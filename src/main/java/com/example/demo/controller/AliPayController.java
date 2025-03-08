package com.example.demo.controller;

import com.alipay.easysdk.factory.Factory;
import com.example.demo.configurer.AliPayConfig;
import com.example.demo.model.Order;
import com.example.demo.model.OrderItem;
import com.example.demo.model.Product;
import com.example.demo.repository.OrderItemRepository;
import com.example.demo.repository.OrderRepository;
import com.example.demo.repository.ProductRepository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradePagePayRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/alipay")
@Transactional(rollbackFor = Exception.class)
public class AliPayController {

    @Resource
    private AliPayConfig aliPayConfig;

    @Resource
    private OrderRepository orderRepository;

    @Resource
    private OrderItemRepository orderItemRepository;

    @Resource
    private ProductRepository productRepository;

    private static final String GATEWAY_URL = "https://openapi-sandbox.dl.alipaydev.com/gateway.do";
    private static final String FORMAT = "JSON";
    private static final String CHARSET = "utf-8";
    private static final String SIGN_TYPE = "RSA2";

    @GetMapping("/pay")
    public void pay(@RequestParam Integer orderId, HttpServletResponse httpResponse) throws Exception {
        // 从数据库获取真实订单数据
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("订单不存在"));

        if (order.getOrderStatus() != 0) {
            throw new RuntimeException("订单状态异常");
        }

        AlipayClient alipayClient = new DefaultAlipayClient(GATEWAY_URL, aliPayConfig.getAppId(),
                aliPayConfig.getAppPrivateKey(), FORMAT, CHARSET, aliPayConfig.getAlipayPublicKey(), SIGN_TYPE);

        AlipayTradePagePayRequest request = new AlipayTradePagePayRequest();
        request.setNotifyUrl(aliPayConfig.getNotifyUrl());
        request.setBizContent("{\"out_trade_no\":\"" + order.getId() + "\","
                + "\"total_amount\":\"" + order.getTotalAmount().setScale(2, BigDecimal.ROUND_HALF_UP) + "\","
                + "\"subject\":\"订单支付-" + order.getId() + "\","
                + "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");

        String form = alipayClient.pageExecute(request).getBody();
        httpResponse.setContentType("text/html;charset=" + CHARSET);
        httpResponse.getWriter().write(form);
        httpResponse.getWriter().flush();
        httpResponse.getWriter().close();
    }

    @PostMapping("/notify")
    public String payNotify(HttpServletRequest request) throws Exception {

        if (request.getParameter("trade_status").equals("TRADE_SUCCESS")) {
            Map<String, String> params = new HashMap<>();
            request.getParameterMap().forEach((key, value) -> params.put(key, value[0]));

            if (Factory.Payment.Common().verifyNotify(params)) {
                String orderId = params.get("out_trade_no");
                BigDecimal amount = new BigDecimal(params.get("total_amount"));

                // 更新订单状态
                Order order = orderRepository.findById(Integer.parseInt(orderId))
                        .orElseThrow(() -> new RuntimeException("订单不存在"));

                if (order.getTotalAmount().compareTo(amount) != 0) {
                    throw new RuntimeException("金额校验失败");
                }

                order.setOrderStatus(1); // 已支付状态
                orderRepository.save(order);
                // 新增：更新商品评分
                updateProductRates(order.getId());
            }
        }
        return "success";
    }

    // 新增方法：更新商品评分
    private void updateProductRates(Integer orderId) {
        List<OrderItem> orderItems = orderItemRepository.findByOrderId(orderId);

        orderItems.forEach(item -> {
            Product product = productRepository.getProductById(item.getProductId());
            // 处理null值：如果rate为null则设为1，否则加1
            product.setRate(product.getRate() != null ? product.getRate() + 1 : 1);
            productRepository.updateProduct(product);
        });
    }
}

package com.example.demo.controller;

import com.alibaba.dashscope.app.Application;
import com.alibaba.dashscope.app.ApplicationParam;
import com.alibaba.dashscope.app.ApplicationResult;
import com.alibaba.dashscope.exception.InputRequiredException;
import com.alibaba.dashscope.exception.NoApiKeyException;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import io.reactivex.Flowable;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyEmitter;

import java.nio.charset.StandardCharsets;
import java.util.concurrent.*;
import java.util.concurrent.atomic.AtomicInteger;

@RestController
@RequestMapping("/api/orders")
public class ChatbotController {
    /**
     * 创建线程池
     **/
    ThreadPoolExecutor executor = new ThreadPoolExecutor(2, 4, 60, TimeUnit.SECONDS,
            new LinkedBlockingQueue<>(10),
            Executors.defaultThreadFactory(),
            new ThreadPoolExecutor.DiscardPolicy()
    );

    /**
     * 实现 chat 接口，支持流式返回数据
     *
     * @param query
     * @return
     */
//    @RequestMapping(value = "/chat", method = RequestMethod.POST)
    @PostMapping("/chat")
    public ResponseBodyEmitter streamData(@RequestBody String query) {
        ResponseBodyEmitter emitter = new ResponseBodyEmitter(180000L);
        executor.execute(() -> {
            try {
                JsonObject jsonObject = JsonParser.parseString(query).getAsJsonObject();
                streamCall(emitter, jsonObject.get("prompt").getAsString());
            } catch (Exception e) {
                e.printStackTrace();
                emitter.completeWithError(e);
            }
        });
        return emitter;
    }

    /**
     * 调用百炼应用，封装流式返回数据
     * 返回数据格式
     * id:1
     * event:result
     * :HTTP_STATUS/200
     * data:{"output":{"session_id":"xxx","finish_reason":"null","text":"相关的问题"}}
     *
     * @param emitter
     * @param query
     * @throws Exception
     */
    public void streamCall(ResponseBodyEmitter emitter, String query) throws Exception {
        // appId 填入百炼应用 ID
        ApplicationParam param = ApplicationParam.builder()
                .appId("your_id")
                .apiKey("your_key")
                .prompt(query)
                .incrementalOutput(true)
                .build();

        Application application = new Application();
        Flowable<ApplicationResult> result = application.streamCall(param);
        AtomicInteger counter = new AtomicInteger(0);
        result.blockingForEach(data -> {
            int newValue = counter.incrementAndGet();
            String resData = "id:" + newValue + "\nevent:result\n:HTTP_STATUS/200\ndata:" + new Gson().toJson(data) + "\n\n";
            emitter.send(resData.getBytes(StandardCharsets.UTF_8));

            if ("stop".equals(data.getOutput().getFinishReason())) {
                emitter.complete();
            }
        });

    }
}
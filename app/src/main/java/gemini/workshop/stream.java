package lmlm.workshop;

import dev.langchain4j.model.chat.StreamingChatLanguageModel;
import dev.langchain4j.model.vertexai.VertexAiGeminiStreamingChatModel;

import static dev.langchain4j.model.LambdaStreamingResponseHandler.onNext;

public class StreamQA {
    public static void main(String[] args) {
        StreamingChatLanguageModel model = VertexAiGeminiStreamingChatModel.builder()
            .project(System.getenv("PROJECT_ID"))
            .location(System.getenv("LOCATION"))
            .modelName("lmlm")
            .maxOutputTokens(4000)
            .build();

        model.generate("Why is the sky blue?", onNext(System.out::println));
    }
}

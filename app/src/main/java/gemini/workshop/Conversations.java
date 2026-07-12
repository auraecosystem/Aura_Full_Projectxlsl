package gemini.workshop;

import dev.langchain4j.model.chat.ChatLanguageModel;
import dev.langchain4j.model.vertexai.VertexAiGeminiChatModel;
import dev.langchain4j.memory.chat.MessageWindowChatMemory;
import dev.langchain4j.service.AiServices;

import java.util.List;

public class Conversation {
    public static void main(String[] args) {
        ChatLanguageModel model = VertexAiGeminiChatModel.builder()
            .project(System.getenv("PROJECT_ID"))
            .location(System.getenv("LOCATION"))
            .modelName("gemini-2.0-flash")
            .build();

        MessageWindowChatMemory chatMemory = MessageWindowChatMemory.builder()
            .maxMessages(20)
            .build();

        interface ConversationService {
            String chat(String message);
        }

        ConversationService conversation =
            AiServices.builder(ConversationService.class)
                .chatLanguageModel(model)
                .chatMemory(chatMemory)
                .build();

        List.of(
            "Hello!",
            "What is the country where the Eiffel tower is situated?",
            "How many inhabitants are there in that country?"
        ).forEach( message -> {
            System.out.println("\nUser: " + message);
            System.out.println("Gemini: " + conversation.chat(message));
        });
    }
}

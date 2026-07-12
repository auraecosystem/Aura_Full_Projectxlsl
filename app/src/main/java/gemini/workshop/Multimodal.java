package gemini.workshop;

import dev.langchain4j.model.chat.ChatLanguageModel;
import dev.langchain4j.model.vertexai.VertexAiGeminiChatModel;
import dev.langchain4j.data.message.UserMessage;
import dev.langchain4j.data.message.AiMessage;
import dev.langchain4j.model.output.Response;
import dev.langchain4j.data.message.ImageContent;
import dev.langchain4j.data.message.TextContent;

public class Multimodal {

    static final String CAT_IMAGE_URL =
        "https://upload.wikimedia.org/wikipedia/" +
        "commons/b/b6/Felis_catus-cat_on_snow.jpg";


    public static void main(String[] args) {
        ChatLanguageModel model = VertexAiGeminiChatModel.builder()
            .project(System.getenv("PROJECT_ID"))
            .location(System.getenv("LOCATION"))
            .modelName("gemini-2.0-flash")
            .build();

        UserMessage userMessage = UserMessage.from(
            ImageContent.from(CAT_IMAGE_URL),
            TextContent.from("Describe the picture")
        );

        Response<AiMessage> response = model.generate(userMessage);

        System.out.println(response.content().text());
    }
}

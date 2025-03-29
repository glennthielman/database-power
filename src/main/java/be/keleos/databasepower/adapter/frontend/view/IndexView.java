package be.keleos.databasepower.adapter.frontend.view;

import be.keleos.databasepower.adapter.frontend.repository.RecentPostRepository;
import be.keleos.databasepower.adapter.frontend.repository.TopLikedCommentRepository;
import be.keleos.databasepower.adapter.frontend.repository.TopLikedPostRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.util.ResourceUtils;

import java.io.IOException;
import java.nio.file.Files;

@RequiredArgsConstructor
@Component
public class IndexView {

    private final RecentPostRepository recentPostRepository;
    private final TopLikedPostRepository topLikedPostRepository;
    private final TopLikedCommentRepository topLikedCommentRepository;

    private static final String BASE_PATH = "web/index.html";
    private static final String RECENT_COMMENT_COMPONENT_PATH = "web/components/recentCommentComponent.html";
    private static final String MAIN_POST_COMPONENT_PATH = "web/components/mainPostBanner.html";
    private static final String FEATURE_POST_COMPONENT_PATH = "web/components/featurePostBanner.html";

    public String getHTML() throws IOException {
        var file = ResourceUtils.getFile("classpath:" + BASE_PATH);
        var html = new String (Files.readAllBytes(file.toPath()));
        return html
                .replace("${recent-comments}", recentCommentComponent())
                .replace("${top-liked-blogs}", topLikedPostComponent())
                .replace("${main-post-banner}", mainPostBanner())
                .replace("${feature-post-banner}", featuredPostBanner());
    }

    private String recentCommentComponent() throws IOException {
        var file = ResourceUtils.getFile("classpath:" + RECENT_COMMENT_COMPONENT_PATH);
        var component = new String (Files.readAllBytes(file.toPath()));
        var comments = topLikedCommentRepository.findAll();

        var commentHtml = "";
        for(var comment : comments) {
            commentHtml += component
                    .replace("${comment}", comment.getComment())
                    .replace("${firstname}", comment.getFirstname());
        }
        return commentHtml;
    }

    private String topLikedPostComponent() throws IOException {
        var posts = topLikedPostRepository.findAll();
        var html = "";
        for(var post : posts) {
            html += "<li><a href=\"#!\">" + post.getTitle() + "</a></li>";
        }
        return html;
    }

    private String mainPostBanner() throws IOException {
        var posts = recentPostRepository.findAll().getFirst();
        var file = ResourceUtils.getFile("classpath:" + MAIN_POST_COMPONENT_PATH);
        var html = new String (Files.readAllBytes(file.toPath()));

        return html
                .replace("${createdAt}", posts.getCreatedAt().toString())
                .replace("${title}", posts.getTitle())
                .replace("${summary}", posts.getSummary());
    }

    private String featuredPostBanner() throws IOException {
        var posts = recentPostRepository.findAll();
        var file = ResourceUtils.getFile("classpath:" + FEATURE_POST_COMPONENT_PATH);
        var component = new String (Files.readAllBytes(file.toPath()));

        var html = "<div class=\"col-lg-6\">";
        for(int i = 1; i < 3; i++) {
            var post = posts.get(i);
            html += component
                    .replace("${createdAt}", post.getCreatedAt().toString())
                    .replace("${title}", post.getTitle())
                    .replace("${summary}", post.getSummary());
        }
        html += "</div>";
        html += "<div class=\"col-lg-6\">";
        for(int i = 3; i < 5; i++) {
            var post = posts.get(i);
            html += component
                    .replace("${createdAt}", post.getCreatedAt().toString())
                    .replace("${title}", post.getTitle())
                    .replace("${summary}", post.getSummary());
        }
        html += "</div>";
        return html;
    }
}

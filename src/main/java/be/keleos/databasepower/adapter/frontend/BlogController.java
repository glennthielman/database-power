package be.keleos.databasepower.adapter.frontend;

import be.keleos.databasepower.adapter.frontend.repository.HtmlViewRepository;
import be.keleos.databasepower.adapter.frontend.repository.RecentPostRepository;
import be.keleos.databasepower.adapter.frontend.repository.TopLikedCommentRepository;
import be.keleos.databasepower.adapter.frontend.repository.TopLikedPostRepository;
import be.keleos.databasepower.adapter.frontend.view.IndexView;
import be.keleos.databasepower.core.repository.CommentRepository;
import be.keleos.databasepower.core.repository.PostRepository;
import be.keleos.databasepower.adapter.frontend.out.OutComment;
import be.keleos.databasepower.adapter.frontend.out.OutPost;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

@RequiredArgsConstructor
@RestController
public class BlogController {

    private final PostRepository postRepository;
    private final CommentRepository commentRepository;
    private final RecentPostRepository recentPostRepository;
    private final TopLikedPostRepository topLikedPostRepository;
    private final TopLikedCommentRepository topLikedCommentRepository;
    private final IndexView indexView;
    private final HtmlViewRepository htmlViewRepository;

    @GetMapping("/v1/posts")
    public List<OutPost> getPosts() {
        return postRepository.findAll()
                .stream()
                .map(OutPost::fromPostEntity)
                .toList();
    }

    @GetMapping("/v1/posts/recent")
    public List<OutPost> getRecentPosts() {
        return recentPostRepository.findAll()
                .stream()
                .map(OutPost::fromRecentPostEntity)
                .toList();
    }

    @GetMapping("/v1/posts/top/liked")
    public List<OutPost> getPostsTopLiked() {
        return topLikedPostRepository.findAll()
                .stream()
                .map(OutPost::fromTopLikedEntity)
                .toList();
    }

    @GetMapping("/v1/comments/top/liked")
    public List<OutComment> getCommentsTopLiked() {
        return topLikedCommentRepository.findAll()
                .stream()
                .map(OutComment::fromTopLikedComment)
                .toList();
    }


    @GetMapping(value = "/index", produces = MediaType.TEXT_HTML_VALUE)
    @ResponseBody
    public String index() throws IOException {
        return htmlViewRepository.findById("index").get().getValue();
    }

    @GetMapping(value = "/css/style.css", produces = "text/css")
    @ResponseBody
    public String getCss() throws IOException {
        var file = ResourceUtils.getFile("classpath:web/css/styles.css");
        return new String (Files.readAllBytes(file.toPath()));
    }

    @GetMapping(value = "/js/scripts.js", produces = "text/javascript")
    @ResponseBody
    public String getJs() throws IOException {
        var file = ResourceUtils.getFile("classpath:web/js/scripts.js");
        return new String (Files.readAllBytes(file.toPath()));
    }
}

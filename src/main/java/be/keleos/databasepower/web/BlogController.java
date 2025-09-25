package be.keleos.databasepower.web;

import be.keleos.databasepower.repository.CommentRepository;
import be.keleos.databasepower.repository.PostRepository;
import be.keleos.databasepower.web.out.OutComment;
import be.keleos.databasepower.web.out.OutPost;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
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

    @GetMapping("/v1/posts")
    public List<OutPost> getPosts() {
        return postRepository.findAll()
                .stream()
                .map(OutPost::fromPostEntity)
                .toList();
    }

    @GetMapping("/v1/posts/recent")
    public List<OutPost> getRecentPosts() {
        return postRepository.findRecentPosts(PageRequest.of(0,5))
                .stream()
                .map(OutPost::fromPostEntity)
                .toList();
    }

    @GetMapping("/v1/posts/top/liked")
    public List<OutPost> getPostsTopLiked() {
        return postRepository.findTop10Liked(PageRequest.of(0,10))
                .stream()
                .map(OutPost::fromPostEntity)
                .toList();

    }

    @GetMapping("/v1/comments/top/liked")
    public List<OutComment> getCommentsTopLiked() {
        return commentRepository.findTop10Comments(PageRequest.of(0,10))
                .stream()
                .map(OutComment::fromCommentEntity)
                .toList();

    }


    @GetMapping(value = "/index", produces = MediaType.TEXT_HTML_VALUE)
    @ResponseBody
    public String index() throws IOException {
        var file = ResourceUtils.getFile("classpath:web/index.html");
        return new String (Files.readAllBytes(file.toPath()));
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

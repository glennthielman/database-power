package be.keleos.databasepower.web;

import be.keleos.databasepower.repository.PostRepository;
import be.keleos.databasepower.web.out.OutPost;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequiredArgsConstructor
@RestController
public class BlogController {

    private final PostRepository postRepository;

    @GetMapping("/v1/posts")
    public List<OutPost> getPosts() {
        return postRepository.findAll()
                .stream()
                .map(OutPost::fromPostEntity)
                .toList();
    }
}

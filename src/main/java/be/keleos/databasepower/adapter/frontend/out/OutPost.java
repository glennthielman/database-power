package be.keleos.databasepower.adapter.frontend.out;

import be.keleos.databasepower.core.repository.entity.PostEntity;
import be.keleos.databasepower.adapter.frontend.repository.entity.RecentPostEntity;
import be.keleos.databasepower.adapter.frontend.repository.entity.TopLikedPostEntity;
import lombok.*;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;
import java.util.List;

@Accessors(chain = true)
@Getter
@Setter
public class OutPost {
    private String id;
    private String title;
    private String summary;
    private String body;
    private OutUser user;
    private LocalDateTime createdAt;
    private List<OutComment> comments;
    private List<OutLike> likes;

    public static OutPost fromPostEntity(PostEntity postEntity) {
        return new OutPost()
                .setId(postEntity.getId().toString())
                .setTitle(postEntity.getTitle())
                .setSummary(postEntity.getSummary())
                .setBody(postEntity.getBody())
                .setUser(OutUser.fromEntity(postEntity.getUser()))
                .setCreatedAt(postEntity.getCreatedAt())
                .setComments(postEntity.getComments()
                        .stream()
                        .map(OutComment::fromCommentEntity)
                        .toList()
                )
                .setLikes(postEntity.getLikes()
                        .stream()
                        .map(OutLike::fromEntity)
                        .toList());
    }

    public static OutPost fromRecentPostEntity(RecentPostEntity postEntity) {
        return new OutPost()
                .setId(postEntity.getId().toString())
                .setTitle(postEntity.getTitle())
                .setSummary(postEntity.getSummary())
                .setCreatedAt(postEntity.getCreatedAt());
    }

    public static OutPost fromTopLikedEntity(TopLikedPostEntity postEntity) {
        return new OutPost()
                .setId(postEntity.getId().toString())
                .setTitle(postEntity.getTitle());
    }
}

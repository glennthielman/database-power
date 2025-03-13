package be.keleos.databasepower.adapter.frontend.out;

import be.keleos.databasepower.core.repository.entity.CommentEntity;
import be.keleos.databasepower.adapter.frontend.repository.entity.TopLikedCommentEntity;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.util.List;
import java.util.UUID;

@Accessors(chain = true)
@Getter
@Setter
public class OutComment {

    private UUID id;
    private String comment;
    private OutUser user;
    private List<OutLike> likes;

    public static OutComment fromCommentEntity(CommentEntity comment) {
        return new OutComment()
                .setId(comment.getId())
                .setComment(comment.getComment())
                .setUser(OutUser.fromEntity(comment.getUser()))
                .setLikes(comment.getLikes()
                        .stream()
                        .map(OutLike::fromEntity)
                        .toList());
    }

    public static OutComment fromTopLikedComment(TopLikedCommentEntity comment) {
        return new OutComment()
                .setId(comment.getId())
                .setComment(comment.getComment())
                .setUser(new OutUser()
                        .setFirstname(comment.getFirstname())
                );
    }
}

package be.keleos.databasepower.web.out;

import be.keleos.databasepower.repository.entity.CommentEntity;
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
}

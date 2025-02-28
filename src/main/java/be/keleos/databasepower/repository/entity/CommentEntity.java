package be.keleos.databasepower.repository.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "blog_comment")
@Data
public class CommentEntity {

    @Id
    private UUID id;
    private String comment;

    @OneToOne
    @JoinColumn(name = "author_id", referencedColumnName = "id")
    private UserEntity user;

    @ManyToOne
    @JoinColumn(name = "parent_id")
    private PostEntity post;

    @OneToMany(mappedBy = "comment")
    private List<CommentLikeEntity> likes;
}

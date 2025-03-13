package be.keleos.databasepower.core.repository.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "blog_post")
@Data
public class PostEntity {

    @Id
    private UUID id;
    private String title;
    private String summary;
    private String body;
    @Column(name = "created_on")
    private LocalDateTime createdAt;

    @OneToOne
    @JoinColumn(name = "author_id", referencedColumnName = "id")
    private UserEntity user;

    @OneToMany(mappedBy = "post")
    private List<CommentEntity> comments;

    @OneToMany(mappedBy = "post")
    private List<PostLikeEntity> likes;
}

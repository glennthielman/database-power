package be.keleos.databasepower.repository.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.UUID;

@Entity
@Table(name = "blog_likes")
@Data
public class LikeEntity {

    @Id
    private UUID id;
    @OneToOne
    @JoinColumn(name = "author_id", referencedColumnName = "id")
    private UserEntity user;
    @ManyToOne
    @JoinColumn(name = "parent_id")
    private PostEntity post;
}

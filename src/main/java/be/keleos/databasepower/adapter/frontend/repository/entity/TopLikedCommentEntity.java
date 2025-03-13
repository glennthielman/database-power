package be.keleos.databasepower.adapter.frontend.repository.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

import java.util.UUID;

@Entity
@Table(name = "vw_top_liked_comments")
@Data
public class TopLikedCommentEntity {

    @Id
    private UUID id;
    @Column(name = "parent_id")
    private UUID postId;
    private String comment;
    private String firstname;
}

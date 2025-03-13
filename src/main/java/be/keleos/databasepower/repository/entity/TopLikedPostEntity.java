package be.keleos.databasepower.repository.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

import java.util.UUID;

@Entity
@Table(name = "vw_top_liked_posts")
@Data
public class TopLikedPostEntity {

    @Id
    private UUID id;
    private String title;
}

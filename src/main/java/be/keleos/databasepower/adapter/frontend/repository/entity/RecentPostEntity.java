package be.keleos.databasepower.adapter.frontend.repository.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "vw_recent_posts")
@Data
public class RecentPostEntity {
    @Id
    private UUID id;
    private String title;
    private String summary;
    @Column(name = "created_on")
    private LocalDateTime createdAt;
}

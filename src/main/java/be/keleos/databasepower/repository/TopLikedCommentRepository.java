package be.keleos.databasepower.repository;

import be.keleos.databasepower.repository.entity.TopLikedCommentEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface TopLikedCommentRepository extends JpaRepository<TopLikedCommentEntity, UUID> {
}

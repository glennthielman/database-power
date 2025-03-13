package be.keleos.databasepower.adapter.frontend.repository;

import be.keleos.databasepower.adapter.frontend.repository.entity.TopLikedCommentEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface TopLikedCommentRepository extends JpaRepository<TopLikedCommentEntity, UUID> {
}

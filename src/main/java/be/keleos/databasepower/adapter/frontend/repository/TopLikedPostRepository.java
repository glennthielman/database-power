package be.keleos.databasepower.adapter.frontend.repository;

import be.keleos.databasepower.adapter.frontend.repository.entity.TopLikedPostEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface TopLikedPostRepository extends JpaRepository<TopLikedPostEntity, UUID> {
}

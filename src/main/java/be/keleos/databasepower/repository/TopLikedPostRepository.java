package be.keleos.databasepower.repository;

import be.keleos.databasepower.repository.entity.TopLikedPostEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface TopLikedPostRepository extends JpaRepository<TopLikedPostEntity, UUID> {
}

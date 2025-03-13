package be.keleos.databasepower.repository;

import be.keleos.databasepower.repository.entity.RecentPostEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface RecentPostRepository extends JpaRepository<RecentPostEntity, UUID> {
}

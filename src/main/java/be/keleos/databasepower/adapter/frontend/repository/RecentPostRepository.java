package be.keleos.databasepower.adapter.frontend.repository;

import be.keleos.databasepower.adapter.frontend.repository.entity.RecentPostEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface RecentPostRepository extends JpaRepository<RecentPostEntity, UUID> {
}

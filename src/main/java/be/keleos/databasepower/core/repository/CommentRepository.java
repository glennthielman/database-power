package be.keleos.databasepower.core.repository;

import be.keleos.databasepower.core.repository.entity.CommentEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface CommentRepository extends JpaRepository<CommentEntity, UUID> {

}

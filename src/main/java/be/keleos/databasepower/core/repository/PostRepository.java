package be.keleos.databasepower.core.repository;

import be.keleos.databasepower.core.repository.entity.PostEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

public interface PostRepository extends JpaRepository<PostEntity, UUID> {

    Optional<PostEntity> findById(UUID id);

}

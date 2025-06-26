package be.keleos.databasepower.repository;

import be.keleos.databasepower.repository.entity.PostEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface PostRepository extends JpaRepository<PostEntity, UUID> {

    Optional<PostEntity> findById(UUID id);

    @Query(value = "select p from PostEntity p where p.id IN " +
            "(select l.post.id from PostLikeEntity l group by l.post.id order by count(*) DESC)")
    List<PostEntity> findTop10Liked(Pageable pageable);

    @Query(value = "select p from PostEntity p order by p.createdAt desc")
    List<PostEntity> findRecentPosts(Pageable pageable);

}

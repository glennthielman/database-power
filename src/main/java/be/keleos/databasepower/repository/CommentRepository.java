package be.keleos.databasepower.repository;

import be.keleos.databasepower.repository.entity.CommentEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.UUID;

public interface CommentRepository extends JpaRepository<CommentEntity, UUID> {

    @Query(value = "select c from CommentEntity c where c.id IN " +
            "(select l.comment.id from CommentLikeEntity l group by l.comment.id order by count(*) DESC)")
    List<CommentEntity> findTop10Comments(Pageable pageable);

}

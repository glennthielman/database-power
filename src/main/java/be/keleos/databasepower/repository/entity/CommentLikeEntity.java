package be.keleos.databasepower.repository.entity;

import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Filter;
import org.hibernate.annotations.FilterDef;

import java.util.UUID;

@Entity
@Table(name = "blog_likes")
@FilterDef(name = "isComment")
@Filter(name = "isComment", condition="type = 'comment'")
public class CommentLikeEntity extends LikeEntity{

    @ManyToOne
    @JoinColumn(name = "parent_id")
    private CommentEntity comment;
}

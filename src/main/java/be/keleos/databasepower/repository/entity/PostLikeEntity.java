package be.keleos.databasepower.repository.entity;

import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.Filter;
import org.hibernate.annotations.FilterDef;

import java.util.UUID;

@Entity
@Table(name = "blog_likes")
@FilterDef(name = "isPost")
@Filter(name = "isPost", condition="type = 'post'")
public class PostLikeEntity extends LikeEntity{

    @ManyToOne
    @JoinColumn(name = "parent_id")
    private PostEntity post;
}

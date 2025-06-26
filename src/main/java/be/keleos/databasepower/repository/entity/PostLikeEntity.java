package be.keleos.databasepower.repository.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import org.hibernate.annotations.Filter;
import org.hibernate.annotations.FilterDef;

@Entity
@Table(name = "blog_likes")
@FilterDef(name = "isPost")
@Filter(name = "isPost", condition="type = 'post'")
public class PostLikeEntity extends LikeEntity{

    @ManyToOne
    @JoinColumn(name = "parent_id")
    private PostEntity post;
}

package be.keleos.databasepower.adapter.frontend.repository.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.experimental.Accessors;

@Accessors(chain = true)
@Entity
@Table(name = "blog_html_views")
@Data
public class HtmlViewEntity {
    @Id
    private String key;
    private String value;
}

package be.keleos.databasepower.core.repository.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.UUID;

@Data
@MappedSuperclass
public class LikeEntity {

    @Id
    private UUID id;
    @OneToOne
    @JoinColumn(name = "author_id", referencedColumnName = "id")
    private UserEntity user;
    @Column(name = "parent_type")
    private String type;

}

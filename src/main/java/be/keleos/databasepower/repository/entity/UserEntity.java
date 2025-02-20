package be.keleos.databasepower.repository.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

import java.util.UUID;

@Entity
@Table(name = "blog_user")
@Data
public class UserEntity {

    @Id
    private UUID id;
    private String email;
    private String firstname;
    private String lastname;
}

package be.keleos.databasepower.adapter.frontend.out;

import be.keleos.databasepower.core.repository.entity.UserEntity;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.util.UUID;

@Accessors(chain = true)
@Getter
@Setter
public class OutUser {

    private UUID id;
    private String email;
    private String firstname;
    private String lastname;

    public static OutUser fromEntity(UserEntity user) {
        return new OutUser()
                .setId(user.getId())
                .setEmail(user.getEmail())
                .setFirstname(user.getFirstname())
                .setLastname(user.getLastname());
    }

}

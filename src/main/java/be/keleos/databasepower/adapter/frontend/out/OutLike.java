package be.keleos.databasepower.adapter.frontend.out;

import be.keleos.databasepower.core.repository.entity.LikeEntity;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.util.UUID;

@Accessors(chain = true)
@Getter
@Setter
public class OutLike {

    private UUID id;
    private OutUser user;

    public static OutLike fromEntity(LikeEntity entity) {
        return new OutLike()
                .setId(entity.getId())
                .setUser(OutUser.fromEntity(entity.getUser()));
    }
}

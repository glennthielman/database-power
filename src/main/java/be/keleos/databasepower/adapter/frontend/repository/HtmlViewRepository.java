package be.keleos.databasepower.adapter.frontend.repository;

import be.keleos.databasepower.adapter.frontend.repository.entity.HtmlViewEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface HtmlViewRepository extends JpaRepository<HtmlViewEntity, String> {

}

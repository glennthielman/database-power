package be.keleos.databasepower.adapter.frontend.service;

import be.keleos.databasepower.adapter.frontend.repository.HtmlViewRepository;
import be.keleos.databasepower.adapter.frontend.repository.entity.HtmlViewEntity;
import be.keleos.databasepower.adapter.frontend.view.IndexView;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.io.IOException;

@Service
@RequiredArgsConstructor
public class HtmlViewService {

    private final IndexView indexView;
    private final HtmlViewRepository htmlViewRepository;

    @Scheduled(fixedRate = 10000)
    public void renderIndexPage() throws IOException {
        System.out.println("Rendering index page");
        var indexPage = indexView.getHTML();
        var entity = new HtmlViewEntity()
                .setKey("index")
                .setValue(indexPage);
        htmlViewRepository.save(entity);
    }
}

package be.keleos.databasepower.adapter.frontend.service;

import be.keleos.databasepower.adapter.frontend.repository.HtmlViewRepository;
import be.keleos.databasepower.adapter.frontend.repository.entity.HtmlViewEntity;
import be.keleos.databasepower.adapter.frontend.view.IndexView;
import lombok.RequiredArgsConstructor;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.io.IOException;

@Service
@RequiredArgsConstructor
public class HtmlViewService {

    private final IndexView indexView;
    private final HtmlViewRepository htmlViewRepository;

    @CacheEvict(value="indexPage", allEntries=true)
    @Scheduled(fixedRate = 20000)
    public void RenderIndexPage() throws IOException {
        System.out.println("Rendering index page");
        var indexPage = indexView.getHTML();
        var entity = new HtmlViewEntity()
                .setKey("index")
                .setValue(indexPage);
        htmlViewRepository.save(entity);
    }

    @Cacheable("indexPage")
    public String getIndexPage() {
        return htmlViewRepository.findById("index").get().getValue();

    }
}

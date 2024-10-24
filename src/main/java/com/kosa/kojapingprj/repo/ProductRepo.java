    package com.kosa.kojapingprj.repo;

    import com.kosa.kojaping.entity.Accommodation;
    import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;
    import org.springframework.data.elasticsearch.repository.config.EnableElasticsearchRepositories;

    import java.util.List;

    @EnableElasticsearchRepositories
    public interface ProductRepo extends ElasticsearchRepository<Accommodation, String> {
        // 위치로 검색 (숫자형태이기 때문에 변환이 필요함)
        List<Accommodation> findByLocationNo(int locationNo);
    }
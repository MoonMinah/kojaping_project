package com.kosa.kojapingprj.service.serviceImpl;

import com.kosa.kojaping.entity.Accommodation;
import com.kosa.kojaping.mapper.ProductMapper;
import com.kosa.kojaping.repo.ProductRepo;
import com.kosa.kojaping.service.ProductService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductMapper productMapper; // MyBatis

    @Autowired
    private ProductRepo productRepo; // Elasticsearch


    // Accommodation 으로 변수명을 하자고 하려니까 Host Reservation 이랑 겹칠 것 같아서
    // 예시로 준 파일과 동일하게 Product 로 진행함
    @Override
    public void syncMySQLToElasticsearch() {
        try {
            List<Accommodation> products = getAllProductsFromMySQL();

            // Elasticsearch의 모든 Accommodation의 ID를 가져오기.
            List<Accommodation> productList = new ArrayList<>();
            productRepo.findAll().forEach(productList::add);

            //숙소 리스트 ID 생성
            List<String> esProductIds = productList.stream()
                    .map(Accommodation::getAccommodationNo)
                    .collect(Collectors.toList());

            // MySQL에서 가져온 제품들을 Elasticsearch에 동기화
            for (Accommodation product : products) {
                //없으면 새로운 숙소로 삽입
                if (!esProductIds.contains(product.getAccommodationNo())) {
                    log.info("Inserting product to Elasticsearch: {}", product);
                    insertProductToElasticsearch(product);
                } else { //이미 존재한다면 비교를 통해 다르면 Update
                    Accommodation esProduct = findProductInElasticsearchByAccommodationNo(product.getAccommodationNo());
                    if (!product.equals(esProduct)) {
                        log.info("Updating product in Elasticsearch: {}", product);
                        updateProductInElasticsearch(product);
                    }
                }
            }

            // Elasticsearch에서 삭제된 데이터 삭제
            esProductIds.forEach(accommodationNo -> {
                if (products.stream().noneMatch(p -> p.getAccommodationNo().equals(accommodationNo))) {
                    log.info("Deleting product from Elasticsearch: accommodationNo {}", accommodationNo);
                    productRepo.deleteById(accommodationNo);
                }
            });
        } catch (Exception e) {
            log.error("syncMySQLToElasticsearch() 도중 에러 발생", e);
        }
    }

    // Elasticsearch에 제품 갱신
    @Override
    public void updateProductInElasticsearch(Accommodation product) {
        productRepo.save(product);
    }


    // Elasticsearch에서 제품 검색
    @Override
    public Accommodation findProductInElasticsearchByAccommodationNo(String accommodationNo) {
        return productRepo.findById(accommodationNo).orElse(null);
    }

    // Elasticsearch에 제품 삽입
    @Override
    public void insertProductToElasticsearch(Accommodation product) {
        productRepo.save(product);
    }

    @Override
    public List<Accommodation> getAllProductsFromMySQL() {
        return productMapper.findAllProducts(); // 전체 제품 목록을 가져오는 메서드 호출
    }

    @Override
    public void deleteProduct(String accommodationNo) {
        productMapper.deleteProductByaccommodationNo(accommodationNo); // MySQL에서 삭제
        productRepo.deleteById(accommodationNo); // Elasticsearch에서 삭제
    }
}

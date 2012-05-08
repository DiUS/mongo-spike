package au.com.dius.spike.nosql.repository;

import au.com.dius.spike.nosql.domain.Order;
import java.util.List;
import org.springframework.roo.addon.layers.repository.mongo.RooMongoRepository;

@RooMongoRepository(domainType = Order.class)
public interface OrderRepository {

    List<au.com.dius.spike.nosql.domain.Order> findAll();
}

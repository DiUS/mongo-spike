// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package au.com.dius.spike.nosql.domain;

import au.com.dius.spike.nosql.domain.OrderDataOnDemand;
import au.com.dius.spike.nosql.domain.OrderIntegrationTest;
import au.com.dius.spike.nosql.repository.OrderRepository;
import java.math.BigInteger;
import java.util.List;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

privileged aspect OrderIntegrationTest_Roo_IntegrationTest {
    
    declare @type: OrderIntegrationTest: @RunWith(SpringJUnit4ClassRunner.class);
    
    declare @type: OrderIntegrationTest: @ContextConfiguration(locations = "classpath:/META-INF/spring/applicationContext*.xml");
    
    @Autowired
    private OrderDataOnDemand OrderIntegrationTest.dod;
    
    @Autowired
    OrderRepository OrderIntegrationTest.orderRepository;
    
    @Test
    public void OrderIntegrationTest.testCount() {
        Assert.assertNotNull("Data on demand for 'Order' failed to initialize correctly", dod.getRandomOrder());
        long count = orderRepository.count();
        Assert.assertTrue("Counter for 'Order' incorrectly reported there were no entries", count > 0);
    }
    
    @Test
    public void OrderIntegrationTest.testFind() {
        Order obj = dod.getRandomOrder();
        Assert.assertNotNull("Data on demand for 'Order' failed to initialize correctly", obj);
        BigInteger id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Order' failed to provide an identifier", id);
        obj = orderRepository.findOne(id);
        Assert.assertNotNull("Find method for 'Order' illegally returned null for id '" + id + "'", obj);
        Assert.assertEquals("Find method for 'Order' returned the incorrect identifier", id, obj.getId());
    }
    
    @Test
    public void OrderIntegrationTest.testFindAll() {
        Assert.assertNotNull("Data on demand for 'Order' failed to initialize correctly", dod.getRandomOrder());
        long count = orderRepository.count();
        Assert.assertTrue("Too expensive to perform a find all test for 'Order', as there are " + count + " entries; set the findAllMaximum to exceed this value or set findAll=false on the integration test annotation to disable the test", count < 250);
        List<Order> result = orderRepository.findAll();
        Assert.assertNotNull("Find all method for 'Order' illegally returned null", result);
        Assert.assertTrue("Find all method for 'Order' failed to return any data", result.size() > 0);
    }
    
    @Test
    public void OrderIntegrationTest.testFindEntries() {
        Assert.assertNotNull("Data on demand for 'Order' failed to initialize correctly", dod.getRandomOrder());
        long count = orderRepository.count();
        if (count > 20) count = 20;
        int firstResult = 0;
        int maxResults = (int) count;
        List<Order> result = orderRepository.findAll(new org.springframework.data.domain.PageRequest(firstResult / maxResults, maxResults)).getContent();
        Assert.assertNotNull("Find entries method for 'Order' illegally returned null", result);
        Assert.assertEquals("Find entries method for 'Order' returned an incorrect number of entries", count, result.size());
    }
    
    @Test
    public void OrderIntegrationTest.testSave() {
        Assert.assertNotNull("Data on demand for 'Order' failed to initialize correctly", dod.getRandomOrder());
        Order obj = dod.getNewTransientOrder(Integer.MAX_VALUE);
        Assert.assertNotNull("Data on demand for 'Order' failed to provide a new transient entity", obj);
        Assert.assertNull("Expected 'Order' identifier to be null", obj.getId());
        orderRepository.save(obj);
        Assert.assertNotNull("Expected 'Order' identifier to no longer be null", obj.getId());
    }
    
    @Test
    public void OrderIntegrationTest.testDelete() {
        Order obj = dod.getRandomOrder();
        Assert.assertNotNull("Data on demand for 'Order' failed to initialize correctly", obj);
        BigInteger id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Order' failed to provide an identifier", id);
        obj = orderRepository.findOne(id);
        orderRepository.delete(obj);
        Assert.assertNull("Failed to remove 'Order' with identifier '" + id + "'", orderRepository.findOne(id));
    }
    
}
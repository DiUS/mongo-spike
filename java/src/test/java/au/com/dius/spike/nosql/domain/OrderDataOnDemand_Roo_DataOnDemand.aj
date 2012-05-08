// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package au.com.dius.spike.nosql.domain;

import au.com.dius.spike.nosql.domain.Order;
import au.com.dius.spike.nosql.domain.OrderDataOnDemand;
import au.com.dius.spike.nosql.repository.OrderRepository;
import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

privileged aspect OrderDataOnDemand_Roo_DataOnDemand {
    
    declare @type: OrderDataOnDemand: @Component;
    
    private Random OrderDataOnDemand.rnd = new SecureRandom();
    
    private List<Order> OrderDataOnDemand.data;
    
    @Autowired
    OrderRepository OrderDataOnDemand.orderRepository;
    
    public Order OrderDataOnDemand.getNewTransientOrder(int index) {
        Order obj = new Order();
        setCustomerName(obj, index);
        setDatePlaced(obj, index);
        return obj;
    }
    
    public void OrderDataOnDemand.setCustomerName(Order obj, int index) {
        String customerName = "customerName_" + index;
        obj.setCustomerName(customerName);
    }
    
    public void OrderDataOnDemand.setDatePlaced(Order obj, int index) {
        Date datePlaced = new GregorianCalendar(Calendar.getInstance().get(Calendar.YEAR), Calendar.getInstance().get(Calendar.MONTH), Calendar.getInstance().get(Calendar.DAY_OF_MONTH), Calendar.getInstance().get(Calendar.HOUR_OF_DAY), Calendar.getInstance().get(Calendar.MINUTE), Calendar.getInstance().get(Calendar.SECOND) + new Double(Math.random() * 1000).intValue()).getTime();
        obj.setDatePlaced(datePlaced);
    }
    
    public Order OrderDataOnDemand.getSpecificOrder(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        Order obj = data.get(index);
        BigInteger id = obj.getId();
        return orderRepository.findOne(id);
    }
    
    public Order OrderDataOnDemand.getRandomOrder() {
        init();
        Order obj = data.get(rnd.nextInt(data.size()));
        BigInteger id = obj.getId();
        return orderRepository.findOne(id);
    }
    
    public boolean OrderDataOnDemand.modifyOrder(Order obj) {
        return false;
    }
    
    public void OrderDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = orderRepository.findAll(new org.springframework.data.domain.PageRequest(from / to, to)).getContent();
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'Order' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<Order>();
        for (int i = 0; i < 10; i++) {
            Order obj = getNewTransientOrder(i);
            try {
                orderRepository.save(obj);
            } catch (ConstraintViolationException e) {
                StringBuilder msg = new StringBuilder();
                for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                    ConstraintViolation<?> cv = iter.next();
                    msg.append("[").append(cv.getConstraintDescriptor()).append(":").append(cv.getMessage()).append("=").append(cv.getInvalidValue()).append("]");
                }
                throw new RuntimeException(msg.toString(), e);
            }
            data.add(obj);
        }
    }
    
}

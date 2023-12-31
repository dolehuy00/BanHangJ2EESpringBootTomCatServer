
package web.Service;

import java.util.List;
import java.util.Optional;
import java.util.Random;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import web.Model.Customer;
import web.Repository.CustomerRepository;

@Service
public class CustomerServiceImpl implements CustomerService{

    @Autowired
    private CustomerRepository cusRepo;
        
    @Override
    public Customer findCustomerByUserName(String username) {
        try{
            Customer customer = cusRepo.findByUserName(username);
            return customer;
        }catch(Exception e){
            return null;
        }
    }

    @Override
    public Customer saveCustomer(Customer customer) {
        return cusRepo.save(customer);
    }
    
    @Override
    public boolean isValidAccount(String username, String password) {
        Customer customer = cusRepo.findByUserName(username);
        return customer != null && customer.getPassword().equals(password);
    }
    
    @Override
    public boolean checkExitsAccoutByEmail(String email){
        Customer customer = cusRepo.findByEmail(email);
        return customer != null;   
    }
    
    @Override
    public Customer findCustomerByEmail(String email){
        return cusRepo.findByEmail(email);   
    }
    
    @Override
    public Customer updateCustomer(Customer customer){
        return cusRepo.save(customer);
    }

    @Override
    public void updateSearchLastest(Integer id, String keyword){
        Customer customer = cusRepo.findById(id).get();
        customer.setSearchLatest(keyword);
        cusRepo.save(customer);
    }
    
    @Override
    public boolean checkExitsAccoutByUsername(String username){
        Customer customer = cusRepo.findByUserName(username);
        return customer != null;
    }

    @Override
    public List<Customer> findAll() {
        return (List<Customer>) cusRepo.findAll();
    }

    @Override
    public void lockById(Integer Id) {
        cusRepo.lockById(Id);
    }

    @Override
    public void unlockById(Integer Id) {
         cusRepo.unlockById(Id);
    }

    @Override
    public Customer findById(Integer customerId) {
        Optional<Customer> customer = cusRepo.findById(customerId);
        if(customer.isPresent()){
            return customer.get();
        }
        return null;
    }

    @Override
    public List<Customer> searchInManage(String keyword) {
        return cusRepo.searchInManage("%"+keyword+"%");
    }
    
}

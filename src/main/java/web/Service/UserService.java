
package web.Service;

import java.util.List;
import org.springframework.stereotype.Service;
import web.Model.User;

@Service
public interface UserService {
    public List<User> findAllUser();
    public User isValidAccount(String username, String password);
    public User findUserByUserName(String username);
    public void lockUserById(Integer userId);
    public List<User> findAllUserExceptAdmin();
    public User findUserById(Integer userID);
    public User saveUser(User user);
    public boolean checkExitsAccoutByUsername(String username);
    public boolean checkExitsAccoutByEmail(String email);
    public boolean checkExitsAccoutByPhoneNumber(String phoneNumber);
    public void unlockUserById(Integer userId);
    public User findByEmail(String email);
    public User findByPhoneNumber(String phoneNumber);
    public List<User> searchInManage(String keyword);
}

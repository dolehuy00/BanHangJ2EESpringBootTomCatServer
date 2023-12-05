
package web.Service;

import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import web.Model.Cartitem;
import web.Model.CartitemPK;
import web.Repository.CartItemRepository;

@Service
public class CartItemServiceImpl implements CartItemService{

    @Autowired CartItemRepository cartItemRepo;
     
    @Override
    public void updateQuantityCartItem(CartitemPK id, Integer quantity) {
        Cartitem cartItem = cartItemRepo.findById(id).get();
        cartItem.setQuantity(quantity);
        cartItemRepo.save(cartItem);
    }

    @Override
    public boolean deleteProductCartItem(CartitemPK id) {
        int result = cartItemRepo.deleteCartItem(id);
        return result==1;
    }

    @Override
    public Cartitem addCartItem(Cartitem cartItem) {
        return cartItemRepo.save(cartItem);
    }
    
    @Override
    public Cartitem getCartItemById(CartitemPK id){
        Optional<Cartitem> optionalItem = cartItemRepo.findById(id);
        if (optionalItem.isPresent()) {
            return optionalItem.get();
        } else {
            return null;
        }
    }
    
}

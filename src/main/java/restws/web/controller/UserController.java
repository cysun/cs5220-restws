package restws.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import restws.model.User;
import restws.model.dao.UserDao;

@Controller
public class UserController {

    @Autowired
    private UserDao userDao;

    @RequestMapping("/users")
    public String users( ModelMap models )
    {
        models.put( "users", userDao.getUsers() );
        return "users";
    }

    @RequestMapping("/editUser")
    public String editUser( @RequestParam Integer id, ModelMap models )
    {
        models.put( "user", userDao.getUser( id ) );
        return "editUser";
    }

    @RequestMapping(value = "/editUser", params = "field")
    @ResponseBody
    public void editUser( @RequestParam Integer id, @RequestParam String field,
        @RequestParam String value )
    {
        User user = userDao.getUser( id );
        switch( field )
        {
            case "firstName":
                user.setFirstName( value );
                break;

            case "lastName":
                user.setLastName( value );
                break;

            case "email":
                user.setEmail( value );
                break;

            case "enabled":
                user.setEnabled( Boolean.parseBoolean( value ) );
                break;
        }
        userDao.saveUser( user );
    }

}

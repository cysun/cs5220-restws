package restws.web.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import restws.model.User;
import restws.model.dao.UserDao;

@Controller
public class UserService {

    @Autowired
    UserDao userDao;

    @RequestMapping(value = "/service/user/{id}.xml",
        method = RequestMethod.GET)
    public String getUserXml( @PathVariable Integer id, ModelMap models )
    {
        models.put( "user", userDao.getUser( id ) );
        return "user.xml";
    }

    @RequestMapping(value = "/service/user/{id}.json",
        method = RequestMethod.GET)
    public String getUserJson( @PathVariable Integer id, ModelMap models )
    {
        models.put( "user", userDao.getUser( id ) );
        return "user.json";
    }

    @RequestMapping(value = "/service/users", method = RequestMethod.GET)
    @ResponseBody
    public List<User> getUsers()
    {
        return userDao.getUsers();
    }

    @RequestMapping(value = "/service/user/{id}", method = RequestMethod.GET)
    @ResponseBody
    public User getUser( @PathVariable Integer id, ModelMap models )
    {
        return userDao.getUser( id );
    }

    @RequestMapping(value = "/service/users", method = RequestMethod.POST)
    @ResponseBody
    public User addUser( @RequestBody User user )
    {
        return userDao.saveUser( user );
    }

    @RequestMapping(value = "/service/user/{id}", method = RequestMethod.PUT)
    @ResponseBody
    public void updateUser( @PathVariable Integer id, @RequestBody User user )
    {
        user.setId( id );
        userDao.saveUser( user );
    }

    @RequestMapping(value = "/service/user/{id}", method = RequestMethod.DELETE)
    @ResponseBody
    public void deleteUser( @PathVariable Integer id )
    {
        userDao.deleteUser( id );
    }

}

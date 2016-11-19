package restws.web.service;

import javax.servlet.http.HttpServletResponse;

import org.simpleframework.xml.Serializer;
import org.simpleframework.xml.core.Persister;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import restws.helper.Users;
import restws.model.User;
import restws.model.dao.UserDao;

@Controller
public class UserService {

    @Autowired
    UserDao userDao;

    @RequestMapping(value = "/service/user/{id}", method = RequestMethod.GET)
    public String getUser( @PathVariable Integer id, ModelMap models )
    {
        models.put( "user", userDao.getUser( id ) );
        return "getUser";
    }

    @RequestMapping(value = "/service/user/{id}.xml",
        method = RequestMethod.GET)
    public String getUserXml( @PathVariable Integer id,
        HttpServletResponse response ) throws Exception
    {
        User user = userDao.getUser( id );

        response.setContentType( "text/xml" );
        Serializer serializer = new Persister();
        serializer.write( user, response.getWriter() );
        return null;
    }

    @RequestMapping(value = "/service/user/all.xml", method = RequestMethod.GET)
    public String getUsersXml( HttpServletResponse response ) throws Exception
    {
        response.setContentType( "text/xml" );
        Serializer serializer = new Persister();
        serializer.write( new Users( userDao.getUsers() ), response.getWriter() );
        return null;
    }

    @RequestMapping(value = "/service/user/{id}.json",
        method = RequestMethod.GET)
    public String getUserJson( @PathVariable Integer id, ModelMap models )
    {
        models.put( "user", userDao.getUser( id ) );
        return "jsonView";
    }

    @RequestMapping(value = "/service/user/all.json",
        method = RequestMethod.GET)
    public String getUsersJson( ModelMap models )
    {
        models.put( "users", userDao.getUsers() );
        return "jsonView";
    }

}

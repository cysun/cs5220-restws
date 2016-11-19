package restws.helper;

import java.util.List;

import org.simpleframework.xml.ElementList;
import org.simpleframework.xml.Root;

import restws.model.User;

@Root
public class Users {

    @ElementList(inline = true)
    private List<User> users;

    public Users()
    {
    }

    @Override
    public String toString()
    {
        StringBuffer sb = new StringBuffer();
        for( User user : users )
            sb.append( user.toString() ).append( "\n" );
        return sb.toString();
    }

    public Users( List<User> users )
    {
        this.users = users;
    }

    public List<User> getUsers()
    {
        return users;
    }

    public void setUsers( List<User> users )
    {
        this.users = users;
    }

}

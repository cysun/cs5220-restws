package restws.client;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.simpleframework.xml.Serializer;
import org.simpleframework.xml.core.Persister;

import restws.helper.Users;
import restws.model.User;

public class XmlClient {

    public static void main( String args[] ) throws Exception
    {
        DefaultHttpClient httpClient = new DefaultHttpClient();
        Serializer serializer = new Persister();

        // Use a GET request to retrieve user #1
        HttpGet request = new HttpGet(
            "http://localhost:8080/restws/service/user/1.xml" );
        HttpResponse response = httpClient.execute( request );
        HttpEntity responseBody = response.getEntity();

        // Convert the XML response to a User object and print it out
        User user = serializer.read( User.class, responseBody.getContent() );
        System.out.println( user );

        // Close connection
        EntityUtils.consume( responseBody );

        // Use a GET request to retrieve all users
        request = new HttpGet(
            "http://localhost:8080/restws/service/user/all.xml" );
        response = httpClient.execute( request );
        responseBody = response.getEntity();

        // Convert the XML response to a Users object and print it out
        Users users = serializer.read( Users.class, responseBody.getContent() );
        System.out.println( users );

        // Close connection
        EntityUtils.consume( responseBody );
    }

}

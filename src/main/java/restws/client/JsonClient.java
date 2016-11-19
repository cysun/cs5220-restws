package restws.client;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;

import restws.model.User;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

public class JsonClient {

    public static void main( String args[] ) throws ClientProtocolException,
        IOException
    {
        DefaultHttpClient httpClient = new DefaultHttpClient();
        ObjectMapper mapper = new ObjectMapper();

        // Use a GET request to retrieve user #1
        HttpGet request = new HttpGet(
            "http://localhost:8080/restws/service/user/1.json" );
        HttpResponse response = httpClient.execute( request );
        HttpEntity responseBody = response.getEntity();

        // Convert the JSON response to a User object and print it out
        Map<String, User> result = mapper.readValue( responseBody.getContent(),
            new TypeReference<Map<String, User>>() {
            } );
        System.out.println( result.get( "user" ) );

        // Close connection
        EntityUtils.consume( responseBody );

        // Use a GET request to retrieve all users
        request = new HttpGet(
            "http://localhost:8080/restws/service/user/all.json" );
        response = httpClient.execute( request );
        responseBody = response.getEntity();

        // Convert the JSON response to a list of User objects and print them
        // out
        Map<String, List<User>> results = mapper.readValue(
            responseBody.getContent(),
            new TypeReference<Map<String, List<User>>>() {
            } );
        for( User user : results.get( "users" ) )
            System.out.println( user );

        // Close connection
        EntityUtils.consume( responseBody );
    }

}

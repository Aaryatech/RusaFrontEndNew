package com.ats.rusafrontend.commen;

import java.io.IOException;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.springframework.http.HttpRequest;
import org.springframework.http.client.ClientHttpRequestExecution;
import org.springframework.http.client.ClientHttpRequestInterceptor;
import org.springframework.http.client.ClientHttpResponse;
import org.springframework.lang.Nullable;
import org.springframework.util.Assert;
import org.springframework.util.Base64Utils;

 
public class BasicAuthorizationInterceptor implements ClientHttpRequestInterceptor {

	private final String username;

	private final String password;

	public BasicAuthorizationInterceptor(@Nullable String username, @Nullable String password) {
		Assert.doesNotContain(username, ":", "Username must not contain a colon");
		this.username = (username != null ? username : "");
		this.password = (password != null ? password : "");
	}

	@Override
	public ClientHttpResponse intercept(HttpRequest request, byte[] body, ClientHttpRequestExecution execution)
			throws IOException {

		/*
		 * try { MessageDigest md = MessageDigest.getInstance("MD5"); byte[]
		 * messageDigest = md.digest(password.getBytes()); BigInteger number = new
		 * BigInteger(1, messageDigest); String hashtext = number.toString(16);
		 * System.out.println(hashtext); request.getHeaders().add("Authorization",
		 * "Basic " + hashtext); } catch (NoSuchAlgorithmException e) { // TODO
		 * Auto-generated catch block e.printStackTrace(); }
		 */

		String token = Base64Utils
				.encodeToString((this.username + ":" + this.password).getBytes(StandardCharsets.UTF_8));
		request.getHeaders().add("Authorization", "Basic " + token);

		return execution.execute(request, body);
	}

}

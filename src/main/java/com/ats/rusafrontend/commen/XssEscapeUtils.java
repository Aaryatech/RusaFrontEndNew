package com.ats.rusafrontend.commen;

import java.net.URLDecoder;
import java.net.URLEncoder;

import org.apache.commons.text.StringEscapeUtils;
import org.jsoup.Jsoup;
import org.jsoup.safety.Whitelist;
import org.springframework.web.util.JavaScriptUtils;

/*<dependency>
<groupId>org.jsoup</groupId>
<artifactId>jsoup</artifactId>
<version>1.8.3</version>
</dependency>
<!-- https://mvnrepository.com/artifact/org.apache.commons/commons-lang3 -->
<dependency>
<groupId>org.apache.commons</groupId>
<artifactId>commons-text</artifactId>
<version>1.4</version>
</dependency>*/
public class XssEscapeUtils {
	// a) in all input type text and textarea without ckeditor or any html editor
	// in both project
	public static String jsoupParse(String str) {
		str = str.replaceAll("\\<.*?\\>", "");
		str=Jsoup.parse(str).text();
		//System.err.println("str1 in jsoupParse " +str);
		//str = URLEncoder.encode(str);
		try {
			str =URLDecoder.decode(str);
		}catch(Exception e) {
			
		}
		
		
	  	str=StringEscapeUtils.escapeHtml4(str);
	 	str=StringEscapeUtils.escapeJava(str);
		//str= StringEscapeUtils.escapeEcmaScript(str);
		//str=StringEscapeUtils.unescapeHtml4(str);
		 
	//	str=StringEscapeUtils.escapeJava(str); 
		//System.err.println("str1 in encode " +str);
		return str;
		}

		// b) in all textarea with ckeditor or any html editor in both project
		public static String jsoupParseClean(String str) {
			//Jsoup.clean(str, Whitelist.relaxed())
		return str;
		}

		public static String jsoupParseOutput(String str) {
		//System.err.println("str0 " +str);

//			str = URLEncoder.encode(str);
//			System.err.println("str1 encode " +str);



		str=StringEscapeUtils.unescapeHtml4(str);
		//System.err.println("str2  unescapeHtml4 " +str);

		str=StringEscapeUtils.escapeJava(str);

		//System.err.println("str3 unescapeJava " +str);
		return str;
		}
	/*
	 * public static String jsoupParse(String str) { return Jsoup.parse(str).text();
	 * }
	 * 
	 * public static String escapeHtml4(String html) { return
	 * StringEscapeUtils.escapeHtml4(html); }
	 * 
	 * public static String unescapeHtml4(String html) { return
	 * StringEscapeUtils.unescapeHtml4(html); }
	 */
}

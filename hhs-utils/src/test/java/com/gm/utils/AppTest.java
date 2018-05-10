package com.gm.utils;

import java.util.ArrayList;
import java.util.List;

import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.Md5Hash;


import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

/**
 * Unit test for simple App.
 */
public class AppTest {
	public static void main(String[] args) {
/*
		SecureRandomNumberGenerator secureRandomNumberGenerator = new SecureRandomNumberGenerator();
		String salt = secureRandomNumberGenerator.nextBytes().toHex();
		// 组合username,两次迭代，对密码进行加密
		String password_cipherText = new Md5Hash("admin", "admin" + salt, 2).toHex();
		System.out.println(salt);
		System.out.println(password_cipherText);*/
		
		String sc ="http://192.168.0.15:8080" ;
/*		String sr = sc.substring(0, sc.indexOf(":8080"));*/
		System.out.println(sc);
		String content = "<p><span style='color: rgb(51, 51, 51); font-family: 宋体; font-size: 14px; background-color: rgb(255, 255, 255);'>　<img src='/static/upload/image/20170610/1497098032016048693.png'></div><span onclick='delPics(this,'+id+')' class='fa fa-close delete'>彼时一颦一笑，尽显流年里活色生香的春花秋月。此时的一磋一叹，又像是掸去了岁月浮尘，展露记忆珍藏的、值得用一生回味的美好时刻。</span><img src='/static/upload/image/20170610/1497098032017777777.png'><img src='/static/upload/image/20170610/149709803201666666.png'></p>";
		List<String>list =  StringUtil.getImgSrc(content);
		List<String>list2 = new  ArrayList<String>();
		
		for (int i = 0; i < list.size(); i++) {
			String ss=sc+list.get(i);
			list2.add(ss);
		}
		for(int i = 0;i<list.size();i++){
			content=content.replace(list.get(i), list2.get(i));
			System.out.println(i+"==="+content);
			
		}
		System.out.println(list2);
		System.out.println("==="+content);
		
	}

}

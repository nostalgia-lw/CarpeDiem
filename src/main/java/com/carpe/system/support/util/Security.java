package com.carpe.system.support.util;

import org.apache.log4j.Logger;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.io.UnsupportedEncodingException;
import java.security.Key;

/**
 * 加密解密
 * Created by zyou on 2016/06/20
 *
 */
public class Security {
	/** 日志记录者 */
	private Logger logger = Logger.getLogger(Security.class);
	/** 加密密钥 */
	private String keyValue = "偷拍自拍，|";
	/**
	 * 加密
	 *
	 * @param content 要加密的内容
	 * @return 加密后的密文,加密失败直接返回原来内容
	 */
	public String encrypt(String content) {
		try {
			Key key = generateKey();
			Cipher c = Cipher.getInstance("AES");
			c.init(Cipher.ENCRYPT_MODE, key);
			byte[] encVal = c.doFinal(content.getBytes("UTF-8"));
			String encryptedValue = new BASE64Encoder().encode(encVal);
			return encryptedValue;
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return content;
	}

	/**
	 * 解密
	 * 
	 * @param encryptedData 加密的数据
	 * @return 解密后的明文,解密失败直接返回密文
	 */
	public String decrypt(String encryptedData) {
		try {
			Key key = generateKey();
			Cipher c = Cipher.getInstance("AES");
			c.init(Cipher.DECRYPT_MODE, key);
			byte[] decordedValue = new BASE64Decoder()
					.decodeBuffer(encryptedData);
			byte[] decValue = c.doFinal(decordedValue);
			return new String(decValue, "UTF-8");
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return encryptedData;
	}
	/**
	 * 生成密钥对象
	 * 
	 * @return 密钥对象
	 * @throws UnsupportedEncodingException
	 *             不支持的字符串编码
	 */
	private Key generateKey() throws UnsupportedEncodingException {
		return new SecretKeySpec(keyValue.getBytes("UTF-8"), "AES");
	}
}

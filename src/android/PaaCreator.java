package com.cordova.plugin;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

import org.json.JSONException;
import org.json.JSONObject;

import android.util.Log;

public class PaaCreator {
	public static JSONObject genPayData(Double amount, String receiveUrl, String signType, String merchantId, String orderNo, String productName, String orderCurrency, String orderDatetime, String payType, String key) {
		String amountString = String.format("%.0f", (amount * 100));
	    
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        dateFormat.setTimeZone(TimeZone.getTimeZone("GMT+8"));
        String timeStr = dateFormat.format(new Date());
	    String orderStr = timeStr + "0000";
	    
	    JSONObject paaParams = new JSONObject();
	    try {
			paaParams.put("inputCharset", "1");
			paaParams.put("receiveUrl", receiveUrl);
			paaParams.put("version", "v1.0");
			paaParams.put("signType", signType);
			paaParams.put("merchantId", merchantId);
			paaParams.put("orderNo", orderNo);
			paaParams.put("orderAmount", amountString);
			paaParams.put("orderCurrency", orderCurrency);
			paaParams.put("orderDatetime", orderDatetime);
			paaParams.put("productName", productName);
//			paaParams.put("ext1", ext1FromInput());
//			paaParams.put("ext1", "<USER>201406231006545</USER>");
			paaParams.put("payType", payType);
//			paaParams.put("issuerId", "visa");
//			paaParams.put("tradeNature", "GOODS");
//			paaParams.put("language", "3");
//			paaParams.put("cardNo", "");
		} catch (JSONException e) {
			e.printStackTrace();
		}
	    
		    String[] paaParamsArray = {
				"1","inputCharset",
				receiveUrl,"receiveUrl",
				"v1.0","version",
//				"3","language",
				signType,"signType",
				merchantId,"merchantId",
				orderNo,"orderNo",
				amountString,"orderAmount",
				orderCurrency,"orderCurrency",
				orderDatetime,"orderDatetime",
				productName, "productName",
//				ext1FromInput(),"ext1",
//			    "<USER>201406231006545</USER>","ext1",
				payType,"payType",
//				"visa","issuerId",
//				"GOODS","tradeNature",
				key,"key",
		    };
		    
		    String paaStr = "";
		    for (int i = 0; i < paaParamsArray.length; i++) {
		    	paaStr += paaParamsArray[i+1] + "=" + paaParamsArray[i] + "&";
		        i++;
		    }
		    Log.d("PaaCreator", "PaaCreator " + paaStr.substring(0, paaStr.length() -1));
		    String md5Str = md5(paaStr.substring(0, paaStr.length() -1));
		    Log.d("PaaCreator", "PaaCreator md5Str " + md5Str);
		    try {
				paaParams.put("signMsg", md5Str);
//				paaParams.put("ship_to_country", "US");
//				paaParams.put("ship_to_state", "AL");
//				paaParams.put("ship_to_city", "city");
//				paaParams.put("ship_to_street1", "street_1");
//				paaParams.put("ship_to_street2", "street_2"); 
//				paaParams.put("ship_to_phonenumber", "13812345678");
//				paaParams.put("ship_to_postalcode", "20004");
//				paaParams.put("ship_to_firstname", "Smith");
//				paaParams.put("ship_to_lastname", "Black");
//				paaParams.put("registration_name", "abc");
//				paaParams.put("registration_email", "abc@gmail.com");
//				paaParams.put("registration_phone", "999-13800000000");
//				paaParams.put("buyerid_period", "200");
//				paaParams.put("fnpay_mode", "1");
//				paaParams.put("bill_firstname", "handon");
//				paaParams.put("bill_lastname", "hao");
//				paaParams.put("expireddate", "1919");
//				paaParams.put("cvv2", "888");
//				paaParams.put("bill_email", "abc@gmail.com");
//				paaParams.put("bill_country", "US"); 
//				paaParams.put("bill_address", "billaddress");
//				paaParams.put("bill_city", "billcity");
//				paaParams.put("bill_state", "IL");
//				paaParams.put("bill_zip", "12345");
			} catch (JSONException e) {
				e.printStackTrace();
			}
		    return paaParams;
		}
	
	public static String md5(String string) {
		byte[] hash;
		try {
			hash = MessageDigest.getInstance("MD5").digest(
					string.getBytes("UTF-8"));
		} catch (NoSuchAlgorithmException e) {
			throw new RuntimeException("Huh, MD5 should be supported?", e);
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException("Huh, UTF-8 should be supported?", e);
		}

		return hexString(hash);
	}
	
	public static final String hexString(byte[] bytes)
	{
		StringBuffer buffer = new StringBuffer();
		for (int i = 0; i < bytes.length; i++)
		{
			buffer.append(hexString(bytes[i]));
		}
		return buffer.toString();
	}
	
	public static final String hexString(byte byte0)
	{
		char ac[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
		char ac1[] = new char[2];
		ac1[0] = ac[byte0 >>> 4 & 0xf];
		ac1[1] = ac[byte0 & 0xf];
		String s = new String(ac1);
		return s;
	}
	
//	public static String ext1FromInput() {
//	    String[] paaParamsArray = {
//				"US","ship_to_country",
//				"AL","ship_to_state",
//				"city","ship_to_city",
//				"street_1","ship_to_street1",
//				"street_2","ship_to_street2",
//				"13812345678","ship_to_phonenumber",
//				"20004","ship_to_postalcode",
//				"Smith","ship_to_firstname",
//				"Black","ship_to_lastname",
//				"abc", "registration_name",
//				"abc@gmail.com","registration_email",
//				"999-13800000000","registration_phone",
//				"200","buyerid_period",
//				"1","fnpay_mode",
//				"handon","bill_firstname",
//				"hao","bill_lastname",
//				"1919","expireddate",
//				"888","cvv2",
//				"abc@gmail.com","bill_email",
//				"US","bill_country",
//				"billaddress","bill_address",
//				"billcity", "bill_city",
//				"IL","bill_state",
//				"12345","bill_zip",
//		    };
//		    
//		    String paaStr = "";
//		    for (int i = 0; i < paaParamsArray.length; i++) {
//		    	paaStr += paaParamsArray[i];
//		        i++;
//		    }
//		    Log.d("ext1FromInput", "ext1FromInput " + paaStr);
//		    String md5Str = md5(paaStr);
//		    Log.d("ext1FromInput", "ext1FromInput md5Str " + md5Str);
//		
//		return md5Str;
//	}
}

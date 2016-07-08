package com.carpe.system.support.util;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

/**
 * 发送短信
 *
 * @author My_Ascii
 */
public class SendSmsUtil {


    private String sendMsg(String mobile, String content, String ext) throws Exception {
        String url = "http://sdk.entinfo.cn:8061/webservice.asmx/mdsmssend";
        List<NameValuePair> params = new ArrayList<NameValuePair>();
        params.add(new NameValuePair("sn", "SDK-WSS-010-09391"));
        params.add(new NameValuePair("pwd", "DFD5A3C3573B850BE0991C6C1EA5B4EC"));
        params.add(new NameValuePair("mobile", mobile));
        params.add(new NameValuePair("content", URLEncoder.encode(content + "【顶呱呱集团】", "utf-8")));
        params.add(new NameValuePair("ext", ""));
        params.add(new NameValuePair("stime", ""));
        params.add(new NameValuePair("rrid", ""));
        params.add(new NameValuePair("msgfmt", ""));
        String result = SendSmsUtil.request(url, params.toArray(new NameValuePair[params.size()]));
        return result;
    }

    public String sendSms(String mobile, String content){
        String result = null;
        try {
            result = this.sendMsg(mobile,content,null);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static void main(String[] args) {
        SendSmsUtil s = new SendSmsUtil();
        String msg = "HELLO,我是测试短信，你好。";
        try {
            String body = s.sendSms("18613236735", msg);
            System.out.println(body);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public static String request(String url, NameValuePair[] params) {

        String result = null;

        HttpClient client = new HttpClient();

        PostMethod postMethod = new PostMethod(url);

        postMethod.setRequestBody(params);

        int statusCode = 0;
        try {
            statusCode = client.executeMethod(postMethod);
        } catch (HttpException e) {
        } catch (IOException e) {
        }

        try {
            if (statusCode == HttpStatus.SC_OK) {
                result = postMethod.getResponseBodyAsString();
                return result;
            } else {
            }
        } catch (IOException e) {
        }
        postMethod.releaseConnection();
        return result;
    }

}

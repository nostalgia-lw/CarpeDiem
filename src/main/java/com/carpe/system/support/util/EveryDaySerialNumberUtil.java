package com.carpe.system.support.util;

import java.io.File;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 每日序列编号生成类<br/>
 * 生成的格式是: 201209010000001 前面8位为当前的日期,后面3位为系统自增长类型的编号<br/>
 * 原理: <br/>
 * 1.获取当前日期格式化值;<br/>
 * 2.读取文件,上次编号的值+1最为当前此次编号的值 (新的一天会重新从1开始编号);<br/>
 * 
 * @author DongQihong
 * 
 */
public class EveryDaySerialNumberUtil {
    /**
     * 分隔符
     */
    private static final String FIELD_SEPARATOR = ",";
    /**
     * 序列号长度
     */
    private int serialwidth = 4;
    /**
     * 生成序列号所要用到的文件名
     */
    public String path =this.getClass().getClassLoader().getResource("").getPath();
    private String serialFileName = path+"EveryDaySerialNumber.dat";

    /**
     * 生成每日序号
     * 
     * @return 生成的序号
     */
    public synchronized String makeSerialNumber() {
        Date date = new Date();
        int n = getAndUpdateNumber(date, 1);
        return format(date) + format(n);
    }

    /**
     * 格式化数字
     * 
     * @param num
     *            要格式化的整数
     * @return 格式化后的字符串
     */
    private String format(int num) {
        char[] chs = new char[serialwidth];
        for (int i = 0; i < serialwidth; i++) {
            chs[i] = '0';
        }
        DecimalFormat decimalFormat = new DecimalFormat(new String(chs));
        return decimalFormat.format(num);
    }

    /**
     * 格式化时间，格式化为形如20120925
     * 
     * @param date
     *            要格式它的时间
     * @return 格式化后的字符串
     */
    protected String format(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");
        return sdf.format(date);
    }

    /**
     * 获取并更新数字
     * 
     * @param current
     *            当前时间
     * @param start
     *            开始数字
     * @return 新的数字
     */
    private int getAndUpdateNumber(Date current, int start) {
        File file = new File(serialFileName);
        String date = format(current);
        int num = start;
        if (file.exists()) {
            List<String> list = FileUtil.readList(file);
            try {
                String[] data = list.get(0).split(FIELD_SEPARATOR);
                if (date.equals(data[0])) {
                    num = Integer.parseInt(data[1]);
                }
            } catch (Exception e) {
                num = 1;
            }
        }
        FileUtil.rewrite(file, date + FIELD_SEPARATOR + (num + 1));
        return num;
    }

    /**
     * 得到序列号的长度
     * 
     * @return 序列号的长度
     */
    public int getSerialwidth() {
        return serialwidth;
    }

    /**
     * 设置序列号的长度
     * 
     * @param serialwidth
     *            序列号的长度<br/>
     *            注意：只能是1至9范围内的整数<br/>
     */
    public void setSerialwidth(int serialwidth) {
        if (serialwidth < 1) {
            throw new IllegalArgumentException(
                    "Parameter length must be great than 1!");
        }
        if (serialwidth > 9) {
            throw new IllegalArgumentException(
                    "Parameter length must be less than 9!");
        }
        this.serialwidth = serialwidth;
    }

    /**
     * 得到生成序列号所用到的文件名
     * 
     * @return 生成序列号所要用到的文件名
     */
    public String getSerialFileName() {
        return serialFileName;
    }

    /**
     * 设置生成序列号所要用到的文件名
     * 
     * @param serialFileName
     *            生成序列号所要用到的文件名
     */
    public void setSerialFileName(String serialFileName) {
        this.serialFileName = serialFileName;
    }
}

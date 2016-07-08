package com.carpe.system.support.util;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.stream.MemoryCacheImageInputStream;
import javax.swing.*;
import java.awt.*;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.awt.image.ColorModel;
import java.awt.image.WritableRaster;
import java.io.*;
import java.util.Iterator;

/**
 * 图片处理
 * @author Gershon
 *
 */
public class ImageUtil {
	
	/**
	 * 判断图片类型
	 * @param imageBytes
	 * @return
	 */
	public static String checkImageType(byte[] imageBytes) {
		ByteArrayInputStream bais = null;
		MemoryCacheImageInputStream mcis = null;
		try {
			bais = new ByteArrayInputStream(imageBytes);
			mcis = new MemoryCacheImageInputStream(bais);
			Iterator itr = ImageIO.getImageReaders(mcis);
			while (itr.hasNext()) {
				ImageReader reader = (ImageReader) itr.next();
				String imageName = reader.getClass().getSimpleName();
				if (imageName != null && ("JPEGImageReader".equalsIgnoreCase(imageName))) {
					return "jpeg";
				} else if (imageName != null && ("JPGImageReader".equalsIgnoreCase(imageName))) {
					return "jpg";
				} else if (imageName != null && ("pngImageReader".equalsIgnoreCase(imageName))) {
					return "png";
				}
			}
		} catch (Exception e) {
			System.out.println("判断图片类型失败");
		}
		return null;
	}

	public static byte[] image2Bytes(String imagePath) {
		ImageIcon ima = new ImageIcon(imagePath);
		BufferedImage bu = new BufferedImage(ima.getImage().getWidth(null), ima.getImage().getHeight(null),
				BufferedImage.TYPE_INT_RGB);
		ByteArrayOutputStream imageStream = new ByteArrayOutputStream();
		try {
			// 这里可以转变图片的编码格式
			ImageIO.write(bu, "png", imageStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
		byte[] tagInfo = imageStream.toByteArray();
		return tagInfo;
	}

	public static byte[] getImageData(File file, String format) {
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		try {
			BufferedImage bImage = ImageIO.read(new FileInputStream(file));
			ImageIO.write(bImage, format, out);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return out.toByteArray();
	}

	public static BufferedImage resize(BufferedImage source, int targetW, int targetH) {
		// targetW，targetH分别表示目标长和宽
		int type = source.getType();
		BufferedImage target = null;
		double sx = (double) targetW / source.getWidth();
		double sy = (double) targetH / source.getHeight();
		// 这里想实现在targetW，targetH范围内实现等比缩放。如果不需要等比缩放
		// 则将下面的if else语句注释即可
		if (sx > sy) {
			sx = sy;
			targetW = (int) (sx * source.getWidth());
		} else {
			sy = sx;
			targetH = (int) (sy * source.getHeight());
		}
		if (type == BufferedImage.TYPE_CUSTOM) {// handmade
			ColorModel cm = source.getColorModel();
			WritableRaster raster = cm.createCompatibleWritableRaster(targetW, targetH);
			boolean alphaPremultiplied = cm.isAlphaPremultiplied();
			target = new BufferedImage(cm, raster, alphaPremultiplied, null);
		} else
			target = new BufferedImage(targetW, targetH, type);
		Graphics2D g = target.createGraphics();
		// smoother than exlax:
		g.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
		g.drawRenderedImage(source, AffineTransform.getScaleInstance(sx, sy));
		g.dispose();
		return target;
	}
	/**
	 *  图片转化成base64字符串
	 * @return
	 */
	public static String GetImageStr(String imgFileUrl) {// 将图片文件转化为字节数组字符串，并对其进行Base64编码处理
		InputStream in = null;
		byte[] data = null;
		// 读取图片字节数组
		try {
		in = new FileInputStream(imgFileUrl);
		data = new byte[in.available()];
		in.read(data);
		in.close();
		} catch (IOException e) {
		e.printStackTrace();
		}
		// 对字节数组Base64编码
		BASE64Encoder encoder = new BASE64Encoder();
		return encoder.encode(data);// 返回Base64编码过的字节数组字符串
	}
	/**
	 * base64字符串转化成图片
	 * @param imgStr 64位编码
	 * @param imgFilePath  转化后保存的图片
	 * @return
	 */
	public static boolean GenerateImage(String imgStr,String imgFilePath) { // 对字节数组字符串进行Base64解码并生成图片
		if (imgStr == null) // 图像数据为空
		return false;
		BASE64Decoder decoder = new BASE64Decoder();
		try {
		// Base64解码
		byte[] b = decoder.decodeBuffer(imgStr);
		for (int i = 0; i < b.length; ++i) {
		if (b[i] < 0) {// 调整异常数据
		b[i] += 256;
		}
		}
		// 生成jpeg图片
		//String imgFilePath = "C:/Users/Star/Desktop/test22.png";// 新生成的图片
		String imgPath = imgFilePath.substring(0, imgFilePath.lastIndexOf("\\"));
		File savePath = new File(imgPath);
		if (!savePath.exists()) {
			savePath.mkdirs();
		}
		
		OutputStream out = new FileOutputStream(imgFilePath);
		out.write(b);
		out.flush();
		out.close();
		return true;
		} catch (Exception e) {
		return false;
		}
	}
}

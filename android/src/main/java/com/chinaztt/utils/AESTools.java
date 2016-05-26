package com.chinaztt.utils;

import org.apache.axis.encoding.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

/**
 * 当前类注释:
 * 项目名：android
 * 包名：com.chinaztt.utils
 * 作者：江清清 on 16/5/26 13:58
 * 邮箱：jiangqqlmj@163.com
 * QQ： 781931404
 * 公司：江苏中天科技软件技术有限公司
 * 站点:<a href="http://www.lcode.org">www.lcode.org</a>
 */
public class AESTools {
    /**
     * 加密--把加密后的byte数组先进行二进制转16进制在进行base64编码
     *
     * @param sSrc
     * @param sKey
     * @return
     * @throws Exception
     */
    public static String encrypt(String sSrc, String sKey) throws Exception {
        if (sKey == null) {
            throw new IllegalArgumentException("Argument sKey is null.");
        }
        if (sKey.length() != 16) {
            throw new IllegalArgumentException(
                    "Argument sKey'length is not 16.");
        }
        byte[] raw = sKey.getBytes("ASCII");
        SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");

        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.ENCRYPT_MODE, skeySpec);

        byte[] encrypted = cipher.doFinal(sSrc.getBytes("UTF-8"));
        String tempStr = parseByte2HexStr(encrypted);
        //BASE64Encoder encoder = new BASE64Encoder();
        return Base64.encode(tempStr.getBytes("UTF-8"));


    }

    /**
     * 解密--先 进行base64解码，在进行16进制转为2进制然后再解码
     *
     * @param sSrc
     * @param sKey
     * @return
     * @throws Exception
     */
    public static String decrypt(String sSrc, String sKey) throws Exception {

        if (sKey == null) {
            throw new IllegalArgumentException("499");
        }
        if (sKey.length() != 16) {
            throw new IllegalArgumentException("498");
        }

        byte[] raw = sKey.getBytes("ASCII");
        SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");

        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.DECRYPT_MODE, skeySpec);

        // Base64Encoder encoder = new Base64Encoder();
        byte[] encrypted1 = Base64.decode(sSrc);
        String tempStr = new String(encrypted1, "utf-8");
        encrypted1 = parseHexStr2Byte(tempStr);
        byte[] original = cipher.doFinal(encrypted1);
        String originalString = new String(original, "utf-8");
        return originalString;
    }

    /**
     * 将二进制转换成16进制
     *
     * @param buf
     * @return
     */
    public static String parseByte2HexStr(byte buf[]) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < buf.length; i++) {
            String hex = Integer.toHexString(buf[i] & 0xFF);
            if (hex.length() == 1) {
                hex = '0' + hex;
            }
            sb.append(hex.toUpperCase());
        }
        return sb.toString();
    }

    /**
     * 将16进制转换为二进制
     *
     * @param hexStr
     * @return
     */
    public static byte[] parseHexStr2Byte(String hexStr) {
        if (hexStr.length() < 1)
            return null;
        byte[] result = new byte[hexStr.length() / 2];
        for (int i = 0; i < hexStr.length() / 2; i++) {
            int high = Integer.parseInt(hexStr.substring(i * 2, i * 2 + 1), 16);
            int low = Integer.parseInt(hexStr.substring(i * 2 + 1, i * 2 + 2),
                    16);
            result[i] = (byte) (high * 16 + low);
        }
        return result;
    }

    public static void main(String[] args) throws Exception {
        String Code = "jiangqq";
        String key = "wIEuw3kAGwVNl7BW";
        String codE;
        codE = AESTools.encrypt(Code, key);
        System.out.println("原文：" + Code);
        System.out.println("密钥：" + key);
        System.out.println("密文：" + codE);
        System.out.println("解密：" + AESTools.decrypt(codE, key));

    }
}

package com.chinaztt.encapsulation;

import android.util.Log;

import com.chinaztt.utils.AESTools;
import com.chinaztt.utils.MD5Tools;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

/**
 * 当前类注释:
 * 项目名：android
 * 包名：com.chinaztt.encapsulation
 * 作者：江清清 on 16/5/26 14:03
 * 邮箱：jiangqqlmj@163.com
 * QQ： 781931404
 * 公司：江苏中天科技软件技术有限公司
 * 站点:<a href="http://www.lcode.org">www.lcode.org</a>
 */
public class EncryptionModule extends ReactContextBaseJavaModule {

    public EncryptionModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "EncryptionModule";
    }

    /**
     * 对传入的数据进行MD5加密 然后通过CallBack方法回调到JS端
     * @param encryptionMsg    待加密数据
     * @param successBack
     * @param errorBack
     */
    @ReactMethod
    public void MD5ByCallBack(String encryptionMsg, Callback successBack,Callback errorBack){
        try {
            String result=MD5Tools.MD5(encryptionMsg);
            successBack.invoke(result);
        }catch (Exception e){
            errorBack.invoke(e.getMessage());
            e.printStackTrace();
        }
    }
    /**
     * 对传入的数据进行MD5加密 然后通过Promise方法回调到JS端
     * @param encryptionMsg
     * @param promise
     */
    @ReactMethod
    public void MD5ByPromise(String encryptionMsg, Promise promise){
         try {
             String result=MD5Tools.MD5(encryptionMsg);
             promise.resolve(result);
         }catch (Exception e){
             promise.reject(e);
             e.printStackTrace();


         }
    }

    /**
     * 对传入的待加密数据和秘钥进行加密，然后通过CallBack返回结果
     * @param encryptionMsg
     * @param encryptionKey
     * @param successBack
     * @param errorBack
     */
    @ReactMethod
    public void AESEncryptByCallBack(String encryptionMsg,String encryptionKey,Callback successBack,Callback errorBack){
       try {
           String result= AESTools.encrypt(encryptionMsg, encryptionKey);
           successBack.invoke(result);
       }catch (Exception e){
           errorBack.invoke(e.getMessage());
           e.printStackTrace();
       }
    }

    /**
     * 对传入的待加密数据和秘钥进行加密，然后通过Promise返回结果
     * @param encryptionMsg
     * @param encryptionKey
     * @param promise
     */
    @ReactMethod
    public void AESEncryptByPromise(String encryptionMsg,String encryptionKey,Promise promise){
        try {
            String result=AESTools.encrypt(encryptionMsg, encryptionKey);
            promise.resolve(result);
        }catch (Exception e){
            promise.reject(e);
            e.printStackTrace();
        }
    }

    /**
     * 对传入的加密数据和秘钥进行解密，然后通过CallBack返回结果
     * @param encryptionMsg
     * @param encryptionKey
     * @param successBack
     * @param errorBack
     */
    @ReactMethod
    public void AESDecryptByCallBack(String encryptionMsg,String encryptionKey,Callback successBack,Callback errorBack){
        try {
            Log.d("zttjiangqq","传入的数据为:"+encryptionMsg);
            String result= AESTools.decrypt(encryptionMsg, encryptionKey);
            successBack.invoke(result);
        }catch (Exception e){
            errorBack.invoke(e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * 对传入的加密数据和秘钥进行解密，然后通过Promise返回结果
     * @param encryptionMsg
     * @param encryptionKey
     * @param promise
     */
    @ReactMethod
    public void AESDecryptByPromise(String encryptionMsg,String encryptionKey,Promise promise){
        try {
            Log.d("zttjiangqq","传入的数据为:"+encryptionMsg);
            String result= AESTools.decrypt(encryptionMsg, encryptionKey);
            promise.resolve(result);
        }catch (Exception e){
            promise.reject(e);
            e.printStackTrace();
        }
    }
}

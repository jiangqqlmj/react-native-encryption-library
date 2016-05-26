/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  TouchableHighlight
} from 'react-native';
import {NativeModules} from 'react-native';
var EncryptionModule=NativeModules.EncryptionModule

//待加密的信息
var PASSWORD='745r#x3g';
var KEY='wIEuw3kAGwVNl7BW';  //16位AES加密私钥

class CustomButton extends React.Component {
  render() {
    return (
      <TouchableHighlight
        style={styles.button}
        underlayColor="#a5a5a5"
        onPress={this.props.onPress}>
        <Text style={styles.buttonText}>{this.props.text}</Text>
      </TouchableHighlight>
    );
  }
}
class react_native_encryption_library extends Component {
  constructor(props){
     super(props);
     this.state={
        result:'',
        AES_Result:'',
     }
  }
  async _MD5ByPromise(){
     try{
        var result=await EncryptionModule.MD5ByPromise(PASSWORD);
        this.setState({result:'Promise:'+result});
     }catch(e){
        this.setState({result:'MD5加密失败-通过Promise回调'}); 
     }
  }
  async _AESEncryptByPromise(){
     try{
        var result=await EncryptionModule.AESEncryptByPromise(PASSWORD,KEY);
        this.setState({AES_Result:result});
     }catch(e){
        this.setState({AES_Result:'AES加密失败-通过Promise回调'}); 
     }
  }
  
  async _AESDecryptByPromise(){
     try{
        var result=await EncryptionModule.AESDecryptByPromise(this.state.AES_Result,KEY);
        this.setState({AES_Result:result});
     }catch(e){
        this.setState({AES_Result:'AES解密失败-通过Promise回调'}); 
     }
  }
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
           加密模块封装实例-Android端
        </Text>
        <Text style={{margin:10,fontSize:12}}>
           结果:{this.state.result}
        </Text>
        <CustomButton
           text="测试MD5加密封装-CallBack回调"
           onPress={()=>EncryptionModule.MD5ByCallBack(PASSWORD,(msg)=>{
               this.setState({result:'CallBack:'+msg});
          },(error)=>{
               this.setState({result:'MD5加密失败-通过Callback回调'});   
          })}
        />
        <CustomButton
           text="测试MD5加密封装-Promise回调"
           onPress={()=>this._MD5ByPromise()}
        />
         <Text style={{margin:10,fontSize:12}}>
           AES结果:{this.state.AES_Result}
        </Text>
        <CustomButton
           text="测试AES加密封装-CallBack回调"
           onPress={()=>EncryptionModule.AESEncryptByCallBack(PASSWORD,KEY,(msg)=>{
               this.setState({AES_Result:msg});
          },(error)=>{
               this.setState({AES_Result:'AES加密失败-通过Callback回调'});   
          })}
        />
        <CustomButton
           text="测试AES加密封装-Promise回调"
           onPress={()=>this._AESEncryptByPromise()}
        />
        <CustomButton
           text="测试AES解密封装-CallBack回调"
           onPress={()=>EncryptionModule.AESDecryptByCallBack(this.state.AES_Result,KEY,(msg)=>{
               this.setState({AES_Result:msg});
          },(error)=>{
               this.setState({AES_Result:'AES解密失败-通过Callback回调'});   
          })}
        />
        <CustomButton
           text="测试AES解密封装-Promise回调"
           onPress={()=>this._AESDecryptByPromise()}
        />
      </View>
    );
  }
}
const styles = StyleSheet.create({
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  button: {
    margin:5,
    backgroundColor: 'white',
    padding: 15,
    borderBottomWidth: StyleSheet.hairlineWidth,
    borderBottomColor: '#cdcdcd',
  },
});

AppRegistry.registerComponent('encryption_library', () => react_native_encryption_library);

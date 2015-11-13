package com.cordova.plugin;

import com.cordova.plugin.PaaCreator;

import org.apache.cordova.*;
import 	org.json.JSONObject;
import org.json.JSONArray;
import org.json.JSONException;
import com.allinpay.appayassistex.APPayAssistEx;
import android.content.Intent;
import android.app.Activity;

import java.lang.Override;
import java.util.Date;

public class AllInPay extends CordovaPlugin {
    private CallbackContext callbackContext;

    @Override
    public boolean execute(String action, JSONArray data, CallbackContext callbackContext) throws JSONException {
        this.callbackContext = callbackContext;

        this.cordova.setActivityResultCallback(this);

        if (action.equals("pay")) {

            Double amount = data.getDouble(0);
            String receiveUrl = data.getString(1);
            String signType = data.getString(2);
            String merchantId = data.getString(3);
            String orderNo = data.getString(4);
            String productName = data.getString(5);
            String orderCurrency = data.getString(6);
            String orderDatetime = data.getString(7);
            String payType = data.getString(8);
            String stage = data.getString(9);
            String key = data.getString(10);

            String paydata = PaaCreator.genPayData(amount, receiveUrl, signType, merchantId, orderNo, productName, orderCurrency, orderDatetime, payType, key).toString();

            Activity activity = cordova.getActivity();
            APPayAssistEx.startPay(activity, paydata, stage);

            PluginResult pluginResult = new  PluginResult(PluginResult.Status.NO_RESULT);
            pluginResult.setKeepCallback(true);
            callbackContext.sendPluginResult(pluginResult);

            return true;
        }
        
        return false;
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (APPayAssistEx.REQUESTCODE == requestCode) {
            if (null != data) {
                String payRes = null;
                String payAmount = null;
                String payTime = null;
                String payOrderId = null;
                try {
                    JSONObject resultJson = new JSONObject(data.getExtras().getString("result"));
                    payRes = resultJson.getString(APPayAssistEx.KEY_PAY_RES);
                    payAmount = resultJson.getString("payAmount");
                    payTime = resultJson.getString("payTime");
                    payOrderId = resultJson.getString("payOrderId");
                } catch (JSONException e) {
                    e.printStackTrace();
                }
                if (null != payRes && payRes.equals(APPayAssistEx.RES_SUCCESS)) {
                    this.callbackContext.success("pay success");
                }else{
                    this.callbackContext.error("pay fail");
                }
            }else{
                this.callbackContext.error("pay fail");
            }
        }

        super.onActivityResult(requestCode, resultCode, data);
    }
}

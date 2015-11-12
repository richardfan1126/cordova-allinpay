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

public class AllInPay extends CordovaPlugin {
    private CallbackContext callbackContext;

    @Override
    public boolean execute(String action, JSONArray data, CallbackContext callbackContext) throws JSONException {
        this.callbackContext = callbackContext;

        this.cordova.setActivityResultCallback(this);

        if (action.equals("pay")) {

            Double amount = data.getDouble(0);

            String paydata = PaaCreator.randomPaa().toString();

            Activity activity = cordova.getActivity();
            APPayAssistEx.startPay(activity, paydata, "01");

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

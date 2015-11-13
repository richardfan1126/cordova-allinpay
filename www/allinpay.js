/*global cordova, module*/

module.exports = {
    pay: function (data, successCallback, errorCallback) {
    	var defaultData = {
    		amount: ((typeof data.amount == 'undefined') ? 0.0 : data.amount),
    		receiveUrl: ((typeof data.receiveUrl == 'undefined') ? 'http://example.com' : data.receiveUrl),
    		signType: ((typeof data.signType == 'undefined') ? '0' : data.signType),
    		merchantId: ((typeof data.merchantId == 'undefined') ? '00000' : data.merchantId),
    		orderNo: ((typeof data.orderNo == 'undefined') ? '00000' : data.orderNo),
    		productName: ((typeof data.productName == 'undefined') ? 'Sample Product' : data.productName),
    		orderCurrency: ((typeof data.orderCurrency == 'undefined') ? '0' : data.orderCurrency),
    		orderDatetime: ((typeof data.orderDatetime == 'undefined') ? '' : data.orderDatetime),
    		payType: ((typeof data.payType == 'undefined') ? '0' : data.payType),
    		stage: ((typeof data.stage == 'undefined') ? '00' : data.stage),
    		key: ((typeof data.key == 'undefined') ? '00000' : data.key)
    	};
    	
    	var dataArray = [
    		defaultData.amount,
    		defaultData.receiveUrl,
    		defaultData.signType,
    		defaultData.merchantId,
    		defaultData.orderNo,
    		defaultData.productName,
    		defaultData.orderCurrency,
    		defaultData.orderDatetime,
    		defaultData.payType,
    		defaultData.stage,
    		defaultData.key
    	];
    	
        cordova.exec(successCallback, errorCallback, "AllInPay", "pay", dataArray);
    }
};
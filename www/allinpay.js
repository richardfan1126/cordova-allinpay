/*global cordova, module*/

module.exports = {
    pay: function (amount, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "AllInPay", "pay", [amount]);
    }
};

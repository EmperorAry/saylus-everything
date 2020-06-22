package com.example.jinx

import androidx.annotation.NonNull;
import android.telephony.SmsManager;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.saylus/sendsms"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if(call.method == "sendSMS")
            {
                val number : String? = call.argument("number");
                val message : String? = call.argument("message");
                var smsManager = SmsManager.getDefault() as SmsManager;
                smsManager.sendTextMessage(number, null, message, null, null);
                result.success(null);
            }else{
                result.notImplemented();
            }
        }
    }
}

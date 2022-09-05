package com.example.flutter_training

import android.R
import android.app.AlertDialog
import android.util.Log
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity() {

    var builder: AlertDialog.Builder? = null

    private val CHANNEL = "flutter.native/helper"

    //    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//        GeneratedPluginRegistrant.registerWith(this)
//        MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
//            object : MethodCallHandler() {
//                fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
//                    if (call.method.equals("helloFromNativeCode")) {
//    val greetings = helloFromNativeCode()
//    result.success(greetings)
//                    }
//                }
//            })
//
//    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

            when (call.method) {
                "getValue" -> {
                    val text = call.argument<String>("text")
                    val greetings = helloFromNativeCode(text = text).toString()
                    result.success(greetings)
                }
                "printLog" -> {
                    Log.d("TAG", "message call method channel")
                }
                "openDialog" -> {
                    showDefaultDialog()
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun showDefaultDialog() {
        builder = AlertDialog.Builder(this@MainActivity)
        builder?.setTitle("Alert Dialog")
        builder?.setMessage("Do you want to close this application ?")
            ?.setCancelable(false)
            ?.setPositiveButton("Yes") { dialog, id ->
                finish()
                Toast.makeText(
                    this@MainActivity, "you choose yes action",
                    Toast.LENGTH_SHORT
                ).show()
            }
            ?.setNegativeButton(
                "No"
            ) { dialog, id ->
                dialog.cancel()
                Toast.makeText(
                    this@MainActivity, "you choose no action",
                    Toast.LENGTH_SHORT
                ).show()
            }
        val alert: AlertDialog = builder!!.create()
        alert.show()
    }

    private fun helloFromNativeCode(text: String?): Int {
        var t = text!!.toInt()
        t++
        return t
    }
}


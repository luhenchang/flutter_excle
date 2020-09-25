package com.example.flutter_excle

import android.content.Context
import android.os.Environment
import com.example.flutter_excle.excle.ExcelUtil
import com.example.flutter_excle.excle.ShareUtils
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.io.File

/**
 *
 *
 *@auther Create By fei wang on 2020/9/22
 */
/**
 * Platform implementation of the permission_handler Flutter plugin.
 *
 *
 * Instantiate this in an add to app scenario to gracefully handle activity and context changes.
 * See `com.example.permissionhandlerexample.MainActivity` for an example.
 *
 *
 * Call [.registerWith] to register an implementation of this that uses the
 * stable `io.flutter.plugin.common` package.
 */
@Suppress("UNCHECKED_CAST")
class ExclePlugin : FlutterPlugin, ActivityAware, MethodCallHandler {
    private var binding: ActivityPluginBinding? = null
    override fun onAttachedToEngine(binding: FlutterPluginBinding) {
        startListening(
                binding.applicationContext,
                binding.binaryMessenger
        )
    }

    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
        stopListening()
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.binding = binding
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivity() {

    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }


    private fun startListening(applicationContext: Context, messenger: BinaryMessenger) {
        methodChannel = MethodChannel(messenger, "flutter.com.example.flutterosm/excle_plugin/methods")
        methodChannel.setMethodCallHandler(this);
    }

    private fun stopListening() {
        methodChannel.setMethodCallHandler(null)
    }

    var moudleFile: File? = null
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "excle_info" -> {
                moudleFile = null
                val mapInfor = call.arguments as Map<*, *>
                val excelName = mapInfor["excle_name"].toString()
                val sheetName = mapInfor["sheetName"].toString()
                val title_list = mapInfor["title_list"] as ArrayList<String>
                val all_list = mapInfor["list_string"] as ArrayList<ArrayList<Map<String, String>>>
                val fileName = mapInfor["fileName"].toString()
                val title_sheet = mapInfor["title_sheet"] as ArrayList<Map<String, Any?>>


                val filePath = (Environment.getExternalStorageDirectory().absolutePath + "/bhne/")
                val files = File(filePath)
                if (!files.exists()) {
                    files.mkdirs()
                }
                val excelFileName = "/$fileName.xls"
                val resultPath = files.absolutePath + excelFileName
                //region 设置Excle的头布局内容
                //endregion
                ExcelUtil.initExcel(excelName, sheetName, resultPath, title_list.toTypedArray(), mapInfor["headerCellFormat"] as Map<String, Any?>, mapInfor["bodyCellFormat"] as Map<String, Any?>, mapInfor["otherHeader"] as List<Map<String, Any?>>, all_list, title_sheet)
                moudleFile = ExcelUtil.writeObjListToExcel(all_list, resultPath, binding!!.activity)!!
                ShareUtils.shareFile(binding!!.activity, moudleFile)
            }

        }
    }

    companion object {
        private lateinit var methodChannel: MethodChannel

        fun registerWith(registrar: Registrar) {
            methodChannel = MethodChannel(registrar.messenger(), "flutter.com.example.flutterosm/excle_plugin/methods")
            val instance = ExclePlugin()
            methodChannel.setMethodCallHandler(instance)

        }
    }


}
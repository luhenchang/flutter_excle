package com.example.flutter_excle

import android.os.Environment
import androidx.annotation.NonNull;
import com.example.flutter_excle.excle.ExcelUtil
import com.example.flutter_excle.excle.ShareUtils

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.io.File

/** FlutterExclePlugin */
public class FlutterExclePlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private var binding: ActivityPluginBinding? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_excle")
        channel.setMethodCallHandler(this);
    }

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "flutter_excle")
            channel.setMethodCallHandler(FlutterExclePlugin())
        }
    }

    var moudleFile: File? = null
    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
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

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onDetachedFromActivity() {

    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.binding = binding
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }
}

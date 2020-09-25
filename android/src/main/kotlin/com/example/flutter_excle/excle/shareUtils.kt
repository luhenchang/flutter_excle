package com.example.flutter_excle.excle

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import androidx.core.content.FileProvider
import java.io.File

/**
 *
 *
 *@auther Create By fei wang on 2020/9/22
 */
object ShareUtils {
    private const val COM_ZJ_OSM_FILEPROVIDER = "com.example.flutter_excle.fileprovider"
    private const val TEXT_PLAIN = "text/plain"

    /**
     * 分享文件到第三方软件
     *
     * @param file 文件
     */
    fun shareFile(context: Context?, file: File?) {
        if (context == null) {
            throw NullPointerException("上下文不能为空")
        }
        if (file == null) {
            throw NullPointerException("分享文件不能为空")
        }
        val shareIntent = Intent()
        shareIntent.action = Intent.ACTION_SEND
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            //做一些处理
            shareIntent.putExtra(Intent.EXTRA_STREAM, FileProvider.getUriForFile(context, COM_ZJ_OSM_FILEPROVIDER, file))
        } else {
            //在版本低于此的时候，做一些处理
            shareIntent.putExtra(Intent.EXTRA_STREAM, Uri.fromFile(file))
        }
        shareIntent.type = TEXT_PLAIN
        //设置分享列表的标题，并且每次都显示分享列表
        context.startActivity(Intent.createChooser(shareIntent, "分享勘测文件到"))
    }
}
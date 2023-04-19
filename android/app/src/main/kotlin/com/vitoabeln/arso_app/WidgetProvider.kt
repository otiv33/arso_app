package com.vitoabeln.arso_app

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.content.res.AssetManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Build
import android.util.TypedValue
import android.widget.RemoteViews
import com.android.volley.Request
import com.android.volley.Response
import com.android.volley.toolbox.StringRequest
import com.android.volley.toolbox.Volley
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider
import io.flutter.FlutterInjector
import io.flutter.embedding.engine.loader.FlutterLoader
import org.json.JSONArray
import org.json.JSONObject
import org.json.JSONTokener
import java.io.InputStream
import java.time.ZonedDateTime


class HomeScreenWidgetProvider : HomeWidgetProvider() {
    fun load_image(icon_name: String, loader: FlutterLoader, assetManager: AssetManager): Bitmap? {
        val key = loader.getLookupKeyForAsset("assets/icons/"+icon_name+".png")
        val inputStream: InputStream = assetManager.open(key)
        return BitmapFactory.decodeStream(inputStream)
    }

    fun format_time(hour: String): String {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            // Slovenia +2h UTC
            return ZonedDateTime.parse(hour).plusHours(2).toLocalTime().toString()
        } else {
            return hour.split("([0-1][0-9]|2[0-3]):[0-5][0-9]")[0]
        };
    }


     override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_layout)
            // Open App on Widget Click
            val pendingIntent = HomeWidgetLaunchIntent.getActivity(context,
                MainActivity::class.java)
            views.setOnClickPendingIntent(R.id.widget_root, pendingIntent)

            // Get city
            val city: String = widgetData.getString("_city", "None") as String
            if(city != "None"){

                // Letališče Jožeta Pučnika Ljubljana -> Max 34 characters
                // Šmartno pri Slovenj Gradcu -> 26
                // Letališče Cerklje ob Krki -> 25
                // Letališče Portorož -> 18
                val cCount: Int = city.length
                if(cCount < 20){
                    views.setTextViewTextSize(R.id.tv_city, TypedValue.COMPLEX_UNIT_SP, 16.0F)
                }else{
                    if (cCount < 25){
                        views.setTextViewTextSize(R.id.tv_city, TypedValue.COMPLEX_UNIT_SP, 14.0F)
                    }else{
                        if (cCount < 30){
                            views.setTextViewTextSize(R.id.tv_city, TypedValue.COMPLEX_UNIT_SP, 12.0F)
                        }else{
                            views.setTextViewTextSize(R.id.tv_city, TypedValue.COMPLEX_UNIT_SP, 10.0F)
                        }
                    }
                }



                views.setTextViewText(R.id.tv_city, city)

                val queue = Volley.newRequestQueue(context)
                val url = "https://vreme.arso.gov.si/api/1.0/location/?location=" + city
                val stringRequest = StringRequest(Request.Method.GET, url,
                    Response.Listener<String> { response ->
                        val jsonObject = JSONTokener(response).nextValue() as JSONObject
                        val loader = FlutterInjector.instance().flutterLoader()
                        val assetManager: AssetManager = context.getAssets()


                        // Current
                        val observation = ((((((((jsonObject["observation"] as JSONObject)["features"]) as JSONArray)[0] as JSONObject)["properties"] as JSONObject)["days"] as JSONArray)[0] as JSONObject)["timeline"] as JSONArray)[0] as JSONObject
                        val current_temp = observation["t"] as String + " °C"
                        views.setTextViewText(R.id.tv_temp_now, current_temp)

                        val current_icon = observation["clouds_icon_wwsyn_icon"] as String
                        val b_current_icon = this.load_image(current_icon, loader, assetManager) as Bitmap
                        views.setImageViewBitmap(R.id.i_weather_current, b_current_icon)

                        // Hour1
                        val hour = (((((((jsonObject["forecast1h"] as JSONObject)["features"]) as JSONArray)[0] as JSONObject)["properties"] as JSONObject)["days"] as JSONArray)[0] as JSONObject)["timeline"] as JSONArray
                        val hour1_temp = (hour[0] as JSONObject)["t"] as String + " °C"
                        views.setTextViewText(R.id.tv_temp_hour1, hour1_temp)

                        val hour1 = (hour[0] as JSONObject)["valid"] as String
                        views.setTextViewText(R.id.tv_hour1, this.format_time(hour1))


                        val hour1_icon = (hour[0] as JSONObject)["clouds_icon_wwsyn_icon"] as String
                        val b_hour1_icon = this.load_image(hour1_icon, loader, assetManager) as Bitmap
                        views.setImageViewBitmap(R.id.i_hour1, b_hour1_icon)

                        // Hour2
                        val hour2_temp = (hour[1] as JSONObject)["t"] as String + " °C"
                        views.setTextViewText(R.id.tv_temp_hour2, hour2_temp)

                        val hour2 = (hour[1] as JSONObject)["valid"] as String
                        views.setTextViewText(R.id.tv_hour2, this.format_time(hour2))

                        val hour2_icon = (hour[1] as JSONObject)["clouds_icon_wwsyn_icon"] as String
                        val b_hour2_icon = this.load_image(hour2_icon, loader, assetManager) as Bitmap
                        views.setImageViewBitmap(R.id.i_hour2, b_hour2_icon)

                        // Hour3
                        val hour3_temp = (hour[1] as JSONObject)["t"] as String + " °C"
                        views.setTextViewText(R.id.tv_temp_hour3, hour3_temp)

                        val hour3 = (hour[1] as JSONObject)["valid"] as String
                        views.setTextViewText(R.id.tv_hour3, this.format_time(hour3))

                        val hour3_icon = (hour[1] as JSONObject)["clouds_icon_wwsyn_icon"] as String
                        val b_hour3_icon = this.load_image(hour3_icon, loader, assetManager) as Bitmap
                        views.setImageViewBitmap(R.id.i_hour3, b_hour3_icon)

                        // TODO MIDNIGHT TIME !!!

                        // // Hour4
                        // val hour4_temp = (hour[1] as JSONObject)["t"] as String + " °C"
                        // views.setTextViewText(R.id.tv_temp_hour4, hour4_temp)

                        // val hour4 = (hour[1] as JSONObject)["valid"] as String
                        // views.setTextViewText(R.id.tv_hour4, this.format_time(hour4))

                        // val hour4_icon = (hour[1] as JSONObject)["clouds_icon_wwsyn_icon"] as String
                        // val b_hour4_icon = this.load_image(hour4_icon, loader, assetManager) as Bitmap
                        // views.setImageViewBitmap(R.id.i_hour4, b_hour4_icon)

                        appWidgetManager.updateAppWidget(widgetId, views)
                    },
                    Response.ErrorListener {
                        appWidgetManager.updateAppWidget(widgetId, views)
                    })
                queue.add(stringRequest)
            }

        }


    }
}
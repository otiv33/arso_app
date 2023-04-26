package com.vitoabeln.arsovreme

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.content.res.AssetManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Build
import android.util.TypedValue
import android.widget.RemoteViews
import androidx.annotation.RequiresApi
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
import java.time.LocalDate
import java.time.LocalDateTime
import java.time.ZonedDateTime


class HomeScreenWidgetProvider : HomeWidgetProvider() {
    fun load_image(icon_name: String, loader: FlutterLoader, assetManager: AssetManager): Bitmap? {
        var key = "";
        try {
            key = loader.getLookupKeyForAsset("assets/icons/"+icon_name+".png")
        }catch (e: Exception){
            key = "flutter_assets/assets/icons/"+icon_name+".png"
        }
        val inputStream: InputStream = assetManager.open(key)
        return BitmapFactory.decodeStream(inputStream)
    }

    fun format_time(hourToday: String): String {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            // Slovenia +2h UTC
            return ZonedDateTime.parse(hourToday).plusHours(2).toLocalTime().toString()
        } else {
            return hourToday.split("([0-1][0-9]|2[0-3]):[0-5][0-9]")[0]
        };
    }

    override fun onReceive(context: Context?, intent: Intent?) {
        print(intent.toString())
        super.onReceive(context, intent)
    }

     @RequiresApi(Build.VERSION_CODES.O)
     override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_layout)
            // Open App on Widget Click
            val pendingIntent = HomeWidgetLaunchIntent.getActivity(context,
                MainActivity::class.java)
            views.setOnClickPendingIntent(R.id.widget_root, pendingIntent)

            // Get city
            var city: String = widgetData.getString("_city", "None") as String
            if(city == "None"){
                val loader = FlutterInjector.instance().flutterLoader()
                val key = loader.getLookupKeyForAsset("assets/data/localData.json")
                val res: String = context.getAssets().open(key).readBytes().toString(Charsets.UTF_8)
                val jsonObject = JSONTokener(res).nextValue() as JSONObject
                city = jsonObject["cityName"].toString()
            }

            val cCount: Int = city.length
            var textSize: Float = 0.0F

            if (cCount < 9)
                textSize = 12.0F
            else
                if (cCount < 30)
                    textSize = 11.0F
                else
                    textSize = 10.0F
            views.setTextViewTextSize(R.id.tv_city, TypedValue.COMPLEX_UNIT_SP, textSize)
            views.setTextViewText(R.id.tv_city, city)

            val queue = Volley.newRequestQueue(context)
            val url = "https://vreme.arso.gov.si/api/1.0/location/?location=" + city
            val stringRequest = StringRequest(Request.Method.GET, url,
                Response.Listener<String> { response ->
                    try {
                        val jsonObject = JSONTokener(response).nextValue() as JSONObject
                        val loader = FlutterInjector.instance().flutterLoader()
                        val assetManager: AssetManager = context.getAssets()

                        try {
                            // Current
                            val observation = ((((((((jsonObject["observation"] as JSONObject)["features"]) as JSONArray)[0] as JSONObject)["properties"] as JSONObject)["days"] as JSONArray)[0] as JSONObject)["timeline"] as JSONArray)[0] as JSONObject
                            val current_temp = observation["t"] as String + " °C"
                            // val current_temp = LocalDateTime.now().toString().substring(11)
                            views.setTextViewText(R.id.tv_temp_now, current_temp)

                            val current_icon = observation["clouds_icon_wwsyn_icon"] as String
                            val b_current_icon = this.load_image(current_icon, loader, assetManager) as Bitmap
                            views.setImageViewBitmap(R.id.i_weather_current, b_current_icon)
                        }catch (e: Exception){
                            print(e)
                        }

                        try {
                            // Hour
                            val days = ((((((jsonObject["forecast1h"] as JSONObject)["features"]) as JSONArray)[0] as JSONObject)["properties"] as JSONObject)["days"] as JSONArray)
                            val hourToday = (days[0] as JSONObject)["timeline"] as JSONArray

                            try {
                                // Hour +1
                                var hour1 = hourToday.opt(0)
                                if (hour1 != null){
                                    hour1 = hour1 as JSONObject
                                }else{
                                    hour1 = ((days[1] as JSONObject)["timeline"] as JSONArray).get(0) as JSONObject
                                }
                                val hour1_temp = hour1["t"] as String + " °C"
                                views.setTextViewText(R.id.tv_temp_hour1, hour1_temp)

                                val hour1_time = hour1["valid"] as String
                                views.setTextViewText(R.id.tv_hour1, this.format_time(hour1_time))

                                val hour1_icon = hour1["clouds_icon_wwsyn_icon"] as String
                                val b_hour1_icon = this.load_image(hour1_icon, loader, assetManager) as Bitmap
                                views.setImageViewBitmap(R.id.i_hour1, b_hour1_icon)
                            }catch (e: Exception){
                                print(e)
                            }

                            try {
                                // Hour +3
                                var hour2 = hourToday.opt(2)
                                if (hour2 != null){
                                    hour2 = hour2 as JSONObject
                                }else{
                                    hour2 = ((days[1] as JSONObject)["timeline"] as JSONArray).get(2) as JSONObject
                                }
                                val hour2_temp = hour2["t"] as String + " °C"
                                views.setTextViewText(R.id.tv_temp_hour2, hour2_temp)

                                val hour2_time = hour2["valid"] as String
                                views.setTextViewText(R.id.tv_hour2, this.format_time(hour2_time))

                                val hour2_icon = hour2["clouds_icon_wwsyn_icon"] as String
                                val b_hour2_icon = this.load_image(hour2_icon, loader, assetManager) as Bitmap
                                views.setImageViewBitmap(R.id.i_hour2, b_hour2_icon)
                            }catch (e: Exception){
                                print(e)
                            }

                            try {
                                // Hour +5
                                var hour3 = hourToday.opt(4)
                                if (hour3 != null){
                                    hour3 = hour3 as JSONObject
                                }else{
                                    hour3 = ((days[1] as JSONObject)["timeline"] as JSONArray).get(4) as JSONObject
                                }
                                val hour3_temp = hour3["t"] as String + " °C"
                                views.setTextViewText(R.id.tv_temp_hour3, hour3_temp)

                                val hour3_time = hour3["valid"] as String
                                views.setTextViewText(R.id.tv_hour3, this.format_time(hour3_time))

                                val hour3_icon = hour3["clouds_icon_wwsyn_icon"] as String
                                val b_hour3_icon = this.load_image(hour3_icon, loader, assetManager) as Bitmap
                                views.setImageViewBitmap(R.id.i_hour3, b_hour3_icon)
                            }catch (e: Exception){
                                print(e)
                            }
                        }catch (e: Exception){
                            print(e)
                        }

                    }catch (e: Exception){
                        print(e)
                    }
                    appWidgetManager.updateAppWidget(widgetId, views)
                },
                Response.ErrorListener { error ->
                    views.setTextViewText(R.id.tv_city, "No internet")
                    views.setTextViewText(R.id.tv_temp_now, "/ °C")
                    views.setTextViewText(R.id.tv_temp_hour1, "/ °C")
                    views.setTextViewText(R.id.tv_temp_hour2, "/ °C")
                    views.setTextViewText(R.id.tv_temp_hour3, "/ °C")

                    views.setTextViewText(R.id.tv_hour1, "+1h")
                    views.setTextViewText(R.id.tv_hour2, "+3h")
                    views.setTextViewText(R.id.tv_hour3, "+5h")

                    val loader = FlutterInjector.instance().flutterLoader()
                    val assetManager: AssetManager = context.getAssets()

                    val no_icon = this.load_image("no_icon", loader, assetManager) as Bitmap
                    views.setImageViewBitmap(R.id.i_weather_current, no_icon)
                    views.setImageViewBitmap(R.id.i_hour1, no_icon)
                    views.setImageViewBitmap(R.id.i_hour2, no_icon)
                    views.setImageViewBitmap(R.id.i_hour3, no_icon)
                    appWidgetManager.updateAppWidget(widgetId, views)
                })
            queue.add(stringRequest)
        }
    }
}
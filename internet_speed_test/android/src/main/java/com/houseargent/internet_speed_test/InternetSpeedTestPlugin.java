package com.houseargent.internet_speed_test;

import androidx.annotation.NonNull;

import com.houseargent.core.Speedtest;
import android.os.Handler;
import android.os.Looper;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import com.houseargent.core.serverSelector.TestPoint;
import com.houseargent.speedtest.core.NetworkTool;
import org.json.JSONException;
import org.json.JSONObject;

/** InternetSpeedTestPlugin */
public class InternetSpeedTestPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private String CHANNEL = "com.houseargent.speedtest";
  Speedtest speedtest = new Speedtest();
  NetworkTool networkTool= new NetworkTool();
  MethodChannel methodChannel;
  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    methodChannel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "internet_speed_test");
    methodChannel.setMethodCallHandler(this);
    networkTool.serverSelectedHandler= new Speedtest.ServerSelectedHandler() {
      @Override
      public void onServerSelected(TestPoint server) {
        System.out.println(server.getName());
        speedtest.setSelectedServer(server);
        speedtest.start(speedtestHandler);

        //speedtest.addTestPoint(server);
        // networkTool.page_init();


      }
    };

  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
   
    switch (call.method){
      case "startSpeedTest":
        networkTool.page_init();
        //networkTool.page_init();
        break;

      case "stopSpeedTest":
        speedtest.abort();
        //networkTool.page_init();
        break;
      case "getPlatformVersion":
      //networkTool.page_init();

        result.success("Android helo  hhh " + android.os.Build.VERSION.RELEASE);
        break;


    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  Speedtest.SpeedtestHandler speedtestHandler = new Speedtest.SpeedtestHandler() {
    @Override
    public void onDownloadUpdate(double dl, double progress) {
      JSONObject jsonObject=new JSONObject();
      try {
        jsonObject.put("download",dl);
        jsonObject.put("progress",progress);


      } catch (JSONException e) {
        e.printStackTrace();
      }
      new Handler(Looper.getMainLooper()).post(new Runnable() {
        @Override
        public void run() {
          methodChannel.invokeMethod("onDownloadUpdate",jsonObject.toString());
          // System.out.println("onDownloadUpdate " + dl + " progress " + progress);


        }
      });

//           System.out.println("onDownloadUpdate " + dl + " progress " + progress);

    }

    @Override
    public void onUploadUpdate(double ul, double progress) {
      JSONObject jsonObject=new JSONObject();
      try {
        jsonObject.put("upload",ul);
        jsonObject.put("progress",progress);


      } catch (JSONException e) {
        e.printStackTrace();
      }
      new Handler(Looper.getMainLooper()).post(new Runnable() {
        @Override
        public void run() {
          methodChannel.invokeMethod("onUploadUpdate",jsonObject.toString());

        }
      });

//            System.out.println("onUploadUpdate " + ul + " progress " + progress);

    }

    @Override
    public void onPingJitterUpdate(double ping, double jitter, double progress) {
      JSONObject jsonObject=new JSONObject();
      try {
        jsonObject.put("ping",ping);
        jsonObject.put("jitter",jitter);
        jsonObject.put("progress",progress);


      } catch (JSONException e) {
        e.printStackTrace();
      }
      new Handler(Looper.getMainLooper()).post(new Runnable() {
        @Override
        public void run() {
          methodChannel.invokeMethod("onPingJitterUpdate",jsonObject.toString());

        }
      });

//            System.out.println("onPingJitterUpdate " + ping + " jitter " + jitter + " + progress " + progress);

    }

    @Override
    public void onIPInfoUpdate(String ipInfo) {
      JSONObject jsonObject=new JSONObject();
      try {
        jsonObject.put("ipInfo",ipInfo);



      } catch (JSONException e) {
        e.printStackTrace();
      }
      new Handler(Looper.getMainLooper()).post(new Runnable() {
        @Override
        public void run() {
          methodChannel.invokeMethod("onIPInfoUpdate",jsonObject.toString());

        }
      });

//            System.out.println("onIPInfoUpdate " + ipInfo);

    }

    @Override
    public void onTestIDReceived(String id, String shareURL) {
      JSONObject jsonObject=new JSONObject();
      try {
        jsonObject.put("id",id);
        jsonObject.put("shareUr",shareURL);



      } catch (JSONException e) {
        e.printStackTrace();
      }
      new Handler(Looper.getMainLooper()).post(new Runnable() {
        @Override
        public void run() {
          methodChannel.invokeMethod("onTestIDReceived",jsonObject.toString());

        }
      });

//            System.out.println("onTestIDReceived " + id + " progress " + shareURL);

    }

    @Override
    public void onEnd() {
      JSONObject jsonObject=new JSONObject();
      try {
        jsonObject.put("end","end");



      } catch (JSONException e) {
        e.printStackTrace();
      }
      new Handler(Looper.getMainLooper()).post(new Runnable() {
        @Override
        public void run() {
          methodChannel.invokeMethod("onEnd",jsonObject.toString());

        }
      });

//            System.out.println("onEnd");

    }

    @Override
    public void onCriticalFailure(String err) {
      JSONObject jsonObject=new JSONObject();
      try {
        jsonObject.put("error",err);



      } catch (JSONException e) {
        e.printStackTrace();
      }
      new Handler(Looper.getMainLooper()).post(new Runnable() {
        @Override
        public void run() {
          methodChannel.invokeMethod("onCriticalFailure",jsonObject.toString());

        }
      });

//            System.out.println("onCriticalFailure " + err + " progress");

    }
  };

  class ServerHandler extends Speedtest.ServerSelectedHandler {
    Speedtest.SpeedtestHandler speedtestHandler;

    ServerHandler(Speedtest.SpeedtestHandler speedtestHandler) {
      this.speedtestHandler = speedtestHandler;
    }

    @Override
    public void onServerSelected(TestPoint server) {
      System.out.println(server.getServer());
      speedtest.setSelectedServer(server);
      speedtest.start(speedtestHandler);

    }
  }
}

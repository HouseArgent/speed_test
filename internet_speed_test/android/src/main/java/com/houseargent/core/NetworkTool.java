package com.houseargent.speedtest.core;


import com.houseargent.core.Speedtest;
import com.houseargent.core.config.SpeedtestConfig;
import com.houseargent.core.config.TelemetryConfig;
import com.houseargent.core.log.Logger;
import com.houseargent.core.serverSelector.TestPoint;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.*;
import java.util.ArrayList;

public class NetworkTool {
    Logger logger= new Logger();
    Speedtest.SpeedtestHandler speedtestHandler;
    public Speedtest.ServerSelectedHandler serverSelectedHandler;
    private  Speedtest st=null;
    SpeedtestConfig config=null;
    TelemetryConfig telemetryConfig=null;
    ArrayList<TestPoint> servers=new ArrayList<>();



    private void page_serverSelect(TestPoint selected, TestPoint[] servers){


    }


    private String readFileFromAssets(String name) throws Exception{
        InputStream is = getClass().getClassLoader().getResourceAsStream(name);

        BufferedReader b=new BufferedReader(new InputStreamReader(is));
        String ret="";
        try{
            for(;;){
                String s=b.readLine();
                if(s==null) break;
                ret+=s;
            }
        }catch(EOFException e){}
        return ret;
    }
    public void page_init(){
        new Thread(() -> {
            try{

                String c=readFileFromAssets("SpeedtestConfig.json");
                JSONObject o=new JSONObject(c);
                config=new SpeedtestConfig(o);
                c=readFileFromAssets("TelemetryConfig.json");
                o=new JSONObject(c);

                telemetryConfig=new TelemetryConfig(o);
                if(st!=null){
                    try{st.abort();}catch (Throwable e){
                        System.out.println(e.getCause());

                    }
                }
                this.st=new Speedtest();
                this.st.setSpeedtestConfig(config);
                this.st.setTelemetryConfig(telemetryConfig);
                c=readFileFromAssets("ServerList.json");

                if(c.startsWith("\"")||c.startsWith("'")){ //fetch server list from URL
                    if(!st.loadServerList(c.subSequence(1,c.length()-1).toString())){
                        throw new Exception("Failed to load server list");
                    }

                }else{ //use provided server list
                    JSONArray a=new JSONArray(c);
                    if(a.length()==0) throw new Exception("No test points");
                    ArrayList<TestPoint> s=new ArrayList<>();
                    for(int i=0;i<a.length();i++) s.add(new TestPoint(a.getJSONObject(i)));
                    servers=s;

                    st.addTestPoints(servers);
                }
                final String testOrder=config.getTest_order();
                System.out.println("test server up");
            }catch (final Throwable e){
                System.out.println("This is the first app");
                System.out.println(e.getCause());
                st=null;
            }
            if(st!=null){
                System.out.println("server selected handler "+st.toString());

                st.selectServer(serverSelectedHandler);
            }else{
            
            }
            
        }).start();
    }

}

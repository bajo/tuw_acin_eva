/*
 * Copyright (C) 2011 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */

package org.ros.android.tuw_eva;

import org.ros.address.InetAddressFactory;
import org.ros.android.MessageCallable;
import org.ros.android.RosActivity;
import org.ros.android.view.RosTextView;
import org.ros.node.NodeConfiguration;
import org.ros.node.NodeMainExecutor;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.RadioButton;

import com.nuance.nmdp.speechkit.SpeechKit;


/**
 * @author markus.bajones@gmail.com (Markus Bajones) 
 */
public class MainActivity extends RosActivity {

  private RosTextView<std_msgs.String> rosTextView;
  private static Talker talker;  
  private static SpeechKit speechKit;
  private static String language;
  
  // Allow other activities to access the SpeechKit instance.
  static SpeechKit getSpeechKit()
  {
      return speechKit;
  }
  
  public static Talker getTalker() {
	return talker;
}

public MainActivity() {
    // The RosActivity constructor configures the notification title and ticker
    // messages.
    super("TU Wien-Eva", "TU Wien-Eva");

  }

  @SuppressWarnings({ "unchecked", "deprecation" })
  @Override
  public void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.main);    
    rosTextView = (RosTextView<std_msgs.String>) findViewById(R.id.text);
    rosTextView.setTopicName("/tuw_eva/voice_commands");
    rosTextView.setMessageType(std_msgs.String._TYPE);
    rosTextView.setMessageToStringCallable(new MessageCallable<String, std_msgs.String>() {
      @Override
      public String call(std_msgs.String message) {
        return message.getData();
      }
    });
    
    // Default language is german (deutsch)
    // you can switch to english if you wish
    // language = "english";
    language = "deutsch";
    
    // If this Activity is being recreated due to a config change (e.g. 
    // screen rotation), check for the saved SpeechKit instance.
    speechKit = (SpeechKit)getLastNonConfigurationInstance();
    if (speechKit == null)
    {
        speechKit = SpeechKit.initialize(getApplication().getApplicationContext(), AppInfo.SpeechKitAppId, AppInfo.SpeechKitServer, AppInfo.SpeechKitPort, AppInfo.SpeechKitSsl, AppInfo.SpeechKitApplicationKey);
        speechKit.connect();
    }   
  }
  
  public void startDictation(View view) {
	    Intent intent = new Intent(this, DictationActivity.class);
	    startActivity(intent);
	}
  
  public void onRadioButtonClicked(View view) {
	    // Is the button now checked?
	    boolean checked = ((RadioButton) view).isChecked();
	    
	    // Check which radio button was clicked
	    switch(view.getId()) {
	        case R.id.radio_english:
	            if (checked)
	                language = "english";
	            break;
	        case R.id.radio_german:
	            if (checked)
	            	language = "deutsch";
	            break;	        
	    }
	}

  public static String getLanguage() {
	return language;
  }
   
  public static void setLanguage(String language) {
	  MainActivity.language = language;
  }
 
@Override
  protected void init(NodeMainExecutor nodeMainExecutor) {
    talker = new Talker();
    NodeConfiguration nodeConfiguration = NodeConfiguration.newPublic(InetAddressFactory.newNonLoopback().getHostAddress());;
    // At this point, the user has already been prompted to either enter the URI
    // of a master to use or to start a master locally.
    nodeConfiguration.setMasterUri(getMasterUri());
    nodeMainExecutor.execute(talker, nodeConfiguration);
    // The RosTextView is also a NodeMain that must be executed in order to
    // start displaying incoming messages.
    nodeMainExecutor.execute(rosTextView, nodeConfiguration);
  }
}

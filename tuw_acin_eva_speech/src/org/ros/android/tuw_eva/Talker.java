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

import org.ros.concurrent.CancellableLoop;
import org.ros.namespace.GraphName;
import org.ros.node.AbstractNodeMain;
import org.ros.node.ConnectedNode;
import org.ros.node.NodeMain;
import org.ros.node.topic.Publisher;

/**
 * A simple {@link Publisher} {@link NodeMain}.
 * 
 * @author damonkohler@google.com (Damon Kohler)
 */
public class Talker extends AbstractNodeMain {
	private String message = null;
	private String language_code = null;
	

  public void setLanguage_code(String language_code) {
		this.language_code = language_code;
	}

  public void setMessage(String message) {
		this.message = message;
	}

@Override
  public GraphName getDefaultNodeName() {
    return GraphName.of("rosjava_tutorial_pubsub/talker");
  }

  @Override
  public void onStart(final ConnectedNode connectedNode) {
	message = "No commands received yet";
    final Publisher<std_msgs.String> publisher =
        connectedNode.newPublisher("/tuw_eva/voice_commands", std_msgs.String._TYPE);
    // This CancellableLoop will be canceled automatically when the node shuts
    // down.
    connectedNode.executeCancellableLoop(new CancellableLoop() {
      private int sequenceNumber;

      @Override
      protected void setup() {
        sequenceNumber = 0;
      }

      @Override
      protected void loop() throws InterruptedException {
        std_msgs.String str = publisher.newMessage();
        str.setData(language_code+","+message+","+ sequenceNumber);
        publisher.publish(str);
        sequenceNumber++;
        Thread.sleep(1000);
      }
    });
  }
}

#! /usr/bin/env python

import roslib; roslib.load_manifest('tuw_acin_eva_people')
import rospy

# Brings in the SimpleActionClient
import actionlib

# Brings in the messages used by the DoHeadMove action, including the
# goal message and the result message.
import tuw_acin_eva_people.msg

def headmove_client():
    # Creates the SimpleActionClient, passing the type of the action
    # (DoHeadMoveAction) to the constructor.
    client = actionlib.SimpleActionClient('Eva_head_mover', tuw_acin_eva_people.msg.DoHeadMoveAction)

    print "waiting for server"
    # Waits until the action server has started up and started
    # listening for goals.
    client.wait_for_server()

    print "got server"
    # Creates a goal to send to the action server.
    goal = tuw_acin_eva_people.msg.DoHeadMoveGoal([-5,-10]) 
    print "sent goal to server"

    # Sends the goal to the action server.
    client.send_goal(goal)

    # Waits for the server to finish performing the action.
    client.wait_for_result()

    # Prints out the result of executing the action
    return client.get_result()  # Position Reached Result 

if __name__ == '__main__':
    try:
        # Initializes a rospy node so that the SimpleActionClient can
        # publish and subscribe over ROS.
        rospy.init_node('headmove_client')
        result = headmove_client()
	print type(result)
	if result.pos_reached: print "Success"
    except rospy.ROSInterruptException:
        print "program interrupted before completion"

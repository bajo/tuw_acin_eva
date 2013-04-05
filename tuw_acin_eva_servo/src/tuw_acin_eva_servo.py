#!/usr/bin/env python

import roslib; roslib.load_manifest('tuw_acin_eva')
import rospy
from phidgets.msg import servo_params #@UnresolvedImport
from phidgets.srv import servo_reference #@UnresolvedImport
from tuw_acin_eva_servo.msg import *

class SERVO_CONTROLLER:
    """
    Controlls Servos
    """
    
    # degrees of freedom:
    # pan: schwenken (Kopf schuetteln)
    # tilt: kippen (nicken)
    
    # index numbers of servos
    PAN_IDX = 0
    TILT_IDX = 1

    # range for pan values
    PAN_CENTER = 125.0
    PAN_LOWER = 29.0
    PAN_UPPER = 211.0
    PAN_DEF_SPEED = 20.0
    
    # range for tilt values
    TILT_CENTER = 125.0
    TILT_LOWER = 100.0
    TILT_UPPER = 155.0 
    TILT_DEF_SPEED = 20.0
    
    # states
    TSK_STOP = 0
    TSK_MOVE = 1
    TSK_POS = 2
    
    # multipliers
    MULT_PAN_ANGLE = 18.5/20.0
    MULT_TILT_ANGLE = -26.0/20.0
    MULT_PAN_SPEED = 1.0
    MULT_TILT_SPEED = -1.0
    
    # set attributes to their defaults 
    current_task = TSK_POS
    pan_pos = 0 #PAN_CENTER
    tilt_pos = 0 #TILT_CENTER
    pan_speed = PAN_DEF_SPEED
    tilt_speed = TILT_DEF_SPEED
    
    servo_ref = None
    error = False;
    
    # actual positions (servo driver values)
    act_pan_pos = PAN_CENTER
    act_tilt_pos = TILT_CENTER
                         
    def __init__ (self):
        return
    
    def servo_pos_callback(self, data):
        if (data.index == self.PAN_IDX):
            self.act_pan_pos = data.position
        elif (data.index == self.TILT_IDX):
            self.act_tilt_pos = data.position

    def handle_speed_service(self, req):
        rospy.loginfo("Set servo speed to [pan=%i, tilt=%i]", req.pan_speed, req.tilt_speed)
        #set new task
        if req.pan_speed==0 and req.tilt_speed==0: self.current_task = self.TSK_STOP
        else: self.current_task = self.TSK_MOVE
        #set new speeds
        self.pan_speed = req.pan_speed
        self.tilt_speed = req.tilt_speed
        return True
        
    def handle_pos_service(self, req):
        rospy.loginfo("Set servo position to [pan=%s, tilt=%s]", req.pan_angle, req.tilt_angle)
        #set new task
        self.current_task = self.TSK_POS
        #set new position
        self.pan_pos = req.pan_angle
        self.tilt_pos = req.tilt_angle
        #set new speeds
        self.pan_speed = req.pan_speed
        self.tilt_speed = req.tilt_speed
        return True
    
    def handle_actpos_service(self, req):
        # recalc values to represent an angle
        panangle = (self.act_pan_pos - self.PAN_CENTER) / self.MULT_PAN_ANGLE
        tiltangle = (self.act_tilt_pos - self.TILT_CENTER) / self.MULT_TILT_ANGLE
        return (panangle, tiltangle)
        
    def task(self):
        # set variables to default values
        tmp_pan_pos = self.PAN_CENTER + self.pan_pos * self.MULT_PAN_ANGLE
        tmp_tilt_pos = self.TILT_CENTER + self.tilt_pos * self.MULT_TILT_ANGLE
        tmp_pan_speed = self.pan_speed * self.MULT_PAN_SPEED
        tmp_tilt_speed = self.tilt_speed * self.MULT_TILT_SPEED
        #print "pan_raw: %s, tilt_raw: %s" % (tmp_pan_pos, tmp_tilt_pos)
        # overrule them depending on the task
        if (self.current_task == self.TSK_MOVE):
            # move with given speed, negative values move the servos in the other direction
            if (tmp_pan_speed < 0):
                tmp_pan_pos = self.PAN_LOWER
            else:
                tmp_pan_pos = self.PAN_UPPER
            tmp_pan_speed = abs(tmp_pan_speed)
            
            if (tmp_tilt_speed < 0):
                tmp_tilt_pos = self.TILT_LOWER
            else:
                tmp_tilt_pos = self.TILT_UPPER
            tmp_tilt_speed = abs(tmp_tilt_speed)
            
        elif (self.current_task == self.TSK_POS):
            # truncate values
            if (tmp_pan_pos < self.PAN_LOWER): tmp_pan_pos = self.PAN_LOWER
            if (tmp_pan_pos > self.PAN_UPPER): tmp_pan_pos = self.PAN_UPPER
            if (tmp_tilt_pos < self.TILT_LOWER): tmp_tilt_pos = self.TILT_LOWER
            if (tmp_tilt_pos > self.TILT_UPPER): tmp_tilt_pos = self.TILT_UPPER
            
            # set pan_speed for positioning:
            if (tmp_pan_speed == 0):
                tmp_pan_speed = self.PAN_DEF_SPEED
            else:
                tmp_pan_speed = abs(tmp_pan_speed)
                
            # set tilt_speed for positioning:
            if (tmp_tilt_speed == 0):
                tmp_tilt_speed = self.TILT_DEF_SPEED
            else:
                tmp_tilt_speed = abs(tmp_tilt_speed)
                
        else:
            # stop mode, stop servos
            tmp_pan_speed = 0.0
            tmp_tilt_speed = 0.0
        
        #print and publish current positions:
        panangle = (self.act_pan_pos - self.PAN_CENTER) / self.MULT_PAN_ANGLE
        tiltangle = (self.act_tilt_pos - self.TILT_CENTER) / self.MULT_TILT_ANGLE
        #print "pan: %s, tilt: %s" % (panangle, tiltangle)
        
        self.pub.publish(pan_angle = panangle, tilt_angle = tiltangle)
        
        # servo reference service (Phidgets module)
        self.servo_ref = rospy.ServiceProxy('servo_reference', servo_reference)
        
        # set tilt values:
        ack = self.servo_ref(self.TILT_IDX, 1, tmp_tilt_pos, tmp_tilt_speed, 0.0) #@UnusedVariable
        
        # set pan values:
        ack = self.servo_ref(self.PAN_IDX, 1, tmp_pan_pos, tmp_pan_speed, 0.0) #@UnusedVariable
        
        return;

    def listener(self):
        # initialize node
        rospy.init_node('tuw_acin_eva_servo')
        rospy.loginfo("tuw_acin_eva_servo started")

        #advertise topic for current values
        self.pub = rospy.Publisher('tuw_acin_eva/servo/cur_head_pos', ServoCurPos) #@UndefinedVariable
        
        # listen on topics:
        rospy.Subscriber("phidgets/servos", servo_params, self.servo_pos_callback)
        rospy.Subscriber("tuw_acin_eva/servo/speed", ServoSpeed, self.handle_speed_service) #@UndefinedVariable
        rospy.Subscriber("tuw_acin_eva/servo/pos", ServoPos, self.handle_pos_service) #@UndefinedVariable
        
        # MAIN-LOOP:
        while not rospy.is_shutdown():
            try:
                self.task()
            except rospy.ServiceException, e:
                str = "Service call failed: %s"%e;
                rospy.logerr(str)
                
            except rospy.ROSInterruptException, e:
                str = "%s" % e
                rospy.logerr(str)
                break
                
            rospy.sleep(0.1)        
        
if __name__ == '__main__':
    sc = SERVO_CONTROLLER()
    sc.listener()
    

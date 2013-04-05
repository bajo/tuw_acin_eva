#!/usr/bin/env python

import roslib; roslib.load_manifest('tuw_acin_eva_main')
import rospy
import smach
import smach_ros
import rospy
from std_msgs.msg import String
import actionlib
from tuw_acin_eva_msgs.msg import *

out_de = ["Unbekannter Befehl","Ja?", "Ja", "Nein", "Es geht mir gut.", "Ok, suche nach Menschen.", "Hallo ", "Ok, folge ", "Suche nach Gegenstaenden", "Ok"]
out_en = ["unknown command", "yes?", "yes", "no", "i'm fine. thank you","Ok, looking for people", "hello ", "Trying to follow ", "Looking for objects", "ok"] 

class SubPub():
	def __init__(self):
		print "init"
	
	def startme(self):
		print "startme"
		self.subscriber = rospy.Subscriber('/tuw_acin_eva/speech_processed', ProcessedCommands, self.callback)
		self.publisher = rospy.Publisher('tuw_acin_eva/speech_output', String)
			
	def callback(self, data):
		global out_de, out_en
		out = []
		print "out_.."
		print out_de
		print "start data"
		print data
		print "end data"
		language = data.parameters[0]
		               
		if language == "german":
			out = out_de
		elif language == "english":
			out = out_en
		
		if data.command == 1:
			# eva
			out_msg= out[1]
		elif data.command == 2:
			# find people
			out_msg= out[5]
		elif data.command == 3:
			# this is _name_
			out_msg= out[6]+msg.params[1][1]
		elif data.command == 4:
			# follow _name_
			out_msg= out[7]+msg.params[1][1]
		elif data.command == 5:
			# find objects
			out_msg= out[8]
		elif data.command == 6:
			# find the hot coffee
			out_msg= out[2]
		elif data.command == 7:
			# find the cold beer
			out_msg= out[2]
		elif data.command == 8:
			# stop
			out_msg= out[9]
		elif data.command == 9:
			# german / english
			out_msg= out[9]
		elif data.command == 10:
			# how are you?
			print out
			out_msg= out[4]
		elif data.command == 11:
			# where is the _color_ _object_?
			# FIXME
			# insert actual code
			out_msg= out[1]
		elif data.command == 12:
			# how big is the _object_?
			# FIXME 
			# insert actual code
			out_msg= out[0]
		elif data.command == 13:
			# yes
			out_msg= out[9]
		elif data.command == 14:
			# no
			out_msg= out[9]
			rospy.sleep(1.0)                
		self.publisher.publish(out_msg)

class Ready(smach.State):
	def __init__(self):
		smach.State.__init__(self, outcomes=['LearnPerson', 'FollowPerson', 'LearnObject','RecognizeObject', 'Start', 'Sleep'])

	def execute(self,userdata):
		return 'LearnPerson'

class Stop(smach.State, SubPub):
	def __init__(self):
		smach.State.__init__(self, outcomes=['Start', 'Stop'])

	def execute(self,userdata):
		self.startme()
		rospy.sleep(3.0)
		return 'Stop'	

class PersonLearn(smach.State):
	def __init__(self):
		smach.State.__init__(self, outcomes=['PersonSaved'])

	def execute(self,userdata):
		return 'PersonSaved'	

class PersonFollow(smach.State):
	def __init__(self):
		smach.State.__init__(self, outcomes=['Stop', 'LearnObject', 'Sleep', 'FollowPerson'])

	def execute(self,userdata):
		return 'Stop'

class ObjectLearn(smach.State):
	def __init__(self):
		smach.State.__init__(self, outcomes=['ObjectSaved'])

	def execute(self,userdata):
		return 'ObjectSaved'

class ObjectRecognize(smach.State):
	def __init__(self):
		smach.State.__init__(self, outcomes=['ObjectRecognized', 'Sleep'])

	def execute(self,userdata):
		return 'ObjectRecognized'

def main():
	rospy.init_node('Eva_main_state_machine')
	rospy.loginfo("TU Wien Evas state machine node is ready!")

	# Create a SMACH state machine
	sm = smach.StateMachine(outcomes='Shutdown')

	# Open the container
	with sm:
		# Add states to the state machine
		smach.StateMachine.add('STOP', Stop(), transitions={'Start':'READY', 'Stop':'STOP'})
		smach.StateMachine.add('READY', Ready(), transitions={'LearnPerson':'PERSON_LEARN','FollowPerson':'PERSON_FOLLOW', 'LearnObject':'OBJECT_LEARN','RecognizeObject':'OBJECT_RECOGNITION',
									'Start':'READY','Sleep':'STOP'})
		smach.StateMachine.add('PERSON_LEARN', PersonLearn(), transitions={'PersonSaved':'READY'})
		smach.StateMachine.add('PERSON_FOLLOW', PersonFollow(), transitions={'Stop':'READY','LearnObject':'OBJECT_LEARN','Sleep':'STOP','FollowPerson':'PERSON_FOLLOW'})
		smach.StateMachine.add('OBJECT_LEARN', ObjectLearn(), transitions={'ObjectSaved':'READY'})
		smach.StateMachine.add('OBJECT_RECOGNITION', ObjectRecognize(), transitions={'ObjectRecognized':'READY','Sleep':'STOP'})
#		smach.StateMachine.add('FOO', smach_ros.MonitorState("/sm_reset", ProcessedCommands, monitor_cb), transitions={'invalid':'BAR', 'valid':'FOO', 'preempted':'FOO'})
	
	# Create and start the introspection server
	sis = smach_ros.IntrospectionServer('tuw_acin_eva_states', sm, '/SM_ROOT')
	sis.start()
	
	# Execute the SMACH plan
	outcome = sm.execute()
	
	# Wait for ctrl-c to stop the application
	rospy.spin()
	sis.stop()

if __name__ == '__main__':
	main()

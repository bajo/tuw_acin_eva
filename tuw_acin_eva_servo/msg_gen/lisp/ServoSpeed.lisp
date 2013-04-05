; Auto-generated. Do not edit!


(cl:in-package tuw_acin_eva_servo-msg)


;//! \htmlinclude ServoSpeed.msg.html

(cl:defclass <ServoSpeed> (roslisp-msg-protocol:ros-message)
  ((pan_speed
    :reader pan_speed
    :initarg :pan_speed
    :type cl:integer
    :initform 0)
   (tilt_speed
    :reader tilt_speed
    :initarg :tilt_speed
    :type cl:integer
    :initform 0))
)

(cl:defclass ServoSpeed (<ServoSpeed>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ServoSpeed>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ServoSpeed)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tuw_acin_eva_servo-msg:<ServoSpeed> is deprecated: use tuw_acin_eva_servo-msg:ServoSpeed instead.")))

(cl:ensure-generic-function 'pan_speed-val :lambda-list '(m))
(cl:defmethod pan_speed-val ((m <ServoSpeed>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tuw_acin_eva_servo-msg:pan_speed-val is deprecated.  Use tuw_acin_eva_servo-msg:pan_speed instead.")
  (pan_speed m))

(cl:ensure-generic-function 'tilt_speed-val :lambda-list '(m))
(cl:defmethod tilt_speed-val ((m <ServoSpeed>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tuw_acin_eva_servo-msg:tilt_speed-val is deprecated.  Use tuw_acin_eva_servo-msg:tilt_speed instead.")
  (tilt_speed m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ServoSpeed>) ostream)
  "Serializes a message object of type '<ServoSpeed>"
  (cl:let* ((signed (cl:slot-value msg 'pan_speed)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'tilt_speed)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ServoSpeed>) istream)
  "Deserializes a message object of type '<ServoSpeed>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'pan_speed) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'tilt_speed) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ServoSpeed>)))
  "Returns string type for a message object of type '<ServoSpeed>"
  "tuw_acin_eva_servo/ServoSpeed")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ServoSpeed)))
  "Returns string type for a message object of type 'ServoSpeed"
  "tuw_acin_eva_servo/ServoSpeed")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ServoSpeed>)))
  "Returns md5sum for a message object of type '<ServoSpeed>"
  "1308e18703a9a36af635dc7306ba5e60")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ServoSpeed)))
  "Returns md5sum for a message object of type 'ServoSpeed"
  "1308e18703a9a36af635dc7306ba5e60")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ServoSpeed>)))
  "Returns full string definition for message of type '<ServoSpeed>"
  (cl:format cl:nil "int32 pan_speed~%int32 tilt_speed~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ServoSpeed)))
  "Returns full string definition for message of type 'ServoSpeed"
  (cl:format cl:nil "int32 pan_speed~%int32 tilt_speed~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ServoSpeed>))
  (cl:+ 0
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ServoSpeed>))
  "Converts a ROS message object to a list"
  (cl:list 'ServoSpeed
    (cl:cons ':pan_speed (pan_speed msg))
    (cl:cons ':tilt_speed (tilt_speed msg))
))

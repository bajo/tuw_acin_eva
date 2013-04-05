; Auto-generated. Do not edit!


(cl:in-package tuw_acin_eva_servo-msg)


;//! \htmlinclude ServoPos.msg.html

(cl:defclass <ServoPos> (roslisp-msg-protocol:ros-message)
  ((pan_angle
    :reader pan_angle
    :initarg :pan_angle
    :type cl:float
    :initform 0.0)
   (tilt_angle
    :reader tilt_angle
    :initarg :tilt_angle
    :type cl:float
    :initform 0.0)
   (pan_speed
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

(cl:defclass ServoPos (<ServoPos>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ServoPos>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ServoPos)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tuw_acin_eva_servo-msg:<ServoPos> is deprecated: use tuw_acin_eva_servo-msg:ServoPos instead.")))

(cl:ensure-generic-function 'pan_angle-val :lambda-list '(m))
(cl:defmethod pan_angle-val ((m <ServoPos>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tuw_acin_eva_servo-msg:pan_angle-val is deprecated.  Use tuw_acin_eva_servo-msg:pan_angle instead.")
  (pan_angle m))

(cl:ensure-generic-function 'tilt_angle-val :lambda-list '(m))
(cl:defmethod tilt_angle-val ((m <ServoPos>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tuw_acin_eva_servo-msg:tilt_angle-val is deprecated.  Use tuw_acin_eva_servo-msg:tilt_angle instead.")
  (tilt_angle m))

(cl:ensure-generic-function 'pan_speed-val :lambda-list '(m))
(cl:defmethod pan_speed-val ((m <ServoPos>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tuw_acin_eva_servo-msg:pan_speed-val is deprecated.  Use tuw_acin_eva_servo-msg:pan_speed instead.")
  (pan_speed m))

(cl:ensure-generic-function 'tilt_speed-val :lambda-list '(m))
(cl:defmethod tilt_speed-val ((m <ServoPos>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tuw_acin_eva_servo-msg:tilt_speed-val is deprecated.  Use tuw_acin_eva_servo-msg:tilt_speed instead.")
  (tilt_speed m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ServoPos>) ostream)
  "Serializes a message object of type '<ServoPos>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'pan_angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'tilt_angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ServoPos>) istream)
  "Deserializes a message object of type '<ServoPos>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pan_angle) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'tilt_angle) (roslisp-utils:decode-single-float-bits bits)))
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ServoPos>)))
  "Returns string type for a message object of type '<ServoPos>"
  "tuw_acin_eva_servo/ServoPos")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ServoPos)))
  "Returns string type for a message object of type 'ServoPos"
  "tuw_acin_eva_servo/ServoPos")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ServoPos>)))
  "Returns md5sum for a message object of type '<ServoPos>"
  "ff2fe6b1988f525ab5d7553c924dfb97")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ServoPos)))
  "Returns md5sum for a message object of type 'ServoPos"
  "ff2fe6b1988f525ab5d7553c924dfb97")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ServoPos>)))
  "Returns full string definition for message of type '<ServoPos>"
  (cl:format cl:nil "float32 pan_angle~%float32 tilt_angle~%int32 pan_speed~%int32 tilt_speed~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ServoPos)))
  "Returns full string definition for message of type 'ServoPos"
  (cl:format cl:nil "float32 pan_angle~%float32 tilt_angle~%int32 pan_speed~%int32 tilt_speed~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ServoPos>))
  (cl:+ 0
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ServoPos>))
  "Converts a ROS message object to a list"
  (cl:list 'ServoPos
    (cl:cons ':pan_angle (pan_angle msg))
    (cl:cons ':tilt_angle (tilt_angle msg))
    (cl:cons ':pan_speed (pan_speed msg))
    (cl:cons ':tilt_speed (tilt_speed msg))
))

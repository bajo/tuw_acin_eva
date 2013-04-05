; Auto-generated. Do not edit!


(cl:in-package tuw_acin_eva_servo-msg)


;//! \htmlinclude ServoCurPos.msg.html

(cl:defclass <ServoCurPos> (roslisp-msg-protocol:ros-message)
  ((pan_angle
    :reader pan_angle
    :initarg :pan_angle
    :type cl:float
    :initform 0.0)
   (tilt_angle
    :reader tilt_angle
    :initarg :tilt_angle
    :type cl:float
    :initform 0.0))
)

(cl:defclass ServoCurPos (<ServoCurPos>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ServoCurPos>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ServoCurPos)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tuw_acin_eva_servo-msg:<ServoCurPos> is deprecated: use tuw_acin_eva_servo-msg:ServoCurPos instead.")))

(cl:ensure-generic-function 'pan_angle-val :lambda-list '(m))
(cl:defmethod pan_angle-val ((m <ServoCurPos>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tuw_acin_eva_servo-msg:pan_angle-val is deprecated.  Use tuw_acin_eva_servo-msg:pan_angle instead.")
  (pan_angle m))

(cl:ensure-generic-function 'tilt_angle-val :lambda-list '(m))
(cl:defmethod tilt_angle-val ((m <ServoCurPos>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tuw_acin_eva_servo-msg:tilt_angle-val is deprecated.  Use tuw_acin_eva_servo-msg:tilt_angle instead.")
  (tilt_angle m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ServoCurPos>) ostream)
  "Serializes a message object of type '<ServoCurPos>"
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
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ServoCurPos>) istream)
  "Deserializes a message object of type '<ServoCurPos>"
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
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ServoCurPos>)))
  "Returns string type for a message object of type '<ServoCurPos>"
  "tuw_acin_eva_servo/ServoCurPos")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ServoCurPos)))
  "Returns string type for a message object of type 'ServoCurPos"
  "tuw_acin_eva_servo/ServoCurPos")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ServoCurPos>)))
  "Returns md5sum for a message object of type '<ServoCurPos>"
  "f191de4d1f51ebd5f8f3b12305019bf6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ServoCurPos)))
  "Returns md5sum for a message object of type 'ServoCurPos"
  "f191de4d1f51ebd5f8f3b12305019bf6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ServoCurPos>)))
  "Returns full string definition for message of type '<ServoCurPos>"
  (cl:format cl:nil "float32 pan_angle~%float32 tilt_angle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ServoCurPos)))
  "Returns full string definition for message of type 'ServoCurPos"
  (cl:format cl:nil "float32 pan_angle~%float32 tilt_angle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ServoCurPos>))
  (cl:+ 0
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ServoCurPos>))
  "Converts a ROS message object to a list"
  (cl:list 'ServoCurPos
    (cl:cons ':pan_angle (pan_angle msg))
    (cl:cons ':tilt_angle (tilt_angle msg))
))

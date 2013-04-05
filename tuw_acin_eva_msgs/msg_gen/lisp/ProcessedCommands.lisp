; Auto-generated. Do not edit!


(cl:in-package tuw_acin_eva_msgs-msg)


;//! \htmlinclude ProcessedCommands.msg.html

(cl:defclass <ProcessedCommands> (roslisp-msg-protocol:ros-message)
  ((command
    :reader command
    :initarg :command
    :type cl:fixnum
    :initform 0)
   (parameters
    :reader parameters
    :initarg :parameters
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element "")))
)

(cl:defclass ProcessedCommands (<ProcessedCommands>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ProcessedCommands>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ProcessedCommands)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tuw_acin_eva_msgs-msg:<ProcessedCommands> is deprecated: use tuw_acin_eva_msgs-msg:ProcessedCommands instead.")))

(cl:ensure-generic-function 'command-val :lambda-list '(m))
(cl:defmethod command-val ((m <ProcessedCommands>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tuw_acin_eva_msgs-msg:command-val is deprecated.  Use tuw_acin_eva_msgs-msg:command instead.")
  (command m))

(cl:ensure-generic-function 'parameters-val :lambda-list '(m))
(cl:defmethod parameters-val ((m <ProcessedCommands>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tuw_acin_eva_msgs-msg:parameters-val is deprecated.  Use tuw_acin_eva_msgs-msg:parameters instead.")
  (parameters m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ProcessedCommands>) ostream)
  "Serializes a message object of type '<ProcessedCommands>"
  (cl:let* ((signed (cl:slot-value msg 'command)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'parameters))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'parameters))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ProcessedCommands>) istream)
  "Deserializes a message object of type '<ProcessedCommands>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'command) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'parameters) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'parameters)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ProcessedCommands>)))
  "Returns string type for a message object of type '<ProcessedCommands>"
  "tuw_acin_eva_msgs/ProcessedCommands")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ProcessedCommands)))
  "Returns string type for a message object of type 'ProcessedCommands"
  "tuw_acin_eva_msgs/ProcessedCommands")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ProcessedCommands>)))
  "Returns md5sum for a message object of type '<ProcessedCommands>"
  "99bd9d5d381f3b949e10fbd1fb7ebaff")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ProcessedCommands)))
  "Returns md5sum for a message object of type 'ProcessedCommands"
  "99bd9d5d381f3b949e10fbd1fb7ebaff")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ProcessedCommands>)))
  "Returns full string definition for message of type '<ProcessedCommands>"
  (cl:format cl:nil "int8 command~%string[] parameters~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ProcessedCommands)))
  "Returns full string definition for message of type 'ProcessedCommands"
  (cl:format cl:nil "int8 command~%string[] parameters~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ProcessedCommands>))
  (cl:+ 0
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'parameters) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ProcessedCommands>))
  "Converts a ROS message object to a list"
  (cl:list 'ProcessedCommands
    (cl:cons ':command (command msg))
    (cl:cons ':parameters (parameters msg))
))

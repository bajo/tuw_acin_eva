; Auto-generated. Do not edit!


(cl:in-package tuw_acin_eva_people-srv)


;//! \htmlinclude PeopleCommands-request.msg.html

(cl:defclass <PeopleCommands-request> (roslisp-msg-protocol:ros-message)
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

(cl:defclass PeopleCommands-request (<PeopleCommands-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PeopleCommands-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PeopleCommands-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tuw_acin_eva_people-srv:<PeopleCommands-request> is deprecated: use tuw_acin_eva_people-srv:PeopleCommands-request instead.")))

(cl:ensure-generic-function 'command-val :lambda-list '(m))
(cl:defmethod command-val ((m <PeopleCommands-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tuw_acin_eva_people-srv:command-val is deprecated.  Use tuw_acin_eva_people-srv:command instead.")
  (command m))

(cl:ensure-generic-function 'parameters-val :lambda-list '(m))
(cl:defmethod parameters-val ((m <PeopleCommands-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tuw_acin_eva_people-srv:parameters-val is deprecated.  Use tuw_acin_eva_people-srv:parameters instead.")
  (parameters m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PeopleCommands-request>) ostream)
  "Serializes a message object of type '<PeopleCommands-request>"
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PeopleCommands-request>) istream)
  "Deserializes a message object of type '<PeopleCommands-request>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PeopleCommands-request>)))
  "Returns string type for a service object of type '<PeopleCommands-request>"
  "tuw_acin_eva_people/PeopleCommandsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PeopleCommands-request)))
  "Returns string type for a service object of type 'PeopleCommands-request"
  "tuw_acin_eva_people/PeopleCommandsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PeopleCommands-request>)))
  "Returns md5sum for a message object of type '<PeopleCommands-request>"
  "6dc1dadd68b2adb4088cd7c7ed66f3c3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PeopleCommands-request)))
  "Returns md5sum for a message object of type 'PeopleCommands-request"
  "6dc1dadd68b2adb4088cd7c7ed66f3c3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PeopleCommands-request>)))
  "Returns full string definition for message of type '<PeopleCommands-request>"
  (cl:format cl:nil "int8 command~%string[] parameters~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PeopleCommands-request)))
  "Returns full string definition for message of type 'PeopleCommands-request"
  (cl:format cl:nil "int8 command~%string[] parameters~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PeopleCommands-request>))
  (cl:+ 0
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'parameters) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PeopleCommands-request>))
  "Converts a ROS message object to a list"
  (cl:list 'PeopleCommands-request
    (cl:cons ':command (command msg))
    (cl:cons ':parameters (parameters msg))
))
;//! \htmlinclude PeopleCommands-response.msg.html

(cl:defclass <PeopleCommands-response> (roslisp-msg-protocol:ros-message)
  ((status
    :reader status
    :initarg :status
    :type cl:string
    :initform ""))
)

(cl:defclass PeopleCommands-response (<PeopleCommands-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PeopleCommands-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PeopleCommands-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tuw_acin_eva_people-srv:<PeopleCommands-response> is deprecated: use tuw_acin_eva_people-srv:PeopleCommands-response instead.")))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <PeopleCommands-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tuw_acin_eva_people-srv:status-val is deprecated.  Use tuw_acin_eva_people-srv:status instead.")
  (status m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PeopleCommands-response>) ostream)
  "Serializes a message object of type '<PeopleCommands-response>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'status))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'status))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PeopleCommands-response>) istream)
  "Deserializes a message object of type '<PeopleCommands-response>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'status) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'status) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PeopleCommands-response>)))
  "Returns string type for a service object of type '<PeopleCommands-response>"
  "tuw_acin_eva_people/PeopleCommandsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PeopleCommands-response)))
  "Returns string type for a service object of type 'PeopleCommands-response"
  "tuw_acin_eva_people/PeopleCommandsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PeopleCommands-response>)))
  "Returns md5sum for a message object of type '<PeopleCommands-response>"
  "6dc1dadd68b2adb4088cd7c7ed66f3c3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PeopleCommands-response)))
  "Returns md5sum for a message object of type 'PeopleCommands-response"
  "6dc1dadd68b2adb4088cd7c7ed66f3c3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PeopleCommands-response>)))
  "Returns full string definition for message of type '<PeopleCommands-response>"
  (cl:format cl:nil "string status~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PeopleCommands-response)))
  "Returns full string definition for message of type 'PeopleCommands-response"
  (cl:format cl:nil "string status~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PeopleCommands-response>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'status))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PeopleCommands-response>))
  "Converts a ROS message object to a list"
  (cl:list 'PeopleCommands-response
    (cl:cons ':status (status msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'PeopleCommands)))
  'PeopleCommands-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'PeopleCommands)))
  'PeopleCommands-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PeopleCommands)))
  "Returns string type for a service object of type '<PeopleCommands>"
  "tuw_acin_eva_people/PeopleCommands")
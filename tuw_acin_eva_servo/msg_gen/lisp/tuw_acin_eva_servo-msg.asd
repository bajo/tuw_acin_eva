
(cl:in-package :asdf)

(defsystem "tuw_acin_eva_servo-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "ServoSpeed" :depends-on ("_package_ServoSpeed"))
    (:file "_package_ServoSpeed" :depends-on ("_package"))
    (:file "ServoCurPos" :depends-on ("_package_ServoCurPos"))
    (:file "_package_ServoCurPos" :depends-on ("_package"))
    (:file "ServoPos" :depends-on ("_package_ServoPos"))
    (:file "_package_ServoPos" :depends-on ("_package"))
  ))
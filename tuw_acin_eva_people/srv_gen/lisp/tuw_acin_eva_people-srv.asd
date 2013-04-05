
(cl:in-package :asdf)

(defsystem "tuw_acin_eva_people-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "PeopleCommands" :depends-on ("_package_PeopleCommands"))
    (:file "_package_PeopleCommands" :depends-on ("_package"))
  ))
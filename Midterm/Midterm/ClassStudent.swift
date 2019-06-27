//
//  ClassStudent.swift
//  Midterm
//
//  Created by SonPham on 10/28/18.
//  Copyright © 2018 SonPham. All rights reserved.
//
import UIKit
import Foundation
class Student{
    var Gender:String
    var FirstName:String
    var LastName:String
    var DateOfBirth:String
    var IdStudent:String
    var ClassStudent:String
    var OtherInfo:String
    //var ImageStudent:UIImage
    init(firstName:String,lastName:String,classStudent:String,idStudent:String,birthDay:String,gender:String,otherInfo:String){
    self.LastName=lastName
    self.FirstName=firstName
    self.DateOfBirth=birthDay
    self.ClassStudent=classStudent
    self.IdStudent=idStudent
    self.Gender=gender
    self.OtherInfo=otherInfo
   // self.ImageStudent=nil
    }
    
    func SetInfoNewStudent(firstName:String,lastName:String,classStudent:String,idStudent:String,gender:String){
        LastName=lastName
        FirstName=firstName
        //self.DateOfBirth=dateOfBirth
        ClassStudent=classStudent
        IdStudent=idStudent
        Gender=gender
        // self.ImageStudent=nil
    }
    func SetFirstName(firstName:String){
        FirstName=firstName
    }
    func SetLastName(lastName:String){
        LastName=lastName
    }
    func SetIdStudent(idStudent:String){
        IdStudent=idStudent
    }
    func SetClassStudent(classStudent:String){
        ClassStudent=classStudent
    }
}


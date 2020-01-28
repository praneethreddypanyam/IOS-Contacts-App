//
//  functionality.swift
//  Assignment2
//
//  Created by Praneet Reddy on 27/01/20.
//  Copyright © 2020 PraneethReddy. All rights reserved.
//

import Foundation

enum InvalidEntryErrors: Error{
    case noInput
    case notInteger
    case invalidType
    case nothing
    case notPositive
}
var students = [Student]()

class initial {
    
    var name: String?, age: Int?, address: String?, rollNumber: Int?, courses:String?
    
    
    func addDetails() throws -> [Any] {
        var list = [Any]()
        repeat{
            if name == nil{
                print("Enter your full name: ")
                guard let temp = readLine() else{
                     throw InvalidEntryErrors.nothing
                }
                guard temp != "" else {
                     throw InvalidEntryErrors.noInput
                }
                name = temp
                list.append(name!)
            }
            if age == nil {
                print("Enter your age: ")
                guard let temp = readLine() else{
                    throw InvalidEntryErrors.nothing
                }
                guard temp != "" else {
                     throw InvalidEntryErrors.noInput
                }
                guard let temp1=Int(temp) else {
                    throw InvalidEntryErrors.notInteger
                }
                guard temp1 > 0 else{
                    throw InvalidEntryErrors.notPositive
                }
                age = temp1
                list.append(age!)
            }
            
            if address == nil{
                print("Enter your address: ")
                guard let temp = readLine() else{
                    throw InvalidEntryErrors.nothing
                }
                guard temp != "" else{
                    throw InvalidEntryErrors.noInput
                }
                address = temp
                list.append(address!)
            }
            
            if rollNumber == nil {
                print("Enter your roll number: ")
                guard let temp = readLine() else{
                    throw InvalidEntryErrors.nothing
                }
                guard temp != "" else {
                     throw InvalidEntryErrors.noInput
                }
                guard let temp1=Int(temp) else {
                    throw InvalidEntryErrors.notInteger
                }
                guard temp1 > 0 else{
                    throw InvalidEntryErrors.notPositive
                }
                rollNumber = temp1
                list.append(rollNumber!)
            }
            
            if courses == nil{
                var j = 1
                           var course:Int?
                           while j==1{
                               print("Enter number of courses : ")
                               if let c = readLine(){
                                   if let temp = Int(c){
                                       if temp >= 4{
                                           course = temp
                                           j=2
                                       }
                                       else{
                                           print("Courses must be greater than 4")
                                           continue
                                       }
                                   }
                               }
                           }
                           print("Available courses are A,B,C,D,E,F")
                           
                           var courseList = [String]()
                           
                            var k = 0
                            let availableList = ["A","B","C","D","E","F"]
                            while k < course!{
                                print("Enter the course", (k+1) ," : ")
                                let temp = readLine()
                                let temp1 = temp!.uppercased()
                                if availableList.contains(temp1){
                                    courseList.append(temp1)
                                    k += 1
                                }
                                else{
                                    print("Invalid course selected. Reselect the course")
                                }
                            }
                            
                           courses = courseList.joined(separator: " ")
                           list.append(courses!)
            }
           
            let s = Student(Name: name!, Address: address!, Courses: courses!, Age: age!, RollNumber: rollNumber!)
            students.append(s)
            
            name = nil
            age = nil
            address = nil
            courses = nil
            rollNumber = nil
            return list
        }while true
    }



    func displayDetails(){

        print("Select the type in which you want to display the details:");
        print("1. Sort based on Name");
        print("2. Sort based on RollNumber");
        print("3. Sort based on Age");
        print("4. Sort based on Address");
        
        let sort = Sorting()
        var sortedValues = [Student]()
        if let choice = readLine(){
            if let choice1 = Int(choice){
                switch(choice1){
                case 1:
                    sortedValues = sort.StuName(value :students)
                case 2:
                    sortedValues = sort.StuRoll(value :students)
                case 3:
                    sortedValues = sort.StuAge(value :students)
                case 4:
                    sortedValues = sort.StuAddress(value :students)
                default:
                    print("Invalid Choice")
                }
            }
        }
        
        
        print("Student details in sorted order :")
        print("-----------------------------------------------------------------------------")
        print("Name \t\t Roll No. \t\t Age \t\t Address  \t\t Courses")
        print("-----------------------------------------------------------------------------")
        for i in sortedValues{
            print(" \(i.getName()) \t\t\t \(i.getRollNo()) \t\t\t \(i.getAge()) \t\t\t \(i.getAddress())")
        }
        print("\n")
        print("---------------------------------------")
        
    }


    func deleteDetails(){
        print("Enter Roll no of student to be deleted")
        if let roll = readLine(){
            if let rollNo = Int(roll){
                var f:Int = 0
                for (index,i) in students.enumerated(){
                    if i.getRollNo() == rollNo{
                        f = 1
                        students.remove(at:index)
                        print("Student detail with roll no",rollNo,"deleted")
                    }
                }
                if f==0{
                    print("Student with entered rollNo doesnt exist")
                }
            }
        }
    }

    func saveDetails(){
        print("Details saved")
    }

    func quit() -> Int{
        return 0
    }
}





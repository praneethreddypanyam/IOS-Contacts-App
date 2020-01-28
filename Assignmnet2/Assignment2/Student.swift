//
//  Student.swift
//  Assignment2
//
//  Created by Praneet Reddy on 27/01/20.
//  Copyright © 2020 PraneethReddy. All rights reserved.
//

import Foundation

class Student{
    
    var Name: String, Address: String, Courses: String, Age: Int, RollNumber: Int
    
    init(Name: String, Address: String, Courses: String, Age: Int, RollNumber: Int){
        self.Name = Name
        self.Address = Address
        self.Courses = Courses
        self.Age = Age
        self.RollNumber = RollNumber
    }
    
    func getName() -> String{
        return Name
    }
    
    func getAddress() -> String{
        return Address
    }
    
    func getCourses() -> String{
        return Courses
    }
    
    func getAge() -> Int{
        return Age
    }

    func getRollNo() ->Int{
        return RollNumber
    }
}

//
//  exceptionHandler.swift
//  Assignment2
//
//  Created by Praneet Reddy on 27/01/20.
//  Copyright © 2020 PraneethReddy. All rights reserved.
//

import Foundation

class ErrorHandler{
    
    var j:Int = 1
    var choice:String?
    var obj = initial()
    var student = [Any]()
    
    func Errors(){
        while true{
        do{
            let x = try obj.addDetails()
            student.append(x)
            break
        }
        catch InvalidEntryErrors.noInput{
            print("You entered nothing, Renter the value")
            
        }
        catch InvalidEntryErrors.notInteger{
            print("You didnt enter integer value. Please reneter an integer value")
        }
        catch InvalidEntryErrors.notPositive{
            print("Age cannot be negative. Please enter positive value")
        }
        catch InvalidEntryErrors.invalidType{
            print("There is Invalid Type. Reeneter a valid type.")
        }
        catch{
            print("Invalid")
        }
    }
    
    
    }
}


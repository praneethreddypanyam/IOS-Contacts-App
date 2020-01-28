//
//  main.swift
//  Assignment2
//
//  Created by Praneet Reddy on 27/01/20.
//  Copyright © 2020 PraneethReddy. All rights reserved.
//

import Foundation

var i = 1
while i==1{
    print("Menu")
    print("1. Add user details")
    print("2. Display user details")
    print("3. Delete user details")
    print("4. Save user details")
    print("5. Exit")
    
    if let choice = readLine(){
        if let choice1 = Int(choice){
            let object = initial()
            switch(choice1){
            case 1:
                let x = ErrorHandler()
                x.Errors()
            case 2:
                object.displayDetails()
            case 3:
                object.deleteDetails()
            case 4:
                object.saveDetails()
            case 5:
                i = object.quit()
            default:
                print("Invalid Choice")
            }
        }
    }
}

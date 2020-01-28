//
//  Sorting.swift
//  Assignment2
//
//  Created by Praneet Reddy on 27/01/20.
//  Copyright © 2020 PraneethReddy. All rights reserved.
//

import Foundation

class Sorting{
    func StuName(value : [Student]) -> [Student]{
        print("Choose the type of sorting order.")
        print("1. Ascending order")
        print("2. Descending order")
        if let temp = readLine(){
            if let option = Int(temp){
                if option == 1{
                    return value.sorted(by: { $0.Name < $1.Name } )
                }
                else{
                    return value.sorted(by: { $0.Name > $1.Name } )
                }
            }
        }
        return value
    }
    
    func StuAge(value : [Student]) -> [Student]{
        print("Choose the type of sorting order.")
        print("1. Ascending order")
        print("2. Descending order")
        if let temp = readLine(){
            if let option = Int(temp){
                if option == 1{
                    return value.sorted(by: { $0.Age < $1.Age } )
                }
                else{
                    return value.sorted(by: { $0.Age > $1.Age } )
                }
            }
        }
        return value
    }
    
    func StuAddress(value : [Student]) -> [Student]{
        print("Choose the type of sorting order.")
        print("1. Ascending order")
        print("2. Descending order")
        if let temp = readLine(){
            if let option = Int(temp){
                if option == 1{
                    return value.sorted(by: { $0.Address < $1.Address } )
                }
                else{
                    return value.sorted(by: { $0.Address > $1.Address } )
                }
            }
        }
        return value
    }
    
    func StuRoll(value : [Student]) -> [Student]{
        print("Choose the type of sorting order.")
        print("1. Ascending order")
        print("2. Descending order")
        if let temp = readLine(){
            if let option = Int(temp){
                if option == 1{
                    return value.sorted(by: { $0.RollNumber < $1.RollNumber } )
                }
                else{
                    return value.sorted(by: { $0.RollNumber > $1.RollNumber } )
                }
            }
        }
        return value
    }
    
}

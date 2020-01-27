//
//  main.swift
//  Assignment1
//
//  Created by Praneet Reddy on 27/01/20.
//  Copyright © 2020 PraneethReddy. All rights reserved.
//

import Foundation

var i:Int=1
var choice:String?
var obj = initial()
while i==1{
    do{
        let item = try obj.add_item()
        let x = sample(name: item[0] as! String,price: item[1] as! Double,quantity: item[2] as! Int,type: item[3] as! String)
        i = x.calculate_tax()
        
    }
    catch InvalidEntryErrors.noInput{
        print("You entered nothing, Renter the value")
        
    }
    catch InvalidEntryErrors.notInteger{
        print("You didnt enter integer value. Please reneter an integer value")
        
    }
    catch InvalidEntryErrors.notDouble{
        print("You didnt enter a Double value. Please reneter")
        
    }    catch InvalidEntryErrors.invalidType{
        print("There is Invalid Type. Reeneter a valid type.")
        
    }
}








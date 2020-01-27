//
//  TaxCalculation.swift
//  Assignment1
//
//  Created by Praneet Reddy on 27/01/20.
//  Copyright © 2020 PraneethReddy. All rights reserved.
//

import Foundation

var items = [Any]()
class sample {
    var name: String,quantity: Int,price: Double,type: String
    init(name: String,price: Double,quantity: Int,type: String) {
        self.name = name
        self.quantity = quantity
        self.price = price
        self.type = type
    }
    
    
    var item_detail = [Any]()
    
    func calculate_tax() -> Int{
        var sales_tax: Double
        if type == "raw"{
            sales_tax=(12.5*(price))/100;
        }
        else if type == "manufactured"{
            let tax:Double = (12.5*(price))/100
            sales_tax=(2*(price + tax))/100
        }
        else{
            var tax,cost:Double;
            tax=(10*(price))/100;
            cost=price+tax;
            if(cost<=100){
                sales_tax=cost+5;

            }
            else if(cost>100 && cost<=200){
                sales_tax=cost+10;
            }
            else{
                    sales_tax=(105*(cost))/100;
            }
        }
        let item_final_cost = price + sales_tax;
        
        item_detail.append(name)
        item_detail.append(price)
        item_detail.append(sales_tax)
        item_detail.append(item_final_cost)
        
        items.append(item_detail)
        
        
        print("Do you want to enter details of any other item (y/n):")
        let choice = readLine()
        if choice=="n"{
            print("-----------------Details Of Items-------------------")
            print("Name     Price   Tax    Cost")
            bill()
            return 0
        }
        return 1
    }

    func bill(){
        for item in items{
            for i in item as! [Any]{
                print(i,terminator:"    ")
            }
            print("\n")
        }
    }
}


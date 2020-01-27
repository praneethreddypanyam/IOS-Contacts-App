//
//  itemAdding.swift
//  Assignment1
//
//  Created by Praneet Reddy on 27/01/20.
//  Copyright © 2020 PraneethReddy. All rights reserved.
//

import Foundation

enum InvalidEntryErrors: Error{
    case noInput
    case notInteger
    case notDouble
    case invalidType
    case nothing
}

class initial{
    var item_name: String?, item_price: Double?, item_quantity: Int?, item_type: String?

    func add_item() throws -> [Any] {
        var list = [Any]()
        repeat{
            if item_name == nil{
                print("Enter item name: ")
                guard let temp = readLine() else{
                     throw InvalidEntryErrors.nothing
                }
                guard temp != "" else {
                     throw InvalidEntryErrors.noInput
                }
                item_name = temp
                list.append(item_name!)
            }
            if item_price == nil {
                print("Enter item price: ")
                guard let temp = readLine() else{
                    throw InvalidEntryErrors.nothing
                }
                guard temp != "" else {
                     throw InvalidEntryErrors.noInput
                }
                guard let temp1=Double(temp) else {
                    throw InvalidEntryErrors.notDouble
                }
                item_price = temp1
                list.append(item_price!)
            }
            
            print("Enter item quantity: ")
            if item_quantity == nil {
                guard let temp = readLine() else{
                    throw InvalidEntryErrors.nothing
                }
                guard temp != "" else {
                     throw InvalidEntryErrors.noInput
                }
                guard let temp1=Int(temp) else {
                    throw InvalidEntryErrors.notInteger
                }
                item_quantity = temp1
                list.append(item_quantity!)
            }
            
            print("Enter item type : ")
            print("Available types are: 'raw' , 'manufactured' , 'impoted'")
            let l = ["raw","manufactured","imported"]
            if item_type == nil {
                guard let temp = readLine() else{
                    throw InvalidEntryErrors.nothing
                }
                guard temp != "" else {
                     throw InvalidEntryErrors.noInput
                }
                guard l.contains(temp) else {
                    throw InvalidEntryErrors.invalidType
                }
                item_type = temp
                list.append(item_type!)
            }
            item_name = nil
            item_type = nil
            item_price = nil
            item_quantity = nil
            return list
        }while true
    }
}





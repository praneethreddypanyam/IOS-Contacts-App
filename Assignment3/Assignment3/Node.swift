//
//  Node.swift
//  Assignment3
//
//  Created by Praneet Reddy on 28/01/20.
//  Copyright © 2020 PraneethReddy. All rights reserved.
//

import Foundation

class Node{
    
    var nodeId: Int
    var name: String
    var children = [Int:Node]()
    
    init(nodeId: Int, name: String){
        self.nodeId = nodeId
        self.name = name
        self.children = [Int:Node]()
    }
}

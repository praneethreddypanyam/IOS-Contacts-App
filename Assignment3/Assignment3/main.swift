//
//  main.swift
//  Assignment3
//
//  Created by Praneet Reddy on 28/01/20.
//  Copyright © 2020 PraneethReddy. All rights reserved.
//

import Foundation

var i = 1
var graph = [Int:Node]()
while i==1{
    
    print("Menu")
    print("1. Immediate parents of a node")
    print("2. Immediate children of a node")
    print("3. Ancestors of a node")
    print("4. Descendants of a node")
    print("5. Delete dependency from a tree")
    print("6. Delete a node from a tree")
    print("7. Add a new dependency to a tree")
    print("8. Add a new node to tree")
    print("9. End")
    
    if let choice = readLine(){
        if let choice1 = Int(choice){
            switch(choice1){
            case 1:
                parents(graph: graph)
            case 2:
                children(graph: graph)
            case 3:
                printAncestors(graph: graph)
            case 4:
                printDescendants(graph: graph)
            case 5:
                deleteDependancy(graph: graph)
            case 6:
                deleteNode(graph: &graph)
            case 7:
                addDependancy(graph: graph)
            case 8:
                newNode(graph: &graph)
            case 9:
                i=0
            default:
                print("Invalid Choice")
            }
        }
    }
}

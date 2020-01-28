//
//  functionality.swift
//  Assignment3
//
//  Created by Praneet Reddy on 28/01/20.
//  Copyright © 2020 PraneethReddy. All rights reserved.
//

import Foundation

var IdList = [Int:String]()

func getNode(Name: String) -> Int{
    var id:Int?
    while id == nil{
        print("Enter the",Name,"node id: ")
        if let temp = readLine(){
            if let temp1 = Int(temp){
                id = temp1
            }
        }
        if checkNode(Id: id!, graph: graph){
            return id!
        }
        else{
            print("Invalid Id . Reenter")
            id = nil
        }
        
    }
    return 0
}

func parents(graph: [Int:Node]){
    let NodeId = getNode(Name: "required")
    if let _ = graph[NodeId]{
        var parentsList = [Int]()
        for node in graph.values{
            if let _ = node.children[NodeId]{
                parentsList.append(node.nodeId)
            }
        }
        if parentsList.count > 0{
            print("Parents of node: ",NodeId,"are: ")
            for (index,_) in parentsList.enumerated(){
                print(parentsList[index])
            }
        }
        else{
            print("No parents.",NodeId,"is root node")
        }
    }
    else{
        print("Node with Id:",NodeId,"doesn't exist")
    }
}

func checkNode(Id: Int, graph: [Int:Node]) -> Bool{
    let temp = graph.keys
    if temp.contains(Id){
        return true
    }
    return false
}


func children(graph: [Int:Node]){
    let NodeId = getNode(Name: "required")
    let temp = graph[NodeId]!
    let temp1 = temp.children.keys
    if temp1.count > 0{
        print("Children are: ")
        for i in temp1{
            print(i)
        }
    }
    else{
        print(NodeId,"has no children")
    }
}


func getancestors(NodeId: Int, graph: [Int:Node]) -> [Int]{
    if let _ = graph[NodeId]{
        var parentsList = [Int]()
        for node in graph.values{
            if let _ = node.children[NodeId]{
                parentsList.append(node.nodeId)
            }
        }
        var ancestorsList = parentsList
        
        for parent in parentsList{
            let temp = getancestors(NodeId: parent,graph: graph)
            for i in temp {
                ancestorsList.append(i)
            }
        }
        return ancestorsList
        }
    return []
}


func printAncestors(graph: [Int:Node]){
    let NodeId = getNode(Name: "required")
    print("Ancestors are: ")
    let ancestors = getancestors(NodeId: NodeId, graph: graph)
    if ancestors.count > 0{
        for ancestor in ancestors{
            print(ancestor)
        }
    }
    else{
        print("No ancestors")
    }
}

func getDescendants(NodeId: Int, graph: [Int:Node]) -> [Int]{
    var descendants = [Int]()
    let temp = graph[NodeId]!
    let temp1 = temp.children.keys
    for i in temp1{
        descendants.append(i)
    }
    for j in temp1{
        let temp2 = getDescendants(NodeId: j, graph: graph)
        for k in temp2{
            descendants.append(k)
        }
    }
    return descendants
}


func printDescendants(graph: [Int:Node]){
    let NodeId = getNode(Name: "required")
    print("Descendants are: ")
    let descendants = getDescendants(NodeId: NodeId, graph: graph)
    if descendants.count > 0{
        for descendant in descendants{
            print(descendant)
        }
    }
    else{
        print("No descendants")
    }
    
}


func deleteDependancy(graph: [Int:Node]){
    let parentId = getNode(Name: "parent")
    let childId = getNode(Name: "child")
    let temp = graph[parentId]
    let temp2 = temp?.children.keys
    if temp2!.contains(childId){
        temp?.children.removeValue(forKey: childId)
        print("Deleted dependancy between",parentId,"and",childId)
    }
    else{
        print("No dependency between entered nodes")
    }
}

func deleteNode(graph: inout [Int:Node]){
    var Id:Int?
    while Id == nil{
        print("Enter the Id of node")
        if let temp = readLine(){
            if let temp1 = Int(temp){
                Id = temp1
            }
        }
        let temp2 = graph.keys
        if temp2.contains(Id!){
             graph.removeValue(forKey: Id!)
             print("Deleted node with Id",Id!)
        }
        else{
           print("Invalid node ID")
        }
    
    }
}

func addDependancy(graph: [Int:Node]){
    let parentId = getNode(Name: "parent")
    let childId = getNode(Name: "child")
    
    if checkcycle(parent: parentId,child: childId,graph: graph){
        let temp = graph[parentId]
        let temp1 = graph[childId]
        temp?.children[childId] = temp1
        print("Added dependancy between",parentId,"and",childId)
    }
    else{
        print("It is a cycle")
    }
}

func newNode(graph: inout [Int:Node]){
    var Id:Int?
    while Id == nil{
        print("Enter the Id for new node")
        if let temp = readLine(){
            if let temp1 = Int(temp){
                Id = temp1
            }
        }
        let temp2 = graph.keys
        if temp2.contains(Id!){
            print("Node with",Id!,"already exists")
            Id = nil
        }
    }
    
    
    print("Enter the name for new node")
    var Name:String?
    if let temp = readLine(){
        Name = temp
    }
    graph[Id!] = Node(nodeId: Id!, name: Name!)
    print("New node added")
}


func checkcycle(parent: Int,child: Int,graph: [Int:Node]) -> Bool{
    var ancestors = [Int]()
    ancestors = getancestors(NodeId: parent, graph: graph)
    return !ancestors.contains(child) && parent != child
}
  

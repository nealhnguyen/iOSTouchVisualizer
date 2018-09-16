//
//  Queue.swift
//  Example
//
//  Created by Neal Nguyen on 9/16/18.
//  Copyright © 2018 molabo. All rights reserved.
//

/* I was going to use this for dictionary of Queues for previous touches, for quicker pop and addition of new touches,
 but in the end it would be difficult to iterate over for the filter algorithm */
import Foundation

public class LinkedList<T> {
    var data: T
    var next: LinkedList?
    public init(data: T){
        self.data = data
    }
}

public class Queue<T> {
    typealias LLNode = LinkedList<T>
    var head: LLNode!
    public var isEmpty: Bool { return head == nil }
    var first: LLNode? { return head }
    var last: LLNode? {
        if var node = self.head {
            while case let next? = node.next {
                node = next
            }
            return node
        } else {
            return nil
        }
    }
    
    func enqueue(key: T) {
        let nextItem = LLNode(data: key)
        if let lastNode = last {
            lastNode.next = nextItem
        } else {
            head = nextItem
        }
    }
    func dequeue() -> T? {
        if self.head?.data == nil { return nil  }
        if let nextItem = self.head?.next {
            head = nextItem
        } else {
            head = nil
        }
        return head?.data
    }
    
}

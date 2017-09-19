// This a generic Linked List with some basic user functions.

import UIKit

public class LinkedListNode<T> {
  public private(set) var value: T
  public var next: LinkedListNode<T>?
  
  init(_ value: T, next: LinkedListNode? = nil) {
    self.value = value
    self.next = next
  }
}

public class LinkedList<T> {
  public private(set) var head: LinkedListNode<T>?
  public private(set) var tail: LinkedListNode<T>?
  public private(set) var count = 0
  
  init(_ head: LinkedListNode<T>? = nil, tail: LinkedListNode<T>? = nil) {
    self.head = head
    self.tail = tail
  }
  /// Private Functions ____________________________
  
  // Add a value to the front of the list
  private func addFirst(_ node: LinkedListNode<T>) {
    // Save current head node so it is not lost
    let temp = head
    
    // Point head to the new node
    head = node
    
    // Insert the rest of the list after the head
    head?.next = temp
    
    if tail == nil {
      tail = head
    }
    
    count += 1
  }
  
  // Add a value to the back of the list
  private func addLast(_ node: LinkedListNode<T>) {
    // Check that this is not the first node, but if it is make it the head
    if head == nil {
      head = node
    }else {
    // If it is not the first node, then link to the original tail
      tail?.next = node
    }
    // Now set the tail to the passed node
    tail = node
    // Increase count
    count += 1
  }
  
  // Remove value from the front of the list
  private func _removeFirst() {
    // Check for a first value
    if head != nil {
      
      // Set new head to the 2nd item
      head = head?.next
      
      // Check the new head for nil value
      if head == nil {
        tail = nil
      }
      
      // Reduce count by 1
      count -= 1
    }
  }
  
  // Remove value from the back of the list
  
  // Return the contents of the list
  
  /// User Functions ______________________
  
  public func addLast(_ value: T) {
    addLast(LinkedListNode<T>(value))
  }
  
  public func addFirst(_ value: T) {
    addFirst(LinkedListNode<T>(value))
  }
  
  public func removeFirst() {
    _removeFirst()
  }
}

var ourLinkedList = LinkedList<Any>()
ourLinkedList.addFirst(1)
ourLinkedList.addLast("Butts")
ourLinkedList.addFirst(2)

print("The list has \(ourLinkedList.count) linked objects")
print("Head: \(ourLinkedList.head!.value) , Tail: \(ourLinkedList.tail!.value)")
//print("The contents of the list are \()n/")

print(ourLinkedList.head!.value)
ourLinkedList.removeFirst()
print(ourLinkedList.head!.value)



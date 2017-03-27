//
//  SecondViewController.swift
//  GCDExample
//
//  Created by Rolando Asmat on 4/14/16.
//  Copyright © 2016 YAMS. All rights reserved.
//

import UIKit
import Foundation

class SecondViewController: UIViewController {
    let db = [("Yrua", "25"),
              ("Andre", "24"),
              ("Marcelo", "19"),
              ("Silvia", "17")]
    
    var people = [Person]()

    @IBOutlet weak var mainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func example4Pressed(_ sender: UIButton) {
        self.exampleFour()
    }
    
    @IBAction func example5Pressed(_ sender: UIButton) {
        self.exampleFive()
    }
    
    
    func addPerson(_ person:Person) {
        self.people.append(person)
        print(self.people)
    }
    
    func addPerson(_ person:Person, queue:DispatchQueue) {
        GCD.runAsyncBarrier(queue) {
            self.people.append(person)
            print(self.people)
        }
    }
    
    /**
     This example shows how to protect a critical section
     */
    func exampleFour() {
        self.people.removeAll()
        print()
        // The main use case here is protection a resource from a custom concurrent queue, first create one
        let myQueue = GCD.createConcurrentQueue("MyOneAndOnlyQueue")
        for entry in db {
            GCD.runAsync(myQueue) {
                self.addPerson(Person(name: entry.0, age: entry.1), queue: myQueue)
            }
        }
    }
    
    /**
     Here we will make several async calls, create a group to keep track of the tasts and update the UI once complete
     */
    func exampleFive() {
        print()
        // Let's get a global concurrent queue to run tasks ins
        let globalQueue = GCD.getGlobalQueue(DispatchQoS.QoSClass.userInitiated)
        // Create group
        let group = GCD.getGroup()
        var total = 0
        for i in 0...10 {
            GCD.enterGroup(group)
            GCD.runAsync(globalQueue) {
                var sum = 0
                for j in 0...10 {
                    sum += i * j
                }
                total += sum
                GCD.leaveGroup(group)
            }
        }
        print("Finished at \(total)")
        GCD.groupComplete(group, queue: GCD.getMainQueue()) {
            self.mainLabel.text = "Finished."
            print("Finished for reals: \(total)")
        }
    }


}

struct Person {
    let name:String
    let age:String
    
    init(name:String, age:String) {
        self.name = name
        self.age = age
    }
}

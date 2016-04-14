//
//  SecondViewController.swift
//  GCDExample
//
//  Created by Rolando Asmat on 4/14/16.
//  Copyright © 2016 YAMS. All rights reserved.
//

import UIKit

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
    
    @IBAction func exampleThree(sender: UIButton) {
        self.exampleThree()
    }
    
    
    @IBAction func Example4(sender: UIButton) {
        self.exampleFour()
    }
    
    
    func addPerson(person:Person) {
        self.people.append(person)
        print(self.people)
    }
    
    func addPerson(person:Person, queue:dispatch_queue_t) {
        GCD.runAsyncBarrier(queue) {
            self.people.append(person)
            print(self.people)
        }
    }
    
    /**
     This example shows how to protect a critical section
     */
    func exampleThree() {
        self.people.removeAll()
        print()
        // The main use case here is protection a resource from a custom concurrent queue, first create one
        let myQueue = GCD.createConcurrentQueue("MyOneAndOnlyQueue")
        let globalQueue = GCD.getGlobalQueue(QualityOfService.Utility)
        for entry in db {
            GCD.runAsync(globalQueue) {
                self.addPerson(Person(name: entry.0, age: entry.1), queue: myQueue)
            }
        }
    }
    
    /**
     Here we will make several async calls, create a group to keep track of the tasts and update the UI once complete
     */
    func exampleFour() {
        print()
        // Let's get a global concurrent queue to run tasks ins
        let globalQueue = GCD.getGlobalQueue(QualityOfService.UserInitiated)
        // Create group
        let group = GCD.getGroup()
        var total = 0
        for index in 0...10 {
            GCD.enterGroup(group)
            GCD.runAsync(globalQueue) {
                var sum = 0
                for index in 0...10 {
                    sum += index
                }
                total += sum
                GCD.leaveGroup(group)
            }
        }
        GCD.groupComplete(group, queue: GCD.getMainQueue()) {
            self.mainLabel.text = "Finished."
            print("Finished total: \(total)")
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

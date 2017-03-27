//
//  FirstViewController.swift
//  GCDExample
//
//  Created by Rolando Asmat on 4/14/16.
//  Copyright © 2016 YAMS. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func example1Pressed(_ sender: UIButton) {
        self.exampleOne()
    }
    
    @IBAction func example2Pressed(_ sender: UIButton) {
        self.exampleTwo()
    }

    /**
     Basic use of getting a global queue, creating custom queues and running tasks on them.
     */
    func exampleOne() {
        print("\n")
        // Get a reference to the main queue
        let mainQueue = GCD.getMainQueue()
        // Add a task to the main queue asynchronously
        GCD.runAsync(mainQueue) {
            print("1. Hello from the main queue!")
        }
        
        // Get the user initiated QOS global queue
        let globalQueue = GCD.getGlobalQueue(DispatchQoS.QoSClass.userInitiated)
        // Add small math task to queue
        GCD.runAsync(globalQueue) {
            var sum = 0
            for index in 0...100 {
                sum += index
            }
            print("2. Finished! the sum is \(sum)")
        }
        
        // Create a custom concurrent queue
        let myQueue = GCD.createConcurrentQueue("RolandosQueue")
        // Add a long task to custom queue
        GCD.runAsync(myQueue) {
            var sum = 0
            let randomNum = Int(arc4random_uniform(20)*100)
            for index in 0...randomNum {
                sum += index
            }
            print("3. Finally finished, the sum is \(sum)")
        }
        
        // Add a very easy task to same custom queue
        GCD.runAsync(myQueue) {
            print("4. This task didn't even do anything!")
        }
        print("Finished.")
    }
    
    
    /**
     This shows how after an async task is done how to update the UI, recall that this can ONLY be done in the main thread.
     */
    func exampleTwo() {
        // Get the user initiated QOS global queue
        let globalQueue = GCD.getGlobalQueue(DispatchQoS.QoSClass.userInitiated)
        // Add a small math operation task
        GCD.runAsync(globalQueue) {
            var sum = 0
            let randomNum = Int(arc4random_uniform(20)*100)
            for index in 0...randomNum {
                sum += index
            }
            
//            self.mainLabel.text = String(sum) //<- This will print warnings to the console, do not do this!
//            //Instead, update the UI in the main queue
            
            GCD.runAsync(GCD.getMainQueue()) {
                self.mainLabel.text = String(sum)
            }
            
        }
    }
    
}


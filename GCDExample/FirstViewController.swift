//
//  FirstViewController.swift
//  GCDExample
//
//  Created by Rolando Asmat on 4/14/16.
//  Copyright © 2016 YAMS. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.exampleOne()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func exampleOne() {
        
        // Get the main queue
        let mainQueue = GCD.getMainQueue()
        // Add a task to the main queue asynchronously
        GCD.runAsync(mainQueue) {
            print("Hello from the main queue!")
        }
        
        // Get the user initiated QOS global queue and run a small math operation
        let queue = GCD.getGlobalQueue(QualityOfService.UserInitiated)
        GCD.runAsync(queue) {
            var sum = 0
            for index in 0...10000 {
                sum += index
            }
            print("Finished! the sum is \(sum)")
        }
        
        // Run something that might take a little longer
        GCD.runAsync(queue) {
            var sum = 0
            for index in 0...1000000000 {
                sum += index
            }
            print("Finally finished, the sum is \(sum)")
        }
        
    }



}


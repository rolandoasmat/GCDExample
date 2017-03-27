//
//  GCD.swift
//  GCDExample1
//
//  Created by Rolando Asmat on 4/13/16.
//  Copyright © 2016 YAMS. All rights reserved.
//
// References: 
// - https://developer.apple.com/reference/dispatch
// - https://www.raywenderlich.com/148513/grand-central-dispatch-tutorial-swift-3-part-1
//

import Foundation

public struct GCD {
    
    // A task will always be a closure with no parameters and void return
    public typealias Task = () -> Void
    
}

// MARK: Queues
extension GCD {
    
    /// Main queue:
    /// Runs on the main thread and is a serial queue.
    public static func getMainQueue() -> DispatchQueue {
        return DispatchQueue.main
    }
    
    /// Global queues:
    /// Concurrent queues that are shared by the whole system. 
    /// When setting up a Global Queue specify a QualityOfService in order for the 
    /// system to determine a priority.
    public static func getGlobalQueue(_ qualityOfService:DispatchQoS.QoSClass) -> DispatchQueue {
        return DispatchQueue.global(qos: qualityOfService)
    }
    
    /// Custom queues: 
    /// Queues that you create which can be serial or concurrent.
    /// These actually trickle down into being handled by one of the global queues.
    public static func createConcurrentQueue(_ name:String) -> DispatchQueue {
        return DispatchQueue(label: name, attributes: DispatchQueue.Attributes.concurrent)
    }
    public static func createSerialQueue(_ name:String) -> DispatchQueue {
        return DispatchQueue(label: name, attributes: [])
    }
    
}


// MARK: Dispatching Tasks
extension GCD {
    
    /// Run task Asynchronously
    /// An asynchronous function returns immediately, ordering the task to be done but not waiting for it. 
    /// Thus, an asynchronous function does not block the current thread of execution from proceeding on to the next function.
    public static func runAsync(_ queue:DispatchQueue, task:@escaping Task) {
        queue.async(execute: task)
    }
    
    /// Run task Synchronously 
    /// A synchronous function returns control to the caller after the task is completed.
    public static func runSync(_ queue:DispatchQueue, task:Task) {
        queue.sync(execute: task)
    }
    
}

// MARK: Barriers
extension GCD {
    
    // Only 1 task will run at a time in provided queue
    public static func runAsyncBarrier(_ queue:DispatchQueue, task:@escaping Task) {
        queue.async(flags: .barrier, execute: task)
    }
    
    public static func runSyncBarrier(_ queue:DispatchQueue, task:Task) {
        queue.sync(flags: .barrier, execute: task)
    }
    
}

// MARK: Groups
extension GCD {
    
    public static func getGroup() -> DispatchGroup {
        return DispatchGroup()
    }
    
    public static func enterGroup(_ group:DispatchGroup) {
        group.enter()
    }
    
    public static func leaveGroup(_ group:DispatchGroup) {
        group.leave()
    }
    
    public static func groupComplete(_ group:DispatchGroup, queue:DispatchQueue, task:@escaping Task) {
        group.notify(queue: queue, execute: task)
    }
    
}


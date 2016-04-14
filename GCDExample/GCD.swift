//
//  GCD.swift
//  GCDExample1
//
//  Created by Rolando Asmat on 4/13/16.
//  Copyright © 2016 YAMS. All rights reserved.
//

import Foundation

public struct GCD {
    
    // A task will always be a closure with no parameters and void return
    public typealias Task = () -> Void
    
}

// MARK: Queues
extension GCD {
    
    // Main queue is a serial queue
    public static func getMainQueue() -> dispatch_queue_t {
        return dispatch_get_main_queue()
    }
    
    // All global queues are concurrent queues
    public static func getGlobalQueue(qualityOfService:QualityOfService) -> dispatch_queue_t {
        return dispatch_get_global_queue(qualityOfService.value, 0)
    }
    
    public static func createConcurrentQueue(name:String) -> dispatch_queue_t {
        return dispatch_queue_create(name, DISPATCH_QUEUE_CONCURRENT)
    }
    
    public static func createSerialQueue(name:String) -> dispatch_queue_t {
        return dispatch_queue_create(name, DISPATCH_QUEUE_SERIAL)
    }
    
}


// MARK: Asysnc/sync calls
extension GCD {
    
    public static func runAsync(queue:dispatch_queue_t, task:Task) {
        dispatch_async(queue, task)
    }
    
    public static func runAsync(queue:dispatch_queue_t, delayInSeconds:Double, task:Task) {
        let delay = Int64(delayInSeconds*Double(NSEC_PER_SEC))
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        dispatch_after(dispatchTime, queue, task)
    }
    
    public static func runSync(queue:dispatch_queue_t, task:Task) {
        dispatch_sync(queue, task)
    }
    
}

// MARK: Barriers
extension GCD {
    
    // Only 1 task will run at a time in provided queue
    public static func runAsyncBarrier(queue:dispatch_queue_t, task:Task) {
        dispatch_barrier_async(queue, task)
    }
    
    public static func runSyncBarrier(queue:dispatch_queue_t, task:Task) {
        dispatch_barrier_sync(queue, task)
    }
    
}

// MARK: Groups
extension GCD {
    
    public static func getGroup() -> dispatch_group_t {
        return dispatch_group_create()
    }
    
    public static func enterGroup(group:dispatch_group_t) {
        dispatch_group_enter(group)
    }
    
    public static func leaveGroup(group:dispatch_group_t) {
        dispatch_group_leave(group)
    }
    
    public static func groupComplete(group:dispatch_group_t, queue:dispatch_queue_t, task:Task) {
        dispatch_group_notify(group, queue, task)
    }
    
}

// MARK: Timers
extension GCD {
    
    public static func timerAsync(queue:dispatch_queue_t, interval:Double, task:Task) -> dispatch_source_t {
        let timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, UInt64(interval * Double(NSEC_PER_SEC)), 100)
        dispatch_source_set_event_handler(timer, task)
        dispatch_resume(timer)
        return timer
    }
    
    public static func timerStop(timer:dispatch_source_t) {
        dispatch_source_cancel(timer)
    }
    
}

// MARK: Quality of Service
public enum QualityOfService {
    
    // Ordered by priority
    case UserInteractive
    case UserInitiated
    case Default
    case Utility
    case Background
    
    var value:Int {
        switch self {
        case .UserInteractive:
            return Int(QOS_CLASS_USER_INTERACTIVE.rawValue)
        case .UserInitiated:
            return Int(QOS_CLASS_USER_INITIATED.rawValue)
        case .Default:
            return Int(QOS_CLASS_DEFAULT.rawValue)
        case .Utility:
            return Int(QOS_CLASS_UTILITY.rawValue)
        case .Background:
            return Int(QOS_CLASS_BACKGROUND.rawValue)
        }
    }
    
}
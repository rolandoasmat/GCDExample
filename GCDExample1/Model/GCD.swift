//
//  GCD.swift
//  GCDExample1
//
//  Created by Rolando Asmat on 4/13/16.
//  Copyright © 2016 YAMS. All rights reserved.
//

import Foundation

public struct GCD {
    
    public typealias Closure = () -> Void

}

// MARK: Queues
extension GCD {
    
    public static func getMainQueue() -> dispatch_queue_t {
        return dispatch_get_main_queue()
    }
    
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


// MARK: Asysnc calls
extension GCD {
    
    public static func runAsync(queue:dispatch_queue_t, task:Closure) {
        dispatch_async(queue, task)
    }
    
    public static func runAsync(queue:dispatch_queue_t, delayInSeconds:Double, task:Closure) {
        let delay = Int64(delayInSeconds*Double(NSEC_PER_SEC))
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        dispatch_after(dispatchTime, queue, task)
    }
    
}

// MARK: Quality of Service
public enum QualityOfService {
    
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
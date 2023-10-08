// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import ObjectiveC.runtime

public protocol TaskPoollable {
    func tasksPool(@TasksPool _ callback: () -> TasksPool)
}

private enum TPKey {
    static var tasksPools = 0
}

public extension TaskPoollable where Self: AnyObject {
    private var __tasksPools: [TasksPool] {
        get {
            (objc_getAssociatedObject(self, &TPKey.tasksPools) as? [TasksPool]) ?? []
        }
        set {
            objc_setAssociatedObject(self, &TPKey.tasksPools, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func tasksPool(@TasksPool _ callback: () -> TasksPool) {
        __tasksPools.append(callback())
    }
}

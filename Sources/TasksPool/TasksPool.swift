// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import ObjectiveC.runtime

public protocol TaskPoollable {
    func tasksPool(@TasksPool _ callback: () -> TasksPool)
}

private enum TPKey {
    static var tasksPooll = 0
}

public extension TaskPoollable where Self: AnyObject {
    private var __tasksPools: [TasksPool] {
        get {
            (objc_getAssociatedObject(self, &TPKey.tasksPooll) as? [TasksPool]) ?? []
        }
        set {
            objc_setAssociatedObject(self, &TPKey.tasksPooll, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func tasksPool(@TasksPool _ callback: () -> TasksPool) {
        __tasksPools.append(callback())
    }
}

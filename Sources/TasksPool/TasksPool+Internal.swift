//
//  File.swift
//  
//
//  Created by Alex Antonyuk on 08.10.2023.
//

import Foundation

protocol CancellableTask {
    func cancel()
    func store(in storage: inout [any CancellableTask])
}

extension Task: CancellableTask {
    func store(in storage: inout [any CancellableTask]) {
        storage.append(self)
    }
}

@resultBuilder
public final class TasksPool {

    deinit {
        tasks.forEach { $0.cancel() }
    }

    init(tasks: [any CancellableTask]) {
        self.tasks = tasks
    }

    private var tasks: [any CancellableTask] = []

    public static func buildBlock<each V, each E>(_ component: repeat Task<each V, each E>) -> TasksPool {
        let result = TasksPool(tasks: [])
        (repeat (each component).store(in: &result.tasks))
        return result
    }
}

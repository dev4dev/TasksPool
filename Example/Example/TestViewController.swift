//
//  TestViewController.swift
//  Example
//
//  Created by Alex Antonyuk on 08.10.2023.
//

import UIKit
import TasksPool

final class TestViewController: UIViewController, TaskPoollable {

    deinit {
        print("☠️ dead \(self)")
    }

    let useIt: Bool
    init(useIt: Bool) {
        self.useIt = useIt
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = .init(systemItem: .close, primaryAction: .init(handler: { [weak self] _ in
            self?.dismiss(animated: true)
        }))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        run()
    }

    private func run() {
        if useIt {
            // it will be cancelled in VC deinit
            tasksPool {
                Task {
                    Task.detached {
                        try await Task.sleep(for: .seconds(4.0))
                        print("this will end anyway")
                    }

                    try await Task.sleep(for: .seconds(4.0))
                    print("task result")
                }
            }
        } else {
            // it will continue running
            Task {
                try await Task.sleep(for: .seconds(4.0))
                print("task result")
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.dismiss(animated: true)
        }
    }
}

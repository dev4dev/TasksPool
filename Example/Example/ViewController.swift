//
//  ViewController.swift
//  Example
//
//  Created by Alex Antonyuk on 08.10.2023.
//

import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        let label = UILabel()
        label.text = "Use It"
        let switcher = UISwitch()
        
        let hstack = UIStackView(arrangedSubviews: [label, switcher])
        hstack.axis = .horizontal
        hstack.spacing = 10.0

        let button = UIButton(primaryAction: .init(title: "Test", handler: { [weak self] _ in
            self?.present(UINavigationController(rootViewController: TestViewController(useIt: switcher.isOn)), animated: true)
        }))

        let vstack = UIStackView(arrangedSubviews: [hstack, button])
        vstack.axis = .vertical
        vstack.spacing = 10.0
        vstack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(vstack)
        vstack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vstack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}


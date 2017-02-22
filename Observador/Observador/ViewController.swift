//
//  ViewController.swift
//  Observador
//
//  Created by Ariel Elkin on 21/02/2017.
//  Copyright © 2017 NSConfArg. All rights reserved.
//

import UIKit

class VistaSujeto: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .orange
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        print("touches: \(touches.first!.location(in: self).x)")
    }
}

class VistaRoja: VistaSimple {
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .red
    }
    func respond() {
        label.text = "hello!"
    }
}

class VistaAzul: VistaSimple {
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .cyan
    }
    func respond() {
        label.text = "hello!"
    }
}



class VistaVerde: VistaSimple {
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .green
    }
    func respond() {
        label.text = "hello!"
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var viewsDict = [String: UIView]()


        // Inicializar Sujeto Concreto:

        let button = VistaSujeto()
        viewsDict["button"] = button
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)

        // Inicializar Observadores Concretos:

        let vistaRoja = VistaRoja()
        vistaRoja.translatesAutoresizingMaskIntoConstraints = false
        viewsDict["vistaRoja"] = vistaRoja
        view.addSubview(vistaRoja)

        let vistaAzul = VistaAzul()
        vistaAzul.translatesAutoresizingMaskIntoConstraints = false
        viewsDict["vistaAzul"] = vistaAzul
        view.addSubview(vistaAzul)

        let vistaVerde = VistaVerde()
        vistaVerde.translatesAutoresizingMaskIntoConstraints = false
        viewsDict["vistaVerde"] = vistaVerde
        view.addSubview(vistaVerde)

        let visualConstraints = [
            "H:|-[button]-|",
            "H:|-[vistaRoja]-|",
            "H:|-[vistaAzul]-|",
            "H:|-[vistaVerde]-|",
            "V:|-40-[vistaRoja(>=100)]-[button(>=100)]-[vistaAzul(vistaRoja)]-[vistaVerde(vistaRoja)]-40-|"
        ]

        let constraints = visualConstraints.flatMap {
            NSLayoutConstraint.constraints(withVisualFormat: $0,
                                           options: [],
                                           metrics: nil,
                                           views: viewsDict)
        }

        NSLayoutConstraint.activate(constraints)

    }

    func tappedButton() {
        print("tapped!")
    }
}


class VistaSimple: UIView {

    let label = UILabel()

    override init(frame: CGRect) {

        super.init(frame: frame)

        label.text = "nothing happened"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)

        label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

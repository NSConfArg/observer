//
//  ViewController.swift
//  Observador
//
//  Created by Ariel Elkin on 21/02/2017.
//  Copyright © 2017 NSConfArg. All rights reserved.
//

import UIKit

protocol Subject {
    func add(observer: Observer)
    func remove(observer: Observer)
}

protocol Observer: class {
    func receive(event: Event)
}

protocol Event {
    var message: String { get }
}

struct MyCGPointEvent: Event {
    let point: CGPoint
    var message: String
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


class VistaSujeto: VistaSimple, Subject {

    var observers = [VistaObservadora]()

    internal func remove(observer: Observer) {
        observers = observers.filter { $0 !== observer }
    }

    internal func add(observer: Observer) {
        if let observer = observer as? VistaObservadora {
            observers.append(observer)
        }
        else {
            assertionFailure()
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        print("touches: \(touches.first!.location(in: self).x)")
        let point = touches.first!.location(in: self)

        for observer in observers {
            observer.receive(event: MyCGPointEvent(point: point, message: ""))
        }
    }

}

class VistaObservadora: VistaSimple, Observer {
    internal func receive(event: Event) {
        if let event = event as? MyCGPointEvent {
            label.text = "\(event.point.x), \(event.point.y)"
        }
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var viewsDict = [String: UIView]()


        // Inicializar Sujeto Concreto:

        let vistaAzul = VistaSujeto()
        vistaAzul.backgroundColor = .blue
        vistaAzul.label.text = "Touch and drag"
        vistaAzul.translatesAutoresizingMaskIntoConstraints = false
        viewsDict["vistaAzul"] = vistaAzul
        view.addSubview(vistaAzul)


        // Inicializar Observadores Concretos:

        let vistaRoja = VistaObservadora()
        vistaRoja.backgroundColor = .red
        vistaRoja.translatesAutoresizingMaskIntoConstraints = false
        viewsDict["vistaRoja"] = vistaRoja
        view.addSubview(vistaRoja)


        let vistaVerde = VistaObservadora()
        vistaVerde.backgroundColor = .green
        vistaVerde.translatesAutoresizingMaskIntoConstraints = false
        viewsDict["vistaVerde"] = vistaVerde
        view.addSubview(vistaVerde)

        let vistaVioleta = VistaObservadora()
        vistaVioleta.backgroundColor = .purple
        vistaVioleta.translatesAutoresizingMaskIntoConstraints = false
        viewsDict["vistaVioleta"] = vistaVioleta
        view.addSubview(vistaVioleta)


        // Definir relaciones entre Sujeto y Observadores:

        vistaAzul.add(observer: vistaRoja)
        vistaAzul.add(observer: vistaVerde)
        vistaAzul.add(observer: vistaVioleta)

        let visualConstraints = [
            "H:|-[vistaAzul]-|",
            "H:|-[vistaRoja]-|",
            "H:|-[vistaVerde]-|",
            "H:|-[vistaVioleta]-|",
            "V:|-40-[vistaAzul(>=100)]-[vistaRoja(vistaAzul)]-[vistaVerde(vistaAzul)]-4-[vistaVioleta(vistaAzul)]-40-|"
        ]

        let constraints = visualConstraints.flatMap {
            NSLayoutConstraint.constraints(withVisualFormat: $0,
                                           options: [],
                                           metrics: nil,
                                           views: viewsDict)
        }

        NSLayoutConstraint.activate(constraints)

    }
}

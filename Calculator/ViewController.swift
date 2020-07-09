//
//  ViewController.swift
//  LessonOne
//
//  Created by Nulrybek Karshyga on 7/1/20.
//  Copyright © 2020 Nulrybek Karshyga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @objc func btnClicked(_ sender: UIButton) {
        let title = sender.title(for: .normal) ?? "0"
        let operations = ["AC","="]

        if operations.allSatisfy({ (op) -> Bool in
            op != title
        }) {
            outputPanel.text! += title
        } else {
            switch title {
            case "AC":
                outputPanel.text = ""
            case "=":
                guard outputPanel.text != "0.0" else { return }
                let expression = NSExpression(format: outputPanel.text ?? "")
                guard let result = expression.toFloatingPoint().expressionValue(with: nil, context: nil) as? Double else { return }
                print(result)
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 7
                guard let value = formatter.string(from: NSNumber(value: result)) else { return }
                outputPanel.text = value
            case "+","-","*","/","%": break
            default:
                outputPanel.text = ""
            }
            
        }
        print("\(String(describing: title))")
        }
    
    
    
    @IBOutlet weak var outputPanel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // setup for the label
        outputPanel.layer.borderColor = UIColor.darkGray.cgColor
        outputPanel.layer.borderWidth = 3.0
        
        
        for i in 0..<5 {
            let numbers = ["AC",7,4,1,0] as [Any]
            let btn = createButton(x: 30, y: Double(400+(i*70)), name: "\(numbers[i])", color:UIColor.lightGray)
            view.addSubview(btn)
        }
        for i in 0..<4 {
            let numbers = ["",8,5,2] as [Any]
            let btn = createButton(x: 120, y: Double(400+(i*70)), name: "\(numbers[i])", color: UIColor.lightGray)
            view.addSubview(btn)
        }
        for i in 0..<5 {
            let numbers = ["%",9,6,3,"."] as [Any]
            let btn = createButton(x: 210, y: Double(400+(i*70)), name: "\(numbers[i])", color: UIColor.lightGray)
            view.addSubview(btn)
        }
        for i in 0..<5 {
            let numbers = ["/","*","-","+","="] as [Any]
            let btn = createButton(x: 300, y: Double(400+(i*70)), name: "\(numbers[i])", color: UIColor.orange)
            view.addSubview(btn)
        }
        outputPanel.text = ""
    }

    
    func createButton(x: Double, y: Double, name: String, color: UIColor) -> UIButton {
        let frameOfOpenLogin = CGRect(x: x, y: y, width: 90, height: 60)
        let btn = UIButton.init(frame: frameOfOpenLogin)
        btn.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        btn.setTitle(name, for: .normal)
        btn.backgroundColor = color
        return btn
    }
    
    
}

extension NSExpression {

    func toFloatingPoint() -> NSExpression {
        switch expressionType {
        case .constantValue:
            if let value = constantValue as? NSNumber {
                return NSExpression(forConstantValue: NSNumber(value: value.doubleValue))
            }
        case .function:
           let newArgs = arguments.map { $0.map { $0.toFloatingPoint() } }
           return NSExpression(forFunction: operand, selectorName: function, arguments: newArgs)
        case .conditional:
           return NSExpression(forConditional: predicate, trueExpression: self.true.toFloatingPoint(), falseExpression: self.false.toFloatingPoint())
        case .unionSet:
            return NSExpression(forUnionSet: left.toFloatingPoint(), with: right.toFloatingPoint())
        case .intersectSet:
            return NSExpression(forIntersectSet: left.toFloatingPoint(), with: right.toFloatingPoint())
        case .minusSet:
            return NSExpression(forMinusSet: left.toFloatingPoint(), with: right.toFloatingPoint())
        case .subquery:
            if let subQuery = collection as? NSExpression {
                return NSExpression(forSubquery: subQuery.toFloatingPoint(), usingIteratorVariable: variable, predicate: predicate)
            }
        case .aggregate:
            if let subExpressions = collection as? [NSExpression] {
                return NSExpression(forAggregate: subExpressions.map { $0.toFloatingPoint() })
            }
        case .anyKey:
            fatalError("anyKey not yet implemented")
        case .block:
            fatalError("block not yet implemented")
        case .evaluatedObject, .variable, .keyPath:
            break // Nothing to do here
        }
        return self
    }
}

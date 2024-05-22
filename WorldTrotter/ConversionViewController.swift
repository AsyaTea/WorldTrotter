//
//  ViewController.swift
//  WorldTrotter
//
//  Created by Asya Tealdi on 20/12/2023.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var celsiusLabel: UILabel!
    var farenheitValue: Measurement<UnitTemperature>?  {
        didSet {
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Measurement<UnitTemperature>? {
        if let farenheitValue = farenheitValue  {
            return farenheitValue.converted(to: .celsius)
        } else { return nil }
    }
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let firstFrame = CGRect(x: 160, y: 240, width: 100, height: 150)
//        let firstView = UIView(frame: firstFrame)
//        firstView.backgroundColor = UIColor.blue
//        view.addSubview(firstView)
//        
//        let secondFrame = CGRect(x: 20, y: 30, width: 50, height: 50)
//        let secondView = UIView(frame: secondFrame)
//        secondView.backgroundColor = UIColor.green
//        firstView.addSubview(secondView)
        print("ConversionVC loaded its view")
        
        updateCelsiusLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        view.backgroundColor = .random()
    }
    @IBAction func fahrenheitFieldEditingChanged(_ sender: Any) {
        if let text = textField.text , let value = Double(text) {
            farenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            farenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"

        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let existingTextHasDecimalSeparator = textField.text?.ranges(of: ",")
        let replacementTextHasDecimalSeparator = string.range(of: ",")
        
        if existingTextHasDecimalSeparator != nil,
           replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
    }
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}


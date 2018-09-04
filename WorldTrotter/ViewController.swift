//
//  ViewController.swift
//  WorldTrotter
//
//  Created by Heidi Fawson on 8/28/18.
//  Copyright © 2018 Heidi Fawson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var celsiusLabel: UILabel!
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Measurement<UnitTemperature>? {
        if let f = self.fahrenheitValue {
            return f.converted(to: .celsius)
        }
        else {
            return nil
        }
    }
    
    func updateCelsiusLabel() {
        if let c = celsiusValue {
            self.celsiusLabel.text = numberFormatter.string(from: NSNumber(value: c.value))
        }
        else {
            self.celsiusLabel.text="???"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateCelsiusLabel()
        print("conversion controller loaded")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func dissmissKeyboard(_ sender: UITapGestureRecognizer) {
        self.textField.resignFirstResponder()
    }
    
    @IBAction func fahrenheitFieldEditingChanged(_ sender: UITextField) {
        if let text = textField.text, let v = Double(text) {
            self.fahrenheitValue = Measurement(value: v, unit: .fahrenheit)
        }
        else{
            self.fahrenheitValue = nil
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //print("Replacement: \(string)")
        //print("Current: \(textField.text)")
        
        let existingDecimal = textField.text?.range(of: ".")
        let replacementDecimal = string.range(of: ".")
        
        if existingDecimal != nil && replacementDecimal != nil {
            return false
        } else {
            return true
        }
    }
}


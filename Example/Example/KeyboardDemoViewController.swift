//
//  KeyboardDemoViewController.swift
//  Example
//

import UIKit

final class KeyboardDemoViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textField.resignFirstResponder()
    }
    
    @IBAction func cancelButtonDidTapp(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

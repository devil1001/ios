
import UIKit

class ViewController: UIViewController {

    @IBOutlet var display: UILabel!
    
    private var userStartedTyping = false
    private var userSendPoint = false
    
    private let calculator = Calculator()
    
    var displayedNumber: Double {
        get {
            return Double(display.text!) ?? 0.0
        }
        
        set {
            display.text = String(newValue)
            calculator.setNumber(number: newValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func resetButtonPressed(_ sender: AnyObject) {
        display.text = "0"
        userStartedTyping = false
        userSendPoint = false
        calculator.setNumber(number: displayedNumber)
    }
    
    @IBAction func operationButtonPressed(_ sender: AnyObject) {
        guard let button = sender as? UIButton else {
            return
        }
        
        guard let op = button.currentTitle else {
            return
        }
        
        displayedNumber = calculator.performOperation(operation: op)
        userStartedTyping = false
        userSendPoint = false
    }
    
    @IBAction func numberButtonPressed(_ sender: AnyObject) {
        guard let button = sender as? UIButton else {
            return
        }

        guard let currentText = display.text, let number = button.currentTitle else {
            return
        }
        
        if userStartedTyping {
            display.text = currentText + number
        } else {
            display.text = number
        }
        
        calculator.setNumber(number: displayedNumber)
        userStartedTyping = true
    }
    
    @IBAction func pointButtonPressed(_ sender: AnyObject){
        guard let button = sender as? UIButton else {
                return
        }
        
        guard userSendPoint == false else {
            return
        }
        
        guard let currentText = display.text, let point = button.currentTitle else {
            return
        }
        
        if userStartedTyping {
            display.text = currentText + point
        } else {
            display.text = "0."
            userStartedTyping = true
        }
        userSendPoint = true
    }
}


//
//  ViewController.swift
//  LowCostFinder
//
//  Created by Jeevanantham Kalyanasundram on 3/8/17.
//  Copyright © 2017 Jeevanantham Kalyanasundram. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    // MARK: -
    var rowValue: Int = 0
    var columnValue: Int = 0
    var rowIndex: Int = 0
    var columnIndex: Int = 0
    
    var cost = [[Int]]()
    
    
    // MARK: -
    // MARK: @IBOutlet variables
    
    @IBOutlet weak var  getArrayInputBtn: UIButton!
    @IBOutlet weak var  getResultBtn: UIButton!
    @IBOutlet weak var  rowTextField: UITextField!
    @IBOutlet weak var  columnTextField: UITextField!
    @IBOutlet weak var arrayValue: UITableView!
    @IBOutlet weak var inputArrayValueDisplayLbl: UILabel!
    @IBOutlet weak var statusDisplayLbl: UILabel!
    @IBOutlet weak var minCostLbl:UILabel!
    
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: -
    // MARK: User define methods
    
    func showAlertView(iteration: Int) {
        
        var inputTextField: UITextField?
        inputTextField?.delegate = self
        
        let alertController = UIAlertController(title: "Input", message: "Enter value for row no \(iteration) with comma separator and without space", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            // Do whatever you want with inputTextField?.text
            
            guard let valuesForRow = inputTextField?.text!, !(inputTextField?.text?.isEmpty)! else {
                return
            }
            
            let arrayOfTextInput = valuesForRow.components(separatedBy: ",")
            
            let rowValueOfCost = arrayOfTextInput.map { Int($0)!}
            
            self.cost.append(rowValueOfCost )
            
            print(self.cost)
            
            if (self.rowIndex < (self.rowValue-1)) {
                self.rowIndex += 1
                self.columnIndex = 0
                
                self.showAlertView(iteration: self.rowIndex)
            }
            else {
                self.inputArrayValueDisplayLbl.text = "\(self.cost)"
            }
            
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in }
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        alertController.addTextField { (textField) -> Void in
            textField.delegate = self
            inputTextField = textField
        }
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    // MARK: -
    // MARK:  IBAction methods
    @IBAction func getArrayInputBtnClicked(_ sender: Any) {
        
        guard let noOfRows: Int = Int(rowTextField.text!), !(rowTextField.text?.isEmpty)! else {
            return
        }
        
        rowValue = noOfRows
        
        guard let noOfColumns: Int = Int(columnTextField.text!), !(columnTextField.text?.isEmpty)! else {
            return
        }
        
        columnValue = noOfColumns
        
        
        self.showAlertView(iteration: self.rowIndex)
        
    }

    @IBAction func getResult(_ sender: Any) {
        
        let r = cost.count
        var initialCost = 0
        var arrayOfInitialCost = [Int]()
        
        for iteration in 0...(r-1) {
            arrayOfInitialCost.append(cost[iteration][0])
        }
        
        initialCost = arrayOfInitialCost.min()!
            
        let indexOfA = arrayOfInitialCost.index(of: initialCost)
            
        minCostLbl.text = "\(self.minCost(cost: cost, m: indexOfA!, n: 0))"
        
        if self.minCost(cost: cost, m: 0, n: 0) > 50 {
            statusDisplayLbl.text = "NO"
        }
        else {
            statusDisplayLbl.text = "YES"
        }
    }
    
    func minCost(cost: [[Int]], m: Int, n: Int) -> (Int) {
        
        let r = cost.count
        let c = cost[0].count
        
        if (n < 0 || m < 0) {
            return 0
        }
        else if ( (m == r-1 && n == c-1) || (n+1 >= c) ) {
            
            return cost[m][n]
        }
        else {
            
            return cost[m][n] + min(minCost(cost: cost, m: (m+1 >= r ? r-1 : m+1), n: (n+1)), minCost(cost: cost, m: m, n: n+1), minCost(cost: cost, m: (m-1 >= 0 ?m-1 : r-1), n:  (n+1)) )
        }
        
    }
    
}


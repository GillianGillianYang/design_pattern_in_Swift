//
//  ViewController.swift
//  CommandTester
//
//  Created by Gillian on 2017/9/6.
//  Copyright © 2017年 MrRabitRabit_studio. All rights reserved.
//

import UIKit;
//import Objects;

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showTest(_ sender: UIButton) {
        let s : swiftPractice?;
        s = swiftPractice();
       // s?.testReduce();
       
        let calc = Calculator();
        calc.add(amount: 12);
        calc.multiply(amount: 5);
        calc.subtract(amount: 4);
        
        print("Total: \(calc.total) \n");
        
      /*  for _ in 0..<3
        {
            calc.undo();
            print("Total_: \(calc.total) \n");
        }
        print("Total__: \(calc.total) \n");
         */
        
        let snapshot = calc.getHistorySnaphot();
        print("pre-snapshot: \(calc.total)");
        snapshot?.execute();
        print("post-snapshot: \(calc.total)");
        
    }
    
}




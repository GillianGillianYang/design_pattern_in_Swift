//
//  commands.swift
//  CommandTester
//
//  Created by Gillian on 2017/9/6.
//  Copyright © 2017年 MrRabitRabit_studio. All rights reserved.
//
//using swift4

import Foundation;

protocol Command {
    func execute();
}

class commands {
    private (set) var total = 0;
    private var history = [Command]();
  
    
}


class GenericCommand<T> : Command{
    
    private var reciever: T;
    private var instructions:(T) -> Void;
    //Single argument function types require parentheses
    
    init(reciever:T , instructions:@escaping (T) -> Void){
        self.reciever = reciever;
        self.instructions = instructions;
    }
    
    func execute() {
      
        instructions(reciever);
    }

    //class func : like static func ( used in protocol or class )
    // @escaping
    //Instance member 'reciever' cannot be used on type 'GenericCommand<T>'
    
    class func createCommand(receivera:T, instuctiona:@escaping (T)-> Void) -> Command {
        return GenericCommand(reciever: receivera , instructions: instuctiona);
    }
    
}

class Calculator{
    private(set) var total = 0;
    private var history = [Command]();
   // private var queue = dispatch_queue_create("ArrayQ", DISPATCH_QUEUE_SERIAL);
    private let queue = DispatchQueue(label: "since Swift 3");
    private var perfaormingUndo = false;
    
    func add(amount: Int){
        addUndoCommand(method: Calculator.subtract  , amount : amount);
        total += amount;
    }
    func subtract(amount: Int){
        addUndoCommand(method: Calculator.add , amount : amount);
         total -= amount;
    }
    func multiply( amount: Int){
        addUndoCommand(method: Calculator.divide , amount : amount);
        total = total * amount ;
    }
    func divide( amount : Int){
        addUndoCommand(method: Calculator.multiply , amount : amount);
        total = total / amount ;
    }
    
    private func addUndoCommand(method: @escaping (Calculator) -> (Int) -> () , amount: Int)
    {
        
        if(!perfaormingUndo){
            queue.async {
                self.history.append( GenericCommand<Calculator>.createCommand(receivera: self, instuctiona: { calc in method(calc)(amount)}));
                print(amount);
                // print( self.history);
          }
        }
    }
    
    func undo(){
         queue.async {
            if self.history.count > 0 {
                self.perfaormingUndo = true;
                var test : Command?;
                test = self.history.removeLast();
                //self.history.removeLast().execute();
                test?.execute();
                print("execute::\(self.total)", ": \(self.history.count)"); 
                self.perfaormingUndo = false;
                //self.history.removeLast();
                // 把上述undo行為多增加的history紀錄刪除
            }
        }
    }
    
}

class swiftPractice{
    //reduce :
    //https://hugolu.gitbooks.io/learn-swift/content/Advanced/HighOrderFunctions.html#reduce
    func testReduce(){
        let Nums = Array(0...10);
        var totals = Nums.reduce(0, {(sum, num)-> Int in return sum + num });
        var totals2 =  Nums.reduce(0){ $0 + $1 }
        print(totals2);
        //println(totals);
    }
    
}




//
//  commands.swift
//  CommandTester
//
//  Created by Gillian on 2017/9/6.
//  Copyright © 2017年 MrRabitRabit_studio. All rights reserved.
//
//using swift4

import Foundation

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
    
    func add(aamount: Int){
        addUndoCommand(method: Calculator.substract  , amount : aamount);
        total += aamount;
    }
    func substract(amount: Int){
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
        self.history.append( GenericCommand<Calculator>.createCommand(receivera: self, instuctiona: { calc in
               method(calc)(amount)
        })); //(Calculator) -> void
    }
    
    func undo(){
        if self.history.count > 0 {
            self.history.removeLast().execute();
            self.history.removeLast();// 把上述undo行為多增加的history紀錄刪除
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
        
        //printl(totals);
    }
    
}




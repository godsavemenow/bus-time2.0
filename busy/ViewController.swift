//
//  ViewController.swift
//  busy
//
//  Created by Lucas Vinícius José da Silva on 13/03/20.
//  Copyright © 2020 Lucas Vinícius José da Silva. All rights reserved.
//
import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet var listaHorarios: UILabel!
    @IBOutlet var cronometroLabel: UILabel!
    @IBOutlet var firstView: UIView!
    @IBOutlet var horarioInput: UITextField!
    @IBOutlet weak var warning: UILabel!
    var timer = Timer()
    var count:Int=0
    var acumuladorStr:String = ""
    var horariosString:[String] = []
    
    @IBAction func confirmarButton(_ sender: Any) {
    horarios.removeFirst();
    iniciarCronometro(index: 0)
    }
    var horarios:[Int] = []
    @IBAction func addHorario(_ sender: Any) {
        if(horarios.count<5){
            let horatext = horarioInput.text
            acumuladorStr = acumuladorStr + (horatext ?? " ") + "\n"
            print(acumuladorStr)
            listaHorarios.text = acumuladorStr
            let auxHora = horatext?.components(separatedBy: ":")
            let hora    = auxHora?[0] ?? "0"
            let minuto = auxHora?[1] ?? "0"
            let intHora = Int(hora) ?? 0
            let intMinuto = Int(minuto) ?? 0
            horarios.append(intHora*60 + intMinuto)
            horarioInput.text = ""
        }else{
            horarioInput.text = ""
            warning.isHidden = false
        }
    }
    
    @IBAction func iniciarTimer(_ sender: Any) {
        firstView.isHidden = true;
        iniciarCronometro(index: 0);
    }
    func iniciarCronometro(index:Int){
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.hour,.minute], from: date)
        let hour = components.hour
        let minute = components.minute
        count = horarios[index] - (hour ?? 1)*60 - (minute ?? 0)
        count = count * 60
        scheduledTimerWithTimeInterval()
    }
    func scheduledTimerWithTimeInterval(){

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
       }
    @objc func updateTime() {

       if(count >= 0){
           var minutes = String(count / 60)
           var seconds = String(count % 60)
           if(minutes.count<2){
               minutes = "0"+minutes
           }
           if(seconds.count<2){
               seconds = "0"+seconds
           }
           cronometroLabel.text = minutes + ":" + seconds
           count-=1
     }

       }
    override func viewDidLoad() {
        super.viewDidLoad()
        warning.isHidden = true
        
    }
}

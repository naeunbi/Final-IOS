//
//  ViewController.swift
//  ios timer 1
//
//  Created by 나은비 on 2021/01/03.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    @IBOutlet weak var Label_Present: UILabel!
    @IBOutlet weak var Label_Alltime: UILabel!
    @IBOutlet weak var Label_someTime: UILabel!
    @IBOutlet weak var Label_Timer: UILabel!
    
    @IBOutlet weak var Button_Start_Outlet: UIButton!
    @IBOutlet weak var Button_Stop_Outlet: UIButton!
    @IBOutlet weak var Button_Restart_outlet: UIButton!

    @IBOutlet weak var Button_Reset_outlet: UIButton!
    @IBOutlet weak var Button_TimeSet_outlet: UIButton!
    //    타이머 시간 : 50분으로 설정
//    총 남은시간 : 8시간 설정
//    누적시간 : 0부터 시작
    
    
//    타이머시간
    var Int_seconds: Int = 3000
//    총 남은시간
    var Int_allTimes: Int = 28800
//    누적시간
    var Int_sum: Int = 0
//   타이머 작동 메소드를 실행할 수 있는지 여부
    var timeTrigger: Bool = true
//    타이머 작동을 위한 기본작업?
    var realTime = Timer()
     
    let BUTTON_CLICK = UIColor(named: "ButtonClick")
    let BUTTON_COLOR = UIColor(named: "ButtonColor")
    let BACKGROUND_COLOR = UIColor(named: "BackgroundColor")
//    스탑된 경우 배경색을 바꾸겠다.
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Button_Start_Outlet.layer.cornerRadius = 8
        Button_Stop_Outlet.layer.cornerRadius = 8
        Button_Restart_outlet.layer.cornerRadius = 8
    }


    @IBAction func Button_Start_Action(_ sender: UIButton) {
//        버튼 클릭했을 때 타이머 작동할 수 있는 상태일 경우 -> 타이머 작동
        if(timeTrigger)
        {
            checkTimeTrigger()
            timeTrigger = false
        }
//        실행시 배경색을 검은색으로 바꾸겠다.
        startColor()
        
//        시작을 누른 경우 시작, 재시작 버튼 비활성화, stop 버튼 활성
       startEnable()
            }
    @IBAction func Button_Stop_Action(_ sender: UIButton) {
        endGame()
//        스탑된 경우 배경색을 바꾸겠다.
        stopColor()
        
        stopEnable()
        
        
//        시작을 누른 경우 시작, 재시작 버튼 비활성화, stop 버튼 활성
        Button_Start_Outlet.isUserInteractionEnabled = false
        Button_Stop_Outlet.isUserInteractionEnabled = true
        Button_Restart_outlet.isUserInteractionEnabled = false
     
//        스탑이 된 경우 START 버튼을 클릭할 수 있게 설정하겠다.
        Button_Start_Outlet.isUserInteractionEnabled = true
        Button_Stop_Outlet.isUserInteractionEnabled = false
        Button_Restart_outlet.isUserInteractionEnabled = true
    }
    @IBAction func Button_Restart_Action(_ sender: Any) {
        Int_seconds = 3000
        updateShow()
        stopColor()
        stopEnable()
        Button_Restart_outlet.backgroundColor = BUTTON_CLICK
        Button_Restart_outlet.isUserInteractionEnabled = false
    }
    @IBAction func Button_Reset_Action(_ sender: Any) {
        getTimeData()
        updateShow()
        stopColor()
        stopEnable()
        Button_Restart_outlet.backgroundColor = BUTTON_CLICK
        Button_Restart_outlet.isUserInteractionEnabled = false
    }
    @IBAction func Button_Timeset_Action(_ sender: Any) {
        Label_Timer.text = "시간 설정!"
    }
//    타이머 작동 메소드, 실행시 1초마다 updateCounter가 실행한다
    func checkTimeTrigger() {
     realTime = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter(){
//        종료될 경우 생성
        
//        타이머 시간이 종료된 경우
        if(Int_seconds < 1)
        {
            endGame()
            stopColor()
            stopEnable()
            AudioServicesPlaySystemSound(1254) // 진동
            AudioServicesPlaySystemSound(4095) // 특정한 소리
        }
//        총 남은시간이 종료된 경우
        else if(Int_allTimes < 1)
        {
            endGame()
        }
//        그외에 타이머가 실행되어야 하는 경우
        else
        {
        Int_seconds = Int_seconds - 1
        Int_sum = Int_sum + 1
        Int_allTimes = Int_allTimes - 1
        }
//        print("seconds : " + String(Int_seconds))
//        print("sum : " + String(Int_sum))
//        print("alltimes : " + String(Int_allTimes))
        updateShow()
    }
    
//    타이머 숫자를 표시해주는 메소드
    func updateShow()
    {
        Label_Timer.text = printTime(temp: Int_seconds)
        Label_Alltime.text = printTime(temp: Int_allTimes)
        Label_someTime.text = printTime(temp: Int_sum)
    }
//    printTime이라는 이름의 메소드, temp라는 이름으로 값을 가져와 메소드 내에서 사용하겠다. 근데 가져오는 자료형이 int 형이다.
//    메소드 반환 형태는 String
    func printTime(temp: Int) -> String
    {
//        초 -> 60으로 나눈 나머지 : 초
//        초 -> 60으로 나눈 몫 : 분
//        초 -> 60*60으로 나눈 몫 : 시간
        
//        다만, 분 : 61이상으로 뜰수가 있다.
//        해결 : 분 - 시간*60
        let S: Int = temp%60
        let H: Int = temp/3600
        let M: Int = temp/60 - H*60
        
        // 삼항연산자를 이용하여 만약에 10보다 작은 경우 0을 추가하여 출력하겠다.
        
//        let stringS: String = ""
//        if(S<10)
//        {
//            stringS = "0" + String(S)
//        }
//        else{
//            stringS = String(S)
//        }
        
        let stringS = S<10 ? "0"+String(S) : String(S)
        let stringM = M<10 ? "0"+String(M) : String(M)
        
        let returnString = String(H) + ":" + stringM + ":" + stringS
        return returnString
    }
//    func printTime(temp : Int) -> String
//    {
//        let S = temp%60
//         let H = temp/3600
//         let M = temp/60 - H*60
//         let stringS = S<10 ? "0"+String(S) : String(S)
//         let stringM = M<10 ? "0"+String(M) : String(M)
//         let returnString = String(H) + ":" + stringM + ":" + stringS
//         return returnString
//         }
    // 정지되는 경우의 메소드
    func endGame(){
        realTime.invalidate()
        timeTrigger = true
    }
    
    func startColor()
    {
        self.view.backgroundColor = UIColor.black
        Button_Start_Outlet.backgroundColor = BUTTON_CLICK
        Button_Stop_Outlet.backgroundColor = BUTTON_COLOR
        Button_Restart_outlet.backgroundColor = BUTTON_CLICK
    }
    func startEnable()
    {
        Button_Start_Outlet.isUserInteractionEnabled = false
        Button_Stop_Outlet.isUserInteractionEnabled = true
        Button_Restart_outlet.isUserInteractionEnabled = false
        Button_Reset_outlet.isUserInteractionEnabled = false
        Button_TimeSet_outlet.isUserInteractionEnabled = false
        
    }
    
    func stopColor()
    {
        self.view.backgroundColor = BACKGROUND_COLOR
        Button_Start_Outlet.backgroundColor = BUTTON_COLOR
        Button_Stop_Outlet.backgroundColor = BUTTON_CLICK
        Button_Restart_outlet.backgroundColor = BUTTON_COLOR
        
    }
    func stopEnable(){
        Button_Start_Outlet.isUserInteractionEnabled = true
        Button_Stop_Outlet.isUserInteractionEnabled = false
        Button_Restart_outlet.isUserInteractionEnabled = true
        Button_Reset_outlet.isUserInteractionEnabled = true
        Button_TimeSet_outlet.isUserInteractionEnabled = true
    }
//    저장되어있는 시간을 불러오는 메소드, 8시간 50분을 재설정해주는 메소드
    func getTimeData()
    {
    timeTrigger = true
    Int_seconds = 3000
    Int_allTimes = 28800
    Int_sum = 0
    }
}




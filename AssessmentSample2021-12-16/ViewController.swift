//
//  ViewController.swift
//  AssessmentSample2021-12-16
//
//  Created by 村中令 on 2021/12/16.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!

    var fimItemCount = 1
    var fimItemResult: Int?
    var textsSample: [String] = []
    var buttons: [UIButton] = []
    var dictionary: [UIButton: String] = [:]
    var buttonsNum: [UIButton: Int] = [:]
    var fimNum = [1,2,3,4,5,6,7]
    override func viewDidLoad() {
        super.viewDidLoad()
        decoderFimJsonFile()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        label.text = FimData[fimItemCount - 1].fimItem
        textView.text = FimData[fimItemCount - 1].attention
        textsSample = { () -> [String] in
            let texts = [
                FimData[fimItemCount - 1].one,
                FimData[fimItemCount - 1].two,
                FimData[fimItemCount - 1].three,
                FimData[fimItemCount - 1].four,
                FimData[fimItemCount - 1].five,
                FimData[fimItemCount - 1].six,
                FimData[fimItemCount - 1].seven
            ]
            return texts
        }()
        buttons = [
            button1,button2,button3,button4,button5,button6,button7
        ]
        dictionary = {[UIButton: String](uniqueKeysWithValues: zip(buttons, textsSample)) }()
        buttonsNum = {[UIButton: Int](uniqueKeysWithValues: zip(buttons,fimNum))}()
    }

    //　ボタンと文字列を関連付けさせた配列を、ボタンが選択された際に、そのボタンと関連づけられた文字列を、テキストビューに反映させる。
    @IBAction func update(sender: UIButton){
        textView.text = dictionary[sender]
    }
    //　一つのボタンが押された際、そのボタン以外は非選択状態にする
    @IBAction private func change(sender: UIButton) {
        buttons.forEach{ (button: UIButton) in
            button.isSelected = (button === sender)
        }
    }
    //　決定ボタンのアクション
    @IBAction func decide(_ sender: Any) {
        fimItemCount += 1
        let button = buttons.filter{$0.isSelected == true}.first
        //配列から、ボタンを取り出して、単体にしてから、↓に代入する。
        guard let num = buttonsNum[button!] else { return }
        print(num)

        viewWillAppear(true)
        buttons.forEach{ (button: UIButton) in
            button.isSelected = false
        }
    }


    //MARK: - IBAction　各ボタン
    //
    //    @IBAction func button1(_ sender: Any) {
    //        fimItemResult = 1
    //        textView.text = FimData[fimItemCount - 1].one
    //    }
    //
    //    @IBAction func button2(_ sender: Any) {
    //        fimItemResult = 2
    //        textView.text = FimData[fimItemCount - 1].two
    //    }
    //
    //    @IBAction func button3(_ sender: Any) {
    //        fimItemResult = 3
    //        textView.text = FimData[fimItemCount - 1].three
    //    }
    //
    //    @IBAction func button4(_ sender: Any) {
    //        fimItemResult = 4
    //        textView.text = FimData[fimItemCount - 1].four
    //    }
    //
    //    @IBAction func button5(_ sender: Any) {
    //        fimItemResult = 5
    //        textView.text = FimData[fimItemCount - 1].five
    //    }
    //
    //    @IBAction func button6(_ sender: Any) {
    //        fimItemResult = 6
    //        textView.text = FimData[fimItemCount - 1].six
    //    }
    //
    //    @IBAction func button7(_ sender: Any) {
    //        fimItemResult = 7
    //        textView.text = FimData[fimItemCount - 1].seven
    //    }

    //MARK: - JSONファイルのデコーダー
    var FimData:[FimItem] = []
    var count: Int = 0

    struct FimItem: Codable {
        var fimItem: String
        var seven: String
        var six: String
        var five: String
        var four: String
        var three: String
        var two: String
        var one: String
        var attention: String
    }

    func decoderFimJsonFile() {
        let data:Data?
        guard let file = Bundle.main.url(forResource: "FIM", withExtension: "json") else {
            fatalError("ファイルが見つかりません")
        }

        do{
            data  = try? Data(contentsOf: file)
        } catch {
            fatalError("ファイルをロード不可")
        }

        do{
            guard let data = data else {
                print("アンラップ失敗")
                return
            }
            let decoder = JSONDecoder()
        FimData = try decoder.decode([FimItem].self, from: data)
        } catch {
            fatalError("パース不可")
        }
    }

    struct FIM {
        var uuidString = UUID().uuidString
        var eating = 0
        var grooming = 0
        var bathing = 0
        var dressingUpperBody = 0
        var dressingLowerBody  = 0
        var toileting = 0
        var bladderManagement = 0
        var bowelManagement = 0
        var transfersBedChairWheelchair = 0
        var transfersToilet = 0
        var transfersBathShower = 0
        var walkWheelchair = 0
        var stairs = 0
        var comprehension = 0
        var expression = 0
        var socialInteraction = 0
        var problemSolving = 0
        var memory = 0
        var createdAt: Date? = nil
        var updatedAt: Date? = nil
 }
}

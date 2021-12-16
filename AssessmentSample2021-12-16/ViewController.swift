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

    override func viewDidLoad() {
        super.viewDidLoad()
        decoderFimJsonFile()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        label.text = FimData[fimItemCount - 1].fimItem
        textView.text = FimData[fimItemCount - 1].attention
    }

    @IBAction func button1(_ sender: Any) {
        fimItemResult = 1
        textView.text = FimData[fimItemCount - 1].one
    }

    @IBAction func button2(_ sender: Any) {
        fimItemResult = 2
        textView.text = FimData[fimItemCount - 1].two
    }

    @IBAction func button3(_ sender: Any) {
        fimItemResult = 3
        textView.text = FimData[fimItemCount - 1].three
    }

    @IBAction func button4(_ sender: Any) {
        fimItemResult = 4
        textView.text = FimData[fimItemCount - 1].four
    }

    @IBAction func button5(_ sender: Any) {
        fimItemResult = 5
        textView.text = FimData[fimItemCount - 1].five
    }

    @IBAction func button6(_ sender: Any) {
        fimItemResult = 6
        textView.text = FimData[fimItemCount - 1].six
    }

    @IBAction func button7(_ sender: Any) {
        fimItemResult = 7
        textView.text = FimData[fimItemCount - 1].seven
    }

    @IBAction private func change(sender: UIButton) {
        var buttons:[UIButton] = [button1,button2,button3,button4,button5,button6,button7]
        buttons.forEach{ (button: UIButton) in
            button.isSelected = (button === sender)
        }
    }

    @IBAction func decide(_ sender: Any) {
        fimItemCount += 1
        viewWillAppear(true)
    }

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
}


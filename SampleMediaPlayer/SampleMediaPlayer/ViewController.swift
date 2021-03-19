import UIKit
import MediaPlayer
import AVFoundation

class ViewController: UIViewController, MPMediaPickerControllerDelegate {

    // プレイヤー用のproperty
    var audioPlayer:AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pick(sender: AnyObject) {
        // MPMediaPickerControllerのインスタンスを作成
        let picker = MPMediaPickerController()
        // ピッカーのデリゲートを設定
        picker.delegate = self
        // 複数選択を不可にする。（trueにすると、複数選択できる）
        picker.allowsPickingMultipleItems = false
        // ピッカーを表示する
        present(picker, animated: true, completion: nil)
    }
    
    // メディアアイテムピッカーでアイテムを選択完了したときに呼び出される
    func mediaPicker(mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        
        // このfunctionを抜ける際にピッカーを閉じ、破棄する
        // (defer文はfunctionを抜ける際に実行される)
        defer {
            dismiss(animated: true, completion: nil)
        }

        // 選択した曲情報がmediaItemCollectionに入っている
        // mediaItemCollection.itemsから入っているMPMediaItemの配列を取得できる
        let items = mediaItemCollection.items
        if items.isEmpty {
            // itemが一つもなかったので戻る
            return
        }
        
        // 先頭のMPMediaItemを取得し、そのassetURLからプレイヤーを作成する
        let item = items[0]
        if let url = item.assetURL {
            do {
                // itemのassetURLからプレイヤーを作成する
                audioPlayer = try AVAudioPlayer(contentsOf: url)
            } catch  {
                // エラー発生してプレイヤー作成失敗
                audioPlayer = nil
                // 戻る
                return
            }
            
            // 再生開始
            if let player = audioPlayer {
                player.play()
            }
        } else {
            audioPlayer = nil
        }
    }
    
    //選択がキャンセルされた場合に呼ばれる
    func mediaPickerDidCancel(mediaPicker: MPMediaPickerController) {
        // ピッカーを閉じ、破棄する
        dismiss(animated: true, completion: nil)
    }

    @IBAction func pushPlay(sender: AnyObject) {
        // 再生
        if let player = audioPlayer {
            player.play()
        }
    }
    
    @IBAction func pushStop(sender: AnyObject) {
        // 停止
        if let player = audioPlayer {
            player.stop()
        }
    }
 

}

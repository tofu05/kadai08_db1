import SwiftUI
import CoreData

struct ContentView: View {
    @State private var message: String = "" // 状態を管理する変数
    @Environment(\.managedObjectContext) private var viewContext // CoreDataの管理コンテキスト
    @State private var title: String = "" // タイトル入力用
    @State private var content: String = "" // 本文入力用
    
    var body: some View {
        VStack {
            // 入力用テキストボックス
            TextField("タイトルを入力", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("本文を入力", text: $content)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // 登録ボタン
            Button(action: {
                addWord() // Core Dataにデータを挿入
            }) {
                Text("登録")
                    .frame(width: 100, height: 40)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
            Spacer() // 画面上部に空白を確保
            Text(message)
                .font(.headline)
                .foregroundColor(.red)
                .padding()
                }
        .edgesIgnoringSafeArea(.bottom) // 安全領域を無視して背景を画面下部に固定
    }
    private func addWord() {
        let newWord = TangoWords(context: viewContext) // TangoWordsはCore Dataのエンティティ
        newWord.word_id = UUID() // 一意のIDを生成
        newWord.name = title
        newWord.content = content
        
        do {
            try viewContext.save() // データを保存
            title = "" // 入力内容をクリア
            content = ""
        } catch {
            print("Error saving data: \(error)")
        }
    }
}

#Preview {
    let previewController = PersistenceController.preview
    ContentView()
        .environment(\.managedObjectContext, previewController.viewContext)
}

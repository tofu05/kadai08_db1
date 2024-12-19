import SwiftUI
import CoreData

struct WordListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: TangoWords.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \TangoWords.name, ascending: true)]
    ) private var words: FetchedResults<TangoWords>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(words, id: \.self) { word in
                    VStack(alignment: .leading) {
                        Text(word.name ?? "無題")
                            .font(.headline)
                        Text(word.content ?? "内容なし")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .onDelete(perform: deleteWords)
            }
            .navigationTitle("登録した単語")
            .toolbar {
                EditButton()
            }
        }
    }
    
    private func deleteWords(offsets: IndexSet) {
        withAnimation {
            offsets.map { words[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                print("Error deleting items: \(error)")
            }
        }
    }
}

#Preview {
    let previewController = PersistenceController.preview
    WordListView()
        .environment(\.managedObjectContext, previewController.viewContext)
}

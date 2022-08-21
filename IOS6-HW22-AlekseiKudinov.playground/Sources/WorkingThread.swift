import Foundation

public class WorkingThread: Thread {
    private var storage: Storage

    public init(storage: Storage) {
        self.storage = storage
    }

    public override func main() {
        repeat {
            let chipForSoldering = storage.getChipFromStorage()
            print("Chip was soldered - \(Date.getCurrentTime())")
            chipForSoldering.sodering()
        } while storage.isAvailable || storage.isStorageEmpty
    }
}

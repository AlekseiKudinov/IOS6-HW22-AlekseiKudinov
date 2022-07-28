import Foundation

public class WorkingThread: Thread {
    private var storage: Storage

    public init(storage: Storage) {
        self.storage = storage
    }

    public override func main() {
        repeat {
            let chipForSoldering = storage.getChipFromStorage()
            chipForSoldering.sodering()
            print("Chip was soldered - \(Date.getCurrentTime())")
            print("Chips in storage — \(storage.storage.count) - \(Date.getCurrentTime())\n")
        } while storage.isAvailable || storage.isStorageEmpty
    }
}

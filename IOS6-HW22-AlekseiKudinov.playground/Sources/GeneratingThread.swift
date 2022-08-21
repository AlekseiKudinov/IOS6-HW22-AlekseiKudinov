import Foundation

public class GeneratingThread: Thread {
    private var timer = Timer()
    private var storage: Storage

    public init(storage: Storage) {
        self.storage = storage
    }

    public override func main() {
        timer = Timer(timeInterval: 2, repeats: true) { [unowned self] _ in
            self.storage.addChipToStorage(item: Chip.make())
        }
        RunLoop.current.add(timer, forMode: .common)
        RunLoop.current.run(until: Date.init(timeIntervalSinceNow: 20))
    }
}


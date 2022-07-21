import Foundation

public class GeneratingThread: Thread {
    private var timer: Timer?
    private var storage = Storage()
    private var id = 0

    public init(storage: Storage) {
        self.storage = storage
    }

    public override func main() {
        timer = Timer.scheduledTimer(
            timeInterval: 2,
            target: self,
            selector: #selector(addChipsToStorage),
            userInfo: nil,
            repeats: true)

        if let timer = timer {
            RunLoop.current.add(timer, forMode: .common)
            RunLoop.current.run(until: .now + 20)
            storage.isStorageEmpty = false
        }
    }

    @objc func addChipsToStorage() {
        let chip = Chip.make()
        storage.addChipToStorage(chip: chip) {
            self.updateID()
            self.report(chip: chip)
            self.signal()
        }
    }

    private func signal() {
        if self.storage.chipsCount > 0 {
            condition.signal()
        }
    }

    private func updateID() {
        id += 1
    }

    private func report(chip: Chip) {
        print("№\(id) is created.")
        print("Type is \"\(chip.chipType)\"")
        print("Quantity of chips in storage — \(self.storage.chipsCount)")
    }
}


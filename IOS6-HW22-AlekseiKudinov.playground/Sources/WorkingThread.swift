import Foundation

public let condition = NSCondition()

public class WorkingThread: Thread {
    private var id = 0
    private var storage = Storage()

    public init(storage: Storage) {
        self.storage = storage
    }

    public override func main() {

        if storage.isStorageEmpty {
            condition.lock()

            while storage.chipsCount <= 0 {
                condition.wait()
            }

            while storage.chipsCount > 0 {
                var chipForSodering: Chip?

                storage.getChipFromStorage() { chip in
                    chipForSodering = chip
                    self.updateID()
                    self.report(chip: chip, type: .getFromStorage)
                }

                if let chip = chipForSodering {
                    chip.sodering()
                    report(chip: chip, type: .soldering)
                }
            }

            condition.unlock()
            main()
        } else {
            print("Work is done.")
        }
    }
}

extension WorkingThread {
    private func updateID() {
        id += 1
    }

    private func report(chip: Chip?, type: OperationType) {
        if let chip = chip {

            switch type {
            case .getFromStorage:
                print("№\(id) \"\(chip.chipType)\" was moved from storage.")
            case .soldering:
                print("№\(id) \"\(chip.chipType)\" was soldered.")
            }

            print("Quantity of chips in storage — \(self.storage.chipsCount)")
        }
    }

    private enum OperationType: String {
        case getFromStorage
        case soldering
    }
}


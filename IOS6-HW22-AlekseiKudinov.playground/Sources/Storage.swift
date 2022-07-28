import Foundation

public class Storage {
    public var storage: [Chip] = []
    public var id: Int = 0
    private let condition = NSCondition()
    public var isAvailable = false
    public var isStorageEmpty: Bool {
        return storage.isEmpty
    }

    public init() {}

    func addChipToStorage(item: Chip) {
        condition.lock()
        storage.append(item)
        id += 1
        print("Chip is created - \(Date.getCurrentTime())")
        print("Chips in storage — \(storage.count) - \(Date.getCurrentTime())\n")
        isAvailable = true
        condition.signal()
        condition.unlock()
    }

    func getChipFromStorage() -> Chip {
        while (!isAvailable) {
            condition.wait()
        }
        let lastChip = storage.removeLast()
        condition.signal()
        condition.unlock()
        if isStorageEmpty {
            isAvailable = false
        }
        return lastChip
    }
}

extension Date {
    public static func getCurrentTime() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "HH:mm:ss"

        let currentTime = dateFormatter.string(from: date)
        return currentTime
    }
}


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
        condition.signal()
        condition.unlock()
        isAvailable = true
    }

    func getChipFromStorage() -> Chip {
        while (!isAvailable) {
            condition.wait()
        }
        let lastChip = storage.removeLast()
//        print("Chip was soldered - \(Date.getCurrentTime())")
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

        dateFormatter.dateFormat = "HH:mm:ss:SSSS"

        let currentTime = dateFormatter.string(from: date)
        return currentTime
    }
}


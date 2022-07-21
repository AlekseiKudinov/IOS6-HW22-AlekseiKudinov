import Foundation

public class Storage {
    private var storage = [Chip]()
    private let queue = DispatchQueue(label: "Storage Queue", qos: .utility, attributes: .concurrent)
    public var chipsCount: Int {
        return storage.count
    }
    public var isStorageEmpty = true

    public init() {}

    func addChipToStorage(chip: Chip, completion: @escaping () -> ()) {
        queue.async(flags: .barrier) {
            self.storage.append(chip)
            completion()
        }
    }

    func getChipFromStorage(completion: @escaping (_ lastChip: Chip) -> ()) {
        queue.sync {
            if let lastChip = self.storage.popLast() {
                completion(lastChip)
            }
        }
    }
}

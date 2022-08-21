import Foundation

let storage = Storage()
let generationThread = GeneratingThread(storage: storage)
let workingThread = WorkingThread(storage: storage)

generationThread.start()
workingThread.start()

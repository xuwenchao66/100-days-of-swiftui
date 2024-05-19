import Foundation

@Observable
class Favorites {
    private var resorts: Set<Resort>
    
    init() {
        resorts = []
    }
    
    func contains (_ resort: Resort) -> Bool {
        resorts.contains(resort)
    }
    
    func add (_ resort: Resort) {
        resorts.insert(resort)
    }
    
    func remove (_ resort: Resort) {
        resorts.remove(resort)
    }
}

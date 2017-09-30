
import Foundation

import ObjectMapper

extension Mappable {

    init() {
        self.init(map: Map(mappingType: .fromJSON, JSON: [:]))!
    }

}

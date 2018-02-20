//
//  Created by Brian Coyner on 2/19/18.
//  Copyright © 2018 High Rail, LLC. All rights reserved.
//

import Foundation

/// A `CompositeResource` can be used to help coordinate the life cycle of zero or more `Resource`s.

final class CompositeResource: Resource {
    
    private let resources: [Resource]
    
    init(resources: [Resource]) {
        self.resources = resources
    }
}

extension CompositeResource {
    
    /// When executed, calls `activate` on each `Resource` (first to last)
    func activate() {
        resources.forEach { $0.activate() }
    }
    
    /// When executed, calls `deactivate` on each `Resource` (last to first).
    func deactivate() {
        resources.reversed().forEach { $0.deactivate() }
    }
}

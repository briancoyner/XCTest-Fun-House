//
//  Created by Brian Coyner on 2/19/18.
//  Copyright © 2018 High Rail, LLC. All rights reserved.
//

import Foundation

/// The `Resource` protocol, for example, may be adopted by a long-lived "resource" referenced
/// associated with the currently signed in user. Often times resources must be activated and
/// deactivated in a particular order. See the `CompositeResource` for an implementation that we'll
/// be testing.

protocol Resource: class {
    
    func activate()
    
    func deactivate()
}

//
//  Created by Brian Coyner on 2/19/18.
//  Copyright © 2018 High Rail, LLC. All rights reserved.
//

import Foundation
import UIKit

@testable import FunHouse

/// The test case needs an implementation of the `CellRenderer` that is guaranteed not to
/// implement the `estimatedRowHeight` property. All other implementation details are
/// not implemented because the test case only cares about the `estimatedRowHeight` property.

final class InternalCellRendererForTestingProtocolExtensionEstimatedHeight: CellRenderer {
    
    // Note: this implementation does not provide an `estimatedRowHeight` value. The value
    // is provided by the `CellRenderer`'s protocol extension.
    
    func render(cell: UITableViewCell, using element: String) {
        // empty on purpose
    }
    
    func tearDown(cell: UITableViewCell) {
        // empty on purpose
    }
}

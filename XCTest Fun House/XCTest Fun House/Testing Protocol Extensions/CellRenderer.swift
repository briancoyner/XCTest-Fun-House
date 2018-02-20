//
//  Created by Brian Coyner on 2/19/18.
//  Copyright © 2018 High Rail, LLC. All rights reserved.
//

import Foundation
import UIKit

protocol CellRenderer {
    
    associatedtype Element
    associatedtype Cell: UITableViewCell
    
    var estimatedRowHeight: CGFloat { get }
    
    /// Called during `tableView:cellForRowAtIndexPath:` `UITableViewDataSource` callback.
    func render(cell: Cell, using element: Element)
    
    /// Called during `tableView:didEndDisplaying:forForAt:`
    func tearDown(cell: Cell)
}

extension CellRenderer {
    
    /// All rows, by default, have a 44-point estimated row height.
    var estimatedRowHeight: CGFloat {
        return 44
    }
}

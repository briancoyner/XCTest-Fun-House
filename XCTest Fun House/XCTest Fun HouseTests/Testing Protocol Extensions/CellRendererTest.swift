//
//  Created by Brian Coyner on 2/19/18.
//  Copyright © 2018 High Rail, LLC. All rights reserved.
//

import Foundation
import XCTest

@testable import FunHouse

/// # Testing Protocol Extensions
/// ## How do you write a test for a protocol extension?
///
/// Testing a protocol extension requires a dummy protocol implementation guaranteed not to implement
/// the parts provided by the protocol extension.
///
/// The `CellRenderer` is a simple protocol that may be integrated with a "generic" table view controller.
/// The actual view controller implementation is outside the scope of this example.
///
/// The goal is to write a unit test verifying the `estimatedRowHeight` default implementation returns 44-points.
///
/// ## Test Case
///
/// This test case verifies that the `CellRenderer` protocol has a
/// default implementation (via a protocol extension) of the `estimatedRowProperty` property.

final class CellRendererTest: XCTestCase {
    
    func testEstimatedRowHeightIsProvidedByTheProtocolExtensionAndIsEqualToTheStandardFortyFourPoints() {
        
        let renderer = InternalCellRendererForTestingProtocolExtensionEstimatedHeight()
        XCTAssertEqual(44, renderer.estimatedRowHeight)
    }
}

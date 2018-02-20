//
//  Created by Brian Coyner on 2/19/18.
//  Copyright © 2018 High Rail, LLC. All rights reserved.
//

import Foundation
import XCTest

@testable import FunHouse

/// This looks pretty simple, too. One may even question the need to write a test.
/// Let's see how we can test that the `Resource`s are activated and deactivated in the correct order.
///
/// First, we need to create a stub `Resource` implementation to capture calls to the `activate`
/// and `deactivate` methods. Two internally created `XCTestExpection`s are used to track
/// method invocations.

final class StubResource: Resource {
    
    let activateExpectation: XCTestExpectation
    let deactivateExpectation: XCTestExpectation
    
    /// Creates a feature resource used by the `CompositeResourceTest` to verify
    /// that the `activate` and `deactivate` functions are correctly delegated.
    ///
    /// - Parameters:
    ///   - description: the expectation's description.
    ///   - activateExpectedToExecute: if the test expects the `activate` function to execute; default is `true`.
    ///   - deactivateExpectedToExecute: if the test expects the `deactivate` function to execute; default is `true`.
    init(description: String, isActivateExpectedToExecute: Bool, isDeactivateExpectedToExecute: Bool) {
        self.activateExpectation = StubResource.makeExpectation(
            withDescription: description,
            isExpectedToExecute: isActivateExpectedToExecute
        )
        
        self.deactivateExpectation = StubResource.makeExpectation(
            withDescription: description,
            isExpectedToExecute: isDeactivateExpectedToExecute
        )
    }
}

extension StubResource {
    
    func activate() {
        activateExpectation.fulfill()
    }
    
    func deactivate() {
        deactivateExpectation.fulfill()
    }
}

extension StubResource {
    
    private static func makeExpectation(withDescription description: String, isExpectedToExecute: Bool) -> XCTestExpectation {
        let expectation = XCTestExpectation(description: "Resource Expection \(description)")
        
        // Fail fast if the expectation is fulfilled more than once.
        expectation.assertForOverFulfill = true
        
        // Fail fast if the expectation is fulfilled (i.e. method should not have executed).
        expectation.isInverted = !isExpectedToExecute
        
        return expectation
    }
}

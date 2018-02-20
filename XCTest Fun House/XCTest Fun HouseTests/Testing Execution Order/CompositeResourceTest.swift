//
//  Created by Brian Coyner on 2/19/18.
//  Copyright © 2018 High Rail, LLC. All rights reserved.
//

import Foundation
import XCTest

@testable import FunHouse

/// # Testing Execution Order
///
/// ## How do you write a test that verifies execution order?
///
/// One simple and effective way is to use an `XCTestExpectation`. Let's look at relatively
/// common problem and testable solution.
///
/// Assume your app has a protocol named `Resource` containing a method to `activate` the
/// resource and a method to `deactivate` the resource.
///
/// The `Resource` protocol, for example, may be adopted by a resource referenced by the
/// currently signed in user. Often times resources must be activated and deactivated in
/// a particular order.
///
/// A `CompositeResource` can be used to help coordinate the life cycle of zero or more `Resource`s.
///
/// The goal is to test that the `CompositeResource` activates and deactivates the resources once
/// and in the correct order. The actual `CompositeResource` implementation is pretty simple. One
/// may even question the need to write a test. But what is "simple" today is complex tomorrow.
///
/// Let's see how we can test that the `Resource`s are activated and deactivated in the correct order.
/// A stub `Resource` implementation captures calls to the `activate` and `deactivate` methods. Two internally
/// created `XCTestExpection`s are used to track method invocations.

final class CompositeResourceTest: XCTestCase {
}

extension CompositeResourceTest {
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
    }
}

extension CompositeResourceTest {
    
    func testActivationActivatesInTheOrderTheFeatureResourcesAreRegistered() {
        let featureResourceA = StubResource(description: "A", isActivateExpectedToExecute: true, isDeactivateExpectedToExecute: false)
        let featureResourceB = StubResource(description: "B", isActivateExpectedToExecute: true, isDeactivateExpectedToExecute: false)
        let featureResourceC = StubResource(description: "C", isActivateExpectedToExecute: true, isDeactivateExpectedToExecute: false)
        let featureResourceD = StubResource(description: "D", isActivateExpectedToExecute: true, isDeactivateExpectedToExecute: false)
        
        let compositeResource = CompositeResource(resources: [
            featureResourceA,
            featureResourceB,
            featureResourceC,
            featureResourceD
        ])
        
        //
        // Activating the composite resource should call the `activate` method
        // on the registered `Resource`s in the order the resources were passed to the initializer.
        //
        // This test also verifies that the `deactivate` functions were not called.
        //
        
        compositeResource.activate()
        
        wait(for: [
            featureResourceA.activateExpectation,
            featureResourceB.activateExpectation,
            featureResourceC.activateExpectation,
            featureResourceD.activateExpectation
        ], timeout: 0, enforceOrder: true)
        
        wait(for: [
            featureResourceA.deactivateExpectation,
            featureResourceB.deactivateExpectation,
            featureResourceC.deactivateExpectation,
            featureResourceD.deactivateExpectation,
        ], timeout: 0)
    }
}

extension CompositeResourceTest {
    
    func testDeactivateDeactivatesInReverseOrderTheFeatureResourcesAreRegistered() {
        let featureResourceA = StubResource(description: "A", isActivateExpectedToExecute: false, isDeactivateExpectedToExecute: true)
        let featureResourceB = StubResource(description: "B", isActivateExpectedToExecute: false, isDeactivateExpectedToExecute: true)
        let featureResourceC = StubResource(description: "C", isActivateExpectedToExecute: false, isDeactivateExpectedToExecute: true)
        let featureResourceD = StubResource(description: "D", isActivateExpectedToExecute: false, isDeactivateExpectedToExecute: true)
        
        let compositeResource = CompositeResource(resources: [
            featureResourceA,
            featureResourceB,
            featureResourceC,
            featureResourceD
        ])
        
        //
        // Deactivating the composite resource should call the `deactivate` method
        // on the registered `FeatureResources` in reverse order.
        //
        // This test also verifies that the `activate` functions were not called.
        //
        
        compositeResource.deactivate()
        
        wait(for: [
            featureResourceD.deactivateExpectation,
            featureResourceC.deactivateExpectation,
            featureResourceB.deactivateExpectation,
            featureResourceA.deactivateExpectation
        ], timeout: 0, enforceOrder: true)
        
        wait(for: [
            featureResourceA.activateExpectation,
            featureResourceB.activateExpectation,
            featureResourceC.activateExpectation,
            featureResourceD.activateExpectation,
        ], timeout: 0)
    }
}

//
//  LowCostFinderTests.swift
//  LowCostFinderTests
//
//  Created by Jeevanantham Kalyanasundram on 3/8/17.
//  Copyright © 2017 Jeevanantham Kalyanasundram. All rights reserved.
//

import XCTest
@testable import LowCostFinder

class LowCostFinderTests: XCTestCase {
    
    var viewController: ViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        //viewController = navigationController.topViewController as! ViewController
        let _ = viewController?.view
        viewController?.viewWillAppear(true)
    }

    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testminCostFunction() {
        
        let cost: [[Int]] = [
            [3, 4, 1, 2, 8, 6],
            [6, 1, 8, 2, 7, 4],
            [5, 9, 3, 9, 9, 5],
            [8, 4, 1, 3, 2, 6],
            [3, 7, 2, 8, 6, 4]
        ]
        
        let minimumCost = self.minCost(cost: cost, m: 0, n: 0)
        
        XCTAssertTrue(minimumCost == 16, "Correct output.");
        
    }
    
    func minCost(cost: [[Int]], m: Int, n: Int) -> (Int) {
        
        let r = cost.count
        let c = cost[0].count
        
        if (n < 0 || m < 0) {
            return 0
        }
        else if ( (m == r-1 && n == c-1) || (n+1 >= c) ) {
            
            return cost[m][n]
        }
        else {
            
            return cost[m][n] + min(minCost(cost: cost, m: (m+1 >= r ? r-1 : m+1), n: (n+1)), minCost(cost: cost, m: m, n: n+1), minCost(cost: cost, m: (m-1 >= 0 ?m-1 : r-1), n:  (n+1)) )
        }
        
    }
    
}

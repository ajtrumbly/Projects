//
//  PortfolioWidgetBundle.swift
//  PortfolioWidget
//
//  Created by Austin Trumbly on 7/29/24.
//

import WidgetKit
import SwiftUI

@main
struct PortfolioWidgetBundle: WidgetBundle {
    var body: some Widget {
        PortfolioWidget()
        PortfolioWidgetControl()
    }
}

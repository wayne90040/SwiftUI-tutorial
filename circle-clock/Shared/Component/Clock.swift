//
//  Clock.swift
//  circle-clock
//
//  Created by Wei Lun Hsu on 2022/6/9.
//

import Foundation
import SwiftUI

protocol Clock: View {
    var hour: Int { get set }
    var minute: Int { get set }
    var second: Int { get set }
}

//
//  ArchivesView.swift
//  Nano2
//
//  Created by Elvis Susanto on 21/12/24.
//

import SwiftUI

struct ArchivesView: View {
    public init(onDismiss: (@escaping () -> Void)) {
        self.onDismiss = onDismiss
    }
    private let onDismiss : (() -> Void)
    var body: some View {
        VStack {
            Text(StringConstant.listButtonText)
        }
        .useCustomToolbar(
            onDismiss: {
                onDismiss()
            }
        )
    }
}

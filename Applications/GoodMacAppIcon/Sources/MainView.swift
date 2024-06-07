//
//  MainView.swift
//  GoodMacAppIcon
//
//  Created by Yoshimasa Niwa on 6/6/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct MainView: View {
    @Environment(Service.self)
    private var service

    @State
    private var isDropTargeted: Bool = false

    @State
    private var appIconImage: NSImage?

    @State
    private var goodAppIconProbability: Double?

    var body: some View {
        VStack(spacing: 40.0) {
            Group {
                if let appIconImage {
                    Image(nsImage: appIconImage)
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 168.0, minHeight: 168.0)
                } else {
                    Image("app")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(.white)
                        .scaledToFit()
                        .frame(width: 128.0, height: 128.0)
                        .padding(40.0)
                        .background {
                            RoundedRectangle(cornerRadius: 20.0)
                                .stroke(style: StrokeStyle(
                                    lineWidth: 8.0,
                                    lineCap: .round,
                                    dash: [10.0, 22.0]
                                ))
                        }
                        .opacity(isDropTargeted ? 0.8 : 0.4)
                }
            }
            if let goodAppIconProbability {
                HStack {
                    Circle()
                        .frame(height: 20.0)
                        .foregroundColor(goodAppIconProbability >= 0.5 ? .green : .red)
                    Text(String(format: "%0.4f%%", goodAppIconProbability * 100))
                        .font(.largeTitle)
                        .bold()
                }
            } else {
                Text("Good Mac app icon…? 🤔")
                    .font(.largeTitle)
                    .bold()
                    .opacity(0.4)
            }
        }
        .padding(40.0)
        // TODO: Use .application UTType, .image, and also use Transferrable
        .onDrop(of: [
            .fileURL
        ], isTargeted: $isDropTargeted) { providers in
            guard let provider = providers.first else {
                return false
            }
            _ = provider.loadObject(ofClass: URL.self) { url, error in
                guard let url else {
                    return
                }
                Task { @MainActor in
                    appIconImage = NSWorkspace.shared.icon(forFile: url.path(percentEncoded: false))
                }
            }
            return true
        }
        .onChange(of: appIconImage) { _, newValue in
            guard let newValue else {
                return
            }
            Task {
                let probability = try await service.probabilityOfGoodAppIconImage(newValue)
                goodAppIconProbability = probability
            }
        }
    }
}

#Preview {
    MainView()
        .environment(Service())
}

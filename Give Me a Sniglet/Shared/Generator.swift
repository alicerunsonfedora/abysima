//
//  Generator.swift
//  Give Me a Sniglet
//
//  Created by Marquis Kurt on 16/11/21.
//

import SwiftUI

struct Generator: View {
    @AppStorage("generateSize") var generateSize: Int = 1
    @State var showDetails: Bool = false

    var body: some View {
        Group {
            if generateSize == 1 {
                GeneratorSingleView()
            } else {
                GeneratorList()
            }
        }
    }
}

struct GeneratorSingleView: View {

    @AppStorage("allowClipboard") var tapToCopy: Bool = true
    @State var validateResults: Sniglet.Result = .empty()
    @State var showDetails: Bool = false

    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            if tapToCopy {
                Button(action: { UIPasteboard.general.string = validateResults.word }) {
                    Text(validateResults.word)
                        .font(.system(.largeTitle, design: .serif))
                        .bold()
                }
                .buttonStyle(.plain)
            } else {
                Text(validateResults.word)
                    .font(.system(.largeTitle, design: .serif))
                    .bold()
                    .textSelection(.enabled)
            }


            Button(action: setSniglet) {
                Label("generator.button.prompt", systemImage: "wand.and.stars")
            }
            .buttonStyle(.borderedProminent)
            #if os(iOS)
            .cornerRadius(16)
            #endif

            if tapToCopy {
                Text("Tap the word to copy it to your clipboard.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            VStack {
                GeneratorConfidenceBar(confidence: validateResults.confidence)
                HStack {
                    Text("Confidence: \(validateResults.confidence.asPercentage())%")
                    Spacer()
                    Button(action: { showDetails.toggle() }) {
                        Label("generator.button.help", systemImage: "questionmark.circle")
                    }
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            if validateResults == .empty() {
                validateResults = Sniglet.shared.getNewWords().first ?? .null()
            }
        }
        .sheet(isPresented: $showDetails) {
            GeneratorExplanation {
                showDetails.toggle()
            }
        }
        .padding()
    }

    func setSniglet() {
        validateResults = Sniglet.shared.getNewWords().first ?? .null()
    }

}

struct GeneratorList: View {

    @AppStorage("generateSize") var generateSize: Int = 1
    @State var validateResults: [Sniglet.Result] = []
    @State var showDetails: Bool = false
    

    var body: some View {
        NavigationView {
            List {
                ForEach(validateResults) { result in
                    NavigationLink(destination: GeneratorListDetail(result: result)) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(result.word)
                                .font(.system(.title2, design: .serif))
                                .bold()
                            Text("Confidence: \(result.confidence.asPercentage())%")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("generator.title")
            .onAppear(perform: setInitialState)
            .refreshable {
                updateState()
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: updateState) {
                        Label("generator.button.prompt", systemImage: "wand.and.stars")
                    }
                }
            }
        }

    }

    func setInitialState() {
        if !validateResults.isEmpty { return }
        validateResults = Sniglet.shared.getNewWords(count: generateSize).asArray()
    }

    func updateState() {
        validateResults = Sniglet.shared.getNewWords(count: generateSize).asArray()
    }
}

struct GeneratorListDetail: View {

    @AppStorage("allowClipboard") var tapToCopy: Bool = true
    @State var result: Sniglet.Result
    @State var showDetails: Bool = false

    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            if tapToCopy {
                Button(action: { UIPasteboard.general.string = result.word }) {
                    Text(result.word)
                        .font(.system(.largeTitle, design: .serif))
                        .bold()
                }
                .buttonStyle(.plain)
                Text("Tap the word to copy it to your clipboard.")
                    .font(.caption)
                    .foregroundColor(.secondary)

            } else {
                Text(result.word)
                    .font(.system(.largeTitle, design: .serif))
                    .bold()
                    .textSelection(.enabled)
            }
            Spacer()
            GeneratorConfidenceBar(confidence: result.confidence)
            HStack {
                Text("Confidence: \(result.confidence.asPercentage())%")
                Spacer()
                Button(action: { showDetails.toggle() }) {
                    Label("generator.button.help", systemImage: "questionmark.circle")
                }
            }
            .padding(.horizontal)
        }
        .padding()
        .toolbar {
            ToolbarItem {
                if !tapToCopy {
                    Button(action: { UIPasteboard.general.string = result.word }) {
                        Label("Copy to Clipboard", systemImage: "doc.on.clipboard")
                    }
                }
            }
        }
        .sheet(isPresented: $showDetails) {
            GeneratorExplanation {
                showDetails.toggle()
            }
        }
    }

}

struct GeneratorConfidenceBar: View {
    var confidence: Double

    var tint: Color {
        switch confidence.asPercentage() {
        case 0..<33:
            return Color.red
        case 34..<50:
            return Color.orange
        case 50..<85:
            return Color.yellow
        case 85..<92:
            return Color.green
        default:
            return Color.cyan
        }
    }

    var body: some View {
        ProgressView(value: confidence)
            .progressViewStyle(.linear)
            .tint(tint)
            .padding(.horizontal)
        .animation(.easeInOut, value: confidence)
    }
}

struct GeneratorExplanation: View {

    var onDismiss: () -> Void

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 48) {
                    Text("generator.explain.detail")
                        .padding(.horizontal)
                    HStack(spacing: 8) {
                        Spacer()
                        letterNode("a")
                        letterNode("b")
                        letterNode("c")
                        letterNode("d")
                        letterNode("e")
                        ForEach(0..<3) { _ in
                            letterNode("*")
                        }
                        Spacer()
                    }
                    Text("generator.explain.detail2")
                        .padding(.horizontal)
                    Text("generator.explain.detail3")
                        .padding(.horizontal)
                }
                Spacer()
            }
            .navigationTitle("generator.explain.title")
            .toolbar {
                Button(action: onDismiss) {
                    Text("Dismiss")
                }
            }
        }
    }

    func letterNode(_ text: LocalizedStringKey) -> some View {
        Text(text)
            .font(.system(.title, design: .monospaced))
            .foregroundColor(.green)
            .frame(width: 36, height: 36)
            .background(Color.black)
            .cornerRadius(4)
    }
}

struct Generator_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GeneratorSingleView()
            GeneratorList()
            NavigationView {
                GeneratorListDetail(result: .empty())
            }
            GeneratorExplanation { }
        }
    }
}

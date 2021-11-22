//
//  Settings.swift
//  Give Me a Sniglet
//
//  Created by Marquis Kurt on 16/11/21.
//

import SwiftUI

struct SettingsView: View {

    @AppStorage("allowClipboard") var allowCopying: Bool = true
    @AppStorage("generateSize") var generateBatches: Int = 1
    @AppStorage("algoMinBound") var minGenerationValue: Int = 3
    @AppStorage("algoMaxBound") var maxGenerationValue: Int = 8
    @AppStorage("algoBatchSize") var batchSize: Int = 25
    @AppStorage("customShapes") var customSyllables: SyllableShapes = SyllableShapes()
    @State var customSyllableEntry: String = ""

    var body: some View {
        NavigationView {
            List {

                Section(header: Text("settings.general.title"), footer: Text("settings.clipboard.footer")) {
                    Stepper(value: $generateBatches, in: 1...Int.max) {
                        Label("Generate \(generateBatches) words", systemImage: "sparkles.rectangle.stack.fill")
                    }
                    Toggle(isOn: $allowCopying) {
                        Label("settings.clipboard.name", systemImage: "doc.on.clipboard")
                    }
                }

                boundaries
                Section(header: Text("settings.algorithm.batch.title"), footer: Text("settings.algorithm.batch.explain")) {
                    Stepper(value: $batchSize, in: 5...Int.max, step: 5) {
                        Label("\(batchSize) words", systemImage: "square.stack")
                    }
                }

                NavigationLink(destination: { syllables }) {
                    Label("settings.syllable.title", systemImage: "quote.closing")
                }
            }
            .navigationTitle("settings.title")
        }
    }

    var boundaries: some View {
        Section(header: Text("settings.algorithm.boundaries.title"), footer: Text("settings.algorithm.boundaries.explain")) {
            Stepper(value: $minGenerationValue, in: 3...maxGenerationValue) {
                Label("Min: \(minGenerationValue) letters", systemImage: "smallcircle.filled.circle")
            }
            Stepper(value: $maxGenerationValue, in: minGenerationValue...8) {
                Label("Max: \(maxGenerationValue) letters", systemImage: "circle.circle.fill")
            }
        }
    }

    var syllables: some View {
        List {
            Section(footer: syllableFooter) {
                HStack {
                    TextField("settings.syllable.textprompt", text: $customSyllableEntry)
                        .textCase(.uppercase)
                        .font(.system(.body, design: .monospaced))
                    Button(action: {
                        customSyllables.append(customSyllableEntry.toSyllableMarker())
                        customSyllableEntry = ""
                    }) {
                        Text("settings.syllable.add")
                    }
                    .disabled(customSyllableEntry.isEmpty)
                }
            }



            Section(footer: Text("settings.syllable.footer")) {
                ForEach(customSyllables, id: \.self) { custom in
                    Text(custom)
                        .font(.system(.body, design: .monospaced))
                }
                .onDelete { indices in
                    indices.forEach { idx in customSyllables.remove(at: idx) }
                }
                ForEach(SyllableShapes.common(), id: \.self) { syl in
                    VStack(alignment: .leading) {
                        Text(syl)
                            .foregroundColor(.secondary)
                            .font(.system(.body, design: .monospaced))
                        Text("Common")
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                }
            }
        }
        .navigationTitle("settings.syllable.title")
        #if os(iOS)
        .toolbar {
            EditButton()
                .disabled(customSyllables.isEmpty)
        }
        #endif
    }

    var syllableFooter: some View {
        Group {
            if customSyllableEntry.count > 8 {
                Label {
                    Text("settings.syllable.limit")
                } icon: {
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundColor(.yellow)
                }
            } else if !customSyllableEntry.isMarker {
                Label("settings.syllable.convert", systemImage: "wand.and.stars")
            }
            else {
                Text("")
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsView()
            NavigationView {
                SettingsView().syllables
            }
        }
    }
}

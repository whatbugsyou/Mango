import SwiftUI

struct MGConfigurationSecurityView: View {
    
    @ObservedObject private var vm: MGCreateConfigurationViewModel
    
    init(vm: MGCreateConfigurationViewModel) {
        self._vm = ObservedObject(initialValue: vm)
    }
    
    var body: some View {
        Picker("Security", selection: $vm.security) {
            ForEach(MGConfiguration.Security.allCases) { type in
                Text(type.description)
            }
        }
        switch vm.security {
        case .tls:
            LabeledContent("Server Name") {
                TextField("", text: $vm.tls.serverName)
            }
            LabeledContent("ALPN") {
                HStack {
                    ForEach(MGConfiguration.ALPN.allCases) { alpn in
                        MGToggleButton(
                            title: alpn.description,
                            isOn: Binding(
                                get: {
                                    vm.tls.alpn.contains(alpn.rawValue)
                                },
                                set: { value in
                                    if value {
                                        vm.tls.alpn.append(alpn.rawValue)
                                    } else {
                                        vm.tls.alpn.removeAll(where: { $0 == alpn.rawValue })
                                    }
                                }
                            )
                        )
                    }
                }
            }
            LabeledContent("Fingerprint") {
                Picker("", selection: $vm.tls.fingerprint) {
                    ForEach(MGConfiguration.Fingerprint.allCases) { fingerprint in
                        Text(fingerprint.description)
                    }
                }
            }
            Toggle("Allow Insecure", isOn: $vm.tls.allowInsecure)
        case .reality:
            LabeledContent("Server Name") {
                TextField("", text: $vm.reality.serverName)
            }
            LabeledContent("Fingerprint") {
                Picker("", selection: $vm.reality.fingerprint) {
                    ForEach(MGConfiguration.Fingerprint.allCases) { fingerprint in
                        Text(fingerprint.description)
                    }
                }
            }
            LabeledContent("Public Key") {
                TextField("", text: $vm.reality.publicKey)
            }
            LabeledContent("Short ID") {
                TextField("", text: $vm.reality.shortId)
            }
            LabeledContent("SpiderX") {
                TextField("", text: $vm.reality.spiderX)
            }
        case .none:
            EmptyView()
        }
    }
}

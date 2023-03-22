import SwiftUI

struct MGCreateConfigurationView: View {
    
    @ObservedObject private var vm: MGCreateConfigurationViewModel
    
    @Environment(\.dismiss) private var dismiss
        
    init(protocolType: MGConfiguration.ProtocolType) {
        self._vm = ObservedObject(initialValue: MGCreateConfigurationViewModel(protocolType: protocolType))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    LabeledContent("Description") {
                        TextField("", text: $vm.descriptive)
                    }
                    switch vm.protocolType {
                    case .vless:
                        MGConfigurationVLESSView(vm: vm)
                    case .vmess:
                        MGConfigurationVMessView(vm: vm)
                    case .trojan:
                        MGConfigurationTrojanView(vm: vm)
                    case .shadowsocks:
                        MGConfigurationShadowsocksView(vm: vm)
                    }
                } header: {
                    Text("Server")
                }
                if vm.protocolType.isTransportAvailable {
                    Section {
                        MGConfigurationNetworkView(vm: vm)
                    } header: {
                        Text("Transport")
                    }
                }
                if vm.protocolType.isSecurityAvailable {
                    Section {
                        MGConfigurationSecurityView(vm: vm)
                    } header: {
                        Text("Security")
                    }
                }
            }
            .lineLimit(1)
            .multilineTextAlignment(.trailing)
            .navigationTitle(Text(vm.protocolType.description))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(role: .cancel) {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                    }
                    .fontWeight(.medium)
                }
            }
        }
    }
}

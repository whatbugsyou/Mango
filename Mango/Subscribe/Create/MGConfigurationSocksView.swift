import SwiftUI

struct MGConfigurationSocksView: View {
    
    @ObservedObject private var vm: MGCreateOrUpdateConfigurationViewModel
    
    init(vm: MGCreateOrUpdateConfigurationViewModel) {
        self._vm = ObservedObject(initialValue: vm)
    }
    
    var body: some View {
        LabeledContent("Address") {
            TextField("", text: $vm.socks.address)
        }
        LabeledContent("Port") {
            TextField("", value: $vm.socks.port, format: .number)
        }
        LabeledContent("Username") {
            TextField("", text: $vm.socks.users[0].user)
        }
        LabeledContent("Password") {
            TextField("", text: $vm.socks.users[0].pass)
        }

    }
}


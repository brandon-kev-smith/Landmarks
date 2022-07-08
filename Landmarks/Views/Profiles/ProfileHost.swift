//
//  ProfileHost.swift
//  Landmarks
//
//  Created by Brandon Smith on 7/6/22.
//

import SwiftUI

struct ProfileHost: View {
    @State private var draftProfile = Profile.default
    @Environment(\.editMode) var editMode
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        VStack{
            HStack {
                if editMode?.wrappedValue == .active {
                    Button("Cancel", role: .cancel){
                        draftProfile = modelData.profile
                        editMode?.animation().wrappedValue = .inactive
                    }
                }
                Spacer()
                EditButton()
            }
            if editMode?.wrappedValue == .inactive {
                ProfileSummary(profile: modelData.profile)
            }else{
                ProfileEditor(profile: $draftProfile)
                    .onAppear() {
                        draftProfile = modelData.profile
                    }
                    .onDisappear() {
                        modelData.profile = draftProfile
                    }
            }
        }
        .padding()
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
            .environmentObject(ModelData())
    }
}

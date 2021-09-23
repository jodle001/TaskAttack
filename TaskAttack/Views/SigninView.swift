//
//  SigninView.swift
//  TaskAttack
//
//  Created by Jacob Odle on 9/23/21.
//

import SwiftUI

struct SigninView: View {
    var body: some View {
        VStack {
            Text("Thanks for using TaskAttack.  Please sign in here.")
            SignInWithAppleButton()
        }
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}

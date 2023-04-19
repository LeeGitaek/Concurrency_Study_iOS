//
//  ContentView.swift
//  SampleProject
//
//  Created by gitaeklee on 4/8/23.
//

import SwiftUI

struct EntriesRow: View {
    @Binding var model : Entries
    
    var body: some View {
        VStack {
            Text(model.api)
            Text(model.description)
            Text(model.auth)
            Text(model.cors)
            Text(model.category)
            Text(model.link)
        }
    }
}

struct ErrorView: View {
    @Binding var errorMessage: String
    
    var body: some View {
        LazyVStack {
            if !errorMessage.isEmpty {
                Text("status: \(errorMessage)")
            } else {
                Text("status: success")
            }
        }
    }
}

struct DataInfoView: View {
    @Binding var dataCount: Int
    
    var body: some View {
        LazyVStack {
            if dataCount != 0 {
                Text("count: \(dataCount)")
            } else {
                Text("count: 0")
            }
        }
    }
}

struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            DataInfoView(dataCount: $viewModel.model.count)
            ErrorView(errorMessage: $viewModel.errorModel.errorMsg)
            
            List {
                ForEach($viewModel.model.entries, id:\.self) { entries in
                    EntriesRow(model: entries)
                }
            }
        }
        .task {
            await viewModel.fetchProvider()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

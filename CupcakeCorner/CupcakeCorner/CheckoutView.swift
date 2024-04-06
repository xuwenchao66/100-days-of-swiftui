import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false

    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                ProgressView()
            }.frame(height: 233)
            
            Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
            Button("Place Order") {
                Task {
                    await placeOrder()
                }
            }
            .padding()
        }
        .navigationTitle("Check out")
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") {}
        } message: {
            Text(confirmationMessage)
        }
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Encode error!")
            return
        }
        
        do {
            let url = URL(string: "https://reqres.in/api/cupcakes")!
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField:  "Content-Type")
            request.httpMethod = "POST"
            
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decoded = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decoded.quantity) * \(Order.types[decoded.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
            print(decoded)
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}

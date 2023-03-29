//
//  PostAnalitcsService.swift
//  PoliServices
//
//  Created by Douglas  Rodrigues  on 08/03/23.
//

import UIKit

class PostAnalitcsService {
    
    func post(recibo: String, completion: @escaping(_ salvo: Bool) -> Void) {
        
        let baseURL = "https://run.mocky.io/v3/9c225953-f8b1-4210-bc58-a95a61c6dc9b"
        
        let paramtros: [String: Any] = [
            "reason": recibo
        ]
        
        guard let url = URL(string: baseURL) else { return }
        
        var requisicao = URLRequest(url: url)
        requisicao.httpMethod = "POST"
        requisicao.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requisicao.httpBody = try? JSONSerialization.data(withJSONObject: paramtros, options: .fragmentsAllowed)
        
        URLSession.shared.dataTask(with: requisicao) { data, resposta, error in
            if error != nil {
                completion(false)
            }
            
            guard let data = data else {
                return
            }

            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                completion(true)
            } catch {
                completion(false)
            }
        }.resume()
    }
}

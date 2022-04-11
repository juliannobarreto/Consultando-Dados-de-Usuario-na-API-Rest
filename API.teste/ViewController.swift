//
//  ViewController.swift
//  API.teste
//
//  Created by user212674 on 4/7/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var UmageAvatar: UIImageView!
    
    @IBOutlet weak var txtLastName: UITextField!
    
    @IBOutlet weak var txtFirstName: UITextField!
    
    var userAlterado: UsersModel?
    
    @IBAction func buttonAdd(_ sender: Any) {
        
        //Editando
        if let x = userAlterado {
            editando()
        }
        //salvando
        else {
            salvando()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// quando editar
        if let x = userAlterado {
            txtFirstName.text = x.first_name
            txtLastName.text = x.first_name
            txtEmail.text = x.email
            
        }
    }
                
    func editando() {
            
        let url = URL(string: "https://reqres.in/api/users")!
            
        var requisicao = URLRequest(url: url)
        requisicao.httpMethod = "GET ONE"
            
        requisicao.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
        let user = UsersModel()
        user.first_name = txtLastName.text
        user.last_name = txtFirstName.text
        user.email = txtEmail.text
            
        let encoder = JSONEncoder()
        // conversão atribuir json
        do {
                requisicao.httpBody = try encoder.encode(user)
        }
        catch {
                print("Erro ao converter os dados do user!")
        }
        /// criar tarefa assincrona
        let tarefa = URLSession.shared.dataTask(with: requisicao) {
            (dados, resposta, erro) in
                
            if (erro == nil) {
                print("User criado com sucesso!")
            }
            else{
                    print("Erro ao criar o user!")
            }
        }
        tarefa.resume()
            
    }
        
    func salvando(){
        
        let url = URL(string : "https://reqres.in/api/users")!
                
        var requisicao = URLRequest(url: url)
        requisicao.httpMethod = "POST"
                
        requisicao.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
        let user = UsersModel()
        user.last_name = txtLastName.text
        user.first_name = txtFirstName.text
        user.email  = txtEmail.text
                
        let encoder = JSONEncoder()
            
        // Conversao e atribuir JSON para o corpo da requisicao
        do {
            requisicao.httpBody = try encoder.encode(user)
        }
        catch{
            print("Erro ao recuperar user!")
        }
                
        // criar a tarefa assincrona que vai fazer a requisicao
                
        let tarefa = URLSession.shared.dataTask(with: requisicao){ (dados, resposta, erro) in
                    
            if (erro == nil){
                print("User criado com sucesso!")
            }
            else{
                print("Erro ao criar o user!")
            }
                    
        }
        tarefa.resume()
        
    }


}
    
   

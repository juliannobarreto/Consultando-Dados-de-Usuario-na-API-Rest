//
//  ListandoUsuariosTableViewController.swift
//  API.teste
//
//  Created by user212674 on 4/7/22.
//
import UIKit

class ListUsersTableViewController: UITableViewController {
    
    var users : [UsersModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        recarregarDados()
    }
    
    func recarregarDados(){
        
        print("Users")
        
        if let url = URL(string: "https://reqres.in/api/users"){
            
            let tarefa = URLSession.shared.dataTask(with: url){
                (dados, requisicao, erro) in
                                           
                    if erro == nil{
                        print("Dados resgatados com sucesso")
                        
                        let jDecoder = JSONDecoder()
                        
                        if let dadosRetornados = dados {
                            
                            do {
                                let resposta = try
                                 jDecoder.decode(InforUsers.self, from: dadosRetornados)
                                self.users = resposta.data
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            }
                            catch {
                                print("Erro ao converter Users")
                            }
                        }
                    }else{
                        print("Erro ao consultar a dados")
                    }
            }
            tarefa.resume()
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = self.users[indexPath.row].last_name
        cell.textLabel?.text = self.users[indexPath.row].first_name
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let id = users[indexPath.row].id!
            
            let urlStr = "https://reqres.in/api/users\(id)"
            let url = URL(string: urlStr)!
            
            print(urlStr)
            
            var requisicao = URLRequest(url: url)
            requisicao.httpMethod = "DELETE"
            
            requisicao.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let tarefa = URLSession.shared.dataTask(with: requisicao) {
                (dados, resposta, erro) in
                
                if (erro == nil) {
                    print("User deletado com sucesso!")
                    self.users.remove(at: indexPath.row)
                    // Delete the row from the data source
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
                else{
                    print("Erro ao deletatar o user!")
                }
            }
            tarefa.resume()
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let usersAlterado = users[indexPath.row]
        
        performSegue(withIdentifier: "userAlterandoSegue", sender: usersAlterado)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "userAlterandoSegue") {
            
            let controller = segue.destination as! ViewController
            
            if let add = sender as? UsersModel {
                
                controller.userAlterado = add
            }
            
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



    }


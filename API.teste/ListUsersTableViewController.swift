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
        
        print("Professores")
        
        if let url = URL(string: "https://cors.grandeporte.com.br/cursos.grandeporte.com.br:8080/professores"){
            
            let tarefa = URLSession.shared.dataTask(with: url){
                (dados, requisicao, erro) in
                                           
                    if erro == nil{
                        print("Dados capturados da API com sucesso")
                        //print(dados)
                        
                        let jDecoder = JSONDecoder()
                        
                        if let dadosRetornados = dados{
                            do {
                                self.professores  = try jDecoder.decode([ProfessorModel].self, from: dadosRetornados)
                                //print(self.professores)
                                //self.tableView.reloadData()
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            }
                            catch {
                                print("Erro ao converter Professor Model")
                            }
                        }
                    }else{
                        print("Erro ao consultar a API")
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
        return usuarios.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = self.usuarios[indexPath.row].nome
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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


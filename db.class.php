<?php

class db {

	//host
	private $host;

	//usuario
	private $usuario;

	//senha
	private $senha;

	//banco de dados
	private $database;

	public function __construct(){
		$this->host     = getenv('DB_HOST') ?: 'localhost';
		$this->usuario  = getenv('DB_USER') ?: 'root';
		$this->senha    = getenv('DB_PASS') ?: '';
		$this->database = getenv('DB_NAME') ?: 'twitter_clone';
	}

	public function conecta_mysql(){

		//criar a conexao
		$con = mysqli_connect($this->host, $this->usuario, $this->senha, $this->database);

		//ajustar o charset de comunicação entre a aplicação e o banco de dados
		mysqli_set_charset($con, 'utf8');

		//verficar se houve erro de conexão
		if(mysqli_connect_errno()){
			echo 'Erro ao tentar se conectar com o BD MySQL: '.mysqli_connect_error();	
		}

		return $con;
	}

}

?>

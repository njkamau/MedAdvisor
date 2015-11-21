<?php
class Medic {
	private $medic_id;
	private $firstname;
	private $lastname;
	private $email;
	private $phonenumber;
	private $id_number;
	private $privilege;

	public function __construct($registry) {
		$this->config = $registry->get('config');
		$this->db = $registry->get('db');
		$this->request = $registry->get('request');
		$this->session = $registry->get('session');

		if (isset($this->session->data['medic_id'])) {
			$medic_query = $this->db->query("SELECT * FROM medics WHERE medic_id = '" . (int)$this->session->data['medic_id'] . "'");

			if ($medic_query->num_rows) {
				$this->medic_id = $medic_query->row['medic_id'];
				$this->firstname = $medic_query->row['firstname'];
				$this->lastname = $medic_query->row['lastname'];
				$this->email = $medic_query->row['email'];
				$this->phonenumber = $medic_query->row['phonenumber'];
				$this->id_number = $medic_query->row['id_number'];
				$this->privilege = $medic_query->row['privilege'];

			} else {
				$this->logout();
			}
		}
	}

	public function login($email, $password) {

		$medic_query = $this->db->query("SELECT * FROM medics WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "' AND (password = SHA1(CONCAT(salt, SHA1(CONCAT(salt, SHA1('" . $this->db->escape($password) . "'))))) OR password = '" . $this->db->escape(md5($password)) . "') AND status = '1' AND approved = '1'");

		if ($medic_query->num_rows) {
			$this->session->data['medic_id'] = $medic_query->row['medic_id'];

			$this->medic_id = $medic_query->row['medic_id'];
			$this->firstname = $medic_query->row['firstname'];
			$this->lastname = $medic_query->row['lastname'];
			$this->email = $medic_query->row['email'];
			$this->phonenumber = $medic_query->row['phonenumber'];
			$this->id_number = $medic_query->row['id_number'];
			$this->privilege = $medic_query->row['privilege'];

			return true;
		} else {
			return false;
		}
	}

	public function logout() {

		unset($this->session->data['medic_id']);

		$this->medic_id = '';
		$this->firstname = '';
		$this->lastname = '';
		$this->email = '';
		$this->phonenumber = '';
		$this->id_number = '';
	}

	public function isLogged() {
		return $this->medic_id;
	}

	public function getId() {
		return $this->medic_id;
	}

	public function getFirstName() {
		return $this->firstname;
	}

	public function getLastName() {
		return $this->lastname;
	}

	public function getEmail() {
		return $this->email;
	}

	public function getPhonenumber() {
		return $this->phonenumber;
	}

	public function getIdnumber() {
		return $this->Idnumber;
	}
}
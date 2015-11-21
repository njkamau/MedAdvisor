<?php
class ModelAccountMedic extends Model {

	public function getMedic($medic_id) {
		$query = $this->db->query("SELECT * FROM medics WHERE medic_id = '" . (int)$medic_id . "'");

		return $query->row;
	}

	public function getMedicByEmail($email) {
		$query = $this->db->query("SELECT * FROM medics WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");

		return $query->row;
	}

	public function getTotalMedicsByEmail($email) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM medics WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");

		return $query->row['total'];
	}
}

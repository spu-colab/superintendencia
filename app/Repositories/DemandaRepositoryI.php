<?php

namespace App\Repositories;

use App\User;
use App\DivisaoOrganograma;

interface DemandaRepositoryI {

    public function listarDistribuidasParaUsuario(User $user) : array;

    public function listarDistribuidasParaDivisaoOrganograma(DivisaoOrganograma $divisaoOrganograma) : array;

}

?>
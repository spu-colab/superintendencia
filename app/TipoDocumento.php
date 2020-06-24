<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class TipoDocumento extends Model
{

    public const TABLE_NAME = "tipodocumento";
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = TipoDocumento::TABLE_NAME;
    
}

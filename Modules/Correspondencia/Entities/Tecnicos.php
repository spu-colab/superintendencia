<?php

namespace Modules\Correspondencia\Entities;

use Illuminate\Database\Eloquent\Model;

class Tecnicos extends Model
{
    protected $connection = 'spuadmin';
    protected $table = "tecnicos";
    protected $primaryKey = 'codigo';
    protected $fillable = [];
    public $timestamps = false;
    protected $hidden = ['senha'];
    protected $with = ['setor'];

    public function setor()
    {
        return $this->belongsTo('Modules\Correspondencia\Entities\Setor','setor','codigo');
    }

}

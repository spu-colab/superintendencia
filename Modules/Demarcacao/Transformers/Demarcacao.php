<?php

namespace Modules\Demarcacao\Transformers;

use Illuminate\Http\Resources\Json\Resource;

class Demarcacao extends Resource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request
     * @return array
     */
    public function toArray($request)
    {
        $resource = parent::toArray($request);
        $resource['subtituloGeoReferencia'] = $this->subtituloGeoReferencia(); // $this->trecho->trechodemarcacao;
        return $resource;
    }
}

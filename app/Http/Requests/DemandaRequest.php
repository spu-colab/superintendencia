<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class DemandaRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'demanda.idAutorDemanda' => 'required|int',
            'demanda.idProcedimentoExterno' => 'required|int',
            'demanda.idTipoDocumento' => 'required|int',
            'demanda.documentoExterno' => 'required',
            'demanda.nupSEI' => 'required',
            // 'demanda.idSituacaoDemanda' => 'required|int',
            'demanda.demanda' => 'required'
        ];
    }
}

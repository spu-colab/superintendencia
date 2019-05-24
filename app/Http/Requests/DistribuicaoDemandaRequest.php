<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class DistribuicaoDemandaRequest extends FormRequest
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
            'distribuicao.idDemanda' => 'required_if:distribuicao.id,null|int',
            'distribuicao.idUsuarioDe' => 'required_if:distribuicao.id,null|int',
            'distribuicao.assignable_id' => 'required_if:distribuicao.id,null|int',
            'distribuicao.assignable_type' => 'required_if:distribuicao.id,null'
        ];
    }
}

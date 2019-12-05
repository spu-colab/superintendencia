<?php

namespace Modules\Governanca\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class MetaEspecificaUnidadeRequest extends FormRequest
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'idMetaEspecifica' => 'required|int',
            'idDivisaoOrganograma' => 'required|int'
        ];
    }

    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }
}

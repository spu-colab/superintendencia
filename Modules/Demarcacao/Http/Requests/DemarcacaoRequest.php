<?php

namespace Modules\Demarcacao\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class DemarcacaoRequest extends FormRequest
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'id_tipodemarcacao' => 'required|numeric',
            'id_situacaodemarcacao' => 'required|numeric',
            'id_trechodemarcacao' => 'required|numeric',
            'processo' => 'required|regex:/^([0-9]{5})\.?([0-9]{6})\/?([0-9]{4})\-?([0-9]{2})/'
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

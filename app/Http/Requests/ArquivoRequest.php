<?php

namespace App\Http\Requests;

use App\Arquivo;
use Illuminate\Foundation\Http\FormRequest;

class ArquivoRequest extends FormRequest
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
            'disco' => 'required',
            'diretorio' => 'required',
        ];
    }

    public function withValidator($validator)
    {
        $validator->after(function ($validator) {
            if ($this->discoInvalido()) {
                $validator->errors()->add('disco', 'Disco inválido');
            }
            if ($this->diretorioInvalido()) {
                $validator->errors()->add('diretorio', 'Diretório inválido');
            }
        });
    }

    private function discoInvalido() {
        return !key_exists($this->disco, Arquivo::DISCOS);
    }

    private function diretorioInvalido() {
        return !key_exists($this->diretorio, Arquivo::DISCOS[$this->disco]);
    }

}

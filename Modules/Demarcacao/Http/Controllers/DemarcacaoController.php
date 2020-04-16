<?php

namespace Modules\Demarcacao\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;

use App\Http\Controllers\Controller;
use Modules\Demarcacao\Entities\Demarcacao;
use Modules\Demarcacao\Http\Requests\DemarcacaoRequest;
use Modules\Demarcacao\Transformers\Demarcacao as DemarcacaoResource;

class DemarcacaoController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index()
    {
        $result = Demarcacao::with(['tipo','situacao','trecho'])
            ->get();
        return DemarcacaoResource::collection($result);
    }

    /**
     * Store a newly created resource in storage.
     * @param DemarcacaoRequest $request
     * @return Response
     */
    public function store(DemarcacaoRequest $request)
    {
        $validatedData = $request->validated();

        $demarcacao = new Demarcacao();
        $demarcacao->fill($request->all());

        $this->authorize('create', $demarcacao);

        $demarcacao->save();
        return new DemarcacaoResource($demarcacao);
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Response
     */
    public function show($id)
    {
        $demarcacao = Demarcacao::with(['tipo','situacao','trecho'])->findOrFail($id);
        return new DemarcacaoResource($demarcacao);
    }

    /**
     * Update the specified resource in storage.
     * @param DemarcacaoRequest $request
     * @param int $id
     * @return Response
     */
    public function update(DemarcacaoRequest $request, $id)
    {
        $validatedData = $request->validated();

        $demarcacao = Demarcacao::findOrFail($id);
        $demarcacao->fill($request->all());

        $this->authorize('update', $demarcacao);

        $demarcacao->update();        
        return response()->json($demarcacao);
    }

    /**
     * Remove the specified resource from storage.
     * @param int $id
     * @return Response
     */
    public function destroy($id)
    {
        //
    }
}

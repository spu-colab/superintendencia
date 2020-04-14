<?php

namespace Modules\Demarcacao\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;

use App\Http\Controllers\Controller;
use Modules\Demarcacao\Entities\Demarcacao;
use Modules\Demarcacao\Http\Requests\DemarcacaoRequest;

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
        return response()->json($result);
    }

    /**
     * Show the form for creating a new resource.
     * @return Response
     */
    public function create()
    {
        return null;
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
        return response()->json($demarcacao);
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Response
     */
    public function show($id)
    {
        return Demarcacao::with(['tipo','situacao','trecho'])->findOrFail($id);
    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Response
     */
    public function edit($id)
    {
        return null;
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

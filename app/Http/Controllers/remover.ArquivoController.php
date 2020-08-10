<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\File;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Storage;
use App\Http\Controllers\Controller;

use App\Arquivo;

class ArquivoController extends Controller
{

    public function index() {
        $files = Arquivo::all();
        // return view('arquivo.index', compact('files'));
        return response()->json($files);
    }

    public function uploadFile(Request $request) {
        $file = Input::file('file');
        $path = '';
        $filename = hash( 'sha256', $file).'.'.$file->getClientOriginalName();      

        if($request->file('file')->storeAs($path, $filename, 'uploads')) {
            $input['filename'] = $filename;
            $input['mime'] = $file->getClientMimeType();
            $input['path'] = $path;
            $input['size'] = $file->getClientSize();
            $file = Arquivo::create($input);

            return response()->json([
                'success' => true,
                'id' => $file->id
            ], 200);
        }
        return response()->json([
            'success' => false
        ], 500);
    }
}

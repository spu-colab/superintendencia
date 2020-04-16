var Validador = function() {

    var email = function(v) {
        return /.+@.+\..+/.test(v) || 'E-mail precisa ser válido'
    }

    var obrigatorio = function(valor) {
        let mensagem = "Preenchimento obrigatório."
        if(valor == null || valor.length == 0) {
            return mensagem
        }
        return true
    }

    var tamanhoMinimo = function(valor, tamanho) {
        console.log('tamanhoMinimo')
        if (valor == null) {
            return true
        }
        if (valor.length >= tamanho) {
            return true
        }
        return 'O tamanho mínimo: ' + tamanho + ' caracteres.'
    }

    return { 
        email: email,
        obrigatorio: obrigatorio,
        tamanhoMinimo : tamanhoMinimo,
    }
} ();

module.exports = Validador;
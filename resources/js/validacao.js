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
        if (valor == null) {
            return true
        }
        if (valor.length >= tamanho) {
            return true
        }
        return 'O tamanho mínimo: ' + tamanho + ' caracteres.'
    }

    var tamanho = function(valor, tamanho) {
        if (valor == null) {
            return true
        }
        if (valor.length == tamanho) {
            return true
        }
        return 'O tamanho deve ser de ' + tamanho + ' caracteres.'
    }

    var igual = function(valor, aComparar, mensagem) {
        if(valor == null) {
            return true
        }

        if(valor == aComparar) {
            return true
        }
        return mensagem
    }

    return { 
        email: email,
        obrigatorio: obrigatorio,
        tamanhoMinimo : tamanhoMinimo,
        tamanho: tamanho,
        igual: igual
    }
} ();

module.exports = Validador;
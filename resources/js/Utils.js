export default {
    parseDate (date) {
        // console.log(date)
        if (!date) return null

        const [day, month, year] = date.split('/')
        let retorno = `${year}-${month.padStart(2, '0')}-${day.padStart(2, '0')}`
        // console.log('parseDate = ')
        // console.log(retorno)
        return retorno
    },
    formatDate (date) {
        // console.log(date)
        if (!date) return null
        
        const [year, month, day] = date.split('-')
        let retorno = `${day}/${month}/${year}`
        // console.log('formatDate =')
        // console.log(retorno)
        return retorno
    },

    formatarDataHora(dataHora) {
        if(dataHora == null)
            return null
        return new Date(dataHora).toLocaleString()
    },

    validacao: {
        obrigatorio: v => !!v || 'Preenchimento obrigatório.',
        min15: v => !!v && v.length >= 15 || 'No mínimo 15 caracteres' ,
        min8: v => !!v && v.length >= 8 || 'No mínimo 8 caracteres' ,
        min5: v => !!v && v.length >= 5 || 'No mínimo 5 caracteres',
        min3: v => !!v && v.length >= 3 || 'No mínimo 3 caracteres',
        min2: v => !!v && v.length >= 2 || 'No mínimo 2 caracteres',
        email: v => {
            if(v == null || v.length == 0) {
                return true
            }
            return /.+@.+\..+/.test(v) || 'E-mail precisa ser válido'
        }
    },

    obterDateCorretoServidor(date) {
        let _date = new Date(date)
        _date.setHours(_date.getHours() - 1)
        return _date
    },

    tempoDecorridoEntre(date2, date1) {
        let totalSegundos = Math.floor(Math.abs(date2 - date1) / 1000);

        
        
        let dias = Math.floor(totalSegundos / 86400);
        let sobraSegundos = totalSegundos - (dias * 86400);

        let horas = Math.floor(sobraSegundos / 3600);
        sobraSegundos -= horas * 3600;
        horas = ('' + horas).padStart(2, '0')
        
        let minutos = Math.floor(sobraSegundos / 60);
        sobraSegundos -= minutos * 60;
        minutos = ('' + minutos).padStart(2, '0')
        
        let segundos = ('' + sobraSegundos).padStart(2, '0')

        let resultado = ''
        if(dias > 0) {
            resultado = dias + ' dia' + (dias > 1 ? 's' : '') + ' + '
        }
        resultado = resultado + horas + ':' + minutos + ':' + segundos
        return resultado
    },
    
}
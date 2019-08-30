let reports = [
    {
        id: 1, text: "Informações gerenciais", open: 1, items: [
            {id: 2, text: "Frequência de passagem", userdata: {
                    info: {modelo: './html/modelos/analiticos/tabela.html',
                        titulo: "Relatório analítico de capturas LPR",
                        subtitulo: "Demonstrativo de frequências por ponto de acesso",
                        descricao: "Relatório das passagens por ponto de acesso. Apresenta o ponto de acesso, as datas e as frequências de captura para o período selecionado ou os últimos 30 dias.",
                        origem: "/smart/public/diario_captura_analitico",
                        campos:[
                            {nome:"data", label:"Data", detail: true, type:"date", format:"DD/MM/YYYY"},
                            {nome:"cliente", label:"Cliente", group: true, type: "combo"},
                            {nome:"ponto", label:"Ponto", group: true, type: "combo"},
                            {nome:"coletor", label:"Coletor", detail: true, type: "combo"},
                            {nome:"identificacoes", label:"Identificações", totais: true, avgs: true, type:"number", format: '0,'},
                            {nome:"ident_hora", label:"Ident./Hora", totais: false, avgs: true, type:"number", format: '0,'},
                            {nome:"capturas", label:"Capturas", totais: true, avgs: true, type:"number", format: '0,'},
                            {nome:"capt_hora", label:"Capt./Hora", totais:false, avgs: true, type:"number", truncate: true},
                            {nome:"avgprocessing_time_ms", label:"Méd. T. Process.", totais:false, avgs: true, type:"number", truncate: true},
                            {nome:"minprocessing_time_ms", label:"Mín. T. Process.", totais:false, avgs: true, type:"number", truncate: true},
                            {nome:"maxprocessing_time_ms", label:"Máx. T. Process.", totais:false, avgs: true, type:"number", truncate: true},
                            {nome:"avgconfidence", label:"Méd. LPR", totais:false, avgs: true, type:"number", truncate: true},
                            {nome:"minconfidence", label:"Mín. LPR", totais:false, avgs: true, type:"number", truncate: true},
                            {nome:"maxconfidence", label:"Máx. LPR", totais:false, avgs: true, type:"number", truncate: true}
                        ]
                    }
                }
            }
        ]
    }
];
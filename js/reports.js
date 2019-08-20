let reports = [
    {
        id: 1, text: "Informações gerenciais", open: 1, items: [
            {id: 2, text: "Frequência de passagem", userdata: {
                    origem: "/smart/public/diario",
                    campos: "data,identificacoes,capturas",
                    filtros: [
                        {type:"combo", name:"data_inicial"}
                    ]}
            }
        ]
    }
];
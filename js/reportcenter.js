class Reportcenter {

    constructor(cell) {

        let layout = cell.attachLayout({
            pattern: '2U',
            offsets: {
                top: 0,
                right: 0,
                bottom: 0,
                left: 0
            },
            cells: [
                {
                    id: 'a',
                    header: false,
                    width: 250
                },
                {
                    id: 'b',
                    header: false
                }
            ]
        });

        let Tree = layout.cells('a').attachTreeView({
            items: [
                {
                    id: 1, text: "Informações gerenciais", open: 1, items: [
                        {
                            id: 2, text: "Frequência de passagem", userdata: {
                                name1: "value1", name2: "value2"
                            }
                        }
                    ]
                }
            ]
        });

        Tree.attachEvent("onClick", function(id){

        });


    }
}
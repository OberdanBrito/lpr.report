class Reportcenter {

    constructor(cell) {

        let thisreport = this;

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
            items: reports
        });

        Tree.attachEvent("onDblClick", function(id){
            thisreport.MontaLayout(id);
            return true;
        });

    }

    MontaLayout(id) {

        let info = new Info();
        info.api = Tree.getUserData(id, "origem");
        info.Listar({
            fields:Tree.getUserData(id, "campos"),
            callback: function (response) {
                console.debug(response);
            }
        });

    }
}
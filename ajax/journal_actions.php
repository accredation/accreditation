<?php
echo '<div class="modal" id="journalActions" style="display: block" >
<div class="modal-dialog " style="max-width: 80vw;">
    <div class="modal-content">

       
        <div class="modal-header" >
            <div style="display: flex">
                <h4 class="modal-title">Журнал событий</h4>
            </div>

            <div style="display: flex">


                <button type="button" class="btn  btn-danger btn-close  "  data-bs-dismiss="modal" id="closeJournalX" onClick="closeJournal()">x</button>
            </div>
        </div>

      
        <div class="modal-body">
            <div id="tableActions" >        

            </div>
        </div>

       
        <div class="modal-footer">          
            <button type="button" class="btn btn-success btn-fw " data-bs-dismiss="modal" id="btnRefresh" onClick="refreshJournal()">Обновить</button>
            <button type="button" class="btn btn-danger " data-bs-dismiss="modal" id="closeJournal" onClick="closeJournal()">Закрыть</button>
        </div>

    </div>
</div>
</div>


';


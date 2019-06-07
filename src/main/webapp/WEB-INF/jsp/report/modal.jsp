<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!-- 방 추가하기 버튼 Modal -->
<div class="modal fade" id="addRoom" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Create Report</h4>
                <button type="button" class="close" data-dismiss="modal">×</button>
            </div>
            <div class="modal-body">
                <div class="form-group row">
                    <label class="col-md-3 col-form-label form-control-label">제목</label>
                    <div class="col-md-9">
                        <input id = "name" class="form-control" type="text" value=""/>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-lg-3 col-form-label form-control-label">비밀번호</label>
                    <div class="col-lg-9">
                        <input id = "password" class="form-control" type="password" value=""/>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-lg-3 col-form-label form-control-label">방 설명</label>
                    <div class="col-lg-9">
                        <input id = "info" class="form-control" type="text" value=""/>
                        <input id = "manager" class="form-control" type="hidden" value="${username}"/>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button id = "modalCreate" type="button" class="btn btn-success">Create</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div>

<!-- 방나가기 버튼 Modal -->
<div class="modal fade" id="outRoom" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Go Out Room</h4>
                <button type="button" class="close" data-dismiss="modal">×</button>
            </div>
            <div align="center" class="modal-body text-center">
                <div class="text-center" align="center">
                    방을 정말로 나가시겠습니까 ?
                </div>
            </div>
            <div class="modal-footer">
                <input id = "roomNo" class="form-control" type="hidden" value="${roomNo}"/>
                <button id="outRoombtn" type="button" class="btn btn-danger">방 나가기 </button>
            </div>
        </div>

    </div>
</div>

<!-- 방 password 입력 Modal -->
<div class="modal fade" id="inRoom" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Input Password </h4>
                <button type="button" class="close" data-dismiss="modal">×</button>
            </div>
            <div class="modal-body">
                <div class="form-group row">
                    <label class="col-md-3 col-form-label form-control-label">제목</label>
                    <input id = "roomId" class="form-control" type="hidden" value=""/>
                    <div class="col-md-9">
                        <label id = "title"></label>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-lg-3 col-form-label form-control-label">비밀번호</label>
                    <div class="col-lg-9">
                        <input id = "inputPassword" class="form-control" type="password" value=""/>
                    </div>
                </div>
                <div align="center" class="modal-body text-center">
                    <div class="text-center" align="center">
                        <label id="warning" style="color: red"></label>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button id = "goInRoom" type="button" class="btn btn-success">Attend</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div>
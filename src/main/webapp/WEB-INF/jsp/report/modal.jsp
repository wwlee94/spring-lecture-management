<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!-- 방 추가하기 버튼 Modal -->
<html>

<style type="text/css">

    .fileB input[type="file"] {
        position: absolute;
        width: 1px;
        height: 1px;
        padding: 0;
        margin: -1px;
        overflow: hidden;
        clip: rect(0, 0, 0, 0);
        border: 0;
    }

    .fileB label {
        display: inline-block;
        padding: .5em .75em;
        color: #999;
        font-size: inherit;
        line-height: normal;
        vertical-align: middle;
        background-color: #fdfdfd;
        cursor: pointer;
        border: 1px solid #ebebeb;
        border-bottom-color: #e2e2e2;
        border-radius: .25em;
    }

    /* named upload */
    .fileB .upload-name {
        display: inline-block;
        padding: .5em .75em;
        font-size: inherit;
        font-family: inherit;
        line-height: normal;
        vertical-align: middle;
        background-color: #f5f5f5;
        border: 1px solid #ebebeb;
        border-bottom-color: #e2e2e2;
        border-radius: .25em;
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
    }

    .fileB.bs3-primary label {
        color: #fff;
        background-color: #337ab7;
        border-color: #2e6da4;
    }
</style>

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
                        <input id="name" class="form-control" type="text" value=""/>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-lg-3 col-form-label form-control-label">비밀번호</label>
                    <div class="col-lg-9">
                        <input id="password" class="form-control" type="password" value=""/>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-lg-3 col-form-label form-control-label">방 설명</label>
                    <div class="col-lg-9">
                        <input id="info" class="form-control" type="text" value=""/>
                        <input id="manager" class="form-control" type="hidden" value="${username}"/>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button id="modalCreate" type="button" class="btn btn-success">Create</button>
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
                <input id="roomNo" class="form-control" type="hidden" value="${roomNo}"/>
                <button id="outRoombtn" type="button" class="btn btn-danger">방 나가기</button>
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
                    <input id="roomId" class="form-control" type="hidden" value=""/>
                    <div class="col-md-9">
                        <label id="title"></label>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-lg-3 col-form-label form-control-label">비밀번호</label>
                    <div class="col-lg-9">
                        <input id="inputPassword" class="form-control" type="password" value=""/>
                    </div>
                </div>
                <div align="center" class="modal-body text-center">
                    <div class="text-center" align="center">
                        <label id="warning" style="color: red"></label>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button id="goInRoom" type="button" class="btn btn-success">Attend</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div>

<!-- 방에 글 추가하기 -->
<div class="modal fade" id="addBoardModal" role="dialog">
    <div class="modal-dialog modal-lg">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">새 글 작성</h4>
                <button type="button" class="close" data-dismiss="modal">×</button>
            </div>

            <div class="modal-body">
                <div class="form-group row">
                    <label class="col-md-3 col-form-label form-control-label">제목</label>
                    <div class="col-md-9">
                        <input id="boardTitle" class="form-control" type="text" value=""/>
                        <input id="roomNoFromReport" class="form-control" type="hidden" value=""/>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-lg-3 col-form-label form-control-label">내용</label>
                    <div class="col-lg-9">
                        <textarea class="form-control" id="contents" rows="15"></textarea>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-lg-3 col-form-label form-control-label">첨부 파일</label>
                    <div class="col-lg-9">
                        <div class="fileB bs3-primary">
                            <input id="upload-name" class="upload-name" value="파일선택" disabled="disabled">

                            <label for="ex_filename">업로드</label>
                            <input type="file" id="ex_filename" class="upload-hidden">
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button id="addBoardBtn" type="button" class="btn btn-success">Submit</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div>

<!-- 글 삭제하기 Modal -->
<div class="modal fade" id="deleteBoardModal" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">글 삭제하기</h4>
                <button type="button" class="close" data-dismiss="modal">×</button>
            </div>
            <div align="center" class="modal-body text-center">
                <div class="text-center" align="center">
                    글을 정말 삭제 하시겠습니까 ?
                </div>
            </div>
            <div class="modal-footer">
                <input id="deleteBno" class="form-control" type="hidden" value=""/>
                <button id="deleteBoardBtn" type="button" class="btn btn-danger">글 삭제하기</button>
            </div>
        </div>

    </div>
</div>

<!-- 방에 글 수정하기 -->
<div class="modal fade" id="modifiedBoardModal" role="dialog">
    <div class="modal-dialog modal-lg">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">글 수정하기</h4>
                <button type="button" class="close" data-dismiss="modal">×</button>
            </div>

            <div class="modal-body">
                <div class="form-group row">
                    <label class="col-md-3 col-form-label form-control-label">제목</label>
                    <div class="col-md-9">
                        <input id="modifiedBoardTitle" class="form-control" type="text" value=""/>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-lg-3 col-form-label form-control-label">내용</label>
                    <div class="col-lg-9">
                        <textarea class="form-control" id="modifedBoardContents" rows="15"></textarea>\
                        <input id="modifiedBno" class="form-control" type="hidden" value=""/>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button id="modifiedModalBtn" type="button" class="btn btn-success">Submit</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        var fileTarget = $(".fileB .upload-hidden");

        fileTarget.on('change', function () {
            if (window.FileReader) {
                var filename = $(this)[0].files[0].name;
            } else {
                var filename = $(this).val().split('/').pop().split('\\').pop();
            }
            console.log(filename);
            $('#upload-name').val(filename);
        });
    });
</script>
</html>
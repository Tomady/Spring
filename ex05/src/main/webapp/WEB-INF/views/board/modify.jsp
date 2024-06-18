<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- add header -->
<%@ include file="../includes/header.jsp" %>
<div id="wrapper">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Board Modify page</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">Board Modify Page</div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <form role="form" action="/board/modify" method="post">
                            <input type="hidden" name="pageNum" th:value="${cri.pageNum}">
                            <input type="hidden" name="amount" th:value="${cri.amount}">
                            <input type="hidden" name="type" th:value="${cri.type}">
                            <input type="hidden" name="keyword" th:value="${cri.keyword}">
                            <div class="form-group">
                                <label>BoardId</label>
                                <input class="form-control" name="bno" th:value="${board.bno}" readonly="readonly">
                            </div>
                            <div class="form-group">
                                <label>Title</label>
                                <input class="form-control" name="title" th:value="${board.title}">
                            </div>
                            <div class="form-group">
                                <label>Content</label>
                                <textarea class="form-control" rows="3" name="content" th:value="|${board.content}|" th:text="|${board.content}|"></textarea>
                            </div>
                            <div class="form-group">
                                <label>writer</label>
                                <input class="form-control" name="writer" th:value="${board.writer}" readonly="readonly">
                            </div>
                            <div class="form-group" style="display: none;">
                                <label>RegDate</label>
                                <input class="form-control" name="regDate" th:value="|${#dates.format(board.regdate, 'yyyy-MM-dd')}|">
                            </div>
                            <div class="form-group" style="display: none;">
                                <label>UpdateDate</label>
                                <input class="form-control" name="updateDate" th:value="|${#dates.format(board.updatedate, 'yyyy-MM-dd')}|">
                            </div>
                            <button type="submit" data-oper="modify" class="btn btn-default">Modify</button>
                            <button type="submit" data-oper="remove" class="btn btn-danger">Remove</button>
                            <button type="submit" data-oper="list" class="btn btn-info">List</button>
                        </form>
                    </div>
                    <!-- end panel-body -->
                </div>
                <!-- end panel-body -->
            </div>
            <!-- end panel -->
        </div>
        <!-- /.row -->
    </div>
    <!-- page-wrapper -->
</div>
<!-- wrapper -->
<!-- add footer -->
<%@ include file="../includes/footer.jsp" %>

<script type="text/javascript">
    $(document).ready(function() {
        let formObj = $("form");

        $("button").on("click", function(e) {
            e.preventDefault();

            let operation = $(this).data("oper");

            console.log(operation);

            if(operation === "remove") {
                formObj.attr("action", "/board/remove");
            } else if(operation === "list") {
                // move to list
                formObj.attr("action", "/board/list").attr("method", "get");

                let pageNumTag = $("input[name='pageNum']").clone();
                let amountTag = $("input[name='amount']").clone();
                let keywordTag = $("input[name='keyword']").clone();
                let typeTag = $("input[name='type']").clone();

                formObj.empty();
                formObj.append(pageNumTag);
                formObj.append(amountTag);
                formObj.append(keywordTag);
                formObj.append(typeTag);
            }

            formObj.submit();
        });
    });
</script>

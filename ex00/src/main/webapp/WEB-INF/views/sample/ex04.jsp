<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ex04</title>
</head>
<body>
    <h2>SAMPLEDTO ${sampleDTO}</h2>
    <h2>PAGE ${page}</h2>
</body>
<script type="text/javascript">
    $(document).ready(function() {
        // let result = [[${result}]];

        checkModal(result);

        function checkModal(result) {
            if(result === "") {
                return;
            }

            if(parseInt(result) > 0) {
                $(".modal-body").html("게시글 " + parseInt(result) + "번이 등록되었습니다.");
            }

            $("#myModal").modal("show");
        }
    });
</script>
</html>

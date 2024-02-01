<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>userDelete</title>
</head>
<body>

    <button onclick="userDelete()">삭제하시겠습니까?</button>

    <script>
        function userDelete() {
            var userIdToDelete = prompt("아이디를 다시 입력하세요:");
            if (userIdToDelete !== null && userIdToDelete !== "") {
                $.ajax({
                    type: "POST",
                    url: "UserDAO", 
                    data: { userId: userIdToDelete },
                    success: function(response) {
                        alert("User deleted successfully!");
                    },
                    error: function(error) {
                        alert("Error deleting user: " + error.responseText);
                    }
                });
            }
        }
    </script>

</body>
</html>

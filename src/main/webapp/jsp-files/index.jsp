<%@ page import="com.company.servlet.entity.User" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>привы джавистам</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    <script>
        $(function() {
            $(".action").on("click", function () {
                var id=$(this).attr("value");
                var form=$("#tr_" + id).children();
                var object = {};
                for(var num = 0; num < form.length; num++) {
                    let td=$(form[num]);
                    if(typeof td.data == "function" && td.data("name") != undefined) {
                        object[td.data("name")] = td.text();
                    }
                }
                $("#inputId").val(id);
                $("#inputLastName").val(object.lastName);
                $("#inputName").val(object.name);
                $("#inputPatronymic").val(object.patronymic);
                $("#inputPlace").val(object.place);
                $("#inputLang").val(object.lang);
                $("#createStudent").modal("show");
            });
            $(".create").on("click", function () {
                $("#createStudent").modal("show");
                $("#createStudent form")[0].reset();
            });
        });
    </script>
<body>
<h1>ЭМИС-14м</h1><br>

<form class="form-inline">
    <button type="button" class="btn btn-outline-success create">Добавить</button>
    <input type="searchfield" class="form-control" id="InputSearch" placeholder="Search..." style="width: 80%">
    <button type="button" class="btn btn-outline-primary">Поиск</button>
    <button type="button" class="btn btn-outline-dark">Очистить</button>
</form><br>

<Table class="table">
    <tr>
        <th>Фамилия</th>
        <th>Имя</th>
        <th>Отчество</th>
        <th>Место работы</th>
        <th>Языки</th>
        <th>&nbsp;</th>
        <th>&nbsp;</th>
    </tr>
    <c:forEach var="user" items="${requestScope.users}">
        <tr id="tr_${user.id}">
            <td data-name="lastName"><c:out value="${user.lastName}"/></td>
            <td data-name="name"><c:out value="${user.name}"/></td>
            <td data-name="patronymic"><c:out value="${user.patronymic}"/></td>
            <td data-name="place"><c:out value="${user.place}"/></td>
            <td data-name="lang"><c:out value="${user.lang}"/></td>
            <td width="50"><button type="button" class="btn btn-outline-warning action" value="${user.id}" action="update">Изменить</button></td>
            <td width="50"><a href="?rm=${user.id}" class="btn btn-outline-danger">Удалить</a></td>
        </tr>
    </c:forEach>
</Table>


<div class="modal fade" id="createStudent" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Добавить студента</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form method="post">
                <input type="hidden" name="id" id="inputId" value="0">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="inputLastName">Фамилия</label>
                        <input type="text" class="form-control" id="inputLastName" name="lastName">
                    </div>
                    <div class="form-group">
                        <label for="inputName">Имя</label>
                        <input type="text" class="form-control" id="inputName" name="name">
                    </div>
                    <div class="form-group">
                        <label for="inputPatronymic">Отчество</label>
                        <input type="text" class="form-control" id="inputPatronymic" name="patronymic">
                    </div>
                    <div class="form-group">
                        <label for="inputPlace">Место работы</label>
                        <input type="text" class="form-control" id="inputPlace" name="place">
                    </div>
                    <div class="form-group">
                        <label for="inputLang">Языки</label>
                        <input type="text" class="form-control" id="inputLang" name="lang">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Отменить</button>
                    <button type="submit" class="btn btn-primary">Сохранить</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý khách hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link href="../../css/admin.css" rel="stylesheet">
    <style>
        .title {
            font-size: 50px;
        }

        a {
            text-decoration: none;
        }

        .search {
            margin-left: 20%;
            margin-right: 20%;
        }

        .menu {
            padding-top: 20px;
            padding-bottom: 20px;
        }

        td a {
            margin-left: 10px;
        }
        .btn-danger{
            margin-left: 10px
        }
    </style>
</head>

<body>
    <jsp:include page="../index/header-admin-page.jsp"/>
    <main>
        <div class="container">
            <div class="row align-items-center">
                <div class="col text-center title">
                    Quản lý khách hàng
                </div>
            </div>
            <div class="row text-center">
                <div class="col">
                    <a href="add">Thêm khách hàng</a>
                </div>
            </div>
            <div class="row align-items-center">
                <div class="col text-center" style="font-size: 30px">
                    Danh sách khách hàng
                </div>
            </div>
            <div class="row align-items-center">
                <div class="col text-center search">
                    <form action="search" method="get">
                        <div class="input-group mb-3">
                            <span class="input-group-text" id="inputGroup-sizing-default">Tìm kiếm</span>
                            <input type="text" name="keyword" class="form-control" aria-label="Sizing example input"
                                aria-describedby="inputGroup-sizing-default">
                            <button type="submit">Tìm</button>
                        </div>
                    </form>
                </div>  
            </div>
            <form>
                <table class="table text-center align-middle">
                    <thead>
                        <tr>
                            <th scope="col">STT</th>
                            <th scope="col">Mã KH</th>
                            <th scope="col">Tên khách hàng</th>
                            <th scope="col">Tài khoản</th>
                            <th scope="col">Email</th>
                            <th scope="col">Số điện thoại</th>
                            <th scope="col">Địa chỉ</th>
                            <th scope="col">Trạng thái</th>
                            <th scope="col">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="count" value="1"/>
                        <c:forEach var="row" items="${ListCustomer}">
                            <tr>
                              <th scope="row">${count}</th>
                              <td>${row.customerID}</td>
                              <td>${row.name}</td>
                              <td>${row.username}</td>
                              <td>${row.email}</td>
                              <td>${row.phoneNumber}</td>
                              <td>${row.address}</td>
                              <td>${row.status.name}</td>
                              <td>
                                  <a href="edit/${row.customerID}"><button type="button" class="btn btn-info">Sửa</button></a>
                                  <c:choose>
                                      <c:when test="${row.status.statusID == 1}">
                                        <button type="submit" formaction="lock" 
                                          formmethod="post" value="${row.customerID}" 
                                          name="id" class="btn btn-danger">Khóa
                                        </button>
                                      </c:when>
                                      <c:otherwise>
                                          <button type="submit" formaction="unlock" 
                                          formmethod="post" value="${row.customerID}" 
                                          name="id" class="btn btn-danger">Mở khóa
                                        </button>
                                      </c:otherwise>
                                  </c:choose>
                              </td>
                            </tr>
                            <c:set var="count" value="${count+1}"/>
                        </c:forEach>
                    </tbody>
                </table>
            </form>
        </div>
    </main>
    <jsp:include page="../index/footer-admin-page.jsp"/>                   
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
</body>

</html>

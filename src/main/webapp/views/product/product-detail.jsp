
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
<html>

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Sản phẩm</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="../css/style.css">
        <style>
            .colorOption {
                width: 30px;
                height: 30px;
                border-radius: 50%;
                display: inline-block;
                margin-right: 10px;
                cursor: pointer;
            }

            .colorOption:hover {
                transform: scale(1.2);
            }

            #productImage {
                width: 80%;
                height: 350px;
            }

            .input-quantity {
                max-width: 90px;
            }

            main {
                margin: 30px 30px;
            }

            .show-price {
                font-weight: bold;
            }

            .btn-success {
                margin-right: 20px;
                margin-top: 20px;
            }

            #colorOptions {
                margin-bottom: 20px;
            }
            .card{
                margin-top: 20px;
            }
        </style>
    </head>

    <body>
        <header>
            <jsp:include page="../index/header-top.jsp"></jsp:include>
            <jsp:include page="../index/header-middle.jsp"></jsp:include>
            </header>
            <main>
                <div class="container">
                    <div class="row">
                        <div class="col-md-4 text-center">
                            <img id="productImage" src="" alt="Product Image">
                        </div>
                        <div class="col-md-6">
                            <h3>${Product.name}</h3>
                        <p>Thương hiệu: ${Product.supplier.name}</p>
                        <h2 class="show-price"><fmt:formatNumber value="${Product.price}" pattern="###,###,###"/></h2>
                        <h5>Màu sắc</h5>
                        <div id="colorOptions">
                            <c:set value="1" var="count"/>
                            <c:forEach var="row" items="${Product.productColorList}">
                                <button onclick="changeImage('/banhang/${row.images}')" type="button"
                                        name="color" value="${row.color.colorID}" class="btn btn-outline-secondary" id="btn-color-${count}">${row.color.name}</button>
                                <c:set value="${count+1}" var="count"/>
                            </c:forEach>
                        </div>
                        <div class="input-group flex-nowrap">
                            <span class="input-group-text" id="addon-wrapping" >Số lượng: </span>
                            <input type="number" min="1" max="" value="1" class="form-control input-quantity" id="input-quantity-product">
                            <c:forEach var="row" items="${Product.productColorList}">
                                <span class="input-group-text show-quantity" id="quantity-for-color-${row.color.colorID}" >Số lượng trong kho: ${row.quantity}</span>
                            </c:forEach>
                        </div>
                        <input type="hidden" id="product-id" name="product-id" value="${Product.productID}">
                        <button type="button" class="btn btn-success" id="btn-add-to-cart">Thêm vào giỏ hàng</button>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4">
                        <h4>Thông số kỹ thuật</h4>
                        <ul>
                            <c:forTokens var="token" items="${Product.specifications}" delims=";">
                                <li>${token}</li>
                                </c:forTokens>
                        </ul>
                    </div>
                    <div class="col-md-6">
                        <h3>Mô tả sản phẩm</h3>
                        <p>${Product.description}</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <h2>Đánh giá sản phẩm</h2>
                        <div>Đánh giá tổng thể: 
                            <c:choose>
                                <c:when test="${not empty AverageStart}">
                                    ${AverageStart}/5 <div class="fa-solid fa-star"></div>
                                </c:when>
                                <c:otherwise>
                                    Chưa có đánh giá
                                </c:otherwise>
                            </c:choose></div>
                        <br>
                        <h4>Thêm đánh giá mới</h4>
                        <form action="review" method="post">
                            <input type="hidden" name="product" value="${Product.productID}"/>
                            <div class="rating">
                                <label>Chọn sao: </label>
                                <label for="star1">1</label>
                                <input type="radio" name="rating" value="1" d="star1" style="margin-right: 20px">
                                <label for="star2">2</label>
                                <input type="radio" name="rating" value="2" id="star2" style="margin-right: 20px">
                                <label for="star3">3</label>
                                <input type="radio" name="rating" value="3" id="star3" style="margin-right: 20px">
                                <label for="star4">4</label>
                                <input type="radio" name="rating" value="4" id="star4" style="margin-right: 20px">
                                <label for="star5">5</label>
                                <input type="radio" name="rating" value="5" id="star5" checked style="margin-right: 20px"> 
                            </div>
                            <div class="input-group mb-3">
                                <div class="form-floating">
                                    <textarea name="substance" class="form-control" placeholder="Leave a comment here" id="floatingTextarea2" style="height: 100px"></textarea>
                                    <label for="floatingTextarea2">Viết đánh giá của bạn</label>
                                </div>
                                <button class="btn btn-primary" type="submit">Gửi</button>
                            </div>
                        </form>

                        <c:forEach var="row" items="${Product.reviewList}">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">${row.cutomerID.name}</h5>
                                    <c:forEach var="count" begin="1" end="${row.star}">
                                        <div class="fa-solid fa-star"></div>
                                    </c:forEach>
                                    <p class="card-text">${row.substance}</p>
                                    <div class="card-footer">
                                    <c:if test="${not empty row.sellerReplyList}">
                                        <c:set value="${row.sellerReplyList.get(0)}" var="item"/>
                                        <small class="text-muted">${item.userID.name}: ${item.reply}</small>
                                    </c:if>
                                    <c:if test="${empty row.sellerReplyList && not empty sessionScope.ADMIN}">
                                        <div class="form-floating">
                                            <textarea class="form-control" placeholder="Leave a comment here" id="seller-reply-${row.reviewID}" style="height: 100px"></textarea>
                                            <label for="floatingTextarea">Viết câu trả lời</label> 
                                        </div>
                                        <div class="text-end" style="margin-top: 10px">
                                            <button type="button" name="review" value="${row.reviewID}" class="btn btn-primary" id="btn-seller-reply">Trả lời</button>
                                        </div>
                                    </c:if> 
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <div class="toast-container position-fixed bottom-0 end-0 p-3">
                <div id="messageAddCartToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="toast-header">
                        <strong class="me-auto">Thông báo</strong>
                        <small>now</small>
                        <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                    <div class="toast-body" id="messageQuantity">Sản phẩm đã có trong giỏ hàng của bạn</div>
                </div>
            </div>
        </main>
        <jsp:include page="../index/footer.jsp"></jsp:include>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
        <script>
            const btnReplya = document.querySelectorAll('#btn-seller-reply');
            btnReplya.forEach(button => {
                button.addEventListener('click', function () {
                    var reviewId = button.value;
                    var reply = document.getElementById('seller-reply-'+reviewId).value;
                    fetch('reply-review?reply='+reply+'&review='+reviewId, {
                        method: 'POST'
                    })
                    .then(response => response.json())
                    .then(data => {
                        if(data.success){
                            location.reload();
                        }
                    })
                    .catch(error => {
                       console.error('Error:', error);
                    });
                });
            });
            
        </script>
        <script>
            function setClickButtonColor() {
                var buttonColors = document.querySelectorAll('button[name="color"]');
                buttonColors.forEach(function (button) {
                    button.addEventListener('click', function () {
                        var value = button.value;

                        const btnAddToCart = document.getElementById('btn-add-to-cart');
                        const pId = document.getElementById('product-id');
                        btnAddToCart.value = pId.value + '-' + value;

                        const selectedColor = parseInt(button.value);
                        buttonColors.forEach(buttonColor => {
                            const color = parseInt(buttonColor.value);
                            if (color === selectedColor) {
                                buttonColor.classList.add('active');
                                var span = document.getElementById("quantity-for-color-" + color);
                                span.style.display = "inline";
                            } else {
                                buttonColor.classList.remove('active');
                                var span = document.getElementById("quantity-for-color-" + color);
                                span.style.display = "none";
                            }
                        });
                    });
                });
            }
            setClickButtonColor();
        </script>
        <script>
            window.addEventListener("load", function () {
                var productImage = document.getElementById("btn-color-1");
                productImage.click();
            });

            function changeImage(color) {
                var productImage = document.getElementById("productImage");
                productImage.src = color;
            }

            const btnAddCart = document.getElementById('btn-add-to-cart');
            btnAddCart.addEventListener('click', function () {
                const value = btnAddCart.value;
                const tokens = value.split('-');
                const product = tokens[0];
                const color = tokens[1];
                const quantity = document.getElementById('input-quantity-product').value;
                fetch('../cart/add?product=' + product + '&color=' + color + '&quantity=' + quantity, {
                    method: 'POST',
                })
                        .then(response => response.json())
                        .then(data => {
                            if (data.Redirect) {
                                window.location.href = data.Redirect;
                            } else if (data.Success === true) {
                                const toastMessageAddCart = document.getElementById('messageAddCartToast');
                                const toast = bootstrap.Toast.getOrCreateInstance(toastMessageAddCart);
                                const messageQuantity = document.getElementById('messageQuantity');
                                if (data.MessageMaxQuantity) {
                                    messageQuantity.innerHTML = data.MessageMaxQuantity;
                                }
                                updateDataById('total-quantity', data.QuantityProductInCart);
                                toast.show();
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                        });
            });
            function updateDataById(id, value) {
                const td = document.getElementById(id);
                if (td) {
                    td.textContent = value;
                }
            }
        </script>
    </body>

</html>

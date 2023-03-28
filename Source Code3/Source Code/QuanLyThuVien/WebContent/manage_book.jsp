<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<!-- Main content -->
<!-- Content Wrapper. Contains page content -->
<style>
    .book-label{
        width:80px;
        display:inline-block;
    }
    .modal li input {
        width: 70%;
    }
    .modal li {
        margin-bottom: 20px;
    }
    .modal li input[type="file"] {
        width: 50%;
        margin-left: 20px;
    }
    table td input[type="checkbox"] {
        cursor: pointer;
    }
    tr:nth-child(even) {background: #CCC}
    tr:nth-child(odd) {background: #FFF}
</style>
<!--tuetc-->

<div class="content-wrapper">
    <!-- Main content -->
    <section class="content">
        <!--tuetc-->
        <form action="${pageContext.request.contextPath}/DeleteBook" method="POST">
            <div class="container-fluid">
                <div class="row">

                    <div class="col-md-12">
                        <div class="card">
                            <form role="form" method="post"
                                  action="${pageContext.request.contextPath}/SearchBook">
                                <div class="card-header">
                                    <h3 class="card-title">Danh sách sách trong thư viện</h3>

                                    <div class="card-tools" style="margin-right: 1px;">
                                        <div class="input-group input-group-sm" style="width: 200px;">
                                            <input type="text" name="data_search"
                                                   class="form-control float-right"
                                                   placeholder="Tìm kiếm theo tên">

                                            <div class="input-group-append">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="fas fa-search"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </form>
                            <div class="row justify-content-center">
                                <div style="margin-top: 20px; color: red;">${errorString}</div>
                            </div>
                            <!-- /.card-header -->
                            <div class="card-body" >
                                <div class="card-header" style="margin-left: -20px; margin-top: -40px;">
                                    <input type="button" value="Thêm sách"
                                           class="btn btn-primary"
                                           onclick="location.href='${pageContext.request.contextPath}/AddBook'">
                                </div>
                                <table class="table table-bordered table-hover" id="example2">
                                    <thead>
                                        <tr>
                                            <!--tuetc-->
                                            <th><input type="checkbox" id="check-all"><label for="check-all">Chọn tất cả</label></th>
                                            <th style="width: 10px">STT</th>
                                            <th style="width: 318px;">Tên</th>
                                            <th>Thể loại</th>
                                            <th>Số lượng</th>
                                            <th>Ngày nhập</th>
                                            <!--tuetc-->
                                            <th>Đánh giá</th>
                                            <th>Hình ảnh</th>
                                            <th>Chỉnh sửa</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${bookList}" var="book" varStatus="loop">
                                            <tr data-id='${book.getId()}' data-categotyid="${book.getCategory().getId()}">
                                                <!--tuetc-->
                                                <td>
                                                    <input type="checkbox" name="id" value="${book.getId()}">
                                                </td>
                                                <td>${loop.index+1}</td>
                                                <td class='book_name'>${book.getName()}</td>
                                                <td class='book_category'>${book.getCategory().getName()}</td>
                                                <td class='book_amount' style="text-align: center;">${book.getAmount()}</td>
                                                <td class='book_day'>${book.getDay()}</td>
                                                <!--tuetc-->
                                                <td class='book_gia'>${book.getDanhGiaVeSach()}</td>
                                                <td style="text-align: center;">
                                                    <a class="p_c_i_img" style="margin-top: 20px;" href="Resources/img/products/${book.getImage()}" rel="prettyPhoto">
                                                        <img style="margin: 0 auto;width: 50px;height: 50px;" src="Resources/img/products/${book.getImage()}">                            
                                                    </a>
                                                    <input data-toggle="modal" data-target="#bookDetail" type="button" value="Xem chi tiết" style="margin-top: 20px;">
                                                <td><a  data-toggle="modal" data-target="#bookEdit" class="btn btn-sm btn-info">Chỉnh sửa</a></td>
                                            </tr>

                                        <div class="modal fade"
                                             id="staticBackdrop-${Integer.toString(book.getId())}"
                                             data-backdrop="static" data-keyboard="false" tabindex="-1"
                                             aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="staticBackdropLabel1">Chú
                                                            ý</h5>
                                                        <button type="button" class="close" data-dismiss="modal"
                                                                aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <span class="text-danger"> Bạn có muốn chắc xóa
                                                            cuốn sách '${book.getName()}'</span>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button"
                                                                class="btn btn-warning  btn-secondary"
                                                                data-dismiss="modal">Hủy</button>
                                                        <!--tuetc-->
                                                        <!--														<form
                                                                                                                                                                                action="${pageContext.request.contextPath}/DeleteBook?id=${book.getId()}"
                                                                                                                                                                                method="POST">
                                                                                                                                                                                <button type="submit" class="btn btn-danger">Xóa</button>
                                                                                                                                                                        </form>-->
                                                        <button type="submit" class="btn btn-danger">Xóa</button>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </c:forEach>
                                    </tbody>
                                </table>

                                <div class="card-header">
                                    <div class="card-tools">
                                        <input id="delete-all" disabled type="button" value="Xóa" class="btn btn-danger"
                                               data-toggle="modal" data-target="#staticBackdrop-DeleteAll">
                                    </div>
                                    <div class="modal fade" id="staticBackdrop-DeleteAll"
                                         data-backdrop="static" data-keyboard="false" tabindex="-1"
                                         aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="staticBackdropLabel1">Chú ý</h5>
                                                    <button type="button" class="close" data-dismiss="modal"
                                                            aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <span class="text-danger"> Bạn có muốn chắc xóa tất
                                                        cả sách</span>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-warning  btn-secondary"
                                                            data-dismiss="modal">Hủy</button>

                                                    <button type="submit" class="btn btn-danger"
                                                            onclick="location.href='${pageContext.request.contextPath}/DeleteBook'">Xóa</button>


                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>

                        </div>
                        <!-- /.card -->
                    </div>
                </div>
                <!-- /.container-fluid -->
                <!--tuetc-->
        </form>
    </section>
                                                            
    <div class="modal" id="bookDetail">
        <div class="modal-dialog">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">Chi tiết sách</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Đóng</button>
                </div>

            </div>
        </div>
    </div>
     <div class="modal" id="bookEdit">
        <form>
            <div class="modal-dialog">
                <div class="modal-content">

                    <!-- Modal Header -->
                    <div class="modal-header">
                        <h4 class="modal-title">Chỉnh sửa sách</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">

                    </div>

                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <div class="spinner-border" style="display: none;"></div>
                        <button type="button" class="btn btn-primary" id="edit-book">Lưu</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Đóng</button>
                    </div>

                </div>
            </div>
        </form>
    </div>                                                       
                                                            
    <div class="modal" id="bookEdit">
        <div class="modal-dialog">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">Chi tiết sách</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Đóng</button>
                </div>

            </div>
        </div>
    </div>
    <select style="display: none;" id="category-list">                                                        
        <c:forEach items="${categoryList}" var="category" varStatus="loop">
            <option value="${category.getId()}">${category.getName()}</option>
        </c:forEach>
    </select>
<%@ include file="footer.jsp"%>
<!-- DataTables -->
<script src="Resources/plugins/datatables/jquery.dataTables.min.js"></script>
<script
        src="Resources/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
<script
        src="Resources/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
<script
        src="Resources/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>

<!--tuetc-->
<!--<script type="text/javascript" src="Resources/js/jquery-1.9.1.min.js"></script>-->
<link href="Resources/css/thumnail/prettyPhoto.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="Resources/js/thumnail/jquery.prettyPhoto.js"></script>
<script type="text/javascript" src="Resources/js/thumnail/initPrettyPhoto.js"></script> 
<!-- page script -->
<script>
    var books = {};
    <c:forEach items="${bookList}" var="book" varStatus="loop">
        books[${book.getId()}] = {
                                    'Tên sách:': '${book.getName()}', 
                                    'Thể loại:': '${book.getCategory().getName()}', 
                                    'Số lượng:': '${book.getAmount()}', 
                                    'Ngày nhập:': '${book.getDay()}', 
                                    'Đánh giá:': '${book.getDanhGiaVeSach()}',
                                    'Hình ảnh:': '<img style="margin: 0 auto;width: 50px;height: 50px;" src="Resources/img/products/${book.getImage()}">'
                                };
    </c:forEach>
        $(function() {
                $("#example1").DataTable({
                        "responsive" : true,
                        "autoWidth" : false,
                });
                $('#example2').DataTable({
                        "paging" : true,
                        "lengthChange" : false,
                        "searching" : false,
                        "ordering" : true,
                        "info" : true,
                        "autoWidth" : false,
                        "responsive" : true,
                });
        });

//                tuetc
        $(document).on("change","table input[type='checkbox']",function() {
            if($(this).attr('id') === 'check-all') {
                if($(this).is(':checked')) {
                    $("input[name='id']").prop('checked', true);
                } else {
                    $("input[name='id']").prop('checked', false);
                }
            } else {
                if($("input[name='id']").length == $("input[name='id']:checked").length) {
                    $("#check-all").prop('checked', true);
                } else {
                    $("#check-all").prop('checked', false);
                }
            }

            if($("input[name='id']:checked").length > 0) {
                $("#delete-all").prop('disabled', false);
            } else {
                $("#delete-all").prop('disabled', true);
            }
        });
        
        $('#bookDetail').on('show.bs.modal', function (e) {
                var button = e.relatedTarget;
                var bookId = $(button).parents('tr').data('id');
                var object= books[bookId];
                var bookContent = '<ul>';
                for(var key in object ){
                    bookContent += '<li><span class="book-label">' + key + '</span> '+ object[key] + '</li>';
                }
                bookContent += '</ul>';
                $("#bookDetail .modal-body").html(bookContent);
                    
        });
        //tuetc
        $('#bookEdit').on('show.bs.modal', function (e) {
                var button = e.relatedTarget;
                var bookId = $(button).parents('tr').data('id');
                var categotyId = $(button).parents('tr').data('categotyid');
                var object= books[bookId];
                var bookContent = '<ul>';
                var disabled;
                for(var key in object ){
                    var disabled = '';
                    if(key === 'Ngày nhập:' || key === 'Đánh giá:') {
                        disabled = ' disabled';
                    } else {
                        disabled = '';
                    }
                    if(key === 'Số lượng:'){
                        var name = 'count';
                    } else if(key === 'Tên sách:'){
                        var name = 'name';
                    } else {
                        var name = '';
                    }
                    if(key === 'Thể loại:'){
                        bookContent += '<li><span class="book-label">' + key + '</span><select name="category">' + $("#category-list").html() + '</select></li>';
                    } else if(key === 'Hình ảnh:'){
                        bookContent += '<li><span class="book-label">' + key + '</span>'+ object[key] + '<input name="fileImage" type="file" id="fileImage"></li>';
                    } else {
                        bookContent += '<li><span class="book-label">' + key + '</span><input' + disabled + ' name="' + name + '" type="text" value="'+ object[key] + '"></li>';
                    }
                }
                bookContent += '</ul>';
                bookContent += '<input type="hidden" name="id" value="' + bookId + '">';
                $("#bookEdit .modal-body").html(bookContent);
                
                $('#bookEdit select').val(categotyId);
        });
        
        //tuetc
        $(document).on("click","#edit-book",function(e) {
            $("#bookEdit").find('.spinner-border').show();
            
            var url = "${pageContext.request.contextPath}/EditBook";
            var formData = new FormData();
            
            var dataArray = $("#bookEdit form").serializeArray();
            $(dataArray).each(function(i, field){
                if(field.name != 'fileImage') {
                    formData.append(field.name, field.value);
                }
            });
            formData.append('fileImage', $('#fileImage')[0].files[0]);

            $.ajax({
                url: url, 
                type: "POST",
                data: formData,
                contentType: false,
                processData: false,
                success: function(result){
                    $("#bookEdit").find('.spinner-border').hide();
                    window.location.reload();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                }
            });
        });

</script>

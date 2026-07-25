/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

    let viTri = 0; // Vị trí ảnh đang hiển thị (0 là ảnh đầu tiên)
    let cacAnh = document.getElementsByClassName("banner");
    let cacCham = document.getElementsByClassName("dot");
    
    function doiAnh(huongDi) {
        let cacAnh = document.getElementsByClassName("banner");
        
        // 1. Ẩn ảnh hiện tại VÀ xóa màu của chấm tròn hiện tại đi
        cacAnh[viTri].style.display = "none";
        cacCham[viTri].classList.remove("active-dot");
        
        // Tính toán vị trí ảnh tiếp theo (Code gốc của bác)
        viTri = viTri + huongDi;
        
        // Nếu vượt quá ảnh cuối thì quay về ảnh đầu
        if (viTri >= cacAnh.length) { viTri = 0; }
        // Nếu lùi quá ảnh đầu thì nhảy đến ảnh cuối
        if (viTri < 0) { viTri = cacAnh.length - 1; }
        
        // 2. Hiển thị ảnh mới VÀ tô màu cho chấm tròn mới lên
        cacAnh[viTri].style.display = "block";
        cacCham[viTri].classList.add("active-dot");
    }

    // Tự động chuyển ảnh sau mỗi 3 giây (Code gốc của bác)
    setInterval(function() {
        doiAnh(1);
    }, 3000);
///////////////nút xem thêm//////////////
    document.addEventListener("DOMContentLoaded", function() {
        const productList = document.getElementById("productList");
        const btnViewMore = document.getElementById("btnViewMore");
        const viewMoreBox = document.getElementById("viewMoreBox");
        
        if (productList && btnViewMore) {
            const items = productList.querySelectorAll(".product-item");
            
            // Ẩn luôn nút XEM THÊM nếu có từ 4 sản phẩm trở xuống
            if (items.length <= 4) {
                viewMoreBox.style.display = "none";
            }

            // Khi click vào nút
            btnViewMore.addEventListener("click", function() {
                productList.classList.toggle("show-all");
                
                if (productList.classList.contains("show-all")) {
                    btnViewMore.innerHTML = 'THU GỌN';
                } else {
                    btnViewMore.innerHTML = 'XEM THÊM';
                    // Cuộn mượt mà về lại đầu danh sách
                    productList.scrollIntoView({ behavior: 'smooth', block: 'start' });
                }
            });
        }
    });




    function addToCart(id) {
        window.location.href = "cart?action=add&id=" + id;
    }

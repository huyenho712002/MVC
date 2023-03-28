package Model.Bean;

import java.util.Date;

public class Book {
	private String id;
	private String name;
	private String image;
	private String amount;
	private Category Category;
	private String day;
        /**
         * 
         * tuetc
         * định nghĩa thêm một thuộc tính cho Book
         * dùng thuộc tính này để hiển thị thêm cột [Đánh giá] trong page book list (trang danh sách book)
         * thuộc tính này được gán giá trị từ column book_full.danh_gia_ve_sach
         */
        private String danhGiaVeSach;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public Category getCategory() {
		return Category;
	}
	public void setCategory(Category category) {
		Category = category;
	}

        /**
         * 
         * tuetc
         */
        public String getDanhGiaVeSach() {
            return danhGiaVeSach;
        }

        /**
         * 
         * tuetc
         */
        public void setDanhGiaVeSach(String danhGiaVeSach) {
            this.danhGiaVeSach = danhGiaVeSach;
        }
        
        
	
}

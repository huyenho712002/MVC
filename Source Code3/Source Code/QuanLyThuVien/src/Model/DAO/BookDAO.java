package Model.DAO;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;

import Model.BO.CategoryBO;
import Model.BO.ReaderBO;
import Model.Bean.Book;
import Model.Bean.Category;
import java.util.List;

public class BookDAO {
	Connection conn = null;
	Statement st = null;
	PreparedStatement preSt = null;
	CategoryBO categoryBO = new CategoryBO();
	ReaderBO readerBO= new ReaderBO();

	public Book findBook(String id) throws SQLException, ClassNotFoundException {
		if (conn == null)
			conn = ConnectDatabase.getMySQLConnection();
		String sql = "Select * from Book where id=?";

		PreparedStatement pstm = (PreparedStatement) conn.prepareStatement(sql);
		pstm.setString(1, id);

		ResultSet rs = pstm.executeQuery();

		while (rs.next()) {
			String name = rs.getString("name");
			String category_id = rs.getString("category_id");
			Date date = rs.getDate("create_day");
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			String strDate = dateFormat.format(date);
			Category category = new Category();
			try {
				category = categoryBO.findCategory(category_id);
			} catch (ClassNotFoundException | SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			String amount = rs.getString("amount");
			String image = rs.getString("image");
			Book book = new Book();
			book.setId(id);
			book.setName(name);
			book.setCategory(category);
			book.setAmount(amount);
			book.setImage(image);
			book.setDay(strDate);
			return book;
		}
		return null;
	}

	public int insertBook(Book book) throws SQLException, ClassNotFoundException {
		if (conn == null)
			conn = ConnectDatabase.getMySQLConnection();
		try {
			st = (Statement) conn.createStatement();
		} catch (Exception e) {
			e.printStackTrace();
		}
		int result = 0;
		String insert = "INSERT INTO Book (name, category_id, amount, image) VALUES (?,?, ?, ?)";
		preSt = (PreparedStatement) conn.prepareStatement(insert);
		preSt.setString(1, book.getName());
		preSt.setString(2, Integer.toString(book.getCategory().getId()));
		preSt.setString(3, book.getAmount());
		preSt.setString(4, book.getImage());
		result = preSt.executeUpdate();
		System.out.println("Ketqua" + result);
		return result;
	}

	public ArrayList<Book> getAllBook() throws ClassNotFoundException, SQLException {
		if (conn == null)
			conn = ConnectDatabase.getMySQLConnection();
		ArrayList<Book> list = new ArrayList<Book>();
                /**
                 * tuetc
                 * câu query cũ: String sql = "Select * from Book ORDER BY create_day DESC";
                 * câu query mới: String sql = "Select * from book_full ORDER BY create_day DESC";
                 * 
                 * book_full là một view được tạo ra với dòng lệnh như sau:
                 * CREATE VIEW book_full AS 

                        SELECT book.*, category.name as category_name, 'Sách nổi tiếng nên nhập về số lượng nhiều' AS danh_gia_ve_sach  
                        FROM book JOIN category ON category.id = book.category_id 
                        WHERE book.amount >= 4 and is_deleted = 0

                        UNION 

                        SELECT book.*, category.name as category_name, 'Sách chưa nổi tiếng nên nhập về số lượng không nhiều' AS danh_gia_ve_sach  
                        FROM book JOIN category ON category.id = book.category_id 
                        WHERE book.amount < 4  and is_deleted = 0 
                    
                 *  với view này, đã lấy được thông tin của tên thể loại category.name, lấy được [danh_gia_ve_sach]
                 *  câu select đầu tiên lấy một tập dữ liệu với logic book.amount >= 4 (tập dữ liệu 1)
                 *  câu select đầu tiên lấy một tập dữ liệu với logic book.amount < 4 (tập dữ liệu 2)
                 *  gộp 2 tập dữ liệu này bằng lệnh [union]; 2 tập dữ liệu này cuối cùng cũng giống như một tập dữ liệu của toàn bộ các sách
                 *  nhưng vì mình định nghĩa thêm một column danh_gia_ve_sach nên mình phải dùng 2 tập dữ liệu, mỗi tập dữ liệu là chứa một logic của column danh_gia_ve_sach
                 * 
                 **/
//		String sql = "Select * from Book ORDER BY create_day DESC";
                String sql = "Select * from book_full ORDER BY create_day DESC";
		PreparedStatement pstm = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = pstm.executeQuery();

		while (rs.next()) {
			String id = rs.getString("id");
			String name = rs.getString("name");
			Date date = rs.getDate("create_day");
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			String strDate = dateFormat.format(date);
			Category category = new Category();
                        /**
                         * tuetc
                         * đây là code cũ
                         * code này rất là tầm bậy
                         * performance kém
                         * lý do code tầm bậy là vì lý do này:
                         * khi chạy vòng lặp để lấy thông tin từng quyển sách, 
                         * mỗi khi lấy một quyển sách thì lại connect đến mysql để get thông tin Category bằng dòng lệnh [category = categoryBO.findCategory(category_id);]
                         * bỏ code này và thay thế code khác nhé
                         */
			/*
                        try {
				category = categoryBO.findCategory(category_id);
			} catch (ClassNotFoundException | SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
                        */
                        category.setId(rs.getInt("category_id"));
                        category.setName(rs.getString("category_name"));
                        
			String amount = rs.getString("amount");
			String image = rs.getString("image");
			Book book = new Book();
			book.setId(id);
			book.setName(name);
			book.setCategory(category);
			book.setAmount(amount);
			book.setImage(image);
			book.setDay(strDate);
                        //tuetc
                        book.setDanhGiaVeSach(rs.getString("danh_gia_ve_sach"));
			list.add(book);
		}
		return list;
	}
	public ArrayList<Book> getSearchBook(String name_search) throws ClassNotFoundException, SQLException {
		if (conn == null)
			conn = ConnectDatabase.getMySQLConnection();
		System.out.println("Day"+name_search);
		ArrayList<Book> list = new ArrayList<Book>();
		String sql = "Select * from Book where name like '%"+name_search+"%';";
//		String sql = "Select * from Book where name like '%l';";
		PreparedStatement pstm = (PreparedStatement) conn.prepareStatement(sql);
		ResultSet rs = pstm.executeQuery();

		while (rs.next()) {
			String id = rs.getString("id");
			String name = rs.getString("name");
			String category_id = rs.getString("category_id");
			Date date = rs.getDate("create_day");
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			String strDate = dateFormat.format(date);
			Category category = new Category();
			try {
				category = categoryBO.findCategory(category_id);
			} catch (ClassNotFoundException | SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			String amount = rs.getString("amount");
			String image = rs.getString("image");
			Book book = new Book();
			book.setId(id);
			book.setName(name);
			book.setCategory(category);
			book.setAmount(amount);
			book.setImage(image);
			book.setDay(strDate);
			list.add(book);
		}
		System.out.println(list);
		return list;
	}

	public int updateBook(Book book) throws SQLException, ClassNotFoundException {
		
		int result = 0;
		if (conn == null)
			conn = ConnectDatabase.getMySQLConnection();
                String image = "";
                if (book.getImage() != null && !book.getImage().equals("")) {
                    image = ",image =?";
                }
		String sql = "Update Book set name =?,category_id =?,amount =?" + image +" where id = " + book.getId();
		PreparedStatement pstm = (PreparedStatement) conn.prepareStatement(sql);
		
		pstm.setString(1, book.getName());
		pstm.setString(2, Integer.toString(book.getCategory().getId()));
		pstm.setString(3, book.getAmount());
                if(book.getImage() != null && !book.getImage().equals("")){
                    pstm.setString(4, book.getImage());
                } 
		result = pstm.executeUpdate();
		return result;
	}
	public int deleteAllBook() throws ClassNotFoundException, SQLException {
		int result = 0;
		if (conn == null)
			conn = ConnectDatabase.getMySQLConnection();
		readerBO.deleteAllReader();
		String sql = "update book set is_deleted = 1";
		PreparedStatement pstm = (PreparedStatement) conn.prepareStatement(sql);
		result = pstm.executeUpdate();
		return result;
	}
	public int deleteBook(String id) throws ClassNotFoundException, SQLException {
		int result = 0;
		if (conn == null)
			conn = ConnectDatabase.getMySQLConnection();

		readerBO.deleteBookReader(id);
		String sql = "update book set is_deleted = 1 where id= ?";
		PreparedStatement pstm = (PreparedStatement) conn.prepareStatement(sql);
		pstm.setString(1, id);
		result = pstm.executeUpdate();
		return result;
	}
        /**
         * tuetc
         * @param ids
         * @return
         * @throws ClassNotFoundException
         * @throws SQLException 
         */
        public int deleteBooks(String[] ids) throws ClassNotFoundException, SQLException {
		int result = 0;
		if (conn == null)
			conn = ConnectDatabase.getMySQLConnection();

		readerBO.deleteBookReaders(ids);
		String sql = "update book set is_deleted = 1 where id IN (" + String.join(",", ids) + ")";
		PreparedStatement pstm = (PreparedStatement) conn.prepareStatement(sql);
		result = pstm.executeUpdate();
		return result;
	}
	public int deleteBookCategory(String category_id) throws ClassNotFoundException, SQLException {
		int result = 0;
		if (conn == null)
			conn = ConnectDatabase.getMySQLConnection();
		readerBO.deleteBookReaderCategory(category_id);
//		String sql = "DELETE  Reader, Book FROM Reader INNER JOIN Book ON Reader.book_id = Book.id WHERE Book.category_id=?;";
		String sql = "Delete From Book where category_id= ?";
		PreparedStatement pstm = (PreparedStatement) conn.prepareStatement(sql);
		pstm.setString(1, category_id);
		result = pstm.executeUpdate();
		return result;
	}
}

package Model.Controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.BO.BookBO;
import Model.BO.CategoryBO;
import Model.Bean.Book;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Servlet implementation class DeleteCategory
 */
@WebServlet("/DeleteBook")
public class DeleteBook extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BookBO bookBO = new BookBO();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeleteBook() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
//                tuetc
//                không dùng code phía dưới nữa nhé
		/*String id = (String) request.getParameter("id");

		if (id == null) {
			boolean result;
			try {
				result = bookBO.deleteAllBook();
			} catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			boolean result;
			try {
				result = bookBO.deleteBook(id);
			} catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		request.setAttribute("errorString", "Đã xóa thành công");
		RequestDispatcher dispatcher = request.getRequestDispatcher("/ManageBook");
		dispatcher.forward(request, response);*/
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//            tuetc
            String deleteResult = "Đã xóa thành công";
            // TODO Auto-generated method stub
            String[] ids = request.getParameterValues("id");
            
            boolean result;
            try {
                    result = bookBO.deleteBooks(ids);
                    if(!result) {
                        deleteResult = "Xoá không thành công";
                    }
            } catch (ClassNotFoundException | SQLException e) {
                    // TODO Auto-generated catch block
                    deleteResult = "Xoá không thành công";
            }
            
            request.setAttribute("errorString", deleteResult);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/ManageBook");
            dispatcher.forward(request, response);
	}

}

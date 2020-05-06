package com.company.servlet;

import com.company.servlet.entity.UserSession;
import org.hibernate.HibernateException;
import org.hibernate.Session;

import com.company.servlet.entity.User;
import org.hibernate.Transaction;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class MainServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
          throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        String act = req.getParameter("rm");
        if (act != null) {
            int Id = Integer.parseInt(act);
            delete(Id);
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        Session session = SessionFactory.getInstance().openSession();

        List q = session.createQuery("from User").list();
        List<User> users = new ArrayList<User>();

        if(q.size() > 0) {
            for(Object user: q) {
                User us = (User) user;
                users.add(us);
            }
        }
        session.close();
        req.setAttribute("users", users);
        req.getRequestDispatcher("/jsp-files/index.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        User user = new User();
        user.setId(Integer.parseInt(req.getParameter("id")));
        user.setLastName(req.getParameter("lastName"));
        user.setName(req.getParameter("name"));
        user.setPatronymic(req.getParameter("patronymic"));
        user.setPlace(req.getParameter("place"));
        user.setLang(req.getParameter("lang"));

        query(user, user.getId() > 0 ? "update" : "save");
        resp.sendRedirect(req.getContextPath() + "/");
    }

    private static void query(Object el, String act) {
      try {
          Session ss = SessionFactory.getInstance().openSession();
          try {
              Transaction tr = ss.beginTransaction();
              if (act.equals("save"))
                  ss.save(el);
              else if (act.equals("update"))
                  ss.saveOrUpdate(el);
              else if (act.equals("delete"))
                  ss.delete(el);
              ss.flush(); //после записи выталкиваем данные в поток, чтобы данные не потерялись при ошибках
              tr.commit();
          } catch (HibernateException exp) {
          } finally {
              ss.close();
          }
      } catch (ExceptionInInitializerError exc) {}
  }

  public static void delete(int id) {
      try {
          Session ss = SessionFactory.getInstance().openSession();
          Transaction tr = ss.beginTransaction();
          User user = ss.byId(User.class).load(id);
          ss.delete(user);
          ss.flush();
          tr.commit();
          ss.close();
      }
      catch (ExceptionInInitializerError exc){}
  }
}


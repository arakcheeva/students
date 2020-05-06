package com.company.servlet;

import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import com.company.servlet.entity.User;
import com.company.servlet.entity.UserSession;

public class SessionFactory {
    private static org.hibernate.SessionFactory sf;

    static {

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (Exception x){
            System.err.println("Sorry, no MSSQL!");
        }

        Configuration cfg = new Configuration()
                .addAnnotatedClass(User.class);
             //   .addAnnotatedClass(UserSession.class);

        cfg.setProperty("hibernate.connection.url", "jdbc:sqlserver://localhost\\ARA;database=Useri;CharacterSet=UTF-8");
        cfg.setProperty("hibernate.connection.username", "sa");
        cfg.setProperty("hibernate.connection.password", "2020");
        cfg.setProperty("hibernate.hbm2ddl.auto", "update");

        StandardServiceRegistryBuilder builder = new StandardServiceRegistryBuilder();
        builder.applySettings(cfg.getProperties());
        sf = cfg.buildSessionFactory(builder.build());
    }

    private SessionFactory(){}

    public static org.hibernate.SessionFactory getInstance(){
        return sf;
    }
}
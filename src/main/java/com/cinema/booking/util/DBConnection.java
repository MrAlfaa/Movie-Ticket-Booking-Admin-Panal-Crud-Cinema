package com.cinema.booking.util;

import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;

public class DBConnection {
    private static final String JNDI_LOOKUP = "jdbc/cinemadb";
    
    public static Connection getConnection() throws Exception {
        InitialContext ctx = new InitialContext();
        DataSource ds = (DataSource) ctx.lookup(JNDI_LOOKUP);
        return ds.getConnection();
    }
    
    public static void closeConnection(Connection conn) {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (Exception e) {
            throw new RuntimeException("Error closing connection", e);
        }
    }
}

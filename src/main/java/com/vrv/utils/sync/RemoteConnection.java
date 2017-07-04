package com.vrv.utils.sync;

import java.io.InputStream;
import java.sql.SQLException;
import java.util.Properties;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.pool.DruidDataSourceFactory;
import com.alibaba.druid.pool.DruidPooledConnection;

public class RemoteConnection {
    private static RemoteConnection databasePool = null;

    private static DruidDataSource dds = null;
    static {
        InputStream in = RemoteConnection.class.getClassLoader().getResourceAsStream(
                "config/jdbc_remote.properties");
        Properties properties = new Properties();
        try {
            properties.load(in);
            in.close();
            dds = (DruidDataSource) DruidDataSourceFactory.createDataSource(properties);
            System.out.println(RemoteConnection.getInstance() + "===");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private RemoteConnection() {
    }

    public static synchronized RemoteConnection getInstance() {
        if (null == databasePool) {
            databasePool = new RemoteConnection();
        }
        return databasePool;
    }

    public DruidPooledConnection getConnection() throws SQLException {
        return dds.getConnection();
    }

}
package org.zerock.persistence;

import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.config.RootConfig;

import java.sql.Connection;
import java.sql.DriverManager;

import static org.junit.Assert.fail;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class})
@Log4j
public class JDBCTests {
    static {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void testConnection() {
        try(Connection con =
            DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:XE",
                    "book_ex",
                    "book_ex"
            )
        ) {
            log.info(con);
        } catch (Exception e) {
            fail(e.getMessage());
        }
    }
}

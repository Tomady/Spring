package org.zerock.sample;

import static org.junit.Assert.assertNotNull;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.apache.log4j.BasicConfigurator;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.config.RootConfig;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class})
@Log4j
public class SampleTests {
    @Setter(onMethod_ = {@Autowired})
    private Restaurant restaurant;

    @BeforeClass
    public static void setUp() {
        BasicConfigurator.configure();
    }

    @Test
    public void testExist() {
        assertNotNull(restaurant);

        log.info(restaurant);
        log.info("-------------------------");
        log.info(restaurant.getChef());
    }
}

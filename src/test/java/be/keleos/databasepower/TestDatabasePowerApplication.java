package be.keleos.databasepower;

import org.springframework.boot.SpringApplication;

public class TestDatabasePowerApplication {

    public static void main(String[] args) {
        SpringApplication.from(DatabasePowerApplication::main).with(TestcontainersConfiguration.class).run(args);
    }

}

package com.example.sender;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;

import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.random.RandomGenerator;

@SpringBootApplication
public class SenderApplication {

    @Autowired
    JdbcTemplate template;

    public static void main(String[] args) {
        SpringApplication.run(SenderApplication.class, args);
    }

    @Bean
    public CommandLineRunner commandLineRunner(ApplicationContext ctx) {
        return args -> {

            ExecutorService ex = Executors.newFixedThreadPool(100);

            for (int x = 0; x < 30; x++) {
                ex.submit(() -> {

                    for (int z = 0; z < 30; z++) {

                        Random rand = new Random();
                        String correlation = UUID.randomUUID().toString().substring(0, 10);
                        Map<String, Object> parameters = null;

                        int c = RandomGenerator.getDefault().nextInt(1, 5);
                        List<Integer> a_ids = new ArrayList<>();
                        for (int i = 0; i < c; i++) {
                            parameters = new HashMap<>();
                            parameters.put("correlation", correlation);
                            SimpleJdbcInsert insert = new SimpleJdbcInsert(template).withTableName("table_a").usingGeneratedKeyColumns("id");
                            Integer a_id = insert.executeAndReturnKey(parameters).intValue();
                            a_ids.add(a_id);
                        }

                        c = RandomGenerator.getDefault().nextInt(1, 5);
                        List<Integer> b_ids = new ArrayList<>();
                        for (int i = 0; i < c; i++) {
                            parameters = new HashMap<>();
                            parameters.put("correlation", correlation);
                            parameters.put("a_id", a_ids.get(rand.nextInt(a_ids.size())));
                            SimpleJdbcInsert insert = new SimpleJdbcInsert(template).withTableName("table_b").usingGeneratedKeyColumns("id");
                            Integer b_id = insert.executeAndReturnKey(parameters).intValue();
                            b_ids.add(b_id);
                        }

                        c = RandomGenerator.getDefault().nextInt(1, 5);
                        List<Integer> c_ids = new ArrayList<>();
                        for (int i = 0; i < c; i++) {
                            parameters = new HashMap<>();
                            parameters.put("correlation", correlation);
                            parameters.put("a_id", a_ids.get(rand.nextInt(a_ids.size())));
                            parameters.put("b_id", b_ids.get(rand.nextInt(b_ids.size())));
                            SimpleJdbcInsert insert = new SimpleJdbcInsert(template).withTableName("table_c").usingGeneratedKeyColumns("id");
                            Integer c_id = insert.executeAndReturnKey(parameters).intValue();
                            c_ids.add(c_id);
                        }

                        System.out.println(a_ids);
                        System.out.println(b_ids);
                        System.out.println(c_ids);

                    }

                    // Deletion


                });


            }
        };
    }


}

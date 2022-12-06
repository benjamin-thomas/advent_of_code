package org.example;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

/*
 * ./gradlew run
 *
 * ./gradlew build
 * java -jar build/libs/aoc-1.0-SNAPSHOT.jar
 */
public class Main {
    public static void main(String[] args) {
        String input = readDay("day01");
        Day01 day01 = new Day01(input);
        System.out.println("Day 01 answer1: " + day01.answer1());
        System.out.println("Day 01 answer2: " + day01.answer2());
    }

    private static String readDay(String day) {
        var path = Path.of("..", "inputs", day);
        String input;
        try {
            input = Files.readString(path);
        } catch (IOException e) {
            throw new RuntimeException(String.format("Could not open day: %s", day));
        }
        return input;
    }
}

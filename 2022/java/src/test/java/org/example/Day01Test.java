package org.example;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

/*
 * rg --files src/ test/ | entr -c ./gradlew test 2>/dev/null
 */
public class Day01Test {
    @Test
    void testGreet() {
        assertEquals("Hello from day1!", Day01.greet());
    }
}

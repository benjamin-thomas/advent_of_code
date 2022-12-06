package org.example;

import org.junit.jupiter.api.Test;

import static java.util.List.of;
import static org.junit.jupiter.api.Assertions.assertEquals;

/*
 * rg --files src/ test/ | entr -c ./gradlew test 2>/dev/null
 */
public class Day01Test {

    @Test
    void fromInput() {
        assertEquals(of(5, 4, 1), new Day01("1\n\n2\n3\n\n4").getData());
    }

    @Test
    void answers() {
        assertEquals(8, new Day01("1\n\n2\n3\n\n4\n\n8").answer1());

        // 8 + 4 + 5
        assertEquals(17, new Day01("1\n\n2\n3\n\n4\n\n8").answer2());
    }
}

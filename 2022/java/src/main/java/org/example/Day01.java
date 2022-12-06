package org.example;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class Day01 {
    private final List<Integer> data;

    public Day01(String input) {
        this.data = fromInput(input);
    }

    private List<Integer> fromInput(String input) {
        return Arrays.stream(input.split("\n\n"))
                .map(s ->
                        Arrays.stream(s.split("\n"))
                                .map(Integer::parseInt)
                                .mapToInt(Integer::intValue)
                                .sum()
                )
                .sorted((o1, o2) -> o2 - o1)
                .collect(Collectors.toList());
    }

    public int answer1() {
        return this.data.stream().findFirst().orElseThrow();
    }

    public Integer answer2() {
        return this.data.stream().limit(3).reduce(Integer::sum).orElseThrow();
    }

    public List<Integer> getData() {
        return data;
    }
}

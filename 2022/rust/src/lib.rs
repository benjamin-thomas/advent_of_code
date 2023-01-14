use std::num::ParseIntError;

pub fn from_input(input: &str) -> Vec<u32> {
    return input
        .split("\n\n")
        .map(|x| x.lines().map(|x| x.parse::<u32>().unwrap()).sum())
        .collect();
}

pub fn most_calories(calories: Vec<u32>) -> u32 {
    let mut cal = calories.clone();
    cal.sort();
    return cal.last().unwrap().clone();
}

pub fn top3_calories(calories: Vec<u32>) -> u32 {
    let mut res = calories.clone();
    res.sort_by(|a, b| b.cmp(a));
    res = res[0..3].into();
    res.iter().sum()
}

#[allow(dead_code)]
fn parse_data(s: Vec<&str>) -> Result<Vec<isize>, ParseIntError> {
    s.iter().map(|item| item.parse()).collect()
}

#[allow(dead_code)]
fn compute(lst: Vec<Result<isize, &str>>) -> Result<Vec<isize>, &str> {
    lst.iter().map(|item| item.to_owned()).collect()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_compute() {
        assert_eq!(Ok(vec![1, 2, 3]), compute(vec![Ok(1), Ok(2), Ok(3)]));
        assert_eq!(Err("oops"), compute(vec![Ok(1), Err("oops"), Ok(3)]));
    }

    #[test]
    fn test_parse_data() {
        assert_eq!(Ok(vec![1, 2, 3]), parse_data(vec!["1", "2", "3"]));
        assert!(parse_data(vec!["1", "2a", "3"]).is_err())
    }

    #[test]
    fn test_from_input() {
        assert_eq!(from_input("1"), vec![1]);
        assert_eq!(from_input("1\n\n2"), vec![1, 2]);
        assert_eq!(from_input("1\n\n2\n3"), vec![1, 5]);
    }

    #[test]
    fn test_most_calories() {
        assert_eq!(most_calories(vec![1, 5]), 5);
        assert_eq!(most_calories(vec![1, 5, 8, 3]), 8);
    }

    #[test]
    fn test_top3_calories() {
        assert_eq!(top3_calories(vec![1, 3, 2, 6, 4, 5]), 15); // 4+5+6
    }
}

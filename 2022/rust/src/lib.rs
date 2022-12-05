pub fn greet() -> String {
    String::from("hello from lib!")
}

/// Adds in a smart way!
///
/// Examples:
/// ```
/// assert_eq!(aoc::add(1, 1), 2);
/// assert_eq!(aoc::add(1, 2), 3);
/// ```
pub fn add(a: usize, b: usize) -> usize {
    a + b
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let result = add(2, 2);
        assert_eq!(result, 4);
        assert_eq!("hello from lib!", greet());
    }
}

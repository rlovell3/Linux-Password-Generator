// A simple Rust framework to call the password script.

use std::process::Command;
use std::str;

fn main() {
    // Call the script with the -auto flag
    let output = Command::new("./password_gen.sh")
        .arg("-a")
        .arg("-l50")
        .arg("-sC")
        .output()
        .expect("Failed to execute command");

    // Get the output
    let password = str::from_utf8(&output.stdout).unwrap().trim();

    println!("The generated password is: {}", password);
}

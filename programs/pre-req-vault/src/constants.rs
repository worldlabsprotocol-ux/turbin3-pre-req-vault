use anchor_lang::prelude::*;

#[constant]
pub const COUNTER_SEED: &[u8] = b"counter";

#[constant]
pub const HELLO_WORLD_LAMPORTS: u64 = 1;

#[constant]
pub const MAX_COUNT: u64 = 10;

/// Set to your GitHub username before deploying (used by registration CPI on withdraw).
pub const GITHUB_USERNAME: &str = "worldlabsprotocol-ux";

# Readwise Highlight Cleaner

A Ruby script to bulk delete all highlights from your Readwise account.

Use with caution as this will permanently delete all your highlights!

## Prerequisites

- Ruby (2.6.0 or higher)
- Bundler gem
- Readwise API token (get it from [readwise.io/access_token](https://readwise.io/access_token))

## Installation

1. Clone this repository:

```bash
git clone <repository-url>
cd readwise-highlight-cleaner
```

2. Install dependencies:

```bash
bundle install
```

3. Set up your Readwise API token:
   - Copy the `.env.example` file to `.env`:

     ```bash
     cp .env.example .env
     ```

   - Edit `.env` and replace `your_token_here` with your actual Readwise API token

## Usage

To run the script:

```bash
./bin/delete_highlights
```

The script will:

1. Ask for confirmation before proceeding
2. Fetch all highlights from your Readwise account
3. Display the total number of highlights found
4. Delete them one by one with progress updates
5. Add a small delay between deletions to avoid rate limiting

Example output:

```
Warning: This script will delete ALL your Readwise highlights!
Are you sure you want to continue? (y/N)
y
Found 150 highlights to delete
Deleting highlight 1/150
Successfully deleted highlight 12345
Deleting highlight 2/150
Successfully deleted highlight 12346
...
Finished deleting all highlights
```

## Development

The main components of this project are:

- `lib/readwise_cleaner.rb`: Contains the main `ReadwiseCleaner` class
- `bin/delete_highlights`: Executable script that uses the cleaner class
- `.env`: Configuration file for your API token

## Disclaimer

⚠️ **WARNING**: This script will permanently delete ALL your Readwise highlights. Make sure to back up any important data before running the script. There is no way to recover deleted highlights!

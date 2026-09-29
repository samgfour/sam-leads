# Sam Leads

A small, private sales follow-up tracker. Keep prospects, call notes, next steps and reminders in one place. Your data lives in your own [Supabase](https://supabase.com) project. There is no build step: it is one HTML file.

## Features

- Add, edit and delete leads with stage, last contact, next follow-up and notes
- Search, filter by stage and sort
- "Today and overdue" and "Upcoming" agendas
- Browser reminders at a time you choose (keep the page open)
- Optional email sign-in, with each user only able to see their own leads

## Setup

1. **Create a Supabase project** at supabase.com.
2. **Create the table.** In the SQL editor, run `schema.sql`. If you already have a `leads` table, run `migrate-existing-table.sql` instead.
3. **Configure sign-in.** In Authentication, then URL Configuration, set the Site URL to where you will host the app and add it under Redirect URLs. After you have signed in once, you can turn off "Allow new users to sign up" to keep the app private.
4. **Add your settings.** Copy `config.example.js` to `config.js` and fill in your project URL and publishable (anon) key from Project Settings, then API.
5. **Host the files.** Upload `index.html` and `config.js` to any static host (Cloudflare Pages or Workers, Netlify, GitHub Pages), or open `index.html` with a local server.

## Security notes

- The publishable key is meant to be visible in the browser. Your data is protected by the row-level security policies in `schema.sql`, not by hiding the key. Do not skip step 2.
- Keep `REQUIRE_AUTH: true` unless you are running a private copy with your own policies.
- `config.js` is git-ignored so your own project settings are not published.
- Never put a `service_role` key in `config.js`.

## License

Copyright (C) 2026 Sam.

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the [GNU General Public License](https://www.gnu.org/licenses/gpl-3.0.html) for more details.

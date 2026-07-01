# Blogger — Modern Editorial Publication Platform

> A refined, human-centered blogging and publication engine built with Ruby on Rails. Styled with a warm editorial Vanilla CSS design system that prioritizes typographic elegance, reading comfort, and robust security.

---

## ✨ Architectural & Design Highlights

### 🎨 Warm Editorial Aesthetics
In response to modern web trends dominated by cold minimalism and dark cyberpunk palettes, **Blogger** embraces a publication-inspired aesthetic:
- **Curated Palette**: Soft off-white/cream background (`#fcfaf7`) paired with clean white cards, warm terracotta primary actions (`#c85a32`), and sage forest green badges (`#235347`).
- **Typographic Hierarchy**: Classical serif headers (`Merriweather`) paired with highly legible sans-serif body copy (`Inter`) for effortless long-form reading.
- **Responsive Magazine Layout**: Fluid CSS Grid article cards with hover animations, reading time metadata, and tag cloud directory.

### 🛡️ Secure & Modernized Logic
- **Deprecated Dependency Removal**: Successfully eliminated the obsolete `paperclip` gem, replacing it with a secure, lightweight custom `ImageAttachment` proxy model that handles file persistence cleanly without legacy bloat.
- **Association & Integrity Protection**: Enforced strict `before_save` callbacks for tag sanitization, uniqueness validations, and `dependent: :destroy` cascading rules on comments and taggings to prevent orphaned database records.
- **Robust Exception Handling**: Controllers (`ArticlesController`, `CommentsController`, `TagsController`) implement safe `ActiveRecord::RecordNotFound` rescue blocks, preventing 500 server crashes and redirecting users gracefully with informative flash notices.

---

## 🚀 Key Features
- **Dynamic Search & Filtering**: Integrated navigation search bar allowing instant keyword queries across article titles and body text.
- **Topic & Tag Indexing**: Full support for comma-separated tag creation with an interactive Tag Cloud directory and topic-specific filtering.
- **Community Discussions**: Clean, conversational comment threads on every perspective with author initials avatar styling and inline error validation.
- **Automated Reading Metrics**: Dynamic word-count and reading time calculations displayed on article cards and show pages.

---

## 🛠️ Technology Stack
- **Language**: Ruby 2.6.10+
- **Framework**: Ruby on Rails 6.0+
- **Database**: SQLite3
- **Frontend**: Vanilla CSS3 (Custom Properties, Grid, Flexbox — zero external UI framework dependencies)

---

## 📦 Installation & Setup

### 1. Clone the Repository
```bash
git clone https://github.com/michaelhamilton/blogger.git
cd blogger
```

### 2. Install Dependencies
Ensure you have Ruby installed (matching `.ruby-version`), then run Bundler:
```bash
gem install bundler
bundle install
```

### 3. Database Setup & Seeding
Prepare the SQLite database and seed it with curated editorial sample data:
```bash
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed
```

### 4. Launch Development Server
```bash
bundle exec rails server
```
Visit `http://localhost:3000` in your web browser to explore the publication.

---

## 🔧 Troubleshooting & Dependency Management

### What if Gems or Rails Dependencies Cannot Be Found?
If you encounter `GemNotFound`, `Bundler::GemNotFound`, or cannot locate Rails dependencies when running commands, follow these diagnostic steps:

1. **Verify Ruby & Bundler Environment**:
   Ensure your shell is using the correct Ruby version specified in `.ruby-version` via your environment manager (`rbenv`, `rvm`, or `asdf`):
   ```bash
   ruby -v
   which ruby
   ```
   If Bundler is missing for your Ruby version, install it globally:
   ```bash
   gem install bundler
   ```

2. **Re-index and Install Missing Gems**:
   Check if gems are missing or out of sync with `Gemfile.lock`:
   ```bash
   bundle check || bundle install
   ```
   If gems fail to install due to system permissions or system Ruby constraints, configure Bundler to install within the local project directory:
   ```bash
   bundle config set --local path 'vendor/bundle'
   bundle install
   ```

3. **Running Executables Safely**:
   Always prefix Rails commands and Rake tasks with `bundle exec` to ensure execution within the isolated gem environment:
   ```bash
   bundle exec rails server
   bundle exec rake db:migrate
   ```

4. **Offline / Vendor Cache Workflows**:
   In restricted or offline environments where gems cannot be downloaded from RubyGems, cache dependencies locally when online:
   ```bash
   bundle cache
   ```
   Gems will be packaged in `vendor/cache` and can be installed offline using `bundle install --local`.

---

## 📁 Project Structure
```text
blogger/
├── app/
│   ├── assets/stylesheets/application.css # Master Warm Editorial Design System
│   ├── controllers/                       # Refactored controllers with error rescue
│   ├── models/                            # Secure models & ImageAttachment proxy
│   └── views/                             # Refactored responsive magazine ERB views
├── db/
│   ├── migrate/                           # Database schema migrations
│   ├── schema.rb                          # Active database structure
│   └── seeds.rb                           # Curated editorial publication seed data
├── .gitignore                             # Comprehensive OS, editor, and Rails rules
├── .ruby-version                          # Ruby environment specification (2.6.10)
└── Gemfile                                # Clean dependency manifest (no paperclip)
```

---

## 📝 License
This project is open-source and available under the MIT License. Designed and modernized with security, elegance, and best practices in mind.

#!/usr/bin/env ruby
#
# Walks through creating a new post rather than reading everything
# in the "Guide to New Posts" topic and rather than typing the filename
# and all by hand, like jekyll-compose, but specific to this repo.
#

require 'yaml'

# --- Configuration ---
CONFIG_FILE = '_config.yml'.freeze
AUTHORS_FILE = '_data/authors.yml'.freeze
DRAFTS_DIR = '_drafts'.freeze
POSTS_DIR = '_posts'.freeze

# --- Helper Methods ---

def clear_screen
  Gem.win_platform? ? system('cls') : system('clear')
end

def get_input(prompt, default: nil, validation: nil)
  loop do
    print "#{prompt} #{default ? "[#{default}]" : ''}: "
    input = gets.strip
    return default if input.empty? && default
    return input if !validation || validation.call(input)
  end
end

# --- Main Script ---

Gem.win_platform? ? (system "cls") : (system "clear")

cfgfile = YAML.safe_load(File.read(CONFIG_FILE))

# getting the default author (first in authors file if exist)
if File.exist?(AUTHORS_FILE)
  author = YAML.safe_load(File.read(AUTHORS_FILE)).keys.first
end

# for print stmt buffers
STDOUT.sync = true

#
# interview
#

puts <<-eoh

This script helps you create a post. It adds it to the _drafts folder.
(Hit Ctrl-C at any time to cancel. Default values are shown in brackets;
to accept the default you can just hit return.)

This site has two types of posts:
- Topics: blog posts
- Works: portfolio entries

eoh
type = get_input('Is this a (t)opic or (w)ork?', default: 't', validation: ->(i) { %w[t w].include?(i) })

categories = Array.new
if type=='w'
  categories << 'works'
  puts <<-eoh

Higher priority works are listed first and also get the same priority value
for the site map. 1.0 is the highest possible value, and you probably don't
want it to have a priority under 0.5. What priority should it have?
  eoh
  priority = get_input('(0 - 1.0)', default: '0.7', validation: ->(i) { (0.0..1.0).cover?(i.to_f) })
else
  categories << 'topics'
  puts <<-eoh

The first 10 featured posts are listed on the front page and get a higher
priority in the site map. Is this a featured post?
  eoh
  featured = get_input('(y or [n])', default: 'n', validation: ->(i) { %w[y n].include?(i) }) == 'y'
  puts <<-eoh

If this is a part of a series of posts that you want to be displayed with
back/next links, you can specify a sub-category name. Note that only the
first topic in the sub-category is listed in the topics index. Also note
that categories should probably have alphanumeric, underscores, hyphens,
and space characters only. Tip: I title my first topic in the sub-category
with the same name as the sub-category so that the breadcrumb looks nice.

  eoh
  is_group = get_input('So, is this part of a sub-category grouping? (y or [n])', default: 'n', validation: ->(i) { %w[y n].include?(i) })
  if is_group == 'y'
    subcat = get_input("\nSub-category name", validation: ->(i) { !i.empty? && i.match?(/\A[0-9A-Za-z_\- ]+\z/) })
    categories << subcat

    is_first = get_input("\nIs this your first topic in the sub-category? (y or [n])", default: 'n', validation: ->(i) { %w[y n].include?(i) })
    if is_first == 'y'
      perma = "/#{categories.join('/')}/"
    end
  end
end

title = get_input("\nPost title", validation: ->(i) { !i.empty? })

excerpt = get_input("\nPost excerpt")

if type == 't'
  theauth = if author
              get_input("\nPost author", default: author)
            else
              get_input("\nPost author", validation: ->(i) { !i.empty? })
            end
end

puts <<-eoc

If you want an image in the banner, put the image in the /images folder
and type the name here. If it's in another folder, prefix the image with
'/' and the folder name, such as /unique/images/mine.jpg. For no image,
just hit Enter.
eoc_
back = get_input('background-image')

puts <<-eoc

There are a few other options you could add, such as a mini-heading, a
full-width body, and a custom icon for featured posts on the front page.
For a full description of options, see the "Guide for New Posts" topic
when you run jekyll serve --future.

Otherwise, hit Enter to create this starter post.
eoc
letsdothis = gets

#
# a bit of formatting and date
#

tslug = title.downcase.gsub(/[[:space:]]|[\\\/<>:"|?*#%]+/, '-')

t = Time.new
tstamp = t.strftime("%Y-%m-%d %H:%M:%S")
dstamp = t.strftime("%Y-%m-%d")

ext = cfgfile.dig('compose', 'extension') || 'md'

fname = "#{dstamp}-#{tslug}.#{ext}"

#
# Done, let's print the post
#

STDOUT.flush

draft_path = File.join(DRAFTS_DIR, fname)
post_path = File.join(POSTS_DIR, fname)

if File.exist?(draft_path) || File.exist?(post_path)
  puts <<-eom
Sorry you went through all that trouble, but the file
#{fname} already exists.
  eom
else
  Dir.mkdir(DRAFTS_DIR) unless Dir.exist?(DRAFTS_DIR)
  File.open(draft_path, 'w') do |f|
    f.puts "---"
    f.puts "title: #{title}"
    f.puts "excerpt: #{excerpt}"
    f.puts "author: #{theauth}" if theauth
    f.puts "tags: featured" if featured
    f.puts "priority: #{priority}" if priority
    f.puts "permalink: #{perma}" if perma
    f.puts "categories:"
    categories.each { |cat| f.puts "  - #{cat}" }
    f.puts "background-image: #{back}" if back && !back.empty?
    f.puts "#date/lastupdated are optional"
    f.puts "#date: #{tstamp}"
    f.puts "#lastupdated: #{tstamp}"
    f.puts "---"
    puts "File created: #{draft_path}"
    # open it in an editor if specified
    if (editor_cmd = cfgfile.dig('compose', 'editor'))
      system "#{editor_cmd} #{draft_path}"
    end
  end
end

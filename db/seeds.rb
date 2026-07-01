# This file seeds the database with realistic editorial publication data.
# Run with: bundle exec rails db:seed

puts "Clearing existing data..."
Comment.delete_all
Tagging.delete_all
Tag.delete_all
Article.delete_all

puts "Creating editorial perspectives..."

a1 = Article.create!(
  title: "The Silent Geometry of Brutalist Spaces",
  body: <<~BODY,
    There is a profound quiet that envelops you when standing inside a well-proportioned concrete hall. For decades, Brutalism was misunderstood by the public as imposing, cold, and authoritarian. Yet today, architects and philosophers are revisiting raw concrete—béton brut—as an honest material that strips away superficial ornament to celebrate light, shadow, and sheer structural truth.

    Consider the way morning sunlight carves across a textured concrete wall. Because the surface does not reflect light like glass or polished marble, it absorbs and softens it. The geometry of the building becomes a canvas for the passing of time itself.

    As our digital environments become increasingly ephemeral and frictionless, our physical craving for permanence, gravity, and tactile authenticity grows stronger. Brutalist spaces anchor us in the physical world, demanding our attention and reminding us of the monumental scale of human endeavor.
  BODY
  tag_list: "Architecture, Design, Modernism"
)

a1.comments.create!(author_name: "Marcus Thorne", body: "A wonderfully articulated defense of Brutalism! The point about concrete absorbing rather than reflecting light is something I notice every time I visit the Barbican in London.")
a1.comments.create!(author_name: "Elena Rostova", body: "I used to find raw concrete intimidating until I started studying mid-century Japanese architecture. The interplay between raw stone, wood, and concrete is magical.")

a2 = Article.create!(
  title: "Wired for Slow: Why Analog Tools Endure in the Digital Age",
  body: <<~BODY,
    In an era dominated by instant synchronization, artificial intelligence, and ubiquitous cloud storage, a counter-intuitive phenomenon is occurring among creative professionals: the resurgence of analog tools. Vinyl records, fountain pens, mechanical notebooks, and film cameras are experiencing sustained revivals that defy pure nostalgia.

    Why do we reach for a paper notebook when a tablet can index and search thousands of pages instantly? The answer lies in the cognitive benefits of friction. The physical act of handwriting slows our thought processes down to match the speed of our physical hand movements. This deliberate pacing creates a mental buffer where synthesis, reflection, and deeper memory retention take place.

    Furthermore, analog tools offer a sanctuary from the relentless demand for attention. A notebook does not push notifications, track your location, or request software updates. It exists purely in service of your thoughts, offering a finite, tactile boundary in an otherwise boundless digital ocean.
  BODY
  tag_list: "Technology, Culture, Philosophy"
)

a2.comments.create!(author_name: "David Chen", body: "This resonates deeply with my daily workflow. I switched back to a paper daily planner six months ago, and my anxiety levels dropped noticeably.")

a3 = Article.create!(
  title: "The Sustainable Kitchen: Designing for Zero-Waste Living",
  body: <<~BODY,
    The kitchen is the biological and social engine of the home, but it is also historically one of our largest sources of domestic waste. Transitioning toward a sustainable kitchen is not about aesthetic perfection or expensive matching glass jars; it is fundamentally about redesigning our relationship with consumption and preservation.

    True sustainability begins with intentional sourcing and local circularity. Understanding the seasonality of local produce transforms cooking from a routine chore into an evolving conversation with your local ecosystem. When we design our kitchens around preservation—fermentation, composting, and root storage—we rediscover culinary traditions that have sustained communities for generations.

    Small, consistent shifts in daily habits accumulate into massive environmental impacts over time. By honoring our ingredients and minimizing single-use packaging, we turn the kitchen into a space of stewardship and nourishment.
  BODY
  tag_list: "Sustainability, Living, Food"
)

a3.comments.create!(author_name: "Clara Jenkins", body: "Love this perspective! Fermentation has completely changed how I look at food preservation and reducing kitchen waste.")
a3.comments.create!(author_name: "Samir Patel", body: "Simple, actionable, and inspiring without being preachy. Thank you for this essay.")

a4 = Article.create!(
  title: "Typography as Voice: The Emotional Architecture of Serif Fonts",
  body: <<~BODY,
    Typography is often described as the dress code of the written word, but it is more accurately understood as the subconscious voice of the text. Before a reader consciously processes a single sentence, the geometry of the typeface has already established the tone, pacing, and emotional resonance of the communication.

    In recent years, the digital landscape was swept by an wave of geometric sans-serif homogenization. Brands and publications adopted identical minimalist letterforms in pursuit of sterile neutrality. Today, however, we are witnessing a celebrated return to editorial serifs—typefaces with warmth, historical roots, and distinctive humanist quirks.

    A well-crafted serif typeface creates a rhythmic baseline that guides the reader's eye effortlessly across long-form paragraphs. The subtle modulation of thick and thin strokes introduces a cadenced melody to the reading experience, bridging the gap between historical print traditions and modern digital displays.
  BODY
  tag_list: "Design, Typography, Culture"
)

a4.comments.create!(author_name: "Sonia Wright", body: "As a editorial designer, I couldn't agree more. The return to humanist serifs has restored so much soul to online publishing.")

puts "Seed data successfully created!"
puts "Created #{Article.count} articles, #{Tag.count} tags, and #{Comment.count} comments."

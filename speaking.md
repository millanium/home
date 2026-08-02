---
layout: page
title: Speaking
permalink: /speaking/
excerpt: "I enjoy speaking publicly at the conferences and meetups where I share my knowledge and experience."
background-image: /images/pic4.jpg
featured: true
---

<div class="tiles">
{% for post in site.categories.speaking %}
  <article>
    <span class="image">
      <img src="{{ post.background-image | default: '/images/pic01.jpg' | relative_url }}" alt="" />
    </span>
    <a href="{{ post.url | relative_url }}">
      <h2>{{ post.title }}</h2>
      <div class="content"><p>{{ post.excerpt }}</p></div>
    </a>
  </article>
{% endfor %}
</div>
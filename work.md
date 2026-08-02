---
layout: page
title: Work
permalink: /work/
excerpt: "I write about ideas, tools, processes and everything that matters to our work."
background-image: /images/pic3.jpg
---

<div class="tiles">
{% for post in site.categories.work %}
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
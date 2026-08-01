---
key: 2
title: Speaking
permalink: /speaking/
excerpt: "A collection of my public speaking engagements, including keynotes, conference talks, and meetup presentations."
background-image: /images/pic3.jpg
image: pic3.jpg
---

I enjoy sharing my knowledge and experience at conferences and meetups. Here is a list of my previous and upcoming speaking engagements.

<div class="table-wrapper">
  <table>
    {% for post in site.categories.speaking reversed %}
      <tr><td><a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a></td></tr>
    {% endfor %}
  </table>
</div>
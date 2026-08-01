---
key: 3
title: Work
permalink: /work/
excerpt: "A collection of my professional work, projects, and articles."
background-image: /images/pic4.jpg
image: pic4.jpg
---

Here are some of my projects and writings. For a more detailed overview, please see my <a href="/resume/">resume</a>.

<div class="table-wrapper">
  <table>
    {% for post in site.categories.work reversed %}
      <tr><td><a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a></td></tr>
    {% endfor %}
  </table>
</div>
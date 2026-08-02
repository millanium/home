---
key: 3
title: Work
permalink: /work/
excerpt: "A collection of my professional work, projects, and articles."
background-image: pic4.jpg
image: pic4.jpg
---

Here are some of my projects and writings. For a more detailed overview, please see my <a href="/resume/">resume</a>.

<div class="table-wrapper">
  <table>
    <tbody>
    {% assign sorted_work = site.categories.work | sort: 'date' | reverse %}
    {% for post in sorted_work %}
      <tr>
        <td><b><a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a></b></td>
        <td>{{ post.date | date: "%b %Y" }}</td>
        <td>{{ post.excerpt | strip_html | truncatewords: 14 }}</td>
      </tr>
    {% endfor %}
    </tbody>
  </table>
</div>

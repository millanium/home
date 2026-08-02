---
key: 3
title: Speaking
permalink: /speaking/
excerpt: "A collection of my public speaking engagements, including keynotes, conference talks, and meetup presentations."
description: "A collection of my public speaking engagements, including keynotes, conference talks, and meetup presentations."
background-image: pic3.jpg
image: pic3.jpg
---

I enjoy sharing my knowledge and experience at conferences and meetups. Here is a list of my previous and upcoming speaking engagements.

<div class="table-wrapper">
  <table>
    <tbody>
    {% assign sorted_speaking = site.categories.speaking | sort: 'date' | reverse %}
    {% for post in sorted_speaking %}
      <tr>
        <td><b><a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a></b></td>
        <td>{{ post.date | date: "%b %Y" }}</td>
        <td>{{ post.excerpt | strip_html | truncatewords: 14 }}</td>
      </tr>
    {% endfor %}
    </tbody>
  </table>
</div>

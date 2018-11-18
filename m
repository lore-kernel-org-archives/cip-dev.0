From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Sun, 18 Nov 2018 21:51:49 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 3
 commits: webview: Display {intrdoduced, fixed}-by value of 'never' properly
Message-ID: <5bf1def5a0138_50653ffc64fb4e9c574959@sidekiq-asap-03-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
ce82cf92 by Ben Hutchings at 2018-11-18T21:33:27Z
webview: Display {intrdoduced,fixed}-by value of &#39;never&#39; properly

- - - - -
770a43fa by Ben Hutchings at 2018-11-18T21:48:44Z
webview: Move fixed/introduced commit lists into status on issue page

- - - - -
606cb07e by Ben Hutchings at 2018-11-18T21:50:54Z
webview: Use green/red colouring for status background rather than text

- - - - -


2 changed files:

- scripts/templates/issue.html
- scripts/templates/style.css


Changes:

=====================================
scripts/templates/issue.html
=====================================
@@ -71,36 +71,35 @@
     </td>
   </tr>
   {% endif %}
-  {% if issue['introduced-by'] %}
   <tr>
-    <th rowspan={{ issue['introduced-by']|length }}>Introduced by</th>
-    {% for branch in issue['introduced-by'] %}
+    <th rowspan={{ branches|length }}>Status</th>
+    {% for name, affected in branches %}
     <th>
-      {{ branch }}
+      <a href="/branch/{{ name }}/">{{ name }}</a>
     </th>
     <td>
-      {% for commit in issue['introduced-by'][branch] %}
+      {% if not affected %}
+      {% if issue['fixed-by'] and issue['fixed-by'][name] and issue['fixed-by'][name] != 'never' %}
+      <span class="good">fixed</span> by
+      {% for commit in issue['fixed-by'][name] %}
       <a href="https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit?id={{ commit }}">{{ commit[:12] }}</a>{% if not loop.last %},{% endif %}
       {% endfor %}
-    </td>
-    {% if not loop.last %}
-  </tr>
-  <tr>
-    {% endif %}
-    {% endfor %}
-  </tr>
-  {% endif %}
-  {% if issue['fixed-by'] %}
-  <tr>
-    <th rowspan={{ issue['fixed-by']|length }}>Fixed by</th>
-    {% for branch in issue['fixed-by'] %}
-    <th>
-      {{ branch }}
-    </th>
-    <td>
-      {% for commit in issue['fixed-by'][branch] %}
+      {% else %}
+      <span class="good">never affected</span>
+      {% endif %}
+      {% else %}
+      {% if issue.ignore and (issue.ignore.all or issue.ignore[name]) %}
+      <span class="ignored">ignored</span>
+      {% else %}
+      <span class="bad">vulnerable</span>
+      {% endif %}
+      {% if issue['introduced-by'] and issue['introduced-by'][name] and issue['introduced-by'][name] != 'never' %}
+      - introduced by
+      {% for commit in issue['introduced-by'][name] %}
       <a href="https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit?id={{ commit }}">{{ commit[:12] }}</a>{% if not loop.last %},{% endif %}
       {% endfor %}
+      {% endif %}
+      {% endif %}
     </td>
     {% if not loop.last %}
   </tr>
@@ -108,7 +107,6 @@
     {% endif %}
     {% endfor %}
   </tr>
-  {% endif %}
   {% if issue['fix-depends-on'] %}
   <tr>
     <th>Fix depends on</th>
@@ -122,26 +120,4 @@
     </td>
   </tr>
   {% endif %}
-  <tr>
-    <th rowspan={{ branches|length }}>Status</th>
-    {% for name, affected in branches %}
-    <th>
-      <a href="/branch/{{ name }}/">{{ name }}</a>
-    </th>
-    <td>
-      {% if not affected %}
-      {# Currently we don't distinguish between never-affected or fixed #}
-      <span class="good">not affected</span>
-      {% elif issue.ignore and (issue.ignore.all or issue.ignore[name]) %}
-      <span class="ignored">ignored</span>
-      {% else %}
-      <span class="bad">vulnerable</span>
-      {% endif %}
-    </td>
-    {% if not loop.last %}
-  </tr>
-  <tr>
-    {% endif %}
-    {% endfor %}
-  </tr>
 </table>


=====================================
scripts/templates/style.css
=====================================
@@ -20,10 +20,10 @@ body {
 }
 
 .good {
-    color: #33cc33;
+    background-color: #40ff40;
 }
 .bad {
-    color: #ff0000;
+    background-color: #ff4040;
 }
 
 table {



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/c4d3bc0b2ec59720acd1d5ab5d35904538fd1ffe...606cb07e94f6c16a67cfd57bbdc79221af133921

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/c4d3bc0b2ec59720acd1d5ab5d35904538fd1ffe...606cb07e94f6c16a67cfd57bbdc79221af133921
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20181118/805dba3a/attachment-0001.html>

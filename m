From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Thu, 15 Aug 2019 15:41:02 +0000
Subject: [cip-dev]
 [Git][cip-project/cip-kernel/cip-kernel-sec][bwh/web-report-affected]
 webview: Make open issues table headings "sticky"
Message-ID: <5d557d0ebbfeb_3ce73fdcad24e1943759070@sidekiq-asap-02-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch bwh/web-report-affected at cip-project / cip-kernel / cip-kernel-sec


Commits:
b72bc3f4 by Ben Hutchings at 2019-08-15T15:40:50Z
webview: Make open issues table headings &quot;sticky&quot;

The open issues table can easily be larger than a browser window.
Style the table headings for this table so that they don&#39;t scroll
away (in either dimension).

Tested with Firefox 60.8.0esr and 73.0.3683.75, and should be
compatible with current Edge and Safari.

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -


2 changed files:

- scripts/templates/open_issues.html
- scripts/templates/style.css


Changes:

=====================================
scripts/templates/open_issues.html
=====================================
@@ -1,37 +1,39 @@
 <link rel="stylesheet" href="/static/style.css">
 <title>Open issues</title>
 <h1>Open issues</h1>
-<table>
-  <thead>
+<div class="table-container">
+  <table class="fixed-header">
+    <thead>
+      <tr>
+	<th/>
+	{% for name, _, _ in branches %}
+	<th>
+	  <a href="/branch/{{ name }}/">{{ name }}</a>
+	</th>
+	{% endfor %}
+      </tr>
+    </thead>
+    {% for cve_id, issue in cve_ids %}
     <tr>
-      <td/>
-      {% for name, _, _ in branches %}
       <th>
-	<a href="/branch/{{ name }}/">{{ name }}</a>
+	<a href="/issue/{{ cve_id }}/">{{ cve_id }}</a>
       </th>
+      {% for name, branch, affected in branches %}
+      {% if not affected[cve_id] %}
+      {% if issue['fixed-by'] and issue['fixed-by'][name] %}
+      <td class="good">fixed</td>
+      {% else %}
+      <td class="good">never affected</td>
+      {% endif %}
+      {% else %}
+      {% if issue.ignore and (issue.ignore.all or issue.ignore[name]) %}
+      <td class="ignored">ignored</td>
+      {% else %}
+      <td class="bad">vulnerable</td>
+      {% endif %}
+      {% endif %}
       {% endfor %}
     </tr>
-  </thead>
-  {% for cve_id, issue in cve_ids %}
-  <tr>
-    <th>
-      <a href="/issue/{{ cve_id }}/">{{ cve_id }}</a>
-    </th>
-    {% for name, branch, affected in branches %}
-    {% if not affected[cve_id] %}
-    {% if issue['fixed-by'] and issue['fixed-by'][name] %}
-    <td class="good">fixed</td>
-    {% else %}
-    <td class="good">never affected</td>
-    {% endif %}
-    {% else %}
-    {% if issue.ignore and (issue.ignore.all or issue.ignore[name]) %}
-    <td class="ignored">ignored</td>
-    {% else %}
-    <td class="bad">vulnerable</td>
-    {% endif %}
-    {% endif %}
     {% endfor %}
-  </tr>
-  {% endfor %}
-</table>
+  </table>
+</div>


=====================================
scripts/templates/style.css
=====================================
@@ -45,3 +45,26 @@ th, td {
     padding-left: 0.5em;
     padding-right: 0.5em;
 }
+
+/*
+ * Stop table headings scrolling away using position: sticky; see
+ * <https://stackoverflow.com/questions/11891065/>.
+ */
+table-container {
+    display: inline-block;
+    overflow: auto;
+}
+table.fixed-header thead th {
+    position: -webkit-sticky;
+    position: sticky;
+    top: 0;
+    background-color: #ffffff;
+    background-clip: padding-box;
+}
+table.fixed-header tbody th {
+    position: -webkit-sticky;
+    position: sticky;
+    left: 0;
+    background-color: #ffffff;
+    background-clip: padding-box;
+}



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/b72bc3f4ddcb3b9635c88f2234eae09748e25e4c

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/b72bc3f4ddcb3b9635c88f2234eae09748e25e4c
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190815/2759202b/attachment-0001.html>

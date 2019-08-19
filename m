From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Mon, 19 Aug 2019 13:45:18 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 3
 commits: webview: Add "open issues" page similar to default report_affected
 output
Message-ID: <5d5aa7eed1017_56f53fefc51334141310002c@sidekiq-asap-04-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
bc3d6315 by Ben Hutchings at 2019-08-15T15:01:34Z
webview: Add &quot;open issues&quot; page similar to default report_affected output

Thew new page shows a table of open issues with the status for each
branch.

* Expose the page at /issue/open/
* Link to it from the root
* Align text to the left in the heading row

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
b72bc3f4 by Ben Hutchings at 2019-08-15T15:40:50Z
webview: Make open issues table headings &quot;sticky&quot;

The open issues table can easily be larger than a browser window.
Style the table headings for this table so that they don&#39;t scroll
away (in either dimension).

Tested with Firefox 60.8.0esr and 73.0.3683.75, and should be
compatible with current Edge and Safari.

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
3c031569 by Ben Hutchings at 2019-08-19T13:45:16Z
Merge branch &#39;bwh/web-report-affected&#39; into &#39;master&#39;

webview: Add &quot;open issues&quot; page similar to default report_affected output

See merge request cip-project/cip-kernel/cip-kernel-sec!6
- - - - -


4 changed files:

- + scripts/templates/open_issues.html
- scripts/templates/root.html
- scripts/templates/style.css
- scripts/webview.py


Changes:

=====================================
scripts/templates/open_issues.html
=====================================
@@ -0,0 +1,39 @@
+<link rel="stylesheet" href="/static/style.css">
+<title>Open issues</title>
+<h1>Open issues</h1>
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
+    <tr>
+      <th>
+	<a href="/issue/{{ cve_id }}/">{{ cve_id }}</a>
+      </th>
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
+      {% endfor %}
+    </tr>
+    {% endfor %}
+  </table>
+</div>


=====================================
scripts/templates/root.html
=====================================
@@ -2,5 +2,7 @@
 <title>Kernel security tracker</title>
 <h1>Kernel security tracker</h1>
 <p>
-  <a href="branch/">View branches</a> | <a href="issue/">View issues</a>
+  <a href="branch/">View branches</a> |
+  <a href="issue/open/">View open issues</a> |
+  <a href="issue/">View all issues</a>
 </p>


=====================================
scripts/templates/style.css
=====================================
@@ -38,7 +38,33 @@ th {
     vertical-align: top;
     white-space: nowrap;
 }
+thead th {
+    text-align: left;
+}
 th, td {
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


=====================================
scripts/webview.py
=====================================
@@ -1,6 +1,6 @@
 #!/usr/bin/python3
 
-# Copyright 2018 Codethink Ltd.
+# Copyright 2018-2019 Codethink Ltd.
 #
 # This script is distributed under the terms and conditions of the GNU General
 # Public License, Version 3 or later. See http://www.gnu.org/copyleft/gpl.html
@@ -137,6 +137,43 @@ class Issue:
             remotes=self._root.remotes)
 
 
+class OpenIssues:
+    _template = _template_env.get_template('open_issues.html')
+
+    def __init__(self, root):
+        self._root = root
+
+    @cherrypy.expose
+    def index(self):
+        open_cve_ids = []
+        branches = [
+            (branch_name, self._root.branch_defs[branch_name], {})
+            for branch_name in self._root.branch_names
+        ]
+        for cve_id in _issue_cache.keys():
+            issue = _issue_cache[cve_id]
+            ignore = issue.get('ignore', {})
+            if 'all' in ignore:
+                continue
+            is_open = False
+            for branch_name, branch, affected in branches:
+                if kernel_sec.issue.affects_branch(
+                        issue, branch, self._root.is_commit_in_branch):
+                    affected[cve_id] = True
+                    if branch_name not in ignore:
+                        is_open = True
+            if is_open:
+                open_cve_ids.append(cve_id)
+
+        return self._template.render(
+            cve_ids=[
+                (cve_id, _issue_cache[cve_id])
+                for cve_id in sorted(open_cve_ids,
+                                     key=kernel_sec.issue.get_id_sort_key)
+            ],
+            branches=branches)
+
+
 class Issues:
     _template = _template_env.get_template('issues.html')
 
@@ -146,6 +183,8 @@ class Issues:
     def _cp_dispatch(self, vpath):
         if len(vpath) == 1 and vpath[0] in _issue_cache:
             return Issue(vpath.pop(), self._root)
+        if len(vpath) == 1 and vpath[0] == 'open':
+            return OpenIssues(self._root)
         return vpath
 
     @cherrypy.expose



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/58c5886331a7cf41190f22eeaaa1ee7a03f3eb44...3c031569f053f87070fd40d8c1020efc775b4480

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/58c5886331a7cf41190f22eeaaa1ee7a03f3eb44...3c031569f053f87070fd40d8c1020efc775b4480
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190819/010b7805/attachment-0001.html>

From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Wed, 14 Nov 2018 22:20:27 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 3
 commits: Move CVE ID sort key function into kernel_sec.issue module
Message-ID: <5bec9fab8ada9_69123fea4cfa0a0c60046a@sidekiq-asap-02-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
0f9551d9 by Ben Hutchings at 2018-11-14T18:26:22Z
Move CVE ID sort key function into kernel_sec.issue module

- - - - -
73dd8ff0 by Ben Hutchings at 2018-11-14T22:18:14Z
Add simple web application

- - - - -
58186e1a by Ben Hutchings at 2018-11-14T22:20:04Z
Document the PyYAML dependency

- - - - -


9 changed files:

- README.md
- scripts/kernel_sec/issue.py
- scripts/report_affected.py
- + scripts/templates/branch.html
- + scripts/templates/branches.html
- + scripts/templates/issue.html
- + scripts/templates/issues.html
- + scripts/templates/root.html
- + scripts/webview.py


Changes:

=====================================
README.md
=====================================
@@ -14,7 +14,8 @@ The schema is roughly documented in
 
 Various scripts, written in Python 3, are in the `scripts`
 subdirectory.  Supporting modules are in the `kernel_sec` subdirectory
-beneath that.
+beneath that.  They require PyYAML (packaged in Debian as
+python3-yaml).
 
 * `scripts/import_debian.py` - import information from Debian's
 `kernel_sec` project.  It includes all issues that Debian considers
@@ -39,6 +40,10 @@ schema.
 files.  This should be run after hand-editing files to reduce
 "noise" in later automated updates.
 
+* `scripts/webview.py` - run a local web server that allows browsing
+branches and issues.  This requires CherryPy and Jinja2 (packaged
+in Debian as python3-cherrypy3 and python3-jinja2).
+
 ## Contributions
 
 If you have better information about any issue, or additional


=====================================
scripts/kernel_sec/issue.py
=====================================
@@ -265,3 +265,10 @@ def load(cve_id):
 
 def save(cve_id, issue):
     save_filename(get_filename(cve_id), issue)
+
+# Match the "arbitrary digits" after the year
+_cve_id_arbdig_re = re.compile(r'-(\d+)$')
+
+# Pad "arbitrary digits" to 6 digits so string comparison works
+def get_id_sort_key(cve_id):
+    return _cve_id_arbdig_re.sub(lambda m: '-%06d' % int(m.group(1)), cve_id)


=====================================
scripts/report_affected.py
=====================================
@@ -27,10 +27,6 @@ def get_commits(git_repo, end, start=None):
     for line in io.TextIOWrapper(list_proc.stdout):
         yield line.rstrip('\n')
 
-# Pad last part of CVE ID to 6 digits so string comparison keeps working
-def pad_cve_id(cve_id):
-    return re.sub(r'-(\d+)$', lambda m: '-%06d' % int(m.group(1)), cve_id)
-
 def main(git_repo, mainline_remote_name, stable_remote_name, only_fixed_upstream,
          include_ignored, *branch_names):
     if branch_names:
@@ -119,7 +115,8 @@ def main(git_repo, mainline_remote_name, stable_remote_name, only_fixed_upstream
             branch_issues.setdefault(branch, []).append(cve_id)
 
     for branch in branch_names:
-        print('%s:' % branch, *sorted(branch_issues.get(branch, []), key=pad_cve_id))
+        print('%s:' % branch, *sorted(branch_issues.get(branch, []),
+                                      key=kernel_sec.issue.get_id_sort_key))
 
 if __name__ == '__main__':
     parser = argparse.ArgumentParser(


=====================================
scripts/templates/branch.html
=====================================
@@ -0,0 +1,5 @@
+<title>Branch {{ name }}</title>
+<h1>Branch {{ name }}</h1>
+<p>
+  There should be a list of issues here...
+</p>


=====================================
scripts/templates/branches.html
=====================================
@@ -0,0 +1,10 @@
+<title>Branches</title>
+<h1>Branches</h1>
+<p>
+  Only the currently maintained branches are shown.
+</p>
+<ul>
+  {% for name in names %}
+  <li><a href="{{ name }}/">{{ name }}</a></li>
+  {% endfor %}
+</ul>


=====================================
scripts/templates/issue.html
=====================================
@@ -0,0 +1,104 @@
+<title>{{ cve_id }} - {{ issue.description|truncate(50) }}</title>
+<h1>{{ cve_id }} - {{ issue.description|truncate(50) }}</h1>
+<h2>Summary</h2>
+<p>{{ issue.description }}</p>
+{% if issue.advisory %}
+<h2>Advisory</h2>
+<p>{{ issue.advisory }}</p>
+{% endif %}
+<table>
+  {% if issue.references %}
+  <tr>
+    <th>References</th>
+    <td>
+      {% for url in issue.references %}
+      <a href="{{ url }}">{{ url }}</a>
+      {% if not loop.last %}|{% endif %}
+      {% endfor %}
+    </td>
+  </tr>
+  {% endif %}
+  {% if issue.aliases %}
+  <tr>
+    <th>Aliases</th>
+    <td>
+      {% for alias in issue.aliases %}
+      {{ alias }}{% if not loop.last %},{% endif %}  
+      {% endfor %}
+    </td>
+  </tr>
+  {% endif %}
+  {% if issue.comments %}
+  <tr>
+    <th>Comments</th>
+    <td>
+      {% for handle in issue.comments %}
+      {{ handle }}: <q>{{ issue.comments[handle] }}</q>
+      {% if not loop.last %}<br/>{% endif %}
+      {% endfor %}
+    </td>
+  </tr>
+  {% endif %}
+  {% if issue.reporters %}
+  <tr>
+    <th>Reporters</th>
+    <td>
+      {% for rep in issue.reporters %}
+      {# This may include an email address which could be linked #}
+      {{ rep }}{% if not loop.last %},{% endif %}
+      {% endfor %}
+    </td>
+  </tr>
+  {% endif %}
+  {% if issue['embargo-end'] %}
+  <tr>
+    <th>Embargo</th>
+    <td>
+      {# TODO: If embargo-end is in the future we should prominently
+      flag this issue as embargoed #}
+      {{ issue['embargo-end'] }}
+    </td>
+  </tr>
+  {% endif %}
+  {% if issue['introduced-by'] %}
+  <tr>
+    <th>Introduced by</th>
+    <td>
+      {% for branch in issue['introduced-by'] %}
+      {{ branch }}:
+      {% for commit in issue['introduced-by'][branch] %}
+      <a href="https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit?id={{ commit }}">{{ commit[:12] }}</a>{% if not loop.last %},{% endif %}
+      {% endfor %}
+      {% if not loop.last %}<br/>{% endif %}
+      {% endfor %}
+    </td>
+  </tr>
+  {% endif %}
+  {% if issue['fixed-by'] %}
+  <tr>
+    <th>Fixed by</th>
+    <td>
+      {% for branch in issue['fixed-by'] %}
+      {{ branch }}:
+      {% for commit in issue['fixed-by'][branch] %}
+      <a href="https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit?id={{ commit }}">{{ commit[:12] }}</a>{% if not loop.last %},{% endif %}
+      {% endfor %}
+      {% if not loop.last %}<br/>{% endif %}
+      {% endfor %}
+    </td>
+  </tr>
+  {% endif %}
+  {% if issue['fix-depends-on'] %}
+  <tr>
+    <th>Fix depends on</th>
+    <td>
+      {% for commit in issue['fix-depends-on'] %}
+      <a href="https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit?id={{ commit }}">{{ commit[:12] }}</a>
+      ({{ issue['fix-depends-on'][commit] }})
+      {% if not loop.last %}<br/>{% endif %}
+      {% endfor %}
+    </td>
+  </tr>
+  {% endif %}
+</table>
+{# TODO: show issue status for each branch #}


=====================================
scripts/templates/issues.html
=====================================
@@ -0,0 +1,7 @@
+<title>Issues</title>
+<h1>Issues</h1>
+<ul>
+  {% for cve_id in cve_ids %}
+  <li><a href="{{ cve_id }}/">{{ cve_id }}</a></li>
+  {% endfor %}
+</ul>


=====================================
scripts/templates/root.html
=====================================
@@ -0,0 +1,5 @@
+<title>Kernel security tracker</title>
+<h1>Kernel security tracker</h1>
+<p>
+  <a href="branch/">View branches</a> | <a href="issue/">View issues</a>
+</p>


=====================================
scripts/webview.py
=====================================
@@ -0,0 +1,153 @@
+#!/usr/bin/python3
+
+# Copyright 2018 Codethink Ltd.
+#
+# This script is distributed under the terms and conditions of the GNU General
+# Public License, Version 3 or later. See http://www.gnu.org/copyleft/gpl.html
+# for details.
+
+import argparse
+import os
+
+import cherrypy
+import jinja2
+
+import kernel_sec.branch, kernel_sec.issue
+
+
+_template_env = jinja2.Environment(
+    loader=jinja2.FileSystemLoader('scripts/templates'),
+    autoescape=True)
+
+
+class IssueCache:
+    def __init__(self):
+        self._data = {}
+
+    def _refresh(self, name, loader):
+        file_time = os.stat(name).st_mtime
+        cache_data, cache_time = self._data.get(name, (None, None))
+        if file_time != cache_time:
+            cache_data, cache_time = loader(), file_time
+            self._data[name] = (cache_data, cache_time)
+        return cache_data
+
+    def _refresh_keys(self):
+        return self._refresh('issues', lambda: set(kernel_sec.issue.get_list()))
+
+    def _refresh_issue(self, cve_id):
+        filename = kernel_sec.issue.get_filename(cve_id)
+        return self._refresh(filename,
+                             lambda: kernel_sec.issue.load_filename(filename))
+
+    def keys(self):
+        return iter(self._refresh_keys())
+
+    def __contains__(self, cve_id):
+        return cve_id in self._refresh_keys()
+
+    def __getitem__(self, cve_id):
+        if cve_id not in self._refresh_keys():
+            raise KeyError
+        return self._refresh_issue(cve_id)
+
+
+_issue_cache = IssueCache()
+
+
+class Branch:
+    _template = _template_env.get_template('branch.html')
+
+    def __init__(self, branch):
+        self._name = name
+
+    @cherrypy.expose
+    def index(self):
+        return self._template.render(name=self._name)
+
+
+class Branches:
+    _template = _template_env.get_template('branches.html')
+
+    def __init__(self, git_repo, mainline_remote_name, stable_remote_name):
+        self._names = kernel_sec.branch.get_live_stable_branches(
+            git_repo, stable_remote_name)
+        self._names.append('mainline')
+
+    def _cp_dispatch(self, vpath):
+        if len(vpath) == 1 and vpath[0] in self._branches:
+            return Branch(vpath.pop())
+        return vpath
+
+    @cherrypy.expose
+    def index(self):
+        return self._template.render(names=self._names)
+
+
+class Issue:
+    _template = _template_env.get_template('issue.html')
+
+    def __init__(self, cve_id):
+        self._cve_id = cve_id
+
+    @cherrypy.expose
+    def index(self):
+        return self._template.render(cve_id=self._cve_id,
+                                     issue=_issue_cache[self._cve_id])
+
+
+class Issues:
+    _template = _template_env.get_template('issues.html')
+
+    def _cp_dispatch(self, vpath):
+        if len(vpath) == 1 and vpath[0] in _issue_cache:
+            return Issue(vpath.pop())
+        return vpath
+
+    @cherrypy.expose
+    def index(self):
+        return self._template.render(
+            cve_ids=sorted(_issue_cache.keys(),
+                           key=kernel_sec.issue.get_id_sort_key))
+
+
+class Root:
+    _template = _template_env.get_template('root.html')
+
+    def __init__(self, git_repo, mainline_remote_name, stable_remote_name):
+        self.branches = Branches(git_repo, mainline_remote_name,
+                                 stable_remote_name)
+        self.issues = Issues()
+
+    def _cp_dispatch(self, vpath):
+        if vpath[0] == 'branch':
+            vpath.pop(0)
+            return self.branches
+        if vpath[0] == 'issue':
+            vpath.pop(0)
+            return self.issues
+        return vpath
+
+    @cherrypy.expose
+    def index(self):
+        return self._template.render()
+
+
+if __name__ == '__main__':
+    parser = argparse.ArgumentParser(
+        description='Report unfixed CVEs in Linux kernel branches.')
+    parser.add_argument('--git-repo',
+                        dest='git_repo', default='../kernel',
+                        help='git repository from which to read commit logs (default: ../kernel)',
+                        metavar='DIRECTORY')
+    parser.add_argument('--mainline-remote',
+                        dest='mainline_remote_name', default='torvalds',
+                        help='git remote for mainline (default: torvalds)',
+                        metavar='NAME')
+    parser.add_argument('--stable-remote',
+                        dest='stable_remote_name', default='stable',
+                        help='git remote for stable branches (default: stable)',
+                        metavar='NAME')
+    args = parser.parse_args()
+    cherrypy.quickstart(Root(args.git_repo, args.mainline_remote_name,
+                             args.stable_remote_name))



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/76ee2952bc74b4e19ff34c83410c668fd3e93711...58186e1acfa101dcba098736188ba445fb23fcd7

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/76ee2952bc74b4e19ff34c83410c668fd3e93711...58186e1acfa101dcba098736188ba445fb23fcd7
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20181114/94244445/attachment-0001.html>

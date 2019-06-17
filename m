From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Mon, 17 Jun 2019 14:21:26 +0900
Subject: [cip-dev] [cip-kernel-sec 1/2] remotes: automatically add remotes
	from configuration file
Message-ID: <20190617052127.9571-1-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Currently the user is required to create its own remotes by
hand. This should not be necessary, because the information
is already collected in conf/remotes.yml. For that reason,
if we detect that any remote has not been added to the
local repo then we will add those.

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 README.md                    | 5 +++--
 conf/remotes.yml             | 9 ++++++---
 scripts/import_stable.py     | 9 +++++++++
 scripts/templates/issue.html | 7 ++++---
 4 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/README.md b/README.md
index 4c5808f..dda94a8 100644
--- a/README.md
+++ b/README.md
@@ -77,8 +77,9 @@ These files, if they exist, contain a mapping where the keys
 are default git remote names.  The values are also mappings,
 with the keys:
 
-* `commit_url_prefix`: URL prefix for browsing a commit on a
-  branch from this remote.
+* `git_repo_url`: URL of the remote repository.
+* `commit_url_suffix`: URL suffix that gets appended to `git_repo_url`
+  for browsing a commit on a branch from this remote.
 * `git_name`: (optional) The name actually used for this git
   remote, if it's different from the default.
 
diff --git a/conf/remotes.yml b/conf/remotes.yml
index 51c523d..446bb15 100644
--- a/conf/remotes.yml
+++ b/conf/remotes.yml
@@ -1,6 +1,9 @@
 torvalds:
-  commit_url_prefix: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=
+  git_repo_url: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
+  commit_url_suffix: /commit/?id=
 stable:
-  commit_url_prefix: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit?id=
+  git_repo_url: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
+  commit_url_suffix: /commit?id=
 cip:
-  commit_url_prefix: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit?id=
+  git_repo_url: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
+  commit_url_suffix: /commit?id=
diff --git a/scripts/import_stable.py b/scripts/import_stable.py
index b3261cf..26e45a9 100755
--- a/scripts/import_stable.py
+++ b/scripts/import_stable.py
@@ -35,6 +35,9 @@ def update(git_repo, remote_name):
     subprocess.check_call(['git', 'remote', 'update', remote_name],
                           cwd=git_repo)
 
+def add(git_repo, remote_name, remote_url):
+    subprocess.check_call(['git', 'remote', 'add', remote_name, remote_url],
+                          cwd=git_repo)
 
 def get_backports(git_repo, remotes, branches, debug=False):
     backports = {}
@@ -140,6 +143,12 @@ def main(git_repo, remotes, debug=False):
     remote_names = set(branch['git_remote'] for branch in branches)
 
     for remote_name in remote_names:
+        import sys
+        current_remotes = subprocess.check_output(['git', 'remote', 'show'],
+            cwd=git_repo).decode(sys.stdout.encoding).strip().split('\n')
+        if remote_name not in current_remotes:
+            add(git_repo, remotes[remote_name]['git_name'],
+                remotes[remote_name]['git_repo_url'])
         update(git_repo, remotes[remote_name]['git_name'])
     backports = get_backports(git_repo, remotes, branches, debug)
     c_b_map = kernel_sec.branch.CommitBranchMap(git_repo, remotes, branches)
diff --git a/scripts/templates/issue.html b/scripts/templates/issue.html
index a3286e1..de42753 100644
--- a/scripts/templates/issue.html
+++ b/scripts/templates/issue.html
@@ -75,7 +75,8 @@
     <th rowspan={{ branches|length }}>Status</th>
     {% for branch, affected in branches %}
     {% set name = branch.short_name %}
-    {% set url_prefix = remotes[branch.git_remote].commit_url_prefix %}
+    {% set git_repo_url = remotes[branch.git_remote].git_repo_url %}
+    {% set url_suffix = remotes[branch.git_remote].commit_url_suffix %}
     <th>
       <a href="/branch/{{ name }}/">{{ name }}</a>
     </th>
@@ -84,7 +85,7 @@
       {% if issue['fixed-by'] and issue['fixed-by'][name] and issue['fixed-by'][name] != 'never' %}
       <span class="good">fixed</span> by
       {% for commit in issue['fixed-by'][name] %}
-      <a href="{{ url_prefix }}{{ commit }}">{{ commit[:12] }}</a>{% if not loop.last %},{% endif %}
+      <a href="{{ git_repo_url }}{{ url_suffix }}{{ commit }}">{{ commit[:12] }}</a>{% if not loop.last %},{% endif %}
       {% endfor %}
       {% else %}
       <span class="good">never affected</span>
@@ -98,7 +99,7 @@
       {% if issue['introduced-by'] and issue['introduced-by'][name] and issue['introduced-by'][name] != 'never' %}
       - introduced by
       {% for commit in issue['introduced-by'][name] %}
-      <a href="{{ url_prefix }}{{ commit }}">{{ commit[:12] }}</a>{% if not loop.last %},{% endif %}
+      <a href="{{ git_repo_url }}{{ url_suffix }}{{ commit }}">{{ commit[:12] }}</a>{% if not loop.last %},{% endif %}
       {% endfor %}
       {% endif %}
       {% endif %}
-- 
2.17.1

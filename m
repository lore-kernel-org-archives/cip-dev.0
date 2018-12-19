From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Wed, 19 Dec 2018 16:07:57 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 4
 commits: kernel_sec.branch: Create import directory before branches cache
Message-ID: <5c1a6cdd68016_6fc03f90498cbdc438787@sidekiq-asap-01-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
e77a4ade by Ben Hutchings at 2018-12-19T15:09:00Z
kernel_sec.branch: Create import directory before branches cache

- - - - -
10d08339 by Ben Hutchings at 2018-12-19T15:54:55Z
kernel_sec.issue: Explicitly use UTF-8 encoding for YAML files

By default, the encoding is locale-dependent.

- - - - -
5f62ad65 by Ben Hutchings at 2018-12-19T15:59:17Z
README.md: Document the need for a kernel git repository

- - - - -
45b595b9 by Ben Hutchings at 2018-12-19T16:03:20Z
README.md: Document that import_ubuntu.py needs Bazaar-NG

- - - - -


3 changed files:

- README.md
- scripts/kernel_sec/branch.py
- scripts/kernel_sec/issue.py


Changes:

=====================================
README.md
=====================================
@@ -17,6 +17,11 @@ subdirectory.  Supporting modules are in the `kernel_sec` subdirectory
 beneath that.  They require PyYAML and html5lib (packaged in Debian as
 python3-yaml and python3-html5lib).
 
+Many scripts require access to a kernel git repository.  By default
+this is assumed to be in `../kernel`, with remotes named `torvalds`
+and `stable` for the mainline and stable repositories.  These can
+be overridden by command-line options.
+
 * `scripts/import_debian.py` - import information from Debian's
 `kernel_sec` project.  It includes all issues that Debian considers
 active or that are already tracked here.
@@ -26,6 +31,7 @@ active or that are already tracked here.
 marked as affecting the 'linux' package and don't have the word
 'Android' in the description, and that are either dated from the
 current or previous year or that are already tracked here.
+It requires Bazaar-NG (bzr) to be installed and configured.
 
 * `scripts/import_stable.py` - import information about backports
 to stable by reading the git commit logs.


=====================================
scripts/kernel_sec/branch.py
=====================================
@@ -105,6 +105,7 @@ def get_live_stable_branches():
             return branches
         raise
 
+    os.makedirs('import', 0o777, exist_ok=True)
     with open('import/branches.yml', 'w') as f:
         yaml.safe_dump(branches, f)
     return branches


=====================================
scripts/kernel_sec/issue.py
=====================================
@@ -265,12 +265,12 @@ _IssueLoader.add_constructor('tag:yaml.org,2002:timestamp',
 
 
 def load_filename(name):
-    with open(name) as f:
+    with open(name, 'r', encoding='utf-8') as f:
         return yaml.load(f, Loader=_IssueLoader)
 
 
 def save_filename(name, issue):
-    with open(name, 'w') as f:
+    with open(name, 'w', encoding='utf-8') as f:
         yaml.dump(issue, f, Dumper=_IssueDumper)
 
 



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/9f9d70405033878c810b65e392d382c674765300...45b595b96c7783ede7e743212368da373a20b6c8

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/9f9d70405033878c810b65e392d382c674765300...45b595b96c7783ede7e743212368da373a20b6c8
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20181219/61852ac3/attachment-0001.html>

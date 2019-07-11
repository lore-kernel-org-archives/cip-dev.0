From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Thu, 11 Jul 2019 15:04:15 +0900
Subject: [cip-dev] [cip-kernel-sec][Quickstart v2] docs: add a quickstart
	with practical information
In-Reply-To: <20190711060415.17484-1-daniel.sangorrin@toshiba.co.jp>
References: <Quickstart fixes>
	<20190711060415.17484-1-daniel.sangorrin@toshiba.co.jp>
Message-ID: <20190711060415.17484-2-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Although the README already contains all the information
that users may need, there are some bits of know-how that
are better expressed through a step-by-step quickstart or
tutorial. This files tries to fill that gap.

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 QUICKSTART.md | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 QUICKSTART.md

diff --git a/QUICKSTART.md b/QUICKSTART.md
new file mode 100644
index 0000000..c79af41
--- /dev/null
+++ b/QUICKSTART.md
@@ -0,0 +1,132 @@
+# Quickstart
+
+## Overview
+
+This project tracks the status of CVEs in mainline and stable kernels. Each CVE is described in YAML format that includes data such as:
+
+```
+$ cat issues/CVE-2019-1999.yml
+description: 'binder: fix race between munmap() and direct reclaim'
+references:
+- https://source.android.com/security/bulletin/2019-02-01
+comments:
+  Debian-bwh: |-
+    Introduced in 4.14 by f2517eb76f1f "android: binder: Add global lru
+    shrinker to binder".  Backports of the fix to stable have incorrect
+    metadata.
+  bwh: Backports to stable have incorrect metadata
+introduced-by:
+  mainline: [f2517eb76f1f2f7f89761f9db2b202e89931738c]
+fixed-by:
+  linux-4.14.y: [33c6b9ca70a8b066a613e2a3d0331ae8f82aa31a]
+  linux-4.19.y: [6bf7d3c5c0c5dad650bfc4345ed553c18b69d59e]
+  linux-5.0.y: [bbb19ca082ce27ce60ca65be016a951806ea947c]
+  mainline: [5cec2d2e5839f9c0fec319c523a911e0a7fd299f]
+```
+
+## Quickstart
+
+Clone `cip-kernel-sec` and install its dependencies:
+
+```
+$ git clone https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec
+$ cd cip-kernel-sec/
+$ sudo apt install python3-yaml python3-html5lib python3-cherrypy3 python3-jinja2
+```
+
+Prepare kernel remote repositories according to `conf/remotes.yml`:
+
+```
+$ ./scripts/prepare_remotes.py
+```
+
+Alternatively, you can do that manually:
+
+```
+$ mkdir ../kernel
+$ cd ../kernel
+$ git remote add torvalds https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
+$ git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
+$ git remote add cip https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
+$ cd ../cip-kernel-sec
+```
+
+Download CVE information from [Debian] (https://salsa.debian.org/kernel-team/kernel-sec.git), [Ubuntu]  (https://git.launchpad.net/ubuntu-cve-tracker) and Stable:
+
+```
+
+$ ./scripts/import_debian.py
+	-> import/debian
+$ ./scripts/import_ubuntu.py
+	-> import/ubuntu
+$ ./scripts/import_stable.py
+	-> import/stable_branches.yml
+```
+
+Check issues that affect a linux-cip branch:
+
+```
+$ ./scripts/report_affected.py linux-4.4.y
+```
+
+You can show a short description on your report:
+
+```
+$ ./scripts/report_affected.py --show-description linux-4.4.y
+```
+
+Check issues that affect a tag:
+
+```
+$ ./scripts/report_affected.py v4.4.181-cip33
+```
+
+Browse kernel branches and issues interactively:
+
+```
+$ ./scripts/webview.py
+$ firefox http://localhost:8080
+```
+
+[Note] Use Ctr-c to stop the `webview.py` script.
+
+## Kernel maintainer workflow
+
+Import or update the latest CVE information:
+
+```
+$ ./scripts/import_debian.py
+$ ./scripts/import_ubuntu.py
+$ ./scripts/import_stable.py
+```
+
+Edit by hand the newly created issues if you see that some imported information is incorrect or there is missing information:
+
+```
+$ vi issues/CVE-xx.yml
+```
+
+Validate the issue files against the YAML schema.
+
+```
+$ ./scripts/validate.py
+```
+
+YAML allows the same thing to be written in different ways, e.g. bracketed vs bulleted lists. Use `cleanup.py` to make the syntax and ordering of items consistent with the importers, to reduce "noise" in diffs:
+
+```
+$ ./scripts/cleanup.py
+```
+
+Check if the current issues:
+
+```
+$ ./scripts/report_affected.py
+```
+
+## Changelog
+
+- 20190614: First version <daniel.sangorrin@toshiba.co.jp>
+- 20190618: Add workflow information provided by Ben
+- 20190711: Add tag reporting <daniel.sangorrin@toshiba.co.jp>
+
-- 
2.17.1

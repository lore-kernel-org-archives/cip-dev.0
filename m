From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Mon, 03 Jun 2019 14:06:37 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master]
 README.md: Mention configurable branches and remotes in more places
Message-ID: <5cf5296d99f90_4c233f8e6abade742783147@sidekiq-asap-01-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
5e2a0e07 by Ben Hutchings at 2019-06-03T14:06:32Z
README.md: Mention configurable branches and remotes in more places

- - - - -


1 changed file:

- README.md


Changes:

=====================================
README.md
=====================================
@@ -1,7 +1,7 @@
 # kernel-sec - Linux kernel CVE tracker
 
 This project tracks the status of security issues, identified by CVE
-ID, in mainline and in stable branches.
+ID, in mainline, stable, and other configured branches.
 
 ## Issue format
 
@@ -20,7 +20,7 @@ python3-yaml and python3-html5lib).
 Many scripts require access to a kernel git repository.  By default
 this is assumed to be in `../kernel`, with remotes named `torvalds`
 and `stable` for the mainline and stable repositories.  These can
-be overridden by command-line options.
+be overridden by command-line options or by configuration.
 
 * `scripts/import_debian.py` - import information from Debian's
 `kernel_sec` project.  It includes all issues that Debian considers
@@ -32,8 +32,8 @@ marked as affecting the 'linux' package and don't have the word
 'Android' in the description, and that are either dated from the
 current or previous year or that are already tracked here.
 
-* `scripts/import_stable.py` - import information about backports
-to stable by reading the git commit logs.
+* `scripts/import_stable.py` - import information about backports to
+stable and other configured branches, by reading the git commit logs.
 
 * `scripts/report_affected.py` - report which issues affect the
 specified branches, or all active branches.



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/5e2a0e07317efd9623d7d87c752d1d8082c13ccb

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/5e2a0e07317efd9623d7d87c752d1d8082c13ccb
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190603/83bcf847/attachment.html>

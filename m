From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Wed, 17 Jul 2019 22:24:57 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] Mark
 some issues to be ignored for 4.4
Message-ID: <5d2fa0393cd9c_1d083ff8665ec9ac1203612@sidekiq-asap-01-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
7c70981f by Ben Hutchings at 2019-07-17T22:24:27Z
Mark some issues to be ignored for 4.4

- - - - -


3 changed files:

- issues/CVE-2018-3646.yml
- issues/CVE-2018-ebpf-filter-dos.yml
- issues/CVE-2019-2054.yml


Changes:

=====================================
issues/CVE-2018-3646.yml
=====================================
@@ -177,3 +177,6 @@ fixed-by:
     07d981ad4cf1e78361c6db1c28ee5ba105f96cc1]
 ignore:
   linux-3.16.y: Too invasive and risky to apply
+  linux-4.4.y: Too invasive and risky to apply
+  linux-4.4.y-cip: Too invasive and risky to apply
+  linux-4.4.y-cip-rt: Too invasive and risky to apply


=====================================
issues/CVE-2018-ebpf-filter-dos.yml
=====================================
@@ -20,3 +20,4 @@ fixed-by:
 ignore:
   linux-4.4.y: Unprivileged BPF JIT should not be enabled
   linux-4.4.y-cip: Unprivileged BPF JIT should not be enabled
+  linux-4.4.y-cip-rt: Unprivileged BPF JIT should not be enabled


=====================================
issues/CVE-2019-2054.yml
=====================================
@@ -10,3 +10,6 @@ fixed-by:
   mainline: [0f3912fd934cdfd03d93f2dc6f064099795bf638]
 ignore:
   linux-3.16.y: Documented limitation
+  linux-4.4.y: Documented limitation
+  linux-4.4.y-cip: Documented limitation
+  linux-4.4.y-cip-rt: Documented limitation



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/7c70981f1d20c195ca397c0af9ea64d8a8d98362

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/7c70981f1d20c195ca397c0af9ea64d8a8d98362
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190717/2aac48ad/attachment-0001.html>

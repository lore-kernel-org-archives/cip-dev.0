From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Mon, 22 Jul 2019 20:10:04 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master]
	Import more data
Message-ID: <5d36181c9e5e3_2ac33fe7d5c921f417612f7@sidekiq-asap-10-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
87656eff by Ben Hutchings at 2019-07-22T20:09:29Z
Import more data

- - - - -


5 changed files:

- issues/CVE-2019-10126.yml
- + issues/CVE-2019-13272.yml
- + issues/CVE-2019-13631.yml
- + issues/CVE-2019-13648.yml
- issues/CVE-2019-3846.yml


Changes:

=====================================
issues/CVE-2019-10126.yml
=====================================
@@ -5,6 +5,9 @@ references:
 - https://marc.info/?l=oss-security&m=155965912410053&w=2
 fixed-by:
   linux-3.16.y: [a62393d7eb63bd075c51154002825cc7ab4dd3eb]
+  linux-4.14.y: [b1459fb34061337efbf0d47a3ba6208f2f59829d]
   linux-4.19.y: [c7e427e28a3a2d1b89b8f9fa7c3f559774d91a7b]
+  linux-4.4.y: [3a611df229a90247c9a5159d136c60f4008c29a2]
+  linux-4.9.y: [f70d411e2ecd1f8297e1fd7e91108ca220986784]
   linux-5.1.y: [e9111176d9c195ba709245f1bf1d3d1dae5cd22a]
   mainline: [69ae4f6aac1578575126319d3f55550e7e440449]


=====================================
issues/CVE-2019-13272.yml
=====================================
@@ -0,0 +1,32 @@
+description: 'ptrace: Fix ->ptracer_cred handling for PTRACE_TRACEME'
+references:
+- https://bugzilla.suse.com/show_bug.cgi?id=1140671
+- https://bugs.chromium.org/p/project-zero/issues/detail?id=1903
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13272
+- http://packetstormsecurity.com/files/153663/Linux-PTRACE_TRACEME-Broken-Permission-Object-Lifetime-Handling.html
+- https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=6994eefb0053799d2e07cd140df6c2ea106c41ee
+- https://bugzilla.redhat.com/show_bug.cgi?id=1730895
+comments:
+  Debian-carnil: |-
+    64b875f7ac8a ("ptrace: Capture the ptracer's creds not
+    PT_PTRACE_CAP") which is in 4.10 was backported to older stable
+    series as well, got included in v4.9.32
+reporters:
+- Jann Horn
+introduced-by:
+  linux-3.16.y: [d55a94ed03a24794d47f80d5300825f6c095a0a7]
+  linux-4.4.y: [1c1f15f8ebfbd5042883a1c9ae4b18a6299c9c5f]
+  linux-4.4.y-cip: [1c1f15f8ebfbd5042883a1c9ae4b18a6299c9c5f]
+  linux-4.4.y-cip-rt: [1c1f15f8ebfbd5042883a1c9ae4b18a6299c9c5f]
+  linux-4.9.y: [e747b4ae3b6bca205d82e86366e140cdcbfb7731]
+  mainline: [64b875f7ac8a5d60a4e191479299e931ee949b67]
+fixed-by:
+  linux-4.14.y: [bf71ef9655d25e8b275ec6ed649b6bd719231ddc]
+  linux-4.19.y: [54435b7fff7bfb9515cc457b71c3734c1c3fff76]
+  linux-4.19.y-cip: [54435b7fff7bfb9515cc457b71c3734c1c3fff76]
+  linux-4.4.y: [54562d2b0be5c120b01c8bb94baef1aca37fd329]
+  linux-4.4.y-cip: [54562d2b0be5c120b01c8bb94baef1aca37fd329]
+  linux-4.4.y-cip-rt: [54562d2b0be5c120b01c8bb94baef1aca37fd329]
+  linux-4.9.y: [d8b99303da935228a33fa7656a964adfb33e271b]
+  linux-5.1.y: [49887fc3f2a7e6185777af3a9c96095aeb2bce1b]
+  mainline: [6994eefb0053799d2e07cd140df6c2ea106c41ee]


=====================================
issues/CVE-2019-13631.yml
=====================================
@@ -0,0 +1,8 @@
+description: 'Input: gtco - bounds check collection indent level'
+references:
+- https://patchwork.kernel.org/patch/11040813/
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13631
+introduced-by:
+  mainline: [a19ceb56cbd1e1beff3e9cf6042e1f31f6487aa6]
+fixed-by:
+  mainline: [2a017fd82c5402b3c8df5e3d6e5165d9e6147dc1]


=====================================
issues/CVE-2019-13648.yml
=====================================
@@ -0,0 +1,4 @@
+description: 'powerpc/tm: Fix oops on sigreturn on systems without TM'
+references:
+- https://patchwork.ozlabs.org/patch/1133904/
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13648


=====================================
issues/CVE-2019-3846.yml
=====================================
@@ -9,6 +9,9 @@ introduced-by:
   mainline: [5e6e3a92b9a4c9416b17f468fa5c7fa2233b8b4e]
 fixed-by:
   linux-3.16.y: [a24ac7326f38ffab2b63141496d075da144cec7d]
+  linux-4.14.y: [d50f6b58d7ad30ad8e96c0bbc3e5ecfe9b91ba77]
   linux-4.19.y: [d4c0f752c1d2c6383cc7582c19b2ed7159d45937]
+  linux-4.4.y: [5d43b417e60ab25984fc7c41175f3ce8cee992bd]
+  linux-4.9.y: [58ec3690a908494f7a7c3e8a302eb491bef9d979]
   linux-5.1.y: [cb48f5e50582bf44f63599b78941b325a17fa1ec]
   mainline: [13ec7f10b87f5fc04c4ccbd491c94c7980236a74]



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/87656eff4b84a515652b7abf25fd203b99dc43e7

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/87656eff4b84a515652b7abf25fd203b99dc43e7
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190722/59b6b389/attachment-0001.html>

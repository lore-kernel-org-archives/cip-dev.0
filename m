From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Sun, 28 Jul 2019 22:52:23 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master]
	Import more data
Message-ID: <5d3e2727536a8_48483ff3fd864f80589d3@sidekiq-asap-09-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
ceaff914 by Ben Hutchings at 2019-07-28T22:52:16Z
Import more data

- - - - -


24 changed files:

- + issues/CVE-2017-18379.yml
- issues/CVE-2018-20836.yml
- + issues/CVE-2018-20854.yml
- + issues/CVE-2018-20855.yml
- + issues/CVE-2018-20856.yml
- issues/CVE-2019-10126.yml
- issues/CVE-2019-10142.yml
- + issues/CVE-2019-10207.yml
- issues/CVE-2019-10638.yml
- issues/CVE-2019-10639.yml
- issues/CVE-2019-11085.yml
- issues/CVE-2019-11487.yml
- issues/CVE-2019-11599.yml
- issues/CVE-2019-11815.yml
- issues/CVE-2019-11833.yml
- issues/CVE-2019-11884.yml
- issues/CVE-2019-12456.yml
- issues/CVE-2019-13272.yml
- issues/CVE-2019-13631.yml
- issues/CVE-2019-13648.yml
- + issues/CVE-2019-14283.yml
- + issues/CVE-2019-14284.yml
- issues/CVE-2019-3846.yml
- issues/CVE-2019-9503.yml


Changes:

=====================================
issues/CVE-2017-18379.yml
=====================================
@@ -0,0 +1,3 @@
+description: 'nvmet-fc: ensure target queue id within range'
+fixed-by:
+  mainline: [0c319d3a144d4b8f1ea2047fd614d2149b68f889]


=====================================
issues/CVE-2018-20836.yml
=====================================
@@ -2,6 +2,7 @@ description: 'scsi: libsas: fix a race condition when smp task timeout'
 references:
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20836
 - https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=b90cd6f2b905905fb42671009dc0e27c310a16ae
+- https://usn.ubuntu.com/usn/usn-4076-1
 comments:
   Debian-bwh: |-
     Note that the fix depends on the low-level device drivers setting the


=====================================
issues/CVE-2018-20854.yml
=====================================
@@ -0,0 +1,8 @@
+description: |-
+  An issue was discovered in the Linux kernel before 4.20.
+  drivers/phy/mscc/phy-ocelot-serdes.c has an off-by-one error with a
+  resultant ctrl->phys out-of-bounds read.
+references:
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20854
+- https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=6acb47d1a318e5b3b7115354ebc4ea060c59d3a1
+- https://github.com/torvalds/linux/commit/6acb47d1a318e5b3b7115354ebc4ea060c59d3a1


=====================================
issues/CVE-2018-20855.yml
=====================================
@@ -0,0 +1,8 @@
+description: 'IB/mlx5: Fix leaking stack memory to userspace'
+references:
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20855
+- https://cdn.kernel.org/pub/linux/kernel/v4.x/ChangeLog-4.18.7
+- https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=0625b4ba1a5d4703c7fb01c497bd6c156908af00
+- https://github.com/torvalds/linux/commit/0625b4ba1a5d4703c7fb01c497bd6c156908af00
+fixed-by:
+  mainline: [0625b4ba1a5d4703c7fb01c497bd6c156908af00]


=====================================
issues/CVE-2018-20856.yml
=====================================
@@ -0,0 +1,9 @@
+description: 'block: blk_init_allocated_queue() set q->fq as NULL in the fail case'
+references:
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20856
+- https://cdn.kernel.org/pub/linux/kernel/v4.x/ChangeLog-4.18.7
+- https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=54648cf1ec2d7f4b6a71767799c45676a138ca24
+- https://github.com/torvalds/linux/commit/54648cf1ec2d7f4b6a71767799c45676a138ca24
+fixed-by:
+  linux-4.14.y: [0affbaece6d0b7c75c5166732d0481ae9a28be60]
+  mainline: [54648cf1ec2d7f4b6a71767799c45676a138ca24]


=====================================
issues/CVE-2019-10126.yml
=====================================
@@ -7,6 +7,7 @@ fixed-by:
   linux-3.16.y: [a62393d7eb63bd075c51154002825cc7ab4dd3eb]
   linux-4.14.y: [b1459fb34061337efbf0d47a3ba6208f2f59829d]
   linux-4.19.y: [c7e427e28a3a2d1b89b8f9fa7c3f559774d91a7b]
+  linux-4.19.y-cip: [c7e427e28a3a2d1b89b8f9fa7c3f559774d91a7b]
   linux-4.4.y: [3a611df229a90247c9a5159d136c60f4008c29a2]
   linux-4.9.y: [f70d411e2ecd1f8297e1fd7e91108ca220986784]
   linux-5.1.y: [e9111176d9c195ba709245f1bf1d3d1dae5cd22a]


=====================================
issues/CVE-2019-10142.yml
=====================================
@@ -4,6 +4,7 @@ references:
 - https://www.openwall.com/lists/oss-security/2019/05/22/5
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-10142
 - https://bugzilla.redhat.com/show_bug.cgi?id=CVE-2019-10142
+- https://usn.ubuntu.com/usn/usn-4076-1
 comments:
   Debian-carnil: CONFIG_FSL_HV_MANAGER not enabled, so only affected source-wise.
   Ubuntu-sbeattie: depends on freescale (ppc) only


=====================================
issues/CVE-2019-10207.yml
=====================================
@@ -0,0 +1,4 @@
+description: 'bluetooth: hci_uart: 0x0 address  execution as nonprivileged user'
+references:
+- https://www.openwall.com/lists/oss-security/2019/07/25/1
+- https://lore.kernel.org/linux-bluetooth/20190725120909.31235-1-vdronov at redhat.com/T/#u


=====================================
issues/CVE-2019-10638.yml
=====================================
@@ -15,6 +15,12 @@ comments:
     Versions older than 4.1 might need 55f0fc7a02de ("inet: update
     the IP ID generation algorithm to higher standards.").
     This needs clarifying on the fixing commits.
+  Ubuntu-tyhicks: |-
+    Kernels prior to 4.1 also need the following commit
+     https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-3.16.y&id=8b197d3ce585d6777197e0633d71e5af7d98cb35
+reporters:
+- Amit Klein
+- Benny Pinkas
 fixed-by:
   linux-3.16.y: [188da790e1f4d164bcfdea486e91fd47e1ba59c5]
   linux-4.14.y: [adbb8bdd392db14dc80ad1ac29f8f1d37ab57a62]


=====================================
issues/CVE-2019-10639.yml
=====================================
@@ -12,6 +12,11 @@ comments:
     leak through IPv4 IDs since commit b6a7719aedd7 "ipv4: hash net ptr
     into fragmentation bucket selection" in Linux 4.1.  However, other
     uses may also leak the address in 3.16.
+reporters:
+- Amit Klein
+- Benny Pinkas
+introduced-by:
+  mainline: [0b4419162aa6c4204843f3a13b48d9ab821d3167]
 fixed-by:
   linux-3.16.y: [188da790e1f4d164bcfdea486e91fd47e1ba59c5]
   linux-4.14.y: [adbb8bdd392db14dc80ad1ac29f8f1d37ab57a62]


=====================================
issues/CVE-2019-11085.yml
=====================================
@@ -6,6 +6,8 @@ references:
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11085
 - https://git.kernel.org/linus/51b00d8509dc69c98740da2ad07308b630d3eb7d
 - https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00249.html
+- https://usn.ubuntu.com/usn/usn-4068-1
+- https://usn.ubuntu.com/usn/usn-4068-2
 comments:
   Debian-carnil: |-
     Commit fixes 659643f7d814 ("drm/i915/gvt/kvmgt: add vfio/mdev


=====================================
issues/CVE-2019-11487.yml
=====================================
@@ -13,6 +13,7 @@ references:
 - https://github.com/torvalds/linux/commit/88b1a17dfc3ed7728316478fae0f5ad508f50397
 - https://github.com/torvalds/linux/commit/8fde12ca79aff9b5ba951fce1a2641901b8d8e64
 - https://github.com/torvalds/linux/commit/f958d7b528b1b40c44cfda5eabe2d82760d868c3
+- https://usn.ubuntu.com/usn/usn-4069-1
 comments:
   Debian-bwh: |-
     I'm having trouble backporting to this to 3.16 because we don't


=====================================
issues/CVE-2019-11599.yml
=====================================
@@ -7,6 +7,7 @@ references:
 - http://www.openwall.com/lists/oss-security/2019/04/29/1
 - http://www.openwall.com/lists/oss-security/2019/04/29/2
 - https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=04f5866e41fb70690e28397487d8bd8eea7d712a
+- https://usn.ubuntu.com/usn/usn-4069-1
 comments:
   Debian-bwh: |-
     The backports to 4.4 and 4.9 are still under discussion.


=====================================
issues/CVE-2019-11815.yml
=====================================
@@ -9,6 +9,8 @@ references:
 - https://usn.ubuntu.com/usn/usn-4005-1
 - https://usn.ubuntu.com/usn/usn-4008-1
 - https://usn.ubuntu.com/usn/usn-4008-3
+- https://usn.ubuntu.com/usn/usn-4068-1
+- https://usn.ubuntu.com/usn/usn-4068-2
 comments:
   Debian-bwh: |-
     Introduced in 4.3 by commit 467fa15356ac "RDS-TCP: Support multiple


=====================================
issues/CVE-2019-11833.yml
=====================================
@@ -3,6 +3,10 @@ references:
 - https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?id=592acbf16821288ecdc4192c47e3774a4c48bb64
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11833
 - https://github.com/torvalds/linux/commit/592acbf16821288ecdc4192c47e3774a4c48bb64
+- https://usn.ubuntu.com/usn/usn-4068-1
+- https://usn.ubuntu.com/usn/usn-4068-2
+- https://usn.ubuntu.com/usn/usn-4069-1
+- https://usn.ubuntu.com/usn/usn-4076-1
 introduced-by:
   mainline: [a86c61812637c7dd0c57e29880cffd477b62f2e7]
 fixed-by:


=====================================
issues/CVE-2019-11884.yml
=====================================
@@ -4,6 +4,10 @@ references:
 - https://git.kernel.org/linus/a1616a5ac99ede5d605047a9012481ce7ff18b16
 - https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.0.15
 - https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=a1616a5ac99ede5d605047a9012481ce7ff18b16
+- https://usn.ubuntu.com/usn/usn-4068-1
+- https://usn.ubuntu.com/usn/usn-4068-2
+- https://usn.ubuntu.com/usn/usn-4069-1
+- https://usn.ubuntu.com/usn/usn-4076-1
 comments:
   Debian-carnil: similar issue to CVE-2011-1079.
 fixed-by:


=====================================
issues/CVE-2019-12456.yml
=====================================
@@ -10,6 +10,7 @@ references:
 - https://lkml.org/lkml/2019/5/29/1164
 - https://bugzilla.redhat.com/show_bug.cgi?id=1717182#c3
 comments:
+  Debian-bwh: The double-fetched value is not used after the second fetch
   Ubuntu-tyhicks: |-
     There seems to be no security impact as the ioc_number is never used
      after the "double fetch"


=====================================
issues/CVE-2019-13272.yml
=====================================
@@ -21,6 +21,7 @@ introduced-by:
   linux-4.9.y: [e747b4ae3b6bca205d82e86366e140cdcbfb7731]
   mainline: [64b875f7ac8a5d60a4e191479299e931ee949b67]
 fixed-by:
+  linux-3.16.y: [d5d5bd909a4f03f132ee3fd3f6f0568c8344eee5]
   linux-4.14.y: [bf71ef9655d25e8b275ec6ed649b6bd719231ddc]
   linux-4.19.y: [54435b7fff7bfb9515cc457b71c3734c1c3fff76]
   linux-4.19.y-cip: [54435b7fff7bfb9515cc457b71c3734c1c3fff76]


=====================================
issues/CVE-2019-13631.yml
=====================================
@@ -5,4 +5,6 @@ references:
 introduced-by:
   mainline: [a19ceb56cbd1e1beff3e9cf6042e1f31f6487aa6]
 fixed-by:
+  linux-4.19.y: [d657077eda7b5572d86f2f618391bb016b5d9a64]
+  linux-5.2.y: [63fabf4287b23da069986b7a7fdc6ad0b202f00a]
   mainline: [2a017fd82c5402b3c8df5e3d6e5165d9e6147dc1]


=====================================
issues/CVE-2019-13648.yml
=====================================
@@ -2,3 +2,13 @@ description: 'powerpc/tm: Fix oops on sigreturn on systems without TM'
 references:
 - https://patchwork.ozlabs.org/patch/1133904/
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13648
+comments:
+  Debian-bwh: |-
+    We have disabled CONFIG_PPC_TRANSACTIONAL_MEM in 4.9.184-1 for
+    other reasons, which I think will also fix this.
+reporters:
+- Praveen Pandey
+introduced-by:
+  mainline: [2b0a576d15e0e14751f00f9c87e46bad27f217e7]
+fixed-by:
+  mainline: [f16d80b75a096c52354c6e0a574993f3b0dfbdfe]


=====================================
issues/CVE-2019-14283.yml
=====================================
@@ -0,0 +1,5 @@
+description: 'floppy: fix out-of-bounds read in copy_buffer'
+fixed-by:
+  linux-4.19.y: [ff54c44f103825a426e46d08b5d3d76e44791a87]
+  linux-5.2.y: [d39c2e97277229970fe2ae56dcbf67a535e14873]
+  mainline: [da99466ac243f15fbba65bd261bfc75ffa1532b6]


=====================================
issues/CVE-2019-14284.yml
=====================================
@@ -0,0 +1,5 @@
+description: 'floppy: fix div-by-zero in setup_format_params'
+fixed-by:
+  linux-4.19.y: [6e34fd07484a0622a17b40e0ca89ed451260ef45]
+  linux-5.2.y: [697c0af7468a941522c1e26345aa5128fa2a4815]
+  mainline: [f3554aeb991214cbfafd17d55e2bfddb50282e32]


=====================================
issues/CVE-2019-3846.yml
=====================================
@@ -11,6 +11,7 @@ fixed-by:
   linux-3.16.y: [a24ac7326f38ffab2b63141496d075da144cec7d]
   linux-4.14.y: [d50f6b58d7ad30ad8e96c0bbc3e5ecfe9b91ba77]
   linux-4.19.y: [d4c0f752c1d2c6383cc7582c19b2ed7159d45937]
+  linux-4.19.y-cip: [d4c0f752c1d2c6383cc7582c19b2ed7159d45937]
   linux-4.4.y: [5d43b417e60ab25984fc7c41175f3ce8cee992bd]
   linux-4.9.y: [58ec3690a908494f7a7c3e8a302eb491bef9d979]
   linux-5.1.y: [cb48f5e50582bf44f63599b78941b325a17fa1ec]


=====================================
issues/CVE-2019-9503.yml
=====================================
@@ -7,6 +7,7 @@ references:
 - https://usn.ubuntu.com/usn/usn-3981-1
 - https://usn.ubuntu.com/usn/usn-3980-2
 - https://usn.ubuntu.com/usn/usn-3981-2
+- https://usn.ubuntu.com/usn/usn-4076-1
 comments:
   Debian-bwh: |-
     For 3.16, a related fix for PCIe and SDIO needs to be applied first:



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/ceaff914a546358bc6325c65e6ae33913c26a7e2

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/ceaff914a546358bc6325c65e6ae33913c26a7e2
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190728/5ab1a4c3/attachment-0001.html>

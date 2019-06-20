From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Thu, 20 Jun 2019 20:26:32 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master]
	Import more data
Message-ID: <5d0bebf82257_470e3fd2b3244620356163@sidekiq-asap-03-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
4975a489 by Ben Hutchings at 2019-06-20T20:26:18Z
Import more data

- - - - -


19 changed files:

- + issues/CVE-2019-0136.yml
- + issues/CVE-2019-0157.yml
- issues/CVE-2019-10142.yml
- + issues/CVE-2019-11477.yml
- + issues/CVE-2019-11478.yml
- + issues/CVE-2019-11479.yml
- issues/CVE-2019-11810.yml
- issues/CVE-2019-11833.yml
- issues/CVE-2019-11884.yml
- issues/CVE-2019-12379.yml
- issues/CVE-2019-12380.yml
- issues/CVE-2019-12382.yml
- issues/CVE-2019-12454.yml
- + issues/CVE-2019-12818.yml
- + issues/CVE-2019-12819.yml
- + issues/CVE-2019-12881.yml
- issues/CVE-2019-3846.yml
- + issues/CVE-2019-3896.yml
- issues/CVE-2019-5489.yml


Changes:

=====================================
issues/CVE-2019-0136.yml
=====================================
@@ -0,0 +1,7 @@
+description: |-
+  Insufficient access control in the Intel(R) PROSet/Wireless WiFi Software
+  driver before version 21.10 may allow an unauthenticated user to
+  potentially enable denial of service via adjacent access.
+references:
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-0136
+- https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00232.html


=====================================
issues/CVE-2019-0157.yml
=====================================
@@ -0,0 +1,7 @@
+description: |-
+  Insufficient input validation in the Intel(R) SGX driver for Linux may
+  allow an authenticated user to potentially enable a denial of service via
+  local access.
+references:
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-0157
+- https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00235.html?wapkw=cve-2019-0157


=====================================
issues/CVE-2019-10142.yml
=====================================
@@ -14,6 +14,7 @@ comments:
 introduced-by:
   mainline: [6db7199407ca56f55bc0832fb124e1ad216ea57b]
 fixed-by:
+  linux-3.16.y: [bfa8c73482dae6bafc0741cbfd63f84d11311b36]
   linux-4.14.y: [1a3a561df5e176a4422270e3d2cca1cd835b292e]
   linux-4.19.y: [e9ec5073c90d6de2ca5338bd67f7935b19d7c0c7]
   linux-4.19.y-cip: [e9ec5073c90d6de2ca5338bd67f7935b19d7c0c7]


=====================================
issues/CVE-2019-11477.yml
=====================================
@@ -0,0 +1,25 @@
+description: DoS through u16 overflow of TCP_SKB_CB(skb)->tcp_gso_segs
+references:
+- https://patchwork.ozlabs.org/patch/1117155/
+- https://github.com/Netflix/security-bulletins/blob/master/advisories/third-party/2019-001.md
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11477
+- https://wiki.ubuntu.com/SecurityTeam/KnowledgeBase/SACKPanic
+- https://usn.ubuntu.com/usn/usn-4017-1
+- https://usn.ubuntu.com/usn/usn-4017-2
+- https://launchpad.net/bugs/1831637
+comments:
+  Ubuntu-tyhicks: Known as "SACK Panic"
+reporters:
+- Jonathan Looney
+introduced-by:
+  mainline: [832d11c5cd076abc0aa1eaf7be96c81d1a59ce41]
+fixed-by:
+  linux-3.16.y: [ef27e3c531782ec8213108e11e5515f9724303c7]
+  linux-4.14.y: [d632920554c5aec81d8a79c23dac07efcbabbd54]
+  linux-4.19.y: [c09be31461ed140976c60a87364415454a2c3d42]
+  linux-4.19.y-cip: [c09be31461ed140976c60a87364415454a2c3d42]
+  linux-4.4.y: [4657ee0fe05e15ab572b157f13a82e080d4b7d73]
+  linux-4.4.y-cip: [4657ee0fe05e15ab572b157f13a82e080d4b7d73]
+  linux-4.9.y: [cc1b58ccb78e0de51bcec1f2914d9296260668bd]
+  linux-5.1.y: [d907a0770bb23deacd7087263aa6e242d91d3075]
+  mainline: [3b4929f65b0d8249f19a50245cd88ed1a2f78cff]


=====================================
issues/CVE-2019-11478.yml
=====================================
@@ -0,0 +1,25 @@
+description: tcp_fragment fragmentation can exceed socket memory limits
+references:
+- https://patchwork.ozlabs.org/patch/1117156/
+- https://github.com/Netflix/security-bulletins/blob/master/advisories/third-party/2019-001.md
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11478
+- https://wiki.ubuntu.com/SecurityTeam/KnowledgeBase/SACKPanic
+- https://usn.ubuntu.com/usn/usn-4017-1
+- https://usn.ubuntu.com/usn/usn-4017-2
+- https://launchpad.net/bugs/1831638
+comments:
+  Ubuntu-tyhicks: |-
+    This vulnerability results in exhausted CPU resources on kernels < 4.15
+    This vulnerability results in exhausted kernel memory on kernels >= 4.15
+reporters:
+- Jonathan Looney
+fixed-by:
+  linux-3.16.y: [dc97a907bc76b71c08e7e99a5b1b30ef4d5e4a85]
+  linux-4.14.y: [9daf226ff92679d09aeca1b5c1240e3607153336]
+  linux-4.19.y: [ec83921899a571ad70d582934ee9e3e07f478848]
+  linux-4.19.y-cip: [ec83921899a571ad70d582934ee9e3e07f478848]
+  linux-4.4.y: [ad472d3a9483abc155e1644ad740cd8c039b5170]
+  linux-4.4.y-cip: [ad472d3a9483abc155e1644ad740cd8c039b5170]
+  linux-4.9.y: [e358f4af19db46ca25cc9a8a78412b09ba98859d]
+  linux-5.1.y: [a38c401b4afafd11a127f250cb382c476bdeed9e]
+  mainline: [f070ef2ac66716357066b683fb0baf55f8191a2e]


=====================================
issues/CVE-2019-11479.yml
=====================================
@@ -0,0 +1,28 @@
+description: TCP minimum MSS hardcoded to 48 which can lead to DoS
+references:
+- https://patchwork.ozlabs.org/patch/1117157/
+- https://patchwork.ozlabs.org/patch/1117158/
+- https://github.com/Netflix/security-bulletins/blob/master/advisories/third-party/2019-001.md
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-11479
+- https://wiki.ubuntu.com/SecurityTeam/KnowledgeBase/SACKPanic
+- https://launchpad.net/bugs/1832286
+comments:
+  Ubuntu-tyhicks: |-
+    This issue is primarily due to the TCP spec not defining a minimum
+     value for the Minimum Segment Size (MSS). The Linux kernel cannot safely put
+     a restriction on the MSS because it may break valid TCP connections. This
+     issue will be addressed by allowing a system administrator to raise the
+     smallest acceptable MSS value but there will be no default mitigation by
+     default.
+reporters:
+- Jonathan Looney
+fixed-by:
+  linux-3.16.y: [6b7e7997ad3505db7de85ff12276fc84659481d3, 7ce5a5796ca119c5c6935ea9f4e785f0cb7f39b7]
+  linux-4.14.y: [cd6f35b8421ff20365ff711c0ac7647fd70e9af7, f2aa4f1a05e0987e812809dbc489bd294fdae5ae]
+  linux-4.19.y: [7f9f8a37e563c67b24ccd57da1d541a95538e8d9, 59222807fcc99951dc769cd50e132e319d73d699]
+  linux-4.19.y-cip: [7f9f8a37e563c67b24ccd57da1d541a95538e8d9, 59222807fcc99951dc769cd50e132e319d73d699]
+  linux-4.4.y: [e757d052f3b8ce739d068a1e890643376c16b7a9, f938ae0ce5ef7b693125b918509b941281afc957]
+  linux-4.4.y-cip: [e757d052f3b8ce739d068a1e890643376c16b7a9, f938ae0ce5ef7b693125b918509b941281afc957]
+  linux-4.9.y: [8e39cbc03dafa3731d22533f869bf326c0e6e6f8, 7e9096287352d0416f3caa0919c90bd9ed2f68d3]
+  linux-5.1.y: [2efabe3e1491f10bf3cf82ae1a371755ba054a1b, 1cebce3b9cb3ec174f367d9e5f1537578ec538dc]
+  mainline: [5f3e2bf008c2221478101ee72f5cb4654b9fc363, 967c05aee439e6e5d7d805e195b3a20ef5c433d6]


=====================================
issues/CVE-2019-11810.yml
=====================================
@@ -10,6 +10,7 @@ references:
 introduced-by:
   mainline: [c4a3e0a529ab3e65223e81681c7c6b1bc188fa58]
 fixed-by:
+  linux-3.16.y: [bd0908fbd84009cb5f01cf1a258a6f7fd78b6b3a]
   linux-4.14.y: [90fca247abf6adc1ee6eef9b3de199448c8a4ad6]
   linux-4.19.y: [8032fc9120c211cd40beef4c91c8206f4167e523]
   linux-4.19.y-cip: [8032fc9120c211cd40beef4c91c8206f4167e523]


=====================================
issues/CVE-2019-11833.yml
=====================================
@@ -6,6 +6,7 @@ references:
 introduced-by:
   mainline: [a86c61812637c7dd0c57e29880cffd477b62f2e7]
 fixed-by:
+  linux-3.16.y: [13c4be25bdcbe5045f9b17ad875c3253a4888e45]
   linux-4.14.y: [d7d9e4823b658eb795f4a379d121d3f0539c1117]
   linux-4.19.y: [25d010f4e0ece1ddf0d8d57942c0b0f1568fe498]
   linux-4.19.y-cip: [25d010f4e0ece1ddf0d8d57942c0b0f1568fe498]


=====================================
issues/CVE-2019-11884.yml
=====================================
@@ -7,6 +7,7 @@ references:
 comments:
   Debian-carnil: similar issue to CVE-2011-1079.
 fixed-by:
+  linux-3.16.y: [acaf43aa7ede1e500532f1f5d910e207f89d5e1f]
   linux-4.14.y: [2c33156b2d2f5efe820d8efdd610fb168c9acf72]
   linux-4.19.y: [c6d1f9b4b2cb768e29f5d44af143f25ad89062b1]
   linux-4.19.y-cip: [c6d1f9b4b2cb768e29f5d44af143f25ad89062b1]


=====================================
issues/CVE-2019-12379.yml
=====================================
@@ -9,5 +9,7 @@ comments:
   Debian-bwh: |-
     There is no memory leak, and the purported "fix" actually
     introduces a security issue.  I have sent a patch to revert it.
+introduced-by:
+  mainline: [1da177e4c3f41524e886b7f1b8a0c1fc7321cac2]
 ignore:
   all: Invalid


=====================================
issues/CVE-2019-12380.yml
=====================================
@@ -10,5 +10,9 @@ comments:
   Debian-bwh: |-
     All the code involved runs at boot before userland starts, so
     there is no "denial of service".
+introduced-by:
+  mainline: [b8f2c21db390273c3eaf0e5308faeaeb1e233840]
+fixed-by:
+  mainline: [4e78921ba4dd0aca1cc89168f45039add4183f8e]
 ignore:
   all: Invalid


=====================================
issues/CVE-2019-12382.yml
=====================================
@@ -11,5 +11,8 @@ comments:
   Debian-bwh: |-
     Root can set a long string and maybe (but probably not) cause a
     null pointer dereference.  No security impact.
+  Ubuntu-tyhicks: |-
+    There's no security impact here as there's no chance of a NULL
+     pointer derefence. I've requested that MITRE reject this CVE.
 ignore:
   all: Invalid


=====================================
issues/CVE-2019-12454.yml
=====================================
@@ -8,6 +8,9 @@ references:
 - https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?h=for-5.3&id=a54988113985ca22e414e132054f234fc8a92604
 - https://lkml.org/lkml/2019/5/29/705
 comments:
+  Ubuntu-tyhicks: |-
+    There's no security impact here from what I can tell. I've requested
+     that MITRE reject this CVE.
   bwh: kstrndup() was the correct function to use here.
 ignore:
   all: Invalid


=====================================
issues/CVE-2019-12818.yml
=====================================
@@ -0,0 +1,12 @@
+description: |-
+  An issue was discovered in the Linux kernel before 4.20.15. The
+  nfc_llcp_build_tlv function in net/nfc/llcp_commands.c may return NULL. If
+  the caller does not check for this, it will trigger a NULL pointer
+  dereference. This will cause denial of service. This affects
+  nfc_llcp_build_gb in net/nfc/llcp_core.c.
+references:
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-12818
+- https://git.kernel.org/linus/58bdd544e2933a21a51eecf17c3f5f94038261b5
+- https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=58bdd544e2933a21a51eecf17c3f5f94038261b5
+- https://github.com/torvalds/linux/commit/58bdd544e2933a21a51eecf17c3f5f94038261b5
+- https://www.kernel.org/pub/linux/kernel/v4.x/ChangeLog-4.20.15


=====================================
issues/CVE-2019-12819.yml
=====================================
@@ -0,0 +1,10 @@
+description: |-
+  An issue was discovered in the Linux kernel before 5.0. The function
+  __mdiobus_register() in drivers/net/phy/mdio_bus.c calls put_device(),
+  which will trigger a fixed_mdio_bus_init use-after-free. This will cause a
+  denial of service.
+references:
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-12819
+- https://git.kernel.org/linus/6ff7b060535e87c2ae14dd8548512abfdda528fb
+- https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=6ff7b060535e87c2ae14dd8548512abfdda528fb
+- https://github.com/torvalds/linux/commit/6ff7b060535e87c2ae14dd8548512abfdda528fb


=====================================
issues/CVE-2019-12881.yml
=====================================
@@ -0,0 +1,6 @@
+description: ''
+references:
+- https://gist.github.com/oxagast/472866fb2c3d439e10499d7141d0a520
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-12881
+comments:
+  Debian-carnil: Unclear status on the issue (e.g. if upstream is aware)


=====================================
issues/CVE-2019-3846.yml
=====================================
@@ -5,3 +5,5 @@ description: |-
 references:
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3846
 - https://lore.kernel.org/linux-wireless/20190529125220.17066-1-tiwai at suse.de/
+fixed-by:
+  mainline: [13ec7f10b87f5fc04c4ccbd491c94c7980236a74]


=====================================
issues/CVE-2019-3896.yml
=====================================
@@ -0,0 +1,7 @@
+description: |-
+  A double-free can happen in idr_remove_all() in lib/idr.c in the Linux
+  kernel 2.6 branch. An unprivileged local attacker can use this flaw for a
+  privilege escalation or for a system crash and a denial of service (DoS).
+references:
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3896
+- https://bugzilla.redhat.com/show_bug.cgi?id=1694812


=====================================
issues/CVE-2019-5489.yml
=====================================
@@ -51,6 +51,7 @@ reporters:
 introduced-by:
   mainline: [1da177e4c3f41524e886b7f1b8a0c1fc7321cac2]
 fixed-by:
+  linux-3.16.y: [b96659f18c61120dbf8b4cc36fbc05589bf9dc02]
   linux-4.14.y: [212c5685825c1ed45ac3a191dd7ada6e5889bfa2]
   linux-4.19.y: [f580a54bbd522f2518fd642f7d4d73ad728e5d58]
   linux-4.19.y-cip: [f580a54bbd522f2518fd642f7d4d73ad728e5d58]



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/4975a4892b252c9bbfbf878f762ee590d24db76d

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/4975a4892b252c9bbfbf878f762ee590d24db76d
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190620/245fbcc0/attachment-0001.html>

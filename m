From: gitlab@mg.gitlab.com (=?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?=)
Date: Wed, 06 Nov 2019 08:33:14 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 9
 commits: Import data from Debian and Ubuntu archives
Message-ID: <5dc2854a558a4_5cfb3f9955218eb894882@sidekiq-asap-02-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



SZ Lin (???) pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
9f11fbee by SZ Lin (???) at 2019-10-14T11:40:54Z
Import data from Debian and Ubuntu archives

Signed-off-by: SZ Lin (???) &lt;sz.lin at moxa.com&gt;

- - - - -
c5fb22f6 by SZ Lin (???) at 2019-10-14T11:45:01Z
Fill in fixed-by commit lists for CVE-2019-17133

Signed-off-by: SZ Lin (???) &lt;sz.lin at moxa.com&gt;

- - - - -
eb4b17f4 by SZ Lin (???) at 2019-10-14T11:54:56Z
Add comment for 4.4 status

Signed-off-by: SZ Lin (???) &lt;sz.lin at moxa.com&gt;

- - - - -
26f0cb2c by SZ Lin (???) at 2019-10-14T11:59:18Z
Mark this issue to be ignored on CIP branches

The components affected by this issue is not enabled by any CIP
members.

Signed-off-by: SZ Lin (???) &lt;sz.lin at moxa.com&gt;

- - - - -
62045139 by SZ Lin (???) at 2019-10-14T12:05:31Z
Tidy the description

Signed-off-by: SZ Lin (???) &lt;sz.lin at moxa.com&gt;

- - - - -
8cc5fbbd by SZ Lin (???) at 2019-10-14T12:15:51Z
Fill in fixed-by commit lists for CVE-2019-17351

Signed-off-by: SZ Lin (???) &lt;sz.lin at moxa.com&gt;

- - - - -
2b43b909 by SZ Lin (???) at 2019-10-23T03:32:43Z
Import data from Debian and Ubuntu archives

Signed-off-by: SZ Lin (???) &lt;sz.lin at moxa.com&gt;

- - - - -
3c2b0e9b by SZ Lin (???) at 2019-10-24T10:13:06Z
Add comment about not affected of CVE-2019-18198

Signed-off-by: SZ Lin (???) &lt;sz.lin at moxa.com&gt;

- - - - -
28b5cda1 by SZ Lin (???) at 2019-11-06T08:33:11Z
Merge branch &#39;master&#39; into &#39;master&#39;

Update issues

See merge request cip-project/cip-kernel/cip-kernel-sec!16
- - - - -


23 changed files:

- issues/CVE-2016-10906.yml
- issues/CVE-2017-18232.yml
- issues/CVE-2018-20976.yml
- issues/CVE-2018-21008.yml
- issues/CVE-2019-14814.yml
- issues/CVE-2019-14815.yml
- issues/CVE-2019-14816.yml
- issues/CVE-2019-14821.yml
- issues/CVE-2019-15099.yml
- issues/CVE-2019-15117.yml
- issues/CVE-2019-15118.yml
- issues/CVE-2019-15504.yml
- issues/CVE-2019-15505.yml
- issues/CVE-2019-15902.yml
- issues/CVE-2019-15918.yml
- issues/CVE-2019-16714.yml
- issues/CVE-2019-16746.yml
- issues/CVE-2019-17075.yml
- issues/CVE-2019-17133.yml
- + issues/CVE-2019-17351.yml
- + issues/CVE-2019-17666.yml
- + issues/CVE-2019-18198.yml
- + issues/CVE-2019-2215.yml


Changes:

=====================================
issues/CVE-2016-10906.yml
=====================================
@@ -3,6 +3,7 @@ references:
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-10906
 - https://git.kernel.org/linus/c278c253f3d992c6994d08aa0efb2b6806ca396f
 - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c278c253f3d992c6994d08aa0efb2b6806ca396f
+- https://usn.ubuntu.com/usn/usn-4163-1
 comments:
   Debian-bwh: CONFIG_ARC_EMAC not enabled, so only affected source-wise.
   Ubuntu-tyhicks: |-


=====================================
issues/CVE-2017-18232.yml
=====================================
@@ -2,6 +2,7 @@ description: 'scsi: libsas: direct call probe and destruct'
 references:
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-18232
 - http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=0558f33c06bb910e2879e355192227a8e8f0219d
+- https://usn.ubuntu.com/usn/usn-4163-1
 comments:
   Debian-bwh: |-
     Commit message says this was introduced by commit 87c8331fcf72


=====================================
issues/CVE-2018-20976.yml
=====================================
@@ -9,6 +9,7 @@ introduced-by:
   mainline: [8daaa83145ef1f0a146680618328dbbd0fa76939]
 fixed-by:
   linux-3.16.y: [bf3878994377a97143f5f6b6e60a18f9b76e0476]
+  linux-4.9.y: [e6e3f36b1ac9c439d3bc0b2c2aaf1663ad705ac0]
   mainline: [c9fbd7bbc23dbdd73364be4d045e5d3612cf6e82]
 ignore:
   linux-4.19.y-cip-rt: No member enables XFS


=====================================
issues/CVE-2018-21008.yml
=====================================
@@ -4,6 +4,8 @@ references:
 - https://git.kernel.org/linus/abd39c6ded9db53aa44c2540092bdd5fb6590fa8
 - https://cdn.kernel.org/pub/linux/kernel/v4.x/ChangeLog-4.16.7
 - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=abd39c6ded9db53aa44c2540092bdd5fb6590fa8
+- https://usn.ubuntu.com/usn/usn-4162-1
+- https://usn.ubuntu.com/usn/usn-4163-1
 comments:
   Debian-bwh: Apparently introduced in 3.15 when rsi driver was added.
 introduced-by:


=====================================
issues/CVE-2019-14814.yml
=====================================
@@ -4,6 +4,10 @@ references:
 - https://lore.kernel.org/linux-wireless/20190828020751.13625-1-huangwenabc at gmail.com/
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14814
 - https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers.git/commit/?id=8b51dc7291473093c821195c4b6af85fadedbc2f
+- https://usn.ubuntu.com/usn/usn-4157-1
+- https://usn.ubuntu.com/usn/usn-4162-1
+- https://usn.ubuntu.com/usn/usn-4163-1
+- https://usn.ubuntu.com/usn/usn-4157-2
 comments:
   Debian-bwh: |-
     Introduced in 3.7 by commit a3c2c4f6d8bc "mwifiex: parse rate info


=====================================
issues/CVE-2019-14815.yml
=====================================
@@ -4,6 +4,9 @@ references:
 - https://lore.kernel.org/linux-wireless/20190828020751.13625-1-huangwenabc at gmail.com/
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14815
 - https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers.git/commit/?id=8b51dc7291473093c821195c4b6af85fadedbc2f
+- https://usn.ubuntu.com/usn/usn-4157-1
+- https://usn.ubuntu.com/usn/usn-4162-1
+- https://usn.ubuntu.com/usn/usn-4157-2
 comments:
   Debian-bwh: |-
     Introduced in 4.10 by commit 113630b581d6 "mwifiex: vendor_ie length


=====================================
issues/CVE-2019-14816.yml
=====================================
@@ -4,6 +4,10 @@ references:
 - https://lore.kernel.org/linux-wireless/20190828020751.13625-1-huangwenabc at gmail.com/
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14816
 - https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers.git/commit/?id=7caac62ed598a196d6ddf8d9c121e12e082cac3a
+- https://usn.ubuntu.com/usn/usn-4157-1
+- https://usn.ubuntu.com/usn/usn-4162-1
+- https://usn.ubuntu.com/usn/usn-4163-1
+- https://usn.ubuntu.com/usn/usn-4157-2
 comments:
   Debian-bwh: |-
     Introduced in 3.6 by commit 2152fe9c2fa4 "mwifiex: parse WPS IEs from


=====================================
issues/CVE-2019-14821.yml
=====================================
@@ -4,6 +4,10 @@ references:
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14821
 - https://www.openwall.com/lists/oss-security/2019/09/20/1
 - https://bugzilla.redhat.com/show_bug.cgi?id=1746708
+- https://usn.ubuntu.com/usn/usn-4157-1
+- https://usn.ubuntu.com/usn/usn-4162-1
+- https://usn.ubuntu.com/usn/usn-4163-1
+- https://usn.ubuntu.com/usn/usn-4157-2
 comments:
   Debian-carnil: |-
     Commit fixes 5f94c1741bdc ("KVM: Add coalesced MMIO support


=====================================
issues/CVE-2019-15099.yml
=====================================
@@ -2,6 +2,7 @@ description: Fix a NULL-ptr-deref bug in ath10k_usb_alloc_urb_from_pipe
 references:
 - https://lore.kernel.org/linux-wireless/20190804003101.11541-1-benquike at gmail.com/T/#u
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15099
+- https://lore.kernel.org/linux-wireless/20191018133516.12606-1-linux at roeck-us.net/
 comments:
   Debian-bwh: |-
     Introduced in 4.14 by commit 4db66499df91 "ath10k: add initial USB


=====================================
issues/CVE-2019-15117.yml
=====================================
@@ -4,6 +4,8 @@ references:
 - https://lore.kernel.org/lkml/20190814023625.21683-1-benquike at gmail.com/
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15117
 - https://usn.ubuntu.com/usn/usn-4147-1
+- https://usn.ubuntu.com/usn/usn-4162-1
+- https://usn.ubuntu.com/usn/usn-4163-1
 comments:
   Ubuntu-tyhicks: |-
     The parse_audio_mixer_unit() function has changed its handling of the


=====================================
issues/CVE-2019-15118.yml
=====================================
@@ -4,6 +4,8 @@ references:
 - https://lore.kernel.org/lkml/20190815043554.16623-1-benquike at gmail.com/
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15118
 - https://usn.ubuntu.com/usn/usn-4147-1
+- https://usn.ubuntu.com/usn/usn-4162-1
+- https://usn.ubuntu.com/usn/usn-4163-1
 comments:
   Debian-bwh: |-
     This is actually a stack overflow (unbounded recursion), not a


=====================================
issues/CVE-2019-15504.yml
=====================================
@@ -3,6 +3,8 @@ references:
 - https://lore.kernel.org/lkml/20190819220230.10597-1-benquike at gmail.com/
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15504
 - https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers.git/commit/?id=8b51dc7291473093c821195c4b6af85fadedbc2f
+- https://usn.ubuntu.com/usn/usn-4157-1
+- https://usn.ubuntu.com/usn/usn-4157-2
 comments:
   Debian-bwh: I agree that commit a1854fae1414 introduced this.
   Debian-carnil: |-


=====================================
issues/CVE-2019-15505.yml
=====================================
@@ -4,6 +4,10 @@ references:
 - https://lore.kernel.org/linux-media/20190821104408.w7krumcglxo6fz5q at gofer.mess.org/
 - https://lore.kernel.org/lkml/b9b256cb-95f2-5fa1-9956-5a602a017c11 at gmail.com/
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15505
+- https://usn.ubuntu.com/usn/usn-4157-1
+- https://usn.ubuntu.com/usn/usn-4162-1
+- https://usn.ubuntu.com/usn/usn-4163-1
+- https://usn.ubuntu.com/usn/usn-4157-2
 comments:
   Debian-bwh: Apparently introduced in 2.6.39 when technisat-usb2 driver was added.
   Ubuntu-tyhicks: |-


=====================================
issues/CVE-2019-15902.yml
=====================================
@@ -2,6 +2,10 @@ description: 'x86/ptrace: fix up botched merge of spectrev1 fix'
 references:
 - https://grsecurity.net/teardown_of_a_failed_linux_lts_spectre_fix.php
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15902
+- https://usn.ubuntu.com/usn/usn-4157-1
+- https://usn.ubuntu.com/usn/usn-4162-1
+- https://usn.ubuntu.com/usn/usn-4163-1
+- https://usn.ubuntu.com/usn/usn-4157-2
 reporters:
 - Brad Spengler
 introduced-by:


=====================================
issues/CVE-2019-15918.yml
=====================================
@@ -4,6 +4,7 @@ references:
 - https://git.kernel.org/linus/b57a55e2200ede754e4dc9cce4ba9402544b9365
 - https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.0.10
 - https://github.com/torvalds/linux/commit/b57a55e2200ede754e4dc9cce4ba9402544b9365
+- https://usn.ubuntu.com/usn/usn-4162-1
 comments:
   Debian-bwh: |-
     Introduced in 4.14 by commit 9764c02fcbad "SMB3: Add support for


=====================================
issues/CVE-2019-16714.yml
=====================================
@@ -2,6 +2,8 @@ description: 'net/rds: Fix info leak in rds6_inc_info_copy()'
 references:
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16714
 - https://git.kernel.org/linus/7d0a06586b2686ba80c4a2da5f91cb10ffbea736
+- https://usn.ubuntu.com/usn/usn-4157-1
+- https://usn.ubuntu.com/usn/usn-4157-2
 comments:
   Ubuntu-tyhicks: |-
     This is a local info leak that is only reachable by calling the


=====================================
issues/CVE-2019-16746.yml
=====================================
@@ -2,7 +2,14 @@ description: 'nl80211: validate beacon head'
 references:
 - https://marc.info/?l=linux-wireless&m=156901391225058&w=2
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16746
+comments:
+  Moxa-szlin: |-
+    This issue was fixed in 4.19.79, and Greg mentioned [1]
+    he backported the patch to 4.4.
+    [1] https://www.mail-archive.com/linux-wireless at vger.kernel.org/msg60345.html
 introduced-by:
   mainline: [ed1b6cc7f80f831e192704b05b9917f9cc37be15]
 fixed-by:
+  linux-4.19.y: [1bd17a737c9e7e91483d9a603528b0e6d4c772f8]
+  linux-4.9.y: [a873afd7d888f7349bfabc9191afeb20eb1d3a45]
   mainline: [f88eb7c0d002a67ef31aeb7850b42ff69abc46dc]


=====================================
issues/CVE-2019-17075.yml
=====================================
@@ -7,3 +7,10 @@ reporters:
 - Nicolas Waisman
 introduced-by:
   mainline: [cfdda9d764362ab77b11a410bb928400e6520d57]
+fixed-by:
+  mainline: [3840c5b78803b2b6cc1ff820100a74a092c40cbb]
+ignore:
+  linux-4.19.y-cip: No member enables cxgb4
+  linux-4.19.y-cip-rt: No member enables cxgb4
+  linux-4.4.y-cip: No member enables cxgb4
+  linux-4.4.y-cip-rt: No member enables cxgb4


=====================================
issues/CVE-2019-17133.yml
=====================================
@@ -1,3 +1,10 @@
-description: 'cfg80211: wext: Reject malformed SSID elements'
+description: 'cfg80211: wext: avoid copying malformed SSIDs'
 references:
 - https://marc.info/?l=linux-wireless&m=157018270915487&w=2
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17133
+reporters:
+- Nicolas Waisman
+introduced-by:
+  mainline: [a42dd7efd934888833c01199dbd21b242100ee92]
+fixed-by:
+  mainline: [4ac2813cc867ae563a1ba5a9414bfb554e5796fa]


=====================================
issues/CVE-2019-17351.yml
=====================================
@@ -0,0 +1,23 @@
+description: 'xen: let alloc_xenballooned_pages() fail if not enough memory free'
+references:
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17351
+- https://xenbits.xen.org/xsa/advisory-300.html
+comments:
+  Debian-benh: |-
+    The advisory says another patch will be needed for domU.
+    For 3.16 we need d02bd27bd33d "mm/page_alloc.c: calculate
+    'available' memory in a separate function" first.
+  Debian-carnil: |-
+    Is a1078e821b60 ("xen: let alloc_xenballooned_pages() fail if
+    not enough memory free") enough or is more needed?
+reporters:
+- Julien Grall
+introduced-by:
+  mainline: [1775826ceec51187aa868406585799b7e76ffa7d]
+fixed-by:
+  linux-3.16.y: [2ed58e578b03269b23eb7119fb38478725ae6470]
+  linux-4.19.y: [e73db096691e5f2720049502a3794a2a0c6d1b1f]
+  linux-4.19.y-cip: [e73db096691e5f2720049502a3794a2a0c6d1b1f]
+  linux-4.19.y-cip-rt: [e73db096691e5f2720049502a3794a2a0c6d1b1f]
+  linux-4.9.y: [259b0fc2caddc21a6b561b595747a8091102f7ff]
+  mainline: [a1078e821b605813b63bf6bca414a85f804d5c66]


=====================================
issues/CVE-2019-17666.yml
=====================================
@@ -0,0 +1,9 @@
+description: 'rtlwifi: Fix potential overflow on P2P code'
+references:
+- https://lkml.org/lkml/2019/10/16/1226
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17666
+- https://lore.kernel.org/lkml/20191016205716.2843-1-labbott at redhat.com/
+- https://twitter.com/nicowaisman/status/1184864519316758535
+- https://bugzilla.suse.com/show_bug.cgi?id=CVE-2019-17666
+reporters:
+- Nico Waisman


=====================================
issues/CVE-2019-18198.yml
=====================================
@@ -0,0 +1,23 @@
+description: |-
+  In the Linux 5.3 kernel before 5.3.4, a reference count usage error in
+  the fib6_rule_suppress() function in the fib6 suppression feature of
+  net/ipv6/fib6_rules.c, when handling the FIB_LOOKUP_NOREF flag, can be
+  exploited by a local attacker to corrupt memory, aka CID-ca7a03c41753.
+references:
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-18198
+- https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=ca7a03c4175366a92cee0ccc4fec0038c3266e26
+- https://usn.ubuntu.com/usn/usn-4161-1
+- https://launchpad.net/bugs/1847478
+comments:
+  Ubuntu-sbeattie: affects 5.3 kernels only
+  Moxa-szlin: |-
+    Since CIP only supports kernel 4.4 and 4.19, there is no impact for CIP member
+introduced-by:
+  mainline: [7d9e5f422150ed00de744e02a80734d74cc9704d]
+fixed-by:
+  mainline: [ca7a03c4175366a92cee0ccc4fec0038c3266e26]
+ignore
+  linux-4.19.y-cip: Not affected
+  linux-4.19.y-cip-rt: Not affected
+  linux-4.4.y-cip: Not affected
+  linux-4.4.y-cip-rt: Not affected


=====================================
issues/CVE-2019-2215.yml
=====================================
@@ -0,0 +1,12 @@
+description: |-
+  A use-after-free in binder.c allows an elevation of privilege from an
+  application to the Linux Kernel. No user interaction is required to exploit
+  this vulnerability, however exploitation does require either the
+  installation of a malicious local application or a separate vulnerability
+  in a network facing application.Product: AndroidAndroid ID: A-141720095
+references:
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-2215
+- https://source.android.com/security/bulletin/2019-10-01
+- https://bugs.chromium.org/p/project-zero/issues/detail?id=1942
+fixed-by:
+  mainline: [f5cb779ba16334b45ba8946d6bfa6d9834d1527f]



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/f2989df1a8bf45c10f00cfecb7dafcadd0d4ed3c...28b5cda1bc9cbb4f23be3a10ef568cfe5021b149

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/f2989df1a8bf45c10f00cfecb7dafcadd0d4ed3c...28b5cda1bc9cbb4f23be3a10ef568cfe5021b149
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191106/8de1223d/attachment-0001.html>

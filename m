From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Sun, 29 Sep 2019 20:13:33 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 5
 commits: Import more data
Message-ID: <5d91106d55aed_18693fa2888af75464764@sidekiq-asap-05-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
270d9a5d by Ben Hutchings at 2019-09-17T15:49:40Z
Import more data

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
f4ac8eba by Ben Hutchings at 2019-09-17T18:36:27Z
Fill in introduced-by commits for various issues

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
9ad72398 by Ben Hutchings at 2019-09-17T18:40:59Z
Fill in fixed-by commit lists for CVE-2019-3900

* The first new commit &quot;vhost: introduce vhost_exceeds_weight()&quot; wasn&#39;t
  listed for some branches.
* Fill in the commit list for 4.4.  import_stable.py didn&#39;t do this
  because it lacks the fix for vhost_vsock, but that&#39;s OK because
  vhost_vsock was added later.
* Note that 4.9 does not have the fix for vhost_vsock, but it is
  present and should be fixed.

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
290036da by Ben Hutchings at 2019-09-17T18:41:39Z
Fill in description and likely commit details for CVE-2019-9445

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
6b5c715a by Ben Hutchings at 2019-09-29T20:13:30Z
Merge branch &#39;bwh/update-issues&#39; into &#39;master&#39;

Update issues

See merge request cip-project/cip-kernel/cip-kernel-sec!12
- - - - -


19 changed files:

- issues/CVE-2019-14814.yml
- issues/CVE-2019-14815.yml
- issues/CVE-2019-14816.yml
- + issues/CVE-2019-14835.yml
- issues/CVE-2019-15030.yml
- issues/CVE-2019-15031.yml
- issues/CVE-2019-15213.yml
- issues/CVE-2019-15504.yml
- issues/CVE-2019-15918.yml
- issues/CVE-2019-15925.yml
- + issues/CVE-2019-2181.yml
- + issues/CVE-2019-2182.yml
- issues/CVE-2019-3900.yml
- + issues/CVE-2019-9245.yml
- + issues/CVE-2019-9445.yml
- + issues/CVE-2019-9453.yml
- + issues/CVE-2019-9455.yml
- issues/CVE-2019-9506.yml
- issues/CVE-2019-kvm-guest-xcr0.yml


Changes:

=====================================
issues/CVE-2019-14814.yml
=====================================
@@ -8,3 +8,5 @@ reporters:
 - huangwen of ADLab of Venustech
 introduced-by:
   mainline: [a3c2c4f6d8bcd473a7016db93da4f10b3f10f25f]
+fixed-by:
+  mainline: [7caac62ed598a196d6ddf8d9c121e12e082cac3a]


=====================================
issues/CVE-2019-14815.yml
=====================================
@@ -8,3 +8,5 @@ reporters:
 - huangwen of ADLab of Venustech
 introduced-by:
   mainline: [113630b581d6d423998d2113a8e892ed6e6af6f9]
+fixed-by:
+  mainline: [7caac62ed598a196d6ddf8d9c121e12e082cac3a]


=====================================
issues/CVE-2019-14816.yml
=====================================
@@ -8,3 +8,5 @@ reporters:
 - huangwen of ADLab of Venustech
 introduced-by:
   mainline: [2152fe9c2fa4c948347b83cb0649d24d214267f5]
+fixed-by:
+  mainline: [7caac62ed598a196d6ddf8d9c121e12e082cac3a]


=====================================
issues/CVE-2019-14835.yml
=====================================
@@ -0,0 +1,16 @@
+description: 'vhost: make sure log_num < in_num'
+references:
+- https://www.openwall.com/lists/oss-security/2019/09/17/1
+comments:
+  Debian-carnil: |-
+    commit fixes 3a4d5c94e959 ("vhost_net: a kernel-level virtio
+    server") present in all supported releases.
+introduced-by:
+  mainline: [3a4d5c94e959359ece6d6b55045c3f046677f55c]
+fixed-by:
+  linux-4.14.y: [7e9480b480a57fb4ef2e4d2c2cddbb1a31d56b33]
+  linux-4.19.y: [ba03ee62aed0b0ee2eadfeb4a2fecc7d7eb47871]
+  linux-4.4.y: [35b29a78cc9b2523f6b0c080e6b44d2eeb367023]
+  linux-4.9.y: [8d8276867b5ac539f1d6e166a028b51c8b1ceda8]
+  linux-5.2.y: [e86a7794620a589212636e0f370c98c451c7f065]
+  mainline: [060423bfdee3f8bc6e2c1bac97de24d5415e2bc4]


=====================================
issues/CVE-2019-15030.yml
=====================================
@@ -14,6 +14,10 @@ introduced-by:
   linux-4.9.y: [a685601f85331ec7f8cda1975bddba311441f333]
   mainline: [f48e91e87e67b56bef63393d1a02c6e22c1d7078]
 fixed-by:
+  linux-4.14.y: [32b803e81ce17eec816f09d5388ef0a1cc9e4c2f]
+  linux-4.19.y: [47a0f70d7d9ac3d6b1a96b312d07bc67af3834e9]
+  linux-4.9.y: [acdf558ef62ceb71938d87f5b700b7ecc0bbee90]
+  linux-5.2.y: [7f20c56c0b7a79e310ed6b4bf13bc009f339529a]
   mainline: [8205d5d98ef7f155de211f5e2eb6ca03d95a5a60]
 ignore:
   linux-4.19.y-cip: No members are using powerpc


=====================================
issues/CVE-2019-15031.yml
=====================================
@@ -3,6 +3,7 @@ references:
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15031
 - https://git.kernel.org/linus/a8318c13e79badb92bc6640704a64cc022a6eb97
 - https://launchpad.net/bugs/1843533
+- https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1843533
 comments:
   Debian-carnil: |-
     Commit fixes a7771176b439 ("powerpc: Don't enable FP/Altivec if
@@ -11,6 +12,8 @@ comments:
 introduced-by:
   mainline: [a7771176b4392fbc3a17399c51a8c11f2f681afe]
 fixed-by:
+  linux-4.19.y: [569775bd536416ed9049aa580d9f89a0b4307d60]
+  linux-5.2.y: [398f2c8277f2de2299fb92e38d9982afc780329b]
   mainline: [a8318c13e79badb92bc6640704a64cc022a6eb97]
 ignore:
   linux-4.19.y-cip: No members are using powerpc


=====================================
issues/CVE-2019-15213.yml
=====================================
@@ -6,6 +6,8 @@ references:
 - https://syzkaller.appspot.com/bug?id=a53c9c9dd2981bfdbfbcbc1ddbd35595eda8bced
 - https://lore.kernel.org/linux-media/fe983331d14442a96db3f71066ca0488a8921840.camel at decadent.org.uk/
 - https://bugzilla.kernel.org/show_bug.cgi?id=204597
+- https://lore.kernel.org/linux-media/fe983331d14442a96db3f71066ca0488a8921840.camel%40decadent.org.uk/
+- https://lore.kernel.org/linux-media/20190822104147.4420-1-vasilyev@ispras.ru/
 comments:
   Debian-bwh: |-
     This is supposed to be fixed by commit 6cf97230cd5f "media: dvb:


=====================================
issues/CVE-2019-15504.yml
=====================================
@@ -15,6 +15,8 @@ reporters:
 - Mathias Payer
 introduced-by:
   mainline: [a1854fae1414dd8edfff4857fd26c3e355d43e19]
+fixed-by:
+  mainline: [8b51dc7291473093c821195c4b6af85fadedbc2f]
 ignore:
   linux-4.19.y-cip: No member enables rsi_usb
   linux-4.19.y-cip-rt: No member enables rsi_usb


=====================================
issues/CVE-2019-15918.yml
=====================================
@@ -7,4 +7,5 @@ references:
 introduced-by:
   mainline: [9764c02fcbad40001fd3f63558d918e4d519bb75]
 fixed-by:
+  linux-4.19.y: [4061e662c8e9f5fb796b05fd2ab58fed8cd16d59]
   mainline: [b57a55e2200ede754e4dc9cce4ba9402544b9365]


=====================================
issues/CVE-2019-15925.yml
=====================================
@@ -7,6 +7,11 @@ references:
 - https://git.kernel.org/linus/04f25edb48c441fc278ecc154c270f16966cbb90
 - https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.2.3
 - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=04f25edb48c441fc278ecc154c270f16966cbb90
+comments:
+  Debian-carnil: |-
+    Needs check when introduced but likely 848440544b41 ("net:
+    hns3: Add support of TX Scheduler & Shaper to HNS3 driver") in
+    4.14-rc1.
 introduced-by:
   mainline: [848440544b41fbe21f36072ee7dc7c3c59ce62e2]
 fixed-by:


=====================================
issues/CVE-2019-2181.yml
=====================================
@@ -0,0 +1,7 @@
+description: 'binder: check for overflow when alloc for security context'
+references:
+- https://source.android.com/security/bulletin/pixel/2019-09-01
+introduced-by:
+  mainline: [ec74136ded792deed80780a2f8baf3521eeb72f9]
+fixed-by:
+  mainline: [0b0509508beff65c1d50541861bc0d4973487dc5]


=====================================
issues/CVE-2019-2182.yml
=====================================
@@ -0,0 +1,11 @@
+description: 'arm64: Enforce BBM for huge IO/VMAP mappings'
+references:
+- https://source.android.com/security/bulletin/pixel/2019-09-01
+comments:
+  Debian-carnil: |-
+    Commit fixes 324420bf91f6 ("arm64: add support for ioremap()
+    block mappings") which is in 4.6-rc1.
+introduced-by:
+  mainline: [324420bf91f60582bb481133db9547111768ef17]
+fixed-by:
+  mainline: [15122ee2c515a253b0c66a3e618bc7ebe35105eb]


=====================================
issues/CVE-2019-3900.yml
=====================================
@@ -10,22 +10,27 @@ references:
 - https://usn.ubuntu.com/usn/usn-4116-1
 - https://usn.ubuntu.com/usn/usn-4117-1
 - https://usn.ubuntu.com/usn/usn-4118-1
+comments:
+  bwh: 4.9 is still missing a fix for vhost_vsock.
 reporters:
 - Jason Wang
 introduced-by:
   mainline: [3a4d5c94e959359ece6d6b55045c3f046677f55c]
 fixed-by:
-  linux-3.16.y: [f3a64b1071c414e59233b769110872a026f8d254, 6c74f68cf3ca570f39ff8a9e3b0ae357839c4560]
-  linux-4.14.y: [ae446749492d8bd23f1d0b81adba16e5739dc740, 46c7fce709dccb4b0e4a5a06bfacdf2bb1a4fc43,
-    011942d12cc28c58fdeb2ca77e745c4c370fc250]
-  linux-4.19.y: [3af3b843aee41ed22343b011a4cf3812a80d2f38, 239910101c4ebf91a00e6f4a81ac3144b121f0c4,
-    02cdc166128cf9cb2be4786b997eebbc0b976bfa]
-  linux-4.19.y-cip: [3af3b843aee41ed22343b011a4cf3812a80d2f38, 239910101c4ebf91a00e6f4a81ac3144b121f0c4,
-    02cdc166128cf9cb2be4786b997eebbc0b976bfa]
+  linux-3.16.y: [2a59b04bcdb2f009906982e711b20bcd40fd253f, f3a64b1071c414e59233b769110872a026f8d254,
+    6c74f68cf3ca570f39ff8a9e3b0ae357839c4560]
+  linux-4.14.y: [c051fb9788281fa308ef614a7317f7fabadb8363, ae446749492d8bd23f1d0b81adba16e5739dc740,
+    46c7fce709dccb4b0e4a5a06bfacdf2bb1a4fc43, 011942d12cc28c58fdeb2ca77e745c4c370fc250]
+  linux-4.19.y: [ad5fc8953d61b99f445db447ac1eadc99a00d47e, 3af3b843aee41ed22343b011a4cf3812a80d2f38,
+    239910101c4ebf91a00e6f4a81ac3144b121f0c4, 02cdc166128cf9cb2be4786b997eebbc0b976bfa]
+  linux-4.19.y-cip: [ad5fc8953d61b99f445db447ac1eadc99a00d47e, 3af3b843aee41ed22343b011a4cf3812a80d2f38,
+    239910101c4ebf91a00e6f4a81ac3144b121f0c4, 02cdc166128cf9cb2be4786b997eebbc0b976bfa]
+  linux-4.4.y: [9e0b3406326401f4f7f1ce84194a29a595dc7aa9, bb85b4cbd8f69cdea3a0caa9aa4edb1d4d7bc24f,
+    6ca24361c2a4c28e69cac96b0bbe476043f5d866]
   linux-4.9.y: [66c8d9d53e657d5068d9f234bc4ec1d703107a48, 4b586288578a3a2aa4efb969feed86f2d760f082,
     02b40edda9fd2e42abae40f5dd85122f13dbe7b8]
-  mainline: [e2412c07f8f3040593dfb88207865a3cd58680c0, e79b431fb901ba1106670bcc80b9b617b25def7d,
-    c1ea02f15ab5efb3e93fc3144d895410bf79fcf2]
+  mainline: [e82b9b0727ff6d665fff2d326162b460dded554d, e2412c07f8f3040593dfb88207865a3cd58680c0,
+    e79b431fb901ba1106670bcc80b9b617b25def7d, c1ea02f15ab5efb3e93fc3144d895410bf79fcf2]
 ignore:
   linux-4.19.y-cip-rt: No member enables vhost drivers
   linux-4.4.y-cip-rt: No member enables vhost drivers


=====================================
issues/CVE-2019-9245.yml
=====================================
@@ -0,0 +1,8 @@
+description: 'f2fs: sanity check of xattr entry size'
+introduced-by:
+  mainline: [af48b85b8cd3fbb12c9b6759c16db6d69c0b03da]
+fixed-by:
+  linux-4.19.y: [5036fcd9b14516f62efae6ed0c42dfbb9798b643]
+  linux-4.19.y-cip: [5036fcd9b14516f62efae6ed0c42dfbb9798b643]
+  linux-4.19.y-cip-rt: [5036fcd9b14516f62efae6ed0c42dfbb9798b643]
+  mainline: [64beba0558fce7b59e9a8a7afd77290e82a22163]


=====================================
issues/CVE-2019-9445.yml
=====================================
@@ -0,0 +1,17 @@
+description: Out-of-bounds read in f2fs
+references:
+- https://source.android.com/security/bulletin/pixel/2019-09-01
+- https://android-review.googlesource.com/c/kernel/common/+/864649
+- https://nvd.nist.gov/vuln/detail/CVE-2019-9445
+comments:
+  Debian-carnil: Not fully clear (to me) which specific commit is meant.
+  bwh: |
+    The CVE description mentions an "out-of bounds read", so the most
+    likely fix seemed to be commit 64beba0558fc "f2fs: sanity check of
+    xattr entry size".  However that addresses CVE-2019-9245.  The
+    other candidate I could see was commit 720db068634c "f2fs: check
+    if file namelen exceeds max value".
+introduced-by:
+  mainline: [6b4ea0160ae236a6561defa28e19f973aedda9ff]
+fixed-by:
+  mainline: [720db068634c91553a8e1d9a0fcd8c7050e06d2b]


=====================================
issues/CVE-2019-9453.yml
=====================================
@@ -0,0 +1,9 @@
+description: 'f2fs: fix to avoid accessing xattr across the boundary'
+references:
+- https://source.android.com/security/bulletin/pixel/2019-09-01
+introduced-by:
+  mainline: [af48b85b8cd3fbb12c9b6759c16db6d69c0b03da]
+fixed-by:
+  linux-4.19.y: [ae3787d433f7b87ebf6b916e524c6e280e4e5804]
+  linux-4.19.y-cip: [ae3787d433f7b87ebf6b916e524c6e280e4e5804]
+  mainline: [2777e654371dd4207a3a7f4fb5fa39550053a080]


=====================================
issues/CVE-2019-9455.yml
=====================================
@@ -0,0 +1,15 @@
+description: 'media: videobuf2-v4l2: drop WARN_ON in vb2_warn_zero_bytesused()'
+references:
+- https://source.android.com/security/bulletin/pixel/2019-09-01
+introduced-by:
+  mainline: [f61bf13b6a07a93b9348e77808d369803f40b681]
+fixed-by:
+  linux-4.14.y: [8d6df5097c0005320ab6f3cd8dda2ef31db6c6d1]
+  linux-4.19.y: [573d423a9bd76b396954ddf847ff24d97658453d]
+  linux-4.19.y-cip: [573d423a9bd76b396954ddf847ff24d97658453d]
+  linux-4.19.y-cip-rt: [573d423a9bd76b396954ddf847ff24d97658453d]
+  linux-4.4.y: [7b5115689bf9dafc5127b28ace4589f698d4adfa]
+  linux-4.4.y-cip: [7b5115689bf9dafc5127b28ace4589f698d4adfa]
+  linux-4.4.y-cip-rt: [7b5115689bf9dafc5127b28ace4589f698d4adfa]
+  linux-4.9.y: [7f422aa63d5a0905232455a8953cd9bc02eab4da]
+  mainline: [5e99456c20f712dcc13d9f6ca4278937d5367355]


=====================================
issues/CVE-2019-9506.yml
=====================================
@@ -7,13 +7,10 @@ references:
 - https://www.bluetooth.com/security/statement-key-negotiation-of-bluetooth/
 - https://usn.ubuntu.com/usn/usn-4115-1
 - https://usn.ubuntu.com/usn/usn-4118-1
+- https://bugzilla.kernel.org/show_bug.cgi?id=203997
 comments:
   Debian-carnil: HW issue, but some mitigations are applied in Linux
-  Ubuntu-mdeslaur: |-
-    As of 2019-08-16, no exact details on what the fix for this
-    issue is, but likely to be implemented in bluetooth firmware.
-    As such, and since this requires that the attacker be in
-    Bluetooth range, downgrading priority to medium.
+  Ubuntu-mdeslaur: Mitigation for this issue was added to the kernel
   Ubuntu-sbeattie: CERT VU#918987
 reporters:
 - Daniele Antonioli


=====================================
issues/CVE-2019-kvm-guest-xcr0.yml
=====================================
@@ -10,6 +10,7 @@ comments:
     subdirectory arch/x86/kvm/vmx/vmx.c so backport to 4.19 and
     older need to account for that.
 fixed-by:
+  linux-4.19.y: [7a74d806bdaa4718b96577068fe86fcdb91436e1]
   mainline: [1811d979c71621aafc7b879477202d286f7e863b]
 ignore:
   linux-4.19.y-cip-rt: No member enables KVM



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/fd9cebc286cd842458d7024ab40e3a64c902130d...6b5c715a4c0d4bc6e0d3ea3b8ab0cd98466f28c3

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/fd9cebc286cd842458d7024ab40e3a64c902130d...6b5c715a4c0d4bc6e0d3ea3b8ab0cd98466f28c3
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190929/76e5c5b7/attachment-0001.html>

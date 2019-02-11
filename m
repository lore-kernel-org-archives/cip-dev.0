From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Mon, 11 Feb 2019 22:05:02 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 3
 commits: Import more data
Message-ID: <5c61f18e8a389_3f5f3fdfef3878a4483085@sidekiq-asap-03-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
75376d99 by Ben Hutchings at 2019-02-11T20:47:33Z
Import more data

- - - - -
5c5b5306 by Ben Hutchings at 2019-02-11T22:04:23Z
Record introduced-by commits for several issues

- - - - -
6ed13434 by Ben Hutchings at 2019-02-11T22:04:41Z
Record fixes for CVE-2018-3620 and CVE-2018-16885

- - - - -


27 changed files:

- issues/CVE-2017-18249.yml
- issues/CVE-2017-5967.yml
- issues/CVE-2017-9725.yml
- issues/CVE-2018-10876.yml
- issues/CVE-2018-10877.yml
- issues/CVE-2018-10878.yml
- issues/CVE-2018-10879.yml
- issues/CVE-2018-10880.yml
- issues/CVE-2018-10882.yml
- issues/CVE-2018-10883.yml
- issues/CVE-2018-14616.yml
- issues/CVE-2018-14625.yml
- issues/CVE-2018-16882.yml
- issues/CVE-2018-16885.yml
- issues/CVE-2018-17972.yml
- issues/CVE-2018-18281.yml
- issues/CVE-2018-19407.yml
- issues/CVE-2018-19824.yml
- issues/CVE-2018-19854.yml
- issues/CVE-2018-20169.yml
- issues/CVE-2018-20669.yml
- issues/CVE-2018-3620.yml
- issues/CVE-2018-5391.yml
- + issues/CVE-2019-6974.yml
- + issues/CVE-2019-7221.yml
- + issues/CVE-2019-7222.yml
- issues/CVE-2019-7308.yml


Changes:

=====================================
issues/CVE-2017-18249.yml
=====================================
@@ -5,6 +5,8 @@ references:
 - https://github.com/torvalds/linux/commit/30a61ddf8117c26ac5b295e1233eaa9629a94ca3
 comments:
   Debian-bwh: So far I've failed to backport this even to 4.9.
+introduced-by:
+  mainline: [e05df3b115e7308afbca652769b54e4549fcc723]
 fixed-by:
   linux-4.4.y: [a4f4f97573bfb057bbc30696d803cc37ed629d02]
   linux-4.9.y: [cb9b1d4ec206702a4df1cb42ba8142f39acfdd91]


=====================================
issues/CVE-2017-5967.yml
=====================================
@@ -14,6 +14,9 @@ comments:
     acceptable for stable branches, other than possibly 4.9.  We
     could instead prevent processes outside the initial pid
     namespace from opening the file.
+    Although MITRE's description only refers to /proc/timer_list,
+    /proc/timer_stats also exposes pids if CONFIG_TIMER_STATS is
+    enabled.
   Ubuntu-jdstrand: |-
     android kernels (flo, goldfish, grouper, maguro, mako and manta) are
      not supported on the Ubuntu Touch 14.10 and earlier preview kernels


=====================================
issues/CVE-2017-9725.yml
=====================================
@@ -2,5 +2,7 @@ description: 'mm: cma: fix incorrect type conversion for size during dma allocat
 references:
 - https://bugzilla.redhat.com/show_bug.cgi?id=1489088
 - https://source.android.com/security/bulletin/2017-09-01
+introduced-by:
+  mainline: [c64be2bb1c6eb43c838b2c6d57b074078be208dd]
 fixed-by:
   mainline: [67a2e213e7e937c41c52ab5bc46bf3f4de469f6e]


=====================================
issues/CVE-2018-10876.yml
=====================================
@@ -12,6 +12,7 @@ references:
 - https://usn.ubuntu.com/usn/usn-3871-1
 - https://usn.ubuntu.com/usn/usn-3871-3
 - https://usn.ubuntu.com/usn/usn-3871-4
+- https://usn.ubuntu.com/usn/usn-3871-5
 comments:
   Ubuntu-sbeattie: |-
     fs/ext4/balloc.c


=====================================
issues/CVE-2018-10877.yml
=====================================
@@ -13,6 +13,7 @@ references:
 - https://usn.ubuntu.com/usn/usn-3871-1
 - https://usn.ubuntu.com/usn/usn-3871-3
 - https://usn.ubuntu.com/usn/usn-3871-4
+- https://usn.ubuntu.com/usn/usn-3871-5
 comments:
   Ubuntu-sbeattie: |-
     possible reproducer in bug report


=====================================
issues/CVE-2018-10878.yml
=====================================
@@ -15,6 +15,7 @@ references:
 - https://usn.ubuntu.com/usn/usn-3871-1
 - https://usn.ubuntu.com/usn/usn-3871-3
 - https://usn.ubuntu.com/usn/usn-3871-4
+- https://usn.ubuntu.com/usn/usn-3871-5
 comments:
   Ubuntu-sbeattie: reproducer in bug report
 reporters:


=====================================
issues/CVE-2018-10879.yml
=====================================
@@ -15,6 +15,7 @@ references:
 - https://usn.ubuntu.com/usn/usn-3871-1
 - https://usn.ubuntu.com/usn/usn-3871-3
 - https://usn.ubuntu.com/usn/usn-3871-4
+- https://usn.ubuntu.com/usn/usn-3871-5
 comments:
   Ubuntu-sbeattie: |-
     possible reproducer in kernel bug report


=====================================
issues/CVE-2018-10880.yml
=====================================
@@ -12,6 +12,7 @@ references:
 - https://usn.ubuntu.com/usn/usn-3871-1
 - https://usn.ubuntu.com/usn/usn-3871-3
 - https://usn.ubuntu.com/usn/usn-3871-4
+- https://usn.ubuntu.com/usn/usn-3871-5
 comments:
   Ubuntu-sbeattie: |-
     possible reproducer in bug report


=====================================
issues/CVE-2018-10882.yml
=====================================
@@ -11,6 +11,7 @@ references:
 - https://usn.ubuntu.com/usn/usn-3871-1
 - https://usn.ubuntu.com/usn/usn-3871-3
 - https://usn.ubuntu.com/usn/usn-3871-4
+- https://usn.ubuntu.com/usn/usn-3871-5
 comments:
   Ubuntu-sbeattie: possible reproducer in bug report
 reporters:


=====================================
issues/CVE-2018-10883.yml
=====================================
@@ -13,6 +13,7 @@ references:
 - https://usn.ubuntu.com/usn/usn-3871-4
 - https://usn.ubuntu.com/usn/usn-3879-1
 - https://usn.ubuntu.com/usn/usn-3879-2
+- https://usn.ubuntu.com/usn/usn-3871-5
 comments:
   Debian-carnil: |-
     Upstream 4.9.x series did only contain the first part in


=====================================
issues/CVE-2018-14616.yml
=====================================
@@ -12,6 +12,8 @@ comments:
      not the default filesystem and it is not widely used in Ubuntu
 reporters:
 - Wen Xu
+introduced-by:
+  mainline: [57e5055b0a5e33267b8be366ee52ce5cdc239bc7]
 fixed-by:
   linux-4.14.y: [38fce19d4d7bc8acfa183ee2918758d279a69c9a]
   linux-4.4.y: [4901e126b6e1677c90d3c0a668193e52ecdd4971]


=====================================
issues/CVE-2018-14625.yml
=====================================
@@ -9,6 +9,8 @@ references:
 - https://usn.ubuntu.com/usn/usn-3871-3
 - https://usn.ubuntu.com/usn/usn-3871-4
 - https://usn.ubuntu.com/usn/usn-3878-1
+- https://usn.ubuntu.com/usn/usn-3871-5
+- https://usn.ubuntu.com/usn/usn-3878-2
 comments:
   bwh: |-
     I'm not certain when this was introduced but the earliest possible


=====================================
issues/CVE-2018-16882.yml
=====================================
@@ -16,6 +16,8 @@ references:
 - https://usn.ubuntu.com/usn/usn-3871-3
 - https://usn.ubuntu.com/usn/usn-3871-4
 - https://usn.ubuntu.com/usn/usn-3878-1
+- https://usn.ubuntu.com/usn/usn-3871-5
+- https://usn.ubuntu.com/usn/usn-3878-2
 comments:
   Debian-carnil: |-
     Commit fixes 5e2f30b756a37 "KVM: nVMX: get rid of nested_get_page()"


=====================================
issues/CVE-2018-16885.yml
=====================================
@@ -15,4 +15,5 @@ comments:
 reporters:
 - Paolo Abeni
 fixed-by:
-  mainline: [21226abb4e9f14d88238964d89b279e461ddc30c]
+  linux-3.16.y: [874c613a476d6a283ce418290c4472a07dadadf6]
+  mainline: [06ebb06d49486676272a3c030bfeef4bd969a8e6]


=====================================
issues/CVE-2018-17972.yml
=====================================
@@ -13,6 +13,7 @@ references:
 - https://usn.ubuntu.com/usn/usn-3871-4
 - https://usn.ubuntu.com/usn/usn-3880-1
 - https://usn.ubuntu.com/usn/usn-3880-2
+- https://usn.ubuntu.com/usn/usn-3871-5
 reporters:
 - Jann Horn
 introduced-by:


=====================================
issues/CVE-2018-18281.yml
=====================================
@@ -11,6 +11,7 @@ references:
 - https://usn.ubuntu.com/usn/usn-3871-4
 - https://usn.ubuntu.com/usn/usn-3880-1
 - https://usn.ubuntu.com/usn/usn-3880-2
+- https://usn.ubuntu.com/usn/usn-3871-5
 reporters:
 - Jann Horn
 introduced-by:


=====================================
issues/CVE-2018-19407.yml
=====================================
@@ -10,6 +10,8 @@ references:
 - https://usn.ubuntu.com/usn/usn-3878-1
 - https://usn.ubuntu.com/usn/usn-3879-1
 - https://usn.ubuntu.com/usn/usn-3879-2
+- https://usn.ubuntu.com/usn/usn-3871-5
+- https://usn.ubuntu.com/usn/usn-3878-2
 comments:
   Debian-bwh: |-
     I'm fairly sure this is impossible before commit 5c919412fe61


=====================================
issues/CVE-2018-19824.yml
=====================================
@@ -14,6 +14,7 @@ reporters:
 introduced-by:
   mainline: [362e4e49abe53e89d87455dfcd7c1bbaf08a839d]
 fixed-by:
+  linux-3.16.y: [1c38b9d9e74a24a8ed9089429031f6d7721b6df0]
   linux-4.14.y: [19f74e45746253cafb8cb1e773041e7cadbac622]
   linux-4.19.y: [a7e719ace75e4451b7958cb73cbc12c627760007]
   linux-4.4.y: [82fa3e95432f95254fd07556c55b1018145e1439]


=====================================
issues/CVE-2018-19854.yml
=====================================
@@ -11,6 +11,7 @@ references:
 - http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=f43f39958beb206b53292801e216d9b8a660f087
 - https://usn.ubuntu.com/usn/usn-3872-1
 - https://usn.ubuntu.com/usn/usn-3878-1
+- https://usn.ubuntu.com/usn/usn-3878-2
 comments:
   Debian-carnil: |-
     Regreession from CVE-2013-2547 and commit fixes 4473710df1f8


=====================================
issues/CVE-2018-20169.yml
=====================================
@@ -17,6 +17,7 @@ reporters:
 introduced-by:
   mainline: [1da177e4c3f41524e886b7f1b8a0c1fc7321cac2]
 fixed-by:
+  linux-3.16.y: [f8860a91d7538022c1c3f0bdddeec9a9d83e0c09]
   linux-4.14.y: [7b6e85da8d94948201abb8d576d485892a6a878f]
   linux-4.19.y: [1b2e742bf7230ce04cda5b7348f922174bef2d7a]
   linux-4.4.y: [c380600bf71c35dc23aa0c3628a1013ec10cb349]


=====================================
issues/CVE-2018-20669.yml
=====================================
@@ -2,11 +2,14 @@ description: Missing access_ok() checks in IOCTL function (gpu/drm/i915 Driver)
 references:
 - https://www.openwall.com/lists/oss-security/2019/01/23/6
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20669
+- https://www.openwall.com/lists/oss-security/2019/02/07/1
 comments:
   Ubuntu-tyhicks: |-
     Only the i915_gem_execbuffer2_ioctl() changes are technically needed
      for this CVE. It would be ideal to audit the callers of the other changed
      functions in the fix commit.
+    This CVE is being disputed. See the oss-security emails on
+     2019-02-07 for details.
 introduced-by:
   mainline: [2889caa9232109afc8881f29a2205abeb5709d0c]
 fixed-by:


=====================================
issues/CVE-2018-3620.yml
=====================================
@@ -37,6 +37,20 @@ comments:
 reporters:
 - Researchers from Intel
 fixed-by:
+  linux-3.16.y: [10855c7f42392ba42dcd0a934b3f99d0bd1eea31, 3e2303b14e5560ef760b7934a8c4c9ad1cdf246f,
+    5fe3e72fa4229fa457d6a6a31d104aff23edd8bd, a21dcddca6930a1edb043712e8562365ccf96dba,
+    251377474f8c66ec70e5b3883fee13db791e21a4, 299147ddcbd447d97e80088d05aff0fa62af34c2,
+    74a430116636754bf42e7ab08fdd9629bd00ffc1, cf957b8f323ad8237f5c685eea8415a3086b1d33,
+    f168a77cc3d6289f9ac07b381f0ab5c3b0d8b6db, 90ff407c74170af5be4ccf02baa1ee89fef36976,
+    d6d4b0323639065a2360b50392aa05ba3fdd5dff, c11f6523a7298a7e0b1a2b767e292a69639b997d,
+    c11f6523a7298a7e0b1a2b767e292a69639b997d, b3dc998f1ca71c91f0b0e077a360405f0550a511,
+    13948a9f275c7d945589737c6f29241b97930630, 9c8c0995084eb87c0f634a16d4a05406f3d3a16f,
+    308ad2888759478ed11dc989e8538c621046b811, e2ec50b1272c238735ebf48a25020676818aef79,
+    df54183ac4eccbbae95afedf7ed1643ac46ac88a, f168a77cc3d6289f9ac07b381f0ab5c3b0d8b6db,
+    7076c25fd00163ce2189a88a31877cc1376b0be5, 6097e7f43a8b9109626e3ffef3e280119febb2f9,
+    1fb3a36c0e333e2810c9aa4715c0e2080dad5a19, 9c8c0995084eb87c0f634a16d4a05406f3d3a16f,
+    308ad2888759478ed11dc989e8538c621046b811, e2ec50b1272c238735ebf48a25020676818aef79,
+    b579b8f2128ee2b9e9393b6a18297bb79080ef34, 2dd5705f361a1335f067e56f69a3994fcf9e98f4]
   linux-4.14.y: [aefe1861bc156102ac5d5be18cf781a76537c119, 39991a7aa8d527164a87f90bb18b07b2699ed7d0,
     83ef7e8c0cb72510588ee8b96f5cf30c1ecd9270, 8c35b2fcbe6a86be93aa7cb9c4842e3c70b77620,
     aff6fe17f52815e6ebdbf82b69f3edf669808eb6, 3d98de691c013ea4e60360db93b885fe9db15c37,


=====================================
issues/CVE-2018-5391.yml
=====================================
@@ -54,6 +54,10 @@ fixed-by:
     37c7cc80b1d7de36a6ed54796ae30ee091d05eab, 6b921536f1707a240e6f53843f1f26231016fda5,
     04b28f406e86512a3592664553b5e17efe663ece, c91f27fb571666a176e1446646726f78d4657ddb,
     b3a0c61b73699b3764a6568e85c67f599158c541, 08fb833b40e361ce927c64d40e348af96996d9eb]
+  linux-4.4.y: [ef0f963de1d2c5bc99d3d6ace3dd44a7d6002717, 26cfea3c1d041d08edacae291565f295553e15ce,
+    3f78a3f45e79ca378cb850a598e4c76633710e92, 5f2d68b6b5a439c3223d8fa6ba20736f91fc58d8,
+    acd00a0692072b374afee4b6f38c1eb1c6cf6f4a, 2039bd8669f4ecefca163f0c9d8c5f5f6a4c8610,
+    2822475e70db5a4b46de88a5b66eb2aceb3734af, cb5fd4aa24b57206548d5940dc359f0b181a2688]
   linux-4.9.y: [7fca77153c5c2a2c59e70720332bce7088aef8e8, 2ffb1c363dfa89858dded0b291f005faf1b72adc,
     bbf6d8604475f36279c7b2d9a1f425654bc24588, dae73e7d73fce8d8d5132ec3c94de16280653fc6,
     1b363f81f38f28bd69ec90837da0f65161f36325, 620018dd713da51daac7ec4cd0ae54b0f0fa0f75,


=====================================
issues/CVE-2019-6974.yml
=====================================
@@ -0,0 +1,10 @@
+description: |-
+  kvm: fix kvm_ioctl_create_device() reference counting
+   https://bugzilla.redhat.com/show_bug.cgi?id=1671913
+   https://git.kernel.org/pub/scm/virt/kvm/kvm.git/commit/?id=cfa39381173d5f969daf43582c95ad679189cbc9
+comments:
+  Debian-carnil: 'Commit fixes 852b6d57dc7f ("kvm: add device control API") (3.10-rc1)'
+introduced-by:
+  mainline: [852b6d57dc7fa378019786fa84727036e56839ea]
+fixed-by:
+  mainline: [cfa39381173d5f969daf43582c95ad679189cbc9]


=====================================
issues/CVE-2019-7221.yml
=====================================
@@ -0,0 +1,8 @@
+description: 'KVM: nVMX: unconditionally cancel preemption timer in free_nested'
+references:
+- https://git.kernel.org/pub/scm/virt/kvm/kvm.git/commit/?id=ecec76885bcfe3294685dc363fd1273df0d5d65f
+- https://bugzilla.redhat.com/show_bug.cgi?id=1671904
+introduced-by:
+  mainline: [f4124500c2c13eb1208c6143b3f6d469709dea10]
+fixed-by:
+  mainline: [ecec76885bcfe3294685dc363fd1273df0d5d65f]


=====================================
issues/CVE-2019-7222.yml
=====================================
@@ -0,0 +1,8 @@
+description: 'KVM: x86: work around leak of uninitialized stack contents'
+references:
+- https://git.kernel.org/pub/scm/virt/kvm/kvm.git/commit/?id=353c0956a618a07ba4bbe7ad00ff29fe70e8412a
+- https://bugzilla.redhat.com/show_bug.cgi?id=1671930
+introduced-by:
+  mainline: [27d6c865211662721e6cf305706e4a3da35f12b4]
+fixed-by:
+  mainline: [353c0956a618a07ba4bbe7ad00ff29fe70e8412a]


=====================================
issues/CVE-2019-7308.yml
=====================================
@@ -18,6 +18,8 @@ comments:
      the kernel lockdown feature which blocks BPF program loading.
 reporters:
 - Jann Horn
+introduced-by:
+  mainline: [1be7f75d1668d6296b80bf35dcf6762393530afc]
 fixed-by:
   linux-4.19.y: [f92a819b4cbef8c9527d9797110544b2055a4b96]
   linux-4.20.y: [078da99d449f64ca04d459cdbdcce513b64173cd]



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/2673ace439e64574f09d38e7fcd8e87b2b673ce5...6ed13434893858c8af2b7799a8ff451d68b4e9f4

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/2673ace439e64574f09d38e7fcd8e87b2b673ce5...6ed13434893858c8af2b7799a8ff451d68b4e9f4
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190211/4375aaad/attachment-0001.html>

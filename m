From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Thu, 21 Feb 2019 19:08:20 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 2
 commits: Import more data
Message-ID: <5c6ef72448c56_65fc3fd861125704220115a@sidekiq-asap-05-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
22dc117c by Ben Hutchings at 2019-02-21T18:55:29Z
Import more data

- - - - -
8c45b2e3 by Ben Hutchings at 2019-02-21T19:08:15Z
Record introduced-by commits for two issues

- - - - -


13 changed files:

- issues/CVE-2016-3695.yml
- issues/CVE-2018-1000026.yml
- issues/CVE-2018-1120.yml
- issues/CVE-2018-15572.yml
- issues/CVE-2018-20669.yml
- issues/CVE-2019-3819.yml
- issues/CVE-2019-6974.yml
- issues/CVE-2019-7221.yml
- issues/CVE-2019-7222.yml
- issues/CVE-2019-7308.yml
- + issues/CVE-2019-8912.yml
- + issues/CVE-2019-8956.yml
- + issues/CVE-2019-8980.yml


Changes:

=====================================
issues/CVE-2016-3695.yml
=====================================
@@ -21,6 +21,10 @@ comments:
     it's possible we will want/get CVEs for other issues
      addressed in the patch series containing this fix.
     still unfixed as of 2017-10-12
+  Ubuntu-tyhicks: |-
+    This CVE was assigned against an out-of-tree patch series.
+     The Ubuntu kernel carries the patch series in Bionic and newer
+     releases.
   bwh: |-
     This is a flaw in the secure modules/securelevel/lockdown patch sets.
     Mainline is not expected to prevent hardware access by privileged users.


=====================================
issues/CVE-2018-1000026.yml
=====================================
@@ -24,7 +24,15 @@ comments:
     But this is really a core networking bug and must be fixed
     there, because other drivers and hardware are almost
     certainly affected.
+  Debian-carnil: |-
+    apparently the CVE is specifically associated only with
+    2b16f048729b and 8914a595110a, so consider it released
+    with those two commits. The two commited are as well to
+    be included in 4.14.102 and 4.9.159.
+    Do we maybe need a separate CVE for the generic issue?
 fixed-by:
+  linux-4.14.y: [60cd31866de4386d940e55073491c3ee17ca593e, 785644d6731914407b87e70db00aca351a44a935]
+  linux-4.9.y: [84d8c3a7e1a48df8d21d100181b1d97a3adc50e5, f3fe2c72a7b7361a306ca1b51387bb2f995216a2]
   mainline: [8914a595110a6eca69a5e275b323f5d09e18f4f9, 2b16f048729bf35e6c28a40cbfad07239f9dcd90]
 ignore:
   linux-3.2.y: EOL


=====================================
issues/CVE-2018-1120.yml
=====================================
@@ -22,4 +22,5 @@ fix-depends-on:
     Convert access_remote_vm to take flags.  This in turn depends on
     several preceding commits.
 ignore:
+  linux-3.16.y: Too risky to backport
   linux-3.2.y: EOL


=====================================
issues/CVE-2018-15572.yml
=====================================
@@ -16,6 +16,12 @@ references:
 - https://usn.ubuntu.com/usn/usn-3777-1
 - https://usn.ubuntu.com/usn/usn-3777-2
 - https://usn.ubuntu.com/usn/usn-3777-3
+introduced-by:
+  linux-3.16.y: [1f8ab11aba17e183e30e45f06227600f76617012]
+  linux-4.14.y: [051547583bdda4b74953053a1034026c56b55c4c]
+  linux-4.4.y: [18bb117d1b7690181346e6365c6237b6ceaac4c4]
+  linux-4.9.y: [abf67b1e788194a2d13a8e77f05a44cbf9eae655]
+  mainline: [c995efd5a740d9cbafbf58bde4973e8b50b4d761]
 fixed-by:
   linux-3.16.y: [ba4a6140b84f5a86be14c2511431004bc4b9be69]
   linux-4.14.y: [f374b5593e44c01265156b4c4070b618097f401b]


=====================================
issues/CVE-2018-20669.yml
=====================================
@@ -4,6 +4,9 @@ references:
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20669
 - https://www.openwall.com/lists/oss-security/2019/02/07/1
 comments:
+  Debian-bwh: |-
+    I think this is not a real vulnerability, as explained in
+    https://www.openwall.com/lists/oss-security/2019/02/07/1
   Ubuntu-tyhicks: |-
     Only the i915_gem_execbuffer2_ioctl() changes are technically needed
      for this CVE. It would be ideal to audit the callers of the other changed


=====================================
issues/CVE-2019-3819.yml
=====================================
@@ -27,6 +27,11 @@ introduced-by:
   linux-4.9.y: [4a30c12542290f1def08b9ef0d677c024c500589]
   mainline: [717adfdaf14704fd3ec7fa2c04520c0723247eac]
 fixed-by:
+  linux-4.14.y: [e0f784bf571528011a7421021f72dbe4bfe10a7c]
+  linux-4.19.y: [c70374ce418e7ae9276d3dc26aed0301e4da5e35]
+  linux-4.20.y: [a8d5fb2f83c533379b8e78f5647c412e47009a46]
+  linux-4.4.y: [b661fff5f8a0f19824df91cc3905ba2c5b54dc87]
+  linux-4.9.y: [64a9f5f2e45b7241bd753b6cd57a8249a7e52639]
   mainline: [13054abbaa4f1fd4e6f3b4b63439ec033b4c8035]
 ignore:
   all: debugfs restricted to root by default


=====================================
issues/CVE-2019-6974.yml
=====================================
@@ -2,9 +2,18 @@ description: |-
   kvm: fix kvm_ioctl_create_device() reference counting
    https://bugzilla.redhat.com/show_bug.cgi?id=1671913
    https://git.kernel.org/pub/scm/virt/kvm/kvm.git/commit/?id=cfa39381173d5f969daf43582c95ad679189cbc9
+references:
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-6974
+- https://bugs.chromium.org/p/project-zero/issues/detail?id=1765
 comments:
   Debian-carnil: 'Commit fixes 852b6d57dc7f ("kvm: add device control API") (3.10-rc1)'
+reporters:
+- Jann Horn
 introduced-by:
   mainline: [852b6d57dc7fa378019786fa84727036e56839ea]
 fixed-by:
+  linux-4.14.y: [8c1b11bc3555b5d1207b0e179cbdd8b945e71e69]
+  linux-4.19.y: [24b027d2b1386da03aafb2aaac69d4fa67ee7d9c]
+  linux-4.20.y: [e02d0a24a0faa566b9c87c5c301255c5f203875c]
+  linux-4.9.y: [0c42df1f9f82f73ebc6c0f54b1df295ffc5a7b4b]
   mainline: [cfa39381173d5f969daf43582c95ad679189cbc9]


=====================================
issues/CVE-2019-7221.yml
=====================================
@@ -2,7 +2,25 @@ description: 'KVM: nVMX: unconditionally cancel preemption timer in free_nested'
 references:
 - https://git.kernel.org/pub/scm/virt/kvm/kvm.git/commit/?id=ecec76885bcfe3294685dc363fd1273df0d5d65f
 - https://bugzilla.redhat.com/show_bug.cgi?id=1671904
+- https://bugs.chromium.org/p/project-zero/issues/detail?id=1760
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-7221
+comments:
+  Ubuntu-tyhicks: |-
+    Ubuntu kernels do not enable nested KVM virtualization by default and
+     are unaffected by this flaw in the default configuration. However, installing
+     QEMU results in nested KVM support to be enabled via the
+     /etc/modprobe.d/qemu-system-x86.conf file. To ensure that nested
+     virtualization is not enabled, verify that the
+     /sys/module/kvm_intel/parameters/nested file contains "N".
+reporters:
+- Jim Mattson
+- Felix Wilhelm
 introduced-by:
   mainline: [f4124500c2c13eb1208c6143b3f6d469709dea10]
 fixed-by:
+  linux-4.14.y: [1c965b1b5ecc2c9e1d59b2514cedb6f7483a0241]
+  linux-4.19.y: [236fd677125f974aaf39f09074d226a884b4fe0e]
+  linux-4.20.y: [c645d81d70579acbdebbda16f0dc003a9c6d223a]
+  linux-4.4.y: [9872ddae1949b46d5310e0e71ca26bb5c4e52a70]
+  linux-4.9.y: [a2c34d20660f24a40b46d0d341547b84f3fff3b0]
   mainline: [ecec76885bcfe3294685dc363fd1273df0d5d65f]


=====================================
issues/CVE-2019-7222.yml
=====================================
@@ -2,7 +2,24 @@ description: 'KVM: x86: work around leak of uninitialized stack contents'
 references:
 - https://git.kernel.org/pub/scm/virt/kvm/kvm.git/commit/?id=353c0956a618a07ba4bbe7ad00ff29fe70e8412a
 - https://bugzilla.redhat.com/show_bug.cgi?id=1671930
+- https://bugs.chromium.org/p/project-zero/issues/detail?id=1759
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-7222
+comments:
+  Ubuntu-tyhicks: |-
+    Ubuntu kernels do not enable nested KVM virtualization by default and
+     are unaffected by this flaw in the default configuration. However, installing
+     QEMU results in nested KVM support to be enabled via the
+     /etc/modprobe.d/qemu-system-x86.conf file. To ensure that nested
+     virtualization is not enabled, verify that the
+     /sys/module/kvm_intel/parameters/nested file contains "N".
+reporters:
+- Felix Wilhelm
 introduced-by:
   mainline: [27d6c865211662721e6cf305706e4a3da35f12b4]
 fixed-by:
+  linux-4.14.y: [ef1b3d4893cec543305d30e8160df8c096135950]
+  linux-4.19.y: [5a45d3720b5437515f8c094f1c3d61f6afe211c1]
+  linux-4.20.y: [69b8c405155e0dcaee718434ff7859b757641646]
+  linux-4.4.y: [1b5fd913a4eb07cb13e969bb8e3b1633a40e683f]
+  linux-4.9.y: [f5c61e4f6b5a1cc66c61eb68334f725031948a7e]
   mainline: [353c0956a618a07ba4bbe7ad00ff29fe70e8412a]


=====================================
issues/CVE-2019-7308.yml
=====================================
@@ -21,6 +21,6 @@ reporters:
 introduced-by:
   mainline: [1be7f75d1668d6296b80bf35dcf6762393530afc]
 fixed-by:
-  linux-4.19.y: [f92a819b4cbef8c9527d9797110544b2055a4b96]
+  linux-4.19.y: [f92a819b4cbef8c9527d9797110544b2055a4b96, eed84f94ff8d97abcbc5706f6f9427520fd60a10]
   linux-4.20.y: [078da99d449f64ca04d459cdbdcce513b64173cd]
   mainline: [979d63d50c0c0f7bc537bf821e056cc9fe5abd38]


=====================================
issues/CVE-2019-8912.yml
=====================================
@@ -0,0 +1,16 @@
+description: 'net: crypto set sk to NULL when af_alg_release.'
+references:
+- https://patchwork.ozlabs.org/patch/1042902/
+- https://bugzilla.novell.com/show_bug.cgi?id=1125907
+- https://bugzilla.novell.com/show_bug.cgi?id=1125907#c5
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-8912
+comments:
+  Debian-carnil: |-
+    This is a followup fix for
+    6d8c50dcb029872b298eea68cc6209c866fd3e14 (4.18-rc1) which was
+    CVE-2018-12232. CVE-2018-12232 was affecting only 4.10-rc1
+    onwards, quoting the note in CVE-2018-12232.
+introduced-by:
+  mainline: [86741ec25462e4c8cdce6df2f41ead05568c7d5e]
+fixed-by:
+  mainline: [9060cb719e61b685ec0102574e10337fa5f445ea]


=====================================
issues/CVE-2019-8956.yml
=====================================
@@ -0,0 +1,13 @@
+description: 'sctp: walk the list of asoc safely'
+references:
+- https://bugzilla.novell.com/show_bug.cgi?id=1124136
+- https://secuniaresearch.flexerasoftware.com/secunia_research/2019-5/
+comments:
+  Debian-carnil: 'Introduced in 4910280503f3 ("sctp: add support for snd flag SCTP_SENDALL
+    process in sendmsg") in 4.17-rc1.'
+introduced-by:
+  mainline: [4910280503f3af2857d5aa77e35b22d93a8960a8]
+fixed-by:
+  linux-4.19.y: [7c2361308e1727c3135ebb3b5c6906fb781bb261]
+  linux-4.20.y: [cc3a83d1428693d6039387a8bedbfe970d629867]
+  mainline: [ba59fb0273076637f0add4311faa990a5eec27c0]


=====================================
issues/CVE-2019-8980.yml
=====================================
@@ -0,0 +1,10 @@
+description: memory leak in the kernel_read_file function in fs/exec.c
+references:
+- https://lore.kernel.org/lkml/20190219021038.11340-1-yuehaibing at huawei.com/
+- https://lore.kernel.org/lkml/20190219022512.GW2217 at ZenIV.linux.org.uk/
+comments:
+  Debian-carnil: |-
+    Commit Fixes: 39d637af5aa7 ("vfs: forbid write access when
+    reading a file into memory") which is in 4.7-rc1
+introduced-by:
+  mainline: [39d637af5aa7577f655c58b9e55587566c63a0af]



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/6ed13434893858c8af2b7799a8ff451d68b4e9f4...8c45b2e3c8bfcab3413ff0b727a62a689ff7c1b8

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/6ed13434893858c8af2b7799a8ff451d68b4e9f4...8c45b2e3c8bfcab3413ff0b727a62a689ff7c1b8
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190221/ea8ff735/attachment-0001.html>

From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Tue, 27 Aug 2019 17:29:10 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 6
 commits: Import more data
Message-ID: <5d656866a5628_46c83f9ae1991504510932fb@sidekiq-asap-04-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
e7b59afe by Ben Hutchings at 2019-08-22T20:07:26Z
Import more data

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
00e48ddc by Ben Hutchings at 2019-08-22T20:16:25Z
Fill in further details about CVE-2019-15239

This was previously &quot;CVE-2019-tcp-reconnect-uaf&quot; before it got a CVE
ID.  It turns out to have been discovered multiple times but only
fixed in some branches until recently.

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
7d9748fd by Ben Hutchings at 2019-08-22T20:30:40Z
Fill in introduced-by commits for several issues

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
96ccc480 by Ben Hutchings at 2019-08-23T17:07:35Z
Un-ignore two USB audio issues for linux-4.19.y-cip-rt

The USB audio driver is enabled by the siemens_i386-rt configuration.

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
7c306459 by Ben Hutchings at 2019-08-23T17:09:44Z
Mark various issues to be ignored on CIP branches

The components affected by these issues are not enabled by any members
on some of the CIP branches.

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
83a64e32 by Ben Hutchings at 2019-08-27T17:29:07Z
Merge branch &#39;bwh/update-issues&#39; into &#39;master&#39;

Update issues

See merge request cip-project/cip-kernel/cip-kernel-sec!9
- - - - -


25 changed files:

- issues/CVE-2016-10905.yml
- issues/CVE-2016-10906.yml
- issues/CVE-2018-20976.yml
- issues/CVE-2019-13648.yml
- issues/CVE-2019-14283.yml
- issues/CVE-2019-14284.yml
- issues/CVE-2019-15117.yml
- issues/CVE-2019-15118.yml
- + issues/CVE-2019-15211.yml
- + issues/CVE-2019-15212.yml
- + issues/CVE-2019-15213.yml
- + issues/CVE-2019-15214.yml
- + issues/CVE-2019-15215.yml
- + issues/CVE-2019-15216.yml
- + issues/CVE-2019-15217.yml
- + issues/CVE-2019-15218.yml
- + issues/CVE-2019-15219.yml
- + issues/CVE-2019-15220.yml
- + issues/CVE-2019-15221.yml
- + issues/CVE-2019-15222.yml
- + issues/CVE-2019-15223.yml
- issues/CVE-2019-tcp-reconnect-uaf.yml ? issues/CVE-2019-15239.yml
- + issues/CVE-2019-15290.yml
- + issues/CVE-2019-15291.yml
- + issues/CVE-2019-15292.yml


Changes:

=====================================
issues/CVE-2016-10905.yml
=====================================
@@ -1,4 +1,8 @@
 description: 'GFS2: don''t set rgrp gl_object until it''s inserted into rgrp tree'
+references:
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-10905
+- https://git.kernel.org/linus/36e4ad0316c017d5b271378ed9a1c9a4b77fab5f
+- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=36e4ad0316c017d5b271378ed9a1c9a4b77fab5f
 fixed-by:
   mainline: [36e4ad0316c017d5b271378ed9a1c9a4b77fab5f]
 ignore:


=====================================
issues/CVE-2016-10906.yml
=====================================
@@ -1,4 +1,8 @@
 description: 'net: arc_emac: fix koops caused by sk_buff free'
+references:
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-10906
+- https://git.kernel.org/linus/c278c253f3d992c6994d08aa0efb2b6806ca396f
+- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c278c253f3d992c6994d08aa0efb2b6806ca396f
 fixed-by:
   mainline: [c278c253f3d992c6994d08aa0efb2b6806ca396f]
 ignore:


=====================================
issues/CVE-2018-20976.yml
=====================================
@@ -1,4 +1,8 @@
 description: 'xfs: clear sb->s_fs_info on mount failure'
+references:
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20976
+- https://git.kernel.org/linus/c9fbd7bbc23dbdd73364be4d045e5d3612cf6e82
+- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c9fbd7bbc23dbdd73364be4d045e5d3612cf6e82
 fixed-by:
   mainline: [c9fbd7bbc23dbdd73364be4d045e5d3612cf6e82]
 ignore:


=====================================
issues/CVE-2019-13648.yml
=====================================
@@ -24,3 +24,5 @@ fixed-by:
 ignore:
   linux-4.19.y-cip: No members are using powerpc
   linux-4.19.y-cip-rt: No members are using powerpc
+  linux-4.4.y-cip: No members are using powerpc
+  linux-4.4.y-cip-rt: No members are using powerpc


=====================================
issues/CVE-2019-14283.yml
=====================================
@@ -17,3 +17,4 @@ fixed-by:
 ignore:
   linux-4.19.y-cip: No members enable the floppy driver
   linux-4.19.y-cip-rt: No members enable the floppy driver
+  linux-4.4.y-cip: No members enable the floppy driver


=====================================
issues/CVE-2019-14284.yml
=====================================
@@ -17,3 +17,4 @@ fixed-by:
 ignore:
   linux-4.19.y-cip: No members enable the floppy driver
   linux-4.19.y-cip-rt: No members enable the floppy driver
+  linux-4.4.y-cip: No members enable the floppy driver


=====================================
issues/CVE-2019-15117.yml
=====================================
@@ -3,8 +3,17 @@ references:
 - https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?id=daac07156b330b18eb5071aec4b3ddca1c377f2c
 - https://lore.kernel.org/lkml/20190814023625.21683-1-benquike at gmail.com/
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15117
+comments:
+  Ubuntu-tyhicks: |-
+    The parse_audio_mixer_unit() function has changed its handling of the
+     input pins and source ID over time but I believe that it is vulnerable all
+     the way back to the start of git history.
+reporters:
+- Hui Peng
+- Mathias Payer
+introduced-by:
+  mainline: [1da177e4c3f41524e886b7f1b8a0c1fc7321cac2]
 fixed-by:
   mainline: [daac07156b330b18eb5071aec4b3ddca1c377f2c]
 ignore:
-  linux-4.19.y-cip-rt: No member enables USB audio
   linux-4.4.y-cip-rt: No member enables USB audio


=====================================
issues/CVE-2019-15118.yml
=====================================
@@ -7,8 +7,12 @@ comments:
   Debian-bwh: |-
     This is actually a stack overflow (unbounded recursion), not a
     stack buffer overflow.
+reporters:
+- Hui Peng
+- Mathias Payer
+introduced-by:
+  mainline: [1da177e4c3f41524e886b7f1b8a0c1fc7321cac2]
 fixed-by:
   mainline: [19bce474c45be69a284ecee660aa12d8f1e88f18]
 ignore:
-  linux-4.19.y-cip-rt: No member enables USB audio
   linux-4.4.y-cip-rt: No member enables USB audio


=====================================
issues/CVE-2019-15211.yml
=====================================
@@ -0,0 +1,20 @@
+description: 'media: radio-raremono: change devm_k*alloc to k*alloc'
+references:
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15211
+- https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.2.6
+- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c666355e60ddb4748ead3bdd983e3f7f2224aaf0
+- https://syzkaller.appspot.com/bug?id=775f90f43cfd6f8ac6c15251ce68e604453da226
+comments:
+  Debian-bwh: |-
+    Introduced in 3.14 by commit 21326c461e10 "[media] radio-raremono:
+    add support for 'Thanko's Raremono' AM/FM/SW USB device".
+introduced-by:
+  mainline: [21326c461e10431767e817e858e66113336d361c]
+fixed-by:
+  linux-4.19.y: [b3836af8560e27cd0d27940ff9c5a08b90b8d256]
+  linux-4.9.y: [4c0a7ec4b98f2e75ac974140291d3c8c6642145c]
+ignore:
+  linux-4.19.y-cip: No member enables radio-raremono
+  linux-4.19.y-cip-rt: No member enables radio-raremono
+  linux-4.4.y-cip: No member enables radio-raremono
+  linux-4.4.y-cip-rt: No member enables radio-raremono


=====================================
issues/CVE-2019-15212.yml
=====================================
@@ -0,0 +1,20 @@
+description: 'USB: rio500: refuse more than one device at a time'
+references:
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15212
+- https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.1.8
+- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3864d33943b4a76c6e64616280e98d2410b1190f
+- https://syzkaller.appspot.com/bug?id=64aa96c96f594a77eb8d945df21ec76dd35573b3
+fixed-by:
+  linux-4.14.y: [f18227d08e6b50717e1560a86fbebda0ca911507]
+  linux-4.19.y: [d2d93077bac37c6895d8c58f564699a3a897c5db]
+  linux-4.19.y-cip: [d2d93077bac37c6895d8c58f564699a3a897c5db]
+  linux-4.19.y-cip-rt: [d2d93077bac37c6895d8c58f564699a3a897c5db]
+  linux-4.4.y: [b92be99a0c8b2c1c66fe37f1fb21ef069c7732f1]
+  linux-4.4.y-cip: [b92be99a0c8b2c1c66fe37f1fb21ef069c7732f1]
+  linux-4.4.y-cip-rt: [b92be99a0c8b2c1c66fe37f1fb21ef069c7732f1]
+  linux-4.9.y: [6496f8ef3242b57f285e5c89134ad95dec17ab62]
+  mainline: [3864d33943b4a76c6e64616280e98d2410b1190f]
+ignore:
+  linux-4.19.y-cip: No member enables rio500
+  linux-4.19.y-cip-rt: No member enables rio500
+  linux-4.4.y-cip: No member enables rio500


=====================================
issues/CVE-2019-15213.yml
=====================================
@@ -0,0 +1,28 @@
+description: 'media: dvb: usb: use after free in dvb_usb_device_exit'
+references:
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15213
+- https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.2.3
+- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6cf97230cd5f36b7665099083272595c55d72be7
+- https://syzkaller.appspot.com/bug?id=a53c9c9dd2981bfdbfbcbc1ddbd35595eda8bced
+comments:
+  Debian-bwh: |-
+    This is supposed to be fixed by commit 6cf97230cd5f "media: dvb:
+    usb: fix use after free in dvb_usb_device_exit", but that won't fix
+    the syzkaller report it claims to.  The KASAN output shows an 8-byte
+    access to memory that was allocated in dw2102_probe(), apparently by
+    the statement "s421 = kmemdup(...)".  But it was also freed by
+    dw2102_probe(), so d->desc was already a dangling pointer before
+    dvb_usb_device_exit() was called.
+    The name strings seem to be static data that are only freed when
+    the module containing them is unloaded.  Which dvb_usb_device_exit()
+    doesn't do.
+    Introduced in 4.19 by commit 299c7007e936 "media: dw2102: Fix
+    memleak on sequence of probes".
+introduced-by:
+  linux-4.14.y: [6b7c7186c210df8fd3f2bd6f074715f4ac07979b]
+  mainline: [299c7007e93645067e1d2743f4e50156de78c4ff]
+ignore:
+  linux-4.19.y-cip: No member enables dw2102
+  linux-4.19.y-cip-rt: No member enables dw2102
+  linux-4.4.y-cip: No member enables dw2102
+  linux-4.4.y-cip-rt: No member enables dw2102


=====================================
issues/CVE-2019-15214.yml
=====================================
@@ -0,0 +1,20 @@
+description: ''
+references:
+- https://syzkaller.appspot.com/bug?id=75903e0021cef79bc434d068b5169b599b2a46a9
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15214
+- https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.0.10
+- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2a3f7221acddfe1caa9ff09b3a8158c39b2fdeac
+- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8c2f870890fd28e023b0fcf49dcee333f2c8bad7
+comments:
+  Debian-carnil: Check if 3.16-upstream-stable fixes complete.
+fixed-by:
+  linux-3.16.y: [dbcb50792a5175b222c181bafa51f470550ba827]
+  linux-4.14.y: [d11a33e9ba584bb6f5cc74df9d74b26156ba9bb2, 216f6570d18bcd06975205b8af1708ea10a1baf6]
+  linux-4.19.y: [b50e435df2d8b9a1d3e956e1c767dfc7e30a441b, 8a6f2ea0c3dd3de75cc344fe8d216457287a2ab2]
+  linux-4.19.y-cip: [b50e435df2d8b9a1d3e956e1c767dfc7e30a441b, 8a6f2ea0c3dd3de75cc344fe8d216457287a2ab2]
+  linux-4.19.y-cip-rt: [b50e435df2d8b9a1d3e956e1c767dfc7e30a441b, 8a6f2ea0c3dd3de75cc344fe8d216457287a2ab2]
+  linux-4.4.y: [f94135f92d97d85444691bcc4f79784d995a5458, abc81720ea872ba9b1fa6ac17e837456869b2281]
+  linux-4.4.y-cip: [f94135f92d97d85444691bcc4f79784d995a5458, abc81720ea872ba9b1fa6ac17e837456869b2281]
+  linux-4.4.y-cip-rt: [f94135f92d97d85444691bcc4f79784d995a5458, abc81720ea872ba9b1fa6ac17e837456869b2281]
+  linux-4.9.y: [d944299e7a6fce01db3603bc55d51ef336c19cc4, a9f62dc69942e2a9aeedd9f5d238674cf1882138]
+  mainline: [2a3f7221acddfe1caa9ff09b3a8158c39b2fdeac, 8c2f870890fd28e023b0fcf49dcee333f2c8bad7]


=====================================
issues/CVE-2019-15215.yml
=====================================
@@ -0,0 +1,25 @@
+description: 'media: cpia2_usb: first wake up, then free in disconnect'
+references:
+- https://syzkaller.appspot.com/bug?id=b68d3c254cf294f8a802582094fa3251d6de5247
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15215
+- https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.2.6
+- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eff73de2b1600ad8230692f00bc0ab49b166512a
+comments:
+  Debian-bwh: |-
+    Maybe introduced in 3.5 by commit 6c493f8b28c6 "[media] cpia2:
+    major overhaul to get it in a working state again", but might be
+    older.
+fixed-by:
+  linux-4.14.y: [3566a98e59b5cb19829d21bfe18cd396812ce15e]
+  linux-4.19.y: [8b44cc225e6024174508164931cab9f01c79dca2]
+  linux-4.19.y-cip: [8b44cc225e6024174508164931cab9f01c79dca2]
+  linux-4.4.y: [63a80df0ea2b94813f60e8372f9ee93856bcfd5b]
+  linux-4.4.y-cip: [63a80df0ea2b94813f60e8372f9ee93856bcfd5b]
+  linux-4.9.y: [0b8a71a8bd2129ca9cc115195fd9630564765772]
+  linux-5.2.y: [7951663c80a558ac97978e19ba893f9f6d3dec3d]
+  mainline: [eff73de2b1600ad8230692f00bc0ab49b166512a]
+ignore:
+  linux-4.19.y-cip: No member enables cpia2
+  linux-4.19.y-cip-rt: No member enables cpia2
+  linux-4.4.y-cip: No member enables cpia2
+  linux-4.4.y-cip-rt: No member enables cpia2


=====================================
issues/CVE-2019-15216.yml
=====================================
@@ -0,0 +1,17 @@
+description: 'USB: yurex: Fix protection fault after device removal'
+references:
+- https://syzkaller.appspot.com/bug?id=f0b1f2952022c75394c0eef2afeb17af90f9227e
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15216
+- https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.0.14
+- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ef61eb43ada6c1d6b94668f0f514e4c268093ff3
+fixed-by:
+  linux-3.16.y: [5133454a1f3a7f22412ab083f7ff53f822d50f49]
+  linux-4.14.y: [5696fa3f42168ee33256c0b0b72ca963d224327f]
+  linux-4.19.y: [9f632afe4f3989d77fdbf8ac6a015d6beb03ccb9]
+  linux-4.19.y-cip: [9f632afe4f3989d77fdbf8ac6a015d6beb03ccb9]
+  linux-4.19.y-cip-rt: [9f632afe4f3989d77fdbf8ac6a015d6beb03ccb9]
+  linux-4.4.y: [438b075fc77d63472892df735fe2a27d3f23dcbf]
+  linux-4.4.y-cip: [438b075fc77d63472892df735fe2a27d3f23dcbf]
+  linux-4.4.y-cip-rt: [438b075fc77d63472892df735fe2a27d3f23dcbf]
+  linux-4.9.y: [965cc8406cf38d6e535b264f5906211c3e5e33b7]
+  mainline: [ef61eb43ada6c1d6b94668f0f514e4c268093ff3]


=====================================
issues/CVE-2019-15217.yml
=====================================
@@ -0,0 +1,20 @@
+description: 'media: usb:zr364xx:Fix KASAN:null-ptr-deref Read in zr364xx_vidioc_querycap'
+references:
+- https://syzkaller.appspot.com/bug?id=9c0c178c24d828a7378f483309001329750aad64
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15217
+- https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.2.3
+- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5d2e73a5f80a5b5aff3caf1ec6d39b5b3f54b26e
+comments:
+  Debian-bwh: |-
+    Introduced in 2.6.32 by commit ccbf035ae5de "V4L/DVB (12278): zr364xx:
+    implement V4L2_CAP_STREAMING".
+introduced-by:
+  mainline: [ccbf035ae5de4c535160fc99f73feb44cc55b534]
+fixed-by:
+  linux-5.2.y: [702fc0f88dc5d6124594abafc678d7c3d6022863]
+  mainline: [5d2e73a5f80a5b5aff3caf1ec6d39b5b3f54b26e]
+ignore:
+  linux-4.19.y-cip: No member enables zr364xx
+  linux-4.19.y-cip-rt: No member enables zr364xx
+  linux-4.4.y-cip: No member enables zr364xx
+  linux-4.4.y-cip-rt: No member enables zr364xx


=====================================
issues/CVE-2019-15218.yml
=====================================
@@ -0,0 +1,22 @@
+description: 'media: usb: siano: Fix general protection fault in smsusb'
+references:
+- https://syzkaller.appspot.com/bug?id=4a5d7c8c2b6dbedb5b7218c6d7e8666bd2387517
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15218
+- https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.1.8
+- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=31e0456de5be379b10fea0fa94a681057114a96e
+comments:
+  Debian-bwh: |-
+    Introduced in 2.6.27 by commit 2e5c1ec8865a "V4L/DVB (8258): add support
+    for SMS1010 and SMS1150 based digital television devices".
+introduced-by:
+  mainline: [2e5c1ec8865abd81e24a394918c7ba315e0b7b70]
+fixed-by:
+  linux-4.14.y: [5a7adcda3de26a44fc0fa3f68199358b1527daf4]
+  linux-4.19.y: [35b1044566528b26d48b31a52069f45851d49885]
+  linux-4.19.y-cip: [35b1044566528b26d48b31a52069f45851d49885]
+  linux-4.19.y-cip-rt: [35b1044566528b26d48b31a52069f45851d49885]
+  linux-4.4.y: [b1782be70e1e281216f58ba283a0e55ad6364aaf]
+  linux-4.4.y-cip: [b1782be70e1e281216f58ba283a0e55ad6364aaf]
+  linux-4.4.y-cip-rt: [b1782be70e1e281216f58ba283a0e55ad6364aaf]
+  linux-4.9.y: [6ecd1809002699377d2b3b95b170d636f8a60eb4]
+  mainline: [31e0456de5be379b10fea0fa94a681057114a96e]


=====================================
issues/CVE-2019-15219.yml
=====================================
@@ -0,0 +1,22 @@
+description: 'USB: sisusbvga: fix oops in error path of sisusb_probe'
+references:
+- https://syzkaller.appspot.com/bug?id=aaf6794922521df1c35c81e32cb2d0bb6a351e7b
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15219
+- https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.1.8
+- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9a5729f68d3a82786aea110b1bfe610be318f80a
+comments:
+  Debian-bwh: |-
+    Introduced in 2.6.24 by commit 7b5cd5fefbe0 "USB: SisUSB2VGA: Convert
+    printk to dev_* macros".
+introduced-by:
+  mainline: [7b5cd5fefbe023625a7ff7604e8beb9a15a9efab]
+fixed-by:
+  linux-4.14.y: [47ffaae93ea154ae149315389a30780fa3189caf]
+  linux-4.19.y: [d27ea5e9eb4ac45e0e4cf8250a45aa06b0944787]
+  linux-4.19.y-cip: [d27ea5e9eb4ac45e0e4cf8250a45aa06b0944787]
+  linux-4.19.y-cip-rt: [d27ea5e9eb4ac45e0e4cf8250a45aa06b0944787]
+  linux-4.4.y: [30e66d7d2fb978f7b59fbf6106bdc1092acbb7ef]
+  linux-4.4.y-cip: [30e66d7d2fb978f7b59fbf6106bdc1092acbb7ef]
+  linux-4.4.y-cip-rt: [30e66d7d2fb978f7b59fbf6106bdc1092acbb7ef]
+  linux-4.9.y: [a45f178bcbf22d4c5c6e76dcc26e2b849cda6408]
+  mainline: [9a5729f68d3a82786aea110b1bfe610be318f80a]


=====================================
issues/CVE-2019-15220.yml
=====================================
@@ -0,0 +1,22 @@
+description: 'p54usb: Fix race between disconnect and firmware loading'
+references:
+- https://syzkaller.appspot.com/bug?id=082c09653e43e33a6a56f8c57cf051eeacae9d5f
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15220
+- https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.2.1
+- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e41e2257f1094acc37618bf6c856115374c6922
+comments:
+  Debian-bwh: |-
+    Probably introduced in 3.5 by commit 5612a508d11f "p54usb: Load firmware
+    asynchronously".
+introduced-by:
+  mainline: [5612a508d11f81c1ca3290260f86328dfb55d513]
+fixed-by:
+  linux-4.14.y: [c760ecb74f84f729ae31b9fbc6b772923cdc78df]
+  linux-4.19.y: [449a8d08a4bc45101fa26e6d233b98258d33620a]
+  linux-4.19.y-cip: [449a8d08a4bc45101fa26e6d233b98258d33620a]
+  linux-4.9.y: [feca0ce34518f69447d0d13cd431d0eef647a794]
+  linux-5.2.y: [9baa5b4925da756e7a47444514bc88a6818d300f]
+  mainline: [6e41e2257f1094acc37618bf6c856115374c6922]
+ignore:
+  linux-4.4.y-cip: No member enables p54usb
+  linux-4.4.y-cip-rt: No member enables p54usb


=====================================
issues/CVE-2019-15221.yml
=====================================
@@ -0,0 +1,21 @@
+description: 'ALSA: line6: Fix write on zero-sized buffer'
+references:
+- https://syzkaller.appspot.com/bug?id=240f09164db2c3d3af33a117c713dc7650dc29d6
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15221
+- https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.1.17
+- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3450121997ce872eb7f1248417225827ea249710
+comments:
+  Ubuntu-tyhicks: |-
+    Setting priority to low since this issue requires a malicious piece
+     of hardware to be exploited
+fixed-by:
+  linux-4.14.y: [37eaa74451c1003a6bec548c957890c264559463]
+  linux-4.19.y: [7f52af5e9baa9c478edcecdd4058eeef2835b1c3]
+  linux-4.19.y-cip: [7f52af5e9baa9c478edcecdd4058eeef2835b1c3]
+  linux-4.9.y: [8b449e9dc215e47641c4737a199b7767ffd032a9]
+  mainline: [3450121997ce872eb7f1248417225827ea249710]
+ignore:
+  linux-4.19.y-cip: No member enables line6
+  linux-4.19.y-cip-rt: No member enables line6
+  linux-4.4.y-cip: No member enables line6
+  linux-4.4.y-cip-rt: No member enables line6


=====================================
issues/CVE-2019-15222.yml
=====================================
@@ -0,0 +1,17 @@
+description: 'ALSA: usb-audio: Fix gpf in snd_usb_pipe_sanity_check'
+references:
+- https://syzkaller.appspot.com/bug?id=3ec1dad62657fef22282536d7532dbb65eee778a
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15222
+- https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.2.8
+- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5d78e1c2b7f4be00bbe62141603a631dc7812f35
+comments:
+  Debian-bwh: |-
+    Introduced in 5.3-rc1 by commit 801ebf1043ae "ALSA: usb-audio: Sanity
+    checks for each pipe and EP types" (!).  Both the breaking and fixing
+    commits were backported in 5.2.8.
+introduced-by:
+  linux-5.2.y: [f7795140ac4aaf867e84d202f6107921a358e50f]
+  mainline: [801ebf1043ae7b182588554cc9b9ad3c14bc2ab5]
+fixed-by:
+  linux-5.2.y: [bcbfb3efab0671590a14c7baf104173e49b7b248]
+  mainline: [5d78e1c2b7f4be00bbe62141603a631dc7812f35]


=====================================
issues/CVE-2019-15223.yml
=====================================
@@ -0,0 +1,21 @@
+description: 'ALSA: line6: Assure canceling delayed work at disconnection'
+references:
+- https://syzkaller.appspot.com/bug?id=0c1e517c657d3de2361cb0cc2d3a8663c25039a7
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15223
+- https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.1.8
+- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0b074ab7fc0d575247b9cc9f93bb7e007ca38840
+comments:
+  Debian-bwh: |-
+    Introduced in 5.2-rc1 by commit 7f84ff68be05 "ALSA: line6: toneport: Fix
+    broken usage of timer for delayed execution".  This was backported
+    into 4.19.45.
+introduced-by:
+  linux-4.19.y: [741e3efd8174fbc4278bc3dd8d3d5a3caab7f2c5]
+  linux-4.19.y-cip: [741e3efd8174fbc4278bc3dd8d3d5a3caab7f2c5]
+  linux-4.19.y-cip-rt: [741e3efd8174fbc4278bc3dd8d3d5a3caab7f2c5]
+  mainline: [7f84ff68be05ec7a5d2acf8fdc734fe5897af48f]
+fixed-by:
+  linux-4.19.y: [eb2eeec920fb1b9b6faf8ea340f6295a2d03602b]
+  linux-4.19.y-cip: [eb2eeec920fb1b9b6faf8ea340f6295a2d03602b]
+  linux-4.19.y-cip-rt: [eb2eeec920fb1b9b6faf8ea340f6295a2d03602b]
+  mainline: [0b074ab7fc0d575247b9cc9f93bb7e007ca38840]


=====================================
issues/CVE-2019-tcp-reconnect-uaf.yml ? issues/CVE-2019-15239.yml
=====================================
@@ -1,13 +1,32 @@
-description: TCP reconnection use-after-free
+description: |-
+  In the Linux kernel, a certain net/ipv4/tcp_output.c change, which was
+  properly incorporated into 4.16.12, was incorrectly backported to the
+  earlier longterm kernels, introducing a new vulnerability that was
+  potentially more severe than the issue that was intended to be fixed by
+  backporting. Specifically, by adding to a write queue between disconnection
+  and re-connection, a local attacker can trigger multiple use-after-free
+  conditions. This can result in a kernel crash, or potentially in privilege
+  escalation. NOTE: this affects (for example) Linux distributions that use
+  4.9.x longterm kernels before 4.9.190 or 4.14.x longterm kernels before
+  4.14.139.
 references:
-- https://lore.kernel.org/stable/20190813115317.6cgml2mckd3c6u7z at decadent.org.uk/
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15239
 - https://pulsesecurity.co.nz/advisories/linux-kernel-4.9-tcpsocketsuaf
+- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7f582b248d0a86bae5788c548d7bb5bca6f7691a
+- https://lore.kernel.org/stable/41a61a2f87691d2bc839f26cdfe6f5ff2f51e472.camel at decadent.org.uk/
+- https://salsa.debian.org/kernel-team/kernel-sec/blob/f6273af2d956a87296b6b60379d0a186c9be4bbc/active/CVE-2019-15239
+- https://www.debian.org/security/2019/dsa-4497
 comments:
   Debian-bwh: |-
     Introduced by backports of commit 7f582b248d0a
     "tcp: purge write queue in tcp_connect_init()" to stable.
     Upstream avoided this issue due to the earlier commit
     75c119afe14f "tcp: implement rb-tree based retransmit queue".
+  Debian-carnil: |-
+    As pointed out by Ben, in https://lore.kernel.org/stable/41a61a2f87691d2bc839f26cdfe6f5ff2f51e472.camel at decadent.org.uk/
+    the issue got already fixed by dbbf2d1e4077 ("tcp: reset
+    sk_send_head in tcp_write_queue_purge") in 4.14.32, which got
+    backported to 4.4.187 and 4.9.187.
 introduced-by:
   linux-3.16.y: [0da162e05f65a8073ef1dc3c7598b82a9b9caa70]
   linux-3.18.y: [85611642047443ea8567f5cccc4c282fedde11b6]
@@ -18,4 +37,8 @@ introduced-by:
   linux-4.9.y: [74a4c09d4b05c67ed6bd6aed088a5552f4f64aaa]
   mainline: never
 fixed-by:
-  linux-4.14.y: [e99e7745d03fc50ba7c5b7c91c17294fee2d5991]
+  linux-3.16.y: [3157fbc900bdb366b2186e5a6e506cc5e4697cf0]
+  linux-4.14.y: [dbbf2d1e4077bab0c65ece2765d3fc69cf7d610f]
+  linux-4.4.y: [8f0b77b71f3fec09f86f80cd98c36a1a35109499]
+  linux-4.4.y-cip: [8f0b77b71f3fec09f86f80cd98c36a1a35109499]
+  linux-4.9.y: [704533394e488a109fe46ab3693315376c3824d5]


=====================================
issues/CVE-2019-15290.yml
=====================================
@@ -0,0 +1,6 @@
+description: general protection fault in ath6kl_usb_alloc_urb_from_pipe
+references:
+- https://syzkaller.appspot.com/bug?id=cd8b9cfe50a0bf36ee19eda2d7e2e06843dfbeaf
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15290
+- https://www.openwall.com/lists/oss-security/2019/08/20/2
+- http://www.openwall.com/lists/oss-security/2019/08/20/2


=====================================
issues/CVE-2019-15291.yml
=====================================
@@ -0,0 +1,11 @@
+description: general protection fault in flexcop_usb_probe
+references:
+- https://syzkaller.appspot.com/bug?id=c0203bd72037d07493f4b7562411e4f5f4553a8f
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15291
+- https://www.openwall.com/lists/oss-security/2019/08/20/2
+- http://www.openwall.com/lists/oss-security/2019/08/20/2
+ignore:
+  linux-4.19.y-cip: No member enables flexcop
+  linux-4.19.y-cip-rt: No member enables flexcop
+  linux-4.4.y-cip: No member enables flexcop
+  linux-4.4.y-cip-rt: No member enables flexcop


=====================================
issues/CVE-2019-15292.yml
=====================================
@@ -0,0 +1,15 @@
+description: 'appletalk: Fix use-after-free in atalk_proc_exit'
+references:
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15292
+- https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.0.9
+- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6377f787aeb945cae7abbb6474798de129e1f3ac
+fixed-by:
+  linux-4.14.y: [0ba1fa56351e6e9c2f8db4ffc823cb7057e4ea82]
+  linux-4.19.y: [6c42507f426b40c63e8eb98ce6dd4afbc7efcdb5]
+  linux-4.19.y-cip: [6c42507f426b40c63e8eb98ce6dd4afbc7efcdb5]
+  linux-4.19.y-cip-rt: [6c42507f426b40c63e8eb98ce6dd4afbc7efcdb5]
+  linux-4.4.y: [d49a75f5add4543eb138fb0a8fe0560fb276352e]
+  linux-4.4.y-cip: [d49a75f5add4543eb138fb0a8fe0560fb276352e]
+  linux-4.4.y-cip-rt: [d49a75f5add4543eb138fb0a8fe0560fb276352e]
+  linux-4.9.y: [057a0da1899f00a4ac9a4c4c452cf2cf652bdbf0]
+  mainline: [6377f787aeb945cae7abbb6474798de129e1f3ac]



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/f487d464ae208e322cfb2a4b95afd84f317f0c71...83a64e3270c1db80aac178c3ec98a0093364a16b

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/f487d464ae208e322cfb2a4b95afd84f317f0c71...83a64e3270c1db80aac178c3ec98a0093364a16b
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190827/8498eefe/attachment-0001.html>

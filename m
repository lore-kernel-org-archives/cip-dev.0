From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Wed, 21 Aug 2019 14:14:43 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 7
 commits: Import more data
Message-ID: <5d5d51d3f181a_68e63f82210491644824112@sidekiq-asap-02-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
6c4f9997 by Ben Hutchings at 2019-08-19T13:54:12Z
Import more data

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
c4379a84 by Ben Hutchings at 2019-08-19T13:56:16Z
Fix commit lists for CVE-2019-9506

Multiple commits are required to fix this properly.

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
a2278da3 by Ben Hutchings at 2019-08-19T13:59:49Z
Record fix for TCP reconnect use-after-free on linux-4.14.y

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
a4de3abd by Ben Hutchings at 2019-08-19T14:08:37Z
Note regression fix needed when fixing ctnetlink address leak

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
2dc6b28f by Ben Hutchings at 2019-08-19T14:30:50Z
Mark various issues to be ignored on CIP branches

The components affected by these issued are not enabled by any members
on some of the CIP branches.

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
efbae131 by Ben Hutchings at 2019-08-19T18:05:05Z
Note additional commit needed to fix CVE-2019-11487 on linux-4.9.y

- - - - -
4b5919c3 by Ben Hutchings at 2019-08-21T14:14:40Z
Merge branch &#39;bwh/update-issues&#39; into &#39;master&#39;

Update issues

See merge request cip-project/cip-kernel/cip-kernel-sec!7
- - - - -


28 changed files:

- issues/CVE-2013-7445.yml
- + issues/CVE-2016-10905.yml
- + issues/CVE-2016-10906.yml
- issues/CVE-2016-1576.yml
- issues/CVE-2016-8660.yml
- issues/CVE-2017-18509.yml
- issues/CVE-2018-1128.yml
- issues/CVE-2018-1129.yml
- issues/CVE-2018-13094.yml
- issues/CVE-2018-13095.yml
- issues/CVE-2018-17977.yml
- issues/CVE-2018-20961.yml
- + issues/CVE-2018-20976.yml
- issues/CVE-2018-9517.yml
- issues/CVE-2019-0136.yml
- issues/CVE-2019-1125.yml
- issues/CVE-2019-11487.yml
- issues/CVE-2019-12881.yml
- + issues/CVE-2019-15090.yml
- + issues/CVE-2019-15098.yml
- + issues/CVE-2019-15099.yml
- + issues/CVE-2019-15117.yml
- + issues/CVE-2019-15118.yml
- issues/CVE-2019-3900.yml
- + issues/CVE-2019-9506.yml
- issues/CVE-2019-ctnl-addr-leak.yml
- issues/CVE-2019-kvm-guest-xcr0.yml
- issues/CVE-2019-tcp-reconnect-uaf.yml


Changes:

=====================================
issues/CVE-2013-7445.yml
=====================================
@@ -15,3 +15,5 @@ comments:
 ignore:
   linux-3.16.y: Fix is likely to be too big and risky to backport
   linux-3.2.y: Fix is likely to be too big and risky to backport
+  linux-4.19.y-cip-rt: No member enables DRM
+  linux-4.4.y-cip-rt: No member enables DRM


=====================================
issues/CVE-2016-10905.yml
=====================================
@@ -0,0 +1,6 @@
+description: 'GFS2: don''t set rgrp gl_object until it''s inserted into rgrp tree'
+fixed-by:
+  mainline: [36e4ad0316c017d5b271378ed9a1c9a4b77fab5f]
+ignore:
+  linux-4.19.y-cip-rt: No member enables GFS2
+  linux-4.4.y-cip-rt: No member enables GFS2


=====================================
issues/CVE-2016-10906.yml
=====================================
@@ -0,0 +1,6 @@
+description: 'net: arc_emac: fix koops caused by sk_buff free'
+fixed-by:
+  mainline: [c278c253f3d992c6994d08aa0efb2b6806ca396f]
+ignore:
+  linux-4.4.y-cip: No member enables arc_emac
+  linux-4.4.y-cip-rt: No member enables arc_emac


=====================================
issues/CVE-2016-1576.yml
=====================================
@@ -54,3 +54,6 @@ introduced-by:
   mainline: [e9be9d5e76e34872f0c37d72e25bc27fe9e2c54c]
 fixed-by:
   mainline: never
+ignore:
+  linux-4.19.y-cip-rt: No member enables overlayfs
+  linux-4.4.y-cip-rt: No member enables overlayfs


=====================================
issues/CVE-2016-8660.yml
=====================================
@@ -22,3 +22,6 @@ comments:
      above)
 introduced-by:
   mainline: [fc0561cefc04e7803c0f6501ca4f310a502f65b8]
+ignore:
+  linux-4.19.y-cip-rt: No member enables XFS
+  linux-4.4.y-cip-rt: No member enables XFS


=====================================
issues/CVE-2017-18509.yml
=====================================
@@ -2,6 +2,15 @@ description: IPv6 mroute missing type check
 references:
 - https://lists.openwall.net/netdev/2017/12/04/40
 - https://pulsesecurity.co.nz/advisories/linux-kernel-4.9-inetcsklistenstop-gpf
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-18509
+- https://git.kernel.org/linus/99253eb750fda6a644d5188fb26c43bad8d5a745
+- https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=99253eb750fda6a644d5188fb26c43bad8d5a745
+- https://github.com/torvalds/linux/commit/99253eb750fda6a644d5188fb26c43bad8d5a745
+- https://lists.debian.org/debian-lts-announce/2019/08/msg00016.html
+- https://salsa.debian.org/kernel-team/linux/commit/baefcdc2f29923e7325ce4e1a72c3ff0a9800f32
+- https://www.debian.org/security/2019/dsa-4497
+introduced-by:
+  mainline: [d1db275dd3f6e4182c4c4b4a1ac6287925d60569]
 fixed-by:
   linux-3.16.y: [2b8d63b97d78835d3cd75b0ee344d21489df4edc]
   linux-4.4.y: [ee2f25641633ffb03fb88e4fa8a6424d24d3f295]


=====================================
issues/CVE-2018-1128.yml
=====================================
@@ -24,3 +24,5 @@ fix-depends-on:
   b3bbd3f2ab19c8ca319003b4b51ce4c4ca74da06: Simplifies backporting of 262614c4294d.
 ignore:
   linux-3.16.y: Protocol change is too difficult
+  linux-4.19.y-cip-rt: No member enables ceph
+  linux-4.4.y-cip-rt: No member enables ceph


=====================================
issues/CVE-2018-1129.yml
=====================================
@@ -5,3 +5,6 @@ fixed-by:
   linux-4.14.y: [b16d0c5d32468a0624505a7b6b211e20488295e9]
   linux-4.9.y: [18a23fb2632030888fc56a7df73a80f57445718f]
   mainline: [cc255c76c70f7a87d97939621eae04b600d9f4a1]
+ignore:
+  linux-4.19.y-cip-rt: No member enables ceph
+  linux-4.4.y-cip-rt: No member enables ceph


=====================================
issues/CVE-2018-13094.yml
=====================================
@@ -18,3 +18,6 @@ fixed-by:
   linux-4.14.y: [59f35b983e8aeb98188c6ef93f8eabc594f8f953]
   linux-4.17.y: [173f00f40107e5099eb8a74ea7b7ff0e662ec80b]
   mainline: [bb3d48dcf86a97dc25fe9fc2c11938e19cb4399a]
+ignore:
+  linux-4.19.y-cip-rt: No member enables XFS
+  linux-4.4.y-cip-rt: No member enables XFS


=====================================
issues/CVE-2018-13095.yml
=====================================
@@ -16,3 +16,5 @@ fixed-by:
   mainline: [23fcb3340d033d9f081e21e6c12c2db7eaa541d3]
 ignore:
   linux-3.16.y: Too risky to backport
+  linux-4.19.y-cip-rt: No member enables XFS
+  linux-4.4.y-cip-rt: No member enables XFS


=====================================
issues/CVE-2018-17977.yml
=====================================
@@ -9,3 +9,5 @@ comments:
   Ubuntu-sbeattie: |-
     reporter's detailed descriptions were in google drive
       documents which have been made unavailable.
+ignore:
+  linux-4.4.y-cip-rt: No member enables xfrm


=====================================
issues/CVE-2018-20961.yml
=====================================
@@ -12,3 +12,7 @@ fixed-by:
   linux-4.14.y: [96dc465173a1f790e805246206aee3d18770f614]
   linux-4.9.y: [b3b0809ac25c3ffedc58e7f83bc01a03193e7834]
   mainline: [7fafcfdf6377b18b2a726ea554d6e593ba44349f]
+ignore:
+  linux-4.19.y-cip: No member enables f_midi
+  linux-4.19.y-cip-rt: No member enables f_midi
+  linux-4.4.y-cip-rt: No member enables f_midi


=====================================
issues/CVE-2018-20976.yml
=====================================
@@ -0,0 +1,6 @@
+description: 'xfs: clear sb->s_fs_info on mount failure'
+fixed-by:
+  mainline: [c9fbd7bbc23dbdd73364be4d045e5d3612cf6e82]
+ignore:
+  linux-4.19.y-cip-rt: No member enables XFS
+  linux-4.4.y-cip-rt: No member enables XFS


=====================================
issues/CVE-2018-9517.yml
=====================================
@@ -12,3 +12,6 @@ fixed-by:
   linux-3.16.y: [0b3ca265e81f5e1d9f7f66ad416cbabecca914cf]
   linux-3.2.y: [ca8172873304dbc6c6047b698452d9c89d86f037]
   mainline: [f026bc29a8e093edfbb2a77700454b285c97e8ad]
+ignore:
+  linux-4.19.y-cip-rt: No member enables L2TP
+  linux-4.4.y-cip-rt: No member enables L2TP


=====================================
issues/CVE-2019-0136.yml
=====================================
@@ -10,4 +10,7 @@ comments:
     Ubuntu was told by an OEM that upstream commits
      588f7d39b3592a36fb7702ae3b8bdd9be4621e2f and
      79c92ca42b5a3e0ea172ea2ce8df8e125af237da address this CVE. We've reached out
-     to Intel to confirm the commits and are waiting to hear back.
+     to Intel, on 2019-08-08, to confirm the commits and are waiting to hear back.
+ignore:
+  linux-4.19.y-cip-rt: No member enables iwlwifi
+  linux-4.4.y-cip-rt: No member enables iwlwifi


=====================================
issues/CVE-2019-1125.yml
=====================================
@@ -34,7 +34,8 @@ fixed-by:
   linux-4.4.y: [e3d8c979c49d6113566acf4b3002073979cd35c3, 73e2c1bd2714f902c5ee290445579b79afc6a0e6,
     967858f2f222dd140429c70d855e85dafcc89c29, 62dcfbb199c436405fa9be23273e47068db36b0a]
   linux-4.9.y: [e90ec5e2b679fd882a0f59eb1bf155d96b34b29c, 90d45f0856f3479a742ae29d5150c59116d3f34a,
-    6583ecced632cf7f92ff8313d9a6d168df291124, 2224e89446b6095988606ffee3c040e6a7a2c049]
+    6583ecced632cf7f92ff8313d9a6d168df291124, 2224e89446b6095988606ffee3c040e6a7a2c049,
+    7092a21c757c35d1f924da06092dbed7c113f79a]
   linux-5.2.y: [6b5145c74f91dd46cb299f9e0a42a0b6df1055bd, 405d06fba6937bf272917ec36bd1cf4ad7f7f286,
     061b8f7dfb9c4b8afcf20e9873f064438b0d8046, 6ec6d45454123ca5281f2f4aea68235c6b0770fb,
     726d427e17b9185d9a35409a6c2a0a991615df6a]


=====================================
issues/CVE-2019-11487.yml
=====================================
@@ -23,6 +23,9 @@ comments:
     604d7b594c6d ("mm: add 'try_get_page()' helper function") was
     already added in 4.9.175, possibly for preparation.
   Ubuntu-tyhicks: Requires >= 140 GiB of RAM which is rare
+  bwh: |
+    For kernel versions before 4.13, arch/x86/mm/gup.c also needs to be
+    updated.  This is done by the last commit listed for linux-4.9.y.
 reporters:
 - Jann Horn
 introduced-by:
@@ -37,7 +40,8 @@ fixed-by:
   linux-4.19.y-cip-rt: [0311ff82b70fa12e80d188635bff24029ec06ae1, 0612cae7ec6b79d2ff1b34562bab79d5bf96327a,
     d972ebbf42ba6712460308ae57c222a0706f2af3, 9f6da5fd05577ef4a05c1744cc7098d0173823af]
   linux-4.9.y: [9557090582a33801349f0a0920a55d134a27e740, 604d7b594c6d18582650dd06b201643b15202232,
-    2ed768cfd8956df77f60dd073251699ad3e56cd4, 96019c69145840a498e4e988f56a7524dc0c59b7]
+    2ed768cfd8956df77f60dd073251699ad3e56cd4, 96019c69145840a498e4e988f56a7524dc0c59b7,
+    d73af79742e708a171c1a224759fb0661ed6fcac]
   linux-5.0.y: [27f651142eec95373c7ed6e10a3929fab1733c1a, bdc8dfd6587378458e248e36ab79a129f24ba8e9,
     ad73e3a199066ad9bf48ea1334ef312e5aa078f4, 258fc3baeb4b2da15391735fd806facf4a91b585]
   mainline: [15fab63e1e57be9fdb5eec1bbc5916e9825e9acb, 88b1a17dfc3ed7728316478fae0f5ad508f50397,


=====================================
issues/CVE-2019-12881.yml
=====================================
@@ -8,3 +8,6 @@ comments:
   Ubuntu-tyhicks: |-
     This issue only affects systems with Intel GPUs that utilize the i915
      graphics driver
+ignore:
+  linux-4.19.y-cip-rt: No member enables i915
+  linux-4.4.y-cip-rt: No member enables i915


=====================================
issues/CVE-2019-15090.yml
=====================================
@@ -0,0 +1,17 @@
+description: 'scsi: qedi: remove memset/memcpy to nfunc and use func instead'
+references:
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15090
+- https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.1.12
+- https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c09581a52765a85f19fc35340127396d5e3379cc
+- https://github.com/torvalds/linux/commit/c09581a52765a85f19fc35340127396d5e3379cc
+comments:
+  Debian-carnil: |-
+    Issue introduced in ace7f46ba5fd ("scsi: qedi: Add QLogic
+    FastLinQ offload iSCSI driver framework.") in 4.10-rc1.
+introduced-by:
+  mainline: [ace7f46ba5fde7273207c7122b0650ceb72510e0]
+fixed-by:
+  linux-4.14.y: [af1630c6dc4fd96c09fef088f9c400c35e259e72]
+  linux-4.19.y: [f3a7a1137ffc69e1f460eb9e1b5f4fd09d3c4ea9]
+  linux-4.19.y-cip: [f3a7a1137ffc69e1f460eb9e1b5f4fd09d3c4ea9]
+  mainline: [c09581a52765a85f19fc35340127396d5e3379cc]


=====================================
issues/CVE-2019-15098.yml
=====================================
@@ -0,0 +1,12 @@
+description: Fix a NULL-ptr-deref bug in ath6kl_usb_alloc_urb_from_pipe
+references:
+- https://lore.kernel.org/linux-wireless/20190804002905.11292-1-benquike at gmail.com/T/#u
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15098
+comments:
+  Debian-bwh: |-
+    Introduced in Linux 3.5 by commit 9cbee358687e "ath6kl: add full USB
+    support".
+introduced-by:
+  mainline: [9cbee358687edf0359e29ac683ec25835134f059]
+ignore:
+  linux-4.4.y-cip-rt: No member enables ath6kl


=====================================
issues/CVE-2019-15099.yml
=====================================
@@ -0,0 +1,10 @@
+description: Fix a NULL-ptr-deref bug in ath10k_usb_alloc_urb_from_pipe
+references:
+- https://lore.kernel.org/linux-wireless/20190804003101.11541-1-benquike at gmail.com/T/#u
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15099
+comments:
+  Debian-bwh: |-
+    Introduced in 4.14 by commit 4db66499df91 "ath10k: add initial USB
+    support".
+introduced-by:
+  mainline: [4db66499df91b9398435e2dbee0e42cd6df0bc27]


=====================================
issues/CVE-2019-15117.yml
=====================================
@@ -0,0 +1,10 @@
+description: 'ALSA: usb-audio: Fix an OOB bug in parse_audio_mixer_unit'
+references:
+- https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?id=daac07156b330b18eb5071aec4b3ddca1c377f2c
+- https://lore.kernel.org/lkml/20190814023625.21683-1-benquike at gmail.com/
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15117
+fixed-by:
+  mainline: [daac07156b330b18eb5071aec4b3ddca1c377f2c]
+ignore:
+  linux-4.19.y-cip-rt: No member enables USB audio
+  linux-4.4.y-cip-rt: No member enables USB audio


=====================================
issues/CVE-2019-15118.yml
=====================================
@@ -0,0 +1,14 @@
+description: 'ALSA: usb-audio: Fix a stack buffer overflow bug in check_input_term'
+references:
+- https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?id=19bce474c45be69a284ecee660aa12d8f1e88f18
+- https://lore.kernel.org/lkml/20190815043554.16623-1-benquike at gmail.com/
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15118
+comments:
+  Debian-bwh: |-
+    This is actually a stack overflow (unbounded recursion), not a
+    stack buffer overflow.
+fixed-by:
+  mainline: [19bce474c45be69a284ecee660aa12d8f1e88f18]
+ignore:
+  linux-4.19.y-cip-rt: No member enables USB audio
+  linux-4.4.y-cip-rt: No member enables USB audio


=====================================
issues/CVE-2019-3900.yml
=====================================
@@ -19,3 +19,6 @@ fixed-by:
     02cdc166128cf9cb2be4786b997eebbc0b976bfa]
   mainline: [e2412c07f8f3040593dfb88207865a3cd58680c0, e79b431fb901ba1106670bcc80b9b617b25def7d,
     c1ea02f15ab5efb3e93fc3144d895410bf79fcf2]
+ignore:
+  linux-4.19.y-cip-rt: No member enables vhost drivers
+  linux-4.4.y-cip-rt: No member enables vhost drivers


=====================================
issues/CVE-2019-9506.yml
=====================================
@@ -0,0 +1,36 @@
+description: BR/EDR encryption key negotiation attacks (KNOB)
+references:
+- https://kb.cert.org/vuls/id/918987/
+- https://knobattack.com/
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9506
+- https://www.usenix.org/conference/usenixsecurity19/presentation/antonioli
+- https://www.bluetooth.com/security/statement-key-negotiation-of-bluetooth/
+comments:
+  Debian-carnil: HW issue, but some mitigations are applied in Linux
+  Ubuntu-mdeslaur: |-
+    As of 2019-08-16, no exact details on what the fix for this
+    issue is, but likely to be implemented in bluetooth firmware.
+    As such, and since this requires that the attacker be in
+    Bluetooth range, downgrading priority to medium.
+  Ubuntu-sbeattie: CERT VU#918987
+reporters:
+- Daniele Antonioli
+- Nils Ole Tippenhauer
+- Kasper B. Rasmussen
+fixed-by:
+  linux-4.14.y: [2fa7a155b25160696cd77cdd995536cf5e172e20, 1fd49b11c8f7c0bf1f018144266cd6c1de1e6056,
+    05206de4e9ae033afd32f685c4a005cbc1dceb39]
+  linux-4.19.y: [38f092c41cebaff589e88cc22686b289a6840559, db7f1076c0bd26832ee3b94eccc1a815c7dac32d,
+    5dd6139a0aa22112e46a6df5fd283046095822e0]
+  linux-4.19.y-cip: [38f092c41cebaff589e88cc22686b289a6840559, db7f1076c0bd26832ee3b94eccc1a815c7dac32d,
+    5dd6139a0aa22112e46a6df5fd283046095822e0]
+  linux-4.4.y: [d016dc1bd29a2cfb0707fc6fb290ccd21f3b139c, 59f9ad4b789db877ded449f9ec4595ae593403e4,
+    993699d9de09097e2bfd49100b8904774e5304fb]
+  linux-4.4.y-cip: [d016dc1bd29a2cfb0707fc6fb290ccd21f3b139c, 59f9ad4b789db877ded449f9ec4595ae593403e4,
+    993699d9de09097e2bfd49100b8904774e5304fb]
+  linux-4.4.y-cip-rt: [d016dc1bd29a2cfb0707fc6fb290ccd21f3b139c, 59f9ad4b789db877ded449f9ec4595ae593403e4,
+    993699d9de09097e2bfd49100b8904774e5304fb]
+  linux-4.9.y: [745f5c5f2ac14ac1cbb7fe3cbdc893c9d1af1356, 68d1e285e934c50df37d807a8e7ae29397c055bc,
+    f470557724f2c94c25e4f6480a41612cf42aff26]
+  mainline: [d5bb334a8e171b262e48f378bd2096c0ea458265, 693cd8ce3f882524a5d06f7800dd8492411877b3,
+    eca94432934fe5f141d084f2e36ee2c0e614cc04]


=====================================
issues/CVE-2019-ctnl-addr-leak.yml
=====================================
@@ -1,6 +1,10 @@
 description: ctnetlink uses kernel addresses as user-visible IDs
 comments:
   Debian-bwh: Fix depends on adding siphash
+  bwh: |
+    Introduces a regression which is fixed by commit 656c8e9cc1ba
+    "netfilter: conntrack: Use consistent ct id hash calculation",
+    which is not yet upstream.
 fixed-by:
   linux-3.16.y: [3d8b3d0384f709126beef6b917b7e97c23f18e74]
   linux-4.14.y: [f862c13c3c926d3008b2c2bcc746ab813108dfbf]
@@ -8,3 +12,6 @@ fixed-by:
   linux-4.19.y-cip: [7b115755fb9d3aff0ddcd18a5c4d83381362acce]
   linux-4.19.y-cip-rt: [7b115755fb9d3aff0ddcd18a5c4d83381362acce]
   mainline: [3c79107631db1f7fd32cf3f7368e4672004a3010]
+ignore:
+  linux-4.19.y-cip-rt: No member enables nf_conntrack
+  linux-4.4.y-cip-rt: No member enables nf_conntrack


=====================================
issues/CVE-2019-kvm-guest-xcr0.yml
=====================================
@@ -6,3 +6,6 @@ comments:
     only to avoid conflicts.  But this in turn needs further fixes.
 fixed-by:
   mainline: [1811d979c71621aafc7b879477202d286f7e863b]
+ignore:
+  linux-4.19.y-cip-rt: No member enables KVM
+  linux-4.4.y-cip-rt: No member enables KVM


=====================================
issues/CVE-2019-tcp-reconnect-uaf.yml
=====================================
@@ -4,11 +4,10 @@ references:
 - https://pulsesecurity.co.nz/advisories/linux-kernel-4.9-tcpsocketsuaf
 comments:
   Debian-bwh: |-
-    Apparently introduced by backports of commit 7f582b248d0a
+    Introduced by backports of commit 7f582b248d0a
     "tcp: purge write queue in tcp_connect_init()" to stable.
     Upstream avoided this issue due to the earlier commit
     75c119afe14f "tcp: implement rb-tree based retransmit queue".
-    This issue is currently embargoed.
 introduced-by:
   linux-3.16.y: [0da162e05f65a8073ef1dc3c7598b82a9b9caa70]
   linux-3.18.y: [85611642047443ea8567f5cccc4c282fedde11b6]
@@ -18,3 +17,5 @@ introduced-by:
   linux-4.4.y-cip-rt: [5bbe138a250e795b32f29fc91af88c69851a12d3]
   linux-4.9.y: [74a4c09d4b05c67ed6bd6aed088a5552f4f64aaa]
   mainline: never
+fixed-by:
+  linux-4.14.y: [e99e7745d03fc50ba7c5b7c91c17294fee2d5991]



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/a0b90b8daa35d484414f7b75e98a1a712a072cb5...4b5919c3988089916da67d940810f6c13c10625e

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/a0b90b8daa35d484414f7b75e98a1a712a072cb5...4b5919c3988089916da67d940810f6c13c10625e
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190821/6bc34665/attachment-0001.html>

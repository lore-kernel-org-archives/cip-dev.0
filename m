From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Tue, 05 Feb 2019 18:11:28 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 6
 commits: Add test scripts for f2fs issues with public reproducers
Message-ID: <5c59d1d0a1c81_56e53fbec751120437281c@sidekiq-asap-04-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
762d2184 by Ben Hutchings at 2019-02-05T18:10:06Z
Add test scripts for f2fs issues with public reproducers

- - - - -
718ec1d6 by Ben Hutchings at 2019-02-05T18:10:35Z
Import more data

- - - - -
78b6f478 by Ben Hutchings at 2019-02-05T18:10:35Z
Fill in fix commit list for SSB in 4.4

- - - - -
bd17a1cc by Ben Hutchings at 2019-02-05T18:10:35Z
Update description for CVE-2019-3701 and mark it to be ignored

- - - - -
35c41e3e by Ben Hutchings at 2019-02-05T18:10:35Z
Add test script for CVE-2018-18690

- - - - -
f97cfc8c by Ben Hutchings at 2019-02-05T18:10:35Z
Ignore some minor issues

- - - - -


30 changed files:

- issues/CVE-2017-18232.yml
- issues/CVE-2018-13096.yml
- issues/CVE-2018-13097.yml
- issues/CVE-2018-13099.yml
- issues/CVE-2018-13100.yml
- issues/CVE-2018-14610.yml
- issues/CVE-2018-14611.yml
- issues/CVE-2018-14612.yml
- issues/CVE-2018-14613.yml
- issues/CVE-2018-14614.yml
- issues/CVE-2018-14616.yml
- issues/CVE-2018-16884.yml
- issues/CVE-2018-16885.yml
- issues/CVE-2018-18690.yml
- issues/CVE-2018-19985.yml
- issues/CVE-2018-3639.yml
- issues/CVE-2018-5995.yml
- issues/CVE-2018-7273.yml
- + issues/CVE-2019-3459.yml
- + issues/CVE-2019-3460.yml
- issues/CVE-2019-3701.yml
- issues/CVE-2019-5489.yml
- + tests/CVE-2018-13096
- + tests/CVE-2018-13097
- + tests/CVE-2018-13099
- + tests/CVE-2018-13100
- + tests/CVE-2018-14614
- + tests/CVE-2018-14616
- + tests/CVE-2018-18690
- + tests/common.sh


Changes:

=====================================
issues/CVE-2017-18232.yml
=====================================
@@ -10,3 +10,8 @@ introduced-by:
   mainline: [87c8331fcf72e501c3a3c0cdc5c9391ec72f7cf2]
 fixed-by:
   mainline: [0558f33c06bb910e2879e355192227a8e8f0219d]
+ignore:
+  all: |-
+    This appears to be a denial-of-service that requires physical
+    access or CAP_SYS_ADMIN privileges. That doesn't seem to be a
+    security issue at all.


=====================================
issues/CVE-2018-13096.yml
=====================================
@@ -23,3 +23,5 @@ fixed-by:
   linux-4.14.y: [b8321ccd045710ee04fd5322c34cadd13a5e58af]
   linux-4.9.y: [1c87980591a1dc8c5eafdcc5f9953fca4e518465]
   mainline: [e34438c903b653daca2b2a7de95aed46226f8ed3]
+tests:
+- CVE-2018-13096


=====================================
issues/CVE-2018-13097.yml
=====================================
@@ -21,3 +21,5 @@ fixed-by:
   linux-4.14.y: [f9cf5462b51d98026275cc51437fc531e808b64a]
   linux-4.9.y: [06e606acedaf8bb00c83c4cee43acdd264287a92]
   mainline: [9dc956b2c8523aed39d1e6508438be9fea28c8fc]
+tests:
+- CVE-2018-13097


=====================================
issues/CVE-2018-13099.yml
=====================================
@@ -24,3 +24,5 @@ fixed-by:
   linux-4.18.y: [235fd393825b8b79d962eb2f9a2d6aa454eb17a5]
   linux-4.9.y: [7e0782ceebaaed70b0c4b775c27b81e8f8cf6ddb]
   mainline: [4dbe38dc386910c668c75ae616b99b823b59f3eb]
+tests:
+- CVE-2018-13099


=====================================
issues/CVE-2018-13100.yml
=====================================
@@ -21,3 +21,5 @@ fixed-by:
   linux-4.18.y: [0342426f2bf7298a91efee659ddc033082f6918b]
   linux-4.9.y: [a3dccfacd3a574365ab6c5118f8a944a4ba691fa]
   mainline: [42bf546c1fe3f3654bdf914e977acbc2b80a5be5]
+tests:
+- CVE-2018-13100


=====================================
issues/CVE-2018-14610.yml
=====================================
@@ -13,5 +13,6 @@ reporters:
 - Po-Ning Tseng
 fixed-by:
   linux-4.14.y: [34407a175a59b668a1a2bbf0d0e495d87a7777d8]
+  linux-4.4.y: [ee5e37a26791f9c842b3298e594c6e3c93bb1355]
   linux-4.9.y: [7a72f918825ddece7a4ed79583836f6f1e06e478]
   mainline: [514c7dca85a0bf40be984dab0b477403a6db901f]


=====================================
issues/CVE-2018-14611.yml
=====================================
@@ -13,5 +13,6 @@ reporters:
 - Po-Ning Tseng
 fixed-by:
   linux-4.14.y: [f7eef132ccc95c9af50b647c5da0511d2b8492f8]
+  linux-4.4.y: [50962a7b4877f26d1f3f49cd77ad1814a9e81bac]
   linux-4.9.y: [3c77b07dc365a7ed2644ca0dd38e6e40a9652d57]
   mainline: [315409b0098fb2651d86553f0436b70502b29bb2]


=====================================
issues/CVE-2018-14612.yml
=====================================
@@ -15,5 +15,6 @@ reporters:
 - Po-Ning Tseng
 fixed-by:
   linux-4.14.y: [c0dfb99847851fb830d1e8ea7d5e0571f50c325a, 895586ecb7a4528336d41f81d0ce3985e8abbed6]
+  linux-4.4.y: [42d263820480ab1f7eba54590f2c7283b3428723, 98620167ed91cfef2bf24b058170d5194e0c4c45]
   linux-4.9.y: [6f33d3d8dca8683a4df94e9944296a1a1a2a6f10, 23eb2f435a07e1e09d48ea10c4a22bc96e16fde6]
   mainline: [ba480dd4db9f1798541eb2d1c423fc95feee8d36, 7ef49515fa6727cb4b6f2f5b0ffbc5fc20a9f8c6]


=====================================
issues/CVE-2018-14613.yml
=====================================
@@ -9,5 +9,6 @@ reporters:
 - Po-Ning Tseng
 fixed-by:
   linux-4.14.y: [9f268b5cf2d6a716779dfe11f4bc02d6461db693]
+  linux-4.4.y: [ae94efaf2b609e811bce6280d5c88cf557cd1238]
   linux-4.9.y: [058e388e42c8dc5b6ce6248990c75a0459e20197]
   mainline: [fce466eab7ac6baa9d2dcd88abcf945be3d4a089]


=====================================
issues/CVE-2018-14614.yml
=====================================
@@ -14,3 +14,5 @@ fixed-by:
   linux-4.14.y: [30130700acfad8a705c109325379f5bbe21b3ccc]
   linux-4.9.y: [91fe514bedf4c72ae8046fe4cfa98c5e201f6b84]
   mainline: [e494c2f995d6181d6e29c4927d68e0f295ecf75b]
+tests:
+- CVE-2018-14614


=====================================
issues/CVE-2018-14616.yml
=====================================
@@ -16,3 +16,5 @@ fixed-by:
   linux-4.14.y: [38fce19d4d7bc8acfa183ee2918758d279a69c9a]
   linux-4.9.y: [b10a6ac262f8c1c0c70a90e992137a5590325f0b]
   mainline: [91291e9998d208370eb8156c760691b873bd7522]
+tests:
+- CVE-2018-14616


=====================================
issues/CVE-2018-16884.yml
=====================================
@@ -22,4 +22,9 @@ reporters:
 introduced-by:
   mainline: [23c20ecd44750dd42e5fd53285a17ca8d8a9b0a3]
 fixed-by:
+  linux-4.14.y: [65dba32522065b79a16393efc75f8006c2c3dbb8]
+  linux-4.19.y: [44e7bab39f877c9c095bfaaee943b0807574a7f7]
+  linux-4.20.y: [696d76cca37114d6a32f7043add7ce22a734dcfa]
+  linux-4.4.y: [9615b6aeccbfb233fd672107aa6885bf039c3de3]
+  linux-4.9.y: [37c791a031ece3afeb9c8b023397473a5349f171]
   mainline: [d4b09acf924b84bae77cad090a9d108e70b43643]


=====================================
issues/CVE-2018-16885.yml
=====================================
@@ -1,6 +1,8 @@
 description: out-of-bound read in memcpy_fromiovecend()
 references:
 - https://bugzilla.redhat.com/show_bug.cgi?id=1661503
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-16885
+- https://bugzilla.redhat.com/show_bug.cgi?id=1661503#c4
 comments:
   Debian-carnil: |-
     Not much details provided in RedHat Bugzilla #1661503 but said
@@ -8,5 +10,9 @@ comments:
     the buggy memcpy_fromiovecend() (and related functions) are
     fixed by upstream commit
     21226abb4e9f14d88238964d89b279e461ddc30c (4.0-rc1)
+  Ubuntu-tyhicks: According to Red Hat, this flaw only affects Red Hat Enterprise
+    Linux
+reporters:
+- Paolo Abeni
 fixed-by:
   mainline: [21226abb4e9f14d88238964d89b279e461ddc30c]


=====================================
issues/CVE-2018-18690.yml
=====================================
@@ -18,3 +18,5 @@ fixed-by:
   linux-4.14.y: [cb7ccb9924bb3596f211badf0d2becf131a979cd]
   linux-4.9.y: [4ec44e98ab08c704d0ff1a35a21a0682a5562a27]
   mainline: [7b38460dc8e4eafba06c78f8e37099d3b34d473c]
+tests:
+- CVE-2018-18690


=====================================
issues/CVE-2018-19985.yml
=====================================
@@ -10,5 +10,6 @@ introduced-by:
 fixed-by:
   linux-4.14.y: [49be8dc589aee04c64d61e362c5029ab20fd6fd7]
   linux-4.19.y: [8f980122236c1fc8e11ffb57ec73315d01dc88e0]
+  linux-4.4.y: [8846b1dbfd2146b145d73ba31a4caa4a4789aefb]
   linux-4.9.y: [5501175cb1975239add62a521cfbedcf76b93d8d]
   mainline: [5146f95df782b0ac61abde36567e718692725c89]


=====================================
issues/CVE-2018-3639.yml
=====================================
@@ -119,6 +119,32 @@ fixed-by:
     bd4b410bc5ea560107126a3df18e9233baaec9f3, 95271aeb93d4681c65e2f94969b23ef6070367a6,
     7445962ff2d652bb957722ca1a08a92d09f3e5d7, 677af592349708498671b0d9290912acb2f203e4,
     75e3417f898fe1d2451e7ceffe93db5c66772b0a]
+  linux-4.4.y: [b2dab2dc776cea8e1f190523456b32b850506ce3, d77421663170a2d660fa63a50c664805d132e69d,
+    96df48c0c42c6816d5b2808ed9e18a428cbf9598, 51f37b2f0248911465d8f84fb6f547be5316a261,
+    2658e4d66deca4c1fc6eb59514bded62dd0a7812, 3e1ec1698244de1b808ae0142dd653e5aded91d7,
+    d8067aba239cbd2bfd64cdd548a914b20c58d189, 1cdf94bc21610ffbabedd5b6d85700ed1017037d,
+    46ea6e547d0595f88086bc56c2f032b0e2f3f9ac, 7dc950c1ce909c11c3985802b1aba6b655d8dc23,
+    d9a58c4316857347b0ef77e94bde43379c87a746, ec5bf1a308faac133951877c8b5fbbb0413529cb,
+    0109a1b0a5cababd514671b517722585302c0d4f, 49d8e36618f7524611409b8608dd54d399e7097f,
+    13fa2c65c9a8c2cd5f2a9799891582c40b6f5cfa, b04a020d0745a7ba18800e86ea678676aeb21278,
+    2cb00ce1273d48dafce848f4e0ea353eb5839475, b6f4a6285d7979b45d629e65c880279930b98ef1,
+    484964fa3e5a0d8467891aab8368dab34e8eb13c, 0b1174054e0f4afd999c56ddecbbfb18f598f099,
+    3f9cb20f9126db1edb1fad78a0e94ff8e9ae94e2, a08c3f484c34df1e3bec3c47818d570483bf67fa,
+    c463c0f037f2d83aea54415ed7c61deb0b90333b, 9237a1b0828962191107e702cf56c88db9f9d455,
+    afc6bf9131efc36d4ae8a003e8597119a2190661, 6e2119e4b8767a6c3a415875ad09596ada00755c,
+    765897c6486de605eae3f94f77f2c800c9a2a254, e5eea0486470acbe7aa20a0533543c47c942ec93,
+    631474e1cee0fbc0f346664aea5ee5b1c3600649, 103b28d8a271c1d650eb5b09bd7a53d8915b51d6,
+    95bef2217ece77c345e627eba9cd2e85ada8eeb2, 714f18858ceda6f2b8335686f1f019560fe89283,
+    7f77d36ab3f3d3dc09af0afbc7b58198382e9941, 3e3a1c2ee031cd3d1a8fe9a990b61c8f17a6dd83,
+    4f4a2c70cf2ecd17ef3899c754fee30caa343286, e4bb3382cbe9173e7f6e3a13fd1cb39c3a72671f,
+    11a0b92f6d57853550f927fe91190b745a5ab945, 21757fc8bafd50ce477fff2bcec6faec27c5548d,
+    ea8efcd4415f70766acb4bb9553fad855eea48e1, b5ec2b3f11993d843f75c2d2954ece20af96dc88,
+    e13a6f0955bb5ee6daca1f08027d6561d0830daf, ecfe9bf30e4b7cd13f3b28f40a587a932b5cb457,
+    3d60492cea89c0a0fb06c73ee49cc14c55f527dd, d5aec90670c378b6d05e5f904b1a8c8cffb17eef,
+    9ed7ee52e4e06364f47d6a6e898610bae5f04e93, 90cfa767bc12a9931e5e45ed275b069d5b35b52e,
+    80d7439fb0c446d006599b6347efd255a86a93ca, 48805280d05c968e0883e8debf5e33f40f8e56c5,
+    ff3c3b181c5ee5930b9cc6ca59c4c985a3d93220, cadb98135daf474648d646db5625e9c663b94a3d,
+    1c74bd22e846b162ea6401e8d43172e0e7256ccf]
   linux-4.9.y: [741c026d1a0c594f7ad509f44488ef29582fed74, 88659d5fd9bea7f6afb227c6d404de750b368b45,
     3effee64a9993dc5587fb39f0da4455769e53d26, 0f5dd651397b264903e8becc511af6cf384c273e,
     cf21f58ae6f264e0a10d9736be97342627cf9837, 24e4dd97af40afa4d45e85a32d9c2cc81425a62e,


=====================================
issues/CVE-2018-5995.yml
=====================================
@@ -10,3 +10,8 @@ comments:
     be possible.
 fixed-by:
   mainline: [ad67b74d2469d9b82aaa572d76474c95bc484d57]
+ignore:
+  all: |-
+    This is an information leak that requires access to the system
+    log. It can therefore be mitigated with
+    CONFIG_SECURITY_DMESG_RESTRICT or sysctl kernel.dmesg_restrict.


=====================================
issues/CVE-2018-7273.yml
=====================================
@@ -10,4 +10,7 @@ comments:
 fixed-by:
   mainline: [ad67b74d2469d9b82aaa572d76474c95bc484d57]
 ignore:
-  linux-3.2.y: Minor issue
+  all: |-
+    This is an information leak that requires access to the system
+    log. It can therefore be mitigated with
+    CONFIG_SECURITY_DMESG_RESTRICT or sysctl kernel.dmesg_restrict.


=====================================
issues/CVE-2019-3459.yml
=====================================
@@ -0,0 +1,8 @@
+description: Heap address infoleak in use of l2cap_get_conf_opt
+references:
+- https://lore.kernel.org/linux-bluetooth/20190110062833.GA15047 at kroah.com/
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3459
+reporters:
+- Shlomi Oberman
+- Yuli Shapiro
+- Ran Menscher


=====================================
issues/CVE-2019-3460.yml
=====================================
@@ -0,0 +1,8 @@
+description: Heap data infoleak in multiple locations including functionl2cap_parse_conf_rsp
+references:
+- https://lore.kernel.org/linux-bluetooth/20190110062917.GB15047 at kroah.com/
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3460
+reporters:
+- Shlomi Oberman
+- Yuli Shapiro
+- Ran Menscher


=====================================
issues/CVE-2019-3701.yml
=====================================
@@ -4,13 +4,15 @@ description: |-
   logical operations that can be also applied to the can_dlc field. Because
   of a missing check, the CAN drivers may write arbitrary content beyond the
   data registers in the CAN controller's I/O memory when processing can-gw
-  manipulated outgoing frames. This is related to cgw_csum_xor_rel. An
-  unprivileged user can trigger a system crash (general protection fault).
+  manipulated outgoing frames. This is related to cgw_csum_xor_rel. A
+  privileged user can trigger a system crash (general protection fault).
 references:
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-3701
 - https://marc.info/?l=linux-netdev&m=154659326324991&w=2
 - https://bugzilla.suse.com/show_bug.cgi?id=1120386
 - https://marc.info/?l=linux-netdev&m=154651842302479&w=2
+- https://marc.info/?l=linux-can&m=154659326224990&w=2
+- https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/net/can?id=0aaa81377c5a01f686bcdb8c7a6929a7bf330c68
 comments:
   Debian-carnil: |-
     unprivileged user namespaces might be needed to exploit the bug,
@@ -31,3 +33,7 @@ fixed-by:
   linux-4.4.y: [693ae291197429f404e7d9c191e1541f61925278]
   linux-4.9.y: [d379b338387e3d5a9b5ebe5ab16656a9c65c988d]
   mainline: [0aaa81377c5a01f686bcdb8c7a6929a7bf330c68]
+ignore:
+  all: |-
+    Only the global root user can trigger this bug and the result is a
+    crash. This doesn't seem to have a security impact.


=====================================
issues/CVE-2019-5489.yml
=====================================
@@ -15,12 +15,22 @@ references:
 - https://bugzilla.suse.com/show_bug.cgi?id=1120843
 - https://twitter.com/lavados/status/1081205802046607361
 - https://lore.kernel.org/lkml/CAHk-=wiqbKEC5jUXr3ax+oUuiRrp=QMv_ZnUfO-SPv=UNJ-OTw at mail.gmail.com/T/#mf09fc35229f38e5b657f299a3a3865c8ca39e7e1
+- https://lore.kernel.org/lkml/CAHk-=wiqbKEC5jUXr3ax+oUuiRrp=QMv_ZnUfO-SPv=UNJ-OTw at mail.gmail.com/
 comments:
   Debian-carnil: |-
     574823bfab82d9d8fa47f422778043fbb4b4f50e was marked explicitly
     not yet for stable as it is expected to check if there are issues
     with this approach. There are enough tools which depend on mincore()
     to try to tell wheter a file is loaded in cache or not.
+  Ubuntu-tyhicks: |-
+    On 2018-01-06, a potential fix for this issue was committed in the
+     upstream kernel git tree. The potential fix changes the behavior of the
+     mincore(2) system call in ways that could possibly break userspace
+     applications. The potential fix landed during the kernel's "merge window"
+     which allows for the change to mature and receive additional testing.
+     Applying the potential fix to Ubuntu kernels, at this time, could potentially
+     break some existing applications. Ubuntu will continue to monitor related
+     changes in the upstream kernel and evaluate/test the potential fix.
 reporters:
 - Daniel Gruss
 - Erik Kraft


=====================================
tests/CVE-2018-13096
=====================================
@@ -0,0 +1,21 @@
+#!/bin/sh -eu
+
+. "$(dirname "$0")/common.sh"
+
+test_cleanup() {
+    if mountpoint -q "$scratch_dir/mnt"; then
+	umount "$scratch_dir/mnt"
+    fi
+}
+
+assert_kconfig CONFIG_F2FS_FS
+assert_kconfig CONFIG_KASAN y
+
+curl -o "$scratch_dir/35.img.zip" \
+     "https://bugzilla.kernel.org/attachment.cgi?id=276727"
+unzip -d "$scratch_dir" "$scratch_dir/35.img.zip" 35.img
+
+mkdir "$scratch_dir/mnt"
+! mount -o loop -t f2fs "$scratch_dir/35.img" "$scratch_dir/mnt"
+
+assert_untainted


=====================================
tests/CVE-2018-13097
=====================================
@@ -0,0 +1,20 @@
+#!/bin/sh -eu
+
+. "$(dirname "$0")/common.sh"
+
+test_cleanup() {
+    if mountpoint -q "$scratch_dir/mnt"; then
+	umount "$scratch_dir/mnt"
+    fi
+}
+
+assert_kconfig CONFIG_F2FS_FS
+
+curl -o "$scratch_dir/final.img.zip" \
+     "https://bugzilla.kernel.org/attachment.cgi?id=276731"
+unzip -d "$scratch_dir" "$scratch_dir/final.img.zip" final.img
+
+mkdir "$scratch_dir/mnt"
+! mount -o loop -t f2fs "$scratch_dir/final.img" "$scratch_dir/mnt"
+
+assert_untainted


=====================================
tests/CVE-2018-13099
=====================================
@@ -0,0 +1,33 @@
+#!/bin/sh -eu
+
+. "$(dirname "$0")/common.sh"
+
+test_cleanup() {
+    if mountpoint -q "$scratch_dir/mnt"; then
+	umount "$scratch_dir/mnt"
+    fi
+}
+
+assert_kconfig CONFIG_F2FS_FS
+assert_kconfig CONFIG_KASAN y
+
+curl -o "$scratch_dir/final.img.zip" \
+     "https://bugzilla.kernel.org/attachment.cgi?id=276739"
+unzip -d "$scratch_dir" "$scratch_dir/final.img.zip" final.img
+
+# Proof-of-concept code is inline in a comment :-(
+curl -o "$scratch_dir/comments.json" \
+     "https://bugzilla.kernel.org/rest/bug/comment/1290421"
+jq --raw-output '.comments["1290421"].text' "$scratch_dir/comments.json" \
+    | sed -n '/^- POC/,/^- Kernel message/ { /^-/d; p }' \
+    > "$scratch_dir/poc.c"
+cc -Wall -Wextra -O2 "$scratch_dir/poc.c" -o "$scratch_dir/poc"
+
+mkdir "$scratch_dir/mnt"
+mount -o loop -t f2fs "$scratch_dir/final.img" "$scratch_dir/mnt"
+
+assert_untainted
+
+"$scratch_dir/poc" "$scratch_dir/mnt"
+
+assert_untainted $((0x200))  # expect and ignore TAINT_WARN


=====================================
tests/CVE-2018-13100
=====================================
@@ -0,0 +1,20 @@
+#!/bin/sh -eu
+
+. "$(dirname "$0")/common.sh"
+
+test_cleanup() {
+    if mountpoint -q "$scratch_dir/mnt"; then
+	umount "$scratch_dir/mnt"
+    fi
+}
+
+assert_kconfig CONFIG_F2FS_FS
+
+curl -o "$scratch_dir/final.img.zip" \
+     "https://bugzilla.kernel.org/attachment.cgi?id=276743"
+unzip -d "$scratch_dir" "$scratch_dir/final.img.zip" final.img
+
+mkdir "$scratch_dir/mnt"
+! mount -o loop -t f2fs "$scratch_dir/final.img" "$scratch_dir/mnt"
+
+assert_untainted


=====================================
tests/CVE-2018-14614
=====================================
@@ -0,0 +1,20 @@
+#!/bin/sh -eu
+
+. "$(dirname "$0")/common.sh"
+
+test_cleanup() {
+    if mountpoint -q "$scratch_dir/mnt"; then
+	umount "$scratch_dir/mnt"
+    fi
+}
+
+assert_kconfig CONFIG_F2FS_FS
+
+curl -o "$scratch_dir/74.img.zip" \
+     "https://bugzilla.kernel.org/attachment.cgi?id=277195"
+unzip -d "$scratch_dir" "$scratch_dir/74.img.zip" 74.img
+
+mkdir "$scratch_dir/mnt"
+! mount -o loop -t f2fs "$scratch_dir/74.img" "$scratch_dir/mnt"
+
+assert_untainted


=====================================
tests/CVE-2018-14616
=====================================
@@ -0,0 +1,33 @@
+#!/bin/sh -eu
+
+. "$(dirname "$0")/common.sh"
+
+test_cleanup() {
+    if mountpoint -q "$scratch_dir/mnt"; then
+	umount "$scratch_dir/mnt"
+    fi
+}
+
+assert_kconfig CONFIG_F2FS_FS
+assert_kconfig CONFIG_F2FS_FS_ENCRYPTION
+
+curl -o "$scratch_dir/final.img.zip" \
+     "https://bugzilla.kernel.org/attachment.cgi?id=277309"
+unzip -d "$scratch_dir" "$scratch_dir/final.img.zip" final.img
+
+# Proof-of-concept code is inline in a comment :-(
+curl -o "$scratch_dir/comments.json" \
+     "https://bugzilla.kernel.org/rest/bug/comment/1292063"
+jq --raw-output '.comments["1292063"].text' "$scratch_dir/comments.json" \
+    | sed -n '/^- POC/,/^- kernel message/ { /^-/d; p }' \
+    > "$scratch_dir/poc.c"
+cc -Wall -Wextra -O2 "$scratch_dir/poc.c" -o "$scratch_dir/poc"
+
+mkdir "$scratch_dir/mnt"
+mount -o loop -t f2fs "$scratch_dir/final.img" "$scratch_dir/mnt"
+
+assert_untainted
+
+"$scratch_dir/poc" "$scratch_dir/mnt"
+
+assert_untainted $((0x200))  # expect and ignore TAINT_WARN


=====================================
tests/CVE-2018-18690
=====================================
@@ -0,0 +1,27 @@
+#!/bin/sh -eu
+
+. "$(dirname "$0")/common.sh"
+
+test_cleanup() {
+    if mountpoint -q "$scratch_dir/mnt"; then
+	umount "$scratch_dir/mnt"
+    fi
+}
+
+assert_kconfig CONFIG_XFS_FS
+
+truncate -s 1G "$scratch_dir/xfs.img"
+mkfs.xfs "$scratch_dir/xfs.img"
+
+curl -o "$scratch_dir/setattr.c" \
+     "https://bugzilla.kernel.org/attachment.cgi?id=274733"
+cc -Wall -Wextra -O2 "$scratch_dir/setattr.c" -o "$scratch_dir/setattr"
+
+mkdir "$scratch_dir/mnt"
+mount -o loop -t xfs "$scratch_dir/xfs.img" "$scratch_dir/mnt"
+
+"$scratch_dir/setattr" "$scratch_dir/mnt/hello"
+value="$(getfattr -n user.world --absolute-names --only-values  "$scratch_dir/mnt/hello")"
+test "${#value}" -eq 2048
+
+assert_untainted


=====================================
tests/common.sh
=====================================
@@ -0,0 +1,86 @@
+# -*- shell-script -*-
+
+_cat_kconfig() {
+    local release
+
+    if [ -f /proc/config ]; then
+	cat /proc/config
+    elif [ -f /proc/config.gz ]; then
+	gzip -dc /proc/config.gz
+    elif [ -f /boot/config-"${release:=$(uname -r)}" ]; then
+	cat /boot/config-"$release"
+    else
+	return 1
+    fi
+}
+
+# Check symbol state in kernel config.
+# Parameters:
+# - symbol name (required)
+# - symbol state (optional), one of m n y
+# If symbol state is not specified then both m and y will be accepted.
+check_kconfig() {
+    local regexp
+
+    if [ $# -eq 1 ]; then
+	regexp="^$1="
+    elif [ "$2" = n ]; then
+	regexp="^# $1 is not"
+    else
+	regexp="^$1=$2"
+    fi
+    _cat_kconfig | grep -q "$regexp"
+}
+
+assert_kconfig() {
+    if check_kconfig "$@"; then
+	return
+    fi
+    if [ $# -eq 1 ]; then
+	echo >&2 "E: $1 must be enabled"
+    elif [ "$2" = n ]; then
+	echo >&2 "E: $1 must be disabled"
+    else
+	echo >&2 "E: $1 must be set to $2"
+    fi
+    exit 1
+}
+
+# Assert that no unexpected taint flags are set.  By default this ignores
+# TAINT_CRAP, TAINT_FIRMWARE_WORKAROUND, TAINT_OOT_MODULE,
+# TAINT_UNSIGNED_MODULE, TAINT_LIVEPATCH.
+# Parameters:
+# - bitmask of extra flags to ignore (optional)
+assert_untainted() {
+    local tainted
+
+    tainted="$(cat /proc/sys/kernel/tainted)"
+    tainted="$((tainted & ~(0xbc00 | ${1:-0})))"
+
+    if [ $tainted -eq 0 ]; then
+	return
+    fi
+
+    printf >&2 'E: Unexpected taint flags: %#x\n' $tainted
+    exit 1
+}
+
+# Temporary files should normally be created under this directory, which
+# is automatically cleaned up.
+scratch_dir="$(mktemp -d)"
+
+common_cleanup() {
+    rm -rf "$scratch_dir"
+}
+
+# The test_cleanup function should be redefined by tests that need any
+# special cleanup.
+test_cleanup() {
+    :
+}
+
+cleanup() {
+    test_cleanup
+    common_cleanup
+}
+trap cleanup EXIT



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/41754e091a6b0befc10591ddab56a3c95193773f...f97cfc8c21d00e91e0a96b230f6a39a04c45c1b0

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/41754e091a6b0befc10591ddab56a3c95193773f...f97cfc8c21d00e91e0a96b230f6a39a04c45c1b0
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190205/0a79d480/attachment-0001.html>

From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Thu, 06 Dec 2018 14:22:08 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 2
 commits: Fill in and correct commit lists for various issues
Message-ID: <5c093090c1278_60643ff150672d581073492@sidekiq-asap-03-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
6a687350 by Ben Hutchings at 2018-12-06T13:39:35Z
Fill in and correct commit lists for various issues

- - - - -
efeeb55f by Ben Hutchings at 2018-12-06T14:21:45Z
Import data from stable

Record the fixes I backported for 4.14.85.

- - - - -


24 changed files:

- issues/CVE-2017-13166.yml
- issues/CVE-2017-13216.yml
- issues/CVE-2017-18174.yml
- issues/CVE-2017-18232.yml
- issues/CVE-2017-18257.yml
- issues/CVE-2018-1128.yml
- issues/CVE-2018-1129.yml
- issues/CVE-2018-12232.yml
- issues/CVE-2018-13096.yml
- issues/CVE-2018-13097.yml
- issues/CVE-2018-13098.yml
- issues/CVE-2018-13100.yml
- issues/CVE-2018-14610.yml
- issues/CVE-2018-14611.yml
- issues/CVE-2018-14612.yml
- issues/CVE-2018-14613.yml
- issues/CVE-2018-14614.yml
- issues/CVE-2018-14615.yml
- issues/CVE-2018-18445.yml
- issues/CVE-2018-18690.yml
- issues/CVE-2018-3639.yml
- issues/CVE-2018-5703.yml
- issues/CVE-2018-5848.yml
- issues/CVE-2018-7740.yml


Changes:

=====================================
issues/CVE-2017-13166.yml
=====================================
@@ -8,6 +8,8 @@ comments:
     by commit 7e6a68210784 "[media] videodev2.h: add initial support for
     compound controls".  Hans Verkuil is working on stable backports.
   Debian-carnil: 'Patch series backported to: 4.15.4'
+introduced-by:
+  mainline: [fdf82dc2e2d43cf135b5fd352dea523642bb553a]
 fixed-by:
   linux-3.16.y: [5e5747642716c7a5ee61b8eb42f6b5d32136b150, 182f3143bcbc783ee18c1b8af52734929813541e,
     846e214562b1fd6d49ec2dd334bc5fe1ab1707f3, f64f7bd54eca5210397b060ca0a9aab8e633c772,


=====================================
issues/CVE-2017-13216.yml
=====================================
@@ -10,6 +10,8 @@ comments:
     ashmem driver source-wise introduced in 3.3-rc1 with
     11980c2ac4ccfad21a5f8ee9e12059f1e687bb40
   Debian-jmm: Only present in drivers/staging/android/ashmem.c
+introduced-by:
+  mainline: [11980c2ac4ccfad21a5f8ee9e12059f1e687bb40]
 fixed-by:
   linux-3.16.y: [63aa20e4f4760249339c7771bd7e4a01d82a95ad]
   linux-3.18.y: [6dc42f889217a0a077bc75c6fa5239ade762fff4]


=====================================
issues/CVE-2017-18174.yml
=====================================
@@ -13,5 +13,7 @@ comments:
     Issue fixed in 251e22abde21833b3d29577e4d8c7aaccd650eee (4.7-rc1).
     Was shortly introduced in a rc version with 3bfd44306c65d073008b9ca8f062249f35576b61
     in 4.11-rc1 and fixed in same rc version with 8dca4a41f1ad65043a78c2338d9725f859c8d2c3
+introduced-by:
+  mainline: [3bfd44306c65d073008b9ca8f062249f35576b61]
 fixed-by:
-  mainline: [251e22abde21833b3d29577e4d8c7aaccd650eee]
+  mainline: [8dca4a41f1ad65043a78c2338d9725f859c8d2c3]


=====================================
issues/CVE-2017-18232.yml
=====================================
@@ -6,5 +6,7 @@ comments:
   Debian-bwh: |-
     Commit message says this was introduced by commit 87c8331fcf72
     (Linux 3.4).  For stretch, this requires an ABI bump.
+introduced-by:
+  mainline: [87c8331fcf72e501c3a3c0cdc5c9391ec72f7cf2]
 fixed-by:
   mainline: [0558f33c06bb910e2879e355192227a8e8f0219d]


=====================================
issues/CVE-2017-18257.yml
=====================================
@@ -11,6 +11,8 @@ comments:
   Debian-bwh: |-
     Appears to be a regression introduced in Linux 4.2 by commit
     003a3e1d60b0 "f2fs: add f2fs_map_blocks".
+introduced-by:
+  mainline: [003a3e1d60b0bb5cfb4feffb05a2083db2346364]
 fixed-by:
   linux-4.4.y: [0678adf8f8a99c66c48c608ea9a79588743bc615]
   linux-4.9.y: [b8bf4b886b82585202ab4ee169718656661cb89e]


=====================================
issues/CVE-2018-1128.yml
=====================================
@@ -9,13 +9,15 @@ comments:
     I don't think this is practical for 3.16 as the protocol change
     seems to depend on message signatures which were added in 3.19.
 fixed-by:
+  linux-4.14.y: [2fd0d0f9bb59ec5b628622e30f22158cb564c4ea, 66abd96062b627f0ee20a684ebba48cec80233d7,
+    0858417b5c2e7bcc0b9e52c4b76e2af3d69e138b, a55056e1523990e1ef9d70531ffaf27fd1ddff55,
+    3fd73c8a71f299e30359a63add1f33e3fd834831]
   mainline: [262614c4294d33b1f19e0d18c0091d9c329b544a, c0f56b483aa09c99bfe97409a43ad786f33b8a5a,
     c571fe24d243bfe7017f0e67fe800b3cc2a1d1f7, 149cac4a50b0b4081b38b2f38de6ef71c27eaa85,
     6daca13d2e72bedaaacfc08f873114c9307d5aea]
+fix-depends-on:
+  0dde584882ade13dc9708d611fbf69b0ae8a9e48: Avoids textual conflicts when picking
+    6daca13d2e72.
+  b3bbd3f2ab19c8ca319003b4b51ce4c4ca74da06: Simplifies backporting of 262614c4294d.
 ignore:
   linux-3.16.y: Protocol change is too difficult
-fix-depends-on:
-  0dde584882ade13dc9708d611fbf69b0ae8a9e48: |-
-    Avoids textual conflicts when picking 6daca13d2e72.
-  b3bbd3f2ab19c8ca319003b4b51ce4c4ca74da06: |-
-    Simplifies backporting of 262614c4294d.


=====================================
issues/CVE-2018-1129.yml
=====================================
@@ -2,4 +2,5 @@ description: 'libceph: implement CEPHX_V2 calculation mode'
 references:
 - http://tracker.ceph.com/issues/24837
 fixed-by:
+  linux-4.14.y: [b16d0c5d32468a0624505a7b6b211e20488295e9]
   mainline: [cc255c76c70f7a87d97939621eae04b600d9f4a1]


=====================================
issues/CVE-2018-12232.yml
=====================================
@@ -15,6 +15,8 @@ comments:
   Debian-bwh: |-
     Introduced in 4.10 by commit 86741ec25462 "net: core: Add a UID
     field to struct sock."
+introduced-by:
+  mainline: [86741ec25462e4c8cdce6df2f41ead05568c7d5e]
 fixed-by:
   linux-4.14.y: [91717ffc9057f38a0203a40ef36ae2e482fd7cbe]
   linux-4.16.y: [abaa1bb5e3652593a22a51e289bf9dfd4d4a8542]


=====================================
issues/CVE-2018-13096.yml
=====================================
@@ -3,4 +3,5 @@ references:
 - https://bugzilla.kernel.org/show_bug.cgi?id=200167
 - https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=f2fs-dev&id=8c9c95d5f4e68d22f22091546ce554ac9222689c
 fixed-by:
+  linux-4.14.y: [b8321ccd045710ee04fd5322c34cadd13a5e58af]
   mainline: [e34438c903b653daca2b2a7de95aed46226f8ed3]


=====================================
issues/CVE-2018-13097.yml
=====================================
@@ -3,4 +3,5 @@ references:
 - https://bugzilla.kernel.org/show_bug.cgi?id=200171
 - https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=f2fs-dev&id=d5c28acdb832800fbbcf831f20f75080cba54f04
 fixed-by:
+  linux-4.14.y: [f9cf5462b51d98026275cc51437fc531e808b64a]
   mainline: [9dc956b2c8523aed39d1e6508438be9fea28c8fc]


=====================================
issues/CVE-2018-13098.yml
=====================================
@@ -3,5 +3,6 @@ references:
 - https://bugzilla.kernel.org/show_bug.cgi?id=200173
 - https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=f2fs-dev&id=190286a242344d42aad83c8e70169d6d72a63d05
 fixed-by:
+  linux-4.14.y: [0081c90ebacebb3a82d0d24bf0f42273ce2d902e]
   linux-4.18.y: [b6f493453c78311598fdd204f7815e683818512a]
   mainline: [76d56d4ab4f2a9e4f085c7d77172194ddaccf7d2]


=====================================
issues/CVE-2018-13100.yml
=====================================
@@ -3,5 +3,6 @@ references:
 - https://bugzilla.kernel.org/show_bug.cgi?id=200183
 - https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=f2fs-dev&id=e72ba39212abc9e77f367cd95d7d3c8689aba14a
 fixed-by:
+  linux-4.14.y: [f3d6361a96a455c8ba12226a04efa67a0ada4966]
   linux-4.18.y: [0342426f2bf7298a91efee659ddc033082f6918b]
   mainline: [42bf546c1fe3f3654bdf914e977acbc2b80a5be5]


=====================================
issues/CVE-2018-14610.yml
=====================================
@@ -8,4 +8,5 @@ comments:
     Upstream fix depends on (at least) commit fce466eab7ac
     "btrfs: tree-checker: Verify block_group_item".
 fixed-by:
+  linux-4.14.y: [34407a175a59b668a1a2bbf0d0e495d87a7777d8]
   mainline: [514c7dca85a0bf40be984dab0b477403a6db901f]


=====================================
issues/CVE-2018-14611.yml
=====================================
@@ -8,4 +8,5 @@ comments:
     Upstream fix depends on (at least) commit e06cd3dd7cea
     "Btrfs: add validadtion checks for chunk loading".
 fixed-by:
+  linux-4.14.y: [f7eef132ccc95c9af50b647c5da0511d2b8492f8]
   mainline: [315409b0098fb2651d86553f0436b70502b29bb2]


=====================================
issues/CVE-2018-14612.yml
=====================================
@@ -10,4 +10,5 @@ comments:
     what happened for the second one, resp. not yet checked if
     that applies.
 fixed-by:
+  linux-4.14.y: [c0dfb99847851fb830d1e8ea7d5e0571f50c325a, 895586ecb7a4528336d41f81d0ce3985e8abbed6]
   mainline: [ba480dd4db9f1798541eb2d1c423fc95feee8d36, 7ef49515fa6727cb4b6f2f5b0ffbc5fc20a9f8c6]


=====================================
issues/CVE-2018-14613.yml
=====================================
@@ -4,4 +4,5 @@ references:
 - https://bugzilla.kernel.org/show_bug.cgi?id=199849
 - https://patchwork.kernel.org/patch/10503147/
 fixed-by:
+  linux-4.14.y: [9f268b5cf2d6a716779dfe11f4bc02d6461db693]
   mainline: [fce466eab7ac6baa9d2dcd88abcf945be3d4a089]


=====================================
issues/CVE-2018-14614.yml
=====================================
@@ -4,4 +4,5 @@ references:
 - https://bugzilla.kernel.org/show_bug.cgi?id=200419
 - https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=f2fs-dev&id=bf2d987b270ed14fb205c83c6dcfbfa6dfcd9f8c
 fixed-by:
+  linux-4.14.y: [30130700acfad8a705c109325379f5bbe21b3ccc]
   mainline: [e494c2f995d6181d6e29c4927d68e0f295ecf75b]


=====================================
issues/CVE-2018-14615.yml
=====================================
@@ -4,4 +4,5 @@ references:
 - https://bugzilla.kernel.org/show_bug.cgi?id=200421
 - https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=f2fs-dev&id=a80a2ff8e0a1265a4e92f4b8ae7caacc83a19503
 fixed-by:
+  linux-4.14.y: [d7d9d29a837358636e12fe09c90a7882b53b2220]
   mainline: [18dd6470c2d14d10f5a2dd926925dc80dbd3abfd]


=====================================
issues/CVE-2018-18445.yml
=====================================
@@ -2,6 +2,8 @@ description: BPF verifier bug leads to out-of-bounds access
 references:
 - https://www.openwall.com/lists/oss-security/2018/10/17/9
 - https://bugs.chromium.org/p/project-zero/issues/detail?id=1686
+introduced-by:
+  mainline: [468f6eafa6c44cb2c5d8aad35e12f06c240a812a]
 fixed-by:
   linux-4.14.y: [10fdfea70d4667abf3724c31443e5d5922fecebd]
   linux-4.18.y: [11b165210c7214645c183dc7f74aca8d51381691]


=====================================
issues/CVE-2018-18690.yml
=====================================
@@ -4,4 +4,5 @@ references:
 - https://bugzilla.kernel.org/show_bug.cgi?id=199119
 - https://bugzilla.suse.com/show_bug.cgi?id=1105025
 fixed-by:
+  linux-4.14.y: [cb7ccb9924bb3596f211badf0d2becf131a979cd]
   mainline: [7b38460dc8e4eafba06c78f8e37099d3b34d473c]


=====================================
issues/CVE-2018-3639.yml
=====================================
@@ -64,6 +64,31 @@ fixed-by:
     4e99bb051d3e60dbb323c5562375c96f56d56ec4, fbb7b98887d4fe5e556b2146857b9c43b6c469f3,
     8963b10319ec195059f8a65c049303f84cb02d38, dde241727d8213c0f29102642a6be2629df4c596,
     5a9cbccff42fdecd30daaf8e88d4779cce055ac7]
+  linux-4.14.y: [8410540f5aaf06ab01197443371be89822971e58, 69dc73805969ea919786c56d18e5a51fb8c128f2,
+    3ce1634f6165ba638546bf83123f1e5c51b1afcd, 7c9b4959cda48f22ecd6ceb88bda7f939f2016b3,
+    94ae9d26284369da199dfb2581fe0b7ea66f7733, c6dc89dd04e3adfb713c40c20817a8791a8deda6,
+    832b579e1e83f17e14a8c054ccc768eaf5e80269, 65f747a6b1089f13e80b0b2e0c4128e72d135a70,
+    128e69909f7c245765f75d7f350dd67eb8fe8a7b, fa2f1c65246d956106fa964cf0ed953162af88e5,
+    716bfae3b3f40de8c0a6ae83f199d96fd152b3cc, 97224b3da69810155b44f173cc8959eea565a98d,
+    81c3c2b5917af382a90d116a5ccd034fe5d32c2a, 33f6a06810cb3f3f0ba20914db334c7c4855ba80,
+    704609d396801c86bca6dcdb14676489dd623da5, d8553911627ab1d9789d08c9902f5e43194f99f7,
+    7d1254a1489c4ecc23a6afdfd1a17bdbb4cd186d, dd88d569eeff59a03b897ba0168547a465091aca,
+    87895ae1e9b22a04441992921b79b6d32e22142a, c024722ffecd484fcb35ad61e822c214b6913196,
+    20d036a2e223a5c4327bcf432ef995f59f51d1d1, d829fcceb8f532966bfb07fb67cb968374fcbbd2,
+    9939db75cd5b686ca43c4aa26e24d6b73ffa66e0, 61dfdc12ff35cd6f196a543271174ae611e36fb1,
+    0f18f44ce076e48d25c1b03e15f3b588ba0f9df1, 89ba80e61a395afc40a865d008931c576d20724d,
+    43c47eb2a274fa12029ac5485ae4360048a398af, 8dc742f930ccbb6b41d538bb35b81693cd8bad43,
+    4fbc01632e779977bbdcbb14877dcc80d7beeb0b, f69c4dd36766666077b96e30e7d0d1122642c00a,
+    5a53a5fefb73c150d754907916188d0cf3fb36d8, bd2059282934fc009d755d24527187df5fe448de,
+    b1a6028c23748afc3b970bf2a740a3ebc7424e12, b1d1984f389865e655076ae18d4626b1a65ba82c,
+    8e0836d1413b86ef6e85142c3902990815cf1cba, bbc0d1c335664660acc2c6e68901d350805a1ff1,
+    7f1efb5e74e3e1a01b73d3364d223f71044f5049, b213ab46cde40368b793daac516be9218beaa750,
+    72f46c229ac286c0a734888f50a3af274036290f, 8e1c285a050ca8bcbe30c47f102497e44319f12c,
+    3e6ab4ca1345b8b7ff09ea00e0abffa276c6919c, 6befd3a735e0228b8128f2916309ed218d9c49dd,
+    987f49474b0680db37f9bfcecc8e563803c55f52, d13f068b94a18b8d9fafaf2519fd1f43d4965f36,
+    71179d5dcbb96afc70c3344fd4b35db0c33d6008, 3f44c1a3c29379aa976be27df1da0fc4b9e7c364,
+    e8837f0a000f79e1e629ad8a00eceb3c452bf3bc, 92a3c944d6d5d3e08335cd3b6a75df907a43a960,
+    83b570c004da47b51d7417ac18d8491d9fc91420]
   linux-4.16.y: [2cd883a4cc87871db17dbc52398a58321af209b1, d1ee580200e9937cc4e3f0ff1d45c3cfb2532f9e,
     0e303bbda22ac4a655f0a2bfdd51cda209562ddb, 4fa760f200941e88187c0241ce5df72e8ec9cd97,
     2460962b14b78b47ebfeb744bd9e09d813c8236d, 569e3b16770b6d3c8ea08bb41678473f786868a3,


=====================================
issues/CVE-2018-5703.yml
=====================================
@@ -9,5 +9,6 @@ comments:
 introduced-by:
   mainline: [3c4d7559159bfe1e3b94df3a657b2cda3a34e218]
 fixed-by:
+  linux-4.14.y: [2a0f5919e1e6a1c0423d895ab75eb15f94a67c69]
   linux-4.15.y: [c5f3a16c047dfa7f309a2e1ca7d43e7db92ec35b]
   mainline: [c113187d38ff85dc302a1bb55864b203ebb2ba10]


=====================================
issues/CVE-2018-5848.yml
=====================================
@@ -5,4 +5,5 @@ references:
 - https://www.codeaurora.org/security-bulletin/2018/05/11/may-2018-code-aurora-security-bulletin-2#_CVE-2018-5848
 - https://marc.info/?l=linux-wireless&m=151066597529493&w=2
 fixed-by:
+  linux-4.14.y: [107b02c81a8761f1f7efc1e8b54d435324ccd13e]
   mainline: [b5a8ffcae4103a9d823ea3aa3a761f65779fbe2a]


=====================================
issues/CVE-2018-7740.yml
=====================================
@@ -17,6 +17,8 @@ comments:
     045c7a3f tried to catch issues like this, but missed this case.
     ff8c0c53c475 and 045c7a3f may also be needed for older
       releases
+introduced-by:
+  mainline: [ff8c0c53c47530ffea82c22a0a6df6332b56c957]
 fixed-by:
   linux-3.16.y: [363ed2044f82d8997e9ea8231dc1abeab4993755, 8cca49ea37415645203520bff04309c8a87f7677]
   linux-3.2.y: [4cba2554682469496ff48536d50c399110d20043, 131802b8292d35e8a407469c485565b199ed79cf]



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/cfd826db2fb01bbdc297234e20a6e0add27bffca...efeeb55f65f8bb4e27558d190d89c91515285abb

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/cfd826db2fb01bbdc297234e20a6e0add27bffca...efeeb55f65f8bb4e27558d190d89c91515285abb
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20181206/1fcf4fe3/attachment-0001.html>

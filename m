From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Sat, 08 Dec 2018 18:32:46 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 2
 commits: Fill in and correct commit lists for various issues
Message-ID: <5c0c0e4e396d3_35563fbebd4ef4881483f7@sidekiq-asap-03-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
ce17def7 by Ben Hutchings at 2018-12-08T18:30:21Z
Fill in and correct commit lists for various issues

- - - - -
d809002c by Ben Hutchings at 2018-12-08T18:32:07Z
Import data from stable

Record the fixes I backported for 4.9.144.

- - - - -


24 changed files:

- issues/CVE-2017-13166.yml
- issues/CVE-2017-18241.yml
- issues/CVE-2017-18249.yml
- issues/CVE-2018-1108.yml
- issues/CVE-2018-1120.yml
- issues/CVE-2018-1128.yml
- issues/CVE-2018-1129.yml
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
- issues/CVE-2018-18281.yml
- issues/CVE-2018-18690.yml
- issues/CVE-2018-18955.yml
- issues/CVE-2018-3620.yml
- issues/CVE-2018-3639.yml
- issues/CVE-2018-5848.yml
- issues/CVE-2018-7740.yml


Changes:

=====================================
issues/CVE-2017-13166.yml
=====================================
@@ -37,6 +37,12 @@ fixed-by:
     2b14d31a951e1af276077d40e000638fa469185e, 1cc643ab48ee22b71679db6453475de299c0ac83,
     11fe1040030e703340a7c6c91330314e1129cdc1, 76db969a3bbf598bdfaa1c957a54586c2bb61fb8,
     d971cb5f5fbd4af3b35a4addb850fb4b2aa8d720]
+  linux-4.4.y: [15e3780a8add9d5cd6bdc9df9cdc4e0d9b8e55dd, 4a85bbbcb5d5d3afb66b6c9a9ba54d02e30f8b4f,
+    04d632236ad250f527ff9d7e3b2696783e82409c, 56a4fbdf5092d64f1f29a1e45508f18f3072f316,
+    57f0817a6dd82cf0b3188f36df191abd629555c8, c6cbc2c3539fd68d37dff300870f56869d21bb82,
+    d64d203f201975604578f71982ba13fe71bd86d6, 4c8ba4d5ad2fc0d2c11ade4997571f654a573f87,
+    edbc67ef654b4abf14e7de391ce286a722bfda13, af41ce9e1304db4008356d36236d4f85199ecf87,
+    e87f9596660622f01ed8f90b7088615933dca320, 8fbc22b34365bfeb72b1e3a63ba9239d327137dc]
   linux-4.9.y: [e78d9fdf5ecce2830d76d54017c3d8531bf9b119, f294548da6455cae64456a9dfeff1e96390171c0,
     02129c9bc23582a48194e89cbbeb15169115b8b9, 81e0acf07015dbd3e0b45e8f8a053d64b804bb46,
     daff4d009f4f7fb3b1f041b76c0782cb96d99d56, eec955463de3259c0db5b38952f79c3e39e03f65,


=====================================
issues/CVE-2017-18241.yml
=====================================
@@ -5,4 +5,5 @@ references:
 - https://github.com/torvalds/linux/commit/d4fdf8ba0e5808ba9ad6b44337783bd9935e0982
 fixed-by:
   linux-3.16.y: [1f0db424c8770c7b31296d5c66a52fffdec1d24c]
+  linux-4.9.y: [3b19f961d260d1ae12b497e5eb77e5ecc1039fac]
   mainline: [d4fdf8ba0e5808ba9ad6b44337783bd9935e0982]


=====================================
issues/CVE-2017-18249.yml
=====================================
@@ -6,4 +6,5 @@ references:
 comments:
   Debian-bwh: So far I've failed to backport this even to 4.9.
 fixed-by:
+  linux-4.9.y: [cb9b1d4ec206702a4df1cb42ba8142f39acfdd91]
   mainline: [30a61ddf8117c26ac5b295e1233eaa9629a94ca3]


=====================================
issues/CVE-2018-1108.yml
=====================================
@@ -18,6 +18,8 @@ comments:
       it's unlikely user space will receive backports to support it.
 reporters:
 - Jann Horn
+introduced-by:
+  mainline: [e192be9d9a30555aae2ca1dc3aad37cba484cd4a]
 fixed-by:
   linux-4.14.y: [6e513bc20ca63f594632eca4e1968791240b8f18]
   linux-4.16.y: [cd8d7a5778a4abf76ee8fe8f1bfcf78976029f8d]


=====================================
issues/CVE-2018-1120.yml
=====================================
@@ -13,5 +13,9 @@ fixed-by:
   linux-4.16.y: [b7458b534b56b9b4d9297ba7a6708aa8071ac8ba]
   linux-4.9.y: [6f1abf8628b750905606996fd5ff5ea22d149238]
   mainline: [7f7ccc2ccc2e70c6054685f5e3522efa81556830]
+fix-depends-on:
+  6347e8d5bcce33fc36e651901efefbe2c93a43ef: |-
+    Convert access_remote_vm to take flags.  This in turn depends on
+    several preceding commits.
 ignore:
   linux-3.2.y: EOL


=====================================
issues/CVE-2018-1128.yml
=====================================
@@ -12,6 +12,9 @@ fixed-by:
   linux-4.14.y: [2fd0d0f9bb59ec5b628622e30f22158cb564c4ea, 66abd96062b627f0ee20a684ebba48cec80233d7,
     0858417b5c2e7bcc0b9e52c4b76e2af3d69e138b, a55056e1523990e1ef9d70531ffaf27fd1ddff55,
     3fd73c8a71f299e30359a63add1f33e3fd834831]
+  linux-4.9.y: [08115452f865b39c9ecbd468201f606ff5434619, 2617cd5743c6d6207de26e51b95c3fcb171ff70e,
+    9da9bb4a0ff67af49c1ca96a313c2cf8e079b46a, 2e901ea8b448a7f5899104a3917ecca2a5e8ab7f,
+    06e925920d4de3da2114876bc607447e929604af]
   mainline: [262614c4294d33b1f19e0d18c0091d9c329b544a, c0f56b483aa09c99bfe97409a43ad786f33b8a5a,
     c571fe24d243bfe7017f0e67fe800b3cc2a1d1f7, 149cac4a50b0b4081b38b2f38de6ef71c27eaa85,
     6daca13d2e72bedaaacfc08f873114c9307d5aea]


=====================================
issues/CVE-2018-1129.yml
=====================================
@@ -3,4 +3,5 @@ references:
 - http://tracker.ceph.com/issues/24837
 fixed-by:
   linux-4.14.y: [b16d0c5d32468a0624505a7b6b211e20488295e9]
+  linux-4.9.y: [18a23fb2632030888fc56a7df73a80f57445718f]
   mainline: [cc255c76c70f7a87d97939621eae04b600d9f4a1]


=====================================
issues/CVE-2018-13096.yml
=====================================
@@ -4,4 +4,5 @@ references:
 - https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=f2fs-dev&id=8c9c95d5f4e68d22f22091546ce554ac9222689c
 fixed-by:
   linux-4.14.y: [b8321ccd045710ee04fd5322c34cadd13a5e58af]
+  linux-4.9.y: [1c87980591a1dc8c5eafdcc5f9953fca4e518465]
   mainline: [e34438c903b653daca2b2a7de95aed46226f8ed3]


=====================================
issues/CVE-2018-13097.yml
=====================================
@@ -4,4 +4,5 @@ references:
 - https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=f2fs-dev&id=d5c28acdb832800fbbcf831f20f75080cba54f04
 fixed-by:
   linux-4.14.y: [f9cf5462b51d98026275cc51437fc531e808b64a]
+  linux-4.9.y: [06e606acedaf8bb00c83c4cee43acdd264287a92]
   mainline: [9dc956b2c8523aed39d1e6508438be9fea28c8fc]


=====================================
issues/CVE-2018-13098.yml
=====================================
@@ -2,6 +2,8 @@ description: Out-of-bound access in f2fs_iget() when mounting a corrupted f2fs i
 references:
 - https://bugzilla.kernel.org/show_bug.cgi?id=200173
 - https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=f2fs-dev&id=190286a242344d42aad83c8e70169d6d72a63d05
+introduced-by:
+  mainline: [7a2af766af15887754f7f7a0869b4603b390876a]
 fixed-by:
   linux-4.14.y: [0081c90ebacebb3a82d0d24bf0f42273ce2d902e]
   linux-4.18.y: [b6f493453c78311598fdd204f7815e683818512a]


=====================================
issues/CVE-2018-13100.yml
=====================================
@@ -5,4 +5,5 @@ references:
 fixed-by:
   linux-4.14.y: [f3d6361a96a455c8ba12226a04efa67a0ada4966]
   linux-4.18.y: [0342426f2bf7298a91efee659ddc033082f6918b]
+  linux-4.9.y: [a3dccfacd3a574365ab6c5118f8a944a4ba691fa]
   mainline: [42bf546c1fe3f3654bdf914e977acbc2b80a5be5]


=====================================
issues/CVE-2018-14610.yml
=====================================
@@ -9,4 +9,5 @@ comments:
     "btrfs: tree-checker: Verify block_group_item".
 fixed-by:
   linux-4.14.y: [34407a175a59b668a1a2bbf0d0e495d87a7777d8]
+  linux-4.9.y: [7a72f918825ddece7a4ed79583836f6f1e06e478]
   mainline: [514c7dca85a0bf40be984dab0b477403a6db901f]


=====================================
issues/CVE-2018-14611.yml
=====================================
@@ -9,4 +9,5 @@ comments:
     "Btrfs: add validadtion checks for chunk loading".
 fixed-by:
   linux-4.14.y: [f7eef132ccc95c9af50b647c5da0511d2b8492f8]
+  linux-4.9.y: [3c77b07dc365a7ed2644ca0dd38e6e40a9652d57]
   mainline: [315409b0098fb2651d86553f0436b70502b29bb2]


=====================================
issues/CVE-2018-14612.yml
=====================================
@@ -11,4 +11,5 @@ comments:
     that applies.
 fixed-by:
   linux-4.14.y: [c0dfb99847851fb830d1e8ea7d5e0571f50c325a, 895586ecb7a4528336d41f81d0ce3985e8abbed6]
+  linux-4.9.y: [6f33d3d8dca8683a4df94e9944296a1a1a2a6f10, 23eb2f435a07e1e09d48ea10c4a22bc96e16fde6]
   mainline: [ba480dd4db9f1798541eb2d1c423fc95feee8d36, 7ef49515fa6727cb4b6f2f5b0ffbc5fc20a9f8c6]


=====================================
issues/CVE-2018-14613.yml
=====================================
@@ -5,4 +5,5 @@ references:
 - https://patchwork.kernel.org/patch/10503147/
 fixed-by:
   linux-4.14.y: [9f268b5cf2d6a716779dfe11f4bc02d6461db693]
+  linux-4.9.y: [058e388e42c8dc5b6ce6248990c75a0459e20197]
   mainline: [fce466eab7ac6baa9d2dcd88abcf945be3d4a089]


=====================================
issues/CVE-2018-14614.yml
=====================================
@@ -5,4 +5,5 @@ references:
 - https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=f2fs-dev&id=bf2d987b270ed14fb205c83c6dcfbfa6dfcd9f8c
 fixed-by:
   linux-4.14.y: [30130700acfad8a705c109325379f5bbe21b3ccc]
+  linux-4.9.y: [91fe514bedf4c72ae8046fe4cfa98c5e201f6b84]
   mainline: [e494c2f995d6181d6e29c4927d68e0f295ecf75b]


=====================================
issues/CVE-2018-14615.yml
=====================================
@@ -3,6 +3,8 @@ description: Buffer overrun in f2fs_truncate_inline_inode() when umounting an f2
 references:
 - https://bugzilla.kernel.org/show_bug.cgi?id=200421
 - https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=f2fs-dev&id=a80a2ff8e0a1265a4e92f4b8ae7caacc83a19503
+introduced-by:
+  mainline: [7a2af766af15887754f7f7a0869b4603b390876a]
 fixed-by:
   linux-4.14.y: [d7d9d29a837358636e12fe09c90a7882b53b2220]
   mainline: [18dd6470c2d14d10f5a2dd926925dc80dbd3abfd]


=====================================
issues/CVE-2018-18281.yml
=====================================
@@ -5,5 +5,6 @@ references:
 fixed-by:
   linux-4.14.y: [541500abfe9eb30a89ff0a6eb42a21521996d68d]
   linux-4.18.y: [d80183541e6006563334eaec9e8d1dc6e40efeb7]
+  linux-4.4.y: [2e3ae534fb98c7a6a5cf3e80a190181154328f80]
   linux-4.9.y: [e34bd9a96704f7089ccad61b6e01ea985fa54dd6]
   mainline: [eb66ae030829605d61fbef1909ce310e29f78821]


=====================================
issues/CVE-2018-18690.yml
=====================================
@@ -5,4 +5,5 @@ references:
 - https://bugzilla.suse.com/show_bug.cgi?id=1105025
 fixed-by:
   linux-4.14.y: [cb7ccb9924bb3596f211badf0d2becf131a979cd]
+  linux-4.9.y: [4ec44e98ab08c704d0ff1a35a21a0682a5562a27]
   mainline: [7b38460dc8e4eafba06c78f8e37099d3b34d473c]


=====================================
issues/CVE-2018-18955.yml
=====================================
@@ -1,7 +1,7 @@
 description: 'userns: also map extents in the reverse map to kernel IDs'
+introduced-by:
+  mainline: [6397fac4915ab3002dc15aae751455da1a852f25]
 fixed-by:
   linux-4.18.y: [bbfed258eb08070e051a1c086282623cc562ff24]
   linux-4.19.y: [9a7a80fb02cc7515b273dbb4249374d6e6a35b70]
   mainline: [d2f007dbe7e4c9583eea6eb04d60001e85c6f1bd]
-introduced-by:
-  mainline: [6397fac4915ab3002dc15aae751455da1a852f25]


=====================================
issues/CVE-2018-3620.yml
=====================================
@@ -43,6 +43,20 @@ fixed-by:
     43b0b90df51125979137b4ca9debb5c479b8e7de, 9fc384dd5354b46ef967f7187764a485935b0dc6,
     862b9e18a0a33b79635122857ee9c20733542271, 0ea75fa0f6bd8bb79bbccdeb77b313bb9463bde3,
     2ff13cec042e5793bbcee126729c49d1a4869583, 22b734b0c850139bb0cd31dcaa37cde7f00ccbd6]
+  linux-4.4.y: [90a231c63cc28d896ab353b027011a949e9884d3, 614f5e84640e382b9916b6f606328191ed0264b3,
+    9bbdab847fc9a0b8cf23fa7354e1210f0b492821, 9ee2d2da676c48a459a99f10f45c71ffca8761a8,
+    52dc5c9f8eee1c569974308f0bb7be64ec63565c, bf0cca01b8736a5e146a980434ba36eb036e37ac,
+    d71af2dbacb5611c1dcdc16fd1d343821d61bd5e, 685b44483f077c949bd5016fdfe734b662b74aba,
+    fa86c208d22d8179ef3d295f6084fc87390c8366, df7fd6ccb358bd4aa3abc8a6ff995b1f3da1b0fb,
+    b55b06bd3b3c977da2c938d1a73d38674cb88086, e3dea38fc8528c9d04acd9a28bcdd7dab3b461fa,
+    09049f022a9b96b0d09d90023d4f0a097a61a767, 8f2adf3d2118cc0822b83a7bb43475f9149a1d26,
+    0aae5fe8413dfcd949d0df1c7d6b835efecd5b3b, 9feecdb6cb73feaa55b0135aee8777eaac848c78,
+    02ff2769edbce2261e981effbc3c4b98fae4faf0, 6b06f36f07e2c91ad0126f17d0fc8f933c827da8,
+    4b90ff885c6cc88795b678414aaf5d7b0153a5dc, fa86c208d22d8179ef3d295f6084fc87390c8366,
+    6a56bd7f2ea31d4c86849b8f67d4e2dc1cb5b788, 7b69cd6fa088e473869512672969e6c490cac1b6,
+    4cdedeefa38f45299b18ae692426d5baaff6b785, 9feecdb6cb73feaa55b0135aee8777eaac848c78,
+    02ff2769edbce2261e981effbc3c4b98fae4faf0, 6b06f36f07e2c91ad0126f17d0fc8f933c827da8,
+    72f6531162bd2f1b57e8114c8358fca507090f41, f46d2b99a6acd87d56822c600fd2587a37e4d56c]
   linux-4.9.y: [bbd07cbb1076de03d896c9c3787081b1080e8c99, 2c9b57e4474d93222bcb6e7f901fd1e71ded699c,
     60712274887fcd4ad5eb8e01796022b6b202143c, 33182fe97add6e83c195e9d0f7297a6499563b52,
     5b2ec92f70f6d4084d23bf42391fd27fa03e8c4c, 432e99b34066099db62f87b2704654b1b23fd6be,


=====================================
issues/CVE-2018-3639.yml
=====================================
@@ -33,9 +33,8 @@ comments:
     (and respective stable releases).
     Basically: 3b78ce4a34b761c7fe13520de822984019ff1a8f^2 ^1aa7a5735a41418d8e01fa7c9565eb2657e2ea3f~1
   Ubuntu-tyhicks: '"Variant 4"'
-  bwh: |-
-    linux-4.4.y, linux-4.9.y, linux-4.14.y are missing a backport of commit
-    af86ca4e3088.  linux-4.4.y is also missing KVM support for SSBD.
+  bwh: linux-4.4.y is missing a backport of commit af86ca4e3088 and KVM support for
+    SSBD.
 reporters:
 - Jann Horn
 - Ken Johnson
@@ -114,6 +113,31 @@ fixed-by:
     bd4b410bc5ea560107126a3df18e9233baaec9f3, 95271aeb93d4681c65e2f94969b23ef6070367a6,
     7445962ff2d652bb957722ca1a08a92d09f3e5d7, 677af592349708498671b0d9290912acb2f203e4,
     75e3417f898fe1d2451e7ceffe93db5c66772b0a]
+  linux-4.9.y: [741c026d1a0c594f7ad509f44488ef29582fed74, 88659d5fd9bea7f6afb227c6d404de750b368b45,
+    3effee64a9993dc5587fb39f0da4455769e53d26, 0f5dd651397b264903e8becc511af6cf384c273e,
+    cf21f58ae6f264e0a10d9736be97342627cf9837, 24e4dd97af40afa4d45e85a32d9c2cc81425a62e,
+    a80714172abca6413d2d6505be64723ae73a903b, 6f70a553666dd8c4fa370eaaa41380eec593229c,
+    19e3a2bec95e966921689ae39117f9dbbaffd99b, 99b13116965f16b2e608e7796cd59198eee5bf06,
+    f854434b37bbf8953900226acd6139081f60d3da, 99318eca2c7ab3250b9614043b9ac6077ff2cb46,
+    7a2d2358ba9b6de29be0a98c8290479df32604b6, 4812ffbbfcac35270b82292e84e8e7187088c8b8,
+    89c6e9b599c573802de1b2fff6a9ccd99c3c4e57, a078e3e81964c31079627dd32c3ea714d5b1531e,
+    4272f528da381673a8e7845c93daa88b8aa4f4e9, 51ef9af2a35bbc21334c801fd15cbfe01210760f,
+    0a112f104548667f5618477ff0f2a54ee626addd, ea055f7d43fb3a9d56e80d0116104555d6dde3f7,
+    036608d62a838aeb63cae0adaf8ac773cb53148c, c71def81cd07e1bd74da468ae6abe1ce62e3157b,
+    ab677c2addbb128f334c4906f27a0285a67d2180, 094c2767c4f02c36eabc27309d78b04f4a216e88,
+    05a85a396f3989e9ac953785d9dccfc7cd0110f2, bf3da841edae882de545d2d19b1fae205cab8d98,
+    f8cd89f5e05d49422315e60ec2db9fcb66d25aca, f79f0efe8e1816063f83926c946026d83b9b287f,
+    eb7b5624be3e6249a880310be486245db15a5f5c, dbb264a253c8b07259d55fb3373b783fcb641b04,
+    6fdd277a9326c5ef3fe94999c9c319ad64333fdd, 3a684641619ff0e06b8d4cb8c2ffbef304c9bdb1,
+    69e9b0b1e04001a743927489bb8b9a10344810d8, 4a58908fa1476c600548f82effc75bcfa890454a,
+    a7c343228e5c32802431e6cc5b855ae61eb4db72, f69e91f2c4ce59deb66bd30150e5153c08873ae9,
+    53c434e735fffbf8715a1778ce44387131e0b080, d0cb78f5e4214db86b12a9448d8ccaa005f43cb9,
+    1189cbf52ad35cfd04a715016200ea81dd4c708f, 7c0b2dc44956533c5aac95f07575feef7b63344c,
+    b7b84401576d3858e9573d69d8287e182444f8e9, ea99935b633bd4766a679e51b173197c750fb00b,
+    599288ec9e20d9772e6e8a27aeae021f018c7336, ec90464d96c50f90bfe1bde6dea748a6c962313c,
+    0ec827f974e198c609c2f258a5a1f11f9af48bb2, b0ef8c72b3d70505ba7fd72af6b1e3fc9b3ae9bc,
+    b965592a07a248ef254d9d421bd34a6b548db21f, 3394ef1a7efc08e3c185ac2446f06284847ccb37,
+    def8c1d045a0fb457a1136f7edcc5ed8b2d81af6]
   mainline: [1aa7a5735a41418d8e01fa7c9565eb2657e2ea3f, 4a28bfe3267b68e22c663ac26185aa16c9b879ef,
     d1059518b4789cabe34bb4b714d07e6089c82ca1, 1b86883ccb8d5d9506529d42dbe1a5257cb30b18,
     5cf687548705412da47c9cec342fd952d71ed3d5, c456442cd3a59eeb1d60293c26cbe2ff2c4e42cf,


=====================================
issues/CVE-2018-5848.yml
=====================================
@@ -6,4 +6,5 @@ references:
 - https://marc.info/?l=linux-wireless&m=151066597529493&w=2
 fixed-by:
   linux-4.14.y: [107b02c81a8761f1f7efc1e8b54d435324ccd13e]
+  linux-4.9.y: [35db4d1ed8a344899a87887fa7bf11be5b057bec]
   mainline: [b5a8ffcae4103a9d823ea3aa3a761f65779fbe2a]


=====================================
issues/CVE-2018-7740.yml
=====================================
@@ -18,10 +18,13 @@ comments:
     ff8c0c53c475 and 045c7a3f may also be needed for older
       releases
 introduced-by:
+  linux-4.9.y: [e5deaa544138b5b01531d06cfee05a969375a5f6]
   mainline: [ff8c0c53c47530ffea82c22a0a6df6332b56c957]
 fixed-by:
-  linux-3.16.y: [363ed2044f82d8997e9ea8231dc1abeab4993755, 8cca49ea37415645203520bff04309c8a87f7677]
+  linux-3.16.y: [363ed2044f82d8997e9ea8231dc1abeab4993755, 8cca49ea37415645203520bff04309c8a87f7677,
+    b9beff69cd84917c7881c176c241db933a3f7f7d]
   linux-3.2.y: [4cba2554682469496ff48536d50c399110d20043, 131802b8292d35e8a407469c485565b199ed79cf]
-  linux-4.14.y: [1e8628443ede418464b0ab101b24fbb7030949b2]
-  linux-4.15.y: [e0fdb5385c4bf26b4be60c0042344c315c039aeb]
-  mainline: [63489f8e821144000e0bdca7e65a8d1cc23a7ee7]
+  linux-4.14.y: [1e8628443ede418464b0ab101b24fbb7030949b2, 61534984904eaf3604626170dc718556210642a2]
+  linux-4.15.y: [e0fdb5385c4bf26b4be60c0042344c315c039aeb, f6b213293ed95d8482769d3c496dfa8692a155b1]
+  linux-4.9.y: [447effd30f9d12f7925595ba9a6ffb01969d6cce, 0c82bca7cd1ae580dc34069d42edfd5102603e7e]
+  mainline: [63489f8e821144000e0bdca7e65a8d1cc23a7ee7, 5df63c2a149ae65a9ec239e7c2af44efa6f79beb]



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/efeeb55f65f8bb4e27558d190d89c91515285abb...d809002c1c357902a2ed7bf38c1fa2efde5e1f74

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/efeeb55f65f8bb4e27558d190d89c91515285abb...d809002c1c357902a2ed7bf38c1fa2efde5e1f74
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20181208/68419adc/attachment-0001.html>

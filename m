From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Wed, 14 Aug 2019 18:23:19 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 3
 commits: Import more data
Message-ID: <5d5451975621d_5993f9913e0c01836462356@sidekiq-asap-02-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
d2f70487 by Ben Hutchings at 2019-08-06T15:53:33Z
Import more data

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
8747b6a7 by Ben Hutchings at 2019-08-06T16:12:50Z
Fill in status for linux-4.4.y-cip-rt for two issues

I missed these two when adding the -rt branches.

Fixes: 71a5163608b3 (&quot;Add linux-4.{4,19}.y-cip-rt branches to ...&quot;)
Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
58c58863 by Ben Hutchings at 2019-08-14T18:23:09Z
Merge branch &#39;bwh/update-issues&#39; into &#39;master&#39;

Update issues

See merge request cip-project/cip-kernel/cip-kernel-sec!4
- - - - -


17 changed files:

- issues/CVE-2017-18379.yml
- + issues/CVE-2017-ipv6-mroute-type-check.yml
- issues/CVE-2018-13093.yml
- issues/CVE-2018-20854.yml
- issues/CVE-2018-20855.yml
- issues/CVE-2018-20856.yml
- issues/CVE-2019-10207.yml
- issues/CVE-2019-11091.yml
- issues/CVE-2019-11487.yml
- issues/CVE-2019-11599.yml
- issues/CVE-2019-11833.yml
- issues/CVE-2019-11884.yml
- issues/CVE-2019-13631.yml
- issues/CVE-2019-13648.yml
- issues/CVE-2019-14283.yml
- issues/CVE-2019-14284.yml
- issues/CVE-2019-3900.yml


Changes:

=====================================
issues/CVE-2017-18379.yml
=====================================
@@ -1,4 +1,11 @@
 description: 'nvmet-fc: ensure target queue id within range'
+references:
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-18379
+- https://git.kernel.org/linus/0c319d3a144d4b8f1ea2047fd614d2149b68f889
+comments:
+  Debian-bwh: |-
+    Introduced in Linux 4.10 by commit c53432030d86 "nvme-fabrics: Add
+    target support for FC transport".
 introduced-by:
   mainline: [c53432030d86429dc9fe5adc3d68cb9d1343b0b2]
 fixed-by:


=====================================
issues/CVE-2017-ipv6-mroute-type-check.yml
=====================================
@@ -0,0 +1,7 @@
+description: IPv6 mroute missing type check
+references:
+- https://lists.openwall.net/netdev/2017/12/04/40
+fixed-by:
+  linux-4.4.y: [ee2f25641633ffb03fb88e4fa8a6424d24d3f295]
+  linux-4.9.y: [1e531ad4316cb47c6c2b42f3257d1841a6e837e7]
+  mainline: [99253eb750fda6a644d5188fb26c43bad8d5a745]


=====================================
issues/CVE-2018-13093.yml
=====================================
@@ -5,6 +5,8 @@ references:
 - https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=for-next&id=afca6c5b2595fc44383919fba740c194b0b76aff
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-13093
 - https://github.com/torvalds/linux/commit/afca6c5b2595fc44383919fba740c194b0b76aff
+reporters:
+- Wen Xu
 introduced-by:
   mainline: [1da177e4c3f41524e886b7f1b8a0c1fc7321cac2]
 fixed-by:


=====================================
issues/CVE-2018-20854.yml
=====================================
@@ -6,6 +6,11 @@ references:
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20854
 - https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=6acb47d1a318e5b3b7115354ebc4ea060c59d3a1
 - https://github.com/torvalds/linux/commit/6acb47d1a318e5b3b7115354ebc4ea060c59d3a1
+comments:
+  Debian-carnil: |-
+    Driver intorduced in same upstream version as per 51f6b410fc22
+    ("phy: add driver for Microsemi Ocelot SerDes muxing") so it is
+    disputable why this has a CVE.
 introduced-by:
   mainline: [51f6b410fc220d8a5a4fae00ebfd8243b6c11d4e]
 fixed-by:


=====================================
issues/CVE-2018-20855.yml
=====================================
@@ -4,6 +4,12 @@ references:
 - https://cdn.kernel.org/pub/linux/kernel/v4.x/ChangeLog-4.18.7
 - https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=0625b4ba1a5d4703c7fb01c497bd6c156908af00
 - https://github.com/torvalds/linux/commit/0625b4ba1a5d4703c7fb01c497bd6c156908af00
+comments:
+  Debian-bwh: |-
+    Introduced in Linux 4.17 by commit 41d902cb7c32 "RDMA/mlx5: Fix
+    definition of mlx5_ib_create_qp_resp".
+introduced-by:
+  mainline: [41d902cb7c326d711674977763c4b30df87611bc]
 fixed-by:
   mainline: [0625b4ba1a5d4703c7fb01c497bd6c156908af00]
 ignore:


=====================================
issues/CVE-2018-20856.yml
=====================================
@@ -4,6 +4,10 @@ references:
 - https://cdn.kernel.org/pub/linux/kernel/v4.x/ChangeLog-4.18.7
 - https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=54648cf1ec2d7f4b6a71767799c45676a138ca24
 - https://github.com/torvalds/linux/commit/54648cf1ec2d7f4b6a71767799c45676a138ca24
+comments:
+  Debian-bwh: |-
+    Introduced in Linux 3.18 by commit 7c94e1c157a2 "block: introduce
+    blk_flush_queue to drive flush machinery".
 introduced-by:
   mainline: [7c94e1c157a227837b04f02f5edeff8301410ba2]
 fixed-by:


=====================================
issues/CVE-2019-10207.yml
=====================================
@@ -2,3 +2,19 @@ description: 'bluetooth: hci_uart: 0x0 address  execution as nonprivileged user'
 references:
 - https://www.openwall.com/lists/oss-security/2019/07/25/1
 - https://lore.kernel.org/linux-bluetooth/20190725120909.31235-1-vdronov at redhat.com/T/#u
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-10207
+- https://lore.kernel.org/linux-bluetooth/20190729122215.9948-1-vdronov at redhat.com/
+comments:
+  Debian-bwh: |-
+    For hci_ath, this was introduced in Linux 2.6.36 by commit
+    b3190df62861 "Bluetooth: Support for Atheros AR300x serial chip".
+    For hci_uart, this was introduced in Linux 4.2 by commit
+    2a973dfada2b "Bluetooth: hci_uart: Add new line discipline
+    enhancements".
+fixed-by:
+  linux-4.14.y: [69f9c2bc3f754ad1d610b30b940681d678c8e684]
+  linux-4.19.y: [56966212e23f82ced10831f7cca02f7339147428]
+  linux-4.4.y: [37fb924139954a28a1f04959070c3cc762b0de4c]
+  linux-4.9.y: [58a01b0bd8ea5fddb51d4d854bb149a1a7312c12]
+  linux-5.2.y: [785b5dc6c06083a874d7bda593de06a01ac7fe6a]
+  mainline: [b36a1552d7319bbfd5cf7f08726c23c5c66d4f73]


=====================================
issues/CVE-2019-11091.yml
=====================================
@@ -133,6 +133,18 @@ fixed-by:
     f223c10cf17689353a41e052bfc16c9ac4758132, adef560d1ef8ab84aceee8b6ebae6f515c2b7a66,
     179adc415f947eb64eb12a15c90d0d8da09418b9, 8be7f1183d2f113d82c0c68a5e23a44d7fb8a8b6,
     683f9fba8c27817b6c2f7320a4095ca353022651]
+  linux-4.4.y-cip-rt: [a50e2ca5757f54fc5b0eabbb77a509209cbcc40d, 31a2c5f7a25b1cf4739ccd0244b0b270c42dab89,
+    71041afe26a30d8a5bfb75ff5699c9cfdee5250a, 693eb3bdaf19dd58aea99a5ed088dd6319ecc098,
+    0f961ec593057bad865d3a9f6834c0ca1582d486, 3092ad5c4f2ed6925847273a65c5598a73ee88d8,
+    2b26dff34698b8f4b57c5492c17a3fcf71e32de6, 0144cbc1247411f6fa07447ce9a4ae204903031a,
+    e2896d6b1e485605b5c436f11abc2016a60c083a, 06deb655ae265b397cd013db5cb77aa442a68617,
+    48204fd98023ff7d05166c7ddb9d8afd2c5006e9, e0e64cdc7fd9eb3dbcf670e8c3dd9dfd0501d104,
+    9fe26a407f0eca058829dec41a4de71c70bfc3ec, 3fb41b4e2d389f2b187e2e12a7c8611d6c4b0e30,
+    8c7398befdf1ecb163b5d0f6f5ba27b45c63211e, d4c1e6cbbcdca0f4688a58092ecbb81a58fe4421,
+    a41a2dee403d99e6c13d35b935a310b0609b8e6a, 7a6c2a6c4235e68472d1924b2d3f6f808ee5d39a,
+    f223c10cf17689353a41e052bfc16c9ac4758132, adef560d1ef8ab84aceee8b6ebae6f515c2b7a66,
+    179adc415f947eb64eb12a15c90d0d8da09418b9, 8be7f1183d2f113d82c0c68a5e23a44d7fb8a8b6,
+    683f9fba8c27817b6c2f7320a4095ca353022651]
   linux-4.9.y: [ffe8cffc8be1ae47c08cbc3571bed6b5b0fa53ad, 192d1975450e51c1abb725343a7e19a4d61e30bd,
     626743f43da44598076019a82193caf49dca1fde, 2a099011de8abebac475a90dad1835c60dfca88c,
     da360f1f5eb43e0d71009bab3be53c7a06d40caf, 96c06cda5b4bdc6a3a9a8f8adc46c86077a70ee0,


=====================================
issues/CVE-2019-11487.yml
=====================================
@@ -14,6 +14,7 @@ references:
 - https://github.com/torvalds/linux/commit/8fde12ca79aff9b5ba951fce1a2641901b8d8e64
 - https://github.com/torvalds/linux/commit/f958d7b528b1b40c44cfda5eabe2d82760d868c3
 - https://usn.ubuntu.com/usn/usn-4069-1
+- https://usn.ubuntu.com/usn/usn-4069-2
 comments:
   Debian-bwh: |-
     I'm having trouble backporting to this to 3.16 because we don't
@@ -45,3 +46,4 @@ ignore:
   linux-3.16.y: Minor issue, difficult to backport fix
   linux-4.4.y: Minor issue, difficult to backport fix
   linux-4.4.y-cip: Minor issue, difficult to backport fix
+  linux-4.4.y-cip-rt: Minor issue, difficult to backport fix


=====================================
issues/CVE-2019-11599.yml
=====================================
@@ -8,6 +8,7 @@ references:
 - http://www.openwall.com/lists/oss-security/2019/04/29/2
 - https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=04f5866e41fb70690e28397487d8bd8eea7d712a
 - https://usn.ubuntu.com/usn/usn-4069-1
+- https://usn.ubuntu.com/usn/usn-4069-2
 comments:
   Debian-bwh: |-
     The backports to 4.4 and 4.9 are still under discussion.


=====================================
issues/CVE-2019-11833.yml
=====================================
@@ -7,6 +7,7 @@ references:
 - https://usn.ubuntu.com/usn/usn-4068-2
 - https://usn.ubuntu.com/usn/usn-4069-1
 - https://usn.ubuntu.com/usn/usn-4076-1
+- https://usn.ubuntu.com/usn/usn-4069-2
 introduced-by:
   mainline: [a86c61812637c7dd0c57e29880cffd477b62f2e7]
 fixed-by:


=====================================
issues/CVE-2019-11884.yml
=====================================
@@ -8,6 +8,7 @@ references:
 - https://usn.ubuntu.com/usn/usn-4068-2
 - https://usn.ubuntu.com/usn/usn-4069-1
 - https://usn.ubuntu.com/usn/usn-4076-1
+- https://usn.ubuntu.com/usn/usn-4069-2
 comments:
   Debian-carnil: similar issue to CVE-2011-1079.
 fixed-by:


=====================================
issues/CVE-2019-13631.yml
=====================================
@@ -5,7 +5,10 @@ references:
 introduced-by:
   mainline: [a19ceb56cbd1e1beff3e9cf6042e1f31f6487aa6]
 fixed-by:
+  linux-4.14.y: [81bf168d855cc1d97a7c9cde6787ff42485556c8]
   linux-4.19.y: [d657077eda7b5572d86f2f618391bb016b5d9a64]
+  linux-4.4.y: [3ca20e950203a6c7759186ec4e89cbd33ee2bf81]
+  linux-4.9.y: [2628fa1a6d824ee1f3fe67a272a3d00ba33d23fa]
   linux-5.2.y: [63fabf4287b23da069986b7a7fdc6ad0b202f00a]
   mainline: [2a017fd82c5402b3c8df5e3d6e5165d9e6147dc1]
 ignore:


=====================================
issues/CVE-2019-13648.yml
=====================================
@@ -2,6 +2,7 @@ description: 'powerpc/tm: Fix oops on sigreturn on systems without TM'
 references:
 - https://patchwork.ozlabs.org/patch/1133904/
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-13648
+- https://www.openwall.com/lists/oss-security/2019/07/30/1
 comments:
   Debian-bwh: |-
     We have disabled CONFIG_PPC_TRANSACTIONAL_MEM in 4.9.184-1 for
@@ -11,6 +12,11 @@ reporters:
 introduced-by:
   mainline: [2b0a576d15e0e14751f00f9c87e46bad27f217e7]
 fixed-by:
+  linux-4.14.y: [26bee6ef0d72193d58a085610fe49169d23baa83]
+  linux-4.19.y: [b993a66d8ddc1c26da0d9aa3471789cc170b28ee]
+  linux-4.4.y: [e67fd28f9ed887d0c8124bda96b66dab87823eac]
+  linux-4.9.y: [08ee34d86c9c6a9b93c0986d7fc6e272690e8d24]
+  linux-5.2.y: [8716e8d122e12799eff9e92c05fdabba31d47b2f]
   mainline: [f16d80b75a096c52354c6e0a574993f3b0dfbdfe]
 ignore:
   linux-4.19.y-cip: No members are using powerpc


=====================================
issues/CVE-2019-14283.yml
=====================================
@@ -1,6 +1,14 @@
 description: 'floppy: fix out-of-bounds read in copy_buffer'
+references:
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14283
+- https://git.kernel.org/linus/da99466ac243f15fbba65bd261bfc75ffa1532b6
+introduced-by:
+  mainline: [1da177e4c3f41524e886b7f1b8a0c1fc7321cac2]
 fixed-by:
+  linux-4.14.y: [80637a906eded08e04ed8a6fbbdd2b8112eaa387]
   linux-4.19.y: [ff54c44f103825a426e46d08b5d3d76e44791a87]
+  linux-4.4.y: [d105eaf5fb67a193df8fe72e64690c43e343a560]
+  linux-4.9.y: [1fdefbb5bc70ff20ea49083c6984aae86e3ecf93]
   linux-5.2.y: [d39c2e97277229970fe2ae56dcbf67a535e14873]
   mainline: [da99466ac243f15fbba65bd261bfc75ffa1532b6]
 ignore:


=====================================
issues/CVE-2019-14284.yml
=====================================
@@ -1,6 +1,14 @@
 description: 'floppy: fix div-by-zero in setup_format_params'
+references:
+- https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14284
+- https://git.kernel.org/linus/f3554aeb991214cbfafd17d55e2bfddb50282e32
+introduced-by:
+  mainline: [1da177e4c3f41524e886b7f1b8a0c1fc7321cac2]
 fixed-by:
+  linux-4.14.y: [a904a690ea0317fcd88c5b9dfef40ef0f98d9530]
   linux-4.19.y: [6e34fd07484a0622a17b40e0ca89ed451260ef45]
+  linux-4.4.y: [26d6284d5d392bd96c414f745bcbf3620e93c8fd]
+  linux-4.9.y: [604206cde7a6c1907f6f03d90c37505a45ef1b62]
   linux-5.2.y: [697c0af7468a941522c1e26345aa5128fa2a4815]
   mainline: [f3554aeb991214cbfafd17d55e2bfddb50282e32]
 ignore:


=====================================
issues/CVE-2019-3900.yml
=====================================
@@ -12,5 +12,7 @@ introduced-by:
 fixed-by:
   linux-4.14.y: [ae446749492d8bd23f1d0b81adba16e5739dc740, 46c7fce709dccb4b0e4a5a06bfacdf2bb1a4fc43,
     011942d12cc28c58fdeb2ca77e745c4c370fc250]
+  linux-4.19.y: [3af3b843aee41ed22343b011a4cf3812a80d2f38, 239910101c4ebf91a00e6f4a81ac3144b121f0c4,
+    02cdc166128cf9cb2be4786b997eebbc0b976bfa]
   mainline: [e2412c07f8f3040593dfb88207865a3cd58680c0, e79b431fb901ba1106670bcc80b9b617b25def7d,
     c1ea02f15ab5efb3e93fc3144d895410bf79fcf2]



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/9ff7bd4ee1ec373015f0e2d2c9921f68f384635d...58c5886331a7cf41190f22eeaaa1ee7a03f3eb44

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/9ff7bd4ee1ec373015f0e2d2c9921f68f384635d...58c5886331a7cf41190f22eeaaa1ee7a03f3eb44
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190814/cd5ac875/attachment-0001.html>

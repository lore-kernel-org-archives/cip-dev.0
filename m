Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C624C433F5
	for <webhook@archiver.kernel.org>; Thu, 24 Mar 2022 00:43:25 +0000 (UTC)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com
 [209.85.219.171])
 by mx.groups.io with SMTP id smtpd.web11.5207.1648082603998517284
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Mar 2022 17:43:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=ccE3P338;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.171,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f171.google.com with SMTP id t33so5739536ybt.12
        for <cip-dev@lists.cip-project.org>;
 Wed, 23 Mar 2022 17:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=WEWr/501tfW+w+WVafrgReXSCHyZfIIRp8oWXb59dgo=;
        b=ccE3P338RAqW1/R6RtJmz/M9MSIxM2gTfdZEjQue1lvq1obpRZsf2porj4FSrnRBof
         CSRi8AA9EXPpnumqEXN3JkYyIP8D9kpaMAXK89nRNKFPS9j/DqhMvfnutvU0qZEpbQMF
         KOtXInFd7jmf96Yv4Gz+jypX1b28yypUUr+pjsNMGbi9Hcr6cq9/g9nCEAsTr3ReMJdp
         mhVa7b0wXMLkwbHulw/kpUDhMZTjMz9ipillIQg3VVptSc6fLqxIQLh0pT3P7QoHHKST
         nATzaux2wmPL5ncW7AJjXlzwrvrPmgVHWpjlD2hR+Lme19ql76cB/vAUDVOGioyHHAE8
         ZTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WEWr/501tfW+w+WVafrgReXSCHyZfIIRp8oWXb59dgo=;
        b=KSfWo7P9q8x7tZyzo5MlBx/1KjUl3fIzeHTXZtlT8o1ysB+BZNJIuYcWPA9V3WbLPb
         oYzu9qChJr2KFyumNNDceAl69R/p2JrHipVFCXNYuggG0dxvUgpqUmHoEa8Fzon4vHPo
         f7cnaZ++0Jo5jK29c8T8kU9d9us16p0UaTSaXdHHYxl217G6JlwtjpmlSfolJ0/f6tO9
         QK2RCWun3uCJRQfVD/wsUngsV32HdNPl1umrA91tobWs9U2u5VXL6jYAADRwWN3PajgZ
         2R9c157lOoS77/nb3r9abMuxVy4pQGhFHlbvqB8oXrqFKoTsfFYfyNZ74P3jn5SL5ldX
         UsFw==
X-Gm-Message-State: AOAM530zp07cUK/chZipOvIoDwkZznIuq7jvfXFZ279JiWlXYcSaxTxW
	TeQrPknxzk0rhWeWpKwamfMfGW8yGiiNwB1f4LjhLcZt0KRMgg==
X-Google-Smtp-Source: 
 ABdhPJylk9x0HToL+F3wmeA0GvIaOONjNLOZLarKcHailp5WF58QU7FIxYaqBFtb5iO8s5khGR0/yNmyS8cjHtmDPcY=
X-Received: by 2002:a25:d948:0:b0:633:b734:aa with SMTP id
 q69-20020a25d948000000b00633b73400aamr2454963ybg.220.1648082602320;
 Wed, 23 Mar 2022 17:43:22 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 24 Mar 2022 09:42:46 +0900
Message-ID: 
 <CAODzB9rGKyUBr1kY5V0tCBSaXjr0keXvAy+KsSCvJquNtC6W9Q@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Mar 2022 00:43:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7818

Hi !

It's this week's CVE report.

This week reported 8 new CVEs and 2 updated CVEs.

* New CVEs

CVE-2022-0995: ouf of bounds writes in watch_queue event notification subsystem

CVSS v3 score is not provided

A OOB bug was found in watch_queue event notification subsystem. This
bug may cause a local user to gain privileges access or cause DoS.
This issue was introduced by c73be61 ("pipe: Add general notification
queue support") that was merged in 5.8-rc1.

Fixed status

mainline: [c993ee0f9f81caf5767a50d1faeba39a0dc82af2,
db8facfc9fafacefe8a835416a6b77c838088f8b,
  c1853fbadcba1497f4907971e7107888e0714c81,
96a4d8912b28451cd62825fd7caa0e66e091d938,
  a66bd7575b5f449ee0ba20cfd21c3bc5b04ef361,
3b4c0371928c17af03e8397ac842346624017ce6,
  7ea1a0124b6da246b5bc8c66cddaafd36acf3ecb,
2ed147f015af2b48f41c6f0b6746aa9ea85c19f3,
  4edc0760412b0c4ecefc7e02cb855b310b122825]
stable/5.10: [d729d4e99fb85f734805ff37dd79f38e7db21c0f,
2039900aadba14f438b04d262721ffebc4d33547,
  e2b52ca4988e12ad75aeece53c4f0af849f0d9dc,
880acbb718e15e46d37fcde75fa52d5cb4336dca,
  06ab8444392acdbffb57869d6220fb6654a8c95e,
ec03510e0a7784c4fb5c4b3297878a72cca834d5,
  24d268130e3cbbef0f9ebb1f350e4c6fcdfffb65,
648895da69ced90ca770fd941c3d9479a9d72c16]

CVE-2022-0998: vdpa: clean up get_config_size ret value handling

CVSS v3 score is not provided

An integer overflow bug was found in Vhost driver for vDPA-based backend.
It introduced by 3ed21c1 ("vdpa: check that offsets are within
bounds") that merged in 5.16-rc6.
The commit was backported to 5.10 so 5.10 is affected by this bug.
This driver was introduced in 5.7-rc1.

It looks no CIP member enabled CONFIG_VHOST_VDPA.

Fixed status

mainline: [3ed21c1451a14d139e1ceb18f2fa70865ce3195a]
stable/5.10: [51f6302f81d243772047a74ffeceddfb11c964d5]
stable/5.15: [b08b3bfcc720686cd73888ab20111acd9cbfcb19]

CVE-2022-1011: fuse: fix pipe buffer lifetime for direct_io

CVSS v3 score is not provided

An UAF bug was found in FUSE filesystem. An local attacker can read
any data from filesystem.

It was introduced by commit c302162 ("fuse: support splice() reading
from fuse device") that was merged in 2.6.35-rc1.
The commit 0c4bcfd was failed to apply to 4.9, 4.14, and 4.19 as of 2022/03/18.

Fixed status

mainline: [0c4bcfdecb1ac0967619ee7ff44871d93c08c909]
stable/5.10: [ab5595b45f732212b3b1974041b43a257153edb7]
stable/5.15: [ca62747b38f59d4e75967ebf63c992de8852ca1b]
stable/5.16: [58a9bdff32fde29137731e574b17c42592875fd0]
stable/5.4: [a9174077febfb1608ec3361622bf5f91e2668d7f]

CVE-2021-45868: UAF bug in fs/quota/quota_tree.c

CVSS v3 score is not provided

UAF bug was found in remove_tree() and find_tree_dqentry() in
fs/quota/quota_tree.c.
The mainline and all stable kernels, includes 4.4, were fixed.

Fixed status

mainline: [9bf3d20331295b1ecb81f4ed9ef358c51699a050]
stable/4.14: [1d0606dc3e27e6c281a2684cb8bdf47134051114]
stable/4.19: [e5222c87dc441dcc8a66e93cb3fd34dfff03d3ec]
stable/4.4: [7a40f3e53f5de1d6876df8a9e8025b50616b8818]
stable/4.9: [f7dd331a896700728492e02c20a69e53221cd7a4]
stable/5.10: [ceeb0a8a8716a1c72af3fa4d4f98c3aced32b037]
stable/5.15: [332db0909293f3f4d853ee2ea695272c75082d87]
stable/5.4: [10b808307d37d09b132fc086002bc1aa9910d315]


CVE-2022-0854: swiotlb information leak with DMA_FROM_DEVICE

CVSS v3 score is not provided

A memory leak bug was found in DMA subsystem that cause local user may
be able to read kernel memory.

Commit aa6f8dc fixes ddbd89d. commit ddbd89d was marged in 5.17-rc6.
Commit ddbd89d describes commit a45b599 ("scsi: sg: allocate with
__GFP_ZERO in sg_build_indirect()") in the bug flaw steps. The commit
a45b599 was backported to stable kernels(includes 4.4.y). So it seems
as if stable kernels are affected by this issue.
Patches were failed to apply to 4.9, 4.19, 5.4, and 5.10. Also,
kernel/dma/swiotlb.c and related files were moved from lib/ since
4.18-rc2 by commit cf65a0f ("dma-mapping: move all DMA mapping code to
kernel/dma")

Fixed status

mainline: [ddbd89deb7d32b1fbb879f48d68fda1a8ac58e8e,
aa6f8dcbab473f3a3c7454b74caa46d36cdc5d13]
stable/5.15: [7403f4118ab94be837ab9d770507537a8057bc63,
2c1f97af38be151527380796d31d3c9adb054bf9]
stable/5.16: [270475d6d2410ec66e971bf181afe1958dad565e,
62b27d925655999350d0ea775a025919fd88d27f]

CVE-2022-0494: block-map: add __GFP_ZERO flag for alloc_page in
function bio_copy_kern

CVSS v3 score is not provided

A kernel information leak bug was found in bio_copy_kern(). An local
attacker send SCSI_IOCTL_SEND_COMMAND command via scsi_ioctl(), there
is a path to return uninitialized buffer to user which cause kernel
information leak.

The commit ce288e0 ("block: remove BLK_BOUNCE_ISA support") that was
marged in 5.13-rc1, changed page allocation strategy in
bio_copy_kern().

-   page = alloc_page(q->bounce_gfp | gfp_mask);
+ page = alloc_page(GFP_NOIO | gfp_mask);

Also, bio_copy_kern() was moved from block/bio.c to /block/blk-map.c
by commit 130879f ("block: move bio_map_* to blk-map.c") which was
merged in 5.7-rc1. so, applying patch to before 5.13 kernels will be
fail.

Its looks like earlier than 5.13 kernels may be affected by this issue.

Fixed status

mainline: [cc8f7fe1f5eab010191aa4570f27641876fa1267]
stable/5.15: [a1ba98731518b811ff90009505c1aebf6e400bc2]
stable/5.16: [f8c61361a4f52c2a186269982587facc852dba62]

CVE-2022-0886, CVE-2022-27666: esp: Fix possible buffer overflow in
ESP transformation

CVSS v3 score is not provided

According to the
https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-0886,
CVE-2022-0886 is duplicated of CVE-2022-27666.

A buffer overflow bug was found in net/ipv4/esp4.c and
net/ipv6/esp6.c. A local attacker may be able to gain privileges by
this bug.

This issue was introduced by commit cac2661 ("esp4: Avoid skb_cow_data
whenever possible") and 03e2a30 ("esp6: Avoid skb_cow_data whenever
possible") these commits were merged in 4.11-rc1.

Applying patch to 4.14, 4.19, and 5.4 were failed.
4.14: https://lore.kernel.org/stable/16472498745560@kroah.com/
4.19: https://lore.kernel.org/stable/164724987424249@kroah.com/
5.4: https://lore.kernel.org/stable/16472498744220@kroah.com/

Fixed status

mainline: [ebe48d368e97d007bfeb76fcb065d6cfc4c96645]
stable/5.10: [9248694dac20eda06e22d8503364dc9d03df4e2f]
stable/5.15: [4aaabbffc3b0658ce80eebdde9bafa20a3f932e0]
stable/5.16: [9afe83f62aac348db1facb28bfc106109a06e44d]

CVE-2022-1043: io_uring: fix xa_alloc_cycle() error return value check

CVSS v3 score is not provided

A flaw was found in the Linux kernels io_uring implementation where an
attacker with a local account can corrupt system memory, crash the
system or escalate privileges.

This issue is affected to 5.6 to 5.14-rc6.

Fixed status

mainline: [a30f895ad3239f45012e860d4f94c1a388b36d14]
stable/5.10: [695ab28a7fa107d0350ab19eba8ec89fac45a95d]

* Updated CVEs

CVE-2021-3772: Invalid chunks may be used to remotely remove existing
associations

There was two updates this week.

- stable/4.14 was fixed.
- Added commit 6056abc to stable/5.10.

Fixed status

mainline: [4f7019c7eb33967eb87766e0e4602b5576873680,
eae5783908042a762c24e1bd11876edb91d314b1,
  438b95a7c98f77d51cbf4db021f41b602d750a3f,
a64b341b8695e1c744dd972b39868371b4f68f83,
  aa0f697e45286a6b5f0ceca9418acf54b9099d99,
ef16b1734f0a176277b7bb9c71a6d977a6ef3998,
  9d02831e517aa36ee6bdb453a0eb47bd49923fe3]
stable/4.14: [82ad781d98040b4a5eea4eeb9a5acdd200a420c6,
878cc8e47413d6c35995187992039b1a664ea4f6,
  8a7952ec41de8f855f0cddb552cf3f5340a80482,
9f22d1fed3bb7b8d4e79b24b76962f1e39cce660,
  202d5cd14f2e707259d45a3db05a9097725ed9fb,
32ceffec2a9a23346d33c0b48f4a7269ede2480d,
  a9ded117c98b0aa20e20cb82943ba5f0c34c8881]
stable/4.19: [1f52dfacca7bb315d89f5ece5660b0337809798e,
86044244fc6f9eaec0070cb668e0d500de22dbba,
  aa0f697e45286a6b5f0ceca9418acf54b9099d99,
ef16b1734f0a176277b7bb9c71a6d977a6ef3998,
  9d02831e517aa36ee6bdb453a0eb47bd49923fe3]
stable/4.4: [629d2823abf957bcbcba32154f1f6fd49bdb850c,
c0b5302e3a74997b57985b561e776269d1951ac7]
stable/4.9: [42ce7a69f8140783bab908dc29a93c0bcda315d5,
16d0bfb045abf587c72d46dfea56c20c4aeda927]
stable/5.10: [a7112b8eeb14b3db21bc96abc79ca7525d77e129,
c2442f721972ea7c317fbfd55c902616b3151ad5,
  14c1e02b11c2233343573aff90766ef8472f27e7,
dad2486414b5c81697aa5a24383fbb65fad13cae,
  8c50693d25e4ab6873b32bc3cea23b382a94d05f,
ad111d4435d85fd3eeb2c09692030d89f8862401,
  6056abc99b58fe55033577f3ad6e28d001a27641]
stable/5.14: [332933f9ae0a17f6e362ec0f35ed51e7bc8e76d6,
6277d424ead2702798e8b981fb6f51b8ec2304ec,
  7975f42f10380ff9743a7ee94ef3cb81f1a8275d,
44ef3ecbc24a532fde6a8c7b87b3e55d4ad1c1d1,
  dd82b3a345abf6fc325e748469d9d7f477a0b718,
1c255b5f68f4dac3f1f0f24741575aac2325470a,
  0717c71deae69aa3511492c302dd44a2f3722184]
stable/5.4: [5953ee99bab134d74c805a00eaa20fed33f54255,
5fe74d5e4d58262e4adde277ef773032c57e873d,
  d6470c2200253da67a439aa18c9ce32a127c5a61,
0aa322b5fe70204d3d7f9d1d4cd265fdff2e5a1f,
  df527764072c5fb7ede93a41cc8f3acbf41dde8c,
0f5b4c57dc8573bdb9926b17748065ac2104b1d1]

CVE-2022-23960: Arm cpus BHI problem

Following patches were backported to stable/4.19 this week.

e8bfe29, 87eccd5, 51acb81, 266b1ef, ebcdd80, af484e6, f689fa5,
9e05662, 22fdfcf, 901c0a2, 91429ed, e18876b, 5b5ca26, 7b012f6,
a68912a, c20d551, 5f051d3, a44e7dd, ed5dec3

Fixed status

mainline: [9dd78194a3722fa6712192cdd4f7032d45112a9a,
04e91b7324760a377a725e218b5ee783826d30f5,
  8d9d651ff2270a632e9dc497b142db31e8911315,
b9baf5c8c5c356757f4f9d8180b5e9d234065bc3,
  25875aa71dfefd1959f07e626c4d285b88b27ac2,
4330e2c5c04c27bebf89d34e0bc14e6943413067,
  1b33d4860deaecf1d8eec3061b7e7ed7ab0bae8d,
5bdf3437603d4af87f9c7f424b0c8aeed2420745,
  d739da1694a0eaef0358a42b76904b611539b77b,
03aff3a77a58b5b52a77e00537a42090ad57b80b,
  c091fb6ae059cda563b2a4d93fdbc548ef34e1d6,
6c5bf79b69f911560fbf82214c0971af6e58e682,
  ed50da7764535f1e24432ded289974f2bf2b0c5a,
13d7a08352a83ef2252aeb464a5e08dfc06b5dfd,
  c47e4d04ba0f1ea17353d85d45f611277507e07a,
a9c406e6462ff14956d690de7bbe5131a5677dc9,
  aff65393fa1401e034656e349abd655cfe272de0,
ba2689234be92024e5635d30fe744f4853ad97db,
  b28a8eebe81c186fdb1a0078263b30576c8e1f42,
bd09128d16fac3c34b80bd6a29088ac632e8ce09,
  dee435be76f4117410bbd90573a881fd33488f37,
558c303c9734af5a813739cd284879227f7297d2,
  a5905d6af492ee6a4a2205f0d550b3f931b03d03,
228a26b912287934789023b4132ba76065d9491c,
  58c9a5060cb7cd529d49c93954cdafe81c1d642a]
stable/4.19: [dc64af755099d1e51fd64e99fe3a59b75595814a,
45c25917ceb7a5377883ef4c3a675276fba8a268,
  67e1f18a972be16363c6e88d7b29cde880774164,
99e14db3b711c27f93079ba9d7f2fff169916d5f,
  29db7e4b67fccf5e1fe28ec89f2add90ce74d77b,
e8bfe29afc09ac77b347540a0f4c789e6530a436,
  87eccd56c52fcdd6c55b048d789da5c9c2e51ed3,
51acb81130d1feee7fd043760b75f5377ab8d4f0,
  266b1ef1368e06ac4c5a89eb9774ef2bbaa54e19,
ebcdd80d0016c7445e8395cec99b9ce266a26001,
  af484e69b5e83095609d8b5c8abaf13a5460229e,
f689fa53bb944873f75fe1584f446cae1aabd2c1,
  9e056623dfc538909ed2a914f70a66d68ec71ec3,
22fdfcf1c2cea8e6dc383d46cbbe59d476d24a96,
  901c0a20aa94d09a9328899e2dd69a8d43a3a920,
91429ed04ebe9dbec88f97c6fd136b722bc3f3c5,
  e18876b523d5f5fd8b8f34721f60a470caf20aa1,
5b5ca2608fbd6f250281b6a1d0d73613f250e6f1,
  7b012f6597e55a2ea4c7efe94b5d9a792b6e5757,
a68912a3ae3413be5febcaa40e7e0ec1fd62adee,
  c20d551744797000c4af993f7d59ef8c69732949,
5f051d32b03f08a0507ac1afd7b9c0a30c8e5d59,
  a44e7ddb5822b943cd50c5ad6a2541fb445d58bd,
ed5dec3fae86f20db52930e1d9a7cc38403994cc]
stable/4.9: [b24d4041cfb6dab83f9edf40573375bd1365e619,
dfea9912129157ba3c5a9d060e58df17fb688e72,
  964aafb29a07cb7cdea71ef41a75394e879f529c,
da3dfb69bbc3fdfeb3e5930fe28bcd689751a594,
  48b1aa98e19d189703d518166ddb2520164b3164]
stable/5.10: [b7f1e73c4ddf2044530091e69114a5fc1a1229d0,
46deb224680bb33c8e87440a7b909d16e5a7d7c5,
  29d9b56df1e18a8ff2e669b79e511163972a8b65,
3f9c958e3572b19b1cfb9d28eeb15be0a5d80193,
  302754d023a06171113e8fb20c7b2a18ebf9088f,
dc5b630c0d532140e194997d350f587dbcc78bfb,
  7048a21086fb16ec67287a25b62e88b0cd17c8c3,
192023e6baf7cce7fb76ff3a5c24c55968c774ff,
  5242d6971e106be115d9dace9c1441f4a2e1cb25,
d93b25a6654812e0511b71a6d4a207f6b1ce5dfe,
  bda89602814c69e6f027878209b0b9453133ada2,
5275fb5ea5f573ce1ecd2bf0bcd928abb916b43d,
  e55025063276fcf7b07e9340c38d70b04aa8a7b9,
8c691e5308c531deede16bef4f2d933d5f859ce7,
  73ee716a1f6356ca86d16d4ffc97fcfc7961d3ef,
26211252c1c104732a0fea6c37645f1b670587f5,
  49379552969acee3237387cc258848437e127d98,
3f21b7e355237aa2f8196ad44c2b7456a739518d,
  56cf5326bdf9c20de9a45e4a7a4c0ae16833e561,
1f63326a5211208e2c5868650e47f13a9072afde,
  13a807a0a080383ceab6c40e53c0228108423e51,
e192c8baa69ac8a5585d61ac535aa1e5eb795e80,
  38c26bdb3cc53f219d6ab75ac1a95436f393c60f,
551717cf3b58f11311d10f70eb027d4b275135de,
  b65b87e718c33caa46d5246d8fbeda895aa9cf5b,
f3c12fc53e0a1fffbe102a9501c7bb6efdabbe99,
  fc8070a9c5ad3e0ac343532df7d4d2d709b173a8,
86171569312b5870aaedc74b4b28d444c0f72105,
  b19eaa004f2eeae94a4fcf5f0cadac35cc579a72,
7ae8127e412361025e7b4a0e6347ca9e8f3ed109,
  dbcfa98539531bff0d7e4d6087741702dfa50f06,
162aa002ec1a78e91cf2f0b8e7450e2770b2941f,
  97d8bdf33182494b7cb327ed555313d17d80c639]
stable/5.15: [f02cab2bed1a3493a230e54d83ff117bc59f480e,
878ad97f745ebc6b135d87b6901dbe93d07745d3,
  2dca61693e6cb6d163e5ba2cf18f2c3270d7ec30,
576548846f1ee53a4d04fa5f91e6a088adbfe3f8,
  842f2d498ee1e75fc9bf78555ee5b59c894c071b,
b7beeab84f02091124b176ba34c71a601762d1de,
  44adac5908ff712e0fee34e3472f884c17af8025,
368a1fd8c4a600ed8ae605afa27904f359a57161,
  479c9bb741bf6e1ac300d2f3c2797c7fbce117c0,
4a691bbf56a186f9df432b0bfd666dc2e82e4334,
  e25a9dced2bdbace585d613444f2cf317b84cda5,
2e09754a03a7e54eae6017d94fb9c265217288f1,
  be9c5526aad63ab0b13d72978206aec12ede9d76,
a40472d463f9ab6f971850989aa5a21f704b5cfd,
  6895584a92eeaa0702afc47c9758b7fca6345fec,
517f988ee0500688ac23e011bc3bbbf502e76a23,
  ffb8a34c0fd81fdcf677bc8e9af251ea526e8c49,
50e700a117669e072fb9e47ff3ea49e4a8cacf04,
  cfd0c38125aa27a15617473d053897eb7967ab1c,
d7066114dcd6a295122c5942791025e16a33f89f,
  8e55b9b0e76575e3755919820848b9ca53d82381,
4bbfd0c280254b273c564767021bb9b0f945148e,
  fb2bb2ec137c3a8afbd91c949d9384d9e8a913c9,
8979720ac64c70af1395ce78e5c6ffb546b43e0d,
  3317d21b84e91be72df14744040513a280b88946]
stable/5.16: [f5eb0f1dcde4b7c2b5ee920ae53bcecaaba03947,
0f0fd6ef76dee10aae861c69635c42b1c427e577,
  21ceffd3628edfc775d33851cf56ea1d85c528fc,
9fd1d31810ccf6b4e4df8ccf2e68bbdcf528d186,
  680e356c1be19a7663d8077be12e0ab048430ebd,
d1e3d6d26d9eab22548c3b7373ec12bbfecc765f,
  346793c01582f62f4a5536c325a3dfc627ca543a,
46af6fc4f7a22ada597982ff01db34fb4bdba6a3,
  7b63df956358d183c25178e970f6ed304cd0f659,
57e9a5fbd1f8b8ac5b7f849715fcdf5a32dda040,
  62cfcf8d06ca7786e781e1b60f57b67f43448868,
5da0c4bbae492434b534ffd39aac5d5610190491,
  dfb25997bdefca7a3cd69c1dea872ba52133d31f,
e0077b0a66f14998c0d18508bf945a40a0d3ebab,
  984e7e3ebac334d7af0069a4d3636cf2338525df,
483fa5319f16b627e7873c1079e35ebbfb04cf45,
  448a95af1b7ae205eb762c2c1fb35b290cc3032e,
d535ca624f6d439424aeeb0a3cc4a426cfd9a993,
  b9c29587c533faaa0aefeaaf7a4a4ff834975ba4,
d4293ed32d390ce363d964a9216ce9ab0ff9d74c,
  f0567fc3fb835499eda68f20e30ce16f9b83d774,
0b2bf1b37b5ebd90e69e30d8c2d6e1cd0c1f37b4,
  e1e87704621efcf0310bd1543a8e6352156a43bd,
2df4d0aba0e673d37be14901e853d1d540b19bbd,
  80d1978b8062cbad01cbea2aec2a5aac8f61c366]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26557: kernel: predictable Authvalue in Bluetooth Mesh
Provisioning Leads to MITM

No fix information.

CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26560: kernel: impersonation attack in Bluetooth Mesh Provisioning

No fix information.

Regards,


-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com


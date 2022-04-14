Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2798EC4708E
	for <webhook@archiver.kernel.org>; Thu, 14 Apr 2022 16:03:54 +0000 (UTC)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
 [209.85.167.182])
 by mx.groups.io with SMTP id smtpd.web10.5843.1649895038417516519
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 17:10:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=M8qtCnji;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.182,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f182.google.com with SMTP id k13so3814012oiw.1
        for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 17:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=yZeKwx1tbqpXUHmgyr7zfK81y1SUlDVtXwGbLfz0JfI=;
        b=M8qtCnji/n8PvS4qZqtLOdOrh6OBVTi8+Bt+8BvE5d6vIBFn06kZiruPTw7n42slfQ
         ExAffrYfBU5jSFSQFlmdw1tebvJslioD5i+hDTOa8ojQXJFrAQwy8Ii9szjqcSOJSSLJ
         mKdxMy+sujQsaC70pZh3qLG/YC10jv/PLclRoydJRVH4zy9atpB85msSqsJp3l+JDR8v
         nQmE5wnCfL2l2duP+e3Szr2sJWwIpxy4rPCoOvpc45cvldQo3+nCT603yr2216udhG4P
         tUsk+8T3lk1StHfQsPbDnoVN/ConupfW5bDaRtfhn9iZsUqpKZX76Hn9cgMd80y1dnom
         0UnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=yZeKwx1tbqpXUHmgyr7zfK81y1SUlDVtXwGbLfz0JfI=;
        b=EsHVZcbl8G3RWORZ7nDGYTC9m/WGL/nmMnbDIV/Rvhq2lF9Q1Qt47i+Co4JnhOOs3u
         Wl2iRq/lf1kRD/4/poDnRSLZZwQzstswX999KFkNFhfvcRUna5sYwxsJ2JibaV1aQd8c
         og2HeqZsPyhKTpTDAQzLaiPlvn3OCMSjrSG1y79o83ZIvDJv2YwtLVEwi2hS46WZ5bHp
         6tGABwAe4Wztucv/DiYzqkTLEJr9pYzTMJ+gBTbX+CzYQ46P3z/J6xRCd/8uXpOmiUaM
         0jZaSl+BuxgNWZX5hmSQRTSaqdGgDazcf3ZIzTce/ytSY1yyPzLwBAryOZcusUL1n2LY
         sexQ==
X-Gm-Message-State: AOAM532BYmLrtim6P9yIs+Tl4U6MbdAUTIKe/lbSaLbGbcgaCHu0L9kH
	qaDrsK3x972hgsgAxLEBsrR8DIGr33c1wykpVWJ4ro2O0DkCmw==
X-Google-Smtp-Source: 
 ABdhPJz+LKLNE5tQSHAeqQ9X30KdklQvGSp83PWITQjYQUJoudYE8sNckY7rzllDi9G1QmVIHk/RhP693g6pmgaiDuk=
X-Received: by 2002:a05:6808:1152:b0:2da:c7f:66c2 with SMTP id
 u18-20020a056808115200b002da0c7f66c2mr564330oiu.253.1649895037024; Wed, 13
 Apr 2022 17:10:37 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 14 Apr 2022 09:10:01 +0900
Message-ID: 
 <CAODzB9pruSGoVdq7zS7t+GVm_mzfogSE=84NEKq3nD+5VscRRw@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Apr 2022 16:03:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8086

Hi !

It's this week's CVE report.

This week reported 9 new CVEs and 9 updated CVE.
There is no notable new vulnerabilities.
CVE-2022-28390(Spectre-BHB for arm) has updated. 19 patches were added
to 4.9 kernel.

* New CVEs

CVE-2021-39800: Information leak bug in Android ION code

CVSS v3 score is not provided

ION was remove by commit e722a29 ("staging: ion: remove from the
tree") which was merged in 5.11-rc1.
There is a big different between 4.9 and 4.19/5.10 so 4.19 and 5.10
may not have this issue. 4.4 may affected by this issue.
However, no CIP member enables CONFIG_ION in 4.4 kernel.

Fixed status

stable/4.9: [504e1d6ee65d5b5a053253ae62f46035d774353c,
a8200613c8c9fbaf7b55d4d438376ebaf0c4ce7e,
  c47385c73fced27375559d1a2eb10f165a0869b0]

CVE-2021-39801: privilege escalation bug in Android ION code

CVSS v3 score is not provided

This vulnerability is related to CVE-2021-39800. CVE-2021-39800 and
CVE-2021-39801 use same patch to fix its vulnerability.

stable/4.9: [504e1d6ee65d5b5a053253ae62f46035d774353c,
a8200613c8c9fbaf7b55d4d438376ebaf0c4ce7e,
  c47385c73fced27375559d1a2eb10f165a0869b0]

Fixed status

CVE-2022-1195: kernel: A possible race condition (use-after-free) in
drivers/net/hamradio/6pack ( mkiss.c) after unregister_netdev

CVSS v3 score is not provided

An UFA bug found in hamradio driver that a local attacker will be able
to crash the system.

The mainline has 4 patches.

3e0588c: hamradio: defer ax25 kfree after unregister_netdev
0b91119: hamradio: defer 6pack kfree after unregister_netdev
81b1d54: hamradio: remove needs_free_netdev to avoid UAF
b2f37ae: hamradio: improve the incomplete fix to avoid NPD

b2f37ae fixes 3e0588c and 81b1d54 fixes 0b91119.

This vulnerability has been fixed in 5.16.

Fixed status

mainline: [3e0588c291d6ce225f2b891753ca41d45ba42469,
0b9111922b1f399aba6ed1e1b8f2079c3da1aed8,
  81b1d548d00bcd028303c4f3150fa753b9b8aa71,
b2f37aead1b82a770c48b5d583f35ec22aabb61e]
stable/4.19: [896193a02a2981e60c40d4614fd095ce92135ccd,
b68f41c6320b2b7fbb54a95f07a69f3dc7e56c59]
stable/4.9: [8a1a314965a17c62084a056b4f2cb7a770854c90,
83ba6ec97c74fb1a60f7779a26b6a94b28741d8a]
stable/5.10: [450121075a6a6f1d50f97225d3396315309d61a1,
7dd52af1eb5798f590d9d9e1c56ed8f5744ee0ca]

CVE-2022-1263: Null pointer dereference bug in the kvm module which
can lead to DoS

CVSS v3 score is not provided

Added kvm_dirty_ring_free() in kvm_vcpu_destroy() was commit fb04a1e
("KVM: X86: Implement ring-based dirty memory tracking") that was
merged in 5.11-rc1. So, earlier than 5.11 kernels may not be affected
by this vulnerability.

Fixed status

Fixed in kvm tree as of
2022/04/08(https://www.spinics.net/lists/kvm/msg273052.html).

CVE-2022-1158: KVM: x86/mmu: do compare-and-exchange of gPTE via the
user address

CVSS v3 score is not provided

Reporter said that "/dev/kvm is accessible by unprivileged local
users, so a userspace process
may leverage this bug to corrupt the kernel, resulting in a denial of
service condition or potentially achieving privilege escalation. But, since
the write is a compare-and-exchange operation that only updates the
Access/Dirty bit, we don't think exploiting this single bug will be easy.".

This vulnerability was introduced by commit bd53cb3 (X86/KVM: Handle
PFNs outside of kernel reach when touching GPTEs) was merged in
5.2-rc1 so that 4.x kernels are not affected by this issue.

Fixed status

mainline: [2a8859f373b0a86f0ece8ec8312607eacf12485d]
stable/5.10: [e90518d10c7dd59d5ebbe25b0f0083a7dbffa42f]
stable/5.15: [8771d9673e0bdb7148299f3c074667124bde6dff]
stable/5.16: [9a611c57530050dc359a83177c2f97678b1f961e]
stable/5.17: [5051c04d70c6e035c2c923c04fbe015a4468b08d]

CVE-2022-28796: jbd2_journal_wait_updates in fs/jbd2/transaction.c in
the Linux kernel
  before 5.17.1 has a use-after-free caused by a transaction_t race
  condition

CVSS v3 score is not provided

jbd2_journal_wait_updates in fs/jbd2/transaction.c in the Linux kernel
before 5.17.1 has a use-after-free caused by a transaction_t race
condition.

This vulnerability was introduced by commit 4f98186 ("jbd2: refactor
wait logic for transaction updates into a common function") which was
merged in 5.17-rc3.

Fixed status

mainline: [cc16eecae687912238ee6efbff71ad31e2bc414e]
stable/5.17: [bff94c57bd130e3062afa94414c2294871314096]

CVE-2022-28893: SUNRPC: Ensure we flush any closed sockets before xs_xprt_free()

CVSS v3 score is not provided

The SUNRPC subsystem in the Linux kernel through 5.17.2 can call
xs_xprt_free before ensuring that sockets are in the intended state.
This is an UAF bug that causes in inet_put_port().

This vulnerability was introduced by commit a73881c ("SUNRPC: Fix an
Oops in udp_poll()") which was merged in 5.8-rc1.
The commit a73881c fixes commit 0ffe86f("SUNRPC: Use poll() to fix up
the socket requeue races") which was merged in 5.8-rc1.
Commit 0ffe86f does not exist in less than 5.8 kernels so that these
kernels aren't affected by this issue.

Fixed status

mainline: [f00432063db1a0db484e85193eccc6845435b80e]
stable/5.16: [7a0921a23cae42e9fa5ce964f6907181b6dc80d8]
stable/5.17: [d21287d8a4589dd8513038f887ece980fbc399cf]

CVE-2022-1280: concurrency use-after-free between drm_setmaster_ioctl
and drm_mode_getresources

CVSS v3 score is not provided

The reporter found this bug in 4.19.237. Kernel 5.15 and newer are
already fixed (https://www.openwall.com/lists/oss-security/2022/04/12/4)
but not described which commit(s) fixes this bug.

According to the
PoC(https://www.openwall.com/lists/oss-security/2022/04/12/3), it
needs to open /dev/dri/card0.
However, /dev/dri/card0's permission is following.

crw-rw----+ 1 root video 226, 0 Apr 13 09:15 /dev/dri/card0

So, attacker must have correct privilege to abuse this CVE.

Fixed status

Not fixed yet.

CVE-2022-29156: drivers/infiniband/ulp/rtrs/rtrs-clt.c in the Linux
kernel before 5.16.12
  has a double free related to rtrs_clt_dev_release

CVSS v3 score is not provided

This vulnerability is introduced by commit eab0982 ("RDMA/rtrs-clt:
Refactor the failure cases in alloc_clt") which fixes commit 6a98d71
("RDMA/rtrs: client: main functionality"). Commit eab0982 was merged
in 5.12-rc1-dontuse, commmit 6a98d71 was merged in 5.8-rc1.
This driver was introduced in 5.8 so less than 5.8 kernels aren't
affected this issue.

Fixed status

mainline: [8700af2cc18c919b2a83e74e0479038fd113c15d]
stable/5.16: [fa498059c631e94e91dcb6d78070909d8de56d99]

* Updated CVEs

CVE-2022-0854: swiotlb information leak with DMA_FROM_DEVICE

stable/5.10 was fixed this week.

Fixed status

mainline: [ddbd89deb7d32b1fbb879f48d68fda1a8ac58e8e,
aa6f8dcbab473f3a3c7454b74caa46d36cdc5d13]
stable/5.10: [d4d975e7921079f877f828099bb8260af335508f]
stable/5.15: [7403f4118ab94be837ab9d770507537a8057bc63,
2c1f97af38be151527380796d31d3c9adb054bf9]
stable/5.16: [270475d6d2410ec66e971bf181afe1958dad565e,
62b27d925655999350d0ea775a025919fd88d27f]

CVE-2022-1198: use-after-free in drivers/net/hamradio/6pack.c

stable/5.10 and stable/5.15 were fixed this week.

Fixed status

mainline: [efe4186e6a1b54bf38b9e05450d43b0da1fd7739]
stable/5.10: [f67a1400788f550d201c71aeaf56706afe57f0da]
stable/5.15: [3eb18f8a1d02a9462a0e4903efc674ca3d0406d1]
stable/5.16: [4356343fb70c899901bce33acedf4fede797d21f]

CVE-2022-1204: UAF caused by binding operation when ax25 device is detaching

stable/5.17 was fixed this week.

Fixed status

mainline: [d01ffb9eee4af165d83b08dd73ebdf9fe94a519b,
87563a043cef044fed5db7967a75741cc16ad2b1,
  feef318c855a361a1eccd880f33e88c460eb63b4,
9fd75b66b8f68498454d685dc4ba13192ae069b0,
  5352a761308397a0e6250fdc629bb3f615b94747]
stable/5.17: [d01ffb9eee4af165d83b08dd73ebdf9fe94a519b,
87563a043cef044fed5db7967a75741cc16ad2b1,
  feef318c855a361a1eccd880f33e88c460eb63b4,
534156dd4ed768e30a43de0036f45dca7c54818f,
  01619aa347d35ac8b79751757784ec6f507a3215]

CVE-2022-28388: can: usb_8dev: usb_8dev_start_xmit(): fix double
dev_kfree_skb() in error path

Backporting to 4.x kernels were faild.

4.19: https://lore.kernel.org/stable/1648815686221218@kroah.com/
4.14: https://lore.kernel.org/stable/164881568517591@kroah.com/
4.9: https://lore.kernel.org/stable/1648815685196254@kroah.com/

Fixed status

mainline: [3d3925ff6433f98992685a9679613a2cc97f3ce2]
stable/5.10: [5318cdf4fd834856ce71238b064f35386f9ef528]
stable/5.15: [f2ce5238904f539648aaf56c5ee49e5eaf44d8fc]
stable/5.16: [3e006cf0fb809815d56e59c9de4486fbe253ccdf]
stable/5.17: [29d6c06168faa23ce23db3321981c8fde576c95c]

CVE-2022-28389: can: mcba_usb: mcba_usb_start_xmit(): fix double
dev_kfree_skb in error path

stable/5.x kernels were fixed this week.

Fixed status

mainline: [04c9b00ba83594a29813d6b1fb8fdc93a3915174]
stable/5.10: [0801a51d79389282c1271e623613b2e1886e071e]
stable/5.15: [37f07ad24866c6c1423b37b131c9a42414bcf8a1]
stable/5.16: [f913412848defa326a155c47d026267624472190]
stable/5.17: [42a4b0dfd365c4f77f96fd1f73a64b47ae443a38]

CVE-2022-28390: can: ems_usb: ems_usb_start_xmit(): fix double
dev_kfree_skb() in error path

stable/5.x kernels were fixed this week.

Fixed status

mainline: [c70222752228a62135cee3409dccefd494a24646]
stable/5.10: [b417f9c50586588754b2b0453a1f99520cf7c0e8]
stable/5.15: [459b19f42fd5e031e743dfa119f44aba0b62ff97]
stable/5.16: [41f6be840f138c7d42312d7619a6b44c001d6b6e]
stable/5.17: [3f71f499395545119383f10760b8b19703d2a7dd]

CVE-2022-0168: smb2_ioctl_query_info NULL Pointer Dereference

The mainline and stable/5.10, 5,15, 5.16, and 5.17 kernels ware fixed this week.
Commit d6f5e3 said bug was in smb2_ioctl_query_info() which was merged
in 5.20-rc1, so less than 4.20 kernels aren't affected by this bug.

Fixed status

mainline: [d6f5e358452479fa8a773b5c6ccc9e4ec5a20880]
stable/5.10: [edefc4b2a8e8310eee8e2b1714709ad5b2a93928]
stable/5.15: [39a4bf7d1a23dd172526c2fb0db480c5d5c63bd6]
stable/5.16: [0f0ce73e7dad17084222da19989049ebfb8be541]
stable/5.17: [49bef50e585d738e957060f669e872b4ad15eb87]

CVE-2022-23960: Arm cpus BHI problem

stable/4.9 added more patches this week.
Following patches were merged.
0a59e9c 6835855 a212d16 ee04ed1 99cbe34 2ce6f5d 283bcb8 1f7da61
bd69a09 944ecb1 ac96573 218ddd9 aee10c2 1451b7f 094a410 4dd8aae
df04484 9396d5e 7815cbf

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
  48b1aa98e19d189703d518166ddb2520164b3164,
0a59e9cf1f29f446ab5a3dc91a23af8ca0cf5bea,
  6835855140dc7adecd5af713a17d488f93fd8226,
a212d166a9d7c35e56ba11f15d6706eee3dd499b,
  ee04ed16acb65f7dfde8cb74ae774f4314c5c816,
99cbe345732d49d4626052908754259ac9222bb2,
  2ce6f5deed712c6768e5b19ac4e23d4aaa828ff4,
283bcb8f640ecc3e4a74f5084c15cdd9ce350951,
  1f7da613bf57d10b0ff6807b36bd7eda27482ab6,
bd69a09d7d229303286a685f59b9033c384f72b1,
  944ecb18c729545ea73c53f9ee9b802637c549d0,
ac965734ce0f87c194f0a666889a4f37436b2421,
  218ddd9cb91e7bc0bb69d53fc40f600b0b217a16,
aee10c2dd01383a8a01111d647b6e17b9a3cc791,
  1451b7fe7a3689113e70d2936b92fa4d50e68371,
094a410426b4a5cbb0d68609050a15110124aeda,
  4dd8aae585a51a1d276911fe19096ad90144e9fe,
df0448480b9c2f0a2f5a5055e04afa80bf0a5301,
  9396d5ede3df91cc71c70a7fb11826a10c34e775,
7815cbf19ac47ca0cc22b0d8aa25d6ec6ab2ad81]
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

CVE-2021-4197: cgroup: Use open-time creds and namespace for migration
perm checks

Commit 4665722 ("cgroup: Use open-time credentials for process
migraton perm checks") was added to stable/5.10.

Fixed status

mainline: [1756d7994ad85c2479af6ae5a9750b92324685af,
0d2b5955b36250a9428c832664f2079cbf723bec,
  e57457641613fef0d147ede8bd6a3047df588b95]
stable/5.10: [f28364fe384feffbe7d44b095ef4571285465c47,
824a950c3f1118eb06b1877c49ed1b2eca8e236d,
  4665722d36ad13c6abc6b2ef3fe5150c0a92d870]
stable/5.15: [c6ebc35298848accb5e50c37fdb2490cf4690c92,
50273128d640e8d21a13aec5f4bbce4802f17d7d,
  43fa0b3639c5fd48c96b19d645d0c7ff2327651a]


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


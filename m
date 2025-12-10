Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D969ED3B9AB
	for <webhook@archiver.kernel.org>; Wed, 10 Dec 2025 23:04:55 +0000 (UTC)
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9641.1765407890304061070
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Dec 2025 15:04:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=GwoPf4S+;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.49, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-63fc6d9fde5so310840d50.3
        for <cip-dev@lists.cip-project.org>; Wed, 10 Dec 2025 15:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1765407889; x=1766012689; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sEs42xV4TpX8sRHfz9PvtUsv7InGK8iEIy/el5GlgZc=;
        b=GwoPf4S+3Ny1ojwmKThPm+xxdzITWq7/f4F9GjlJI76Yazaj3MW0gP6O0Umj82vsaL
         jwE2yI1m+CdMf+S69+Z4IC+OgVsyaPQQVfWpgv6NVx8U50Htr4fvuGciQ9GkJwTgeGbE
         pIT79i+KEv4HFzCx2TU3LHWni7iUj35iuN068pOpwbpjm35nwfgKYg7Nwa6BccUczEI5
         kvw8+N/nw8idfaGuxOk9gnXug5yVtYRBs1TRgHCbW3LFK6Z6C0e5HSErCc+O7MBHH/bS
         9aL0blygK9dvxOIMufGfNUJoTPJlbS5fwmUoTujX4S6WeC026ksSuL30a1M0zFsMjBFJ
         Jtzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765407889; x=1766012689;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sEs42xV4TpX8sRHfz9PvtUsv7InGK8iEIy/el5GlgZc=;
        b=ibelIY7uoLOcbN8heSv7wdZ2TeL2XuMAe6s+ycLV5fMPBxC7rNcCvnU68UIIIg0lkx
         Iz9FDY1t0c4vDs1AcUDuKdrVoaKRul4ZQfcfiQ0Ge2yMKCyTjVxOBudTrDgdpVN5st4b
         9ZJ7N+f75JwxLy2H5nuVpYy4Ect90vAQaVZuAPgYOCmLO2bQ/IA8X9sInIo3VTrAzoJP
         Atnqwro3Bwie5pUDQEaDUJVLJ9bhDwkpUk1LiWXAhejQmxFmab5bqmePvQtOnC/BYRzj
         wLFDJC5VElCDn9M4GCwemUfCrLENo/Ac5rPnwVXWNjYUESk+Hv/fiCO3vK2sv5H4qd6P
         HVyg==
X-Gm-Message-State: AOJu0YzjKFH4RTnCAMiTzI0JgyeB6KXzO9frx2V7H1gRq1TnuWt49icB
	aBjuTWddrI7BfkWFP5YoAX0r/tAVOxUdBwlXJrarJJ/LL5MAViyJeCxER3lKUfzsRF4bbFX10Kx
	bN6m2/g7yA8xjSErzLoaU8ubHErNCwZag8K7dMalUmLm9WS6IeV3yrcA=
X-Gm-Gg: AY/fxX6iiFBYvg3nR1fbehSe2Gm1j0Us69fH65k2U+WjOgkxNzrfeIt/6RfI/vsurwb
	xy5zAtrNvrGF2LrFAbM4EXHdQVMS53Y31PdtO15qtfjFqe7KgtCCIIpJUXkM/2Su4scJJKYtcH3
	KAEMPA6dWaE76ZxQXVmSN095cBevsosrN/Mn5FJXKJgu91Ym8oqwM01KqSBmc/4rE2dens6YAaY
	YbiklVbVN83TMnb2w+hZPsdvX9fcMOj3c6eDG5CRA0Xkxnqc319+G/p5nh1hTNDGUmWx3TaYmvr
	XPSfFds=
X-Google-Smtp-Source: AGHT+IExCkIop395Bf8Vy5OB/LgkhKyElzllsIf0YBFMU/MnAUwJdpTGYET3OY4tmWoCLBuk1VtZMCxoq5jA0hiCBLw=
X-Received: by 2002:a05:690e:148f:b0:63f:2b0c:2d61 with SMTP id
 956f58d0204a3-6446eb00d96mr3127170d50.60.1765407886482; Wed, 10 Dec 2025
 15:04:46 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 11 Dec 2025 08:04:10 +0900
X-Gm-Features: AQt7F2p61S0hiuvoKCF6CEHnpkF0Cm3zhTzdi7Z5si9pEFcxKV1bM-1pKKDr8o8
Message-ID: <CAODzB9oyD=t_Hg_h6ROc8uqEFS4MO4+KOvwF5R1toakEqn-dAw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Dec 2025 23:04:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20964

Hi!

It's this week's CVE report.

This week reported 313 new CVEs and 18 updated CVEs.

* New CVEs
CVE-2025-40214: af_unix: Initialise scc_index in unix_add_edge().

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40214

Introduced by commit ad08192 ("af_unix: Avoid Tarjan's algorithm if
unnecessary.") in v6.10-rc1.
Fixed in v6.18-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [60e6489f8e3b086bd1130ad4450a2c112e863791]
stable/6.1: [20003fbb9174121b27bd1da6ebe61542ac4c327d]
stable/6.12: [db81ad20fd8aef7cc7d536c52ee5ea4c1f979128]
stable/6.6: [4cd8d755c7d4f515dd9abf483316aca2f1b7b0f3]

CVE-2025-40215: xfrm: delete x->tunnel as we delete x

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40215

Introduced by commit 9d4139c ("netns xfrm: per-netns xfrm_state_all
list") in v2.6.29-rc1.
Fixed in v6.16.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b441cf3f8c4b8576639d20c8eb4aa32917602ecd]

CVE-2025-40216: io_uring/rsrc: don't rely on user vaddr alignment

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40216

Introduced by commit a8edbb4 ("io_uring/rsrc: enable multi-hugepage
buffer coalescing") in v6.12-rc1.
Fixed in v6.16-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a3c6d61577dbb23c09df3e21f6f9eda1ecd634b]
stable/6.12: [50998b0ae7d9d552e96d8b7239981cf05f65eff5]

CVE-2025-40217: pidfs: validate extensible ioctls

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40217

Introduced commit is not determined.Fixed in v6.18-rc1.
Affected code was added by 091ee63 ("pidfs: improve ioctl handling")
in 6.14-rc2.

Fixed status
mainline: [3c17001b21b9f168c957ced9384abe969019b609]

CVE-2025-40218: mm/damon/vaddr: do not repeat pte_offset_map_lock()
until success

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40218

Introduced by commit 7780d04 ("mm/pagewalkers: ACTION_AGAIN if
pte_offset_map_lock() fails") in v6.5-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b93af2cc8e036754c0d9970d9ddc47f43cc94b9f]
stable/6.12: [ac42320ec873bfe726141069cfdd90ee5bc4e885]
stable/6.6: [677ebfe5d00f94adec0c0204f6e6e2a82d3f77bf]

CVE-2025-40219: PCI/IOV: Add PCI rescan-remove locking when
enabling/disabling SR-IOV

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40219

Introduced by commit 18f9e9d ("PCI/IOV: Factor out sriov_add_vfs()")
in v5.0-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [05703271c3cdcc0f2a8cf6ebdc45892b8ca83520]
stable/5.10: [1e8a80290f964bdbad225221c8a1594c7e01c8fd]
stable/5.15: [a645ca21de09e3137cbb224fa6c23cca873a1d01]
stable/6.1: [a24219172456f035d886857e265ca24c85b167c8]
stable/6.12: [53154cd40ccf285f1d1c24367824082061d155bd]
stable/6.6: [36039348bca77828bf06eae41b8f76e38cd15847]

CVE-2025-40220: fuse: fix livelock in synchronous file put from fuseblk workers

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40220

Introduced by commit 5a18ec1 ("fuse: fix hang of single threaded
fuseblk filesystem") in v2.6.38-rc7.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26e5c67deb2e1f42a951f022fdf5b9f7eb747b01]
stable/5.10: [548e1f2bac1d4df91a6138f26bb4ab00323fd948]
stable/5.15: [cfd1aa3e2b71f3327cb373c45a897c9028c62b35]
stable/6.1: [83b375c6efef69b1066ad2d79601221e7892745a]
stable/6.12: [b26923512dbe57ae4917bafd31396d22a9d1691a]
stable/6.6: [bfd17b6138df0122a95989457d8e18ce0b86165e]

CVE-2025-40221: media: pci: mg4b: fix uninitialized iio scan data

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40221

Introduced by commit 0ab1367 ("media: pci: mgb4: Added Digiteq
Automotive MGB4 driver") in v6.7-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0d3f6969bb4d72476cfe7ea9263831f1c283704]
stable/6.12: [b7f82da7f86479cb6479a76ebe213ece7c77398f]

CVE-2025-40222: tty: serial: sh-sci: fix RSCI FIFO overrun handling

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40222

Introduced by commit 0666e3f ("serial: sh-sci: Add support for RZ/T2H
SCI") in v6.17-rc1.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef8fef45c74b5a0059488fda2df65fa133f7d7d0]

CVE-2025-40223: most: usb: Fix use-after-free in hdm_disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40223

Introduced by commit 97a6f77 ("drivers: most: add USB adapter driver")
in v5.9-rc1.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b1270902609ef0d935ed2faa2ea6d122bd148f5]
stable/5.10: [5b5c478f09b1b35e7fe6fc9a1786c9bf6030e831]
stable/5.15: [578eb18cd111addec94c43f61cd4b4429e454809]
stable/6.1: [33daf469f5294b9d07c4fc98216cace9f4f34cc6]
stable/6.12: [f93a84ffb884d761a9d4e869ba29c238711e81f1]
stable/6.6: [72427dc6f87523995f4e6ae35a948bb2992cabce]

CVE-2025-40224: hwmon: (cgbc-hwmon) Add missing NULL check after devm_kzalloc()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40224

Introduced by commit 08ebc9d ("hwmon: Add Congatec Board Controller
monitoring driver") in v6.15-rc1.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a09a5aa8bf258ddc99a22c30f17fe304b96b5350]

CVE-2025-40225: drm/panthor: Fix kernel panic on partial unmap of a
GPU VA region

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40225

Introduced by commit 647810e ("drm/panthor: Add the MMU/VM logical
block") in v6.10-rc1.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4eabd0d8791eaf9a7b114ccbf56eb488aefe7b1f]
stable/6.12: [efe6dced3512066ebee2cf7c4c38d1c99625814e]

CVE-2025-40226: firmware: arm_scmi: Account for failed debug initialization

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40226

Introduced by commit 0b3d48c ("firmware: arm_scmi: Track basic SCMI
communication debug metrics") in v6.12-rc1.
Fixed in v6.18-rc3.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [2290ab43b9d8eafb8046387f10a8dfa2b030ba46]
stable/6.12: [e088efcd97cb7c7297d166bb52c3b87a29f6a0b1]
stable/6.6: [d719ce9f286c439795cd2beee4c91f12b84bc5a0]

CVE-2025-40227: mm/damon/sysfs: dealloc commit test ctx always

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40227

Introduced by commit 4c9ea53 ("mm/damon/sysfs: validate user inputs
from damon_sysfs_commit_input()") in v6.15-rc1.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [139e7a572af0b45f558b5e502121a768dc328ba8]

CVE-2025-40228: mm/damon/sysfs: catch commit test ctx alloc failure

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40228

Introduced by commit 4c9ea53 ("mm/damon/sysfs: validate user inputs
from damon_sysfs_commit_input()") in v6.15-rc1.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0c5118ebb0eb7e4fd6f0d2ace3315ca141b317f]

CVE-2025-40229: mm/damon/core: fix potential memory leak by cleaning
ops_filter in damon_destroy_scheme

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40229

Introduced by commit ab82e57 ("mm/damon/core: introduce
damos->ops_filters") in v6.15-rc1.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7071537159be845a5c4ed5fb7d3db25aa4bd04a3]

CVE-2025-40230: mm: prevent poison consumption when splitting THP

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40230

Introduced by commit b1f2020 ("mm: remap unused subpages to shared
zeropage when splitting isolated thp") in v6.12-rc1.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [841a8bfcbad94bb1ba60f59ce34f75259074ae0d]
stable/6.12: [6fc0a7c99e973a50018c8b4be34914a1b5c7b383]

CVE-2025-40231: vsock: fix lock inversion in vsock_assign_transport()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40231

Introduced by commit 687aa0c ("vsock: Fix transport_* TOCTOU") in v6.16-rc6.
Fixed in v6.18-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [f7c877e7535260cc7a21484c994e8ce7e8cb6780]
stable/5.10: [ce4f856c64f0bc30e29302a0ce41f4295ca391c5]
stable/5.15: [09bba278ccde25a14b6e5088a9e65a8717d0cccf]
stable/6.1: [b44182c116778feaa05da52a426aeb9da1878dcf]
stable/6.12: [251caee792a21eb0b781aab91362b422c945e162]
stable/6.6: [42ed0784d11adebf748711e503af0eb9f1e6d81d]

CVE-2025-40232: rv: Fully convert enabled_monitors to use list_head as iterator

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40232

Introduced by commit de090d1 ("rv: Fix wrong type cast in
enabled_monitors_next()") in v6.17-rc7.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [103541e6a5854b08a25e4caa61e990af1009a52e]

CVE-2025-40233: ocfs2: clear extent cache after moving/defragmenting extents

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40233

Introduced by commit 53069d4 ("Ocfs2/move_extents: move/defrag extents
within a certain range.") in v3.0-rc1.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [ddfd54c55edb99782c59d2afc568e6178059cc29]
cip/4.4-st: [0bd6cb6c7a22f2f53e2f3d563050ad5e6a0aa79d]
mainline: [78a63493f8e352296dbc7cb7b3f4973105e8679e]
stable/5.10: [a7ee72286efba1d407c6f15a0528e43593fb7007]
stable/5.15: [93b1ab422f1966b71561158e1aedce4ec100f357]
stable/6.1: [e92af7737a94a729225d2a5d180eaaa77fe0bbc1]
stable/6.12: [bb69928ed578f881e68d26aaf1a8f6e7faab3b44]
stable/6.6: [aa6a21409dd6221bb268b56bb410e031c632ff9a]

CVE-2025-40234: platform/x86: alienware-wmi-wmax: Fix NULL pointer
dereference in sleep handlers

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40234

Introduced by commit 07ac275 ("platform/x86: alienware-wmi-wmax: Add
support for manual fan control") in v6.16-rc1.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a49c4d48c3b60926e6a8cec217bf95aa65388ecc]

CVE-2025-40235: btrfs: directly free partially initialized fs_info in
btrfs_check_leaked_roots()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40235

Introduced by commit 3bb17a2 ("btrfs: add get_tree callback for new
mount API") in v6.8-rc1.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [17679ac6df6c4830ba711835aa8cf961be36cfa1]
stable/6.12: [b1c2b4e6ffd307720ab6ce42f6749b0c02ba0a73]

CVE-2025-40236: virtio-net: zero unused hash fields

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40236

Introduced by commit a2fb4bc ("net: implement virtio helpers to handle
UDP GSO tunneling") in v6.17-rc1.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b2284768c6b32aa224ca7d0ef0741beb434f03aa]

CVE-2025-40237: fs/notify: call exportfs_encode_fid with s_umount

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40237

Introduced by commit c45beeb ("ovl: support encoding fid from inode
with no alias") in v6.13-rc7.
Fixed in v6.18-rc3.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [a7c4bb43bfdc2b9f06ee9d036028ed13a83df42a]
stable/6.12: [3f307a9f7a7a2822e38ac451b73e2244e7279496]
stable/6.6: [bc1c6b803e14ea2b8f7e33b7164013f666ceb656]

CVE-2025-40238: net/mlx5: Fix IPsec cleanup over MPV device

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40238

Introduced by commit 82f9378 ("net/mlx5: Handle IPsec steering upon
master unbind/bind") in v6.7-rc1.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [664f76be38a18c61151d0ef248c7e2f3afb4f3c7]
stable/6.12: [7e212cebc863c2c7a82f480446cd731721451691]

CVE-2025-40239: net: phy: micrel: always set shared->phydev for LAN8814

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40239

Introduced by commit b3f1a08 ("net: phy: micrel: Add support for
PTP_PF_EXTTS for lan8814") in v6.10-rc1.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [399d10934740ae8cdaa4e3245f7c5f6c332da844]
stable/6.12: [da1ef8e9eb5d4a12bec32d11636e521e7d529b9e]

CVE-2025-40240: sctp: avoid NULL dereference when chunk data buffer is missing

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40240

Introduced by commit 90017ac ("sctp: Add GSO support") in v4.8-rc1.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [52e917456d4e575578ccdbb9aa54eb38361ccd72]
mainline: [441f0647f7673e0e64d4910ef61a5fb8f16bfb82]
stable/5.10: [08165c296597075763130919f2aae59b5822f016]
stable/5.15: [03e80a4b04ef1fb2c61dd63216ab8d3a5dcb196f]
stable/6.1: [4f6da435fb5d8a21cbf8cae5ca5a2ba0e1012b71]
stable/6.12: [7a832b0f99be19df608cb75c023f8027b1789bd1]
stable/6.6: [cb9055ba30306ede4ad920002233d0659982f1cb]

CVE-2025-40241: erofs: fix crafted invalid cases for encoded extents

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40241

Introduced by commit 1d191b4 ("erofs: implement encoded extent
metadata") in v6.15-rc1.
Fixed in v6.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a429b76114aaca3ef1aff4cd469dcf025431bd11]

CVE-2025-40242: gfs2: Fix unlikely race in gdlm_put_lock

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40242

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [28c4d9bc0708956c1a736a9e49fee71b65deee81]
stable/6.12: [279bde3bbb0ac0bad5c729dfa85983d75a5d7641]

CVE-2025-40243: hfs: fix KMSAN uninit-value issue in hfs_find_set_zero_bits()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40243

Introduced commit is not determined.Fixed in v6.18-rc1.
The kmalloc was used since 4.5-rc1. Linux 4.4 uses __get_free_pages to
allocate bitmap.

Fixed status
cip/4.19-st: [08dafc1b64741cb1bb8bb893c0bf42812e83a76c]
mainline: [2048ec5b98dbdfe0b929d2e42dc7a54c389c53dd]
stable/5.10: [bf1683078fbdd09a7f7f9b74121ebaa03432bd00]
stable/5.15: [2a112cdd66f5a132da5235ca31a320528c86bf33]
stable/6.1: [e148ed5cda8fd96d4620c4622fb02f552a2d166a]
stable/6.12: [3b447fd401824e1ccf0b769188edefe866a1e676]
stable/6.6: [cfafefcb0e1fc60135f7040f4aed0a4aef4f76ca]

CVE-2025-40244: hfsplus: fix KMSAN uninit-value issue in
__hfsplus_ext_cache_extent()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40244

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
cip/4.19-st: [057a64a335eb98c006d9a23b34670054417cf8bd]
cip/4.4-st: [e6ef7c1aed3b3749c16edc2b63b989e52e818aef]
mainline: [4840ceadef4290c56cc422f0fc697655f3cbf070]
stable/5.10: [b8a72692aa42b7dcd179a96b90bc2763ac74576a]
stable/5.15: [c135b8dca65526aa5b8814e9954e0ae317d9c598]
stable/6.1: [d7e313039a8f3a6ee072dc5ff4643234d2d735cf]
stable/6.12: [99202d94909d323a30d154ab0261c0a07166daec]
stable/6.6: [a5bfb13b4f406aef1a450f99d22d3e48df01528c]

CVE-2025-40245: nios2: ensure that memblock.current_limit is set when
setting pfn limits

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40245

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [a20b83cf45be2057f3d073506779e52c7fa17f94]
stable/5.15: [25f09699edd360b534ccae16bc276c3b52c471f3]
stable/6.1: [5c3e38a367822f036227dd52bac82dc4a05157e2]
stable/6.12: [90f5f715550e07cd6a51f80fc3f062d832c8c997]
stable/6.6: [b1ec9faef7e36269ca3ec890972a78effbaeb975]

CVE-2025-40246: xfs: fix out of bounds memory read error in symlink repair

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40246

Introduced by commit 2651923 ("xfs: online repair of symbolic links")
in v6.10-rc1.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [678e1cc2f482e0985a0613ab4a5bf89c497e5acc]
stable/6.12: [7c2d68e091584149fe89bcbaf9b99b3162d46ee7]

CVE-2025-40247: drm/msm: Fix pgtable prealloc error path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40247

Introduced commit is not determined.Fixed in v6.18-rc4.
The pgtable preallocation feature was added by e601ea3 ("drm/msm:
Support pgtable preallocation") in 6.17-rc1.

Fixed status
mainline: [830d68f2cb8ab6fb798bb9555016709a9e012af0]

CVE-2025-40248: vsock: Ignore signal/timeout on connect() if already established

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40248

Introduced by commit d021c34 ("VSOCK: Introduce VM Sockets") in v3.9-rc1.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [002541ef650b742a198e4be363881439bb9d86b4]
stable/5.10: [da664101fb4a0de5cb70d2bae6a650df954df2af]
stable/5.15: [67432915145848658149683101104e32f9fd6559]
stable/6.1: [eeca93f06df89be5a36305b7b9dae1ed65550dfc]
stable/6.12: [f1c170cae285e4b8f61be043bb17addc3d0a14b5]
stable/6.6: [5998da5a8208ae9ad7838ba322bccb2bdcd95e81]

CVE-2025-40249: gpio: cdev: make sure the cdev fd is still active
before emitting events

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40249

Introduced by commit 40b7c49 ("gpio: cdev: put emitting the line state
events on a workqueue") in v6.13-rc1.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d4cd0902c156b2ca60fdda8cd8b5bcb4b0e9ed64]

CVE-2025-40250: net/mlx5: Clean up only new IRQ glue on request_irq() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40250

Introduced by commit 3354822 ("net/mlx5: Use dynamic msix vectors
allocation") in v6.4-rc1.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d47515af6cccd7484d8b0870376858c9848a18ec]
stable/6.12: [6ebd02cf2dde11b86f89ea4c9f55179eab30d4ee]
stable/6.6: [69e043bce09c9a77e5f55b9ac7505874a2a1a9f0]

CVE-2025-40251: devlink: rate: Unset parent pointer in devl_rate_nodes_destroy

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40251

Introduced by commit d755598 ("devlink: Allow setting parent node of
rate objects") in v5.14-rc1.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f94c1a114ac209977bdf5ca841b98424295ab1f0]
stable/6.12: [c70df6c17d389cc743f0eb30160e2d6bc6910db8]
stable/6.6: [715d9cda646a8a38ea8b2bb5afb679a7464055e2]

CVE-2025-40252: net: qlogic/qede: fix potential out-of-bounds read in
qede_tpa_cont() and qede_tpa_end()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40252

Introduced by commit 55482ed ("qede: Add slowpath/fastpath support and
enable hardware GRO") in v4.6-rc1.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [896f1a2493b59beb2b5ccdf990503dbb16cb2256]
stable/5.15: [ecbb12caf399d7cf364b7553ed5aebeaa2f255bc]
stable/6.1: [a778912b4a53587ea07d85526d152f85d109cbfe]
stable/6.12: [917a9d02182ac8b4f25eb47dc02f3ec679608c24]
stable/6.6: [f0923011c1261b33a2ac1de349256d39cb750dd0]

CVE-2025-40253: s390/ctcm: Fix double-kfree

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40253

Introduced by commit 0c0b205 ("s390/ctcm: fix potential memory leak")
in v5.18-rc7.
Fixed in v6.18-rc7.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [da02a1824884d6c84c5e5b5ac373b0c9e3288ec2]
stable/5.10: [6bf8ccaabce8cebb6cb1f255c93d0acdfe95c17a]
stable/5.15: [7616e2eee679746d526c7f5befd4eedb995935b5]
stable/6.1: [43096dab8cc60fc39133205fd149a54d3acebea8]
stable/6.12: [b9dbfb1b5699f9f1e4991f96741bdf9047147589]
stable/6.6: [3b177b2ded563df16f6d5920671ffcfe5915d472]

CVE-2025-40254: net: openvswitch: remove never-working support for
setting nsh fields

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40254

Introduced by commit b2d0f5d ("openvswitch: enable NSH support") in v4.15-rc1.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dfe28c4167a9259fc0c372d9f9473e1ac95cff67]
stable/5.10: [3d2e7d3b28469081ccf08301df07cc411a1cc5e9]
stable/5.15: [f95bef5ba0b88d971b02c776f24bd17544930a3a]
stable/6.1: [87d2429381ddcf8cbd30c8c36793a4f7916d5f99]
stable/6.12: [9c61d8fe1350b7322f4953318165d6719c3b1475]
stable/6.6: [0b903f33c31c82b1c3591279fd8a23893802b987]

CVE-2025-40255: net: core: prevent NULL deref in generic_hwtstamp_ioctl_lower()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40255

Introduced by commit 6e9e2ee ("net: ethtool: Add support for tsconfig
command to get/set hwtstamp config") in v6.14-rc1.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f796a8dec9beafcc0f6f0d3478ed685a15c5e062]

CVE-2025-40256: xfrm: also call xfrm_state_delete_tunnel at destroy
time for states that were never added

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40256

Introduced by commit b441cf3 ("xfrm: delete x->tunnel as we delete x") in v6.16.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [10deb69864840ccf96b00ac2ab3a2055c0c04721]

CVE-2025-40257: mptcp: fix a race in mptcp_pm_del_add_timer()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40257

Introduced by commit 00cfd77 ("mptcp: retransmit ADD_ADDR when
timeout") in v5.10-rc1.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [426358d9be7ce3518966422f87b96f1bad27295f]
stable/5.10: [9be29f8e7ce4e147e56caac2c3a0ce3573cf9c17]
stable/5.15: [e2d1ad207174a7cd7903dd27a00db4b2dfa6c64b]
stable/6.1: [385ddc0f008f24d1e7d03be998b3a98a37bd29ff]
stable/6.12: [6d3275d4ca62e2c02e1b7e8cd32db59df91c14b7]
stable/6.6: [c602cc344b4b8d41515fec3ffa98457ac963ee12]

CVE-2025-40258: mptcp: fix race condition in mptcp_schedule_work()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40258

Introduced by commit 3b1d621 ("mptcp: implement and use MPTCP-level
retransmission") in v5.7-rc1.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [035bca3f017ee9dea3a5a756e77a6f7138cc6eea]
stable/5.10: [f865e6595acf33083168db76921e66ace8bf0e5b]
stable/5.15: [99908e2d601236842d705d5fd04fb349577316f5]
stable/6.1: [db4f7968a75250ca6c4ed70d0a78beabb2dcee18]
stable/6.12: [ac28dfddedf6f209190950fc71bcff65ec4ab47b]
stable/6.6: [8f9ba1a99a89feef9b5867c15a0141a97e893309]

CVE-2025-40259: scsi: sg: Do not sleep in atomic context

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40259

Introduced by commit 97d27b0 ("scsi: sg: close race condition in
sg_remove_sfp_usercontext()") in v4.12-rc1.
Fixed in v6.18-rc7.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [90449f2d1e1f020835cba5417234636937dd657e]
stable/5.10: [db6ac8703ab2b473e1ec845f57f6dd961a388d9f]
stable/5.15: [109afbd88ecc46b6cc7551367222387e97999765]
stable/6.1: [3dfd520c3b4ffe69e0630c580717d40447ab842f]
stable/6.12: [b2c0340cfa25c5c1f65e8590cc1a2dc97d14ef0f]
stable/6.6: [b343cee5df7e750d9033fba33e96fc4399fa88a5]

CVE-2025-40260: sched_ext: Fix scx_enable() crash on helper kthread
creation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40260

Introduced by commit bff3b5a ("sched_ext: Move disable machinery into
scx_sched") in v6.16-rc1.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b6216baae751369195fa3c83d434d23bcda406a]

CVE-2025-40261: nvme: nvme-fc: Ensure ->ioerr_work is cancelled in
nvme_fc_delete_ctrl()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40261

Introduced by commit 19fce04 ("nvme-fc: avoid calling
_nvme_fc_abort_outstanding_ios from interrupt context") in v5.11-rc3.
Fixed in v6.18-rc7.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [0a2c5495b6d1ecb0fa18ef6631450f391a888256]
stable/5.10: [3d78e8e01251da032a5f7cbc9728e4ab1a5a5464]
stable/5.15: [60ba31330faf5677e2eebef7eac62ea9e42a200d]
stable/6.1: [3d81beae4753db3b3dc5b70dc300d4036e0d9cb8]
stable/6.12: [48ae433c6cc6985f647b1b37d8bb002972cf9bdb]
stable/6.6: [33f64600a12055219bda38b55320c62cdeda9167]

CVE-2025-40262: Input: imx_sc_key - fix memory corruption on unload

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40262

Introduced by commit 768062f ("Input: imx_sc_key - use
devm_add_action_or_reset() to handle all cleanups") in v5.8-rc1.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d83f1512758f4ef6fc5e83219fe7eeeb6b428ea4]
stable/5.10: [3e96803b169dc948847f0fc2bae729a80914eb7b]
stable/5.15: [4ce5218b101205b3425099fe3df88a61b58f9cc2]
stable/6.1: [a155292c3ce722036014da5477ee0e4c87b5e6b3]
stable/6.12: [56881294915a6e866d31a46f9bcb5e19167cfbaa]
stable/6.6: [ca9a08de9b294422376f47ade323d69590dbc6f2]

CVE-2025-40263: Input: cros_ec_keyb - fix an invalid memory access

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40263

Introduced commit is not determined.Fixed in v6.18-rc7.


Fixed status
mainline: [e08969c4d65ac31297fcb4d31d4808c789152f68]
stable/5.10: [8b5ae1521660c16fa830ff17d16e650b4905b71a]
stable/5.15: [729d21c82c1b0504ffccb17cc261bf32e024fd0f]
stable/6.1: [d74864291cb8bd784d44d1d02e87109cf88666bb]
stable/6.12: [6d81068685154535af06163eb585d6d9663ec7ec]
stable/6.6: [9cf59f4724a9ee06ebb06c76b8678ac322e850b7]

CVE-2025-40264: be2net: pass wrb_params in case of OS2BMC

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40264

Introduced by commit 760c295 ("be2net: Support for OS2BMC.") in v4.2-rc1.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d277a7a58578dd62fd546ddaef459ec24ccae36]
stable/5.10: [f499dfa5c98e92e72dd454eb95a1000a448f3405]
stable/5.15: [630360c6724e27f1aa494ba3fffe1e38c4205284]
stable/6.1: [012ee5882b1830db469194466a210768ed207388]
stable/6.12: [1ecd86ec6efddb59a10c927e8e679f183bb9113e]
stable/6.6: [ce0a3699244aca3acb659f143c9cb1327b210f89]

CVE-2025-40265: vfat: fix missing sb_min_blocksize() return value checks

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40265

Introduced by commit a64e5a5 ("bdev: add back PAGE_SIZE block size
validation for sb_set_blocksize()") in v6.15-rc1.
Fixed in v6.18-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63b5aa01da0f38cdbd97d021477258e511631497]

CVE-2025-40266: KVM: arm64: Check the untrusted offset in FF-A memory share

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40266

Introduced commit is not determined.Fixed in v6.18-rc6.
Affected function was added by 4360900 ("KVM: arm64: Handle
FFA_MEM_SHARE calls from the host") in 6.5-rc1.

Fixed status
mainline: [103e17aac09cdd358133f9e00998b75d6c1f1518]
stable/6.12: [bc1909ef38788f2ee3d8011d70bf029948433051]
stable/6.6: [fc3139d9f4c1fe1c7d5f25f99676bd8e9c6a1041]

CVE-2025-40267: io_uring/rw: ensure allocated iovec gets cleared for
early failure

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40267

Introduced by commit 9ac273a ("io_uring/rw: use io_rw_recycle() from
cleanup path") in v6.14-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3c9c213c0b86ac5dd8fe2c53c24db20f1f510bc]

CVE-2025-40268: cifs: client: fix memory leak in smb3_fs_context_parse_param

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40268

Introduced commit is not determined.Fixed in v6.18-rc6.
Commit af1a3d2 ("cifs: In the new mount api we get the full devname as
source=") in 5.11 added another memory allocation to ctx->source.

Fixed status
mainline: [e8c73eb7db0a498cd4b22d2819e6ab1a6f506bd6]
stable/6.12: [48c17341577e25a22feb13d694374b61d974edbc]
stable/6.6: [868fc62811d3fabcf5685e14f36377a855d5412d]

CVE-2025-40269: ALSA: usb-audio: Fix potential overflow of PCM transfer buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40269

Introduced commit is not determined.Fixed in v6.18-rc6.


Fixed status
mainline: [05a1fc5efdd8560f34a3af39c9cf1e1526cc3ddf]
stable/5.10: [6a5da3fa80affc948923f20a4e086177f505e86e]
stable/5.15: [217d47255a2ec8b246f2725f5db9ac3f1d4109d7]
stable/6.1: [ef592bf2232a2daa9fffa8881881fc9957ea56e9]
stable/6.12: [98e9d5e33bda8db875cc1a4fe99c192658e45ab6]
stable/6.6: [ece3b981bb6620e47fac826a2156c090b1a936a0]

CVE-2025-40270: mm, swap: fix potential UAF issue for VMA readahead

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40270

Introduced by commit 78524b0 ("mm, swap: avoid redundant swap device
pinning") in v6.15-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c2a936edd71e133f2806e68324ec81a4eb07588]

CVE-2025-40271: fs/proc: fix uaf in proc_readdir_de()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40271

Introduced commit is not determined.Fixed in v6.18-rc6.


Fixed status
mainline: [895b4c0c79b092d732544011c3cecaf7322c36a1]
stable/5.10: [c81d0385500446efe48c305bbb83d47f2ae23a50]
stable/5.15: [4cba73c4c89219beef7685a47374bf88b1022369]
stable/6.1: [6f2482745e510ae1dacc9b090194b9c5f918d774]
stable/6.12: [623bb26127fb581a741e880e1e1a47d79aecb6f8]
stable/6.6: [67272c11f379d9aa5e0f6b16286b9d89b3f76046]

CVE-2025-40272: mm/secretmem: fix use-after-free race in fault handler

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40272

Introduced by commit 1507f51 ("mm: introduce memfd_secret system call
to create "secret" memory areas") in v5.14-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f86d0534fddfbd08687fa0f01479d4226bc3c3d]
stable/5.15: [bb1c19636aedae39360e6fdbcaef4f2bcff25785]
stable/6.1: [1e4643d6628edf9c0047b1f8f5bc574665025acb]
stable/6.12: [52f2d5cf33de9a8f5e72bbb0ed38282ae0bc4649]
stable/6.6: [42d486d35a4143cc37fc72ee66edc99d942dd367]

CVE-2025-40273: NFSD: free copynotify stateid in nfs4_free_ol_stateid()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40273

Introduced by commit 624322f ("NFSD add COPY_NOTIFY operation") in v5.6-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4aa17144d5abc3c756883e3a010246f0dba8b468]
stable/5.10: [935a2dc8928670bb2c37e21025331e61ec48ccf4]
stable/5.15: [b114996a095da39e38410a0328d4a8aca8c36088]
stable/6.1: [839f56f626723f36904764858467e7a3881b975d]
stable/6.12: [d7be15a634aa3874827d0d3ea47452ee878b8df7]
stable/6.6: [29fbb3ad4018ca2b0988fbac76f4c694cc6d7e66]

CVE-2025-40274: KVM: guest_memfd: Remove bindings on memslot deletion
when gmem is dying

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40274

Introduced by commit a7800aa ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl()
for guest-specific backing memory") in v6.8-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae431059e75d36170a5ae6b44cc4d06d43613215]
stable/6.12: [a8ac2bd0f98e1a230f1eb3260fa552bf2ef1753b]

CVE-2025-40275: ALSA: usb-audio: Fix NULL pointer dereference in
snd_usb_mixer_controls_badd

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40275

Introduced by commit 17156f2 ("ALSA: usb: add UAC3 BADD profiles
support") in v4.18-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [632108ec072ad64c8c83db6e16a7efee29ebfb74]
stable/5.10: [c5c08965ab96b16361e69a1e2a0e89dbcb99b5a6]
stable/5.15: [9f282104627be5fbded3102ff9004f753c55a063]
stable/6.1: [2762d3ea9c929ca4094541ca517c317ffa94625b]
stable/6.12: [cbdbfc756f2990942138ed0138da9303b4dbf9ff]
stable/6.6: [57f607c112966c21240c424b33e2cb71e121dcf0]

CVE-2025-40276: drm/panthor: Flush shmem writes before mapping buffers
CPU-uncached

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40276

Introduced by commit 8a1cc07 ("drm/panthor: Add GEM logical block") in
v6.10-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [576c930e5e7dcb937648490611a83f1bf0171048]

CVE-2025-40277: drm/vmwgfx: Validate command header size against
SVGA_CMD_MAX_DATASIZE

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40277

Introduced by commit 8ce75f8 ("drm/vmwgfx: Update device includes for
DX device functionality") in v4.3-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [32b415a9dc2c212e809b7ebc2b14bc3fbda2b9af]
stable/5.10: [54d458b244893e47bda52ec3943fdfbc8d7d068b]
stable/5.15: [709e5c088f9c99a5cf2c1d1c6ce58f2cca7ab173]
stable/6.1: [a3abb54c27b2c393c44362399777ad2f6e1ff17e]
stable/6.12: [5aea2cde03d4247cdcf53f9ab7d0747c9dca1cfc]
stable/6.6: [b5df9e06eed3df6a4f5c6f8453013b0cabb927b4]

CVE-2025-40278: net: sched: act_ife: initialize struct tc_ife to fix
KMSAN kernel-infoleak

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40278

Introduced by commit ef6980b ("introduce IFE action") in v4.6-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce50039be49eea9b4cd8873ca6eccded1b4a130a]
stable/5.10: [5e3644ef147bf7140259dfa4cace680c9b26fe8b]
stable/5.15: [37f0680887c5aeba9a433fe04b35169010568bb1]
stable/6.1: [2191662058443e0bcc28d11694293d8339af6dde]
stable/6.12: [d1dbbbe839647486c9b893e5011fe84a052962df]
stable/6.6: [a676a296af65d33725bdf7396803180957dbd92e]

CVE-2025-40279: net: sched: act_connmark: initialize struct tc_ife to
fix kernel leak

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40279

Introduced by commit 22a5dc0 ("net: sched: Introduce connmark action")
in v4.0-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [62b656e43eaeae445a39cd8021a4f47065af4389]
stable/5.15: [218b67c8c8246d47a2a7910eae80abe4861fe2b7]
stable/6.1: [73cc56c608c209d3d666cc571293b090a471da70]
stable/6.12: [51cb05d4fd632596816ba44e882e84db9fb28a7e]
stable/6.6: [31e4aa93e2e5b5647fc235b0f6ee329646878f9e]

CVE-2025-40280: tipc: Fix use-after-free in tipc_mon_reinit_self().

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40280

Introduced by commit 46cb01e ("tipc: update mon's self addr when node
addr generated") in v5.5-rc1.
Fixed in v6.18-rc6.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [0725e6afb55128be21a2ca36e9674f573ccec173]
stable/5.10: [b2e77c789c234e7fe49057d2ced8f32e2d2c7901]
stable/5.15: [51b8f0ab888f8aa5dfac954918864eeda8c12c19]
stable/6.1: [499b5fa78d525c4450ebb76db83207db71efea77]
stable/6.12: [f0104977fed25ebe001fd63dab2b6b7fefad3373]
stable/6.6: [c92dbf85627b5c29e52d9c120a24e785801716df]

CVE-2025-40281: sctp: prevent possible shift-out-of-bounds in
sctp_transport_update_rto

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40281

Introduced by commit b58537a ("net: sctp: fix permissions for
rto_alpha and rto_beta knobs") in v3.16-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1534ff77757e44bcc4b98d0196bc5c0052fce5fa]
stable/5.10: [834e65be429c0fa4f9bb5945064bd57f18ed2187]
stable/5.15: [abb086b9a95d0ed3b757ee59964ba3c4e4b2fc1a]
stable/6.1: [d0d858652834dcf531342c82a0428170aa7c2675]
stable/6.12: [1cfa4eac275cc4875755c1303d48a4ddfe507ca8]
stable/6.6: [ed71f801249d2350c77a73dca2c03918a15a62fe]

CVE-2025-40282: Bluetooth: 6lowpan: reset link-local header on ipv6 recv path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40282

Introduced by commit 18722c2 ("Bluetooth: Enable 6LoWPAN support for
BT LE devices") in v3.14-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3b78f50918276ab28fb22eac9aa49401ac436a3b]
stable/5.10: [973e0271754c77db3e1b6b69adf2de85a79a4c8b]
stable/5.15: [d566e9a2bfc848941b091ffd5f4e12c4e889d818]
stable/6.1: [4ebb90c3c309e6375dc3e841af92e2a039843e62]
stable/6.12: [11cd7e068381666f842ad41d1cc58eecd0c75237]
stable/6.6: [c24ac6cfe4f9a47180a65592c47e7a310d2f9d93]

CVE-2025-40283: Bluetooth: btusb: reorder cleanup in btusb_disconnect
to avoid UAF

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40283

Introduced by commit fd913ef ("Bluetooth: btusb: Add out-of-band
wakeup support") in v4.11-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23d22f2f71768034d6ef86168213843fc49bf550]
stable/5.10: [f858f004bc343a7ae9f2533bbb2a3ab27428532f]
stable/5.15: [7a6d1e740220ff9dfcb6a8c994d6ba49e76db198]
stable/6.1: [5dc00065a0496c36694afe11e52a5bc64524a9b8]
stable/6.12: [95b9b98c93b1c0916a3d4cf4540b7f5d69145a0d]
stable/6.6: [1c28c1e1522c773a94e26950ffb145e88cd9834b]

CVE-2025-40284: Bluetooth: MGMT: cancel mesh send timer when hdev removed

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40284

Introduced by commit b338d91 ("Bluetooth: Implement support for Mesh")
in v6.1-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [55fb52ffdd62850d667ebed842815e072d3c9961]
stable/6.1: [990e6143b0ca0c66f099d67d00c112bf59b30d76]
stable/6.12: [7b6b6c077cad0601d62c3c34ab7ce3fb25deda7b]
stable/6.6: [2927ff643607eddf4f03d10ef80fe10d977154aa]

CVE-2025-40285: smb/server: fix possible refcount leak in smb2_sess_setup()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40285

Introduced commit is not determined.Fixed in v6.18-rc2.


Fixed status
mainline: [379510a815cb2e64eb0a379cb62295d6ade65df0]
stable/6.1: [6fc935f798d44a8eb8a5e6659198399fbf57b981]
stable/6.12: [dcc51dfe6ff26b52cac106865a172ac982d78401]
stable/6.6: [e671f9bb97805771380c98de944e2ceab6949188]

CVE-2025-40286: smb/server: fix possible memory leak in smb2_read()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40286

Introduced commit is not determined.Fixed in v6.18-rc2.


Fixed status
mainline: [6fced056d2cc8d01b326e6fcfabaacb9850b71a4]
stable/6.1: [0797c6cf3b857cc229ab2bc69552938dcd738d78]
stable/6.12: [f1305587731886da37a214cda812ade246c653b0]
stable/6.6: [63d8706a2c09a0c29b8b0e8a44bc7a1339685de9]

CVE-2025-40287: exfat: fix improper check of dentry.stream.valid_size

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40287

Introduced commit is not determined.Fixed in v6.18-rc2.
Affeced file was added by 5f2aa07 ("exfat: add inode operations") in 5.7-rc1.

Fixed status
mainline: [82ebecdc74ff555daf70b811d854b1f32a296bea]
stable/6.12: [6c627bcc1896ba62ec793d0c00da74f3c93ce3ad]

CVE-2025-40288: drm/amdgpu: Fix NULL pointer dereference in VRAM logic
for APU devices

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40288

Introduced commit is not determined.Fixed in v6.18-rc2.


Fixed status
mainline: [883f309add55060233bf11c1ea6947140372920f]
stable/6.1: [e70113b741ba253886cd71dbadfe3ea444bb2f5c]
stable/6.12: [43aa61c18a3a45042b098b7a1186ffb29364002c]
stable/6.6: [1243e396148a65bb6c42a2b70fe43e50c16c494f]

CVE-2025-40289: drm/amdgpu: hide VRAM sysfs attributes on GPUs without VRAM

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40289

Introduced commit is not determined.Fixed in v6.18-rc2.
Affected function was added by 89a7c0b ("drm/amdgpu: Show vram vendor
only if available") in 6.8-rc2.

Fixed status
mainline: [33cc891b56b93cad1a83263eaf2e417436f70c82]
stable/6.12: [39a1c8c860e32d775f29917939e87b6a7c08ebb1]

CVE-2022-50583: md/raid0, raid10: Don't set discard sectors for request queue

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50583

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
mainline: [8e1a2279ca2b0485cc379a153d02a9793f74a48f]
stable/6.1: [27e5d61a8e6919b5c0c6f473703ffea2acba862a]

CVE-2022-50614: misc: pci_endpoint_test: Fix
pci_endpoint_test_{copy,write,read}() panic

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50614

Introduced by commit 343dc69 ("misc: pci_endpoint_test: Prevent some
integer overflows") in v4.15-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e30538eca016de8e252bef174beadecd64239f0]
stable/5.10: [0df206bdc6204b758585bbe159a55e23e7917b13]
stable/5.15: [e5ebcbb4f967af2083d409271aaf7c7d8351603f]

CVE-2022-50615: perf/x86/intel/uncore: Fix reference count leak in
snr_uncore_mmio_map()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50615

Introduced by commit ee49532 ("perf/x86/intel/uncore: Add IMC uncore
support for Snow Ridge") in v5.3-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ebd16c11c346751b3944d708e6c181ed4746c39]
stable/5.10: [d2afced51108813256d8072c6e464b0c9f0bb890]
stable/5.15: [433bd587dca5c3f7157fef2fe571290cd392cbf6]
stable/6.1: [dc7f07bc1ebb56a23fd1c4f664db5cbeb8900800]

CVE-2022-50616: regulator: core: Use different devices for resource
allocation and DT lookup

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50616

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
mainline: [8f3cbcd6b440032ebc7f7d48a1689dcc70a4eb98]
stable/6.1: [b0f25ca1ff9be7abd1679ae7e59a8f25dbffe67a]

CVE-2022-50617: drm/amdgpu/powerplay/psm: Fix memory leak in power state init

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50617

Introduced by commit 902bc65 ("drm/amdgpu/powerplay/psm: return an
error in power state init") in v5.11-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8f8033d5663b18e6efb33feb61f2287a04605ab5]
stable/5.15: [1caed03305b560bafea8eaa57f1847791658b3ff]
stable/6.1: [1c65f8f98148709e08bd6157a807c443ba91f0ac]

CVE-2022-50618: mmc: meson-gx: fix return value check of mmc_add_host()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50618

Introduced by commit 51c5d84 ("MMC: meson: initial support for GX
platforms") in v4.10-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f5506e0bbb25102bd8ef2e1a3b483a0b934e454e]
mainline: [90935f16f2650ab7416fa2ffbe5c28cb39cf3f1e]
stable/5.10: [64b2c441171febf075bd9632aca579afda8ab9fb]
stable/5.15: [e0cfe7aa41f3965f5224affd88afd48c60f6ad1f]
stable/6.1: [f5ce76aeddf01ca8f2a80fc37119388d59db7c10]

CVE-2022-50619: drm/amdkfd: Fix memory leak in kfd_mem_dmamap_userptr()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50619

Introduced by commit 264fb4d ("drm/amdgpu: Add multi-GPU DMA mapping
helpers") in v5.14-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [90bfee142af0f0e9d3bec80e7acd5f49b230acf7]
stable/5.15: [304a10161696d86300ceab1cbe72b2d74b8cdd94]

CVE-2022-50620: f2fs: fix to invalidate dcc->f2fs_issue_discard in error path

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50620

Introduced by commit 4d67490 ("f2fs: Don't create discard thread when
device doesn't support realtime discard") in v5.15-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [91586ce0d39a05f88795aa8814fb99b1387236b3]
stable/5.15: [865bb7b5a7deeb0e5afbd82381d52d38825dc64d]
stable/6.1: [ae6c960a82c52c3bda5adc82d90643d6c12d308e]

CVE-2022-50621: dm: verity-loadpin: Only trust verity targets with enforcement

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50621

Introduced by commit b6c1c57 ("dm: Add verity helpers for LoadPin") in v6.0-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [916ef6232cc4b84db7082b4c3d3cf1753d9462ba]

CVE-2022-50622: ext4: fix potential memory leak in
ext4_fc_record_modified_inode()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50622

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected file was added by 8016e29 ("ext4: fast commit recovery path")

Fixed status
mainline: [9305721a309fa1bd7c194e0d4a2335bf3b29dca4]
stable/5.10: [c9ce7766dc4e88e624c62a68221a3bbe8f06e856]
stable/5.15: [9b5eb368a86f97eb9831f5b53b8e43ec69bc7cd4]

CVE-2022-50623: fpga: prevent integer overflow in dfl_feature_ioctl_set_irq()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50623

Introduced by commit 322b598 ("fpga: dfl: introduce interrupt trigger
setting API") in v5.9-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [939bc5453b8cbdde9f1e5110ce8309aedb1b501a]
stable/5.10: [f59861946fa51bcc1f305809e4ebc1013b0ee61c]
stable/5.15: [b94605f5cb99e90c8ca91523597a40e1bd59546b]

CVE-2022-50624: net: netsec: fix error handling in netsec_register_mdio()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50624

Introduced by commit 533dd11 ("net: socionext: Add Synquacer NetSec
driver") in v4.16-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [728884b22d83148a330b23f9472f1e118b589211]
mainline: [94423589689124e8cd145b38a1034be7f25835b2]
stable/5.10: [62f0a08e82a6312efd7df7f595c0b11d4ffde610]
stable/5.15: [1e0bee973ef6fc3c1e3acb014515eaea37c8fa17]

CVE-2022-50625: serial: amba-pl011: avoid SBSA UART accessing DMACR register

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50625

Introduced by commit 0dd1e24 (drivers: PL011: add support for the ARM
SBSA generic UART) in v4.2-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [78d837ce20517e0c1ff3ebe08ad64636e02c2e48]
cip/4.4-st: [bb8dd016041c21d1a6eaf46630fc5d28ba1ac0e4]
mainline: [94cdb9f33698478b0e7062586633c42c6158a786]
stable/5.10: [d5b16eb076f46c88d02d41ece5bec4e0d89158bb]
stable/5.15: [d71a611fca1984c0765f9317ff471ac8cd0e3e2f]
stable/6.1: [64bc5dbc3260230e2f022288c71e5c680059384a]

CVE-2022-50626: media: dvb-usb: fix memory leak in dvb_usb_adapter_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50626

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [21b6b0c9f3796e6917e90db403dae9e74025fc40]
cip/4.4-st: [b68ff10a52e1f1b4e0109a1456a9c338f7306d46]
mainline: [94d90fb06b94a90c176270d38861bcba34ce377d]
stable/5.10: [7d7ab25ead969594df05fb09ee46ca931d46c5c8]
stable/5.15: [d0af6220bb1eed8225a5511de5a3bd386b94afa4]
stable/6.1: [93bbf2ed428142aa9a9693721230b28571678bf8]

CVE-2022-50627: wifi: ath11k: fix monitor mode bringup crash

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50627

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected file was added by d5c6515 ("ath11k: driver for Qualcomm IEEE
802.11ax devices") in 5.6-rc1.

Fixed status
mainline: [950b43f8bd8a4d476d2da6d2a083a89bcd3c90d7]
stable/6.1: [d6ea1ca1d456bb661e5a9d104e69d2c261161115]

CVE-2022-50628: drm/gud: Fix UBSAN warning

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50628

Introduced by commit 40e1a70 ("drm: Add GUD USB Display driver") in v5.13-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [951df98024f7272f85df5044eca7374f5b5b24ef]
stable/6.1: [832f861a46039d50536dcfda0a9fb334b48d0f8b]

CVE-2022-50629: wifi: rsi: Fix memory leak in rsi_coex_attach()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50629

Introduced by commit 2108df3 ("rsi: add coex support") in v4.17-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [98259e0b6cf7f021da9fe4e11fbcce6ad6705ffe]
mainline: [956fb851a6e19da5ab491e19c1bc323bb2c2cf6f]
stable/5.10: [efc8df970561ff708379b89b348e16d3b410cc7b]
stable/5.15: [b56e60b3b158a93bc713437e8e466f401ff8cc9f]
stable/6.1: [c4f1ded67a90fb3b2e679e2c90b78921d9246044]

CVE-2022-50630: mm: hugetlb: fix UAF in hugetlb_handle_userfault

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50630

Introduced by commit 1a1aad8 ("userfaultfd: hugetlbfs: add userfaultfd
hugetlb hook") in v4.11-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [958f32ce832ba781ac20e11bb2d12a9352ea28fc]
stable/5.10: [45c33966759ea1b4040c08dacda99ef623c0ca29]
stable/5.15: [0db2efb3bff879566f05341d94c3de00ac95c4cc]

CVE-2023-53742: kcsan: Avoid READ_ONCE() in read_instrumented_memory()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53742

Introduced commit is not determined.Fixed in v6.4-rc1.
This bug was introduced since commit e35123d ("arm64: lto: Strengthen
READ_ONCE() to acquire when CONFIG_LTO=y") is merged.

Fixed status
mainline: [8dec88070d964bfeb4198f34cb5956d89dd1f557]
stable/6.1: [706ae665747b629bcf87a2d7e6438602f904b8d5]

CVE-2023-53743: PCI: Free released resource after coalescing

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53743

Introduced by commit e542232 ("PCI: Release resource invalidated by
coalescing") in v6.5-rc1.
Fixed in v6.6-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [8ec9c1d5d0a5a4744516adb483b97a238892f9d5]
stable/6.1: [4443f3695d581ad1a55f2ef59259dcd0c52402b3]

CVE-2023-53744: soc: ti: pm33xx: Fix refcount leak in am33xx_pm_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53744

Introduced by commit 5a99ae0 ("soc: ti: pm33xx: AM437X: Add rtc_only
with ddr in self-refresh support") in v5.2-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8f3c307b580a4a6425896007325bddefc36e8d91]
stable/5.10: [08310f810975c8c9e17c6ffb99fdb76a84e8adb7]
stable/5.15: [6a50350033e0e0854acf59a8413913b4de04bd7d]
stable/6.1: [6dbcc493a18dd60947c2168a39df0ec2fe7b5110]

CVE-2023-53745: um: vector: Fix memory leak in vector_config

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53745

Introduced by commit 49da7e6 ("High Performance UML Vector Network
Driver") in v4.17-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [5c49fb5ad01104acc584405572abf6616d45148e]
mainline: [8f88c73afe481f93d40801596927e8c0047b6d96]
stable/5.10: [f2b9c4544e3bd60f353732291300097b0e8d8454]
stable/5.15: [276a7298af6a801e9a865282605a79303365ec66]
stable/6.1: [c8583b4655aab44a9796b5c4a681ddcc6fe2f0d0]

CVE-2023-53746: s390/vfio-ap: fix memory leak in vfio_ap device driver

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53746

Introduced by commit 1fde573 ("s390: vfio-ap: base implementation of
VFIO AP device driver") in v4.20-rc1.
Fixed in v6.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8f8cf767589f2131ae5d40f3758429095c701c84]
stable/5.10: [ee17dea3072dec0bc34399a32fa884e26342e4ea]
stable/5.15: [aa2bff25e9bb10c935c7ffe3d5f5975bdccb1749]
stable/6.1: [6a40fda14b4be3e38f03cc42ffd4efbc64fb3e67]

CVE-2023-53747: vc_screen: reload load of struct vc_data pointer in
vcs_write() to avoid UAF

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53747

Introduced by commit ac751ef ("console: rename
acquire/release_console_sem() to console_lock/unlock()") in
v2.6.38-rc3.
Fixed in v6.4-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [0deff678157333d775af190f84696336cdcccd6d]
cip/4.4-st: [9e7f19fe40908ff08749fc5b63d58513d9c0e833]
mainline: [8fb9ea65c9d1338b0d2bb0a9122dc942cdd32357]
stable/5.10: [11dddfbb7a4e62489b01074d6c04d9d1b42e4047]
stable/5.15: [e3d1adcad5b73c7ed0c7edb35ab68abcaa45cf67]
stable/6.1: [3338d0b9acde770ee588eead5cac32c25e7048fc]

CVE-2023-53748: media: mediatek: vcodec: Fix potential array
out-of-bounds in decoder queue_setup

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53748

Introduced commit is not determined.Fixed in v6.4-rc1.
Affected file was added by 590577a ("[media] vcodec: mediatek: Add
Mediatek V4L2 Video Decoder Driver") in 4.10-rc1.

Fixed status
mainline: [8fbcf730cb89c3647f3365226fe7014118fa93c7]
stable/6.1: [48e4e06e2c5fe1fda283d499f91492eda2248bb9]

CVE-2023-53749: x86: fix clear_user_rep_good() exception handling annotation

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53749



Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2c95f9d6802cc518d71d9795f4d9da54fb4e24d]
stable/6.1: [76ce32682635fe907e0f8e64e039e773e5c7508f]

CVE-2023-53750: pinctrl: freescale: Fix a memory out of bounds when
num_configs is 1

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53750

Introduced by commit f60c9ea ("gpio: mxc: enable pad wakeup on i.MX8x
platforms") in v6.2-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9063777ca1e2e895c5fdd493ee0c3f18fa710ed4]

CVE-2023-53751: cifs: fix potential use-after-free bugs in
TCP_Server_Info::hostname

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53751

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
mainline: [90c49fce1c43e1cc152695e20363ff5087897c09]
stable/6.1: [64d62ac6d6514cba1305bd08e271ec1843bdd612]

CVE-2023-53752: net: deal with integer overflows in kmalloc_reserve()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53752

Introduced by commit 12d6c1d ("skbuff: Proactively round up to kmalloc
bucket size") in v6.2-rc1.
Fixed in v6.6-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [915d975b2ffa58a14bfcf16fafe00c41315949ff]
stable/6.1: [31cf7853a940181593e4472fc56f46574123f9f6]

CVE-2023-53753: drm/amd/display: fix mapping to non-allocated address

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53753

Introduced commit is not determined.Fixed in v6.3-rc1.
hw_factory_dcn32.c was added by 58efeea ("drm/amd/display: add GPIO
changes for DCN32/321") in 6.0-rc1. hw_factory_dcn30.c was added by
666ed8b ("drm/amd/display: Add DCN3 GPIO") in 5.9-rc1.
hw_factory_dcn20.c was added by 2e35fac ("drm/amd/display: Add GPIO
support for DCN2") in 5.3-rc1.

Fixed status
mainline: [9190d4a263264eabf715f5fc1827da45e3fdc247]
stable/6.1: [8ce8a443ddd9002861a4ee8a7e33a0c02717422f]

CVE-2023-53754: scsi: lpfc: Fix ioremap issues in lpfc_sli4_pci_mem_setup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53754

Introduced by commit 1351e69 ("scsi: lpfc: Add push-to-adapter support
to sli4") in v4.17-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [91a0c0c1413239d0548b5aac4c82f38f6d53a91e]
stable/5.10: [bab8dc38b1a0a12bc064fc064269033bdcf5b88e]
stable/5.15: [fd8c83d8375b9dac1949f2753485a5c055ebfad0]
stable/6.1: [e6f1ef4a53856ed000b0f7265d7e16dcb00f4243]

CVE-2023-53755: dmaengine: ptdma: check for null desc before calling
pt_cmd_callback

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53755

Introduced by commit 6fa7e0e ("dmaengine: ptdma: fix concurrency issue
with multiple dma transfer") in v5.18-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [928469986171a6f763b34b039427f5667ba3fd50]
stable/6.1: [8ae2113702613207efc05453bc9a3df2b992bf45]

CVE-2023-53756: KVM: VMX: Fix crash due to uninitialized current_vmcs

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53756

Introduced by commit ceef7d1 ("KVM: x86: VMX: hyper-v: Enlightened
MSR-Bitmap support") in v4.18-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [93827a0a36396f2fd6368a54a020f420c8916e9b]
stable/5.10: [6baebcecf09acd19e2bab1c2911dcdba5d48a1dc]
stable/5.15: [6e7bc50f97c9855da83f1478f722590defd45ff2]
stable/6.1: [b2de2b4d4e007f9add46ea8dc06f781835e3ea9f]

CVE-2023-53757: irqchip/irq-mvebu-gicp: Fix refcount leak in mvebu_gicp_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53757

Introduced by commit a68a63c ("irqchip/irq-mvebu-gicp: Add new driver
for Marvell GICP") in v4.13-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [4545d7a70ce0fc78b1d3c33c4a0939a86f363b57]
mainline: [9419e700021a393f67be36abd0c4f3acc6139041]
stable/5.10: [cee12e8be8e227731a845ae43a4c9ce2e404be45]
stable/5.15: [88cb93d3a16f706bd7213f8a5882c394e5d10c4e]
stable/6.1: [bb755e020abc24793b9411c9419ed43f07f9a03d]

CVE-2023-53758: spi: atmel-quadspi: Free resources even if runtime
resume failed in .remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53758

Introduced by commit 4a2f83b ("spi: atmel-quadspi: add runtime pm
support") in v6.0-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9448bc1dee65f86c0fe64d9dea8b410af0586886]
stable/6.1: [f6974fb20499e3b6522daa7aec822aac11dfcf42]

CVE-2023-53759: HID: hidraw: fix data race on device refcount

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53759

Introduced by commit 8590222 ("HID: hidraw: Replace hidraw device
table mutex with a rwsem") in v5.17-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [944ee77dc6ec7b0afd8ec70ffc418b238c92f12b]
stable/6.1: [879e79c3aead41b8aa2e91164354b30bd1c4ef3b]

CVE-2023-53760: scsi: ufs: core: mcq: Fix &hwq->cq_lock deadlock issue

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53760

Introduced by commit ed97506 ("scsi: ufs: core: mcq: Add completion
support in poll") in v6.3-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [948afc69615167a3c82430f99bfd046332b89912]

CVE-2023-53761: USB: usbtmc: Fix direction for 0-length ioctl control messages

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53761

Introduced commit is not determined.Fixed in v6.4-rc3.
Affected function was added by 658f24f ("usb: usbtmc: Add ioctl for
generic requests on control") in 4.20-rc1.

Fixed status
mainline: [94d25e9128988c6a1fc9070f6e98215a95795bd8]
stable/5.10: [6340e432cf70bf156b19c6f5dd737d940eca02a3]
stable/5.15: [3b43d9df27a708f4079d518b879f517fea150a91]
stable/6.1: [0ced12bdf624d8d8977ddb16eb130cd479d92bcf]

CVE-2023-53762: Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53762

Introduced by commit 182ee45 ("Bluetooth: hci_sync: Rework
hci_suspend_notifier") in v5.17-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [94d9ba9f9888b748d4abd2aa1547af56ae85f772]

CVE-2023-53763: Revert "f2fs: fix to do sanity check on extent cache correctly"

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53763

Introduced by commit d48a7b3 ("f2fs: fix to do sanity check on extent
cache correctly") in v6.3-rc1.
Fixed in v6.6-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [958ccbbf1ce716d77c7cfa79ace50a421c1eed73]
stable/6.1: [0d545a8e77cbd1fbad311b18952e38e0f7672ab4]

CVE-2023-53764: wifi: ath12k: Handle lock during peer_id find

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53764

Introduced commit is not determined.Fixed in v6.4-rc1.
Affected function was added by d889913 ("wifi: ath12k: driver for
Qualcomm Wi-Fi 7 devices") in 6.3-rc1.

Fixed status
mainline: [95a389e2ff3212d866cc51c77d682d2934074eb8]

CVE-2023-53765: dm cache: free background tracker's queued work in
btracker_destroy

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53765

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected function was added by b29d498 ("dm cache: significant rework
to leverage dm-bio-prison-v2") in 4.12-rc1.

Fixed status
mainline: [95ab80a8a0fef2ce0cc494a306dd283948066ce7]
stable/6.1: [673a3af21d5e3ed769f3eaed0c888244290a3506]

CVE-2023-53766: FS: JFS: Check for read-only mounted filesystem in txBegin

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53766

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
cip/4.19-st: [97c1f26e4d4af55e8584e4646dd5c5fa7baf62c7]
cip/4.4-st: [edba6badc2d694022e7a626912d5171a0d59eb21]
mainline: [95e2b352c03b0a86c5717ba1d24ea20969abcacc]
stable/5.10: [5c094ca994824e038b6a97835ded4e5d1d808504]
stable/5.15: [2febd5f81e4bfba61d9f374dcca628aff374cc56]
stable/6.1: [aa7cdf487ab3fa47284daaccc3d7d5de01c6a84c]

CVE-2023-53767: wifi: ath12k: fix memory leak in ath12k_qmi_driver_event_work()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53767

Introduced commit is not determined.Fixed in v6.4-rc1.
Affected function was added by d889913 ("wifi: ath12k: driver for
Qualcomm Wi-Fi 7 devices") in 6.3-rc1.

Fixed status
mainline: [960412bee0ea75f6b3c2dca4a3535795ee84c47a]

CVE-2023-53768: regmap-irq: Fix out-of-bounds access when allocating
config buffers

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53768

Introduced by commit faa87ce ("regmap-irq: Introduce config registers
for irq types") in v6.0-rc1.
Fixed in v6.5-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [963b54df82b6d6206d7def273390bf3f7af558e1]
stable/6.1: [b1a726ad33e585e3d9fa70712df31ae105e4532c]

CVE-2023-53769: virt/coco/sev-guest: Double-buffer messages

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53769

Introduced by commit d5af44d ("x86/sev: Provide support for SNP guest
request NAEs") in v5.19-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [965006103a14703cc42043bbf9b5e0cdf7a468ad]
stable/6.1: [577a64725bfd77645986168e953d405067ee565b]

CVE-2025-40290: xsk: avoid data corruption on cq descriptor number

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40290

Introduced by commit 30f241f ("xsk: Fix immature cq descriptor
production") in v6.17-rc6.
Fixed in v6.18.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ebc27a4c67d44e5ce88d21cdad8201862b78837]

CVE-2025-40291: io_uring: fix regbuf vector size truncation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40291

Introduced by commit 9ef4cbb ("io_uring: add infra for importing
vectored reg buffers") in v6.15-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [146eb58629f45f8297e83d69e64d4eea4b28d972]

CVE-2025-40292: virtio-net: fix received length check in big packets

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40292

Introduced by commit 4959aeb ("virtio-net: use mtu size as buffer
length for big packets") in v6.1-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c716703965ffc5ef4311b65cb5d84a703784717]
stable/6.1: [82f9028e83944a9eee5229cbc6fee9be1de8a62d]
stable/6.12: [82fe78065450d2d07f36a22e2b6b44955cf5ca5b]
stable/6.6: [946dec89c41726b94d31147ec528b96af0be1b5a]

CVE-2025-40293: iommufd: Don't overflow during division for dirty tracking

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40293

Introduced by commit 58ccf01 ("vfio: Add an IOVA bitmap support") in v6.1-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb30dfa75d55eced379a42fd67bd5fb7ec38555e]
stable/6.1: [07105e61882ff4a7d58db63cc5f9e90c6c60506c]
stable/6.12: [de7f2c67ceb1941b05b04ac35458a03e93cc57b1]
stable/6.6: [4c8a4f1d34eced168cc0b3a3dfe7b6dcc2090f69]

CVE-2025-40294: Bluetooth: MGMT: Fix OOB access in parse_adv_monitor_pattern()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40294

Introduced by commit db08722 ("Bluetooth: hci_core: Fix missing
instances using HCI_MAX_AD_LENGTH") in v6.6-rc1.
Fixed in v6.18-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [8d59fba49362c65332395789fd82771f1028d87e]
stable/6.1: [96616530f524a0a76248cd44201de0a9e8526190]
stable/6.12: [4b7d4aa5399b5a64caee639275615c63c008540d]
stable/6.6: [5f7350ff2b179764a4f40ba4161b60b8aaef857b]

CVE-2025-40295: fscrypt: fix left shift underflow when
inode->i_blkbits > PAGE_SHIFT

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40295

Introduced by commit 47dd675 ("block/bdev: lift block size
restrictions to 64k") in v6.15-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e39da974ce621ed874c6d3aaf65ad14848c9f0d]

CVE-2025-40296: platform/x86: int3472: Fix double free of GPIO device
during unregister

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40296

Introduced by commit 1e5d088 ("platform/x86: int3472: Stop using
devm_gpiod_get()") in v6.16-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0f7a3f542c1698edb69075f25a3f846207facba]

CVE-2025-40297: net: bridge: fix use-after-free due to MST port state bypass

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40297

Introduced by commit ec7328b ("net: bridge: mst: Multiple Spanning
Tree (MST) mode") in v5.18-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8dca36978aa80bab9d4da130c211db75c9e00048]
stable/6.1: [e19085b2a86addccff33ab8536fc67ebd9d52198]
stable/6.12: [bf3843183bc3158e5821b46f330c438ae9bd6ddb]
stable/6.6: [3b60ce334c1ce8b3fad7e02dcd5ed9f6646477c8]

CVE-2025-40298: gve: Implement settime64 with -EOPNOTSUPP

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40298

Introduced by commit acd1638 ("gve: Add initial PTP device support")
in v6.17-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [329d050bbe63c2999f657cf2d3855be11a473745]

CVE-2025-40299: gve: Implement gettimex64 with -EOPNOTSUPP

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40299

Introduced by commit acd1638 ("gve: Add initial PTP device support")
in v6.17-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6ab753b5d8e521616cd9bd10b09891cbeb7e0235]

CVE-2025-40301: Bluetooth: hci_event: validate skb length for unknown CC opcode

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40301

Introduced by commit afcb336 ("Bluetooth: hci_event: Fix vendor
(unknown) opcode status handling") in v6.1-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5c5f1f64681cc889d9b13e4a61285e9e029d6ab5]
stable/6.1: [fea895de78d3bb2f0c09db9f10b18f8121b15759]
stable/6.12: [cf2c2acec1cf456c3d11c11a7589e886a0f963a9]
stable/6.6: [779f83a91d4f1bf5ddfeaf528420cbb6dbf03fa8]

CVE-2025-40302: media: videobuf2: forbid remove_bufs when legacy
fileio is active

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40302

Introduced by commit a3293a8 ("media: v4l2: Add REMOVE_BUFS ioctl") in
v6.10-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [27afd6e066cfd80ddbe22a4a11b99174ac89cced]
stable/6.12: [a6a493b985bfffac097a4e1be09f98b27729dca8]

CVE-2025-40303: btrfs: ensure no dirty metadata is written back for an
fs with errors

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40303

Introduced commit is not determined.Fixed in v6.18-rc5.


Fixed status
mainline: [2618849f31e7cf51fadd4a5242458501a6d5b315]
stable/6.12: [e2b3859067bf012d53c49b3f885fef40624a2c83]
stable/6.6: [066ee13f05fbd82ada01883e51f0695172f98dff]

CVE-2025-40304: fbdev: Add bounds checking in bit_putcs to fix
vmalloc-out-of-bounds

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40304

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [3637d34b35b287ab830e66048841ace404382b67]
stable/5.10: [f0982400648a3e00580253e0c48e991f34d2684c]
stable/5.15: [1943b69e87b0ab35032d47de0a7fca9a3d1d6fc1]
stable/6.1: [ebc0730b490c7f27340b1222e01dd106e820320d]
stable/6.12: [15ba9acafb0517f8359ca30002c189a68ddbb939]
stable/6.6: [86df8ade88d290725554cefd03101ecd0fbd3752]

CVE-2025-40305: 9p/trans_fd: p9_fd_request: kick rx thread if EPOLLIN

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40305

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [e8fe3f07a357c39d429e02ca34f740692d88967a]
stable/6.12: [2e1461034aef99e905a1fe5589aaf00eaea73eee]

CVE-2025-40306: orangefs: fix xattr related buffer overflow...

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40306

Introduced commit is not determined.Fixed in v6.18-rc1.
Orangefs was added by 1182fca ("Orangefs: kernel client part 5") in 4.6-rc1.

Fixed status
mainline: [025e880759c279ec64d0f754fe65bf45961da864]
stable/5.10: [ef892d2bf4f3fa2c8de1677dd307e678bdd3d865]
stable/5.15: [15afebb9597449c444801d1ff0b8d8b311f950ab]
stable/6.1: [bc812574de633cf9a9ad6974490e45f6a4bb5126]
stable/6.12: [9127d1e90c90e5960c8bc72a4ce2c209691a7021]
stable/6.6: [e09a096104fc65859422817fb2211f35855983fe]

CVE-2025-40307: exfat: validate cluster allocation bits of the allocation bitmap

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40307

Introduced commit is not determined.Fixed in v6.18-rc1.
Affected file was added by 1e49a94 ("exfat: add bitmap operations") in 5.7-rc1.

Fixed status
mainline: [79c1587b6cda74deb0c86fc7ba194b92958c793c]
stable/6.12: [6bc58b4c53795ab5fe00648344aa7d9d61175f90]

CVE-2025-40308: Bluetooth: bcsp: receive data only if registered

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40308

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [ca94b2b036c22556c3a66f1b80f490882deef7a6]
stable/5.10: [164586725b47f9d61912e6bf17dbaffeff11710b]
stable/5.15: [b65ca9708bfbf47d8b7bd44b7c574bd16798e9c9]
stable/6.1: [8b892dbef3887dbe9afdc7176d1a5fd90e1636aa]
stable/6.12: [b420a4c7f915fc1c94ad1f6ca740acc046d94334]
stable/6.6: [799cd62cbcc3f12ee04b33ef390ff7d41c37d671]

CVE-2025-40309: Bluetooth: SCO: Fix UAF on sco_conn_free

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40309

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [ecb9a843be4d6fd710d7026e359f21015a062572]
stable/5.10: [c17caff1062ca91ebac44bfd01d2fb3d99dc0e23]
stable/5.15: [d2850f037c2ae75882d68ae654d546ff5c0f678c]
stable/6.1: [c419674cc74309ffaabc591e7200efb49a18fccd]
stable/6.12: [ed10dddc7df2daaf2a4d98a972aac5183e738cc0]
stable/6.6: [03371c0218189b185595b65a04dad60076ca9718]

CVE-2025-40310: amd/amdkfd: resolve a race in amdgpu_amdkfd_device_fini_sw

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40310

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [99d7181bca34e96fbf61bdb6844918bdd4df2814]
stable/6.12: [bc9e789053abe463f8cf74eee5fc2f157c11a79f]
stable/6.6: [93f8d67ef8b50334a26129df4da5a4cb60ad4090]

CVE-2025-40311: accel/habanalabs: support mapping cb with
vmalloc-backed coherent memory

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40311

Introduced commit is not determined.Fixed in v6.18-rc1.
gaudi2.c was added by d7bb1ac ("habanalabs: add gaudi2 asic-specific
code") in 6.0-rc1. gaudi.c was added by ac0ae6a ("habanalabs: add
gaudi asic-dependent code") in 5.8-rc1.

Fixed status
mainline: [513024d5a0e34fd34247043f1876b6138ca52847]
stable/6.12: [d1dfe21a332d38a6a09658ec29a55940afb5fe36]
stable/6.6: [7ec8ac9f73d4a9438c2186768d6de27ace37531e]

CVE-2025-40312: jfs: Verify inode mode when loading from disk

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40312

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [7a5aa54fba2bd591b22b9b624e6baa9037276986]
stable/5.10: [fabc1348bb8fe6bc80850014ee94bd89945f7f4d]
stable/5.15: [46c76cfa17d1828c1a889cb54cb11d5ef3dfbc0f]
stable/6.1: [2870a7dec49ccdc3f6ae35da8f5d6737f21133a8]
stable/6.12: [1795277a4e98d82e6451544d43695540cee042ea]
stable/6.6: [ce054a366c54992185c9514e489a14f145b10c29]

CVE-2025-40313: ntfs3: pretend $Extend records as regular files

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40313

Introduced commit is not determined.Fixed in v6.18-rc1.
ntfs3 was addedby 82cae26 ("fs/ntfs3: Add initialization of super
block") in 5.15-rc1.

Fixed status
mainline: [4e8011ffec79717e5fdac43a7e79faf811a384b7]
stable/5.15: [63eb6730ce0604d3eacf036c2f68ea70b068317c]
stable/6.1: [78d46f5276ed3589aaaa435580068c5b62efc921]
stable/6.12: [37f65e68ba9852dc51c78dbb54a9881c3f0fe4f7]
stable/6.6: [17249b2a65274f73ed68bcd1604e08a60fd8a278]

CVE-2025-40314: usb: cdns3: gadget: Use-after-free during failed
initialization and exit of cdnsp gadget

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40314

Introduced commit is not determined.Fixed in v6.18-rc1.
cdnsp-gadget.c was added by 3d82904 ("usb: cdnsp: cdns3 Add main part
of Cadence USBSSP DRD Driver") in v5.12-rc1-dontuse.

Fixed status
mainline: [87c5ff5615dc0a37167e8faf3adeeddc6f1344a3]
stable/5.15: [0cf9a50af91fbdac3849f8d950e883a3eaa3ecea]
stable/6.1: [37158ce6ba964b62d1e3eebd11f03c6900a52dd1]
stable/6.12: [9c52f01429c377a2d32cafc977465f37b5384f77]
stable/6.6: [ea37884097a0931abb8e11e40eacfb25e9fdb5e9]

CVE-2025-40315: usb: gadget: f_fs: Fix epfile null pointer access
after ep enable.

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40315

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [cfd6f1a7b42f62523c96d9703ef32b0dbc495ba4]
stable/5.10: [1c0dbd240be3f87cac321b14e17979b7e9cb6a8f]
stable/5.15: [9ec40fba7357df2d36f4c2e2f3b9b1a4fba0a272]
stable/6.1: [c53e90563bc148e4e0ad09fe130ba2246d426ea6]
stable/6.12: [d62b808d5c68a931ad0849a00a5e3be3dd7e0019]
stable/6.6: [fc1141a530dfc91f0ee19b7f422a2d24829584bc]

CVE-2025-40316: drm/mediatek: Fix device use-after-free on unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40316

Introduced by commit 1f40369 ("drm/mediatek: Fix device/node reference
count leaks in mtk_drm_get_all_drm_priv") in v6.17-rc4.
Fixed in v6.18-rc4.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [926d002e6d7e2f1fd5c1b53cf6208153ee7d380d]
stable/6.12: [0142fe895986addf35885b43440718e567121155]
stable/6.6: [a5a896f8315de358a2932e2c23c42d550256046a]

CVE-2025-40317: regmap: slimbus: fix bus_context pointer in regmap init calls

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40317

Introduced by commit 4e65bda ("ASoC: wcd934x: fix error handling in
wcd934x_codec_parse_data()") in v6.18-rc1.
Introduced by commit 7d6f7fb ("regmap: add SLIMbus support") in v4.16-rc1.
Fixed in v6.18-rc4.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.17 stable/6.6

Fixed status
mainline: [434f7349a1f00618a620b316f091bd13a12bc8d2]
stable/5.10: [02d3041caaa3fe4dd69e5a8afd1ac6b918ddc6a1]
stable/5.15: [d979639f099c6e51f06ce4dd8d8e56364d6c17ba]
stable/6.1: [8143e4075d131c528540417a51966f6697be14eb]
stable/6.12: [a16e92f8d7dc7371e68f17a9926cb92d2244be7b]
stable/6.6: [2664bfd8969d1c43dcbe3ea313f130dfa6b74f4c]

CVE-2025-40318: Bluetooth: hci_sync: fix race in hci_cmd_sync_dequeue_once

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40318

Introduced by commit 505ea2b ("Bluetooth: hci_sync: Add helper
functions to manipulate cmd_sync queue") in v6.9-rc1.
Fixed in v6.18-rc4.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [09b0cd1297b4dbfe736aeaa0ceeab2265f47f772]
stable/6.1: [0a94f7e017438935c09ef833a1aa908ad9875213]
stable/6.12: [ae76cf6c2c842944c6514c57df54d728f1916553]
stable/6.6: [932c0a4f77ac13e526fdd5b42914d29c9821d389]

CVE-2025-40319: bpf: Sync pending IRQ work before freeing ring buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40319

Introduced by commit 457f443 ("bpf: Implement BPF ring buffer and
verifier support for it") in v5.8-rc1.
Fixed in v6.18-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e9077638301816a7d73fa1e1b4c1db4a7e3b59c]
stable/5.10: [47626748a2a00068dbbd5836d19076637b4e235b]
stable/5.15: [de2ce6b14bc3e565708a39bdba3ef9162aeffc72]
stable/6.1: [e1828c7a8d8135e21ff6adaaa9458c32aae13b11]
stable/6.12: [10ca3b2eec384628bc9f5d8190aed9427ad2dde6]
stable/6.6: [6451141103547f4efd774e912418a3b4318046c6]

CVE-2025-40320: smb: client: fix potential cfid UAF in smb2_query_info_compound

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40320

Introduced by commit 4f1fffa ("cifs: commands that are retried should
have replay flag set") in v6.8-rc2.
Fixed in v6.18-rc4.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [5c76f9961c170552c1d07c830b5e145475151600]
stable/6.12: [327f89c21601ebb7889f8c97754b76f08ce95a0c]
stable/6.6: [939c4e33005e2a56ea8fcedddf0da92df864bd3b]

CVE-2025-40321: wifi: brcmfmac: fix crash while sending Action Frames
in standalone AP Mode

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40321

Introduced by commit 18e2f61 ("brcmfmac: P2P action frame tx") in v3.9-rc1.
Fixed in v6.18-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3776c685ebe5f43e9060af06872661de55e80b9a]
stable/5.10: [e1fc9afcce9139791260f962541282d47fbb508d]
stable/5.15: [55f60a72a178909ece4e32987e4c642ba57e1cf4]
stable/6.1: [c2b0f8d3e7358c33d90f0e62765d474f25f26a45]
stable/6.12: [a6eed58249e7d60f856900e682992300f770f64b]
stable/6.6: [64e3175d1c8a3bea02032e7c9d1befd5f43786fa]

CVE-2025-40322: fbdev: bitblit: bound-check glyph index in bit_putcs*

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40322

Introduced commit is not determined.Fixed in v6.18-rc4.


Fixed status
mainline: [18c4ef4e765a798b47980555ed665d78b71aeadf]
stable/5.10: [0998a6cb232674408a03e8561dc15aa266b2f53b]
stable/5.15: [db5c9a162d2f42bcc842b76b3d935dcc050a0eec]
stable/6.1: [c12003bf91fdff381c55ef54fef3e961a5af2545]
stable/6.12: [901f44227072be60812fe8083e83e1533c04eed1]
stable/6.6: [9ba1a7802ca9a2590cef95b253e6526f4364477f]

CVE-2025-40323: fbcon: Set fb_display[i]->mode to NULL when the mode is released

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40323

Introduced commit is not determined.Fixed in v6.18-rc4.


Fixed status
mainline: [a1f3058930745d2b938b6b4f5bd9630dc74b26b7]
stable/6.1: [4ac18f0e6a6d599ca751c4cd98e522afc8e3d4eb]
stable/6.12: [c079d42f70109512eee49123a843be91d8fa133f]
stable/6.6: [468f78276a37f4c6499385a4ce28f4f57be6655d]

CVE-2025-40324: NFSD: Fix crash in nfsd4_read_release()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40324

Introduced by commit 15a8b55 ("nfsd: call op_release, even when
op_func returns an error") in v6.3-rc6.
Fixed in v6.18-rc4.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [abb1f08a2121dd270193746e43b2a9373db9ad84]
stable/5.10: [930cb4fe3ab4061be31f20ee30bb72a66f7bb6d1]
stable/5.15: [375fdd8993cecc48afa359728a6e70b280dde1c8]
stable/6.1: [2ac46606b2cc49e78d8e3d8f2685e79e9ba73020]
stable/6.12: [a4948875ed0599c037dc438c11891c9012721b1d]
stable/6.6: [03524ccff698d4a77d096ed529073d91f5edee5d]

CVE-2025-40326: NFSD: Define actions for the new time_deleg FATTR4 attributes

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40326

Introduced by commit 51c0d4f ("nfsd: add support for
FATTR4_OPEN_ARGUMENTS") in v6.14-rc1.
Fixed in v6.18-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f76435fd517981f01608678c06ad9718a86ee98]

CVE-2022-50631: RISC-V: kexec: Fix memory leak of fdt buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50631

Introduced by commit 6261586 ("RISC-V: Add kexec_file support") in v5.19-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [96df59b1ae23f5c11698c3c2159aeb2ecd4944a4]
stable/6.1: [dc387c34d8dd10b02a333df098f8fd9bba177a45]

CVE-2022-50632: drivers: perf: marvell_cn10k: Fix hotplug callback
leak in tad_pmu_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50632

Introduced by commit 036a758 ("drivers: perf: Add LLC-TAD perf counter
support") in v5.17-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [973ae93d80d9d262f695eb485a1902b74c4b9098]
stable/6.1: [7772f4de934123ccd7c7cdc1dc4e46fdd5d767fb]

CVE-2022-50633: usb: dwc3: qcom: Fix memory leak in dwc3_qcom_interconnect_init

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50633

Introduced by commit bea46b9 ("usb: dwc3: qcom: Add interconnect
support in dwc3 driver") in v5.10-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [97a48da1619ba6bd42a0e5da0a03aa490a9496b1]
stable/5.10: [f9089b95548f0272e02a89989c511e235561d051]
stable/5.15: [56f6de394f0f57928cd401255a5c7866b68a77e3]
stable/6.1: [2f3b51189f7a7be5d822fb8c537d778c57eb9821]

CVE-2022-50634: power: supply: cw2015: Fix potential null-ptr-deref in
cw_bat_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50634

Introduced by commit b4c7715 ("power: supply: add CellWise cw2015 fuel
gauge driver") in v5.8-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [97f2b4ddb0aa700d673691a7d5e44d226d22bab7]
stable/6.1: [5150b76aa2eb8bb8feb7f7a048417f9d39c3dd04]

CVE-2022-50635: powerpc/kprobes: Fix null pointer reference in
arch_prepare_kprobe()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50635

Introduced by commit b4657f7 ("powerpc/kprobes: Don't allow
breakpoints on suffixes") in v5.8-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [97f88a3d723162781d6cbfdc7b9617eefab55b19]
stable/5.15: [7f536a8cb62dd5c084f112373fc34cdb5168a813]

CVE-2022-50636: PCI: Fix pci_device_is_present() for VFs by checking PF

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50636

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [643d77fda08d06f863af35e80a7e517ea61d9629]
mainline: [98b04dd0b4577894520493d96bc4623387767445]
stable/5.10: [99ef6cc791584495987dd11b14769b450dfa5820]
stable/5.15: [67fd41bbb0f51aa648a47f728b99e6f1fa2ccc34]
stable/6.1: [518573988a2f14f517403db2ece5ddaefba21e94]

CVE-2022-50637: cpufreq: qcom-hw: Fix memory leak in qcom_cpufreq_hw_read_lut()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50637

Introduced by commit 51c843c ("cpufreq: qcom: Update the bandwidth
levels on frequency change") in v5.9-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9901c21bcaf2f01fe5078f750d624f4ddfa8f81b]
stable/5.10: [3ef12a4a8ef5553af9c3fd2719a616637a102568]
stable/5.15: [4ea765b10624d67407817100d381c60f53593033]
stable/6.1: [242e23be8f31ebd90525c57ee3244c28e99a1697]

CVE-2022-50638: ext4: fix bug_on in __es_tree_search caused by bad
boot loader inode

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50638

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [5f8d36abd2059bf1bd016b17d1fe78d8613deddd]
cip/4.4-st: [91c683d64f43427aa3b717158b57d7ddb5696dad]
mainline: [991ed014de0840c5dc405b679168924afb2952ac]
stable/5.10: [71e99ec1315fe98d322b17b9a28f204aaf15ffee]
stable/5.15: [d480a49c15c465cb9a16db1379f4996e9b5bb9cc]
stable/6.1: [a125c8806b7d3c3815b6f9f59d395b9d7527b0ef]

CVE-2022-50639: io-wq: Fix memory leak in worker creation

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50639

Introduced by commit 0e03496 ("io-wq: use private CPU mask") in v5.14-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [996d3efeb091c503afd3ee6b5e20eabf446fd955]
stable/5.15: [b6e2c54be37d5eb4f6666e6aa59cd0581c7ffc3c]

CVE-2022-50640: mmc: core: Fix kernel panic when remove non-standard SDIO card

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50640

Introduced by commit 6f51be3 ("sdio: allow non-standard SDIO cards")
in v2.6.36-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [1fb79478695d92bab1c120ad3dad05252b02a29d]
cip/4.4-st: [5c9b964e128ec5552686b413d4191484017fdec4]
mainline: [9972e6b404884adae9eec7463e30d9b3c9a70b18]
stable/5.10: [8bf037279b5869ae9331c42bb1527d2680ebba96]
stable/5.15: [1e8cd93ae536581562bab4e1d8c5315bbc2548bf]

CVE-2022-50641: HSI: omap_ssi: Fix refcount leak in ssi_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50641

Introduced by commit b209e04 ("HSI: Introduce OMAP SSI driver") in v3.16-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e8a218c17d7c5c42d5609ef92d339b47f3d11d02]
cip/4.4-st: [097728f71f8800c6129fe00005fa5f89786c6415]
mainline: [9a2ea132df860177b33c9fd421b26c4e9a0a9396]
stable/5.10: [962f22e7f7698f7718d95bd9b63e41fb8cca01a9]
stable/5.15: [691f23a8475f04c988f7e98066b084e996b40fa0]

CVE-2022-50642: platform/chrome: cros_ec_typec: zero out stale pointers

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50642

Introduced by commit f28adb4 ("platform/chrome: cros_ec_typec:
Register Type C switches") in v5.9-rc1.
Introduced by commit 1a8912c ("platform/chrome: cros_ec_typec: Get
retimer handle") in v6.1-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9a8aadcf0b459c1257b9477fd6402e1d5952ae07]
stable/5.15: [0ceadb5a3e45f1b81cf54bd496b40a5e50b6bd40]
stable/6.1: [6613f36a2fa5c69e528bccba8b3d831f759dad2f]

CVE-2022-50643: cifs: Fix xid leak in cifs_copy_file_range()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50643

Introduced by commit 4e8aea3 ("smb3: enable swap on SMB3 mounts") in v5.7-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9a97df404a402fe1174d2d1119f87ff2a0ca2fe9]
stable/5.10: [bf49d4fe4ab7b8d812927a2c7b514864d5fc1bb2]
stable/5.15: [27cfd3afaab000a455194338db3b7f2031fde9d0]

CVE-2022-50644: clk: ti: dra7-atl: Fix reference leak in of_dra7_atl_clk_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50644

Introduced by commit 9ac33b0 ("CLK: TI: Driver for DRA7 ATL (Audio
Tracking Logic)") in v3.16-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [25fe7b0d596b343e7a5504ba11767115fff8494f]
cip/4.4-st: [38590682194dfd4eea73cf1d1ebb20618722a44b]
mainline: [9c59a01caba26ec06fefd6ca1f22d5fd1de57d63]
stable/5.10: [6d01017247eee3fba399f601b0bcb38e4fb88a72]
stable/5.15: [3441076f83aace85f5d6ccd9ffb301ac6b874776]

CVE-2022-50645: EDAC/i10nm: fix refcount leak in pci_get_dev_wrapper()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50645

Introduced by commit d4dc89d ("EDAC, i10nm: Add a driver for Intel
10nm server processors") in v5.1-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9c8921555907f4d723f01ed2d859b66f2d14f08e]
stable/5.10: [2db53c7059167b63cc790366ef1a9e286e71980b]
stable/5.15: [3e255dc21031cc1f341584eb99a7f31598bf0be7]
stable/6.1: [f29c2f57cdf7a57223dcd9fbaa2261faab5234b2]

CVE-2022-50646: scsi: hpsa: Fix possible memory leak in hpsa_init_one()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50646

Introduced by commit 8b834bf ("scsi: hpsa: fix selection of reply
queue") in v4.16.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f4d1c14e8b404766ff2bb8644bb19443d73965de]
mainline: [9c9ff300e0de07475796495d86f449340d454a0c]
stable/5.10: [c808edbf580bfc454671cbe66e9d7c2e938e7601]
stable/5.15: [bfe10a1d9fbccdf39f8449d62509f070d8aaaac1]
stable/6.1: [0aa7be66168b1e84b2581ffff3ccb54a6c804a1e]

CVE-2022-50647: RISC-V: Make port I/O string accessors actually work

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50647

Introduced by commit fab957c ("RISC-V: Atomic and Locking Code") in v4.15-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9cc205e3c17d5716da7ebb7fa0c985555e95d009]
stable/5.10: [2ce9fab94b8db61f014e43ddf80dd1524ae6dff4]
stable/5.15: [dc235db7b79a352d07d62e8757ad856dbf1564c1]

CVE-2022-50648: ftrace: Fix recursive locking direct_mutex in
ftrace_modify_direct_caller

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50648

Introduced by commit 53cd885 ("ftrace: Allow IPMODIFY and DIRECT ops
on the same function") in v6.0-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9d2ce78ddcee159eb6a97449e9c68b6d60b9cec4]

CVE-2022-50649: power: supply: adp5061: fix out-of-bounds read in
adp5061_get_chg_type()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50649

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected file was added by fe8e81b ("adp5061: New driver for ADP5061
I2C battery charger") in 4.19-rc1.

Fixed status
cip/4.19-st: [24a0be36e9a21f63de2e6088607e689e59ec15f4]
mainline: [9d47e01b9d807808224347935562f7043a358054]
stable/5.10: [89f305a71418591cdda18180f712f91c9820f03b]
stable/5.15: [7c8bc374659de19d846f7cab3eda9ebdb005c4cc]

CVE-2022-50650: bpf: Fix reference state management for synchronous callbacks

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50650

Introduced by commit 69c087b ("bpf: Add bpf_for_each_map_elem()
helper") in v5.13-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9d9d00ac29d0ef7ce426964de46fa6b380357d0a]
stable/5.15: [4ed5155043c97ac8912bcf67331df87c833fb067]

CVE-2022-50651: ethtool: eeprom: fix null-deref on genl_info in dump

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50651

Introduced by commit c781ff1 ("ethtool: Allow network drivers to dump
arbitrary EEPROM data") in v5.13-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9d9effca9d7d7cf6341182a7c5cabcbd6fa28063]
stable/5.15: [138a13d8f5c81266032af680f63069387f2748da]

CVE-2022-50652: uio: uio_dmem_genirq: Fix missing unlock in irq configuration

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50652

Introduced by commit b743512 ("uio: fix a sleep-in-atomic-context bug
in uio_dmem_genirq_irqcontrol()") in v5.6-rc1.
Fixed in v6.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
cip/4.19-st: [ac5585bb06a2e82177269bee93e59887ce591106]
cip/4.4-st: [7ffb5b16b572d67bcddc0e3018bd3a17f4914286]
mainline: [9de255c461d1b3f0242b3ad1450c3323a3e00b34]
stable/5.10: [9bf7a0b2b15cd12e15f7858072bd89933746de67]
stable/5.15: [79a4bdb6b9920134af1a4738a1fa36a0438cd905]
stable/6.1: [ee180e867ce4b2f744799247b81050b3e5dd62cd]

CVE-2022-50653: mmc: atmel-mci: fix return value check of mmc_add_host()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50653

Introduced by commit 7d2be07 ("atmel-mci: Driver for Atmel on-chip MMC
controllers") in v2.6.27-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [99a6cdfa2cf05028b52f6d8ee85ccc5f8b71b4a2]
mainline: [9e6e8c43726673ca2abcaac87640b9215fd72f4c]
stable/5.10: [00ac0f5f95920f003cd6ece53cdc759549b69118]
stable/5.15: [1925472dec31ec061d57412b3a65a056ea24f340]
stable/6.1: [85946ceb0fac20ab39cdb85333086daf0291a553]

CVE-2022-50654: bpf: Fix panic due to wrong pageattr of im->image

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50654

Introduced by commit 00963a2 ("bpf: Support bpf_trampoline on
functions with IPMODIFY (e.g. livepatch)") in v6.0-rc1.
Fixed in v6.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ed1d9aeef5842ecacb660fce933613b58af1e00]
stable/6.1: [7f656fff955ccb216c40fa188a24c05fa40985a5]

CVE-2022-50655: ppp: associate skb with a device at tx

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50655

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [c2a698ff156974908308f42cf5991ab5c0c4b8cd]
cip/4.4-st: [6d20a24c402a4e0c96b2910c18ae5056b570c15e]
mainline: [9f225444467b98579cf28d94f4ad053460dfdb84]
stable/5.10: [148dcbd3af039ae39c3af697a3183008c7995805]
stable/5.15: [4b8f3b939266c90f03b7cc7e26a4c28c7b64137b]
stable/6.1: [ee678b1f52f9439e930db2db3fd7e345d03e1a50]

CVE-2022-50656: nfc: pn533: Clear nfc_target before being used

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50656

Introduced by commit 673088f ("NFC: pn533: Send ATR_REQ directly for
active device detection") in v3.13-rc1.
Introduced by commit 361f3cb ("NFC: DEP link hook implementation for
pn533") in v3.3-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [bef2f478513e7367ef3b05441f6afca981de29be]
cip/4.4-st: [25542bf993ac9973c535c2d104f20fff9346b678]
mainline: [9f28157778ede0d4f183f7ab3b46995bb400abbe]
stable/5.10: [aea9e64dec2cc6cd742e07ecd4e6236fc76b389b]
stable/5.15: [aae9c24ebd901f482e6c88b6f9e0c80dc5b536d6]
stable/6.1: [e491285b4d08884b622638be8e4961eb43b0af64]

CVE-2023-53777: erofs: kill hooked chains to avoid loops on
deduplicated compressed images

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53777

Introduced by commit 267f249 ("erofs: introduce multi-reference
pclusters (fully-referenced)") in v6.0-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [967c28b23f6c89bb8eef6a046ea88afe0d7c1029]
stable/6.1: [d3b39ea24835ac03da1a30f93ae7c05d55a40191]

CVE-2023-53778: accel/qaic: Clean up integer overflow checking in
map_user_pages()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53778

Introduced by commit 129776a ("accel/qaic: Add control path") in v6.4-rc1.
Fixed in v6.5-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [96d3c1cadedb6ae2e8965e19cd12caa244afbd9c]

CVE-2023-53779: mfd: dln2: Fix memory leak in dln2_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53779

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
cip/4.19-st: [71fa6f134d13822a5dd906327de04aad8e903e49]
cip/4.4-st: [c599db23e96f959d439e17295cb2656ba5fa71ad]
mainline: [96da8f148396329ba769246cb8ceaa35f1ddfc48]
stable/5.10: [6a1a72a8cfdad6911a7167405b63545ad781fbe2]
stable/5.15: [1fa3fb4f70184254af437ccd59fd1c091a90d518]
stable/6.1: [77f43c014a770c4dcbdeed7cda6884c29382eb0f]

CVE-2023-53780: drm/amd/display: fix FCLK pstate change underflow

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53780

Introduced commit is not determined.Fixed in v6.3-rc1.
dcn32 was addedby 041a110 ("drm/amd/display: Drop FPU flags from
dcn32_clk_mgr") in 6.0-rc1.

Fixed status
mainline: [972243f973eb0821084e5833d5f7f4ed025f42da]
stable/6.1: [4bdfa48d74649898468a0bf5c8b8a48dded77b4a]

CVE-2023-53781: smc: Fix use-after-free in tcp_write_timer_handler().

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53781

Introduced by commit ac71387 ("smc: establish new socket family") in v4.11-rc1.
Fixed in v6.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9744d2bf19762703704ecba885b7ac282c02eacf]

CVE-2023-53782: dccp: Fix out of bounds access in DCCP error handler

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53782

Introduced by commit 6706a97 ("dccp: fix out of bound access in
dccp_v4_err()") in v4.9-rc6.
Introduced by commit 1aa9d1a ("ipv6: dccp: fix out of bound access in
dccp_v6_err()") in v4.9-rc6.
Fixed in v6.6-rc1.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
cip/4.19-st: [177212bf6dc1ff2d13d0409cddc5c9e81feec63d]
cip/4.4-st: [41c40691a9b9e8110293903bfc1ea6d65d17cd37]
mainline: [977ad86c2a1bcaf58f01ab98df5cc145083c489c]
stable/5.10: [4b8a938e329ae4eb54b73b0c87b5170607b038a8]
stable/5.15: [6ecf09699eb1554299aa1e7fd13e9e80f656c2f9]
stable/6.1: [f8a7f10a1dccf9868ff09342a73dce27501b86df]
stable/6.6: [977ad86c2a1bcaf58f01ab98df5cc145083c489c]

CVE-2023-53783: blk-iocost: fix divide by 0 error in calc_lcoefs()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53783

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected file was added by 7caa471 ("blkcg: implement blk-iocost") in 5.4-rc1.

Fixed status
mainline: [984af1e66b4126cf145153661cc24c213e2ec231]
stable/5.10: [6e291810fe83a384700eb24a1f714966391ed562]
stable/5.15: [3538ade9d8c2ba41088e395de916f2599fadba8f]
stable/6.1: [bf8eb1fd6110871e6232e8e7efe399276ef7e6f6]

CVE-2023-53784: drm: bridge: dw_hdmi: fix connector access for scdc

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53784

Introduced by commit 5d84409 ("drm/scdc-helper: Pimp SCDC debugs") in v6.4-rc1.
Fixed in v6.5-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98703e4e061fb8715c7613cd227e32cdfd136b23]

CVE-2023-53785: mt76: mt7921: don't assume adequate headroom for SDIO headers

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53785

Introduced commit is not determined.Fixed in v6.6-rc1.
Affected file was added by 163f4d2 ("mt76: mt7921: add MAC support")
in v5.12-rc1-dontuse.

Fixed status
mainline: [98c4d0abf5c478db1ad126ff0c187dbb84c0803c]
stable/6.1: [5c8bbb79c7cbca65534badf360f3b1145759c7bc]
stable/6.6: [98c4d0abf5c478db1ad126ff0c187dbb84c0803c]

CVE-2023-53786: dm flakey: fix a crash with invalid table line

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53786

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
cip/4.19-st: [12849ed107c0b2869fb775c81208050899006f07]
cip/4.4-st: [6c4f7992f52736a5b38b9a3c7e0f385f2238af51]
mainline: [98dba02d9a93eec11bffbb93c7c51624290702d2]
stable/5.10: [a1e3fffe02e05c05357af91364ac0fc1ed425b5b]
stable/5.15: [f76fcb9d43ec014ac4a1bb983768696d5b032df9]
stable/6.1: [cb874a190f3f7c3c3fa5b979bee7a3b8cc3a19cc]

CVE-2023-53787: regulator: da9063: fix null pointer deref with partial DT config

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53787

Introduced by commit b8717a8 ("regulator: da9063: implement setter for
voltage monitoring") in v6.4-rc1.
Fixed in v6.5-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98e2dd5f7a8be5cb2501a897e96910393a49f0ff]

CVE-2023-53788: ALSA: hda/ca0132: fixup buffer overrun at tuning_ctl_set()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53788

Introduced commit is not determined.Fixed in v6.3-rc3.


Fixed status
cip/4.19-st: [3590498117a11aa1f92a97e8a04d95320e347ebd]
cip/4.4-st: [ac6c033b1e5dc4d78afd14668bc7f266c999cfc3]
mainline: [98e5eb110095ec77cb6d775051d181edbf9cd3cf]
stable/5.10: [baef27176ea5fdc7ad0947e2dc7733855e35db71]
stable/5.15: [d23f65f08247068576a01e28b297e995b7dc3965]
stable/6.1: [32854bc91ae7debcdefdc7ae881ed83385a04792]

CVE-2023-53789: iommu/amd: Improve page fault error reporting

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53789

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
mainline: [996d120b4de2b0d6b592bd9fbbe6e244b81ab3cc]
stable/6.1: [be8301e2d5a8b95c04ae8e35d7bfee7b0f03f83a]

CVE-2023-53790: bpf: Zeroing allocated object from slab in bpf memory allocator

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53790

Introduced by commit 0fd7c5d ("bpf: Optimize call_rcu in
non-preallocated hash map.") in v6.1-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [997849c4b969034e225153f41026657def66d286]
stable/6.1: [678ea18d6240299fd77d7000c8b1d7e5f274c8af]

CVE-2023-53791: md: fix warning for holder mismatch from export_rdev()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53791

Introduced by commit a1d7671 ("md: use mddev->external to select
holder in export_rdev()") in v6.5-rc1.
Fixed in v6.6-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [99892147f028d711f9d40fefad4f33632593864c]
stable/6.6: [99892147f028d711f9d40fefad4f33632593864c]

CVE-2023-53792: nvme-core: fix memory leak in dhchap_ctrl_secret

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53792

Introduced by commit f50fff7 ("nvme: implement In-Band
authentication") in v6.0-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [99c2dcc8ffc24e210a3aa05c204d92f3ef460b05]
stable/6.1: [43d0724d756a13694f612a8a151f835ad6425b93]

CVE-2023-53793: perf tool x86: Fix perf_env memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53793

Introduced by commit f7b58cb ("perf mem/c2c: Add load store event
mappings for AMD") in v6.1-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [99d4850062a84564f36923764bb93935ef2ed108]
stable/6.1: [75d65c1cc439606ada882755fd205d13c2c7907d]

CVE-2023-53794: cifs: fix session state check in reconnect to avoid
use-after-free issue

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53794

Introduced commit is not determined.Fixed in v6.5-rc1.
Affected function was added by 53e0e11 ("CIFS: Fix a possible memory
corruption during reconnect") in 4.10-rc1.
Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [99f280700b4cc02d5f141b8d15f8e9fad0418f65]
stable/6.1: [7e4f5c3f01fb0e51ca438e43262d858daf9a0a76]

CVE-2023-53795: iommufd: IOMMUFD_DESTROY should not increase the refcount

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53795

Introduced by commit 2ff4bed ("iommufd: File descriptor, context,
kconfig and makefiles") in v6.2-rc1.
Fixed in v6.5-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [99f98a7c0d6985d5507c8130a981972e4b7b3bdc]

CVE-2023-53796: f2fs: fix information leak in f2fs_move_inline_dirents()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53796

Introduced by commit 4ec17d6 ("f2fs: avoid unneeded initializing when
converting inline dentry") in v4.3-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [a6807ef0f3b3d8508d3b07a2e35de8a91820a014]
cip/4.4-st: [33b7fb6c82333aefdd326d2a557183a58c1552e1]
mainline: [9a5571cff4ffcfc24847df9fd545cc5799ac0ee5]
stable/5.10: [00b5587326625d0fddb2a5f5a3d4acd950102ace]
stable/5.15: [117d4f6687b1f74423b5d398ea95c63b262a8e73]
stable/6.1: [f07a8d61b6ea81bb3cbe0638af40f8824d6147fd]

CVE-2023-53797: HID: wacom: Use ktime_t rather than int when dealing
with timestamps

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53797

Introduced by commit 17d793f ("HID: wacom: insert timestamp to packed
Bluetooth (BT) events") in v6.4-rc1.
Fixed in v6.5-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [9a6c0e28e215535b2938c61ded54603b4e5814c5]
stable/5.10: [9598a647ecc8f300b0540abf9d3b3439859d163b]
stable/5.15: [67ce7724637c6adb66f788677cb50b82615de0ac]
stable/6.1: [d89750b19681581796dfbe3689bbb5d439b99b24]

CVE-2023-53798: ethtool: Fix uninitialized number of lanes

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53798

Introduced by commit 012ce4d ("ethtool: Extend link modes settings
uAPI with lanes") in v5.12-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ad685dbfe7e856bbf17a7177b64676d324d6ed7]
stable/5.15: [da81af0ef8092ecacd87fac3229c29e2e0ce39fd]
stable/6.1: [942a2a0184f7bb1c1ae4bbc556559c86c054b0d2]

CVE-2023-53799: crypto: api - Use work queue in crypto_destroy_instance

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53799

Introduced by commit 6bfd480 ("[CRYPTO] api: Added spawns") in v2.6.20.16.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ae4577bc077a7e32c3c7d442c95bc76865c0f17]
stable/5.10: [625bf86bf53eb7a8ee60fb9dc45b272b77e5ce1c]
stable/5.15: [048545d9fc6424b0a11e7e8771225bb9afe09422]
stable/6.1: [c4cb61c5f976183c07d16b0071f0c60bc212ef1f]
stable/6.6: [9ae4577bc077a7e32c3c7d442c95bc76865c0f17]

CVE-2023-53800: ubi: Fix use-after-free when volume resizing failed

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53800

Introduced by commit 801c135 ("UBI: Unsorted Block Images") in v2.6.22-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [bf795ebbb9995e2fe7945de71177f01c2f1215dc]
cip/4.4-st: [0dbf94a0bcd5b3ae6bca226fd7623ccfaceb5a0b]
mainline: [9af31d6ec1a4be4caab2550096c6bd2ba8fba472]
stable/5.10: [35f8d4064e54c18424db2997059d4c0b1d13d093]
stable/5.15: [53818746e549e61841428892a8d94344494be797]
stable/6.1: [b0c951742348d216f094d16ed4f70ae73db881c0]

CVE-2023-53801: iommu/sprd: Release dma buffer to avoid memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53801

Introduced commit is not determined.Fixed in v6.4-rc1.
Affected file was added by b23e4fc ("iommu: add Unisoc IOMMU basic
driver") in 5.13-rc1.

Fixed status
mainline: [9afea57384d4ae7b2034593eac7fa76c7122762a]
stable/5.15: [92c089a931fd3939cd32318cf4f54e69e8f51a19]
stable/6.1: [8745f3592ee4a7b49ede16ddd3f12a41ecaa23c9]

CVE-2023-53802: wifi: ath9k: htc_hst: free skb in ath9k_htc_rx_msg()
if there is no callback function

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53802

Introduced by commit fb9987d ("ath9k_htc: Support for AR9271
chipset.") in v2.6.35-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [68171c006c8645a3e0293a6c3e6037c6538ac1c5]
cip/4.4-st: [b92f3607c3186ab9bfa80a95e98134df227aa114]
mainline: [9b25e3985477ac3f02eca5fc1e0cc6850a3f7e69]
stable/5.10: [ec246dfe006b2a8f36353f7489e4f525114db9a5]
stable/5.15: [c0c0614f143b568cd0e9525d53cf12e5dcd11987]
stable/6.1: [5a84e51f72580fc70066b03f3dac38421e702a0b]

CVE-2023-53803: scsi: ses: Fix slab-out-of-bounds in
ses_enclosure_data_process()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53803

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
cip/4.19-st: [9e5c7d52085b8c84bc82a261580f0eb170039325]
cip/4.4-st: [200aa32399bd19d3441c332a3212f354e29d3bda]
mainline: [9b4f5028e493cb353a5c8f5c45073eeea0303abd]
stable/5.10: [e4dd25da784b2e07dbfbf04509afa4c5a1375227]
stable/5.15: [2b28a7d261cb309912596d6a2d383ca370483527]
stable/6.1: [0dfe68394cbe1d4fe579fb325ecc813c50528c5a]

CVE-2023-53804: nilfs2: fix use-after-free bug of nilfs_root in
nilfs_evict_inode()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53804

Introduced commit is not determined.Fixed in v6.4-rc3.


Fixed status
cip/4.19-st: [2a782ea8ebd712a458466e3103e2881b4f886cb5]
cip/4.4-st: [1e6c5c794c1f925518bbc7ae9e53f0a2a654e174]
mainline: [9b5a04ac3ad9898c4745cba46ea26de74ba56a8e]
stable/5.10: [6b4205ea97901f822004e6c8d59484ccfda03faa]
stable/5.15: [b8427b8522d9ede53015ba45a9978ba68d1162f5]
stable/6.1: [acc2a40e428f12780004e1e9fce4722d88f909fd]

CVE-2023-53805: tty: n_gsm: fix UAF in gsm_cleanup_mux

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53805

Introduced by commit aa371e9 ("tty: n_gsm: fix restart handling via
CLD command") in v5.18-rc5.
Fixed in v6.5-rc4.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [9b9c8195f3f0d74a826077fc1c01b9ee74907239]
stable/5.10: [8fc0eabaa73bbd9bd705577071564616da5c8c61]
stable/5.15: [5138c228311a863c3cf937b94a3ab4c87f1f70c4]
stable/6.1: [9615ca54bc138e35353a001e8b5d4824dce72188]

CVE-2023-53806: drm/amd/display: populate subvp cmd info only for the top pipe

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53806

Introduced commit is not determined.Fixed in v6.4-rc1.
Affected file was added by 85f4bc0 ("drm/amd/display: Add SubVP
required code") in 6.0-rc1.

Fixed status
mainline: [9bb10b7aaec3b6278f9cc410c17dcaa129bbbbf0]
stable/6.1: [92e6c79acad4b96efeff261d27bdbd8089a7dd24]

CVE-2023-53807: clk: clocking-wizard: Fix Oops in clk_wzrd_register_divider()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53807

Introduced by commit 5a85372 ("staging: clocking-wizard: Add support
for dynamic reconfiguration") in v5.13-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9c632a6396505a019ea6d12b5ab45e659a542a93]
stable/5.15: [2f276dd9c0f835242836d9f6823035158ce2585c]
stable/6.1: [b35cb0c05b8dafe23ae5e8b605a91b88bcf4aba7]

CVE-2023-53808: wifi: mwifiex: fix memory leak in mwifiex_histogram_read()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53808

Introduced by commit cbf6e05 ("mwifiex: add rx histogram statistics
support") in v4.0-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [7be90670b967d11f53a9d45bc88fa8ac9daf9709]
cip/4.4-st: [f0a36c0f6588a04490f1f5bc85632138ec1258bd]
mainline: [9c8fd72a5c2a031cbc680a2990107ecd958ffcdb]
stable/5.10: [0c4240d23db525208fd40dd6371ca3254fa1b93d]
stable/5.15: [308eb3a609ac39ca9c3e466b35e8825007c8d826]
stable/6.1: [84081b4baafb49211193c6a056d5aee9c0e6ab8e]
stable/6.6: [9c8fd72a5c2a031cbc680a2990107ecd958ffcdb]

CVE-2023-53809: l2tp: Avoid possible recursive deadlock in
l2tp_tunnel_register()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53809

Introduced by commit 0b2c597 ("l2tp: close all race conditions in
l2tp_tunnel_register()") in v6.2-rc5.
Fixed in v6.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [9ca5e7ecab064f1f47da07f7c1ddf40e4bc0e5ac]
stable/5.10: [4a413d360959962995e16a899cf2b9ef53e9fcb9]
stable/5.15: [f6df58aa15f7d469f69b1dd21b001ff483255244]
stable/6.1: [4bb736b40475528ac1aa8c98b368563618488a70]

CVE-2023-53810: blk-mq: release crypto keyslot before reporting I/O complete

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53810

Introduced by commit a892c8d ("block: Inline encryption support for
blk-mq") in v5.8-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9cd1e566676bbcb8a126acd921e4e194e6339603]
stable/5.10: [874bdf43b4a7dc5463c31508f62b3e42eb237b08]
stable/5.15: [d206f79d9cd658665b37ce8134c6ec849ac7af0c]
stable/6.1: [7d206ec7a04e8545828191b6ea8b49d3ea61391f]

CVE-2023-53811: RDMA/irdma: Cap MSIX used to online CPUs + 1

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53811

Introduced by commit 44d9e52 ("RDMA/irdma: Implement device
initialization definitions") in v5.14-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9cd9842c46996ef62173c36619c746f57416bcb0]
stable/5.15: [87674a359ad173a3b8cd484e92e4f1901666da4c]
stable/6.1: [b3bd44bf20cb3a6a47aa4373e1817147efb4be04]

CVE-2023-53812: media: mediatek: vcodec: fix decoder disable pm crash

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53812

Introduced by commit ba31a5b ("media: mtk-vcodec: Remove
mtk_vcodec_release_dec_pm") in v5.18-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9d2f13fb47dcab6d094f34ecfd6a879a409722b3]
stable/6.1: [c692a44bc5146eb487f40798a1ea8dd57fd2607d]

CVE-2023-53813: ext4: fix rbtree traversal bug in ext4_mb_use_preallocated

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53813

Introduced by commit 3872778 ("ext4: Use rbtrees to manage PAs instead
of inode i_prealloc_list") in v6.4-rc1.
Fixed in v6.5-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9d3de7ee192a6a253f475197fe4d2e2af10a731f]

CVE-2023-53814: PCI: Fix dropping valid root bus resources with .end = zero

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53814

Introduced by commit 7c3855c ("PCI: Coalesce host bridge contiguous
apertures") in v5.16-rc1.
Fixed in v6.3-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [9d8ba74a181b1c81def21168795ed96cbe6f05ed]
stable/5.15: [e4af080f3ef6a65b0d702988c2471a47c9ae2cc0]
stable/6.1: [fe6a1fbe83f5b23d7db93596b793561230f06b40]

CVE-2023-53815: posix-timers: Prevent RT livelock in itimer_delete()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53815

Introduced by commit ec8f954 ("posix-timers: Use a callback for cancel
synchronization on PREEMPT_RT") in v5.4-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9d9e522010eb5685d8b53e8a24320653d9d4cbbf]
stable/5.10: [f1be1ed32daa053484222f7f9beb2b16c624dffd]
stable/5.15: [0670c4c567b27bd8f999a943028f4fe60d1a1106]
stable/6.1: [e7aff15ba29ba4b3052786b1636fa5c4aa39e179]

CVE-2023-53816: drm/amdkfd: fix potential kgd_mem UAFs

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53816

Introduced commit is not determined.Fixed in v6.3-rc3.


Fixed status
mainline: [9da050b0d9e04439d225a2ec3044af70cdfb3933]
stable/6.1: [5045360f3bb62ccd4f87202e33489f71f8bbc3fc]

CVE-2023-53817: crypto: lib/mpi - avoid null pointer deref in mpi_cmp_ui()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53817

Introduced commit is not determined.Fixed in v6.6-rc1.


Fixed status
cip/4.19-st: [ae63e84ffda74267bf7277c38415ba38389229a0]
cip/4.4-st: [74290dd01600c09a1718b3e82b848c1e21a39fd7]
mainline: [9e47a758b70167c9301d2b44d2569f86c7796f2d]
stable/5.10: [0fc7147c694394f8a8cbc19570c6bc918cac0906]
stable/5.15: [67589d247909043e94d2dd5fb590958e0f99d58d]
stable/6.1: [d3ad023a39f1127dcfd331c562673355dc078650]
stable/6.6: [9e47a758b70167c9301d2b44d2569f86c7796f2d]

CVE-2023-53818: ARM: zynq: Fix refcount leak in zynq_early_slcr_init

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53818

Introduced by commit 3329659 ("ARM: zynq: Simplify SLCR
initialization") in v4.0-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [351b7e93d02b50b2faae2d4bda28e16a8389cbb7]
cip/4.4-st: [184a4e0fe57b8426c44cdddd2ffe5c7e8a00ec3b]
mainline: [9eedb910a3be0005b88c696a8552c0d4c9937cd4]
stable/5.10: [227f8c1c5c4b3d131b66e57e58d38054f441b915]
stable/5.15: [1cc12d10d13ae5ad8d3f7432a4c0156d221fc99b]
stable/6.1: [e43a06c73be4b93d308f0df809ee0023b7c37b54]

CVE-2023-53819: amdgpu: validate offset_in_bo of drm_amdgpu_gem_va

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53819

Introduced by commit 9f7eb53 ("drm/amdgpu: actually use the VM map
parameters") in v4.2-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [82aace80cfaab778245bd2f9e31b67953725e4d0]
mainline: [9f0bcf49e9895cb005d78b33a5eebfa11711b425]
stable/5.10: [968e27fd037ec4732068820a9b9836eccc0e0a12]
stable/5.15: [4300a47e4017c9febb60ffa7d39723eeaed00f2b]
stable/6.1: [b10db1d2137415e5e7f9706d96cfe77539c499d4]

CVE-2022-50657: riscv: mm: add missing memcpy in kasan_init

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50657

Introduced by commit 8fbdccd ("riscv: mm: Support kasan for sv57") in v5.18-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f2ac64d6ca60db99132e08628ac2899f956a0ec]

CVE-2022-50658: cpufreq: qcom: fix memory leak in error path

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50658

Introduced by commit a8811ec ("cpufreq: qcom: Add support for krait
based socs") in v5.7-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f42cf54403a42cb092636804d2628d8ecf71e75]
stable/5.10: [e55feb31df3fc78b880d6e9d4b5853f05c974833]
stable/5.15: [b5606e3ab1f7cc00d89903f4a11fe57747bb3a68]

CVE-2022-50659: hwrng: geode - Fix PCI device refcount leak

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50659

Introduced by commit ef5d862 ("[PATCH] Add Geode HW RNG driver") in v2.6.20.16.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [6b9e43c4098f1310f5b4d52121d007a219fa5d43]
cip/4.4-st: [faeaf9af85b71657ce576b738548637c4103453e]
mainline: [9f6ec8dc574efb7f4f3d7ee9cd59ae307e78f445]
stable/5.10: [aa96aff394a511cc7bb7df08d1b8504d4d97671e]
stable/5.15: [82bd423ed977847652b2048b0f8dcf049b1847a9]
stable/6.1: [19b7b85773b18457ff85a9ff4f5e2a2d4bf7ed0c]

CVE-2022-50660: wifi: ipw2200: fix memory leak in ipw_wdev_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50660

Introduced by commit a3caa99 ("libipw: initiate cfg80211 API
conversion (v2)") in v2.6.33-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [fb3517b92a45c8004ac26250ae041a24eb23fef1]
cip/4.4-st: [42fbe0bbe595324bb7a9a6086c1c30234aea51a3]
mainline: [9fe21dc626117fb44a8eb393713a86a620128ce3]
stable/5.10: [8a2eb9d9d0c1535bc8e22840193bff4cdcac878b]
stable/5.15: [9424ea9d557ef41d86eb40b6349ae991c3dcff89]
stable/6.1: [62ec7e8bf42f1542f966dda687c654aae81718c8]

CVE-2022-50661: seccomp: Move copy_seccomp() to no failure path.

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50661

Introduced by commit 3a15fb6 ("seccomp: release filter after task is
fully dead") in v5.9-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a1140cb215fa13dcec06d12ba0c3ee105633b7c4]
stable/5.10: [d4a895e924b486f2a38463114509e1088ef4d7f5]
stable/5.15: [a31a647a3d1073a642c5bbe3457731fb353cb980]
stable/6.1: [5b81f0c6c60e35bf8153230ddfb03ebb14e17986]

CVE-2022-50662: RDMA/hns: fix memory leak in hns_roce_alloc_mr()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50662

Introduced by commit 9b2cf76 ("RDMA/hns: Optimize PBL buffer
allocation process") in v5.8-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a115aa00b18f7b8982b8f458149632caf64a862a]
stable/5.10: [164fa80330a81db67c26d10d071083941d29a510]
stable/5.15: [35f9cd060e68ff910e49bf37b1b0d336a311849a]
stable/6.1: [fc2c43bf41c89e7451fe750025ae55eb2e2a741d]

CVE-2022-50663: net: stmmac: fix possible memory leak in stmmac_dvr_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50663

Introduced by commit bba2556 ("net: stmmac: Enable RX via AF_XDP
zero-copy") in v5.13-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a137f3f27f9290933fe7e40e6dc8a445781c31a2]
stable/5.15: [96e50897029f65222ef76cfe9bc802321fcea33b]
stable/6.1: [446757787baf99b7db15cb347783c45a37bfe21f]

CVE-2022-50664: media: dvb-frontends: fix leak of memory fw

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50664

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [b4d8fd008de1774d99a5b50acc03d92a1919c3a7]
cip/4.4-st: [64e1f8236d25b0a82dc82568f6727c5dfe6ab1d3]
mainline: [a15fe8d9f1bf460a804bcf18a890bfd2cf0d5caa]
stable/5.10: [b42580c8d8aac11a66046897979cc13cfd04c541]
stable/5.15: [438cd29fec3ea09769639f6032687e0c1434dbe0]
stable/6.1: [669fb90507dbaf419aa3871bf73160e93d50487f]

CVE-2022-50665: wifi: ath11k: fix failed to find the peer with peer_id
0 when disconnected

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50665

Introduced by commit 01d2f28 ("ath11k: decode HE status tlv") in v5.18-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a20ed60bb357776301c2dad7b4a4f0db97e143e9]

CVE-2022-50666: RDMA/siw: Fix QP destroy to wait for all references dropped.

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50666

Introduced by commit 303ae1c ("rdma/siw: application interface") in v5.3-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3c278807a459e6f50afee6971cabe74cccfb490]
stable/5.15: [5c75d608fad58301b63e7d69200c13c3a1d411da]

CVE-2022-50667: drm/vmwgfx: Fix memory leak in vmw_mksstat_add_ioctl()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50667

Introduced by commit 7a7a933 ("drm/vmwgfx: Introduce VMware
mks-guest-stats") in v5.15-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a40c7f61d12fbd1e785e59140b9efd57127c0c33]
stable/5.15: [b47a37ad4a444d82f9caf153a79d090b79786ebb]

CVE-2022-50668: ext4: fix deadlock due to mbcache entry corruption

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50668

Introduced by commit 6048c64 ("mbcache: add reusable flag to cache
entries") in v4.6-rc1.
Introduced by commit 65f8b80 ("ext4: fix race when reusing xattr
blocks") in v6.0-rc1.
Fixed in v6.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
cip/4.19-st: [efaa0ca678f56d47316a08030b2515678cebbc50]
mainline: [a44e84a9b7764c72896f7241a0ec9ac7e7ef38dd]
stable/5.10: [1be16a0c2f10186df505e28b0cc92d7f3366e2a8]
stable/5.15: [5bc0b2fda4b47c86278f7c6d30c211f425bf51cf]
stable/6.1: [cc1538c693d25e282bed8c54b65c914a04023a78]

CVE-2022-50669: misc: ocxl: fix possible name leak in ocxl_file_register_afu()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50669

Introduced by commit 75ca758 ("ocxl: Create a clear delineation
between ocxl backend & frontend") in v5.2-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a4cb1004aeed2ab893a058fad00a5b41a12c4691]
stable/5.10: [7525741cb302a1672b8c3a5edb2a08e4229b5c7c]
stable/5.15: [3299983a6bf628249ac650908e62d12de959341e]
stable/6.1: [2fce8b3583d1641a1716486f408478b58e96ec91]

CVE-2022-50670: mmc: omap_hsmmc: fix return value check of mmc_add_host()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50670

Introduced by commit a45c6cb ("[ARM] 5369/1: omap mmc: Add new omap
hsmmc controller for 2430 and 34xx, v3") in v2.6.29-rc3.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a525cad241c339ca00bf7ebf03c5180f2a9b767c]
stable/5.10: [fb3d596267a98813a7a8206097d8d46c98505a0d]
stable/5.15: [62005dfcc396424db3337a1dc3ab49623537f5e5]
stable/6.1: [4e1dc24bcfc8257f24c0663badec7e4f3ae80558]

CVE-2022-50671: RDMA/rxe: Fix "kernel NULL pointer dereference" error

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50671

Introduced by commit 8700e3e ("Soft RoCE driver") in v4.8-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [9c5dd6993c794703e74c6ba17ac78ca0211ef940]
mainline: [a625ca30eff806395175ebad3ac1399014bdb280]
stable/5.10: [cdce36a88def550773142a34ef727a830cad96a8]
stable/5.15: [f2f405af70e6f0419e718d23fa304798a5405c41]

CVE-2022-50672: mailbox: zynq-ipi: fix error handling while
device_register() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50672

Introduced by commit 4981b82 ("mailbox: ZynqMP IPI mailbox
controller") in v5.1-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a6792a0cdef0b1c2d77920246283a72537e60e94]
stable/5.10: [a39b4de0804f9fe0ae911b359ffd4afe7d9d933b]
stable/5.15: [4f05d8e2fb3ab702c2633a74571e1b31cb579985]
stable/6.1: [3fcf079958c00d83c51e4f250abf2c77fe9cc1b9]

CVE-2022-50673: ext4: fix use-after-free in ext4_orphan_cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50673

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [7f801a1593cb957f73659732836b2dafbdfc7709]
mainline: [a71248b1accb2b42e4980afef4fa4a27fa0e36f5]
stable/5.10: [7223d5e75f26352354ea2c0ccf8b579821b52adf]
stable/5.15: [cf0e0817b0f925b70d101d7014ea81b7094e1159]
stable/6.1: [7908b8a541b1578cc61b4da7f19b604a931441da]

CVE-2022-50674: riscv: vdso: fix NULL deference in vdso_join_timens() when vfork

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50674

Introduced by commit 3092eb4 ("riscv: compat: vdso: Add setup
additional pages implementation") in v5.19-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a8616d2dc193b6becc36b5f3cfeaa9ac7a5762f9]

CVE-2022-50675: arm64: mte: Avoid setting PG_mte_tagged if no tags
cleared or restored

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50675

Introduced by commit 69e3b84 ("arm64: mte: Sync tags for pages where
PTE is untagged") in v5.14-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a8e5e5146ad08d794c58252bab00b261045ef16d]
stable/5.15: [918002bdbe4328c8c0164a22e8ebf2384b80dc23]

CVE-2022-50676: net: rds: don't hold sock lock when cancelling work
from rds_tcp_reset_callbacks()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50676

Introduced by commit ac3615e ("RDS: TCP: Reduce code duplication in
rds_tcp_reset_callbacks()") in v4.8-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e3cb25d3ad08f5dbd53ce2b31720cad529944322]
mainline: [a91b750fd6629354460282bbf5146c01b05c4859]
stable/5.10: [da349221c4d2d4ac5f606c1c3b36d4ef0b3e6a0c]
stable/5.15: [30bfa5aa7228eb1e67663d67e553627e572cc717]

CVE-2022-50677: ipmi: fix use after free in _ipmi_destroy_user()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50677

Introduced by commit cbb7986 ("ipmi: Don't allow device module unload
when in use") in v5.5-rc1.
Fixed in v6.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
cip/4.19-st: [35ad87bfe330f7ef6a19f772223c63296d643172]
mainline: [a92ce570c81dc0feaeb12a429b4bc65686d17967]
stable/5.10: [f29d127b372e1b7662397d92341d9f7de198ff99]
stable/5.15: [bfce073089cb81482521c65061835aaa6d1a6cc0]
stable/6.1: [1fc9b20a7688000fcf4d7fbaa58e415a3cdda961]

CVE-2022-50678: wifi: brcmfmac: fix invalid address access when
enabling SCAN log level

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50678

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected code was added by efc2c1f ("brcmfmac: add support
multi-scheduled scan") in 4.13-rc1.

Fixed status
cip/4.19-st: [1c12d47a9017a7745585b57b9b0fdc0d8c50978e]
mainline: [aa666b68e73fc06d83c070d96180b9010cf5a960]
stable/5.10: [50e45034c5802cedbf5b707364ea76ace29ad984]
stable/5.15: [75995ce1c926ee87bf93d58977c766b4e7744715]

CVE-2022-50679: i40e: Fix DMA mappings leak

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50679

Introduced by commit be1222b ("i40e: Separate kernel allocated rx_bi
rings from AF_XDP rings") in v5.8-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aae425efdfd1b1d8452260a3cb49344ebf20b1f5]
stable/5.10: [ed5baf3d0a33caaca4cd4073ebb0854cc77a616d]
stable/5.15: [94a171c982b8a8137a00721c1e62bc2713435bca]

CVE-2023-53820: loop: loop_set_status_from_info() check before assignment

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53820

Introduced by commit c490a0b ("loop: Check for overflow while
configuring loop") in v6.0-rc3.
Fixed in v6.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
cip/4.19-st: [832580af82ace363205039a8e7c4ef04552ccc1a]
mainline: [9f6ad5d533d1c71e51bdd06a5712c4fbc8768dfa]
stable/5.10: [c79a924ed6afac1708dfd370ba66bcf6a852ced6]
stable/5.15: [3e7d0968203d668af6036b9f9199c7b62c8a3581]
stable/6.1: [4be26d553a3f1d4f54f25353d1496c562002126d]

CVE-2023-53821: ip6_vti: fix slab-use-after-free in decode_session6

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53821

Introduced by commit f855691 ("xfrm6: Fix the nexthdr offset in
_decode_session6.") in v3.19-rc7.
Fixed in v6.5-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [fa6c6c04f6c9b21b315023f487e5a07ae7fcf647]
cip/4.4-st: [e2a0c217a0147edd7cd24767d42c9ff9e5bbaf63]
mainline: [9fd41f1ba638938c9a1195d09bc6fa3be2712f25]
stable/5.10: [ec23b25e5687dbd644c0f57bcb6af22dd5a6dd36]
stable/5.15: [a1639a82ce14af76b6419778d343ccbff86ee626]
stable/6.1: [55ad2309205cc00c585344374c7472420e1b2c12]

CVE-2023-53822: wifi: ath11k: Ignore frags from uninitialized peer in dp.

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53822

Introduced commit is not determined.Fixed in v6.4-rc1.
The ath11k driver was introduced by d5c6515 ("ath11k: driver for
Qualcomm IEEE 802.11ax devices") in 5.6-rc1.

Fixed status
mainline: [a06bfb3c9f69f303692cdae87bc0899d2ae8b2a6]
stable/6.1: [e78526a06b53718bfc1dfff37864c7760e41f8ec]

CVE-2023-53823: block/rq_qos: protect rq_qos apis with a new lock

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53823

Introduced by commit 50e34d7 ("block: disable the elevator int
del_gendisk") in v5.19-rc4.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a13bd91be22318768d55470cbc0b0f4488ef9edf]

CVE-2023-53824: netlink: annotate lockless accesses to nlk->max_recvmsg_len

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53824

Introduced by commit 9063e21 ("netlink: autosize skb lengthes") in v3.15-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a1865f2e7d10dde00d35a2122b38d2e469ae67ed]
stable/5.10: [05c9e3fc93b02d18c3ab258d43350a6d44b40bbd]
stable/5.15: [7cff4103be7c402ecc3e7bf8f95a64089e3c91b8]
stable/6.1: [e3bcf2a77060bea4d8d09cb09d92c7056f07df5a]

CVE-2023-53825: kcm: Fix error handling for SOCK_DGRAM in kcm_sendmsg().

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53825

Introduced by commit c821a88 ("kcm: Fix memory leak in error path of
kcm_sendmsg()") in v6.6-rc2.
Introduced by commit ab7ac4e ("kcm: Kernel Connection Multiplexor
module") in v4.6-rc1.
Fixed in v6.6-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
cip/4.19-st: [d4b8f380b0a041ee6a84fdac14127d8fe1dcad7b]
mainline: [a22730b1b4bf437c6bbfdeff5feddf54be4aeada]
stable/5.10: [2e18493c421428a936946c452461b8e979088f17]
stable/5.15: [55d2e7c1ab8eaa7b62575b8a4194132795d1f9fc]
stable/6.1: [e5b28ce127a690f3acc49a6a342e6c9442c9edd6]
stable/6.6: [a22730b1b4bf437c6bbfdeff5feddf54be4aeada]

CVE-2023-53826: ubi: Fix UAF wear-leveling entry in eraseblk_count_seq_show()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53826

Introduced by commit 7bccd12 ("ubi: Add debugfs file for tracking PEB
state") in v4.12-rc1.
Introduced by commit 801c135 ("UBI: Unsorted Block Images") in v2.6.22-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [84250da1c63cb7d421a3b4812b5c2ce2e47d31a1]
cip/4.4-st: [d05b1d139d5b7a6978301f15b17a5638a750680f]
mainline: [a240bc5c43130c6aa50831d7caaa02a1d84e1bce]
stable/5.10: [9d448dd6bcb61a508204b57ea1f454ba9bac2f24]
stable/5.15: [79548ccdd992707879b4b683b7251c58ddf26f12]
stable/6.1: [84253f3c2dad6be10d30c92626c763d9a9f512ad]

CVE-2023-53827: Bluetooth: L2CAP: Fix use-after-free in
l2cap_disconnect_{req,rsp}

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53827

Introduced commit is not determined.Fixed in v6.3-rc7.


Fixed status
cip/4.19-st: [1351551aa9058e07a20a27a158270cf84fcde621]
cip/4.4-st: [bf858012816fadfaf2ea8e4c2dac3952f680df8c]
mainline: [a2a9339e1c9deb7e1e079e12e27a0265aea8421a]
stable/5.10: [d9ba36c22a7bb09d6bac4cc2f243eff05da53f43]
stable/5.15: [ac6725a634f7e8c0330610a8527f20c730b61115]
stable/6.1: [348d446762e7c70778df8bafbdf3fa0df2123f58]

CVE-2023-53828: Bluetooth: hci_sync: Avoid use-after-free in dbg for
hci_add_adv_monitor()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53828

Introduced by commit b747a83 ("Bluetooth: hci_sync: Refactor add Adv
Monitor") in v6.0-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a2bcd2b63271a93a695fabbfbf459c603d956d48]
stable/6.1: [81d8e9f59df63b8358751c1ffed9f1cf5c796909]
stable/6.6: [a2bcd2b63271a93a695fabbfbf459c603d956d48]

CVE-2023-53829: f2fs: flush inode if atomic file is aborted

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53829

Introduced commit is not determined.Fixed in v6.6-rc1.


Fixed status
mainline: [a3ab55746612247ce3dcaac6de66f5ffc055b9df]
stable/6.1: [1c64dbe8fa3552a340bca6d7fa09468c16ed2a85]
stable/6.6: [a3ab55746612247ce3dcaac6de66f5ffc055b9df]

CVE-2023-53830: platform/x86: think-lmi: Fix memory leak when showing
current settings

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53830

Introduced by commit 0fdf10e ("platform/x86: think-lmi: Split
current_value to reflect only the value") in v5.14-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3c4c053014585dcf20f4df954791b74d8a8afcd]
stable/5.15: [b9396d991abe8d1ac31a043274ab20b49f92c2e6]
stable/6.1: [9071525bfcb1f5674117dbed3eca0cd7b122813b]

CVE-2023-53831: net: read sk->sk_family once in sk_mc_loop()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53831

Introduced by commit 7ad6848 ("ip: fix mc_loop checks for tunnels with
multicast outer addresses") in v2.6.33-rc4.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e918d0211ffbaf039447334c3460cafee1ce0157]
cip/4.4-st: [29151b0b343c39d3a765ad424366e23e3734d0dd]
mainline: [a3e0fdf71bbe031de845e8e08ed7fba49f9c702c]
stable/5.10: [895dc4c47171a20035cdaa8d74c1c1e97f2fc974]
stable/5.15: [ed4e0adfa407ab65dd73b8862ebf2f308a0349d2]
stable/6.1: [9036b6342fcdab190d6edce3dd447859c1de90fc]
stable/6.6: [a3e0fdf71bbe031de845e8e08ed7fba49f9c702c]

CVE-2023-53832: md/raid10: fix null-ptr-deref in raid10_sync_request

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53832

Introduced by commit 7e83ccb ("md/raid10: Allow skipping recovery when
clean arrays are assembled") in v3.10-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [38d33593260536840b49fd1dcac9aedfd14a9d42]
mainline: [a405c6f0229526160aa3f177f65e20c86fce84c5]
stable/5.10: [bdbf104b1c91fbf38f82c522ebf75429f094292a]
stable/5.15: [68695084077e3de9d3e94e09238ace2b6f246446]
stable/6.1: [b50fd1c3d9d0175aa29ff2706ef36cc178bc356a]

CVE-2023-53833: drm/i915: Fix NULL ptr deref by checking new_crtc_state

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53833

Introduced by commit 74a75dc ("drm/i915/display: move plane
prepare/cleanup to intel_atomic_plane.c") in v5.16-rc1.
Fixed in v6.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a41d985902c153c31c616fe183cf2ee331e95ecb]
stable/6.1: [dbf25cc21beff4fd2e730573845a266504b21bb2]

CVE-2023-53834: iio: adc: ina2xx: avoid NULL pointer dereference on OF
device match

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53834

Introduced by commit c43a102 ("iio: ina2xx: add support for TI INA2xx
Power Monitors") in v4.5-rc1.
Fixed in v6.5-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a41e19cc0d6b6a445a4133170b90271e4a2553dc]
stable/5.15: [a8e2ae6296d56478fb98ae7f739846ed121f154f]
stable/6.1: [77b689cc27d489b75d33f1a368356d70eb0ce08c]

CVE-2023-53836: bpf, sockmap: Fix skb refcnt race after locking changes

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53836

Introduced by commit 799aa7f ("skmsg: Avoid lock_sock() in
sk_psock_backlog()") in v5.13-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a454d84ee20baf7bd7be90721b9821f73c7d23d9]
stable/5.15: [65ad600b9bde68d2d28709943ab00b51ca8f0a1d]
stable/6.1: [923877254f002ae87d441382bb1096d9e773d56d]
stable/6.6: [a454d84ee20baf7bd7be90721b9821f73c7d23d9]

CVE-2023-53837: drm/msm: fix NULL-deref on snapshot tear down

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53837

Introduced by commit 9865948 ("drm/msm: add support to take dpu
snapshot") in v5.14-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a465353b9250802f87b97123e33a17f51277f0b1]
stable/5.15: [8f0e1ad5327a3499e7f09157cb714302a856e8a4]
stable/6.1: [16e0e6fb4511c004a5a0987d5bd75d9bcfb2b175]

CVE-2023-53838: f2fs: synchronize atomic write aborts

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53838

Introduced by commit 3db1de0 ("f2fs: change the current atomic write
way") in v5.19-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a46bebd502fe1a3bd1d22f64cedd93e7e7702693]
stable/6.1: [102b82708c1523b36d421cb8687746906069bc17]

CVE-2023-53839: dccp: fix data-race around dp->dccps_mss_cache

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53839

Introduced by commit 7c65787 ("[DCCP]: Initial implementation") in v2.6.20.16.
Fixed in v6.5-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [2bdc7f272b3a110a4e1fdee6c47c8d20f9b20817]
cip/4.4-st: [4561fb67e5b89b38bc6b68c9b257808a7694342f]
mainline: [a47e598fbd8617967e49d85c49c22f9fc642704c]
stable/5.10: [6d701c95ee6463abcbb6da543060d6e444554135]
stable/5.15: [f239c9e1d98b313435481b4926e8bdd06197e4d8]
stable/6.1: [a6ddc1c774874dc704f96a99d015dc759627bba7]

CVE-2023-53840: usb: early: xhci-dbc: Fix a potential out-of-bound memory access

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53840

Introduced by commit aeb9dd1 ("usb/early: Add driver for xhci debug
capability") in v4.12-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a4a97ab3db5c081eb6e7dba91306adefb461e0bd]
stable/5.15: [e8fb0f13e45cf361fd06593d3cb2d89915cd3bd0]
stable/6.1: [351c8d8650d1ccc006255fa01f98b6c6496a02e5]

CVE-2023-53841: devlink: report devlink_port_type_warn source device

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53841

Introduced commit is not determined.Fixed in v6.5-rc1.
Affected function was added by 136bf27 ("devlink: add warning in case
driver does not set port type") in 5.3-rc1.

Fixed status
mainline: [a52305a81d6bb74b90b400dfa56455d37872fe4b]
stable/5.10: [2864cc9a1fd13666ed7fd9064dc3f2c51a85de32]
stable/5.15: [7552020e3aa8283b215ca6b3840e6f9281ee4664]
stable/6.1: [408d40c729cbe3a918a381405df769491a472122]

CVE-2023-53842: ASoC: codecs: wcd-mbhc-v2: fix resource leaks on
component remove

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53842

Introduced by commit 0e5c9e7 ("ASoC: codecs: wcd: add multi button
Headset detection support") in v5.14-rc1.
Fixed in v6.5-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a5475829adcc600bc69ee9ff7c9e3e43fb4f8d30]
stable/5.15: [90ab6446eb522e31421b77bf8f45714f5668f9a3]
stable/6.1: [17feff71d06c96dea1fa72451c20d411e9d5ac8f]

CVE-2023-53843: net: openvswitch: reject negative ifindex

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53843

Introduced by commit 54c4ef3 ("openvswitch: allow specifying ifindex
of new interfaces") in v6.1-rc1.
Fixed in v6.5-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a552bfa16bab4ce901ee721346a28c4e483f4066]
stable/6.1: [c965a58376146dcfdda186819462e8eb3aadef3a]

CVE-2023-53844: drm/ttm: Don't leak a resource on swapout move error

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53844

Introduced by commit bfa3357 ("drm/ttm: allocate resource object
instead of embedding it v2") in v5.14-rc1.
Fixed in v6.5-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a590f03d8de7c4cb7ce4916dc7f2fd10711faabe]
stable/5.15: [af4e0ce2af8a8f0ff3b89702a1e18d8ec2c4a834]
stable/6.1: [f037f6038736bd038ddb9c72de979a08cc1ee3b5]

CVE-2023-53845: nilfs2: fix infinite loop in nilfs_mdt_get_block()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53845

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
cip/4.19-st: [d536f9976bb04e9c84cf80045a9355975e418f41]
cip/4.4-st: [1ee19b6c70c04cd917c3d349b37a4b0af01bb884]
mainline: [a6a491c048882e7e424d407d32cba0b52d9ef2bf]
stable/5.10: [8a89d36a07afe1ed4564df51fefa2bb556c85412]
stable/5.15: [8d07d9119642ba43d21f8ba64d51d01931096b20]
stable/6.1: [25457d07c8146e57d28906c663def033dc425af6]

CVE-2023-53846: f2fs: fix to do sanity check on direct node in truncate_dnode()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53846

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
mainline: [a6ec83786ab9f13f25fb18166dee908845713a95]
stable/6.1: [a78a8bcdc26de5ef3a0ee27c9c6c512e54a6051c]

CVE-2023-53847: usb-storage: alauda: Fix uninit-value in alauda_check_media()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53847

Introduced by commit e80b0fa ("[PATCH] USB Storage: add alauda
support") in v2.6.20.16.
Fixed in v6.5-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [49d380bcd6cba987c6085fae6464c9c087e8d9a0]
cip/4.4-st: [d9666793ed06d0c83f714d8082fb9047aa1099e6]
mainline: [a6ff6e7a9dd69364547751db0f626a10a6d628d2]
stable/5.10: [fe7c3a445d22783d27fe8bd0521a8aab1eb9da65]
stable/5.15: [7a11d1e2625bdb2346f6586773b20b20977278ac]
stable/6.1: [0d2d5282d39aed6f27dfe1ed60a5f3934ebd21cd]

CVE-2023-53848: md/raid5-cache: fix a deadlock in r5l_exit_log()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53848

Introduced by commit b13015a ("md/raid5-cache: Clear conf->log after
finishing work") in v6.0-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a705b11b358dee677aad80630e7608b2d5f56691]
stable/6.1: [ac9e103f282a7854f3274ef5ff0742fbbe8d7d6b]
stable/6.6: [a705b11b358dee677aad80630e7608b2d5f56691]

CVE-2023-53849: drm/msm: fix workqueue leak on bind errors

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53849

Introduced by commit 060530f ("drm/msm: use componentised device
support") in v3.15-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a75b49db6529b2af049eafd938fae888451c3685]
stable/6.1: [6e1476225ec02eeebc4b79f793506f80bc4bca8f]

CVE-2023-53850: iavf: use internal state to free traffic IRQs

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53850

Introduced by commit 5b36e8d ("i40evf: Enable VF to request an
alternate queue allocation") in v4.15-rc1.
Fixed in v6.5-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a77ed5c5b768e9649be240a2d864e5cd9c6a2015]
stable/6.1: [6d9d01689b82ff5cb8f8d2a82717d7997bc0bfff]

CVE-2023-53851: drm/msm/dp: Drop aux devices together with DP controller

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53851

Introduced by commit 2b57f72 ("drm/msm/dp: fix aux-bus EP lifetime")
in v6.1-rc3.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a7bfb2ad2184a1fba78be35209b6019aa8cc8d4d]

CVE-2023-53852: nvme-core: fix memory leak in dhchap_secret_store

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53852

Introduced by commit f50fff7 ("nvme: implement In-Band
authentication") in v6.0-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a836ca33c5b07d34dd5347af9f64d25651d12674]
stable/6.1: [2e9b141307554521d60fecf6bf1d2edc8dd0181d]

CVE-2023-53853: netlink: annotate accesses to nlk->cb_running

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53853

Introduced by commit 16b304f ("netlink: Eliminate kmalloc in netlink
dump operation.") in v3.12-rc1.
Fixed in v6.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [840a647499b093621167de56ffa8756dfc69f242]
cip/4.4-st: [865113f152bd03c1257aadecc1a0839d6fde45ed]
mainline: [a939d14919b799e6fff8a9c80296ca229ba2f8a4]
stable/5.10: [f92557f79a60cb142258f5fa7194f327573fadd8]
stable/5.15: [1d5c8b01f1df0461256a6d75854ed806f50645a3]
stable/6.1: [a115dadf8995b1730c36c474401d97355705cb88]

CVE-2023-53854: ASoC: mediatek: mt8186: Fix use-after-free in driver remove path

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53854

Introduced by commit 55b423d ("ASoC: mediatek: mt8186: support audio
clock control in platform driver") in v6.0-rc1.
Fixed in v6.4-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a93d2afd3f77a7331271a0f25c6a11003db69b3c]
stable/6.1: [3e56a1c04882852e3e7d6c59756a16211ebbc457]

CVE-2023-53855: net: dsa: ocelot: call dsa_tag_8021q_unregister()
under rtnl_lock() on driver remove

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53855

Introduced by commit 7c83a7c ("net: dsa: add a second tagger for
Ocelot switches based on tag_8021q") in v5.12-rc1.
Fixed in v6.5-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a94c16a2fda010866b8858a386a8bfbeba4f72c5]
stable/6.1: [758dbcfb257e1aee0a310bae789c2af6ffe35d0f]

CVE-2023-53856: of: overlay: Call of_changeset_init() early

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53856

Introduced by commit f948d6d ("of: overlay: avoid race condition
between applying multiple overlays") in v4.15-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a9515ff4fb142b690a0d2b58782b15903b990dba]
stable/5.15: [01bb96ad38089f5cc6de7746dac13437d35eb1dc]
stable/6.1: [3fb210cd521c9efcb211e9f5ce40fc907200bf13]
stable/6.6: [a9515ff4fb142b690a0d2b58782b15903b990dba]

CVE-2023-53857: bpf: bpf_sk_storage: Fix invalid wait context lockdep report

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53857

Introduced by commit b00fa38 ("bpf: Enable non-atomic allocations in
local storage") in v5.18-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a96a44aba556c42b432929d37d60158aca21ad4c]
stable/6.6: [a96a44aba556c42b432929d37d60158aca21ad4c]

CVE-2023-53858: tty: serial: samsung_tty: Fix a memory leak in
s3c24xx_serial_getclk() in case of error

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53858

Introduced by commit 5f5a7a5 ("serial: samsung: switch to clkdev based
clock lookup") in v3.3-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f47e6631a8fcc6fe05b8644aa4222a60f3b0a927]
cip/4.4-st: [a69e9c1e9d4ec697fc00991a4e12b9c07cc34910]
mainline: [a9c09546e903f1068acfa38e1ee18bded7114b37]
stable/5.10: [a49e5a05121c8bc471a57b4916c5393749c24de5]
stable/5.15: [073dbbe5743779faf24f233cc95459b47c7198dd]
stable/6.1: [34f5b826dd509b76644f83094b4af7e7668a6a38]

CVE-2023-53859: s390/idle: mark arch_cpu_idle() noinstr

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53859

Introduced commit is not determined.Fixed in v6.3-rc1.
According to the commit log, arch_cpu_idle() is needed noinstr since
commit d099dbfd ("cpuidle: tracing: Warn about !rcu_is_watching()") is
merged.

Fixed status
mainline: [a9cbc1b471d291c865907542394f1c483b93a811]
stable/5.15: [49aa49952116b8fd56bfb1e8c69bce179f49bece]
stable/6.1: [611c390217106c46e24e1af3db83187339d447ea]

CVE-2023-53860: dm: don't attempt to queue IO under RCU protection

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53860

Introduced by commit 563a225 ("dm: introduce
dm_{get,put}_live_table_bio called from dm_submit_bio") in v5.19-rc1.
Fixed in v6.6-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a9ce385344f916cd1c36a33905e564f5581beae9]
stable/6.1: [d7b2abd87d1fcdb47811f90090a363e7ca15cb14]
stable/6.6: [a9ce385344f916cd1c36a33905e564f5581beae9]

CVE-2023-53861: ext4: correct grp validation in ext4_mb_good_group

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53861

Introduced by commit 5354b2a ("ext4: allow ext4_get_group_info() to
fail") in v6.4-rc2.
Fixed in v6.6-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [a9ce5993a0f5c0887c8a1b4ffa3b8046fbcfdc93]
stable/5.10: [245759d987b617d183061db6ab8886ebb5cc78e9]
stable/5.15: [3e24082f16825279054a2b8a5e668d65070bbf07]
stable/6.1: [772ca4bc1d0d21320ef2ecc0f9e4f90ea85a035d]
stable/6.6: [a9ce5993a0f5c0887c8a1b4ffa3b8046fbcfdc93]

CVE-2023-53862: hfs: fix missing hfs_bnode_get() in __hfs_bnode_create

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53862

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
cip/4.19-st: [3a9065a33988c02789722be612f7c42fb8ebbb22]
cip/4.4-st: [e14bafcd3ad0c450cc527afdb68d91fbda086391]
mainline: [a9dc087fd3c484fd1ed18c5efb290efaaf44ce03]
stable/5.10: [dc9f78b6d254427a06e568f2887b1011ef3143ef]
stable/5.15: [2cab8db14566cf6a516c1f103a60cf6b7f54b1e5]
stable/6.1: [8140cdc57bc5844cd5e1392673ec2dbf8fdc6940]

CVE-2023-53863: netlink: do not hard code device address lenth in fdb dumps

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53863

Introduced by commit d83b060 ("net: add fdb generic dump routine") in v3.5-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [c3ad49ff5c030cbe719fc4cb0ae081b8255ef4b3]
cip/4.4-st: [80ab09081ecc403627fa241500715b182a51f568]
mainline: [aa5406950726e336c5c9585b09799a734b6e77bf]
stable/5.10: [44db85c6e1a184b99a2cdf56b525ac63c4962c22]
stable/5.15: [619384319b137908d1008c92426c9daa95c06b90]
stable/6.1: [e9331c8fa4c69f09d2c71682af75586f77266e81]

CVE-2023-53864: drm/mxsfb: Disable overlay plane in
mxsfb_plane_overlay_atomic_disable()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53864

Introduced by commit cb285a5 ("drm: mxsfb: Replace
mxsfb_get_fb_paddr() with drm_fb_cma_get_gem_addr()") in v5.19-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa656d48e871a1b062e1bbf9474d8b831c35074c]
stable/6.1: [8bf2d4ca521d3acb57fc1607386e749b3cc92aaf]
stable/6.6: [aa656d48e871a1b062e1bbf9474d8b831c35074c]

CVE-2023-53865: btrfs: fix warning when putting transaction with
qgroups enabled after abort

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53865

Introduced by commit 81f7eb0 ("btrfs: destroy qgroup extent records on
transaction abort") in v5.6-rc3.
Fixed in v6.5-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa84ce8a78a1a5c10cdf9c7a5fb0c999fbc2c8d6]
stable/5.10: [d2c667cc18314c9bad3ec86ae071c0342132aa09]
stable/5.15: [c9060caab4135dd660c4676d1ea33a6e0d3fc09d]
stable/6.1: [89e994688e965813ec0a09fb30b87fb8cee06474]

CVE-2023-53866: ASoC: soc-compress: Reposition and add pcm_mutex

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53866

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
mainline: [aa9ff6a4955fdba02b54fbc4386db876603703b7]
stable/5.15: [9576b7ccc20365d27c26c494651c89360a85bbdc]
stable/6.1: [9a9942cbdb7c3f41452f7bc4a9ff9f0b45eb3651]

CVE-2025-40327: perf/core: Fix system hang caused by cpu-clock usage

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40327

Introduced by commit 18dbcbf ("perf: Fix the POLL_HUP delivery
breakage") in v6.17-rc5.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb3182ef0405ff2f6668fd3e5ff9883f60ce8801]

CVE-2025-40328: smb: client: fix potential UAF in smb2_close_cached_fid()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40328

Introduced by commit ebe98f1 ("cifs: enable caching of directories for
which a lease is held") in v6.1-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [734e99623c5b65bf2c03e35978a0b980ebc3c2f8]
stable/6.12: [065bd62412271a2d734810dd50336cae88c54427]
stable/6.6: [cb52d9c86d70298de0ab7c7953653898cbc0efd6]

CVE-2025-40329: drm/sched: Fix deadlock in drm_sched_entity_kill_jobs_cb

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40329

Introduced by commit 2fdb8a8 ("drm/scheduler: rework entity flush,
kill and fini") in v6.2-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [487df8b698345dd5a91346335f05170ed5f29d4e]
stable/6.12: [0d63031ee4a57be0252cb9a4e09ae921c75cece9]
stable/6.6: [70150b9443dddf02157d821c68abf438f55a2e8e]

CVE-2025-40330: bnxt_en: Shutdown FW DMA in bnxt_shutdown()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40330

Introduced by commit 24d694a ("bnxt_en: Allocate backing store memory
for FW trace logs") in v6.13-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc7208ca805ae6062f353a4753467d913d963bc6]

CVE-2025-40331: sctp: Prevent TOCTOU out-of-bounds write

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40331

Introduced by commit 8f840e4 ("sctp: add the sctp_diag.c file") in v4.7-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [95aef86ab231f047bb8085c70666059b58f53c09]
stable/5.10: [3006959371007fc2eae4a078f823c680fa52de1a]
stable/5.15: [72e3fea68eac8d088e44c3dd954e843478e9240e]
stable/6.1: [584307275b2048991b2e8984962189b6cc0a9b85]
stable/6.12: [2fe08fcaacb7eb019fa9c81db39b2214de216677]
stable/6.6: [c9119f243d9c0da3c3b5f577a328de3e7ffd1b42]

CVE-2025-40332: drm/amdkfd: Fix mmap write lock not release

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40332

Introduced commit is not determined.Fixed in v6.18-rc1.
Affected file was added by 42de677 ("drm/amdkfd: register svm range")
in 5.14-rc1.

Fixed status
mainline: [7574f30337e19045f03126b4c51f525b84e5049e]
stable/6.12: [e2105ba1c262dcaa9573f11844b6e1e1ca762c3f]

CVE-2025-40333: f2fs: fix infinite loop in __insert_extent_tree()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40333

Introduced commit is not determined.Fixed in v6.18-rc1.
Affected code was added by bf21acf ("f2fs: remove entire rb_entry
sharing") in 6.4-rc1.

Fixed status
mainline: [23361bd54966b437e1ed3eb1a704572f4b279e58]
stable/6.12: [c0b9951bb2668d67eb4817bb23fc109abc08c075]
stable/6.6: [765f8816d3959ef1f3f7f85e2af748594d091f40]

CVE-2025-40334: drm/amdgpu: validate userq buffer virtual address and size

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40334

Introduced commit is not determined.Fixed in v6.18-rc1.
mes_userqueue.c was added by fbf136b ("drm/amdgpu: create MES-V11
usermode queue for GFX") in 6.16-rc1. amdgpu_userq.c and
amdgpu_userq.h were added by bf33cb6 ("drm/amdgpu: add usermode queue
base code") in 6.16-rc1.

Fixed status
mainline: [9e46b8bb0539d7bc9a9e7b3072fa4f6082490392]

CVE-2025-40335: drm/amdgpu: validate userq input args

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40335

Introduced commit is not determined.Fixed in v6.18-rc1.
mes_userqueue.c was added by fbf136b ("drm/amdgpu: create MES-V11
usermode queue for GFX") in 6.16-rc1. amdgpu_userq.c was added by
bf33cb6 ("drm/amdgpu: add usermode queue base code") in 6.16-rc1.

Fixed status
mainline: [219be4711a1ba788bc2a9fafc117139d133e5fea]

CVE-2025-40336: drm/gpusvm: fix hmm_pfn_to_map_order() usage

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40336

Introduced commit is not determined.Fixed in v6.18-rc1.
Affected file was added by 99624bd ("drm/gpusvm: Add support for GPU
Shared Virtual Memory") in 6.15-rc1.

Fixed status
mainline: [c50729c68aaf93611c855752b00e49ce1fdd1558]

CVE-2025-40337: net: stmmac: Correctly handle Rx checksum offload errors

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40337

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [ee0aace5f844ef59335148875d05bec8764e71e8]
stable/6.12: [719fcdf29051f7471d5d433475af76219019d33d]
stable/6.6: [63fbe0e6413279d5ea5842e2423e351ded547683]

CVE-2025-40338: ASoC: Intel: avs: Do not share the name pointer
between components

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40338

Introduced commit is not determined.Fixed in v6.18-rc1.
Affected file was added by f1b3b320 ("ASoC: Intel: avs: Generic soc
component driver") in 5.19-rc1.

Fixed status
mainline: [4dee5c1cc439b0d5ef87f741518268ad6a95b23d]

CVE-2025-40339: drm/amdgpu: fix nullptr err of vm_handle_moved

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40339

Introduced commit is not determined.Fixed in v6.18-rc1.
Affected file was added by a46a2cd ("drm/amdgpu: Add GPUVM memory
management functions for KFD") in 4.17-rc1.

Fixed status
mainline: [859958a7faefe5b7742b7b8cdbc170713d4bf158]
stable/6.12: [47281febebe337586569aa4c5694a7511063a42e]

CVE-2025-40340: drm/xe: Fix oops in xe_gem_fault when running
core_hotunplug test.

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40340

Introduced commit is not determined.Fixed in v6.18-rc1.
Affected file was added by dd08ebf ("drm/xe: Introduce a new DRM
driver for Intel GPUs") in 6.8-rc1.

Fixed status
mainline: [1cda3c755bb7770be07d75949bb0f45fb88651f6]
stable/6.12: [99428bd6123d5676209dfb1d7a8f176cc830b665]

CVE-2025-40341: futex: Don't leak robust_list pointer on exec race

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40341

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [6b54082c3ed4dc9821cdf0edb17302355cc5bb45]
stable/6.1: [6511984d1aa1360181bcafb1ca75df7f291ef237]
stable/6.12: [3b4222494489f6d4b8705a496dab03384b7ca998]
stable/6.6: [4aced32596ead1820b7dbd8e40d30b30dc1f3ad4]

CVE-2025-40342: nvme-fc: use lock accessing port_state and rport state

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40342

Introduced commit is not determined.Fixed in v6.18-rc1.
Affected file was added by e399441 ("nvme-fabrics: Add host support
for FC transport") in 4.10-rc1.

Fixed status
mainline: [891cdbb162ccdb079cd5228ae43bdeebce8597ad]
stable/5.10: [de3d91af47bc015031e7721b100a29989f6498a5]
stable/5.15: [e8cde03de8674b05f2c5e0870729049eba517800]
stable/6.1: [4253e0a4546138a2bf9cb6acf66b32fee677fc7c]
stable/6.12: [9950af4303942081dc8c7a5fdc3688c17c7eb6c0]
stable/6.6: [25f4bf1f7979a7871974fd36c79d69ff1cf4b446]

CVE-2025-40343: nvmet-fc: avoid scheduling association deletion twice

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40343

Introduced commit is not determined.Fixed in v6.18-rc1.
Affected file was added by c534320 ("nvme-fabrics: Add target support
for FC transport") in 4.10-rc1.

Fixed status
mainline: [f2537be4f8421f6495edfa0bc284d722f253841d]
stable/5.15: [2f4852db87e25d4e226b25cb6f652fef9504360e]
stable/6.1: [85e2ce1920cb511d57aae59f0df6ff85b28bf04d]
stable/6.12: [04d17540ef51e2c291eb863ca87fd332259b2d40]
stable/6.6: [601ed47b2363c24d948d7bac0c23abc8bd459570]

CVE-2025-40344: ASoC: Intel: avs: Disable periods-elapsed work when closing PCM

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40344

Introduced by commit 0dbb186 ("ASoC: Intel: avs: Update stream status
in a separate thread") in v6.12-rc5.
Fixed in v6.18-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [845f716dc5f354c719f6fda35048b6c2eca99331]
stable/6.12: [ca6d2b7aca778afbf8c0c4b330d10cb228c14052]


* Updated CVEs

CVE-2023-24023: Bluetooth BR/EDR devices with Secure Simple Pairing
and Secure Connections
pairing in Bluetooth Core Specification 4.2 through 5.4 allow certain
man-in-the-middle attacks that force a short key length, and might lead to
discovery of the encryption key and live injection, aka BLUFFS.

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [a2cec30f0a244a603b21c405bd3b04ae0a3cd53a]
stable/5.15: [f7b814a132c5eda280cc73df205d999d27724095]

CVE-2024-37354: btrfs: fix crash on racing fsync and size-extending
write into prealloc

stable/5.15 was fixed.

Fixed status
stable/5.15: [c993fd02ba471e296ca1996f13626fc917120158]

CVE-2024-47666: scsi: pm80xx: Set phy->enable_completion only when we
wait for it

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [ddc501f4130f4baa787cb6cfa309af697179f475]
stable/5.15: [a5d954802bda1aabcba49633cd94bad91c94113f]
stable/6.1: [e23ee0cc5bded07e700553aecc333bb20c768546]

CVE-2024-57947: netfilter: nf_set_pipapo: fix initial map fill

stable/5.10 was fixed.

Fixed status
stable/5.10: [77bf0c4ab928ca4c9a99311f4f70ba0c17fecba9]

CVE-2025-21887: ovl: fix UAF in ovl_dentry_update_reval by moving
dput() in ovl_link_up

stable/5.10 was fixed.

Fixed status
stable/5.10: [f77618291836168eca99e89cd175256f928f5e64]

CVE-2025-22105: bonding: check xdp prog when set bond mode

stable/6.6 was fixed.

Fixed status
stable/6.6: [5106da73b01668a1aa5d0f352b95d2b832b5caa7]

CVE-2025-37899: ksmbd: fix use-after-free in session logoff

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [931dc8a3670f71c45c0b1379ea4e92dafbda1aca]
stable/6.6: [70ad6455139e26e85f48f95d0e21f351c1909342]

CVE-2025-38057: espintcp: fix skb leaks

stable/6.1 was fixed.

Fixed status
stable/6.1: [e2e1f50fc5ebd2826c4e8c558dc65434382d0c0b]

CVE-2025-38073: block: fix race between set_blocksize and read paths

stable/6.1 was fixed.

Fixed status
stable/6.1: [311427c9384d93ce01f6375a83f93c1c18f7cabe]

CVE-2025-38120: netfilter: nf_set_pipapo_avx2: fix initial map fill

stable/5.10 was fixed.

Fixed status
stable/5.10: [8164d0efaf370c425dc69a1e8216940d09e7de0c]

CVE-2025-38556: HID: core: Harden s32ton() against conversion to 0 bits

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [3c86548a20d7bc2861aa4de044991a327bebad1a]
stable/6.6: [810189546cb6c8f36443ed091d91f1f5d2fc2ec7]

CVE-2025-38593: Bluetooth: hci_sync: fix double free in
'hci_discovery_filter_clear()'

stable/6.1 was fixed.

Fixed status
stable/6.1: [86f3dcd1f331cfd4fd7ec88906955134ec51afbe]

CVE-2025-38678: netfilter: nf_tables: reject duplicate device on updates

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [0521e694d5b80899fba8695881a6349f9bc538cb]
stable/5.15: [4681960bc0f4f8bcc782cbf2fd205f48ad314dfd]
stable/6.1: [4ce2a0c3b8497a66cfc25fc7ca3d087258a785d2]

CVE-2025-39805: net: macb: fix unregister_netdev call order in macb_remove()

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [7351782f2fc8ac31ced52e3d4e6fa120f819a7ab]
stable/6.6: [2b9719ccad38dffad7dbdd2f39896f723f9b9011]

CVE-2025-39866: fs: writeback: fix use-after-free in __mark_inode_dirty()

stable/5.10 was fixed.

Fixed status
stable/5.10: [e2a14bbae5d8bacaa301362744a110e2be40a3a3]

CVE-2025-40040: mm/ksm: fix flag-dropping behavior in ksm_madvise

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [788e5385d0ff69cdba1cabccb9dab8d9647b9239]
stable/5.15: [b69f19244c2b6475c8a6eb72f0fb0d53509e48cd]

CVE-2025-40083: net/sched: sch_qfq: Fix null-deref in agg_dequeue

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [99fc137f178797204d36ac860dd8b31e35baa2df]
stable/5.15: [1bed56f089f09b465420bf23bb32985c305cfc28]
stable/6.1: [3c2a8994807623c7655ece205667ae2cf74940aa]

CVE-2025-40211: ACPI: video: Fix use-after-free in
acpi_video_switch_brightness()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [ba1704316492a0496c69334338ea1fdbf4c2fd34]
stable/5.15: [bc78a4f51d548c1ccc3d1967c2b394bf687c86e9]
stable/6.1: [a63a5b6fb508d78fe57ae3b159d9ef3af7ba80e9]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com


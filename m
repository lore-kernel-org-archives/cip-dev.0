Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B81CD6E60
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 23:13:55 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32860.1780528430216177538
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2026 16:13:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=nIbNp3Lk;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.169, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7dd3f176f84so1868297b3.0
        for <cip-dev@lists.cip-project.org>; Wed, 03 Jun 2026 16:13:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780528429; cv=none;
        d=google.com; s=arc-20240605;
        b=O3z5dEceMdusMAo/qCwNbFuH9rxSSgs2+DC2j392pYAWxZ/+ajql2FEWKR7jShl5uu
         SM521kVOj08pvvSqMRd20//ctw+C3bVpAIhsOGbB0whq89kr5gYo1pFdDeR+urJd8EMH
         sLKk2UVENbpqoPIu0AfHNFcnL9lcq67FLLdM5Gr2aYHFv/FE+eq05YjnzDjVyu2ueDRr
         h8LL3ofcgTRtaVQUsuucxFhZJlVDjr1od9aNNtLGfrYK9y+zkXavSVlL0lsFEPSyS6e3
         krOpWQnQZnuJXsWvpimCXAXXtU+z7GogTN/2ySVE9E7mXX4GJ7fZYBZi/OLr1HtVn0W1
         EPEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=VrtOdiFCNsu1VhAUOL79lArA099t5+qQDe5POZvOWTk=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=BGlnFk5q5yCFONZGQes3XA4FIZR65GpUjyVFVO20ibQYUsYEVsJz8q4+vGxnB6WcI9
         Qn5oS1utuksZXVgz9p2RuVfL0sEAj/DkGqtC1eI9tB/k0fAVMemykZkSq5X9Xq3dlx/c
         5IrVKYs+en1I0jg4QMcR3ZUn83ifXynYbH5TgYM05JKfsvBxMs7iVfBAUdlPjlgb5/U0
         41ARzhsduOTH9G/KkUWwSJ5NQ/Vo7ZCTpwZlVQ88xbcVrFFCdIRdkFCvANsaHZ8Ao9dF
         4aH91jGjPdr101mB+j14ubTZt/KClL/rDE1Zm/X0cLuU1uCjMiEI5cEOguFogIasVxc6
         bqRw==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1780528429; x=1781133229; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VrtOdiFCNsu1VhAUOL79lArA099t5+qQDe5POZvOWTk=;
        b=nIbNp3LkAAduNRlcm4yEudwJc4TdOnikwr8KnQOPai++kieu2u+brUEB68NBeZPqrL
         wSpSid+HY2U2ujgWBZDd05VmEPu/WcE1FJFgVUpWg+uk/3oLLdBvF9Dg9ux5SNjzzqr4
         Rm75Jnw3J+0yb18KUzwfCBj920UxCfIC2iyUMBZh7pOwwkAeDCC9wr8Sdr+LHBjDQpqo
         SP20bAhWlpD2UaQWswQ4Z6L+Lxz8cv9d1uyi1PxhAoHvaW5WYz/b2sM2BK4Y1TkpQEey
         RaH0wkeq2GpxWRB+SYBerkEgJXrkul2h88B5FvElWI4S4UVhmXV2PagEkN2zVS0YWjnj
         YdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780528429; x=1781133229;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VrtOdiFCNsu1VhAUOL79lArA099t5+qQDe5POZvOWTk=;
        b=QrSvwoMVReYsLNwj/9B0M6erRxICUJiykAal9hkJuJGGrV2ybsH6hto5k5V/xpDdkT
         bfnF6AQGjoPdJeBOjCdT9bAviYzYBGF6LgwEQ/nAptibGvmHoTC7LtF7Nz9DKy+2MEMp
         aifCVSWzCCPtgpxWT67oMEUyn0Z+QRsV+uxAGjTAwQ58KGSBCFgcYSwPqXxcrKz5boeR
         0w4XLuNie3xoeZLYOPxBFGpP/uTBcS8KOOmiUtvS3dTo1NBSRwcjvaJQXnACwOjYvVcq
         DoXQUiU4VSrbopdEQsrjVj7MJQrwJYXLcEBUJesWDstoiwGnXN2gfDYKsR0wCOYqJrUB
         Gn5w==
X-Gm-Message-State: AOJu0YwDZvR6yy7SgQOLKVa8Y+g6YLvoBvAUEJkBhhx5GtaGcDClbnzL
	GSMbN3SeeKKtL8yuUBQSQDCnzjj9GISzyRWTwwcxG9ERvii7na6u54i/OkiFlI4uQP0ry8TQHVt
	cgbEHk/fDkA1QRtNhw/v5lhHf5PXFk2BYC+nSkYWb9S5NhxSr2SjzWkaDiA==
X-Gm-Gg: Acq92OEG3YiKrqT484VjwOj9kzyhtKSAgRRmPrMA7EtFfsri7ZQdKjhBYLq6BEPun6V
	BLWZnqh03DtZjJ3QE2arYAAtLJqoSco5TAmivsaG56Y2CuPTocarF7Xm+FlLNPZG61+wCLl8fGH
	yKWfegQAJ2Cat/kvTmWVxm/157ocbwfBosPHatAcdllBrEdKEDiek+CBAPy7GqRls3UTQwpp+0T
	MrMc2wTPnynLeHZqM1E6GoAIt3S9auAb779ajLSR81Aie5fcxRKTJYmdjbG6EFgtQzcKmvd7PMI
	PdgnKyoyOEk3m92aaPdUD44DlzwV4g==
X-Received: by 2002:a05:690c:909:b0:7b9:d6b8:b9ac with SMTP id
 00721157ae682-7ea49486d96mr51175867b3.26.1780528426520; Wed, 03 Jun 2026
 16:13:46 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 4 Jun 2026 08:13:08 +0900
X-Gm-Features: AVHnY4IvzdFj400q17YaWixlzASQaO_qDSnrhkLmVpLaxAFy6M05rsOzVpqgyrk
Message-ID: <CAODzB9rtuovKbQ4qT57m=3DLzUBCZNzRU1=wtgROXR=P7qmY=Q@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Jun 2026 23:13:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23040

Hi!

It's this week's CVE report.

This week reported 172 new CVEs and 256 updated CVEs.

The CVE-2026-46243 is known as CIFSwitch.

* New CVEs
CVE-2026-46104: selinux: use sk blob accessor in socket permission helpers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46104

Introduced by commit d1d991e ("selinux: Add netlink xperm support") in
v6.13-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [032e70aff025d7c519af9ab791cd084380619263]
stable/6.18: [d350fef4bc2467fe1bce15f7a20fe60e01ce41ad]
stable/7.0: [7eca71f57f194c1638ebb7f4097d6be8fd04c101]

CVE-2026-46105: scsi: mpt3sas: Limit NVMe request size to 2 MiB

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46105

Introduced by commit 9b8b848 ("block: Increase
BLK_DEF_MAX_SECTORS_CAP") in v6.17-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [04631f55afc543d5431a2bdee7f6cc0f2c0debe7]
stable/6.18: [45dcc815fc5539e88154315f36cbcb11d3a52fc2]
stable/7.0: [e5f9824817c6358b9f9738bdb92dec9e4e794d3c]

CVE-2026-46106: eventfs: Hold eventfs_mutex and SRCU when remount walks events

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46106

Introduced by commit 340f0c7 ("eventfs: Update all the eventfs_inodes
from the events descriptor") in v6.10-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [07004a8c4b572171934390148ee48c4175c77eed]
stable/6.12: [44e64d8a432837308f4dda3ffe819f1ec092a0ba]
stable/6.18: [52b109f1b875b912d4ab2c5fdd8c322d47119d9b]
stable/6.6: [ae9cd0b46b1890040006a2fc5e905c5d6053fd02]
stable/7.0: [ed2ad73bcb0a7a6cc934097d4853b6d5124c317e]

CVE-2026-46107: dm-thin: fix metadata refcount underflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46107

Introduced by commit 3241b1d ("dm: add persistent data library") in v3.2-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [09a65adc7d8bbfce06392cb6d375468e2728ead5]
stable/5.15: [f49b41c9eb7c6ff00df27cd49cea210abbadd8ad]
stable/6.1: [f06f6aededd792a754cd677c02b3d3016d868c2c]
stable/6.12: [323d252a4a378834e4fe68298ca61cfc5dd3a460]
stable/6.18: [85311a585a26640760cd0f3349ab9f2905691044]
stable/6.6: [12161e03d33afce781f68fa11cc6060538862fad]
stable/7.0: [5ec0debbcfd43596e32c1239e993de06a704e04c]

CVE-2026-46108: ipmi:si: Return state to normal if message allocation fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46108

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [09dd798270ff582d7309f285d4aaf5dbebae01cb]
stable/5.10: [c204fab7f76a055eac346e3b1a75c6b4bb99600e]
stable/5.15: [ab48817aebe4d831f87d4da6f94f50498c130d9e]
stable/6.1: [9c6ded95ac6281e390d167637ccbde6cea2ba1ae]
stable/6.12: [88881dc1da86064f479378bc9d0a4956c3d0bb12]
stable/6.18: [bc13fce9eeec88c4950924754c3347c6dc66ff4c]
stable/6.6: [ce905b65e649eee378a0f37e8219f1d70efb3007]
stable/7.0: [ba60140d4133231b49185ac8bf6e54f318d3134e]

CVE-2026-46109: usb: ulpi: fix memory leak on ulpi_register() error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46109

Introduced by commit 01af542 ("usb: ulpi: fix double free in
ulpi_register_interface() error path") in v7.0-rc7.
Fixed in v7.1-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.12 stable/5.10 stable/5.15
stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [0b9fcab1b8608d429e5f239afb197de928d4de7d]
stable/5.10: [0c2c0c6820fe96fa4be0a0499f8d3f3321b9af6c]
stable/5.15: [f1b855c00988a9cb41134cab7cf9faedba775dd9]
stable/6.1: [7bd61ed0bf9f4f1f2673d489b3bda1555b48d054]
stable/6.12: [be2c1d825f54277472c87019e82013ac534ddc4c]
stable/6.18: [2a71e01b2cf9b4329ff67102c1bea7448c2a2d2d]
stable/6.6: [b0c0d44adb55c66663886cb6e30ee92cbb0f5385]
stable/7.0: [f30ccfc2985590b33a23a3d8bed7ca16c0af551b]

CVE-2026-46110: net: stmmac: Prevent NULL deref when RX memory exhausted

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46110

Introduced by commit b6cb454 ("net: stmmac: avoid rx queue overrun")
in v6.7-rc2.
Fixed in v7.1-rc2.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [0bb05e6adfa99a2ea1fee1125cc0953409f83ed8]
stable/6.12: [5c910f7708e3c507b037ca91ca5b09f8cfe71e65]
stable/6.18: [4af2e62cbcda575a174acd230c3f3a208135e16d]
stable/6.6: [e1c50b273298c7cd9b08b113e7a7598b531a02f5]
stable/7.0: [950cb436165aad0f8f2cd49da3cd07677465bcde]

CVE-2026-46111: Bluetooth: hci_conn: fix potential UAF in create_big_sync

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46111

Introduced by commit eca0ae4 ("Bluetooth: Add initial implementation
of BIS connections") in v6.0-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0beddb0c380bed5f5b8e61ddbe14635bb73d0b41]
stable/6.12: [1750a2df0eab61dc421a7afae74abdd239a44b85]
stable/6.18: [dc34f8d8240f25dd137dc2758ebbcc75e3779142]
stable/6.6: [6823f730bf195fc296d9edd09e2ca94bc1ff5584]
stable/7.0: [f8eaf92c57ad99358dd372580d5ff87623343a72]

CVE-2026-46112: RDMA/hns: Fix unlocked call to hns_roce_qp_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46112

Introduced by commit e088a68 ("RDMA/hns: Support rq record doorbell
for the user space") in v4.17-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c99acbc8b6c6dd526ae475a48ee1897b61072fb]
stable/5.15: [1f0a3aa8b569d010316b427238222c5d899f9618]
stable/6.1: [b6296ff2475fc95ee6ea1b528c4b385302808186]
stable/6.12: [fcf6a832c0d5b2bc5398d6996c5570d3ee7993fb]
stable/6.18: [1912f78798505dc9c637081bbddfbf1c22494c49]
stable/6.6: [fb4ae739811d467409bd07d0e36cfd4140f3d26a]
stable/7.0: [615d9d260c32bb678504ca96f29ae46f9d745155]

CVE-2026-46113: KVM: x86: Fix shadow paging use-after-free due to unexpected GFN

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46113

Introduced by commit 2032a93 ("KVM: MMU: Don't allocate gfns page for
direct mmu pages") in v2.6.36-rc1.
Introduced by commit 6aa8b73 ("kvm: userspace interface") in v2.6.20.16.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0cb2af2ea66ad8ff195c156ea690f11216285bdf]
stable/6.1: [e9d4ea13aa2b6400bb10ec64b370ba3dadcd22f0]
stable/6.12: [06c19c967b845b63172601fe459667d973b7e6b7]
stable/6.18: [738ec97b1855df6c08fe2369f798fa0b972e556b]
stable/6.6: [488e386484ec8c0e558be6e156edf34ed9f4d5c8]
stable/7.0: [14d1e55dfd2cf4711bff164a6aaaddb783552134]

CVE-2026-46114: RDMA/rxe: Reject non-8-byte ATOMIC_WRITE payloads

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46114

Introduced by commit 034e285 ("RDMA/rxe: Make responder support atomic
write on RC service") in v6.2-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1114c87aa6f195cf07da55a27b2122ae26557b26]
stable/6.12: [d415fce3fcde6d7aeea6c25362a395b905811452]
stable/6.18: [105bf79a23b85cf3a761d18a4f3e10ce88526bc1]
stable/6.6: [539cabb7b2d8ba70f55bba91db55faef11c2a6d7]
stable/7.0: [7ec1ed4747f5f99f8b797bb438c5efd36079fad5]

CVE-2026-46115: block: add pgmap check to biovec_phys_mergeable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46115

Introduced by commit 49580e6 ("block: add check when merging zone
device pages") in v6.2-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [13920e4b7b784b40cf4519ff1f0f3e513476a499]
stable/6.12: [a7f3aa8c9df3905fe820ae36b67ba56b81587574]
stable/6.18: [f17d521075325b8afc42d1baa1c28a5e9aca111f]
stable/6.6: [3d2ecbd444b01d6500671d1a582b7393943cf539]
stable/7.0: [f632dab4b841554cd6416058c61886d7db176581]

CVE-2026-46116: xfrm: defensively unhash xfrm_state lists in __xfrm_state_delete

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46116

Introduced by commit fe9f1d8 ("xfrm: add state hashtable keyed by
seq") in v5.14-rc1.
Introduced by commit 7b4dc36 ("[XFRM]: Do not add a state whose SPI is
zero to the SPI hash.") in v2.6.20.16.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [14acf9652e5690de3c7486c6db5fb8dafd0a32a3]
stable/6.12: [26edb0a3c99f9d958c212be68b21f1221614dcf0]
stable/6.18: [4980162de555cb838f1a189ce7d2cbf5d2e7b050]
stable/6.6: [b4a53add2fa8f1b5aa17d4c5686c320785fab182]
stable/7.0: [a2e2d08fb070fab4947447171f1c4e3ca5a188e5]

CVE-2026-46117: RDMA/mana: Remove user triggerable WARN_ON() in
mana_ib_create_qp_rss()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46117

Introduced by commit c15d780 ("RDMA/mana_ib: Add CQ interrupt support
for RAW QP") in v6.8-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [159f2efabc89d3f931d38f2d35876535d4abf0a3]
stable/6.12: [9cc0c6b1ba8cd5c55aef043e1384de0a8b4efa71]
stable/6.18: [9ef65af26b2a6738bf15812042e84b3112402d3a]
stable/7.0: [db991ba50087ad99fa12a2c483aa3be19671ea73]

CVE-2026-46118: pseries/papr-hvpipe: Fix null ptr deref in
papr_hvpipe_dev_create_handle()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46118

Introduced by commit 6d3789d ("papr-hvpipe: convert
papr_hvpipe_dev_create_handle() to FD_PREPARE()") in v6.19-rc1.
Fixed in v7.1-rc3.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [1b9f7aafa44f5ce852c00509104d10fd9eb0f402]
stable/6.18: [735439394dde8462f9b50566727fbe333beaadaf]
stable/7.0: [cf51bec1560f8bf115d1476f60335f9d90e110b0]

CVE-2026-46119: libceph: Fix slab-out-of-bounds access in auth message
processing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46119

According to the .vulnerable file, this bug was introduced by commit
4e7a5dc in v2.6.34-rc2.
Fixed in v7.1-rc1.
It looks as if this bug was introduced by 3c0d089 ("libceph: don't
pass result into ac->ops->handle_reply()") in v5.13.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c439de70b1c3eb3c6bffa8245c16b9fc318f114]
stable/5.15: [c2374b92c729d0388a538b3cde7b3e3b5e55ef39]
stable/6.1: [38fdf04c602d52c42c67fc1617211492753b7e8b]
stable/6.12: [408e85ee708b6aa03eeb0220ffa0915f4d407181]
stable/6.18: [b7df9fbd4869fdfe09a3f501ffd228486521e062]
stable/6.6: [2ae0afd98432536562fa8261538ae795446f0589]
stable/7.0: [8517b6c8d2c759918ba0058cb6c7e14d59643202]

CVE-2026-46120: ip6_gre: Use cached t->net in ip6erspan_changelink().

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46120

Introduced by commit 2d66503 ("net: ip6_gre: Fix ip6erspan hlen
calculation") in v4.17-rc7.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1d324c2f43f70c965f25c58cc3611c779adbe47e]
stable/5.10: [7bd0f2b162b426b343a114e1b329f0d8d14fdc6e]
stable/5.15: [01b71ff2857d3598337de11e7840a8e3ff21553c]
stable/6.1: [0fcf6731706f73494245a9c0d64f93bebf95bb51]
stable/6.12: [311fdd26eb4443d43b909cc67a10f3a5fd1b21b2]
stable/6.18: [e70cfb40c3a99b232cd42c6a6a10f0d8e039dc82]
stable/6.6: [eca62bb0569de4d43a4dac06a2092a9d4ca1d702]
stable/7.0: [cf7fc624329e76c6394653d12353e1d033adea91]

CVE-2026-46121: mm/damon/sysfs-schemes: protect memcg_path kfree()
with damon_sysfs_lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46121

Introduced by commit 4f489fe ("mm/damon/sysfs-schemes: free old
damon_sysfs_scheme_filter->memcg_path on write") in v6.16-rc4.
Fixed in v7.1-rc2.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [1e68eb96e8beb1abefd12dd22c5637795d8a877e]
stable/6.12: [c88802d0e8edd14b6cd2daf3000f99adbc4c85c5]
stable/6.18: [eafd6f5372d29b0dd213799b92c2c9c7ad31d7da]
stable/6.6: [b1e9f2d5870776347edef927f9bb3ea19b8e3abb]
stable/7.0: [baecc45ad60e621ef14d6c1e7f41ef36bbfdf910]

CVE-2026-46122: wifi: b43: enforce bounds check on firmware key index
in b43_rx()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46122

Introduced by commit e4d6b79 ("[B43]: add mac80211-based driver for
modern BCM43xx devices") in v2.6.24-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f4f78bf8549e6ac4f04fba4176854f3a6e0c332]
stable/5.10: [135cb49c9a42a02cceeac7b49ec03e267f7ed6d6]
stable/5.15: [3157ad40b084a8f3932da2641749ab45e99b933e]
stable/6.1: [765709720e6af9a178abc40244a8d1aa39ac4e71]
stable/6.12: [1e9e55cf66f0fa4799f4d86ef3aaba8e606b5c14]
stable/6.18: [d7029879bafdac2006c67553807d122283dc6cbf]
stable/6.6: [c3d7b90dc95020cd9282c4630e402fe224f7644e]
stable/7.0: [219ba67e69e49681e48c822d6eaafb5def032f34]

CVE-2026-46123: Bluetooth: virtio_bt: clamp rx length before skb_put

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46123

Introduced by commit 160fbcf ("Bluetooth: virtio_bt: Use skb_put to
set length") in v6.1-rc4.
Fixed in v7.1-rc3.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [21bd244b6de5d2fe1063c23acc93fbdd2b20d112]
stable/5.15: [4236e55b2d9d1ffd3b4bdf8ebbb86e5a0a526b4a]
stable/6.1: [fd91fa2678ab603dfb285416c1cf3843d7be1e41]
stable/6.12: [6c1730099a6fc18b183bd6c1adad3b54adcaeda9]
stable/6.18: [b40cdd1b1370d76e9e760af4490cb4a351cceead]
stable/6.6: [ed41c81d30b211a671667259c3b5feeba0e062d5]
stable/7.0: [e6b4296f170d949ebba937cf6a3f247ec9550d2c]

CVE-2026-46124: isofs: validate block number from NFS file handle in
isofs_export_iget

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46124

Introduced by commit 0405d4b ("isofs: Prevent the use of too small
fid") in v6.15-rc3.
Fixed in v7.1-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [24376458138387fb251e782e624c7776e9826796]
stable/5.10: [ee0024f5a7e3c73aa253869fae9650ae054093ca]
stable/5.15: [31dbb4ba0f719ae7774e4c0c95172c9bf81692f5]
stable/6.1: [908a76f0b1038035e6ebb4f2293ce079f92e0a02]
stable/6.12: [0a1af74ae2177bda3aee0837a0546309aa539d0d]
stable/6.18: [afbafeddf23db13fe2edb2d5c0bf4bbb13d7881b]
stable/6.6: [bb0988ed4f2e26d59bbb58f644cb3a55b7521e21]
stable/7.0: [4c721a1d9b3c4fcaf59cc9b2281e3ec5a043e1a6]

CVE-2026-46125: wifi: mac80211: remove station if connection prep fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46125

Introduced by commit 81151ce ("wifi: mac80211: support MLO
authentication/association with one link") in v6.0-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [283fc9e44ff5b5ac967439b4951b80bd4299f4e4]
stable/6.12: [afcbaed89cdc1a001b43270cbf5394bb4804270a]
stable/6.18: [9e28654f79f443bca9b29ff3ae7cf18abfba58a0]
stable/6.6: [fe75fa1ac9a92990f7fc3d34b17808fd933071b2]
stable/7.0: [1c2b72ea89882aeb948340498391e69c58d466f1]

CVE-2026-46126: RDMA/mana: Fix mana_destroy_wq_obj() cleanup in
mana_ib_create_qp_rss()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46126

Introduced by commit c15d780 ("RDMA/mana_ib: Add CQ interrupt support
for RAW QP") in v6.8-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [34ecf795692ee57c393109f4a24ccc313091e137]
stable/6.12: [8f23eb6c50f1a4bf32fc4d62cfb9fc39e8e586cf]
stable/6.18: [bb9cb36eaefa4dcb7c0d9f7a01e5c739abdd53a8]
stable/7.0: [9a05a6798177e44dfbe18393be2c1ebb89ab06fd]

CVE-2026-46127: RDMA/ocrdma: Don't NULL deref uctx on errors in
ocrdma_copy_pd_uresp()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46127

Introduced by commit fe2caef ("RDMA/ocrdma: Add driver for Emulex
OneConnect IBoE RDMA adapter") in v3.5-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [34fbf48cf3b410d2a6e8c586fa952a36331ca5ba]
stable/5.10: [b610f33c5523fe26f6dd897667fff9c7a1de5905]
stable/5.15: [443c991fbc954cc9363e963c09f404b9f281f3a2]
stable/6.1: [27b6eb1f27fda9bdd5cae028e396758cdf525845]
stable/6.12: [75fc130664ae324e7b2f9ad3630e0f175e9ca6c8]
stable/6.18: [8832626a483439e207734e027afff322ccdf726e]
stable/6.6: [e01a957561f663d3b68d2fd233a4502e3367efcd]
stable/7.0: [ec44c00a4fe1327efa35083f98b39c01cb535a51]

CVE-2026-46128: ipmi: Check event message buffer response for bad data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46128

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [36920f30e78e69df01f9691c470b6f3ba8aebf98]
stable/5.10: [cf1ef30c42a7079e5bad863cd01c52aa3a17c3ac]
stable/5.15: [474e53d4397087913a5b9c9eb90fa068da4808bf]
stable/6.1: [01f8387fa5b796f13cf50014c171f6da7abc46ea]
stable/6.12: [7f7ada72c07a83b46045ddfeee526bd9e2e3c8f0]
stable/6.18: [42432b579a594b66ac32e5e7b7c26e6bc578ec89]
stable/6.6: [2418e4b21fb1355504d095da5d5f0a210564a43d]
stable/7.0: [24269264c3d59a49eb09b10af2c75b14f2931482]

CVE-2026-46129: btrfs: fix double free in create_space_info() error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46129

Introduced by commit a11224a ("btrfs: fix memory leaks in
create_space_info() error paths") in v6.19-rc6.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [3f487be81292702a59ea9dbc4088b3360a50e837]
stable/6.1: [ae6d6e31ceb72b7697c28a528e4923c08e3c2ef5]
stable/6.12: [f414b3abbba59ef379a2b3c31f2bdd9358ed5e53]
stable/6.18: [9a060970fd7b5e1c561e4ce73cb9949e4269a738]
stable/6.6: [c2670ec4aa49ca226bce9776601e0da37502be07]
stable/7.0: [dd6ade0fdd59218d71a981ae7c937a304e49209c]

CVE-2026-46130: dm-verity-fec: fix reading parity bytes split across
blocks (take 3)

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46130

Introduced by commit 6df90c0 ("dm-verity FEC: Fix RS FEC repair for
roots unaligned to block size (take 2)") in v6.13-rc7.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [430a05cb926f6bdf53e81460a2c3a553257f3f61]
stable/7.0: [3d1b4e2d8ac0a1a1390a117f61ce0ca1c47e3bcb]

CVE-2026-46131: KVM: x86: check for nEPT/nNPT in slow flush hypercalls

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46131

Introduced by commit aee7382 ("KVM: x86: Prepare kvm_hv_flush_tlb() to
handle L2's GPAs", 2022-11-18) in v6.2-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [464af6fc2b1dcc74005b7f58ee3812b17777efee]
stable/6.12: [45fc766bc756ff1d66f8ca026a9c4f7f764adfae]
stable/6.18: [d6f4e217d663ede5becc2fd6cb612c749677387b]
stable/6.6: [971f17f5d91045404e3914029ea57c3da90179a4]
stable/7.0: [4c7f8436b19a2a3acc0cb6b6e3becd6796ae5c57]

CVE-2026-46132: net: rtnetlink: zero ifla_vf_broadcast to avoid stack
infoleak in rtnl_fill_vfinfo

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46132

Introduced by commit 75345f8 ("ipoib: show VF broadcast address") in v5.3-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b9e327991815e128ad3af75c3a04630a63ce3e0]
stable/5.10: [14271b401ec6a4bf0d88054106fc2956084717e1]
stable/5.15: [cccce3190ba4356432b9f22369b56123d3d89f0d]
stable/6.1: [a44fbb631cba646532f3948636626f81717365a7]
stable/6.12: [c5b1b92ab7eff1a6e8c507ddde6fd02fabd0cfa8]
stable/6.18: [fbe0e6197225e6a83cf113a67a4b425f8de0bcd5]
stable/6.6: [0653c0516234c8258975d268a749115fc0f0ff00]
stable/7.0: [38bcc21f52246badb3154b6158dcb381d98de011]

CVE-2026-46133: RDMA/rxe: Reject unknown opcodes before ICRC processing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46133

Introduced by commit 8700e3e ("Soft RoCE driver") in v4.8-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c6f86d85d03cdb33addce86aa69aa795ca6c47a]
stable/5.10: [318787fa7193bd79691f2ebce4e80cb6abd0faef]
stable/5.15: [6a79b1ea0fcb2c998fda6a793050f66146e9cc42]
stable/6.1: [599cfdf44c1701c581cd4a21f1e1e03f8dc3840b]
stable/6.12: [f8ee926431a7bbec2b10c1290664af2cb290b983]
stable/6.18: [006a3a5f75345c6a0dbf13fd3ee01406e93b6733]
stable/6.6: [e3dc3a2fb05f4ed49c7f20594c4c52350d032189]
stable/7.0: [6fa18025e5782afff91415fd5217b39c1e4837d7]

CVE-2026-46134: platform/chrome: cros_ec_typec: Init mutex in
Thunderbolt registration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46134

Introduced by commit 3b00be2 ("platform/chrome: cros_ec_typec:
Thunderbolt support") in v6.14-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [525cb7ba6661074c1c5cc3772bccc6afab6791ef]
stable/6.18: [23ae72e8c2f1c1d1da8cbd479320ddcfcc9c7435]
stable/7.0: [3b13d5883a097f538fccbab1c61c95546d29621f]

CVE-2026-46135: nvmet-tcp: fix race between ICReq handling and queue teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46135

Introduced commit is not determined.Fixed in v7.1-rc2.
NVMe over TCP target driver was added by 872d26a ("nvmet-tcp: add NVMe
over TCP target driver") in 5.0-rc1.

Fixed status
mainline: [5293a8882c549fab4a878bc76b0b6c951f980a61]
stable/6.12: [49891c8fe0cb43fbbe480da1cdccfbbaeb820cb3]
stable/6.18: [67e1aaf93b495c2f10bc8a5fbba575fbb7f449b6]
stable/7.0: [dcfe4d1f7960e7d1c01642318f3aae1a604f8508]

CVE-2026-46136: wifi: mt76: mt7921: fix a potential clc buffer length underflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46136

Introduced by commit fa6ad88 ("wifi: mt76: mt7921: fix country count
limitation for CLC") in v6.8-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [5373f8b19e568b5c217832b9bbef165bd2b2df14]
stable/6.1: [2a79b1a492bcfa725383b6580cd93a6862308c85]
stable/6.12: [90cc573fd2f46ddbc2c329e7814b5ba3deb7b939]
stable/6.18: [0aa63d33742b805d1a218d18d12b983cce4b2f7b]
stable/6.6: [e451c325b000b9a0081fd93bc6d103d6943d4b55]
stable/7.0: [a0111847f0b4f6023f6dd320114697514e024ba3]

CVE-2026-46137: mptcp: pm: ADD_ADDR rtx: fix potential data-race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46137

Introduced by commit 00cfd77 ("mptcp: retransmit ADD_ADDR when
timeout") in v5.10-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5cd6e0ad79d2615264f63929f8b457ad97ae550d]
stable/6.12: [6e4710d7d8782cb61af29a7e7111ddfc38b9e1a3]
stable/6.18: [2ad56e434199ca24a812bb353667aa1c3860f513]
stable/6.6: [013dcdc1961543b9a3433466bc8c79a2f4ca75b5]
stable/7.0: [cc3c0399361efaaf7ae64262eb3f70829b1189c6]

CVE-2026-46138: Bluetooth: hci_event: Fix OOB read and infinite loop
in hci_le_create_big_complete_evt

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46138

Introduced by commit a0bfde1 ("Bluetooth: ISO: Add support for
connecting multiple BISes") in v6.6-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ddb8014261137cadaf83ab5617a588d80a22586]
stable/6.12: [22559ad7654f61727fc270ee4893da9f4b70cf17]
stable/6.18: [77981a507aa0fc001dc37f0dd6631dd2042fed17]
stable/6.6: [6cb7f67bc28da787499291a562d49a084d9c90cd]
stable/7.0: [665da0baaf0396f9ed3c86ccb3955dcd0b73e774]

CVE-2026-46139: smb: client: use kzalloc to zero-initialize security
descriptor buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46139

Introduced by commit 62e7dd0 ("smb: common: change the data type of
num_aces to le16") in v6.14-rc6.
Fixed in v7.1-rc3.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [5e489c6c47a2ac15edbaca153b9348e42c1eacab]
stable/6.12: [941a1e6eb35440336913afc88a82103291956d5d]
stable/6.18: [be1ef9512a3f5a755895c24f31b334342f4aa15b]
stable/6.6: [4c3ed344a970aad51388ac3b0145b98318f0e21f]
stable/7.0: [9bdb2ca31368b7671949dfb94a5d57ffccd01edd]

CVE-2026-46140: Bluetooth: btmtk: validate WMT event SKB length before
struct access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46140

Introduced by commit d019930 ("Bluetooth: btmtk: move
btusb_mtk_hci_wmt_sync to btmtk.c") in v6.11-rc1.
Fixed in v7.1-rc3.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [634a4408c0615c523cf7531790f4f14a422b9206]
stable/6.12: [c411cf1bfde951cfa821809cf4020ba177f76e0c]
stable/6.18: [624fb79dadc1b65757986a9d0fdde5c0cf3fe179]
stable/7.0: [70d37a8b9229e394cc17ddad47e90b81d80fcd09]

CVE-2026-46141: powerpc/xive: fix kmemleak caused by incorrect chip_data lookup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46141

Introduced by commit cc0cc23 ("powerpc/xive: Untangle xive from child
interrupt controller drivers") in v6.18-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6771c54728c278bf1e4bfdab4fddbbb186e33498]
stable/6.18: [2546fb8c9acc8c7512ed4339ce2a982cb7407065]
stable/7.0: [e66ed135cdf23a318e9727dca48f98f7f6142f78]

CVE-2026-46142: net: libwx: fix VF illegal register access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46142

Introduced by commit a04ea57 ("net: libwx: fix device bus LAN ID") in v6.18-rc5.
Fixed in v7.1-rc3.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [694de316f607fe2473d52ca0707e3918e72c1562]
stable/6.12: [f6e656f7cea16b638675a2ab7d7e4cf2516c5eb0]
stable/6.18: [33c5bb50b9c40e8451e6aec4487a31d794b98d92]
stable/6.6: [d3bd8040497968f6f5470018724ef7b0df92f707]
stable/7.0: [68a007a701bc06fa426507c551ef12514f2e721d]

CVE-2026-46143: ASoC: qcom: q6apm-lpass-dai: Fix multiple graph opens

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46143

Introduced by commit be1fae6 ("ASoC: q6apm-lpass-dai: close graph on
prepare errors") in v6.10-rc6.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [69acc488aaf39d0ddf6c3cf0e47c1873d39919a2]
stable/6.1: [af9cc7c622e596455c5190e6ef53c5b40ea7a90d]
stable/6.12: [c91b7bcc70346d07f57ef03d1b9a338324e213de]
stable/6.18: [7cab9f2ad51c858263da836baebad050a1bc7914]
stable/6.6: [3141d8b00cad6d3331953c79060ccc3a0262311b]
stable/7.0: [b97493f0f42ab9d882a62466782e1900e481a9d6]

CVE-2026-46144: RDMA/mana: Fix error unwind in mana_ib_create_qp_rss()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46144

Introduced by commit 0266a17 ("RDMA/mana_ib: Add a driver for
Microsoft Azure Network Adapter") in v6.2-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6aaa978c6b6218cfac15fe1dab17c76fe229ce3f]
stable/6.12: [726af85ea4af750b2f75095e24e3cd99797344cb]
stable/6.18: [ab64c63b460bbd0521480bf90d5695783f5e66bc]
stable/6.6: [190e570cc0fc7f57eacf80d2b854ba54b4dfad6b]
stable/7.0: [30e8a2f33815d8f51b8f8b829c07af16c671cc27]

CVE-2026-46145: RDMA/mana: Validate rx_hash_key_len

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46145

Introduced by commit 0266a17 ("RDMA/mana_ib: Add a driver for
Microsoft Azure Network Adapter") in v6.2-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6dd2d4ad9c8429523b1c220c5132bd551c006425]
stable/6.12: [11c1431d641e0e4e0529e96957995820600c7287]
stable/6.18: [012796f9541fcd0c1fa8ae4da7eb4d83931ef838]
stable/6.6: [7d7c9f0fcd19c4d2f0164347c58d49cafa961b72]
stable/7.0: [7d94f155f354b961c598f71bafa804dceded513f]

CVE-2026-46146: ALSA: usb-audio: Avoid potential endless loop in
convert_chmap_v3()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46146

Introduced by commit ecfd411 ("ALSA: usb-audio: Validate UAC3 cluster
segment descriptors") in v6.17-rc2.
Fixed in v7.1-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12
stable/6.6

Fixed status
mainline: [6e7247d8f5fefeceb0bb9cc80a5388a636b219cd]
stable/5.10: [076d5d13eb9c1ad259a7f246149f6676c62285f9]
stable/5.15: [316aa0b1e3c5600eae5ab876394c1ac70e6db581]
stable/6.1: [24a40df79307ca7ca0eec0889361cf6ac146d72a]
stable/6.12: [4e0ee232ebe3df04874125d7c7f3e6c25ea5483d]
stable/6.18: [be09b47ed8677d76962e3240c145502e2ad9f3c8]
stable/6.6: [e0e3dcf48189603f3865f1a0b799b3b42baae96d]
stable/7.0: [fa5b19ce69067874b1413f3c2027563bae8c2cb3]

CVE-2026-46147: KVM: arm64: Fix pin leak and publication ordering in
__pkvm_init_vcpu()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46147

Introduced commit is not determined.Fixed in v7.1-rc2.


Fixed status
mainline: [73b9c1e5da84cd69b1a86e374e450817cd051371]
stable/6.18: [7d3c27b54253cda91dc4d2c1bfc109c490837ab9]
stable/7.0: [6d69c0ed978f7f0efd053fc98390f25ab77c1aea]

CVE-2026-46148: spi: microchip-core-qspi: control built-in cs manually

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46148

Introduced by commit 8f9cf02 ("spi: microchip-core-qspi: Add regular
transfers") in v6.17-rc1.
Introduced by commit 8596124 ("spi: microchip-core-qspi: Add support
for microchip fpga qspi controllers") in v6.1-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7672749e1496215e8683ce57cf323119033954cf]
stable/6.18: [998f43196d732f20f9b71eb6ebd973736c9fa911]
stable/7.0: [ee3c99aa102212ad59dc2c19595515c4a6729307]

CVE-2026-46149: scsi: target: configfs: Bound snprintf() return in
tg_pt_gp_members_show()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46149

Introduced by commit c66ac9d ("[SCSI] target: Add LIO target core
v4.0.0-rc6") in v2.6.38-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [772a896a56e0e3ef9424a025cec9176f9d8f4552]
stable/5.10: [d3cc9d490c207d57a289054397349f6f8c90354e]
stable/5.15: [db0a4759d62cad4ff891e2d81ae4be73bb57f4a4]
stable/6.1: [12f2201a56957ba020392223a7393a5eba080c1b]
stable/6.12: [72cc5ea7ef32bb5fa38bf0dd2e56fcd73aa8c89e]
stable/6.18: [00d91bfdce5033f5d9b4915638ae9b0553848b5d]
stable/6.6: [1f678d13e939f91840cb1ebe9b88544923539d3c]
stable/7.0: [e501154f9d82c95d2719bcbbaf679d8fd3226ef7]

CVE-2026-46150: fanotify: fix false positive on permission events

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46150

Introduced by commit abc7757 ("fsnotify: Provide framework for
dropping SRCU lock in ->handle_event") in v4.12-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7746e3bd4cc19b5092e00d32d676e329bfcb6900]
stable/5.10: [a24765332e129c1916d5a6615418b75599b8fcdc]
stable/5.15: [4a7611ad653785fcdea5ff5f4441e2b7d05b7f11]
stable/6.1: [04bb66be92f48ed13c3faf1139d892df228789bc]
stable/6.12: [f130790f1acc8399f32652846c875a251efd040f]
stable/6.18: [7baa02b0ae9d17ec5f08836d8ea88ce1927d0678]
stable/6.6: [895ebbedf88318607c24acc0f591c74b165e1d0a]
stable/7.0: [b7b24b28c8cd55844cab908f4f39dded638d5538]

CVE-2026-46151: usb: usblp: fix heap leak in IEEE 1284 device ID via
short response

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46151

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7a400c6fe3617e31e690e3f7ca37bb335e0498f3]
stable/5.10: [4650cce898fcd0bb8c33e529984687a8caed10c3]
stable/5.15: [612640abbd9e0947fe8f37aaf0cf324265d7caa4]
stable/6.1: [4220d4dd062ea3d3eb056a6cbe0b568e740d20b1]
stable/6.12: [6d8142141c942c0d8e79343cffda9c44bb1f3f4f]
stable/6.18: [8247f52d822180e94ccbfdab91613af386a4e34d]
stable/6.6: [6e29c32a27218f2dcd4a4e9b0b3c5e7728640698]
stable/7.0: [522d17e93a85575256894212d10e5a1fa6f36529]

CVE-2026-46152: wifi: mac80211: drop stray 'static' from fast-RX rx_result

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46152

Introduced by commit 3468e1e ("wifi: mac80211: add mesh fast-rx
support") in v6.4-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7a5b81e0c87a075afd572f659d8eb68c9c4cd2ba]
stable/6.12: [1739fc31b4de06c5c78ce0741182770fb079091e]
stable/6.18: [e131562d6f2b958148c35c98831b007f47f0e3d3]
stable/6.6: [03584528bfffb195e384698af9148b94e42e3f14]
stable/7.0: [3ef44f96ccc3e06e059dec57842e366f0c4b1893]

CVE-2026-46153: 8021q: delete cleared egress QoS mappings

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46153

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7dddc74af369478ba7f9bc136d0fc1dc4570cb66]
stable/7.0: [a52e122c9e4d56ad9a03b32c915a199276d989c3]

CVE-2026-46154: sched_ext: Read scx_root under scx_cgroup_ops_rwsem in
cgroup setters

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46154

Introduced by commit a5bd6ba ("sched_ext: Use cgroup_lock/unlock() to
synchronize against cgroup operations") in v6.18-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [80afd4c84bc8f5e80145ce35279f5ce53f6043db]
stable/6.18: [ce9aaa3af445c391735c9d000c4db60dfd5640d4]
stable/7.0: [0f54f6355575971673d8aac7da107ec4178e45bd]

CVE-2026-46155: smb/client: fix out-of-bounds read in smb2_compound_op()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46155

Introduced by commit ea41367 ("smb: client: introduce
SMB2_OP_QUERY_WSL_EA") in v6.9-rc1.
Fixed in v7.1-rc3.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [8d09328dfda089675e4c049f3f256064a1d1996b]
stable/6.12: [9b3af35645ff9cd334edc130249f9a2fb2bea25f]
stable/6.18: [512d33bc8ea4ea5c19728ee118715f4b1f4d1926]
stable/6.6: [dffb44b2e06a2908e249f0f93156fc987eee1d1c]
stable/7.0: [a16f70a71be4b5a4eccf39a9bf09b47285f4cb7c]

CVE-2026-46156: LoongArch: Fix potential ADE in loongson_gpu_fixup_dma_hang()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46156

Introduced by commit 95db0c9 ("LoongArch: Workaround LS2K/LS7A GPU DMA
hang bug") in v7.0-rc6.
Fixed in v7.1-rc3.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.12 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [8dfa2f8780e486d05b9a0ffce70b8f5fbd62053e]
stable/6.1: [bfde8accc3e3260c0ecbb8cc34361739e1e16f31]
stable/6.12: [2cb19b06c09983727573bbe7d7430cbad480a714]
stable/6.18: [9e1aed63a5552958ef2a9bfd699a3f990e52a77f]
stable/6.6: [07d190e4ec689d6478f7f5e36099fb9bf457e7c5]
stable/7.0: [81fef1c278436e6bd68ee4ca05a0acb96e256561]

CVE-2026-46157: ALSA: pcm: oss: Fix data race at accessing runtime.oss.trigger

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46157

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [901ac0ff15edf9503162e2cf6579bd11a30f1ed4]
stable/6.12: [49f9d048845be874df7997e4b1ce662de450c4b6]
stable/6.18: [ac3e9b55b7da6f0be51720bd330a0edc1a8b61f1]
stable/7.0: [6b01c1bc9a4748ab37548a700a8aaff910e298e6]

CVE-2026-46158: mptcp: pm: ADD_ADDR rtx: always decrease sk refcount

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46158

Introduced by commit 00cfd77 ("mptcp: retransmit ADD_ADDR when
timeout") in v5.10-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9634cb35af17019baec21ca648516ce376fa10e6]
stable/6.12: [b41dd76f3b9735096c21d3e799a2b9fe36498d57]
stable/6.18: [acd3d3562315c99f3c0db16f0fcc5f0306638982]
stable/6.6: [9426265e157dd77ec237c795901ed4dea6d69b5c]
stable/7.0: [25e37407442b8766ec2cf52fb4e31b5c3d3aeeae]

CVE-2026-46159: btrfs: fix btrfs_ioctl_space_info() slot_count TOCTOU
which can lead to info-leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46159

Introduced by commit 7fde62b ("Btrfs: buffer results in the space_info
ioctl") in v2.6.34-rc2.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [973e57c726c1f8e77259d1c8e519519f1e9aea77]
stable/6.12: [4fdc6ee0802121d9cd96b8d085e589f51e5a4ec3]
stable/6.18: [5d12e0ab009ade48c1bff9324fd9bea2c773d088]
stable/6.6: [f5ee467b56764964027c361641f64953fc0f8f9a]
stable/7.0: [d09d67d5de577cedae3de9497dff217e0ac8b641]

CVE-2026-46160: btrfs: fix missing last_unlink_trans update when
removing a directory

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46160

According to the .vulnerable file, this bug was introduced by commit
12fcfd2 in v2.6.30-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [999757231c49376cd1a37308d2c8c4c9932571e1]
stable/6.12: [aa9c3ecaf7337df3a689318584f879b5339ede0f]
stable/6.18: [fb388eb58c1ba047ccabc33901839acfecadcf49]
stable/6.6: [cc3c0a0f965754ce230d93ba44ee5b34fbe6138a]
stable/7.0: [36fcc2c7517f8a86379154c9793f867592aa8b7e]

CVE-2026-46161: md/raid10: fix divide-by-zero in setup_geo() with zero
far_copies

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46161

Introduced by commit 475901a ("MD RAID10: Improve redundancy for 'far'
and 'offset' algorithms (part 1)") in v3.9-rc2.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9aa6d860b0930e2f72795665c42c44252a558a0c]
stable/5.10: [0b43a70394ce492274e67463326be03e0a9897c5]
stable/5.15: [c716ab3034f84f8a6c226814247b8c5ac9f95da1]
stable/6.1: [553e32adfa1a96b217651139a3f8c3b92b9984ac]
stable/6.12: [9d8e03b9a2b1e8ce5c198bf3a409a629f4d02cda]
stable/6.18: [913d556e4bd1b56ed822815655b82c7bb54edc51]
stable/6.6: [4af2e558e6fdfb972c61350653fd55d1f62b60a5]
stable/7.0: [f9ddb621b2325eb69c95692958daf2bab4dea2c4]

CVE-2026-46162: ice: fix double free in ice_sf_eth_activate() error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46162

Introduced by commit 13acc5c ("ice: subfunction activation and base
devlink ops") in v6.12-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9aab1c3d7299285e2569cbc0ed5892d631a241b2]
stable/6.12: [2ca30340b5028ddc3f17086a538feeff06167b1b]
stable/6.18: [121d1f253aed515cd85748f68c664a6cb756e8ad]
stable/7.0: [d0c6a4816609f145ffcc74e64baa214c571c17c6]

CVE-2026-46163: wifi: b43legacy: enforce bounds check on firmware key
index in RX path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46163

Introduced by commit 75388ac ("[B43LEGACY]: add mac80211-based driver
for legacy BCM43xx devices") in v2.6.24-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a035766f970bde2d4298346a31a80685be5c0205]
stable/5.10: [a92bd0503df2488f2cc040f329ebccff1c1934cb]
stable/5.15: [df805c1d085b7a96077f0964185764c87060950d]
stable/6.1: [4242db36de99de734cc1f60e5edd86cda7e598c6]
stable/6.12: [6ee946077607d7783ae6709a899213fc4fe08f35]
stable/6.18: [9d1bc155802943e92c57a5fb923d23edfbf0b525]
stable/6.6: [1baaeb6adecb9691748c0253dab6ddd19a2b4e9e]
stable/7.0: [fdd4e51979f42ca8b1ab7e6176b607e1caabf2a5]

CVE-2026-46164: btrfs: fix double free in
create_space_info_sub_group() error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46164

Introduced by commit f92ee31 ("btrfs: introduce btrfs_space_info
sub-group") in v6.16-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [a7449edf96143f192606ec8647e3167e1ecbd728]
stable/6.12: [14b22be1dd844383eb03af9b1ee3b6b25d32aeaf]
stable/6.18: [dfd05a16b5c9d1d98b47905f37f2fccda52173d1]
stable/6.6: [d2a675f2e238ec96c8e91e2718c1f910c9c8fb21]
stable/7.0: [259af6857a1b4f1e9ef8b780353f9d11c26a22bd]

CVE-2026-46165: openvswitch: vport: fix self-deadlock on release of tunnel ports

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46165

Introduced by commit 6931d21 ("openvswitch: defer tunnel netdev_put to
RCU release") in v7.0-rc6.
Fixed in v7.1-rc3.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.12 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [aa69918bd418e700309fdd08509dba324fb24296]
stable/6.1: [8ae6c15fc473c9ad03b0173330cce9a092c76154]
stable/6.12: [6522d59fb7de55ce0f0f285d962243ddffebb01f]
stable/6.18: [3df75fff46b1517eb479d8e6b8e3500763715dd0]
stable/6.6: [c741433f6c8dcdecd1d9549d89053761fd1ea413]
stable/7.0: [366c482965c673565ecb8bcfb15d5548f13a6a10]

CVE-2026-46166: wifi: mac80211: use safe list iteration in radar detect work

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46166

Introduced by commit bca8bc0 ("wifi: mac80211: handle
ieee80211_radar_detected() for MLO") in v6.12-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac8eb3e18f41e2cc8492cc1d358bcb786c850270]
stable/6.12: [887ece6c23b49d02a6678e7a8d5ad213d75883ce]
stable/6.18: [7577a4b8a10fab45a6ee2045ea038a5adadbb585]
stable/7.0: [120149fb3ebcf674832ca3cafd32bedcdb686dde]

CVE-2026-46167: usb: usblp: fix uninitialized heap leak via LPGETSTATUS ioctl

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46167

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b38e53cbfb9d84732e5984fbd73e128d592415c5]
stable/5.10: [0f7c41314ebf17049917a452684db371babf711a]
stable/5.15: [cf24991619be317e2769310b4a367bf4a04b82bc]
stable/6.1: [087d97342c100138ea7d75a50977c9c2319f957b]
stable/6.12: [a502b997668401a6821501fc98b7f9220f9b6ff2]
stable/6.18: [762a6ccf391db0d629e590a803a3a2231e17dd3f]
stable/6.6: [d06d937b0a4cdb8867f04275c8100a8b943da31a]
stable/7.0: [6b0e7438e31c74b01514d31ff35c1e688c4baaba]

CVE-2026-46168: mptcp: fix scheduling with atomic in timestamp sockopt

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46168

Introduced by commit 9061f24 ("mptcp: sockopt: propagate timestamp
request to subflows") in v5.14-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b5c52908d52c6c8eb8933264aa6087a0600fd892]
stable/5.15: [0949d8bbbedbafe0136a1723c41eb823c2f1e09d]
stable/6.1: [e792cfb6aeaf65612cdf8e3ac431d65e66283654]
stable/6.12: [b157dab93a7af44a84e78cf0cb311dde475cff5b]
stable/6.18: [8a005fe451c73fd2b3d1faa5643c11e6bd07acfc]
stable/6.6: [ebeb70e29e37cfce899309cc2665a3bfe960ed94]
stable/7.0: [7eb513b42721bee4b96da69f6188d5a7783f210d]

CVE-2026-46169: hfsplus: fix uninit-value by validating catalog record size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46169

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b6b592275aeff184aa82fcf6abccd833fb71b393]
stable/6.12: [c91bbd6193c70a02c50c22e0fb1f60c3c5bd053a]
stable/6.18: [a420904450962a562ad053a41a53a27755021b48]
stable/6.6: [61a790974ff7e533acbceca06c7d02f22bf96d4d]
stable/7.0: [93e8d613f1a01b6637f387cc93f184cf7fb881d6]

CVE-2026-46170: mptcp: pm: ADD_ADDR rtx: free sk if last

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46170

Introduced by commit 00cfd77 ("mptcp: retransmit ADD_ADDR when
timeout") in v5.10-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b7b9a461569734d33d3259d58d2507adfac107ed]
stable/6.12: [531c537b8fb620beabccfb1594e8d43cbebbb87a]
stable/6.18: [b74ad20198652b6b39a761c277ba65ae82b1e107]
stable/6.6: [6a3af482188f6db4186d1605f64d911d7330abb3]
stable/7.0: [8143a224785ceaf2b0856e08d4498916f38228fb]

CVE-2026-46171: riscv: kvm: fix vector context allocation leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46171

Introduced by commit 0f4b825 ("riscv: KVM: Add vector lazy
save/restore support") in v6.5-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b7c958d7c1eb1cb9b2be7b5ee4129fcd66cec978]
stable/6.18: [bd62c0f61bc722a097417401030c596cea8e21aa]
stable/7.0: [1d57ab45ec5c0e22789de793bcf2a31ad6fb7d98]

CVE-2026-46172: ipv6: xfrm6: release dst on error in xfrm6_rcv_encap()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46172

Introduced by commit 0146dca ("xfrm: add support for UDPv6
encapsulation of ESP") in v5.8-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc0fcb9823cd0894934cf968b525c575833d7078]
stable/5.10: [a0721bcd72641c32b281f227a94505b31cf54117]
stable/5.15: [a20b34f6e854fe6f2aa82528fae7a88759919eb4]
stable/6.1: [870560015ce6e0d8f841c6a8aba33c44be52c727]
stable/6.12: [554c9b090c8ac5b1c5c507f4badf8d5d0c9c6e13]
stable/6.18: [9d5047782f9bd2829e529df69209bf3232eb561f]
stable/6.6: [c2efc4956981066df2fef1cc77391b523db6d8e4]
stable/7.0: [6a5eec0a2a0e99ec9743cf8f1c4082178811d90a]

CVE-2026-46173: exit: prevent preemption of oopsing TASK_DEAD task

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46173

Introduced by commit 7f80a2f ("exit: Stop poorly open coding
do_task_dead in make_task_dead") in v5.17-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c1fa0bb633e4a6b11e83ffc57fa5abe8ebb87891]
stable/6.1: [3d6fb8a7690c23e3213c4b008f64d89a44b98737]
stable/6.12: [7b2800ba5f5f77a8ee7f4cbadb19cf1264597a34]
stable/6.18: [6f49f94f3b11fe8bff1bf2a054143789e76aaf17]
stable/6.6: [640b4c00fb0e2920327435f6176cbefc3c546165]
stable/7.0: [9756b3db5db6c2f5eccb32dddbd88eb4c54f575e]

CVE-2026-46174: x86/CPU/AMD: Prevent improper isolation of shared
resources in Zen2's op cache

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46174

According to the .vulnerable file, this bug was introduced by commit
f7f3dc0 in v4.14-rc2.
Fixed in v7.1-rc4.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
cip/4.19-st: [3461f705cfdf325386297a27e46094efe20f0896]
mainline: [c21b90f77687075115d989e53a8ec5e2bb427ab1]
stable/5.10: [1e23b30a80b14e5764657401ee2cca030525ae8e]
stable/5.15: [f5bc3aef7df46eaaf423d7413ab8833f704ae576]
stable/6.1: [251497955f2314cd39d43191e81c6151dead4c7b]
stable/6.12: [9109489cc8c34e50d15575a3d1ff82af586bc1aa]
stable/6.18: [28f5ed477eef166d678d6966762cbc1de9b4f436]
stable/6.6: [ff6fc65b3bf73acc5ee71919154d830ad5431362]
stable/7.0: [1cd85a19748b2407830376a5cbae5c0f126016e5]

CVE-2026-46175: f2fs: fix fsck inconsistency caused by FGGC of node block

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46175

Introduced by commit da011cc ("f2fs: move node pages only in victim
section during GC") in v4.7-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c3e238bd1f56993f205ef83889d406dfeaf717a8]
stable/6.18: [8be551f538dc5b64183e27bd45a7a0795263f760]
stable/7.0: [e7c6d30169b03307d27c4479563df79c08f3a746]

CVE-2026-46176: RDMA/mlx5: Fix error path fall-through in
mlx5_ib_dev_res_srq_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46176

Introduced by commit 5895e70 ("IB/mlx5: Allocate resources just before
first QP/SRQ is created") in v6.11-rc1.
Fixed in v7.1-rc3.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [c488df06bd552bb8b6e14fa0cfd5ad986c6e9525]
stable/6.12: [bc2cf5935b4665172235341163315905197ae91d]
stable/6.18: [b087913ae88256df66620f7ba0a9776716aeef7e]
stable/6.6: [a13c2ac4d480b734342c6fbf8249fc48afd675f3]
stable/7.0: [6fd93142dd1d09000c3750af08270f5792523fe9]

CVE-2026-46177: ipmi: Add limits to event and receive message requests

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46177

Introduced commit is not determined.Fixed in v7.1-rc3.


Fixed status
mainline: [c4cca236968683eb0d59abfb12d5c7e4d8514227]
stable/5.10: [112df8e631636cafda64dcee4561daf09ce74a4a]
stable/5.15: [304b56883b7eff73eb606c35d062c8101aaf5471]
stable/6.1: [9059dc94421e1d4f8e5844204608b37ebfddb3da]
stable/6.12: [e20212b431bef217d3886b86bbc90cc3ed00de68]
stable/6.18: [3d37d2165df9504ea99d9e6181552dc4d2d1ab37]
stable/6.6: [67c44e0deba936d5edaebea356b4589eb43acb5c]
stable/7.0: [c024167fb00489baee08c72182ca2e7dc5fb9f20]

CVE-2026-46178: RDMA/mlx4: Fix resource leak on error in mlx4_ib_create_srq()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46178

Introduced by commit 225c7b1 ("IB/mlx4: Add a driver Mellanox ConnectX
InfiniBand adapters") in v2.6.22-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c54c7e4cb679c0aaa1cb489b9c3f2cd98e63a44c]
stable/5.10: [53fd4c03558672ccb167754fbacbf045c7ab335c]
stable/5.15: [0be6ae614ca7fa53e7389e3c7462ed20abbd4192]
stable/6.1: [5b3b220d54e6a3d77380cb7caa1ef79cb8f4fc94]
stable/6.12: [0dbd619716fb07b7de1acd64fec673ee6e1adde7]
stable/6.18: [e01b8c9286c470b71a38acd320106f2c4f2826a1]
stable/6.6: [c5dc30da990045105c9762248d23076223e7878a]
stable/7.0: [388617f44d81604a760742a0b5de292d411e63e3]

CVE-2026-46179: ASoC: SOF: Don't allow pointer operations on
unconfigured streams

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46179

Introduced by commit c1a731c ("ASoC: SOF: compress: Add support for
computing timestamps") in v6.1-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c5b6285aae050ff1c3ea824ca3d88ac4be1e69c8]
stable/6.1: [76ff6bfc9a809571793f425ba99f6a759108dcf8]
stable/6.12: [98ed1383f597f8a45b6cb816bb20b96d46eeceda]
stable/6.18: [0f0c0c1397a42aacaacae828206ee1b921623952]
stable/6.6: [327a64241f30c74b6f35537eb9e1fc6c3cbe060b]
stable/7.0: [4f42dd01f5217465f23a763e27b3984e114d0972]

CVE-2026-46180: wifi: brcmfmac: Fix potential use-after-free issue
when stopping watchdog task

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46180

Introduced by commit 373c83a ("brcmfmac: stop watchdog before detach
and free everything") in v4.18-rc6.
Introduced by commit a9ffda8 ("brcm80211: fmac: abstract bus_stop
interface function pointer") in v3.3-rc1.
Fixed in v7.1-rc3.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [c623b63580880cc742255eaed3d79804c1b91143]
stable/6.12: [d16827cb1d3936f7627d0da6044483f743ebde03]
stable/6.18: [658d2e46c2e9a8eb9b80c5e803ce3c89885b3366]
stable/6.6: [ed4168d1a50fef5be8eca947fbbf05a28507d265]
stable/7.0: [908b92231e1ded53e43fcfad5e0704d83e1b803c]

CVE-2026-46181: RDMA/mlx4: Fix mis-use of RCU in mlx4_srq_event()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46181

Introduced by commit 30353bf ("net/mlx4_core: Use RCU to perform radix
tree lookup for SRQ") in v4.9-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9341307ea16b9395c2e4c9c94d8499d91fe31d0]
stable/6.18: [1e2a44875b6afb4add1115f7f3351dcbeb6f273d]
stable/7.0: [8b7833f3bce35cb0d01c1503781523c099c675f0]

CVE-2026-46182: pseries/papr-hvpipe: Prevent kernel stack memory leak
to userspace

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46182

Introduced by commit cebdb52 ("powerpc/pseries: Receive payload with
ibm,receive-hvpipe-msg RTAS") in v6.18-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cefeed44296261173a806bef988b26bc565da4be]
stable/6.18: [0479b6e9f999cc1cbad7d9f09f574fc387e605d5]
stable/7.0: [f88f8e4485b437e0a2f96a7ff1f88aa22d925659]

CVE-2026-46183: mm/damon/sysfs-schemes: protect path kfree() with
damon_sysfs_lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46183

Introduced by commit c41e253 ("mm/damon/sysfs-schemes: implement path
file under quota goal directory") in v6.19-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf3b71421ca00807328c6d9cd242f9de3b77a4bf]
stable/7.0: [a34ca3e33da4b924c66bcca3729bf68ec5936910]

CVE-2026-46184: sound: ua101: fix division by zero at probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46184

Introduced by commit 63978ab ("sound: add Edirol UA-101 support") in
v2.6.34-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1f73f169c1014463b5060e3f60813e13ddc7b87]
stable/5.10: [e02897c5b041c9b980055fa9a6167023d6dc5caf]
stable/5.15: [aae1498c59f48d03ee358df84f07a5af9885f827]
stable/6.1: [66d9c2ed081f299cfb201d9e9c4faf920e56e0bf]
stable/6.12: [593dd7e6c890d8e4ca21b3e2f796b7cb8e8da983]
stable/6.18: [0ff2b713f406e9ecadb406014d74e7a020ac12b1]
stable/6.6: [6162e8212e88c39492d981b248b5e37002486c66]
stable/7.0: [f1862dbf09080254c52175a448290c784dd7d3de]

CVE-2026-46185: smb/client: fix out-of-bounds read in symlink_data()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46185

Introduced by commit 76894f3 ("cifs: improve symlink handling for
smb2+") in v6.1-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d62b8d236fab503c6fec1d3e9a38bea71feaca20]
stable/6.1: [2be11faf79e49fb8250a181ff0b4d2b2f084af83]
stable/6.12: [15dc0a4de743a1aaa7b859b3aea79f08c695396c]
stable/6.18: [b8c8a704f0bc133deb171f6aeb6f3a684203e212]
stable/6.6: [ef6495d4df6e7af8f3de67e65150881c880f696c]
stable/7.0: [b9561402489d41149f63e001a74384863b7b30a6]

CVE-2026-46186: Bluetooth: virtio_bt: validate rx pkt_type header length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46186

Introduced by commit 160fbcf ("Bluetooth: virtio_bt: Use skb_put to
set length") in v6.1-rc4.
Fixed in v7.1-rc3.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [daf23014e5d975e72ea9c02b5160d3fcf070ea47]
stable/5.15: [149cfb42ad69c7964fd9f2c43831da9152007129]
stable/6.1: [7b2d4c04816cdc887f472caaf7fc966cfc107e40]
stable/6.12: [2c1143564c71e7497b42d8360a8379ccbb011d3c]
stable/6.18: [3485c7236c59c8c34a41af1c4b52982437554e79]
stable/6.6: [1e1e509b6fd2a42421745bbcd98bd16daad20904]
stable/7.0: [f743eab6486965f276c7e3f1700895f014fdc6db]

CVE-2026-46187: wifi: rsi: fix kthread lifetime race between self-exit
and external-stop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46187

Introduced by commit 4c62764 ("rsi: improve kernel thread handling to
fix kernel panic") in v4.20-rc1.
Fixed in v7.1-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [db57a1aa54ff68669781976e4edb045e09e2b65b]
stable/5.10: [4ac3095da22fc50e51ec10c3b8323c21ab3e441a]
stable/5.15: [9dfe8a4458a063c6433526bc59112a169eee1aa3]
stable/6.1: [4f697813162d5f9151726a6d2bee82bffe4b0256]
stable/6.12: [16d9f674c619838bdeae42abc0929c9c5477ea1f]
stable/6.18: [4f9a4ae8d2c198f01611ea376034c326ef43ab56]
stable/6.6: [95fcb436586dc3c2983537d557ac05bbc6a027f3]
stable/7.0: [4f4c9b13c485abd0a2d2c97f9db339d1dd8e147f]

CVE-2026-46188: octeon_ep_vf: add NULL check for napi_build_skb()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46188

Introduced by commit 1cd3b40 ("octeon_ep_vf: add Tx/Rx processing and
interrupt support") in v6.9-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd66b42854705e4e4ee7f14d260f86c578bed3e3]
stable/6.12: [60246cdd4c515ea7d920cddf48932efcb990773e]
stable/6.18: [b0f4711b426a06fb4c4be85c36b9f5588d5140d3]
stable/7.0: [6fef6640bbf360e254cc0174365ed30ce3a07572]

CVE-2026-46189: RDMA/vmw_pvrdma: Fix double free on
pvrdma_alloc_ucontext() error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46189

Introduced by commit 29c8d9e ("IB: Add vmw_pvrdma driver") in v4.10-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e38e86995df27f1f854063dab1f0c6a513db3faf]
stable/5.10: [269967d7693304e1f06ed2dff4ebbbeeb397cda4]
stable/5.15: [1df5711121cdc11e76b889408fdbe459feba1d39]
stable/6.1: [3a231c34c5bc3d3cfc850b877758ec9fdaa8a483]
stable/6.12: [45d25e3ec17900bf5a9d6876ff16ceee31c4c0e0]
stable/6.18: [0c63333ff97bd1275294fd12840a0efe9d7a4c59]
stable/6.6: [ecc36a82ecfcfdf3c6606d209f22ec5543c410e0]
stable/7.0: [935ee27d0904aa944cbcc979094c20e5ef62eead]

CVE-2026-46190: mtd: spi-nor: debugfs: fix out-of-bounds read in
spi_nor_params_show()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46190

Introduced by commit 0257be7 ("mtd: spi-nor: expose internal
parameters via debugfs") in v5.19-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e47029b977e747cb3a9174308fd55762cce70147]
stable/6.12: [ca18c180b053f6ce80394322b314ac721c316af7]
stable/6.18: [34bdcfb496b29f9a52431194f94473b37fb8c162]
stable/6.6: [9a80c458320e0514e11945402dd6e48fcee05524]
stable/7.0: [c0b654bc0b76a1da102d9138be1ed1223bd99310]

CVE-2026-46191: fbcon: Avoid OOB font access if console rotation fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46191

Introduced by commit 6cc50e1 ("[PATCH] fbcon: Console Rotation - Add
support to rotate font bitmap") in v2.6.20.16.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e4ef723d8975a2694cc90733a6b888a5e2841842]
stable/6.12: [ab6c34b9829d5de03f1d08a47a2253729a6e7e27]
stable/6.18: [7105d9f1387d63b15c9a860674fc92c959181f2f]
stable/6.6: [594973a2e54924d8ba31c9faac669fc1ba6fcb80]
stable/7.0: [b44cc78ff46b96e72d333a3be6aaaa0a14797263]

CVE-2026-46192: spi: microchip-core-qspi: don't attempt to transmit
during emulated read-only dual/quad operations

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46192

Introduced by commit 8f9cf02 ("spi: microchip-core-qspi: Add regular
transfers") in v6.17-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb56deaabf127e8985fc91fa6c97bf8a3b062844]
stable/6.18: [ec9d0ddbde6003c303fa5e1d5cd48952852984d8]
stable/7.0: [67184f361ab4d9fac6d2b8d5fed6649d496038a4]

CVE-2026-46193: xfrm: ah: account for ESN high bits in async callbacks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46193

Introduced by commit d4d573d ("{IPv4,xfrm} Add ESN support for AH
egress part") in v3.15-rc1.
Introduced by commit d8b2a86 ("{IPv4,xfrm} Add ESN support for AH
ingress part") in v3.15-rc1.
Introduced by commit 26dd70c ("{IPv6,xfrm} Add ESN support for AH
egress part") in v3.15-rc1.
Introduced by commit 8d6da6f ("{IPv6,xfrm} Add ESN support for AH
ingress part") in v3.15-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec54093e6a8f87e800bb6aa15eb7fc1e33faa524]
stable/6.12: [729899a2aa8bda7844be0cdcd3b470f11b912eda]
stable/6.18: [7db99a09b3bc87268287bc7ab5f2e7f382b5ad87]
stable/6.6: [0555d4f526232b3c9e3afbcd490c0c0793aefec6]
stable/7.0: [2ffaa7a94f9a4d22724364a1821735a0231d9f8d]

CVE-2026-46194: f2fs: fix node_cnt race between extent node destroy
and writeback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46194

Introduced by commit 3fc5d5a ("f2fs: fix to shrink read extent node in
batches") in v6.13-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [ed78aeebef05212ef7dca93bd931e4eff67c113f]
stable/6.12: [ab1eaf9d5c99042f5b0243bf67a06283a4c0757f]
stable/6.18: [b0e4395870eb3441ddc959f6710b5f6ca61aff26]
stable/6.6: [42dd1c91f993431d0b399502479d00e6ad1bca71]
stable/7.0: [0559a0e962aacbb47519e26ee663be04b72dcb92]

CVE-2026-46195: smb: client: validate dacloffset before building DACL pointers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46195

Introduced by commit bc3e9dd ("cifs: Change SIDs in ACEs while
transferring file ownership.") in v5.12-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f98b48151cc502ada59d9778f0112d21f2586ca3]
stable/6.12: [3b1ddba19e77ee35241cd27f16dc3e8d14e08db7]
stable/6.18: [c688f3ed73d31943334ad2139cb02ec49664322a]
stable/6.6: [ba7f71b6161c0943dafc367565e5843d16b7d505]
stable/7.0: [8bd07e417b6bda67e317920584e48cb6ee442a8a]

CVE-2026-46196: tracepoint: balance regfunc() on func_add() failure in
tracepoint_add_func()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46196

Introduced by commit 8cf868a ("tracing: Have the reg function allow to
fail") in v4.10-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fad217e16fded7f3c09f8637b0f6a224d58b5f2e]
stable/6.12: [7bcadb3c2bc1cf60690e931aadd35fb7bd646a49]
stable/6.18: [2c5b8eeea006eb694c81631cd5713d494b80be90]
stable/6.6: [247ed8a969f981bfba3112fd4bb441eaa6cef59c]
stable/7.0: [342829e042ac00f3d68d442ea92873fb6683f494]

CVE-2026-46197: drm/amdkfd: validate SVM ioctl nattr against buffer size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46197

According to the .vulnerable file, this bug was introduced by commit
42de677 in v5.14-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [045e0ff208f0838a246c10204105126611b267a1]
stable/5.15: [daa8bc5f83814b55b71d2b5b3a090d57a5219c21]
stable/6.1: [fb07a0c9c8419164812e07274947f11b1d92dd61]
stable/6.12: [ccd060b5c7cc75ae7e211c250b97c5b6272e7efc]
stable/6.18: [db9530a9873a7c85d2266a922589ebcf427fa631]
stable/6.6: [91c6dc5a41695d02dfc6299f106ac38a6c493e52]
stable/7.0: [6abd3a4417cb73a7d0db7e25bf11fae1074bdba3]

CVE-2026-46198: batman-adv: fix integer overflow on buff_pos

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46198

Introduced by commit c6c8fea ("net: Add batman-adv meshing protocol")
in v2.6.38-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0799e5943611006b346b8813c7daf7dd5aa26bfd]
stable/5.10: [867cd090760e8f5cd206f387b47ff9c56fac04e9]
stable/5.15: [10bb1f366d884d506c38a947b43026a75d1afe9a]
stable/6.1: [96c9c0ed9a9579a9085765aceaa4556a6666eb82]
stable/6.12: [974542d1efc48b7e9fe16184e647615cba39969b]
stable/6.18: [bf872db54f91ffe70104b98c20068b2d5910e018]
stable/6.6: [f61499359fa529f0d45a53bf7c573a49eb6322e6]
stable/7.0: [b252797bfced986d6d92ec2f4cfcca842ce8aa78]

CVE-2026-46199: drm/amdgpu/vcn4: Prevent OOB reads when parsing dec msg

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46199

According to the .vulnerable file, this bug was introduced by commit
87cc7f9 in v5.13-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0a78f2bac1424deb7c9d5e09c6b8e849d8e8b648]
stable/6.1: [88411caee8f576d6b5abf6531232fcc0ce756dc5]
stable/6.12: [7688143ca62edeecacb3ba0a2cea129dbd262a18]
stable/6.18: [63b51e8a9d54317d31cc3856c1e12407070d5fc2]
stable/6.6: [c72a8b4dc6d598e3831ef3abd9c6527dfbf4810e]
stable/7.0: [3c817a60b09eaab926e475088e750936efcc95ae]

CVE-2026-46200: spi: mpc52xx: fix controller deregistration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46200

Introduced by commit 42bbb70 ("powerpc/5200: Add mpc5200-spi (non-PSC)
device driver") in v2.6.33-rc1.
Introduced by commit b8d4e2c ("mpc52xx_spi: add gpio chipselect") in
v2.6.33-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0f997fdae819a8c2cc83bd4ff7d935ad76c727c9]
stable/6.12: [a3669f678d0ee8b686d3eea4c0ed9817c9374945]
stable/6.18: [28f28a0f4e327f792c230493a0ea00389ff68ff5]
stable/7.0: [7fea80d93bfd34051b2ac1cec07766c87d8d28be]

CVE-2026-46201: drm/xe: Fix dma-buf attachment leak in xe_gem_prime_import()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46201

Introduced by commit dd08ebf ("drm/xe: Introduce a new DRM driver for
Intel GPUs") in v6.8-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [111ab678471bf1f90d078d5513bb086b70596c3c]
stable/6.12: [d394669e194936d7ce15284a24a5ae334c4c5b74]
stable/6.18: [0afa8b1ef582ecf6fb04097fd356f8741e5005ed]
stable/7.0: [eea1e10f8d99c0f04deef707c99705b94bba3b78]

CVE-2026-46202: HID: appletb-kbd: run inactivity autodim from workqueues

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46202

Introduced by commit 93a0fc4 ("HID: hid-appletb-kbd: add support for
automatic brightness control while using the touchbar") in v6.15-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1654e53349d4e657b331de354313461f401f5063]
stable/6.18: [5c0830323689ef15224f0025276176988861b3b0]
stable/7.0: [2473a334c292af257ef68e33bc7760f4a8251812]

CVE-2026-46203: spi: cadence-quadspi: fix unclocked access on unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46203

Introduced by commit 0578a6d ("spi: spi-cadence-quadspi: add runtime
pm support") in v6.7-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [233db2cb14db8b1935dda52a6affd97276462b82]
stable/7.0: [d67a5311818b3e6481a1e4293c9337ebfee73111]

CVE-2026-46204: drm/amdgpu/vcn4: Prevent OOB reads when parsing IB

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46204

According to the .vulnerable file, this bug was introduced by commit
0b15205 in v6.0-rc1.
Fixed in v7.1-rc1.
Affected file was added by 8da1170 ("drm/amdgpu: add VCN4 ip block
support") in v5.19-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2444eb0ec8283f4a3845eb7febad378476e1ba3c]
stable/6.12: [d0802a8877d730260d4af4dd4e0b6cde7e0e593f]
stable/6.18: [a6d5563ba1f03a049561cd347574613167294e8d]
stable/6.6: [1dc005775fb5b3f86464406452b17364f85581d3]
stable/7.0: [5c3e8ebad0c9e2354ddfa8f2148dc4f70a3b4bd1]

CVE-2026-46205: staging: media: atomisp: Disallow all private IOCTLs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46205

Introduced by commit a49d253 ("staging/atomisp: Add support for the
Intel IPU v2") in v4.12-rc1.
Introduced by commit ad85094 ("Revert "media: staging: atomisp: Remove
driver"") in v5.8-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b7eb2c5dc72f0fc954ac4aa155f9e285e937f7c]
stable/5.10: [64e85679beafe082fc2e70a557ec356c7fd27548]
stable/5.15: [8774f8cb661f57ae43cc3bc0509d16ef1f406e45]
stable/6.1: [ceb1b5f910e58986ea544ff8c9c2f23ae9a52414]
stable/6.12: [6f1ce75a75c65061e7a720c3d0ee5f8adab7a2d3]
stable/6.18: [c7848b67ef10f581114b6a2f52b160fc20eb52c9]
stable/6.6: [8c7a281a99224a5b9af99c4dcd98d68eea75926c]
stable/7.0: [6850a439f8d23d4979624f1d6880d3118d473a28]

CVE-2026-46206: batman-adv: reject new tp_meter sessions during teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46206

Introduced by commit 33a3bb4 ("batman-adv: throughput meter
implementation") in v4.8-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3243543592425beec83d453793e9d27caa0d8e66]
stable/5.10: [0a7a840074c9ca5ebffc9c52358c8ea55828ec71]
stable/5.15: [dcff44644bb518598b1a6be722706d6174b2f6a1]
stable/6.1: [52e6ec3e972cf27792cc1559874dbee19f286869]
stable/6.12: [ff93f86ecbb50a4709c403fc279a396e308edde5]
stable/6.18: [e1e2194cc725ec1d41f9412496212f0fa0519c36]
stable/6.6: [e4a3c4a4c8f6efd243c3e448c05b7bebcbf7b3b6]
stable/7.0: [ca39545cf07c142b39d474a1439a046bf28def3d]

CVE-2026-46207: vsock/virtio: fix empty payload in tap skb for
non-linear buffers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46207

Introduced by commit 4b0bf10 ("vsock/virtio: non-linear skb handling
for tap") in v6.7-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a3e3d90cbc79600544536723911657730759af3]
stable/6.12: [06747f52ab157591cec7e5623a759473b66ef6f6]
stable/6.18: [52da6a74ca3de0fcda60301096b71534b3b18641]
stable/7.0: [378b131a25bd1a5ee27ca199fe486c299d5350c5]

CVE-2026-46208: batman-adv: stop tp_meter sessions during mesh teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46208

Introduced by commit 33a3bb4 ("batman-adv: throughput meter
implementation") in v4.8-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d3cf6a7314aca4df0a6dde28ce784a2a30d0166]
stable/6.12: [26dfeee8db81354bfdade155f27f9e16510ad196]
stable/6.18: [03660dab86f93319178a24667f6998526dc4355d]
stable/6.6: [79bc0eaeef2c5797317bf2da8e3159a74d62ec47]
stable/7.0: [8634c1dbd73adb74d40533ebb7e914efb82e71fb]

CVE-2026-46209: drm/gem: Fix inconsistent plane dimension calculation
in drm_gem_fb_init_with_funcs()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46209

Introduced by commit 4c3dbb2 ("drm: Add GEM backed framebuffer
library") in v4.14-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d4c2268bd7243c3780fe32bf24ff876da272acf]
stable/5.10: [11427ad6c9f0def5ce567982b785da3191946430]
stable/5.15: [adfc5ba4ef4dd2bca5969f40e8fc7b41fb3902ad]
stable/6.1: [22922f7dae74409fc4bf0f1142710cb6b8ce8cc2]
stable/6.12: [1da4ab7189f1064b3b712b388772c008b4d82580]
stable/6.18: [1a17ea9861e89585361caa8bc231bd22dc6dbe7d]
stable/6.6: [6b992591e04f2cce813bcf239b354f375bbf84d3]
stable/7.0: [c5fc49d8470c5ebf3b41607600f277158f159950]

CVE-2026-46210: media: iris: fix use-after-free of fmt_src during MBPF check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46210

Introduced by commit 5ad964a ("media: iris: Initialize and
deinitialize encoder instance structure") in v6.18-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d9593ad1a58c5acc3e5fa2a48222bb7632e6812]
stable/7.0: [494ffd1712a588e590e6b1e9f876a8c8b24a9180]

CVE-2026-46211: drm/msm/gem: fix error handling in
msm_ioctl_gem_info_get_metadata()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46211

Introduced by commit 9902cb9 ("drm/msm/gem: Add metadata") in v6.8-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47cbfe2608314b833ad61a65827d8fb363bc2d2d]
stable/6.12: [697e1a9559f6962f999cc4c748c2ffffcc0a7a7a]
stable/6.18: [c57c861956b89f2e2528e6384d51e2dedd915809]
stable/7.0: [b079e85c91f446f29e808d8291189e897f1884ff]

CVE-2026-46212: batman-adv: bla: prevent use-after-free when deleting claims

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46212

Introduced by commit 2372138 ("batman-adv: add basic bridge loop
avoidance code") in v3.5-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ae1709a314060a196981b344610d023ea841e57]
stable/5.10: [1d4b241482d9025c537afb3c7c8419c72c0e0c82]
stable/5.15: [a1a99837bb6169cfb9187abaa2005e8f12079426]
stable/6.1: [b88c865dcf6e9f20bfe66a360d4b62941ef769b8]
stable/6.12: [6c5dc6d68e6ba7f0224a757a39ed52fcdb54d472]
stable/6.18: [00155f336a5e8b1006d2ca9ae7ad8fc4a44bb401]
stable/6.6: [368449e467d5f1e2c2e987bf2bd57000ba75e10b]
stable/7.0: [0cc9847c64cb6e61118bc78c9187c8209a7197fa]

CVE-2026-46213: HID: appletb-kbd: fix UAF in inactivity-timer cleanup path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46213

Introduced by commit 38224c4 ("HID: appletb-kbd: fix slab
use-after-free bug in appletb_kbd_probe") in v6.16-rc5.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4db2af929279c799b5653a39eb0795c72baffca4]
stable/6.18: [59a79938ca5541fe55d675304116b7ea684afef0]
stable/7.0: [93d989e47bc316c793a69c6a332e053c90e29f02]

CVE-2026-46214: vsock/virtio: fix accept queue count leak on transport mismatch

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46214

Introduced by commit c0cfa2d ("vsock: add multi-transports support")
in v5.5-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [52bcb57a4e8a0865a76c587c2451906342ae1b2d]
stable/5.10: [2ea5d2c79edcc99c7dbe0bb7518f5e1ee2a2391f]
stable/5.15: [fd51e810affa38d735d04261e673b2a5fe9c8665]
stable/6.1: [f66c7904fb6f0e420a654bc90909e64a25d00896]
stable/6.12: [29371f3cc83e2a92265b4768014a30b80234112f]
stable/6.18: [e9edf9893cf26d060705c910a9b62d8cc96ed56a]
stable/6.6: [65c484726e74013a2ec7ba67a34d87760ae8f390]
stable/7.0: [6d3275fc4ed968938e1d556c344798046776668d]

CVE-2026-46215: drm: Set old handle to NULL before prime swap in change_handle

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46215

Introduced by commit 5309672 ("drm: Add DRM prime interface to
reassign GEM handle") in v6.18-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5e28b7b94408897e41c63477aabc9e1db439bc8c]
stable/6.18: [672464dd53231509c9c771110798c56d4660e19e]
stable/7.0: [61bd96d3e5472c253f9c1ab77608f0c8aaa9d025]

CVE-2026-46216: drm/xe/hdcp: Add NULL check for media_gt in
intel_hdcp_gsc_check_status()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46216

Introduced by commit 4af50be ("drm/xe: Use gsc_proxy_init_done to
check proxy status") in v6.10-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [60a1e131a811b68703da58fd805ab359b704ab03]
stable/6.12: [cad210d2851f3a7d9573bdfc02aa61d9287bbe8c]
stable/6.18: [814326e86e929b865020ff44f4576dbdfe3f7ff3]
stable/7.0: [d8ab4b47edf4578dbfbe5e95817107a514fa34cc]

CVE-2026-46217: drm/amdgpu/vcn4: Avoid overflow on msg bound check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46217

Introduced by commit 0a78f2b ("drm/amdgpu/vcn4: Prevent OOB reads when
parsing dec msg") in v7.1-rc1.
Fixed in v7.1-rc2.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.1 stable/6.12 stable/6.18 stable/6.6 stable/7.0

Fixed status
mainline: [65bce27ea6192320448c30267ffc17ffa094e713]
stable/6.1: [f7bf02dcb7c76229ea8ace11b7d0d0c7b87ee57e]
stable/6.12: [73043d296787bf187d89ffb5c5dcf5bdc3db7885]
stable/6.18: [271cd5429513ff9b364a9bf8903e5b65b687eb25]
stable/6.6: [5bb5faff4837b1d98fd655cf8bd7b5d4da0fc4dc]
stable/7.0: [30d12ee310a6024ff4c7b9eafdbbeab2db450d4a]

CVE-2026-46218: drm/amdgpu: Add bounds checking to ib_{get,set}_value

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46218

According to the .vulnerable file, this bug was introduced by commit
d38ceaf in v4.2-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66085e206431ef88ce36f53c1f53d570790ccc9e]
stable/6.1: [5da6c6430be0acb25b4242bce0323fc514d4e3cf]
stable/6.12: [a853178d23e774adfe3a35073c375b04b3b20f7d]
stable/6.18: [fec8b11b55e53ff51a741e56894fe331a516f5c6]
stable/6.6: [0fb5cb556b249b2b64c0f818136c4c3e838ef53f]
stable/7.0: [ee26fcf7c5cf131f0b6a732faa27d79ec61b8ec7]

CVE-2026-46219: spi: mpc52xx: fix use-after-free on unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46219

Introduced by commit 9848366 ("spi: mpc52xx: Add cancel_work_sync
before module remove") in v6.13-rc2.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [706b3dc2ac7a998c55e14b3fd2e8f934c367e6e0]
stable/5.10: [ac8316c896c79f32c1d0a38cb41fd2b14cf8112e]
stable/5.15: [ed929d40963073f23cfb50219ccbcc6e0c3ea641]
stable/6.1: [0944b20e9dfa2917bd70eb5b301cbb67fe54a718]
stable/6.12: [ee52da0dd83ebcd89ecbbe2660c57b15a25489f2]
stable/6.18: [6c3e413919a12627d04a31a4a5fccb9fc129bb02]
stable/6.6: [bb6b50f709c5a01906ff72a07fdc070bb3357188]
stable/7.0: [bbcd6dd8e9f264440eaf6167382bf404911c1c46]

CVE-2026-46220: drm/amdgpu/sdma4: replace BUG_ON with WARN_ON in fence emission

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46220

Introduced by commit 2130f89 ("drm/amdgpu: add SDMA v4.0
implementation (v2)") in v4.12-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [78d2e624fa073c14970aa097adcf3ea31c157a66]
stable/5.10: [ecaa80318e900ca0c3f687742ede33b41cfd2f8e]
stable/5.15: [25e7d56a39657d56d1ea6d78992f7ed15dedb412]
stable/6.1: [d4c56932d29773e278be6a65a5384a36c95b89a4]
stable/6.12: [d331fb241a4602253976ddd65144a8ba2b05665d]
stable/6.18: [0b91ea46bb68abf98a082bf239092253bbd6aaa2]
stable/6.6: [4f7ca00fa91daf0795ec6b3b130c5ebba1f155fe]
stable/7.0: [a4fd82fb0757c180bf622907397c528b89a827b2]

CVE-2026-46221: EDAC/versalnet: Fix device name memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46221

Introduced by commit d5fe2fe ("EDAC: Add a driver for the AMD Versal
NET DDR controller") in v6.18-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8cf5dd235eff6008cb04c3d8064d2acfa90616f1]
stable/6.18: [24d2912962d087ebff7c4984f8ac34a5f23c8dbf]
stable/7.0: [b16033c8774f5fb4c0cb9b445a1dfc68f499ae6a]

CVE-2026-46222: media: rockchip: rkcif: Add missing MUST_CONNECT flag to pads

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46222

Introduced by commit 501802e ("media: rockchip: rkcif: add abstraction
for dma blocks") in v6.19-rc1.
Introduced by commit 85411d1 ("media: rockchip: rkcif: add abstraction
for interface and crop blocks") in v6.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e3c751259dc2d1325838eff26f41032523c7b57]
stable/7.0: [318142640590342bfec7aa06d0bdcd0ddbf953d0]

CVE-2026-46223: cgroup: Defer css percpu_ref kill on rmdir until
cgroup is depopulated

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46223

Introduced by commit 1b164b8 ("cgroup: Wait for dying tasks to leave
on rmdir") in v7.0-rc7.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [93618edf753838a727dbff63c7c291dee22d656b]
stable/7.0: [33fa2e6b1507a0a377a151a8826438bedad1d0b0]

CVE-2026-46224: drm/xe: Fix bo leak in xe_dma_buf_init_obj() on
allocation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46224

Introduced by commit eb289a5 ("drm/xe: Convert xe_dma_buf.c for
exhaustive eviction") in v6.18-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [93a528f67ce5095bcab46a69839eca97f43dd352]
stable/6.18: [f9ad21b90162baf1d78f8036ff3813c3ec1ac88e]
stable/7.0: [8fa8c2a22585fcb31dc605b91a67bbcca223fdd7]

CVE-2026-46225: spi: rspi: fix controller deregistration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46225

Introduced by commit 9e03d05 ("spi: rcar: Use
devm_spi_register_master()") in v3.14-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9944fa6726afb1e6eb7e2212764e7da0c97f2dcc]
stable/6.12: [c5090db1b31de3ef4db0cda7e822ab49cb572292]
stable/6.18: [aee76c1dd189562c6678313caec12761f78a9ef3]
stable/6.6: [77defd64b405b680db73d767313fce770d368368]
stable/7.0: [fee6abd9845c3edd217b0e429d09f764f9a5690e]

CVE-2026-46226: spi: fsl: fix controller deregistration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46226

Introduced by commit 4178b6b ("spi: fsl-(e)spi: migrate to using devm_
functions to simplify cleanup") in v4.3-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b7abfed4c3754062d1f3ffd452e65a38667f586]
stable/6.12: [e888308222375ac28bae69134dae288178718a96]
stable/6.18: [ca3195c7b88362d7c81efe685948663a9f9db0e6]
stable/6.6: [562d954a144950ec2aa6a874ae657cb3fa31fe53]
stable/7.0: [5750743a39c9d46ac9fcf57ffe000956da4942cf]

CVE-2026-46227: sctp: revalidate list cursor after
sctp_sendmsg_to_asoc() in SCTP_SENDALL

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46227

Introduced by commit 4910280 ("sctp: add support for snd flag
SCTP_SENDALL process in sendmsg") in v4.17-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [abb5f36771cc4c05899b34000829a787572a8817]
stable/5.10: [f3a3f0b406b4b7eb3cea35a23fa2bf170848b104]
stable/5.15: [0dbc8cde64280fc37cdd678cced34eaf96cfb197]
stable/6.1: [0c7b55974f97b78d1109025eadf084e74cbf330f]
stable/6.12: [6187a172d6ed57d6b2c327836e4407c6456e639d]
stable/6.18: [c9dadb31f36045a8cb65df4bd75e7237ef21a4b5]
stable/6.6: [1bfb06ecb00f7fdf35dba8e8f2877346cbe5e078]
stable/7.0: [bf0f40d8107e2ce827521968dc6926f3e13728ae]

CVE-2026-46228: spi: ch341: fix devres lifetime

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46228

Introduced by commit 8846739 ("spi: add ch341a usb2spi driver") in v6.11-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [abe572f630bc1f0e77041012ab075869036ede4f]
stable/6.18: [4422fc2411cbbdf5104a914e0596bb483faea254]
stable/7.0: [108a64b27a52f781c4f3751641e3dd65c7dd2fb5]

CVE-2026-46229: drm/amdkfd: Clear VRAM on allocation to prevent stale
data exposure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46229

According to the .vulnerable file, this bug was introduced by commit
6856e4b in v5.4-rc1.
Fixed in v7.1-rc1.
Affected file was added by a46a2cd ("drm/amdgpu: Add GPUVM memory
management functions for KFD") in v4.17-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ad52d61d82181dbdb7f05826de38352d5e550cc2]
stable/6.12: [32b153658f017ad2f5bf8aab479e8d16ac95bc3a]
stable/6.18: [77d0b5d11387071770246fd0185a69fa28e8e109]
stable/6.6: [1db431380879fd9d28b763a88a0c0431be5be8df]
stable/7.0: [047d44d8d29a6a1a5757256837aa9dd78e3cd0b5]

CVE-2026-46230: drm/amdgpu/vcn3: Prevent OOB reads when parsing dec msg

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46230

According to the .vulnerable file, this bug was introduced by commit
87cc7f9 in v5.13-rc1.
Fixed in v7.1-rc1.
Affected file was added by cf14826 ("drm/amdgpu: add VCN3.0 support
for Sienna_Cichlid") in v5.9-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b193019860d61e92da395eae2011f2f6716b182f]
stable/5.15: [f55552adb100eb54a6e6dabff4fbdc8679bd3fa0]
stable/6.1: [82c535eff05490c71153af57de9fe85502fcb5d5]
stable/6.12: [870c8738c3774336baedddd0240951d078a703b8]
stable/6.18: [638e48ee39d0f2af9336f917a6f5d6692dd64d93]
stable/6.6: [638d3e0b9eb77aa53fdd60e2b928761d16ba76fa]
stable/7.0: [e382e0b81a3e7bd21504fee1d01ae8b08f84d3a7]

CVE-2026-46231: batman-adv: bla: put backbone reference on failed
claim hash insert

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46231

Introduced by commit 3db0dec ("batman-adv: Fix non-atomic
bla_claim::backbone_gw access") in v4.7.
Fixed in v7.1-rc4.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [ba9d20ee9076dac32c371116bacbe72480eb356c]
stable/5.10: [6c8b68a7ed667a63aa603ba4d3a7088be143007e]
stable/5.15: [769f413d374ff2b6ff6d8d8c37b4c1178e6cdf14]
stable/6.1: [2888c9a154123db0254ae4fb9bea570c7e1f2e06]
stable/6.12: [fd0ca034c1e71ca7613cde9dd892836b2c2831bd]
stable/6.18: [0baf4b659cdc7305cf685b5a5d60f9e3816ab5d0]
stable/6.6: [65419eb4259a26a3cd3f56fa0e3b3c113bf8c256]
stable/7.0: [7cccf4eb4f96d3c3af91a00b7a9caa652439542e]

CVE-2026-46232: HID: playstation: Clamp num_touch_reports

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46232

Introduced by commit 7520382 ("HID: playstation: add DualShock4
touchpad support.") in v6.2-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cac61b58a3b6340c52afa06bb15eac033158db2f]
stable/6.12: [9c031b24aed6733b6dcc5d98527875b8654a04e9]
stable/6.18: [7812694752a5f295eaa05a093b90a2c332666051]
stable/6.6: [0bc4cf1a6ba00fb8c074531b179bc7b97502fbc4]
stable/7.0: [208f6d5b1dfd6399bc6af9e11f27f1f496243ed0]

CVE-2026-46233: batman-adv: bla: only purge non-released claims

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46233

Introduced by commit 2372138 ("batman-adv: add basic bridge loop
avoidance code") in v3.5-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf6b604011591865ae39ac82de8978c1120d17af]
stable/5.10: [a9f58d5e3261f3deeae69ec1e237f38ef3ff5cbe]
stable/5.15: [6725c523a35eeca611ff37e7d4a8712fae92aefd]
stable/6.1: [afb5436f6028fd68f408f189230fbaa19c910d72]
stable/6.12: [7b7ebb7222a5524ce58e48cc9c6d688320ea6cfe]
stable/6.18: [b65365d2b1e6095c538d49baeb140dd1c166c1b3]
stable/6.6: [7b8fbcee3184d848b5aee085ca16d0cf05c9b641]
stable/7.0: [ab3dbd07a809a8eb30c7ddfab9ac886ed30dce8d]

CVE-2026-46234: vsock: fix buffer size clamping order

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46234

Introduced by commit b9f2b0f ("vsock: handle buffer_size sockopts in
the core") in v5.5-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d114bfdc9b76bf93b881e195b7ec957c14227bab]
stable/5.10: [f6ec135941d2c1c2dbb87b5ce1783f4f6ac6ccca]
stable/5.15: [caf11dfea5233a69298a1c448bbf8d1639c80536]
stable/6.1: [01ef69785dc3162f588a361ab770b1e312800188]
stable/6.12: [310da27932dd0afe7ce7456dfe1f0814c3301f41]
stable/6.18: [2602f7bb5818e92315feeaeb71d8ce4d5c9ab160]
stable/6.6: [a998a7e250bf976539e05a00ec64a81292afecaa]
stable/7.0: [0b68881501460c3761f196469e1e503218c5e536]

CVE-2026-46235: media: saa7164: add ioremap return checks and cleanups

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46235

Introduced by commit 443c122 ("V4L/DVB (12923): SAA7164: Add support
for the NXP SAA7164 silicon") in v2.6.32-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d51c60a498e83c9a79884c8e420f97e3885c9583]
stable/6.1: [23dee5990d2c27ed79567fd61ccfe6876768531a]
stable/6.12: [a9b83f46e52cf1239d780920d1a7a3e415f7b5d9]
stable/6.18: [6047dc542fa404b5c187cc2c7906aaaaec6d11ed]
stable/6.6: [3ce8f3057c51bb0a66aa3fab0862be74e9f88684]
stable/7.0: [6c22a6d8e4c1507bba504aeebe80476144a373eb]

CVE-2026-46236: media: rc: xbox_remote: heed DMA restrictions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46236

Introduced by commit 02d32bd ("media: rc: add driver for Xbox DVD
Movie Playback Kit") in v5.0-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e280d1e5e3f2595bbb43fe6e1bce00c59a43c0ff]
stable/5.10: [465d27ab83692167f06a6f917bdfd0a0d4fc8ff3]
stable/5.15: [e0301883ec779c21158a3923b2eb666074fa976e]
stable/6.1: [0ea67a135335e51be50e83ee4cc99560b8b89c25]
stable/6.12: [48a668c22e8f92637bc496e84d1cf06900f74a5c]
stable/6.18: [63a960b39de9c51f29ca19aa5067934f865c0bc7]
stable/6.6: [0cc9251833bf02c8c7863404157c94dab5928fcf]
stable/7.0: [0bd8ac88ec5f74cd0f4b8cfc54f4cc0827007249]

CVE-2026-46237: drm/amdgpu/vcn3: Avoid overflow on msg bound check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46237

Introduced by commit b193019 ("drm/amdgpu/vcn3: Prevent OOB reads when
parsing dec msg") in v7.1-rc1.
Fixed in v7.1-rc2.

Bug introduced commit was backported to following branches.
cip/6.12 stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6 stable/7.0

Fixed status
mainline: [e6e9faba8100628990cccd13f0f044a648c303cf]
stable/5.15: [94a2b37399807fd2ca78dc1906986c4fbd72968e]
stable/6.1: [95b0f6df8d7fad2eabf265d2c3d2538ef58e4465]
stable/6.12: [e8124121b79ab5d32fa8fbbd101f7208eca9cd7d]
stable/6.18: [016b64a0313ea5346cf526e30c8d3e66aca10175]
stable/6.6: [1936310f68c54be961de38ac539cef9b543207cb]
stable/7.0: [2e43b66fceacd6e982b94f2e3f8b34edd7463396]

CVE-2026-46238: batman-adv: stop caching unowned originator pointers in BAT IV

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46238

Introduced by commit c6c8fea ("net: Add batman-adv meshing protocol")
in v2.6.38-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f03e8583532941b07761c5429de7d50766fa3110]
stable/5.10: [86b2b58d7c228d850c8c78e4144e6123e8ed2718]
stable/5.15: [384e3050a42be9085d50507b4d5f8266a588d742]
stable/6.1: [8c16c68fdbb69778f8d04f650340c3f4d1518f8e]
stable/6.12: [6e20700f8c524ac379ba8274ff5d453023b7c006]
stable/6.18: [09dc0d1a12222ffca6481916eab3cfea477b9620]
stable/6.6: [aafcbaf1159ea224528ca4075d0ba8c10ef374af]
stable/7.0: [67bceeb22207f1f5a402973a3a0809e5f2698f38]

CVE-2026-46239: media: i2c: ov5647: Fix runtime PM refcount leak in s_ctrl

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46239

Introduced by commit 4f66f36 ("media: i2c: ov5647: Convert to CCI
register access helpers") in v7.0-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f11ae9c04f8368a3b5a0280ef595198dace1c983]
stable/7.0: [6b03ecf75bda5900b8e661eb75656f631b598bc2]

CVE-2026-46240: media: iris: Fix use-after-free in
iris_release_internal_buffers()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46240

Introduced by commit 1dabf00 ("media: iris: gen1: Destroy internal
buffers after FW releases") in v7.0-rc1.
Fixed in v7.1-rc3.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [f27cfdcfc916bb59297825805f4c3499f89f9e76]
stable/6.18: [dd24998a4a4016fb9921916024399bd80f0d45c6]
stable/7.0: [18c64439f249859b6140f7bf8bcf95c8ed841f28]

CVE-2026-46241: spi: mpc52xx: fix use-after-free on registration failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46241

Introduced by commit 42bbb70 ("powerpc/5200: Add mpc5200-spi (non-PSC)
device driver") in v2.6.33-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f62c060272b9d7423b1650b844e8e4e7b8f9f925]
stable/6.12: [8b49b6aadd0c622ca7d68b4a53ae10362e221cf3]
stable/6.18: [336d9ad7560b3baba17af06727a888040ee93390]
stable/7.0: [5c77f11b9b5f1ad5a704dad875260c44016ede10]

CVE-2026-46242: eventpoll: fix ep_remove struct eventpoll / struct file UAF

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46242

Introduced by commit 58c9b01 ("epoll: use refcount to reduce ep_mutex
contention") in v6.4-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
stable/5.15 stable/6.1

Fixed status
mainline: [a6dc643c69311677c574a0f17a3f4d66a5f3744b]
stable/6.18: [ef4ca02e95363e78977ca04340d44fe3b4b2b81f]
stable/7.0: [ced39b6a8062bac5c18a1c3df85634107eb8664a]

CVE-2026-46243: smb: client: reject userspace cifs.spnego descriptions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46243

Introduced by commit f1d662a ("[CIFS] Add upcall files for cifs to use
spnego/kerberos") in v2.6.24-rc3.
Fixed in v7.1-rc5.
This vulnerability is known as CIFSwitch.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3da1fdf4efbc490041eb4f836bf596201203f8f2]
stable/5.10: [7713bd320ed4fc3d08a227cd8e41242219a16981]
stable/5.15: [9544559e59438a4b609b2fdfa0763d8360572824]
stable/6.1: [cf20038657d6d4974349556a34e08fe0490bebbc]
stable/6.12: [a3bbda6502a9398b816fa2e71c9a3f955f58013d]
stable/6.18: [91f89c1d83e80417629791fcef6af8140d7d01c8]
stable/6.6: [2035acfb17221729b1b8ac335e941868a04ca079]
stable/7.0: [0aece6685fc80a8de492688ca2315fb86ec379c7]

CVE-2025-71313: PCI: endpoint: Add missing NULL check for alloc_workqueue()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71313

Introduced by commit e35f56b ("PCI: endpoint: Support NTB transfer
between RC and EP") in v6.0-rc1.
Introduced by commit 8b821cf ("PCI: endpoint: Add EP function driver
to provide NTB functionality") in v5.12-rc1.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [03f336a869b3a3f119d3ae52ac9723739c7fb7b6]

CVE-2025-71314: drm/panthor: Recover from panthor_gpu_flush_caches() failures

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71314

Introduced by commit 5cd894e ("drm/panthor: Add the GPU logical
block") in v6.10-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c0a60195b37af83bbbaf223cd3a78945bace49e]
stable/6.12: [8ec4f1b14a6147db07d6e51aa1d6bcc799649847]
stable/6.18: [57753f2c64c033a21a7400b3a2192db1cd6c890e]

CVE-2026-46244: netfilter: nft_inner: Fix IPv6 inner_thoff desync

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46244

Introduced by commit 3a07327 ("netfilter: nft_inner: support for inner
tunnel header matching") in v6.2-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b6a91f68ebfed9c38e0e9150f58a9b85da07181c]
stable/6.12: [870d59e2cf218e7418491e26bad768cb16654582]
stable/6.18: [689bbf48c1f45130086ae1c46ab83ea4c753c601]
stable/6.6: [c161ad9157f5a0429b5ff94d9770faf3bf48d273]
stable/7.0: [d0f98a3617f6ae5b1e95cde1e68e7ead4a1279ce]

CVE-2026-46245: drm/amd/display: Fix dc_link NULL handling in HPD init

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46245

Introduced by commit 4562236 ("drm/amd/dc: Add dc display driver
(v2)") in v4.15-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [226a40c06a183abaeb7529a4f54d6c203bd14407]

CVE-2026-46246: power: supply: pm8916_lbc: Fix use-after-free for
extcon in IRQ handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46246

Introduced by commit f8d7a3d ("power: supply: Add driver for pm8916
lbc") in v6.7-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23067259919663580c6f81801847cfc7bd54fd1f]
stable/6.12: [9fab0120907e6965168e55b1e17cb9dfaf262b86]
stable/6.18: [47abfc207ab02cf1297257e282e8048da63f0d08]

CVE-2026-46247: clk: qcom: gfx3d: add parent to parent request map

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46247

Introduced by commit 55213e1 ("clk: qcom: Add gfx3d ping-pong PLL
frequency switching") in v4.5-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2583cb925ca1ce450aa5d74a05a67448db970193]
stable/6.1: [82cfe5292b11deb1dc33822f67f73cfbe8eafe25]
stable/6.12: [56360aa4ddd736fc19e6d0b0206c5e437e0d6ff8]
stable/6.18: [aed53da569fb96eec09b4817b1953bcc2e467eea]
stable/6.6: [547ae2f17349c7586953af5ef50de43ef3f65e9e]

CVE-2026-46248: wifi: ath12k: clear stale link mapping of ahvif->links_map

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46248

Introduced by commit 81e4be3 ("wifi: ath12k: handle link removal in
change_vif_links()") in v6.15-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c1ba9c2adf0fda96eaaebd8799268a7506a8fc9]
stable/6.18: [da289440f04c93048d82d293b180f1cacdfee2d9]

CVE-2026-46249: octeontx2-af: Fix PF driver crash with kexec kernel booting

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46249

Introduced by commit 54494aa ("octeontx2-af: Add Marvell OcteonTX2 RVU
AF driver") in v4.20-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d2d574309e3ae84ee794869a5da8b4c38753a94]
stable/5.10: [b7605b9301abc18fbbf2b0e23fdd281fc768955d]
stable/5.15: [9769a09afda20a006b528b9e723effcae45965b2]
stable/6.1: [57821d1436ba1c6a6973aa32d54166fdec35558c]
stable/6.12: [7d56ba306e93d04696718963fb4cda2883ee7585]
stable/6.18: [9c3398e5b3a914b74276d44ab54c49123b89c61a]
stable/6.6: [8b5ed7c5417b7013d35b6f2507dab739013ba1a9]

CVE-2026-46250: MIPS: Work around LLVM bug when gp is used as global
register variable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46250

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
cip/4.19-st: [512fb475b00016996cdec9f308ddb9775912a1c7]
mainline: [30bfc2d6a1132a89a5f1c3b96c59cf3e4d076ea3]
stable/5.10: [05bff9b0ae095b2420cfebb4a96759a09334bec6]
stable/5.15: [1fe3b402b1e97a1718df3be0a1d3eee20133e735]
stable/6.1: [4dc65b40fb80c2020efbf139b9a38d30f9a37b92]
stable/6.12: [e3a6498a63394218561065a9a7a597a204f52f6a]
stable/6.18: [561834f6d6f52b8a1791331e94b2aac753491d2a]
stable/6.6: [c0155dee51b9f5f48aaf5c71cae005eb0e36521f]

CVE-2026-46251: btrfs: fix block_group_tree dirty_list corruption

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46251

Introduced by commit 14033b0 ("btrfs: don't save block group root into
super block") in v6.1-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a1f4264daed4b419c325a7fe35e756cada3cf82]
stable/6.1: [6e10283b5519d987d880d71bec90cdc7f2ec62b3]
stable/6.12: [4eb830847d84276f1c8ea46541cfeeedaba1fb63]
stable/6.18: [80e1fda9c084dcf54819a12bc7682ec0afd2d8f4]
stable/6.6: [e3d1fd084319f8f0830b22f014c7af6a96b4497b]

CVE-2026-46252: regulator: core: fix locking in
regulator_resolve_supply() error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46252

Introduced by commit 36a1f1b ("regulator: core: Fix memory leak in
regulator_resolve_supply()") in v4.2-rc4.
Introduced by commit 8e5356a ("regulator: core: Clear the supply
pointer if enabling fails") in v4.7-rc1.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [497330b203d2c59c5ff3fa4c34d14494d7203bc3]

CVE-2026-46253: pstore/ram: fix buffer overflow in persistent_ram_save_old()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46253

Introduced by commit 201e4ac ("pstore/ram: Should update old dmesg
buffer before reading") in v3.5-rc4.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [ac13d7ba72df5c74cc1276fecdc5eebaf8f2c98a]
cip/4.4-st: [9a7aa6096256392f98d1057c82fc7d09dd9b9567]
mainline: [5669645c052f235726a85f443769b6fc02f66762]
stable/5.10: [58bda5a1d1ee98254383ef34f76b2c35140513ea]
stable/5.15: [06d2c8bd108cea503f6f6e13e47495ed1085275f]
stable/6.1: [2fa9a047c6a50ec80c3890dd623b85e237f0d1fd]
stable/6.12: [9a6fc69a570c0780834246d52c856cc3dbc2605f]
stable/6.18: [4f73486ca822305c1cf5b8ebc0b53a6ab3801a81]
stable/6.6: [cff0ef043e16feb5a02307c8f9d0117a96c5587c]

CVE-2026-46254: AppArmor: Allow apparmor to handle unaligned dfa tables

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46254

Introduced by commit e6e8bf4 ("apparmor: fix restricted endian type
warnings for dfa unpack") in v4.11-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [64802f731214a51dfe3c6c27636b3ddafd003eb0]
stable/6.12: [ec737e7fdf2f0ba7b203d4ec72cc915978b10e7e]
stable/6.18: [23f112bd6144e815153462e12d313ac3e7027168]

CVE-2026-46255: dmaengine: fsl-edma: don't explicitly disable clocks
in .remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46255

Introduced by commit a9903de ("dmaengine: fsl-edma: refactor using
devm_clk_get_enabled") in v6.6-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [666c53e94c1d0bf0bdf14c49505ece9ddbe725bc]
stable/6.12: [68feac21bd4de7ae4faba05704c404861d991fcf]
stable/6.18: [bda244871179543dd3be7d093236cb33b2fb1765]
stable/6.6: [533d495f15e4c88ad5246c7f90ae026702e28d75]

CVE-2026-46256: NFS/localio: prevent direct reclaim recursion into NFS
via nfs_writepages

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46256

Introduced by commit 70ba381 ("nfs: add LOCALIO support") in v6.12-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [67435d2d8a33a75f9647724952cb1b18279d2e95]
stable/6.18: [ae26a4cf2baf0a44c538dc093504d1994b02dade]

CVE-2026-46257: clocksource/drivers/timer-sp804: Fix an Oops when
read_current_timer is called on ARM32 platforms where the SP804 is not
registered as the sched_clock.

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46257

Introduced by commit 640594a ("clocksource/drivers/timer-sp804: Fix
read_current_timer() issue when clock source is not registered") in
v6.19-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [694921a93f3e3621e067afc545cedf6fe3b234a9]

CVE-2026-46258: gpio: cdev: Avoid NULL dereference in linehandle_create()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46258

Introduced by commit da7e394 ("gpio: convert linehandle_create() to
FD_PREPARE()") in v6.19-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6af6be278e3ba2ffb6af5b796c89dfb3f5d9063e]

CVE-2026-46259: procfs: fix missing RCU protection when reading
real_parent in do_task_stat()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46259

Introduced by commit 06fffb1 ("do_task_stat: don't take
rcu_read_lock()") in v2.6.26-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [dc487ccdbe36d1b4e77c21417ee19ecc3469d8d0]
cip/4.4-st: [34fa0caccdaa8585ddcbb2ce9e513172a897ce49]
mainline: [76149d53502cf17ef3ae454ff384551236fba867]
stable/5.10: [fefa0fcd78be465b7ad4c497fa6ec90d64194c04]
stable/5.15: [c93a33f28f915d446eea6fb3f0e1def0b3af1982]
stable/6.1: [1c8dc5b5517546c68ffae40b948336122bb61306]
stable/6.12: [73ec7c96601d61d52310c659145bb06d933a0fa6]
stable/6.18: [4f9ae386861e280b7631ca252f798d25575627ee]
stable/6.6: [0e64bd46a04a4fd61279aca9f53a664e9e5f7e7e]

CVE-2026-46260: ipv6: Fix out-of-bound access in fib6_add_rt2node().

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46260

Introduced by commit bbf4a17 ("ipv6: Fix ECMP sibling count mismatch
when clearing RTF_ADDRCONF") in v6.19.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [8244f959e2c125c849e569f5b23ed49804cce695]
stable/6.12: [bf5009a06e03ee9a51052bb59f2228a5e4e66260]
stable/6.18: [03b5051e02f5a3772eee57493ad697d4b505b0c2]
stable/6.6: [bcc60ad129ae1837cf809c81bff56ec8bfdb6b11]

CVE-2026-46261: spi: wpcm-fiu: Fix potential NULL pointer dereference
in wpcm_fiu_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46261

Introduced by commit 9838c18 ("spi: wpcm-fiu: Add direct map support")
in v6.2-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [888a0a802c467bbe34a42167bdf9d7331333440a]
stable/6.12: [2c538a0b3472e99c892c26f4940da38b7d87f632]
stable/6.18: [0f93a80eb3fd596ddc5730d05e0e8c88e1aa2891]
stable/6.6: [9e5cb7e67fbdb8320d68d87db882a92b36f6a1d9]

CVE-2026-46262: ASoC: fsl_xcvr: Revert fix missing lock in fsl_xcvr_mode_put()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46262

Introduced by commit f514248 ("ASoC: fsl_xcvr: fix missing lock in
fsl_xcvr_mode_put()") in v6.19.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/5.15 stable/6.1 stable/6.12
stable/6.18 stable/6.6

Fixed status
mainline: [9f16d96e1222391a6b996a1b676bec14fb91e3b2]
stable/5.15: [ae5a70e3e87c28edbaf9939cfef1bcbd9615420f]
stable/6.1: [30ffcad5edb56947dccc26f6816ab7a55b21a711]
stable/6.12: [b0f74f5d24fe3c73ef1369a811891198b54c1e8e]
stable/6.18: [9a2a5da002775376498e8814df4a87cd629a3a0c]
stable/6.6: [29b2fbe3498da3681a01b34e4a2259f8a1b89448]

CVE-2026-46263: drm/amd/display: Fix out-of-bounds stream encoder index v3

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46263

Introduced by commit 2728e9c ("drm/amd/display: add DC changes for
DCN351") in v6.9-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [abde491143e4e12eecc41337910aace4e8d59603]
stable/6.12: [29f3824b08a98d41ecbbfd33580630d7607f962e]
stable/6.18: [263e28add4f4472cfa95150d218955d1945aa413]

CVE-2026-46264: drm/xe/pf: Fix sysfs initialization

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46264

Introduced by commit 5c170a4 ("drm/xe/pf: Prepare sysfs for SR-IOV
admin attributes") in v6.19-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf7172cd25ed182f30af2cbb9f80c730dc717d8e]

CVE-2026-46265: RDMA/hns: Fix WQ_MEM_RECLAIM warning

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46265

Introduced by commit ffd541d ("RDMA/hns: Add the workqueue framework
for flush cqe handler") in v5.7-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0a26bbd3f99b7b03f072e3409aff4e6ec8af6f6]
stable/6.1: [12761bd0ae16a80f237c2a65ab1b1064076cc74a]
stable/6.12: [562c96b1393da2df3ea62173c84117b39da353b9]
stable/6.18: [0cbec8b49270f3f0600b8e3ef5e8f0d233dcea27]
stable/6.6: [70a5eb757ace5bd627a36f04d871eaf85def424d]

CVE-2026-46266: inet: RAW sockets using IPPROTO_RAW MUST drop incoming ICMP

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46266

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c89477ad79446867394360b29bb801010fc3ff22]
stable/6.12: [19e42490c89bac9a388f28179e66bebbef350f99]
stable/6.18: [531c1aec81bfe19d00af13da5531fbb8209e4bd2]
stable/6.6: [db76b75ede3810e7cf9cfea5067d4f3e0993768b]

CVE-2026-46267: nfc: hci: shdlc: Stop timers and work before freeing context

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46267

Introduced by commit 4a61cd6 ("NFC: Add an shdlc llc module to llc
core") in v3.7-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9efde1e537baed7648a94022b43836a348a074f]
stable/5.15: [c60f41022eaad2a1dafecd3ae6f249a3bd6d4b6e]
stable/6.1: [a24a676329d40481b2331bfa1418a679577dfd3a]
stable/6.12: [cf70cedce327833296ebe6043364d1e44b76a2ab]
stable/6.18: [276820278e9717cc7d4bb32381892dd3ddf418d4]
stable/6.6: [77eef9f2eef045c3c37a3df82d3e661afb866b98]

CVE-2026-46268: PCI/P2PDMA: Fix p2pmem_alloc_mmap() warning condition

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46268

Introduced by commit b7e2823 ("mm/mm_init: move p2pdma page refcount
initialisation to p2pdma") in v6.15-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb500023a75246f60b79af9f7321d6e75330c5b5]
stable/6.18: [eb9aa9f8010465d927864f5a35bdc5604b0ff51a]

CVE-2026-46269: pinctrl: canaan: k230: Fix NULL pointer dereference
when parsing devicetree

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46269

Introduced by commit d94a32a ("pinctrl: canaan: k230: Fix order of DT
parse and pinctrl register") in v6.17-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d8c128fb6c2277d95f3f6a4ce28b82c8370031f6]
stable/6.18: [3c7d637bfc3dfbd6471c68bd767f7eb8b5b09eba]

CVE-2026-46270: power: supply: rt9455: Fix use-after-free in
power_supply_changed()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46270

Introduced by commit e86d69d ("power_supply: Add support for Richtek
RT9455 battery charger") in v4.2-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [14089824bf261a0d5fa1957a9f18761249787b7f]
cip/4.4-st: [c20d6273c666b768d56aca53a77fded4e2b5578e]
mainline: [e2febe375e5ea5afed92f4cd9711bde8f24ee6d2]
stable/5.10: [d4e2e3c3caa26b93aa9f36d0a6824b584e2a8dfc]
stable/5.15: [62d753b916bd500bb269b7078cdab73198ab4718]
stable/6.1: [a39f8f06216f73ef40e71e2fe4ad071964c1fd36]
stable/6.12: [2178dc65d45e2f7bcaa8af8d80d100419bdab251]
stable/6.18: [64e15155095f39f4dec9b4659da1238ef8fc54d4]
stable/6.6: [af261f218a7606f93d2c786353d60bb4feb56ef0]

CVE-2026-46271: wifi: ath12k: do WoW offloads only on primary link

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46271

Introduced by commit 32f7b19 ("wifi: ath12k: support MLO as well if
single_chip_mlo_support flag is set") in v6.16-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e62102ac9b773bdb08475aa9ca24dea61ae98708]
stable/6.18: [7379837c3f9efa576dc2d716ebfaa3a113b3112f]

CVE-2026-46272: coresight: tmc-etr: Fix race condition between sysfs
and perf mode

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46272

Introduced by commit 296b01f ("coresight: Refactor out buffer
allocation function for ETR") in v6.5-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e6e43e82c79c97917cbe356c07e8a6f3f982ab53]
stable/6.18: [38a07194bbcddb18d77dad40ba9978d994c0b74c]

CVE-2026-46273: ibmveth: Disable GSO for packets with small MSS

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46273

Introduced by commit 8641dd8 ("ibmveth: Add support for TSO") in v4.2-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cc427d24ac6442ffdeafd157a63c7c5b73ed4de4]
stable/5.10: [86fc64584811d43c9ccd74447de58620189d8b77]
stable/5.15: [9a5e984d7af910e46dcbed3ce77873e000a4f77d]
stable/6.1: [1cdf5dbcec988d06f5f720bdf89e91073f77fa10]
stable/6.12: [db8012c631cb845e9ae2b4b531e17d86c9519755]
stable/6.18: [c1f261863e65b508f37416dfbc5c5d911c9b9233]
stable/6.6: [82bc89fbb82d9396fb4eaee8720ea85e2e787957]
stable/7.0: [3af24f0c4c31f18a4a2d927990759194832bb6e9]

* Updated CVEs

CVE-2021-47188: scsi: ufs: core: Improve SCSI abort handling

stable/5.10 was fixed.

Fixed status
stable/5.10: [9491bc16082d9a402c9099acbfffc89af6f9316f]

CVE-2022-48703: thermal/int340x_thermal: handle data_vault when the
value is ZERO_SIZE_PTR

stable/5.10 was fixed.

Fixed status
stable/5.10: [722588f17fd3d3a127e50718ec2caf22bd7e9daa]

CVE-2022-48816: SUNRPC: lock against ->sock changing during sysfs read

stable/5.15 was fixed.

Fixed status
stable/5.15: [fdc42287ae3f8a35cc2098307f52d7864b4bc8ed]

CVE-2022-49135: drm/amd/display: Fix memory leak

stable/5.10 was fixed.

Fixed status
stable/5.10: [5076315aaddd640bde896ec8d79423ed8ec83a59]

CVE-2022-49158: scsi: qla2xxx: Fix warning message due to adisc being flushed

stable/5.10 was fixed.

Fixed status
stable/5.10: [c7e01292eb8499ef044737fd2ba37d033552167c]

CVE-2022-49183: net/sched: act_ct: fix ref leak when switching zones

stable/5.10 was fixed.

Fixed status
stable/5.10: [9222a08be539cbb7a8e0d46cbc7ab9e4db273eb8]

CVE-2022-49803: netdevsim: Fix memory leak of nsim_dev->fa_cookie

stable/5.15 was fixed.

Fixed status
stable/5.15: [6d463ddd0107d4188229d996dcdd45c99bad8af7]

CVE-2022-49822: cifs: Fix connections leak when tlink setup failed

stable/5.10 was fixed.

Fixed status
stable/5.10: [775d6625f96b26b90b9be9164b855ea2c471c0e5]

CVE-2022-49961: bpf: Do mark_chain_precision for ARG_CONST_ALLOC_SIZE_OR_ZERO

stable/5.15 was fixed.

Fixed status
stable/5.15: [987b4c465ba28c662ca857be6c20fd2d96bc55f0]

CVE-2022-50073: net: tap: NULL pointer derefence in
dev_parse_header_protocol when skb->dev is null

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [8f90163f9e013c8fc791aab338aab44a46044cfc]
stable/5.15: [447ba770cfe798925f4923548b367fd49f0ee5f0]

CVE-2022-50116: tty: n_gsm: fix deadlock and link starvation in
outgoing data path

stable/5.15 was fixed.

Fixed status
stable/5.15: [5020173e7e7725110a8d4be1359bf1dfc4b1814d]

CVE-2022-50472: IB/mad: Don't call to function that might sleep while
in atomic context

stable/5.10 was fixed.

Fixed status
stable/5.10: [d45e6ccb8e98d8339631f32984d345a663e74ce2]

CVE-2022-50493: scsi: qla2xxx: Fix crash when I/O abort times out

stable/5.10 was fixed.

Fixed status
stable/5.10: [5f730e489e741c28fe6a5b3308e33c094462acb0]

CVE-2022-50552: blk-mq: use quiesced elevator switch when reinitializing queues

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [0f90015383cd3f1128bebfbe7a97122d97808046]
stable/5.15: [9646443f28f33ec545ae303e613c3f476fad4dc1]

CVE-2023-45896: fs/ntfs3: Add more attributes checks in mi_enum_attr()

stable/5.15 was fixed.

Fixed status
stable/5.15: [a7accf181a4709a6e380360372150cc4a1b6b89a]

CVE-2023-52682: f2fs: fix to wait on block writeback for post_read case

stable/5.15 was fixed.

Fixed status
stable/5.15: [2bfe8fdb674f71747553a65f2ef27e14c8880655]

CVE-2023-52737: btrfs: lock the inode in shared mode before starting fiemap

stable/5.15 was fixed.

Fixed status
stable/5.15: [e425191073a80906d8502b5179471cc58b0b9e9a]

CVE-2023-53133: bpf, sockmap: Fix an infinite loop error when len is 0
in tcp_bpf_recvmsg_parser()

stable/5.10 was fixed.

Fixed status
stable/5.10: [f0d52cc242f279c422b487dcaaccd98b99672fd0]

CVE-2023-53292: blk-mq: fix NULL dereference on q->elevator in
blk_mq_elv_switch_none

stable/6.1 was fixed.

Fixed status
stable/6.1: [988ddb77218d3975dd13dee7bb0e1fae098a9fdb]

CVE-2023-53421: blk-cgroup: Reinit blkg_iostat_set after clearing in
blkcg_reset_stats()

stable/5.10 was fixed.

Fixed status
stable/5.10: [58c135513562698f222a58ba07dbdfcfb268aa0d]

CVE-2023-53543: vdpa: Add max vqp attr to vdpa_nl_policy for nlattr length check

stable/5.15 was fixed.

Fixed status
stable/5.15: [baed19c108ac8287425b93a44985bbe9a0b1af8d]

CVE-2023-53545: drm/amdgpu: unmap and remove csa_va properly

stable/5.15 was fixed.

Fixed status
stable/5.15: [1bc35e637a81dac5f5155e83a277c26708c4d4d7]

CVE-2023-53596: drivers: base: Free devm resources when unregistering a device

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [83e2ec36a92432e9445e853c12becbbae353b511]
stable/5.15: [b9ef4b0aa91d2f9f5951faafdbbd47cf01799ec3]

CVE-2023-53629: fs: dlm: fix use after free in midcomms commit

stable/5.15 was fixed.

Fixed status
stable/5.15: [84d6ce2aef1d06a53f606211da68a2085dfeb50d]

CVE-2023-53989: arm64: mm: fix VA-range sanity check

stable/6.1 was fixed.

Fixed status
stable/6.1: [c7a9e967cc9615a1dabc5e0e6fdbe88a172d5a5b]

CVE-2023-54322: arm64: set __exception_irq_entry with __irq_entry as a default

stable/6.1 was fixed.

Fixed status
stable/6.1: [47d74b54180b6b296b489b7895011c9a28979ff1]

CVE-2024-26886: Bluetooth: af_bluetooth: Fix deadlock

stable/5.15 was fixed.

Fixed status
stable/5.15: [60673f442984fe689d4127a5dd4be414247b3d67]

CVE-2024-27389: pstore: inode: Only d_invalidate() is needed

stable/5.15 was fixed.

Fixed status
stable/5.15: [d0ee2a8adb6673382cce8a4280e1ca0849b3b783]

CVE-2024-35865: smb: client: fix potential UAF in smb2_is_valid_oplock_break()

stable/5.15 was fixed.

Fixed status
stable/5.15: [a710ef9e974f18232d2b9b19c90eda1a1167b2d4]

CVE-2024-36922: wifi: iwlwifi: read txq->read_ptr under lock

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [f30e8af109818c9db08cbcc46eb9713fe4b530ba]
stable/6.1: [aab7b39fcac5f6165f6434bcbb56bb7865d4ad2b]

CVE-2024-41079: nvmet: always initialize cqe.result

stable/5.15 was fixed.

Fixed status
stable/5.15: [c6a2cf8b0764f3ba7d9bff58c8775a6d4476bb29]

CVE-2024-43902: drm/amd/display: Add null checker before passing variables

stable/5.10 was fixed.

Fixed status
stable/5.10: [ea000e4b4ee5363997715531cb3d024b4e5d561c]

CVE-2024-46770: ice: Add netif_device_attach/detach into PF reset flow

stable/5.15 was fixed.

Fixed status
stable/5.15: [721f27f489a47ed0d8690b73fc1f070c2eb180cf]

CVE-2024-47809: dlm: fix possible lkb_resource null dereference

stable/5.15 was fixed.

Fixed status
stable/5.15: [e1ffea6bec96d4349dbfcc42ad3e436259f64243]

CVE-2024-49925: fbdev: efifb: Register sysfs groups through driver core

stable/5.15 was fixed.

Fixed status
stable/5.15: [2d97b85eb5a86766ad0f8ea3d121e6ae144e3ed8]

CVE-2024-50012: cpufreq: Avoid a bad reference count on CPU node

stable/5.15 was fixed.

Fixed status
stable/5.15: [2b846344b15f933a56903b7cdba9080f06c725ff]

CVE-2024-53213: net: usb: lan78xx: Fix double free issue with
interrupt buffer allocation

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [cc5aa8e3ad69dcedeba79e667d4a2efb72a305af]
stable/5.15: [2970ef2fce90c661952ec2b451b0276d5f8d6180]

CVE-2024-53221: f2fs: fix null-ptr-deref in f2fs_submit_page_bio()

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [4289be8465924748daa9bf14866eb7f0987d4e39]
stable/6.1: [bd9197b72d772be7bccc3b66c83a3157cfe2f96f]

CVE-2024-56647: net: Fix icmp host relookup triggering ip_rt_bug

stable/6.1 was fixed.

Fixed status
stable/6.1: [d50981aaaefc3b04490fbc8274d37881a2b1b112]

CVE-2024-56657: ALSA: control: Avoid WARN() for symlink errors

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [4e5a92a7223c83c1f5f2db6cd010ac9347948972]
stable/6.1: [365ee29e559269cbb2108c4cc05dd8e262b4e84e]

CVE-2024-56719: net: stmmac: fix TSO DMA API usage causing oops

stable/5.15 was fixed.

Fixed status
stable/5.15: [05968b6dd0ffc65d7386608b11a11fb4fdfc9f36]

CVE-2024-56727: octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_flows.c

stable/5.15 was fixed.

Fixed status
stable/5.15: [e3c4e78d636e6dbd8ed72e41b311de2bb7e0b699]

CVE-2024-57945: riscv: mm: Fix the out of bound issue of vmemmap address

stable/5.10 was fixed.

Fixed status
stable/5.10: [04350304428063da6a55a8a4597d409dc69148b2]

CVE-2025-21712: md/md-bitmap: Synchronize bitmap_get_stats() with
bitmap lifetime

stable/5.15 was fixed.

Fixed status
stable/5.15: [eb2f9d98cd3e94a79fbf8fb90637c5b12e805428]

CVE-2025-21739: scsi: ufs: core: Fix use-after free in init error and
remove paths

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [0a6895c03b1f439236e2d22b1a69ebfc1eb9d5ea]
stable/6.1: [d06eb2620d3bf16056b8b7ea3744dbb5e30512f4]

CVE-2025-21845: mtd: spi-nor: sst: Fix SST write failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [f791837015a0d20f584d0ed368393f119a00018f]

CVE-2025-21847: ASoC: SOF: stream-ipc: Check for cstream nullity in
sof_ipc_msg_data()

stable/6.1 was fixed.

Fixed status
stable/6.1: [dfe25c554daa12ee26eb3540bbded57733ed5d9c]

CVE-2025-21863: io_uring: prevent opcode speculation

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [18eae8420081ef8e043ad455937bfb470ef08607]
stable/6.1: [d261ead565a080e3411b0dd04e6d58a52471cac8]

CVE-2025-22069: riscv: fgraph: Fix stack layout to match
__arch_ftrace_regs argument of ftrace_return_to_handler

stable/6.12 was fixed.

Fixed status
stable/6.12: [7ed384db061a264bd806898f7ccab9b98b591488]

CVE-2025-22105: bonding: check xdp prog when set bond mode

stable/6.1 was fixed.

Fixed status
stable/6.1: [074de2f6706ea840bbf06599cdc194086fbae092]

CVE-2025-22107: net: dsa: sja1105: fix kasan out-of-bounds warning in
sja1105_table_delete_entry()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [f85b9bfb08ba2b642d1810c6c4ae1e7b46f1776a]
stable/5.15: [f117d0467215d7f1d445ae16d2c799637e63dc6c]

CVE-2025-23141: KVM: x86: Acquire SRCU in KVM_GET_MP_STATE to protect
guest memory accesses

stable/5.15 was fixed.

Fixed status
stable/5.15: [56d997b257075951a46663970cd350cd5e34c041]

CVE-2025-37864: net: dsa: clean up FDB, MDB, VLAN entries on unbind

stable/6.1 was fixed.

Fixed status
stable/6.1: [5e531e71b9d21d5e985251440e0d722f71299b7a]

CVE-2025-38105: ALSA: usb-audio: Kill timer properly at removal

stable/5.15 was fixed.

Fixed status
stable/5.15: [06513dd6d32c37d0364db8488cfdf3e14da238a8]

CVE-2025-38192: net: clear the dst when changing skb protocol

stable/5.15 was fixed.

Fixed status
stable/5.15: [a046f183d21ab5ace5a96ece4cf9873a42f003a7]

CVE-2025-38250: Bluetooth: hci_core: Fix use-after-free in vhci_flush()

stable/5.15 was fixed.

Fixed status
stable/5.15: [90dee0a0ff84fac8accd5be98412b3819f667149]

CVE-2025-38584: padata: Fix pd UAF once and for all

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [a2048e475e22b13dc3e53d485b7e6e11464ed9a6]
stable/5.15: [73f132e60857038416540c3599b1de6033d7575a]
stable/6.1: [609e59193fc6d9dd323f1c6ae1fdd721f1c79680]

CVE-2025-38626: f2fs: fix to trigger foreground gc during
f2fs_map_blocks() in lfs mode

stable/5.15 was fixed.

Fixed status
stable/5.15: [c737047f4665232d1e26b3620bc62df334545451]

CVE-2025-38627: f2fs: compress: fix UAF of f2fs_inode_info in f2fs_free_dic

stable/6.1 was fixed.

Fixed status
stable/6.1: [74cbeeca4f16823ba58c882e1d8b836c0e39c93d]

CVE-2025-38659: gfs2: No more self recovery

stable/5.15 was fixed.

Fixed status
stable/5.15: [69cf5699a402ee7ae1be53954dc2ae652c0a053c]

CVE-2025-38710: gfs2: Validate i_depth for exhash directories

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [076e992752e4b24178918f748d75597c80a408d2]
stable/5.15: [366183911b153e9b8cf758e1414e1154d7569337]
stable/6.1: [112bb60cd0e254a369e95aa9941a694ffeca089f]

CVE-2025-39997: ALSA: usb-audio: fix race condition to UAF in snd_usbmidi_free

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [e63f049c7764b615d1d50cb486745fa63372b42d]
stable/6.1: [e16985513e89466a236d2a7c202783b4dd0c5a46]

CVE-2025-40005: spi: cadence-quadspi: Implement refcount to handle
unbind during busy

stable/5.15 was fixed.

Fixed status
stable/5.15: [8ce3ebbe5c718940b4e94f5c25f5720223f893f8]

CVE-2025-40163: sched/deadline: Stop dl_server before CPU goes offline

stable/6.12 was fixed.

Fixed status
stable/6.12: [d7fd56ed5e07e053a5eea6112d61fcaded653b87]

CVE-2025-40347: net: enetc: fix the deadlock of enetc_mdio_lock

stable/6.1 was fixed.

Fixed status
stable/6.1: [a649161526736f48bcc592e3a412e5bcd7dd9e24]

CVE-2025-68201: drm/amdgpu: remove two invalid BUG_ON()s

stable/6.1 was fixed.

Fixed status
stable/6.1: [7281d5b698d60fa46d17cd36ee8c5192fea9428d]

CVE-2025-68239: binfmt_misc: restore write access before closing files
opened by open_exec()

stable/5.15 was fixed.

Fixed status
stable/5.15: [54274ff90488b6c0f595a6518faed3cf0bc966eb]

CVE-2025-68307: can: gs_usb: gs_usb_xmit_callback(): fix handling of
failed transmitted URBs

stable/5.15 was fixed.

Fixed status
stable/5.15: [87974ebd6552817492daec7866ebfa2c484fa2ac]

CVE-2025-68315: f2fs: fix to detect potential corrupted nid in free_nid_list

stable/6.1 was fixed.

Fixed status
stable/6.1: [88b2ddb0c4f1dc874d4598e78cc830c64315ed86]

CVE-2025-68823: ublk: fix deadlock when reading partition table

stable/6.1 was fixed.

Fixed status
stable/6.1: [27bb79b7717b2fbb111a1c13548b2786ee712dca]

CVE-2025-71161: dm-verity: disable recursive forward error correction

stable/5.15 was fixed.

Fixed status
stable/5.15: [8b821ca892cfeeaf0bedc9fc72717294f67144d5]

CVE-2025-71221: dmaengine: mmp_pdma: Fix race condition in mmp_pdma_residue()

stable/5.15 was fixed.

Fixed status
stable/5.15: [3f0e0e2d9e752570041e95fd04635e2580097819]

CVE-2025-71289: fs/ntfs3: handle attr_set_size() errors when truncating files

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [3a718675d6af4992e34ffe86b8f36d471a5afe0e]
stable/6.18: [d73dcd1520d65a34420761641a36b951b14c8c53]

CVE-2026-23066: rxrpc: Fix recvmsg() unconditional requeue

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [8fd3b5e297854a4da0f273169baf4b1b7b257b97]
stable/5.15: [c198628f3fca5c874d93874c233014d336e09f64]
stable/6.1: [c6cebcb4e0b3140ec2ace45c020a9049527385d1]

CVE-2026-23141: btrfs: send: check for inline extents in
range_is_hole_in_parent()

stable/5.15 was fixed.

Fixed status
stable/5.15: [901e581bfc44d181f7d9c3f11880dac3e89deb2e]

CVE-2026-23157: btrfs: do not strictly require dirty metadata
threshold for metadata writepages

stable/5.15 was fixed.

Fixed status
stable/5.15: [6a8b6242eaa1dd7a0de2d6de6420d10ffe68db90]

CVE-2026-23204: net/sched: cls_u32: use skb_header_pointer_careful()

stable/5.15 was fixed.

Fixed status
stable/5.15: [29681ed51e737be14d18ecd1c304c57002e4b72c]

CVE-2026-23255: net: add proper RCU protection to /proc/net/ptype

stable/6.1 was fixed.

Fixed status
stable/6.1: [e974a10a52618f7f57a4bce173a0ed96acd4e5dc]

CVE-2026-23327: cxl/mbox: validate payload size before accessing
contents in cxl_payload_from_user_allowed()

stable/6.18 was fixed.

Fixed status
stable/6.18: [dc184ac2f0ba77ae19725ee06ad3ab36bb9d1f61]

CVE-2026-23371: sched/deadline: Fix missing ENQUEUE_REPLENISH during
PI de-boosting

stable/6.18 was fixed.

Fixed status
stable/6.18: [0638bf16b7a73a2fe63624bd0d16d9fd904805c3]

CVE-2026-23389: ice: Fix memory leak in ice_set_ringparam()

stable/6.1 was fixed.

Fixed status
stable/6.1: [bddf04e3822e4fa38691433dd0750420d49a0dd6]

CVE-2026-23394: af_unix: Give up GC if MSG_PEEK intervened.

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [e3dd56fb5683ba80bf8d7a2f9aa21cfa53f05202]
stable/6.6: [3106f326f67c03dd9da4ca64663d11e40138cf40]

CVE-2026-23399: nf_tables: nft_dynset: fix possible stateful
expression memleak in error path

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [eb7bf413e59945df03d4567b73ce464eebe2f4ea]
stable/6.1: [4357dbb1d9c35ca0b4443d71c98a48e6666f7689]

CVE-2026-23442: ipv6: add NULL checks for idev in SRv6 paths

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [0348fa0ada37cef7c6b5ab2a428bb2c6aee784e4]
stable/5.15: [83d705d35e583cb1b1eacf196dfe7b77d442018e]
stable/6.1: [d1bd8b9edc6752d10f84d28ff64f842401ce336d]

CVE-2026-23444: wifi: mac80211: always free skb on
ieee80211_tx_prepare_skb() failure

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [905ef207d5ed99ca64adfe39fba9ac46e434327a]
stable/5.15: [5ef8ca1c164786da24169af155c1ca1ff1353cf8]
stable/6.1: [9a779d1f480e83720b5384adf165604e7ee226bd]

CVE-2026-23468: drm/amdgpu: Limit BO list entry count to prevent
resource exhaustion

stable/6.1 was fixed.

Fixed status
stable/6.1: [c833d6c7199c5b5fca9ec95593acd539ec9c171c]

CVE-2026-23469: drm/imagination: Synchronize interrupts before
suspending the GPU

stable/6.12 was fixed.

Fixed status
stable/6.12: [50257450196e4bba11c562117847ea409660a7de]

CVE-2026-23473: [REJECTED]: io_uring/poll: fix multishot recv missing
EOF on wakeup race

stable/6.1 was fixed.

Fixed status
stable/6.1: [3c7f635c60a3512b7912602df804ca7cd1cd3659]

CVE-2026-31407: netfilter: conntrack: add missing netlink policy validations

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [e7b5766693477c52424cc6c79dd30a7a9c7db52c]
stable/5.15: [78bba9f73942aa7dca47d817d8cec0fb9b443b70]
stable/6.1: [be88a337bf07afb1ee173f1099294d1b7ab3fefe]

CVE-2026-31409: ksmbd: unset conn->binding on failed binding request

stable/5.15 was fixed.

Fixed status
stable/5.15: [7e8b270813079c785696bce8802a3f920665c88c]

CVE-2026-31420: bridge: mrp: reject zero test interval to avoid OOM panic

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [630a15a31c2034b5b697f4aabc769b9d80d82446]
stable/6.18: [e8ec80430bfa520e7352155d6ac632e527cba7aa]

CVE-2026-31449: ext4: validate p_idx bounds in ext4_ext_correct_indexes

stable/6.1 was fixed.

Fixed status
stable/6.1: [10242e640b36b91ad03d25f3dc77854bbdff8358]

CVE-2026-31476: ksmbd: do not expire session on binding failure

stable/5.15 was fixed.

Fixed status
stable/5.15: [4642ea35c03cf3d3558c009df4757cdb7af3f82d]

CVE-2026-31486: hwmon: (pmbus/core) Protect regulator operations with mutex

stable/6.12 was fixed.

Fixed status
stable/6.12: [acf04e2863132f6d9222f71f3a76fb9782cbe061]

CVE-2026-31488: drm/amd/display: Do not skip unrelated mode changes in
DSC validation

stable/6.1 was fixed.

Fixed status
stable/6.1: [da1d0ed31e9802fd99384f43cc63678a5a11cb41]

CVE-2026-31489: spi: meson-spicc: Fix double-put in remove path

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [d61bcec3aec6f0244a9b963e0c76c00f771d49b6]
stable/6.1: [7434c64ddae88a02e7fb478bc256cc100d48d3e3]

CVE-2026-31500: Bluetooth: btintel: serialize btintel_hw_error() with
hci_req_sync_lock

stable/6.1 was fixed.

Fixed status
stable/6.1: [7e041d0aad1d4d43d921ace052e04f4e2cacaed3]

CVE-2026-31527: driver core: platform: use generic driver_override
infrastructure

stable/6.6 was fixed.

Fixed status
stable/6.6: [492349e5e4a369a8b62781100a3ade470bf1ce6b]

CVE-2026-31532: can: raw: fix ro->uniq use-after-free in raw_rcv()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [1de30576a6dfeaaa27ef91fa272e6b9240b6fbd3]
stable/5.15: [64c8553decf5a5f2417bd54761ea0a832c56c4ca]
stable/6.1: [3f43f12fde34737fba091b7e3ab391e14ddbb0be]

CVE-2026-31560: spi: spi-dw-dma: fix print error log when wait finish
transaction

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [b8188ff3cfaa5621212b08473488cdbe41f86531]
stable/6.18: [aae4a47073b12c23eb1d2c5401bda442fbe27bd1]

CVE-2026-31576: media: hackrf: fix to not free memory after the device
is registered in hackrf_probe()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [87b9685cca91ed715c39ba544715832d26a7f4b4]
stable/5.15: [131ec9046e1c8af101aebdaec4e8095e05f3312b]
stable/6.1: [67fd62e3efdc9dce01f76d95a745212f4feb38e6]

CVE-2026-31577: nilfs2: fix NULL i_assoc_inode dereference in
nilfs_mdt_save_to_shadow_map

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [6637bbcfb59df5b732a79e5ab1a74886a0b93d59]
stable/5.15: [837c7a59fb58f81b0db33848357f6a5d0d1250ad]
stable/6.1: [7902b1df1520a0880bcda7a3704cfacd17905a83]

CVE-2026-31578: media: as102: fix to not free memory after the device
is registered in as102_usb_probe()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [0d36653a3a821e5a974798adb347b3ea09332914]
stable/5.15: [25d500cf391e384356a612b85cf60b353ad3cd0c]
stable/6.1: [07ceb444c8f627cf863864d4274b5a77769725ed]

CVE-2026-31580: bcache: fix cached_dev.sb_bio use-after-free and crash

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [81f44ed8c3f54abb7561ece774ea4cca5070b2f2]
stable/5.15: [f50e7c325ab1207fe941555bcff659f6d7050572]
stable/6.1: [9467d360be70e6ee55b0c1cd2a1f1424f57b5b85]

CVE-2026-31581: ALSA: 6fire: fix use-after-free on disconnect

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [e719232f4552e29de8027a83918ea94434be87af]
stable/5.15: [e247a0e01d15ed420f77ec5e2335721bf430a5b3]
stable/6.1: [ba88461f7653636c48321ca993006a74724c2f41]

CVE-2026-31583: media: em28xx: fix use-after-free in em28xx_v4l2_open()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [3c0283a59e36e3707c4a81f4952e362d31f876b8]
stable/5.15: [2cbf81f76842e46bdf25823c70e1db4044a65678]
stable/6.1: [38a327221f7f765e7d853b7bafe47e342441ec85]

CVE-2026-31585: media: vidtv: fix nfeeds state corruption on
start_streaming failure

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [f8cccb427e65d725fc0ba05e8900b4676eda268e]
stable/5.15: [60f768d46df561e06d92ffcacc00909f37a0f23d]
stable/6.1: [80900b5424f3454256153ce386388df43b324f63]

CVE-2026-31586: KVM: SEV: Protect *all* of
sev_mem_enc_register_region() with kvm->lock

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [23acef4156c260e8598397a1a2e8b3a23e919893]
stable/5.15: [1bd36e93b542d9dd020190c6607c6a3663405195]
stable/6.1: [740ba1ebb223f137ff088ab74d533a13f9167bd8]

CVE-2026-31587:  ASoC: qcom: q6apm: move component registration to
unmanaged version

stable/6.1 was fixed.

Fixed status
stable/6.1: [110769a9aa51135ac7ce479a47dfb41924f37664]

CVE-2026-31588: KVM: x86: Use scratch field in MMIO fragment to hold
small write values

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [019d0bd32b9a4646ba35d904907452039e2db700]
stable/5.15: [4569c66dd9e94a22cd0796b6514a8b25ffff16a1]
stable/6.1: [52570e73d48f1c73836d37e594667117b4c2a5a8]

CVE-2026-31590: KVM: SEV: Drop WARN on large size for
KVM_MEMORY_ENCRYPT_REG_REGION

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [6a8e3c82122737529b25ef2a048fbcc569d8c055]
stable/5.15: [a703933bcfa5cc76ca10e2048464600e74136099]
stable/6.1: [abcd43ff579abd0a654bb4636086e78819dd5f4c]

CVE-2026-31594: PCI: endpoint: pci-epf-vntb: Remove duplicate resource teardown

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [305a0674bc552bfcc3231e23fb91cf4f62aec168]
stable/6.1: [b261027a1a235d8925e332363f23135a0eff2b35]

CVE-2026-31595: PCI: endpoint: pci-epf-vntb: Stop cmd_handler work in
epf_ntb_epc_cleanup

stable/6.1 was fixed.

Fixed status
stable/6.1: [b2eb405bbced3a6e772545e1b74dbde37cee1f8f]

CVE-2026-31596: ocfs2: handle invalid dinode in ocfs2_group_extend

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [7eafcf507fbd68f3276c00f6c02ef155ad69f79b]
stable/5.15: [fabfa6b81bd386154d7e59f8cd8f760f9e68b48c]
stable/6.1: [b328d8e7c437d0f026ba2c13788af6eae77700f1]

CVE-2026-31597: ocfs2: fix use-after-free in ocfs2_fault() when VM_FAULT_RETRY

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [36539c4d536f851a3b346a6ebb27b51bc3d77a94]
stable/5.15: [35c2c05261d6f6d84aaa1355afa201d507943e76]
stable/6.1: [3f5e74b5db9353b01ed50f4de84e75b755f8fbc2]

CVE-2026-31598: ocfs2: fix possible deadlock between unlink and dio_end_io_write

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [297d8d7bb6a2bf133d3a3636edbdf94101cbd719]
stable/5.15: [32630dee18c6bb2175c8a865a474749492eaf19c]
stable/6.1: [93f35419eb84d58820040642cb6e7528fe4aba7a]

CVE-2026-31599: media: vidtv: fix NULL pointer dereference in
vidtv_channel_pmt_match_sections

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [54e18a23e62e81b8335cec3e8e9c5cb33fd88665]
stable/5.15: [5c986b77200b5ea754ba6636deacc7e0942fec9b]
stable/6.1: [93d9e747a9e8a5ca9e3c5e37dcff76b40399139f]

CVE-2026-31602:  ALSA: ctxfi: Limit PTP to a single page

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [c5908160e17cb56e1f61fbaee08adc21083f4933]
stable/5.15: [de8016fb0904d68ac886e375069535996baa42ee]
stable/6.1: [2b4331c08c0b385598b4d8ccd71e93ab3f4b2578]

CVE-2026-31603: staging: sm750fb: fix division by zero in ps_to_hz()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [124a43550db8a74eef080cd4573a4904efe67029]
stable/5.15: [b285a8f3bbb821a93eb37c2740a68ca1d7112a59]
stable/6.1: [3300b049693138852a4c6738b5f1194a1ee91ddd]

CVE-2026-31605: fbdev: udlfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [9981de9fb5ae0d3d6bc5ff5ca63350c2a3cdc564]
stable/5.15: [fd50ab7dd4ee5bbb4aebffa76ae18484b03a8ea5]
stable/6.1: [828ce54b27de93bd9c67991bca5a2c76c76742de]

CVE-2026-31607:  usbip: validate number_of_packets in usbip_pack_ret_submit()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [324262c38438255bf6bdbf6342ca47c0badaab76]
stable/5.15: [973f2c250289f5bf6cc146b98aa6fdde11fe50d6]
stable/6.1: [ce744264b06b97069b3722511ab355738311fee0]

CVE-2026-31611: ksmbd: require 3 sub-authorities before reading sub_auth[2]

stable/6.1 was fixed.

Fixed status
stable/6.1: [cf2148b880fb7c0fcd727202dbc4fd5d6998b9c2]

CVE-2026-31612: ksmbd: validate EaNameLength in smb2_get_ea()

stable/6.1 was fixed.

Fixed status
stable/6.1: [859f11e1bc81a4d32bb3ceeae54bcd296ac675d3]

CVE-2026-31613: smb: client: fix OOB reads parsing symlink error response

stable/6.1 was fixed.

Fixed status
stable/6.1: [043834e72337ee7b4e9685859888623ba1504ac7]

CVE-2026-31615: usb: gadget: renesas_usb3: validate endpoint index in
standard request handlers

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [7caaf76207f50c77abfd788380e19b2c23a94415]
stable/5.15: [c4e5ae6db2328d2d9ed55d3005a36c13faab0752]
stable/6.1: [360aa6e71870a175a6d86af905be2ca171639eb3]

CVE-2026-31616: usb: gadget: f_phonet: fix skb frags[] overflow in
pn_rx_complete()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [3d7f7e0c842242878c24b2facff8d6eda23ee1e9]
stable/5.15: [b5ec49fa198bd08967a3102bd41f53ccadce72c9]
stable/6.1: [7424f0287da73d3d8c5fa5e9d25d26fce762708e]

CVE-2026-31617: usb: gadget: f_ncm: validate minimum block_len in
ncm_unwrap_ntb()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [068a7f2749fff6462a0a908ec415b885fe430f50]
stable/5.15: [1425655c2870054c3ab4712e2b6dbdd331597ada]
stable/6.1: [8b3b7bd3c02f98634baaf36c7fc7ac915f6517ca]

CVE-2026-31618: fbdev: tdfxfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [2f207e46c62688bb7eb4e3feaf9a0d94020fb0c9]
stable/5.15: [6c05191598eca87a87329b3f6e4a0825775f09cf]
stable/6.1: [59bde9e0930efef1286768cb65fc78d5e5267f93]

CVE-2026-31619: ALSA: fireworks: bound device-supplied status before
string array lookup

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [183aa0de0f680496b9feb85c9d182681ad4600dd]
stable/5.15: [62fcb273fbee5b2a0e7ed41cc914c8d7d1a5d285]
stable/6.1: [327f8e730e3c65ec97df9d3b07de66aeb3dc932d]

CVE-2026-31622: NFC: digital: Bounds check NFC-A cascade depth in SDD
response handler

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [9ba6bb09e00b922d902f684f575779e5433fe6e3]
stable/5.15: [f83b399aa05a0712e3b1569a30d3d90b3533d2ef]
stable/6.1: [20663102c14566e900e1d2f679e30b7f1694f387]

CVE-2026-31623: net: usb: cdc-phonet: fix skb frags[] overflow in rx_complete()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [6807ff49bf796b3823b1e29f97b69316a40a9a94]
stable/5.15: [0c5c65a17db729fc63ab656bdaaf0e675a9dbeac]
stable/6.1: [6053620fdbcd89fa7e755644efdaab78e0daaae7]

CVE-2026-31624: HID: core: clamp report_size in s32ton() to avoid
undefined shift

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [76ad02854a30c394e0c076e6e6bed0a388573a94]
stable/5.15: [eb415ddaf25e09ddb8fe5736a70c9de2e6462534]
stable/6.1: [0ab048dbdb1daacf17d52e9252297eb6e1298e49]

CVE-2026-31625: HID: alps: fix NULL pointer dereference in alps_raw_event()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [56850666bb5dcf7a13d76c5d02864813e17ee537]
stable/5.15: [72516a8d7fe247fd895424bab87952f105a0c255]
stable/6.1: [cc411e4823d8bfa23327d9989a0fa4e0ce76aebe]

CVE-2026-31626: staging: rtl8723bs: initialize le_tmp64 in rtw_BIP_verify()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [6792624d933146e2757b07092e93ad915cb58930]
stable/5.15: [51532c7c1d357145f4ac561648499f7a6847f739]
stable/6.1: [9e911eead187240193516edf55a0e1ab3425aa5b]

CVE-2026-31627: i2c: s3c24xx: check the size of the SMBUS message
before using it

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [fd1650da24ed54c716aa9b69e9bbd8a662e492da]
stable/5.15: [8f756a5964396da0fc9e0db33253a5b85dbbcbb6]
stable/6.1: [2d262da4bca6fab96e2e709feb95b31b0a9a03a7]

CVE-2026-31629: nfc: llcp: add missing return after LLCP_CLOSED checks

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [b2a23529593d011fb433a3d711fc597ed6a6bd2f]
stable/5.15: [665315df9c3486cb213fc44d83cc8bcd47fe0d26]
stable/6.1: [9b49e2a4b8219a2fc5cebf94f4ec34e509aff8a6]

CVE-2026-31630: rxrpc: proc: size address buffers for %pISpc output

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [386c86412608d3449006a318a662cbcd6ca1f668]
stable/5.15: [235b2115de892eab2e107a42efa7a4347baaa80b]
stable/6.1: [625af53a1564e31bb2df9adc3739df46137f46c1]

CVE-2026-31634: rxrpc: fix reference count leak in rxrpc_server_keyring()

stable/5.10 was fixed.

Fixed status
stable/5.10: [45d9584e51bdd61faf1900f82666d4ea6a85da72]

CVE-2026-31637: rxrpc: reject undecryptable rxkad response tickets

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [252157d939d179b5d767cb860ff8fa7f8723b67a]
stable/5.15: [a75b3b361dd481d942c5f259a82d59718a41092c]
stable/6.1: [b3a808cd0790b5075aaa2bc3588edf02cd71d352]

CVE-2026-31642: rxrpc: Fix call removal to use RCU safe deletion

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [3e47a38e584b905359fe0ce5be5165d1e8592a90]
stable/5.15: [b15b1ce96777b88989a6a4de8d01efbcd81ad2d7]
stable/6.1: [280efb85e9759881a9d31d0874baa04583cb6c09]

CVE-2026-31656: drm/i915/gt: fix refcount underflow in
intel_engine_park_heartbeat

stable/5.10 was fixed.

Fixed status
stable/5.10: [82034799c6c14b3104668878c3f3e5786f777126]

CVE-2026-31657: batman-adv: hold claim backbone gateways by reference

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [5202f071b367ffbc8e279fc7a00db14f5e587f52]
stable/5.15: [69d1ce9c72eca91203ffdb8d08bacd511100aec6]

CVE-2026-31664: xfrm: clear trailing padding in build_polexpire()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [a5127501c8d30b5728791b1e340284ca5c9cc4bd]
stable/5.15: [e6f4ffe8596947a595c9544e73a73adcb0568b88]

CVE-2026-31673: af_unix: read UNIX_DIAG_VFS data under unix_state_lock

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [e7339db13b9ddb63417b12da55fd6191e59f7442]
stable/5.15: [4f6a8f10182c3a9d22e8eb183957ae7ade9e4bf7]
stable/6.1: [c3ec44ab4526bbc4b6c9fc845af86488244f4c9b]

CVE-2026-31676: rxrpc: only handle RESPONSE during service challenge

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [a1a8efde03a40b6c658d580e96644d9b9a2a0d3a]
stable/5.15: [6c3a0fbdafef8316e34ae22333e317a341e737cd]
stable/6.1: [0afdfd4941c1b60a1f5c361760daa970edca60cd]

CVE-2026-31681: netfilter: xt_multiport: validate range encoding in checkentry

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [8c5bf8f5b478f569191c4a7982de7cd5f5f73c1a]
stable/5.15: [c9749f6232c845e31c21d4cc72200211df15d8a2]
stable/6.1: [b67d638cbee9975c765feb45c126e96ed11ec802]

CVE-2026-31684: net: sched: act_csum: validate nested VLAN headers

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [0410c619e86551677fb79887a38eccad3f5a0725]
stable/5.15: [886469b6455611a511aa6013e957e15e50577513]
stable/6.1: [46c07ad50fa2f4ba7663ee1b72b75ad7ad45cf09]

CVE-2026-31685: netfilter: ip6t_eui64: reject invalid MAC header for all packets

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [4d75bc2cd093bf5803edf512c099bfb220fd6459]
stable/5.15: [7d6a57411caf54df025860c9b1a82cd42d57a562]
stable/6.1: [d5603591373441fecf9951833d6d873e09320f08]

CVE-2026-31686: mm/kasan: fix double free for kasan pXds

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [7d7b2d5c107a1f6302cf0006d859985e7c3ddd1c]
stable/5.15: [3298bdf5a878ded06351eb293856fa84e050029e]
stable/6.1: [2277246ea265cdca64ce6fdea4b26cd6ff0ec4db]

CVE-2026-31694: fuse: reject oversized dirents in page cache

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [3059f9abe7f1ba8fddf3c86c5faa1eeacf07e7d4]
stable/5.15: [1d4a517fa90480c52fd452fea2686cd80f773ce2]
stable/6.1: [038e61812fa52ef62bad2cfc96bf37dc0db47c1e]

CVE-2026-31696: rxrpc: Fix missing validation of ticket length in
non-XDR key preparsing

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [44714dfda386884919ba366411880b6fb3c3efd3]
stable/5.15: [41a117dd80371343babc52198d1114e83eb37627]
stable/6.1: [9a397aa9b5e53ca63d4d6aefb542832eca389618]

CVE-2026-31697: crypto: ccp: Don't attempt to copy ID to userspace if
PSP command failed

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [99bae2e3c3f9ba8f854c938ed2c811b6a63b28e4]
stable/5.15: [a21ae9f8769e5f75433bb0a85ac3868b2100ef5b]
stable/6.1: [0f1f2f9894893dc8a28af1b9e9dbc0abf453eb52]

CVE-2026-31698: crypto: ccp: Don't attempt to copy PDH cert to
userspace if PSP command failed

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [af67d35da744b6b678c7a0296d9c679658779829]
stable/5.15: [854d7846e1d29f32f1bbeb2e869e794df12067f6]
stable/6.1: [25d9b3446001185484209cf57951f3368462b631]

CVE-2026-31699: crypto: ccp: Don't attempt to copy CSR to userspace if
PSP command failed

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [502d10a1d9d477e6c7fc7021a2dac7018f4ab8b5]
stable/5.15: [0fb87e44b81385f940b482cba5b3f0bd18fb8185]
stable/6.1: [372116eece159adff631b1508344c8b85ebf9559]

CVE-2026-31701: ALSA: caiaq: take a reference on the USB device in create_card()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [493b3a682ededc804555755f5d2193201339612d]
stable/5.15: [dbcf7588e8dea017ddb3f18ec2766f7d2e5f2a0e]
stable/6.1: [ac7345f68cda6989016d85d63f7b244c064aa8f6]

CVE-2026-31702: f2fs: fix use-after-free of sbi in f2fs_compress_write_end_io()

stable/6.1 was fixed.

Fixed status
stable/6.1: [57bc678f36ac03281e877c6b84877b43f964143f]

CVE-2026-31704: ksmbd: use check_add_overflow() to prevent u16 DACL
size overflow

stable/6.1 was fixed.

Fixed status
stable/6.1: [41e53a773db6342ac9a689ee5ba635c31744c9f0]

CVE-2026-31705: ksmbd: fix out-of-bounds write in smb2_get_ea() EA alignment

stable/6.1 was fixed.

Fixed status
stable/6.1: [ddbbc8b2a09dd2cfed90871313e3691ae1db08a2]

CVE-2026-31708: smb: client: fix OOB read in smb2_ioctl_query_info
QUERY_INFO path

stable/6.1 was fixed.

Fixed status
stable/6.1: [1dd757379997b71a328a4b591ffaf481acd0ead1]

CVE-2026-31711: smb: server: fix active_num_conn leak on transport
allocation failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [60734c8bc3b4aa0672e251f08dda81977e4b5387]

CVE-2026-31716: fs/ntfs3: validate rec->used in journal-replay file record check

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [8e64d33198b5a0fb14a452708bad844f94f03b2c]
stable/6.1: [1393a467a9607e62123806de7d4c3a3e54e396a9]

CVE-2026-31717: ksmbd: validate owner of durable handle on reconnect

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [c7f0f0d01c88bdcb8b1694d7d321670013f7ed7d]
stable/6.6: [712cdf917e77a6444ce3836874829d770db20ee6]

CVE-2026-43052: wifi: mac80211: check tdls flag in ieee80211_tdls_oper

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [6813a8b1b240756dad4375f3e020ce10e4e3871b]
stable/6.1: [44839ea7e96b3659a1606f3d5267063135479b7c]
stable/6.6: [ba5b43db126a5e7378553869e3f7954d9187349f]

CVE-2026-43058: media: vidtv: fix pass-by-value structs causing MSAN warnings

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [a876d72ceba7fe5444005239f363c105767e0ecf]
stable/5.15: [a73f84a30975e6c4ae06efd500d31c82564dba10]
stable/6.1: [c034d8094fee474eb94142c17643eee2919079b7]

CVE-2026-43071: dcache: Limit the minimal number of bucket to two

stable/6.1 was fixed.

Fixed status
stable/6.1: [45b06bb5ea96f75ad81d7ef446f832ea6b0026fe]

CVE-2026-43072: drm/vc4: platform_get_irq_byname() returns an int

stable/6.1 was fixed.

Fixed status
stable/6.1: [59ece0d4d1db0cf483c4c51a58691f50ff81d3a2]

CVE-2026-43074: eventpoll: defer struct eventpoll free to RCU grace period

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [902120be4f44947df6311002addc7faf69bdbff1]
stable/6.1: [a6d57084372161f86660bc4607784420e00efe2c]

CVE-2026-43075: ocfs2: fix out-of-bounds write in ocfs2_write_end_inline

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [68f9cc3bbf2ae501770cea7dc0005fc9a85e48ea]
stable/5.15: [2e6a254f9cedf51b75cc20b8b92e2209bfa04c3e]
stable/6.1: [22df7d4de9c5cd42edf855a1de25f2106088c4c6]

CVE-2026-43076: ocfs2: validate inline data i_size during inode read

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [d012c782abcabe68b5b9e71be58a15e9f9d83dc1]
stable/5.15: [bcd46bc261b215b3b12c557a978299eafa02ecdd]
stable/6.1: [131c0b573e1b467b7d553e9ff38003f1acd8f5f2]

CVE-2026-43079: perf/x86/intel/uncore: Skip discovery table for offline dies

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [d18da11a5e21eac7651c8897e5e0908f6c2bc9de]
stable/6.1: [dfcba8c8674cead6c88a2f269b71aa4efd3d384a]

CVE-2026-43080: l2tp: Drop large packets with UDP encap

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [02d787fd0922c71c0264449fe82d35983613e4e5]
stable/5.15: [c2994fd24997ed63d713c03313f863645adb4d6c]
stable/6.1: [a42452db035577e150ffd9adf98c56fef9fb9408]

CVE-2026-43085: netfilter: nfnetlink_log: initialize nfgenmsg in
NLMSG_DONE terminator

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [296f18e1c3a87c915a92ed27832d5040a22d1072]
stable/5.15: [9e2182865de781c41ab16b7985e9d26dcefea867]
stable/6.1: [57cc509d82b46150a11dcecc8b25eaa177eda34d]

CVE-2026-43089: xfrm_user: fix info leak in build_mapping()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [521385cbd50ca9474396d88462fcdfa6489685d9]
stable/5.15: [c2779ae9a3e5a044e5ccd564681511bbbcc5fc0f]
stable/6.1: [72a8de41c3eb4dcf22bf3b674ea38fb2f75d6f32]

CVE-2026-43093: xsk: tighten UMEM headroom validation to account for
tailroom and min frame

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [5f123bc278bf4e3283d8606321bebbfd299f4384]
stable/5.15: [1a6051cd7e3e4c54ff3854a43b638b9292af5e67]
stable/6.1: [8769708add9eadeea8041a9761771bb715a87104]

CVE-2026-43094: ixgbevf: add missing negotiate_features op to Hyper-V ops table

stable/6.1 was fixed.

Fixed status
stable/6.1: [376d74ea03589914fbe2dedcbebf418396c04fd0]

CVE-2026-43098: nfc: s3fwrn5: allocate rx skb before consuming bytes

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [20a57de2e79b797ed75382659d52bf4c7d9cb446]
stable/6.1: [e4ab0fd1c91882f2a7846b1817781c8741f7f315]

CVE-2026-43099: ipv4: icmp: fix null-ptr-deref in icmp_build_probe()

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [0f21bc261e60f0c696c58841c4873ff77ed83673]
stable/6.1: [dc5db4db19766a61ad65d81d1f55b1c1e51ba78d]

CVE-2026-43103: net: lapbether: handle NETDEV_PRE_TYPE_CHANGE

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [698642a01d53107ce9b3fc08bd801284af478a2b]
stable/5.15: [ffc5ed59f6dc87c51e8775f002619310225742e8]
stable/6.1: [a10570973619cba9dfa6d723177251b846fae587]

CVE-2026-43104: drm/vc4: Fix a memory leak in hang state error path

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [c197def3834cbee3fd824ce4c57d08cb24e18955]
stable/5.15: [9487daa18e627ac6b5ed5911be79f23362554b70]
stable/6.1: [259e2bba3fd7005c62cbd42365a48b3221b244e3]

CVE-2026-43105: drm/vc4: Fix memory leak of BO array in hang state

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [7235fc096ece53211bd2c0e958c65f9b802aeb98]
stable/5.15: [686bb2fce082f043db50db02b5de5c64ca4dc4c4]
stable/6.1: [9c092941fc1d00933bcb46ecac1cb930db3abf5d]

CVE-2026-43110: wifi: brcmfmac: validate bsscfg indices in IF events

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [b329fbcf075949a038045d8e9b86ae3d5bbd8a54]
stable/5.15: [2ae3ccb78c0a9ef5ee3d80d02ab319ac1d5af734]
stable/6.1: [9c81bcc2c695e0082012a2a3d36a0eefaa51579c]

CVE-2026-43111: HID: roccat: fix use-after-free in roccat_report_event

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [20dca865460f7943cf70afca274b60dac371f546]
stable/5.15: [441689e3103694caa3e2d62b7d57c7bccefa5e37]
stable/6.1: [181ea51ab0f6370842c5b49cfb86824253a1189e]

CVE-2026-43112: fs/smb/client: fix out-of-bounds read in cifs_sanitize_prepath

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [a2ba20c17de8eb028f96b1d85f119d3d25655bd9]
stable/6.1: [fbced33599653471b4581dfe1abc7b467031f126]

CVE-2026-43113: wifi: wl1251: validate packet IDs before indexing tx_frames

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [6509dbece7339dbc8980c706b9d623119a6de105]
stable/5.15: [a8a11a876f0a97061ee5d9e61d0f5a0df7e241c7]
stable/6.1: [e0dc1ad870d6788b049bfe1511ac75b2333a7550]

CVE-2026-43114: netfilter: nft_set_pipapo_avx2: don't return
non-matching entry on expiry

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [f8c39983fc9c1a978c82e6f2df7bfba8a8561587]
stable/5.15: [c7babe2f28b507e17f28e9f753b7caec72d4857f]
stable/6.1: [1c43f0dd8691ddf8884793b481ddc7511cf593c3]

CVE-2026-43117: btrfs: tracepoints: get correct superblock from dentry
in event btrfs_sync_file()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [4a7bab35fad5251c8cb738161152578cd83b6b9c]
stable/5.15: [520e8b4bcf872a534a7bf61ccf880047642df296]
stable/6.1: [e252db8ca2a01f82d472091f35d549b313278636]

CVE-2026-43281: mailbox: Prevent out-of-bounds access in fw_mbox_index_xlate()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [2c7ff651ec6b660c7c96a36db9328b3232f555d8]
stable/5.15: [ec0874447895b994182a962d2fee9ef075de5efd]

CVE-2026-43319: spi: spidev: fix lock inversion between spi_lock and buf_lock

stable/6.6 was fixed.

Fixed status
stable/6.6: [fabfed1afe273717ea33b8aee46b767360edbb80]

CVE-2026-43328: cpufreq: governor: fix double free in
cpufreq_dbs_governor_init() error path

stable/5.15 was fixed.

Fixed status
stable/5.15: [4b9118e93d2499bb2808ef3742fa0ce06f4f8117]

CVE-2026-43350: smb: client: require a full NFS mode SID before
reading mode bits

stable/6.1 was fixed.

Fixed status
stable/6.1: [8bd4cad3f458d11650d51c2d24b03fb1770ae6cc]

CVE-2026-43493: crypto: pcrypt - Fix handling of MAY_BACKLOG requests

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [ae7e95638d956d556d74b9abb9e780d3bd3dcd9e]
stable/5.15: [1d7f07df450bac3301938fbc4251f2611be4084e]
stable/6.1: [76641449b28979ebd6c02e9598367e119e385236]

CVE-2026-43494: net/rds: reset op_nents when zerocopy page pin fails

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [c6e51512a784c4a7b86e1a044988696e3b3721fa]
stable/5.15: [03014551938a0887fa55f18ce49b70158a9c0113]
stable/6.1: [d84ce1786ce40fdd3dd98db47aec5527817e1ef6]

CVE-2026-43496: net/sched: sch_red: Replace direct dequeue call with
peek and qdisc_dequeue_peeked

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [03b0aaeba082ae981a0dfe96cdd03d02050537a1]
stable/5.15: [c7335f4dc0fa21f7015b910c6fc2f4d599732328]
stable/6.1: [45cd83c5c470ba49fe261489c8358ad7b9df7c45]

CVE-2026-43497: fbdev: udlfb: add vm_ops to dlfb_ops_mmap to prevent
use-after-free

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [60f711cfd580f86fea8284146ac133804e728f9a]
stable/5.15: [5931f5651ee32bd41b3323256b31fcc8e71336ed]
stable/6.1: [e3d9865dacd7435b8465848428210d0f0c673311]

CVE-2026-43499: rtmutex: Use waiter::task instead of current in remove_waiter()

stable/6.1 was fixed.

Fixed status
stable/6.1: [d8cce4773c2b23d819baf5abedc62f7b430e8745]

CVE-2026-43501: ipv6: rpl: reserve mac_len headroom when recompressed SRH grows

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [bde199c72d319a4e207f88daabc888317504e2fb]
stable/5.15: [be1fa0aa9b4fdd5a8b7a61ba520a690a68391e6e]
stable/6.1: [0a9e8053f1f8a8e1bfc1dd61ffe67be6c1180402]

CVE-2026-43502: net/rds: handle zerocopy send cleanup before the
message is queued

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [e9aefdc5c53fe9aed108c14e3d155710a1bb14c9]
stable/5.15: [46662f7dc59475995609bf3e9d27eb36f4acf26f]
stable/6.1: [1e262db7675e27f42c3f3f47d6011855f4454f24]

CVE-2026-45834: Bluetooth: L2CAP: Fix null-ptr-deref in
l2cap_sock_state_change_cb()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [1b1c0da227bf63479bac9982fc8d12df9aaea0fb]
stable/5.15: [85426e97dc72f2088ba6d27e74cd58c3fbd43e31]
stable/6.1: [0c17c8832562b2aac288e89cefd0f46074f54bcb]

CVE-2026-45835: Bluetooth: L2CAP: Fix null-ptr-deref in
l2cap_sock_new_connection_cb()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [140b63cb46f2855ac4ec8fba2f1e974a9c2974e8]
stable/5.15: [2422eaed0925973c0f318c94eb13e76f14c7381e]
stable/6.1: [684a1f9ee2325437ae18ac5371884e4c6a25ae73]

CVE-2026-45836: Bluetooth: L2CAP: Fix null-ptr-deref in
l2cap_sock_get_sndtimeo_cb()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [fd072f833147b0bc10c43a454624cb99d02f3fc7]
stable/5.15: [6e8d1a2a677a81caa60cf0aabd4217bd585fbba1]
stable/6.1: [e1863e7480feddb90125d0dd5a1b572972d75908]

CVE-2026-45838: bpf: fix end-of-list detection in cgroup_storage_get_next_key()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [0f3d9dd5e1fd52b39e25328307c6a694e994ffe3]
stable/5.15: [26d3339e465e54107bd85884341d1609c5300d6a]
stable/6.1: [2c88b2d96e1d4d0c7c4589a4593d4cdee6d332d6]

CVE-2026-45839: bpf: reject negative CO-RE accessor indices in
bpf_core_parse_spec()

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [a9e777f856cd2f1efc106afc7bf21aef868509d5]
stable/6.1: [669349b4612c26b3d7aacfa99d7174681bd19223]

CVE-2026-45840: openvswitch: cap upcall PID array size and pre-size
vport replies

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [8d59b80e69dddb665eb2de36e62859ab2073470e]
stable/5.15: [d9e47e29aacb9f8a9d59feb6ab5b128a9bbb40b0]
stable/6.1: [b39f763d720d623218bc1d95ace6855d7b474e81]

CVE-2026-45841: netfilter: nfnetlink_osf: fix divide-by-zero in OSF_WSS_MODULO

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [cb833bbc1b3c51e08652d3c86298307c07d3f2db]
stable/5.15: [26900306a5a2c3e4f75c643a064525526bb6e5f3]
stable/6.1: [0694618cf3e9b120666e31f5f383a6e466d95a0d]

CVE-2026-45842: slip: reject VJ receive packets on instances with no
rstate array

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [3d71c961febddd855d3ae9a519eeb96c8023f430]
stable/5.15: [72304fec672e8aac9ee7b9c475db96b37cca8d8d]
stable/6.1: [4aa9eca6fda2919027dfd7a7cc69334982d89586]

CVE-2026-45843: slip: bound decode() reads against the compressed packet length

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [6268f01ae989013671b526c883e92655342c6f6f]
stable/5.15: [9aafba2f49e1fcccc2018816f5836a609c925879]
stable/6.1: [335957df4ed60f02a2ec0432fbedbf0cc7241d8b]

CVE-2026-45844: netfilter: arp_tables: fix IEEE1394 ARP payload parsing

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [0f23a1457695f1a61f64367e39f0f9cfa29947d1]
stable/5.15: [1e285362ef7096eb12733370d59e033f4a1d294a]
stable/6.1: [84e8536c981338d0d8cc6e712cf71a936a93e13f]

CVE-2026-45846: bareudp: fix NULL pointer dereference in
bareudp_fill_metadata_dst()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [31e010a106ff6cd8ccac4bfee547fd3fa1015574]
stable/5.15: [55193df8d6d33318435f19572bf5ea47a22eee28]
stable/6.1: [51eef9c072aa3405a6823a96ae666d38a3b48750]

CVE-2026-45986: crypto: ccree - fix a memory leak in cc_mac_digest()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [7c21d58fcd6ad8e15a539347254093c93224a8b2]
stable/5.15: [f53458c7c756b3e0838d51cf1e9f41b25079801a]
stable/6.1: [7cd17993adb8a5d14a7e84d751316a5fdf0c251f]

CVE-2026-45987: KVM: nSVM: Sync interrupt shadow to cached vmcb12
after VMRUN of L2

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [0c1f74d8b74d8a31751fb6ea5417e48e02c93b58]
stable/5.15: [4b44aa1a134e499c4517597118378b308602a16c]
stable/6.1: [e39a77a9b1e17d2d831c304eafac4c41a784a0be]

CVE-2026-45992: ALSA: caiaq: Fix potentially leftover ep1_in_urb at error path

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [2d42c3386b7389d33caea7184cdb0188997fa6a9]
stable/5.15: [d50223ae98148fcc3bba18e718e4b0608df83bce]
stable/6.1: [089940d969e13e129b54f104a578cbafd99e308b]

CVE-2026-45994: ibmasm: fix OOB reads in command_file_write due to
missing size checks

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [44ee19422aa82a6847594866de7e5a31e4ef98b3]
stable/5.15: [7b8a574da5d7ea99b943f7a3458a17a1d95e8838]
stable/6.1: [d50e2019c9d7c433f56d9dff65703eb904aa1fb1]

CVE-2026-45997: scsi: sd: fix missing put_disk() when
device_add(&disk_dev) fails

stable/6.1 was fixed.

Fixed status
stable/6.1: [2c2c14b7dfccad8c5a28802849e40c21252e4c28]

CVE-2026-46002: ext2: reject inodes with zero i_nlink and valid mode
in ext2_iget()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [1b80cf48bcf0e1937af9cd6c7beb188762bbf7c5]
stable/5.15: [9e2d67fb2b73eeff8b601e26b332128eae8147bb]
stable/6.1: [a69a0c5156b6f0092b9fcf44517f5831a962de2d]

CVE-2026-46004: ALSA: caiaq: Handle probe errors properly

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [da938aa9fc7826901921dcea225948ab21a97e45]
stable/5.15: [09616e25f502080ba684fc7fcf959d1376ab756d]
stable/6.1: [b956e48371f2ff72b76be9a829800ecec963bd45]

CVE-2026-46006: drm/nouveau: fix u32 overflow in pushbuf reloc bounds check

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [573a1104bd36e49c067a9dc62e7c476d5ee7e92a]
stable/6.1: [45a45184b9c0b0b26ead06e370cda2073616a7cc]

CVE-2026-46009: PCI: endpoint: pci-epf-ntb: Remove duplicate resource teardown

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [c3029721b84f59e790285ad27544ed5d3cb0f2a6]
stable/6.1: [c72f6a7ea638f95c486a5cfd86e567b646027687]

CVE-2026-46015: tcp: call sk_data_ready() after listener migration

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [7aa7933a5607b1e5b56f322d17265c1d0ea02c51]
stable/6.1: [14e9bb6eba8f59dcc637702e4744ae5e30660d76]

CVE-2026-46018: ALSA: usb-audio: stop parsing UAC2 rates at MAX_NR_RATES

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [5436bc1b07d4656f99412dc72871d250d7d55205]
stable/5.15: [0da05fedf5e1966b7e7d389866cb86fcf09f4b32]
stable/6.1: [f14bd323eec4b4f0ef662520ec852e593ece1d4c]

CVE-2026-46019: crypto: atmel-aes - Fix 3-page memory leak in
atmel_aes_buff_cleanup

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [de6952e0af2acbada900d742437e848285c01d11]
stable/5.15: [5ad40cde96d603a88d68f8ed59f6d36407ab1f3c]
stable/6.1: [03e00aafa5f747d07811589e8d5fee638245431b]

CVE-2026-46022: misc: ibmasm: fix OOB MMIO read in
ibmasm_handle_mouse_interrupt()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [6f6ecc9153df176e956d0664b56f93080b0a45f0]
stable/5.15: [bac8643486f854dd53af9b23aea7dbbd9b7c1865]
stable/6.1: [f7e5b4eefd7be3e09f8bd5fee63ed478fd7446ab]

CVE-2026-46023: dm mirror: fix integer overflow in create_dirty_log()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [e5e0ae3237584ebef510366c4cb3d5cc7c22b610]
stable/5.15: [249c831183fb806c8e3b14c7c4c1d2fb68cf37fb]
stable/6.1: [ae59b3025609d5a0a39cf5b2b94e2467f6231573]

CVE-2026-46024: libceph: Prevent potential null-ptr-deref in
ceph_handle_auth_reply()

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [9ded62c302c0342efdb5eda3bf6e75720caad0df]
stable/6.1: [f101271fcf55d7eacfefd610b51ec65f46ba8118]

CVE-2026-46027: net/smc: avoid early lgr access in smc_clc_wait_msg

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [257cdf0c5ced9c0fba8aba501d94b0a5fcef2086]
stable/5.15: [22546729b96fc873b23065dc49e3d73c45cfb874]
stable/6.1: [5eedbfd82c2884e0010fdfb3c9446a6ebcadb691]

CVE-2026-46031: net: ks8851: Reinstate disabling of BHs around IRQ handler

stable/6.1 was fixed.

Fixed status
stable/6.1: [1962027a6d223f90df8b372929f9d1a8d321ad6a]

CVE-2026-46033: crypto: authencesn - reject short ahash digests during
instance creation

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [77f59fb2d3aa33e90ec6cbbf45dcfb20ab82b1a9]
stable/5.15: [2f31cd1e64a079c845bca31d2da7b3c90a311726]
stable/6.1: [d4c6a6d08e70bb1083c7c405fc7faacbf19aebc0]

CVE-2026-46037: ipv4: icmp: validate reply type before using icmp_pointers

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [b3a88fc5ae024d43c5ecf653f3bbe837e4a6dc99]
stable/6.1: [93df2af4f491de33827550b9d420f01808c0706b]

CVE-2026-46040: inotify: fix watch count leak when
fsnotify_add_inode_mark_locked() fails

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [3ab58cf42c46bf2366d2f55ae5c59299d5e178b7]
stable/5.15: [10edf7e0ffdc7faa18e2244b17722c1b882b8273]
stable/6.1: [3ad9ccea1b25435f6179b57aa891960beb7ce8f9]

CVE-2026-46043: RDMA/rxe: Validate pad and ICRC before payload_size() in rxe_rcv

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [c4376c672c3648d5bdc31dfffc329d07164f93c4]
stable/5.15: [5fedefec757192dcaad29a664ac332c7601be144]
stable/6.1: [2c0d71ef12f46c57d37bc571f3f2797db7eb50cc]

CVE-2026-46044: ipmi:ssif: Clean up kthread on errors

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [549607af66a0efdb41307ba6343eed31de8b133e]
stable/5.15: [f2d0a3ede5ebf404d4c334a1f04ef439e0086857]

CVE-2026-46046: ext4: fix missing brelse() in ext4_xattr_inode_dec_ref_all()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [dd98a5603a212ea9c96c6982ccdbcc748fdb9a56]
stable/5.15: [153ab2c52355fbebcae622db8e7b506492c73a29]
stable/6.1: [b706d00206a9e82362a9633efbd8b5775650169b]

CVE-2026-46047: net: qrtr: ns: Fix use-after-free in driver remove()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [65168712c216584ff482a7d1a67589f2079b2634]
stable/5.15: [dff081c3602f2fd810f69ef47945a226980dd05d]
stable/6.1: [4ae0bd51bf7079e9c2a06b5de0ae04ba70d10167]

CVE-2026-46048: ALSA: caiaq: fix usb_dev refcount leak on probe failure

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [c874db8a1d2f9f08161470d00cfe8db2f5cca2cc]
stable/5.15: [6fa8dff64fb6c401ced40a05797b327659317498]
stable/6.1: [a8d907acc3e5a078c2e5637ff60c30c6d2ddc23a]

CVE-2026-46049: ALSA: ctxfi: Add fallback to default RSR for S/PDIF

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [d0b53842211f73a10ea174100a213f7fa14b9f33]
stable/5.15: [615b7a5e5d8be68d52f262579906f7e015ba4606]
stable/6.1: [dfc00979ff00d9dfdfa1df32144a272ee2728102]

CVE-2026-46050: md/raid10: fix deadlock with check operation and nowait requests

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [2249983d971e6839b36284e6610390b2c217dfa1]
stable/6.1: [ae356d5eb1331d678985799f893e436314834a87]

CVE-2026-46051: md/raid5: fix soft lockup in retry_aligned_read()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [66df9f30673db66ac35145820a8e24906069ae57]
stable/5.15: [4166d5234fe8b6c3c7f796a6c198605356c5b355]
stable/6.1: [a9055300e07d9d6800264d3c2560e1d0144689ca]

CVE-2026-46053: net: rds: fix MR cleanup on copy error

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [91a44b406bc1f9e1c5da0cb7d0d5991b43b79147]
stable/5.15: [106dc689206610cfa2098f593fdd1e020c997835]
stable/6.1: [ec55a86f7fba7d9111df94b9c11a4755ed492995]

CVE-2026-46056: Bluetooth: hci_event: fix potential UAF in SSP passkey handlers

stable/6.1 was fixed.

Fixed status
stable/6.1: [b6ae482f88654db407c8c17619d4b62959b903ef]

CVE-2026-46058: media: amphion: Fix race between m2m job_abort and device_run

stable/6.1 was fixed.

Fixed status
stable/6.1: [516467052fdfc6a13eadc70d43420ae57436bf3c]

CVE-2026-46062: ntfs3: fix integer overflow in run_unpack() volume
boundary check

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [424858f9a048057bb8f834bfe03d18f5e477e747]
stable/6.1: [e73cd5aed6b15e55c1c47577bdb473b5e88d6a69]

CVE-2026-46064: ibmasm: fix heap over-read in ibmasm_send_i2o_message()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [ca1c857e2bb74a9fc0606128334f85316d57067b]
stable/5.15: [b870f652877bfbe321bd0f4096fc37a93296f7b6]
stable/6.1: [ce57fa439bd1b5d664f334a0c3e3f0e42abb0153]

CVE-2026-46070: md/raid5: validate payload size before accessing
journal metadata

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [c96c6f01d84b5c67db1bf1cc8591c0b7146826fc]
stable/5.15: [ef4851d8324fd978ca1ff9ec76a275438f887743]
stable/6.1: [28d3ff7109c66e99dc1b7cddacb5c760849620ef]

CVE-2026-46072: ntfs3: add buffer boundary checks to run_unpack()

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [bbad75336870b51b81979b97613746237fcb02fe]
stable/6.1: [425de2aba0d061b3e715d51a3b1992c112ed5b99]

CVE-2026-46075: crypto: atmel-sha204a - Fix potential UAF and memory
leak in remove path

stable/6.1 was fixed.

Fixed status
stable/6.1: [6dbeb0f788582e1ab5dfc3f41994eac0ec88c2b5]

CVE-2026-46077: crypto: atmel-tdes - fix DMA sync direction

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [ce3224678acb8c0b3473daa7d7dbffc998c6951a]
stable/5.15: [b9b28f3881dd514e74f98ae04e79a635022a4804]
stable/6.1: [c0f3002c02a3a83250e25582ffbe8df7eb78a8bd]

CVE-2026-46078: erofs: fix the out-of-bounds nameoff handling for
trailing dirents

stable/6.1 was fixed.

Fixed status
stable/6.1: [80a23c6d1aba35be8746d74ac14e6ba5ae46da21]

CVE-2026-46079: rbd: fix null-ptr-deref when device_add_disk() fails

stable/6.1 was fixed.

Fixed status
stable/6.1: [78bd0c143dea4b7a4c23c13356987ca0eafb442e]

CVE-2026-46080: ocfs2: split transactions in dio completion to avoid
credit exhaustion

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [97c03c0e9f73a5049794b3c69ee60fb5e8b0ebd8]
stable/5.15: [1e99bb19994246514d63e656492904176f9d5edd]
stable/6.1: [91e05ac2336d00d5b99fc774be4bd50039084796]

CVE-2026-46082: KVM: SVM: Inject #UD for INVLPGA if EFER.SVME=0

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [ebb63390142c6458fc37758e0892759989cc159f]
stable/6.1: [491139c17f8ad5773303068411f6ac5eed438b51]

CVE-2026-46088: ALSA: control: Validate buf_len before strnlen() in
snd_ctl_elem_init_enum_names()

stable/5.10, stable/5.15, stable/6.1 were fixed.


--
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

Fixed status
stable/5.10: [708f6ec9bcdf58bfd561409110baaf4fd3be4ea3]
stable/5.15: [bfcbb4994da9e979c4bcfcf24aaaac69e457e48e]
stable/6.1: [a470f7cabc4df72d9bd132f5719a8717292bb440]

CVE-2026-46092: wifi: rtw88: check for PCI upstream bridge existence

stable/6.1 was fixed.

Fixed status
stable/6.1: [3b89b4c095804c478d50376285e66700cf3c045f]

CVE-2026-46098: net: caif: clear client service pointer on teardown

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [cffca7a18b8f9de7c3d3013a1f5740c412b2a501]
stable/5.15: [7ef97d4675b05a103648bd9244d91dff7d8c08b0]
stable/6.1: [e16859f3f4426fa349bc5519d582a93d28f5a15d]

CVE-2026-46099: net: ipv6: fix NOREF dst use in seg6 and rpl lwtunnels

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [51fef5a7c4d160839199e941929456ba21ddf73c]
stable/6.1: [b258b849a580285a1692e782ebc902b44c884a71]

CVE-2026-46101: netfilter: reject zero shift in nft_bitwise

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [9baa08d6b6b096fad70049533f0d705d85fdc979]
stable/5.15: [4fccea585631621c975883911a08d15b6671f7dc]
stable/6.1: [9ad26c272405f53834871cc2e46b9b5393a666c3]

CVE-2026-46102: net: strparser: fix skb_head leak in strp_abort_strp()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [d6668ce0e78d23eabecef9a6bc4f0f739cb28ad3]
stable/5.15: [a470ed71c906cc8cbad0d74c9942216698911f8b]
stable/6.1: [c2e57695ec9ff9d42f23de70f3805199153d007b]

CVE-2026-46103: can: ucan: fix devres lifetime

stable/6.1 was fixed.

Fixed status
stable/6.1: [3df5b9110ac08f67ccfe382fc172bfee95688eec]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com


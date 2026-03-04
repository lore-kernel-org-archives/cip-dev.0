Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE54AEFCE4F
	for <webhook@archiver.kernel.org>; Wed,  4 Mar 2026 22:50:46 +0000 (UTC)
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31420.1772664637203173479
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Mar 2026 14:50:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=QvkwV1O5;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.50, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64c9a6d7f81so6755064d50.3
        for <cip-dev@lists.cip-project.org>; Wed, 04 Mar 2026 14:50:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772664636; cv=none;
        d=google.com; s=arc-20240605;
        b=ZQI4UOa3T8Bsj6SgRhAYu2CxZlE0khKbfkTn+ubXdVRL4Lxpj3UlTXNUKpCWritEcY
         NWz+rjpqpAUDo9Vz0kGv6kInfmS1pSDbW8chG08ifA6Ckrdx5TBXPRitgIhst0OZ28r4
         fpjDW4QxPfN6Ix6+Y1ZmqnQnF9zzX+d96Ht6JHf0Q3uYht7HBVI6futAOOI5ASsG0OI8
         n/pAvl1ZCvraO2/887ehoaTl+3BXtyB4lwSalbeRVhgOEX9GtYAszHRLb5TPnmUaeSDf
         AZM3zvTM5uicQq7//EVB2PSZUwl7zbsYkhXzONOX80Pv3mEdLWZsZEHPU/KwFapNBqIF
         N8NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=yhrNlotLuUuKQtL9sEvqVu/G7gAMpOTFXiyKDRPQPb8=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=KutLFU7/XpZGuQhDaLYRN4AYEh2IMJzAb4BMcA3PD2+Bv4JOLUkFmSCtrPkhIO43Q9
         KlP6+7bLG1PMv8SSDtDyHK93K3dLmlga2FRDEVee7ZD0wNFwLedf+aysiIWuq519SewH
         MSNbTDI1/vtip+TTar/C214Mlh1+pYGXzI0NZPwy4x8EiuIEP1W9DuIQc67ezQrTnE3+
         nU3TqHC22YVvLvsYZwGAtq+hhFEem75deZEHjlkBvRK6rNMAXyW427DUyF6dewIYpo9B
         47MK5spZppZYz8BUkz+S8ZzPS3d1ldZlNyOgN+rOPKpvvHOXqmrP9yGJPby5TIcwUZpO
         D1BA==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1772664636; x=1773269436; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yhrNlotLuUuKQtL9sEvqVu/G7gAMpOTFXiyKDRPQPb8=;
        b=QvkwV1O55NOx2LCX/v3+hiRpPDw4JfzG1mfLbpYeyZXBoYHJf1AZpyPW0+6bdjnaak
         +qIbmidKR4Kkqhv60m4BNFpQyZv5lkj0LAridx7EI5UBnF7/7iXFlbzMCPp7NrS2+RBq
         8gAKCqRnHvay2Zwwzy+JxMO7HsT9d4iXHG7lXDOO3c4d8OZWM1qYZxza9Wi8kaKpcnfO
         /bUwWDt8DQ5gmbY9xfymGZZnXYzQRlNhVvfxK4sss1rA3K/3b/lup+2xeGGOrOfj7z3V
         d2mnWACc3XcyDizp4OCKjHgIf+pN1x1o9DFLbcYFJUl06aTtgtk5LePyvexQurB22nwj
         RLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772664636; x=1773269436;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yhrNlotLuUuKQtL9sEvqVu/G7gAMpOTFXiyKDRPQPb8=;
        b=IP2go3+IT3FtQHA7idYq+rzGqgcIOtHxW/jjqBMua7FjdfwsGDmvrzNKXr8UcyKuSB
         x2kvkIopu0H37rW8LBjImF+g1L50/xsKNm4nlHYP8GBN98mo0yVFKV60Ot/+GrDCZ3KV
         GEM3zowqZjrMspLVswaw7dODbM0B9mGebaCRs8nLb8RoHwlH/h2WURJkqhh66dJpjWl9
         1xeiQYxCJQ3MYJ69s8NNDJsZGKvDVhrWMteCJUVkHoK6U25Esh1dI0ZzhbIBGAFYHA+y
         Aykkybk/3Syi90dGx1EGSiDfPbt7Qp/Lye3l1DekynGaG2Btd5LS4s0tofKoLbBV9oHN
         o4YA==
X-Gm-Message-State: AOJu0YxtZSz5Igv6jXV59vVsyW7i+s1YnVHFRz9VlEtDp9Zg3deskFmI
	ajNYnGSyS5ECJ8uiS5FOL1EpJi0ZkncneaOT9M54CmZVGKA5MAfhDxTIOLRjmrRg5fWpc43rOIm
	4bTWhu6M4UPANiLo9+Z3kP4GaWCHV5zGzkkcPzBaKp1UAJ0nYBdWpQyM=
X-Gm-Gg: ATEYQzw8QCHQFSN2aIOeOdVUUwuaiwgYfw6NxWm5K4jgbgNbLN+04klHVS6kMgl87DW
	jNqJIOcVpd5/65y/Ng4HMvIoMzi2SXcNOdQwFk2F5diuyuSmu6dVcE4rjJKoA0LXaU+o6F+xjrC
	xj1BNEQhevB5wVZBFb4ufDOxK7bHtg4/z8pIL2yit+Pg71xGQGtIPwHnD23m1QYEiJ6tiRNLCLx
	Qnp6ZfCNQq4ZzsoaMruk+ZbOnwpsujhzyBTbeBbxu0SkUeqOySSiDfxlGSgV3IajiFXJDwY0gwi
	v6AuEX/M
X-Received: by 2002:a05:690e:12ce:b0:644:2e1b:c8bb with SMTP id
 956f58d0204a3-64cf9bba49bmr3186722d50.59.1772664635998; Wed, 04 Mar 2026
 14:50:35 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 5 Mar 2026 07:49:59 +0900
X-Gm-Features: AaiRm53oliwdBBIwldz1EQxc9YE03LK1PhzDozTYhVsFXPiG-3WPwkiQZuJ3h2E
Message-ID: <CAODzB9pqj=tEhZW=uGFn4=eOFYXEvyzc-UegZM=syyH9D1op5g@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Mar 2026 22:50:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22072

Hi!

It's this week's CVE report.

This week reported 9 new CVEs and 1 updated CVEs.

* New CVEs
CVE-2025-71238: scsi: qla2xxx: Fix bsg_done() causing double free

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71238

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [c2c68225b1456f4d0d393b5a8778d51bb0d5b1d0]
stable/5.10: [057a5bdc481e58ab853117254867ffb22caf9f6e]
stable/5.15: [f2bbb4db0e4a4fbd5e649c0b5d8733f61da24720]
stable/6.1: [27ac9679c43a09e54e2d9aae9980ada045b428e0]
stable/6.12: [871f6236da96c4a9712b8a29d7f555f767a47e95]
stable/6.18: [31f33b856d2324d86bcaef295f4d210477a1c018]
stable/6.19: [708003e1bc857dd014d4c44278d7d77c26f91b1c]
stable/6.6: [74e7458537cd9349cf019862e51491f670871707]

CVE-2026-23231: netfilter: nf_tables: fix use-after-free in nf_tables_addchain()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23231

Introduced by commit 91c7b38 ("netfilter: nf_tables: use new
transaction infrastructure to handle chain") in v3.16-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [71e99ee20fc3f662555118cf1159443250647533]
stable/6.1: [2a6586ecfa4ce1413daaafee250d2590e05f1a33]
stable/6.12: [f3fe58ce37926a10115ede527d59b91bcc05400a]
stable/6.18: [dbd0af8083dd201f07c49110b2ee93710abdff28]
stable/6.19: [2f9a4ffeb763aec822f8ff3d1e82202d27d46d4b]
stable/6.6: [7017745068a9068904e1e7a1b170a5785647cc81]

CVE-2026-23232: Revert "f2fs: block cache/dio write during
f2fs_enable_checkpoint()"

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23232

Introduced by commit 196c81f ("f2fs: block cache/dio write during
f2fs_enable_checkpoint()") in v6.19-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3996b70209f145bfcf2afc7d05dd92c27b233b48]
stable/6.19: [b6382273801bc7c778545dd8004c9a9d750b4f62]

CVE-2026-23233: f2fs: fix to avoid mapping wrong physical block for swapfile

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23233

Introduced by commit 9703d69 ("f2fs: support file pinning for zoned
devices") in v6.9-rc1.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [5c145c03188bc9ba1c29e0bc4d527a5978fc47f9]
stable/6.12: [1ff415eef513bf12deb058fc50d57788c46c48e6]
stable/6.18: [fee27b69dde1a05908b350eea42937af2387c4fe]
stable/6.19: [607cb9d83838d2cd9f0406c2403ed61aadf0edff]
stable/6.6: [d4534a7f6c92baaf7e12a45fc6e37332cafafc33]

CVE-2026-23234: f2fs: fix to avoid UAF in f2fs_write_end_io()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23234

Introduced by commit e234088 ("f2fs: avoid wait if IO end up when
do_checkpoint for better performance") in v3.13-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce2739e482bce8d2c014d76c4531c877f382aa54]
stable/5.10: [0fb58aff0dafd6837cc91f4154f3ed6e020358fa]
stable/5.15: [2f67ff1e15a8a4d0e4ffc6564ab20d03d7398fe9]
stable/6.1: [505e1c0530db6152cab3feef8e3e4da3d3e358c9]
stable/6.12: [cf4a9e1bc8129eb63fda5f8bdcd8d87f0bd76f42]
stable/6.18: [995030be4ce6338c6ff814583c14166446a64008]
stable/6.19: [a42f99be8a16b32a0bb91bb6dda212a6ad61be5d]
stable/6.6: [acc2c97fc0005846e5cf11b5ba3189fef130c9b3]

CVE-2026-23235: f2fs: fix out-of-bounds access in sysfs attribute read/write

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23235

Introduced by commit b59d0ba ("f2fs: add sysfs support for controlling
the gc_thread") in v3.12-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98ea0039dbfdd00e5cc1b9a8afa40434476c0955]
stable/5.10: [e85a99db9ab85dfc30d93b0ca0e9156f3127f55a]
stable/5.15: [438a405fbad6882df0e34b3e1a16839a71f04240]
stable/6.1: [6a6c07a9b49e43f0df42d7118fc76aa555c73d98]
stable/6.12: [4ef30b9f1641c9e877792df6b049f1cf507d002d]
stable/6.18: [d4a594dd952df123cbdcdee9b9640d9d55e4a954]
stable/6.19: [3a905e183c047577b154f08a78ac3039e9454703]
stable/6.6: [eebd72cff518ac87e660aefb8a41224bd88c32ce]

CVE-2026-23236: fbdev: smscufx: properly copy ioctl memory to kernelspace

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23236

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [120adae7b42faa641179270c067864544a50ab69]
stable/5.10: [061cfeb560aa3ddc174153dbe5be9d0b55eb7248]
stable/5.15: [6167af934f956d3ae1e06d61f45cd0d1004bbe1a]
stable/6.1: [a0321e6e58facb39fe191caa0e52ed9aab6a48fe]
stable/6.12: [52917e265aa5f848212f60fc50fc504d8ef12866]
stable/6.18: [1c008ad0f0d1c1523902b9cdb08e404129677bfc]
stable/6.19: [f1e91bd4efeae48b0f42caed7e8ce2e3a0d05b02]
stable/6.6: [0634e8d650993602fc5b389ff7ac525f6542e141]

CVE-2026-23237: platform/x86: classmate-laptop: Add missing NULL pointer checks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23237

Introduced commit is not determined.Fixed in v6.19.


Fixed status
mainline: [fe747d7112283f47169e9c16e751179a9b38611e]
stable/5.10: [993708fc18d0d0919db438361b4e8c1f980a8d1b]
stable/5.15: [af673209d43b46257540997aba042b90ef3258c0]
stable/6.1: [eb214804f03c829decf10998e9b7dd26f4c8ab9e]
stable/6.12: [da6e06a5fdbabea3870d18c227734b5dea5b3be6]
stable/6.18: [97528b1622b8f129574d29a571c32a3c85eafa3c]
stable/6.6: [9cf4b9b8ad09d6e05307abc4e951cabdff4be652]

CVE-2026-23238: romfs: check sb_set_blocksize() return value

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23238

Introduced commit is not determined.Fixed in v6.19-rc8.


Fixed status
mainline: [ab7ad7abb3660c58ffffdf07ff3bb976e7e0afa0]
stable/5.10: [a381f0f61b35c8894b0bd0d6acef2d8f9b08b244]
stable/5.15: [f2521ab1f63a8c244f06a080319e5ff9a2e1bd95]
stable/6.1: [2c5829cd8fbbc91568c520b666898f57cdcb8cf6]
stable/6.12: [9b203b8ddd7359270e8a694d0584743555128e2c]
stable/6.18: [4b71ad7676564a94ec5f7d18298f51e8ae53db73]
stable/6.6: [cbd9931e6456822067725354d83446c5bb813030]


* Updated CVEs

CVE-2025-39889: Bluetooth: l2cap: Check encryption key size on
incoming connection

stable/5.10 was fixed.

Fixed status
stable/5.10: [ed503d340a501e414114ddc614a3aae4f6e9eae2]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com


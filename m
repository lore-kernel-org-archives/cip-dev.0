Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00C9CD4934
	for <webhook@archiver.kernel.org>; Wed, 20 Sep 2023 22:51:54 +0000 (UTC)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
 by mx.groups.io with SMTP id smtpd.web10.3661.1695250306417166371
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Sep 2023 15:51:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=W0wK8Bm8;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.53, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1d66baacc8cso163973fac.1
        for <cip-dev@lists.cip-project.org>; Wed, 20 Sep 2023 15:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1695250305; x=1695855105; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z7/QzCTKFteObIZ2zEraZtSZ5rjCIFZ1tG4gpph3NU4=;
        b=W0wK8Bm8yoBN7xDGLyONbY/yTd5hudukEmDex1/Iz9Q7pcjRgBy6RUxA0yTHOwSA+4
         7B8Itvcfd5Rsq6yUZOYHaIT42rIxpA+nJqa2s0giMclyAVyIXECZSxBJRZhdJ1vIAhq4
         QmGQbSTpwjoHJyuk5kDRScfq09LF3zSTRFvTML3vUQzWHXWNJdmdVNsdTFHb8ah2FZDi
         TI5sGtaJoVZ+PkKCfco26uEGQk5n+0abRygSf/CZYZEdi5Kx3b/zO1Xm6HALEV0NkdAP
         PzxuzHzYNygPFZWrj2UFltQhc+BPjAnSZW4918k2zGiql3rp3+nIfuwLz34d7+aLBeym
         9HMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695250305; x=1695855105;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z7/QzCTKFteObIZ2zEraZtSZ5rjCIFZ1tG4gpph3NU4=;
        b=awYqqNX17XopvznpDJc1v3psM3fL9cD3wSnPkSbwaSuClraRejYG7ZDaLummlopIZW
         DorEgCwJOBXHNo4r1FrdazGVXlVlI9Ykzd2N+T8xZy5gUbBNX6OWCovTIcBLTheQfI+b
         zKl2CtVvL+wA4vprnOD6KPg/GilpFdD2aYRrT1BTAjoGYdGRS/E/GbdqXhCw0XsaVqdq
         8zPu8zw8PN8vvSs/aVTv/NJ9/Kh/rp1k7kqlXaZ6bj41yBL4gqJbNEeQglP6eVtuJ+4A
         g9Qf/3LQiUvAIm7QvPhWD4AMYQiu7KKG6Qw0MgNUqWKx4e1D4Fvx9tALIJwTJP2xKWJX
         8ncQ==
X-Gm-Message-State: AOJu0YwimSqHGWxYj0/WLcFELEMuzo3XrDdL3o20ze1yTTRLVTgoSLFB
	T7prBljErlklAhzfGfgsCBfsBQ8GhpCyXUU6ImXCRvUwdgKC5mqw2Tw=
X-Google-Smtp-Source: AGHT+IHGjXkinhWkQhjnmbjI9it2nRjvvHG7ukINQQi0w0kkHWtQ0xnzxgRDI4oR5C02NJIvp7zOuZjY25+MMCBdtgc=
X-Received: by 2002:a05:6871:60b:b0:1d6:5664:8365 with SMTP id
 w11-20020a056871060b00b001d656648365mr2631591oan.6.1695250305277; Wed, 20 Sep
 2023 15:51:45 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 21 Sep 2023 07:51:09 +0900
Message-ID: <CAODzB9qZ83ftx6hw5M+fynH5oah+BB5X-iUa1wiObqz4mkJ_wg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Sep 2023 22:51:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13182

Hi !

It's this week's CVE report.

This week reported 1 new CVEs and 6 updated CVEs.

* New CVEs

CVE-2023-42752: integer overflows in kmalloc_reserve()

CVSS v3 score is not provided .

An integer overflow bug was found in kmalloc_reserve() in
net/core/skbuff.c when calculating  memory size to allocate.
If a user passes a huge value to the size parameter, it leads to an
integer overflow bug.

This bug was introduced by commit 12d6c1d ("skbuff: Proactively round
up to kmalloc bucket size") in 6.2-rc1.
It was backported to 6.1. However, Linux 4.4, 4.14, 4.19, 5.4, 5.10
and 5.15 are not affected by this vulnerability.

Fixed status
mainline: [915d975b2ffa58a14bfcf16fafe00c41315949ff,
c3b704d4a4a265660e665df51b129e8425216ed1]
stable/6.1: [6678912b4df1bfac6f7c80642d56dc22e23419e4,
31cf7853a940181593e4472fc56f46574123f9f6]
stable/6.5: [bf7da02d2b8faf324206e1cbe64a4813ff903cc1,
3138192865c2a1f089dd27a7d80a7271ecd468e7]

* Updated CVEs

CVE-2023-4244: A use-after-free vulnerability in the Linux kernel's netfilter

Added following commits.
- 2413893 ("netfilter: nf_tables: don't skip expired elements during walk")
- 6a33d8b ("netfilter: nf_tables: fix GC transaction races with netns
and netlink event exit path")
- 02c6c24 ("netfilter: nf_tables: GC transaction race with netns dismantle")
- 23185c6 ("netfilter: nft_dynset: disallow object maps")

Fixed status
mainline: [5f68718b34a531a556f2f50300ead2862278da26,
f6c383b8c31a93752a52697f8430a71dcbc46adf,
  c92db3030492b8ad1d0faace7a93bbcf53850d0c,
a2dd0233cbc4d8a0abb5f64487487ffc9265beb5,
  24138933b97b055d486e8064b4a1721702442a9b,
6a33d8b73dfac0a41f3877894b38082bd0c9a5bc,
  02c6c24402bf1c1e986899c14ba22a10b510916b,
23185c6aed1ffb8fc44087880ba2767aba493779]

CVE-2023-1989: Bluetooth: btsdio: fix use after free bug in
btsdio_remove due to unfinished work

Added commit 746b363 ("Bluetooth: btsdio: fix use after free bug in
btsdio_remove due to race condition") to 5.10.

Fixed status
mainline: [1e9ac114c4428fdb7ff4635b45d4f46017e8916f,
73f7b171b7c09139eb3c6a5677c200dc1be5f318]
stable/4.14: [95eacef5692545f199fae4e52abfbfa273acb351]
stable/4.19: [af4d48754d5517d33bac5e504ff1f1de0808e29e]
stable/5.10: [da3d3fdfb4d523c5da30e35a8dd90e04f0fd8962,
746b363bef41cc159c051c47f9e30800bc6b520d]
stable/5.15: [8efae2112d910d8e5166dd0a836791b08721eef1]
stable/5.4: [a18fb433ceb56e0787546a9d77056dd0f215e762]
stable/6.1: [cbf8deacb7053ce3e3fed64b277c6c6989e65bba,
179c65828593aff1f444e15debd40a477cb23cf4]
stable/6.2: [c59c65a14e8f7d738429648833f3bb3f9df0513f]

CVE-2023-37453: i out-of-bounds in read_descriptors in drivers/usb/core/sysfs

Stable 5.10 and 5.15 were fixed.

Fixed status
mainline: [ff33299ec8bb80cdcc073ad9c506bd79bb2ed20b]
stable/5.10: [9d241c5d9a9b7ad95c90c6520272fe404d5ac88f]
stable/5.15: [7fe9d87996062f5eb0ca476ad0257f79bf43aaf5]
stable/6.1: [8186596a663506b1124bede9fde6f243ef9f37ee]
stable/6.4: [b4a074b1fb222164ed7d5c0b8c922dc4a0840848]
stable/6.5: [b9fbfb349eacc0820f91c797d7f0a3ac7a4935b5]

CVE-2023-4623: net/sched: sch_hfsc: Ensure inner classes have fsc curve

Stable 5.10 and 5.15 were fixed.

Fixed status
mainline: [b3d26c5702c7d6c45456326e56d2ccf3f103e60f]
stable/5.10: [b08cc6c0396fd5cfaac4ca044f2282367347c062]
stable/5.15: [4cf994d3f4ff42d604fae2b461bdd5195a7dfabd]
stable/6.1: [a1e820fc7808e42b990d224f40e9b4895503ac40]
stable/6.4: [5293f466d41d6c2eaad8b833576ea3dbee630dc2]
stable/6.5: [eb07894c51c7d6bb8d00948a3e6e7b52c791e93e]

CVE-2023-4881: netfilter: nftables: exthdr: fix 4-byte stack OOB write

Stable 5.15, 6.1, and 6.5 were fixed.

Fixed status
mainline: [fd94d9dadee58e09b49075240fe83423eb1dcd36]
stable/5.15: [1ad7b189cc1411048434e8595ffcbe7873b71082]
stable/6.1: [d9ebfc0f21377690837ebbd119e679243e0099cc]
stable/6.5: [c8f292322ff16b9a2272a67de396c09a50e09dce]

CVE-2023-4921: net: sched: sch_qfq: Fix UAF in qfq_dequeue()

Stable 5.10, 5.15, 6.1, and 6.5 were fixed.

Fixed status
mainline: [8fc134fee27f2263988ae38920bc03da416b03d8]
stable/5.10: [746a8df5e4d235059b1adf02e8456e7ec132d2d8]
stable/5.15: [6ea277b2c6263931798234e2eed892ecfbb85596]
stable/6.1: [a18349dc8d916a64d7c93f05da98953e3386d8e9]
stable/6.5: [e5471b82c36396e809817cb988dfc4bce0a688cb]

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


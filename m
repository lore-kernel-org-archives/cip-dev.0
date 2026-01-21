Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B8FC44508
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 22:14:14 +0000 (UTC)
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24178.1769033651853701131
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Jan 2026 14:14:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=YXxlOMFb;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.47, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64942ebf1a3so424023d50.3
        for <cip-dev@lists.cip-project.org>; Wed, 21 Jan 2026 14:14:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769033651; cv=none;
        d=google.com; s=arc-20240605;
        b=BNrIg6uQrJATy0yHv95MW599eLX1pkj0wG1KuPXXPrc35Z8zSJHj89KeEFy0pc5ncB
         NMlY1DwMdF0PTCNszp0oQ0ys4DxWBT7GuQYk47hSKmdHqeXJlATIL5N0LhAPKn2rkKvU
         aGsVROtoL2st36GpZV9NBIsblGgSsTyXLHnsdlIhRC4Ak6XHGJ0pkYlm7oJwdSvug1gU
         1YUniIMq1yNvV1LxhgEC14H5R0cpiOJvWZxEXfuvIGmnzPsY6CyaNgWJ/k/KJ6BSrjrd
         +XKrSCUxg8Y0vVEAMVk36Xknp+zW4gkx+hNdJkregPZazlF8PS4KcNiHwmD2Ji5FoaL8
         +yhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=DL1zRbO8yrJNATflunV7bj2ncUTPDCrHkP1xHgzOq0k=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=MrIBHNDoLRKxB7vB/M7Ey7RuNDeiNSS+asJ2uZFpVq5gkNOHFopCTDCEjFjASNJyNt
         t6wpE9mW7bh6hLEiQCoFr9GOrZjUewXstcaNJyNg4POeFEWqlLPID1KCgbJVA0BJB4Qz
         MnXssisGNxYjy5GZh8kV2irIzneRebtbc29AinTs5QN0fpUnOOt9MY5wwNFqW8pyQXpg
         nzB7IkL9fX7ZYtwPkN1tLUVws3Cs9FbQM5dzt5fe4w0txEHa0PNPylfih+F/ls+fP4xj
         qwxZufcXtUePclHLMBJ1PEoxMCFJfrYkHa7ZHm0Cx9Iv2lACs1oajcVPO6vJY4nBc6+l
         qycg==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1769033651; x=1769638451; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DL1zRbO8yrJNATflunV7bj2ncUTPDCrHkP1xHgzOq0k=;
        b=YXxlOMFbX/J6RrXOjKzYySYn9dIMaorr4YbNc69uLldvs+IMa3XZKJNuoZ5MeTaok+
         gfApyASFDtlm1efez5/wpcXfsiFJbGyLVfHmeBWmFwFDQwhKRKPMBdvnSjFR9Jo7Xigj
         J0K3x9xHEPek3eCroy0OOnsteOtkxyxFCmBymo6nRUJTiQBEbB3BhcUgdZDb315Z2bw5
         QtjbdJwurcAtD3rMLZ6IMUrUXZz90VpLoHNo6dU6eY1wYt9GMW5KU8CreEpzGFfhdtxh
         jqA5vIvCYQtOUbygpqJV1i0WMdrFiYTtAJb2r7Gn2RzjTlJSwdlmUIugvQx/OpYFxr93
         drjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769033651; x=1769638451;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DL1zRbO8yrJNATflunV7bj2ncUTPDCrHkP1xHgzOq0k=;
        b=kuX7l43pWKrkNTzTYZvivfmygL7zio8xNeB24dsI57lkTyWM3yycEWgztHx1ZDWQ6b
         2MOs/1BmOJcJUcDqKugRS5Z9ioiXxsW3oBL7L4Ctsgb8/+tuBnHENOJVNcQHPsNp8qPC
         prXrbbAOlL+PtyylYDyTBqtKf4Hz7PmuQq6D5BtjGPmNLrtGpUQtN7T68bBaI7L85wbT
         UjqkQbr301SMmCtOrC/eDZf6fc0YfsDKnJXB5kdvFDmuOM2YF3xNWpfzZGOZU9sX8FNd
         PhoB5nM1nMeJdhJkI72ZKJ8fRpZk14D1aajO+6BqmkfRWszlA0wBfTKgqi6ZXSdxuwaW
         +4Jg==
X-Gm-Message-State: AOJu0YxoCsqWS50278cPg2icooM7dXWb1fdeScBxwGNwR1Ev7QYArpiP
	9yxTfLPfy2/2hCOZQLfA42h+fEgrFC6EU0QBj/FKRa+rlyWJy/WIVCRlYVzOZIl++JvQWvQhaYL
	21wYXCbIOrquTazpmMZJWRRB8idOJrEkygsaLuKPmt6eTvIZ0LZyrRBk=
X-Gm-Gg: AZuq6aKBUJHfemPNMlZ9sxiUzxZnDb2wWkcr1NtZneUJfAfJCLwiZ7i/SOXiALAuH6e
	hM4PzV+6G+ia0yHTKL0qQeQZkLO8DZmyCasHtP7lwqm3xJgV59QE20Y1axcgtLnG0dQ/E7wp+45
	pcczq+BTjWYgsz6xGI3xw94fTOVeflVhkzUQzLHiHlmU9ofZwHEQ/EUe72KAVGGJzcqdHgaIko/
	Z6GNE7sp5WEOPe2y1vm0nc5Lw+V21r1rHhwlTvKst2TW98iNLhUQO2WcHm+Nc//obBk/m0i
X-Received: by 2002:a05:690e:1245:b0:649:3a50:d016 with SMTP id
 956f58d0204a3-6493c809db9mr4828589d50.41.1769033650660; Wed, 21 Jan 2026
 14:14:10 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 22 Jan 2026 07:13:34 +0900
X-Gm-Features: AZwV_Qjpsa_fnxEIRziWh1JX3xbkD5LNv9ZomjPWJx0X2QCcZt2L8jdMmgx5-9A
Message-ID: <CAODzB9pOpe0LuFYmxjaE+Vb0-rcZBym_wA77f4Vjs1U3UP_3Hw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Jan 2026 22:14:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21693

Hi!

It's this week's CVE report.

This week reported 2 new CVEs and 6 updated CVEs.

* New CVEs
CVE-2026-22976: net/sched: sch_qfq: Fix NULL deref when deactivating
inactive aggregate in qfq_reset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-22976

Introduced by commit 0545a30 ("pkt_sched: QFQ - quick fair queue
scheduler") in v3.0-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c1d73b1480235731e35c81df70b08f4714a7d095]
stable/5.10: [6116a83ec167d3ab1390cded854d237481f41b63]
stable/5.15: [0809c4bc06c9c961222df29f2eccfd449304056f]
stable/6.1: [cdb24200b043438a144df501f1ebbd926bb1a2c7]
stable/6.12: [43497313d0da3e12b5cfcd97aa17bf48ee663f95]
stable/6.6: [11bf9134613f6c71fc0ff36c5d8d33856f6ae3bb]

CVE-2026-22977: net: sock: fix hardened usercopy panic in sock_recv_errqueue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-22977

Introduced by commit 6d07d1c ("usercopy: Restrict non-usercopy caches
to size 0") in v4.16-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2a71a1a8d0ed718b1c7a9ac61f07e5755c47ae20]
stable/5.10: [88dd6be7ebb3153b662c2cebcb06e032a92857f5]
stable/5.15: [c655d2167bf014d4c61b4faeca59b60ff9b9f6b1]
stable/6.1: [8c6901aa29626e35045130bac09b75f791acca85]
stable/6.12: [005671c60fcf1dbdb8bddf12a62568fd5e4ec391]
stable/6.6: [582a5e922a9652fcbb7d0165c95d5b20aa37575d]


Fixed status

* Updated CVEs

CVE-2025-22121: ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()

stable/6.1 was fixed.

Fixed status
stable/6.1: [c000a8a9b5343a5ef867df173c6349672dacbd0f]

CVE-2025-37822: riscv: uprobes: Add missing fence.i after building the
XOL buffer

stable/6.6 was fixed.

Fixed status
stable/6.6: [77c956152a3a7c7a18b68f3654f70565b2181d03]

CVE-2025-40149: tls: Use __sk_dst_get() and dst_dev_rcu() in
get_netdev_for_sock().

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [e37ca0092ddace60833790b4ad7a390408fb1be9]
stable/6.12: [f09cd209359a23f88d4f3fa3d2379d057027e53c]
stable/6.6: [13159c7125636371543a82cb7bbae00ab36730cc]

CVE-2025-68211: ksm: use range-walk function to jump over holes in
scan_get_next_rmap_item

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [67137b715b7db28d82e4ed07a7092c2fa6ba7adb]
stable/6.6: [9c2f8a9b68024e5ebb4813665845ec0a95f2eac3]

CVE-2025-68792: tpm2-sessions: Fix out of range indexing in name_size

stable/6.12 was fixed.

Fixed status
stable/6.12: [47e676ce4d68f461dfcab906f6aeb254f7276deb]

CVE-2025-68803: NFSD: NFSv4 file creation neglects setting ACL

stable/6.6 was fixed.

Fixed status
stable/6.6: [381261f24f4e4b41521c0e5ef5cc0b9a786a9862]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com


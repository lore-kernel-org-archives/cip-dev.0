Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FF6C77B73
	for <webhook@archiver.kernel.org>; Wed, 24 May 2023 22:50:48 +0000 (UTC)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
 by mx.groups.io with SMTP id smtpd.web11.96.1684968644233741845
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 May 2023 15:50:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=R1qp8hVE;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.43, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-199dd37f0e4so693671fac.2
        for <cip-dev@lists.cip-project.org>; Wed, 24 May 2023 15:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1684968643; x=1687560643;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ty6/s5RuKHEvXeAN+/GxJYUjZzxOnu0bScAU8fdlguw=;
        b=R1qp8hVEqiNHz/2cwEOraUvuuCzzzNz8AYoS1wiGjpTUMOWK58s0vVM6RT11QTBap/
         rSkEgW5/8tLorB8UOD2zemf7GkCkwg60Kb0vwBnjNB8j75PJAZcrHwCpRInN2waZQk6C
         o7PchxdduGNWvTLRfWWfaE/szJbQ1OTQDI8HN8iKg+K7labmzOiiNBgpJ8qXFNMSsRc5
         V8D5+CC6Y9qBb/90fhJjvQ5sem3+Gw9h9xpJ6svl3f5axCROexfJqn8F19yZrJdj0bji
         y0VxYUP/2T1py0xxhq+nB9Pb+zmT/EkM6qY/XN3+pEXLUOhb8fHkEJEv/HWV+i1V2gvz
         RtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684968643; x=1687560643;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ty6/s5RuKHEvXeAN+/GxJYUjZzxOnu0bScAU8fdlguw=;
        b=VE7v6vCE6V+HPu3plVQ4ea3K0Px0xMqsaGpykJzOA/3mvb21hyh8Eo/3bpQqWfxs4r
         ANiFKNkZieSiP7H0aWKf60wHPsX6YXASPXPblrIpGK27b41w6aus7SRAIRZAMY3bUi3q
         2PB/U2sGVnIONdb2mDp7yr8tV9/oBbC28QqXxgdX+h34Wm0ebRtB6zotnjTfK7Lt2hlQ
         69ti8rveeoNHl2ZAKwh/7Nc0zvKUbM3oxQjBYEc9ad9Zo/Y4ifloy0lJArzQn2Ez5UC7
         a52FLyRsXPNcatZBHiD8+GBGtuCoSN1vJAweza9EllisgmWcZaFzuC0QgieA5468H+vs
         4VpQ==
X-Gm-Message-State: AC+VfDyd3gzhDLAxgPoc5RkjptBrm1/RAePrRsRWDC4yhLfKIHtIf1u7
	KJ9g5SKlr/QwyW9j7+/897TGoHv7fnCWZ29RdMwru5GIgRV8mTwzoxw=
X-Google-Smtp-Source: ACHHUZ4drYd72m+tYivf7JZXoyxoc+/qy2VqaM/9mtnXLZjDPwII9iDNKkrE0soCg1D98spyBJvizyEGxbm3qM/qAVY=
X-Received: by 2002:a05:6870:4415:b0:19a:aea3:c96 with SMTP id
 u21-20020a056870441500b0019aaea30c96mr706357oah.55.1684968642650; Wed, 24 May
 2023 15:50:42 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 25 May 2023 07:50:06 +0900
Message-ID: <CAODzB9pUjvqbG+BcDiX8XeJFQY0-ZDVQuQ6X6mnORcV6K2==+g@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 May 2023 22:50:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11645

Hi !

It's this week's CVE report.

This week reported 6 new CVEs and 2 updated CVEs.

* New CVEs

CVE-2023-33203: A use-after-free bug was found in the qualcomm emac driver code

CVSS v3 score is not provided.

The Linux kernel before 6.2.9 has a race condition and resultant
use-after-free in drivers/net/ethernet/qualcomm/emac/emac.
If a physically proximate attacker unplugs an emac based device.

It was introduced by commit b9b17de ("net: emac: emac gigabit ethernet
controller driver") in 4.9-rc1.
Linux 4.4 is not affected.

Fixed status
mainline: [6b6bc5b8bd2d4ca9e1efa9ae0f98a0b0687ace75]
stable/4.14: [aee129c0096e479eae92e2127f96f9d08f16ad8f]
stable/4.19: [4bbc59ec4feb1ea8d5cb3d9d38d4cb1317943ea4]
stable/5.10: [cb5879efde4f9b4de4248b835890df7b6c49ffbc]
stable/5.15: [8c4a180dc12303159592d15e8f077c20deeb1e55]
stable/5.4: [0e5c7d00ec4f2f359234044b809eb23b7032d9b0]
stable/6.1: [5fc2c4e311a9341a2b0e044ab5f33afa37b56226]

CVE-2020-36694: A use-after-free bug was found in the netfilter

CVSS v3 score is not provided.

An issue was discovered in netfilter in the Linux kernel before 5.10.
There can be a use-after-free in the packet processing context,
because the per-CPU sequence count is mishandled during concurrent
iptables rules replacement.
This could be exploited with the CAP_NET_ADMIN capability in an
unprivileged namespace. NOTE: cc00bca was reverted in 5.12.

This bug was introduced by commit 80055da ("netfilter: x_tables: make
xt_replace_table wait until old rules are not used anymore") in
4.15-rc1.
The commit cc00bca ("netfilter: x_tables: Switch synchronization to
RCU") fixes this issue but it has been reverted by commit
d3d40f2 ("Revert "netfilter: x_tables: Switch synchronization to RCU")
in 5.12-rc5 because there was a performance regression.

Fixed status
Not fixed.

CVE-2023-32250: ksmbd: fix racy issue from session setup and logoff

CVSS v3 score is not provided.

This vulnerability allows remote attackers to execute arbitrary code
on affected installations of Linux Kernel. Authentication is not
required to exploit this vulnerability,
but only systems with ksmbd enabled are vulnerable.
The specific flaw exists within the processing of SMB2_SESSION_SETUP
commands. The issue results from the lack of proper locking when
performing operations on an object.
An attacker can leverage this vulnerability to execute code in the
context of the kernel.

The ksmbd was introduced in 5.15 so before 5.15 kernels aren't
affected by this issue.

Fixed status
mainline: [f5c779b7ddbda30866cf2a27c63e34158f858c73]
stable/6.1: [f623f627ad2b1dc215ab3b0df53fb05cfd3a1c3b]
stable/6.3: [02f41d88f15d6b7d523e52cc3f87488f57e9265b]

CVE-2023-32254: ksmbd: fix racy issue under cocurrent smb2 tree disconnect

CVSS v3 score is not provided.

This vulnerability allows remote attackers to execute arbitrary code
on affected installations of Linux Kernel. Authentication is not
required to exploit this vulnerability,
but only systems with ksmbd enabled are vulnerable.
The specific flaw exists within the processing of SMB2_TREE_DISCONNECT
commands. The issue results from the lack of proper locking when
performing operations on an object.
An attacker can leverage this vulnerability to execute code in the
context of the kernel.

The ksmbd was introduced in 5.15 so before 5.15 kernels aren't
affected by this issue.

Fixed status
mainline: [30210947a343b6b3ca13adc9bfc88e1543e16dd5]
stable/6.1: [bd80d35725a0cf4df9307bfe2f1a3b2cb983d8e6]
stable/6.3: [39366b47a59d46af15ac57beb0996268bf911f6a]

CVE-2023-33250: a use-after-free bug was found in iopt_unmap_iova_range

CVSS v3 score is not provided.

The Linux kernel 6.3 has a use-after-free in iopt_unmap_iova_range in
drivers/iommu/iommufd/io_pagetable.c.

Fixed status
Not fixed.

CVE-2023-33288: power: supply: bq24190: Fix use after free bug in
bq24190_remove due to race condition

CVSS v3 score is not provided.

An issue was discovered in the Linux kernel before 6.2.9. A
use-after-free was found in bq24190_remove in
drivers/power/supply/bq24190_charger.c.
It could allow a local attacker to crash the system due to a race condition.

This bug was introduced by commit 9777467 ("power_supply: Initialize
changed_work before calling device_add") in 2.6.39-rc1.

Fixed status
mainline: [47c29d69212911f50bdcdd0564b5999a559010d4]
stable/5.10: [2b346876b93168541a45551d5f9abd1d26102e89]
stable/5.15: [4ca3fd39c72efa250129d2af406c3bb56eec7dd9]
stable/6.1: [84bdb3b76b07f2e62183913a1f5da2d4aa25580a]

* Updated CVEs

CVE-2023-31084: BUG: WARNING in dvb_frontend_get_event

The mainline was fixed.
It looks as if all stable kernels and cip kernels are affected.

Fixed status
mainline: [b8c75e4a1b325ea0a9433fa8834be97b5836b946]

CVE-2022-48425: fs/ntfs3: Validate MFT flags before replaying logs

stable 6.3 and 5.15 were fixed.

Fixed status
mainline: [98bea253aa28ad8be2ce565a9ca21beb4a9419e5]
stable/5.15: [2a67f26f70ab344ae6ea78638890eebc1191a501]
stable/6.3: [e6f4b1c32d6d6047958d7700d12fed6d91f441e7]

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


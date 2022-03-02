Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAD7C433F5
	for <webhook@archiver.kernel.org>; Wed,  2 Mar 2022 23:50:44 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com
 [209.85.161.42])
 by mx.groups.io with SMTP id smtpd.web12.5115.1646265042806074249
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Mar 2022 15:50:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=z8VGCB4o;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.42,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f42.google.com with SMTP id
 s203-20020a4a3bd4000000b003191c2dcbe8so3882817oos.9
        for <cip-dev@lists.cip-project.org>;
 Wed, 02 Mar 2022 15:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=5Ch2klxDC7uCwMHqx7mUzYna3FRzcAxrZUyljibqIhM=;
        b=z8VGCB4owa5thibRE0lmtRmHqLxPdUIxQdc/BHeD1+IkM8SaiSfmjhaEgEB+KuHusM
         I9+WoceXgTYGkd9iVQt0RmKU4xgyDAa/2GDgm/+rgqACeTEt/B2AdapMy9Eh5HkspWjB
         w+Cp55CHXrf8L9laT1ABhljWJdoQghd7elraqKNGRratq9Yl4v14TblCS5cRNXZArHwq
         DSr/SqNXP1ljNVmCQTiBKfDdzOnVVot/A4t04Od4pgl6rkZZDBQP/3xDGRGGFqYoIom0
         rca83zGJ9jcFeJcIEW5HQgloE7imIi0rMNtYnguLIiJATr8hB5IhHmjWRl9zRxeFWf/2
         3ZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5Ch2klxDC7uCwMHqx7mUzYna3FRzcAxrZUyljibqIhM=;
        b=eAldAjWHC5qM/0EOkwubRj/9/n+NAmUrd0TNehcXKKWicJHwI56ms9xDMkQWCXCX/w
         j4gn6Nex5GNggU5GQEplhzUeQHXqVlg9NA5pmsqejYGvodtcFm1VWKwYNly3UUo9pRuc
         j9Up+H7VZtAroMTj3c4yzSU8hsWSIBbjy//7xpyhJpSBwA3FzG472pKB5FYrW/Jtw1qH
         HnbV4AUy/jH+3ndnr6cnxH4CCuPhRxMzLrZ73kjuaVnwguJFY270l390YMzFut8HFvCq
         EsDrk784NTam6LyR47jp+Ed2iJEzXSG14kMkM5u98PgGCAkSM6vQSFgzwUQrLBm5ICAq
         jl0w==
X-Gm-Message-State: AOAM53157yCQ3Vhf6X8IyEpIp2gf3Ql5C371w/P12R9x1mXIXcXb/xRL
	Du5TKMXXPyMhuV+V3PdmHJtUUInO480SRz0XvaYr1mSLoZG43w==
X-Google-Smtp-Source: 
 ABdhPJzHkm0uX4mg4lsE9U+TG+av7ybFe3aDaRwFVG2c5gB/8KZlHuLm0tAcV/X4qj2TVlpvBttXAoFyGiqmTJrF23s=
X-Received: by 2002:a05:6870:3113:b0:d3:473b:3f1d with SMTP id
 v19-20020a056870311300b000d3473b3f1dmr1934781oaa.116.1646265041559; Wed, 02
 Mar 2022 15:50:41 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 3 Mar 2022 08:50:05 +0900
Message-ID: 
 <CAODzB9qrrgv4ZzQKYm=oHkuBeVp4kB-OscqGFpPdJVPPEcYi6Q@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Mar 2022 23:50:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7649

Hi !

It's this week's CVE report.

This week reported 2 new CVEs and 2 updated CVE.

* New CVEs

CVE-2020-36516: Off-Path TCP Exploits of the Mixed IPID Assignment

CVSS v3 score is not provided

An issue was discovered in the Linux kernel through 5.16.11. The mixed
IPID assignment method with the hash-based IPID assignment policy
allows an off-path attacker to inject data into a victim's TCP session
or terminate that session.

According to the commit 23f5740 ("ipv4: avoid using shared IP
generator for connected sockets ") this bug was introduced by commit
73f156a ("inetpeer: get rid of ip_id_count") which was merged at
3.16-rc1.

The 4.4 kernel was fixed in its maintenance phase.

Fixed status

mainline: [23f57406b82de51809d5812afd96f210f8b627f3]
stable/4.14: [853f58791145b6d7e6d2b6ff2a982119e920e21a]
stable/4.19: [eb04c6d1ec67e30f3aa5ef82112cbfdbddfd4f65]
stable/4.4: [e1b3fa7b6471e1b2f4c7573711e7f8ee2e9f3dc3]
stable/4.9: [2b77927a8cb7f540ca2bccff4017745104fe371b]
stable/5.10: [b26fed25e67bc09f28f998569ed14022e07b174b]
stable/5.15: [dee686cbfdd13ca022f20be344a14f595a93f303]
stable/5.16: [32ac95e4478f7aeb1d9f9539430361737eec8459]
stable/5.4: [1f748455a8f0e984dc91fc09e6dfe99f0e58cfbe]

CVE-2022-0812: NFS over RDMA random memory leakage

CVSS v3 score is not provided

According to the red hat bugzilla, it described that "An information
leak flaw was found in NFS over RDMA in the
net/sunrpc/xprtrdma/rpc_rdma.c function in RPCRDMA_HDRLEN_MIN (7) (in
rpcrdma_max_call_header_size, rpcrdma_max_reply_header_size). This
flaw allows an attacker with normal user privileges to leak kernel
information.".

Vulnerable functions rpcrdma_max_call_header_size() and
rpcrdma_max_reply_header_size() were added by commit 302d3de
("xprtrdma: Prevent inline overflow"). These functions are introduced
in 4.7-rc1. The 4.4 kernel's size calculation logic is different from
others so it looks like 4.4 doesn't affect this issue.

Fixed status

Not fixed yet.

* Updated CVEs

CVE-2022-0646: mctp: serial: Cancel pending work from ndo_uninit handler

This bug was introduced by commit 7bd9890 ("mctp: serial: cancel tx
work on ldisc close"). This commit was merged in 5.17-rc1 and has not
been backported to stable kernels. So, stable kernels aren't affected
by this issue.

Fixed status

mainline: [6c342ce2239c182c2428ce5a44cb32330434ae6e]

CVE-2022-25636: netfilter: nf_tables_offload: incorrect flow offload
action array size

This issue was introduced by commit be2861d ("netfilter:
nft_{fwd,dup}_netdev: add offload support") that was merged since
5.4-rc1.

Fixed status

mainline: [b1a5983f56e371046dcf164f90bfaf704d2b89f6]
stable/5.10: [68f19845f580a1d3ac1ef40e95b0250804e046bb]
stable/5.15: [6c5d780469d6c3590729940e2be8a3bd66ea4814]
stable/5.16: [6bff27caef1ee07a8b190f34cf32c99d6cc37a33]
stable/5.4: [49c011a44edd14adb555dbcbaf757f52b1f2f748]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2020-26555: BR/EDR pin code pairing broken

No fix information

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


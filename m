Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D74C4332F
	for <webhook@archiver.kernel.org>; Wed, 12 Oct 2022 23:44:28 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web10.1594.1665618260884055165
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Oct 2022 16:44:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=OhZjExqY;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.171, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-pf1-f171.google.com with SMTP id 3so443331pfw.4
        for <cip-dev@lists.cip-project.org>; Wed, 12 Oct 2022 16:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UFYXNL19hwJQJn18fgqTMGZOA6j0YvehINJicgjDtIs=;
        b=OhZjExqYHa+Vv8qozb4X4xKW91ex+++CHTKG/UqyuqQLhJIcPOQA/fSEfZs7Tzw+CQ
         V/ygOGvvcFOVD9opXAA7uHOo+FICn5t6zjHh0PONSuTt63dPwpfF3zR13Vy24yV2b39T
         /EZQ1xs7WLRqqV3t9HxUndvyeeJYGnu7QwHv9tcfU4amoQwTFOiVCVZy07rmtT9L6UkI
         pwe1bkxTN4H9XXmUQx97FNbGImJHJwVNrvqfaGMYghQ8LzdXWiwve5/MJxXHMXjXyABB
         gc6zcIar5Up0xIvNnLLcaOQC6i5GOTSUbtTGtXtqrsnpkSEZsgiqO6Hrt0SrvEQuNj1h
         oREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UFYXNL19hwJQJn18fgqTMGZOA6j0YvehINJicgjDtIs=;
        b=scRy7oBPq9m+tBxLa7UEcra7ls6qTrSbYaICkYOYYZvdfQcrt/+vWFavuBUloz4UyL
         Mod4CvvHHT/JcAGe4/u5DeMwb+4imgFN2negcPHt37Qr1TSf8m1uRY+P1/BgKusHtKiY
         xamgixY/KEr4nFZmH8fhUZlhsuhKJSgpxIPG9KZ1MdTYaTJE/VfNCpo8acu2SyA+vpDp
         5Yk+F14ODJUlJu4apedG7GmX4S7Zq73nf+eHPFKOPOGWLX3/s6G8oVsalxbHC0J57Cw/
         OPL//z8Q6WJhAH3KzlZl3yFoSp5OKiLgr5OxuIPdfoQP/GC+eSS7Hq2l10bWOtpdiZeS
         bSDA==
X-Gm-Message-State: ACrzQf25r1kZwBpkmD+R/ES3VwXyz4snxrwWujDLGZCvUjd4bIcQxBzz
	ersbwuGg1N8PhXIq9jSJIql+p3TFbdGpZpVPQpsHzJrVWwH5fA==
X-Google-Smtp-Source: AMsMyM5NP5Wx7GPTGUTcWuIWfqMAw1CAV4LZFFNkIAYW2wpezKOI9bZi6kpQ1s1o9PHT/wvo07U0TRs0ieQqwTuqZdQ=
X-Received: by 2002:a63:5164:0:b0:43b:e57c:a15f with SMTP id
 r36-20020a635164000000b0043be57ca15fmr27283356pgl.586.1665618259305; Wed, 12
 Oct 2022 16:44:19 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 13 Oct 2022 08:43:43 +0900
Message-ID: <CAODzB9qKvv13PTN_k5pcDocLHV=q0+YBUrwsNNQ7x_AA8CHjLw@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Oct 2022 23:44:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9747

Hi !

It's this week's CVE report.

This week reported 4 new CVEs and 1 updated CVEs.

* New CVEs

CVE-2022-3424: misc: sgi-gru: fix use-after-free error in
gru_set_context_option, gru_fault and gru_handle_user_call_os

CVSS v3 score is not provided.

A gts value may be freed in gru_check_chiplet_assignment(). However,
the caller still uses it after that, then use-after-free happens.

No CIP member enables CONFIG_SGI_GRU.

Fixed status
Patch is available(https://lore.kernel.org/all/20221006152643.1694235-1-zyytlz.wz@163.com/)
but not merged yet.

CVE-2022-3435: ipv4: Handle attempt to delete multipath route when
fib_info contains an nh reference

CVSS v3 score is 4.3 MEDIUM.

A vulnerability classified as problematic has been found in Linux
Kernel. This affects the function fib_nh_match of the file
net/ipv4/fib_semantics.c of the component IPv4 Handler. The
manipulation leads to out-of-bounds read. It is possible to initiate
the attack remotely. It is recommended to apply a patch to fix this
issue. The identifier VDB-210357 was assigned to this vulnerability.

Commit 493ced1ac47c ("ipv4: Allow routes to use nexthop objects")
introduced this vulnerability.
This commit is not backported to 4.x kernels so they aren't affected
by this vulnerability.

CVE-2022-20409: io_uring: Use original task for req identity in
io_identity_cow()

CVSS v3 score is not provided.

Commit 2ee0cab1 ("io_uring: Use original task for req identity in
io_identity_cow()") described that
 "If the ring is setup with IORING_SETUP_IOPOLL and we have more than
  one task doing submissions on a ring, we can up in a situation where
  we assign the context from the current task rather than the request
  originator."

This vulnerability was introduced by commit 5c3462cfd123b ("io_uring:
store io_identity in io_uring_task") in 5.10-rc1.
The mainline kernel stops to use non-native workers since 5.12-rc1.
So, only 5.10 has this vulnerability.

Fixed status
mainline: [4379bf8bd70b5de6bba7d53015b0c36c57a634ee]
stable/5.10: [2ee0cab11f6626071f8a64c7792406dabdd94c8d]

CVE-2022-42703: anon_vma UAF through bogus merge of VMAs caused by
double-reuse of leaf anon_vma because of ->degree misinterpretation

CVSS v3 score is 5.5 MEDIUM.

mm/rmap.c in the Linux kernel before 5.19.7 has a use-after-free
related to leaf anon_vma double reuse.

This vulnerability was introduced by commit 7a3ef20 ("mm: prevent
endless growth of anon_vma hierarchy") in 3.19-rc4.
CIP's 4.4 kernels can apply c24ca0f17 (this commit is in 4.9) without
modification.

Fixed status
mainline: [2555283eb40df89945557273121e9393ef9b542b]
stable/4.14: [978a70601bdc4c32de4003d3beef4dfa23fff1e0]
stable/4.19: [6dbfc25d68d922736381988d64156a649ccf7bf1]
stable/4.9: [c24ca0f172905d593ad8ab276b0992bb74353a8d]
stable/5.10: [98f401d36396134c0c86e9e3bd00b6b6b028b521]
stable/5.15: [c18a209b56e37b2a60414f714bd70b084ef25835]
stable/5.19: [7877eaa1131147b4d6a063962f3aac0ab1b8ea1c]
stable/5.4: [2fe3eee48899a890310177d54537d5b8e255eb31]

* Updated CVEs

CVE-2022-40768: scsi: stex: properly zero out the passthrough command structure

Vulnerability was in drivers/scsi/stex.c which is compiled when
CONFIG_SCSI_STEX is set.

Fixed status
mainline: [6022f210461fef67e6e676fd8544ca02d1bcfa7a]

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


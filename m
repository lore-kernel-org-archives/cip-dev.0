Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7398C3DA6E
	for <webhook@archiver.kernel.org>; Wed, 20 Dec 2023 23:09:14 +0000 (UTC)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
 by mx.groups.io with SMTP id smtpd.web10.35121.1703113744755291777
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Dec 2023 15:09:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=yaR4mRG6;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.47, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-20403a18a51so63592fac.3
        for <cip-dev@lists.cip-project.org>; Wed, 20 Dec 2023 15:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1703113744; x=1703718544; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sMRhq9BtNlnONKxvyOX/tpJuBUm9qamVU5k+RG2Fp2U=;
        b=yaR4mRG61qLVjCRxLhdPJpMmy4vbTZUXLtjByfJSt3rGodRsvtTPjtw0pdGg4a2u1f
         E3e273Oy06gnmCCXO9kbTK1Nhtn0TI+vnc1Xmd6HZCv1awCMVf8LxVUgJsfRr/vT27ve
         yVgOaFMGOT18dSMBSmtdTJ11wzldDkeHlAYp8cEsxRPlM0Forxk5NV3NQoHEb2jsE7iK
         NllinwY8HPg5fQHEQd4KMTzcTTuobccoLkx65c1KP4KP7CdmEw/3qYtoBvhZOWih8HTf
         +sFyIPSXW1z6h2PWyWVehilS+aEbReZlA2YcR+6veuMBQLcSrhYl5XeeDaRK+sgOlrnr
         lkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703113744; x=1703718544;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sMRhq9BtNlnONKxvyOX/tpJuBUm9qamVU5k+RG2Fp2U=;
        b=IeBS3mTbMIloFx+DMmhTbS+qCx0fLcOnWPll1FXe7fRtpazZRE9H0ffAkG22TscTlA
         UWpCoXL9KaTdCFCt7wXe/6YnrZSMTjYDaAL4j8/B50JyCoDE4ewWuDm+0FX7gTpqgEfK
         VdrtXiBm3vdfv0bsVYUpufxvrJ2ZRevNoKfJZTW1ghA+uyhg0S7yQFbVEeSNwRjUjXCC
         ZgDDu5+5JrH4LdsEU0rzypN2tX5kz4ac5yOLOMrg3MPG2B47OmgoQCAASQrZpOyPbzLi
         HkeqOvhJoKJ8PACaQNU6ykHvYhnnn/8X8P4i3nMv736FnMbFTiMy18CRA+Lytiqm3gcv
         XZUA==
X-Gm-Message-State: AOJu0YwiCee4XeJJgU5eiCvDpnGZyU00OOFx5JJ7lt5BFYWcNJMCjjJO
	+/AdJ467iBmvEWrdu8xOyQiOwi5Vn0oVjMXx9zwnB8P66LjitnciOHY=
X-Google-Smtp-Source: AGHT+IEjOfD9B27CCsxla0rkbj2zQF5eR8x0Kiv5KF2wx8dci8fgqcjqCOFXMi9Y8+1gz5V2fJb97c7xRicKLvcyo4Q=
X-Received: by 2002:a05:6870:d192:b0:203:cac5:f217 with SMTP id
 a18-20020a056870d19200b00203cac5f217mr475106oac.109.1703113743565; Wed, 20
 Dec 2023 15:09:03 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 21 Dec 2023 08:08:27 +0900
Message-ID: <CAODzB9q7Vqna2kPrp7gBPUkGZ5B_fYf+12c+CTNn3N6CDMUfxA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Dec 2023 23:09:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14167

Hi!

It's this week's CVE report.

This week reported 3 new CVEs and 1 updated CVEs.

Talking about CVE-2020-26555, additional mitigation patches were
merged into the mainline.
- Cover letter
https://lore.kernel.org/lkml/20231001084934.GA16906@linux-691t/T/#u

-Bluetooth: Reject connection with the device which has same BD_ADDR
https://github.com/torvalds/linux/commit/1ffc6f8cc33268731fcf9629fc4438f6db1191fc

- Bluetooth: hci_event: Ignore NULL link key
https://github.com/torvalds/linux/commit/33155c4aae5260475def6f7438e4e35564f4f3ba

* New CVEs

CVE-2023-6817: nft_set_pipapo: skip inactive elements during set walk

CVSS v3(NIST): N/A
CVSS v3(CNA): 7.8 (HIGH)

System may crash when walking through active elements in the
nft_pipapo_walk() in net/netfilter/nft_set_pipapo.c. During iteration,
an element can be deactivate twice so if accessing deactivated
element, it will cause a crash.

This bug was introduced by commit 3c4287f ("nf_tables: Add set type
for arbitrary concatenation of ranges") in 5.6-rc1. Before 5.6 kernels
are not affected.

Fixed status
mainline: [317eb9685095678f2c9f5a8189de698c5354316a]
stable/5.10: [bf72b44fe81be08a9fcd58aabf417cd3337ffc99]
stable/5.15: [e65128616faa101b336e52fefbd62b83bb309916]
stable/6.1: [189c2a82933c67ad360c421258d5449f6647544a]
stable/6.6: [c66d39f18e0ef16bac8c8491b657051f531a1eba]

CVE-2023-6931: perf: Fix perf_event_validate_size()

CVSS v3(NIST): N/A
CVSS v3(CNA): 7.8 (HIGH)

A heap out-of-bounds write vulnerability in the Linux kernel's
Performance Events system component can be exploited to achieve local
privilege escalation. A perf_event's read_size can overflow, leading
to an heap out-of-bounds increment or write in perf_read_group().

It was introduced by commit a723968 ("perf: Fix u16 overflows") in
4.3-rc1. Fixed in 6.7-rc5.

Fixed status
mainline: [382c27f4ed28f803b1f1473ac2d8db0afc795a1b]
stable/4.19: [f5d6ab016792c9d6d5280fdb7f8962eb3b8c620e]
stable/5.10: [208dd116f96ea19e5d38d7b80fce49bc5ce1bbe8]
stable/5.15: [ebc7597ce9719d2ff72e13df072680aa491f27fb]
stable/5.4: [152f51d159f35b2f64d7046429703500375becc9]
stable/6.1: [06dec254c59afd01b7a44838cf8bfc382bef019b]
stable/6.6: [cfe9295db0932f1b8e0d94ffc75521898e5a5a8a]

CVE-2023-6932: ipv4: igmp: fix refcnt uaf issue when receiving igmp query packet

CVSS v3(NIST): N/A
CVSS v3(CNA): 7.8 (HIGH)

A use-after-free vulnerability in the Linux kernel's ipv4: igmp
component can be exploited to achieve local privilege escalation. A
race condition can be exploited to cause a timer be mistakenly
registered on a RCU read locked object which is freed by another
thread.

This bug was introduced in less or equal to 2.6.12. Fixed in 6.7-rc4.

Fixed status
mainline: [e2b706c691905fe78468c361aaabc719d0a496f1]
stable/4.14: [be70b329c7fcb4a90c33546dc7c34bff07975b60]
stable/4.19: [6b6f5c6671fdfde9c94efe6409fa9f39436017e7]
stable/5.10: [772fe1da9a8d4dcd8993abaecbde04789c52a4c2]
stable/5.15: [c4a00c47a140c39a0497a40b0f54cf4586a2b1d7]
stable/5.4: [7ccf772a8bad7962d12d48723447c3605a6e23c1]
stable/6.1: [94445d9583079e0ccc5dde1370076ff24800d86e]
stable/6.6: [bf8601dabed0c134a7d58085824e3e466840c5d1]

* Updated CVEs

CVE-2023-25775: improper access control flaw in RDMA driver

stable/5.15 was fixed.

Fixed status
mainline: [bb6d73d9add68ad270888db327514384dfa44958]
stable/4.14: [92f871191e0bcb35dff37815579f15cac329955c]
stable/4.19: [f3c2760510c119c609e751c5a0b06cec6ae4bb4d]
stable/5.10: [ac65f8979b0eaac80c4710729c509d8837d8fdb7]
stable/5.15: [410c05b60c1af650b37ae45010086091f2d0cebe]
stable/5.4: [518b7f7d87aa87cf5173a937baa9a93fc6ed3d6d]
stable/6.1: [f01cfec8d3456bf389918eb898eda11f46d8b1b7]
stable/6.4: [ceba966f1d6391800cab3c1c9ac1661b5166bc5b]
stable/6.5: [782c5702b933477b088e80e6d07b9493145b2916]

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


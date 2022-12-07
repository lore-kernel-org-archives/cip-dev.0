Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECF2C4708D
	for <webhook@archiver.kernel.org>; Wed,  7 Dec 2022 23:26:31 +0000 (UTC)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
 by mx.groups.io with SMTP id smtpd.web10.797.1670455590512292648
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Dec 2022 15:26:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=nwr3Z2xE;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.42, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f42.google.com with SMTP id l42-20020a9d1b2d000000b0066c6366fbc3so12273501otl.3
        for <cip-dev@lists.cip-project.org>; Wed, 07 Dec 2022 15:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1Y90xyHLSRDffkSnOd5G3sw5cYztB8I4LxK1KzWEE2Q=;
        b=nwr3Z2xETn/QkYcOVFHODZ9o6tSNKmysrNAfcvQqryzr/qFAVTNkCwWYW29jdbImbc
         hLcFDjQ6gOXt9ZWVp8mYbo0rhwHwYYVlMrtuoF3QpDuJQmDtR2zSskQSw8vaXV4spM4G
         MPdzd8GFraz9ZM3Ca8pdybgSs16WDCfFQwvBzqFDHsjScGDkUT7M1rQpq3AT1XSMisx6
         nJL2l9ttNwOfzQIMiXUsukv/xTtgn19+m/7RN5gs3Fcqc+AdEKDOybVk9eXEYSUU0JfH
         A6ZvCL0AMJ/0QqGDgzG9Wxu25jAFWyrVMx5gWlPXdWfE/xbqm4LFF6Mx1leVqEQB+FJF
         9bUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Y90xyHLSRDffkSnOd5G3sw5cYztB8I4LxK1KzWEE2Q=;
        b=aHP6LN6PYnlidIxccB6erfBZh5AVckuZLdLUQxeb9mjBwYFwnMdYZ6xO3YBDLGkj1N
         b9O1QUhbsBgy5Yq3jWr1lMudfl9maDTNvBgvm8YHiDbnLUV8nczsY58Hu1kSWjeENF3A
         2V8xPMSrp8yrNZzFyBEt5ATuCWF0MINMD1pBMkqEg491SstECCmXFSQ20ndSl2rwV91d
         fPVGHC0lBAIAMv+vNUbt9ooB+NsQPz5TtokUEBf2DfSzmB3DXvVU+t7f54/ZveS0r4f5
         mBh/bhNrvUNKRdGNlKceCnebHPHmeP0b5ZRnzsOiBbP6sPKWIjrrDBt+GAAjDu9bYPpU
         8Jww==
X-Gm-Message-State: ANoB5pmfY+vZfmeKxst9jGuFAzydHoXOg/jRh5+7u/+RXaAHW0fw7lFI
	dyhYociwHI322RKHBZOluJJkR0SeppAf7suzxCngmy4xM56r2iI8
X-Google-Smtp-Source: AA0mqf7QGb6Axl7V/bgepHhdT1X1xVQADzThI3UcosbVu40oZ06sQNDF6yNCy7X04dFV59e92JPmDtFL52OY3gO1Av8=
X-Received: by 2002:a05:6830:26f2:b0:66e:7c8d:f8 with SMTP id
 m50-20020a05683026f200b0066e7c8d00f8mr13882452otu.223.1670455589048; Wed, 07
 Dec 2022 15:26:29 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 8 Dec 2022 08:25:52 +0900
Message-ID: <CAODzB9p3KP2ahLKtenGzKg35+3DwRaWbfzugFqzavBsTo1mJ=w@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Dec 2022 23:26:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10162

Hi !

It's this week's CVE report.

This week reported 9 new CVEs and 3 updated CVEs.

* New CVEs

CVE-2022-4269: kernel: net: CPU soft lockup in TC mirred
egress-to-ingress action

CVSS v3 score is 5.5MEDIUM.

A deadlock bug was found in the Linux kernel traffic control(TC)
subsystem. When configuring redirecting egress packets to ingress
using TC action "mirred" a local user could trigger deadlock.
This issue was introduced by commit 53592b364001 ("net/sched:
act_mirred: Implement ingress actions") in 4.10-rc1.

Fixed status
Patch is available but it hasn't been merged into the mainlin yet.

CVE-2022-20565: HID: core: Correctly handle ReportSize being zero

CVSS v3 score is not provided.

If ReportSize is 0 which is legal value, calculating total size of
byte will be wrong. When the wrong value is passed to memset() it will
access invalid memory area.
This bug was fixed in 5.9-rc4. cip/4.4 kernels contain backport commit 12b27c4.

Fixed status
mainline: [bce1305c0ece3dc549663605e567655dd701752c]
stable/4.14: [9e5894b7e2229e6d89319864fb08304571fd44f7]
stable/4.19: [abae259fdccc5e41ff302dd80a2b944ce385c970]
stable/4.9: [cf7797ea60e3e721e3ae5090edbc2ec72d715436]
stable/5.4: [667514df10a08e4a65cb88f5fd5ffeccd027c4af]

CVE-2022-20566: Bluetooth: L2CAP: Fix use-after-free caused by l2cap_chan_put

CVSS v3 score is not provided.

A use-after-free bug was found in the Bluetooth subsystem.
When hci_rx_work() starts up after the final channel reference has
been put during sock_clone() and this channel has been destroyed
before starting hci_rx_work(), it will lead to a UAF bug.
cip/4.4 kernels contain backport commit 46e77e0.

This bug was fixed in 5.19.

Fixed status
mainline: [d0be8347c623e0ac4202a1d4e0373882821f56b0]
stable/4.14: [5bb395334392891dffae5a0e8f37dbe1d70496c9]
stable/4.19: [bbd1fdb0e1adf827997a93bf108f20ede038e56e]
stable/4.9: [d255c861e268ba342e855244639a15f12d7a0bf2]
stable/5.10: [de5d4654ac6c22b1be756fdf7db18471e7df01ea]
stable/5.15: [f32d5615a78a1256c4f557ccc6543866e75d03f4]
stable/5.4: [098e07ef0059296e710a801cdbd74b59016e6624]

CVE-2022-20567: l2tp: fix race in pppol2tp_release with session object destroy

CVSS v3 score is not provided.

A race condition bug was found in l2tp subsystem. When
pppol2tp_release() put final reference on its socket by call_rcu,
while pppol2tp_put_sk() is running, pppol2tp_release() may release an
already freed socket.

This bug was introduced by commit ee40fb2 ("l2tp: protect sock pointer
of struct pppol2tp_session with RCU") in 4.15-rc1 and fixed in
4.16-rc5.
cip/4.4 kernels contain backport commit b241b0c.

Fixed status
mainline: [d02ba2a6110c530a32926af8ad441111774d2893]
stable/4.14: [1819c764fe0f851942c2b3cf5dae516e7bbe69d8]
stable/4.9: [267b8fa3f5bf8ca6458670298a02f7438855bd80]

CVE-2022-20568: io_uring: always grab file table for deferred statx

CVSS v3 score is not provided.

A use-after-free bug was found in io_uring.
This bug was only in the 5.10.y stable kernel series. According to the
commit log, it said that "This issues doesn't exist upstream since the
native workers got introduced with 5.12."

Fixed status
stable/5.10: [3c48558be571e01f67e65edcf03193484eeb2b79]

CVE-2022-3643: xen/netback: Ensure protocol headers don''t fall in the
non-linear area

CVSS v3 score is not provided.

A xen guest can reset/abort/crash NIC interface by sending certain
kinds of packets.
This bug was introduced by commit 7e5d775 ("xen-netback: remove
unconditional __pskb_pull_tail() in guest Tx path") in 3.19-rc1 so all
stable kernels affected by this issue.

Fixed status
mainline: [ad7f402ae4f466647c3a669b8a6f3e5d4271c84a]

CVE-2022-42328: xen/netback: don''t call kfree_skb() with interrupts disabled
CVE-2022-42329: xen/netback: don''t call kfree_skb() with interrupts disabled

CVSS v3 score is not provided.

CVE-2022-42328 and CVE-2022-42329 have the same root cause and are
also fixed by the same commit.

Introduced by commit be81992 ("xen/netback: don't queue unlimited
number of packages") in v5.16-rc7. This commit fixes f48da8b
("xen-netback: fix unlimited guest Rx internal queue and carrier
flapping") in 3.18-rc3.
Commit be81992 is not backported to 4.4 kernel because
drivers/net/xen-netback/rx.c isn't present in 4.4.
However, 4.9, 4.19, 5.4, 5.10, 5.15 are affected.

Fixed status
mainline: [74e7e1efdad45580cc3839f2a155174cf158f9b5]

CVE-2022-20572: dm verity: set DM_TARGET_IMMUTABLE feature flag

CVSS v3 score is not provided.

The dm-verity doesn't set its feature as immutable so that it allows a
user to change its target type.

Introduced by commit a4ffc15 ("dm: add verity target") in 3.4-rc1.
In kernel 4.4, verity_target variable is defined in drivers/md/dm-verity.c.

Fixed status
mainline: [4caae58406f8ceb741603eee460d79bacca9b1b5]
stable/4.14: [388bc1e69663956f8cee43af3bd02bd3061d222d]
stable/4.19: [6bff6107d1364c95109609c3fd680e6c8d7fa503]
stable/4.9: [27798cca4e54fe9c390396c4cc655480f827bbd5]
stable/5.10: [8df42bcd364cc3b41105215d841792aea787b133]
stable/5.15: [69712b170237ec5979f168149cd31e851a465853]
stable/5.4: [fd2f7e9984850a0162bfb6948b98ffac9fb5fa58]

* Updated CVEs

CVE-2022-3344: KVM: SVM: nested shutdown interception could lead to host crash

5.15 and 6.0 were fixed.

Fixed status
mainline: [16ae56d7e0528559bf8dc9070e3bfd8ba3de80df,
ed129ec9057f89d615ba0c81a4984a90345a1684]
stable/5.15: [3e87cb0caa25d667a9ca2fe15fef889e43ab8f95,
6425c590d0cc6914658a630a40b7f8226aa028c3]
stable/6.0: [5ca2721b7d3ed4d3da6323a2ea7339f745866d83,
d40ef0a511676bd65ca9acb295430c07af59ab85]

CVE-2022-4139: drm/i915: fix TLB invalidation for Gen12 video and
compute engines

5.10, 5.15, and 6.0 were fixed.

Fixed status
mainline: [04aa64375f48a5d430b5550d9271f8428883e550]
stable/5.10: [86f0082fb9470904b15546726417f28077088fee]
stable/5.15: [ee2d04f23bbb16208045c3de545c6127aaa1ed0e]
stable/6.0: [aef39675ad33317c8badc0165ea882e172a633e6]

CVE-2022-45869: KVM: x86/mmu: Fix race condition in direct_page_fault

6.0 was fixed.

Fixed status
mainline: [47b0c2e4c220f2251fd8dcfbb44479819c715e15]
stable/6.0: [34ced1da74eb975abdf7ef823512c7719f67601b]

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


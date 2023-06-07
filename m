Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B22C7EE25
	for <webhook@archiver.kernel.org>; Wed,  7 Jun 2023 22:19:58 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
 by mx.groups.io with SMTP id smtpd.web11.1703.1686176394866541857
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jun 2023 15:19:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=3tPjq9Ev;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.53, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-558b04141e2so3283071eaf.0
        for <cip-dev@lists.cip-project.org>; Wed, 07 Jun 2023 15:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1686176393; x=1688768393;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HeESQtAqUAB5Ph7+s+ZpolQTnGkR1lsufitS1J96+MY=;
        b=3tPjq9Ev05DpZUENUj+be1sGvYjPr7fQD3wDJ/Pm/vwXGfpn2vrVoxVreWvzoT2erw
         UqNpS9lCGdgR82407jiG3zGpSi8oSlV8cJbauQzywDE0VMd5t+22JUq7ZJC7m2SfoixE
         Z8QtkfBiVhiQkIrHiKOAMYqZUiaWUv1uSl0QUAVjGvpB5vtMlMLS7znZaEGlr4zq7RnV
         mHRwAoN78Fp1ertLVn879bsXNW7amPuCfxzDSQVfpOnHyBMRK4srPH0I6BZpAnphOtkz
         pY84LQm8qQBTGh+OgGKUKXYc6SCVxzIyJFz09XvxalBXZA1lucFqPjxD16UuAZxUX99k
         unaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686176393; x=1688768393;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HeESQtAqUAB5Ph7+s+ZpolQTnGkR1lsufitS1J96+MY=;
        b=C5c8pg12I42VoGf5LJTMW/ebfkc90pZqzK1+UPCbPRQ9xiyp1AYuNSDOEVAg37V+YC
         DVevf/Fb8SYav+/QxqhaWXhTIV0ePhjPCPNIkbveWoEewZTJkXdHJ/nQlLXG9M5uezHu
         bltPFd0JjxnsNyA0/YrbgPXjEjeqYBFXABypjI6UjbRBWyj3omKHZ5+W+pA+RObxMOdP
         vm87+To6kJfqhlD8xSdFRu3YIabJhW2UIGd3ELDHOGdW62rmm+QuoXDe9b09mDHNelNf
         EtWUxDEu2FRkmMUZ2xChL5be8n91W581eCo1o+xodZRDDPn4nbsbQRDZxkjTVDixa6Yp
         miJw==
X-Gm-Message-State: AC+VfDx9aPiX1NnGM3CKSyXCmtbE5oULDQKJ4VlZLxnJogeGInJ7AL3D
	B8diIThDy2nRlswT1qLv8c6lqmK17N7VCBMD6D0WI4IeXc7I4We5i0I=
X-Google-Smtp-Source: ACHHUZ6HwHEQN1WR169UL2AFNjArbZTdHHdaJimpiEm+ZLIG0v10ouYFrk5xoRnqi2cyux5ez2dq/tzKHd6EBXYHUnc=
X-Received: by 2002:a4a:d00d:0:b0:558:b5c7:4832 with SMTP id
 h13-20020a4ad00d000000b00558b5c74832mr5010366oor.3.1686176393307; Wed, 07 Jun
 2023 15:19:53 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 8 Jun 2023 07:19:16 +0900
Message-ID: <CAODzB9o3k=a3QaDE3YOfiTzWND4pnY3TYtOugvjQw6x858Pp7g@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jun 2023 22:19:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11928

Hi !

It's this week's CVE report.

This week reported 4 new CVEs and 1 updated CVEs.

* New CVEs

CVE-2023-3006: arm64: Add AMPERE1 to the Spectre-BHB affected list

CVSS v3 score is not provided.

A known cache speculation vulnerability, known as Branch History
Injection (BHI) or Spectre-BHB, becomes actual again for the new hw
AmpereOne. Spectre-BHB is similar to Spectre v2, except that malicious
code uses the shared branch history (stored in the CPU Branch History
Buffer, or BHB) to influence mispredicted branches within the victim's
hardware context. Once that occurs, speculation caused by the
mispredicted branches can cause cache allocation. This issue leads to
obtaining information that should not be accessible.

The arch/arm64/kernel/proton-pack.c was introduced by commit 455697ad
("arm64: Introduce separate file for spectre mitigations and
reporting") int 5.10-rc1. Kernel 5.4, 4.19, and 4.14 have
spectre_bhb_loop_affected() in the arch/arm64/kernel/cpu_errata.c but
4.4 doesn't

Fixed status
mainline: [0e5d5ae837c8ce04d2ddb874ec5f920118bd9d31]
stable/5.10: [52a43b82006dc88f996bd06da5a3fcfef85220c8]
stable/5.15: [52c2329147cf5d956dcaa3a91c886c550e7bdd39]

CVE-2023-2985: A use-after-free bug was found hfsplus file system

CVSS v3 score is 5.5(MEDIUM).

A use after free flaw was found in hfsplus_put_super in
fs/hfsplus/super.c in the Linux Kernel. This flaw could allow a local
user to cause a denial of service problem.

Fixed status
mainline: [07db5e247ab5858439b14dd7cc1fe538b9efcf32]
stable/4.14: [a9433406837c211af58a533d9e6f7a8f865b01f3]
stable/4.19: [e226f1fdcee1ca6e68233b132718deb578a84e38]
stable/5.10: [ef7d71d7bd57b8b7fe514e459927696c1c6d1047]
stable/5.15: [05103d88482dc3757db108415342fdd86821a79b]
stable/5.4: [3776ef785e1005355cdd86c751a8e838bac8e2e8]
stable/6.1: [0c80bef0b7d297ea86e5408fe79c45479e504a26]

CVE-2023-3022: ipv6: Use result arg in fib_lookup_arg consistently

CVSS v3 score is not provided.

According to the Red Hat bugzilla, there is a kernel crash bug that
was found in the ipv6 subsystem when some specific networking local
rule enabled and both IPV6 being used.

This bug was introduced by commit effda4d ("ipv6: Pass fib6_result to
fib lookups") in 5.2-rc1. Kernel 4.x are not affected by this issue.

Fixed status
mainline: [a65120bae4b7425a39c5783aa3d4fc29677eef0e]

CVE-2023-3111: btrfs: unset reloc control if transaction commit fails
in prepare_to_relocate()

CVSS v3 score is not provided.

A use after free vulnerability was found in prepare_to_relocate in
fs/btrfs/relocation.c in btrfs in the Linux Kernel. This possible flaw
can be triggered by calling btrfs_ioctl_balance() before calling
btrfs_ioctl_defrag().
It was fixed in 6.0-rc2.

Fixed status
mainline: [85f02d6c856b9f3a0acf5219de6e32f58b9778eb]
stable/5.15: [78f8c2370e3d33e35f23bdc648653d779aeacb6e]

* Updated CVEs

CVE-2023-2156: Linux Kernel IPv6 RPL Protocol Reachable Assertion
Denial-of-Service Vulnerability

The mainline, stable 5.10, 5.15, and 6.1 were fixed. It was introduced
by commit 8610c7c ("net: ipv6: add support for rpl sr exthdr") in
5.7-rc1 and fixed in 6.3. Before 5.7 kernels don't contain commit
8610c7c so that these kernels aren't affected.

Fixed status
mainline: [4e006c7a6dac0ead4c1bf606000aa90a372fc253]
stable/5.10: [c972851d3848647f57cd8d5625c48663410c3f96]
stable/5.15: [4eee0d9d3c1117aa4a1c9f4c7f29287107e7c084]
stable/6.1: [9a0b96d03c59ba560b074cdb9b6233493fd5492d]

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


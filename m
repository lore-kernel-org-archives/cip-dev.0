Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B73EE0211
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 22:35:45 +0000 (UTC)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
 by mx.groups.io with SMTP id smtpd.web10.10945.1694644535824829327
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Sep 2023 15:35:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=XyPvkvMM;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.50, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5739972accdso790471eaf.1
        for <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 15:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1694644534; x=1695249334; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NJurSMfvSMjzxt25jcVaBPtS/Mmjv0jaoHwEFPnk+Nw=;
        b=XyPvkvMMc0bUMFDYZjU6ND0MBvaY77t9ClGmOdON/jL0ptsMZy2daYWd3L8d5LGaJe
         276aZGA+AKA9ml9zCiKEu9o1Kf2KgDcZIRubXkfZmOcMfuC9Db4u7b4b51MXxlGv5S2R
         wgP+DWwQGPQ8BSiAMZhbK6s5tgJ1GaGIzgCw396Ma6OzyFSiPKrqVqB/gHMRzk2eV9RS
         juqN2FDPFoxyWrTutJfWeE85UGY5IhM2c+4VZ+jjIUmu7zUWFfpMaRJlYH9JHdZXt+vk
         IrlDq8e1EIg0h66bl1bn8hxZt3bgkoMDz0VvdWZtaCKyeMgT6JIeoATgJgPT5NPqcUr+
         McvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694644534; x=1695249334;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJurSMfvSMjzxt25jcVaBPtS/Mmjv0jaoHwEFPnk+Nw=;
        b=ak1PtaqqoHz51gTTq9YlNa8VoBIb7++UPSHLFzY/EIc/Yj0n38cx5ukksbrqEvyle9
         NKWqrPF+vpJQ2AOxyvtBhmAuFQaIszrDGF32JPOF+YKv2PjqRjmRTAgWuK1iutPgYYj/
         pEXS0jNvrwPyvPuUPz5l077ZXqQwrK5hEV8QIPnTmams4wnUhJGI5IsFzVQiexW94JoA
         J+sLW4ltW2RPIh/E0R6VJfgV7iVehsTd+WHLqNZGgJEcSoBl4pD4NIvktlGoOV0Z46nX
         ewiAY6nU30cVzQGGSx8NGY/QeXqgM3YuXH26rVWxfFOXfKGjcgZC+UGDQH2vBW11zPFG
         PBmg==
X-Gm-Message-State: AOJu0YxUBkfUyetk8sMX2T5Dixe1taNqLEDM4LZOGbfxQgl6q/q+WIf8
	+XJjiO1omy3d++M+IYdUwgRNbob0Ayi4BYLUz+d77Vosrv0j66KrGHk=
X-Google-Smtp-Source: AGHT+IGfVfhdHrPF2VuNaIySn1YPOuEKsatoUt9c6IGGIE+prfUZHwOgvSpIdgZy6FNFWha7YwxseFg+D0/tngRl40E=
X-Received: by 2002:a05:6870:526:b0:1c5:1269:9e2c with SMTP id
 j38-20020a056870052600b001c512699e2cmr68093oao.9.1694644534590; Wed, 13 Sep
 2023 15:35:34 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 14 Sep 2023 07:34:58 +0900
Message-ID: <CAODzB9poNH=6Bn2OGED3F3jxGJ+D94vYx_Hkt=_YsDS7=pdH7Q@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 22:35:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13125

Hi !

It's this week's CVE report.

This week reported 6 new CVEs and 3 updated CVEs.

* New CVEs

CVE-2023-4244: A use-after-free vulnerability in the Linux kernel's netfilter

CVSS v3 score is 7.0 HIGH (NIST).
CVSS v3 score is 7.8 HIGH (CNA).

A use-after-free vulnerability in the Linux kernel's netfilter:
nf_tables component can be exploited to achieve local privilege
escalation. Due to a race condition between nf_tables netlink control
plane transaction and nft_set element garbage collection, it is
possible to underflow the reference counter causing a use-after-free
vulnerability.

It may be a duplicate of CVE-2023-4563.

Fixed status
mainline: [5f68718b34a531a556f2f50300ead2862278da26,
f6c383b8c31a93752a52697f8430a71dcbc46adf,
  c92db3030492b8ad1d0faace7a93bbcf53850d0c,
a2dd0233cbc4d8a0abb5f64487487ffc9265beb5]

CVE-2023-4881: netfilter: nftables: exthdr: fix 4-byte stack OOB write

CVSS v3 score is 7.1 HIGH(NIST).
CVSS v3 score is 6.1 MEDIUM (CNA).

A stack based out-of-bounds write flaw was found in the netfilter
subsystem in the Linux kernel.
If the expression length is a multiple of 4 (register size), the
`nft_exthdr_eval` family of
functions writes 4 NULL bytes past the end of the `regs` argument,
leading to stack corruption
and potential information disclosure or a denial of service.

The commit fd94d9d fixes commit 49499c3 ("netfilter: nf_tables: switch
registers to 32 bit addressing") in 4.1-rc1,
935b7f6 ("netfilter: nft_exthdr: add TCP option matching") in
4.11-rc1, 133dc20 ("netfilter:
nft_exthdr: Support SCTP chunks") in 5.14-rc1, and dbb5281
("netfilter: nf_tables: add support
for matching IPv4 options") in 5.3-rc1.

Fixed status
mainline: [fd94d9dadee58e09b49075240fe83423eb1dcd36]

CVE-2023-4921: net: sched: sch_qfq: Fix UAF in qfq_dequeue()

CVSS v3 score is not provided (NIST).
CVSS v3 score is 7.8 HIGH (CNA).

A use-after-free vulnerability in the Linux kernel's net/sched:
sch_qfq component can be exploited to
achieve local privilege escalation. When the plug qdisc is used as a
class of the qfq qdisc, sending
network packets triggers use-after-free in qfq_dequeue() due to the
incorrect .peek handler of sch_plug
and lack of error checking in agg_dequeue().

This vulnerability was introduced by commit 462dbc9 ("pkt_sched: QFQ
Plus: fair-queueing service at DRR cost") in 3.8-rc1.

Fixed status
mainline: [8fc134fee27f2263988ae38920bc03da416b03d8]

CVE-2023-3865: ksmbd: fix out-of-bound read in smb2_write

CVSS v3 score is not provided.

This vulnerability allows remote attackers to disclose sensitive
information on affected installations of Linux Kernel.
Authentication may or may not be required to exploit this
vulnerability, depending upon configuration. Furthermore,
only systems with ksmbd enabled are vulnerable.

The specific flaw exists within the parsing of smb2_hdr structure. The
issue results from the lack of proper validation
of user-supplied data, which can result in a read past the end of an
allocated buffer. An attacker can leverage this in
conjunction with other vulnerabilities to execute arbitrary code in
the context of the kernel.

Vulnerable function ksmbd_smb2_check_message() was introduced by
commit e2f3448("cifsd: add server-side procedures for SMB3")
in 5.15-rc1.

Fixed status
mainline: [5fe7f7b78290638806211046a99f031ff26164e1]
stable/5.15: [3813eee5154d6a4c5875cb4444cb2b63bac8947f]
stable/6.1: [c86211159bc3178b891e0d60e586a32c7b6a231b]

CVE-2023-3866: ksmbd: validate session id and tree id in the compound request

CVSS v3 score is not provided.

This vulnerability allows remote attackers to create a
denial-of-service condition on affected installations of Linux Kernel.
Authentication is not required to exploit this vulnerability, but only
systems with ksmbd enabled are vulnerable.

The specific flaw exists within the handling of chained requests. The
issue results from dereferencing a NULL pointer.
An attacker can leverage this vulnerability to create a
denial-of-service condition on the system.

It was introduced by commit e2f3448("cifsd: add server-side procedures
for SMB3") in 5.15-rc1.

Fixed status
mainline: [5005bcb4219156f1bf7587b185080ec1da08518e]
stable/5.15: [eb947403518ea3d93f6d89264bb1f5416bb0c7d0]
stable/6.1: [854156d12caa9d36de1cf5f084591c7686cc8a9d]

CVE-2023-3867: ksmbd: add missing compound request handing in some commands

CVSS v3 score is not provided.

This vulnerability allows remote attackers to disclose sensitive
information on affected installations of Linux Kernel.
Authentication is not required to exploit this vulnerability. However,
only systems with ksmbd enabled are vulnerable.

The specific flaw exists within the handling of session setup
commands. The issue results from the lack of proper validation
of user-supplied data, which can result in a read past the end of an
allocated buffer. An attacker can leverage this in
conjunction with other vulnerabilities to execute arbitrary code in
the context of the kernel.

This vulnerability was introduced by commit 7b7d709e("ksmbd: add
missing compound request handing in some commands") in 6.5-rc1.

Fixed status
mainline: [7b7d709ef7cf285309157fb94c33f625dd22c5e1]
stable/6.1: [869ef4f2965bbb91157dad220133f76c16faba9b]
stable/6.4: [ffaa0c85edd9245594a94918c09db9163b71767a]

* Updated CVEs

CVE-2023-25775: improper access control flaw in RDMA driver

stable 6.1, 6.4, and 6.5 were fixed.

Fixed status
mainline: [bb6d73d9add68ad270888db327514384dfa44958]
stable/6.1: [f01cfec8d3456bf389918eb898eda11f46d8b1b7]
stable/6.4: [ceba966f1d6391800cab3c1c9ac1661b5166bc5b]
stable/6.5: [782c5702b933477b088e80e6d07b9493145b2916]

CVE-2023-37453: i out-of-bounds in read_descriptors in drivers/usb/core/sysfs

stable 6.1, 6.4, and 6.5 were fixed.

Fixed status
stable/6.1: [8186596a663506b1124bede9fde6f243ef9f37ee]
stable/6.4: [b4a074b1fb222164ed7d5c0b8c922dc4a0840848]
stable/6.5: [b9fbfb349eacc0820f91c797d7f0a3ac7a4935b5]

CVE-2023-4623: net/sched: sch_hfsc: Ensure inner classes have fsc curve

stable 6.1, 6.4, and 6.5 were fixed.

Fixed status
mainline: [b3d26c5702c7d6c45456326e56d2ccf3f103e60f]
stable/6.1: [a1e820fc7808e42b990d224f40e9b4895503ac40]
stable/6.4: [5293f466d41d6c2eaad8b833576ea3dbee630dc2]
stable/6.5: [eb07894c51c7d6bb8d00948a3e6e7b52c791e93e]

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


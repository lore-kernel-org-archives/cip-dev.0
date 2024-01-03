Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28203C47073
	for <webhook@archiver.kernel.org>; Wed,  3 Jan 2024 23:09:48 +0000 (UTC)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
 by mx.groups.io with SMTP id smtpd.web10.41889.1704323380643668355
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jan 2024 15:09:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=aVvV6Sqx;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.48, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-204fdd685fdso4249253fac.2
        for <cip-dev@lists.cip-project.org>; Wed, 03 Jan 2024 15:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1704323379; x=1704928179; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=43SbFGuy0+Ewdtih1Q6+J2St3mNmF2SrLqorBOTaRkA=;
        b=aVvV6Sqx4BjQ/mFvL2jSzdTiK/9//TfQFj6UIcO8wkarSJRoSmMjsP8t3BRb3uc7vF
         9qVKp5rFPf/4GVTT6OWb75N/n8l3NB5kLEXzs4uo7N/grB5sxqJGJ2HK6VBZoLOMhKlS
         48hQo4kY/LMKs++iC450zO0nqAgPNdOoj73SFUHCB07/HUFQkVLW8EbmOWxV7a3dyqos
         jJGmH0jZ1c6NDR++/+KIgdTn11i52bi/6Ai+bR2DCvajgME/FQKctMqrpYJLDlamYJmM
         nGO0qL7KxFC3hyEzLwmqPau0Z619cNjiMZhdf0Ka198Zjf0sD8dnNZ+hlULlF0bBHWoJ
         Nt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704323379; x=1704928179;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=43SbFGuy0+Ewdtih1Q6+J2St3mNmF2SrLqorBOTaRkA=;
        b=DhE0a4/tLggoZMOLEusrE++avFwv9x491IisNb7ao+YjNRQF7xKD3Zeeh7q0Tmo2gr
         X/6tPm8UmgVQrejgQeNZ9w3LmHXvo8MQtQkRhpmpal23EOxQo1nDweBclsyrq69B4yiC
         /eQCcUXzms/PnX1x5E/fr9te/SWj6Gkw0lBQw0yzqwC9I+09Haiy+T0iVMmOTrmWKX0w
         eHdwZFLIwD0O9md8nOYHpcs7p3SpNo3xDPkDLDx/0SDCuXAgOJaD4GE7psGtrisVltJJ
         hDUszBoc3nKw0qxZv0RUt+EMnnIsnDTflLCPD1dk2+d/4KpGy5Eb1jW8CkZZk6ueAdvl
         GlSw==
X-Gm-Message-State: AOJu0YzefwpsRSQSOMkAJ3GWLNMExGq977b+0xok1houYQxjgDmaIQn1
	Sf9R2RdtbE34XAkGWnfeXPAkrXbHlVOfkAW0gSSGfm9CoAMA+ida+e6k2Rjiovw=
X-Google-Smtp-Source: AGHT+IEXy3viZSggEciAbeNq32E+3PvOoP33A6Jv6AcN7MNUWV9Bj+GShJPuAgdcm6ujRu8WIy1Sri/bkl0Zy8tlAV0=
X-Received: by 2002:a05:6870:b69c:b0:203:a983:c7b with SMTP id
 cy28-20020a056870b69c00b00203a9830c7bmr26925985oab.60.1704323379577; Wed, 03
 Jan 2024 15:09:39 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 4 Jan 2024 08:09:03 +0900
Message-ID: <CAODzB9rxqmUTuB6yJbqw2h0rzcZSUqhP=HY0ErDd2eCER6e2dw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Jan 2024 23:09:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14252

Hi!

It's this week's CVE report.

This week reported 4 new CVEs and 2 updated CVEs.

* New CVEs

CVE-2023-6531: io_uring/af_unix: disable sending io_uring over sockets

CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

A use-after-free bug was found in the io_uring subsystem for
supporting af_unix socket. There was a race condition bug that causes
use-after-free.

This bug was introduced by commit 0091bfc ("io_uring/af_unix: defer
registered files gc to io_uring release") in 6.1-rc1. It has been
backported to 5.4, 5.10, and 5.15.

Fixed status
mainline: [705318a99a138c29a512a72c3e0043b3cd7f55f4,
69db702c83874fbaa2a51af761e35a8e5a593b95]
stable/5.10: [3fe1ea5f921bf5b71cbfdc4469fb96c05936610e]
stable/6.1: [5a33d385eb36991a91e3dddb189d8679e2aac2be]

CVE-2023-6546: A use-after-free bug was found in the gsm_cleanup_mux()

CVSS v3(NIST): 7.0 (HIGH)
CVSS v3(CNA): 7.8 (HIGH)

A race condition was found in the GSM 0710 tty multiplexor in the
Linux kernel. This issue occurs when two threads execute the
GSMIOC_SETCONF ioctl on the same tty file descriptor with the gsm line
discipline enabled, and can lead to a use-after-free problem on a
struct gsm_dlci while restarting the gsm mux. This could allow a local
unprivileged user to escalate their privileges on the system.

In commit 9b9c819 ("tty: n_gsm: fix UAF in gsm_cleanup_mux") tried to
fix a use-after-free bug but introduced a race condition which causes
this use-after-free bug.

The commit 9b9c819 was introduced in 6.5.-rc4. This CVE was fixed in 6.5-rc7.

Fixed status
mainline: [3c4f8333b582487a2d1e02171f1465531cde53e3]
stable/5.10: [869ce5e5984595bd2c62b598d977debc218b6f4d]
stable/5.15: [2a523446438376bb7c224f3169ae9b98ce0fb893]
stable/6.1: [31311a9a4baae0ad47c85e448af21b2120344ff0]

CVE-2023-7192: A memory leak problem was found in
ctnetlink_create_conntrack() in the netfilter subsystem

CVSS v3(NIST): N/A
CVSS v3(CNA): 6.1 (MEDIUM)

A memory leak problem was found in ctnetlink_create_conntrack in
net/netfilter/nf_conntrack_netlink.c in the Linux Kernel. This issue
may allow a local attacker with CAP_NET_ADMIN privileges to cause a
denial of service (DoS) attack due to a refcount overflow.

This bug was introduced by commit 7d367e0 ("netfilter: ctnetlink: fix
soft lockup when netlink adds new entries (v2)") in 3.3-rc6.
The commit 7d367e0 fixes a race condition bug which was introduced by
commit cfed7e1 ("netfilter: nf_tables: add set garbage collection
helpers") in 4.1-rc1.

This CVE was fixed in 6.3-rc1.

Fixed status
cip/4.4: [a3f90f806278532e352739f354ace32e69e96da4]
cip/4.4-rt: [a3f90f806278532e352739f354ace32e69e96da4]
cip/4.4-st: [a3f90f806278532e352739f354ace32e69e96da4]
mainline: [ac4893980bbe79ce383daf9a0885666a30fe4c83]
stable/4.14: [8df5f3b50d9ce523251edf9cd0470963be20004b]
stable/4.19: [43b9a9c78e37a5532c2a9260dff9d9989f2bbb23]
stable/5.10: [1ff0b87df98b93e10ced45773aa7d35377355421]
stable/5.15: [af41b3cd9a9245f482b8855bd3c62c6f04ae68ab]
stable/5.4: [5d0d38805d3234ca2cd6fbeb74d706348f4bbc43]
stable/6.1: [4f25d1dff80535f088b8f8568dd731fb098e29b4]

CVE-2024-0193: netfilter: nf_tables: skip set commit for deleted/destroyed sets

CVSS v3(NIST): N/A
CVSS v3(CNA): 7.8 (HIGH)

A use-after-free flaw was found in the netfilter subsystem of the
Linux kernel. If the catchall element is garbage-collected when the
pipapo set is removed, the element can be deactivated twice. This can
cause a use-after-free issue on an NFT_CHAIN object or NFT_OBJECT
object, allowing a local unprivileged user to escalate their
privileges on the system.

This bug was introduced by commit 5f68718b34a5 ("netfilter: nf_tables:
GC transaction API to avoid race with control plane") in 6.5-rc6.
The commit 5f68718b34a5 was backported to 5.10, 5.15, 5.4, and 6.4.

Fixed status
Patch is merged into netfilter tree
(https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git/commit/?id=7315dc1e122c85ffdfc8defffbb8f8b616c2eb1a)
but it hasn't been merged into the mainline yet.

* Updated CVEs

CVE-2023-51779: Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg

Stable 6.1 and 6.6 were fixed.

Fixed status
mainline: [2e07e8348ea454615e268222ae3fc240421be768]
stable/6.1: [37f71e2c9f515834841826f4eb68ec33cfb2a1ff]
stable/6.6: [1d576c3a5af850bf11fbd103f9ba11aa6d6061fb]

CVE-2023-6606: Out-Of-Bounds Read vulnerability in smbCalcSize

Stable 6.1 and 6.6 were fixed.

Fixed status
mainline: [b35858b3786ddbb56e1c35138ba25d6adf8d0bef]
stable/6.1: [c60e10d1549f8748a68ec13dcd177c62843985ff]
stable/6.6: [ac48fcef5ec2e9ac85c0b39045d874e60eac75d7]

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


Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98BAEB64DA
	for <webhook@archiver.kernel.org>; Wed, 12 Jul 2023 23:25:40 +0000 (UTC)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
 by mx.groups.io with SMTP id smtpd.web10.1380.1689204334478489189
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Jul 2023 16:25:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=ZhkBGtzQ;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.42, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6b74b37fbe0so54972a34.1
        for <cip-dev@lists.cip-project.org>; Wed, 12 Jul 2023 16:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1689204332; x=1691796332;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GqDICk6kuzHTsK+v7y37EvV8V75Iy7gUcup6qopRHio=;
        b=ZhkBGtzQzB4Ntz5/VNdH/jSrU5U/b1ArJZAEfzmtA2nid3L1g2Vz0oPvhP/vdq89d2
         6jAoJ08dlxyvvk93L6nt5WDKMc23cFb7mGeARi+kk5Pj95o2s5rm8hw6Do7OBUxT7uF8
         AE93eQPI188gcsjv5XD3q5uAsHn+9zPnyCfmAyQ+eqwwDAa5Kvzd9s7yv1MzuFNKDJ6d
         bUwnDdq7kN835oTjkDZ8EPTd/sgasdl378HxFJPtK4SdDXd+2ak7dEa9ZvtLqKMqN9Xc
         BddDnlY5hA5FEd5XQQNYzFGc+wl3cZEiNAIYIIATuzcRRK52Ir3tfO+aTry2sBznlmg7
         PpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689204332; x=1691796332;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqDICk6kuzHTsK+v7y37EvV8V75Iy7gUcup6qopRHio=;
        b=gHaq+80TcBCxOoJEI+l7bUuFPtnel8k3rJUjRNTIDDsBh6Xqp7Iv/dGKev0oxB3wWT
         28LGO1UVq6Yw2rmP8a0WljFwmPQiizt8JcV9x0MCMC0UWfW43TzHKpTfNmLbSQFt+XQP
         AzOdM4MhAqChDEaZ+jcQN3MxXU500s0bscVtPNHufXqU99DYjzxXWSpsOiuus9D9zel6
         6NS44qmKZDKhS4y2cXUcQsW9RPlFJ3zoPDYdJVWhGZ0xI99vDorcvIuYE6TkdA8szd/+
         waXsX3FGUX/Nco9xfmhHxFSwKB93cF+MMnzn9f3vyv0djxW80VOOfNfEq3kwOJs9lDjL
         tKNw==
X-Gm-Message-State: ABy/qLaoEw8UotUh83Y3DAb0WpusTnGFe2m6mlhnTZglS8cxR0Wmllmg
	PTJhQJvDOdGYlepCGc3wbCsIpRGrbH1arK3BbLcxS8Qqd6U5GW3FPzU=
X-Google-Smtp-Source: APBJJlGprDIeCT0EtO3wsQt5fgFW8W6htNJXD/z/cij6IKxv9KAW40t3AkJ558CrX6YnCAV8jxLpaifcEnfij083684=
X-Received: by 2002:a9d:768b:0:b0:6b9:304a:e778 with SMTP id
 j11-20020a9d768b000000b006b9304ae778mr21563otl.34.1689204331819; Wed, 12 Jul
 2023 16:25:31 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 13 Jul 2023 08:24:54 +0900
Message-ID: <CAODzB9romU4fGXwGP_+kx+ujExDLqZnxrjYqkETeygrwKf55Qw@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Jul 2023 23:25:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12328

Hi !

It's this week's CVE report.

This week reported 6 new CVEs and 0 updated CVEs.

A new exploitation technique called Dirty Pagetable has been published
(https://yanglingxi1993.github.io/dirty_pagetable/dirty_pagetable.html).
It is interesting to read. This technique can bypass major mitigation
methods like KASLR, SMAP, and so on. It abuses heap-based
vulnerabilities to manipulate user page tables.

* New CVEs

CVE-2023-21255: binder: fix UAF caused by faulty buffer cleanup

CVSS v3 score is not provided.

A use-after-free bug was found in binder_transaction_buffer_release().
When a transaction buffer is released without
any objects having been processed, it leads to a use-after-free bug.
This bug was introduced by commit 32e9f56 ("binder: don't detect
sender/target during buffer cleanup") in 5.16-rc1.
This commit fixes 44d8047 ("binder: use standard functions to allocate
fds") in 4.20-rc1. So, commit 32e9f56 isn't backported to 4.x kernels.

Fixed status
mainline: [bdc1c5fac982845a58d28690cdb56db8c88a530d]
stable/5.10: [2218752325a98861dfb10f59a9b0270d6d4abe21]
stable/5.15: [5fd7c1e36b0a500d5fce820ee63c2a5b47b36e85]
stable/5.4: [6c88024cab83c820604db5f6a998ef3ae5682f1c]
stable/6.1: [e1e198eff1fbaf56fd8022c4fbbf59c5324ea320]
stable/6.3: [c9e6aae1f26758f3e87b93cff18d79dfd80f2f25]

CVE-2023-32248: Linux Kernel ksmbd Tree Connection NULL Pointer
Dereference Denial-of-Service Vulnerability

CVSS v3 score is not provided.

This vulnerability allows remote attackers to create a
denial-of-service condition on affected installations of Linux Kernel.
Authentication is not required to exploit this vulnerability, but only
systems with ksmbd enabled are vulnerable.

The specific flaw exists within the handling of SMB2_TREE_CONNECT and
SMB2_QUERY_INFO commands. The issue results from the lack of proper
validation of a pointer prior to accessing it. An attacker can
leverage this vulnerability to create a denial-of-service condition on
the system.

The ksmbd subsystem was introduced in 5.15 so before this versions are
not affected.

Fixed status
mainline: [3ac00a2ab69b34189942afa9e862d5170cdcb018]
stable/5.15: [227eb2689b44d0d60da3839b146983e73435924c]
stable/6.1: [a70751dd7b60eab025e97e19b6b2477c6eaf2bbb]
stable/6.3: [1636e09779f83e10e6ed57d91ef94abcefdd206b]

CVE-2023-37453: out-of-bounds in read_descriptors in drivers/usb/core/sysfs

CVSS v3 score is 4.4 MEDIUM.

An issue was discovered in the USB subsystem in the Linux kernel
through 6.4.2. There is an out-of-bounds and crash in read_descriptors
in drivers/usb/core/sysfs.c.

Fixed status
Not fixed yet.

CVE-2023-37454: use-after-free in udf_put_super and udf_close_lvid
functions in fs/udf/super.c

CVSS v3 score is 5.5 MEDIUM.

An issue was discovered in the Linux kernel through 6.4.2. A crafted
UDF filesystem image causes a use-after-free write operation in the
udf_put_super and udf_close_lvid functions in fs/udf/super.c.

Fixed status
Not fixed yet.

CVE-2023-3567: use-after-free in vcs_read in drivers/tty/vt/vc_screen.c

CVSS v3 score is not provided.

A use-after-free bug was found in vcs_size() in the drivers/tty/vt/vc_scree=
n.c.
It was introduced by commit ac751ef ("console: rename
acquire/release_console_sem() to console_lock/unlock()") in
2.6.38-rc3.

Fixed status
mainline: [226fae124b2dac217ea5436060d623ff3385bc34]
stable/4.19: [6332f52f44b9776568bf3c0b714ddfb0bb175e78]
stable/5.10: [55515d7d8743b71b80bfe68e89eb9d92630626ab]
stable/5.15: [fc9e27f3ba083534b8bbf72ab0f5c810ffdc7d18]
stable/5.4: [d0332cbf53dad06a22189cc341391237f4ea6d9f]
stable/6.1: [8506f16aae9daf354e3732bcfd447e2a97f023df]

CVE-2023-3108: rypto: fix af_alg_make_sg() conversion to iov_iter

CVSS v3 score is not provided (NIST).
CVSS v3 score is 6.2 MEDIUM (CNA).

A flaw was found in the subsequent get_user_pages_fast in the Linux
kernel=E2=80=99s interface for symmetric key cipher algorithms in the
skcipher_recvmsg of crypto/algif_skcipher.c function. This flaw allows
a local user to crash the system.

This bug was introduced by commit 1d10eb2 ("crypto: switch
af_alg_make_sg() to iov_iter") in 4.0-rc1 and fixed by commit 9399f0c
("crypto: fix af_alg_make_sg() conversion to iov_iter") in 4.0-rc1.
So, this bug was introduced and fixed during the 4.0-rc1 development
cycle. Therefore, no released kernels are affected.

Fixed status
mainline: [9399f0c51489ae8c16d6559b82a452fdc1895e91]

* Updated CVEs

No update CVEs.

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
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
      :masami.ichikawa@miraclelinux.com


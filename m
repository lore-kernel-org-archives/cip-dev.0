Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6A5C05027
	for <webhook@archiver.kernel.org>; Thu,  2 Feb 2023 00:56:32 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
 by mx.groups.io with SMTP id smtpd.web11.3899.1675299389315259105
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Feb 2023 16:56:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=kX2a9105;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.42, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f42.google.com with SMTP id h12-20020a4a940c000000b004fa81915b1cso62315ooi.4
        for <cip-dev@lists.cip-project.org>; Wed, 01 Feb 2023 16:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0pNvtKsUKFyaxM8hgq3BCNfldA7V9VskuLtJaTKsCMQ=;
        b=kX2a9105dsMRfWMu5VA7W4W6DJr9pmGZ7JiplIxUZ7990O149uC2Q3c0piKjY16bdl
         CdJ89vL7filn4FqEX9x6h1GuN6N1gH3+9GrJYzCo9hNI/tMpWwSVqVCU06IMVKTG+S/g
         z8SStqBT0k3mEpcnZnCH7EqO5PqSFsPLY1snDrx57oUlmkxM9WLJoMk1m2UoSe2UcvaI
         QTkB+h4AA3COM/D1sqB3Vgtmvnsq++mQL6Hyx2udzfK/doEVLNmnLQxz+dyauWx0a4xM
         sZTHfHToxzzSL2kaC1+ntUDgLpa6aIffSLHxc4AK9Td0mWm+klwQAnvHMs0EtGUph6SV
         HHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0pNvtKsUKFyaxM8hgq3BCNfldA7V9VskuLtJaTKsCMQ=;
        b=mK8vVk/cvWUFmIJC+PJ1y72JCrV4xY033iLtqz5Wj3IonmCpph7TTuGLOOHnA3tv6O
         9FKx6sUPxJ2ACj41fa15SAofvri7eLPK+31H0wPKKYI8+BOSvZK990s+Y+4mNoY14tNP
         rfuA+Vi/xozMBPeJ7J0GLYRl2rfijB3FQJnI1a+xwGHNPelljEwO/zuIeSex/Okzfxn9
         p+aNSqz2VEoEEPERKIw/MgIamL/gNjAu8m8BT3f30cQ7XyTYtvxoR2FqrP8YCWZeXysl
         3SjNnFe1P7YnFP8CcFgDAqwgRgRRgEGpcJdqB20kwiyDMyYjYYjxo8qHlIMjtDyWpcMQ
         FL/w==
X-Gm-Message-State: AO0yUKVxhl5PXazBdgURAPZzV9Iaey7boeUMPIIWnTycKpVRqyDBmfYt
	BddF+7mrd//am4OL8/J7GVIjFN7SHlk8NlFXtko5w/OT7V/VNmpp
X-Google-Smtp-Source: AK7set8M34zWjP+IqhSff0XWtZmFCgQuKGo8XtilqdgiD2IKw31OcgVSeg0/25WEAD38fMxwARs2iM73VmdKvdw4r9Q=
X-Received: by 2002:a4a:d2d9:0:b0:517:6158:dbcc with SMTP id
 j25-20020a4ad2d9000000b005176158dbccmr169556oos.22.1675299388063; Wed, 01 Feb
 2023 16:56:28 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 2 Feb 2023 09:55:51 +0900
Message-ID: <CAODzB9pLT-sejvsZD9VpYE+d5BfzMGFLs+RtyY-doR__tVQFDA@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Feb 2023 00:56:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10564

Hi !

It's this week's CVE report.

This week reported 4 new CVEs and 3 updated CVEs.

* New CVEs

CVE-2023-0469: A use-after-free flaw was found in io_uring/filetable.c

CVSS v3 score is not provided

A use-after-free flaw was found in io_uring/filetable.c in
io_install_fixed_file in the io_uring subcomponent in the Linux Kernel
during call cleanup. This flaw may lead to a denial of service.

This bug was introduced by commit 61c1b44 ("io_uring: fix deadlock on
iowq file slot alloc") in 5.19-rc1.
It fixes 1339f24 ("io_uring: allow allocated fixed files for
openat/openat2") in 510-rc1.
This bug was fixed by commit 9d94c04 ("io_uring/filetable: fix file
reference underflow") in 6.1-rc7.
The commit 1339f24 is not backported to older stable kernels.

Fixed status
mainline: [9d94c04c0db024922e886c9fd429659f22f48ea4]

CVE-2023-0240: Privilege escalation bug in io_uring

CVSS v3 score is not provided (NIST)
CVSS v3 score is 7.8 HIGH (CNA)

There is a logic error in io_uring's implementation which can be used
to trigger a use-after-free vulnerability leading to privilege
escalation. In the io_prep_async_work function the assumption that the
last io_grab_identity call cannot return false is not true, and in
this case the function will use the init_cred or the previous linked
requests identity to do operations instead of using the current
identity. This can lead to reference counting issues causing
use-after-free.

It looks only affects 5.10.

Fixed status
mainline: [4379bf8bd70b5de6bba7d53015b0c36c57a634ee]
stable/5.10: [788d0824269bef539fe31a785b1517882eafed93]

CVE-2023-0590: net: sched: fix race condition in qdisc_graft()

CVSS v3 score is not provided.

A use-after-free flaw was found in qdisc_graft in net/sched/sch_api.c
in the Linux Kernel due to a race problem leading to a
denial-of-service problem.

It was introduced by commit af356af ("net_sched: reintroduce
dev->qdisc for use by sch_api") in 2.6.32-rc1 and fixed in 6.1-rc2.

Fixed status
mainline: [ebda44da44f6f309d302522b049f43d6f829f7aa]
stable/5.10: [7aa3d623c11b9ab60f86b7833666e5d55bac4be9]
stable/5.15: [ce1234573d183db1ebcab524668ca2d85543bf80]

CVE-2023-0597: kernel: x86/mm: Randomize per-cpu entry area

CVSS v3 score is not provided.

A new Side-Channel Attacks was found in prefetch instructions. It an
unprivileged attacker to obtain address information.
This details is published in the paper called "Prefetch Side-Channel
Attacks: Bypassing SMAP and Kernel ASLR"
(https://gruss.cc/files/prefetch.pdf)

Fixed status
mainline: [97e3d26b5e5f371b3ee223d94dd123e6c442ba80]

* Updated CVEs

CVE-2023-23559: rndis_wlan: Prevent buffer overflow in rndis_query_oid

mainline, 5.10, 5.15, and 6.1 were fixed.

Fixed status
mainline: [b870e73a56c4cccbec33224233eaf295839f228c]
stable/5.10: [802fd7623e9ed19ee809b503e93fccc1e3f37bd6]
stable/5.15: [8cbf932c5c40b0c20597fa623c308d5bde0848b5]
stable/6.1: [7794efa358bca8b8a2a80070c6e088a74945f018]

CVE-2022-4129: l2tp: missing lock when clearing sk_user_data can lead
to NULL pointer dereference

stable 5.10 and 5.15 were fixed.

Fixed status
mainline: [b68777d54fac21fc833ec26ea1a2a84f975ab035,
af295e854a4e3813ffbdef26dbb6a4d6226c3ea1]
stable/5.10: [e34a965f771f1977f172593c73e373036c765724,
5b209b8c99d487a1c32983981bf3552980fda591]
stable/5.15: [87d9205d9a57dfc1f39f840b32e38475c3f523f6,
22c7d45ca3d7672f0b209783726d7559a2343f21]

CVE-2022-4382: usb: A use-after-free Write in put_dev

mainline, 5.10, 5.15, 5.4, and 6.1 were fixed.
This vulnerability was introduced by commit e5d82a7360d1 ("vfs:
Convert gadgetfs to use the new mount API") in 5.3-r1 so 4.x are not
affected.

Fixed status
mainline: [d18dcfe9860e842f394e37ba01ca9440ab2178f4]
stable/5.10: [856e4b5e53f21edbd15d275dde62228dd94fb2b4]
stable/5.15: [a2e075f40122d8daf587db126c562a67abd69cf9]
stable/5.4: [9a39f4626b361ee7aa10fd990401c37ec3b466ae]
stable/6.1: [616fd34d017000ecf9097368b13d8a266f4920b3]

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


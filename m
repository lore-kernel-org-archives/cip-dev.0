Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFCEC00140
	for <webhook@archiver.kernel.org>; Wed, 10 Aug 2022 23:20:45 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com
 [209.85.160.51])
 by mx.groups.io with SMTP id smtpd.web11.446.1660173637219963264
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Aug 2022 16:20:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=TrPFd0uw;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.51,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f51.google.com with SMTP id
 586e51a60fabf-10edfa2d57dso19746114fac.0
        for <cip-dev@lists.cip-project.org>;
 Wed, 10 Aug 2022 16:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=YQIdSMATG4GxjUq5jEhxf+5Wiz5DcchK+D4QT3bVQDw=;
        b=TrPFd0uwjk8Qd2wZtXtR7N3iDc5pcDl52FCQJLRJWoQkZ+3f1rG/LhLHy0zQBzwRVN
         0AU44oS7waqe8Kt2iGBgyyOWXxxoP/hiKN8ygixHChjQmzphIbVK9F8MSUDvuY1t5cjX
         TzT41l5yt+264zvA1vh+r3xTQ9EP9JGBkMiJw8agJQ+JCov1XlUO6iyvVUFmCpghp0v+
         xj7vB2kdaeWKNwDnVa1ACr6+Lg2FavzRNLl3z4zbr28wbRmucuOXPJl2kbjUGv4STGI5
         tc3Hl2XrSoaPysPFk6XkK7htkyD3DZI0rAS3G+bR8na5T+Ds2OvgCIs57x89ftoKUkOV
         riuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=YQIdSMATG4GxjUq5jEhxf+5Wiz5DcchK+D4QT3bVQDw=;
        b=JW4OVjA8Trr6vqxs7xVF5SGNEy3CWaU/ooGWKmfe48FhgeXvRQ3mJjYdOKG2RB+Y6s
         wBRMmBw+yaU8ZsJkOBWGwgeDjGxb2N6j9+ZnyQC1Meq5htb9etPUqu1Hsuf4H7ZnknHK
         91WTbvQuwSesg8Td6AQFUpcw0psKjsxabZIzQFFkSCA7XNGzyWvP4kRlC0TWVbx7uM8A
         EO8uRo6ah1Vhys7MoguhUkIalHUhS0opAHapLWWkwsjFXFkjg6HdElz9brp1UeJ5glum
         w1mRK1t+ldesPJVzU7LI4IQhMmNWHPSkLZBVwNhjkjBxZ3nZCygDQwsfV0Tt59Z0bnzv
         nfQQ==
X-Gm-Message-State: ACgBeo1bgi6Pme6d8dtbIBEm8Zro2ueLA7AnJtHxlE6SAyJYuX2Up+a0
	5pcJZRZzxIq1Xm0uYH/aI+pFnfJbizxxbhFA1WYBj8We/MJstQ==
X-Google-Smtp-Source: 
 AA6agR6AtcfF6hYog8smiL+A1dz4S3apR9mPzlWJNcBuyIqpyONOUaSyDuRtHl+Pt7aS3GGJVgLhGL0fF5nP8Un/rLw=
X-Received: by 2002:a05:6870:e313:b0:10e:757c:d388 with SMTP id
 z19-20020a056870e31300b0010e757cd388mr2399498oad.280.1660173635952; Wed, 10
 Aug 2022 16:20:35 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 11 Aug 2022 08:20:00 +0900
Message-ID: 
 <CAODzB9pz92KBbvgi24pK8iVHWxj-JcuNm42jkPFYmhjnxMj77g@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Aug 2022 23:20:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9153

Hi !

It's this week's CVE report.

This week reported 6 new CVEs and 0 updated CVEs.

* New CVEs

CVE-2022-2639: openvswitch: fix OOB access in reserve_sfa_size()

CVSS v3 score is not assigned.

An OOB write bug was found in reserve_sfa_size() in the openvswitch
subsystem. It will cause system crashes or potentially escalate their
privileges on the system.
This bug was fixed in the mainline, stable, and cip kernels.

Fixed status
cip/4.4-st: [25b37bbe34192188ae7f4b04a7bb857621b3a597]
mainline: [cefa91b2332d7009bc0be5d951d6cbbf349f90f8]
stable/4.14: [6cde4a87248e8d39fad5e5e72e104b6d74fcabef]
stable/4.19: [bbbf059337f9a74285c1cf088ff85ee92d149e64]
stable/4.9: [1aba176280dcd0eb08e291bc59ba6067df22af98]
stable/5.10: [0837ff17d052b7d755d5086208c3445867aaff82]
stable/5.15: [e411af98013dba5bce8118ee2b84bd1ad4c36b86]
stable/5.4: [aa70705560871725e963945a2d36ace7849c004e]

CVE-2022-2590: mm/gup: fix FOLL_FORCE COW security issue and remove FOLL_COW

CVSS v3 score is not assigned.

This is kind of Dirty COW like vulnerability in shmem/tmpfs so that it
allows unprivileged users to modify read only files.
This bug was introduced by commit 9ae0f87d009c ("mm/shmem:
unconditionally set pte dirty in mfill_atomic_install_pte") which was
merged in 5.16-rc1. If kernel contains commit 9ae0f87d009c and is
compiled with CONFIG_USERFAULTFD=y, the kernel will affect this
vulnerability.

Kernel 4.4, 4.9, 4.19, 5.4, 5.10, 1.15 did not contain commit
9ae0f87d009c so they are not affected.

Fixed status
Patch is available
(https://lore.kernel.org/linux-mm/20220808073232.8808-1-david@redhat.com/)
but hasn't been merged into the mainline yet.

CVE-2022-2585: Linux kernel POSIX CPU timer UAF

CVSS v3 score is not assigned.

A use-after-free bug was found in posix_cpu_timer when a non-leader
thread calls execve().
This vulnerability may allow an attacker to escalate privilege escalation.

Commit 55e8c8eb2c7b ("posix-cpu-timers: Store a reference to a pid not
a task") isn't backported to 4.4, 4.9, 4.14, 4.19, and 5.4 kernels so
they won't be affected.

Patch is available on
https://lore.kernel.org/lkml/20220809170751.164716-1-cascardo@canonical.com/T/#u
.

Fixed status
Patch is available but it hasn't been merged into the mainline yet.

CVE-2022-2586: Linux kernel nf_tables cross-table reference UAF

CVSS v3 score is not assigned.

A use-after-free vulnerability was found in nf_tables. This
vulnerability may allow an attacker to escalate privilege escalation.
However, to exploit this vulnerability, it requires CAP_NET_ADMIN in
user or netns.

This bug was introduced by commit 958bee14d071 ("netfilter: nf_tables:
use new transaction infrastructure to handle sets") which was merged
in 3.16-rc1. So, all stable kernels are affected by this
vulnerability.

Patch is available on
https://lore.kernel.org/netfilter-devel/20220809170148.164591-1-cascardo@canonical.com/T/#t
.

Fixed status
Patch is available but it hasn't been merged into the mainline yet.

CVE-2022-2588: Linux kernel cls_route UAF

CVSS v3 score is not assigned.

A use-after-free vulnerability was found in the net scheduler
subsystem. This vulnerability may allow an attacker to escalate
privilege escalation. This vulnerability was introduced before the git
era. Therefore all stable kernels are affected.

Exploiting this vulnerability, it requires CAP_NET_ADMIN in user or netns.

Patch is available on
https://lore.kernel.org/netdev/20220809170518.164662-1-cascardo@canonical.com/T/#u
.

Fixed status
Patch is available but it hasn't been merged into the mainline yet.

CVE-2022-26373: Post-Barrier Return Stack Buffer Predictions (PBRSB)

NIST: CVSS v3 score is not assigned.
Intel: CVSS Base Score: 5.5 Medium

This vulnerability affects Intel CPUs.
The Enhanced Indirect Branch Restricted Speculation (eIBRS) mitigation
for Specre V2 doesn't work for RET instruction after VM exits. This
causes information disclosure via local access.

Fixed status
mainline: [2b1299322016731d56807aa49254a5ea3080b6b3,
ba6e31af2be96c4d0536f2152ed6f7b6c11bca47]

* Updated CVEs

no updates.

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


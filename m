Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A79C433F5
	for <webhook@archiver.kernel.org>; Wed,  5 Jan 2022 23:32:27 +0000 (UTC)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 by mx.groups.io with SMTP id smtpd.web09.1470.1641425545173105636
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Jan 2022 15:32:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=Q4B7JUWN;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.54,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f54.google.com with SMTP id
 s21-20020a05683004d500b0058f585672efso1177616otd.3
        for <cip-dev@lists.cip-project.org>;
 Wed, 05 Jan 2022 15:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=siPupC99tFXAA1Y9q1GBXBDmmmsBdsGfF2oy3RNUkgs=;
        b=Q4B7JUWNEwviPJ/+9/LOCMrvQHMFmzUFv+28/3j5jhuKCtbPi3NOZZ3H6uk9x0d+Vp
         goWvGxmnzLTIgmZSQZ1GF7jeJE8T9187gwGESkf8iWbI6gWVulgE54elS+zF8Lp/eR7P
         k2sp3dhVsyI+W393w8gPuqqwspFKKESi1nBwZTt3jlm9/JN1nUYcl9a9zdaQ3TU82B3p
         Thr42SdBlTZoqFdIuPrq1WSXnTWSKuGhGXNcdgRHWHo1cITYv3mszx/vvGRSnbzLbBpT
         C2FwOzw1WWt/gmo7PE5hWPSW/7Pf3RrWh5d6Af8kL2B1mIk/vozPusJq8/a/HRUF92MG
         sV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=siPupC99tFXAA1Y9q1GBXBDmmmsBdsGfF2oy3RNUkgs=;
        b=i/XAHvdHU1fCcUunE2C9VR3+yJMAAYeLHt3X80OdTuh9qiv3I0Ggvrw8UGPA34J8HX
         P+J/90LqDOBr7An9ISWdFsWEx8XJ/aEdixlc0UQtGX3P73F71tavbPP+Whmd2fts1/zu
         wglB57ngwq35gXYh7cDjEsyAiiL4EmqUgzdJJ88x/W5DvJksnZSUfMTdF+LsemmJxOFY
         XyOtffLOgn4qUX8w6H2QwFuxcy8Itf8HBWmJG7kqLgiotUDlYwiBSt3WROLeRmJAqnNh
         lxwrpXoAp3D41Ib7mcBTkSOZfMj5HmuWPwtG5YXn2mgpGhV1aQEVhRdXxE98wNv2bdAU
         uDmA==
X-Gm-Message-State: AOAM533/PpI1GRIkMox0Bi8XXa9ORBqkKl0D5TV8RJiBHk0TUffFaciG
	Rysk/hxfdTrg7feCa6ijEE9BiH7N2Ca/HkGDa7n/viqpMtqv0g==
X-Google-Smtp-Source: 
 ABdhPJzW5gkYoVqA0kp6zrgmTg1vZ6WFg/qngEczQ1VeH7ZcC0z2m2cFfJZARdMqL91DRWQbnmxyruE+OjNJp2dspHY=
X-Received: by 2002:a05:6830:1285:: with SMTP id
 z5mr42314158otp.180.1641425544096;
 Wed, 05 Jan 2022 15:32:24 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 6 Jan 2022 08:31:48 +0900
Message-ID: 
 <CAODzB9riQtRjSjO+_8MD10TTiZGYG8eKU1Kx+uN4NWzXYTQZEQ@mail.gmail.com>
Subject: New CVE entries this week.
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Jan 2022 23:32:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7323

Hi !

It's this week's CVE report.

This week reported 1 new CVE.

* New CVEs

CVE-2021-4197: cgroup: Use open-time creds and namespace for migration
perm checks

CVSS v3 score is not provided

A local attacker could escalate privileges for the containers or other
processes that uses cgroups
Patch series is available
(https://lore.kernel.org/lkml/20211209214707.805617-1-tj@kernel.org/T/)
but it hasn't been merged into the mainline yet.

Fixed status

Not fixed yet.

* Updated CVEs

CVE-2021-44733: tee: handle lookup of shm with reference count 0

This CVE was introduced by commit 967c9cc ("tee: generic TEE
subsystem") at 4.12-rc1. so 4.4 isn't affected this issue.

Fixed status

mainline: [dfd0743f1d9ea76931510ed150334d571fbab49d]
stable/4.14: [3d556a28bbfe34a80b014db49908b0f1bcb1ae80]
stable/4.19: [b4a661b4212b8fac8853ec3b68e4a909dccc88a1]
stable/5.10: [c05d8f66ec3470e5212c4d08c46d6cb5738d600d]
stable/5.15: [492eb7afe858d60408b2da09adc78540c4d16543]
stable/5.4: [940e68e57ab69248fabba5889e615305789db8a7]

CVE-2021-45100: ksmbd: disable SMB2_GLOBAL_CAP_ENCRYPTION for SMB 3.1.1

This CVE was introduced by commit e2f3448 ("cifsd: add server-side
procedures for SMB3") which was merged at 5.15-rc1. so before 5.15
kernels are not affected.

Fixed status

mainline: [83912d6d55be10d65b5268d1871168b9ebe1ec4b]
stable/5.15: [a2c144d17623984fdafa4634ecf4ab64580d29bb]

CVE-2021-45469: f2fs: fix to do sanity check on last xattr entry in
__f2fs_setxattr()

The mainline hasn't been fixed yet.

Fixed status

stable/4.14: [88dedecc24763c2e0bc1e8eeb35f9f2cd785a7e5]
stable/4.19: [f9dfa44be0fb5e8426183a70f69a246cf5827f49]
stable/5.10: [fffb6581a23add416239dfcf7e7f3980c6b913da]
stable/5.15: [a8a9d753edd7f71e6a2edaa580d8182530b68791]
stable/5.4: [b0406b5ef4e2c4fb21d9e7d5c36a0453b4279e9b]

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


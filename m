Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2FAC433EF
	for <webhook@archiver.kernel.org>; Thu, 21 Jul 2022 00:02:31 +0000 (UTC)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com
 [209.85.160.42])
 by mx.groups.io with SMTP id smtpd.web10.225.1658361743170235232
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Jul 2022 17:02:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=pqS0eBIu;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.42,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-10cf9f5b500so335851fac.2
        for <cip-dev@lists.cip-project.org>;
 Wed, 20 Jul 2022 17:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=qRnLJv9k9HdKBj3Jj4KZ9h0HlLIqbqVdIAGvsXXu3Hg=;
        b=pqS0eBIuh9OVHY98YeoOsNs5WmANmup8W65+DkKSNhRb1hWLIxrRlc3bap2oTD3jhR
         PgXxHq8E+nkA3AS+hPBjvX+YpEWq2fNBwB/o14r8Nxf8vTEXk+qWz5GE7qUndm+68DMo
         QqYKkHZu+FEnClMnkZ/U+wwAIwIi+yMh+xYuimkqn0MWYfYmWoVK0EGW6of8rUj2dMxJ
         1RIEl3Zm0Kf/nDezTvwB7wCFSHh2W55LUEYWjPO5rSO0eavcp3b9w8ZVSYDBtBJTSa1X
         mnd29VrwhgoOpUJNXp1MhWb9NwDY9MH2rzyArLvDQcmpHEuWOTSPt7g7v98SAsFguWlx
         0rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qRnLJv9k9HdKBj3Jj4KZ9h0HlLIqbqVdIAGvsXXu3Hg=;
        b=l9DmponmffoBvv6ZXm6L3qyvMr5wEiEywypVKIJx95xRV8thgkmqeE4D6kliFDgIzi
         CNHp6B5OkkB3d7CzHFYV3mEPji9zDiVWgXKvzlnW31KAfyK/NPrX1JlcSRdDWBwp8mWS
         BEnpCQCdO9wvFz+0lwpRIovsGUGXYK86of+vJAM41p1C1LOJzZrmOXbiSUeRNnuUTPnz
         90rP4xf5BW5ll3PcsAY0ZZ1ZL/P3OJPmBrIA8mCiXv+wYmWP+RzmS/aGCbenpanR25jw
         UVTTeEBgZ8FrRMKJ2T7l82G6dIL3KpwAi31NULncM53B84HYdlhUxnG/oV2wG4yw9Fg9
         37HA==
X-Gm-Message-State: AJIora+rguGylq3YufURx1er/GrDZgz8x/ZzEyToQhvf48zd/lTXRlI6
	UW8u9D0WFP//1S9bU6dza7BnqevKH/PQO7BJ1c4nuTlBl90zOg==
X-Google-Smtp-Source: 
 AGRyM1t0iWEYbZlUJPRCqug5DW2tSISqy5GGYw6QrV5XcJS5lyXrA7D4MDmy4OBQnSPofKVI1LH6DUVLF88vGERI1DA=
X-Received: by 2002:a05:6870:c889:b0:10c:7f1:c6b8 with SMTP id
 er9-20020a056870c88900b0010c07f1c6b8mr3840777oab.280.1658361742140; Wed, 20
 Jul 2022 17:02:22 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 21 Jul 2022 09:01:46 +0900
Message-ID: 
 <CAODzB9o-mDE3YR3qt5JdqemPxbUR167KW5a7J3_zKLb1Q6VVSQ@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Jul 2022 00:02:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8863

Hi !

It's this week's CVE report.

This week reported 3 CVEs and no updated CVEs.

* New CVEs

CVE-2021-33655: When sending malicous data to kernel by ioctl cmd
FBIOPUT_VSCREENINFO,kernel will write memory out of bounds.

CVSS v3 score is not assigned.

This vulnerability allows buffer overwrite when a user passes an
invalid font size.
There are three patches in the mainline. Each commit contains an
affected version.

e64242c ("fbcon: Prevent that screen size is smaller than font size"): 5.4+
65a01e6 ("fbcon: Disallow setting font bigger than screen size"): 4.14+
6c11df5 ("fbmem: Check virtual screen sizes in fb_set_var()"): 5.4+

Fixed status
mainline: [e64242caef18b4a5840b0e7a9bff37abd4f4f933,
65a01e601dbba8b7a51a2677811f70f783766682,
  6c11df58fd1ac0aefcb3b227f72769272b939e56]
stable/5.10: [cecb806c766c78e1be62b6b7b1483ef59bbaeabe]
stable/5.15: [9c9e44bb3dd5233232f2379c2dde0e403b1fd642]
stable/5.18: [365b729e36ca942f4d2d184afc8486017504a597]
stable/5.4: [af93e821973426ded00158ea66a977039483997e]

CVE-2021-33656: When setting font with malicous data by ioctl cmd
PIO_FONT,kernel will write memory out of bounds.

CVSS v3 score is not assigned.

This vulnerability requires a user to have permission to access a
console device(e.g. /dev/tth1).

Fixed status
mainline: [ff2047fb755d4415ec3c70ac799889371151796d]
stable/4.14: [259742e9ad3551d5be58cd4754e65e0aabc1f9c8]
stable/4.19: [b15d5731b708a2190fec836990b8aefbbf36b07a]
stable/4.9: [dc1421db273b725ebe90978a4b2d9bfba5cef702]
stable/5.10: [3acb7dc242ca25eb258493b513ef2f4b0f2a9ad1]
stable/5.4: [c87e851b23e5cb2ba90a3049ef38340ed7d5746f]

CVE-2022-21505: Kernel lockdown bypass bug

CVSS v3 score is not assigned.

When UEFI Secure Boot is disable and linux boots with
"ima_appraise=log" parameter, user is able to do kexec even if the
lockdown feature is enabled.
A reporter attached a
patch(https://www.openwall.com/lists/oss-security/2022/07/19/4) but it
hasn't been merged yet.
This vulnerability was introduced by commit 29d3c1c ("kexec: Allow
kexec_file() with appropriate IMA policy when locked down") which was
merged in 5.4. Less than 5.4 kernels aren't affected by this issue.

Fixed status
Patch is available but not merged yet

* Updated CVEs

No updated CVEs this week.

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


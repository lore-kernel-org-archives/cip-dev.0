Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6C1CA0EE0
	for <webhook@archiver.kernel.org>; Thu, 14 Aug 2025 00:42:48 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
 by mx.groups.io with SMTP id smtpd.web11.11955.1755132162045759367
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Aug 2025 17:42:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=wQkNlMta;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.170, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d6014810fso4631527b3.0
        for <cip-dev@lists.cip-project.org>; Wed, 13 Aug 2025 17:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1755132161; x=1755736961; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vLCva0ZPwg/22Ysm8ls64A/cYhGt48NoSRhdZ7T65mQ=;
        b=wQkNlMtaRLrdtbxIuLu6K23FHIUZGAaZI8pprn1thRUw8fPrhGwWlXpoojcnxrDT91
         DsV4+J0xlqBWlXItO+A06mN5tca9oeAwpEUtCOUb7r+bcOQCdrw23A45kixiGYMU6auj
         aUgsrJvnCGKfs+HlkZIo3TiTRe9XruoWi/ETsnLAEzmUWbSgNUwPyEIiXYPCb8yfWJoJ
         P7o04h4agkDzm/iQOjRkFzuj2KK/EUOgHKIvVCyk1P0LN3LhuJqv7stAVt+SYSXtUcYx
         N8hZW63MBu56pRvpHQCfPx+iVZcTREnZUyS+/Ms08JYamzcwBEfUSAsjvP+sOJqZXTM1
         Jr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755132161; x=1755736961;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vLCva0ZPwg/22Ysm8ls64A/cYhGt48NoSRhdZ7T65mQ=;
        b=NNET/VpOAH+ZWpWacZKOhRP3epgDH+NYeki41oAPQ1QUV0mTpGItbdcdncG6OvHWyl
         gIaKdxS+C8wrsTKYiUkhRtwn1KLdho6s6uV2tJLgKxt2VP2nAhB1TyDf7gPALkocNcja
         PWHbRsia47VLfp8LiVHOu+NDXcgFxnP0PZvcFhSJeEGvd1V1xtNkZ8ob+3i/pgzAI/12
         l8DWExLI6HYUEPz90xIeRfuApeEqJ0RY2gqdCeYGpOcN8LfMGEirF/rmn/6u1soI3LfM
         6PrI2s8X+WWyjZWngVClcfRjlAJqcrNN8GTFbNyYyArRXh4bWMK1G9ESp5bOm6HCcez1
         +kfw==
X-Gm-Message-State: AOJu0YxlyYnHu5xWHSlWvI33Cv3aK3z1K8VQRqCNOWdpSGWcrMl7LpqC
	1CwRgz+rsHzh9hACBUbLRh/3RAvNfOI1ZrTwiXRHi53qbDxAoBhmIc4n508ylM/v0/4Hk4BrAoV
	l+/hRiBOStPIslx5jVQF0ksrBTUtVWGeBwBs32ctdl75z35mkxCvdEgQ=
X-Gm-Gg: ASbGncu1nOvGcUuYU58oIe/u30dT+/KpE6MZZXreMsw3nT3NwKo+2AChbdzdS1mcegR
	WXIFz5NgZtSS4kOJb9zku5Lk0ER4elP06dmtJMfs4iSfITFCkJ95fzh1jDVs3EHYjeuTrO95VYl
	WnJITmgvH2hjocYa1SmuczFnreKhQ/TYaZtt3s+o1b6t1jMUgzrAt4xd4j0VWPrxF9DgxwgeULD
	DvBrTgCoOBVm+/rZDO77Llp
X-Google-Smtp-Source: AGHT+IGfqQs1aLb3mFtVbUlcAhmrQvnpzSlN732P6uUd95lMMncfXxcGqYi+K+QbfnMe8hqPt4SrlrOvHyka8sTd7c4=
X-Received: by 2002:a05:690c:45c5:b0:71a:8c1:fae with SMTP id
 00721157ae682-71d633e889cmr12666007b3.9.1755132160781; Wed, 13 Aug 2025
 17:42:40 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 14 Aug 2025 09:42:04 +0900
X-Gm-Features: Ac12FXzI5cVX0FV4YOZQN_TgHWTxGSKP6jJCpLOkNKprNCFzLBHjZVPuUdc6qOo
Message-ID: <CAODzB9oZF16HaEA6onfbgZiUr=jKDJzuhQuAZz2wsxD3kqReLQ@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Aug 2025 00:42:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19735

Hi!

It's this week's CVE report.

This week reported 5 new CVEs and 0 updated CVEs.

* New CVEs
CVE-2022-50233: Bluetooth: eir: Fix using strlen with
hdev->{dev_name,short_name}

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50233

Introduced commit is not determined.Fixed in v6.0-rc1.


Fixed status
mainline: [dd7b8cdde098cf9f7c8de409b5b7bbb98f97be80]

CVE-2024-58238: Bluetooth: btnxpuart: Resolve TX timeout error in
power save stress test

Announce: https://www.cve.org/CVERecord?id=CVE-2024-58238

Introduced commit is not determined.Fixed in v6.9-rc1.
The BT_NXPUART was added by 689ca16 ("Bluetooth: NXP: Add protocol support
for NXP Bluetooth chipsets") in 6.4-rc1.

Fixed status
mainline: [e4db90e4eb8d5487098712ffb1048f3fa6d25e98]
stable/6.6: [9d5df94ce0e213d5b549633f528f96114c736190]

CVE-2025-38499: clone_private_mnt(): make sure that caller has
CAP_SYS_ADMIN in the right userns

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38499


Introduced by commit 427215d ("ovl: prevent private clone if bind
mount is not allowed")
in 5.14-rc6. Fixed in 6.16-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [c28f922c9dcee0e4876a2c095939d77fe7e15116]
stable/6.1: [d717325b5ecf2a40daca85c61923e17f32306179]
stable/6.12: [e77078e52fbf018ab986efb3c79065ab35025607]
stable/6.6: [dc6a664089f10eab0fb36b6e4f705022210191d2]

CVE-2025-38500: xfrm: interface: fix use-after-free after changing
collect_md xfrm interface

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38500

Introduced by commit abc340b ("xfrm: interface: support collect
metadata mode") in v6.1-rc1.
Fixed in v6.16.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a90b2a1aaacbcf0f91d7e4868ad6c51c5dee814b]
stable/6.12: [5918c3f4800a3aef2173865e5903370f21e24f47]
stable/6.6: [bfebdb85496e1da21d3cf05de099210915c3e706]

CVE-2024-36331: x86/sev: Evict cache lines during SNP memory validation

Announce: https://www.cve.org/CVERecord?id=CVE-2024-36331


Fixed by 7b306df ("x86/sev: Evict cache lines during SNP memory validation") in
mainline.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b306dfa326f70114312b320d083b21fa9481e1e]

* Updated CVEs

no updated cves.

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com


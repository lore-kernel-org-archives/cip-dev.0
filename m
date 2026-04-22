Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9246EF9EDF9
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 22:32:15 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.415.1776897128783835370
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Apr 2026 15:32:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=EMlilQ7D;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.181, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7986e538decso61207577b3.1
        for <cip-dev@lists.cip-project.org>; Wed, 22 Apr 2026 15:32:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776897128; cv=none;
        d=google.com; s=arc-20240605;
        b=gFzcVgmmfY14pEewPRnOVKeewpFHIggCu+GijvJ0QUmuRGOqVI6POEkLc3IRkH6Tdk
         IugFNrIpdWUFBaUuqQvqBNjCRdXQsQ1aYHljdHoA/ovYGgGcu03J49e54BK5XmJXtJel
         YfvEI9ZhQ/NbZ9tPq1SjP85UEPp88mfEjm9bQZ5JCQ5Xi//njA6h2XY7I9WLnuugQuNC
         Y725gFaAOP2xLbDkLCznQxXNkIEP9NbWjSSMQYShYlt00ypOCy//1MoIbqHR3Llh5Jkc
         hHFCPxtprULZxvpZkoguznl7pcPTVZ2s4D5XIdo233oVqqpfJHW1oB/Q8lMvfuuE8rBM
         eHmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=n7pc96T8efgG6HMc8urUnJu35tMC1mnR0iyomDszIJc=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=DlNcKq9qEsiD6oiEgY8N6GVrY6+7xFteAJihtJ9nJc7bdQgvsH/hauMnlj1WF02zKf
         /S9tdCZr6o3rG7C1Vl/sQHMWNzcJKtou/Z+6xMMSS7abWcNCt3FZthAuiN+CmsSnDR/Q
         hjy7tZsPEvQFn9FYMSM7W7/gqRAYd6ridwC7jdaIMsr1cqMVIqMQc3ahXogXJzeNk1Mz
         AytzMV1+P0IyM0L0/Zp6q9lxrK5XG5DDvf7yFVdAiexpNIQB2/Zf88d7sFG9OqIq8g0H
         l7pB8fBcKOzKNE81uWQfBjUhXjlWSioRXkVVEfCsG1PF6Dcad23JI3HSkRhcBR0EywuL
         Y19A==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1776897128; x=1777501928; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n7pc96T8efgG6HMc8urUnJu35tMC1mnR0iyomDszIJc=;
        b=EMlilQ7DugRrNpr6CGwn6FVL+9ILvBp+v/Udk+IIcfgb4JTNz/Z66Z2GQUbkETnSwS
         Su2XyfxMS+5BdtAKkunghkMLVelWvkYJjzR5L6IaYoyxOmWuOo/U2q5GxHaxWKqQ+YXu
         vVq6PTZUaTmSOiPWXu56xKrxGSXjgsic6uQEa8dHOVIRwZ6dMMohJORT3lGHI5sbV279
         VUO5a/xo9WCSkx25vJMdZViB+sKuuNR+pkQ5L8KugvZ22BF+izAC4QLsfy+WvTfej1Cb
         RQw/opAdCD8t/E2q3S3l6Yt6OLg22I0uChjbU4KZrstSDAEMr742Y5fjW8M1v04pOZC9
         V6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776897128; x=1777501928;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n7pc96T8efgG6HMc8urUnJu35tMC1mnR0iyomDszIJc=;
        b=VbokxrZBYCccZcgnT9T7T63w+7gqf8uc4b878Eb/6BQ5/TL/6thycpde3yW6B7oF74
         3xs99Os4/zpjsKjnbFtS+zxYWs7x+kQZjOBGihe+r9Lap1jRWcIrk6/9gEv5WbOJnO/T
         fU3WoBOjf6dQrxe2SoZd2Kw0RwyLAZ0kp6vQ5oyfnifqYq84AVss+348IuSLNyyn3BB4
         aH0tY18VDAyt9ZYTue4OAvh+dA/Hjw/LWO7Nb7qdByk/OcbQWi+uGjmyzB5ztnDtj0H/
         rb85n0ZY9LYY2iI8vhlTrivxysX/cR2v6eiiL5qRSyQRy01GDxHC/p8Unw96Gusvx1gv
         DhyA==
X-Gm-Message-State: AOJu0YzJXnGpslUVBgQCjZNlJTvDJIN1sj5goZ9eIR3AwfRDUv6jyk4+
	N7GDV6Exq40XqZuBn5VtNgrk2dREMWfKGbG7trS3HxsCSXMV/WyF2S91xLqi4zNX8Jqye+J4lcs
	YxfYTpGhhfUt+hdiRVydTri40UQV19hPV8E0z/VF/Wbx2zLNUwQ+d9t8kUA==
X-Gm-Gg: AeBDietECrVZ+4niDwUzmDGHUQinJh+kqSySHcdFP1GD7QpTQiIMGkFf7jeBpbadAhI
	9DouOH40YwlAwI3xdAQtVmsyPhkgB9z64rxg2557E2m9V91HlQN/uLjVJyAI5FL2bNZSMNBrYVF
	U668ZZWBh8RxX8Ej+2uF2O3wmSsZZUp6m7lYGtZjym2lYkx+gSXmmVBYv+ggQXOmKJGKzcsZXEX
	KNpAeglgVwgNwWFvylA8ylHvcgXqqu+eNAvkJJzoLg4q97N+HkfQdcvEqSt8dv/eNYrjq4c6usG
	KXcF3SLEvTdt+TmCbRzaA1eelx2qDw==
X-Received: by 2002:a05:690c:d85:b0:7b2:9ad9:cd2e with SMTP id
 00721157ae682-7b9ecece6edmr269704867b3.14.1776897125313; Wed, 22 Apr 2026
 15:32:05 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 23 Apr 2026 07:31:28 +0900
X-Gm-Features: AQROBzDD8AGj6UlQR-c0wHXhICa9SW5g9tWa1gbEBAYxaUFI9-Fwjb_2aWZuKWc
Message-ID: <CAODzB9oZsKXv8O7+gG4rZc5j54eXrxVYadwoi+ue0sPNEtgBEQ@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Apr 2026 22:32:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22788

Hi!

It's this week's CVE report.

This week reported 102 new CVEs and 132 updated CVEs.

* New CVEs
CVE-2026-31429: net: skb: fix cross-cache free of KFENCE-allocated skb head

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31429

Introduced by commit bf9f1ba ("net: add dedicated kmem_cache for
typical/small skb->head") in v6.3-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0f42e3f4fe2a58394e37241d02d9ca6ab7b7d516]
stable/6.12: [60313768a8edc7094435975587c00c2d7b834083]
stable/6.18: [2d64618ea846d8d033477311f805ca487d6a6696]
stable/6.19: [474e00b935db250cac320d10c1d3cf4e44b46721]

CVE-2026-31430: X.509: Fix out-of-bounds access when parsing extensions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31430

Introduced by commit 30eae2b ("KEYS: X.509: Parse Basic Constraints
for CA") in v6.4-rc1.
Introduced by commit 5676712 ("KEYS: X.509: Parse Key Usage") in v6.4-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d702c3408213bb12bd570bb97204d8340d141c51]
stable/6.12: [30ab358fad0c7daa1d282ec48089901b21b36a20]
stable/6.18: [206121294b9cf27f0589857f80d64f87e496ffb2]
stable/6.19: [7fb4dadc2734f4020d7543d688b8d49c8e569c61]
stable/6.6: [672b526def1f94c1be8eb11b885b803da0d8c2f1]

CVE-2026-31431: crypto: algif_aead - Revert to operating out-of-place

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31431

Introduced by commit 72548b0 ("crypto: algif_aead - copy AAD from src
to dst") in v4.14-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a664bf3d603dc3bdcf9ae47cc21e0daec706d7a5]
stable/6.18: [fafe0fa2995a0f7073c1c358d7d3145bcc9aedd8]
stable/6.19: [ce42ee423e58dffa5ec03524054c9d8bfd4f6237]

CVE-2026-31432: ksmbd: fix OOB write in QUERY_INFO for compound requests

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31432

Introduced by commit e2b76ab ("ksmbd: add support for read compound")
in v6.6-rc1.
Fixed in v7.0-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [fda9522ed6afaec45cabc198d8492270c394c7bc]
stable/6.12: [d48c64fb80ad78b3dd29fb7d79b6ec7bd72bfc09]
stable/6.18: [075ea208c648cc2bcd616295b711d3637c61de45]
stable/6.19: [515c2daab46021221bdf406bef19bc90a44ec617]

CVE-2026-31433: ksmbd: fix potencial OOB in get_file_all_info() for
compound requests

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31433

Introduced by commit e2b76ab ("ksmbd: add support for read compound")
in v6.6-rc1.
Fixed in v7.0-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [beef2634f81f1c086208191f7228bce1d366493d]
stable/5.15: [3a852f9d1c981fb14f6bf4e24999e0ea8088a7d7]
stable/6.1: [4cca3eff2099b18672934a39cee70aed835d652c]
stable/6.12: [7aec5a769d2356cbf344d85bcfd36de592ac96a5]
stable/6.18: [b0cd9725fe2bcc9f37d096b132318a9060373f5d]
stable/6.19: [9d7032851d6f5adbe2739601ca456c0ad3b422f0]
stable/6.6: [358cdaa1f7fbf2712cb4c5f6b59cb9a5c673c5fe]

CVE-2026-31434: btrfs: fix leak of kobject name for sub-group space_info

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31434

Introduced by commit f92ee31 ("btrfs: introduce btrfs_space_info
sub-group") in v6.16-rc1.
Fixed in v7.0-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [a4376d9a5d4c9610e69def3fc0b32c86a7ab7a41]
stable/6.1: [416484f21a9d1280cf6daa7ebc10c79b59c46e48]
stable/6.12: [1737ddeafbb1304f41ec2eede4f7366082e7c96a]
stable/6.18: [3c844d01f9874a43004c82970d8da94f9aba8949]
stable/6.19: [3c645c6f7e5470debbb81666b230056de48f36dc]
stable/6.6: [94054ffd311a1f76b7093ba8ebf50bdb0d28337c]

CVE-2026-31435: netfs: Fix read abandonment during retry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31435

Introduced by commit ee4cdf7 ("netfs: Speed up buffered reading") in v6.12-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e57523490cd2efb52b1ea97f2e0a74c0fb634cd]
stable/6.18: [3e5fd8f53b575ff2188f82071da19c977ca56c41]
stable/6.19: [8f2f2bd128a8d9edbc1e785760da54ada3df69b7]

CVE-2026-31436: dmaengine: idxd: fix possible wrong descriptor
completion in llist_abort_desc()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31436

Introduced by commit aa8d18b ("dmaengine: idxd: add callback support
for iaa crypto") in v6.8-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e1c9866173c5f8521f2d0768547a01508cb9ff27]
stable/6.12: [e21da2ad8844585040fe4b82be1ad2fe99d40074]
stable/6.18: [82656e8daf8de00935ae91b91bed43f4d6e0d644]
stable/6.19: [0e4f43779d550e559be13a5cdb763bad92c4cc99]

CVE-2026-31437: netfs: Fix NULL pointer dereference in
netfs_unbuffered_write() on retry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31437

Introduced by commit a0b4c7a ("netfs: Fix unbuffered/DIO writes to
dispatch subrequests in strict sequence") in v7.0-rc3.
Fixed in v7.0-rc6.

Bug introduced commit was backported to following branches.
stable/6.18 stable/6.19

Fixed status
mainline: [e9075e420a1eb3b52c60f3b95893a55e77419ce8]
stable/6.18: [a4d1b4ba9754bac3efebd06f583a44a7af52c0ab]
stable/6.19: [7a5482f5ce891decbf36f2e6fab1e9fc4a76a684]

CVE-2026-31438: netfs: Fix kernel BUG in netfs_limit_iter() for
ITER_KVEC iterators

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31438

Introduced by commit cae932d ("netfs: Add func to calculate
pagecount/size-limited span of an iterator") in v6.8-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [67e467a11f62ff64ad219dc6aa5459e132c79d14]
stable/6.12: [18c2e20b42dd21db599e42d05ddaeeb647b2bb6d]
stable/6.18: [4bc2d72c7695cedf6d4e1a558924903c2b28a78e]
stable/6.19: [00d6df7115f6972370974212de9088087820802e]

CVE-2026-31439: dmaengine: xilinx: xdma: Fix regmap init error handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31439

Introduced by commit 17ce252 ("dmaengine: xilinx: xdma: Add xilinx
xdma driver") in v6.3-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0adbf74e2a0455a6bc9628726ba87bcd0b42bf8]
stable/6.12: [9787b3d9b908785b40bc3f2e6d7082fdb8fdd98a]
stable/6.18: [f27197ccfd2ecd2c71f27fd57c6d507e892ad24d]
stable/6.19: [59f6ccd0f3345be2e8a78bdef2103e93f180633a]
stable/6.6: [4b6e1da50b22e5528b9003f376a3cecccce4decc]

CVE-2026-31440: dmaengine: idxd: Fix leaking event log memory

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31440

Introduced by commit 244da66 ("dmaengine: idxd: setup event log
configuration") in v6.4-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee66bc29578391c9b48523dc9119af67bd5c7c0f]
stable/6.12: [d94f9b0ba28a205caf95902ee88b42bdb8af83d0]
stable/6.18: [facd0012708e942fc12890708738aebde497564e]
stable/6.19: [9dfa00967e6ef43a9dd0887fe5c3a721a39da92e]

CVE-2026-31441: dmaengine: idxd: Fix memory leak when a wq is reset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31441

Introduced by commit da32b28 ("dmaengine: idxd: cleanup workqueue
config after disabling") in v5.8-rc6.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d9cfb5193a047a92a4d3c0e91ea4cc87c8f7c478]
stable/6.1: [a16098a2f0c11ee5e04e23aa7478ca1fcfb0f658]
stable/6.12: [39c1504e0e76bcfb93991fd94288a83e05d13b51]
stable/6.18: [a9e7815d38629bcf59d3005001f1f315424a58de]
stable/6.19: [0c3d3ac57e3c52b570b8c695903306bff07e04c8]
stable/6.6: [54d77cc0c40ca2f894859dc7b3c52997574f1a2a]

CVE-2026-31442: dmaengine: idxd: Fix possible invalid memory access after FLR

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31442

Introduced by commit 98d187a ("dmaengine: idxd: Enable Function Level
Reset (FLR) for halt") in v6.14-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d6077df7b75d26e4edf98983836c05d00ebabd8d]
stable/6.18: [504c0e6751001ac46917c73e703f2b1b92cfc026]
stable/6.19: [867d0c801f21370d561420fa32f2ea1a7dc3a22d]

CVE-2026-31443: dmaengine: idxd: Fix crash when the event log is disabled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31443

Introduced by commit 6078a31 ("dmaengine: idxd: Add
idxd_device_config_save() and idxd_device_config_restore() helpers")
in v6.14-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [52d2edea0d63c935e82631e4b9e4a94eccf97b5b]
stable/6.18: [aa0ffc6d3990ec35976308a068dc23178037e564]
stable/6.19: [0e761079d653c25f838380cf7cef2730832110cc]

CVE-2026-31444: ksmbd: fix use-after-free and NULL deref in smb_grant_oplock()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31444

Introduced by commit 1dfd062 ("ksmbd: fix use-after-free by using
call_rcu() for oplock_info") in v7.0-rc4.
Fixed in v7.0-rc6.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.19 stable/6.6

Fixed status
mainline: [48623ec358c1c600fa1e38368746f933e0f1a617]
stable/6.12: [7de55bba69cbf0f9280daaea385daf08bc076121]
stable/6.18: [a5c6f6d6ceefed2d5210ee420fb75f8362461f46]
stable/6.19: [6d7e5a918c1d0aad06db0e17677b66fc9a471021]
stable/6.6: [9e785f004cbc56390479b77375726ea9b0d1a8a6]

CVE-2026-31445: mm/damon/core: avoid use of half-online-committed context

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31445

Introduced by commit 3301f18 ("mm/damon/sysfs: handle commit command
using damon_call()") in v6.15-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26f775a054c3cda86ad465a64141894a90a9e145]
stable/6.18: [9c495f9d3781cd692bd199531cabd4627155e8cd]
stable/6.19: [1b247cd0654a3a306996fa80741d79296c683a56]

CVE-2026-31446: ext4: fix use-after-free in update_super_work when
racing with umount

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31446

Introduced by commit b98535d ("ext4: fix bug_on in start_this_handle
during umount filesystem") in v5.18-rc4.
Fixed in v7.0-rc6.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [d15e4b0a418537aafa56b2cb80d44add83e83697]
stable/5.15: [c8fe17a1b308c3d8c703ebfb049b325f844342c3]
stable/6.1: [c4d829737329f2290dd41e290b7d75effdb2a7ff]
stable/6.12: [034053378dd81837fd6c7a43b37ee2e58d4f0b4e]
stable/6.18: [c97e282f7bfd0c3554c63d289964a5ca6a1d2ffe]
stable/6.19: [08b10e6f37fc533a759e9833af0692242e8b3f93]
stable/6.6: [9449f99ba04f5dd1c8423ad8a90b3651d7240d1d]

CVE-2026-31447: ext4: reject mount if bigalloc with s_first_data_block != 0

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31447

Introduced commit is not determined.Fixed in v7.0-rc6.


Fixed status
mainline: [3822743dc20386d9897e999dbb990befa3a5b3f8]
stable/5.10: [5ad6d994255e27a3254079dfb50ca861fc31f2d0]
stable/5.15: [3a926957cc95899ef88529710836edadc03c71a1]
stable/6.1: [7b58c110b4e1f028eb38eec9ed3555e9be81c8b0]
stable/6.12: [d787d3ae96648dc14a3b7ca8fde817177e82c1c7]
stable/6.18: [ad1f6d608f33f59d21a3d025615d6786a6443998]
stable/6.19: [7d5b04290156c3fc316eecc86a4f9d201ab7d44a]
stable/6.6: [b77de3fceafbb39f30e4ff5dc986f863d5456417]

CVE-2026-31448: ext4: avoid infinite loops caused by residual data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31448

Introduced commit is not determined.Fixed in v7.0-rc6.


Fixed status
mainline: [5422fe71d26d42af6c454ca9527faaad4e677d6c]
stable/6.1: [c66545e83a802c3851d9be27a41c0479dd29ff0c]
stable/6.12: [3a7667595bcad84da53fc156a418e110267c3412]
stable/6.18: [416c86f30f91b4fb2642ef6b102596ca898f41a5]
stable/6.19: [64f425b06b3bea9abc8977fd3982779b3ad070c9]
stable/6.6: [ecc50bfca9b5c2ee6aeef998181689b80477367b]

CVE-2026-31449: ext4: validate p_idx bounds in ext4_ext_correct_indexes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31449

Introduced commit is not determined.Fixed in v7.0-rc6.


Fixed status
mainline: [2acb5c12ebd860f30e4faf67e6cc8c44ddfe5fe8]
stable/6.12: [407c944f217c17d4343148011acafebc604d55e1]
stable/6.18: [93f2e975ed658ce09db4d4c2877ca2c06540df83]
stable/6.19: [01bf1e0b997d82c0e353b51ed74ef99698043c33]

CVE-2026-31450: ext4: publish jinode after initialization

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31450

Introduced by commit a361293 ("jbd2: Fix oops in
jbd2_journal_file_inode()") in v3.11-rc6.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1aec30021edd410b986c156f195f3d23959a9d11]
stable/5.10: [2d2b648960147d078b000b9a7494017082024366]
stable/5.15: [e4325e84727e539c8597bd5b8491349f57f7fb17]
stable/6.1: [be54c0055407a73b60349c093c8ce621cb8fa232]
stable/6.12: [e76bcb727e4874a2f9d0297f8e3f8eced89b0764]
stable/6.18: [4855a59e21789c79f003a9b5f4135c95a7495c6b]
stable/6.19: [33f486987af21531a7b18973d11795ede3da9ddd]
stable/6.6: [a070d5a872ffe0e0fe5c46eda6386140ded39adb]

CVE-2026-31451: ext4: replace BUG_ON with proper error handling in
ext4_read_inline_folio

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31451

Introduced commit is not determined.Fixed in v7.0-rc6.


Fixed status
mainline: [356227096eb66e41b23caf7045e6304877322edf]
stable/6.12: [d4b3f370c3d8f7ce565d4a718572c9f7c12f77ed]
stable/6.18: [823849a26af089ffc5dfdd2ae4b9d446b46a0cda]
stable/6.19: [a7d600e04732a7d29b107c91fe3aec64cf6ce7f2]
stable/6.6: [65c6c30ce6362c1c684568744ea510c921a756cd]

CVE-2026-31452: ext4: convert inline data to extents when truncate
exceeds inline size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31452

Introduced commit is not determined.Fixed in v7.0-rc6.


Fixed status
mainline: [ed9356a30e59c7cc3198e7fc46cfedf3767b9b17]
stable/5.10: [110d7ef602659ce4d7947c5480f7ca2779696aaf]
stable/5.15: [f53a5d9f32924bc2a810d2df243b7714da58b636]
stable/6.1: [c047332be7195833a5c5126816c2502df8269fe4]
stable/6.12: [7920dcc571cef3d8aa9ee109c136125d61d41669]
stable/6.18: [93cb2d103e5c707de0f7ad58a39b7f0fddc27aa6]
stable/6.19: [07c1a31af18290054da3d18221b8bf58983c5d3a]
stable/6.6: [699bac4d4c951974d55b045c983d1de777215949]

CVE-2026-31453: xfs: avoid dereferencing log items after push callbacks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31453

Introduced by commit 90c60e1 ("xfs: xfs_iflush() is no longer
necessary") in v5.9-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [79ef34ec0554ec04bdbafafbc9836423734e1bd6]
stable/6.1: [c8a2ab339b88d10fc34a3318c92f07d8a467019d]
stable/6.12: [c4d603e8e58a3bf35480135ccca2b4f7238abda5]
stable/6.18: [95fb5d643cc70959baa54cd17f52f80ffc3295e7]
stable/6.19: [451c6329d9afa45862c36fe6677eb7750db60617]
stable/6.6: [7121b22b0bac89394cc4c6a54b5aebc15347bdf5]

CVE-2026-31454: xfs: save ailp before dropping the AIL lock in push callbacks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31454

Introduced by commit 90c60e1 ("xfs: xfs_iflush() is no longer
necessary") in v5.9-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [394d70b86fae9fe865e7e6d9540b7696f73aa9b6]
stable/5.10: [edd1637d4e3911ab6c760f553f2040fe72f61a13]
stable/5.15: [19437e4f7bb909afde832b39372aa2f3ce3cfd88]
stable/6.1: [6dbe17f19c290a72ce57d5abc70e1fad0c3e14e5]
stable/6.12: [d8fc60bbaf5aea1604bf9f4ed565da6a1ac7a87d]
stable/6.18: [50f5f056807b7bed74f4f307f2ca0ed92f3e556d]
stable/6.19: [4c7d50147316cf049462f327c4a3e9dc2b7f1dd0]
stable/6.6: [75669e987137f49c99ca44406bf0200d1892dd16]

CVE-2026-31455: xfs: stop reclaim before pushing AIL during unmount

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31455

Introduced by commit 90c60e1 ("xfs: xfs_iflush() is no longer
necessary") in v5.9-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f24a767e3d64a5f58c595b5c29b6063a201f1e3]
stable/5.10: [e6cc490048f78b009259a5f032acead9f789c34c]
stable/5.15: [239d734c00644072862fa833805c4471573b1445]
stable/6.1: [bda27fc0b4eb3a425d9a18475c4cb94fbe862c60]
stable/6.12: [a89434a6188d8430ea31120da96e3e4cefb58686]
stable/6.18: [8147e304d7d32fd5c3e943babc296ce2873dc279]
stable/6.19: [558e3275d8a3b101be18a7fe7d1634053e9d9b07]
stable/6.6: [d38135af04a3ad8a585c899d176efc8e97853115]

CVE-2026-31456: mm/pagewalk: fix race between concurrent split and refault

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31456

Introduced by commit f9e54c3 ("vfio/pci: implement huge_fault
support") in v6.12-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3b89863c3fa482912911cd65a12a3aeef662c250]
stable/6.18: [38ec58670a0c5fc1edabdeccd857e586b7b3f318]
stable/6.19: [9bbbebd94dd5be25ec8c899d46ef01b33d5d22c0]

CVE-2026-31457: mm/damon/sysfs: check contexts->nr in repeat_call_fn

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31457

Introduced by commit d809a7c ("mm/damon/sysfs: implement refresh_ms
file internal work") in v6.17-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6557004a8b59c7701e695f02be03c7e20ed1cc15]
stable/6.18: [3527e9fdc38570cea0f6ddb7a2c9303d4044b217]
stable/6.19: [652cd0641a763dd0e846b0d12814977fadb2b7d8]

CVE-2026-31458: mm/damon/sysfs: check contexts->nr before accessing
contexts_arr[0]

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31458

Introduced by commit 0ac32b8 ("mm/damon/sysfs: support DAMOS stats")
in v5.18-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1bfe9fb5ed2667fb075682408b776b5273162615]
stable/6.1: [dee11efae9e7911a14fee6568ce1eab5fa71f255]
stable/6.12: [1e8da792672481d603fa7cd0d815577220a3ee27]
stable/6.18: [708033c231bd782858f4ddbb46ee874a5a5fbdab]
stable/6.19: [bbe03ad3fb9e714191757ca7b41582f930be7be2]
stable/6.6: [aba546061341b56e9ffb37e1eb661a3628b6ec12]

CVE-2026-31459: mm/damon/sysfs: fix param_ctx leak on
damon_sysfs_new_test_ctx() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31459

Introduced by commit f0c5118 ("mm/damon/sysfs: catch commit test ctx
alloc failure") in v6.18-rc3.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7fe000eb32904758a85e62f6ea9483f89d5dabfc]
stable/6.18: [e9de9f3ce06b133a348006668bc8d25c6e504867]
stable/6.19: [f76f0a964bc3d7b7e253b43c669c41356bc54e71]

CVE-2026-31460: drm/amd/display: check if ext_caps is valid in BL setup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31460

Introduced by commit 1454642 ("drm/amd: Re-introduce property to
control adaptive backlight modulation") in v6.19-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9da4f9964abcaeb6e19797d5e3b10faad338a786]
stable/6.19: [60b0524bfb7d691ab378cdc788209f11cd34da89]

CVE-2026-31461: drm/amd/display: Fix drm_edid leak in amdgpu_dm

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31461

Introduced commit is not determined.Fixed in v7.0-rc6.


Fixed status
mainline: [37c2caa167b0b8aca4f74c32404c5288b876a2a3]
stable/6.18: [eb95595194e4755b62360aa821f40a79b0953105]
stable/6.19: [52db857e94b9be4e6315586602b0257d1d2b165a]

CVE-2026-31462: drm/amdgpu: prevent immediate PASID reuse case

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31462

Introduced commit is not determined.Fixed in v7.0-rc6.


Fixed status
mainline: [14b81abe7bdc25f8097906fc2f91276ffedb2d26]
stable/6.12: [c0b3882836de8ac991b626823966f385555bbcff]
stable/6.18: [51ccaf0e30c303149244c34820def83d74c86288]
stable/6.19: [9e5ebfe99b223bb0eb9c50a125c9c02f4ef4c71b]

CVE-2026-31463: iomap: fix invalid folio access when i_blkbits differs
from I/O granularity

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31463

Introduced by commit b2f35ac ("iomap: add caller-provided callbacks
for read and readahead") in v6.19-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bd71fb3fea9945987053968f028a948997cba8cc]
stable/6.19: [4a927f670cdb0def226f9f85f42a9f19d9e09c88]

CVE-2026-31464: scsi: ibmvfc: Fix OOB access in ibmvfc_discover_targets_done()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31464

Introduced by commit 072b91f ("[SCSI] ibmvfc: IBM Power Virtual Fibre
Channel Adapter Client Driver") in v2.6.27-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [61d099ac4a7a8fb11ebdb6e2ec8d77f38e77362f]
stable/5.10: [d842348f8a00d5b1d7358f207eb34ffcf5b16df3]
stable/5.15: [a007246cb6c9ebdc93dafbf63cc2d43d98f402cc]
stable/6.1: [394a1cac3c12fdd7d77f19ccfd222ab5ff87ef89]
stable/6.12: [d1466bf991b2343cf2ba8336e440c8faf3cbb780]
stable/6.18: [786f10b1966e485046839f992e89f2c18cbd1983]
stable/6.19: [bae4df0a643fa7f84663473aa3082a9c2ed139db]
stable/6.6: [4ed727e35b0ab17d3eeeb1e8023768396e2be161]

CVE-2026-31465: writeback: don't block sync for filesystems with no
data integrity guarantees

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31465

Introduced by commit 0c58a97 ("fuse: remove tmp folio for writebacks
and internal rb tree") in v6.16-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [76f9377cd2ab7a9220c25d33940d9ca20d368172]
stable/6.18: [83800f8ef358ea2fc9b1ae4986b83f2bc24be927]
stable/6.19: [5c24a13d8a0466ca0446e58309e51f2606520164]

CVE-2026-31466: mm/huge_memory: fix folio isn't locked in softleaf_to_folio()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31466

Introduced by commit e9b61f1 ("thp: reintroduce split_huge_page()") in v4.5-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c5e7f0fcd592801c9cc18f29f80fbee84eb8669]
stable/5.10: [426ee10711586617da869c8bb798214965337617]
stable/5.15: [f1acf5887c2bbaf998dc3fe32c72b7a8b84a3ddd]
stable/6.1: [722cfaf6b31d31123439e67b5deac6b1261a3dea]
stable/6.12: [b8c49ad888892ad7b77062b9c102b799a3e9b4f8]
stable/6.18: [7ad1997b9bc8032603df8f091761114479285769]
stable/6.19: [8bfb8414e9f2ce6f5f2f0e3d0da52f2d132128e7]
stable/6.6: [7ddcf4a245c1c5a91fdd9698757e3d95179ffe41]

CVE-2026-31467: erofs: add GFP_NOIO in the bio completion if needed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31467

Introduced commit is not determined.Fixed in v7.0-rc6.
The erofs was introduced in aea1286 ("staging: erofs: add on-disk
layout") in 4.19-rc1.

Fixed status
mainline: [c23df30915f83e7257c8625b690a1cece94142a0]
stable/5.15: [d6565ea662e17d45a577184b0011bd69de22dc2b]
stable/6.1: [d9d8360cb66e3b599d89d2526e7da8b530ebf2ff]
stable/6.12: [378949f46e897204384f3f5f91e42e93e3f87568]
stable/6.18: [da40464064599eefe78749f75cd2bba371044c04]
stable/6.19: [e83e20b82859f0588e9a52a6fa9fea704a2061cf]
stable/6.6: [5c8ecdcfbfb0b0c6a82a4ebadc1ddea61609b902]

CVE-2026-31468: vfio/pci: Fix double free in dma-buf feature

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31468

Introduced by commit 5d74781 ("vfio/pci: Add dma-buf export support
for MMIO regions") in v6.19-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e98137f0a874ab36d0946de4707aa48cb7137d1c]
stable/6.19: [83ad334afc9a645cef1062f5346526b1e36d6516]

CVE-2026-31469: virtio_net: Fix UAF on dst_ops when
IFF_XMIT_DST_RELEASE is cleared and napi_tx is false

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31469

Introduced by commit f2fc6a5 ("[NETNS][IPV6] route6 - move ip6_dst_ops
inside the network namespace") in v2.6.26-rc1.
Introduced by commit 0287587 ("net: better IFF_XMIT_DST_RELEASE
support") in v3.18-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ba8bda9a0896746053aa97ac6c3e08168729172c]
stable/5.10: [be0e63f3b97bbaf453c542e8a15ba2a536e2ac01]
stable/5.15: [c1ec36cb3768574b916f20d2d7415fd14fa1bf12]
stable/6.1: [8a4790850e710fd6771e4d2112168ed1dd6c0e54]
stable/6.12: [f04733c4dc40c43899c3d1c97afbae5831a3770f]
stable/6.18: [9a18629f2525781f0f3dda7be72b204e4cf77d08]
stable/6.19: [63d45077b97bb0e0fe0c75931acbbca7a47af141]
stable/6.6: [fedd2e1630cac920844997227ccbe7b26a76375a]

CVE-2026-31470: virt: tdx-guest: Fix handling of host controlled
'quote' buffer length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31470

Introduced by commit f4738f5 ("virt: tdx-guest: Add Quote generation
support using TSM_REPORTS") in v6.7-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c3fd16c3b98ed726294feab2f94f876290bf7b61]
stable/6.12: [a079a62883e3365de592cea9f7a669d8115433b0]
stable/6.18: [6f3c8795ae9ba74fa10fe979293d1904712d3fb1]
stable/6.19: [02ca2d9d197723696cb9cc0cb159eb7e8bf5f89b]

CVE-2026-31471: xfrm: iptfs: only publish mode_data after clone setup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31471

Introduced by commit 6be02e3 ("xfrm: iptfs: handle reordering of
received packets") in v6.14-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d849a2f7309fc0616e79d13b008b0a47e0458b6e]
stable/6.18: [371a43c4ac70cac0de9f9b1fc5b1660b9565b9f1]
stable/6.19: [5784a1e2889c9525a8f036cb586930e232170bf7]

CVE-2026-31472: xfrm: iptfs: validate inner IPv4 header length in IPTFS payload

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31472

Introduced by commit 6c82d24 ("xfrm: iptfs: add basic receive packet
(tunnel egress) handling") in v6.14-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0d10393d5eac33cbd92f7a41fddca12c41d3cb7e]
stable/6.18: [de6d8e8ce5187f7402c9859b443355e7120c5f09]
stable/6.19: [3db7d4f777a00164582061ccaa99569cd85011a3]

CVE-2026-31473: media: mc, v4l2: serialize REINIT and REQBUFS with
req_queue_mutex

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31473

Introduced by commit 6093d30 ("media: vb2: keep a reference to the
request until dqbuf") in v4.20-rc7.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bef4f4a88b73e4cc550d25f665b8a9952af22773]
stable/5.10: [331242998a7ade5c2f65e14988901614629f3db5]
stable/5.15: [2c685e99efb3b3bd2b78699fba6b1cf321975db0]
stable/6.1: [585fd9a2063dacce8b2820f675ef23d5d17434c5]
stable/6.12: [d8549a453d5bdc0a71de66ad47a1106703406a56]
stable/6.18: [72b9e81e0203f03c40f3adb457f55bd4c8eb112d]
stable/6.19: [cf2023e84f0888f96f4b65dc0804e7f3651969c1]
stable/6.6: [1a0d9083c24fbd5d22f7100f09d11e4d696a5f01]

CVE-2026-31474: can: isotp: fix tx.buf use-after-free in isotp_sendmsg()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31474

Introduced by commit 96d1c81 ("can: isotp: add module parameter for
maximum pdu size") in v6.4-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [424e95d62110cdbc8fd12b40918f37e408e35a92]
stable/6.12: [9649d051e54413049c009638ec1dc23962c884a4]
stable/6.18: [eec8a1b18a79600bd4419079dc0026c1db72a830]
stable/6.19: [2e62e7051eca75a7f2e3d52d62ec10d7d7aa358c]
stable/6.6: [cb3d6efa78460e6d50bf68806d0db66265709f64]

CVE-2026-31475: ASoC: sma1307: fix double free of devm_kzalloc() memory

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31475

Introduced by commit 0ec6bd1 ("ASoC: sma1307: Add NULL check in
sma1307_setting_loaded()") in v6.15-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe757092d2329c397ecb32f2bf68a5b1c4bd9193]
stable/6.18: [d472d1a52985211b92883bb64bbe710b45980190]
stable/6.19: [1a82c3272626db9006f4c2cad3adf2916417aed6]

CVE-2026-31476: ksmbd: do not expire session on binding failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31476

Introduced commit is not determined.Fixed in v7.0-rc6.


Fixed status
mainline: [9bbb19d21ded7d78645506f20d8c44895e3d0fb9]
stable/6.1: [f5300690c23c5ac860499bb37dbc09cf43fd62e6]
stable/6.12: [1d1888b4a7aec518b707f6eca0bf08992c0e8da3]
stable/6.18: [a897064a457056acb976e20e3007cdf553de340f]
stable/6.19: [e0e5edc81b241c70355217de7e120c97c3429deb]
stable/6.6: [6fafc4c4238e538969f1375f9ecdc6587c53f1cc]

CVE-2026-31477: ksmbd: fix memory leaks and NULL deref in smb2_lock()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31477

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [309b44ed684496ed3f9c5715d10b899338623512]
stable/6.1: [cdac6f7e7e428dc70e3b5898ac6999a72ed13993]
stable/6.12: [91aeaa7256006d79a37298f5a1df23325db91599]
stable/6.18: [3cdacd11b41569ce75b3162142240f2355e04900]
stable/6.19: [aab42f0795620cf0d3955a520f571f697d0f9a2a]
stable/6.6: [c9b95ef6f5039f19e46c3a521a4fe1752d91dfe9]

CVE-2026-31478: ksmbd: replace hardcoded hdr2_len with offsetof() in
smb2_calc_max_out_buf_len()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31478

Introduced by commit e2b76ab ("ksmbd: add support for read compound")
in v6.6-rc1.
Fixed in v7.0-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [0e55f63dd08f09651d39e1b709a91705a8a0ddcb]
stable/5.15: [70b4c414889492c522b6e4331562360f49be2361]
stable/6.1: [9a7166f0ef8cbb7bb48dd05e2471d995566003f5]
stable/6.12: [6aef1765d6807e0f027cd87f6ac973eb0879a46d]
stable/6.18: [80824c7e527b70cf9039534e60aff592e8f209d1]
stable/6.19: [4cb537ae4f37d7d0f617815ed4bed7173fb50861]
stable/6.6: [c3a89e3ec1ccf64fa6a34e391e1581ebbcba8683]

CVE-2026-31479: drm/xe: always keep track of remap prev/next

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31479

Introduced by commit 8f33b4f ("drm/xe: Avoid doing rebinds") in v6.8-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bfe9e314d7574d1c5c851972e7aee342733819d2]
stable/6.12: [ccd41f110c608b3cc347b9be881c3e72cd634b2b]
stable/6.18: [5eda8001ebb5269755608d678dd1f3928ab077c9]
stable/6.19: [e6ba1749549e87b83c0c4885d84b543687c3740e]

CVE-2026-31480: tracing: Fix potential deadlock in cpu hotplug with osnoise

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31480

Introduced by commit bce29ac ("trace: Add osnoise tracer") in v5.14-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f9885732248d22f788e4992c739a98c88ab8a55]
stable/5.15: [cf929c21eeed5bd39873fb14bfdfff963fa6f1da]
stable/6.1: [7aa095ce7d224308cb6979956f0de8607df93d4f]
stable/6.12: [03474a01c199de17a8e2d39b51df6beb9c76e831]
stable/6.18: [f278b8ebf7eba2a1699cfc7bf30dd3ef898d60d7]
stable/6.19: [7a41d4633cd2c15eb5ed31e8f3b16910e50a8c9f]
stable/6.6: [ef41a85a55022e27cdaebf22a6676910b66f65aa]

CVE-2026-31481: tracing: Drain deferred trigger frees if kthread creation fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31481

Introduced by commit 61d445a ("tracing: Add bulk garbage collection of
freeing event_trigger_data") in v6.19-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [250ab25391edeeab8462b68be42e4904506c409c]
stable/6.19: [771624b7884a83bb9f922ae64ee41a5f8b7576c9]

CVE-2026-31482: s390/entry: Scrub r12 register on kernel entry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31482

Introduced by commit f33f2d4 ("s390/bp: remove TIF_ISOLATE_BP") in v6.4-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0738d395aab8fae3b5a3ad3fc640630c91693c27]
stable/6.12: [95c899cd791803a5bf7b73e5994fbbe1cc1a9c36]
stable/6.18: [7f4e3233faa8470dd0627bc49b2809f2bfebd909]
stable/6.19: [99a8b420f3f0e162eb9c9c9253929d4d23f9bd30]
stable/6.6: [a58d298a83a3a9b7ca99ded9d60a1e77231159ef]

CVE-2026-31483: s390/syscalls: Add spectre boundary for syscall dispatch table

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31483

Introduced by commit 56e62a7 ("s390: convert to generic entry") in v5.12-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [48b8814e25d073dd84daf990a879a820bad2bcbd]
stable/5.10: [6fab780a4ab534093d80a9ce48dcaed9e05ba893]
stable/5.15: [3c3b97064764899c39a0abbd35a6caa031e70333]
stable/6.1: [1cb9c7bc9025c637564fabc7fcc3c9343949e310]
stable/6.12: [f8c444b918d639e1f9a621ee20fe481c1d10dfc4]
stable/6.18: [87776f02449e3bded95b2ccbd6b012e9ae64e6f3]
stable/6.19: [4d05dd18d867d58c6952a3bc260d244899da7256]
stable/6.6: [7a5260fbc6e79a1595328ec5c6aa3f937504a1f0]

CVE-2026-31484: io_uring/fdinfo: fix OOB read in SQE_MIXED wrap check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31484

Introduced by commit 1cba30b ("io_uring: add support for
IORING_SETUP_SQE_MIXED") in v6.19-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5170efd9c344c68a8075dcb8ed38d3f8a60e7ed4]
stable/6.19: [ba21ab247a5be5382da7464b95afbe5f0e9aa503]

CVE-2026-31485: spi: spi-fsl-lpspi: fix teardown order issue (UAF)

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31485

Introduced by commit 5314987 ("spi: imx: add lpspi bus driver") in v4.10-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b341c1176f2e001b3adf0b47154fc31589f7410e]
stable/5.10: [fbe6f40caeebb0b1ea9dfedc259124c1d3cda7a6]
stable/5.15: [ca4483f36ac1b62e69f8b182c5b8f059e0abecfb]
stable/6.1: [e3fd54f8b0317fbccc103961ddd660f2a32dcf0b]
stable/6.12: [d5d01f24bc6fbde40b4e567ef9160194b61267bc]
stable/6.18: [e89e2b97253c124d37bf88e96e5e8ce5c3aeeec3]
stable/6.19: [15650dfbaeeb14bcaaf053b93cf631db8d465300]
stable/6.6: [adb25339b66112393fd6892ceff926765feb5b86]

CVE-2026-31486: hwmon: (pmbus/core) Protect regulator operations with mutex

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31486

Introduced by commit ddbb4db ("hwmon: (pmbus) Add regulator support")
in v3.19-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [754bd2b4a084b90b5e7b630e1f423061a9b9b761]
stable/6.18: [4e9d723d9f198b86f6882a84c501ba1f39e8d055]
stable/6.19: [2c77ae315f3ce9d2c8e1609be74c9358c1fe4e07]

CVE-2026-31487: spi: use generic driver_override infrastructure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31487

Introduced by commit 5039563 ("spi: Add driver_override SPI device
attribute") in v4.20-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cc34d77dd48708d810c12bfd6f5bf03304f6c824]
stable/6.12: [eedf220442d13b6d97294e5b0ac8a2c38ee1a1a0]
stable/6.18: [c73a58661a760373d08a6883af4f0bb5cc991a67]
stable/6.19: [e0ae367a2de06c49aa1de6ec9b1ab6860bbb2cf0]

CVE-2026-31488: drm/amd/display: Do not skip unrelated mode changes in
DSC validation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31488

Introduced by commit 17ce8a6 ("drm/amd/display: Add dsc pre-validation
in atomic check") in v5.18-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aed3d041ab061ec8a64f50a3edda0f4db7280025]
stable/6.12: [10862e344b4d6434642a48c87d765813fc0b0ba7]
stable/6.18: [8a5edc97fd9c6415ff2eff872748439a97e3c3d8]
stable/6.19: [111208b5b7ebcdadb3f922cc52d8425f0fa91b33]

CVE-2026-31489: spi: meson-spicc: Fix double-put in remove path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31489

Introduced by commit 8311ee2 ("spi: meson-spicc: fix memory leak in
meson_spicc_remove") in v5.14-rc5.
Fixed in v7.0-rc6.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [63542bb402b7013171c9f621c28b609eda4dbf1f]
stable/6.12: [40ad0334c17b23d8b66b1082ad1478a6202e90e2]
stable/6.18: [da06a104f0486355073ff0d1bcb1fcbebb7080d6]
stable/6.19: [9b812ceb75a6260c17c91db4b9e74ead8cfa06f5]

CVE-2026-31490: drm/xe/pf: Fix use-after-free in migration restore

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31490

Introduced by commit 1ed3039 ("drm/xe/pf: Add support for encap/decap
of bitstream to/from packet") in v6.19-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87997b6c6516e049cbaf2fc6810b213d587a06b1]
stable/6.19: [e28552b4ddea5cb4725380dd08237831af835124]

CVE-2026-31491: RDMA/irdma: Harden depth calculation functions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31491

Introduced by commit 563e1fe ("RDMA/irdma: Add SRQ support") in v6.18-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e37afcb56ae070477741fe2d6e61fc0c542cce2d]
stable/6.18: [3f08351de5ca4f2f724b86ad252fbc21289467e1]
stable/6.19: [cbd852f5700eb3f64392452faf693ac45cae8281]

CVE-2026-31492: RDMA/irdma: Initialize free_qp completion before using it

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31492

Introduced by commit b48c24c ("RDMA/irdma: Implement device supported
verb APIs") in v5.14-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [11a95521fb93c91e2d4ef9d53dc80ef0a755549b]
stable/6.1: [ac1da7bd224d406b6f1b84414f0f652ab43b6bd8]
stable/6.12: [cd1534c8f4984432382c240f6784408497f5bb0a]
stable/6.18: [3cb88c12461b71c7d9c604aa2e6a9a477ecfa147]
stable/6.19: [f72996834f7bdefc2b95e3eec30447ee195df44e]
stable/6.6: [af310407f79d5816fc0ab3638e1588b6193316dd]

CVE-2026-31493: RDMA/efa: Fix use of completion ctx after free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31493

Introduced by commit 68fb9f3 ("RDMA/efa: Remove redundant NULL pointer
check of CQE") in v5.12-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef3b06742c8a201d0e83edc9a33a89a4fe3009f8]
stable/6.18: [0dd98aea1c0c45987fa2dd92f988b0eb1a72c125]
stable/6.19: [1cf95fe5dc5471efea947b4c6f8913da6bc7976e]

CVE-2026-31494: net: macb: use the current queue number for stats

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31494

Introduced by commit 512286b ("net: macb: Added some queue
statistics") in v4.16-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [72d96e4e24bbefdcfbc68bdb9341a05d8f5cb6e5]
stable/5.10: [9738be665544281aa624842812c2fbfed6f88226]
stable/5.15: [240c5302eed83e34e98db18f6795ee5f40814024]
stable/6.1: [9596759a84e1dbf2670518d85e969208960041f9]
stable/6.12: [9d74d10e4e26672e139a8bcf8bf95957bf2d160f]
stable/6.18: [7ff87da099210856cbfe2f2f7f52ddfa57af4f0c]
stable/6.19: [e182fe273cdf5a8931592228196ef514ffac392b]
stable/6.6: [95246341945163ad9a250a87ca5bd1c1252777ae]

CVE-2026-31495: netfilter: ctnetlink: use netlink policy range checks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31495

Introduced by commit c8e2078 ("[NETFILTER]: ctnetlink: add support for
internal tcp connection tracking flags handling") in v2.6.22-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8f15b5071b4548b0aafc03b366eb45c9c6566704]
stable/5.10: [435b576cd2faa75154777868f8cbb73bf71644d3]
stable/5.15: [2ef71307c86a9f866d6e28f1a0c06e2e9d794474]
stable/6.1: [4f7d25f3f0786402ba48ff7d13b6241d77d975f5]
stable/6.12: [675c913b940488a84effdeeac5a1cfb657b59804]
stable/6.18: [c6cb41eaae875501eaaa487b8db6539feb092292]
stable/6.19: [45c33e79ae705b7af97e3117672b6cd258dd0b1b]
stable/6.6: [fcec5ce2d73a41668b24e3f18c803541602a59f6]

CVE-2026-31496: netfilter: nf_conntrack_expect: skip expectations in
other netns via proc

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31496

Introduced by commit 9b03f38 ("netfilter: netns nf_conntrack:
per-netns expectations") in v2.6.28-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3db5647984de03d9cae0dcddb509b058351f0ee4]
stable/6.1: [2028405ea6987b4448784e439413202cfe19f43f]
stable/6.12: [dcfcd95b3ae7683e8ae55c92284b3430ce614bc7]
stable/6.18: [9ca8c7452493d915f9bbf2f39331e6c583d07a23]
stable/6.19: [3265ad619987cb551edaf797ed056d80ac450225]
stable/6.6: [168145c87444619e3e649322bbe7719ecd00d411]

CVE-2026-31497: Bluetooth: btusb: clamp SCO altsetting table indices

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31497

Introduced by commit baac627 ("Bluetooth: btusb: handle mSBC audio
over USB Endpoints") in v5.8-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [129fa608b6ad08b8ab7178eeb2ec272c993aaccc]
stable/5.10: [312c4450fe23014665c163f480edd5ad2e27bbb8]
stable/5.15: [9dd13a8641de79bc1bc93da55cdd35259a002683]
stable/6.1: [476c9262b430c38c6a701a3b8176a3f48689085b]
stable/6.12: [834cf890d2c3d29cbfa1ee2376c40469c28ec297]
stable/6.18: [1019028eb124564cf7bca58a16f1df8a1ca30726]
stable/6.19: [21c254202f9d78abe0fcd642a92966deb92bd226]
stable/6.6: [6fba3c3d48c927e55611a0f5ea34da88138ed0ff]

CVE-2026-31498: Bluetooth: L2CAP: Fix ERTM re-init and zero pdu_len
infinite loop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31498

Introduced by commit 96298f6 ("Bluetooth: L2CAP: handle l2cap config
request during open state") in v5.7-rc1.
Fixed in v7.0-rc6.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [25f420a0d4cfd61d3d23ec4b9c56d9f443d91377]
stable/5.10: [9760b83cfd24b38caee663f429011a0dd6064fa9]
stable/5.15: [de37e2655b7abc3f59254c6b72256840f39fc6d5]
stable/6.1: [e7aab23b7df89a3d754a5f0a7d2237548b328bd0]
stable/6.12: [9a21a631ee034b1573dce14b572a24943dbfd7ae]
stable/6.18: [900e4db5385ec2cacd372345a80ab9c8e105b3a3]
stable/6.19: [042e2cd4bb11e5313b19b87593616524949e4c52]
stable/6.6: [52667c859fe33f70c2e711cb81bbd505d5eb8e75]

CVE-2026-31499: Bluetooth: L2CAP: Fix deadlock in l2cap_conn_del()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31499

Introduced by commit ab4eedb ("Bluetooth: L2CAP: Fix corrupted list in
hci_chan_del") in v6.14-rc3.
Fixed in v7.0-rc6.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [00fdebbbc557a2fc21321ff2eaa22fd70c078608]
stable/6.18: [3f26ecbd9cde621dd94be7ef252c7210b965a5c7]
stable/6.19: [d008460de352e534f6721de829b093368564ec66]

CVE-2026-31500: Bluetooth: btintel: serialize btintel_hw_error() with
hci_req_sync_lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31500

Introduced by commit 973bb97 ("Bluetooth: btintel: Add generic
function for handling hardware errors") in v4.3-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [94d8e6fe5d0818e9300e514e095a200bd5ff93ae]
stable/6.12: [e10a4cb72468686ffbe8bb2b0520e37f6be1a0c5]
stable/6.18: [66696648af477dc87859e5e4b607112f5f29d010]
stable/6.19: [f7d84737663ad4a120d2d8ef1561a4df91282c2e]
stable/6.6: [5f84e845648dfa86e42de5487f1a774b42f0444d]

CVE-2026-31501: net: ti: icssg-prueth: fix use-after-free of CPPI
descriptor in RX path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31501

Introduced by commit 46eeb90 ("net: ti: icssg-prueth: Use page_pool
API for RX buffer allocation") in v6.15-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb8c426c9803beb171f89d15fea17505eb517714]
stable/6.19: [d5827316debcb677679bb014885d7be92c410e11]

CVE-2026-31502: team: fix header_ops type confusion with non-Ethernet ports

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31502

Introduced by commit 1d76efe ("team: add support for non-ethernet
devices") in v3.7-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [425000dbf17373a4ab8be9428f5dc055ef870a56]
stable/6.12: [6d3161fa3eee64d46b766fb0db33ec7f300ef52d]
stable/6.18: [0a7468ed49a6b65d34abcc6eb60e15f7f6d34da0]
stable/6.19: [20491d384d973a63fbdaf7a71e38d69b0659ea55]

CVE-2026-31503: udp: Fix wildcard bind conflict check when using hash2

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31503

Introduced by commit 30fff92 ("udp: bind() optimisation") in v2.6.33-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e537dd15d0d4ad989d56a1021290f0c674dd8b28]
stable/6.1: [d6ace0dbcbb7fd285738bb87b42b71b01858c952]
stable/6.12: [f1bed05a832ae79be5f7a105da56810eaa59a5f1]
stable/6.18: [18d84c45def3671d5c89fbdd5d4ab8a3217fe4b4]
stable/6.19: [0a360f7f73a06ac88f18917055fbcc79694252d7]
stable/6.6: [2297e38114316b26ae02f2d205c49b5511c5ed55]

CVE-2026-31504: net: fix fanout UAF in packet_release() via NETDEV_UP race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31504

Introduced by commit ce06b03 ("packet: Add helpers to
register/unregister ->prot_hook") in v3.1-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [42156f93d123436f2a27c468f18c966b7e5db796]
stable/5.10: [ee642b1962caa9aa231c01abbd58bc453ae6b66e]
stable/5.15: [42cfd7898eeed290c9fb73f732af1f7d6b0a703e]
stable/6.1: [1b4c03f8892d955385c202009af7485364731bb9]
stable/6.12: [75fe6db23705a1d55160081f7b37db9665b1880b]
stable/6.18: [d0c7cdc15fdf8c4f91aca1928e52295d175b6ec6]
stable/6.19: [ceccbfc6de720ad633519a226715989cfb065af1]
stable/6.6: [654386baef228c2992dbf604c819e4c7c35fc71b]

CVE-2026-31505: iavf: fix out-of-bounds writes in iavf_get_ethtool_stats()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31505

Introduced by commit 64430f7 ("iavf: Fix displaying queue statistics
shown by ethtool") in v5.17-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fecacfc95f195b99c71c579a472120d0b4ed65fa]
stable/6.12: [1f931dee5b726df1940348ec31614d64bac03aa6]
stable/6.18: [bb85741d2dc2be207353a412f51b83697fcbefcf]
stable/6.19: [fdf902bf86a80bf15792a1d20a67a5302498d7f1]

CVE-2026-31506: net: bcmasp: fix double free of WoL irq

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31506

Introduced by commit a2f0751 ("net: bcmasp: Add support for WoL magic
packet") in v6.6-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cbfa5be2bf64511d49b854a0f9fd6d0b5118621f]
stable/6.12: [121a6ad9cd42ba3bfc57deae93e3326515c2afe1]
stable/6.18: [9e5f5c07cc7d66522f8c9676c28605eba5d4a20e]
stable/6.19: [8a30509ce6a29bdf18e0802383c524a7b2357ec0]

CVE-2026-31507: net/smc: fix double-free of smc_spd_priv when tee()
duplicates splice pipe buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31507

Introduced by commit 9014db2 ("smc: add support for splice()") in v4.18-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [24dd586bb4cbba1889a50abe74143817a095c1c9]
stable/5.10: [7e8916f46c2f48607f907fd401590093753a6bc5]
stable/5.15: [ae5575e660410c8d2c5d38fb28a0f37aea945676]
stable/6.1: [98ba5cb274768146e25ffbfde47753652c1c20d3]
stable/6.12: [7bcb974c771c863e8588cea0012ac204443a7126]
stable/6.18: [54c87a730157868543ebdfa0ecb21b4590ed23a5]
stable/6.19: [3cc76380fea749280c026f410af56a28aaac388a]
stable/6.6: [81acbd345d405994875d419d43b319fee0b9ad62]

CVE-2026-31508: net: openvswitch: Avoid releasing netdev before
teardown completes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31508

Introduced by commit 5498227 ("net: openvswitch: Avoid needlessly
taking the RTNL on vport destroy") in v6.19-rc4.
Fixed in v7.0-rc6.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [7c770dadfda5cbbde6aa3c4363ed513f1d212bf8]
stable/5.10: [df3c95be76103604e752131d9495a24814915ece]
stable/5.15: [33609454be4f582e686a4bf13d4482a5ca0f6c4b]
stable/6.1: [5fdeaf591a0942772c2d18ff3563697a49ad01c6]
stable/6.12: [43579baa17270aa51f93eb09b6e4af6e047b7f6e]
stable/6.18: [95265232b49765a4d00f4d028c100bb7185600f4]
stable/6.19: [755a6300afbd743cda4b102f24f343380ec0e0ff]
stable/6.6: [4c3e25a7b711a402fcbbbcfbbdf2868ece1ae7c8]

CVE-2026-31509: nfc: nci: fix circular locking dependency in nci_close_device

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31509

Introduced by commit 6a2968a ("NFC: basic NCI protocol
implementation") in v3.2-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4527025d440ce84bf56e75ce1df2e84cb8178616]
stable/5.10: [7ed00a3edc8597fe2333f524401e2889aa1b5edf]
stable/5.15: [5eef9ebec7f5738f12cadede3545c05b34bf5ac3]
stable/6.1: [ca54e904a071aa65ef3ad46ba42d51aaac6b73b4]
stable/6.12: [1edc12d2bbcb7a8d0f1088e6fccb9d8c01bb1289]
stable/6.18: [d89b74bf08f067b55c03d7f999ba0a0e73177eb3]
stable/6.19: [09143c0e8f3b03517e6233aad42f45c794d8df8e]
stable/6.6: [eb435d150ca74b4d40f77f1a2266f3636ed64a79]

CVE-2026-31510: Bluetooth: L2CAP: Fix null-ptr-deref on l2cap_sock_ready_cb

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31510

Introduced by commit 54a59aa ("Bluetooth: Add
l2cap_chan->ops->ready()") in v3.6-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b6552e0503973daf6f23bd6ed9273ef131ee364f]
stable/5.10: [d34776c7fa1f2c510f1cdd14823aba701babb4ad]
stable/5.15: [03d4eafb0f3788239df63575951f6b4c97bbfda4]
stable/6.1: [3c821bc0fbeaa27910a20d0b43c6008d099792af]
stable/6.12: [0780f9333852971ca77d110019e3a66ce5a7b100]
stable/6.18: [1dc6db047919ecd59493cd51248b37381bbabcbb]
stable/6.19: [898b89c90ff9496e64b9331040778cc4e1b28c9d]
stable/6.6: [a04a760c06bb591989db659439efdf106f0bae76]

CVE-2026-31511: Bluetooth: MGMT: Fix dangling pointer on
mgmt_add_adv_patterns_monitor_complete

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31511

Introduced by commit 302a1f6 ("Bluetooth: MGMT: Fix possible UAFs") in v6.17.
Fixed in v7.0-rc6.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [5f5fa4cd35f707344f65ce9e225b6528691dbbaa]
stable/6.12: [340666172cf747de58c283d2eef1f335f050538b]
stable/6.18: [bafec9325d4de26b6c49db75b5d5172de652aae0]
stable/6.19: [3a89c33deffb3cb7877a7ea2e50734cd12b064f2]

CVE-2026-31512: Bluetooth: L2CAP: Validate PDU length before reading
SDU length in l2cap_ecred_data_rcv()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31512

Introduced by commit aac23bf ("Bluetooth: Implement LE L2CAP
reassembly") in v3.14-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c65bd945d1c08c3db756821b6bf9f1c4a77b29c6]
stable/5.10: [cef09691cfb61f6c91cc27c3d69634f81c8ab949]
stable/5.15: [3340be2bafdcc806f048273ea6d8e82a6597aa1b]
stable/6.1: [e47315b84d0eb188772c3ff5cf073cdbdefca6b4]
stable/6.12: [40c7f7eea2f4d9cb0b3e924254c8c9053372168f]
stable/6.18: [8c96f3bd4ae0802db90630be8e9851827e9c9209]
stable/6.19: [5ad981249be52f5e4e92e0e97b436b569071cb86]
stable/6.6: [477ad4976072056c348937e94f24583321938df4]

CVE-2026-31513: Bluetooth: L2CAP: Fix stack-out-of-bounds read in
l2cap_ecred_conn_req

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31513

Introduced by commit c28d2bf ("Bluetooth: L2CAP: Fix result of
L2CAP_ECRED_CONN_RSP when MTU is too short") in v7.0-rc2.
Fixed in v7.0-rc6.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.19

Fixed status
mainline: [9d87cb22195b2c67405f5485d525190747ad5493]
stable/6.12: [c8e1a27edb8b4e5afb56b384acd7b6c2dec1b7cc]
stable/6.18: [5b35f8211a913cfe7ab9d54fa36a272d2059a588]
stable/6.19: [a3d9c50d69785ae02e153f000da1b5fd6dbfdf1b]

CVE-2026-31514: erofs: set fileio bio failed in short read case

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31514

Introduced by commit bc804a8 ("erofs: handle end of filesystem
properly for file-backed mounts") in v7.0-rc1.
Fixed in v7.0-rc6.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.19

Fixed status
mainline: [eade54040384f54b7fb330e4b0975c5734850b3c]
stable/6.12: [d1ba7d6b3cd1757b108d7b6856c92ae661d6c323]
stable/6.18: [5cf3972c8221abdb1b464a14ccf8103d840b9085]
stable/6.19: [5a5f23ef5431639db1ac3a0b274aef3a84cc413c]

CVE-2026-31515: af_key: validate families in pfkey_send_migrate()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31515

Introduced by commit 08de61b ("[PFKEYV2]: Extension for dynamic update
of endpoint address(es)") in v2.6.21-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb2d16a7d599dc9d4df391b5e660df9949963786]
stable/5.10: [d0c5aa8dd38887714f1aad04236a3620b56a5e4e]
stable/5.15: [e06b596fc4eb01936a2e5dccad17c946d660bab8]
stable/6.1: [8ddf8de7e758f6888988467af9ffc8adf589fb16]
stable/6.12: [7b18692c59afb8e5c364c8e3ac01e51dd6b52028]
stable/6.18: [83f644ea92987c100b82d8481ae2230faeed3d34]
stable/6.19: [ee836e820a40e2ca4da8af7310bff92d586772d4]
stable/6.6: [d3225e6b9bd51ec177970a628fe4b11237ce87d5]

CVE-2026-31516: xfrm: prevent policy_hthresh.work from racing with
netns teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31516

Introduced by commit 880a6fa ("xfrm: configure policy hash table
thresholds by netlink") in v3.18-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [29fe3a61bcdce398ee3955101c39f89c01a8a77e]
stable/6.12: [56ea2257b83ee29a543f158159e3d1abc1e3e4fe]
stable/6.18: [8854e9367465d784046362698731c1111e3b39b8]
stable/6.19: [4e2e77843fef473ef47e322d52436d8308582a96]

CVE-2026-31517: xfrm: iptfs: fix skb_put() panic on non-linear skb
during reassembly

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31517

Introduced by commit 5f2b6a9 ("xfrm: iptfs: add skb-fragment sharing
code") in v6.14-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0b352f83cabfefdaafa806d6471f0eca117dc7d5]
stable/6.18: [33a7b36268933c75bdc355e5531951e0ea9f1951]
stable/6.19: [7fdfe8f6efeb0e1200e22a903f2471539f54522b]

CVE-2026-31518: esp: fix skb leak with espintcp and async crypto

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31518

Introduced by commit e27cca9 ("xfrm: add espintcp (RFC 8229)") in v5.6-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c0eef8ccd2413b0a10eb6bbd3442333b1e64dd2]
stable/5.10: [aca3ad0c262f54a5b5c95dda80a48365997d1224]
stable/5.15: [41aafca57de4a4c026701622bd4648f112a9edcd]
stable/6.1: [4820847e036ff1035b01b69ad68dfc17e7028fe9]
stable/6.12: [df6f995358dc1f3c42484f5cfe241d7bd3e1cd15]
stable/6.18: [88d386243ed374ac969dabd3bbc1409a31d81818]
stable/6.19: [6aa9841d917532d0f2d932d1ff2f3a94305aaf47]
stable/6.6: [6a3ec6efbc4f90e0ccb2e71574f07351f19996f4]

CVE-2026-31519: btrfs: set BTRFS_ROOT_ORPHAN_CLEANUP during subvol create

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31519

Introduced commit is not determined.Fixed in v7.0-rc4.


Fixed status
mainline: [5131fa077f9bb386a1b901bf5b247041f0ec8f80]
stable/6.1: [d43da8de0ed376abafbad8a245a1835e8f66cb0f]
stable/6.12: [a41a9b8d19a98b45591528c6e54d31cc66271d1e]
stable/6.18: [2ec578e6452138ab76f6c9a9c18711fcd197649f]
stable/6.19: [696683f214495db3cdacab9a713efaaced8660f8]
stable/6.6: [c57276ced3c3207f42182dfa2f0d8e860357e111]

CVE-2026-31520: HID: apple: avoid memory leak in apple_report_fixup()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31520

Introduced commit is not determined.Fixed in v7.0-rc3.


Fixed status
mainline: [239c15116d80f67d32f00acc34575f1a6b699613]
stable/6.1: [e2f090aeb7b9930a964e151910f4d45b04c8a7e5]
stable/6.12: [31860c3f7ac66ab897a8c90dc4e74fa17ca0b624]
stable/6.18: [be1a341c161430282acdfe2ac99b413271575cf1]
stable/6.19: [e652ebd29928181c3e6820e303da25873e9917d4]
stable/6.6: [2635d0c715f3fb177e0f80ecd5fa48feb6bf3884]

CVE-2026-31521: module: Fix kernel panic when a symbol st_shndx is out of bounds

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31521

Introduced commit is not determined.Fixed in v7.0-rc3.


Fixed status
mainline: [f9d69d5e7bde2295eb7488a56f094ac8f5383b92]
stable/5.15: [5d16f519b6eb1d071807e57efe0df2baa8d32ad6]
stable/6.1: [4bbdb0e48176fd281c2b9a211b110db6fd94e175]
stable/6.12: [ec2b22a58073f80739013588af448ff6e2ab906f]
stable/6.18: [ef75dc1401d8e797ee51559a0dd0336c225e1776]
stable/6.19: [6ba6957c640f58dc8ef046981a045da43e47ea23]
stable/6.6: [082f15d2887329e0f43fd3727e69365f5bfe5d2c]

CVE-2026-31522: HID: magicmouse: avoid memory leak in magicmouse_report_fixup()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31522

Introduced commit is not determined.Fixed in v7.0-rc3.


Fixed status
mainline: [91e8c6e601bdc1ccdf886479b6513c01c7e51c2c]
stable/5.15: [579c4c9857acdc8380fa99803f355f878bd766cb]
stable/6.1: [d84c21aabaab517b9aaf9bc1d785922cb9db2f31]
stable/6.12: [79e5dcc95d9abed6f8203cfd529f4ec71f0e505d]
stable/6.18: [136f605e246b4bfe7ac2259471d1ff814aed0084]
stable/6.19: [fa95b0146358b49f9858139b67314591fd5871b0]
stable/6.6: [7edfe4346b052b708645d0acc0f186425766b785]

CVE-2026-31523: nvme-pci: ensure we're polling a polled queue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31523

Introduced commit is not determined.Fixed in v7.0-rc3.


Fixed status
mainline: [166e31d7dbf6aa44829b98aa446bda5c9580f12a]
stable/5.10: [965e2c943f065122f14282a88d70a8a92e12a4da]
stable/5.15: [ba167d5982e2eb6ff9356d409eca592ce99555da]
stable/6.1: [0685dd9cb855ab77fcf3577b4702ba1d6df1c98d]
stable/6.12: [acbc72dd1a09df53cafcf577259f4678be6afd6d]
stable/6.18: [b96c7b25eb1b748f3e3b1832ebf028b0b223d7e3]
stable/6.19: [b222680ba55e018426c4535067a008f1d81a5d21]
stable/6.6: [6f12734c4b619f923a4df0b1a46b8098b187d324]

CVE-2026-31524: HID: asus: avoid memory leak in asus_report_fixup()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31524

Introduced commit is not determined.Fixed in v7.0-rc3.


Fixed status
mainline: [2bad24c17742fc88973d6aea526ce1353f5334a3]
stable/5.10: [726765b43deb2b4723869d673cc5fc6f7a3b2059]
stable/5.15: [ede95cfcab8064d9a08813fbd7ed42cea8843dcf]
stable/6.1: [2e4fe6b15c2f390c023b20d728b1a3fe7ea4f973]
stable/6.12: [7a6d6e4d8af044f94fa97e97af5ff2771e1fbebd]
stable/6.18: [a41cc7c1668e44ff2c2d36f9a6353253ffc43e3c]
stable/6.19: [84724ac4821a160d47b84289adf139023027bdbb]
stable/6.6: [f20f17cffbe34fb330267e0f8084f5565f807444]

CVE-2026-31525: bpf: Fix undefined behavior in interpreter sdiv/smod for INT_MIN

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31525

Introduced by commit ec0e2da ("bpf: Support new signed div/mod
instructions.") in v6.6-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c77b30bd1dcb61f66c640ff7d2757816210c7cb0]
stable/6.12: [9ab1227765c446942f290c83382f0b19887c55cf]
stable/6.18: [f14ca604c0ff274fba19f73f1f0485c0047c1396]
stable/6.19: [0d5d8c3ce45c734aaf3c51cbef59155a6746157d]
stable/6.6: [694ea55f1b1c74f9942d91ec366ae9e822422e42]

CVE-2026-31526: bpf: Fix exception exit lock checking for subprogs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31526

Introduced by commit f18b03f ("bpf: Implement BPF exceptions") in v6.7-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6c2128505f61b504c79a20b89596feba61388112]
stable/6.18: [c0281da1f2aa5c2fca3a05f79b86bea96591c358]
stable/6.19: [5a399f3117642494e35545f6ca397d3e177c1f9b]

CVE-2026-31527: driver core: platform: use generic driver_override
infrastructure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31527

Introduced by commit 3d713e0 ("driver core: platform: add device
binding path 'driver_override'") in v3.17-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b38efc05bf7a8568ec74bfffea0f5cfa62bc01d]
stable/6.12: [9a6086d2a828dd2ff74cf9abcae456670febd71f]
stable/6.18: [7c02a9bd7d14a89065fcf672b86d8e1d1a41d3b1]
stable/6.19: [edee7ee5a14c3b33f6d54641f5af5c5e9180992d]

CVE-2026-31528: perf: Make sure to use pmu_ctx->pmu for groups

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31528

Introduced by commit bd27568 ("perf: Rewrite core context handling")
in v6.2-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b9ce671960627b2505b3f64742544ae9801df97]
stable/6.12: [3a696e84a8b1fafdd774bb30d62919faf844d9e4]
stable/6.18: [35f7914e54fe7f13654c22ee045b05e4b6d8062b]
stable/6.19: [4c759446046500a1a6785b25725725c3ff087ace]
stable/6.6: [656f35b463995bee024d948440128230aacd81e1]

CVE-2026-31529: cxl/region: Fix leakage in __construct_region()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31529

Introduced by commit d6602e2 (cxl/region: Add support to indicate
region has extended linear cache) in v6.19-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [77b310bb7b5ff8c017524df83292e0242ba89791]
stable/6.19: [f1b4741adf08b0063291ec1b0dfa9c3d55644933]

CVE-2026-31530: cxl/port: Fix use after free of parent_port in cxl_detach_ep()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31530

Introduced by commit 2345df5 ("cxl/memdev: Fix endpoint port removal")
in v6.3-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [19d2f0b97a131198efc2c4ca3eb7f980bba8c2b4]
stable/6.12: [d216a4bd138eb57cc4ae7c43b2f709e3482af7e2]
stable/6.18: [2c32141462045cf93d54a5146a0ba572b83533dd]
stable/6.19: [f7dc6f381a1e5f068333f1faa9265d6af1df4235]


* Updated CVEs

CVE-2022-49752: device property: fix of node refcount leak in
fwnode_graph_get_next_endpoint()

stable/5.10 was fixed.

Fixed status
stable/5.10: [e0472947bead3af94cc968ce35fc0414803a2f65]

CVE-2024-26849: netlink: add nla be16/32 types to minlen array

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [000a68159c0326b46c42ec712ab98793e7e625a7]
stable/5.15: [80b40f9cb87f3bf5877dfb852765cf92bc03ca77]

CVE-2024-36898: gpiolib: cdev: fix uninitialised kfifo

stable/5.15 was fixed.

Fixed status
stable/5.15: [c87cc32bc48b187067e089b15ab7a6a7eed5767d]

CVE-2024-46715: driver: iio: add missing checks on iio_info's callback access

stable/5.15 was fixed.

Fixed status
stable/5.15: [2b961d5786b4b31c367c719a2f918569b444c007]

CVE-2024-56557: iio: adc: ad7923: Fix buffer overflow for tx_buf and ring_xfer

stable/5.15 was fixed.

Fixed status
stable/5.15: [6e4d236d9c4b38571c394d3ab6e85dfb71c33ed3]

CVE-2024-56584: io_uring/tctx: work around xa_store() allocation error issue

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [e05c070b401f6365c503e2b59f091331965c4fb9]
stable/5.15: [3a84fa784710990964c1e35df743851ab2863898]

CVE-2025-21739: scsi: ufs: core: Fix use-after free in init error and
remove paths

stable/6.6 was fixed.

Fixed status
stable/6.6: [0dc539b888fb5f56b6eeddd95433eab557d4b0c1]

CVE-2025-37778: ksmbd: Fix dangling pointer in krb_authenticate

stable/5.15 was fixed.

Fixed status
stable/5.15: [b61f04d5d73c53d183019bafe22fb700a739bac5]

CVE-2025-38006: net: mctp: Don't access ifa_index when missing

stable/5.15 was fixed.

Fixed status
stable/5.15: [8ef7b3f0db69e2f4a80be351f6aee9a4c2332ef9]

CVE-2025-38436: drm/scheduler: signal scheduled fence when kill job

stable/6.1 was fixed.

Fixed status
stable/6.1: [8342127a8a65b0673863b106ce32b79c91ae3270]

CVE-2025-38562: ksmbd: fix null pointer dereference error in
generate_encryptionkey

stable/5.15 was fixed.

Fixed status
stable/5.15: [922f85e6e88fdea723a26854c3a6dcb4beb8d0b9]

CVE-2025-39748: bpf: Forget ranges when refining tnum after JSET

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [22191359f8454b0be082c3b126f86bcbea0f1318]
stable/5.15: [c29dd8336236a4deb75596b52d2dd16ccc4a380d]

CVE-2025-39764: netfilter: ctnetlink: remove refcounting in expectation dumpers

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [b05500444b8eb97644efdd180839a04a706be97c]
stable/5.15: [bada48ad5b0590e318d0f79636ff62a2ef9f4955]

CVE-2025-39930: ASoC: simple-card-utils: Don't use __free(device_node)
at graph_util_parse_dai()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [16a49e3fda339aa552cde7f2cdbb25b91426cb8a]
stable/6.6: [146e25625378f7d4463acbd1ffbd975f3332a806]

CVE-2025-40016: media: uvcvideo: Mark invalid entities with id
UVC_INVALID_ENTITY_ID

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [983a1d327e2642832a43f969761e27339b0d2a8f]
stable/6.1: [59f64514bc347d0e93b70c6b612ad824b63ae7ca]

CVE-2025-40103: smb: client: Fix refcount leak for cifs_sb_tlink

stable/5.15 was fixed.

Fixed status
stable/5.15: [d3c8ea197055c260119a13360e8202a27e53e1e4]

CVE-2025-40323: fbcon: Set fb_display[i]->mode to NULL when the mode is released

stable/5.15 was fixed.

Fixed status
stable/5.15: [39c2c1a2773aaf73e56906e5ef670114eb2d354f]

CVE-2025-68206: netfilter: nft_ct: add seqadj extension for natted connections

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [83273af0b60c093ba0085c205864d8542e1b1653]
stable/5.15: [b19492c25eff04852e0cb58f9bb8238b6695ed2d]

CVE-2025-68256: staging: rtl8723bs: fix out-of-bounds read in
rtw_get_ie() parser

stable/5.15 was fixed.

Fixed status
stable/5.15: [9829c6e1b2e4180fd18315252ad6faeab6128076]

CVE-2025-71150: ksmbd: Fix refcount leak when invalid session is found
on session lookup

stable/5.15 was fixed.

Fixed status
stable/5.15: [11fe566b442e3bc2774191740fd377739a87a1c0]

CVE-2026-23031: can: gs_usb: gs_usb_receive_bulk_callback(): fix URB memory leak

stable/5.15 was fixed.

Fixed status
stable/5.15: [9c151898cc259a7784be60ba38664f42ede39b31]

CVE-2026-23082: can: gs_usb: gs_usb_receive_bulk_callback(): unanchor
URL on usb_submit_urb() error

stable/5.15 was fixed.

Fixed status
stable/5.15: [da01de754e455e2598a7f1ce4ff2078c4f0ecde1]

CVE-2026-23100: mm/hugetlb: fix hugetlb_pmd_shared()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [8ae48255bcb17b32436be97553dca848730d365f]
stable/5.15: [bf3c2affe245cf831866ddc8f736ae6a22cdc11c]

CVE-2026-23113: io_uring/io-wq: check IO_WQ_BIT_EXIT inside work run loop

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [065dd936195a3466b8ebe5f9287400987ee3c063]
stable/5.15: [27e47500fac23d15b7dc93ff650bc4844d2581bd]

CVE-2026-23155: can: gs_usb: gs_usb_receive_bulk_callback(): fix error message

stable/5.15 was fixed.

Fixed status
stable/5.15: [7a431df418ee6b79841e0b4c7c265a791e3d0a75]

CVE-2026-23220: ksmbd: fix infinite loop caused by
next_smb2_rcv_hdr_off reset in error paths

stable/5.15 was fixed.

Fixed status
stable/5.15: [544adb0a6658ea1bff4064723761dbf05f95b1e2]

CVE-2026-23227: drm/exynos: vidi: use ctx->lock to protect struct
vidi_context member variables related to memory alloc/free

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [56966a4cfa925ec24edb68ab652a740a7abe2c4d]
stable/5.15: [9e1ef9396a1899925911b1729cb65665420268df]

CVE-2026-23245: net/sched: act_gate: snapshot parameters with RCU on replace

stable/5.10 was fixed.

Fixed status
stable/5.10: [fc98fd8d214693be91253d9a88cdf8e5e143d124]

CVE-2026-23253: media: dvb-core: fix wrong reinitialization of
ringbuffer on reopen

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [527cfa8a3486b3555c5c15e2f62be484a11398dc]
stable/5.15: [fb378cf89be434ed1f10ab79cc4788fba8ae868d]

CVE-2026-23268: apparmor: fix unprivileged local user can do
privileged policy management

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [a407a078cd41b5261b99d822af784bd9f136eb4d]
stable/5.15: [4cafce4d6d0a66ec27e3af5637c11901d60189fa]
stable/6.1: [33ee909702e047c94aaf41d4eea35626d509802c]

CVE-2026-23269: apparmor: validate DFA start states are in bounds in unpack_pdb

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [f43eea8ae0102ea198da211ef7f5ce83725ecf19]
stable/5.15: [5487871b2b56c19d26936ed6fdc62652b30941df]
stable/6.1: [5443c027ec16afa55b1b8a3e7a1ab2ea3c77767a]

CVE-2026-23270: net/sched: Only allow act_ct to bind to clsact/ingress
qdiscs and shared blocks

stable/5.15 was fixed.

Fixed status
stable/5.15: [bc4e5bb529823a09f02dbe96169de679a9db26e0]

CVE-2026-23274: netfilter: xt_IDLETIMER: reject rev0 reuse of ALARM timer labels

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [32e937dc6e97f5ed3cdfe3fc0b2b19a05e23fa44]
stable/5.15: [144f88054ba0180467356f40895bd660b5dceeec]

CVE-2026-23277: net/sched: teql: fix NULL pointer dereference in
iptunnel_xmit on TEQL slave xmit

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [383493b9940e3d1b5517424081b3e072e20ec43c]
stable/5.15: [6b1f563d670162e188a0f2aec39c24b67b106e17]

CVE-2026-23279: wifi: mac80211: fix NULL pointer dereference in
mesh_rx_csa_frame()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [753ad20dcbe36b67088c7770d8fc357d7cc43e08]
stable/5.15: [f061336f072ab03fd29270ae61fede46bf8fd69d]

CVE-2026-23281: wifi: libertas: fix use-after-free in lbs_free_adapter()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [b15e0fa7adb4de3a03aee9e6fc4d83e5cf0a65e4]
stable/5.15: [09f3c30ab3b1371eaf9676a1b8add57bca763083]

CVE-2026-23286: atm: lec: fix null-ptr-deref in lec_arp_clear_vccs

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [8aff65a82b6389ec674d46e5b3d3ae6f07db5e3e]
stable/5.15: [30c9744a989feb22cfbb84170eb0e038a7a2c1da]

CVE-2026-23289: IB/mthca: Add missed mthca_unmap_user_db() for
mthca_create_srq()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [11ac61f4e9b7c48b0dd44661765e5ace3c441aa3]
stable/5.15: [72fcfd4df46f2ee684c4776664d0cfc6c1746c9a]

CVE-2026-23290: net: usb: pegasus: validate USB endpoints

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [d5d9086211877361f1bda44a0aec538ddb04042a]
stable/5.15: [af7369ae572f53cb701731a4289ec3b3889bc501]

CVE-2026-23291: nfc: pn533: properly drop the usb interface reference
on disconnect

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [6645b030b0c1fc5bf338bffb0044238f24b2f770]
stable/5.15: [5be8aa2bcfb53158436182db8dee9d0b8e5901e6]

CVE-2026-23293: net: vxlan: fix nd_tbl NULL dereference when IPv6 is disabled

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [649e2bb74da54c96cf20729001e283626a2fefa0]
stable/5.15: [dc3e62cf3bbf66280a907ec379f373d0c3b8b2bc]

CVE-2026-23296: scsi: core: Fix refcount leak for tagset_refcnt

stable/5.15 was fixed.

Fixed status
stable/5.15: [0e274674714427dc578bb99db5b86e312d2b57f8]

CVE-2026-23298: can: ucan: Fix infinite loop from zero-length messages

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [ca07d3c6eef14d34e6fdeefe55058db045be29dc]
stable/5.15: [e7bb6e0606b5f233531aaaad9542d69fbb792115]

CVE-2026-23300: net: ipv6: fix panic when IPv4 route references
loopback IPv6 nexthop

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [607e68c1b7c5a30c795571be1906d716e989a644]
stable/5.15: [c11d7c56c2076ee9cd72004f1976fe0734df2ae9]

CVE-2026-23302: net: annotate data-races around sk->sk_{data_ready,write_space}

stable/6.12 was fixed.

Fixed status
stable/6.12: [c494448bb522bbbb63096540eb2319101a0480ab]

CVE-2026-23303: smb: client: Don't log plaintext credentials in
cifs_set_cifscreds

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [e5a3b11e07b335006371915b2da47b6056c9e3bc]
stable/5.15: [54c570de9a35860dfa85fe668f23ddfda8cc7e26]

CVE-2026-23304: ipv6: fix NULL pointer deref in ip6_rt_get_dev_rcu()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [d542e2ac7f9e288d49735be0775611547ca4e0ee]
stable/5.15: [a73fe9f4ae84a239d5b2686f47a58c158aee2eb4]

CVE-2026-23307: can: ems_usb: ems_usb_read_bulk_callback(): check the
proper length of a message

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [aed172a2e2330131f0977d2acd3ec8883f413ec1]
stable/5.15: [f10177e6c4575aedaea580ce67d792fab7a2235e]

CVE-2026-23312: net: usb: kaweth: validate USB endpoints

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [3b5075e4ce97d1a1ce82ff3fb6308761987a48bb]
stable/5.15: [6c986abd2a5033633c6e6f9dd135cf96b19c7fdf]

CVE-2026-23318: ALSA: usb-audio: Use correct version for UAC3 header validation

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [82a7d0a1b88798de1a609130080ce0c65dd869e9]
stable/5.15: [8307d93e63d5f54ef10412d4db2dd551e920dee4]

CVE-2026-23324: can: usb: etas_es58x: correctly anchor the urb in the
read bulk callback

stable/5.15 was fixed.

Fixed status
stable/5.15: [7a0171b4921ad443fee5ed4fcb9d99fa4776edac]

CVE-2026-23330: nfc: nci: complete pending data exchange on device close

stable/6.12 was fixed.

Fixed status
stable/6.12: [702029337b057085ea13f964822dcd95e0fe53f5]

CVE-2026-23335: RDMA/irdma: Fix kernel stack leak in irdma_create_user_ah()

stable/5.15 was fixed.

Fixed status
stable/5.15: [1f70df004fdd944653013ccc2e1dfd472a693b46]

CVE-2026-23336: wifi: cfg80211: cancel rfkill_block work in wiphy_unregister()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [82a35356b5c1f75fe6a8a561db44e8d0e49da8f9]
stable/5.15: [b2e9626a9d16b9bbbd06498c9e73c93be354dc7a]

CVE-2026-23339: nfc: nci: free skb on nci_transceive early error paths

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [b367cb44d919f35b07cd56feffa15e68cd9f53f9]
stable/5.15: [6d898f943766440cf766d30364e715111c3563b5]

CVE-2026-23340: net: sched: avoid qdisc_reset_all_tx_gt() vs dequeue
race for lockless qdiscs

stable/5.15 was fixed.

Fixed status
stable/5.15: [5bb27ad54d12de67e457d7d251198e361bef835e]

CVE-2026-23351: netfilter: nft_set_pipapo: split gc into unlink and
reclaim phase

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [65ca51b9fb85477ab92a04295aed34b38f7c062e]
stable/5.15: [c0f1f85097ac2b6e7d750fe4d05807985cd3fd3a]

CVE-2026-23352: x86/efi: defer freeing of boot services memory

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [7131bd1fecc749bc94fb44aae217bbd8a8a85264]
stable/5.15: [6d8ba221e7aafaa2f284b7d22faee814c28e009d]

CVE-2026-23356: drbd: fix "LOGIC BUG" in drbd_al_begin_io_nonblock()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [933d161baa3794547adee621c0bf52cbf2c1b3cd]
stable/5.15: [cf01aa6288e1190f89865e765056e2a9d8190639]

CVE-2026-23357: can: mcp251x: fix deadlock in error path of mcp251x_open

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [739454057572cb0948658d1142f3fa2c6966465c]
stable/5.15: [416c18ecddafab0ed09be1e7b9d2f448f3d4db16]

CVE-2026-23359: bpf: Fix stack-out-of-bounds write in devmap

stable/5.15 was fixed.

Fixed status
stable/5.15: [88df604f0d16a692867582350ce3f2fcd22243f1]

CVE-2026-23362: can: bcm: fix locking for bcm_op runtime updates

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [0904037e713f787d1376e1d349c3bdf6c3105881]
stable/5.15: [c85b96eaf766d8f066b1139a17a51efa2f6627ef]

CVE-2026-23365: net: usb: kalmia: validate USB endpoints

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [ff675bc5b3e8c356f9d993d65d0bae6ed0dc7459]
stable/5.15: [185050b47df3d41e49f20ad01beea2e7b9cddaa7]

CVE-2026-23367: wifi: radiotap: reject radiotap with unknown bits

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [6f80f6a60f5d87e5de5fb2732751fce799991c24]
stable/5.15: [d1d1d3c50095928624a95b67a6d7ccc3a18f2215]

CVE-2026-23368: net: phy: register phy led_triggers during probe to
avoid AB-BA deadlock

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [2b01518eabace18f7ec8b4cafd52082303080dca]
stable/5.15: [305afdd02ff3e694c165457793104710ec0728e5]

CVE-2026-23370: platform/x86: dell-wmi-sysman: Don't hex dump
plaintext password data

stable/5.15 was fixed.

Fixed status
stable/5.15: [9bbb420f202834363e1e25435e49db0a385c2232]

CVE-2026-23372: nfc: rawsock: cancel tx_work before socket teardown

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [9b2d23cd09e1cb56bdf0e4d5614703094159f16c]
stable/5.15: [cdeed45ce8c92defd057f7d67ee9a69374d8fa16]

CVE-2026-23374: blktrace: fix __this_cpu_read/write in preemptible context

stable/6.12 was fixed.

Fixed status
stable/6.12: [e5584932ac1dacc182c430d09e2b5490d1d4372b]

CVE-2026-23379: net/sched: ets: fix divide by zero in the offload path

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [62015c05878eb9ca448dca7f5a74423d10d40789]
stable/5.15: [a11ec75a029b3a22b5596f98ce91a3be76a86213]

CVE-2026-23381: net: bridge: fix nd_tbl NULL dereference when IPv6 is disabled

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [a9d712ccfeef737c0e700a4b5b98f310e07b6b60]
stable/5.15: [a5c56e65b685360dd3f2278aeff8c21061feb665]

CVE-2026-23382: HID: Add HID_CLAIMED_INPUT guards in raw_event
callbacks missing them

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [b48284d7f0f76023b215a3409cdc989b5081eadf]
stable/5.15: [de316c1edf15bc30ff5e0d4c7b37c70fd41cf319]

CVE-2026-23388: Squashfs: check metadata block offset is within range

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [60f679f643f3f36a8571ea585e4ce5d93ef952b5]
stable/5.15: [3f68a9457a6190814377577374da75f872e0a013]

CVE-2026-23391: netfilter: xt_CT: drop pending enqueued packets on
template removal

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [55445134d42b84cb0a272e42c98d233ca65eca83]
stable/5.15: [cc57506dd66555899560b9c0f24e813f034e12ec]

CVE-2026-23394: af_unix: Give up GC if MSG_PEEK intervened.

stable/6.18 was fixed.

Fixed status
stable/6.18: [72cf49ad50c16270b52bc512d9c2df5743922968]

CVE-2026-23395: Bluetooth: L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [10a7a702542240d5edb2b39450ac951c59ccd009]
stable/5.15: [46e5b71666fb7652082e4e214a3365f4b14f1dc3]

CVE-2026-23396: wifi: mac80211: fix NULL deref in mesh_matches_local()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [14a4fd13657a3f2489db6566f081adfb27a49c64]
stable/5.15: [74de6fa472b03bc8cde0a081484e9960bcbda568]

CVE-2026-23397: nfnetlink_osf: validate individual option lengths in
fingerprints

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [e9cf17b91e733fec725ebcc0b3098bc5ccd505e0]
stable/5.15: [3c11b5c2436a3a5b450612ab160e3a525b28cfb5]

CVE-2026-23398: icmp: fix NULL pointer dereference in icmp_tag_validation()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [571d9d7b650f02d1e38c01128817868bceac9edd]
stable/5.15: [d783fa413c702ff0f8f8bea63f862e28eeaf39e3]

CVE-2026-23401: KVM: x86/mmu: Drop/zap existing present SPTE even when
creating an MMIO SPTE

stable/5.15 was fixed.

Fixed status
stable/5.15: [20656cd1f243d3a154aac5dd1b823110b6906fe1]

CVE-2026-23403: apparmor: fix memory leak in verify_header

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [9d678eb0fe55c9195d9a253e8c5b82a87b930737]
stable/5.15: [6b79abcb3c985e153fcf9d395e1d4336081aabc2]
stable/6.1: [bcf82c0c5a8b383fd2d5d8f3fd880cdcab2ac557]

CVE-2026-23404: apparmor: replace recursive profile removal with
iterative approach

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [ea854f032190cc9f26dc4a0e727090c89e55e342]
stable/5.15: [4fdc847b107321dec22bf8ecd6019b7af76d7886]
stable/6.1: [b36a04284d0208be94e5e401409caa00e2bf1be1]

CVE-2026-23405: apparmor: fix: limit the number of levels of policy namespaces

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [6b396cc2f0365e684fc1d3547d18ef79fcee225d]
stable/5.15: [87d0cecc900e55d55fc4dbfb43ac93e269c7a5b3]
stable/6.1: [b1226e37eb3754d389721c135db6107db94c7a72]

CVE-2026-23406: apparmor: fix side-effect bug in match_char() macro usage

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [c7dc56d8b37eda1396feeec3ab1c7ecee5eae31b]
stable/5.15: [f16f2e5936c0f5f0d11fdf10d2be3e47e7108e42]
stable/6.1: [1fc94f16098213d01e56c97feed9b3ecf0147a37]

CVE-2026-23407: apparmor: fix missing bounds check on DEFAULT table in
verify_dfa()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [555829fd91eaf0711e369b0a92aecb0f0aa3281f]
stable/5.15: [a75e12ca90c9e70ba10fee1be2f63cdd63d91a7c]
stable/6.1: [22094c996968a7c5b59cd3fc9fcbdfdd46d02fec]

CVE-2026-23408: apparmor: Fix double free of ns_name in aa_replace_profiles()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [c6347a2116ecccb8fd9ee4ebc75ae41d1d7ef689]
stable/5.15: [c053ae381ce227577567d1ef10090ce7506d7a28]
stable/6.1: [35f4caec1352054b9a61cfdf2bf1898073637aa0]

CVE-2026-23409: apparmor: fix differential encoding verification

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [ff7c73744fafe944ed9a7b2b7cf6c8d5557a3d84]
stable/5.15: [1439150cd3c411228b387ab5efca92199d2a659a]
stable/6.1: [0fab44285445e9012674396d5c1236a67da518e0]

CVE-2026-23410: apparmor: fix race on rawdata dereference

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [3b8e77c7abab40e6de9ad9de730d77984a498840]
stable/5.15: [d9d8560b9b7932f8cffc4c068c14289220900f79]
stable/6.1: [6b6ba87579c7e7c669e0bec91823e7fb693bc5df]

CVE-2026-23411: apparmor: fix race between freeing data and fs accessing it

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [a92c5e5086a87d082696245a8607666da3d80554]
stable/5.15: [667df93769c02ff581c77d2d8f162147e719c557]
stable/6.1: [3ddb961d2929bbb3204a2bba21b5d8153cd3f7cc]

CVE-2026-23420: wifi: wlcore: Fix a locking bug

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [4ae8faf31b24c78653f4433298ee52813a56967a]
stable/5.15: [fc404390a386404cf9822d4091ccae1f61efcbcd]

CVE-2026-23422: dpaa2-switch: Fix interrupt storm after receiving bad
if_id in IRQ handler

stable/5.15 was fixed.

Fixed status
stable/5.15: [7def51cb9fb8b8d5342443372b8cf28d8fbd7f3d]

CVE-2026-23428: ksmbd: fix use-after-free of share_conf in compound request

stable/5.15 was fixed.

Fixed status
stable/5.15: [d08417981155883068b7260d9500ca306a03edac]

CVE-2026-23434: mtd: rawnand: serialize lock/unlock against other NAND
operations

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [28ea836cc44cb8b89c1c174707ead0c1133c60e9]
stable/5.15: [fe4a73c3dd48308149d57a10c2761e1d36ced7ba]

CVE-2026-23438: net: mvpp2: guard flow control update with
global_tx_fc in buffer switching

stable/5.15 was fixed.

Fixed status
stable/5.15: [0cfcd31f98fc608dc9406bff3fee3a9dd364d014]

CVE-2026-23439: udp_tunnel: fix NULL deref caused by udp_sock_create6
when CONFIG_IPV6=n

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [dfc96ae0074cc47b5478a59e5aa19233e434243f]
stable/5.15: [66117dbb3dbae82f86735bf727b1d59cc677afa1]

CVE-2026-23443: ACPI: processor: Fix previous acpi_processor_errata_piix4() fix

stable/5.15 was fixed.

Fixed status
stable/5.15: [68408e8f9e366ad9850a66ac65cb569f13bf6cd4]

CVE-2026-23446: net: usb: aqc111: Do not perform PM inside suspend callback

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [cc06ac99fd78839b2d38850785731ef131d9ae26]
stable/5.15: [b87f361d41f9a7f1f6c426947ca815651c481376]

CVE-2026-23450: net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()

stable/5.15 was fixed.

Fixed status
stable/5.15: [f315277856caeafcd996c2611afc085ca2d53275]

CVE-2026-23452: PM: runtime: Fix a race condition related to device removal

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [20f6e2e22a9c6234113812d5f300d3e952a82721]
stable/5.15: [b6dd1a562ca8ba96c8ecb247c62b73f9fa02d47e]

CVE-2026-23454: net: mana: fix use-after-free in
mana_hwc_destroy_channel() by reordering teardown

stable/5.15 was fixed.

Fixed status
stable/5.15: [b88edf12fc3779521ae5f6f1584153b15f7da6df]

CVE-2026-23455: netfilter: nf_conntrack_h323: check for zero length in
DecodeQ931()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [2121f5fbe88daff0f1fc5bc47d359426c74b86b0]
stable/5.15: [65fa92f79677858b14b9e4b7275f26639afe2710]

CVE-2026-23456: netfilter: nf_conntrack_h323: fix OOB read in
decode_int() CONS case

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [a2cd54b9348e485d338b3c132338a4410c99afaf]
stable/5.15: [c95dc674ebf01ecfb40388b6facfc89b81fed3b7]

CVE-2026-23457: netfilter: nf_conntrack_sip: fix Content-Length u32
truncation in sip_help_tcp()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [ed81b6a7012485acdb9c6c80735a0b7d8e5e1873]
stable/5.15: [cd1b7403ec835f8a0b3f1f7e68ac26af2cb1e42f]

CVE-2026-23458: netfilter: ctnetlink: fix use-after-free in
ctnetlink_dump_exp_ct()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [d8cd0efbccc5cfb0a80da744a7da76e1333ab925]
stable/5.15: [9821b47f669eb82791fa0b1a6ebaf9aa219bea72]

CVE-2026-23460: net/rose: fix NULL pointer dereference in
rose_transmit_link on reconnect

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [c85fe6580e86947ca07907ebf4363a73c156fda7]
stable/5.15: [a753844d2a8136f090123c8fb1ff6c7f6ee7c2b3]

CVE-2026-23462: Bluetooth: HIDP: Fix possible UAF

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [d955ccbf91ab74d76fe9e4eab2846a7d8a173075]
stable/5.15: [18b1263ece6431bd78fa6b61faaef5281203741c]

CVE-2026-23463: soc: fsl: qbman: fix race condition in qman_destroy_fq

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [66442cf9989bd4489fa80d9f37637d58ab016835]
stable/5.15: [d288fbe652ef43b7128e4bc0c0c2ef6bd03a2210]

CVE-2026-23474: mtd: Avoid boot crash in RedBoot partition table parser

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [ca235d11fc2fd8fce1dcd9d732dc780be0cde2de]
stable/5.15: [e0065e106f798ce6862251bc4fc030ac5cead940]

CVE-2026-31391: crypto: atmel-sha204a - Fix OOM ->tfm_count leak

stable/5.10 was fixed.

Fixed status
stable/5.10: [c2d0c45dbb9eb272385ae919b17eef5a5318d3f8]

CVE-2026-31393: Bluetooth: L2CAP: Validate L2CAP_INFO_RSP payload
length before access

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [187e6fe939295be36063a1d91f8bebee04399a8c]
stable/5.15: [5229e7d15771eac2b5886bfb1f976aea0c1eec14]

CVE-2026-31396: net: macb: fix use-after-free access to PTP clock

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [8820ffe0975fd2efbe50453e9179c8e1c33a13d3]
stable/5.15: [6b757f345eeea87ed5d8afd6de35b927a1a57a2f]

CVE-2026-31399: nvdimm/bus: Fix potential use after free in
asynchronous initialization

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [6fc36c2a925ceaba203eb13d75a8f0879a2c121b]
stable/5.15: [a36cf138500e56f50db9f9a33222df6969b38326]

CVE-2026-31400: sunrpc: fix cache_request leak in cache_release

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [1dfedb293943e491379c9302b428e6f920a73d12]
stable/5.15: [f18c1f2a88ca91357916997cdb0f7adaf14fc497]

CVE-2026-31402: nfsd: fix heap overflow in NFSv4.0 LOCK replay cache

stable/5.10 was fixed.

Fixed status
stable/5.10: [f9fcb4441f6c02bb20c2eb340101e27dfe23607c]

CVE-2026-31403: NFSD: Hold net reference for the lifetime of
/proc/fs/nfs/exports fd

stable/5.10 was fixed.

Fixed status
stable/5.10: [76740c28050dc6db2f5550f1325b00a11bbb3255]

CVE-2026-31405: media: dvb-net: fix OOB access in ULE extension header tables

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [e51238718217c4abdb3ccc3b0c0cde265c7ec629]
stable/5.15: [b2bd2ee73b697c177157bba534e1b1064c2e66a0]

CVE-2026-31408: Bluetooth: SCO: Fix use-after-free in sco_recv_frame()
due to missing sock_hold

stable/5.15 was fixed.

Fixed status
stable/5.15: [d57384e27d1ebf0047e3f00a6e1181b8be9857a2]

CVE-2026-31415: ipv6: avoid overflows in ip6_datagram_send_ctl()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [2dbfb003bbf3fc0e94f07efefab0ebcf83029a2a]
stable/5.15: [4082f9984a694829153115d28c956a3534f52f29]

CVE-2026-31416: netfilter: nfnetlink_log: account for netlink header size

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [4ec216410fac9de83c99177a160ebb8d42fad075]
stable/5.15: [09883bf257f4243ed5a1fd35078ec6f0d0f3696a]

CVE-2026-31417: net/x25: Fix overflow when accumulating packets

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [96fc16370b0bceb289c7e0479bd0540b81e257aa]
stable/5.15: [798d613afb64b01a203f448fb0f43c37c6afe79d]

CVE-2026-31418: netfilter: ipset: drop logically empty buckets in mtype_del

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [c098ff857e7ca923539164af5b3c2fe3e8f8afaf]
stable/5.15: [58f3a14826d4e6b0d5421f1a64be280b48601ea2]

CVE-2026-31421: net/sched: cls_fw: fix NULL pointer dereference on shared blocks

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [d6d5bd62a09650856e1e2010eb09853eba0d64e1]
stable/5.15: [febf64ca79a2d6540ab6e5e197fa0f4f7e84473e]

CVE-2026-31422: net/sched: cls_flow: fix NULL pointer dereference on
shared blocks

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [57f94ac7e953eece5ed4819605a18f3cdfc63dcc]
stable/5.15: [942813276edeb1741fa5b0a73471beb4e495fa08]

CVE-2026-31423: net/sched: sch_hfsc: fix divide-by-zero in rtsc_min()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [ad8e8fec40290a8c8cf145c0deaadf76f80c5163]
stable/5.15: [ab1ff5890c7354afc7be56502fcfbd61f3b7ae4f]

CVE-2026-31424: netfilter: x_tables: restrict
xt_check_match/xt_check_target extensions for NFPROTO_ARP

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [80e3c75f71c3ea1e62fcb032382de13e00a68f8b]
stable/5.15: [d9a0af9e43416aa50c0595e15fa01365a1c72c49]

CVE-2026-31425: rds: ib: reject FRMR registration before IB connection
is established

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [c506456ebf84c50ed9327473d4e9bd905def212b]
stable/5.15: [82e4a3b56b23b844802056c9e75a39d24169b0a4]

CVE-2026-31427: netfilter: nf_conntrack_sip: fix use of uninitialized
rtp_addr in process_sdp

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [faa6ea32797a1847790514ff0da1be1d09771580]
stable/5.15: [82baeb871e8f04906bc886273fdf0209e1754eb3]

CVE-2026-31428: netfilter: nfnetlink_log: fix uninitialized padding
leak in NFULA_PAYLOAD

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [7f3e5d72455936f42709116fabeca3bb216cda62]
stable/5.15: [21d8efda029948d3666b0db5afcc0d36c0984aae]

CVE-2026-31788:

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [4eb245ff0d33b618e097a2c23de5df56d4ad6969,
9149cb2da15fcbc0080b91af795afabdd5ee90d4]
stable/5.15: [3ee5b9e3de4b8bdd74183d83205481c91a9effc8,
a5ea87cc1a2ec9dd9862080b3e530ddd8a995238]

CVE-2025-21709: kernel: be more careful about dup_mmap() failures and
uprobe registering

stable/6.12 was fixed.

Fixed status
stable/6.12: [74c2471eb891a7dcb3874b21c106cda75f52be30]

CVE-2026-22986: gpiolib: fix race condition for gdev->srcu

stable/6.12 was fixed.

Fixed status
stable/6.12: [1ef731547dfd73f466c5d0e52801b97191d4647f]

CVE-2026-23442: ipv6: add NULL checks for idev in SRv6 paths

stable/6.12 was fixed.

Fixed status
stable/6.12: [bc9843c39f9932a8b36efd1d362ea00bb88e4e78]

CVE-2026-31407: netfilter: conntrack: add missing netlink policy validations

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [9174d28f3f15d8c4962f5980c0be167633880443]
stable/6.18: [67c53c1978cef3c504237275e39c857e2f6af56e]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com


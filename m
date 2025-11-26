Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8614DD111A7
	for <webhook@archiver.kernel.org>; Wed, 26 Nov 2025 23:02:22 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6701.1764198140308178509
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Nov 2025 15:02:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=KwnxK83O;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.177, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-787da30c53dso3106447b3.0
        for <cip-dev@lists.cip-project.org>; Wed, 26 Nov 2025 15:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1764198139; x=1764802939; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ywiN1S9hRaBcDiYqZrnZayJxFJQJ4hSWdRqZIoFYPN8=;
        b=KwnxK83ONVxSJJo1o+1G36+Bra3fDMrfiVjDnLKyK4eQIo7mIwE00vXTlobrhIIaU1
         9aUlDexlmeBJMfcYvQb70EP6v4NCHy6WobXSGQ+vvf8FRsxEwSX+p3KlFay5STwi4zuz
         HrjkfRMcLi7J/di9AFF+dNYmt+Xl3eIAH9d+6CrCl27eUdgZWnh5zjMgfuX0kMS1w5QU
         3juHPPk5KHlq0X17CRH4X0OoyqALv6vAe66srYGIVKeH6Vhgi9yf6TGnnfSfIVWHjbzB
         30YbhMK/GFv+e5UvzJ8VUOfUtkjF6Gpdm0BWb31uz+8ai9oirktfT9fvAri7Pwn2cppe
         mrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764198139; x=1764802939;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywiN1S9hRaBcDiYqZrnZayJxFJQJ4hSWdRqZIoFYPN8=;
        b=vxGeSFgzFj5UaHuVNhddOEyGKsSnl3u28xMoY7RLJ70zsL21Scoom/OZs6NZphrhUu
         goHPqYSrE0CAZmYIRg1IRzHReRH8JCla4Jj7ckoAIGNEFk0NPHQ2IUyOQCeT+cClMwkT
         wgJc1QJiGYXvM2tc+/kWlg22IEJg1vQE0cCqUW/D0EHwhpFvqgL5y1rOneb7dDxJYj9y
         rbYc2/ulr5EBj0tLH3OEL/Gflr1g6bcRnbE+jCHU/fZqwQzP1NGvJNdTpAjm/fSno2OD
         WgMPT43SwolaXL5msZmSpyHfX3tG40h2y8Im4NbjcfkFnV9oLQOpkBRwaGc6MsqClCMV
         cKpA==
X-Gm-Message-State: AOJu0YywKt9aiH6sm8g/OD0mduVK3R6pW6kL34rGB7S/illxxl9bx8YN
	TfAz3W6d8+FHmw2wJg2UqYRS/8K3kDiRrACKWQlTLlpyFuGt/0M0JKOtRyZIPS+y2m9HQsfD9DI
	zwf3UiCsP0iB4e5YFQOknGK6KYILcyrFzNuIwkwlCfaFdraoxc44zzfM=
X-Gm-Gg: ASbGnctkbd7K65Od0WzynOyu+dEd09JAEEcKwXaAfRXi7GGNixs6NcyP1f9r1Hxsb1p
	JX4ENi2vgmHKCYvcUhjJ6VaXaY2G1OPejW9LUkvAPxUQSHVQmR+HzuTDZkIc6v5KKD+vZ7v2SVi
	px/6I618w+lYYOVT4OCAv2fWOmVMyd8Uh9OVbjmv2eZo73+8Fz9pcn09eDkXaz6Bn1zQUczg82J
	v3TK5WYVs5HA8OXFmITm5GF48g5BkU/vvQxzV3Sk6reRfIR7SaldQp5JmLpJdjfNdH6bRE1
X-Google-Smtp-Source: AGHT+IHEVXw+8w9kqNKCf503bp7OEbe0UBPUy9UmmIZnOXNqcJRzCU6Jg8tT/yPOMNK1ZGLkj915InB38wEeovz1R0o=
X-Received: by 2002:a05:690c:4985:b0:78a:27a9:d471 with SMTP id
 00721157ae682-78a8b568025mr143035677b3.69.1764198139083; Wed, 26 Nov 2025
 15:02:19 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 27 Nov 2025 08:01:43 +0900
X-Gm-Features: AWmQ_blyEKt1yPRIoXYURqTpZx-gdF3n4BJiAuJxSgFNWq2mDRP8RANheEtgDvg
Message-ID: <CAODzB9qRnpnW585bide=GPr5q1c6SQYrQs6zWozR1gp15+sMCQ@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Nov 2025 23:02:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20734

Hi!

It's this week's CVE report.

This week reported 5 new CVEs and 14 updated CVEs.

* New CVEs

* New CVEs
CVE-2025-40209: btrfs: fix memory leak of qgroup_list in
btrfs_add_qgroup_relation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40209

Introduced by commit 4addc1f ("btrfs: qgroup: preallocate memory
before adding a relation") in v6.11-rc1.
Fixed in v6.18-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f260c6aff0b8af236084012d14f9f1bf792ea883]
stable/6.12: [3412d0e973e8f8381747d69033eda809a57a2581]

CVE-2025-40210: Revert "NFSD: Remove the cap on number of operations
per NFSv4 COMPOUND"

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40210

Introduced commit is not determined.Fixed in v6.18-rc4.
According to the commit log, this commit reverts 48aab16 ("NFSD:
Remove the cap on number of operations per NFSv4 COMPOUND").

Fixed status
mainline: [3e7f011c255582d7c914133785bbba1990441713]

CVE-2025-40211: ACPI: video: Fix use-after-free in
acpi_video_switch_brightness()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40211

Introduced by commit 8ab58e8 ("ACPI / video: Fix backlight taking 2
steps on a brightness up/down keypress") in v3.17-rc1.
Fixed in v6.18-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8f067aa59430266386b83c18b983ca583faa6a11]
stable/6.12: [de5fc93275a4a459fe2f7cb746984f2ab3e8292a]
stable/6.6: [4e85246ec0d019dfba86ba54d841ef6694f97149]

CVE-2025-40212: nfsd: fix refcount leak in nfsd_set_fh_dentry()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40212

Introduced by commit ef7f6c4 ("nfsd: move V4ROOT version check to
nfsd_set_fh_dentry()") in v6.12-rc1.
Fixed in v6.18-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a7348a9ed70bda1c1f51d3f1815bcbdf9f3b38c]
stable/6.12: [b6bc86ce3944b10b9fc181fc00c1a520a20ed965]

CVE-2025-40213: Bluetooth: MGMT: fix crash in set_mesh_sync and
set_mesh_complete

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40213

Introduced by commit 302a1f6 ("Bluetooth: MGMT: Fix possible UAFs") in v6.17.
Fixed in v6.18-rc4.

Bug introduced commit was backported to following branches.
stable/6.12

Fixed status
mainline: [e8785404de06a69d89dcdd1e9a0b6ea42dc6d327]
stable/6.12: [5c19daa93d9af29f1f46251b47e1ea66bcc8d679]



* Updated CVEs

CVE-2024-41033: cachestat: do not flush stats in recency check

stable/6.6 was fixed.

Fixed status
stable/6.6: [e2f7c76758be16f1dc32c5a82270d4f6649eedab]

CVE-2024-49998: net: dsa: improve shutdown sequence

stable/6.6 was fixed.

Fixed status
stable/6.6: [2e93bf719462ac6d23c881c8b93e5dc9bf5ab7f5]

CVE-2025-21868: net: allow small head cache usage with large
MAX_SKB_FRAGS values

stable/6.6 was fixed.

Fixed status
stable/6.6: [ed8a77fee4618facd2a539cad7b7366697b5a575]

CVE-2025-22103: net: fix NULL pointer dereference in l3mdev_l3_rcv

stable/6.6 was fixed.

Fixed status
stable/6.6: [52b44d8c653459c658b733d13658afdde45f6836]

CVE-2025-22107: net: dsa: sja1105: fix kasan out-of-bounds warning in
sja1105_table_delete_entry()

stable/6.12 was fixed.

Fixed status
stable/6.12: [031e00249e9e6bee72ba66701c8f83b45fc4b8a2]

CVE-2025-22121: ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()

stable/6.12 was fixed.

Fixed status
stable/6.12: [098927a13fd918bd7c64c2de905350a1ad7b4a3a]

CVE-2025-23129: wifi: ath11k: Clear affinity hint before calling
ath11k_pcic_free_irq() in error path

stable/6.12 was fixed.

Fixed status
stable/6.12: [80dc5a2ce5b75d648e08549617f5c555d07ae43c]

CVE-2025-23155: net: stmmac: Fix accessing freed irq affinity_hint

stable/6.6 was fixed.

Fixed status
stable/6.6: [960dab23f6d405740c537d095f90a4ee9ddd9285]

CVE-2025-38057: espintcp: fix skb leaks

stable/6.6 was fixed.

Fixed status
stable/6.6: [d8d79cf8c2b7475c22f9874eb844bcc80f858b13]

CVE-2025-38593: Bluetooth: hci_sync: fix double free in
'hci_discovery_filter_clear()'

stable/6.6 was fixed.

Fixed status
stable/6.6: [7ce9bb0b95fc280e9212b8922590c492ca1d9c39]

CVE-2025-38678: netfilter: nf_tables: reject duplicate device on updates

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [cf23d531a9d496863aa4c5a0e2f71f0a23f3df3c]
stable/6.6: [3f358a66a04513311668ea4b40f5064e253d8386]

CVE-2025-39981: Bluetooth: MGMT: Fix possible UAFs

stable/6.12 was fixed.

Fixed status
stable/6.12: [d71b98f253b079cbadc83266383f26fe7e9e103b]

CVE-2025-40077: f2fs: fix to avoid overflow while left shift operation

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [0e75a098b0a37f02ca31fe99ac16004c8163cf67]
stable/6.6: [ef49378864bb1ed14cd48c8e687729e12714d849]

CVE-2025-40097: ALSA: hda: Fix missing pointer check in
hda_component_manager_init function

stable/6.12 was fixed.

Fixed status
stable/6.12: [218a8504e62fc2c8a1fd12523346b7a2b9bd2474]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com


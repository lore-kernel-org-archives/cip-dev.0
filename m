Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D25FC5475B
	for <webhook@archiver.kernel.org>; Thu,  7 Mar 2024 03:08:57 +0000 (UTC)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
 by mx.groups.io with SMTP id smtpd.web10.14695.1709780927669146979
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Mar 2024 19:08:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=09jw+M8m;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.43, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-21f0c82e97fso191740fac.2
        for <cip-dev@lists.cip-project.org>; Wed, 06 Mar 2024 19:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1709780927; x=1710385727; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4sHGUukXdk/ZE9nuUr4KQRDEk+37togOFhBFGE2JEN4=;
        b=09jw+M8mLaC8WXD7Dpm16tKA8UeanghkNMudLOP05DByxv9aCP09mJv8/PhvRnit8h
         AFl5D14GE9eSVauEYRTKPC0eJXn4vLEf7QxRz6XDArwdJJ/a6VpjtBN1V+Kqqt5WJ7Y3
         zKEvjnHCw5e0e85lF/SbeJogPEYCcaOtfhe+0PWJ6RpNVrr3dIMmBM74PpF7nWKa4Tb/
         bG+FBTGT4tblU4F3uHahFa0t6j8asTUnbwYlrr/hrF5Di9is+sivt/mMAuEBZ/59tgWi
         drFxvakLJtIiZEt1fSYaAa3JJnSkEeUZ/HqxOELUIYH2UnQsCtzz71tPtuGfzkFnvdMx
         mGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709780927; x=1710385727;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4sHGUukXdk/ZE9nuUr4KQRDEk+37togOFhBFGE2JEN4=;
        b=eEmyql5cImJ0b46ctXmexq75oe/xpZKbO4avqBehK1BLBl9HHnKu9aYa8HrwAc8SYC
         OBKe51VvsEmU9YLkOowa4QF0OFYAWNdzrF74w2zoWwqYS2k15NCUk6gELBnJvd+D3Xuz
         SUTF3l/vUUGRtEfYiYA8lZNlDs7UV0s6RHnKelMHGSgkJ2m7B6aSva5XfjkPrQgJeQg/
         F8aHzUwjDCxZI9Pur8cHl9x/MCdhyVSD+PKg2dJomElv5sEa5V82FxlnU2hN76gSFQUz
         MRYPJ4QCiuxzEPZ5+k+ycFmioM4usvCMgIs7rtTXlsmG8Z1XNg19lL7K0U1uN/suEKcR
         ASQg==
X-Gm-Message-State: AOJu0Yw+FgCbjpKqo1VBAnZZMSxfMxDvV7AmnjAVwS00B11Kri7D7cP7
	Sae5OdlNFatyA5G69CG3hFkAJx803P1dYtvPkyQWSEJfxvzklPewEnyIJcne3/zZ3YMGbI3RTFh
	T+VovrXlHo2z5n6Pl9kxJmVGcqovFlPnxVlG4JBQ7PXH3zp+91E0=
X-Google-Smtp-Source: AGHT+IEA7HZxCoLKGSLYeOBZGMNa87e4Sq8xoUkoC85LHJXEbQPW33thpaMkO8HqqngfUcoLIPP4eKShtLwAIUkq+SI=
X-Received: by 2002:a05:6870:f14a:b0:21e:7751:312c with SMTP id
 l10-20020a056870f14a00b0021e7751312cmr7344475oac.30.1709780924183; Wed, 06
 Mar 2024 19:08:44 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 7 Mar 2024 12:08:07 +0900
Message-ID: <CAODzB9q9m4YpyjagOXCjpbydgBnOuBw7XU0OuQfpASWzzFDRsA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Mar 2024 03:08:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15250

Hi!

It's this week's CVE report.

This week reported 277 new CVEs and 10 updated CVEs.

* New CVEs

CVE-2020-36779: i2c: stm32f7: fix reference leak when pm_runtime_get_sync fails

Announce: https://lore.kernel.org/linux-cve-announce/2024022819-CVE-2020-36779-9f1e@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ea6dd25 ("i2c: stm32f7: add PM_SLEEP
suspend/resume support") in 5.6-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [2c662660ce2bd3b09dae21a9a9ac9395e1e6c00b]
stable/5.10: [c323b270a52a26aa8038a4d1fd9a850904a41166]

CVE-2020-36778: i2c: xiic: fix reference leak when pm_runtime_get_sync fails

Announce: https://lore.kernel.org/linux-cve-announce/2024022817-CVE-2020-36778-48a5@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 10b1700 ("i2c: xiic: Fix the clocking across bind
unbind") in 5.6-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [a85c5c7a3aa8041777ff691400b4046e56149fd3]
stable/5.10: [c977426db644ba476938125597947979e8aba725]

CVE-2020-36780: i2c: sprd: fix reference leak when pm_runtime_get_sync fails

Announce: https://lore.kernel.org/linux-cve-announce/2024022820-CVE-2020-36780-9637@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8b9ec07 ("i2c: Add Spreadtrum I2C controller
driver") in 4.14-rc1.
Linux 4.4 is not affected.
Fixed in 5.13-rc1.

Fixed status
mainline: [a85c5c7a3aa8041777ff691400b4046e56149fd3]
stable/5.10: [c977426db644ba476938125597947979e8aba725]

CVE-2020-36781: i2c: imx: fix reference leak when pm_runtime_get_sync fails

Announce: https://lore.kernel.org/linux-cve-announce/2024022820-CVE-2020-36781-d70c@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3a5ee18 ("i2c: imx: implement master_xfer_atomic
callback") in 5.7-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.7-rc1.

Fixed status
mainline: [47ff617217ca6a13194fcb35c6c3a0c57c080693]
stable/5.10: [3a0cdd336d92c429b51a79bf4f64b17eafa0325d]

CVE-2020-36782: i2c: imx-lpi2c: fix reference leak when
pm_runtime_get_sync fails

Announce: https://lore.kernel.org/linux-cve-announce/2024022820-CVE-2020-36782-e7d8@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 13d6eb2 ("i2c: imx-lpi2c: add runtime pm
support") in 4.16-rc1.
Linux 4.4 is not affected.
Fixed in 5.13-rc1.

Fixed status
mainline: [278e5bbdb9a94fa063c0f9bcde2479d0b8042462]
stable/5.10: [cc49d206414240483bb93ffa3d80243e6a776916]
stable/5.4: [815859cb1d2302e74f11bf6894bceace9ca9eb4a]

CVE-2020-36783: i2c: img-scb: fix reference leak when pm_runtime_get_sync fails

Announce: https://lore.kernel.org/linux-cve-announce/2024022820-CVE-2020-36783-8372@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 93222bd ("i2c: img-scb: Add runtime PM") in 4.15-rc1.
Linux 4.4 is not affected.
Fixed in 5.13-rc1.

Fixed status
mainline: [223125e37af8a641ea4a09747a6a52172fc4b903]
stable/5.10: [e80ae8bde41266d3b8bf012460b6593851766006]
stable/5.4: [4734c4b1d9573c9d20bbc46cf37dde095ee011b8]

CVE-2020-36784: i2c: cadence: fix reference leak when pm_runtime_get_sync fails

Announce: https://lore.kernel.org/linux-cve-announce/2024022821-CVE-2020-36784-a266@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7fa3232 ("i2c: cadence: Move to sensible power
management") in 4.5-rc1.
Linux 4.4 is not affected.
Fixed in 5.13-rc1.

Fixed status
mainline: [23ceb8462dc6f4b4decdb5536a7e5fc477cdf0b6]
stable/5.10: [30410519328c94367e561fd878e5f0d3a0303585]

CVE-2020-36785: media: atomisp: Fix use after free in
atomisp_alloc_css_stat_bufs()

Announce: https://lore.kernel.org/linux-cve-announce/2024022821-CVE-2020-36784-a266@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ad85094 ("Revert "media: staging: atomisp: Remove
driver"") in 5.8-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [ba11bbf303fafb33989e95473e409f6ab412b18d]
stable/5.10: [d218c7a0284f6b92a7b82d2e19706e18663b4193]

CVE-2020-36787: media: aspeed: fix clock handling logic

Announce: https://lore.kernel.org/linux-cve-announce/2024022821-CVE-2020-36787-7efe@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d2b4387 ("media: platform: Add Aspeed Video
Engine driver") in 5.0-rc1 and
d3d04f6 ("clk: Add support for AST2600 SoC") 5.4-rc1.
Linux 4.x is not affected.
Fixed in 5.13-rc1.

Fixed status
mainline: [3536169f8531c2c5b153921dc7d1ac9fd570cda7]
stable/5.10: [a59d01384c80a8a4392665802df57c3df20055f5]
stable/5.4: [1dc1d30ac101bb8335d9852de2107af60c2580e7]

CVE-2021-46984: kyber: fix out of bounds access when preempted

Announce: https://lore.kernel.org/linux-cve-announce/2024022824-CVE-2021-46984-e55e@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a608884 ("block: kyber: make kyber more friendly
with merging") in 4.18-rc1.
Linux 4.4 is not affected.
Fixed in 5.13-rc2.

Fixed status
mainline: [efed9a3337e341bd0989161b97453b52567bc59d]
stable/5.10: [54dbe2d2c1fcabf650c7a8b747601da355cd7f9f]
stable/5.4: [0b6b4b90b74c27bea968c214d820ba4254b903a5]

CVE-2021-46985: ACPI: scan: Fix a memory leak in an error handling path

Announce: https://lore.kernel.org/linux-cve-announce/2024022824-CVE-2021-46985-4dad@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit eb50aaf ("ACPI: scan: Use unique number for
instance_no") in 5.12-rc5.
This commit is backported to 5.10, 5.4, and 4.19. Linux 4.4 is not affected.
Fixed in 5.13-rc2.

Fixed status
mainline: [0c8bd174f0fc131bc9dfab35cd8784f59045da87]
stable/4.19: [69cc821e89ce572884548ac54c4f80eec7a837a5]
stable/5.10: [e2381174daeae0ca35eddffef02dcc8de8c1ef8a]
stable/5.4: [dafd4c0b5e835db020cff11c74b4af9493a58e72]

CVE-2021-46986: usb: dwc3: gadget: Free gadget structure only after
freeing endpoints

Announce: https://lore.kernel.org/linux-cve-announce/2024022824-CVE-2021-46986-1d6e@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e81a701 ("usb: dwc3: allocate gadget structure
dynamically") in 5.10-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc2.

Fixed status
mainline: [bb9c74a5bd1462499fe5ccb1e3c5ac40dcfa9139]
stable/5.10: [1ea775021282d90e1d08d696b7ab54aa75d688e5]

CVE-2021-46987: btrfs: fix deadlock when cloning inline extents and
using qgroups

Announce: https://lore.kernel.org/linux-cve-announce/2024022825-CVE-2021-46987-f73f@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c6887cd ("Btrfs: don't do nocow check unless we
have to") in 5.9-rc1.
This commit is backported to 5.4. Linux 4.x is not affected.
Fixed in 5.9-rc1.

Fixed status
mainline: [f9baa501b4fd6962257853d46ddffbc21f27e344]

CVE-2021-46988: userfaultfd: release page in error path to avoid BUG_ON

Announce: https://lore.kernel.org/linux-cve-announce/2024022825-CVE-2021-46988-ae47@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cb658a4 ("userfaultfd: shmem: avoid leaking
blocks and used blocks in UFFDIO_COPY") in 4.11-rc4.
Linux 4.4 is not affected.
Fixed in 5.13-rc2.

Fixed status
mainline: [7ed9d238c7dbb1fdb63ad96a6184985151b0171c]
stable/4.19: [07c9b834c97d0fa3402fb7f3f3b32df370a6ff1f]
stable/5.10: [140cfd9980124aecb6c03ef2e69c72d0548744de]
stable/5.4: [b3f1731c6d7fbc1ebe3ed8eff6d6bec56d76ff43]

CVE-2021-46989: hfsplus: prevent corruption in shrinking truncate

Announce: https://lore.kernel.org/linux-cve-announce/2024022825-CVE-2021-46989-8377@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 31651c6 ("hfsplus: avoid deadlock on file
truncation") in 4.19-rc1.
Linux 4.4 is not affected.
Fixed in 5.13-rc2.

Fixed status
mainline: [c3187cf32216313fb316084efac4dab3a8459b1d]
stable/4.19: [52dde855663e5db824af51db39b5757d2ef3e28a]
stable/5.10: [adbd8a2a8cc05d9e501f93e5c95c59307874cc99]
stable/5.4: [c451a6bafb5f422197d31536f82116aed132b72c]

CVE-2021-46990: powerpc/64s: Fix crashes when toggling entry flush barrier

Announce: https://lore.kernel.org/linux-cve-announce/2024022825-CVE-2021-46990-5ab1@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5f68718 ("netfilter: nf_tables: GC transaction
API to avoid race with control plane") in 6.5-rc6.
Fixed in 6.7.

Fixed status
cip/4.4: [8382b15864e5014261b4f36c2aa89723612ee058]
cip/4.4-rt: [8382b15864e5014261b4f36c2aa89723612ee058]
cip/4.4-st: [8382b15864e5014261b4f36c2aa89723612ee058]
mainline: [aec86b052df6541cc97c5fca44e5934cbea4963b]
stable/4.19: [2db22ba4e0e103f00e0512e0ecce36ac78c644f8]
stable/5.10: [d2e3590ca39ccfd8a5a46d8c7f095cb6c7b9ae92]
stable/5.4: [0b4eb172cc12dc102cd0ad013e53ee4463db9508]

CVE-2021-46991: i40e: Fix use-after-free in i40e_client_subtask()

Announce: https://lore.kernel.org/linux-cve-announce/2024022826-CVE-2021-46991-3c16@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7b0b1a6 ("i40e: Disable iWARP VSI PETCP_ENA flag
on netdev down events") in 4.16-rc1.
Linux 4.4 is not affected.
Fixed in 5.13-rc1.

Fixed status
mainline: [38318f23a7ef86a8b1862e5e8078c4de121960c3]
stable/4.19: [c1322eaeb8af0d8985b5cc5fa759140fa0e57b84]
stable/5.10: [829a713450b8fb127cbabfc1244c1d8179ec5107]
stable/5.4: [d718c15a2bf9ae082d5ae4d177fb19ef23cb4132]

CVE-2021-46992: netfilter: nftables: avoid overflows in nft_hash_buckets()

Announce: https://lore.kernel.org/linux-cve-announce/2024022826-CVE-2021-46991-3c16@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0ed6389 ("netfilter: nf_tables: rename set
implementations") in 4.9-rc1.
Linux 4.4 is not affected.
Fixed in 5.13-rc1.

Fixed status
mainline: [a54754ec9891830ba548e2010c889e3c8146e449]
stable/4.19: [efcd730ddd6f25578bd31bfe703e593e2421d708]
stable/5.10: [72b49dd116ca00a46a11d5a4d8d7987f05ed9cd7]
stable/5.4: [c77e2ef18167ad334e27610ced9a7f6af5ec1787]

CVE-2021-46993: sched: Fix out-of-bound access in uclamp

Announce: https://lore.kernel.org/linux-cve-announce/2024022826-CVE-2021-46993-da22@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 69842cb ("sched/uclamp: Add CPU's clamp buckets
refcounting") in 5.3-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [6d2f8909a5fabb73fe2a63918117943986c39b6c]
stable/5.10: [f7347c85490b92dd144fa1fba9e1eca501656ab3]
stable/5.4: [687f523c134b7f0bd040ee1230f6d17990d54172]

CVE-2021-46976: drm/i915: Fix crash in auto_retire

Announce: https://lore.kernel.org/linux-cve-announce/2024022822-CVE-2021-46976-1dd4@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 229007e ("drm/i915: Wrap i915_active in a simple
kreffed struct") in 5.8-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc2.

Fixed status
mainline: [402be8a101190969fc7ff122d07e262df86e132b]
stable/5.10: [805c990a9c54b9451d3daff640b850909c31ab9d]

CVE-2021-46994: can: mcp251x: fix resume from sleep before interface
was brought up

Announce: https://lore.kernel.org/linux-cve-announce/2024022826-CVE-2021-46994-4722@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8ce8c0a ("can: mcp251x: only reset hardware as
required") in 5.5-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [03c427147b2d3e503af258711af4fc792b89b0af]
stable/5.10: [eecb4df8ec9f896b19ee05bfa632ac6c1dcd8f21]

CVE-2021-46995: can: mcp251xfd: mcp251xfd_probe(): fix an error
pointer dereference in probe

Announce: https://lore.kernel.org/linux-cve-announce/2024022827-CVE-2021-46995-6757@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cf8ee6d ("can: mcp251xfd: mcp251xfd_probe(): use
dev_err_probe() to simplify error handling") in 5.12-rc1-dontuse
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [4cc7faa406975b460aa674606291dea197c1210c]

CVE-2021-46996: netfilter: nftables: Fix a memleak from userdata error
path in new objects

Announce: https://lore.kernel.org/linux-cve-announce/2024022827-CVE-2021-46996-0af4@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b131c96 ("netfilter: nf_tables: add userdata
support for nft_object") in 5.10-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [85dfd816fabfc16e71786eda0a33a7046688b5b0]
stable/5.10: [2c784a500f5edd337258b0fdb2f31bc9abde1a23]

CVE-2021-46997: arm64: entry: always set GIC_PRIO_PSR_I_SET during entry

Announce: https://lore.kernel.org/linux-cve-announce/2024022827-CVE-2021-46997-a93c@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2352904 ("arm64: entry: fix non-NMI user<->kernel
transitions") in 5.10-rc7 and
7cd1ea1 ("arm64: entry: fix non-NMI kernel<->kernel transitions") in
5.10-rc7 and
f0cd5ac ("arm64: entry: fix NMI {user, kernel}->kernel transitions")
in 5.10-rc7 and
2a9b3e6 ("arm64: entry: fix EL1 debug transitions") in 5.10-rc7.
These commits are not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [4d6a38da8e79e94cbd1344aa90876f0f805db705]
stable/5.10: [51524fa8b5f7b879ba569227738375d283b79382]

CVE-2021-46998: ethernet:enic: Fix a use after free bug in enic_hard_start_xmit

Announce: https://lore.kernel.org/linux-cve-announce/2024022827-CVE-2021-46998-eda2@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit fb7516d ("enic: add sw timestamp support") in 4.16-rc1.
These commits are not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [643001b47adc844ae33510c4bb93c236667008a3]
stable/4.19: [25a87b1f566b5eb2af2857a928f0e2310d900976]
stable/5.10: [7afdd6aba95c8a526038e7abe283eeac3e4320f1]
stable/5.4: [f7f6f07774091a6ddd98500b85386c3c6afb30d3]

CVE-2021-46999: sctp: do asoc update earlier in sctp_sf_do_dupcook_a

Announce: https://lore.kernel.org/linux-cve-announce/2024022828-CVE-2021-46999-d408@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 145cb2f ("sctp: Fix bundling of SHUTDOWN with
COOKIE-ACK") in 5.7-rc3.
This commit is backported to 5.4 and 4.19. Linux 4.4 is not affected.
Fixed in 5.13-rc1.

Fixed status
mainline: [35b4f24415c854cd718ccdf38dbea6297f010aae]
stable/4.19: [d624f2991b977821375fbd56c91b0c91d456a697]
stable/5.10: [f01988ecf3654f805282dce2d3bb9afe68d2691e]
stable/5.4: [b1b31948c0af44628e43353828453461bb74098f]

CVE-2021-47000: ceph: fix inode leak on getattr error in __fh_to_dentry

Announce: https://lore.kernel.org/linux-cve-announce/2024022828-CVE-2021-47000-981a@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 878dabb ("ceph: don't return -ESTALE if there's
still an open file") in 5.8-rc1.
This commit is backported to 5.4 Linux 4.x is not affected.
Fixed in 5.13-rc1.

Fixed status
mainline: [1775c7ddacfcea29051c67409087578f8f4d751b]
stable/5.10: [bf45c9fe99aa8003d2703f1bd353f956dea47e40]
stable/5.4: [2ad8af2b70e986284050213230428b823b950a38]

CVE-2021-47001: xprtrdma: Fix cwnd update ordering

Announce: https://lore.kernel.org/linux-cve-announce/2024022828-CVE-2021-47001-0e51@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2ae50ad ("xprtrdma: Close window between waking
RPC senders and posting Receives") in 5.5-rc.
This commit is backported to 5.4. Linux 4.x is not affected.
Fixed in 5.13-rc1.

Fixed status
mainline: [35d8b10a25884050bb3b0149b62c3818ec59f77c]
stable/5.10: [eddae8be7944096419c2ae29477a45f767d0fcd4]

CVE-2021-47002: SUNRPC: Fix null pointer dereference in svc_rqst_free()

Announce: https://lore.kernel.org/linux-cve-announce/2024022828-CVE-2021-47002-3946@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5191955 ("SUNRPC: Prepare for xdr_stream-style
decoding on the server-side") in 5.11-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [b9f83ffaa0c096b4c832a43964fe6bff3acffe10]

CVE-2021-47003: dmaengine: idxd: Fix potential null dereference on
pointer status

Announce: https://lore.kernel.org/linux-cve-announce/2024022829-CVE-2021-47003-12d7@gregkh/T/#u

Introduced by commit 89e3bec ("dmaengine: idxd: check device state
before issue command") in 5.11.
This commit is backported to 5.10. Linux 5.4 and 4.x are not affected.
Fixed in 5.13-rc1.

Fixed status
mainline: [28ac8e03c43dfc6a703aa420d18222540b801120]
stable/5.10: [5756f757c72501ef1a16f5f63f940623044180e9]

CVE-2021-46977: KVM: VMX: Disable preemption when probing user return MSRs

https://lore.kernel.org/linux-cve-announce/2024022822-CVE-2021-46977-76be@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4be5341 ("KVM: VMX: Initialize vmx->guest_msrs[]
right after allocation") in 5.5-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc2.

Fixed status
mainline: [5104d7ffcf24749939bea7fdb5378d186473f890]
stable/5.10: [31f29749ee970c251b3a7e5b914108425940d089]

CVE-2021-47004: f2fs: fix to avoid touching checkpointed data in get_victim()

Announce: https://lore.kernel.org/linux-cve-announce/2024022829-CVE-2021-47004-8544@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4354994 ("f2fs: checkpoint disabling") in 4.20-rc1 and
093749e ("f2fs: support age threshold based garbage collection")  5.10-rc1.
These commits are not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [61461fc921b756ae16e64243f72af2bfc2e620db]
stable/5.10: [105155a8146ddb54c119d8318964eef3859d109d]

CVE-2021-47005: PCI: endpoint: Fix NULL pointer dereference for ->get_features()

Announce: https://lore.kernel.org/linux-cve-announce/2024022829-CVE-2021-47005-8f88@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2c04c5b ("PCI: pci-epf-test: Use
pci_epc_get_features() to get EPC features") in 5.1-rc1.
This commit is backported to cip/4.19 and cip/4.19-rt. stable/4.19 and
4.4 are not affected.
Fixed in 5.13-rc1.

Fixed status
mainline: [6613bc2301ba291a1c5a90e1dc24cf3edf223c03]
stable/5.10: [bbed83d7060e07a5d309104d25a00f0a24441428]

CVE-2021-47006: ARM: 9064/1: hw_breakpoint: Do not directly check the
event's overflow_handler hook

Announce: https://lore.kernel.org/linux-cve-announce/2024022829-CVE-2021-47006-3312@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1879445 ("perf/core: Set event's default
::overflow_handler()") in 4.7-rc1.
Linux 4.4 is not affected.
Fixed in 5.13-rc1.

Fixed status
mainline: [a506bd5756290821a4314f502b4bafc2afcf5260]
stable/4.19: [a9938d6d78a238d6ab8de57a4d3dcf77adceb9bb]
stable/5.10: [630146203108bf6b8934eec0dfdb3e46dcb917de]
stable/5.4: [3ed8832aeaa9a37b0fc386bb72ff604352567c80]

CVE-2021-47007: f2fs: fix panic during f2fs_resize_fs()

Announce: https://lore.kernel.org/linux-cve-announce/2024022830-CVE-2021-47007-4d53@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b4b1006 ("f2fs: refactor resize_fs to avoid meta
updates in progress") in 5.8-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [3ab0598e6d860ef49d029943ba80f627c15c15d6]
stable/5.10: [1c20a4896409f5ca1c770e1880c33d0a28a8b10f]

CVE-2021-47008: KVM: SVM: Make sure GHCB is mapped before updating

Announce: https://lore.kernel.org/linux-cve-announce/2024022830-CVE-2021-47008-3dc3@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f1c6366 ("KVM: SVM: Add required changes to
support intercepts under SEV-ES") in 5.11-rc1 and
647daca ("KVM: SVM: Add support for booting APs in an SEV-ES guest")
in 5.11-rc3.
These commits are not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [a3ba26ecfb569f4aa3f867e80c02aa65f20aadad]

CVE-2021-46978: KVM: nVMX: Always make an attempt to map eVMCS after migration

Announce: https://lore.kernel.org/linux-cve-announce/2024022822-CVE-2021-46978-3516@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f2c7ef3 ("KVM: nSVM: cancel
KVM_REQ_GET_NESTED_STATE_PAGES on nested vmexit") in 5.11-rc3.
This commit is backported to 5.10. Linux 5.4 and 4.x are not affected.
Fixed in 5.13-rc2.

Fixed status
mainline: [f5c7e8425f18fdb9bdb7d13340651d7876890329]
stable/5.10: [c8bf64e3fb77cc19bad146fbe26651985b117194]

CVE-2021-46979: iio: core: fix ioctl handlers removal

Announce: https://lore.kernel.org/linux-cve-announce/2024022823-CVE-2021-46979-de90@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8dedcc3 ("iio: core: centralize ioctl() calls to
the main chardev") in 5.11-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc2.

Fixed status
mainline: [901f84de0e16bde10a72d7eb2f2eb73fcde8fa1a]

CVE-2021-46980: usb: typec: ucsi: Retrieve all the PDOs instead of
just the first 4

Announce: https://lore.kernel.org/linux-cve-announce/2024022823-CVE-2021-46980-adda@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 992a60e ("usb: typec: ucsi: register with
power_supply class") in 5.8-rc1 and
4dbc6a4 ("usb: typec: ucsi: save power data objects in PD mode") in 5.8-rc1.
These commits are not backported to older stable kernels.
Fixed in 5.13-rc2.

Fixed status
mainline: [1f4642b72be79757f050924a9b9673b6a02034bc]
stable/5.10: [e5366bea0277425e1868ba20eeb27c879d5a6e2d]

CVE-2021-46981: nbd: Fix NULL pointer in flush_workqueue

Announce: https://lore.kernel.org/linux-cve-announce/2024022823-CVE-2021-46981-0fb9@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e9e006f ("nbd: fix max number of supported devs")
in 5.4-rc1.
This commit is backported to 4.19. Linux 4.4 is not affected.
Fixed in 5.13-rc2.

Fixed status
mainline: [79ebe9110fa458d58f1fceb078e2068d7ad37390]
stable/5.10: [cde4b55cfb24522dcbba80bbdb0c082303e76c43]
stable/5.4: [1c4962df938891af9ab4775f5224ef8601764107]

CVE-2021-46982: f2fs: compress: fix race condition of overwrite vs truncate

Announce: https://lore.kernel.org/linux-cve-announce/2024022823-CVE-2021-46982-5134@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4c8ff70 ("f2fs: support data compression") in 5.6-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc2.

Fixed status
mainline: [a949dc5f2c5cfe0c910b664650f45371254c0744]
stable/5.10: [5639b73fd3bc6fc8ca72e3a9ac15aacaabd7ebff]

CVE-2021-46983: nvmet-rdma: Fix NULL deref when SEND is completed with error

Announce: https://lore.kernel.org/linux-cve-announce/2024022824-CVE-2021-46983-f808@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ca0f1a8 ("nvmet-rdma: use new shared CQ
mechanism") in 5.9-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc2.

Fixed status
mainline: [8cc365f9559b86802afc0208389f5c8d46b4ad61]
stable/5.10: [64f3410c7bfc389b1a58611d0799f4a36ce4b6b5]

CVE-2020-36786: media: [next] staging: media: atomisp: fix memory leak
of object flash

Announce: https://lore.kernel.org/linux-cve-announce/2024022821-CVE-2020-36786-fa2b@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9289cdf ("staging: media: atomisp: Convert to
GPIO descriptors") in 5.10-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [6045b01dd0e3cd3759eafe7f290ed04c957500b1]
stable/5.10: [cc4cc2fb5aaf9adb83c02211eb13b16cfcb7ba64]

CVE-2021-47010: net: Only allow init netns to set default tcp cong to
a restricted algo

Announce: https://lore.kernel.org/linux-cve-announce/2024022830-CVE-2021-47010-6853@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6670e15 ("tcp: Namespace-ify
sysctl_tcp_default_congestion_control") in 4.15-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [8d432592f30fcc34ef5a10aac4887b4897884493]
stable/4.19: [992de06308d9a9584d59b96d294ac676f924e437]
stable/5.10: [6c1ea8bee75df8fe2184a50fcd0f70bf82986f42]
stable/5.4: [9884f745108f7d25b189bbcd6754e284fb29ab68]

CVE-2021-47021: mt76: mt7915: fix memleak when mt7915_unregister_device()

Announce: https://lore.kernel.org/linux-cve-announce/2024022833-CVE-2021-47021-6cbb@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f285dfb ("mt76: mt7915: reset token when
mac_reset happens") in 5.12-rc1-dontuse.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [e9d32af478cfc3744a45245c0b126738af4b3ac4]

CVE-2021-47022: mt76: mt7615: fix memleak when mt7615_unregister_device()

Announce: https://lore.kernel.org/linux-cve-announce/2024022833-CVE-2021-47022-402e@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a6275e9 ("mt76: mt7615: reset token when
mac_reset happens") in 5.12-rc1-dontuse.
This commit is backported to 5.10. Linux 4.19 and 4.4 are not affected.
Fixed in 5.13-rc1.

Fixed status
mainline: [8ab31da7b89f71c4c2defcca989fab7b42f87d71]
stable/5.10: [4fa28c807da54c1d720b3cc12e48eb9bea1e2c8f]

CVE-2021-47023: net: marvell: prestera: fix port event handling on init

Announce: https://lore.kernel.org/linux-cve-announce/2024022833-CVE-2021-47023-118c@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 501ef30 ("net: marvell: prestera: Add driver for
Prestera family ASIC devices") in 5.10-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [333980481b99edb24ebd5d1a53af70a15d9146de]
stable/5.10: [0ce6052802be2cb61a57b753e41301339c88c839]

CVE-2021-47024: vsock/virtio: free queued packets when closing socket

Announce: https://lore.kernel.org/linux-cve-announce/2024022833-CVE-2021-47024-c116@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ac03046 ("vsock/virtio: free packets during the
socket release") in 5.2-rc2.
This commit is backported to 4.19. Linux 4.4 is not affected.
Fixed in 5.13-rc1.

Fixed status
mainline: [8432b8114957235f42e070a16118a7f750de9d39]
stable/5.10: [b605673b523fe33abeafb2136759bcbc9c1e6ebf]

CVE-2021-47025: iommu/mediatek: Always enable the clk on resume

Announce: https://lore.kernel.org/linux-cve-announce/2024022834-CVE-2021-47025-cbd5@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c0b5758 ("iommu/mediatek: Add power-domain
operation") in 5.12-rc1dontuse.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [b34ea31fe013569d42b7e8681ef3f717f77c5b72]

CVE-2021-47026: RDMA/rtrs-clt: destroy sysfs after removing session
from active list

Announce: https://lore.kernel.org/linux-cve-announce/2024022834-CVE-2021-47026-4e19@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6a98d71 ("RDMA/rtrs: client: main functionality")
in 5.8-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [7f4a8592ff29f19c5a2ca549d0973821319afaad]
stable/5.10: [b64415c6b3476cf9fa4d0aea3807065b8403a937]

CVE-2021-47027: mt76: mt7921: fix kernel crash when the firmware fails
to download

Announce: https://lore.kernel.org/linux-cve-announce/2024022834-CVE-2021-47027-4a56@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5c14a5f ("mt76: mt7921: introduce mt7921e
support") in 5.12-rc1dontuse.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [e230f0c44f011f3270680a506b19b7e84c5e8923]

CVE-2021-47028: mt76: mt7915: fix txrate reporting

Announce: https://lore.kernel.org/linux-cve-announce/2024022834-CVE-2021-47028-3a13@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e57b790 ("mt76: add mac80211 driver for MT7915
PCIe-based chipsets") in 5.8-rc1 and
e4c5ead ("mt76: mt7915: rename mt7915_mcu_get_rate_info to
mt7915_mcu_get_tx_rate") in 5.11-rc1.
These commits are not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [f43b941fd61003659a3f0e039595e5e525917aa8]

CVE-2021-47029: mt76: connac: fix kernel warning adding monitor interface

Announce: https://lore.kernel.org/linux-cve-announce/2024022835-CVE-2021-47029-2c85@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d0e274a ("mt76: mt76_connac: create mcu library")
in 5.12-rc1dontuse.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [c996f0346e40e3b1ac2ebaf0681df898fb157f60]

CVE-2021-47030: mt76: mt7615: fix memory leak in mt7615_coredump_work

Announce: https://lore.kernel.org/linux-cve-announce/2024022835-CVE-2021-47030-d1f6@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d2bf795 ("mt76: mt7663: introduce coredump
support") in 5.12-rc1dontuse.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [49cc85059a2cb656f96ff3693f891e8fe8f669a9]

CVE-2021-47011: mm: memcontrol: slab: fix obtain a reference to a freeing memcg

Announce: https://lore.kernel.org/linux-cve-announce/2024022831-CVE-2021-47011-5b75@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3de7d4f ("mm: memcg/slab: optimize objcg stock
draining") in 5.11-rc5.
This commit is backported to 5.10. Linux 5.4 and 4.x are not affected.
Fixed in 5.13-rc1.

Fixed status
mainline: [9f38f03ae8d5f57371b71aa6b4275765b65454fd]
stable/5.10: [31df8bc4d3feca9f9c6b2cd06fd64a111ae1a0e6]

CVE-2021-47031: mt76: mt7921: fix memory leak in mt7921_coredump_work

Announce: https://lore.kernel.org/linux-cve-announce/2024022835-CVE-2021-47031-75a5@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1c099ab ("mt76: mt7921: add MCU support") in
5.12-rc1dontuse.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [782b3e86ea970e899f8e723db9f64708a15ca30e]

CVE-2021-47032: mt76: mt7915: fix tx skb dma unmap

Announce: https://lore.kernel.org/linux-cve-announce/2024022835-CVE-2021-47032-b4df@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 27d5c52 ("mt76: fix double DMA unmap of the first
buffer on 7615/7915") in 5.10-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [7dcf3c04f0aca746517a77433b33d40868ca4749]
stable/5.10: [4e7914ce23306b28d377ec395e00e5fde0e6f96e]

CVE-2021-47033: mt76: mt7615: fix tx skb dma unmap

Announce: https://lore.kernel.org/linux-cve-announce/2024022836-CVE-2021-47033-4d0d@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 27d5c52 ("mt76: fix double DMA unmap of the first
buffer on 7615/7915") in 5.10-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [ebee7885bb12a8fe2c2f9bac87dbd87a05b645f9]
stable/5.10: [75bc5f779a7664d1fc19cb915039439c6e58bb94]

CVE-2021-47034: powerpc/64s: Fix pte update for kernel memory on radix

Announce: https://lore.kernel.org/linux-cve-announce/2024022836-CVE-2021-47034-0851@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f1cb8f9 ("powerpc/64s/radix: avoid ptesync after
set_pte and ptep_set_access_flags") in 4.18-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [b8b2f37cf632434456182e9002d63cbc4cccc50c]
stable/4.19: [b3d5d0983388d6c4fb35f7d722556d5595f167a7]
stable/5.10: [84c0762633f2a7ac8399e6b97d3b9bb8e6e1d50f]
stable/5.4: [73f9dccb29e4f82574bec2765c0090cdb0404301]

CVE-2021-47035: iommu/vt-d: Remove WO permissions on second-level paging entries

Announce: https://lore.kernel.org/linux-cve-announce/2024022836-CVE-2021-47035-e152@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b802d07 ("iommu/vt-d: Use iova over first level")
in 5.6-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [eea53c5816889ee8b64544fa2e9311a81184ff9c]
stable/5.10: [89bd620798704a8805fc9db0d71d7f812cf5b3d2]

CVE-2021-47036: udp: skip L4 aggregation for UDP tunnel packets

Announce: https://lore.kernel.org/linux-cve-announce/2024022837-CVE-2021-47036-cd49@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9fd1ff5 ("udp: Support UDP fraglist GRO/GSO.") in
5.6-rc1 and
3670706 ("udp: allow forwarding of plain (non-fraglisted) UDP GRO
packets") in 5.12-rc1-dontuse.
These commits are not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [18f25dc399901426dff61e676ba603ff52c666f7]

CVE-2021-47037: ASoC: q6afe-clocks: fix reprobing of the driver

Announce: https://lore.kernel.org/linux-cve-announce/2024022837-CVE-2021-47037-d130@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 520a1c3 ("ASoC: q6afe-clocks: add q6afe clock
controller") in 5.10-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [96fadf7e8ff49fdb74754801228942b67c3eeebd]

CVE-2021-47038: Bluetooth: avoid deadlock between hci_dev->lock and socket lock

Announce: https://lore.kernel.org/linux-cve-announce/2024022837-CVE-2021-47038-bfcf@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit eab2404 ("Bluetooth: Add BT_PHY socket option") in 5.7-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [17486960d79b900c45e0bb8fbcac0262848582ba]
stable/5.10: [7cc0ba67883c6c8d3bddb283f56c167fc837a555]

CVE-2021-47039: ataflop: potential out of bounds in do_format()

Announce: https://lore.kernel.org/linux-cve-announce/2024022837-CVE-2021-47039-638f@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit bf9c053 ("ataflop: use a separate gendisk for
each media format") in 5.11-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [1ffec389a6431782a8a28805830b6fae9bf00af1]

CVE-2021-47040: io_uring: fix overflows checks in provide buffers

Announce: https://lore.kernel.org/linux-cve-announce/2024022838-CVE-2021-47040-8722@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit efe68c1 ("io_uring: validate the full range of
provided buffers for access") in 5.8-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [38134ada0ceea3e848fe993263c0ff6207fd46e7]
stable/5.10: [cbbc13b115b8f18e0a714d89f87fbdc499acfe2d]

CVE-2021-47012: RDMA/siw: Fix a use after free in siw_alloc_mr

Announce: https://lore.kernel.org/linux-cve-announce/2024022831-CVE-2021-47012-73c5@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2251334 ("rdma/siw: application buffer
management") in 5.3-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [3093ee182f01689b89e9f8797b321603e5de4f63]
stable/5.10: [608a4b90ece039940e9425ee2b39c8beff27e00c]
stable/5.4: [30b9e92d0b5e5d5dc1101ab856c17009537cbca4]

CVE-2021-47041: nvmet-tcp: fix incorrect locking in state_change sk callback

Announce: https://lore.kernel.org/linux-cve-announce/2024022838-CVE-2021-47041-de92@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 872d26a ("nvmet-tcp: add NVMe over TCP target
driver") in 5.0-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [b5332a9f3f3d884a1b646ce155e664cc558c1722]
stable/5.10: [60ade0d56b06537a28884745059b3801c78e03bc]
stable/5.4: [999d606a820c36ae9b9e9611360c8b3d8d4bb777]

CVE-2021-47042: drm/amd/display: Free local data after use

Announce: https://lore.kernel.org/linux-cve-announce/2024022838-CVE-2021-47042-142d@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3a00c04 ("drm/amd/display/dc/core/dc_link: Move
some local data from the stack to the heap") in 5.12-rc1-dontuse.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [616cf23b6cf40ad6f03ffbddfa1b6c4eb68d8ae1]

CVE-2021-47043: media: venus: core: Fix some resource leaks in the
error path of 'venus_probe()'

Announce: https://lore.kernel.org/linux-cve-announce/2024022838-CVE-2021-47043-cb3c@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 32f0a6d ("media: venus: Use on-chip interconnect
API") in 5.5-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [5a465c5391a856a0c1e9554964d660676c35d1b2]
stable/5.10: [00b68a7478343afdf83f30c43e64db5296057030]

CVE-2021-47044: sched/fair: Fix shift-out-of-bounds in load_balance()

Announce: https://lore.kernel.org/linux-cve-announce/2024022839-CVE-2021-47044-2e16@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5a7f555 ("sched/fair: Relax constraint on task's
load during load balance") in 5.10-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [39a2a6eb5c9b66ea7c8055026303b3aa681b49a5]
stable/5.10: [80862cbf76c2646f709a57c4517aefe0b094c774]

CVE-2021-47045: scsi: lpfc: Fix null pointer dereference in lpfc_prep_els_iocb()

Announce: https://lore.kernel.org/linux-cve-announce/2024022839-CVE-2021-47045-7363@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4430f7f ("scsi: lpfc: Rework locations of ndlp
reference taking") in 5.11-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [8dd1c125f7f838abad009b64bff5f0a11afe3cb6]

CVE-2021-47046: drm/amd/display: Fix off by one in hdmi_14_process_transaction()

Announce: https://lore.kernel.org/linux-cve-announce/2024022839-CVE-2021-47046-3ffe@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit in 4c283fd ("drm/amd/display: Add HDCP module") in 5.5-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [8e6fafd5a22e7a2eb216f5510db7aab54cc545c1]
stable/5.10: [403c4528e5887af3deb9838cb77a557631d1e138]

CVE-2021-47047: spi: spi-zynqmp-gqspi: return -ENOMEM if dma_map_single fails

Announce: https://lore.kernel.org/linux-cve-announce/2024022839-CVE-2021-47047-4c75@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1c26372 ("spi: spi-zynqmp-gqspi: Update driver to
use spi-mem framework") in 5.10-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [126bdb606fd2802454e6048caef1be3e25dd121e]
stable/5.10: [5980a3b9c933408bc22b0e349b78c3ebd7cbf880]

CVE-2021-47013: net:emac/emac-mac: Fix a use after free in emac_mac_tx_buf_send

Announce: https://lore.kernel.org/linux-cve-announce/2024022831-CVE-2021-47013-034a@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b9b17de ("net: emac: emac gigabit ethernet
controller driver") in 4.9-r1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [6d72e7c767acbbdd44ebc7d89c6690b405b32b57]
stable/4.19: [16d8c44be52e3650917736d45f5904384a9da834]
stable/5.10: [9dc373f74097edd0e35f3393d6248eda8d1ba99d]
stable/5.4: [55fcdd1258faaecca74b91b88cc0921f9edd775d]

CVE-2021-47014: net/sched: act_ct: fix wild memory access when
clearing fragments

Announce: https://lore.kernel.org/linux-cve-announce/2024022831-CVE-2021-47014-ffc7@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit in ae372cb ("net/sched: act_ct: fix restore the
qdisc_skb_cb after defrag") in 5.8-rc7 and
7baf242 ("net/sched: cls_flower add CT_FLAGS_INVALID flag support") in
5.12-rc1-dontuse.
These commits are not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [f77bd544a6bbe69aa50d9ed09f13494cf36ff806]

CVE-2021-47015: bnxt_en: Fix RX consumer index logic in the error path

Announce: https://lore.kernel.org/linux-cve-announce/2024022832-CVE-2021-47015-c2ae@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a1b0e4e ("bnxt_en: Improve RX consumer index
validity check.") in 5.1-rc5.
This commit is backported to 4.19. Linux 4.4 is not affected.
Fixed in 5.13-rc1.

Fixed status
mainline: [bbd6f0a948139970f4a615dff189d9a503681a39]
stable/5.10: [4fcaad2b7dac3f16704f8118c7e481024ddbd3ed]
stable/5.4: [b1523e4ba293b2a32d9fabaf70c1dcaa6e3e2847]

CVE-2021-47017: ath10k: Fix a use after free in ath10k_htc_send_bundle

Announce: https://lore.kernel.org/linux-cve-announce/2024022832-CVE-2021-47017-c3e8@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c833451 ("ath10k: add htt TX bundle for sdio") in 5.8-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [8392df5d7e0b6a7d21440da1fc259f9938f4dec3]
stable/5.10: [8bb054fb336f4250002fff4e0b075221c05c3c65]

CVE-2021-47018: powerpc/64: Fix the definition of the fixmap area

Announce: https://lore.kernel.org/linux-cve-announce/2024022832-CVE-2021-47018-f631@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 265c349 ("powerpc: Add support for
GENERIC_EARLY_IOREMAP") in 5.5-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [9ccba66d4d2aff9a3909aa77d57ea8b7cc166f3c]
stable/5.10: [4b9fb2c9039a206d37f215936a4d5bee7b1bf9cd]

CVE-2021-47019: mt76: mt7921: fix possible invalid register access

Announce: https://lore.kernel.org/linux-cve-announce/2024022832-CVE-2021-47019-9b9a@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ffa1bf9 ("mt76: mt7921: introduce PM support") in
5.12-rc1-dontuse.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [fe3fccde8870764ba3e60610774bd7bc9f8faeff]

CVE-2021-47009: KEYS: trusted: Fix memory leak on object td

Announce: https://lore.kernel.org/linux-cve-announce/2024022830-CVE-2021-47009-3f56@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5df16ca ("KEYS: trusted: Fix incorrect handling
of tpm_get_random()") in 5.12-rc1-dontuse.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc2.

Fixed status
mainline: [83a775d5f9bfda95b1c295f95a3a041a40c7f321]
stable/5.10: [31c9a4b24d86cbb36ff0d7a085725a3b4f0138c8]

CVE-2021-47049: Drivers: hv: vmbus: Use after free in __vmbus_open()

Announce: https://lore.kernel.org/linux-cve-announce/2024022840-CVE-2021-47049-5cc6@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6f3d791 ("Drivers: hv: vmbus: Fix rescind
handling issues") in 4.14-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [3e9bf43f7f7a46f21ec071cb47be92d0874c48da]
stable/5.10: [d5c7b42c9f56ca46b286daa537d181bd7f69214f]

CVE-2021-47050: memory: renesas-rpc-if: fix possible NULL pointer
dereference of resource

Announce: https://lore.kernel.org/linux-cve-announce/2024022840-CVE-2021-47050-5ba5@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ca7d8b9 ("memory: add Renesas RPC-IF driver") in 5.9-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [59e27d7c94aa02da039b000d33c304c179395801]
stable/5.10: [71bcc1b4a1743534d8abdcb57ff912e6bc390438]

CVE-2021-47051: spi: fsl-lpspi: Fix PM reference leak in
lpspi_prepare_xfer_hardware()

Announce: https://lore.kernel.org/linux-cve-announce/2024022840-CVE-2021-47051-cf30@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 944c01a ("spi: lpspi: enable runtime pm for
lpspi") in 5.2-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [a03675497970a93fcf25d81d9d92a59c2d7377a7]
stable/5.10: [ce02e58ddf8658a4c3bed2296f32a5873b3f7cce]
stable/5.4: [4a01ad002d2e03c399af536562693752af7c81b1]

CVE-2021-47052: crypto: sa2ul - Fix memory leak of rxd

Announce: https://lore.kernel.org/linux-cve-announce/2024022841-CVE-2021-47052-3cca@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 00c9211 ("crypto: sa2ul - Fix DMA mapping API
usage") in 5.10-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [854b7737199848a91f6adfa0a03cf6f0c46c86e8]
stable/5.10: [0e596b3734649041ed77edc86a23c0442bbe062b]

CVE-2021-47053: crypto: sun8i-ss - Fix memory leak of pad

Announce: https://lore.kernel.org/linux-cve-announce/2024022841-CVE-2021-47053-c68d@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d9b4541 ("crypto: sun8i-ss - support hash
algorithms") in 5.10-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [50274b01ac1689b1a3f6bc4b5b3dbf361a55dd3a]
stable/5.10: [2c67a9333da9d0a3b87310e0d116b7c9070c7b00]

CVE-2021-47048: spi: spi-zynqmp-gqspi: fix use-after-free in zynqmp_qspi_exec_op

Announce: https://lore.kernel.org/linux-cve-announce/2024022840-CVE-2021-47048-8586@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1c26372 ("spi: spi-zynqmp-gqspi: Update driver to
use spi-mem framework") in 5.10rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [a2c5bedb2d55dd27c642c7b9fb6886d7ad7bdb58]
stable/5.10: [1231279389b5e638bc3b66b9741c94077aed4b5a]

CVE-2021-46959: spi: Fix use-after-free with devm_spi_alloc_*

Announce: https://lore.kernel.org/linux-cve-announce/2024022916-CVE-2021-46959-f517@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5e844cc ("spi: Introduce device-managed SPI
controller allocation") in 5.10-rc5.
This commit is backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
cip/4.4: [62bb2c7f2411a0045c24831f11ecacfc35610815]
cip/4.4-rt: [62bb2c7f2411a0045c24831f11ecacfc35610815]
cip/4.4-st: [62bb2c7f2411a0045c24831f11ecacfc35610815]
mainline: [794aaf01444d4e765e2b067cba01cc69c1c68ed9]
stable/4.19: [28a5529068c51cdf0295ab1e11a99a3a909a03e4]
stable/5.10: [c7fabe372a9031acd00498bc718ce27c253abfd1]
stable/5.4: [001c8e83646ad3b847b18f6ac55a54367d917d74]

CVE-2021-47016: m68k: mvme147,mvme16x: Don''t wipe PCC timer config bits

Announce: https://lore.kernel.org/linux-cve-announce/2024022919-CVE-2021-47016-320d@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7529b90 ("m68k: mvme147: Handle timer counter
overflow") in 5.2-rc1 and
19999a8 ("m68k: mvme16x: Handle timer counter overflow") in 5.2-rc1.
These commits are not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [43262178c043032e7c42d00de44c818ba05f9967]
stable/5.10: [1dfb26df15fc7036a74221d43de7427f74293dae]
stable/5.4: [f6a90818a32058fca62cda3a2027a6a2364e1878]

CVE-2021-47020: oundwire: stream: fix memory leak in stream config error path

Announce: https://lore.kernel.org/linux-cve-announce/2024022920-CVE-2021-47020-78d9@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 89e5905 ("soundwire: Add support for SoundWire
stream management") in 4.18-rc1.
This commit is not backported to older kernels.
Fixed 5.13-rc1.

Fixed status
mainline: [48f17f96a81763c7c8bf5500460a359b9939359f]
stable/4.19: [342260fe821047c3d515e3d28085d73fbdce3e80]
stable/5.10: [7c468deae306d0cbbd539408c26cfec04c66159a]
stable/5.4: [870533403ffa28ff63e173045fc5369365642002]

CVE-2021-47054: bus: qcom: Put child node before return

Announce: https://lore.kernel.org/linux-cve-announce/2024022950-CVE-2021-47054-c994@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 335a127 ("bus: qcom: add EBI2 driver") in 4.9-rc1.
This commit is not backported to older kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [ac6ad7c2a862d682bb584a4bc904d89fa7721af8]
stable/4.19: [a399dd80e697a02cfb23e2fc09b87849994043d9]
stable/5.10: [00f6abd3509b1d70d0ab0fbe65ce5685cebed8be]
stable/5.4: [3a76ec28824c01b57aa1f0927841d75e4f167cb8]

CVE-2021-47055: mtd: require write permissions for locking and badblock ioctls

Announce: https://lore.kernel.org/linux-cve-announce/2024022950-CVE-2021-47055-6927@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f7e6b19 ("mtd: properly check all write ioctls
for permissions") in 5.9-rc1.
This commit is backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
cip/4.4: [f4d28d8b9b0e7c4ae04214b8d7e0b0466ec6bcaf]
cip/4.4-rt: [f4d28d8b9b0e7c4ae04214b8d7e0b0466ec6bcaf]
cip/4.4-st: [f4d28d8b9b0e7c4ae04214b8d7e0b0466ec6bcaf]
mainline: [1e97743fd180981bef5f01402342bb54bf1c6366]
stable/4.19: [75ed985bd6c8ac1d4e673e93ea9d96c9908c1d37]
stable/5.10: [7b6552719c0ccbbea29dde4be141da54fdb5877e]
stable/5.4: [5880afefe0cb9b2d5e801816acd58bfe91a96981]

CVE-2021-47056: crypto: qat - ADF_STATUS_PF_RUNNING should be set
after adf_dev_init

https://lore.kernel.org/linux-cve-announce/2024022950-CVE-2021-47056-c2b3@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 25c6ffb ("crypto: qat - check if PF is running")
in 4.7-rc1.
Linux 4.4 is not affected.
Fixed in 5.13-rc1.

Fixed status
mainline: [8609f5cfdc872fc3a462efa6a3eca5cb1e2f6446]
stable/4.19: [09d16cee6285d37cc76311c29add6d97a7e4acda]
stable/5.10: [1f50392650ae794a1aea41c213c6a3e1c824413c]
stable/5.4: [05ec8192ee4bfdf2a8894a68350dac9f1a155fa6]

CVE-2021-47057: crypto: sun8i-ss - Fix memory leak of object d when
dma_iv fails to map

Announce: https://lore.kernel.org/linux-cve-announce/2024022951-CVE-2021-47057-01fa@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ac2614d ("crypto: sun8i-ss - Add support for the
PRNG") in 5.10-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [98b5ef3e97b16eaeeedb936f8bda3594ff84a70e]
stable/5.10: [617ec35ed51f731a593ae7274228ef2cfc9cb781]

CVE-2021-47058: crypto: sun8i-ss - fix result memory leak on error path

Announce: https://lore.kernel.org/linux-cve-announce/2024022951-CVE-2021-47058-3130@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cffa4b2 ("regmap: debugfs: Fix a memory leak when
calling regmap_attach_dev") in 5.11-rc3.
This commit is backported to 5.10, 5.4, and 4.19. Linux 4.4 is not affected.
Fixed in 5.13-rc1.

Fixed status
mainline: [e41a962f82e7afb5b1ee644f48ad0b3aee656268]
stable/4.19: [2dc1554d5f0fdaf47cc5bea442b84b9226fea867]
stable/5.10: [eb949f891226c012138ffd9df90d1e509f428ae6]
stable/5.4: [d8897f7b2283a500666c85ef06e820df38ed7b52]

CVE-2021-47060: KVM: Stop looking for coalesced MMIO zones if the bus
is destroyed

Announce: https://lore.kernel.org/linux-cve-announce/2024022952-CVE-2021-47060-d2ce@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f658866 ("KVM: fix memory leak in
kvm_io_bus_unregister_dev()") in 5.9-rc5.
This commit is backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [5d3c4c79384af06e3c8e25b7770b6247496b4417]
stable/5.10: [2a20592baff59c5351c5200ec667e1a2aa22af85]
stable/5.4: [7d1bc32d6477ff96a32695ea4be8144e4513ab2d]

CVE-2021-47061: KVM: Destroy I/O bus devices on unregister failure
_after_ sync''ing SRCU

Announce: https://lore.kernel.org/linux-cve-announce/2024022952-CVE-2021-47061-6fea@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit in f658866 ("KVM: fix memory leak in
kvm_io_bus_unregister_dev()") in 4.11-rc5.
This commit is backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [2ee3757424be7c1cd1d0bbfa6db29a7edd82a250]
stable/5.10: [03c6cccedd3913006744faa252a4da5145299343]

CVE-2021-47062: KVM: SVM: Use online_vcpus, not created_vcpus, to
iterate over vCPUs

Announce: https://lore.kernel.org/linux-cve-announce/2024022953-CVE-2021-47062-ed39@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ad73109 ("KVM: SVM: Provide support to launch and
run an SEV-ES guest") in 5.11-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [c36b16d29f3af5f32fc1b2a3401bf48f71cabee1]

CVE-2021-47063: drm: bridge/panel: Cleanup connector on bridge detach

Announce: https://lore.kernel.org/linux-cve-announce/2024022953-CVE-2021-47063-2f50@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 13dfc05 ("drm/bridge: Refactor out the panel
wrapper from the lvds-encoder bridge.") in 4.13-rc1.
Linux 4.4 is not affected.
Fixed in 5.13-rc1.

Fixed status
mainline: [4d906839d321c2efbf3fed4bc31ffd9ff55b75c0]
stable/5.10: [ce450934a00cf896e648fde08d0bd1426653d7a2]

CVE-2021-47064: mt76: fix potential DMA mapping leak

Announce: https://lore.kernel.org/linux-cve-announce/2024022954-CVE-2021-47064-f220@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 27d5c52 ("mt76: fix double DMA unmap of the first
buffer on 7615/7915") in 5.10-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [b4403cee6400c5f679e9c4a82b91d61aa961eccf]
stable/5.10: [9fa26701cd1fc4d932d431971efc5746325bdfce]

CVE-2021-47065: rtw88: Fix array overrun in rtw_get_tx_power_params()

Announce: https://lore.kernel.org/linux-cve-announce/2024022954-CVE-2021-47065-be1d@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit fa6dfe6 ("rtw88: resolve order of tx power
setting routines") in 5.3-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [2ff25985ea9ccc6c9af2c77b0b49045adcc62e0e]
stable/5.10: [95fb153c6027924cda3422120169d1890737f3a0]
stable/5.4: [6b5aa0cf321c25f41e09a61c83ee4dc7ab9549cb]

CVE-2021-47066: async_xor: increase src_offs when dropping destination page

Announce: https://lore.kernel.org/linux-cve-announce/2024022954-CVE-2021-47066-02e0@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 29bcff7 ("md/raid5: add new xor function to
support different page offset") in 5.10-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [ceaf2966ab082bbc4d26516f97b3ca8a676e2af8]
stable/5.10: [cab2e8e5997b592fdb7d02cf2387b4b8e3057174]

CVE-2021-47067: soc/tegra: regulators: Fix locking up when
voltage-spread is out of range

Announce: https://lore.kernel.org/linux-cve-announce/2024022955-CVE-2021-47067-8104@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7838074 ("soc/tegra: regulators: Add regulators
coupler for Tegra30") in 5.5-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [ef85bb582c41524e9e68dfdbde48e519dac4ab3d]
stable/5.10: [a1ad124c836816fac8bd5e461d36eaf33cee4e24]

CVE-2021-47068: net/nfc: fix use-after-free llcp_sock_bind/connect

Announce: https://lore.kernel.org/linux-cve-announce/2024022955-CVE-2021-47068-a416@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c33b1cc ("nfc: fix refcount leak in
llcp_sock_bind()") in 5.12-rc7.
This commit is backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
cip/4.4: [26157c82ba756767b2bd66d28a71b1bc454447f6]
cip/4.4-rt: [26157c82ba756767b2bd66d28a71b1bc454447f6]
cip/4.4-st: [26157c82ba756767b2bd66d28a71b1bc454447f6]
mainline: [c61760e6940dd4039a7f5e84a6afc9cdbf4d82b6]
stable/4.19: [48fba458fe54cc2a980a05c13e6c19b8b2cfb610]
stable/5.10: [6b7021ed36dabf29e56842e3408781cd3b82ef6e]
stable/5.4: [e32352070bcac22be6ed8ab635debc280bb65b8c]

CVE-2023-52476: perf/x86/lbr: Filter vsyscall addresses

Announce: https://lore.kernel.org/linux-cve-announce/2024022921-CVE-2023-52476-e307@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.
I found similar code in following files but not sure these are
vulnerable or not.

5.10: https://elixir.bootlin.com/linux/v5.10.210/source/arch/x86/events/intel/lbr.c#L1228
5.4: https://elixir.bootlin.com/linux/v5.4.269/source/arch/x86/events/intel/lbr.c#L878
4.19: https://elixir.bootlin.com/linux/v4.19.307/source/arch/x86/events/intel/lbr.c#L867
4.4: https://elixir.bootlin.com/linux/v4.4.302/source/arch/x86/kernel/cpu/perf_event_intel_lbr.c#L694

Fixed in 6.6-rc6.

Fixed status
mainline: [e53899771a02f798d436655efbd9d4b46c0f9265]
stable/5.15: [403d201d1fd144cb249836dafb222f6375871c6c]
stable/6.1: [3863989497652488a50f00e96de4331e5efabc6c]

CVE-2023-52479: ksmbd: fix uaf in smb20_oplock_break_ack

Announce: https://lore.kernel.org/linux-cve-announce/2024022922-CVE-2023-52479-fc87@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined. The ksmbd is introduced in 5.15
so prior to 5.15 kernels are not affected.
Fixed in 6.6-rc5.

Fixed status
mainline: [c69813471a1ec081a0b9bf0c6bd7e8afd818afce]
stable/5.15: [694e13732e830cbbfedb562e57f28644927c33fd]
stable/6.1: [8226ffc759ea59f10067b9acdf7f94bae1c69930]

CVE-2023-52480: ksmbd: fix race condition between session lookup and expire

Announce: https://lore.kernel.org/linux-cve-announce/2024022922-CVE-2023-52480-ff7f@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined. The ksmbd is introduced in 5.15
so prior to 5.15 kernels are not affected.
Fixed in 6.6-rc5.

Fixed status
mainline: [53ff5cf89142b978b1a5ca8dc4d4425e6a09745f]
stable/5.15: [c77fd3e25a51ac92b0f1b347a96eff6a0b4f066f]
stable/6.1: [a2ca5fd3dbcc665e1169044fa0c9e3eba779202b]

CVE-2023-52481: arm64: errata: Add Cortex-A520 speculative
unprivileged load workaround

Announce: https://lore.kernel.org/linux-cve-announce/2024022922-CVE-2023-52481-99a8@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.
Fixed in 6.6-rc5.

Fixed status
mainline: [471470bc7052d28ce125901877dd10e4c048e513]
stable/6.1: [6e3ae2927b432a3b7c8374f14dbc1bd9ebe4372c]

CVE-2023-52482: x86/srso: Add SRSO mitigation for Hygon processors

Announce: https://lore.kernel.org/linux-cve-announce/2024022922-CVE-2023-52482-9375@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.
Fixed in 6.6-rc4.

Fixed status
mainline: [a5ef7d68cea1344cf524f04981c2b3f80bedbb0d]
stable/5.15: [f090a8b4d2e3ec6f318d6fdab243a2edc5a8cc37]
stable/6.1: [6ce2f297a7168274547d0b5aea6c7c16268b8a96]

CVE-2023-52484: iommu/arm-smmu-v3: Fix soft lockup triggered by
arm_smmu_mm_invalidate_range

Announce: https://lore.kernel.org/linux-cve-announce/2024022923-CVE-2023-52484-3635@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.
Fixed in 6.6-rc5.

Fixed status
mainline: [d5afb4b47e13161b3f33904d45110f9e6463bad6]
stable/5.15: [f5a604757aa8e37ea9c7011dc9da54fa1b30f29b]
stable/6.1: [f90f4c562003ac3d3b135c5a40a5383313f27264]

CVE-2023-52485: drm/amd/display: Wake DMCUB before sending a command

Announce: https://lore.kernel.org/linux-cve-announce/20240229150009.1525992-2-lee@kernel.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.
Fixed in 6.8-rc1.

Fixed status
mainline: [8892780834ae294bc3697c7d0e056d7743900b39]
stable/6.7: [303197775a97416b62d4da69280d0c120a20e009]

CVE-2023-52486: drm: Don''t unref the same fb many times by mistake
due to deadlock handling

Announce: https://lore.kernel.org/linux-cve-announce/20240229155245.1571576-27-lee@kernel.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined. It looks as if it's good to backport to 4.4
(https://elixir.bootlin.com/linux/v4.4.302/source/drivers/gpu/drm/drm_crtc.c#L5329).
Fixed in 6.8-rc1.

Fixed status
mainline: [cb4daf271302d71a6b9a7c01bd0b6d76febd8f0c]
stable/4.19: [376e21a9e4c2c63ee5d8d3aa74be5082c3882229]
stable/5.10: [f55261469be87c55df13db76dc945f6bcd825105]
stable/5.15: [b4af63da9d94986c529d74499fdfe44289acd551]
stable/5.4: [9dd334a8245011ace45e53298175c7b659edb3e7]
stable/6.1: [62f2e79cf9f4f47cc9dea9cebdf58d9f7b5695e0]
stable/6.6: [d7afdf360f4ac142832b098b4de974e867cc063c]
stable/6.7: [bfd0feb1b109cb63b87fdcd00122603787c75a1a]

CVE-2023-52488: erial: sc16is7xx: convert from _raw_ to _noinc_ regmap
functions for FIFO

Announce: https://lore.kernel.org/linux-cve-announce/20240229155245.1571576-29-lee@kernel.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit dfeae61 ("serial: sc16is7xx") in 3.16-rc1.
Fixed in 6.8-rc1.

Fixed status
mainline: [dbf4ab821804df071c8b566d9813083125e6d97b]
stable/6.1: [416b10d2817c94db86829fb92ad43ce7d002c573]
stable/6.6: [084c24e788d9cf29c55564de368bf5284f2bb5db]
stable/6.7: [aa7cb4787698add9367b19f7afc667662c9bdb23]

CVE-2023-52489: mm/sparsemem: fix race in accessing memory_section->usage

Announce: https://lore.kernel.org/linux-cve-announce/20240229155245.1571576-30-lee@kernel.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f46edbd ("mm/sparsemem: add helpers track active
portions of a section at boot") in 5.3-rc1.
This commit is not backported to older stable kernels.
Fixed in 6/8-rc1.

Fixed status
mainline: [5ec8e8ea8b7783fab150cf86404fc38cb4db8800]
stable/5.10: [90ad17575d26874287271127d43ef3c2af876cea]
stable/5.15: [b448de2459b6d62a53892487ab18b7d823ff0529]
stable/6.1: [68ed9e33324021e9d6b798e9db00ca3093d2012a]
stable/6.6: [70064241f2229f7ba7b9599a98f68d9142e81a97]
stable/6.7: [3a01daace71b521563c38bbbf874e14c3e58adb7]

CVE-2023-52491: media: mtk-jpeg: Fix use after free bug due to error
path handling in mtk_jpeg_dec_device_run

Announce: https://lore.kernel.org/linux-cve-announce/20240229155245.1571576-32-lee@kernel.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b2f0d27 ("[media] vcodec: mediatek: Add Mediatek
JPEG Decoder Driver") in 4.12-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [206c857dd17d4d026de85866f1b5f0969f2a109e]
stable/5.10: [43872f44eee6c6781fea1348b38885d8e78face9]
stable/5.15: [1b1036c60a37a30caf6759a90fe5ecd06ec35590]
stable/6.1: [9fec4db7fff54d9b0306a332bab31eac47eeb5f6]
stable/6.6: [8254d54d00eb6cdb8367399c7f912eb8d354ecd7]
stable/6.7: [6e2f37022f0fc0893da4d85a0500c9d547fffd4c]

CVE-2023-52492: dmaengine: fix NULL pointer in channel unregistration function

Announce: https://lore.kernel.org/linux-cve-announce/20240229155245.1571576-33-lee@kernel.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d2fb0a0 ("dmaengine: break out channel
registration") in 5.6-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [f5c24d94512f1b288262beda4d3dcb9629222fc7]
stable/5.10: [9de69732dde4e443c1c7f89acbbed2c45a6a8e17]
stable/5.15: [047fce470412ab64cb7345f9ff5d06919078ad79]
stable/6.1: [2ab32986a0b9e329eb7f8f04dd57cc127f797c08]
stable/6.6: [7f0ccfad2031eddcc510caf4e57f2d4aa2d8a50b]
stable/6.7: [9263fd2a63487c6d04cbb7b74a48fb12e1e352d0]

CVE-2023-52493: bus: mhi: host: Drop chan lock before queuing buffers

Announce: https://lore.kernel.org/linux-cve-announce/20240229155245.1571576-34-lee@kernel.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1d3173a ("bus: mhi: core: Add support for
processing events from client device") in 5.7-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [01bd694ac2f682fb8017e16148b928482bc8fa4b]
stable/5.10: [20a6dea2d1c68d4e03c6bb50bc12e72e226b5c0e]
stable/5.15: [6e4c84316e2b70709f0d00c33ba3358d9fc8eece]
stable/6.1: [3c5ec66b4b3f6816f3a6161538672e389e537690]
stable/6.6: [eaefb9464031215d63c0a8a7e2bfaa00736aa17e]
stable/6.7: [b8eff20d87092e14cac976d057cb0aea2f1d0830]

CVE-2023-52494: bus: mhi: host: Add alignment check for event ring read pointer

Announce: https://lore.kernel.org/linux-cve-announce/20240229155245.1571576-35-lee@kernel.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ec32332 ("bus: mhi: core: Sanity check values
from remote device before use") in 5.13-rc1.
This commit is backported to 5.19. Linux 5.4 and 4.x are not affected.
Fixed in 6.8-rc1.

Fixed status
mainline: [eff9704f5332a13b08fbdbe0f84059c9e7051d5f]
stable/5.15: [94991728c84f8df54fd9eec9b85855ef9057ea08]
stable/6.1: [2df39ac8f813860f79782807c3f7acff40b3c551]
stable/6.6: [a9ebfc405fe1be145f414eafadcbf09506082010]
stable/6.7: [ecf8320111822a1ae5d5fc512953eab46d543d0b]

CVE-2023-52497: erofs: fix lz4 inplace decompression

Announce: https://lore.kernel.org/linux-cve-announce/20240229155245.1571576-38-lee@kernel.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0ffd71b ("staging: erofs: introduce LZ4
decompression inplace") in 5.3-rc1 and
598162d ("erofs: support decompress big pcluster for lz4 backend") in 5.13-rc1.
These commits are not backported to older stable kernels.
Fixed in 6.8-rc6.

Fixed status
mainline: [3c12466b6b7bf1e56f9b32c366a3d83d87afb4de]
stable/5.10: [a0180e940cf1aefa7d516e20b259ad34f7a8b379]
stable/5.15: [77cbc04a1a8610e303a0e0d74f2676667876a184]
stable/6.1: [33bf23c9940dbd3a22aad7f0cda4c84ed5701847]
stable/6.6: [f36d200a80a3ca025532ed60dd1ac21b620e14ae]
stable/6.7: [bffc4cc334c5bb31ded54bc3cfd651735a3cb79e]

CVE-2023-52498: PM: sleep: Fix possible deadlocks in core system-wide PM code

Announce: https://lore.kernel.org/linux-cve-announce/20240229155245.1571576-39-lee@kernel.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined. Fixed in 6.8-rc1.
This commit log contains 5.7+ tag so that it may not affect to prior to 5.7.

Fixed status
mainline: [7839d0078e0d5e6cc2fa0b0dfbee71de74f1e557]
stable/5.10: [f46eb832389f162ad13cb780d0b8cde93641990d]
stable/5.15: [a1d62c775b07213c73f81ae842424c74dd14b5f0]
stable/6.1: [e1c9d32c98309ae764893a481552d3f99d46cb34]
stable/6.6: [e681e29d1f59a04ef773296e4bebb17b1b79f8fe]
stable/6.7: [9bd3dce27b01c51295b60e1433e1dadfb16649f7]

CVE-2024-26607: drm/bridge: sii902x: Fix probing race issue

Announce: https://lore.kernel.org/linux-cve-announce/20240229133514.1480195-2-lee@kernel.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 21d8084 ("drm/bridge/sii902x: Fix EDID readback")
in 5.0-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc2.

Fixed status
mainline: [08ac6f132dd77e40f786d8af51140c96c6d739c9]
stable/6.1: [e0f83c234ea7a3dec1f84e5d02caa1c51664a076]
stable/6.6: [56f96cf6eb11a1c2d594367c3becbfb06a855ec1]
stable/6.7: [2a4c6af7934a7b4c304542c38fee35e09cc1770c]

CVE-2024-26609: netfilter: nf_tables: reject QUEUE/DROP verdict parameters

Announce: https://lore.kernel.org/linux-cve-announce/20240229155245.1571576-41-lee@kernel.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e0abdad ("netfilter: nf_tables: accept QUEUE/DROP
verdict parameters") in 3.15-rc1.
Fixed in 6.8-rc2.

Fixed status
mainline: [f342de4e2f33e0e39165d8639387aa6c19dff660]
stable/4.19: [8365e9d92b85fda975a5ece7a3a139cb964018c8]
stable/5.10: [55a60251fa50d4e68175e36666b536a602ce4f6c]
stable/5.15: [960cf4f812530f01f6acc6878ceaa5404c06af7b]
stable/5.4: [4e66422f1b56149761dc76030e6345d1cca6f869]
stable/6.1: [8e34430e33b8a80bc014f3efe29cac76bc30a4b4]
stable/6.6: [6653118b176a00915125521c6572ae8e507621db]
stable/6.7: [f05a497e7bc8851eeeb3a58da180ba469efebb05]

CVE-2024-26610: wifi: iwlwifi: fix a memory corruption

Announce: https://lore.kernel.org/linux-cve-announce/20240229155245.1571576-42-lee@kernel.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cf29c5b ("iwlwifi: dbg_ini: implement time point
handling") in 5.5-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc2.

mainline: [cf4a0d840ecc72fcf16198d5e9c505ab7d5a5e4d]
stable/5.10: [05dd9facfb9a1e056752c0901c6e86416037d15a]
stable/5.15: [99a23462fe1a6f709f0fda3ebbe8b6b193ac75bd]
stable/6.1: [aa2cc9363926991ba74411e3aa0a0ea82c1ffe32]
stable/6.6: [870171899d75d43e3d14360f3a4850e90a9c289b]
stable/6.7: [f32a81999d0b8e5ce60afb5f6a3dd7241c17dd67]

CVE-2024-26613: net/rds: Fix UBSAN: array-index-out-of-bounds in rds_cmsg_recv

Announce: https://lore.kernel.org/linux-cve-announce/20240229155245.1571576-45-lee@kernel.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3289025 ("RDS: add receive message trace used by
application") in 4.11-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc2.

Fixed status
mainline: [13e788deb7348cc88df34bed736c3b3b9927ea52]
stable/4.19: [344350bfa3b4b37d7c3d5a00536e6fbf0e953fbf]
stable/5.10: [5ae8d50044633306ff160fcf7faa24994175efe1]
stable/5.15: [00d1ee8e1d02194f7b7b433e904e04bbcd2cc0dc]
stable/5.4: [a37ae111db5e0f7e3d6b692056c30e3e0f6f79cd]
stable/6.1: [71024928b3f71ce4529426f8692943205c58d30b]
stable/6.6: [7a73190ea557e7f26914b0fe04c1f57a96cb771f]
stable/6.7: [0b787c2dea15e7a2828fa3a74a5447df4ed57711]

CVE-2024-26614: tcp: make sure init the accept_queue''s spinlocks once

Announce: https://lore.kernel.org/linux-cve-announce/20240229155245.1571576-46-lee@kernel.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit fff1f30 ("tcp: add a spinlock to protect struct
request_sock_queue") in 4.4-rc1 and
168a8f5 ("tcp: TCP Fast Open Server - main code path") in 3.7-rc1.
Fixed in 6.8-rc2.

Fixed status
mainline: [198bc90e0e734e5f98c3d2833e8390cac3df61b2]
stable/5.10: [bc99dcedd2f422d602516762b96c8ef1ae6b2882]
stable/5.15: [d86cc6ab33b085eaef27ea88b78fc8e2375c0ef3]
stable/6.1: [b1e0a68a0cd2a83259c444f638b417a8fffc6855]
stable/6.6: [168e7e599860654876c2a1102a82610285c02f02]
stable/6.7: [3982fe726a63fb3de6005e534e2ac8ca7e0aca2a]

CVE-2024-26615: net/smc: fix illegal rmb_desc access in SMC-D connection dump

Announce: https://lore.kernel.org/linux-cve-announce/20240229155245.1571576-47-lee@kernel.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4b1b7d3 ("net/smc: add SMC-D diag support") in 4.19-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc2.

Fixed status
mainline: [dbc153fd3c142909e564bb256da087e13fbf239c]
stable/4.19: [27aea64838914c6122db5b8bd4bed865c9736f22]
stable/5.10: [5fed92ca32eafbfae8b6bee8ca34cca71c6a8b6d]
stable/5.15: [68b888d51ac82f2b96bf5e077a31d76afcdef25a]
stable/5.4: [1fea9969b81c67d0cb1611d1b8b7d19049d937be]
stable/6.1: [6994dba06321e3c48fdad0ba796a063d9d82183a]
stable/6.6: [a164c2922675d7051805cdaf2b07daffe44f20d9]
stable/6.7: [8f3f9186e5bb96a9c9654c41653210e3ea7e48a6]

CVE-2024-26618: arm64/sme: Always exit sme_alloc() early with existing storage

Introduced by commit 5d0a8d2 ("arm64/ptrace: Ensure that SME is set up
for target when writing SSVE state") in 6.5-rc7.
This commit is backported to 6.1. Linux 5.x and 4.x are not affected.
Fixed in 6.8-rc1.

Fixed status
mainline: [dc7eb8755797ed41a0d1b5c0c39df3c8f401b3d9]
stable/6.6: [569156e4fa347237f8fa2a7e935d860109c55ac4]
stable/6.7: [814af6b4e6000e574e74d92197190edf07cc3680]

CVE-2021-47059: crypto: sun8i-ss - fix result memory leak on error path

Announce: https://lore.kernel.org/linux-cve-announce/2024022952-CVE-2021-47059-4bb8@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d9b4541 ("crypto: sun8i-ss - support hash
algorithms") in 5.10-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [1dbc6a1e25be8575d6c4114d1d2b841a796507f7]
stable/5.10: [1f12aaf07f61122cf5074d29714ee26f8d44b0e7]

CVE-2021-47070: uio_hv_generic: Fix another memory leak in error handling paths

Announce: https://lore.kernel.org/linux-cve-announce/2024030141-CVE-2021-47070-0525@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cdfa835 ("uio_hv_generic: defer opening vmbus
until first use" in 4.20-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc3.

Fixed status
mainline: [0b0226be3a52dadd965644bc52a807961c2c26df]

CVE-2021-47074: nvme-loop: fix memory leak in nvme_loop_create_ctrl()

Announce: https://lore.kernel.org/linux-cve-announce/2024030142-CVE-2021-47074-46a7@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3a85a5d ("nvme-loop: add a NVMe loopback host
driver") in 4.8-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc3.

Fixed status
mainline: [03504e3b54cc8118cc26c064e60a0b00c2308708]
stable/5.10: [9c980795ccd77e8abec33dd6fe28dfe1c4083e65]

CVE-2021-47076: RDMA/rxe: Return CQE error if invalid lkey was supplied

Announce: https://lore.kernel.org/linux-cve-announce/2024030142-CVE-2021-47076-a6b6@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit in 8700e3e ("Soft RoCE driver") in 4.8-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc3.

Fixed status
mainline: [dc07628bd2bbc1da768e265192c28ebd301f509d]

CVE-2021-47077: scsi: qedf: Add pointer checks in qedf_update_link_speed()

Announce: https://lore.kernel.org/linux-cve-announce/2024030142-CVE-2021-47077-994b@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 61d8658 ("scsi: qedf: Add QLogic FastLinQ offload
FCoE driver framework.") in 4.11-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc3.

Fixed status
mainline: [73578af92a0fae6609b955fcc9113e50e413c80f]
stable/5.10: [a6362a737572f66051deb7637f3f77ddf7a4402f]

CVE-2021-47073: platform/x86: dell-smbios-wmi: Fix oops on rmmod dell_smbios

Announce: https://lore.kernel.org/linux-cve-announce/2024030142-CVE-2021-47073-704a@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1a258e6 ("platform/x86: dell-smbios-wmi: Add new
WMI dispatcher driver") in 4.15-rc1.
Linux 4.4 is not affected.
Fixed in 5.13-rc3.

Fixed status
mainline: [3a53587423d25c87af4b4126a806a0575104b45e]
stable/4.19: [75cfc833da4a2111106d4c134e93e0c7f41e35e7]
stable/5.10: [0cf036a0d325200e6c27b90908e51195bbc557b1]
stable/5.4: [6fa78a6b9a3beb676a010dc489c1257f7e432525]

CVE-2021-47079: platform/x86: ideapad-laptop: fix a NULL pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024030142-CVE-2021-47079-3934@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ff36b0d ("platform/x86: ideapad-laptop: rework
and create new ACPI helpers") in 5.12-rc1-dontuse.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc3.

Fixed status
mainline: [ff67dbd554b2aaa22be933eced32610ff90209dd]

CVE-2021-47071: uio_hv_generic: Fix a memory leak in error handling paths

Announce: https://lore.kernel.org/linux-cve-announce/2024030141-CVE-2021-47071-cd46@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cdfa835 ("uio_hv_generic: defer opening vmbus
until first use") in 4.20-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc3.

Fixed status
mainline: [3ee098f96b8b6c1a98f7f97915f8873164e6af9d]
stable/5.10: [d84b5e912212b05f6b5bde9f682046accfbe0354]
stable/5.4: [cdd91637d4ef33e2be19a8e16e72e7d00c996d76]

CVE-2021-47080: RDMA/core: Prevent divide-by-zero error triggered by the user

Announce: https://lore.kernel.org/linux-cve-announce/2024030142-CVE-2021-47080-eb20@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9f85cbe ("RDMA/uverbs: Expose the new GID query
API to user space") in 5.10-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc3.

Fixed status
mainline: [54d87913f147a983589923c7f651f97de9af5be1]
stable/5.10: [66ab7fcdac34b890017f04f391507ef5b2b89a13]

CVE-2021-47075: nvmet: fix memory leak in nvmet_alloc_ctrl()

Announce: https://lore.kernel.org/linux-cve-announce/2024030142-CVE-2021-47075-8d12@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 94a39d6 ("nvmet: make ctrl-id configurable") in 5.7-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc3.

Fixed status
mainline: [fec356a61aa3d3a66416b4321f1279e09e0f256f]
stable/5.10: [4720f29acb3fe67aa8aa71e6b675b079d193aaeb]

CVE-2021-47078: RDMA/rxe: Clear all QP fields if creation failed

Announce: https://lore.kernel.org/linux-cve-announce/2024030142-CVE-2021-47078-71f9@gregkh/T/#u

Introduced by commit 8700e3e ("Soft RoCE driver") in 4.8-rc1.
Linux 4.4 is not affected.
Fixed in 5.13-rc3.

Fixed status
mainline: [67f29896fdc83298eed5a6576ff8f9873f709228]
stable/4.19: [f3783c415bf6d2ead3d7aa2c38802bbe10723646]
stable/5.10: [2ee4d79c364914989c80de382c0b1a7259a7e4b3]
stable/5.4: [a62225d951d77eb20208fed8fc199e0c9b1df08b]

CVE-2021-47081: habanalabs/gaudi: Fix a potential use after free in
gaudi_memset_device_memory

Announce: https://lore.kernel.org/linux-cve-announce/2024030143-CVE-2021-47081-e590@gregkh/T/#u

Introduced by commit 423815b ("habanalabs/gaudi: remove PCI access to
SM block") in 5.12-rc1-dontuse.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc3.

Fixed status
mainline: [115726c5d312b462c9d9931ea42becdfa838a076]

CVE-2021-47069: ipc/mqueue, msg, sem: avoid relying on a stack
reference past its expiry

Announce: https://lore.kernel.org/linux-cve-announce/2024030141-CVE-2021-47069-5797@gregkh/T/#u

Introduced by commit c5b2cbd ("ipc/mqueue.c: update/document memory
barriers") in 5.6-rc1 and
8116b54 ("ipc/sem.c: document and update memory barriers") in 5.6-rc1 and
0d97a82 ("ipc/msg.c: update and document memory barriers") in 5.6-rc1.
These commits are not backported to older stable kernels.
Fixed in 5.13-rc3.

Fixed status
mainline: [a11ddb37bf367e6b5239b95ca759e5389bb46048]
stable/5.10: [4528c0c323085e645b8765913b4a7fd42cf49b65]

CVE-2021-47072: btrfs: fix removed dentries still existing after log is synced

Announce: https://lore.kernel.org/linux-cve-announce/2024030141-CVE-2021-47072-52d4@gregkh/T/#u

Introduced by commit 64d6b28 ("btrfs: remove unnecessary
check_parent_dirs_for_sync()") in 5.12-rc1-dontuse.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc3.

Fixed status
mainline: [54a40fc3a1da21b52dbf19f72fdc27a2ec740760]

CVE-2023-52477: usb: hub: Guard against accesses to uninitialized BOS
descriptors

Announce: usb: hub: Guard against accesses to uninitialized BOS descriptors

Introduced commit is not determined. It looks as if Linux 4.4 may be
affected too.
Fixed in 6.6-rc6.

Fixed status
mainline: [f74a7afc224acd5e922c7a2e52244d891bbe44ee]
stable/4.19: [8e7346bfea56453e31b7421c1c17ca2fb9ed613d]
stable/5.10: [241f230324337ed5eae3846a554fb6d15169872c]
stable/5.15: [528f0ba9f7a4bc1b61c9b6eb591ff97ca37cac6b]
stable/5.4: [6ad3e9fd3632106696692232bf7ff88b9f7e1bc3]
stable/6.1: [fb9895ab9533534335fa83d70344b397ac862c81]

CVE-2023-52487: net/mlx5e: Fix peer flow lists handling

Announce: https://lore.kernel.org/linux-cve-announce/20240229155245.1571576-28-lee@kernel.org/T/#u

Introduced by commit 9be6c21 ("net/mlx5e: Handle offloads flows per
peer") in 6.5-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc2.

Fixed status
mainline: [d76fdd31f953ac5046555171620f2562715e9b71]
stable/6.6: [74cec142f89bf85c6c99c5db957da9f663f9f16f]
stable/6.7: [e24d6f5a7f2d95a98a46257a5a5a5381d572894f]

CVE-2023-52495: soc: qcom: pmic_glink_altmode: fix port sanity check

Announce: https://lore.kernel.org/linux-cve-announce/20240229155245.1571576-36-lee@kernel.org/T/#u

Introduced by commit 080b4e2 ("soc: qcom: pmic_glink: Introduce
altmode support") in 6.3-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [c4fb7d2eac9ff9bfc35a2e4d40c7169a332416e0]
stable/6.6: [532a5557da6892a6b2d5793052e1bce1f4c9e177]
stable/6.7: [d26edf4ee3672cc9828f2a3ffae34086a712574d]

CVE-2023-52496: mtd: maps: vmu-flash: Fix the (mtd core) switch to ref counters

Announce: https://lore.kernel.org/linux-cve-announce/20240229155245.1571576-37-lee@kernel.org/T/#u

Introduced by commit 19bfa9e ("mtd: use refcount to prevent
corruption") in 6.6-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [a7d84a2e7663bbe12394cc771107e04668ea313a]
stable/6.6: [38c12f10990ad6e63ddef2f20c1b066e5e4d34fd]
stable/6.7: [1168d6b79d2fafb41299fbc1b528e20644c562a5]

CVE-2023-52490: mm: migrate: fix getting incorrect page mapping during
page migration

Announce: https://lore.kernel.org/linux-cve-announce/20240229155245.1571576-31-lee@kernel.org/T/#u

Introduced by commit 64c8902 ("migrate_pages: split unmap_and_move()
to _unmap() and _move()") in 6.3-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [d1adb25df7111de83b64655a80b5a135adbded61]
stable/6.6: [9128bfbc5c80d8f4874dd0a0424d1f5fb010df1b]
stable/6.7: [3889a418b6eb9a1113fb989aaadecf2f64964767]

CVE-2023-52478: HID: logitech-hidpp: Fix kernel crash on receiver USB disconnect

Announce: https://lore.kernel.org/linux-cve-announce/2024022921-CVE-2023-52478-c0a1@gregkh/T/#u

Introduced commit is not determined. Fixed in 6.6-rc6.

Fixed status
cip/4.4: [60b2e00632dafe730b3e7f258b286b04b49d59e4]
cip/4.4-rt: [60b2e00632dafe730b3e7f258b286b04b49d59e4]
cip/4.4-st: [60b2e00632dafe730b3e7f258b286b04b49d59e4]
mainline: [dac501397b9d81e4782232c39f94f4307b137452]
stable/4.19: [44481b244fcaa2b895a53081d6204c574720c38c]
stable/5.10: [093af62c023537f097d2ebdfaa0bc7c1a6e874e1]
stable/5.15: [28ddc1e0b898291323b62d770b1b931de131a528]
stable/5.4: [cd0e2bf7fb22fe9b989c59c42dca06367fd10e6b]
stable/6.1: [fd72ac9556a473fc7daf54efb6ca8a97180d621d]

CVE-2023-52475: Input: powermate - fix use-after-free in
powermate_config_complete

Announce: https://lore.kernel.org/linux-cve-announce/2024022918-CVE-2023-52475-442e@gregkh/T/#u

Introduced commit is not determined. Fixed in 6.6-rc6.

Fixed status
cip/4.4: [a2557fa768734fc895d8201475a7dedd775089bb]
cip/4.4-rt: [a2557fa768734fc895d8201475a7dedd775089bb]
cip/4.4-st: [a2557fa768734fc895d8201475a7dedd775089bb]
mainline: [5c15c60e7be615f05a45cd905093a54b11f461bc]
stable/4.19: [67cace72606baf1758fd60feb358f4c6be92e1cc]
stable/5.10: [cd2fbfd8b922b7fdd50732e47d797754ab59cb06]
stable/5.15: [6a4a396386404e62fb59bc3bde48871a64a82b4f]
stable/5.4: [5aa514100aaf59868d745196258269a16737c7bd]
stable/6.1: [2efe67c581a2a6122b328d4bb6f21b3f36f40d46]

CVE-2023-52483: mctp: perform route lookups under a RCU read-side lock

Announce: https://lore.kernel.org/linux-cve-announce/2024022923-CVE-2023-52483-5b9d@gregkh/T/#u

Introduced by commit 889b7da ("mctp: Add initial routing framework")
in 5.15-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.6-rc6.

Fixed status
mainline: [5093bbfc10ab6636b32728e35813cbd79feb063c]
stable/5.15: [6c52b12159049046483fdb0c411a0a1869c41a67]
stable/6.1: [1db0724a01b558feb1ecae551782add1951a114a]

CVE-2024-26612: netfs, fscache: Prevent Oops in fscache_put_cache()

Announce: https://lore.kernel.org/linux-cve-announce/20240229155245.1571576-44-lee@kernel.org/T/#u

Introduced by commit 9549332 ("fscache: Implement cache registration")
in 5.17-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc2.

Fixed status
mainline: [3be0b3ed1d76c6703b9ee482b55f7e01c369cc68]
stable/6.1: [82a9bc343ba019665d3ddc1d9a180bf0e0390cf3]
stable/6.6: [1c45256e599061021e2c848952e50f406457e448]
stable/6.7: [4200ad3e46ce50f410fdda302745489441bc70f0]

CVE-2024-26617: fs/proc/task_mmu: move mmu notification mechanism inside mm lock

Announce: https://lore.kernel.org/linux-cve-announce/20240229155245.1571576-49-lee@kernel.org/T/#u

Introduced by commit 52526ca ("fs/proc/task_mmu: implement IOCTL to
get and optionally clear info about PTEs") in 6.7-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [4cccb6221cae6d020270606b9e52b1678fc8b71a]
stable/6.7: [05509adf297924f51e1493aa86f9fcde1433ed80]

CVE-2024-26616: btrfs: scrub: avoid use-after-free when chunk length
is not 64K aligned

Announce: https://lore.kernel.org/linux-cve-announce/20240229155245.1571576-48-lee@kernel.org/T/#u

Introduced by commit e02ee89 ("btrfs: scrub: switch
scrub_simple_mirror() to scrub_stripe infrastructure") in 6.4-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc2.

Fixed status
mainline: [f546c4282673497a06ecb6190b50ae7f6c85b02f]
stable/6.6: [642b9c520ef2f104277ad1f902f8526edbe087fb]
stable/6.7: [34de0f04684ec00c093a0455648be055f0e8e24f]

CVE-2024-26611: xsk: fix usage of multi-buffer BPF helpers for ZC XDP

Announce: https://lore.kernel.org/linux-cve-announce/20240229155245.1571576-43-lee@kernel.org/T/#u

Introduced by commit 24ea501 ("xsk: support mbuf on ZC RX") in 6.6-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc2.

Fixed status
mainline: [c5114710c8ce86b8317e9b448f4fd15c711c2a82]
stable/6.6: [82ee4781b8200e44669a354140d5c6bd966b8768]
stable/6.7: [5cd781f7216f980207af09c5e0e1bb1eda284540]

CVE-2024-26608: ksmbd: fix global oob in ksmbd_nl_policy

Announce: https://lore.kernel.org/linux-cve-announce/20240229155245.1571576-40-lee@kernel.org/T/#u

Introduced by commit 0626e66 ("cifsd: add server handler for central
processing and tranport layers") in 5.15-rc1.
ksmbd is introduced in 5.15 so 5.10, 5.4, and 4.x kernels are not affected.
Fixed in 6.8-rc2.

Fixed status
mainline: [ebeae8adf89d9a82359f6659b1663d09beec2faa]
stable/5.15: [aaa1f1a2ee80888c12ae2783f3a0be10e14067c5]
stable/6.1: [2c939c74ef0b74e99b92e32edc2a59f9b9ca3d5a]
stable/6.6: [9863a53100f47652755545c2bd43e14a1855104d]
stable/6.7: [6993328a4cd62a24df254b587c0796a4a1eecc95]

CVE-2024-26620: s390/vfio-ap: always filter entire AP matrix

Announce: https://lore.kernel.org/linux-cve-announce/20240229155245.1571576-52-lee@kernel.org/T/#u

Introduced by commit 48cae94 ("s390/vfio-ap: refresh guest's APCB by
filtering AP resources assigned to mdev") in 6.0-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [850fb7fa8c684a4c6bf0e4b6978f4ddcc5d43d11]
stable/6.1: [d6b8d034b576f406af920a7bee81606c027b24c6]
stable/6.6: [c69d821197611678533fb3eb784fc823b921349a]
stable/6.7: [cdd134d56138302976685e6c7bc4755450b3880e]

CVE-2024-26619: riscv: Fix module loading free order

Announce: https://lore.kernel.org/linux-cve-announce/20240229155245.1571576-51-lee@kernel.org/T/#u

Introduced by commit d8792a5 ("riscv: Safely remove entries from
relocation list") in 6.7-rc5.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [78996eee79ebdfe8b6f0e54cb6dcc792d5129291]
stable/6.7: [2fa79badf4bfeffda6b5032cf62b828486ec9a99]

CVE-2022-48627: vt: fix memory overlapping when deleting chars in the buffer

Announce: https://lore.kernel.org/linux-cve-announce/2024030252-CVE-2022-48627-c7bf@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 81732c3 ("tty vt: Fix line garbage in virtual
console on command line edition") in v3.7-rc1.
Fixed in v5.19-rc7.

Fixed status
mainline: [39cdb68c64d84e71a4a717000b6e5de208ee60cc]
stable/5.10: [bfee93c9a6c395f9aa62268f1cedf64999844926]
stable/5.15: [57964a5710252bc82fe22d9fa98c180c58c20244]

CVE-2022-48628: ceph: drop messages from MDS when unmounting

Announce: https://lore.kernel.org/linux-cve-announce/2024030245-CVE-2022-48628-181a@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.6-rc1.

Fixed status
mainline: [e3dfcab2080dc1f9a4b09cc1327361bc2845bfcd]
stable/6.1: [89744b64914426cbabceb3d8a149176b5dafdfb5]

CVE-2023-52499: powerpc/47x: Fix 47x syscall return crash

Announce: https://lore.kernel.org/linux-cve-announce/2024030247-CVE-2023-52499-1b6f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6f76a01 ("powerpc/syscall: implement system call
entry/exit logic in C for PPC32") in v5.12-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.6-rc6.

Fixed status
mainline: [f0eee815babed70a749d2496a7678be5b45b4c14]
stable/5.15: [29017ab1a539101d9c7bec63cc13a019f97b2820]
stable/6.1: [8ac2689502f986a46f4221e239d4ff2897f1ccb3]

CVE-2023-52500: scsi: pm80xx: Avoid leaking tags when processing
OPC_INB_SET_CONTROLLER_CONFIG command

Announce: https://lore.kernel.org/linux-cve-announce/2024030248-CVE-2023-52500-3d53@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.6-rc2.

Fixed status
mainline: [c13e7331745852d0dd7c35eabbe181cbd5b01172]
stable/5.10: [2afd8fcee0c4d65a482e30c3ad2a92c25e5e92d4]
stable/5.15: [d540a4370aba378fbedf349ba0bb68e96e24243d]
stable/6.1: [2259e1901b2d8c0e8538fc99e77de443b939e749]

CVE-2023-52501: ring-buffer: Do not attempt to read past "commit"

Announce: https://lore.kernel.org/linux-cve-announce/2024030248-CVE-2023-52501-75ba@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.6-rc2.
It seems as if 4.19 and 4.4 are affected.

Fixed status
mainline: [95a404bd60af6c4d9d8db01ad14fe8957ece31ca]
stable/5.10: [cee5151c5410e868826b8afecfb356f3799ebea3]
stable/5.15: [344f2f3e61a90f0150c754796ec9a17fcaeec03d]
stable/6.1: [b08a4938229dbb530a35c41b83002a1457c6ff49]

CVE-2023-52502: net: nfc: fix races in nfc_llcp_sock_get() and
nfc_llcp_sock_get_sn()

Announce: https://lore.kernel.org/linux-cve-announce/2024030248-CVE-2023-52502-6863@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8f50020 ("NFC: LLCP late binding") in v3.6-rc1.
Fixed in v6.6-rc6.

Fixed status
mainline: [31c07dffafce914c1d1543c135382a11ff058d93]
stable/4.19: [e863f5720a5680e50c4cecf12424d7cc31b3eb0a]
stable/5.10: [6ac22ecdaad2ecc662048f8c6b0ceb1ca0699ef9]
stable/5.15: [d888d3f70b0de32b4f51534175f039ddab15eef8]
stable/5.4: [7adcf014bda16cdbf804af5c164d94d5d025db2d]
stable/6.1: [e4f2611f07c87b3ddb57c4b9e8efcd1e330fc3dc]

CVE-2023-52503: tee: amdtee: fix use-after-free vulnerability in
amdtee_close_session

Announce: https://lore.kernel.org/linux-cve-announce/2024030248-CVE-2023-52503-cb3a@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 757cc3e ("tee: add AMD-TEE driver") in v5.6-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.6-rc6.

Fixed status
mainline: [f4384b3e54ea813868bb81a861bf5b2406e15d8f]
stable/5.10: [da7ce52a2f6c468946195b116615297d3d113a27]
stable/5.15: [1680c82929bc14d706065f123dab77f2f1293116]
stable/6.1: [60c3e7a00db954947c265b55099c21b216f2a05c]

CVE-2023-52504: x86/alternatives: Disable KASAN in apply_alternatives()

Announce: https://lore.kernel.org/linux-cve-announce/2024030249-CVE-2023-52504-ebc5@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6657fca ("x86/mm: Allow to boot without LA57 if
CONFIG_X86_5LEVEL=y") in v4.17-rc1.
Linux 4.4 is not affected.
Fixed in v6.6-rc6.

Fixed status
mainline: [d35652a5fc9944784f6f50a5c979518ff8dacf61]
stable/4.19: [3719d3c36aa853d5a2401af9f8d6b116c91ad5ae]
stable/5.10: [6788b10620ca6e98575d1e06e72a8974aad7657e]
stable/5.15: [ecba5afe86f30605eb9dfb7f265a8de0218d4cfc]
stable/5.4: [3770c38cd6a60494da29ac2da73ff8156440a2d1]
stable/6.1: [5b784489c8158518bf7a466bb3cc045b0fb66b4b]

CVE-2023-52505: phy: lynx-28g: serialize concurrent phy_set_mode_ext()
calls to shared registers

Announce: https://lore.kernel.org/linux-cve-announce/2024030249-CVE-2023-52505-8ac5@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8f73b37 ("phy: add support for the Layerscape
SerDes 28G") in v5.18-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.6-rc6.

Fixed status
mainline: [139ad1143151a07be93bf741d4ea7c89e59f89ce]
stable/6.1: [6f901f8448c6b25ed843796b114471d2a3fc5dfb]

CVE-2023-52506: LoongArch: Set all reserved memblocks on Node#0 at
initialization

Announce: https://lore.kernel.org/linux-cve-announce/2024030249-CVE-2023-52506-2b5a@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.6-rc3.
The LoonArch architecture is introduced in 5.19.

Fixed status
mainline: [b795fb9f5861ee256070d59e33130980a01fadd7]
stable/6.1: [f105e893a8edd48bdf4bef9fef845a9ff402f737]

CVE-2023-52507: nfc: nci: assert requested protocol is valid

Announce: https://lore.kernel.org/linux-cve-announce/2024030249-CVE-2023-52507-030c@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6a2968a ("NFC: basic NCI protocol
implementation") in v3.2-rc1.
Fixed in v6.6-rc6.

Fixed status
cip/4.4: [b33ea19edf8559941bd5b924fd2433cbc9eadd58]
cip/4.4-rt: [b33ea19edf8559941bd5b924fd2433cbc9eadd58]
cip/4.4-st: [b33ea19edf8559941bd5b924fd2433cbc9eadd58]
mainline: [354a6e707e29cb0c007176ee5b8db8be7bd2dee0]
stable/4.19: [a686f84101680b8442181a8846fbd3c934653729]
stable/5.10: [a424807d860ba816aaafc3064b46b456361c0802]
stable/5.15: [25dd54b95abfdca423b65a4ee620a774777d8213]
stable/5.4: [95733ea130e35ef9ec5949a5908dde3feaba92cb]
stable/6.1: [853dda54ba59ea70d5580a298b7ede4707826848]

CVE-2023-52508: nvme-fc: Prevent null pointer dereference in
nvme_fc_io_getuuid()

Announce: https://lore.kernel.org/linux-cve-announce/2024030250-CVE-2023-52508-359c@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.6-rc2.
Vulnerable function is introduced by commit 827fc630e ("scsi: nvme-fc:
Add new routine nvme_fc_io_getuuid()") in 5.19-rc1.

Fixed status
mainline: [8ae5b3a685dc59a8cf7ccfe0e850999ba9727a3c]
stable/6.1: [be90c9e29dd59b7d19a73297a1590ff3ec1d22ea]

CVE-2023-52509: ravb: Fix use-after-free issue in ravb_tx_timeout_work()

Announce: https://lore.kernel.org/linux-cve-announce/2024030250-CVE-2023-52509-997c@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c156633 ("Renesas Ethernet AVB driver proper") in v4.2-rc1.
Fixed in v6.6-rc6.

Fixed status
mainline: [3971442870713de527684398416970cf025b4f89]
stable/5.10: [db9aafa19547833240f58c2998aed7baf414dc82]
stable/5.15: [616761cf9df9af838c0a1a1232a69322a9eb67e6]
stable/5.4: [65d34cfd4e347054eb4193bc95d9da7eaa72dee5]
stable/6.1: [6f6fa8061f756aedb93af12a8a5d3cf659127965]

CVE-2023-52510: ieee802154: ca8210: Fix a potential UAF in ca8210_probe

Announce: https://lore.kernel.org/linux-cve-announce/2024030250-CVE-2023-52510-6f8a@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ded845a ("ieee802154: Add CA8210 IEEE 802.15.4
device driver") in v4.12-rc1.
Linux 4.4 is not affected.
Fixed in v6.6-rc6.

Fixed status
mainline: [f990874b1c98fe8e57ee9385669f501822979258]
stable/4.19: [cdb46be93c1f7bbf2c4649e9fc5fb147cfb5245d]
stable/5.10: [55e06850c7894f00d41b767c5f5665459f83f58f]
stable/5.15: [84c6aa0ae5c4dc121f9996bb8fed46c80909d80e]
stable/5.4: [85c2857ef90041f567ce98722c1c342c4d31f4bc]
stable/6.1: [217efe32a45249eb07dcd7197e8403de98345e66]

CVE-2023-52511: spi: sun6i: reduce DMA RX transfer width to single byte

Announce: https://lore.kernel.org/linux-cve-announce/2024030250-CVE-2023-52511-1dbc@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.6-rc1.
Vulnerable function sun6i_spi_prepare_dma() is introcued by commit
345980a  ("spi: spi-sun6i: implement DMA-based transfer mode") in
5.11-rc1.

Fixed status
mainline: [171f8a49f212e87a8b04087568e1b3d132e36a18]
stable/5.15: [ff05ed4ae214011464a0156f05cac1b0b46b5fbc]
stable/6.1: [e15bb292b24630ee832bfc7fd616bd72c7682bbb]

CVE-2023-52512: pinctrl: nuvoton: wpcm450: fix out of bounds write

Announce: https://lore.kernel.org/linux-cve-announce/2024030251-CVE-2023-52512-92f7@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a1d1e0e ("pinctrl: nuvoton: Add driver for
WPCM450") in v5.18-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.6-rc6.

Fixed status
mainline: [87d315a34133edcb29c4cadbf196ec6c30dfd47b]
stable/6.1: [6c18c386fd13dbb3ff31a1086dabb526780d9bda]

CVE-2023-52513: RDMA/siw: Fix connection failure handling

Announce: https://lore.kernel.org/linux-cve-announce/2024030251-CVE-2023-52513-5224@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6c52fdc ("rdma/siw: connection management") in v5.3-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.6-rc5.

Fixed status
mainline: [53a3f777049771496f791504e7dc8ef017cba590]
stable/5.10: [0d520cdb0cd095eac5d00078dfd318408c9b5eed]
stable/5.15: [81b7bf367eea795d259d0261710c6a89f548844d]
stable/5.4: [6e26812e289b374c17677d238164a5a8f5770594]
stable/6.1: [5cf38e638e5d01b68f9133968a85e8b3fd1ecf2f]

CVE-2023-52514: x86/reboot: VMCLEAR active VMCSes before emergency reboot

Announce: https://lore.kernel.org/linux-cve-announce/2024030251-CVE-2023-52514-c93d@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.6-rc1.

Fixed status
mainline: [b23c83ad2c638420ec0608a9de354507c41bec29]
stable/6.1: [1375d9600c38c231163de584656b07aef9a27b0d]

CVE-2023-52515: RDMA/srp: Do not call scsi_done() from srp_abort()

Announce: https://lore.kernel.org/linux-cve-announce/2024030251-CVE-2023-52515-5af7@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d853667 ("IB/srp: Avoid having aborted requests
hang") in v3.7-rc1.
Fixed in v6.6-rc5.

Fixed status
mainline: [e193b7955dfad68035b983a0011f4ef3590c85eb]
stable/5.10: [26788a5b48d9d5cd3283d777d238631c8cd7495a]
stable/5.15: [b9bdffb3f9aaeff8379c83f5449c6b42cb71c2b5]
stable/6.1: [2b298f9181582270d5e95774e5a6c7a7fb5b1206]

CVE-2023-52516: dma-debug: don't call __dma_entry_alloc_check_leak()
under free_entries_lock

Announce: https://lore.kernel.org/linux-cve-announce/2024030252-CVE-2023-52516-9b4a@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.6-rc1.

Fixed status
mainline: [fb5a4315591dae307a65fc246ca80b5159d296e1]
stable/5.10: [c79300599923daaa30f417c75555d5566b3d31ae]
stable/5.15: [ac0d068099349cbca3d93f2e3b15bb329364b08c]
stable/6.1: [be8f49029eca3efbad0d74dbff3cb9129994ffab]

CVE-2023-52517: spi: sun6i: fix race between DMA RX transfer
completion and RX FIFO drain

Announce: https://lore.kernel.org/linux-cve-announce/2024030252-CVE-2023-52517-30dc@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.6-rc1.

Fixed status
mainline: [1f11f4202caf5710204d334fe63392052783876d]
stable/5.15: [bd1ec7f9983b5cd3c77e0f7cda3fa8aed041af2f]
stable/6.1: [36b29974a7ad2ff604c24ad348f940506c7b1209]

CVE-2023-52518: Bluetooth: hci_codec: Fix leaking content of local_codecs

Announce: https://lore.kernel.org/linux-cve-announce/2024030251-CVE-2023-52518-bcfa@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8961987 ("Bluetooth: Enumerate local supported
codec and cache details") in v5.16-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.6-rc5.

Fixed status
mainline: [b938790e70540bf4f2e653dcd74b232494d06c8f]
stable/6.1: [626535077ba9dc110787540d1fe24881094c15a1]

CVE-2023-52519: HID: intel-ish-hid: ipc: Disable and reenable ACPI GPE bit

Announce: https://lore.kernel.org/linux-cve-announce/2024030252-CVE-2023-52519-d53f@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2e23a70 ("HID: intel-ish-hid: ipc: finish power
flow for EHL OOB") in v5.12-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.6-rc5.

Fixed status
mainline: [8f02139ad9a7e6e5c05712f8c1501eebed8eacfd]
stable/5.15: [8781fe259dd5a178fdd1069401bbd1437f9491c5]
stable/6.1: [cdcc04e844a2d22d9d25cef1e8e504a174ea9f8f]

CVE-2023-52520: platform/x86: think-lmi: Fix reference leak

Announce: https://lore.kernel.org/linux-cve-announce/2024030252-CVE-2023-52520-0a4e@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1bcad8e ("platform/x86: think-lmi: Fix issues
with duplicate attributes") in v5.14-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.6-rc5.

Fixed status
mainline: [528ab3e605cabf2f9c9bd5944d3bfe15f6e94f81]
stable/5.15: [124cf0ea4b82e1444ec8c7420af4e7db5558c293]
stable/6.1: [af21c9119a37cecb7ff27ce0c2f3cf721e9d0ec4]

CVE-2023-52521: bpf: Annotate bpf_long_memcpy with data_race

Announce: https://lore.kernel.org/linux-cve-announce/2024030253-CVE-2023-52521-d847@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

This CVE is rejected
Introduced commit is not determined.Fixed in v6.6-rc1.
The bpf_long_memcpy function is introduced in15a07b33 ("bpf: add
lookup/update support for per-cpu hash and array maps") in 4.6-rc1.

Fixed status
mainline: [6a86b5b5cd76d2734304a0173f5f01aa8aa2025e]
stable/6.1: [5685f8a6fae1fbe480493b980a1fdbe67c86a094]

CVE-2023-52522: net: fix possible store tearing in neigh_periodic_work()

Announce: https://lore.kernel.org/linux-cve-announce/2024030253-CVE-2023-52522-6abd@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 767e97e ("neigh: RCU conversion of struct
neighbour") in v2.6.37-rc1.
Fixed in v6.6-rc5.

Fixed status
mainline: [25563b581ba3a1f263a00e8c9a97f5e7363be6fd]
stable/5.10: [2ea52a2fb8e87067e26bbab4efb8872639240eb0]
stable/5.15: [147d89ee41434b97043c2dcb17a97dc151859baa]
stable/5.4: [95eabb075a5902f4c0834ab1fb12dc35730c05af]
stable/6.1: [f82aac8162871e87027692b36af335a2375d4580]

CVE-2023-52523: bpf, sockmap: Reject sk_msg egress redirects to non-TCP sockets

Announce: https://lore.kernel.org/linux-cve-announce/2024030253-CVE-2023-52523-5ae2@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 122e6c7 ("sock_map: Update sock type checks for
UDP") in v5.13-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.6-rc5.

Fixed status
mainline: [b80e31baa43614e086a9d29dc1151932b1bd7fc5]
stable/5.15: [bc8b89b6963803a123f64aa9494155a037b3d728]
stable/6.1: [b8f97e47b6fb84fcf2f5a22e725eefb6cf5070c2]

CVE-2023-52524: net: nfc: llcp: Add lock when modifying device list

Announce: https://lore.kernel.org/linux-cve-announce/2024030253-CVE-2023-52524-a5e0@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6709d4b ("net: nfc: Fix use-after-free caused by
nfc_llcp_find_local") in v6.5-rc1.
This commit is backported to 5.4, 5.10, 5.15, and 6.1. Linux 4.4 is
not affected.
Fixed in v6.6-rc5.

Fixed status
mainline: [dfc7f7a988dad34c3bf4c053124fb26aa6c5f916]
stable/5.10: [dba849cc98113b145c6e720122942c00b8012bdb]
stable/5.15: [4837a192f6d06d5bb2f3f47d6ce5353ab69bf86b]
stable/5.4: [191d87a19cf1005ecf41e1ae08d74e17379e8391]
stable/6.1: [7562780e32b84196731d57dd24563546fcf6d082]

CVE-2023-52525: wifi: mwifiex: Fix oob check condition in
mwifiex_process_rx_packet

Announce: https://lore.kernel.org/linux-cve-announce/2024030254-CVE-2023-52525-3989@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

This CVE announce does not contain fixed commit in the mainline.
The commit aef7a030 ("wifi: mwifiex: Fix oob check condition in
mwifiex_process_rx_packet ") fixes in the mainline.
It's intdouced by commit 1195852 ("wifi: mwifiex: Fix OOB and integer
underflow when rx packets") in 6.6-rc1.

Fixed status
cip/4.4: [ad1e56ff6e81e312f70ab00930f7c85f0a69ee38]
cip/4.4-rt: [ad1e56ff6e81e312f70ab00930f7c85f0a69ee38]
cip/4.4-st: [ad1e56ff6e81e312f70ab00930f7c85f0a69ee38]
mainline: [aef7a0300047e7b4707ea0411dc9597cba108fc8]
stable/4.19: [16cc18b9080892d1a0200a38e36ae52e464bc555]
stable/5.10: [10a18c8bac7f60d32b7af22da03b66f350beee38]
stable/5.15: [5afb996349cb6d1f14d6ba9aaa7aed3bd82534f6]
stable/5.4: [b8e260654a29de872e7cb85387d8ab8974694e8e]
stable/6.1: [6b706286473db4fd54b5f869faa67f4a8cb18e99]

CVE-2023-52526: erofs: fix memory leak of LZMA global compressed deduplication

Announce: https://lore.kernel.org/linux-cve-announce/2024030254-CVE-2023-52526-8928@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5c2a642 ("erofs: introduce partial-referenced
pclusters") in v6.1-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.6-rc5.

Fixed status
mainline: [75a5221630fe5aa3fedba7a06be618db0f79ba1e]
stable/6.1: [6a5a8f0a9740f865693d5aa97a42cc4504538e18]

CVE-2023-52527: ipv4, ipv6: Fix handling of transhdrlen in
__ip{,6}_append_data()

Announce: https://lore.kernel.org/linux-cve-announce/2024030254-CVE-2023-52527-a1e8@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a32e0ee ("l2tp: introduce L2TPv3 IP encapsulation
support for IPv6") in v3.5-rc1.
Fixed in v6.6-rc5.

Fixed status
cip/4.4: [b4985ece59e38e3b46fa2c5a23fd73aae300999b]
cip/4.4-rt: [b4985ece59e38e3b46fa2c5a23fd73aae300999b]
cip/4.4-st: [b4985ece59e38e3b46fa2c5a23fd73aae300999b]
mainline: [9d4c75800f61e5d75c1659ba201b6c0c7ead3070]
stable/4.19: [559d697c5d072593d22b3e0bd8b8081108aeaf59]
stable/5.10: [96b2e1090397217839fcd6c9b6d8f5d439e705ed]
stable/5.15: [cd1189956393bf850b2e275e37411855d3bd86bb]
stable/5.4: [1fc793d68d50dee4782ef2e808913d5dd880bcc6]
stable/6.1: [f6a7182179c0ed788e3755ee2ed18c888ddcc33f]

CVE-2023-52528: net: usb: smsc75xx: Fix uninit-value access in
__smsc75xx_read_reg

Announce: https://lore.kernel.org/linux-cve-announce/2024030254-CVE-2023-52528-c33b@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d0cad87 ("smsc75xx: SMSC LAN75xx USB gigabit
ethernet adapter driver") in v2.6.34-rc2.
Fixed in v6.6-rc5.

Fixed status
cip/4.4: [7149c409c334776ebfcca45f37ee98c723c87eed]
cip/4.4-rt: [7149c409c334776ebfcca45f37ee98c723c87eed]
cip/4.4-st: [7149c409c334776ebfcca45f37ee98c723c87eed]
mainline: [e9c65989920f7c28775ec4e0c11b483910fb67b8]
stable/4.19: [2a36d9e2995c8c3c3f179aab1215a69cff06cbed]
stable/5.10: [30bc4d7aebe33904b0f2d3aad4b4a9c6029ad0c5]
stable/5.15: [cda10784a176d7192f08ecb518f777a4e9575812]
stable/5.4: [310f1c92f65ad905b7e81fe14de82d979ebbd825]
stable/6.1: [9ffc5018020fe646795a8dc1203224b8f776dc09]

CVE-2023-52529: HID: sony: Fix a potential memory leak in sony_probe()

Announce: https://lore.kernel.org/linux-cve-announce/2024030255-CVE-2023-52529-56ff@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit fb1a79a ("HID: sony: fix freeze when inserting
ghlive ps3/wii dongles") in v5.14-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.6-rc5.

Fixed status
mainline: [e1cd4004cde7c9b694bbdd8def0e02288ee58c74]
stable/5.15: [bb0707fde7492121917fd9ddb43829e96ec0bb9e]
stable/6.1: [f237b17611fa3501f43f12d1cb64323e10fdcb4f]

CVE-2023-52530: wifi: mac80211: fix potential key use-after-free

Announce: https://lore.kernel.org/linux-cve-announce/2024030255-CVE-2023-52530-ebf0@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit fdf7cb4 ("mac80211: accept key reinstall without
changing anything") in v4.14-rc6.
This commit is not backported to older stable kernels.
Fixed in v6.6-rc5.

Fixed status
mainline: [31db78a4923ef5e2008f2eed321811ca79e7f71b]
stable/6.1: [2f4e16e39e4f5e78248dd9e51276a83203950b36]

CVE-2023-52531: wifi: iwlwifi: mvm: Fix a memory corruption issue

Announce: https://lore.kernel.org/linux-cve-announce/2024030255-CVE-2023-52531-be21@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8ca151b ("iwlwifi: add the MVM driver") in v3.9-rc1.
Fixed in v6.6-rc5.

Fixed status
mainline: [8ba438ef3cacc4808a63ed0ce24d4f0942cfe55d]
stable/5.15: [7c8faa31080342aec4903c9acb20caf82fcca1ef]
stable/6.1: [6b3223449c959a8be94a1f042288059e40fcccb0]

CVE-2023-52532: net: mana: Fix TX CQE error handling

Announce: https://lore.kernel.org/linux-cve-announce/2024030255-CVE-2023-52532-57db@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ca9c54d ("net: mana: Add a driver for Microsoft
Azure Network Adapter (MANA)") in v5.13-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.6-rc5.

Fixed status
mainline: [b2b000069a4c307b09548dc2243f31f3ca0eac9c]
stable/6.1: [b67d7b1bfc46d05c1a58b172516454698e8d5004]

CVE-2023-52559: iommu/vt-d: Avoid memory allocation in iommu_suspend()

Announce: https://lore.kernel.org/linux-cve-announce/2024030252-CVE-2023-52559-680e@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 33e0715 ("iommu/vt-d: Avoid GFP_ATOMIC where it
is not needed") in v5.11-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.6-rc5.

Fixed status
mainline: [59df44bfb0ca4c3ee1f1c3c5d0ee8e314844799e]
stable/5.15: [29298c85a81abdc512e87537515ed4b1a9601d0e]
stable/6.1: [c12ef025add77ca3a0902e8719d552b6d47b4282]

CVE-2023-52560: mm/damon/vaddr-test: fix memory leak in
damon_do_test_apply_three_regions()

Announce: https://lore.kernel.org/linux-cve-announce/2024030252-CVE-2023-52560-c3de@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9f86d62 ("mm/damon/vaddr-test: remove unnecessary
variables") in v5.16-rc5.
This commit is not backported to older stable kernels.
Fixed in v6.6-rc4.

Fixed status
mainline: [45120b15743fa7c0aa53d5db6dfb4c8f87be4abd]
stable/6.1: [9a4fe81a8644b717d57d81ce5849e16583b13fe8]

CVE-2023-52561: arm64: dts: qcom: sdm845-db845c: Mark cont splash
memory region as reserved

Announce: https://lore.kernel.org/linux-cve-announce/2024030253-CVE-2023-52561-89b2@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.6-rc1.
The sdm845-db845c.dts is introduced by commit 3f72e2d3 in ("arm64:
dts: qcom: Add Dragonboard 845c")

Fixed status
mainline: [110e70fccce4f22b53986ae797d665ffb1950aa6]
stable/6.1: [dc1ab6577475b0460ba4261cd9caec37bd62ca0b]

CVE-2023-52562: mm/slab_common: fix slab_caches list corruption after
kmem_cache_destroy()

Announce: https://lore.kernel.org/linux-cve-announce/2024030253-CVE-2023-52562-da24@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0495e33 ("mm/slab_common: Deleting kobject in
kmem_cache_destroy() without holding slab_mutex/cpu_hotplug_lock") in
v6.0-rc4.
This commit is not backported to older stable kernels.
Fixed in v6.6-rc4.

Fixed status
mainline: [46a9ea6681907a3be6b6b0d43776dccc62cad6cf]
stable/6.1: [a5569bb187521432f509b69dda7d29f78b2d38b0]

CVE-2023-52563: drm/meson: fix memory leak on ->hpd_notify callback

Announce: https://lore.kernel.org/linux-cve-announce/2024030253-CVE-2023-52563-269f@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0af5e0b ("drm/meson: encoder_hdmi: switch to
bridge DRM_BRIDGE_ATTACH_NO_CONNECTOR") in v5.17-rc1.
This commit is backported to 5.15. Linux 4.4, 4.19, 5.4, 5.10 are not affected.
Fixed in v6.6-rc3.

Fixed status
mainline: [099f0af9d98231bb74956ce92508e87cbcb896be]
stable/5.15: [66cb6d74f5a1b6eafe3370b56bf2cb575a91acbc]
stable/6.1: [ee335e0094add7fc2c7034e0534e1920d61d2078]

CVE-2023-52564: Revert "tty: n_gsm: fix UAF in gsm_cleanup_mux"

Announce: https://lore.kernel.org/linux-cve-announce/2024030253-CVE-2023-52564-88cb@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9b9c819 ("tty: n_gsm: fix UAF in
gsm_cleanup_mux") in v6.5-rc4.
This commit is backported to 5.10 and 5.15. Linux 4.x and 5.4 are not affected.
Fixed in v6.6-rc4.

Fixed status
mainline: [29346e217b8ab8a52889b88f00b268278d6b7668]
stable/5.10: [6d5c8862932d31a810b6545f7d69ecc124402c6e]
stable/5.15: [a48d2bcd23f2c98d575bc2f9b7a3fbd16aeea9eb]
stable/6.1: [c61d0b87a7028c2c10faffc524d748334c7b9827]

CVE-2023-52565: media: uvcvideo: Fix OOB read

Announce: https://lore.kernel.org/linux-cve-announce/2024030254-CVE-2023-52565-07ce@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 40140ed ("media: uvcvideo: Implement mask for
V4L2_CTRL_TYPE_MENU") in v6.3-rc1.
This commit is backported to 6.1. Linux 4.x and 5.x are not affected.
Fixed in v6.6-rc3.

Fixed status
mainline: [41ebaa5e0eebea4c3bac96b72f9f8ae0d77c0bdb]
stable/6.1: [09635bf4cdd4adf2160198a6041bcc7ca46c0558]

CVE-2023-52566: nilfs2: fix potential use after free in
nilfs_gccache_submit_read_data()

Announce: https://lore.kernel.org/linux-cve-announce/2024030254-CVE-2023-52566-69f0@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a3d93f7 ("nilfs2: block cache for garbage
collection") in v2.6.30-rc1.
Fixed in v6.6-rc4.

Fixed status
cip/4.4: [d8accb5f4e874863faddb26bf353c2f0ec55ca56]
cip/4.4-rt: [d8accb5f4e874863faddb26bf353c2f0ec55ca56]
cip/4.4-st: [d8accb5f4e874863faddb26bf353c2f0ec55ca56]
mainline: [7ee29facd8a9c5a26079148e36bcf07141b3a6bc]
stable/4.19: [bb61224f6abc8e71bfdf06d7c984e23460875f5b]
stable/5.10: [7130a87ca32396eb9bf48b71a2d42259ae44c6c7]
stable/5.15: [3936e8714907cd55e37c7cc50e50229e4a9042e8]
stable/5.4: [193b5a1c6c67c36b430989dc063fe7ea4e200a33]
stable/6.1: [980663f1d189eedafd18d80053d9cf3e2ceb5c8c]

CVE-2023-52567: serial: 8250_port: Check IRQ data before use

Announce: https://lore.kernel.org/linux-cve-announce/2024030254-CVE-2023-52567-38c1@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0ba9e3a ("serial: 8250: Add missing wakeup event
reporting") in v6.4-rc1.
This commit is backpoted to older stable kernels.
Fixed in v6.6-rc4.

Fixed status
cip/4.4: [0d4146285759cd38fed112642796da6bec255548]
cip/4.4-rt: [0d4146285759cd38fed112642796da6bec255548]
cip/4.4-st: [0d4146285759cd38fed112642796da6bec255548]
mainline: [cce7fc8b29961b64fadb1ce398dc5ff32a79643b]
stable/4.19: [c334650150c29234b0923476f51573ae1b2f252a]
stable/5.10: [e14afa4450cb7e4cf93e993a765801203d41d014]
stable/5.15: [2b837f13a818f96304736453ac53b66a70aaa4f2]
stable/5.4: [bf3c728e3692cc6d998874f0f27d433117348742]
stable/6.1: [e14f68a48fd445a083ac0750fafcb064df5f18f7]

CVE-2023-52568: x86/sgx: Resolves SECS reclaim vs. page fault for EAUG race

Announce: https://lore.kernel.org/linux-cve-announce/2024030255-CVE-2023-52568-b5c6@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5a90d2c ("x86/sgx: Support adding of pages to an
initialized enclave") in v6.0-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.6-rc4.

Fixed status
mainline: [c6c2adcba50c2622ed25ba5d5e7f05f584711358]
stable/6.1: [811ba2ef0cb6402672e64ba1419d6ef95aa3405d]

CVE-2023-52569: btrfs: remove BUG() after failure to insert delayed
dir index item

Announce: https://lore.kernel.org/linux-cve-announce/2024030255-CVE-2023-52569-a9c1@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.6-rc2.

Fixed status
mainline: [2c58c3931ede7cd08cbecf1f1a4acaf0a04a41a9]
stable/6.1: [39c4a9522db0072570d602e9b365119e17fb9f4f]

CVE-2023-52570: vfio/mdev: Fix a null-ptr-deref bug for mdev_unregister_parent()

Announce: https://lore.kernel.org/linux-cve-announce/2024030255-CVE-2023-52570-0789@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit da44c34 ("vfio/mdev: simplify mdev_type
handling") in v6.1-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.6-rc4.

Fixed status
mainline: [c777b11d34e0f47dbbc4b018ef65ad030f2b283a]
stable/6.1: [c01b2e0ee22ef8b4dd7509a93aecc0ac0826bae4]

CVE-2023-52571: power: supply: rk817: Fix node refcount leak

Announce: https://lore.kernel.org/linux-cve-announce/2024030255-CVE-2023-52571-087e@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 54c03bf ("power: supply: Fix refcount leak in
rk817_charger_probe") in v6.2-rc1.
This commit is backported to 6.1. Linux 4.x and 5.x are not affected.
Fixed in v6.6-rc4.

Fixed status
mainline: [488ef44c068e79752dba8eda0b75f524f111a695]
stable/6.1: [fe6406238d5a24e9fb0286c71edd67b99d8db58d]

CVE-2023-52572: cifs: Fix UAF in cifs_demultiplex_thread()

Announce: https://lore.kernel.org/linux-cve-announce/2024030256-CVE-2023-52572-2b92@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ec637e3 ("[CIFS] Avoid extra large buffer
allocation (and memcpy) in cifs_readpages") in v2.6.20.16.
Fixed in v6.6-rc3.

Fixed status
mainline: [d527f51331cace562393a8038d870b3e9916686f]
stable/6.1: [908b3b5e97d25e879de3d1f172a255665491c2c3]

CVE-2023-52573: net: rds: Fix possible NULL-pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024030256-CVE-2023-52573-531c@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit fd261ce ("rds: rdma: update rdma transport for
tos") in v5.1-rc1.
This commit is not backported to 4.x kernels.
Fixed in v6.6-rc3.

Fixed status
mainline: [f1d95df0f31048f1c59092648997686e3f7d9478]
stable/5.10: [f515112e833791001aaa8ab886af3ca78503617f]
stable/5.15: [ea82139e6e3561100d38d14401d57c0ea93fc07e]
stable/5.4: [812da2a08dc5cc75fb71e29083ea20904510ac7a]
stable/6.1: [51fa66024a5eabf270164f2dc82a48ffb35a12e9]

CVE-2023-52574: team: fix null-ptr-deref when team device type is changed

Announce: https://lore.kernel.org/linux-cve-announce/2024030256-CVE-2023-52574-a423@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1d76efe ("team: add support for non-ethernet
devices") in v3.7-rc1.
Fixed in v6.6-rc3.

Fixed status
mainline: [492032760127251e5540a5716a70996bacf2a3fd]
stable/4.19: [a7fb47b9711101d2405b0eb1276fb1f9b9b270c7]
stable/5.10: [b44dd92e2afd89eb6e9d27616858e72a67bdc1a7]
stable/5.15: [cd05eec2ee0cc396813a32ef675634e403748255]
stable/5.4: [c5f6478686bb45f453031594ae19b6c9723a780d]
stable/6.1: [2f0acb0736ecc3eb85dc80ad2790d634dcb10b58]

CVE-2023-52575: x86/srso: Fix SBPB enablement for spec_rstack_overflow=off

Announce: https://lore.kernel.org/linux-cve-announce/2024030256-CVE-2023-52575-34bf@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit fb3bd91 ("x86/srso: Add a Speculative RAS
Overflow mitigation") in v6.5-rc6.
Fixed in v6.6-rc3.

According to the CVE announce, this CVE is introcued by commit fb3bd914b3ec.

```
    Issue introduced in 5.10.189 with commit 8457fb5740b1 and fixed in
5.10.198 with commit ae806c74c063
    Issue introduced in 5.15.125 with commit 153f9a7b02d4 and fixed in
5.15.134 with commit 13ea4b92e875
    Issue introduced in 6.1.44 with commit 4f25355540ad and fixed in
6.1.56 with commit adbcec23c842
    Issue introduced in 6.5 with commit fb3bd914b3ec and fixed in
6.5.6 with commit e3cb8b2c391b
    Issue introduced in 6.5 with commit fb3bd914b3ec and fixed in 6.6
with commit 01b057b2f4cc
```

However, 5.10, 5.15, and 6.1 show different subject from fb3bd914b3ec.

$ git log -n 1 --pretty=oneline fb3bd914b3ec
fb3bd914b3ec28f5fb697ac55c4846ac2d542855 x86/srso: Add a Speculative
RAS Overflow mitigation
$ git log -n 1 --pretty=oneline 4f25355540ad
4f25355540ad4d40dd3445f66159a321dad29cc8 x86/srso: Tie SBPB bit
setting to microcode patch detection
$ git log -n 1 --pretty=oneline 153f9a7b02d4
153f9a7b02d4f292671e81077e901ef01e123a9f x86/srso: Tie SBPB bit
setting to microcode patch detection
$ git log -n 1 --pretty=oneline 8457fb5740b1
8457fb5740b14311a8941044ff4eb5a3945de9b2 x86/srso: Tie SBPB bit
setting to microcode patch detection

Fixed status
mainline: [01b057b2f4cc2d905a0bd92195657dbd9a7005ab]
stable/5.10: [ae806c74c0634b0c23855066d8ba28d850fd1260]
stable/5.15: [13ea4b92e8759d2f6c330a73cde31ad9c313021b]
stable/6.1: [adbcec23c8423e3d5df1839c5ae91599dcf703cb]

CVE-2023-52576: x86/mm, kexec, ima: Use memblock_free_late() from
ima_free_kexec_buffer()

Announce: https://lore.kernel.org/linux-cve-announce/2024030257-CVE-2023-52576-7ee2@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit fee3ff9 ("powerpc: Move arch independent ima
kexec functions to drivers/of/kexec.c") in v5.13-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.6-rc3.

Fixed status
mainline: [34cf99c250d5cd2530b93a57b0de31d3aaf8685b]
stable/6.1: [eef16bfdb212da60f5144689f2967fb25b051a2b]

CVE-2023-52577: dccp: fix dccp_v4_err()/dccp_v6_err() again

Announce: https://lore.kernel.org/linux-cve-announce/2024030257-CVE-2023-52577-2638@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

This CVE announce does not contain fixed commit in the mainline.
The commit 6af2897 ("dccp: fix dccp_v4_err()/dccp_v6_err() again")
fixes mainline in 6.6-rc3.
Introduced by commit 977ad86 ("dccp: Fix out of bounds access in DCCP
error handler") in 6.6-rc1.

Fixed status
cip/4.4: [f775702709181d2ffc5047ec9b6bab3e8642f01c]
cip/4.4-rt: [f775702709181d2ffc5047ec9b6bab3e8642f01c]
cip/4.4-st: [f775702709181d2ffc5047ec9b6bab3e8642f01c]
mainline: [6af289746a636f71f4c0535a9801774118486c7a]
stable/4.19: [62c218124fe58372e0e1f60d5b634d21c264b337]
stable/5.10: [60d73c62e3e4464f375758b6f2459c13d46465b6]
stable/5.15: [26df9ab5de308caa1503d937533c56c35793018d]
stable/5.4: [a6f4d582e25d512c9b492670b6608436694357b3]
stable/6.1: [73be49248a04746096339a48a33fa2f03bd85969]

CVE-2023-52578: net: bridge: use DEV_STATS_INC()

Announce: https://lore.kernel.org/linux-cve-announce/2024030257-CVE-2023-52578-50cb@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1c29fc4 ("[BRIDGE]: keep track of received
multicast packets") in v2.6.20.16.
Fixed in v6.6-rc3.

Fixed status
mainline: [44bdb313da57322c9b3c108eb66981c6ec6509f4]
stable/4.19: [d2346e6beb699909ca455d9d20c4e577ce900839]
stable/5.10: [04cc361f029c14dd067ad180525c7392334c9bfd]
stable/5.15: [8bc97117b51d68d5cea8f5351cca2d8c4153f394]
stable/5.4: [ad8d39c7b437fcdab7208a6a56c093d222c008d5]
stable/6.1: [89f9f20b1cbd36d99d5a248a4bf8d11d4fd049a2]

CVE-2023-52579: ipv4: fix null-deref in ipv4_link_failure

Announce: https://lore.kernel.org/linux-cve-announce/2024030257-CVE-2023-52579-af56@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

This CVE is rejected.
Introduced by commit ed0de45 ("ipv4: recompile ip options in
ipv4_link_failure") in v5.1-rc6.
This commit is backported to older stable kernels.
Fixed in v6.6-rc3.

Fixed status
cip/4.4: [d4dccc15764f93278855862b35259fc62b50540e]
cip/4.4-rt: [d4dccc15764f93278855862b35259fc62b50540e]
cip/4.4-st: [d4dccc15764f93278855862b35259fc62b50540e]
mainline: [0113d9c9d1ccc07f5a3710dac4aa24b6d711278c]
stable/4.19: [a2cf7bd75b3992e8df68dd5fdc6499b67d45f6e0]
stable/5.10: [8689c9ace976d6c078e6dc844b09598796e84099]
stable/5.15: [8860d354f653628b6330e1c5b06b2828948135a4]
stable/5.4: [810fd23d9715474aa27997584e8fc9396ef3cb67]
stable/6.1: [2712545e535d7a2e4c53b9c9658a9c88c6055862]

CVE-2023-52580: net/core: Fix ETH_P_1588 flow dissector

Announce: https://lore.kernel.org/linux-cve-announce/2024030258-CVE-2023-52580-c37e@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4f1cc51 ("net: flow_dissector: Parse PTP L2
packet header") in v5.12-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.6-rc3.

Fixed status
mainline: [75ad80ed88a182ab2ad5513e448cf07b403af5c3]
stable/5.15: [f90a7b9586d72f907092078a9f394733ca502cc9]
stable/6.1: [488ea2a3e2666022f79abfdd7d12e8305fc27a40]

CVE-2023-52581: netfilter: nf_tables: fix memleak when more than 255
elements expired

Announce: https://lore.kernel.org/linux-cve-announce/2024030258-CVE-2023-52581-2165@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5f68718 ("netfilter: nf_tables: GC transaction
API to avoid race with control plane") in v6.5-rc6.
This commit is backported to 6.1 and 5.x kernels. Linux 4.x is not affected.
Fixed in v6.6-rc3.

Fixed status
mainline: [cf5000a7787cbc10341091d37245a42c119d26c5]
stable/5.10: [09c85f2d21ab6b5acba31a037985b13e8e6565b8]
stable/5.15: [ef99506eaf1dc31feff1adfcfd68bc5535a22171]
stable/5.4: [a995a68e8a3b48533e47c856865d109a1f1a9d01]
stable/6.1: [7e5d732e6902eb6a37b35480796838a145ae5f07]

CVE-2023-52582: netfs: Only call folio_start_fscache() one time for each folio

Announce: https://lore.kernel.org/linux-cve-announce/2024030258-CVE-2023-52582-07c8@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3d3c950 ("netfs: Provide readahead and readpage
netfs helpers") in v5.13-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.6-rc3.

Fixed status
mainline: [df1c357f25d808e30b216188330e708e09e1a412]
stable/6.1: [df9950d37df113db59495fa09d060754366a2b7c]

CVE-2024-26621: mm: huge_memory: don't force huge page alignment on 32 bit

Announce: https://lore.kernel.org/linux-cve-announce/2024030255-CVE-2024-26621-9300@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit efa7df3 ("mm: align larger anonymous mappings on
THP boundaries") in v6.7.
This commit is not backported to older stable kernels
Fixed in v6.8-rc3.

Fixed status
mainline: [4ef9ad19e17676b9ef071309bc62020e2373705d]
stable/6.1: [87632bc9ecff5ded93433bc0fca428019bdd1cfe]
stable/6.7: [7432376c913381c5f24d373a87ff629bbde94b47]

CVE-2024-26622: tomoyo: fix UAF write bug in tomoyo_write_control()

Announce: https://lore.kernel.org/linux-cve-announce/2024030409-CVE-2024-26622-9e01@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit bd03a3e ("TOMOYO: Add policy namespace support.")
in v3.1-rc1.
Fixed in v6.8-rc7.

Fixed status
mainline: [2f03fc340cac9ea1dc63cbf8c93dd2eb0f227815]
stable/5.10: [a23ac1788e2c828c097119e9a3178f0b7e503fee]
stable/5.15: [7d930a4da17958f869ef679ee0e4a8729337affc]
stable/6.1: [3bfe04c1273d30b866f4c7c238331ed3b08e5824]
stable/6.6: [2caa605079488da9601099fbda460cfc1702839f]
stable/6.7: [6edefe1b6c29a9932f558a898968a9fcbeec5711]

CVE-2021-47082: tun: avoid double free in tun_free_netdev

Announce: https://lore.kernel.org/linux-cve-announce/2024030451-CVE-2021-47082-b12c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.16-rc7.
It seems as if Linux 4.4 may be affected.

Fixed status
mainline: [158b515f703e75e7d68289bf4d98c664e1d632df]
stable/4.19: [8eb43d635950e27c29f1e9e49a23b31637f37757]
stable/5.10: [a01a4e9f5dc93335c716fa4023b1901956e8c904]
stable/5.15: [3cb5ae77799e8ed6ec3fec0b6b4cd07f01650cc5]
stable/5.4: [0c0e566f0387490d16f166808c72e9c772027681]

CVE-2021-47083: pinctrl: mediatek: fix global-out-of-bounds issue

Announce: https://lore.kernel.org/linux-cve-announce/2024030454-CVE-2021-47083-eab5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.16-rc7.
It seems as if commit fb5fa8dc1 ("pinctrl: mediatek: extend struct
mtk_pin_desc to pinctrl-mtk-common-v2.c") in 4.20-rc1 introduced this
bug.
The commit fb5fa8dc1 is not backported to older stable kernels.

Fixed status
mainline: [2d5446da5acecf9c67db1c9d55ae2c3e5de01f8d]
stable/5.10: [441d3873664d170982922c5d2fc01fa89d9439ed]
stable/5.15: [fb563baa3eb8e7a15f2cff3c2695e2cca0493e69]
stable/5.4: [f373298e1bf0c6ea097c0bcc558dc43ad53e421f]

CVE-2021-47084: hamradio: defer ax25 kfree after unregister_netdev

Announce: https://lore.kernel.org/linux-cve-announce/2024030455-CVE-2021-47084-4984@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.16-rc1.
All stable kernels have been fixed.

Fixed status
cip/4.4: [b5b193d0c67180fefdc664650138e3b7959df615]
cip/4.4-rt: [b5b193d0c67180fefdc664650138e3b7959df615]
cip/4.4-st: [b5b193d0c67180fefdc664650138e3b7959df615]
mainline: [3e0588c291d6ce225f2b891753ca41d45ba42469]
stable/4.19: [896193a02a2981e60c40d4614fd095ce92135ccd]
stable/4.4: [b5b193d0c67180fefdc664650138e3b7959df615]
stable/5.10: [450121075a6a6f1d50f97225d3396315309d61a1]
stable/5.15: [cb6c99aedd2c843056a598a8907a6128cb07603b]
stable/5.4: [ef5f7bfa19e3fc366f4c6d1a841ceaddf7a9f5d4]

CVE-2021-47085: hamradio: improve the incomplete fix to avoid NPD

Announce: https://lore.kernel.org/linux-cve-announce/2024030455-CVE-2021-47085-3c44@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.16-rc7.
All stable kernels have been fixed.

Fixed status
cip/4.4: [371a874ea06f147d6ca30be43dad33683965eba6]
cip/4.4-rt: [371a874ea06f147d6ca30be43dad33683965eba6]
cip/4.4-st: [371a874ea06f147d6ca30be43dad33683965eba6]
mainline: [b2f37aead1b82a770c48b5d583f35ec22aabb61e]
stable/4.19: [b68f41c6320b2b7fbb54a95f07a69f3dc7e56c59]
stable/4.4: [371a874ea06f147d6ca30be43dad33683965eba6]
stable/5.10: [7dd52af1eb5798f590d9d9e1c56ed8f5744ee0ca]
stable/5.15: [03d00f7f1815ec00dab5035851b3de83afd054a8]
stable/5.4: [a5c6a13e9056d87805ba3042c208fbd4164ad22b]

CVE-2021-47086: phonet/pep: refuse to enable an unbound pipe

Announce: https://lore.kernel.org/linux-cve-announce/2024030455-CVE-2021-47086-cdaa@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.16-rc7.
All stable kernels have been fixed.

Fixed status
cip/4.4: [0bbdd62ce9d44f3a22059b3d20a0df977d9f6d59]
cip/4.4-rt: [0bbdd62ce9d44f3a22059b3d20a0df977d9f6d59]
cip/4.4-st: [0bbdd62ce9d44f3a22059b3d20a0df977d9f6d59]
mainline: [75a2f31520095600f650597c0ac41f48b5ba0068]
stable/4.19: [982b6ba1ce626ef87e5c29f26f2401897554f235]
stable/4.4: [0bbdd62ce9d44f3a22059b3d20a0df977d9f6d59]
stable/5.10: [52ad5da8e316fa11e3a50b3f089aa63e4089bf52]
stable/5.15: [53ccdc73eedaf0e922c45b569b797d2796fbaafa]
stable/5.4: [48c76fc53582e7f13c1e0b11c916e503256c4d0b]

CVE-2021-47087: tee: optee: Fix incorrect page free bug

Announce: https://lore.kernel.org/linux-cve-announce/2024030413-CVE-2021-47087-4132@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ec185dd ("optee: Fix memory leak when failing to
register shm pages") in v5.14-rc5.
This commit is not backported to 4.x kernels.
Fixed in v5.16-rc7.

Fixed status
mainline: [18549bf4b21c739a9def39f27dcac53e27286ab5]
stable/5.10: [ad338d825e3f7b96ee542bf313728af2d19fe9ad]
stable/5.15: [91e94e42f6fc49635f1a16d8ae3f79552bcfda29]
stable/5.4: [806142c805cacd098e61bdc0f72c778a2389fe4a]

CVE-2021-47088: mm/damon/dbgfs: protect targets destructions with kdamond_lock

Announce: https://lore.kernel.org/linux-cve-announce/2024030413-CVE-2021-47088-269c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4bc0595 ("mm/damon: implement a debugfs-based
user space interface") in v5.15-rc1.
This commit is not backported to older stable kernel.
Fixed in v5.16-rc7.

Fixed status
mainline: [34796417964b8d0aef45a99cf6c2d20cebe33733]
stable/5.15: [330c6117a82c16a9a365a51cec5c9ab30b13245c]

CVE-2021-47089: kfence: fix memory leak when cat kfence objects

Announce: https://lore.kernel.org/linux-cve-announce/2024030413-CVE-2021-47089-bc5a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0ce20dd ("mm: add Kernel Electric-Fence
infrastructure") in v5.12-rc1.
This commit is not backported to older stable kernel.
Fixed in v5.16-rc7.

Fixed status
mainline: [0129ab1f268b6cf88825eae819b9b84aa0a85634]
stable/5.15: [2f06c8293d27f6337f907042c602c9c953988c48]

CVE-2021-47090: mm/hwpoison: clear MF_COUNT_INCREASED before retrying
get_any_page()

Announce: https://lore.kernel.org/linux-cve-announce/2024030413-CVE-2021-47090-a429@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b94e028 ("mm,hwpoison: try to narrow window race
for free pages") in v5.10-rc1.
This commit is not backported to older stable kernel.
Fixed in v5.16-rc7.

Fixed status
mainline: [2a57d83c78f889bf3f54eede908d0643c40d5418]
stable/5.10: [1f207076740101fed87074a6bc924dbe806f08a5]
stable/5.15: [c691e7575eff76e563b0199c23ec46bd454f43e3]

CVE-2021-47091: mac80211: fix locking in ieee80211_start_ap error path

Announce: https://lore.kernel.org/linux-cve-announce/2024030414-CVE-2021-47091-edad@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 295b02c ("mac80211: Add FILS discovery support")
in v5.10-rc1.
This commit is not backported to older stable kernel.
Fixed in v5.16-rc7.

Fixed status
mainline: [87a270625a89fc841f1a7e21aae6176543d8385c]
stable/5.10: [ac61b9c6c0549aaeb98194cf429d93c41bfe5f79]
stable/5.15: [c1d1ec4db5f7264cfc21993e59e8f2dcecf4b44f]

CVE-2021-47092: KVM: VMX: Always clear vmx->fail on emulation_required

Announce: https://lore.kernel.org/linux-cve-announce/2024030414-CVE-2021-47092-36e2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c8607e4 ("KVM: x86: nVMX: don't fail nested VM
entry on invalid guest state if !from_vmentry") in v5.15-rc4.
This commit is not backported to older stable kernel.
Fixed in v5.16-rc7.

Fixed status
mainline: [a80dfc025924024d2c61a4c1b8ef62b2fce76a04]
stable/5.15: [e4e4e7cb229821cd215031abc47efdab5486a67c]

CVE-2021-47093: platform/x86: intel_pmc_core: fix memleak on
registration failure

Announce: https://lore.kernel.org/linux-cve-announce/2024030414-CVE-2021-47093-ccd0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 938835a ("platform/x86: intel_pmc_core: do not
create a static struct device") in v5.9.
This commit is not backported to older stable kernel.
Fixed in v5.16-rc7.

Fixed status
mainline: [26a8b09437804fabfb1db080d676b96c0de68e7c]
stable/5.10: [7a37f2e370699e2feca3dca6c8178c71ceee7e8a]
stable/5.15: [9ca1324755f1f8629a370af5cc315b175331f5d1]

CVE-2021-47094: KVM: x86/mmu: Don't advance iterator after restart due
to yielding

Announce: https://lore.kernel.org/linux-cve-announce/2024030414-CVE-2021-47094-8cc7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit faaf05b ("kvm: x86/mmu: Support zapping SPTEs in
the TDP MMU") in v5.10-rc1.
Introduced by commit 1af4a96 ("KVM: x86/mmu: Yield in TDU MMU iter
even if no SPTES changed") in v5.12-rc1.
These commits are not backported to older stable kernel.
Fixed in v5.16-rc7.

Fixed status
mainline: [3a0f64de479cae75effb630a2e0a237ca0d0623c]
stable/5.15: [d884eefd75cc54887bc2e9e724207443525dfb2c]

CVE-2021-47095: ipmi: ssif: initialize ssif_info->client early

Announce: https://lore.kernel.org/linux-cve-announce/2024030414-CVE-2021-47095-39dd@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c4436c9 ("ipmi_ssif: avoid registering duplicate
ssif interface") in v5.4-rc1.
This commit is not backported to older stable kernel.
Fixed in v5.16-rc7.

Fixed status
mainline: [34f35f8f14bc406efc06ee4ff73202c6fd245d15]
stable/5.10: [1f6ab847461ce7dd89ae9db2dd4658c993355d7c]
stable/5.15: [77a7311ca167aa5b7055c549a940a56e73ee5f29]
stable/5.4: [8efd6a3391f7b0b19fb0c38e50add06ca30c94af]

CVE-2021-47096: ALSA: rawmidi - fix the uninitalized user_pversion

Announce: https://lore.kernel.org/linux-cve-announce/2024030415-CVE-2021-47096-40c7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 09d2317 ("ALSA: rawmidi: introduce
SNDRV_RAWMIDI_IOCTL_USER_PVERSION") in v5.15-rc4.
This commit is not backported to older stable kernel.
Fixed in v5.16-rc7.

Fixed status
mainline: [39a8fc4971a00d22536aeb7d446ee4a97810611b]
stable/5.15: [b398fcbe4de1e1100867fdb6f447c6fbc8fe7085]

CVE-2021-47097: Input: elantech - fix stack out of bound access in
elantech_change_report_id()

Announce: https://lore.kernel.org/linux-cve-announce/2024030415-CVE-2021-47097-e7f4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e4c9062 ("Input: elantech - fix protocol errors
for some trackpoints in SMBus mode") in v5.11-rc1.
This commit is backported to 5.10 and 5.4. Linux 4.x is not affected.
Fixed in v5.16-rc7.

Fixed status
mainline: [1d72d9f960ccf1052a0630a68c3d358791dbdaaa]
stable/5.10: [676c572439e58b7ee6b7ca3f1e5595382921045c]
stable/5.15: [dfd5b60b5342b6b505a104e48f08ad9b9bdbbd7b]
stable/5.4: [a7f95328c6f0afffdc4555f16e3bbab8bbf0d9be]

CVE-2021-47098: hwmon: (lm90) Prevent integer overflow/underflow in
hysteresis calculations

Announce: https://lore.kernel.org/linux-cve-announce/2024030415-CVE-2021-47098-e11f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b50aa49 ("hwmon: (lm90) Prevent integer
underflows of temperature calculations") in v5.14-rc1.
This commit is not backported to older stable kernel.
Fixed in v5.16-rc7.

Fixed status
mainline: [55840b9eae5367b5d5b29619dc2fb7e4596dba46]
stable/5.15: [d105f30bea9104c590a9e5b495cb8a49bdfe405f]

CVE-2021-47099: veth: ensure skb entering GRO are not cloned.

Announce: https://lore.kernel.org/linux-cve-announce/2024030415-CVE-2021-47099-3127@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d3256ef ("veth: allow enabling NAPI even without
XDP") in v5.13-rc1.
This commit is not backported to older stable kernel.
Fixed in v5.16-rc7.

Fixed status
mainline: [9695b7de5b4760ed22132aca919570c0190cb0ce]
stable/5.15: [d2269ae48598e05b59ec9ea9e6e44fd33941130d]

CVE-2021-47100: ipmi: Fix UAF when uninstall ipmi_si and ipmi_msghandler module

Announce: https://lore.kernel.org/linux-cve-announce/2024030415-CVE-2021-47100-043d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b2cfd8a ("ipmi: Rework device id and guid
handling to catch changing BMCs") in v4.15-rc1.
Linux 4.4 is not affected.
Fixed in v5.16-rc7.

Fixed status
mainline: [ffb76a86f8096a8206be03b14adda6092e18e275]
stable/4.19: [925229d552724e1bba1abf01d3a0b1318539b012]
stable/5.10: [6809da5185141e61401da5b01896b79a4deed1ad]
stable/5.15: [6b3f7e4b10f343f05b5fb513b07a9168fbf1172e]
stable/5.4: [992649b8b16843d27eb39ceea5f9cf85ffb50a18]

CVE-2021-47101: asix: fix uninit-value in asix_mdio_read()

Announce: https://lore.kernel.org/linux-cve-announce/2024030415-CVE-2021-47101-f3fa@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d9fe64e ("net: asix: Add in_pm parameter") in v4.9-rc1.
Linux 4.4 is not affected.
Fixed in v5.16-rc7.

Fixed status
mainline: [8035b1a2a37a29d8c717ef84fca8fe7278bc9f03]
stable/5.15: [d259f621c85949f30cc578cac813b82bb5169f56]

CVE-2021-47102: net: marvell: prestera: fix incorrect structure access

Announce: https://lore.kernel.org/linux-cve-announce/2024030416-CVE-2021-47102-1335@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3d5048c ("net: marvell: prestera: move netdev
topology validation to prestera_main") in v5.14-rc1.
This commit is not backported to older stable kernels.
Fixed in v5.16-rc7.

Fixed status
mainline: [2efc2256febf214e7b2bdaa21fe6c3c3146acdcb]
stable/5.15: [5c553a0cd1263e4da5f220d80fa713fc3959c1d0]

CVE-2021-47103: inet: fully convert sk->sk_rx_dst to RCU rules

Announce: https://lore.kernel.org/linux-cve-announce/2024030416-CVE-2021-47103-4314@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 41063e9 ("ipv4: Early TCP socket demux.") in v3.6-rc1.
Fixed in v5.16-rc7. All stable kernels have been fixed.

Fixed status
cip/4.4: [f3d7398a12be2ec4ed01351025933af051d2cd6d]
cip/4.4-rt: [f3d7398a12be2ec4ed01351025933af051d2cd6d]
cip/4.4-st: [f3d7398a12be2ec4ed01351025933af051d2cd6d]
mainline: [8f905c0e7354ef261360fb7535ea079b1082c105]
stable/4.19: [75a578000ae5e511e5d0e8433c94a14d9c99c412]
stable/5.10: [f039b43cbaea5e0700980c2f0052da05a70782e0]
stable/5.15: [0249a4b8a554f2eb6a27b62516fa50168584faa4]
stable/5.4: [c3bb4a7e8cbc984e1cdac0fe6af60e880214ed6e]

CVE-2021-47104: IB/qib: Fix memory leak in qib_user_sdma_queue_pkts()

Announce: https://lore.kernel.org/linux-cve-announce/2024030444-CVE-2021-47104-bedc@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d39bf40 ("IB/qib: Protect from buffer overflow in
struct qib_user_sdma_pkt fields") in v5.15.
Fixed in v5.16-rc7. All stable kernels have been fixed.

Fixed status
cip/4.4: [1ced0a3015a95c6a6db45e37250912c4c86697ab]
cip/4.4-rt: [1ced0a3015a95c6a6db45e37250912c4c86697ab]
cip/4.4-st: [1ced0a3015a95c6a6db45e37250912c4c86697ab]
mainline: [bee90911e0138c76ee67458ac0d58b38a3190f65]
stable/4.19: [0aaec9c5f60754b56f84460ea439b8c5e91f4caa]
stable/4.4: [1ced0a3015a95c6a6db45e37250912c4c86697ab]
stable/5.10: [7cf6466e00a77b0a914b7b2c28a1fc7947d55e59]
stable/5.15: [aefcc25f3a0cd28a87d11d41d30419a12cd26a34]
stable/5.4: [79dcbd8176152b860028b62f81a635d987365752]

CVE-2021-47105: ice: xsk: return xsk buffers back to pool when cleaning the ring

Announce: https://lore.kernel.org/linux-cve-announce/2024030444-CVE-2021-47105-fa23@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2d4238f ("ice: Add support for AF_XDP") in v5.5-rc1.
Tnis commit is not backported to older stable kernels.
Fixed in v5.16-rc7.

Fixed status
mainline: [afe8a3ba85ec2a6b6849367e25c06a2f8e0ddd05]
stable/5.15: [ad6d20da2cfbe14b7b1200d15f39e65988b0b9e8]

CVE-2021-47106: netfilter: nf_tables: fix use-after-free in
nft_set_catchall_destroy()

Announce: https://lore.kernel.org/linux-cve-announce/2024030445-CVE-2021-47106-fdff@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit aaa3104 ("netfilter: nftables: add catch-all set
element support") in v5.13-rc1.
Tnis commit is not backported to older stable kernels.
Fixed in v5.16-rc7.

Fixed status
mainline: [0f7d9b31ce7abdbb29bf018131ac920c9f698518]
stable/5.15: [9d558e5f0d6fdd0a568f73dceb0b40c4f5012e5a]

CVE-2021-47107: NFSD: Fix READDIR buffer overflow

Announce: https://lore.kernel.org/linux-cve-announce/2024030445-CVE-2021-47107-7dda@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f5dcccd ("NFSD: Update the NFSv2 READDIR entry
encoder to use struct xdr_stream") in v5.13-rc1.
Introduced by commit 7f87fc2 ("NFSD: Update NFSv3 READDIR entry
encoders to use struct xdr_stream") in v5.13-rc1.
These commits are not backported to older stable kernels.
Fixed in v5.16-rc7.

Fixed status
mainline: [53b1119a6e5028b125f431a0116ba73510d82a72]
stable/5.15: [eabc0aab98e5218ceecd82069b0d6fdfff5ee885]

CVE-2021-47108: drm/mediatek: hdmi: Perform NULL pointer check for mtk_hdmi_conf

Announce: https://lore.kernel.org/linux-cve-announce/2024030445-CVE-2021-47108-252a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 41ca9ca ("drm/mediatek: hdmi: Add check for CEA
modes only") in v5.14-rc1.
Introduced by commit c91026a ("drm/mediatek: hdmi: Add optional limit
on maximal HDMI mode clock") in v5.14-rc1.
These commits are not backported to older stable kernels.
Fixed in v5.16-rc7.

Fixed status
mainline: [3b8e19a0aa3933a785be9f1541afd8d398c4ec69]
stable/5.15: [71d07ebc5000b9c1d140e99e7493b0bafa954776]

CVE-2022-48629: crypto: qcom-rng - ensure buffer for generate is
completely filled

Announce: https://lore.kernel.org/linux-cve-announce/2024030513-CVE-2022-48629-8ee0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ceec5f5 ("crypto: qcom-rng - Add Qcom prng
driver") in v4.19-rc1.
Linux 4.4 is not affected.
Fixed in v5.17.

Fixed status
mainline: [a680b1832ced3b5fa7c93484248fd221ea0d614b]
stable/4.19: [a8e32bbb96c25b7ab29b1894dcd45e0b3b08fd9d]
stable/5.10: [0f9b7b8df17525e464294c916acc8194ce38446b]
stable/5.15: [ab9337c7cb6f875b6286440b1adfbeeef2b2b2bd]
stable/5.4: [184f7bd08ce56f003530fc19f160d54e75bf5c9d]

CVE-2022-48630: crypto: qcom-rng - fix infinite loop on requests not
multiple of WORD_SZ

Announce: https://lore.kernel.org/linux-cve-announce/2024030516-CVE-2022-48630-ae00@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a680b18 ("crypto: qcom-rng - ensure buffer for
generate is completely filled") in v5.17.
This commit is backported to 4.19, 5.4, 5.10, and 5.15. Linux 4.4 is
not affected.
Fixed in v5.18.

Fixed status
mainline: [16287397ec5c08aa58db6acf7dbc55470d78087d]
stable/4.19: [71a89789552b7faf3ef27969b9bc783fa0df3550]
stable/5.10: [233a3cc60e7a8fe0be8cf9934ae7b67ba25a866c]
stable/5.15: [8a06f25f5941c145773204f2f7abef95b4ffb8ce]
stable/5.4: [8be06f62b426801dba43ddf8893952a0e62ab6ae]

CVE-2023-52583: ceph: fix deadlock or deadcode of misusing dget()

Announce: https://lore.kernel.org/linux-cve-announce/2024030641-CVE-2023-52583-fd38@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
This commit seems fix commit ca6c8ae0 ("ceph: pass parent inode info
to ceph_encode_dentry_release if we have it") in 4.11-rc1.
Linux 4.4 alyages get parent inode from dentry->d_parent so Linux 4.4
may not be affected.

Fixed status
mainline: [b493ad718b1f0357394d2cdecbf00a44a36fa085]
stable/4.19: [eb55ba8aa7fb7aad54f40fbf4d8dcdfdba0bebf6]
stable/5.10: [e016e358461b89b231626fcf78c5c38e35c44fd3]
stable/5.15: [a9c15d6e8aee074fae66c04d114f20b84274fcca]
stable/5.4: [6ab4fd508fad942f1f1ba940492f2735e078e980]
stable/6.1: [7f2649c94264d00df6b6ac27161e9f4372a3450e]
stable/6.6: [196b87e5c00ce021e164a5de0f0d04f4116a9160]
stable/6.7: [76cb2aa3421fee4fde706dec41b1344bc0a9ad67]

CVE-2023-52584: spmi: mediatek: Fix UAF on device remove

Announce: https://lore.kernel.org/linux-cve-announce/2024030643-CVE-2023-52584-fb9a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
The mtk_spmi_probe() is introduced by commit b45b3cce ("spmi:
mediatek: Add support for MT6873/8192") in 5.17-rc1.
This commit is not backported to older stable kernels.

Fixed status
mainline: [e821d50ab5b956ed0effa49faaf29912fd4106d9]
stable/6.1: [521f28eedd6b14228c46e3b81e3bf9b90c2818d8]
stable/6.6: [f8dcafcb54632536684336161da8bdd52120f95e]
stable/6.7: [9a3881b1f07db1bb55cb0108e6f05cfd027eaf2e]

CVE-2023-52585: drm/amdgpu: Fix possible NULL dereference in
amdgpu_ras_query_error_status_helper()

Announce: https://lore.kernel.org/linux-cve-announce/2024030643-CVE-2023-52585-7dbc@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
The affected file drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c is
introduced by commit c030f2e4 ("drm/amdgpu: add amdgpu_ras.c to
support ras (v2)") in 5.2-rc1.
The error query mode handling support is introduced by commit 8cc0f566
("drm/amdgpu: Support multiple error query modes") in 6.7-rc1.
So, prior to Linux 6.7 kernels may not be affected.


Fixed status
mainline: [b8d55a90fd55b767c25687747e2b24abd1ef8680]
stable/6.7: [195a6289282e039024ad30ba66e6f94a4d0fbe49]

CVE-2023-52586: drm/msm/dpu: Add mutex lock in control vblank irq

Announce: https://lore.kernel.org/linux-cve-announce/2024030644-CVE-2023-52586-3ecb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
The /drivers/gpu/drm/msm/disp directory is not found in Linux 4.4.
Other stable kernels may be affected.

Fixed status
mainline: [45284ff733e4caf6c118aae5131eb7e7cf3eea5a]
stable/6.7: [14f109bf74dd67e1d0469fed859c8e506b0df53f]

CVE-2023-52587: IB/ipoib: Fix mcast list locking

Announce: https://lore.kernel.org/linux-cve-announce/2024030644-CVE-2023-52587-5479@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
Linux 4.4 is affected.

Fixed status
mainline: [4f973e211b3b1c6d36f7c6a19239d258856749f9]
stable/4.19: [4c8922ae8eb8dcc1e4b7d1059d97a8334288d825]
stable/5.10: [ac2630fd3c90ffec34a0bfc4d413668538b0e8f2]
stable/5.15: [ed790bd0903ed3352ebf7f650d910f49b7319b34]
stable/5.4: [615e3adc2042b7be4ad122a043fc9135e6342c90]
stable/6.1: [5108a2dc2db5630fb6cd58b8be80a0c134bc310a]
stable/6.6: [342258fb46d66c1b4c7e2c3717ac01e10c03cf18]
stable/6.7: [7c7bd4d561e9dc6f5b7df9e184974915f6701a89]

CVE-2023-52588: f2fs: fix to tag gcing flag on page during block migration

Announce: https://lore.kernel.org/linux-cve-announce/2024030644-CVE-2023-52588-619a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
The affected file /fs/f2fs/compress.c doesn't exist in Linux 4.4, 4.19, and 5.4.
The /fs/f2fs/file.c is found in all stable kernels. Linux 4.4 doesn't
have __clone_blkaddrs() and redirty_blocks().
Linux 4.19, 5.4, and 5.10 doesn't have redirty_blocks().

Fixed status
mainline: [4961acdd65c956e97c1a000c82d91a8c1cdbe44b]
stable/5.15: [7ea0f29d9fd84905051be020c0df7d557e286136]
stable/6.1: [7c972c89457511007dfc933814c06786905e515c]
stable/6.6: [417b8a91f4e8831cadaf85c3f15c6991c1f54dde]
stable/6.7: [b8094c0f1aae329b1c60a275a780d6c2c9ff7aa3]

CVE-2023-52589: media: rkisp1: Fix IRQ disable race issue

Announce: https://lore.kernel.org/linux-cve-announce/2024030644-CVE-2023-52589-8f84@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
The /drivers/media/platform/rockchip/rkisp1 directory is not found in
4.4, 4.19, 5.4, and 5.10.

Fixed status
mainline: [870565f063a58576e8a4529f122cac4325c6b395]
stable/6.1: [bf808f58681cab64c81cd814551814fd34e540fe]
stable/6.6: [fab483438342984f2a315fe13c882a80f0f7e545]
stable/6.7: [7bb1a2822aa2c2de4e09bf7c56dd93bd532f1fa7]

CVE-2023-52590: ocfs2: Avoid touching renamed directory if parent does
not change

Announce: https://lore.kernel.org/linux-cve-announce/2024030644-CVE-2023-52590-fca9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
All stable kernels may be affected.

Fixed status
mainline: [9d618d19b29c2943527e3a43da0a35aea91062fc]
stable/6.7: [de940cede3c41624e2de27f805b490999f419df9]

CVE-2023-52591: reiserfs: Avoid touching renamed directory if parent
does not change

Announce: https://lore.kernel.org/linux-cve-announce/2024030644-CVE-2023-52591-46a0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
All stable kernels may be affected.

Fixed status
mainline: [49db9b1b86a82448dfaf3fcfefcf678dee56c8ed]
stable/6.6: [17e1361cb91dc1325834da95d2ab532959d2debc]
stable/6.7: [c04c162f82ac403917780eb6d1654694455d4e7c]

CVE-2023-52592: libbpf: Fix NULL pointer dereference in
bpf_object__collect_prog_relos

Announce: https://lore.kernel.org/linux-cve-announce/2024030645-CVE-2023-52592-4693@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
It seems as if this bug is introduced by commit 6245947c1 ("Allow gaps
in BPF program sections to support  overriden weak functions") in
5.13-rc1.

Fixed status
mainline: [fc3a5534e2a8855427403113cbeb54af5837bbe0]
stable/5.15: [90dbf4535668042fac0d7201ce9e2c8c770c578a]
stable/6.1: [12473265f50c1e27b0dfd9735738ac418c4bfcce]
stable/6.6: [5f3e436832e86b826a6450eb8d1aaa51205a758e]
stable/6.7: [ab26541270c722eedf8eefd62797c3ce3d18a91b]

CVE-2023-52593: wifi: wfx: fix possible NULL pointer dereference in
wfx_set_mfp_ap()

Announce: https://lore.kernel.org/linux-cve-announce/2024030645-CVE-2023-52593-14ef@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
The wfx was first introduced by commit a7a91ca5 ("staging: wfx: add
infrastructure for new driver") in 5.5-rc1 to staging directory.
It looks commit 268bcee ("staging: wfx: fix BA when device is AP and
MFP is enabled") in 5.10-rc1. introduced by this bug.

Fixed status
mainline: [fe0a7776d4d19e613bb8dd80fe2d78ae49e8b49d]
stable/6.1: [574dcd3126aa2eed75437137843f254b1190dd03]
stable/6.6: [9ab224744a47363f74ea29c6894c405e3bcf5132]
stable/6.7: [3739121443f5114c6bcf6d841a5124deb006b878]

CVE-2023-52594: wifi: ath9k: Fix potential array-index-out-of-bounds
read in ath9k_htc_txstatus()

Announce: https://lore.kernel.org/linux-cve-announce/2024030645-CVE-2023-52594-9b84@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
Linux 4.4 Linux 4.4 looks to be affected.

Fixed status
mainline: [2adc886244dff60f948497b59affb6c6ebb3c348]
stable/4.19: [f44f073c78112ff921a220d01b86d09f2ace59bc]
stable/5.10: [84770a996ad8d7f121ff2fb5a8d149aad52d64c1]
stable/5.15: [9003fa9a0198ce004b30738766c67eb7373479c9]
stable/5.4: [f11f0fd1ad6c11ae7856d4325fe9d05059767225]
stable/6.1: [25c6f49ef59b7a9b80a3f7ab9e95268a1b01a234]
stable/6.6: [e4f4bac7d3b64eb75f70cd3345712de6f68a215d]
stable/6.7: [be609c7002dd4504b15b069cb7582f4c778548d1]

CVE-2023-52595: wifi: rt2x00: restart beacon queue when hardware reset

Announce: https://lore.kernel.org/linux-cve-announce/2024030645-CVE-2023-52595-d018@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
It looks all stable kernels are affected.

Fixed status
mainline: [a11d965a218f0cd95b13fe44d0bcd8a20ce134a8]
stable/5.10: [69e905beca193125820c201ab3db4fb0e245124e]
stable/5.15: [4cc198580a7b93a36f5beb923f40f7ae27a3716c]
stable/5.4: [e1f113b57ddd18274d7c83618deca25cc880bc48]
stable/6.1: [739b3ccd9486dff04af95f9a890846d088a84957]
stable/6.6: [04cfe4a5da57ab9358cdfadea22bcb37324aaf83]
stable/6.7: [fdb580ed05df8973aa5149cafa598c64bebcd0cb]

CVE-2023-52596: sysctl: Fix out of bounds access for empty sysctl registers

Announce: https://lore.kernel.org/linux-cve-announce/2024030645-CVE-2023-52596-b98e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
Old stable kernels don't use header for loop iteration.
The ctl_table_size variable was introduced by commit 1e88772 ("sysctl:
Add ctl_table_size to ctl_table_header") in 6.6-rc1.

Fixed status
mainline: [315552310c7de92baea4e570967066569937a843]
stable/6.6: [15893975e9e382f8294ea8d926f08dc2d8d39ede]
stable/6.7: [2ae7081bc10123b187e36a4f3a8e53768de31489]

CVE-2023-52597: KVM: s390: fix setting of fpc register

Announce: https://lore.kernel.org/linux-cve-announce/2024030646-CVE-2023-52597-2ed6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
s390 is not supported by the CIP.

Fixed status
mainline: [b988b1bb0053c0dcd26187d29ef07566a565cf55]
stable/4.19: [3a04410b0bc7e056e0843ac598825dd359246d18]
stable/5.10: [150a3a3871490e8c454ffbac2e60abeafcecff99]
stable/5.15: [732a3bea7aba5b15026ea42d14953c3425cc7dc2]
stable/5.4: [5e63c9ae8055109d805aacdaf2a4fe2c3b371ba1]
stable/6.1: [0671f42a9c1084db10d68ac347d08dbf6689ecb3]
stable/6.6: [c87d7d910775a025e230fd6359b60627e392460f]
stable/6.7: [2823db0010c400e4b2b12d02aa5d0d3ecb15d7c7]

CVE-2023-52598: s390/ptrace: handle setting of fpc register correctly

Announce: https://lore.kernel.org/linux-cve-announce/2024030646-CVE-2023-52598-d0a2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
s390 is not supported by the CIP.

Fixed status
mainline: [8b13601d19c541158a6e18b278c00ba69ae37829]
stable/4.19: [6ccf904aac0292e1f6b1a1be6c407c414f7cf713]
stable/5.10: [856caf2730ea18cb39e95833719c02a02447dc0a]
stable/5.15: [28a1f492cb527f64593457a0a0f0d809b3f36c25]
stable/5.4: [6d0822f2cc9b153bf2df49a84599195a2e0d21a8]
stable/6.1: [7a4d6481fbdd661f9e40e95febb95e3dee82bad3]
stable/6.6: [02c6bbfb08bad78dd014e24c7b893723c15ec7a1]
stable/6.7: [bdce67df7f12fb0409fbc604ce7c4254703f56d4]

CVE-2023-52599: jfs: fix array-index-out-of-bounds in diNewExt

Announce: https://lore.kernel.org/linux-cve-announce/2024030646-CVE-2023-52599-b318@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
Linux 4.4 looks to beaffected.

Fixed status
mainline: [49f9637aafa6e63ba686c13cb8549bf5e6920402]
stable/4.19: [f423528488e4f9606cef858eceea210bf1163f41]
stable/5.10: [e2b77d107b33bb31c8b1f5c4cb8f277b23728f1e]
stable/5.15: [6aa30020879042d46df9f747e4f0a486eea6fe98]
stable/5.4: [de6a91aed1e0b1a23e9c11e7d7557f088eeeb017]
stable/6.1: [3537f92cd22c672db97fae6997481e678ad14641]
stable/6.6: [6996d43b14486f4a6655b10edc541ada1b580b4b]
stable/6.7: [5a6660139195f5e2fbbda459eeecb8788f3885fe]

CVE-2023-52600: jfs: fix uaf in jfs_evict_inode

Announce: https://lore.kernel.org/linux-cve-announce/2024030646-CVE-2023-52600-6ffe@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
Linux 4.4 looks to be affected.

Fixed status
mainline: [e0e1958f4c365e380b17ccb35617345b31ef7bf3]
stable/4.19: [81b4249ef37297fb17ba102a524039a05c6c5d35]
stable/5.10: [bc6ef64dbe71136f327d63b2b9071b828af2c2a8]
stable/5.15: [8e44dc3f96e903815dab1d74fff8faafdc6feb61]
stable/5.4: [93df0a2a0b3cde2d7ab3a52ed46ea1d6d4aaba5f]
stable/6.1: [32e8f2d95528d45828c613417cb2827d866cbdce]
stable/6.6: [1696d6d7d4a1b373e96428d0fe1166bd7c3c795e]
stable/6.7: [bacdaa04251382d7efd4f09f9a0686bfcc297e2e]

CVE-2023-52601: jfs: fix array-index-out-of-bounds in dbAdjTree

Announce: https://lore.kernel.org/linux-cve-announce/2024030646-CVE-2023-52601-6c3d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
Linux 4.4 looks to be affected.

Fixed status
mainline: [74ecdda68242b174920fe7c6133a856fb7d8559b]
stable/4.19: [3d3898b4d72c677d47fe3cb554449f2df5c12555]
stable/5.10: [2037cb9d95f1741885f7daf50e8a028c4ade5317]
stable/5.15: [8393c80cce45f40c1256d72e21ad351b3650c57e]
stable/5.4: [3f8217c323fd6ecd6829a0c3ae7ac3f14eac368e]
stable/6.1: [70780914cb57e2ba711e0ac1b677aaaa75103603]
stable/6.6: [2e16a1389b5a7983b45cb2aa20b0e3f0ee364d6c]
stable/6.7: [fc67a2e18f4c4e3f07e9f9ae463da24530470e73]

CVE-2023-52602: jfs: fix slab-out-of-bounds Read in dtSearch

Announce: https://lore.kernel.org/linux-cve-announce/2024030646-CVE-2023-52602-393a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
Linux 4.4 looks to be affected.

Fixed status
mainline: [fa5492ee89463a7590a1449358002ff7ef63529f]
stable/4.19: [ce8bc22e948634a5c0a3fa58a179177d0e3f3950]
stable/5.10: [1c40ca3d39d769931b28295b3145c25f1decf5a6]
stable/5.15: [6c6a96c3d74df185ee344977d46944d6f33bb4dd]
stable/5.4: [1b9d6828589d57f94a23fb1c46112cda39d7efdb]
stable/6.1: [cab0c265ba182fd266c2aa3c69d7e40640a7f612]
stable/6.6: [7110650b85dd2f1cee819acd1345a9013a1a62f7]
stable/6.7: [bff9d4078a232c01e42e9377d005fb2f4d31a472]

CVE-2023-52603: UBSAN: array-index-out-of-bounds in dtSplitRoot

Announce: https://lore.kernel.org/linux-cve-announce/2024030647-CVE-2023-52603-e47b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
Bug is in the fs/jfs/jfs_dtree.c. Linux 4.4 looks to be affected.

Fixed status
mainline: [27e56f59bab5ddafbcfe69ad7a4a6ea1279c1b16]
stable/4.19: [e30b52a2ea3d1e0aaee68096957cf90a2f4ec5af]
stable/5.10: [7aa33854477d9c346f5560a1a1fcb3fe7783e2a8]
stable/5.15: [e4ce01c25ccbea02a09a5291c21749b1fc358e39]
stable/5.4: [fd3486a893778770557649fe28afa5e463d4ed07]
stable/6.1: [e4cbc857d75d4e22a1f75446e7480b1f305d8d60]
stable/6.6: [edff092a59260bf0b0a2eba219cb3da6372c2f9f]
stable/6.7: [6e2902ecc77e9760a9fc447f56d598383e2372d2]

CVE-2023-52604: FS:JFS:UBSAN:array-index-out-of-bounds in dbAdjTree

Announce: https://lore.kernel.org/linux-cve-announce/2024030647-CVE-2023-52604-41d9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
Bug is in the fs/jfs/jfs_dmap.c. Linux 4.4 looks to be affected.

Fixed status
mainline: [9862ec7ac1cbc6eb5ee4a045b5d5b8edbb2f7e68]
stable/4.19: [e3e95c6850661c77e6dab079d9b5374a618ebb15]
stable/5.10: [de34de6e57bbbc868e4fcf9e98c76b3587cabb0b]
stable/5.15: [6fe8b702125aeee6ce83f20092a2341446704e7b]
stable/5.4: [98f9537fe61b8382b3cc5dd97347531698517c56]
stable/6.1: [42f433785f108893de0dd5260bafb85d7d51db03]
stable/6.6: [6a44065dd604972ec1fbcccbdc4a70d266a89cdd]
stable/6.7: [59342822276f753e49d27ef5eebffbba990572b9]

CVE-2023-52605: ACPI: extlog: fix NULL pointer dereference check

Announce: https://lore.kernel.org/linux-cve-announce/2024030647-CVE-2023-52605-292a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
Linux 4.4 looks to be affected.

Fixed status
mainline: [72d9b9747e78979510e9aafdd32eb99c7aa30dd1]
stable/4.19: [b7b33627be0626b16ca321b982d6a2261ef7f703]
stable/5.10: [b17a71435e7e153e949df018244a98b4ede04069]
stable/5.15: [5457b0cbaa0238fc56b855c4ef2c0b9cc9c559ab]
stable/5.4: [d2049af7ddbc361702c3e1f09bd6c5e9488454ca]
stable/6.1: [33650372e3ead97c5ab3b84d9ad97737bc5e00c0]
stable/6.6: [f066171de33d71ff0f7c46bd17636a5a26db3fb6]
stable/6.7: [77846571b3ba6a6125a20ad109bb8514ba884cf9]

CVE-2023-52606: powerpc/lib: Validate size for vector operations

Announce: https://lore.kernel.org/linux-cve-announce/2024030647-CVE-2023-52606-fdcc@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
Linux 4.4 seems to be affected.

Fixed status
mainline: [8f9abaa6d7de0a70fc68acaedce290c1f96e2e59]
stable/4.19: [42084a428a139f1a429f597d44621e3a18f3e414]
stable/5.10: [beee482cc4c9a6b1dcffb2e190b4fd8782258678]
stable/5.15: [de4f5ed63b8a199704d8cdcbf810309d7eb4b36b]
stable/5.4: [0580f4403ad33f379eef865c2a6fe94de37febdf]
stable/6.1: [abd26515d4b767ba48241eea77b28ce0872aef3e]
stable/6.6: [28b8ba8eebf26f66d9f2df4ba550b6b3b136082c]
stable/6.7: [848e1d7fd710900397e1d0e7584680c1c04e3afd]

CVE-2023-52607: powerpc/mm: Fix null-pointer dereference in pgtable_cache_add

Announce: https://lore.kernel.org/linux-cve-announce/2024030647-CVE-2023-52607-75d1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
The fulnerable function pgtable_cache_add() is in the
/arch/powerpc/mm/init_64.c in Linux 4.4. It looks to be affected.

Fixed status
mainline: [f46c8a75263f97bda13c739ba1c90aced0d3b071]
stable/4.19: [21e45a7b08d7cd98d6a53c5fc5111879f2d96611]
stable/5.10: [aa28eecb43cac6e20ef14dfc50b8892c1fbcda5b]
stable/5.15: [ac3ed969a40357b0542d20f096a6d43acdfa6cc7]
stable/5.4: [f6781add1c311c17eff43e14c786004bbacf901e]
stable/6.1: [d482d61025e303a2bef3733a011b6b740215cfa1]
stable/6.6: [145febd85c3bcc5c74d87ef9a598fc7d9122d532]
stable/6.7: [ffd29dc45bc0355393859049f6becddc3ed08f74]

CVE-2024-26623: pds_core: Prevent race issues involving the adminq

Announce: https://lore.kernel.org/linux-cve-announce/2024030648-CVE-2024-26623-ee77@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 01ba61b ("pds_core: Add adminq processing and
commands") in v6.4-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc3.

Fixed status
mainline: [7e82a8745b951b1e794cc780d46f3fbee5e93447]
stable/6.6: [22cd6046eb2148b18990257505834dd45c672a1b]
stable/6.7: [5939feb63ea1f011027576c64b68b681cbad31ca]

CVE-2024-26624: af_unix: fix lockdep positive in sk_diag_dump_icons()

Announce: https://lore.kernel.org/linux-cve-announce/2024030648-CVE-2024-26624-3032@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2aac7a2 ("unix_diag: Pending connections IDs
NLA") in v3.3-rc1.
Fixed in v6.8-rc3.

Fixed status
mainline: [4d322dce82a1d44f8c83f0f54f95dd1b8dcf46c9]
stable/4.19: [875f31aaa67e306098befa5e798a049075910fa7]
stable/5.10: [f199018dc762dfa501f6d96a424468a0f3c10d9e]
stable/5.15: [c8f6b3b864cb876e9ee21666a391c9ee290682ac]
stable/5.4: [b169ffde733c5adf01788ae091c377f0eca44806]
stable/6.1: [a2104f43876408b164be5fd58f9b6a3a73b77746]
stable/6.6: [5e7f3e0381c002cb2abde42f09ad511991a8ebaf]
stable/6.7: [c2d272a9a1e8f22ba584589219f6fe1886a3595f]

CVE-2024-26625: llc: call sock_orphan() at release time

Announce: https://lore.kernel.org/linux-cve-announce/2024030648-CVE-2024-26625-3549@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4381548 ("net: sock_def_readable() and friends
RCU conversion") in v2.6.35-rc1.
Fixed in v6.8-rc3.

Fixed status
mainline: [aa2b2eb3934859904c287bf5434647ba72e14c1c]
stable/4.19: [6b950c712a9a05cdda4aea7fcb2848766576c11b]
stable/5.10: [d0b5b1f12429df3cd9751ab8b2f53729b77733b7]
stable/5.15: [dbc1b89981f9c5360277071d33d7f04a43ffda4a]
stable/5.4: [64babb17e8150771c58575d8f93a35c5296b499f]
stable/6.1: [9c333d9891f34cea8af1b229dc754552304c8eee]
stable/6.6: [3151051b787f7cd7e3329ea0016eb9113c248812]
stable/6.7: [8e51f084b5716653f19e291ed5f026791d4b3ed4]

CVE-2024-26626: ipmr: fix kernel panic when forwarding mcast packets

Announce: https://lore.kernel.org/linux-cve-announce/2024030648-CVE-2024-26626-a910@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit bb74036 ("ipmr: support IP_PKTINFO on cache
report IGMP msg") in v6.8-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc3.

Fixed status
mainline: [e622502c310f1069fd9f41cd38210553115f610a]
stable/6.1: [d2f1b7fe74afd66298dbb3c7b39e7b62e4df1724]
stable/6.6: [dcaafdba6c6162bb49f1192850bc3bbc3707738c]
stable/6.7: [2e8c9ae40adda2be1ba41c05fd3cd1e61cce3207]

CVE-2024-26627: scsi: core: Move scsi_host_busy() out of host lock for
waking up EH handler

Announce: https://lore.kernel.org/linux-cve-announce/2024030648-CVE-2024-26627-e3a2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6eb045e ("scsi: core: avoid host-wide host_busy
counter for scsi_mq") in v5.5-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc3.

Fixed status
mainline: [4373534a9850627a2695317944898eb1283a2db0]
stable/5.10: [f5944853f7a961fedc1227dc8f60393f8936d37c]
stable/5.15: [d37c1c81419fdef66ebd0747cf76fb8b7d979059]
stable/6.1: [db6338f45971b4285ea368432a84033690eaf53c]
stable/6.6: [65ead8468c21c2676d4d06f50b46beffdea69df1]
stable/6.7: [07e3ca0f17f579491b5f54e9ed05173d6c1d6fcb]

CVE-2024-26628: drm/amdkfd: Fix lock dependency warning

Announce: https://lore.kernel.org/linux-cve-announce/2024030649-CVE-2024-26628-f6ce@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
Affected functions svm_range_evict_svm_bo_worker() was added by commit
b41896e ("drm/amdkfd: add svm_bo eviction mechanism support "),
svm_range_trigger_migration() was add by commit 0b0e518 ("drm/amdkfd:
HMM migrate ram to vram"),
svm_range_bo_release() was adde by commit e49fe404 ("drm/amdkfd:
validate vram svm range from TTM"). These 3 commits were introduced in
5.14-rc1.

Fixed status
mainline: [47bf0f83fc86df1bf42b385a91aadb910137c5c9]
stable/5.15: [7a70663ba02bd4e19aea8d70c979eb3bd03d839d]
stable/6.1: [8b25d397162b0316ceda40afaa63ee0c4a97d28b]
stable/6.6: [28d2d623d2fbddcca5c24600474e92f16ebb3a05]
stable/6.7: [cb96e492d72d143d57db2d2bc143a1cee8741807]

* Updated CVEs

CVE-2023-52434: smb: client: fix potential OOBs in smb2_parse_contexts()

stable 5.10 and 5.15 were fixed.

Fixed status
mainline: [af1689a9b7701d9907dfc84d2a4b57c4bc907144]
stable/5.10: [13fb0fc4917621f3dfa285a27eaf7151d770b5e5]
stable/5.15: [890bc4fac3c0973a49cac35f634579bebba7fe48]
stable/6.1: [1ae3c59355dc9882e09c020afe8ffbd895ad0f29]
stable/6.6: [17a0f64cc02d4972e21c733d9f21d1c512963afa]

CVE-2024-0565: smb: client: fix OOB in receive_encrypted_standard()

stable 5.10 and 5.15 were fixed.

Fixed status
mainline: [eec04ea119691e65227a97ce53c0da6b9b74b0b7]
stable/5.10: [b03c8099a738a04d2343547ae6a04e5f0f63d3fa]
stable/5.15: [858e73ff25639a0cc1f6f8d2587b62c045867e41]
stable/6.1: [9f528a8e68327117837b5e28b096f52af4c26a05]
stable/6.6: [534733397da26de0303057ce0b93a22bda150365]

CVE-2024-26590: erofs: fix inconsistent per-file compression format

stable 6.1 was fixed.

Fixed status
mainline: [118a8cf504d7dfa519562d000f423ee3ca75d2c4]
stable/6.1: [47467e04816cb297905c0f09bc2d11ef865942d9]
stable/6.6: [823ba1d2106019ddf195287ba53057aee33cf724]
stable/6.7: [eed24b816e50c6cd18cbee0ff0d7218c8fced199]

CVE-2024-26601: ext4: regenerate buddy after block freeing failed if
under fc replay

stable 5.10 and 5.15 were fixed.

Fixed status
mainline: [c9b528c35795b711331ed36dc3dbee90d5812d4e]
stable/5.10: [94ebf71bddbcd4ab1ce43ae32c6cb66396d2d51a]
stable/5.15: [c1317822e2de80e78f137d3a2d99febab1b80326]
stable/6.1: [78327acd4cdc4a1601af718b781eece577b6b7d4]
stable/6.6: [ea42d6cffb0dd27a417f410b9d0011e9859328cb]
stable/6.7: [6b0d48647935e4b8c7b75d1eccb9043fcd4ee581]

CVE-2024-26603: x86/fpu: Stop relying on userspace for info to fault
in xsave buffer

stable 5.15 was fixed.

Fixed status
mainline: [d877550eaf2dc9090d782864c96939397a3c6835]
stable/5.15: [8bd3eee7720c14b59a206bd05b98d7586bccf99a]
stable/6.1: [627339cccdc9166792ecf96bc3c9f711a60ce996]
stable/6.6: [b2479ab426cef7ab79a13005650eff956223ced2]
stable/6.7: [627e28cbb65564e55008315d9e02fbb90478beda]

CVE-2023-2176: Kernel: Slab-out-of-bound read in compare_netdev_and_ip

stable 6.1 was fixed.

Fixed status
mainline: [8d037973d48c026224ab285e6a06985ccac6f7bf]
stable/6.1: [88067197e97af3fcb104dd86030f788ec1b32fdb]

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


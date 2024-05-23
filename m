Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5E1C25B78
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 00:57:17 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
 by mx.groups.io with SMTP id smtpd.web10.4849.1716425827905884038
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 May 2024 17:57:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=2gMRiIEa;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.51, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b7ee9b5429so173833eaf.1
        for <cip-dev@lists.cip-project.org>; Wed, 22 May 2024 17:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1716425827; x=1717030627; darn=lists.cip-project.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=95JWWMKoR7TggqfT4a3yiFvQWTuodSRS7pM8xond9XE=;
        b=2gMRiIEa5wDAoB4Q6VXzFpivJpZIHeSNSgJGUaua/kH1/CwL1j/2Yhu8afJQGDYtnM
         BRP9f6bvc3lL/WHXmO7OyvuUL3RK9QmymsendsiACpKEhOhBh/V4XPvUm3zQWGsEz5mU
         fqwevUnt0iideOAbqOADgMr70kp/R6lmZjijN3yBhKZi2tYqXPNJXr65zAfSMqnUvR49
         Xc2MyhHQ1EXYYTuYsFUpGVxuILRLXvATlImO3t8p78+nQnOGIgfXKL5SH52xBR+4j9VK
         Rv+vJbnqQIx3S3Mvgvbv/uEPZSiKdXvip7dFQInE3mOCg0lVFg7VI06kAxjUaRXdszHm
         Lmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716425827; x=1717030627;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95JWWMKoR7TggqfT4a3yiFvQWTuodSRS7pM8xond9XE=;
        b=raGU7HnYNO2JpZnO+86bITyPcJ7cInH8ksJkZWTjh7LB6lLblIebXi0AGj6ERk7Q9F
         mNNP2cC6tWvjKr95Sq1AUJfE6XUub6soF+jEy8hgPZBDbUuSUnqO+106o+WwDdr6+Lz8
         1lT6jjhCnfO+9WZPCRMnkbBZxLZPH5VXD4sEeG6eFfprepukkgdiW8PNFbf6cEYZl9Sf
         IrrxtQ8oqWVUf4hdrb5ICEayPahxuCs6FyH0gUU7dZLBsJIngLrLyxNJviHpIUdP/x1D
         1mXiMr7D/LIcZx3/TCPubfAEy+JiJHyh8TYTFFsjKsVkjrruIzAgaSPfrthQQuv9lv7O
         AWLg==
X-Gm-Message-State: AOJu0YzKw0s2XO11bL9IgtNp+2/cwbh8aTGpcOXS2phvp0hprjY+rwJU
	Fz+CWdaGKk052OvAV4+0+UD2f1cEVecff1ktTiD5maM6S4BXSAdBqAhpUSyY8lhSgDjgnHcHPLy
	MieLpyOqZBL73m6FiX4I5D+X/d+mMg/lWiyUxTq0ODPlQe9sWC5U=
X-Google-Smtp-Source: AGHT+IE3UGpj6bZbB8WcJgiX+pOfm1xar3zH3A/vKfc4V/uw2IQU6kOw7qsD1iiX+fQOW1bsUa3p6g+CCwpmHfnqxaM=
X-Received: by 2002:a05:6870:e412:b0:23f:4413:67bd with SMTP id
 586e51a60fabf-24c8365ae52mr402533fac.6.1716425823973; Wed, 22 May 2024
 17:57:03 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 23 May 2024 09:56:27 +0900
Message-ID: <CAODzB9pO==EZEVU-weviDj06jaHWEco7QTweYS3bvZaKq48NHg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 May 2024 00:57:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15924

Hi!

It's this week's CVE report.

This week reported 685 new CVEs and 8 updated CVEs.

* New CVEs

CVE-2023-38417: Improper input validation for some Intel(R)
PROSet/Wireless WiFi software
before version 23.20 may allow an unauthenticated user to potentially
enable denial of service via adjacent access.

Announce: https://www.cve.org/CVERecord?id=3DCVE-2023-38417
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

It looks as if this bug is Intel wifi software's bug.

Fixed status
Not fixed yet.

CVE-2023-47210: Improper input validation for some Intel(R)
PROSet/Wireless WiFi software
for linux before version 23.20 may allow an unauthenticated user to
potentially enable denial of service via adjacent access.

Announce: https://www.cve.org/CVERecord?id=3DCVE-2023-47210
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

It looks as if this bug is Intel wifi software's bug.

Fixed status
Not fixed yet.

CVE-2023-52657: Revert "drm/amd/pm: resolve reboot exception for si oland"

Announce: https://lore.kernel.org/linux-cve-announce/2024051758-CVE-2023-52=
657-628c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

This fix reverts commit e490d60 ("drm/amd/pm: resolve reboot exception
for si oland"). Fixed in v6.8-rc7.
The commit e490d60 was backported to 6.1 and 6.6.

Fixed status
mainline: [955558030954b9637b41c97b730f9b38c92ac488]
stable/6.1: [2e443ed55fe3ffb08327b331a9f45e9382413c94]
stable/6.6: [baac292852c0e347626fb5436916947188e5838f]

CVE-2023-52658: Revert "net/mlx5: Block entering switchdev mode with
ns inconsistency"

Announce: https://lore.kernel.org/linux-cve-announce/2024051717-CVE-2023-52=
658-4c61@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 662404b ("net/mlx5e: Block entering switchdev
mode with ns inconsistency") in v6.3-rc4.
Fixed in v6.8.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [8deeefb24786ea7950b37bde4516b286c877db00]
stable/6.6: [3fba8eab2cfc7334e0f132d29dfd2552f2f2a579]

CVE-2023-52659: x86/mm: Ensure input to pfn_to_kaddr() is treated as a
64-bit type

Announce: https://lore.kernel.org/linux-cve-announce/2024051755-CVE-2023-52=
659-6f51@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6c32117 ("x86/sev: Add SNP-specific unaccepted
memory support") in v6.5-rc1.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [8e5647a723c49d73b9f108a8bb38e8c29d3948ea]
stable/6.6: [325956b0173f11e98f90462be4829a8b8b0682ce]
stable/6.8: [814305b5c23cb815ada68d43019f39050472b25f]

CVE-2023-52660: media: rkisp1: Fix IRQ handling due to shared interrupts

Announce: https://lore.kernel.org/linux-cve-announce/2024051755-CVE-2023-52=
660-6eac@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc5.

Fixed status
mainline: [ffb635bb398fc07cb38f8a7b4a82cbe5f412f08e]
stable/6.1: [abd34206f396d3ae50cddbd5aa840b8cd7f68c63]
stable/6.6: [b39b4d207d4f236a74e20d291f6356f2231fd9ee]

CVE-2023-52661: drm/tegra: rgb: Fix missing clk_put() in the error
handling paths of tegra_dc_rgb_probe()

Announce: https://lore.kernel.org/linux-cve-announce/2024051738-CVE-2023-52=
661-5539@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0c921b6 ("drm/tegra: dc: rgb: Allow changing PLLD
rate on Tegra30+") in v5.17-rc1.
Fixed in v6.8.2.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [fa74e4f5d0821829545b9f7034a0e577c205c101]
stable/6.1: [5c8dc26e31b8b410ad1895e0d314def50c76eed0]
stable/6.6: [f3f407ccbe84a34de9be3195d22cdd5969f3fd9f]
stable/6.8: [2388c36e028fff7f8ffd515681a14c6c2c07fea7]

CVE-2023-52662: drm/vmwgfx: fix a memleak in vmw_gmrid_man_get_node

Announce: https://lore.kernel.org/linux-cve-announce/2024051740-CVE-2023-52=
662-1536@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d3bcb4b ("drm/vmwgfx: switch the TTM backends to
self alloc") in v5.14-rc1.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [89709105a6091948ffb6ec2427954cbfe45358ce]
stable/5.15: [03b1072616a8f7d6e8594f643b416a9467c83fbf]
stable/6.1: [40624af6674745e174c754a20d7c53c250e65e7a]
stable/6.6: [83e0f220d1e992fa074157fcf14945bf170ffbc5]
stable/6.8: [d1e546ab91c670e536a274a75481034ab7534876]

CVE-2023-52663: ASoC: SOF: amd: Fix memory leak in amd_sof_acp_probe()

Announce: https://lore.kernel.org/linux-cve-announce/2024051740-CVE-2023-52=
663-1045@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f7da880 ("ASoC: SOF: amd: Enable signed firmware
image loading for Vangogh platform") in v6.6-rc1.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [222be59e5eed1554119294edc743ee548c2371d0]
stable/6.6: [88028c45d5871dfc449b2b0a27abf6428453a5ec]
stable/6.8: [7296152e58858f928db448826eb7ba5ae611297b]

CVE-2023-52664: net: atlantic: eliminate double free in error handling logi=
c

Announce: https://lore.kernel.org/linux-cve-announce/2024051756-CVE-2023-52=
664-dea1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
This driver was introduced by commit 5015024 ("net: ethernet:
aquantia: Make and configuration files.") in 4.11-rc1.

Fixed status
mainline: [b3cb7a830a24527877b0bc900b9bd74a96aea928]
stable/6.1: [0edb3ae8bfa31cd544b0c195bdec00e036002b5d]
stable/6.6: [c11a870a73a3bc4cc7df6dd877a45b181795fcbf]

CVE-2024-21823: dmaengine/idxd: hardware erratum allows potential
security problem with direct access by untrusted application


Announce: https://www.cve.org/CVERecord?id=3DCVE-2024-21823
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Bug introduced commit is not determined. Fixed in master branch in the main=
line.

Fixed status
mainline: [95feb3160eef0caa6018e175a5560b816aee8e79,
e11452eb071b2a8e6ba52892b2e270bbdaa6640d,
  6827738dc684a87ad54ebba3ae7f3d7c977698eb]
stable/6.1: [9ff3c42aa37c2e6989e9b73d466737ef13d74969,
3e4368832e5478bec54c0b83e7c3fb390518bb96,
  5056d238937dc7ef9fdf7c06a5bf64f9b04091c0]
stable/6.6: [c516453577d00abbe922215c9ffe97df39551ace,
8cacaaa4756899408e23c658f5d9091a2583b680,
  9fda5aed60a0b7098f5a5a03aa1a7f9f5f10eb6e]
stable/6.8: [43c888436f1d7dee5e8fc5e48c8b58f09a5cc1dc,
a8787353d21381a1e21b18e71f35178e7fc50079,
  2ddfa52d50290a723b5e9985f7eb4de5efa1217c]
stable/6.9: [fa20fd0f9cd9748490175f58091e7d695ef675a0,
8da3a84ebb9260b70b9127c4850c9a118f1eac12,
  21a8f1ce35d3da4a830250f4e10a81b379807e39]

CVE-2024-27402: phonet/pep: fix racy skb_queue_empty() use

Announce: https://lore.kernel.org/linux-cve-announce/2024051736-CVE-2024-27=
402-90cf@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9641458 ("Phonet: Pipe End Point for Phonet Pipes
protocol") in v2.6.28-rc1.
Fixed in v6.8-rc6.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [7d2a894d7f487dcb894df023e9d3014cf5b93fe5]
stable/6.1: [9d5523e065b568e79dfaa2ea1085a5bcf74baf78]
stable/6.6: [0a9f558c72c47472c38c05fcb72c70abb9104277]

CVE-2024-27403: netfilter: nft_flow_offload: reset dst in route object
after setting up flow

Announce: https://lore.kernel.org/linux-cve-announce/2024051738-CVE-2024-27=
403-c4ba@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a3c90f7 ("netfilter: nf_tables: flow offload
expression") in v4.16-rc1.
Fixed in v6.8-rc6.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [9e0f0430389be7696396c62f037be4bf72cf93e3]
stable/5.15: [4c167af9f6b5ae4a5dbc243d5983c295ccc2e43c]
stable/6.1: [012df10717da02367aaf92c65f9c89db206c15f4]
stable/6.6: [558b00a30e05753a62ecc7e05e939ca8f0241148]

CVE-2024-27404: mptcp: fix data races on remote_id

Announce: https://lore.kernel.org/linux-cve-announce/2024051738-CVE-2024-27=
404-ab54@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit bedee0b ("mptcp: address lookup improvements") in v6.0=
-rc1.
Fixed in v6.8-rc6.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [967d3c27127e71a10ff5c083583a038606431b61]
stable/6.1: [e64148635509bf13eea851986f5a0b150e5bd066]
stable/6.6: [2dba5774e8ed326a78ad4339d921a4291281ea6e]

CVE-2024-27405: usb: gadget: ncm: Avoid dropping datagrams of properly
parsed NTBs

Announce: https://lore.kernel.org/linux-cve-announce/2024051739-CVE-2024-27=
405-6768@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9f6ce42 ("usb: gadget: f_ncm.c added") in v2.6.38-rc1.
Fixed in v6.8-rc6.
Bug introduced commit is not backported to older stable kernels

Fixed status
cip/4.4: [abc80c3cad53f506d5688eeb1a0173fdcfb6d1c3]
cip/4.4-rt: [abc80c3cad53f506d5688eeb1a0173fdcfb6d1c3]
cip/4.4-st: [abc80c3cad53f506d5688eeb1a0173fdcfb6d1c3]
mainline: [76c51146820c5dac629f21deafab0a7039bc3ccd]
stable/4.19: [059285e04ebb273d32323fbad5431c5b94f77e48]
stable/5.10: [57ca0e16f393bb21d69734e536e383a3a4c665fd]
stable/5.15: [2cb66b62a5d64ccf09b0591ab86fb085fa491fc5]
stable/5.4: [a31cf46d108dabce3df80b3e5c07661e24912151]
stable/6.1: [35b604a37ec70d68b19dafd10bbacf1db505c9ca]
stable/6.6: [2b7ec68869d50ea998908af43b643bca7e54577e]

CVE-2024-27406: lib/Kconfig.debug: TEST_IOV_ITER depends on MMU

Announce: https://lore.kernel.org/linux-cve-announce/2024051739-CVE-2024-27=
406-cfc3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2d71340 ("iov_iter: Kunit tests for copying
to/from an iterator") in v6.6-rc1.
Fixed in v6.8-rc6.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [1eb1e984379e2da04361763f66eec90dd75cf63e]
stable/6.6: [e6316749d603fe9c4c91f6ec3694e06e4de632a3]

CVE-2024-27407: fs/ntfs3: Fixed overflow check in mi_enum_attr()

Announce: https://lore.kernel.org/linux-cve-announce/2024051739-CVE-2024-27=
407-976d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

It was introduced by commit 4342306 ("s/ntfs3: Add file operations and
implementation") in 5.15-rc1. Fixed in v6.8-rc4.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [652cfeb43d6b9aba5c7c4902bed7a7340df131fb]
stable/6.6: [8c77398c72618101d66480b94b34fe9087ee3d08]

CVE-2024-27408: dmaengine: dw-edma: eDMA: Add sync read before
starting the DMA transfer in remote setup

Announce: https://lore.kernel.org/linux-cve-announce/2024051700-CVE-2024-27=
408-6911@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7e4b8a4 ("dmaengine: Add Synopsys eDMA IP version
0 support") in v5.3-rc1.
Fixed in v6.8-rc7.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [bbcc1c83f343e580c3aa1f2a8593343bf7b55bba]
stable/6.6: [d24fe6d5a1cfdddb7a9ef56736ec501c4d0a5fd3]

CVE-2024-27409: dmaengine: dw-edma: HDMA: Add sync read before
starting the DMA transfer in remote setup

Announce: https://lore.kernel.org/linux-cve-announce/2024051701-CVE-2024-27=
409-f797@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e74c395 ("dmaengine: dw-edma: Add support for
native HDMA") in v6.5-rc1.
Fixed in v6.8-rc7.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [712a92a48158e02155b4b6b21e03a817f78c9b7e]
stable/6.6: [227ef58a9b0c372efba422e8886a8015a1509eba]

CVE-2024-27410: wifi: nl80211: reject iftype change with mesh ID change

Announce: https://lore.kernel.org/linux-cve-announce/2024051701-CVE-2024-27=
410-874a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 29cbe68 ("cfg80211/mac80211: add mesh join/leave
commands") in v2.6.38-rc1.
Fixed in v6.8-rc7.
Bug introduced commit is not backported to older stable kernels

Fixed status
cip/4.4: [3715d24caf8c85422edb905db4761fe42bcc31e0]
cip/4.4-rt: [3715d24caf8c85422edb905db4761fe42bcc31e0]
cip/4.4-st: [3715d24caf8c85422edb905db4761fe42bcc31e0]
mainline: [f78c1375339a291cba492a70eaf12ec501d28a8e]
stable/4.19: [d38d31bbbb9dc0d4d71a45431eafba03d0bc150d]
stable/5.10: [99eb2159680af8786104dac80528acd5acd45980]
stable/5.15: [063715c33b4c37587aeca2c83cf08ead0c542995]
stable/5.4: [0cfbb26ee5e7b3d6483a73883f9f6157bca22ec9]
stable/6.1: [930e826962d9f01dcd2220176134427358d112f2]
stable/6.6: [177d574be4b58f832354ab1ef5a297aa0c9aa2df]

CVE-2024-27411: drm/nouveau: keep DMA buffers required for suspend/resume

Announce: https://lore.kernel.org/linux-cve-announce/2024051701-CVE-2024-27=
411-1af2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 042b5f8 ("drm/nouveau: fix several DMA buffer
leaks") in 6.8-rc4. Fixed in 6.8-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f6ecfdad359a01c7fd8a3bcfde3ef0acdf107e6e]

CVE-2024-27412: power: supply: bq27xxx-i2c: Do not free non existing IRQ

Announce: https://lore.kernel.org/linux-cve-announce/2024051702-CVE-2024-27=
412-3c4b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 444ff00 ("power: supply: bq27xxx: Fix I2C IRQ
race on remove") in v6.4-rc4.
Fixed in v6.8-rc7.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt
stable/4.19 stable/5.10 stable/5.15 stable/5.4 stable/6.1

Fixed status
mainline: [2df70149e73e79783bcbc7db4fa51ecef0e2022c]
stable/4.19: [d4d813c0a14d6bf52d810a55db06a2e7e3d98eaa]
stable/5.10: [d7acc4a569f5f4513120c85ea2b9f04909b7490f]
stable/5.15: [e601ae81910ce6a3797876e190a2d8ef6cf828bc]
stable/5.4: [7394abc8926adee6a817bab10797e0adc898af77]
stable/6.1: [cefe18e9ec84f8fe3e198ccebb815cc996eb9797]
stable/6.6: [fbca8bae1ba79d443a58781b45e92a73a24ac8f8]

CVE-2024-27413: efi/capsule-loader: fix incorrect allocation size

Announce: https://lore.kernel.org/linux-cve-announce/2024051702-CVE-2024-27=
413-bccd@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f24c4d4 ("efi/capsule-loader: Reinstate virtual
capsule mapping") in v4.15-rc7.
Fixed in v6.8-rc7.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [fccfa646ef3628097d59f7d9c1a3e84d4b6bb45e]
stable/4.19: [00cf21ac526011a29fc708f8912da446fac19f7b]
stable/5.10: [537e3f49dbe88881a6f0752beaa596942d9efd64]
stable/5.15: [4b73473c050a612fb4317831371073eda07c3050]
stable/5.4: [950d4d74d311a18baed6878dbfba8180d7e5dddd]
stable/6.1: [ddc547dd05a46720866c32022300f7376c40119f]
stable/6.6: [11aabd7487857b8e7d768fefb092f66dfde68492]

CVE-2024-27414: rtnetlink: fix error logic of IFLA_BRIDGE_FLAGS writing bac=
k

Announce: https://lore.kernel.org/linux-cve-announce/2024051702-CVE-2024-27=
414-5c5d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d73ef2d ("rtnetlink: let rtnl_bridge_setlink
checks IFLA_BRIDGE_MODE length") in v6.5-rc5.
Fixed in v6.8-rc7.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/5.4 stable/6.1

Fixed status
mainline: [743ad091fb46e622f1b690385bb15e3cd3daf874]
stable/5.10: [882a51a10ecf24ce135d573afa0872aef02c5125]
stable/5.15: [a1227b27fcccc99dc44f912b479e01a17e2d7d31]
stable/5.4: [b9fbc44159dfc3e9a7073032752d9e03f5194a6f]
stable/6.1: [f2261eb994aa5757c1da046b78e3229a3ece0ad9]
stable/6.6: [167d8642daa6a44b51de17f8ff0f584e1e762db7]

CVE-2024-27415: netfilter: bridge: confirm multicast packets before
passing them up the stack

Announce: https://lore.kernel.org/linux-cve-announce/2024051702-CVE-2024-27=
415-dcae@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.8-rc7.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [62e7151ae3eb465e0ab52a20c941ff33bb6332e9]
stable/5.15: [7c3f28599652acf431a2211168de4a583f30b6d5]
stable/6.1: [2b1414d5e94e477edff1d2c79030f1d742625ea0]
stable/6.6: [80cd0487f630b5382734997c3e5e3003a77db315]

CVE-2024-27416: Bluetooth: hci_event: Fix handling of HCI_EV_IO_CAPA_REQUES=
T

Announce: https://lore.kernel.org/linux-cve-announce/2024051703-CVE-2024-27=
416-f368@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c7f5946 ("Bluetooth: Fix a refcnt underflow
problem for hci_conn") in v6.6-rc7.
Fixed in v6.8-rc7.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10
cip/5.10-rt cip/6.1 cip/6.1-rt stable/4.19 stable/5.10 stable/5.15
stable/5.4 stable/6.1

Fixed status
cip/4.4: [8d756eeb85e8aed412ab3f6682771d0d4e3f6726]
cip/4.4-rt: [8d756eeb85e8aed412ab3f6682771d0d4e3f6726]
cip/4.4-st: [8d756eeb85e8aed412ab3f6682771d0d4e3f6726]
mainline: [7e74aa53a68bf60f6019bd5d9a9a1406ec4d4865]
stable/4.19: [afec8f772296dd8e5a2a6f83bbf99db1b9ca877f]
stable/5.10: [df193568d61234c81de7ed4d540c01975de60277]
stable/5.15: [c3df637266df29edee85e94cab5fd7041e5753ba]
stable/5.4: [79820a7e1e057120c49be07cbe10643d0706b259]
stable/6.1: [30a5e812f78e3d1cced90e1ed750bf027599205f]
stable/6.6: [fba268ac36ab19f9763ff90d276cde0ce6cd5f31]

CVE-2024-27417: ipv6: fix potential "struct net" leak in inet6_rtm_getaddr(=
)

Announce: https://lore.kernel.org/linux-cve-announce/2024051703-CVE-2024-27=
417-3841@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6ecf4c3 ("ipv6: enable IFA_TARGET_NETNSID for
RTM_GETADDR") in v4.20-rc1.
Fixed in v6.8-rc7.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [10bfd453da64a057bcfd1a49fb6b271c48653cdb]
stable/5.10: [810fa7d5e5202fcfb22720304b755f1bdfd4c174]
stable/5.15: [8a54834c03c30e549c33d5da0975f3e1454ec906]
stable/5.4: [9d4ffb5b9d879a75e4f7460e8b10e756b4dfb132]
stable/6.1: [1b0998fdd85776775d975d0024bca227597e836a]
stable/6.6: [44112bc5c74e64f28f5a9127dc34066c7a09bd0f]

CVE-2024-27418: net: mctp: take ownership of skb in mctp_local_output

Announce: https://lore.kernel.org/linux-cve-announce/2024051703-CVE-2024-27=
418-3cda@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 833ef3b ("mctp: Populate socket implementation")
in v5.15-rc1.
Fixed in v6.8-rc7.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [3773d65ae5154ed7df404b050fd7387a36ab5ef3]
stable/6.1: [a3c8fa54e904b0ddb52a08cc2d8ac239054f61fd]
stable/6.6: [cbebc55ceacef1fc0651e80e0103cc184552fc68]

CVE-2024-27419: netrom: Fix data-races around sysctl_net_busy_read

Announce: https://lore.kernel.org/linux-cve-announce/2024051719-CVE-2024-27=
419-726a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.8.
Bug introduced commit is not backported to older stable kernels

Fixed status
cip/4.4: [ffbb40d27ad7efeb65447ef403435c580945f8fe]
cip/4.4-rt: [ffbb40d27ad7efeb65447ef403435c580945f8fe]
cip/4.4-st: [ffbb40d27ad7efeb65447ef403435c580945f8fe]
mainline: [d380ce70058a4ccddc3e5f5c2063165dc07672c6]
stable/4.19: [d623fd5298d95b65d27ef5a618ebf39541074856]
stable/5.10: [bbf950a6e96a91cf8cf0c71117b94ed3fafc9dd3]
stable/5.15: [0866afaff19d8460308b022345ed116a12b1d0e1]
stable/5.4: [f9055fa2b2931261d5f89948ee5bc315b6a22d4a]
stable/6.1: [43464808669ba9d23996f0b6d875450191687caf]
stable/6.6: [34cab94f7473e7b09f5205d4583fb5096cb63b5b]

CVE-2024-27420: netrom: Fix a data-race around sysctl_netrom_link_fails_cou=
nt

Announce: https://lore.kernel.org/linux-cve-announce/2024051720-CVE-2024-27=
420-f76f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.8.
Bug introduced commit is not backported to older stable kernels

Fixed status
cip/4.4: [e0876094a42d1a2b6c5842f5eccd1600c67f17f6]
cip/4.4-rt: [e0876094a42d1a2b6c5842f5eccd1600c67f17f6]
cip/4.4-st: [e0876094a42d1a2b6c5842f5eccd1600c67f17f6]
mainline: [bc76645ebdd01be9b9994dac39685a3d0f6f7985]
stable/4.19: [97a4d8b9f67cc7efe9a0c137e12f6d9e40795bf1]
stable/5.10: [cfe0f73fb38a01bce86fe15ef5f750f850f7d3fe]
stable/5.15: [c558e54f7712b086fbcb611723272a0a4b0d451c]
stable/5.4: [07bbccd1adb56b39eef982b8960d59e3c005c6a1]
stable/6.1: [cfedde3058bf976f2f292c0a236edd43afcdab57]
stable/6.6: [db364859ce68fb3a52d42cd87a54da3dc42dc1c8]

CVE-2024-27421: netrom: Fix a data-race around sysctl_netrom_routing_contro=
l

Announce: https://lore.kernel.org/linux-cve-announce/2024051720-CVE-2024-27=
421-77a2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.8.
Bug introduced commit is not backported to older stable kernels

Fixed status
cip/4.4: [519faf5cb8d7ba2757d9bffbf427dba1b344e708]
cip/4.4-rt: [519faf5cb8d7ba2757d9bffbf427dba1b344e708]
cip/4.4-st: [519faf5cb8d7ba2757d9bffbf427dba1b344e708]
mainline: [b5dffcb8f71bdd02a4e5799985b51b12f4eeaf76]
stable/4.19: [c13fbb5902bce848759385986d4833f5b90782c1]
stable/5.10: [b7d33e083f9d5d39445c0a91e7ad4f3e2c47fcb5]
stable/5.15: [f9c4d42464173b826190fae2283ed1a4bbae0c8b]
stable/5.4: [c4309e5f8e80584715c814e1d012dbc3eee5a500]
stable/6.1: [4c02b9ccbb11862ee39850b2b285664cd579b039]
stable/6.6: [d732b83251322ecd3b503e03442247745d6052ce]

CVE-2024-27422: netrom: Fix a data-race around
sysctl_netrom_transport_no_activity_timeout

Announce: https://lore.kernel.org/linux-cve-announce/2024051720-CVE-2024-27=
422-2854@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.8.
Bug introduced commit is not backported to older stable kernels

Fixed status
cip/4.4: [9b975c8c70af532cbb57fa48cca6f59465cddd20]
cip/4.4-rt: [9b975c8c70af532cbb57fa48cca6f59465cddd20]
cip/4.4-st: [9b975c8c70af532cbb57fa48cca6f59465cddd20]
mainline: [f99b494b40431f0ca416859f2345746199398e2b]
stable/4.19: [73426c32e259c767d40613b956d5b80d0c28a9a9]
stable/5.10: [01d4e3afe257768cd2a45f15a0e57bacf932b140]
stable/5.15: [4eacb242e22e31385a50a393681d0fe4b55ed1e9]
stable/5.4: [cbba77abb4a553c1f5afac1ba2a0861aa1f13549]
stable/6.1: [498f1d6da11ed6d736d655a2db14ee2d9569eecb]
stable/6.6: [2309b369fae2d9cdc3c945cd3eaec84eb1958ca3]

CVE-2024-27423: netrom: Fix a data-race around
sysctl_netrom_transport_requested_window_size

Announce: https://lore.kernel.org/linux-cve-announce/2024051720-CVE-2024-27=
423-3abe@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.8.
Bug introduced commit is not backported to older stable kernels

Fixed status
cip/4.4: [9e7f0f0c55e2a2a0b5683f2012553a155b813134]
cip/4.4-rt: [9e7f0f0c55e2a2a0b5683f2012553a155b813134]
cip/4.4-st: [9e7f0f0c55e2a2a0b5683f2012553a155b813134]
mainline: [a2e706841488f474c06e9b33f71afc947fb3bf56]
stable/4.19: [4f2efa17c3ec5e4be0567b47439b9713c0dc6550]
stable/5.10: [652b0b35819610a42b8a90d21acb12f69943b397]
stable/5.15: [489e05c614dbeb1a1148959f02bdb788891819e6]
stable/5.4: [89aa78a34340e9dbc3248095f44d81d0e1c23193]
stable/6.1: [46803b776d869b0c36041828a83c4f7da2dfa03b]
stable/6.6: [db006d7edbf0b4800390ece3727a82f4ae764043]

CVE-2024-27424: netrom: Fix a data-race around
sysctl_netrom_transport_busy_delay

Announce: https://lore.kernel.org/linux-cve-announce/2024051721-CVE-2024-27=
424-abaf@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.8.
Bug introduced commit is not backported to older stable kernels

Fixed status
cip/4.4: [fd552ce73594ecc471b44d3ced025b6105256f57]
cip/4.4-rt: [fd552ce73594ecc471b44d3ced025b6105256f57]
cip/4.4-st: [fd552ce73594ecc471b44d3ced025b6105256f57]
mainline: [43547d8699439a67b78d6bb39015113f7aa360fd]
stable/4.19: [7782e5e7047cae6b9255ee727c99fc73d77cf773]
stable/5.10: [f3315a6edaec12b461031eab8c98c78111a41f95]
stable/5.15: [85f34d352f4b79afd63dd13634b23dafe6b570f9]
stable/5.4: [1f60795dcafc97c45984240d442cdc151f825977]
stable/6.1: [5ac337138272d26d6d3d4f71bc5b1a87adf8b24d]
stable/6.6: [4ccad39009e7bd8a03d60a97c87b0327ae812880]

CVE-2024-27425: netrom: Fix a data-race around
sysctl_netrom_transport_acknowledge_delay

Announce: https://lore.kernel.org/linux-cve-announce/2024051721-CVE-2024-27=
425-a235@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.8.
Bug introduced commit is not backported to older stable kernels

Fixed status
cip/4.4: [f9196386b13ee9be60a14629d9b7d9e773996729]
cip/4.4-rt: [f9196386b13ee9be60a14629d9b7d9e773996729]
cip/4.4-st: [f9196386b13ee9be60a14629d9b7d9e773996729]
mainline: [806f462ba9029d41aadf8ec93f2f99c5305deada]
stable/4.19: [6133a71c75dacea12fcc85838b4455c2055b0f14]
stable/5.10: [34c84e0036a60e7e50ae50b42ed194d8daef8cc9]
stable/5.15: [33081e0f34899d5325e7c45683dd8dc9cb18b583]
stable/5.4: [80578681ea274e0a6512bb7515718c206a7b74cf]
stable/6.1: [5deaef2bf56456c71b841e0dfde1bee2fd88c4eb]
stable/6.6: [7d56ffc51ebd2777ded8dca50d631ee19d97db5c]

CVE-2024-27426: netrom: Fix a data-race around
sysctl_netrom_transport_maximum_tries

Announce: https://lore.kernel.org/linux-cve-announce/2024051721-CVE-2024-27=
426-341e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.8.
Bug introduced commit is not backported to older stable kernels

Fixed status
cip/4.4: [6ce0039cb29296621e52e429cc7ee09705ac57cb]
cip/4.4-rt: [6ce0039cb29296621e52e429cc7ee09705ac57cb]
cip/4.4-st: [6ce0039cb29296621e52e429cc7ee09705ac57cb]
mainline: [e799299aafed417cc1f32adccb2a0e5268b3f6d5]
stable/4.19: [84b8486e9cedc93875f251ba31abcf73bd586a3a]
stable/5.10: [34a164d2448264b62af82bc0af3d2c83d12d38ac]
stable/5.15: [f84f7709486d8a578ab4b7d2a556d1b1a59cfc97]
stable/5.4: [f716a68234242f95305dffb5c9426caa64b316b0]
stable/6.1: [d28fa5f0e6c1554e2829f73a6a276c9a49689d04]
stable/6.6: [fa3f3ab5c399852d32a0c3cbb8c55882f7e2c61f]

CVE-2024-27427: netrom: Fix a data-race around sysctl_netrom_transport_time=
out

Announce: https://lore.kernel.org/linux-cve-announce/2024051722-CVE-2024-27=
427-14e0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.8.
Bug introduced commit is not backported to older stable kernels

Fixed status
cip/4.4: [0724aa697ec7d939f843983bf1e9f1419d812e15]
cip/4.4-rt: [0724aa697ec7d939f843983bf1e9f1419d812e15]
cip/4.4-st: [0724aa697ec7d939f843983bf1e9f1419d812e15]
mainline: [60a7a152abd494ed4f69098cf0f322e6bb140612]
stable/4.19: [500936692ccca8617a955652d1929f079b17a201]
stable/5.10: [291d36d772f5ea5c68a263ee440f2c9eade371c9]
stable/5.15: [b8006cb0a34aaf85cdd8741f4148fd9c76b351d3]
stable/5.4: [eadec8da4451c2c0897199691184602e4ee497d1]
stable/6.1: [fed835d415766a94fc0246dcebc3af4c03fe9941]
stable/6.6: [5d5c14efc987900509cec465af26608e39ac607c]

CVE-2024-27428: netrom: Fix data-races around
sysctl_netrom_network_ttl_initialiser

Announce: https://lore.kernel.org/linux-cve-announce/2024051722-CVE-2024-27=
428-2df6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.8.
Bug introduced commit is not backported to older stable kernels

Fixed status
cip/4.4: [94dc0503591a5abaf1c122dbe03f999fc1b9043d]
cip/4.4-rt: [94dc0503591a5abaf1c122dbe03f999fc1b9043d]
cip/4.4-st: [94dc0503591a5abaf1c122dbe03f999fc1b9043d]
mainline: [119cae5ea3f9e35cdada8e572cc067f072fa825a]
stable/4.19: [acc653e8a3aaab1b7103f98645f2cce7be89e3d3]
stable/5.10: [d1261bde59a3a087ab0c81181821e194278d9264]
stable/5.15: [775ed3549819f814a6ecef5726d2b4c23f249b77]
stable/5.4: [eda02a0bed550f07a8283d3e1f25b90a38e151ed]
stable/6.1: [a47d68d777b41862757b7e3051f2d46d6e25f87b]
stable/6.6: [5731369af2de21695fe7c1c91fe134fabe5b33b8]

CVE-2024-27429: netrom: Fix a data-race around
sysctl_netrom_obsolescence_count_initialiser

Announce: https://lore.kernel.org/linux-cve-announce/2024051722-CVE-2024-27=
429-878c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.8.
Bug introduced commit is not backported to older stable kernels

Fixed status
cip/4.4: [c2df305898642a4b1b01f742bde441da2252ae2c]
cip/4.4-rt: [c2df305898642a4b1b01f742bde441da2252ae2c]
cip/4.4-st: [c2df305898642a4b1b01f742bde441da2252ae2c]
mainline: [cfd9f4a740f772298308b2e6070d2c744fb5cf79]
stable/4.19: [e3a3718b1723253d4f068e88e81d880d71f1a1e9]
stable/5.10: [18c95d11c347a12e5c31df1325cef6b995d14ecf]
stable/5.15: [b3f0bc3a315cf1af03673a0163c08fe037587acd]
stable/5.4: [1e84b108f2a71daa8d04032e4d2096522376debb]
stable/6.1: [e439607291c082332e1e35baf8faf8552e6bcb4a]
stable/6.6: [7e1e25891f090e24a871451c9403abac63cb45dd]

CVE-2024-27430: netrom: Fix a data-race around
sysctl_netrom_default_path_quality

Announce: https://lore.kernel.org/linux-cve-announce/2024051723-CVE-2024-27=
430-f8b8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.8.
Bug introduced commit is not backported to older stable kernels

Fixed status
cip/4.4: [c1403c85e873ca0146899f7b16c4fdc11347e5aa]
cip/4.4-rt: [c1403c85e873ca0146899f7b16c4fdc11347e5aa]
cip/4.4-st: [c1403c85e873ca0146899f7b16c4fdc11347e5aa]
mainline: [958d6145a6d9ba9e075c921aead8753fb91c9101]
stable/4.19: [7644df766006d4878a556e427e3ecc78c2d5606b]
stable/5.10: [e041df5dc9e68adffcba5499ca28e1252bed6f4b]
stable/5.15: [bbc21f134b89535d1cf110c5f2b33ac54e5839c4]
stable/5.4: [7f615232556f3c6e3eeecef96ef2b00d0aa905bb]
stable/6.1: [dec82a8fc45c6ce494c2cb31f001a2aadb132b57]
stable/6.6: [7510b08c5f5ba15983da004b021fc6154eeb4047]

CVE-2024-27431: cpumap: Zero-initialise xdp_rxq_info struct before
running XDP program

Announce: https://lore.kernel.org/linux-cve-announce/2024051723-CVE-2024-27=
431-30ae@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9216477 ("bpf: cpumap: Add the possibility to
attach an eBPF program to cpumap") in v5.9-rc1.
Fixed in v6.8.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [2487007aa3b9fafbd2cb14068f49791ce1d7ede5]
stable/5.10: [5f4e51abfbe6eb444fa91906a5cd083044278297]
stable/5.15: [f0363af9619c77730764f10360e36c6445c12f7b]
stable/6.1: [3420b3ff1ff489c177ea1cb7bd9fbbc4e9a0be95]
stable/6.6: [f562e4c4aab00986dde3093c4be919c3f2b85a4a]

CVE-2024-27432: net: ethernet: mtk_eth_soc: fix PPE hanging issue

Announce: https://lore.kernel.org/linux-cve-announce/2024051755-CVE-2024-27=
432-e3bd@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ba37b7c ("net: ethernet: mtk_eth_soc: add support
for initializing the PPE") in v5.13-rc1.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [ea80e3ed09ab2c2b75724faf5484721753e92c31]
stable/5.15: [9fcadd125044007351905d40c405fadc2d3bb6d6]
stable/6.1: [f78807362828ad01db2a9ed005bf79501b620f27]
stable/6.6: [943c14ece95eb1cf98d477462aebcbfdfd714633]
stable/6.8: [09a1907433865b7c8ee6777e507f5126bdd38c0f]

CVE-2024-27433: clk: mediatek: mt7622-apmixedsys: Fix an error
handling path in clk_mt8135_apmixed_probe()

Announce: https://lore.kernel.org/linux-cve-announce/2024051756-CVE-2024-27=
433-42fb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c50e2ea ("clk: mediatek: mt7622-apmixedsys: Add
.remove() callback for module build") in v6.4-rc1.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [a32e88f2b20259f5fe4f8eed598bbc85dc4879ed]
stable/6.6: [de3340533bd68a7b3d6be1841b8eb3fa6c762fe6]
stable/6.8: [fa761ce7a1d15cca1a306b3635f81a22b15fee5b]

CVE-2024-27434: wifi: iwlwifi: mvm: don't set the MFP flag for the GTK

Announce: https://lore.kernel.org/linux-cve-announce/2024051756-CVE-2024-27=
434-ac61@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5c75a20 ("wifi: iwlwifi: mvm: support new key
API") in v6.2-rc1.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [e35f316bce9e5733c9826120c1838f4c447b2c4c]
stable/6.6: [b4f1b0b3b91762edd19bf9d3b2e4c3a0740501f8]
stable/6.8: [60f6d5fc84a9fd26528a24d8a267fc6a6698b628]

CVE-2024-27435: nvme: fix reconnection fail due to reserved tag allocation

Announce: https://lore.kernel.org/linux-cve-announce/2024051710-CVE-2024-27=
435-c465@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ed01fee ("nvme-fabrics: only reserve a single
tag") in v5.12-rc4.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [de105068fead55ed5c07ade75e9c8e7f86a00d1d]
stable/6.1: [149afee5c7418ec5db9d7387b9c9a5c1eb7ea2a8]
stable/6.6: [ff2f90f88d78559802466ad1c84ac5bda4416b3a]
stable/6.8: [262da920896e2f2ab0e3947d9dbee0aa09045818]

CVE-2024-27436: ALSA: usb-audio: Stop parsing channels bits when all
channels are found.

Announce: https://lore.kernel.org/linux-cve-announce/2024051711-CVE-2024-27=
436-2227@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 04324cc ("ALSA: usb-audio: add channel map
support") in v3.8-rc1.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
cip/4.4: [587c5f0f40557d65068bc7b6233bf0ccdb6d976c]
cip/4.4-rt: [587c5f0f40557d65068bc7b6233bf0ccdb6d976c]
cip/4.4-st: [587c5f0f40557d65068bc7b6233bf0ccdb6d976c]
mainline: [a39d51ff1f52cd0b6fe7d379ac93bd8b4237d1b7]
stable/4.19: [7e2c1b0f6dd9abde9e60f0f9730026714468770f]
stable/5.10: [5cd466673b34bac369334f66cbe14bb77b7d7827]
stable/5.15: [9af1658ba293458ca6a13f70637b9654fa4be064]
stable/5.4: [6d5dc96b154be371df0d62ecb07efe400701ed8a]
stable/6.1: [629af0d5fe94a35f498ba2c3f19bd78bfa591be6]
stable/6.6: [22cad1b841a63635a38273b799b4791f202ade72]
stable/6.8: [6d88b289fb0a8d055cb79d1c46a56aba7809d96d]

CVE-2024-35784: btrfs: fix deadlock with fiemap and extent locking

Announce: https://lore.kernel.org/linux-cve-announce/2024051704-CVE-2024-35=
784-6dec@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc6.

Fixed status
mainline: [b0ad381fa7690244802aed119b478b4bdafc31dd]
stable/6.6: [ded566b4637f1b6b4c9ba74e7d0b8493e93f19cf]

CVE-2024-35785: tee: optee: Fix kernel panic caused by incorrect error hand=
ling

Announce: https://lore.kernel.org/linux-cve-announce/2024051706-CVE-2024-35=
785-b813@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7269cba ("tee: optee: Fix supplicant based device
enumeration") in v6.7-rc5.
Fixed in v6.8.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [95915ba4b987cf2b222b0f251280228a1ff977ac]
stable/5.10: [bc40ded92af55760d12bec8222d4108de725dbe4]
stable/5.15: [4b12ff5edd141926d49c9ace4791adf3a4902fe7]
stable/6.1: [e5b5948c769aa1ebf962dddfb972f87d8f166f95]
stable/6.6: [520f79c110ff712b391b3d87fcacf03c74bc56ee]

CVE-2024-35786: drm/nouveau: fix stale locked mutex in nouveau_gem_ioctl_pu=
shbuf

Announce: https://lore.kernel.org/linux-cve-announce/2024051707-CVE-2024-35=
786-0d93@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b88baab ("drm/nouveau: implement new VM_BIND
uAPI") in v6.6-rc1.
Fixed in v6.8.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [daf8739c3322a762ce84f240f50e0c39181a41ab]
stable/6.6: [c288a61a48ddb77ec097e11ab81b81027cd4e197]

CVE-2024-35787: md/md-bitmap: fix incorrect usage for sb_index

Announce: https://lore.kernel.org/linux-cve-announce/2024051707-CVE-2024-35=
787-dede@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d7038f9 ("md-bitmap: don't use ->index for pages
backing the bitmap file") in v6.6-rc1.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [ecbd8ebb51bf7e4939d83b9e6022a55cac44ef06]
stable/6.6: [736ad6c577a367834118f57417038d45bb5e0a31]
stable/6.8: [5a95815b17428ce2f56ec18da5e0d1b2a1a15240]

CVE-2024-35788: drm/amd/display: Fix bounds check for dcn35 DcfClocks

Announce: https://lore.kernel.org/linux-cve-announce/2024051707-CVE-2024-35=
788-877d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a8edc9c ("drm/amd/display: Fix
array-index-out-of-bounds in dcn35_clkmgr") in 6.9-rc1. Fixed in
6.9-rc2.
Bug introduced commit is not backported to older stable kernels

Fixed status
stable/6.8: [f6e163e9c3d50cd167ab9d411ed01b7718177387]

CVE-2024-35789: wifi: mac80211: check/clear fast rx for non-4addr sta
VLAN changes

Announce: https://lore.kernel.org/linux-cve-announce/2024051707-CVE-2024-35=
789-52e5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc2.
It looks as if this bug was introduced by commit dd0b455 ("mac80211:
clear sta->fast_rx when STA removed from 4-addr VLAN") in 5.12-rc7.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt stable/4.19 stable/5.10
stable/5.15 stable/5.4

Fixed status
mainline: [4f2bdb3c5e3189297e156b3ff84b140423d64685]
stable/4.19: [ea9a0cfc07a7d3601cc680718d9cff0d6927a921]
stable/5.10: [e8b067c4058c0121ac8ca71559df8e2e08ff1a7e]
stable/5.15: [c8bddbd91bc8e42c961a5e2cec20ab879f21100f]
stable/5.4: [be1dd9254fc115321d6fbee042026d42afc8d931]
stable/6.1: [7eeabcea79b67cc29563e6a9a5c81f9e2c664d5b]
stable/6.6: [6b948b54c8bd620725e0c906e44b10c0b13087a7]
stable/6.8: [e8678551c0243f799b4859448781cbec1bd6f1cb]

CVE-2024-35790: usb: typec: altmodes/displayport: create sysfs nodes
as driver's default device attribute group

Announce: https://lore.kernel.org/linux-cve-announce/2024051708-CVE-2024-35=
790-6a80@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0e3bb7d ("usb: typec: Add driver for DisplayPort
alternate mode") in v4.19-rc1.
Fixed in v6.8.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [165376f6b23e9a779850e750fb2eb06622e5a531]
stable/6.6: [4a22aeac24d0d5f26ba741408e8b5a4be6dc5dc0]

CVE-2024-35791: KVM: SVM: Flush pages under kvm->lock to fix UAF in
svm_register_enc_region()

Announce: https://lore.kernel.org/linux-cve-announce/2024051708-CVE-2024-35=
791-65ad@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 19a23da ("Fix unsynchronized access to sev
members through svm_register_enc_region") in v5.11-rc7.
Fixed in v6.8.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt stable/4.19 stable/5.10 stable/5.=
4

Fixed status
mainline: [5ef1d8c1ddbf696e47b226e11888eaf8d9e8e807]
stable/5.10: [2d13b79640b147bd77c34a5998533b2021a4122d]
stable/5.15: [e126b508ed2e616d679d85fca2fbe77bb48bbdd7]
stable/6.1: [4868c0ecdb6cfde7c70cf478c46e06bb9c7e5865]
stable/6.6: [12f8e32a5a389a5d58afc67728c76e61beee1ad4]

CVE-2024-35792: crypto: rk3288 - Fix use after free in unprepare

Announce: https://lore.kernel.org/linux-cve-announce/2024051708-CVE-2024-35=
792-d944@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c66c17a ("crypto: rk3288 - Remove
prepare/unprepare request") in v6.6-rc1.
Fixed in v6.8.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [c0afb6b88fbbc177fa322a835f874be217bffe45]
stable/6.6: [48dd260fdb728eda4a246f635d1325e82f0d3555]

CVE-2024-35793: debugfs: fix wait/cancellation handling during remove

Announce: https://lore.kernel.org/linux-cve-announce/2024051709-CVE-2024-35=
793-6171@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8c88a47 ("debugfs: add API to allow debugfs
operations cancellation") in v6.7-rc4.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [952c3fce297f12c7ff59380adb66b564e2bc9b64]
stable/6.8: [3d08cca5fd0aabb62b7015067ab40913b33da906]

CVE-2024-35794: dm-raid: really frozen sync_thread during suspend

Announce: https://lore.kernel.org/linux-cve-announce/2024051709-CVE-2024-35=
794-f42d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1af2048 ("dm raid: fix deadlock caused by
premature md_stop_writes()") in v4.16-rc1.
Introduced by commit 9dbd1aa ("dm raid: add reshaping support to the
target") in v4.8-rc1.
Introduced by commit f52f5c7 ("md: fix stopping sync thread") in v6.7-rc5.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [16c4770c75b1223998adbeb7286f9a15c65fba73]
stable/6.8: [eaa8fc9b092837cf2c754bde1a15d784ce9a85ab]

CVE-2024-35795: drm/amdgpu: fix deadlock while reading mqd from debugfs

Announce: https://lore.kernel.org/linux-cve-announce/2024051734-CVE-2024-35=
795-ee3e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 445d85e ("drm/amdgpu: add debugfs interface for
reading MQDs") in v6.5-rc1.
Fixed in v6.9-rc2.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [8678b1060ae2b75feb60b87e5b75e17374e3c1c5]
stable/6.6: [197f6d6987c55860f6eea1c93e4f800c59078874]
stable/6.8: [4687e3c6ee877ee25e57b984eca00be53b9a8db5]

CVE-2024-35796: net: ll_temac: platform_get_resource replaced by wrong func=
tion

Announce: https://lore.kernel.org/linux-cve-announce/2024051736-CVE-2024-35=
796-e66c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit bd69058 ("net: ll_temac: Use
devm_platform_ioremap_resource_byname()") in v5.9-rc1.
Fixed in v6.9-rc2.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [3a38a829c8bc27d78552c28e582eb1d885d07d11]
stable/5.10: [6d9395ba7f85bdb7af0b93272e537484ecbeff48]
stable/5.15: [553d294db94b5f139378022df480a9fb6c3ae39e]
stable/6.1: [46efbdbc95a30951c2579caf97b6df2ee2b3bef3]
stable/6.6: [476eed5f1c22034774902a980aa48dc4662cb39a]
stable/6.8: [92c0c29f667870f17c0b764544bdf22ce0e886a1]

CVE-2024-35797: mm: cachestat: fix two shmem bugs

Announce: https://lore.kernel.org/linux-cve-announce/2024051737-CVE-2024-35=
797-06f6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cf264e1 ("cachestat: implement cachestat
syscall") in v6.5-rc1.
Fixed in v6.9-rc2.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [d5d39c707a4cf0bcc84680178677b97aa2cb2627]
stable/6.6: [b79f9e1ff27c994a4c452235ba09e672ec698e23]
stable/6.8: [24a0e73d544439bb9329fbbafac44299e548a677]

CVE-2024-35798: btrfs: fix race in read_extent_buffer_pages()

Announce: https://lore.kernel.org/linux-cve-announce/2024051737-CVE-2024-35=
798-8d90@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d7172f5 ("btrfs: use per-buffer locking for
extent_buffer reading") in v6.5-rc1.
Fixed in v6.9-rc2.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [ef1e68236b9153c27cb7cf29ead0c532870d4215]
stable/6.6: [0427c8ef8bbb7f304de42ef51d69c960e165e052]
stable/6.8: [2885d54af2c2e1d910e20d5c8045bae40e02fbc1]

CVE-2024-35799: drm/amd/display: Prevent crash when disable stream

Announce: https://lore.kernel.org/linux-cve-announce/2024051737-CVE-2024-35=
799-75e5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc2.
Linux 4.4 does not have this driver. It was added by commit 4562236b
("drm/amd/dc: Add dc display driver (v2)") in 4.15-rc1.

Fixed status
mainline: [72d72e8fddbcd6c98e1b02d32cf6f2b04e10bd1c]
stable/6.6: [4356a2c3f296503c8b420ae8adece053960a9f06]
stable/6.8: [2b17133a0a2e0e111803124dad09e803718d4a48]

CVE-2024-35800: efi: fix panic in kdump kernel

Announce: https://lore.kernel.org/linux-cve-announce/2024051738-CVE-2024-35=
800-219a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit bad267f ("efi: verify that variable services are
supported") in v6.3-rc1.
Fixed in v6.9-rc1.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [62b71cd73d41ddac6b1760402bbe8c4932e23531]
stable/6.1: [b9d103aca85f082a343b222493f3cab1219aaaf4]
stable/6.6: [9114ba9987506bcfbb454f6e68558d68cb1abbde]
stable/6.8: [090d2b4515ade379cd592fbc8931344945978210]

CVE-2024-35801: x86/fpu: Keep xfd_state in sync with MSR_IA32_XFD

Announce: https://lore.kernel.org/linux-cve-announce/2024051738-CVE-2024-35=
801-8038@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6723654 ("x86/fpu: Update XFD state where
required") in v5.16-rc1.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [10e4b5166df9ff7a2d5316138ca668b42d004422]
stable/6.1: [21c7c00dae55cb0e3810d5f9506b58f68475d41d]
stable/6.6: [1acbca933313aa866e39996904c9aca4d435c4cd]
stable/6.8: [b61e3b7055ac6edee4be071c52f48c26472d2624]

CVE-2024-35802: x86/sev: Fix position dependent variable references in
startup code

Announce: https://lore.kernel.org/linux-cve-announce/2024051738-CVE-2024-35=
802-959d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.

Fixed status
mainline: [1c811d403afd73f04bde82b83b24c754011bd0e8]
stable/6.1: [fe272b61506bb1534922ef07aa165fd3c37a6a90]
stable/6.6: [0982fd6bf0b822876f2e93ec782c4c28a3f85535]
stable/6.8: [954a4a87814465ad61cc97c1cd3de1525baaaf07]

CVE-2024-35803: x86/efistub: Call mixed mode boot services on the
firmware's stack

Announce: https://lore.kernel.org/linux-cve-announce/2024051739-CVE-2024-35=
803-c81f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.

Fixed status
mainline: [cefcd4fe2e3aaf792c14c9e56dab89e3d7a65d02]
stable/6.1: [2149f8a56e2ed345c7a4d022a79f6b8fc53ae926]
stable/6.6: [930775060ca348b8665f60eef14b204172d14f31]
stable/6.8: [725351c036452b7db5771a7bed783564bc4b99cc]

CVE-2024-35804: KVM: x86: Mark target gfn of emulated atomic
instruction as dirty

Announce: https://lore.kernel.org/linux-cve-announce/2024051739-CVE-2024-35=
804-bd95@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1c2361f ("KVM: x86: Use __try_cmpxchg_user() to
emulate atomic accesses") in v5.19-rc1.
Fixed in v6.8.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [910c57dfa4d113aae6571c2a8b9ae8c430975902]
stable/5.15: [a9bd6bb6f02bf7132c1ab192ba62bbfa52df7d66]
stable/6.1: [726374dde5d608b15b9756bd52b6fc283fda7a06]
stable/6.6: [9d1b22e573a3789ed1f32033ee709106993ba551]

CVE-2024-35805: dm snapshot: fix lockup in dm_exception_table_exit

Announce: https://lore.kernel.org/linux-cve-announce/2024051739-CVE-2024-35=
805-179f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
Linux 4.x may be affected.

Fixed status
mainline: [6e7132ed3c07bd8a6ce3db4bb307ef2852b322dc]
stable/5.10: [9759ff196e7d248bcf8386a7451d6ff8537a7d9c]
stable/5.15: [116562e804ffc9dc600adab6326dde31d72262c7]
stable/5.4: [e7d4cff57c3c43fdd72342c78d4138f509c7416e]
stable/6.1: [3d47eb405781cc5127deca9a14e24b27696087a1]
stable/6.6: [e50f83061ac250f90710757a3e51b70a200835e2]
stable/6.8: [5f4ad4d0b0943296287313db60b3f84df4aad683]

CVE-2024-35806: soc: fsl: qbman: Always disable interrupts when taking cgr_=
lock

Announce: https://lore.kernel.org/linux-cve-announce/2024051739-CVE-2024-35=
806-38c3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 96f413f ("soc/fsl/qbman: fix issue in
qman_delete_cgr_safe()") in v4.16-rc7.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [584c2a9184a33a40fceee838f856de3cffa19be3]
stable/4.19: [b56a793f267679945d1fdb9a280013bd2d0ed7f9]
stable/5.10: [dd199e5b759ffe349622a4b8fbcafc51fc51b1ec]
stable/5.15: [e6378314bb920acb39013051fa65d8f9f8030430]
stable/5.4: [62c3ecd2833cff0eff4a82af4082c44ca8d2518a]
stable/6.1: [a62168653774c36398d65846a98034436ee66d03]
stable/6.6: [0e6521b0f93ff350434ed4ae61a250907e65d397]
stable/6.8: [af25c5180b2b1796342798f6c56fcfd12f5035bd]

CVE-2024-35807: ext4: fix corruption during on-line resize

Announce: https://lore.kernel.org/linux-cve-announce/2024051740-CVE-2024-35=
807-2a9e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 01f795f ("ext4: add online resizing support for
meta_bg and 64-bit file systems") in v3.7-rc1.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
cip/4.4: [a8a53d1a97675121355558a94ce0f827908863a7]
cip/4.4-rt: [a8a53d1a97675121355558a94ce0f827908863a7]
cip/4.4-st: [a8a53d1a97675121355558a94ce0f827908863a7]
mainline: [a6b3bfe176e8a5b05ec4447404e412c2a3fc92cc]
stable/4.19: [75cc31c2e7193b69f5d25650bda5bb42ed92f8a1]
stable/5.10: [e8e8b197317228b5089ed9e7802dadf3ccaa027a]
stable/5.15: [239c669edb2bffa1aa2612519b1d438ab35d6be6]
stable/5.4: [ee4e9c1976147a850f6085a13fca95bcaa00d84c]
stable/6.1: [fb1088d51bbaa0faec5a55d4f5818a9ab79e24df]
stable/6.6: [37b6a3ba793bbbae057f5b991970ebcc52cb3db5]
stable/6.8: [722d2c01b8b108f8283d1b7222209d5b2a5aa7bd]

CVE-2024-35808: md/dm-raid: don't call md_reap_sync_thread() directly

Announce: https://lore.kernel.org/linux-cve-announce/2024051740-CVE-2024-35=
808-2bf6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit be83651 ("DM RAID: Add message/status support for
changing sync action") in v3.10-rc1.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [cd32b27a66db8776d8b8e82ec7d7dde97a8693b0]
stable/6.8: [9e59b8d76ff511505eb0dd1478329f09e0f04669]

CVE-2024-35809: PCI/PM: Drain runtime-idle callbacks before driver removal

Announce: https://lore.kernel.org/linux-cve-announce/2024051740-CVE-2024-35=
809-4a4e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.

Fixed status
cip/4.4: [21a780f8c3f748e7e9efd77ebe3b04149e808edb]
cip/4.4-rt: [21a780f8c3f748e7e9efd77ebe3b04149e808edb]
cip/4.4-st: [21a780f8c3f748e7e9efd77ebe3b04149e808edb]
mainline: [9d5286d4e7f68beab450deddbb6a32edd5ecf4bf]
stable/4.19: [9a87375bb586515c0af63d5dcdcd58ec4acf20a6]
stable/5.10: [bbe068b24409ef740657215605284fc7cdddd491]
stable/5.15: [7cc94dd36e48879e76ae7a8daea4ff322b7d9674]
stable/5.4: [47d8aafcfe313511a98f165a54d0adceb34e54b1]
stable/6.1: [900b81caf00c89417172afe0e7e49ac4eb110f4b]
stable/6.6: [d86ad8c3e152349454b82f37007ff6ba45f26989]
stable/6.8: [6347348c6aba52dda0b33296684cbb627bdc6970]

CVE-2024-35810: drm/vmwgfx: Fix the lifetime of the bo cursor memory

Announce: https://lore.kernel.org/linux-cve-announce/2024051741-CVE-2024-35=
810-1b33@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit bb6780a ("drm/vmwgfx: Diff cursors when using
cmds") in v6.2-rc1.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [9a9e8a7159ca09af9b1a300a6c8e8b6ff7501c76]
stable/6.6: [86cb706a40b7e6b2221ee49a298a65ad9b46c02d]
stable/6.8: [ed381800ea6d9a4c7f199235a471c0c48100f0ae]

CVE-2024-35811: wifi: brcmfmac: Fix use-after-free bug in brcmf_cfg80211_de=
tach

Announce: https://lore.kernel.org/linux-cve-announce/2024051741-CVE-2024-35=
811-9306@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e756af5 ("brcmfmac: add e-scan support.") in v3.7-rc1.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
cip/4.4: [726d91d1c97799544aee356136de385d11f81eab]
cip/4.4-rt: [726d91d1c97799544aee356136de385d11f81eab]
cip/4.4-st: [726d91d1c97799544aee356136de385d11f81eab]
mainline: [0f7352557a35ab7888bc7831411ec8a3cbe20d78]
stable/4.19: [202c503935042272e2f9e1bb549d5f69a8681169]
stable/5.10: [bacb8c3ab86dcd760c15903fcee58169bc3026aa]
stable/5.15: [8c36205123dc57349b59b4f1a2301eb278cbc731]
stable/5.4: [8e3f03f4ef7c36091f46e7349096efb5a2cdb3a1]
stable/6.1: [0b812f706fd7090be74812101114a0e165b36744]
stable/6.6: [190794848e2b9d15de92d502b6ac652806904f5a]
stable/6.8: [0a7591e14a8da794d0b93b5d1c6254ccb23adacb]

CVE-2024-35812: usb: cdc-wdm: close race between read and workqueue

Announce: https://lore.kernel.org/linux-cve-announce/2024051741-CVE-2024-35=
812-c804@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit afba937 ("USB: CDC WDM driver") in v2.6.26-rc4.
Fixed in v6.9-rc2.
Bug introduced commit is not backported to older stable kernels

Fixed status
cip/4.4: [78c0ad059da4a387d415ad390af4e075e9738e43]
cip/4.4-rt: [78c0ad059da4a387d415ad390af4e075e9738e43]
cip/4.4-st: [78c0ad059da4a387d415ad390af4e075e9738e43]
mainline: [339f83612f3a569b194680768b22bf113c26a29d]
stable/4.19: [347cca11bb78b9f3c29b45a9c52e70258bd008bf]
stable/5.10: [ab92e11b73b48b79f144421430891f3aa6242656]
stable/5.15: [7182175f565ffffa2ba1911726c5656bfc7a1bae]
stable/5.4: [164be0a824387301312689bb29b2be92ab2cd39d]
stable/6.1: [8672ad663a22d0e4a325bb7d817b36ec412b967c]
stable/6.6: [2ff436b6399859e06539a2b9c667897d3cc85ad5]
stable/6.8: [e4e47e406d74cab601b2ab21ba5e3add811e05ae]

CVE-2024-35813: mmc: core: Avoid negative index with array access

Announce: https://lore.kernel.org/linux-cve-announce/2024051742-CVE-2024-35=
813-bdc9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4d0c8d0 ("mmc: core: Use mrq.sbc in close-ended
ffu") in v6.8-rc1.
Fixed in v6.9-rc2.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [cf55a7acd1ed38afe43bba1c8a0935b51d1dc014]
stable/5.10: [2b539c88940e22494da80a93ee1c5a28bbad10f6]
stable/5.15: [81b8645feca08a54c7c4bf36e7b176f4983b2f28]
stable/5.4: [b9a7339ae403035ffe7fc37cb034b36947910f68]
stable/6.1: [ad9cc5e9e53ab94aa0c7ac65d43be7eb208dcb55]
stable/6.6: [4466677dcabe2d70de6aa3d4bd4a4fafa94a71f2]
stable/6.8: [7d0e8a6147550aa058fa6ade8583ad252aa61304]

CVE-2024-35814: swiotlb: Fix double-allocation of slots due to broken
alignment handling

Announce: https://lore.kernel.org/linux-cve-announce/2024051742-CVE-2024-35=
814-98c7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit bbb73a1 ("swiotlb: fix a braino in the alignment
check fix") in v6.3-rc6.
Introduced by commit 0eee5ae ("swiotlb: fix slot alignment checks") in v6.3=
-rc5.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [04867a7a33324c9c562ee7949dbcaab7aaad1fb4]
stable/6.6: [3e7acd6e25ba77dde48c3b721c54c89cd6a10534]
stable/6.8: [777391743771040e12cc40d3d0d178f70c616491]

CVE-2024-35815: fs/aio: Check IOCB_AIO_RW before the struct aio_kiocb conve=
rsion

Announce: https://lore.kernel.org/linux-cve-announce/2024051742-CVE-2024-35=
815-c819@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b820de7 ("fs/aio: Restrict kiocb_set_cancel_fn()
to I/O submitted via libaio") in 6.8-rc6. Fixed in 6.8.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt
stable/4.19 stable/5.10 stable/5.15 stable/5.4 stable/6.1 stable/6.6

Fixed status
stable/4.19: [10ca82aff58434e122c7c757cf0497c335f993f3]
stable/5.10: [94eb0293703ced580f05dfbe5a57da5931e9aee2]
stable/5.15: [a71cba07783abc76b547568b6452cd1dd9981410]
stable/5.4: [396dbbc18963648e9d1a4edbb55cfe08fa374d50]
stable/6.1: [18d5fc3c16cc317bd0e5f5dabe0660df415cadb7]
stable/6.6: [c01ed748847fe8b810d86efc229b9e6c7fafa01e]

CVE-2024-35816: firewire: ohci: prevent leak of left-over IRQ on unbind

Announce: https://lore.kernel.org/linux-cve-announce/2024051742-CVE-2024-35=
816-183c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5a95f1d ("firewire: ohci: use devres for
requested IRQ") in v6.5-rc1.
Fixed in v6.8.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [575801663c7dc38f826212b39e3b91a4a8661c33]
stable/6.6: [43c70cbc2502cf2557105c662eeed6a15d082b88]

CVE-2024-35817: drm/amdgpu: amdgpu_ttm_gart_bind set gtt bound flag

Announce: https://lore.kernel.org/linux-cve-announce/2024051743-CVE-2024-35=
817-d29b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.

Fixed status
mainline: [6c6064cbe58b43533e3451ad6a8ba9736c109ac3]
stable/5.15: [5d5f1a7f3b1039925f79c7894f153c2a905201fb]
stable/6.1: [589c414138a1bed98e652c905937d8f790804efe]
stable/6.6: [6fcd12cb90888ef2d8af8d4c04e913252eee4ef3]
stable/6.8: [5cdce3dda3b3dacde902f63a8ee72c2b7f91912d]

CVE-2024-35818: LoongArch: Define the __io_aw() hook as mmiowb()

Announce: https://lore.kernel.org/linux-cve-announce/2024051743-CVE-2024-35=
818-d446@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
The LoongArch was added by commit fa96b57 ("LoongArch: Add build
infrastructure") in 5.19-rc1.

Fixed status
mainline: [9c68ece8b2a5c5ff9b2fcaea923dd73efeb174cd]
stable/6.1: [97cd43ba824aec764f5ea2790d0c0a318f885167]
stable/6.6: [d7d7c6cdea875be3b241d7d39873bb431db7154d]
stable/6.8: [9adec248bba33b1503252caf8e59d81febfc5ceb]

CVE-2024-35819: soc: fsl: qbman: Use raw spinlock for cgr_lock

Announce: https://lore.kernel.org/linux-cve-announce/2024051743-CVE-2024-35=
819-d234@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 96f413f ("soc/fsl/qbman: fix issue in
qman_delete_cgr_safe()") in v4.16-rc7.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [fbec4e7fed89b579f2483041fabf9650fb0dd6bc]
stable/4.19: [2b3fede8225133671ce837c0d284804aa3bc7a02]
stable/5.10: [32edca2f03a6cc42c650ddc3ad83d086e3f365d1]
stable/5.15: [9a3ca8292ce9fdcce122706c28c3f07bc857fe5e]
stable/5.4: [ff50716b7d5b7985979a5b21163cd79fb3d21d59]
stable/6.1: [d6b5aac451c9cc12e43ab7308e0e2ddc52c62c14]
stable/6.6: [54d26adf64c04f186098b39dba86b86037084baa]
stable/6.8: [cd53a8ae5aacb4ecd25088486dea1cd02e74b506]

CVE-2024-35820: io_uring: fix io_queue_proc modifying req->flags

Announce: https://lore.kernel.org/linux-cve-announce/2024051744-CVE-2024-35=
820-6aa4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 595e522 ("io_uring/poll: don't enable lazy wake
for POLLEXCLUSIVE") in v6.7-rc6.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [1a8ec63b2b6c91caec87d4e132b1f71b5df342be]
stable/6.8: [0ecb8919469e6d5c74eea24086b34ce1bda5aef7]

CVE-2024-35821: ubifs: Set page uptodate in the correct place

Announce: https://lore.kernel.org/linux-cve-announce/2024051744-CVE-2024-35=
821-6af5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1e51764 ("UBIFS: add new flash file system") in
v2.6.27-rc1.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
cip/4.4: [6041a8318bdb5bbc1818da5f78e7997b2febd279]
cip/4.4-rt: [6041a8318bdb5bbc1818da5f78e7997b2febd279]
cip/4.4-st: [6041a8318bdb5bbc1818da5f78e7997b2febd279]
mainline: [723012cab779eee8228376754e22c6594229bf8f]
stable/4.19: [4aa554832b9dc9e66249df75b8f447d87853e12e]
stable/5.10: [8f599ab6fabbca4c741107eade70722a98adfd9f]
stable/5.15: [f19b1023a3758f40791ec166038d6411c8894ae3]
stable/5.4: [778c6ad40256f1c03244fc06d7cdf71f6b5e7310]
stable/6.1: [142d87c958d9454c3cffa625fab56f3016e8f9f3]
stable/6.6: [fc99f4e2d2f1ce766c14e98463c2839194ae964f]
stable/6.8: [17772bbe9cfa972ea1ff827319f6e1340de76566]

CVE-2024-35822: usb: udc: remove warning when queue disabled ep

Announce: https://lore.kernel.org/linux-cve-announce/2024051744-CVE-2024-35=
822-410b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8a0859b ("usb: gadget: forbid queuing request to
a disabled ep") in 4.5-rc1. Fixed in v6.9-rc2.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [2a587a035214fa1b5ef598aea0b81848c5b72e5e]
stable/4.19: [2b002c308e184feeaeb72987bca3f1b11e5f70b8]
stable/5.10: [3e944ddc17c042945d983e006df7860687a8849a]
stable/5.15: [df5cbb908f1687e8ab97e222a16b7890d5501acf]
stable/5.4: [68d951880d0c52c7f13dcefb5501b69b8605ce8c]
stable/6.1: [f74c5e0b54b02706d9a862ac6cddade30ac86bcf]
stable/6.6: [99731076722eb7ed26b0c87c879da7bb71d24290]
stable/6.8: [30511676eb54d480d014352bf784f02577a10252]

CVE-2024-35823: vt: fix unicode buffer corruption when deleting characters

Announce: https://lore.kernel.org/linux-cve-announce/2024051745-CVE-2024-35=
823-1e69@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 81732c3 ("tty vt: Fix line garbage in virtual
console on command line edition") in v3.7-rc1.
Fixed in v6.8.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [1581dafaf0d34bc9c428a794a22110d7046d186d]
stable/4.19: [fc7dfe3d123f00e720be80b920da287810a1f37d]
stable/5.10: [1ce408f75ccf1e25b3fddef75cca878b55f2ac90]
stable/5.15: [0190d19d7651c08abc187dac3819c61b726e7e3f]
stable/5.4: [ff7342090c1e8c5a37015c89822a68b275b46f8a]
stable/6.1: [994a1e583c0c206c8ca7d03334a65b79f4d8bc51]
stable/6.6: [7529cbd8b5f6697b369803fe1533612c039cabda]

CVE-2024-35824: misc: lis3lv02d_i2c: Fix regulators getting
en-/dis-abled twice on suspend/resume

Announce: https://lore.kernel.org/linux-cve-announce/2024051737-CVE-2024-35=
824-7302@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b1b9f7a ("misc: lis3lv02d_i2c: Add missing
setting of the reg_ctrl callback") in 6.8-rc1. Fixed in 6.8.
Bug introduced commit is not backported to older stable kernels

Fixed status
stable/6.1: [4154e767354140db7804207117e7238fb337b0e7]
stable/6.6: [997ca415384612c8df76d99d9a768e0b3f42b325]

CVE-2024-35825: usb: gadget: ncm: Fix handling of zero block length packets

Announce: https://lore.kernel.org/linux-cve-announce/2024051737-CVE-2024-35=
825-9e41@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 427694c ("usb: gadget: ncm: Handle decoding of
multiple NTB's in unwrap call") in v6.6-rc6.
Fixed in v6.8.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10
cip/5.10-rt cip/6.1 cip/6.1-rt stable/4.19 stable/5.10 stable/5.15
stable/5.4 stable/6.1

Fixed status
cip/4.4: [804a04c6518077ea6244d142950329e8fec4c100]
cip/4.4-rt: [804a04c6518077ea6244d142950329e8fec4c100]
cip/4.4-st: [804a04c6518077ea6244d142950329e8fec4c100]
mainline: [f90ce1e04cbcc76639d6cba0fdbd820cd80b3c70]
stable/4.19: [e2dbfea520e60d58e0c498ba41bde10452257779]
stable/5.10: [ef846cdbd100f7f9dc045e8bcd7fe4b3a3713c03]
stable/5.15: [92b051b87658df7649ffcdef522593f21a2b296b]
stable/5.4: [a766761d206e7c36d7526e0ae749949d17ca582c]
stable/6.1: [7664ee8bd80309b90d53488b619764f0a057f2b7]
stable/6.6: [a0f77b5d6067285b8eca0ee3bd1e448a6258026f]

CVE-2024-35826: block: Fix page refcounts for unaligned buffers in
__bio_release_pages()

Announce: https://lore.kernel.org/linux-cve-announce/2024051737-CVE-2024-35=
826-c17f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1b151e2 ("block: Remove special-casing of
compound pages") in v6.8-rc1.
Fixed in v6.9-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/4.19
stable/5.10 stable/5.15 stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [38b43539d64b2fa020b3b9a752a986769f87f7a6]
stable/6.1: [242006996d15f5ca62e22f8c7de077d9c4a8f367]
stable/6.6: [7d3765550374f71248c55e6206ea1d6fd4537e65]
stable/6.8: [c9d3d2fbde9b8197bce88abcbe8ee8e713ffe7c2]

CVE-2024-35827: io_uring/net: fix overflow check in io_recvmsg_mshot_prep()

Announce: https://lore.kernel.org/linux-cve-announce/2024051741-CVE-2024-35=
827-822c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9b0fc3c ("io_uring: fix types in
io_recvmsg_multishot_overflow") in v6.0-rc1.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [8ede3db5061bb1fe28e2c9683329aafa89d2b1b4]
stable/6.1: [868ec868616438df487b9e2baa5a99f8662cc47c]
stable/6.6: [59a534690ecc3af72c6ab121aeac1237a4adae66]
stable/6.8: [b6563ad0d599110bd5cf8f56c47d279c3ed796fe]

CVE-2024-35828: wifi: libertas: fix some memleaks in lbs_allocate_cmd_buffe=
r()

Announce: https://lore.kernel.org/linux-cve-announce/2024051741-CVE-2024-35=
828-0024@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 876c9d3 ("[PATCH] Marvell Libertas 8388 802.11b/g
USB driver") in v2.6.22-rc1.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
cip/4.4: [7367f72c7f47c6cf5f14d7f40128643f102ba0c7]
cip/4.4-rt: [7367f72c7f47c6cf5f14d7f40128643f102ba0c7]
cip/4.4-st: [7367f72c7f47c6cf5f14d7f40128643f102ba0c7]
mainline: [5f0e4aede01cb01fa633171f0533affd25328c3a]
stable/4.19: [96481624fb5a6319079fb5059e46dbce43a90186]
stable/5.10: [f0dd27314c7afe34794c2aa19dd6f2d30eb23bc7]
stable/5.15: [e888c4461e109f7b93c3522afcbbaa5a8fdf29d2]
stable/5.4: [bea9573c795acec5614d4ac2dcc7b3b684cea5bf]
stable/6.1: [4d99d267da3415db2124029cb5a6d2d955ca43f9]
stable/6.6: [da10f6b7918abd5b4bc5c9cb66f0fc6763ac48f3]
stable/6.8: [8e243ac649c10922a6b4855170eaefe4c5b3faab]

CVE-2024-35829: drm/lima: fix a memleak in lima_heap_alloc

Announce: https://lore.kernel.org/linux-cve-announce/2024051741-CVE-2024-35=
829-2457@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6aebc51 ("drm/lima: support heap buffer
creation") in v5.7-rc1.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [04ae3eb470e52a3c41babe85ff8cee195e4dcbea]
stable/5.10: [f2e80ac9344aebbff576453d5c0290b332e187ed]
stable/5.15: [746606d37d662c70ae1379fc658ee9c65f06880f]
stable/6.1: [f6d51a91b41704704e395de6839c667b0f810bbf]
stable/6.6: [8e25c0ee5665e8a768b8e21445db1f86e9156eb7]
stable/6.8: [ec6bb037e4a35fcbb5cd7bc78242d034ed893fcd]

CVE-2024-35830: media: tc358743: register v4l2 async device only after
successful setup

Announce: https://lore.kernel.org/linux-cve-announce/2024051742-CVE-2024-35=
830-4ad0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4c5211a ("[media] tc358743: register v4l2
asynchronous subdevice") in v4.3-rc1.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
cip/4.4: [71b63c7acb8a4cb96dc2328144c6e612b9fb2b45]
cip/4.4-rt: [71b63c7acb8a4cb96dc2328144c6e612b9fb2b45]
cip/4.4-st: [71b63c7acb8a4cb96dc2328144c6e612b9fb2b45]
mainline: [87399f1ff92203d65f1febf5919429f4bb613a02]
stable/4.19: [17c2650de14842c25c569cbb2126c421489a3a24]
stable/5.10: [610f20e5cf35ca9c0992693cae0dd8643ce932e7]
stable/5.15: [b8505a1aee8f1edc9d16d72ae09c93de086e2a1a]
stable/5.4: [daf21394f9898fb9f0698c3e50de08132d2164e6]
stable/6.1: [8ba8db9786b55047df5ad3db3e01dd886687a77d]
stable/6.6: [edbb3226c985469a2f8eb69885055c9f5550f468]
stable/6.8: [4f1490a5d7a0472ee5d9f36547bc4ba46be755c7]

CVE-2024-35831: io_uring: Fix release of pinned pages when __io_uaddr_map f=
ails

Announce: https://lore.kernel.org/linux-cve-announce/2024051742-CVE-2024-35=
831-abcc@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 223ef47 ("io_uring: don't allow
IORING_SETUP_NO_MMAP rings on highmem pages") in v6.6-rc5.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [67d1189d1095d471ed7fa426c7e384a7140a5dd7]
stable/6.6: [0b6f39c175ba5f0ef72bdb3b9d2a06ad78621d62]
stable/6.8: [4d376d7ad62b6a8e8dfff56b559d9d275e5b9b3a]

CVE-2024-35832: bcachefs: kvfree bch_fs::snapshots in bch2_fs_snapshots_exi=
t

Announce: https://lore.kernel.org/linux-cve-announce/2024051730-CVE-2024-35=
832-b2f8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
The bcachefs was introduced by commit 1c6fdbd8 ("bcachefs: Initial
commit") in 6.7-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [369acf97d6fd5da620d053d0f1878ffe32eff555]

CVE-2024-35833: dmaengine: fsl-qdma: Fix a memory leak related to the
queue command DMA

Announce: https://lore.kernel.org/linux-cve-announce/2024051731-CVE-2024-35=
833-0b1b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b092529 ("dmaengine: fsl-qdma: Add qDMA
controller driver for Layerscape SoCs") in v5.1-rc1.
Fixed in v6.8-rc3.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [3aa58cb51318e329d203857f7a191678e60bb714]
stable/5.10: [ae6769ba51417c1c86fb645812d5bff455eee802]
stable/5.15: [15eb996d7d13cb72a16389231945ada8f0fef2c3]
stable/5.4: [1c75fe450b5200c78f4a102a0eb8e15d8f1ccda8]
stable/6.1: [25ab4d72eb7cbfa0f3d97a139a9b2bfcaa72dd59]
stable/6.6: [5cd8a51517ce15edbdcea4fc74c4c127ddaa1bd6]

CVE-2023-52665: powerpc/ps3_defconfig: Disable PPC64_BIG_ENDIAN_ELF_ABI_V2

Announce: https://lore.kernel.org/linux-cve-announce/2024051725-CVE-2023-52=
665-1d6f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8c5fa3b ("powerpc/64: Make ELFv2 the default for
big-endian builds") in v6.5-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [482b718a84f08b6fc84879c3e90cc57dba11c115]
stable/6.6: [f70557d48215b14a9284ac3a6ae7e4ee1d039f10]

CVE-2023-52666: ksmbd: fix potential circular locking issue in smb2_set_ea(=
)

Announce: https://lore.kernel.org/linux-cve-announce/2024051727-CVE-2023-52=
666-802b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.

Fixed status
mainline: [6fc0a265e1b932e5e97a038f99e29400a93baad0]
stable/5.15: [5349fd419e4f685d609c85b781f2b70f0fb14848]
stable/6.1: [e61fc656ceeaec65f19a92f0ffbeb562b7941e8d]
stable/6.6: [e9ec6665de8f706b4f4133b87b2bd02a159ec57b]

CVE-2023-52667: net/mlx5e: fix a potential double-free in fs_any_create_gro=
ups

Announce: https://lore.kernel.org/linux-cve-announce/2024051728-CVE-2023-52=
667-649b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0f575c2 ("net/mlx5e: Introduce Flow Steering ANY
API") in v5.13-rc1.
Fixed in v6.8-rc2.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [aef855df7e1bbd5aa4484851561211500b22707e]
stable/5.15: [72a729868592752b5a294d27453da264106983b1]
stable/6.1: [b2fa86b2aceb4bc9ada51cea90f61546d7512cbe]
stable/6.6: [2897c981ee63e1be5e530b1042484626a10b26d8]

CVE-2023-52668: btrfs: zoned: fix lock ordering in btrfs_zone_activate()

Announce: https://lore.kernel.org/linux-cve-announce/2024051728-CVE-2023-52=
668-4da2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a7e1ac7 ("btrfs: zoned: reserve zones for an
active metadata/system block group") in v6.6-rc1.
Fixed in v6.8-rc2.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [b18f3b60b35a8c01c9a2a0f0d6424c6d73971dc3]
stable/6.6: [6f74989f5909cdec9b1274641f0fa306b15bb476]

CVE-2023-52669: crypto: s390/aes - Fix buffer overread in CTR mode

Announce: https://lore.kernel.org/linux-cve-announce/2024051728-CVE-2023-52=
669-5a58@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0200f3e ("crypto: s390 - add System z hardware
support for CTR mode") in v3.0-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [d07f951903fa9922c375b8ab1ce81b18a0034e3b]
stable/5.10: [cd51e26a3b89706beec64f2d8296cfb1c34e0c79]
stable/5.15: [a7f580cdb42ec3d53bbb7c4e4335a98423703285]
stable/6.1: [dbc9a791a70ea47be9f2acf251700fe254a2ab23]
stable/6.6: [d68ac38895e84446848b7647ab9458d54cacba3e]

CVE-2023-52670: rpmsg: virtio: Free driver_override when rpmsg_remove()

Announce: https://lore.kernel.org/linux-cve-announce/2024051729-CVE-2023-52=
670-a191@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b0b03b8 ("rpmsg: Release rpmsg devices in
backends") in v4.13-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [d5362c37e1f8a40096452fc201c30e705750e687]
stable/4.19: [229ce47cbfdc7d3a9415eb676abbfb77d676cb08]
stable/5.10: [69ca89d80f2c8a1f5af429b955637beea7eead30]
stable/5.15: [2d27a7b19cb354c6d04bcdc9239e261ff29858d6]
stable/5.4: [dd50fe18c234bd5ff22f658f4d414e8fa8cd6a5d]
stable/6.1: [f4bb1d5daf77b1a95a43277268adf0d1430c2346]
stable/6.6: [4e6cef3fae5c164968118a13f3fe293700adc81a]

CVE-2023-52671: drm/amd/display: Fix hang/underflow when transitioning to O=
DM4:1

Announce: https://lore.kernel.org/linux-cve-announce/2024051729-CVE-2023-52=
671-a2df@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
The optc32_disable_crtc() was added by commit 235c676
("drm/amd/display: add DCN32/321 specific files for Display Core") in
6.0-rc1 and the optc35_disable_crtc() was added by commit b9c96af6
("drm/amd/display: Add DCN35 OPT") in 6.7-rc1.
These commits are not backported to older stable kernels

Fixed status
mainline: [e7b2b108cdeab76a7e7324459e50b0c1214c0386]
stable/6.6: [ae62f1dde66a6f0eee98defc4c7a346bd5acd239]

CVE-2023-52672: pipe: wakeup wr_wait after setting max_usage

Announce: https://lore.kernel.org/linux-cve-announce/2024051729-CVE-2023-52=
672-f30c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c73be61 ("pipe: Add general notification queue
support") in v5.8-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [e95aada4cb93d42e25c30a0ef9eb2923d9711d4a]
stable/5.10: [162ae0e78bdabf84ef10c1293c4ed7865cb7d3c8]
stable/5.15: [3efbd114b91525bb095b8ae046382197d92126b9]
stable/6.1: [b87a1229d8668fbc78ebd9ca0fc797a76001c60f]
stable/6.6: [68e51bdb1194f11d3452525b99c98aff6f837b24]

CVE-2023-52673: drm/amd/display: Fix a debugfs null pointer error

Announce: https://lore.kernel.org/linux-cve-announce/2024051729-CVE-2023-52=
673-57e2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

It seems to be this bug was introduced by commit 670da29
("drm/amd/display: add interface to query SubVP status") in 6.7-rc1.
Fixed in 6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [efb91fea652a42fcc037d2a9ef4ecd1ffc5ff4b7]

CVE-2023-52674: ALSA: scarlett2: Add clamp() in scarlett2_mixer_ctl_put()

Announce: https://lore.kernel.org/linux-cve-announce/2024051747-CVE-2023-52=
674-2aec@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9e4d5c1 ("ALSA: usb-audio: Scarlett Gen 2 mixer
interface") in v5.4-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [04f8f053252b86c7583895c962d66747ecdc61b7]
stable/5.15: [e517645ead5ea22c69d2a44694baa23fe1ce7c2b]
stable/6.1: [d8d8897d65061cbe36bf2909057338303a904810]
stable/6.6: [03035872e17897ba89866940bbc9cefca601e572]

CVE-2023-52675: powerpc/imc-pmu: Add a null pointer check in
update_events_in_group()

Announce: https://lore.kernel.org/linux-cve-announce/2024051749-CVE-2023-52=
675-4d66@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 885dcd7 ("powerpc/perf: Add nest IMC PMU
support") in v4.14-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [0a233867a39078ebb0f575e2948593bbff5826b3]
stable/4.19: [75fc599bcdcb1de093c9ced2e3cccc832f3787f3]
stable/5.10: [5a669f3511d273c8c1ab1c1d268fbcdf53fc7a05]
stable/5.15: [f105c263009839d80fad6998324a4e1b3511cba0]
stable/5.4: [1e80aa25d186a7aa212df5acd8c75f55ac8dae34]
stable/6.1: [a2da3f9b1a1019c887ee1d164475a8fcdb0a3fec]
stable/6.6: [024352f7928b28f53609660663329d8c0f4ad032]

CVE-2023-52676: bpf: Guard stack limits against 32bit overflow

Announce: https://lore.kernel.org/linux-cve-announce/2024051749-CVE-2023-52=
676-e224@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

It seems to be this bug was introduced by commit 01f810a ("bpf: Allow
variable-offset stack access") in 5.12-rc1-dontuse.
Fixed in v6.8-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [1d38a9ee81570c4bd61f557832dead4d6f816760]
stable/6.6: [ad140fc856f0b1d5e2215bcb6d0cc247a86805a2]

CVE-2023-52677: riscv: Check if the code to patch lies in the exit section

Announce: https://lore.kernel.org/linux-cve-announce/2024051749-CVE-2023-52=
677-5d0c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 043cb41 ("riscv: introduce interfaces to patch
kernel code") in v5.7-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [420370f3ae3d3b883813fd3051a38805160b2b9f]
stable/5.15: [938f70d14618ec72e10d6fcf8a546134136d7c13]
stable/6.1: [890cfe5337e0aaf03ece1429db04d23c88da72e7]
stable/6.6: [8db56df4a954b774bdc68917046a685a9fa2e4bc]

CVE-2023-52678: drm/amdkfd: Confirm list is non-empty before utilizing
list_first_entry in kfd_topology.c

Announce: https://lore.kernel.org/linux-cve-announce/2024051750-CVE-2023-52=
678-32b5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0f28cca ("drm/amdkfd: Extend KFD device topology
to surface peer-to-peer links") in v6.0-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [499839eca34ad62d43025ec0b46b80e77065f6d8]
stable/6.1: [4525525cb7161d08f95d0e47025323dd10214313]
stable/6.6: [5024cce888e11e5688f77df81db9e14828495d64]

CVE-2023-52679: of: Fix double free in of_parse_phandle_with_args_map

Announce: https://lore.kernel.org/linux-cve-announce/2024051750-CVE-2023-52=
679-948f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit bd6f2fd ("of: Support parsing phandle argument
lists through a nexus node") in v4.17-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [4dde83569832f9377362e50f7748463340c5db6b]
stable/4.19: [26b4d702c44f9e5cf3c5c001ae619a4a001889db]
stable/5.10: [d5f490343c77e6708b6c4aa7dbbfbcbb9546adea]
stable/5.15: [4541004084527ce9e95a818ebbc4e6b293ffca21]
stable/5.4: [a0a061151a6200c13149dbcdb6c065203c8425d2]
stable/6.1: [b9d760dae5b10e73369b769073525acd7b3be2bd]
stable/6.6: [b64d09a4e8596f76d27f4b4a90a1cf6baf6a82f8]

CVE-2023-52680: ALSA: scarlett2: Add missing error checks to *_ctl_get()

Announce: https://lore.kernel.org/linux-cve-announce/2024051750-CVE-2023-52=
680-1f4a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9e4d5c1 ("ALSA: usb-audio: Scarlett Gen 2 mixer
interface") in v5.4-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [50603a67daef161c78c814580d57f7f0be57167e]
stable/5.15: [3a09488f4f67f7ade59b8ac62a6c7fb29439cf51]
stable/6.1: [cda7762bea857e6951315a2f7d0632ea1850ed43]
stable/6.6: [821fbaeaaae23d483d3df799fe91ec8045973ec3]

CVE-2023-52681: efivarfs: Free s_fs_info on unmount

Announce: https://lore.kernel.org/linux-cve-announce/2024051751-CVE-2023-52=
681-9f54@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5329aa5 ("efivarfs: Add uid/gid mount options")
in v6.7-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [547713d502f7b4b8efccd409cff84d731a23853b]
stable/6.1: [ea6b597fcaca99562fa56a473bcbbbd79b40af03]
stable/6.6: [48be1364dd387e375e1274b76af986cb8747be2c]

CVE-2023-52682: f2fs: fix to wait on block writeback for post_read case

Announce: https://lore.kernel.org/linux-cve-announce/2024051751-CVE-2023-52=
682-fae2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4c8ff70 ("f2fs: support data compression") in v5.6-rc1=
.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [55fdc1c24a1d6229fe0ecf31335fb9a2eceaaa00]
stable/6.1: [9bfd5ea71521d0e522ba581c6ccc5db93759c0c3]
stable/6.6: [4535be48780431753505e74e1b1ad4836a189bc2]

CVE-2023-52683: ACPI: LPIT: Avoid u32 multiplication overflow

Announce: https://lore.kernel.org/linux-cve-announce/2024051751-CVE-2023-52=
683-f280@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit eeb2d80 ("ACPI / LPIT: Add Low Power Idle Table
(LPIT) support") in v4.15-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [56d2eeda87995245300836ee4dbd13b002311782]
stable/4.19: [647d1d50c31e60ef9ccb9756a8fdf863329f7aee]
stable/5.10: [f39c3d578c7d09a18ceaf56750fc7f20b02ada63]
stable/5.15: [c1814a4ffd016ce5392c6767d22ef3aa2f0d4bd1]
stable/5.4: [6c38e791bde07d6ca2a0a619ff9b6837e0d5f9ad]
stable/6.1: [72222dfd76a79d9666ab3117fcdd44ca8cd0c4de]
stable/6.6: [d1ac288b2742aa4af746c5613bac71760fadd1c4]

CVE-2023-52684: firmware: qcom: qseecom: fix memory leaks in error paths

Announce: https://lore.kernel.org/linux-cve-announce/2024051752-CVE-2023-52=
684-8d25@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 759e7a2 ("firmware: Add support for Qualcomm UEFI
Secure Application") in v6.7-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [6c57d7b593c4a4e60db65d5ce0fe1d9f79ccbe9b]

CVE-2023-52685: pstore: ram_core: fix possible overflow in
persistent_ram_init_ecc()

Announce: https://lore.kernel.org/linux-cve-announce/2024051752-CVE-2023-52=
685-64c5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9cc05ad ("staging: android: persistent_ram:
refactor ecc support") in v3.4-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
cip/4.4: [15cbc45e86a1eafba11b29122869f1af4cb306bd]
cip/4.4-rt: [15cbc45e86a1eafba11b29122869f1af4cb306bd]
cip/4.4-st: [15cbc45e86a1eafba11b29122869f1af4cb306bd]
mainline: [86222a8fc16ec517de8da2604d904c9df3a08e5d]
stable/4.19: [3b333cded94fbe5ce30d699b316c4715151268ae]
stable/5.10: [acd413da3e1f37582207cd6078a41d57c9011918]
stable/5.15: [8fb12524c86bdd542a54857d5d076b1b6778c78c]
stable/5.4: [d1fe1aede684bd014714dacfdc75586a9ad38657]
stable/6.1: [48dcfc42ce705b652c0619cb99846afc43029de9]
stable/6.6: [a34946ec3de88a16cc3a87fdab50aad06255a22b]

CVE-2023-52686: powerpc/powernv: Add a null pointer check in opal_event_ini=
t()

Announce: https://lore.kernel.org/linux-cve-announce/2024051752-CVE-2023-52=
686-4a08@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2717a33 ("powerpc/opal-irqchip: Use interrupt
names if present") in v4.11-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [8649829a1dd25199bbf557b2621cedb4bf9b3050]
stable/4.19: [8422d179cf46889c15ceff9ede48c5bfa4e7f0b4]
stable/5.10: [e6ad05e3ae9c84c5a71d7bb2d44dc845ae7990cf]
stable/5.15: [c0b111ea786ddcc8be0682612830796ece9436c7]
stable/5.4: [e93d7cf4c1ddbcd846739e7ad849f955a4f18031]
stable/6.1: [9a523e1da6d88c2034f946adfa4f74b236c95ca9]
stable/6.6: [a14c55eb461d630b836f80591d8caf1f74e62877]

CVE-2023-52687: crypto: safexcel - Add error handling for dma_map_sg() call=
s

Announce: https://lore.kernel.org/linux-cve-announce/2024051752-CVE-2023-52=
687-b540@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 49186a7 ("crypto: inside_secure - Avoid dma map
if size is zero") in v6.1-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [87e02063d07708cac5bfe9fd3a6a242898758ac8]
stable/6.1: [4c0ac81a172a69a7733290915276672787e904ec]
stable/6.6: [8084b788c2fb1260f7d44c032d5124680b20d2b2]

CVE-2023-52688: wifi: ath12k: fix the error handler of rfkill config

Announce: https://lore.kernel.org/linux-cve-announce/2024051753-CVE-2023-52=
688-4932@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 004ccbc ("wifi: ath12k: add support for hardware
rfkill for WCN7850") in v6.7-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [898d8b3e1414cd900492ee6a0b582f8095ba4a1a]

CVE-2023-52689: ALSA: scarlett2: Add missing mutex lock around get meter le=
vels

Announce: https://lore.kernel.org/linux-cve-announce/2024051753-CVE-2023-52=
689-f657@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3473185 ("ALSA: scarlett2: Remap Level Meter
values") in v6.7-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [993f7b42fa066b055e3a19b7f76ad8157c0927a0]

CVE-2023-52690: powerpc/powernv: Add a null pointer check to
scom_debug_init_one()

Announce: https://lore.kernel.org/linux-cve-announce/2024051753-CVE-2023-52=
690-f225@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit bfd2f0d ("powerpc/powernv: Get rid of old
scom_controller abstraction") in v5.4-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [9a260f2dd827bbc82cc60eb4f4d8c22707d80742]
stable/5.10: [1eefa93faf69188540b08b024794fa90b1d82e8b]
stable/5.15: [2a82c4439b903639e0a1f21990cd399fb0a49c19]
stable/5.4: [f84c1446daa552e9699da8d1f8375eac0f65edc7]
stable/6.1: [ed8d023cfa97b559db58c0e1afdd2eec7a83d8f2]
stable/6.6: [dd8422ff271c22058560832fc3006324ded895a9]

CVE-2023-52691: drm/amd/pm: fix a double-free in si_dpm_init

Announce: https://lore.kernel.org/linux-cve-announce/2024051754-CVE-2023-52=
691-bad0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 841686d ("drm/amdgpu: add SI DPM support (v4)")
in v4.9-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [ac16667237a82e2597e329eb9bc520d1cf9dff30]
stable/4.19: [afe9f5b871f86d58ecdc45b217b662227d7890d0]
stable/5.10: [aeed2b4e4a70c7568d4a5eecd6a109713c0dfbf4]
stable/5.15: [2bf47c89bbaca2bae16581ef1b28aaec0ade0334]
stable/5.4: [06d95c99d5a4f5accdb79464076efe62e668c706]
stable/6.1: [f957a1be647f7fc65926cbf572992ec2747a93f2]
stable/6.6: [fb1936cb587262cd539e84b34541abb06e42b2f9]

CVE-2023-52692: ALSA: scarlett2: Add missing error check to
scarlett2_usb_set_config()

Announce: https://lore.kernel.org/linux-cve-announce/2024051754-CVE-2023-52=
692-4d94@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9e15fae ("ALSA: usb-audio: scarlett2: Allow
bit-level access to config") in v5.14-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [ca459dfa7d4ed9098fcf13e410963be6ae9b6bf3]
stable/5.15: [51d5697e1c0380d482c3eab002bfc8d0be177e99]
stable/6.1: [be96acd3eaa790d10a5b33e65267f52d02f6ad88]
stable/6.6: [996fde492ad9b9563ee483b363af40d7696a8467]

CVE-2023-52693: ACPI: video: check for error while searching for
backlight device parent

Announce: https://lore.kernel.org/linux-cve-announce/2024051754-CVE-2023-52=
693-04db@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9661e92 ("acpi: tie ACPI backlight devices to PCI
devices if possible") in v2.6.39-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
cip/4.4: [7336cb4192cd52d0b2be40c0396a3e107234fdc7]
cip/4.4-rt: [7336cb4192cd52d0b2be40c0396a3e107234fdc7]
cip/4.4-st: [7336cb4192cd52d0b2be40c0396a3e107234fdc7]
mainline: [ccd45faf4973746c4f30ea41eec864e5cf191099]
stable/4.19: [556f02699d33c1f40b1b31bd25828ce08fa165d8]
stable/5.10: [c4e1a0ef0b4782854c9b77a333ca912b392bed2f]
stable/5.15: [3a370502a5681986f9828e43be75ce26c6ab24af]
stable/5.4: [1e3a2b9b4039bb4d136dca59fb31e06465e056f3]
stable/6.1: [2124c5bc22948fc4d09a23db4a8acdccc7d21e95]
stable/6.6: [39af144b6d01d9b40f52e5d773e653957e6c379c]

CVE-2023-52694: drm/bridge: tpd12s015: Drop buggy __exit annotation
for remove function

Announce: https://lore.kernel.org/linux-cve-announce/2024051755-CVE-2023-52=
694-dad8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cff5e6f ("drm/bridge: Add driver for the TI
TPD12S015 HDMI level shifter") in v5.7-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [ce3e112e7ae854249d8755906acc5f27e1542114]
stable/5.10: [53926e2a39629702f7f809d614b3ca89c2478205]
stable/5.15: [08ccff6ece35f08e8107e975903c370d849089e5]
stable/6.1: [81f1bd85960b7a089a91e679ff7cd2524390bbf1]
stable/6.6: [a8657406e12aa10412134622c58977ac657f16d2]

CVE-2023-52695: drm/amd/display: Check writeback connectors in
create_validate_stream_for_sink

Announce: https://lore.kernel.org/linux-cve-announce/2024051755-CVE-2023-52=
695-3d29@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 60e034f ("drm/amd/display: Revert
"drm/amd/display: Use drm_connector in
create_validate_stream_for_sink"") in v6.7-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [dbf5d3d02987faa0eec3710dd687cd912362d7b5]

CVE-2023-52696: powerpc/powernv: Add a null pointer check in
opal_powercap_init()

Announce: https://lore.kernel.org/linux-cve-announce/2024051755-CVE-2023-52=
696-d4ab@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b9ef7b4 ("powerpc: Convert to using %pOFn instead
of device_node.name") in v4.20-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [e123015c0ba859cf48aa7f89c5016cc6e98e018d]
stable/5.10: [a67a04ad05acb56640798625e73fa54d6d41cce1]
stable/5.15: [6b58d16037217d0c64a2a09b655f370403ec7219]
stable/5.4: [9da4a56dd3772570512ca58aa8832b052ae910dc]
stable/6.1: [f152a6bfd187f67afeffc9fd68cbe46f51439be0]
stable/6.6: [69f95c5e9220f77ce7c540686b056c2b49e9a664]

CVE-2023-52697: ASoC: Intel: sof_sdw_rt_sdca_jack_common:
ctx->headset_codec_dev =3D NULL

Announce: https://lore.kernel.org/linux-cve-announce/2024051755-CVE-2023-52=
697-1b7f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5360c67 ("ASoC: Intel: sof_sdw: add rt712
support") in v6.5-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [e38e252dbceeef7d2f848017132efd68e9ae1416]
stable/6.6: [a410d58117d6da4b7d41f3c91365f191d006bc3d]

CVE-2023-52698: calipso: fix memory leak in netlbl_calipso_add_pass()

Announce: https://lore.kernel.org/linux-cve-announce/2024051756-CVE-2023-52=
698-bbc2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cb72d38 ("netlabel: Initial support for the
CALIPSO netlink protocol.") in v4.8-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [ec4e9d630a64df500641892f4e259e8149594a99]
stable/4.19: [9a8f811a146aa2a0230f8edb2e9f4b6609aab8da]
stable/5.10: [44a88650ba55e6a7f2ec485d2c2413ba7e216f01]
stable/5.15: [a4529a08d3704c17ea9c7277d180e46b99250ded]
stable/5.4: [36e19f84634aaa94f543fedc0a07588949638d53]
stable/6.1: [321b3a5592c8a9d6b654c7c64833ea67dbb33149]
stable/6.6: [408bbd1e1746fe33e51f4c81c2febd7d3841d031]

CVE-2024-35834: xsk: recycle buffer in case Rx queue was full

Announce: https://lore.kernel.org/linux-cve-announce/2024051730-CVE-2024-35=
834-2378@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 24ea501 ("xsk: support mbuf on ZC RX") in v6.6-rc1.
Fixed in v6.8-rc2.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [269009893146c495f41e9572dd9319e787c2eba9]
stable/6.6: [cce713664548284daf977739e7ff1cd59e84189c]

CVE-2024-35835: net/mlx5e: fix a double-free in arfs_create_groups

Announce: https://lore.kernel.org/linux-cve-announce/2024051730-CVE-2024-35=
835-d75f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1cabe6b ("net/mlx5e: Create aRFS flow tables") in v4.7=
-rc1.
Fixed in v6.8-rc2.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [3c6d5189246f590e4e1f167991558bdb72a4738b]
stable/4.19: [e3d3ed8c152971dbe64c92c9ecb98fdb52abb629]
stable/5.10: [cf116d9c3c2aebd653c2dfab5b10c278e9ec3ee5]
stable/5.15: [c57ca114eb00e03274dd38108d07a3750fa3c056]
stable/5.4: [2501afe6c4c9829d03abe9a368b83d9ea1b611b7]
stable/6.1: [42876db001bbea7558e8676d1019f08f9390addb]
stable/6.6: [b21db3f1ab7967a81d6bbd328d28fe5a4c07a8a7]

CVE-2024-35836: dpll: fix pin dump crash for rebound module

Announce: https://lore.kernel.org/linux-cve-announce/2024051730-CVE-2024-35=
836-9638@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9431063 ("dpll: core: Add DPLL framework base
functions") in v6.7-rc1.
Introduced by commit 9d71b54 ("dpll: netlink: Add DPLL framework base
functions") in v6.7-rc1.
Fixed in v6.8-rc2.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [830ead5fb0c5855ce4d70ba2ed4a673b5f1e7d9b]

CVE-2024-35837: net: mvpp2: clear BM pool before initialization

Announce: https://lore.kernel.org/linux-cve-announce/2024051731-CVE-2024-35=
837-3159@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3f51850 ("ethernet: Add new driver for Marvell
Armada 375 network unit") in v3.17-rc1.
Fixed in v6.8-rc2.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [9f538b415db862e74b8c5d3abbccfc1b2b6caa38]
stable/5.10: [83f99138bf3b396f761600ab488054396fb5768f]
stable/5.15: [af47faa6d3328406038b731794e7cf508c71affa]
stable/6.1: [cec65f09c47d8c2d67f2bcad6cf05c490628d1ec]
stable/6.6: [938729484cfa535e9987ed0f86f29a2ae3a8188b]

CVE-2024-35838: wifi: mac80211: fix potential sta-link leak

Announce: https://lore.kernel.org/linux-cve-announce/2024051731-CVE-2024-35=
838-d072@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cb71f1d ("wifi: mac80211: add sta link
addition/removal") in v6.0-rc1.
Fixed in v6.8-rc2.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [b01a74b3ca6fd51b62c67733ba7c3280fa6c5d26]
stable/6.1: [49aaeb8c539b1633b3bd7c2df131ec578aa1eae1]
stable/6.6: [587c5892976108674bbe61a8ff659de279318034]

CVE-2024-35839: netfilter: bridge: replace physindev with physinif in
nf_bridge_info

Announce: https://lore.kernel.org/linux-cve-announce/2024051756-CVE-2024-35=
839-4194@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c4e70a8 ("netfilter: bridge: rename
br_netfilter.c to br_netfilter_hooks.c") in v4.2-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [9874808878d9eed407e3977fd11fee49de1e1d86]
stable/6.1: [7ae19ee81ca56b13c50a78de6c47d5b8fdc9d97b]
stable/6.6: [9325e3188a9cf3f69fc6f32af59844bbc5b90547]

CVE-2024-35840: mptcp: use OPTION_MPTCP_MPJ_SYNACK in subflow_finish_connec=
t()

Announce: https://lore.kernel.org/linux-cve-announce/2024051756-CVE-2024-35=
840-99fa@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f296234 ("mptcp: Add handling of incoming MP_JOIN
requests") in v5.7-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [be1d9d9d38da922bd4beeec5b6dd821ff5a1dfeb]
stable/5.15: [413b913507326972135d2977975dbff8b7f2c453]
stable/6.1: [51e4cb032d49ce094605f27e45eabebc0408893c]
stable/6.6: [ad3e8f5c3d5c53841046ef7a947c04ad45a20721]

CVE-2024-35841: net: tls, fix WARNIING in __sk_msg_free

Announce: https://lore.kernel.org/linux-cve-announce/2024051757-CVE-2024-35=
841-1f2e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit fe1e81d ("tls/sw: Support MSG_SPLICE_PAGES") in v6.5-r=
c1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [dc9dfc8dc629e42f2234e3327b75324ffc752bc9]
stable/6.6: [02e368eb1444a4af649b73cbe2edd51780511d86]

CVE-2024-35842: ASoC: mediatek: sof-common: Add NULL check for
normal_link string

Announce: https://lore.kernel.org/linux-cve-announce/2024051757-CVE-2024-35=
842-2d97@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0caf112 ("ASoC: mediatek: mt8195: extract SOF
common code") in v6.0-rc1.
Fixed in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [e3b3ec967a7d93b9010a5af9a2394c8b5c8f31ed]
stable/6.1: [cad471227a37c0c7c080bfc9ed01b53750e82afe]
stable/6.6: [b1d3db6740d0997ffc6e5a0d96ef7cbd62b35fdd]

CVE-2024-35843: iommu/vt-d: Use device rbtree in iopf reporting path

Announce: https://lore.kernel.org/linux-cve-announce/2024051717-CVE-2024-35=
843-516e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [def054b01a867822254e1dda13d587f5c7a99e2a]
stable/6.8: [3d39238991e745c5df85785604f037f35d9d1b15]

CVE-2024-35844: f2fs: compress: fix reserve_cblocks counting error
when out of space

Announce: https://lore.kernel.org/linux-cve-announce/2024051718-CVE-2024-35=
844-7ddb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c75488f ("f2fs: introduce
F2FS_IOC_RESERVE_COMPRESS_BLOCKS") in v5.8-rc1.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [2f6d721e14b69d6e1251f69fa238b48e8374e25f]
stable/5.15: [fa3ac8b1a227d9b470b87972494293348b5839ee]
stable/6.1: [889846dfc8ee2cf31148a44bfd2faeb2faadc685]
stable/6.6: [f0bf89e84c3afb79d7a3a9e4bc853ad6a3245c0a]
stable/6.8: [fc0aed88afbf6f606205129a7466eebdf528e3f3]

CVE-2024-35845: wifi: iwlwifi: dbg-tlv: ensure NUL termination

Announce: https://lore.kernel.org/linux-cve-announce/2024051718-CVE-2024-35=
845-65bd@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a9248de ("iwlwifi: dbg_ini: add TLV allocation
new API support") in v5.5-rc1.
Fixed in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [ea1d166fae14e05d49ffb0ea9fcd4658f8d3dcea]
stable/5.10: [fabe2db7de32a881e437ee69db32e0de785a6209]
stable/5.15: [96aa40761673da045a7774f874487cdb50c6a2f7]
stable/6.1: [c855a1a5b7e3de57e6b1b29563113d5e3bfdb89a]
stable/6.6: [783d413f332a3ebec916664b366c28f58147f82c]
stable/6.8: [71d4186d470e9cda7cd1a0921b4afda737c6f641]

CVE-2024-35846: mm: zswap: fix shrinker NULL crash with cgroup_disable=3Dme=
mory

Announce: https://lore.kernel.org/linux-cve-announce/2024051738-CVE-2024-35=
846-d8bf@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b5ba474 ("zswap: shrink zswap pool based on
memory pressure") in v6.8-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [682886ec69d22363819a83ddddd5d66cb5c791e1]
stable/6.8: [b0fdabc908a7f81d12382c87ca9e46a9c2e14042]

CVE-2024-35847: irqchip/gic-v3-its: Prevent double free on error

Announce: https://lore.kernel.org/linux-cve-announce/2024051738-CVE-2024-35=
847-7e4b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7d75bbb ("irqchip/gic-v3-its: Add VPE irq domain
allocation/teardown") in v4.14-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [c26591afd33adce296c022e3480dea4282b7ef91]
stable/4.19: [f5417ff561b8ac9a7e53c747b8627a7ab58378ae]
stable/5.10: [aa44d21574751a7d6bca892eb8e0e9ac68372e52]
stable/5.15: [5dbdbe1133911ca7d8466bb86885adec32ad9438]
stable/5.4: [b72d2b1448b682844f995e660b77f2a1fabc1662]
stable/6.1: [dd681710ab77c8beafe2e263064cb1bd0e2d6ca9]
stable/6.6: [03170e657f62c26834172742492a8cb8077ef792]
stable/6.8: [5b012f77abde89bf0be8a0547636184fea618137]

CVE-2024-35848: eeprom: at24: fix memory corruption race condition

Announce: https://lore.kernel.org/linux-cve-announce/2024051738-CVE-2024-35=
848-fc2b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b20eb4c ("eeprom: at24: drop unnecessary label")
in v5.3-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [f42c97027fb75776e2e9358d16bf4a99aeb04cf2]
stable/5.10: [c850f71fca09ea41800ed55905980063d17e01da]
stable/5.15: [26d32bec4c6d255a03762f33c637bfa3718be15a]
stable/6.1: [c43e5028f5a35331eb25017f5ff6cc21735005c6]
stable/6.6: [2af84c46b9b8f2d6c0f88d09ee5c849ae1734676]
stable/6.8: [6d8b56ec0c8f30d5657382f47344a32569f7a9bc]

CVE-2024-35849: btrfs: fix information leak in btrfs_ioctl_logical_to_ino()

Announce: https://lore.kernel.org/linux-cve-announce/2024051739-CVE-2024-35=
849-d74e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc6.

Fixed status
cip/4.4: [09be185f0bbcbf166d32573df6024470f5443dc3]
cip/4.4-rt: [09be185f0bbcbf166d32573df6024470f5443dc3]
cip/4.4-st: [09be185f0bbcbf166d32573df6024470f5443dc3]
mainline: [2f7ef5bb4a2f3e481ef05fab946edb97c84f67cf]
stable/4.19: [689efe22e9b5b7d9d523119a9a5c3c17107a0772]
stable/5.10: [30189e54ba80e3209d34cfeea87b848f6ae025e6]
stable/5.15: [e58047553a4e859dafc8d1d901e1de77c9dd922d]
stable/5.4: [73db209dcd4ae026021234d40cfcb2fb5b564b86]
stable/6.1: [8bdbcfaf3eac42f98e5486b3d7e130fa287811f6]
stable/6.6: [3a63cee1a5e14a3e52c19142c61dd5fcb524f6dc]
stable/6.8: [fddc19631c51d9c17d43e9f822a7bc403af88d54]

CVE-2024-35850: Bluetooth: qca: fix NULL-deref on non-serdev setup

Announce: https://lore.kernel.org/linux-cve-announce/2024051739-CVE-2024-35=
850-2b62@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e9b3e5b ("Bluetooth: hci_qca: only assign wakeup
with serial port support") in v6.2-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [7ddb9de6af0f1c71147785b12fd7c8ec3f06cc86]
stable/6.6: [67459f1a707aae6d590454de07956c2752e21ea4]
stable/6.8: [bec4d4c6fa5c6526409f582e4f31144e20c86c21]

CVE-2024-35851: Bluetooth: qca: fix NULL-deref on non-serdev suspend

Announce: https://lore.kernel.org/linux-cve-announce/2024051739-CVE-2024-35=
851-31be@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c1a7416 ("Bluetooth: hci_qca: Add
device_may_wakeup support") in v5.13-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [73e87c0a49fda31d7b589edccf4c72e924411371]
stable/5.15: [52f9041deaca3fc5c40ef3b9cb943993ec7d2489]
stable/6.1: [e60502b907be350c518819297b565007a94c706d]
stable/6.6: [6b47cdeb786c38e4174319218db3fa6d7b4bba88]
stable/6.8: [b64092d2f108f0cd1d7fd7e176f5fb2a67a2f189]

CVE-2024-35852: mlxsw: spectrum_acl_tcam: Fix memory leak when
canceling rehash work

Announce: https://lore.kernel.org/linux-cve-announce/2024051740-CVE-2024-35=
852-9e9a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c9c9af9 ("mlxsw: spectrum_acl: Allow to
interrupt/continue rehash work") in v5.1-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [fb4e2b70a7194b209fc7320bbf33b375f7114bd5]
stable/5.10: [857ed800133ffcfcee28582090b63b0cbb8ba59d]
stable/5.15: [63d814d93c5cce4c18284adc810028f28dca493f]
stable/5.4: [51cefc9da400b953fee749c9e5d26cd4a2b5d758]
stable/6.1: [5bfe7bf9656ed2633718388f12b7c38b86414a04]
stable/6.6: [de1aaefa75be9d0ec19c9a3e0e2f9696de20c6ab]
stable/6.8: [d72dd6fcd7886d0523afbab8b4a4b22d17addd7d]

CVE-2024-35853: mlxsw: spectrum_acl_tcam: Fix memory leak during rehash

Announce: https://lore.kernel.org/linux-cve-announce/2024051740-CVE-2024-35=
853-869a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8435005 ("mlxsw: spectrum_acl: Do rollback as
another call to mlxsw_sp_acl_tcam_vchunk_migrate_all()") in v5.1-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [8ca3f7a7b61393804c46f170743c3b839df13977]
stable/5.10: [617e98ba4c50f4547c9eb0946b1cfc26937d70d1]
stable/5.15: [413a01886c3958d4b8aac23a3bff3d430b92093e]
stable/5.4: [c6f3fa7f5a748bf6e5c4eb742686d6952f854e76]
stable/6.1: [b822644fd90992ee362c5e0c8d2556efc8856c76]
stable/6.6: [0ae8ff7b6d42e33943af462910bdcfa2ec0cb8cf]
stable/6.8: [b3fd51f684a0711504f82de510da109ae639722d]

CVE-2024-35854: mlxsw: spectrum_acl_tcam: Fix possible use-after-free
during rehash

Announce: https://lore.kernel.org/linux-cve-announce/2024051740-CVE-2024-35=
854-d17b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c9c9af9 ("mlxsw: spectrum_acl: Allow to
interrupt/continue rehash work") in v5.1-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [54225988889931467a9b55fdbef534079b665519]
stable/5.10: [a429a912d6c779807f4d72a6cc0a1efaaa3613e1]
stable/5.15: [4c89642ca47fb620914780c7c51d8d1248201121]
stable/5.4: [e118e7ea24d1392878ef85926627c6bc640c4388]
stable/6.1: [813e2ab753a8f8c243a39ede20c2e0adc15f3887]
stable/6.6: [311eeaa7b9e26aba5b3d57b09859f07d8e9fc049]
stable/6.8: [a02687044e124f8ccb427cd3632124a4e1a7d7c1]

CVE-2024-35855: mlxsw: spectrum_acl_tcam: Fix possible use-after-free
during activity update

Announce: https://lore.kernel.org/linux-cve-announce/2024051741-CVE-2024-35=
855-c1fb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2bffc53 ("mlxsw: spectrum_acl: Don't take mutex
in mlxsw_sp_acl_tcam_vregion_rehash_work()") in v5.1-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [79b5b4b18bc85b19d3a518483f9abbbe6d7b3ba4]
stable/5.10: [e24d2487424779c02760ff50cd9021b8676e19ef]
stable/5.15: [c17976b42d546ee118ca300db559630ee96fb758]
stable/5.4: [1b73f6e4ea770410a937a8db98f77e52594d23a0]
stable/6.1: [b996e8699da810e4c915841d6aaef761007f933a]
stable/6.6: [feabdac2057e863d0e140a2adf3d232eb4882db4]
stable/6.8: [b183b915beef818a25e3154d719ca015a1ae0770]

CVE-2024-35856: Bluetooth: btusb: mediatek: Fix double free of skb in cored=
ump

Announce: https://lore.kernel.org/linux-cve-announce/2024051741-CVE-2024-35=
856-a7ed@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0b70151 ("Bluetooth: btusb: mediatek: add
MediaTek devcoredump support") in v6.6-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [18bdb386a1a30e7a3d7732a98e45e69cf6b5710d]
stable/6.6: [80dfef128cb9f1b1ef67c0fe8c8deb4ea7ad30c1]
stable/6.8: [e20093c741d8da9f6390dd45d75b779861547035]

CVE-2024-35857: icmp: prevent possible NULL dereferences from icmp_build_pr=
obe()

Announce: https://lore.kernel.org/linux-cve-announce/2024051741-CVE-2024-35=
857-837c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d329ea5 ("icmp: add response to RFC 8335 PROBE
messages") in v5.13-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [c58e88d49097bd12dfcfef4f075b43f5d5830941]
stable/5.15: [23b7ee4a8d559bf38eac7ce5bb2f6ebf76f9c401]
stable/6.1: [599c9ad5e1d43f5c12d869f5fd406ba5d8c55270]
stable/6.6: [d68dc711d84fdcf698e5d45308c3ddeede586350]
stable/6.8: [3e2979bf080c40da4f7c93aff8575ab8bc62b767]

CVE-2024-35858: net: bcmasp: fix memory leak when bringing down interface

Announce: https://lore.kernel.org/linux-cve-announce/2024051742-CVE-2024-35=
858-1470@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 490cb41 ("net: bcmasp: Add support for ASP2.0
Ethernet controller") in v6.6-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [9f898fc2c31fbf0ac5ecd289f528a716464cb005]
stable/6.6: [09040baf8779ad880e0e0d0ea10e57aa929ef3ab]
stable/6.8: [2389ad1990163d29cba5480d693b4c2e31cc545c]

CVE-2024-35859: block: fix module reference leakage from
bdev_open_by_dev error path

Announce: https://lore.kernel.org/linux-cve-announce/2024051742-CVE-2024-35=
859-23c9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ed5cc70 ("block: Add config option to not allow
writing to mounted devices") in v6.8-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [9617cd6f24b294552a817f80f5225431ef67b540]
stable/6.8: [0e9327c67410b129bf85e5c3a5aaea518328636f]

CVE-2023-52699: sysv: don't call sb_bread() with pointers_lock held

Announce: https://lore.kernel.org/linux-cve-announce/2024051910-CVE-2023-52=
699-4099@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.

Fixed status
cip/4.4: [3a1f68881da10ea532c3a24ec24f29fd3533884d]
cip/4.4-rt: [3a1f68881da10ea532c3a24ec24f29fd3533884d]
cip/4.4-st: [3a1f68881da10ea532c3a24ec24f29fd3533884d]
mainline: [f123dc86388cb669c3d6322702dc441abc35c31e]
stable/4.19: [13b33feb2ebddc2b1aa607f553566b18a4af1d76]
stable/5.10: [674c1c4229e743070e09db63a23442950ff000d1]
stable/5.15: [fd203d2c671bdee9ab77090ff394d3b71b627927]
stable/5.4: [1b4fe801b5bedec2b622ddb18e5c9bf26c63d79f]
stable/6.1: [53cb1e52c9db618c08335984d1ca80db220ccf09]
stable/6.6: [89e8524135a3902e7563a5a59b7b5ec1bf4904ac]
stable/6.8: [a69224223746ab96d43e5db9d22d136827b7e2d3]

CVE-2024-35860: bpf: support deferring bpf_link dealloc to after RCU
grace period

Announce: https://lore.kernel.org/linux-cve-announce/2024051935-CVE-2024-35=
860-04fd@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0dcac27 ("bpf: Add multi kprobe link") in v5.18-rc1.
Introduced by commit 89ae89f ("bpf: Add multi uprobe link") in v6.6-rc1.
Fixed in v6.9-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1a80dbcb2dbaf6e4c216e62e30fa7d3daa8001ce]
stable/6.6: [876941f533e7b47fc69977fc4551c02f2d18af97]
stable/6.8: [5d8d447777564b35f67000e7838e7ccb64d525c8]

CVE-2024-35861: smb: client: fix potential UAF in
cifs_signal_cifsd_for_reconnect()

Announce: https://lore.kernel.org/linux-cve-announce/2024051937-CVE-2024-35=
861-dcfe@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

It seems as if this bug was introduced by commit dca65818 ("cifs: use
a different reconnect helper for non-cifsd threads") in 5.18-rc1.
Fixed in v6.9-rc3.

Fixed status
mainline: [e0e50401cc3921c9eaf1b0e667db174519ea939f]
stable/6.1: [7e8360ac8774e19b0b25f44fff84a105bb2417e4]
stable/6.6: [2cfff21732132e363b4cc275d63ea98f1af726c1]
stable/6.8: [f9a96a7ad1e8d25dc6662bc7552e0752de74a20d]

CVE-2024-35862: smb: client: fix potential UAF in smb2_is_network_name_dele=
ted()

Announce: https://lore.kernel.org/linux-cve-announce/2024051937-CVE-2024-35=
862-eda2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

It seems as if this bug was introduced by commit 9e550b0 ("TCON
Reconnect during STATUS_NETWORK_NAME_DELETED") 5.12-rc1-dontuse.
Fixed in v6.9-rc3.

Fixed status
mainline: [63981561ffd2d4987807df4126f96a11e18b0c1d]
stable/6.1: [f9414004798d9742c1af23a1d839fe6a9503751c]
stable/6.6: [aa582b33f94453fdeaff1e7d0aa252c505975e01]
stable/6.8: [d919b6ea15ffa56fbafef4a1d92f47aeda9af645]

CVE-2024-35863: smb: client: fix potential UAF in is_valid_oplock_break()

Announce: https://lore.kernel.org/linux-cve-announce/2024051938-CVE-2024-35=
863-7c05@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

It seems as if this bug was introduced by commit f1987b44 ("cifs:
reinstate sharing of tree connections") in 2.6.28-rc6.
Fixed in v6.9-rc3.

Fixed status
mainline: [69ccf040acddf33a3a85ec0f6b45ef84b0f7ec29]
stable/6.1: [494c91e1e9413b407d12166a61b84200d4d54fac]
stable/6.6: [0a15ba88a32fa7a516aff7ffd27befed5334dff2]
stable/6.8: [16d58c6a7db5050b9638669084b63fc05f951825]

CVE-2024-35864: smb: client: fix potential UAF in smb2_is_valid_lease_break=
()

Announce: https://lore.kernel.org/linux-cve-announce/2024051938-CVE-2024-35=
864-3536@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

It seems as if this bug was introduced by commit 0822f51 ("CIFS: Add
SMB2.1 lease break support") in 3.7-rc1.
Fixed in v6.9-rc3.

Fixed status
mainline: [705c76fbf726c7a2f6ff9143d4013b18daaaebf1]
stable/6.1: [c868cabdf6fdd61bea54532271f4708254e57fc5]
stable/6.6: [f92739fdd4522c4291277136399353d7c341fae4]
stable/6.8: [a8344e2b69bde63f713b0aa796d70dbeadffddfb]

CVE-2024-35865: smb: client: fix potential UAF in smb2_is_valid_oplock_brea=
k()

Announce: https://lore.kernel.org/linux-cve-announce/2024051939-CVE-2024-35=
865-c095@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

It seems as if this bug was introduced by commit 983c88a ("CIFS: Add
oplock break support for SMB2") in 3.7-rc1.
Fixed in v6.9-rc3.

Fixed status
mainline: [22863485a4626ec6ecf297f4cc0aef709bc862e4]
stable/6.1: [84488466b7a69570bdbf76dd9576847ab97d54e7]
stable/6.6: [21fed37d2bdcde33453faf61d3d4d96c355f04bd]
stable/6.8: [3dba0e5276f131e36d6d8043191d856f49238628]

CVE-2024-35866: smb: client: fix potential UAF in cifs_dump_full_key()

Announce: https://lore.kernel.org/linux-cve-announce/2024051939-CVE-2024-35=
866-97e5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc3.

Fixed status
mainline: [58acd1f497162e7d282077f816faa519487be045]
stable/6.6: [10e17ca4000ec34737bde002a13435c38ace2682]
stable/6.8: [3103163ccd3be4adcfa37e15608fb497be044113]

CVE-2024-35867: smb: client: fix potential UAF in cifs_stats_proc_show()

Announce: https://lore.kernel.org/linux-cve-announce/2024051939-CVE-2024-35=
867-15e3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

It seems as if this bug was introduced by commit f1987b44 ("cifs:
reinstate sharing of tree connections") in 2.6.28-rc6.
Fixed in v6.9-rc3.

Fixed status
mainline: [0865ffefea197b437ba78b5dd8d8e256253efd65]
stable/6.1: [16b7d785775eb03929766819415055e367398f49]
stable/6.6: [c3cf8b74c57924c0985e49a1fdf02d3395111f39]
stable/6.8: [1e12f0d5c66f07c934041621351973a116fa13c7]

CVE-2024-35868: smb: client: fix potential UAF in cifs_stats_proc_write()

Announce: https://lore.kernel.org/linux-cve-announce/2024051940-CVE-2024-35=
868-be7a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

It seems as if this bug was introduced by commit f1987b44 ("cifs:
reinstate sharing of tree connections") in 2.6.28-rc6.
Fixed in v6.9-rc3.

Fixed status
mainline: [d3da25c5ac84430f89875ca7485a3828150a7e0a]
stable/6.1: [8fefd166fcb368c5fcf48238e3f7c8af829e0a72]
stable/6.6: [cf03020c56d3ed28c4942280957a007b5e9544f7]
stable/6.8: [5b5475ce69f02ecc1b13ea23106e5b89c690429b]

CVE-2024-35869: smb: client: guarantee refcounted children from parent sess=
ion

Announce: https://lore.kernel.org/linux-cve-announce/2024051940-CVE-2024-35=
869-73f8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc3.

Fixed status
mainline: [062a7f0ff46eb57aff526897bd2bebfdb1d3046a]
stable/6.6: [645f332c6b63499cc76197f9b6bffcc659ba64cc]
stable/6.8: [e1db9ae87b7148c021daee1fcc4bc71b2ac58a79]

CVE-2024-35870: smb: client: fix UAF in smb2_reconnect_server()

Announce: https://lore.kernel.org/linux-cve-announce/2024051940-CVE-2024-35=
870-3c02@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc3.

Fixed status
mainline: [24a9799aa8efecd0eb55a75e35f9d8e6400063aa]
stable/6.6: [6202996a1c1887e83d0b3b0fcd86d0e5e6910ea0]
stable/6.8: [45f2beda1f1bc3d962ec07db1ccc3197c25499a5]

CVE-2024-35871: riscv: process: Fix kernel gp leakage

Announce: https://lore.kernel.org/linux-cve-announce/2024051941-CVE-2024-35=
871-2db0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7db91e5 ("RISC-V: Task implementation") in v4.15-rc1.
Fixed in v6.9-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d14fa1fcf69db9d070e75f1c4425211fa619dfc8]
stable/5.10: [9abc3e6f1116adb7a2d4fbb8ce20c37916976bf5]
stable/5.15: [dff6072124f6df77bfd36951fbd88565746980ef]
stable/6.1: [f6583444d7e78dae750798552b65a2519ff3ca84]
stable/6.6: [00effef72c98294edb1efa87ffa0f6cfb61b36a4]
stable/6.8: [d8dcba0691b8e42bddb61aab201e4d918a08e5d9]

CVE-2024-35872: mm/secretmem: fix GUP-fast succeeding on secretmem folios

Announce: https://lore.kernel.org/linux-cve-announce/2024051941-CVE-2024-35=
872-4632@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1507f51 ("mm: introduce memfd_secret system call
to create "secret" memory areas") in v5.14-rc1.
Fixed in v6.9-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [65291dcfcf8936e1b23cfd7718fdfde7cfaf7706]
stable/5.15: [6564b014af92b677c1f07c44d7f5b595d589cf6e]
stable/6.1: [9c2b4b657739ecda38e3b383354a29566955ac48]
stable/6.6: [43fad1d0284de30159661d0badfc3cbaf7e6f8f8]
stable/6.8: [201e4aaf405dfd1308da54448654053004c579b5]

CVE-2024-35873: riscv: Fix vector state restore in rt_sigreturn()

Announce: https://lore.kernel.org/linux-cve-announce/2024051942-CVE-2024-35=
873-40f1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c2a658d ("riscv: lib: vectorize
copy_to_user/copy_from_user") in v6.8-rc1.
Fixed in v6.9-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c27fa53b858b4ee6552a719aa599c250cf98a586]
stable/6.8: [5b16d904e910183181b9d90efa957c787a8ac91b]

CVE-2024-35874: aio: Fix null ptr deref in aio_complete() wakeup

Announce: https://lore.kernel.org/linux-cve-announce/2024051942-CVE-2024-35=
874-c494@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 71eb6b6 ("fs/aio: obey min_nr when doing
wakeups") in v6.8-rc1.
Fixed in v6.9-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [caeb4b0a11b3393e43f7fa8e0a5a18462acc66bd]
stable/6.8: [9678bcc6234d83759fe091c197f5017a32b468da]

CVE-2024-35875: x86/coco: Require seeding RNG with RDRAND on CoCo systems

Announce: https://lore.kernel.org/linux-cve-announce/2024051942-CVE-2024-35=
875-e23d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc3.
The x86/coco (old name was arch/x86/kernel/cc_platform.c) was introduced by
commit aa5a4611 ("x86/sev: Add an x86 version of cc_platform_has()")
in 5.16-rc1.
So, prior to 5.16 kernels are not affected.

Fixed status
mainline: [99485c4c026f024e7cb82da84c7951dbe3deb584]
stable/6.1: [22943e4fe4b3a2dcbadc3d38d5bf840bbdbfe374]
stable/6.6: [453b5f2dec276c1bb4ea078bf8c0da57ee4627e5]
stable/6.8: [08044b08b37528b82f70a87576c692b4e4b7716e]

CVE-2024-35876: x86/mce: Make sure to grab mce_sysfs_mutex in set_bank()

Announce: https://lore.kernel.org/linux-cve-announce/2024051943-CVE-2024-35=
876-d9b5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc3.

Fixed status
mainline: [3ddf944b32f88741c303f0b21459dbb3872b8bc5]
stable/5.10: [f5e65b782f3e07324b9a8fa3cdaee422f057c758]
stable/5.15: [f860595512ff5c05a29fa4d64169c3fd1186b8cf]
stable/5.4: [976b1b2680fb4c01aaf05a0623288d87619a6c93]
stable/6.1: [20a915154ccb88da08986ab6c9fc4c1cf6259de2]
stable/6.6: [5a02df3e92470efd589712925b5c722e730276a0]
stable/6.8: [32223b0b60d53f49567fc501f91ca076ae96be6b]

CVE-2024-35877: x86/mm/pat: fix VM_PAT handling in COW mappings

Announce: https://lore.kernel.org/linux-cve-announce/2024051943-CVE-2024-35=
877-39e6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b1a86e1 ("x86, pat: remove the dependency on
'vm_pgoff' in track/untrack pfn vma routines") in v3.7-rc1.
Introduced by commit 5899329 ("x86: PAT: implement track/untrack of
pfnmap regions for x86 - v3") in v2.6.29-rc1.
Fixed in v6.9-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [c853c986ec599b64efb255b5f8fbe57549d2bf5c]
cip/4.4-rt: [c853c986ec599b64efb255b5f8fbe57549d2bf5c]
cip/4.4-st: [c853c986ec599b64efb255b5f8fbe57549d2bf5c]
mainline: [04c35ab3bdae7fefbd7c7a7355f29fa03a035221]
stable/4.19: [f18681daaec9665a15c5e7e0f591aad5d0ac622b]
stable/5.10: [c2b2430b48f3c9eaccd2c3d2ad75bb540d4952f4]
stable/5.15: [7cfee26d1950250b14c5cb0a37b142f3fcc6396a]
stable/5.4: [09e6bb53217bf388a0d2fd7fb21e74ab9dffc173]
stable/6.1: [97e93367e82752e475a33839a80b33bdbef1209f]
stable/6.6: [51b7841f3fe84606ec0bd8da859d22e05e5419ec]
stable/6.8: [1341e4b32e1fb1b0acd002ccd56f07bd32f2abc6]

CVE-2024-35878: of: module: prevent NULL pointer dereference in vsnprintf()

Announce: https://lore.kernel.org/linux-cve-announce/2024051943-CVE-2024-35=
878-5af8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

It seems as if commit eb0cb8a ("[POWERPC] Add a unified uevent handler
for bus based on of_device") in 2.6.22-rc1 introduced this bug.
Fixed in v6.9-rc3.

Fixed status
mainline: [a1aa5390cc912934fee76ce80af5f940452fa987]
stable/6.6: [e4a449368a2ce6d57a775d0ead27fc07f5a86e5b]
stable/6.8: [544561dc56f7e69a053c25e11e6170f48bb97898]

CVE-2024-35879: of: dynamic: Synchronize of_changeset_destroy() with
the devlink removals

Announce: https://lore.kernel.org/linux-cve-announce/2024051944-CVE-2024-35=
879-963b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 80dd33c ("drivers: base: Fix device link
removal") in v5.13-rc4.
Fixed in v6.9-rc3.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [8917e7385346bd6584890ed362985c219fe6ae84]
stable/5.10: [3127b2ee50c424a96eb3559fbb7b43cf0b111c7a]
stable/5.15: [3ee2424107546d882e1ddd75333ca9c32879908c]
stable/6.1: [7b6df050c45a1ea158fd50bc32a8e1447dd1e951]
stable/6.6: [801c8b8ec5bfb3519566dff16a5ecd48302fca82]
stable/6.8: [ae6d76e4f06c37a623e357e79d49b17411db6f5c]

CVE-2024-35880: io_uring/kbuf: hold io_buffer_list reference over mmap

Announce: https://lore.kernel.org/linux-cve-announce/2024051944-CVE-2024-35=
880-6ffb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5cf4f52 ("io_uring: free io_buffer_list entries
via RCU") in v6.7-rc4.
Fixed in v6.9-rc3.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [561e4f9451d65fc2f7eef564e0064373e3019793]
stable/6.6: [65938e81df2197203bda4b9a0c477e7987218d66]
stable/6.8: [5fd8e2359498043e0b5329a05f02d10a9eb91eb9]

CVE-2024-35881: Revert "drm/amd/display: Send DTBCLK disable message
on first commit"

Announce: https://lore.kernel.org/linux-cve-announce/2024051945-CVE-2024-35=
881-08cd@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

This fix reverts commit f341055 ("drm/amd/display: Send DTBCLK disable
message on first commit") in 6.9-rc1.
This commit was backported to 6.8.
Fixed in v6.9-rc1.

Fixed status
mainline: [3a6a32b31a111f6e66526fb2d3cb13a876465076]
stable/6.8: [0dab75b433ed2480d57ae4f8f725186a46223e42]

CVE-2024-35882: SUNRPC: Fix a slow server-side memory leak with RPC-over-TC=
P

Announce: https://lore.kernel.org/linux-cve-announce/2024051945-CVE-2024-35=
882-f7cf@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e18e157 ("SUNRPC: Send RPC message on TCP with a
single sock_sendmsg() call") in v6.6-rc1.
Fixed in v6.9-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [05258a0a69b3c5d2c003f818702c0a52b6fea861]
stable/6.6: [1ba1291172f935e6b6fe703161a948f3347400b8]
stable/6.8: [a2ebedf7bcd17a1194a0a18122c885eb578ee882]

CVE-2024-35883: spi: mchp-pci1xxx: Fix a possible null pointer
dereference in pci1xxx_spi_probe

Announce: https://lore.kernel.org/linux-cve-announce/2024051945-CVE-2024-35=
883-471d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1cc0cbe ("spi: microchip: pci1xxxx: Add driver
for SPI controller of PCI1XXXX PCIe switch") in v6.2-rc1.
Fixed in v6.9-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f886a7bfb3faf4c1021e73f045538008ce7634e]
stable/6.6: [4b31a226097cf8cc3c9de5e855d97757fdb2bf06]
stable/6.8: [95e5d9eb26705a9a76d2ef8bcba9ee2e195d653d]

CVE-2024-35884: udp: do not accept non-tunnel GSO skbs landing in a tunnel

Announce: https://lore.kernel.org/linux-cve-announce/2024051946-CVE-2024-35=
884-d4a4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9fd1ff5 ("udp: Support UDP fraglist GRO/GSO.") in v5.6=
-rc1.
Introduced by commit 3670706 ("udp: allow forwarding of plain
(non-fraglisted) UDP GRO packets") in v5.12-rc1.
Fixed in v6.9-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d010c8031e39f5fa1e8b13ada77e0321091011f]
stable/5.10: [3391b157780bbedf8ef9f202cbf10ee90bf6b0f8]
stable/5.15: [d49ae15a5767d4e9ef8bbb79e42df1bfebc94670]
stable/6.1: [d12245080cb259d82b34699f6cd4ec11bdb688bd]
stable/6.6: [3001e7aa43d6691db2a878b0745b854bf12ddd19]
stable/6.8: [35fe0e0b5c00bef7dde74842a2564c43856fbce4]

CVE-2024-35885: mlxbf_gige: stop interface during shutdown

Announce: https://lore.kernel.org/linux-cve-announce/2024051946-CVE-2024-35=
885-ce9c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f92e186 ("Add Mellanox BlueField Gigabit Ethernet
driver") in v5.14-rc1.
Fixed in v6.9-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [09ba28e1cd3cf715daab1fca6e1623e22fd754a6]
stable/5.15: [63a10b530e22cc923008b5925821c26872f37971]
stable/6.1: [80247e0eca14ff177d565f58ecd3010f6b7910a4]
stable/6.6: [36a1cb0371aa6f0698910ee70cb4ed3c349f4fa4]
stable/6.8: [9783b3b0e71d704949214a8f76468f591a31f3f5]

CVE-2024-35886: ipv6: Fix infinite recursion in fib6_dump_done().

Announce: https://lore.kernel.org/linux-cve-announce/2024051946-CVE-2024-35=
886-19d4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.9-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [645ed90aad17812e36301126006bc3db3746cafc]
cip/4.4-rt: [645ed90aad17812e36301126006bc3db3746cafc]
cip/4.4-st: [645ed90aad17812e36301126006bc3db3746cafc]
mainline: [d21d40605bca7bd5fc23ef03d4c1ca1f48bc2cae]
stable/4.19: [9472d07cd095cbd3294ac54c42f304a38fbe9bfe]
stable/5.10: [fd307f2d91d40fa7bc55df3e2cd1253fabf8a2d6]
stable/5.15: [40a344b2ddc06c1a2caa7208a43911f39c662778]
stable/5.4: [9c5258196182c25b55c33167cd72fdd9bbf08985]
stable/6.1: [167d4b47a9bdcb01541dfa29e9f3cbb8edd3dfd2]
stable/6.6: [f2dd75e57285f49e34af1a5b6cd8945c08243776]
stable/6.8: [4a7c465a5dcd657d59d25bf4815e19ac05c13061]

CVE-2024-35887: ax25: fix use-after-free bugs caused by ax25_ds_del_timer

Announce: https://lore.kernel.org/linux-cve-announce/2024051947-CVE-2024-35=
887-9c08@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.9-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd819ad3ecf6f3c232a06b27423ce9ed8c20da89]
stable/6.6: [74204bf9050f7627aead9875fe4e07ba125cb19b]
stable/6.8: [c6a368f9c7af4c14b14d390c2543af8001c9bdb9]

CVE-2024-35888: erspan: make sure erspan_base_hdr is present in skb->head

Announce: https://lore.kernel.org/linux-cve-announce/2024051947-CVE-2024-35=
888-1e04@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cb73ee4 ("net: ip_gre: use erspan key field for
tunnel lookup") in v5.0-rc4.
Fixed in v6.9-rc3.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt stable/4.19

Fixed status
mainline: [17af420545a750f763025149fa7b833a4fc8b8f0]
stable/4.19: [06a939f72a24a7d8251f84cf4c042df86c6666ac]
stable/5.10: [b14b9f9503ec823ca75be766dcaeff4f0bfeca85]
stable/5.15: [ee0088101beee10fa809716d6245d915b09c37c7]
stable/5.4: [e54a0c79cdc2548729dd7e2e468b08c5af4d0df5]
stable/6.1: [1db7fcb2b290c47c202b79528824f119fa28937d]
stable/6.6: [4e3fdeecec5707678b0d1f18c259dadb97262e9d]
stable/6.8: [0ac328a5a4138a6c03dfc3f46017bd5c19167446]

CVE-2024-35889: idpf: fix kernel panic on unknown packet types

Announce: https://lore.kernel.org/linux-cve-announce/2024051948-CVE-2024-35=
889-023e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3a8845a ("idpf: add RX splitq napi poll support")
in v6.7-rc1.
Fixed in v6.9-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd19e827d63ac60debf117676d1126bff884bdb8]
stable/6.8: [b4d28f7fa4dd531cf503a4fe1ca7008960cc5832]

CVE-2024-35890: gro: fix ownership transfer

Announce: https://lore.kernel.org/linux-cve-announce/2024051948-CVE-2024-35=
890-beaa@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5e10da5 ("skbuff: allow 'slow_gro' for skb
carring sock reference") in v5.15-rc1.
Fixed in v6.9-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ed4cccef64c1d0d5b91e69f7a8a6697c3a865486]
stable/5.15: [d225b0ac96dc40d7e8ae2bc227eb2c56e130975f]
stable/6.1: [2eeab8c47c3c0276e0746bc382f405c9a236a5ad]
stable/6.6: [fc126c1d51e9552eacd2d717b9ffe9262a8a4cd6]
stable/6.8: [5b3b67f731296027cceb3efad881ae281213f86f]

CVE-2024-35891: net: phy: micrel: Fix potential null pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024051948-CVE-2024-35=
891-3a56@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ece1950 ("net: phy: micrel: 1588 support for
LAN8814 phy") in v5.18-rc1.
Fixed in v6.9-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [96c155943a703f0655c0c4cab540f67055960e91]
stable/6.1: [10608161696c2768f53426642f78a42bcaaa53e8]
stable/6.6: [95c1016a2d92c4c28a9d1b6d09859c00b19c0ea4]
stable/6.8: [49767b0df276f12e3e7184601e09ee7430e252dc]

CVE-2024-35892: net/sched: fix lockdep splat in qdisc_tree_reduce_backlog()

Announce: https://lore.kernel.org/linux-cve-announce/2024051949-CVE-2024-35=
892-0f0c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d636fc5 ("net: sched: add rcu annotations around
qdisc->qdisc_sleeping") in v6.4-rc6.
Fixed in v6.9-rc3.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [7eb322360b0266481e560d1807ee79e0cef5742b]
stable/6.1: [b7d1ce2cc7192e8a037faa3f5d3ba72c25976460]
stable/6.6: [c040b99461a5bfc14c2d0cbb1780fcc3a4706c7e]
stable/6.8: [07696415526bee0607e495017369c7303a4792e1]

CVE-2024-35893: net/sched: act_skbmod: prevent kernel-infoleak

Announce: https://lore.kernel.org/linux-cve-announce/2024051949-CVE-2024-35=
893-5132@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 86da71b ("net_sched: Introduce skbmod action") in v4.9=
-rc1.
Fixed in v6.9-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d313eb8b77557a6d5855f42d2234bd592c7b50dd]
stable/4.19: [f190a4aa03cbd518bd9c62a66e1233984f5fd2ec]
stable/5.10: [5e45dc4408857305f4685abfd7a528a1e58b51b5]
stable/5.15: [a097fc199ab5f4b5392c5144034c0d2148b55a14]
stable/5.4: [f356eb2fb567e0931143ac1769ac802d3b3e2077]
stable/6.1: [55d3fe7b2b7bc354e7cbc1f7b8f98a29ccd5a366]
stable/6.6: [729ad2ac2a2cdc9f4a4bdfd40bfd276e6bc33924]
stable/6.8: [7bb2c7103d8c13b06a57bf997b8cdbe93cd7283c]

CVE-2024-35894: mptcp: prevent BPF accessing lowat from a subflow socket.

Announce: https://lore.kernel.org/linux-cve-announce/2024051949-CVE-2024-35=
894-fd19@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5684ab1 ("mptcp: give rcvlowat some love") in v6.7-rc1=
.
Fixed in v6.9-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fcf4692fa39e86a590c14a4af2de704e1d20a3b5]
stable/6.8: [3ffb1ab698376f09cc33101c07c1be229389fe29]

CVE-2024-35895: bpf, sockmap: Prevent lock inversion deadlock in map delete=
 elem

Announce: https://lore.kernel.org/linux-cve-announce/2024051950-CVE-2024-35=
895-cb33@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 604326b ("bpf, sockmap: convert to generic sk_msg
interface") in v4.20-rc1.
Fixed in v6.9-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff91059932401894e6c86341915615c5eb0eca48]
stable/5.10: [dd54b48db0c822ae7b520bc80751f0a0a173ef75]
stable/5.15: [d1e73fb19a4c872d7a399ad3c66e8ca30e0875ec]
stable/5.4: [f7990498b05ac41f7d6a190dc0418ef1d21bf058]
stable/6.1: [a44770fed86515eedb5a7c00b787f847ebb134a5]
stable/6.6: [668b3074aa14829e2ac2759799537a93b60fef86]
stable/6.8: [6af057ccdd8e7619960aca1f0428339f213b31cd]

CVE-2024-35896: netfilter: validate user input for expected length

Announce: https://lore.kernel.org/linux-cve-announce/2024051950-CVE-2024-35=
896-e6b5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.9-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c83842df40f86e529db6842231154772c20edcc]
stable/5.10: [0f038242b77ddfc505bf4163d4904c1abd2e74d6]
stable/5.15: [440e948cf0eff32cfe322dcbca3f2525354b159b]
stable/6.1: [18aae2cb87e5faa9c5bd865260ceadac60d5a6c5]
stable/6.6: [81d51b9b7c95e791ba3c1a2dd77920a9d3b3f525]
stable/6.8: [58f2bfb789e6bd3bc24a2c9c1580f3c67aec3018]

CVE-2024-35897: netfilter: nf_tables: discard table flag update with
pending basechain deletion

Announce: https://lore.kernel.org/linux-cve-announce/2024051951-CVE-2024-35=
897-1585@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 179d9ba ("netfilter: nf_tables: fix table flag
updates") in v5.13-rc5.
Fixed in v6.9-rc3.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [1bc83a019bbe268be3526406245ec28c2458a518]
stable/5.10: [b58d0ac35f6d75ec1db8650a29dfd6f292c11362]
stable/5.15: [6cbbe1ba76ee7e674a86abd43009b083a45838cb]
stable/5.4: [9a3b90904d8a072287480eed4c3ece4b99d64f78]
stable/6.1: [2aeb805a1bcd5f27c8c0d1a9d4d653f16d1506f4]
stable/6.6: [9627fd0c6ea1c446741a33e67bc5709c59923827]
stable/6.8: [7f609f630951b624348373cef99991ce08831927]

CVE-2024-35898: netfilter: nf_tables: Fix potential data-race in
__nft_flowtable_type_get()

Announce: https://lore.kernel.org/linux-cve-announce/2024051951-CVE-2024-35=
898-a10e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3b49e2e ("netfilter: nf_tables: add flow table
netlink frontend") in v4.16-rc1.
Fixed in v6.9-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [24225011d81b471acc0e1e315b7d9905459a6304]
stable/4.19: [69d1fe14a680042ec913f22196b58e2c8ff1b007]
stable/5.10: [940d41caa71f0d3a52df2fde5fada524a993e331]
stable/5.15: [2485bcfe05ee3cf9ca8923a94fa2e456924c79c8]
stable/5.4: [a347bc8e6251eaee4b619da28020641eb5b0dd77]
stable/6.1: [9b5b7708ec2be21dd7ef8ca0e3abe4ae9f3b083b]
stable/6.6: [8b891153b2e4dc0ca9d9dab8f619d49c740813df]
stable/6.8: [e684b1674fd1ca4361812a491242ae871d6b2859]

CVE-2024-35899: netfilter: nf_tables: flush pending destroy work
before exit_net release

Announce: https://lore.kernel.org/linux-cve-announce/2024051951-CVE-2024-35=
899-c56a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0935d55 ("netfilter: nf_tables: asynchronous
release") in v4.20-rc1.
Fixed in v6.9-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [24cea9677025e0de419989ecb692acd4bb34cac2]
stable/5.10: [46c4481938e2ca62343b16ea83ab28f4c1733d31]
stable/5.15: [f7e3c88cc2a977c2b9a8aa52c1ce689e7b394e49]
stable/5.4: [f4e14695fe805eb0f0cb36e0ad6a560b9f985e86]
stable/6.1: [4e8447a9a3d367b5065a0b7abe101da6e0037b6e]
stable/6.6: [333b5085522cf1898d5a0d92616046b414f631a7]
stable/6.8: [d2c9eb19fc3b11caebafde4c30a76a49203d18a6]

CVE-2024-35900: netfilter: nf_tables: reject new basechain after table
flag update

Announce: https://lore.kernel.org/linux-cve-announce/2024051952-CVE-2024-35=
900-c2c9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 179d9ba ("netfilter: nf_tables: fix table flag
updates") in v5.13-rc5.
Fixed in v6.9-rc3.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [994209ddf4f430946f6247616b2e33d179243769]
stable/5.10: [7b6fba6918714afee3e17796113ccab636255c7b]
stable/5.15: [8ba81dca416adf82fc5a2a23abc1a8cc02ad32fb]
stable/5.4: [41bad13c0e8a5a2b47a7472cced922555372daab]
stable/6.1: [745cf6a843896cdac8766c74379300ed73c78830]
stable/6.6: [420132bee3d0136b7fba253a597b098fe15493a7]
stable/6.8: [e95bb4cba94c018be24b11f017d1c55dd6cda31a]

CVE-2024-35901: net: mana: Fix Rx DMA datasize and skb_over_panic

Announce: https://lore.kernel.org/linux-cve-announce/2024051952-CVE-2024-35=
901-6e99@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2fbbd71 ("net: mana: Enable RX path to handle
various MTU sizes") in v6.4-rc1.
Fixed in v6.9-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0de6ab920aafb56feab56058e46b688e694a246]
stable/6.6: [ca58927b00385005f488b6a9905ced7a4f719aad]
stable/6.8: [05cb7c41fa1a7a7b2c2a6b81bbe7c67f5c11932b]

CVE-2024-35902: net/rds: fix possible cp null dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024051952-CVE-2024-35=
902-a288@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c055fc0 ("net/rds: fix WARNING in
rds_conn_connect_if_down") in v6.8.
Fixed in v6.9-rc3.
Bug introduced commit was backported to following branches.
cip/4.19 cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/4.19
stable/5.10 stable/5.15 stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [62fc3357e079a07a22465b9b6ef71bb6ea75ee4b]
stable/4.19: [d275de8ea7be3a453629fddae41d4156762e814c]
stable/5.10: [cfb786b03b03c5ff38882bee38525eb9987e4d14]
stable/5.15: [d49fac38479bfdaec52b3ea274d290c47a294029]
stable/5.4: [bcd46782e2ec3825d10c1552fcb674d491cc09f9]
stable/6.1: [cbaac2e5488ed54833897264a5ffb2a341a9f196]
stable/6.6: [92309bed3c5fbe2ccd4c45056efd42edbd06162d]
stable/6.8: [6794090c742008c53b344b35b021d4a3093dc50a]

CVE-2024-35903: x86/bpf: Fix IP after emitting call depth accounting

Announce: https://lore.kernel.org/linux-cve-announce/2024051953-CVE-2024-35=
903-c5d9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b2e9dfe ("x86/bpf: Emit call depth accounting if
required") in v6.2-rc1.
Fixed in v6.9-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9d98aa088386aee3db1b7b60b800c0fde0654a4a]
stable/6.6: [3f9d57c771656bfd651e22edcfdb5f60e62542d4]
stable/6.8: [81166178cf0a0062a22b1b3b5368183d39577028]

CVE-2024-35904: selinux: avoid dereference of garbage after mount failure

Announce: https://lore.kernel.org/linux-cve-announce/2024051953-CVE-2024-35=
904-7f85@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0619f0f ("selinux: wrap selinuxfs state") in v4.17-rc1=
.
Fixed in v6.9-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [37801a36b4d68892ce807264f784d818f8d0d39b]
stable/6.6: [477ed6789eb9f3f4d3568bb977f90c863c12724e]
stable/6.8: [68784a5d01b8868ff85a7926676b6729715fff3c]

CVE-2024-35905: bpf: Protect against int overflow for stack access size

Announce: https://lore.kernel.org/linux-cve-announce/2024051954-CVE-2024-35=
905-d079@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a833a17 ("bpf: Fix verification of indirect
var-off stack access") in v6.8-rc1.
Fixed in v6.9-rc2.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [ecc6a2101840177e57c925c102d2d29f260d37c8]
stable/5.10: [9970e059af471478455f9534e8c3db82f8c5496d]
stable/5.15: [37dc1718dc0c4392dbfcb9adec22a776e745dd69]
stable/6.1: [98cdac206b112bec63852e94802791e316acc2c1]
stable/6.6: [3f0784b2f1eb9147973d8c43ba085c5fdf44ff69]
stable/6.8: [203a68151e8eeb331d4a64ab78303f3a15faf103]

CVE-2024-35906: drm/amd/display: Send DTBCLK disable message on first commi=
t

Announce: https://lore.kernel.org/linux-cve-announce/2024051954-CVE-2024-35=
906-1c6f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
This driver was introduced by commit 8774029 ("drm/amd/display: Add
DCN35 CLK_MGR") in 6.7-rc1.

Fixed status
mainline: [f341055b10bd8be55c3c995dff5f770b236b8ca9]
stable/6.8: [0dab75b433ed2480d57ae4f8f725186a46223e42]

CVE-2024-35907: mlxbf_gige: call request_irq() after NAPI initialized

Announce: https://lore.kernel.org/linux-cve-announce/2024051954-CVE-2024-35=
907-32f9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f92e186 ("Add Mellanox BlueField Gigabit Ethernet
driver") in v5.14-rc1.
Fixed in v6.9-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7442a634ac06b953fc1f7418f307b25acd4cfbc]
stable/5.15: [a583117668ddb86e98f2e11c7caa3db0e6df52a3]
stable/6.1: [24444af5ddf729376b90db0f135fa19973cb5dab]
stable/6.6: [867a2f598af6a645c865d1101b58c5e070c6dd9e]
stable/6.8: [8feb1652afe9c5d019059a55c90f70690dce0f52]

CVE-2024-35908: tls: get psock ref after taking rxlock to avoid leak

Announce: https://lore.kernel.org/linux-cve-announce/2024051955-CVE-2024-35=
908-e78a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4cbc325 ("tls: rx: allow only one reader at a
time") in v6.0-rc1.
Fixed in v6.9-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [417e91e856099e9b8a42a2520e2255e6afe024be]
stable/6.1: [30fabe50a7ace3e9d57cf7f9288f33ea408491c8]
stable/6.6: [f1b7f14130d782433bc98c1e1e41ce6b4d4c3096]
stable/6.8: [b565d294e3d5aa809566a4d819835da11997d8b3]

CVE-2024-35909: net: wwan: t7xx: Split 64bit accesses to fix alignment issu=
es

Announce: https://lore.kernel.org/linux-cve-announce/2024051955-CVE-2024-35=
909-a00f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 39d4390 ("net: wwan: t7xx: Add control DMA
interface") in v5.19-rc1.
Fixed in v6.9-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d5a7dd5a35876f0ecc286f3602a88887a788217]
stable/6.1: [beaf0e7996b79e06ccc2bdcb4442fbaeccc31200]
stable/6.6: [2e22c9cb618716b8e557fe17c3d4958171288082]
stable/6.8: [b4fdb3c197e35f655b2d9b6759ce29440eacdfda]

CVE-2024-35910: tcp: properly terminate timers for kernel sockets

Announce: https://lore.kernel.org/linux-cve-announce/2024051955-CVE-2024-35=
910-5f95@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 26abe14 ("net: Modify sk_alloc to not reference
count the netns of kernel sockets.") in v4.2-rc1.
Introduced by commit 8a68173 ("net: sk_clone_lock() should only do
get_net() if the parent is not a kernel socket") in v4.2-rc5.
Fixed in v6.9-rc2.

Fixed status
mainline: [151c9c724d05d5b0dd8acd3e11cb69ef1f2dbada]
stable/4.19: [93f0133b9d589cc6e865f254ad9be3e9d8133f50]
stable/5.10: [e3e27d2b446deb1f643758a0c4731f5c22492810]
stable/5.15: [2e43d8eba6edd1cf05a3a20fdd77688fa7ec16a4]
stable/5.4: [44e62f5d35678686734afd47c6a421ad30772e7f]
stable/6.1: [91b243de910a9ac8476d40238ab3dbfeedd5b7de]
stable/6.6: [c1ae4d1e76eacddaacb958b67cd942082f800c87]
stable/6.8: [899265c1389fe022802aae73dbf13ee08837a35a]

CVE-2024-35911: ice: fix memory corruption bug with suspend and rebuild

Announce: https://lore.kernel.org/linux-cve-announce/2024051956-CVE-2024-35=
911-f6f9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b3e7b3a ("ice: prevent NULL pointer deref during
reload") in v6.5-rc3.
Fixed in v6.9-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1cb7fdb1dfde1aab66780b4ba44dba6402172111]
stable/6.6: [e40a02f06ceb0e0b0183e0b973ac5dbf8f75edec]
stable/6.8: [11ff8392943e08a35cb0aa19d638b02db745f170]

CVE-2024-35912: wifi: iwlwifi: mvm: rfi: fix potential response leaks

Announce: https://lore.kernel.org/linux-cve-announce/2024051956-CVE-2024-35=
912-b093@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2125490 ("iwlwifi: mvm: add RFI-M support") in v5.12-r=
c1.
Fixed in v6.9-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [06a093807eb7b5c5b29b6cff49f8174a4e702341]
stable/5.15: [28db0ae86cb91a4ab0e855cff779daead936b7d5]
stable/6.1: [99a75d75007421d8e08ba139e24f77395cd08f62]
stable/6.6: [c0a40f2f8eba07416f695ffe2011bf3f8b0b6dc8]
stable/6.8: [f7f0e784894dfcb265f0f9fa499103b0ca7eabde]

CVE-2024-35913: wifi: iwlwifi: mvm: pick the version of SESSION_PROTECTION_=
NOTIF

Announce: https://lore.kernel.org/linux-cve-announce/2024051956-CVE-2024-35=
913-72a4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 085d33c ("wifi: iwlwifi: support link id in
SESSION_PROTECTION_NOTIF") in v6.7-rc1.
Fixed in v6.9-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bbe806c294c9c4cd1221140d96e5f367673e393a]
stable/6.8: [222abd95f503e28c0404e596291fe472fe90929c]

CVE-2024-35914: nfsd: Fix error cleanup path in nfsd_rename()

Announce: https://lore.kernel.org/linux-cve-announce/2024051957-CVE-2024-35=
914-3194@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a8b0026 ("rename(): avoid a deadlock in the case
of parents having no common ancestor") in v6.8-rc1.
Fixed in v6.9-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9fe6e9e7b58944037714442384075c17cfde1c56]
stable/6.8: [331e125e02c08ffaecc1074af78a988a278039bd]

CVE-2024-35915: nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet

Announce: https://lore.kernel.org/linux-cve-announce/2024051957-CVE-2024-35=
915-aead@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6a2968a ("NFC: basic NCI protocol
implementation") in v3.2-rc1.
Fixed in v6.9-rc2.

Fixed status
cip/4.4: [fb95e56a6be64d6536bb0503d9beb4f694864cfd]
cip/4.4-rt: [fb95e56a6be64d6536bb0503d9beb4f694864cfd]
cip/4.4-st: [fb95e56a6be64d6536bb0503d9beb4f694864cfd]
mainline: [d24b03535e5eb82e025219c2f632b485409c898f]
stable/4.19: [11387b2effbb55f58dc2111ef4b4b896f2756240]
stable/5.10: [755e53bbc61bc1aff90eafa64c8c2464fd3dfa3c]
stable/5.15: [ac68d9fa09e410fa3ed20fb721d56aa558695e16]
stable/5.4: [03fe259649a551d336a7f20919b641ea100e3fff]
stable/6.1: [b51ec7fc9f877ef869c01d3ea6f18f6a64e831a7]
stable/6.6: [a946ebee45b09294c8b0b0e77410b763c4d2817a]
stable/6.8: [8948e30de81faee87eeee01ef42a1f6008f5a83a]

CVE-2024-35916: dma-buf: Fix NULL pointer dereference in sanitycheck()

Announce: https://lore.kernel.org/linux-cve-announce/2024051958-CVE-2024-35=
916-67f1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d62c43a ("dma-buf: Enable signaling on fence for
selftests") in v6.1-rc1.
Fixed in v6.9-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2295bd846765c766701e666ed2e4b35396be25e6]
stable/6.1: [0336995512cdab0c65e99e4cdd47c4606debe14e]
stable/6.6: [156c226cbbdcf5f3bce7b2408a33b59fab7fae2c]
stable/6.8: [eabf131cba1db12005a68378305f13b9090a7a6b]

CVE-2024-35917: s390/bpf: Fix bpf_plt pointer arithmetic

Announce: https://lore.kernel.org/linux-cve-announce/2024051958-CVE-2024-35=
917-df0b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f1d5df8 ("s390/bpf: Implement
bpf_arch_text_poke()") in v6.3-rc1.
Fixed in v6.9-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ded842b356d151ece8ac4985940438e6d3998bb]
stable/6.6: [c3062bdb859b6e2567e7f5c8cde20c0250bb130f]
stable/6.8: [d3d74e45a060d218fe4b0c9174f0a77517509d8e]

CVE-2024-35918: randomize_kstack: Improve entropy diffusion

Announce: https://lore.kernel.org/linux-cve-announce/2024051912-CVE-2024-35=
918-3fed@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 39218ff ("stack: Optionally randomize kernel
stack offset each syscall") in v5.13-rc1.
Fixed in v6.9-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9c573cd313433f6c1f7236fe64b9b743500c1628]
stable/5.15: [dfb2ce952143de60dd756ed666901236c76cb3fa]
stable/6.1: [e80b4980af2688d8ff69c157ffa773dd1f1eb02c]
stable/6.6: [300a2b9c2b28282974ee300bb5d5025cbbb1f64c]
stable/6.8: [6be74b1e21f8de4c48af772c2f658b464bfe6145]

CVE-2024-35919: media: mediatek: vcodec: adding lock to protect
encoder context list

Announce: https://lore.kernel.org/linux-cve-announce/2024051913-CVE-2024-35=
919-b10c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1972e32 ("media: mediatek: vcodec: Fix possible
invalid memory access for encoder") in v6.6-rc1.
Fixed in v6.9-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [afaaf3a0f647a24a7bf6a2145d8ade37baaf75ad]
stable/6.6: [41671f0c0182b2bae74ca7e3b0f155559e3e2fc5]
stable/6.8: [51c84a8aac6e3b59af2b0e92ba63cabe2e641a2d]

CVE-2024-35920: media: mediatek: vcodec: adding lock to protect
decoder context list

Announce: https://lore.kernel.org/linux-cve-announce/2024051913-CVE-2024-35=
920-ceed@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 655b86e ("media: mediatek: vcodec: Fix possible
invalid memory access for decoder") in v6.6-rc1.
Fixed in v6.9-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6467cda18c9f9b5f2f9a0aa1e2861c653e41f382]
stable/6.6: [0a2dc707aa42214f9c4827bd57e344e29a0841d6]
stable/6.8: [23aaf824121055ba81b55f75444355bd83c8eb38]

CVE-2024-35921: media: mediatek: vcodec: Fix oops when HEVC init fails

Announce: https://lore.kernel.org/linux-cve-announce/2024051913-CVE-2024-35=
921-ec49@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2674486 ("media: mediatek: vcodec: support
stateless hevc decoder") in v6.5-rc1.
Fixed in v6.9-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [97c75ee5de060d271d80109b0c47cb6008439e5b]
stable/6.6: [ec25fc3c2c1e8958a51abcfed614f81446d918c4]
stable/6.8: [521ce0ea7418298d754494fe53263c23c4c78a8e]

CVE-2024-35922: fbmon: prevent division by zero in fb_videomode_from_videom=
ode()

Announce: https://lore.kernel.org/linux-cve-announce/2024051913-CVE-2024-35=
922-650f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.

Fixed status
cip/4.4: [91d0326797ae6de3be3ae9d7a989ae960fa74595]
cip/4.4-rt: [91d0326797ae6de3be3ae9d7a989ae960fa74595]
cip/4.4-st: [91d0326797ae6de3be3ae9d7a989ae960fa74595]
mainline: [c2d953276b8b27459baed1277a4fdd5dd9bd4126]
stable/4.19: [1fb52bc1de55e9e0bdf71fe078efd4da0889710f]
stable/5.10: [951838fee462aa01fa2a6a91d56f9a495082e7f0]
stable/5.15: [48d6bcfc31751ca2e753d901a2d82f27edf8a029]
stable/5.4: [72d091b7515e0532ee015e144c906f3bcfdd6270]
stable/6.1: [664206ff8b019bcd1e55b10b2eea3add8761b971]
stable/6.6: [3d4b909704bf2114f64f87363fa22b5ef8ac4a33]
stable/6.8: [1b107d637fed68a787da77a3514ad06e57abd0b4]

CVE-2024-35923: io_uring: clear opcode specific data for an early failure

Announce: https://lore.kernel.org/linux-cve-announce/2024051914-CVE-2024-35=
923-ddae@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
The io_uring was introduced in 5.1 so 4.x is not affected.

Fixed status
mainline: [e21e1c45e1fe2e31732f40256b49c04e76a17cee]
stable/6.1: [5245a6da27ef79f8dba98dad5542ebe56d311837]
stable/6.6: [21162ad2de7446438cbd6224b3794a375bcb24df]
stable/6.8: [cb1cd176e0b431644653a7fa8691a1aaf7be98da]

CVE-2024-35924: usb: typec: ucsi: Limit read size on v1.2

Announce: https://lore.kernel.org/linux-cve-announce/2024051914-CVE-2024-35=
924-90f6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
The drivers/usb/typec/ucsi was introduced by commit c1b0bc2 ("usb:
typec: Add support for UCSI interface") in 4.13-rc1.

Fixed status
mainline: [b3db266fb031fba88c423d4bb8983a73a3db6527]
stable/6.6: [266f403ec47573046dee4bcebda82777ce702c40]
stable/6.8: [0defcaa09d3b21e8387829ee3a652c43fa91e13f]

CVE-2024-35925: block: prevent division by zero in blk_rq_stat_sum()

Announce: https://lore.kernel.org/linux-cve-announce/2024051914-CVE-2024-35=
925-fa17@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
The block/blk-stat.c was introduced by commit cf43e6b ("block: add
scalable completion tracking of requests") in 4.10-rc1.

Fixed status
mainline: [93f52fbeaf4b676b21acfe42a5152620e6770d02]
stable/4.19: [6a55dab4ac956deb23690eedd74e70b892a378e7]
stable/5.10: [b0cb5564c3e8e0ee0a2d28c86fa7f02e82d64c3c]
stable/5.15: [21e7d72d0cfcbae6042d498ea2e6f395311767f8]
stable/5.4: [edd073c78d2bf48c5b8bf435bbc3d61d6e7c6c14]
stable/6.1: [512a01da7134bac8f8b373506011e8aaa3283854]
stable/6.6: [5f7fd6aa4c4877d77133ea86c14cf256f390b2fe]
stable/6.8: [98ddf2604ade2d954bf5ec193600d5274a43fd68]

CVE-2024-35926: crypto: iaa - Fix async_disable descriptor leak

Announce: https://lore.kernel.org/linux-cve-announce/2024051915-CVE-2024-35=
926-d677@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
It seems as if this bug was introduced by commit 09646c9 ("crypto: iaa
- Add irq support for the crypto async interface") in 6.8-rc1.

Fixed status
mainline: [262534ddc88dfea7474ed18adfecf856e4fbe054]
stable/6.8: [d994f7d77aaded05dc05af58a2720fd4f4b72a83]

CVE-2024-35927: drm: Check output polling initialized before disabling

Announce: https://lore.kernel.org/linux-cve-announce/2024051915-CVE-2024-35=
927-2100@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
The drivers/gpu/drm/drm_modeset_helper.c was added by commit 1de72faf
("drm/kms-helpers: Extract drm_modeset_helper.[hc]") in 4.9-rc1.

Fixed status
mainline: [5abffb66d12bcac84bf7b66389c571b8bb6e82bd]
stable/6.6: [3d1b47e3a935abd4f258a945db87e7267ff4079c]
stable/6.8: [18451798f4a4e7418b9fad7e7dd313fe84b1f545]

CVE-2024-35928: drm/amd/amdgpu: Fix potential ioremap() memory leaks
in amdgpu_device_init()

Announce: https://lore.kernel.org/linux-cve-announce/2024051915-CVE-2024-35=
928-ead3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.

Fixed status
mainline: [eb4f139888f636614dab3bcce97ff61cefc4b3a7]
stable/6.1: [c5f9fe2c1e5023fa096189a8bfba6420aa035587]
stable/6.6: [14ac934db851642ea8cd1bd4121c788a8899ef69]
stable/6.8: [aa665c3a2aca2ffe31b9645bda278e96dfc3b55c]

CVE-2024-35929: rcu/nocb: Fix WARN_ON_ONCE() in the rcu_nocb_bypass_lock()

Announce: https://lore.kernel.org/linux-cve-announce/2024051916-CVE-2024-35=
929-6f74@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
It seems as if this bug was introduced by commit 7625926 ("rcu/nocb:
Fix shrinker race against callback enqueuer") in 6.5-rc1.
This commit is not backported to older stable kernels.

Fixed status
mainline: [dda98810b552fc6bf650f4270edeebdc2f28bd3f]
stable/6.6: [4d58c9fb45c70e62c19e8be3f3605889c47601bc]
stable/6.8: [927d1f4f77e4784ab3944a9df86ab14d1cd3185a]

CVE-2024-35930: scsi: lpfc: Fix possible memory leak in lpfc_rcv_padisc()

Announce: https://lore.kernel.org/linux-cve-announce/2024051916-CVE-2024-35=
930-5571@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.

Fixed status
cip/4.4: [0dc42ac344a11bf255159c2becb60b6aa2c8711c]
cip/4.4-rt: [0dc42ac344a11bf255159c2becb60b6aa2c8711c]
cip/4.4-st: [0dc42ac344a11bf255159c2becb60b6aa2c8711c]
mainline: [2ae917d4bcab80ab304b774d492e2fcd6c52c06b]
stable/4.19: [edf82aa7e9eb864a09229392054d131b34a5c9e8]
stable/5.10: [c473288f27d15014447de5a891bdf22a0695847a]
stable/5.15: [7849e6f8410da96384e3d1f6b6d730f095142dc7]
stable/5.4: [e2cd32435b1dff3d63759476a3abc878e02fb6c8]
stable/6.1: [ee0b5f96b6d66a1e6698228dcb41df11ec7f352f]
stable/6.6: [07a2aa674fca679316b8ac51440adb895b53a7cf]
stable/6.8: [3320126ed3afbc11934502319b340f91a4d61c8f]

CVE-2024-35931: drm/amdgpu: Skip do PCI error slot reset during RAS recover=
y

Announce: https://lore.kernel.org/linux-cve-announce/2024051916-CVE-2024-35=
931-430d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.

Fixed status
mainline: [601429cca96b4af3be44172c3b64e4228515dbe1]
stable/6.8: [395ca1031acf89d8ecb26127c544a71688d96f35]

CVE-2024-35932: drm/vc4: don't check if plane->state->fb =3D=3D state->fb

Announce: https://lore.kernel.org/linux-cve-announce/2024051916-CVE-2024-35=
932-b008@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
The vc4_prepare_fb() was added by commit 334dbd6 ("drm/vc4: Hook up
plane prepare_fb to lookup dma-buf reservations.") in 4.14-rc1.
The vc4_cleanup_fb() was added by commit b9f1925 ("drm/vc4: Add the
DRM_IOCTL_VC4_GEM_MADVISE ioctl") in 4.15-rc1.
So, Linux 4.4 is not affected.

Fixed status
mainline: [5ee0d47dcf33efd8950b347dcf4d20bab12a3fa9]
stable/6.1: [48bfb4b03c5ff6e1fa1dc73fb915e150b0968c40]
stable/6.6: [d6b2fe2db1d0927b2d7df5c763eba55d0e1def3c]
stable/6.8: [5343f724c912c77541029123f47ecd3d2ea63bdd]

CVE-2024-35933: Bluetooth: btintel: Fix null ptr deref in btintel_read_vers=
ion

Announce: https://lore.kernel.org/linux-cve-announce/2024051917-CVE-2024-35=
933-cf34@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
It seems as if this bug was introduced by commit 6c483de ("Bluetooth:
btintel: Create common Intel Version Read function") in 4.5-rc1.

Fixed status
mainline: [b79e040910101b020931ba0c9a6b77e81ab7f645]
stable/4.19: [ec2049fb2b8be3e108fe2ef1f1040f91e72c9990]
stable/5.10: [86e9b47e8a75c74b1bd83a479979b425c5dc8bd9]
stable/5.15: [006936ecb4edfc3102464044f75858c714e34d28]
stable/5.4: [68a69bb2ecafaacdb998a87783068fb51736f43b]
stable/6.1: [b19fe5eea619d54eea59bb8a37c0f8d00ef0e912]
stable/6.6: [ffdca0a62abaf8c41d8d9ea132000fd808de329b]
stable/6.8: [22d3053ef05f0b5045e45bd91e7473846261d65e]

CVE-2024-35934: net/smc: reduce rtnl pressure in smc_pnet_create_pnetids_li=
st()

Announce: https://lore.kernel.org/linux-cve-announce/2024051917-CVE-2024-35=
934-c8af@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
It seems as if this bug was introduced by commit e888a2e ("net/smc:
introduce list of pnetids for Ethernet devices") in 5.10-rc1.

Fixed status
mainline: [00af2aa93b76b1bade471ad0d0525d4d29ca5cc0]
stable/5.10: [bc4d1ebca11b4f194e262326bd45938e857c59d2]
stable/5.15: [b9117dc783c0ab0a3866812f70e07bf2ea071ac4]
stable/6.1: [d7ee3bf0caf599c14db0bf4af7aacd6206ef8a23]
stable/6.6: [a2e6bffc0388526ed10406040279a693d62b36ec]
stable/6.8: [6e920422e7104928f760fc0e12b6d65ab097a2e7]

CVE-2024-35935: btrfs: send: handle path ref underflow in header
iterate_inode_ref()

Announce: https://lore.kernel.org/linux-cve-announce/2024051917-CVE-2024-35=
935-cdbd@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.

Fixed status
cip/4.4: [8ec31fc4b9b3bab1ef25955f0b0479c544f85978]
cip/4.4-rt: [8ec31fc4b9b3bab1ef25955f0b0479c544f85978]
cip/4.4-st: [8ec31fc4b9b3bab1ef25955f0b0479c544f85978]
mainline: [3c6ee34c6f9cd12802326da26631232a61743501]
stable/4.19: [be2b6bcc936ae17f42fff6494106a5660b35d8d3]
stable/5.10: [4720d590c4cb5d9ffa0060b89743651cc7e995f9]
stable/5.15: [2f6174fd4ccf403b42b3d5f0d1b6b496a0e5330a]
stable/5.4: [024529c27c8b4b273325a169e078337c8279e229]
stable/6.1: [9ae356c627b493323e1433dcb27a26917668c07c]
stable/6.6: [c1363ed8867b81ea169fba2ccc14af96a85ed183]
stable/6.8: [03938619a1e718b6168ae4528e1b0f979293f1a5]

CVE-2024-35936: btrfs: handle chunk tree lookup error in
btrfs_relocate_sys_chunks()

Announce: https://lore.kernel.org/linux-cve-announce/2024051918-CVE-2024-35=
936-990c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.

Fixed status
cip/4.4: [98c250e5a54c630cc1977e2e1243cc6455da6097]
cip/4.4-rt: [98c250e5a54c630cc1977e2e1243cc6455da6097]
cip/4.4-st: [98c250e5a54c630cc1977e2e1243cc6455da6097]
mainline: [7411055db5ce64f836aaffd422396af0075fdc99]
stable/4.19: [bebd9e0ff90034875c5dfe4bd514fd7055fc7a89]
stable/5.10: [87299cdaae757f3f41212146cfb5b3af416b8385]
stable/5.15: [d1ffa4ae2d591fdd40471074e79954ec45f147f7]
stable/5.4: [576164bd01bd795f8b09fb194b493103506b33c9]
stable/6.1: [36c2a2863bc3896243eb724dc3fd4cf9aea633f2]
stable/6.6: [0d23b34c68c46cd225b55868bc8a269e3134816d]
stable/6.8: [1f9212cdbd005bc55f2b7422e7b560d9c02bd1da]

CVE-2024-35937: wifi: cfg80211: check A-MSDU format more carefully

Announce: https://lore.kernel.org/linux-cve-announce/2024051918-CVE-2024-35=
937-0415@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
It seems as if this bug was introduced by commit 6e4c0d0 ("wifi:
mac80211: add a workaround for receiving non-standard mesh A-MSDU") in
6.3-rc1.
This commit is not backported to older stable kernels.

Fixed status
mainline: [9ad7974856926129f190ffbe3beea78460b3b7cc]
stable/6.6: [5d7a8585fbb31e88fb2a0f581b70667d3300d1e9]
stable/6.8: [16da1e1dac23be45ef6e23c41b1508c400e6c544]

CVE-2024-35938: wifi: ath11k: decrease MHI channel buffer length to 8KB

Announce: https://lore.kernel.org/linux-cve-announce/2024051918-CVE-2024-35=
938-0100@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
The drivers/net/wireless/ath/ath11k/mhi.c was added by commit 1399fb8
("ath11k: register MHI controller device for QCA6390") in 5.10-rc1.
It seems as if this bug was introduced by commit 1399fb8.

Fixed status
mainline: [1cca1bddf9ef080503c15378cecf4877f7510015]
stable/5.15: [805a1cdde82fec00c7471a393f4bb437b2741559]
stable/6.1: [6597a6687af54e2cb58371cf8f6ee4dd85c537de]
stable/6.6: [138fdeac75fb7512a7f9f1c3b236cd2e754af793]
stable/6.8: [ae5876b3b7b2243d874e2afa099e7926122087a1]

CVE-2024-35939: dma-direct: Leak pages on dma_set_decrypted() failure

Announce: https://lore.kernel.org/linux-cve-announce/2024051919-CVE-2024-35=
939-f877@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
The vulnerable file kernel/dma/direct.c was added by commit a8463d4
("dma: Provide simple noop dma ops") in 4.6-rc1 as lib/dma-noop.c.
Linux 4.19 calls set_memory_encrypted() but it does not check return
value. Therefore 4.19 may not be affected this issue but it should
check return value.
Linux 5.10 looks to be affected this issue.

Fixed status
mainline: [b9fa16949d18e06bdf728a560f5c8af56d2bdcaf]
stable/6.1: [4e0cfb25d49da2e6261ad582f58ffa5b5dd8c8e9]
stable/6.6: [4031b72ca747a1e6e9ae4fa729e765b43363d66a]
stable/6.8: [b57326c96b7bc7638aa8c44e12afa2defe0c934c]

CVE-2024-35940: pstore/zone: Add a null pointer check to the psz_kmsg_read

Announce: https://lore.kernel.org/linux-cve-announce/2024051919-CVE-2024-35=
940-5c73@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
It seems as if this bug was introduced by commit d26c332
("pstore/zone: Introduce common layer to manage storage zones") in
5.8-rc1.

Fixed status
mainline: [98bc7e26e14fbb26a6abf97603d59532475e97f8]
stable/5.10: [98e2b97acb875d65bdfc75fc408e67975cef3041]
stable/5.15: [0ff96ec22a84d80a18d7ae8ca7eb111c34ee33bb]
stable/6.1: [635594cca59f9d7a8e96187600c34facb8bc0682]
stable/6.6: [ec7256887d072f98c42cdbef4dcc80ddf84c7a70]
stable/6.8: [6f9f2e498eae7897ba5d3e33908917f68ff4abcc]

CVE-2024-35941: net: skbuff: add overflow debug check to pull/push helpers

Announce: https://lore.kernel.org/linux-cve-announce/2024051919-CVE-2024-35=
941-1a9e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
It looks as if all stable kernels are affected.

Fixed status
mainline: [219eee9c0d16f1b754a8b85275854ab17df0850a]
stable/6.1: [8af60bb2b215f478b886f1d6d302fefa7f0b917d]
stable/6.6: [1b2b26595bb09febf14c5444c873ac4ec90a5a77]
stable/6.8: [fff05b2b004d9a8a2416d08647f3dc9068e357c8]

CVE-2024-35942: pmdomain: imx8mp-blk-ctrl: imx8mp_blk: Add fdcc clock
to hdmimix domain

Announce: https://lore.kernel.org/linux-cve-announce/2024051919-CVE-2024-35=
942-af72@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
Affected file was added by commit 556f5cf9 ("soc: imx: add i.MX8MP
HSIO blk-ctrl") in 5.19-rc1.
Setting clk_names for IMX8MP_HDMIBLK_PD_LCDIF and was added by commit
e3442022 ("soc: imx: add i.MX8MP HDMI blk-ctrl") in 5.19-rc1.

Fixed status
mainline: [697624ee8ad557ab5417f985d2c804241a7ad30d]
stable/6.6: [9d3f959b426635c4da50dfc7b1306afd84d23e7c]
stable/6.8: [b13c0d871cd878ff53d25507ca535f59ed1f6a2a]

CVE-2024-35943: pmdomain: ti: Add a null pointer check to the
omap_prm_domain_init

Announce: https://lore.kernel.org/linux-cve-announce/2024051920-CVE-2024-35=
943-93a9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
It seems as if this bug was introduced by commit 58cbff02 ("soc: ti:
omap-prm: Add basic power domain support") in5.10-rc1.

Fixed status
mainline: [5d7f58ee08434a33340f75ac7ac5071eea9673b3]
stable/6.6: [ce666cecc09c0f92d5f86d89d8068ecfcf723a7e]
stable/6.8: [04f23510daa40f9010fadf309507564a34ad956f]

CVE-2024-35944: VMCI: Fix memcpy() run-time warning in dg_dispatch_as_host(=
)

Announce: https://lore.kernel.org/linux-cve-announce/2024051920-CVE-2024-35=
944-a860@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.

Fixed status
cip/4.4: [19f360cbd4ccca796d8ad9382b37ae633cfbbe38]
cip/4.4-rt: [19f360cbd4ccca796d8ad9382b37ae633cfbbe38]
cip/4.4-st: [19f360cbd4ccca796d8ad9382b37ae633cfbbe38]
mainline: [19b070fefd0d024af3daa7329cbc0d00de5302ec]
stable/4.19: [e87bb99d2df6512d8ee37a5d63d2ca9a39a8c051]
stable/5.10: [ad78c5047dc4076d0b3c4fad4f42ffe9c86e8100]
stable/5.15: [130b0cd064874e0d0f58e18fb00e6f3993e90c74]
stable/5.4: [f15eca95138b3d4ec17b63c3c1937b0aa0d3624b]
stable/6.1: [feacd430b42bbfa9ab3ed9e4f38b86c43e348c75]
stable/6.6: [dae70a57565686f16089737adb8ac64471570f73]
stable/6.8: [491a1eb07c2bd8841d63cb5263455e185be5866f]

CVE-2024-35945: net: phy: phy_device: Prevent nullptr exceptions on ISR

Announce: https://lore.kernel.org/linux-cve-announce/2024051920-CVE-2024-35=
945-c005@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
The phy_drv_supports_irq() was added by commit 0d2e778e ("net: phy:
replace PHY_HAS_INTERRUPT with a check for config_intr and
ack_interrupt") in 5.0-rc1.
If this bug affects all stable kernels, backporting this commit is needed.

Fixed status
mainline: [61c81872815f46006982bb80460c0c80a949b35b]
stable/6.6: [7a71f61ebf95cedd3f245db6da397822971d8db5]
stable/6.8: [3419ee39e3d3162ab2ec9942bb537613ed5b6311]

CVE-2024-35946: wifi: rtw89: fix null pointer access when abort scan

Announce: https://lore.kernel.org/linux-cve-announce/2024051921-CVE-2024-35=
946-c2c2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
Added rtwdev->scanning check to rtw89_ops_bss_info_changed() was
commit 895907 ("rtw89: 8852a: add ieee80211_ops::hw_scan") in
5.18-rc1.
Added rtwdev->scanning check to rtw89_ops_remain_on_channel() was
commit ae3f332 ("wifi: rtw89: add ieee80211::remain_on_channel ops")
in 6.4-rc1.

Fixed status
mainline: [7e11a2966f51695c0af0b1f976a32d64dee243b2]
stable/6.6: [b34d64e9aa5505e3c84570aed5c757f1839573e8]
stable/6.8: [4f11c741908dab7dd48fa5a986b210d4fc74ca8d]

CVE-2024-35947: dyndbg: fix old BUG_ON in >control parser

Announce: https://lore.kernel.org/linux-cve-announce/2024051952-CVE-2024-35=
947-09bb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc7.
It looks as if Linux 4.4 is affected.

Fixed status
mainline: [00e7d3bea2ce7dac7bee1cf501fb071fd0ea8f6c]
stable/4.19: [3c718bddddca9cbef177ac475b94c5c91147fb38]
stable/5.10: [41d8ac238ab1cab01a8c71798d61903304f4e79b]
stable/5.15: [ba3c118cff7bcb0fe6aa84ae1f9080d50e31c561]
stable/5.4: [343081c21e56bd6690d342e2f5ae8c00183bf081]
stable/6.1: [a66c869b17c4c4dcf81d273b02cb0efe88e127ab]
stable/6.6: [a69e1bdd777ce51061111dc419801e8a2fd241cc]
stable/6.8: [529e1852785599160415e964ca322ee7add7aef0]

CVE-2024-35948: bcachefs: Check for journal entries overruning end of
sb clean section

Announce: https://lore.kernel.org/linux-cve-announce/2024052043-CVE-2024-35=
948-a92f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc6.
The bcachefs was introduced by commit ("bcachefs: Initial commit") in 6.7-r=
c1.

Fixed status
mainline: [fcdbc1d7a4b638e5d5668de461f320386f3002aa]

CVE-2024-35949: btrfs: make sure that WRITTEN is set on all metadata blocks

Announce: https://lore.kernel.org/linux-cve-announce/2024052045-CVE-2024-35=
949-4a64@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9.
It seems as if this bug was introduced by 732fab9 ("btrfs:
check-integrity: remove CONFIG_BTRFS_FS_CHECK_INTEGRITY option") in
6.7-rc1.

Fixed status
mainline: [e03418abde871314e1a3a550f4c8afb7b89cb273]
stable/6.8: [ef3ba8ce8cf7075b716aa4afcefc3034215878ee]

CVE-2024-35950: drm/client: Fully protect modes[] with dev->mode_config.mut=
ex

Announce: https://lore.kernel.org/linux-cve-announce/2024052015-CVE-2024-35=
950-41bf@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc4.
It looks as if 4.19 may be affected too. The drm_setup_crtcs() which
was renamed to drm_client_modeset_probe() by
commit aafa9e06 ("drm/fb-helper: Prepare to move out modeset config
code") runs same steps as drm_client_modeset_probe() does.
Linux 4.4 does not take lock in the drm_setup_crtcs().  so Linux 4.4
may not be affected.

Fixed status
mainline: [3eadd887dbac1df8f25f701e5d404d1b90fd0fea]
stable/5.10: [41586487769eede64ab1aa6c65c74cbf76c12ef0]
stable/5.15: [d2dc6600d4e3e1453e3b1fb233e9f97e2a1ae949]
stable/5.4: [5a2f957e3c4553bbb100504a1acfeaeb33f4ca4e]
stable/6.1: [18c8cc6680ce938d0458859b6a08b4d34f7d8055]
stable/6.6: [04e018bd913d3d3336ab7d21c2ad31a9175fe984]
stable/6.8: [8ceb873d816786a7c8058f50d903574aff8d3764]

CVE-2024-35951: drm/panfrost: Fix the error path in
panfrost_mmu_map_fault_addr()

Announce: https://lore.kernel.org/linux-cve-announce/2024052017-CVE-2024-35=
951-d66a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 187d292 ("drm/panfrost: Add support for GPU heap
allocations") in v5.4-rc1.
Fixed in v6.9-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1fc9af813b25e146d3607669247d0f970f5a87c3]
stable/6.6: [31806711e8a4b75e09b1c43652f2a6420e6e1002]
stable/6.8: [e18070c622c63f0cab170348e320454728c277aa]

CVE-2024-35952: drm/ast: Fix soft lockup

Announce: https://lore.kernel.org/linux-cve-announce/2024052017-CVE-2024-35=
952-645b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 594e9c0 ("drm/ast: Create the driver for ASPEED
proprietory Display-Port") in v5.19-rc1.
Fixed in v6.9-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc004f5038220b1891ef4107134ccae44be55109]
stable/6.1: [8a6fea3fcb577a543ef67683ca7105bde49a38fb]
stable/6.6: [a81b2acd43e24e419f65df97348c76a5a1496066]
stable/6.8: [35768baf0fdfc47ede42d899506bad78450e9294]

CVE-2024-35953: accel/ivpu: Fix deadlock in context_xa

Announce: https://lore.kernel.org/linux-cve-announce/2024052018-CVE-2024-35=
953-a809@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 35b1376 ("accel/ivpu: Introduce a new DRM driver
for Intel VPU") in v6.3-rc1.
Fixed in v6.9-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd7726e75968b27fe98534ccbf47ccd6fef686f3]
stable/6.6: [d43e11d9c7fcb16f18bd46ab2556c2772ffc5775]
stable/6.8: [e6011411147209bc0cc14628cbc155356837e52a]

CVE-2024-35954: scsi: sg: Avoid sg device teardown race

Announce: https://lore.kernel.org/linux-cve-announce/2024052018-CVE-2024-35=
954-cdbf@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit db59133 ("scsi: sg: fix blktrace debugfs entries
leakage") in v6.5-rc1.
Fixed in v6.9-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [27f58c04a8f438078583041468ec60597841284d]
stable/6.6: [46af9047523e2517712ae8e71d984286c626e022]
stable/6.8: [b0d1ebcc1a9560e494ea9b3ee808540db26c5086]

CVE-2024-35955: kprobes: Fix possible use-after-free issue on kprobe
registration

Announce: https://lore.kernel.org/linux-cve-announce/2024052018-CVE-2024-35=
955-2555@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 28f6c37 ("kprobes: Forbid probing on trampoline
and BPF code areas") in v6.0-rc1.
Fixed in v6.9-rc4.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt stable/4.19 stable/5.10
stable/5.15 stable/5.4

Fixed status
mainline: [325f3fb551f8cd672dbbfc4cf58b14f9ee3fc9e8]
stable/4.19: [b5808d40093403334d939e2c3c417144d12a6f33]
stable/5.10: [5062d1f4f07facbdade0f402d9a04a788f52e26d]
stable/5.15: [2df2dd27066cdba8041e46a64362325626bdfb2e]
stable/5.4: [93eb31e7c3399e326259f2caa17be1e821f5a412]
stable/6.1: [62029bc9ff2c17a4e3a2478d83418ec575413808]
stable/6.6: [d15023fb407337028a654237d8968fefdcf87c2f]
stable/6.8: [36b57c7d2f8b7de224980f1a284432846ad71ca0]

CVE-2024-35956: btrfs: qgroup: fix qgroup prealloc rsv leak in
subvolume operations

Announce: https://lore.kernel.org/linux-cve-announce/2024052018-CVE-2024-35=
956-3c25@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e85fde5 ("btrfs: qgroup: fix qgroup meta rsv leak
for subvolume operations") in v5.10-rc1.
Fixed in v6.9-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [74e97958121aa1f5854da6effba70143f051b0cd]
stable/6.6: [14431815a4ae4bcd7c7a68b6a64c66c7712d27c9]
stable/6.8: [6c95336f5d8eb9ab79cd7306d71b6d0477363f8c]

CVE-2024-35957: iommu/vt-d: Fix WARN_ON in iommu probe path

Announce: https://lore.kernel.org/linux-cve-announce/2024052019-CVE-2024-35=
957-8c83@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1a75cc7 ("iommu/vt-d: Use rbtree to track iommu
probed devices") in 6.9-rc1. Fixed in 6.9-rc4.
Bug introduced commit was backported to following branches.
stable/6.8

Fixed status
mainline: [89436f4f54125b1297aec1f466efd8acb4ec613d]
stable/6.8: [fba8ca3e6f608b92e54271fdbd3ce569361939fc]

CVE-2024-35958: net: ena: Fix incorrect descriptor free behavior

Announce: https://lore.kernel.org/linux-cve-announce/2024052019-CVE-2024-35=
958-18a7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 548c494 ("net: ena: Implement XDP_TX action") in v5.6-=
rc1.
Fixed in v6.9-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf02d9fe00632d22fa91d34749c7aacf397b6cde]
stable/5.10: [b26aa765f7437e1bbe8db4c1641b12bd5dd378f0]
stable/5.15: [fdfbf54d128ab6ab255db138488f9650485795a2]
stable/6.1: [19ff8fed3338898b70b2aad831386c78564912e1]
stable/6.6: [5c7f2240d9835a7823d87f7460d8eae9f4e504c7]
stable/6.8: [c31baa07f01307b7ae05f3ce32b89d8e2ba0cc1d]

CVE-2024-35959: net/mlx5e: Fix mlx5e_priv_init() cleanup flow

Announce: https://lore.kernel.org/linux-cve-announce/2024052019-CVE-2024-35=
959-6e06@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8bf30be ("net/mlx5e: Introduce select queue
parameters") in v5.18-rc1.
Fixed in v6.9-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ecb829459a841198e142f72fadab56424ae96519]
stable/6.1: [ad26f26abd353113dea4e8d5ebadccdab9b61e76]
stable/6.6: [f9ac93b6f3de34aa0bb983b9be4f69ca50fc70f3]
stable/6.8: [6bd77865fda662913dcb5722a66a773840370aa7]

CVE-2024-35960: net/mlx5: Properly link new fs rules into the tree

Announce: https://lore.kernel.org/linux-cve-announce/2024052020-CVE-2024-35=
960-2eaa@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 74491de ("net/mlx5: Add multi dest support") in v4.10-=
rc1.
Fixed in v6.9-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7c6782ad4911cbee874e85630226ed389ff2e453]
stable/4.19: [de0139719cdda82806a47580ca0df06fc85e0bd2]
stable/5.10: [3d90ca9145f6b97b38d0c2b6b30f6ca6af9c1801]
stable/5.15: [7aaee12b804c5e0374e7b132b6ec2158ff33dd64]
stable/5.4: [1263b0b26077b1183c3c45a0a2479573a351d423]
stable/6.1: [2e8dc5cffc844dacfa79f056dea88002312f253f]
stable/6.6: [5cf5337ef701830f173b4eec00a4f984adeb57a0]
stable/6.8: [adf67a03af39095f05d82050f15813d6f700159d]

CVE-2024-35961: net/mlx5: Register devlink first under devlink lock

Announce: https://lore.kernel.org/linux-cve-announce/2024052020-CVE-2024-35=
961-dbbf@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cf53021 ("devlink: Notify users when objects are
accessible") in v5.16-rc1.
Fixed in v6.9-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c6e77aa9dd82bc18a89bf49418f8f7e961cfccc8]
stable/6.6: [8c91c60858473731bcdaf04fda99fcbcf84420d4]
stable/6.8: [967caa3d37c078e5b95a32094657e6a4cad145f0]

CVE-2024-35962: netfilter: complete validation of user input

Announce: https://lore.kernel.org/linux-cve-announce/2024052020-CVE-2024-35=
962-e5ce@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0c83842 ("netfilter: validate user input for
expected length") in 6.9-rc3. Fixed in 6.9-rc4.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6 stable/6.8

Fixed status
mainline: [65acf6e0501ac8880a4f73980d01b5d27648b956]
stable/5.10: [cf4bc359b76144a3dd55d7c09464ef4c5f2b2b05]
stable/5.15: [97dab36e57c64106e1c8ebd66cbf0d2d1e52d6b7]
stable/6.1: [c760089aa98289b4b88a7ff5a62dd92845adf223]
stable/6.6: [89242d9584c342cb83311b598d9e6b82572eadf8]
stable/6.8: [562b7245131f6e9f1d280c8b5a8750f03edfc05c]

CVE-2024-35963: Bluetooth: hci_sock: Fix not validating setsockopt user inp=
ut

Announce: https://lore.kernel.org/linux-cve-announce/2024052021-CVE-2024-35=
963-7934@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 09572fc ("Bluetooth: hci_sock: Add support for
BT_{SND,RCV}BUF") in v5.16-rc1.
Fixed in v6.9-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b2186061d6043d6345a97100460363e990af0d46]
stable/6.8: [50173882bb187e70e37bac01385b9b114019bee2]

CVE-2024-35964: Bluetooth: ISO: Fix not validating setsockopt user input

Announce: https://lore.kernel.org/linux-cve-announce/2024052021-CVE-2024-35=
964-25e2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ccf74f2 ("Bluetooth: Add BTPROTO_ISO socket
type") in v6.0-rc1.
Introduced by commit 0731c5a ("Bluetooth: ISO: Add support for
BT_PKT_STATUS") in v6.6-rc1.
Introduced by commit f764a6c ("Bluetooth: ISO: Add broadcast support")
in v6.0-rc1.
Fixed in v6.9-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9e8742cdfc4b0e65266bb4a901a19462bda9285e]
stable/6.8: [0c4a89f4690478969729c7ba5f69d53d8516aa12]

CVE-2024-35965: Bluetooth: L2CAP: Fix not validating setsockopt user input

Announce: https://lore.kernel.org/linux-cve-announce/2024052021-CVE-2024-35=
965-19f1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 33575df ("Bluetooth: move l2cap_sock_setsockopt()
to l2cap_sock.c") in v2.6.39-rc1.
Introduced by commit 3ee7b7c ("Bluetooth: Add BT_MODE socket option")
in v5.8-rc1.
Fixed in v6.9-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f3951242ace5efc7131932e2e01e6ac6baed846]
stable/6.1: [9d42f373391211c7c8af66a3a316533a32b8a607]
stable/6.8: [8ee0c132a61df9723813c40e742dc5321824daa9]

CVE-2024-35966: Bluetooth: RFCOMM: Fix not validating setsockopt user input

Announce: https://lore.kernel.org/linux-cve-announce/2024052021-CVE-2024-35=
966-e107@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9f2c8a0 ("Bluetooth: Replace RFCOMM link mode
with security level") in v2.6.30-rc1.
Introduced by commit bb23c0a ("Bluetooth: Add support for deferring
RFCOMM connection setup") in v2.6.30-rc1.
Fixed in v6.9-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a97de7bff13b1cc825c1b1344eaed8d6c2d3e695]
stable/6.8: [c3f787a3eafe519c93df9abbb0ca5145861c8d0f]

CVE-2024-35967: Bluetooth: SCO: Fix not validating setsockopt user input

Announce: https://lore.kernel.org/linux-cve-announce/2024052022-CVE-2024-35=
967-d111@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ad10b1a ("Bluetooth: Add Bluetooth socket voice
option") in v3.12-rc1.
Introduced by commit b96e9c6 ("Bluetooth: Add BT_DEFER_SETUP option to
sco socket") in v3.8-rc1.
Introduced by commit 00398e1 ("Bluetooth: Add support for
BT_PKT_STATUS CMSG data for SCO connections") in v5.9-rc1.
Introduced by commit f687340 ("Bluetooth: Allow setting of codec for
HFP offload use case") in v5.16-rc1.
Fixed in v6.9-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [51eda36d33e43201e7a4fd35232e069b2c850b01]
stable/5.10: [b0e30c37695b614bee69187f86eaf250e36606ce]
stable/6.1: [7bc65d23ba20dcd7ecc094a12c181e594e5eb315]
stable/6.6: [72473db90900da970a16ee50ad23c2c38d107d8c]
stable/6.8: [419a0ffca7010216f0fc265b08558d7394fa0ba7]

CVE-2024-35968: pds_core: Fix pdsc_check_pci_health function to use work th=
read

Announce: https://lore.kernel.org/linux-cve-announce/2024052022-CVE-2024-35=
968-80ae@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d9407ff ("pds_core: Prevent health thread from
running during reset/remove") in v6.8-rc3.
Fixed in v6.9-rc4.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [81665adf25d28a00a986533f1d3a5df76b79cad9]
stable/6.8: [38407914d48273d7f8ab765b9243658afe1c3ab6]

CVE-2024-35969: ipv6: fix race condition between ipv6_get_ifaddr and
ipv6_del_addr

Announce: https://lore.kernel.org/linux-cve-announce/2024052022-CVE-2024-35=
969-4a04@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5c578ae ("IPv6: convert addrconf hash list to
RCU") in v2.6.35-rc1.
Fixed in v6.9-rc4.

Fixed status
cip/4.4: [648afb4faf34b14ba4dde5a9eb77451af9a2cfb4]
cip/4.4-rt: [648afb4faf34b14ba4dde5a9eb77451af9a2cfb4]
cip/4.4-st: [648afb4faf34b14ba4dde5a9eb77451af9a2cfb4]
mainline: [7633c4da919ad51164acbf1aa322cc1a3ead6129]
stable/4.19: [b4b3b69a19016d4e7fbdbd1dbcc184915eb862e1]
stable/5.10: [3fb02ec57ead2891a2306af8c51a306bc5945e70]
stable/5.15: [4b19e9507c275de0cfe61c24db69179dc52cf9fb]
stable/5.4: [cca606e14264098cba65efa82790825dbf69e903]
stable/6.1: [de76ae9ea1a6cf9e77fcec4f2df2904e26c23ceb]
stable/6.6: [01b11a0566670612bd464a932e5ac2eae53d8652]
stable/6.8: [6cdb20c342cd0193d3e956e3d83981d0f438bb83]

CVE-2024-35970: af_unix: Clear stale u->oob_skb.

Announce: https://lore.kernel.org/linux-cve-announce/2024052023-CVE-2024-35=
970-2b77@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 314001f ("af_unix: Add OOB support") in v5.15-rc1.
Fixed in v6.9-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b46f4eaa4f0ec38909fb0072eea3aeddb32f954e]
stable/5.15: [b4bc99d04c689b5652665394ae8d3e02fb754153]
stable/6.1: [84a352b7eba1142a95441380058985ff19f25ec9]
stable/6.6: [601a89ea24d05089debfa2dc896ea9f5937ac7a6]
stable/6.8: [698a95ade1a00e6494482046902b986dfffd1caf]

CVE-2024-35971: net: ks8851: Handle softirqs at the end of IRQ thread
to fix hang

Announce: https://lore.kernel.org/linux-cve-announce/2024052023-CVE-2024-35=
971-fb84@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 797047f ("net: ks8851: Implement Parallel bus
operations") in v5.8-rc1.
Fixed in v6.9-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be0384bf599cf1eb8d337517feeb732d71f75a6f]
stable/6.1: [492337a4fbd1421b42df684ee9b34be2a2722540]
stable/6.6: [cba376eb036c2c20077b41d47b317d8218fe754f]
stable/6.8: [49d5d70538b6b8f2a3f8f1ac30c1f921d4a0929b]

CVE-2024-35972: bnxt_en: Fix possible memory leak in bnxt_rdma_aux_device_i=
nit()

Announce: https://lore.kernel.org/linux-cve-announce/2024052023-CVE-2024-35=
972-138d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3034322 ("bnxt_en: Remove runtime interrupt
vector allocation") in v6.3-rc1.
Fixed in v6.9-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ac10c7d728d75bc9daaa8fade3c7a3273b9a9ff]
stable/6.6: [c60ed825530b8c0cc2b524efd39b1d696ec54004]
stable/6.8: [10a9d6a7513f93d7faffcb341af0aa42be8218fe]

CVE-2024-35973: geneve: fix header validation in geneve[6]_xmit_skb

Announce: https://lore.kernel.org/linux-cve-announce/2024052024-CVE-2024-35=
973-1b5b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d13f048 ("net: geneve: modify IP header check in
geneve6_xmit_skb and geneve_xmit_skb") in v5.13-rc1.
Fixed in v6.9-rc4.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt stable/4.19 stable/5.10 stable/5.=
4

Fixed status
mainline: [d8a6213d70accb403b82924a1c229e733433a5ef]
stable/4.19: [43be590456e1f3566054ce78ae2dbb68cbe1a536]
stable/5.10: [10204df9beda4978bd1d0c2db0d8375bfb03b915]
stable/5.15: [3c1ae6de74e3d2d6333d29a2d3e13e6094596c79]
stable/5.4: [d3adf11d7993518a39bd02b383cfe657ccc0023c]
stable/6.1: [4a1b65d1e55d53b397cb27014208be1e04172670]
stable/6.6: [190d9efa5773f26d6f334b1b8be282c4fa13fd5e]
stable/6.8: [357163fff3a6e48fe74745425a32071ec9caf852]

CVE-2024-35974: block: fix q->blkg_list corruption during disk rebind

Announce: https://lore.kernel.org/linux-cve-announce/2024052024-CVE-2024-35=
974-7008@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f1c006f ("blk-cgroup: synchronize pd_free_fn()
from blkg_free_workfn() and blkcg_deactivate_policy()") in v6.3-rc1.
Introduced by commit 1059699 ("block: move blkcg
initialization/destroy into disk allocation/release handler") in
v5.18-rc1.
Fixed in v6.9-rc4.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [8b8ace080319a866f5dfe9da8e665ae51d971c54]
stable/6.6: [740ffad95ca8033bd6e080ed337655b13b4d38ac]
stable/6.8: [858c489d81d659af17a4d11cfaad2afb42e47a76]

CVE-2024-35975: octeontx2-pf: Fix transmit scheduler resource leak

Announce: https://lore.kernel.org/linux-cve-announce/2024052024-CVE-2024-35=
975-1696@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 47a9656 ("octeontx2-pf: htb offload support for
Round Robin scheduling") in v6.6-rc1.
Fixed in v6.9-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bccb798e07f8bb8b91212fe8ed1e421685449076]
stable/6.6: [7af5582ea67209a23e44be9a9612ba7897be1f47]
stable/6.8: [b34fe77a1b18654233e4e54b334fcaeddf487100]

CVE-2024-35976: xsk: validate user input for XDP_{UMEM|COMPLETION}_FILL_RIN=
G

Announce: https://lore.kernel.org/linux-cve-announce/2024052024-CVE-2024-35=
976-339b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 423f383 ("xsk: add umem fill queue support and
mmap") in v4.18-rc1.
Fixed in v6.9-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [237f3cf13b20db183d3706d997eedc3c49eacd44]
stable/5.10: [a82984b3c6a7e8c7937dba6e857ddf829d149417]
stable/5.15: [f0a068de65d5b7358e9aff792716afa9333f3922]
stable/6.1: [2a523f14a3f53b46ff0e1fafd215b0bc5f6783aa]
stable/6.6: [b143e19dc28c3211f050f7848d87d9b0a170e10c]
stable/6.8: [2eb979fbb2479bcd7e049f2f9978b6590dd8a0e6]

CVE-2024-35977: platform/chrome: cros_ec_uart: properly fix race condition

Announce: https://lore.kernel.org/linux-cve-announce/2024052025-CVE-2024-35=
977-5edd@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 01f95d4 ("platform/chrome: cros_ec_uart: fix race
condition") in v6.3-rc1.
Fixed in v6.9-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5e700b384ec13f5bcac9855cb28fcc674f1d3593]
stable/6.6: [cfd758041d8b79aa8c3f811b6bd6105379f2f702]
stable/6.8: [9e9bb74a93b7daa32313ccaefd0edc529d40daf8]

CVE-2024-35978: Bluetooth: Fix memory leak in hci_req_sync_complete()

Announce: https://lore.kernel.org/linux-cve-announce/2024052025-CVE-2024-35=
978-adaa@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f60cb30 ("Bluetooth: Convert hci_req_sync family
of function to new request API") in v4.1-rc1.
Fixed in v6.9-rc4.

Fixed status
mainline: [45d355a926ab40f3ae7bc0b0a00cb0e3e8a5a810]
stable/4.19: [89a32741f4217856066c198a4a7267bcdd1edd67]
stable/5.10: [8478394f76c748862ef179a16f651f752bdafaf0]
stable/5.15: [75193678cce993aa959e7764b6df2f599886dd06]
stable/5.4: [4beab84fbb50df3be1d8f8a976e6fe882ca65cb2]
stable/6.1: [66fab1e120b39f8f47a94186ddee36006fc02ca8]
stable/6.6: [9ab5e44b9bac946bd49fd63264a08cd1ea494e76]
stable/6.8: [e4cb8382fff6706436b66eafd9c0ee857ff0a9f5]

CVE-2024-35979: raid1: fix use-after-free for original bio in
raid1_write_request()

Announce: https://lore.kernel.org/linux-cve-announce/2024052025-CVE-2024-35=
979-2618@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 992db13 ("md/raid1: free the r1bio before waiting
for blocked rdev") in v6.6-rc1.
Fixed in v6.9-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fcf3f7e2fc8a53a6140beee46ec782a4c88e4744]
stable/6.6: [3f28d49a328fe20926995d5fbdc92da665596268]
stable/6.8: [f423f41b7679c09abb26d2bd54be5cbef23c9446]

CVE-2024-35980: arm64: tlb: Fix TLBI RANGE operand

Announce: https://lore.kernel.org/linux-cve-announce/2024052026-CVE-2024-35=
980-7f0c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 117940a ("KVM: arm64: Define
kvm_tlb_flush_vmid_range()") in v6.6-rc1.
Fixed in v6.9-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3ba51ab24fddef79fc212f9840de54db8fd1685]
stable/6.6: [ac4ad513de4fba18b4ac0ace132777d0910e8cfa]
stable/6.8: [944db7b536baaf49d7e576af36a94f4719552b07]

CVE-2024-35981: virtio_net: Do not send RSS key if it is not supported

Announce: https://lore.kernel.org/linux-cve-announce/2024052026-CVE-2024-35=
981-2fb9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c7114b1 ("drivers/net/virtio_net: Added basic RSS
support.") in v5.18-rc1.
Fixed in v6.9-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [059a49aa2e25c58f90b50151f109dd3c4cdb3a47]
stable/6.1: [539a2b995a4ed93125cb0efae0f793b00ab2158b]
stable/6.6: [43a71c1b4b3a6d4db857b1435d271540279fc7de]
stable/6.8: [28e9a64638cd16bc1ecac9ff74ffeacb9fb652de]

CVE-2024-35982: batman-adv: Avoid infinite loop trying to resize local TT

Announce: https://lore.kernel.org/linux-cve-announce/2024052026-CVE-2024-35=
982-aeed@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a19d3d8 ("batman-adv: limit local translation
table max size") in v3.13-rc1.
Fixed in v6.9-rc4.

Fixed status
cip/4.4: [bd13b6a0972d5ac9179ae0c212e521ab6eec4fda]
cip/4.4-rt: [bd13b6a0972d5ac9179ae0c212e521ab6eec4fda]
cip/4.4-st: [bd13b6a0972d5ac9179ae0c212e521ab6eec4fda]
mainline: [b1f532a3b1e6d2e5559c7ace49322922637a28aa]
stable/4.19: [04720ea2e6c64459a90ca28570ea78335eccd924]
stable/5.10: [70a8be9dc2fb65d67f8c1e0c88c587e08e2e575d]
stable/5.15: [87b6af1a7683e021710c08fc0551fc078346032f]
stable/5.4: [b3ddf6904073990492454b1dd1c10a24be8c74c6]
stable/6.1: [3fe79b2c83461edbbf86ed8a6f3924820ff89259]
stable/6.6: [4ca2a5fb54ea2cc43edea614207fcede562d91c2]
stable/6.8: [ca54e2671548616ad34885f90d4f26f7adb088f0]

CVE-2024-35983: bounds: Use the right number of bits for power-of-two
CONFIG_NR_CPUS

Announce: https://lore.kernel.org/linux-cve-announce/2024052018-CVE-2024-35=
983-a607@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f2d5dcb (bounds: support non-power-of-two
CONFIG_NR_CPUS) in 6.9-rc1. Fixed in 6.9-rc7.
Bug introduced commit was backported to following branches.
cip/5.10 cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/5.4
stable/6.1 stable/6.6 stable/6.8

Fixed status
mainline: [5af385f5f4cddf908f663974847a4083b2ff2c79]
stable/5.10: [66297b2ceda841f809637731d287bda3a93b49d8]
stable/5.15: [93ba36238db6a74a82feb3dc476e25ea424ad630]
stable/5.4: [d34a516f2635090d36a306f84573e8de3d7374ce]
stable/6.1: [9b7c5004d7c5ae062134052a85290869a015814c]
stable/6.6: [15aa09d6d84629eb5296de30ac0aa19a33512f16]
stable/6.8: [ebfe41889b762f1933c6762f6624b9724a25bee0]

CVE-2024-35984: i2c: smbus: fix NULL function pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024052018-CVE-2024-35=
984-d72b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4b1acc4 ("i2c: core changes for slave support")
in v3.19-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [91811a31b68d3765b3065f4bb6d7d6d84a7cfc9f]
stable/4.19: [40f1d79f07b49c8a64a861706e5163f2db4bd95d]
stable/5.10: [5fd72404587d7db4acb2d241fd8c387afb0a7aec]
stable/5.15: [5a09eae9a7db597fe0c1fc91636205b4a25d2620]
stable/5.4: [ad3c3ac7a03be3697114f781193dd3e9d97e6e23]
stable/6.1: [4e75e222d397c6752b229ed72fc4644c8c36ecde]
stable/6.6: [e3425674ff68dc521c57c6eabad0cbd20a027d85]
stable/6.8: [357c64ef1ef39b1e7cd91ab6bdd304d043702c83]

CVE-2024-35985: sched/eevdf: Prevent vlag from going out of bounds in
reweight_eevdf()

Announce: https://lore.kernel.org/linux-cve-announce/2024052018-CVE-2024-35=
985-8839@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit eab03c2 ("sched/eevdf: Fix vruntime adjustment on
reweight") in v6.7-rc2.
Fixed in v6.9-rc6.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [1560d1f6eb6b398bddd80c16676776c0325fe5fe]
stable/6.6: [470d347b14b0ecffa9b39cf8f644fa2351db3efb]
stable/6.8: [06f27e6d7bf0abf54488259ef36bbf0e1fccb35c]

CVE-2024-35986: phy: ti: tusb1210: Resolve charger-det crash if
charger psy is unregistered

Announce: https://lore.kernel.org/linux-cve-announce/2024052019-CVE-2024-35=
986-c76f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 48969a5 ("phy: ti: tusb1210: Add charger
detection") in v5.18-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf6e4ee5c43690e4c5a8a057bbcd4ff986bed052]
stable/6.1: [25b3498485ac281e5851700e33b97f12c9533fd8]
stable/6.6: [73224a5d2180066c7fe05b4656647601ba08d588]
stable/6.8: [9827caa5105fb16d1fae2e75c8d0e4662014b3ca]

CVE-2024-35987: riscv: Fix loading 64-bit NOMMU kernels past the start of R=
AM

Announce: https://lore.kernel.org/linux-cve-announce/2024052019-CVE-2024-35=
987-c5e7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3335068 ("riscv: Use PUD/P4D/PGD pages for the
linear mapping") in v6.4-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aea702dde7e9876fb00571a2602f25130847bf0f]
stable/6.6: [b008e327fa570aca210f98c817757649bae56694]
stable/6.8: [ea6628e4e2353978af7e3b4ad4fdaab6149acf3d]

CVE-2024-35988: riscv: Fix TASK_SIZE on 64-bit NOMMU

Announce: https://lore.kernel.org/linux-cve-announce/2024052019-CVE-2024-35=
988-22a1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6bd33e1 ("riscv: add nommu support") in v5.5-rc1.
Introduced by commit c3f896d ("mm: switch the test_vmalloc module to
use __vmalloc_node") in v5.8-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6065e736f82c817c9a597a31ee67f0ce4628e948]
stable/5.10: [04bf2e5f95c1a52e28a7567a507f926efe31c3b6]
stable/5.15: [52e8a42b11078d2aad4b9ba96503d77c7299168b]
stable/6.1: [4201b8c8f2c32af321fb50867e68ac6c1cbed4be]
stable/6.6: [a0f0dbbb1bc49fa0de18e92c36492ff6d804cdaa]
stable/6.8: [efdcfa554b6eb228943ef1dd4d023c606be647d2]

CVE-2024-35989: dmaengine: idxd: Fix oops during rmmod on single-CPU platfo=
rms

Announce: https://lore.kernel.org/linux-cve-announce/2024052020-CVE-2024-35=
989-c5da@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 81dd4d4 ("dmaengine: idxd: Add IDXD performance
monitor support") in v5.13-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f221033f5c24659dc6ad7e5cf18fb1b075f4a8be]
stable/5.15: [9edd3aa34d50f27b97be30b2ba4a6af0945ff56b]
stable/6.1: [023b6390a15a98f9c3aa5e7da78d485d5384a08e]
stable/6.6: [f976eca36cdf94e32fa4f865db0e7c427c9aa33c]
stable/6.8: [47533176fdcef17b114a6f688bc872901c1ec6bb]

CVE-2024-35990: dma: xilinx_dpdma: Fix locking

Announce: https://lore.kernel.org/linux-cve-announce/2024052020-CVE-2024-35=
990-9e74@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7cbb0c6 ("dmaengine: xilinx: dpdma: Add the
Xilinx DisplayPort DMA engine driver") in v5.9-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [244296cc3a155199a8b080d19e645d7d49081a38]
stable/5.10: [fcdd5bb4a8c81c64c1334d7e0aba41a8829a24de]
stable/5.15: [0ccac964520a6f19e355652c8ca38af2a7f27076]
stable/6.1: [8bf574183282d219cfa991f7df37aad491d74c11]
stable/6.6: [8e3c94767cad5150198e4337c8b91f3bb068e14b]
stable/6.8: [c660be571609e03e7d5972343536a736fcb31557]

CVE-2024-35991: dmaengine: idxd: Convert spinlock to mutex to lock evl work=
queue

Announce: https://lore.kernel.org/linux-cve-announce/2024052020-CVE-2024-35=
991-5f06@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c40bd7d ("dmaengine: idxd: process user page
faults for completion record") in v6.4-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d5638de827cff0fce77007e426ec0ffdedf68a44]
stable/6.6: [758071a35d9f3ffd84ff12169d081412a2f5f098]
stable/6.8: [c9b732a9f73eadc638abdcf0a6d39bc7a0c1af5f]

CVE-2024-35992: phy: marvell: a3700-comphy: Fix out of bounds read

Announce: https://lore.kernel.org/linux-cve-announce/2024052020-CVE-2024-35=
992-2e88@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9343370 ("phy: marvell: phy-mvebu-a3700-comphy:
Add native kernel implementation") in v5.18-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e4308bc22b9d46cf33165c9dfaeebcf29cd56f04]
stable/6.1: [976df695f579bbb2914114b4e9974fe4ed1eb813]
stable/6.6: [610f175d2e16fb2436ba7974b990563002c20d07]
stable/6.8: [40406dfbc060503d2e0a9e637e98493c54997b3d]

CVE-2024-35993: mm: turn folio_test_hugetlb into a PageType

Announce: https://lore.kernel.org/linux-cve-announce/2024052021-CVE-2024-35=
993-0309@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9c5ccf2 ("mm: remove HUGETLB_PAGE_DTOR") in v6.6-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d99e3140a4d33e26066183ff727d8f02f56bec64]
stable/6.6: [2431b5f2650dfc47ce782d1ca7b02d6b3916976f]
stable/6.8: [9fdcc5b6359dfdaa52a55033bf50e2cedd66eb32]

CVE-2024-35994: firmware: qcom: uefisecapp: Fix memory related IO
errors and crashes

Announce: https://lore.kernel.org/linux-cve-announce/2024052021-CVE-2024-35=
994-d606@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 759e7a2 ("firmware: Add support for Qualcomm UEFI
Secure Application") in v6.7-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ed09f81eeaa8f9265e1787282cb283f10285c259]
stable/6.8: [dd22b34fb53cb04b13b2f5eee5c9200bb091fc88]

CVE-2024-35995: ACPI: CPPC: Use access_width over bit_width for system
memory accesses

Announce: https://lore.kernel.org/linux-cve-announce/2024052021-CVE-2024-35=
995-abbc@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.

Fixed status
mainline: [2f4a4d63a193be6fd530d180bb13c3592052904c]
stable/5.15: [6dfd79ed04c578f1d9a9a41ba5b2015cf9f03fc3]
stable/6.1: [01fc53be672acae37e611c80cc0b4f3939584de3]
stable/6.6: [1b890ae474d19800a6be1696df7fb4d9a41676e4]
stable/6.8: [6cb6b12b78dcd8867a3fdbb1b6d0ed1df2b208d1]

CVE-2024-35996: cpu: Re-enable CPU mitigations by default for !X86 architec=
tures

Announce: https://lore.kernel.org/linux-cve-announce/2024052022-CVE-2024-35=
996-3f86@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f337a6a ("x86/cpu: Actually turn off mitigations
by default for SPECULATION_MITIGATIONS=3Dn") in 6.9-rc4. Fixed in
6.9-rc6.
Bug introduced commit was backported to following branches.
cip/5.10 cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1
stable/6.6 stable/6.8

Fixed status
mainline: [fe42754b94a42d08cf9501790afc25c4f6a5f631]
stable/5.10: [af6d6a923b40bf6471e44067ac61cc5814b48e7f]
stable/5.15: [af6d6a923b40bf6471e44067ac61cc5814b48e7f]
stable/6.1: [36b32816fbab267611f073223f1b0b816ec5920f]
stable/6.6: [38f17d1fbb5bfb56ca1419e2d06376d57a9396f9]
stable/6.8: [8292f4f8dd1b005d0688d726261004f816ef730a]

CVE-2024-35997: HID: i2c-hid: remove I2C_HID_READ_PENDING flag to
prevent lock-up

Announce: https://lore.kernel.org/linux-cve-announce/2024052022-CVE-2024-35=
997-1a3c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4a200c3 ("HID: i2c-hid: introduce HID over i2c
specification implementation") in v3.8-rc1.
Fixed in v6.9-rc6.

Fixed status
cip/4.4: [9c0fa2c42f71b0fb251c443e04acbbd6679ea28c]
cip/4.4-rt: [9c0fa2c42f71b0fb251c443e04acbbd6679ea28c]
cip/4.4-st: [9c0fa2c42f71b0fb251c443e04acbbd6679ea28c]
mainline: [9c0f59e47a90c54d0153f8ddc0f80d7a36207d0e]
stable/4.19: [21bfca822cfc1e71796124e93b46e0d9fa584401]
stable/5.10: [5095b93021b899f54c9355bebf36d78854c33a22]
stable/5.15: [b65fb50e04a95eec34a9d1bc138454a98a5578d8]
stable/5.4: [c448a9fd50f77e8fb9156ff64848aa4295eb3003]
stable/6.1: [0561b65fbd53d3e788c5b0222d9112ca016fd6a1]
stable/6.6: [29e94f295bad5be59cf4271a93e22cdcf5536722]
stable/6.8: [418c5575d56410c6e186ab727bf32ae32447d497]

CVE-2024-35998: smb3: fix lock ordering potential deadlock in
cifs_sync_mid_result

Announce: https://lore.kernel.org/linux-cve-announce/2024052022-CVE-2024-35=
998-96a4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc6.
It looks as if Linux 4.4 may not be affected.

Fixed status
mainline: [8861fd5180476f45f9e8853db154600469a0284f]
stable/6.1: [c7a4bca289e50bb4b2650f845c41bb3e453f4c66]
stable/6.6: [699f8958dece132709c0bff6a9700999a2a63b75]
stable/6.8: [8248224ab5b8ca7559b671917c224296a4d671fc]

CVE-2024-35999: smb3: missing lock when picking channel

Announce: https://lore.kernel.org/linux-cve-announce/2024052023-CVE-2024-35=
999-da29@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc6.
It seems as if this bug was introduced by commit f486ef8 ("cifs: use
the chans_need_reconnect bitmap for reconnect status") in 5.17-rc1.

Fixed status
mainline: [8094a600245e9b28eb36a13036f202ad67c1f887]
stable/6.1: [98c7ed29cd754ae7475dc7cb3f33399fda902729]
stable/6.6: [0fcf7e219448e937681216353c9a58abae6d3c2e]
stable/6.8: [60ab245292280905603bc0d3654f4cf8fceccb00]

CVE-2024-36000: mm/hugetlb: fix missing hugetlb_lock for resv uncharge

Announce: https://lore.kernel.org/linux-cve-announce/2024052023-CVE-2024-36=
000-cfc4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 79aa925 ("hugetlb_cgroup: fix reservation
accounting") in v5.10-rc3.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b76b46902c2d0395488c8412e1116c2486cdfcb2]
stable/6.1: [4c806333efea1000a2a9620926f560ad2e1ca7cc]
stable/6.6: [f6c5d21db16a0910152ec8aa9d5a7aed72694505]
stable/6.8: [538faabf31e9c53d8c870d114846fda958a0de10]

CVE-2024-36001: netfs: Fix the pre-flush when appending to a file in
writethrough mode

Announce: https://lore.kernel.org/linux-cve-announce/2024052023-CVE-2024-36=
001-e6a9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 41d8e76 ("netfs: Implement a write-through
caching option") in v6.8-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c97f59e276d4e93480f29a70accbd0d7273cf3f5]
stable/6.8: [5eaf23b2e81349f6614f88396dc468fda89fc0b9]

CVE-2024-36002: dpll: fix dpll_pin_on_pin_register() for multiple parent pi=
ns

Announce: https://lore.kernel.org/linux-cve-announce/2024052023-CVE-2024-36=
002-c5bc@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b446631 ("dpll: fix dpll_xa_ref_*_del() for
multiple registrations") in 6.9-rc1. Fixed in 6.9-rc6.
Bug introduced commit was backported to following branches.
stable/6.8

Fixed status
mainline: [38d7b94e81d068b8d8c8392f421cfd2c3bbfd1a6]
stable/6.8: [f3e1cf62d18220a3aa97e084e7a3552debece9fc]

CVE-2024-36003: ice: fix LAG and VF lock dependency in ice_reset_vf()

Announce: https://lore.kernel.org/linux-cve-announce/2024052024-CVE-2024-36=
003-33b4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9f74a3d ("ice: Fix VF Reset paths when interface
in a failed over aggregate") in v6.7-rc4.
Fixed in v6.9-rc6.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [96fdd1f6b4ed72a741fb0eb705c0e13049b8721f]
stable/6.6: [740717774dc37338404d10726967d582414f638c]
stable/6.8: [de8631d8c9df08440268630200e64b623a5f69e6]

CVE-2024-36004: i40e: Do not use WQ_MEM_RECLAIM flag for workqueue

Announce: https://lore.kernel.org/linux-cve-announce/2024052024-CVE-2024-36=
004-fb45@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4d5957c ("i40e: remove WQ_UNBOUND and the task
limit of our workqueue") in v4.14-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2cc7d150550cc981aceedf008f5459193282425c]
stable/4.19: [09b54d29f05129b092f7c793a70b689ffb3c7b2c]
stable/5.10: [fbbb2404340dd6178e281bd427c271f7d5ec1d22]
stable/5.15: [ff7431f898dd00892a545b7d0ce7adf5b926944f]
stable/5.4: [546d0fe9d76e8229a67369f9cb61e961d99038bd]
stable/6.1: [152ed360cf2d273f88fc99a518b7eb868aae2939]
stable/6.6: [8d6105f637883c8c09825e962308c06e977de4f0]
stable/6.8: [1594dac8b1ed78f9e75c263327e198a2e5e25b0e]

CVE-2024-36005: netfilter: nf_tables: honor table dormant flag from
netdev release event path

Announce: https://lore.kernel.org/linux-cve-announce/2024052024-CVE-2024-36=
005-2336@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d54725c ("netfilter: nf_tables: support for
multiple devices per netdev hook") in v5.5-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e30abc9ace4f0add4cd761dfdbfaebae5632dd2]
stable/5.10: [e4bb6da24de336a7899033a65490ed2d892efa5b]
stable/5.15: [5c45feb3c288cf44a529e2657b36c259d86497d2]
stable/6.1: [13ba94f6cc820fdea15efeaa17d4c722874eebf9]
stable/6.6: [8260c980aee7d8d8a3db39faf19c391d2f898816]
stable/6.8: [ca34c40d1c22c555fa7f4a21a1c807fea7290a0a]

CVE-2024-36006: mlxsw: spectrum_acl_tcam: Fix incorrect list API usage

Announce: https://lore.kernel.org/linux-cve-announce/2024052025-CVE-2024-36=
006-c032@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6f9579d ("mlxsw: spectrum_acl: Remember where to
continue rehash migration") in v5.1-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b377add0f0117409c418ddd6504bd682ebe0bf79]
stable/5.10: [09846c2309b150b8ce4e0ce96f058197598fc530]
stable/5.15: [64435b64e43d8ee60faa46c0cd04e323e8b2a7b0]
stable/5.4: [0b2c13b670b168e324e1cf109e67056a20fd610a]
stable/6.1: [4526a56e02da3725db979358964df9cd9c567154]
stable/6.6: [ab4ecfb627338e440ae11def004c524a00d93e40]
stable/6.8: [af8b593c3dd9df82cb199be65863af004b09fd97]

CVE-2024-36007: mlxsw: spectrum_acl_tcam: Fix warning during rehash

Announce: https://lore.kernel.org/linux-cve-announce/2024052025-CVE-2024-36=
007-052e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6f9579d ("mlxsw: spectrum_acl: Remember where to
continue rehash migration") in v5.1-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [743edc8547a92b6192aa1f1b6bb78233fa21dc9b]
stable/5.10: [1d76bd2a0034d0d08045c1c6adf2235d88982952]
stable/5.15: [039992b6d2df097c65f480dcf269de3d2656f573]
stable/5.4: [0b88631855026b55cad901ac28d081e0f358e596]
stable/6.1: [751d352858108314efd33dddd5a9a2b6bf7d6916]
stable/6.6: [e890456051fe8c57944b911defb3e6de91315861]
stable/6.8: [17e9e0bbae652b9b2049e51699e93dfa60b2988d]

CVE-2024-36008: ipv4: check for NULL idev in ip_route_use_hint()

Announce: https://lore.kernel.org/linux-cve-announce/2024052025-CVE-2024-36=
008-0637@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 02b2494 ("ipv4: use dst hint for ipv4 list
receive") in v5.5-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [58a4c9b1e5a3e53c9148e80b90e1e43897ce77d1]
stable/5.10: [7da0f91681c4902bc5c210356fdd963b04d5d1d4]
stable/5.15: [03b5a9b2b526862b21bcc31976e393a6e63785d1]
stable/6.1: [7a25bfd12733a8f38f8ca47c581f876c3d481ac0]
stable/6.6: [8240c7308c941db4d9a0a91b54eca843c616a655]
stable/6.8: [c71ea3534ec0936fc57e6fb271c7cc6a2f68c295]

CVE-2024-36009: ax25: Fix netdev refcount issue

Announce: https://lore.kernel.org/linux-cve-announce/2024052026-CVE-2024-36=
009-f213@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit feef318 ("ax25: fix UAF bugs of net_device caused
by rebinding operation") in v5.17-rc4.
Fixed in v6.9-rc6.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt stable/4.19 stable/5.10
stable/5.15 stable/5.4

Fixed status
mainline: [467324bcfe1a31ec65d0cf4aa59421d6b7a7d52b]
stable/6.1: [0d14f104027e30720582448706c7d6b43065c851]
stable/6.6: [4fee8fa86a15d7790268eea458b1aec69c695530]
stable/6.8: [c42b073d9af4a5329b25b17390c63ab3847f30e8]

CVE-2020-36788: drm/nouveau: avoid a use-after-free when BO init fails

Announce: https://lore.kernel.org/linux-cve-announce/2024052134-CVE-2020-36=
788-06ab@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 019cbd4 ("drm/nouveau: Initialize GEM object
before TTM object") in v5.4-rc1.
Fixed in v5.15-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bcf34aa5082ee2343574bc3f4d1c126030913e54]
stable/5.10: [f86e19d918a85492ad1a01fcdc0ad5ecbdac6f96]

CVE-2021-47220: usb: dwc3: core: fix kernel panic when do reboot

Announce: https://lore.kernel.org/linux-cve-announce/2024052133-CVE-2021-47=
220-cece@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8d396bb ("usb: dwc3: debugfs: Add and remove
endpoint dirs dynamically") in 5.13-rc6. Fixed in 5.13-rc7.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt stable/4.19 stable/5.10 stable/5.=
4

Fixed status
mainline: [4bf584a03eec674975ee9fe36c8583d9d470dab1]
stable/4.19: [7f9745ab342bcce5efd5d4d2297d0a3dd9db0eac]
stable/5.10: [174c27583b3807ac96228c442735b02622d8d1c3]
stable/5.4: [fd7c4bd582494934be15d41aebe0dbe23790605f]

CVE-2021-47221: mm/slub: actually fix freelist pointer vs redzoning

Announce: https://lore.kernel.org/linux-cve-announce/2024052135-CVE-2021-47=
221-4e17@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 89b83f2 (slub: avoid redzone when choosing
freepointer location) in v5.7-rc3.
Fixed in v5.13-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e41a49fadbc80b60b48d3c095d9e2ee7ef7c9a8e]
stable/5.10: [f6ed2357541612a13a5841b3af4dc32ed984a25f]

CVE-2021-47222: net: bridge: fix vlan tunnel dst refcnt when egressing

Announce: https://lore.kernel.org/linux-cve-announce/2024052136-CVE-2021-47=
222-f01c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 11538d0 ("bridge: vlan dst_metadata hooks in
ingress and egress paths") in v4.11-rc1.
Fixed in v5.13-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cfc579f9d89af4ada58c69b03bcaa4887840f3b3]
stable/4.19: [84fc1c944e45ab317e2e70a0e7f76fa2a5e43b6e]
stable/5.10: [fc7fdd8c5c2ad2fe3e297698be9d4dbe4a4e0579]
stable/5.4: [79855be6445b6592bddb7bd7167083ec8cdbd73f]

CVE-2021-47223: net: bridge: fix vlan tunnel dst null pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024052136-CVE-2021-47=
223-149e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 11538d0 ("bridge: vlan dst_metadata hooks in
ingress and egress paths") in v4.11-rc1.
Fixed in v5.13-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [58e2071742e38f29f051b709a5cca014ba51166f]
stable/4.19: [24a6e55f17aa123bc1fc54b7d3c410b41bc16530]
stable/5.10: [fe0448a3fad365a747283a00a1d1ad5e8d6675b7]
stable/5.4: [a2241e62f6b4a774d8a92048fdf59c45f6c2fe5c]

CVE-2021-47224: net: ll_temac: Make sure to free skb when it is completely =
used

Announce: https://lore.kernel.org/linux-cve-announce/2024052136-CVE-2021-47=
224-8135@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc7.
The ptr_to_txbd() was added by commit d84aec4 ("net: ll_temac: Fix
support for 64-bit platforms") in 5.2-rc1.
However, this bug seems affect to prior to Linux 5.2.

Fixed status
mainline: [6aa32217a9a446275440ee8724b1ecaf1838df47]
stable/5.10: [019ab7d044d0ebf97e1236bb8935b7809be92358]
stable/5.4: [6d120ab4dc39a543c6b63361e1d0541c382900a3]

CVE-2021-47225: mac80211: fix deadlock in AP/VLAN handling

Announce: https://lore.kernel.org/linux-cve-announce/2024052137-CVE-2021-47=
225-550b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a05829a ("cfg80211: avoid holding the RTNL when
calling the driver") in v5.12-rc1.
Fixed in v5.13-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d5befb224edbe53056c2c18999d630dafb4a08b9]

CVE-2021-47226: x86/fpu: Invalidate FPU state after a failed XRSTOR
from a user buffer

Announce: https://lore.kernel.org/linux-cve-announce/2024052137-CVE-2021-47=
226-5d4f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1d731e7 ("x86/fpu: Add a fastpath to
__fpu__restore_sig()") in v5.2-rc1.
Fixed in v5.13-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d8778e393afa421f1f117471144f8ce6deb6953a]
stable/5.10: [a7748e021b9fb7739e3cb88449296539de0b6817]

CVE-2021-47227: x86/fpu: Prevent state corruption in __fpu__restore_sig()

Announce: https://lore.kernel.org/linux-cve-announce/2024052137-CVE-2021-47=
227-8364@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b860eb8 ("x86/fpu/xstate: Define new functions
for clearing fpregs and xstates") in v5.8-rc1.
Fixed in v5.13-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [484cea4f362e1eeb5c869abbfb5f90eae6421b38]
stable/5.10: [076f732b16a5bf842686e1b43ab6021a2d98233e]

CVE-2021-47228: x86/ioremap: Map EFI-reserved memory as encrypted for SEV

Announce: https://lore.kernel.org/linux-cve-announce/2024052137-CVE-2021-47=
228-415f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 58c9090 ("efi: Support for MOK variable config
table") in v5.10-rc1.
Fixed in v5.13-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8d651ee9c71bb12fc0c8eb2786b66cbe5aa3e43b]
stable/5.10: [208bb686e7fa7fff16e8fa78ff0db34aa9acdbd7]

CVE-2021-47229: PCI: aardvark: Fix kernel panic during PIO transfer

Announce: https://lore.kernel.org/linux-cve-announce/2024052138-CVE-2021-47=
229-408e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc7.
The pci-aardvark.c was added by commit 8c39d710 ("PCI: aardvark: Add
Aardvark PCI host controller driver") in 4.8-rc1.
Linux 4.4 is not affected.

Fixed status
mainline: [f18139966d072dab8e4398c95ce955a9742e04f7]
stable/4.19: [b00a9aaa4be20ad6e3311fb78a485eae0899e89a]
stable/5.10: [1a1dbc4473974867fe8c5f195c17b341c8e82867]
stable/5.4: [4c90f90a91d75c3c73dd633827c90e8746d9f54d]

CVE-2021-47230: KVM: x86: Immediately reset the MMU context when the
SMM flag is cleared

Announce: https://lore.kernel.org/linux-cve-announce/2024052138-CVE-2021-47=
230-e1ff@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9ec1949 ("KVM: x86: clear SMM flags before
loading state while leaving SMM") in v5.1-rc6.
Fixed in v5.13-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [78fcb2c91adfec8ce3a2ba6b4d0dda89f2f4a7c6]
stable/5.10: [669a8866e468fd020d34eb00e08cb41d3774b71b]
stable/5.4: [cbb425f62df9df7abee4b3f068f7ed6ffc3561e2]

CVE-2021-47231: can: mcba_usb: fix memory leak in mcba_usb

Announce: https://lore.kernel.org/linux-cve-announce/2024052138-CVE-2021-47=
231-c384@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 51f3baa ("can: mcba_usb: Add support for
Microchip CAN BUS Analyzer") in v4.12-rc1.
Fixed in v5.13-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [91c02557174be7f72e46ed7311e3bea1939840b0]
stable/4.19: [a115198caaab6d663bef75823a3c5f0802306d60]
stable/5.10: [6bd3d80d1f019cefa7011056c54b323f1d8b8e83]
stable/5.4: [6f87c0e21ad20dd3d22108e33db1c552dfa352a0]

CVE-2021-47232: can: j1939: fix Use-after-Free, hold skb ref while in use

Announce: https://lore.kernel.org/linux-cve-announce/2024052139-CVE-2021-47=
232-9022@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9d71dd0 ("can: add support of SAE J1939
protocol") in v5.4-rc1.
Fixed in v5.13-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2030043e616cab40f510299f09b636285e0a3678]
stable/5.10: [509ab6bfdd0c76daebbad0f0af07da712116de22]
stable/5.4: [22cba878abf646cd3a02ee7c8c2cef7afe66a256]

CVE-2021-47233: regulator: rt4801: Fix NULL pointer dereference if
priv->enable_gpios is NULL

Announce: https://lore.kernel.org/linux-cve-announce/2024052139-CVE-2021-47=
233-e795@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5bbbfc7 ("regulator: rt4801: Add support for
RT4801 Display Bias regulator driver") in 5.10-rc1.
Fixed in v5.13-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb2381cbecb81a8893b2d1e1af29bc2e5531df27]
stable/5.10: [ba8a26a7ce8617f9f3d6230de34b2302df086b41]

CVE-2021-47234: phy: phy-mtk-tphy: Fix some resource leaks in mtk_phy_init(=
)

Announce: https://lore.kernel.org/linux-cve-announce/2024052139-CVE-2021-47=
234-349a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc6.
It looks as if Linux 4.4/4.19/5.4 need to call clk_disable_unprepare()
when some error occured.

Fixed status
mainline: [aaac9a1bd370338ce372669eb9a6059d16b929aa]
stable/5.10: [9a17907946232d01aa2ec109da5f93b8d31dd425]

CVE-2021-47235: net: ethernet: fix potential use-after-free in ec_bhf_remov=
e

Announce: https://lore.kernel.org/linux-cve-announce/2024052140-CVE-2021-47=
235-1fb6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6af55ff ("Driver for Beckhoff CX5020 EtherCAT
master module.") in v3.15-rc7.
Fixed in v5.13-rc7.

Fixed status
cip/4.4: [db2bc3cfd2bc01621014d4f17cdfc74611f339c8]
cip/4.4-rt: [db2bc3cfd2bc01621014d4f17cdfc74611f339c8]
cip/4.4-st: [db2bc3cfd2bc01621014d4f17cdfc74611f339c8]
mainline: [9cca0c2d70149160407bda9a9446ce0c29b6e6c6]
stable/4.19: [0260916843cc74f3906acf8b6f256693e01530a2]
stable/4.4: [db2bc3cfd2bc01621014d4f17cdfc74611f339c8]
stable/5.10: [95deeb29d831e2fae608439e243e7a520611e7ea]
stable/5.4: [19f88ca68ccf8771276a606765239b167654f84a]

CVE-2021-47236: net: cdc_eem: fix tx fixup skb leak

Announce: https://lore.kernel.org/linux-cve-announce/2024052140-CVE-2021-47=
236-c679@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9f722c0 ("usbnet: CDC EEM support (v5)") in v2.6.30-rc=
5.
Fixed in v5.13-rc7.

Fixed status
cip/4.4: [f12554b0ff639e74612cc01b3b4a049e098d2d65]
cip/4.4-rt: [f12554b0ff639e74612cc01b3b4a049e098d2d65]
cip/4.4-st: [f12554b0ff639e74612cc01b3b4a049e098d2d65]
mainline: [c3b26fdf1b32f91c7a3bc743384b4a298ab53ad7]
stable/4.19: [f4e6a7f19c82f39b1803e91c54718f0d7143767d]
stable/4.4: [f12554b0ff639e74612cc01b3b4a049e098d2d65]
stable/5.10: [05b2b9f7d24b5663d9b47427fe1555bdafd3ea02]
stable/5.4: [81de2ed06df8b5451e050fe6a318af3263dbff3f]

CVE-2021-47237: net: hamradio: fix memory leak in mkiss_close

Announce: https://lore.kernel.org/linux-cve-announce/2024052140-CVE-2021-47=
237-52cf@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 815f62b ("[PATCH] SMP rewrite of mkiss") in v2.6.20.16=
.
Fixed in v5.13-rc7.

Fixed status
cip/4.4: [c634ba0b4159838ff45a60d3a0ace3b4118077a5]
cip/4.4-rt: [c634ba0b4159838ff45a60d3a0ace3b4118077a5]
cip/4.4-st: [c634ba0b4159838ff45a60d3a0ace3b4118077a5]
mainline: [7edcc682301492380fbdd604b4516af5ae667a13]
stable/4.19: [c16c4716a1b5ba4f83c7e00da457cba06761f119]
stable/4.4: [c634ba0b4159838ff45a60d3a0ace3b4118077a5]
stable/5.10: [290b0b6432e2599021db0b8d6046f756d931c29f]
stable/5.4: [a49cbb762ef20655f5c91abdc13658b0af5e159d]

CVE-2021-47238: net: ipv4: fix memory leak in ip_mc_add1_src

Announce: https://lore.kernel.org/linux-cve-announce/2024052140-CVE-2021-47=
238-c466@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 24803f3 ("igmp: do not remove igmp souce list
info ...") in v4.9-rc7.
Fixed in v5.13-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d8e2973029b8b2ce477b564824431f3385c77083]
stable/4.19: [1e28018b5c83d5073f74a6fb72eabe8370b2f501]
stable/5.10: [ac31cc837cafb57a271babad8ccffbf733caa076]
stable/5.4: [3dd2aeac2e9624cff9fa634710837e4f2e352758]

CVE-2021-47239: net: usb: fix possible use-after-free in smsc75xx_bind

Announce: https://lore.kernel.org/linux-cve-announce/2024052141-CVE-2021-47=
239-ae00@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 46a8b29 ("net: usb: fix memory leak in
smsc75xx_bind") in 5.13-rc4. Fixed in 5.13-rc7.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10
cip/5.10-rt stable/4.19 stable/5.10 stable/5.44

Fixed status
cip/4.4: [7cc8b2e05fcea6edd022d26e82091d781af8fd9b]
cip/4.4-rt: [7cc8b2e05fcea6edd022d26e82091d781af8fd9b]
cip/4.4-st: [7cc8b2e05fcea6edd022d26e82091d781af8fd9b]
mainline: [56b786d86694e079d8aad9b314e015cd4ac02a3d]
stable/4.19: [2fc8300c9cfa5167fcb5b1a2a07db6f53e82f59b]
stable/4.4: [7cc8b2e05fcea6edd022d26e82091d781af8fd9b]
stable/5.10: [570a52cf3e01d19f7fd1a251dfc52b0cd86c13cb]
stable/5.4: [4252bf6c2b245f47011098113d405ffad6ad5d5b]

CVE-2021-47240: net: qrtr: fix OOB Read in qrtr_endpoint_post

Announce: https://lore.kernel.org/linux-cve-announce/2024052141-CVE-2021-47=
240-b6f9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 194ccc8 ("net: qrtr: Support decoding incoming v2
packets") in v4.15-rc1.
Fixed in v5.13-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ad9d24c9429e2159d1e279dc3a83191ccb4daf1d]
stable/4.19: [f8111c0d7ed42ede41a3d0d393b104de0730a8a6]
stable/5.10: [960b08dd36de1e341e3eb43d1c547513e338f4f8]
stable/5.4: [26b8d10703a9be45d6097946b2b4011f7dd2c56f]

CVE-2021-47241: ethtool: strset: fix message length calculation

Announce: https://lore.kernel.org/linux-cve-announce/2024052141-CVE-2021-47=
241-93cd@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7192169 ("ethtool: provide string sets with
STRSET_GET request") in v5.6-rc1.
Fixed in v5.13-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e175aef902697826d344ce3a12189329848fe898]
stable/5.10: [fb3a948143688e14e2cfd2a2812877923d0e5e92]

CVE-2021-47242: mptcp: fix soft lookup in subflow_error_report()

Announce: https://lore.kernel.org/linux-cve-announce/2024052142-CVE-2021-47=
242-2015@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 15cc104 ("mptcp: deliver ssk errors to msk") in v5.12-=
rc1.
Fixed in v5.13-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [499ada5073361c631f2a3c4a8aed44d53b6f82ec]

CVE-2021-47243: sch_cake: Fix out of bounds when parsing TCP options and he=
ader

Announce: https://lore.kernel.org/linux-cve-announce/2024052142-CVE-2021-47=
243-830c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8b71388 ("sch_cake: Add optional ACK filter") in v4.19=
-rc1.
Fixed in v5.13-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ba91c49dedbde758ba0b72f57ac90b06ddf8e548]
stable/4.19: [595897ef118d6fe66690c4fc5b572028c9da95b7]
stable/5.10: [3b491dd593d582ceeb27aa617600712a6bd14246]
stable/5.4: [4cefa061fc63f4d2dff5ab4083f43857cd7a2335]

CVE-2021-47244: mptcp: Fix out of bounds when parsing TCP options

Announce: https://lore.kernel.org/linux-cve-announce/2024052142-CVE-2021-47=
244-cc41@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cec37a6 ("mptcp: Handle MP_CAPABLE options for
outgoing connections") in v5.6-rc1.
Fixed in v5.13-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [07718be265680dcf496347d475ce1a5442f55ad7]
stable/5.10: [73eeba71dc9932970befa009e68272a3d5ec4a58]

CVE-2021-47245: netfilter: synproxy: Fix out of bounds when parsing TCP opt=
ions

Announce: https://lore.kernel.org/linux-cve-announce/2024052143-CVE-2021-47=
245-13d9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 48b1de4 ("netfilter: add SYNPROXY core/target")
in v3.12-rc1.
Fixed in v5.13-rc7.

Fixed status
cip/4.4: [e1eb98cfeafdd85537e7e3cefe93ca9bfbcc3ea8]
cip/4.4-rt: [e1eb98cfeafdd85537e7e3cefe93ca9bfbcc3ea8]
cip/4.4-st: [e1eb98cfeafdd85537e7e3cefe93ca9bfbcc3ea8]
mainline: [5fc177ab759418c9537433e63301096e733fb915]
stable/4.19: [7d9a9a1a88a3da574e019b4de756bc73337b3b0b]
stable/4.4: [e1eb98cfeafdd85537e7e3cefe93ca9bfbcc3ea8]
stable/5.10: [9cdf299ba4e153b5e56187648420de22c6216f02]
stable/5.4: [6defc77d48eff74075b80ad5925061b2fc010d98]

CVE-2021-47246: net/mlx5e: Fix page reclaim for dead peer hairpin

Announce: https://lore.kernel.org/linux-cve-announce/2024052143-CVE-2021-47=
246-9896@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4d8fcf2 ("net/mlx5e: Avoid unbounded peer devices
when unpairing TC hairpin rules") in v4.19-rc7.
Fixed in v5.13-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3e5fd9314dfc4314a9567cde96e1aef83a7458a]
stable/5.10: [be7f3f401d224e1efe8112b2fa8b837eeb8c5e52]
stable/5.4: [4b16118665e94c90a3e84a5190486fd0e4eedd74]

CVE-2021-47247: net/mlx5e: Fix use-after-free of encap entry in neigh
update handler

Announce: https://lore.kernel.org/linux-cve-announce/2024052143-CVE-2021-47=
247-e933@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2a1f176 ("net/mlx5e: Refactor neigh update for
concurrent execution") in v5.4-rc1.
Fixed in v5.13-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fb1a3132ee1ac968316e45d21a48703a6db0b6c3]

CVE-2021-47248: udp: fix race between close() and udp_abort()

Announce: https://lore.kernel.org/linux-cve-announce/2024052143-CVE-2021-47=
248-2609@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5d77dca ("net: diag: support SOCK_DESTROY for UDP
sockets") in v4.9-rc1.
Fixed in v5.13-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a8b897c7bcd47f4147d066e22cc01d1026d7640e]
stable/4.19: [2f73448041bd0682d4b552cfd314ace66107f1ad]
stable/5.10: [8729ec8a2238152a4afc212a331a6cd2c61aeeac]
stable/5.4: [5a88477c1c85e4baa51e91f2d40f2166235daa56]

CVE-2021-47249: net: rds: fix memory leak in rds_recvmsg

Announce: https://lore.kernel.org/linux-cve-announce/2024052144-CVE-2021-47=
249-ed65@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit bdbe6fb ("RDS: recv.c") in v2.6.30-rc1.
Fixed in v5.13-rc7.

Fixed status
cip/4.4: [8c3ec88b03e9e4ca117dcdc4204fd3edcd02084f]
cip/4.4-rt: [8c3ec88b03e9e4ca117dcdc4204fd3edcd02084f]
cip/4.4-st: [8c3ec88b03e9e4ca117dcdc4204fd3edcd02084f]
mainline: [49bfcbfd989a8f1f23e705759a6bb099de2cff9f]
stable/4.19: [06b7cb0194bd1ede0dd27f3a946e7c0279fba44a]
stable/4.4: [8c3ec88b03e9e4ca117dcdc4204fd3edcd02084f]
stable/5.10: [5946fbf48355f5a8caeff72580c7658da5966b86]
stable/5.4: [2038cd15eacdf7512755c27686822e0052eb9042]

CVE-2021-47250: net: ipv4: fix memory leak in netlbl_cipsov4_add_std

Announce: https://lore.kernel.org/linux-cve-announce/2024052144-CVE-2021-47=
250-7fad@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 96cb8e3 ("[NetLabel]: CIPSOv4 and Unlabeled
packet integration") in v2.6.20.16.
Fixed in v5.13-rc7.

Fixed status
cip/4.4: [212166510582631994be4f4b3fe15e10a03c1dd4]
cip/4.4-rt: [212166510582631994be4f4b3fe15e10a03c1dd4]
cip/4.4-st: [212166510582631994be4f4b3fe15e10a03c1dd4]
mainline: [d612c3f3fae221e7ea736d196581c2217304bbbc]
stable/4.19: [5340858147e3dc60913fb3dd0cbb758ec4a26e66]
stable/4.4: [212166510582631994be4f4b3fe15e10a03c1dd4]
stable/5.10: [deeeb65c6ee404f2d1fb80b38b2730645c0f4663]
stable/5.4: [398a24447eb60f060c8994221cb5ae6caf355fa1]

CVE-2021-47251: mac80211: fix skb length check in ieee80211_scan_rx()

Announce: https://lore.kernel.org/linux-cve-announce/2024052144-CVE-2021-47=
251-8504@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cd418ba ("mac80211: convert S1G beacon to scan
results") in v5.10-rc1.
Fixed in v5.13-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e298aa358f0ca658406d524b6639fe389cb6e11e]
stable/5.10: [5a1cd67a801cf5ef989c4783e07b86a25b143126]

CVE-2021-47252: batman-adv: Avoid WARN_ON timing related checks

Announce: https://lore.kernel.org/linux-cve-announce/2024052145-CVE-2021-47=
252-3551@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ef0a937 ("batman-adv: consider outgoing interface
in OGM sending") in v3.14-rc1.
Fixed in v5.13-rc7.

Fixed status
cip/4.4: [45011f2973f6b52cf50db397bb27bf805f5f0e7f]
cip/4.4-rt: [45011f2973f6b52cf50db397bb27bf805f5f0e7f]
cip/4.4-st: [45011f2973f6b52cf50db397bb27bf805f5f0e7f]
mainline: [9f460ae31c4435fd022c443a6029352217a16ac1]
stable/4.19: [e8e9d2968a9d08bf5c683afca182f1537edebf8d]
stable/4.4: [45011f2973f6b52cf50db397bb27bf805f5f0e7f]
stable/5.10: [282baa8104af44e04c4af3e7f933b44267c7f86f]
stable/5.4: [e7fbd8184fa9e85f0d648c499841cb7ff6dec9f4]

CVE-2021-47253: drm/amd/display: Fix potential memory leak in DMUB hw_init

Announce: https://lore.kernel.org/linux-cve-announce/2024052145-CVE-2021-47=
253-d6c6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc5.
It seems as if this bug was introduced by commit 9a71c7d31 in
("drm/amd/display: Register DMUB service with DC") in 5.6-rc1
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c5699e2d863f58221044efdc3fa712dd32d55cde]
stable/5.10: [9e8c2af010463197315fa54a6c17e74988b5259c]

CVE-2021-47254: gfs2: Fix use-after-free in gfs2_glock_shrink_scan

Announce: https://lore.kernel.org/linux-cve-announce/2024052145-CVE-2021-47=
254-41d1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc5.

Fixed status
cip/4.4: [38ce329534500bf4ae71f81df6a37a406cf187b4]
cip/4.4-rt: [38ce329534500bf4ae71f81df6a37a406cf187b4]
cip/4.4-st: [38ce329534500bf4ae71f81df6a37a406cf187b4]
mainline: [1ab19c5de4c537ec0d9b21020395a5b5a6c059b2]
stable/4.19: [094bf5670e762afa243d2c41a5c4ab71c7447bf4]
stable/4.4: [38ce329534500bf4ae71f81df6a37a406cf187b4]
stable/5.10: [a61156314b66456ab6a291ed5deba1ebd002ab3c]
stable/5.4: [86fd5b27db743a0ce0cc245e3a34813b2aa6ec1d]

CVE-2021-47255: kvm: LAPIC: Restore guard to prevent illegal APIC
register access

Announce: https://lore.kernel.org/linux-cve-announce/2024052146-CVE-2021-47=
255-c840@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 01402cf ("kvm: LAPIC: write down valid APIC
registers") in v5.3-rc1.
Fixed in v5.13-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [218bf772bddd221489c38dde6ef8e917131161f6]
stable/5.10: [018685461a5b9a9a70e664ac77aef0d7415a3fd5]
stable/5.4: [bf99ea52970caeb4583bdba1192c1f9b53b12c84]

CVE-2021-47256: mm/memory-failure: make sure wait for page writeback
in memory_failure

Announce: https://lore.kernel.org/linux-cve-announce/2024052146-CVE-2021-47=
256-a490@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0bc1f8b ("hwpoison: fix the handling path of the
victimized page frame that belong to non-LRU") in v3.16-rc4.
Fixed in v5.13-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e8675d291ac007e1c636870db880f837a9ea112a]
stable/4.19: [6d210d547adc2218ef8b5bcf23518c5f2f1fd872]
stable/5.10: [9e379da727a7a031be9b877cde7b9c34a0fb8306]
stable/5.4: [566345aaabac853aa866f53a219c4b02a6beb527]

CVE-2021-47257: net: ieee802154: fix null deref in parse dev addr

Announce: https://lore.kernel.org/linux-cve-announce/2024052146-CVE-2021-47=
257-1d1c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc5.
It looks to be Linux 4.4 is affected too.

Fixed status
mainline: [9fdd04918a452980631ecc499317881c1d120b70]
stable/4.19: [5f728ec65485625e30f46e5b4917ff023ad29ea0]
stable/5.10: [c7836de2cadd88bc2f20f2c5a3d4ef4c73aef627]
stable/5.4: [d0f47648b87b6d5f204cb7f3cbce6d36dab85a67]

CVE-2021-47258: scsi: core: Fix error handling of scsi_host_alloc()

Announce: https://lore.kernel.org/linux-cve-announce/2024052146-CVE-2021-47=
258-f276@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc6.
It seems as if Linux 4.4 need to call put_device in error path instead
of calling kfree as well.

Fixed status
mainline: [66a834d092930cf41d809c0e989b13cd6f9ca006]
stable/4.19: [2dc85045ae65b9302a1d2e2ddd7ce4c030153a6a]
stable/5.10: [7a696ce1d5d16a33a6cd6400bbcc0339b2460e11]
stable/5.4: [79296e292d67fa7b5fb8d8c27343683e823872c8]

CVE-2021-47259: NFS: Fix use-after-free in nfs4_init_client()

Announce: https://lore.kernel.org/linux-cve-announce/2024052147-CVE-2021-47=
259-921b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8dcbec6 ("NFSv41: Handle EXCHID4_FLAG_CONFIRMED_R
during NFSv4.1 migration") in v4.13-rc1.
Fixed in v5.13-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [476bdb04c501fc64bf3b8464ffddefc8dbe01577]
stable/4.19: [42c10b0db064e45f5c5ae7019bbf2168ffab766c]
stable/5.10: [c3b6cf64dfe4ef96e7341508d50d6998da7062c7]
stable/5.4: [3e3c7ebbfac152d08be75c92802a64a1f6471a15]

CVE-2021-47260: NFS: Fix a potential NULL dereference in nfs_get_client()

Announce: https://lore.kernel.org/linux-cve-announce/2024052147-CVE-2021-47=
260-4a4b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 31434f4 ("nfs: check hostname in nfs_get_client")
in v3.17-rc1.
Fixed in v5.13-rc6.

Fixed status
cip/4.4: [fab8bfdfb4aac9e4e8363666333adfdf21e89106]
cip/4.4-rt: [fab8bfdfb4aac9e4e8363666333adfdf21e89106]
cip/4.4-st: [fab8bfdfb4aac9e4e8363666333adfdf21e89106]
mainline: [09226e8303beeec10f2ff844d2e46d1371dc58e0]
stable/4.19: [4b380a7d84ef2ce3f4f5bec5d8706ed937ac6502]
stable/4.4: [fab8bfdfb4aac9e4e8363666333adfdf21e89106]
stable/5.10: [279ad78a00f8b9c5ff24171a59297187a3bd44b7]
stable/5.4: [0057ecef9f324007c0ba5fcca4ddd131178ce78b]

CVE-2021-47261: IB/mlx5: Fix initializing CQ fragments buffer

Announce: https://lore.kernel.org/linux-cve-announce/2024052147-CVE-2021-47=
261-20fd@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 388ca8b ("IB/mlx5: Implement fragmented
completion queue (CQ)") in v4.17-rc1.
Fixed in v5.13-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ba0aa2feebda680ecfc3c552e867cf4d1b05a3a]
stable/4.19: [1ec2dcd680c71d0d36fa25638b327a468babd5c9]
stable/5.10: [91f7fdc4cc10542ca1045c06aad23365f0d067e0]
stable/5.4: [e3ecd9c09fcc10cf6b2bc67e2990c397c40a8c26]

CVE-2021-47262: KVM: x86: Ensure liveliness of nested VM-Enter fail
tracepoint message

Announce: https://lore.kernel.org/linux-cve-announce/2024052148-CVE-2021-47=
262-cf6a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 380e005 ("KVM: nVMX: trace nested VM-Enter
failures detected by H/W") in v5.4-rc1.
Fixed in v5.13-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f31500b0d437a2464ca5972d8f5439e156b74960]
stable/5.10: [d046f724bbd725a24007b7e52b2d675249870888]
stable/5.4: [796d3bd4ac9316e70c181189318cd2bd98af34bc]

CVE-2021-47263: gpio: wcd934x: Fix shift-out-of-bounds error

Announce: https://lore.kernel.org/linux-cve-announce/2024052148-CVE-2021-47=
263-37f2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 59c3246 ("gpio: wcd934x: Add support to wcd934x
gpio controller") in v5.6-rc1.
Fixed in v5.13-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dbec64b11c65d74f31427e2b9d5746fbf17bf840]
stable/5.10: [e0b518a2eb44d8a74c19e50f79a8ed393e96d634]

CVE-2021-47264: ASoC: core: Fix Null-point-dereference in fmt_single_name()

Announce: https://lore.kernel.org/linux-cve-announce/2024052148-CVE-2021-47=
264-a94a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 45dd994 ("ASoC: core: remove artificial component
and DAI name constraint") in v5.10-rc1.
Fixed in v5.13-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [41daf6ba594d55f201c50280ebcd430590441da1]
stable/5.10: [0e2c9aeb00289f279b8181fbd4c20765127d8943]

CVE-2021-47265: RDMA: Verify port when creating flow rule

Announce: https://lore.kernel.org/linux-cve-announce/2024052149-CVE-2021-47=
265-b339@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 436f2ad ("IB/core: Export ib_create/destroy_flow
through uverbs") in v3.12-rc1.
Fixed in v5.13-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2adcb4c5a52a2623cd2b43efa7041e74d19f3a5e]

CVE-2021-47266: RDMA/ipoib: Fix warning caused by destroying non-initial ne=
tns

Announce: https://lore.kernel.org/linux-cve-announce/2024052149-CVE-2021-47=
266-a1b5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5ce2dce ("RDMA/ipoib: Set rtnl_link_ops for ipoib
interfaces") in v5.10-rc1.
Fixed in v5.13-rc6.
Bug introduced commit was backported to following branches.
stable/5.4

Fixed status
mainline: [a3e74fb9247cd530dca246699d5eb5a691884d32]
stable/5.10: [67cf4e447b5e5e9e94996cb6812ae2828e0e0e27]
stable/5.4: [64f1fb6acc2ab95982fc4334f351d7576c26f313]

CVE-2021-47267: usb: fix various gadget panics on 10gbps cabling

Announce: https://lore.kernel.org/linux-cve-announce/2024052149-CVE-2021-47=
267-1427@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc6.
The ssp parameter was added by commit eaef50c7 ("usb: gadget: Update
usb_assign_descriptors for SuperSpeedPlus") in 4.6-rc1.
so Linux 4.4 is not affected.

Fixed status
mainline: [032e288097a553db5653af552dd8035cd2a0ba96]
stable/4.19: [45f9a2fe737dc0a5df270787f2231aee8985cd59]
stable/5.10: [b972eff874637402ddc4a7dd11fb22538a0b6d28]
stable/5.4: [5ef23506695b01d5d56a13a092a97f2478069d75]

CVE-2021-47268: usb: typec: tcpm: cancel vdm and state machine hrtimer
when unregister tcpm port

Announce: https://lore.kernel.org/linux-cve-announce/2024052149-CVE-2021-47=
268-8a75@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3ed8e1c ("usb: typec: tcpm: Migrate workqueue to
RT priority for processing events") in v5.10-rc1.
Fixed in v5.13-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a13ff7ef4349d70d1d18378d661117dd5af8efe]
stable/5.10: [18eaf0de50eadeeb395b83310b259b21ad8ed0a6]

CVE-2021-47269: usb: dwc3: ep0: fix NULL pointer exception

Announce: https://lore.kernel.org/linux-cve-announce/2024052150-CVE-2021-47=
269-c83f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc6.

Fixed status
cip/4.4: [96b74a99d360235c24052f1d060e64ac53f43528]
cip/4.4-rt: [96b74a99d360235c24052f1d060e64ac53f43528]
cip/4.4-st: [96b74a99d360235c24052f1d060e64ac53f43528]
mainline: [d00889080ab60051627dab1d85831cd9db750e2a]
stable/4.19: [bd551e7c85939de2182010273450bfa78c3742fc]
stable/4.4: [96b74a99d360235c24052f1d060e64ac53f43528]
stable/5.10: [470403639114895e2697c766fbe17be8d0e9b67a]
stable/5.4: [366369b89bedd59b1425386e8d4a18a466e420e4]

CVE-2021-47270: usb: fix various gadgets null ptr deref on 10gbps cabling.

Announce: https://lore.kernel.org/linux-cve-announce/2024052150-CVE-2021-47=
270-700e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit eaef50c ("usb: gadget: Update
usb_assign_descriptors for SuperSpeedPlus") in v4.6-rc1.
Fixed in v5.13-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [90c4d05780d47e14a50e11a7f17373104cd47d25]
stable/4.19: [10770d2ac0094b053c8897d96d7b2737cd72f7c5]
stable/5.10: [4b289a0f3033f465b4fd51ba995251a7867a2aa2]
stable/5.4: [b4903f7fdc484628d0b8022daf86e2439d3ab4db]

CVE-2021-47271: usb: cdnsp: Fix deadlock issue in cdnsp_thread_irq_handler

Announce: https://lore.kernel.org/linux-cve-announce/2024052150-CVE-2021-47=
271-e0ad@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3d82904 ("usb: cdnsp: cdns3 Add main part of
Cadence USBSSP DRD Driver") in v5.12-rc1.
Fixed in v5.13-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a9aecef198faae3240921b707bc09b602e966fce]

CVE-2021-47272: usb: dwc3: gadget: Bail from dwc3_gadget_exit() if
dwc->gadget is NULL

Announce: https://lore.kernel.org/linux-cve-announce/2024052151-CVE-2021-47=
272-607d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e81a701 ("usb: dwc3: allocate gadget structure
dynamically") in v5.10-rc1.
Fixed in v5.13-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [03715ea2e3dbbc56947137ce3b4ac18a726b2f87]
stable/5.10: [851dee5a5da56564a70290713aee665403bb0b24]

CVE-2021-47273: usb: dwc3-meson-g12a: fix usb2 PHY glue init when phy0
is disabled

Announce: https://lore.kernel.org/linux-cve-announce/2024052151-CVE-2021-47=
273-1c92@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 013af22 ("usb: dwc3: meson-g12a: handle the phy
and glue registers separately") in v5.8-rc1.
Fixed in v5.13-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d2aa178d2ad2fb156711113790dde13e9aa2376]
stable/5.10: [750a0d75564293be3ed50f13ef7f38ab75106421]

CVE-2021-47274: tracing: Correct the length check which causes memory corru=
ption

Announce: https://lore.kernel.org/linux-cve-announce/2024052151-CVE-2021-47=
274-3867@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b220c04 ("tracing: Check length before giving out
the filter buffer") in v5.11.
Fixed in v5.13-rc6.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt stable/4.19 stable/5.10 stable/5.=
4

Fixed status
mainline: [3e08a9f9760f4a70d633c328a76408e62d6f80a3]
stable/4.19: [31ceae385556c37e4d286cb6378696448f566883]
stable/5.10: [43c32c22254b9328d7abb1c2b0f689dc67838e60]
stable/5.4: [d63f00ec908b3be635ead5d6029cc94246e1f38d]

CVE-2021-47275: bcache: avoid oversized read request in cache missing code =
path

Announce: https://lore.kernel.org/linux-cve-announce/2024052152-CVE-2021-47=
275-0e3d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc6.
Linux 4.4, 4.19, 5.4, and 5.10 may be affected.

Fixed status
mainline: [41fe8d088e96472f63164e213de44ec77be69478]

CVE-2021-47276: ftrace: Do not blindly read the ip address in ftrace_bug()

Announce: https://lore.kernel.org/linux-cve-announce/2024052152-CVE-2021-47=
276-7574@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 05736a4 ("ftrace: warn on failure to disable
mcount callers") in v2.6.28-rc1.
Fixed in v5.13-rc6.

Fixed status
cip/4.4: [0bc62e398bbd9e600959e610def5109957437b28]
cip/4.4-rt: [0bc62e398bbd9e600959e610def5109957437b28]
cip/4.4-st: [0bc62e398bbd9e600959e610def5109957437b28]
mainline: [6c14133d2d3f768e0a35128faac8aa6ed4815051]
stable/4.19: [862dcc14f2803c556bdd73b43c27b023fafce2fb]
stable/4.4: [0bc62e398bbd9e600959e610def5109957437b28]
stable/5.10: [97524384762c1fb9b3ded931498dd2047bd0de81]
stable/5.4: [7e4e824b109f1d41ccf223fbb0565d877d6223a2]

CVE-2021-47277: kvm: avoid speculation-based attacks from out-of-range
memslot accesses

Announce: https://lore.kernel.org/linux-cve-announce/2024052152-CVE-2021-47=
277-68e4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc6.

Fixed status
cip/4.4: [3098b86390a6b9ea52657689f08410baf130ceff]
cip/4.4-rt: [3098b86390a6b9ea52657689f08410baf130ceff]
cip/4.4-st: [3098b86390a6b9ea52657689f08410baf130ceff]
mainline: [da27a83fd6cc7780fea190e1f5c19e87019da65c]
stable/4.19: [22b87fb17a28d37331bb9c1110737627b17f6781]
stable/4.4: [3098b86390a6b9ea52657689f08410baf130ceff]
stable/5.10: [7af299b97734c7e7f465b42a2139ce4d77246975]
stable/5.4: [bff1fbf0cf0712686f1df59a83fba6e31d2746a0]

CVE-2021-47278: bus: mhi: pci_generic: Fix possible use-after-free in
mhi_pci_remove()

Announce: https://lore.kernel.org/linux-cve-announce/2024052152-CVE-2021-47=
278-8b68@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8562d4f ("mhi: pci_generic: Add health-check") in
v5.12-rc1.
Fixed in v5.13-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0b67808ade8893a1b3608ddd74fac7854786c919]

CVE-2021-47279: usb: misc: brcmstb-usb-pinmap: check return value
after calling platform_get_resource()

Announce: https://lore.kernel.org/linux-cve-announce/2024052153-CVE-2021-47=
279-6e4d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 517c4c4 ("usb: Add driver to allow any GPIO to be
used for 7211 USB signals") in v5.11-rc1.
Fixed in v5.13-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fbf649cd6d64d40c03c5397ecd6b1ae922ba7afc]

CVE-2021-47280: drm: Fix use-after-free read in drm_getunique()

Announce: https://lore.kernel.org/linux-cve-announce/2024052153-CVE-2021-47=
280-4344@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc6.
It seems to be Linux 4.4 is affected.

Fixed status
mainline: [b436acd1cf7fac0ba987abd22955d98025c80c2b]
stable/4.19: [7d233ba700ceb593905ea82b42dadb4ec8ef85e9]
stable/5.10: [491d52e0078860b33b6c14f0a7ac74ca1b603bd6]
stable/5.4: [b246b4c70c1250e7814f409b243000f9c0bf79a3]

CVE-2021-47281: ALSA: seq: Fix race of snd_seq_timer_open()

Announce: https://lore.kernel.org/linux-cve-announce/2024052153-CVE-2021-47=
281-d193@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc6.
It seems to be Linux 4.4, 4.19, and 5.10 are affected.

Fixed status
mainline: [83e197a8414c0ba545e7e3916ce05f836f349273]
stable/5.10: [bd7d88b0874f82f7b29d1a53e574cedaf23166ba]

CVE-2021-47282: spi: bcm2835: Fix out-of-bounds access with more than 4 sla=
ves

Announce: https://lore.kernel.org/linux-cve-announce/2024052154-CVE-2021-47=
282-edd8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 571e31f ("spi: bcm2835: Cache CS register value
for ->prepare_message()") in v5.4-rc1.
Fixed in v5.13-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [13817d466eb8713a1ffd254f537402f091d48444]
stable/5.10: [82a8ffba54d31e97582051cb56ba1f988018681e]
stable/5.4: [b5502580cf958b094f3b69dfe4eece90eae01fbc]

CVE-2021-47283: net:sfc: fix non-freed irq in legacy irq mode

Announce: https://lore.kernel.org/linux-cve-announce/2024052154-CVE-2021-47=
283-6ea6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc4.
It seems to be Linux 4.4, 4.19, and 5.4 are affected.

Fixed status
mainline: [8f03eeb6e0a0a0b8d617ee0a4bce729e47130036]
stable/5.10: [8d717c9135a3340ae62d1699484850bfb4112b0c]

CVE-2021-47284: isdn: mISDN: netjet: Fix crash in nj_probe:

Announce: https://lore.kernel.org/linux-cve-announce/2024052154-CVE-2021-47=
284-c8f5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc4.

Fixed status
cip/4.4: [958cb1078ca60d214826fd90a0961a447fade59a]
cip/4.4-rt: [958cb1078ca60d214826fd90a0961a447fade59a]
cip/4.4-st: [958cb1078ca60d214826fd90a0961a447fade59a]
mainline: [9f6f852550d0e1b7735651228116ae9d300f69b3]
stable/4.19: [bf78e25bd3f487208e042c67c8a31706c2dba265]
stable/4.4: [958cb1078ca60d214826fd90a0961a447fade59a]
stable/5.10: [143fc7220961220eecc04669e5909af8847bf8c8]
stable/5.4: [9d7d4649dc1c53acf76df260fd519db698ed20d7]

CVE-2021-47285: net/nfc/rawsock.c: fix a permission check bug

Announce: https://lore.kernel.org/linux-cve-announce/2024052155-CVE-2021-47=
285-4fee@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc4.

Fixed status
cip/4.4: [c08e0be44759d0b5affc5888be4aa5e536873335]
cip/4.4-rt: [c08e0be44759d0b5affc5888be4aa5e536873335]
cip/4.4-st: [c08e0be44759d0b5affc5888be4aa5e536873335]
mainline: [8ab78863e9eff11910e1ac8bcf478060c29b379e]
stable/4.19: [ec72482564ff99c6832d33610d9f8ab7ecc81b6d]
stable/4.4: [c08e0be44759d0b5affc5888be4aa5e536873335]
stable/5.10: [1e5cab50208c8fb7351b798cb1d569debfeb994a]
stable/5.4: [f3ed12af6bbbaf79eddb0ae14656b8ecacea74f0]

CVE-2021-47286: bus: mhi: core: Validate channel ID when processing
command completions

Announce: https://lore.kernel.org/linux-cve-announce/2024052119-CVE-2021-47=
286-c242@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1d3173a ("bus: mhi: core: Add support for
processing events from client device") in v5.7-rc1.
Fixed in v5.14-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [546362a9ef2ef40b57c6605f14e88ced507f8dd0]
stable/5.10: [3efec3b4b16fc7af25676a94230a8ab2a3bb867c]

CVE-2021-47287: driver core: auxiliary bus: Fix memory leak when
driver_register() fail

Announce: https://lore.kernel.org/linux-cve-announce/2024052121-CVE-2021-47=
287-6345@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7de3697 ("Add auxiliary bus support") in v5.11-rc1.
Fixed in v5.14-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4afa0c22eed33cfe0c590742387f0d16f32412f3]

CVE-2021-47288: media: ngene: Fix out-of-bounds bug in
ngene_command_config_free_buf()

Announce: https://lore.kernel.org/linux-cve-announce/2024052122-CVE-2021-47=
288-ffb4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit dae52d0 ("V4L/DVB: ngene: Initial check-in") in
v2.6.34-rc1.
Fixed in v5.14-rc3.

Fixed status
cip/4.4: [4487b968e5eacd02c493303dc2b61150bb7fe4b2]
cip/4.4-rt: [4487b968e5eacd02c493303dc2b61150bb7fe4b2]
cip/4.4-st: [4487b968e5eacd02c493303dc2b61150bb7fe4b2]
mainline: [8d4abca95ecc82fc8c41912fa0085281f19cc29f]
stable/4.19: [ec731c6ef564ee6fc101fc5d73e3a3a953d09a00]
stable/4.4: [4487b968e5eacd02c493303dc2b61150bb7fe4b2]
stable/5.10: [e991457afdcb5f4dbc5bc9d79eaf775be33e7092]
stable/5.4: [e617fa62f6cf859a7b042cdd6c73af905ff8fca3]

CVE-2021-47289: ACPI: fix NULL pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024052122-CVE-2021-47=
289-7cbb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc3.
According to the commit log, this bug was introduced by commit 71f6428
("ACPI: utils: Fix reference counting in for_each_acpi_dev_match()")
in 5.14-rc3.

Fixed status
mainline: [fc68f42aa737dc15e7665a4101d4168aadb8e4c4]
stable/5.10: [cae3fa3d8165761f3000f523b11cfa1cd35206bc]
stable/5.4: [38f54217b423c0101d03a00feec6fb8ec608b12e]

CVE-2021-47290: scsi: target: Fix NULL dereference on XCOPY completion

Announce: https://lore.kernel.org/linux-cve-announce/2024052122-CVE-2021-47=
290-b403@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 39ae3ed ("scsi: target: core: Make completion
affinity configurable") in v5.13-rc1.
Fixed in v5.14-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a47fa41381a09e5997afd762664db4f5f6657e03]

CVE-2021-47291: ipv6: fix another slab-out-of-bounds in fib6_nh_flush_excep=
tions

Announce: https://lore.kernel.org/linux-cve-announce/2024052123-CVE-2021-47=
291-8eb9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f88d8ea ("ipv6: Plumb support for nexthop object
in a fib6_info") in v5.3-rc1.
Fixed in v5.14-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8fb4792f091e608a0a1d353dfdf07ef55a719db5]
stable/5.10: [ce8fafb68051fba52546f8bbe8621f7641683680]
stable/5.4: [830251361425c5be044db4d826aaf304ea3d14c6]

CVE-2021-47292: io_uring: fix memleak in io_init_wq_offload()

Announce: https://lore.kernel.org/linux-cve-announce/2024052123-CVE-2021-47=
292-4c13@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e941894 ("io-wq: make buffered file write hashed
work map per-ctx") in v5.12-rc1.
Fixed in v5.14-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [362a9e65289284f36403058eea2462d0330c1f24]

CVE-2021-47293: net/sched: act_skbmod: Skip non-Ethernet packets

Announce: https://lore.kernel.org/linux-cve-announce/2024052123-CVE-2021-47=
293-0cbe@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 86da71b ("net_sched: Introduce skbmod action") in v4.9=
-rc1.
Fixed in v5.14-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [727d6a8b7ef3d25080fad228b2c4a1d4da5999c6]
stable/4.19: [e4fdca366806f6bab374d1a95e626a10a3854b0c]
stable/5.10: [071729150be9e1d1b851b70efb6d91ee9269d57b]
stable/5.4: [a88414fb1117f2fe65fb88e45ba694e1d09d5024]

CVE-2021-47294: netrom: Decrease sock refcount when sock timers expire

Announce: https://lore.kernel.org/linux-cve-announce/2024052123-CVE-2021-47=
294-76ec@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6334665 ("netrom: switch to sock timer API") in v5.0-r=
c5.
Fixed in v5.14-rc3.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st stable/4.19

Fixed status
cip/4.4: [853262355518cd1247515b74e83fabf038aa6c29]
cip/4.4-rt: [853262355518cd1247515b74e83fabf038aa6c29]
cip/4.4-st: [853262355518cd1247515b74e83fabf038aa6c29]
mainline: [517a16b1a88bdb6b530f48d5d153478b2552d9a8]
stable/4.19: [9619cc7d97c3aa8ed3cfd2b8678b74fb6d6c7950]
stable/4.4: [853262355518cd1247515b74e83fabf038aa6c29]
stable/5.10: [6811744bd0efb9e472cb15d066cdb460beb8cb8a]
stable/5.4: [25df44e90ff5959b5c24ad361b648504a7e39ef3]

CVE-2021-47295: net: sched: fix memory leak in tcindex_partial_destroy_work

Announce: https://lore.kernel.org/linux-cve-announce/2024052124-CVE-2021-47=
295-cc64@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 331b729 ("net: sched: RCU cls_tcindex") in v3.18-rc1.
Fixed in v5.14-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5051bcece50140abd1a11a2d36dc3ec5484fc32]
stable/5.10: [8e9662fde6d63c78eb1350f6167f64c9d71a865b]
stable/5.4: [8d7924ce85bae64e7a67c366c7c50840f49f3a62]

CVE-2021-47296: KVM: PPC: Fix kvm_arch_vcpu_ioctl vcpu_load leak

Announce: https://lore.kernel.org/linux-cve-announce/2024052124-CVE-2021-47=
296-a208@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b3cebfe ("KVM: PPC: Move vcpu_load/vcpu_put down
to each ioctl case in kvm_arch_vcpu_ioctl") in v4.18-rc1.
Fixed in v5.14-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc4188a2f56e821ea057aca6bf444e138d06c252]
stable/4.19: [9bafc34dc4ad0cef18727c557f21ed3c3304df50]
stable/5.10: [e14ef1095387f764d95614d3ec9e4d07c82a3533]
stable/5.4: [f38527f1890543cdfca8dfd06f75f9887cce6151]

CVE-2021-47297: net: fix uninit-value in caif_seqpkt_sendmsg

Announce: https://lore.kernel.org/linux-cve-announce/2024052124-CVE-2021-47=
297-55b5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit bece7b2 ("caif: Rewritten socket implementation")
in v2.6.35-rc1.
Fixed in v5.14-rc3.

Fixed status
cip/4.4: [d9d646acad2c3590e189bb5d5c86ab8bd8a2dfc3]
cip/4.4-rt: [d9d646acad2c3590e189bb5d5c86ab8bd8a2dfc3]
cip/4.4-st: [d9d646acad2c3590e189bb5d5c86ab8bd8a2dfc3]
mainline: [991e634360f2622a683b48dfe44fe6d9cb765a09]
stable/4.19: [452c3ed7bf63721b07bc2238ed1261bb26027e85]
stable/4.4: [d9d646acad2c3590e189bb5d5c86ab8bd8a2dfc3]
stable/5.10: [1582a02fecffcee306663035a295e28e1c4aaaff]
stable/5.4: [9413c0abb57f70a953b1116318d6aa478013c35d]

CVE-2021-47298: bpf, sockmap: Fix potential memory leak on unlikely error c=
ase

Announce: https://lore.kernel.org/linux-cve-announce/2024052125-CVE-2021-47=
298-22d6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4363023 ("bpf, sockmap: Avoid failures from
skb_to_sgvec when skb has frag_list") in v5.10-rc5.
Fixed in v5.14-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e6b27a69167f97c56b5437871d29e9722c3e470]
stable/5.10: [715f378f42909c401ec043f5150c4fdf57fb8889]

CVE-2021-47299: xdp, net: Fix use-after-free in bpf_xdp_link_release

Announce: https://lore.kernel.org/linux-cve-announce/2024052125-CVE-2021-47=
299-e1d9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit aa8d3a7 ("bpf, xdp: Add bpf_link-based XDP
attachment API") in v5.9-rc1.
Fixed in v5.14-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5acc7d3e8d342858405fbbc671221f676b547ce7]
stable/5.10: [ca9ba1de8f09976b45ccc8e655c51c6201992139]

CVE-2021-47300: bpf: Fix tail_call_reachable rejection for interpreter
when jit failed

Announce: https://lore.kernel.org/linux-cve-announce/2024052125-CVE-2021-47=
300-eee0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ebf7d1f ("bpf, x64: rework pro/epilogue and
tailcall handling in JIT") in v5.10-rc1.
Introduced by commit e411901 ("bpf: allow for tailcalls in BPF
subprograms for x64 JIT") in v5.10-rc1.
Fixed in v5.14-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5dd0a6b8582ffbfa88351949d50eccd5b6694ade]
stable/5.10: [39f1735c8107ef43a53c4daf82f330d880488d8f]

CVE-2021-47301: igb: Fix use-after-free error during reset

Announce: https://lore.kernel.org/linux-cve-announce/2024052126-CVE-2021-47=
301-13b4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7cc6fd4 ("igb: Don't bother clearing Tx
buffer_info in igb_clean_tx_ring") in v4.12-rc1.
Fixed in v5.14-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b292608db23ccbbfbfa50cdb155d01725d7a52e]
stable/4.19: [d3ccb18ed5ac3283c7b31ecc685b499e580d5492]
stable/5.10: [f153664d8e70c11d0371341613651e1130e20240]
stable/5.4: [88e0720133d42d34851c8721cf5f289a50a8710f]

CVE-2021-47302: igc: Fix use-after-free error during reset

Announce: https://lore.kernel.org/linux-cve-announce/2024052126-CVE-2021-47=
302-0a00@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 13b5b7f ("igc: Add support for Tx/Rx rings") in v4.20-=
rc1.
Fixed in v5.14-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [56ea7ed103b46970e171eb1c95916f393d64eeff]
stable/5.10: [e15f629036bac005fc758b4ad17896cf2312add4]
stable/5.4: [a9508e0edfe369ac95d0825bcdca976436ce780f]

CVE-2021-47303: bpf: Track subprog poke descriptors correctly and fix
use-after-free

Announce: https://lore.kernel.org/linux-cve-announce/2024052126-CVE-2021-47=
303-72dc@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a748c69 ("bpf: propagate poke descriptors to
subprograms") in v5.10-rc1.
Fixed in v5.14-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f263a81451c12da5a342d90572e317e611846f2c]
stable/5.10: [a9f36bf3613c65cb587c70fac655c775d911409b]

CVE-2021-47304: tcp: fix tcp_init_transfer() to not reset icsk_ca_initializ=
ed

Announce: https://lore.kernel.org/linux-cve-announce/2024052126-CVE-2021-47=
304-fc16@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8919a9b ("tcp: Only init congestion control if
not initialized already") in v5.10-rc1.
Fixed in v5.14-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be5d1b61a2ad28c7e57fe8bfa277373e8ecffcdc]
stable/5.10: [ad4ba3404931745a5977ad12db4f0c34080e52f7]

CVE-2021-47305: dma-buf/sync_file: Don't leak fences on merge failure

Announce: https://lore.kernel.org/linux-cve-announce/2024052127-CVE-2021-47=
305-e1c5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a02b9dc ("dma-buf/sync_file: refactor fence
storage in struct sync_file") in v4.9-rc1.
Fixed in v5.14-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ffe000217c5068c5da07ccb1c0f8cce7ad767435]
stable/4.19: [e0355a0ad31a1d677b2a4514206de4902bd550e8]
stable/5.10: [0d514185ae792d3a1903c8e1a83899aa996705ce]
stable/5.4: [41f45e91c92c8480242ea448d54e28c753b13902]

CVE-2021-47306: net: fddi: fix UAF in fza_probe

Announce: https://lore.kernel.org/linux-cve-announce/2024052127-CVE-2021-47=
306-2af7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 61414f5 ("FDDI: defza: Add support for DEC
FDDIcontroller 700 in v4.20-rc1.
Fixed in v5.14-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [deb7178eb940e2c5caca1b1db084a69b2e59b4c9]
stable/5.10: [f33605908a9b6063525e9f68e62d739948c5fccf]
stable/5.4: [04b06716838bfc26742dbed3ae1d3697fe5317ee]

CVE-2021-47307: cifs: prevent NULL deref in cifs_compose_mount_options()

Announce: https://lore.kernel.org/linux-cve-announce/2024052127-CVE-2021-47=
307-f8a6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.
Linux 4.4 and 4.19 do not check if ref is NULL or not. If ref can be
NULL, they need to check ref parameter NULL check and ref->node_name
check.

Fixed status
mainline: [03313d1c3a2f086bb60920607ab79ac8f8578306]
stable/5.10: [e58c162789becede894d3e94c0ce6695a2ef5796]
stable/5.4: [f7d1fa65e74263d11f90ddd33b4d4cd905a93759]

CVE-2021-47308: scsi: libfc: Fix array index out of bound exception

Announce: https://lore.kernel.org/linux-cve-announce/2024052128-CVE-2021-47=
308-e3d8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.
Linux 4.4 seems to be affected.

Fixed status
mainline: [b27c4577557045f1ab3cdfeabfc7f3cd24aca1fe]
stable/4.19: [4921b1618045ffab71b1050bf0014df3313a2289]
stable/5.10: [a4a54c54af2516caa9c145015844543cfc84316a]
stable/5.4: [0fe70c15f9435bb3c50954778245d62ee38b0e03]

CVE-2021-47309: net: validate lwtstate->data before returning from
skb_tunnel_info()

Announce: https://lore.kernel.org/linux-cve-announce/2024052128-CVE-2021-47=
309-2889@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 61adedf ("route: move lwtunnel state to
dst_entry") in v4.3-rc1.
Fixed in v5.14-rc2.

Fixed status
cip/4.4: [e7f3c9df40515a6c6b46f36c4c94cf48a043f887]
cip/4.4-rt: [e7f3c9df40515a6c6b46f36c4c94cf48a043f887]
cip/4.4-st: [e7f3c9df40515a6c6b46f36c4c94cf48a043f887]
mainline: [67a9c94317402b826fc3db32afc8f39336803d97]
stable/4.19: [8bb1589c89e61e3b182dd546f1021928ebb5c2a6]
stable/4.4: [e7f3c9df40515a6c6b46f36c4c94cf48a043f887]
stable/5.10: [2179d96ec702cc33ead02a9ce40ece599b8538c5]
stable/5.4: [8aa13a86964cdec4fd969ef677c6614ff068641a]

CVE-2021-47310: net: ti: fix UAF in tlan_remove_one

Announce: https://lore.kernel.org/linux-cve-announce/2024052128-CVE-2021-47=
310-a59d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1e0a8b1 ("tlan: cancel work at remove path") in v3.10-=
rc1.
Fixed in v5.14-rc2.

Fixed status
cip/4.4: [a18a8d9cfbb112ad72e625372849adc3986fd6bf]
cip/4.4-rt: [a18a8d9cfbb112ad72e625372849adc3986fd6bf]
cip/4.4-st: [a18a8d9cfbb112ad72e625372849adc3986fd6bf]
mainline: [0336f8ffece62f882ab3012820965a786a983f70]
stable/4.19: [a0a817b2d308fac090a05cbbe80988e073ac5193]
stable/4.4: [a18a8d9cfbb112ad72e625372849adc3986fd6bf]
stable/5.10: [f2a062fcfe1d6f1b0a86fa76ae21c277d65f4405]
stable/5.4: [b7e5563f2a7862a9e4796abb9908b092f677e3c1]

CVE-2021-47311: net: qcom/emac: fix UAF in emac_remove

Announce: https://lore.kernel.org/linux-cve-announce/2024052129-CVE-2021-47=
311-47f4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 54e19bc ("net: qcom/emac: do not use devm on
internal phy pdev") in v4.9-rc1.
Fixed in v5.14-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ad297cd2db8953e2202970e9504cab247b6c7cb4]
stable/4.19: [11e9d163d631198bb3eb41a677a61b499516c0f7]
stable/5.10: [b560521eca03d0a2db6093a5a632cbdd0a0cf833]
stable/5.4: [2b70ca92847c619d6264c7372ef74fcbfd1e048c]

CVE-2021-47312: netfilter: nf_tables: Fix dereference of null pointer flow

Announce: https://lore.kernel.org/linux-cve-announce/2024052129-CVE-2021-47=
312-682b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3c5e446 ("netfilter: nf_tables: memleak in hw
offload abort path") in 5.14-rc1.
Fixed in 5.14-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ca041f919f13783b0b03894783deee00dbca19a]

CVE-2021-47313: cpufreq: CPPC: Fix potential memleak in cppc_cpufreq_cpu_in=
it

Announce: https://lore.kernel.org/linux-cve-announce/2024052129-CVE-2021-47=
313-af10@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a28b2bf ("cppc_cpufreq: replace per-cpu data
array with a list") in v5.11-rc1.
Fixed in v5.14-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe2535a44904a77615a3af8e8fd7dafb98fb0e1b]

CVE-2021-47314: memory: fsl_ifc: fix leak of private memory on probe failur=
e

Announce: https://lore.kernel.org/linux-cve-announce/2024052129-CVE-2021-47=
314-7860@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a20cbde ("powerpc/fsl: Add support for Integrated
Flash Controller") in v3.3-rc1.
Fixed in v5.14-rc1.

Fixed status
cip/4.4: [8018476756066e97ecb886c3dc024aeb7d5792ad]
cip/4.4-rt: [8018476756066e97ecb886c3dc024aeb7d5792ad]
cip/4.4-st: [8018476756066e97ecb886c3dc024aeb7d5792ad]
mainline: [8e0d09b1232d0538066c40ed4c13086faccbdff6]
stable/4.19: [ee1aa737ba0b75ab8af3444c4ae5bdba36aed6e6]
stable/4.4: [8018476756066e97ecb886c3dc024aeb7d5792ad]
stable/5.10: [b5789e23773f4a852fbfe244b63f675e265d3a7f]
stable/5.4: [443f6ca6fd186b4fa4e6f377b6e19a91feb1a0d5]

CVE-2021-47315: memory: fsl_ifc: fix leak of IO mapping on probe failure

Announce: https://lore.kernel.org/linux-cve-announce/2024052130-CVE-2021-47=
315-dbfa@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a20cbde ("powerpc/fsl: Add support for Integrated
Flash Controller") in v3.3-rc1.
Fixed in v5.14-rc1.

Fixed status
cip/4.4: [b7a2bcb4a3731d68f938207f75ed3e1d41774510]
cip/4.4-rt: [b7a2bcb4a3731d68f938207f75ed3e1d41774510]
cip/4.4-st: [b7a2bcb4a3731d68f938207f75ed3e1d41774510]
mainline: [3b132ab67fc7a358fff35e808fa65d4bea452521]
stable/4.19: [94bc2fe46102d1e060fc749c0c19511e76c9995f]
stable/4.4: [bd051b3e184fa56eeb6276ee913ba4d48069024b]
stable/5.10: [8d071d270afba468708faca5f7b6d9e656f75e27]
stable/5.4: [d9213d4f372d30b5bc4d921795d6bed0c0e3eebf]

CVE-2021-47316: nfsd: fix NULL dereference in nfs3svc_encode_getaclres

Announce: https://lore.kernel.org/linux-cve-announce/2024052130-CVE-2021-47=
316-e2c2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 20798df ("NFSD: Update the NFSv3 GETACL result
encoder...") in v5.13-rc1.
Fixed in v5.14-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab1016d39cc052064e32f25ad18ef8767a0ee3b8]

CVE-2021-47317: powerpc/bpf: Fix detecting BPF atomic instructions

Announce: https://lore.kernel.org/linux-cve-announce/2024052130-CVE-2021-47=
317-3729@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 91c960b ("bpf: Rename BPF_XADD and prepare to
encode other atomics in .imm") in v5.12-rc1.
Fixed in v5.14-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [419ac821766cbdb9fd85872bb3f1a589df05c94c]

CVE-2021-47318: arch_topology: Avoid use-after-free for scale_freq_data

Announce: https://lore.kernel.org/linux-cve-announce/2024052131-CVE-2021-47=
318-fffb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 01e055c ("arch_topology: Allow multiple entities
to provide sched_freq_tick() callback") in v5.13-rc1.
Fixed in v5.14-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83150f5d05f065fb5c12c612f119015cabdcc124]

CVE-2021-47319: virtio-blk: Fix memory leak among suspend/resume procedure

Announce: https://lore.kernel.org/linux-cve-announce/2024052131-CVE-2021-47=
319-9548@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.

Fixed status
cip/4.4: [381bde79d11e596002edfd914e6714291826967a]
cip/4.4-rt: [381bde79d11e596002edfd914e6714291826967a]
cip/4.4-st: [381bde79d11e596002edfd914e6714291826967a]
mainline: [b71ba22e7c6c6b279c66f53ee7818709774efa1f]
stable/4.19: [600942d2fd49b90e44857d20c774b20d16f3130f]
stable/4.4: [381bde79d11e596002edfd914e6714291826967a]
stable/5.10: [cd24da0db9f75ca11eaf6060f0ccb90e2f3be3b0]
stable/5.4: [04c6e60b884cb5e94ff32af46867fb41d5848358]

CVE-2021-47320: nfs: fix acl memory leak of posix_acl_create()

Announce: https://lore.kernel.org/linux-cve-announce/2024052131-CVE-2021-47=
320-9a42@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 013cdf1 ("nfs: use generic posix ACL
infrastructure for v3 Posix ACLs") in v3.14-rc1.
Fixed in v5.14-rc1.

Fixed status
cip/4.4: [2e3960f276b4574a9bb0dfa31a7497302f6363b2]
cip/4.4-rt: [2e3960f276b4574a9bb0dfa31a7497302f6363b2]
cip/4.4-st: [2e3960f276b4574a9bb0dfa31a7497302f6363b2]
mainline: [1fcb6fcd74a222d9ead54d405842fc763bb86262]
stable/4.19: [0704f617040c397ae73c1f88f3956787ec5d6529]
stable/4.4: [2e3960f276b4574a9bb0dfa31a7497302f6363b2]
stable/5.10: [4b515308ab875c7e8ada8e606fe0c64762da5ed4]
stable/5.4: [d0b32dc1409f7e65e4fcc34e236462268e69a357]

CVE-2021-47321: watchdog: Fix possible use-after-free by calling
del_timer_sync()

Announce: https://lore.kernel.org/linux-cve-announce/2024052132-CVE-2021-47=
321-1b9b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.

Fixed status
cip/4.4: [58606882ad8ec6c39e0f40344b922921ef94ab4d]
cip/4.4-rt: [58606882ad8ec6c39e0f40344b922921ef94ab4d]
cip/4.4-st: [58606882ad8ec6c39e0f40344b922921ef94ab4d]
mainline: [d0212f095ab56672f6f36aabc605bda205e1e0bf]
stable/4.19: [ecd620e0fb1ff7f78fdb593379b2e6938c99707a]
stable/4.4: [58606882ad8ec6c39e0f40344b922921ef94ab4d]
stable/5.10: [66ba9cf929b1c4fabf545bd4c18f6f64e23e46e4]
stable/5.4: [db222f1477ad5692cd454709b714949807e5d111]

CVE-2021-47322: NFSv4: Fix an Oops in pnfs_mark_request_commit() when
doing O_DIRECT

Announce: https://lore.kernel.org/linux-cve-announce/2024052132-CVE-2021-47=
322-e9cb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9c455a8 ("NFS/pNFS: Clean up pNFS commit
operations") in v5.7-rc1.
Fixed in v5.14-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3731d44bba8e0116b052b1b374476c5f6dd9a456]
stable/5.10: [5c7ef8a3705542136a1e19b070e951f0730b2153]

CVE-2021-47323: watchdog: sc520_wdt: Fix possible use-after-free in
wdt_turnoff()

Announce: https://lore.kernel.org/linux-cve-announce/2024052132-CVE-2021-47=
323-deae@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.

Fixed status
cip/4.4: [0015581a79bbf8e521f85dddb7d3e4a66b9f51d4]
cip/4.4-rt: [0015581a79bbf8e521f85dddb7d3e4a66b9f51d4]
cip/4.4-st: [0015581a79bbf8e521f85dddb7d3e4a66b9f51d4]
mainline: [90b7c141132244e8e49a34a4c1e445cce33e07f4]
stable/4.19: [522e75ed63f67e815d4ec0deace67df22d9ce78e]
stable/4.4: [0015581a79bbf8e521f85dddb7d3e4a66b9f51d4]
stable/5.10: [a173e3b62cf6dd3c4a0a10c8a82eedfcae81a566]
stable/5.4: [7c56c5508dc20a6b133bc669fc34327a6711c24c]

CVE-2021-47324: watchdog: Fix possible use-after-free in wdt_startup()

Announce: https://lore.kernel.org/linux-cve-announce/2024052132-CVE-2021-47=
324-c15a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.

Fixed status
cip/4.4: [63a3dc24bd053792f84cb4eef0168b1266202a02]
cip/4.4-rt: [63a3dc24bd053792f84cb4eef0168b1266202a02]
cip/4.4-st: [63a3dc24bd053792f84cb4eef0168b1266202a02]
mainline: [c08a6b31e4917034f0ed0cb457c3bb209576f542]
stable/4.19: [dc9403097be52d57a5c9c35efa9be79d166a78af]
stable/4.4: [63a3dc24bd053792f84cb4eef0168b1266202a02]
stable/5.10: [a397cb4576fc2fc802562418b3a50b8f67d60d31]
stable/5.4: [146cc288fb80c662c9c35e7bc58325d1ac0a7875]

CVE-2021-47325: iommu/arm-smmu: Fix arm_smmu_device refcount leak in
address translation

Announce: https://lore.kernel.org/linux-cve-announce/2024052133-CVE-2021-47=
325-f4e8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.

Fixed status
mainline: [7c8f176d6a3fa18aa0f8875da6f7c672ed2a8554]
stable/5.10: [43d1aaa1965f9b58035196dac49b1e1e6c9c25eb]
stable/5.4: [b11220803ad14a2a880cc06d8e01fe2548cc85b0]

CVE-2021-47326: x86/signal: Detect and prevent an alternate signal
stack overflow

Announce: https://lore.kernel.org/linux-cve-announce/2024052133-CVE-2021-47=
326-fd53@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c2bc11f ("x86, AVX-512: Enable AVX-512 States
Context Switch") in v3.15-rc1.
Fixed in v5.14-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2beb4a53fc3f1081cedc1c1a198c7f56cc4fc60c]
stable/5.10: [74569cb9ed7bc60e395927f55d3dc3be143a0164]
stable/5.4: [00fcd8f33e9b9f57115c3b1cfc4cb96450c18796]

CVE-2021-47327: iommu/arm-smmu: Fix arm_smmu_device refcount leak when
arm_smmu_rpm_get fails

Announce: https://lore.kernel.org/linux-cve-announce/2024052133-CVE-2021-47=
327-bbe1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.

Fixed status
mainline: [1adf30f198c26539a62d761e45af72cde570413d]
stable/5.10: [c4007596fbdabc29f858dc2e1990858a146b60b2]
stable/5.4: [3761ae0d0e549f2acdaf11f49df4ed06d256b20f]

CVE-2021-47328: scsi: iscsi: Fix conn use after free during resets

Announce: https://lore.kernel.org/linux-cve-announce/2024052134-CVE-2021-47=
328-441f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.

Fixed status
mainline: [ec29d0ac29be366450a7faffbcf8cba3a6a3b506]
stable/4.19: [bf20d85a88384574fabb3d53ad62a8af57e7ab11]
stable/5.10: [89812e7957ab0746eab66ed6fc49d52bb4dca250]
stable/5.4: [d04958a348e560938410e04a12fb99da9c7e6a00]

CVE-2021-47329: scsi: megaraid_sas: Fix resource leak in case of probe fail=
ure

Announce: https://lore.kernel.org/linux-cve-announce/2024052134-CVE-2021-47=
329-fb26@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.
It seems to be Linux 4.4 is affected.

Fixed status
mainline: [b5438f48fdd8e1c3f130d32637511efd32038152]
stable/5.10: [0680db6f41920b2c91c7df3cc9cd5968701a6f74]
stable/5.4: [0c6226601c3e191a44a57d8f9f814b7e5c308959]

CVE-2021-47330: tty: serial: 8250: serial_cs: Fix a memory leak in
error handling path

Announce: https://lore.kernel.org/linux-cve-announce/2024052134-CVE-2021-47=
330-f142@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.

Fixed status
cip/4.4: [b5a2799cd62ed30c81b22c23028d9ee374e2138c]
cip/4.4-rt: [b5a2799cd62ed30c81b22c23028d9ee374e2138c]
cip/4.4-st: [b5a2799cd62ed30c81b22c23028d9ee374e2138c]
mainline: [fad92b11047a748c996ebd6cfb164a63814eeb2e]
stable/4.19: [cddee5c287e26f6b2ba5c0ffdfc3a846f2f10461]
stable/4.4: [b5a2799cd62ed30c81b22c23028d9ee374e2138c]
stable/5.10: [7a80f71601af015856a0aeb1e3c294037ac3dd32]
stable/5.4: [ee16bed959862a6de2913f71a04cb563d7237b67]

CVE-2021-47331: usb: common: usb-conn-gpio: fix NULL pointer
dereference of charger

Announce: https://lore.kernel.org/linux-cve-announce/2024052134-CVE-2021-47=
331-283e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.
The usb-conn-gpio.c was added by commit 4602f3b ("usb: common: add USB
GPIO based connection detection driver") in 5.4-rc1.
Affected code in usb_conn_probe() was introduced by commit e3ee0e7
("usb: common: usb-conn-gpio: Register charger") in 5.9-rc1.
so Linux 4.4 and 5.4 seem to be not affected.

Fixed status
mainline: [880287910b1892ed2cb38977893b947382a09d21]
stable/5.10: [8e8d910e9a3a7fba86140aff4924c30955ab228b]

CVE-2021-47332: ALSA: usx2y: Don't call free_pages_exact() with NULL addres=
s

Announce: https://lore.kernel.org/linux-cve-announce/2024052135-CVE-2021-47=
332-33c9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.
free_pages_exact() was used since commit 36b8def ("ALSA: us122l: Use
alloc_pages_exact()") in 5.2-rc1 instead of using free_pages().
However, it would be nice to check NULL pointer for free_pages().

Fixed status
mainline: [cae0cf651adccee2c3f376e78f30fbd788d0829f]
stable/5.10: [7d7f30cf182e55023fa8fde4c084b2d37c6be69d]
stable/5.4: [88262229b778f4f7a896da828d966f94dcb35d19]

CVE-2021-47333: misc: alcor_pci: fix null-ptr-deref when there is no PCI br=
idge

Announce: https://lore.kernel.org/linux-cve-announce/2024052135-CVE-2021-47=
333-ed1e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.
It seems as if this bug was introduced by commit 4f556bc0 ("misc:
cardreader: add new Alcor Micro Cardreader PCI driver") in 5.0-rc1.

Fixed status
mainline: [3ce3e45cc333da707d4d6eb433574b990bcc26f5]
stable/5.10: [58f69684ba03e5b0e0a3ae844a845280c0f06309]
stable/5.4: [d2639ffdcad463b358b6bef8645ff81715daffcb]

CVE-2021-47334: misc/libmasm/module: Fix two use after free in ibmasm_init_=
one

Announce: https://lore.kernel.org/linux-cve-announce/2024052135-CVE-2021-47=
334-433e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.

Fixed status
cip/4.4: [1512e7dc5eb08b7d92a12e2bfcd9cb8c4a1ec069]
cip/4.4-rt: [1512e7dc5eb08b7d92a12e2bfcd9cb8c4a1ec069]
cip/4.4-st: [1512e7dc5eb08b7d92a12e2bfcd9cb8c4a1ec069]
mainline: [7272b591c4cb9327c43443f67b8fbae7657dd9ae]
stable/4.19: [481a76d4749ee3a27f902ba213fdcbb4bb39720e]
stable/4.4: [1512e7dc5eb08b7d92a12e2bfcd9cb8c4a1ec069]
stable/5.10: [b9c87ce3bc6331f82811a8cf8e930423c22523a3]
stable/5.4: [38660031e80eaa6cc9370b031c180612f414b00d]

CVE-2021-47335: f2fs: fix to avoid racing on fsync_entry_slab by multi
filesystem instances

Announce: https://lore.kernel.org/linux-cve-announce/2024052136-CVE-2021-47=
335-23c8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.
It looks as if Linux 4.4, 4.19, and 5.4 are affected too.

Fixed status
mainline: [cad83c968c2ebe97905f900326988ed37146c347]
stable/5.10: [86786603014e0a22d0d6af8e80ae4b8687927048]

CVE-2021-47336: smackfs: restrict bytes count in smk_set_cipso()

Announce: https://lore.kernel.org/linux-cve-announce/2024052136-CVE-2021-47=
336-b6a7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.
It looks as if add PAGE_SIZE check to Linux 4.4 would be nice.

Fixed status
mainline: [49ec114a6e62d8d320037ce71c1aaf9650b3cafd]
stable/4.19: [cbd87ba6a13891acf6180783f8234a8b7a3e3d4d]
stable/5.10: [3780348c1a0e14ffefcaf1fc521f815bcaac94b0]
stable/5.4: [135122f174c357b7a3e58f40fa5792156c5e93e6]

CVE-2021-47337: scsi: core: Fix bad pointer dereference when ehandler
kthread is invalid

Announce: https://lore.kernel.org/linux-cve-announce/2024052136-CVE-2021-47=
337-4863@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 66a834d ("scsi: core: Fix error handling of
scsi_host_alloc()") in v5.13-rc6.
Fixed in v5.14-rc2.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt stable/4.19 stable/5.10 stable/5.=
4

Fixed status
mainline: [93aa71ad7379900e61c8adff6a710a4c18c7c99b]
stable/4.19: [e1bd3fac2baa3d5c04375980c1d5263a3335af92]
stable/5.10: [ea518b70ed5e4598c8d706f37fc16f7b06e440bd]
stable/5.4: [887bfae2732b5b02a86a859fd239d34f7ff93c05]

CVE-2021-47338: fbmem: Do not delete the mode that is still in use

Announce: https://lore.kernel.org/linux-cve-announce/2024052137-CVE-2021-47=
338-cd10@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 13ff178 ("fbcon: Call
fbcon_mode_deleted/new_modelist directly") in v5.3-rc1.
Fixed in v5.14-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0af778269a522c988ef0b4188556aba97fb420cc]
stable/5.10: [087bff9acd2ec6db3f61aceb3224bde90fe0f7f8]
stable/5.4: [359311b85ebec7c07c3a08ae2f3def946cad33fa]

CVE-2021-47339: media: v4l2-core: explicitly clear ioctl input data

Announce: https://lore.kernel.org/linux-cve-announce/2024052137-CVE-2021-47=
339-6d3e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.
It looks as if this bug was introduced by commit 8dbcc3f ("media:
v4l2: prepare compat-ioctl rework") in 5.11-rc1.

Fixed status
mainline: [7b53cca764f9b291b7907fcd39d9e66ad728ee0b]

CVE-2021-47340: jfs: fix GPF in diFree

Announce: https://lore.kernel.org/linux-cve-announce/2024052137-CVE-2021-47=
340-059b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.

Fixed status
cip/4.4: [7bde24bde490f3139eee147efc6d60d6040fe975]
cip/4.4-rt: [7bde24bde490f3139eee147efc6d60d6040fe975]
cip/4.4-st: [7bde24bde490f3139eee147efc6d60d6040fe975]
mainline: [9d574f985fe33efd6911f4d752de6f485a1ea732]
stable/4.19: [aff8d95b69051d0cf4acc3d91f22299fdbb9dfb3]
stable/4.4: [7bde24bde490f3139eee147efc6d60d6040fe975]
stable/5.10: [8018936950360f1c503bb385e158cfc5e4945d18]
stable/5.4: [a21e5cb1a64c904f1f0ef7b2d386fc7d2b1d2ce2]

CVE-2021-47341: KVM: mmio: Fix use-after-free Read in
kvm_vm_ioctl_unregister_coalesced_mmio

Announce: https://lore.kernel.org/linux-cve-announce/2024052137-CVE-2021-47=
341-f4e9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5d3c4c7 ("KVM: Stop looking for coalesced MMIO
zones if the bus is destroyed", 2021-04-20) in v5.13-rc1.
Fixed in v5.14-rc2.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [23fa2e46a5556f787ce2ea1a315d3ab93cced204]
stable/5.10: [679837dc0abaa2c6e2a7bcd86483e05eee1d5066]
stable/5.4: [f2ff9d03432fcb160e9f7d4be26174d89de2779a]

CVE-2021-47342: ext4: fix possible UAF when remounting r/o a
mmp-protected file system

Announce: https://lore.kernel.org/linux-cve-announce/2024052138-CVE-2021-47=
342-bfd5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.
According to the commit log, this bug was introduced by commit
618f0031 ("ext4: fix memory leak in ext4_fill_super") in 5.14-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [61bb4a1c417e5b95d9edb4f887f131de32e419cb]
stable/5.10: [b663890d854403e566169f7e90aed5cd6ff64f6b]

CVE-2021-47343: dm btree remove: assign new_root only when removal succeeds

Announce: https://lore.kernel.org/linux-cve-announce/2024052138-CVE-2021-47=
343-1974@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.

Fixed status
cip/4.4: [4c84b3e0728ffe10d89c633694c35a02b5c477dc]
cip/4.4-rt: [4c84b3e0728ffe10d89c633694c35a02b5c477dc]
cip/4.4-st: [4c84b3e0728ffe10d89c633694c35a02b5c477dc]
mainline: [b6e58b5466b2959f83034bead2e2e1395cca8aeb]
stable/4.19: [8fbae4a1bdb5b889490cdee929e68540151536e5]
stable/4.4: [4c84b3e0728ffe10d89c633694c35a02b5c477dc]
stable/5.10: [ba47e65a5de3e0e8270301a409fc63d3129fdb9e]
stable/5.4: [964d57d1962d7e68f0f578f05d9ae4a104d74851]

CVE-2021-47344: media: zr364xx: fix memory leak in zr364xx_start_readpipe

Announce: https://lore.kernel.org/linux-cve-announce/2024052138-CVE-2021-47=
344-ea37@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ccbf035 ("V4L/DVB (12278): zr364xx: implement
V4L2_CAP_STREAMING") in v2.6.32-rc1.
Fixed in v5.14-rc1.

Fixed status
cip/4.4: [c57b2bd3247925e253729dce283d6bf6abc9339d]
cip/4.4-rt: [c57b2bd3247925e253729dce283d6bf6abc9339d]
cip/4.4-st: [c57b2bd3247925e253729dce283d6bf6abc9339d]
mainline: [0a045eac8d0427b64577a24d74bb8347c905ac65]
stable/4.19: [021c294dff030f3ba38eb81e400ba123db32ecbc]
stable/4.4: [c57b2bd3247925e253729dce283d6bf6abc9339d]
stable/5.10: [c57bfd8000d7677bf435873b440eec0c47f73a08]
stable/5.4: [0edd6759167295ea9969e89283b81017b4c688aa]

CVE-2021-47345: RDMA/cma: Fix rdma_resolve_route() memory leak

Announce: https://lore.kernel.org/linux-cve-announce/2024052139-CVE-2021-47=
345-8da7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.

Fixed status
cip/4.4: [40b613db3a95bc27998e4097d74c2f7e5d083a0b]
cip/4.4-rt: [40b613db3a95bc27998e4097d74c2f7e5d083a0b]
cip/4.4-st: [40b613db3a95bc27998e4097d74c2f7e5d083a0b]
mainline: [74f160ead74bfe5f2b38afb4fcf86189f9ff40c9]
stable/4.19: [4893c938f2a140a74be91779e45e4a7fa111198f]
stable/4.4: [40b613db3a95bc27998e4097d74c2f7e5d083a0b]
stable/5.10: [3d08b5917984f737f32d5bee9737b9075c3895c6]
stable/5.4: [032c68b4f5be128a2167f35b558b7cec88fe4972]

CVE-2021-47346: coresight: tmc-etf: Fix global-out-of-bounds in
tmc_update_etf_buffer()

Announce: https://lore.kernel.org/linux-cve-announce/2024052139-CVE-2021-47=
346-dcfa@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0c3fc4d ("coresight: Add barrier packet for
synchronisation") in v4.14-rc1.
Fixed in v5.14-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5fae8a946ac2df879caf3f79a193d4766d00239b]
stable/4.19: [04bd77ef4f4d9fc6102023b85f4590fc2130aac5]
stable/5.10: [35c1c4bd2d59ad734129d4e232af9d1098023918]
stable/5.4: [ef0a06acc6b16388640ad367eedfa2a17f1945db]

CVE-2021-47347: wl1251: Fix possible buffer overflow in wl1251_cmd_scan

Announce: https://lore.kernel.org/linux-cve-announce/2024052139-CVE-2021-47=
347-82e1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.

Fixed status
cip/4.4: [57ad99ae3c6738ba87bad259bb57c641ca68ebf6]
cip/4.4-rt: [57ad99ae3c6738ba87bad259bb57c641ca68ebf6]
cip/4.4-st: [57ad99ae3c6738ba87bad259bb57c641ca68ebf6]
mainline: [d10a87a3535cce2b890897914f5d0d83df669c63]
stable/4.19: [115103f6e3f1c26c473766c16439c7c8b235529a]
stable/4.4: [57ad99ae3c6738ba87bad259bb57c641ca68ebf6]
stable/5.10: [c5e4a10d7bd5d4f419d8b9705dff60cf69b302a1]
stable/5.4: [d71dddeb5380613f9ef199f3e7368fd78fb1a46e]

CVE-2021-47348: drm/amd/display: Avoid HDCP over-read and corruption

Announce: https://lore.kernel.org/linux-cve-announce/2024052140-CVE-2021-47=
348-df7d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.
It looks as if this bug was introduced by commit a1acc5d0
("drm/amd/display: Fix static analysis bug in validate_bksv" in
5.6-rc1.

Fixed status
mainline: [06888d571b513cbfc0b41949948def6cb81021b2]
stable/5.10: [c5b518f4b98dbb2bc31b6a55e6aaa1e0e2948f2e]

CVE-2021-47349: mwifiex: bring down link before deleting interface

Announce: https://lore.kernel.org/linux-cve-announce/2024052140-CVE-2021-47=
349-9828@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a05829a ("cfg80211: avoid holding the RTNL when
calling the driver") in v5.12-rc1.
Fixed in v5.14-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f9482aa8d412b4ba06ce6ab8e333fb8ca29a06e]

CVE-2021-47350: powerpc/mm: Fix lockup on kernel exec fault

Announce: https://lore.kernel.org/linux-cve-announce/2024052140-CVE-2021-47=
350-08a8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d3ca587 ("powerpc/mm: Fix reporting of kernel
execute faults") in v4.14-rc1.
Fixed in v5.14-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cd5d5e602f502895e47e18cd46804d6d7014e65c]
stable/5.10: [d2e52d4664097a6c1f591d869ec594bd7a0d4925]
stable/5.4: [a82471a14aad90f79d1608d2bcbb019f0ffb53f0]

CVE-2021-47351: ubifs: Fix races between xattr_{set|get} and listxattr
operations

Announce: https://lore.kernel.org/linux-cve-announce/2024052140-CVE-2021-47=
351-8e6c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1e51764 ("UBIFS: add new flash file system") in
v2.6.27-rc1.
Fixed in v5.14-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f4e3634a3b642225a530c292fdb1e8a4007507f5]
stable/5.10: [38dde03eb239605f428f3f1e4baa73d4933a4cc6]
stable/5.4: [7adc05b73d91a5e3d4ca7714fa53ad9b70c53d08]

CVE-2021-47352: virtio-net: Add validation for used length

Announce: https://lore.kernel.org/linux-cve-announce/2024052141-CVE-2021-47=
352-df50@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.

Fixed status
mainline: [ad993a95c508417acdeb15244109e009e50d8758]
stable/5.10: [c92298d228f61589dd21657af2bea95fc866b813]

CVE-2021-47353: udf: Fix NULL pointer dereference in udf_symlink function

Announce: https://lore.kernel.org/linux-cve-announce/2024052141-CVE-2021-47=
353-8d3a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.

Fixed status
cip/4.4: [2f3d9ddd32a28803baa547e6274983b67d5e287c]
cip/4.4-rt: [2f3d9ddd32a28803baa547e6274983b67d5e287c]
cip/4.4-st: [2f3d9ddd32a28803baa547e6274983b67d5e287c]
mainline: [fa236c2b2d4436d9f19ee4e5d5924e90ffd7bb43]
stable/4.19: [3638705ecd5ad2785e996f820121c0ad15ce64b5]
stable/4.4: [2f3d9ddd32a28803baa547e6274983b67d5e287c]
stable/5.10: [21bf1414580c36ffc8d8de043beb3508cf812238]
stable/5.4: [80d505aee6398cf8beb72475c7edcf1733c1c68b]

CVE-2021-47354: drm/sched: Avoid data corruptions

Announce: https://lore.kernel.org/linux-cve-announce/2024052141-CVE-2021-47=
354-79f4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.

Fixed status
mainline: [0b10ab80695d61422337ede6ff496552d8ace99d]
stable/5.10: [0687411e2a8858262de2fc4a1d576016fd77292e]
stable/5.4: [c32d0f0e164ffab2a56c7cf8e612584b4b740e2e]

CVE-2021-47355: atm: nicstar: Fix possible use-after-free in nicstar_cleanu=
p()

Announce: https://lore.kernel.org/linux-cve-announce/2024052142-CVE-2021-47=
355-b7d6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.

Fixed status
cip/4.4: [99779c9d9ffc7775da6f7fd8a7c93ac61657bed5]
cip/4.4-rt: [99779c9d9ffc7775da6f7fd8a7c93ac61657bed5]
cip/4.4-st: [99779c9d9ffc7775da6f7fd8a7c93ac61657bed5]
mainline: [34e7434ba4e97f4b85c1423a59b2922ba7dff2ea]
stable/4.19: [a7a7b2848312cc4c3a42b6e42a8ab2e441857aba]
stable/4.4: [99779c9d9ffc7775da6f7fd8a7c93ac61657bed5]
stable/5.10: [a7f7c42e31157d1f0871d6a8e1a0b73a6b4ea785]
stable/5.4: [bdf5334250c69fabf555b7322c75249ea7d5f148]

CVE-2021-47356: mISDN: fix possible use-after-free in HFC_cleanup()

Announce: https://lore.kernel.org/linux-cve-announce/2024052142-CVE-2021-47=
356-a3d4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.

Fixed status
cip/4.4: [49331c07ef0f8fdfa42b30ba6a83a657b29d7fbe]
cip/4.4-rt: [49331c07ef0f8fdfa42b30ba6a83a657b29d7fbe]
cip/4.4-st: [49331c07ef0f8fdfa42b30ba6a83a657b29d7fbe]
mainline: [009fc857c5f6fda81f2f7dd851b2d54193a8e733]
stable/4.19: [5f2818185da0fe82a932f0856633038b66faf124]
stable/4.4: [49331c07ef0f8fdfa42b30ba6a83a657b29d7fbe]
stable/5.10: [b7ee9ae1e0cf55a037c4a99af2acc5d78cb7802d]
stable/5.4: [3ecd228c636ee17c14662729737fa07242a93cb0]

CVE-2021-47357: atm: iphase: fix possible use-after-free in ia_module_exit(=
)

Announce: https://lore.kernel.org/linux-cve-announce/2024052142-CVE-2021-47=
357-f13e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.14-rc1.

Fixed status
cip/4.4: [9e161687855175334ca93c6c3ccb221731194479]
cip/4.4-rt: [9e161687855175334ca93c6c3ccb221731194479]
cip/4.4-st: [9e161687855175334ca93c6c3ccb221731194479]
mainline: [1c72e6ab66b9598cac741ed397438a52065a8f1f]
stable/4.19: [89ce0b0747f319eb70f85bc820dcc43cebbd5417]
stable/4.4: [9e161687855175334ca93c6c3ccb221731194479]
stable/5.10: [e759ff76ebbbfcdcf83b6634c54dc47828573d8b]
stable/5.4: [c9172498d4d62c9b64e5fb37c1ee0343e65fe51b]

CVE-2021-47358: staging: greybus: uart: fix tty use after free

Announce: https://lore.kernel.org/linux-cve-announce/2024052151-CVE-2021-47=
358-3a8d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a18e151 ("greybus: more uart work") in v4.9-rc1.
Fixed in v5.15-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [92dc0b1f46e12cfabd28d709bb34f7a39431b44f]
stable/4.19: [a5cfd51f6348e8fd7531461366946039c29c7e69]
stable/5.10: [b9e697e60ce9890e9258a73eb061288e7d68e5e6]
stable/5.4: [4dc56951a8d9d61d364d346c61a5f1d70b4f5e14]

CVE-2021-47359: cifs: Fix soft lockup during fsstress

Announce: https://lore.kernel.org/linux-cve-announce/2024052136-CVE-2021-47=
359-d5d1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.15-rc3.
It looks as if this bug was introduced by commit 9e99275 ("cifs: Call
close synchronously during unlink/rename/lease break.") in 5.14-rc6.

Fixed status
mainline: [71826b068884050d5fdd37fda857ba1539c513d3]

CVE-2021-47360: binder: make sure fd closes complete

Announce: https://lore.kernel.org/linux-cve-announce/2024052137-CVE-2021-47=
360-756a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 80cd795 ("binder: fix use-after-free due to
ksys_close() during fdget()") in v5.0-rc1.
Fixed in v5.15-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5fdb55c1ac9585eb23bb2541d5819224429e103d]
stable/5.10: [d5b0473707fa53b03a5db0256ce62b2874bddbc7]
stable/5.4: [aa2c274c279ff365a06a4cba263f04965895166e]

CVE-2021-47361: mcb: fix error handling in mcb_alloc_bus()

Announce: https://lore.kernel.org/linux-cve-announce/2024052137-CVE-2021-47=
361-855d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5d9e2ab ("mcb: Implement bus->dev.release
callback") in v4.7-rc1.
Introduced by commit 18d2881 ("mcb: Correctly initialize the bus's
device") in v4.7-rc1.
Fixed in v5.15-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [25a1433216489de4abc889910f744e952cb6dbae]
stable/4.19: [66f74ba9be9daf9c47fface6af3677f602774f6b]
stable/5.10: [91e4ad05bf18322b5921d1a6c9b603f6eb1694f0]
stable/5.4: [7751f609eadf36b1f53712bae430019c53a16eb0]

CVE-2021-47362: drm/amd/pm: Update intermediate power state for SI

Announce: https://lore.kernel.org/linux-cve-announce/2024052137-CVE-2021-47=
362-ce0d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.15-rc3.
According to the bug tracker issue
1698(https://gitlab.freedesktop.org/drm/amd/-/issues/1698),
commit f9b7f370 ("drm/amdgpu/acpi: make ATPX/ATCS structures global
(v2)") in 5.14-rc1 is first bad commit.

Fixed status
mainline: [ab39d3cef526ba09c4c6923b4cd7e6ec1c5d4faa]
stable/5.10: [68d4fbe6220cd1f3d07cab0a4901e62f8c12cc68]

CVE-2021-47363: nexthop: Fix division by zero while replacing a resilient g=
roup

Announce: https://lore.kernel.org/linux-cve-announce/2024052138-CVE-2021-47=
363-5c46@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 283a72a ("nexthop: Add implementation of
resilient next-hop groups") in v5.13-rc1.
Fixed in v5.15-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [563f23b002534176f49524b5ca0e1d94d8906c40]

CVE-2021-47364: comedi: Fix memory leak in compat_insnlist()

Announce: https://lore.kernel.org/linux-cve-announce/2024052138-CVE-2021-47=
364-a7c7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b8d47d8 ("comedi: get rid of
compat_alloc_user_space() mess in COMEDI_INSNLIST compat") in
v5.8-rc1.
Fixed in v5.15-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bb509a6ffed2c8b0950f637ab5779aa818ed1596]
stable/5.10: [8d6a21e4cd6a319b0662cbe4ad6199e276ac776a]

CVE-2021-47365: afs: Fix page leak

Announce: https://lore.kernel.org/linux-cve-announce/2024052138-CVE-2021-47=
365-d5ef@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e87b03f ("afs: Prepare for use of THPs") in v5.13-rc1.
Fixed in v5.15-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [581b2027af0018944ba301d68e7af45c6d1128b5]

CVE-2021-47366: afs: Fix corruption in reads at fpos 2G-4G from an
OpenAFS server

Announce: https://lore.kernel.org/linux-cve-announce/2024052139-CVE-2021-47=
366-04ed@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b9b1f8d ("AFS: write support fixes") in v2.6.22-rc1.
Fixed in v5.15-rc3.

Fixed status
mainline: [b537a3c21775075395af475dcc6ef212fcf29db8]

CVE-2021-47367: virtio-net: fix pages leaking when building skb in big mode

Announce: https://lore.kernel.org/linux-cve-announce/2024052139-CVE-2021-47=
367-f587@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit fb32856 ("virtio-net: page_to_skb() use build_skb
when there's sufficient tailroom") in v5.13-rc1.
Fixed in v5.15-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [afd92d82c9d715fb97565408755acad81573591a]

CVE-2021-47368: enetc: Fix illegal access when reading affinity_hint

Announce: https://lore.kernel.org/linux-cve-announce/2024052139-CVE-2021-47=
368-1290@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d4fd040 ("enetc: Introduce basic PF and VF ENETC
ethernet drivers") in v5.1-rc1.
Fixed in v5.15-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7237a494decfa17d0b9d0076e6cee3235719de90]
stable/5.10: [6c3f1b741c6c2914ea120e3a5790d3e900152f7b]
stable/5.4: [4c4c3052911b577920353a7646e4883d5da40c28]

CVE-2021-47369: s390/qeth: fix NULL deref in qeth_clear_working_pool_list()

Announce: https://lore.kernel.org/linux-cve-announce/2024052139-CVE-2021-47=
369-a5fc@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit eff73e1 ("s390/qeth: tolerate pre-filled RX
buffer") in v5.9-rc1.
Fixed in v5.15-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [248f064af222a1f97ee02c84a98013dfbccad386]
stable/5.10: [db94f89e1dadf693c15c2d60de0c34777cea5779]

CVE-2021-47370: mptcp: ensure tx skbs always have the MPTCP ext

Announce: https://lore.kernel.org/linux-cve-announce/2024052140-CVE-2021-47=
370-707f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1094c6f ("mptcp: fix possible divide by zero") in 5.15=
-rc1.
Fixed in 5.15-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [977d293e23b48a1129830d7968605f61c4af71a0]

CVE-2021-47371: nexthop: Fix memory leaks in nexthop notification
chain listeners

Announce: https://lore.kernel.org/linux-cve-announce/2024052140-CVE-2021-47=
371-9e42@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2a014b2 ("mlxsw: spectrum_router: Add support for
nexthop objects") in v5.11-rc1.
Fixed in v5.15-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3106a0847525befe3e22fc723909d1b21eb0d520]

CVE-2021-47372: net: macb: fix use after free on rmmod

Announce: https://lore.kernel.org/linux-cve-announce/2024052140-CVE-2021-47=
372-ecc4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.15-rc2.
This bug was introduced by commit 83a77e9e ("net: macb: Added PCI
wrapper for Platform Driver.") in 4.10-rc1.

Fixed status
mainline: [d82d5303c4c539db86588ffb5dc5b26c3f1513e8]
stable/4.19: [46670fb832ee80943715df618632ca13c2e96f2b]
stable/5.10: [7721221e87d25c9840d9ca6b986dbdc410d5ce2b]
stable/5.4: [1da750d1e2140ef43d64d17f301ff6f41b45541e]

CVE-2021-47373: irqchip/gic-v3-its: Fix potential VPE leak on error

Announce: https://lore.kernel.org/linux-cve-announce/2024052141-CVE-2021-47=
373-e5ff@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7d75bbb ("irqchip/gic-v3-its: Add VPE irq domain
allocation/teardown") in v4.14-rc1.
Fixed in v5.15-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [280bef512933b2dda01d681d8cbe499b98fc5bdd]
stable/4.19: [5701e8bff314c155e7afdc467b1e0389d86853d0]
stable/5.10: [568662e37f927e3dc3e475f3ff7cf4ab7719c5e7]
stable/5.4: [42d3711c23781045e7a5cd28536c774b9a66d20b]

CVE-2021-47374: dma-debug: prevent an error message from causing
runtime problems

Announce: https://lore.kernel.org/linux-cve-announce/2024052141-CVE-2021-47=
374-41c2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.15-rc2.
This bug was introduced by commit 2b4bbc62 ("dma-debug: report -EEXIST
errors in add_dma_entry") in 5.14-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [510e1a724ab1bf38150be2c1acabb303f98d0047]

CVE-2021-47375: blktrace: Fix uaf in blk_trace access after removing by sys=
fs

Announce: https://lore.kernel.org/linux-cve-announce/2024052141-CVE-2021-47=
375-8849@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c71a896 ("blktrace: add ftrace plugin") in v2.6.30-rc1=
.
Fixed in v5.15-rc3.

Fixed status
cip/4.4: [488da313edf3abea7f7733efe011c96b23740ab5]
cip/4.4-rt: [488da313edf3abea7f7733efe011c96b23740ab5]
cip/4.4-st: [488da313edf3abea7f7733efe011c96b23740ab5]
mainline: [5afedf670caf30a2b5a52da96eb7eac7dee6a9c9]
stable/4.19: [677e362ba807f3aafe6f405c07e0b37244da5222]
stable/4.4: [488da313edf3abea7f7733efe011c96b23740ab5]
stable/5.10: [3815fe7371d2411ce164281cef40d9fc7b323dee]
stable/5.4: [ebb8d26d93c3ec3c7576c52a8373a2309423c069]

CVE-2021-47376: bpf: Add oversize check before call kvcalloc()

Announce: https://lore.kernel.org/linux-cve-announce/2024052142-CVE-2021-47=
376-1032@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.15-rc2.
According to the commit log, this bug was introduced by commit 7661809
("mm: don't allow oversized kvmalloc() calls") in 5.15-rc2.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10
cip/5.10-rt stable/4.19 stable/5.10 stable/5.4

Fixed status
mainline: [0e6491b559704da720f6da09dd0a52c4df44c514]
stable/5.10: [6345a0bee80139ea00a341c4202ebfd1534b5eb0]
stable/5.4: [93937596e0652d50973f9dc944fea1694ac8cdfd]

CVE-2021-47377: xen/balloon: use a kernel thread instead a workqueue

Announce: https://lore.kernel.org/linux-cve-announce/2024052142-CVE-2021-47=
377-8c20@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.15-rc2.
Linux 4.4 seems to be affected.

Fixed status
mainline: [8480ed9c2bbd56fc86524998e5f2e3e22f5038f6]
stable/4.19: [6bba79c6a073741b672b0bf86a1f03c0fe47f973]
stable/5.10: [372d3e6ea1e115942fdfb4b25f7003d822d071be]
stable/5.4: [29917bbb07c30be295dece245c7c21872e1a6fbb]

CVE-2021-47378: nvme-rdma: destroy cm id before destroy qp to avoid
use after free

Announce: https://lore.kernel.org/linux-cve-announce/2024052142-CVE-2021-47=
378-8e72@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.15-rc2.
The nvme-rdma driver was add by commit 711023071 ("nvme-rdma: add a
NVMe over Fabrics RDMA host driver") in 4.8-rc1.
Linux 4.4 is not affeced.

Fixed status
mainline: [9817d763dbe15327b9b3ff4404fa6f27f927e744]
stable/5.10: [ecf0dc5a904830c926a64feffd8e01141f89822f]

CVE-2021-47379: blk-cgroup: fix UAF by grabbing blkcg lock before
destroying blkg pd

Announce: https://lore.kernel.org/linux-cve-announce/2024052142-CVE-2021-47=
379-58ec@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.15-rc2.
It seems to be Linux 4.x is affected too.

Fixed status
mainline: [858560b27645e7e97aca37ee8f232cccd658fbd2]
stable/5.10: [f58d305887ad7b24986d58e881f6806bb81b2bdf]
stable/5.4: [d12ddd843f1877de1f7dd2aeea4907cf9ff3ac08]

CVE-2021-47380: HID: amd_sfh: Fix potential NULL pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024052143-CVE-2021-47=
380-8750@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.15-rc4.
This bug was introduced by commit 4f567b9f ("SFH: PCIe driver to add
support of AMD sensor fusion hub") in 5.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d46ef750ed58cbeeba2d9a55c99231c30a172764]

CVE-2021-47381: ASoC: SOF: Fix DSP oops stack dump output contents

Announce: https://lore.kernel.org/linux-cve-announce/2024052143-CVE-2021-47=
381-b80b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e657c18 ('ASoC: SOF: Add xtensa support') in v5.2-rc1.
Fixed in v5.15-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac4dfccb96571ca03af7cac64b7a0b2952c97f3a]

CVE-2021-47382: s390/qeth: fix deadlock during failing recovery

Announce: https://lore.kernel.org/linux-cve-announce/2024052143-CVE-2021-47=
382-87ee@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b41b554 ("s390/qeth: fix locking for discipline
setup / removal") in v5.11-rc3.
Fixed in v5.15-rc3.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [d2b59bd4b06d84a4eadb520b0f71c62fe8ec0a62]

CVE-2021-47383: tty: Fix out-of-bound vmalloc access in imageblit

Announce: https://lore.kernel.org/linux-cve-announce/2024052144-CVE-2021-47=
383-a8f4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.15-rc1.

Fixed status
cip/4.4: [7e71fcedfda6f7de18f850a6b36e78d78b04476f]
cip/4.4-rt: [7e71fcedfda6f7de18f850a6b36e78d78b04476f]
cip/4.4-st: [7e71fcedfda6f7de18f850a6b36e78d78b04476f]
mainline: [3b0c406124719b625b1aba431659f5cdc24a982c]
stable/4.19: [8a6a240f52e14356386030d8958ae8b1761d2325]
stable/4.4: [7e71fcedfda6f7de18f850a6b36e78d78b04476f]
stable/5.10: [d570c48dd37dbe8fc6875d4461d01a9554ae2560]
stable/5.4: [883f7897a25e3ce14a7f274ca4c73f49ac84002a]

CVE-2021-47384: hwmon: (w83793) Fix NULL pointer dereference by
removing unnecessary structure field

Announce: https://lore.kernel.org/linux-cve-announce/2024052144-CVE-2021-47=
384-f311@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.15-rc4.
It looks as if Linux 4.x is affected too.

Fixed status
mainline: [dd4d747ef05addab887dc8ff0d6ab9860bbcd783]
stable/5.10: [7c4fd5de39f273626a2b0f3a446d2cc85cd47616]
stable/5.4: [6cb01fe630eaffc5a2c3f7364436caddba286623]

CVE-2021-47385: hwmon: (w83792d) Fix NULL pointer dereference by
removing unnecessary structure field

Announce: https://lore.kernel.org/linux-cve-announce/2024052144-CVE-2021-47=
385-a7e7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.15-rc4.
It looks as if Linux 4.x is affected too.

Fixed status
mainline: [0f36b88173f028e372668ae040ab1a496834d278]
stable/5.10: [1499bb2c3a87a2efea0065adab2bd66badee61c3]
stable/5.4: [200ced5ba724d8bbf29dfac4ed1e17a39ccaccd1]

CVE-2021-47386: hwmon: (w83791d) Fix NULL pointer dereference by
removing unnecessary structure field

Announce: https://lore.kernel.org/linux-cve-announce/2024052145-CVE-2021-47=
386-2701@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.15-rc4.
It looks as if Linux 4.x is affected too.

Fixed status
mainline: [943c15ac1b84d378da26bba41c83c67e16499ac4]
stable/5.10: [516d9055039017a20a698103be2b556b4c976bb8]
stable/5.4: [44d3c480e4e2a75bf6296a18b4356157991ccd80]

CVE-2021-47387: cpufreq: schedutil: Use kobject release() method to
free sugov_tunables

Announce: https://lore.kernel.org/linux-cve-announce/2024052145-CVE-2021-47=
387-7c1e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9bdcb44 ("cpufreq: schedutil: New governor based
on scheduler utilization data") in v4.7-rc1.
Fixed in v5.15-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e5c6b312ce3cc97e90ea159446e6bfa06645364d]
stable/4.19: [30d57cf2c4116ca6d34ecd1cac94ad84f8bc446c]
stable/5.10: [a7d4fc84404d45d72f4490417e8cc3efa4af93f1]
stable/5.4: [67c98e023135ff81b8d52998a6fdb8ca0c518d82]

CVE-2021-47388: mac80211: fix use-after-free in CCMP/GCMP RX

Announce: https://lore.kernel.org/linux-cve-announce/2024052145-CVE-2021-47=
388-5715@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit bf30ca9 ("mac80211: check defrag PN against
current frame") in v5.13-rc4.
Fixed in v5.15-rc4.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10
cip/5.10-rt stable/4.19 stable/5.10 stable/5.4

Fixed status
cip/4.4: [447d001b875d0e7f211c4ba004916028da994258]
cip/4.4-rt: [447d001b875d0e7f211c4ba004916028da994258]
cip/4.4-st: [447d001b875d0e7f211c4ba004916028da994258]
mainline: [94513069eb549737bcfc3d988d6ed4da948a2de8]
stable/4.19: [3d5d629c99c468458022e9b381789de3595bf4dd]
stable/4.4: [447d001b875d0e7f211c4ba004916028da994258]
stable/5.10: [57de2dcb18742dc2860861c9f496da7d42b67da0]
stable/5.4: [50149e0866a82cef33e680ee68dc380a5bc75d32]

CVE-2021-47389: KVM: SVM: fix missing sev_decommission in sev_receive_start

Announce: https://lore.kernel.org/linux-cve-announce/2024052145-CVE-2021-47=
389-c01c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit af43cbb ("KVM: SVM: Add support for
KVM_SEV_RECEIVE_START command") in v5.13-rc1.
Fixed in v5.15-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f1815e0aa770f2127c5df31eb5c2f0e37b60fa77]

CVE-2021-47390: KVM: x86: Fix stack-out-of-bounds memory access from
ioapic_write_indirect()

Announce: https://lore.kernel.org/linux-cve-announce/2024052146-CVE-2021-47=
390-5f20@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7ee30bc ("KVM: x86: deliver KVM IOAPIC scan
request to target vCPUs") in v5.5-rc1.
Introduced by commit 9a2ae9f ("KVM: x86: Zero the IOAPIC scan request
dest vCPUs bitmap") in v5.5-rc1.
Fixed in v5.15-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f9b68f57c6278c322793a06063181deded0ad69]
stable/5.10: [bebabb76ad9acca8858e0371e102fb60d708e25b]

CVE-2021-47391: RDMA/cma: Ensure rdma_addr_cancel() happens before
issuing more requests

Announce: https://lore.kernel.org/linux-cve-announce/2024052146-CVE-2021-47=
391-45fb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e51060f ("IB: IP address based RDMA connection
manager") in v2.6.20.16.
Fixed in v5.15-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [305d568b72f17f674155a2a8275f865f207b3808]
stable/5.10: [9a085fa9b7d644a234465091e038c1911e1a4f2a]

CVE-2021-47392: RDMA/cma: Fix listener leak in rdma_cma_listen_on_all() fai=
lure

Announce: https://lore.kernel.org/linux-cve-announce/2024052146-CVE-2021-47=
392-47dc@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c80a0c5 ("RDMA/cma: Add missing error handling of
listen_id") in v5.11-rc1.
Fixed in v5.15-rc4.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [ca465e1f1f9b38fe916a36f7d80c5d25f2337c81]
stable/5.10: [3f4e68902d2e545033c80d7ad62fd9a439e573f4]

CVE-2021-47393: hwmon: (mlxreg-fan) Return non-zero value when fan
current state is enforced from sysfs

Announce: https://lore.kernel.org/linux-cve-announce/2024052147-CVE-2021-47=
393-ea1c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 65afb4c ("hwmon: (mlxreg-fan) Add support for
Mellanox FAN driver") in v4.19-rc1.
Fixed in v5.15-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e6fab7af6ba1bc77c78713a83876f60ca7a4a064]
stable/4.19: [5c6e0bce647d9cb32a17d58ffa669b3421fcc6ca]
stable/5.10: [76bbb482d33bfcd7e9070ecf594c9ec73e01c930]
stable/5.4: [a6c42ae1530f94724d3c42cf91fe3d3c5e394f8a]

CVE-2021-47394: netfilter: nf_tables: unlink table before deleting it

Announce: https://lore.kernel.org/linux-cve-announce/2024052147-CVE-2021-47=
394-9ec5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6001a93 ("netfilter: nftables: introduce table
ownership") in v5.12-rc1.
Fixed in v5.15-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a499b03bf36b0c2e3b958a381d828678ab0ffc5e]

CVE-2021-47395: mac80211: limit injected vht mcs/nss in
ieee80211_parse_tx_radiotap

Announce: https://lore.kernel.org/linux-cve-announce/2024052147-CVE-2021-47=
395-80d3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 646e76b ("mac80211: parse VHT info in injected
frames") in v4.7-rc1.
Fixed in v5.15-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [13cb6d826e0ac0d144b0d48191ff1a111d32f0c6]
stable/4.19: [76538c7b4df314bb937e44c5cb1782f37d47443c]
stable/5.10: [1282bb00835ff79d2d9c023055d514df5b4de260]
stable/5.4: [ab85997465b972d39d9747fc16311fa5773374b2]

CVE-2021-47396: mac80211-hwsim: fix late beacon hrtimer handling

Announce: https://lore.kernel.org/linux-cve-announce/2024052148-CVE-2021-47=
396-42fa@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 01e59e4 ("mac80211_hwsim: hrtimer beacon") in v3.9-rc1=
.
Fixed in v5.15-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [313bbd1990b6ddfdaa7da098d0c56b098a833572]
stable/5.10: [2c204cf594df3b9468368dc9d0b24d482d93cda7]
stable/5.4: [9bee85de2c8155388c09a2e1530a243ec1c96f05]

CVE-2021-47397: sctp: break out if skb_header_pointer returns NULL in
sctp_rcv_ootb

Announce: https://lore.kernel.org/linux-cve-announce/2024052148-CVE-2021-47=
397-1b56@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3acb50c ("sctp: delay as much as possible
skb_linearize") in v4.8-rc1.
Fixed in v5.15-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7e745f8e94492a8ac0b0a26e25f2b19d342918f]
stable/4.19: [8c630a7b4f9dec63f08bd881ab77984a724a5124]
stable/5.10: [9c6591ae8e63f93c895ad5e2703c36c548aac997]
stable/5.4: [ec018021cf445abbe8e2f3e2a7f1dcc813cb8ea1]

CVE-2021-47398: RDMA/hfi1: Fix kernel pointer leak

Announce: https://lore.kernel.org/linux-cve-announce/2024052148-CVE-2021-47=
398-9acb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 042a00f ("IB/{ipoib,hfi1}: Add a timeout handler
for rdma_netdev") in v5.13-rc1.
Fixed in v5.15-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d5cfafe8b4006a75b55c2f1fdfdb363f9a5cc98]

CVE-2021-47399: ixgbe: Fix NULL pointer dereference in ixgbe_xdp_setup

Announce: https://lore.kernel.org/linux-cve-announce/2024052148-CVE-2021-47=
399-3b96@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4a9b32f ("ixgbe: fix potential RX buffer
starvation for AF_XDP") in v5.0-rc8.
Fixed in v5.15-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [513e605d7a9ce136886cb42ebb2c40e9a6eb6333]
stable/5.10: [20f6c4a31a525edd9ea6243712b868ba0e4e331e]

CVE-2021-47400: net: hns3: do not allow call hns3_nic_net_open repeatedly

Announce: https://lore.kernel.org/linux-cve-announce/2024052149-CVE-2021-47=
400-394b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e888402 ("net: hns3: call hns3_nic_net_open()
while doing HNAE3_UP_CLIENT") in v5.0-rc1.
Fixed in v5.15-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5b09e88e1bf7fe86540fab4b5f3eece8abead39e]
stable/5.10: [f8ba689cb69523144d10606096ef686002dd7285]
stable/5.4: [5a31d4e73ada8022427b69b10fd1f01a6a8d4b3d]

CVE-2021-47401: ipack: ipoctal: fix stack information leak

Announce: https://lore.kernel.org/linux-cve-announce/2024052149-CVE-2021-47=
401-10e4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ba4dc61 ("Staging: ipack: add support for
IP-OCTAL mezzanine board") in v3.5-rc1.
Fixed in v5.15-rc4.

Fixed status
cip/4.4: [acb96e782bad427ca4bb1bd94af660acd1462380]
cip/4.4-rt: [acb96e782bad427ca4bb1bd94af660acd1462380]
cip/4.4-st: [acb96e782bad427ca4bb1bd94af660acd1462380]
mainline: [a89936cce87d60766a75732a9e7e25c51164f47c]
stable/4.19: [829f13d6079cf7a2465522f39acb43033e9b320d]
stable/4.4: [acb96e782bad427ca4bb1bd94af660acd1462380]
stable/5.10: [5f6a309a699675680df15d9b6d389114515b4426]
stable/5.4: [8657158a3b68c85234e6da3d8eae33d6183588b7]

CVE-2021-47402: net: sched: flower: protect fl_walk() with rcu

Announce: https://lore.kernel.org/linux-cve-announce/2024052149-CVE-2021-47=
402-6c19@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d39d714 ("idr: introduce
idr_for_each_entry_continue_ul()") in v5.3-rc1.
Fixed in v5.15-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d5ef190693a7d76c5c192d108e8dec48307b46ee]
stable/5.10: [d0d520c19e7ea19ed38dc5797b12397b6ccf9f88]
stable/5.4: [694b0cee7f8546b69a80996a29cb3cf4149c0453]

CVE-2021-47403: ipack: ipoctal: fix module reference leak

Announce: https://lore.kernel.org/linux-cve-announce/2024052150-CVE-2021-47=
403-b338@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 82a8234 ("ipoctal: get carrier driver to avoid
rmmod") in v3.18-rc1.
Fixed in v5.15-rc4.

Fixed status
cip/4.4: [31398849b84ebae0d43a1cf379cb9895597f221a]
cip/4.4-rt: [31398849b84ebae0d43a1cf379cb9895597f221a]
cip/4.4-st: [31398849b84ebae0d43a1cf379cb9895597f221a]
mainline: [bb8a4fcb2136508224c596a7e665bdba1d7c3c27]
stable/4.19: [9c5b77a7ffc983b2429ce158b50497c5d3c86a69]
stable/4.4: [31398849b84ebae0d43a1cf379cb9895597f221a]
stable/5.10: [7cea848678470daadbfdaa6a112b823c290f900c]
stable/5.4: [3253c87e1e5bc0107aab773af2f135ebccf38666]

CVE-2021-47404: HID: betop: fix slab-out-of-bounds Write in betop_probe

Announce: https://lore.kernel.org/linux-cve-announce/2024052150-CVE-2021-47=
404-f851@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.15-rc4.

Fixed status
cip/4.4: [a4faa7153b87fbcfe4be15f4278676f79ca6e019]
cip/4.4-rt: [a4faa7153b87fbcfe4be15f4278676f79ca6e019]
cip/4.4-st: [a4faa7153b87fbcfe4be15f4278676f79ca6e019]
mainline: [1e4ce418b1cb1a810256b5fb3fd33d22d1325993]
stable/4.19: [bb8b72374db69afa25a5b65cf1c092860c6fe914]
stable/4.4: [a4faa7153b87fbcfe4be15f4278676f79ca6e019]
stable/5.10: [dedfc35a2de2bae9fa3da8210a05bfd515f83fee]
stable/5.4: [fe9bb925e7096509711660d39c0493a1546e9550]

CVE-2021-47405: HID: usbhid: free raw_report buffers in usbhid_stop

Announce: https://lore.kernel.org/linux-cve-announce/2024052150-CVE-2021-47=
405-b693@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.15-rc1.

Fixed status
cip/4.4: [7ce4e49146612261265671b1d30d117139021030]
cip/4.4-rt: [7ce4e49146612261265671b1d30d117139021030]
cip/4.4-st: [7ce4e49146612261265671b1d30d117139021030]
mainline: [f7744fa16b96da57187dc8e5634152d3b63d72de]
stable/4.19: [764ac04de056801dfe52a716da63f6e7018e7f3b]
stable/4.4: [7ce4e49146612261265671b1d30d117139021030]
stable/5.10: [f7ac4d24e1610b92689946fa88177673f1e88a3f]
stable/5.4: [965147067fa1bedff3ae1f07ce3f89f1a14d2df3]

CVE-2021-47406: ext4: add error checking to ext4_ext_replay_set_iblocks()

Announce: https://lore.kernel.org/linux-cve-announce/2024052150-CVE-2021-47=
406-04e3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8016e29 ("ext4: fast commit recovery path") in v5.10-r=
c1.
Fixed in v5.15-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1fd95c05d8f742abfe906620780aee4dbe1a2db0]
stable/5.10: [a63474dbf692dd09b50fed592bc41f6de5f102fc]

CVE-2021-47407: KVM: x86: Handle SRCU initialization failure during
page track init

Announce: https://lore.kernel.org/linux-cve-announce/2024052151-CVE-2021-47=
407-fd65@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.15-rc4.
It seems to as if this bug was introduced by commit 0eb05bf ("KVM:
page track: add notifier support") in 4.6-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb7511bf9182292ef1df1082d23039e856d1ddfb]
stable/5.10: [deb2949417677649e2413266d7ce8c2ff73952b4]

CVE-2021-47408: netfilter: conntrack: serialize hash resizes and cleanups

Announce: https://lore.kernel.org/linux-cve-announce/2024052151-CVE-2021-47=
408-ad88@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.15-rc4.
It looks to be 4.4, 4.19, and 5.4 are affected too.

Fixed status
mainline: [e9edc188fc76499b0b9bd60364084037f6d03773]
stable/5.10: [e2d192301a0df8160d1555b66ae8611e8050e424]

CVE-2021-47409: usb: dwc2: check return value after calling
platform_get_resource()

Announce: https://lore.kernel.org/linux-cve-announce/2024052151-CVE-2021-47=
409-1856@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.15-rc3.
It was introduced by commit 348becd ("usb: dwc2: fix "iomem
0x00000000" message") in 4.11-rc1.

Fixed status
mainline: [856e6e8e0f9300befa87dde09edb578555c99a82]
stable/4.19: [a7182993dd8e09f96839ddc3ac54f9b37370d282]
stable/5.10: [2754fa3b73df7d0ae042f3ed6cfd9df9042f6262]
stable/5.4: [8b9c1c33e51d0959f2aec573dfbac0ffd3f5c0b7]

CVE-2021-47410: drm/amdkfd: fix svm_migrate_fini warning

Announce: https://lore.kernel.org/linux-cve-announce/2024052152-CVE-2021-47=
410-3b06@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.15-rc3.
The svm_migrate_fini() was first introduced by commit 814ab99
("drm/amdkfd: register HMM device private zone") in 5.14-rc1.
This patch is not backported to older kernels. so 4.4, 4.19, 5.10, and
5.4 are not affected.

Fixed status
mainline: [197ae17722e989942b36e33e044787877f158574]

CVE-2021-47411: io_uring: allow conditional reschedule for intensive iterat=
ors

Announce: https://lore.kernel.org/linux-cve-announce/2024052152-CVE-2021-47=
411-9e6f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.15-rc3.
io_uring was introduced in 5.1 so 4.x is not affected. 5.4 does not
have vulnerable functoins.

Fixed status
mainline: [8bab4c09f24ec8d4a7a78ab343620f89d3a24804]

CVE-2021-47412: block: don't call rq_qos_ops->done_bio if the bio isn't tra=
cked

Announce: https://lore.kernel.org/linux-cve-announce/2024052152-CVE-2021-47=
412-b362@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.15-rc3.
This bug was introduced by commit 67b42d0 ("rq-qos: introduce dio_bio
callback") in 4.19-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a647a524a46736786c95cdb553a070322ca096e3]

CVE-2021-47413: usb: chipidea: ci_hdrc_imx: Also search for 'phys' phandle

Announce: https://lore.kernel.org/linux-cve-announce/2024052153-CVE-2021-47=
413-5ff4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 746f316 ("usb: chipidea: introduce imx7d USB
charger detection") in v5.8-rc1.
Fixed in v5.15-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8253a34bfae3278baca52fc1209b7c29270486ca]
stable/5.10: [b3265b88e83b16c7be762fa5fb7e0632bce0002c]

CVE-2021-47414: riscv: Flush current cpu icache before other cpus

Announce: https://lore.kernel.org/linux-cve-announce/2024052153-CVE-2021-47=
414-a400@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit fab957c ("RISC-V: Atomic and Locking Code") in v4.15-r=
c1.
Fixed in v5.15-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bb8958d5dc79acbd071397abb57b8756375fe1ce]
stable/5.10: [427faa29e06f0709476ea1bd59758f997ec8b64e]

CVE-2021-47415: iwlwifi: mvm: Fix possible NULL dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024052153-CVE-2021-47=
415-4e3d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7b3954a ("iwlwifi: mvm: Explicitly stop session
protection before unbinding") in v5.14-rc1.
Fixed in v5.15-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [24d5f16e407b75bc59d5419b957a9cab423b2681]

CVE-2021-47416: phy: mdio: fix memory leak

Announce: https://lore.kernel.org/linux-cve-announce/2024052154-CVE-2021-47=
416-7584@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 46abc02 ("phylib: give mdio buses a device tree
presence") in v2.6.28-rc1.
Fixed in v5.15-rc5.

Fixed status
cip/4.4: [25e9f88c7e3cc35f5e3d3db199660d28a15df639]
cip/4.4-rt: [25e9f88c7e3cc35f5e3d3db199660d28a15df639]
cip/4.4-st: [25e9f88c7e3cc35f5e3d3db199660d28a15df639]
mainline: [ca6e11c337daf7925ff8a2aac8e84490a8691905]
stable/4.19: [2397b9e118721292429fea8807a698e71b94795f]
stable/4.4: [25e9f88c7e3cc35f5e3d3db199660d28a15df639]
stable/5.10: [0d2dd40a7be61b89a7c99dae8ee96389d27b413a]
stable/5.4: [414bb4ead1362ef2c8592db723c017258f213988]

CVE-2021-47417: libbpf: Fix memory leak in strset

Announce: https://lore.kernel.org/linux-cve-announce/2024052154-CVE-2021-47=
417-783a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 90d76d3 ("libbpf: Extract internal set-of-strings
datastructure APIs") in v5.13-rc1.
Fixed in v5.15-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b0e875bac0fab3e7a7431c2eee36a8ccc0c712ac]

CVE-2021-47418: net_sched: fix NULL deref in fifo_set_limit()

Announce: https://lore.kernel.org/linux-cve-announce/2024052154-CVE-2021-47=
418-342e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit fb0305c ("net-sched: consolidate default fifo
qdisc setup") in v2.6.27-rc1.
Fixed in v5.15-rc5.

Fixed status
cip/4.4: [0dd7ddc462b9c2d31eb5a9926a2cc63eaa3e9f52]
cip/4.4-rt: [0dd7ddc462b9c2d31eb5a9926a2cc63eaa3e9f52]
cip/4.4-st: [0dd7ddc462b9c2d31eb5a9926a2cc63eaa3e9f52]
mainline: [560ee196fe9e5037e5015e2cdb14b3aecb1cd7dc]
stable/4.19: [d07098f45be868a9cdce6c616563c36c64dbbd87]
stable/4.4: [0dd7ddc462b9c2d31eb5a9926a2cc63eaa3e9f52]
stable/5.10: [acff2d182c0768a713cee77442caeb07668bd68f]
stable/5.4: [c951a3be5e8803e93bb49a0aca0d30457d3c1b67]

CVE-2021-47419: net/sched: sch_taprio: properly cancel timer from
taprio_destroy()

Announce: https://lore.kernel.org/linux-cve-announce/2024052154-CVE-2021-47=
419-22ab@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 44d4775 ("net/sched: sch_taprio: reset child
qdiscs before freeing them") in v5.11-rc1.
Fixed in v5.15-rc5.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [a56d447f196fa9973c568f54c0d76d5391c3b0c0]
stable/5.10: [3ec73ffeef54596c32aff0e73fe60971b9c8b866]
stable/5.4: [c951c08a5996365aecbc5f1a9bddec3905e1ddfc]

CVE-2021-47420: drm/amdkfd: fix a potential ttm->sg memory leak

Announce: https://lore.kernel.org/linux-cve-announce/2024052155-CVE-2021-47=
420-939e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 264fb4d ("drm/amdgpu: Add multi-GPU DMA mapping
helpers") in v5.14-rc1.
Fixed in v5.15-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b072ef1215aca33186e3a10109e872e528a9e516]

CVE-2021-47421: drm/amdgpu: handle the case of pci_channel_io_frozen
only in amdgpu_pci_resume

Announce: https://lore.kernel.org/linux-cve-announce/2024052155-CVE-2021-47=
421-00f1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c9a6b82 ("drm/amdgpu: Implement DPC recovery") in
v5.10-rc1.
Fixed in v5.15-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [248b061689a40f4fed05252ee2c89f87cf26d7d8]

CVE-2021-47422: drm/nouveau/kms/nv50-: fix file release memory leak

Announce: https://lore.kernel.org/linux-cve-announce/2024052155-CVE-2021-47=
422-3f95@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 12885ec ("drm/nouveau/kms/nvd9-: Add CRC
support") in v5.9-rc1.
Fixed in v5.15-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0b3d4945cc7e7ea1acd52cb06dfa83bfe265b6d5]
stable/5.10: [65fff0a8efcdca8d84ffe3e23057c3b32403482d]

CVE-2021-47423: drm/nouveau/debugfs: fix file release memory leak

Announce: https://lore.kernel.org/linux-cve-announce/2024052156-CVE-2021-47=
423-6632@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6e9fc17 ("drm/nouveau/debugfs: add copy of sysfs
pstate interface ported to debugfs") in v4.5-rc1.
Fixed in v5.15-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5a8703a9c418c6fc54eb772712dfe7641e3991c]
stable/4.19: [1508b09945bde393326a9dab73b1fc35f672d771]
stable/5.10: [f69556a42043b5444ca712ee889829ba89fdcba8]
stable/5.4: [11cd944bb87d9e575b94c07c952105eda745b459]

CVE-2021-47424: i40e: Fix freeing of uninitialized misc IRQ vector

Announce: https://lore.kernel.org/linux-cve-announce/2024052156-CVE-2021-47=
424-a4dc@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c17401a ("i40e: use separate state bit for
miscellaneous IRQ setup") in v4.15-rc1.
Fixed in v5.15-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2e5a20573a926302b233b0c2e1077f5debc7ab2e]
stable/4.19: [60ad4cde0ad28921f9ea25b0201c774b95ffa4b4]
stable/5.10: [97aeed72af4f83ae51534f0a2473ff52f8d66236]
stable/5.4: [17063cac4088b8e2fc0f633abddca5426ed58312]

CVE-2021-47425: i2c: acpi: fix resource leak in reconfiguration device addi=
tion

Announce: https://lore.kernel.org/linux-cve-announce/2024052156-CVE-2021-47=
425-8e9f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 525e6fa ("i2c / ACPI: add support for ACPI
reconfigure notifications") in v4.8-rc1.
Fixed in v5.15-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6558b646ce1c2a872fe1c2c7cb116f05a2c1950f]
stable/4.19: [3d9d458a8aaafa47268ea4f1b4114a9f12927989]
stable/5.10: [f86de018fd7a24ee07372d55ffa7824f0c674a95]
stable/5.4: [60bacf259e8c2eb2324f3e13275200baaee9494b]

CVE-2021-47426: bpf, s390: Fix potential memory leak about jit_data

Announce: https://lore.kernel.org/linux-cve-announce/2024052156-CVE-2021-47=
426-8f34@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1c8f9b9 ("bpf: s390: add JIT support for
multi-function programs") in v5.4-rc1.
Fixed in v5.15-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [686cb8b9f6b46787f035afe8fbd132a74e6b1bdd]
stable/5.10: [29fdb11ca88d3c490a3d56f0dc77eb9444d086be]
stable/5.4: [a326f9c01cfbee4450ae49ce618ae6cbc0f76842]

CVE-2021-47427: scsi: iscsi: Fix iscsi_task use after free

Announce: https://lore.kernel.org/linux-cve-announce/2024052157-CVE-2021-47=
427-ffc6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d39df15 ("scsi: iscsi: Have abort handler get ref
to conn") in v5.14-rc1.
Fixed in v5.15-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [258aad75c62146453d03028a44f2f1590d58e1f6]

CVE-2021-47428: powerpc/64s: fix program check interrupt emergency stack pa=
th

Announce: https://lore.kernel.org/linux-cve-announce/2024052157-CVE-2021-47=
428-f3c0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0a882e2 ("powerpc/64s/exception: remove bad stack
branch") in v5.3-rc1.
Fixed in v5.15-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e607dc4df180b72a38e75030cb0f94d12808712]
stable/5.10: [411b38fe68ba20a8bbe724b0939762c3f16e16ca]

CVE-2021-47429: powerpc/64s: Fix unrecoverable MCE calling async
handler from NMI

Announce: https://lore.kernel.org/linux-cve-announce/2024052157-CVE-2021-47=
429-e386@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2b43dd7 ("powerpc/64: enable MSR[EE] in irq
replay pt_regs") in v5.14-rc1.
Fixed in v5.15-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f08fb25bc66986b0952724530a640d9970fa52c1]

CVE-2021-47430: x86/entry: Clear X86_FEATURE_SMAP when CONFIG_X86_SMAP=3Dn

Announce: https://lore.kernel.org/linux-cve-announce/2024052158-CVE-2021-47=
430-7b38@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3c73b81 ("x86/entry, selftests: Further improve
user entry sanity checks") in v5.8-rc4.
Introduced by commit 662a022 ("x86/entry: Fix AC assertion") in v5.9-rc4.
Fixed in v5.15-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3958b9c34c2729597e182cc606cc43942fd19f7c]
stable/5.10: [f2447f6587b8ffe42ba04d14ce67d429a1163e5e]

CVE-2021-47431: drm/amdgpu: fix gart.bo pin_count leak

Announce: https://lore.kernel.org/linux-cve-announce/2024052158-CVE-2021-47=
431-ff0c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.15-rc4.
The vulnerability in gmc_v10_0.c was introduced by commit f9df67e92
("drm/amdgpu: add gmc v10 ip block for navi10 (v6)") in 5.3-rc1.
The vulnerability in gmc_v9_0.c was introduced by commit 5dd696
("drm/amdgpu: Bypass GMC/UVD/VCE hw_fini in SR-IOV") in 4.13-rc1.

Fixed status
mainline: [66805763a97f8f7bdf742fc0851d85c02ed9411f]
stable/5.10: [621ddffb70db824eabd63d18ac635180fe9500f9]
stable/5.4: [83d857d6b0967b6709cd38750c3ce2ed8ced1a95]

CVE-2021-47432: lib/generic-radix-tree.c: Don't overflow in peek()

Announce: https://lore.kernel.org/linux-cve-announce/2024052143-CVE-2021-47=
432-5e69@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
It looks as if this bug was introduced by commit ba20ba2e3 ("generic
radix trees") in 5.1-rc1.

Fixed status
mainline: [9492261ff2460252cf2d8de89cdf854c7e2b28a0]
stable/6.1: [784d01f9bbc282abb0c5ade5beb98a87f50343ac]
stable/6.6: [aa7f1827953100cdde0795289a80c6c077bfe437]

CVE-2022-48706: vdpa: ifcvf: Do proper cleanup if IFCVF init fails

Announce: https://lore.kernel.org/linux-cve-announce/2024052153-CVE-2022-48=
706-3175@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.2-rc7.
It looks as if this bug was introduced by commit 378b2e95
("vDPA/ifcvf: support userspace to query features and MQ of a
management device") in 6.0-rc1.

Fixed status
mainline: [6b04456e248761cf68f562f2fd7c04e591fcac94]
stable/6.1: [5d2cc32c1c10bd889125d2adc16a6bc3338dcd3e]

CVE-2022-48707: cxl/region: Fix null pointer dereference for resetting deco=
der

Announce: https://lore.kernel.org/linux-cve-announce/2024052155-CVE-2022-48=
707-8523@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 176baef ("cxl/hdm: Commit decoder state to
hardware") in v6.0-rc1.
Fixed in v6.2-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4fa4302d6dc7de7e8e74dc7405611a2efb4bf54b]
stable/6.1: [a04c7d062b537ff787d00da95bdfe343260d4beb]

CVE-2022-48708: pinctrl: single: fix potential NULL dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024052155-CVE-2022-48=
708-ba53@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 571aec4 ("pinctrl: single: Use generic pinmux
helpers for managing functions") in v4.11-rc1.
Fixed in v6.2-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2d73e6d4822140445ad4a7b1c6091e0f5fe703b]
stable/4.19: [e671e63587c92b3fd767cf82e73129f6d5feeb33]
stable/5.10: [6e2a0521e4e84a2698f2da3950fb5c5496a4d208]
stable/5.15: [71668706fbe7d20e6f172fa3287fa8aac1b56c26]
stable/5.4: [2b763f7de108cb1a5ad5ed08e617d677341947cb]
stable/6.1: [bcc487001a15f71f103d102cba4ac8145d7a68f2]

CVE-2022-48709: ice: switch: fix potential memleak in ice_add_adv_recipe()

Announce: https://lore.kernel.org/linux-cve-announce/2024052155-CVE-2022-48=
709-4ab8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8b032a5 ("ice: low level support for tunnels") in
v5.16-rc1.
Fixed in v6.2-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a606ce68426c88ff2563382b33cc34f3485fe57]
stable/6.1: [47f4ff6f23f00f5501ff2d7054c1a37c170a7aa0]

CVE-2022-48710: drm/radeon: fix a possible null pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024052143-CVE-2022-48=
710-aa43@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.19-rc1.

Fixed status
cip/4.4: [085375bc61dca146acb15a32c168dc5260c55de3]
cip/4.4-rt: [085375bc61dca146acb15a32c168dc5260c55de3]
cip/4.4-st: [085375bc61dca146acb15a32c168dc5260c55de3]
mainline: [a2b28708b645c5632dc93669ab06e97874c8244f]
stable/4.19: [8a89bfeef9abe93371e3ea8796377f2d132eee29]
stable/5.10: [fee8ae0a0bb66eb7730c22f44fbd7203f63c2eab]
stable/5.15: [7b7fba107b2c4ec7673d0f45bdbb9d1af697d9b9]
stable/5.4: [28fd384c78d7d8ed8af0d086d778c3e438ba7f60]

CVE-2023-52700: tipc: fix kernel warning when sending SYN message

Announce: https://lore.kernel.org/linux-cve-announce/2024052156-CVE-2023-52=
700-1e45@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f25dcc7 ("tipc: tipc ->sendmsg() conversion") in v4.0-=
rc1.
Fixed in v6.2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [11a4d6f67cf55883dc78e31c247d1903ed7feccc]
stable/6.1: [54b6082aec178f16ad6d193b4ecdc9c4823d9a32]

CVE-2023-52701: net: use a bounce buffer for copying skb->mark

Announce: https://lore.kernel.org/linux-cve-announce/2024052156-CVE-2023-52=
701-5037@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6fd1d51 ("net: SO_RCVMARK socket option for
SO_MARK with recvmsg()") in v5.19-rc1.
Fixed in v6.2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2558b8039d059342197610498c8749ad294adee5]
stable/6.1: [863a7de987f02a901bf215509276a7de0370e0f9]

CVE-2023-52702: net: openvswitch: fix possible memory leak in
ovs_meter_cmd_set()

Announce: https://lore.kernel.org/linux-cve-announce/2024052156-CVE-2023-52=
702-ebca@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c7c4c44 ("net: openvswitch: expand the meters
supported number") in v5.8-rc1.
Fixed in v6.2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2fa28f5c6fcbfc794340684f36d2581b4f2d20b5]
stable/5.10: [c0f65ee0a3329eb4b94beaef0268633696e2d0c6]
stable/5.15: [1563e998a938f095548054ef09e277b562b79536]
stable/6.1: [e336a9e08618203a456fb5367f1387b14554f55e]

CVE-2023-52703: net/usb: kalmia: Don't pass act_len in usb_bulk_msg error p=
ath

Announce: https://lore.kernel.org/linux-cve-announce/2024052157-CVE-2023-52=
703-abcb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d402612 ("net/usb: Add Samsung Kalmia driver for
Samsung GT-B3730") in v3.0-rc4.
Fixed in v6.2.

Fixed status
cip/4.4: [12ebe46604c815d8662e19efea902b09796ae710]
cip/4.4-rt: [12ebe46604c815d8662e19efea902b09796ae710]
cip/4.4-st: [12ebe46604c815d8662e19efea902b09796ae710]
mainline: [c68f345b7c425b38656e1791a0486769a8797016]
stable/4.19: [723ef7b66f37c0841f5a451ccbce47ee1641e081]
stable/5.10: [525bdcb0838d19d918c7786151ee14661967a030]
stable/5.15: [338f826d3afead6e4df521f7972a4bef04a72efb]
stable/5.4: [a753352622b4f3c0219e0e9c73114b2848ae6042]
stable/6.1: [02df3170c04a8356cd571ab9155a42f030190abc]

CVE-2023-52704: freezer,umh: Fix call_usermode_helper_exec() vs SIGKILL

Announce: https://lore.kernel.org/linux-cve-announce/2024052157-CVE-2023-52=
704-0d9a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f5d39b0 ("freezer,sched: Rewrite core freezer
logic") in v6.1-rc1.
Fixed in v6.2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eedeb787ebb53de5c5dcf7b7b39d01bf1b0f037d]
stable/6.1: [7f9f6c54da876b3f0bece2b569456ceb96965ed7]

CVE-2023-52705: nilfs2: fix underflow in second superblock position calcula=
tions

Announce: https://lore.kernel.org/linux-cve-announce/2024052157-CVE-2023-52=
705-8468@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.2.

Fixed status
cip/4.4: [f38b2184301473b279187de7bf94416d63e595b4]
cip/4.4-rt: [f38b2184301473b279187de7bf94416d63e595b4]
cip/4.4-st: [f38b2184301473b279187de7bf94416d63e595b4]
mainline: [99b9402a36f0799f25feee4465bfa4b8dfa74b4d]
stable/4.19: [b96591e2c35c8b47db0ec816b5fc6cb8868000ff]
stable/5.10: [0ee5ed0126a2211f7174492da2ca2c29f43755c5]
stable/5.15: [a158782b56b070485d54d25fc9aaf2c8f3752205]
stable/5.4: [52844d8382cd9166d708032def8905ffc3ae550f]
stable/6.1: [a8ef5109f93cea9933bbac0455d8c18757b3fcb4]

CVE-2023-52706: gpio: sim: fix a memory leak

Announce: https://lore.kernel.org/linux-cve-announce/2024052158-CVE-2023-52=
706-1652@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cb8c474 ("gpio: sim: new testing module") in v5.17-rc1=
.
Fixed in v6.2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [79eeab1d85e0fee4c0bc36f3b6ddf3920f39f74b]
stable/6.1: [854e1ecff266033d3149666d3c5b8b0e174b4210]

CVE-2023-52707: sched/psi: Fix use-after-free in ep_remove_wait_queue()

Announce: https://lore.kernel.org/linux-cve-announce/2024052158-CVE-2023-52=
707-e048@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0e94682 ("psi: introduce psi monitor") in v5.2-rc1.
Fixed in v6.2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c2dbe32d5db5c4ead121cf86dabd5ab691fb47fe]
stable/5.10: [ec9c7aa08819f976b2492fa63c41b5712d2924b5]
stable/5.15: [cca2b3feb70170ef6f0fbc4b4d91eea235a2b73a]
stable/5.4: [7caeb5457bd01ccba0df1d6f4872f20d28e50b38]
stable/6.1: [c6879a4dcefe92d870ab68cabaa9caeda4f2af5a]

CVE-2023-52708: mmc: mmc_spi: fix error handling in mmc_spi_probe()

Announce: https://lore.kernel.org/linux-cve-announce/2024052158-CVE-2023-52=
708-d68d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 15a0580 ("mmc_spi host driver") in v2.6.24-rc1.
Fixed in v6.2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf4c9d2ac1e42c7d18b921bec39486896645b714]
stable/5.10: [0b3edcb24bd81b3b2e3dac89f4733bfd47d283be]
stable/5.15: [ecad2fafd424ffdc203b2748ded0b37e4bbecef3]
stable/5.4: [e9b488d60f51ae312006e224e03a30a151c28bdd]
stable/6.1: [82645bf4ed02abe930a659c5fe16d593a6dbd93f]

CVE-2023-52730: mmc: sdio: fix possible resource leaks in some error paths

Announce: https://lore.kernel.org/linux-cve-announce/2024052158-CVE-2023-52=
730-1c8f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3d10a1b ("sdio: fix reference counting in
sdio_remove_func()") in v2.6.33-rc1.
Fixed in v6.2.

Fixed status
cip/4.4: [e500cfce9b5312a164e769ec88152fd1c61980a0]
cip/4.4-rt: [e500cfce9b5312a164e769ec88152fd1c61980a0]
cip/4.4-st: [e500cfce9b5312a164e769ec88152fd1c61980a0]
mainline: [605d9fb9556f8f5fb4566f4df1480f280f308ded]
stable/4.19: [5c7858adada31dbed042448cff6997dd6efc472a]
stable/5.10: [30716d9f0fa1766e522cf24c8a456244e4fc9931]
stable/5.15: [1e06cf04239e202248c8fa356bf11449dc73cfbd]
stable/5.4: [761db46b29b496946046d8cb33c7ea6de6bef36e]
stable/6.1: [f855d31bb38d663c3ba672345d7cce9324ba3b72]

CVE-2023-52731: fbdev: Fix invalid page access after closing deferred
I/O devices

Announce: https://lore.kernel.org/linux-cve-announce/2024052159-CVE-2023-52=
731-29ab@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 56c134f ("fbdev: Track deferred-I/O pages in
pageref struct") in v5.19-rc1.
Fixed in v6.1.13.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [f1d91f0e9d5a240a809698d7d9c5a538e7dcc149]
stable/6.1: [87b9802ca824fcee7915e717e9a60471af62e8e9]

CVE-2023-52732: ceph: blocklist the kclient when receiving corrupted snap t=
race

Announce: https://lore.kernel.org/linux-cve-announce/2024052159-CVE-2023-52=
732-c783@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.2-rc7.

Fixed status
mainline: [a68e564adcaa69b0930809fb64d9d5f7d9c32ba9]
stable/6.1: [66ec619e4591f8350f99c5269a7ce160cccc7a7c]

CVE-2023-52733: s390/decompressor: specify __decompress() buf len to
avoid overflow

Announce: https://lore.kernel.org/linux-cve-announce/2024052159-CVE-2023-52=
733-601c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.2-rc7.
According to the commit log, this bug was introduced by commit
2aa14b1a ("zstd: import usptream v1.5.2") in 6.2-rc1.

Fixed status
mainline: [7ab41c2c08a32132ba8c14624910e2fe8ce4ba4b]
stable/5.10: [55dbd6f4ea954751340f4f73d5dcd7c8f12208b2]
stable/5.15: [9ed522143f959630f8b7782ddc212900d8f609a9]
stable/5.4: [16409f7d9ca5bb8220e1049ea9aae0d3c94d2dfb]
stable/6.1: [f1eb22d0ff064ad458b3b1a1eaa84ac3996206c2]

CVE-2023-52734: net: sched: sch: Bounds check priority

Announce: https://lore.kernel.org/linux-cve-announce/2024052100-CVE-2023-52=
734-c8c2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.2-rc7.
It looks as if all stable kernels are affected.

Fixed status
mainline: [de5ca4c3852f896cacac2bf259597aab5e17d9e3]
stable/5.10: [90fcf55d83b20da1091f926a291af05fb74f61c6]
stable/5.15: [99875ea9b5b47995bfb3c684d21eb17feb4b7e6a]
stable/5.4: [fbe71c5dacaa5a9960323215f118958174c81aa0]
stable/6.1: [f6415c9c9a0b3881543d38528a58b54af4351522]

CVE-2023-52735: bpf, sockmap: Don't let
sock_map_{close,destroy,unhash} call itself

Announce: https://lore.kernel.org/linux-cve-announce/2024052100-CVE-2023-52=
735-4df1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.2-rc7.

Fixed status
mainline: [5b4a79ba65a1ab479903fff2e604865d229b70a9]
stable/5.15: [f312367f5246e04df564d341044286e9e37a97ba]
stable/6.1: [7499859881488da97589f3c79cc66fa75748ad49]

CVE-2023-52736: ALSA: hda: Do not unset preset when cleaning up codec

Announce: https://lore.kernel.org/linux-cve-announce/2024052100-CVE-2023-52=
736-ff92@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.2-rc7.
It looks as if 4.4, 4.19, and 5.4 are affected.

Fixed status
mainline: [87978e6ad45a16835cc58234451111091be3c59a]
stable/5.10: [7fc4e7191eae9d9325511e03deadfdb2224914f8]
stable/5.15: [e909f5f2aa55a8f9aa6919cce08015cb0e8d4668]
stable/6.1: [427ca2530da8dc61a42620d7113b05e187b6c2c0]

CVE-2023-52737: btrfs: lock the inode in shared mode before starting fiemap

Announce: https://lore.kernel.org/linux-cve-announce/2024052101-CVE-2023-52=
737-e10e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.2-rc8.

Fixed status
mainline: [519b7e13b5ae8dd38da1e52275705343be6bb508]
stable/6.1: [d8c594da79bc0244e610a70594e824a401802be1]

CVE-2023-52738: drm/amdgpu/fence: Fix oops due to non-matching
drm_sched init/fini

Announce: https://lore.kernel.org/linux-cve-announce/2024052101-CVE-2023-52=
738-f1bb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 067f44c ("drm/amdgpu: avoid over-handle of fence
driver fini in s3 test (v2)") in v5.15-rc1.
Fixed in v6.2-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ad7bbf3dba5c4a684338df1f285080f2588b535]
stable/5.15: [2e557c8ca2c585bdef591b8503ba83b85f5d0afd]
stable/6.1: [2bcbbef9cace772f5b7128b11401c515982de34b]

CVE-2023-52739: Fix page corruption caused by racy check in __free_pages

Announce: https://lore.kernel.org/linux-cve-announce/2024052101-CVE-2023-52=
739-46c6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e320d30 ("mm/page_alloc.c: fix freeing
non-compound pages") in v5.10-rc1.
Fixed in v6.2-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [462a8e08e0e6287e5ce13187257edbf24213ed03]
stable/5.10: [0a626e27f984dfbe96bd8e4fd08f20a2ede3ea23]
stable/5.15: [3af734f3eac6f70ef8e272a80da40544b9d0f2b5]
stable/6.1: [3b4c045a98f53a8890a94bb5846a390c8e39e673]

CVE-2023-52740: powerpc/64s/interrupt: Fix interrupt exit race with
security mitigation switch

Announce: https://lore.kernel.org/linux-cve-announce/2024052101-CVE-2023-52=
740-3265@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1379974 ("powerpc/64: use interrupt restart table
to speed up return from interrupt") in v5.14-rc1.
Fixed in v6.2-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ea31e2e62bbc4d11c411eeb36f1b02841dbcab1]
stable/5.15: [86f7e423933608d536015a0f2eb9e0338c1227e0]
stable/6.1: [6f097c24815e67909a1fcc2c605586d02babd673]

CVE-2023-52741: cifs: Fix use-after-free in rdata->read_into_pages()

Announce: https://lore.kernel.org/linux-cve-announce/2024052102-CVE-2023-52=
741-6a1e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.2-rc8.
It seems as if this bug was introduced by commit b3160ae=E3=80=80("CIFS: Co=
unt
got bytes in read_into_pages()") in 3.17-rc1.

Fixed status
mainline: [aa5465aeca3c66fecdf7efcf554aed79b4c4b211]
stable/5.10: [2b693fe3f760c87fd9768e759f6297f743a1b3b0]
stable/5.15: [d1fba1e096ffc7ec11df863a97c50203c47315b9]
stable/6.1: [3684a2f6affa1ca52a5d4a12f04d0652efdee65e]

CVE-2023-52742: net: USB: Fix wrong-direction WARNING in plusb.c

Announce: https://lore.kernel.org/linux-cve-announce/2024052102-CVE-2023-52=
742-005f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 090ffa9 ("[PATCH] USB: usbnet (9/9) module for
pl2301/2302 cables") in v2.6.20.16.
Fixed in v6.2-rc8.

Fixed status
cip/4.4: [2b493228104c6624775030eb1382499fb35d4dca]
cip/4.4-rt: [2b493228104c6624775030eb1382499fb35d4dca]
cip/4.4-st: [2b493228104c6624775030eb1382499fb35d4dca]
mainline: [811d581194f7412eda97acc03d17fc77824b561f]
stable/4.19: [6f69307f625904feed189008381fd83bd1a35b63]
stable/5.10: [1be271c52bf3554edcb8d124d1f8c7f777ee5727]
stable/5.15: [25141fb4119112f4ebf8f00cf52014abbc8020b1]
stable/5.4: [43379fcacea2dcee35d02efc9c8fe97807a503c9]
stable/6.1: [0d2cf3fae701646061e295815bb7588d2f3671cc]

CVE-2023-52743: ice: Do not use WQ_MEM_RECLAIM flag for workqueue

Announce: https://lore.kernel.org/linux-cve-announce/2024052102-CVE-2023-52=
743-f027@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 940b61a ("ice: Initialize PF and setup
miscellaneous interrupt") in v4.17-rc1.
Fixed in v6.2-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d159f7884f78b1aacb99b4fc37d1e3cb1194e39]
stable/5.10: [1ad4112c9fcf0bc08222b2b1614fba52ffd12255]
stable/5.15: [ca834a017851c50464c25a85f3cb2daefff7bede]
stable/5.4: [87a5e3fc8416106e290c448fc8a6dd50ab24c634]
stable/6.1: [df59e05401450973c8c7e96fd74b49e24442dc1f]

CVE-2023-52744: RDMA/irdma: Fix potential NULL-ptr-dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024052103-CVE-2023-52=
744-1e58@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 146b975 ("RDMA/irdma: Add connection manager") in
v5.14-rc1.
Fixed in v6.2-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d9745cead1f121974322b94ceadfb4d1e67960e]
stable/5.15: [8f5fe1cd8e6a97f94840b55f59ed08cbc397086f]
stable/6.1: [360682fe7df262d94fae54f737c487bec0f9190d]

CVE-2023-52745: IB/IPoIB: Fix legacy IPoIB due to wrong number of queues

Announce: https://lore.kernel.org/linux-cve-announce/2024052103-CVE-2023-52=
745-3727@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit dbc94a0 ("IB/IPoIB: Fix queue count inconsistency
for PKEY child interfaces") in 6.2-rc1.
Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st cip/4.19 cip/4.19-rt cip/4.19-rt
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/4.19 stable/5.10
stable/5.15 stable/5.4 stable/6.1

Fixed status
mainline: [e632291a2dbce45a24cddeb5fe28fe71d724ba43]
stable/5.10: [b1afb666c32931667c15ad1b58e7203f0119dcaf]
stable/5.15: [1b4ef90cbcfa603b3bb536fbd6f261197012b6f6]
stable/5.4: [4a779187db39b2f32d048a752573e56e4e77807f]
stable/6.1: [7197460dcd43ff0e4a502ba855dd82d37c2848cc]

CVE-2023-52746: xfrm/compat: prevent potential spectre v1 gadget in
xfrm_xlate32_attr()

Announce: https://lore.kernel.org/linux-cve-announce/2024052103-CVE-2023-52=
746-0476@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5106f4a ("xfrm/compat: Add 32=3D>64-bit messages
translator") in v5.10-rc1.
Fixed in v6.2-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b6ee896385380aa621102e8ea402ba12db1cabff]
stable/5.10: [a893cc644812728e86e9aff517fd5698812ecef0]
stable/5.15: [5dc688fae6b7be9dbbf5304a3d2520d038e06db5]
stable/6.1: [419674224390fca298020fc0751a20812f84b12d]

CVE-2023-52747: IB/hfi1: Restore allocated resources on failed copyout

Announce: https://lore.kernel.org/linux-cve-announce/2024052104-CVE-2023-52=
747-a85f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f404ca4 ("IB/hfi1: Refactor
hfi_user_exp_rcv_setup() IOCTL") in v4.15-rc1.
Fixed in v6.2-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6601fc0d15ffc20654e39486f9bef35567106d68]
stable/4.19: [00d9e212b8a39e6ffcf31b9d2e503d2bf6009d45]
stable/5.10: [79b595d9591426156a9e0635a5b5115508a36fef]
stable/5.15: [9bae58d58b6bb73b572356b31a62d2afc7378d12]
stable/5.4: [7896accedf5bf1277d2f305718e36dc8bac7e321]
stable/6.1: [0a4f811f2e5d07bbd0c9226f4afb0a1270a831ae]

CVE-2023-52748: f2fs: avoid format-overflow warning

Announce: https://lore.kernel.org/linux-cve-announce/2024052143-CVE-2023-52=
748-577d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
This bug was introduced by commit 31083031 ("f2fs: compress: introduce
page array slab cache") in 5.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0d4e8acb3789c5a8651061fbab62ca24a45c063]
stable/5.10: [c041f5ddef00c731c541e00bc8ae97b8c84c682f]
stable/5.15: [e4088d7d8f1123006d46a42edf51b8c960a58ef9]
stable/6.1: [526dd7540a09ecf87b5f54f3ab4e0a2528f25a79]
stable/6.6: [3eebe636cac53886bd5d1cdd55e082ec9e84983f]

CVE-2023-52749: spi: Fix null dereference on suspend

Announce: https://lore.kernel.org/linux-cve-announce/2024052144-CVE-2023-52=
749-684e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.

Fixed status
mainline: [bef4a48f4ef798c4feddf045d49e53c8a97d5e37]
stable/6.1: [4ec4508db97502a12daee88c74782e8d35ced068]
stable/6.6: [96474ea47dc67b0704392d59192b233c8197db0e]

CVE-2023-52750: arm64: Restrict CPU_BIG_ENDIAN to GNU as or LLVM IAS
15.x or newer

Announce: https://lore.kernel.org/linux-cve-announce/2024052144-CVE-2023-52=
750-2115@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
According to the commit log, this bug was introduced by commit 34f66c4
("arm64: Use a positive cpucap for FP/SIMD") in 6.7-rc7.

Fixed status
mainline: [146a15b873353f8ac28dc281c139ff611a3c4848]
stable/5.10: [d08a1e75253b4e19ae290b1c35349f12cfcebc0a]
stable/5.15: [936c9c10efaefaf1ab3ef020e1f8aaaaff1ad2f9]
stable/6.1: [ef0224ee5399ea8a46bc07dc6c6494961ed5fdd2]
stable/6.6: [69e619d2fd056fe1f5d0adf01584f2da669e0d28]

CVE-2023-52751: smb: client: fix use-after-free in smb2_query_info_compound=
()

Announce: https://lore.kernel.org/linux-cve-announce/2024052144-CVE-2023-52=
751-69df@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.

Fixed status
mainline: [5c86919455c1edec99ebd3338ad213b59271a71b]
stable/6.6: [93877b9afc2994c89362007aac480a7b150f386f]

CVE-2023-52752: smb: client: fix use-after-free bug in
cifs_debug_data_proc_show()

Announce: https://lore.kernel.org/linux-cve-announce/2024052144-CVE-2023-52=
752-2342@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
It seem as if 4.4 vulnerable functions may not present.

Fixed status
mainline: [d328c09ee9f15ee5a26431f5aad7c9239fa85e62]
stable/6.1: [558817597d5fbd7af31f891b67b0fd20f0d047b7]
stable/6.6: [0ab6f842452ce2cae04209d4671ac6289d0aef8a]

CVE-2023-52753: drm/amd/display: Avoid NULL dereference of timing generator

Announce: https://lore.kernel.org/linux-cve-announce/2024052145-CVE-2023-52=
753-0805@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.

Fixed status
mainline: [b1904ed480cee3f9f4036ea0e36d139cb5fee2d6]
stable/4.19: [09909f515032fa80b921fd3118efe66b185d10fd]
stable/5.10: [79b6a90f4f2433312154cd68452b0ba501fa74db]
stable/5.15: [4e497f1acd99075b13605b2e7fa0cba721a2cfd9]
stable/5.4: [eac3e4760aa12159f7f5475d55a67b7933abc195]
stable/6.1: [8a06894666e0b462c9316b26ab615cefdd0d676c]
stable/6.6: [df8bc953eed72371e43ca407bd063507f760cf89]

CVE-2023-52754: media: imon: fix access to invalid resource for the
second interface

Announce: https://lore.kernel.org/linux-cve-announce/2024052145-CVE-2023-52=
754-9725@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
It seems as if 4.4, 4.19, and 5.4 are affected too.

Fixed status
mainline: [a1766a4fd83befa0b34d932d532e7ebb7fab1fa7]
stable/5.10: [0f5068519f89d928d6c51100e4b274479123829f]
stable/5.15: [5e0b788fb96be36d1baf1a5c88d09c7c82a0452a]
stable/6.1: [b083aaf5db2eeca9e362723258e5d8698f7dd84e]
stable/6.6: [2a493a34bd6e496c55fabedd82b957193ace178f]

CVE-2023-52755: ksmbd: fix slab out of bounds write in smb_inherit_dacl()

Announce: https://lore.kernel.org/linux-cve-announce/2024052145-CVE-2023-52=
755-0e00@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
the ksmbd was introduced in 5.15 so prior to 5.15 kernels aren't affected.

Fixed status
mainline: [eebff19acaa35820cb09ce2ccb3d21bee2156ffb]
stable/5.15: [aaf0a07d60887d6c36fc46a24de0083744f07819]
stable/6.1: [8387c94d73ec66eb597c7a23a8d9eadf64bfbafa]
stable/6.6: [712e01f32e577e7e48ab0adb5fe550646a3d93cb]

CVE-2023-52756: pwm: Fix double shift bug

Announce: https://lore.kernel.org/linux-cve-announce/2024052146-CVE-2023-52=
756-f694@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
4.4 may need to apply the fix.

Fixed status
mainline: [d27abbfd4888d79dd24baf50e774631046ac4732]
stable/4.19: [a98ff250b5af87f92f17bb9725cb21de1931ee57]
stable/5.10: [e52518b9cb9fc98fc043c8fb2b8cfc619ca8a88b]
stable/5.15: [a7ee519e8095d9c834086d0ff40da11415e1e4d7]
stable/5.4: [eca19db60f99925461f49c3fd743733881395728]
stable/6.1: [1fb3a9c59e7f7d2b1d737a0d6e02e31d5b516455]
stable/6.6: [45d0a298e05adee521f6fe605d6a88341ba07edd]

CVE-2023-52757: smb: client: fix potential deadlock when releasing mids

Announce: https://lore.kernel.org/linux-cve-announce/2024052146-CVE-2023-52=
757-5028@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.

Fixed status
mainline: [e6322fd177c6885a21dd4609dc5e5c973d1a2eb7]
stable/6.1: [9eb44db68c5b7f5aa22b8fc7de74a3e2e08d1f29]
stable/6.6: [c1a5962f1462b64fe7b69f20a4b6af8067bc2d26]

CVE-2023-52758: i2c: dev: copy userspace array safely

Announce: https://lore.kernel.org/linux-cve-announce/2024052146-CVE-2023-52=
758-9b23@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
It looks as if all stable kernels are affected.

Fixed status
mainline: [cc9c54232f04aef3a5d7f64a0ece7df00f1aaa3d]
stable/5.15: [38ada2f304f6f2065dd59613ef236a26f4dd73cd]
stable/6.1: [aff8be2cad74a22525cd89cdff0b72a5c9a4c0c6]
stable/6.6: [bef76b8544939518dafa3325bcd438b111136437]

CVE-2023-52759: gfs2: ignore negated quota changes

Announce: https://lore.kernel.org/linux-cve-announce/2024052147-CVE-2023-52=
759-0e9f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.

Fixed status
cip/4.4: [b143c68823709a08a649e9041e3a68db01edbe57]
cip/4.4-rt: [b143c68823709a08a649e9041e3a68db01edbe57]
cip/4.4-st: [b143c68823709a08a649e9041e3a68db01edbe57]
mainline: [4c6a08125f2249531ec01783a5f4317d7342add5]
stable/4.19: [b4deec69fe32b58dc5fb4ace52456ece85b75561]
stable/5.10: [2a054b87a1b799b391e578597a42ee6e57a987ae]
stable/5.15: [5bfda356e903633d16ae1bac1ee38364e12628a3]
stable/5.4: [2bb42a27a92ff3984c9fa5fbe128eced3ea693f2]
stable/6.1: [53fc16c1ad84f5467ec24341670b63aa759335d3]
stable/6.6: [119565e566f91ff3588ffcd5812f0c8061586c6b]

CVE-2023-52760: gfs2: Fix slab-use-after-free in gfs2_qd_dealloc

Announce: https://lore.kernel.org/linux-cve-announce/2024052147-CVE-2023-52=
760-5ac4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.

Fixed status
mainline: [bdcb8aa434c6d36b5c215d02a9ef07551be25a37]
stable/6.6: [08a28272faa750d4357ea2cb48d2baefd778ea81]

CVE-2023-52761: riscv: VMAP_STACK overflow detection thread-safe

Announce: https://lore.kernel.org/linux-cve-announce/2024052147-CVE-2023-52=
761-5ddf@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
Introduced by commit 31da94c ("riscv: add VMAP_STACK overflow
detection") in 5.14-rc1.

Fixed status
mainline: [be97d0db5f44c0674480cb79ac6f5b0529b84c76]
stable/6.6: [eff53aea3855f71992c043cebb1c00988c17ee20]

CVE-2023-52762: virtio-blk: fix implicit overflow on virtio_max_dma_size

Announce: https://lore.kernel.org/linux-cve-announce/2024052147-CVE-2023-52=
762-fe90@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.

Fixed status
mainline: [fafb51a67fb883eb2dde352539df939a251851be]
stable/5.15: [72775cad7f572bb2501f9ea609e1d20e68f0b38b]
stable/6.1: [472bd4787406bef2e8b41ee4c74d960a06a49a48]
stable/6.6: [d667fe301dcbcb12d1d6494fc4b8abee2cb75d90]

CVE-2023-52763: i3c: master: mipi-i3c-hci: Fix a kernel panic for
accessing DAT_data.

Announce: https://lore.kernel.org/linux-cve-announce/2024052148-CVE-2023-52=
763-34b7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
It looks as if this bug was introduced by commit fd1068e ("virtio-blk:
Consider virtio_max_dma_size() for maximum segment size") in 5.1-rc1.

Fixed status
mainline: [b53e9758a31c683fc8615df930262192ed5f034b]
stable/5.15: [39c71357e68e2f03766f9321b9f4882e49ff1442]
stable/6.1: [e64d23dc65810be4e3395d72df0c398f60c991f9]
stable/6.6: [eed74230435c61eeb58abaa275b1820e6a4b7f02]

CVE-2023-52764: media: gspca: cpia1: shift-out-of-bounds in set_flicker

Announce: https://lore.kernel.org/linux-cve-announce/2024052148-CVE-2023-52=
764-fa3b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.

Fixed status
cip/4.4: [56f9282550362301af5b0336f221dc86340ad8f0]
cip/4.4-rt: [56f9282550362301af5b0336f221dc86340ad8f0]
cip/4.4-st: [56f9282550362301af5b0336f221dc86340ad8f0]
mainline: [099be1822d1f095433f4b08af9cc9d6308ec1953]
stable/4.19: [2eee8edfff90e22980a6b22079d238c3c9d323bb]
stable/5.10: [c6b6b8692218da73b33b310d7c1df90f115bdd9a]
stable/5.15: [09cd8b561aa9796903710a1046957f2b112c8f26]
stable/5.4: [8f83c85ee88225319c52680792320c02158c2a9b]
stable/6.1: [a647f27a7426d2fe1b40da7c8fa2b81354a51177]
stable/6.6: [e2d7149b913d14352c82624e723ce1c211ca06d3]

CVE-2023-52765: mfd: qcom-spmi-pmic: Fix revid implementation

Announce: https://lore.kernel.org/linux-cve-announce/2024052148-CVE-2023-52=
765-3bc7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e9c11c6 ("mfd: qcom-spmi-pmic: expose the PMIC
revid information to clients") in v6.0-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b439aaa62fee474a0d84d67a25f4984467e7b95]
stable/6.1: [db98de0809f12b0edb9cd1be78e1ec1bfeba8f40]
stable/6.6: [affae18838db5e6b463ee30c821385695af56dc2]

CVE-2023-52766: i3c: mipi-i3c-hci: Fix out of bounds access in
hci_dma_irq_handler

Announce: https://lore.kernel.org/linux-cve-announce/2024052149-CVE-2023-52=
766-2ae1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
This bug was introduced by commit 9ad9a52cc ("i3c/master: introduce
the mipi-i3c-hci driver") in 5.11-rc1.

Fixed status
mainline: [45a832f989e520095429589d5b01b0c65da9b574]
stable/5.15: [d23ad76f240c0f597b7a9eb79905d246f27d40df]
stable/6.1: [8be39f66915b40d26ea2c18ba84b5c3d5da6809b]
stable/6.6: [4c86cb2321bd9c72d3b945ce7f747961beda8e65]

CVE-2023-52767: tls: fix NULL deref on tls_sw_splice_eof() with empty recor=
d

Announce: https://lore.kernel.org/linux-cve-announce/2024052149-CVE-2023-52=
767-1f5b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit df720d2 ("tls/sw: Use splice_eof() to flush") in v6.5-=
rc1.
Fixed in v6.6.4.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [2214e2bb5489145aba944874d0ee1652a0a63dc8]
stable/6.1: [944900fe2736c07288efe2d9394db4d3ca23f2c9]
stable/6.6: [944900fe2736c07288efe2d9394db4d3ca23f2c9]

CVE-2023-52768: wifi: wilc1000: use vmm_table as array in wilc struct

Announce: https://lore.kernel.org/linux-cve-announce/2024052149-CVE-2023-52=
768-68fc@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 40b717b ("wifi: wilc1000: fix DMA on stack
objects") in v6.0-rc5.
Fixed in v6.7-rc1.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [05ac1a198a63ad66bf5ae8b7321407c102d40ef3]
stable/5.15: [541b3757fd443a68ed8d25968eae511a8275e7c8]
stable/6.1: [4b0d6ddb6466d10df878a7787f175a0e4adc3e27]
stable/6.6: [3ce1c2c3999b232258f7aabab311d47dda75605c]

CVE-2023-52769: wifi: ath12k: fix htt mlo-offset event locking

Announce: https://lore.kernel.org/linux-cve-announce/2024052150-CVE-2023-52=
769-8bac@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d889913 ("wifi: ath12k: driver for Qualcomm Wi-Fi
7 devices") in v6.3-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6afc57ea315e0f660b1f870a681737bb7b71faef]
stable/6.6: [afd3425bd69610f318403084fe491e24a1357fb9]

CVE-2023-52770: f2fs: split initial and dynamic conditions for extent_cache

Announce: https://lore.kernel.org/linux-cve-announce/2024052150-CVE-2023-52=
770-fa95@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 72840cc ("f2fs: allocate the extent_cache by
default") in v6.2-rc1.
Fixed in v6.7-rc1.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [f803982190f0265fd36cf84670aa6daefc2b0768]
stable/6.6: [d83309e7e006cee8afca83523559017c824fbf7a]

CVE-2023-52771: cxl/port: Fix delete_endpoint() vs parent unregistration ra=
ce

Announce: https://lore.kernel.org/linux-cve-announce/2024052150-CVE-2023-52=
771-43ad@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8dd2bc0 ("cxl/mem: Add the cxl_mem driver") in v5.18-r=
c1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8d2ad999ca3c64cb08cf6a58d227b9d9e746d708]
stable/6.6: [6b2e428e673b3f55965674a426c40922e91388aa]

CVE-2023-52772: af_unix: fix use-after-free in unix_stream_read_actor()

Announce: https://lore.kernel.org/linux-cve-announce/2024052150-CVE-2023-52=
772-4875@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 876c14a ("af_unix: fix holding spinlock in oob
handling") in v5.15-rc1.
Fixed in v6.7-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b7b492615cf3017190f55444f7016812b66611d]
stable/5.15: [75bcfc188abf4fae9c1d5f5dc0a03540be602eef]
stable/6.1: [d179189eec426fe4801e4b91efa1889faed12700]
stable/6.6: [069a3ec329ff43e7869a3d94c62cd03203016bce]

CVE-2023-52773: drm/amd/display: fix a NULL pointer dereference in
amdgpu_dm_i2c_xfer()

Announce: https://lore.kernel.org/linux-cve-announce/2024052151-CVE-2023-52=
773-8334@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 22676bc ("drm/amd/display: Fix dmub soft hang for
PSR 1") in v6.0-rc1.
Fixed in v6.7-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b71f4ade1b8900d30c661d6c27f87c35214c398c]
stable/6.1: [fb5c134ca589fe670430acc9e7ebf2691ca2476d]
stable/6.6: [1d07b7e84276777dad3c8cfebdf8e739606f90c9]

CVE-2023-52774: s390/dasd: protect device queue against concurrent access

Announce: https://lore.kernel.org/linux-cve-announce/2024052151-CVE-2023-52=
774-1657@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4fa52aa ("[S390] dasd: add enhanced DASD
statistics interface") in v3.1-rc1.
Fixed in v6.7-rc3.

Fixed status
cip/4.4: [0cb17405e685c8d098deda2713dd243e2eaf03cd]
cip/4.4-rt: [0cb17405e685c8d098deda2713dd243e2eaf03cd]
cip/4.4-st: [0cb17405e685c8d098deda2713dd243e2eaf03cd]
mainline: [db46cd1e0426f52999d50fa72cfa97fa39952885]
stable/4.19: [f75617cc8df4155374132f0b500b0b3ebb967458]
stable/5.10: [c841de6247e94e07566d57163d3c0d8b29278f7a]
stable/5.15: [6062c527d0403cef27c54b91ac8390c3a497b250]
stable/5.4: [f1ac7789406e2ca9ac51c41ad2daa597f47bdd4d]
stable/6.1: [dc96fde8fcb2b896fd6c64802a7f4ece2e69b0be]
stable/6.6: [9372aab5d0ff621ea203c8c603e7e5f75e888240]

CVE-2023-52775: net/smc: avoid data corruption caused by decline

Announce: https://lore.kernel.org/linux-cve-announce/2024052151-CVE-2023-52=
775-38a8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0fb0b02 ("net/smc: adapt SMC client code to use
the LLC flow") in v5.8-rc1.
Fixed in v6.7-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e6d71b437abc2f249e3b6a1ae1a7228e09c6e563]
stable/5.10: [5ada292b5c504720a0acef8cae9acc62a694d19c]
stable/5.15: [90072af9efe8c7bd7d086709014ddd44cebd5e7c]
stable/6.1: [94a0ae698b4d5d5bb598e23228002a1491c50add]
stable/6.6: [7234d2b5dffa5af77fd4e0deaebab509e130c6b1]

CVE-2023-52776: wifi: ath12k: fix dfs-radar and temperature event locking

Announce: https://lore.kernel.org/linux-cve-announce/2024052152-CVE-2023-52=
776-1f55@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d889913 ("wifi: ath12k: driver for Qualcomm Wi-Fi
7 devices") in v6.3-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [69bd216e049349886405b1c87a55dce3d35d1ba7]
stable/6.6: [d7a5f7f76568e48869916d769e28b9f3ca70c78e]

CVE-2023-52777: wifi: ath11k: fix gtk offload status event locking

Announce: https://lore.kernel.org/linux-cve-announce/2024052152-CVE-2023-52=
777-2f32@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a16d9b5 ("ath11k: support GTK rekey offload") in v5.19=
-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1dea3c0720a146bd7193969f2847ccfed5be2221]
stable/6.1: [0cf7577b6b3153b4b49deea9719fe43f96469c6d]
stable/6.6: [e83246ecd3b193f8d91fce778e8a5ba747fc7d8a]

CVE-2023-52778: mptcp: deal with large GSO size

Announce: https://lore.kernel.org/linux-cve-announce/2024052152-CVE-2023-52=
778-2a54@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7c4e983 ("net: allow gso_max_size to exceed
65536") in v5.19-rc1.
Fixed in v6.7-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9fce92f050f448a0d1ddd9083ef967d9930f1e52]
stable/6.1: [70ff9b65a72885b3a2dfde6709da1f19b85fa696]
stable/6.6: [57ced2eb77343a91d28f4a73675b05fe7b555def]

CVE-2023-52779: fs: Pass AT_GETATTR_NOSEC flag to getattr interface functio=
n

Announce: https://lore.kernel.org/linux-cve-announce/2024052153-CVE-2023-52=
779-59e8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit db1d1e8 ("IMA: use vfs_getattr_nosec to get the
i_version") in v6.5-rc1.
Fixed in v6.7-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a924db2d7b5eb69ba08b1a0af46e9f1359a9bdf]
stable/6.6: [3fb0fa08641903304b9d81d52a379ff031dc41d4]

CVE-2023-52780: net: mvneta: fix calls to page_pool_get_stats

Announce: https://lore.kernel.org/linux-cve-announce/2024052153-CVE-2023-52=
780-0324@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b3fc792 ("net: mvneta: add support for
page_pool_get_stats") in v5.19-rc1.
Fixed in v6.7-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ca8add922f9c7f6e2e3c71039da8e0dcc64b87ed]
stable/6.1: [00768b3e90e648227eaa959d9d279f5e32823df1]
stable/6.6: [2b0e99072654edd601d05c0061a20337af5008ba]

CVE-2023-52781: usb: config: fix iteration issue in 'usb_get_bos_descriptor=
()'

Announce: https://lore.kernel.org/linux-cve-announce/2024052153-CVE-2023-52=
781-8f04@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3dd550a ("USB: usbcore: Fix slab-out-of-bounds
bug during device reset") in v5.4-rc1.
Fixed in v6.7-rc3.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st stable/4.19

Fixed status
mainline: [974bba5c118f4c2baf00de0356e3e4f7928b4cbc]
stable/5.10: [9ef94ec8e52eaf7b9abc5b5f8f5b911751112223]
stable/5.15: [64c27b7b2357ddb38b6afebaf46d5bff4d250702]
stable/6.1: [f89fef7710b2ba0f7a1e46594e530dcf2f77be91]
stable/6.6: [7c0244cc311a4038505b73682b7c8ceaa5c7a8c8]

CVE-2023-52782: net/mlx5e: Track xmit submission to PTP WQ after
populating metadata map

Announce: https://lore.kernel.org/linux-cve-announce/2024052153-CVE-2023-52=
782-acc6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3178308 ("net/mlx5e: Make tx_port_ts logic
resilient to out-of-order CQEs") in v6.6-rc1.
Fixed in v6.6.3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d510506b46504664eacf8a44a9e8f3e54c137b8]
stable/6.6: [a9d6c0c5a6bd9ca88e964f8843ea41bc085de866]

CVE-2023-52783: net: wangxun: fix kernel panic due to null pointer

Announce: https://lore.kernel.org/linux-cve-announce/2024052154-CVE-2023-52=
783-8ea7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 79625f4 ("net: wangxun: Move MAC address handling
to libwx") in v6.3-rc1.
Fixed in v6.7-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ba2c459668cfe2aaacc5ebcd35b4b9ef8643013]
stable/6.6: [61a55071653974dab172d4c5d699bb365cfd13c9]

CVE-2023-52784: bonding: stop the device in bond_setup_by_slave()

Announce: https://lore.kernel.org/linux-cve-announce/2024052154-CVE-2023-52=
784-80ad@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 872254d ("net/bonding: Enable bonding to enslave
non ARPHRD_ETHER") in v2.6.24-rc1.
Fixed in v6.7-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3cffa2ddc4d3fcf70cde361236f5a614f81a09b2]
stable/5.10: [396baca6683f415b5bc2b380289387bef1406edc]
stable/5.15: [53064e8239dd2ecfefc5634e991f1025abc2ee0c]
stable/5.4: [b4f0e605a508f6d7cda6df2f03a0c676b778b1fe]
stable/6.1: [19554aa901b5833787df4417a05ccdebf351b7f4]
stable/6.6: [d98c91215a5748a0f536e7ccea26027005196859]

CVE-2023-52785: scsi: ufs: core: Fix racing issue between
ufshcd_mcq_abort() and ISR

Announce: https://lore.kernel.org/linux-cve-announce/2024052154-CVE-2023-52=
785-8104@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f1304d4 ("scsi: ufs: mcq: Added
ufshcd_mcq_abort()") in v6.5-rc1.
Fixed in v6.7-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [27900d7119c464b43cd9eac69c85884d17bae240]
stable/6.6: [f84d461f33a6b27304d468d9cfb56c0cefdb4ee7]

CVE-2023-52786: ext4: fix racy may inline data check in dio write

Announce: https://lore.kernel.org/linux-cve-announce/2024052155-CVE-2023-52=
786-ff76@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 310ee09 ("ext4: allow concurrent unaligned dio
overwrites") in v6.5-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce56d21355cd6f6937aca32f1f44ca749d1e4808]
stable/6.6: [7343c23ebcadbedc23a7063d1e24d976eccb0d0d]

CVE-2023-52787: blk-mq: make sure active queue usage is held for
bio_integrity_prep()

Announce: https://lore.kernel.org/linux-cve-announce/2024052155-CVE-2023-52=
787-67f0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 900e080 ("block: move queue enter logic into
blk_mq_submit_bio()") in v5.16-rc1.
Fixed in v6.7-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b0077e269f6c152e807fdac90b58caf012cdbaab]
stable/6.1: [b5c8e0ff76d10f6bf70a7237678f27c20cf59bc9]
stable/6.6: [b80056bd75a16e4550873ecefe12bc8fd190b1cf]

CVE-2023-52788: i915/perf: Fix NULL deref bugs with drm_dbg() calls

Announce: https://lore.kernel.org/linux-cve-announce/2024052155-CVE-2023-52=
788-9cb4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2fec539 ("i915/perf: Replace DRM_DEBUG with
driver specific drm_dbg call") in v6.0-rc1.
Fixed in v6.7-rc1.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [471aa951bf1206d3c10d0daa67005b8e4db4ff83]
stable/5.15: [1566e8be73fd5fa424e88d2a4cffdc34f970f0e1]
stable/6.1: [55db76caa782baa4a1bf02296e2773c38a524a3e]
stable/6.6: [10f49cdfd5fb342a1a9641930dc040c570694e98]

CVE-2023-52789: tty: vcc: Add check for kstrdup() in vcc_probe()

Announce: https://lore.kernel.org/linux-cve-announce/2024052156-CVE-2023-52=
789-6006@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
Introduced by commit 5d17105 ("sparc64: vcc: Enable VCC port probe and
removal") in 4.14-rc1.

Fixed status
mainline: [d81ffb87aaa75f842cd7aa57091810353755b3e6]
stable/4.19: [909963e0c16778cec28efb1affc21558825f4200]
stable/5.10: [4ef41a7f33ffe1a335e7db7e1564ddc6afad47cc]
stable/5.15: [6c80f48912b5bd4965352d1a9a989e21743a4a06]
stable/5.4: [460284dfb10b207980c6f3f7046e33446ceb38ac]
stable/6.1: [7cebc86481bf16049e266f6774d90f2fd4f8d5d2]
stable/6.6: [8f8771757b130383732195497e47fba2aba76d3a]

CVE-2023-52790: swiotlb: fix out-of-bounds TLB allocations with
CONFIG_SWIOTLB_DYNAMIC

Announce: https://lore.kernel.org/linux-cve-announce/2024052156-CVE-2023-52=
790-2a4f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 79636ca ("swiotlb: if swiotlb is full, fall back
to a transient memory pool") in v6.6-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [53c87e846e335e3c18044c397cc35178163d7827]
stable/6.6: [ce7612496a4ba6068bc68aa1fa9d947dadb4ad9b]

CVE-2023-52791: i2c: core: Run atomic i2c xfer when !preemptible

Announce: https://lore.kernel.org/linux-cve-announce/2024052156-CVE-2023-52=
791-f2b9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit bae1d3a ("i2c: core: remove use of in_atomic()")
in v5.2-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa49c90894d06e18a1ee7c095edbd2f37c232d02]
stable/5.10: [25284c46b657f48c0f3880a2e0706c70d81182c0]
stable/5.15: [f6237afabc349c1c7909db00e15d2816519e0d2b]
stable/5.4: [25eb381a736e7ae39a4245ef5c96484eb1073809]
stable/6.1: [185f3617adc8fe45e40489b458f03911f0dec46c]
stable/6.6: [3473cf43b9068b9dfef2f545f833f33c6a544b91]

CVE-2023-52792: cxl/region: Do not try to cleanup after
cxl_region_setup_targets() fails

Announce: https://lore.kernel.org/linux-cve-announce/2024052156-CVE-2023-52=
792-69ce@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5e42bcb ("cxl/region: decrement ->nr_targets on
error in cxl_region_attach()") in v6.0-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0718588c7aaa7a1510b4de972370535b61dddd0d]
stable/6.1: [90db4c1d5ebaf574d3c3065c055977982c378a83]
stable/6.6: [07ffcd8ec79cf7383e1e45815f4842fd357991c2]

CVE-2023-52793: samples/bpf: syscall_tp_user: Fix array out-of-bound access

Announce: https://lore.kernel.org/linux-cve-announce/2024052157-CVE-2023-52=
793-18ab@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 06744f2 ("samples/bpf: Add openat2() enter/exit
tracepoint to syscall_tp sample") in v6.3-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9220c3ef6fefbf18f24aeedb1142a642b3de0596]
stable/6.6: [de4825a444560f8cb78b03dda3ba873fab88bc4f]

CVE-2023-52794: thermal: intel: powerclamp: fix mismatch in get
function for max_idle

Announce: https://lore.kernel.org/linux-cve-announce/2024052157-CVE-2023-52=
794-bb34@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ebf5197 ("thermal: intel: powerclamp: Add two
module parameters") in v6.3-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fae633cfb729da2771b5433f6b84ae7e8b4aa5f7]
stable/6.6: [0a8585281b11e3a0723bba8d8085d61f0b55f37c]

CVE-2023-52795: vhost-vdpa: fix use after free in vhost_vdpa_probe()

Announce: https://lore.kernel.org/linux-cve-announce/2024052157-CVE-2023-52=
795-4811@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ebe6a35 ("vhost-vdpa: Call ida_simple_remove()
when failed") in v6.0-rc1.
Fixed in v6.7-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e07754e0a1ea2d63fb29574253d1fd7405607343]
stable/6.1: [c0f8b8fb7df9d1a38652eb5aa817afccd3c56111]
stable/6.6: [bf04132cd64ccde4e9e9765d489c83fe83c09b7f]

CVE-2023-52796: ipvlan: add ipvlan_route_v6_outbound() helper

Announce: https://lore.kernel.org/linux-cve-announce/2024052158-CVE-2023-52=
796-860d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2ad7bf3 ("ipvlan: Initial check-in of the IPVLAN
driver.") in v3.19-rc1.
Fixed in v6.7-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [18f039428c7df183b09c69ebf10ffd4e521035d2]
stable/4.19: [4f7f850611aa27aaaf1bf5687702ad2240ae442a]
stable/5.10: [43b781e7cb5cd0b435de276111953bf2bacd1f02]
stable/5.15: [1f64cad3ac38ac5978b53c40e6c5e6fd3477c68f]
stable/5.4: [4d2d30f0792b47908af64c4d02ed1ee25ff50542]
stable/6.1: [732a67ca436887b594ebc43bb5a04ffb0971a760]
stable/6.6: [03cddc4df8c6be47fd27c8f8b87e5f9a989e1458]

CVE-2023-52797: drivers: perf: Check find_first_bit() return value

Announce: https://lore.kernel.org/linux-cve-announce/2024052158-CVE-2023-52=
797-3d7a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4905ec2 ("RISC-V: Add sscofpmf extension
support") in v5.18-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c6e316ac05532febb0c966fa9b55f5258ed037be]
stable/6.6: [45a0de41ec383c8b7c6d442734ba3852dd2fc4a7]

CVE-2023-52798: wifi: ath11k: fix dfs radar event locking

Announce: https://lore.kernel.org/linux-cve-announce/2024052158-CVE-2023-52=
798-374e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d5c6515 ("ath11k: driver for Qualcomm IEEE
802.11ax devices") in v5.6-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3b6c14833165f689cc5928574ebafe52bbce5f1e]
stable/5.10: [f882f51905517575c9f793a3dff567af90ef9a10]
stable/5.15: [426e718ce9ba60013364a54233feee309356cb82]
stable/6.1: [ca420ac4f9451f22347bae44b18ab47ba2c267ec]
stable/6.6: [21ebb0aba580d347e12f01ce5f6e75044427b3d5]

CVE-2023-52799: jfs: fix array-index-out-of-bounds in dbFindLeaf

Announce: https://lore.kernel.org/linux-cve-announce/2024052159-CVE-2023-52=
799-c335@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.

Fixed status
cip/4.4: [95675ab17d1c330bcb1311974fd3549c38b23d89]
cip/4.4-rt: [95675ab17d1c330bcb1311974fd3549c38b23d89]
cip/4.4-st: [95675ab17d1c330bcb1311974fd3549c38b23d89]
mainline: [22cad8bc1d36547cdae0eef316c47d917ce3147c]
stable/4.19: [86df90f3fea7c5591f05c8a0010871d435e83046]
stable/5.10: [81aa58cd8495b8c3b527f58ccbe19478d8087f61]
stable/5.15: [da3da5e1e6f71c21d8e6149d7076d936ef5d4cb9]
stable/5.4: [ecfb47f13b08b02cf28b7b50d4941eefa21954d2]
stable/6.1: [a50b796d36719757526ee094c703378895ab5e67]
stable/6.6: [87c681ab49e99039ff2dd3e71852417381b13878]

CVE-2023-52800: wifi: ath11k: fix htt pktlog locking

Announce: https://lore.kernel.org/linux-cve-announce/2024052159-CVE-2023-52=
800-63da@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d5c6515 ("ath11k: driver for Qualcomm IEEE
802.11ax devices") in v5.6-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f77c7d605b29df277d77e9ee75d96e7ad145d2d]
stable/5.10: [03ed26935bebf6b6fd8a656490bf3dcc71b72679]
stable/5.15: [3a51e6b4da71fdfa43ec006d6abc020f3e22d14e]
stable/6.1: [e3199b3fac65c9f103055390b6fd07c5cffa5961]
stable/6.6: [69cede2a5a5f60e3f5602b901b52cb64edd2ea6c]

CVE-2023-52801: iommufd: Fix missing update of domains_itree after
splitting iopt_area

Announce: https://lore.kernel.org/linux-cve-announce/2024052159-CVE-2023-52=
801-b287@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 51fe614 ("iommufd: Data structure to provide IOVA
to PFN mapping") in v6.2-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e7250ab7ca4998fe026f2149805b03e09dc32498]
stable/6.6: [fcb32111f01ddf3cbd04644cde1773428e31de6a]

CVE-2023-52802: iio: adc: stm32-adc: harden against NULL pointer deref
in stm32_adc_probe()

Announce: https://lore.kernel.org/linux-cve-announce/2024052159-CVE-2023-52=
802-81ce@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
Introduced by commit 64ad7f6 ("iio: adc: stm32: introduce compatible
data cfg") in 4.13-rc1.

Fixed status
mainline: [3a23b384e7e3d64d5587ad10729a34d4f761517e]
stable/6.1: [b80aaff5f7817d50798ac61ed75973f004dd5202]
stable/6.6: [5b82e4240533bcd4691e50b64ec86d0d7fbd21b9]

CVE-2023-52803: SUNRPC: Fix RPC client cleaned up the freed pipefs dentries

Announce: https://lore.kernel.org/linux-cve-announce/2024052100-CVE-2023-52=
803-1f43@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0157d02 ("SUNRPC: handle RPC client pipefs
dentries by network namespace aware routines") in v3.4-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bfca5fb4e97c46503ddfc582335917b0cc228264]
stable/5.10: [dedf2a0eb9448ae73b270743e6ea9b108189df46]
stable/5.15: [194454afa6aa9d6ed74f0c57127bc8beb27c20df]
stable/6.1: [7749fd2dbef72a52b5c9ffdbf877691950ed4680]
stable/6.6: [cc2e7ebbeb1d0601f7f3c8d93b78fcc03a95e44a]

CVE-2023-52804: fs/jfs: Add validity check for db_maxag and db_agpref

Announce: https://lore.kernel.org/linux-cve-announce/2024052100-CVE-2023-52=
804-b817@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.

Fixed status
cip/4.4: [772253dbcda996fe36e6ea46ac910ae48be67323]
cip/4.4-rt: [772253dbcda996fe36e6ea46ac910ae48be67323]
cip/4.4-st: [772253dbcda996fe36e6ea46ac910ae48be67323]
mainline: [64933ab7b04881c6c18b21ff206c12278341c72e]
stable/4.19: [ce15b0f1a431168f07b1cc6c9f71206a2db5c809]
stable/5.10: [c6c8863fb3f57700ab583d875adda04caaf2278a]
stable/5.15: [1f74d336990f37703a8eee77153463d65b67f70e]
stable/5.4: [32bd8f1cbcf8b663e29dd1f908ba3a129541a11b]
stable/6.1: [5013f8269887642cca784adc8db9b5f0b771533f]
stable/6.6: [2323de34a3ae61a9f9b544c18583f71cea86721f]

CVE-2023-52805: jfs: fix array-index-out-of-bounds in diAlloc

Announce: https://lore.kernel.org/linux-cve-announce/2024052100-CVE-2023-52=
805-1338@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.

Fixed status
cip/4.4: [4cf8348791a2b5b3df1a1d54d1fd202f1ea9099b]
cip/4.4-rt: [4cf8348791a2b5b3df1a1d54d1fd202f1ea9099b]
cip/4.4-st: [4cf8348791a2b5b3df1a1d54d1fd202f1ea9099b]
mainline: [05d9ea1ceb62a55af6727a69269a4fd310edf483]
stable/4.19: [cf7e3e84df36a9953796c737f080712f631d7083]
stable/5.10: [1ba7df5457dc1c1071c5f92ac11323533a6430e1]
stable/5.15: [64f062baf202b82f54987a3f614a6c8f3e466641]
stable/5.4: [7467ca10a5ff09b0e87edf6c4d2a4bfdee69cf2c]
stable/6.1: [8c68af2af697ba2ba3b138be0c6d72e2ce3a3d6d]
stable/6.6: [1708d0a9917fea579cc9da3d87b154285abd2cd8]

CVE-2023-52806: ALSA: hda: Fix possible null-ptr-deref when assigning a str=
eam

Announce: https://lore.kernel.org/linux-cve-announce/2024052101-CVE-2023-52=
806-e9ee@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.

Fixed status
cip/4.4: [ffbe59f96196aa2847039f10edd095257fb76a39]
cip/4.4-rt: [ffbe59f96196aa2847039f10edd095257fb76a39]
cip/4.4-st: [ffbe59f96196aa2847039f10edd095257fb76a39]
mainline: [f93dc90c2e8ed664985e366aa6459ac83cdab236]
stable/4.19: [758c7733cb821041f5fd403b7b97c0b95d319323]
stable/5.10: [25354bae4fc310c3928e8a42fda2d486f67745d7]
stable/5.15: [631a96e9eb4228ff75fce7e72d133ca81194797e]
stable/5.4: [2527775616f3638f4fd54649eba8c7b84d5e4250]
stable/6.1: [43b91df291c8802268ab3cfd8fccfdf135800ed4]
stable/6.6: [4a320da7f7cbdab2098b103c47f45d5061f42edd]

CVE-2023-52807: net: hns3: fix out-of-bounds access may occur when
coalesce info is read via debugfs

Announce: https://lore.kernel.org/linux-cve-announce/2024052101-CVE-2023-52=
807-dcb9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c99fead ("net: hns3: add debugfs support for
interrupt coalesce") in v5.16-rc1.
Fixed in v6.7-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [53aba458f23846112c0d44239580ff59bc5c36c3]
stable/6.1: [07f5b8c47152cadbd9102e053dcb60685820aa09]
stable/6.6: [f79d985c69060047426be68b7e4c1663d5d731b4]

CVE-2023-52808: scsi: hisi_sas: Set debugfs_dir pointer to NULL after
removing debugfs

Announce: https://lore.kernel.org/linux-cve-announce/2024052101-CVE-2023-52=
808-b457@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
Introduced by commit 623a4b6d ("scsi: hisi_sas: Move debugfs code to
v3 hw driver") in 5.11-rc1.

Fixed status
mainline: [6de426f9276c448e2db7238911c97fb157cb23be]
stable/5.15: [f0bfc8a5561fb0b2c48183dcbfe00bdd6d973bd3]
stable/6.1: [33331b265aac9441ac0c1a5442e3f05d038240ec]
stable/6.6: [b4465009e7d60c6111946db4c8f1e50d401ed7be]

CVE-2023-52809: scsi: libfc: Fix potential NULL pointer dereference in
fc_lport_ptp_setup()

Announce: https://lore.kernel.org/linux-cve-announce/2024052102-CVE-2023-52=
809-f07c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.

Fixed status
cip/4.4: [3fd261462ca49f4418baceda0f7a943a1fc6218e]
cip/4.4-rt: [3fd261462ca49f4418baceda0f7a943a1fc6218e]
cip/4.4-st: [3fd261462ca49f4418baceda0f7a943a1fc6218e]
mainline: [4df105f0ce9f6f30cda4e99f577150d23f0c9c5f]
stable/4.19: [77072ec41d6ab3718c3fc639bc149b8037caedfa]
stable/5.10: [bb83f79f90e92f46466adcfd4fd264a7ae0f0f01]
stable/5.15: [56d78b5495ebecbb9395101f3be177cd0a52450b]
stable/5.4: [b549acf999824d4f751ca57965700372f2f3ad00]
stable/6.1: [442fd24d7b6b29e4a9cd9225afba4142d5f522ba]
stable/6.6: [6b9ecf4e1032e645873933e5b43cbb84cac19106]

CVE-2023-52810: fs/jfs: Add check for negative db_l2nbperpage

Announce: https://lore.kernel.org/linux-cve-announce/2024052102-CVE-2023-52=
810-efd0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.

Fixed status
cip/4.4: [e2b9527d119c9b444bda51d81f19d78a97d5d069]
cip/4.4-rt: [e2b9527d119c9b444bda51d81f19d78a97d5d069]
cip/4.4-st: [e2b9527d119c9b444bda51d81f19d78a97d5d069]
mainline: [525b861a008143048535011f3816d407940f4bfa]
stable/4.19: [8f2964df6bfce9d92d81ca552010b8677af8d9dc]
stable/5.10: [524b4f203afcf87accfe387e846f33f916f0c907]
stable/5.15: [5f148b16972e5f4592629b244d5109b15135f53f]
stable/5.4: [a81a56b4cbe3142cc99f6b98e8f9b3a631c768e1]
stable/6.1: [0cb567e727339a192f9fd0db00781d73a91d15a6]
stable/6.6: [1a7c53fdea1d189087544d9a606d249e93c4934b]

CVE-2023-52811: scsi: ibmvfc: Remove BUG_ON in the case of an empty event p=
ool

Announce: https://lore.kernel.org/linux-cve-announce/2024052102-CVE-2023-52=
811-2a5f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
It seems as if checking return value from ibmvfc_get_event() is
required for all kernels.

Fixed status
mainline: [b39f2d10b86d0af353ea339e5815820026bca48f]
stable/5.15: [e1d1f79b1929dce470a5dc9281c574cd58e8c6c0]
stable/6.1: [88984ec4792766df5a9de7a2ff2b5f281f94c7d4]
stable/6.6: [8bbe784c2ff28d56ca0c548aaf3e584edc77052d]

CVE-2023-52812: drm/amd: check num of link levels when update pcie param

Announce: https://lore.kernel.org/linux-cve-announce/2024052102-CVE-2023-52=
812-b5b2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
Introduced by commit 31c7a3b ("drm/amd/pm: conditionally disable pcie
lane/speed switching for SMU13") in 6.5-rc2.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [406e8845356d18bdf3d3a23b347faf67706472ec]
stable/6.6: [09f617219fe9ccd8d7b65dc3e879b5889f663b5a]

CVE-2023-52813: crypto: pcrypt - Fix hungtask for PADATA_RESET

Announce: https://lore.kernel.org/linux-cve-announce/2024052103-CVE-2023-52=
813-0704@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.

Fixed status
cip/4.4: [e97380c96a84d2e6acf3c721e1fb08be994e28b7]
cip/4.4-rt: [e97380c96a84d2e6acf3c721e1fb08be994e28b7]
cip/4.4-st: [e97380c96a84d2e6acf3c721e1fb08be994e28b7]
mainline: [8f4f68e788c3a7a696546291258bfa5fdb215523]
stable/4.19: [039fec48e062504f14845124a1a25eb199b2ddc0]
stable/5.10: [e97bf4ada7dddacd184c3e196bd063b0dc71b41d]
stable/5.15: [546c1796ad1ed0d87dab3c4b5156d75819be2316]
stable/5.4: [c9c1334697301c10e6918d747ed38abfbc0c96e7]
stable/6.1: [c55fc098fd9d2dca475b82d00ffbcaf97879d77e]
stable/6.6: [372636debe852913529b1716f44addd94fff2d28]

CVE-2023-52814: drm/amdgpu: Fix potential null pointer derefernce

Announce: https://lore.kernel.org/linux-cve-announce/2024052103-CVE-2023-52=
814-1cae@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
Introduced by commit d5ea093 ("dmr/amdgpu: Add system auto reboot to
RAS.") in 5.5-rc1.

Fixed status
mainline: [80285ae1ec8717b597b20de38866c29d84d321a1]
stable/5.10: [b93a25de28af153312f0fc979b0663fc4bd3442b]
stable/5.15: [c11cf5e117f50f5a767054600885acd981449afe]
stable/6.1: [9b70fc7d70e8ef7c4a65034c9487f58609e708a1]
stable/6.6: [da46e63482fdc5e35c008865c22ac64027f6f0c2]

CVE-2023-52815: drm/amdgpu/vkms: fix a possible null pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024052103-CVE-2023-52=
815-a80a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
Introduced by commit 84ec374 ("drm/amdgpu: create amdgpu_vkms (v4)")
in 5.15-rc1.

Fixed status
mainline: [cd90511557fdfb394bb4ac4c3b539b007383914c]
stable/5.15: [eaa03ea366c85ae3cb69c8d4bbc67c8bc2167a27]
stable/6.1: [33fb1a555354bd593f785935ddcb5d9dd4d3847f]
stable/6.6: [70f831f21155c692bb336c434936fd6f24f3f81a]

CVE-2023-52816: drm/amdkfd: Fix shift out-of-bounds issue

Announce: https://lore.kernel.org/linux-cve-announce/2024052104-CVE-2023-52=
816-73c7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
Introduced by commit 42de67 ("drm/amdkfd: register svm range") in 5.14-rc1.

Fixed status
mainline: [282c1d793076c2edac6c3db51b7e8ed2b41d60a5]
stable/5.15: [3f7a400d5e80f99581e3e8a9843e1f6118bf454f]
stable/6.1: [2806f880379232e789957c2078d612669eb7a69c]
stable/6.6: [56649c43d40ce0147465a2d5756d300e87f9ee1c]

CVE-2023-52817: drm/amdgpu: Fix a null pointer access when the
smc_rreg pointer is NULL

Announce: https://lore.kernel.org/linux-cve-announce/2024052104-CVE-2023-52=
817-ba29@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
It looks as if 4.4 need check if adev is NULL or not before using this
value in amdgpu_debugfs_regs_read() and amdgpu_debugfs_regs_write().

Fixed status
mainline: [5104fdf50d326db2c1a994f8b35dcd46e63ae4ad]
stable/4.19: [bf2d51eedf03bd61e3556e35d74d49e2e6112398]
stable/5.10: [f475d5502f33a6c5b149b0afe96316ad1962a64a]
stable/5.15: [174f62a0aa15c211e60208b41ee9e7cdfb73d455]
stable/5.4: [437e0fa907ba39b4d7eda863c03ea9cf48bd93a9]
stable/6.1: [6c1b3d89a2dda79881726bb6e37af19c0936d736]
stable/6.6: [ba3c0796d292de84f2932cc5bbb0f771fc720996]

CVE-2023-52818: drm/amd: Fix UBSAN array-index-out-of-bounds for SMU7

Announce: https://lore.kernel.org/linux-cve-announce/2024052104-CVE-2023-52=
818-758f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.

Fixed status
cip/4.4: [f18088e8b73f448c211d9db0c85bef12d979e9d8]
cip/4.4-rt: [f18088e8b73f448c211d9db0c85bef12d979e9d8]
cip/4.4-st: [f18088e8b73f448c211d9db0c85bef12d979e9d8]
mainline: [760efbca74a405dc439a013a5efaa9fadc95a8c3]
stable/4.19: [cfd8cd907fd94538561479a43aea455f5cf16928]
stable/5.10: [8af28ae3acb736ada4ce3457662fa446cc913bb4]
stable/5.15: [acdb6830de02cf2873aeaccdf2d9bca4aee50e47]
stable/5.4: [c847379a5d00078ad6fcb1c24230e72c5609342f]
stable/6.1: [fc9ac0e8e0bcb3740c6eaad3a1a50c20016d422b]
stable/6.6: [92a775e7c9707aed28782bafe636bf87675f5a97]

CVE-2023-52819: drm/amd: Fix UBSAN array-index-out-of-bounds for
Polaris and Tonga

Announce: https://lore.kernel.org/linux-cve-announce/2024052105-CVE-2023-52=
819-98d5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
It looks as if 4.4 does not have affeced file.

Fixed status
mainline: [0f0e59075b5c22f1e871fbd508d6e4f495048356]
stable/4.19: [a63fd579e7b1c3a9ebd6e6c494d49b1b6cf5515e]
stable/5.10: [8c1dbddbfcb051e82cea0c197c620f9dcdc38e92]
stable/5.15: [a237675aa1e62bbfaa341c535331c8656a508fa1]
stable/5.4: [d50a56749e5afdc63491b88f5153c1aae00d4679]
stable/6.1: [d0725232da777840703f5f1e22f2e3081d712aa4]
stable/6.6: [b3b8b7c040cf069da7afe11c5bd73b870b8f3d18]

CVE-2023-52820: drm_lease.c: copy user-array safely

Announce: https://lore.kernel.org/linux-cve-announce/2024052105-CVE-2023-52=
820-1d6d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
Using memdup_user() start from commit 62884cd ("drm: Add four ioctls
for managing drm mode object leases [v7]") in 4.15-rc1.

Fixed status
mainline: [f37d63e219c39199a59b8b8a211412ff27192830]
stable/6.1: [0f5f56745188b06f13509e5054231cb7a4cb047d]
stable/6.6: [ea42bc330723644a0bd01d7124a601ab60b27747]

CVE-2023-52821: drm/panel: fix a possible null pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024052105-CVE-2023-52=
821-1b6f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
Introduced by commit f40f5b8 ("drm/panel: Add support for ARM
Versatile panels") in 4.17-rc1.

Fixed status
mainline: [924e5814d1f84e6fa5cb19c6eceb69f066225229]
stable/5.10: [c7dc0aca5962fb37dbea9769dd26ec37813faae1]
stable/5.15: [2381f6b628b3214f07375e0adf5ce17093c31190]
stable/6.1: [79813cd59398015867d51e6d7dcc14d287d4c402]
stable/6.6: [8a9dd36fcb4f3906982b82593393578db4479992]

CVE-2023-52822: drm: vmwgfx_surface.c: copy user-array safely

Announce: https://lore.kernel.org/linux-cve-announce/2024052105-CVE-2023-52=
822-9e83@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
memdump_user() is using since commit c138d03f ("drm/vmwgfx: Use
memdup_user() rather than duplicating its implementation") in 4.9-rc2.

Fixed status
mainline: [06ab64a0d836ac430c5f94669710a78aa43942cb]
stable/5.15: [689b33b94f096e717cd8f140a8b5502e7e4fe759]
stable/6.1: [412ce89669341dfd8ed98a4746ad3dbe9653a7b8]
stable/6.6: [21e29f1437b7c36c76efa908589578eaf0f50900]

CVE-2023-52823: kernel: kexec: copy user-array safely

Announce: https://lore.kernel.org/linux-cve-announce/2024052106-CVE-2023-52=
823-3d81@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
memdup_user is using since commit 5d700a0f ("kexec: avoid
compat_alloc_user_space") in 5.15-rc1.

Fixed status
mainline: [569c8d82f95eb5993c84fb61a649a9c4ddd208b3]
stable/5.15: [d4f2c09d4672f0e997ba4b1b589cc376be7ec938]
stable/6.1: [8332523b13dbfcce60f631dfb34ac90df021b4bd]
stable/6.6: [4fc857cc5cb9b7ce6940898857d773564973a584]

CVE-2023-52824: kernel: watch_queue: copy user-array safely

Announce: https://lore.kernel.org/linux-cve-announce/2024052106-CVE-2023-52=
824-3586@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
memdup_user() is using since commit c73be61 ("pipe: Add general
notification queue support") in 5.8-rc1.

Fixed status
mainline: [ca0776571d3163bd03b3e8c9e3da936abfaecbf6]
stable/5.15: [22260dabcfe30ab70440d91aa1e4a703d13925c4]
stable/6.1: [6995df256e4f5841fb45cf40d04f94b62b8067e1]
stable/6.6: [0f403ebad98e6151aaa9c96c9aae5549aa4d87cd]

CVE-2023-52825: drm/amdkfd: Fix a race condition of vram buffer unref
in svm code

Announce: https://lore.kernel.org/linux-cve-announce/2024052106-CVE-2023-52=
825-0696@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
Introduced by commit e49fe40 ("drm/amdkfd: validate vram svm range
from TTM") in 5.14-v1.

Fixed status
mainline: [709c348261618da7ed89d6c303e2ceb9e453ba74]
stable/5.15: [7d43cdd22cd81a2b079e864c4321b9aba4c6af34]
stable/6.1: [50f35a907c4f9ed431fd3dbb8b871ef1cbb0718e]
stable/6.6: [fc0210720127cc6302e6d6f3de48f49c3fcf5659]

CVE-2023-52826: drm/panel/panel-tpo-tpg110: fix a possible null
pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024052107-CVE-2023-52=
826-9960@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
Introduced by commit 324bb707 ("drm/panel: Add a driver for the TPO
TPG110") in 5.1-rc1.

Fixed status
mainline: [f22def5970c423ea7f87d5247bd0ef91416b0658]
stable/5.10: [9acc2bc00135e9ecd13a70ce1140e2673e504cdc]
stable/5.15: [84c923d898905187ebfd4c0ef38cd1450af7e0ea]
stable/6.1: [d0bc9ab0a161a9745273f5bf723733a8e6c57aca]
stable/6.6: [eaede6900c0961b072669d6bd97fe8f90ed1900f]

CVE-2023-52827: wifi: ath12k: fix possible out-of-bound read in
ath12k_htt_pull_ppdu_stats()

Announce: https://lore.kernel.org/linux-cve-announce/2024052107-CVE-2023-52=
827-c62f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
Introduced by commit d88991 ("wifi: ath12k: driver for Qualcomm Wi-Fi
7 devices") in 6.3-rc1.

Fixed status
mainline: [1bc44a505a229bb1dd4957e11aa594edeea3690e]
stable/6.6: [c9e44111da221246efb2e623ae1be40a5cf6542c]

CVE-2023-52828: bpf: Detect IP =3D=3D ksym.end as part of BPF program

Announce: https://lore.kernel.org/linux-cve-announce/2024052107-CVE-2023-52=
828-e1e5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
Since commit 74451e6 ("bpf: make jited programs visible in traces") in
4.11-rc1, operand >=3D was used in bpf_tree_comp().

Fixed status
mainline: [66d9111f3517f85ef2af0337ece02683ce0faf21]
stable/5.10: [6058e4829696412457729a00734969acc6fd1d18]
stable/5.15: [cf353904a82873e952633fcac4385c2fcd3a46e1]
stable/6.1: [aa42a7cb92647786719fe9608685da345883878f]
stable/6.6: [821a7e4143af115b840ec199eb179537e18af922]

CVE-2023-52829: wifi: ath12k: fix possible out-of-bound write in
ath12k_wmi_ext_hal_reg_caps()

Announce: https://lore.kernel.org/linux-cve-announce/2024052108-CVE-2023-52=
829-3283@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
Introduced by commit d88991 ("wifi: ath12k: driver for Qualcomm Wi-Fi
7 devices") in 6.3-rc1.

Fixed status
mainline: [b302dce3d9edea5b93d1902a541684a967f3c63c]
stable/6.6: [4dd0547e8b45faf6f95373be5436b66cde326c0e]

CVE-2023-52830: Bluetooth: Fix double free in hci_conn_cleanup

Announce: https://lore.kernel.org/linux-cve-announce/2024052108-CVE-2023-52=
830-529a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
It seems as if Linux 4.4 is affected.

Fixed status
mainline: [a85fb91e3d728bdfc80833167e8162cce8bc7004]
stable/4.19: [5c53afc766e07098429520b7677eaa164b593451]
stable/5.10: [53d61daf35b1bbf3ae06e852ee107aa2f05b3776]
stable/5.15: [ba7088769800d9892a7e4f35c3137a5b3e65410b]
stable/5.4: [3c4236f1b2a715e878a06599fa8b0cc21f165d28]
stable/6.1: [87624b1f9b781549e69f92db7ede012a21cec275]
stable/6.6: [56a4fdde95ed98d864611155f6728983e199e198]

CVE-2023-52831: cpu/hotplug: Don't offline the last non-isolated CPU

Announce: https://lore.kernel.org/linux-cve-announce/2024052108-CVE-2023-52=
831-ce31@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
Introduced by commit 2b8272f ("cpu/hotplug: Prevent self deadlock on
CPU hot-unplug") in 6.6-rc1.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/4.19 stable/6.1

Fixed status
mainline: [38685e2a0476127db766f81b1c06019ddc4c9ffa]
stable/6.1: [3410b702354702b500bde10e3cc1f9db8731d908]
stable/6.6: [3073f6df783d9d75f7f69f73e16c7ef85d6cfb63]

CVE-2023-52832: wifi: mac80211: don't return unset power in
ieee80211_get_tx_power()

Announce: https://lore.kernel.org/linux-cve-announce/2024052108-CVE-2023-52=
832-b9d9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.

Fixed status
cip/4.4: [2dfaae8771b74a804f56c0e99fec19a0bd4b11d2]
cip/4.4-rt: [2dfaae8771b74a804f56c0e99fec19a0bd4b11d2]
cip/4.4-st: [2dfaae8771b74a804f56c0e99fec19a0bd4b11d2]
mainline: [e160ab85166e77347d0cbe5149045cb25e83937f]
stable/4.19: [298e767362cade639b7121ecb3cc5345b6529f62]
stable/5.10: [717de20abdcd1d4993fa450e28b8086a352620ea]
stable/5.15: [21a0f310a9f3bfd2b4cf4f382430e638607db846]
stable/5.4: [efeae5f4972f75d50002bc50eb112ab9e7069b18]
stable/6.1: [2be24c47ac19bf639c48c082486c08888bd603c6]
stable/6.6: [5a94cffe90e20e8fade0b9abd4370bd671fe87c7]

CVE-2023-52833: Bluetooth: btusb: Add date->evt_skb is NULL check

Announce: https://lore.kernel.org/linux-cve-announce/2024052109-CVE-2023-52=
833-eee3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
Introduced by commit a1c49c4 ("Bluetooth: btusb: Add protocol support
for MediaTek MT7668U USB devices") in 5.3-rc1.

Fixed status
mainline: [624820f7c8826dd010e8b1963303c145f99816e9]
stable/5.10: [9f8e4d1a4ca1179aaeb43f91f3e2a386e7e616b3]
stable/5.15: [f9de14bde56dcbb0765284c6dfc35842b021733c]
stable/6.1: [a556f2ef556a04790f67f2fa272f1a77336d15a0]
stable/6.6: [13b1ebad4c175e6a9b0748acbf133c21a15d282a]

CVE-2023-52834: atl1c: Work around the DMA RX overflow issue

Announce: https://lore.kernel.org/linux-cve-announce/2024052109-CVE-2023-52=
834-4c46@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
It seems as if 4.x and 5.x are affected too.

Fixed status
mainline: [86565682e9053e5deb128193ea9e88531bbae9cf]
stable/5.15: [c29a89b23f67ee592f4dee61f9d7efbf86d60315]
stable/6.1: [57e44ff9c2c9747b2b1a53556810b0e5192655d6]
stable/6.6: [32f08b7b430ee01ec47d730f961a3306c1c7b6fb]

CVE-2023-52835: perf/core: Bail out early if the request AUX area is
out of bound

Announce: https://lore.kernel.org/linux-cve-announce/2024052109-CVE-2023-52=
835-80ee@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
Introduced by commit 590b5b7 ("treewide: kzalloc_node() ->
kcalloc_node()") in 4.18-rc1.

Fixed status
mainline: [54aee5f15b83437f23b2b2469bcf21bdd9823916]
stable/4.19: [8c504f615d7ed60ae035c51d0c789137ced6797f]
stable/5.10: [1a2a4202c60fcdffbf04f259002ce9bff39edece]
stable/5.15: [fd0df3f8719201dbe61a4d39083d5aecd705399a]
stable/5.4: [788c0b3442ead737008934947730a6d1ff703734]
stable/6.1: [9ce4e87a8efd37c85766ec08b15e885cab08553a]
stable/6.6: [2e905e608e38cf7f8dcddcf8a6036e91a78444cb]

CVE-2023-52836: locking/ww_mutex/test: Fix potential workqueue corruption

Announce: https://lore.kernel.org/linux-cve-announce/2024052110-CVE-2023-52=
836-930a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.7-rc1.
Affected file(kernel/locking/test-ww_mutex.c) is introduced by commit
f2a5fec173 ("locking/ww_mutex: Begin kselftests for ww_mutex") in
4.11-rc1.
Linux 4.4 is not affected.

Fixed status
mainline: [bccdd808902f8c677317cec47c306e42b93b849e]
stable/4.19: [d8267cabbe1bed15ccf8b0e684c528bf8eeef715]
stable/5.10: [9ed2d68b3925145f5f51c46559484881d6082f75]
stable/5.15: [e89d0ed45a419c485bae999426ecf92697cbdda3]
stable/5.4: [dcd85e3c929368076a7592b27f541e0da8b427f5]
stable/6.1: [c56df79d68677cf062da1b6e3b33e74299a92dfc]
stable/6.6: [304a2c4aad0fff887ce493e4197bf9cbaf394479]

CVE-2023-52837: nbd: fix uaf in nbd_open

Announce: https://lore.kernel.org/linux-cve-announce/2024052110-CVE-2023-52=
837-6490@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4af5f2e ("nbd: use blk_mq_alloc_disk and
blk_cleanup_disk") in v5.14-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [327462725b0f759f093788dfbcb2f1fd132f956b]
stable/6.1: [4e9b3ec84dc97909876641dad14e0a2300d6c2a3]
stable/6.6: [56bd7901b5e9dbc9112036ea615ebcba1565fafe]

CVE-2023-52838: fbdev: imsttfb: fix a resource leak in probe

Announce: https://lore.kernel.org/linux-cve-announce/2024052110-CVE-2023-52=
838-be44@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c75f5a5 ("fbdev: imsttfb: Fix use after free bug
in imsttfb_probe") in v6.4-rc2.
Fixed in v6.7-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10
cip/5.10-rt cip/6.1 cip/6.1-rt stable/4.19 stable/5.10 stable/5.15
stable/5.4 stable/6.1

Fixed status
mainline: [aba6ab57a910ad4b940c2024d15f2cdbf5b7f76b]
stable/4.19: [382e1931e0c9cd58a5a8519cdc6cd9dc4d82b485]
stable/5.10: [a4dfebec32ec6d420a5506dd56a7834c91be28e4]
stable/5.15: [8e4b510fe91782522b7ca0ca881b663b5d35e513]
stable/5.4: [6c66d737b2726ac7784269ddf32a31634f8f269d]
stable/6.1: [7bc7b82fb2191b0d50a80ee4e27030918767dd1d]
stable/6.6: [b346a531159d08c564a312a9eaeea691704f3c00]

CVE-2023-52839: drivers: perf: Do not broadcast to other cpus when
starting a counter

Announce: https://lore.kernel.org/linux-cve-announce/2024052111-CVE-2023-52=
839-e3d4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3fec323 ("drivers: perf: Fix panic in riscv SBI
mmap support") in v6.6-rc6.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [61e3d993c8bd3e80f8f1363ed5e04f88ab531b72]
stable/6.6: [85be1a73fd298ed3fd060dfce97caef5f9928c57]

CVE-2023-52840: Input: synaptics-rmi4 - fix use after free in
rmi_unregister_function()

Announce: https://lore.kernel.org/linux-cve-announce/2024052111-CVE-2023-52=
840-8a3d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 24d28e4 ("Input: synaptics-rmi4 - convert irq
distribution to irq_domain") in v4.18-rc3.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb988e46da2e4eae89f5337e047ce372fe33d5b1]
stable/4.19: [2f236d8638f5b43e0c72919a6a27fe286c32053f]
stable/5.10: [6c71e065befb2fae8f1461559b940c04e1071bd5]
stable/5.15: [303766bb92c5c225cf40f9bbbe7e29749406e2f2]
stable/5.4: [50d12253666195a14c6cd2b81c376e2dbeedbdff]
stable/6.1: [7082b1fb5321037bc11ba1cf2d7ed23c6b2b521f]
stable/6.6: [c8e639f5743cf4b01f8c65e0df075fe4d782b585]

CVE-2023-52841: media: vidtv: mux: Add check and kfree for kstrdup

Announce: https://lore.kernel.org/linux-cve-announce/2024052111-CVE-2023-52=
841-1157@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c2f78f0 ("media: vidtv: psi: add a Network
Information Table (NIT)") in v5.10-rc6.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1fd6eb12642e0c32692924ff359c07de4b781d78]
stable/5.10: [64863ba8e6b7651d994c6e6d506cc8aa2ac45edb]
stable/5.15: [980be4c3b0d51c0f873fd750117774561c66cf68]
stable/6.1: [a254ee1ddc592ae1efcce96b8c014e1bd2d5a2b4]
stable/6.6: [aae7598aff291d4d140be1355aa20930af948785]

CVE-2023-52842: virtio/vsock: Fix uninit-value in virtio_transport_recv_pkt=
()

Announce: https://lore.kernel.org/linux-cve-announce/2024052111-CVE-2023-52=
842-711c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 71dc9ec ("virtio/vsock: replace virtio_vsock_pkt
with sk_buff") in v6.3-rc1.
Fixed in v6.6.2.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [0b8906fb48b99e993d6e8a12539f618f4854dd26]
stable/6.1: [cd12535b97dd7d18cf655ec78ce1cf1f29a576be]
stable/6.6: [cd12535b97dd7d18cf655ec78ce1cf1f29a576be]

CVE-2023-52843: llc: verify mac len before reading mac header

Announce: https://lore.kernel.org/linux-cve-announce/2024052112-CVE-2023-52=
843-6515@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f83f176 ("[LLC]: skb allocation size for
responses") in v2.6.25-rc9.
Fixed in v6.7-rc1.

Fixed status
cip/4.4: [586ba576f4cbaa6651a3505770f847d60eefef89]
cip/4.4-rt: [586ba576f4cbaa6651a3505770f847d60eefef89]
cip/4.4-st: [586ba576f4cbaa6651a3505770f847d60eefef89]
mainline: [7b3ba18703a63f6fd487183b9262b08e5632da1b]
stable/4.19: [9a3f9054a5227d7567cba1fb821df48ccecad10c]
stable/5.10: [3a2653828ffc6101aef80bf58d5b77484239f779]
stable/5.15: [352887b3edd007cf9b0abc30fe9d98622acd859b]
stable/5.4: [cbdcdf42d15dac74c7287679fb2a9d955f8feb1f]
stable/6.1: [f980e9a57dfb9530f1f4ee41a2420f2a256d7b29]
stable/6.6: [ff5cb6a4f0c6d7fbdc84858323fb4b7af32cfd79]

CVE-2023-52844: media: vidtv: psi: Add check for kstrdup

Announce: https://lore.kernel.org/linux-cve-announce/2024052112-CVE-2023-52=
844-e2e7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7a7899f ("media: vidtv: psi: Implement an Event
Information Table (EIT)") in v5.10-rc6.
Introduced by commit c2f78f0 ("media: vidtv: psi: add a Network
Information Table (NIT)") in v5.10-rc6.
Introduced by commit f90cf60 ("media: vidtv: add a bridge driver") in v5.10=
-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [76a2c5df6ca8bd8ada45e953b8c72b746f42918d]
stable/5.10: [3387490c89b10aeb4e71d78b65dbc9ba4b2385b9]
stable/5.15: [d17269fb9161995303985ab2fe6f16cfb72152f9]
stable/6.1: [5c26aae3723965c291c65dd2ecad6a3240d422b0]
stable/6.6: [a51335704a3f90eaf23a6864faefca34b382490a]

CVE-2023-52845: tipc: Change nla_policy for bearer-related names to
NLA_NUL_STRING

Announce: https://lore.kernel.org/linux-cve-announce/2024052112-CVE-2023-52=
845-0245@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7be57fc ("tipc: add link get/dump to new netlink
api") in v3.19-rc1.
Introduced by commit 0655f6a ("tipc: add bearer disable/enable to new
netlink api") in v3.19-rc1.
Fixed in v6.7-rc1.

Fixed status
cip/4.4: [b682679848b27756af092220845a1cc413672eae]
cip/4.4-rt: [b682679848b27756af092220845a1cc413672eae]
cip/4.4-st: [b682679848b27756af092220845a1cc413672eae]
mainline: [19b3f72a41a8751e26bffc093bb7e1cef29ad579]
stable/4.19: [2426425d686b43adbc4f2f4a367b494f06f159d6]
stable/5.10: [b33d130f07f1decd756b849ab03c23d11d4dd294]
stable/5.15: [3907b89cd17fcc23e9a80789c36856f00ece0ba8]
stable/5.4: [2199260c42e6fbc5af8adae3bf78e623407c91b0]
stable/6.1: [4c731e98fe4d678e87ba3e4d45d3cf0a5a193dc4]
stable/6.6: [560992f41c0cea44b7603bc9e6c73bffbf6b5709]

CVE-2023-52846: hsr: Prevent use after free in prp_create_tagged_frame()

Announce: https://lore.kernel.org/linux-cve-announce/2024052113-CVE-2023-52=
846-c0ec@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 451d812 ("net: prp: add packet handling support")
in v5.9-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [876f8ab52363f649bcc74072157dfd7adfbabc0d]
stable/5.10: [ddf4e04e946aaa6c458b8b6829617cc44af2bffd]
stable/5.15: [a1a485e45d24b1cd8fe834fd6f1b06e2903827da]
stable/6.1: [6086258bd5ea7b5c706ff62da42b8e271b2401db]
stable/6.6: [d103fb6726904e353b4773188ee3d3acb4078363]

CVE-2023-52847: media: bttv: fix use after free error due to btv->timeout t=
imer

Announce: https://lore.kernel.org/linux-cve-announce/2024052113-CVE-2023-52=
847-a551@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 162e637 ("media: pci: Convert timers to use
timer_setup()") in v4.15-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bd5b50b329e850d467e7bcc07b2b6bde3752fbda]
stable/4.19: [bbc3b8dd2cb7817e703f112d988e4f4728f0f2a9]
stable/5.10: [2f3d9198cdae1cb079ec8652f4defacd481eab2b]
stable/5.15: [51c94256a83fe4e17406c66ff3e1ad7d242d8574]
stable/5.4: [b35fdade92c5058a5e727e233fe263b828de2c9a]
stable/6.1: [20568d06f6069cb835e05eed432edf962645d226]
stable/6.6: [847599fffa528b2cdec4e21b6bf7586dad982132]

CVE-2023-52848: f2fs: fix to drop meta_inode's page cache in f2fs_put_super=
()

Announce: https://lore.kernel.org/linux-cve-announce/2024052113-CVE-2023-52=
848-a5fa@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2087258 ("f2fs: fix to drop all dirty meta/node
pages during umount()") in v6.5-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a4639380bbe66172df329f8b54aa7d2e943f0f64]
stable/6.6: [10b2a6c0dade67b5a2b2d17fb75c457ea1985fad]

CVE-2023-52849: cxl/mem: Fix shutdown order

Announce: https://lore.kernel.org/linux-cve-announce/2024052114-CVE-2023-52=
849-b63f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9cc238c ("cxl/pci: Introduce
cdevm_file_operations") in v5.15-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [88d3917f82ed4215a2154432c26de1480a61b209]
stable/5.15: [20bd0198bebdd706bd4614b3933ef70d7c19618f]
stable/6.1: [7c7371b41a14e86f53e7dbe5baa7b1d3e0ab324b]
stable/6.6: [0ca074f7d788627a4e0b047ca5fbdb5fc567220c]

CVE-2023-52850: media: hantro: Check whether reset op is defined before use

Announce: https://lore.kernel.org/linux-cve-announce/2024052114-CVE-2023-52=
850-d1a1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6971efb ("media: hantro: Allow i.MX8MQ G1 and G2
to run independently") in v5.18-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [88d4b23a629ebd34f682f770cb6c2116c851f7b8]
stable/6.1: [64f55cebb4339ae771e9e7f3f42bee2489e2fa00]
stable/6.6: [24c06295f28335ced3aad53dd4b0a0bae7b9b100]

CVE-2023-52851: IB/mlx5: Fix init stage error handling to avoid double
free of same QP and UAF

Announce: https://lore.kernel.org/linux-cve-announce/2024052114-CVE-2023-52=
851-b53c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 04876c1 ("RDMA/mlx5: Move init and cleanup of UMR
to umr.c") in v5.19-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ef422f063b74adcc4a4a9004b0a87bb55e0a836]
stable/6.1: [437f033e30c897bb3723eac9e9003cd9f88d00a3]
stable/6.6: [6387f269d84e6e149499408c4d1fc805017729b2]

CVE-2023-52852: f2fs: compress: fix to avoid use-after-free on dic

Announce: https://lore.kernel.org/linux-cve-announce/2024052114-CVE-2023-52=
852-e55a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6ce19af ("f2fs: compress: add compress_inode to
cache compressed blocks") in v5.14-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b0327c84e91a0f4f0abced8cb83ec86a7083f086]
stable/5.15: [8c4504cc0c64862740a6acb301e0cfa59580dbc5]
stable/6.1: [9375ea7f269093d7c884857ae1f47633a91f429c]
stable/6.6: [9d065aa52b6ee1b06f9c4eca881c9b4425a12ba2]

CVE-2023-52853: hid: cp2112: Fix duplicate workqueue initialization

Announce: https://lore.kernel.org/linux-cve-announce/2024052115-CVE-2023-52=
853-5fd3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 13de9cc ("HID: cp2112: add IRQ chip handling") in
v4.10-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3c2d2d144c082dd71596953193adf9891491f42]
stable/4.19: [df0daac2709473531d6a3472997cc65301ac06d6]
stable/5.10: [3d959406c8fff2334d83d0c352d54fd6f5b2e7cd]
stable/5.15: [012d0c66f9392a99232ac28217229f32dd3a70cf]
stable/5.4: [727203e6e7e7020e1246fc1628cbdb8d90177819]
stable/6.1: [bafb12b629b7c3ad59812dd1ac1b0618062e0e38]
stable/6.6: [eb1121fac7986b30915ba20c5a04cc01fdcf160c]

CVE-2023-52854: padata: Fix refcnt handling in padata_free_shell()

Announce: https://lore.kernel.org/linux-cve-announce/2024052115-CVE-2023-52=
854-7657@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 07928d9 ("padata: Remove broken queue flushing")
in v5.6-rc1.
Fixed in v6.7-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st stable/4.19 stable/5.4

Fixed status
mainline: [7ddc21e317b360c3444de3023bcc83b85fabae2f]
stable/5.10: [41aad9d6953984d134fc50f631f24ef476875d4d]
stable/5.15: [0dd34a7ad395dbcf6ae60e48e9786050e25b9bc5]
stable/6.1: [c7c26d0ef5d20f00dbb2ae3befcabbe0efa77275]
stable/6.6: [1734a79e951914f1db2c65e635012a35db1c674b]

CVE-2023-52855: usb: dwc2: fix possible NULL pointer dereference
caused by driver concurrency

Announce: https://lore.kernel.org/linux-cve-announce/2024052115-CVE-2023-52=
855-3a55@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 33ad261 ("usb: dwc2: host: spinlock urb_enqueue")
in v4.2-rc1.
Fixed in v6.7-rc1.

Fixed status
cip/4.4: [b0f2abe34758ee77cacf9ddcef096ed7993dadbd]
cip/4.4-rt: [b0f2abe34758ee77cacf9ddcef096ed7993dadbd]
cip/4.4-st: [b0f2abe34758ee77cacf9ddcef096ed7993dadbd]
mainline: [ef307bc6ef04e8c1ea843231db58e3afaafa9fa6]
stable/4.19: [fed492aa6493a91a77ebd51da6fb939c98d94a0d]
stable/5.10: [bdb3dd4096302d6b87441fdc528439f171b04be6]
stable/5.15: [fcaafb574fc88a52dce817f039f7ff2f9da38001]
stable/5.4: [64c47749fc7507ed732e155c958253968c1d275e]
stable/6.1: [6b21a22728852d020a6658d39cd7bb7e14b07790]
stable/6.6: [a7bee9598afb38004841a41dd8fe68c1faff4e90]

CVE-2023-52856: drm/bridge: lt8912b: Fix crash on bridge detach

Announce: https://lore.kernel.org/linux-cve-announce/2024052116-CVE-2023-52=
856-fe35@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 30e2ae9 ("drm/bridge: Introduce LT8912B DSI to
HDMI bridge") in v5.13-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [44283993144a03af9df31934d6c32bbd42d1a347]
stable/5.15: [42071feab712ba2a139b8928f7e0f8d3a6fc719e]
stable/6.1: [7bf0cb8f40280a85034990dfe42be8ca8f80f37a]
stable/6.6: [b65e3249f3ca96e3c736af889461d80d675feab6]

CVE-2023-52857: drm/mediatek: Fix coverity issue with unintentional
integer overflow

Announce: https://lore.kernel.org/linux-cve-announce/2024052116-CVE-2023-52=
857-e288@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1a64a7a ("drm/mediatek: Fix cursor plane no
update") in v5.14-rc6.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b0b0d811eac6b4c52cb9ad632fa6384cf48869e7]
stable/6.6: [96312a251d4dcee5d36e32edba3002bfde0ddd9c]

CVE-2023-52858: clk: mediatek: clk-mt7629: Add check for mtk_alloc_clk_data

Announce: https://lore.kernel.org/linux-cve-announce/2024052116-CVE-2023-52=
858-24db@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3b5e748 ("clk: mediatek: add clock support for
MT7629 SoC") in v5.0-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2befa515c1bb6cdd33c262b909d93d1973a219aa]
stable/5.10: [4f861b63945e076f9f003a5fad958174096df1ee]
stable/5.15: [e964d21dc034b650d719c4ea39564bec72b42f94]
stable/5.4: [e8ae4b49dd9cfde69d8de8c0c0cd7cf1b004482e]
stable/6.1: [a836efc21ef04608333d6d05753e558ebd1f85d0]
stable/6.6: [5fbea47eebff5daeca7d918c99289bcd3ae4dc8d]

CVE-2023-52859: perf: hisi: Fix use-after-free when register pmu fails

Announce: https://lore.kernel.org/linux-cve-announce/2024052117-CVE-2023-52=
859-ad0e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a0ab25c ("drivers/perf: hisi: Add support for
HiSilicon PA PMU driver") in v5.13-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b805cafc604bfdb671fae7347a57f51154afa735]
stable/5.15: [0e1e88bba286621b886218363de07b319d6208b2]
stable/6.1: [b660420f449d094b1fabfa504889810b3a63cdd5]
stable/6.6: [75bab28ffd05ec8879c197890b1bd1dfec8d3f63]

CVE-2023-52860: drivers/perf: hisi: use
cpuhp_state_remove_instance_nocalls() for hisi_hns3_pmu uninit process

Announce: https://lore.kernel.org/linux-cve-announce/2024052117-CVE-2023-52=
860-fc61@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 66637ab ("drivers/perf: hisi: add driver for HNS3
PMU") in v6.0-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [50b560783f7f71790bcf70e9e9855155fb0af8c1]
stable/6.1: [4589403a343bb0c72a6faf5898386ff964d4e01a]
stable/6.6: [d04ff5437a45f275db5530efb49b68d0ec851f6f]

CVE-2023-52861: drm: bridge: it66121: Fix invalid connector dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024052117-CVE-2023-52=
861-acb2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e0fd83d ("drm: bridge: it66121: Add audio
support") in v5.19-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d0375f6858c4ff7244b62b02eb5e93428e1916cd]
stable/6.1: [2c80c4f0d2845645f41cbb7c9304c8efbdbd4331]
stable/6.6: [1374561a7cbc9a000b77bb0473bb2c19daf18d86]

CVE-2023-52862: drm/amd/display: Fix null pointer dereference in error mess=
age

Announce: https://lore.kernel.org/linux-cve-announce/2024052117-CVE-2023-52=
862-b020@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9788d08 ("drm/amd/display: improve the message
printed when loading DC") in v6.5-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c3601a2fbfb265ce283651480e30c8e60459112]
stable/6.6: [8b72c5d4a5d25e76b16283397c40b8b3c0d70019]

CVE-2023-52863: hwmon: (axi-fan-control) Fix possible NULL pointer derefere=
nce

Announce: https://lore.kernel.org/linux-cve-announce/2024052118-CVE-2023-52=
863-490d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8412b41 ("hwmon: Support ADI Fan Control IP") in v5.7-=
rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2a5b3370a1d9750eca325292e291c8c7cb8cf2e0]
stable/5.10: [7d870088db4863c514a7f8751cd593751983029a]
stable/5.15: [b3e7eb23a6e97642ff3190431c06475d9ca1e062]
stable/6.1: [33de53a2706066d526173dc743faf43d92c62105]
stable/6.6: [c49f14cc1bb12c625a1c572e8a95b6adefd4d8eb]

CVE-2023-52864: platform/x86: wmi: Fix opening of char device

Announce: https://lore.kernel.org/linux-cve-announce/2024052118-CVE-2023-52=
864-15cd@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 44b6b76 ("platform/x86: wmi: create userspace
interface for drivers") in v4.15-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eba9ac7abab91c8f6d351460239108bef5e7a0b6]
stable/4.19: [cf098e937dd125c0317a0d6f261ac2a950a233d6]
stable/5.10: [d426a2955e45a95b2282764105fcfb110a540453]
stable/5.15: [e0bf076b734a2fab92d8fddc2b8b03462eee7097]
stable/5.4: [9fb0eed09e1470cd4021ff52b2b9dfcbcee4c203]
stable/6.1: [44a96796d25809502c75771d40ee693c2e44724e]
stable/6.6: [fb7b06b59c6887659c6ed0ecd3110835eecbb6a3]

CVE-2023-52865: clk: mediatek: clk-mt6797: Add check for mtk_alloc_clk_data

Announce: https://lore.kernel.org/linux-cve-announce/2024052118-CVE-2023-52=
865-6412@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 96596aa ("clk: mediatek: add clk support for
MT6797") in v4.12-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [606f6366a35a3329545e38129804d65ef26ed7d2]
stable/4.19: [4c79cbfb8e9e2311be77182893fda5ea4068c836]
stable/5.10: [81b16286110728674dcf81137be0687c5055e7bf]
stable/5.15: [3aefc6fcfbada57fac27f470602d5565e5b76cb4]
stable/5.4: [2705c5b97f504e831ae1935c05f0e44f80dfa6b3]
stable/6.1: [357df1c2f6ace96defd557fad709ed1f9f70e16c]
stable/6.6: [122ac6496e4975ddd7ec1edba4f6fc1e15e39478]

CVE-2023-52866: HID: uclogic: Fix user-memory-access bug in
uclogic_params_ugee_v2_init_event_hooks()

Announce: https://lore.kernel.org/linux-cve-announce/2024052119-CVE-2023-52=
866-c17d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a251d65 ("HID: uclogic: Handle wireless device
reconnection") in v6.3-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [91cfe0bbaa1c434d4271eb6e1d7aaa1fe8d121f6]
stable/6.6: [6c8f953728d75104d994893f58801c457274335a]

CVE-2023-52867: drm/radeon: possible buffer overflow

Announce: https://lore.kernel.org/linux-cve-announce/2024052119-CVE-2023-52=
867-3f26@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5cc4e5f ("drm/radeon: Cleanup HDMI audio
interrupt handling for evergreen") in v4.13-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd05484f99d16715a88eedfca363828ef9a4c2d4]
stable/4.19: [caaa74541459c4c9e2c10046cf66ad2890483d0f]
stable/5.10: [7b063c93bece827fde237fae1c101bceeee4e896]
stable/5.15: [347f025a02b3a5d715a0b471fc3b1439c338ad94]
stable/5.4: [ddc42881f170f1f518496f5a70447501335fc783]
stable/6.1: [341e79f8aec6af6b0061b8171d77b085835c6a58]
stable/6.6: [19534a7a225f1bf2da70a9a90d41d0215f8f6b45]

CVE-2023-52868: thermal: core: prevent potential string overflow

Announce: https://lore.kernel.org/linux-cve-announce/2024052119-CVE-2023-52=
868-c2c3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 203d3d4 ("the generic thermal sysfs driver") in
v2.6.25-rc1.
Fixed in v6.7-rc1.

Fixed status
cip/4.4: [e4da583b3328661651854d7e97600609f862e3de]
cip/4.4-rt: [e4da583b3328661651854d7e97600609f862e3de]
cip/4.4-st: [e4da583b3328661651854d7e97600609f862e3de]
mainline: [c99626092efca3061b387043d4a7399bf75fbdd5]
stable/4.19: [6ad1bf47fbe5750c4d5d8e41337665e193e2c521]
stable/5.10: [3f795fb35c2d8a637efe76b4518216c9319b998c]
stable/5.15: [3a8f4e58e1ee707b4f46a1000b40b86ea3dd509c]
stable/5.4: [3091ab943dfc7b2578599b0fe203350286fab5bb]
stable/6.1: [77ff34a56b695e228e6daf30ee30be747973d6e8]
stable/6.6: [edbd6bbe40ac524a8f2273ffacc53edf14f3c686]

CVE-2023-52869: pstore/platform: Add check for kstrdup

Announce: https://lore.kernel.org/linux-cve-announce/2024052120-CVE-2023-52=
869-6f57@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 563ca40 ("pstore/platform: Switch
pstore_info::name to const") in v5.8-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a19d48f7c5d57c0f0405a7d4334d1d38fe9d3c1c]
stable/5.10: [bb166bdae1a7d7db30e9be7e6ccaba606debc05f]
stable/5.15: [379b120e4f27fd1cf636a5f85570c4d240a3f688]
stable/6.1: [63f637309baadf81a095f2653e3b807d4b5814b9]
stable/6.6: [ad5cb6deb41417ef41b9d6ff54f789212108606f]

CVE-2023-52870: clk: mediatek: clk-mt6765: Add check for mtk_alloc_clk_data

Announce: https://lore.kernel.org/linux-cve-announce/2024052120-CVE-2023-52=
870-9af4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1aca993 ("clk: mediatek: Add MT6765 clock
support") in v5.8-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b82681042724924ae3ba0f2f2eeec217fa31e830]
stable/5.10: [2617aa8ceaf30e41d3eb7f5fef3445542bef193a]
stable/5.15: [533ca5153ad6c7b7d47ae0114b14d0333964b946]
stable/6.1: [dd1f30d68fa98eb672c0a259297b761656a9025f]
stable/6.6: [b5ff3e89b4e7f46ad2aa0de7e08d18e6f87d71bc]

CVE-2023-52871: soc: qcom: llcc: Handle a second device without data corrup=
tion

Announce: https://lore.kernel.org/linux-cve-announce/2024052120-CVE-2023-52=
871-eaa4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a3134fb ("drivers: soc: Add LLCC driver") in v4.19-rc1=
.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f1a1bc8775b26345aba2be278118999e7f661d3d]
stable/5.10: [5e5b85ea0f4bc484bfe4cc73ead51fa48d2366a0]
stable/5.15: [995ee1e84e8db7fa5dcdde7dfe0bd7bb6f9bbb8c]
stable/5.4: [cc1a1dcb411fe224f48553cfdcdfe6e61395b69c]
stable/6.1: [f0ef883cae309bc5e8cdfcdbc1b4822732ce20a8]
stable/6.6: [1143bfb9b055897975aeaea254da148e19524493]

CVE-2023-52872: tty: n_gsm: fix race condition in status line change
on dead connections

Announce: https://lore.kernel.org/linux-cve-announce/2024052120-CVE-2023-52=
872-48fd@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c568f70 ("tty: n_gsm: fix missing timer to handle
stalled links") in v6.0-rc1.
Fixed in v6.7-rc1.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [3a75b205de43365f80a33b98ec9289785da56243]
stable/5.15: [81a4dd5e6c78f5d8952fa8c9d36565db1fe01444]
stable/6.1: [df6cfab66ff2a44bd23ad5dd5309cb3421bb6593]
stable/6.6: [ce4df90333c4fe65acb8b5089fdfe9b955ce976a]

CVE-2023-52873: clk: mediatek: clk-mt6779: Add check for mtk_alloc_clk_data

Announce: https://lore.kernel.org/linux-cve-announce/2024052121-CVE-2023-52=
873-cbe9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 710774e ("clk: mediatek: Add MT6779 clock
support") in v5.4-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f57f78fbacf630430bf954e5a84caafdfea30c0]
stable/5.10: [3994387ba3564976731179c4d4a6d7850ddda71a]
stable/5.15: [ca6d565a2319d69d9766e6ecbb5af827fc4afb2b]
stable/5.4: [fbe466f06d4ea18745da0d57540539b7b36936ae]
stable/6.1: [df1c4a9efa3f5b6fb5e0ae63890230dbe2190b7e]
stable/6.6: [f6a7c51cf07a399ec067d39f0a22f1817c5c7d2b]

CVE-2023-52874: x86/tdx: Zero out the missing RSI in TDX_HYPERCALL macro

Announce: https://lore.kernel.org/linux-cve-announce/2024052121-CVE-2023-52=
874-2fda@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7a3a401 ("x86/tdx: Drop flags from
__tdx_hypercall()") in v6.4-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d092b66119d774853cc9308522620299048a662]
stable/6.6: [de4c5bacca4f50233f1f791bec9eeb4dee1b14cd]

CVE-2023-52875: clk: mediatek: clk-mt2701: Add check for mtk_alloc_clk_data

Announce: https://lore.kernel.org/linux-cve-announce/2024052121-CVE-2023-52=
875-99fe@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e986211 ("clk: mediatek: Add MT2701 clock
support") in v4.10-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0d6e24b422a2166a9297a8286ff2e6ab9a5e8cd3]
stable/4.19: [1953e62366da5460dc712e045f94fb0d8918999d]
stable/5.10: [001e5def774fa1a8f2b29567c0b0cd3e3a859a96]
stable/5.15: [d1175cf4bd2b4c5f7c43f677ea1ce9ad2c18d055]
stable/5.4: [d1461f0c9ca0827c03730fe9652ebbf6316a2a95]
stable/6.1: [2a18dd653284550900b02107c3c7b3ac5e0eb802]
stable/6.6: [1bf9c204aef4cc55ce46a7ff2d4dc7e5f86551a7]

CVE-2023-52876: clk: mediatek: clk-mt7629-eth: Add check for mtk_alloc_clk_=
data

Announce: https://lore.kernel.org/linux-cve-announce/2024052122-CVE-2023-52=
876-db2f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3b5e748 ("clk: mediatek: add clock support for
MT7629 SoC") in v5.0-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0884393c63cc9a1772f7121a6645ba7bd76feeb9]
stable/5.10: [96e9544a0c4faca616b3f9f4034dcd83a14e7f22]
stable/5.15: [c4070ada5d5155c8d4d17ea64bd246949889f25b]
stable/5.4: [cfa68e0ac5dcde43577adadf6f0f26f3b365ad68]
stable/6.1: [a540ca0aeae83c2f3964bcb4e383f64ce2ec1783]
stable/6.6: [1639072f6260babd017556e9f236ca2ad589d1e7]

CVE-2023-52877: usb: typec: tcpm: Fix NULL pointer dereference in tcpm_pd_s=
vdm()

Announce: https://lore.kernel.org/linux-cve-announce/2024052122-CVE-2023-52=
877-0826@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5e1d4c4 ("usb: typec: tcpm: Determine common SVDM
Version") in v5.12-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4987daf86c152ff882d51572d154ad12e4ff3a4b]
stable/5.15: [e5f53a68a596e04df3fde3099273435a30b6fdac]
stable/6.1: [e7a802447c491903aa7cb45967aa2a934a4e63fc]
stable/6.6: [b37a168c0137156042a0ca9626651b5a789e822b]

CVE-2023-52878: can: dev: can_put_echo_skb(): don't crash kernel if
can_priv::echo_skb is accessed out of bounds

Announce: https://lore.kernel.org/linux-cve-announce/2024052122-CVE-2023-52=
878-d433@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a6e4bc5 ("can: make the number of echo skb's
configurable") in v2.6.33-rc1.
Fixed in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6411959c10fe917288cbb1038886999148560057]
stable/5.15: [826120c9ba68f2d0dbae58e99013929c883d1444]
stable/6.1: [0d30931f1fa0fb893fb7d5dc32b6b7edfb775be4]
stable/6.6: [8ab67da060157362b2e0926692c659808784708f]

CVE-2023-52879: tracing: Have trace_event_file have ref counters

Announce: https://lore.kernel.org/linux-cve-announce/2024052122-CVE-2023-52=
879-fa4d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f5ca233 ("tracing: Increase trace array ref count
on enable and filter files") in v6.6-rc2.
Fixed in v6.7-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/5.4 stable/6.1

Fixed status
mainline: [bb32500fb9b78215e4ef6ee8b4345c5f5d7eafb4]
stable/5.10: [a98172e36e5f1b3d29ad71fade2d611cfcc2fe6f]
stable/5.15: [cbc7c29dff0fa18162f2a3889d82eeefd67305e0]
stable/5.4: [961c4511c7578d6b8f39118be919016ec3db1c1e]
stable/6.1: [2fa74d29fc1899c237d51bf9a6e132ea5c488976]
stable/6.6: [9034c87d61be8cff989017740a91701ac8195a1d]

* Updated CVEs

CVE-2024-26900: md: fix kmemleak of rdev->serial

stable 5.10, 5.15, 6.1, and 6.6 were fixed.

Fixed status
mainline: [6cf350658736681b9d6b0b6e58c5c76b235bb4c4]
stable/5.10: [fb5b347efd1bda989846ffc74679d181222fb123]
stable/5.15: [f3a1787dc48213f6caea5ba7d47e0222e7fa34a9]
stable/6.1: [beaf11969fd5cbe6f09cefaa34df1ce8578e8dd9]
stable/6.6: [9fd0198f7ef06ae0d6636fb0578560857dead995]
stable/6.8: [4c1021ce46fc2fb6115f7e79d353941e6dcad366]

CVE-2024-26923: af_unix: Fix garbage collector racing against connect()

stable 4.19 was fixed.

Fixed status
mainline: [47d8ac011fe1c9251070e1bd64cb10b48193ec51]
stable/4.19: [a36ae0ec2353015f0f6762e59f4c2dbc0c906423]
stable/5.10: [2e2a03787f4f0abc0072350654ab0ef3324d9db3]
stable/5.15: [e76c2678228f6aec74b305ae30c9374cc2f28a51]
stable/5.4: [343c5372d5e17b306db5f8f3c895539b06e3177f]
stable/6.1: [b75722be422c276b699200de90527d01c602ea7c]
stable/6.6: [507cc232ffe53a352847893f8177d276c3b532a9]
stable/6.8: [dbdf7bec5c920200077d693193f989cb1513f009]

CVE-2024-26936: ksmbd: validate request buffer size in smb2_allocate_rsp_bu=
f()

stable 5.15 was fixed.

Fixed status
mainline: [17cf0c2794bdb6f39671265aa18aea5c22ee8c4a]
stable/5.15: [8f3d0bf1d0c62b539d54c5b9108a845cff619b99]
stable/6.1: [21ff9d7d223c5c19cb4334009e4c0c83a2f4d674]
stable/6.6: [5c20b242d4fed73a93591e48bfd9772e2322fb11]
stable/6.8: [2c27a64a2bc47d9bfc7c3cf8be14be53b1ee7cb6]

CVE-2024-26980: ksmbd: fix slab-out-of-bounds in smb2_allocate_rsp_buf

stable 5.15 was fixed.

Fixed status
mainline: [c119f4ede3fa90a9463f50831761c28f989bfb20]
stable/5.15: [da21401372607c49972ea87a6edaafb36a17c325]
stable/6.1: [b80ba648714e6d790d69610cf14656be222d0248]
stable/6.6: [3160d9734453a40db248487f8204830879c207f1]
stable/6.8: [0977f89722eceba165700ea384f075143f012085]

CVE-2024-27398: Bluetooth: Fix use-after-free bugs caused by sco_sock_timeo=
ut

stable 4.19, 5.10, 5.15, 5.4, 6.1, 6.6, and 6.8 were fixed.

Fixed status
mainline: [483bc08181827fc475643272ffb69c533007e546]
stable/4.19: [1b33d55fb7355e27f8c82cd4ecd560f162469249]
stable/5.10: [33a6e92161a78c1073d90e27abe28d746feb0a53]
stable/5.15: [6a18eeb1b3bbc67c20d9609c31dca6a69b4bcde5]
stable/5.4: [3212afd00e3cda790fd0583cb3eaef8f9575a014]
stable/6.1: [bfab2c1f7940a232cd519e82fff137e308abfd93]
stable/6.6: [012363cb1bec5f33a7b94629ab2c1086f30280f2]
stable/6.8: [50c2037fc28df870ef29d9728c770c8955d32178]

CVE-2024-27399: Bluetooth: l2cap: fix null-ptr-deref in l2cap_chan_timeout

stable 4.19, 5.10, 5.15, 5.4, 6.1, 6.6, and 6.8 were fixed.

Fixed status
mainline: [adf0398cee86643b8eacde95f17d073d022f782c]
stable/4.19: [e137e2ba96e51902dc2878131823a96bf8e638ae]
stable/5.10: [06acb75e7ed600d0bbf7bff5628aa8f24a97978c]
stable/5.15: [e97e16433eb4533083b096a3824b93a5ca3aee79]
stable/5.4: [6466ee65e5b27161c846c73ef407f49dfa1bd1d9]
stable/6.1: [8960ff650aec70485b40771cd8e6e8c4cb467d33]
stable/6.6: [955b5b6c54d95b5e7444dfc81c95c8e013f27ac0]
stable/6.8: [eb86f955488c39526534211f2610e48a5cf8ead4]

CVE-2024-27400: drm/amdgpu: once more fix the call oder in amdgpu_ttm_move(=
) v2

stable 6.1, 6.6, and 6.8 were fixed.

Fixed status
mainline: [d3a9331a6591e9df64791e076f6591f440af51c3]
stable/6.1: [5c25b169f9a0b34ee410891a96bc9d7b9ed6f9be]
stable/6.6: [0c7ed3ed35eec9138b88d42217b5a6b9a62bda4d]
stable/6.8: [9a4f6e138720b6e9adf7b82a71d0292f3f276480]

CVE-2024-27401: firewire: nosy: ensure user_length is taken into
account when fetching packet contents

stable 4.19, 5.10, 5.15, 5.4, 6.1, 6.6, and 6.8 were fixed.

Fixed status
mainline: [38762a0763c10c24a4915feee722d7aa6e73eb98]
stable/4.19: [67f34f093c0f7bf33f5b4ae64d3d695a3b978285]
stable/5.10: [cca330c59c54207567a648357835f59df9a286bb]
stable/5.15: [79f988d3ffc1aa778fc5181bdfab312e57956c6b]
stable/5.4: [7b8c7bd2296e95b38a6ff346242356a2e7190239]
stable/6.1: [4ee0941da10e8fdcdb34756b877efd3282594c1f]
stable/6.6: [1fe60ee709436550f8cfbab01295936b868d5baa]
stable/6.8: [539d51ac48bcfcfa1b3d4a85f8df92fa22c1d41c]

Regards,
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com


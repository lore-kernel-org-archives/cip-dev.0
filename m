Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E631CC3ABDA
	for <webhook@archiver.kernel.org>; Wed, 14 May 2025 22:44:24 +0000 (UTC)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
 by mx.groups.io with SMTP id smtpd.web11.645.1747262658619578931
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 May 2025 15:44:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=wJ9zmSL5;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.169, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e7ab544d798so284902276.3
        for <cip-dev@lists.cip-project.org>; Wed, 14 May 2025 15:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1747262657; x=1747867457; darn=lists.cip-project.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aC5rFobBN+yTzpxIrEEa0pVePZEKoVBZYYfyoIi8/co=;
        b=wJ9zmSL5cQmiMht3MCIiCq8km9lqwvmlxMdgT3x5S4eeJW6KkYHeDAd99EQSH+cQDa
         amEgFXC78f/A/QU86HiB7eNVD+4XrH9jcgnHYiEC3ETo/U8SCTb7R/OcKU2xKfffA+tx
         qcWUjabJruEWUiQUX74fYN74x/0pJkIbozLQpv3qJXyGnvWmvv9cBEI26jbtDgr4ZX6r
         mGdpSSy0q+8AovdLojGiKbokOkIZx07Ae88nQEULri5eV0BnsDgtaR/vvoUDp+ZXTaX0
         +AV+VdgnQm4JLpklSEdrBtsIZ7cTMIMgXJdGlktpgND+c3L2XYZJiB41dYNWNwmYENe4
         Qdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747262657; x=1747867457;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aC5rFobBN+yTzpxIrEEa0pVePZEKoVBZYYfyoIi8/co=;
        b=Ar0HOZWpk/F16yXEMOVIm1oq2SunhPduQMiQ6fTCH69PtRlQKOLV2IYVkKxVYjQaZr
         xWkvPNHt02BdfgQhRpkFZTUwyrv0O76sc9Fqit+/Zc5hYeUjYl5w+SuKnpESPwl9BmVP
         pzjTRYY2EhbCIKIT5djOIFHBRV79fQsmeW/hJrJGFw8PF6FszwKiEoPNw8kVLkp7m6WL
         UoCdIyb6e16aXhZlzjkqlLtM2XYJtdLdJ5/8SDMvlXMFnSm/KWmIQrKWEtOvfFLrYDq9
         Y+L5dDLv0ogCfQC3i30yPf9LmvAQM+KJSEC072Ja/KB95hF2lpQsgR6XXyUp7boFrf1K
         nQWQ==
X-Gm-Message-State: AOJu0YxTCb62D5odD9DtRBSl2WC8tUbiKM9kyD/dQrx0VFUjCPn6qj0w
	6qfl612HPlT9kotLSnZjaBfWyUQ3SAmntIWjOr6BEEpXbAw4SYYF6CxoH/sm/rlj6ZIJ27jtQEE
	C/HJeb/AUDHj6yYVmq9wZRNH0s7o8I5w46jNsWGq52kmtNJwqYW4=
X-Gm-Gg: ASbGncvGGQXIeaBSEJIJ9EA1AiNSYgGtpugRWqq9TClKVZB0BrTz5yw89Whr7veUn/f
	7bHptvWtH6E1jsTJ47MMgdxzNZlzK/lhPPFTA7i+QepOxOeVZ3AS1LdwfkUJcjkOKLPHSAtFdsm
	rvrGaFfpa58MMN5jUJDXBgLWpxuttgFSOVqQ==
X-Google-Smtp-Source: AGHT+IH2zp1HUcNsUv0v9sKVISGYKoEHy2oHcJ8StY0TgnaOUXdk3wa3DJ7iPYUfVJ5hE1sVVl3x/fD5PoDp7IvyZQ0=
X-Received: by 2002:a05:6902:4891:b0:e74:2b67:51b3 with SMTP id
 3f1490d57ef6-e7b54333758mr236765276.29.1747262655651; Wed, 14 May 2025
 15:44:15 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 15 May 2025 07:43:39 +0900
X-Gm-Features: AX0GCFshj8kaH3El3yqTW0_o-ObTI9NmPPOHi0KEtwFORsBks531HTtAGEMf0aA
Message-ID: <CAODzB9pc6UEQY4pT+sb3PbRkCEXg1cuzjp6mSziNYuSK6=wk9g@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 May 2025 22:44:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18907

Hi!

It's this week's CVE report.

This week reported 90 new CVEs and 8 updated CVEs.

* New CVEs
CVE-2025-37800: driver core: fix potential NULL pointer dereference in
dev_uevent()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37800

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc4.


Fixed status
mainline: [18daa52418e7e4629ed1703b64777294209d2622]
stable/6.12: [2b344e779d9afd0fcb5ee4000e4d0fc7d8d867eb]
stable/6.12: [2b344e779d9afd0fcb5ee4000e4d0fc7d8d867eb]
stable/6.14: [3781e4b83e174364998855de777e184cf0b62c40]
stable/6.14: [3781e4b83e174364998855de777e184cf0b62c40]
stable/6.6: [abe56be73eb10a677d16066f65ff9d30251f5eee]
stable/6.6: [abe56be73eb10a677d16066f65ff9d30251f5eee]

CVE-2025-37801: spi: spi-imx: Add check for spi_imx_setupxfer()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37801

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc3.
Calling spi_imx_setupxfer was added by 307c897 ("spi: spi-imx: replace stru=
ct
spi_imx_data::bitbang by pointer to struct spi_controller") in 5.19-rc1.

Fixed status
mainline: [951a04ab3a2db4029debfa48d380ef834b93207e]
stable/6.1: [2fea0d6d7b5d27fbf55512d51851ba0a346ede52]
stable/6.1: [2fea0d6d7b5d27fbf55512d51851ba0a346ede52]
stable/6.12: [185d376875ea6fb4256b9dc97ee0b4d2b0fdd399]
stable/6.12: [185d376875ea6fb4256b9dc97ee0b4d2b0fdd399]
stable/6.14: [055ef73bb1afc3f783a9a13b496770a781964a07]
stable/6.14: [055ef73bb1afc3f783a9a13b496770a781964a07]
stable/6.6: [2b4479eb462ecb39001b38dfb331fc6028dedac8]
stable/6.6: [2b4479eb462ecb39001b38dfb331fc6028dedac8]

CVE-2025-37802: ksmbd: fix WARNING "do not call blocking ops when !TASK_RUN=
NING"

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37802

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc3.
Affected functions were added by d484d62 ("ksmbd: add durable scavenger tim=
er")
in 6.11-rc1.

Fixed status
mainline: [1df0d4c616138784e033ad337961b6e1a6bcd999]
stable/6.12: [8f805b3746d2f41702c77cba22f94f8415fadd1a]
stable/6.12: [8f805b3746d2f41702c77cba22f94f8415fadd1a]
stable/6.14: [cd161198e091e8a62b9bd631be970ea9a87d2d6a]
stable/6.14: [cd161198e091e8a62b9bd631be970ea9a87d2d6a]

CVE-2025-37803: udmabuf: fix a buf size overflow issue during udmabuf creat=
ion

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37803

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc2.
Affected line was added by dc4716d ("udmabuf: rework limits") in 4.20-rc1.

Fixed status
mainline: [021ba7f1babd029e714d13a6bf2571b08af96d0f]
stable/5.10: [13fe12c037b470321436deec393030c6153cfeb9]
stable/5.10: [13fe12c037b470321436deec393030c6153cfeb9]
stable/5.15: [373512760e13fdaa726faa9502d0f5be2abb3d33]
stable/5.15: [373512760e13fdaa726faa9502d0f5be2abb3d33]
stable/5.4: [e84a08fc7e25cdad5d9a3def42cc770ff711193f]
stable/5.4: [e84a08fc7e25cdad5d9a3def42cc770ff711193f]
stable/6.1: [3f6c9d66e0f8eb9679b57913aa64b4d2266f6fbe]
stable/6.1: [3f6c9d66e0f8eb9679b57913aa64b4d2266f6fbe]
stable/6.14: [2b8419c6ecf69007dcff54ea0b9f0b215282c55a]
stable/6.14: [2b8419c6ecf69007dcff54ea0b9f0b215282c55a]
stable/6.6: [b2ff4e9c599b000833d16a917f519aa2e4a75de2]
stable/6.6: [b2ff4e9c599b000833d16a917f519aa2e4a75de2]

CVE-2025-37804: io_uring: always do atomic put from iowq

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37804

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [390513642ee6763c7ada07f0a1470474986e6c1c]
stable/6.12: [3568fd9e440ea393c7d8bee253419ea11fd8e9d9]
stable/6.12: [3568fd9e440ea393c7d8bee253419ea11fd8e9d9]
stable/6.14: [6d2753b46452a557a12f7ef1ef4ee6641b4e89d8]
stable/6.14: [6d2753b46452a557a12f7ef1ef4ee6641b4e89d8]
stable/6.6: [c5d4d103005d8926cdad344f9fc947e651c9f2f7]
stable/6.6: [c5d4d103005d8926cdad344f9fc947e651c9f2f7]

CVE-2025-37805: sound/virtio: Fix cancel_sync warnings on
uninitialized work_structs

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37805

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
The virtsnd_pcm_parse_cfg was added by 29b96bf ("ALSA: virtio: build PCM de=
vices
and substream hardware descriptors") in 5.13-rc1.

Fixed status
mainline: [3c7df2e27346eb40a0e86230db1ccab195c97cfe]
stable/5.15: [e03b10c45c7675b6098190c6e7de1b656d8bcdbe]
stable/5.15: [e03b10c45c7675b6098190c6e7de1b656d8bcdbe]
stable/6.1: [54c7b864fbe4423a07b443a4ada0106052942116]
stable/6.1: [54c7b864fbe4423a07b443a4ada0106052942116]
stable/6.12: [66046b586c0aaa9332483bcdbd76e3305d6138e9]
stable/6.12: [66046b586c0aaa9332483bcdbd76e3305d6138e9]
stable/6.14: [9908498ce929a5a052b79bb7942f9ea317312ce4]
stable/6.14: [9908498ce929a5a052b79bb7942f9ea317312ce4]
stable/6.6: [5be9407b41eae20eef9140f5cfbfcbc3d01aaf45]
stable/6.6: [5be9407b41eae20eef9140f5cfbfcbc3d01aaf45]

CVE-2025-37806: fs/ntfs3: Keep write operations atomic

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37806

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
Affected file was added by 4342306 ("fs/ntfs3: Add file operations and
implementation")
in 5.15-rc1.

Fixed status
mainline: [285cec318bf5a7a6c8ba999b2b6ec96f9a20590f]
stable/6.12: [8db49e89a7f8b48ee59fa9ad32b6ed0879747df8]
stable/6.12: [8db49e89a7f8b48ee59fa9ad32b6ed0879747df8]
stable/6.14: [464139e18f619aa14fb921a61721862f43421c54]
stable/6.14: [464139e18f619aa14fb921a61721862f43421c54]

CVE-2025-37807: bpf: Fix kmemleak warning for percpu hashmap

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37807

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
Both functions htab_elem_set_ptr and htab_elem_get_ptr ware added by
6c90598 ("bpf:
pre-allocate hash map elements") in 4.6-rc1.

Fixed status
mainline: [11ba7ce076e5903e7bdc1fd1498979c331b3c286]
stable/6.12: [7758e308aeda1038aba1944f7302d34161b3effe]
stable/6.12: [7758e308aeda1038aba1944f7302d34161b3effe]
stable/6.14: [1f1c29aa1934177349c17e3c32e68ec38a7a56df]
stable/6.14: [1f1c29aa1934177349c17e3c32e68ec38a7a56df]

CVE-2025-37808: crypto: null - Use spin lock instead of mutex

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37808

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
Affected functions were added by 3302346 ("crypto: null - Add default
null skcipher")
in 4.2-rc5.

Fixed status
mainline: [dcc47a028c24e793ce6d6efebfef1a1e92f80297]
stable/5.10: [e307c54ac8198bf09652c72603ba6e6d97798410]
stable/5.10: [e307c54ac8198bf09652c72603ba6e6d97798410]
stable/5.15: [1dd4a8561d85dea545cf93f56efc48df8176e218]
stable/5.15: [1dd4a8561d85dea545cf93f56efc48df8176e218]
stable/5.4: [f7a5a5c8e1ec16a4b2041398abe95de0e14572ef]
stable/5.4: [f7a5a5c8e1ec16a4b2041398abe95de0e14572ef]
stable/6.1: [e27244cbe10658a66b8775be7f0acc4ad2f618d6]
stable/6.1: [e27244cbe10658a66b8775be7f0acc4ad2f618d6]
stable/6.12: [0486de3c1b8223138dcc614846bd76364f758de6]
stable/6.12: [0486de3c1b8223138dcc614846bd76364f758de6]
stable/6.14: [8cf2945512a8c0ef74ddd5b5a4f6b6a2fb1a4efb]
stable/6.14: [8cf2945512a8c0ef74ddd5b5a4f6b6a2fb1a4efb]
stable/6.6: [1b66a5920b7fc7cc6251192a3fcad115b6d75dd5]
stable/6.6: [1b66a5920b7fc7cc6251192a3fcad115b6d75dd5]

CVE-2025-37809: usb: typec: class: Fix NULL pointer access

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37809

Introduced by commit 59de2a5 ("usb: typec: Link enumerated USB devices
with Type-C partner") in v6.7-rc1.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec27386de23a511008c53aa2f3434ad180a3ca9a]
stable/6.12: [de7c24febd21413ea8f49f61b36338b676c02852]
stable/6.12: [de7c24febd21413ea8f49f61b36338b676c02852]
stable/6.14: [1fdde62411fe65640e69bc55ea027d5b7b2f0093]
stable/6.14: [1fdde62411fe65640e69bc55ea027d5b7b2f0093]

CVE-2025-37810: usb: dwc3: gadget: check that event count does not
exceed event buffer length

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37810

Introduced by commit 72246da ("usb: Introduce DesignWare USB3 DRD
Driver") in v3.2-rc1.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63ccd26cd1f6600421795f6ca3e625076be06c9f]
stable/5.10: [b43225948b231b3f331194010f84512bee4d9f59]
stable/5.10: [b43225948b231b3f331194010f84512bee4d9f59]
stable/5.15: [c0079630f268843a25ed75226169cba40e0d8880]
stable/5.15: [c0079630f268843a25ed75226169cba40e0d8880]
stable/5.4: [015c39f38e69a491d2abd5e98869a500a9459b3b]
stable/5.4: [015c39f38e69a491d2abd5e98869a500a9459b3b]
stable/6.1: [a44547015287a19001384fe94dbff84c92ce4ee1]
stable/6.1: [a44547015287a19001384fe94dbff84c92ce4ee1]
stable/6.12: [52a7c9d930b95aa8b1620edaba4818040c32631f]
stable/6.12: [52a7c9d930b95aa8b1620edaba4818040c32631f]
stable/6.14: [99d655119b870ee60e4dbf310aa9a1ed8d9ede3d]
stable/6.14: [99d655119b870ee60e4dbf310aa9a1ed8d9ede3d]
stable/6.6: [c4d80e41cb42008dceb35e5dbf52574d93beac0d]
stable/6.6: [c4d80e41cb42008dceb35e5dbf52574d93beac0d]

CVE-2025-37811: usb: chipidea: ci_hdrc_imx: fix usbmisc handling

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37811

Introduced by commit 74adad5 ("usb: chipidea: ci_hdrc_imx: decrement
device's refcount in .remove() and in the error path of .probe()") in
v6.13-rc7.
Fixed in v6.15-rc4.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [4e28f79e3dffa52d327b46d1a78dac16efb5810b]
stable/5.15: [8060b719676e8c0e5a2222c2977ba0458d9d9535]
stable/5.15: [8060b719676e8c0e5a2222c2977ba0458d9d9535]
stable/6.1: [0ee460498ced49196149197c9f6d29a10e5e0798]
stable/6.1: [0ee460498ced49196149197c9f6d29a10e5e0798]
stable/6.12: [887902ca73490f38c69fd6149ef361a041cf912f]
stable/6.12: [887902ca73490f38c69fd6149ef361a041cf912f]
stable/6.14: [2aa87bd825377f5073b76701780a902cd0fc725a]
stable/6.14: [2aa87bd825377f5073b76701780a902cd0fc725a]
stable/6.6: [121e9f80ea5478bca3a8f3f26593fd66f87da649]
stable/6.6: [121e9f80ea5478bca3a8f3f26593fd66f87da649]

CVE-2025-37812: usb: cdns3: Fix deadlock when using NCM gadget

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37812

Introduced by commit 7733f6c ("usb: cdns3: Add Cadence USB3 DRD
Driver") in v5.4-rc1.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a1059896f2bfdcebcdc7153c3be2307ea319501f]
stable/5.10: [59a760e4796a3cd88d8b9d7706e0a638de677751]
stable/5.10: [59a760e4796a3cd88d8b9d7706e0a638de677751]
stable/5.15: [b96239582531775f2fdcb14de29bdb6870fd4c8c]
stable/5.15: [b96239582531775f2fdcb14de29bdb6870fd4c8c]
stable/5.4: [eebfb64c624fc738b669100173344fb441c5e719]
stable/5.4: [eebfb64c624fc738b669100173344fb441c5e719]
stable/6.1: [c27db84ed44e50ff90d9e3a2a25fae2e0a0fa015]
stable/6.1: [c27db84ed44e50ff90d9e3a2a25fae2e0a0fa015]
stable/6.12: [74cd6e408a4c010e404832f0e4609d29bf1d0c41]
stable/6.12: [74cd6e408a4c010e404832f0e4609d29bf1d0c41]
stable/6.14: [09e90a9689a4aac7a2f726dc2aa472b0b37937b7]
stable/6.14: [09e90a9689a4aac7a2f726dc2aa472b0b37937b7]
stable/6.6: [48a62deb857f0694f611949015e70ad194d97159]
stable/6.6: [48a62deb857f0694f611949015e70ad194d97159]

CVE-2025-37813: usb: xhci: Fix invalid pointer dereference in Etron workaro=
und

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37813

Introduced by commit 5e1c67a ("xhci: Fix control transfer error on
Etron xHCI host") in v6.13-rc1.
Fixed in v6.15-rc4.

Bug introduced commit was backported to following branches.
stable/6.12 stable/6.6

Fixed status
mainline: [1ea050da5562af9b930d17cbbe9632d30f5df43a]
stable/6.12: [bce3055b08e303e28a8751f6073066f5c33a0744]
stable/6.12: [bce3055b08e303e28a8751f6073066f5c33a0744]
stable/6.14: [0624e29c595b05e7a0e6d1c368f0a05799928e30]
stable/6.14: [0624e29c595b05e7a0e6d1c368f0a05799928e30]
stable/6.6: [142273a49f2c315eabdbdf5a71c15e479b75ca91]
stable/6.6: [142273a49f2c315eabdbdf5a71c15e479b75ca91]

CVE-2025-37814: tty: Require CAP_SYS_ADMIN for all usages of
TIOCL_SELMOUSEREPORT

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37814

Introduced by commit 2f83e38 ("tty: Permit some TIOCL_SETSEL modes
without CAP_SYS_ADMIN") in v6.14-rc1.
Fixed in v6.15-rc4.

Bug introduced commit was backported to following branches.
stable/6.12

Fixed status
mainline: [ee6a44da3c87cf64d67dd02be8c0127a5bf56175]
stable/6.12: [6f021bc0083b96125fdbed6a60d7b4396c4d6dac]
stable/6.12: [6f021bc0083b96125fdbed6a60d7b4396c4d6dac]
stable/6.14: [9b50c9c97db953de756a39af83d4be4d7f618aa6]
stable/6.14: [9b50c9c97db953de756a39af83d4be4d7f618aa6]

CVE-2025-37815: misc: microchip: pci1xxxx: Fix Kernel panic during IRQ
handler registration

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37815

Introduced by commit 194f9f9 ("misc: microchip: pci1xxxx: Resolve
kernel panic during GPIO IRQ handling") in v6.13-rc7.
Fixed in v6.15-rc4.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [18eb77c75ed01439f96ae5c0f33461eb5134b907]
stable/6.1: [1263d5f581908602c618c6665e683c4436383a09]
stable/6.1: [1263d5f581908602c618c6665e683c4436383a09]
stable/6.12: [12cc2193f2b9548e8ea5fbce8201b44158222edf]
stable/6.12: [12cc2193f2b9548e8ea5fbce8201b44158222edf]
stable/6.14: [4e02059dc91068bc5017b8546f9ec3b930f6d6a6]
stable/6.14: [4e02059dc91068bc5017b8546f9ec3b930f6d6a6]
stable/6.6: [62957f58ab3aa7fa792dc6ff3575624062539a4d]
stable/6.6: [62957f58ab3aa7fa792dc6ff3575624062539a4d]

CVE-2025-37816: mei: vsc: Fix fortify-panic caused by invalid counted_by() =
use

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37816

Introduced by commit 566f5ca ("mei: Add transport driver for IVSC
device") in v6.8-rc1.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [00f1cc14da0f06d2897b8c528df7c7dcf1b8da50]
stable/6.12: [3e243378f27cc7d11682a3ad720228b0723affa5]
stable/6.12: [3e243378f27cc7d11682a3ad720228b0723affa5]
stable/6.14: [ac04663c67f244810b3492e9ecd9f7cdbefeca2d]
stable/6.14: [ac04663c67f244810b3492e9ecd9f7cdbefeca2d]

CVE-2025-37817: mcb: fix a double free bug in chameleon_parse_gdd()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37817

Introduced by commit 3764e82 ("drivers: Introduce MEN Chameleon Bus")
in v3.15-rc1.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7c7f1bfdb2249f854a736d9b79778c7e5a29a150]
stable/5.10: [4ffe8c9fb561e4427dd1a3056cd5b3685b74f78d]
stable/5.10: [4ffe8c9fb561e4427dd1a3056cd5b3685b74f78d]
stable/5.15: [59f993cd36b6e28a394ba3d977e8ffe5c9884e3b]
stable/5.15: [59f993cd36b6e28a394ba3d977e8ffe5c9884e3b]
stable/5.4: [d70184958b0ea8c0fd52e2b456654b503e769fc8]
stable/5.4: [d70184958b0ea8c0fd52e2b456654b503e769fc8]
stable/6.1: [c5b8a549ef1fcc6066b037a3962c79d60465ba0b]
stable/6.1: [c5b8a549ef1fcc6066b037a3962c79d60465ba0b]
stable/6.12: [df1a5d5c6134224f9298e5189230f9d29ae50cac]
stable/6.12: [df1a5d5c6134224f9298e5189230f9d29ae50cac]
stable/6.14: [bcc7d58ee5173e34306026bd01e1fbf75e169d37]
stable/6.14: [bcc7d58ee5173e34306026bd01e1fbf75e169d37]
stable/6.6: [96838eb1836fd372e42be5db84f0b333b65146a6]
stable/6.6: [96838eb1836fd372e42be5db84f0b333b65146a6]

CVE-2025-37818: LoongArch: Return NULL from huge_pte_offset() for invalid P=
MD

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37818

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc4.
Affected function was added by 09cfefb ("LoongArch: Add memory management")=
 in
5.19-rc1.

Fixed status
mainline: [bd51834d1cf65a2c801295d230c220aeebf87a73]
stable/6.1: [34256805720993e37adf6127371a1265aea8376a]
stable/6.1: [34256805720993e37adf6127371a1265aea8376a]
stable/6.12: [51424fd171cee6a33f01f7c66b8eb23ac42289d4]
stable/6.12: [51424fd171cee6a33f01f7c66b8eb23ac42289d4]
stable/6.14: [b49f085cd671addbda4802d6b9382513f7dd0f30]
stable/6.14: [b49f085cd671addbda4802d6b9382513f7dd0f30]
stable/6.6: [2ca9380b12711afe95b3589bd82b59623b3c96b3]
stable/6.6: [2ca9380b12711afe95b3589bd82b59623b3c96b3]

CVE-2025-37819: irqchip/gic-v2m: Prevent use after free of gicv2m_get_fwnod=
e()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37819

Introduced by commit 0644b3d ("irqchip/gic-v2m: acpi: Introducing
GICv2m ACPI support") in v4.5-rc1.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3318dc299b072a0511d6dfd8367f3304fb6d9827]
stable/5.15: [f95659affee301464f0d058d528d96b35b452da8]
stable/5.15: [f95659affee301464f0d058d528d96b35b452da8]
stable/6.1: [dc0d654eb4179b06d3206e4396d072108b9ba082]
stable/6.1: [dc0d654eb4179b06d3206e4396d072108b9ba082]
stable/6.12: [3939d6f29d34cdb60e3f68b76e39e00a964a1d51]
stable/6.12: [3939d6f29d34cdb60e3f68b76e39e00a964a1d51]
stable/6.14: [47bee0081b483b077c7560bc5358ad101f89c8ef]
stable/6.14: [47bee0081b483b077c7560bc5358ad101f89c8ef]
stable/6.6: [2f2803e4b5e4df2b08d378deaab78b1681ef9b30]
stable/6.6: [2f2803e4b5e4df2b08d378deaab78b1681ef9b30]

CVE-2025-37820: xen-netfront: handle NULL returned by
xdp_convert_buff_to_frame()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37820

Introduced by commit 6c5aa6f ("xen networking: add basic XDP support
for xen-netfront") in v5.9-rc1.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cc3628dcd851ddd8d418bf0c897024b4621ddc92]
stable/6.1: [5b83d30c63f9964acb1bc63eb8e670b9e0d2c240]
stable/6.1: [5b83d30c63f9964acb1bc63eb8e670b9e0d2c240]
stable/6.12: [d6a9c4e6f9b3ec3ad98468c950ad214af8a2efb9]
stable/6.12: [d6a9c4e6f9b3ec3ad98468c950ad214af8a2efb9]
stable/6.14: [eefccd889df3b49d92e7349d94c4aa7e1ba19f6c]
stable/6.14: [eefccd889df3b49d92e7349d94c4aa7e1ba19f6c]
stable/6.6: [cefd8a2e2de46209ce66e6d30c237eb59b6c5bfa]
stable/6.6: [cefd8a2e2de46209ce66e6d30c237eb59b6c5bfa]

CVE-2025-37821: sched/eevdf: Fix se->slice being set to U64_MAX and
resulting crash

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37821

Introduced by commit aef6987 ("sched/eevdf: Propagate min_slice up the
cgroup hierarchy") in v6.12-rc1.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bbce3de72be56e4b5f68924b7da9630cc89aa1a8]
stable/6.14: [50a665496881262519f115f1bfe5822f30580eb0]
stable/6.14: [50a665496881262519f115f1bfe5822f30580eb0]

CVE-2025-37822: riscv: uprobes: Add missing fence.i after building the
XOL buffer

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37822

Introduced by commit 7478408 ("riscv: Add uprobes supported") in v5.12-rc1.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d1d19a11cfbfd8bae1d89cc010b2cc397cd0c48]
stable/6.12: [bcf6d3158c5902d92b6d62335af4422b7bf7c4e2]
stable/6.12: [bcf6d3158c5902d92b6d62335af4422b7bf7c4e2]
stable/6.14: [1dbb95a36499374c51b47ee8ae258a8862c20978]
stable/6.14: [1dbb95a36499374c51b47ee8ae258a8862c20978]

CVE-2025-37823: net_sched: hfsc: Fix a potential UAF in hfsc_dequeue() too

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37823

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6ccbda44e2cc3d26fd22af54c650d6d5d801addf]
stable/5.10: [2f46d14919c39528c6e540ebc43f90055993eedc]
stable/5.10: [2f46d14919c39528c6e540ebc43f90055993eedc]
stable/5.15: [da7936518996d290e2fcfcaf6cd7e15bfd87804a]
stable/5.15: [da7936518996d290e2fcfcaf6cd7e15bfd87804a]
stable/5.4: [68f256305ceb426d545a0dc31f83c2ab1d211a1e]
stable/5.4: [68f256305ceb426d545a0dc31f83c2ab1d211a1e]
stable/6.1: [11bccb054c1462fb069219f8e98e97a5a730758e]
stable/6.1: [11bccb054c1462fb069219f8e98e97a5a730758e]
stable/6.12: [c6f035044104c6ff656f4565cd22938dc892528c]
stable/6.12: [c6f035044104c6ff656f4565cd22938dc892528c]
stable/6.14: [c6936266f8bf98a53f28ef9a820e6a501e946d09]
stable/6.14: [c6936266f8bf98a53f28ef9a820e6a501e946d09]
stable/6.6: [76c4c22c2437d3d3880efc0f62eca06ef078d290]
stable/6.6: [76c4c22c2437d3d3880efc0f62eca06ef078d290]

CVE-2025-37824: tipc: fix NULL pointer dereference in tipc_mon_reinit_self(=
)

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37824

Introduced by commit 46cb01e ("tipc: update mon's self addr when node
addr generated") in v5.5-rc1.
Fixed in v6.15-rc4.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st stable/5.4

Fixed status
mainline: [d63527e109e811ef11abb1c2985048fdb528b4cb]
stable/5.10: [e6613b6d41f4010c4d484cbc7bfca690d8d522a2]
stable/5.10: [e6613b6d41f4010c4d484cbc7bfca690d8d522a2]
stable/5.15: [5fd464fd24de93d0eca377554bf0ff2548f76f30]
stable/5.15: [5fd464fd24de93d0eca377554bf0ff2548f76f30]
stable/5.4: [a3df56010403b2cd26388096ebccf959d23c4dcc]
stable/5.4: [a3df56010403b2cd26388096ebccf959d23c4dcc]
stable/6.1: [e79e8e05aa46f90d21023f0ffe6f136ed6a20932]
stable/6.1: [e79e8e05aa46f90d21023f0ffe6f136ed6a20932]
stable/6.12: [0ceef62a328ce1288598c9242576292671f21e96]
stable/6.12: [0ceef62a328ce1288598c9242576292671f21e96]
stable/6.14: [4d5e1e2d3e9d70beff7beab44fd6ce91405a405e]
stable/6.14: [4d5e1e2d3e9d70beff7beab44fd6ce91405a405e]
stable/6.6: [dd6cb0a8575b00fbd503e96903184125176f4fa3]
stable/6.6: [dd6cb0a8575b00fbd503e96903184125176f4fa3]

CVE-2025-37825: nvmet: fix out-of-bounds access in nvmet_enable_port

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37825

Introduced by commit 200adac ("nvme: Add PCI transport type") in v6.14-rc1.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d7aa0c7b4e96cd460826d932e44710cdeb3378b]
stable/6.14: [83c00860a37b3fcba8026cb344101f1b8af547cf]
stable/6.14: [83c00860a37b3fcba8026cb344101f1b8af547cf]

CVE-2025-37826: scsi: ufs: core: Add NULL check in
ufshcd_mcq_compl_pending_transfer()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37826

Introduced by commit ab24864 ("scsi: ufs: core: Add error handling for
MCQ mode") in v6.5-rc1.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [08a966a917fe3d92150fa3cc15793ad5e57051eb]
stable/6.12: [eeab6618037be84e438e9d6ed5d9a53502faf81f]
stable/6.12: [eeab6618037be84e438e9d6ed5d9a53502faf81f]
stable/6.14: [700128d67d57bb1de4251e563ab85202def36c50]
stable/6.14: [700128d67d57bb1de4251e563ab85202def36c50]

CVE-2025-37827: btrfs: zoned: return EIO on RAID1 block group write
pointer mismatch

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37827

Introduced by commit b1934cd ("btrfs: zoned: handle broken write
pointer on zones") in v6.11-rc7.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b0c26f47992672661340dd6ea931240213016609]
stable/6.12: [9a447f748f6c7287dad68fa91913cd382fa0fcc8]
stable/6.12: [9a447f748f6c7287dad68fa91913cd382fa0fcc8]
stable/6.14: [f4717a02cc422cf4bb2dbb280b154a1ae65c5f84]
stable/6.14: [f4717a02cc422cf4bb2dbb280b154a1ae65c5f84]

CVE-2025-37828: scsi: ufs: mcq: Add NULL check in ufshcd_mcq_abort()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37828

Introduced by commit f1304d4 ("scsi: ufs: mcq: Added
ufshcd_mcq_abort()") in v6.5-rc1.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c324085062919d4e21c69e5e78456dcec0052fe]
stable/6.12: [7d002f591486f5ef4bc02eb02025a53f931f0eb5]
stable/6.12: [7d002f591486f5ef4bc02eb02025a53f931f0eb5]
stable/6.14: [47eec518aef3814f64a5da43df81bdd74d8c0041]
stable/6.14: [47eec518aef3814f64a5da43df81bdd74d8c0041]
stable/6.6: [d6979fabe812a168d5053e5a41d5a2e9b8afd7bf]
stable/6.6: [d6979fabe812a168d5053e5a41d5a2e9b8afd7bf]

CVE-2025-37829: cpufreq: scpi: Fix null-ptr-deref in scpi_cpufreq_get_rate(=
)

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37829

Introduced by commit 343a8d1 ("cpufreq: scpi: remove arm_big_little
dependency") in v4.16-rc1.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [73b24dc731731edf762f9454552cb3a5b7224949]
stable/5.10: [fdf035d9c5436536ffcfea0ac6adeb5dda3c3a23]
stable/5.10: [fdf035d9c5436536ffcfea0ac6adeb5dda3c3a23]
stable/5.15: [8fbaa76690f67a7cbad315f89d607b46e3e06ede]
stable/5.15: [8fbaa76690f67a7cbad315f89d607b46e3e06ede]
stable/5.4: [ad4796f2da495b2cbbd0fccccbcbf63f2aeee613]
stable/5.4: [ad4796f2da495b2cbbd0fccccbcbf63f2aeee613]
stable/6.1: [da8ee91e532486055ecf88478d38c2f3dc234182]
stable/6.1: [da8ee91e532486055ecf88478d38c2f3dc234182]
stable/6.12: [28fbd7b13b4d3074b16db913aedc9d8d37ab41e7]
stable/6.12: [28fbd7b13b4d3074b16db913aedc9d8d37ab41e7]
stable/6.14: [124bddf123311cd1f18bffd63a5d974468d59c67]
stable/6.14: [124bddf123311cd1f18bffd63a5d974468d59c67]
stable/6.6: [19e0eaa62e8831f2bc0285fef3bf8faaa7f3e09b]
stable/6.6: [19e0eaa62e8831f2bc0285fef3bf8faaa7f3e09b]

CVE-2025-37830: cpufreq: scmi: Fix null-ptr-deref in scmi_cpufreq_get_rate(=
)

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37830

Introduced by commit 99d6bdf ("cpufreq: add support for CPU DVFS based
on SCMI message protocol") in v4.17-rc1.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [484d3f15cc6cbaa52541d6259778e715b2c83c54]
stable/5.15: [4e3d1c1925d8e752992cd893d03d974e6807ac16]
stable/5.15: [4e3d1c1925d8e752992cd893d03d974e6807ac16]
stable/6.1: [f9c5423855e3687262d881aeee5cfb3bc8577bff]
stable/6.1: [f9c5423855e3687262d881aeee5cfb3bc8577bff]
stable/6.12: [7ccfadfb2562337b4f0462a86a9746a6eea89718]
stable/6.12: [7ccfadfb2562337b4f0462a86a9746a6eea89718]
stable/6.14: [cfaca93b8fe317b7faa9af732e0ba8c9081fa018]
stable/6.14: [cfaca93b8fe317b7faa9af732e0ba8c9081fa018]
stable/6.6: [ea834c90aa7cc80a1b456f7a91432734d5087d16]
stable/6.6: [ea834c90aa7cc80a1b456f7a91432734d5087d16]

CVE-2025-37831: cpufreq: apple-soc: Fix null-ptr-deref in
apple_soc_cpufreq_get_rate()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37831

Introduced by commit 6286bbb ("cpufreq: apple-soc: Add new driver to
control Apple SoC CPU P-states") in v6.2-rc1.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9992649f6786921873a9b89dafa5e04d8c5fef2b]
stable/6.12: [fbdba5f37413dbc09d82ad7235e5b7a2fb8e0f75]
stable/6.12: [fbdba5f37413dbc09d82ad7235e5b7a2fb8e0f75]
stable/6.14: [01e86ea22610d98ae6141e428019a6916e79f725]
stable/6.14: [01e86ea22610d98ae6141e428019a6916e79f725]
stable/6.6: [1053dcf8a504d4933bb3f73df22bc363298d194b]
stable/6.6: [1053dcf8a504d4933bb3f73df22bc363298d194b]

CVE-2025-37832: cpufreq: sun50i: prevent out-of-bounds access

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37832

Introduced by commit 6cc4bcc ("cpufreq: sun50i: Refactor speed bin
decoding") in v6.10-rc1.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [14c8a418159e541d70dbf8fc71225d1623beaf0f]
stable/6.12: [40bf7f560ca4c2468d518cebf14561bc864f58f8]
stable/6.12: [40bf7f560ca4c2468d518cebf14561bc864f58f8]
stable/6.14: [dba5a1f963cf781c0b60f4b7f07465a6c687c27e]
stable/6.14: [dba5a1f963cf781c0b60f4b7f07465a6c687c27e]

CVE-2025-37833: net/niu: Niu requires MSIX ENTRY_DATA fields touch
before entry reads

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37833

Introduced by commit 7d5ec3d ("PCI/MSI: Mask all unused MSI-X
entries") in v5.14-rc6.
Fixed in v6.15-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [fbb429ddff5c8e479edcc7dde5a542c9295944e6]
stable/6.12: [c187aaa9e79b4b6d86ac7ba941e579ad33df5538]
stable/6.12: [c187aaa9e79b4b6d86ac7ba941e579ad33df5538]
stable/6.14: [64903e4849a71cf7f7c7e5d45225ccefc1280929]
stable/6.14: [64903e4849a71cf7f7c7e5d45225ccefc1280929]

CVE-2025-37834: mm/vmscan: don't try to reclaim hwpoison folio

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37834

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [1b0449544c6482179ac84530b61fc192a6527bfd]
stable/6.12: [1c9798bf8145a92abf45aa9d38a6406d9eb8bdf0]
stable/6.12: [1c9798bf8145a92abf45aa9d38a6406d9eb8bdf0]
stable/6.14: [912e9f0300c3564b72a8808db406e313193a37ad]
stable/6.14: [912e9f0300c3564b72a8808db406e313193a37ad]

CVE-2023-53145: Bluetooth: btsdio: fix use after free bug in
btsdio_remove due to race condition

Announce: https://www.cve.org/CVERecord?id=3DCVE-2023-53145

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.3-rc7.


Fixed status
cip/4.19-st: [3efcbf25e5ab4d4ad1b7e6ba0869ff85540e3f6e]
cip/4.4-st: [390aef59c1852e003a8ae37c671d5b690f8e778f]
mainline: [73f7b171b7c09139eb3c6a5677c200dc1be5f318]
stable/4.19: [3efcbf25e5ab4d4ad1b7e6ba0869ff85540e3f6e]
stable/4.19: [3efcbf25e5ab4d4ad1b7e6ba0869ff85540e3f6e]
stable/5.10: [746b363bef41cc159c051c47f9e30800bc6b520d]
stable/5.10: [746b363bef41cc159c051c47f9e30800bc6b520d]
stable/5.15: [a5c2a467e9e789ae0891de55b766daac52e3b7b3]
stable/5.15: [a5c2a467e9e789ae0891de55b766daac52e3b7b3]
stable/5.4: [a6650d27ab2c12a8ee750f396edb5ac8b4558b2e]
stable/5.4: [a6650d27ab2c12a8ee750f396edb5ac8b4558b2e]
stable/6.1: [179c65828593aff1f444e15debd40a477cb23cf4]
stable/6.1: [179c65828593aff1f444e15debd40a477cb23cf4]

CVE-2025-37836: PCI: Fix reference leak in pci_register_host_bridge()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37836

Introduced by commit 37d6a0a ("PCI: Add pci_register_host_bridge()
interface") in v4.10-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [804443c1f27883926de94c849d91f5b7d7d696e9]
stable/5.10: [f4db1b2c9ae3d013733c302ee70cac943b7070c0]
stable/5.10: [f4db1b2c9ae3d013733c302ee70cac943b7070c0]
stable/5.15: [3297497ad2246eb9243849bfbbc57a0dea97d76e]
stable/5.15: [3297497ad2246eb9243849bfbbc57a0dea97d76e]
stable/6.1: [b783478e0c53ffb4f04f25fb4e21ef7f482b05df]
stable/6.1: [b783478e0c53ffb4f04f25fb4e21ef7f482b05df]
stable/6.12: [9707d0c932f41006a2701afc926b232b50e356b4]
stable/6.12: [9707d0c932f41006a2701afc926b232b50e356b4]
stable/6.14: [f9208aec86226524ec1cb68a09ac70e974ea6536]
stable/6.14: [f9208aec86226524ec1cb68a09ac70e974ea6536]
stable/6.6: [bd2a352a0d72575f1842d28c14c10089f0cfe1ae]
stable/6.6: [bd2a352a0d72575f1842d28c14c10089f0cfe1ae]

CVE-2025-37837: iommu/tegra241-cmdqv: Fix warnings due to dmam_free_coheren=
t()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37837

Introduced by commit 483e0bd ("iommu/tegra241-cmdqv: Do not allocate
vcmdq until dma_set_mask_and_coherent") in v6.12-rc1.
Fixed in v6.15-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [767e22001dfce64cc03b7def1562338591ab6031]
stable/6.12: [e5dd974d6e00704553308ef1a88659f8dcfb39d4]
stable/6.12: [e5dd974d6e00704553308ef1a88659f8dcfb39d4]
stable/6.14: [e38ed6908080047d8fa1763d1da86b584f9eb55b]
stable/6.14: [e38ed6908080047d8fa1763d1da86b584f9eb55b]

CVE-2025-37839: jbd2: remove wrong sb->s_sequence check

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37839

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [e6eff39dd0fe4190c6146069cc16d160e71d1148]
stable/5.10: [b479839525fe7906966cdc4b5b2afbca048558a1]
stable/5.10: [b479839525fe7906966cdc4b5b2afbca048558a1]
stable/5.15: [ad926f735b4d4f10768fec7d080cadeb6d075cac]
stable/5.15: [ad926f735b4d4f10768fec7d080cadeb6d075cac]
stable/5.4: [cf30432f5b3064ff85d85639c2f0106f89c566f6]
stable/5.4: [cf30432f5b3064ff85d85639c2f0106f89c566f6]
stable/6.1: [3b4643ffaf72d7a5a357e9bf68b1775f8cfe7e77]
stable/6.1: [3b4643ffaf72d7a5a357e9bf68b1775f8cfe7e77]
stable/6.12: [9eaec071f111cd2124ce9a5b93536d3f6837d457]
stable/6.12: [9eaec071f111cd2124ce9a5b93536d3f6837d457]
stable/6.14: [b0cca357f85beb6144ab60c62dcc98508cc044bf]
stable/6.14: [b0cca357f85beb6144ab60c62dcc98508cc044bf]
stable/6.6: [c88f7328bb0fff66520fc9164f02b1d06e083c1b]
stable/6.6: [c88f7328bb0fff66520fc9164f02b1d06e083c1b]

CVE-2025-37840: mtd: rawnand: brcmnand: fix PM resume warning

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37840

Introduced by commit 97d90da ("mtd: nand: provide several helpers to
do common NAND operations") in v4.16-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ddc210cf8b8a8be68051ad958bf3e2cef6b681c2]
stable/5.10: [8775581e1c48e1bdd04a893d6f6bbe5128ad0ea7]
stable/5.10: [8775581e1c48e1bdd04a893d6f6bbe5128ad0ea7]
stable/5.15: [fbcb584efa5cd912ff8a151d67b8fe22f4162a85]
stable/5.15: [fbcb584efa5cd912ff8a151d67b8fe22f4162a85]
stable/5.4: [6f567c6a5250e3531cfd9c7ff254ecc2650464fa]
stable/5.4: [6f567c6a5250e3531cfd9c7ff254ecc2650464fa]
stable/6.1: [9dd161f707ecb7db38e5f529e979a5b6eb565b2d]
stable/6.1: [9dd161f707ecb7db38e5f529e979a5b6eb565b2d]
stable/6.12: [7266066b9469f04ed1d4c0fdddaea1425835eb55]
stable/6.12: [7266066b9469f04ed1d4c0fdddaea1425835eb55]
stable/6.14: [659b1f29f3e2fd5d751fdf35c5526d1f1c9b3dd2]
stable/6.14: [659b1f29f3e2fd5d751fdf35c5526d1f1c9b3dd2]
stable/6.6: [9bd51723ab51580e077c91d494c37e80703b8524]
stable/6.6: [9bd51723ab51580e077c91d494c37e80703b8524]

CVE-2025-37841: pm: cpupower: bench: Prevent NULL dereference on malloc fai=
lure

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37841

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
Introduced by commit 7fe2f63 ("cpupowerutils - cpufrequtils extended with q=
uite
some features") in 3.1-rc1.

Fixed status
mainline: [208baa3ec9043a664d9acfb8174b332e6b17fb69]
stable/5.10: [79bded9d70142d2a11d931fc029afece471641db]
stable/5.10: [79bded9d70142d2a11d931fc029afece471641db]
stable/5.15: [0e297a02e03dceb2874789ca40bd4e65c5371704]
stable/5.15: [0e297a02e03dceb2874789ca40bd4e65c5371704]
stable/5.4: [34a9394794b0f97af6afedc0c9ee2012c24b28ed]
stable/5.4: [34a9394794b0f97af6afedc0c9ee2012c24b28ed]
stable/6.1: [87b9f0867c0afa7e892f4b30c36cff6bf2707f85]
stable/6.1: [87b9f0867c0afa7e892f4b30c36cff6bf2707f85]
stable/6.12: [f8d28fa305b78c5d1073b63f26db265ba8291ae1]
stable/6.12: [f8d28fa305b78c5d1073b63f26db265ba8291ae1]
stable/6.14: [5e38122aa3fd0f9788186e86a677925bfec0b2d1]
stable/6.14: [5e38122aa3fd0f9788186e86a677925bfec0b2d1]
stable/6.6: [942a4b97fc77516678b1d8af1521ff9a94c13b3e]
stable/6.6: [942a4b97fc77516678b1d8af1521ff9a94c13b3e]

CVE-2025-37842: spi: fsl-qspi: use devm function instead of driver remove

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37842

Introduced by commit 8fcb830 ("spi: spi-fsl-qspi: use
devm_spi_register_controller") in v5.2-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [40369bfe717e96e26650eeecfa5a6363563df6e4]
stable/6.14: [f9bfb3a5f6f616f3eb7665c8ff3bcb9760ae33c8]
stable/6.14: [f9bfb3a5f6f616f3eb7665c8ff3bcb9760ae33c8]

CVE-2025-37843: PCI: pciehp: Avoid unnecessary device replacement check

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37843

Introduced by commit 9d573d1 ("PCI: pciehp: Detect device replacement
during system sleep") in v6.11-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3260237aaadc9799107ccb940c6688195c4518d]
stable/6.12: [e4a1d7defbc2d806540720a5adebe24ec3488683]
stable/6.12: [e4a1d7defbc2d806540720a5adebe24ec3488683]
stable/6.14: [7535d10a2c61baeff493300070cf04d9ddda216b]
stable/6.14: [7535d10a2c61baeff493300070cf04d9ddda216b]

CVE-2025-37844: cifs: avoid NULL pointer dereference in dbg call

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37844

Introduced by commit e79b033 ("cifs: ignore cached share root handle
closing errors") in v5.7-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b4885bd5935bb26f0a414ad55679a372e53f9b9b]
stable/5.10: [ba3ce6c60cd5db258687dfeba9fc608f5e7cadf3]
stable/5.10: [ba3ce6c60cd5db258687dfeba9fc608f5e7cadf3]
stable/5.15: [9c9000cb91b986eb7f75835340c67857ab97c09b]
stable/5.15: [9c9000cb91b986eb7f75835340c67857ab97c09b]
stable/6.1: [b2a1833e1c63e2585867ebeaf4dd41494dcede4b]
stable/6.1: [b2a1833e1c63e2585867ebeaf4dd41494dcede4b]
stable/6.12: [e0717385f5c51e290c2cd2ad4699a778316b5132]
stable/6.12: [e0717385f5c51e290c2cd2ad4699a778316b5132]
stable/6.14: [6c14ee6af8f1f188b668afd6d003f7516a507b08]
stable/6.14: [6c14ee6af8f1f188b668afd6d003f7516a507b08]
stable/6.6: [864ba5c651b03830f36f0906c21af05b15c1aaa6]
stable/6.6: [864ba5c651b03830f36f0906c21af05b15c1aaa6]

CVE-2025-37845: tracing: fprobe events: Fix possible UAF on modules

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37845

Introduced by commit ac91052 ("tracing: tprobe-events: Fix leakage of
module refcount") in v6.14.
Fixed in v6.15-rc2.

Bug introduced commit was backported to following branches.
stable/6.12

Fixed status
mainline: [dd941507a9486252d6fcf11814387666792020f3]
stable/6.12: [868df4eb784c3ccc7e4340a9ea993cbbedca167e]
stable/6.12: [868df4eb784c3ccc7e4340a9ea993cbbedca167e]
stable/6.14: [626f01f4d26e8cf92e69c1df53036153c8e98a20]
stable/6.14: [626f01f4d26e8cf92e69c1df53036153c8e98a20]

CVE-2025-37846: arm64: mops: Do not dereference src reg for a set operation

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37846

Introduced by commit 2de451a ("KVM: arm64: Add handler for MOPS
exceptions") in v6.7-rc1.
Fixed in v6.15-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a13bfa4fe0d6949cea14718df2d1fe84c38cd113]
stable/6.12: [eec737e17e5567e08148550a7f1d94d495b9fb17]
stable/6.12: [eec737e17e5567e08148550a7f1d94d495b9fb17]
stable/6.14: [5f6022a74147675124b781fdc056b291850e7786]
stable/6.14: [5f6022a74147675124b781fdc056b291850e7786]

CVE-2025-37847: accel/ivpu: Fix deadlock in ivpu_ms_cleanup()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37847

Introduced by commit cdfad4d ("accel/ivpu: Add NPU profiling support")
in v6.11-rc1.
Fixed in v6.15-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9a6f56762d23a1f3af15e67901493c927caaf882]
stable/6.12: [7d12a7d43c7bab9097ba466581d8db702e7908dc]
stable/6.12: [7d12a7d43c7bab9097ba466581d8db702e7908dc]
stable/6.14: [019634f27a16796eab749e8107dae32099945f29]
stable/6.14: [019634f27a16796eab749e8107dae32099945f29]

CVE-2025-37848: accel/ivpu: Fix PM related deadlocks in MS IOCTLs

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37848

Introduced by commit cdfad4d ("accel/ivpu: Add NPU profiling support")
in v6.11-rc1.
Fixed in v6.15-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d893da85e06edf54737bb80648bb58ba8fd56d9f]
stable/6.12: [afada73000bef7c79a22f0d7e93fac414eeff19e]
stable/6.12: [afada73000bef7c79a22f0d7e93fac414eeff19e]
stable/6.14: [84547128526441b45c3c241419dececf20c30104]
stable/6.14: [84547128526441b45c3c241419dececf20c30104]

CVE-2025-37849: KVM: arm64: Tear down vGIC on failed vCPU creation

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37849

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
It seems as if it was introduced by commit 39a93a8 ("KVM: ARM: Move all vcp=
u
init code into kvm_arch_vcpu_create()") in 5.6-rc1.

Fixed status
mainline: [250f25367b58d8c65a1b060a2dda037eea09a672]
stable/6.1: [07476e0d932afc53c05468076393ac35d0b4999e]
stable/6.1: [07476e0d932afc53c05468076393ac35d0b4999e]
stable/6.12: [c322789613407647a05ff5c451a7bf545fb34e73]
stable/6.12: [c322789613407647a05ff5c451a7bf545fb34e73]
stable/6.14: [f1e9087abaeedec9bf2894a282ee4f0d8383f299]
stable/6.14: [f1e9087abaeedec9bf2894a282ee4f0d8383f299]
stable/6.6: [5085e02362b9948f82fceca979b8f8e12acb1cc5]
stable/6.6: [5085e02362b9948f82fceca979b8f8e12acb1cc5]

CVE-2025-37850: pwm: mediatek: Prevent divide-by-zero in pwm_mediatek_confi=
g()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37850

Introduced by commit caf065f ("pwm: Add MediaTek PWM support") in v4.12-rc1=
.
Fixed in v6.15-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ca59947b5fcf94e7ea4029d1bd0f7c41500a161]
stable/5.10: [e1206d8e1651c9f62e5640b69b14d925b1a0a00a]
stable/5.10: [e1206d8e1651c9f62e5640b69b14d925b1a0a00a]
stable/5.15: [e3cf0c38d3ce754ad63005102fcfeb0b7ff3290b]
stable/5.15: [e3cf0c38d3ce754ad63005102fcfeb0b7ff3290b]
stable/5.4: [8b9f60725d74b72c238e4437c957d0217746b506]
stable/5.4: [8b9f60725d74b72c238e4437c957d0217746b506]
stable/6.1: [f3e9cf266c2c103cf071e15d7a17e2c699fff3c5]
stable/6.1: [f3e9cf266c2c103cf071e15d7a17e2c699fff3c5]
stable/6.12: [4cb15042b5f3ec0474e91cf379120cc597625dbb]
stable/6.12: [4cb15042b5f3ec0474e91cf379120cc597625dbb]
stable/6.14: [77fb96dbe350e8a5ae4965ff9f6e7049f3966a6b]
stable/6.14: [77fb96dbe350e8a5ae4965ff9f6e7049f3966a6b]
stable/6.6: [8ddbec73ea2598d8414e8f7103241b55cf877010]
stable/6.6: [8ddbec73ea2598d8414e8f7103241b55cf877010]

CVE-2025-37851: fbdev: omapfb: Add 'plane' value check

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37851

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
Introduced by commit f76ee89 ("omapfb: copy omapdss & displays for omapfb")
in 4.5-rc1.

Fixed status
mainline: [3e411827f31db7f938a30a3c7a7599839401ec30]
stable/5.10: [cdf41d72e8b015d9ea68f5a1c0a79624e7c312aa]
stable/5.10: [cdf41d72e8b015d9ea68f5a1c0a79624e7c312aa]
stable/5.15: [09dbf22fd68c2f1a81ab89670ffa1ec3033436c4]
stable/5.15: [09dbf22fd68c2f1a81ab89670ffa1ec3033436c4]
stable/5.4: [a570efb4d877adbf3db2dc95487f2ba6bfdd148a]
stable/5.4: [a570efb4d877adbf3db2dc95487f2ba6bfdd148a]
stable/6.1: [660a53a0694d1f3789802509fe729dd4656fc5e0]
stable/6.1: [660a53a0694d1f3789802509fe729dd4656fc5e0]
stable/6.12: [52eafaa56f8f6d6a0cdff9282b25b4acbde34edc]
stable/6.12: [52eafaa56f8f6d6a0cdff9282b25b4acbde34edc]
stable/6.14: [4efd8ef5e40f2c7a4a91a5a9f03140bfa827da89]
stable/6.14: [4efd8ef5e40f2c7a4a91a5a9f03140bfa827da89]
stable/6.6: [fda15c5b96b883d62fb2d84a3a1422aa87717897]
stable/6.6: [fda15c5b96b883d62fb2d84a3a1422aa87717897]

CVE-2025-37852: drm/amdgpu: handle amdgpu_cgs_create_device() errors
in amd_powerplay_create()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37852

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
It looks as if it was introduced by commit b905090 ("drm/amdgpu: Remove wra=
pper
layer of smu ip functions") in 4.17-rc1.

Fixed status
mainline: [1435e895d4fc967d64e9f5bf81e992ac32f5ac76]
stable/6.1: [55ef52c30c3e747f145a64de96192e37a8fed670]
stable/6.1: [55ef52c30c3e747f145a64de96192e37a8fed670]
stable/6.12: [dc4380f34613eaae997b3ed263bd1cb3d0fd0075]
stable/6.12: [dc4380f34613eaae997b3ed263bd1cb3d0fd0075]
stable/6.14: [b784734811438f11533e2fb9e0deb327844bdb56]
stable/6.14: [b784734811438f11533e2fb9e0deb327844bdb56]
stable/6.6: [f8693e1bae9c08233a2f535c3f412e157df32b33]
stable/6.6: [f8693e1bae9c08233a2f535c3f412e157df32b33]

CVE-2025-37853: drm/amdkfd: debugfs hang_hws skip GPU with MES

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37853

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
The kfd_debugfs_hang_hws was added by commit a29ec47 ("drm/amdkfd: Add debu=
gfs
interface to trigger HWS hang") in 4.19-rc1.

Fixed status
mainline: [fe9d0061c413f8fb8c529b18b592b04170850ded]
stable/6.12: [1a322b330dc0b775d1d7a84e55c752d9451bfe7d]
stable/6.12: [1a322b330dc0b775d1d7a84e55c752d9451bfe7d]
stable/6.14: [24b9e0e2e6147314c22d821f0542c4dd9a320c40]
stable/6.14: [24b9e0e2e6147314c22d821f0542c4dd9a320c40]
stable/6.6: [a36f8d544522a19ef06ed9e84667d154dcb6be52]
stable/6.6: [a36f8d544522a19ef06ed9e84667d154dcb6be52]

CVE-2025-37854: drm/amdkfd: Fix mode1 reset crash issue

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37854

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [f0b4440cdc1807bb6ec3dce0d6de81170803569b]
stable/6.1: [57c9dabda80ac167de8cd71231baae37cc2f442d]
stable/6.1: [57c9dabda80ac167de8cd71231baae37cc2f442d]
stable/6.12: [ffd37d7d44d7e0b6e769d4fe6590e327f8cc3951]
stable/6.12: [ffd37d7d44d7e0b6e769d4fe6590e327f8cc3951]
stable/6.14: [9c4bcdf4068aae3e17e31c144300be405cfa03ff]
stable/6.14: [9c4bcdf4068aae3e17e31c144300be405cfa03ff]
stable/6.6: [89af6b39f028c130d4362f57042927f005423e6a]
stable/6.6: [89af6b39f028c130d4362f57042927f005423e6a]

CVE-2025-37855: drm/amd/display: Guard Possible Null Pointer Dereference

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37855

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
Affected for loop was added by 59fb2d0 ("drm/amd/display: Log Hard Min Cloc=
ks
and Phantom Pipe Status") in 6.14-rc1.

Fixed status
mainline: [c87d202692de34ee71d1fd4679a549a29095658a]
stable/6.14: [dc2de1ac7145f882f3c03d2d6f84583ae7e35d41]
stable/6.14: [dc2de1ac7145f882f3c03d2d6f84583ae7e35d41]

CVE-2025-37856: btrfs: harden block_group::bg_list against list_del() races

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37856

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [7511e29cf1355b2c47d0effb39e463119913e2f6]
stable/6.12: [bf089c4d1141b27332c092b1dcca5022c415a3b6]
stable/6.12: [bf089c4d1141b27332c092b1dcca5022c415a3b6]
stable/6.14: [185fd73e5ac06027c4be9a129e59193f6a3ef202]
stable/6.14: [185fd73e5ac06027c4be9a129e59193f6a3ef202]

CVE-2025-37857: scsi: st: Fix array overflow in st_setup()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37857

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
It looks as if 4.4 and 4.19 are affected.

Fixed status
mainline: [a018d1cf990d0c339fe0e29b762ea5dc10567d67]
stable/5.10: [574b399a7fb6ae71c97e26d122205c4a720c0e43]
stable/5.10: [574b399a7fb6ae71c97e26d122205c4a720c0e43]
stable/5.15: [c6015d0f7a2236ddb3928b2dfcb1c556a1368b55]
stable/5.15: [c6015d0f7a2236ddb3928b2dfcb1c556a1368b55]
stable/5.4: [736ae988bfb5932c05625baff70fba224d547c08]
stable/5.4: [736ae988bfb5932c05625baff70fba224d547c08]
stable/6.1: [f746fe0c51e044d1248dc67918328bfb3d86b639]
stable/6.1: [f746fe0c51e044d1248dc67918328bfb3d86b639]
stable/6.12: [7fe3b4deed8b93609058c37c9a11df1d2b2c0423]
stable/6.12: [7fe3b4deed8b93609058c37c9a11df1d2b2c0423]
stable/6.14: [ad4c3037dc77739a625246a2a0fb23b8f3402c06]
stable/6.14: [ad4c3037dc77739a625246a2a0fb23b8f3402c06]
stable/6.6: [e4d1ca0a84a6650d3172eb8c07ef2fbc585b0d96]
stable/6.6: [e4d1ca0a84a6650d3172eb8c07ef2fbc585b0d96]

CVE-2025-37858: fs/jfs: Prevent integer overflow in AG size calculation

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37858

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
It looks as if 4.4 and 4.19 are affected.

Fixed status
mainline: [7fcbf789629cdb9fbf4e2172ce31136cfed11e5e]
stable/5.10: [8bb29629a5e4090e1ef7199cb42db04a52802239]
stable/5.10: [8bb29629a5e4090e1ef7199cb42db04a52802239]
stable/5.15: [3d8a45f87010a802aa214bf39702ca9d99cbf3ba]
stable/5.15: [3d8a45f87010a802aa214bf39702ca9d99cbf3ba]
stable/5.4: [dd07a985e2ded47b6c7d69fc93c1fe02977c8454]
stable/5.4: [dd07a985e2ded47b6c7d69fc93c1fe02977c8454]
stable/6.1: [55edbf5dbf60a8195c21e92124c4028939ae16b2]
stable/6.1: [55edbf5dbf60a8195c21e92124c4028939ae16b2]
stable/6.12: [c802a6a4009f585111f903e810b3be9c6d0da329]
stable/6.12: [c802a6a4009f585111f903e810b3be9c6d0da329]
stable/6.14: [ec34cdf4f917cc6abd306cf091f8b8361fedac88]
stable/6.14: [ec34cdf4f917cc6abd306cf091f8b8361fedac88]
stable/6.6: [7ccf3b35274512b60ecb614e0637e76bd6f2d829]
stable/6.6: [7ccf3b35274512b60ecb614e0637e76bd6f2d829]

CVE-2025-37859: page_pool: avoid infinite loop to schedule delayed worker

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37859

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
Affected function was added by c3f812c ("page_pool: do not release pool unt=
il
inflight =3D=3D 0.") in 5.5-rc1.
Bug introduced commit was backported to following branches.
stable/5.4

Fixed status
mainline: [43130d02baa137033c25297aaae95fd0edc41654]
stable/5.10: [9f71db4fb82deb889e0bac4a51b34daea7d506a3]
stable/5.10: [9f71db4fb82deb889e0bac4a51b34daea7d506a3]
stable/5.15: [91522aba56e9fcdf64da25ffef9b27f8fad48e0f]
stable/5.15: [91522aba56e9fcdf64da25ffef9b27f8fad48e0f]
stable/5.4: [c3c7c57017ce1d4b2d3788c1fc59e7e39026e158]
stable/5.4: [c3c7c57017ce1d4b2d3788c1fc59e7e39026e158]
stable/6.1: [90e089a64504982f8d62f223027cb9f903781f78]
stable/6.1: [90e089a64504982f8d62f223027cb9f903781f78]
stable/6.12: [7204335d1991c23fc615ab76f31f175748a578e1]
stable/6.12: [7204335d1991c23fc615ab76f31f175748a578e1]
stable/6.14: [738d1812ec2e395e953258aea912ddd867d11a13]
stable/6.14: [738d1812ec2e395e953258aea912ddd867d11a13]
stable/6.6: [95f17738b86fd198924d874a5639bcdc49c7e5b8]
stable/6.6: [95f17738b86fd198924d874a5639bcdc49c7e5b8]

CVE-2025-37861: scsi: mpi3mr: Synchronous access b/w reset and tm
thread for reply queue

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37861

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
Affected files were added by 824a156 ("scsi: mpi3mr: Base driver
code") in 5.14-rc1.

Fixed status
mainline: [f195fc060c738d303a21fae146dbf85e1595fb4c]
stable/6.12: [65ba18c84dbd03afe9b38c06c151239d97a09834]
stable/6.12: [65ba18c84dbd03afe9b38c06c151239d97a09834]
stable/6.14: [75b67dca4195e11ccf966a704787b2aa2754a457]
stable/6.14: [75b67dca4195e11ccf966a704787b2aa2754a457]

CVE-2025-37862: HID: pidff: Fix null pointer dereference in pidff_find_fiel=
ds

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37862

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
It seems as if this bug was introduced by 224ee88 ("Input: add force feedba=
ck
driver for PID devices") in v2.6.19-rc1.

Fixed status
mainline: [22a05462c3d0eee15154faf8d13c49e6295270a5]
stable/5.10: [d230becb9d38b7325c5c38d051693e4c26b1829b]
stable/5.10: [d230becb9d38b7325c5c38d051693e4c26b1829b]
stable/5.15: [6b4449e4f03326fbd2136e67bfcc1e6ffe61541d]
stable/5.15: [6b4449e4f03326fbd2136e67bfcc1e6ffe61541d]
stable/5.4: [44a1b8b2027afbb37e418993fb23561bdb9efb38]
stable/5.4: [44a1b8b2027afbb37e418993fb23561bdb9efb38]
stable/6.1: [ddb147885225d768025f6818df533d30edf3e102]
stable/6.1: [ddb147885225d768025f6818df533d30edf3e102]
stable/6.12: [f8f4d77710e1c38f4a2bd26c88c4878b5b5e817a]
stable/6.12: [f8f4d77710e1c38f4a2bd26c88c4878b5b5e817a]
stable/6.14: [e368698da79af821f18c099520deab1219c2044b]
stable/6.14: [e368698da79af821f18c099520deab1219c2044b]
stable/6.6: [be706a48bb7896d4130edc82811233d1d62158e7]
stable/6.6: [be706a48bb7896d4130edc82811233d1d62158e7]

CVE-2025-37863: ovl: don't allow datadir only

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37863

Introduced by commit 24e16e3 ("ovl: add support for appending
lowerdirs one by one") in v6.7-rc1.
Fixed in v6.15-rc3.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [eb3a04a8516ee9b5174379306f94279fc90424c4]
stable/6.12: [b9e3579213ba648fa23f780e8d53e99011c62331]
stable/6.12: [b9e3579213ba648fa23f780e8d53e99011c62331]
stable/6.14: [21d2ffb0e9838a175064c22f3a9de97d1f56f27d]
stable/6.14: [21d2ffb0e9838a175064c22f3a9de97d1f56f27d]
stable/6.6: [0874b629f65320778e7e3e206177770666d9db18]
stable/6.6: [0874b629f65320778e7e3e206177770666d9db18]

CVE-2025-37864: net: dsa: clean up FDB, MDB, VLAN entries on unbind

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37864

Introduced by commit 0832cd9 ("net: dsa: warn if port lists aren't
empty in dsa_port_teardown") in v5.18-rc1.
Fixed in v6.15-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7afb5fb42d4950f33af2732b8147c552659f79b7]
stable/6.12: [8fcc1e6f808912977caf17366c625b95dc29ba4f]
stable/6.12: [8fcc1e6f808912977caf17366c625b95dc29ba4f]
stable/6.14: [99c50c98803425378e08a7394dc885506dc85f06]
stable/6.14: [99c50c98803425378e08a7394dc885506dc85f06]
stable/6.6: [86c6613a69bca815f1865ed8cedfd4b9142621ab]
stable/6.6: [86c6613a69bca815f1865ed8cedfd4b9142621ab]

CVE-2025-37865: net: dsa: mv88e6xxx: fix -ENOENT when deleting VLANs
and MST is unsupported

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37865

Introduced by commit acaf4d2 ("net: dsa: mv88e6xxx: MST Offloading")
in v5.18-rc1.
Fixed in v6.15-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea08dfc35f83cfc73493c52f63ae4f2e29edfe8d]
stable/6.1: [35cde75c08a1fa1a5ac0467afe2709caceeef002]
stable/6.1: [35cde75c08a1fa1a5ac0467afe2709caceeef002]
stable/6.12: [9ee6d3a368ed34f2457863da3085c676e9e37a3d]
stable/6.12: [9ee6d3a368ed34f2457863da3085c676e9e37a3d]
stable/6.14: [9da4acbd60664271d34a627f7f63cd5bad8eba74]
stable/6.14: [9da4acbd60664271d34a627f7f63cd5bad8eba74]
stable/6.6: [afae9087301471970254a9180e5a26d3d8e8af09]
stable/6.6: [afae9087301471970254a9180e5a26d3d8e8af09]

CVE-2025-37866: mlxbf-bootctl: use sysfs_emit_at() in
secure_boot_fuse_state_show()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37866

Introduced by commit 9886f57 ("platform/mellanox: mlxbf-bootctl: use
sysfs_emit() instead of sprintf()") in v6.14-rc1.
Fixed in v6.15-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b129005ddfc0e6daf04a6d3b928a9e474f9b3918]
stable/6.14: [5e1dcc5bfd7a2896178c604bc69d6ab9650967da]
stable/6.14: [5e1dcc5bfd7a2896178c604bc69d6ab9650967da]

CVE-2025-37867: RDMA/core: Silence oversized kvmalloc() warning

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37867

Introduced by commit 3782495 ("RDMA/odp: Use kvcalloc for the dma_list
and page_list") in v5.4-rc1.
Fixed in v6.15-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9a0e6f15029e1a8a21e40f06fd05aa52b7f063de]
stable/5.10: [f94ac90ce7bd6f9266ad0d99044ed86e8d1416c1]
stable/5.10: [f94ac90ce7bd6f9266ad0d99044ed86e8d1416c1]
stable/5.15: [791daf8240cedf27af8794038ae1d32ef643bce6]
stable/5.15: [791daf8240cedf27af8794038ae1d32ef643bce6]
stable/6.1: [6c588e9afbab240c921f936cb676dac72e2e2b66]
stable/6.1: [6c588e9afbab240c921f936cb676dac72e2e2b66]
stable/6.12: [0d81bb58a203ad5f4044dc18cfbc230c194f650a]
stable/6.12: [0d81bb58a203ad5f4044dc18cfbc230c194f650a]
stable/6.14: [f476eba25fdf70faa7b19a3e0fb00e65c5b53106]
stable/6.14: [f476eba25fdf70faa7b19a3e0fb00e65c5b53106]
stable/6.6: [ae470d06320dea4002d441784d691f0a26b4322d]
stable/6.6: [ae470d06320dea4002d441784d691f0a26b4322d]

CVE-2025-37868: drm/xe/userptr: fix notifier vs folio deadlock

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37868

Introduced by commit 0a98219 ("drm/xe/hmm: Don't dereference struct
page pointers without notifier lock") in v6.14-rc6.
Fixed in v6.15-rc3.

Bug introduced commit was backported to following branches.
stable/6.12

Fixed status
mainline: [2577b202458cddff85cc154b1fe7f313e0d1f418]
stable/6.12: [65dc4e3d5b01db0179fc95c1f0bdb87194c28ab5]
stable/6.12: [65dc4e3d5b01db0179fc95c1f0bdb87194c28ab5]
stable/6.14: [90574ecf6052be83971d91d16600c5cf07003bbb]
stable/6.14: [90574ecf6052be83971d91d16600c5cf07003bbb]

CVE-2025-37869: drm/xe: Use local fence in error path of xe_migrate_clear

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37869

Introduced by commit dd08ebf ("drm/xe: Introduce a new DRM driver for
Intel GPUs") in v6.8-rc1.
Fixed in v6.15-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [20659d3150f1a2a258a173fe011013178ff2a197]
stable/6.12: [2ac5f466f62892a7d1ac2d1a3eb6cd14efbe2f2d]
stable/6.12: [2ac5f466f62892a7d1ac2d1a3eb6cd14efbe2f2d]
stable/6.14: [dc712938aa26b001f448d5e93f59d57fa80f2dbd]
stable/6.14: [dc712938aa26b001f448d5e93f59d57fa80f2dbd]

CVE-2025-37870: drm/amd/display: prevent hang on link training fail

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37870

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
Added vulnerable code into the dcn20_enable_stream by 7462475 ("drm/amd/dis=
play:
move dccg programming from link hwss hpo dp to hwss") in 6.3-rc1.
The enable_symclk32_se was added by 70839da ("drm/amd/display: Add new DCN4=
01
sources") in 6.11-rc1.

Fixed status
mainline: [8058061ed9d6bc259d1e678607b07d259342c08f]
stable/6.12: [0363c03672cd3191f037905bf981eb523a3b71b1]
stable/6.12: [0363c03672cd3191f037905bf981eb523a3b71b1]
stable/6.14: [04bf4f2a497e9877c425c5124652e61fb8a1a0aa]
stable/6.14: [04bf4f2a497e9877c425c5124652e61fb8a1a0aa]

CVE-2025-37871: nfsd: decrease sc_count directly if fail to queue dl_recall

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37871

Introduced by commit 230ca75 ("nfsd: put dl_stid if fail to queue
dl_recall") in v6.15-rc1.
Fixed in v6.15-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1
stable/6.12 stable/6.14 stable/6.6

Fixed status
mainline: [a1d14d931bf700c1025db8c46d6731aa5cf440f9]
stable/5.10: [b9bbe8f9d5663311d06667ce36d6ed255ead1a26]
stable/5.10: [b9bbe8f9d5663311d06667ce36d6ed255ead1a26]
stable/5.15: [a70832d3555987035fc430ccd703acd89393eadb]
stable/5.15: [a70832d3555987035fc430ccd703acd89393eadb]
stable/6.1: [ba903539fff745d592d893c71b30e5e268a95413]
stable/6.1: [ba903539fff745d592d893c71b30e5e268a95413]
stable/6.12: [a7fce086f6ca84db409b9d58493ea77c1978897c]
stable/6.12: [a7fce086f6ca84db409b9d58493ea77c1978897c]
stable/6.14: [14985d66b9b99c12995dd99d1c6c8dec4114c2a5]
stable/6.14: [14985d66b9b99c12995dd99d1c6c8dec4114c2a5]
stable/6.6: [7d192e27a431026c58d60edf66dc6cd98d0c01fc]
stable/6.6: [7d192e27a431026c58d60edf66dc6cd98d0c01fc]

CVE-2025-37872: net: txgbe: fix memory leak in txgbe_probe() error path

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37872

Introduced by commit 937d46e ("net: wangxun: add ethtool_ops for
channel number") in v6.8-rc1.
Fixed in v6.15-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b2727326d0a53709380aa147018085d71a6d4843]
stable/6.12: [635863d93deb8e352d63a8eba852efeaf1ac3539]
stable/6.12: [635863d93deb8e352d63a8eba852efeaf1ac3539]
stable/6.14: [837197a722919f5b0eeb967fe7cb0cc1e83173b9]
stable/6.14: [837197a722919f5b0eeb967fe7cb0cc1e83173b9]

CVE-2025-37873: eth: bnxt: fix missing ring index trim on error path

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37873

Introduced by commit 6d1add9 ("bnxt_en: Modify TX ring indexing
logic.") in v6.8-rc1.
Fixed in v6.15-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12f2d033fae957d84c2c0ce604d2a077e61fa2c0]
stable/6.12: [21e70f694bc0dcb40174b0940cc52a7769fc19e0]
stable/6.12: [21e70f694bc0dcb40174b0940cc52a7769fc19e0]
stable/6.14: [3742c55de00266fa7c8fd2c5d61a453d223a9cd1]
stable/6.14: [3742c55de00266fa7c8fd2c5d61a453d223a9cd1]

CVE-2025-37874: net: ngbe: fix memory leak in ngbe_probe() error path

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37874

Introduced by commit 02338c4 ("net: ngbe: Initialize sw info and
register netdev") in v6.2-rc1.
Fixed in v6.15-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [88fa80021b77732bc98f73fb69d69c7cc37b9f0d]
stable/6.12: [8335a3feb9d0d97e5e8f76d38b6bb8573d5b4a29]
stable/6.12: [8335a3feb9d0d97e5e8f76d38b6bb8573d5b4a29]
stable/6.14: [397487338eff1891c4654ce7deaafbf72a1688b2]
stable/6.14: [397487338eff1891c4654ce7deaafbf72a1688b2]
stable/6.6: [7c2b66a31c7a4866400f7e6fb43cb32021bfca01]
stable/6.6: [7c2b66a31c7a4866400f7e6fb43cb32021bfca01]

CVE-2025-37875: igc: fix PTM cycle trigger logic

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37875

Introduced by commit a90ec84 ("igc: Add support for PTP
getcrosststamp()") in v5.15-rc1.
Fixed in v6.15-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e404ad95d2c10c261e2ef6992c7c12dde03df0e]
stable/5.15: [c1f174edaccc5a00f8e218c42a0aa9156efd5f76]
stable/5.15: [c1f174edaccc5a00f8e218c42a0aa9156efd5f76]
stable/6.1: [0c03e4fbe1321697d9d04587e21e416705e1b19f]
stable/6.1: [0c03e4fbe1321697d9d04587e21e416705e1b19f]
stable/6.12: [f3516229cd12dcd45f23ed01adab17e8772b1bd5]
stable/6.12: [f3516229cd12dcd45f23ed01adab17e8772b1bd5]
stable/6.14: [31959e06143692f7e02b8eef7d7d6ac645637906]
stable/6.14: [31959e06143692f7e02b8eef7d7d6ac645637906]
stable/6.6: [16194ca3f3b4448a062650c869a7b3b206c6f5d3]
stable/6.6: [16194ca3f3b4448a062650c869a7b3b206c6f5d3]

CVE-2025-37876: netfs: Only create /proc/fs/netfs with CONFIG_PROC_FS

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37876

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc3.
It looks as if this bug was introduced by commit 7eb5b3e ("netfs, fscache:
Move /proc/fs/fscache to /proc/fs/netfs and put in a symlink") in 6.8-rc1.

Fixed status
mainline: [40cb48eba3b4b79e110c1a35d33a48cac54507a2]
stable/6.12: [2ef6eea2efce01d1956ace483216f6b6e26330c9]
stable/6.12: [2ef6eea2efce01d1956ace483216f6b6e26330c9]
stable/6.14: [6c4c5e0b96a90f2a11c378e66edc1f25165e10b6]
stable/6.14: [6c4c5e0b96a90f2a11c378e66edc1f25165e10b6]

CVE-2025-37877: iommu: Clear iommu-dma ops on cleanup

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37877

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc2.
The iommu_init_device was added by aa09585 ("iommu: Add
iommu_init/deinit_device()
paired functions") in 6.6-rc1.
The dma_iommu flag was added by b5c58b2 ("dma-mapping: direct calls
for dma-iommu")
in 6.12-rc1.

Fixed status
mainline: [280e5a30100578106a4305ce0118e0aa9b866f12]
stable/6.12: [b14d98641312d972bb3f38e82eddf92898522389]
stable/6.12: [b14d98641312d972bb3f38e82eddf92898522389]
stable/6.14: [104a84276821aed0ed241ce0d82d6c3267e3fcb8]
stable/6.14: [104a84276821aed0ed241ce0d82d6c3267e3fcb8]

CVE-2025-37878: perf/core: Fix WARN_ON(!ctx) in __free_event() for partial =
init

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37878

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc2.


Fixed status
mainline: [0ba3a4ab76fd3367b9cb680cad70182c896c795c]
stable/6.12: [90dc6c1e3b200812da8d0aa030e1b7fda8226d0e]
stable/6.12: [90dc6c1e3b200812da8d0aa030e1b7fda8226d0e]
stable/6.14: [cb56cd11feabf99e08bc18960700a53322ffcea7]
stable/6.14: [cb56cd11feabf99e08bc18960700a53322ffcea7]
stable/6.6: [1fe9b92eede32574dbe05b5bdb6ad666b350bed0]
stable/6.6: [1fe9b92eede32574dbe05b5bdb6ad666b350bed0]

CVE-2025-37879: 9p/net: fix improper handling of bogus negative
read/write replies

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37879

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [d0259a856afca31d699b706ed5e2adf11086c73b]
stable/6.1: [468ff4a7c61fb811c596a7c44b6a5455e40fd12b]
stable/6.1: [468ff4a7c61fb811c596a7c44b6a5455e40fd12b]
stable/6.12: [c548f95688e2b5ae0e2ae43d53cf717156c7d034]
stable/6.12: [c548f95688e2b5ae0e2ae43d53cf717156c7d034]
stable/6.14: [374e4cd75617c8c2552f562f39dd989583f5c330]
stable/6.14: [374e4cd75617c8c2552f562f39dd989583f5c330]
stable/6.6: [a68768e280b7d0c967ea509e791bb9b90adc94a5]
stable/6.6: [a68768e280b7d0c967ea509e791bb9b90adc94a5]

CVE-2025-37880: um: work around sched_yield not yielding in time-travel mod=
e

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37880

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [887c5c12e80c8424bd471122d2e8b6b462e12874]
stable/6.12: [da780c4a075ba2deb05ae29f0af4a990578c7901]
stable/6.12: [da780c4a075ba2deb05ae29f0af4a990578c7901]
stable/6.14: [990ddc65173776f1e01e7135d8c1fd5f8fd4d5d2]
stable/6.14: [990ddc65173776f1e01e7135d8c1fd5f8fd4d5d2]

CVE-2025-37881: usb: gadget: aspeed: Add NULL pointer check in
ast_vhub_init_dev()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37881

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
Introduced by 7ecca2a ("usb/gadget: Add driver for Aspeed SoC virtual hub")
in 4.18-rc1.

Fixed status
mainline: [8c75f3e6a433d92084ad4e78b029ae680865420f]
stable/5.10: [c8d4faf452a627f9b09c3a5c366133a19e5b7a28]
stable/5.10: [c8d4faf452a627f9b09c3a5c366133a19e5b7a28]
stable/5.15: [d26a6093d52904cacdbb75424c323c19b443a890]
stable/5.15: [d26a6093d52904cacdbb75424c323c19b443a890]
stable/5.4: [a777ccfb9ba8d43f745e41b69ba39d4a506a081e]
stable/5.4: [a777ccfb9ba8d43f745e41b69ba39d4a506a081e]
stable/6.1: [36d68151712e525450f0fbb3045e7110f0d9b610]
stable/6.1: [36d68151712e525450f0fbb3045e7110f0d9b610]
stable/6.12: [052fb65335befeae8500e88d69ea022266baaf6d]
stable/6.12: [052fb65335befeae8500e88d69ea022266baaf6d]
stable/6.14: [61006ca381b4d65d2b8ca695ea8da1ce18d6dee3]
stable/6.14: [61006ca381b4d65d2b8ca695ea8da1ce18d6dee3]
stable/6.6: [cfa7984f69359761b07a7831c1258c0fde1e0389]
stable/6.6: [cfa7984f69359761b07a7831c1258c0fde1e0389]

CVE-2025-37882: usb: xhci: Fix isochronous Ring Underrun/Overrun event hand=
ling

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37882

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [906dec15b9b321b546fd31a3c99ffc13724c7af4]
stable/6.12: [16a7a8e6c47fea5c847beb696c8c21a7a44c1915]
stable/6.12: [16a7a8e6c47fea5c847beb696c8c21a7a44c1915]
stable/6.14: [39a080a2925c81b0f1da0add44722ef2b78e5454]
stable/6.14: [39a080a2925c81b0f1da0add44722ef2b78e5454]

CVE-2025-37883: s390/sclp: Add check for get_zeroed_page()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37883

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
This bug was introduced by commit 4c8f479 ("[S390] sclp console: convert fr=
om
bootmem to slab") in v2.6.31-rc1.

Fixed status
mainline: [3db42c75a921854a99db0a2775814fef97415bac]
stable/5.15: [e1e00dc45648125ef7cb87ebc3b581ac224e7b39]
stable/5.15: [e1e00dc45648125ef7cb87ebc3b581ac224e7b39]
stable/6.1: [397254706eba9d8f99fd237feede7ab3169a7f9a]
stable/6.1: [397254706eba9d8f99fd237feede7ab3169a7f9a]
stable/6.12: [3b3aa72636a6205933609ec274a8747720c1ee3f]
stable/6.12: [3b3aa72636a6205933609ec274a8747720c1ee3f]
stable/6.14: [f69f8a93aacf6e99af7b1cc992d8ca2cc07b96fb]
stable/6.14: [f69f8a93aacf6e99af7b1cc992d8ca2cc07b96fb]
stable/6.6: [28e5a867aa542e369e211c2baba7044228809a99]
stable/6.6: [28e5a867aa542e369e211c2baba7044228809a99]

CVE-2025-37884: bpf: Fix deadlock between rcu_tasks_trace and event_mutex.

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37884

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.
It looks as if this bug was introduced by 10aceb6 ("bpf: Add bpf_trace_vpri=
ntk
helper") in 5.16-rc1.

Fixed status
mainline: [4580f4e0ebdf8dc8d506ae926b88510395a0c1d1]
stable/6.1: [255cbc9db7067a83713fd2f4b31034ddd266549a]
stable/6.1: [255cbc9db7067a83713fd2f4b31034ddd266549a]
stable/6.12: [c5c833f6375f8ecf9254dd27946c927c7d645421]
stable/6.12: [c5c833f6375f8ecf9254dd27946c927c7d645421]
stable/6.14: [45286680b385f2592db3003554872388dee66d68]
stable/6.14: [45286680b385f2592db3003554872388dee66d68]
stable/6.6: [b5a528a34e1f613565115a7a6016862ccbfcb9ac]
stable/6.6: [b5a528a34e1f613565115a7a6016862ccbfcb9ac]

CVE-2025-37885: KVM: x86: Reset IRTE to host control if *new* route
isn't postable

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37885

Introduced by commit efc6440 ("KVM: x86: Update IRTE for
posted-interrupts") in v4.4-rc1.
Introduced by commit 411b44b ("svm: Implements update_pi_irte hook to
setup posted interrupt") in v4.9-rc1.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9bcac97dc42d2f4da8229d18feb0fe2b1ce523a2]
stable/5.10: [e5f2dee9f7fcd2ff4b97869f3c66a0d89c167769]
stable/5.10: [e5f2dee9f7fcd2ff4b97869f3c66a0d89c167769]
stable/5.15: [116c7d35b8f72eac383b9fd371d7c1a8ffc2968b]
stable/5.15: [116c7d35b8f72eac383b9fd371d7c1a8ffc2968b]
stable/6.1: [023816bd5fa46fab94d1e7917fe131b79ed1fb41]
stable/6.1: [023816bd5fa46fab94d1e7917fe131b79ed1fb41]
stable/6.12: [b5de7ac74f69603ad803c524b840bffd36368fc3]
stable/6.12: [b5de7ac74f69603ad803c524b840bffd36368fc3]
stable/6.14: [3066ec21d1a33896125747f68638725f456308db]
stable/6.14: [3066ec21d1a33896125747f68638725f456308db]
stable/6.6: [3481fd96d801715942b6f69fe251133128156f30]
stable/6.6: [3481fd96d801715942b6f69fe251133128156f30]

CVE-2025-37886: pds_core: make wait_context part of q_info

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37886

Introduced by commit 01ba61b ("pds_core: Add adminq processing and
commands") in v6.4-rc1.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f77c3dfffc7063428b100c4945ca2a7a8680380]
stable/6.12: [66d7702b42ffdf0dce4808626088268a4e905ca6]
stable/6.12: [66d7702b42ffdf0dce4808626088268a4e905ca6]
stable/6.14: [520f012fe75fb8efc9f16a57ef929a7a2115d892]
stable/6.14: [520f012fe75fb8efc9f16a57ef929a7a2115d892]
stable/6.6: [1d7c4b2b0bbfb09b55b2dc0e2355d7936bf89381]
stable/6.6: [1d7c4b2b0bbfb09b55b2dc0e2355d7936bf89381]

CVE-2025-37887: pds_core: handle unsupported PDS_CORE_CMD_FW_CONTROL result

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37887

Introduced by commit 45d76f4 ("pds_core: set up device and adminq") in v6.4=
-rc1.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2567daad69cd1107fc0ec29b1615f110d7cf7385]
stable/6.12: [6702f5c6b22deaa95bf84f526148174a160a02cb]
stable/6.12: [6702f5c6b22deaa95bf84f526148174a160a02cb]
stable/6.14: [12a4651a80dbe4589a84e26785fbbe1ed4d043b7]
stable/6.14: [12a4651a80dbe4589a84e26785fbbe1ed4d043b7]
stable/6.6: [cdd784c96fe2e5edbf0ed9b3e96fe776e8092385]
stable/6.6: [cdd784c96fe2e5edbf0ed9b3e96fe776e8092385]

CVE-2025-37888: net/mlx5: Fix null-ptr-deref in mlx5_create_{inner_,}ttc_ta=
ble()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37888

Introduced by commit 137f3d5 ("net/mlx5: Support matching on l4_type
for ttc_table") in v6.10-rc1.
Fixed in v6.15-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [91037037ee3d611ce17f39d75f79c7de394b122a]
stable/6.12: [0b682680b12b08cd62b113ea92b2938195de1dfe]
stable/6.12: [0b682680b12b08cd62b113ea92b2938195de1dfe]
stable/6.14: [ecd9d2647ddb4f42a121de648e48659ae1856c39]
stable/6.14: [ecd9d2647ddb4f42a121de648e48659ae1856c39]

CVE-2025-37889: ASoC: ops: Consistently treat platform_max as control value

Announce: https://www.cve.org/CVERecord?id=3DCVE-2025-37889

Introduced by commit fb9ad24 ("ASoC: ops: add correct range check for
limiting volume") in v6.7-rc5.
Fixed in v6.14-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [0eba2a7e858907a746ba69cd002eb9eb4dbd7bf3]
stable/5.15: [c402f184a053c8e7ca325e50f04bbbc1e4fee019]
stable/5.15: [c402f184a053c8e7ca325e50f04bbbc1e4fee019]
stable/6.1: [694110bc2407a61f02a770cbb5f39b51e4ec77c6]
stable/6.1: [694110bc2407a61f02a770cbb5f39b51e4ec77c6]
stable/6.12: [a46a9371f8b9a0eeff53a21e11ed3b65f52d9cf6]
stable/6.12: [a46a9371f8b9a0eeff53a21e11ed3b65f52d9cf6]
stable/6.6: [544055329560d4b64fe204fc6be325ebc24c72ca]
stable/6.6: [544055329560d4b64fe204fc6be325ebc24c72ca]

CVE-2024-28956: x86: Indirect Target Selection

Announce: https://www.cve.org/CVERecord?id=3DCVE-2024-28956



Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1ac116ce6468670eeda39345a5585df308243dca,159013a7ca18c271ff64192=
deb62a689b622d860,8754e67ad4ac692c67ff1f99c0d07156f04ae40c,a75bf27fe41abe65=
8c53276a0c486c4bf9adecfc,f4818881c47fd91fcb6d62373c57c7844e3de1c0,2665281a0=
7e19550944e8354a2024635a7b2714a,facd226f7e0c8ca936ac114aba43cb3e8b94e41e,f0=
cd7091cc5a032c8870b4285305d9172569d126,d6d1e3e6580ca35071ad474381f053cbf1fb=
6414,ebebe30794d38c51f71fe4951ba6af4159d9837d,872df34d7c51a79523820ea6a1486=
0398c639b87,e52c1dc7455d32c8a55f9949d300e5e87d011fa6,7a9b709e7cc5ce1ffb84ce=
07bf6d157e1de758df]

CVE-2023-53146: media: dw2102: Fix null-ptr-deref in dw2102_i2c_transfer()

Announce: https://www.cve.org/CVERecord?id=3DCVE-2023-53146

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.6-rc1.


Fixed status
cip/4.19-st: [ecbe6d011b95c7da59f014f8d26cb7245ed1e11e]
cip/4.4-st: [ffe7df53fb3ea13457df7b26053de60db4fd0688]
mainline: [5ae544d94abc8ff77b1b9bf8774def3fa5689b5b]
stable/4.19: [ecbe6d011b95c7da59f014f8d26cb7245ed1e11e]
stable/4.19: [ecbe6d011b95c7da59f014f8d26cb7245ed1e11e]
stable/5.10: [97fdbdb750342cbc204befde976872fedb406ee6]
stable/5.10: [97fdbdb750342cbc204befde976872fedb406ee6]
stable/5.15: [903566208ae6bb9c0e7e54355ce75bf6cf72485d]
stable/5.15: [903566208ae6bb9c0e7e54355ce75bf6cf72485d]
stable/5.4: [beb9550494e7349f92b9eaa283256a5ad9b1c9be]
stable/5.4: [beb9550494e7349f92b9eaa283256a5ad9b1c9be]
stable/6.1: [08dfcbd03b2b7f918c4f87c6ff637054e510df74]
stable/6.1: [08dfcbd03b2b7f918c4f87c6ff637054e510df74]
stable/6.6: [5ae544d94abc8ff77b1b9bf8774def3fa5689b5b]
stable/6.6: [5ae544d94abc8ff77b1b9bf8774def3fa5689b5b]

* Updated CVEs

CVE-2025-21839: KVM: x86: Load DR6 with guest value only before
entering .vcpu_run() loop

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [9efb2b99b96c86664bbdbdd2cdb354ac9627eb20]
stable/6.1: [93eeb6df1605b3a24f38afdba7ab903ba6b64133]
stable/6.12: [4eb063de686bfcdfd03a8c801d1bbe87d2d5eb55]
stable/6.13: [d456de38d9eb753a4e9fde053c18d4ef8e485339]
stable/6.6: [a1723e9c53fe6431415be19302a56543daf503f5]

CVE-2024-58237: bpf: consider that tail calls invalidate packet pointers

stable/6.6 was fixed.

Fixed status
stable/6.12: [1c2244437f9ad3dd91215f920401a14f2542dbfc]
stable/6.6: [f1692ee23dcaaddc24ba407b269707ee5df1301f]

CVE-2024-58100: bpf: check changes_pkt_data property for extension programs

stable/6.6 was fixed.

Fixed status
stable/6.12: [3846e2bea565ee1c5195dcc625fda9868fb0e3b3]
stable/6.6: [7197fc4acdf238ec8ad06de5a8235df0c1f9c7d7]

CVE-2024-58098: bpf: track changes_pkt_data property for global functions

stable/6.6 was fixed.

Fixed status
stable/6.12: [1d572c60488b52882b719ed273767ee3b280413d]
stable/6.6: [79751e9227a5910c0e5a2c7186877d91821d957d]

CVE-2024-45027: usb: xhci: Check for xhci->interrupters being
allocated in xhci_mem_clearup()

stable/6.6 was fixed.

Fixed status
stable/6.10: [770cacc75b0091ece17349195d72133912c1ca7c]
stable/6.6: [3efb29f6a78d4746f958c1ab6cd7981c5762f03b]

CVE-2024-38541: of: module: add buffer overflow check in of_modalias()

stable/5.15 was fixed.

Fixed status
stable/5.15: [c7f24b7d94549ff4623e8f41ea4d9f5319bd8ac8]
stable/6.1: [5d59fd637a8af42b211a92b2edb2474325b4d488]
stable/6.6: [0b0d5701a8bf02f8fee037e81aacf6746558bfd6]
stable/6.9: [e45b69360a63165377b30db4a1dfddd89ca18e9a]

CVE-2024-26739: net/sched: act_mirred: don''t override retval if we
already lost the skb

stable/5.15 was fixed.

Fixed status
stable/5.15: [9d3ef89b6a5e9f2e940de2cef3d543be0be8dec5]
stable/6.1: [e873e8f7d03a2ee5b77fb1a305c782fed98e2754]
stable/6.6: [28cdbbd38a4413b8eff53399b3f872fd4e80db9d]
stable/6.7: [f4e294bbdca8ac8757db436fc82214f3882fc7e7]

CVE-2022-21546: scsi: target: Fix WRITE_SAME No Data Buffer crash

stable/5.15 was fixed.

Fixed status
stable/5.15: [4226622647e3e5ac06d3ebc1605b917446157510]

Regards,
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com


Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E79C02194
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 22:47:50 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
 by mx.groups.io with SMTP id smtpd.web11.26592.1738795663087072827
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Feb 2025 14:47:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=seT4PfdP;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.182, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6f8c58229f1so2750147b3.0
        for <cip-dev@lists.cip-project.org>; Wed, 05 Feb 2025 14:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1738795662; x=1739400462; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZQ5/6jGtu6i3yntiFlb6t91PbmiNrKM7ATp0q3+FtAc=;
        b=seT4PfdP6qO7xBytGFMYjvXhxIvBAhN3BgoBj2wGaCMI4E14nwLgx8I1muxBXNJ3bB
         XxwV8BGpihWC9pt7MiYiLItresH5lOV/WaY0Bajb1xFjwCLpE2ATic7Guqx/vIRO5z0u
         B0Vx1NeL6RCuGB8J9YmWix67gS+UguaMzVF0FzzbZiru70k/iYgX3kf5eYSF8SMqUf83
         UwlSvRGusD+dZ/8DEDgjiGxPXdaW3Z9CEJBcdyAvk+5qoevtLj/1CkHemB2U85kYTIz3
         NDuFvxMWGjJT1qmautrTmmUiPGGPHoXjb9+fmF2fKrn3b7CfRt7Ivr3XXZcb0t8YFygN
         simw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738795662; x=1739400462;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZQ5/6jGtu6i3yntiFlb6t91PbmiNrKM7ATp0q3+FtAc=;
        b=Gnb7nHe29VX1vYDHp7s/OJgqmv5OpK1Ko8u3T7zt14x3sqzc4ed9sJZP1CJqqtb+z3
         4FXUKpXFu0HAxyHadTwG6q4XRN3meguCxNMTmxhDFOIrfEdzScKH3dM8MeQgCEdmlIx2
         hjvdUqTyVWRqp9yVgl489s2FQEef0UajPQSPcIu1CxwjB+8weFYh6fIroOc9wFvR+SvR
         WtymGoLhleN80kUxlzUKgPks1ZjAtGbmvvgsWN9LwAllv4iAeXe74LaGz6eJ/4p8FKkh
         OzWjErV+WVNGLsGTxORch0Qet1zhMLuUJ+ff2oXoodif+w4ytbT0xjUpTluq1cJ2Te6Y
         V1Rg==
X-Gm-Message-State: AOJu0YxqQn4FgV4cmNuOAMnOlDKdRxUP68QASiHh7AT5B9agPNRn9TNU
	ppQV1v8uyH6/jRs8MwWLm1FzEMYSxwGASIytEfOhDix3CVHtJMeNxW2/YvO2RRThnn7jlnt/W+x
	1HWVvZykB44eQZz4sUSSJFg+NSKKow+WTAtiV8YIQE32ndppjfVM=
X-Gm-Gg: ASbGncsd2HjTrf460WHNFTTK0R3CJwdo1wZ6fqCDO8iH29/cj5/KySQL23/FyWOiyXh
	cy4keFtcqqKJGCQccW0yA2Jor5f8HF31lyjNDVecjLL3M5eW7UCNp0w5efzIhcPdZZIXSYXa5nA
	==
X-Google-Smtp-Source: AGHT+IGihyJd6AozTSM8c3MsygHLpFqPY59jM+GyWOOVfjo5VwPQ48YbyjZwyh1sMDK9PA4rGgI3btLTK5818udQn7E=
X-Received: by 2002:a05:690c:688e:b0:6e2:2684:7f62 with SMTP id
 00721157ae682-6f99a5722ebmr10991997b3.8.1738795661725; Wed, 05 Feb 2025
 14:47:41 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 6 Feb 2025 07:47:06 +0900
X-Gm-Features: AWEUYZln0LzofGqBYQLduHYPAzqdMt6YJmHUVy3G0YsJgx6IFJq1SBw-ZiVTyU8
Message-ID: <CAODzB9q1DMso18zfiWJEN_8NMxkErSLHQyZamwSjoE1cjqngLA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Feb 2025 22:47:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17757

Hi!

It's this week's CVE report.

This week reported 22 new CVEs and 45 updated CVEs.

* New CVEs

CVE-2024-57948: mac802154: check local interfaces before deleting sdata list

Announce: https://lore.kernel.org/linux-cve-announce/2025013155-CVE-2024-57948-e07f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc7.

Fixed status
mainline: [eb09fbeb48709fe66c0d708aed81e910a577a30a]
stable/5.10: [98ea165a2ac240345c48b57c0a3d08bbcad02929]
stable/5.15: [80aee0bc0dbe253b6692d33e64455dc742fc52f1]
stable/5.4: [0d11dc30edfc4acef0acef130bb5ca596317190a]
stable/6.1: [41e4ca8acba39f1cecff2dfdf14ace4ee52c4272]
stable/6.6: [2e41e98c4e79edae338f2662dbdf74ac2245d183]

CVE-2025-21665: filemap: avoid truncating 64-bit offset to 32 bits

Announce: https://lore.kernel.org/linux-cve-announce/2025013157-CVE-2025-21665-d6a2@gregkh/

Introduced by commit 54fa39a ("iomap: use mapping_seek_hole_data") in v5.12-rc1.
Fixed in v6.13.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f505e6c91e7a22d10316665a86d79f84d9f0ba76]
stable/5.15: [64e5fd96330df2ad278d1c4edcca581f26e5f76e]
stable/6.1: [80fc836f3ebe2f2d2d2c80c698b7667974285a04]
stable/6.6: [09528bb1a4123e2a234eac2bc45a0e51e78dab43]

CVE-2025-21666: vsock: prevent null-ptr-deref in vsock_*[has_data|has_space]

Announce: https://lore.kernel.org/linux-cve-announce/2025013157-CVE-2025-21666-465a@gregkh/

Introduced by commit c0cfa2d ("vsock: add multi-transports support")
in v5.5-rc1.
Fixed in v6.13.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [91751e248256efc111e52e15115840c35d85abaf]
stable/5.10: [daeac89cdb03d30028186f5ff7dc26ec8fa843e7]
stable/5.15: [9e5fed46ccd2c34c5fa5a9c8825ce4823fdc853e]
stable/6.1: [b52e50dd4fabd12944172bd486a4f4853b7f74dd]
stable/6.6: [bc9c49341f9728c31fe248c5fbba32d2e81a092b]

CVE-2025-21667: iomap: avoid avoid truncating 64-bit offset to 32 bits

Announce: https://lore.kernel.org/linux-cve-announce/2025013158-CVE-2025-21667-a644@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc7.
It seems as if this bug was introduced by commit f43dc4dc ("iomap: buffered
write failure should not truncate the page cache") in 6.2-rc1.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [c13094b894de289514d84b8db56d1f2931a0bade]
stable/6.1: [7ca4bd6b754913910151acce00be093f03642725]
stable/6.6: [91371922704c8d82049ef7c2ad974d0a2cd1174d]

CVE-2025-21668: pmdomain: imx8mp-blk-ctrl: add missing loop break condition

Announce: https://lore.kernel.org/linux-cve-announce/2025013158-CVE-2025-21668-f82f@gregkh/

Introduced by commit 556f5cf ("soc: imx: add i.MX8MP HSIO blk-ctrl")
in v5.19-rc1.
Fixed in v6.13.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [726efa92e02b460811e8bc6990dd742f03b645ea]
stable/6.1: [699cc10cc3068f9097a506eae7fe178c860dca4e]
stable/6.6: [926ad31b76b8e229b412536e77cdf828a5cae9c6]

CVE-2025-21669: vsock/virtio: discard packets if the transport changes

Announce: https://lore.kernel.org/linux-cve-announce/2025013158-CVE-2025-21669-b52c@gregkh/

Introduced by commit c0cfa2d ("vsock: add multi-transports support")
in v5.5-rc1.
Fixed in v6.13.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2cb7c756f605ec02ffe562fb26828e4bcc5fdfc1]
stable/5.10: [18a7fc371d1dbf8deff16c2dd9292bcc73f43040]
stable/5.15: [6486915fa661584d70e8e7e4068c6c075c67dd6d]
stable/6.1: [88244163bc7e7b0ce9dd7bf4c8a563b41525c3ee]
stable/6.6: [d88b249e14bd0ee1e46bbe4f456e22e01b8c68de]

CVE-2025-21670: vsock/bpf: return early if transport is not assigned

Announce: https://lore.kernel.org/linux-cve-announce/2025013159-CVE-2025-21670-5d52@gregkh/

Introduced by commit 634f1a7 ("vsock: support sockmap") in v6.4-rc1.
Fixed in v6.13.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f6abafcd32f9cfc4b1a2f820ecea70773e26d423]
stable/6.6: [58e586c30d0b6f5dc0174a41026f2b0a48c9aab6]

CVE-2025-21671: zram: fix potential UAF of zram table

Announce: https://lore.kernel.org/linux-cve-announce/2025013159-CVE-2025-21671-c4b0@gregkh/


This bug was introduced by commit 74363ec ("zram: fix uninitialized ZRAM not
releasing backing device") in 6.13-rc4.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [212fe1c0df4a150fb6298db2cfff267ceaba5402]
stable/6.1: [fe3de867f94819ba0f28e035c0b0182150147d95]
stable/6.6: [571d3f6045cd3a6d9f6aec33b678f3ffe97582ef]

CVE-2025-21672: afs: Fix merge preference rule failure condition

Announce: https://lore.kernel.org/linux-cve-announce/2025013100-CVE-2025-21672-cd35@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc7.
It seems as if this bug was introduced by commit f94f70d ("afs: Provide a way
to configure address priorities") in 6.8-rc1.

Fixed status
mainline: [17a4fde81d3a7478d97d15304a6d61094a10c2e3]

CVE-2025-21673: smb: client: fix double free of TCP_Server_Info::hostname

Announce: https://lore.kernel.org/linux-cve-announce/2025013100-CVE-2025-21673-4465@gregkh/

Introduced by commit 7be3248 ("cifs: To match file servers, make sure
the server hostname matches") in v5.16-rc1.
Fixed in v6.13.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [fa2f9906a7b333ba757a7dbae0713d8a5396186e]
stable/6.6: [1ea68070338518a1d31ce71e6abfe1b30001b27a]

CVE-2025-21674: net/mlx5e: Fix inversion dependency warning while
enabling IPsec tunnel

Announce: https://lore.kernel.org/linux-cve-announce/2025013100-CVE-2025-21674-8b15@gregkh/

Introduced by commit 4c24272 ("net/mlx5e: Listen to ARP events to
update IPsec L2 headers in tunnel mode") in v6.4-rc1.
Fixed in v6.13.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c3688090f8a1f085230aa839cc63e4a7b977df0]
stable/6.6: [87c4417a902151cfe4363166245a3671a08c256c]

CVE-2025-21675: net/mlx5: Clear port select structure when fail to create

Announce: https://lore.kernel.org/linux-cve-announce/2025013101-CVE-2025-21675-bf0e@gregkh/

Introduced by commit dc48516 ("net/mlx5: Lag, add support to create
definers for LAG") in v5.16-rc1.
Fixed in v6.13.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5641e82cb55b4ecbc6366a499300917d2f3e6790]
stable/6.1: [efc92a260e23cf9fafb0b6f6c9beb6f8df93fab4]
stable/6.6: [473bc285378f49aa27e5b3e95a6d5ed12995d654]

CVE-2025-21676: net: fec: handle page_pool_dev_alloc_pages error

Announce: https://lore.kernel.org/linux-cve-announce/2025013101-CVE-2025-21676-3d08@gregkh/

Introduced by commit 95698ff ("net: fec: using page pool to manage RX
buffers") in v6.1-rc1.
Fixed in v6.13.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [001ba0902046cb6c352494df610718c0763e77a5]
stable/6.6: [8a0097db0544b658c159ac787319737712063a23]

CVE-2025-21677: pfcp: Destroy device along with udp socket's netns dismantle.

Announce: https://lore.kernel.org/linux-cve-announce/2025013101-CVE-2025-21677-093f@gregkh/

Introduced by commit 76c8764 ("pfcp: add PFCP module") in v6.10-rc1.
Fixed in v6.13.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ffc90e9ca61b0f619326a1417ff32efd6cc71ed2]

CVE-2025-21678: gtp: Destroy device along with udp socket's netns dismantle.

Announce: https://lore.kernel.org/linux-cve-announce/2025013102-CVE-2025-21678-42cb@gregkh/

Introduced by commit 459aa66 ("gtp: add initial driver for datapath of
GPRS Tunneling Protocol (GTP-U)") in v4.7-rc1.
Fixed in v6.13.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb28fd76c0a08a47b470677c6cef9dd1c60e92d1]
stable/5.10: [5f1678346109ff3a6d229d33437fcba3cce9209d]
stable/5.15: [036f8d814a2cd11ee8ef62b8f3e7ce5dec0ee4f3]
stable/5.4: [c986380c1d5274c4d5e935addc807d6791cc23eb]
stable/6.1: [efec287cbac92ac6ee8312a89221854760e13b34]
stable/6.6: [bb11f992f5a475bc68ef959f17a55306f0328495]

CVE-2025-21679: btrfs: add the missing error handling inside
get_canonical_dev_path

Announce: https://lore.kernel.org/linux-cve-announce/2025013102-CVE-2025-21679-f980@gregkh/


This bug was introduced by commit 7e06de7 ("btrfs: canonicalize the device path
before adding it") in 6.13-rc1.
Bug introduced commit was backported to following branches.
stable/6.12

Fixed status
mainline: [fe4de594f7a2e9bc49407de60fbd20809fad4192]

CVE-2025-21680: pktgen: Avoid out-of-bounds access in get_imix_entries

Announce: https://lore.kernel.org/linux-cve-announce/2025013102-CVE-2025-21680-c2d6@gregkh/

Introduced by commit 52a62f8 ("pktgen: Parse internet mix (imix)
input") in v5.15-rc1.
Fixed in v6.13.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [76201b5979768500bca362871db66d77cb4c225e]
stable/5.15: [3450092cc2d1c311c5ea92a2486daa2a33520ea5]
stable/6.1: [e5d24a7074dcd0c7e76b7e7e4efbbe7418d62486]
stable/6.6: [7cde21f52042aa2e29a654458166b873d2ae66b3]

CVE-2025-21681: openvswitch: fix lockup on tx to unregistering netdev
with carrier

Announce: https://lore.kernel.org/linux-cve-announce/2025013103-CVE-2025-21681-ed9d@gregkh/

Introduced by commit 066b867 ("net: openvswitch: fix race on port
output") in v6.3-rc7.
Fixed in v6.13.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [47e55e4b410f7d552e43011baa5be1aab4093990]
stable/6.1: [ea9e990356b7bee95440ba0e6e83cc4d701afaca]
stable/6.6: [ea966b6698785fb9cd0fdb867acd91b222e4723f]

CVE-2025-21682: eth: bnxt: always recalculate features after XDP
clearing, fix null-deref

Announce: https://lore.kernel.org/linux-cve-announce/2025013103-CVE-2025-21682-ccfd@gregkh/

Introduced by commit 1054aee ("bnxt_en: Use NETIF_F_GRO_HW.") in v4.16-rc1.
Introduced by commit 98ba1d9 ("bnxt_en: Fix RSS logic in
__bnxt_reserve_rings()") in v6.11-rc2.
Fixed in v6.13.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0aa6a37a3dbb40b272df5fc6db93c114688adcd]

CVE-2025-21683: bpf: Fix bpf_sk_select_reuseport() memory leak

Announce: https://lore.kernel.org/linux-cve-announce/2025013103-CVE-2025-21683-c0d4@gregkh/

Introduced by commit 64d8529 ("bpf: Allow bpf_map_lookup_elem for
SOCKMAP and SOCKHASH") in v5.8-rc1.
Fixed in v6.13.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b3af60928ab9129befa65e6df0310d27300942bf]
stable/5.10: [bb36838dac7bb334a3f3d7eb29875593ec9473fc]
stable/5.15: [0ab52a8ca6e156a64c51b5e7456cac9a0ebfd9bf]
stable/6.1: [d0a3b3d1176d39218b8edb2a2d03164942ab9ccd]
stable/6.6: [b02e70be498b138e9c21701c2f33f4018ca7cd5e]

CVE-2023-52924: netfilter: nf_tables: don't skip expired elements during walk

Announce: https://lore.kernel.org/linux-cve-announce/2025020500-CVE-2023-52924-03d7@gregkh/

Introduced by commit 3c4287f ("nf_tables: Add set type for arbitrary
concatenation of ranges") in v5.6-rc1.
Introduced by commit 8d8540c ("netfilter: nft_set_rbtree: add timeout
support") in v4.18-rc1.
Introduced by commit 9d09829 ("netfilter: nft_hash: add support for
timeouts") in v4.1-rc1.
Fixed in v6.5-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [24138933b97b055d486e8064b4a1721702442a9b]
stable/4.19: [94313a196b44184b5b52c1876da6a537701b425a]
stable/5.10: [b15ea4017af82011dd55225ce77cce3d4dfc169c]
stable/5.15: [7c7e658a36f8b1522bd3586d8137e5f93a25ddc5]
stable/5.4: [1da4874d05da1526b11b82fc7f3c7ac38749ddf8]
stable/6.1: [59dab3bf0b8fc08eb802721c0532f13dd89209b8]

CVE-2023-52925: netfilter: nf_tables: don't fail inserts if duplicate
has expired

Announce: https://lore.kernel.org/linux-cve-announce/2025020502-CVE-2023-52925-0b0e@gregkh/

Introduced by commit 2413893 ("netfilter: nf_tables: don't skip expired elements
during walk") in 6.5-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7845914f45f066497ac75b30c50dbc735e84e884]
stable/5.10: [891ca5dfe3b718b441fc786014a7ba8f517da188]
stable/5.15: [af78b0489e8898a8c9449ffc0fdd2e181916f0d4]
stable/6.1: [59ee68c437c562170265194a99698c805a686bb3]

* Updated CVEs

CVE-2024-23307: Integer Overflow bug was found md/raid/raid5 modules

stable/5.10 was fixed.

Fixed status
stable/5.10: [66de7a2541d8ed4e404755f1dd76edf43da7da94]
stable/5.15: [203f38eb72f2fb8b353338cc9ffe45ae3b9bbc65]
stable/6.1: [9477cfeb300823461b44223a7d5fac26a31df4fe]
stable/6.6: [8ec4a68a25a231e2303716a0aba8ff1413d47c87]
stable/6.7: [1191f9391105e49115715e55030476849f6f6da5]
stable/6.8: [83dcc4e850c69ca569e1b0f1484910e6a68b2d78]

CVE-2024-35966: Bluetooth: RFCOMM: Fix not validating setsockopt user input

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [d072ea24748189cd8f4a9c3f585ca9af073a0838]
stable/5.15: [00767fbd67af70d7a550caa5b12d9515fa978bab]
stable/6.1: [eea40d33bf936a5c7fb03c190e61e0cfee00e872]
stable/6.6: [4ea65e2095e9bd151d0469328dd7fc2858feb546]
stable/6.8: [c3f787a3eafe519c93df9abbb0ca5145861c8d0f]

CVE-2024-35967: Bluetooth: SCO: Fix not validating setsockopt user input

stable/5.15 was fixed.

Fixed status
stable/5.10: [b0e30c37695b614bee69187f86eaf250e36606ce]
stable/5.15: [2c2dc87cdebef3fe3b9d7a711a984c70e376e32e]
stable/6.1: [7bc65d23ba20dcd7ecc094a12c181e594e5eb315]
stable/6.6: [72473db90900da970a16ee50ad23c2c38d107d8c]
stable/6.8: [419a0ffca7010216f0fc265b08558d7394fa0ba7]

CVE-2024-36899: gpiolib: cdev: Fix use after free in lineinfo_changed_notify

stable/5.10 was fixed.

Fixed status
stable/5.10: [2dfbb920a89bdc58087672ad5325dc6c588b6860]
stable/5.15: [2d008d4961b039d2edce8976289773961b7e5fb5]
stable/6.1: [d38c49f7bdf14381270736299e2ff68ec248a017]
stable/6.6: [95ca7c90eaf5ea8a8460536535101e3e81160e2a]

CVE-2024-38591: RDMA/hns: Fix deadlock on SRQ async events.

stable/5.10 was fixed.

Fixed status
stable/5.10: [605889754ee68aacf7c381938fcd5eb654e71822]
stable/5.15: [4a3be1a0ffe04c085dd7f79be97c91b0c786df3d]
stable/6.1: [756ddbe665ea7f9416951bd76731b174d136eea0]
stable/6.6: [22c915af31bd84ffaa46145e317f53333f94a868]
stable/6.9: [d271e66abac5c7eb8de345b9b44d89f777437a4c]

CVE-2024-41060: drm/radeon: check bo_va->bo is non-NULL before using it

stable/5.10 was fixed.

Fixed status
stable/5.10: [e8d3c53c6f1cccea9c03113f06dd39521c228831]
stable/5.15: [a2b201f83971df03c8e81a480b2f2846ae8ce1a3]
stable/6.1: [a9100f17428cb733c4f6fbb132d98bed76318342]
stable/6.6: [f13c96e0e325a057c03f8a47734adb360e112efe]

CVE-2024-44940: fou: remove warn in gue_gro_receive on unsupported protocol

stable/5.10 was fixed.

Fixed status
stable/5.10: [a925a200299a6dfc7c172f54da6f374edc930053]
stable/5.15: [b1453a5616c7bd8acd90633ceba4e59105ba3b51]
stable/6.1: [5a2e37bc648a2503bf6d687aed27b9f4455d82eb]
stable/6.10: [440ab7f97261bc28501636a13998e1b1946d2e79]
stable/6.6: [3db4395332e7050ef9ddeb3052e6b5019f2a2a59]

CVE-2024-47707: ipv6: avoid possible NULL deref in rt6_uncached_list_flush_dev()

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [8a8b83016f06805775db099c8377024b6fa5b975]
stable/5.15: [e43dd28405e6b9935279996725ee11e6306547a5]
stable/5.4: [a61a174280dad99f25a7dee920310885daf2552b]
stable/6.1: [f2bd9635543ca41533b870f420872819f8331823]
stable/6.11: [08409e401622e2896b4313be9f781bde8a2a6a53]
stable/6.6: [0ceb2f2b5c813f932d6e60d3feec5e7e713da783]

CVE-2024-49884: ext4: fix slab-use-after-free in ext4_split_extent_at()

stable/5.4 was fixed.

Fixed status
cip/4.4: [e6bc59e0c89e7230d3ff32ce9ca8ab99082b7189]
cip/4.4-rt: [e6bc59e0c89e7230d3ff32ce9ca8ab99082b7189]
cip/4.4-st: [e6bc59e0c89e7230d3ff32ce9ca8ab99082b7189]
stable/4.19: [393a46f60ea4f249dc9d496d4eb2d542f5e11ade]
stable/5.10: [e52f933598b781d291b9297e39c463536da0e185]
stable/5.15: [cafcc1bd62934547c76abf46c6d0d54f135006fe]
stable/5.4: [448100a29395b0c8b4c42967155849fe0fbe808f]
stable/6.1: [a5401d4c3e2a3d25643c567d26e6de327774a2c9]
stable/6.11: [915ac3630488af0ca194dc63b86d99802b4f6e18]
stable/6.6: [8fe117790b37c84c651e2bad9efc0e7fda73c0e3]

CVE-2024-49936: net/xen-netback: prevent UAF in xenvif_flush_hash()

stable/5.4 was fixed.

Fixed status
stable/5.10: [a7f0073fcd12ed7de185ef2c0af9d0fa1ddef22c]
stable/5.15: [a0465723b8581cad27164c9073fd780904cd22d4]
stable/5.4: [3c4423b0c4b98213b3438e15061e1d08220e6982]
stable/6.1: [efcff6ce7467f01f0753609f420333f3f2ceceda]
stable/6.11: [54d8639af5568fc41c0e274fc3ec9cf86c59fcbb]
stable/6.6: [143edf098b80669d05245b2f2367dd156a83a2c5]

CVE-2024-49994: block: fix integer overflow in BLKSECDISCARD

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [8476f8428e8b48fd7a0e4258fa2a96a8f4468239]
stable/6.11: [6c9915fa9410cbb9bd75ee283c03120046c56d3d]
stable/6.6: [a99bacb35c1416355eef957560e8fcac3a665549]

CVE-2024-50009: cpufreq: amd-pstate: add check for cpufreq_cpu_get's
return value

stable/6.6 was fixed.

Fixed status
stable/6.11: [5f250d44b8191d612355dd97b89b37bbc1b5d2cb]
stable/6.6: [cd9f7bf6cad8b2d3876105ce3c9fc63460a046f6]

CVE-2024-50014: ext4: fix access to uninitialised lock in fc replay path

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [13ea9547763a0488a90ff37cdf52ec85e36ea344]
stable/6.11: [b002031d585a14eed511117dda8c6452a804d508]
stable/6.6: [6e35f560daebe40264c95e9a1ab03110d4997df6]

CVE-2024-50047: smb: client: fix UAF in async decryption

stable/6.1 was fixed.

Fixed status
stable/6.1: [bce966530fd5542bbb422cb45ecb775f7a1a6bc3]
stable/6.11: [538c26d9bf70c90edc460d18c81008a4e555925a]
stable/6.6: [0809fb86ad13b29e1d6d491364fc7ea4fb545995]

CVE-2024-50157: RDMA/bnxt_re: Avoid CPU lockups due fifo occupancy check loop

stable/6.6 was fixed.

Fixed status
stable/6.11: [2fb6b2e82413e401b72dfeacd7a60416fcfc5b41]
stable/6.6: [7998e7efd1d557af118ac96f48ebc569b929b555]

CVE-2024-50242: fs/ntfs3: Additional check in ntfs_file_release

stable/5.15 was fixed.

Fixed status
stable/5.15: [542532afe249588ae88d8409d4bf861c315f8862]
stable/6.1: [d1ac7e2620302e3e49573df39bd4e868e8b4962a]
stable/6.11: [82685eb6ca1db2bd11190451085bcb86ed03aa24]
stable/6.6: [550ef40fa6366d5d11b122e5f36b1f9aa20c087e]

CVE-2024-50304: ipv4: ip_tunnel: Fix suspicious RCU usage warning in
ip_tunnel_find()

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [31bd7378c6fe100a8af0e996ea0b5dafd3579df6]
stable/5.15: [6ac5dfa575136da8dd8a9e7c1437c41f3a593993]
stable/6.1: [ce11424026cbf87d5861b09e5e33565ff7f2ec8d]
stable/6.11: [f20fe2cfe06ca1b008b09da4f2b4e0c5547ccef6]
stable/6.6: [e0500e4373cd3d5eace1f1712444ab830b82c114]

CVE-2024-53124: net: fix data-races around sk->sk_forward_alloc

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [fe2c0bd6d1e29ccefdc978b9a290571c93c27473]
stable/5.15: [c3d052cae566ec2285f5999958a5deb415a0f59e]
stable/5.4: [695fb0b9aecfd5dd5b2946ba8897ac2c1eef654d]
stable/6.1: [be7c61ea5f816168c38955eb4e898adc8b4b32fd]
stable/6.11: [d285eb9d0641c8344f2836081b4ccb7b3c5cc1b6]
stable/6.6: [3f51f8c9d28954cf380100883a02eed35a8277e9]

CVE-2024-53185: smb: client: fix NULL ptr deref in crypto_aead_setkey()

stable/6.1 was fixed.

Fixed status
stable/6.1: [44c495818d9c4a741ab9e6bc9203ccc9f55f6f40]
stable/6.12: [9b8904b53b5ace0519c74cd89fc3ca763f3856d4]
stable/6.6: [46f8e25926817272ec8d5bfbd003569bdeb9a8c8]

CVE-2024-53685: ceph: give up on paths longer than PATH_MAX

stable/5.10 was fixed.

Fixed status
stable/5.10: [0f2b2d9e881c90402dbe28f9ba831775b7992e1f]
stable/5.15: [d42ad3f161a5a487f81915c406f46943c7187a0a]
stable/6.1: [e4b168c64da06954be5d520f6c16469b1cadc069]
stable/6.12: [99a37ab76a315c8307eb5b0dc095d8ad9d8efeaa]
stable/6.6: [c47ed91156daf328601d02b58d52d9804da54108]

CVE-2024-56631: scsi: sg: Fix slab-use-after-free read in sg_release()

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [285ce1f89f8d414e7eecab5ef5118cd512596318]
stable/5.15: [198b89dd5a595ee3f96e5ce5c448b0484cd0e53c]
stable/5.4: [e19acb1926c4a1f30ee1ec84d8afba2d975bd534]
stable/6.1: [275b8347e21ab8193e93223a8394a806e4ba8918]
stable/6.12: [1f5e2f1ca5875728fcf62bc1a054707444ab4960]
stable/6.6: [59b30afa578637169e2819536bb66459fdddc39d]

CVE-2024-56672: blk-cgroup: Fix UAF in blkcg_unpin_online()

stable/5.10 was fixed.

Fixed status
stable/5.10: [83f5a87ee8caa76a917f59912a74d6811f773c67]
stable/5.15: [8a07350fe070017a887433f4d6909433955be5f1]
stable/6.1: [64afc6fe24c9896c0153e5a199bcea241ecb0d5c]
stable/6.12: [29d1e06560f0f6179062ac638b4064deb637d1ad]
stable/6.6: [5baa28569c924d9a90d036c2aaab79f791fedaf8]

CVE-2024-56703: ipv6: Fix soft lockups in fib6_select_path under high
next hop churn

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [d0ec61c9f3583b76aebdbb271f5c0d3fcccd48b2]
stable/6.12: [34a949e7a0869dfa31a40416d2a56973fae1807b]
stable/6.6: [52da02521ede55fb86546c3fffd9377b3261b91f]

CVE-2024-57887: drm: adv7511: Fix use-after-free in adv7533_attach_dsi()

stable/5.10 was fixed.

Fixed status
stable/5.10: [acec80d9f126cd3fa764bbe3d96bc0cb5cd2b087]
stable/6.1: [d208571943ffddc438a7ce533d5d0b9219806242]
stable/6.12: [ca9d077350fa21897de8bf64cba23b198740aab5]
stable/6.6: [1f49aaf55652580ae63ab83d67211fe6a55d83dc]

CVE-2024-57892: ocfs2: fix slab-use-after-free due to dangling pointer dqi_priv

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [8ff6f635a08c30559ded0c110c7ce03ba7747d11]
stable/5.15: [f44e6d70c100614c211703f065cad448050e4a0e]
stable/5.4: [58f9e20e2a7602e1dd649a1ec4790077c251cb6c]
stable/6.1: [2d431192486367eee03cc28d0b53b97dafcb8e63]
stable/6.12: [ba950a02d8d23811aa1120affd3adedcfac6153d]
stable/6.6: [2e3d203b1adede46bbba049e497765d67865be18]

CVE-2024-57904: iio: adc: at91: call input_free_device() on allocated iio_dev

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [ac8d932e3214c10ec641ad45a253929a596ead62]
stable/5.15: [028a1ba8e3bae593d701aee4f690ce7c195b67d6]
stable/5.4: [b549c90bfe66f704878aa1e57b30ba15dab71935]
stable/6.1: [25ef52f1c15db67d890b80203a911b9a57b0bf71]
stable/6.12: [d115b7f3ddc03b38bb7e8754601556fe9b4fc034]
stable/6.6: [09e067e3c83e0695d338e8a26916e3c2bc44be02]

CVE-2024-57906: iio: adc: ti-ads8688: fix information leak in triggered buffer

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [3bf8d1e87939b8a19c9b738564fddf5b73322f2f]
stable/5.15: [aae96738006840533cf147ffd5f41830987f21c5]
stable/5.4: [1c80a0985a9a14f33dbf63cd703ca010f094f878]
stable/6.1: [ebe2672bc42a0dfe31bb539f8ce79d024aa7e46d]
stable/6.12: [485570ed82b7a6bb109fa1d0a79998e21f7f4c73]
stable/6.6: [455df95eb8f24a37abc549d6738fc8ee07eb623b]

CVE-2024-57907: iio: adc: rockchip_saradc: fix information leak in
triggered buffer

stable/5.10 was fixed.

Fixed status
stable/5.10: [85a9c98a5e0f22d911b00077d751e34fff1401aa]
stable/5.15: [7a07fb80ea886e9134284a27d0155cca7649e293]
stable/6.1: [64b79afdca7b27a768c7d3716b7f4deb1d6b955c]
stable/6.12: [8193941bc4fe7247ff13233f328aea709f574554]
stable/6.6: [5a95fbbecec7a34bbad5dcc3156700b8711d53c4]

CVE-2024-57908: iio: imu: kmx61: fix information leak in triggered buffer

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [a386d9d2dc6635f2ec210b8199cfb3acf4d31305]
stable/5.15: [a07f698084412a3ef5e950fcac1d6b0f53289efd]
stable/5.4: [0871eb8d700b33dd7fa86c80630d62ddaef58c2c]
stable/6.1: [6985ba4467e4b15b809043fa7740d1fb23a1897b]
stable/6.12: [565814cbbaa674d2901428796801de49a611e59d]
stable/6.6: [cde312e257b59ecaa0fad3af9ec7e2370bb24639]

CVE-2024-57910: iio: light: vcnl4035: fix information leak in triggered buffer

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [b0e9c11c762e4286732d80e66c08c2cb3157b06b]
stable/5.15: [cb488706cdec0d6d13f2895bcdf0c32b283a7cc7]
stable/5.4: [13e56229fc81051a42731046e200493c4a7c28ff]
stable/6.1: [47d245be86492974db3aeb048609542167f56518]
stable/6.12: [f6fb1c59776b4263634c472a5be8204c906ffc2c]
stable/6.6: [a15ea87d4337479c9446b5d71616f4668337afed]

CVE-2024-57911: iio: dummy: iio_simply_dummy_buffer: fix information
leak in triggered buffer

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [e1c1e8c05010103c9c9ea3e9c4304b0b7e2c8e4a]
stable/5.15: [006073761888a632c5d6f93e47c41760fa627f77]
stable/5.4: [03fa47621bf8fcbf5994c5716021527853f9af3d]
stable/6.1: [b0642d9c871aea1f28eb02cd84d60434df594f67]
stable/6.12: [ea703cda36da0dacb9a2fd876370003197d8a019]
stable/6.6: [74058395b2c63c8a438cf199d09094b640f8c7f4]

CVE-2024-57912: iio: pressure: zpa2326: fix information leak in triggered buffer

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [d25f1fc273670271412a52a1efbdaf5dcf274ed8]
stable/5.15: [64a989aa7475b8e76e69b9ec86819ea293e53bab]
stable/5.4: [9629ff1a86823269b12fb1ba9ca4efa945906287]
stable/6.1: [b7849f62e61242e0e02c776e1109eb81e59c567c]
stable/6.12: [979a0db76ceda8fe1f2f85a116bfe97620ebbadf]
stable/6.6: [fefb88a4da961a0b9c2473cbdcfce1a942fcfa9a]

CVE-2024-57913: usb: gadget: f_fs: Remove WARN_ON in functionfs_bind

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [3e4d32cc145955d5c56c5498a3ff057e4aafa9d1]
stable/5.15: [19fc1c83454ca9d5699e39633ec79ce26355251c]
stable/5.4: [bfe60030fcd976e3546e1f73d6d0eb3fea26442e]
stable/6.1: [82f60f3600aecd9ffcd0fbc4e193694511c85b47]
stable/6.12: [a8b6a18b9b66cc4c016d63132b59ce5383f7cdd2]
stable/6.6: [ea6a1498742430eb2effce0d1439ff29ef37dd7d]

CVE-2024-57915: usb: gadget: u_serial: Disable ep before setting port
to null to fix the crash caused by port being null

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [1062b648bff63ed62b2d47a045e08ea9741d98ea]
stable/5.15: [d2de56cc45ee447f005d63217e84988b4f02faa9]
stable/5.4: [f5f33fb57aae12e4b0add79e0242f458ea0bc510]
stable/6.1: [3d730e8758c75b68a0152ee1ac48a270ea6725b4]
stable/6.12: [8e122d780a0f19aefd700dbd0b0e3ed3af0ae97f]
stable/6.6: [0c50f00cc29948184af05bda31392fff5821f4f3]

CVE-2024-57922: drm/amd/display: Add check for granularity in dml
ceil/floor helpers

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [497471baf53bb8fd3cd1529d65d4d7f7b81f1917]
stable/5.15: [95793f9684e58d2aa56671b2d616b4f9f577a0a8]
stable/5.4: [8a9315e6f7b2d94c65a1ba476481deddb20fc3ae]
stable/6.1: [f3d1e4062ef251fa55ccfeca1e54a98b6818b3a1]
stable/6.12: [4f0dd09ed3001725ffd8cdc2868e71df585392fe]
stable/6.6: [ae9ab63a268be99a27a4720ca24f6be801744fee]

CVE-2024-57929: dm array: fix releasing a faulty array block twice in
dm_array_cursor_end

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [fc1ef07c3522e257e32702954f265debbcb096a7]
stable/5.15: [738994872d77e189b2d13c501a1d145e95d98f46]
stable/5.4: [9c7c03d0e926762adf3a3a0ba86156fb5e19538b]
stable/6.1: [e477021d252c007f0c6d45b5d13d341efed03979]
stable/6.12: [017c4470bff53585370028fec9341247bad358ff]
stable/6.6: [6002bec5354f86d1a2df21468f68e3ec03ede9da]

CVE-2024-57939: riscv: Fix sleeping in invalid context in die()

stable/5.10 was fixed.

Fixed status
stable/5.10: [8c38baa03ac8e18140faf36a3b955d30cad48e74]
stable/5.15: [10c24df2e303f517fab0359392c11b6b1d553f2b]
stable/6.1: [c21df31fc2a4afc02a6e56511364e9e793ea92ec]
stable/6.12: [76ab0afcdbe8c9685b589016ee1c0e25fe596707]
stable/6.6: [f48f060a4b36b5e96628f6c3fb1540f1e8dedb69]

CVE-2024-57940: exfat: fix the infinite loop in exfat_readdir()

stable/5.10 was fixed.

Fixed status
stable/5.10: [d8cfbb8723bd3d3222f360227a1cc15227189ca6]
stable/5.15: [28c21f0ac5293a4bf19b3e0e32005d6dd31a6c17]
stable/6.1: [31beabd0f47f8c3ed9965ba861c9e5b252d4920a]
stable/6.12: [d9ea94f5cd117d56e573696d0045ab3044185a15]
stable/6.6: [dc1d7afceb982e8f666e70a582e6b5aa806de063]

CVE-2025-21638: sctp: sysctl: auth_enable: avoid using current->nsproxy

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [dc583e7e5f8515ca489c0df28e4362a70eade382]
stable/5.15: [bd2a2939423566c654545fa3e96a656662a0af9e]
stable/5.4: [10c869a52f266e40f548cc3c565d14930a5edafc]
stable/6.1: [1b67030d39f2b00f94ac1f0af11ba6657589e4d3]
stable/6.12: [c184bc621e3cef03ac9ba81a50dda2dae6a21d36]
stable/6.6: [7ec30c54f339c640aa7e49d7e9f7bbed6bd42bf6]

CVE-2025-21639: sctp: sysctl: rto_min/max: avoid using current->nsproxy

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [246428bfb9e7db15c5cd08e1d0eca41b65af2b06]
stable/5.15: [0f78f09466744589e420935e646ae78212a38290]
stable/5.4: [c8d179f3b1c1d60bf4484f50aa67b4c70f91bff9]
stable/6.1: [4059507e34aa5fe0fa9fd5b2b5f0c8b26ab2d482]
stable/6.12: [c87f1f6ade56c711f8736901e330685b453e420e]
stable/6.6: [dc9d0e3cfd16f66fbf0862857c6b391c8613ca9f]

CVE-2025-21640: sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [03ca51faba2b017bf6c90e139434c4117d0afcdc]
stable/5.15: [86ddf8118123cb58a0fb8724cad6979c4069065b]
stable/5.4: [1031462a944ba0fa83c25ab1111465f8345b5589]
stable/6.1: [3cd0659deb9c03535fd61839e91d4d4d3e51ac71]
stable/6.12: [f0bb3935470684306e4e04793a20ac4c4b08de0b]
stable/6.6: [ad673e514b2793b8d5902f6ba6ab7e890dea23d5]

CVE-2025-21646: afs: Fix the maximum cell name length

stable/5.10 was fixed.

Fixed status
stable/5.10: [9340385468d056bb700b8f28df236b81fc86a079]
stable/5.15: [7cb3e77e9b4e6ffa325a5559393d3283c9af3d01]
stable/6.1: [aabe47cf5ac5e1db2ae0635f189d836f67024904]
stable/6.12: [7922b1f058fe24a93730511dd0ae2e1630920096]
stable/6.6: [7673030efe0f8ca1056d3849d61784c6caa052af]

CVE-2025-21648: netfilter: conntrack: clamp maximum hashtable size to INT_MAX

stable/5.10 was fixed.

Fixed status
stable/5.10: [a965f7f0ea3ae61b9165bed619d5d6da02c75f80]
stable/5.15: [b1b2353d768f1b80cd7fe045a70adee576b9b338]
stable/6.1: [5552b4fd44be3393b930434a7845d8d95a2a3c33]
stable/6.12: [f559357d035877b9d0dcd273e0ff83e18e1d46aa]
stable/6.6: [d5807dd1328bbc86e059c5de80d1bbee9d58ca3d]

CVE-2025-21653: net_sched: cls_flow: validate TCA_FLOW_RSHIFT attribute

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [43658e4a5f2770ad94e93362885ff51c10cf3179]
stable/5.15: [a313d6e6d5f3a631cae5a241c392c28868aa5c5e]
stable/5.4: [9858f4afeb2e59506e714176bd3e135539a3eeec]
stable/6.1: [2011749ca96460386844dfc7e0fde53ebee96f3c]
stable/6.12: [6fde663f7321418996645ee602a473457640542f]
stable/6.6: [e54beb9aed2a90dddf4c5d68fcfc9a01f3e40a61]

CVE-2025-21664: dm thin: make get_first_thin use rcu-safe list first function

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [cd30a3960433ec2db94b3689752fa3c5df44d649]
stable/5.15: [802666a40c71a23542c43a3f87e3a2d0f4e8fe45]
stable/5.4: [ec037fe8c0d0f6140e3d8a49c7b29cb5582160b8]
stable/6.1: [12771050b6d059eea096993bf2001da9da9fddff]
stable/6.12: [cbd0d5ecfa390ac29c5380200147d09c381b2ac6]
stable/6.6: [6b305e98de0d225ccebfb225730a9f560d28ecb0]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com


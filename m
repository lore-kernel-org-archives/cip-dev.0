Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB70C36018
	for <webhook@archiver.kernel.org>; Wed,  2 Apr 2025 23:02:46 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
 by mx.groups.io with SMTP id smtpd.web11.684.1743634961410563366
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Apr 2025 16:02:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=xbZH+oMl;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.182, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6fee63b9139so3237067b3.1
        for <cip-dev@lists.cip-project.org>; Wed, 02 Apr 2025 16:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1743634960; x=1744239760; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XKu5nkSUR9sKmnWfb9E2GY1fYbeOtR5SzzyUqi2jYdI=;
        b=xbZH+oMlnhkUuNkrBJgS2c+vCTE/T5MsQka9f3LPTZHPSXpVPZbPCSZxTC9tsNz07y
         +VocUS2GbUj//IdOQjav5SyWlj6P+L80FzGuY17dlkNQNu80Qt9zdgkme6Pdlqq9dqaW
         XDcoMBVgT9OLQzb9x1KVj6nGJYaooe6SDR1KLzV2tpaziFWuiK4oG6PFJjNXUl7dgjTz
         Q0cLlVfiao5ytfdQTZI9Nm+/0m5E+vcnR4tZLSkGu8yxyhZGLDdpZAzLU9qgISCU2A4K
         gJ573YA5utnOPpy1rqqpLxfbkHLp6IEIKDVGtlGYqbFAOjHCQs+ZFVAFpNQKPLst3uuM
         EDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743634960; x=1744239760;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XKu5nkSUR9sKmnWfb9E2GY1fYbeOtR5SzzyUqi2jYdI=;
        b=r4AwGbaQpvCyy8UEsEurNGlMmCvUbzSY4dpumlObOuqzUaMLquYI/7B2awaQSDLNv9
         T8AZgxtYSGpUMd/g/CYDkvvemwCM3wTE3CIEP8pOm7n2mouPD0FgshK6aAAF79h2ae2w
         JlWke4pBPpX7ktvvcnOFlBTOr0wKSQnNj8pE2oBtepV15kYiCv8Gru+6L1utte2weHUJ
         MgKW+ZuyDs2t8muUAxCiI0N6Chqs8rbtw33UgPnY9MLKSkeFNRYZ+lOpq1kMbeDdJH6k
         wpg1vn8FFGxKmX4aI1QlYdpo6Y8eC1KjkNbLTYKIGo/IO8Vk7H0pSLrdhQKrQY/p+bhI
         gwrg==
X-Gm-Message-State: AOJu0Yxd2f3dtLkQPpC166HxQ6W+Q1FesHAeFKyGJn6rY6rf+nlgGQR0
	Hph8gbLgpBabGG4ESYvk53YUl8+nx6iEO++nDFe54txae2IMBUuN/icuobttEGW2/1JpStHSyAb
	SiaVDEy/VwkymuFYlW2LryhPthiQEH0J9uuGCVzM4jJ6xqn0qdPA=
X-Gm-Gg: ASbGncsrIYHu+PU0Ugp+FM+auMFZwjI4uX266ZtJAAq/4h/EozGiDq/fnBIH4TB2y/8
	7ZMmmehPzk195XeH5HjHZN64p6H9c1BVCoqJLHHUoCPrt2C36q9pbPknnVDMStimtuI4znsG8uT
	woM4/mLootEkb8emX5bZUdip3Fg6I=
X-Google-Smtp-Source: AGHT+IF+O1A7bMEk0byWk9IoqVNpD+ZR4RYMF78o27jHswC8RjDnRmfZt4Flh28wkxRs2z8PQ8NAbmlFTx4oicLQ3MQ=
X-Received: by 2002:a05:690c:46ca:b0:6f9:47ad:f5f1 with SMTP id
 00721157ae682-703ce2417d0mr23231097b3.17.1743634957281; Wed, 02 Apr 2025
 16:02:37 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 3 Apr 2025 08:02:00 +0900
X-Gm-Features: ATxdqUFpzuV-0-AvCC3VHw63AXap9uV3OsAufRhdsaUtFYVdMmzpfK7WN0EQPoQ
Message-ID: <CAODzB9oCWdGfHLZ5cJ==HQSOAY9hWCDwS=2is9h-seBDyK5P9Q@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Apr 2025 23:02:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18457

Hi!

It's this week's CVE report.

This week reported 231 new CVEs and 8 updated CVEs.

* New CVEs
CVE-2021-4454: can: j1939: fix errant WARN_ON_ONCE in j1939_session_deactivate

Announce: https://lore.kernel.org/linux-cve-announce/2025032716-CVE-2021-4454-f4a4@gregkh/

Introduced by commit 0c71437 ("can: j1939: j1939_session_deactivate():
clarify lifetime of session object") in v5.14-rc4.
Fixed in v6.2-rc7.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [d0553680f94c49bbe0e39eb50d033ba563b4212d]
stable/5.10: [b6d44072117bba057d50f7a2f96e5d070c65926d]
stable/5.15: [9ab896775f98ff54b68512f345eed178bf961084]
stable/5.4: [6950df42a03c9ac9290503ced3f371199cb68fa9]
stable/6.1: [1740a1e45eee65099a92fb502e1e67e63aad277d]

CVE-2022-49738: f2fs: fix to do sanity check on i_extra_isize in is_alive()

Announce: https://lore.kernel.org/linux-cve-announce/2025032756-CVE-2022-49738-c2ef@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc1.
It seems as if this bug was introduced by commit c6ad7fd1 ("f2fs: fix to do
sanity check on summary info") in 6.1-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15 stable/5.4

Fixed status
mainline: [d3b7b4afd6b2c344eabf9cc26b8bfa903c164c7c]
stable/5.10: [914e38f02a490dafd980ff0f39cccedc074deb29]
stable/5.15: [97ccfffcc061e54ce87e4a51a40e2e9cb0b7076a]
stable/5.4: [e5142a4935c1f15841d06047b8130078fc4d7b8f]
stable/6.1: [5b25035fb888cb2f78bf0b9c9f95b1dc54480d36]

CVE-2022-49739: gfs2: Always check inode size of inline inodes

Announce: https://lore.kernel.org/linux-cve-announce/2025032756-CVE-2022-49739-a93e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [45df749f827c286adbc951f2a4865b67f0442ba9]
mainline: [70376c7ff31221f1d21db5611d8209e677781d3a]
stable/4.19: [45df749f827c286adbc951f2a4865b67f0442ba9]
stable/5.10: [7c414f6f06e9a3934901b6edc3177ae5a1e07094]
stable/5.15: [46c9088cabd4d0469fdb61ac2a9c5003057fe94d]
stable/5.4: [4d4cb76636134bf9a0c9c3432dae936f99954586]
stable/6.1: [d458a0984429c2d47e60254f5bc4119cbafe83a2]

CVE-2022-49740: wifi: brcmfmac: Check the count value of channel spec
to prevent out-of-bounds reads

Announce: https://lore.kernel.org/linux-cve-announce/2025032757-CVE-2022-49740-7f6e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc1.


Fixed status
mainline: [4920ab131b2dbae7464b72bdcac465d070254209]
stable/5.10: [b2e412879595821ff1b5545cbed5f108fba7f5b6]
stable/5.15: [e4991910f15013db72f6ec0db7038ea67a57052e]
stable/5.4: [9cf5e99c1ae1a85286a76c9a970202750538394c]
stable/6.1: [f06de1bb6d61f0c18b0213bbc6298960037f9d42]

CVE-2022-49741: fbdev: smscufx: fix error handling code in ufx_usb_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025032757-CVE-2022-49741-65a7@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc1.


Fixed status
mainline: [b76449ee75e21acfe9fa4c653d8598f191ed7d68]
stable/5.10: [3931014367ef31d26af65386a4ca496f50f0cfdf]
stable/5.15: [64fa364ad3245508d393e16ed4886f92d7eb423c]
stable/5.4: [3b3d3127f5b4291ae4caaf50f7b66089ad600480]
stable/6.1: [1b4c08844628dfc8d72d3f51b657f2a5e63b7b4b]

CVE-2022-49742: f2fs: initialize locks earlier in f2fs_fill_super()

Announce: https://lore.kernel.org/linux-cve-announce/2025032757-CVE-2022-49742-e3d5@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc1.


Fixed status
mainline: [92b4cf5b48955a4bdd15fe4e2067db8ebd87f04c]
stable/6.1: [ddeff03bb33810fcf2f0c18e03d099cf0aacda62]

CVE-2022-49743: ovl: Use "buf" flexible array for memcpy() destination

Announce: https://lore.kernel.org/linux-cve-announce/2025032758-CVE-2022-49743-a049@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc1.
It seems as if this bug was introduced by commit cbe7fba ("ovl: make
sure that real
fid is 32bit aligned in memory") in 5.5-rc2.

Fixed status
mainline: [cf8aa9bf97cadf85745506c6a3e244b22c268d63]
stable/5.15: [a77141a06367825d639ac51b04703d551163e36c]
stable/6.1: [07a96977b2f462337a9121302de64277b8747ab1]

CVE-2022-49744: mm/uffd: fix pte marker when fork() without fork event

Announce: https://lore.kernel.org/linux-cve-announce/2025032758-CVE-2022-49744-8c5a@gregkh/

Introduced by commit c56d1b6 ("mm/shmem: handle uffd-wp during
fork()") in v5.19-rc1.
Fixed in v6.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [49d6d7fb631345b0f2957a7c4be24ad63903150f]
stable/6.1: [2d11727655bf931776fb541f5862daf04bd5bf02]

CVE-2022-49745: fpga: m10bmc-sec: Fix probe rollback

Announce: https://lore.kernel.org/linux-cve-announce/2025032758-CVE-2022-49745-903a@gregkh/

Introduced by commit 5cd339b ("fpga: m10bmc-sec: add max10 secure
update functions") in v6.0-rc1.
Fixed in v6.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [60ce26d10e5850f33cc76fce52f5377045e75a15]
stable/6.1: [74cff472d3d66db13b5ef64f40dfa42383f71ff7]

CVE-2022-49746: dmaengine: imx-sdma: Fix a possible memory leak in
sdma_transfer_init

Announce: https://lore.kernel.org/linux-cve-announce/2025032758-CVE-2022-49746-251b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc5.
It seems as if this bug was introduced by commit 2142084 ("dmaengine: imx-sdma:
add sdma_transfer_init to decrease code overlap") in 4.19-rc1.

Fixed status
cip/4.19-st: [80ee99e52936b2c04cc37b17a14b2ae2f9d282ac]
mainline: [1417f59ac0b02130ee56c0c50794b9b257be3d17]
stable/4.19: [80ee99e52936b2c04cc37b17a14b2ae2f9d282ac]
stable/5.10: [bd0050b7ffa87c7b260d563646af612f4112a778]
stable/5.15: [43acd767bd90c5d4172ce7fee5d9007a9a08dea9]
stable/5.4: [dbe634ce824329d8f14079c3e9f8f11670894bec]
stable/6.1: [ce4745a6b8016fae74c95dcd457d4ceef7d98af1]

CVE-2022-49747: erofs/zmap.c: Fix incorrect offset calculation

Announce: https://lore.kernel.org/linux-cve-announce/2025032759-CVE-2022-49747-f361@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc5.
It seems as if this bug was introduced by commit eadcd6b ("erofs: add
fiemap support
with iomap") in 5.15-rc1.

Fixed status
mainline: [6acd87d50998ef0afafc441613aeaf5a8f5c9eff]
stable/5.15: [2144859229c1e74f52d3ea067338d314a83a8afb]
stable/6.1: [9f31d8c889d9a4e47bfcc6c4537d0c9f89fe582c]

CVE-2022-49748: perf/x86/amd: fix potential integer overflow on shift of a int

Announce: https://lore.kernel.org/linux-cve-announce/2025032759-CVE-2022-49748-4658@gregkh/

Introduced by commit 471af00 ("perf/x86/amd: Constrain Large Increment
per Cycle events") in v5.6-rc1.
Fixed in v6.2-rc2.

Bug introduced commit was backported to following branches.
stable/5.4

Fixed status
mainline: [08245672cdc6505550d1a5020603b0a8d4a6dcc7]
stable/5.10: [f84c9b72fb200633774704d8020f769c88a4b249]
stable/5.15: [14cc13e433e1067557435b1adbf05608d7d47a93]
stable/5.4: [fbf7b0e4cef3b5470b610f14fb9faa5ee7f63954]
stable/6.1: [a4d01fb87ece45d4164fd725890211ccf9a307a9]

CVE-2022-49749: i2c: designware: use casting of u64 in clock
multiplication to avoid overflow

Announce: https://lore.kernel.org/linux-cve-announce/2025032759-CVE-2022-49749-ed85@gregkh/

Introduced by commit 2373f6b ("i2c-designware: split of
i2c-designware.c into core and bus specific parts") in v3.2-rc1.
Fixed in v6.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c8c37bc514514999e62a17e95160ed9ebf75ca8d]
stable/5.10: [ed173f77fd28a3e4fffc13b3f28687b9eba61157]
stable/5.15: [2f29d780bd691d20e89e5b35d5e6568607115e94]
stable/6.1: [9f36aae9e80e79b7a6d62227eaa96935166be9fe]

CVE-2022-49750: cpufreq: CPPC: Add u64 casts to avoid overflowing

Announce: https://lore.kernel.org/linux-cve-announce/2025032700-CVE-2022-49750-743d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc4.
It seems as if this bug was introduced by commit 740fcdc ("cpufreq:
CPPC: Register
EM based on efficiency class information") in 5.19-rc1.

Fixed status
mainline: [f5f94b9c8b805d87ff185caf9779c3a4d07819e3]
stable/6.1: [7d596bbc66a52ff2c7a83d7e0ee840cb07e2a045]

CVE-2022-49751: w1: fix WARNING after calling w1_process()

Announce: https://lore.kernel.org/linux-cve-announce/2025032700-CVE-2022-49751-bf8f@gregkh/

Introduced by commit 3c52e4e ("W1: w1_process, block or sleep") in v2.6.28-rc1.
Fixed in v6.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [bccd6df4c177b1ad766f16565ccc298653d027d0]
cip/4.4-st: [5156f0e48a8453808ef4606541a0718f1c98cf6b]
mainline: [36225a7c72e9e3e1ce4001b6ce72849f5c9a2d3b]
stable/4.19: [bccd6df4c177b1ad766f16565ccc298653d027d0]
stable/5.10: [216f35db6ec6a667cd9db4838d657c1d2f4684da]
stable/5.15: [89c62cee5d4d65ac75d99b5f986f7f94290e888f]
stable/5.4: [276052159ba94d4d9f5b453fb4707d6798c6b845]
stable/6.1: [cfc7462ff824ed6718ed0272ee9aae88e20d469a]

CVE-2022-49752: device property: fix of node refcount leak in
fwnode_graph_get_next_endpoint()

Announce: https://lore.kernel.org/linux-cve-announce/2025032700-CVE-2022-49752-19a3@gregkh/

Introduced by commit b5b41ab ("device property: Check
fwnode->secondary in fwnode_graph_get_next_endpoint()") in v5.15-rc1.
Fixed in v6.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [39af728649b05e88a2b40e714feeee6451c3f18e]
stable/5.15: [7701a4bd45c11f9a289d8f262fad05705a012339]
stable/6.1: [e75485fc589ec729cc182aa9b41dfb6c15ae6f6e]

CVE-2022-49753: dmaengine: Fix double increment of client_count in
dma_chan_get()

Announce: https://lore.kernel.org/linux-cve-announce/2025032701-CVE-2022-49753-d1ce@gregkh/

Introduced by commit d2f4f99 ("dmaengine: Rework dma_chan_get") in v4.0-rc1.
Fixed in v6.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [c6221afe573413fd2981e291f7df4a58283e0654]
cip/4.4-st: [5ebe61e75bdd1250e48798bf145a850a7c8a2662]
mainline: [f3dc1b3b4750851a94212dba249703dd0e50bb20]
stable/4.19: [c6221afe573413fd2981e291f7df4a58283e0654]
stable/5.10: [42ecd72f02cd657b00b559621e7ef7d2c4d3e5f1]
stable/5.15: [71c601965532c38030133535f7cd93c1efa75af1]
stable/5.4: [18dd3b30d4c7e8440c63118c7a7b687372b9567f]
stable/6.1: [142d644fd2cc059ffa042fbfb68e766433ef3afd]

CVE-2022-49754: Bluetooth: Fix a buffer overflow in mgmt_mesh_add()

Announce: https://lore.kernel.org/linux-cve-announce/2025032701-CVE-2022-49754-cc36@gregkh/

Introduced by commit b338d91 ("Bluetooth: Implement support for Mesh")
in v6.1-rc1.
Fixed in v6.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2185e0fdbb2137f22a9dd9fcbf6481400d56299b]
stable/6.1: [ed818fd8c531abf561b379995ee7cc4c68029464]

CVE-2022-49755: usb: gadget: f_fs: Prevent race during ffs_ep0_queue_wait

Announce: https://lore.kernel.org/linux-cve-announce/2025032701-CVE-2022-49755-dfb6@gregkh/

Introduced by commit ddf8abd ("USB: f_fs: the FunctionFS driver") in
v2.6.35-rc1.
Fixed in v6.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e9036e951f93fb8d7b5e9d6e2c7f94a4da312ae4]
cip/4.4-st: [2ec791e9db4dbc3caff74c1c78875e2c2376eb74]
mainline: [6a19da111057f69214b97c62fb0ac59023970850]
stable/4.19: [e9036e951f93fb8d7b5e9d6e2c7f94a4da312ae4]
stable/5.10: [6dd9ea05534f323668db94fcc2726c7a84547e78]
stable/5.15: [ae8e136bcaae96163b5821984de1036efc9abb1a]
stable/5.4: [a8d40942df074f4ebcb9bd3413596d92f323b064]
stable/6.1: [6aee197b7fbcd61596a78b47d553f2f99111f217]

CVE-2022-49756: phy: usb: sunplus: Fix potential null-ptr-deref in
sp_usb_phy_probe()

Announce: https://lore.kernel.org/linux-cve-announce/2025032701-CVE-2022-49756-7fd9@gregkh/

Introduced by commit 99d9ccd ("phy: usb: Add USB2.0 phy driver for
Sunplus SP7021") in v6.1-rc1.
Fixed in v6.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [17eee264ef386ef30a69dd70e36f29893b85c170]
stable/6.1: [d838b5c99bcecd593b4710a93fce8fdbf122395b]

CVE-2022-49757: EDAC/highbank: Fix memory leak in highbank_mc_probe()

Announce: https://lore.kernel.org/linux-cve-announce/2025032702-CVE-2022-49757-a990@gregkh/

Introduced by commit a1b01ed ("edac: add support for Calxeda highbank
memory controller") in v3.6-rc1.
Fixed in v6.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [0db40e23b56d217eebd385bebb64057ef764b2c7]
cip/4.4-st: [f2e4b15c6db7f7fb480354e2a63114082e7a1b73]
mainline: [e7a293658c20a7945014570e1921bf7d25d68a36]
stable/4.19: [0db40e23b56d217eebd385bebb64057ef764b2c7]
stable/5.10: [329fbd260352a7b9a83781d8b8bd96f95844a51f]
stable/5.15: [caffa7fed1397d1395052272c93900176de86557]
stable/5.4: [8d23f5d25264beb223ee79cdb530b88c237719fc]
stable/6.1: [b7863ef8a8f0fee96b4eb41211f4918c0e047253]

CVE-2022-49758: reset: uniphier-glue: Fix possible null-ptr-deref

Announce: https://lore.kernel.org/linux-cve-announce/2025032702-CVE-2022-49758-10e5@gregkh/

Introduced by commit 499fef0 ("reset: uniphier: add USB3 core reset
control") in v4.19-rc1.
Fixed in v6.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a2390c6777e3f6662980c6cfc25cafe9e4fef98]
stable/5.15: [95de286200b2a046da01c4aeba02ae9220d68ca4]
stable/6.1: [633bad3dc81ce2aa561f704ec091e49eb647bd0b]

CVE-2022-49759: VMCI: Use threaded irqs instead of tasklets

Announce: https://lore.kernel.org/linux-cve-announce/2025032702-CVE-2022-49759-5392@gregkh/

Introduced by commit 463713e ("VMCI: dma dg: add support for DMA
datagrams receive") in v5.18-rc1.
Fixed in v6.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3daed6345d5880464f46adab871d208e1baa2f3a]
stable/6.1: [548ea9dd5e01b0ecf53d2563004c80abd636743d]

CVE-2022-49760: mm/hugetlb: fix PTE marker handling in
hugetlb_change_protection()

Announce: https://lore.kernel.org/linux-cve-announce/2025032703-CVE-2022-49760-97be@gregkh/

Introduced by commit 60dfaad ("mm/hugetlb: allow uffd wr-protect none
ptes") in v5.19-rc1.
Fixed in v6.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0e678153f5be7e6c8d28835f5a678618da4b7a9c]
stable/6.1: [6062c992e912df1eedad52cf64efb3d48e8d35c5]

CVE-2022-49761: btrfs: always report error in run_one_delayed_ref()

Announce: https://lore.kernel.org/linux-cve-announce/2025032703-CVE-2022-49761-9b1e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc3.
The btrfs_run_delayed_refs_for_head was introduced by commit e7261386
("btrfs: Factor
out loop processing all refs of a head") in 4.20-rc1.

Fixed status
mainline: [39f501d68ec1ed5cd5c66ac6ec2a7131c517bb92]
stable/5.10: [18bd1c9c02e64a3567f90c83c2c8b855531c8098]
stable/5.15: [fdb4a70bb768d2a87890409597529ad81cb3de8a]
stable/6.1: [853ffa1511b058c79a4c9bb1407b3b20ce311792]

CVE-2023-52928: bpf: Skip invalid kfunc call in backtrack_insn

Announce: https://lore.kernel.org/linux-cve-announce/2025032718-CVE-2023-52928-e380@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc5.


Fixed status
mainline: [d3178e8a434b58678d99257c0387810a24042fb6]
stable/5.15: [6e2fac197de2c4c041bdd8982cffb104689113f1]
stable/6.1: [74eec8266f37aff609db6a2f2b093e56a11c28c4]

CVE-2023-52929: nvmem: core: fix cleanup after dev_set_name()

Announce: https://lore.kernel.org/linux-cve-announce/2025032719-CVE-2023-52929-7900@gregkh/

Introduced by commit 5544e90 ("nvmem: core: add error handling for
dev_set_name") in v6.1-rc1.
Fixed in v5.15.95.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [8f9c4b2a3b132bf6698e477aba6ee194b40c75f4]
stable/5.10: [23676ecd2eb377f7c24a6ff578b0f4c7135658b6]
stable/6.1: [23676ecd2eb377f7c24a6ff578b0f4c7135658b6]

CVE-2023-52930: drm/i915: Fix potential bit_17 double-free

Announce: https://lore.kernel.org/linux-cve-announce/2025032719-CVE-2023-52930-4bbc@gregkh/

Introduced by commit 2850748 ("drm/i915: Pull i915_vma_pin under the
vm->mutex") in v5.5-rc1.
Fixed in v6.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7057a8f126f14f14b040faecfa220fd27c6c2f85]
stable/5.10: [b591abac78e25269b12e3d7170c99463f8c5cb02]
stable/5.15: [e3ebc3e23bd9028a8a9a26cbc5985f99be445f65]
stable/6.1: [0769f997a7b6d5cb8336db0b4ec3d2d311b8097c]

CVE-2023-52931: drm/i915: Avoid potential vm use-after-free

Announce: https://lore.kernel.org/linux-cve-announce/2025032719-CVE-2023-52931-593f@gregkh/

Introduced by commit 9ec8795 ("drm/i915: Drop __rcu from
gem_context->vm") in v5.16-rc1.
Fixed in v6.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [41d419382ec7e257e54b7b6ff0d3623aafb1316d]
stable/6.1: [764accc2c1b8fd1507be2e7f436c94cdce887a00]

CVE-2023-52932: mm/swapfile: add cond_resched() in get_swap_pages()

Announce: https://lore.kernel.org/linux-cve-announce/2025032720-CVE-2023-52932-434b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc7.


Fixed status
cip/4.19-st: [387217b97e99699c34e6d95ce2b91b327fcd853e]
cip/4.4-st: [e407c5d860162152832e04d4cfe41dce65322075]
mainline: [7717fc1a12f88701573f9ed897cc4f6699c661e3]
stable/4.19: [387217b97e99699c34e6d95ce2b91b327fcd853e]
stable/5.10: [30187be29052bba9203b0ae2bdd815e0bc2faaab]
stable/5.15: [5dbe1ebd56470d03b78fc31491a9e4d433106ef2]
stable/5.4: [d49c85a1913385eed46dd16a25ad0928253767f0]
stable/6.1: [49178d4d61e78aed8c837dfeea8a450700f196e2]

CVE-2023-52933: Squashfs: fix handling and sanity checking of xattr_ids count

Announce: https://lore.kernel.org/linux-cve-announce/2025032720-CVE-2023-52933-f292@gregkh/

Introduced by commit 506220d ("squashfs: add more sanity checks in
xattr id lookup") in v5.11.
Fixed in v6.2-rc7.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
cip/4.19-st: [b38c3e9e0adc01956cc3e5a52e4d3f92f79d88e2]
cip/4.4-st: [1e1c8b361440c6467b2c4f336eff12b4d117bf4a]
mainline: [f65c4bbbd682b0877b669828b4e033b8d5d0a2dc]
stable/4.19: [b38c3e9e0adc01956cc3e5a52e4d3f92f79d88e2]
stable/5.10: [5c4d4a83bf1a862d80c1efff1c6e3ce33b501e2e]
stable/5.15: [997bed0f3cde78a3e639d624985bf4a95cf767e6]
stable/5.4: [1369322c1de52c7b9b988b95c9903110a4566778]
stable/6.1: [a7da7d01ac5ce9b369a1ac70e1197999cc6c9686]

CVE-2023-52934: mm/MADV_COLLAPSE: catch !none !huge !bad pmd lookups

Announce: https://lore.kernel.org/linux-cve-announce/2025032720-CVE-2023-52934-bd3c@gregkh/

Introduced by commit 3448839 ("mm/madvise: add file and shmem support
to MADV_COLLAPSE") in v6.1-rc1.
Fixed in v6.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [edb5d0cf5525357652aff6eacd9850b8ced07143]
stable/6.1: [96aaaf8666010a39430cecf8a65c7ce2908a030f]

CVE-2023-52935: mm/khugepaged: fix ->anon_vma race

Announce: https://lore.kernel.org/linux-cve-announce/2025032720-CVE-2023-52935-1c3c@gregkh/

Introduced by commit f3f0e1d ("khugepaged: add support of collapse for
tmpfs/shmem pages") in v4.8-rc1.
Fixed in v6.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [023f47a8250c6bdb4aebe744db4bf7f73414028b]
stable/6.1: [acb08187b5a83cdb9ac4112fae9e18cf983b0128]

CVE-2023-52936: kernel/irq/irqdomain.c: fix memory leak with using
debugfs_lookup()

Announce: https://lore.kernel.org/linux-cve-announce/2025032721-CVE-2023-52936-d459@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc7.
It seems as if this bug was introduced by commit 69dd450 ("irqdomain: Remove
debugfs_file from struct irq_domain") in 5.12-rc3.

Fixed status
mainline: [d83d7ed260283560700d4034a80baad46620481b]
stable/5.15: [066ecbf1a53eb0b92b10c8df7808666be6ea5681]
stable/6.1: [cf1c917bf1c761a557b26410024e90057646c049]

CVE-2023-52937: HV: hv_balloon: fix memory leak with using debugfs_lookup()

Announce: https://lore.kernel.org/linux-cve-announce/2025032721-CVE-2023-52937-605d@gregkh/

Introduced by commit d180e0a ("Drivers: hv: Create debugfs file with
hyper-v balloon usage information") in v6.0-rc1.
Fixed in v6.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6dfb0771429a63db8561d44147f2bb76f93e1c86]
stable/6.1: [0b570a059cf42ad6e2eb632f47c23813d58d8303]

CVE-2023-52938: usb: typec: ucsi: Don't attempt to resume the ports
before they exist

Announce: https://lore.kernel.org/linux-cve-announce/2025032721-CVE-2023-52938-ee34@gregkh/

Introduced by commit e0dced9 ("usb: typec: ucsi: Resume in separate
work") in 6.2-rc1. Fixed in 6.2-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [f82060da749c611ed427523b6d1605d87338aac1]
stable/6.1: [fdd11d7136fd070b3a74d6d8799d9eac28a57fc5]

CVE-2023-52939: mm: memcg: fix NULL pointer in
mem_cgroup_track_foreign_dirty_slowpath()

Announce: https://lore.kernel.org/linux-cve-announce/2025032722-CVE-2023-52939-8bb1@gregkh/

Introduced by commit 97b2782 ("writeback, memcg: Implement foreign
dirty flushing") in v5.4-rc1.
Fixed in v6.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac86f547ca1002aec2ef66b9e64d03f45bbbfbb9]
stable/6.1: [b79ba5953f6fdc5559389ad415620bffc24f024b]

CVE-2023-52940: mm: multi-gen LRU: fix crash during cgroup migration

Announce: https://lore.kernel.org/linux-cve-announce/2025032722-CVE-2023-52940-2e53@gregkh/

Introduced by commit bd74fda ("mm: multi-gen LRU: support page table
walks") in v6.1-rc1.
Fixed in v6.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de08eaa6156405f2e9369f06ba5afae0e4ab3b62]
stable/6.1: [04448022311cebd30969d3aebdde765f1258b360]

CVE-2023-52941: can: isotp: split tx timer into transmission and timeout

Announce: https://lore.kernel.org/linux-cve-announce/2025032722-CVE-2023-52941-7c12@gregkh/

Introduced by commit 8663378 ("can: isotp: fix tx state handling for
echo tx processing") in v6.1-rc5.
Fixed in v6.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f027cba8216f42a18b544842efab134f8b1f9f4]
stable/6.1: [cae4c9bc35f72af5d4a079bb9d9fd62c4088a411]

CVE-2023-52942: cgroup/cpuset: Fix wrong check in
update_parent_subparts_cpumask()

Announce: https://lore.kernel.org/linux-cve-announce/2025032723-CVE-2023-52942-6a3c@gregkh/

Introduced by commit f0af1bf ("cgroup/cpuset: Relax constraints to
partition & cpus changes") in v6.1-rc1.
Fixed in v6.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e5ae8803847b80fe9d744a3174abe2b7bfed222a]
stable/6.1: [a2ab7f2cf5ef8f0c6212a246e681d1fe358cec1f]

CVE-2023-52973: vc_screen: move load of struct vc_data pointer in
vcs_read() to avoid UAF

Announce: https://lore.kernel.org/linux-cve-announce/2025032703-CVE-2023-52973-a993@gregkh/

Introduced by commit ac751ef ("console: rename
acquire/release_console_sem() to console_lock/unlock()") in
v2.6.38-rc3.
Fixed in v6.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [6332f52f44b9776568bf3c0b714ddfb0bb175e78]
cip/4.4-st: [3e546f713a53b0ba772c1ebe2125e746083d6104]
mainline: [226fae124b2dac217ea5436060d623ff3385bc34]
stable/4.19: [6332f52f44b9776568bf3c0b714ddfb0bb175e78]
stable/5.10: [55515d7d8743b71b80bfe68e89eb9d92630626ab]
stable/5.15: [fc9e27f3ba083534b8bbf72ab0f5c810ffdc7d18]
stable/5.4: [d0332cbf53dad06a22189cc341391237f4ea6d9f]
stable/6.1: [8506f16aae9daf354e3732bcfd447e2a97f023df]

CVE-2023-52974: scsi: iscsi_tcp: Fix UAF during login when accessing
the shost ipaddress

Announce: https://lore.kernel.org/linux-cve-announce/2025032704-CVE-2023-52974-0aa2@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc6.


Fixed status
cip/4.19-st: [6abd4698f4c8a78e7bbfc421205c060c199554a0]
cip/4.4-st: [2c5af7ba1f9af22a46615884f5b67d033390377b]
mainline: [f484a794e4ee2a9ce61f52a78e810ac45f3fe3b3]
stable/4.19: [6abd4698f4c8a78e7bbfc421205c060c199554a0]
stable/5.10: [9758ffe1c07b86aefd7ca8e40d9a461293427ca0]
stable/5.15: [0aaabdb900c7415caa2006ef580322f7eac5f6b6]
stable/5.4: [d4d765f4761f9e3a2d62992f825aeee593bcb6b9]
stable/6.1: [61e43ebfd243bcbad11be26bd921723027b77441]

CVE-2023-52975: scsi: iscsi_tcp: Fix UAF during logout when accessing
the shost ipaddress

Announce: https://lore.kernel.org/linux-cve-announce/2025032704-CVE-2023-52975-155c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc6.


Fixed status
mainline: [6f1d64b13097e85abda0f91b5638000afc5f9a06]
stable/5.15: [17b738590b97fb3fc287289971d1519ff9b875a1]
stable/6.1: [8859687f5b242c0b057461df0a9ff51d5500783b]

CVE-2023-52976: efi: fix potential NULL deref in efi_mem_reserve_persistent

Announce: https://lore.kernel.org/linux-cve-announce/2025032704-CVE-2023-52976-eda3@gregkh/

Introduced by commit 18df757 ("efi/memreserve: deal with memreserve
entries in unmapped memory") in v5.2-rc7.
Fixed in v6.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [966d47e1f27c45507c5df82b2a2157e5a4fd3909]
stable/5.10: [87d4ff18738fd71e7e3c10827c80257da6283697]
stable/5.15: [d8fc0b5fb3e816a4a8684bcd3ed02cbef0fce23c]
stable/5.4: [d92a25627bcdf264183670da73c9a60c0bac327e]
stable/6.1: [a2e6a9ff89f13666a1c3ff7195612ab949ea9afc]

CVE-2023-52977: net: openvswitch: fix flow memory leak in ovs_flow_cmd_new

Announce: https://lore.kernel.org/linux-cve-announce/2025032704-CVE-2023-52977-f91d@gregkh/

Introduced by 68bb101 ("openvswitch: Fix flow lookup to use unmasked
key") in 6.2-rc1. Fixed in 6.2-rc7.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/5.10 stable/5.15 stable/5.4 stable/6.1

Fixed status
cip/4.19-st: [af4e720bc00a2653f7b9df21755b9978b3d7f386]
mainline: [0c598aed445eb45b0ee7ba405f7ece99ee349c30]
stable/4.19: [af4e720bc00a2653f7b9df21755b9978b3d7f386]
stable/5.10: [70154489f531587996f3e9d7cceeee65cff0001d]
stable/5.15: [f423c2efd51d7eb1d143c2be7eea233241d9bbbf]
stable/5.4: [ed6c5e8caf55778500202775167e8ccdb1a030cb]
stable/6.1: [70d40674a549d498bd63d5432acf46205da1534b]

CVE-2023-52978: riscv: kprobe: Fixup kernel panic when probing an
illegal position

Announce: https://lore.kernel.org/linux-cve-announce/2025032705-CVE-2023-52978-6a05@gregkh/

Introduced by commit c22b0bc ("riscv: Add kprobes supported") in v5.12-rc1.
Fixed in v6.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87f48c7ccc73afc78630530d9af51f458f58cab8]
stable/5.15: [04a73558209554da17f46490ec4faaaf1b2bab68]
stable/6.1: [12316538b1d193064109ce1a28fc9bacd43950de]

CVE-2023-52979: squashfs: harden sanity check in squashfs_read_xattr_id_table

Announce: https://lore.kernel.org/linux-cve-announce/2025032705-CVE-2023-52979-ca3f@gregkh/

Introduced by commit 506220d ("squashfs: add more sanity checks in
xattr id lookup") in v5.11.
Fixed in v6.2-rc7.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
cip/4.19-st: [b30a74f83265c24d1d0842c6c3928cd2e775a3fb]
cip/4.4-st: [5de4d5f86e09d6d3ba4be5a2aae6107e99fd01a3]
mainline: [72e544b1b28325fe78a4687b980871a7e4101f76]
stable/4.19: [b30a74f83265c24d1d0842c6c3928cd2e775a3fb]
stable/5.10: [de2785aa3448d1ee7be3ab47fd4a873025f1b3d7]
stable/5.15: [b7398efe24a965cf3937b716c0b1011c201c5d6e]
stable/5.4: [db76fc535fbdfbf29fd0b93e49627537ad794c8c]
stable/6.1: [29e774dcb27116c06b9c57b1f1f14a1623738989]

CVE-2023-52980: block: ublk: extending queue_size to fix overflow

Announce: https://lore.kernel.org/linux-cve-announce/2025032705-CVE-2023-52980-0fea@gregkh/

Introduced by commit 71f28f3 ("ublk_drv: add io_uring based userspace
block driver") in v6.0-rc1.
Fixed in v6.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [29baef789c838bd5c02f50c88adbbc6b955aaf61]
stable/6.1: [ee1e3fe4b4579f856997190a00ea4db0307b4332]

CVE-2023-52981: drm/i915: Fix request ref counting during error
capture & debugfs dump

Announce: https://lore.kernel.org/linux-cve-announce/2025032706-CVE-2023-52981-070c@gregkh/

Introduced by commit dc0dad3 ("drm/i915/guc: Fix for error capture
after full GPU reset with GuC") in v5.15-rc1.
Introduced by commit 573ba12 ("drm/i915/guc: Capture error state on
context reset") in v5.15-rc1.
Fixed in v6.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [86d8ddc74124c3fdfc139f246ba6da15e45e86e3]
stable/6.1: [9467397f417dd7b5d0db91452f0474e79716a527]

CVE-2023-52982: fscache: Use wait_on_bit() to wait for the freeing of
relinquished volume

Announce: https://lore.kernel.org/linux-cve-announce/2025032706-CVE-2023-52982-7291@gregkh/

Introduced by commit 62ab633 ("fscache: Implement volume
registration") in v5.17-rc1.
Fixed in v6.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8226e37d82f43657da34dd770e2b38f20242ada7]
stable/6.1: [3be069f42a7b79d3149194f21cdf24bf23864cac]

CVE-2023-52983: block, bfq: fix uaf for bfqq in bic_set_bfqq()

Announce: https://lore.kernel.org/linux-cve-announce/2025032706-CVE-2023-52983-4a16@gregkh/

Introduced by 64dc8c7 ("block, bfq: fix possible uaf for 'bfqq->bic'")
in 6.2-rc1. Fixed in 6.2-rc7.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [b600de2d7d3a16f9007fad1bdae82a3951a26af2]
stable/5.10: [7f77f3dab5066a7c9da73d72d1eee895ff84a8d5]
stable/5.15: [7f77f3dab5066a7c9da73d72d1eee895ff84a8d5]
stable/6.1: [511c922c5bf6c8a166bea826e702336bc2424140]

CVE-2023-52984: net: phy: dp83822: Fix null pointer access on
DP83825/DP83826 devices

Announce: https://lore.kernel.org/linux-cve-announce/2025032707-CVE-2023-52984-19ad@gregkh/

Introduced by commit 5dc39fd ("net: phy: DP83822: Add ability to
advertise Fiber connection") in v5.10-rc1.
Fixed in v6.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [422ae7d9c7221e8d4c8526d0f54106307d69d2dc]
stable/5.10: [362a2f5531dc0e5b0b5b3e3a541000dbffa75461]
stable/5.15: [2cd1e9c013ec56421c58921b1ddf1d2d53bd47fa]
stable/6.1: [78901b10522cdf6badf24acf65a892637596bccc]

CVE-2023-52985: arm64: dts: imx8mm-verdin: Do not power down eth-phy

Announce: https://lore.kernel.org/linux-cve-announce/2025032707-CVE-2023-52985-3f52@gregkh/

Introduced by commit 6a57f22 ("arm64: dts: freescale: add initial
support for verdin imx8m mini") in v5.18-rc1.
Fixed in v6.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [39c95d0c357d7ef76aea958c1bece6b24f9b2e7e]
stable/6.1: [0bdd5a7b517f16fdffc444be6516c45788548d08]

CVE-2023-52986: bpf, sockmap: Check for any of tcp_bpf_prots when
cloning a listener

Announce: https://lore.kernel.org/linux-cve-announce/2025032707-CVE-2023-52986-91fe@gregkh/

Introduced by commit e802515 ("tcp_bpf: Don't let child socket inherit
parent protocol ops on copy") in v5.7-rc1.
Fixed in v6.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ddce1e091757d0259107c6c0c7262df201de2b66]
stable/5.10: [9bd6074e1872d22190a8da30e796cbf937d334f0]
stable/5.15: [c681d7a4ed3d360de0574f4d6b7305a8de8dc54f]
stable/6.1: [12b0ec7c6953e1602957926439e5297095d7d065]

CVE-2023-52987: ASoC: SOF: ipc4-mtrace: prevent underflow in
sof_ipc4_priority_mask_dfs_write()

Announce: https://lore.kernel.org/linux-cve-announce/2025032707-CVE-2023-52987-bcc0@gregkh/

Introduced by commit f4ea22f ("ASoC: SOF: ipc4: Add support for mtrace
log extraction") in v6.1-rc1.
Fixed in v6.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea57680af47587397f5005d7758022441ed66d54]
stable/6.1: [d52f34784e4e2f6e77671a9f104d8a69a3b5d24c]

CVE-2023-52988: ALSA: hda/via: Avoid potential array out-of-bound in
add_secret_dac_path()

Announce: https://lore.kernel.org/linux-cve-announce/2025032708-CVE-2023-52988-5520@gregkh/

Introduced by commit 30b4503 ("ALSA: hda - Expose secret DAC-AA
connection of some VIA codecs") in v3.1-rc1.
Fixed in v6.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [6e1f586ddec48d71016b81acf68ba9f49ca54db8]
cip/4.4-st: [339fa338b7723af68f55272e17480a9014a96ff1]
mainline: [b9cee506da2b7920b5ea02ccd8e78a907d0ee7aa]
stable/4.19: [6e1f586ddec48d71016b81acf68ba9f49ca54db8]
stable/5.10: [2b557fa635e7487f638c0f030c305870839eeda2]
stable/5.15: [1b9256c96220bcdba287eeeb90e7c910c77f8c46]
stable/5.4: [d6870f3800dbb212ae8433183ee82f566d067c6c]
stable/6.1: [f011360ad234a07cb6fbcc720fff646a93a9f0d6]

CVE-2023-52989: firewire: fix memory leak for payload of request
subaction to IEC 61883-1 FCP region

Announce: https://lore.kernel.org/linux-cve-announce/2025032708-CVE-2023-52989-1b68@gregkh/

Introduced by commit 281e203 ("firewire: core: fix use-after-free
regression in FCP handler") in v2.6.33-rc6.
Fixed in v6.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [356ff89acdbe6a66019154bc7eb2d300f5b15103]
cip/4.4-st: [403325d3e1481551d1aab53bc8c6c4f55b835a40]
mainline: [531390a243ef47448f8bad01c186c2787666bf4d]
stable/4.19: [356ff89acdbe6a66019154bc7eb2d300f5b15103]
stable/5.10: [d5a2dcee53fa6e6e2822f93cb3f1b0cd23163bee]
stable/5.15: [5f4543c9382ae2d5062f6aa4fecae0c9258d0b0e]
stable/5.4: [53785fd9b315583cf029e39f72b73d23704a2253]
stable/6.1: [c8bdc88216f09cb7387fedbdf613524367328616]

CVE-2023-52990: [REJECTED]: s390: workaround invalid gcc-11 out of
bounds read warning

Announce: https://lore.kernel.org/linux-cve-announce/2025032708-CVE-2023-52990-befd@gregkh/

This CVE was rejected. There is no mention of the commit that
introduced the bug in the CVE announcement.Fixed in v6.2-rc5.


Fixed status
mainline: [41e1992665a2701fa025a8b76970c43b4148446f]
stable/6.1: [1fc24f9da259b675c3cc74ad5aa92dac286543b3]

CVE-2023-52991: net: fix NULL pointer in skb_segment_list

Announce: https://lore.kernel.org/linux-cve-announce/2025032709-CVE-2023-52991-6358@gregkh/

Introduced by commit 3a1296a ("net: Support GRO/GSO fraglist
chaining.") in v5.6-rc1.
Fixed in v6.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [876e8ca8366735a604bac86ff7e2732fc9d85d2d]
stable/5.10: [6446369fb9f083ce032448c5047da08e298b22e6]
stable/5.15: [046de74f9af92ae9ffce75fa22a1795223f4fb54]
stable/6.1: [888dad6f3e85e3b2f8389bd6478f181efc72534d]

CVE-2023-52992: bpf: Skip task with pid=1 in send_signal_common()

Announce: https://lore.kernel.org/linux-cve-announce/2025032709-CVE-2023-52992-bf46@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc5.
Affected function send_signal_common is not found in 4.4.

Fixed status
mainline: [a3d81bc1eaef48e34dd0b9b48eefed9e02a06451]
stable/5.10: [a1c0263f1eb4deee132e11e52ee6982435460d81]
stable/5.15: [0dfef503133565fa0bcf3268d8eeb5b181191a65]
stable/5.4: [4923160393b06a34759a11b17930d71e06f396f2]
stable/6.1: [1283a01b6e19d05f7ed49584ea653947245cd41e]

CVE-2023-52993: x86/i8259: Mark legacy PIC interrupts with IRQ_LEVEL

Announce: https://lore.kernel.org/linux-cve-announce/2025032709-CVE-2023-52993-3697@gregkh/

Introduced by commit a4633ad ("[PATCH] genirq: add genirq sw
IRQ-retrigger") in v2.6.20.16.
Fixed in v6.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [496975d1a2937f4baadf3d985991b13fc4fc4f27]
cip/4.4-st: [a6c971efc5b6b1ee56738b02e2c2bc44044eacfa]
mainline: [5fa55950729d0762a787451dc52862c3f850f859]
stable/4.19: [496975d1a2937f4baadf3d985991b13fc4fc4f27]
stable/5.10: [e284c273dbb4c1ed68d4204bff94d0b10e4a90f5]
stable/5.15: [0b08201158f177aab469e356b4d6af24fdd118df]
stable/5.4: [8770cd9d7c14aa99c255a0d08186f0be953e1638]
stable/6.1: [137f1b47da5f58805da42c1b7811e28c1e353f39]

CVE-2023-52994: acpi: Fix suspend with Xen PV

Announce: https://lore.kernel.org/linux-cve-announce/2025032710-CVE-2023-52994-5336@gregkh/

Introduced by f1e5250 ("x86/boot: Skip realmode init code when running
as Xen PV guest") in 6.2-rc1. Fixed in 6.2-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [fe0ba8c23f9a35b0307eb662f16dd3a75fcdae41]
stable/6.1: [b96903b7fc8c82ddfd92df4cdd83db3e567da0a5]

CVE-2023-52995: riscv/kprobe: Fix instruction simulation of JALR

Announce: https://lore.kernel.org/linux-cve-announce/2025032710-CVE-2023-52995-c28f@gregkh/

Introduced by commit c22b0bc ("riscv: Add kprobes supported") in v5.12-rc1.
Fixed in v6.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ca0254998be4d74cf6add70ccfab0d2dbd362a10]
stable/5.15: [614471b7f7cd28a2c96ab9c90b37471c82258ffb]
stable/6.1: [f4c8fc775fcbc9e9047b22671c55ca18f9a127d4]

CVE-2023-52996: ipv4: prevent potential spectre v1 gadget in fib_metrics_match()

Announce: https://lore.kernel.org/linux-cve-announce/2025032710-CVE-2023-52996-7c1f@gregkh/

Introduced by commit 5f9ae3d ("ipv4: do metrics match when looking up
and deleting a route") in v4.14-rc1.
Fixed in v6.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5e9398a26a92fc402d82ce1f97cc67d832527da0]
stable/5.10: [7f9828fb1f688210e681268490576f0ca65c322a]
stable/5.15: [ca3cf947760de050d558293002ad3e7f4b8745d2]
stable/5.4: [8f0eb24f1a7a60ce635f0d757a46f1a37a4d467d]
stable/6.1: [f9753ebd61be2d957b5504cbd3fd719674f05b7a]

CVE-2023-52997: ipv4: prevent potential spectre v1 gadget in
ip_metrics_convert()

Announce: https://lore.kernel.org/linux-cve-announce/2025032710-CVE-2023-52997-dbca@gregkh/

Introduced by commit 6cf9dfd ("net: fib: move metrics parsing to a
helper") in v4.3-rc1.
Fixed in v6.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [ef050cf5fb70d995a0d03244e25179b7c66a924a]
mainline: [1d1d63b612801b3f0a39b7d4467cad0abd60e5c8]
stable/4.19: [ef050cf5fb70d995a0d03244e25179b7c66a924a]
stable/5.10: [34c6142f0df9cd75cba5a7aa9df0960d2854b415]
stable/5.15: [d50e7348b44f1e046121ff5be01b7fb6978a1149]
stable/5.4: [746db9ec1e672eee13965625ddac0d97e16fa20c]
stable/6.1: [6850fe301d015a7d2012d1de8caf43dafb7cc2f6]

CVE-2023-52998: net: fec: Use page_pool_put_full_page when freeing rx buffers

Announce: https://lore.kernel.org/linux-cve-announce/2025032711-CVE-2023-52998-0671@gregkh/

Introduced by commit 95698ff ("net: fec: using page pool to manage RX
buffers") in v6.1-rc1.
Fixed in v6.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e38553bdc377e3e7a6caa9dd9770d8b644d8dac3]
stable/6.1: [554484a34e985a307756ee4794e60be31e3db2e5]

CVE-2023-52999: net: fix UaF in netns ops registration error path

Announce: https://lore.kernel.org/linux-cve-announce/2025032711-CVE-2023-52999-e28e@gregkh/

Introduced by commit d266935 ("net: fix UAF issue in
nfqnl_nf_hook_drop() when ops_init() failed") in v6.1-rc3.
Fixed in v6.2-rc6.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10
stable/5.15 stable/5.4

Fixed status
cip/4.19-st: [ad0dfe9bcf0d78e699c7efb64c90ed062dc48bea]
mainline: [71ab9c3e2253619136c31c89dbb2c69305cc89b1]
stable/4.19: [ad0dfe9bcf0d78e699c7efb64c90ed062dc48bea]
stable/5.10: [d4c008f3b7f7d4ffd311eb2dae5e75b3cbddacd0]
stable/5.15: [66689a72ba73575e76d4f6a8748d3fa2690ec1c4]
stable/5.4: [ddd49cbbd4c1ceb38032018b589b44208e54f55e]
stable/6.1: [12075708f2e77ee6a9f8bb2cf512c38be3099794]

CVE-2023-53000: netlink: prevent potential spectre v1 gadgets

Announce: https://lore.kernel.org/linux-cve-announce/2025032711-CVE-2023-53000-fded@gregkh/

Introduced by commit bfa83a9 ("[NETLINK]: Type-safe netlink
messages/attributes interface") in v2.6.20.16.
Fixed in v6.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0950402e8c76e7dcb08563f1b4e8000fbc62455]
stable/5.10: [539ca5dcbc91134bbe2c45677811c31d8b030d2d]
stable/5.15: [41b74e95f297ac360ca7ed6bf200100717cb6c45]
stable/5.4: [3e5082b1c66c7783fbcd79b5b178573230e528ff]
stable/6.1: [992e4ff7116a77968039277b5d6aaa535c2f2184]

CVE-2023-53001: drm/drm_vma_manager: Add drm_vma_node_allow_once()

Announce: https://lore.kernel.org/linux-cve-announce/2025032712-CVE-2023-53001-f28f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc6.


Fixed status
mainline: [899d3a3c19ac0e5da013ce34833dccb97d19b5e4]
stable/6.1: [67444f8ca31cdaf45e0b761241ad49b1ae04bcf9]

CVE-2023-53002: drm/i915: Fix a memory leak with reused mmap_offset

Announce: https://lore.kernel.org/linux-cve-announce/2025032712-CVE-2023-53002-1f76@gregkh/

Introduced by commit 7865559 ("drm/i915/gem: Store mmap_offsets in an
rbtree rather than a plain list") in v5.7-rc1.
Fixed in v6.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0220e4fe178c3390eb0291cdb34912d66972db8a]
stable/6.1: [0bdc4b4ba7206c452ee81c82fa66e39d0e1780fb]

CVE-2023-53003: EDAC/qcom: Do not pass llcc_driv_data as
edac_device_ctl_info's pvt_info

Announce: https://lore.kernel.org/linux-cve-announce/2025032712-CVE-2023-53003-8256@gregkh/

Introduced by commit 2745065 ("drivers: edac: Add EDAC driver support
for QCOM SoCs") in v4.20-rc1.
Fixed in v6.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [977c6ba624f24ae20cf0faee871257a39348d4a9]
stable/5.10: [76d9ebb7f0bc10fbc78b6d576751552edf743968]
stable/5.15: [bff5243bd32661cf9ce66f6d9210fc8f89bda145]
stable/5.4: [66e10d5f399629ef7877304d9ba2b35d0474e7eb]
stable/6.1: [6f0351d0c311951b8b3064db91e61841e85b2b96]

CVE-2023-53004: ovl: fix tmpfile leak

Announce: https://lore.kernel.org/linux-cve-announce/2025032713-CVE-2023-53004-e58b@gregkh/

Introduced by commit 2b1a774 ("ovl: use vfs_tmpfile_open() helper") in v6.1-rc1.
Fixed in v6.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [baabaa505563362b71f2637aedd7b807d270656c]
stable/6.1: [caa0ea92503f8afa1941f6ac899e5c4e3f6ec8bb]

CVE-2023-53005: trace_events_hist: add check for return value of
'create_hist_field'

Announce: https://lore.kernel.org/linux-cve-announce/2025032713-CVE-2023-53005-9bf0@gregkh/

Introduced by commit 30350d6 ("tracing: Add variable support to hist
triggers") in v4.17-rc1.
Fixed in v6.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [d2d1ada58e7cc100b8d7d6b082d19321ba4a700a]
mainline: [8b152e9150d07a885f95e1fd401fc81af202d9a4]
stable/4.19: [d2d1ada58e7cc100b8d7d6b082d19321ba4a700a]
stable/5.10: [886aa449235f478e262bbd5dcdee6ed6bc202949]
stable/5.15: [592ba7116fa620425725ff0972691f352ba3caf6]
stable/5.4: [31b2414abeaa6de0490e85164badc6dcb1bb8ec9]
stable/6.1: [b4e7e81b4fdfcf457daee6b7a61769f62198d840]

CVE-2023-53006: cifs: Fix oops due to uncleared server->smbd_conn in reconnect

Announce: https://lore.kernel.org/linux-cve-announce/2025032713-CVE-2023-53006-209f@gregkh/

Introduced by commit 8ef130f ("CIFS: SMBD: Implement function to
destroy a SMB Direct connection") in v4.16-rc1.
Fixed in v6.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [a9640c0b268405f2540e8203a545e930ea88bb7d]
mainline: [b7ab9161cf5ddc42a288edf9d1a61f3bdffe17c7]
stable/4.19: [a9640c0b268405f2540e8203a545e930ea88bb7d]
stable/5.10: [e037baee16e0b9ace7e730888fcae9cec11daff2]
stable/5.15: [4b83bc6f87eedab4599b0123e572a422689444be]
stable/5.4: [91be54849d5392050f5b847b42bd5e6221551ac8]
stable/6.1: [5109607a4ece7cd8536172bf7549eb4dce1f3576]

CVE-2023-53007: tracing: Make sure trace_printk() can output as soon
as it can be used

Announce: https://lore.kernel.org/linux-cve-announce/2025032713-CVE-2023-53007-6ed4@gregkh/

Introduced by commit e725c73 ("tracing: Split tracing initialization
into two for early initialization") in v4.12-rc1.
Fixed in v6.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [b94d7c7654356860dd7719120c7d15ba38b6162a]
mainline: [3bb06eb6e9acf7c4a3e1b5bc87aed398ff8e2253]
stable/4.19: [b94d7c7654356860dd7719120c7d15ba38b6162a]
stable/5.10: [de3930a4883ddad2244efd6d349013294c62c75c]
stable/5.15: [b0af180514edea6c83dc9a299d9f383009c99f25]
stable/5.4: [76b2390fdc80c0a8300e5da5b6b62d201b6fe9ce]
stable/6.1: [198c83963f6335ca6d690cff067679560f2a3a22]

CVE-2023-53008: cifs: fix potential memory leaks in session setup

Announce: https://lore.kernel.org/linux-cve-announce/2025032714-CVE-2023-53008-415c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc4.


Fixed status
mainline: [2fe58d977ee05da5bb89ef5dc4f5bf2dc15db46f]
stable/6.1: [893d45394dbe4b5cbf3723c19e2ccc8b93a6ac9b]

CVE-2023-53009: drm/amdkfd: Add sync after creating vram bo

Announce: https://lore.kernel.org/linux-cve-announce/2025032714-CVE-2023-53009-82cd@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.2-rc4.
Affected function was added by e49fe40 ("drm/amdkfd: validate vram svm
range from TTM") in 5.14-rc1.

Fixed status
mainline: [ba029e9991d9be90a28b6a0ceb25e9a6fb348829]
stable/6.1: [92af2d3b57a1afdfdcafb1c6a07ffd89cf3e98fb]

CVE-2023-53010: bnxt: Do not read past the end of test names

Announce: https://lore.kernel.org/linux-cve-announce/2025032714-CVE-2023-53010-56af@gregkh/

Introduced by commit eb51365 ("bnxt_en: Add basic ethtool -t selftest
support.") in v4.12-rc1.
Fixed in v6.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3e599c090fc6977331150c5f0a69ab8ce87da21]
stable/6.1: [cefa85480ac99c0bef5a09daadb48d65fc28e279]

CVE-2023-53011: net: stmmac: enable all safety features by default

Announce: https://lore.kernel.org/linux-cve-announce/2025032715-CVE-2023-53011-6f98@gregkh/

Introduced by commit 5ac712d ("net: stmmac: enable platform specific
safety features") in v5.14-rc1.
Fixed in v6.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fdfc76a116b5e9d3e98e6c96fe83b42d011d21d4]
stable/5.15: [120b8e527e07c65de7f2b9018dcd9d17e66f2427]
stable/6.1: [aebf7e62708ba706ee7bf484c9023b15c214e92a]

CVE-2023-53012: thermal: core: call put_device() only after
device_register() fails

Announce: https://lore.kernel.org/linux-cve-announce/2025032715-CVE-2023-53012-597c@gregkh/


Introduced by 4748f96 ("thermal: core: fix some possible name leaks in
error paths") in 6.2-rc1.
Introduced by c408b3d ("thermal: Validate new state in
cur_state_store()") in 6.2-rc1.
Fixed in 6.2-rc5.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [6c54b7bc8a31ce0f7cc7f8deef05067df414f1d8]
stable/5.15: [a7d736cc3c6cb0d7498bbfb56515d414e35e9510]
stable/6.1: [2846a7412f6246fd5171f51011bf76dfebcec0ee]

CVE-2023-53013: ptdma: pt_core_execute_cmd() should use spinlock

Announce: https://lore.kernel.org/linux-cve-announce/2025032715-CVE-2023-53013-58dc@gregkh/

Introduced by commit fa5d823 ("dmaengine: ptdma: Initial driver for
the AMD PTDMA") in v5.15-rc1.
Fixed in v6.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [95e5fda3b5f9ed8239b145da3fa01e641cf5d53c]
stable/5.15: [ed0d8f731e0bf1bb12a7a37698ac613db20e2794]
stable/6.1: [13ba563c2c8055ba8a637c9f70bb833b43cb4207]

CVE-2023-53014: dmaengine: tegra: Fix memory leak in terminate_all()

Announce: https://lore.kernel.org/linux-cve-announce/2025032716-CVE-2023-53014-700f@gregkh/

Introduced by commit ee17028 ("dmaengine: tegra: Add tegra gpcdma
driver") in v5.19-rc1.
Fixed in v6.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a7a7ee6f5a019ad72852c001abbce50d35e992f2]
stable/6.1: [567128076d554e41609c61b7d447089094ff72c5]

CVE-2023-53015: HID: betop: check shape of output reports

Announce: https://lore.kernel.org/linux-cve-announce/2025032716-CVE-2023-53015-f139@gregkh/

Introduced by commit 52cd778 ("HID: betop: add
drivers/hid/hid-betopff.c") in v4.0-rc1.
Fixed in v6.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [7317326f685824c7c29bd80841fd18041af6bb73]
cip/4.4-st: [9835c07b5461c9e3f15546a3a099f8211d645255]
mainline: [3782c0d6edf658b71354a64d60aa7a296188fc90]
stable/4.19: [7317326f685824c7c29bd80841fd18041af6bb73]
stable/5.10: [28fc6095da22dc88433d79578ae1c495ebe8ca43]
stable/5.15: [1a2a47b85cab50a3c146731bfeaf2d860f5344ee]
stable/5.4: [d3065cc56221d1a5eda237e94eaf2a627b88ab79]
stable/6.1: [07bc32e53c7bd5c91472cc485231ef6274db9b76]

CVE-2023-53016: Bluetooth: Fix possible deadlock in rfcomm_sk_state_change

Announce: https://lore.kernel.org/linux-cve-announce/2025032716-CVE-2023-53016-f30c@gregkh/

Introduced by commit 1804fdf ("Bluetooth: btintel: Combine setting up
MSFT extension") in v5.15-rc1.
Fixed in v6.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1d80d57ffcb55488f0ec0b77928d4f82d16b6a90]
stable/5.15: [98aec50ff7f60cc6f2d6a4396b475c547e58b04d]
stable/6.1: [17511bd84871f4a6106cb335616e086880313f3f]

CVE-2023-53017: Bluetooth: hci_sync: fix memory leak in hci_update_adv_data()

Announce: https://lore.kernel.org/linux-cve-announce/2025032716-CVE-2023-53017-8dd9@gregkh/

Introduced by commit 651cd3d ("Bluetooth: convert hci_update_adv_data
to hci_sync") in v6.1-rc1.
Fixed in v6.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1ed8b37cbaf14574c779064ef1372af62e8ba6aa]
stable/6.1: [8ac6043bd3e5b58d30f50737aedc2e58e8087ad5]

CVE-2023-53018: Bluetooth: hci_conn: Fix memory leaks

Announce: https://lore.kernel.org/linux-cve-announce/2025032717-CVE-2023-53018-c89c@gregkh/

Introduced by commit eca0ae4 ("Bluetooth: Add initial implementation
of BIS connections") in v6.0-rc1.
Fixed in v6.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3aa21311f36d8a2730c7ccef37235e951f23927b]
stable/6.1: [f51a825b9f730a782aa768454906b4468e67b667]

CVE-2023-53019: net: mdio: validate parameter addr in mdiobus_get_phy()

Announce: https://lore.kernel.org/linux-cve-announce/2025032717-CVE-2023-53019-441a@gregkh/

Introduced by commit 7f85442 ("phy: Add API for {un}registering an
mdio device to a bus.") in v4.5-rc1.
Fixed in v6.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [c431a3d642593bbdb99e8a9e3eed608b730db6f8]
mainline: [867dbe784c5010a466f00a7d1467c1c5ea569c75]
stable/4.19: [c431a3d642593bbdb99e8a9e3eed608b730db6f8]
stable/5.10: [4bc5f1f6bc94e695dfd912122af96e7115a0ddb8]
stable/5.15: [ad67de330d83e8078372b52af18ffe8d39e26c85]
stable/5.4: [8a7b9560a3a8eb8724888c426e05926752f73aa0]
stable/6.1: [7879626296e6ffd838ae0f2af1ab49ee46354973]

CVE-2023-53020: l2tp: close all race conditions in l2tp_tunnel_register()

Announce: https://lore.kernel.org/linux-cve-announce/2025032717-CVE-2023-53020-1042@gregkh/

Introduced by commit 37159ef ("l2tp: fix a lockdep splat") in v3.6-rc6.
Introduced by commit 6b9f342 ("l2tp: fix races in tunnel creation") in
v4.17-rc1.
Fixed in v6.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0b2c59720e65885a394a017d0cf9cab118914682]
stable/5.10: [2d77e5c0ad79004b5ef901895437e9cce6dfcc7e]
stable/5.15: [77e8ed776cdb1a24b2aab8fe7c6f1f154235e1ce]
stable/6.1: [cef0845b6dcfa2f6c2c832e7f9622551456c741d]

CVE-2023-53021: net/sched: sch_taprio: fix possible use-after-free

Announce: https://lore.kernel.org/linux-cve-announce/2025032718-CVE-2023-53021-def9@gregkh/

Introduced by commit 5a781cc ("tc: Add support for configuring the
taprio scheduler") in v4.20-rc1.
Fixed in v6.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a415d59c1dbec9d772dbfab2d2520d98360caae]
stable/5.10: [c60fe70078d6e515f424cb868d07e00411b27fbc]
stable/5.15: [c53acbf2facfdfabdc6e6984a1a38f5d38b606a1]
stable/5.4: [1200388a0b1c3c6fda48d4d2143db8f7e4ef5348]
stable/6.1: [d3b2d2820a005e43855fa71b80c4a4b194201c60]

CVE-2023-53022: net: enetc: avoid deadlock in enetc_tx_onestep_tstamp()

Announce: https://lore.kernel.org/linux-cve-announce/2025032718-CVE-2023-53022-b539@gregkh/

Introduced by commit 7294380 ("enetc: support PTP Sync packet one-step
timestamping") in v5.13-rc1.
Fixed in v6.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c463721a73bdb57a913e0d3124677a3758886fc]
stable/5.15: [8232e5a84d25a84a5cbda0f241a00793fb6eb608]
stable/6.1: [e893dced1a18e77b1262f5c10169413f0ece0da7]

CVE-2023-53023: net: nfc: Fix use-after-free in local_cleanup()

Announce: https://lore.kernel.org/linux-cve-announce/2025032718-CVE-2023-53023-ef4e@gregkh/

Introduced by commit 3536da0 ("NFC: llcp: Clean local timers and works
when removing a device") in v3.9-rc4.
Fixed in v6.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [54f7be61584b8ec4c6df405f479495b9397bae4a]
cip/4.4-st: [58241402242d3376af44454467ca3d0fc1b814f9]
mainline: [4bb4db7f3187c6e3de6b229ffc87cdb30a2d22b6]
stable/4.19: [54f7be61584b8ec4c6df405f479495b9397bae4a]
stable/5.10: [ad1baab3a5c03692d22ce446f38596a126377f6a]
stable/5.15: [7f129927feaf7c10b1c38bbce630172e9a08c834]
stable/5.4: [a59cdbda3714e11aa3ab579132864c4c8c6d54f9]
stable/6.1: [d3605282ec3502ec8847915eb2cf1f340493ff79]

CVE-2023-53024: bpf: Fix pointer-leak due to insufficient speculative
store bypass mitigation

Announce: https://lore.kernel.org/linux-cve-announce/2025032719-CVE-2023-53024-8d19@gregkh/

Introduced by commit 2039f26 ("bpf: Fix leakage due to insufficient
speculative store bypass mitigation") in v5.14-rc4.
Fixed in v6.2-rc5.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
cip/4.19-st: [aae109414a57ab4164218f36e2e4a17f027fcaaa]
mainline: [e4f4db47794c9f474b184ee1418f42e6a07412b6]
stable/4.19: [aae109414a57ab4164218f36e2e4a17f027fcaaa]
stable/5.10: [da75dec7c6617bddad418159ffebcb133f008262]
stable/5.15: [01bdcc73dbe7be3ad4d4ee9a59b71e42f461a528]
stable/5.4: [81b3374944d201872cfcf82730a7860f8e7c31dd]
stable/6.1: [b0c89ef025562161242a7c19b213bd6b272e93df]

CVE-2023-53025: NFSD: fix use-after-free in nfsd4_ssc_setup_dul()

Announce: https://lore.kernel.org/linux-cve-announce/2025032719-CVE-2023-53025-5662@gregkh/

Introduced by commit f4e44b3 ("NFSD: delay unmount source's export
after inter-server copy completed.") in v5.14-rc1.
Fixed in v6.1.9.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [32d5eb95f8f0e362e37c393310b13b9e95404560]
stable/5.10: [6ac4c383c39f8f2f955f868d1ad9365c2363e80b]
stable/5.15: [6ac4c383c39f8f2f955f868d1ad9365c2363e80b]
stable/6.1: [0a27dcd5343026ac0cb168ee63304255372b7a36]

CVE-2023-53026: RDMA/core: Fix ib block iterator counter overflow

Announce: https://lore.kernel.org/linux-cve-announce/2025032719-CVE-2023-53026-0e24@gregkh/

Introduced by commit a808273 ("RDMA/verbs: Add a DMA iterator to
return aligned contiguous memory blocks") in v5.2-rc1.
Fixed in v6.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0afec5e9cea732cb47014655685a2a47fb180c31]
stable/5.10: [d66c1d4178c219b6e7d7a6f714e3e3656faccc36]
stable/5.15: [362c9489720b31b6aa7491423ba65a4e98aa9838]
stable/5.4: [902063a9fea5f8252df392ade746bc9cfd07a5ae]
stable/6.1: [43811d07ea64366af8ec9e168c558ec51440c39e]

CVE-2023-53027: [REJECTED]: erofs: fix kvcalloc() misuse with __GFP_NOFAIL

Announce: https://lore.kernel.org/linux-cve-announce/2025032719-CVE-2023-53027-dc56@gregkh/

This CVE was rejected. Introduced by commit fe3e591 ("erofs: try to
leave (de)compressed_pages on stack if possible") in v6.0-rc1.
Introduced by commit 4f05687 ("erofs: introduce struct
z_erofs_decompress_backend") in v6.0-rc1.
Fixed in v6.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12724ba38992bd045e92a9a88a868a530f89d13e]
stable/6.1: [7b28a8920844042ca9f44934d8f15d210ef42c75]

CVE-2023-53028: Revert "wifi: mac80211: fix memory leak in ieee80211_if_add()"

Announce: https://lore.kernel.org/linux-cve-announce/2025032720-CVE-2023-53028-8be6@gregkh/

Introduced by 13e5afd ("wifi: mac80211: fix memory leak in
ieee80211_if_add()") in 6.2-rc1. Fixed in 6.2-rc5.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [80f8a66dede0a4b4e9e846765a97809c6fe49ce5]
stable/5.10: [71e5cd1018d345e649e63f74a56c1897f99db7e9]
stable/5.15: [982c8b1e95c088f5d8f65967ec25be66e961401c]
stable/6.1: [effecd8d116d3d3a28b4f628e61bba8d318fdfcf]

CVE-2023-53029: octeontx2-pf: Fix the use of GFP_KERNEL in atomic context on rt

Announce: https://lore.kernel.org/linux-cve-announce/2025032720-CVE-2023-53029-a670@gregkh/

Introduced by 4af1b64 ("octeontx2-pf: Fix lmtst ID used in aura free")
in 6.2-rc3. Fixed in 6.2-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [55ba18dc62deff5910c0fa64486dea1ff20832ff]
stable/5.15: [29e9c67bf3271067735c188e95cf3631ecd64d58]
stable/6.1: [659518e013d6bd562bb0f1d2d9f99d0ac54720e2]

CVE-2023-53030: octeontx2-pf: Avoid use of GFP_KERNEL in atomic context

Announce: https://lore.kernel.org/linux-cve-announce/2025032720-CVE-2023-53030-ba50@gregkh/

Introduced by 4af1b64 ("octeontx2-pf: Fix lmtst ID used in aura free")
in 6.2-rc3. fixed in 6.2-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [87b93b678e95c7d93fe6a55b0e0fbda26d8c7760]
stable/5.15: [2827c4eb429db64befdca11362e2b1c5f524f6ba]
stable/6.1: [1eb57b87f106c90cee6b2a56a10f2e29c7a25f3e]

CVE-2023-53031: powerpc/imc-pmu: Fix use of mutex in IRQs disabled section

Announce: https://lore.kernel.org/linux-cve-announce/2025032721-CVE-2023-53031-39cd@gregkh/

Introduced by commit 8f95faa ("powerpc/powernv: Detect and create IMC
device") in v4.14-rc1.
Fixed in v6.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [76d588dddc459fefa1da96e0a081a397c5c8e216]
stable/5.10: [8cbeb60320ac45a8240b561c8ef466b86c34dedc]
stable/5.15: [a90d339f1f66be4a946769b565668e2bd0686dfa]
stable/5.4: [d0c6d2a31026102d4738b47a610bed4401b9834f]
stable/6.1: [424bcb570cb320d1d15238cd4c933522b90f78fa]

CVE-2023-53032: netfilter: ipset: Fix overflow before widen in the
bitmap_ip_create() function.

Announce: https://lore.kernel.org/linux-cve-announce/2025032721-CVE-2023-53032-70ce@gregkh/

Introduced by commit b9fed74 ("netfilter: ipset: Check and reject
crazy /0 input parameters") in v3.7-rc1.
Fixed in v6.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [dfd834ccc1b88bbbab81b9046a3a539dd0c2d14f]
cip/4.4-st: [29ab601f9eafc450b8b243240432f732dbe64a6a]
mainline: [9ea4b476cea1b7d461d16dda25ca3c7e616e2d15]
stable/4.19: [dfd834ccc1b88bbbab81b9046a3a539dd0c2d14f]
stable/5.10: [4e6a70fd840400e3a2e784a6673968a3eb2431c0]
stable/5.15: [511cf17b2447fc41cfef8d71936e1fa53e395c1e]
stable/5.4: [feefb33eefa166fc3e0fd17547b0bc0cb3baced9]
stable/6.1: [e88865876d47c790be0d5e23973499d75d034364]

CVE-2023-53033: netfilter: nft_payload: incorrect arithmetics when
fetching VLAN header bits

Announce: https://lore.kernel.org/linux-cve-announce/2025032721-CVE-2023-53033-9089@gregkh/

Introduced by commit f6ae9f1 ("netfilter: nft_payload: add C-VLAN
support") in v5.5-rc1.
Fixed in v6.2-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [696e1a48b1a1b01edad542a1ef293665864a4dd0]
stable/5.10: [550efeff989b041f3746118c0ddd863c39ddc1aa]
stable/5.15: [a8acfe2c6fb99f9375a9325807a179cd8c32e6e3]
stable/6.1: [76ef74d4a379faa451003621a84e3498044e7aa3]

CVE-2024-58090: sched/core: Prevent rescheduling when interrupts are disabled

Announce: https://lore.kernel.org/linux-cve-announce/2025032703-CVE-2024-58090-fddc@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc5.


Fixed status
mainline: [82c387ef7568c0d96a918a5a78d9cad6256cfa15]
stable/5.10: [1651f5731b378616565534eb9cda30e258cebebc]
stable/5.15: [288fdb8dcb71ec77b76ab8b8a06bc10f595ea504]
stable/5.4: [321794b75ac968f0bb6b9c913581949452a8d992]
stable/6.1: [84586322e010164eedddfcd0a0894206ae7d9317]
stable/6.6: [68786ab0935ccd5721283b7eb7f4d2f2942c7a52]

CVE-2024-58091: drm/fbdev-dma: Add shadow buffering for deferred I/O

Announce: https://lore.kernel.org/linux-cve-announce/2025032709-CVE-2024-58091-a2a4@gregkh/

Introduced by commit 5ab9144 ("drm/tiny/ili9225: Use fbdev-dma") in v6.11-rc1.
Fixed in v6.14-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3603996432997f7c88da37a97062a46cda01ac9d]

CVE-2025-21867: bpf, test_run: Fix use-after-free issue in eth_skb_pkt_type()

Announce: https://lore.kernel.org/linux-cve-announce/2025032732-CVE-2025-21867-3138@gregkh/

Introduced by commit be3d72a ("bpf: move user_size out of
bpf_test_init") in v5.18-rc1.
Fixed in v6.14-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6b3d638ca897e099fa99bd6d02189d3176f80a47]
stable/6.1: [f615fccfc689cb48977d275ac2e391297b52392b]
stable/6.6: [d56d8a23d95100b65f40438639dd82db2af81c11]

CVE-2025-21868: net: allow small head cache usage with large
MAX_SKB_FRAGS values

Announce: https://lore.kernel.org/linux-cve-announce/2025032734-CVE-2025-21868-ef4f@gregkh/

Introduced by commit 3948b05 ("net: introduce a config option to tweak
MAX_SKB_FRAGS") in v6.4-rc1.
Fixed in v6.14-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [14ad6ed30a10afbe91b0749d6378285f4225d482]

CVE-2025-21869: powerpc/code-patching: Disable KASAN report during
patching via temporary mm

Announce: https://lore.kernel.org/linux-cve-announce/2025032734-CVE-2025-21869-b4a7@gregkh/

Introduced by commit 465cabc ("powerpc/code-patching: introduce
patch_instructions()") in v6.7-rc1.
Fixed in v6.14-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc9c5166c3cb044f8a001e397195242fd6796eee]

CVE-2025-21870: ASoC: SOF: ipc4-topology: Harden loops for looking up
ALH copiers

Announce: https://lore.kernel.org/linux-cve-announce/2025032735-CVE-2025-21870-4c78@gregkh/

Introduced by commit a150345 ("ASoC: SOF: ipc4-topology: add
SoundWire/ALH aggregation support") in v6.0-rc1.
Fixed in v6.14-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6fd60136d256b3b948333ebdb3835f41a95ab7ef]

CVE-2025-21871: tee: optee: Fix supplicant wait loop

Announce: https://lore.kernel.org/linux-cve-announce/2025032735-CVE-2025-21871-bb8c@gregkh/

Introduced by commit 4fb0a5e ("tee: add OP-TEE driver") in v4.12-rc1.
Fixed in v6.14-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [70b0d6b0a199c5a3ee6c72f5e61681ed6f759612]
stable/5.10: [0180cf0373f84fff61b16f8c062553a13dd7cfca]
stable/5.15: [c0a9a948159153be145f9471435695373904ee6d]
stable/5.4: [3eb4911364c764572e9db4ab900a57689a54e8ce]
stable/6.1: [ec18520f5edc20a00c34a8c9fdd6507c355e880f]
stable/6.6: [d61cc1a435e6894bfb0dd3370c6f765d2d12825d]

CVE-2025-21872: efi: Don't map the entire mokvar table to determine its size

Announce: https://lore.kernel.org/linux-cve-announce/2025032709-CVE-2025-21872-574e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc5.
Affected file was introduced by commit 58c9090 ("efi: Support for MOK
variable config table") in 5.10-rc1.

Fixed status
mainline: [2b90e7ace79774a3540ce569e000388f8d22c9e0]
stable/5.10: [46c0454ffb78ce9d3355a3cccac86383ea8ddd55]
stable/6.6: [ea3f0b362dfe4ef885ef812bfaf4088176422c91]

CVE-2025-21873: scsi: ufs: core: bsg: Fix crash when arpmb command fails

Announce: https://lore.kernel.org/linux-cve-announce/2025032709-CVE-2025-21873-311e@gregkh/

Introduced by commit 6ff265f ("scsi: ufs: core: bsg: Add advanced RPMB
support in ufs_bsg") in v6.3-rc1.
Fixed in v6.14-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f27a95845b01e86d67c8b014b4f41bd3327daa63]
stable/6.6: [32fb5ec825f6f76bc28902181c65429a904a07fe]

CVE-2025-21874: dm-integrity: Avoid divide by zero in table status in
Inline mode

Announce: https://lore.kernel.org/linux-cve-announce/2025032710-CVE-2025-21874-d5d9@gregkh/

Introduced by commit fb09876 ("dm-integrity: introduce the Inline
mode") in v6.11-rc1.
Fixed in v6.14-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7fb39882b20c98a9a393c244c86b56ef6933cff8]

CVE-2025-21875: mptcp: always handle address removal under msk socket lock

Announce: https://lore.kernel.org/linux-cve-announce/2025032710-CVE-2025-21875-8eca@gregkh/

Introduced by commit b6c0838 ("mptcp: remove addr and subflow in PM
netlink") in v5.10-rc1.
Fixed in v6.14-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f865c24bc55158313d5779fc81116023a6940ca3]
stable/5.10: [494ec285535632732eaa5786297a9ae4f731b5ff]
stable/5.15: [7cca31035c05819643ffb5d7518e9a331b3f6651]
stable/6.1: [8116fb4acd5d3f06cd37f84887dbe962b6703b1c]
stable/6.6: [a05da2be18aae7e82572f8d795f41bb49f5dfc7d]

CVE-2025-21876: iommu/vt-d: Fix suspicious RCU usage

Announce: https://lore.kernel.org/linux-cve-announce/2025032710-CVE-2025-21876-6c2f@gregkh/

Introduced by commit d74169c ("iommu/vt-d: Allocate DMAR fault
interrupts locally") in v6.10-rc1.
Fixed in v6.14-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b150654f74bf0df8e6a7936d5ec51400d9ec06d8]

CVE-2025-21877: usbnet: gl620a: fix endpoint checking in genelink_bind()

Announce: https://lore.kernel.org/linux-cve-announce/2025032711-CVE-2025-21877-de70@gregkh/

Introduced by commit 47ee305 ("[PATCH] USB: usbnet (5/9) module for
genesys gl620a cables") in v2.6.20.16.
Fixed in v6.14-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1cf9631d836b289bd5490776551961c883ae8a4f]
stable/5.10: [24dd971104057c8828d420a48e0a5af6e6f30d3e]
stable/5.15: [9bcb8cbc3e5d67eb223bfb7e2291a270dbb699dc]
stable/5.4: [5f2dbabbce04b1ffcd6d8d07564adb94db577536]
stable/6.1: [67ebc3391c8377738e97a43374054d9718fdb6e4]
stable/6.6: [a2ee5e55b50a97d13617c8653482c0ad4decff8c]

CVE-2025-21878: i2c: npcm: disable interrupt enable bit before devm_request_irq

Announce: https://lore.kernel.org/linux-cve-announce/2025032711-CVE-2025-21878-3c82@gregkh/

Introduced by commit 56a1485 ("i2c: npcm7xx: Add Nuvoton NPCM I2C
controller driver") in v5.8-rc1.
Fixed in v6.14-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd1998e243f5fa25d348a384ba0b6c84d980f2b2]
stable/5.10: [f32d7b4dc6e791523c70e83049645dcba2a2aa33]
stable/5.15: [e3aea1dba97d31eceed7b622000af0406988b9c8]
stable/6.1: [545b563eb00d0576775da4011b3f7ffefc9e8c60]
stable/6.6: [1b267e1b87d52b16e7dfcc7ab2ab760f6f8f9ca9]

CVE-2025-21879: btrfs: fix use-after-free on inode when scanning root
during em shrinking

Announce: https://lore.kernel.org/linux-cve-announce/2025032711-CVE-2025-21879-f338@gregkh/

Introduced by commit 1020443 ("btrfs: make the extent map shrinker run
asynchronously as a work queue job") in v6.13-rc1.
Fixed in v6.14-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [59f37036bb7ab3d554c24abc856aabca01126414]

CVE-2025-21880: drm/xe/userptr: fix EFAULT handling

Announce: https://lore.kernel.org/linux-cve-announce/2025032711-CVE-2025-21880-f716@gregkh/

Introduced by commit 521db22 ("drm/xe: Invalidate userptr VMA on page
pin fault") in v6.10-rc1.
Fixed in v6.14-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a9f4fa3a7efa65615ff7db13023ac84516e99e21]

CVE-2025-21881: uprobes: Reject the shared zeropage in uprobe_write_opcode()

Announce: https://lore.kernel.org/linux-cve-announce/2025032712-CVE-2025-21881-7a0f@gregkh/

Introduced by commit 7396fa8 ("uprobes/core: Make background page
replacement logic account for rss_stat counters") in v3.5-rc1.
Introduced by commit 2b14449 ("uprobes, mm, x86: Add the ability to
install and remove uprobes breakpoints") in v3.5-rc1.
Fixed in v6.14-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bddf10d26e6e5114e7415a0e442ec6f51a559468]
stable/6.1: [c4cb2bfa99513311886c1eb5c1c2ac26f3338a6e]
stable/6.6: [0b6f19714588cf2366b0364234f97ba963688f63]

CVE-2025-21882: net/mlx5: Fix vport QoS cleanup on error

Announce: https://lore.kernel.org/linux-cve-announce/2025032712-CVE-2025-21882-cc4d@gregkh/

Introduced by commit be034ba ("net/mlx5: Make vport QoS enablement
more flexible for future extensions") in v6.13-rc1.
Fixed in v6.14-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f3528f7d2f98b70e19a6bb7b130fc82c079ac54]

CVE-2025-21883: ice: Fix deinitializing VF in error path

Announce: https://lore.kernel.org/linux-cve-announce/2025032712-CVE-2025-21883-8b73@gregkh/

Introduced by commit 8cd8a6b ("ice: move VF overflow message count
into struct ice_mbx_vf_info") in v6.4-rc1.
Fixed in v6.14-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [79990cf5e7aded76d0c092c9f5ed31eb1c75e02c]
stable/6.6: [3c01102bec9592928e6b155da41cfcd5d25a2066]

CVE-2025-21884: net: better track kernel sockets lifetime

Announce: https://lore.kernel.org/linux-cve-announce/2025032713-CVE-2025-21884-b70c@gregkh/

Introduced by commit 0cafd77 ("net: add a refcount tracker for kernel
sockets") in v6.2-rc1.
Fixed in v6.14-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5c70eb5c593d64d93b178905da215a9fd288a4b5]

CVE-2025-21885: RDMA/bnxt_re: Fix the page details for the srq created
by kernel consumers

Announce: https://lore.kernel.org/linux-cve-announce/2025032713-CVE-2025-21885-be9d@gregkh/

Introduced by commit 0c4dcd6 ("RDMA/bnxt_re: Refactor hardware queue
memory allocation") in v5.7-rc1.
Fixed in v6.14-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b66535356a4834a234f99e16a97eb51f2c6c5a7d]

CVE-2025-21886: RDMA/mlx5: Fix implicit ODP hang on parent deregistration

Announce: https://lore.kernel.org/linux-cve-announce/2025032713-CVE-2025-21886-9ca3@gregkh/

Introduced by d3d9304 ("RDMA/mlx5: Fix implicit ODP use after free")
in 6.14-rc1. Fixed in 6.14-rc5.

Bug introduced commit was backported to following branches.
stable/6.12 stable/6.13

Fixed status
mainline: [3d8c6f26893d55fab218ad086719de1fc9bb86ba]

CVE-2025-21887: ovl: fix UAF in ovl_dentry_update_reval by moving
dput() in ovl_link_up

Announce: https://lore.kernel.org/linux-cve-announce/2025032714-CVE-2025-21887-48e8@gregkh/

Introduced by commit b07d5cc ("ovl: update of dentry revalidate flags
after copy up") in v6.5-rc1.
Fixed in v6.14-rc5.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [c84e125fff2615b4d9c259e762596134eddd2f27]
stable/5.15: [4b49d939b5a79117f939b77cc67efae2694d9799]
stable/6.1: [a7c41830ffcd17b2177a95a9b99b270302090c35]
stable/6.6: [64455c8051c3aedc71abb7ec8d47c80301f99f00]

CVE-2025-21888: RDMA/mlx5: Fix a WARN during dereg_mr for DM type

Announce: https://lore.kernel.org/linux-cve-announce/2025032714-CVE-2025-21888-0f83@gregkh/

Introduced by commit f18ec42 ("RDMA/mlx5: Use a union inside
mlx5_ib_mr") in v5.13-rc1.
Fixed in v6.14-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [abc7b3f1f056d69a8f11d6dceecc0c9549ace770]

CVE-2025-21889: perf/core: Add RCU read lock protection to perf_iterate_ctx()

Announce: https://lore.kernel.org/linux-cve-announce/2025032714-CVE-2025-21889-0913@gregkh/

Introduced by commit bd27568 ("perf: Rewrite core context handling")
in v6.2-rc1.
Fixed in v6.14-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0fe8813baf4b2e865d3b2c735ce1a15b86002c74]
stable/6.6: [f390c2eea571945f357a2d3b9fcb1c015767132e]

CVE-2025-21890: idpf: fix checksums set in idpf_rx_rsc()

Announce: https://lore.kernel.org/linux-cve-announce/2025032714-CVE-2025-21890-f286@gregkh/

Introduced by commit 3a8845a ("idpf: add RX splitq napi poll support")
in v6.7-rc1.
Fixed in v6.14-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [674fcb4f4a7e3e277417a01788cc6daae47c3804]

CVE-2025-21891: ipvlan: ensure network headers are in skb linear part

Announce: https://lore.kernel.org/linux-cve-announce/2025032715-CVE-2025-21891-8717@gregkh/

Introduced by commit 2ad7bf3 ("ipvlan: Initial check-in of the IPVLAN
driver.") in v3.19-rc1.
Fixed in v6.14-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [27843ce6ba3d3122b65066550fe33fb8839f8aef]
stable/6.1: [5b8dea8d1612dc7151d2457d7d2e6a69820309bf]
stable/6.6: [4ec48f812804f370f622e0874e6dd8fcc58241cd]

CVE-2025-21892: RDMA/mlx5: Fix the recovery flow of the UMR QP

Announce: https://lore.kernel.org/linux-cve-announce/2025032715-CVE-2025-21892-12a2@gregkh/

Introduced by commit 158e71b ("RDMA/mlx5: Add a umr recovery flow") in v6.0-rc1.
Fixed in v6.14-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d97505baea64d93538b16baf14ce7b8c1fbad746]

CVE-2025-21893: keys: Fix UAF in key_put()

Announce: https://lore.kernel.org/linux-cve-announce/2025033126-CVE-2025-21893-f2b4@gregkh/

Introduced by commit 9578e32 ("keys: update key quotas in key_put()")
in v6.10-rc1.
Fixed in v6.14.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [75845c6c1a64483e9985302793dbf0dfa5f71e32]

CVE-2025-21894: net: enetc: VFs do not support HWTSTAMP_TX_ONESTEP_SYNC

Announce: https://lore.kernel.org/linux-cve-announce/2025040130-CVE-2025-21894-60f0@gregkh/

Introduced by commit 4151473 ("enetc: add get_ts_info interface for
ethtool") in v5.3-rc1.
Fixed in v6.14-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a562d0c4a893eae3ea51d512c4d90ab858a6b7ec]
stable/6.6: [1748531839298ab7be682155f6cd98ae04773e6a]

CVE-2025-21895: perf/core: Order the PMU list to fix warning about
unordered pmu_ctx_list

Announce: https://lore.kernel.org/linux-cve-announce/2025040132-CVE-2025-21895-5c1a@gregkh/

Introduced by commit bd27568 ("perf: Rewrite core context handling")
in v6.2-rc1.
Fixed in v6.14-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2016066c66192a99d9e0ebf433789c490a6785a2]
stable/6.6: [f0c3971405cef6892844016aa710121a02da3a23]

CVE-2025-21896: fuse: revert back to __readahead_folio() for readahead

Announce: https://lore.kernel.org/linux-cve-announce/2025040132-CVE-2025-21896-395c@gregkh/

Introduced by commit 3eab9d7 ("fuse: convert readahead to use folios")
in v6.13-rc1.
Fixed in v6.14-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c67c37e1710b2a8f61c8a02db95a51fe577e2c1]

CVE-2025-21897: sched_ext: Fix pick_task_scx() picking non-queued
tasks when it's called without balance()

Announce: https://lore.kernel.org/linux-cve-announce/2025040132-CVE-2025-21897-241f@gregkh/

Introduced by commit a6250aa ("sched_ext: Handle cases where
pick_task_scx() is called without preceding balance_scx()") in v6.12.
Fixed in v6.14-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8fef0a3b17bb258130a4fcbcb5addf94b25e9ec5]

CVE-2025-21898: ftrace: Avoid potential division by zero in function_stat_show()

Announce: https://lore.kernel.org/linux-cve-announce/2025040132-CVE-2025-21898-22dd@gregkh/

Introduced by commit e31f793 ("ftrace: Avoid potential division by
zero in function profiler") in v5.5-rc6.
Fixed in v6.14-rc5.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st stable/5.4

Fixed status
mainline: [a1a7eb89ca0b89dc1c326eeee2596f263291aca3]
stable/5.10: [ca381f60a3bb7cfaa618d73ca411610bd7fc3149]
stable/5.15: [3d738b53ed6cddb68e68c9874520a4bf846163b5]
stable/5.4: [5b3d32f607f0478b414b16516cf27f9170cf66c8]
stable/6.1: [992775227843c9376773784b8b362add44592ad7]
stable/6.6: [f58a3f8e284d0bdf94164a8e61cd4e70d337a1a3]

CVE-2025-21899: tracing: Fix bad hist from corrupting named_triggers list

Announce: https://lore.kernel.org/linux-cve-announce/2025040132-CVE-2025-21899-bf75@gregkh/

Introduced by commit 067fe03 ("tracing: Add variable reference
handling to hist triggers") in v4.17-rc1.
Fixed in v6.14-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f86bdeab633a56d5c6dccf1a2c5989b6a5e323e]
stable/6.1: [5ae1b18f05ee2b849dc03b6c15d7da0c1c6efa77]
stable/6.6: [43b254d46c740bf9dbe65709afa021dd726dfa99]

CVE-2025-21900: NFSv4: Fix a deadlock when recovering state on a
sillyrenamed file

Announce: https://lore.kernel.org/linux-cve-announce/2025040133-CVE-2025-21900-8d31@gregkh/

Introduced by commit adb4b42 ("Return the delegation when deleting
sillyrenamed files") in v6.11-rc1.
Fixed in v6.14-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8f8df955f078e1a023ee55161935000a67651f38]

CVE-2025-21901: RDMA/bnxt_re: Add sanity checks on rdev validity

Announce: https://lore.kernel.org/linux-cve-announce/2025040133-CVE-2025-21901-8898@gregkh/

Introduced by commit cc5b9b4 ("RDMA/bnxt_re: Recover the device when
FW error is detected") in v6.12-rc1.
Fixed in v6.14-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0df225d12fcb049429fb5bf5122afe143c2dd15]

CVE-2025-21902: acpi: typec: ucsi: Introduce a ->poll_cci method

Announce: https://lore.kernel.org/linux-cve-announce/2025040126-CVE-2025-21902-ce66@gregkh/

Introduced by commit fa48d7e ("usb: typec: ucsi: Do not call ACPI _DSM
method for UCSI read operations") in v6.13-rc1.
Fixed in v6.14-rc6.

Bug introduced commit was backported to following branches.
stable/6.12

Fixed status
mainline: [976e7e9bdc7719a023a4ecccd2e3daec9ab20a40]

CVE-2025-21903: mctp i3c: handle NULL header address

Announce: https://lore.kernel.org/linux-cve-announce/2025040128-CVE-2025-21903-4dbf@gregkh/

Introduced by commit c8755b2 ("mctp i3c: MCTP I3C driver") in v6.7-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf7ee25e70c6edfac4553d6b671e8b19db1d9573]

CVE-2025-21904: caif_virtio: fix wrong pointer check in cfv_probe()

Announce: https://lore.kernel.org/linux-cve-announce/2025040129-CVE-2025-21904-cd79@gregkh/

Introduced by commit 0d2e1a2 ("caif_virtio: Introduce caif over
virtio") in v3.10-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a466fd7e9fafd975949e5945e2f70c33a94b1a70]
stable/5.10: [7b5fe58959822e6cfa884327cabba6be3b01883d]
stable/5.15: [8e4e08ca4cc634b337bb74bc9a70758fdeda0bcb]
stable/5.4: [990fff6980d0c1693d60a812f58dbf93eab0473f]
stable/6.1: [29e0cd296c87240278e2f7ea4cf3f496b60c03af]
stable/6.6: [90d302619ee7ce5ed0c69c29c290bdccfde66418]

CVE-2025-21905: wifi: iwlwifi: limit printed string from FW file

Announce: https://lore.kernel.org/linux-cve-announce/2025040129-CVE-2025-21905-348b@gregkh/

Introduced by commit aee1b63 ("iwlwifi: support fseq tlv and print
fseq version") in v5.2-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0dc2c1bef722cbf16ae557690861e5f91208129]
stable/5.10: [c0e626f2b2390472afac52dfe72b29daf9ed8e1d]
stable/5.15: [47616b82f2d42ea2060334746fed9a2988d845c9]
stable/5.4: [38f0d398b6d7640d223db69df022c4a232f24774]
stable/6.1: [88ed69f924638c7503644e1f8eed1e976f3ffa7a]
stable/6.6: [b02f8d5a71c8571ccf77f285737c566db73ef5e5]

CVE-2025-21906: wifi: iwlwifi: mvm: clean up ROC on failure

Announce: https://lore.kernel.org/linux-cve-announce/2025040129-CVE-2025-21906-de63@gregkh/

Introduced by commit 35c1bbd ("wifi: iwlwifi: mvm: remove
IWL_MVM_STATUS_NEED_FLUSH_P2P") in v6.9-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9751163bffd3fe60794929829f810968c6de73d]

CVE-2025-21907: mm: memory-failure: update ttu flag inside unmap_poisoned_folio

Announce: https://lore.kernel.org/linux-cve-announce/2025040129-CVE-2025-21907-5379@gregkh/

Introduced by commit 6da6b1d ("mm/hwpoison: convert
TTU_IGNORE_HWPOISON to TTU_HWPOISON") in v6.3-rc1.
Fixed in v6.14-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [b81679b1633aa43c0d973adfa816d78c1ed0d032]

CVE-2025-21908: NFS: fix nfs_release_folio() to not deadlock via
kcompactd writeback

Announce: https://lore.kernel.org/linux-cve-announce/2025040129-CVE-2025-21908-b8ce@gregkh/

Introduced by commit 96780ca ("NFS: fix up nfs_release_folio() to try
to release the page") in v6.3-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce6d9c1c2b5cc785016faa11b48b6cd317eb367e]
stable/6.6: [ab0727d6e2196682351c25c1dd112136f6991f11]

CVE-2025-21909: wifi: nl80211: reject cooked mode if it is set along
with other flags

Announce: https://lore.kernel.org/linux-cve-announce/2025040129-CVE-2025-21909-90df@gregkh/

Introduced by commit 66f7ac5 ("nl80211: Add monitor interface
configuration flags") in v2.6.26-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [49f27f29446a5bfe633dd2cc0cfebd48a1a5e77f]
stable/5.10: [351eb7ac53ff1cd94d893c0c4534ced2f36ae7d7]
stable/5.15: [cd1bdcb77fdc03c253137e55bae10551b3481461]
stable/5.4: [5ea856d93794c4afa5542defd8c61f2708dc245a]
stable/6.1: [236f41ca728f23210b31ed2d1d8a6df575a4b2d6]
stable/6.6: [ebebbb0eded2ed9a1abfa31962f6fb699e6abce7]

CVE-2025-21910: wifi: cfg80211: regulatory: improve invalid hints checking

Announce: https://lore.kernel.org/linux-cve-announce/2025040130-CVE-2025-21910-1f2f@gregkh/

Introduced by commit 09d989d ("cfg80211: add regulatory hint
disconnect support") in v2.6.34-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [59b348be7597c4a9903cb003c69e37df20c04a30]
stable/5.10: [da3f599517ef2ea851208df3229d07728d238dc5]
stable/5.15: [6a5e3b23054cee3b92683d1467e3fa83921f5622]
stable/5.4: [62b1a9bbfebba4b4c2bb6c1ede9ef7ecee7a9ff6]
stable/6.1: [f4112cb477c727a65787a4065a75ca593bb5b2f4]
stable/6.6: [35ef07112b61b06eb30683a6563c9f6378c02476]

CVE-2025-21911: drm/imagination: avoid deadlock on fence release

Announce: https://lore.kernel.org/linux-cve-announce/2025040130-CVE-2025-21911-8a57@gregkh/

Introduced by commit eaf01ee ("drm/imagination: Implement job
submission and scheduling") in v6.8-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [df1a1ed5e1bdd9cc13148e0e5549f5ebcf76cf13]

CVE-2025-21912: gpio: rcar: Use raw_spinlock to protect register access

Announce: https://lore.kernel.org/linux-cve-announce/2025040130-CVE-2025-21912-5b97@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc6.


Fixed status
mainline: [f02c41f87cfe61440c18bf77d1ef0a884b9ee2b5]
stable/5.15: [7c1f36f9c9aca507d317479a3d3388150ae40a87]
stable/6.1: [3e300913c42041e81c5b17a970c4e078086ff2d1]
stable/6.6: [c10365031f16514a29c812cd909085a6e4ea4b61]

CVE-2025-21913: x86/amd_nb: Use rdmsr_safe() in amd_get_mmconfig_range()

Announce: https://lore.kernel.org/linux-cve-announce/2025040130-CVE-2025-21913-b942@gregkh/

Introduced by commit 3fac373 ("xen/pv: support selecting safe/unsafe
msr accesses") in v6.1-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [14cb5d83068ecf15d2da6f7d0e9ea9edbcbc0457]
stable/6.1: [0c65d13bdcc54e5b924ebe790f85a7f01bfe1cb1]
stable/6.6: [8f43ba5ee498fe037d1570f6868d9aeaf49dda80]

CVE-2025-21914: slimbus: messaging: Free transaction ID in delayed
interrupt scenario

Announce: https://lore.kernel.org/linux-cve-announce/2025040130-CVE-2025-21914-83dd@gregkh/

Introduced by commit afbdcc7 ("slimbus: Add messaging APIs to slimbus
framework") in v4.16-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dcb0d43ba8eb9517e70b1a0e4b0ae0ab657a0e5a]
stable/5.10: [a32e5198a9134772eb03f7b72a7849094c55bda9]
stable/5.15: [09d34c4cbc38485c7514069f25348e439555b282]
stable/5.4: [cec8c0ac173fe5321f03fdb1a09a9cb69bc9a9fe]
stable/6.1: [18ae4cee05c310c299ba75d7477dcf34be67aa16]
stable/6.6: [faac8e894014e8167471a8e4a5eb35a8fefbb82a]

CVE-2025-21915: cdx: Fix possible UAF error in driver_override_show()

Announce: https://lore.kernel.org/linux-cve-announce/2025040130-CVE-2025-21915-b56c@gregkh/

Introduced by commit 1f86a00 ("bus/fsl-mc: add support for
'driver_override' in the mc-bus") in v5.10-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [91d44c1afc61a2fec37a9c7a3485368309391e0b]
stable/6.6: [d7b339bbc887bcfc1a5b620bfc70c6fbb8f733bf]

CVE-2025-21916: usb: atm: cxacru: fix a flaw in existing endpoint checks

Announce: https://lore.kernel.org/linux-cve-announce/2025040131-CVE-2025-21916-28b9@gregkh/

Introduced by commit 2eabb65 ("usb: atm: cxacru: fix endpoint checking
in cxacru_bind()") in v6.10-rc6.
Fixed in v6.14-rc6.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [c90aad369899a607cfbc002bebeafd51e31900cd]
stable/5.10: [319529e0356bd904528c64647725a2272d297c83]
stable/5.15: [bf4409f84023b52b5e9b36c0a071a121eee42138]
stable/5.4: [dcd592ab9dd8a2bfc36e75583b9006db2a77ec24]
stable/6.1: [197e78076c5ecd895f109158c4ea2954b9919af6]
stable/6.6: [a0475a885d69849b1ade38add6d64338dfa83a8f]

CVE-2025-21917: usb: renesas_usbhs: Flush the notify_hotplug_work

Announce: https://lore.kernel.org/linux-cve-announce/2025040131-CVE-2025-21917-8a54@gregkh/

Introduced by commit bc57381 ("usb: renesas_usbhs: use delayed_work
instead of work_struct") in v3.0-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [552ca6b87e3778f3dd5b87842f95138162e16c82]
stable/5.10: [394965f90454d6f00fe11879142b720c6c1a872e]
stable/5.15: [3248c1f833f924246cb98ce7da4569133c1b2292]
stable/5.4: [4cd847a7b630a85493d0294ad9542c21aafaa246]
stable/6.1: [4ca078084cdd5f32d533311d6a0b63a60dcadd41]
stable/6.6: [d50f5c0cd949593eb9a3d822b34d7b50046a06b7]

CVE-2025-21918: usb: typec: ucsi: Fix NULL pointer access

Announce: https://lore.kernel.org/linux-cve-announce/2025040131-CVE-2025-21918-dc4c@gregkh/

Introduced by commit b9aa02c ("usb: typec: ucsi: Add polling mechanism
for partner tasks like alt mode checking") in v5.16-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b13abcb7ddd8d38de769486db5bd917537b32ab1]
stable/6.6: [46fba7be161bb89068958138ea64ec33c0b446d4]

CVE-2025-21919: sched/fair: Fix potential memory corruption in
child_cfs_rq_on_list

Announce: https://lore.kernel.org/linux-cve-announce/2025040131-CVE-2025-21919-5f2a@gregkh/

Introduced by commit fdaba61 ("sched/fair: Ensure that the CFS parent
is added after unthrottling") in v5.13.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3b4035ddbfc8e4521f85569998a7569668cccf51]
stable/5.15: [5cb300dcdd27e6a351ac02541e0231261c775852]
stable/6.1: [000c9ee43928f2ce68a156dd40bab7616256f4dd]
stable/6.6: [9cc7f0018609f75a349e42e3aebc3b0e905ba775]

CVE-2025-21920: vlan: enforce underlying device type

Announce: https://lore.kernel.org/linux-cve-announce/2025040131-CVE-2025-21920-08ff@gregkh/

Introduced by commit 22bedad ("net: convert multicast list to
list_head") in v2.6.35-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b33a534610067ade2bdaf2052900aaad99701353]
stable/5.10: [fa40ebef69234e39ec2d26930d045f2fb9a8cb2b]
stable/5.15: [0fb7aa04c19eac4417f360a9f7611a60637bdacc]
stable/5.4: [7f1564b2b2072b7aa1ac75350e9560a07c7a44fd]
stable/6.1: [5a515d13e15536e82c5c7c83eb6cf5bc4827fee5]
stable/6.6: [3561442599804905c3defca241787cd4546e99a7]

CVE-2025-21921: net: ethtool: netlink: Allow NULL nlattrs when getting
a phy_device

Announce: https://lore.kernel.org/linux-cve-announce/2025040131-CVE-2025-21921-9deb@gregkh/

Introduced by commit c15e065 ("net: ethtool: Allow passing a phy index
for some commands") in v6.12-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [637399bf7e77797811adf340090b561a8f9d1213]

CVE-2025-21922: ppp: Fix KMSAN uninit-value warning with bpf

Announce: https://lore.kernel.org/linux-cve-announce/2025040132-CVE-2025-21922-8c36@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c2d14c40a68678d885eab4008a0129646805bae]
stable/5.10: [2f591cb158807bdcf424f66f1fbfa6e4e50f3757]
stable/5.15: [4e2191b0fd0c064d37b0db67396216f2d4787e0f]
stable/5.4: [d685096c8129c9a92689975193e268945fd21dbf]
stable/6.1: [3de809a768464528762757e433cd50de35bcb3c1]
stable/6.6: [1eacd47636a9de5bee25d9d5962dc538a82d9f0b]

CVE-2025-21923: HID: hid-steam: Fix use-after-free when detaching device

Announce: https://lore.kernel.org/linux-cve-announce/2025040132-CVE-2025-21923-5c6e@gregkh/

Introduced by commit 7950424 ("HID: hid-steam: Move hidraw input
(un)registering to work")
in 6.14-rc3. Fixed in 6.14-rc6.

Bug introduced commit was backported to following branches.
stable/6.12 stable/6.13 stable/6.6

Fixed status
mainline: [e53fc232a65f7488ab75d03a5b95f06aaada7262]
stable/6.6: [026714ec7546de741826324a6a1914c91024d06c]

CVE-2025-21924: net: hns3: make sure ptp clock is unregister and freed
if hclge_ptp_get_cycle returns an error

Announce: https://lore.kernel.org/linux-cve-announce/2025040132-CVE-2025-21924-3a08@gregkh/

Introduced by commit 8373cd3 ("net: hns3: change the method of
obtaining default ptp cycle") in v5.14-rc4.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b7365eab39831487a84e63a9638209b68dc54008]
stable/5.15: [b7d8d4529984e2d4a72a6d552fb886233e8e83cb]
stable/6.1: [33244e98aa9503585e585335fe2ceb4492630949]
stable/6.6: [2c04e507f3a5c5dc6e2b9ab37d8cdedee1ef1a37]

CVE-2025-21925: llc: do not use skb_get() before dev_queue_xmit()

Announce: https://lore.kernel.org/linux-cve-announce/2025040132-CVE-2025-21925-89e0@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [64e6a754d33d31aa844b3ee66fb93ac84ca1565e]
stable/5.10: [13f3f872627f0f27c31245524fc11367756240ad]
stable/5.15: [9b6f083db141ece0024be01526aa05aa978811cb]
stable/5.4: [cd1c44327bbbd50fc24f2b38892f5f328b784d0f]
stable/6.1: [17f86e25431ebc15aa9245ff156414fdad47822d]
stable/6.6: [416e8b4c20c6398044e93008deefd563289f477d]

CVE-2025-21926: net: gso: fix ownership in __udp_gso_segment

Announce: https://lore.kernel.org/linux-cve-announce/2025040132-CVE-2025-21926-fd40@gregkh/

Introduced by commit ad40585 ("udp: better wmem accounting on gso") in
v4.18-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee01b2f2d7d0010787c2343463965bbc283a497f]
stable/5.10: [a2d1cca955ed34873e524cc2e6e885450d262f05]
stable/5.15: [455217ac9db0cf9349b3933664355e907bb1a569]
stable/5.4: [9f28205ddb76e86cac418332e952241d85fed0dc]
stable/6.1: [e8db70537878e1bb3fd83e5abcc6feefc0587828]
stable/6.6: [01a83237644d6822bc7df2c5564fc81b0df84358]

CVE-2025-21927: nvme-tcp: fix potential memory corruption in nvme_tcp_recv_pdu()

Announce: https://lore.kernel.org/linux-cve-announce/2025040133-CVE-2025-21927-36d6@gregkh/

Introduced by commit 3f2304f ("nvme-tcp: add NVMe over TCP host
driver") in v5.0-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ad95bab0cd28ed77c2c0d0b6e76e03e031391064]

CVE-2025-21928: HID: intel-ish-hid: Fix use-after-free issue in
ishtp_hid_remove()

Announce: https://lore.kernel.org/linux-cve-announce/2025040133-CVE-2025-21928-e444@gregkh/

Introduced by commit 0b28cb4 ("HID: intel-ish-hid: ISH HID client
driver") in v4.9-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [07583a0010696a17fb0942e0b499a62785c5fc9f]
stable/5.10: [d3faae7f42181865c799d88c5054176f38ae4625]
stable/5.15: [01b18a330cda61cc21423a7d1af92cf31ded8f60]
stable/5.4: [0c1fb475ef999d6c22fc3f963fdf20cb3ed1b03d]
stable/6.1: [cf1a6015d2f6b1f0afaa0fd6a0124ff2c7943394]
stable/6.6: [560f4d1299342504a6ab8a47f575b5e6b8345ada]

CVE-2025-21929: HID: intel-ish-hid: Fix use-after-free issue in
hid_ishtp_cl_remove()

Announce: https://lore.kernel.org/linux-cve-announce/2025040133-CVE-2025-21929-bf29@gregkh/

Introduced by commit f645a90 ("HID: intel-ish-hid: ishtp-hid-client:
use helper functions for connection") in v6.8-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [823987841424289339fdb4ba90e6d2c3792836db]

CVE-2025-21930: wifi: iwlwifi: mvm: don't try to talk to a dead firmware

Announce: https://lore.kernel.org/linux-cve-announce/2025040133-CVE-2025-21930-cc02@gregkh/

Introduced by commit 268712d ("wifi: iwlwifi: mvm: add a debugfs hook
to clear the monitor data") in v6.8-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d73d2c6e3313f0ba60711ab4f4b9044eddca9ca5]

CVE-2025-21931: hwpoison, memory_hotplug: lock folio before unmap
hwpoisoned folio

Announce: https://lore.kernel.org/linux-cve-announce/2025040133-CVE-2025-21931-3d56@gregkh/

Introduced by commit b15c872 ("hwpoison, memory_hotplug: allow
hwpoisoned pages to be offlined") in v5.0-rc1.
Fixed in v6.14-rc6.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [af288a426c3e3552b62595c6138ec6371a17dbba]

CVE-2025-21932: mm: abort vma_modify() on merge out of memory failure

Announce: https://lore.kernel.org/linux-cve-announce/2025040133-CVE-2025-21932-98f8@gregkh/

Introduced by commit 2f1c661 ("mm: introduce vma_merge_struct and
abstract vma_merge(),vma_modify()") in v6.12-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47b16d0462a460000b8f05dfb1292377ac48f3ca]

CVE-2025-21933: arm: pgtable: fix NULL pointer dereference issue

Announce: https://lore.kernel.org/linux-cve-announce/2025040134-CVE-2025-21933-2f5b@gregkh/

Introduced by commit fc9c45b ("arm: adjust_pte() use
pte_offset_map_rw_nolock()") in v6.13-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a564ccfe300fa6a065beda06ab7f3c140d6b4d63]

CVE-2025-21934: rapidio: fix an API misues when rio_add_net() fails

Announce: https://lore.kernel.org/linux-cve-announce/2025040134-CVE-2025-21934-1a8d@gregkh/

Introduced by commit e8de370 ("rapidio: add mport char device driver")
in v4.6-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b2ef51c74b0171fde7eb69b6152d3d2f743ef269]
stable/5.10: [88ddad53e4cfb6de861c6d4fb7b25427f46baed5]
stable/5.15: [cdd9f58f7fe41a55fae4305ea51fc234769fd466]
stable/5.4: [d4ec862ce80f64db923a1d942b5d11cf6fc87d36]
stable/6.1: [a5f5e520e8fbc6294020ff8afa36f684d92c6e6a]
stable/6.6: [2537f01d57f08c527e40bbb5862aa6ff43344898]

CVE-2025-21935: rapidio: add check for rio_add_net() in rio_scan_alloc_net()

Announce: https://lore.kernel.org/linux-cve-announce/2025040134-CVE-2025-21935-4288@gregkh/

Introduced by commit e6b585c ("rapidio: move net allocation into core
code") in v4.6-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e842f9a1edf306bf36fe2a4d847a0b0d458770de]
stable/5.10: [4f3509cfcc02e9d757f2714bb7dbbeec35de6fa7]
stable/5.15: [181d4daaefb3bceeb2f2635ba9f3781eeda9e550]
stable/5.4: [6d22953c4a183d0b7fdf34d68c5debd16da6edc5]
stable/6.1: [ad82be4298a89a9ae46f07128bdf3d8614bce745]
stable/6.6: [e6411c3b9512dba09af7d014d474516828c89706]

CVE-2025-21936: Bluetooth: Add check for mgmt_alloc_skb() in
mgmt_device_connected()

Announce: https://lore.kernel.org/linux-cve-announce/2025040134-CVE-2025-21936-fe95@gregkh/

Introduced by commit e967414 ("Bluetooth: mgmt: Make use of
mgmt_send_event_skb in MGMT_EV_DEVICE_CONNECTED") in v5.17-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d8df010f72b8a32aaea393e36121738bb53ed905]
stable/6.1: [dc516e66fb28c61b248b393e2ddd63bd7f104969]
stable/6.6: [bdb1805c248e9694dbb3ffa8867cef2e52cf7261]

CVE-2025-21937: Bluetooth: Add check for mgmt_alloc_skb() in mgmt_remote_name()

Announce: https://lore.kernel.org/linux-cve-announce/2025040134-CVE-2025-21937-90a8@gregkh/

Introduced by commit ba17bb6 ("Bluetooth: Fix skb allocation in
mgmt_remote_name() & mgmt_device_connected()") in v5.18-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f2176a07e7b19f73e05c805cf3d130a2999154cb]
stable/6.1: [37785a01040cb5d11ed0ddbcbf78491fcd073161]
stable/6.6: [c5845c73cbacf5704169283ef29ca02031a36564]

CVE-2025-21938: mptcp: fix 'scheduling while atomic' in
mptcp_pm_nl_append_new_local_addr

Announce: https://lore.kernel.org/linux-cve-announce/2025040134-CVE-2025-21938-3b75@gregkh/

Introduced by commit d045b9e ("mptcp: introduce implicit endpoints")
in v5.18-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [022bfe24aad8937705704ff2e414b100cf0f2e1a]
stable/6.1: [f1404f368c40fc6a068dad72e4ee0824ee6a78ee]
stable/6.6: [f3fcdb2de9fdbed9d8c6a8eb2c5fbd7d6f54a4d8]

CVE-2025-21939: drm/xe/hmm: Don't dereference struct page pointers
without notifier lock

Announce: https://lore.kernel.org/linux-cve-announce/2025040135-CVE-2025-21939-b7d7@gregkh/

Introduced by commit 81e058a ("drm/xe: Introduce helper to populate
userptr") in v6.10-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0a98219bcc961edd3388960576e4353e123b4a51]

CVE-2025-21940: drm/amdkfd: Fix NULL Pointer Dereference in KFD queue

Announce: https://lore.kernel.org/linux-cve-announce/2025040135-CVE-2025-21940-f9e9@gregkh/

Introduced by commit 629568d ("drm/amdkfd: Validate queue cwsr area
and eop buffer size") in v6.12-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd617ea3b79d2116d53f76cdb5a3601c0ba6e42f]

CVE-2025-21941: drm/amd/display: Fix null check for
pipe_ctx->plane_state in resource_build_scaling_params

Announce: https://lore.kernel.org/linux-cve-announce/2025040135-CVE-2025-21941-8240@gregkh/

Introduced by commit 3be5262 ("drm/amd/display: Rename more dc_surface
stuff to plane_state") in v4.15-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [374c9faac5a763a05bc3f68ad9f73dab3c6aec90]
stable/6.1: [c1e54752dc12e90305eb0475ca908f42f5b369ca]
stable/6.6: [3b3c2be58d5275aa59d8b4810a59f173f2f5bac1]

CVE-2025-21942: btrfs: zoned: fix extent range end unlock in cow_file_range()

Announce: https://lore.kernel.org/linux-cve-announce/2025040135-CVE-2025-21942-2957@gregkh/

Introduced by commit 06f3642 ("btrfs: do proper folio cleanup when
cow_file_range()
failed") in 6.14-rc1. Fixed in 6.14-rc6.

Bug introduced commit was backported to following branches.
stable/6.13

Fixed status
mainline: [5a4041f2c47247575a6c2e53ce14f7b0ac946c33]

CVE-2025-21943: gpio: aggregator: protect driver attr handlers against
module unload

Announce: https://lore.kernel.org/linux-cve-announce/2025040135-CVE-2025-21943-2255@gregkh/

Introduced by commit 828546e ("gpio: Add GPIO Aggregator") in v5.8-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12f65d1203507f7db3ba59930fe29a3b8eee9945]
stable/5.10: [fd6aa1f8cbe0979eb66ac32ebc231bf0b10a2117]
stable/5.15: [807789018186cf508ceb3a1f8f02935cd195717b]
stable/6.1: [9334c88fc2fbc6836b307d269fcc1744c69701c0]
stable/6.6: [d99dc8f7ea01ee1b21306e0eda8eb18a4af80db6]

CVE-2025-21944: ksmbd: fix bug on trap in smb2_lock

Announce: https://lore.kernel.org/linux-cve-announce/2025040135-CVE-2025-21944-d6eb@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc6.
It seems as if it was introduced by commit e2f34481 ("cifsd: add server-side
procedures for SMB3") in 5.15-rc1.

Fixed status
mainline: [e26e2d2e15daf1ab33e0135caf2304a0cfa2744b]
stable/6.1: [11e0e74e14f1832a95092f2c98ed3b99f57797ee]
stable/6.6: [8994f0ce8259f812b4f4a681d8298c6ff682efaa]

CVE-2025-21945: ksmbd: fix use-after-free in smb2_lock

Announce: https://lore.kernel.org/linux-cve-announce/2025040136-CVE-2025-21945-d791@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc6.
It seems as if it was introduced by commit e2f34481 ("cifsd: add server-side
procedures for SMB3") in 5.15-rc1.

Fixed status
mainline: [84d2d1641b71dec326e8736a749b7ee76a9599fc]
stable/6.1: [410ce35a2ed6d0e114132bba29af49b69880c8c7]
stable/6.6: [8573571060ca466cbef2c6f03306b2cc7b883506]

CVE-2025-21946: ksmbd: fix out-of-bounds in parse_sec_desc()

Announce: https://lore.kernel.org/linux-cve-announce/2025040136-CVE-2025-21946-63a2@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc6.
ksmbd was introduced in 5.15.

Fixed status
mainline: [d6e13e19063db24f94b690159d0633aaf72a0f03]
stable/6.6: [c1569dbbe2d43041be9f3fef7ca08bec3b66ad1b]

CVE-2025-21947: ksmbd: fix type confusion via race condition when
using ipc_msg_send_request

Announce: https://lore.kernel.org/linux-cve-announce/2025040136-CVE-2025-21947-fcc5@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc6.
It looks as if this bug was introduced by commit 0626e66 ("cifsd: add
server handler for central processing and tranport layers") in
5.15-rc1.

Fixed status
mainline: [e2ff19f0b7a30e03516e6eb73b948e27a55bc9d2]
stable/6.1: [6321bbda4244b93802d61cfe0887883aae322f4b]
stable/6.6: [76861630b29e51373e73e7b00ad0d467b6941162]

CVE-2025-21948: HID: appleir: Fix potential NULL dereference at raw event handle

Announce: https://lore.kernel.org/linux-cve-announce/2025040136-CVE-2025-21948-cbbb@gregkh/

Introduced by commit 9a4a557 ("HID: appleir: add support for Apple ir
devices") in v3.10-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ff5baa9b5275e3acafdf7f2089f74cccb2f38d1]
stable/5.10: [0df1ac8ee417ad76760ff076faa4518a4d861894]
stable/5.15: [b1d95d733cd6e74f595653daddcfc357bea461e8]
stable/5.4: [6db423b00940b05df2a1265d3c7eabafe9f1734c]
stable/6.1: [8d39eb8c5e14f2f0f441eed832ef8a7b654e6fee]
stable/6.6: [fc69e2c3219d433caabba4b5d6371ba726a4b37f]

CVE-2025-21949: LoongArch: Set hugetlb mmap base address aligned with pmd size

Announce: https://lore.kernel.org/linux-cve-announce/2025040136-CVE-2025-21949-e05a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc6.


Fixed status
mainline: [3109d5ff484b7bc7b955f166974c6776d91f247b]

CVE-2025-21950: drivers: virt: acrn: hsm: Use kzalloc to avoid info
leak in pmcmd_ioctl

Announce: https://lore.kernel.org/linux-cve-announce/2025040136-CVE-2025-21950-11d2@gregkh/

Introduced by commit 3d679d5 ("virt: acrn: Introduce interfaces to
query C-states and P-states allowed by hypervisor") in v5.12-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [819cec1dc47cdeac8f5dd6ba81c1dbee2a68c3bb]
stable/5.15: [4e15cf870d2c748e45d45ffc4d5b1dc1b7d50120]
stable/6.1: [524f29d78c9bdeb49f31f5b0376a07d2fc5cf563]
stable/6.6: [d7e5031fe3f161c8eb5e84db1540bc4373ed861b]

CVE-2025-21951: bus: mhi: host: pci_generic: Use
pci_try_reset_function() to avoid deadlock

Announce: https://lore.kernel.org/linux-cve-announce/2025040137-CVE-2025-21951-5e0f@gregkh/

Introduced by commit 7389337 ("mhi: pci_generic: Add
suspend/resume/recovery procedure") in v5.12-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a321d163de3d8aa38a6449ab2becf4b1581aed96]
stable/5.15: [7746f3bb8917fccb4571a576f3837d80fc513054]
stable/6.1: [7a5ffadd54fe2662f5c99cdccf30144d060376f7]
stable/6.6: [1f9eb7078bc6b5fb5cbfbcb37c4bc01685332b95]

CVE-2025-21952: HID: corsair-void: Update power supply values with a
unified work handler

Announce: https://lore.kernel.org/linux-cve-announce/2025040137-CVE-2025-21952-16cb@gregkh/

Introduced by commit 6ea2a6f ("HID: corsair-void: Add Corsair Void
headset family driver") in v6.13-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c28e4d1e10d2aae608094620bb386e6fd73d55e]

CVE-2025-21953: net: mana: cleanup mana struct after debugfs_remove()

Announce: https://lore.kernel.org/linux-cve-announce/2025040143-CVE-2025-21953-57ef@gregkh/

Introduced by commit 6607c17 ("net: mana: Enable debugfs files for
MANA device") in v6.13-rc1.
Fixed in v6.14-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e64bb2ae7d9f2b3a8259d4d6b86ed1984d5460a]

CVE-2025-21954: netmem: prevent TX of unreadable skbs

Announce: https://lore.kernel.org/linux-cve-announce/2025040143-CVE-2025-21954-8f0d@gregkh/

Introduced by commit 65249fe ("net: add support for skbs with
unreadable frags") in v6.12-rc1.
Fixed in v6.14-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f3600c867c99a2cc8038680ecf211089c50e7971]

CVE-2025-21955: ksmbd: prevent connection release during oplock break
notification

Announce: https://lore.kernel.org/linux-cve-announce/2025040143-CVE-2025-21955-c393@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc7.


Fixed status
mainline: [3aa660c059240e0c795217182cf7df32909dd917]
stable/6.6: [09aeab68033161cb54f194da93e51a11aee6144b]

CVE-2025-21956: drm/amd/display: Assign normalized_pix_clk when color depth = 14

Announce: https://lore.kernel.org/linux-cve-announce/2025040144-CVE-2025-21956-483d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc7.
Affected file was introduced by commit 4562236 ("drm/amd/dc: Add dc display
driver (v2)") in 4.15-rc1.

Fixed status
mainline: [79e31396fdd7037c503e6add15af7cb00633ea92]
stable/6.1: [dc831b38680c47d07e425871a9852109183895cf]
stable/6.6: [a8f77e1658d78e4a8bb227a83bcee67de97f7634]

CVE-2025-21957: scsi: qla1280: Fix kernel oops when debug level > 2

Announce: https://lore.kernel.org/linux-cve-announce/2025040144-CVE-2025-21957-5d2c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc2.


Fixed status
mainline: [5233e3235dec3065ccc632729675575dbe3c6b8a]
stable/6.1: [24602e2664c515a4f2950d7b52c3d5997463418c]
stable/6.6: [ea371d1cdefb0951c7127a33bcd7eb931cf44571]

CVE-2025-21958: Revert "openvswitch: switch to per-action label
counting in conntrack"

Announce: https://lore.kernel.org/linux-cve-announce/2025040144-CVE-2025-21958-c94c@gregkh/

Introduced by commit fcb1aa5 ("openvswitch: switch to per-action label
counting in conntrack") in v6.12-rc1.
Fixed in v6.14-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1063ae07383c0ddc5bcce170260c143825846b03]

CVE-2025-21959: netfilter: nf_conncount: Fully initialize struct
nf_conncount_tuple in insert_tree()

Announce: https://lore.kernel.org/linux-cve-announce/2025040144-CVE-2025-21959-a643@gregkh/

Introduced by commit b36e452 ("netfilter: nf_conncount: fix garbage
collection confirm race") in v4.18-rc4.
Fixed in v6.14-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d653bfeb07ebb3499c403404c21ac58a16531607]
stable/6.1: [a62a25c6ad58fae997f48a0749afeda1c252ae51]
stable/6.6: [fda50302a13701d47fbe01e1739c7a51114144fb]

CVE-2025-21960: eth: bnxt: do not update checksum in bnxt_xdp_build_skb()

Announce: https://lore.kernel.org/linux-cve-announce/2025040144-CVE-2025-21960-14ae@gregkh/

Introduced by commit 1dc4c55 ("bnxt: adding bnxt_xdp_build_skb to
build skb from multibuffer xdp_buff") in v5.19-rc1.
Fixed in v6.14-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c03e7d05aa0e2f7e9a9ce5ad8a12471a53f941dc]
stable/6.1: [e8e3e03d69f2420eaa578199a65d281c58867105]
stable/6.6: [ee086c8e775f9690282e3d26471dbcfd5dad5a6a]

CVE-2025-21961: eth: bnxt: fix truesize for mb-xdp-pass case

Announce: https://lore.kernel.org/linux-cve-announce/2025040144-CVE-2025-21961-5759@gregkh/

Introduced by commit 1dc4c55 ("bnxt: adding bnxt_xdp_build_skb to
build skb from multibuffer xdp_buff") in v5.19-rc1.
Fixed in v6.14-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f7b2aa5034e24d3c49db73d5f760c0435fe31c2]

CVE-2025-21962: cifs: Fix integer overflow while processing closetimeo
mount option

Announce: https://lore.kernel.org/linux-cve-announce/2025040145-CVE-2025-21962-9f86@gregkh/

Introduced by commit 5efdd91 ("smb3: allow deferred close timeout to
be configurable") in v6.0-rc1.
Fixed in v6.14-rc7.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [d5a30fddfe2f2e540f6c43b59cf701809995faef]
stable/6.1: [9968fcf02cf6b0f78fbacf3f63e782162603855a]
stable/6.6: [6c13fcb7cf59ae65940da1dfea80144e42921e53]

CVE-2025-21963: cifs: Fix integer overflow while processing acdirmax
mount option

Announce: https://lore.kernel.org/linux-cve-announce/2025040145-CVE-2025-21963-6e21@gregkh/

Introduced by commit 4c9f948 ("cifs: Add new mount parameter
"acdirmax" to allow caching directory metadata") in v5.12-rc1.
Fixed in v6.14-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5b29891f91dfb8758baf1e2217bef4b16b2b165b]
stable/6.1: [39d086bb3558da9640ef335f97453e01d32578a1]
stable/6.6: [9e438d0410a4002d24f420f2c28897ba2dc0af64]

CVE-2025-21964: cifs: Fix integer overflow while processing acregmax
mount option

Announce: https://lore.kernel.org/linux-cve-announce/2025040145-CVE-2025-21964-e2c1@gregkh/

Introduced by commit 5780464 ("cifs: Add new parameter "acregmax" for
distinct file and directory metadata timeout") in v5.12-rc1.
Fixed in v6.14-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7489161b1852390b4413d57f2457cd40b34da6cc]
stable/6.1: [dd190168e60ac15408f074a1fe0ce36aff34027b]
stable/6.6: [0252c33cc943e9e48ddfafaa6b1eb72adb68a099]

CVE-2025-21965: sched_ext: Validate prev_cpu in scx_bpf_select_cpu_dfl()

Announce: https://lore.kernel.org/linux-cve-announce/2025040145-CVE-2025-21965-34d8@gregkh/

Introduced by commit f0e1a06 ("sched_ext: Implement BPF extensible
scheduler class") in v6.12-rc1.
Fixed in v6.14-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9360dfe4cbd62ff1eb8217b815964931523b75b3]

CVE-2025-21966: dm-flakey: Fix memory corruption in optional
corrupt_bio_byte feature

Announce: https://lore.kernel.org/linux-cve-announce/2025040145-CVE-2025-21966-afc6@gregkh/

Introduced by commit 1d9a943 ("dm flakey: clone pages on write bio
before corrupting them") in v6.5-rc1.
Fixed in v6.14-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [57e9417f69839cb10f7ffca684c38acd28ceb57b]
stable/6.6: [818330f756f3800c37d738bd36bce60eac949938]

CVE-2025-21967: ksmbd: fix use-after-free in ksmbd_free_work_struct

Announce: https://lore.kernel.org/linux-cve-announce/2025040146-CVE-2025-21967-114e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc7.


Fixed status
mainline: [bb39ed47065455604729404729d9116868638d31]
stable/6.6: [fb776765bfc21d5e4ed03bb3d4406c2b86ff1ac3]

CVE-2025-21968: drm/amd/display: Fix slab-use-after-free on hdcp_work

Announce: https://lore.kernel.org/linux-cve-announce/2025040146-CVE-2025-21968-c3f2@gregkh/

Introduced by commit da3fd7a ("drm/amd/display: Update CP property
based on HW query") in v5.5-rc1.
Fixed in v6.14-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e65e7bea220c3ce8c4c793b4ba35557f4994ab2b]
stable/6.1: [4964dbc4191ab436877a5e3ecd9c67a4e50b7c36]
stable/6.6: [378b361e2e30e9729f9a7676f7926868d14f4326]

CVE-2025-21969: Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd

Announce: https://lore.kernel.org/linux-cve-announce/2025040146-CVE-2025-21969-d4f2@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc3.


Fixed status
mainline: [b4f82f9ed43aefa79bec2504ae8c29be0c0f5d1d]
stable/6.6: [c96cce853542b3b13da3738f35ef1be8cfcc9d1d]

CVE-2025-21970: net/mlx5: Bridge, fix the crash caused by LAG state check

Announce: https://lore.kernel.org/linux-cve-announce/2025040146-CVE-2025-21970-fbac@gregkh/

Introduced by commit ff9b752 ("net/mlx5: Bridge, support LAG") in v5.15-rc1.
Fixed in v6.14-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b8eeed4fb105770ce6dc84a2c6ef953c7b71cbb]
stable/6.1: [86ff45f5f61ae1d0d17f0f6d8797b052eacfd8f1]
stable/6.6: [bd7e3a42800743a7748c83243e4cafc1b995d4c4]

CVE-2025-21971: net_sched: Prevent creation of classes with TC_H_ROOT

Announce: https://lore.kernel.org/linux-cve-announce/2025040146-CVE-2025-21971-d17c@gregkh/

Introduced by commit 066a3b5 ("[NET_SCHED] sch_api: fix
qdisc_tree_decrease_qlen() loop") in v2.6.25.
Fixed in v6.14-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c3057a5a04d07120b3d0ec9c79568fceb9c921e]
stable/6.1: [e5ee00607bbfc97ef1526ea95b6b2458ac9e7cb7]
stable/6.6: [78533c4a29ac3aeddce4b481770beaaa4f3bfb67]

CVE-2025-21972: net: mctp: unshare packets when reassembling

Announce: https://lore.kernel.org/linux-cve-announce/2025040146-CVE-2025-21972-1415@gregkh/

Introduced by commit 4a992bb ("mctp: Implement message fragmentation &
reassembly") in v5.15-rc1.
Fixed in v6.14-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5d83cf0eeb90fade4d5c4d17d24b8bee9ceeecc]

CVE-2025-21973: eth: bnxt: fix kernel panic in the bnxt_get_queue_stats{rx | tx}

Announce: https://lore.kernel.org/linux-cve-announce/2025040147-CVE-2025-21973-8246@gregkh/

Introduced by commit af7b3b4 ("eth: bnxt: support per-queue
statistics") in v6.9-rc1.
Fixed in v6.14-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f09af5fdfbd9b0fcee73aab1116904c53b199e97]

CVE-2025-21974: eth: bnxt: return fail if interface is down in
bnxt_queue_mem_alloc()

Announce: https://lore.kernel.org/linux-cve-announce/2025040147-CVE-2025-21974-1526@gregkh/

Introduced by commit 2d694c2 ("bnxt_en: implement
netdev_queue_mgmt_ops") in v6.11-rc1.
Fixed in v6.14-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ca2456e073957781e1184de68551c65161b2bd30]

CVE-2025-21975: net/mlx5: handle errors in mlx5_chains_create_table()

Announce: https://lore.kernel.org/linux-cve-announce/2025040147-CVE-2025-21975-6693@gregkh/

Introduced by commit 39ac237 ("net/mlx5: E-Switch, Refactor chains and
priorities") in v5.6-rc1.
Fixed in v6.14-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eab0396353be1c778eba1c0b5180176f04dd21ce]
stable/6.1: [1598307c914ba3d2642a2b03d1ff11efbdb7c6c2]
stable/6.6: [637105ef0d46fe5beac15aceb431da3ec832bb00]

CVE-2025-21976: fbdev: hyperv_fb: Allow graceful removal of framebuffer

Announce: https://lore.kernel.org/linux-cve-announce/2025040147-CVE-2025-21976-340d@gregkh/

Introduced by commit 68a2d20 ("drivers/video: add Hyper-V Synthetic
Video Frame Buffer Driver") in v3.10-rc1.
Fixed in v6.14-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea2f45ab0e53b255f72c85ccd99e2b394fc5fceb]

CVE-2025-21977: fbdev: hyperv_fb: Fix hang in kdump kernel when on
Hyper-V Gen 2 VMs

Announce: https://lore.kernel.org/linux-cve-announce/2025040147-CVE-2025-21977-5b08@gregkh/

Introduced by commit c25a19a ("fbdev/hyperv_fb: Do not clear global
screen_info") in v6.8-rc1.
Fixed in v6.14-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [304386373007aaca9236a3f36afac0bbedcd2bf0]

CVE-2025-21978: drm/hyperv: Fix address space leak when Hyper-V DRM
device is removed

Announce: https://lore.kernel.org/linux-cve-announce/2025040148-CVE-2025-21978-8f3e@gregkh/

Introduced by commit f1f63cb ("drm/hyperv: Fix an error handling path
in hyperv_vmbus_probe()") in v6.0-rc6.
Introduced by commit a0ab5ab ("drm/hyperv : Removing the restruction
of VRAM allocation with PCI bar size") in v6.0-rc1.
Fixed in v6.14-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aed709355fd05ef747e1af24a1d5d78cd7feb81e]
stable/6.1: [c40cd24bfb9bfbb315c118ca14ebe6cf52e2dd1e]
stable/6.6: [ad27b4a51495490b815580d9b935e8eee14d1a9c]

CVE-2025-21979: wifi: cfg80211: cancel wiphy_work before freeing wiphy

Announce: https://lore.kernel.org/linux-cve-announce/2025040148-CVE-2025-21979-1a5f@gregkh/

Introduced by commit a3ee4dc ("wifi: cfg80211: add a work abstraction
with special semantics") in v6.5-rc1.
Fixed in v6.14-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [72d520476a2fab6f3489e8388ab524985d6c4b90]
stable/6.1: [0272d4af7f92997541d8bbf4c51918b93ded6ee2]
stable/6.6: [75d262ad3c36d52852d764588fcd887f0fcd9138]

CVE-2025-21980: sched: address a potential NULL pointer dereference in
the GRED scheduler.

Announce: https://lore.kernel.org/linux-cve-announce/2025040148-CVE-2025-21980-2846@gregkh/

Introduced by commit f25c051 ("net: sched: gred: dynamically allocate
tc_gred_qopt_offload") in v5.16-rc1.
Fixed in v6.14-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [115ef44a98220fddfab37a39a19370497cd718b9]
stable/6.1: [d02c9acd68950a444acda18d514e2b41f846cb7f]
stable/6.6: [0f0a152957d64ce45b4c27c687e7d087e8f45079]

CVE-2025-21981: ice: fix memory leak in aRFS after reset

Announce: https://lore.kernel.org/linux-cve-announce/2025040148-CVE-2025-21981-963c@gregkh/

Introduced by commit 28bf267 ("ice: Implement aRFS") in v5.8-rc1.
Fixed in v6.14-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23d97f18901ef5e4e264e3b1777fe65c760186b5]
stable/6.1: [fcbacc47d16306c87ad1b820b7a575f6e9eae58b]
stable/6.6: [5d30d256661fc11b6e73fac6c3783a702e1006a3]

CVE-2025-21982: pinctrl: nuvoton: npcm8xx: Add NULL check in npcm8xx_gpio_fw

Announce: https://lore.kernel.org/linux-cve-announce/2025040148-CVE-2025-21982-8ddf@gregkh/

Introduced by commit acf4884 ("pinctrl: nuvoton: add NPCM8XX pinctrl
and GPIO driver") in v6.7-rc1.
Fixed in v6.14-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [acf40ab42799e4ae1397ee6f5c5941092d66f999]

CVE-2025-21983: mm/slab/kvfree_rcu: Switch to WQ_MEM_RECLAIM wq

Announce: https://lore.kernel.org/linux-cve-announce/2025040149-CVE-2025-21983-1bcc@gregkh/

Introduced by commit 6c6c47b ("mm, slab: call kvfree_rcu_barrier()
from kmem_cache_destroy()"), in v6.12-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dfd3df31c9db752234d7d2e09bef2aeabb643ce4]

CVE-2025-21984: mm: fix kernel BUG when userfaultfd_move encounters swapcache

Announce: https://lore.kernel.org/linux-cve-announce/2025040149-CVE-2025-21984-4add@gregkh/

Introduced by commit adef440 ("userfaultfd: UFFDIO_MOVE uABI") in v6.8-rc1.
Fixed in v6.14-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c50f8e6053b0503375c2975bf47f182445aebb4c]

CVE-2025-21985: drm/amd/display: Fix out-of-bound accesses

Announce: https://lore.kernel.org/linux-cve-announce/2025040149-CVE-2025-21985-435c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc2.
The dml2_translation_helper.c was introduced by commit 7966f31
("drm/amd/display:
Introduce DML2") in 6.7-rc1. The dml21_translation_helper.c was introduced by
commit 70839da ("drm/amd/display: Add new DCN401 sources") in 6.11-rc1.

Fixed status
mainline: [8adbb2a98b00926315fd513b5fe2596b5716b82d]

CVE-2025-21986: net: switchdev: Convert blocking notification chain to a raw one

Announce: https://lore.kernel.org/linux-cve-announce/2025040149-CVE-2025-21986-6729@gregkh/

Introduced by commit f7a70d6 ("net: bridge: switchdev: Ensure deferred
event delivery on unoffload") in v6.8-rc6.
Fixed in v6.14-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [62531a1effa87bdab12d5104015af72e60d926ff]
stable/6.1: [af757f5ee3f754c5dceefb05c12ff37cb46fc682]
stable/6.6: [1f7d051814e7a0cb1f0717ed5527c1059992129d]

CVE-2025-21987: drm/amdgpu: init return value in amdgpu_ttm_clear_buffer

Announce: https://lore.kernel.org/linux-cve-announce/2025040249-CVE-2025-21987-de85@gregkh/

Introduced by commit a68c7ea ("drm/amdgpu: Enable clear page
functionality") in v6.10-rc1.
Fixed in v6.14-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3c7059b6a8600fc62cd863f1ea203b8675e63e1]

CVE-2025-21988: fs/netfs/read_collect: add to next->prev_donated

Announce: https://lore.kernel.org/linux-cve-announce/2025040254-CVE-2025-21988-e048@gregkh/

Introduced by commit ee4cdf7 ("netfs: Speed up buffered reading") in 6.12-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e25cec3b76aba47a49138d2162fc809c6cd49c9e]

CVE-2025-21989: drm/amd/display: fix missing .is_two_pixels_per_container

Announce: https://lore.kernel.org/linux-cve-announce/2025040256-CVE-2025-21989-440d@gregkh/

Introduced by commit e6a901a ("drm/amd/display: use even ODM slice
width for two pixels per container") in v6.11-rc1.
Fixed in v6.14-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e204aab79e01bc8ff750645666993ed8b719de57]

CVE-2025-21990: drm/amdgpu: NULL-check BO's backing store when
determining GFX12 PTE flags

Announce: https://lore.kernel.org/linux-cve-announce/2025040256-CVE-2025-21990-cc2d@gregkh/

Introduced by commit 0cce5f2 ("drm/amdkfd: Check correct memory types
for is_system variable") in v6.11-rc1.
Fixed in v6.14-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6cc30748e17ea2a64051ceaf83a8372484e597f1]

CVE-2025-21991: x86/microcode/AMD: Fix out-of-bounds on systems with
CPU-less NUMA nodes

Announce: https://lore.kernel.org/linux-cve-announce/2025040257-CVE-2025-21991-6aae@gregkh/

Introduced by commit 7ff6edf ("x86/microcode/AMD: Fix mixed steppings
support") in v6.3-rc1.
Fixed in v6.14-rc7.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/5.10 stable/5.15 stable/5.4 stable/6.1

Fixed status
mainline: [e3e89178a9f4a80092578af3ff3c8478f9187d59]
stable/6.1: [ec52240622c4d218d0240079b7c1d3ec2328a9f4]
stable/6.6: [e686349cc19e800dac8971929089ba5ff59abfb0]

CVE-2025-21992: HID: ignore non-functional sensor in HP 5MP Camera

Announce: https://lore.kernel.org/linux-cve-announce/2025040257-CVE-2025-21992-3985@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc3.


Fixed status
mainline: [363236d709e75610b628c2a4337ccbe42e454b6d]
stable/6.1: [9acdb0059fb6b82158e15adae91e629cb5974564]
stable/6.6: [7a7ada33879a631b05b536e66d1c5b1219d3bade]

CVE-2025-21993: iscsi_ibft: Fix UBSAN shift-out-of-bounds warning in
ibft_attr_show_nic()

Announce: https://lore.kernel.org/linux-cve-announce/2025040257-CVE-2025-21993-54d1@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc2.


Fixed status
mainline: [07e0d99a2f701123ad3104c0f1a1e66bce74d6e5]
stable/6.1: [9bfa80c8aa4e06dff55a953c3fffbfc68a3a3b1c]
stable/6.6: [2d1eef248107bdf3d5a69d0fde04c30a79a7bf5d]

CVE-2025-21994: ksmbd: fix incorrect validation for num_aces field of smb_acl

Announce: https://lore.kernel.org/linux-cve-announce/2025040214-CVE-2025-21994-44bf@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc6.
ksmbd was introduced in 5.15.

Fixed status
mainline: [1b8b67f3c5e5169535e26efedd3e422172e2db64]
stable/6.1: [9c4e202abff45f8eac17989e549fc7a75095f675]
stable/6.6: [d0f87370622a853b57e851f7d5a5452b72300f19]


* Updated CVEs

CVE-2023-52857: drm/mediatek: Fix coverity issue with unintentional
integer overflow

stable/6.1 was fixed.

Fixed status
stable/6.1: [a12bd675100531f9fb4508fd4430dd1632325a0e]
stable/6.6: [96312a251d4dcee5d36e32edba3002bfde0ddd9c]

CVE-2024-26656: drm/amdgpu: fix use-after-free bug

stable/6.1 was fixed.

Fixed status
stable/6.1: [2e13f88e01ae7e28a7e831bf5c2409c4748e0a60]
stable/6.6: [e87e08c94c9541b4e18c4c13f2f605935f512605]
stable/6.7: [af054a5fb24a144f99895afce9519d709891894c]
stable/6.8: [22f665ecfd1225afa1309ace623157d12bb9bb0c]

CVE-2024-27056: wifi: iwlwifi: mvm: ensure offloading TID queue exists

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [4903303f25f48b5a1e34e6324c7fae9ccd6b959a]
stable/6.6: [35afffaddbe8d310dc61659da0b1a337b0d0addc]

CVE-2024-35866: smb: client: fix potential UAF in cifs_dump_full_key()

stable/6.1 was fixed.

Fixed status
stable/6.1: [f4a60d360d9114b5085701a3702a0102b0d6d846]
stable/6.6: [10e17ca4000ec34737bde002a13435c38ace2682]
stable/6.8: [3103163ccd3be4adcfa37e15608fb497be044113]

CVE-2024-35949: btrfs: make sure that WRITTEN is set on all metadata blocks

stable/6.6 was fixed.

Fixed status
stable/6.6: [9dff3e36ea89e8003516841c27c45af562b6ef44]
stable/6.8: [ef3ba8ce8cf7075b716aa4afcefc3034215878ee]

CVE-2024-42129: leds: mlxreg: Use devm_mutex_init() for mutex initialization

stable/6.1 was fixed.

Fixed status
stable/6.1: [618c6ce83471ab4f7ac744d27b9d03af173bc141]
stable/6.6: [172ffd26a5af13e951d0e82df7cfc5a95b04fa80]

CVE-2024-47753: media: mediatek: vcodec: Fix VP8 stateless decoder
smatch warning

stable/6.1 was fixed.

Fixed status
stable/6.1: [4e0713c79cf5d0b549fa855e230ade1ff83c27d7]
stable/6.11: [3167aa42941b68405a092df114453ef0f1b09c2c]
stable/6.6: [dbe5b7373801c261f3ea118145fbb2caac5f9324]

CVE-2024-53209: bnxt_en: Fix receive ring space parameters when XDP is active

stable/6.6 was fixed.

Fixed status
stable/6.12: [84353386762a0a16dd444ead76c012e167d89b41]
stable/6.6: [7f306c651feab2f3689185f60b94e72b573255db]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com


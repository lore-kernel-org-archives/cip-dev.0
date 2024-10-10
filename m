Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD372CEDDA9
	for <webhook@archiver.kernel.org>; Thu, 10 Oct 2024 01:03:35 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
 by mx.groups.io with SMTP id smtpd.web11.33271.1728522212481032352
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Oct 2024 18:03:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=cBX9Db3D;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.181, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6dde476d3dfso4142447b3.3
        for <cip-dev@lists.cip-project.org>; Wed, 09 Oct 2024 18:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1728522211; x=1729127011; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FQ3MlaQVHj9JrI7X9IAjckKpKbSU8tjYtU26+17/Sgs=;
        b=cBX9Db3DZ/iXUl344OfE9e4OCxG1PnhX5u2F82chlQGroIGRtwtlU2JPwHkbSRsF5N
         Ro/K/FGq8x+kvAnvF3TJBMF5msPNoAFLm/bxz4CaZt7L/A/ulYN0TENF91GzUZtSasjE
         Hm4iuBS0b/CGvhobC0wVJt5rOaZS2bD3iU+U6bN/X57WZwJkjlzIP4ldNh3i8sjSFMBn
         D3MdP6hleFfUtDIhlbmUqpjzoNnNvx74FBdiKTepRJL20kqigA5wFcrROvpAY/DMsT1t
         /4MdpJu05Ld35EIFt3buwEmklaY+woz9WP/QhWSBiGGIPCRFnOXz4/Rxe4B8mKNe2kxu
         Fxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728522211; x=1729127011;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FQ3MlaQVHj9JrI7X9IAjckKpKbSU8tjYtU26+17/Sgs=;
        b=EeiOQOdOjJqQsWAGX0XWzSYT3niTjbZjX3bnO+KD3XnzPkigLAZcDhQsDTwv68kJdT
         IqBetHOc58FYA59dYvhF04xU9xOrGoeyd5FxcdOiuapm0J+iItxYr4T29Rz9PZnG9VFf
         sjbVPzeUl/z/mToa6PTK7OmUaXdeFAGAF6OSYcsnImKKhgw9FUhAzze0NUyok3m/tejM
         /eXgKf/EnSXsBb2PuYfCjP6DWiGVqw7hcPpl7MWLF/0Niv0isCFajchLNHZWcfJbN2JP
         Ynls+2i2Z2vT/i2YSx4Uad1Fdq83lcY8WO4H90olaM2IvmanceBe+AAT6AHyjxITLHtm
         mNAg==
X-Gm-Message-State: AOJu0YwdkWW2OARTcqedF+kAwB2Ga6vfU73GyI0jyDw+BbYd08FEmbW1
	mdFnyj8ZxgGL8815UE3nZmSRp0f6kOtAVzJV5PC9raxgIXsyUAgXFe7q8j+GoFkxOGKLp3ZbB+l
	xFRD2sp99Q1IKIUHfcxEcKLEnQ80vmpgSPFcyWZB+DIlIaa0Z2EQ=
X-Google-Smtp-Source: AGHT+IH/EvjIoLiXHju7arzZ5JTVDgVgYT/ENb/58tjRtdrnx1Cfxjt2dWuwJve1wmA8dMayNMwvtxloBxwxrB0QYug=
X-Received: by 2002:a05:690c:7106:b0:6e2:e3d:4dda with SMTP id
 00721157ae682-6e32214af01mr51429417b3.17.1728522211191; Wed, 09 Oct 2024
 18:03:31 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 10 Oct 2024 10:02:55 +0900
Message-ID: <CAODzB9o_BucpcFUB9EFqwgtpq5MY=ua4LQQh7ABtS1XLVyTkKQ@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Oct 2024 01:03:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17022

Hi!

It's this week's CVE report.

This week reported 18 new CVEs and 2 updated CVEs.

* New CVEs
CVE-2024-46870: drm/amd/display: Disable DMCUB timeout for DCN35

Announce: https://lore.kernel.org/linux-cve-announce/2024100958-CVE-2024-46870-f347@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.

Fixed status
mainline: [7c70e60fbf4bff1123f0e8d5cb1ae71df6164d7f]

CVE-2024-46871: drm/amd/display: Correct the defined value for
AMDGPU_DMUB_NOTIFICATION_MAX

Announce: https://lore.kernel.org/linux-cve-announce/2024100958-CVE-2024-46871-15f4@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It seems as if this bug was introduced by commit e27c41
("drm/amd/display: Support
for DMUB HPD interrupt handling") in 5.16-rc1.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [ad28d7c3d989fc5689581664653879d664da76f0]
stable/6.1: [9f404b0bc2df3880758fb3c3bc7496f596f347d7]
stable/6.6: [800a5ab673c4a61ca220cce177386723d91bdb37]

CVE-2024-47658: crypto: stm32/cryp - call finalize with bh disabled

Announce: https://lore.kernel.org/linux-cve-announce/2024100959-CVE-2024-47658-0b23@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It seems as if this bug was introduced by commit 4b898d5c ("crypto: stm32/cryp -
fix bugs and crash in tests") in 5.17-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [56ddb9aa3b324c2d9645b5a7343e46010cf3f6ce]
stable/6.6: [d93a2f86b0a998aa1f0870c85a2a60a0771ef89a]

CVE-2024-47659: smack: tcp: ipv4, fix incorrect labeling

Announce: https://lore.kernel.org/linux-cve-announce/2024100959-CVE-2024-47659-03a8@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.

Fixed status
cip/4.4: [40ade4973a204eb111cdf183bc02d46d7b9cd213]
cip/4.4-st: [40ade4973a204eb111cdf183bc02d46d7b9cd213]
mainline: [2fe209d0ad2e2729f7e22b9b31a86cc3ff0db550]
stable/4.19: [d3f56c653c65f170b172d3c23120bc64ada645d8]
stable/5.10: [a948ec993541db4ef392b555c37a1186f4d61670]
stable/5.15: [0aea09e82eafa50a373fc8a4b84c1d4734751e2c]
stable/5.4: [5b4b304f196c070342e32a4752e1fa2e22fc0671]
stable/6.1: [0776bcf9cb6de46fdd94d10118de1cf9b05f83b9]
stable/6.6: [4be9fd15c3c88775bdf6fa37acabe6de85beebff]

CVE-2024-47660: fsnotify: clear PARENT_WATCHED flags lazily

Announce: https://lore.kernel.org/linux-cve-announce/2024100959-CVE-2024-47660-2d61@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.

Fixed status
mainline: [172e422ffea20a89bfdc672741c1aad6fbb5044e]
stable/5.10: [3f3ef1d9f66b93913ce2171120d9226b55acd41d]
stable/5.15: [f9a48bc3dd9099935751458a5bbbea4b7c28abc8]
stable/6.1: [d8c42405fc3507cc43ba7e4986a773c3fc633f6e]
stable/6.6: [fc1b1e135c3f72382f792e6c319fc088d5523ad5]

CVE-2024-47661: drm/amd/display: Avoid overflow from uint32_t to uint8_t

Announce: https://lore.kernel.org/linux-cve-announce/2024100930-CVE-2024-47661-a6c1@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
Bug in the drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c was
introduced by
commit 16012806 ("drm/amd/display: Add ABM driver implementation") in 5.8-rc1.
Bug in the drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c was introduced by
commit b8fe56375 ("drm/amd/display: Refactor ABM feature") in 6.5-rc1.

Fixed status
mainline: [d6b54900c564e35989cf6813e4071504fa0a90e0]

CVE-2024-47662: drm/amd/display: Remove register from DCN35 DMCUB
diagnostic collection

Announce: https://lore.kernel.org/linux-cve-announce/2024100931-CVE-2024-47662-74f4@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It seems as if this bug was introduced by commit 65138eb ("drm/amd/display:
Add DCN35 DMUB") in 6.7-rc1.

Fixed status
mainline: [466423c6dd8af23ebb3a69d43434d01aed0db356]

CVE-2024-47663: staging: iio: frequency: ad9834: Validate frequency
parameter value

Announce: https://lore.kernel.org/linux-cve-announce/2024100904-CVE-2024-47663-9bdc@gregkh/

Introduced by commit 12b9d5b ("Staging: IIO: DDS: AD9833 / AD9834
driver") in v2.6.38-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b48aa991758999d4e8f9296c5bbe388f293ef465]
stable/5.10: [41cc91e3138fe52f8da92a81bebcd0e6cf488c53]
stable/5.15: [d8b09a5edc4a634373158c1a405491de3c52e58a]
stable/5.4: [0e727707a239d5c519fc9abc2f0fd913516a7e47]
stable/6.1: [3ba9abfcaa9e16bb91ed7e0e2b42e94a157a953e]
stable/6.6: [dc12e49f970b08d8b007b8981b97e2eb93c0e89d]

CVE-2024-47664: spi: hisi-kunpeng: Add verification for the
max_frequency provided by the firmware

Announce: https://lore.kernel.org/linux-cve-announce/2024100904-CVE-2024-47664-f6bd@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc3.
It seems as if this bug was introduced by commit c770d863 ("spi: Add HiSilicon
SPI Controller Driver for Kunpeng SoCs") in 5.13-rc1.

Fixed status
mainline: [5127c42c77de18651aa9e8e0a3ced190103b449c]
stable/6.6: [16ccaf581da4fcf1e4d66086cf37263f9a656d43]

CVE-2024-47665: i3c: mipi-i3c-hci: Error out instead on BUG_ON() in
IBI DMA setup

Announce: https://lore.kernel.org/linux-cve-announce/2024100905-CVE-2024-47665-901e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It seems as if this bug was introduced by commit 9ad9a52 ("i3c/master: introduce
the mipi-i3c-hci driver") in 5.11-rc1.

Fixed status
mainline: [8a2be2f1db268ec735419e53ef04ca039fc027dc]
stable/5.15: [cacb76df247a7cd842ff29755a523b1cba6c0508]
stable/6.1: [2666085335bdfedf90d91f4071490ad3980be785]
stable/6.6: [5a022269abb22809f2a174b90f200fc4b9526058]

CVE-2024-47666: scsi: pm80xx: Set phy->enable_completion only when we
wait for it

Announce: https://lore.kernel.org/linux-cve-announce/2024100905-CVE-2024-47666-0015@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.

Fixed status
mainline: [e4f949ef1516c0d74745ee54a0f4882c1f6c7aea]
stable/6.6: [7b1d779647afaea9185fa2f150b1721e7c1aae89]

CVE-2024-47667: PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)

Announce: https://lore.kernel.org/linux-cve-announce/2024100905-CVE-2024-47667-2d01@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.

Fixed status
mainline: [86f271f22bbb6391410a07e08d6ca3757fda01fa]
stable/5.10: [ebbdbbc580c1695dec283d0ba6448729dc993246]
stable/5.15: [135843c351c08df72bdd4b4ebea53c8052a76881]
stable/5.4: [cfb006e185f64edbbdf7869eac352442bc76b8f6]
stable/6.1: [af218c803fe298ddf00abef331aa526b20d7ea61]
stable/6.6: [576d0fb6f8d4bd4695e70eee173a1b9c7bae9572]

CVE-2024-47668: lib/generic-radix-tree.c: Fix rare race in
__genradix_ptr_alloc()

Announce: https://lore.kernel.org/linux-cve-announce/2024100906-CVE-2024-47668-6b53@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc4.
It seems as if this bug was introduced by commit b2f11c6f ("generic
radix trees")
in 5.1-rc1.

Fixed status
mainline: [b2f11c6f3e1fc60742673b8675c95b78447f3dae]
stable/5.10: [99418ec776a39609f50934720419e0b464ca2283]
stable/5.15: [ad5ee9feebc2eb8cfc76ed74a2d6e55343b0e169]
stable/5.4: [0f27f4f445390cb7f73d4209cb2bf32834dc53da]
stable/6.1: [ebeff038744c498a036e7a92eb8e433ae0a386d7]
stable/6.6: [d942e855324a60107025c116245095632476613e]

CVE-2024-47669: nilfs2: fix state management in error path of log
writing function

Announce: https://lore.kernel.org/linux-cve-announce/2024100906-CVE-2024-47669-135c@gregkh/

Introduced by commit a694291 ("nilfs2: separate wait function from
nilfs_segctor_write") in v2.6.33-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [d6e58f47af1ba487156d469e6ed5b2bdd6c34328]
cip/4.4-st: [d6e58f47af1ba487156d469e6ed5b2bdd6c34328]
mainline: [6576dd6695f2afca3f4954029ac4a64f82ba60ab]
stable/4.19: [40a2757de2c376ef8a08d9ee9c81e77f3c750adf]
stable/5.10: [efdde00d4a1ef10bb71e09ebc67823a3d3ad725b]
stable/5.15: [3e349d7191f0688fc9808ef24fd4e4b4ef5ca876]
stable/5.4: [036441e8438b29111fa75008f0ce305fb4e83c0a]
stable/6.1: [30562eff4a6dd35c4b5be9699ef61ad9f5f20a06]
stable/6.6: [0a1a961bde4351dc047ffdeb2f1311ca16a700cc]

CVE-2024-47670: ocfs2: add bounds checking to ocfs2_xattr_find_entry()

Announce: https://lore.kernel.org/linux-cve-announce/2024100919-CVE-2024-47670-53f3@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.

Fixed status
mainline: [9e3041fecdc8f78a5900c3aa51d3d756e73264d6]
stable/6.1: [9b32539590a8e6400ac2f6e7cf9cbb8e08711a2f]
stable/6.6: [1f6e167d6753fe3ea493cdc7f7de8d03147a4d39]

CVE-2024-47671: USB: usbtmc: prevent kernel-usb-infoleak

Announce: https://lore.kernel.org/linux-cve-announce/2024100922-CVE-2024-47671-6c52@gregkh/

Introduced by commit 4ddc645 ("usb: usbtmc: Add ioctl for vendor
specific write") in v4.20-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [625fa77151f00c1bd00d34d60d6f2e710b3f9aad]
stable/6.1: [ba6269e187aa1b1f20faf3c458831a0d6350304b]
stable/6.6: [51297ef7ad7824ad577337f273cd092e81a9fa08]

CVE-2024-47672: wifi: iwlwifi: mvm: don't wait for tx queues if firmware is dead

Announce: https://lore.kernel.org/linux-cve-announce/2024100922-CVE-2024-47672-9bef@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc6.

Fixed status
mainline: [3a84454f5204718ca5b4ad2c1f0bf2031e2403d1]
stable/6.1: [1b0cd832c9607f41f84053b818e0b7908510a3b9]
stable/6.6: [4d0a900ec470d392476c428875dbf053f8a0ae5e]

CVE-2024-47673: wifi: iwlwifi: mvm: pause TCM when the firmware is stopped

Announce: https://lore.kernel.org/linux-cve-announce/2024100922-CVE-2024-47673-9110@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc6.

Fixed status
mainline: [0668ebc8c2282ca1e7eb96092a347baefffb5fe7]
stable/6.1: [5948a191906b54e10f02f6b7a7670243a39f99f4]
stable/6.6: [2c61b561baf92a2860c76c2302a62169e22c21cc]

* Updated CVEs

CVE-2024-27060: thunderbolt: Fix NULL pointer dereference in
tb_port_update_credits()

stable/6.6 was fixed.

Fixed status
stable/6.6: [440fba897c5ae32d7df1f1d609dbb19e2bba7fbb]
stable/6.8: [d3d17e23d1a0d1f959b4fa55b35f1802d9c584fa]

CVE-2024-46710: drm/vmwgfx: Prevent unmapping active read buffers

stable/6.6 was fixed.

Fixed status
stable/6.10: [d5228d158e4c0b1663b3983044913c15c3d0135e]
stable/6.6: [0851b1ec650adadcaa23ec96daad95a55bf966f0]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com


Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79460C02181
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 22:26:57 +0000 (UTC)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
 by mx.groups.io with SMTP id smtpd.web11.6958.1737584811506154408
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 14:26:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=yiXlUqk5;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.176, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e573136107bso437367276.3
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 14:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1737584810; x=1738189610; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7tffv2TiatdEFHJ01oE4LnAmUeMdE27rCLzoEj+9lOs=;
        b=yiXlUqk5VQbB0FRoTBEfwIcv+nRct7kPGThoRninJ27KHW5qCqn1Jd+nXui+S2LQm/
         pwWBiS25ux9OJ2zdlSOJmjJI4PaRH/CLZsQj8hj7uVAkaWepAVSxWZcVGjFlCEkXHV2B
         71rsFu1CQl+3cTcxzsDqK9pOykXL3uxuJhuR/pxyQrhgd7z4JC1Aq8vOsshHFoPSYwL/
         9v1dtKsm8TEobJ9CIUepEnZo3aGd3SXZCfB147VKSXug9fT+n7Kqv+QmMebxkxIdXos6
         GZy3dsREll1bGYXQ0ADz/I0xo5vpC1XkL3zWGDHKseohJIoUmWBlfhjZ3WamiUJoR3FS
         +X8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737584810; x=1738189610;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7tffv2TiatdEFHJ01oE4LnAmUeMdE27rCLzoEj+9lOs=;
        b=TkfYsoj6DEQC+1q37KVY4v70QM3sMGATcY04Yi8HUT2NHOTeRqI39HGEMkdYctyW1z
         D5Dc8Haj+qe/Gccr2oGGNQIYjjeIigC6RkNmIe6ZzSNONLNceBM2QRhC/JG9lYdaJSYo
         oNEaTzOmQ+WyVX2VBqdBYdW4lxth7Lbk5rRD7IeWD+g9H24vz5I0dllG8lT6d5QSXFMR
         om/3BcVZ2OkBMZM52Nr4cvW1dk6zJmp/MWPAOXwNrkPFUVEhU1/PsFl/Qir69xz9A3gk
         TPYlGaBmVkeHBY9/6rd9vWCqMaD/DTNhZbbNskMXvC8b83hKZKMGJNAvpVVoP+kdA9/f
         6rSw==
X-Gm-Message-State: AOJu0YxuNSdMslExcLUyNKKh3Iw8C5guR6bOULvnssiXLHOCGBLJE3Wi
	pP1vT+hgIW1vtBwYSnulH6ilhhrKpv27cY2N7Ir50fWN5cR1ZcOcQCZlKwNj0oE9BImTiBR+Lqo
	2SZGq8EW/xezeBz0J4NJbR1xwrAnAOBtbEC41X6FO85g8Y/KKtz0=
X-Gm-Gg: ASbGncvq+VGjJaE8h78RJngBTf2wOPcPwSveNXzTFhSzkap9CAWeDOHklw8BJOdRA29
	JJF86NzqPLSB1AQlHZvhAPWR3GrSj0gyXp4PGaXnpRNaQKqek9VIK
X-Google-Smtp-Source: AGHT+IG6z1IOOUNudCuV3Yf9ioxjF2b+gjh5fXIytPHWw3utDVAkrixIeak8k4gV/QObJaDoWD8HLrqoXwlR+LkbSbA=
X-Received: by 2002:a05:690c:62c4:b0:6ef:aae1:ac5d with SMTP id
 00721157ae682-6f6eb90d588mr199721477b3.27.1737584809862; Wed, 22 Jan 2025
 14:26:49 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 23 Jan 2025 07:26:14 +0900
X-Gm-Features: AWEUYZlrrvU2vbdpI4nMyN9ZNeQmiu3VneC32JNr_klM7pErqVJvTeU1xeDCSLI
Message-ID: <CAODzB9pBzUE6k7rX5LAXpOqzz=Ybjudy4F-GzSZjKERC5Cm8Rw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 22:26:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17599

Hi!

It's this week's CVE report.

This week reported 78 new CVEs and 11 updated CVEs.

* New CVEs

CVE-2024-57904: iio: adc: at91: call input_free_device() on allocated iio_dev

Announce: https://lore.kernel.org/linux-cve-announce/2025011934-CVE-2024-57904-dac5@gregkh/

Introduced by commit 84882b0 ("iio: adc: at91_adc: Add support for
touchscreens without TSMR") in v3.16-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de6a73bad1743e9e81ea5a24c178c67429ff510b]
stable/6.1: [25ef52f1c15db67d890b80203a911b9a57b0bf71]
stable/6.6: [09e067e3c83e0695d338e8a26916e3c2bc44be02]

CVE-2024-57905: iio: adc: ti-ads1119: fix information leak in triggered buffer

Announce: https://lore.kernel.org/linux-cve-announce/2025011937-CVE-2024-57905-7d0d@gregkh/

Introduced by commit a930688 ("iio: adc: ti-ads1119: Add driver") in v6.11-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [75f339d3ecd38cb1ce05357d647189d4a7f7ed08]

CVE-2024-57906: iio: adc: ti-ads8688: fix information leak in triggered buffer

Announce: https://lore.kernel.org/linux-cve-announce/2025011937-CVE-2024-57906-6e61@gregkh/

Introduced by commit 61fa5df ("iio: adc: ti-ads8688: Fix alignment of
buffer in iio_push_to_buffers_with_timestamp()") in v5.14-rc1.
Fixed in v6.13-rc7.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [2a7377ccfd940cd6e9201756aff1e7852c266e69]
stable/6.1: [ebe2672bc42a0dfe31bb539f8ce79d024aa7e46d]
stable/6.6: [455df95eb8f24a37abc549d6738fc8ee07eb623b]

CVE-2024-57907: iio: adc: rockchip_saradc: fix information leak in
triggered buffer

Announce: https://lore.kernel.org/linux-cve-announce/2025011937-CVE-2024-57907-e5dd@gregkh/

Introduced by commit 4e130dc ("iio: adc: rockchip_saradc: Add support
iio buffers") in v5.9-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [38724591364e1e3b278b4053f102b49ea06ee17c]
stable/6.6: [5a95fbbecec7a34bbad5dcc3156700b8711d53c4]

CVE-2024-57908: iio: imu: kmx61: fix information leak in triggered buffer

Announce: https://lore.kernel.org/linux-cve-announce/2025011938-CVE-2024-57908-654f@gregkh/

Introduced by commit c3a23ec ("iio: imu: kmx61: Add support for data
ready triggers") in v4.0-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6ae053113f6a226a2303caa4936a4c37f3bfff7b]
stable/6.1: [6985ba4467e4b15b809043fa7740d1fb23a1897b]
stable/6.6: [cde312e257b59ecaa0fad3af9ec7e2370bb24639]

CVE-2024-57909: iio: light: bh1745: fix information leak in triggered buffer

Announce: https://lore.kernel.org/linux-cve-announce/2025011938-CVE-2024-57909-ed6a@gregkh/

Introduced by commit eab3535 ("iio: light: ROHM BH1745 colour sensor")
in v6.12-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b62fbe3b8eedd3cf3c9ad0b7cb9f72c3f40815f0]

CVE-2024-57910: iio: light: vcnl4035: fix information leak in triggered buffer

Announce: https://lore.kernel.org/linux-cve-announce/2025011938-CVE-2024-57910-e4e0@gregkh/

Introduced by commit ec90b52 ("iio: light: vcnl4035: Fix buffer
alignment in iio_push_to_buffers_with_timestamp()") in v5.14-rc1.
Fixed in v6.13-rc7.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [47b43e53c0a0edf5578d5d12f5fc71c019649279]
stable/6.1: [47d245be86492974db3aeb048609542167f56518]
stable/6.6: [a15ea87d4337479c9446b5d71616f4668337afed]

CVE-2024-57911: iio: dummy: iio_simply_dummy_buffer: fix information
leak in triggered buffer

Announce: https://lore.kernel.org/linux-cve-announce/2025011939-CVE-2024-57911-0e13@gregkh/

Introduced by commit 415f792 ("iio: Move IIO Dummy Driver out of
staging") in v4.5-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [333be433ee908a53f283beb95585dfc14c8ffb46]
stable/6.1: [b0642d9c871aea1f28eb02cd84d60434df594f67]
stable/6.6: [74058395b2c63c8a438cf199d09094b640f8c7f4]

CVE-2024-57912: iio: pressure: zpa2326: fix information leak in triggered buffer

Announce: https://lore.kernel.org/linux-cve-announce/2025011939-CVE-2024-57912-6049@gregkh/

Introduced by commit 03b262f ("iio:pressure: initial zpa2326 barometer
support") in v4.9-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6007d10c5262f6f71479627c1216899ea7f09073]
stable/6.1: [b7849f62e61242e0e02c776e1109eb81e59c567c]
stable/6.6: [fefb88a4da961a0b9c2473cbdcfce1a942fcfa9a]

CVE-2024-57913: usb: gadget: f_fs: Remove WARN_ON in functionfs_bind

Announce: https://lore.kernel.org/linux-cve-announce/2025011939-CVE-2024-57913-d69f@gregkh/

Introduced by commit ddf8abd ("USB: f_fs: the FunctionFS driver") in
v2.6.35-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dfc51e48bca475bbee984e90f33fdc537ce09699]
stable/6.1: [82f60f3600aecd9ffcd0fbc4e193694511c85b47]
stable/6.6: [ea6a1498742430eb2effce0d1439ff29ef37dd7d]

CVE-2024-57914: usb: typec: tcpci: fix NULL pointer issue on shared irq case

Announce: https://lore.kernel.org/linux-cve-announce/2025011940-CVE-2024-57914-33e0@gregkh/

Introduced by commit 77e8510 ("usb: typec: tcpci: support edge irq")
in v6.12-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [862a9c0f68487fd6ced15622d9cdcec48f8b5aaa]

CVE-2024-57915: usb: gadget: u_serial: Disable ep before setting port
to null to fix the crash caused by port being null

Announce: https://lore.kernel.org/linux-cve-announce/2025011940-CVE-2024-57915-fc93@gregkh/

Introduced by commit c1dca56 ("usb gadget: split out serial core") in
v2.6.27-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [13014969cbf07f18d62ceea40bd8ca8ec9d36cec]
stable/6.1: [3d730e8758c75b68a0152ee1ac48a270ea6725b4]
stable/6.6: [0c50f00cc29948184af05bda31392fff5821f4f3]

CVE-2024-57916: misc: microchip: pci1xxxx: Resolve kernel panic during
GPIO IRQ handling

Announce: https://lore.kernel.org/linux-cve-announce/2025011940-CVE-2024-57916-4116@gregkh/

Introduced by commit 1f4d8ae ("misc: microchip: pci1xxxx: Add gpio irq
handler and irq helper functions irq_ack, irq_mask, irq_unmask and
irq_set_type of irq_chip.") in v6.1-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [194f9f94a5169547d682e9bbcc5ae6d18a564735]
stable/6.1: [79aef6187e16b2d32307c8ff610e9e04f7f86e1f]
stable/6.6: [25692750c0259c5b65afec467d97201a485e8a00]

CVE-2024-57917: topology: Keep the cpumask unchanged when printing cpumap

Announce: https://lore.kernel.org/linux-cve-announce/2025011941-CVE-2024-57917-f1e1@gregkh/

Introduced by commit bb9ec13 ("topology: use bin_attribute to break
the size limitation of cpumap ABI") in v5.15-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cbd399f78e23ad4492c174fc5e6b3676dba74a52]
stable/6.1: [ca47e933a900492d89dcf5db18a99c28bd4a742d]
stable/6.6: [b02cf1d27e460ab2b3e1c8c9ce472d562cad2e8d]

CVE-2024-57918: drm/amd/display: fix page fault due to max surface
definition mismatch

Announce: https://lore.kernel.org/linux-cve-announce/2025011941-CVE-2024-57918-ad02@gregkh/

Introduced by commit 1b04dcc ("drm/amd/display: Introduce overlay
cursor mode") in v6.11-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7de8d5c90be9ad9f6575e818a674801db2ada794]

CVE-2024-57919: drm/amd/display: fix divide error in DM plane scale calcs

Announce: https://lore.kernel.org/linux-cve-announce/2025011941-CVE-2024-57919-9800@gregkh/

Introduced by commit 1b04dcc ("drm/amd/display: Introduce overlay
cursor mode") in v6.11-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5225fd2a26211d012533acf98a6ad3f983885817]

CVE-2024-57920: drm/amdkfd: wq_release signals dma_fence only when available

Announce: https://lore.kernel.org/linux-cve-announce/2025011942-CVE-2024-57920-b514@gregkh/

Introduced by commit 967d226 ("dma-buf: add WARN_ON() illegal
dma-fence signaling") in v6.13-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a993d319aebb7cce8a10c6e685344b7c2ad5c4c2]

CVE-2024-57921: drm/amdgpu: Add a lock when accessing the buddy trim function

Announce: https://lore.kernel.org/linux-cve-announce/2025011942-CVE-2024-57921-836d@gregkh/

Introduced by commit 4a5ad08 ("drm/amdgpu: Add address alignment
support to DCC buffers") in v6.11-rc3.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [75c8b703e5bded1e33b08fb09b829e7c2c1ed50a]

CVE-2024-57922: drm/amd/display: Add check for granularity in dml
ceil/floor helpers

Announce: https://lore.kernel.org/linux-cve-announce/2025011942-CVE-2024-57922-1f81@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc7.
dml_ceil_ex and dml_floor_ex were added by commit 061bfa0 ("drm/amdgpu/display:
Add dml support for DCN") in 4.15-rc1. Added granularity parameter to
dml_ceil and
dml_floor is 6d04ee9 ("drm/amd/display: Restructuring and cleaning up
DML") in 4.15-rc1.

Fixed status
mainline: [0881fbc4fd62e00a2b8e102725f76d10351b2ea8]
stable/6.1: [f3d1e4062ef251fa55ccfeca1e54a98b6818b3a1]
stable/6.6: [ae9ab63a268be99a27a4720ca24f6be801744fee]

CVE-2024-57923: btrfs: zlib: fix avail_in bytes for s390 zlib HW
compression path

Announce: https://lore.kernel.org/linux-cve-announce/2025011943-CVE-2024-57923-3c99@gregkh/

Introduced by commit fd1e75d ("btrfs: make compression path to be
subpage compatible") in v6.12-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ee4736c003daded513de0ff112d4a1e9c85bbab]

CVE-2024-57924: fs: relax assertions on failure to encode file handles

Announce: https://lore.kernel.org/linux-cve-announce/2025011943-CVE-2024-57924-954a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc7.


Fixed status
mainline: [974e3fe0ac61de85015bbe5a4990cf4127b304b2]

CVE-2024-57925: ksmbd: fix a missing return value check bug

Announce: https://lore.kernel.org/linux-cve-announce/2025011944-CVE-2024-57925-b738@gregkh/

Introduced by commit 041bba4 ("ksmbd: fix wrong interim response on
compound") in v6.6-rc1.
Fixed in v6.13-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [4c16e1cadcbcaf3c82d5fc310fbd34d0f5d0db7c]
stable/6.1: [ee7e40f7fb17f08a8cbae50553e5c2e10ae32fce]
stable/6.6: [271ae0edbfc942795c162e6cf20d2bc02bd7fde4]

CVE-2024-57926: drm/mediatek: Set private->all_drm_private[i]->drm to
NULL if mtk_drm_bind returns err

Announce: https://lore.kernel.org/linux-cve-announce/2025011944-CVE-2024-57926-023f@gregkh/

Introduced by commit 1ef7ed4 ("drm/mediatek: Modify mediatek-drm for
mt8195 multi mmsys support") in v6.4-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [36684e9d88a2e2401ae26715a2e217cb4295cea7]
stable/6.6: [7083b93e9755d60f0c2bcaa9d064308108280534]

CVE-2024-57927: nfs: Fix oops in nfs_netfs_init_request() when copying to cache

Announce: https://lore.kernel.org/linux-cve-announce/2025011944-CVE-2024-57927-fb00@gregkh/

Introduced by commit ee4cdf7 ("netfs: Speed up buffered reading") in v6.12-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [86ad1a58f6a9453f49e06ef957a40a8dac00a13f]

CVE-2024-57928: netfs: Fix enomem handling in buffered reads

Announce: https://lore.kernel.org/linux-cve-announce/2025011945-CVE-2024-57928-7291@gregkh/

Introduced by commit ee4cdf7 ("netfs: Speed up buffered reading") in v6.12-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [105549d09a539a876b7c3330ab52d8aceedad358]

CVE-2024-57929: dm array: fix releasing a faulty array block twice in
dm_array_cursor_end

Announce: https://lore.kernel.org/linux-cve-announce/2025011945-CVE-2024-57929-2b82@gregkh/

Introduced by commit fdd1315 ("dm array: introduce cursor api") in v4.9-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f2893c0804d86230ffb8f1c8703fdbb18648abc8]
stable/6.1: [e477021d252c007f0c6d45b5d13d341efed03979]
stable/6.6: [6002bec5354f86d1a2df21468f68e3ec03ede9da]

CVE-2025-21631: block, bfq: fix waker_bfqq UAF after bfq_split_bfqq()

Announce: https://lore.kernel.org/linux-cve-announce/2025011939-CVE-2025-21631-5f2d@gregkh/

Introduced by commit 1ba0403 ("block, bfq: fix uaf for accessing
waker_bfqq after splitting") in v6.12-rc1.
Fixed in v6.13-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [fcede1f0a043ccefe9bc6ad57f12718e42f63f1d]
stable/6.1: [2550149fcdf2934155ff625d76ad4e3d4b25bbc6]
stable/6.6: [be3eed59ac01f429ac10aaa46e26f653bcf581ab]

CVE-2025-21632: x86/fpu: Ensure shadow stack is active before
"getting" registers

Announce: https://lore.kernel.org/linux-cve-announce/2025011942-CVE-2025-21632-9fde@gregkh/

Introduced by commit 2fab02b ("x86: Add PTRACE interface for shadow
stack") in v6.6-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a9d9c33132d49329ada647e4514d210d15e31d81]
stable/6.6: [0a3a872214188e4268d31581ed0cd44508e038cf]

CVE-2025-21633: io_uring/sqpoll: zero sqd->thread on tctx errors

Announce: https://lore.kernel.org/linux-cve-announce/2025011942-CVE-2025-21633-a313@gregkh/

Introduced by commit 1251d20 ("io_uring/sqpoll: early exit thread if
task_context wasn't allocated") in v6.9-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b7cfa8b6c28a9fa22b86894166a1a34f6d630ba]

CVE-2025-21634: cgroup/cpuset: remove kernfs active break

Announce: https://lore.kernel.org/linux-cve-announce/2025011942-CVE-2025-21634-011f@gregkh/

Introduced by commit bdb2fd7 ("kernfs: Skip kernfs_drain_open_files()
more aggressively") in v6.1-rc1.
Introduced by commit 76bb5ab ("cpuset: break kernfs active protection
in cpuset_write_resmask()") in v3.16-rc5.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3cb97a927fffe443e1e7e8eddbfebfdb062e86ed]

CVE-2025-21635: rds: sysctl: rds_tcp_{rcv,snd}buf: avoid using current->nsproxy

Announce: https://lore.kernel.org/linux-cve-announce/2025011943-CVE-2025-21635-12e7@gregkh/

Introduced by commit c6a58ff ("RDS: TCP: Add sysctl tunables for
sndbuf/rcvbuf on rds-tcp socket") in v4.6-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f5611cbc4871c7fb1ad36c2e5a9edad63dca95c]

CVE-2025-21636: sctp: sysctl: plpmtud_probe_interval: avoid using
current->nsproxy

Announce: https://lore.kernel.org/linux-cve-announce/2025011943-CVE-2025-21636-0bb0@gregkh/

Introduced by commit d1e462a ("sctp: add probe_interval in sysctl and
sock/asoc/transport") in v5.14-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6259d2484d0ceff42245d1f09cc8cb6ee72d847a]
stable/6.1: [44ee8635922b6eb940faddb961a8347c6857d722]
stable/6.6: [284a221f8fa503628432c7bb5108277c688c6ffa]

CVE-2025-21637: sctp: sysctl: udp_port: avoid using current->nsproxy

Announce: https://lore.kernel.org/linux-cve-announce/2025011943-CVE-2025-21637-3dde@gregkh/

Introduced by commit 046c052 ("sctp: enable udp tunneling socks") in v5.11-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c10377bbc1972d858eaf0ab366a311b39f8ef1b6]
stable/6.1: [e919197fb8616331f5dc81e4c3cc3d12769cb725]
stable/6.6: [55627918febdf9d71107a1e68d1528dc591c9a15]

CVE-2025-21638: sctp: sysctl: auth_enable: avoid using current->nsproxy

Announce: https://lore.kernel.org/linux-cve-announce/2025011944-CVE-2025-21638-35a8@gregkh/

Introduced by commit b14878c ("net: sctp: cache auth_enable per
endpoint") in v3.15-rc2.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [15649fd5415eda664ef35780c2013adeb5d9c695]
stable/6.1: [1b67030d39f2b00f94ac1f0af11ba6657589e4d3]
stable/6.6: [7ec30c54f339c640aa7e49d7e9f7bbed6bd42bf6]

CVE-2025-21639: sctp: sysctl: rto_min/max: avoid using current->nsproxy

Announce: https://lore.kernel.org/linux-cve-announce/2025011944-CVE-2025-21639-f1ca@gregkh/

Introduced by commit 4f3fdf3 ("sctp: add check rto_min and rto_max in
sysctl") in v3.13-rc4.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9fc17b76fc70763780aa78b38fcf4742384044a5]
stable/6.1: [4059507e34aa5fe0fa9fd5b2b5f0c8b26ab2d482]
stable/6.6: [dc9d0e3cfd16f66fbf0862857c6b391c8613ca9f]

CVE-2025-21640: sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy

Announce: https://lore.kernel.org/linux-cve-announce/2025011944-CVE-2025-21640-4dd1@gregkh/

Introduced by commit 3c68198 ("sctp: Make hmac algorithm selection for
cookie generation dynamic") in v3.8-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea62dd1383913b5999f3d16ae99d411f41b528d4]
stable/6.1: [3cd0659deb9c03535fd61839e91d4d4d3e51ac71]
stable/6.6: [ad673e514b2793b8d5902f6ba6ab7e890dea23d5]

CVE-2025-21641: mptcp: sysctl: blackhole timeout: avoid using current->nsproxy

Announce: https://lore.kernel.org/linux-cve-announce/2025011944-CVE-2025-21641-0897@gregkh/

Introduced by commit 27069e7 ("mptcp: disable active MPTCP in case of
blackhole") in v6.12-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [92cf7a51bdae24a32c592adcdd59a773ae149289]

CVE-2025-21642: mptcp: sysctl: sched: avoid using current->nsproxy

Announce: https://lore.kernel.org/linux-cve-announce/2025011944-CVE-2025-21642-5728@gregkh/

Introduced by commit 6963c50 ("mptcp: only allow set existing
scheduler for net.mptcp.scheduler") in v6.9.
Fixed in v6.13-rc7.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [d38e26e36206ae3d544d496513212ae931d1da0a]
stable/6.6: [c0e394fd6b887e84da17e38aaa6c1c104f9c86c2]

CVE-2025-21643: netfs: Fix kernel async DIO

Announce: https://lore.kernel.org/linux-cve-announce/2025011945-CVE-2025-21643-f3f6@gregkh/

Introduced by commit 153a996 ("netfs: Implement unbuffered/DIO write
support") in v6.8-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f6bc9e3ab9b127171d39f9ac6eca1abb693b731]

CVE-2025-21644: drm/xe: Fix tlb invalidation when wedging

Announce: https://lore.kernel.org/linux-cve-announce/2025011945-CVE-2025-21644-9113@gregkh/

Introduced by commit c9474b7 ("drm/xe: Wedge the entire device") in v6.11-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ab4981552930a9c45682d62424ba610edc3992d]

CVE-2025-21645: platform/x86/amd/pmc: Only disable IRQ1 wakeup where
i8042 actually enabled it

Announce: https://lore.kernel.org/linux-cve-announce/2025011945-CVE-2025-21645-e342@gregkh/

Introduced by commit 8e60615 ("platform/x86/amd: pmc: Disable IRQ1
wakeup for RN/CZN") in v6.2-rc6.
Fixed in v6.13-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [dd410d784402c5775f66faf8b624e85e41c38aaf]
stable/6.6: [5cc621085e2b7a9b1905a98f8e5a86bb4aea2016]

CVE-2025-21646: afs: Fix the maximum cell name length

Announce: https://lore.kernel.org/linux-cve-announce/2025011945-CVE-2025-21646-8f6e@gregkh/

Introduced by commit c3e9f88 ("afs: Implement client support for the
YFSVL.GetCellName RPC op") in v5.8-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8fd56ad6e7c90ac2bddb0741c6b248c8c5d56ac8]
stable/6.1: [aabe47cf5ac5e1db2ae0635f189d836f67024904]
stable/6.6: [7673030efe0f8ca1056d3849d61784c6caa052af]

CVE-2025-21647: sched: sch_cake: add bounds checks to host bulk flow
fairness counts

Announce: https://lore.kernel.org/linux-cve-announce/2025011946-CVE-2025-21647-51d8@gregkh/

Introduced by commit 546ea84 ("sched: sch_cake: fix bulk flow
accounting logic for host fairness") in v6.11-rc7.
Fixed in v6.13-rc7.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [737d4d91d35b5f7fa5bb442651472277318b0bfd]
stable/6.1: [a777e06dfc72bed73c05dcb437d7c27ad5f90f3f]
stable/6.6: [27202e2e8721c3b23831563c36ed5ac7818641ba]

CVE-2025-21648: netfilter: conntrack: clamp maximum hashtable size to INT_MAX

Announce: https://lore.kernel.org/linux-cve-announce/2025011946-CVE-2025-21648-bcda@gregkh/

Introduced by commit 9cc1c73 ("netfilter: conntrack: avoid integer
overflow when resizing") in v4.7.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b541ba7d1f5a5b7b3e2e22dc9e40e18a7d6dbc13]
stable/6.1: [5552b4fd44be3393b930434a7845d8d95a2a3c33]
stable/6.6: [d5807dd1328bbc86e059c5de80d1bbee9d58ca3d]

CVE-2025-21649: net: hns3: fix kernel crash when 1588 is sent on HIP08 devices

Announce: https://lore.kernel.org/linux-cve-announce/2025011946-CVE-2025-21649-f7ac@gregkh/

Introduced by commit 0bf5eb7 ("net: hns3: add support for PTP") in v5.14-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9741e72b2286de8b38de9db685588ac421a95c87]

CVE-2025-21650: net: hns3: fixed hclge_fetch_pf_reg accesses bar space
out of bounds issue

Announce: https://lore.kernel.org/linux-cve-announce/2025011946-CVE-2025-21650-3a74@gregkh/

Introduced by commit 939ccd1 ("net: hns3: move dump regs function to a
separate file") in v6.6-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7997ddd46c54408bcba5e37fe18b4d832e45d4d4]

CVE-2025-21651: net: hns3: don't auto enable misc vector

Announce: https://lore.kernel.org/linux-cve-announce/2025011946-CVE-2025-21651-fbe8@gregkh/

Introduced by commit 7be1b9f ("net: hns3: make hclge_service use
delayed workqueue") in v5.4-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98b1e3b27734139c76295754b6c317aa4df6d32e]

CVE-2025-21652: ipvlan: Fix use-after-free in ipvlan_get_iflink().

Announce: https://lore.kernel.org/linux-cve-announce/2025011947-CVE-2025-21652-95d7@gregkh/

Introduced by commit 8c55fac ("net: linkwatch: only report
IF_OPER_LOWERLAYERDOWN if iflink is actually down") in v6.2-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb358ff94154774d031159b018adf45e17673941]
stable/6.6: [ba9f7c16ec879c83bb4f80406773a911aace8267]

CVE-2025-21653: net_sched: cls_flow: validate TCA_FLOW_RSHIFT attribute

Announce: https://lore.kernel.org/linux-cve-announce/2025011947-CVE-2025-21653-b6c0@gregkh/

Introduced by commit e5dfb81 ("[NET_SCHED]: Add flow classifier") in
v2.6.25-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a039e54397c6a75b713b9ce7894a62e06956aa92]
stable/6.1: [2011749ca96460386844dfc7e0fde53ebee96f3c]
stable/6.6: [e54beb9aed2a90dddf4c5d68fcfc9a01f3e40a61]

CVE-2025-21654: ovl: support encoding fid from inode with no alias

Announce: https://lore.kernel.org/linux-cve-announce/2025011947-CVE-2025-21654-5eac@gregkh/

Introduced by commit 16aac5a ("ovl: support encoding non-decodable
file handles") in v6.6-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c45beebfde34aa71afbc48b2c54cdda623515037]
stable/6.6: [a1a541fbfa7e97c1100144db34b57553d7164ce5]

CVE-2023-52923: netfilter: nf_tables: adapt set backend to use GC
transaction API

Announce: https://lore.kernel.org/linux-cve-announce/2025012034-CVE-2023-52923-416e@gregkh/

Introduced by commit 3c4287f ("nf_tables: Add set type for arbitrary
concatenation of ranges") in v5.6-rc1.
Introduced by commit 8d8540c ("netfilter: nft_set_rbtree: add timeout
support") in v4.18-rc1.
Introduced by commit 9d09829 ("netfilter: nft_hash: add support for
timeouts") in v4.1-rc1.
Fixed in v6.5-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f6c383b8c31a93752a52697f8430a71dcbc46adf]
stable/4.19: [cb4d00b563675ba8ff6ef94b077f58d816f68ba3]
stable/5.10: [146c76866795553dbc19998f36718d7986ad302b]
stable/5.15: [479a2cf5259347d6a1f658b0f791d27a34908e91]
stable/5.4: [c357648929c8dff891502349769aafb8f0452bc2]
stable/6.1: [df650d6a4bf47248261b61ef6b174d7c54034d15]

CVE-2025-21655: io_uring/eventfd: ensure io_eventfd_signal() defers
another RCU period

Announce: https://lore.kernel.org/linux-cve-announce/2025012000-CVE-2025-21655-2cc8@gregkh/

Introduced by commit 21a091b ("io_uring: signal registered eventfd to
process deferred task work") in v6.1-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9a40292a44e78f71258b8522655bffaf5753bdb]
stable/6.1: [6b63308c28987c6010b1180c72a6db4df6c68033]
stable/6.6: [8efff2aa2d95dc437ab67c5b4a9f1d3f367baa10]

CVE-2024-57930: tracing: Have process_string() also allow arrays

Announce: https://lore.kernel.org/linux-cve-announce/2025012143-CVE-2024-57930-55c0@gregkh/

This CVE announce does not contain fixed commit in the mainline.

Bug introduced commit was backported to following branches.
cip/6.1 stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [afc6717628f959941d7b33728570568b4af1c4b8]
stable/5.15: [3bcdc9039a6e9e6e47ed689a37b8d57894a3c571]
stable/6.1: [3bcdc9039a6e9e6e47ed689a37b8d57894a3c571]
stable/6.6: [631b1e09e213c86d5a4ce23d45c81af473bb0ac7]

CVE-2024-57931: selinux: ignore unknown extended permissions

Announce: https://lore.kernel.org/linux-cve-announce/2025012147-CVE-2024-57931-06fb@gregkh/

Introduced by commit fa1aa14 ("selinux: extended permissions for
ioctls") in v4.3-rc1.
Fixed in v6.13-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [900f83cf376bdaf798b6f5dcb2eae0c822e908b6]
stable/5.10: [712137b177b45f255ce5687e679d950fcb218256]
stable/5.15: [f70e4b9ec69d9a74b84c17767a9a4eda8c901021]
stable/5.4: [f45a77dd24ae9ddb474303ec3975c376bd99fc51]
stable/6.1: [c79324d42fa48372e0acb306a2761cc642bd4db0]
stable/6.6: [c1dbd28a079553de0023e1c938c713efeeee400f]

CVE-2024-57932: gve: guard XDP xmit NDO on existence of xdp queues

Announce: https://lore.kernel.org/linux-cve-announce/2025012147-CVE-2024-57932-a9f5@gregkh/

Introduced by commit 39a7f4a ("gve: Add XDP REDIRECT support for
GQI-QPL format") in v6.4-rc1.
Fixed in v6.13-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff7c2dea9dd1a436fc79d6273adffdcc4a7ffea3]
stable/6.6: [cbe9eb2c39d09f3c8574febcfa39d8c09d0c7cb5]

CVE-2024-57933: gve: guard XSK operations on the existence of queues

Announce: https://lore.kernel.org/linux-cve-announce/2025012148-CVE-2024-57933-aa3e@gregkh/

Introduced by commit fd8e403 ("gve: Add AF_XDP zero-copy support for
GQI-QPL format") in v6.4-rc1.
Fixed in v6.13-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [40338d7987d810fcaa95c500b1068a52b08eec9b]
stable/6.6: [771d66f2bd8c4dba1286a9163ab982cecd825718]

CVE-2024-57934: fgraph: Add READ_ONCE() when accessing fgraph_array[]

Announce: https://lore.kernel.org/linux-cve-announce/2025012148-CVE-2024-57934-6cd8@gregkh/

Introduced by commit 37238ab ("ftrace/function_graph: Pass fgraph_ops
to function graph callbacks") in v6.11-rc1.
Fixed in v6.13-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d65474033740ded0a4fe9a097fce72328655b41d]

CVE-2024-57935: RDMA/hns: Fix accessing invalid dip_ctx during destroying QP

Announce: https://lore.kernel.org/linux-cve-announce/2025012149-CVE-2024-57935-d9b8@gregkh/

This CVE announce does not contain fixed commit in the mainline.

Bug introduced commit was backported to following branches.
stable/6.12

Fixed status
mainline: [0572eccf239ce4bd89bd531767ec5ab20e249290]

CVE-2024-57936: RDMA/bnxt_re: Fix max SGEs for the Work Request

Announce: https://lore.kernel.org/linux-cve-announce/2025012149-CVE-2024-57936-03a6@gregkh/

Introduced by commit 227f517 ("RDMA/bnxt_re: Fix the max WQE size for
static WQE support") in v6.12-rc1.
Fixed in v6.12.9.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [9a479088e0c8f6140b8c7752b563bc8c6c6dcc8c]
stable/6.6: [3de1b50f055dc2ca7072a526cdda21f691c22dd9]

CVE-2024-57937: [REJECTED]: mm: reinstate ability to map write-sealed
memfd mappings read-only

Announce: https://lore.kernel.org/linux-cve-announce/2025012119-CVE-2024-57937-158a@gregkh/

This CVE was rejected. Introduced by commit 5de1950 ("mm: resolve
faulty mmap_region() error path behaviour") in v6.12-rc7.
Fixed in v6.13-rc6.

Bug introduced commit was backported to following branches.
cip/5.10 cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [8ec396d05d1b737c87311fb7311f753b02c2a6b1]

CVE-2024-57938: net/sctp: Prevent autoclose integer overflow in
sctp_association_init()

Announce: https://lore.kernel.org/linux-cve-announce/2025012119-CVE-2024-57938-eaa0@gregkh/

Introduced by commit 9f70f46 ("sctp: properly latch and use autoclose
value from sock to association") in v3.13-rc4.
Fixed in v6.13-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e86729d1ff329815a6e8a920cb554a1d4cb5b8d]
stable/5.10: [081bdb3a31674339313c6d702af922bc29de2c53]
stable/5.15: [f9c3adb083d3278f065a83c3f667f1246c74c31f]
stable/5.4: [94b7ed0a4896420988e1776942f0a3f67167873e]
stable/6.1: [7af63ef5fe4d480064eb22583b24ffc8b408183a]
stable/6.6: [271f031f4c31c07e2a85a1ba2b4c8e734909a477]

CVE-2024-57939: riscv: Fix sleeping in invalid context in die()

Announce: https://lore.kernel.org/linux-cve-announce/2025012127-CVE-2024-57939-fb7b@gregkh/

Introduced by commit 76d2a04 ("RISC-V: Init and Halt Code") in v4.15-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6a97f4118ac07cfdc316433f385dbdc12af5025e]
stable/6.1: [c21df31fc2a4afc02a6e56511364e9e793ea92ec]
stable/6.6: [f48f060a4b36b5e96628f6c3fb1540f1e8dedb69]

CVE-2024-57940: exfat: fix the infinite loop in exfat_readdir()

Announce: https://lore.kernel.org/linux-cve-announce/2025012128-CVE-2024-57940-e289@gregkh/

Introduced by commit ca06197 ("exfat: add directory operations") in v5.7-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fee873761bd978d077d8c55334b4966ac4cb7b59]
stable/6.1: [31beabd0f47f8c3ed9965ba861c9e5b252d4920a]
stable/6.6: [dc1d7afceb982e8f666e70a582e6b5aa806de063]

CVE-2024-57941: netfs: Fix the (non-)cancellation of copy when cache
is temporarily disabled

Announce: https://lore.kernel.org/linux-cve-announce/2025012128-CVE-2024-57941-8779@gregkh/

Introduced by commit ee4cdf7 ("netfs: Speed up buffered reading") in v6.12-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d0327c824338cdccad058723a31d038ecd553409]

CVE-2024-57942: netfs: Fix ceph copy to cache on write-begin

Announce: https://lore.kernel.org/linux-cve-announce/2025012129-CVE-2024-57942-bedc@gregkh/

Introduced by commit 796a404 ("netfs: In readahead, put the folio refs
as soon extracted") in v6.12-rc5.
Introduced by commit ee4cdf7 ("netfs: Speed up buffered reading") in v6.12-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [38cf8e945721ffe708fa675507465da7f4f2a9f7]

CVE-2024-57943: exfat: fix the new buffer was not zeroed before writing

Announce: https://lore.kernel.org/linux-cve-announce/2025012129-CVE-2024-57943-7a6e@gregkh/

Introduced by commit 6630ea4 ("exfat: move extend valid_size into
->page_mkwrite()") in v6.12-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98e2fb26d1a9eafe79f46d15d54e68e014d81d8c]

CVE-2024-57944: iio: adc: ti-ads1298: Add NULL check in ads1298_init

Announce: https://lore.kernel.org/linux-cve-announce/2025012130-CVE-2024-57944-28e7@gregkh/

Introduced by commit 00ef770 ("iio: adc: ti-ads1298: Add driver") in v6.9-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bcb394bb28e55312cace75362b8e489eb0e02a30]

CVE-2024-57945: riscv: mm: Fix the out of bound issue of vmemmap address

Announce: https://lore.kernel.org/linux-cve-announce/2025012130-CVE-2024-57945-248b@gregkh/

Introduced by commit a11dd49 ("riscv: Sparse-Memory/vmemmap
out-of-bounds fix") in v6.8-rc7.
Fixed in v6.13-rc7.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [f754f27e98f88428aaf6be6e00f5cbce97f62d4b]
stable/6.6: [a4a7ac3d266008018f05fae53060fcb331151a14]

CVE-2024-57946: virtio-blk: don't keep queue frozen during system suspend

Announce: https://lore.kernel.org/linux-cve-announce/2025012156-CVE-2024-57946-41e8@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.13-rc2.
According to the commit message, this bug was introduced by commit
4ce6e2d ("virtio-blk:
Ensure no requests in virtqueues before deleting vqs.") in 6.8-rc4.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt
stable/5.10 stable/5.15 stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [7678abee0867e6b7fb89aa40f6e9f575f755fb37]
stable/5.10: [9ca428c6397abaa8c38f5c69133a2299e1efbbf2]
stable/5.15: [6dea8e3de59928974bf157dd0499d3958d744ae4]
stable/5.4: [d738f3215bb4f88911ff4579780a44960c8e0ca5]
stable/6.1: [9e323f856cf4963120e0e3892a84ef8bd764a0e4]
stable/6.6: [12c0ddd6c551c1e438b087f874b4f1223a75f7ea]

CVE-2025-21656: hwmon: (drivetemp) Fix driver producing garbage data
when SCSI errors occur

Announce: https://lore.kernel.org/linux-cve-announce/2025012131-CVE-2025-21656-b967@gregkh/

Introduced by commit 5b46903 ("hwmon: Driver for disk and solid state
drives with temperature sensors") in v5.6-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [82163d63ae7a4c36142cd252388737205bb7e4b9]
stable/6.6: [53e25b10a28edaf8c2a1d3916fd8929501a50dfc]

CVE-2025-21657: sched_ext: Replace rq_lock() to raw_spin_rq_lock() in
scx_ops_bypass()

Announce: https://lore.kernel.org/linux-cve-announce/2025012131-CVE-2025-21657-5f7d@gregkh/

Introduced by commit 0e7ffff ("scx: Fix raciness in scx_ops_bypass()")
in v6.12-rc6.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6268d5bc10354fc2ab8d44a0cd3b042d49a0417e]

CVE-2025-21658: btrfs: avoid NULL pointer dereference if no valid extent tree

Announce: https://lore.kernel.org/linux-cve-announce/2025012132-CVE-2025-21658-78d9@gregkh/

Introduced by commit 42437a6 ("btrfs: introduce mount option
rescue=ignorebadroots") in v5.11-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6aecd91a5c5b68939cf4169e32bc49f3cd2dd329]
stable/6.6: [24b85a8b0310e0144da9ab30be42e87e6476638a]

CVE-2025-21659: netdev: prevent accessing NAPI instances from another namespace

Announce: https://lore.kernel.org/linux-cve-announce/2025012133-CVE-2025-21659-1c41@gregkh/

Introduced by commit 1287c1a ("netdev-genl: Support setting per-NAPI
config values") in v6.13-rc1.
Introduced by commit 27f91aa ("netdev-genl: Add netlink framework
functions for napi") in v6.8-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1cacd74776895f6435941f86a1130e58f6dd226]

CVE-2025-21660: ksmbd: fix unexpectedly changed path in
ksmbd_vfs_kern_path_locked

Announce: https://lore.kernel.org/linux-cve-announce/2025012133-CVE-2025-21660-cfac@gregkh/

Introduced by commit c5a709f ("ksmbd: handle caseless file creation")
in v6.12-rc1.
Fixed in v6.13-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [2ac538e40278a2c0c051cca81bcaafc547d61372]
stable/6.1: [13e41c58c74baa71f34c0830eaa3c29d53a6e964]
stable/6.6: [65b31b9d992c0fb0685c51a0cf09993832734fc4]

CVE-2025-21661: gpio: virtuser: fix missing lookup table cleanups

Announce: https://lore.kernel.org/linux-cve-announce/2025012134-CVE-2025-21661-2a1e@gregkh/

Introduced by commit 91581c4 ("gpio: virtuser: new virtual testing
driver for the GPIO API") in v6.11-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a619cba8c69c434258ff4101d463322cd63e1bdc]

CVE-2025-21662: net/mlx5: Fix variable not being completed when function returns

Announce: https://lore.kernel.org/linux-cve-announce/2025012134-CVE-2025-21662-0c72@gregkh/

Introduced by commit 485d65e ("net/mlx5: Add a timeout to acquire the
command queue semaphore") in v6.10-rc1.
Fixed in v6.13-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [0e2909c6bec9048f49d0c8e16887c63b50b14647]
stable/6.1: [f0a2808767ac39f64b1d9a0ff865c255073cf3d4]
stable/6.6: [229cc10284373fbe754e623b7033dca7e7470ec8]

CVE-2025-21663: net: stmmac: dwmac-tegra: Read iommu stream id from device tree

Announce: https://lore.kernel.org/linux-cve-announce/2025012135-CVE-2025-21663-7420@gregkh/

Introduced by commit d8ca113 ("net: stmmac: tegra: Add MGBE support")
in v6.2-rc1.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [426046e2d62dd19533808661e912b8e8a9eaec16]
stable/6.6: [235419f0956e8c60e597aa1619ded8bda7460bb4]

CVE-2025-21664: dm thin: make get_first_thin use rcu-safe list first function

Announce: https://lore.kernel.org/linux-cve-announce/2025012135-CVE-2025-21664-3744@gregkh/

Introduced by commit b10ebd3 ("dm thin: fix rcu_read_lock being held
in code that can sleep") in v3.15-rc4.
Fixed in v6.13-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [80f130bfad1dab93b95683fc39b87235682b8f72]
stable/6.1: [12771050b6d059eea096993bf2001da9da9fddff]
stable/6.6: [6b305e98de0d225ccebfb225730a9f560d28ecb0]

* Updated CVEs

CVE-2024-40917: memblock: make memblock_set_node() also warn about use
of MAX_NUMNODES

stable/6.6 was fixed.

Fixed status
stable/6.6: [4ddb7f966f3d06fcf1ba5ee298af6714b593584b]
stable/6.9: [22f742b8f738918f683198a18ec3c691acda14c4]

CVE-2024-47736: erofs: handle overlapped pclusters out of crafted
images properly

stable/6.6 was fixed.

Fixed status
stable/6.11: [9cfa199bcbbbba31cbf97b2786f44f4464f3f29a]
stable/6.6: [1bf7e414cac303c9aec1be67872e19be8b64980c]

CVE-2024-50164: bpf: Fix overloading of MEM_UNINIT's meaning

stable/6.1 was fixed.

Fixed status
stable/6.1: [43f4df339a4d375bedcad29a61ae6f0ee7a048f8]
stable/6.11: [54bc31682660810af1bed7ca7a19f182df8d3df8]
stable/6.6: [48068ccaea957469f1adf78dfd2c1c9a7e18f0fe]

CVE-2024-53128: sched/task_stack: fix object_is_on_stack() for KASAN
tagged pointers

stable/6.1 was fixed.

Fixed status
stable/6.1: [397383db9c69470642ac95beb04f2150928d663b]
stable/6.11: [fbfe23012cec509dfbe09852019c4e4bb84999d0]
stable/6.6: [2d2b19ed4169c38dc6c61a186c5f7bdafc709691]

CVE-2024-53221: f2fs: fix null-ptr-deref in f2fs_submit_page_bio()

stable/6.6 was fixed.

Fixed status
stable/6.12: [9e11b1d5fda972f6be60ab732976a7c8e064cd56]
stable/6.6: [8dddc12d03248755d9f709bc1eb9e3ea2bf1b322]

CVE-2024-53685: ceph: give up on paths longer than PATH_MAX

stable/6.1 was fixed.

Fixed status
stable/6.1: [e4b168c64da06954be5d520f6c16469b1cadc069]
stable/6.12: [99a37ab76a315c8307eb5b0dc095d8ad9d8efeaa]
stable/6.6: [c47ed91156daf328601d02b58d52d9804da54108]

CVE-2024-56664: bpf, sockmap: Fix race between element replace and close()

stable/6.1 was fixed.

Fixed status
stable/6.1: [b79a0d1e9a374d1b376933a354c4fcd01fce0365]
stable/6.12: [bf2318e288f636a882eea39f7e1015623629f168]
stable/6.6: [b015f19fedd2e12283a8450dd0aefce49ec57015]

CVE-2024-57883: mm: hugetlb: independent PMD page table shared count

stable/6.6 was fixed.

Fixed status
stable/6.12: [2e31443a0d18ae43b9d29e02bf0563f07772193d]
stable/6.6: [56b274473d6e7e7375f2d0a2b4aca11d67c6b52f]

CVE-2024-57887: drm: adv7511: Fix use-after-free in adv7533_attach_dsi()

stable/6.1 was fixed.

Fixed status
stable/6.1: [d208571943ffddc438a7ce533d5d0b9219806242]
stable/6.12: [ca9d077350fa21897de8bf64cba23b198740aab5]
stable/6.6: [1f49aaf55652580ae63ab83d67211fe6a55d83dc]

CVE-2024-57888: workqueue: Do not warn when cancelling WQ_MEM_RECLAIM
work from !WQ_MEM_RECLAIM worker

stable/6.6 was fixed.

Fixed status
stable/6.12: [ffb231471a407c96e114070bf828cd2378fdf431]
stable/6.6: [1fd2a57dcb4de3cb40844a29c71b5d7b46a84334]

CVE-2024-57892: ocfs2: fix slab-use-after-free due to dangling pointer dqi_priv

stable/6.1 was fixed.

Fixed status
stable/6.1: [2d431192486367eee03cc28d0b53b97dafcb8e63]
stable/6.12: [ba950a02d8d23811aa1120affd3adedcfac6153d]
stable/6.6: [2e3d203b1adede46bbba049e497765d67865be18]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com


Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899C3E9A04A
	for <webhook@archiver.kernel.org>; Thu, 19 Feb 2026 01:01:01 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4586.1771462856964525157
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Feb 2026 17:00:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=pOX8LYOm;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.177, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-797ab169454so4442317b3.3
        for <cip-dev@lists.cip-project.org>; Wed, 18 Feb 2026 17:00:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771462856; cv=none;
        d=google.com; s=arc-20240605;
        b=Vja2hkFvejAqT0H6Ri30TpyFQu8cl6R0TAooZWEipj9Q7K/qKU1KjXgvYLa745TuFw
         3VCvcBnUyhEj7q/D5gz6iwWZipSjo3oL0arpuJUZ8Sei+PuiaPDoo09rHQTPz9PsdqPM
         dOpoDAMurKvSguqvSUVjf/I3q/tmBCjjKp3fe+HOH3Y6+0K5Bcww9WI4kaTRxldEmcEQ
         T1RRaRdnYKqyOpdBMOe98V8CFPRJ1vvP9vqCZ7R/OQMckqKwstXiNc2/6QrfZInZi0MZ
         5Nmb75ZDhssA/PtHV97jaaZ5oCrnKamW6omzw6XVTKTCzlXdTbjlfThA9kapRl7DXLjG
         f02w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=uOmxPMg1c5EA/2ZZHG+VY0WgwaP94Kr1gee00UDb8Sw=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=jhw8IcMj9m48jvBx7cDFGtZnQkscCfPC/TrseEDlFDkLZCu18rERetR3e8FS1/Ru+9
         lQ1DvLpHxX3e1mf8TfReg9ketN3I02GE11Xb7HnN2RkYdSRsPNqdw7dQ7BG6+cxWksuj
         xGYTncig3U3oNpbzRNNrMEe9V1uLS7wQ/G/AvqIUv9I64Je/ebewLWceFWwyJl9xcLMJ
         zACXd1XlPKwAcBdep2bfU3a5SkMJyxp3GnQy+W/iZaCguJPh4eX6sgmjd+W4bGfDDbcu
         dPfxzlikguHZYkQ7CemXkfh2vWTDwFozJW6MeZ/jkq5ftaeVjLlI0PKOxb0WeLhcJMpN
         cc8w==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1771462856; x=1772067656; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uOmxPMg1c5EA/2ZZHG+VY0WgwaP94Kr1gee00UDb8Sw=;
        b=pOX8LYOm7QneoFPMQ+6vO/+efj8exQe/hDsM7MVsVN+PZlU7bnOuDs750gv2aRVqjZ
         pwjljA5p2XxkxdgPn9UsZgqcQRuMB0DOFfMPTzv0yuDYIWRvbqbNjL5fKLJWk6gf8Yov
         VlHT540ib2gwNvuJPRGQj4cfY19Vqj+upyC9xKDQaSqRajIkMi3cRxra7QuSh/sJdFuM
         WqLZS9/kEoSz30Xo1CNvpoq5QrplnSppYW6mDbAsjyrG1sDUxGAyLrYcDfy1mhzaoq0X
         WKzg/EyNGvOUklzKhlGMwdaiDRP41VPlWVkQjPJvfye3n/40bIeg3a//2ajXIs6S93g5
         2Rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771462856; x=1772067656;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uOmxPMg1c5EA/2ZZHG+VY0WgwaP94Kr1gee00UDb8Sw=;
        b=ut2i71dBymlPPdj/hnuhhhIxxyKKsEp3naGosKGRtIm9vZXGZvWY8AtWaFAU2LZk28
         i3uVxYGEq6Ro2YVpqL6UStxri/Bj1CGwqjFzvBe0hsUxUS88PElo08DlyoeOA3m9ZIzf
         w0XE5ZmC3lGpIYo3AkqPtfaWbImwO1FQSk90a2h87P3P5ru3U8o9QtFsIoK1xwyzxh/X
         EgNnS8Er+kNKNPkJUL9yLr71Wf3PWJiXFH6symUVL3iE8gEjsqNQka5L+sDOvFKNI9pr
         yeErPjD+Jbt5Nd0n9IwHbikus6VrnRy03f1Qzifk5b1TJ39PYpWmb6UPXB/3oHY3jJVr
         wA1A==
X-Gm-Message-State: AOJu0YwVuaafEvMlQwrMau/qdxka7rAvcPmceQ/YdBnT8J/K2UrnhOFh
	EE27djcebp2v2bbx4lMPVI7D2r1JCu2rq1AYL6DNHchy+HLkD18CRCLl/JK3OIFKP2OhUVCOPJx
	st81Fz4YSRpoyP2u7qmXriUSyrc+dSj8SDsWVEDk2XvmMd23k5LpFrFY=
X-Gm-Gg: AZuq6aIlAz+bJfQ92wPE/Hmj9hAj9gKD13uKN6pXtlizxRXNQNvVBNpMBe4egzxnpvh
	KcCmHTbN9iP5qTYBV2svTjYhNKyRXAq/deewDATrqUwEc+upwAD4DdZjLUDHYCC+n/TD6E0dSPk
	w03pFrVFyDgZSybxiZP/Tjwf9RAmo5F3Kimau7LVWkhTlGZx07MV88iG4RY78BnSt4uVfqnIN/e
	yQT488NDCEO4qA5aGu4QFO/ETP+inT2H4WxcMJIQ1u5xnDNIz9+T14cR0kNx7Xd7m7t44JYJBaY
	5dFiuDZT
X-Received: by 2002:a05:690c:3403:b0:798:1f8:37a2 with SMTP id
 00721157ae682-79802079e2bmr16566617b3.11.1771462854096; Wed, 18 Feb 2026
 17:00:54 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 19 Feb 2026 10:00:18 +0900
X-Gm-Features: AaiRm53IhvAIciVKzK110y8TeP8uuq2uhQBKvFKGRXdjtXs-05xvte_LNHHJHXo
Message-ID: <CAODzB9qig1JB=oP14jnbson0xS0hvQz+BYjqfu36G1fCK+aFbg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Feb 2026 01:01:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21894

Hi!

It's this week's CVE report.

This week reported 143 new CVEs and 3 updated CVEs.

* New CVEs
CVE-2026-23111: netfilter: nf_tables: fix inverted genmask check in
nft_map_catchall_activate()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23111

Introduced by commit 628bd3e ("netfilter: nf_tables: drop map element
references from preparation phase") in v6.4.
Fixed in v6.19.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [f41c5d151078c5348271ffaf8e7410d96f2d82f8]
stable/5.15: [8c760ba4e36c750379d13569f23f5a6e185333f5]
stable/6.1: [b9b6573421de51829f7ec1cce76d85f5f6fbbd7f]
stable/6.12: [1444ff890b4653add12f734ffeffc173d42862dd]
stable/6.18: [8b68a45f9722f2babe9e7bad00aa74638addf081]
stable/6.6: [42c574c1504aa089a0a142e4c13859327570473d]

CVE-2026-23112: nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23112

Introduced by commit 872d26a ("nvmet-tcp: add NVMe over TCP target
driver") in v5.0-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [52a0a98549344ca20ad81a4176d68d28e3c05a5c]
stable/5.10: [043b4307a99f902697349128fde93b2ddde4686c]
stable/5.15: [42afe8ed8ad2de9c19457156244ef3e1eca94b5d]
stable/6.1: [1385be357e8acd09b36e026567f3a9d5c61139de]
stable/6.12: [19672ae68d52ff75347ebe2420dde1b07adca09f]
stable/6.18: [ab200d71553bdcf4de554a5985b05b2dd606bc57]
stable/6.6: [dca1a6ba0da9f472ef040525fab10fd9956db59f]

CVE-2025-71200: mmc: sdhci-of-dwcmshc: Prevent illegal clock reduction
in HS200/HS400 mode

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71200

Introduced by commit c6f361c ("mmc: sdhci-of-dwcmshc: add support for
rk3588") in v6.0-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3009738a855cf938bbfc9078bec725031ae623a4]
stable/6.1: [59b8a1ca6df4db2ca250e9eeab74e2b0068d69e9]
stable/6.12: [de0ad7156036a50982bcb75a080e4af284502be2]
stable/6.18: [36be050f21dea7a3a76dff5a031da6274e8ee468]
stable/6.6: [f2677d6e2bbc5ba2030825522d2afd0542b038a3]

CVE-2025-71201: netfs: Fix early read unlock of page with EOF in middle

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71201

Introduced by commit e2d46f2 ("netfs: Change the read result collector
to only use one work item") in v6.14-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [570ad253a3455a520f03c2136af8714bc780186d]
stable/6.18: [5b5482c0e5ee740b35a70759d3582477aea8e8e4]

CVE-2025-71202: iommu/sva: invalidate stale IOTLB entries for kernel
address space

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71202

According to the .vulnerable file, this bug was introduced by commit
2f26e0a in v4.4-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e37d5a2d60a338c5917c45296bac65da1382eda5]
stable/6.18: [9f0a7ab700f8620e433b05c57fbd26c92ea186d9]

CVE-2025-71203: riscv: Sanitize syscall table indexing under speculation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71203

According to the .vulnerable file, this bug was introduced by commit
f0bddf5 in v6.4-rc1.
Fixed in v6.19-rc5.
Affected function was added by f0bddf5 ("riscv: entry: Convert to
generic entry") in v6.4-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [25fd7ee7bf58ac3ec7be3c9f82ceff153451946c]
stable/6.12: [c45848936ebdb4fcab92f8c39510db83c16d0239]
stable/6.18: [8b44e753795107a22ba31495686e83f4aca48f36]

CVE-2025-71204: smb/server: fix refcount leak in parse_durable_handle_context()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71204

According to the .vulnerable file, this bug was introduced by commit
c8efcc7 in v6.9-rc1.
Fixed in v6.19-rc4.
Affected function was added by c8efcc7 ("ksmbd: add support for
durable handles v1/v2") in v6.9-rc1.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [3296c3012a9d9a27e81e34910384e55a6ff3cff0]
stable/6.12: [8a15107c4c031fb19737bf2eb4000f847f1d5e4c]
stable/6.18: [70dd3513ed6ac8c6cab23f72c5b19f44ca89de9d]
stable/6.6: [07df5ff4f6490a5c96715b7c562e0b2908422e04]

CVE-2025-71220: smb/server: call ksmbd_session_rpc_close() on error
path in create_smb2_pipe()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71220

According to the .vulnerable file, this bug was introduced by commit
e2b76ab in v6.6-rc1.
Fixed in v6.19-rc4.
Calling ksmbd_session_rpc_close in create_smb2_pipe was added by
e2b76ab ("ksmbd: add support for read compound") in v6.6-rc1.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [7c28f8eef5ac5312794d8a52918076dcd787e53b]
stable/5.15: [a2c68e256fb7a4ac34154c6e865a1389acca839f]
stable/6.1: [2b7b4df87fe6f2db6ee45f475de6b37b8b8e5d29]
stable/6.12: [ac18761b530b5dd40f59af8a25902282e5512854]
stable/6.18: [fdda836fcee6fdbcccc24e3679097efb583f581f]
stable/6.6: [04dd114b682a4ccaeba2c2bad049c8b50ce740d8]

CVE-2025-71221: dmaengine: mmp_pdma: Fix race condition in mmp_pdma_residue()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71221

According to the .vulnerable file, this bug was introduced by commit
1b38da2 in v3.16-rc1.
Fixed in v6.19-rc6.
Affected function was added by 1b38da2 ("dma: mmp_pdma: add support
for residue reporting") in v3.16-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a143545855bc2c6e1330f6f57ae375ac44af00a7]
stable/6.18: [9f665b3c3d9a168410251f27a5d019b7bf93185c]

CVE-2025-71222: wifi: wlcore: ensure skb headroom before skb_push

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71222

According to the .vulnerable file, this bug was introduced by commit
f5fc0f8 in v2.6.32-rc1.
Fixed in v6.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e75665dd096819b1184087ba5718bd93beafff51]
stable/5.10: [88295a55fefe5414e64293638b6f7549646e58ed]
stable/5.15: [cd89a4656c03f8db0c57350aaec69cd3cfaa3522]
stable/6.1: [745a0810dbc96a0471e5f5e627ba1e978c3116d4]
stable/6.12: [71de0b6e04bbee5575caf9a1e4d424e7dcc50018]
stable/6.18: [689a7980e4788e13e766763d53569fb78dea2513]
stable/6.6: [b167312390fdd461c81ead516f2b0b44e83a9edb]

CVE-2025-71223: smb/server: fix refcount leak in smb2_open()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71223

According to the .vulnerable file, this bug was introduced by commit
c8efcc7 in v6.9-rc1.
Fixed in v6.19-rc4.
Affected code was added by c8efcc7 ("ksmbd: add support for durable
handles v1/v2") in v6.9-rc1.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [f416c556997aa56ec4384c6b6efd6a0e6ac70aa7]
stable/6.12: [39ca11ff158c98fb092176f06047628c54bcf7a1]
stable/6.18: [4665e52bde3b1f8f442895ce7d88fa62a43e48c4]
stable/6.6: [2456fde2b137703328f1695f60c68fe488d17e36]

CVE-2025-71224: wifi: mac80211: ocb: skip rx_no_sta when interface is not joined

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71224

According to the .vulnerable file, this bug was introduced by commit
239281f in v3.19-rc1.
Fixed in v6.19-rc4.
Affected function was added by 239281f ("mac80211: 802.11p OCB mode
support") in v3.19-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff4071c60018a668249dc6a2df7d16330543540e]
stable/5.10: [fcc768760df08337525cde28e8460e36f9855af8]
stable/5.15: [b04c75366a5471ae2dd7f4c33b7f1e2c08b9b32d]
stable/6.1: [8fd1c63e016893b7f6c1cf799410da4eaa98c090]
stable/6.12: [536447521b3b9be1975c7f1db9054bdf2ab779cb]
stable/6.18: [e0bd226804f8e0098711042c93d64f3b720b36c0]
stable/6.6: [ffe1e19c3b0e5b9eb9e04fad4bce7d1dc407fd77]

CVE-2026-23113: io_uring/io-wq: check IO_WQ_BIT_EXIT inside work run loop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23113

According to the .vulnerable file, this bug was introduced by commit
c60eb04 in v5.12-rc7.
Fixed in v6.19-rc7.
Affected code was added by c60eb04 ("io-wq: cancel unbounded works on
io-wq destroy") in v5.12-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [10dc959398175736e495f71c771f8641e1ca1907]
stable/6.12: [2e8ca1078b14142db2ce51cbd18ff9971560046b]
stable/6.18: [bdf0bf73006ea8af9327cdb85cfdff4c23a5f966]
stable/6.6: [85eb83694a91c89d9abe615d717c0053c3efa714]

CVE-2026-23114: arm64/fpsimd: ptrace: Fix SVE writes on !SME systems

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23114

Introduced by commit 9f8bf71 ("arm64/fpsimd: ptrace: Gracefully handle
errors") in v6.16-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [128a7494a9f15aad60cc6b7e3546bf481ac54a13]
stable/6.18: [4f39984176e7edcaba3432b6c649c6fe93bf2f80]

CVE-2026-23115: serial: Fix not set tty->port race condition

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23115

Introduced by commit bfc467d ("serial: remove redundant
tty_port_link_device()") in v6.15-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [32f37e57583f869140cff445feedeea8a5fea986]
stable/6.18: [2501c49306238b54a2de0f93de43d50ab6e76c84]

CVE-2026-23116: pmdomain: imx8m-blk-ctrl: Remove separate rst and clk
mask for 8mq vpu

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23116

Introduced by commit 608d7c3 ("soc: imx: imx8m-blk-ctrl: add i.MX8MQ
VPU blk-ctrl") in v5.18-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3de49966499634454fd59e0e6fecd50baab7febd]
stable/6.1: [8859e336d233e61a4c40d40dc6a9f21e8b9b719c]
stable/6.12: [5c56a6f4b5a4f87c094c92a30fa17e28e37ec2ab]
stable/6.18: [fd675de6bddf7e9bdf42ae3929d4c27ba6d1ef76]
stable/6.6: [cad7003d951e8899db58ee2fef211586af726f09]

CVE-2026-23117: ice: add missing ice_deinit_hw() in devlink reinit path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23117

Introduced by commit 1390b8b ("ice: remove duplicate call to
ice_deinit_hw() on error paths") in v6.19-rc1.
Fixed in v6.19-rc7.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [42fb5f3deb582cb96440e4683745017dbabb83d6]
stable/6.18: [a3d99e2fbf01446d31a0d0dfc46444e915a1f6d4]

CVE-2026-23118: rxrpc: Fix data-race warning and potential load/store tearing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23118

Introduced by commit ace45be ("rxrpc: Fix firewall route keepalive")
in v4.17-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d5fe8bcd331f1e34e0943ec7c18432edfcf0e8b]
stable/6.12: [c08cf314191cd0f8699089715efb9eff030f0086]
stable/6.18: [f8cf1368e0a5491b27189a695c36f64e48f3d19d]

CVE-2026-23119: bonding: provide a net pointer to __skb_flow_dissect()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23119

Introduced by commit 58deb77 ("bonding: balance ICMP echoes in
layer3+4 mode") in v5.5-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5f9b329096596b7e53e07d041d7fca4cbe1be752]
stable/5.10: [8e53780732ee881394406f79da5263b81eb48f7e]
stable/5.15: [3be945abdd228fd00f6afcf8d137002867a4651b]
stable/6.1: [f4faaa1297ecf3255a8591fff2633df05bd5ec84]
stable/6.12: [bc3c8d2493c6f4d2038844dc8b7ee93de050f7fa]
stable/6.18: [de97735a40a144974bf3896ee4cc0270db2e47db]
stable/6.6: [0efee0b992f28bd5ee01c7a86ef6a307c42eb907]

CVE-2026-23120: l2tp: avoid one data-race in l2tp_tunnel_del_work()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23120

Introduced by commit d00fa9a ("l2tp: fix races with tunnel socket
close") in v4.16-rc5.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7a29f6bf60f2590fe5e9c4decb451e19afad2bcf]
stable/5.10: [1f63ca44b4f419a1663d94d1bb0b4e2beb73fdb4]
stable/5.15: [36c40a80109f1771d59558050b1a71e13c60c759]
stable/6.1: [eae074dab764ea181bbed5e88626889319177498]
stable/6.12: [3d6d414b214ce31659bded2f8df50c93a3769474]
stable/6.18: [32d417497b79efb403d75f4c185fe6fd9d64b94f]
stable/6.6: [68e92085427c84e7679ddb53c0d68836d220b6e7]

CVE-2026-23121: mISDN: annotate data-race around dev->work

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23121

Introduced by commit 1b2b03f ("Add mISDN core files") in v2.6.27-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8175dbf174d487afab81e936a862a8d9b8a1ccb6]
stable/5.10: [d5d99cb9e0839093cd53aa3b28176fce2f820ca0]
stable/5.15: [13f3b3b87068898056db4c79ee67052fbde11d43]
stable/6.1: [accc3f8266d2a49881dbcf78c459477f4efa0ff3]
stable/6.12: [aa6e33cd74ca4965f2bbcb025e0b672fb0168a69]
stable/6.18: [7ac345a93af31358e18e9606eb7b354691bf6757]
stable/6.6: [fc8ba17fd3337bd8b1913c30b95df0fee00d8fb7]

CVE-2026-23122: igc: Reduce TSN TX packet buffer from 7KB to 5KB per queue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23122

Introduced by commit 0d58cdc ("igc: optimize TX packet buffer
utilization for TSN mode") in v6.16-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ad1b6c1e63d25f5465b7a8aa403bdcee84b86f9]
stable/6.18: [88037973c8ef6032bf84e9955595f8b20bc14c21]

CVE-2026-23123: interconnect: debugfs: initialize src_node and
dst_node to empty strings

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23123

Introduced by commit 770c69f ("interconnect: Add debugfs test client")
in v6.6-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8cc27f5c6dd17dd090f3a696683f04336c162ff5]
stable/6.12: [935d0938b570589c8b0a1733d2cba3c39d027f25]
stable/6.18: [5d7c7e1fb3ec24fdd0f9faa27b666d6789e891e8]
stable/6.6: [aa79a5a959c7c414bd6fba01ea8dbaddd44f13e7]

CVE-2026-23124: ipv6: annotate data-race in ndisc_router_discovery()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23124

Introduced by commit 49b99da ("ipv6: add IFLA_INET6_RA_MTU to expose
mtu value") in v5.15-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9a063f96d87efc3a6cc667f8de096a3d38d74bb5]
stable/5.15: [4630897eb1a039b5d7b737b8dc9521d9d4b568b5]
stable/6.1: [2619499169fb1c2ac4974b0f2d87767fb543582b]
stable/6.12: [2a2b9d25f801afecf2f83cacce98afa8fd73e3c9]
stable/6.18: [e3c1040252e598f7b4e33a42dc7c38519bc22428]
stable/6.6: [fad8f4ff7928f4d52a062ffdcffa484989c79c47]

CVE-2026-23125: sctp: move SCTP_CMD_ASSOC_SHKEY right after SCTP_CMD_PEER_INIT

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23125

Introduced by commit 730fc3d ("[SCTP]: Implete SCTP-AUTH parameter
processing") in v2.6.24-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a80c9d945aef55b23b54838334345f20251dad83]
stable/5.10: [5a309bedf02ee08b0653215f06c94d61ec7a214a]
stable/5.15: [784428ab1889eb185a1459e9d6bc52df33d572ef]
stable/6.1: [e94294798548e8cfbd80869e1d2f97efce92582c]
stable/6.12: [bf2b543b3cc4ebb4ab5bca4f8dfa5612035d45b8]
stable/6.18: [0c4adb1f391a7b92a0405e9d7c05624c0d9f8a65]
stable/6.6: [e7e81abbcc5620c9532080538f9709a6ea382855]

CVE-2026-23126: netdevsim: fix a race issue related to the operation
on bpf_bound_progs list

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23126

Introduced by commit 31d3ad8 ("netdevsim: add bpf offload support") in
v4.16-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b97d5eedf4976cc94321243be83b39efe81a0e15]
stable/6.1: [3f560cfc7706029294132482fff5d1bc7884b70d]
stable/6.12: [d77379ca82efcb2fe563359cc795027d680410db]
stable/6.18: [68462ecc40ea8f780fb3c74ebfddd05506bb731b]
stable/6.6: [f1f9cfd2f46a73b7de2982d01be822eac3a0efaa]

CVE-2026-23127: perf: Fix refcount warning on event->mmap_count increment

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23127

Introduced by commit 448f97f ("perf: Convert mmap() refcounts to
refcount_t") in v6.18-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d06bf78e55d5159c1b00072e606ab924ffbbad35]
stable/6.18: [23c0e4bd93d0b250775162faf456470485ac9fc7]

CVE-2026-23128: arm64: Set __nocfi on swsusp_arch_resume()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23128

According to the .vulnerable file, this bug was introduced by commit
8924560 in v6.1-rc1.
Fixed in v6.19-rc7.
Affected function was added by 82869ac ("arm64: kernel: Add support
for hibernate/suspend-to-disk") in v4.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e2f8216ca2d8e61a23cb6ec355616339667e0ba6]
stable/5.15: [361df59ad01303008b9e091a1a6ed9bc95b1455a]
stable/6.1: [122b7cb80f7d468fcc2d18cf7eb320f09f310a96]
stable/6.12: [9773a886f26766a8db92d4b342b620a82c2de7dd]
stable/6.18: [6e32070d29d1a35d8f4b3c03babf6c0e5efd1d08]
stable/6.6: [8557bdd9af8dd04911fba56ff92b17842b0b5c7f]

CVE-2026-23129: dpll: Prevent duplicate registrations

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23129

Introduced by commit 9431063 ("dpll: core: Add DPLL framework base
functions") in v6.7-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f3ddbaaaaf4d0633b40482f471753f9c71294a4a]
stable/6.12: [dfec0501dba8f4711ef142a6a890e4812b7af88c]
stable/6.18: [236a657422a564859dcd0db7bdb486abb21a721a]

CVE-2026-23130: wifi: ath12k: fix dead lock while flushing management frames

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23130

Introduced by commit 56dcbf0 ("wifi: ath12k: convert struct
ath12k::wmi_mgmt_tx_work to struct wiphy_work") # [1] in v6.14-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f88e9fc30a261d63946ddc6cc6a33405e6aa27c3]
stable/6.18: [06ac2aa13f701a0296e92f5f54ae24224d426b28]

CVE-2026-23131: platform/x86: hp-bioscfg: Fix kobject warnings for
empty attribute names

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23131

Introduced by commit a34fc32 ("platform/x86: hp-bioscfg: bioscfg") in v6.6-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fdee1b09721605f532352628d0a24623e7062efb]
stable/6.12: [6476be59b7162b891b7bddbd0c2924d87379ef6c]
stable/6.18: [800b2767905d6b409b8bbe357121970f0b489a89]
stable/6.6: [29917c80aa96a25cbcf5876fd774a1cfd72b01a9]

CVE-2026-23132: drm/bridge: synopsys: dw-dp: fix error paths of dw_dp_bind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23132

Introduced by commit 86eecc3 ("drm/bridge: synopsys: Add DW DPTX
Controller support library") in v6.18-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1a0f69e3c28477b97d3609569b7e8feb4b6162e8]
stable/6.18: [569ed6a73e927a34cae4ae6de1464c0737a5ec44]

CVE-2026-23133: wifi: ath10k: fix dma_free_coherent() pointer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23133

Introduced by commit 2a1e1ad ("ath10k: Add support for 64 bit ce
descriptor") in v4.16-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9282a1e171ad8d2205067e8ec3bbe4e3cef4f29f]
stable/5.10: [e2dda298ef809aa201ea7c0904c4d064f6c497cb]
stable/5.15: [fc8da65f9fe1bc6802f8240b342cfff4f5c7e841]
stable/6.1: [b0ad924332a96550a84b8c0ae5483e7042d65fa9]
stable/6.12: [5d6fa4d2c9799c09389588da5118a72d97d87e92]
stable/6.18: [07f363f305793baecad41816f73056252f3df61e]
stable/6.6: [1928851334ecfd6e0d663121ab69ac639d4217a6]

CVE-2026-23134: slab: fix kmalloc_nolock() context check for PREEMPT_RT

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23134

Introduced by commit af92793 ("slab: Introduce kmalloc_nolock() and
kfree_nolock().") in v6.18-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [99a3e3a1cfc93b8fe318c0a3a5cfb01f1d4ad53c]
stable/6.18: [f60ba4a97ae3f94e4818722ed2e4d260bbb17b44]

CVE-2026-23135: wifi: ath12k: fix dma_free_coherent() pointer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23135

Introduced by commit d889913 ("wifi: ath12k: driver for Qualcomm Wi-Fi
7 devices") in v6.3-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bb97131fbf9b708dd9616ac2bdc793ad102b5c48]
stable/6.12: [24585a13c41ea7253ee59aac74441fb570f5824a]
stable/6.18: [4846b32be324f4dd3653f38a3f69c049543d52ae]
stable/6.6: [36e0bc5e8b282564906fca636c4ebc99814de4e7]

CVE-2026-23136: libceph: reset sparse-read state in osd_fault()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23136

Introduced by commit f628d79 ("libceph: add sparse read support to OSD
client") in v6.6-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [11194b416ef95012c2cfe5f546d71af07b639e93]
stable/6.12: [e94075e950a6598e710b9f7dffea5aa388f40313]
stable/6.18: [10b7c72810364226f7b27916ea3e2a4f870bc04b]
stable/6.6: [90a60fe61908afa0eaf7f8fcf1421b9b50e5f7ff]

CVE-2026-23137: of: unittest: Fix memory leak in unittest_data_add()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23137

Introduced by commit 2eb46da ("of/selftest: Use the resolver to fixup
phandles") in v3.18-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [235a1eb8d2dcc49a6cf0a5ee1aa85544a5d0054b]
stable/6.18: [f09b0f705bd7197863b90256ef533a6414d1db2c]

CVE-2026-23138: tracing: Add recursion protection in kernel stack
trace recording

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23138

Introduced by commit 5f5fa7e ("rcu: Don't use negative nesting depth
in __rcu_read_unlock()") in v5.8-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5f1ef0dfcb5b7f4a91a9b0e0ba533efd9f7e2cdb]
stable/6.18: [5b7f91acffd2c4c000971553d22efa1e1bb4feae]

CVE-2026-23139: netfilter: nf_conncount: update last_gc only when GC
has been performed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23139

Introduced by commit d265929 ("netfilter: nf_conncount: reduce
unnecessary GC") in v5.19-rc1.
Fixed in v6.19-rc5.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 stable/5.10 stable/5.15

Fixed status
cip/4.19-st: [3fc927822ac6d9f11ce0cabe4f7b193bbff15262]
mainline: [7811ba452402d58628e68faedf38745b3d485e3c]
stable/5.10: [2c7c71113ed6d3e2f3aca4c088f22283016ff34f]
stable/5.15: [c4cde57c8affdcca5bcff53a1047e15d268bdca1]
stable/6.1: [9f45588993d7f115280fc726119ca86fba32a811]
stable/6.12: [26a82dce2beee39c43c109d9647e16f49cb02a35]
stable/6.18: [8bdafdf4900040a81422056cabe5e00a37bd101a]
stable/6.6: [3cd717359e56f82f06cbf8279b47a7d79880c6f3]

CVE-2026-23140: bpf, test_run: Subtract size of xdp_frame from allowed
metadata size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23140

Introduced by commit b6f1f78 ("bpf, test_run: Fix packet size check
for live packet mode") in v5.18-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e558cca217790286e799a8baacd1610bda31b261]
stable/6.1: [e7440935063949d6f2c10f7328d960d0ff4bce90]
stable/6.12: [6447e697cfa8a43a8e491cb81bcc390d0f28f8ba]
stable/6.18: [31e37f44b60679d90b9f999c91371b15291be8e0]
stable/6.6: [7c81ad5e580bd8441f8a521a8d34824ce6582ae5]

CVE-2026-23141: btrfs: send: check for inline extents in
range_is_hole_in_parent()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23141

Introduced by commit 82bfb2e ("Btrfs: incremental send, fix
unnecessary hole writes for sparse files") in v4.11-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [08b096c1372cd69627f4f559fb47c9fb67a52b39]
stable/6.12: [db00636643e66898d79f2530ac9c56ebd5eca369]
stable/6.18: [39f83f10772310ba4a77f2b5256aaf36994ef7e8]
stable/6.6: [f2dc6ab3a14c2d2eb0b14783427eb9b03bf631c9]

CVE-2026-23142: mm/damon/sysfs-scheme: cleanup access_pattern subdirs
on scheme dir setup failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23142

Introduced by commit 9bbb820 ("mm/damon/sysfs: support DAMOS quotas")
in v5.18-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [392b3d9d595f34877dd745b470c711e8ebcd225c]
stable/6.1: [ae8ac0066b48ed957bdcab58f0d3543549c57a29]
stable/6.12: [16236b0b4a08fa3e326cf1373ef789dabdc2e30d]
stable/6.18: [725d4fdaa01bd1161782081f419e1568cc7432e0]
stable/6.6: [e9711bd0e64812c694a228cf58c9e6032decee54]

CVE-2026-23143: virtio_net: Fix misalignment bug in struct virtnet_info

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23143

Introduced by commit ed3100e ("virtio_net: Use new RSS config
structs") in v6.15-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4156c3745f06bc197094b9ee97a9584e69ed00bf]
stable/6.18: [ae48108c2310f1dd700e0dbb655c2f1d92ed00fc]

CVE-2026-23144: mm/damon/sysfs: cleanup attrs subdirs on context dir
setup failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23144

Introduced by commit c951cd3 ("mm/damon: implement a minimal stub for
sysfs-based DAMON interface") in v5.18-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9814cc832b88bd040fc2a1817c2b5469d0f7e862]
stable/6.1: [db7dfe78fc81bdd2b532d77f340fe453f2360426]
stable/6.12: [5651c0c391c0029541794f9c4c9597faecfd401f]
stable/6.18: [78b4eb99751ebd37ceade78810bf94de80f7fb3a]
stable/6.6: [43964644348f6b1add3055c4a6cae8f77d892a6e]

CVE-2026-23145: ext4: fix iloc.bh leak in ext4_xattr_inode_update_ref

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23145

Introduced by commit 57295e8 ("ext4: guard against EA inode refcount
underflow in xattr update") in v6.18-rc1.
Fixed in v6.19-rc6.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12
stable/6.6

Fixed status
mainline: [d250bdf531d9cd4096fedbb9f172bb2ca660c868]
stable/5.10: [7c9f059c3d531a12d7ad96cd34a44b8af7c00d5f]
stable/5.15: [6241cd1d0acc2363016ac55b8773ba1332dd59d7]
stable/6.1: [3b00c16e42428a1ecd3a5eb9cc37f8ad9bd47626]
stable/6.12: [8e8542c539927ae3898a4d02941f84e252e2dea1]
stable/6.18: [06e26287f2e349a28ad363941ffd9076bfed8b2e]
stable/6.6: [0b06cde92f2f960f4ebe3c988c69f2711f2a24dc]

CVE-2026-23146: Bluetooth: hci_uart: fix null-ptr-deref in hci_uart_write_work

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23146

Introduced by commit 5df5daf ("Bluetooth: hci_uart: Fix another race
during initialization") in v6.15-rc1.
Fixed in v6.19-rc8.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12
stable/6.6

Fixed status
mainline: [0c3cd7a0b862c37acbee6d9502107146cc944398]
stable/5.10: [b0a900939e7e4866d9b90e9112514b72c451e873]
stable/5.15: [ccc683f597ceb28deb966427ae948e5ac739a909]
stable/6.1: [937a573423ce5a96fdb1fd425dc6b8d8d4ab5779]
stable/6.12: [53e54cb31e667fca05b1808b990eac0807d1dab0]
stable/6.18: [03e8c90c62233382042b7bd0fa8b8900552fdb62]
stable/6.6: [186d147cf7689ba1f9b3ddb753ab634a84940cc9]

CVE-2026-23147: btrfs: zlib: fix the folio leak on S390 hardware acceleration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23147

Introduced by commit aa60fe1 ("btrfs: zlib: refactor S390x HW
acceleration buffer preparation") in v6.15-rc1.
Fixed in v6.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0d0f1314e8f86f5205f71f9e31e272a1d008e40b]
stable/6.18: [e80617a5e1c246da2f112a1a072cdd535046adfe]

CVE-2026-23148: nvmet: fix race in nvmet_bio_done() leading to NULL
pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23148

Introduced by commit 190f4c2 ("nvmet: fix memory leak of bio
integrity") in v6.16-rc5.
Fixed in v6.19-rc8.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [0fcee2cfc4b2e16e62ff8e0cc2cd8dd24efad65e]
stable/6.12: [ee10b06980acca1d46e0fa36d6fb4a9578eab6e4]
stable/6.18: [68207ceefd71cc74ce4e983fa9bd10c3122e349b]

CVE-2026-23149: drm: Do not allow userspace to trigger kernel warnings
in drm_gem_change_handle_ioctl()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23149

Introduced by commit 5309672 ("drm: Add DRM prime interface to
reassign GEM handle") in v6.18-rc1.
Fixed in v6.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12f15d52d38ac53f7c70ea3d4b3d76afed04e064]
stable/6.18: [ae8831ee0fb2f5f41f39722e7b3749d65bb78d08]

CVE-2026-23150: nfc: llcp: Fix memleak in nfc_llcp_send_ui_frame().

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23150

Introduced by commit 94f418a ("NFC: UI frame sending routine
implementation") in v3.8-rc1.
Fixed in v6.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [165c34fb6068ff153e3fc99a932a80a9d5755709]
stable/5.10: [ab660cb8e17aa93426d1e821c2cce60e4b9bc56a]
stable/5.15: [65e976e1f474ae3bf5681d7abafb8f3fdb34b8cc]
stable/6.1: [6734ff1ac6beba1d0c22dc9a3dc1849b773b511f]
stable/6.12: [3098e5c8af0f4c8f7eebbb370798df8aa2e12ba5]
stable/6.18: [61858cbce6ca4bef9ed116c689a4be9520841339]
stable/6.6: [f8d002626d434f5fea9085e2557711c16a15cec6]

CVE-2026-23151: Bluetooth: MGMT: Fix memory leak in set_ssp_complete

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23151

Introduced by commit 302a1f6 ("Bluetooth: MGMT: Fix possible UAFs") in v6.17.
Fixed in v6.19-rc8.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [1b9c17fd0a7fdcbe69ec5d6fe8e50bc5ed7f01f2]
stable/6.12: [1850a558d116d7e3e2ef36d06a56f59b640cc214]
stable/6.18: [3b6318505378828ee415d6ef678db6a74c077504]

CVE-2026-23152: wifi: mac80211: correctly decode TTLM with default link map

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23152

Introduced by commit 702e804 ("wifi: mac80211: support handling of
advertised TID-to-link mapping") in v6.7-rc1.
Fixed in v6.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1eab33aa63c993685dd341e03bd5b267dd7403fa]
stable/6.18: [aabc36857bd39da65fe2d047bfaf63a0a09917d4]

CVE-2026-23153: firewire: core: fix race condition against transaction list

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23153

Introduced by commit b5725cf ("firewire: core: use spin lock specific
to timer for split transaction") in v6.18-rc1.
Fixed in v6.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [20e01bba2ae4898ce65cdcacd1bd6bec5111abd9]
stable/6.18: [b038874e31fc3caa0b0d5abd259dd54b918ad4a1]

CVE-2026-23154: net: fix segmentation of forwarding fraglist GRO

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23154

Introduced by commit 9fd1ff5 ("udp: Support UDP fraglist GRO/GSO.") in v5.6-rc1.
Fixed in v6.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [426ca15c7f6cb6562a081341ca88893a50c59fa2]
stable/6.12: [3e62db1e3140449608975e29e0979cc5f3b1cc07]
stable/6.18: [3d48d59235c494d34e32052f768393111c0806ef]

CVE-2026-23155: can: gs_usb: gs_usb_receive_bulk_callback(): fix error message

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23155

Introduced by commit 79a6d1b ("can: gs_usb:
gs_usb_receive_bulk_callback(): unanchor URL on usb_submit_urb()
error") in v6.19-rc7.
Fixed in v6.19-rc8.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.12 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [494fc029f662c331e06b7c2031deff3c64200eed]
stable/6.1: [aed58a28ea71a0d7d0947190fab1e3f4daa1d4a5]
stable/6.12: [8986cdf52f86208df9c7887fee23365b5d37da26]
stable/6.18: [713ba826ae114ab339c9a1b31e209bebdadb0ac9]
stable/6.6: [923379f1d7e3af8ccbf11edbbcf41f1bb3e9cfe6]

CVE-2026-23156: efivarfs: fix error propagation in efivar_entry_get()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23156

Introduced by commit 2d82e62 ("efi: vars: Move efivar caching layer
into efivarfs") in v6.0-rc1.
Fixed in v6.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b22ec1685ce1fc0d862dcda3225d852fb107995]
stable/6.1: [3960f1754664661a970dc9ebbab44ff93a0b4c42]
stable/6.12: [89b8ca709eeeabcc11ebba64806677873a2787a8]
stable/6.18: [e4e15a0a4403c96d9898d8398f0640421df9cb16]
stable/6.6: [510a16f1c5c1690b33504052bc13fbc2772c23f8]

CVE-2026-23157: btrfs: do not strictly require dirty metadata
threshold for metadata writepages

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23157

According to the .vulnerable file, this bug was introduced by commit
793955b in v2.6.29-rc1.
Fixed in v6.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e159150a9a56d66d247f4b5510bed46fe58aa1c]
stable/6.18: [629666d20c7dcd740e193ec0631fdff035b1f7d6]

CVE-2026-23158: gpio: virtuser: fix UAF in configfs release path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23158

Introduced by commit 91581c4 ("gpio: virtuser: new virtual testing
driver for the GPIO API") in v6.11-rc1.
Fixed in v6.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [53ad4a948a4586359b841d607c08fb16c5503230]
stable/6.12: [815a8e3bf72811d402b30bd4a53cde5e9df7a563]
stable/6.18: [7bec90f605cfb138006f5ba575f2310593347110]

CVE-2026-23159: perf: sched: Fix perf crash with new is_user_task() helper

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23159

Introduced by commit 90942f9 ("perf: Use current->flags &
PF_KTHREAD|PF_USER_WORKER instead of current->mm == NULL") in
v6.18-rc1.
Fixed in v6.19-rc8.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [76ed27608f7dd235b727ebbb12163438c2fbb617]
stable/6.12: [5aac392fcd3d981d7997f1a0766829e1afdeac2e]
stable/6.18: [a28fce0365e1cb9cb8c04c893b9334e5ca9d9f1c]
stable/6.6: [d84a4836dc246b7dc244e46a08ff992956b68db0]

CVE-2026-23160: octeon_ep: Fix memory leak in octep_device_setup()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23160

Introduced by commit 577f0d1 ("octeon_ep: add separate mailbox command
and response queues") in v6.4-rc1.
Fixed in v6.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8016dc5ee19a77678c264f8ba368b1e873fa705b]
stable/6.12: [fdfd28e13c244d7c3345e74f339fd1b67605b694]
stable/6.18: [d753f3c3f9d7a6e6dbb4d3a97b73007d71624551]
stable/6.6: [5058d3f8f17202e673f90af1446252322bd0850f]

CVE-2026-23161: mm/shmem, swap: fix race of truncate and swap entry split

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23161

Introduced by commit 809bc86 ("mm: shmem: support large folio swap
out") in v6.12-rc1.
Fixed in v6.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a1968bd997f45a9b11aefeabdd1232e1b6c7184]
stable/6.12: [a99f9a4669a04662c8f9efe0e62cafc598153139]
stable/6.18: [b23bee8cdb7aabce5701a7f57414db5a354ae8ed]

CVE-2026-23162: drm/xe/nvm: Fix double-free on aux add failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23162

Introduced by commit 7926ba2 ("drm/xe: defer free of NVM auxiliary
container to device release callback") in v6.17-rc7.
Fixed in v6.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a44241b0b83a6047c5448da1fff03fcc29496b5]
stable/6.18: [32887d8e4bc0696b3cb6c5915a42b39cfd3434f4]

CVE-2026-23163: drm/amdgpu: fix NULL pointer dereference in
amdgpu_gmc_filter_faults_remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23163

Introduced by commit dd29944 ("drm/amdgpu: Rework retry fault
removal") in v6.4-rc1.
Fixed in v6.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b1ecc9377bc641533cd9e76dfa3aee3cd04a007]
stable/6.12: [7611d7faccc1218be477671f892a89b25c0cb352]
stable/6.18: [ac251d17d8af58ddc3daba65eaf0a99e63dc4284]
stable/6.6: [c74e2dbb5316898fb2113a8ea3a93b27698dbf68]

CVE-2026-23164: rocker: fix memory leak in rocker_world_port_post_fini()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23164

Introduced by commit e420114 ("rocker: introduce worlds
infrastructure") in v4.6-rc1.
Fixed in v6.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8d7ba71e46216b8657a82ca2ec118bc93812a4d0]
stable/5.10: [2a3a64d75d2d0727da285749476761ebcad557a3]
stable/5.15: [b11e6f926480ab0939fec44781f28558c54be4e7]
stable/6.1: [8ce2e85889939c02740b4245301aa5c35fc94887]
stable/6.12: [d8723917efda3b4f4c3de78d1ec1e1af015c0be1]
stable/6.18: [dce375f4afc348c310d171abcde7ec1499a4c26a]
stable/6.6: [d448bf96889f1905e740c554780f5c9fa0440566]

CVE-2026-23165: sfc: fix deadlock in RSS config read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23165

Introduced by commit 040cef3 ("net: ethtool: move get_rxfh callback
under the rss_lock") in v6.17-rc1.
Fixed in v6.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [944c614b0a7afa5b87612c3fb557b95a50ad654c]
stable/6.18: [590c8179ffb01c17644181408821b55b8704c50c]

CVE-2026-23166: ice: Fix NULL pointer dereference in ice_vsi_set_napi_queues

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23166

Introduced by commit 2a5dc09 ("ice: move netif_queue_set_napi to
rtnl-protected sections") in v6.11-rc7.
Fixed in v6.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9bb30be4d89ff9a8d7ab1aa0eb2edaca83431f85]
stable/6.12: [d75c7b7c3c2b8e3569043099e6bdcefc983856c5]
stable/6.18: [36126ddbe924727add05a594dedf230d3b575e4d]

CVE-2026-23167: nfc: nci: Fix race between rfkill and nci_unregister_device().

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23167

Introduced by commit 6a2968a ("NFC: basic NCI protocol
implementation") in v3.2-rc1.
Fixed in v6.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2492688bb9fed6ab6e313682c387ae71a66ebae]
stable/5.10: [cd4412d5905ee580e96c48360dc98fcd9e6f3208]
stable/5.15: [eaa5da5130deda26420273d4610cf6e4f794ed75]
stable/6.1: [8ea4d96419fb20f15a52ce657d49f1e7c91eb7ac]
stable/6.12: [126cd30cad37bc7c2c85fe2df2a522d4edf0a5c5]
stable/6.18: [c3369fc5e6120a72169e71acd72e987907a682af]
stable/6.6: [546eba0b10989de9ccc7fd619e874a30561e2b88]

CVE-2026-23168: flex_proportions: make fprop_new_period() hardirq safe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23168

Introduced by commit a91befd ("lib/flex_proportions.c: remove
local_irq_ops in fprop_new_period()") in v6.0-rc1.
Fixed in v6.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd9e2f5b38f1fdd49b1ab6d3a85f81c14369eacc]
stable/6.1: [0acc9ba7a1b5ba4d998c5753e709be904e179b75]
stable/6.12: [78ede9ebd679dadf480dce6f7b798e3603f88348]
stable/6.18: [b91a84299d72ae0e05551e851e47cd3008bd025b]
stable/6.6: [884b2590ffcc7222cbbd6298051f4c243cc36f5d]

CVE-2026-23169: mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23169

Introduced by commit 141694d ("mptcp: remove address when netlink
flushes addrs") in v5.11-rc1.
Fixed in v6.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e2a9eeb69f7d4ca4cf4c70463af77664fdb6ab1d]
stable/6.12: [51223bdd0f60b06cfc7f25885c4d4be917adba94]
stable/6.18: [1f1b9523527df02685dde603f20ff6e603d8e4a1]
stable/6.6: [455e882192c9833f176f3fbbbb2f036b6c5bf555]

CVE-2026-23170: drm/imx/tve: fix probe device leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23170

Introduced by commit fcbc51e ("staging: drm/imx: Add support for
Television Encoder (TVEv2)") in v3.10-rc1.
Fixed in v6.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e535c23513c63f02f67e3e09e0787907029efeaf]
stable/5.10: [f212652982c6725986cfa42fbf10d1dfa92c010e]
stable/5.15: [52755c5680ce333b33d0750a200fbc99420ed2b2]
stable/6.1: [4aaff8f6ab38f81e00ab8aa1fcfb7eb20cd87ba1]
stable/6.12: [77365382585b40559d63538d09e26e4b2af28fbc]
stable/6.18: [ca68745e820ecd210e3ab018497c9e6b69025c4b]
stable/6.6: [9a15d3fdc22d48f597792aee0cf1bf0947fc62e6]

CVE-2026-23171: bonding: fix use-after-free due to enslave fail after
slave array update

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23171

Introduced by commit 9e2ee5c ("net, bonding: Add XDP support to the
bonding driver") in v5.15-rc1.
Fixed in v6.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e9acda52fd2ee0cdca332f996da7a95c5fd25294]
stable/6.18: [bd25b092a06a3e05f7e8bd6da6fa7318777d8c3d]

CVE-2026-23172: net: wwan: t7xx: fix potential skb->frags overflow in RX path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23172

Introduced by commit d642b01 ("net: wwan: t7xx: Add data path
interface") in v5.19-rc1.
Fixed in v6.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0813bcd2d9d97fdbdf2efb9532ab03ae92e99e6]
stable/6.1: [f9747a7521a48afded5bff2faf1f2dcfff48c577]
stable/6.12: [af4b8577d0b388cc3d0039eb0cdd9ca5bbbc9276]
stable/6.18: [2c0fb0f60bc1545c52da61bc6bd4855c1e7814ba]
stable/6.6: [2a0522f564acd34442652ea083091c329fa7c5d5]

CVE-2026-23173: net/mlx5e: TC, delete flows only for existing peers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23173

Introduced by commit 9be6c21 ("net/mlx5e: Handle offloads flows per
peer") in v6.5-rc1.
Fixed in v6.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f67666938ae626cbda63fbf5176b3583c07e7124]
stable/6.12: [2652e2f1253c53f9a3ce84cc972568b32c892734]
stable/6.18: [fdf8437016f578f18b160c6e14f13ab96bfbc3ba]
stable/6.6: [62e1d8920f6920543f4b095a65fb964448c9901d]

CVE-2026-23174: nvme-pci: handle changing device dma map requirements

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23174

Introduced by commit b8b7570 ("nvme-pci: fix dma unmapping when using
PRPs and not using the IOVA mapping") in v6.17-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [071be3b0b6575d45be9df9c5b612f5882bfc5e88]
stable/6.18: [f3ed399e9aa6f36e92d2d0fe88b387915e9705fe]

CVE-2026-23175: net: cpsw: Execute ndo_set_rx_mode callback in a work queue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23175

Introduced by commit 1767bb2 ("ipv6: mcast: Don't hold RTNL for
IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.") in v6.17-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0b8c878d117319f2be34c8391a77e0f4d5c94d79]
stable/6.18: [488009aa62bb1217ea0624fd5108b79adef4e148]

CVE-2026-23176: platform/x86: toshiba_haps: Fix memory leaks in
add/remove routines

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23176

Introduced by commit 23d0ba0 ("platform/x86: Toshiba HDD Active
Protection Sensor") in v3.17-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [128497456756e1b952bd5a912cd073836465109d]
stable/5.10: [17f37c4cdf42a9e4915216b9e130fc8baef4cc64]
stable/5.15: [5bce10f0f9435afaae3fc4df9a52b01d9b3853dc]
stable/6.1: [f2093e87ddec13e7a920f326c078a5f765ba89c3]
stable/6.12: [bf0474356875d005d420f8c6b9ac168566e72e87]
stable/6.18: [f93ae43780b759a70734be9bc82c1adcf7f33208]
stable/6.6: [ca9ff71c15bc8e48529c2033294a519a7749b272]

CVE-2026-23177: mm, shmem: prevent infinite loop on truncate race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23177

Introduced by commit 809bc86 ("mm: shmem: support large folio swap
out") in v6.12-rc1.
Introduced by commit 8a1968b ("mm/shmem, swap: fix race of truncate
and swap entry split") in v6.19-rc8.
Fixed in v6.19.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18

Fixed status
mainline: [2030dddf95451b4e7a389f052091e7c4b7b274c6]
stable/6.12: [dfc3ab6bd64860f8022d69903be299d09be86e11]
stable/6.18: [7b6a0f121d50234aab3e7ab9a62ebe826d40a32a]

CVE-2026-23178: HID: i2c-hid: fix potential buffer overflow in
i2c_hid_get_report()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23178

According to the .vulnerable file, this bug was introduced by commit
85df713 in v5.18-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2497ff38c530b1af0df5130ca9f5ab22c5e92f29]
stable/6.1: [f9c9ad89d845f88a1509e9d672f65d234425fde9]
stable/6.12: [786ec171788bdf9dda38789163f1b1fbb47f2d1e]
stable/6.18: [2124279f1f8c32c1646ce98e75a1a39b23b7db76]
stable/6.6: [cff3f619fd1cb40cdd89971df9001f075613d219]

CVE-2026-23179: nvmet-tcp: fixup hang in nvmet_tcp_listen_data_ready()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23179

According to the .vulnerable file, this bug was introduced by commit
675b453 in v6.7-rc1.
Fixed in v6.19-rc6.
Affected function was added by 872d26a ("nvmet-tcp: add NVMe over TCP
target driver") in 5.0-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2fa8961d3a6a1c2395d8d560ffed2c782681bade]
stable/6.12: [6e0c7503a5803d568d56a9f9bca662cd94a14908]
stable/6.18: [1c90f930e7b410dd2d75a2a19a85e19c64e98ad5]
stable/6.6: [f532b29b0e313f42b964014038b0f52899b240ec]

CVE-2026-23180: dpaa2-switch: add bounds check for if_id in IRQ handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23180

Introduced by commit 24ab724 ("dpaa2-switch: use the port index in the
IRQ handler") in v5.15-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [31a7a0bbeb006bac2d9c81a2874825025214b6d8]
stable/5.15: [77611cab5bdfff7a070ae574bbfba20a1de99d1b]
stable/6.1: [34b56c16efd61325d80bf1d780d0e176be662f59]
stable/6.12: [2447edc367800ba914acf7ddd5d250416b45fb31]
stable/6.18: [1b381a638e1851d8cfdfe08ed9cdbec5295b18c9]
stable/6.6: [f89e33c9c37f0001b730e23b3b05ab7b1ecface2]

CVE-2026-23181: btrfs: sync read disk super and set block size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23181

According to the .vulnerable file, this bug was introduced by commit
3c20917 in v6.15-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f29d661e5686f3aa14e6f11537ff5c49846f2e2]
stable/6.18: [ccb3c75d57039adb3170ae54a0d470e359705984]

CVE-2026-23182: spi: tegra: Fix a memory leak in tegra_slink_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23182

Introduced by commit eb9913b ("spi: tegra: Fix missing IRQ check in
tegra_slink_probe()") in v6.7-rc1.
Fixed in v6.19.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [41d9a6795b95d6ea28439ac1e9ce8c95bbca20fc]
stable/5.15: [6a04dc650cef8d52a1ccb4ae245dbe318ffff32e]
stable/6.1: [327b71326cc1834bc031e8f52a470a18dfd9caa6]
stable/6.12: [075415ae18b5b3e4d0187962d538653154216fe7]
stable/6.18: [b8eec12aa666c11f8a6ad1488c568f85c58875fa]
stable/6.6: [126a09f4fcd2b895a818ca43fde078d907c1ac9a]

CVE-2026-23183: cgroup/dmem: fix NULL pointer dereference when setting max

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23183

Introduced by commit b168ed4 ("kernel/cgroup: Add "dmem" memory
accounting cgroup") in v6.14-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [43151f812886be1855d2cba059f9c93e4729460b]
stable/6.18: [c13816e8fa23deec6a8d7465d9e637fd02683b5c]

CVE-2026-23184: binder: fix UAF in binder_netlink_report()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23184

Introduced by commit 6374034 ("binder: introduce transaction reports
via netlink") in v6.18-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5e8a3d01544282e50d887d76f30d1496a0a53562]
stable/6.18: [a6050dedb6f1cc23e518e3a132ab74a0aad6df90]

CVE-2026-23185: wifi: iwlwifi: mld: cancel mlo_scan_start_wk

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23185

Introduced by commit 9748ad8 ("wifi: iwlwifi: defer MLO scan after
link activation") in v6.17-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ff641011ab7fb63ea101251087745d9826e8ef5]
stable/6.18: [9b9f52f052f4953fecd2190ae2dde3aa76d10962]

CVE-2026-23186: hwmon: (acpi_power_meter) Fix deadlocks related to
acpi_power_meter_notify()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23186

Introduced by commit 16746ce ("hwmon: (acpi_power_meter) Replace the
deprecated hwmon_device_register") in v6.15-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [615901b57b7ef8eb655f71358f7e956e42bcd16b]
stable/6.18: [8860ddf0e07be37169d4ef9f2618e39fca934a66]

CVE-2026-23187: pmdomain: imx8m-blk-ctrl: fix out-of-range access of bc->domains

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23187

Introduced by commit 2684ac0 ("soc: imx: add i.MX8M blk-ctrl driver")
in v5.16-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6bd8b4a92a901fae1a422e6f914801063c345e8d]
stable/6.1: [7842b5dfcac888ece025a2321257d74b2264b099]
stable/6.12: [4390dcdabb5fca4647bf56a5a6b050bbdfa5760f]
stable/6.18: [eb54ce033b344b531b374496e68a2554b2b56b5a]
stable/6.6: [071159ff5c0bf2e5efff79501e23faf3775cbcd1]

CVE-2026-23188: net: usb: r8152: fix resume reset deadlock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23188

Introduced by commit 4933b06 ("r8152: If inaccessible at resume time,
issue a reset") in v6.11-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d06bc83a5ae8777a5f7a81c32dd75b8d9b2fe04]
stable/6.12: [61c8091b7937f91f9bc0b7f6b578de270fe35dc7]
stable/6.18: [1b2efc593dca99d8e8e6f6d6c7ccd9a972679702]

CVE-2026-23189: ceph: fix NULL pointer dereference in ceph_mds_auth_match()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23189

Introduced by commit 22c73d5 ("ceph: fix multifs mds auth caps issue")
in v6.18-rc1.
Fixed in v6.19.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [7987cce375ac8ce98e170a77aa2399f2cf6eb99f]
stable/6.12: [c6f8326f26bd20d648d9a55afd68148d1b6afe28]
stable/6.18: [57b36ffc8881dd455d875f85c105901974af2130]

CVE-2026-23190: ASoC: amd: fix memory leak in acp3x pdm dma ops

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23190

Introduced by commit 4a767b1 ("ASoC: amd: add acp3x pdm driver dma
ops") in v5.8-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f67ba5413f98d93116a756e7f17cd2c1d6c2bd6]
stable/5.10: [9f23800c7eed06cb8ccae8a225f5e3d421b0d4cc]
stable/5.15: [d7ead6512650447a4cd6db774a2379acb259650c]
stable/6.1: [6d33640404968fe9f14a1252b337362b62fff490]
stable/6.12: [c9c14d2abe4c5546fcd3a7347fadc4aad2b308d8]
stable/6.18: [279cb9180510f7e13c3a4dfde8c16a8fbc7c5709]
stable/6.6: [0e0120214b5dcb0bf6b2171bb4e68e38968b2861]

CVE-2026-23191: ALSA: aloop: Fix racy access at PCM trigger

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23191

According to the .vulnerable file, this bug was introduced by commit
b1c73fc in v2.6.37-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [826af7fa62e347464b1b4e0ba2fe19a92438084f]
stable/6.12: [bad15420050db1803767e58756114800cce91ea4]
stable/6.18: [5727ccf9d19ca414cb76d9b647883822e2789c2e]

CVE-2026-23192: linkwatch: use __dev_put() in callers to prevent UAF

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23192

Introduced by commit 04efcee ("net: hold instance lock during
NETDEV_CHANGE") in v6.15-rc2.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83b67cc9be9223183caf91826d9c194d7fb128fa]
stable/6.18: [2718ae6af7445ba2ee0abf6365ca43a9a3b16aeb]

CVE-2026-23193: scsi: target: iscsi: Fix use-after-free in
iscsit_dec_session_usage_count()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23193

According to the .vulnerable file, this bug was introduced by commit
e48354c in v3.1-rc1.
Fixed in v6.19-rc7.
Affected function was added by e48354c ("iscsi-target: Add iSCSI
fabric support for target v4.1") in v3.1-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [84dc6037390b8607c5551047d3970336cb51ba9a]
stable/5.10: [2b64015550a13bcc72910be0565548d9a754d46d]
stable/5.15: [fd8b0900173307039d3a84644c2fee041a7ed4fb]
stable/6.1: [d8dbdc146e9e9a976931b78715be2e91299049f9]
stable/6.12: [41b86a9ec037bd3435d68dd3692f0891a207e7e7]
stable/6.18: [4530f4e4d0e6a207110b0ffed0c911bca43531a4]
stable/6.6: [11ebafffce31efc6abeb28c509017976fc49f1ca]

CVE-2026-23194: rust_binder: correctly handle FDA objects of length zero

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23194

Introduced by commit eafedbc ("rust_binder: add Rust Binder driver")
in v6.18-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8f589c9c3be539d6c2b393c82940c3783831082f]
stable/6.18: [598fe3ff32e43918ed8a062f55432b3d23e6340c]

CVE-2026-23195: cgroup/dmem: avoid pool UAF

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23195

Introduced by commit b168ed4 ("kernel/cgroup: Add "dmem" memory
accounting cgroup") in v6.14-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [99a2ef500906138ba58093b9893972a5c303c734]
stable/6.18: [d3081353acaa6a638dcf75726066ea556a2de8d5]

CVE-2026-23196: HID: Intel-thc-hid: Intel-thc: Add safety check for
reading DMA buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23196

According to the .vulnerable file, this bug was introduced by commit
4138f21 in v6.14-rc1.
Fixed in v6.19-rc5.
Affected function was added by a688404 ("HID: intel-thc-hid:
intel-thc: Add THC DMA interfaces") in v6.14-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a9a917998d172ec117f9e9de1919174153c0ace4]
stable/6.18: [1e84a807c98a71f767fd1f609637bc5944f916cb]

CVE-2026-23197: i2c: imx: preserve error state in block data length handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23197

Introduced by commit 5f5c2d4 ("i2c: imx: prevent rescheduling in non
dma mode") in v6.13-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b126097b0327437048bd045a0e4d273dea2910dd]
stable/6.18: [3f9b508b3eecc00a243edf320bd83834d6a9b482]

CVE-2026-23198: KVM: Don't clobber irqfd routing type when deassigning irqfd

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23198

Introduced by commit f70c20a ("KVM: Add an arch specific hooks in
'struct kvm_kernel_irqfd'") in v4.4-rc1.
Introduced by commit cb21073 ("KVM: Pass new routing entries and irqfd
when updating IRTEs") in v6.17-rc1.
Introduced by commit a0d7e2f ("KVM: arm64: vgic-v4: Only attempt vLPI
mapping for actual MSIs") in v6.15-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b4d37cdb77a0015f51fee083598fa227cc07aaf1]
stable/5.10: [959a063e7f12524bc1871ad1f519787967bbcd45]
stable/5.15: [2284bc168b148a17b5ca3b37b3d95c411f18a08d]
stable/6.1: [6d14ba1e144e796b5fc81044f08cfba9024ca195]
stable/6.12: [ff48c9312d042bfbe826ca675e98acc6c623211c]
stable/6.18: [4385b2f2843549bfb932e0dcf76bf4b065543a3c]
stable/6.6: [b61f9b2fcf181451d0a319889478cc53c001123e]

CVE-2026-23199: procfs: avoid fetching build ID while holding VMA lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23199

Introduced by commit ed5d583 ("fs/procfs: implement efficient VMA
querying API for /proc/<pid>/maps") in v6.11-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b5cbacd7f86f4f62b8813688c8e73be94e8e1951]
stable/6.12: [b9b97e6aeb534315f9646b2090d1a5024c6a4e82]
stable/6.18: [cbc03ce3e6ce7e21214c3f02218213574c1a2d08]

CVE-2026-23200: ipv6: Fix ECMP sibling count mismatch when clearing RTF_ADDRCONF

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23200

Introduced by commit f72514b ("ipv6: clear RA flags when adding a
static route") in v6.19-rc1.
Fixed in v6.19.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [bbf4a17ad9ffc4e3d7ec13d73ecd59dea149ed25]
stable/6.12: [d8143c54ceeba232dc8a13aa0afa14a44b371d93]
stable/6.18: [b8ad2d53f706aeea833d23d45c0758398fede580]
stable/6.6: [50b7c7a255858a85c4636a1e990ca04591153dca]

CVE-2026-23201: ceph: fix oops due to invalid pointer for kfree() in
parse_longname()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23201

Introduced by commit 101841c ("[ceph] parse_longname(): strrchr()
expects NUL-terminated string") in v6.17-rc1.
Fixed in v6.19.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [bc8dedae022ce3058659c3addef3ec4b41d15e00]
stable/6.12: [8c9af7339de419819cfc641d551675d38ff99abf]
stable/6.18: [e258ed369c9e04caa7d2fd49785d753ae4034cb6]

CVE-2026-23202: spi: tegra210-quad: Protect curr_xfer in
tegra_qspi_combined_seq_xfer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23202

Introduced by commit b4e002d ("spi: tegra210-quad: Fix timeout
handling") in v6.19-rc1.
Fixed in v6.19.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.12 stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [bf4528ab28e2bf112c3a2cdef44fd13f007781cd]
stable/5.15: [9fa4262a80f751d14a6a39d2c03f57db68da2618]
stable/6.1: [762e2ce71c8f0238e9eaf05d14da803d9a24422f]
stable/6.12: [6fd446178a610a48e80e5c5b487b0707cd01daac]
stable/6.18: [3bc293d5b56502068481478842f57b3d96e432c7]
stable/6.6: [712cde8d916889e282727cdf304a43683adf899e]

CVE-2026-23203: net: cpsw_new: Execute ndo_set_rx_mode callback in a work queue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23203

Introduced by commit 1767bb2 ("ipv6: mcast: Don't hold RTNL for
IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.") in v6.17-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0b5dc73a38f954e780f93a549b8fe225235c07a]
stable/6.18: [d5b3a669866977dc87fd56fcf00a70df1536d258]

CVE-2026-23204: net/sched: cls_u32: use skb_header_pointer_careful()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23204

Introduced by commit fbc2e7d ("cls_u32: use skb_header_pointer() to
dereference data safely") in v2.6.35-rc2.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cabd1a976375780dabab888784e356f574bbaed8]
stable/6.12: [e41a23e61259f5526af875c3b86b3d42a9bae0e5]
stable/6.18: [8a672f177ebe19c93d795fbe967846084fbc7943]
stable/6.6: [13336a6239b9d7c6e61483017bb8bdfe3ceb10a5]

CVE-2026-23205: smb/client: fix memory leak in smb2_open_file()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23205

Introduced by commit e255612 ("cifs: Add fallback for SMB2 CREATE
without FILE_READ_ATTRIBUTES") in v6.15-rc1.
Fixed in v6.19.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [e3a43633023e3cacaca60d4b8972d084a2b06236]
stable/6.1: [743f70406264348c0830f38409eb6c40a42fb2db]
stable/6.12: [b64e3b5d8d759dd4333992e4ba4dadf9359952c8]
stable/6.18: [9ee608a64e37cea5b4b13e436c559dd0fb2ad1b5]
stable/6.6: [3a6d6b332f92990958602c1e35ce0173e2dd62e9]

CVE-2026-23206: dpaa2-switch: prevent ZERO_SIZE_PTR dereference when
num_ifs is zero

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23206

Introduced by commit 0b1b713 ("staging: dpaa2-switch: handle Rx path
on control interface") in v5.13-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ed48a84a72fefb20a82dd90a7caa7807e90c6f66]
stable/5.15: [2fcccca88456b592bd668db13aa1d29ed257ca2b]
stable/6.1: [80165ff16051448d6f840585ebe13f2400415df3]
stable/6.12: [4acc40db06ffd0fd92683505342b00c8a7394c60]
stable/6.18: [155eb99aff2920153bf21217ae29565fff81e6af]
stable/6.6: [b97415c4362f739e25ec6f71012277086fabdf6f]

CVE-2026-23207: spi: tegra210-quad: Protect curr_xfer check in IRQ handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23207

Introduced by commit b4e002d ("spi: tegra210-quad: Fix timeout
handling") in v6.19-rc1.
Fixed in v6.19.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.12 stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [edf9088b6e1d6d88982db7eb5e736a0e4fbcc09e]
stable/6.18: [2ac3a105e51496147c0e44e49466eecfcc532d57]

CVE-2026-23208: ALSA: usb-audio: Prevent excessive number of frames

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23208

According to the .vulnerable file, this bug was introduced by commit
f0bd62b in v5.8-rc1.
Fixed in v6.19-rc6.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [ef5749ef8b307bf8717945701b1b79d036af0a15]
stable/6.18: [62932d9ed639a9fa71b4ac1a56766a4b43abb7e4]

CVE-2026-23209: macvlan: fix error recovery in macvlan_common_newlink()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23209

Introduced by commit aa5fd0f ("driver: macvlan: Destroy new macvlan
port if macvlan_common_newlink failed.") in v4.9-rc6.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8db6475a83649689c087a8f52486fcc53e627e9]
stable/5.10: [da5c6b8ae47e414be47e5e04def15b25d5c962dc]
stable/5.15: [5dae6b36a7cb7a4fcf4121b95e9ca7f96f816c8a]
stable/6.1: [c43d0e787cbba569ec9d11579ed370b50fab6c9c]
stable/6.12: [986967a162142710076782d5b93daab93a892980]
stable/6.18: [cdedcd5aa3f3cb8b7ae0f87ab3a936d0bd583d66]
stable/6.6: [11ba9f0dc865136174cb98834280fb21bbc950c7]

CVE-2026-23210: ice: Fix PTP NULL pointer dereference during VSI rebuild

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23210

Introduced by commit 803bef8 ("ice: factor out
ice_ptp_rebuild_owner()") in v6.9-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fc6f36eaaedcf4b81af6fe1a568f018ffd530660]
stable/6.18: [7565d4df66b6619b50dc36618d8b8f1787d77e19]

CVE-2025-71225: md: suspend array while updating raid_disks via sysfs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71225

Introduced commit is not determined.Fixed in v6.19-rc4.


Fixed status
mainline: [2cc583653bbe050bacd1cadcc9776d39bf449740]
stable/6.12: [165d1359f945b72c5f90088f60d48ff46115269e]
stable/6.18: [0107b18cd8ac17eb3e54786adc05a85cdbb6ef22]

CVE-2025-71226: wifi: iwlwifi: Implement settime64 as stub for MVM/MLD PTP

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71226

Introduced commit is not determined.Fixed in v6.19-rc4.


Fixed status
mainline: [81d90d93d22ca4f61833cba921dce9a0bd82218f]
stable/6.18: [ff6892ea544c4052dd5799f675ebc20419953801]

CVE-2025-71227: wifi: mac80211: don't WARN for connections on invalid channels

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71227

Introduced commit is not determined.Fixed in v6.19-rc4.


Fixed status
mainline: [99067b58a408a384d2a45c105eb3dce980a862ce]
stable/6.18: [10d3ff7e5812c8d70300f6fa8f524009a06aa7e1]

CVE-2025-71228: LoongArch: Set correct protection_map[] for VM_NONE/VM_SHARED

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71228

Introduced commit is not determined.Fixed in v6.19-rc4.


Fixed status
mainline: [d5be446948b379f1d1a8e7bc6656d13f44c5c7b1]
stable/6.1: [046303283d02c9732a778ccdeea433a899c78cbd]
stable/6.12: [380d7c1af4bd3e797692f5410ab374a98e766cd4]
stable/6.18: [9531210f348aa78e260a9e5b0d1a6f7e7aa329e6]
stable/6.6: [5fbdf95d2575ec53fd4a5c18e789b4d54a0281fe]

CVE-2025-71229: wifi: rtw88: Fix alignment fault in rtw_core_enable_beacon()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71229


Introduced by commit ad6741b ("wifi: rtw88: Stop high queue during
scan") in v6.5-rc1. Fixed by 0177aa8 ("wifi: rtw88: Fix alignment
fault in rtw_core_enable_beacon()").
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0177aa828d966117ea30a44f2e1890fdb356118e]
stable/6.12: [7d31dde1bd8678115329e46dc8d7afb63c176b74]
stable/6.18: [13394550441557115bb74f6de9778c165755a7ab]
stable/6.19: [653f8b6a091538b084715f259900f62c2ec1c6cf]
stable/6.6: [71dee092903adb496fe1f357b267d94087b679e0]

CVE-2025-71230: hfs: ensure sb->s_fs_info is always cleaned up

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71230


Introduced by ffcd06b ("hfs: convert hfs to use the new mount api") in
v6.13-rc1. Fixed by 05ce49a ("hfs: ensure sb->s_fs_info is always
cleaned up").
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [05ce49a902be15dc93854cbfc20161205a9ee446]
stable/6.18: [46c1d56ad321fb024761abd9af61a0cb616cf2f6]
stable/6.19: [399219831514126bc9541e8eadefe02c6fbd9166]

CVE-2025-71231: crypto: iaa - Fix out-of-bounds index in
find_empty_iaa_compression_mode

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71231


Introduced by b190447 ("crypto: iaa - Add compression mode management
along with fixed mode") in v6.8-rc1. Fixed by 4832930 ("crypto: iaa -
Fix out-of-bounds index in find_empty_iaa_compression_mode").
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [48329301969f6d21b2ef35f678e40f72b59eac94]
stable/6.12: [c77b33b58512708bd5603f48465f018c8b748847]
stable/6.18: [d75207465eed20bc9b0daa4a0927de9568996067]
stable/6.19: [de16f5bca05cace238d237791ed1b6e9d22dab60]

CVE-2025-71232: scsi: qla2xxx: Free sp in error path to fix system crash

Announce: no reference


Introduced by f352eeb ("scsi: qla2xxx: Add ability to use GPNFT/GNNFT
for RSCN handling") in v4.16-rc1. Fixed by 7adbd2b ("scsi: qla2xxx:
Free sp in error path to fix system crash").
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7adbd2b7809066c75f0433e5e2a8e114b429f30f]
stable/6.12: [05fcd590e5fbbb3e9e1b4fc6c23c98a1d38cf256]
stable/6.18: [f04840512438ac025dea6e357d80a986b28bbe4c]
stable/6.19: [19ac050ef09a2f0a9d9787540f77bb45cf9033e8]
stable/6.6: [aed16d37696f494288a291b4b477484ed0be774b]

CVE-2025-71233: PCI: endpoint: Avoid creating sub-groups asynchronously

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71233


Introduced by e85a2d7 ("CI: endpoint: Add support in configfs to
associate two EPCs with EPF") in v5.12-rc1. Fixed by 7c5c7d0 ("PCI:
endpoint: Avoid creating sub-groups asynchronously").
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7c5c7d06bd1f86d2c3ebe62be903a4ba42db4d2c]
stable/6.12: [d9af3cf58bb4c8d6dea4166011c780756b1138b5]
stable/6.18: [24a253c3aa6d9a2cde46158ce9782e023bfbf32d]
stable/6.19: [73cee890adafa2c219bb865356e08e7f82423fe5]

CVE-2025-71234: wifi: rtl8xxxu: fix slab-out-of-bounds in rtl8xxxu_sta_add

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71234


Introduced by eef55f1 ("wifi: rtl8xxxu: support multiple interfaces in
{add,remove}_interface()") in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [86c946bcc00f6390ef65e9614ae60a9377e454f8]
stable/6.12: [5d810ba377eddee95d30766d360a14efbb3d1872]
stable/6.18: [116f7bd8160c6b37d1c6939385abf90f6f6ed2f5]
stable/6.19: [9a0f3fa6ecd0c9c32dbc367a57482bbf7c7d25bf]

CVE-2025-71235: scsi: qla2xxx: Delay module unload while fabric scan in progress

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71235


Introduced by 783e0dc ("qla2xxx: Check for device state before
unloading the driver.") in v4.8-rc1. Fixed by 8890bf4 ("scsi: qla2xxx:
Delay module unload while fabric scan in progress").
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8890bf450e0b6b283f48ac619fca5ac2f14ddd62]
stable/6.12: [d70f71d4c92bcb8b6a21ac62d4ea3e87721f4f32]
stable/6.18: [c068ebbaf52820d6bdefb9b405a1e426663c635a]
stable/6.19: [7062eb0c488f35730334daad9495d9265c574853]
stable/6.6: [528b2f1027edfb52af0171f0f4b227fb356dde05]

CVE-2025-71236: scsi: qla2xxx: Validate sp before freeing associated memory

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71236


Introduced by a423994 ("scsi: qla2xxx: Add switch command to simplify
fabric discovery") in v4.16-rc1. Fixed by b6df15a ("scsi: qla2xxx:
Validate sp before freeing associated memory")
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b6df15aec8c3441357d4da0eaf4339eb20f5999f]
stable/6.12: [40ae93668226b610edb952c6036f607a61750b57]
stable/6.18: [1a9585e4c58d1f1662b3ca46110ed4f583082ce5]
stable/6.19: [944378ead9a48d5d50e9e3cc85e4cdb911c37ca1]
stable/6.6: [949010291bb941d53733ed08a33454254d9afb1b]

CVE-2025-71237: nilfs2: Fix potential block overflow that cause system hang

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71237


Introduced by 82e11e8 ("nilfs2: add nilfs_sufile_trim_fs to trim clean
segs") in v3.15-rc1. Fixed by ed527ef ("nilfs2: Fix potential block
overflow that cause system hang").
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ed527ef0c264e4bed6c7b2a158ddf516b17f5f66]
stable/6.12: [ea2278657ad0d62596589fbe2caf995e189e65e7]
stable/6.18: [4aa45f841413cca81882602b4042c53502f34cad]
stable/6.19: [b8c5ee234bd54f1447c846101fdaef2cf70c2149]
stable/6.6: [df1e20796c9f3d541cca47fb72e4369ea135642d]

CVE-2026-23211: mm, swap: restore swap_space attr aviod kernel panic

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23211

Introduced by commit 8b47299 ("mm, swap: mark swap address space ro
and add context debug check") in v6.18-rc1.
Fixed in v6.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a0f3c0845a4ff68d403c568266d17e9cc553e561]
stable/6.18: [b0020cbd26380177b9fb8b7e75a8f7bdba79db20]

CVE-2026-23212: bonding: annotate data-races around slave->last_rx

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23212

Introduced by commit f5b2b96 ("[PATCH] bonding: Validate probe replies
in ARP monitor") in v2.6.20.16.
Fixed in v6.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f6c3665b6dc53c3ab7d31b585446a953a74340ef]
stable/6.1: [a7516cb0165926d308187e231ccd330e5e3ebff7]
stable/6.12: [b956289b83887e0a306067b6003c3fcd81bfdf84]
stable/6.18: [bd98324e327e41de04b13e372cc16f73150df254]
stable/6.6: [8c0be3277e7aefb2f900fc37ca3fe7df362e26f5]

CVE-2026-23213: drm/amd/pm: Disable MMIO access during SMU Mode 1 reset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23213

Introduced commit is not determined.Fixed in v6.19-rc5.


Fixed status
mainline: [0de604d0357d0d22cbf03af1077d174b641707b6]
stable/6.12: [c1853ebbec980d5c05d431bfd6ded73b1363fd00]
stable/6.18: [cd7ff7fd3e4b77f0b5a292e0926532eaa07c5162]

CVE-2026-23214: btrfs: reject new transactions if the fs is fully read-only

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23214

Introduced commit is not determined.Fixed in v6.19-rc7.


Fixed status
mainline: [1972f44c189c8aacde308fa9284e474c1a5cbd9f]
stable/6.12: [a928eecf030a9a5dc5f5ca98332699f379b91963]
stable/6.18: [3228b2eceb6c3d7e237f8a5330113dbd164fb90d]

CVE-2026-23215: x86/vmware: Fix hypercall clobbers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23215

Introduced commit is not determined.Fixed in v6.19.


Fixed status
mainline: [2687c848e57820651b9f69d30c4710f4219f7dbf]
stable/6.12: [2f467a92df61eb516a4ec36ee16234dd4e5ccf00]
stable/6.18: [feb603a69f830acb58f78d604f0c29e63cd38f87]

CVE-2026-23216: scsi: target: iscsi: Fix use-after-free in
iscsit_dec_conn_usage_count()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23216

Introduced commit is not determined.Fixed in v6.19-rc7.


Fixed status
mainline: [9411a89e9e7135cc459178fa77a3f1d6191ae903]
stable/5.10: [ba684191437380a07b27666eb4e72748be1ea201]
stable/5.15: [8518f072fc92921418cd9ed4268dd4f3e9a8fd75]
stable/6.1: [275016a551ba1a068a3bd6171b18611726b67110]
stable/6.12: [48fe983e92de2c59d143fe38362ad17ba23ec7f3]
stable/6.18: [3835e49e146a4e6e7787b29465f1a23379b6ec44]
stable/6.6: [73b487d44bf4f92942629d578381f89c326ff77f]

CVE-2026-23217: riscv: trace: fix snapshot deadlock with sbi ecall

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23217

Introduced commit is not determined.Fixed in v6.19-rc5.


Fixed status
mainline: [b0d7f5f0c9f05f1b6d4ee7110f15bef9c11f9df0]
stable/6.18: [b1f8285bc8e3508c1fde23b5205f1270215d4984]

CVE-2026-23218: gpio: loongson-64bit: Fix incorrect NULL check after
devm_kcalloc()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23218

Introduced by commit 03c146c ("gpio: loongson-64bit: Add support for
Loongson-2K0300 SoC") in v6.18-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e34f77b09080c86c929153e2a72da26b4f8947ff]
stable/6.18: [e71e3fa90a15134113f61343392e887cd1f4bf7c]

CVE-2026-23219: mm/slab: Add alloc_tagging_slab_free_hook for
memcg_alloc_abort_single

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23219

Introduced by commit 9f9796b ("mm, slab: move memcg charging to
post-alloc hook") in v6.10-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e6c53ead2d8fa73206e0a63e9cd9aea6bc929837]
stable/6.12: [b8bc72587c79fe52c14732e16a766b6eded00707]
stable/6.18: [e8af57e090790983591f6927b3d89ee6383f8c1e]

CVE-2026-23220: ksmbd: fix infinite loop caused by
next_smb2_rcv_hdr_off reset in error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23220


Fixed by 010eb01 ("ksmbd: fix infinite loop caused by
next_smb2_rcv_hdr_off reset in error paths").
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [010eb01ce23b34b50531448b0da391c7f05a72af]
stable/6.12: [f7b1c2f5642bbd60b1beef1f3298cbac81eb232c]
stable/6.18: [71b5e7c528315ca360a1825a4ad2f8ae48c5dc16]
stable/6.19: [9135e791ec2709bcf0cda0335535c74762489498]
stable/6.6: [5accdc5b7f28a81bbc5880ac0b8886e60c86e8c8]

CVE-2026-23221: bus: fsl-mc: fix use-after-free in driver_override_show()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23221


Introduced by 1f86a00 ("bus/fsl-mc: add support for 'driver_override'
in the mc-bus") in v5.10-rc1. Fixed by 148891e ("bus: fsl-mc: fix
use-after-free in driver_override_show()").
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [148891e95014b5dc5878acefa57f1940c281c431]
stable/6.18: [1d6bd6183e723a7b256ff34bbb5b498b5f4f2ec0]
stable/6.19: [a2ae33e1c6361e960a4d00f7cf75d880b54f9528]

CVE-2026-23222: crypto: omap - Allocate OMAP_CRYPTO_FORCE_COPY
scatterlists correctly

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23222


Introduced by 74ed87e ("crypto: omap - add base support library for
common routines") in v4.13-rc1. Fixed by 1562b1f ("crypto: omap -
Allocate OMAP_CRYPTO_FORCE_COPY scatterlists correctly").
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1562b1fb7e17c1b3addb15e125c718b2be7f5512]
stable/6.12: [c184341920ed78b6466360ed7b45b8922586c38f]
stable/6.18: [2ed27b5a1174351148c3adbfc0cd86d54072ba2e]
stable/6.19: [d1836c628cb72734eb5f7dfd4c996a9c18bba3ad]
stable/6.6: [6edf8df4bd29f7bfd245b67b2c31d905f1cfc14b]

CVE-2026-23223: xfs: fix UAF in xchk_btree_check_block_owner

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23223


Introduced by ec793e6 ("xfs: remove xfs_btnum_t") in v6.9-rc1. Fixed
by 1c253e1 ("xfs: fix UAF in xchk_btree_check_block_owner").
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c253e11225bc5167217897885b85093e17c2217]
stable/6.12: [1d411278dda293a507cb794db7d9ed3511c685c6]
stable/6.18: [ed82e7949f5cac3058f4100f3cd670531d41a266]
stable/6.19: [ba5264610423d9653aa36920520902d83841bcfd]

CVE-2026-23224: erofs: fix UAF issue for file-backed mounts w/ directio option

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23224


Introduced by fb17675 ("erofs: add file-backed mount support") in
v6.12-rc1 and 6422cde ("erofs: use buffered I/O for file-backed mounts
by default") in 6.13-rc4.
Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [1caf50ce4af096d0280d59a31abdd85703cd995c]
stable/6.12: [ae385826840a3c8e09bf38cac90adcd690716f57]
stable/6.18: [d741534302f71c511eb0bb670b92eaa7df4a0aec]
stable/6.19: [b2ee5e4d5446babd23ff7beb4e636be0fb3ea5aa]

CVE-2026-23225: sched/mmcid: Don't assume CID is CPU owned on mode switch

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23225


Introduced by 007d842 ("sched/mmcid: Drop per CPU CID immediately when
switching to per task mode") in v6.19. Fixed by 1e83ccd ("sched/mmcid:
Don't assume CID is CPU owned on mode switch").
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e83ccd5921a610ef409a7d4e56db27822b4ea39]
stable/6.19: [81f29975631db8a78651b3140ecd0f88ffafc476]

CVE-2026-23226: ksmbd: add chann_lock to protect ksmbd_chann_list xarray

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71225


Fixed by 4f3a06c ("ksmbd: add chann_lock to protect ksmbd_chann_list xarray").
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f3a06cc57976cafa8c6f716646be6c79a99e485]
stable/6.18: [e4a8a96a93d08570e0405cfd989a8a07e5b6ff33]
stable/6.19: [36ef605c0395b94b826a8c8d6f2697071173de6e]

CVE-2026-23227: drm/exynos: vidi: use ctx->lock to protect struct
vidi_context member variables related to memory alloc/free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23227


Fixed by 52b3307 ("drm/exynos: vidi: use ctx->lock to protect struct
vidi_context member variables related to memory alloc/free").
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [52b330799e2d6f825ae2bb74662ec1b10eb954bb]
stable/6.18: [60b75407c172e1f341a8a5097c5cbc97dbbdd893]
stable/6.19: [0cd2c155740dbd00868ac5a8ae5d14cd6b9ed385]

CVE-2026-23228: smb: server: fix leak of active_num_conn in
ksmbd_tcp_new_connection()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23228


Introduced by 0d0d468 ("ksmbd: add max connections parameter") in
6.2-rc6. Fixed by 77ffbca ("smb: server: fix leak of active_num_conn
in ksmbd_tcp_new_connection()").
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [77ffbcac4e569566d0092d5f22627dfc0896b553]
stable/6.12: [baf664fc90a6139a39a58333e4aaa390c10d45dc]
stable/6.18: [cd25e0d809531a67e9dd53b19012d27d2b13425f]
stable/6.19: [599271110c35f6b16e2e4e45b9fbd47ed378c982]
stable/6.6: [787769c8cc50416af7b8b1a36e6bcd6aaa7680aa]

CVE-2026-23229: crypto: virtio - Add spinlock protection with
virtqueue notification

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23229


Introduced by fed93fb ("crypto: virtio - Handle dataq logic with
tasklet") in v6.8-rc1. Fixed by b505047 ("crypto: virtio - Add
spinlock protection with virtqueue notification")
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/5.10 stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [b505047ffc8057555900d2d3a005d033e6967382]
stable/6.12: [c0a0ded3bb7fd45f720faa48449a930153257d3a]
stable/6.18: [e69a7b0a71b6561b3b6459f1fded8d589f2e8ac2]
stable/6.19: [49c57c6c108931a914ed94e3c0ddb974008260a3]
stable/6.6: [d6f0d586808689963e58fd739bed626ff5013b24]

CVE-2026-23230: smb: client: split cached_fid bitfields to avoid
shared-byte RMW races

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23230


Introduced by ebe98f1 ("cifs: enable caching of directories for which
a lease is held") in v6.1-rc1. Fixed by ec30660 ("smb: client: split
cached_fid bitfields to avoid shared-byte RMW races")
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec306600d5ba7148c9dbf8f5a8f1f5c1a044a241]
stable/6.12: [3eaa22d688311c708b73f3c68bc6d0c8e3f0f77a]
stable/6.18: [c4b9edd55987384a1f201d3d07ff71e448d79c1b]
stable/6.19: [4cfa4c37dcbcfd70866e856200ed8a2894cac578]
stable/6.6: [4386f6af8aaedd0c5ad6f659b40cadcc8f423828]


* Updated CVEs

CVE-2025-22026: nfsd: don't ignore the return code of svc_proc_register()

stable/6.6 was fixed.

Fixed status
stable/6.6: [30405b23b4d5e2a596fb756d48119d7293194e75]

CVE-2025-38162: netfilter: nft_set_pipapo: prevent overflow in lookup
table allocation

stable/6.6 was fixed.

Fixed status
stable/6.6: [a9e757473561da93c6a4136f0e59aba91ec777fc]

CVE-2025-40005: spi: cadence-quadspi: Implement refcount to handle
unbind during busy

stable/6.6 was fixed.

Fixed status
stable/6.6: [8df235f768cea7a5829cb02525622646eb0df5f5]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com


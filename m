Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E950CD3436
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 02:36:22 +0000 (UTC)
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3560.1778121375688360974
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 May 2026 19:36:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=Q1FaJiam;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.46, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-65c0bda7f15so320744d50.0
        for <cip-dev@lists.cip-project.org>; Wed, 06 May 2026 19:36:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778121374; cv=none;
        d=google.com; s=arc-20240605;
        b=JUkcYEhTaurAoZBUHZnKFvu6/DGvsXMnpUnvvfOm4zHO1IWAO/L5hsEiMIjbQfpBi6
         tWAG14BCQ2eXTSsVtzkXfZz8lB88pjJ2MJ3Wy7h1tshbimU9TcaRMHZ7I5lhWVNOg0aB
         Nyf5X9WkZ9PsDA/zENFOeMU+DHOLlLWFhIxB5YGsudDNbvoqPQXMYkjUfsk3Zjc/GDBL
         ed1Y1P/d/k4yNFviOfYtpVQTo1siIwuDXlVUJVlXb3y1MHNrcveQqAl5tj6z9CskWVXd
         hxue2A2lUR2H23yTB/MvibQZZCIHpC5YN4h31YhgaRnrg4Oh/R2le+b+tcPJ++ttXABb
         ffog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=W2nS4N9r0uxibDNcawvEEr5xmjfQap2uVhRjAB0rBUE=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=ByRT1J1o/JeNTQZf0sClHjkiznjX9J1UucGndhHlBRDTLZ/pIGO+LDZni4NoRAQna4
         JWAXJRF6zNol/xAQ6ubXhwXxNguC+JQpG/Lv0MHM+hut3uOIXigGWTZt/RYa5fMGnChb
         siFhrnAXwwjyuqZZASmHohlL0sIZBz4O3nDmof8b0QESlk0OsYMvgPiJCPMyTZAoHUsl
         x5HCXfZyhGwfL4/xMtjwhwV+e10nUNG9I9ZijwU31FPaZyJfcUUrh68zl1Yh9zAmyQlz
         D4LpZ/9OWajXIBXOoiq+a4/XHrRJG+mlxZwZeKyejjtlZf6QBFFcE9USgEUG2RJQO74s
         KEdQ==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1778121374; x=1778726174; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W2nS4N9r0uxibDNcawvEEr5xmjfQap2uVhRjAB0rBUE=;
        b=Q1FaJiamyU2VJi8HSqPIBC32VYpKOeOsV3EfdDuj7cX3LzZ1xMcNE4gV4e+4TuJR/f
         cMl4pI4lfnSTZxZvXprCQOjgDiiz9J+wOrq0O2SoTlfQ2s21MiAuXHQvnlLL6/92iiUy
         FAlWBEuSX1PIFovEckcOVk7U3OUjptUCmHpABuSGAAvLp9wEhvb713GeYgNbr3XuKZhH
         wTtSOrDQpLuUaiCihMlEH54PSVJDi1Wx6A+niOnCl/Gr/6xNHc/4mKGyeu2WpjsOF2RT
         uRtebPAyqPN0GyPRGpD0vZ+HbqW+iv21z/NkjUxHIG/7eLN9TRlaaUmW8smbeVCHLOdQ
         EaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778121374; x=1778726174;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W2nS4N9r0uxibDNcawvEEr5xmjfQap2uVhRjAB0rBUE=;
        b=PEI8SJUJorgqEe+19w8fUg9/2yZqDQcyH9EHOkdMCL48IfooxhMFN2H06ZkpDzBQ5V
         T93fOFUpQiqF/qIMcKug5NlNvYW2CXwbA3exNHAFsCSY/fwE+a36KOt0w1F3VNLMIQ0q
         HAMoP+MdnTYoCXeQ639C2tA3Vfb7RMZ4Z6cJCQFDwZrUtLZ06NfxrnVCXYwodk2qHOvM
         vFNMqKLuja3OR00wW8v9PF5bOR1oNQ37VDKEcZjlfz7TKhm7p74OJ+9Hh9N9LWgiKC66
         EqGvefwedZ0pqCIO7A7svxWgQChUmS4laT6RJmC4YuxaKLGEG2klnQ36i0fA+2haO6B6
         7sBQ==
X-Gm-Message-State: AOJu0Yx+OQS+hjQiK+Li6Lu2PVT0lnsMgNiLC0sWa/G+xs3J4XgwrHko
	luUL0xrrz28WQp8AooLgo9XpW3H9Eem3rRefNaa7Y6/iDJVDk4g4wLs2xsUrc51JTTxX1cvqq6q
	4b7x1ORANTkHbNx5VjsECZwWp1ehMnknDJYZnhLOs3gY6OPK8mVXafJNVfQ==
X-Gm-Gg: AeBDiesNrj8i7ZZmo+sdVM2ZV0amNYfh5eo2HEmoTI/mgXADweV8+oB7PKaur7oOGuA
	Y7UHhh5oNhxwDzr0J+ps3ianvGT+9CX3F+D2N3WwsceNeazfyvomq3ubH5O7/Zqfcq2XpuUxnh0
	QBGetE8kZFS+OQDLsn8ACD2ClQMryCilSvwRyptlh06yjInWNH3R6c2TXXEDNlIl2TN3Bj6nVzX
	U5Wbe3Tkqp/3SNYZPWCt/ksbUiaxZMJE35s3n103/QgWp6xkk+GT2j8T0Vtw6y5KGHMDmoM/BV0
	b61aIY5JyPxw2baPySo=
X-Received: by 2002:a05:690e:d54:b0:65c:bfe:80ed with SMTP id
 956f58d0204a3-65c79929d84mr6145392d50.27.1778121371359; Wed, 06 May 2026
 19:36:11 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 7 May 2026 11:35:34 +0900
X-Gm-Features: AVHnY4I07Kt6lF_VoFFssMaicS7jZ-mry4YWeLVzW6KSBFVMhbLBfaF0WZizf6c
Message-ID: <CAODzB9qMjtWFyaxnrrc_gVa0PdJrBzwyooJhhERgiY0ZyuVvkQ@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 May 2026 02:36:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22895

Hi!

It's this week's CVE report.

This week reported 389 new CVEs and 3 updated CVEs.

* New CVEs
CVE-2026-31692: rtnetlink: add missing netlink_ns_capable() check for peer netns

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31692

Introduced by commit 81adee4 ("net: Support specifying the network
namespace upon device creation.") in v2.6.33-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b735ef81286007794a227ce2539419479c02a5f]
stable/6.18: [0975b64ffb34560042090a5986c3a02e6c80f36f]

CVE-2026-31693: cifs: some missing initializations on replay

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31693

According to the .vulnerable file, this bug was introduced by commit
4f1fffa in v6.8-rc2.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [14f66f44646333d2bfd7ece36585874fd72f8286]
stable/6.12: [1d731e512134495e0ef490ade0e4d91dc0d515ec]
stable/6.18: [7c9ce68192eef14c777cb6ce17155d2eb2431aea]
stable/6.6: [c854ab481ece4b3e5f4c2e8b22824f015ff874a5]

CVE-2026-31694: fuse: reject oversized dirents in page cache

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31694

Introduced by commit 69e3455 ("fuse: allow caching readdir") in v4.20-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [51a8de6c50bf947c8f534cd73da4c8f0a13e7bed]
stable/6.12: [45c05af36311624c1148123caeb011312495d86b]
stable/6.18: [7de93abfaae1b2dc94da8a07a36421bd073f1d8f]
stable/6.6: [d23ad78bfd205eac26766e38ba7d79f279131098]
stable/7.0: [474ce83c96a55f2eeb14dee2be375eeadfdacdf5]

CVE-2026-31695: wifi: virt_wifi: remove SET_NETDEV_DEV to avoid use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31695

Introduced by commit d43c65b ("ethtool: runtime-resume netdev parent
in ethnl_ops_begin") in v5.15-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [789b06f9f39cdc7e895bdab2c034e39c41c8f8d6]
stable/5.15: [e90f3e74e1ebc26c461a74be490d322716bcdcb4]
stable/6.1: [dcb5915696bd7b32b6404a897c24ee47cb23e772]
stable/6.12: [c5fa98842783ed227365d1303785de6a67020c8d]
stable/6.18: [5bbadf60b121065ffb267ec92018607b9c1c7524]
stable/6.6: [d1e3aa80e6e04410ba89eaaba4441a0d749d181d]

CVE-2026-31696: rxrpc: Fix missing validation of ticket length in
non-XDR key preparsing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31696

Introduced by commit 8a7a3eb ("KEYS: RxRPC: Use key preparsing") in v3.17-rc1.
Introduced by commit 84924aa ("rxrpc: Fix checker warning") in v6.2-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac33733b10b484d666f97688561670afd5861383]
stable/6.12: [4458757c020592a3094366e0fb20457383b42f92]
stable/6.18: [ce383ba615339f8eaec646a166d2c2b015bb5ca0]
stable/6.6: [1fa36cf495b0023e8475d038535c05e4063211e1]
stable/7.0: [a1be1c9ece26cea69654f28b255ff9a7906b897b]

CVE-2026-31697: crypto: ccp: Don't attempt to copy ID to userspace if
PSP command failed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31697

Introduced by commit d6112ea ("crypto: ccp - introduce SEV_GET_ID2
command") in v5.2-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f685dbfa87c546e51d9dc6cab379d20f275e114]
stable/6.12: [1fbac0429a42adec830491757a2b53956dd797ea]
stable/6.18: [2937f17bbeefb8e7608ff1f78cffbeb3d0281e5e]
stable/6.6: [09427bcb1715fb20a80b6acd5156dbf15ab5c363]
stable/7.0: [06f06d88c05ce176c61fff8c72c372847b0dd2b5]

CVE-2026-31698: crypto: ccp: Don't attempt to copy PDH cert to
userspace if PSP command failed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31698

Introduced by commit 76a2b52 ("crypto: ccp: Implement
SEV_PDH_CERT_EXPORT ioctl command") in v4.16-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e76239fed3cffd6d304d8ca3ce23984fd24f57d3]
stable/6.12: [78b97e43d0b3e674d9d49ae56937b11e2ba3fcaf]
stable/6.18: [051e51aa55fd4cdc3e8283cf4476aeeb5f563274]
stable/6.6: [b5c14bd4da1f376f385722fe1da993f1edab6472]
stable/7.0: [50808c13452dae43a2c90b1bbbf9daa16501ce70]

CVE-2026-31699: crypto: ccp: Don't attempt to copy CSR to userspace if
PSP command failed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31699

Introduced by commit e799035 ("crypto: ccp: Implement SEV_PEK_CSR
ioctl command") in v4.16-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [abe4a6d6f606113251868c2c4a06ba904bb41eed]
stable/6.12: [59e9ae81f8670ccc780bc75f45a355736f640ec9]
stable/6.18: [111dcc6d0f016076745824a787d25609d0022f4c]
stable/6.6: [607ba280f2adb5092cf5386c3935afac2ca0031a]
stable/7.0: [3b4fd8f15765d9a3105b834dba8a05d025e5e16e]

CVE-2026-31700: net/packet: fix TOCTOU race on mmap'd vnet_hdr in tpacket_snd()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31700

Introduced by commit 1d036d2 ("packet: tpacket_snd gso and checksum
offload") in v4.6-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c054e17d9d41f1020376806c7f750834ced4dc5]
stable/6.12: [3a1bf9116ea31470b89692585c3910dfe830dcdd]
stable/6.18: [28324a3b62d9ce7f9bdd65a8ce63f382041d1b27]
stable/6.6: [74e2db36fe50e3ad9d5300d7fd0e6e2a15a6d121]
stable/7.0: [48a6ef291a17639e1b6ae0fbe9c8b2bb87d7804b]

CVE-2026-31701: ALSA: caiaq: take a reference on the USB device in create_card()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31701

Introduced by commit b04dcbb ("ALSA: caiaq: Use
snd_card_free_when_closed() at disconnection") in v6.13-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [80bb50e2d459213cccff3111d5ef98ed4238c0d5]
stable/6.12: [1d9be95aee6c6246a21752e60c9519902649f482]
stable/6.18: [6473ed16df1fe88051140611b3eb9a49be7f429e]
stable/6.6: [f6634af5de728a46792f674a66d7843570cb68f7]
stable/7.0: [59b622a043cffc58b7638cd85ae6c30a0904f8e6]

CVE-2026-31702: f2fs: fix use-after-free of sbi in f2fs_compress_write_end_io()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31702

Introduced by commit 4c8ff70 ("f2fs: support data compression") in v5.6-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [39d4ee19c1e7d753dd655aebee632271b171f43a]
stable/6.12: [f5154cf3ce1c8193f0c1891d3769f62740cfe6fe]
stable/6.18: [c76cf339b87975ae5b2c06d2d774d5667d25a12a]
stable/6.6: [ef57cd3329b40c739b9a2e1a8a21ecc4171c6280]
stable/7.0: [2c97dcb6147c8f7f25c629b93be1e69617de5d4a]

CVE-2026-31703: writeback: Fix use after free in inode_switch_wbs_work_fn()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31703

Introduced by commit e1b849c ("writeback: Avoid contention on
wb->list_lock when switching inodes") in v6.18-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6689f01d6740cf358932b3e97ee968c6099800d9]
stable/6.18: [028103656b84273c73e9e271cf95c9f3421f4b8a]
stable/7.0: [9223e5f30403a9b506d6d0bff4f2e29a2d7d46af]

CVE-2026-31704: ksmbd: use check_add_overflow() to prevent u16 DACL
size overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31704

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [299f962c0b02d048fb45d248b4da493d03f3175d]
stable/6.12: [e1955a94b6f17f4b058afa955a6f187eb3ed7615]
stable/6.18: [5e7b8f3c539d69b2ed5f2408e2f75e68ce7eef43]
stable/6.6: [8d5729350b236896f51379588d9a690b7fafb8db]
stable/7.0: [ef7902be3f215b6bf7babe4dc9dd9a7d57dad7a7]

CVE-2026-31705: ksmbd: fix out-of-bounds write in smb2_get_ea() EA alignment

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31705

Introduced by commit e2b76ab ("ksmbd: add support for read compound")
in v6.6-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [30010c952077a1c89ecdd71fc4d574c75a8f5617]
stable/6.12: [98f3de6ef4efbd899348d333f0902dc4ff14380c]
stable/6.18: [790304c02bf9bd7b8171feda4294d6e62d32ae8f]
stable/6.6: [ffbce350c6fd1e99116ea57383b9031717e36d3b]
stable/7.0: [922d48fe8c19f388ffa2f709f33acaae4e408de2]

CVE-2026-31706: ksmbd: validate num_aces and harden ACE walk in
smb_inherit_dacl()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31706

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e4e2ea2a781018ed5d75f969e3e5606beb66e48]
stable/6.12: [063a7409b0de46d7c770b65bb0338e6fdb3b1f0a]
stable/6.18: [3e5360b422dd741cb315654a191fa73869a37414]
stable/7.0: [59c32abaaec9cdd6164811c7e864e72f7554b82d]

CVE-2026-31707: ksmbd: validate response sizes in ipc_validate_msg()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31707

Introduced by commit 0626e66 ("cifsd: add server handler for central
processing and tranport layers") in v5.15-rc1.
Introduced by commit a77e0e0 ("ksmbd: add support for supplementary
groups") in v6.12-rc4.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d6a6aa81eac2c9bff66dc6e191179cb69a14426b]
stable/6.12: [7dd0c858e1909769a4c91842724315ee74f1a5f1]
stable/6.18: [299db777ea0cfa5c407e41b045c24a14c034c27b]
stable/7.0: [99c631d0366c1eab8fb188fe66425f4581ebdde4]

CVE-2026-31708: smb: client: fix OOB read in smb2_ioctl_query_info
QUERY_INFO path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31708

Introduced by commit f5778c3 ("SMB3: Allow SMB3 FSCTL queries to be
sent to server from tools") in v5.1-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a58c5af19ff0d6f44f6e9fe31e33a2c92223f77e]
stable/6.12: [ac2f14e4705d020f04e806efa0d49ab8dc2b145f]
stable/6.18: [078fae8f50adebb903ccf2252b44391324571e78]
stable/6.6: [a34d456934fe42e4da5d2cc07787bf418bee99c6]
stable/7.0: [85fd46ee26a11841c670449508025965f61ce131]

CVE-2026-31709: smb: client: validate the whole DACL before rewriting
it in cifsacl

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31709

Introduced by commit bc3e9dd ("cifs: Change SIDs in ACEs while
transferring file ownership.") in v5.12-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0a8cf165566ba55a39fd0f4de172119dd646d39a]
stable/7.0: [b78db9bddc84136f6a0bb49e8883cf200dfb87a8]

CVE-2026-31710: smb: client: fix dir separator in SMB1 UNIX mounts

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31710

Introduced by commit 4fc3a43 ("smb: client: use atomic_t for
mnt_cifs_flags") in v7.0-rc2.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c4d3fc5844d685441befd0caaab648321013cdfd]
stable/7.0: [fbbfcf35e1ee3396631f3dc6214cb626aa9814c3]

CVE-2026-31711: smb: server: fix active_num_conn leak on transport
allocation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31711

Introduced by commit 0d0d468 ("ksmbd: add max connections parameter")
in v6.2-rc6.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [6551300dc452ac16a855a83dbd1e74899542d3b3]
stable/6.12: [295a9fc6789d1011c36ded9f0f2907bb34fa0de4]
stable/6.18: [283027aa93380380a0994f35dde3ec95318f2654]
stable/6.6: [97f8d2648ef4871e4cd335e2d769cb40054a6772]
stable/7.0: [fb48185bcd946d42de7017cf27f912f8ab26acf0]

CVE-2026-31712: ksmbd: require minimum ACE size in smb_check_perm_dacl()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31712

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d07b26f39246a82399661936dd0c853983cfade7]
stable/6.12: [95e5aa3c3261da8c95b27d7aecf8ee39b9f86a4c]
stable/6.18: [90089584b2e25c4510b7b987387b4405f0673ece]
stable/7.0: [151b1799861fde38087c08f613abc2843ef597b0]

CVE-2026-31713: fuse: abort on fatal signal during sync init

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31713

Introduced by commit dfb84c3 ("fuse: allow synchronous FUSE_INIT") in v6.18-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [204aa22a686bfee48daca7db620c1e017615f2ff]
stable/6.18: [0c7fca880a40a209a9c92be14143996d14b93ff6]
stable/7.0: [300e812b882a174dca675d8028684001ad5826bc]

CVE-2026-31714: f2fs: fix to avoid memory leak in f2fs_rename()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31714

Introduced by commit 40b2d55 ("f2fs: fix to create selinux label
during whiteout initialization") in v6.9-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [3cf11e6f36c170050c12171dd6fd3142711478fc]
stable/6.12: [c78206dcb912ab60b8ee3cbe8c48d749a9a12e1e]
stable/6.18: [047c0aef6af37a2a35181aa085c616ad286386f1]
stable/6.6: [a76c1cad4e80a9802ef8048662255417e3ce5b79]
stable/7.0: [369eb2016d8e2f01931b3bad1cb9cefa83f44003]

CVE-2026-31715: f2fs: fix UAF caused by decrementing sbi->nr_pages[]
in f2fs_write_end_io()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31715

Introduced by commit 50fa53e ("f2fs: fix to avoid broken of dnode
block list") in v4.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d9c4a4ed4eef1f82c5b16b037aee8bad819fd53]
stable/6.18: [963d2e24d9d92a31e6773b0f642214f10013ebf7]
stable/7.0: [188bb65f247a7a7c62f287c9a263aee3cad96fa5]

CVE-2026-31716: fs/ntfs3: validate rec->used in journal-replay file record check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31716

Introduced by commit b46acd6 ("fs/ntfs3: Add NTFS journal") in v5.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ca0485e4b2e837ebb6cbd4f2451aba665a03e4b]
stable/6.12: [4b1613d7e2deda831a97e427d1ea586e50fe1be5]
stable/6.18: [0112e6279420d4005b3d57af36fb45c01b8d0116]
stable/6.6: [f90b8a1798b750755a9e9aee66678f0a1820bbaf]
stable/7.0: [f79d0403ea20a81bc29105bba54fbcab54e8c403]

CVE-2026-31717: ksmbd: validate owner of durable handle on reconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31717

Introduced by commit c8efcc7 ("ksmbd: add support for durable handles
v1/v2") in v6.9-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [49110a8ce654bbe56bef7c5e44cce31f4b102b8a]
stable/6.18: [00ce8d6789dae72d042a4522264964c72891ca37]
stable/7.0: [c908c853f304a4969b5aa10eba0b50350cc65b80]

CVE-2026-31718: ksmbd: fix use-after-free in __ksmbd_close_fd() via
durable scavenger

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31718

Introduced by commit c8efcc7 ("ksmbd: add support for durable handles
v1/v2") in v6.9-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [235e32320a470fcd3998fb3774f2290a0eb302a1]
stable/6.12: [e33c65f011980b4ad4abfd93585ec2079856368f]
stable/6.18: [3d6682726c2d3a46d31dae88b8166786b09b03ad]
stable/7.0: [b34fc42cfe922e551f7a27d3ac3bb016e41d7dd9]

CVE-2026-31719: crypto: krb5enc - fix async decrypt skipping hash verification

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31719

Introduced by commit d1775a1 ("crypto: Add 'krb5enc' hash and cipher
AEAD algorithm") in v6.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3bfbf5f0a99c991769ec562721285df7ab69240b]
stable/6.18: [07cbb1bd424370671814a862913c99a6e1441588]
stable/7.0: [e51f42114abbdf47f29dda43e7826be28907fcd2]

CVE-2026-31720: usb: gadget: f_uac1_legacy: validate control request size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31720

According to the .vulnerable file, this bug was introduced by commit
c6994e6 in v2.6.31-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6e0e34d85cd46ceb37d16054e97a373a32770f6c]
stable/5.10: [557d1d4e862eccd0b74cc377b66de3e1e8d49605]
stable/5.15: [21b11e8581285c6f10ef43d05df349d445f24273]
stable/6.1: [0d41772d98dcaf6c17e875b7d0ea0154ae1191ee]
stable/6.12: [be2d32f0c3fe333d14c0a9ca90328dacbc3e06b8]
stable/6.18: [8e5eb1d6e6a3d7bbea9c92132d0cda5793176426]
stable/6.6: [c6da4fed7537aec19880c24f6c3a95065adb1406]

CVE-2026-31721: usb: gadget: f_hid: move list and spinlock inits from
bind to alloc

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31721

According to the .vulnerable file, this bug was introduced by commit
cb38253 in v3.19-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e0a88254ad59f6c53a34bf5fa241884ec09e8b2]
stable/5.10: [13440c0db227c5db01da751ed966dde4cdd2ea18]
stable/5.15: [de93e0862169b5539e00c2b9980b93fd80c37c0d]
stable/6.1: [81aee4500055876883658b024b6fb61801afe134]
stable/6.12: [f7d00ee1c8082c8a134340aaf16d71a27e29c362]
stable/6.18: [5d1bb391ceeebb28327703dd07af8c6324af298f]
stable/6.6: [8ec6a58586f195a88479edcdb0b8027c39f12d03]

CVE-2026-31722: usb: gadget: f_rndis: Fix net_device lifecycle with device_move

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31722

Introduced by commit f466c63 ("usb: gadget: f_rndis: convert to new
function interface with backward compatibility") in v3.11-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e367599529dc42578545a7f85fde517b35b3cda7]
stable/6.12: [1ef251aa63972fe6c0f107f5abd139b7d0f7987a]
stable/6.18: [18ada801899f2b13ef0ceff42427ad980a41e619]

CVE-2026-31723: usb: gadget: f_subset: Fix net_device lifecycle with device_move

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31723

Introduced by commit 8cedba7 ("usb: gadget: f_subset: convert to new
function interface with backward compatibility") in v3.11-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [06524cd1c9011bee141a87e43ab878641ed3652b]
stable/6.12: [70707ce668494c4d35fe070dfbc7cc541b293107]
stable/6.18: [9cbc4f109bb216623894d8819fb930210ed34b21]

CVE-2026-31724: usb: gadget: f_eem: Fix net_device lifecycle with device_move

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31724

Introduced by commit b29002a ("usb: gadget: f_eem: convert to new
function interface with backward compatibility") in v3.11-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d9270c9a8118c1535409db926ac1e2545dc97b81]
stable/6.12: [a6b8bce01a30a8c05c034bbc36c34845d65d644f]
stable/6.18: [4ccdccff8febc5456aff684627f9a4c5c83b9346]

CVE-2026-31725: usb: gadget: f_ecm: Fix net_device lifecycle with device_move

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31725

Introduced by commit fee562a ("usb: gadget: f_ecm: convert to new
function interface with backward compatibility") in v3.11-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b2cc4fae67a51f60d81d6af2678696accb07c656]
stable/6.12: [5eaeac22240d965d24c3bd0c54ded64efd8f6ca1]
stable/6.18: [4e34f3f491fd731809b57ddb5329ec763bd39553]

CVE-2026-31726: usb: gadget: uvc: fix NULL pointer dereference during
unbind race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31726

Introduced by commit b81ac43 ("usb: gadget: uvc: allow for application
to cleanly shutdown") in v5.18-rc7.
Fixed in v7.0-rc7.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [eba2936bbe6b752a31725a9eb5c674ecbf21ee7d]
stable/5.10: [0c00ec409d7b2bce3fcac73188b79a141db7cfda]
stable/5.15: [d92d1532e05b1b31d36d48765e43bf73d793d19f]
stable/6.1: [0587de744615628c38e33ddc1601160a5ea8c50a]
stable/6.12: [8a1128d604c360eca135f15b882b70256a522145]
stable/6.18: [1aa9356881ee4ed414bf72d0c56d915492cb5345]
stable/6.6: [c78e463ee134b4669579d453c81ae00795e4c19a]

CVE-2026-31727: usb: gadget: u_ether: Fix NULL pointer deref in eth_get_drvinfo

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31727

Introduced by commit ec35c19 ("usb: gadget: f_ncm: Fix net_device
lifecycle with device_move") in v7.0-rc4.
Fixed in v7.0-rc7.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18

Fixed status
mainline: [e002e92e88e12457373ed096b18716d97e7bbb20]
stable/6.12: [0326429e8ba99892e1d1e115dc8e88e1a3b64e24]
stable/6.18: [a36e5e800b9c93e3e1ffa42f34d38b36775dbcee]

CVE-2026-31728: usb: gadget: u_ether: Fix race between
gether_disconnect and eth_stop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31728

Introduced by commit 2b3d942 ("usb ethernet gadget: split out network
core") in v2.6.27-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e1eabb072c75681f78312c484ccfffb7430f206e]
stable/5.10: [f02980594deef751e42133714aee25228f1494c6]
stable/5.15: [e1e7a66584bf0aff3becb73c19fa31527889fc9e]
stable/6.1: [a259ba0bce3b192c04334499690372a250f7d0b1]
stable/6.12: [bbb09bb89ffa571475f66daca9482b974cd29d6a]
stable/6.18: [6ad77458637b78ec655e3da5f112c862e6690a9d]
stable/6.6: [f6813c2b2ae78def76b69e0f9d72f80e4a1c4aca]

CVE-2026-31729: usb: typec: ucsi: validate connector number in
ucsi_notify_common()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31729

Introduced by commit bdc62f2 ("usb: typec: ucsi: Simplified
registration and I/O API") in v5.5-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2d8c17ac01a1b1f638ea5d340a884ccc5015186]
stable/6.12: [f6dcbf2b024d55549959402f1db6c614e51d52cb]
stable/6.18: [f4e608fe12b7ac6a4a57176ab0296bb5a110a078]

CVE-2026-31730: misc: fastrpc: possible double-free of cctx->remote_heap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31730

Introduced by commit 0871561 ("misc: fastrpc: Add support for
audiopd") in v6.2-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ba2c83167b215da30fa2aae56b140198cf8d8408]
stable/6.12: [0bdee4118340c5a756220c1b29a7dab86bb0aa65]
stable/6.18: [3a164f640953cc982804746e772d379171aff5c6]
stable/6.6: [4b8e527aca357a6488680713bd88007cf8f547fe]

CVE-2026-31731: thermal: core: Address thermal zone removal races with resume

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31731

Introduced by commit 5a5efda ("thermal: core: Resume thermal zones
asynchronously") in v6.8-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [45b859b0728267a6199ee5002d62e6c6f3e8c89d]
stable/6.12: [1a6d2b001eb730d85f00da39ae7db6f3b4edc540]
stable/6.18: [2dbe93f344f10b432b95a23304006be805c097a1]

CVE-2026-31732: gpio: Fix resource leaks on errors in
gpiochip_add_data_with_key()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31732

Introduced by commit aab5c6f ("gpio: set device type for GPIO chips")
in v6.9-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [16fdabe143fce2cbf89139677728e17e21b46c28]
stable/6.18: [f0cf9c7b7c281956cc0dec163132cd96f76e1d60]

CVE-2026-31733: sched_ext: Fix stale direct dispatch state in ddsp_dsq_id

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31733

Introduced by commit 5b26f7b ("sched_ext: Allow SCX_DSQ_LOCAL_ON for
direct dispatches") in v6.12-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e0ffb72de8aa3b25989c2d980e81b829c577010]
stable/6.12: [ca685511f7afd42cdcbb0feea42e5d332d384251]
stable/6.18: [5e7b2cc8fae9ec2a5bc53311191d2faaff75a4b5]

CVE-2026-31734: sched_ext: Fix is_bpf_migration_disabled() false
negative on non-PREEMPT_RCU

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31734

Introduced by commit 8e4f0b1 ("bpf: use rcu_read_lock_dont_migrate()
for trampoline.c") in v6.18-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c4a59df370bea245695c00aaae6ae75747139bd]
stable/6.18: [72c43eb2e334febe93018cfb68ae828f55c6e49e]

CVE-2026-31735: iommupt: Fix short gather if the unmap goes into a large mapping

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31735

Introduced by commit 7c53f42 ("iommupt: Add unmap_pages op") in v6.19-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee6e69d032550687a3422504bfca3f834c7b5061]

CVE-2026-31736: net: ethernet: mtk_ppe: avoid NULL deref when gmac0 is disabled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31736

Introduced by commit 73cfd94 ("net: ethernet: mtk_eth_soc: ppe:
prevent ppe update for non-mtk devices") in v6.11-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [976ff48c2ac6e6b25b01428c9d7997bcd0fb2949]
stable/6.12: [0b832aad33e6f160fda310f0306a6483d85e9d6e]
stable/6.18: [5dff799c677152dde963c3917bacd9127b03e145]

CVE-2026-31737: net: ftgmac100: fix ring allocation unwind on open failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31737

Introduced by commit d72e01a ("ftgmac100: Use a scratch buffer for
failed RX allocations") in v4.12-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0fd0fe745f5e8c568d898cd1513d0083e46204a]
stable/5.10: [184b3a500d60ea48d1b176103cff1706c456edf3]
stable/5.15: [78da43320d9d6ed788147fb085184e4fc801f057]
stable/6.1: [a7e1bf392acf11dc4209820fef75758f6e42bd65]
stable/6.12: [d45230081f19c280096241353c26b0de457de795]
stable/6.18: [8351d18989c8642fc53e2e12d94e42314a39b078]
stable/6.6: [8a71911fc7eeea930153322bc1efc065db8cd97e]

CVE-2026-31738: vxlan: validate ND option lengths in vxlan_na_create

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31738

Introduced by commit 4b29dba ("vxlan: fix nonfunctional
neigh_reduce()") in v3.14-rc8.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [afa9a05e6c4971bd5586f1b304e14d61fb3d9385]
stable/5.10: [901c1dd3bab2955d7e664f914c374c8c3ac2b958]
stable/5.15: [e476745917a1e288eb15e7ff49d286a86a4861d3]
stable/6.1: [2029712fb2c87e9a8c75094906f2ee29bf08c500]
stable/6.12: [de20d2e3b9179d132f5f5b44e490d7c916c6321b]
stable/6.18: [eddfce70a6f3107d1679b0c2fcbeb96b593bd679]
stable/6.6: [602596c69a70e50d9ab8c6ae0290a01f88229dd7]

CVE-2026-31739: crypto: tegra - Add missing CRYPTO_ALG_ASYNC

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31739

Introduced by commit 0880bb3 ("crypto: tegra - Add Tegra Security
Engine driver") in v6.10-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b56770d345524fc2acc143a2b85539cf7d74bc1]
stable/6.12: [bdbf027a4504b4a86740de6beb6d18a957331839]
stable/6.18: [3aea268b6d5cde3b087df9eeecc3bc620aa09513]

CVE-2026-31740: counter: rz-mtu3-cnt: do not use struct
rz_mtu3_channel's dev member

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31740

Introduced by commit 0be8907 ("counter: Add Renesas RZ/G2L MTU3a
counter driver") in v6.4-rc1.
Fixed in v7.0-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt

Fixed status
mainline: [2932095c114b98cbb40ccf34fc00d613cb17cead]
stable/6.12: [633dfbf0eb2766c597c1a59dd83035c82e14791d]
stable/6.18: [6562290225c197e2e193a53de2a517815288dcd1]
stable/6.6: [28a371be901ef44ee03726c2575d7d6795521fe0]

CVE-2026-31741: counter: rz-mtu3-cnt: prevent counter from being
toggled multiple times

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31741

Introduced by commit 0be8907 ("counter: Add Renesas RZ/G2L MTU3a
counter driver") in v6.4-rc1.
Fixed in v7.0-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt

Fixed status
mainline: [67c3f99bed6f422ba343d2b70a2eeeccdfd91bef]
stable/6.12: [ced8b48420eddb1251f93c22dc23fa136490b3cd]
stable/6.18: [e07237df8538b0ae98dce112e4f6db093d767f80]
stable/6.6: [885aa739a07ab45e90dfa997205acec97979ce4e]

CVE-2026-31742: vt: discard stale unicode buffer on alt screen exit after resize

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31742

Introduced by commit 5eb6083 ("vt: save/restore unicode screen buffer
for alternate screen") in v7.0-rc5.
Fixed in v7.0-rc7.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [40014493cece72a0be5672cd86763e53fb3ec613]
stable/6.18: [891d790fdb5c96c6e1d2841e06ee6c360f2d1288]

CVE-2026-31743: nvmem: zynqmp_nvmem: Fix buffer size in DMA and memcpy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31743

Introduced by commit 737c0c8 ("nvmem: zynqmp_nvmem: Add support to
access efuse") in v6.9-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9b88613ff402aa6fe8fd020573cb95867ae947e]
stable/6.12: [2f6e5b9964d0a63a5ba84fca2642876afb70a662]
stable/6.18: [784ed4abded1ca4b525fa4cade8b02f8c5d2a087]

CVE-2026-31744: PM: EM: Fix NULL pointer dereference when perf domain
ID is not found

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31744

Introduced by commit 380ff27 ("PM: EM: Add dump to get-perf-domains in
the EM YNL spec") in v6.19-rc6.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9badc2a84e688be1275bb740942d5f6f51746908]

CVE-2026-31745: reset: gpio: fix double free in
reset_add_gpio_aux_device() error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31745

Introduced by commit 5fc4e4c ("reset: gpio: use software nodes to
setup the GPIO lookup") in v6.19-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fbffb8c7c7bb4d38e9f65e0bee446685011de5d8]

CVE-2026-31746: s390/zcrypt: Fix memory leak with CCA cards used as accelerator

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31746

Introduced by commit 57db62a ("s390/ap/zcrypt: Rework AP message
buffer allocation") in v6.16-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c8d46f17c2fc7d25c18e60c008928aecab26184d]
stable/6.18: [586222c37d4027dbf60a604fbe820184fee7c1c9]

CVE-2026-31747: comedi: me4000: Fix potential overrun of firmware buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31747

Introduced by commit ac584af ("staging: comedi: me4000: fix firmware
downloading") in v3.19-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3fb43a7a5b44713f892c58ead2e5f3a1bc9f4ee7]
stable/5.10: [8ddfe6495c245226a30d8b36e2f4a7aa7712e8d6]
stable/5.15: [64b24b713e1a3ea6624480594b4f8c2ff86502f2]
stable/6.1: [f72b5567f7c117b46b4058dc6a0c7554f8565561]
stable/6.12: [99f31aa98ab6e3805c455b65bcd01b3d48bdf1a5]
stable/6.18: [eae19cab44204537f79146f15a51811b13227c38]
stable/6.6: [1603dd471f47762e9d1f52304edb3e49a7e62655]

CVE-2026-31748: comedi: me_daq: Fix potential overrun of firmware buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31748

Introduced by commit 85acac6 ("Staging: comedi: add me_daq driver") in
v2.6.29-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cc797d4821c754c701d9714b58bea947e31dbbe0]
stable/5.10: [2fc25a4c2e055cd42ea39a1b42c89bfef70e0319]
stable/5.15: [9f39fa07259eb342908e4aa0271dee038a8ce4f8]
stable/6.1: [f3f8ec00cfb8d8e826e30b1138a56355b88e9ba8]
stable/6.12: [1bf8761eb59e94bf7b8c17b2a1ee48f14378b172]
stable/6.18: [a47ae40339c1048f519df33ff8840731720f57cb]
stable/6.6: [c16ac4e173a05011437a2d868f70cc415339065a]

CVE-2026-31749: comedi: ni_atmio16d: Fix invalid clean-up after failed attach

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31749

Introduced by commit 2323b27 ("Staging: comedi: add ni_at_atmio16d
driver") in v2.6.30-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [101ab946b79ad83b36d5cfd47de587492a80acf0]
stable/5.10: [a01dd339ea6ac58b0967a50085622a6017351140]
stable/5.15: [933a2d6a95f9bfb203e562c9be1dd990c735535c]
stable/6.1: [5d8d88c8c0eec230de8f1f60e0920a4337939a88]
stable/6.12: [3848ae00b1642e2c98ff8cbfd2d3b38c6f53b5c3]
stable/6.18: [43c68a2c7cc35b7c2a83c285cb4ad3d472b8caa2]
stable/6.6: [f517646e008fe99ca1800601cd011b110f8684ae]

CVE-2026-31750: comedi: runflags cannot determine whether to reclaim chanlist

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31750

Introduced by commit 4e1da51 ("comedi: Add reference counting for
Comedi command handling") in v6.19-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [29f644f14b89e6c4965e3c89251929e451190a66]

CVE-2026-31751: comedi: dt2815: add hardware detection to prevent crash

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31751

According to the .vulnerable file, this bug was introduced by commit
d6a929b in v2.6.30-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [93853512f565e625df2397f0d8050d6aafd7c3ad]
stable/5.10: [8d63161837f1bf8810dbcd2a583c2bbf5ca6d733]
stable/5.15: [d2a786efdb9971f2a647724625da5bbecc994dc9]
stable/6.1: [0dcf33994b8dcf3db36530fb7e2cf9f89e5cbac3]
stable/6.12: [65c528fbeddd88478c210052f6c7b21be4973156]
stable/6.18: [34c8b3a91bdfbe4573650b4cd750ef639101fdc5]
stable/6.6: [d5d9df8b08d68d083ac57abc2c887dfb1f31af63]

CVE-2026-31752: bridge: br_nd_send: validate ND option lengths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31752

Introduced by commit ed842fa ("bridge: suppress nd pkts on
BR_NEIGH_SUPPRESS ports") in v4.15-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [850837965af15707fd3142c1cf3c5bfaf022299b]
stable/5.10: [82a42eceec7c6bdb0e0da94c0542a173b7ea57f2]
stable/5.15: [259466f76f5a2148aff11134e68f4b4c6d52725b]
stable/6.1: [ee02d8991fd7bd86ed6ebd0deb4aab53feb0e43a]
stable/6.12: [c49b9256bbacb6a135654aebd12e4c0e87166b7c]
stable/6.18: [837392a38445729c22e03d3abcf33f07763efd85]
stable/6.6: [e0bfd6d4dc77ab345b6c65eef0cfe9b2f69085aa]

CVE-2026-31753: auxdisplay: line-display: fix NULL dereference in
linedisp_release

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31753

Introduced by commit 66c9380 ("auxdisplay: linedisp: encapsulate
container_of usage within to_linedisp") in v6.19-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f138de156b20d9f9da6f72f90b63c01941d97d3]

CVE-2026-31754: usb: cdns3: gadget: fix state inconsistency on gadget
init failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31754

Introduced by commit 7733f6c ("usb: cdns3: Add Cadence USB3 DRD
Driver") in v5.4-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c32f8748d70c8fc77676ad92ed76cede17bf2c48]
stable/5.15: [fb7110a052467098967284ef14d306810b354937]
stable/6.1: [9b1d301fbae837bf6979a19030b81d869bb15f7a]
stable/6.12: [c7e475ae3a5593c5db21b3b7dca4ba8bdac9b47f]
stable/6.18: [5a85599ca4d2584d89dc69f4fc49303b75a42338]
stable/6.6: [cfca84f5986afceb63a3adf39d4a98e915aebbc2]

CVE-2026-31755: usb: cdns3: gadget: fix NULL pointer dereference in ep_queue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31755

Introduced by commit 7733f6c ("usb: cdns3: Add Cadence USB3 DRD
Driver") in v5.4-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f6f127b9bc34bed35f56faf7ecb1561d6b39000]
stable/5.15: [3d1433fe34b224b90259e207e5389e95b504ef04]
stable/6.1: [fb2ad0c1334a3eccfe4ed203f9eef5a4879226f6]
stable/6.12: [d61446dfc9d387775bb1b95b081953201b9222af]
stable/6.18: [390536cc6af4ca5566bc3bf1f8b704700380cd2c]
stable/6.6: [9ab9b0e5fcdac325f950fc8b6caa08a9e22a0db9]

CVE-2026-31756: usb: dwc2: gadget: Fix spin_lock/unlock mismatch in
dwc2_hsotg_udc_stop()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31756

Introduced by commit af076a4 ("usb: dwc2: also exit clock_gating when
stopping udc while suspended") in v6.16-rc1.
Fixed in v7.0-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [9bb4b5ed7f8c4f95cc556bdf042b0ba2fa13557a]
stable/5.15: [e9fcca3e87463013d595c65c2189ffaa32ad3b50]
stable/6.1: [8ffe31acb3b77a30ae34d01719a269881569fb7f]
stable/6.12: [4ed9d2dd9f29828c311db6ec4b8e0d34bfd6d6a4]
stable/6.18: [61937f686290494998236c680ce0836b8dd63a3f]
stable/6.6: [beab10429439e20708036a66fb0d97ffb79da6a1]

CVE-2026-31757: usb: misc: usbio: Fix URB memory leak on submit failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31757

Introduced by commit 121a0f8 ("usb: misc: Add Intel USBIO bridge
driver") in v6.18-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [33cfe0709b6bf1a7f1a16d5e8d65d003a71b6a21]
stable/6.18: [65ff09f48b0e72e4049096a989723406aabcf091]

CVE-2026-31758: usb: usbtmc: Flush anchored URBs in usbtmc_release

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31758

Introduced by commit 4f3c8d6 ("usb: usbtmc: Support Read Status Byte
with SRQ per file") in v4.19-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a768552f7a8276fb9e01d49773d2094ace7c8f1]
stable/5.10: [959ef329071136e4335b54822fe2f607659b4569]
stable/5.15: [e189d443767f7cd390c52f2e122e1fc41c7562d6]
stable/6.1: [7fa8f61bab3fb75b5deba8a0f3abb74dc5068d9f]
stable/6.12: [d13318dec0c1e0e2ac16f8ecbd522db14cea4bb1]
stable/6.18: [977b632db51d231dec0bc571089a5c2402674139]
stable/6.6: [95e09b07e50290254b28b8395509473104518f8c]

CVE-2026-31759: usb: ulpi: fix double free in
ulpi_register_interface() error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31759

Introduced by commit 289fcff ("usb: add bus type for USB ULPI") in v4.2-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01af542392b5d41fd659d487015a71f627accce3]
stable/5.10: [2f70ba9dae13a190673cc3f9b4aad52179738f60]
stable/5.15: [ee248e6e941e4f2e634df2bd43e5f1ef810ab6df]
stable/6.1: [272a9b26c336a295e4e209157fed809706c1b1f7]
stable/6.12: [8763f8317bb389aded32a32b08f6751cfff657d2]
stable/6.18: [38c28fe25611099230f0965c925499bfcf46a795]
stable/6.6: [aaeae6533d77e6ed4def85baec01e2815ebbef61]

CVE-2026-31760: gpib: lpvo_usb: fix memory leak on disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31760

Introduced by commit fce7951 ("staging: gpib: Add LPVO DIY USB GPIB
driver") in v6.13-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5cefb52c1af6f69ea719e42788f6ec6a087eb74c]
stable/6.18: [21f942879f86108b300a23683e67483f8c358fc7]

CVE-2026-31761: iio: gyro: mpu3050: Move iio_device_register() to
correct location

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31761

Introduced by commit 3904b28 ("iio: gyro: Add driver for the MPU-3050
gyroscope") in v4.10-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c05799449108fb0e0a6bd30e65fffc71e60db4d]
stable/5.10: [22487ef85f6dd9499ddf49b85a08afc50a3f1992]
stable/5.15: [caec338f91469f0a70b68165185afa3abc994545]
stable/6.1: [051ca43b0e0e4b66bfd349cd53ccf231ad1d69b7]
stable/6.12: [92f18aa86302fe83e0726a1191015f427d4ff056]
stable/6.18: [cc3de12a5612ee25df7fb549cb7b3e4cc8bfaf9c]
stable/6.6: [2a4537653d200fda2a8516083459f8ff6194f8fc]

CVE-2026-31762: iio: gyro: mpu3050: Fix irq resource leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31762

Introduced by commit 3904b28 ("iio: gyro: Add driver for the MPU-3050
gyroscope") in v4.10-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4216db1043a3be72ef9c2b7b9f393d7fa72496e6]
stable/5.10: [beb23092571e627190f23da4bb8548065cacd89c]
stable/5.15: [658d9deb45d5032baf388ac51991d1e789157334]
stable/6.1: [889253494ec73d60bd47c0518f8fe3a748520d5b]
stable/6.12: [b52fd1644ad2c4e96bbec97543a966d7ad8f21ea]
stable/6.18: [3a8e68d65a443de05061818823037931674740e0]
stable/6.6: [8f237c408f3007d7d9667623ffb41a9e9d661ee9]

CVE-2026-31763: iio: gyro: mpu3050: Fix incorrect free_irq() variable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31763

Introduced by commit 3904b28 ("iio: gyro: Add driver for the MPU-3050
gyroscope") in v4.10-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [edb11a1aef4011a4b7b22cc3c3396c6fe371f4a6]
stable/5.10: [11f7cd960f05b3f06747abfdc4e56dd0d8b8a157]
stable/5.15: [fdbe4b5268cd41f9953d25a67d139e47cac34519]
stable/6.1: [8001b42fbd5e510dced3a25665019982c99bc708]
stable/6.12: [8631e755fc07b651b5d158cc3656ef76cc874068]
stable/6.18: [ac1233397f4cfe55d71f6aa459b42c256c951531]
stable/6.6: [a09171d3f23e13bccd3dc34863186707c6301071]

CVE-2026-31764: iio: imu: st_lsm6dsx: Set buffer sampling frequency
for accelerometer only

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31764

Introduced by commit 6b648a3 ("iio: imu: st_lsm6dsx: Decouple sensor
ODR from FIFO batch data rate") in v6.19-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [679c04c10d65d32a3f269e696b22912ff0a001b9]

CVE-2026-31765: drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE to 64KB

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31765

Introduced by commit 34a1de0 ("drm/amdkfd: Relocate TBA/TMA to
opposite side of VM hole") in v6.9-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4487571ef17a30d274600b3bd6965f497a881299]
stable/6.12: [6b2614a0ff05a2d2836311425091c8feca6f0c21]
stable/6.18: [77c918eaa4c916751769242567407f61c6af142a]

CVE-2026-31766: drm/amdgpu: validate doorbell_offset in user queue creation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31766

Introduced by commit f09c1e6 ("drm/amdgpu: generate doorbell index for
userqueue") in v6.16-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a018d1819f158991b7308e4f74609c6c029b670c]
stable/6.18: [3543005a42d7e8e12b21897ef6798541bf7cbcd3]

CVE-2026-31767: drm/i915/dsi: Don't do DSC horizontal timing
adjustments in command mode

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31767

Introduced by commit 53693f0 ("drm/i915/dsi: account for DSC in
horizontal timings") in v5.6-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4dfce79e098915d8e5fc2b9e1d980bc3251dd32c]
stable/6.12: [55efe8402f46af8399c8b634a18b130a05fd7820]
stable/6.18: [86e926b108880c0109b8635e459450447156aeb7]

CVE-2026-31768: iio: adc: ti-adc161s626: use DMA-safe memory for spi_read()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31768

Introduced by commit 4d671b7 ("iio: adc: ti-adc161s626: add support
for TI 1-channel differential ADCs") in v4.9-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [768461517a28d80fe81ea4d5d03a90cd184ea6ad]
stable/6.1: [b3bb8faeca1a2ef7be95ee8a512b639f9ffce947]
stable/6.12: [67b3a91bdc48220bfb67155ab528121b9c822782]
stable/6.18: [014c6d27878d3883f7bb065610768fd021de1a96]
stable/6.6: [fa64aab25aba47296aa8d12bb4c88ec3fecb2054]

CVE-2026-31769: gpib: fix use-after-free in IO ioctl handlers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31769

According to the .vulnerable file, this bug was introduced by commit
9dde455 in v6.13-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1857f8296dceb75d00ab857fc3c61bc00c7f5c6]
stable/6.18: [cae26eff1b56d78bed7873cf3e60a2b1bdd4da6c]

CVE-2026-31770: hwmon: (occ) Fix division by zero in occ_show_power_1()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31770

Introduced by commit c10e753 ("hwmon (occ): Add sensor types and
versions") in v5.0-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [39e2a5bf970402a8530a319cf06122e216ba57b8]
stable/5.10: [c7d3712362c8ab8f82f441b649d9e446e7b9aa9d]
stable/5.15: [53e6175756b8c474b6247bbcea0aad3d68357475]
stable/6.1: [2502684b9e835de9a992ec47c3e6c6faabe3858d]
stable/6.12: [bbbefc48f6617cfb738dcff7f44beb50b5dfeb38]
stable/6.18: [243d55bd3f08cb15eee9d63f4716d4d4cdd760f5]
stable/6.6: [37ae8fadc74ed68e5bc364ffd17746d88e449ae3]

CVE-2026-31771: Bluetooth: hci_event: move wake reason storage into
validated event handlers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31771

Introduced by commit 2f20216 ("Bluetooth: Emit controller suspend and
resume events") in v5.10-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b2bf47cd75518c36fa2d41380e4a40641cc89cd]

CVE-2026-31772: Bluetooth: hci_sync: fix stack buffer overflow in
hci_le_big_create_sync

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31772

Introduced by commit 42ecf19 ("Bluetooth: ISO: Do not emit LE BIG
Create Sync if previous is pending") in v6.13-rc1.
Fixed in v7.0-rc7.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [bc39a094730ce062fa034a529c93147c096cb488]
stable/6.12: [f5d446624345d309e7a4a1b27ea9f028d6a8c5d9]
stable/6.18: [aba0aea354015794e8312dd7efe726967e58aefe]

CVE-2026-31773: Bluetooth: SMP: derive legacy responder STK
authentication from MITM state

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31773

Introduced by commit fff3490 ("Bluetooth: Fix setting correct
authentication information for SMP STK") in v3.16-rc3.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [20756fec2f0108cb88e815941f1ffff88dc286fe]
stable/5.10: [9a38659a3d06080715691bd3139f9c4b61f688e3]
stable/5.15: [667f44f1392df6482483756458c48670e579e9ff]
stable/6.1: [929db734d12db41ca5f95424db4612397f1bd4a7]
stable/6.12: [0afc846bd80073ffcd2b8040f2b2fafaea3d9f72]
stable/6.18: [061ee71ac6b03c9f8432fe49538c3682bfcf4cf3]
stable/6.6: [b1c6a8e554a39b222c0879a288ea98e338fc4d77]

CVE-2026-31774: io_uring/net: fix slab-out-of-bounds read in io_bundle_nbufs()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31774

Introduced by commit a05d1f6 ("io_uring/net: support bundles for
send") in v6.10-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b948f9d5d3057b01188e36664e7c7604d1c8ecb5]
stable/6.12: [90ced24c500ad4e129e9e34b7e56fd7849e350b6]
stable/6.18: [c314b405dcc4d8b9041124f928f81715d6328bec]

CVE-2026-31775: ALSA: ctxfi: Don't enumerate SPDIF1 at DAIO initialization

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31775

Introduced by commit a2dbaeb ("ALSA: ctxfi: Refactor resource alloc
for sparse mappings") in v6.19-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [75dc1980cf48826287e43dc7a49e310c6691f97e]

CVE-2026-31776: ALSA: ctxfi: Fix missing SPDIFI1 index handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31776

According to the .vulnerable file, this bug was introduced by commit
a2dbaeb in v6.19-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b045ab3dff97edae6d538eeff900a34c098761f8]
stable/5.10: [a3b0e5f84058a9c3d0542a71c2b3a7801e4ee26a]
stable/5.15: [28222e13666b5d26bf66563c056069ed32f87b33]
stable/6.1: [5b39985303a639b159dea306a032c08ef22f029d]
stable/6.12: [a0b45bdfffce9894b39392d061c14fda24de8b67]
stable/6.18: [57698f184e1afbe054b3cd30e2c43a67c11d7f5e]
stable/6.6: [c8859675f1cf92fe2eb25ef525440702140a0b55]

CVE-2026-31777: ALSA: ctxfi: Check the error for index mapping

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31777

According to the .vulnerable file, this bug was introduced by commit
8cc7236 in v2.6.31-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [277c6960d4ddb94d16198afd70c92c3d4593d131]

CVE-2026-31778: ALSA: caiaq: fix stack out-of-bounds read in init_card

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31778

Introduced by commit bafeee5 ("ALSA: snd_usb_caiaq: give better
shortname") in v2.6.31-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [45424e871abf2a152e247a9cff78359f18dd95c0]
stable/5.10: [02d9c5b0b5553a391448b6d655262bd829f90234]
stable/5.15: [3f7f8bae0d52cbd07ab04b76b6aac89ef98ee9f6]
stable/6.1: [66194c2575a4f567577ae70b1d7561163ce791a6]
stable/6.12: [3178b62e2e31bab39f63d4c8e54bf4ee0a425627]
stable/6.18: [3afa2e67f3523a980a2f90fd63c22322ac2b9ce0]
stable/6.6: [a82c1bce2d1299dd3c686a8fe48cf75b79a403c7]

CVE-2026-31779: wifi: iwlwifi: mvm: fix potential out-of-bounds read
in iwl_mvm_nd_match_info_handler()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31779

Introduced by commit 5ac54af ("wifi: iwlwifi: mvm: Add handling for
scan offload match info notification") in v6.1-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [744fabc338e87b95c4d1ff7c95bc8c0f834c6d99]
stable/6.1: [f6abac936a0dfd31d6c3e49205ec0ee75a8f887f]
stable/6.12: [e67d8c626ace80b0fa2b48c8ec0a46b508c93442]
stable/6.18: [dd90880eb5ec5442b37eb2b95688f4a63f4883e3]
stable/6.6: [ffbed27ba15ef80d1c622eeedbfef03e501ae134]

CVE-2026-31780: wifi: wilc1000: fix u8 overflow in SSID scan buffer
size calculation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31780

Introduced by commit c5c77ba ("staging: wilc1000: Add SDIO/SPI 802.11
driver") in v4.2-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d049e56b1739101d1c4d81deedb269c52a8dbba0]
stable/5.10: [34a23fd9ddd683a03c7e8cc0ceded3e59e354b99]
stable/5.15: [549f02d8ec94d39092ab6d9b103d0d6783a4b024]
stable/6.1: [bfbddeadd4779651403035ee177ae2f22f9f5521]
stable/6.12: [c97b2a00059608592ad0d86fbb813a4f8cf9464b]
stable/6.18: [d8388614de613c28eeb659c10115060a83739924]
stable/6.6: [9907ac9b9a18b92fc34b9e4cb9e10f208dc1d3f7]

CVE-2026-31781: drm/ioc32: stop speculation on the drm_compat_ioctl path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31781

Introduced by commit 505b524 ("drm/ioctl: Fix Spectre v1
vulnerabilities") in v4.20.
Fixed in v7.0-rc7.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [f8995c2df519f382525ca4bc90553ad2ec611067]
stable/5.10: [46a60ee8956ef1975f00455f614761c7ecedc09d]
stable/5.15: [5bb398991f378ef74d90b14a6ea8b61ff96cc03a]
stable/6.1: [d59c5d8539662d95887b4564f3f72ad38076a2d5]
stable/6.12: [4a41c2b18fc05d30b718d2602cac339eae710b34]
stable/6.18: [f0e441be08a2eab10b2d06fccfa267ee599dd6b3]
stable/6.6: [489f2ef2b908898d01df697dc4fe1476674be640]

CVE-2026-31782: perf/x86: Fix potential bad container_of in intel_pmu_hw_config

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31782

Introduced by commit ec980e4 ("perf/x86/intel: Support auto counter
reload") in v6.16-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dbde07f06226438cd2cf1179745fa1bec5d8914a]
stable/6.18: [e435a30ca6fe14c9611b1fc731c98a6d28410247]

CVE-2026-31783: spi: amlogic: spifc-a4: unregister ECC engine on probe
failure and remove() callback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31783

Introduced by commit 4670db6 ("spi: amlogic: add driver for Amlogic
SPI Flash Controller") in v6.18-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b0dc7e7c56573e7a52080f25f3179a45f3dd7e6f]
stable/6.18: [ee4c064e37d4d0ddc5a7580933dbe79a2c6acafc]

CVE-2026-31784: drm/xe/pxp: Clear restart flag in pxp_start after jumping back

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31784

Introduced by commit ccd3c68 ("drm/xe/pxp: Decouple queue addition
from PXP start") in v6.17-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [76903b2057c8677c2c006e87fede15f496555dc0]
stable/6.18: [9e962e68a9d26135af67c423767c0983d9ad94c3]

CVE-2026-31785: drm/xe/xe_pagefault: Disallow writes to read-only VMAs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31785

Introduced by commit fb544b8 ("drm/xe: Implement
xe_pagefault_queue_work") in v6.19-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d192b4f2d644d15d9a9f1d33dab05af936f6540]

CVE-2026-43004: spi: stm32-ospi: Fix resource leak in remove() callback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43004

Introduced by commit 79b8a70 ("spi: stm32: Add OSPI driver") in v6.15-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [73cd1f97946ae3796544448ff12c07f399bb2881]
stable/6.18: [b4ec54c974c6ea68b309989dcc3d3511068f45f3]

CVE-2026-43005: hwmon: (tps53679) Fix array access with zero-length block read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43005

Introduced by commit 75ca1e5 ("hwmon: (pmbus/tps53679) Add support for
TPS53685") in v6.17-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0e211f6aaa6a00fd0ee0c1eea5498f168c6725e6]
stable/6.18: [79b7e588399bb55f4c10bea6ca41b6c3b944d2bb]

CVE-2026-43006: io_uring/rsrc: reject zero-length fixed buffer import

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43006

Introduced by commit 8622b20 ("io_uring: add validate_fixed_range()
for validate fixed buffer") in v6.15-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [111a12b422a8cfa93deabaef26fec48237163214]
stable/6.18: [040a1e7e0e2f01851fec1dd2d96906f8636a9f75]

CVE-2026-43007: accel/qaic: Handle DBC deactivation if the owner went away

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43007

Introduced by commit 129776a ("accel/qaic: Add control path") in v6.4-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2feec5ae5df785658924ab6bd91280dc3926507c]
stable/6.12: [08021f2d4a557d6491e3bcc288e96425f50aa3cf]
stable/6.18: [f403094d9075d7c565a3d81002b781c325cb3c07]
stable/6.6: [2dd67966f39a2abf8ccb4865031c722e40e01b7f]

CVE-2026-43008: gpio: qixis-fpga: Fix error handling for devm_regmap_init_mmio()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43008

Introduced by commit e885002 ("gpio: add QIXIS FPGA GPIO controller")
in v6.19-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8de4e0f44c638c66cdc5eeb4d5ab9acd61c31e4f]

CVE-2026-43009: bpf: Fix incorrect pruning due to atomic fetch
precision tracking

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43009

Introduced by commit 5ffa255 ("bpf: Add instructions for
atomic_[cmp]xchg") in v5.12-rc1.
Introduced by commit 5ca419f ("bpf: Add BPF_FETCH field / create
atomic_fetch_add instruction") in v5.12-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [179ee84a89114b854ac2dd1d293633a7f6c8dac1]

CVE-2026-43010: bpf: Reject sleepable kprobe_multi programs at attach time

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43010

Introduced by commit 0dcac27 ("bpf: Add multi kprobe link") in v5.18-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb7024bfcc5f68ed11ed9dd4891a3073c15f04a8]
stable/6.18: [dc9a060d76c12b23c5f378ee115d5e5d03d8bbf3]

CVE-2026-43011: net/x25: Fix potential double free of skb

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43011

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d10a26aa4d072320530e6968ef945c8c575edf61]
stable/5.10: [5d0aa038a90b30c9bedde0c41c1fdcd98ecb16e9]
stable/5.15: [3f5e3005984645bf5bd129c6b13149879580b1fb]
stable/6.1: [f782dd382203b2a8c4552a628431b7de65a19a7b]
stable/6.12: [524371398d8463ea7e101fce2cbf3915645d1730]
stable/6.18: [fa1dbc93530b34fab0da9862426fe9c918c74dc0]
stable/6.6: [143d4fa68ae9efb83b0c55b12cc7f0d03732a2b1]

CVE-2026-43012: net/mlx5: Fix switchdev mode rollback in case of failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43012

Introduced by commit 2a4f56f ("net/mlx5e: Keep netdev when leave
switchdev for devlink set legacy only") in v6.13-rc6.
Fixed in v7.0-rc7.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [403186400a1a6166efe7031edc549c15fee4723f]
stable/6.12: [2ebb13f3e8be0b61f72425b34cce60c8b6ad1891]
stable/6.18: [e27153b2bd6e6699b544ac4dfa35d167bed5e642]

CVE-2026-43013: net/mlx5: lag: Check for LAG device before creating debugfs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43013

Introduced by commit 7f46a0b ("net/mlx5: Lag, add debugfs to query
hardware lag state") in v5.19-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf16bca6653679d8a514d6c1c5a2c67065033f14]
stable/6.1: [a3db46d5f4df92630a96f7bc77b60e75c2353e06]
stable/6.12: [cfa774e6c920c81e700327bf10db8cb50d5db456]
stable/6.18: [c53cf44588a93000f71817a6bb87a66353c48dee]
stable/6.6: [7129632cab3e4d23510b21930aa73b8d97a859f5]

CVE-2026-43014: net: macb: properly unregister fixed rate clocks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43014

Introduced by commit 83a77e9 ("net: macb: Added PCI wrapper for
Platform Driver.") in v4.10-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0f367a4f459cc8118aadc43c6bba53c60d93f8d]
stable/5.10: [54c6f0e7682433abed0304ac2f5cb71a92d4b366]
stable/5.15: [015aa24d3721a05b40935b8af78b49cadf616b8d]
stable/6.1: [ec1be2ce0d94506f11b22066fd6dc5eb4341b14f]
stable/6.12: [e35dbfdb1b7710f04ff5c9972ea04971d823a22d]
stable/6.18: [5392a5174df4f5a2fad2f00e8c617394d0efe031]
stable/6.6: [e1f6f47d6e60d51c3294e5b85787e9aee24c450e]

CVE-2026-43015: net: macb: fix clk handling on PCI glue driver removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43015

Introduced by commit d82d530 ("net: macb: fix use after free on
rmmod") in v5.15-rc2.
Fixed in v7.0-rc7.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [ce8fe5287b87e24e225c342f3b0ec04f0b3680fe]
stable/5.10: [bf64cae913cdd4821f13d5d1d68900c0891bef69]
stable/5.15: [67f70841a175fa3469119f52d77a3662c07507a2]
stable/6.1: [2d96204e4184d6f7dd2f93c6f218fd0c1f55e9ae]
stable/6.12: [f310a836da90d0f0321b14d446c071af63f9ee4c]
stable/6.18: [16ab4c0e2b15df5d33bfcb9ea8e4441b85dd4a57]
stable/6.6: [b3f799cdf830df1782ae463cf15ace35015be99e]

CVE-2026-43016: bpf: sockmap: Fix use-after-free of sk->sk_socket in
sk_psock_verdict_data_ready().

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43016

Introduced by commit c638291 ("af_unix: Implement
->psock_update_sk_prot()") in v5.15-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ad8391d37f334ee73ba91926f8b4e4cf6d31ea04]
stable/6.12: [68187f18a89be4b6237d28ae1313b5adf76238c6]
stable/6.18: [18861f87a043e78b1f901cae4237e755ed7ef095]
stable/6.6: [8d597e3e74027900ffa81b8ff47ab51999a3e110]

CVE-2026-43017: Bluetooth: MGMT: validate mesh send advertising payload length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43017

Introduced by commit b338d91 ("Bluetooth: Implement support for Mesh")
in v6.1-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bda93eec78cdbfe5cda00785cefebd443e56b88b]
stable/6.1: [24fa32369cf15d8fc918bdfe94097b12e6acada0]
stable/6.12: [0b706fb2294aff3adfd54653bda1b5e356ad4566]
stable/6.18: [edb5898cfa91afe7e8f83eda18d93034c953d632]
stable/6.6: [244b639e6a3a8e26241e201004a3a9f764476631]

CVE-2026-43018: Bluetooth: hci_event: fix potential UAF in
hci_le_remote_conn_param_req_evt

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43018

Introduced by commit 95118dd ("Bluetooth: hci_event: Use of a function
table to handle LE subevents") in v5.17-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b255531b27da336571411248c2a72a350662bd09]
stable/6.1: [59eecf0ffde15670e6a5e10c47be67f73d843b20]
stable/6.12: [7cadb03be37e761130edb153544fe0770a842b19]
stable/6.18: [1d0bdbfe3e91c11f0a704c52443a9446a10d699c]
stable/6.6: [5fb69e1eeea9d6cba80517e9f058b56b34bc3a81]

CVE-2026-43019: Bluetooth: hci_conn: fix potential UAF in set_cig_params_sync

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43019

Introduced by commit a091289 ("Bluetooth: hci_conn: Fix
hci_le_set_cig_params") in v6.6-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a2639a7f0f5bf7d73f337f8f077c19415c62ed2c]
stable/6.12: [66d432e9b45bae7881ffcdb12cd8fd0bf254ef02]
stable/6.18: [7d568fede8eac91161a60b710aa920abe9b0fb9f]

CVE-2026-43020: Bluetooth: MGMT: validate LTK enc_size on load

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43020

Introduced by commit 346af67 ("Bluetooth: Add MGMT handlers for
dealing with SMP LTK's") in v3.4-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b8dbe9648d69059cfe3a28917bfbf7e61efd7f15]
stable/5.10: [0f37d1e65c6d71ad94ccfb5c602163c525db789d]
stable/5.15: [257cdb960d8ff6d60bb6461b03c814b6cf0c9e64]
stable/6.1: [c34577f517b556fb6ca173d45bf7e766ae2564ce]
stable/6.12: [82f342b3b006ca1d65f4890c05f2ec32fcb808b6]
stable/6.18: [50fb64defa72a3fecd0af1ca7c6b47b5c5c2b257]
stable/6.6: [f71695e81f4cb428f3c7e2138eae88199005b52c]

CVE-2026-43021: Bluetooth: hci_sync: fix leaks when
hci_cmd_sync_queue_once fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43021

According to the .vulnerable file, this bug was introduced by commit
a106e50 in v6.19-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aca377208e7f7322bf4e107cdec6e7d7e8aa7a88]

CVE-2026-43022: Bluetooth: hci_sync: hci_cmd_sync_queue_once() return
-EEXIST if exists

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43022

According to the .vulnerable file, this bug was introduced by commit
505ea2b in v6.9-rc1.
Fixed in v7.0-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [2969554bcfccb5c609f6b6cd4a014933f3a66dd0]

CVE-2026-43023: Bluetooth: SCO: fix race conditions in sco_sock_connect()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43023

Introduced by commit 9a8ec9e ("Bluetooth: SCO: Fix possible circular
locking dependency on sco_connect_cfm") in v6.3-rc7.
Fixed in v7.0-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [8a5b0135d4a5d9683203a3d9a12a711ccec5936b]
stable/6.1: [dabf22269242e2f2bf44c43fcdc2fa763df7f9cc]
stable/6.12: [7e296ffdab5bdab718dff7c14288fdcb9154fa27]
stable/6.18: [98c8d3bfdaa657d8f472dbbebd7ea8cd816d8a8d]
stable/6.6: [adb90cd0f9f7a8d438fcb93354040fbafc5ae2a0]

CVE-2026-43024: netfilter: nf_tables: reject immediate NF_QUEUE verdict

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43024

Introduced by commit f342de4 ("netfilter: nf_tables: reject QUEUE/DROP
verdict parameters") in v6.8-rc2.
Fixed in v7.0-rc7.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [da107398cbd4bbdb6bffecb2ce86d5c9384f4cec]
stable/5.10: [2f7f825a548be55420f0f5f716f6c27b9d312d3f]
stable/5.15: [f140593901724cfbd16597c3a4fcb24a58ae44b0]
stable/6.1: [68390437a998c3f2c57212b413abef5e6d657d88]
stable/6.12: [f710691be163ae6b39e4bcab9e5be32d329f035b]
stable/6.18: [42a47f4b1b7695026ab9bc1bb35d4622b0835c95]
stable/6.6: [4b12a3cc3f075e750cc3c5e693fd25fb400af4a2]

CVE-2026-43025: netfilter: ctnetlink: ignore explicit helper on new expectations

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43025

Introduced by commit bd07793 ("netfilter: nfnetlink_queue: allow to
attach expectations to conntracks") in v3.12-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [917b61fa2042f11e2af4c428e43f08199586633a]
stable/6.1: [e135f8e8212cbed12a03ab8dec77fa1247139897]
stable/6.12: [0f6c33697ccfac6499d0b7a4dbdec5d3a3a566cd]
stable/6.18: [187b6ec5229ea93cb04c4f6d3b52efc80f513d0d]
stable/6.6: [2ea0f35f235f70c133ad61fe05ba013753b978c6]

CVE-2026-43026: netfilter: ctnetlink: zero expect NAT fields when
CTA_EXPECT_NAT absent

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43026

Introduced by commit 076a0ca ("netfilter: ctnetlink: add NAT support
for expectations") in v3.4-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [35177c6877134a21315f37d57a5577846225623e]
stable/5.10: [a5a89db6981a1ddf2314bf50cb49db5a3146185f]
stable/5.15: [1c2ebdeff8d088a2e47ae25d7b38447249adace2]
stable/6.1: [a64b7bf84b4d5ea54218c5d374ec87fff9000f43]
stable/6.12: [fd002ff2ea030cbfb0188a11b3c60ce7f84485f4]
stable/6.18: [929f7a9a7aad9404a5867216c3f8738232355b38]
stable/6.6: [2898080c054ea4d6ddfaaf21bbedbc229a9a8376]

CVE-2026-43027: netfilter: nf_conntrack_helper: pass helper to expect cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43027

Introduced by commit ac7b848 ("netfilter: expect: add and use
nf_ct_expect_iterate helpers") in v4.14-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a242a9ae58aa46ff7dae51ce64150a93957abe65]
stable/5.10: [5cf28d5c8dcbbe8af6d3b145babe491906d7bad1]
stable/5.15: [504ba4168466c91210c45acdc332479cfd5f2da6]
stable/6.1: [dc1739eff48e34cc71d4e2f03715493fbcebd8af]
stable/6.12: [2c16e4d64dd91227742dfe196a3e7b0568bef65a]
stable/6.18: [620f3d14c1ef51d425060a3056ad8dbae8f998a3]
stable/6.6: [2cf2737c85a2ba2b52024dafe68ffad2676f97be]

CVE-2026-43028: netfilter: x_tables: ensure names are nul-terminated

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43028

Introduced by commit c38c459 ("netfilter: implement xt_cgroup cgroup2
path match") in v4.5-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a958a4f90ddd7de0800b33ca9d7b886b7d40f74e]
stable/5.10: [bcac50ea0a29d430eedc5ac87b215393b567baa9]
stable/5.15: [ea01c1b219f5a11c66918abaa6f052e5a74041d6]
stable/6.1: [aa6cd4a8863391e0a64f62d8922cb0af732a2cf2]
stable/6.12: [673bbd36cba21d10a10f0932f479df7468e26fbb]
stable/6.18: [f419bdc205894750f4d3ec042bc87a1b9cde1351]
stable/6.6: [c2d4a3abb15ca14716c6d8b9ffcbcd7c63626af4]

CVE-2026-43029: mptcp: fix soft lockup in mptcp_recvmsg()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43029

Introduced by commit 8e04ce4 ("mptcp: fix MSG_PEEK stream corruption")
in v6.18-rc4.
Fixed in v7.0-rc7.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [5dd8025a49c268ab6b94d978532af3ad341132a7]
stable/6.18: [58b58b9ba89c43914eea90c18928e51852d10c24]

CVE-2026-43030: bpf: Fix regsafe() for pointers to packet

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43030

Introduced by commit 6d94e74 ("bpf: Support for pointers beyond
pkt_end.") in v5.11-rc1.
Fixed in v7.0-rc7.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [a8502a79e832b861e99218cbd2d8f4312d62e225]
stable/5.10: [b52f6d0ef7b308f9d05bbddb78749852f28e8e40]
stable/5.15: [37db6b9726d0bcf91cbdf9d63b558c50da49f968]
stable/6.1: [015a74476dc1ab6923d89f1ee009aaf43faa7185]
stable/6.12: [7241da033fdc507b920e092dab1f97b945cb0370]
stable/6.18: [8aebe18069394f4a79d2d82080a0f806da449996]
stable/6.6: [b99d82706bd1511bb875e3de7154698fd9215c99]

CVE-2026-43031: net: xilinx: axienet: Fix BQL accounting for multi-BD TX packets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43031

Introduced by commit c900e49 ("net: xilinx: axienet: Implement BQL")
in v6.15-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1978d03e86785872871bff9c2623174b10740de]
stable/6.18: [2a0323a913109b52bfc9f5ea7b92a1b249e07d3e]

CVE-2026-43032: NFC: pn533: bound the UART receive buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43032

Introduced by commit c656aa4 ("nfc: pn533: add UART phy driver") in v5.5-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [30fe3f5f6494f827d812ff179f295a8e532709d6]
stable/5.10: [8bedf1dd5640ac8997bff00bbefe241b438df397]
stable/5.15: [23e925183db26cd322597679669ad29d70ed2ada]
stable/6.1: [3adca9be14bf36b927193f05f5aea35a1a90e913]
stable/6.12: [f48ab6ee654ecc350434e4566bc785773f412b7e]
stable/6.18: [ad2f60de5045bfb5d20ea468a97c8760c6a3a4f8]
stable/6.6: [2c1fadd221b21d8038acfe6a0f56291881d5ff76]

CVE-2026-43033: crypto: authencesn - Do not place hiseq at end of dst
for out-of-place decryption

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43033

Introduced by commit 104880a ("crypto: authencesn - Convert to new
AEAD interface") in v4.3-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e02494114ebf7c8b42777c6cd6982f113bfdbec7]
stable/5.10: [8c62f618576519dbed6816fafc623ce592953025]
stable/5.15: [d589abd8b019b07075fda255ceab8c8e950cdb3f]
stable/6.1: [5466e7d0cd9e4f9cef9d8f18f18b60e7bc1c77e5]
stable/6.12: [89fe118b6470119b20c04afc36e45b81a69ea11f]
stable/6.18: [153d5520c3f9fd62e71c7e7f9e34b59cf411e555]
stable/6.6: [d0c4ff6812386880f30bc64c2921299cc4d7b47f]

CVE-2026-43034: bnxt_en: set backing store type from query type

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43034

Introduced by commit 6a4d077 ("bnxt_en: Add support for new backing
store query firmware API") in v6.8-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ee937107d52f9e5c350e4b5e629760e328b3d9f]
stable/6.18: [c8d53b70166d1dc463ef42adb7293e1a770822c7]

CVE-2026-43035: net: sched: cls_api: fix tc_chain_fill_node to
initialize tcm_info to zero to prevent an info-leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43035

Introduced by commit 32a4f5e ("net: sched: introduce chain object to
uapi") in v4.19-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e6e3eb5ee89ac4c163d46429391c889a1bb5e404]
stable/5.10: [903c3405cfcc7700260e456ab66a5867586c9e69]
stable/5.15: [71a3eda7e850ae844cb8993065f4e410c11a46ce]
stable/6.1: [4ae5d23f51fb91d7d1140c6f1ba77ab0756054c3]
stable/6.12: [d6db08484c6cb3d4ad696246f9d288eceba2a078]
stable/6.18: [906997ea3766c24fbbf9cc4bf17c047315bbd138]
stable/6.6: [e35f5195cd44ff4053fbc5d71ea97681728a0099]

CVE-2026-43036: net: use skb_header_pointer() for TCPv4 GSO frag_off check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43036

Introduced by commit cbc53e0 ("GSO: Add GSO type for fixed IPv4 ID")
in v4.7-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ddc748a391dd8642ba6b2e4fe22e7f2ddf84b7f0]
stable/6.12: [f7a6cd508e9e825a2c69fa9e13d41ee156852f25]
stable/6.18: [cc91202fc20a44aab4c206f12a2bfe05da936051]

CVE-2026-43037: ip6_tunnel: clear skb2->cb[] in ip4ip6_err()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43037

Introduced by commit c4d3efa ("[IPV6] IP6TUNNEL: Add support to IPv4
over IPv6 tunnel.") in v2.6.22-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2edfa31769a4add828a7e604b21cb82aaaa05925]
stable/5.10: [ea9f65b27c8404e164848ebff1443310fd187629]
stable/5.15: [d6621f60192fe10c047a4487be42a6f4c150707f]
stable/6.1: [2cc6e3b0fe0f0242d1f530a93a4924f48ab85ba5]
stable/6.12: [1063515ce15ff31065c4e7f8265f4c2fd3c54876]
stable/6.18: [590f622669b97eaf7b57a1de7b0a6e68c5d8b2c3]
stable/6.6: [a0c4ce9900a108eaf55d0f3b399cb55999647d39]

CVE-2026-43038: ipv6: icmp: clear skb2->cb[] in ip6_err_gen_icmpv6_unreach()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43038

Introduced by commit ca15a07 ("sit: generate icmpv6 error when
receiving icmpv4 error") in v3.13-rc3.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [86ab3e55673a7a49a841838776f1ab18d23a67b5]
stable/5.10: [c438ba010171b70bad22fc18b1d5bdc3627476e8]
stable/5.15: [0452b6526b2f54b2413b9cb4ff1ea2ac542c99c7]
stable/6.1: [a4437faf135da293d16fcc4cc607316742bd0ebb]
stable/6.12: [e41953e7d118e2702bcb217879c173d9d1d3cd4e]
stable/6.18: [a2edbb6393972a02114b6003953a5cef3104fada]
stable/6.6: [3d5127d998de617b130aae96b138dba22ac6a8a7]

CVE-2026-43039: net: ti: icssg-prueth: fix missing data copy and wrong
recycle in ZC RX dispatch

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43039

Introduced by commit 7a64bb3 ("net: ti: icssg-prueth: Add AF_XDP zero
copy for RX") in v6.19-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5597dd284ff8c556c0b00f6a34473677426e3f81]

CVE-2026-43040: net: ipv6: ndisc: fix ndisc_ra_useropt to initialize
nduseropt_padX fields to zero to prevent an info-leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43040

Introduced by commit 3191057 ("[IPv6]: Export userland ND options
through netlink (RDNSS support)") in v2.6.24-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae05340ccaa9d347fe85415609e075545bec589f]
stable/5.10: [1da9023f6b071a38e5430ffbce4b70b2b1ac4f9c]
stable/5.15: [2fe4d0ba690a69ad6ae9f7ab9bdc96e02610b648]
stable/6.1: [11d7fe97421cfc81549940c20ed5ac9472d6db05]
stable/6.12: [4f810c686fde509d1cdaa706322d9d2531f8f1a4]
stable/6.18: [b485eef3d97b7aae55ce669b6de555ec81f3d21c]
stable/6.6: [7f56d87e527bb5a13c3e8b0d5840cb6332822f6d]

CVE-2026-43041: net: qrtr: replace qrtr_tx_flow radix_tree with xarray
to fix memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43041

Introduced by commit 5fdeb0d ("net: qrtr: Implement outgoing flow
control") in v5.6-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2428083101f6883f979cceffa76cd8440751ffe6]
stable/5.10: [f2dd9aaf6e2861337f5835f877a5b2becaf4b015]
stable/5.15: [4b75ff0aedd6ade1018ad4a3a9d8336794e36e42]
stable/6.1: [ff134cc43972d7ddceff8cfd36cf6b9eaafc00b3]
stable/6.12: [69402908e277dd164bf8d7c8fd0513c0fac28e9e]
stable/6.18: [f2664bc4f0f356f17c2094587a2b3665e3867e44]
stable/6.6: [0fda873092b541bb5a9b87d728a2429f863f8cfa]

CVE-2026-43042: mpls: add seqcount to protect the platform_label{,s} pair

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43042

Introduced by commit 7720c01 ("mpls: Add a sysctl to control the size
of the mpls label table") in v4.1-rc1.
Introduced by commit dde1b38 ("mpls: Convert mpls_dump_routes() to
RCU.") in v6.19-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [629ec78ef8608d955ce217880cdc3e1873af3a15]

CVE-2026-43043: crypto: af-alg - fix NULL pointer dereference in scatterwalk

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43043

Introduced by commit 8ff5909 ("crypto: algif_skcipher - User-space
interface for skcipher operations") in v2.6.38-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [62397b493e14107ae82d8b80938f293d95425bcb]
stable/5.10: [f48d3dd99199180cf37d6253550c55e86372309a]
stable/5.15: [f9acceae7b004956851fd4268edf9f518a9bce04]
stable/6.1: [7195350fb78538c25cd790d703f8f2c73ee0d395]
stable/6.12: [44eafa39363e8d5dfda6a8c6eb6b45458ed4b948]
stable/6.18: [00cbdec17c15d024a1c5002c7365df7624a18a75]
stable/6.6: [7cdf2c6381b21ab5ccf8116750d5582fcd6c0f49]

CVE-2026-43044: crypto: caam - fix DMA corruption on long hmac keys

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43044

Introduced by commit 199354d ("crypto: caam - Remove GFP_DMA and add
DMA alignment padding") in v6.3-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ddfdcbe10dc5f97afc4e46ca22be2be717e8caf]
stable/6.12: [c0c133e0225d87aad326bb90bbce9bdd6fde3cbb]
stable/6.18: [68feed135a0c7243a9275ae7e6a18260f755f52b]
stable/6.6: [a7ecf06d3ee06e9b3322e1e7b003ea5c6f6e135a]

CVE-2026-43045: mshv: Fix error handling in mshv_region_pin

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43045

According to the .vulnerable file, this bug was introduced by commit
621191d in v6.15-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0e296f257671ba10249630fe58026f29e4804d9]

CVE-2026-43046: btrfs: reject root items with drop_progress and zero drop_level

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43046

According to the .vulnerable file, this bug was introduced by commit
9f3a742 in v2.6.29-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b17b79ff896305fd74980a5f72afec370ee88ca4]
stable/5.15: [bedaf7d0b9d793e116f16b4d9a7dbc94bcc80443]
stable/6.1: [ac68a9a8e481ab1becaed29d6d23087dac3de15d]
stable/6.12: [53ceedd1eb6280ca8359664e0226983eded2ed73]
stable/6.18: [850de3d87f4720b71ccdcd44f4aa57e46b53a3f3]
stable/6.6: [295f8075d00442d71dc9ccae421ace1c0d2d9224]

CVE-2026-43047: HID: multitouch: Check to ensure report responses
match the request

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43047

According to the .vulnerable file, this bug was introduced by commit
6d4f544 in v4.4-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e716edafedad4952fe3a4a273d2e039a84e8681a]
stable/5.10: [516da3f25cfe18643835af1cf09b0e9ffc36c383]
stable/5.15: [a61163daf8a90b4a7ef154d5fc9c525f665734e3]
stable/6.1: [74c6015375d8b9bc1b1eb79f20636c8e894bcad7]
stable/6.12: [6a4acd3e86fe5584050c213d95147eba33856033]
stable/6.18: [7f66fdbc077faed3b52519228d21d81979e92249]
stable/6.6: [c7a27bb4d0f6573ca0f9c7ef0b63291486239190]

CVE-2026-43048: HID: core: Mitigate potential OOB by removing bogus memset()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43048

According to the .vulnerable file, this bug was introduced by commit
cd61045 in v2.6.20.16.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0a3fe972a7cb1404f693d6f1711f32bc1d244b1c]
stable/6.18: [8f71034649738fdeb6859b8d6cddf132024fac06]

CVE-2026-43049: HID: logitech-hidpp: Prevent use-after-free on force
feedback initialisation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43049

According to the .vulnerable file, this bug was introduced by commit
abdd3d0 in v5.4-rc6.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7a4c78bfeb320299c1b641500fe7761eadbd101]
stable/6.12: [772f99cc8d6e5d95613bce93c9624e154c1abe88]
stable/6.18: [b846fb0a73e99174f08238e083e284c0463a2102]

CVE-2026-43050: atm: lec: fix use-after-free in sock_def_readable()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43050

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [922814879542c2e397b0e9641fd36b8202a8e555]
stable/5.10: [3e8b25f32f2f35549d03d77da030a24a45bdef5b]
stable/5.15: [750a33f417f3d196b86375f8d9f8938bacf130fe]
stable/6.1: [317843d5355062020649124eb4a0d7acbcc3f53e]
stable/6.12: [3989740fa4978e1d2d51ecc62be1b01093e104ad]
stable/6.18: [abc10f85a3965ac14b9ed7ad3e67b35604a63aa3]
stable/6.6: [b256d055da47258e63f8b40965f276c5f23d229a]

CVE-2026-43051: HID: wacom: fix out-of-bounds read in wacom_intuos_bt_irq

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43051

According to the .vulnerable file, this bug was introduced by commit
78761ff in v3.3-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f1763f62909ccb6386ac50350fa0abbf5bb16a9]
stable/5.10: [d0ae84b3c9f3ea1a564eb1b7612113ca9fe8aada]
stable/5.15: [5b5b9730111808410e404ceac2fabd32eef92fbd]
stable/6.1: [fa8901cb1f0b2113a342db93bd5684b59fe99dcf]
stable/6.12: [41026bcc0fdf82605205c27935ef719cbc07193b]
stable/6.18: [c8dc23c97680eebefde06da5858aaef1b37cf75d]
stable/6.6: [8bd690ac1242332c73cba10dacdad6c6642bbb94]

CVE-2026-43052: wifi: mac80211: check tdls flag in ieee80211_tdls_oper

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43052

According to the .vulnerable file, this bug was introduced by commit
941c93c in v3.2-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d73872d949c488a1d7c308031d6a9d89b5e0a8b]
stable/6.12: [8148c2fda4ebb17104a573649c9b699208ad10ee]
stable/6.18: [be81f17151fcb8546a95f35ca8f4231b065985de]

CVE-2026-43053: xfs: close crash window in attr dabtree inactivation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43053

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b854e1c4eff3473b6d3a9ae74129ac5c48bc0b61]

CVE-2026-43054: scsi: target: tcm_loop: Drain commands in target_reset handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43054

Introduced by commit e0eb5d3 ("scsi: target: tcm_loop: Use block cmd
allocator for se_cmds") in v5.13-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1333eee56cdf3f0cf67c6ab4114c2c9e0a952026]
stable/5.15: [757c43c692294cdfad31390accc0e90429b2ef8a]
stable/6.1: [103f79e4949513247d763c6e7f3cbbf62017afdf]
stable/6.12: [7cbd69aaa507b1245240a28022bf5da0f07c68d9]
stable/6.18: [a836054ea81014117ec6b73529a21626a9e1f829]
stable/6.6: [15f5241d5a52364a7e7867b49128b0442dbcad9d]

CVE-2026-43055: scsi: target: file: Use kzalloc_flex for aio_cmd

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43055

Introduced by commit 732f25a ("fs: add a write stream field to the
kiocb") in v6.16-rc1.
Introduced by commit c27683d ("block: expose write streams for block
device nodes") in v6.16-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01f784fc9d0ab2a6dac45ee443620e517cb2a19b]
stable/6.18: [ce54802fe6bb78eb0feffc66fed6a45d41ffc3ab]

CVE-2026-43056: net: mana: fix use-after-free in add_adev() error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43056

Introduced by commit a69839d ("net: mana: Add support for auxiliary
device") in v6.2-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c4ea7d8907cf72b259bf70bd8c2e791e1c4ff70f]
stable/6.12: [43f5b19fd190fea20d052bc84741b28031d5baa9]
stable/6.18: [5f4061f8225d18695e5afe9bbf1cb7bd673d7872]
stable/6.6: [d88541ffd56d62a61e77209080001eddd4d69815]

CVE-2026-43057: net: correctly handle tunneled traffic on IPV6_CSUM GSO fallback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43057

Introduced by commit 864e339 ("net: gso: Forbid IPv6 TSO with
extensions on devices with only IPV6_CSUM") in v6.17-rc3.
Fixed in v7.0-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [c4336a07eb6b2526dc2b62928b5104b41a7f81f5]
stable/6.1: [2094a7cf91b71367b649f991aacc7b579f793d0b]
stable/6.12: [33670f780e0120c3dacda188c512bbffe0b6044c]
stable/6.18: [a98b78116a27e2a57b696b569b2cb431c95cf9b6]
stable/6.6: [ed71cf465c75f5688b07a35d373cd1d6b589c8ea]

CVE-2026-43058: media: vidtv: fix pass-by-value structs causing MSAN warnings

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43058

Introduced by commit f90cf60 ("media: vidtv: add a bridge driver") in v5.10-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5f8e73bde67e931468bc2a1860d78d72f0c6ba41]
stable/6.12: [be57e52e27c7cbfb400a8f255e475cbcff242baa]
stable/6.18: [6d75a9ec5bdb8cf8382eaf8f8fe831ba7d58a9d4]
stable/6.6: [e3957eb26a3d570aefc6bb184fa8b8a1e9a4e508]
stable/7.0: [1b2820c8a9887981634020db19f1a2425558b88e]

CVE-2026-43059: Bluetooth: MGMT: Fix list corruption and UAF in
command complete handlers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43059

Introduced by commit 302a1f6 ("Bluetooth: MGMT: Fix possible UAFs") in v6.17.
Fixed in v7.0-rc5.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [17f89341cb4281d1da0e2fb0de5406ab7c4e25ef]
stable/6.12: [695b45b2262fcb5e71bed1175aad59c72f92aa78]
stable/6.18: [b5c5e96f3b0a5003c3ff98ebb33e59afec51dd77]

CVE-2026-43060: netfilter: nft_ct: drop pending enqueued packets on removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43060

Introduced by commit 7e0b2b5 ("netfilter: nft_ct: add ct timeout
support") in v4.19-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [36eae0956f659e48d5366d9b083d9417f3263ddc]
stable/5.10: [8a64e76933672b08bd85b63086f33432070fd729]
stable/5.15: [3da0b946835f33bf36b459ead764c61a761e689b]
stable/6.1: [ab50302190b303f847c4eba0e31a01a56dec596e]
stable/6.12: [6802ff8beceb9c4254318e81c1395720438f2cc2]
stable/6.18: [f29a055e4f593e577805b41228b142b58f48df1b]
stable/6.6: [e68a8db3a0546482b34e9ca5ca886bcf73eb37bb]

CVE-2026-43061: serial: 8250: Fix TX deadlock when using DMA

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43061

Introduced by commit 9e512ea ("serial: 8250: Fix fifo underflow on
flush") in v6.14-rc3.
Fixed in v7.0-rc5.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [a424a34b8faddf97b5af41689087e7a230f79ba7]
stable/5.10: [8190f9ab6ad90cb97652adbebd238b874a4ef70d]
stable/5.15: [79a19bd936bb35f56ef0ccab1b3b59ebce8c762d]
stable/6.1: [f76d91271bcacbd759a2e4ee3ea61faa6a727ccf]
stable/6.12: [2a72403b985aea6b4aac3171830492f9a387f9e1]
stable/6.18: [5f6b17562f03fc65c7d3474ef8f1959b19d1ca41]
stable/6.6: [d2719a0a9c3439abf67843a5504b7afccd9ded93]

CVE-2026-43062: Bluetooth: L2CAP: Fix type confusion in l2cap_ecred_reconf_rsp()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43062

Introduced by commit 15f02b9 ("Bluetooth: L2CAP: Add initial code for
Enhanced Credit Based Mode") in v5.7-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [15145675690cab2de1056e7ed68e59cbd0452529]
stable/5.10: [21d3ba696918d6373233aac0b9d51fcabdedddc0]
stable/5.15: [3b94e62caa1dc1198d0d55d97bd710da1dee15d7]
stable/6.1: [111f74547eee8cfedfb854284e80f35c8a491186]
stable/6.12: [d90150c72d2e6a8a3079e88755dafcfbe91c746d]
stable/6.18: [5a1ea296f8589ce8f1e3141b2b123b34ad010e19]
stable/6.6: [dd3b221e21079ade8263fbb7176f3d55ad75d3b6]

CVE-2026-43063: xfs: don't irele after failing to iget in xfs_attri_recover_work

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43063

Introduced by commit ae673f5 ("xfs: record inode generation in xattr
update log intent items") in v6.10-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [70685c291ef82269180758130394ecdc4496b52c]
stable/6.12: [b5c5a50c2f513d4a13a6763564a07b470e69cc5a]
stable/6.18: [a1a5df1038f0b3c560d204270373621a4e622808]

CVE-2026-43064: dmaengine: idxd: Fix not releasing workqueue on .release()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43064

Introduced by commit 47c16ac ("dmaengine: idxd: fix idxd conf_dev
'struct device' lifetime") in v5.13-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d33de353b1ff9023d5ec73b9becf80ea87af695]
stable/6.1: [fd4cb61bbd0fc3a749a8da6145cbb56d8f6dba35]
stable/6.12: [d02c24af126dee45247dc7890409c86d1831859d]
stable/6.18: [958e96533ddbd1edd127feb7624a7eed0cc379dc]
stable/6.6: [2bb9e9e93adff9cc8a138ae9a3a8d59b3452272e]

CVE-2026-43065: ext4: always drain queued discard work in ext4_mb_release()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43065

Introduced by commit 55cdd0a ("ext4: get discard out of jbd2 commit
kthread contex") in v5.15-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ee29d20aab228adfb02ca93f87fb53c56c2f3af]
stable/5.15: [e96c2354b170aaa53300c8e8fd59e41b133160f7]
stable/6.1: [c360e9d0def4f4ae03254a67c683103908555b75]
stable/6.12: [9b4d9dda6a71ad3425c8109d27c4c6bfb9da97b8]
stable/6.18: [812b6a7cd3e7f3a3e8a24db85bc6313c26cb1098]
stable/6.6: [1c82f863f090ab899085bdfade073313384b514b]

CVE-2026-43066: ext4: fix iloc.bh leak in ext4_fc_replay_inode() error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43066

Introduced by commit 8016e29 ("ext4: fast commit recovery path") in v5.10-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec0a7500d8eace5b4f305fa0c594dd148f0e8d29]
stable/5.10: [0892f12cd49fde5d5db68137923db107f894f3a3]
stable/5.15: [5a63033696e60b5d70816f1d119645ac5b0b0a03]
stable/6.1: [9c90449a9ac2cd1ba540ad2561b8b70c1bfb0a25]
stable/6.12: [19782b4c793b49a6aa4abbb307ddff3610009d21]
stable/6.18: [f7817ad399d604e8639005d87d148b5ec626ad26]
stable/6.6: [ca99cbcc316cdfd2040cc2b13d1426ccb3b3b50b]

CVE-2026-43067: ext4: handle wraparound when searching for blocks for
indirect mapped blocks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43067

Introduced by commit 4865c76 ("ext4: always allocate blocks only from
groups inode can use") in v7.0-rc1.
Fixed in v7.0-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/5.15 stable/6.1 stable/6.12
stable/6.18 stable/6.6

Fixed status
mainline: [bb81702370fad22c06ca12b6e1648754dbc37e0f]
stable/6.1: [f89bba144938921a2249237ad04a0183ff3f8930]
stable/6.12: [4bec4a498ce86314d470ae6144120461f2138c29]
stable/6.18: [12624c5b724a81e14e532972b40d863b0de3b7d1]
stable/6.6: [83170a05908b6cf2fb3235d3065bf613ff866f3c]

CVE-2026-43068: ext4: avoid allocate block from corrupted group in
ext4_mb_find_by_goal()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43068

Introduced by commit 163a203 ("ext4: mark block group as corrupt on
block bitmap error") in v3.12-rc1.
Introduced by commit 9008a58 ("ext4: make the bitmap read routines
return real error codes") in v4.4-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [46066e3a06647c5b186cc6334409722622d05c44]
stable/5.10: [fea6b2e250ff48f10d166011b57a8516ae5438c9]
stable/5.15: [0b84571c886719823d537f05f4f07cad6357c4b7]
stable/6.1: [ffc0a282462d45fee5957621be5afa29752f3b6d]
stable/6.12: [9370207b36d26e45a8c8ef0500706d37036edd6b]
stable/6.18: [1895f7904be71c48f1e6f338b28f24dabd6b8aeb]
stable/6.6: [2d31a5073f86a177edf44015e0dedb0c47cfd6d8]

CVE-2026-43069: Bluetooth: hci_ll: Fix firmware leak on error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43069

Introduced by commit 3718055 ("bluetooth: hci_uart: add LL protocol
serdev driver support") in v4.12-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [31148a7be723aa9f2e8fbd62424825ab8d577973]
stable/5.10: [95e8601af227b2b4390eecf8db6abdb9f6a91f17]
stable/5.15: [e6d95488c8c964d1df0d3e1db44c958706311e86]
stable/6.1: [b2dfbf1b5ff192cefd49574b951a4af9ddd32213]
stable/6.12: [5213ef54528dd1ac79b846e30d8f72ce092794aa]
stable/6.18: [9ecbfd93cd6de6c78cb7fd51fe079e36c7ff074b]
stable/6.6: [28904375d54b436a757641fb0331537778c0de5a]

CVE-2026-43070: bpf: Reset register ID for BPF_END value tracking

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43070

Introduced by commit 9d21199 ("bpf: Add bitwise tracking for BPF_END")
in v7.0-rc1.
Fixed in v7.0-rc5.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [a3125bc01884431d30d731461634c8295b6f0529]
stable/6.18: [a17443af874229408ce6b78e2c8a2b5adeb4b7d8]

CVE-2026-43071: dcache: Limit the minimal number of bucket to two

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43071

Introduced commit is not determined.Fixed in v7.1-rc1.
It seems as if this bug was introduced by 31fe62b ("mm: add a low
limit to alloc_large_system_hash") in 3.5-rc1.

Fixed status
mainline: [f08fe8891c3eeb63b73f9f1f6d97aa629c821579]
stable/6.12: [ddd57ebce245f9c7e2f6902a6c087d6186d2385d]
stable/6.18: [755b40903eff563768d4d96fd4ef51ec48adde3b]
stable/6.6: [426ef05e82ee52c8d0e95fc0808b7383d8352d73]
stable/7.0: [277cedabb0ab86baae83fa58218be13c6d3e5526]

CVE-2026-43072: drm/vc4: platform_get_irq_byname() returns an int

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43072

Introduced commit is not determined.Fixed in v7.1-rc1.
It seems as if this bug was introduced by commit f479008 ("drm/vc4:
hdmi: Rely on interrupts to handle hotplug") in 5.15-rc1.

Fixed status
mainline: [e597a809a2b97e927060ba182f58eb3e6101bc70]
stable/6.12: [ef2ee9db13b68c5e332b77c0a7108a2d4d56e114]
stable/6.18: [0185e0494a561edfc482507f9de89c2ad798b33d]
stable/6.6: [63c11b19cdc154fa848a6c3b535bfb1dc7b60378]
stable/7.0: [0c1b117f7ba46fb8f6ebc5e0bfe5b58568c301ba]

CVE-2026-43073: x86-64: rename misleadingly named
'__copy_user_nocache()' function

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43073

Introduced commit is not determined.Fixed in v7.1-rc1.


Fixed status
mainline: [d187a86de793f84766ea40b9ade7ac60aabbb4fe]
stable/6.12: [14b9194db4a28421a4dbe5d6e519efbaa7c5f3cd]
stable/6.18: [c6d4e0599e7e73abc04e2488dfeb7940c4039660]
stable/7.0: [efea91ad1729ff1853d7418e4d3bc27d085e72d0]

CVE-2025-71271: hfsplus: ensure sb->s_fs_info is always cleaned up

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71271

Introduced by commit 432f7c7 ("hfsplus: convert hfsplus to use the new
mount api") in v6.13-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [126fb0ce99431126b44a6c360192668c818f641f]
stable/6.18: [0bcfebb83b5460d5be4e5c9dfb19cdaf3d4cb1db]

CVE-2025-71272: most: core: fix resource leak in
most_register_interface error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71272

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [1f4c9d8a1021281750c6cda126d6f8a40cc24e71]
stable/6.12: [a49028a796d7b94f8e3ab9bd34b18f36be235459]
stable/6.18: [af0b99b2214a10554adb5b868240d23af6e64e71]

CVE-2025-71273: wifi: rtw88: Use devm_kmemdup() in rtw_set_supported_band()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71273

Introduced commit is not determined.Fixed in v7.0-rc1.
The rtw88 driver was added by e303748 ("rtw88: new Realtek 802.11ac
driver") in v5.2-rc1.

Fixed status
mainline: [2ba12401cc1f2d970fa2e7d5b15abde3f5abd40d]
stable/6.12: [9b5418070ee8468fac9e8bf641c83d46b85bff30]
stable/6.18: [ad9b80ee310ed734482a2e5da874b67f88ac0ef8]

CVE-2025-71274: rpmsg: core: fix race in driver_override_show() and
use core helper

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71274

Introduced by commit 39e4776 ("rpmsg: Add driver_override device
attribute for rpmsg_device") in v4.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [9d1410853628e0b79bacef01106fbe27b8dd9c0e]
mainline: [42023d4b6d2661a40ee2dcf7e1a3528a35c638ca]
stable/5.10: [392c6b68334aa0e0ae9aba95c0a366bcb0d92f5d]
stable/5.15: [d66b8074c555e8abb0ae19eea1c9f3635498bdde]
stable/6.1: [47615557447185917afa432b7958f87583c417cb]
stable/6.12: [7654e6e3cd6bdee9602f6063b3c670bd556d7e61]
stable/6.18: [2e4a70f3c30910427e5ea848b799066d67b963d5]
stable/6.6: [90c8353f471821d7ccd4fe573a2402e056192494]

CVE-2025-71285: net: qrtr: Drop the MHI auto_queue feature for IPCR DL channels

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71285

Introduced by commit 227fee5 ("bus: mhi: core: Add an API for auto
queueing buffers for DL channel") in v5.17-rc1.
Introduced by commit 68a838b ("net: qrtr: start MHI channel after
endpoit creation") in v6.0-rc2.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [51731792a25cb312ca94cdccfa139eb46de1b2ef]
stable/6.18: [7bdff9b9b0c65ac7105416fe3a40686832515e20]

CVE-2025-71286: ASoC: SOF: ipc4-topology: Correct the allocation size
for bytes controls

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71286

Introduced by commit a382082 ("ASoC: SOF: ipc4-topology: Add support
for TPLG_CTL_BYTES") in v6.4-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a653820700b81c9e6f05ac23b7969ecec1a18e85]
stable/6.12: [491956b45b5f4933632ea6d8a8bdfdf045ab81e1]
stable/6.18: [a704a1a4394b5877b9adc31b2c3165ad0b541896]
stable/6.6: [59fe643f21b9d59bcbedb0dfbf988ee455c23736]

CVE-2025-71287: memory: mtk-smi: fix device leak on larb probe

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71287

Introduced by commit cc8bbe1 ("memory: mediatek: Add SMI driver") in v4.6-rc1.
Introduced by commit 038ae37 ("memory: mtk-smi: add missing
put_device() call in mtk_smi_device_link_common") in v5.19-rc4.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9dae65913b32d05dbc8ff4b8a6bf04a0e49a8eb6]
stable/5.15: [04057b86fdac3d4847913a97dc6552c0bff9b85e]
stable/6.1: [357e16a7fc9c1fef2ea37dce9bb6b9bcb1d1687d]
stable/6.12: [1f23a48ff2b8ab47e514f7c84a4b1dbf9b848168]
stable/6.18: [f69535b77fa0518ad39870c00dd2995439ed5c34]
stable/6.6: [b9eccd59697f7e1cb9a714501d9af826e7f7e073]

CVE-2025-71288: memory: mtk-smi: fix device leaks on common probe

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71288

Introduced by commit 4740475 ("memory: mtk-smi: Add device link for
smi-sub-common") in v5.16-rc1.
Introduced by commit 038ae37 ("memory: mtk-smi: add missing
put_device() call in mtk_smi_device_link_common") in v5.19-rc4.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6cfa038bddd710f544076ea2ef7792fc82fbedd6]
stable/6.1: [b8b2cf42b94c0a8efe43279643935256a6f58b9f]
stable/6.12: [984992f31cfb71b25cd0a72ef51ceb5dd6f187e8]
stable/6.18: [b44d090d6ca159d94b59ad4cc44ffdaca094df82]
stable/6.6: [b16599fedf49fd42d174fba342a0b56103df3169]

CVE-2025-71289: fs/ntfs3: handle attr_set_size() errors when truncating files

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71289

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected file was added by 4342306 ("fs/ntfs3: Add file operations and
implementation") in v5.15-rc1.

Fixed status
mainline: [576248a34b927e93b2fd3fff7df735ba73ad7d01]

CVE-2025-71290: misc: ti_fpc202: fix a potential memory leak in probe function

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71290

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected file was added by 1e5c9b1 ("misc: add FPC202 dual port
controller driver") in v6.16-rc1.

Fixed status
mainline: [dad9f13d967b4e53e8eaf5f9c690f8e778ad9802]
stable/6.18: [d2975604bf1ba36ffc5a08fe8da97fd63b91c4f1]

CVE-2025-71291: misc: bcm_vk: Fix possible null-pointer dereferences
in bcm_vk_read()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71291

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected file was added by 111d746 ("misc: bcm-vk: add VK messaging
support") in v5.12-rc1-dontuse.

Fixed status
mainline: [ba75ecb97d3f4e95d59002c13afb6519205be6cb]
stable/6.1: [741c5a3a0cd893a4218fc0fc8c18403e54fcfb22]
stable/6.12: [aa97ccc3dc1eba9f4537f0410e9dbb0b05ccf2fb]
stable/6.18: [3842f93e6e29d5cc1dcb9e5bda70587b444bed69]
stable/6.6: [ece3722169ba93734bfd1f06255e8ab7f19fe964]

CVE-2025-71292: jfs: nlink overflow in jfs_rename

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71292

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
cip/4.19-st: [6ccc288f1f000e90676b59bf0c578f4c0bf5245d]
cip/4.4-st: [4ebfd6f68f13a18c9244f69795cee999aec49c2e]
mainline: [9218dc26fd922b09858ecd3666ed57dfd8098da8]
stable/5.10: [2108829a59f081e822fdab8c2cd7131deb8aa8a1]
stable/5.15: [b4330a0d0947fbdc9d445cbbeabd8cc910a8c9ca]
stable/6.1: [a3d66089e50a6e0142f8884471f74292102ea9aa]
stable/6.12: [5d77c36cd4b698649f5c30c5f6c084f4f61d1880]
stable/6.18: [fe136426e30ca6debcf916fd6a141555ed9fde74]
stable/6.6: [f70fcbc2ac7c24f087a2c895c5753aa730b1e479]

CVE-2025-71293: drm/amdgpu/ras: Move ras data alloc before bad page check

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71293

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected file was added by c030f2e ("drm/amdgpu: add amdgpu_ras.c to
support ras (v2)") in v5.2-rc1.

Fixed status
mainline: [bd68a1404b6fa2e7e9957b38ba22616faba43e75]
stable/6.18: [0b7f78caeffa51a1afa521c284e863ec3b5a36df]

CVE-2025-71294: drm/amdgpu: fix NULL pointer issue buffer funcs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71294

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected code was added by b704380 ("drm/amdgpu: move buffer funcs
setting up a level") in v6.7-rc1.

Fixed status
mainline: [9877a865d62c9c3e0f4cc369dc9ca9f7f24f5ee9]
stable/6.12: [29fd416e0e08aa6d5a97fd313749d08d83de0826]
stable/6.18: [276028fd9b60bbcc68796d1124b6b58298f4ca8a]

CVE-2025-71295: fs/buffer: add alert in try_to_free_buffers() for
folios without buffers

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71295

Introduced commit is not determined.Fixed in v7.0-rc1.
The folio code was added by 68189fe ("fs: Change try_to_free_buffers()
to take a folio") in v5.19-rc1.

Fixed status
mainline: [b68f91ef3b3fe82ad78c417de71b675699a8467c]
stable/6.1: [1b111a69a6e33a922622bf9870e4e63fb2b649c8]
stable/6.12: [727e5140e0cf83b4ce6a11b89bb73bff5d96f8f3]
stable/6.18: [42c32d7571ccd8ef32351cac506f00b0fae99fd2]
stable/6.6: [c1b6227555c52781178132b7a06466711855795c]

CVE-2026-43074: eventpoll: defer struct eventpoll free to RCU grace period

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43074

According to the .vulnerable file, this bug was introduced by commit
58c9b01 in v6.4-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [07712db80857d5d09ae08f3df85a708ecfc3b61f]
stable/6.12: [5b1173b165421561db29f30afc7e97d940a398a9]
stable/6.18: [7e8083f5eeedab0f460063b9c2c14c9a4e71a427]
stable/6.6: [a6566cd33f6f967a7651ebf2ce0dd31572e319cf]

CVE-2026-43075: ocfs2: fix out-of-bounds write in ocfs2_write_end_inline

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43075

Introduced commit is not determined.Fixed in v7.0.


Fixed status
mainline: [7bc5da4842bed3252d26e742213741a4d0ac1b14]
stable/6.12: [947f953978b0d9463498d548d0f054f5a75be2e9]
stable/6.18: [0c1af902223b6fcedb60904ca0b551254686c7b9]
stable/6.6: [e2c9dc6b6e96f3585f2a1062ca3374a52db0938f]

CVE-2026-43076: ocfs2: validate inline data i_size during inode read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43076

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [1524af3685b35feac76662cc551cbc37bd14775f]
stable/6.12: [c1de19e891be3bfb3e1d0c7cf07bbb8fb3b77c1b]
stable/6.18: [cd2d765aa7157f852999842af32148128c735d39]
stable/6.6: [37f074e65f24f10f8d8df224a572e4cb9e6faf63]

CVE-2026-43077: crypto: algif_aead - Fix minimum RX size check for decryption

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43077

Introduced by commit d887c52 ("crypto: algif_aead - overhaul memory
management") in v4.14-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d14bd48e3a77091cbce637a12c2ae31b4a1687c]
stable/5.10: [74a66fdb5282d89e348b00c42cfca3a936946d94]
stable/5.15: [fd427dd84f224309afbcc2cb67c7bb770a01265c]
stable/6.1: [1c76b5675119f694458293a2a81f40731c69bd32]
stable/6.12: [af2fa2fbbced26129813274b8b3f7705f280e174]
stable/6.18: [78cea133daf721698876e56135049a96d39d610a]
stable/6.6: [e86ab1e5661386a874fbb8551f0c04b8e9f8ad22]

CVE-2026-43078: crypto: af_alg - Fix page reassignment overflow in
af_alg_pull_tsgl

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43078

Introduced by commit e870456 ("crypto: algif_skcipher - overhaul
memory management") in v4.14-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [31d00156e50ecad37f2cb6cbf04aaa9a260505ef]
stable/5.10: [fa48d3ea9cdbfb28c1fd6756c6c5cd01351aa51e]
stable/5.15: [2b781d1d4f933990318bcc5c68fb75a717379e42]
stable/6.1: [f7826bc0b39928a4a22f6b815dd9940b22a63503]
stable/6.12: [c8369a6d62f5abde9cbd4b62c45bf4b996be2468]
stable/6.18: [dea5fcf085f977b6c2de1b2d4ec4767b6c840d1f]
stable/6.6: [710a4ce5d7afd9fe082c75dec282ab4a11c0fe71]

CVE-2026-43079: perf/x86/intel/uncore: Skip discovery table for offline dies

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43079

Introduced by commit edae1f0 ("perf/x86/intel/uncore: Parse uncore
discovery tables") in v5.13-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b568e9eba2fad89a696f22f0413d44cf4a1f892]
stable/6.12: [6cfc187d85f18f976d0fe527d4c6f6171542cc19]
stable/6.18: [f34feda8e0c9535fee3f8870ce8bab53c2798f71]
stable/6.6: [cfab2c817d2e7e0bee98d66850246ce842ed5f18]

CVE-2026-43080: l2tp: Drop large packets with UDP encap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43080

Introduced by commit 3557baa ("[L2TP]: PPP over L2TP driver core") in
v2.6.23-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ebe560ea5f54134279356703e73b7f867c89db13]
stable/6.12: [77c1489398c85a844f90205f5e76fd6bc8bb4089]
stable/6.18: [86534c97abd6365a9a021fd767a2023e63c44469]
stable/6.6: [9ccce02d501335f59a02f26c878c5e095b16302f]

CVE-2026-43081: net: ipa: fix GENERIC_CMD register field masks for IPA v5.0+

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43081

Introduced by commit faf0678 ("net: ipa: add IPA v5.0 GSI register
definitions") in v6.4-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9709b56d908acc120fe8b4ae250b3c9d749ea832]
stable/6.12: [d1c66396796f23f7201b1addf06f62515035354d]
stable/6.18: [bafc45ea30d297002750396d5f10e3018bf2cd60]
stable/6.6: [a7d326dfb13b5a0763eccfd78836fe15199fc499]

CVE-2026-43082: net: txgbe: leave space for null terminators on property_entry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43082

Introduced by commit c3e382a ("net: txgbe: Add software nodes to
support phylink") in v6.5-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5a37d228799b0ec2c277459c83c814a59d310bc3]
stable/6.12: [16eb3c2f86de9a21aefe7a6386607d4cd3947a77]
stable/6.18: [8eff73e58e1f8fe991522acb863164319a7f7dd3]
stable/6.6: [00e1d650fa4b228ef1faea8e29effe4b4861e6e4]

CVE-2026-43083: net: ioam6: fix OOB and missing lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43083

Introduced by commit b63c547 ("ipv6: ioam: Support for Queue depth
data field") in v5.17-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b30b1675aa2bcf0491fd3830b051df4e08a7c8ca]
stable/6.18: [6d1d9ed9b409e0662241e3d245d574a18f643494]

CVE-2026-43084: netfilter: nfnetlink_queue: make hash table per queue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43084

Introduced by commit e19079a ("netfilter: nfnetlink_queue: optimize
verdict lookup with hash table") in v7.0-rc1.
Fixed in v7.0.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18

Fixed status
mainline: [936206e3f6ff411581e615e930263d6f8b78df9d]
stable/6.12: [22730cb96093b5be0609063bbb1923dbecd61252]
stable/6.18: [41e3652a178cb0eecd48e0e6e27fbb73a004046a]

CVE-2026-43085: netfilter: nfnetlink_log: initialize nfgenmsg in
NLMSG_DONE terminator

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43085

Introduced by commit 29c5d4a ("[NETFILTER]: nfnetlink_log: fix sending
of multipart messages") in v2.6.23-rc8.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f3083aec8836213da441270cdb1ab612dd82cf4]
stable/6.12: [d1399632ba255d2e02c757af5d9f5d9279ce168c]
stable/6.18: [d552bcfca323d175664d7444989b04f55666978a]
stable/6.6: [368c22aea490f6f50df831b4f9e3623787686c5b]

CVE-2026-43086: ipvs: fix NULL deref in ip_vs_add_service error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43086

Introduced by commit 705dd34 ("ipvs: use kthreads for stats
estimation") in v6.2-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9a91797e61d286805ae10a92cc48959c30800556]
stable/6.12: [4039959315008888dd53c37674d33351817a5166]
stable/6.18: [a32dabacee111cea083ddd57a03635672e1bff29]
stable/6.6: [730663352c9178f33fcf5929f4a37c1f1ca5a693]

CVE-2026-43087: pinctrl: mcp23s08: Disable all pin interrupts during probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43087

Introduced by commit f9f4fda ("pinctrl: mcp23s08: init reg_defaults
from HW at probe and switch cache type") in v6.19-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [db5b8cecbdf479ad13156af750377e5b43853fab]

CVE-2026-43088: net: af_key: zero aligned sockaddr tail in PF_KEY exports

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43088

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Introduced by commit 08de61b ("[PFKEYV2]: Extension for dynamic update
of endpoint address(es)") in v2.6.21-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [426c355742f02cf743b347d9d7dbdc1bfbfa31ef]

CVE-2026-43089: xfrm_user: fix info leak in build_mapping()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43089

Introduced by commit 3a2dfbe ("xfrm: Notify changes in UDP
encapsulation via netlink") in v2.6.29-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1beb76b2053b68c491b78370794b8ff63c8f8c02]
stable/6.12: [5a1a4b049ddde41466ccac0daeec326254b133f2]
stable/6.18: [f779a6b6cdb6e12baa0663063ac59ab2a8f20c0c]
stable/6.6: [d3125c541a96fb3c0fc7210112684baf22b6c24d]

CVE-2026-43090: xfrm: fix refcount leak in xfrm_migrate_policy_find

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43090

Introduced by commit 563d5ca ("xfrm: switch migrate to
xfrm_policy_lookup_bytype") in v6.12-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83317cce60a032c49480dcdabe146435bd689d03]
stable/6.12: [21e235a36cfb6d145cefb10728f12f5dc5412f54]
stable/6.18: [836ee1b0426ea3db31531e9581cc32f513d24e32]

CVE-2026-43091: xfrm: Wait for RCU readers during policy netns exit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43091

Introduced by commit e1e551b ("xfrm: policy: prepare policy_bydst hash
for rcu lookups") in v4.9-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [069daad4f2ae9c5c108131995529d5f02392c446]
stable/6.12: [438b1f668ad58f46ce699bb48e4698a7839e3f9e]
stable/6.18: [3733fce2871c9bca9dd18a1a23b1432ea215a094]
stable/6.6: [b66920a3348c0f63ba18365248fa21fbf0b3a937]

CVE-2026-43092: xsk: validate MTU against usable frame size on bind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43092

Introduced by commit 24ea501 ("xsk: support mbuf on ZC RX") in v6.6-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [36ee60b569ba0dfb6f961333b90d19ab5b323fa9]
stable/6.12: [f669d60db11dbabb96279f2b20f9d1cba43cddb2]
stable/6.18: [25e1e91a8da819924df0b16e3812d7b24c8ce133]
stable/6.6: [a55793e5a97d4e39bdb380873a9780fe0010bff6]

CVE-2026-43093: xsk: tighten UMEM headroom validation to account for
tailroom and min frame

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43093

Introduced by commit 99e3a23 ("xsk: Add missing check on user supplied
headroom size") in v5.7-rc2.
Fixed in v7.0.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [a315e022a72d95ef5f1d4e58e903cb492b0ad931]
stable/6.12: [0ec4d3f6e6934deb843b561ae048cd17218e5ad1]
stable/6.18: [9ea6ba4f3195dcba6e8b3e7b2e748593b7cafb12]
stable/6.6: [a03975beb9f6af0d8ac051e30b2abeabe618414f]

CVE-2026-43094: ixgbevf: add missing negotiate_features op to Hyper-V ops table

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43094

Introduced by commit a7075f5 ("ixgbevf: fix mailbox API compatibility
by negotiating supported features") in v6.18-rc2.
Fixed in v7.0.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [4821d563cd7f251ae728be1a6d04af82a294a5b9]
stable/6.12: [2270ebab53128fb73c4a70a292be09094074737f]
stable/6.18: [4db7b61ec1d1b2b67c0881b62fc4f9583bc21484]
stable/6.6: [d8a747057a17ffc79e31df1abb11d05e1669d8e5]

CVE-2026-43095: ASoC: SDCA: Fix errors in IRQ cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43095

Introduced by commit b126394 ("ASoC: SDCA: Generic interrupt support")
in v6.17-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e53116437e919c4b9a9d95fb73ae14fe0cfc8f9]

CVE-2026-43096: mshv: Fix infinite fault loop on permission-denied GPA
intercepts

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43096

Introduced by commit b9a66cd ("mshv: Add support for movable memory
regions") in v6.19-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [16cbec24897624051b324aa3a85859c38ca65fde]

CVE-2026-43097: PCI: hv: Fix double ida_free in hv_pci_probe error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43097

Introduced by commit bcce8c7 ("PCI: Enable host bridge emulation for
PCI_DOMAINS_GENERIC platforms") in v6.19-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b6422dff0e518245019233432b6bccfc30b73e2f]

CVE-2026-43098: nfc: s3fwrn5: allocate rx skb before consuming bytes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43098

Introduced by commit 3f52c2c ("nfc: s3fwrn5: Support a UART
interface") in v5.11-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5c14a19d5b1645cce1cb1252833d70b23635b632]
stable/6.12: [7c31f7a599cf00fad3c204092a91a924126c67e4]
stable/6.18: [6d931680a9851481c3243689488eafed08eeff71]
stable/6.6: [d8c2aa3c4a1ec530a485e46a1c4f1a118bb00156]

CVE-2026-43099: ipv4: icmp: fix null-ptr-deref in icmp_build_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43099

Introduced by commit d329ea5 ("icmp: add response to RFC 8335 PROBE
messages") in v5.13-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fde29fd9349327acc50d19a0b5f3d5a6c964dfd8]
stable/6.12: [6be325206850a0891896d38bcf83a09d8b54ec48]
stable/6.18: [f91b3ed9e7fa82a70511b5f6901c88379acf2964]
stable/6.6: [47a8bf52156ac7e7a581eca31c1f964ba4258d4d]

CVE-2026-43100: bridge: guard local VLAN-0 FDB helpers against NULL vlan group

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43100

Introduced by commit 21446c0 ("net: bridge: Introduce UAPI for
BR_BOOLOPT_FDB_LOCAL_VLAN_0") in v6.18-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1979645e1842cb7017525a61a0e0e0beb924d02a]
stable/6.18: [fb612d436ff0317659e45a91c25fd7d9516f5b1b]

CVE-2026-43101: ipv6: ioam: fix potential NULL dereferences in
__ioam6_fill_trace_data()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43101

Introduced by commit 9ee11f0 ("ipv6: ioam: Data plane support for
Pre-allocated Trace") in v5.15-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e65a8b8daa18d63255ec58964dd192c7fdd9f8b]
stable/6.18: [4198aab6f000b4febb18ea820fea20634dd789c7]

CVE-2026-43102: net: airoha: Fix memory leak in airoha_qdma_rx_process()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43102

Introduced by commit d6d2b0e ("net: airoha: Fix page recycling in
airoha_qdma_rx_process()") in v6.15.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [285fa6b1e03cff78ead0383e1b259c44b95faf90]
stable/6.18: [4429b761874fb9c7767d12d98913a467ef2654f1]

CVE-2026-43103: net: lapbether: handle NETDEV_PRE_TYPE_CHANGE

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43103

Introduced by commit 872254d ("net/bonding: Enable bonding to enslave
non ARPHRD_ETHER") in v2.6.24-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b120e4432f9f56c7103133d6a11245e617695adb]
stable/6.12: [328bb2cff5c2ed973f595ded769e15f4b7a117be]
stable/6.18: [63851f60781aa89258c8f0952cd13940aab0888e]
stable/6.6: [363a38044b8cd5b496d241651a1fb666e7c5fe3e]

CVE-2026-43104: drm/vc4: Fix a memory leak in hang state error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43104

Introduced by commit 2146136 ("drm/vc4: Add an interface for capturing
the GPU state after a hang.") in v4.5-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9525d169e5fd481538cf8c663cc5839e54f2e481]
stable/6.12: [d8fdd6adc07b78ad3e9ee0004876d90cb59ca941]
stable/6.18: [e352e9adc9f6df54d63150ff832f71c04e30744b]
stable/6.6: [dd5c49787a32da96a2b154427eb17cbf12a83c28]

CVE-2026-43105: drm/vc4: Fix memory leak of BO array in hang state

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43105

Introduced by commit 2146136 ("drm/vc4: Add an interface for capturing
the GPU state after a hang.") in v4.5-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f4dfd6847b3e5d24e336bca6057485116d17aea4]
stable/6.12: [0d3c014a84396a147705f523a8fd6fc873e76502]
stable/6.18: [421cea4f71f7cf65abaae878562ee4aa2b684628]
stable/6.6: [a812008fe3a0aebb778d277b35717f64e23d0302]

CVE-2026-43106: cachefiles: fix incorrect dentry refcount in cachefiles_cull()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43106

Introduced by commit 7bb1eb4 ("VFS: introduce
start_removing_dentry()") in v6.19-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1635c2acdde86c4f555b627aec873c8677c421ed]

CVE-2026-43107: xfrm: account XFRMA_IF_ID in aevent size calculation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43107

Introduced by commit 7e65264 ("xfrm: Add a new lookup key to match
xfrm interfaces.") in v4.19-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7081d46d32312f1a31f0e0e99c6835a394037599]
stable/6.12: [2c41283d94af943a05f7f2cc1a01f0c872f3cf43]
stable/6.18: [e62e322ea20be78e346e4b49f9a6b9f03313af4c]

CVE-2026-43108: soc: qcom: pd-mapper: Fix element length in
servreg_loc_pfr_req_ei

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43108

Introduced by commit 1ebcde0 ("soc: qcom: add pd-mapper
implementation") in v6.11-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [641f6fda143b879da1515f821ee475073678cf2a]
stable/6.12: [c93ca7c5a72e23a83a0b96f7f5c41a7a72f1dc47]
stable/6.18: [7d75145672cf2ec7c5417e3243af72c48314f7bb]

CVE-2026-43109: x86: shadow stacks: proper error handling for mmap lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43109

Introduced commit is not determined.Fixed in v7.0.
Affected code was added by 7fad2a4 ("x86/shstk: Check that signal
frame is shadow stack mem") in v6.6-rc1.

Fixed status
mainline: [52f657e34d7b21b47434d9d8b26fa7f6778b63a0]
stable/6.18: [c64cebcc5c4f223dbcbe7dcdf74908fc092a0aa4]

CVE-2026-43110: wifi: brcmfmac: validate bsscfg indices in IF events

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43110

Introduced commit is not determined.Fixed in v7.0.


Fixed status
mainline: [304950a467d83678bd0b0f46331882e2ac23b12d]
stable/6.12: [9fca68c2512a362cad258e4df12a307bb2ee4b8e]
stable/6.18: [1ae1e1caa428844e481231f6dbe9b4f475f1d52d]
stable/6.6: [3ec7437e9d11374105c2c4e47ae671537729d7e6]

CVE-2026-43111: HID: roccat: fix use-after-free in roccat_report_event

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43111

Introduced commit is not determined.Fixed in v7.0.


Fixed status
mainline: [d802d848308b35220f21a8025352f0c0aba15c12]
stable/6.12: [e16a6d11bd77b81632165f02cf0d5946df74b3b7]
stable/6.18: [36bb2d0b915014bbdc5044982b31b57b78045b93]
stable/6.6: [e6a445513fbc6a0329d2d5ff375b6725750ec5a6]

CVE-2026-43112: fs/smb/client: fix out-of-bounds read in cifs_sanitize_prepath

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43112

Introduced commit is not determined.Fixed in v7.0-rc7.
Affected code was added by a310808 ("cifs: sanitize multiple
delimiters in prepath") in v5.16-rc6.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [78ec5bf2f589ec7fd8f169394bfeca541b077317]
stable/6.12: [2d29214448ec0f4e7e18bb1c14dd4a6c07f1c439]
stable/6.18: [86f9c23e0814cfdffda9eedf0c591c51ba209010]
stable/6.6: [5d4fe469fe7dbff7d874c196bb680a82f2625d95]

CVE-2026-43113: wifi: wl1251: validate packet IDs before indexing tx_frames

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43113

Introduced commit is not determined.Fixed in v7.0-rc7.


Fixed status
mainline: [0fd56fad9c56356e7fa7a7c52e7ecbf807a44eb0]
stable/6.12: [df15adc692a802636dd3f258fc7cca8bf7a0ed9a]
stable/6.18: [8d7465be5163a923ee5d7459719ef5a021c1584a]
stable/6.6: [b6ba1eacf276063ebeefbbae8056043c24f2efaf]

CVE-2026-43114: netfilter: nft_set_pipapo_avx2: don't return
non-matching entry on expiry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43114

Introduced commit is not determined.Fixed in v7.0-rc6.
Affected code was added by 7400b06 ("nft_set_pipapo: Introduce
AVX2-based lookup implementation") in 5.7-rc1.

Fixed status
mainline: [d3c0037ffe1273fa1961e779ff6906234d6cf53c]
stable/6.12: [3d53f9aafd469ae1ea27051e00f5b96ca1b55d52]
stable/6.18: [07de44424bb7f17ef9357e8535df96d9e97c40cb]
stable/6.6: [fa4f1f52528c73989d820f32bfca06bec5afeece]

CVE-2026-43115: srcu: Use irq_work to start GP in tiny SRCU

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43115

Introduced commit is not determined.Fixed in v7.0-rc6.
Affected file was added by d8be817 ("srcu: Create a tiny SRCU") in v4.12-rc1.

Fixed status
mainline: [a6fc88b22bc8d12ad52e8412c667ec0f5bf055af]

CVE-2026-43116: netfilter: ctnetlink: ensure safe access to master conntrack

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43116

Introduced commit is not determined.Fixed in v7.0-rc6.


Fixed status
mainline: [bffcaad9afdfe45d7fc777397d3b83c1e3ebffe5]
stable/6.18: [f338ced0473849c9f6ed0b77ca99f1aab5826787]

CVE-2026-43117: btrfs: tracepoints: get correct superblock from dentry
in event btrfs_sync_file()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43117

Introduced commit is not determined.Fixed in v7.0-rc6.


Fixed status
mainline: [a85b46db143fda5869e7d8df8f258ccef5fa1719]
stable/6.12: [32372781d664a9b03c40343e96c29d0a6139f97d]
stable/6.18: [2e4adfaec97ee053ad1bdfb5036845e66f7e0d8a]
stable/6.6: [c09a7446aab5773f38d6abb25fce99b8e1dfbc97]

CVE-2026-43118: btrfs: fix zero size inode with non-zero size after log replay

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43118

Introduced commit is not determined.Fixed in v7.0-rc6.


Fixed status
mainline: [5254d4181add9dfaa5e3519edd71cc8f752b2f85]
stable/6.18: [fddb157536e67a055597f00a8b4922d5f5ed0826]

CVE-2026-43119: Bluetooth: hci_sync: annotate data-races around hdev->req_status

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43119

Introduced commit is not determined.Fixed in v7.0-rc6.


Fixed status
mainline: [b6807cfc195ef99e1ac37b2e1e60df40295daa8c]
stable/6.12: [6e539907c0d11f514c5e0b049b27b04dff48a5b1]
stable/6.18: [a7a1cdb4a64ca74eb95cc46648fccb8cd3f9af27]

CVE-2026-43120: RDMA/irdma: Fix double free related to rereg_user_mr

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43120

Introduced commit is not determined.Fixed in v7.0-rc6.
Affected code was added by 5ac388d ("RDMA/irdma: Add support to
re-register a memory region") in v6.7-rc1.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [29a3edd7004bb635d299fb9bc6f0ea4ef13ed5a2]
stable/6.12: [66964118f1f50ed85001c8fc9f7ab5bbdd021ee0]
stable/6.18: [0f22c32141acdcda266b26cab2b830baf870f3e0]
stable/6.6: [62298a48f8b8788ad8b8464e6ffdf1ddebd2217e]

CVE-2026-43121: io_uring/zcrx: fix user_ref race between scrub and refill paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43121

Introduced by commit 34a3e60 ("io_uring/zcrx: implement zerocopy
receive pp memory provider") in v6.15-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [003049b1c4fb8aabb93febb7d1e49004f6ad653b]
stable/6.18: [a94f096e28bfc7975163a6b80f1c8f323efe317a]

CVE-2026-43122: ACPI: processor: Update cpuidle driver check in
__acpi_processor_start()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43122

Introduced by commit 7a8c994 ("ACPI: processor: idle: Optimize ACPI
idle driver registration") in v6.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0089ce1c056aee547115bdc25c223f8f88c08498]
stable/6.18: [68f38f648e4b5bed2aeadd2f711e25302e6490f8]

CVE-2026-43123: fbcon: check return value of con2fb_acquire_newinfo()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43123

Introduced by commit d1baa4f ("fbcon: set_con2fb_map fixes") in v2.6.23-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [011a0502801c8536f64141a2b61362c14f456544]
stable/5.15: [d3e535533767c85788529e626478718b7e95a59f]
stable/6.1: [3b5a754ec86bc6064af9aca76eb191c2405e6b0c]
stable/6.12: [0b038c0be6827dd2dbb1ce4f8d92d97c80cbe9cc]
stable/6.18: [11a93180a70bb3095a9bd80d113d9277e30d9959]
stable/6.6: [a785c4e2a999c2d51dfcf40d317cfb30cc735d2c]

CVE-2026-43124: pstore: ram_core: fix incorrect success return when vmap() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43124

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
cip/4.19-st: [eaeeb2132cefa1e0737d57a13c29cc66616cf352]
cip/4.4-st: [65dea3589dca177009d6030b9dc08ee009aa1294]
mainline: [05363abc7625cf18c96e67f50673cd07f11da5e9]
stable/5.10: [d47234840aeb4182ed3ee795c578b1dfa9cbd25b]
stable/5.15: [49918dd52615097529811d21ec6074dd02ebe77c]
stable/6.1: [8baa234181f632cabacf73e4834a910859e9fcc9]
stable/6.12: [8d849adfbc3e98417fb541620568db1a759ef441]
stable/6.18: [2c99326dc1c79b7ce3c8dd92929b5ce724ff70eb]
stable/6.6: [1da904e84de608907662ad8a51ba9c571d61e003]

CVE-2026-43125: dlm: validate length in dlm_search_rsb_tree

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43125

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [080e5563f878c64e697b89e7439d730d0daad882]
stable/6.12: [67288113c5e6cf9e659b4065c0ed6f16100e0c71]
stable/6.18: [082083c9fbd99422a0370fe2102144a231c9f5d6]

CVE-2026-43126: ALSA: mixer: oss: Add card disconnect checkpoints

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43126

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [084d5d44418148662365eced3e126ad1a81ee3e2]
stable/6.12: [ae583f113d15fa97e5234133c20d09f8e6214e47]
stable/6.18: [e6645e625480cdf1079a4265f758d13b70721029]

CVE-2026-43127: ntfs3: fix circular locking dependency in run_unpack_ex

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43127

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected file was added by 4342306 ("fs/ntfs3: Add file operations and
implementation") in v5.15-rc1.

Fixed status
mainline: [08ce2fee1b869ecbfbd94e0eb2630e52203a2e03]
stable/6.18: [b014372b62237521444ee51384549bdf48b79015]

CVE-2026-43128: RDMA/umem: Fix double dma_buf_unpin in failure path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43128

Introduced by commit 1e4df4a ("RDMA/umem: Allow pinned dmabuf umem
usage") in v5.16-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [104016eb671e19709721c1b0048dd912dc2e96be]
stable/6.1: [70542b69abff34d24b11ae0bb200cc7a766d18df]
stable/6.12: [ba3bf0f1bf1d5d0404678485e872980532fcc2c4]
stable/6.18: [d3e32e2f3262f1b25d77c085ace38e2cc4ad75cf]
stable/6.6: [b324327ff6f48d8065dca67eb3b91357e72726bd]

CVE-2026-43129: ima: verify the previous kernel's IMA buffer lies in
addressable RAM

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43129

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected file was added by 94c3aac ("ima: on soft reboot, restore the
measurement list") in v4.10-rc1.

Fixed status
mainline: [10d1c75ed4382a8e79874379caa2ead8952734f9]
stable/6.12: [f11d7d088f5ed54b31c6735854c12845eb60eb4a]
stable/6.18: [9e1f51c1ad57cc76a0e8b5eb27038f8973fff4fa]

CVE-2026-43130: iommu/vt-d: Flush dev-IOTLB only when PCIe device is
accessible in scalable mode

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43130

Introduced by commit 4fc82cd ("iommu/vt-d: Don't issue ATS
Invalidation request when device is disconnected") in v6.9-rc1.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [10e60d87813989e20eac1f3eda30b3bae461e7f9]
stable/5.10: [581ce094d9eafb78ec4f9de77bd24b780c151236]
stable/5.15: [e2c78c69f8faf2885ea4ceee08c71ac738f401a0]
stable/6.1: [ead67d0378e90f419e385a43af29435242d80c12]
stable/6.12: [9813306610d0d718c863aaa70928bf57d7570ec0]
stable/6.18: [9deaacc8dcaddb6ddc5b52e1e63b457450ec0f94]
stable/6.6: [01aed2f1d7cb8fdf4c60c5bb4727608cb82b401d]

CVE-2026-43131: drm/amd/pm: Fix null pointer dereference issue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43131

Introduced commit is not determined.Fixed in v7.0-rc1.
Affeced code was added by 80e462c ("drm/amd/pm: export a function
amdgpu_smu_ras_send_msg to allow send msg directly") in v6.19-rc1.

Fixed status
mainline: [1197366cca89a4c44c541ddedb8ce8bf0757993d]

CVE-2026-43132: dm-verity: correctly handle dm_bufio_client_create() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43132

Introduced by commit a739ff3 ("dm verity: add support for forward
error correction") in v4.5-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [be799cafdfeb97b1290fd77ab55bcac248106e0a]
mainline: [119f4f04186fa4f33ee6bd39af145cdaff1ff17f]
stable/5.10: [6283e49af87a9c121bb01e5a64a7fe5706c210bc]
stable/5.15: [d3e1f1adc8a0289efe2d2cdc90edb8c6ffe0b5ef]
stable/6.1: [5c2217ddb3b7e7ac25f4ebe9061258fc8f1c9167]
stable/6.12: [9b8dc1d327e2928f3da59ced0595d850d31c0936]
stable/6.18: [451cc650e40e8c3222d37877a9e4be0fcaacb9c8]
stable/6.6: [031f2adc1499b112a39ac316bbab3c80bba16cf2]

CVE-2026-43133: KVM: nSVM: Always use vmcb01 in VMLOAD/VMSAVE emulation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43133

Introduced by commit cc3ed80 ("KVM: nSVM: always use vmcb01 to for
vmsave/vmload of guest state") in v5.13-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [127ccae2c185f62e6ecb4bf24f9cb307e9b9c619]
stable/5.15: [10063e1251c1485034a018236080792ad083dcc5]
stable/6.1: [c3b7015000988ba35ecd5648f4b2283960f00543]
stable/6.12: [fce2fd4a2ca05670a91015aacccf96a1c26268fd]
stable/6.18: [d464cf1ed900d47c85393d40b00017b6adfc2e6c]
stable/6.6: [3880e331b0b31d0d5d3702b124f6c93539cd478a]

CVE-2026-43134: Bluetooth: L2CAP: Fix missing key size check for
L2CAP_LE_CONN_REQ

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43134

Introduced by commit 27e2d4c ("Bluetooth: Add basic LE L2CAP connect
request receiving support") in v3.14-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [7f6a2970bccd1aeab1689fc99093ac9c7b60b2db]
cip/4.4-st: [3b5767ddcc368b7057e9649c854980e44831a7d0]
mainline: [138d7eca445ef37a0333425d269ee59900ca1104]
stable/5.10: [335071c0c3637064ec250481f589075db44fe4e6]
stable/5.15: [fa6ad76fa8623c0a50d529cd5726fa5d819a3be4]
stable/6.1: [9118601ff90b79e8df3c0c98f48ae00c1b02ecef]
stable/6.12: [ec91078e132179b04e0c3906b599816c056ceaad]
stable/6.18: [96581749c7c14fbec32c35728520867929600041]
stable/6.6: [481ea39b342c347b6ac029f3d418486280be4e45]

CVE-2026-43135: media: cx23885: Add missing unmap in snd_cx23885_hw_params()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43135

Introduced by commit 9529a4b ("[media] cx23885: drop videobuf abuse in
cx23885-alsa") in v3.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [0689c345af1dc42d7b5fedb5f1ca6ae9661ac5b3]
cip/4.4-st: [a93c3370770d46e3e73b97e72e4e5f88a4d122af]
mainline: [141c81849fab2ad4d6e3fdaff7cbaa873e8b5eb2]
stable/5.10: [fda46c9025b755ea50a969b960f333be62421b71]
stable/5.15: [0b7f56084cc3d7766bf274b71cd14cc9674b76bf]
stable/6.1: [505630dd1ebf4b53d3f2866c057ddd93157a24d8]
stable/6.12: [9c0a6ff538660c36a98081916a24f08d55a91331]
stable/6.18: [9544b73cad4ee667fed6a60f71570c58a870a735]
stable/6.6: [544215cc37d032ccaf1919852c05e2439a4d7540]

CVE-2026-43136: HID: logitech-hidpp: Check maxfield in hidpp_get_report_length()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43136

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected code was added by d71b18f ("HID: logitech-hidpp: do not
hardcode very long report length") in v5.2-rc1.

Fixed status
mainline: [1547d41f9f19d691c2c9ce4c29f746297baef9e9]
stable/5.10: [ae81fac9ce81917817d787e6b74e68482d99bdf2]
stable/5.15: [2dc023dbc11b8dfa8afa63242762acd8cddcad03]
stable/6.1: [7f59999fcd699af06ad2aef446a635ea6aa87db3]
stable/6.12: [f1ceaaf93ea32d0f2b95c95f784ee155962c52ad]
stable/6.18: [1acb28123e57b50d737377f400f57eec889fe5e4]
stable/6.6: [b74bf7d0d01fa9b53653f58c29aa00772121f6e9]

CVE-2026-43137: ASoC: SOF: Intel: hda: Fix NULL pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43137

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected code was added by 80afde3 ("ASoC: SOF: Intel: hda-dai: Define
and set the HDA DAI widget DMA ops") in v6.4-rc1.

Fixed status
mainline: [16c589567a956d46a7c1363af3f64de3d420af20]
stable/6.12: [10411f1f2c76be67103b1f95822ff629aa25e2aa]
stable/6.18: [42068f7dd42b559c4eeae645e1455ff36518866a]

CVE-2026-43138: reset: gpio: suppress bind attributes in sysfs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43138

Introduced by commit cee544a ("reset: gpio: Add GPIO-based reset
controller") in v6.9-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [16de4c6a8fe9ff497ca1aba33ef0dbee09f11952]
stable/6.12: [09d6efc6abd42809956d598906c222ccd1c8ae92]
stable/6.18: [76801c3dfca0ac6339a23e9615b5f23e25b8644c]

CVE-2026-43139: xfrm6: fix uninitialized saddr in xfrm6_get_saddr()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43139

Introduced by commit a1e59ab ("[XFRM]: Fix wildcard as tunnel source")
in v2.6.20.16.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [35f3dec30c90e41b4f0de363a44a2e1d3e2935f5]
cip/4.4-st: [6493a55c1178bda905641034f02424e05980b568]
mainline: [1799d8abeabc68ec05679292aaf6cba93b343c05]
stable/5.10: [4f28141786e1fe884ce42a5197ba9beed540f0ea]
stable/5.15: [6535867673bf301d52aa00593a4d1d18cc3922fa]
stable/6.1: [eb2ee15290af14c60b45cf2b73f5687d1d077d9b]
stable/6.12: [dc0abce055134cb83b0d981d31ceb20dda419787]
stable/6.18: [c7221e7bd8fc2ef38a0b27be580d9d202281306b]
stable/6.6: [719918fc88df6da023dfff370cd965151a5afd7f]

CVE-2026-43140: HID: magicmouse: Do not crash on missing msc->input

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43140

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
cip/4.19-st: [f57ed48230ddc0fd6093dea8ec0142e8c628de66]
cip/4.4-st: [148053a991d8383f403146e1c3c62533ba5ee770]
mainline: [17abd396548035fbd6179ee1a431bd75d49676a7]
stable/5.10: [db5ba06e7af9325519a03e52fccf4a9e7c1fd9b2]
stable/5.15: [165912d4321c692321c02793068d30700b4e0f1a]
stable/6.1: [f6a3860241fbb556fd72332fa31c5e787004413b]
stable/6.12: [922bd3e498a4b8e445def6e6ffea2ad3682ad516]
stable/6.18: [5bbe266272d86c0657e8253600f3d5b74fb7b2ae]
stable/6.6: [243e1165eb03aca97d87aafa9c3130593837a1c2]

CVE-2026-43141: ntb: ntb_hw_switchtec: Fix shift-out-of-bounds for 0 mw lut

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43141

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected code was added by ec0467c ("NTB: switchtec_ntb: Initialize
hardware for memory windows") in v4.15-rc1.

Fixed status
cip/4.19-st: [a6ca50ecb631f8870ba5a1fea3fab04ef44ce814]
mainline: [186615f8855a0be4ee7d3fcd09a8ecc10e783b08]
stable/5.10: [d652ef399f131fcd5f8f34266167449ee7c9e5b3]
stable/5.15: [5590cd04d6845c01a6bad985a491c58af6fb5389]
stable/6.1: [a11d03d116eef138a7249202bd772c8e61915aec]
stable/6.12: [2e4d5e8d86a969318340be95470bb76e52392082]
stable/6.18: [a133e3caf844a3f56b6eef89ddaa66115874f6bd]
stable/6.6: [d0559d07afabfddaaded6a61a16154486b956764]

CVE-2026-43142: media: iris: gen1: Destroy internal buffers after FW releases

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43142

Introduced by commit 73702f4 ("media: iris: allocate, initialize and
queue internal buffers") in v6.15-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1dabf00ee206eceb0f08a1fe5d1ce635f9064338]
stable/6.18: [7cde76db8883ec8a3d1456068079ecadbfb15ca5]

CVE-2026-43143: mfd: core: Add locking around 'mfd_of_node_list'

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43143

Introduced by commit 466a62d ("mfd: core: Make a best effort attempt
to match devices with the correct of_nodes") in v5.9-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [20117c92bcf9c11afd64d7481d8f94fdf410726e]
stable/6.1: [dcfa679bba02412f2087be21cf06ae88b1f4e0ef]
stable/6.12: [db131ef9d8980cf60dcac8cf94c036eccf75e5d0]
stable/6.18: [9b02e3fec3a7fcb990b4d3bd3b13d7edf123dca6]
stable/6.6: [e2e7c275f557e2b75e3128f4818063798248774c]

CVE-2026-43144: wifi: brcmfmac: Fix potential kernel oops when probe fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43144

Introduced by commit 0ff0843 ("wifi: brcmfmac: Add optional lpo clock
enable support") in v6.13-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [243307a0d1b0d01538e202c00454c28b21d4432e]
stable/6.18: [64ccb0aac41c5055780c2a58bbe2c1b362ceccde]

CVE-2026-43145: remoteproc: imx_rproc: Fix invalid loaded resource
table detection

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43145

Introduced by commit e954a1b ("remoteproc: imx_rproc: Use imx specific
hook for find_loaded_rsc_table") in v6.12-rc1.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [26aa5295010ffaebcf8f1991c53fa7cf2ee1b20d]
stable/5.15: [91baf24d972ea3c04a75dd18821c03d223c0dbc0]
stable/6.1: [fcec79b6a3649ae7b1f659267602ca402c240d6e]
stable/6.12: [65379adf7d231c930572db45933ff4538f4c5128]
stable/6.18: [500778df9e4c313190368908ff40c23948508e97]
stable/6.6: [9bd98d088f47153a81a6ec8162b4415c64aa7f39]

CVE-2026-43146: media: iris: Add buffer to list only after successful allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43146

Introduced by commit 73702f4 ("media: iris: allocate, initialize and
queue internal buffers") in v6.15-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d0bbd982dfdd67da488a772f7a8a1bdca7642bf]
stable/6.18: [45b30f65feeb4d5570d5337793bb0f298be813d2]

CVE-2026-43147: Revert "PCI/IOV: Add PCI rescan-remove locking when
enabling/disabling SR-IOV"

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43147

Introduced by commit 0570327 ("PCI/IOV: Add PCI rescan-remove locking
when enabling/disabling SR-IOV") in v6.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [2fa119c0e5e528453ebae9e70740e8d2d8c0ed5a]
stable/5.10: [f61cdd7e9b67bb8961b0a81bf294b78343e5db05]
stable/5.15: [0de341b2365bad430aade0853fe09c2cbe468f59]
stable/6.1: [83651d37474c762920e345a3a0828f975ca4d732]
stable/6.12: [d47f27e145f8bd13f3c230da5e3af29225b4a2f7]
stable/6.18: [40f67686a5002c0c322fac918406bbc8d9c2ec2f]
stable/6.6: [639265296fe6ee21b6f00e00ee2bab65f3b07252]

CVE-2026-43148: powerpc/smp: Add check for kcalloc() failure in
parse_thread_groups()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43148

Introduced by commit 790a166 ("powerpc/smp: Parse ibm,thread-groups
with multiple properties") in v5.11-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [33c1c6d8a28a2761ac74b0380b2563cf546c2a3a]
stable/5.15: [1de31dba19c3cd0c1caf388a286b46df638f0b91]
stable/6.1: [b265e53d9adfbb5751713185843f7188aa9dd066]
stable/6.12: [ca46d2092f307385a7acfb42632056570d6dbbbc]
stable/6.18: [9b85c8f624b0f8cf9b932f5a65dacd56a1f47a72]
stable/6.6: [9d0ca11258e7b452653d04310addfec1753de1a2]

CVE-2026-43149: net: wan/fsl_ucc_hdlc: Fix dma_free_coherent() in
uhdlc_memclean()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43149

Introduced by commit c19b6d2 ("drivers/net: support hdlc function for
QE-UCC") in v4.8-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f29bd1ed61ef8e88bc9297b1fc3751605a0ceaee]
mainline: [36bd7d5deef936c4e1e3cd341598140e5c14c1d3]
stable/5.10: [6496fb830cbb741d831225cc4e7e5601c6e42970]
stable/5.15: [ba8d8429e5d6c36f9a654d2b96b9e043c43d92b4]
stable/6.1: [011ae5dd84dc9f05eb9b8e1adff44252ac776e7b]
stable/6.12: [84b932bc9899d43e5829e6cf088b72d73a922b2b]
stable/6.18: [d8a522085d09b30aba1016daf1dddac37c0f0285]
stable/6.6: [0f85a9655445e67bb0238cfc983d7c383b54938e]

CVE-2026-43150: perf/arm-cmn: Reject unsupported hardware configurations

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43150

Introduced by commit 7819e05 ("perf/arm-cmn: Revamp model detection")
in v6.5-rc1.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [36c0de02575ce59dfd879eb4ef63d53a68bbf9ce]
stable/6.1: [7e2c200010aa93fa78201da959b4ac6b9f8fed0b]
stable/6.12: [00d69f21ef2ab00e6156c764d89e2b3539eb2f33]
stable/6.18: [08c7eadd8a934a1968e1aeeee8b61b853b99fb3a]
stable/6.6: [d3e837e11ee9ed08df229272319199003ba00379]

CVE-2026-43151: Revert "media: iris: Add sanity check for stop streaming"

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43151

Introduced by commit ad699fa ("media: iris: Add sanity check for stop
streaming") in v6.19-rc1.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [370e19042fb8ac68109f8bdb0fdd8118baf39318]
stable/6.18: [bd4f8fa216182f33c06d4c1e162975a0c42fb14e]

CVE-2026-43152: HID: hid-pl: handle probe errors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43152

Introduced by commit 20eb127 ("hid: force feedback driver for
PantherLord USB/PS2 2in1 Adapter") in v2.6.21-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [ddd2c509710813a70b7bb290d557b33a5fe5c0f5]
cip/4.4-st: [7c2043307626420d88bc4336afa92d7ffecbcbc0]
mainline: [3756a272d2cf356d2203da8474d173257f5f8521]
stable/5.10: [78df3de826668fe842c6061a91bc1ed68f493e80]
stable/5.15: [8a84149337eb5e716e6d59f48ff0374dae8d8b2b]
stable/6.1: [926e6715b48b575ed7754bf163a67686bb2eb111]
stable/6.12: [04e50f45b5175bb90a06f5003113cb4ed6ba44c2]
stable/6.18: [1d46d07458dba369daf61fb643d40a62c8423d8e]
stable/6.6: [449004434e1f55be85604b2645f2d07c4a92fe53]

CVE-2026-43153: xfs: remove xfs_attr_leaf_hasname

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43153

Introduced by commit 07120f1 ("xfs: Add xfs_has_attr and subroutines")
in v5.9-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a65ea768b8094e4699e72f9ab420eb9e0f3f568]
stable/6.12: [2fbc8421d1db102c0e5458607e042a23a03648b1]
stable/6.18: [457121c01f609b9934addbb04d5c1ef638c71c61]

CVE-2026-43154: erofs: fix incorrect early exits in volume label handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43154

Introduced by commit 1cf12c7 ("erofs: Add support for
FS_IOC_GETFSLABEL") in v6.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3afa4da38802a4cba1c23848a32284e7e57b831b]
stable/6.18: [8d8a878ef60801d867119b3df6a93e2982d62a71]

CVE-2026-43155: mux: mmio: fix regmap leak on probe failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43155

Introduced by commit 61de83f ("mux: mmio: Do not use syscon helper to
build regmap") in v6.16-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c4ae63073d84abee5d81ce46d86a94e9dae9c89]
stable/6.18: [76096f156fe9dc9fbd6e4618088706e91b9b0a6c]

CVE-2026-43156: net: usb: pegasus: enable basic endpoint checking

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43156

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [16e0860e8d33fce42176b5569897bfbc7ffdeea9]
cip/4.4-st: [669d98a4938de5aaa645102d2b3a3093e499585c]
mainline: [3d7e6ce34f4fcc7083510c28b17a7c36462a25d4]
stable/5.10: [a3e64e950a3981a8199de9798f6d21261b959171]
stable/5.15: [229dc9b9db475ac900182bafe258943e0e054c6d]
stable/6.1: [26b3ec62fa1a94ac801feca47f040fc729b3c174]
stable/6.12: [67ba6b13dbcaf45681fb6758794c5ac5fa589a6c]
stable/6.18: [d2e7c898cc02dfe42443489a67a45ed616cb76e9]
stable/6.6: [35854ed5c40b02f95824e44398f9d2ba33727203]

CVE-2026-43157: octeontx2-af: CGX: fix bitmap leaks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43157

Introduced by commit e740003 ("octeontx2-af: Flow control resource
management") in v5.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3def995c4ede842adf509c410e92d09a0cedc965]
stable/6.1: [ad8a13a45c5c24d0d32de9a1c3fd58498a675ece]
stable/6.12: [ccef79af58b43787c25710c9da96651c6ddfe50f]
stable/6.18: [6d389382ee655128056fbdab86baad8495ffbf33]
stable/6.6: [013ac469596a0b8671e62d89c89ae0bd46bbe667]

CVE-2026-43158: xfs: fix freemap adjustments when adding xattrs to leaf blocks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43158

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [fc63b764bdb94e552409e7dbd3ffa1cbbf175390]
cip/4.4-st: [7607a3427facbdc78cf53791165e802f6fe343aa]
mainline: [3eefc0c2b78444b64feeb3783c017d6adc3cd3ce]
stable/5.10: [d08976725355b9d54d8332fce223fa281cc304a5]
stable/5.15: [6a8737afbccc340e718e0b22577312826390be8b]
stable/6.1: [a396b3d73d51355e50acdb403ba9c4cae4c1174e]
stable/6.12: [ef42a8766ff3fdf51cf72fb36d0859c09d134478]
stable/6.18: [43f3b18679615a93bd848afde3602ba160637a46]
stable/6.6: [38613c01f69e1e77e6b8acab1e8ac665d01c2f15]

CVE-2026-43159: staging: rtl8723bs: fix null dereference in find_network

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43159

Introduced by commit 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in v4.12-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [41460a19654c32d39fd0e3a3671cd8d4b7b8479f]
stable/5.10: [3b1d0c9a1f78836d0bce6fdd37f596f22c19b03e]
stable/5.15: [1aa9c59f4b96a9056c02476c7ca89e96d15e0645]
stable/6.1: [48b4dec3a8bfd667cd0cd767eaf511176193e9a1]
stable/6.12: [04d24a3654ed195485bc6346a9ef326fc494a34e]
stable/6.18: [677490a6bd4c63acdf6f48e4aaf6a23d7e6a446f]
stable/6.6: [cc3f83b6fb3773ad943365d1cd774b4ec050332e]

CVE-2026-43160: mfd: macsmc: Initialize mutex

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43160

Introduced by commit e038d98 ("mfd: Add Apple Silicon System
Management Controller") in v6.17-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [414f65d6736342c77d4ec5e7373039f4a09250dd]
stable/6.18: [a1e9e299c0d9ea42ab1067b39fb72e976d3f1bdb]

CVE-2026-43161: iommu/vt-d: Skip dev-iotlb flush for inaccessible PCIe
device without scalable mode

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43161

Introduced by commit 37764b9 ("iommu/vt-d: Global devTLB flush when
present context entry changed") in v5.14-rc2.
Introduced by commit 81e921f ("iommu/vt-d: Fix NULL domain on device
release") in v6.9-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [42662d19839f34735b718129ea200e3734b07e50]
stable/6.12: [48b3f08e68b29a79527869cdde7298ca2a9b9646]
stable/6.18: [e70d5feb10c5ba2bbf7ca400b8f39a2f82d653e8]

CVE-2026-43162: media: tegra-video: Fix memory leak in
__tegra_channel_try_format()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43162

Introduced by commit 56f64b8 ("media: tegra-video: Use zero crop
settings if subdev has no get_selection") in v5.12-rc1.
Introduced by commit 1ebaeb0 ("media: tegra-video: Add support for
external sensor capture") in v5.10-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [43e5302d22334f1183dec3e0d5d8007eefe2817c]
stable/6.1: [6c6f419fa9c44a4b7149b0292e01bff47308ba14]
stable/6.12: [3ca2f09061736e72ef25eec2597d00f7f44094d3]
stable/6.18: [2dff8966a3a889dd9d248a7e15d963b4097efcc5]
stable/6.6: [ca921be7a1174d5d58b28f84b683c2c0079f18c5]

CVE-2026-43163: md/bitmap: fix GPF in write_page caused by resize race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43163

Introduced by commit d60b479 ("md/bitmap: add bitmap_resize function
to allow bitmap resizing.") in v3.5-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [5fd88f46ca7084af730a2f8b9a4e0a416d52f6ca]
mainline: [46ef85f854dfa9d5226b3c1c46493d79556c9589]
stable/5.10: [140cc839fbeb1ddb33a8da8811b716d88d3905b7]
stable/5.15: [ebcacc7ca22d5e8a03a970f0621ae1d1356b9ae8]
stable/6.1: [d3af62411e19752c663fe4f424dbf49d95a4cc7c]
stable/6.12: [a437e3bf30e32846079e470c1ba5ee790bccdf89]
stable/6.18: [9a6f8cd28bb9bb6ed86a6df19331fb08016dee7f]
stable/6.6: [d92b8fac294b5f915c50e65ce4ae2262e53614ec]

CVE-2026-43164: udplite: Fix null-ptr-deref in __udp_enqueue_schedule_skb().

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43164

Introduced by commit b650bf0 ("udp: remove busylock and add per NUMA
queues") in v6.18-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [470c7ca2b4c3e3a51feeb952b7f97a775b5c49cd]
stable/6.18: [f27030ac5bef47d997cfac05a3d188aa69f4df7f]

CVE-2026-43165: hwmon: (nct7363) Fix a resource leak in
nct7363_present_pwm_fanin

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43165

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected code was added by 46b94c4 ("hwmon: Add driver for I2C chip
Nuvoton NCT7363Y") in v6.13-rc1.

Fixed status
mainline: [4923bbff0bcffe488b3aa76829c829bd15b02585]
stable/6.18: [c8cde3ddd12ad7d0e6b5a3e0ea3914a9a778adf4]

CVE-2026-43166: erofs: fix interlaced plain identification for encoded extents

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43166

Introduced by commit 1d191b4 ("erofs: implement encoded extent
metadata") in v6.15-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a2d046e4b13202a6301a993961f5b30ae4d7119]
stable/6.18: [9d5a97bc71ed5783687705c708454c4453aa91d1]

CVE-2026-43167: xfrm: always flush state and policy upon NETDEV_UNREGISTER event

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43167

Introduced by commit d77e38e ("xfrm: Add an IPsec hardware offloading
API") in v4.12-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4efa91a28576054aae0e6dad9cba8fed8293aef8]
stable/6.12: [a3c8fede034fa27892f87c863cbd5493167d17ed]
stable/6.18: [59581778792cbaf8ad788f4a21dc663ce986050e]
stable/6.6: [166801e49a5b5fc127b8c9e2f110f303cfddfbc3]

CVE-2026-43168: ocfs2: fix reflink preserve cleanup issue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43168

Introduced by commit 0fe9b66 ("ocfs2: Add preserve to reflink.") in v2.6.32-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [ba34e08ef04b1c8218079bc1554d464f9898839e]
cip/4.4-st: [88dba9b7ac2696cce72a7235fa271bdc9db19780]
mainline: [5138c936c2c82c9be8883921854bc6f7e1177d8c]
stable/5.10: [c44d86ca949cb1e5566ad14510cc26fa1a17e2d8]
stable/5.15: [02acc9f72365e50eb45a56b7dacb9114ca3b503c]
stable/6.1: [8ff329353134280b203cb2bce95311cb8f7cbd8a]
stable/6.12: [b2952dbeac2c3c527cb0519d5ffaeb95b062466a]
stable/6.18: [3bdc3766aafb052aef4baadef455a84c1c0a059d]
stable/6.6: [bb273b68c1719c2925e05557f7e7099edb066680]

CVE-2026-43169: drm/buddy: Prevent BUG_ON by validating rounded allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43169

Introduced by commit 0a1844b ("drm/buddy: Improve contiguous memory
allocation") in v6.7-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5488a29596cdba93a60a79398dc9b69d5bdadf92]
stable/6.12: [d764b8dd420098a4d253b8a5b27568c897edb2cf]
stable/6.18: [6236c1cd9fdf433d39ed28b2491ccdfe7ae95061]

CVE-2026-43170: usb: dwc3: gadget: Move vbus draw to workqueue context

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43170

Introduced by commit 99288de ("usb: dwc3: add an alternate path in
vbus_draw callback") in v5.13-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [54aaa3b387c2f580a99dc86a9cc2eb6dfaf599a7]
stable/6.12: [a7a80c25b65112768eeba58a7af129d3c52a6d90]
stable/6.18: [2333653ef854c2cc124077f71a8526f03bf6e06a]
stable/6.6: [76c1123ffccfaba95cf4ecc2a50f95504a522424]

CVE-2026-43171: EFI/CPER: don't dump the entire memory region

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43171

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected code was added by 3d8c11e ("efi: cper: Add support for
printing Firmware Error Record Reference") in v5.7-rc1.

Fixed status
mainline: [55cc6fe5716f678f06bcb95140882dfa684464ec]
stable/5.10: [02de64ab54b4bb0f1b21bb324aeff3b08612be33]
stable/5.15: [0e09b522f2622841389c3b2f9ac4969e35c0809d]
stable/6.1: [64ae5aaa7ac93c83da456039e8ec747bfa8a7cff]
stable/6.12: [7780c0bad2a3a70a8c0113a33c02f4151d901eb3]
stable/6.18: [a8419f5f2c5f2d80848ddabb2b95cf0da84a5f91]
stable/6.6: [5a9b1dda8481b82851a655c3bcc5b44879b95334]

CVE-2026-43172: wifi: iwlwifi: fix 22000 series SMEM parsing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43172

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected file was added by d0b813f ("iwlwifi: refactor shared mem
parsing") in v4.14-rc1.

Fixed status
mainline: [58192b9ce09b0f0f86e2036683bd542130b91a98]
stable/6.18: [1d49a42717bdc8de77eabeb5b7d3e88d141ffea9]

CVE-2026-43173: net: ethernet: xscale: Check for PTP support properly

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43173

Introduced by commit 9055a2f ("ixp4xx_eth: make ptp support a platform
driver") in v5.15-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [594163ea88a03bdb412063af50fc7177ef3cbeae]
stable/5.15: [144dde3146985b25fa84d4e4b7c3d11e0f5fc5a4]
stable/6.1: [5195b10c34b8993194ad12ad7d8f54d861be084b]
stable/6.12: [21d1e80d0d6e7d0c3cd8b1e001ed1fa92fb9f3f5]
stable/6.18: [2d74412dfd3621552a394d55cc3dd26a7cbf608e]
stable/6.6: [322437972f0a712767f6920ad34aba25f2e9b942]

CVE-2026-43174: io_uring/zcrx: fix post open error handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43174

Introduced by commit e0793de ("io_uring/zcrx: set pp memory provider
for an rx queue") in v6.15-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d540e4508950c674d6feef1d95463d039bbf4f5]

CVE-2026-43175: clk: rs9: Reserve 8 struct clk_hw slots for for 9FGV0841

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43175

Introduced by commit f0e5e18 ("clk: rs9: Add support for 9FGV0841") in v6.8-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ec820fc28d0b8a0f3890d476b1976f20e8343cc]
stable/6.12: [2f926875dffe2226ea26d129e16d9092cccd03aa]
stable/6.18: [da86ca15d7389ee0b5df08e8f70c39354e6b8a4b]

CVE-2026-43176: wifi: rtw89: pci: validate release report content
before using for RTL8922DE

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43176

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected file was added by e3ec701 ("rtw89: add Realtek 802.11ax
driver") in v5.16-rc1.

Fixed status
mainline: [5f93d611b33a05bd03d6843c8efe8cb6a1992620]
stable/6.18: [ebeaa3b24ba568ff8505165f954dba15cc53e4b3]

CVE-2026-43177: media: ipu6: Fix RPM reference leak in probe error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43177

Introduced by commit 25fedc0 ("media: intel/ipu6: add Intel IPU6 PCI
device driver") in v6.10-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6099f78e4c9223f4de4169d2fd1cded01279da1a]
stable/6.12: [fdc06d36dab7b28c2bdd16cb7ee4f25e0f55d9ac]
stable/6.18: [364759ccc3fb49754758c585c530407f96683030]

CVE-2026-43178: procfs: fix possible double mmput() in do_procmap_query()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43178

Introduced by commit b5cbacd ("procfs: avoid fetching build ID while
holding VMA lock") in v6.19.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18

Fixed status
mainline: [61dc9f776705d6db6847c101b98fa4f0e9eb6fa3]
stable/6.12: [f9fe092084cd04deea18747f58a2304026e76aaa]
stable/6.18: [8adaff87db143583e08eec4f4e7788f1ef8af94d]

CVE-2026-43179: erofs: fix incorrect early exits for invalid
metabox-enabled images

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43179

Introduced by commit 4140913 ("erofs: implement metadata compression")
in v6.17-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [643575d5a4f24b23b0c54aa20aa74a4abed8ff5e]
stable/6.18: [041b5163bb9b2e81050bcd885b3373bf2f42d5f5]

CVE-2026-43180: net: usb: kaweth: remove TX queue manipulation in
kaweth_set_rx_mode

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43180

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [305c4f158d8af4068d16574ee6230afd04870221]
cip/4.4-st: [5a8c2b99e83e619866394571c7e64a2e36823d07]
mainline: [64868f5ecadeb359a49bc4485bfa7c497047f13a]
stable/5.10: [443a830b1dc4f85c7560da59d4494b629feee215]
stable/5.15: [586318c2730433184c6f1d21183e346ddf25e81d]
stable/6.1: [a2cd4b4db315a845a5603d08c9d03b11ddfc799d]
stable/6.12: [9c79b839a63980c7da7ec5db895198045e154112]
stable/6.18: [fc393af769af845d9985e2845e49553d8f015a64]
stable/6.6: [ef9b10a020503888eb6c8ed85a3d901a624ede4c]

CVE-2026-43181: gpio: sysfs: fix chip removal with GPIOs exported over sysfs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43181

Introduced by commit 1cd53df ("gpio: sysfs: don't look up exported
lines as class devices") in v6.17-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6766f59012301f1bf3f46c6e7149caca45d92309]
stable/6.18: [54f463494eb5bf193ef7d904a493474c451734df]

CVE-2026-43182: media: ccs: Avoid possible division by zero

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43182

Introduced by commit ccfc97b ("[media] smiapp: Add driver") in v3.5-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [679f0b7b6a409750a25754c8833e268e5fdde742]
stable/5.15: [b6e0529c300e44153fc6f3b565e28163caf1f031]
stable/6.1: [9aae0f31d37a8facd25e37c0f0709ea08de83802]
stable/6.12: [32a21ed2ad743fe2d12af48e627089b921a032c2]
stable/6.18: [a8ff58cc8c7514c278ba0ea2c787d4bf9eeb355d]
stable/6.6: [c9af1818387f5c6f543e2e02c40b3038eae86be8]

CVE-2026-43183: media: cx25821: Fix a resource leak in cx25821_dev_setup()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43183

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
cip/4.19-st: [9708f73698fcdbe7ac5c9a41c3da7522fb49fdce]
cip/4.4-st: [044691e0fc8cd2f1a36db558673d97d1221aa9bb]
mainline: [68cd8ac994cac38a305200f638b30e13c690753b]
stable/5.10: [9f1c926248bde95a77ca104ab525467470607836]
stable/5.15: [071bfc6e723aabbbf08f0d439fb913cd01eb8de2]
stable/6.1: [f7759eb6738ee9fc296f6ab1705c6809947976f3]
stable/6.12: [e220ec4c4596d634685b8a08d79ad876a720b466]
stable/6.18: [b7210170b10e2d17f7a4f6b9d39cc092442db860]
stable/6.6: [4010e596d23cda6de65acb14f7fd4ce8289f1d49]

CVE-2026-43184: rnbd-srv: Zero the rsp buffer before using it

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43184

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected file was added by 2de6c8d ("block/rnbd: server: main
functionality") in v5.8-rc1.

Fixed status
mainline: [69d26698e4fd44935510553809007151b2fe4db5]
stable/5.10: [e4272754063d52c9ad0169865add8816ba696471]
stable/5.15: [e2cacec7d4291300a282feb3af8eba57b93b15aa]
stable/6.1: [b646e54d23b9b592d612a2036aab14e0f6c14206]
stable/6.12: [7aac0a30dcf41cdb510526740d9a2ab1520c5d98]
stable/6.18: [c94ede3c436dfbd9cedd9cb69f604f6fc901b6a2]
stable/6.6: [30868a6a5238849d554295aff3ce61d242d7fad8]

CVE-2026-43185: ksmbd: fix signededness bug in smb_direct_prepare_negotiation()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43185

Introduced by commit 0626e66 ("cifsd: add server handler for central
processing and tranport layers") in v5.15-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6b4f875aac344cdd52a1f34cc70ed2f874a65757]
stable/6.18: [ceae058eb707ddd0d68f0872f9d9f23b7c30c37b]

CVE-2026-43186: ipv6: ioam: fix heap buffer overflow in
__ioam6_fill_trace_data()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43186

Introduced by commit 9ee11f0 ("ipv6: ioam: Data plane support for
Pre-allocated Trace") in v5.15-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6db8b56eed62baacaf37486e83378a72635c04cc]
stable/5.15: [f4d9d4b8fd839719d564651671e24c62c545c23b]
stable/6.1: [fb3c662fafebc5b9d74417ed1de8759f6bb72143]
stable/6.12: [0591d6509c2ff13f09ea2998434aba0c0472e978]
stable/6.18: [e90346a2f1e8917d5760a44a1f61c44e3b36d96b]
stable/6.6: [632d233cf2e64a46865ae2c064ae3c9df7c8864f]

CVE-2026-43187: xfs: delete attr leaf freemap entries when empty

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43187

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [d5b375ee6c7e00a142a128a79328fc301d191adf]
cip/4.4-st: [335e8ad8d95bc8d8e6cd6b37c5d6df5893cd6193]
mainline: [6f13c1d2a6271c2e73226864a0e83de2770b6f34]
stable/5.10: [f3c0d1fc1eadbb4adbee5ab7757d41d35f48325b]
stable/5.15: [aa9083d97e2157da3c6fb45ddb1a97af7f188f7f]
stable/6.1: [a631899025d47ea1aa6464d76db5b4d3b6d196fd]
stable/6.12: [e1b8c6452ee99a30e188a88f3f3f804fb1c6004a]
stable/6.18: [f31a8334e1c54b126fcecf98645a49b6bc5ad399]
stable/6.6: [ffaf5c99d0f862db021fb1af8b813c1416b1beb2]

CVE-2026-43188: ceph: do not propagate page array emplacement errors
as batch errors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43188

Introduced by commit ce80b76 ("ceph: introduce
ceph_process_folio_batch() method") in v6.15-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [707104682e3c163f7c14cdd6b07a3e95fb374759]
stable/6.18: [746840c87d76b614b14d9337c466ff022fc49823]

CVE-2026-43189: media: v4l2-async: Fix error handling on steps after
finding a match

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43189

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [7345d6d356336c448d6b9230ed8704f39679fd12]
stable/6.12: [461733d83e67ba7e3a5b750c0d203f738e01244f]
stable/6.18: [b02bcb378efa8af07827f49b3afcc5e825318c55]
stable/6.6: [30aaed311f973f13ba13a0cd2dc0202f595fff48]

CVE-2026-43190: netfilter: xt_tcpmss: check remaining length before
reading optlen

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43190

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
cip/4.19-st: [f4aaf4bde99ce52cc2fafb4eb94be96de1dcb871]
cip/4.4-st: [0ea945644bc34173fee66e3c80a5cb7366a8326e]
mainline: [735ee8582da3d239eb0c7a53adca61b79fb228b3]
stable/5.10: [f895191dc32c53eaf443b6443fe40945b2f92287]
stable/5.15: [cd5beda7e0e32865e214f28034bb92c1cecff885]
stable/6.1: [eaedc0bc18be46fe7f58170e967959a932c4f824]
stable/6.12: [8b300f726640c48c3edfe9c453334dd801f4b74e]
stable/6.18: [5e13d0a37666955b6cfddc0f73cb40ed645b8a05]
stable/6.6: [07a9b32eaae792ff7d0fcac14d8920c937c0a9c3]

CVE-2026-43191: drm/amd/display: Adjust PHY FSM transition to
TX_EN-to-PLL_ON for TMDS on DCN35

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43191

Introduced commit is not determined.Fixed in v7.0-rc1.
The dcn35_init.c was added by ec129fa ("drm/amd/display: Add DCN35
init") in v6.7-rc1. The dcn35_hwsec.[c|h] was added by 6f8b756
("drm/amd/display: Add DCN35 HWSEQ"") in v6.7-rc1.

Fixed status
mainline: [75372d75a4e23783583998ed99d5009d555850da]

CVE-2026-43192: dm mpath: Add missing dm_put_device when failing to
get scsi dh name

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43192

Introduced by commit fd81bc5 ("scsi: device_handler: Return error
pointer in scsi_dh_attached_handler_name()") in v6.19-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [787bd63ee661b0148ce8e1fde92b7afddd85c446]

CVE-2026-43193: nfsd: fix nfs4_file refcount leak in nfsd_get_dir_deleg()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43193

Introduced by commit 8b99f6a ("nfsd: wire up GET_DIR_DELEGATION
handling") in v6.19-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [789477b849394afdb60507924d65f7ef18f078ce]

CVE-2026-43194: net: consume xmit errors of GSO frames

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43194

Introduced by commit 1f59533 ("qdisc: validate frames going through
the direct_xmit path") in v3.18-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [22a63e3d3ae2c27cdf588436342de860475a8c0f]
mainline: [7aa767d0d3d04e50ae94e770db7db8197f666970]
stable/5.10: [ae3f627b45fbc3c776a4e484696f3cad7cbb4eca]
stable/5.15: [0c9de092ef8c50a7ee9612811566f0aa81d8d7b6]
stable/6.1: [56bd32c0edca34041a5c215887fcf562fae2e2db]
stable/6.12: [ea5d7787635e26ec1194ec7eec0e8e5ae3bd10a5]
stable/6.18: [4cb163e9efcac4cd35c3043e097f25081a5c015c]
stable/6.6: [9ac6aebef4b4bfc5ed408b0b65645981574bc780]

CVE-2026-43195: drm/amdgpu: validate user queue size constraints

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43195

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected file was added by bf33cb6 ("drm/amdgpu: add usermode queue
base code") in v6.16-rc1.

Fixed status
mainline: [8079b87c02e531cc91601f72ea8336dd2262fdf1]
stable/6.18: [cf2a37be899dc1b01f53bf1d0157330eaf3e3f55]

CVE-2026-43196: soc: ti: pruss: Fix double free in pruss_clk_mux_setup()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43196

Introduced by commit ba59c9b ("soc: ti: pruss: support CORECLK_MUX and
IEPCLK_MUX") in v5.10-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [80db65d4acfb9ff12d00172aed39ea8b98261aad]
stable/5.10: [dbda01bf2dfe5af33163e1e5fca1b82b619c2803]
stable/5.15: [24c40076e3bc3d73c839c886d6bda1da6c4d9b93]
stable/6.1: [818cf66d91c8ef09b01664a12d5f4ea786d64396]
stable/6.12: [69aa67c1e22d13e9aad4b08c86304ad8e743dcab]
stable/6.18: [b7db9953c2f8da37de498198623b05b46f8e2ca0]
stable/6.6: [e113339cc7d23be4948891f3a702e9dce5b47035]

CVE-2026-43197: netconsole: avoid OOB reads, msg is not nul-terminated

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43197

Introduced by commit c62c0a1 ("netconsole: Append kernel version to
message") in v6.6-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [82aec772fca2223bc5774bd9af486fd95766e578]
stable/6.18: [3126a2f98beaec5a554a1fb31c46db1e8542665e]

CVE-2026-43198: tcp: fix potential race in tcp_v6_syn_recv_sock()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43198

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [858d2a4f67ff69e645a43487ef7ea7f28f06deae]
stable/6.18: [fe89b2f05b854847784f91127319172945c1fadd]

CVE-2026-43199: net/mlx5e: Fix "scheduling while atomic" in IPsec MAC
address query

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43199

Introduced by commit cee137a ("net/mlx5e: Handle ESN update events")
in v6.2-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [859380694f434597407632c29f30fdb5e763e6cc]
stable/6.12: [e1407fb7c337373dfaaae2445d828b0b9ae26a29]
stable/6.18: [57957bc7f1865778ec9b1618e15515feb6df7eb4]

CVE-2026-43200: PCI: endpoint: Fix swapped parameters in
pci_{primary/secondary}_epc_epf_unlink() functions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43200

Introduced by commit e85a2d7 ("PCI: endpoint: Add support in configfs
to associate two EPCs with EPF") in v5.12-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8754dd7639ab0fd68c3ab9d91c7bdecc3e5740a8]
stable/5.15: [58686bf62cb38b92e4b28408162a5703775b4d12]
stable/6.1: [1c96c1acef4b4a1108fc13f84a8ac0b0633bbb46]
stable/6.12: [339191811e6fc4559c4008c5af7a91b05086d596]
stable/6.18: [733cbc3aa97e71cc70847e75c925b364cc9b04a6]
stable/6.6: [142b1bba3299264b76ed8ef53cd93b2b2af65d6c]

CVE-2026-43201: APEI/GHES: ARM processor Error: don't go past allocated memory

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43201

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [87880af2d24e62a84ed19943dbdd524f097172f2]
stable/6.12: [242c652849d979d0133c315a42d9acea0ff88390]
stable/6.18: [136093ba4161e0080088abff48273f6830a47766]

CVE-2026-43202: fbdev: vt8500lcdfb: fix missing dma_free_coherent()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43202

Introduced by commit e7b9953 ("video: vt8500: Add devicetree support
for vt8500-fb and wm8505-fb") in v3.7-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [88b3b9924337336a31cefbe99a22ed09401be74a]
stable/5.10: [9a9bc60ed372aaae9784ff8ad8e5f496ff15fd31]
stable/5.15: [9c3873cccb3fab54cde0605ae7093d332c99073e]
stable/6.1: [778f31be5b8c10024db23fdd8a05f68a02311008]
stable/6.12: [f47d5b9e8aa6178a0aaf225119ad1ec7d3f49876]
stable/6.18: [40c1ff25025150ff6d7ec7ad441fcfd6d070ee76]
stable/6.6: [e8c5d5f6cd66e032f9aefdcc21b0c34761aef78a]

CVE-2026-43203: atm: fore200e: fix use-after-free in tasklets during
device removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43203

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [d6db504011153f283be3ccb7aec844580ee02309]
cip/4.4-st: [b35c93a6b5dbe6d33d5ea0696cf994ab76287fb9]
mainline: [8930878101cd40063888a68af73b1b0f8b6c79bc]
stable/5.10: [91f25749aaf57c47ae1e12478144e6ea8c8562f2]
stable/5.15: [73fbc5d1a9ccb626937500bbd67136f077d8237b]
stable/6.1: [aba0b4bc09376dfc3d53c826514fe38fc8337f52]
stable/6.12: [97900f512252a59f23d6ce4ab215cc88fed66e68]
stable/6.18: [e4ff4e3ffcf9d5aad380cdd1d8cdc008bb34f97d]
stable/6.6: [e075ec9b08f862dade8011481058f7eb5f716c57]

CVE-2026-43204: ASoC: qcom: q6asm: drop DSP responses for closed data streams

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43204

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected code was added by a354f03 ("ASoC: qcom: q6asm: handle the
responses after closing") in v6.19-rc1.

Fixed status
mainline: [8a066a81ee0c1b6cdbd81393536c3b2d19ccef25]

CVE-2026-43205: dpaa2-switch: validate num_ifs to prevent out-of-bounds write

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43205

Introduced by commit 539dda3 ("staging: dpaa2-switch: properly setup
switching domains") in v5.13-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a5752c6dcc085a3bfc78589925182e4e98468c5]
stable/5.15: [a26dda3bae469c8e4e1b1993ad33dafa32d0fc28]
stable/6.1: [a3034a8d56174dd6464c46823438f25797910a8d]
stable/6.12: [8b841fd529db9faf8bc678d429d4bf4e98b10900]
stable/6.18: [89764cf44544e943230f5e03b8c40a90da26537c]
stable/6.6: [b690635d4719214892855b79ce018d4b1672ac96]

CVE-2026-43206: drm/amdkfd: Fix out-of-bounds write in kfd_event_page_set()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43206

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected code was added by 0fc8011 ("drm/amdkfd: Kmap event page for
dGPUs") in v4.17-rc1.

Fixed status
cip/4.19-st: [2d46baabc1498df537ea2e986e4df70323e9bf3d]
mainline: [8a70a26c9f34baea6c3199a9862ddaff4554a96d]
stable/5.10: [3e04bc310d80b46eaf481f1fefcbcb37a187412d]
stable/5.15: [de8d7a25cd2eb5875b1d8d4fbc7fe4b4138b781f]
stable/6.1: [b4034442cb090e4a980bdcc1540948606cbc951b]
stable/6.12: [75fb57efdd7863fffbc39db23e9cad7aafda26ed]
stable/6.18: [bfcd6b53e1f4feb182952f4ff9a137c36ceaf20b]
stable/6.6: [4857c37c7ba9aa38b9a4c694e8bd8d0091c87940]

CVE-2026-43207: media: mtk-mdp: Fix error handling in probe function

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43207

Introduced by commit c8eb2d7 ("[media] media: Add Mediatek MDP
Driver") in v4.10-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a8a3232abac5b972058a5f2cb3e33199d2a8648]
stable/5.10: [9d9c67976eda502edc6b3a148a1c5b6a18b69a98]
stable/5.15: [0bc43eaf021347f8d5aba87712c36b799695eec6]
stable/6.1: [9d7962d5c81d6cf3f8dbdb5c71c57600bac5772b]
stable/6.12: [c8737d33d4e8ffae87e5d5edac17f8a705235cc2]
stable/6.18: [b3fc99fe5b25613dd61c57bc70b8479adff4f60d]
stable/6.6: [12cafc15d24611bfb43c82877b1bbb7454a85d5a]

CVE-2026-43208: net: do not pass flow_id to set_rps_cpu()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43208

Introduced by commit 48aa304 ("net: Cache hash and flow_id to avoid
recalculation") in v6.18-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a8a9fac9efa6423fd74938b940cb7d731780718]
stable/6.18: [5455a232edea6b946b99449f15ca771a8874a5a6]

CVE-2026-43209: minix: Add required sanity checking to minix_check_superblock()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43209

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
cip/4.19-st: [aed06b0e7d3493e74d9c5784fdbc4d0d23d8d338]
mainline: [8c97a6ddc95690a938ded44b4e3202f03f15078c]
stable/5.10: [a051ecf5c5b0387840dc210413ed3bc7fbdaa69c]
stable/5.15: [d791c544efd6b9c944b43cf7f502e5bcb02fb941]
stable/6.1: [66c7c239c65341f99ae388d4d53dc9df2bcb9925]
stable/6.12: [f57ccd4657c7f082dc47e5b9e18a883bb5f9118f]
stable/6.18: [31fefc18096cdc5549cfa54964d90e0b3229aedc]
stable/6.6: [2bb588cede1c1969e49c0a2822c8cb8b346b7682]

CVE-2026-43210: tracing: ring-buffer: Fix to check event length before using

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43210

Introduced by commit 5f3b6e8 ("ring-buffer: Validate boot range memory
events") in v6.12-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [912b0ee248c529a4f45d1e7f568dc1adddbf2a4a]
stable/6.12: [b4700c089a10f89de3a5149d57f8a58306458982]
stable/6.18: [5026010110a5ad2268d8c23e1e286ab7c736f7ac]

CVE-2026-43211: PCI: Fix pci_slot_trylock() error handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43211

Introduced by commit a4e7728 ("PCI: Add missing bridge lock to
pci_bus_lock()") in v6.11-rc1.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [9368d1ee62829b08aa31836b3ca003803caf0b72]
stable/5.10: [ebb27b7399ab8b9eb1f792b329aa5f6250c590d4]
stable/5.15: [fbe06a3058114bf95a17a4941b205f4b321c6f0a]
stable/6.1: [943ed56606a7ab2fe5a99cad572dd17d484310c7]
stable/6.12: [0425aaf20b407d2f2cf3bf469808e4a35f9abb8b]
stable/6.18: [bd435f4b738130d732ef64e0e57e45185f77165d]
stable/6.6: [a19b61fdb958ffadbba85b43c991eb9fc70c1c1c]

CVE-2026-43212: LoongArch: Make cpumask_of_node() robust against NUMA_NO_NODE

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43212

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected code was added by d4b6f15 ("LoongArch: Add Non-Uniform Memory
Access (NUMA) support") in v5.19-rc1.

Fixed status
mainline: [94b0c831eda778ae9e4f2164a8b3de485d8977bb]
stable/6.1: [b5bf05e05cdf489a04137e4da407de9d4cca5295]
stable/6.12: [92adfb707beec0fe956424373654a70aad35ea13]
stable/6.18: [61a56df2fbaad3a4d00f0c6a904b5d1ee8982eb4]
stable/6.6: [bb1a54f7f011f19ed936632698eae574e0b91063]

CVE-2026-43213: wifi: rtw89: pci: validate sequence number of TX release report

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43213

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected file was added by e3ec701 ("rtw89: add Realtek 802.11ax
driver") in v5.16-rc1.

Fixed status
mainline: [957eda596c7665f2966970fd1dcc35fe299b38e8]
stable/6.18: [ef7fa19809b2d892d45da53f90ac698d13c367fd]

CVE-2026-43214: KVM: x86: Add SRCU protection for reading PDPTRs in
__get_sregs2()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43214

Introduced by commit 6dba940 ("KVM: x86: Introduce KVM_GET_SREGS2 /
KVM_SET_SREGS2") in v5.14-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [95d848dc7e639988dbb385a8cba9b484607cf98c]
stable/6.1: [f621ca24f9f489e226e22560761b04884984133b]
stable/6.12: [9f2bfea51151dfbb24b52f452eb3d5f5fe0e506e]
stable/6.18: [57536ff0a6bd69a5808d682925202babdb5ddc13]
stable/6.6: [708e20c66b2761d878a2bc3c7534e7f814e4dec5]

CVE-2026-43215: cifs: Fix locking usage for tcon fields

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43215

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [96c4af418586ee9a6aab61738644366426e05316]
stable/6.12: [601dd3b79769b38d30b693c40afdb2a4b7edf9d0]
stable/6.18: [3969db6b22e3d90d8c5f22ac1a7fe0350a94c136]
stable/6.6: [953953abb66e52c224057ab91e404284fefeab62]

CVE-2026-43216: net: Drop the lock in skb_may_tx_timestamp()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43216

Introduced by commit b245be1 ("net-timestamp: no-payload only sysctl")
in v4.0-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [983512f3a87fd8dc4c94dfa6b596b6e57df5aad7]
stable/6.18: [f3e4cceafad27c9363c33622732f86722846ec6f]

CVE-2026-43217: media: iris: gen2: Add sanity check for session stop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43217

Introduced by commit 11712ce ("media: iris: implement vb2 streaming
ops") in v6.15-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9aa8d63d09cfc44d879427cc5ba308012ca4ab8e]
stable/6.18: [72846441c5f6396de9face04e77fa3d28e9915b6]

CVE-2026-43218: media: i2c/tw9903: Fix potential memory leak in tw9903_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43218

Introduced by commit 0890ec1 ("[media] tw9903: add new tw9903 video
decoder") in v3.10-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [a36acf2f8fc6349821937f050af39a30b403a8e5]
cip/4.4-st: [55e5fba7ff19ca4d801c622f23f35d4dc7784a93]
mainline: [9cea16fea47e5553f51d10957677ff735b1eff03]
stable/5.10: [e54aa17c968c4de2c5f7b7ea390c63d33c07513b]
stable/5.15: [32f0493506313775d3bd448de34762b6538da6bd]
stable/6.1: [92537a15780b6d0281fd8286f93fbc3652e35f48]
stable/6.12: [a114918270f0d95c607d69b03a244e6afe54813f]
stable/6.18: [cc7aeed33e4f55c76f35f0fca73e4dfe12a63a3a]
stable/6.6: [9cb9eca33d20316ed3c7a938793b8735ac3e128b]

CVE-2026-43219: net: cpsw_new: Fix potential unregister of netdev that
has not been registered yet

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43219

Introduced by commit ed3525e ("net: ethernet: ti: introduce cpsw
switchdev based driver part 1 - dual-emac") in v5.5-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9d724b34fbe13b71865ad0906a4be97571f19cf5]
stable/6.18: [29739ec197ed66535bc0b86f14ab66c5f4512138]

CVE-2026-43220: iommu/amd: serialize sequence allocation under
concurrent TLB invalidations

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43220

Introduced by commit d2a0cac ("iommu/amd: move wait_on_sem() out of
spinlock") in v7.0-rc1.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [9e249c48412828e807afddc21527eb734dc9bd3d]
stable/6.18: [5000ce7fcb31067566a1a1a2e5b5bbff93625242]

CVE-2026-43221: ipmi: ipmb: initialise event handler read bytes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43221

Introduced by commit 63c4eb3 ("ipmi:ipmb: Add initial support for IPMI
over IPMB") in v5.16-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f235ccecd03c436cb1683eac16b12f119e54aa9]
stable/6.1: [905554ebd76aeee370bfd5136ea11e0b9d75c6f1]
stable/6.12: [2dfbc8c17dd161885336e77e71c336cd62cf6748]
stable/6.18: [f726b3a57e00bb6249c67714c11ae8b4b31719a1]
stable/6.6: [56d5c0557e53c4d8d92a619fa83eaae178165e07]

CVE-2026-43222: media: verisilicon: AV1: Fix tile info buffer size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43222

Introduced by commit 727a400 ("media: verisilicon: Add Rockchip AV1
decoder") in v6.5-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a505ca2db89ad92a8d8d27fa68ebafb12e04a679]
stable/6.12: [34f36f9c6114af781a5a4f7a7c99334c85b73fc7]
stable/6.18: [f122f2b3ce9dbde60bf7ab0b180fe4a01f9d9bc4]
stable/6.6: [a5b1ddbe31f49b4da78642157589970e9b60a231]

CVE-2026-43223: media: pvrusb2: fix URB leak in pvr2_send_request_ex

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43223

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
cip/4.19-st: [0d9c61e5102a6f38c8920b6d0d8ebd39b36adcd6]
cip/4.4-st: [0c3ee1b2a8904b7c0eafdc8cbce96b8216649195]
mainline: [a8333c8262aed2aedf608c18edd39cf5342680a7]
stable/5.10: [da524c939b1e5ba17f10db4bde4bdaf569ffcda6]
stable/5.15: [cf459d6ffa5e150ef3744b897f936ff24b52bd15]
stable/6.1: [77a63f8efc434ddb04667ed632aade58301a2f13]
stable/6.12: [58dd722b6c3debcddb4684fb256c90fee7f063e5]
stable/6.18: [2011929f0e4cf6a0a34dd6205911b12276904453]
stable/6.6: [4ba5c7a1aade7090172cbffd4d120bf4cf5ccbde]

CVE-2026-43224: io_uring/zcrx: fix sgtable leak on mapping failures

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43224

Introduced by commit 439a98b ("io_uring/zcrx: deduplicate area
mapping") in v6.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a983aae397767e9da931128ff2b5bf9066513ce3]
stable/6.18: [f1ae403324311e143ef20e53cf9a5f01e312f7c9]

CVE-2026-43225: staging: rtl8723bs: fix memory leak on failure path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43225

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected code was added by 554c0a3 ("staging: Add rtl8723bs sdio wifi
drive") in v4.12-rc1.

Fixed status
mainline: [abe850d82c8cb72d28700673678724e779b1826e]
stable/5.15: [9874e33ce52ba449ab0ade78752a2d37a2294617]
stable/6.1: [a968c6a39607c129b8ac2c3c2a5e8923574e90d0]
stable/6.12: [9f70f78e22b321429afc77befecedf05543d4e2c]
stable/6.18: [af48c1a0abe849e167fc754b6c260b6d8350b6fd]
stable/6.6: [8311bb40698ba027649d5d1ca84ad4bf25270546]

CVE-2026-43226: net/rds: No shortcut out of RDS_CONN_ERROR

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43226

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
cip/4.19-st: [74e7fd37305fb31296976b76fcb78de51e39084d]
mainline: [ad22d24be635c6beab6a1fdd3f8b1f3c478d15da]
stable/5.10: [9bcd7c00691a2db9745817d5ea79262a503b135c]
stable/5.15: [a179ac7be8f5a650d0068040705f4cddd6ca369c]
stable/6.1: [19e384a7d00d888303a8285977cdf1970c6cccd6]
stable/6.12: [81248b1eb3c5954cc1fc7b33b7c03e34d20cb8c8]
stable/6.18: [899ef00963ce76f9fc421a7d02335fe4ead6389b]
stable/6.6: [f0f729bdffb08af32e0f54521b81b8a9e0321f16]

CVE-2026-43227: clocksource/drivers/sh_tmu: Always leave device
running after probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43227

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
cip/4.19-st: [12f4988bcfa70a46e4975ae019f1069fef692605]
cip/4.4-st: [7425539bb9587cfb7eb593066f8aeb11bf9e0abd]
mainline: [b1278972b08e480990e2789bdc6a7c918bc349be]
stable/5.10: [79d650695773f03de36b99228a090d33d1c18264]
stable/5.15: [f0b31247e7d67a943b3a09d3cef7c0ae788d88e6]
stable/6.1: [016476afef993d1201a19decc9b5b2ea1e6620f2]
stable/6.12: [88c76792180dffd83f1c5b9dc8fdaeb145cb94e0]
stable/6.18: [bc59d5f3afe41fec5d673c27c703b761ae578d28]
stable/6.6: [6f113ab549b864c1bc57d4f89846ee335394089a]

CVE-2026-43228: hfs: Replace BUG_ON with error handling for CNID count checks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43228

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [b226804532a875c10276168dc55ce752944096bd]

CVE-2026-43229: media: chips-media: wave5: Fix device cleanup order to
prevent kernel panic

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43229

Introduced by commit 9707a62 ("media: chips-media: wave5: Add the v4l2
layer") in v6.8-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b74cedac643b02aefa7da881b58a3792859d9748]
stable/6.12: [b73d85231d5b1400a4fa5046cdac6c4d7cc6d969]
stable/6.18: [526816f2e331954d80fed8b37fa94efbbdde2b8d]

CVE-2026-43230: net/rds: Clear reconnect pending bit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43230

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
cip/4.19-st: [8c7ae7cecd936f90f5a5adeb8e7e51b78c691303]
mainline: [b89fc7c2523b2b0750d91840f4e52521270d70ed]
stable/5.10: [3cf001aff71b1db1b4732a5381b012a114720664]
stable/5.15: [60b347333ec259ac7352f62cbbc365b04c065ff8]
stable/6.1: [597c46a42930c963f448720aaf5001dd4ed98af4]
stable/6.12: [ba2e3472022f44baddf000621fed150d7a599ea3]
stable/6.18: [14eae5564053ac3973b9369dc674638f22f4765e]
stable/6.6: [391200c274e90c34071b909ba12e3390b81b767f]

CVE-2026-43231: media: radio-keene: fix memory leak in error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43231

Introduced by commit 1bf20c3 ("[media] radio-keene: add a driver for
the Keene FM Transmitter") in v3.4-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [86407ad120c78273c20dd97496d40142910ea11c]
cip/4.4-st: [c4920434c9cd1af4d858a360ee7ed4d3dcd1f98a]
mainline: [b8bf939d77c0cd01118e953bbf554e0fa15e9006]
stable/5.10: [ad85bb5623079a35bd400f51de2e2fbc2170bdb2]
stable/5.15: [242b0aabb1866024a7995a767ac330c158b39aa4]
stable/6.1: [2fe28a63d598235595a9601e0d8fdc7c8f4fd575]
stable/6.12: [7fa9754f48cb8eefa566156be341e63d313247e5]
stable/6.18: [1d8558a232ecb187e8e0328d6347a125f437a0fc]
stable/6.6: [27c508f61963013fdf29097578284099ee7a85a4]

CVE-2026-43232: net: wan: farsync: Fix use-after-free bugs caused by
unfinished tasklets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43232

Introduced by commit 2f623aa ("net: farsync: Fix kmemleak when rmmods
farsync") in v6.2-rc1.
Fixed in v7.0-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1

Fixed status
mainline: [bae8a5d2e759da2e0cba33ab2080deee96a09373]
stable/5.10: [cac048ebfbb92d91d719f74b59177cb70a7633b8]
stable/5.15: [086131807d119238cd464e5b0845e48d938dfd79]
stable/6.1: [ae894e47e1cd5a6bf8a0423d888c45df8b2b02dc]
stable/6.12: [200bdb8d367ca9b478f9c56ebe56411604d55c81]
stable/6.18: [21d341fe514fd07e345ed264c9eee21cb2061ca2]
stable/6.6: [337d7b4112a47984ee319171b75b73bab47e7924]

CVE-2026-43233: netfilter: nf_conntrack_h323: fix OOB read in decode_choice()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43233

Introduced by commit ec8a8f3 ("netfilter: nf_ct_h323: Extend
nf_h323_error_boundary to work on bits as well") in v4.15-rc4.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [0c4bab03f15bca115da72091e65a8a4d0278b16d]
mainline: [baed0d9ba91d4f390da12d5039128ee897253d60]
stable/5.10: [bcb50aa0b8f2b74a9fe5a1c7bee6f2657a288041]
stable/5.15: [2a3aac4205e7d2f1aca2e3827de8cdd517d36c4a]
stable/6.1: [81f2fc5b0d0cf4696146f00f837596d10b92dead]
stable/6.12: [53d32735d77ab56cc3fc7bd53a7d099418f19be1]
stable/6.18: [f0a83d0a4b7c127d32ac06d607a9214937716129]
stable/6.6: [7ef82863d42261817a6394c6c881bd6757a70f16]

CVE-2026-43234: team: avoid NETDEV_CHANGEMTU event when unregistering slave

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43234

Introduced by commit 3d249d4 ("net: introduce ethernet teaming
device") in v3.3-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bb4c698633c0e19717586a6524a33196cff01a32]
stable/6.18: [bce42728ac4887060a24a585c5122fbd24939db7]

CVE-2026-43235: media: iris: Add missing platform data entries for SM8750

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43235

Introduced by commit a5925a2 ("media: iris: add VPU33 specific
encoding buffer calculation") in v6.18-rc1.
Introduced by commit a688243 ("media: iris: Add support for
ENUM_FRAMESIZES/FRAMEINTERVALS for encoder") in v6.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bbef55f414100853d5bcea56a41f8b171bac8fcb]
stable/6.18: [1aa5833f29b88c16e9ad49a1782927754f3af742]

CVE-2026-43236: drm/atmel-hlcdc: fix use-after-free of drm_crtc_commit
after release

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43236

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
cip/4.19-st: [119ed421c91b4b118aee71d3070b86db11f6c21f]
mainline: [bc847787233277a337788568e90a6ee1557595eb]
stable/5.10: [fd4a4d0711f48a99b25bcd45e00eef8339eff82d]
stable/5.15: [6404898af86d986db1dbbe06177c143e40652e49]
stable/6.1: [796e77c14c4c1e2cd36473760fb6cc66c695eb47]
stable/6.12: [a205740a7231e967ac77cb731171642901c327af]
stable/6.18: [7b4d0fab3ff2c00c6d34e1952c9df5129a826aee]
stable/6.6: [ac2d898da5095d46bd1ff8585fdd753d58ad91e7]

CVE-2026-43237: drm/amdgpu: Refactor amdgpu_gem_va_ioctl for Handling
Last Fence Update and Timeline Management v4

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43237

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [bd8150a1b3370a9f7761c5814202a3fe5a79f44f]
stable/6.18: [e9e477d3197f7d8955a042c0d7f53f78f13218ba]

CVE-2026-43238: net/sched: act_skbedit: fix divide-by-zero in tcf_skbedit_hash()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43238

Introduced by commit 38a6f08 ("net: sched: support hash selecting tx
queue") in v5.19-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be054cc66f739a9ba615dba9012a07fab8e7dd6f]
stable/6.1: [59809fda4da7730cfe84a948033f47eb45db073d]
stable/6.12: [015cebdfcb97b5347fb7f598ea712a281cb35840]
stable/6.18: [4ece5eb4836f8ff03b9004dc2430a7169f282851]
stable/6.6: [9c735a7d98c982a786b0db71eb6566ee00aaa04f]

CVE-2026-43239: smb: client: prevent races in ->query_interfaces()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43239

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [c3c06e42e1527716c54f3ad2ced6a034b5f3a489]
stable/6.12: [ab6564f416a6eaf1199200b6100952407b438f7d]
stable/6.18: [6287eefaf21ec805d42f941bd368018cf397a7f5]
stable/6.6: [93e8e3ee165ae4609a1222b516b573837103d2c3]

CVE-2026-43240: x86/kexec: add a sanity check on previous kernel's ima
kexec buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43240

Introduced by commit b69a2af ("x86/kexec: Carry forward IMA
measurement log on kexec") in v6.0-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c5489d04337b47e93c0623e8145fcba3f5739efd]
stable/6.1: [37f18915a261afe84dab462624ed829cddb77a9b]
stable/6.12: [f8f73bf0f8a57ee9b86792456bd42079bc98c6b7]
stable/6.18: [d4a132f121c591b60dbaf57ea91f1faf11631fbc]
stable/6.6: [22e460b6333a5f818b042ac89201f8e735556f4a]

CVE-2026-43241: ntb: ntb_hw_switchtec: Fix array-index-out-of-bounds access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43241

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected code was added by ec0467c ("NTB: switchtec_ntb: Initialize
hardware for memory windows") in v4.15-rc1.

Fixed status
cip/4.19-st: [ed140a9207b4362346ef5cc99999d7cf9f45c59f]
mainline: [c8ba7ad2cc1c7b90570aa347b8ebbe279f1eface]
stable/5.10: [348e1ac9ad983ed7e62de14e1daf47f1695a4ce9]
stable/5.15: [ee02c4f980c91820845dd8e469ec7dc670ab6d9d]
stable/6.1: [740945de896021b9a859e71f38f6aea72a6393cf]
stable/6.12: [0e930420945106151c6eb3d7837b4e6154e9b144]
stable/6.18: [2346856b74823a2a78109002e479a3d02526a9ce]
stable/6.6: [85c9daa1f8319bbb3dfee71dc6a2f969cd3b4c92]

CVE-2026-43242: soc: ti: k3-socinfo: Fix regmap leak on probe failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43242

Introduced by commit a5caf03 ("soc: ti: k3-socinfo: Do not use syscon
helper to build regmap") in v6.15-rc1.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [c933138d45176780fabbbe7da263e04d5b3e525d]
stable/5.10: [c97c21d342838b2a7787b0f1d6ad417e85c906f6]
stable/5.15: [b1006b5892ec8a95d039a89b47e6fd69cf607405]
stable/6.1: [458136527fe127fd051c1c9537f4540849780d70]
stable/6.12: [eaa16059f9af26d8b8a6f3e887649f58e8ca96c9]
stable/6.18: [ab1ac24c407e4df326d7154a4deadd444e9209d9]
stable/6.6: [d451bf970a0c54b586f8b3161261bdf35d463c99]

CVE-2026-43243: drm/amd/display: Add signal type check for dcn401
get_phyd32clk_src

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43243

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected code was added by 70839da ("drm/amd/display: Add new DCN401
sources") in v6.11-rc1.

Fixed status
mainline: [c979d8db7b0f293111f2e83795ea353c8ed75de9]
stable/6.12: [23e7150afc70da615857f9f07b494ec58540f096]
stable/6.18: [486b2909ac284185900c06f05ffc6eca895f38b8]

CVE-2026-43244: kcm: fix zero-frag skb in frag_list on partial sendmsg error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43244

Introduced by commit ab7ac4e ("kcm: Kernel Connection Multiplexor
module") in v4.6-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ca220141fa8ebae09765a242076b2b77338106b0]
stable/6.12: [9ea3671d70ee07480d80bebe86696397c4e99fb7]
stable/6.18: [b1e3edf688a88c1a3ac41657055d9c136a08cd25]

CVE-2026-43245: ntfs: ->d_compare() must not block

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43245

Introduced commit is not determined.Fixed in v7.0-rc1.
The ntfs3 file system was added in v5.15-rc1.

Fixed status
mainline: [ca2a04e84af79596e5cd9cfe697d5122ec39c8ce]
stable/6.18: [142c444a395f4d26055c8a4473e228bb86283f1e]

CVE-2026-43246: media: i2c/tw9906: Fix potential memory leak in tw9906_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43246

Introduced by commit a000e9a ("[media] tw9906: add Techwell tw9906
video decoder") in v3.10-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [d88ed9f0c454be168cfc8f311d50c1a287d1951a]
cip/4.4-st: [33a2ca24c23e058dfbdebb3c956bb2962d3b426c]
mainline: [cad237b6c875fbee5d353a2b289e98d240d17ec8]
stable/5.10: [e9a490937942f18205dac7b6b192975ef1369ae1]
stable/5.15: [9548a8bbf511a252a9848f96220c6b95c9a3b918]
stable/6.1: [0c33338514d8246280533a77091e6b6ee548c606]
stable/6.12: [fb09d8b80046216646f1a344410cfa9cfa6c6c7c]
stable/6.18: [377a7756914364d72550fc86ca0f404ef1d96141]
stable/6.6: [ccb92def042a3636ed47f25a30bd553788e5191e]

CVE-2026-43247: media: chips-media: wave5: Fix SError of kernel panic
when closed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43247

Introduced by commit 2092b38 ("media: chips-media: wave5: Support
runtime suspend/resume") in v6.13-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cbb9c0d50e471483cced55f5b7db4569dcd959a6]
stable/6.18: [27cb12b7dc88c51582094eeb2b65b0e94603e411]

CVE-2026-43248: vhost: move vdpa group bound check to vhost_vdpa

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43248

Introduced by commit bda324f ("vdpasim: control virtqueue support") in
v5.19-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cd025c1e876b4e262e71398236a1550486a73ede]
stable/6.12: [ddb57354634b6ba851b79da45f1de42c646f27d0]
stable/6.18: [7441d35d14d9a3d66d925d90cb73c75394e6d454]

CVE-2026-43249: 9p/xen: protect xen_9pfs_front_free against concurrent calls

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43249

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [ce8ded2e61f47747e31eeefb44dc24a2160a7e32]
stable/6.12: [a5d00dff97118a32fcf5fec7a4c3f864c4620c4e]
stable/6.18: [59e7707492576bdbfa8c1dbe7d90791df31e4773]

CVE-2026-43250: usb: chipidea: udc: fix DMA and SG cleanup in _ep_nuke()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43250

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [cea2a1257a3b5ea3e769a445b34af13e6aa5a123]
stable/6.12: [1b72b834511d17f4d069d512f78671f3f210a2f1]
stable/6.18: [f4fbf2d4750d12ac8525d2efac1016fa0d84d4ec]

CVE-2026-43251: HID: prodikeys: Check presence of pm->input_ep82

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43251

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
cip/4.19-st: [bf34bf2b4e9f26721c19ad892a48ed8349439bba]
cip/4.4-st: [83370a4e280c09bc91d5f78248dade1944c9d0d8]
mainline: [cee8337e1bad168136aecfe6416ecd7d3aa7529a]
stable/5.10: [f580c79683356632f12f2c2029f2fe936d953aa1]
stable/5.15: [ee572578f09f0e743e9383393a75c3a7a0f9b4c2]
stable/6.1: [edccbf7d6dc05d692bde3a89de5a4001f72a0fa4]
stable/6.12: [e7ac1cd823cd2e9fcbd5cb0b261d6d35dbb79341]
stable/6.18: [d5512ce892f774d37c53082adadfcad04f21b50e]
stable/6.6: [3f1b21cc67a15d7d081378a9b8747dd000a017b8]

CVE-2026-43252: mptcp: pm: in-kernel: always set ID as avail when rm endp

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43252

Introduced by commit e255683 ("mptcp: pm: re-using ID of unused
removed ADD_ADDR") in v6.11-rc5.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [d191101dee25567c2af3b28565f45346c33d65f5]
stable/6.1: [d90d73ad183566c81320d453a223f610a280f210]
stable/6.12: [7c1d221e475e3d8eb8ed4702392d43f8c5134d1f]
stable/6.18: [7e4d88e36e5d0b8ffda637999cbca64c81701a81]
stable/6.6: [1b3ff4d88b508b73e2bbddb59356311efb7ba192]

CVE-2026-43253: iommu/amd: move wait_on_sem() out of spinlock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43253

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [d2a0cac10597068567d336e85fa3cbdbe8ca62bf]
stable/6.12: [715c263119fd1b918a9fcbd8a36ea5b604a46324]
stable/6.18: [e15768e68820142077bbca402d8e902f64ade1b0]
stable/6.6: [f2f65b28d802a667119147444ec2ae33eebf9a58]

CVE-2026-43254: ovpn: tcp - fix packet extraction from stream

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43254

Introduced by commit 11851cb ("ovpn: implement TCP transport") in v6.16-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d4f687fbbce45b5e88438e89b5e26c0c15847992]
stable/6.18: [0315bec883c67fa1413c61e504a28dc5bd02eb37]

CVE-2026-43255: wifi: libertas: fix WARNING in usb_tx_block

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43255

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
cip/4.19-st: [c11aa5e51eb1171a55d3e98da73cd345e90581c7]
cip/4.4-st: [b073a736dbe4c48ea31232714e14c91c4855da17]
mainline: [d66676e6ca96bf8680f869a9bd6573b26c634622]
stable/5.10: [498525d8358d6d20918787e59736d5b6a021e9fd]
stable/5.15: [2902a9b4415a6bafc9b1e5dd360f065d757a0bb7]
stable/6.1: [948a39c95d0f8d73722910f8cdb7b6e3e9206232]
stable/6.12: [b82073564373e68c6ae3a96039fae14cd002a496]
stable/6.18: [3308c7504e093b22e91a4468470309cee2e26b83]
stable/6.6: [5bfb25495e391a1be0db94b15715174fa06b93a1]

CVE-2026-43256: media: qcom: camss: vfe: Fix out-of-bounds access in
vfe_isr_reg_update()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43256

Introduced by commit 4edc8ea ("media: camss: Add initial support for
VFE hardware version Titan 480") in v5.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d965919af524e68cb2ab1a685872050ad2ee933d]
stable/6.1: [e6cbf765686fb6c1d8f2530b3daf6c66efc92f5d]
stable/6.12: [1b103307df6d461a0731be25aca69ad0335b0933]
stable/6.18: [fade67c88870f497a13ed450ba01f7236c92dd9b]
stable/6.6: [0c074e80921fd18984b75836730d76c768c84f65]

CVE-2026-43257: media: cx88: Add missing unmap in snd_cx88_hw_params()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43257

Introduced by commit b2c75ab ("[media] cx88: drop videobuf abuse in
cx88-alsa") in v3.19-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [4faac529751a561eab1371e7a82f26ba175c39cb]
cip/4.4-st: [a3c636210e26007322c07d16d679377792740142]
mainline: [dbc527d980f7ba8559de38f8c1e4158c71a78915]
stable/5.10: [f0d7f735eba963742009b0706e19dd0bed91537a]
stable/5.15: [dc911fccc6e08ef46a66b2a42a764252b001ee3c]
stable/6.1: [24f3dabeb97bd0bec8c1c926c97e3eb6a8129225]
stable/6.12: [e3fb15aadfc8643203bbdf97ace0396e4586fa64]
stable/6.18: [1ce8c2a8f050a23240553c8bae628ac623f9dbc1]
stable/6.6: [10ab64f8efc2f479293dce929fde326c285fc96f]

CVE-2026-43258: alpha: fix user-space corruption during memory compaction

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43258

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [dd5712f3379cfe760267cdd28ff957d9ab4e51c7]
stable/6.12: [d4ca6ca2c6f5a1d19d9014c5b36d96637846b5d6]
stable/6.18: [03e42b5f7ad4c2c3db8bd384bab7990d5d53c90f]

CVE-2026-43259: phy: fsl-imx8mq-usb: set platform driver data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43259

Introduced by commit b58f0f8 ("phy: fsl-imx8mq-usb: add tca function
driver for imx95") in v6.15-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [debf8326a435ac746f48173e4742a574810f1ff4]
stable/6.18: [42d9509161d0539767ba875f3ef6b4b3c0b425ed]

CVE-2026-43260: bnxt_en: Fix RSS context delete logic

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43260

Introduced by commit 667ac33 ("eth: bnxt: allow deleting RSS contexts
when the device is down") in v6.11-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e123d9302d223767bd910bfbcfe607bae909f8ac]
stable/6.12: [348a5f8d06c7bdf954e13c17ad5f80b59a075604]
stable/6.18: [079986d6db1f8e3d50c55f400cf998ac9690d2c8]

CVE-2026-43261: arm64: Add support for TSV110 Spectre-BHB mitigation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43261

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [e3baa5d4b361276efeb87b20d8beced451a7dbd5]
stable/5.10: [598c11dd4f4a9de31d854fcb9702f54c1c70f0d0]
stable/5.15: [a8d0ad5d990b050a6db74218a34b5529085e16b8]
stable/6.1: [cccf96c49f61e47d9332d6a4d1c7fe9a2df44440]
stable/6.12: [5dbe1f14359735fa50ba0dd4a496125b5bc7f422]
stable/6.18: [fd51d47fcacec3ca027eb65d8c44853d3b6cea95]
stable/6.6: [fd7e360845d331f542854d552469544182e61134]

CVE-2026-43262: gfs2: fiemap page fault fix

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43262

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [e411d74cc5ba290f85d0dd5e4d1df8f1d6d975d2]
stable/5.15: [5d5d9ec957bfa1eb2b05861c19f5d701dd006db7]
stable/6.1: [cead3bebf3e318578b8a86a5472015d713d2a8a8]
stable/6.12: [5d2c4f182ea8516de8682e2b60411c03df00e3ea]
stable/6.18: [2e121c53b581e40397ae08090a7af4ed10781fbc]
stable/6.6: [e428670cfb2993d8c224effd076242ca6b0950de]

CVE-2026-43263: media: chips-media: wave5: Fix Null reference while
testing fluster

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43263

Introduced by commit 9707a62 ("media: chips-media: wave5: Add the v4l2
layer") in v6.8-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e66ff2b08e4ee1c4d3b84f24818e5bcc178cc3a4]
stable/6.18: [ea316b784fe6a61b29131c98cddb24e651b1dcbc]

CVE-2026-43264: fbdev: of: display_timing: fix refcount leak in
of_get_display_timings()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43264

Introduced by commit cc3f414 ("video: add of helper for display
timings/videomode") in v3.9-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [bf098fbe0321e0fff932b0ec0a54e3d000969eb5]
mainline: [eacf9840ae1285a1ef47eb0ce16d786e542bd4d7]
stable/5.10: [20881ad42e651c69d89eb38a2042838187900fd6]
stable/5.15: [b5bdcc5afbff845834d04d651773cb6b47db5dd3]
stable/6.1: [2b22e4fe1273c24f405ed7903349c4bbd82b6368]
stable/6.12: [d6f34bbff07476c6abb8672c89d217824871c5ed]
stable/6.18: [69290f2d3999c5fa1a7f5d5593cfc5461fa3ee64]
stable/6.6: [3ed019654234edb8625c05d05e15d40f74e64f70]

CVE-2026-43265: KVM: x86: Ignore -EBUSY when checking nested events
from vcpu_block()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43265

Introduced by commit 26844fe ("KVM: x86: never write to memory from
kvm_vcpu_check_block()") in v6.1-rc1.
Introduced by commit 4540515 ("KVM: x86: WARN if a vCPU gets a valid
wakeup that KVM can't yet inject") in v6.11-rc1.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [ead63640d4e72e6f6d464f4e31f7fecb79af8869]
stable/6.1: [78265cd066d73a5cb41c088fcae4a2515e480d97]
stable/6.12: [2657439265d34a911886b916ba8be97ecc117d51]
stable/6.18: [1e88b5f854bdb469424132e0bb44793ad7a7c20a]
stable/6.6: [ec3be7dc9391085a2d96700e159d66d1328b7ff6]

CVE-2026-43266: EFI/CPER: don't go past the ARM processor CPER record buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43266

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected file was added by c6d8c8e ("efi: Move ARM CPER code to new
file") in v4.16-rc1.

Fixed status
cip/4.19-st: [f09aa4845c7547ddfc72525bb47787e36ff326d5]
mainline: [eae21beecb95a3b69ee5c38a659f774e171d730e]
stable/5.10: [c80113dcfc807308f5ab33847fae77e07531aeb8]
stable/5.15: [ca2aad8771aa9091bc9e42e7d546bd40b72ddcd4]
stable/6.1: [a68d22902a6916e10ee235fee609239004e129d0]
stable/6.12: [be10c1bdf64a39832998f54900aa309b3917abcf]
stable/6.18: [25b290624b0e3d2f0f90238709ee0b6009b9fde8]
stable/6.6: [64eb63f573f497553e1a0c388bbcdd639e0f0704]

CVE-2026-43267: wifi: rtw89: fix potential zero beacon interval in
beacon tracking

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43267

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected file was added by e3ec701 ("rtw89: add Realtek 802.11ax
driver") in v5.16-rc1.

Fixed status
mainline: [eb57be32f438c57c88d6ce756101c1dfbcc03bba]
stable/6.18: [1260bee01493126cf9c872b6ca2af261173baa6d]

CVE-2026-43268: hfsplus: pretend special inodes as regular files

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43268

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
cip/4.19-st: [cd9ce695787714e91e6b2c33142c2f633a65a563]
cip/4.4-st: [b9dcb45b68d72b9ea35c4dc83de78718328f3230]
mainline: [ed8889ca21b6ab37bc1435c4009ce37a79acb9e6]
stable/5.10: [dcac5582f90b55a267d89769073c5651990b2ec5]
stable/5.15: [799c492a619a10322543d13e6d2a6d27335c868c]
stable/6.1: [676bc99d0b3e356cdfec5d8204518e1aac14ec84]
stable/6.12: [d209ebaee93fc5089101d34d1b38a91d7abb03fd]
stable/6.18: [67407d6abc9520a8a4661285b3ed294eb73ff6e7]
stable/6.6: [de9affb698d5034888314880736925c39d6d048e]

CVE-2026-43269: drm/atmel-hlcdc: fix memory leak from the
atomic_destroy_state callback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43269

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
cip/4.19-st: [533019ce3215c029f43ab088c949afa024d6833e]
mainline: [f12352471061df83a36edf54bbb16284793284e4]
stable/5.10: [6d4e91ab97fda64e8cf9c8881cc3b4da026bd849]
stable/5.15: [5718d98976ad6b9700e5a6afec67fc47a8a92580]
stable/6.1: [57fa3487acfa3467405f8506b94682abd96e7393]
stable/6.12: [25e832a7830740e72103eb0b527680a4b64bbcb3]
stable/6.18: [082271e364a3205598c2e4e6233a9f49ce7941cf]
stable/6.6: [ec40702029b08ee8d5f5b03303d64a10e74a957b]

CVE-2026-43270: media: mtk-mdp: Fix a reference leak bug in mtk_mdp_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43270

Introduced by commit c8eb2d7 ("[media] media: Add Mediatek MDP
Driver") in v4.10-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [3336004fb14096911ac45f7d6aab216a0c1413bc]
mainline: [f128bab57b8018e526b7eda854ca20069863af47]
stable/5.10: [403b7c757ac9f6b2ffb7d00ff4795a245f5e8911]
stable/5.15: [dd530e29bd514d7187b3e2df8eb2107419c7988f]
stable/6.1: [c44beed2e5caf2cbbe651432baa3a129f18b0169]
stable/6.12: [4f2a51433a3a65d16975d1e32052d80656da077d]
stable/6.18: [a62ba5aa9ee95fd953583e95e519badf0b76ecf3]
stable/6.6: [564fd3a63efc3ebbdb5d0a8fc7c0d3f753fbbd5d]

CVE-2026-43271: md-cluster: fix NULL pointer dereference in
process_metadata_update

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43271

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected code was added by 4469315 ("md: protect md_thread with rcu")
in v6.5-rc1.

Fixed status
mainline: [f150e753cb8dd756085f46e86f2c35ce472e0a3c]
stable/6.12: [dec123825c1ed74d98fd5fc7571a851dea4f46ff]
stable/6.18: [721599e837d3f4c0e6cc14da059612c017b6d3ec]
stable/6.6: [a61c1bc84c4a0f1e7c2fe55b0f43d7d94af4adf1]

CVE-2026-43272: ring-buffer: Fix possible dereference of uninitialized pointer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43272

Introduced by commit 5f3b6e8 ("ring-buffer: Validate boot range memory
events") in v6.12-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f1547779402c4cd67755c33616b7203baa88420b]
stable/6.18: [bc77986f3cb7476637052edf2d87137fa39f153d]

CVE-2026-43273: ceph: supply snapshot context in ceph_zero_partial_object()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43273

Introduced by commit ad7a60d ("ceph: punch hole support") in v3.12-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [c4a52ea236cb375d4a5d3084b687be2bb46d8775]
cip/4.4-st: [c9b6005ee5ff718d57377702829592c429a55ef9]
mainline: [f16bd3fa74a2084ee7e16a8a2be7e7399b970907]
stable/5.10: [36673344b41c31fb502dd0d0113cec1aa96f581e]
stable/5.15: [5788b742007f53406049bef917833a71ddd43f60]
stable/6.1: [757873abfc8ea38592582180aed0f57f0f0cb07a]
stable/6.12: [531a76c5a2e44264cee8a70121e63eb28c1ba728]
stable/6.18: [69e59a87bab0ea31ab2a584fc65e12dafacf8953]
stable/6.6: [9efa154609cdb658f51c7d76b30a09f7e6485250]

CVE-2026-43274: mailbox: mchp-ipc-sbi: fix out-of-bounds access in
mchp_ipc_get_cluster_aggr_irq()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43274

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected code was added by e4b1d67 ("mailbox: add Microchip IPC
support") in v6.14-rc1.

Fixed status
mainline: [f7c330a8c83c9b0332fd524097eaf3e69148164d]
stable/6.18: [95438699c92947155823dcd3918049a07f3cd867]

CVE-2026-43275: scsi: ufs: core: Flush exception handling work when
RPM level is zero

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43275

Introduced by commit 57d104c ("ufs: add UFS power management support")
in v3.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8ef441811ec413717f188f63d99182f30f0f08e]
stable/5.15: [d5c3a1a13f97355c397f9439d79cb04b182958a3]
stable/6.1: [5d186731bc335cc049d4e57ab9f563cfab95593e]
stable/6.12: [aac2fee7513dd25042a616f86a1469b4858d2c5c]
stable/6.18: [78d8e2d6352e8317686ee3a44811ac14c415a57d]
stable/6.6: [aa8d68d97c7f0ef966e51afc17fdbdc372700edf]

CVE-2026-43276: net: mana: Fix double destroy_workqueue on service
rescan PCI path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43276

Introduced by commit 505cc26 ("net: mana: Add support for auxiliary
device servicing events") in v6.16-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f975a0955276579e2176a134366ed586071c7c6a]
stable/6.18: [fa3c2f8d9152344a478abb847081c1b5f84a94f5]

CVE-2026-43277: APEI/GHES: ensure that won't go past CPER allocated record

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43277

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [fa2408a24f8f0db14d9cfc613ef162dc267d7ad4]
stable/5.10: [92ba79074c58e65a6e32713758c5a9aecd33c2ea]
stable/5.15: [616c120dcdf1ce96edcd818e38bce49667f80689]
stable/6.1: [f3740a1562445f36f08afab8af59e37117b3acdc]
stable/6.12: [b6be51a12441136fdf8c49b2525689fbea1856e1]
stable/6.18: [6f5d41984ad896736c23e2fff7c80e15c1319132]
stable/6.6: [e0ec99115e135dbb58e11a0df007c7d4771d4a17]

CVE-2026-43278: dm: clear cloned request bio pointer when last clone
bio completes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43278

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected code was added by dc6364b ("dm rq: do not update rq partially
in each ending bio") in v4.14-rc1.

Fixed status
cip/4.19-st: [60e770aadeab4f0bd497796efafb87fa6df88aa7]
mainline: [fb8a6c18fb9a6561f7a15b58b272442b77a242dd]
stable/5.10: [3d746b639be4b4f5cd8ce2b06aa52dc443f50edc]
stable/5.15: [9a95b98202113045bc1a5bcb30388a500f25e050]
stable/6.1: [8d9ddad561136f7e6a9346767bf97b4d79e38e67]
stable/6.12: [e2e738e8dfbbf83bd2bae0467ec4420cc52da42a]
stable/6.18: [b1c1a2637ebd675aa2d71fee8c70da8791d73850]
stable/6.6: [7daf279c674d515fb22a727a7bbc92aeb35c5442]

CVE-2026-43279: ALSA: usb-audio: Add sanity check for OOB writes at silencing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43279

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [fba2105a157fffcf19825e4eea498346738c9948]
stable/5.15: [fa01973bb79d70c4736b6a4b2de99fbb2cbc8d1f]
stable/6.1: [780dc57794a217b49994fa1d0b42465fb10a00aa]
stable/6.12: [fc9e5af60dc199051dc202ae78e1fe76a9977a5e]
stable/6.18: [6af16f1b8649df4c00d6ced924bdd8b72c885b6a]
stable/6.6: [8995fc0e00b3fee9bf7ecb3d836b635b730c1049]

CVE-2026-43280: drm/xe: Add bounds check on pat_index to prevent OOB
kernel read in madvise

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43280

Introduced by commit ada7486 ("drm/xe: Implement madvise ioctl for
xe") in v6.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fbbe32618e97eff81577a01eb7d9adcd64a216d7]
stable/6.18: [ffba51100ff61792fefbae11ca38ac1987a818dd]

CVE-2026-43281: mailbox: Prevent out-of-bounds access in fw_mbox_index_xlate()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43281

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [fcd7f96c783626c07ee3ed75fa3739a8a2052310]
stable/6.1: [2662ed331a69c0b551f78af58f12eb629a89a36f]
stable/6.12: [01d9a8c2615d436b2b30c19c1afe9fcd5726ff6d]
stable/6.18: [4caae8168d1b808c7d4ff481295292e3f97f90fb]
stable/6.6: [31c4c67dec3362094a6747a171a4848e98542265]

CVE-2026-43282: RDMA/ionic: Fix potential NULL pointer dereference in
ionic_query_port

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43282

Introduced by commit 2075bbe ("RDMA/ionic: Register device ops for
miscellaneous functionality") in v6.18-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd80bd7105f88189f47d465ca8cb7d115570de30]
stable/6.18: [2b96156c927cd83c109e2e3946e6111dce73231f]

CVE-2026-43283: net: ethernet: ec_bhf: Fix dma_free_coherent() dma handle

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43283

Introduced by commit 6af55ff ("Driver for Beckhoff CX5020 EtherCAT
master module.") in v3.15-rc7.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e5780fb0c102b09be1ff6db3f9454c608ac71345]
cip/4.4-st: [56d148427c78376a518e7f946d98ca7effabf605]
mainline: [ffe68c3766997d82e9ccaf1cdbd47eba269c4aa2]
stable/5.10: [0f589ee54fd6d76d3f75e745f7f12c64cbd749e5]
stable/5.15: [accd0599bc8e73b962247c6c6c70ca7aa1f8e8d0]
stable/6.1: [8320727be7ff704e07c87624efc2a4a75f54b3ce]
stable/6.12: [1b1371cd4032ae859838ebc74215f569987bb197]
stable/6.18: [1b1d3c5d58a80a19d017a409aa2308162bab5bbf]
stable/6.6: [1e300c33ef3cc544c2b9c693778fe9490cfe9184]


* Updated CVEs

CVE-2026-31431: crypto: algif_aead - Revert to operating out-of-place

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
mainline: [a664bf3d603dc3bdcf9ae47cc21e0daec706d7a5]
stable/5.10: [893d22e0135fa394db81df88697fba6032747667]
stable/5.15: [19d43105a97be0810edbda875f2cd03f30dc130c]
stable/6.1: [961cfa271a918ad4ae452420e7c303149002875b]
stable/6.12: [8b88d99341f139e23bdeb1027a2a3ae10d341d82]
stable/6.18: [fafe0fa2995a0f7073c1c358d7d3145bcc9aedd8]
stable/6.19: [ce42ee423e58dffa5ec03524054c9d8bfd4f6237]
stable/6.6: [3115af9644c342b356f3f07a4dd1c8905cd9a6fc]

CVE-2026-31786: Buffer overflow in drivers/xen/sys-hypervisor.c

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.18,
stable/6.6, stable/7.0 were fixed.

Fixed status
mainline: [24daca4fc07f3ff8cd0e3f629cd982187f48436a]
stable/5.10: [dbf862ce9f009128ab86b234d91413a3e450beb4]
stable/5.15: [2b985d3a024b9e8c24e21671b34e855569763808]
stable/6.1: [1576ff3869cbd3620717195f971c85b7d7fd62b5]
stable/6.12: [2894a351fe2ea8684919d36df3188b9a35e3926f]
stable/6.18: [446ee446d9ae66f36e95c3c90bbcc4e56b94cde0]
stable/6.6: [402d84ad9e89bd4cbfd07ca8598532b7021daf95]
stable/7.0: [71bf829800758a6e3889096e4754ef47ba7fc850]

CVE-2026-31787:

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.18,
stable/6.6, stable/7.0 were fixed.

Fixed status
mainline: [27fdbab4221b375de54bf91919798d88520c6e28]
stable/5.10: [e3af585e1728c917682b6a3de9a69b41fb9194d4]
stable/5.15: [8288d031a01dbacfde3fc643f7be3d23504de64d]
stable/6.1: [f458ba102da97fafca106327086fc95f3fc764cb]
stable/6.12: [5c5ff7c7bd15bb536f44b10b3fb5b8408f344d0a]
stable/6.18: [d5f59216650c51e5e3fcb7517c825bc8047f60ef]
stable/6.6: [4b4defd2fce3f966c25adabf46644a85558f1169]
stable/7.0: [52cecff98bda2c51eed1c6ce9d21c5d6268fb19d]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com


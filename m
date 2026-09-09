Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776C3C79FB7
	for <webhook@archiver.kernel.org>; Wed,  9 Sep 2026 22:35:23 +0000 (UTC)
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.980.1788993318333012516
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Sep 2026 15:35:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=b6U04CrW;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.43, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66c744a00edso5706328d50.2
        for <cip-dev@lists.cip-project.org>; Wed, 09 Sep 2026 15:35:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788993317; cv=none;
        d=google.com; s=arc-20260327;
        b=gvkezzD9fjgbJcIvr5VIGpzNikFNDM3gH5npyymcaVyMifFBzRcD+bsUxcD9USCxkK
         rYFiYfr0+iTgG++4Z5hIOESguS3vwcE509peh5s4X0uSL6rHcfJYS6HUMqQsqNq01d5+
         gi1k2JovaeRJ6SGgrQTycvj8HmSnWe4PWTxQQj35UzUGBS+fZJoOEXZ2qMkL4rmUNYzd
         O3JD8sSO1au0UiHbRAjiNt07r4Mgifk0av/wVhrALwwSxZ3hL1DyOos7o+3/+plAiJXu
         q2W5JY1X/H1jgIgijcmaB1wM8FDJny2FGZaA04rayAjZtpDNPY/urU0fH/8wEKoZOXHP
         GPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=wVPBdYxMO4rOzJJd84A2UhQmPzEaoVIkbRDEdYiad5Y=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=qwOZys2H3K3Zp6sIqxZC/7HirgS1v3PA7qIuQizw0uXP8znjJ0Gxkg9Y1MJaZuTNfV
         fjJ1md4hX6X7CTllGPpENbhGp6ut59juKX/sck0LFMOPGtqGTPzPlMD2USv3hdgTFqf5
         e7ZxYxGnXtDwR+UrwwGpiKLJNx+IUjgWIeWuVIjoavjTBJDxfjhNWooWAf0n4WqlEQdr
         N8wWTH/1CBqEyB+XMRNhNTFem0eP1fA8k5RjG1A9TZGDxVhKv7fQMlQYldytvPrmftE2
         O4zT9HKyClSfdX6kg/PwcK33nWwrKYF8/JlReR3TiNp8t51mO5HdOiMCx4fOEbfECyev
         hQNw==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1788993317; x=1789598117; darn=lists.cip-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wVPBdYxMO4rOzJJd84A2UhQmPzEaoVIkbRDEdYiad5Y=;
        b=b6U04CrW/Ymptz0hpQ3Hrag5H+cPKh8cT7HVYe1WpgahzYvHyAPCrZMfHNQ44HsH0F
         2kpsYeSuFlpcD4iRpUhccpuOIAx97XHo1MZeUslK7tDKJvImdTYeiuBmC9XQh9UoWqNI
         RQlkoBkiPHYBeUQGcapIIMbbwA81qpPXuTPmKOnevoqMWevigSPDTsRZz3A6XOvQS0Wk
         v42CoI3Nhs9ko9iClU+62au7qdbLpfydLm5bm0X6x96ZqBa7jFNoCbukYNqKJ0Wt5s2K
         QMvxJz6b6dJxIhtQgO8gmHk5Qrm13ks/o02tNrVYKwYHGI8Ie3LXvjCSCHcRd1BOPj9l
         5yPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788993317; x=1789598117;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wVPBdYxMO4rOzJJd84A2UhQmPzEaoVIkbRDEdYiad5Y=;
        b=ZlCpz7lLMd/avcn0M/zdhKz0mKKsQ9t0OBzNizC9W57adEBVhcv7F0kqVPSCQ0X62G
         RVwA1YLHX+Qu1QmWhb0kvBQje0wDM9ux/VCBdRtUlh8tN01dmALe2X/xlCimg+UEdQeY
         PoELGfzCmhcbkGf7bPi/P27K7MjHW+/QlLh+y+GLGr0JWCLl4RstlT///bnrEd3mxh2e
         J7bv0UHstorzYB9cfgZeS0BvuVRTXodvUqTlOmPVGvZHu2swLvYDRd1r0y41MGnKSyJG
         LKNIGtCVFlgbhvk3MCINk+L1bOxm8ZwYdS6/TKt7KLn3r5nsxt2MjyWKWHKAkIs4zts9
         8Qcw==
X-Gm-Message-State: AFuF++ne+8tWQhuWy75YEHPptNLQFgNfRgIvMHnKvWqEcxhoX3PAdToT
	7jOccxoxC6p2BDyfT1ArTI6dKLSZbk+a/b48aI6OMT/X9iVqGoj7GKpRJpIkvcq6wK2fHkfYrue
	wEr3jAvqIzAUSWt5miq9N/3fRxfnPP9UFGI3Tc/hf3P4xwoFsF4nxIRt/SA==
X-Gm-Gg: AYBFou3cMCkbxenlO8NIa7Rq7+xqKXRvleAh3qKXansd8EbqRtunt7Hzhj/SpiMDFqz
	JXu559c6WChQvk44z7Dkvo+nN/X0Gk+C6Dsp1/AZp3KkuOasR+JtjhNGiECWXdtR8yxzzJwyMuN
	i0HpDQXi2CKdCu+3KZMLzD1pL3LsTB1v/o/rCGu9krzTw08/wlKQlwvQyXi6gNakrbmTgB+o2yq
	tUEl4VwlU+7KSNpHjml81l508mrA7BQIxiAKGAEViVzDrq5i2kiyexYeb5kdpZa9cMoxh15DJmD
	dTiiEYXrla2eFCoZj0AprBCQXEmh9gdzMfcuExWDPVfAXqv0HiIt8Mb6hhM6bqW0wkQYVXCbzhs
	u1LydrQv2Isfl1Bd+gciyXlJbZJKfKWXgl4Ywjg==
X-Received: by 2002:a05:690e:108a:10b0:668:8dc0:bcc3 with SMTP id
 956f58d0204a3-66fb572e066mr8895966d50.0.1788993314345; Wed, 09 Sep 2026
 15:35:14 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 10 Sep 2026 07:34:38 +0900
X-Gm-Features: AcwNN1VHn8b_-647UJW40lzLnm3CkWzvfQ_NIAri1dBvd250QDWcZ83N3E-C7n0
Message-ID: <CAODzB9q2cpwLd5rXk=wAmU4W6gMv+J8NzO2fNoNx3mkEsoY-fg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Sep 2026 22:35:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24112

Hi!

It's this week's CVE report.

This week reported 200 new CVEs and 14 updated CVEs.

* New CVEs
CVE-2026-80726: KVM: x86/mmu: WARN and clear role.invalid when
creating a child shadow page

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80726

Introduced by commit a770f6f ("KVM: MMU: Inherit a shadow page's guest
level count from vcpu setup") in v2.6.30-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ec42d57655c690234c14aece6dd3f209778c1d8]
stable/6.1: [9b7984692c18b22d6d61af3f53887fca7fddb0f1]
stable/6.12: [0af4711862c5b818204d40b21f0859ad51c230e9]
stable/6.18: [66bc868a33cf1de43f22a94acd8857e0fe33393f]
stable/6.6: [f33ecb89d352348ed5e625f6747ac51ede254e1b]

CVE-2026-80727: x86/mce: Set up the polling timer before CMCI discovery

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80727

Introduced by commit 1f68ce2 ("x86/mce: Handle Intel threshold
interrupt storms") in v6.8-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a213dfaa2596c1c0dc4dae91c14fbfa499c03223]
stable/6.12: [17ab68d0cf6a41bff61b1e13c6141d9e463736ae]
stable/6.18: [e708fc1566ebd4a2d3f2546e6310d64d362db80d]

CVE-2026-80728: Revert "drm/amdgpu: fix aperture mapping leak"

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80728

Introduced by commit d871e99 ("drm/amdgpu: fix aperture mapping leak")
in v7.3-rc1.
Fixed in v7.2-rc7.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [b96c529cd2551b78316a4afa3237b2ed96ba03c8]
stable/6.12: [96d26143882f9cb47dcc1f3dd4e26d047e53ab9b]
stable/6.18: [a2e326c52c4bcecc033cd3ca2733fdbe30fbf55d]
stable/6.6: [7380f1bfe9d7ed3a4ca9d99a5c4df840fff9af2a]

CVE-2026-80729: mm/huge_memory: initialise workingset state before folio split

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80729

Introduced by commit 58729c0 ("mm/huge_memory: add buddy allocator
like (non-uniform) folio_split()") in v6.15-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aca1f2d5de17e138bc6c4859126b77e516b82541]

CVE-2026-80730: ring-buffer: Fix crash passing ERR_PTR to kthread_stop()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80730

Introduced by commit 64ed3a0 ("ring-buffer: make use of the helper
function kthread_run_on_cpu()") in v5.17-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [91542863abade2fd4f2b361991f5386ad9d19c8c]
stable/6.1: [51d78fad30dd9ae45721224103662bdbcf210096]
stable/6.12: [8532983c312e8b875d7c9e440f8ee4674ea4b711]
stable/6.18: [6dd7a06894d6d3dc84319bd0b7d1a7c27df9d902]
stable/6.6: [93e7044b548a72022208595d2c1b188bb225ce83]

CVE-2026-80731: net: remove CAP_SYS_RAWIO zero-padding in dev_validate_header

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80731

Introduced by commit 2793a23 ("net: validate variable length ll
headers") in v4.6-rc1.
Fixed in v7.2-rc7.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [3b9a324e646d3657a8d9806dfbfe4f3e4066e882]
stable/5.10: [fa6d98dd925e72fc028b26a0cbbff9d2f0601ff6]
stable/5.15: [8fc9816404166a90ed8d544dc52482fafffb6d9f]
stable/6.1: [b0f92a5731dc82556a9ae005cc35f71ab136307b]
stable/6.12: [74e035f07f53feca09e2352e77fccb09cad5e208]
stable/6.18: [dbb30dc943a93e083f1e531bfdc6779e57de40d0]
stable/6.6: [99df6b7a713f96eda206680d100b76e15f9d9b69]

CVE-2026-80732: ata: pata_sl82c105: fix bridge revision use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80732

Introduced by commit 44c1013 ("PCI: Change all drivers to use
pci_device->revision") in v2.6.23-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7700a31039cdc6715cb6cce7e7a664ee4e945f67]
stable/5.10: [1268ca9418e2217f2b60705cf4a280b689b26678]
stable/5.15: [a626dfca96041842053cf2d1efceb436c4cd8dcf]
stable/6.1: [5ef87b1b4656d675440ceab32a56e69ad958d3a1]
stable/6.12: [dc711fb137b33c12e6ca22b6a9c9b9f21d49e4de]
stable/6.18: [a837deeaa37cc3f0e8c4e5c096787047f272c956]
stable/6.6: [fa0dca89b4fb0909ffda7b9ab6051af33270f95e]

CVE-2026-80733: net: remove WARN_ON_ONCE() from sk_mc_loop()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80733

Introduced by commit f60e599 ("ipv6: protect skb->sk accesses from
recursive dereference inside the stack") in v4.0-rc7.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b8a39a09ae4eaae04309e1e38ed6a1101d967496]
stable/5.10: [97133c4d42654578fab95abe47359ebe784dde18]
stable/5.15: [f625c742b33dc137c209dd13d1c5f12b1c18d71c]
stable/6.1: [ad7fa2f411cb30f63d6725f111be134064cdb718]
stable/6.12: [ad7dbb1d14b1b4406eca8ef9478e8de312ba0cfe]
stable/6.18: [c8f256dc849205ccb2bd78bd99a3497b972b44e0]
stable/6.6: [d2adc4e80b29e58b5162ae09f0f657a215806c8c]

CVE-2026-80734: btrfs: initialize inode mapping flags for cached inodes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80734

Introduced by commit ecde48a ("btrfs: expose per-inode stable writes
flag") in v6.15-rc1.
Introduced by commit cc38d17 ("btrfs: enable large data folio support
under CONFIG_BTRFS_EXPERIMENTAL") in v6.17-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ef349734a93227b45f65fc50a3311d1cc5f03e9]

CVE-2026-80735: ovpn: ensure socket is owned by ovpn before deref sk_user_data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80735

Introduced by commit f6226ae ("ovpn: introduce the ovpn_socket
object") in v6.16-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [59aed1eb60d70678a53acccb0cb337a26ce6680e]
stable/6.18: [61fb3cca40ff938671474f4a16adb908c19032d7]

CVE-2026-80736: thunderbolt: Fix bandwidth group reservation indexing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80736

Introduced by commit 52a4490 ("thunderbolt: Reserve released
DisplayPort bandwidth for a group for 10 seconds") in v6.9-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2ee4d47aacbd2ba456092eeec670dba35fde291]
stable/6.12: [0bfb67ba366cd68d1d0ad935760577bae1d5df27]
stable/6.18: [9977321835c7ae71d12a43bed7baa5bd514d01c3]

CVE-2026-80737: serial: amba-pl011: synchronize DMA teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80737

Introduced by commit ead76f3 ("ARM: 6763/1: pl011: add optional RX DMA
to PL011 v2") in v2.6.39-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [440915499231e9db1c361aa45bb702e8fd3b4a32]
stable/5.10: [a38fae9d212e2d3ed5e9ec0ef773f8c0a27fb76e]
stable/5.15: [44bd0ecc3444882d08ecfbc2b2418d2f463d3186]
stable/6.1: [f70c9d4fba46463a5b1c7b3ee9ee3b40c90dac03]
stable/6.12: [9f6989e477f03a4721d34bb4b09b17accd40283e]
stable/6.18: [5974cb66681eac367107b05924744d7e3b49d41c]
stable/6.6: [c8c8e895f65fbf71ea6224e27cf8dab91b776e0d]

CVE-2026-80738: bpf: Check sk_state before sk_protocol in bpf_tcp_*_syncookie

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80738

Introduced by commit 3990408 ("bpf: add helper to check for a valid
SYN cookie") in v5.2-rc1.
Introduced by commit 70d6624 ("bpf: add bpf_tcp_gen_syncookie helper")
in v5.4-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [31a420a822ff92e2090bd5d65efe8e34e2d6d9b8]

CVE-2026-80739: net/mlx5e: TC, Check if flow is PEER before acquiring
devcom lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80739

Introduced by commit 04de7dd ("net/mlx5e: Infrastructure for
duplicated offloading of TC flows") in v5.0-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6ddfba2ea98db21b001e0e5c472499156224650c]
stable/6.12: [585df8643081e6f616579bc52cd49ac823a57c82]
stable/6.18: [ff9e7d5e3500be389ce7a0e46db3a77149830bc9]
stable/6.6: [607adbda01053abf5f93e322fe39325da8828cb8]

CVE-2026-80740: drm/log: Fix infinite loop when scale is too large for display

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80740

Introduced by commit 8a4b913 ("drm/log: Add integer scaling support")
in v6.14-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f4f2bba28df9b9aaa00262a462139dbbcdc38d9f]
stable/6.18: [a7d172b27aa3e1ad56e39949bfe4e5caa25fb20b]

CVE-2026-80741: drm/log: Fix out-of-bounds read on empty message length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80741

Introduced by commit 25e2c2a ("drm/log: Color the timestamp, to
improve readability") in v6.14-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [60baa179ed1333535f6e2da4133511db55278ee4]
stable/6.18: [16a2716910ecf7d31bf3c033ee7c506a0b00b2ee]

CVE-2026-80742: af_packet: Don't send zero-byte data in tpacket_snd().

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80742

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6bcd76c134c55c697148acb5c0194e9666abdf84]
stable/5.10: [dde212f8622f5cb36223fff1ebd6e6f2a3dc61fe]
stable/5.15: [80a702964467b998d254f16cc61c2c9a20540c9d]
stable/6.1: [7521e691c7c4f2231634c95053281ac888d1f452]
stable/6.12: [3fa110f9e2ea96f567f2194c673c4bc327640111]
stable/6.18: [98c5914d6b7bd4b4675535908e57dea31f1efd6a]
stable/6.6: [1fc70b3d513bafb16b17540178870ef46e81c0bb]

CVE-2026-80743: ASoC: xilinx: formatter_pcm: pass aud_drv_data to irq handlers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80743

Introduced by commit 6f6c3c3 ("ASoC: xlnx: add pcm formatter platform
driver") in v5.1-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f12afefb7b01f94d6d66d397f323a9914edbf70e]
stable/5.10: [7d857aec162fb02d10ce326aecc1ac7509c31f43]
stable/5.15: [a85315f2eb06adc5597a7103e1910fc7d0d35ffd]
stable/6.1: [721cfeb0b9572084435695ae535411b921d1ea68]
stable/6.12: [0d58a70b6dc7b65772e3ef7c43beb91882cf9ed5]
stable/6.18: [f51a540b14eecb8667bbe450192318271b87631e]
stable/6.6: [b4ef887bee4d3c177adac5d1eab8b2de31b08ac3]

CVE-2026-80744: netfilter: nf_tables_offload: suppress WARN_ON_ONCE
for ENOMEM in abort path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80744

Introduced by commit 63b48c7 ("netfilter: nf_tables_offload: undo
updates if transaction fails") in v5.5-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d02f592064347e0c1e0d84f24941ad338838cc48]
stable/5.10: [2319033c4bf8bdb275a9e4e1f7af9bf8a457ad79]
stable/5.15: [6ee3803c22b72508c5baf1e5aecb21301b714be0]
stable/6.1: [09bda4b6df222fd1819e8f188c3a6e90caf546d3]
stable/6.12: [7ce9851be6f2b019e96e105a9de99715aec6deb4]
stable/6.18: [4a923fe60939a194777bc605036ce2147ab00c9d]
stable/6.6: [17c132e18ca5d1641ddbaed8d0e6ecfd1d38fa0b]

CVE-2026-80745: regulator: fp9931: Fix VPOS/VNEG voltage selector table

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80745

Introduced by commit 12d821b ("regulator: Add FP9931/JD9930 driver")
in v6.19-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66694b5f90f3876fccb87bbd02b453cdc33b3ae4]

CVE-2026-80746: clk: qcom: dispcc-eliza: Fix disp_cc_mdss_mdp_clk_src
RCG stall on Eliza EVK

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80746

Introduced by commit 0e66f10 ("clk: qcom: dispcc-eliza: Add Eliza
display clock controller support") in v7.1-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ef00630c5c0b7b2c08aba7643f47594952d357e]

CVE-2026-80747: drm/amdkfd: Add bounds check for CRAT subtype length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80747

According to the .vulnerable file, this bug was introduced by commit
5b5c4e4 in v3.19-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6e7566ba4739dd573c331adde1c96690f7a567bd]

CVE-2026-80748: mmc: loongson2: Fix sg iteration in data reorder functions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80748

Introduced by commit d0f8e96 ("mmc: loongson2: Add Loongson-2K2000
SD/SDIO/eMMC controller driver") in v6.17-rc1.
Introduced by commit 2115772 ("mmc: loongson2: Add Loongson-2K SD/SDIO
controller driver") in v6.17-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [00179ed9fbe07799676e2cb63c4e7f0e7cd80a5c]
stable/6.18: [8f7f7a6d5aed8f346a1c936fba02033c73a337dc]

CVE-2026-80749: drm/connector/hdmi: Fix out of bounds memory read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80749

Introduced by commit f378b77 ("drm/connector: hdmi: Add Infoframes
generation") in v6.11-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ecf8ba763d0ffe0673538eb4bf7806f20455d19]
stable/6.12: [d9f7454c185c0c7f0973e11d62ad6c06862c324c]
stable/6.18: [e5b527804a1ea4f70e139179d3062cf5de8c06ab]

CVE-2026-80750: pmdomain: mediatek: fix remaining %pOF after of_node_put()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80750

Introduced by commit c29345f ("pmdomain: mediatek: Refactor bus
protection regmaps retrieval") in v6.18-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e013bc8b941bd52c8e3a99798d0ae8792cb71ca]
stable/6.18: [970b9c83a07c405fdd32bcce7cc4c9e670e58875]

CVE-2026-80751: pmdomain: mediatek: mfg: initialize prev_o in
mtk_mfg_attach_dev()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80751

Introduced by commit f08e7a4 ("pmdomain: mediatek: Add support for
MFlexGraphics") in v6.19-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [090a95dbe13df9965279b588d97eda134831769c]

CVE-2026-80752: Input: psxpad-spi - set driver data before use

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80752

Introduced by commit 8be193c ("Input: add support for PlayStation 1/2
joypads connected via SPI") in v4.12-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [732f38c36059e68ba3b4b89c56911d777fd3185c]
stable/5.10: [e980066e434a9c74ff1665ed9140427e95b0ee7c]
stable/5.15: [1bba6bd6861b1e0c8ecf20cd1892f0d3877c02a2]
stable/6.1: [86531cdfb3a03213e2569deed5195412a4e3f7ee]
stable/6.12: [1edcb7ffee7ac4dc35cbe5bbd0e27bac3614ebe4]
stable/6.18: [8d622c58205adbc8af19864e277386528b671345]
stable/6.6: [da6b8b05db0cf43e0cc198431fa8ee9739b3b817]

CVE-2026-80753: ovpn: run deferred work on a module-owned workqueue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80753

Introduced by commit 3ecfd93 ("ovpn: implement keepalive mechanism")
in v6.16-rc1.
Introduced by commit 11851cb ("ovpn: implement TCP transport") in v6.16-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e9714db8041763f59dde152c812b96b3de05c6d9]
stable/6.18: [b5fe67111e63a8a81ec31056c4475509076fd266]

CVE-2026-80754: Input: synaptics-rmi4 - fix F55 transmitter electrode count typo

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80754

Introduced by commit 6adba43 ("Input: synaptics-rmi4 - add support for
F55 sensor tuning") in v4.10-rc1.
Introduced by commit c762cc6 ("Input: synaptics-rmi4 - propagate
correct number of rx and tx electrodes to F54") in v4.10-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6058f0fea10f3caf63a435677358d1b8e9325114]
stable/5.10: [6484e00d6778fdf2209cd75940bc3902b276457f]
stable/5.15: [db4e20265ebda729610ca5cf45ca9437462c3f36]
stable/6.1: [a6d9646e77da7cab2dff7043a8e9f75e23b836bc]
stable/6.12: [9759502f5cd71805923457f183ae5b9533e20c7b]
stable/6.18: [9b184c8337c6e12df129399007735a7fbcbbcb7b]
stable/6.6: [0739c65e799d4a93fe573ed23255a71fcfcc5438]

CVE-2026-80755: selinux: reject a permission value exceeding the class
permission count

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80755

Introduced by commit 55fcf09 ("selinux: add support for querying
object classes and permissions from the running policy") in
v2.6.23-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d14b5d0e97fccd27974fedc03b903408872907fd]
stable/6.12: [6c2ab7c4549f4f2305848df834e784651dbf1676]
stable/6.18: [9b46fba7528f58ca09eac67ec7d474ff1e9af066]

CVE-2026-80756: selinux: do not cancel a policy conversion that never started

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80756

Introduced by commit 02a52c5 ("selinux: move policy commit after
updating selinuxfs") in v5.10-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e5c0235a3c4e9eb047a16cd02323fe4ecf2f570e]
stable/5.10: [2d29983104f06f5b0babcd5a25a0f0408272cd27]
stable/5.15: [a4f182f8715cb0819445f0850cd5436828f4bafc]
stable/6.1: [1059789ae9f99cbbe3a78e361e9c0976beb5958b]
stable/6.12: [a42932c6aa33d0aac683cacdf1ec7009b955ba5d]
stable/6.18: [1b4ff94ae7c580c880291519fb0e3e2bd075beef]
stable/6.6: [1acc317d67a755a45e32419a15d70e403fa43f0e]

CVE-2026-80757: selinux: reject a class permission count below its
inherited common

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80757

Introduced by commit 55fcf09 ("selinux: add support for querying
object classes and permissions from the running policy") in
v2.6.23-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9a82dcd98b6e6e11cfd162410967951f12152528]
stable/5.10: [2002ff745db64ac83ee1bb9ff78196d2d68bfdb3]
stable/5.15: [38d91446630a20ce8c2a981810deea81fd61a3b5]
stable/6.1: [638213f2e6ea52c06a25861616781338d154db35]
stable/6.12: [a63011c009ea79439b800a05602b880eb4adbb05]
stable/6.18: [acd5b09be98fd38b7392307880156fb0452a7276]
stable/6.6: [2b7ffd7921fcbfe408fb7b372e47454e45b1e6a7]

CVE-2026-80758: futex: Avoid private hash use-after-free on final put

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80758

Introduced by commit bd54df5 ("futex: Allow to resize the private
local hash") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c7efabfbaf796f11000a46094a69955a01ec6cc]
stable/6.18: [dba60d26e9dda3e157ad6b0934d4232f6c6904ee]
stable/7.2: [25408c62ed4ebcd491d0e9e4b4a5b512547512e4]

CVE-2026-80759: Bluetooth: hci_aml: validate firmware segment lengths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80759

Introduced by commit 37bac77 ("Bluetooth: hci_uart: Add support for
Amlogic HCI UART") in v6.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2bf6b9baca9372ea51b6d0f2820dc9bf29a83ef4]
stable/6.12: [7733b01ed13685773ccda91035a46f87d4cfef7c]
stable/6.18: [e1534d49a7b8ba728e84b020f6d802aa1cb759d9]
stable/7.2: [2763b8bcb504e30ec955474f51b99ce42fc62f3b]

CVE-2026-80760: Bluetooth: MGMT: reject HCI_CMD_SYNC params_len above 255

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80760

Introduced by commit 827af47 ("Bluetooth: MGMT: Add initial
implementation of MGMT_OP_HCI_CMD_SYNC") in v6.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d95286b6d6e8f1d304da7522bfa6860fc017e48]
stable/6.18: [b7d9edcf9fe6e9ec3a2e80ef9e8d44ef9b4f2894]
stable/7.2: [6e1c44878aa3ee7336efeaf01414b030b0a5c273]

CVE-2026-80761: Bluetooth: ISO: zero the sockaddr before returning it in getname

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80761

Introduced by commit ccf74f2 ("Bluetooth: Add BTPROTO_ISO socket
type") in v6.0-rc1.
Introduced by commit 0a766a0 ("Bluetooth: ISO: Fix getpeername not
returning sockaddr_iso_bc fields") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [884cf2cc957da7ac178a0e6c6c69ddfec0481cc8]
stable/6.18: [1f6d1f2611af0eb36b133a41d29ffd2cc2601615]
stable/7.2: [190b719b787eb4ca6c25b12fab224806f9108b06]

CVE-2026-80762: Bluetooth: hci_sync: Fix accept list UAF during suspend

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80762

Introduced by commit 182ee45 ("Bluetooth: hci_sync: Rework
hci_suspend_notifier") in v5.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f57b399c4fa1501b2d5451f52d861ece86bcf3db]
stable/6.1: [bb5f5414d1a6272a16f68684e998f4063dd19f57]
stable/6.12: [87ad116ac3abc6f2ce2b5b6c488f633003581eee]
stable/6.18: [fe93a697a7a92fa9adf78c9ff67a10db3193290c]
stable/6.6: [b5181516a9f5c2fdb3271cdad72a5b16c6963a44]
stable/7.2: [29c59212a507804d7616b8abf491d30b4ab8e75f]

CVE-2026-80763: Bluetooth: hci_event: validate LE Set CIG Parameters response

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80763

Introduced by commit 26afbd8 ("Bluetooth: Add initial implementation
of CIS connections") in v6.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0acd4eeb4b225b9bebbf9ef96cc10cdd79b94899]
stable/6.1: [9e05783d0bb96a7b853cc058a7c7de2dc4a62154]
stable/6.12: [a34df5c4a439cfc04565fa5be608ed1e53134f1f]
stable/6.18: [e3f82e8f2a5915f533b57a065e9a045aa2ee03bc]
stable/6.6: [26741d178f31932c9018b36b7953e6dc391436a4]
stable/7.2: [6fc540e835dddb518cef3ff522b780f701cd03df]

CVE-2026-80764: Bluetooth: hci_event: fix LE list UAF on reset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80764

Introduced by commit a4d5504 ("Bluetooth: Clear LE white list when
resetting controller") in v3.19-rc1.
Introduced by commit cfdb0c2 ("Bluetooth: Store Resolv list size") in v4.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [33af47e847fe4a28b109673affb5874015d54f5a]
stable/6.1: [8e68c380290b1dd64a0a512ce66d0264130c46ed]
stable/6.12: [d57702d4c55633c243da5a2fec37ae2ad4adb621]
stable/6.18: [39a3afb91be3cb465f46ce7a8e5696d9e33edf93]
stable/6.6: [0628cc9b2fa29985a7b8c774741f8a736b0f5e7c]
stable/7.2: [25b05e3ce31d954540e99954bcc66cbceb27ab35]

CVE-2026-80765: HID: hyperv: validate initial device info bounds

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80765

Introduced by commit b95f5bc ("HID: Move the hid-hyperv driver out of
staging") in v3.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [934b7778aa7b7c8f6bb073d2a73ba3674885bae0]
stable/5.10: [e0d5d3e45e142b7ef7525654aaa54d3e986002a6]
stable/5.15: [390d3d9c52a710fdc9de95a537747397c0c671d1]
stable/6.1: [8614c043b11cc35ffebd35542ab4da275f8f923d]
stable/6.12: [f84d777574b748b1a488723ca7be9d87a301a872]
stable/6.18: [608f8fd8c0f7b6268da43509447802955f210aac]
stable/6.6: [334271d3812ab3197c95b4593bc6745f8d189114]
stable/7.2: [c894143c508a7e063aab9f73c9e835ab40121283]

CVE-2026-80766: HID: uclogic: fix use-after-free of inrange_timer on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80766

Introduced by commit 01309e2 ("HID: uclogic: Support in-range
reporting emulation") in v5.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [506fd50a9027340f0e9dcc587d10ccb03312dba6]
stable/5.15: [f40243358b407aec362fe305fabfcdc94a3abd89]
stable/6.1: [dc5108f18f58870a8dd4203a02a47e571a2be7f0]
stable/6.12: [e750cdb6de009aace3c77f37fe2173f96175e8e4]
stable/6.18: [849e537160bbb77fe419ecc3944bfe125dcd441b]
stable/6.6: [9d77ac82e57ead056cf3f71d347083ed9244ad90]
stable/7.2: [f13d0a00204b05e62336da0ab72ea0d87b56690c]

CVE-2026-80767: HID: sensor: custom: Fix use-after-free in enable_sensor

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80767

Introduced by commit 4a7de05 ("HID: sensor: Custom and Generic sensor
support") in v4.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ad8fb82b04422f49530d2aa2753cc81d1c60102c]
stable/5.10: [c2be74b0272b7f8f60739e7aaf0d36c0befe7136]
stable/5.15: [d7cbea1d342a16ec96d9eb3d7bd0ba2d4b2f2855]
stable/6.1: [d37ff4e3635c18af907f25712596f8ccec323751]
stable/6.12: [244a1cb638370490ed74a8adb5cc3f1212602e32]
stable/6.18: [8406d4b69d48bc72fb6f8812a65a17a1f903440b]
stable/6.6: [2ce90cfc6646a32100feabd7110ae0352aa01167]
stable/7.2: [7bb79a3cf45e0805aef74457e19deb77e18cf196]

CVE-2026-80768: HID: ft260: fix stack-use-after-return write in I2C read race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80768

Introduced by commit 6a82582 ("HID: ft260: add usb hid to i2c host
bridge driver") in v5.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf3e39df3a397fd82967a31d17c4e02c7feab221]
stable/5.15: [2b907001e8a83cdb71e899fd3d77ab51e2c03f10]
stable/6.1: [90e9298f2e4336a0e1ca7eeb173403df78056164]
stable/6.12: [5aa5a1b7cc4b4bec5497ad9ef113fdfe37b232f3]
stable/6.18: [a8e1f970f9040294cfd9100c681c32af6c2aeec0]
stable/6.6: [460514d46e8892189fc933a1b4433811cfa5c309]
stable/7.2: [77832d8f1c81d9f84b6b54807fb278586001d754]

CVE-2026-80769: HID: rapoo: fix missing hid_is_usb() check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80769

Introduced by commit b3b1c68 ("HID: rapoo: Add support for side
buttons on RAPOO 0x2015 mouse") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b57af2448268c30c25509a832b6ff6dc27176b28]
stable/7.2: [49b6fd28fbcc0b6457e16e25c7617f63449d4808]

CVE-2026-80770: HID: nintendo: stop device IO before hid_hw_stop on
probe failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80770

Introduced by commit 2af16c1 ("HID: nintendo: add nintendo switch
controller driver") in v5.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f74d3bff6fe04a64e02ab3661d2e0d554565aa6]
stable/6.1: [c2f3d51c7f5222f5b51e0c90f02258d82e1b44dd]
stable/6.12: [03a84f9f88b42cd49752ec0259922b67e4b88598]
stable/6.18: [5efcd7bbfaaec67d137c99aa0940fa34375db27f]
stable/6.6: [c023443f0e6cfd257846b6515c93c1ea08026593]
stable/7.2: [2e0d98dc8a6dea5fc2b72bf66e0dcbd5488644b4]

CVE-2026-80771: HID: nintendo: register input device after capabilities are set

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80771

Introduced by commit 2af16c1 ("HID: nintendo: add nintendo switch
controller driver") in v5.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d723bc1fe2e72b9252234e94c11af644ec477bf7]
stable/6.12: [3288bec1a21d582b504344380139cdc0e88ebe4d]
stable/6.18: [268679f501386ad46405d42c2bcf89384cb5e256]
stable/7.2: [27dc4b8eadac73b3c3cc526c8547d8b4ae8528be]

CVE-2026-80772: HID: nintendo: fix out-of-bounds read in
joycon_ctlr_read_handler()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80772

Introduced by commit 2af16c1 ("HID: nintendo: add nintendo switch
controller driver") in v5.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [27b376b945c0aac46fcdfcc950b14a85b874b557]
stable/6.1: [33ea29f8b6141f2d265de807e110a6435b355cb0]
stable/6.12: [addca61f9a23c0d20a387c2040e70479f54518e1]
stable/6.18: [51cfd1adbe7a46bb08af162abb3ab3b6820e2d15]
stable/6.6: [bd397c4123a4bc084913d8c7fdb40ef94e9f8172]
stable/7.2: [34725ed4719da424113db8449fb5485aaf71a913]

CVE-2026-80773: HID: huawei: fix missing hid_is_usb() check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80773

Introduced by commit e93faac ("HID: huawei: fix CD30 keyboard report
descriptor issue") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4cdb6b4b34d7823254f6e1b22faf56c96ac57fb9]
stable/7.2: [9acc2463991cdb0856fdbd63fd7178102c1ed73d]

CVE-2026-80774: HID: asus: fix missing hid_is_usb() check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80774

Introduced by commit 00e005c ("hid-asus: check ROG Ally MCU version
and warn") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [02bf61dfb44f17ec187d1da1a82495951bbd12df]
stable/6.12: [bdb2e0a2a359e473ca5619e35adee89028697239]
stable/6.18: [8b5debb6252cd1e2b6c7adf8f95761a0e743d2cf]
stable/7.2: [ee883906cf6685d753af9c2d2ca9fd6f63197726]

CVE-2026-80775: futex: Fix race on the initial mm->futex.phash.ref allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80775

Introduced by commit d9b0532 ("futex: Move futex_hash_free() back to
__mmput()") in v6.17-rc5.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bde0238083647381d4747355c5a19115a3422b96]
stable/6.18: [86d12b34bafc9a4c271a9edefea88855a934d6e5]
stable/7.2: [c4b4972d8edcdf50b6518f55119e129d2f668a10]

CVE-2026-80776: futex: Fix race in futex_pivot_pending() during
private hash resize

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80776

Introduced by commit bd54df5 ("futex: Allow to resize the private
local hash") in v6.16-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e7ff730dd96519a333d1570edf1c3fabb6d3629]
stable/6.18: [4a7e941ca29a608c6244cbd028d3599ecaef7207]

CVE-2026-80777: futex/pi: Plug private futex exec() race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80777

Introduced by commit 80367ad ("futex: Add basic infrastructure for
local task local hash") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c5f0bc9fd1cec4a00400cc727fcde03e0fde17cc]
stable/6.18: [fdf538b2e69653ff740e84042245018e5680cd7b]
stable/7.2: [d7944cee62ec6cca1c90780a766960a57d3b4bb8]

CVE-2026-80778: futex/pi: Reject cross-mm private futex owners

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80778

Introduced by commit 80367ad ("futex: Add basic infrastructure for
local task local hash") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [59b3732f95dda1fbd2234514d35f4fb6b5bb6d85]
stable/6.18: [2b92e5562653b5293529f63b0300837d9dcedbd7]
stable/7.2: [43b148d796aa338858792d0167cebdc12b8cb4b9]

CVE-2026-80779: net/ionic: avoid OOB TX partner lookup for hwstamp RXQ

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80779

Introduced by commit 8eeed83 ("ionic: Add XDP_TX support") in v6.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d92255b405fb6f5acca408239ccd742e0a42c9cb]
stable/6.12: [881a805a8029ba48c0ce81c6674910f8d83f7afb]
stable/6.18: [39fc615e355b65b8d43be30da57aa95ae6eaf688]
stable/7.2: [ea081b4435515ac7177eb598a3c0678d1b9e7911]

CVE-2026-80780: HID: pidff: fix OOB write when hid->inputs is empty

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80780

Introduced by commit f06bf8d ("HID: Add hid-universal-pidff driver and
supported device ids") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [67bb1074e3d2d12fa059a9cc707e89398a4e4704]
stable/6.12: [ad9330f7e74a97842815a291a0d7389ed2f34504]
stable/6.18: [4529c03c3da8f91392cd630453452f569973f4cd]
stable/6.6: [2e0471bf3ab2a6b7eedcc3b8a2a17286b6a9ae1a]
stable/7.2: [86b63adfa5e132beac4be72668fdf9128fe51d2e]

CVE-2026-80781: HID: core: fix OOB read of field->usage in hid_set_field()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80781

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a13cdb19fcb223ed41bdab3bab42b98dba87e90b]
stable/5.10: [465544b3d6602cfbdc2305d5cbfb7f4954353b63]
stable/5.15: [4993e1ab85d7d3f4a40d81852170f9665483bbd8]
stable/6.1: [313ead1abed945544703b100a12c5a10fdf78409]
stable/6.12: [a38212687519f2a72f43e62dec1348a690412404]
stable/6.18: [9a1d7c5f0d82e8665715d5e47c9410c6a97e3748]
stable/6.6: [c1d9c16af51cc6ff92a5a062617d3b022dd01078]
stable/7.2: [cbcc0e8dea499e5ca86b583372ccb1815cccc570]

CVE-2026-80782: HID: magicmouse: do not keep a stale msc->input if no
input is claimed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80782

Introduced by commit f1a9a14 ("HID: magicmouse: fix race between
input_register() and probe()") in v3.9-rc6.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0af3b89705688af01aa06025b84fa7a1e06ba6cc]
stable/5.10: [c3597923932bb90d4fc2186aef552f6677175e4a]
stable/5.15: [e0c224c93d10ee38854fdf24c815108aedd3dcb3]
stable/6.1: [403cc9bd6ccb9fbe68d501c3236e5a6dd5504e14]
stable/6.12: [9bdf8c7bfd79f1090e61d28f969b32880fd77bb3]
stable/6.18: [15b60ade825c8ce9ec560048a4ae3747e4572be3]
stable/6.6: [3d7a7bac4c75f25b2513505a0ac5ba909588ed2b]
stable/7.2: [2ef16934e069d5f771e989d6ee5c3ece5042f3cd]

CVE-2026-80783: HID: magicmouse: prevent unbounded recursion in
magicmouse_raw_event()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80783

Introduced by commit a462230 ("HID: magicmouse: enable Magic Trackpad
support") in v2.6.37-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [db8d634128d2ba88d79c0b601e983ebe14bb0519]
stable/5.15: [26c45abed62536aabf4033fb6d64cf72e93374e9]
stable/6.1: [8a10a624996f16628234306b46f0cf36707d78bd]
stable/6.12: [bec338b07beb883726b32192c8f01c601bc76fda]
stable/6.18: [70589b0c005db003f6d8ae4db3c4d54fed7b83e4]
stable/6.6: [d16df755b4493b6d37803c628b2c621d096796a8]
stable/7.2: [d095de37f78c5f32a4252ef0f99b84ba76550b86]

CVE-2026-80784: mptcp: pm: fix memory leak from alloc-during-teardown race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80784

Introduced by commit 9ab4807 ("mptcp: netlink: Add
MPTCP_PM_CMD_ANNOUNCE") in v5.19-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [efc33b5102ff859bacd390a5f30112d8e0c084c0]
stable/6.1: [f48341830e4202db3fe884b819b2db6740f0537d]
stable/6.12: [b2a0b55bf613bd3e81ed26a847b0f6b8e6b7f804]
stable/6.18: [9fe5eebb664ecdba88f3fde18062d94b1d1c465f]
stable/6.6: [bb32e9a6a9a9f99eeda16c4efe443400f3e43892]

CVE-2026-80785: fbdev: serialize mode sysfs access with lock_fb_info()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80785

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [061db6b7a910b8378f3b2df64f8c0a3ddc6e85f2]

CVE-2026-80786: fbdev: Wrap user-invoked calls to fb_set_var() in helper

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80786

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f611e5e5f3327cf2e2daabe6ee5acac58cc784e]

CVE-2026-80787: nvmet: pci-epf: fix use-after-free in
nvmet_pci_epf_exec_iod_work()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80787

Introduced by commit 0faa0fe ("nvmet: New NVMe PCI endpoint function
target driver") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9e9bb757971485b4e8414b1744507af186d72c9]
stable/6.18: [20be486d1c225402b067391e72ff5b0dd8ebff76]
stable/7.2: [cede8d2852570c79b9bbb9527255ae9ed3317b82]

CVE-2026-80788: nvmet-tcp: Do not WARN on remotely-controlled
oversized SGL allocations

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80788

According to the .vulnerable file, this bug was introduced by commit
872d26a in v5.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [737a3b535247226f6e1a7988fd9d6e63e7d6fc71]
stable/5.10: [8d01f0d0e96485e39ad89b859ef85e1dc3020465]
stable/5.15: [7b6a54d4e7b0da423c2b53ed293fd36b16c0b19e]
stable/6.1: [e7077e6c45423dd2bb7de7b5fc4b018a8e6c4741]
stable/6.12: [c509f20be1cabda3087810bb2d658d66b3f31f35]
stable/6.18: [9c95f7e66c62ee6c6abedcf1c04311f430ff5833]
stable/6.6: [86cc450022473c4a29b43a09f3ec22a9ef566dac]
stable/7.2: [9b770e40bc00381e5ebf53653de5776773415be3]

CVE-2026-80789: nvmet-tcp: bound SGL data length before allocating
command buffers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80789

Introduced by commit 872d26a ("nvmet-tcp: add NVMe over TCP target
driver") in v5.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a3f00262a044e8e15064b1a6860968bf0500bf4]
stable/5.10: [f6e51b09cbaa5f6f6e6a3a9dafa666f76c37aab5]
stable/5.15: [f63e89a0310264264923f84406dea05fe752de62]
stable/6.1: [0952541b153e258b99d39cdb03ea6919fdeb41d0]
stable/6.12: [d2acc96c528d589f5827cfb90e8e9229dd9d8cb4]
stable/6.18: [6d27199ebe8cb223022150f74be13f154a964474]
stable/6.6: [25ad03d5c0e858c4b63f1e4b6d461d2af1b30b22]
stable/7.2: [d895e66628f939edbb98608f6e033d3d39e6e546]

CVE-2026-80790: nvmet-fc: fix invalid free in LS IOD error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80790

Introduced by commit c534320 ("nvme-fabrics: Add target support for FC
transport") in v4.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ba98d6796d12258e837ece065d2ecb59d76ce4ff]
stable/5.10: [b189c6e408896ccc23d2e76d7738847cdebf1532]
stable/5.15: [449e9c4f8db84ad9d9bb288029b230bcf590faa2]
stable/6.1: [1a8f007faefe8c226ec65896589f8d59b0a8d5a5]
stable/6.12: [371fb1bf902adaa59be32bd7e904a5317e604fd0]
stable/6.18: [8bce9cd08aae4283badf8ddc11fbb6f57b75a81e]
stable/6.6: [d094582cce9c08516d714e7436a8f3b9211dda90]
stable/7.2: [94334ea92f4d7535f66f86e33681efa94827eddc]

CVE-2026-80791: nvmet-auth: zero the AUTH_RECEIVE response buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80791

Introduced by commit db1312d ("nvmet: implement basic In-Band
Authentication") in v6.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3ddcfb013322aa37eaa7a0d344b73079c38dfa21]
stable/6.1: [447b668faa14710f611e714031e3739ac3ec3a4f]
stable/6.12: [dfcf013f77709ebdb282767edc2795a37cab5b57]
stable/6.18: [b26189d28442183a8b5edb754f4a6918f77ca84e]
stable/6.6: [8f6363c8d54dde95982f0ab45e77cf57ec0efd62]
stable/7.2: [1d6837d98bf966a041af65de5f78de7409ff83bc]

CVE-2026-80792: ipv6: fix use-after-free in ip6_finish_output2()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80792

Introduced by commit e415ed3 ("ipv6: use skb_expand_head in
ip6_finish_output2") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [d0d48d999b0eee6bb176ef4e39d9be868fa80f7e]
stable/5.10: [75e0a544ebe9af663ef53ca21e9e9185c51fb54a]
stable/5.15: [c95f01b78266828a57060d754fcbfc92123a98ed]
stable/6.1: [d960881b9312e781a3429aabceb223ce6b7c882f]
stable/6.12: [3c770ac4e6f07af7c7b40c474a3efc61ffed7862]
stable/6.18: [3dc98e5fe82d069dd29b124ffbdb679331dfea43]
stable/6.6: [087ee0d914aaae929f1660c9ca878e367655ba1a]
stable/7.2: [73a187384a8c8b983c7fea046d716b6752a1e7a3]

CVE-2026-80793: ipv4: reject undersized MTUs in ip_do_fragment()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80793

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0726f0caf8c6b3208552949e17d23634a2f3129]
stable/5.10: [a716a64a4ba68cd46f2745fba2b1099fe8e0aa59]
stable/5.15: [515b6816ba0c12d8415c88e5f41e6ec029e35cfa]
stable/6.1: [74ce7389f8f562d39015f59a00ef7ad6acd37803]
stable/6.12: [36e0741833bd823866f8cb9f112f37cea1a70b60]
stable/6.18: [d9d1a676b033acabf8e5645f730486d1f8204a3f]
stable/6.6: [b0ea911453ce7210e8200a07a94d2458bd1e6430]
stable/7.2: [c8a74adccaf028223054633b532593101dfcc581]

CVE-2026-80794: nfc: nci: fix uninit-value in the RF
discover/activated NTF handlers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80794

Introduced by commit 019c4fb ("NFC: Add NCI multiple targets support")
in v3.4-rc1.
Introduced by commit e8c0dac ("NFC: Update names and structs to NCI
spec 1.0 d18") in v3.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8cbe06c1e699c0a165dae5093a2550e65f914818]
stable/5.10: [1007a6b429d756513abd25bd00290908f2e89a4a]
stable/5.15: [4bda9ef8392710f21e99027467f3f4afdfb5c99a]
stable/6.1: [fe69fed3495f676578d49414a069ad7d8468e2ce]
stable/6.12: [7086dab72b3ed95df96842801e10e935cfeb27a3]
stable/6.18: [0d4b5cfab6891a5ca0f6aef209beebba4bd7c095]
stable/6.6: [7489f59d1ea2d3298aa41de7baf193e5e6e132f6]
stable/7.2: [d6f743d3d388913135681cde051c08823730194f]

CVE-2026-80795: nfc: nci: fix out-of-bounds write in nci_target_auto_activated()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80795

Introduced by commit 019c4fb ("NFC: Add NCI multiple targets support")
in v3.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac200079db50af81e6b04d058b33ec92901d8edd]
stable/5.10: [0dc59de0075f88404a0f4a2b5233104ef459fbb2]
stable/5.15: [94530ffabfca57e9bff1d207106010014cc84032]
stable/6.1: [afd8605fb43becb892311102844955c3b127fc7e]
stable/6.12: [50e87e1c0e18d791dcd7dccf30f9a2f3e2cf3951]
stable/6.18: [2f08dbce3b37624ec6b424d759336a99586170ec]
stable/6.6: [24761d3a5f692df5f7d848caeabcb2afd10917aa]
stable/7.2: [129032c0616d83a5e3e304f6ebf88f14ba01e5f7]

CVE-2026-80796: nfc: nci: add data_len bound checks to activation
parameter extractors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80796

Introduced by commit e8c0dac ("NFC: Update names and structs to NCI
spec 1.0 d18") in v3.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0428fa2c22e2ba0cff766d3b80d461e149102045]
stable/5.10: [1168484fe2b3828bf24a46f3c42a8719fade679b]
stable/5.15: [be311c0cfeadfbe815ea22d2914a98d06e3fab0e]
stable/6.1: [04e51353cb9fa321caaeeed8331d4cd041fbaca7]
stable/6.12: [9b01f5af0dc59263b59391b148bc78d83c0354a9]
stable/6.18: [9620a91f8d643b680f417a435db399a04d1e06d8]
stable/6.6: [e25b44bd8b8cc666b49a3fe0ef547e64d5b1e300]
stable/7.2: [f5c534b53f8c424a8e7633c9b585475c4bf4ee18]

CVE-2026-80797: nfc: pn533: purge fragmented skbs during cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80797

Introduced by commit 963a82e ("NFC: pn533: Split large Tx frames in
chunks") in v3.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5718fc62198c38c2de5316020a90506f9e75e0bb]
stable/5.10: [130b5ad4492f8e53d0398ee3af2b0e2388504d11]
stable/5.15: [9319c3c4962efc8697246b563ea31c6d47f085aa]
stable/6.1: [d63e85c5d5555fe6aa65155d3a09452597e163c3]
stable/6.12: [e169277281373818ae1cedf976aa1e99118fb77d]
stable/6.18: [2f5d093194ec24d7c29b91bf7df014924e0f4ea1]
stable/6.6: [4a52ec2457ff8c26206fcc20fa1972cc35a678c4]
stable/7.2: [e95beff58b38c871c557bf84e528408283c2c0ad]

CVE-2026-80798: nfc: llcp: reject PDUs shorter than the LLCP header

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80798

Introduced by commit d646960 ("NFC: Initial LLCP support") in v3.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [95674f506c6376d6722a23144c9acd26609771ed]
stable/5.10: [e6ec76a68dce04884dfeccfe5a5f0e9f67c0ec82]
stable/5.15: [f36cffea24bf3e2cc29a00d4b51dbcadc087d810]
stable/6.1: [a7b9b449f5a5132221fff6adc11a9431ab8cd914]
stable/6.12: [eab47618e282602197db287ecbd1b09d356a2515]
stable/6.18: [e969e98410051b1ef8cc318bfe0c7e3f24ec766d]
stable/6.6: [3793d768b40f38bb97265dd5b9a8b8655c4e1b1d]
stable/7.2: [d3d90243393c48146911c67fd3792b549d21d9e6]

CVE-2026-80799: nfc: llcp: fix OOB read and u8 offset wrap in TLV parsers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80799

Introduced by commit 3df40eb ("nfc: constify several pointers to u8,
char and sk_buff") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [78b20c8eeacd2e44a2d8a4cb5316d3c521d90911]
stable/5.10: [2c1456fe09ab1a5a9fe1d8339ca6d509589b56e1]
stable/5.15: [7f6f3d087c67a4346189ef2c36481455bbc59a74]
stable/6.1: [9c47d667963542c3cf8e3007b7f10c0904d08238]
stable/6.12: [382eaa770335acf4f16a5a55524500f2bb4207df]
stable/6.18: [2d239590d1845a706304833d40dd6d4fec20ad88]
stable/6.6: [a209334ed929941b20810c17c3a507445b0a7c85]
stable/7.2: [875285a165fd3b402de2ab3be0deb355d6f4caf5]

CVE-2026-80800: nfc: llcp: bound the connect_sn TLV walk to the skb

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80800

Introduced by commit d646960 ("NFC: Initial LLCP support") in v3.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [55c68ac93e7dacc0f5f608b9c39dd4ff48cf28e8]
stable/5.10: [b2ebdfe3d5b76e91f267a61cbc3f9a0e3f77071e]
stable/5.15: [e18d044bab6d3d0280639098c3fe6621692cbfe2]
stable/6.1: [65a0ec7783b06068dda6745dd689bf4a91ee64aa]
stable/6.12: [389986fd79e4d43f971a03b512645a1bb63c982f]
stable/6.18: [e87527b506c40db9af528714b7b1240918eb80fc]
stable/6.6: [1964addc8dd535a05d5d3b55b4d1ac19ae31aa65]
stable/7.2: [0cfbdb0e13ab5b0765d77f96af67eb879cbc9736]

CVE-2026-80801: nfc: microread: validate target discovery payload lengths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80801

Introduced by commit cfad1ba ("NFC: Initial support for Inside Secure
microread") in v3.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [25519469972ef57c3edb1805dabd6c5612b90211]
stable/5.10: [c6de4241f2efbbab286efbb84a9c7190298b3052]
stable/5.15: [92a6f0201bb68391b5eba1b3f330af007d7323b6]
stable/6.1: [cb298672282421159e53ab311fe49d204c8a52da]
stable/6.12: [e6397fe7b8b5ef18e051f49612d40ff476c5f7d9]
stable/6.18: [d0902a7c454326c6384c614226ab8987f3fd425d]
stable/6.6: [18f02354ed229b8e4561b580812d026e7eb29c85]
stable/7.2: [953963b9ac5eecbb316617d337bfaa3d731e3c5e]

CVE-2026-80802: nfc: fdp: bound the device-reported read length and
fix an skb leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80802

Introduced by commit a06347c ("NFC: Add Intel Fields Peak NFC solution
driver") in v4.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ad21dcfeb5181af0c3ee2608808c0c0a5283aa1]
stable/5.10: [d9498ab9a78cb63d78dbe4f221d8cc6c91f285ee]
stable/5.15: [1fc32327b927a6e2cde086f82575c29880844228]
stable/6.1: [8d2c243b79854628ff076c38748c020042f02f57]
stable/6.12: [0d723090645b82c1cb27cfd7ebf81f0e7c96bcae]
stable/6.18: [db7e464b350969c6ea8340de00d9796e5fd5123b]
stable/6.6: [fc3c2bd5b1ec6c7cbc8a50e32d9bcec114f25463]
stable/7.2: [1aa3fc769b0c45bd19f8dab1697084c2b3f6d706]

CVE-2026-80803: nfc: digital: clamp SENSF_RES length to the destination buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80803

Introduced by commit 8c0695e ("NFC Digital: Add NFC-F technology
support") in v3.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [344a56d7c8e0f3cbaff0bcb1bcd95a1a1db24b16]
stable/5.10: [6afb29751ee731e7f7a96feb8a15f91441e552ba]
stable/5.15: [e886c63d2ca7108826076989103a1ffa8a0bb8f4]
stable/6.1: [4e942da2869bcd646353eef706b7dd82efeb9db5]
stable/6.12: [af4c0606f743e009254a8d252096855335ade85d]
stable/6.18: [a56773e649ea99b344d6bbaf90f34c8e3fadef5d]
stable/6.6: [d0756a98277e383c26fead988a96c91f0781cd7f]
stable/7.2: [31aa28ed732f66ab83c40ef53d99791be69b85c4]

CVE-2026-80804: xfs: restore nofs context unconditionally in xfs_trans_roll

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80804

Introduced by commit a1ca658 ("xfs: fix incorrect context handling in
xfs_trans_roll") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0241ea5fb0fe86d2a673163b2f5815111aadc7f7]
stable/7.2: [4d00a39c676274f4071b467e630565ac1e3ae0f2]

CVE-2026-80805: xfs: validate attr entry pointer before field access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80805

Introduced by commit c847606 ("xfs: check attribute leaf block
structure") in v5.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b7eea80be25f3334f131d52982b3131aba77b97d]
stable/5.10: [0f82586741e39926542f621bafa424e237a04fa4]
stable/5.15: [134d82a2b5e3eba3ebf58753a1387b22f26ca1de]
stable/6.1: [03a12253dd2a036545bdb0110a4e0b8dc70f8e7c]
stable/6.12: [98a42bb9d60d42898c3494de351a1bf508348cde]
stable/6.18: [184c1a80421a5b5ddcd262e47980ce2e67fee211]
stable/6.6: [e99120b5944a16d0bc27e52b33de78bcdaaabf5c]
stable/7.2: [c35da2bac6f7cb9a9be73f188b4fcc324615c327]

CVE-2026-80806: ext4: don't enable DAX on new encrypted files

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80806

Introduced by commit 043546e ("fs/ext4: Only change S_DAX on inode
load") in v5.8-rc2.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da32af420d6d466e247c43ac0b829edeac7ae0ad]
stable/5.10: [add98959b220935b243170214c787bc03044a44d]
stable/5.15: [f53b325068bca0b238c3e0d2eb7de9b1f2268cab]
stable/6.1: [5959cad3cfa852ec07bbdaf9c17f4838a94a8e6c]
stable/6.12: [ed1cd834da65db127f1c30ff67e78f14825a06c1]
stable/6.18: [458776af0061afec1014cb3cd0061e282e482e83]
stable/6.6: [a13f61ba9b2a7a4ff1f140949ccfad23c5313757]
stable/7.2: [e27bae352158c007143d5bb50f3af33a177c0a37]

CVE-2026-80807: nilfs2: reject invalid block index in GC ioctl

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80807

Introduced by commit 7942b91 ("nilfs2: ioctl operations") in v2.6.30-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a1735eae55448bc79c2da6593455791e886f6ed8]
stable/5.10: [898404cdf882d7b54f1132f75570984ca3214796]
stable/5.15: [ba8a8b563a28d358c45c62a306d421434a058648]
stable/6.1: [3bd064ccc70b85f9a3d53aece29dc8473be5a226]
stable/6.12: [68aa9ab6f8f2895713aa6ddf781463ed8ea5ba44]
stable/6.18: [e447f7edb99bd00cec63d6f3049e2e5074946f71]
stable/6.6: [a5e776e2937581d67ec5b9b4d27b0f70d7baa6b1]
stable/7.2: [fbcfb75c20d71a5b542ad4ac3b79d10b997c8152]

CVE-2026-80808: ext4: stop retrying saturated xattr cache entries

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80808

Introduced by commit 65f8b80 ("ext4: fix race when reusing xattr
blocks") in v6.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [54b6bd40898de7906acb2bccc9a96d1b8e6b4323]
stable/5.10: [119a2f053242ed75bdd2ebc95baf3ae7db6ccacf]
stable/5.15: [61631352a5b405c89be579de00903b72e6888aa4]
stable/6.1: [8865cd664484517703df5c18a965dc3227572b87]
stable/6.12: [889ec86464d261f026f6c334040cfc6c58c99d58]
stable/6.18: [4902a5cba21aeaf91e6b29e20e0967a5f6abdcd9]
stable/6.6: [a40c45268f4358207aa9c53764fed2e05f62986a]
stable/7.2: [dbd4aea175ad3c46436acb251e817b4374628072]

CVE-2026-80809: ocfs2: fix missing metadata reservation for large xattrs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80809

Introduced by commit a78f9f4 ("ocfs2: make xattr extension work with
new local alloc reservation.") in v2.6.35-rc6.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0cdc7dde00ec63ac714271fa8b2918d630b8da1a]
stable/5.10: [743ac908282ac97ef6e73ac3a92df2cc8ecb7479]
stable/5.15: [04ba24bce61c917b5b3009f0db470cbb72e26a0d]
stable/6.1: [b4663405ae29d36011cd712d243456f3f9ab700d]
stable/6.12: [b9eb5c9fdd81d82976d4d5be2b2458eb7d7e46ec]
stable/6.18: [6176313622e34fa3e2b66b9d0682d1e1c6b365c5]
stable/6.6: [6a009f1e61b11d9e23d3c5aa1dacfb010945da45]
stable/7.2: [50f0cbec45b0f3fd7e1263d01916518dbf31eb3f]

CVE-2026-80810: io_uring/rsrc: fix folio size overflow in io_vec_fill_bvec()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80810

Introduced by commit 9ef4cbb ("io_uring: add infra for importing
vectored reg buffers") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f3a6a16bbe8bde76532d9415438f8cdef439e5d]
stable/6.18: [45c945107e007b1fb73e21cd220277652a45521a]
stable/7.2: [3267d7c8ba51642117f7bdd1ece02b2540668476]

CVE-2026-80811: io_uring/cmd: fix iovec leak when the async cmd is not recycled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80811

Introduced by commit 3a4689a ("io_uring/cmd: add iovec cache for
commands") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bb34ae5da3365699d53a756f4c96b6ea9f8ba0c1]
stable/6.18: [b6a768aa975b9ca81b92f028bdd975d1f8237894]
stable/7.2: [7068d3587a64a24943a7c9e232976da2c9e0e303]

CVE-2026-80812: ALSA: dummy: Check card index validity at probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80812

According to the .vulnerable file, this bug was introduced by commit
6e65c1c in v2.6.20.16.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [02442d5fe8ee365a084b055d4fa81a0c1abfc3fd]
stable/5.15: [b7579e86afcec932e169d10e2d603abed8dd2fdf]
stable/6.1: [4d0892a90b57f0e89b274c3f3c51c2fa17937c88]
stable/6.12: [c9f10a001c243d1f069ebb0e2f4999ad4043a254]
stable/6.18: [f20c2c32ec1c5c3526f29a03b487c55a5890996c]
stable/6.6: [b20eb7ecbdaa3e649023fe41b177d90983ffb487]
stable/7.2: [690b721b9595f9a43395fd4047a832c42b5b6078]

CVE-2026-80813: nvmet: fix NULL pointer dereference in
nvmet_execute_identify_nslist()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80813

Introduced by commit 61c9967 ("nvmet: implement active command set ns
list") in v6.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [79aba4c9403419d822972d2851f2a96a2c0531cf]
stable/6.18: [61dc1a37e04d4003a19095f54883358330034a39]
stable/7.2: [123d664ac98d6f3464462ad4a530474b91ba9890]

CVE-2026-80814: rndis_host: add overflow check in rndis_rx_fixup()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80814

According to the .vulnerable file, this bug was introduced by commit
64e0491 in v2.6.20.16.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [965a251f23ff69cfb4486974d4532e9bb551c7fc]
stable/5.10: [2140db1232af04b92faa6c4a2a40df6371ea89ff]
stable/5.15: [8ca3bd404d076495ed0b274b65971c57b6fd5ac0]
stable/6.1: [f8e6fde5db87f855e99b200e392467274f0eb9d7]
stable/6.12: [c5398ce6db7647b7004d73a3102ccc25fb4bb596]
stable/6.18: [e971d956353d382ee2185d71c47b538501a43f76]
stable/6.6: [10a6b99079697c5027b25352e882bdf54fef702a]
stable/7.2: [2ded89ca77fae1da6886fe94831acfe4d6aa80b1]

CVE-2026-80815: ALSA: scarlett2: Use a private URB for the notification endpoint

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80815

Introduced by commit 1b65088 ("ALSA: scarlett2: Implement handling of
the ACK notification") in v6.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cd17d6ff7b7d2b1dd9bcc80ae7b4a83773f918c6]
stable/6.12: [013448eb7b0d0b91d6168685dab10e9b41baa825]
stable/6.18: [4305e4b52acc0ca67dcfdf8f73dd943dab508ae8]
stable/7.2: [ecd2f83a4ddc078901e7104144cb6c5e5db3b7cf]

CVE-2026-80816: ALSA: FCP: Use a private URB for the notification endpoint

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80816

Introduced by commit 46757a3 ("ALSA: FCP: Add Focusrite Control
Protocol driver") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [918b8d231c571c50a00efe92ffc8404a537a0490]
stable/6.18: [65aceb45ca91ddb7f7ed178821f481b34da35543]
stable/7.2: [6db3c1d7e2872c9904e05ca8e0515920776a3c9c]

CVE-2026-80817: iommu/iommufd: Fix NULL pointer deref in
iommufd_ioas_change_process when racing with iopt_map_file_pages

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80817

Introduced by commit 829ed62 ("iommufd: Add
IOMMU_IOAS_CHANGE_PROCESS") in v6.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d616de490ec0242dcf78f02f1adf7baa035c4d0d]
stable/6.18: [7596354148c5aa12dfaa17992d1aef1aa2ea831a]
stable/7.2: [ffe6d379be20df013e19a4c63dd80bc6b683106d]

CVE-2026-80818: iommu/tegra241-cmdqv: Fix CMD_SYNC use-after-free on teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80818

Introduced by commit 4dc0d12 ("iommu/tegra241-cmdqv: Add user-space
use support") in v6.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ff145a25c5c8a26b06ef7cf558fb536b18bba6d]
stable/6.18: [d2ab08437e913d9e4dda4dfd0d327446ec8717fc]
stable/7.2: [5994617e09ee6016c1b094f29d9c85cac944b477]

CVE-2026-80819: Bluetooth: RFCOMM: take rfcomm_mutex for the deferred
setup accept

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80819

Introduced by commit bb23c0a ("Bluetooth: Add support for deferring
RFCOMM connection setup") in v2.6.30-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [43a556b2fd43f2df6dded59c2e26560a27874c24]
stable/5.10: [d8d686dd5662a7c4745e4515f1237a9f3b7df181]
stable/5.15: [eb71d5a1ea8ff2683e394b48ae3cd676037ab4c2]
stable/6.1: [56f0aa75c7640e46397ef73bea251fcbef9150c0]
stable/6.12: [825b95561d7b7c393df9e7bc295451aaeadc3d18]
stable/6.18: [d4b1a13b1eff2e80925c7368ffdeaaa50cba93df]
stable/6.6: [362726c9c6e56eea4262109183e49868c39ccd3a]
stable/7.2: [b405c2f96ae2e37375105881890f7738833b1d62]

CVE-2026-80820: xfs: don't livelock in scrub on a circular unlinked list

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80820

Introduced by commit a12890a ("xfs: scrub the AGI") in v4.15-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [527eaaefddb6ec5c83a06c9a1559960dd6361753]
stable/6.12: [599453f83458b57995290a1d31200c263e2c2691]
stable/6.18: [159d162fe80bd56573cafde5801bd5a90a3dd1ac]

CVE-2026-80821: nvmet: pci-epf: put CQ ref on create_cq mapping failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80821

Introduced by commit 0faa0fe ("nvmet: New NVMe PCI endpoint function
target driver") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [659ae9d02cb5d72c76f74fff7441eb8fb64d8f5c]
stable/6.18: [f31650243c1ab32394077f234685e89ed8dece84]
stable/7.2: [56a7b6a6880dbabe28214ff88df8d229ca3a944a]

CVE-2026-80822: mailbox: mchp-ipc-sbi: Add null check for devm_kasprintf()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80822

According to the .vulnerable file, this bug was introduced by commit
e4b1d67 in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b37c4d0a2fd90c0c31223acd37f763eb8953ed1a]
stable/6.18: [364edaedf4125825781a12c84c77699780d52a16]
stable/7.2: [b233e7836d98d1790e71f5f3734a86409664f341]

CVE-2026-80823: nfc: st21nfca: validate ATR_REQ length against the
received frame

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80823

Introduced by commit 1892bf8 ("NFC: st21nfca: Adding P2P support to
st21nfca in Initiator & Target mode") in v3.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5cdcca5d62a66eda6b774110a44cba67bc1a8d1d]
stable/5.10: [785df00bb3ae3206674a43284eb06dac575b5c64]
stable/5.15: [2c1ad291f4cdc357f9527b688c6fda9c6ffa7890]
stable/6.1: [dd26d30f40c43ad9cfe2f25c6ea0ead1dd51d5aa]
stable/6.12: [0f344944c506b4f02d2b098489f7268b438c369e]
stable/6.18: [bfcca5f42c9aa4eadef1e5fe7bb23783d7fcc96d]
stable/6.6: [9635507fe82949e429b3cd938876a9917125b151]
stable/7.2: [f33cecf69095c43be88567fef92b180b858f7369]

CVE-2026-80824: usb: usbfs: fix use-after-free of usb_device in usbdev_release()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80824

Introduced by commit f7d34b4 ("USB: Add support for usbfs zerocopy.")
in v4.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0dd68b5d01d022fc9c5e71c82a82b0a94d3d0671]
stable/5.10: [0a960b88c5979f853019d4dc4957dfbeeb193440]
stable/5.15: [96f5520fc9a5e4bbf77ac93c9d5ce502f597e6cf]
stable/6.1: [bd4bffc621a8cb2f4d9ed9b6447415de524a3bef]
stable/6.12: [b3cde26a66b04f1d90ed0b675899c88b4e49d424]
stable/6.18: [5f08c45bdcfd28d1171de38c5ef29fc89a76eedc]
stable/6.6: [65879e0a452ca2a234b9475e0c11aff7a4343738]
stable/7.2: [47a7f98fbb5006d46d15a3a210ffdc61448a4f19]

CVE-2026-80825: wifi: mt76: mt7925: ensure tx headroom in
usb_sdio_tx_prepare_skb

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80825

Introduced by commit c948b5d ("wifi: mt76: mt7925: add Mediatek Wi-Fi7
driver for mt7925 chips") in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef3e34874d2332d0f63e72c2c35ce5c93568c125]
stable/6.12: [9a72b180f0575e41471e088e09bddc4b73d6dee2]
stable/6.18: [22edb6786127271aeba7abd30f152977c605c6a3]
stable/7.2: [e5e8fc11a7ac578f16079f855b7fffc1649d053c]

CVE-2026-80826: USB: c67x00: fix use-after-free in c67x00_add_iso_urb()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80826

Introduced by commit e9b29ff ("USB: add Cypress c67x00 OTG controller
HCD driver") in v2.6.26-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b1e24de475bf2d66fffc9103f3444b783527d55a]
stable/5.10: [e4039e9bebb528dd9cd7ac72aeaec529c26c355a]
stable/5.15: [ade18b4ce78a16558f4f435aece80082f6f7b64c]
stable/6.1: [bb572801290e25ec1c4753d14af35777303f5d6b]
stable/6.12: [ff172092cba7ec990ecc7b610ce703e19570b8f0]
stable/6.18: [b4cb8081cf80f82e48fbe9c021a8f6d0fa2ed421]
stable/6.6: [62cd519ab74cac499036cd88c11692f8f0d53e14]
stable/7.2: [f24dcc61bd0ecf7639fac5bf700450b398d793a7]

CVE-2026-80827: USB: serial: option: fix slab OOB read in interrupt URB callback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80827

Introduced by commit 58cfe91 ("[PATCH] USB: add Option Card driver") in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [885d802f544ca7bfa8f3984d94233cce715bb6b3]
stable/5.10: [fbe60fd2abc8a5561f39719a41ad9a01b5d8e567]
stable/5.15: [94e5525697b9e91ddc4071129874120a50a4f342]
stable/6.1: [6b8cf5422c7e96ed5b22a8368eff663f3f98b8ec]
stable/6.12: [060db7d48af1e650643c8b8319111a9ea2ce4486]
stable/6.18: [2ef5560387f2c0713cee975be2b24b281bd90f3e]
stable/6.6: [030e3a73d3c3aa67c44454649e984d6383cdb7d3]
stable/7.2: [d762aef4eba354066be21a5d88eb2066e282f4c9]

CVE-2026-80828: ALSA: usb-audio: Complete cleanup after system-resume errors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80828

Introduced by commit 88a8516 ("ALSA: usbaudio: implement USB
autosuspend") in v2.6.39-rc1.
Introduced by commit 862b250 ("ALSA: usb-audio: Fix inconsistent card
PM state after resume") in v5.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [1739a976312e110c93a8dee66a1cdf893a1b187e]
stable/5.15: [3fa521c3c54b42e16cad8ade76551113a783752b]
stable/6.1: [3f06f3f5b16212f180764654a9398ff5f7a855c8]
stable/6.12: [5a625fc2284e35f33693efd9534aebaca3b005d4]
stable/6.18: [6d3e202670b819c414076a5d07dffac8a39274ad]
stable/6.6: [f1c05c41d07b874635d681ae328d13ec550470c5]
stable/7.2: [d1f643b1c0258bd519146f7a342bbb394d413912]

CVE-2026-80829: ALSA: usb-audio: fix OOB write in snd_usbmidi_novation_output()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80829

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1035a8f63bae28e498b0e7b5ac91d749844a7158]
stable/5.10: [558fc4485ecc704edfe7876d6cebae4738ff7ef8]
stable/5.15: [9c8212436631b0063cb021e9f58df438e3db84d0]
stable/6.1: [e9c00d7533f99aa9833c4b598f47e3b3202fdb9a]
stable/6.12: [7639ec9755d3ec0ec8cd7c0fdd2c3d3997434870]
stable/6.18: [91919b3b99ab7ce3d7dbb39fcf7c6c742a663c0c]
stable/6.6: [94e4562fcc81badd1d467ddfb88c27e4fae974c2]
stable/7.2: [1074c2306901b44ebcb83855583c6776e1e392ea]

CVE-2026-80830: usb: core: Add lock to usb_wakeup_notification()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80830

According to the .vulnerable file, this bug was introduced by commit
4ee823b in v3.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e263e18a9e7b1ff3e7301f0801c6ff87c31adfb6]
stable/5.10: [a7a16167991c88016acef720927400404039d850]
stable/5.15: [975ef630393c07fcbebf94f4d97043161b77a6ce]
stable/6.1: [71cfda2fdf78041a01e9d94143baa79feabbdbf6]
stable/6.12: [bf2288583b4e072bdff17a233963619e4bc7a8b5]
stable/6.18: [d80b946804674069db7ce6657319a71cf8eeaa5a]
stable/6.6: [04ab260407972e631c86f2bc576cd8e64d65b325]
stable/7.2: [7c48aa0c1e79116b8af4b988d16ee29b427d6491]

CVE-2026-80831: crypto: mxs-dcp - fix source scatterlist length access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80831

Introduced by commit 15b59e7 ("crypto: mxs - Add Freescale MXS DCP
driver") in v3.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c5bcb084a9871e5b62afb5f48b60adfa13b5d9f8]
stable/5.10: [fd0f211b27a6ec2ebd8c315683401b43adcc5511]
stable/5.15: [04201dcc88b26eac52f736e39727fc5c420b7257]
stable/6.1: [e72a795df521cb65b7c4705cc11078cdacfaa2f4]
stable/6.12: [da14fae5203b72ca71ccfa9af8de9249e40d533a]
stable/6.18: [182f16a20d329a1c818d51dad57d9bf43d356c7c]
stable/6.6: [1537bd55b4f842565068c54b47cd2ae1777d5f8f]
stable/7.2: [6ef9a4afb52cb102ab038cd42352c142d8505d09]

CVE-2026-80832: crypto: qce - fix CCM AAD buffer underallocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80832

Introduced by commit 9363efb ("crypto: qce - Add support for AEAD
algorithms") in v5.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f2345f47dd189625f657cd72437179ab4170ee1]
stable/5.15: [11775b35ce9f27e73d62188d7d38aa0dc0a219aa]
stable/6.1: [c9e0f06a023107694698a7930616aeb460d91816]
stable/6.12: [002f1f99aef7ea631cb687fc17bce64e4963f6aa]
stable/6.18: [2f65718b9c1095eef1ae9b374aa0384b1b083f3c]
stable/6.6: [cc56d2b0d77cfeea061e98114992ee687d5eb4dd]
stable/7.2: [4839f4c21f9c577eedef2919ced878a3057c7fc3]

CVE-2026-80833: crypto: sun8i-ss - Remove crypto_rng interface

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80833

Introduced by commit ac2614d ("crypto: sun8i-ss - Add support for the
PRNG") in v5.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a78446ee6fae86ac8733f120e3ffce2e5d9384f5]
stable/6.12: [d29ccf9eeb67d775221e49a079caa1af83427afa]
stable/6.18: [7c257a295e05ceb8f78aa3efecc4e9ce19c3313f]
stable/7.2: [8ab58786b4c63b8f1b6c522f33bb67a3c8c2791f]

CVE-2026-80834: crypto: sun8i-ce - Remove crypto_rng interface

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80834

Introduced by commit 5eb7e94 ("crypto: sun8i-ce - Add support for the
PRNG") in v5.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [011556f71d094da61379ae3672692cae2795304e]
stable/6.12: [7bb9e6060710eb7b59491d9826169190297adace]
stable/6.18: [8e4f9110aba3127024646ef7a8999dcfcc03f516]
stable/7.2: [1017f987c5f0841f00408a78f947990c9d84b346]

CVE-2026-80835: crypto: qcom-rng - Remove crypto_rng interface

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80835

Introduced by commit f29cd5b ("crypto: qcom-rng - Add hw_random
interface support") in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ecdf5c9910e20f73639bc322f0518a3439d17c0]
stable/6.12: [bb474dcd9d0224264a27a60891f00872b879835f]
stable/6.18: [14d9ee8286460a7b82f3b8610b5c7ebf4550b06b]
stable/7.2: [669d940351eda316b82e24986e2e0e057653ce7d]

CVE-2026-80836: crypto: virtio - bound the akcipher result length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80836

Introduced by commit a36bd0a ("virtio-crypto: adjust dst_len at ops
callback") in v5.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f77a956f6a19f9463ef1527c9d0cda50dded6b92]
stable/6.18: [5545de5050cbc3594506d74f2c392b0716cf8bca]
stable/7.2: [1f9f877b1ef1fbd4ee95571cddf39c8002cee252]

CVE-2026-80837: netfilter: nf_tables: don't queue packet path object
notifications

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80837

Introduced by commit 67cc570 ("netfilter: nf_tables: coalesce multiple
notifications into one skbuff") in v5.9-rc7.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7904b94768e983bcb2be34a8d6d1f3450f5b838b]
stable/6.12: [df86c0e84025be8b6dd572a20852698927aa666b]
stable/6.18: [6fa88d11983c6fe693c13ed7c5b3b75ae9f39de6]
stable/7.2: [68de7f3a38acab355c24114f77bf00d3094ce4da]

CVE-2026-80838: vxlan: keep the last remote linked during FDB flush

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80838

Introduced by commit c499fcc ("vxlan: vxlan_core: Support FDB flushing
by destination VNI") in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d5d4a7b538b52db63927773a8905fcd9f78a42e2]
stable/6.12: [2a7c2f00843225d5f037676bca649321f3d024c7]
stable/6.18: [a8820c8a7718327e96849782033e7c85a0f6bcfe]
stable/7.2: [4bbc76ee1b21d3bd045d6d819b2bacd30a6372ab]

CVE-2026-80839: batman-adv: reject unrepresentable multicast TVLV offsets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80839

Introduced by commit 07afe1b ("batman-adv: mcast: implement multicast
packet reception and forwarding") in v6.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f12c2de4f542e3220e17e0606f492110064f04cb]
stable/6.12: [da1f5aa7ec93f2cc17f5cd30efc54f62af433cf2]
stable/6.18: [916ec741e65af072b98e475feaad98c063da1b7c]
stable/7.2: [2b46baa591d0a7c16b62f150917187e70d053be6]

CVE-2026-80840: ipv6: seg6: clear IPv4 control block on IPIP decapsulation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80840

Introduced by commit 891ef8d ("ipv6: sr: implement additional
seg6local actions") in v4.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [44930446dde45a7a90fe1446fa38eb0e2c561646]
stable/5.10: [10fd1a8f58ac619a9e251f2858e2e2c8fd6cd667]
stable/5.15: [eb0f422487228e140f3d609b032ac61aedcab8fa]
stable/6.1: [9039e4f3e1c0ffe2b575b655b3f58fdd10f7e40c]
stable/6.12: [0e3f01fe2e704e76af4385b8a1742641885a191c]
stable/6.18: [3e4476e58343fb8f2fffced9e22d935376b17aaf]
stable/6.6: [f52f1e75716d2ee49e013edf204ac92337c72fd8]
stable/7.2: [f4be3b391265e24c7720fc867c50062b436acf33]

CVE-2026-80841: net/packet: defer vmalloc TX_RING free until skbs finish

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80841

Introduced by commit b013840 ("packet: use percpu mmap tx frame
pending refcount") in v3.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [992cc9f94ca924089a506ba9b327caa9af797529]
stable/7.2: [550d00aa58193fb649a09a9c9e338c685adad784]

CVE-2026-80842: net: bridge: mcast: fix use-after-free of a master
VLAN's multicast context

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80842

Introduced by commit 7b54aaa ("net: bridge: multicast: add vlan state
initialization and control") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [50e5c6605cc9c2dd57bd2d1b3459674d19738983]
stable/5.15: [3afaaee2f972aec9059110953adb62fa3cf5c4bd]
stable/6.1: [22226a2c3b90f15b0925f1464470d3baa6c5677e]
stable/6.12: [3a0ad4fcdfa0b7dba1876de14a12cb65c8b5ca50]
stable/6.18: [c069f29da72324697aa4b7cab5b3647a7d24a575]
stable/6.6: [7c54fd8cfbcf371a5ef50db5c53fe6e85fb76686]
stable/7.2: [57f94d3f4dee8b54d63cefddf1112be4656ef9e6]

CVE-2026-80843: xfrm: fix xfrm_state_construct() auth-trunc leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80843

Introduced by commit 4447bb3 ("xfrm: Store aalg in xfrm_state with a
user specified truncation length") in v2.6.33-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c12cbf56320fb633484ee0ca1fb7d68d6b64b213]
stable/5.10: [958ae9f261319e1cdc44879886bcda2263258cca]
stable/5.15: [fb7f3e74789a3c89647f4eb768f6dfaf4a751e72]
stable/6.1: [ba0c110c205855b3f1e3130d8c0fdb484d704c8c]
stable/6.12: [71d42da01740ec6557837bebec0bc48cfc3b4c39]
stable/6.18: [cf67361e78dca488d6e4df8396a53e6745a3a80e]
stable/6.6: [c8837bbe792257af547fd1c0252553ce13148795]
stable/7.2: [be19d20e53a239572bb2a28efcc1cd2b069b1ef9]

CVE-2026-80844: xfrm: ah6: validate routing header segments_left

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80844

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7bad4bda74dc4713f398d3b7624ff05478e3a568]
stable/5.10: [2dc650956e4e163b879b3fb1027f9557abc5c985]
stable/5.15: [48b0e36cf54358276ee7aa897034c973097d2bc9]
stable/6.1: [1b7e066eabcc7d6d8f476c34739b45932f2f4c31]
stable/6.12: [1516e31ac458a738be485620579d8f7fb2700fcb]
stable/6.18: [6733ae71268a27d598cfb3f3339a3c950b9b656d]
stable/6.6: [f00df8500e5a36ba70d336fd34bd2152ea074e5f]
stable/7.2: [46640c814f25f096b0b0045ca50e1b7030cd8a30]

CVE-2026-80845: xfrm: avoid lock inversion in nat keepalive work

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80845

Introduced by commit f531d13 ("xfrm: support sending NAT keepalives in
ESP in UDP states") in v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [763fe700b7c58ad64fe5202c5638848244dd4127]
stable/6.12: [ea09210462316e5235a25eccb11ad0708d86615e]
stable/6.18: [5c86c895d1cac81a71ead3005084c6265cf6a7a5]
stable/7.2: [a9fa05b7a1246797748d15771052639e0d3cabf1]

CVE-2026-80846: xfrm: drop ESP-in-TCP packets with no ingress device

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80846

Introduced by commit e27cca9 ("xfrm: add espintcp (RFC 8229)") in v5.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e1d7c5ac1c246ce5775f604515de0a59fbf2116e]
stable/5.10: [239d0f71af09dc2029fd4d730cb24b8c83aaa43a]
stable/5.15: [f00235f9d12301183d61f75fbe4105506f3e5140]
stable/6.1: [6af5cdb03819a5ce6e945992635c6c5e91045367]
stable/6.12: [c296d25efbc840be24de83f56d43bc47e714ace9]
stable/6.18: [328e40aa774b446969c69b654c52a051a95af8a1]
stable/6.6: [2dd1609cadff46c4b20ce53b91ab9cce1380456a]
stable/7.2: [943d95233b8b4a88994e244fcf466f8c403d63f1]

CVE-2026-80847: tcp: clamp route advmss to TCP_MIN_MSS

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80847

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [870a9e42ecc6fe1b8c25d87af043cb0d9c178fe1]
stable/7.2: [31cf2349361902769dc323e4dbf4b449795ec288]

CVE-2026-80848: xfrm: espintcp: fix UAF during close

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80848

Introduced by commit e27cca9 ("xfrm: add espintcp (RFC 8229)") in v5.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [deb232e884877bf10b4ce2580909eedec986c284]
stable/5.10: [29121c5e6591da527e8e36ddac7120dc527f574d]
stable/5.15: [ed5d9102190c45fc70121c036b0626b740040b75]
stable/6.1: [4bc0dfa28dca6fc0084203732695968049c44072]
stable/6.12: [4b31a875693c480c611519faca46216514e3e052]
stable/6.18: [24efebecf415ba264adba0f0491cec436463a14f]
stable/6.6: [ff8dd7a932f34409a56e1b91a1219340f17457e9]
stable/7.2: [54b41ad14da9a981131ab6e4d3f79321a503ea5d]

CVE-2026-80849: net/tcp-ao: fix use-after-free of current_key on
reconnect to another peer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80849

Introduced by commit 0a3a809 ("net/tcp: Verify inbound TCP-AO signed
segments") in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da4471557f279d0f56605158a625bb6e49ef7d41]
stable/6.12: [84a93b4e012587d0a4a84ffb23ec6da18e9d85f9]
stable/6.18: [73fde8fe4469f4ed8f0afcc0b9d6413002a9e6b3]
stable/7.2: [2857dcbd03cf3354af0fba1b65c6a260fb43811a]

CVE-2026-80850: tcp: fix AO info use-after-free in tcp_ao_connect_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80850

Introduced by commit 248411b ("net/tcp: Wire up l3index to TCP-AO") in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea30dc5267e367b8a5e1e06cc074f813bcbf18b2]
stable/6.12: [594ba77210a1f065832211851a2d7e14d11fcbdb]
stable/6.18: [70051a57786d5b23f059fbaf5c8241eca14d42ed]
stable/7.2: [d17e88b6b60ff4ef64e0dd1444f935cb13dee1cd]

CVE-2026-80851: gtp: serialize PDP context updates

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80851

Introduced by commit 459aa66 ("gtp: add initial driver for datapath of
GPRS Tunneling Protocol (GTP-U)") in v4.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [498386b6d402737db1e2eeed4c385acbf0ef9e34]
stable/6.12: [5f77ddb2756340c1b05381674ca025d52998005e]
stable/6.18: [3d950e98f74af9611925a5226edced02155f6ed1]
stable/7.2: [1e995498d29784a06a2b2899370a1926cfc8410d]

CVE-2026-80852: tls: device: fix out-of-bounds write in tls_append_frag()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80852

Introduced by commit e8f6979 ("net/tls: Add generic NIC offload
infrastructure") in v4.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b17cf742eaad70ae29ac558cefb3aa9bbeea03d4]
stable/6.1: [03ced5da6120965d80ed56dbb7d78fa5c9128906]
stable/6.12: [b7f10d4ff987bda038df90052cd4a1434a7412d4]
stable/6.18: [fadbc1ed2a872a8649a44cf9e1cf9621fc58cd6e]
stable/6.6: [a832d7cb09da2a8e4e9734b4be14d3e76169d805]
stable/7.2: [7e1208c135618358da5d7d6664874dc6e53c62fc]

CVE-2026-80853: KVM: SEV: Allocate full pages for {DE,EN}CRYPT ops on
SNP-enabled hosts

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80853

Introduced by commit 4c735bf ("KVM: SEV: Allocate only as many bytes
as needed for temp crypt buffers") in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a33c40b93ccf5177e042253807d40e0b92e7f206]
stable/7.2: [97f6402f5950ca3450541287c4b3664f3acda976]

CVE-2026-80854: usb: gadget: f_tcm: keep port count until LUN teardown completes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80854

Introduced by commit c52661d ("usb-gadget: Initial merge of target
module for UASP + BOT") in v3.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c39d0916da47d94909391876c9e5bd429ea7b1b9]
stable/5.10: [c494c5562ca69b61a82f566e3b87a445d2c28929]
stable/5.15: [c1f359d9a5efed458946063de65ddbeaacc4f165]
stable/6.1: [178f59a0bccd3f66cdfa5184310f31a58b7257c4]
stable/6.12: [2efbfd42441d3ef8137aff2d59e9835e1d5ae780]
stable/6.18: [85aa61fedcb4eb13f3dc5db73f6dc359f41f5d95]
stable/6.6: [ad6f0375d2e93a1d8c015463e5e92dfcb26e311b]
stable/7.2: [eaa96a8458f54d6cf0954242ab8b1df2a6fccafa]

CVE-2026-80855: fuse: fix invalidate lock leak on open O_TRUNC DAX failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80855

Introduced by commit 2fdbb8d ("fuse: fix deadlock between atomic
O_TRUNC and page invalidation") in v6.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [a927f1867e61b78f39f9da0bbba3c98c2ca151fe]
stable/5.15: [1b04d80a27d317064cce2307472f5bef9975bc50]
stable/6.1: [a61524da59a2f5ac9c8de23ff98b30da769ab144]
stable/6.12: [7288c279ddbd654a06c82118c1a3f5570c1807f0]
stable/6.18: [776e85fda752f9a15e0f82dec42ecacd12a9bd94]
stable/6.6: [dcf30a56624c2a0cfab1bada5b1ca8cc0c02f010]
stable/7.2: [e981474d7bf1457da12404e169ea147d2c8ecea7]

CVE-2026-80856: fuse: fix invalidate lock leak on setattr writeback failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80856

Introduced by commit 6ae330c ("virtiofs: serialize truncate/punch_hole
and dax fault path") in v5.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9afeca0d569c9fc89d758fe7a9339d1e8afb1546]
stable/5.15: [8f14906ce9103ab8f2f1ebda45935a0d61b9d763]
stable/6.1: [03cfeeb135428fa83f0791d3f8f94d9298cae695]
stable/6.12: [ea9fea370b8de4ffd72e0ef89550415c15637787]
stable/6.18: [1758730d9eaa3c06cf415c3446d9f6eed9ed3eed]
stable/6.6: [92588d187ba4697a322e7aefe5d9e538a87d1cd2]
stable/7.2: [e8457ebfd77a46e8d1210e8888ea914ad064558e]

CVE-2026-80857: fuse: wait for FR_FINISHED on abort_on_kill to prevent
use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80857

Introduced by commit 204aa22 ("fuse: abort on fatal signal during sync
init") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [64b0b5cacbd2fea88001464cb712c9dfc795b26e]
stable/6.18: [a8bbb2a60513bf322170903c21462f0bf4f62be2]
stable/7.2: [715cb86e33cda43f5224cdc3fd5610c0b6a46f7a]

CVE-2026-80858: fuse: publish io-uring queues with release semantics

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80858

Introduced by commit 24fe962 ("fuse: {io-uring} Handle SQEs - register
commands") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [42df916e5a5f8fb4b60c8cefb54318d1ec02c580]
stable/7.2: [a1bb359c443d048fe5dfd6ca9caf4e3897f3e9aa]

CVE-2026-80859: fuse: fix missing barrier when checking io-uring readiness

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80859

Introduced by commit 3393ff9 ("fuse: block request allocation until
io-uring init is complete") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [edb310bc27f0ad83e7fd558a3caf1a94ca511654]
stable/7.2: [dd9c835709f4bb3e4256eea7573e4e6e18f956de]

CVE-2026-80860: fuse: fix race between interrupt and resend

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80860

Introduced by commit f8fce75 ("fuse: clear intr_entry in fuse_resend
and fuse_remove_pending_req") in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18

Fixed status
mainline: [ed9c881f3b498383f73c42712b359419da42a7b0]
stable/7.2: [26fbe4bc3ef3ab0200407681cbef182af5d151de]

CVE-2026-80861: usb: xhci: bail out of setup if the controller is inaccessible

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80861

Introduced by commit 66d4ead ("USB: xhci: BIOS handoff and HW
initialization.") in v2.6.31-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [78203d5b54a40f0e36196ebf31c9c7a380fc8811]
stable/7.2: [0b31744f70c5e06cce5fb660e02d057a3b9e0e37]

CVE-2026-80862: nvme-tcp: fix usage of page_frag_cache

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80862

Introduced by commit 4e893ca ("nvme_core: scan namespaces
asynchronously") in v6.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [36ac05f7cfd59d90c597071304b14e98090d5dd1]
stable/6.12: [d19f98c79f1b7e09e4cdf5c20d626e571e487467]
stable/6.18: [64561afb42d8390695bf810d9bbd087cbca00291]
stable/7.2: [6e4cf281558709b92ec2ca3054fe2ffc69266ef9]

CVE-2026-80863: RDMA/rxe: Fix OOB in free_rd_atomic_resources()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80863

Introduced by commit b6bbee0 ("IB/rxe: Properly honor max IRD value
for rd/atomic.") in v4.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de329533792a373186d79dca1ca120f8fa0afd05]
stable/5.10: [142c8165b7974b40fa62c393653edb5c00b8b5fe]
stable/5.15: [30b90b55201902b2b8edcdbe2315ccd4c7547002]
stable/6.1: [9b7d66ea88ae9395e42766b94a5c717b158b940a]
stable/6.12: [bc6e943794515d2a8417b02597a27bd377468d04]
stable/6.18: [bdf5deccfbf9f556a08d1d2ef52e9e48f969e53e]
stable/6.6: [f5e6580a3a16a83c743ad5a7c16922854a0d8b71]
stable/7.2: [d219e7a8eed3802970c3e4d243d79c70ef0a31bf]

CVE-2026-80864: RDMA/rxe: Fix responder UAF on
IB_QP_MAX_DEST_RD_ATOMIC modify_qp

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80864

Introduced by commit 8700e3e ("Soft RoCE driver") in v4.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f7014237405e7f032b5c53a82d9eccf6161c291]
stable/6.12: [0136b528b753c5a56e4d997ef20b86bb6750b8fb]
stable/6.18: [ffa4f0be69656be1755090f02db38d49816585c6]
stable/7.2: [60dfd47929cd1e7070daa810d40ce538d888410d]

CVE-2026-80865: bpf: Add missing access_ok call to copy_user_syms

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80865

Introduced by commit 0236fec ("bpf: Resolve symbols with
ftrace_lookup_symbols for kprobe multi link") in v5.19-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d5dc200c3a3f217de072af269dd90adddf90e48d]
stable/6.1: [a67f7f9647cb243b3be32163e88e5bc76e3d51e9]
stable/6.12: [128391b57e0977c35243672a6f970073651f3831]
stable/6.18: [0b6252afcd1965f77c6a6f8a802a2e1381822b98]
stable/6.6: [8b719cef5ac30ab83ce5693c5faf10e4944874af]

CVE-2026-80866: tipc: avoid busy looping in tipc_exit_net()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80866

Introduced by commit 04c26fa ("tipc: wait and exit until all work
queues are done") in v5.13-rc4.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [c1481c94e74c955e0448ddf46b8615a44d840c1e]

CVE-2026-80867: alpha/PCI: Add security_locked_down() check to
pci_mmap_resource()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80867

Introduced by commit eb627e1 ("PCI: Lock down BAR access when the
kernel is locked down") in v5.4-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [78a228f0aa0e9eba31955950c8a40a9945e2c8bb]
stable/5.10: [6e368485a1ac19fbde0a8b6a332d4545ae72a8ac]
stable/5.15: [ed2cd1fee0ed16a1c2dff49175e65c641eb8ae2b]
stable/6.1: [c3234efe21d4198945492cf7dba6859476f0f6ff]
stable/6.12: [85f966b1120874fe530edec50d28373ceb06ebcd]
stable/6.18: [94defb18ac792fd16407d5a52ad0d3f5055c4b43]
stable/6.6: [4de5ff924c0a8ef8166c1a68af9087826e1e8d61]

CVE-2026-80868: ntfs3: Allocate iomap inline_data using alloc_page

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80868

Introduced by commit 099ef9a ("fs/ntfs3: implement iomap-based file
operations") in v7.0-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [70d3855594cf6e8791970714b65cac3202d6160e]

CVE-2026-80869: ntfs: bound the attribute-list entry in ntfs_read_inode_mount()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80869

Introduced by commit 1e9ea7e ("Revert "fs: Remove NTFS classic"") in v7.1-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98634df5b1cb56c26299b7409227025ddb0167d8]

CVE-2026-80870: drm/amdkfd: Validate CRIU-restored IDs before idr_alloc

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80870

Introduced by commit 40e8a76 ("drm/amdkfd: CRIU checkpoint and restore
events") in v5.18-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [85043dd49c2f51a37b22618168e3ae59ab92f0d6]
stable/6.1: [f8687018f24037056692c1e93c7d96cc72889d5b]
stable/6.12: [085ea93bda71fee600cc12a17026598eb10dd1f9]
stable/6.18: [543ed0f61d56501cc585162da600bbedd7c08c0f]
stable/6.6: [89a75e3349c4fae28cbedc711bc924cbc6293da2]

CVE-2026-80871: crypto: xilinx-trng - Remove crypto_rng interface

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80871

Introduced by commit 8979744 ("crypto: xilinx - Add TRNG driver for
Versal") in v6.18-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [32b4d29280ed2a991dc196d5845b892acedc63b8]
stable/6.18: [83f29da85dc9d9a32fe62cd1055e8e6705e6bf80]

CVE-2026-80872: ALSA: hda/tas2781: Cancel async firmware request at unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80872

Introduced by commit 5be27f1 ("ALSA: hda/tas2781: Add tas2781 HDA
driver") in v6.6-rc1.
Introduced by commit bb5f86e ("ALSA: hda/tas2781: Add tas2781 hda SPI
driver") in v6.14-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5367e2ad14f0ae9350a7aaf2e77c87de39a43ae9]
stable/6.18: [f8272331da877eec8fe8e89a1e98e6a710e12490]

CVE-2026-80873: KVM: arm64: nv: Write ESR_EL2 for injected nested
SError exceptions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80873

Introduced by commit 77ee70a ("KVM: arm64: nv: Honor SError exception
routing / masking") in v6.17-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e2cb1f4578625e71f461d5c1ce70984193389cbb]
stable/6.18: [09f35145f3a4aacea4d9b914ad895bf5af8fc4ae]

CVE-2026-80874: arm64: dts: renesas: ironhide: Describe inline ECC carveouts

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80874

Introduced by commit ad142a4 ("arm64: dts: renesas: r8a78000: Add
initial Ironhide board support") in v6.19-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6fa6ee724d8dadf392139e242ac936b5da730c4b]

CVE-2026-80875: ipvs: use parsed transport offset in TCP state lookup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80875

Introduced by commit 0bbdd42 ("IPVS: Extend protocol DNAT/SNAT and
state handlers") in v2.6.28-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2500fa3958b1ba51c2b065e39db1b04dfa7e23a2]
stable/5.10: [2d06e0897ce18228d199887f0823b431d841dd03]
stable/5.15: [816efb7fc0aeae986e63ac73b428dd97a4ef69f5]
stable/6.1: [5848e914b85e360a2dd9d19c00a72e2ea9617dd0]
stable/6.12: [f6f550f26562d191c30b2818e7925dcb1c7f166c]
stable/6.18: [d73f4249776dd970ad65a69cfc51613dd8a034bb]
stable/6.6: [d45f73c274435703e8d7bc9d8b742a5d9111ab6e]

CVE-2026-80876: ring-buffer: Fix event length with forced 8-byte alignment

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80876

Introduced by commit 2271048 ("ring-buffer: Do 8 byte alignment for 64
bit that can not handle 4 byte align") in v2.6.34-rc3.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c37e0a4b79a6bbb96ce5ffe279d7c001e20529e0]
stable/5.10: [7c9f0ccf9f04142458d2ac3d39414f4acae242f0]
stable/5.15: [24c3fa71f9947b0e1f3b954db1b769b44140192e]
stable/6.1: [14057268e79654c3e8ea2c9b5204cb9644b2964d]
stable/6.12: [cfada73fabe2ccc06ec77fe2ceaa088689213326]
stable/6.18: [ec5e96aee75d27779b9a860307679f13f33adb0c]
stable/6.6: [dbcb8635b1eb7603818591cf745c7b1d714f7ac6]

CVE-2026-80877: afs: Fix vllist leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80877

Introduced by commit d5c32c8 ("afs: Fix cell DNS lookup") in v5.2-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fc10c0ecf06f2981af5d04357612b00051e03e9e]
stable/5.10: [13403945c2385653e282dacda304dce2a25fdb53]
stable/5.15: [2b169eedbb96f37f3f33d7b496d8283194988980]
stable/6.1: [bf55969d9188380eb539bd216850bac27bc2e272]
stable/6.12: [fbfe75c81bff2359a03e85cf84293484cf60fcb9]
stable/6.18: [8afb1a787a2802caf1895dd96745cfd6790a6f95]
stable/6.6: [bef5514f6b6cb4bed9061f4b628d6be1cf26a39e]

CVE-2026-80878: afs: Fix leak of ungot volume

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80878

Introduced by commit 32222f0 ("afs: Apply server breaks to mmap'd
files in the call processor") in v6.8-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d672c276f685a540ed2b2a8bafaed4650a89022c]

CVE-2026-80879: ocfs2: fix circular locking dependency in ocfs2_dio_end_io_write

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80879

Introduced by commit d647c5b ("ocfs2: split transactions in dio
completion to avoid credit exhaustion") in v7.1-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [ff6f26c58421614b02694ac9d219ac61d924bc68]
stable/5.10: [f0ae0a6ca87dc2d4a789f71cdedb808ba6c16990]
stable/5.15: [137e8b4823a9a11928428d4ec0a0cacb2f50a769]
stable/6.1: [4273548e418bd935430d35e9d052870f323441f3]
stable/6.12: [ff187c502b39389b0d732cb7050a3db8e5ebfcd6]
stable/6.18: [ae1f3460833d3e427420ab260278ec0e45d68c86]
stable/6.6: [49b34bd3ad69611af03590a23abf2cda9ac1073d]

CVE-2026-80880: IB/mlx5: Properly support implicit ODP rereg_mr

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80880

Introduced by commit ef3642c ("RDMA/mlx5: Fix error unwinds for
rereg_mr") in v5.11-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee7a8335069150c3f1893a697ab30bbeca00d796]
stable/5.15: [cbc9982c8573fb9e35040063aa78c8ebe768a1ff]
stable/6.1: [ee914ef54a7e707453ecb43eb30fb0a5c6dd0d69]
stable/6.12: [eb7cb798e563b3f3b3baeb9cc6f7455764267e50]
stable/6.18: [d4f84bfa089fe71f775d25beb29303e844494c25]
stable/6.6: [94f7e50eb6b2ce7fbd9aeac1db22460d2013a3fb]

CVE-2026-80881: ocfs2: fix buffer head management in ocfs2_read_blocks()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80881

Introduced by commit cf76c78 ("ocfs2: don't put and assigning null to
bh allocated outside") in v4.20-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [6371a07148ee979af22a9d6f4c277462953a9a4a]
stable/5.10: [a4eae1499c760949a93459d11390bd1fd823d31d]
stable/5.15: [4ab17e328522a4df5fe0f0dcf39098118b1feeaa]
stable/6.1: [5927acb3e2c99985a14adecd9d1b67ba191c622d]
stable/6.12: [61f7a5acb3bf8fc97dad78f54b1e8d0e1c819766]
stable/6.18: [0e389fc290c350c67591abf4c367119f4689f310]
stable/6.6: [ecb3f9386f4353034caef77239473c627232db17]

CVE-2026-80882: crypto: tegra - Return ENOMEM when input buffer
allocation fails for ccm

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80882

Introduced by commit 1e24594 ("crypto: tegra - finalize crypto req on
error") in v6.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [690a5f9e5c972a580565ce544ed1627ccf1e84de]
stable/6.12: [5cf0f624191cd12bd0a376bd7850d63b2b2236d4]
stable/6.18: [4f3c17f14cf9085a9c9ae2145f748ea55cf6d4e9]

CVE-2026-80883: drm/tegra: gr2d/gr3d: Initialize address register map
before HOST1X client is registered

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80883

According to the .vulnerable file, this bug was introduced by commit
d43f81c in v3.10-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c4ef5ba1131346159e31f4ef858525cf377380a6]
stable/6.12: [5db37fd7710e74bc4df48bddab8f571d0bfc6769]
stable/6.18: [40a2a91da02c434938f0ba53877984820800b5f0]
stable/6.6: [6e22d5ad61cfa38aa53fab86a530113aff6a3619]

CVE-2026-80884: ntb: Store original DMA address for future release

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80884

Introduced by commit fc5d182 ("NTB: transport: Try harder to alloc an
aligned MW buffer") in v4.20-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da6d997ac556479c112554ab5d95cbd04683eb11]

CVE-2026-80885: afs: Fix uncancelled rxrpc OOB message handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80885

Introduced by commit 5800b1c ("rxrpc: Allow CHALLENGEs to the passed
to the app for a RESPONSE") in v6.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a4057e58b07005d0fe0491bdbf1868c1491909ee]
stable/6.18: [231414253b648b3518b56f09710b831945d6a2fc]

CVE-2026-80886: serial: msm: Disable DMA for kernel console UART

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80886

Introduced by commit 3a878c4 ("tty: serial: msm: Add TX DMA support")
in v4.4-rc1.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [22dd2777e6c180e1c945b00f6d18550979436324]
stable/5.10: [f58e568dc308c8e13f7730c8de2da5ed514e540d]
stable/5.15: [bb4296de5b538b575978c588cb3738ab8524d01a]
stable/6.1: [6acea62738ed4cae6746483026706a773b44dad7]
stable/6.12: [2727744ccb5ca59090451451ee94f530b1be04a5]
stable/6.18: [d354716245192de2d203f2b35f22ab8dc13595e2]
stable/6.6: [abc1926c88c189e5d698b91ed6890e09ab5c321d]

CVE-2026-80887: drm/vmwgfx: use check_add_overflow for shader size+offset bound

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80887

Introduced by commit 668b206 ("drm/vmwgfx: Stop using raw
ttm_buffer_object's") in v6.4-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [54d56d5b42d2e4c72ba6e365e9774da90698aa22]
stable/6.12: [d3f44438aa805270aaead3b6840ccaea0f4c11f9]
stable/6.18: [cfd163169af3be56eaef113c680ea251f0d09189]
stable/6.6: [1bbe7751f5ebac383405ef29a66622d65bd505d3]

CVE-2026-80888: drm/vmwgfx: drop dma_buf reference on foreign-fd prime import

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80888

Introduced by commit 65981f7 ("drm/ttm: Add a minimal prime
implementation for ttm base objects") in v3.13-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f739416dc555fa205a785e5135d73fa39b26f35d]
stable/6.1: [619c3cfa88e09603a13d918f754808db2dda7057]
stable/6.12: [a1e972fa94c3a8069e022c67b9d97c7aa7b05293]
stable/6.18: [a8434b145b1e467940334c58c00af241e9494c5f]
stable/6.6: [c1c22fca0a0896a452a7cb92422d67babd65b4be]

CVE-2026-80889: can: isotp: fix timer drain order, wakeup handling and
tx_gen ordering

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80889

Introduced by commit cf070fe ("can: isotp: serialize TX state
transitions under so->rx_lock") in v7.2-rc4.
Fixed in v7.2-rc6.

Bug introduced commit was backported to following branches.
cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [050f010f920da17c1044a4f174766ad553e770b6]
stable/5.10: [8acab9fc66d6f426c36968c91a979f70784945a7]
stable/5.15: [af7e25c649ed68cbad07f8185af0f31b892cbf29]
stable/6.1: [2753722612d8824d3910096f93059f669009b0f0]
stable/6.12: [deca7746b57d982cd4f0301f4443f56780c4a048]
stable/6.18: [10be509fa8fd95d1e47d40d1f68b0b26dfe9d572]
stable/6.6: [bf5c4a8b24acb12739ebb9aea5510b007e4f5239]

CVE-2026-80890: sctp: reject stale cookies with mismatched verification tags

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80890

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9d8da8e0a9bce4a340af60dd0446bc7eb8d07587]
stable/5.10: [f6e3cc296372accad4ee57405195021231ef4bcb]
stable/5.15: [c151daba0ceb1fb068a215b07de89fb1eb5f87bc]
stable/6.1: [817cffdbdbdf50e1f2b016599d1897de3ca54964]
stable/6.12: [c68557a49e960dbcdede22c7a9b488603078b8b4]
stable/6.18: [a0d1693923f41d6f49083aa2446686aed09d1d79]
stable/6.6: [61baa5020b0afb41bfd97f8f6ce5e336c4a4546e]

CVE-2026-80891: KVM: s390: pci: Validate AIBV and AISB before pinning
guest pages

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80891

Introduced by commit 3c5a1b6 ("KVM: s390: pci: provide routines for
enabling/disabling interrupt forwarding") in v6.0-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [868d32ac72cba21c5c6d8a66a814b7c25a3a5c01]
stable/6.1: [3a1c64220ede4ac9ef9a3e76f008ff60a34f4c48]
stable/6.12: [15df7700dd99f8a37f5c6ed2dcf1e33009cdba47]
stable/6.18: [b878ba7e28144c9a857bc847d31f3c45413450ac]
stable/6.6: [f00ef8efd41440129ccd88f4a1ebebf8d61d297f]

CVE-2026-80892: erofs: cap LZMA stream pool size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80892

Introduced by commit 622cead ("erofs: lzma compression support") in v5.16-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9b47e6b23114e939b17f818471c7a46e59006e7]
stable/6.1: [682cb3ece37fc5141e73bc726ccf4adb833e5189]
stable/6.12: [0c676903cb2a61992ded8e7907609cc6b0f11744]
stable/6.18: [5aaa06dfc10f8398c8807453dbec738ea9af10e4]
stable/6.6: [e8b3d09aa8889dda9be9cbb3d2f0218c4b9acde4]

CVE-2026-80893: mm/hugetlb: fix swap entry corruption when clearing
uffd-wp at fork()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80893

Introduced by commit bc70fbf ("mm/hugetlb: handle uffd-wp during
fork()") in v5.19-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83abe2fd5b3aeb3123b5408a5a91709c5538fb23]
stable/6.1: [f1b1311c0352873137768bac5a126e491271a747]
stable/6.12: [8b0de7005b148738d79d6c45594d566489948a68]
stable/6.18: [2b9a07002c2f296aa6a9c591213933d3492e3089]
stable/6.6: [69cb5825d9988c7944bc9f1dc08cb233655405a7]

CVE-2026-80894: iommufd: Fix wrong hwpt passed to
iommufd_auto_response_faults on replace

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80894

Introduced by commit fb21b15 ("iommufd: Make attach_handle generic
than fault specific") in v6.15-rc1.
Fixed in v7.2-rc6.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [ba5c0f28a26e7d9be1e0997f8920dd638e2782fd]
stable/6.12: [adb87155b67f9759ff010c0a99559f5bffa45dcf]
stable/6.18: [564ac339c0f8bada4e77a57a92bab9d3df635e07]

CVE-2026-80895: mshv: Order pt_vp_array publish against irqfd assertion path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80895

Introduced by commit 621191d ("Drivers: hv: Introduce mshv_root module
to expose /dev/mshv to VMMs") in v6.15-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b098dc869219c15dc49bf9cf63fb5fc1481d3373]
stable/6.18: [062aa5dcc49a9ad96726a80c2a0ab0a1233bc2b9]

CVE-2026-80896: mshv: Fix race in mshv_irqfd_deassign

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80896

Introduced by commit 621191d ("Drivers: hv: Introduce mshv_root module
to expose /dev/mshv to VMMs") in v6.15-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0762262ac3e70f65b3bb843fe892f8bac1562d08]
stable/6.18: [72a90ce4918b5a2d4820fe20677ba9af780d8826]

CVE-2026-80897: netfs: release readahead folios on iterator preparation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80897

Introduced by commit 06fa229 ("netfs: Abstract out a rolling folio
buffer implementation") in v6.14-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87eb3d272dcbcbbfe5c1576c10e5dc72810cf1f6]
stable/6.18: [2c148a31ca01fc160aceec777bbc0041b0d0b8bd]

CVE-2026-80898: netfs: clear PG_private_2 on copy-to-cache append failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80898

Introduced by commit e2d46f2 ("netfs: Change the read result collector
to only use one work item") in v6.14-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a81fc9266e1c5fef9ccf675a9b44b2f4ab464923]
stable/6.18: [627826ef4208042b0470d1a3fdb729ce35471a0d]

CVE-2026-80899: erofs: remove fscache backend entirely

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80899

According to the .vulnerable file, this bug was introduced by commit
a1bafc3 in v6.9-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c37460cd9b2fcb61ec66b7eb4fde737e65ec2a56]

CVE-2026-80900: ASoC: SDCA: Make UMP message size check more robust

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80900

Introduced by commit daab108 ("ASoC: SDCA: Add UMP buffer helper
functions") in v6.19-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [556d872e7c2a0b570c5b0974813847ef0d0cd637]

CVE-2026-80901: ipvs: fix the checksum validations

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80901

Introduced by commit 2a3b791 ("IPVS: Add/adjust Netfilter hook
functions and helpers for v6") in v2.6.28-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e876b75b9020a97bbdc79721e7fc749024891c65]
stable/6.1: [d418d73acf8be62744dc47359dfdde8c2148845d]
stable/6.12: [9cbe2c0fdb71904ee929b1851cdc1c73341a03c0]
stable/6.18: [00eb23829fd08df1b5e057cb6b625996a70e7e65]
stable/6.6: [b3869d9b54e76dff64118dee4c8fd9302fcd5171]

CVE-2026-80902: dmaengine: sun6i-dma: Fix reclaim descriptors while
terminating DMA

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80902

Introduced by commit 5558593 ("dmaengine: sun6i: Add driver for the
Allwinner A31 DMA controller") in v3.17-rc1.
Fixed in v7.2-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab1150115e68a46b687eb38c1ab92782018c9f2c]
stable/5.10: [bb87440561eb72b47a2b848b5373b86433b247e6]
stable/5.15: [004a7a02982bed0a727a4ac7be400f00f353e7a2]
stable/6.1: [b150f603083cc8b72b0cbf13ec3e91f85b4390a0]
stable/6.12: [1ccc5c059d067c5358682ad5352e7d7e9239ed9b]
stable/6.18: [9086b488f2737d5dcee86852b83f2059f1cdfabf]
stable/6.6: [27806fe7b9701af0963dcd510e30e7d0cc314c43]

CVE-2026-80903: drm/xe/oa: Fix sync entry leak on OA config emit failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80903

Introduced by commit 9920c8b ("drm/xe/oa: Add syncs support to OA
config ioctl") in v6.13-rc1.
Fixed in v7.2.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [8d33c4987cd162527375a3905017ae129ba7c3fe]
stable/6.12: [fcf7943b0a38568c547d7b5702de1d8190480616]
stable/6.18: [948f346fe36e1d02353c3d61b1f6b66c6af91996]

CVE-2026-80904: net/tls: Fail tls_sw_splice_read() after a failed async decrypt

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80904

Introduced by commit f314bfe ("tls: rx: return the already-copied data
on crypto error") in v5.19-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [976df67f463db1fddaf2a32fb04f57ad2891a23d]
stable/6.1: [a808aadff634c7a408b2ab84d5919e9a741fdb5b]
stable/6.12: [18ae1e95f20867106a28820c208a9cec99dda861]
stable/6.18: [82d9269f01ebfd835b6256aa17016a974cbbc647]
stable/6.6: [06c2a53604fa1dc4820063828d7dadb3675b7af8]

CVE-2026-80905: net: tap: fix wrong transport_header when sending
VLAN-tagged frame

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80905

Introduced by commit 8c76e77 ("tap: call skb_probe_transport_header
after setting skb->dev") in v5.0-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cbb35cbe8db268fefe34c23df15348cf99025298]
stable/6.18: [5ffaa5d7f56ab24a8e23cf131eadfef31a3bbc4b]

CVE-2026-80906: net: packet: fix wrong transport_header when sending
VLAN-tagged frame

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80906

Introduced by commit dfed913 ("net/af_packet: add VLAN support for
AF_PACKET SOCK_RAW GSO") in v5.19-rc1.
Fixed in v7.2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [01fdecc0480d916c799dbee584833a4a37e94d06]
stable/5.10: [a4b82de96d465ddb44bc931145c0fa80c4fe9c9c]
stable/5.15: [fa86bc52ea8ba981f74f851fd61e2a3d3bc0feac]
stable/6.1: [5479eb9b355f44745d7ccfe112386bd4f96eceea]
stable/6.12: [6971cf319263d6a1b4096f9248aca9e57d77a1eb]
stable/6.18: [f9297abbcaba760b7a7b9d63b839f607f738013e]
stable/6.6: [e451e20adb869a983a21dda158625f024142e61f]

CVE-2026-80907: drm/amdgpu: Fix UVD dpb min size calculation for H264

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80907

According to the .vulnerable file, this bug was introduced by commit
d38ceaf in v4.2-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [21a8084cd76223a13493237e04d45f5226d7cee6]
stable/6.12: [33f4ef585368fe93523dca1e5440e006f6e5146e]
stable/6.18: [38914cb2c6afb5fe00241ea3438e655822196378]
stable/6.6: [fa96c24485942e277483cc70d9551d9e0111d7c5]

CVE-2026-80908: drm/amdgpu: Reject UVD message with dimensions above 4096

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80908

According to the .vulnerable file, this bug was introduced by commit
d38ceaf in v4.2-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8c9aebcdd9f46f7a14b98d6ab18574b7a48fbb08]
stable/5.10: [8bae80eaed00e7ae28412a3cdf590f4beca72294]
stable/5.15: [9adc5e25f31d7ee7dfc18814499b6e3a6d402904]
stable/6.1: [382bef781ff441ce8055bdada57b8c291dc0fd30]
stable/6.12: [f7af372d3b892b95dd3cd1c6acf29daa39ba076d]
stable/6.18: [339deb76ee4859ea973e435c9a9a4a4fefc29338]
stable/6.6: [8435d41afcf2bc31ecee213ef651c12bd1a16d38]

CVE-2026-80909: drm/amdgpu: Reject UVD message with invalid number of h265 refs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80909

According to the .vulnerable file, this bug was introduced by commit
86fa0bd in v4.2-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9fca434208f1f9ab977feac62df8ebb1cc7ce893]
stable/5.10: [1facad2a78c1a8aeecc36eb4d560c7f1e10ce198]
stable/5.15: [499907e5d46e575e96967c0230a0a6af980a17ab]
stable/6.1: [cbf1c84bf5cac2b3742ea3d2085fa713424465cc]
stable/6.12: [2abcdc5f738574e7fcdd9417575dffb877fdc26f]
stable/6.18: [e304c3e0d9ce251887be1f274aa0ed52219d5fd7]
stable/6.6: [a930c54cb67200de8bc0de87480d09ece7dcd85d]

CVE-2026-80910: ASoC: codecs: lpass-wsa-macro: Fix enum kcontrol accesses

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80910

Introduced by commit 809bcbc ("ASoC: codecs: lpass-wsa-macro: Add
support to WSA Macro") in v5.11-rc1.
Introduced by commit 2c4066e ("ASoC: codecs: lpass-wsa-macro: add dapm
widgets and route") in v5.11-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [56f24311fd5607588a47e44675195a9efb200f29]
stable/5.15: [bd4e5f9c3b764dc0e2a5662f92d63d2f3767a78d]
stable/6.1: [4bcac4bf304a3ec746192e49a669c236aaf27dbf]
stable/6.12: [524aa7b9954b0a43dd13f71ecbbac52a151c326d]
stable/6.18: [2fe7a89b2b5b73be35c1e493d0246314ba54e427]
stable/6.6: [891129df5de79cd533ae335c6eab24df2ff2b0fd]

CVE-2026-80911: ASoC: SOF: sof-audio: Fix error path in
sof_widget_setup_unlocked()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80911

Introduced by commit 31ed8da ("ASoC: SOF: sof-audio: Modify logic for
enabling/disabling topology cores") in v6.7-rc5.
Fixed in v7.2-rc7.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [e780e4917d43683224812400fe3dc4816fceba75]
stable/6.12: [c06995637f6a4667f2b540ac65315bfc8196a099]
stable/6.18: [8cba53b862e1437257ec206d303ff942684284f1]
stable/6.6: [b270ed327380428581bbcbd85707f62e942428d7]

CVE-2026-80912: selinux: reject an unclaimed class value in
security_get_classes()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80912

Introduced by commit 55fcf09 ("selinux: add support for querying
object classes and permissions from the running policy") in
v2.6.23-rc1.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [22b05fec62c0fe9864cfceb52f7d0f3a34d9b1dd]
stable/6.12: [099869e9343a5f8c22b58497f074b34f63cbf856]
stable/6.18: [841aea4d5a25e16273d04cd07a74142b4687e03b]
stable/6.6: [e0285bb152211c00900136b66d4b420c14a59094]

CVE-2026-80913: selinux: require every boolean value to be defined

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80913

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a93d37a09b863810653f93d371fb197457d59deb]
stable/5.10: [4d0ece18e648bd4362704fd087249ac697f2b7fb]
stable/5.15: [3938c8494d3c5d84a53fd7d1966ae9dde46cb5f8]
stable/6.1: [4dfb997c60f7951011d3dcbee926e3a7f80d8a76]
stable/6.12: [740012aebdb8311332bf66e2aabf453ba73c2c45]
stable/6.18: [42a7107f99d86a7524c37f108047dfa3db096ab5]
stable/6.6: [3161daa3f1e3ca68f8b2b8fa01720b5a8dcc6b40]

CVE-2026-80914: Bluetooth: ISO: fix use-after-free of listener socket
in iso_conn_ready

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80914

Introduced by commit ccf74f2 ("Bluetooth: Add BTPROTO_ISO socket
type") in v6.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [560bef609fa5992745929e8d7d458b9d88dd2830]
stable/6.12: [2387cd06a2c0b416f05028b02bba1089f54c28d9]
stable/6.18: [49fd7116f76b860b230843700fb7423ab5331e1f]
stable/7.2: [03288b7447c9e572f8ab82fc29cfb4ca719ab210]

CVE-2026-80915: drm/xe: Fix DPT allocation paths.

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80915

Introduced by commit 775d0ad ("drm/xe/fbdev: Limit the usage of stolen
for LNL+") in v6.12-rc1.
Fixed in v7.2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fc648757908304aedbad74f74bf58192aec383db]
stable/6.12: [491c499295fb0b90308b230b0a1075dcdf7f4d12]
stable/6.18: [f03415030579163f791c978741af7f1f2f6510b7]

CVE-2026-80916: kcov: fix data corruption and race conditions on PREEMPT_RT

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80916

Introduced by commit 5ff3b30 ("kcov: collect coverage from
interrupts") in v5.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2eed77fdcb0cc48e8eccb2bcd4b7f2c6d650e84c]
stable/5.10: [ef7048d8a614c5f5a9b20513a5428101a744514e]
stable/5.15: [8ed3ddf23d39bf5338406bd9f8863d44748cf6ce]
stable/6.1: [5dc59fc959b2b5742985d7ef24bccd1868217dc2]
stable/6.12: [18799e858b407bf355383c9dd6c06477aa437134]
stable/6.18: [e11f5b48c82703242a3be7a7ae4b4940b4cb4610]
stable/6.6: [a2fb8222cde23b0001812ed3acb7c0ea36dd94e2]
stable/7.2: [f8c9a3ec36b4ee3d4701b9be08f40e7bfbf89761]

CVE-2026-80917: PCI: host-generic: Fix NULL pointer dereference on
32-bit CAM systems

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80917

Introduced by commit 8fe55ef ("PCI: Dynamically map ECAM regions") in v5.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [008cb88edb41f3c7c8e0ed763ff9f26719830984]
stable/5.15: [5e52eb0290f66ba0732956dcb1e365b5ca3c5108]
stable/6.1: [baf9b0383ff770fdff123d3a832f3a99641d96dd]
stable/6.12: [74456843f18ba7f3045974d7e8b88ab993152b8c]
stable/6.18: [0c55707bd5d0d7670704cfd0dda933809b052f67]
stable/6.6: [8d08713ec83a18526d1ed1fd5f0d2b901d103a10]
stable/7.2: [0916948026f623844acd08888f7cbedbf1c48d6b]

CVE-2026-80918: HID: core: fix number/pointer type confusion on long items

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80918

Introduced by commit 3dc8fc0 ("HID: Use hid_parser for pre-scanning
the report descriptors") in v3.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [28abce951343fcec26e397610868efa4e1395c3f]
stable/5.10: [bed7fe3a936b6bdd84671385951397ca673cf6e7]
stable/5.15: [aec2c2ec87d4ec1f098979f68cd81b29f031c8cb]
stable/6.1: [634f498ea5d5e8e01f8d9414d4f45eeaf9ee1996]
stable/6.12: [dd8035dec26e98204d6e4a6e0cee5c4d329b3d7e]
stable/6.18: [1fa1591efd417e39e5e164bebea8ca7a3837c469]
stable/6.6: [abec577de5fc16cd5caae42f97cdcd0983c06d66]
stable/7.2: [e542edada3f79387c0ac2a528cebf01f4ef47df8]

CVE-2026-80919: drm/amdgpu: fix recursive ww_mutex acquire in
amdgpu_devcoredump_format

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80919

Introduced by commit 7b15fc2 ("drm/amdgpu: dump job ibs in the
devcoredump") in v7.1-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7152b248dc3c8d5fa8629e99ed5655dd41b51562]

CVE-2026-80920: io_uring: defer eventfd signaling when queued from a
wakeup handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80920

Introduced by commit 21a091b ("io_uring: signal registered eventfd to
process deferred task work") in v6.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cd305ee3633a45fcf5f3a5d83f99f3cb77d87b6e]
stable/6.18: [e22f4494cc9487d326e5e3067f33dea7c1e442b2]
stable/7.2: [40b6ccf68731809ceb85c6e9f0f8f2ed61c7aa5a]

CVE-2026-80921: KVM: s390: vsie: zero stale crypto bits

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80921

Introduced by commit 6b79de4 ("KVM: s390: vsie: allow guest FORMAT-1
CRYCB on host FORMAT-2") in v4.20-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [34d5b5b646c91cfb9338d7a12c955a70ffb8c66b]
stable/5.10: [d110b3297f11ef227098b8a82ade2d5f123b7d2f]
stable/5.15: [59d51550b5cb916bda037673a721a404b3b47a0d]
stable/6.1: [f6079dca67eccb5eabef9f72437948c66dc5131f]
stable/6.12: [7d23489f51109e3ebba5b5db8c5f0185af7b7fdf]
stable/6.18: [935eeba276012916c76243e5cbb843efd8fdb75d]
stable/6.6: [087c19cc60a8caa1a08e1e434c8be2caf6c27733]
stable/7.2: [29b4f7bc2991313bd3e6f6fb8fdf1b173f086dd6]

CVE-2026-80922: crypto: qcom-rng - Allow zero as a random number

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80922

Introduced by commit f29cd5b ("crypto: qcom-rng - Add hw_random
interface support") in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ef04bdc0c9f98836d1638be516f6bf1bad55f69]
stable/6.12: [813e6718a199befc4f26f54bdd899fbfa11515e5]
stable/6.18: [4c0018320942003bfedd0a1c4cce3f036d363a7f]
stable/7.2: [3c7101cfc52e378bcb0a46962145e39c9051dd5d]

CVE-2026-80923: xhci: dbgtty: Fix unregister on tty_register_driver() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80923

Introduced by commit 4521f16 ("xhci: dbctty: split dbc tty driver
registration and unregistration functions.") in v5.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a916fa66a43e10f63198b6ce978badffc678821a]
stable/5.15: [01b7bc0938061f2fd46e0094f6483d8c6c02f7d3]
stable/6.1: [43635ff6401ca0e0ed21875379eeded921321525]
stable/6.12: [943f976c93e70563b132f5585ff68b08c89641a2]
stable/6.18: [0d0faf3cc44c4d86fc6faf5cea972c0fbe00b922]
stable/6.6: [eaca2814f32b9872a332326324b9e83e01f156d2]
stable/7.2: [0e469b94fbba8eb03666da41dd1082b793c50c1a]

CVE-2026-80924: crypto: krb5 - use kfree_sensitive() for derived key buffers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80924

Introduced by commit 3936f02 ("crypto/krb5: Implement Kerberos crypto
core") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7d53dd3f267e46a784f219a75072f2f400d42b9]
stable/6.18: [731a5b6fb4c1705f9405d9029dd64ea81e336207]
stable/7.2: [a1bf79365794783b19f5b09e8a23f7ee311e8931]

CVE-2026-80925: vlan: fix skb_under_panic and races when toggling HW
VLAN offload

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80925

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [447cbe95ebb95392b5d8f6a01c0556826919ce23]
stable/7.2: [a29f3b884ba50217e6f50414f568073221e2bb07]


* Updated CVEs

CVE-2025-21817: block: mark GFP_NOIO around sysfs ->store()

stable/6.12 was fixed.

Fixed status
stable/6.12: [a09280c39ea54080daf19cfaf4a3121a8d17d5cd]

CVE-2025-22108: bnxt_en: Mask the bd_cnt field in the TX BD properly

stable/6.12 was fixed.

Fixed status
stable/6.12: [9ee185e0f15594017a6f1a191ebe6630cfea5f74]

CVE-2025-22127: f2fs: fix potential deadloop in prepare_compress_overwrite()

stable/6.12 was fixed.

Fixed status
stable/6.12: [7cd460bd9e7c6e6c30a33982603f65fb5deab1e4]

CVE-2025-38205: drm/amd/display: Avoid divide by zero by initializing
dummy pitch to 1

stable/6.12 was fixed.

Fixed status
stable/6.12: [03a3dbca3b8e55b88958ce1f54aaf678ded11c79]

CVE-2025-38621: md: make rdev_addable usable for rcu mode

stable/6.12 was fixed.

Fixed status
stable/6.12: [d713e105a6137d3f54f09d4d9e2273482057ca17]

CVE-2026-23459: ip_tunnel: adapt iptunnel_xmit_stats() to
NETDEV_PCPU_STAT_DSTATS

stable/6.18 was fixed.

Fixed status
stable/6.18: [5d562153b4719234227f99c2fb529f98a6a44d15]

CVE-2026-43009: bpf: Fix incorrect pruning due to atomic fetch
precision tracking

stable/6.18 was fixed.

Fixed status
stable/6.18: [ea150ffa9fc9f78c5cf22e1f7b06b6d016b1017c]

CVE-2026-43344: perf/x86/intel/uncore: Fix die ID init and look up bugs

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [bdb35811ff41a1678620a407056b6372f350028a]
stable/6.18: [c79ef3342632e71ac8612a2a1cc17ac84dd258b4]

CVE-2026-43391: nsfs: tighten permission checks for handle opening

stable/6.18 was fixed.

Fixed status
stable/6.18: [24ebaf6676ae4f74f4856eb645959b15e62bc1b4]

CVE-2026-53102: wifi: mt76: Fix memory leak after
mt76_connac_mcu_alloc_sta_req()

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [7de35b99503012e57bec027e98ed53f881518b5b]
stable/6.18: [8527ac1bce87aaabde6755e8e6eb2a9f439d1292]

CVE-2026-53113: wifi: ath11k: fix memory leaks in beacon template setup

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [9478aa5b39e986d45fafe279c24d3546783c22b1]
stable/6.18: [5fc3d921512d31839227a2d22a2990de02acefeb]

CVE-2026-53313: drm/amd/display: Avoid NULL dereference in dc_dmub_srv
error paths

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [a71fdbd6e8289e2725d33a9873833459f3b1824f]
stable/6.18: [2ab18de5ebb11c76bfc8087c5a09fbcccd0dea8a]

CVE-2026-63839: platform/x86: lenovo-wmi-helpers: Fix memory leak in
lwmi_dev_evaluate_int()

stable/6.18 was fixed.

Fixed status
stable/6.18: [ce493f9261cd3f4bffe2f72481d8c3ee01c559a3]

CVE-2026-64068: netfs: Fix missing locking around retry adding new subreqs

stable/6.18 was fixed.

Fixed status
stable/6.18: [d5c9d19b0ff2f7153532ac238a5e96fed2df315c]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com


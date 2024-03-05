Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2866C54E41
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 09:41:13 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
 by mx.groups.io with SMTP id smtpd.web10.18082.1709631670069758423
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Mar 2024 01:41:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=KgEyNTM/;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=rrdKUv24;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.25, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1709631662; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jOIJYw3ex+AqLe7MFPLrjNpFJZCbvmNDtz3dbEymXyfbKHsGksPI+9MnwRUmgluO3h
    lKWx/Lt5+tx9RNXHJ1+4kxxBbm4wLYZyGLTTnzAuDrmmjD6NGvMkUAWWds00WpEwPeh/
    AaP22gnUuhYxtETKmhPmcX02xtjgnLPTuFPGg1WRBgsbt8RbjzAALlu9mv6jpBkjJuH1
    KtBwMP/XmhHMz/THDOQqu813SG77bjOsEm9H4kOu1spSoHIsfaRqX2c8Uv/NM5Eo2gm3
    Va2HGwLNePq2Ud8jgZYcBxdtvAAq3virkm0KVSN3AD7LKBybGMJP84eZRywsuWg399HM
    PMAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1709631662;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=fSsfEcpLx0/rVUtPjsPCcEvK4/uMvthAYeQWuwOo4y8=;
    b=TsAqRmxPWbXn7hagZHHA15lpJPBOew2fDbexKffyo1FadKjWLWYEupzgGJ/Bz7zBNX
    G8h0k0h933UojoujxtLK8gm3jJ5FowNYwUyRBPzOCJ8aak5OqN//myT3qd9u3dsbz7NB
    LO/7BXDSduN879uxTtG+xhjnTToPXg3gKscamD8497VhDC2Q8taarRJ3Gp5WHC/1aQRM
    KKjVMK98YwWpAU8WyDnW1iLFBfQla3yU98Sv1D8EFtgnh4qF+LJbWi+SYzL/C+skm/S3
    AedtMUlH1nMv2TjjCf+955zesFdT756gQW+tpZMq2LQcVcqxxJ7qhmigasSNBxNjan1Z
    ij/Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1709631662;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=fSsfEcpLx0/rVUtPjsPCcEvK4/uMvthAYeQWuwOo4y8=;
    b=KgEyNTM/+hhBjr2eYuhjtbITSHSD68eplS8+yRQB+LKNH9L3X7Sa9P+/5gq1NcL6Te
    /gQlyX2cJ4hv1TwnZ9V9bE1W62rZMwr+3JwYmj9SIs/lUeZxcDMdyNI4Y9K63G6IxJ9c
    7bWQxEzwLFsydXTFW9xW4KoosXXRMsak2uc8yotZ2NNnkVoJBiKKDeweduaYGFzN7z6u
    3oMD6VokxpYcMQjmHRv77DGHszmf37flmPgltAzUrAna9Km2YT1Z3pN2/9eiIXqXKaMM
    I5J5Pb5+Vatqk+CaPw+Nn+yq511oJ6mATvYvxrxXPCT0+tsFHO4llOGARA5P/wpVq2f/
    HcmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1709631662;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=fSsfEcpLx0/rVUtPjsPCcEvK4/uMvthAYeQWuwOo4y8=;
    b=rrdKUv240ruAHiVRFLoKwpXClUGmNz6+AhWsufZCZEbLaApLo2LDfbLlTGzmkiqOP/
    XTXsaflBnbq7MgMAwVCA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKDH+Phm8yA="
Received: from ox-live-app305.back.ox.d0m.de
    by smtp-ox.front (RZmta 50.2.0 AUTH)
    with ESMTPSA id R951020259f1Jnq
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 5 Mar 2024 10:41:01 +0100 (CET)
Date: Tue, 5 Mar 2024 10:41:01 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <595658312.2214847.1709631661765@webmail.strato.com>
Subject: Request for reviews for 4.4-st49, 4.4-cip84
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev60
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 09:41:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15214

Hi!

Due to the switch from 4.14.y the upcoming release of 4.4 covers five 4.19 =
cycles and comes in at 26 manual backports that need to be reviewed. My apo=
logies.

As usual, patches can be found in https://git.kernel.org/pub/scm/linux/kern=
el/git/cip/linux-cip.git/log/?h=3Dlinux-4.4.y-st-rc

** m | 2db1c46c3 9eab04 o  | mm: fix unmap_mapping_range high bits shift bu=
g
** m | 063f6c37b a1c95d .+ | crypto: ccp - fix memleak in ccp_init_dm_worka=
rea
** m | 71ba0d44a ee6e6f .+ | crypto: sahara - fix error handling in sahara_=
hw_descriptor_create()
** m | f7f627ac7 d03376 o+ | Bluetooth: Fix bogus check for re-auth no supp=
orted with non-ssp
** m | 02160112e 53edb5 o+ | f2fs: fix to avoid dirent corruption
** m | 14b84d9a2 15e4c1 o+ | fbdev: flush deferred work in fb_deferred_io_f=
sync()
** m | fef91b68a b3943b o+ | wifi: rtlwifi: Remove bogus and dangerous ASPM=
 disable/enable code
** m | 5733959d6 3ef79c .+ | serial: sc16is7xx: set safe default SPI clock =
frequency
** m | eafd83b92 78aafb o+ | hwrng: core - Fix page fault dead lock on mmap=
-ed hwrng
** m | 771df0145 None o+ | x86/CPU/AMD: Fix disabling XSAVES on AMD family =
0x17 due to erratum
** m | f08405728 173431 o  | btrfs: defrag: reject unknown flags of btrfs_i=
octl_defrag_range_args
** m | 17c04def4 658a52 o  | ext4: unify the type of flexbg_size to unsigne=
d int
** m | 07f181ed6 3ed48c o  | PCI: Add no PM reset quirk for NVIDIA Spectrum=
 devices
** m | 0fee6850e d6b83f o  | bonding: return -ENOMEM instead of BUG in alb_=
upper_dev_walk
** m | 9d3aeecaa c248e5 o  | ARM: dts: imx1: Fix sram node
** m | 81ca80caa dc1cc2 o  | md: Whenassemble the array, consult the superb=
lock of the freshest device
** m | 9eef5de46 90d50b o  | drm/mipi-dsi: Fix detach call without attach
** m | c807df25c bfbea9 .  | clk: hi3620: Fix memory leak in hi3620_mmc_clk=
_init()
** m | 7840b2e4b e3fe8d o  | virtio_net: Fix "=E2=80=98%d=E2=80=99 directiv=
e writing between 1 and 11 bytes into a region of size 10" warnings
** m | b74c5d0d1 bbc404 o+ | ixgbe: Fix an error handling path in ixgbe_rea=
d_iosf_sb_reg_x550()
** m | b0b2937fd 259eb3 o+ | netfilter: nf_log: replace BUG_ON by WARN_ON_O=
NCE when putting logger
** m | 324181326 5dee6d o+ | net: ipv4: fix a memleak in ip_setup_cork
** m | 04b9c13dc c73729 o+ | i40e: Fix waiting for queues of all VSIs to be=
 disabled
** m | bcf4a115a 0958b3 o+ | tracing/trigger: Fix to return error if failed=
 to alloc snapshot
** m | 81c0229f3 741ba0 o+ | pmdomain: core: Move the unused cleanup to a _=
sync initcall
** m | 42fada9bf 5124a0 o  | nilfs2: replace WARN_ONs for invalid DAT metad=
ata block requests

Thanks for having a look.

CU
Uli


Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9BEC77B7A
	for <webhook@archiver.kernel.org>; Wed, 17 May 2023 23:11:33 +0000 (UTC)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
 by mx.groups.io with SMTP id smtpd.web11.2310.1684365086151403509
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 May 2023 16:11:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=ud4h13K4;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.49, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-19a19778b09so590861fac.3
        for <cip-dev@lists.cip-project.org>; Wed, 17 May 2023 16:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1684365084; x=1686957084;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Peac+ZueI12uCGBrI2fdlUzr3ErYWX38gUoUrwwoYN0=;
        b=ud4h13K4BUvRBXtEweQ0RThaGifEX0b++7hXM9AYfwM2HE2JX0RTZ8HnsYR0v5aCIz
         1Siw6G0th4nBxEi3H3WGqpUzNEP2x6d7HEMxYF6c2j2w+IHC9HkebHbcmtCqALWmYyqZ
         NPlbJnDU6t3URrKVa2X03w4X1b9JCCGC/1ydC2w01T5fEtniN/4h6Pc2ZCzGidxSD1Ak
         uPCUz/LWZAiz5LyBlNcWpTSWMJPXEj7U4beD2odY+Cn2/Rxty1HbNJlMe6pvAF9zMcfj
         tasSe3/QGjD+qEa4Q4dK6IIjNGO69EONsII+9Pw0qmis+hvbkcBl65c0tRoi/jjqJ+vm
         w6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684365084; x=1686957084;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Peac+ZueI12uCGBrI2fdlUzr3ErYWX38gUoUrwwoYN0=;
        b=eUImH1MI+I9Qs9DU7v9UJP/FOT22kN25fyxrXwCs14NQtmvRk9b2KrhAZU8yEpqgUq
         F6EL1vp9mPX6ft1CG1IOtPtMDEWdmNrhiDkRWkOVCaF4WvJVVNq3wO3wWpt1Q2+svIZn
         hi5rTiS/OtURKRcvK08TyFBHo85jPSv/6GSi8rFgFio1GBLfSmALxfl+ioJhNFiAFJZH
         x82lDMo6vDqRD+4QUnpJjCp6sjX1tSLod8uZ9PiqI4JMxPcm3DeiYjQ/uE457Y+jUPc9
         PO5pvo4nWtjKbBoMsG9azk8tP3n6p9YgLv/pRIcqlO0o9TqSiU99bZDI0wYJiqbknaMr
         pI0g==
X-Gm-Message-State: AC+VfDzRR7Ollqs4L7OTzgyqDyp1ZxE9mDzuC/lAWb+I32Zre5OgUVFR
	1fOOzS9IUneGHvDr7wlBtNRlwJmwNLkfkU8Tt2sYX+jh69coFWg0QNY=
X-Google-Smtp-Source: ACHHUZ7/2ClJqKLjstXXWWZSgi7n6/GISE4aR+X1LeMT1hjC56D/Wgnzb/h3+yYqaoffZeKRU1ej1cW7DfEHVwrkG60=
X-Received: by 2002:a05:6808:34b:b0:394:39dc:a4b7 with SMTP id
 j11-20020a056808034b00b0039439dca4b7mr172774oie.59.1684365084218; Wed, 17 May
 2023 16:11:24 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 18 May 2023 08:10:47 +0900
Message-ID: <CAODzB9r3gM26gfJO_NB0xjbzjT6NCXMZgBCTM4g5wM=Y_uzQag@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 May 2023 23:11:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11510

Hi !

It's this week's CVE report.

This week reported 0 new CVEs and 8 updated CVEs.

* New CVEs

There is no new CVE this week.

Fixed status

* Updated CVEs

CVE-2023-2269: A possible deadlock in dm_get_inactive_table in dm-
ioctl.c leads to dos

stable 4.14, 4.19, 5.10, 5.4, 5.15, 6.1, 6.2, and 6.3 were fixed.

Fixed status
mainline: [3d32aaa7e66d5c1479a3c31d6c2c5d45dd0d3b89]
stable/4.14: [c9dfa8ba3b181e67970f06d80de18aa257d1ecda]
stable/4.19: [b4b94b25c78ed03be0e07fa4e76fe51e64dac533]
stable/5.10: [ea827627a9249154b34b646b1e1007013402afea]
stable/5.15: [e11765cea2050fa25fc3e03da858e83284c5ce79]
stable/5.4: [29a1ef57c3be1d53ecadb749d45b0636e8245a89]
stable/6.1: [9a94ebc74c3540aba5aa2c7b05032da4610a08c9]
stable/6.2: [243093d536fe3cc78b450f1beb8d584505ea3193]
stable/6.3: [a554e6ec3626d4c11f55d7eef8d6aa93fb211c24]

CVE-2023-2598: An OOB access bug was found in the io_uring subsystem

stable 6.3 was fixed.

Fixed status
mainline: [776617db78c6d208780e7c69d4d68d1fa82913de]
stable/6.3: [3a0a9211d7d0138d55aecd209b05e6d4a9eec383]

CVE-2023-32233: netfilter: nf_tables: deactivate anonymous set from
preparation phase

stable 4.19, 5.10, 5.4, 5.15, 6.1, 6.2, and 6.3 were fixed.

Fixed status
mainline: [c1592a89942e9678f7d9c8030efa777c0d57edab]
stable/4.19: [c6989314fd809c5eaf4980d6fa474f19fc653d6c]
stable/5.10: [e044a24447189419c3a7ccc5fa6da7516036dc55]
stable/5.15: [21c2a454486d5e9c1517ecca19266b3be3df73ca]
stable/5.4: [c8b6063f13add68f89540aa5030ceee875f48aa2]
stable/6.1: [4507918cd1f8b80f21a396fa0531d53e372bed66]
stable/6.2: [6b0801dcc1aa4373d28ac8ee396788d2e715c495]
stable/6.3: [f8486683ffa30456e0be4290282a44c4459a3287]

CVE-2023-28410: A potential security vulnerability in some Intel=C2=AE i915
Graphics drivers for linux may allow escalation of privilege

According to the SUSE bugzilla
(https://bugzilla.suse.com/show_bug.cgi?id=3DCVE-2023-28410), commit
661412e ("drm/i915/gem: add missing boundary check in vm_access") in
5.19-rc1 is fixing this CVE.
This bug was introduced by commit 9f909e2 ("drm/i915: Implement
vm_ops->access for gdb access into mmaps") in 5.8-rc1.

Linux 5.4, 4.19, 4.14, and 4.4 are not affected.

Fixed status
mainline: [661412e301e2ca86799aa4f400d1cf0bd38c57c6]
stable/5.10: [89ddcc81914ab58cc203acc844f27d55ada8ec0e]
stable/5.15: [312d3d4f49e12f97260bcf972c848c3562126a18]

CVE-2022-39189: KVM instruction emulation doesn't clear
KVM_VCPU_PREEMPTED, breaking guest's TLB flushing

stable 5.10 was fixed.

Fixed status
mainline: [6cd88243c7e03845a450795e134b488fc2afb736]
stable/5.10: [529f41f0eb1ef995bfa83c121c3cfe3a0720119a]
stable/5.15: [92343314d34e04da0923cefd3be67521d706fa35]

CVE-2023-1380: wifi: brcmfmac: slab-out-of-bounds read in brcmf_get_assoc_i=
es()

stable 4.14, 4.19, 5.10, and 5.4 were fixed.

Fixed status
mainline: [0da40e018fd034d87c9460123fa7f897b69fdee7]
stable/4.14: [ac5305e5d227b9af3aae25fa83380d3ff0225b73]
stable/4.19: [39f9bd880abac6068bedb24a4e16e7bd26bf92da]
stable/5.10: [549825602e3e6449927ca1ea1a08fd89868439df]
stable/5.15: [936a23293bbb3332bdf4cdb9c1496e80cb0bc2c8]
stable/5.4: [425eea395f1f5ae349fb55f7fe51d833a5324bfe]
stable/6.1: [e29661611e6e71027159a3140e818ef3b99f32dd]
stable/6.2: [228186629ea970cc78b7d7d5f593f2d32fddf9f6]
stable/6.3: [21bee3e649d87f78fe8aef6ae02edd3d6f310fd0]

CVE-2023-2002: bluetooth: Perform careful capability checks in hci_sock_ioc=
tl()

stable 4.14, 4.19, 5.10, and 5.4 were fixed.

Fixed status
mainline: [25c150ac103a4ebeed0319994c742a90634ddf18]
stable/4.14: [73ddc585228db650bd4ff10d5b59c831924fd9ba]
stable/4.19: [8d59548bae309000442c297bff3e54ab535f0ab7]
stable/5.10: [98cfbad52fc286c2a1a75e04bf47b98d6489db1f]
stable/5.15: [f1e6a14d5ae879d6ab6d90c58d2fde1b5716b389]
stable/5.4: [48cdcb40d589d990ccc1a99fb76843484ce732a0]
stable/6.1: [47e6893a5b0ad14c0b1c25983a1facb1cf667b6e]
stable/6.2: [727b3ea80f3fdda6c686806ce3579face0415c76]
stable/6.3: [dd30f9da333748488d96b7cb3c5a17bbaf86b32d]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26557: kernel: predictable Authvalue in Bluetooth Mesh
Provisioning Leads to MITM

No fix information.

CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26560: kernel: impersonation attack in Bluetooth Mesh Provisioning

No fix information.

Regards,
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
      :masami.ichikawa@miraclelinux.com


Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5219EC982CC
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 23:52:24 +0000 (UTC)
Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.28429.1789602739095305813
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Sep 2026 16:52:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=BqPX4VTp;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.171, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-85d440939f0so1224837b3.2
        for <cip-dev@lists.cip-project.org>; Wed, 16 Sep 2026 16:52:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789602738; cv=none;
        d=google.com; s=arc-20260327;
        b=blHX8hz25Hg3Tn0225vYbNjzNnGTYxN3ryIIXRce7TCesxN/7lKp5hvIRl+cJOowNx
         UetJLrPw8o9/C+uXJR9P7NIcspbEEnloJgZPf5iYTaE+MfP2QCF2CVc7qRbbQhHQVuYc
         37/H8nrn/TXysgelu8D+F0OkalmO6Qme9gVui7Ek3wMvofGgCVQQljzBfn8XfE4GyeHR
         ruUtKv0kKLyBmr7p1e8zj3zNWySWlehMweCNLZLrsKqqTbFgzVetrTa1SGHy0zQ0L1E7
         EOq37hZyTiFPNn45xkIMVhTXAiGUxyb5RW2PUkeE80N3kzgvcoHwR6kSsvBx22SezYW2
         d2vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=0uO/C2sWXcK04F6j+FLutVb4bN4cMRpotuMmDLVNV64=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=MSTYAHFTWTt4s5yQYuDZ3Zx2heKByvGFfQj2A9le+d0X5+bDlINX9zTz3w9BJCoE0C
         Fl8YoXn7oEPvQnecjjPbOCME309KnbN9pvdcW9QnmO3g+YdUQ2dlzRdL6ZaVMH8wy5ah
         XyvAwGaqSoY2k6SYprGPnpkqler2UGh4Oa9ksaa9uf/Hbv5VhtjYEhd2N3zWn3tBLR8U
         pBIuzL13ssk4JMposVOsvK/sHoFiSfQD8+UpRAL3fWRGYObGQgBdXt8MsV0jrxHrmpW7
         0uJphKIH7nBMm+b40lyyXIa9YD7U5TW1MP6AP4nTyNKzK/itPAXa6eV0NVsp5Dc6GZ6r
         LGzg==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1789602738; x=1790207538; darn=lists.cip-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0uO/C2sWXcK04F6j+FLutVb4bN4cMRpotuMmDLVNV64=;
        b=BqPX4VTpE0GK75D42NAOhnTX/Ndpg0z/lVrtiEo7bod3w5cHIBnyuL51Ww8QaJ0q9N
         SZe3El73UGK8tvSGc/Wy490ASJgMk1bLX/DJYwkVt8ef7uAMyI2b4+IxcExFzYKbcwF1
         WcSRAgjNB7S+93DvbLfdKJv9zMiXOl1BcF29gAylzWKZFqo+QXgYlaSBnwHb4rorVN7i
         4hw4hBEBYybq8TYA2xzgE4xI0DfXKh1Gkt0NU6Eyd8DSo+mgUFXwuVJHCoySS4voRZtX
         McDqNRu8HQmKnQ55gbL/CeaZqC2CU9l5oYUb/iKnydGgoyH/Sb1Q2tiaR8ZQ8beNJyYk
         tQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789602738; x=1790207538;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0uO/C2sWXcK04F6j+FLutVb4bN4cMRpotuMmDLVNV64=;
        b=nFNleAZjghAa/Apr+UcpqMQXwHGNAZgSoz8K/BkwDJGK+MbWB5BOY2FBC0hakUIuzJ
         3EBuVGRSv9QAOoSEfWO7G+ESkCuRLMYRldnaJka0GlBnD9WiUC5XEaNx2j6jpEKpuo0z
         MsKzNBzu1416vTTVAsDFmlqXodnbMOVxXNm1rePXnVICURV3VHV+FKonOsBQ6xA9nwGM
         nd2xpOj0U8/ehrjqGDLIjn3qzuByrV8GUtu/gRBFWJ1gpo25Kh6drzQIEhHRXjwKlxDj
         NqzTvEDvGUjrCJYwwMbfah5zHhT59wZeXhOmX17X+NJHdwWtFbV3VsNdqAE+fQ1ESeHI
         FVQw==
X-Gm-Message-State: AFuF++kYBAwx5HrgqYyI8CWGMzDq0JeJQYLqXblbIDmvmzGbQ/rM745H
	wS3F/5BtQrTDUnyvbAqd3ZHxUdUXHbMk+NG/VzhgqLq7flyU7j2Nwa4616qG2mKI4kE56H+MJN8
	jc3Bly5vMwJSDRxYyWxw7oP5Wo53ZCcSRnCqQ4hxxUxr877j5MmkaUN9lGg==
X-Gm-Gg: AYBFou0+5fnNbWO/qEEMYa5U0im/t+AqqfnNxSCY2AwO7Smw9mqIFgMrYbxnVAXbLmx
	laysZwc3+a/c+cN5KEg22GhFM0zvdHg66bFhG0Np+TVXz0jb9Lzhuj1c4poNdYX/nKBOcM1TjAP
	4lES+kd4XkUG+gKjtPyzCX4VnL4BsZdt9oPryB7A0mfaFyP3XO5S2wyvRES/GntnNj2fUsRfdV4
	yYHWySU/vrgy9FA+ZRWktKO4p2zuVp3InI6BbPLGFnX6DvuQF5U0eW+EzKqlDRDszHF3LesGWBx
	B5XESd4Y0Jqvmvzoy6SS4dE1o096KgrQQwplTtP1es9ZVV7bES4Ap4E9I9mvkWvgQdnf5wlbzmO
	VO0Qaoar6KDtusXHNb47bmC5DqAnNZ/6TaPQ/tw==
X-Received: by 2002:a05:690c:c019:b0:873:5bb2:6bff with SMTP id
 00721157ae682-892247aa482mr13771697b3.41.1789602730134; Wed, 16 Sep 2026
 16:52:10 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 17 Sep 2026 08:51:32 +0900
X-Gm-Features: AcwNN1WKLZU96GO99HwR4-SOwVMeu-921EZygAd5cFS1huuQdcykXjwVl9KRQd8
Message-ID: <CAODzB9rrjWk=+gS9HW3vOEaeycUT3e9+oiLHNr8O1QCg-4CQ5Q@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Sep 2026 23:52:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24194

Hi!

It's this week's CVE report.

This week reported 706 new CVEs and 71 updated CVEs.

* New CVEs
CVE-2026-80926: ksmbd: fix use-after-free in oplock break notification

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80926

Introduced by commit b003086 ("ksmbd: fix NULL-deref of opinfo->conn
in oplock/lease break notifiers") in v7.1-rc7.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [0e753899627b5e28a9fea8bca98262a6f65a2452]
stable/6.18: [c8279ae8df68cce9cd3b785e85f7a86c80a46e78]
stable/7.2: [8cc98db4fc590e6c7d9db6529320982ee16c5d1d]

CVE-2026-80927: timekeeping: Check the return value of tk_get_aux_ts64
in __do_adjtimex()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80927

Introduced by commit 4eca49d ("timekeeping: Prepare do_adtimex() for
auxiliary clocks") in v6.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b61084b11bcecce86d03804ff30f8d7b465593c]
stable/6.18: [fecf1e37775269ad38c172b468ad4ecc3968aa63]
stable/7.2: [bc59dac50cb45a725f7a50760c7cc72a0964f722]

CVE-2026-80928: smack: fix cred UAF in smack_file_send_sigiotask()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80928

According to the .vulnerable file, this bug was introduced by commit
3b11a1d in v2.6.29-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fedc88e38ce979a720cd2de042578cb5df3dc8de]
stable/5.15: [a512366d84e134a9eefc2cc40eeb6e80e2ec162c]
stable/6.1: [7c7fe043f3099d0d35002b248967f75e55345b93]
stable/6.12: [b5bcf3adfa27279da4401ab8f1e1a706601a92be]
stable/6.18: [ed64aa505875a3b4defd504ee8e59e1949246a62]
stable/6.6: [f9c7b1f2b9d8f4176d2632743f51400855978ace]
stable/7.2: [b791401bf389a1546a830d2b381ca60fe94c7870]

CVE-2026-80929: sysctl: move the "cad_pid" entry from pid_table[] to
kern_reboot_table[]

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80929

Introduced by commit e054bcb ("sysctl: move cad_pid into
kernel/pid.c") in v6.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7170ca01623b399c97f2ae9d3e228badc1f25ea3]
stable/6.18: [e8527de7fea191fda704792a56081f9009aeec37]
stable/7.2: [a09bc4eaa67e1a72df3b6d0beb3afeef1e1fdfcd]

CVE-2026-80930: tpm: tpm_i2c_nuvoton: disable IRQ on wait timeout

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80930

Introduced by commit 4c336e4 ("tpm: Add support for the Nuvoton
NPCT501 I2C TPM") in v3.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [705c4ed0643366963547b2616d53165f2519c81f]
stable/5.10: [007c9e637e0e0b9d946b7f0e8a42f1f1aca48d7a]
stable/5.15: [2c9147b2c0d75091ab451c2461d1c91788a7e60b]
stable/6.1: [07c2544a47da481043e945322b1bef71cdd7af79]
stable/6.12: [73e89faee1f9b9119fa70b679058b045168ae633]
stable/6.18: [cde2d927c29e82380851f209222256c607969a1f]
stable/6.6: [b0dc3f18af01ba9f157b7d810cb22d3752d244ef]
stable/7.2: [aee2296d09f6aeff41db369c6fd2dcaea3ee302c]

CVE-2026-80931: w1: ds28e17: reject an oversize length on an I2C block read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80931

Introduced by commit ebc4768 ("add w1_ds28e17 driver for the DS28E17
Onewire to I2C master bridge") in v4.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [169ae5e65e5aaf213b6a578f6478a9fd2e523606]
stable/5.10: [b30c021c6073559ea6851b522d8a17a524a27b4a]
stable/5.15: [1d08877fc37e90945df38d255715bd1d6c052d46]
stable/6.1: [bf76d61e118b7044600a65775a3bf8adc2c6823d]
stable/6.12: [cb55c5da9828f77db2a2701316949d4de1e9b773]
stable/6.18: [ae0c79a8527044e54d81fd5a3b49ce6177633758]
stable/6.6: [0f6496b34cc2919420f303b2aabdd9f71e084b56]
stable/7.2: [6df05f630c84a109736642362e452089886f9974]

CVE-2026-80932: vsock/virtio: flush works in dependency order

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80932

Introduced by commit 0ea9e1d ("VSOCK: Introduce virtio_transport.ko")
in v4.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [728836ebca239810f164262b10211ef59182f811]
stable/5.10: [e059a14c1067bcc4f7b1947cd09f2baab98e340f]
stable/5.15: [531e2ac2dab1ab90a16427c4f9c86663633e9487]
stable/6.1: [f3313d952fc380cff53db9a28451a8807aa67b43]
stable/6.12: [2187a56f2fd1715d54daed6392809223c60544f3]
stable/6.18: [165a330a68b5f299d8735f0194c314cb2e571269]
stable/6.6: [b9cb4e8ba71c9fbd935d66baa71bbb0b87192c94]
stable/7.2: [da5e9f08714c19ba04e6863aca69d40f042f2e04]

CVE-2026-80933: wifi: mt76: mt7996: validate default EEPROM firmware size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80933

Introduced by commit 98686cd ("wifi: mt76: mt7996: add driver for
MediaTek Wi-Fi 7 (802.11be) devices") in v6.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [653c6e289b13cc6942f3e8f8e3c568e70fa42d1f]
stable/6.12: [127a291f4c8069a4e71906938402cacfe24ee8cd]
stable/6.18: [03b81f015dbb29807ce1ec6d45537d658abdac69]
stable/6.6: [b4bf67cc0871b13103c404b38e332b9d4403a0da]
stable/7.2: [7074ec3769820302f1ccf8794a40a6582153b820]

CVE-2026-80934: wifi: mt76: mt7996: fix TX DMA mapping leak for AddBA req frames

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80934

Introduced by commit cb6ebbd ("wifi: mt76: mt7996: support writing MAC
TXD for AddBA Request") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [deaa2e3656937fbbe312f0ee2616c756c6e2511f]
stable/6.18: [01f2e0da8548f82d704b65b513026cfedc5f8962]
stable/7.2: [b754d3a6d44c53d9853eba374d8a7ef279a9d00a]

CVE-2026-80936: wifi: mt76: mt7925: cancel mlo_pm_work on stop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80936

Introduced by commit 276a568 ("wifi: mt76: mt7925: update the
power-saving flow") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [81faf578320df2dfc682a96baa6e85851dd68b6f]
stable/6.18: [304470333b7f525b23699ea7a7aed3b40ca37ca9]
stable/7.2: [9e20da749ad229a1aa649ece528721b9652f15e1]

CVE-2026-80937: wifi: mt76: mt7915: bound the device EEPROM address
before the EFUSE copy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80937

Introduced by commit e57b790 ("mt76: add mac80211 driver for MT7915
PCIe-based chipsets") in v5.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [44b5adfe49499f53002737f5fe81d608c08122fc]
stable/6.18: [5fdaf7016d7684ef756a229fd5d96b4a140eeb40]
stable/7.2: [5f48b0d752a76590e2c613aae5345c2474627d1b]

CVE-2026-80938: wifi: mt76: mt7615: avoid waiting for mac work under
the mt76 mutex

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80938

Introduced by commit c6bf201 ("mt76: mt7615: add WoW support") in v5.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bda8324270b1ac91bfba1df8928e0570e29759e8]
stable/5.15: [36c73b86a09f0e51c0f81a75c8945b6c5557ff27]
stable/6.1: [33d29aeb4c0eede92622a7d04ea492b94c30f089]
stable/6.12: [3114d479f2a1d31b2e6214c395794c6e5715e579]
stable/6.18: [4506e229b2e468b8c64bcf52c50c41a3bf2e633e]
stable/6.6: [ef2ec8b537c3a54e241d693bd03016f80d0d4484]
stable/7.2: [44be85af3e1772ffb3332feafedad2a73b22854c]

CVE-2026-80939: wifi: rtw89: pci: add .shutdown callback to stop
rfkill polling on reboot

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80939

Introduced by commit 0b38e62 ("wifi: rtw89: add support for hardware
rfkill") in v6.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [667c12782aaf8dd3cb2213e528fe63a73cb63345]
stable/6.18: [9693980cd7d2f5b17e5ef5922b922f2e1a770fca]
stable/7.2: [c1f214dd1351244156deb57761b14190a233aef6]

CVE-2026-80940: wifi: rtw88: pci: fix resource leak on failed NAPI setup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80940

Introduced by commit d0bcb10 ("wifi: rtw88: Un-embed dummy device") in
v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e779df4806cd29cbcca5c9dc0a1073662c76b889]
stable/6.12: [481fff9bda01720c70b19fb260808145a3f21594]
stable/6.18: [34a505071d1ffc5ebf3dc3cd16d2a12b044bcc84]
stable/7.2: [b1596e212ab1739930b25b9d3daf6b5cd307b537]

CVE-2026-80941: wifi: rtw88: Fix potential memory leak in rtw_txq_push_skb()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80941

Introduced by commit aaab5d0 ("rtw88: kick off TX packets once for
higher efficiency") in v5.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f2948010764d708bda27369d09ce6f194abe8e3]
stable/5.10: [e8fd57157ee7a9e2986a9218198a5c1b02f2310b]
stable/5.15: [924e75a420a3000e9f189aed26f67556a62f2d57]
stable/6.1: [68676ce3313b74326fbcf21c673728db4c19d3cf]
stable/6.12: [6e95852f904edbabf411793093fcfd6f6d49ef27]
stable/6.18: [7364713f0931ee45fdf0bea27103b40ccc94979a]
stable/6.6: [c86199357a93b9182854cf805d7780a213fda937]
stable/7.2: [51d8b35574721cf3fe744f46ebd9629916063fee]

CVE-2026-80942: wifi: rtlwifi: rtl8192du: Fix possible memory leak in
rtl92du_init_sw_vars()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80942

Introduced by commit b5dc887 ("wifi: rtlwifi: Add rtl8192du/sw.c") in v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6496ce90845df2d22fb8e8ed235cd2936fad41c8]
stable/6.12: [3a5b23e7dbeb00c93ec3b8add97f5de9bb9cbb5c]
stable/6.18: [dc8b0be0ec4d9b0c80f07b27e656e4a94de5a344]
stable/7.2: [7159e1e12468a0b1ac519b296280c0a27f91eab5]

CVE-2026-80943: wifi: rtlwifi: rtl8192du: check QoS TID before indexing tids

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80943

Introduced by commit 8321424 ("wifi: rtlwifi: Add
rtl8192du/trx.{c,h}") in v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ed4f05d9f2f42fd866f55108db8123eefcc5fb33]
stable/6.12: [6e327f14e1c43e175bf530f9165b2cadff308553]
stable/6.18: [0c0b374e12d52af23ca741728db31091677cf9dc]
stable/7.2: [42785f7e8d31540e6172bbcf08a7cc3cae1086f8]

CVE-2026-80944: wifi: mwifiex: Detach sync cmd buffer on interrupted wait

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80944

Introduced by commit 3d026d0 ("mwifiex: cancel pending commands for
signal") in v3.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef06882c7d8a7400b67d0d003b1008093dd589ed]
stable/5.10: [8c67b8c50286e0cb7f18d667e6a37a2ec6e08ff9]
stable/5.15: [9024c7729eb523cf4f3a4203966d3a4aaabf030d]
stable/6.1: [9e06c9c8a1f10c55d9bc5d139656d58795e64483]
stable/6.12: [20ee9c03f261bf6ac59331e2ca7b46b23646412a]
stable/6.18: [b1bbeb8970eeb6c6bf3cd5314138103f7b69446d]
stable/6.6: [f2134d6ff30cd6e1bf63d6b0a5d8e0839f0168b3]
stable/7.2: [d29a165588b6a0cf7a38db5cbd602aef7ef8c658]

CVE-2026-80945: crypto: iaa - unmap dst before software fallback on decompress

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80945

Introduced by commit 2ec6761 ("crypto: iaa - Add support for
deflate-iaa compression algorithm") in v6.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [94a25930477113730372e0fa2985da4c5ac95c9a]
stable/6.18: [fc933a4a419ba8a75da28666a018602c44846953]
stable/7.2: [fcd86180ef78b0e41763faef7c6d2de7dfb50c1a]

CVE-2026-80946: fuse: copy request headers via a stack buffer for io-uring

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80946

Introduced by commit c090c8a ("fuse: Add io-uring sqe commit and fetch
support") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd10f40af314f07b6d6e028b1ca25c8b49903aab]
stable/6.18: [194d0fb0ea4720535ff3168c9d04c7632cec7071]
stable/7.2: [a47a416ff68d706dc3327ab583f86b9ee757358b]

CVE-2026-80947: wifi: rtl8xxxu: fix use-after-free from rx_urb_wq on stop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80947

Introduced by commit 26f1fad ("New driver: rtl8xxxu (mac80211)") in v4.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6c080026ecc17eecb103f8927c64ea73a74bb818]
stable/6.12: [800d2b490a9af1e7132a3564c2ad5a81292e5b40]
stable/6.18: [620acb1e8037b73a457dc8ef20fc23fc7adcb405]
stable/7.2: [972ab8b9c08f3eb3fa535082de2950dd93604dfd]

CVE-2026-80948: wifi: iwlwifi: dvm: fix memory leak in iwl_op_mode_dvm_start()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80948

According to the .vulnerable file, this bug was introduced by commit
26a7ca9 in v3.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [67105abd6195a685a84dcb8a5daf54a1f4bfdb60]
stable/6.18: [84ba017a1e1ea7896ed1e3258c947bdbfc5299c5]
stable/7.2: [ad2a9fdca4a7100472be82ee6048c616fc589720]

CVE-2026-80949: wifi: brcmfmac: Fix memory leak in brcmf_sdio_read_control()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80949

Introduced by commit dd43a01 ("brcmfmac: use dynamically allocated
control frame buffer") in v3.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0d10db8e94fcb23a799789aaa696b4d8f937e207]
stable/5.10: [b1d0a90a844abccdfed9fe141b5d0d654a821485]
stable/5.15: [86b57fa3172e287bc083113507a965e6d9a46a45]
stable/6.1: [a732c4f36a4cd79f3702391f88ebb56f2e43b0ee]
stable/6.12: [fdb880a7d575efe8b5c7b5b819b96d9251a3937f]
stable/6.18: [261d7c7610b4b2f476382c88a2d1ae0cc5e07add]
stable/6.6: [7704f6ba2a8c492b07a3eaa1e311b4b30d389246]
stable/7.2: [ba04715ee672c336272be3ceb43bda9ffc33eb75]

CVE-2026-80950: i3c: renesas: Check that the transfer is valid before
accessing it

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80950

Introduced by commit d028219 ("i3c: master: Add basic driver for the
Renesas I3C controller") in v6.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12

Fixed status
mainline: [5f1a76ecfe90544a28d657306c9b3caa66ba0e63]
stable/6.18: [0093f9fc102ba8b98561fdd2f8559553ef56be59]
stable/7.2: [ec631aff93261c6d031f953549802322032f2aba]

CVE-2026-80951: i3c: master: svc: bound IBI payload to the requested
max_payload_len

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80951

Introduced by commit dd3c528 ("i3c: master: svc: Add Silvaco I3C
master driver") in v5.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e2bda39d7f9f285ec803e200b5c1f17143d0b483]
stable/5.15: [7c099b0b292a68d0ef558527945dbfb756fbf893]
stable/6.1: [7cc5ba756bc1cfffab9cb2695742f9f479dc73f7]
stable/6.12: [f296a0d5907bf88314dfda67245f7f69d1552470]
stable/6.18: [5697d779577e2786ff3348ae9b77020ac0cf0aab]
stable/6.6: [35aa6730b8c5626b879a4e893fe664f59bf07d7f]
stable/7.2: [aac3c5aababc7fb69d5bf5b0cc52d308574e3a8c]

CVE-2026-80952: i3c: master: Fix info leak and UAF in device unregister path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80952

Introduced by commit 3a379bb ("i3c: Add core I3C infrastructure") in v5.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2c743efd2d1ee64e94324664808f623dd865872]
stable/5.10: [334cfb5e285cece5dc49fb3fb8ea9b70b2cb5d7e]
stable/5.15: [109995153898454c7795c2c299fd0a0b57456a4b]
stable/6.1: [c64daaaba08e490c8347ff60aacac4dd51249f91]
stable/6.12: [c16b6f25e0cc2dd1055dde1256cbf5a9e888cf49]
stable/6.18: [94fb9786d67a8f8b899e77381620f86bad94fdf7]
stable/6.6: [ef72ff6650c4ebf2b444708d84df66db42f262d9]
stable/7.2: [4837be0f9ac2efe5e83b35a696b6242c473d280c]

CVE-2026-80953: i3c: master: adi: initialize the lock before enabling interrupts

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80953

Introduced by commit a79ac2c ("i3c: master: Add driver for Analog
Devices I3C Controller IP") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a53f9102a0d3eeb8784999f925028acf339c276]
stable/6.18: [a15a1b95de980362c14f32f519b293b0d12ce86f]
stable/7.2: [de8c32b0a246bbb4b44ec29e12769496a0bf66f7]

CVE-2026-80954: i3c: Fix unlocked dereference of dev->desc in
i3c_device_get_supported_xfer_mode()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80954

Introduced by commit 256a217 ("i3c: Add HDR API support") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8bed7f4fa710914b7f05fd59998316bfb4d43385]
stable/7.2: [251db58324ea4792c3f9f692ab09be148e051969]

CVE-2026-80955: dm-pcache: fix use-after-free and invalid seg
operations in kset_replay()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80955

Introduced by commit 1d57628 ("dm-pcache: add persistent cache target
in device-mapper") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c2e894eac398b258f12fdec73ed6ba081047f7b3]
stable/6.18: [1894fc7a3bab90143dcd26ef8ee27040ef4a7501]
stable/7.2: [f39a3e9cc5946473e16d6f5071b2ee0216c56d06]

CVE-2026-80956: dm-pcache: only hand out initialized cache segments

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80956

Introduced by commit 1d57628 ("dm-pcache: add persistent cache target
in device-mapper") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2df0fc042e299bae3c0f60ea5cd2af9285658e9f]
stable/6.18: [83e3116283ed2c6a6a1fa662862a4b4d7d2701a2]
stable/7.2: [692037ae1a7cfacc2f0c22c6e034c1dfee0e553f]

CVE-2026-80957: dm-pcache: detect a cycle in the last-kset chain during replay

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80957

Introduced by commit 1d57628 ("dm-pcache: add persistent cache target
in device-mapper") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [16c3b3a326e70f246a605b3dc27b7f83ba4743e3]
stable/6.18: [663ee2f3824a505b983162de44134e789f8230da]
stable/7.2: [5311dfc5cd70edccd110257e3f30b2c1dcd3768d]

CVE-2026-80958: dm-pcache: clamp the tail kset read to the segment data region

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80958

Introduced by commit 1d57628 ("dm-pcache: add persistent cache target
in device-mapper") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [becf07e2b0053027495ecd671b1f82fb2e615f68]
stable/6.18: [2cd9776fe3f2d88ec22c36d3c8ba09fbf9d5500c]
stable/7.2: [1ab55354368d071ebaee4d8c82313955eab65a04]

CVE-2026-80959: dm-pcache: bound the persisted tail-position offset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80959

Introduced by commit 1d57628 ("dm-pcache: add persistent cache target
in device-mapper") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1898576090a10d2ac2715218a652e78fb65a6b0]
stable/6.18: [ffd9a214a94f9928e54856f42b1cc3e33fb10e36]
stable/7.2: [8bf7a06ca3c1611809725f58cfd573f2ffbda75f]

CVE-2026-80960: dm-pcache: validate on-media seg_num against the cache
device size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80960

Introduced by commit 1d57628 ("dm-pcache: add persistent cache target
in device-mapper") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [62d92e45abe9e087370f9fc5d876b95673aced34]
stable/6.18: [91b93fe5cf4d62d5ecc642a6c8f15a3c11b00e3c]
stable/7.2: [e889c0ee81165fc90aad2979b51f930f77895703]

CVE-2026-80961: dm-pcache: validate kset key_num and intra-segment bounds

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80961

Introduced by commit 1d57628 ("dm-pcache: add persistent cache target
in device-mapper") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f11deb032fd84081e7831cffcba895d893054a22]
stable/6.18: [d8caf96040a06096276ab72f5e1e8547c014c564]
stable/7.2: [5ac38f4b4862fad6e7270fde5c3356a822ce74ca]

CVE-2026-80962: dm-pcache: validate geometry fields from on-disk cache_info

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80962

Introduced by commit 1d57628 ("dm-pcache: add persistent cache target
in device-mapper") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [32d1809da31094ef76fd98dc1f1a8b55ca1295dd]
stable/6.18: [ab5dcde6fa96bc115b85f3621c60e39c66229a90]
stable/7.2: [3e19172089ec81132a8a48e802b1034a744209f4]

CVE-2026-80963: dm-stats: fix a crash if allocation of per-cpu data fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80963

Introduced by commit fd2ed4d ("dm: add statistics support") in v3.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cc87e26d9cce22061dc21e51e11afef29dbbc36a]
stable/5.10: [e45f0b0c41139810ff395ba2f3cfca1460a5b8a6]
stable/5.15: [9805d87d0e26c68ee69da3928e665214d2e2851a]
stable/6.1: [564d17573ef643c13cf6e9015124a205fa65e704]
stable/6.12: [c3f211b7a277dd404b4e7d23095be964b5b46a27]
stable/6.18: [74210fa072960a18bb0eead487585452af722e4f]
stable/6.6: [389a50d094e13724f5f45e6d9d6ef734c98ba291]
stable/7.2: [0c8f7870ed3ebd512f090d7714cc2c556b9e5c75]

CVE-2026-80964: ALSA: virmidi: Check card index validity at probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80964

According to the .vulnerable file, this bug was introduced by commit
3564fbb in v2.6.20.16.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b65d5182ecd6b7a24a83d980a0d06e809ef876c5]
stable/5.15: [3ee9cea821730805f232f1e4db0f95e7420477fc]
stable/6.1: [ffefee7daf2362f534097422bb7f8894e798adfd]
stable/6.12: [43f161c53279adac0517cf1c443e531e738b54ce]
stable/6.18: [40ee4224e2fe24c05b92e4d37476adb6e83f10e9]
stable/6.6: [368c521503e38e9bcfcf04c053eb1f85d22391b2]
stable/7.2: [f48c5f3b03afdb795e5f448a1d53d912d5b09f2e]

CVE-2026-80965: ALSA: serial-u16550: Check card index validity at probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80965

According to the .vulnerable file, this bug was introduced by commit
9caf6b5 in v2.6.20.16.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0fb960b227fcdebe22e4f26c9486d60943c0424]
stable/5.10: [41a952304cc8a308748e3f58462c879f2a9c4340]
stable/5.15: [cc0f757d017f4271f137c77e130314bb23792347]
stable/6.1: [1cb30691dc893aafcbc1e211e94764014c0f5d12]
stable/6.12: [fbf3fb097e66fc1874e54ecc46d600d9325480d6]
stable/6.18: [7555e83d7738e65dc83921e3c85bbdc081f08f2f]
stable/6.6: [487ede9b648fc0eb15866f408c41aac2c57f85d5]
stable/7.2: [6d6fdb24fe2eaf6174fc502284c6e1dc5f7242ba]

CVE-2026-80966: ALSA: portman2x4: Check card index validity at probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80966

According to the .vulnerable file, this bug was introduced by commit
757e119 in v2.6.21-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3690ef20469d5959378260e2752f2314a2572913]
stable/5.10: [45ea0707298798678a60ff861b695aea049a5469]
stable/5.15: [5d7ac5e9ee5ba76b567ace13b46075caf79dcca0]
stable/6.1: [0048994854f3e9c57b7a754de43ef8da5818d140]
stable/6.12: [0ce391090809d610647f424b9b1dc24aa2c546fd]
stable/6.18: [d7ef7890e3e35b4ba09e76fc6b72047a1599a5e8]
stable/6.6: [64898e9bd8b7b229efa8642b85b56b326a6ec3dc]
stable/7.2: [e1ce8ad1009b1736b3044b3324350dcfdd516f42]

CVE-2026-80967: ALSA: pcxhr: initialize mutexes before requesting threaded IRQ

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80967

Introduced by commit 9bef72b ("ALSA: pcxhr: Use nonatomic PCM ops") in
v3.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6c97817e20598e5473094e0e38d1f51f1cf4dfff]
stable/5.15: [039602d6ddb1febbb0561b30dab04461f78a1319]
stable/6.1: [a5f405adb0229c9cf64eb3d695c333c92e3d3d4f]
stable/6.12: [c069b3cfd753d6688ea0271c43553631ab38ce10]
stable/6.18: [7ef9ad82d95dd3c74570d80a689a0570fbc7539e]
stable/6.6: [ede25b7fea0d7487ee8528bf35dc7b9a1cbcd814]
stable/7.2: [7cf280fbef5db6310e1b32074c8c34d1ba459796]

CVE-2026-80968: ALSA: mts64: Check card index validity at probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80968

According to the .vulnerable file, this bug was introduced by commit
68ab801 in v2.6.20.16.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d18a260720f86a5f8b5fcfefc4ba2e9dd01c10f8]
stable/5.10: [1566ca99fc0e892b9164ad893d268b00064fff54]
stable/5.15: [5d986d8c9e616636032636d99133f2535f94300d]
stable/6.1: [5168a6241e953ecadb0ec05609649f6a7367fef8]
stable/6.12: [036e7aa793375ab16ea0f64b8de6673220416cc1]
stable/6.18: [a4e774eeb61aec64da5b03d3becffde26f7fe4de]
stable/6.6: [9cd7c59a106e7267d0cbcf68670594584d8689d0]
stable/7.2: [cf3af453a48c8d905512dfc44a5a59439b70f4f0]

CVE-2026-80969: ALSA: mpu401: Check card index validity at probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80969

According to the .vulnerable file, this bug was introduced by commit
b3fe951 in v2.6.20.16.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7dcecb92ed192ff5fcf842918fb1aaea84b5bdd]
stable/5.10: [4a3d6c22ca6b6c16e8055fb518aa87f5e043f754]
stable/5.15: [d606c703d1e0c54996cb3db76a753157cb2a3c06]
stable/6.1: [3a997371ac2957f11a033a4cec2930042dadb7e3]
stable/6.12: [76b6bc38d0f310c0ae1b2a2ebabe2947d92c601a]
stable/6.18: [cc4215cc2a4b2a9cf8b1952bbe8d5bf925acb3ea]
stable/6.6: [26a25fb4ef4ba2a33069d489feb75a4c36899cca]
stable/7.2: [8adda66edf795d4648f8e26f312e4414c535d25a]

CVE-2026-80970: ALSA: FCP: do not copy out an uninitialised init response

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80970

Introduced by commit 46757a3 ("ALSA: FCP: Add Focusrite Control
Protocol driver") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4335e387786479889e6db691fe06d345e52ea536]
stable/6.18: [e9e52437120fb5f802152877ba20c4b406c9fa9e]
stable/7.2: [29ab2df278ab4f1d238cd9c1c393ee00db175cba]

CVE-2026-80971: ALSA: bcd2000: clear the URB pointers on disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80971

Introduced by commit b47a222 ("ALSA: MIDI driver for Behringer BCD2000
USB device") in v3.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [459d3a64766f5ca2f1886daeaf24582831a5f5ab]
stable/5.10: [9af08677aa57debaca5b57c8045c52a83d3dd376]
stable/5.15: [5a77febac6faf6da40fbb4555f703eeb91b58130]
stable/6.1: [3c00004f134fc819f9d9e202c6a64acde0a1f8d0]
stable/6.12: [eb482a06791d6168beb8c78cc904ac5a5ed96a55]
stable/6.18: [7df3194bdb7479cad9199889655a566a2c0c1d1b]
stable/6.6: [6c07aad8a7c9ef8ebc4d03a964b882123a349a2e]
stable/7.2: [b06ebc7fe25a6af4a9f6e4a3d4236a4178ad4b01]

CVE-2026-80972: ALSA: aloop: Check card index validity at probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80972

According to the .vulnerable file, this bug was introduced by commit
597603d in v2.6.37-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [819b106a9fd2ef3fd8abf898b9a8e4524eca8f48]
stable/5.15: [6da6ffb34a5d54e7e6efebb253899c6a3501a611]
stable/6.1: [e35d11102ef0945feaa1dba4e511685911695ab9]
stable/6.12: [c589aeaadfde1cfedb5c6f0a3c782807282126d9]
stable/6.18: [7b3f9855849363e402bf2141df2b428581cbf31b]
stable/6.6: [6fe7d13608a9d1cf5aff9decc0cc653b0f38f537]
stable/7.2: [efbc2e9e43a1b5c6d75ae47439c06896bb142ae6]

CVE-2026-80973: ALSA: 6fire: bound the MIDI event length from the device

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80973

Introduced by commit c6d43ba ("ALSA: usb/6fire - Driver for TerraTec
DMX 6Fire USB") in v2.6.39-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a478893b59e36cfe7d77a76b352f2db55502e879]
stable/5.10: [c9204bc2ed2010e2469dbe5fce598878a37efd04]
stable/5.15: [2c590d5e1b1595d5c8fa0b72d2897423ce9985ca]
stable/6.1: [0c8a3c773823cf12abd39c480aed70e25c384630]
stable/6.12: [466e911bbbbb779bb06337e35a286e5ca7af16b3]
stable/6.18: [2a6f6fba3bd31d2e8c957fefa29156e35e5e75d5]
stable/6.6: [00e84a9ff2d43953ae261995cae94d46f4c307a6]
stable/7.2: [34816e2cfeabafb8eccf54687186ce25699e8363]

CVE-2026-80974: mfd: sm501: Fix potential memory leaks during remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80974

Introduced by commit b6d6454 ("[PATCH] mfd: SM501 core driver") in v2.6.21-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83feedd9d83c0c5199f98c72df0a6196b4aefb4d]
stable/6.12: [fcc6c3b11d73459e0d55b27c98cc56d59fef4d82]
stable/6.18: [94ca4f040ba489db2d4b66e9d1ee91b4f9a00534]
stable/7.2: [c8be3a076a59ec793fb2e4bdb830a709aaea9cce]

CVE-2026-80975: mfd: qnap-mcu: keep the reply buffer alive past a
command timeout

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80975

Introduced by commit 998f70d ("mfd: Add base driver for qnap-mcu
devices") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47504742cea7878ebd1bf1491bbed923df6b90b1]
stable/6.18: [0b6680e306397097a97767447368221fac753809]
stable/7.2: [8391ee06d08845a0a165b5fe679ba326915166b2]

CVE-2026-80976: seg6: reset IP6CB after IPv6 decapsulation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80976

Introduced by commit d7a669d ("ipv6: sr: add helper functions for
seg6local") in v4.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f967455fb2a5a2079b9eb5823e9ccf359174bf9f]
stable/5.10: [d1f0d353358987ca87f21d8956e2d2854951130d]
stable/5.15: [a0e2b0a3718f0cf9fb0ee41710b4a6348a7315c8]
stable/6.1: [9ae92198c24d7dacd4070e2f34f6e1ed3a63061c]
stable/6.12: [2b154e96fcb3f01fd42765c64e0a56820fbc16eb]
stable/6.18: [cfa186a0857a0f831dfca67b16bbc40ecfdf3280]
stable/6.6: [96c74420ac92930a7e0f21770818544eee4a93d7]
stable/7.2: [c73fb911e02b9a766c950bc9707f3e3a96ffd702]

CVE-2026-80977: net: skbuff: don't touch shared zerocopy state in skb_tx_error()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80977

Introduced by commit 2512117 ("skb: api to report errors for zero copy
skbs") in v3.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f66bdb1cc0fcd227a062378f8be0b5873aa5600a]
stable/5.10: [6493165034bca14033bf49c9cec7b45e97a91497]
stable/5.15: [b4452349dcf4d561e13be768d5d278de58248930]
stable/6.1: [363c4252ffc473a0203e91b83ede5519dfb8bd07]
stable/6.12: [15aa81b390d401abf4b8211042470e9e92e3b7fb]
stable/6.18: [288f9970670841044ab030104fa6b6ed159949d0]
stable/6.6: [6ec22afc82a3cae07ade0a6ec361ae2532128ff5]
stable/7.2: [0370da114a9bc044e248b85c6809d1b5e0c1f7f9]

CVE-2026-80978: net: cap advertised IP tunnel headroom

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80978

Introduced by commit 1a37e41 ("net: Use 16bits for *_headers fields of
struct skbuff") in v3.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6b222adeb9340306e2ff97127c76117abb9b3df8]
stable/5.10: [fb889a619723032140f5d983a3a34d25a5a2bed4]
stable/5.15: [b160422f8103574425e2834130e169d84c94fa1d]
stable/6.1: [d36e75f5669140b66515ad3a176ca6337bd80a5e]
stable/6.12: [bc4e05ae66c9797a0972ac44326e69c5305e0020]
stable/6.18: [af0ee8f04bea22cdb331fa3509e17f81b48938ad]
stable/6.6: [84783961cb8bdb36b4f41a02ce43aafc6d52b176]
stable/7.2: [9144f2c53a04465a6878172b523f640313c5559e]

CVE-2026-80979: net/smc: unregister the connection before draining the
rx tasklet

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80979

Introduced by commit ae2be35 ("net/smc: {at|de}tach sndbuf to peer DMB
if supported") in v6.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [36cdf5d48ca191dcd71c28cadbe0981b1d25318d]
stable/6.12: [b4d540ac95cd35c6ebab6afb7eae2bcac7b277a5]
stable/6.18: [5bd8b764a610b6b6bc0c4d3d01652747f6e0b5c3]
stable/6.6: [b6b6ac713ee82b340a8e3be30b101bd2840deec4]
stable/7.2: [b74d313567dfc1b7e56629ddbad04e728686f235]

CVE-2026-80980: net/smc: stop killed, freed and out_of_sync sharing a byte

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80980

Introduced by commit b286a06 ("net/smc: handle incoming CDC validation
message") in v5.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [db51a8658c11a82432b64999519a269c3aabb447]
stable/6.18: [313f79149eb337411c64e2c247234b62ef9a3cb9]
stable/7.2: [2cb7a8d64b7e8ccdc69bbe48fe9c4eaa79c33aec]

CVE-2026-80981: net/smc: fix use-after-free of the LLC qentry in
smc_llc_srv_add_link()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80981

Introduced by commit 27ef6a9 ("net/smc: support SMC-R V2 for rdma
devices with max_recv_sge equals to 1") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a42a459ef0e54cb0c4b3e43e21cb0e658e664f64]
stable/6.18: [c52a998a223e7e84333306996edec096178d1e95]
stable/7.2: [adef84cc85d449ac28d2b4b4c49cf19619c56e27]

CVE-2026-80982: net/smc: fix use-after-free in smc_rx_pipe_buf_release()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80982

Introduced by commit 9014db2 ("smc: add support for splice()") in v4.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c924884743e948e25625b7fbf3ee2a9325a204a7]
stable/6.1: [dadd97c8296b23aa816e91ed70041820ae087baa]
stable/6.12: [6a644a7340df978785f3109d1e0726a982ce2c6f]
stable/6.18: [0761e49aa78c2f1362511054c6e9670653858837]
stable/6.6: [df441f3efbb50eb0f120b8de4bf441c31fb0551d]
stable/7.2: [0926f59ca0f94120895b92180c636a48d0ed3a6d]

CVE-2026-80983: net/smc: fix socket refcount leak in smc_switch_conns()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80983

Introduced by commit 95f7f3e ("net/smc: improved fix wait on already
cleared link") in v5.15-rc6.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [719296c4aa8213d4ac8002e77d5956d436bc98d0]
stable/5.15: [a3378466704e0bbe93aef9769552dca7673a7eb6]
stable/6.1: [e20227019d9da73f8fdf16f0951c2e188c84933f]
stable/6.12: [84dea0585f6b538ae895a8b1d025f4897737f3b1]
stable/6.18: [d89dc1bd8845c669a700eee58c64ebd3cc1b6d2d]
stable/6.6: [09d7a9e162ee1a269878c126aee3d7eff43e4130]
stable/7.2: [d9a879ac25958bdaecb669ce70e58f8e2ff170de]

CVE-2026-80984: net/smc: do not dereference an unset send buffer on
the SMC-D teardown path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80984

Introduced by commit ae2be35 ("net/smc: {at|de}tach sndbuf to peer DMB
if supported") in v6.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [b395dd319cea422239cb45b998fb38d7e373af87]
stable/6.12: [e3fcff8d22a6c9540748846cd800443a643553a6]
stable/6.18: [f950e1b1f0aad334f9a9ee552c4dd5b794ebdd45]
stable/6.6: [ab26e12dd5d2f43d939fcf456933a816e81d2e51]
stable/7.2: [f517cf02033801a28f98d86ca613a3533cf066b3]

CVE-2026-80985: net/smc: carry oversized SMC-Rv2 LLC messages in the queue entry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80985

Introduced by commit 27ef6a9 ("net/smc: support SMC-R V2 for rdma
devices with max_recv_sge equals to 1") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8d3c1ab82c11d4fadebf817a825fd221b3e197ea]
stable/6.18: [edf30d65e3ac52f886f7d87b1a7449742e79157d]
stable/7.2: [0d6f80be8ac5886842640d6526abf3f9a215be75]

CVE-2026-80986: net/smc: bound the peer rkey counts in SMC-Rv2 LLC messages

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80986

Introduced by commit 27ef6a9 ("net/smc: support SMC-R V2 for rdma
devices with max_recv_sge equals to 1") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d1e7c5aaa3326e95e2058457f172ca99a9a4577]
stable/6.18: [486c699a8cde82c1d9b4f443eeab4ddf86358cb0]
stable/7.2: [5e5d9e6df677d30a2203d257b5fd8b99814fa607]

CVE-2026-80987: NTB: ntb_transport: Reject oversized TX buffers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80987

Introduced by commit fce8a7b ("PCI-Express Non-Transparent Bridge
Support") in v3.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a4f2387db6f1cc2f03abba7f3a6807ad61e26ff7]
stable/5.10: [4890152a3069f5cb58cc24b08cfd5fe95e568fa1]
stable/5.15: [668aa3238548584ca9772da9cf43ae8c2389bbf1]
stable/6.1: [9b0fa8a9e1057614a533cc3f18b17f82aab028d8]
stable/6.12: [a7f22105a7df8c7fd74d0af27ace6fa94fe03d87]
stable/6.18: [6b6bbc6c878d64eacc60877df49fce7b1b6a08d0]
stable/6.6: [b6db88cde0fb5c3bd2d3cd2bebcc06b5ce146e88]
stable/7.2: [75a604e9f1cfdebda421062fdf42225ca32154cd]

CVE-2026-80988: NTB: ntb_transport: Fail TX enqueue when the QP link is down

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80988

Introduced by commit f195a1a ("ntb: Drop packets when qp link is
down") in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1

Fixed status
mainline: [873ce713fef5dde0939220f04f3484ec86a16fba]
stable/5.10: [76c9ccc0c6bebfc74c0e727eda67687f5103ab06]
stable/5.15: [96d792c65b9d5f7f9dd86a1004315db59e450c07]
stable/6.1: [45cc11035165918dd1f81796ea98f81ece20d361]
stable/6.12: [5eca0d899a3be661a7e2caaaa7467a6fa15d756c]
stable/6.18: [894e136b432da75c0352c80299807a5c4b04f167]
stable/6.6: [e6cc541fab01099fd8efadfa4f13afdf118bf536]
stable/7.2: [89177732fe1653bbfef10cf5d99bf20cf57762c2]

CVE-2026-80989: net: thunderbolt: Mark the connection down when
bringing it up fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80989

Introduced by commit e69b6c0 ("net: Add support for networking over
Thunderbolt cable") in v4.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c8b26ebf525ba5960510f48c6e9936a79ebe76f]
stable/6.12: [ed1d6e3d735e7b03f43a02f4306c89eb7663da14]
stable/6.18: [f01e6a35c440b62f060e21f36b385e574a7f308c]
stable/6.6: [e0d4a17afde5aa0045dc3e1d66c6bb80927bad8c]
stable/7.2: [d6c0af293129345a17dc31c9b4179dc7f3d6af7a]

CVE-2026-80990: net: thunderbolt: Release the Rx HopID that was handed
out on mismatch

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80990

Introduced by commit 180b068 ("thunderbolt: Allow multiple DMA tunnels
over a single XDomain connection") in v5.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f1463554d0561a2fead81e3888604e5c1125e29]
stable/6.12: [9eac1817bfc5fa76e3a2d1b8fd824cc6ef5a9ab0]
stable/6.18: [61ff3c353e5d2ff4eb9d0b6d8d9e47805b136eea]
stable/6.6: [47981eb66461ba4e74bbaea0f139adaaeb3991e9]
stable/7.2: [1c361f6cf39be7cc0ce37c0b67bd1cdf74b0a0c1]

CVE-2026-80991: net: ravb: serialize PTP clock teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80991

Introduced by commit a0d2f20 ("Renesas Ethernet AVB PTP clock driver")
in v4.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1cb9663789c5b7a12fcd419fcca6d6254c398252]
stable/6.12: [695acb5534a9e366efb47b40c7487fc56488b09b]
stable/6.18: [67a82e6f886beed0de8f8da08bb767e68fba952d]
stable/7.2: [66b50c31419e7946e9aa325a468ad9b64c961a25]

CVE-2026-80992: net: ravb: avoid dereferencing an invalid PTP clock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80992

Introduced by commit a0d2f20 ("Renesas Ethernet AVB PTP clock driver")
in v4.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f77af0aaf277413ff32f6ff8c2c4282bd64c897]
stable/6.1: [29ffd972531f8e6e0edf4ea3496190acff9fc9c2]
stable/6.12: [fc710f89a644e030a7ca15343176ca862fd61b9d]
stable/6.18: [8d4d06d6e2b501cb8e30ed3b1924c470358e8052]
stable/6.6: [bf3308416a2be85dcc9965b614a745b40beeff14]
stable/7.2: [0aaa53936419cf0c19c670387fc6d431e042a1b6]

CVE-2026-80993: net: phylink: correctly validate returned PCS in
phylink_inband_caps

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80993

Introduced by commit df874f9 ("net: phylink: add pcs_inband_caps()
method") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f2849b1fd059ec9b3281b771e6ac5aad9feee851]
stable/6.18: [b6b533f83461c3730875cf3ed5ff6362dcb67be9]
stable/7.2: [fb4d77553841ae85bed9b2cf03351c401e871d85]

CVE-2026-80994: net: openvswitch: fix flow mask use-after-free on flow deletion

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80994

Introduced by commit 56c1986 ("openvswitch: Make flow mask removal
symmetric.") in v3.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e30317ff67a2eb12b4d890d39f72fd7e7117d48]
stable/5.10: [ea5f7b45b582665541ddfb77dce98611354af4ab]
stable/5.15: [18ce1a8b7499c016d4a893d9b1db80608f73745d]
stable/6.1: [c15ef9a5bf594f93a31de2ec2ec394e2a903519a]
stable/6.12: [0ba5cbc2f049af94ec94ff6f64958545efc5eaa2]
stable/6.18: [ac73e3af571da06c1d1cfe3f0f00dc978b851700]
stable/6.6: [64051fe200c7c759af71634bd2123552eaabb69a]
stable/7.2: [7f072b84afd05a77963eb1872f7174e280661dce]

CVE-2026-80995: net: mctp: hold a reference to the route device in
mctp_route_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80995

Introduced by commit 22cb45a ("net: mctp: perform source address
lookups when we populate our dst") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [408da1df18116c971c3392e21e50586688cd3fbf]
stable/7.2: [cc561f8af25586300c2f9d285babb163b866b293]

CVE-2026-80996: net: l2tp: do not propagate multicast notification errors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80996

Introduced by commit 33f72e6 ("l2tp : multicast notification to the
registered listeners") in v4.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af20e269f7459d2ce69887fdf2fad7caf986c865]
stable/6.12: [0fe037d5eaad938aa3e9143ee071aa237750b42b]
stable/6.18: [9c340473f4822bb31b151c19afd17448eda5acd1]
stable/7.2: [50c4038f1670bf9a80c6a58ae83d1602decd8481]

CVE-2026-80997: net: ipa: fix stalled modem TX queue after runtime resume

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80997

Introduced by commit 688de12 ("net: ipa: kill the STARTED IPA power
flag") in v6.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3cbfd627ee720f3d2460d2cbe2fe9e4130240db6]
stable/6.12: [30d5226bac52073c91ce85c2dcff93b866baefdb]
stable/6.18: [62da38b4b3a0dd74a3e0eecf4992d40385924205]
stable/7.2: [30cef9c1229a36a9c80edb29296459849a2fbaa3]

CVE-2026-80998: net: bnxt: ring the doorbell when SW USO exits early

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80998

Introduced by commit cc5d906 ("net: bnxt: Implement software USO") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e15e89faac9f308baeb01f46c13a051814d2449]
stable/7.2: [48d1c9665db6e3d4aeca62eb669377162ebc6fdf]

CVE-2026-80999: net: dsa: realtek: use gpiod_set_value_cansleep for reset GPIO

Announce: https://www.cve.org/CVERecord?id=CVE-2026-80999

Introduced by commit d865295 ("net: dsa: realtek-smi: Add Realtek SMI
driver") in v4.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fb58b6a696b30bcbfbe0cfc0a91b19c816a955fc]
stable/6.12: [c32cf5292a0dd70c4afc138b4dc45743a190cd5a]
stable/6.18: [f71087e7c63aa3e99bf65d7ddf91eb4fd3545778]
stable/7.2: [1610a8c2b93e815e3dc8643a2a69ab1c37975a6a]

CVE-2026-81000: net: tun: bound receive headroom

Announce: https://www.cve.org/CVERecord?id=CVE-2026-81000

Introduced by commit eaea34b ("net/tun: implement
ndo_set_rx_headroom") in v4.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [447c9303942c439a117d9b76ce6d6e2116b38ee7]
stable/5.10: [ad715e713610d2d5473c3a6498c825ccecf26491]
stable/5.15: [708e87937de93f445225c134a2e20519f9b4ce60]
stable/6.1: [18ef24cdb2eba32e38f1d27f2d02b7b4212e8f76]
stable/6.12: [379d85c7f25f3e05a428225e6b8a65613c6e9b9d]
stable/6.18: [e098d9cc8859614a7f7baebc96e32a5a16b18ed2]
stable/6.6: [010eee265d6bd8769b6a523d2a0693d9b3f5df43]
stable/7.2: [0ada54ea63e48b9c1608e917ccb7dfadbe86db28]

CVE-2026-81001: slip: fix use-after-free in sl_sync()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-81001

Introduced by commit 5342b77 ("slip: Clean up create and destroy") in
v2.6.32-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c4e7c42d77e78ad595dbb9e4b5886b58b45d89d]
stable/5.10: [045e307ac21fbd735b789d8817b21be4d8ead054]
stable/5.15: [87398cdec8bdf84096a8af4dbccdb04f1972f32c]
stable/6.1: [e93ace1f46177a4f7b5a8e5996606cdf77e1e890]
stable/6.12: [a235b20972bbd98ca1fb127d6269434edc607f19]
stable/6.18: [486577db807891d0f964fdf13c1640c7f54b0ad1]
stable/6.6: [70e20456bcbf7f3ae145bb96e5548f827a37c640]
stable/7.2: [d6f25e5bd777b05880da8673daf74a8419480545]

CVE-2026-81002: xdp: fix zero-copy frame layout

Announce: https://www.cve.org/CVERecord?id=CVE-2026-81002

Introduced by commit b0d1bee ("xdp: implement convert_to_xdp_frame for
MEM_TYPE_ZERO_COPY") in v4.20-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [71283aaa6c65b3cec84caf1dc78560985737641f]
stable/5.10: [dcb6db9ca6515fcd3e00c93ec5e27dc7a0a7012f]
stable/5.15: [22092730129077c302d8c947bbe0876f0280c528]
stable/6.1: [ced3e18cd9b9caf630aaa1e1eac305f5192ba896]
stable/6.12: [444216dacdbebd3e52d5e704facafbb230da09e9]
stable/6.18: [15d1f3c0dbe7a740f779337deb39f23cd8d002c8]
stable/6.6: [6de17275b3ccdf9887568b07e54da2e3597217cf]
stable/7.2: [68d7cc5512238693670fc19c7a615df631e10edf]

CVE-2026-81003: net/iucv: filter frames in afiucv_hs_rcv() by ingress device

Announce: https://www.cve.org/CVERecord?id=CVE-2026-81003

Introduced by commit 3881ac4 ("af_iucv: add HiperSockets transport")
in v3.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [80230a18c164a4b5bbc048fe2768b219ac17bc5a]
stable/5.10: [639828ad4d374056167391dbaffd13dd5e5e5ddb]
stable/5.15: [92e5c281f1caa287bb58292f2687c9e3ff3aa23e]
stable/6.1: [712330f8a4293cfd97b0d62b7c7dc01862a16b98]
stable/6.12: [dfac2936b83be00035ae176f8252e1c1e1de9207]
stable/6.18: [8e3763f1ccac3fc395f9af2b87114c023ced8a3f]
stable/6.6: [0a5af67e7184c6a0e155c317840bd64b37177af4]
stable/7.2: [a7f0130a091724e69827ab58e74777a88747e892]

CVE-2026-81004: ipmi:msghandler: Cancel work cleanly on an error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-81004

Introduced by commit 62cd145 ("ipmi:msghandler: Handle error returns
from the SMI sender") in v7.0-rc2.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [ae84a2536577057e97f23f75a202e26d0e86cf01]
stable/6.18: [99692252b348c11377fd0cdd66b6b18f3b22758e]
stable/7.2: [a496c51dd3257ed7e00873af2ad9bb22c3ddc4cf]

CVE-2026-81005: ipmi: si: Fix NULL pointer dereference after failed registration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-81005

Introduced by commit 2512e40 ("ipmi: Rework SMI registration failure")
in v4.19-rc4.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d920a75df9a83ab096b3cde7a643b656e4fdfeb]
stable/5.10: [75ecc80ef0614a9f8441ab476fb748d3e919bea8]
stable/5.15: [b11a1e545ad7a2f8f9ba7276b4ae9429c3399456]
stable/6.1: [f390b0e781ca689515b659f94ef05f01497ed833]
stable/6.12: [d4be659a3e56f4eb16039ab8a1162efea086a714]
stable/6.18: [53af3a8bae0a93c1342e1b5519812203332aca8e]
stable/6.6: [d377bf743f29b41729a084a633874ef9c1a13c6a]
stable/7.2: [8ada17dd4c4ffd6b94621e735d77eda196ce118f]

CVE-2026-81006: ipmi: Remove all sysfs files on registration failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-81006

Introduced by commit 6271184 ("ipmi: Add a maintenance mode sysfs
file") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b6c46ab0bdee90c238e96ea4a74972118c97900d]
stable/6.18: [d46c97eddcbc53ca885e8bb359930c58884616ff]
stable/7.2: [b115b7d06f26b3f000d2afda88acb54c7a7cb2c9]

CVE-2026-81007: ipmi: ipmb: validate write message length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-81007

Introduced by commit 51bd6f2 ("Add support for IPMB driver") in v5.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [53637506884dbd5c91a89b1a3547d99d80f8ed2c]
stable/5.10: [8990c7f6bfc1e7689b7012a7d4d0efb9f07a9c89]
stable/5.15: [94f8d20153e348c79bc14dc25f873470518892da]
stable/6.1: [e527cd4e80066e1ed070fdc7c705bde340cdcc62]
stable/6.12: [60939bcda6f3f104ef456fdbf3cc5733c0720fb1]
stable/6.18: [5719431ca2b5fa26560bb38f6202f8b97fa3bbb0]
stable/6.6: [7d66d54b974cff0a959e188af844d2d110422767]
stable/7.2: [a84c6e3d188f2c6e674910929eb790634299d6d5]

CVE-2026-81008: interconnect: Fix use after free in icc_get() and
of_icc_get_by_index()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-81008

Introduced by commit 3791163 ("interconnect: Handle memory allocation
errors") in v5.6-rc5.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [25c7e242aca084fdc1098248194032317dca625d]
stable/5.10: [03c3af594dea9196cf6ca70d914b42aa8c873c35]
stable/5.15: [d4d73decdb9a44a248b1cbd04ed6f334df544d9c]
stable/6.1: [9a671125d4228357e5b929733c4593d27a273749]
stable/6.12: [a4e9aa7907ade87d1d96853d14e05dcf682f8363]
stable/6.18: [db8147c5d5ad2cfa21c2be566f95981b41b05de6]
stable/6.6: [fedea72e8f312fe7d0c6cb19353e61d2d5643b11]
stable/7.2: [d715d19cfcfe99f361adb05cefc143a95d400b87]

CVE-2026-81009: io_uring/query: cap user size passed to copy_struct_to_user

Announce: https://www.cve.org/CVERecord?id=CVE-2026-81009

Introduced by commit c265ae7 ("io_uring: introduce io_uring querying")
in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ba77efee1b95b4ad7559b1cdbe7cd7fa36dca95b]
stable/6.18: [417e02f7b6051765b91cf1289071882eebd172e0]
stable/7.2: [2b8ad4981ecedb14c1fdd811ab977010b23933e6]

CVE-2026-81010: io_uring/waitid: honor task_work cancellation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-81010

Introduced by commit f31ecf6 ("io_uring: add IORING_OP_WAITID
support") in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [14572de82e5022899e5856008bc9cac97004a88c]
stable/6.18: [0879697520abda2383ed7be40572ad583b5c4b02]
stable/7.2: [7bc98e2de8c58a2bfaf0f540eb096a386ecfc96c]

CVE-2026-81011: platform/x86: hp-bioscfg: pass validated element count
to package parsers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-81011

According to the .vulnerable file, this bug was introduced by commit
a34fc32 in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0ddfd77c0c320b7d12b6c9169303b140b798775]
stable/6.12: [436017808c7cbcdb5e49b2142090d4391e3de9a6]
stable/6.18: [a38127df99ae8b1851560b35b837c9952416143a]
stable/6.6: [467e53f231f77a1677191b8cdabdaf1448439d55]
stable/7.2: [400cbc3ccc88a5ad37cd85056224635ce9eba018]

CVE-2026-81012: platform/x86: hp-bioscfg: fix off-by-one write in
hp_get_string_from_buffer()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-81012

Introduced by commit a34fc32 ("platform/x86: hp-bioscfg: bioscfg") in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc03f05e419f3460342fb7564884f244622634b6]
stable/6.12: [3cc772d0154799961f032e5a992d4a50523e291a]
stable/6.18: [b15b334fbc3c0c46440f8a892ebf62164fca23d6]
stable/6.6: [8f5aa1506cdddea6b33584c2445b9ce99eeddb64]
stable/7.2: [ddf98cf33529714b3ba1a158afb1db5b0f759a1a]

CVE-2026-81013: platform/x86: hp-bioscfg: fix heap OOB read on empty
password write

Announce: https://www.cve.org/CVERecord?id=CVE-2026-81013

Introduced by commit 8646a3b ("platform/x86: hp-bioscfg:
passwdobj-attributes") in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b2ec354f905c14e3270e8ec3ab50f7d8ad73bab]
stable/6.12: [cecb8154bd5fa6c8ddbd1a4e8216bbc0f0eb9828]
stable/6.18: [0f9aad08424882dd5714b53d29ae044060890752]
stable/6.6: [21243c15e1d31f0df1517435e3a7784747f19043]
stable/7.2: [b699e5c1f63a9e79946c35598c8a6f7af2c356b8]

CVE-2026-81014: platform/x86: hp-bioscfg: fix heap OOB read in
sk_store() and kek_store()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-81014

Introduced by commit b2715aa ("platform/x86: hp-bioscfg:
spmobj-attributes") in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a7508c7959ff8d037327d377ed21a9c0eabe4674]
stable/6.12: [4c6374dcb270d12907b880cf82a5a5ef21785fc3]
stable/6.18: [7cd8fe01aba303a2382db0966eb6c8ab41d5f3c2]
stable/6.6: [81db79fed115640736188e56595b1e9aec317d5b]
stable/7.2: [67b60703d7d8af1ca0e49f72e1bdb1ccecd41b5b]

CVE-2026-81015: platform/x86/amd/pmc: Fix LPS0 and debugfs leaks when
STB init fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-81015

Introduced by commit 83ad697 ("platform/x86/amd/pmc: Move STB block
into amd_pmc_s2d_init()") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [76f650a76d6a36a4bee79d94db90a0e935a95477]
stable/6.18: [bc9aa5fe21c3966c80647ed6574b94b863f23c62]
stable/7.2: [30e5f4d0cd0be655c800f10ae3e530391aa6c1b5]

CVE-2026-81016: platform/x86/amd/pmc: Propagate SMU errors and
validate S2D address

Announce: https://www.cve.org/CVERecord?id=CVE-2026-81016

Introduced by commit 3d7d407 ("platform/x86: amd-pmc: Add support for
AMD Spill to DRAM STB feature") in v5.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0225c1d637687b03726f00ac65b6def843d2c464]
stable/6.18: [8178f59d76570b152d836bde07f5997f15861f04]
stable/7.2: [775d4cde1f9737796ce7d8393521e9e8c5b49891]

CVE-2026-81017: platform/chrome: sensorhub: Bound the EC-reported sensor number

Announce: https://www.cve.org/CVERecord?id=CVE-2026-81017

Introduced by commit 145d59b ("platform/chrome: cros_ec_sensorhub: Add
FIFO support") in v5.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [833740a2333c2e4db4e02e3d0ffba04e8718a5f3]
stable/5.10: [3a76b87e1d065183e2e7ae5b800cb1f6e84f543d]
stable/5.15: [2b602ecf6193ecb9720c78b6728d7e09370b1ff1]
stable/6.1: [324880f94ba3c6269a607e04f78a4dd4a66b3f53]
stable/6.12: [3d2636dce0a8fe9eecad29010699847be425dc80]
stable/6.18: [5eaf7faa99578ae090030d1e2e6ea3b37a615496]
stable/6.6: [d1b4add68dabfdd6481a4fa198bf3b473d2634d7]
stable/7.2: [4d9bf63ed74f859c6698bc01d8fb216ef9253867]

CVE-2026-81018: platform/x86: think-lmi: Free system certificate signatures

Announce: https://www.cve.org/CVERecord?id=CVE-2026-81018

Introduced by commit 5dcb5ef ("platform/x86: think-lmi:
Multi-certificate support") in v6.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [abca989604f60fe29d7170431f819e28ec7d868a]
stable/6.18: [9c28adde051fe76a7754856d0a414ab89adcaa4d]
stable/7.2: [abbcc0354108cf47a6055b951182bf73520d0363]

CVE-2026-89436: platform/x86: panasonic-laptop: Fix sentinel write
past pcc->sinf[]

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89436

Introduced by commit a3d0dbd ("platform/x86: panasonic-laptop:
simplify allocation of sinf") in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [329f10d8be193bf36af124e00b9dd6644cd71724]
stable/7.2: [a93df956ee4d903735b6d395362c839cb1dc07e3]

CVE-2026-89437: platform/x86: int1092: Fix potential memory leak in sar_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89437

Introduced by commit dcfbd31 ("platform/x86: BIOS SAR driver for Intel
M.2 Modem") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [30c906cff490c3601ee9ff110fe8115fabe75fd4]
stable/6.18: [08dab7065f9369dd0a0aa740071bcd884c4848b0]
stable/7.2: [582b82e573a059be9319bb16b84c45d0ef66f471]

CVE-2026-89438: platform/x86: ISST: Validate logical CPU id and clos id

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89438

Introduced by commit 12a7d2c ("platform/x86: ISST: Add SST-CP support
via TPMI") in v6.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [124e2dbabe460c2a6e7440f4ad8af560131295c9]
stable/6.12: [c9ee2770eb95ba316a56d776b2b66666b70c194b]
stable/6.18: [5b032e1dda486ca41d10536bd195bd8a559af1e2]
stable/6.6: [0d601126c7afda9bb94dfecc8b2c0a16f20d76cb]
stable/7.2: [82d4afadb02fb4d7d7bb9230900904c10e49ec87]

CVE-2026-89439: platform/x86: ISST: Add a NULL check for sst_inst[]

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89439

Introduced by commit d805456 ("platform/x86: ISST: Enumerate TPMI SST
and create framework") in v6.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3de2776e9d7073765c10c2326c2bda5926811ea6]
stable/6.12: [49a95fe1f64f41c2e8959e525aefdb10f23b293e]
stable/6.18: [c280fcd53b938b70c7dee9ce1a66b32bd6e5ebaa]
stable/7.2: [ef7975af15126dd70ace519da7bb33f2848b9064]

CVE-2026-89440: mmc: via-sdmmc: stop card-detect handling on probe failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89440

Introduced by commit e4e46fb ("mmc: via-sdmmc: fix return value check
of mmc_add_host()") in v6.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1

Fixed status
mainline: [088eaa92fcebaa6b957ccf9635afdf39643a577d]
stable/5.10: [5bb5327b92aae17e91c7228953c350a6ee3c94e8]
stable/5.15: [d045596706d1b25d38af4a79980b017639fea9d1]
stable/6.1: [806409f12fdb14c9e4c56a64494c9b75f356cd49]
stable/6.12: [efe7f25dd27e35063477b4b0e7eed3675669fd99]
stable/6.18: [2550f89589caad7402d618d7dffc038582c94b6b]
stable/6.6: [dde5b9c91e9fc64e54a2f186d3ae95868b4dbb02]
stable/7.2: [c2b8a624911999399cc14822fec3e35032b3cee4]

CVE-2026-89441: mmc: via-sdmmc: cancel card-detect work on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89441

Introduced by commit f0bf7f6 ("mmc: Add new via-sdmmc host controller
driver") in v2.6.31-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [57e5d877f898d5e5c9d672a77bb6bdd24f0d9bf5]
stable/6.18: [f7ff3027ef004a331ef911a4886f12bc2e996037]
stable/7.2: [eaca730c6f5e3609df62a0469fb789235a93d276]

CVE-2026-89442: platform/x86: ISST: Validate socket ID in clos_assoc ioctl

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89442

Introduced by commit 12a7d2c ("platform/x86: ISST: Add SST-CP support
via TPMI") in v6.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a89f07db0cb95c54dac4a8406c79a04e44a73c3c]
stable/6.12: [0d90ab5f80e19cddfeb0c9fab47a1f34aa932075]
stable/6.18: [82e707eff9e3b7ef6d96ecc23ea8876d20c7d6ca]
stable/6.6: [c847ea4851ecfa3462cc711ded2c3c3dd8d08ab8]
stable/7.2: [207b4dc6eb100141b122b2602504a1429a4b6558]

CVE-2026-89443: platform/x86: ISST: Validate level in perf mask ioctls

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89443

Introduced by commit ea009e4 ("platform/x86: ISST: Add SST-PP support
via TPMI") in v6.4-rc1.
Introduced by commit 06a61df ("platform/x86: ISST: Add SST-BF support
via TPMI") in v6.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [80e0d353c86a9a168ad6d213f494796294381538]
stable/6.12: [1a8bab5ceee1a42a78de12d3d69f67516a20588e]
stable/6.18: [1889a9156553f0692acd57caf15e877baace1a01]
stable/6.6: [beb22ebf76c0415f22d2d0c3f1ff0627e7ae4a68]
stable/7.2: [d19385624bdfb577db9c94bb8879992fd5e17bcd]

CVE-2026-89444: platform/x86: dell-wmi-sysman: Don't hex dump
attribute security buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89444

Introduced by commit e8a60aa ("platform/x86: Introduce support for
Systems Management Driver over WMI for Dell Systems") in v5.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83c80495e45eddf64c6525fb582d8db68f256b71]
stable/5.15: [23ba9a18896e198f837ae54be99c8852c41890f7]
stable/6.1: [26f554f9f0fb603f76291c10b1cf979241bd2273]
stable/6.12: [ceeee18c927958b74a04b92cf084fc496fa21e8b]
stable/6.18: [22222f92b0a5116eb4aac4be81e7b770adfa32ee]
stable/6.6: [44ec7f1113309a93d0f250bcd49285d21dd1470e]
stable/7.2: [eb73b9d51490bec4f73ac6efdba5ac535fcfee74]

CVE-2026-89445: iommufd: Fix UAF in selftest IOPF reporting

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89445

Introduced by commit ddee199 ("iommufd/selftest: Add IOPF support for
mock device") in v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8c07df7cdfcf52f1ff276c588612aabc6c6b8399]
stable/6.18: [cab2895729516799384d48560e6fca105fb3f927]
stable/7.2: [e27e90bde68b2ab92e63ed19caad1ef57188bea0]

CVE-2026-89446: iommufd: Release current IOAS on xa_store() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89446

Introduced by commit 051ae5a ("iommufd: Lock all IOAS objects") in v6.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ac2ce123824d5f885c868fa1f9f4d463141a2ba]
stable/6.18: [4c33d00ad9a911e87ea222986f732ce072e3aa26]
stable/7.2: [07b4fe1367f076886c1c47a19c70936138325087]

CVE-2026-89447: iommufd: Avoid locking internal accesses during unmap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89447

Introduced by commit 27b77ea ("iommufd/access: Bypass
access->ops->unmap for internal use") in v6.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0dbcdf4473a614adbd732d567c9b39ac0e040e0c]
stable/6.18: [436189ee4bb2c7c993b945d68570dd38c3e4349e]
stable/7.2: [50a66a63d1c841ae6b28a4551f642c1bba4c9529]

CVE-2026-89448: iommu/vt-d: Force requesting ACS when tboot is enabled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89448

Introduced by commit 5d990b6 ("PCI: add pci_request_acs") in v2.6.33-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [607432b2618b61df81134be0ef2562b8300c1216]
stable/6.12: [aaeb81241e802c86be69394f72d49fde3f861fbb]
stable/6.18: [45705a6bfdb283f7b3b509010fd617b72f942537]
stable/6.6: [579eb867d3da63f3b5e32f235925e1daa7ec70d0]
stable/7.2: [87bc611c6c98a41c00feb7b06b0c297dd141a2ae]

CVE-2026-89449: iommu: Fix dev_iommu memory leak when device_add fails
in iommu_mock_device_add

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89449

Introduced by commit 2a91891 ("iommufd: Register iommufd mock devices
with fwspec") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b7b0b3851474883d4aba6ed72da87141204b23e5]
stable/6.18: [f80f3acb69164800051ecdee871b6b006cbc2e66]
stable/7.2: [eaf44262af24810d16800b988c92dfce90f73370]

CVE-2026-89450: iommu/tegra241-cmdqv: Reject a vSID wider than the
SID_MATCH field

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89450

Introduced by commit 4dc0d12 ("iommu/tegra241-cmdqv: Add user-space
use support") in v6.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4379610c79bd88ddbea10e7f6c21e16d4b338c6b]
stable/6.18: [d903d99ffd22b0180bd745a43f221c21bcdd8d7c]
stable/7.2: [445204550f894ca325ac80a21e3df177ad073798]

CVE-2026-89451: iommu/sva: Set handle->dev before the SVA handle is visible

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89451

Introduced by commit be51b1d ("iommu/sva: Refactoring
iommu_sva_bind/unbind_device()") in v6.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [530f8f9c3546cb3ebee1b135375aaee08a073ebb]
stable/6.12: [bcffb1c75da8fc9d51168ff9f09d471c26507912]
stable/6.18: [968e9a1f71140c86dc4092f6b361e997923f3813]
stable/7.2: [37a96a30617a4c96f048a5874c00509bc4fe4d85]

CVE-2026-89452: iommu/msm: Unwind probe state on registration failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89452

Introduced by commit 42df43b ("iommu/msm: Make use of
iommu_device_register interface") in v4.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [535a200220ca2c83bc8bf54bd2cbe045d6ee70c4]
stable/6.18: [f532401be9312ecd166f616bb74a65b0b4c150fa]
stable/7.2: [7f7074a886c4a93e3d12076ce60a510a1ebe400c]

CVE-2026-89453: iommu/amd: Put PCI device after handling PPR faults

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89453

Introduced by commit 978d626 ("iommu/amd: Add IO page fault notifier
handler") in v6.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af3b69b16383fbc8fe5f61b5b0150d2e41ede71f]
stable/6.12: [1de4443f85e4405af00153cdf8ba73ff12a65036]
stable/6.18: [cfc5c1b2caa176dfd40b873a6ff07b11da34cc3e]
stable/7.2: [d1470e16c1977e6c94fadf6048deafaa4d150fec]

CVE-2026-89454: PCI: plda: Fix IRQ domain leaks in the error paths of
plda_init_interrupts()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89454

Introduced by commit 4602c37 ("PCI: microchip: Move IRQ functions to
pcie-plda-host.c") in v6.11-rc1.
Introduced by commit 76c9113 ("PCI: plda: Add host init/deinit and map
bus functions") in v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [19a30bbb6477bfd7e3109b7a2943e6597ee9de37]
stable/6.12: [01b05cebe1e862e31e382359848d7dca02525a4f]
stable/6.18: [4b575052ea65423693726a21826d783cf3f1745e]
stable/7.2: [e54e8d2a0f9c8bf251ae4385ea4f4a68840fedad]

CVE-2026-89455: PCI: plda: Fix use-after-free of event IRQs during teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89455

Introduced by commit 76c9113 ("PCI: plda: Add host init/deinit and map
bus functions") in v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26b73bae01d6eb81a4a38f36101812f20b2639de]
stable/6.12: [1d0159e139261996a3ca21798d9114aab2124d3c]
stable/6.18: [01c2f0c66bd1f892db9c6e82976da6b463cc4427]
stable/7.2: [e3589ca5f2e6477774753a2202c21509428d4701]

CVE-2026-89456: s390/dasd: Propagate partial completion length across
ERP recovery

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89456

Introduced by commit 5e6bdd3 ("s390/dasd: fix data corruption for thin
provisioned devices") in v5.6-rc6.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6fb5ba2e7e43173a3761e46f091070a8185efa14]
stable/5.10: [9e063165d3fe58db2a517717b830f17e82d03467]
stable/5.15: [6b0954c8a259da1e4aa745989f82723947acfb46]
stable/6.1: [d0a2f97d8c97134aa7f6a191940b7bab4bb42f5f]
stable/6.12: [d6b8778b1b82aa3a8dbf8612080f635b834bd16b]
stable/6.18: [ceafb262475ac6cb3a7d07b1102608be2b216b99]
stable/6.6: [f735b9710f0c8fe72c1060103e865f4ae678190b]
stable/7.2: [15ec03452c18e8d288e519837d21b308300d74b2]

CVE-2026-89457: s390/dasd: Guard sysfs discipline callbacks against
unallocated private data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89457

Introduced by commit c729696 ("s390/dasd: Recognise data for ESE
volumes") in v5.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2a1780f9fc2493bd34c418a0be6fc58943afcecf]
stable/5.10: [644b666c202cce12ccfcf9ded67089b18f4f7659]
stable/5.15: [4a042d8e5f34282577ece50515cea8bb1246914d]
stable/6.1: [bd8b4572528f9604a13bf3c7c2a167f5cf222f72]
stable/6.12: [536407b272402af679155910d7fdeeb4834eefb9]
stable/6.18: [6452c13646af7c13d7f6668b6690cfb2427e7f7b]
stable/6.6: [57db27ccc162afe0726cffec0ae62e410ed2d0e9]
stable/7.2: [449f3bada7a9fad8b8cdf4bb20baf27ee9ca56c5]

CVE-2026-89458: s390/dasd: Do not complete a failed ESE read as successful

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89458

Introduced by commit 5e6bdd3 ("s390/dasd: fix data corruption for thin
provisioned devices") in v5.6-rc6.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cddb447c62466f3076938ce120028d7b591f9f37]
stable/5.10: [8cb96cffceead3cbd0541154d7ecc5e6474edda1]
stable/5.15: [77168af195d04b34c6de62b874624e74d64cef8d]
stable/6.1: [921ff697bb6f7067059793becf8b2d00de71ce41]
stable/6.12: [c9adf8399732306dfc97b3adb4778038743e3f5e]
stable/6.18: [52b331c99baac653ca794bd8487c8ec4de8db203]
stable/6.6: [55f4df40178cdfede0d7ae848fbab00efa9b95c1]
stable/7.2: [b0d94dd6e82df396e2254c8b0f25eff7d19c2e7f]

CVE-2026-89459: s390/percpu: Fix MVIY_PERCPU() with older binutils

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89459

Introduced by commit a737737 ("s390/percpu: Infrastructure for more
efficient this_cpu operations") in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [101782f8945a125044347312d74d488c05741c4a]
stable/7.2: [91770b08a120967077ae78600612f18bc5ee3caf]

CVE-2026-89460: s390/cpum_cf: Handle CPU hotplug via prepare/dead callbacks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89460

Introduced by commit 9b9cf3c ("s390/cpum_cf: rework PER_CPU_DEFINE of
struct cpu_cf_events") in v6.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [337bd95507a16063687cfc286ea90de5cca48c37]
stable/6.12: [777d040c2f91d8d929b4a32333dfe4102b27caea]
stable/6.18: [dcce7a06ea690d5cf46a705a9b74cf0398ac091f]
stable/6.6: [991be92489bc7b1b6e7903debb96bd58c892dee4]
stable/7.2: [71d46de9153e067c63a15f3b00e6364e1c0230f8]

CVE-2026-89461: power: supply: max17040: synchronize work cancellation
on suspend

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89461

Introduced by commit c6f4a42 ("Add MAX17040 Fuel Gauge driver") in v2.6.31-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [86a3a8a926aa5969c329d1df2d3259f189961bbc]
stable/5.10: [6bd453e328a0325f838c3bf64d4609c6c1866ed7]
stable/5.15: [7a9ec6707b545b2a0b35942c8b68d975cb901f77]
stable/6.1: [dc946222e4b5bdb4e92bc3a5a5e8fc4ddac34ec0]
stable/6.12: [5a863417fb9a1034ab1cfe4fa0de46ce1f95f3ec]
stable/6.18: [aad7247bd35ad44af90a5e8974cdff614235b497]
stable/6.6: [23783db5642a714f0547c5b5b0c9cdbb1be7b084]
stable/7.2: [36e6ce0f402f965328b27fd31ac793110e8a0c39]

CVE-2026-89462: power: supply: max17040: propagate register read errors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89462

Introduced by commit c6f4a42 ("Add MAX17040 Fuel Gauge driver") in v2.6.31-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [659cc3d8d5ef246263873fce72c8cadeeed073cc]
stable/6.12: [2943a0edd4865ed744702ada647921c3981207f6]
stable/6.18: [13fb0477da9b400071b9d518b24d6434c4965263]
stable/7.2: [c7aa4c3708cc0d8487336f8281665eaea87130f6]

CVE-2026-89463: power: supply: ucs1002: fix use-after-free on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89463

Introduced by commit 81196e2 ("power: supply: ucs1002: fix some health
status issues") in v5.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [609af0ceeaefdfa42cd01dd060b20f2e41f9a232]
stable/5.15: [00c19f8a9a58a318a76fd6f735a8aab3f8ead393]
stable/6.1: [a9a7bb801c443a4d9fc623c4a47deb53accb70bb]
stable/6.12: [4ca2a4678202f15eb790eb7f1d562061709caea7]
stable/6.18: [39b60d615dfa1725c235351fb12bc72e5f8a8d32]
stable/6.6: [2ec4d203ecb06d327af67e32097fe8f774838a40]
stable/7.2: [35242c93d35f391afdc84cef6236b8ad57f1df24]

CVE-2026-89464: power: supply: twl4030_charger: cancel workers via devm

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89464

Introduced by commit d6ccc44 ("twl4030_charger: Make the driver atomic
notifier safe") in v2.6.39-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6eba34732524067da2aad5ddfdfbc641ded10e9e]
stable/5.15: [9644c96ef8646c65d46caa5139a6631e29b79d6c]
stable/6.1: [e9fffe10bd791082263c1678f2f6cdd6d7b487e0]
stable/6.12: [72a2d6cd049f892853e4e2d8d8fc5e7d0244a458]
stable/6.18: [a4460e89d4088cfec2da5be33e265ef1a8e780e9]
stable/6.6: [c46c205bab0dfce4dd54aeb49da3f183e1fdfc63]
stable/7.2: [b955da82db4170bdf1c784dc457287aa0c977378]

CVE-2026-89465: power: supply: rt9455: quiesce delayed work before teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89465

Introduced by commit e86d69d ("power_supply: Add support for Richtek
RT9455 battery charger") in v4.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e7a1ebc32fad5a558254a478efd401c17a24381]
stable/6.12: [df67c7a2fff8414aa766b8cd5ffe11ec1ca27d02]
stable/6.18: [1b9978433c61a9b46e48832a1ebceee1cf5c9eb4]
stable/6.6: [442c60c08ec23ac45da0a58877cab05e0a58f4ea]
stable/7.2: [7323e562f6961e4b7bce3225cde4ecbc78260deb]

CVE-2026-89466: power: supply: qcom_battmgr: terminate the strings from firmware

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89466

Introduced by commit 29e8142 ("power: supply: Introduce Qualcomm PMIC
GLINK power supply") in v6.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab1112df8f4ffa88cb024dd370c432ced80f77d8]
stable/6.12: [0e70a9b0d16acf7adebc4f386178a95da27c0027]
stable/6.18: [ee053561e21ce1e1741dd64ca5ddcdb92e40edc1]
stable/6.6: [c06028db620854b11ad81b04b0a4e1ead930cb76]
stable/7.2: [6cc6c28c9ab6e8ecf901397717a5b391b828cdaf]

CVE-2026-89467: power: supply: qcom_battmgr: fix use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89467

Introduced by commit 29e8142 ("power: supply: Introduce Qualcomm PMIC
GLINK power supply") in v6.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e40befedfc8ed86f44e1f81df92d13c149c9f8d]
stable/6.18: [06618447029c6dddaa02f6e9528efe5dd49fc329]
stable/7.2: [49fbcd3da2958159370d25dafbf736e654a4d59b]

CVE-2026-89468: power: supply: lp8788-charger: fix use-after-free on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89468

Introduced by commit 98a2766 ("power_supply: Add new lp8788 charger
driver") in v3.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [831c29a12d560f8a3225f43050b3fbb5dfd79c66]
stable/6.12: [88d8eadfad5d9ff967e74090152940bcfa27df69]
stable/6.18: [b3aa1e9509e1b0a863353356d617fb45d1b6250a]
stable/7.2: [b4eb6a056b441ba0caedfbfc42cec501acf12f67]

CVE-2026-89469: power: supply: lp8727: fix use-after-free in
lp8727_release_irq()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89469

Introduced by commit d71fda0 ("lp8727_charger: Clean up the interrupt
handler") in v3.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ceb6ac43b0f591722401922ceb958ce2616935e0]
stable/5.10: [1321a4e6247164312eabc6d07f88572da2ee308c]
stable/5.15: [dc1dc2837f8e53bde2f16d52a63f4142e21757f1]
stable/6.1: [035cc6bc4d412dd4302862e8f859b784fcd4653b]
stable/6.12: [80d4e40a85ba524e66c8c748aa7bb19eaf2f69df]
stable/6.18: [ab6b1ad710bed7931540733ce145493fece8ceef]
stable/6.6: [6f0ce09d60a0e4fab6f9ebe8294750481f0c19dd]
stable/7.2: [6ab3128292df67295de1b2a86f21d89cf6612a7e]

CVE-2026-89470: power: supply: cros_usbpd: Limit port counts to
EC_USB_PD_MAX_PORTS

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89470

Introduced by commit 3af15cf ("power: supply: cros: add support for
dedicated port") in v4.20-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [657cd3a42e937276262c0a8ae6b01a87004309de]
stable/5.10: [e951b65ef1699439079b723ca5c72cbe44771647]
stable/5.15: [3ce9218639ff62d011eb8aca0943aa670a654c7b]
stable/6.1: [dce1750ddbd3380b1f6090dda2b07d2ebea2261d]
stable/6.12: [fd5f289cca04ad869b34fc9ccb647670bfdb60ac]
stable/6.18: [4b1f2be1e1b74a50386ba718de3d62bfcf5ee701]
stable/6.6: [3262977a05b23d1be9fc86727a2b490ec997543e]
stable/7.2: [304a29ac55ba3ee6eceaf7d83d09cd9709f3bf60]

CVE-2026-89471: power: supply: cros_usbpd-charger: bound the
EC-reported port count

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89471

Introduced by commit f68b883 ("power: supply: add cros-ec USBPD
charger driver.") in v4.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [48355ce49359740f52e94d3623f6fc557ce341f0]
stable/5.10: [0b5096f6804161b61451b1cec0e38678630be849]
stable/5.15: [c46c9f447415ca802afab51dea1eafc08ddff1c6]
stable/6.1: [a1905375dfc0b9612bbee52fc066e3a70c0d671d]
stable/6.12: [fd29d08ee487f3bf50f2575aaa74f78a74b09b21]
stable/6.18: [78be8b7403ff7638162438b664a07d19da76059e]
stable/6.6: [2746d502b12b343384fb747bdef9cbcfbd7444a2]
stable/7.2: [3d1e01443b221081258ff34ea0cdd0431e4ff62e]

CVE-2026-89472: power: supply: charger-manager: register regulators
before exposing sysfs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89472

Introduced by commit 3950c78 ("charger-manager: Add support sysfs
entry for charger") in v3.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c57cb36f76eb7ced45f57af1a890d8f3a6d76342]
stable/6.12: [af3ce383ba0d0d48957a22ac7058ff5698775898]
stable/6.18: [86e4fa65368f3bbb506dddba8c9eedc75bd603b2]
stable/7.2: [6d532582ff3c420598f02945b13184c738cc1581]

CVE-2026-89473: power: supply: bq25890: Fix power_supply reference leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89473

Introduced by commit d54bf87 ("power: supply: bq25890: Add support for
having a secondary charger IC") in v6.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [863c32a83e4235eb0cbf6106f2b124e645302156]
stable/6.12: [81b558afda9321c1a70971a39071d156f3e26950]
stable/6.18: [238320ad029a3eedabb86286a28cab55bca629b9]
stable/6.6: [976c10d883a02968f3f58be0cee499d1fd2ba68a]
stable/7.2: [58f1025eca92734eadc063715b98f62538286468]

CVE-2026-89474: power: supply: bq256xx: drain usb_work before freeing
the charger

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89474

Introduced by commit 32e4978 ("power: supply: bq256xx: Introduce the
BQ256XX charger driver") in v5.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2dd6cd823777bea6d9a880a12a92a73ec76aee0b]
stable/5.15: [9dcfdf6c598301b278f0b3490eb2bf4f600524e2]
stable/6.1: [fd08d4dbbec07a44f01b0ddb041912be0dc88f8c]
stable/6.12: [9a467bd1e6811011026ad4c8de701b940d88a00c]
stable/6.18: [9e1aba34df9a87d53460888e05718717c0f69343]
stable/6.6: [2cfb59dc9df8b5ebdd95e3d874a7f4690cee2bc8]
stable/7.2: [c8addb842ae8dcf69c15fc976e33e3bd538a41d7]

CVE-2026-89475: power: supply: bq24257: fix use-after-free on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89475

Introduced by commit 2219a93 ("power_supply: Add TI BQ24257 charger
driver") in v4.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9d34c9d660c3d0931d2cc749c46c47cf31f96e48]
stable/5.15: [9d77fd7dd9a3ad57f7655c5264b503b85adbb7b8]
stable/6.1: [a279e64c907f5638bb34cb8e2c9285798cf5f690]
stable/6.12: [861ec73ce86e2ca18082cc7be4f140a5bbdf1428]
stable/6.18: [f495808cdd6d9576965787cf6d9737d0b0e86b73]
stable/6.6: [6d2eb93975c07b0169a3287efc1ae3b60cf52d8e]
stable/7.2: [47ccbad210f48721c30d69d65b83dc9fff919ca9]

CVE-2026-89476: sctp: fix stream->outcnt underflow on duplicate RECONF responses

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89476

Introduced by commit 11ae76e ("sctp: implement receiver-side
procedures for the Reconf Response Parameter") in v4.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3faf13aff243ca9f78d08b1a2956ef5a6fc77b6e]
stable/5.10: [041f7df5a929d3e7435dd8387e8ea17f2d412b7d]
stable/5.15: [59f61c39cb99ee1737bd742a20094fe5653389bb]
stable/6.1: [793519e343867ee9a3e84f6cac07f81f2aec7b5d]
stable/6.12: [2d867663c563e8009257b9edf9c8ec75d9bbf19a]
stable/6.18: [d02a5794c3deedcb8476d017fcee2b7aaedab2e1]
stable/6.6: [092acd3c55a4077b00489064615d8d2d898daf91]
stable/7.2: [8320cbd81bc21a1ca6ebdf70ad610ebc5ef1bd68]

CVE-2026-89477: sctp: fix NULL deref on untransmitted RECONF completion

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89477

Introduced by commit 8105447 ("sctp: implement receiver-side
procedures for the Outgoing SSN Reset Request Parameter") in
v4.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2db9bfa3e27bdea15e05ea70b56bad3d21e570ec]
stable/5.10: [79ff751311e80fa0370007e46a79a6d601685e75]
stable/5.15: [53141db979687eae7dc6d29414cefc77034f967e]
stable/6.1: [68891125af5a5dfbca728809a16637a869bbe0df]
stable/6.12: [77ea60f2d24002c308f224db44a4542c466489af]
stable/6.18: [25419f516ea84b1e7d3d55aae5215ac86ece0c66]
stable/6.6: [b2d6d873b4dfb5b84194061c4b40a1cd85b92ca4]
stable/7.2: [0ee697defc0594f1da810ed75d9d643fb46f5318]

CVE-2026-89478: sctp: drop a chunk if its transport was removed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89478

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [03a9d10ecf71f54b2af8020935f2033d4a132be5]
stable/5.10: [3fc072e7cb4a0ff251d13cfc2d24f62489cd9386]
stable/5.15: [d7cb5ad832095dc4becfdb2a36007ffd50e49fb0]
stable/6.1: [0422b092a3d43ca462932ff9f747731ca078d1d4]
stable/6.12: [c6c86a5e62a4fec36692ddd64b9144b660f71f96]
stable/6.18: [1035bdef1efb9b1076d1a57b81e08c637ff08ecc]
stable/6.6: [928fd7920ba37cc5637a211b9be979083413a2fa]
stable/7.2: [3537961df2163258bddc230db0e18dc14e925ea6]

CVE-2026-89479: sctp: stop processing a packet once its association is deleted

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89479

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47e15a8d12e366d0d261bcbc394394f44418938d]
stable/5.10: [7d970353eeb98f46a3b9dc602850e4f6336a9889]
stable/5.15: [09c3b193a3e8fe53e1f416e2f8e3283d2a785405]
stable/6.1: [ed85fe91a61bc0e0da6b585c07102b20f4cc65a0]
stable/6.12: [ee3f04cf566f6041aa9a0360494fd8db5ade383a]
stable/6.18: [fa306a40e716c5abcd967475459ce1ebd56e5115]
stable/6.6: [5c0b2dbbdafc9eeeb11fffe1e46551fc3b55d8ee]
stable/7.2: [a713e1b3a265f180ad25a08e17be15d67a2f7149]

CVE-2026-89480: nvme-tcp: reject a read that transferred too few bytes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89480

Introduced by commit 3f2304f ("nvme-tcp: add NVMe over TCP host
driver") in v5.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7fa3f73f6c8ddc5f0425b50fb2a626a782ef7d12]
stable/5.15: [a5c1bb0fb1bab2f24a081339c145870697f6d220]
stable/6.1: [aa107e3a68f4af177d60f2d87679e7f67179a36c]
stable/6.12: [99066cf9bba175f610ceb61a35f6fc9fbc33ff65]
stable/6.18: [8a02ad98798fd01f51f648c1fdd8f3c9d07195d3]
stable/6.6: [fca3ebb63e5c82561cd9934365dcc0d068008006]
stable/7.2: [832a685efeb5d925ee7d30011d2dbe45f81447a3]

CVE-2026-89481: nvme-tcp: fix host memory disclosure on R2T for a read command

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89481

Introduced by commit 3f2304f ("nvme-tcp: add NVMe over TCP host
driver") in v5.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6efbc52237facda35d2d874fe1765bb4839275d8]
stable/6.1: [49a4dcf57608ebf6432dbcb203ed25e7ed581445]
stable/6.12: [a4c3c7310156493797c920b10d8648c07aa05403]
stable/6.18: [3b3d27670c0c890ba7cf1bc3614cab61bde6d25c]
stable/6.6: [bc4013c7cce58d46f792c8c87bc8c8318a70190e]
stable/7.2: [3a0b05145053a5fad1a2ddb4e4d87b07385e63e5]

CVE-2026-89482: nvme-tcp: do not accept C2HData based on
blk_rq_payload_bytes() alone

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89482

Introduced by commit 25e5cb7 ("nvme-tcp: fix possible crash in
write_zeroes processing") in v5.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a4aa9e6ad3e35f8e24d5eaf38ee4d437075fb36]
stable/5.10: [32ea8ce96b9bd797c59c351ce490ffd97adaa8c0]
stable/5.15: [dd8906bb8f8d5bf1c9f861e1382c82b87bfe7cab]
stable/6.1: [7ed0b61bbc145988be292c4d3ec580aebd8d2bcd]
stable/6.12: [b36161701cb366f416afdcf70771d432a7c74753]
stable/6.18: [6a01b58263108eaf9869bb6f82f07709240c6589]
stable/6.6: [b96e1ff75e5c0ad6e077ac002b1d30b0a2b49528]
stable/7.2: [641ad3a30ba560f0a9a610376c568d7b75d2a2aa]

CVE-2026-89483: nvme: zero the discard fallback page

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89483

Introduced by commit 530436c ("nvme: Discard workaround for
non-conformant devices") in v5.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [bededeaaeff404978a5a8e2a605a6c3017cddd3e]
stable/5.10: [76139b5bbf531e675934b97227be3521c7fdd537]
stable/5.15: [3f84d2bd0d8ae8c7e8e0f8fc3cbf018a282971a1]
stable/6.1: [415f2772ebcbc7f3f1ab1a71915dab82cee3465e]
stable/6.12: [dc4d4b70a863f7e39ef8bd137634be4e6db8b084]
stable/6.18: [67551d8430df94c827e1830bd3a5fae1f66a5219]
stable/6.6: [66b5af23b6f956e57f8205c46aa80b054631be34]
stable/7.2: [f5827817b4fc7feeabf4f53fb4b626e6edc52fef]

CVE-2026-89484: lockd: fix NULL dereference on lockowner allocation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89484

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c7fc129db061c7daab841c4f3c342d894832362]
stable/6.12: [07adfbb3de7529f58ca708a97ead7fa4fdb71056]
stable/6.18: [d662f7fc04fde305a27f304b3cd19b614d366839]
stable/7.2: [51af080ca4e553256c59a75a877b9b4fff828311]

CVE-2026-89485: lockd: pin next file across nlm_inspect_file lock-drop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89485

Introduced by commit 01df9c5 ("LOCKD: Fix a deadlock in
nlm_traverse_files()") in v2.6.20.16.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [526c49cff3f72c3ec74752016380c7567040581b]
stable/5.10: [e3c413f789eaf0170275c7eba523ead73d963f30]
stable/5.15: [08a455f87b14c7ff22ae3fdadda62a796a3a5572]
stable/6.1: [550c19222c7132c888e23c9d89079ba1c9bc4cca]
stable/6.12: [c24bdb7df2f34bdc38ca8a73796f5acb40f1830c]
stable/6.18: [41f0a6d31615fcae261bf28a0aa50050dc93a401]
stable/6.6: [350087f231c11efcd288c310707c40eab63ca583]
stable/7.2: [e999a88133654c6dfc68487fb49da5f20dfa2d4f]

CVE-2026-89486: ipmi: Fix use-after-free of cmd_rcvr in _ipmi_destroy_user()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89486

Introduced by commit 9e91f8a ("ipmi:msghandler: Remove srcu for the
ipmi_interfaces list") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [05ec76cfbce653e07cec19b9b8b20e33449d5d87]
stable/6.18: [3088e41292fecf132f85f79af5ee4d620b9ff1b4]
stable/7.2: [5dc0b2a9af95a97861c1bffaf1687a3173e395c5]

CVE-2026-89487: openvswitch: only skb_tx_error() a packet we are about to drop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89487

Introduced by commit 36d5fe6 ("core, nfqueue, openvswitch: Orphan
frags in skb_zerocopy and handle errors") in v3.14.
Introduced by commit f4c50a4 ("xfrm: esp: avoid in-place decrypt on
shared skb frags") in v7.1-rc3.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12
stable/6.18 stable/6.6

Fixed status
mainline: [0dbc2398fca3bb33eda963849f865ddb1b3aa05e]
stable/5.10: [5de5d554141a15b3f1f5c978fd9f7f4fd6d0600a]
stable/5.15: [48db11e115d1b232edc5591604adc6eda95cd545]
stable/6.1: [4477222e2916a18e273edc139c955ade6bbb7a69]
stable/6.12: [6767d70cf46f65807a6a4c4406a518e6c12e36ae]
stable/6.18: [e41a59fc056f63a7a1f42788913c53cc48d744aa]
stable/6.6: [4d5c460ef8754be1d43b16dbf02695b008b207d6]
stable/7.2: [5d85eef222cfd28e73deed7402c100229e8b9e6e]

CVE-2026-89488: openvswitch: Fix CT limit teardown use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89488

Introduced by commit 11efd5c ("openvswitch: Support conntrack zone
limit") in v4.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [403f96c32c9e24600093d7d0c61c17daeedca957]
stable/5.10: [239f26589a6926db28c436e14f28517581ef1385]
stable/5.15: [3b9369881b403f4cdbb11fa998554382bdcc3d8c]
stable/6.1: [3b41d907400cc1dd1da9555b81dca422b1f44433]
stable/6.12: [bf4aaa7ea2579e24ed7de2e20578a875bebca011]
stable/6.18: [e15407c3a8a005324f633cd46cd8fb58042c1157]
stable/6.6: [680f20d5937fa4d1367c59fe83091b78041015f5]
stable/7.2: [6a6d36fadb8537d9b79e72c9fa51885ec0c33e10]

CVE-2026-89489: openrisc: fix arbitrary kernel memory access via
or1k_atomic syscall

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89489

Introduced by commit 9d02a42 ("OpenRISC: Boot code") in v3.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [78004e9a87f240df03e2f73120d291763c32e0a7]
stable/5.10: [bf310718c6fa6adeee06d207a55489546d860e2c]
stable/5.15: [497cba0b02e5555d99fe9ee1dc478af743ab7f7a]
stable/6.1: [1f2e92e499d863f81df1732af59b4a3559969193]
stable/6.12: [a520e8cac54fb403f3800125b606f55fcad42cb9]
stable/6.18: [d64a75369cd0f2ee79afcc9d9ca34a3890989379]
stable/6.6: [574ae2ac2b314aa33498cd2c28add106cbe644f2]
stable/7.2: [b53435c079c78f89f70a62dd5a322cca4e292b34]

CVE-2026-89490: ocfs2: fix readdir position truncation on 32-bit kernels

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89490

Introduced by commit ccd979b ("[PATCH] OCFS2: The Second Oracle
Cluster Filesystem") in v2.6.20.16.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a63308ab426f3a3c7e33b02c150ea59054620261]
stable/5.10: [c28dc3407937aa8f225942538cd585c9b28ea65a]
stable/5.15: [94569154ba49f5f85645d2019c8e206213d8404e]
stable/6.1: [1ae7029823ae4c91664cb32eec7fb8dd5e1a337a]
stable/6.12: [1001fb3b69a11eaa0dc7c7428f6edfa48b88997a]
stable/6.18: [c0c165487a2ea5a37ddcdab4259157b7a527129c]
stable/6.6: [f9dd5cad8d09110ddff2db1fe756aae93c7552ff]
stable/7.2: [b53e2b271eeb6040c2a4a78230c570dc41cdcfa4]

CVE-2026-89491: ocfs2: cluster: don't sleep while holding
o2hb_live_lock in o2hb_region_pin()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89491

Introduced by commit 58a3158 ("ocfs2/cluster: Pin/unpin o2hb regions")
in v2.6.38-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af09df89db9a68a1d76df0f75667998135bc8d65]
stable/5.10: [4d64f8da82fb9e8dbd5aa9b64c9bb6ac0decea03]
stable/5.15: [3b790774280a610f8bdbd5d4260a07345bcf8e04]
stable/6.1: [0cbc2f20a6ea7b4a59efa9171b7c694cdd196507]
stable/6.12: [49002acc520c61002ad195894ac391c94317d3ba]
stable/6.18: [ce035f208d68b812d83e5482980f2b1c88a9cd94]
stable/6.6: [c9be4de77f97f383b750698e1517fd296041f4bb]
stable/7.2: [470212a5eefabcc16b8e2f7fe2844b8737fe571c]

CVE-2026-89492: ocfs2: validate directory-index entry counts when
reading metadata

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89492

Introduced by commit 9b7895e ("ocfs2: Add a name indexed b-tree to
directory inodes") in v2.6.30-rc1.
Introduced by commit 4ed8a6b ("ocfs2: Store dir index records inline")
in v2.6.30-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc70726ddad53c7e9a9a85915bf2415b0d4f42f9]
stable/6.18: [fcfcba8fe17dbf2c8805690b8cc25e32d81249a4]
stable/7.2: [b8a5c0c32df2c5b685ceef76ac77e37c7e1dc3ed]

CVE-2026-89493: ocfs2: validate rl_used against rl_count in refcount
block validator

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89493

Introduced by commit f2c870e ("ocfs2: Add ocfs2_read_refcount_block.")
in v2.6.32-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ca62df6bc0708947b48da3f6a712ecb8e73929c]
stable/5.10: [f882e9e32d017a6569b2996c63ba3864717788e6]
stable/5.15: [5593b63028cb43a6cda75a65ce1db95f00ea6857]
stable/6.1: [c8b02f4ee91e757b3fff556c7168b24b7ae55132]
stable/6.12: [af56e90cb546cb0c47bef059335365283f61d6a4]
stable/6.18: [0761d2c9494424469a0d30a9da3496ca010b0b2d]
stable/6.6: [97584e93fc49a2d59252ac60467e9279f11b1b5b]
stable/7.2: [04ead708e13ddcb9c39319cbe02a18cef99cb823]

CVE-2026-89494: ocfs2: validate lengths in dlm_mig_lockres_handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89494

Introduced by commit 6714d8e ("[PATCH] OCFS2: The Second Oracle
Cluster Filesystem") in v2.6.20.16.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b54e03d9b3697d25f4a0063cf717d459c5e3ad94]
stable/5.10: [4a5798253212093b9ff7d90c6cfbe348bcda1594]
stable/5.15: [dce05b17db862f47ff60614017abe639b2e71cad]
stable/6.1: [0e999d56917f861f97adb961617b1828c9eb4733]
stable/6.12: [f33041906885f96e190cde54e61ddc69de39e3ee]
stable/6.18: [50c4cc9183e11f83427efbf770f54851f4471c02]
stable/6.6: [77686fa5bba135252d348e2dacf481fc19f60c41]
stable/7.2: [a8facb1670b4a0612183198e758d9539ef628ed9]

CVE-2026-89495: ocfs2: bound namelen in dlm_migrate_request_handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89495

Introduced by commit 6714d8e ("[PATCH] OCFS2: The Second Oracle
Cluster Filesystem") in v2.6.20.16.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea5b5609305a8437bc955a0834a530c12246d78f]
stable/5.10: [e1288865b8ceac0dcd1009ecba43de961f13d5bd]
stable/5.15: [aabc5d8388e6f8826345f0073455dbcaaaa6491d]
stable/6.1: [006c96ea488eca2ef5155ec76038e0a4dbf65f0a]
stable/6.12: [f8658ee3327f73bd81c0bcd07cdeb5a8527fac98]
stable/6.18: [de10cd3b062a5235af754925fcf49beb5a1109d4]
stable/6.6: [24989909d3413b44b104102caa6661b1e424ba0f]
stable/7.2: [2487bea2098322669f0563baff53e797486b823f]

CVE-2026-89496: ocfs2: always run deallocs on copy-on-write completion

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89496

Introduced by commit 6f70fa5 ("ocfs2: Add CoW support.") in v2.6.32-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [82ea9d4fc05fb7a387db547c6a7c0aa6a3719616]
stable/5.10: [5ff30f07def6d0e6edacf47952807b5ff60f3af6]
stable/5.15: [2753e12853ed2023555cec2c5fe22fbaabb2c0b7]
stable/6.1: [f0261b3aca027f5c409a402ea22f6982750f911c]
stable/6.12: [123c050eb96aae0bab74c9f06c6ad3de7992722b]
stable/6.18: [71f07b7f90b3109c9098d1b9c8efbbeece5deb8a]
stable/6.6: [a4adaa722977f46511d4247172cd4ec991b80ff2]
stable/7.2: [09e93a60e18e83a630ff84ae00cb564bab96ab1f]

CVE-2026-89497: orangefs: skip leading spaces before parsing client debug masks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89497

Introduced by commit f7be4ee ("Orangefs: kernel client part 4") in v4.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d410cd5303ec59c7cf23dd61423752ce8e9ecb59]
stable/5.10: [173bfd69696815bcf1c052f61cb69c26cca4e443]
stable/5.15: [995f4d05589f87452a56672270af28918c8939c3]
stable/6.1: [0ef38d53bca5ea1375fea0d3d11e9727df064b85]
stable/6.12: [15d79c806231e62a7b746d3b42626810004e1b27]
stable/6.18: [116d14f29a0524853c9316f32a2ac06cff5d4bf6]
stable/6.6: [ce748ae1181d0daf5dd0d2d906d5c1cc328c153b]
stable/7.2: [1774c5b3713add32fe15ab0d3db4b73355f94e35]

CVE-2026-89498: orangefs: fix double-free of trailer_buf on readdir copy failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89498

Introduced by commit 382f458 ("orangefs: rewrite readdir to fix
several bugs") in v4.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f574296be7f46eb60beca851240b526df232f480]
stable/5.10: [712c4235fcc73c11a2f1d59a499d489e49c374a4]
stable/5.15: [433c2e470053cc9c712314d3d8c3dfbc862d68eb]
stable/6.1: [6e5924644ef4bce06a3cbb7cb841a8bbfdfc03ad]
stable/6.12: [2f5454a25127854c232fde5d1d65d16fbcd42d43]
stable/6.18: [f796f38a324e89547738f4b70cc33be5be2bc6da]
stable/6.6: [9c9eacc47c618ed6d7d35fe75a40d294c8cdbffa]
stable/7.2: [519f4146b8b8c5f20c2ad01913acd6df2df8fc8e]

CVE-2026-89499: ring-buffer: Stop remote reader update when page swap fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89499

Introduced by commit 2e67fab ("ring-buffer: Introduce ring-buffer
remotes") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5eab74874d11160725c42ab676ba97a797a362eb]
stable/7.2: [a14a97048e48471e283d76879b83d2ae323e0722]

CVE-2026-89500: ring-buffer: Make cpu_buffer::free_page a buffer_data_read_page

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89500

Introduced by commit 8e7b58c ("ring-buffer: Just update the subbuffers
when changing their allocation order") in v6.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7a1fb95de5404134f8758c1295ce88986bdf117c]
stable/6.18: [a1dabe68fb53730bc0be60c5dbfd3f4c560084e7]
stable/7.2: [d787d509bdf6c88c85e095247daf7456cb7fb772]

CVE-2026-89501: ring-buffer: Hold cpu_buffer::lock when resizing a subbuf

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89501

Introduced by commit 8e7b58c ("ring-buffer: Just update the subbuffers
when changing their allocation order") in v6.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [24974bd0da1b47fd56c975533ead50abf754e74d]
stable/6.12: [8a496aaa3da6e8d545896c2370c7e617cc931ae2]
stable/6.18: [6fcb0b745a0b80df62eae4a93ce52a2d061f4ac2]
stable/7.2: [bf242baf58de03467f226c8e29554c9495dca7fc]

CVE-2026-89502: ring-buffer: Free cpu_buffer::free_page with subbuf_order

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89502

Introduced by commit f9b94da ("ring-buffer: Set new size of the ring
buffer sub page") in v6.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [234b1a72e9706fe20c08c96f4374ec8e83b934cb]
stable/6.12: [77275ccea06eaf297e8e6ac3fc830cb72086379a]
stable/6.18: [8c1ecdcdea738efe0494af908f12c0ae3a97fffa]
stable/7.2: [81063bbb16c4fcf0136c9117d5e49d3621dd6a1e]

CVE-2026-89503: ring-buffer: Fix subbuf resize race with
ring_buffer_alloc_read_page()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89503

Introduced by commit bce761d ("ring-buffer: Read and write to ring
buffers with custom sub buffer size") in v6.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e743527c5bfdceda1095bc0a9e596e2aebb6a9c3]
stable/6.18: [2dc510957fe8fd098ab3c3147ebdf34d00cd2734]
stable/7.2: [53106e9262a310ef2c9a9321168c03705940c678]

CVE-2026-89504: regulator: as3722_get_regulator_dt_data: fix premature
of_node_put leaving dangling of_node pointer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89504

Introduced by commit bc40733 ("regulator: as3722: add regulator driver
for AMS AS3722") in v3.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9324d670ae0b88cbfb0aa48fcaefa5baeb8da4c]
stable/5.10: [d9b1407477fb736978b04108073180ca84958936]
stable/5.15: [bd5606e9da1a01a61c7d2f5df36243414a0142be]
stable/6.1: [0bde4f140e90f87ebd49cd9c884c4bb3f19fe931]
stable/6.12: [d3c1316d84e0a036890b00ae6e4c0b0b80f70c25]
stable/6.18: [95342d26f9c6b68a46ab57fa48428a3c4a423dd7]
stable/6.6: [eda08b6bd64f01ca9defbfcc9e0c3e30f46cfc02]
stable/7.2: [8648e29e5c01b6b677c704049189287e27255ccb]

CVE-2026-89505: RDMA/uverbs: Guard legacy bundles without method_elm

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89505

Introduced by commit 7122ff9 ("RDMA/core: Do not read wild stack
memory in uverbs_get_handler_fn()") in v7.1-rc5.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [60a42d510113f46de47e86a84bf5758597644487]
stable/7.2: [edae84e5461749ed9adf9fcf5c6e075381040ac3]

CVE-2026-89506: RDMA/uverbs: Add UVERBS_ATTR_UHW to UVERBS_METHOD_REG_MR

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89506

Introduced by commit 5b2e450 ("IB/core: Add UVERBS_METHOD_REG_MR on
the MR object") in v6.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [011199f46f44a9fd93a9e5ab5d7fd1328d80e9bf]
stable/6.18: [71d5c41ac583df09a7c32199bef7d42de7267d07]
stable/7.2: [9e71d0f4944ba5641e01db29b3256c963656d671]

CVE-2026-89507: RDMA/ucma: Lock the handler in ucma_write_cm_event()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89507

Introduced by commit a3c9d0f ("RDMA/ucma: Support write an event into
a CM") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f4cc21c6a8e9d392871477f9fd98d68e5ad80272]
stable/6.18: [4f8bb11dd2ff365e7cff1c9964ab4607292d364e]
stable/7.2: [0be1955040a2eceed0ecfc387fdc92305411d273]

CVE-2026-89508: RDMA/ucma: Lock the handler in ucma_set_ib_path()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89508

Introduced by commit 09e328e ("RDMA/ucma: Fix the locking of
ctx->file") in v5.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ecbe7d36dc2de07e5dfbb4a8ff5b315ab43de820]
stable/5.10: [3dd07b369371a2f29e1c3caf1ade85bb92b4c551]
stable/5.15: [b2da0d488a1c72956ebb0a57015ee8ee6a2f7748]
stable/6.1: [a7f8d26e653ee43b0b572984b8ec544d3b3b6f3c]
stable/6.12: [764586f8f6180084c5a7d622120f526acc6ce0c9]
stable/6.18: [28ac2dd416482d1c763c4af5d61af465b387fb50]
stable/6.6: [71dc206f2e2a645dac78879768762451aa1799f7]
stable/7.2: [43a7d8ae9f645dc00235cfa4bf57673c20b769f8]

CVE-2026-89509: RDMA/ionic: Embed counter driver data in rdma_counter allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89509

Introduced by commit ea4c399 ("RDMA/ionic: Implement device stats
ops") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf3ebd89e754015625fee90aa938f6bc79a2c974]
stable/6.18: [c98197ee3cd28288da13dc9881bb9e74daa7cbbc]
stable/7.2: [08b8630b557828aedb1d9ef0a6e2ec421f334ee2]

CVE-2026-89510: RDMA/cxgb4: Cancel reg_work before freeing device on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89510

Introduced by commit 1c8f1da ("iw_cxgb4: Fix possible circular
dependency locking warning") in v4.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a7100601aa1a39f799a566acce10db20eaf4b7f2]
stable/5.10: [e6e79e7be87c5ea92728060a3d7fb56890a91e45]
stable/5.15: [672ee1981db10569ec96030bddb322f18382ec04]
stable/6.1: [4681e731db07769846901cfabdd3e53f765eb9d3]
stable/6.12: [fe9c591026c576d8b1f72aab5e4cd67350530763]
stable/6.18: [85f438382a865a4dc4c50e6b884310bb2b60fc4d]
stable/6.6: [3265d558dfafab8f12f5fba06ebbf15cae9f3225]
stable/7.2: [320e5258a53af0abc5abd9eb01519a48bab2dee8]

CVE-2026-89511: qede: Fix NULL pointer dereference in TPA fragment processing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89511

Introduced by commit 8a86339 ("qede: Add build_skb() support.") in v4.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [06aa3d26327f24edd039ff249672fdf6f2ba5695]
stable/5.10: [e2214e2793154b745436e46c6a9a7985d9b3781d]
stable/5.15: [dd8bc0a9d87d2b048711edd17ba7286432edd285]
stable/6.1: [fa7c9bd2c4a8de167e2fb32968ca4d91dd774375]
stable/6.12: [7f911e208b3ca2c76d9f2bbba1f54b9403568c10]
stable/6.18: [2a952fb1b20d83e83ca852773e6188511f7d2191]
stable/6.6: [a5e1fdc126ab337d601d1a00cc4b47910679d005]
stable/7.2: [f5c8619ccbd70102642120c4c6fda1c048a555fd]

CVE-2026-89512: remoteproc: scp: Fix device reference leak on failed lookup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89512

Introduced by commit 63c13d6 ("remoteproc/mediatek: add SCP support
for mt8183") in v5.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [22f9efb3ae07f966a1901d929d16df1388cce65c]
stable/5.10: [f1c9512ae072996647fb829c6402348d1b72af39]
stable/5.15: [d6ef9060775483bcf57291cbacbc0fe89b5857da]
stable/6.1: [554689ff2d7561d91011e69a8bfcef1b71901b2b]
stable/6.12: [f794c930d8238e370fd61fcb12cc301ae098231b]
stable/6.18: [c7e32814a6bf20f792d05f0bc9f94f0606311bc6]
stable/6.6: [6ca338cf2d386fd701b2dc27a2cd4c067a45d545]
stable/7.2: [440bcb0948a12c9104b6dcca99a2cfb0db49b22a]

CVE-2026-89513: RISC-V: KVM: Fix PMU event info array size overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89513

Introduced by commit e309fd1 ("RISC-V: KVM: Implement get event info
function") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [735bc20c24187ca419c9d5e63860a54b91be34bd]
stable/7.2: [82088f88c96b99c27a974d09b02c2b133262fadf]

CVE-2026-89514: scsi: fnic: Use GFP_ATOMIC for VLAN alloc under spinlock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89514

Introduced by commit 098585a ("scsi: fnic: Add and integrate support
for FIP") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9639c6324524ea3f934908bd51f02430000954ab]
stable/6.18: [c4ade059aaeb51fdb3f4ae71e1ea3e2019b85178]
stable/7.2: [d86f65aed01408613607f8fc31493f07554788f2]

CVE-2026-89515: scsi: core: Fill in DMA padding bytes in scsi_alloc_sgtables()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89515

Introduced by commit 40b01b9 ("block: update bio according to DMA
alignment padding") in v2.6.25-rc3.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [626147717bea776b61ed3631d2c26283760c4cc4]
stable/5.10: [1aa6df61cef1f47f503c3ccf60d08c4dd931fdc1]
stable/5.15: [6da140ebdfdd6aa3773945f2c0ebba01d2ef33d8]
stable/6.1: [fd2cbe08c6ccba7fc1ddb830653a93bb7e2d833c]
stable/6.12: [a4353ec7742bdf87dcdde5875270feb3a1982a51]
stable/6.18: [e7143c3f4e5c0a7986733c6f27009274bf6c4264]
stable/6.6: [28ed5343666ff424ce5e248fa1c5a402303b4aff]
stable/7.2: [6fd1cce5018fdcc8d928e00a6a1dd2997d5b9409]

CVE-2026-89516: sched_ext: Don't BUG_ON a destroyed DSQ in
process_deferred_reenq_users

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89516

Introduced by commit 84b1a0e ("sched_ext: Implement
scx_bpf_dsq_reenq() for user DSQs") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8d8dd8ae89eaa78b37fc85528e926029f5facbdf]
stable/7.2: [c480961a1e790b46ffd8c20c4b6754d65ec6572d]

CVE-2026-89517: sched_ext: Fix rq->core_pick corruption under core scheduling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89517

Introduced by commit 4c95380 ("sched/ext: Fold balance_scx() into
pick_task_scx()") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d954004205c1a1d3f59ce8482b559266c15600fa]
stable/7.2: [cdafb68155bee2d5c4e50c12e4606323e9334e6b]

CVE-2026-89518: sched_ext: Fix this_rq() assumptions in dispatch kfuncs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89518

Introduced by commit 4c95380 ("sched/ext: Fold balance_scx() into
pick_task_scx()") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3dd52416e44a70bc993adb96d2e0d71b9ea21359]
stable/7.2: [6d1890d3c6137ab523799765ae2de62cc05f116d]

CVE-2026-89519: sched_ext: Replace SCX_RQ_BAL_KEEP with a dispatch
verdict return

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89519

Introduced by commit 4c95380 ("sched/ext: Fold balance_scx() into
pick_task_scx()") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ffaab58d217581cb75353168f8812a16e10463fc]
stable/7.2: [6f1d3bfe54430f8d54e0530a27f2ecbf8466576e]

CVE-2026-89520: sched/core: Make core-sched flips wait for in-flight selections

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89520

Introduced by commit 539f651 ("sched: Add core wide task selection and
scheduling") in v5.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f3629c63a4af3e491381780bc6c123cb498c4c40]
stable/6.18: [9d69422ddaa13526c2223444e237d948d6e44728]
stable/7.2: [23eda24f325a6e6d686d30ec75f2e9d6745e2015]

CVE-2026-89521: sched/core: Handle pick_task() releasing the rq lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89521

Introduced by commit 4c95380 ("sched/ext: Fold balance_scx() into
pick_task_scx()") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c10b216a072ff5c57bc880a05f87eb519aecc529]
stable/7.2: [88ed5a66467ca2a5148b9997af9c71d8c43060ad]

CVE-2026-89522: media: staging/ipu7: fix async notifier UAF on probe error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89522

Introduced by commit a516d36 ("media: staging/ipu7: add IPU7 input
system device driver") in v6.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d7f48aa7d60c65d3e6d5312c27f17d5525a245fb]
stable/6.18: [2a8dd9fd12f3f6b21207cec8f50c92cd428e6b81]
stable/7.2: [323c411fb63122e8cef5b833032d69d59a838559]

CVE-2026-89523: wifi: mt76: mt7925: cancel pending mlo_pm_work

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89523

Introduced by commit 276a568 ("wifi: mt76: mt7925: update the
power-saving flow") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2889e84282dda147f10b10d94cf0efd90a349c53]
stable/6.18: [5be6d02837d418bc6c805b5cab1b338de6de9ca7]
stable/7.2: [c5e073f2fbfd34d22099a50d96f60990799753e2]

CVE-2026-89524: wifi: ath6kl: clamp assoc request/response lengths
before subtracting IE offsets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89524

Introduced by commit bdcd817 ("Add ath6kl cleaned up driver") in v3.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3bbd05723d15dd06f0560bcd94fbf9a91b5f5613]
stable/5.10: [225587bdbf4b0eb5265a71ee4dc183561a1857fc]
stable/5.15: [d337213a889705a69735079606d0b4c672b17605]
stable/6.1: [e11d5ae96d5e52cb48fa27c6ad352d766d0322fb]
stable/6.12: [e3619bed5da125713b29ac881dc66f5e06606f88]
stable/6.18: [e1330d719c047c4d8190a16be034b29fc601a815]
stable/6.6: [6deb4d7a0c3d91821b2a8d5239e3d9933d9217d9]
stable/7.2: [8eb73016fb3968cf2db3987a92764563a3af773a]

CVE-2026-89525: udf: reject VAT indexes equal to the entry count

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89525

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cac0cb07f29ccfb373fd4a36c81e908ef3ce608c]
stable/5.10: [f64e01a90326bb85a3cc8aa0199931dc2f15b589]
stable/5.15: [8a8c1c42a34349a0626d910abbad5a29136446b7]
stable/6.1: [19f36c6453cd88fe6d60ef36ab1f1cad8ddf4ce4]
stable/6.12: [9193368408d792cec2057628d87862140fb1ce1c]
stable/6.18: [b95c33a4e743874f1b0a45bf2aaa4da553552bd1]
stable/6.6: [b77b83f5529a26d084d64ece98abd6f0cc86e053]
stable/7.2: [1bd7947f1463c21edafa256d0fbec5b99215e2b6]

CVE-2026-89526: svcrdma: Validate Read chunk positions before reconstruction

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89526

Introduced by commit d96962e ("svcrdma: Use the new parsed chunk list
when pulling Read chunks") in v5.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3779b7b9e7d1c8ba4738f9d327de3b0288cefe9b]
stable/6.12: [5ab3f6d882fe07ae5e61d0bcfeea00b9409155c2]
stable/6.18: [f84ec84d8d4bc65f9ae23372570349687f66fa39]
stable/7.2: [577097455d084610fc31e91e6a61c5793b6f04ba]

CVE-2026-89527: svcrdma: Use svc_xprt_put to free listener on create failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89527

Introduced by commit 4fb8518 ("sunrpc: Tag svc_xprt with net") in v2.6.37-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e346ef7bcb137f50c49f969330ab7dcf64ea1654]
stable/7.2: [ac1dd6002f758ab7dd3e737757e5a1bb1c0b38d6]

CVE-2026-89528: svcrdma: Reject Read lists that exceed the page budget

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89528

Introduced by commit 026d958 ("svcrdma: Add recvfrom helpers to
svc_rdma_rw.c") in v4.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ca487abb3bdf581851664b5db21f364caf57682]
stable/6.18: [1a3af2262cb384112ef38632de4690682be528b4]
stable/7.2: [465f511f59a0fa7a80d5d1073c4b24f28ea38f58]

CVE-2026-89529: svcrdma: Reject oversized Read segments at decode time

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89529

Introduced by commit 5ee62b4 ("svcrdma: use bvec-based RDMA read/write
API") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af6f0e06bed818ee7fc8b869915964410020a1c5]
stable/6.18: [59bcf1b38f89879e0a41aecb152f1b076c4b6ac6]
stable/7.2: [5120fe54e0e2f5b62797a432115cc61d61117a5b]

CVE-2026-89530: svcrdma: Reject inline replies that overflow the pull-up buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89530

Introduced by commit e248aa7 ("svcrdma: Remove max_sge check at
connect time") in v5.0-rc6.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [0fbe20dfe74b783d255bf389a6ea77aa25dc7860]
stable/6.12: [fcd91b9957462d398792201c239dffaeff1cc8b2]
stable/6.18: [1949dd1576f7a8aa161b1330c6125df9d53046d5]
stable/7.2: [8ec60eb51fae37cd3d334ff26e4a7d6fb21ff7cf]

CVE-2026-89531: svcrdma: Reject connection when transport allocation fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89531

Introduced by commit 377f9b2 ("rdma: SVCRDMA Core Transport Services")
in v2.6.25-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0944462247dcb7de7622cdaaadf5f05c52707dab]
stable/6.12: [6e21754bbf75075f3fee1cebc79f3417364235ec]
stable/6.18: [3cf372cec7ab2cd8c6002bf775cc14d90ccb098b]
stable/7.2: [1f6a14c142fee4778c32709d1d54595c2e2b7991]

CVE-2026-89532: svcrdma: Fix pcl_for_each_segment for empty chunks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89532

Introduced by commit 78147ca ("svcrdma: Add a "parsed chunk list" data
structure") in v5.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b7713a784c59515d0aba558c8f5df6a0164dd3a9]
stable/5.15: [1e2e3481e39103a386b86be1c33eaef97cbdf16e]
stable/6.1: [3a78b841879c2a3243f74edc514236fb2907167f]
stable/6.12: [9c5a03c3dc505c0295339b0a1b9e4fe36447e482]
stable/6.18: [a1c954ca4977a4e6ec73ef92fe48073ec54f9fc8]
stable/6.6: [06d0390c37fa6714624af771bd72bbf1a7ed9bb1]
stable/7.2: [6d33a7e6bf6c6b293a266a617201285a1ad32c56]

CVE-2026-89533: svcrdma: Fix offset arithmetic in read_chunk_range

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89533

Introduced by commit d7cc739 ("svcrdma: support multiple Read chunks
per RPC") in v5.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a44c140cc2f3643a39e258bb0c0ab9d0f494f5e]
stable/5.15: [10873311f91db9454e2fadbf9866bc819e0646d9]
stable/6.1: [addbf02dfe3b25e7e38e03bbd4e2a6ed86a14be7]
stable/6.12: [6ee4dc7476b3abc92ec1d444533a559f33f59561]
stable/6.18: [a46b35f213c2426f5d6a0458a8f7e873fc59cdfd]
stable/6.6: [cba8543c18cf42fd80fd63effb6df6ff4f7e73ce]
stable/7.2: [4493c96bbd0068fadf69cbae8d13426202e34cdc]

CVE-2026-89534: svcrdma: Clear sc_cm_id when ADDR_CHANGE replacement fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89534

Introduced by commit d1b586e ("svcrdma: Handle ADDR_CHANGE CM event
properly") in v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01500306e1d50de7ca7a2cdcdfa28ac0523eb747]
stable/7.2: [673e358ab7c11f8cec223c6a36a793056a67facd]

CVE-2026-89535: svcrdma: Reorder rpcrdma_rn_unregister before rdma_destroy_id

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89535

Introduced by commit c4de97f ("svcrdma: Handle device removal outside
of the CM event handler") in v6.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4488e912973773d64368828acf3b8e39d93650ae]
stable/6.18: [9f2f5d0999364c7070306cd422d8babc2621070d]
stable/7.2: [cfca6eb3345ba4a23cf9a1153ad09bf19faabfc9]

CVE-2026-89536: SUNRPC: wait for in-flight client TLS handshake callback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89536

Introduced by commit 75eb6af ("SUNRPC: Add a TCP-with-TLS RPC
transport class") in v6.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a89dd597458848b463d284b15e42a8078beeb046]
stable/6.12: [15431820f448e09f8029b670d5c82aa5917d4625]
stable/6.18: [1de391e8b94e31b45c19c16dbf315e294810c7de]
stable/6.6: [fb43997407bc17ee39bac81ab708101312e255f5]
stable/7.2: [7fbb6d2ab0391eb8d1f1a68e6bc263ef02cea61b]

CVE-2026-89537: SUNRPC: Reject short RFC 4121 MIC tokens in
gss_krb5_verify_mic_v2

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89537

Introduced by commit de9c17e ("gss_krb5: add support for new token
formats in rfc4121") in v2.6.35-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b94f6719dcd9f7a609bc5f459f85795900e77d25]
stable/7.2: [7a946b2e7207f968902f2147ab9b30726f82f7ab]

CVE-2026-89538: SUNRPC: Reject krb5 v2 wrap tokens with oversized ec field

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89538

Introduced by commit cf4c024 ("sunrpc: trim off EC bytes in GSSAPI v2
unwrap") in v3.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ad484748eec0a66eac0f13ab53b3fbedb7333c91]
stable/5.10: [ac9efc29346b6942e71f0e24a3178a9121330fab]
stable/5.15: [b5746095b59f4d11f39f08751d36bbdfd1e5deac]
stable/6.1: [9fc6d6e6db49ab55208d5dd1c424c1d0d9aa7296]
stable/6.12: [dfcd81ab45613d45996fbf483d4ef54b0ec90ab9]
stable/6.18: [1f9856af065b6158271687e9788407b9573fd16f]
stable/6.6: [4abb44a29bb515df6f49123848765c70fc9b5021]
stable/7.2: [880effc943ed82d6811f272ed3307c222b40f4d6]

CVE-2026-89539: SUNRPC: reject duplicate CREDS_VALUE options

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89539

Introduced by commit 1d65833 ("SUNRPC: Add RPC based upcall mechanism
for RPCGSS auth") in v3.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2e4ce62385c1b8a887c5370af058ac7b52a8eaf9]
stable/6.12: [f615b884310bf82d0014e3b5a92eb9aa88146685]
stable/6.18: [7a1d0501cbb962beba23377035d667bf3c1726ee]
stable/7.2: [9d94f046b23de0f77849ea69133063c949297e30]

CVE-2026-89540: sunrpc: init gssp_lock before publishing proc entry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89540

Introduced by commit 030d794 ("SUNRPC: Use gssproxy upcall for server
RPCGSS authentication.") in v3.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ce1ed6159731a41fdd0b03eedbed4e147036a5a]
stable/5.10: [159a4fab7170badd6c4a553aef81cac079d6f4ee]
stable/5.15: [b3526ae3351968f6726bcbe25d8d09973ad79109]
stable/6.1: [7f5bcdc8da15077ebe846c2756a5a17741021410]
stable/6.12: [f15b87521168c2a92cb1931f532cba422f856f01]
stable/6.18: [edeefb111d6181a4aa278f415b005efe284b9489]
stable/6.6: [89c8e0733e8c46b7973503f15b1b31a8587d8030]
stable/7.2: [3f019571928b269feebcff59926ec13294215e0e]

CVE-2026-89541: SUNRPC: harden gss_unwrap_resp_priv length checks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89541

Introduced by commit 2d2da60 ("RPCSEC_GSS: client-side privacy
support") in v2.6.20.16.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87831b92112c81db251d46756d65daa4f91af6a2]
stable/5.10: [3691c4b3488d8ca046b9941e5be30c626dbbbb50]
stable/5.15: [85fa6b12e8f439739ac36ef2aad925f37c8b976a]
stable/6.1: [401f6a5b338d05bb1069ad814d9f77e3c367854f]
stable/6.12: [89a15a50f84d32d4b99db86f957427fcbe20a99a]
stable/6.18: [ebcbd2523a8524c3d24e111cdbed8e271d910269]
stable/6.6: [81fd7654a8429718adfcb2a7e03496077f547ed0]
stable/7.2: [d395c30d570ca6168f0297b191709927d1258273]

CVE-2026-89542: SUNRPC: harden gss_krb5_unwrap_v2 against short tokens

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89542

Introduced by commit de9c17e ("gss_krb5: add support for new token
formats in rfc4121") in v2.6.35-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6959297aaa9572783d620a226d73c3fb94494888]
stable/5.10: [299d281c7225ded15b28cb861a98d818d82787fc]
stable/5.15: [84ddbc8d084c0251d534f14f5d1a7da05be56404]
stable/6.1: [075d7cfc4df8c54cb202ba8b28420370c03ba9b6]
stable/6.12: [dddcb0f4b7e27fac16a78ea9a1c8ec2e8a241087]
stable/6.18: [806584a4b67a7233870c33e5b8f872e76dd02988]
stable/6.6: [f2591660e0eb263c9415bf0d0bb1b111e62df7a4]
stable/7.2: [a7894e10572d53eb10109b8d07459cc8d3435811]

CVE-2026-89543: sunrpc: fix use-after-free in __rpc_clnt_handle_event
and __rpc_clnt_remove_pipedir

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89543

Introduced by commit bfca5fb ("SUNRPC: Fix RPC client cleaned up the
freed pipefs dentries") in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [932a8cf6abb2b2f8677b79153a823108d8861fe2]
stable/6.18: [e769fcde3cc73e847b1eb3acd40c04a291cb0c0c]
stable/7.2: [cdf7a233cb94774b0e7df42d9157077983f5022c]

CVE-2026-89544: SUNRPC: fix gssx_dec_option_array error path bugs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89544

Introduced by commit 3cfcfc1 ("SUNRPC: fix some memleaks in
gssx_dec_option_array") in v6.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [5e9a94539b1ec17a89177d952badfd0d844d694a]
stable/6.18: [3ff45361e9469e85c0f86b8e7b82c63e50bab8ef]
stable/7.2: [f85a83774d7f4e2ac71c0c384df0dfb6f7d0179a]

CVE-2026-89545: sunrpc: defer rq_argp and rq_resp free until after RCU
grace period

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89545

Introduced by commit 8124438 ("sunrpc: add a rcu_head to svc_rqst and
use kfree_rcu to free it") in v3.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c479bde671cbe2f9e152834a8b0eb7c3c295bbaf]
stable/6.18: [08bc49e0541260bf294962cf889a32a2d2713ad6]
stable/7.2: [e0c5693d3f9a5d4911735ab0e0eba4eecb1f1090]

CVE-2026-89546: SUNRPC: close backchannel before destroying callback service

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89546

Introduced by commit 441244d ("SUNRPC: cleanup common code in
backchannel request") in v6.19-rc1.
Introduced by commit 9e9fdd0 ("NFSv4.1: protect destroying and
nullifying bc_serv structure") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3674f780f47d2906b5a0f7199b66973067bdfeca]
stable/7.2: [6debde9e3e6ae21dcca75837b4247b13ca4ea2b8]

CVE-2026-89547: SUNRPC: Check svc pool percpu counter allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89547

Introduced by commit ccf08be ("SUNRPC: Replace pool stats with per-CPU
variables") in v6.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [43e11e164704dde975c9edb370de1a06bec67270]
stable/6.12: [3a2b7649de76376a69f1d3ed2a539fb15907cd4d]
stable/6.18: [bd1ef2cfb44d72b7aa6943e87b206eb0e30fbd0c]
stable/6.6: [57ac7d899409b0a9b768cf417e3bb86bcca3d4c6]
stable/7.2: [b541a15046976e481618726cc23db0fb22d576db]

CVE-2026-89548: SUNRPC: always drain cache_cleaner before destroying a
cache_detail

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89548

Introduced by commit 820f944 ("SUNRPC: split cache creation and PipeFS
registration") in v3.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f42d0fda0c67695db6bc704b04b7c10240805377]
stable/5.10: [dec787a15c96a5665e9ffc61b429a6a4ab26e6b9]
stable/5.15: [5eea874a696201c31e7c2d7badbfa0d90e9961b5]
stable/6.1: [cf239de7fdcc8336259b01ea4bcf650dadad1040]
stable/6.12: [9d44836f60c8c29bcdb1471fd9202387c642a890]
stable/6.18: [2e861ce2aaa468351a6a47c4cbb4971ebb740c7b]
stable/6.6: [6d74ecc2be120a0c300b224b7649fe93c0453714]
stable/7.2: [3d60fdf951143d6ef4e352e2f8eb852286701726]

CVE-2026-89549: sunrpc: route to a populated pool in svc_pool_for_cpu()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89549

Introduced by commit bfd2416 ("[PATCH] knfsd: make rpc threads pools
numa aware") in v2.6.20.16.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f6310491c4cdb88af73aa551ec9df1f10a90c709]
stable/5.10: [9accc25e5af0bac8479f6054e674b2c593c45281]
stable/5.15: [6f66d38e2a6c78d48723ea17ad86135ec80ca24b]
stable/6.1: [d79d7b9e8acbb53e2d60f6b24afc13e2f15e691f]
stable/6.12: [011479cf9a7657d4a3e7cc42a784ac63df594170]
stable/6.18: [9d04d64ad192439835ed9884d767353061c3ed6f]
stable/6.6: [edb20e8c03aebacb409968c99d046f509c6c485a]
stable/7.2: [8f766d2d0b4dabf54f8b35812df2b4f481d13316]

CVE-2026-89550: SUNRPC: svcauth_gss: enforce krb5 token minimum length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89550

Introduced by commit 7c9fdcf ("[PATCH] knfsd: svcrpc: gss: server-side
implementation of rpcsec_gss privacy") in v2.6.20.16.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a919c5c88769cf8fb3ec071e6078d830bf512489]
stable/6.12: [dd6afc6cab8c5d387d1ed2f069562ef7bdadd651]
stable/6.18: [de942dd8c2c8358bcad04ce44271954c48924423]
stable/6.6: [0ea5b0c7f212c2772d32c2b88287b89a9cdf6edd]
stable/7.2: [2eed1e6a976a44015c3ee78841fe336796e2b21c]

CVE-2026-89551: SUNRPC: xdr_buf_trim: clamp buf->len to avoid underflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89551

Introduced by commit 4c190e2 ("sunrpc: trim off trailing checksum
before returning decrypted or integrity authenticated buffer") in
v3.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f491306dcb673ff5e78e1044ba450c58978774e]
stable/5.10: [a3d77bcd974b8625d16bddf448cb3a1b5e37049c]
stable/5.15: [fa16bbe987b47e771e52eeb1b4540f18d92496ac]
stable/6.1: [a924ac4c78afab71bf82641afa3b62e0c4a8b55e]
stable/6.12: [e6267cccd7b05cc514e57f2160aa8db85f5c2701]
stable/6.18: [ad0cce80d4af2f74674e8b635d97aa3880e83da8]
stable/6.6: [4bf59cb0ea5b0ddfbc46a1dc2fa78fc8b9986ce4]
stable/7.2: [85e9602650e9df07190abe817cee3b4d9bc3df17]

CVE-2026-89552: params: fix charp corruption on allocation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89552

Introduced by commit e180a6b ("param: fix charp parameters set via
sysfs") in v2.6.30-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3dfaae04243cde460d82dfc2a7dd0bb6664d20ae]
stable/6.12: [614f873268c5b172804c9af6639bd17b7e1e2359]
stable/6.18: [704ecd010d4a9b33160e40b74eb402f6b86a18e0]
stable/7.2: [0d8e2404925a0607ffec79a53170715a46936896]

CVE-2026-89553: nouveau/gem: reserve the bo in the info ioctl around
the vma lookup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89553

Introduced by commit e758a31 ("drm/nouveau: fixup gem_info ioctl to
return client-specific bo virtual") in v3.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5e17160d41d92823f3379c1982e1369680c5ce4d]
stable/6.12: [208867763843aa82efcbe3b771f1b8e6c7aa820a]
stable/6.18: [ff110e85837d7ecd83f36078107be240ff5ae409]
stable/6.6: [e05c28bd6043d0fd0bea9c3fc49300a8871a1a81]
stable/7.2: [e60466011ac3a6b8045e6cc3c2cbb30d58039d2e]

CVE-2026-89554: mptcp: fix uninitialized local_id in syncookie MP_JOIN
reconstruction

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89554

Introduced by commit 9466a1c ("mptcp: enable JOIN requests even if
cookies are in use") in v5.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b878dfdd12d7a5b8722a78d35e313506140ca3d9]
stable/5.10: [4534e0eead692bb069ad1e6a5a245fc2e2078300]
stable/5.15: [63cacb05e51a1c6e1349d2e593d00fd6ef43def4]
stable/6.1: [954b5ea836eb118d188975ced803448537ab8479]
stable/6.12: [64f2c5dd49b956a542c8c02b8dad5d262a462bba]
stable/6.18: [51887ccd88791ddaa8755a7c614fda031ecf7982]
stable/6.6: [9df36a4846375a9b75bf42d77bfed216b0f366f9]
stable/7.2: [bf19d166337c6488b39cb03eeeffb30a941d6326]

CVE-2026-89555: mpls: reload header after pskb_may_pull()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89555

Introduced by commit 9f427a0 ("net: mpls: Fix multipath selection for
LSR use case") in v4.10-rc6.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [29e63b8d9fc150cc191b1c6eb7e16e1247e1b650]
stable/5.10: [aa4fe0b450a461aa1162fe8375f5d28f4c957df8]
stable/5.15: [b1c0783b2facc398437ad8f8b86c636d7a78f8db]
stable/6.1: [bfaaff99238326166694354a63a76c02563f98b1]
stable/6.12: [fed638a248116b8a249bd4202d28e5934bdc65ad]
stable/6.18: [d82b90a38c2ca8a0694428eab0e9551c23f2447d]
stable/6.6: [d9640239827d6d0cb84263b590f7a4f1596c17eb]
stable/7.2: [49d38c1b4390412f8950d33dfaee0ccbd17beb81]

CVE-2026-89556: module: validate string table section types

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89556

According to the .vulnerable file, this bug was introduced by commit
c92aab8 in v6.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9a5ff45689329835f874cefe5174e577d141d423]
stable/6.18: [50d0aa7d25ba4bc3606f150cd69755068e79f97f]
stable/7.2: [e4496dda2c6d0acf7ba5fbce14a2723a8935ceee]

CVE-2026-89557: md: do overflow check for sb->bblog_shift in super_1_load()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89557

Introduced by commit 2699b67 ("md: load/store badblock list from v1.x
metadata") in v3.1-rc1.
Introduced by commit 1726c77 ("badblocks: improve badblocks_set() for
multiple ranges handling") in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [35d522bd32462afcf1981dab6da8a9256c26c1e0]
stable/5.10: [94c820d99a4305d4ded41a97ed37ec7d26c56e7f]
stable/5.15: [573fb68105fdc6a127ba6069e58a0d2aff3c9f93]
stable/6.1: [323f3a056dbccb39a642ebde642044a680f3a6d6]
stable/6.12: [75d15738fd33a782606d0dc80cfeff47edf2ddd8]
stable/6.18: [3b097416b4cff77285c1f472fc2c4058d8a7554f]
stable/6.6: [0a03f9541c06fda64301dcf94f376f07ce2cc396]
stable/7.2: [df7d4d011d5ace20699ea948712f09f9ac08924f]

CVE-2026-89558: md/raid10: fix still_degraded being inverted in
raid10_sync_request()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89558

Introduced by commit fe6a19d ("md/md-bitmap: merge
md_bitmap_start_sync() into bitmap_operations") in v6.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47f1441b281decde6954a2fa82b4131637d685ac]
stable/6.12: [9bb8da6ecb330a5b1ac9b96f1e55f134a7aef1d4]
stable/6.18: [0efabe6229dc683dbf6eeebd0f9fddc7971ed420]
stable/7.2: [00449d752bee9c8787f42ea1bf533a9fb17f9b6b]

CVE-2026-89559: libnvdimm/labels: Prevent integer overflow in
__nd_label_validate()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89559

Introduced by commit 564e871 ("libnvdimm, label: add v1.2 nvdimm label
definitions") in v4.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [037770686126155eafc44501312989e2837b9659]
stable/5.10: [b4975f2ff6c82adc24ae547f029f82530ba43cfe]
stable/5.15: [6030597ec683d1e5b46445f888bb5c7776b5a0c4]
stable/6.1: [1c391696d2791f82ae462e11da9a0d96f90b240c]
stable/6.12: [e057efcc9c71d90099d9ee00bed0748d0e9fd586]
stable/6.18: [09e649117c54b7e1c004f22eaa19efbadd9ac856]
stable/6.6: [93967bfb17dab66642c57e609c99e1a91fe11278]
stable/7.2: [69a734359639fca16a0dd73ab17a34943e76c68b]

CVE-2026-89560: landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for
whiteout creation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89560

Introduced by commit cb2c7d1 ("landlock: Support filesystem
access-control") in v5.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [672fa082d48b21e1fb62cdb184fee41513e53421]
stable/6.1: [d739e32318479086efb8a6bcf5d37cf341b51f8f]
stable/6.12: [efb4f24fc2b9bcef1c41ff3392894f1fa8fba2a0]
stable/6.18: [627ce4902df1d737e99306daae5a87c68b876d16]
stable/6.6: [dfb10d989056181168ebc16781a8f39520e33200]
stable/7.2: [0c3204aacbe8c07f9e87e3028f28ec6c166a1075]

CVE-2026-89561: ipv6: rpl: fix NULL dereference of idev in ipv6_rpl_srh_rcv()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89561

Introduced by commit 8610c7c ("net: ipv6: add support for rpl sr
exthdr") in v5.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f826df95332c07380206dbd54178b6eefb311aba]
stable/6.18: [63f50e9f90d0287ad66a0955ebfc2d3a9c044a1c]
stable/7.2: [eab3a917cdcb182542a3aac6a0d2d30659ca9821]

CVE-2026-89562: ip6_gre: fix hardware header length for NBMA tunnels

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89562

Introduced by commit 832ba59 ("net: ip6_gre: set dev->hard_header_len
when using header_ops") in v5.10-rc7.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [505b6d296c486ef7d1274f279d4c43a172f63224]
stable/5.10: [cb1afd087aedc90e5274537e4fb9bf3f98e5afdb]
stable/5.15: [7719f6e7ed2ffddc2c3bb61f4467b76d49e0af6a]
stable/6.1: [b1e95e3602d8e112458627f14c6c31c21f2188cb]
stable/6.12: [8bfe746afee38dd6e4348ddcd22d554789dbb9ff]
stable/6.18: [b8282668d8fa7c61b80e8e4890729031c291a16c]
stable/6.6: [c3457a5aae5fb43f7023d3f3dc472c2afa22acf0]
stable/7.2: [565038b0092f65afe384961c0f548d605bf438b9]

CVE-2026-89563: ip6_tunnel: use skb_cow_head() in ip6_tnl_xmit()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89563

Introduced by commit 058214a ("ip6_tun: Add infrastructure for doing
encapsulation") in v4.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87f21b59ddc618eff9670c174842964ad65fdade]
stable/5.10: [6e8eff8ed13b14708bc39f170144eacde494aac6]
stable/5.15: [dc1a319a4815c074914e2812e0e9cd0164ca682b]
stable/6.1: [629d5557e635cdbc109a14ed913ba5a540e3f79a]
stable/6.12: [37df5bc6b5ccad88c2faa0f5466f150178882b74]
stable/6.18: [b36dfd6e8cff00cea81c11cc0af88d1564763461]
stable/6.6: [defa0adeff132cc90ed66915b9a104d9393e1e54]
stable/7.2: [8fc56ca49fc0ee1725b55c67bb43ab0dd01f3f52]

CVE-2026-89564: ip: orphan prefetched skbs before multicast forwarding

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89564

Introduced by commit cf7fbe6 ("bpf: Add socket assign support") in v5.7-rc1.
Introduced by commit 08842c4 ("udp: no longer touch sk->sk_refcnt in
early demux") in v6.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e36ce6e78fe3fc3c071a26750783b7ba081ce10d]
stable/6.18: [a8af6fbac895f057c4b8ff8a2e3fb4c5827fe4ce]
stable/7.2: [f1281d4b99089fbaf0d3579bba62a814ebb4de4d]

CVE-2026-89565: ipip: fix skb leak in collect_md mode when
metadata_dst allocation fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89565

Introduced by commit cfc7381 ("ip_tunnel: add collect_md mode to IPIP
tunnel") in v4.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6776efe4a52f289a3fc18f8adf19b035a7d8e1bb]
stable/6.1: [1909df2d066424767429e13053eb9701263430ef]
stable/6.12: [6d8c5b266d0035a061573843a7243be068eb6118]
stable/6.18: [31e4be21dacee49395013caae28576484a049a4f]
stable/6.6: [c4dc23de4cc75e4e304170b31bb8aeeacd5cb990]
stable/7.2: [fd01f1a3ed4a189a784654f7c69eb565872f2e12]

CVE-2026-89566: jbd2: check need_resched() when skipping busy checkpoint buffers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89566

Introduced by commit b98dba2 ("jbd2: remove
journal_clean_one_cp_list()") in v6.5-rc3.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [f213e12ff5c9590b1034ae8da0e6d09665c772d0]
stable/6.12: [f83c23286e54180cdc83a36463a60003534cc290]
stable/6.18: [f9182a85991a0ad5cd2940df6db75f40ad90028c]
stable/7.2: [595cac7f1b32d009b97f83dd2b2d6a1a445e9bb4]

CVE-2026-89567: jbd2: bound shrinker scans by examined checkpoint buffers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89567

Introduced by commit b98dba2 ("jbd2: remove
journal_clean_one_cp_list()") in v6.5-rc3.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [15cb16496446b94e67f7abcb049b8e2c75cd3d02]
stable/6.12: [edf5fcd0469b7467bd5b37a79502c8d9c3257dbb]
stable/6.18: [71c6b872c746465fa4b5def239cb296173ca8216]
stable/7.2: [c2c0fb364685b8996c357d3b050394959b29d6e0]

CVE-2026-89568: kho: fix size calculation in kho_preserved_memory_reserve()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89568

Introduced by commit fc33e4b ("kexec: enable KHO support for memory
preservation") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a0b8fa2eb36afc88b62a95f33f0c77c71fa5ded]
stable/7.2: [42a6f03cf352eb6e6dbeef95e75e686f4cdb9bd1]

CVE-2026-89569: Bluetooth: RFCOMM: serialize security confirmation handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89569

Introduced by commit 08c30ac ("Bluetooth: Remove RFCOMM session
refcnt") in v3.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [759c185d0bbdb131357408f50b8735e04ed3caff]
stable/5.10: [62ce8b33eb238cf18c15207332fbdc26d858f592]
stable/5.15: [3873f3449701b3dc98cba577923be6493598e7a1]
stable/6.1: [7ded3264106418c6456ccceaafd9fda596ce12c3]
stable/6.12: [1b7841ffad08e911e8c4b9470f3fa08423568940]
stable/6.18: [946d76db77ee5f922968ce558629ae47b381e3fc]
stable/6.6: [82425b14f0fb22e46cfddc56d6465570f5ed0ce6]
stable/7.2: [fbf7961964a6e93360179f64712320ae9a1e9577]

CVE-2026-89570: cxl/mce: Make the MCE notifier per-region

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89570

Introduced by commit 516e5bd ("cxl: Add mce notifier to emit aliased
address for extended linear cache") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [775d0f4558f4cec0ee0c8966595d1add1791f36e]
stable/6.18: [5563db13c9528a56c7161260ec75ec8690dc5608]
stable/7.2: [491d8c9ac98d55073bda778f88a5248d4cce3fa0]

CVE-2026-89571: cxl/features: bound fwctl command payload to the input buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89571

Introduced by commit eb5dfcb ("cxl: Add support to handle user feature
commands for set feature") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f687394af983df5660b6afae7e0d06969f3af206]
stable/6.18: [14d52c15d5d99477b20a2d61fe36f347080da6cd]
stable/7.2: [d8957545fe96f7905791c937758ebfc1ae1e5b17]

CVE-2026-89572: cpufreq: apple-soc: Fix OPP table cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89572

Introduced by commit 6286bbb ("cpufreq: apple-soc: Add new driver to
control Apple SoC CPU P-states") in v6.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d87cb889dc7ab1f2deecadf2a5e9023184bd7900]
stable/6.18: [7c19b94c625dc7042b0a7dff4c8da158358ffa2c]
stable/7.2: [36c55d118d5ecd2fb444f52802955903937b9ccd]

CVE-2026-89573: dm array: reject an array block whose value size is
not the caller's

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89573

Introduced by commit 6513c29 ("dm persistent data: add transactional
array") in v3.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4538a287bdf5d0f9a379c678e5262b9f5783f547]
stable/5.10: [35cd3b278448c79614f65ab6bbc9ed348d847df9]
stable/5.15: [a8237cb8fa0a628d903e76635bfdeae4202036b9]
stable/6.1: [a530a9a419a7c5fdb7dae55ffa2dd7a130631842]
stable/6.12: [7bf4b5cb42a4e27f36bcbc6209d82a5da9c0168c]
stable/6.18: [ac4a5eb8b002a0742c938fc98b922e243f53573a]
stable/6.6: [522fa26da24ccaa298ebe3c1c97395d2d63dfc21]
stable/7.2: [cb409b38b0232ee4385ef55cddcd6fbdd011a8a2]

CVE-2026-89574: dm array: validate array block headers on read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89574

Introduced by commit 6513c29 ("dm persistent data: add transactional
array") in v3.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2965787723084835b18dfe993cd450ebf5bd4540]
stable/6.12: [67adda7ed5da3e3b64f5b9021a02c21fb374fd9c]
stable/6.18: [b33f76d33aaeacf3baf3370d8d64985169b36600]
stable/7.2: [9808ddffb4bc659352df3020cd84d9d864820ee5]

CVE-2026-89575: dm raid1: reserve space for NUL-terminator in
build_constructor_string()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89575

Introduced by commit f5db4af ("dm raid1: add userspace log") in v2.6.31-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [73c37fe54cd056d07461b142ab0b8b81e1ef6ad8]
stable/5.10: [35ba81c93fe7392c973af9881640180490e76f34]
stable/5.15: [1fcc9f9f35653c5ee1a8b144ec96ff3fc48532f7]
stable/6.1: [7b035983b895db3ae01d9855963d42541db42125]
stable/6.12: [0a3657ebd6b517b60cdc5123894047616974e25b]
stable/6.18: [644140527ae494cedf3b5c0ecd16287deaea7a66]
stable/6.6: [01a0276706c7b6fb758a8e2ff9cf221a3dfcae97]
stable/7.2: [f79b53ca3a68a46c6fc3b30b148d1dfb1b33ea8b]

CVE-2026-89576: dm-era: fix shadowed superblock leak on take-snap failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89576

Introduced by commit eec4057 ("dm: add era target") in v3.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [39c5aa3bd8ec3912d2cd0b3fe092642b0d2b0713]
stable/5.10: [54dd21ca945ecc07885012b9f3e8197f091cfba0]
stable/5.15: [ef00efb6fcaee88f50891279ceced17c614e97f7]
stable/6.1: [e9fa68b89214bc65af0ef963af7ec3cce9f866e0]
stable/6.12: [d66ceeefb87ddb097b0546bafc581380b816b048]
stable/6.18: [36ff918637e3517f732188a3c39dbeae5b9cfb1b]
stable/6.6: [dc731d7fddfd6149f5e88ea080475d18c36d3c64]
stable/7.2: [6876ca330e741fb8886d12070cb6a7f9cb67257e]

CVE-2026-89577: dm-io: report non-retryable errors separatedly

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89577

Introduced by commit 7eac331 ("iomap: simplify direct io validity
check") in v6.18-rc1.
Introduced by commit 5ff3f74 ("block: simplify direct io validity
check") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47a5e62f39875f371bded6e34ffb9cf15ccd813d]
stable/6.18: [49694a363f7ecd5a52d1ea1a13c287ad6d196c35]
stable/7.2: [15fc1ec72e1f8089063d298550ada727e18f114a]

CVE-2026-89578: dm-io: clone the source bio instead of copying its biovec

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89578

Introduced by commit 7eac331 ("iomap: simplify direct io validity
check") in v6.18-rc1.
Introduced by commit 5ff3f74 ("block: simplify direct io validity
check") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [62dc37a819a5a5de5cba989ad9e96ee214b9253e]
stable/6.18: [9493ac67623d45b7d4671d2b0b4d0633c2bc2e51]
stable/7.2: [8dc48b68d7c3e6ecaae80fc1592befb0e8603d6c]

CVE-2026-89579: bpf: Harden bloom filter sizing and indexing on 32-bit kernels

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89579

Introduced by commit 9330986 ("bpf: Add bloom filter map
implementation") in v5.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [11c1e836710dcba03e50454a4eedfdbaf8d3050e]
stable/6.1: [a6183bc683f97f4317f7e84939ca7fff37c5688b]
stable/6.12: [3b7a13eccfcf97714ffc1ca6aa663d66d4a30e29]
stable/6.18: [272fcb4ba6fab678db0eb966dc81c4c804bef64a]
stable/6.6: [80551bf8912c42d1e3d55eec6fa3c40f306c3de8]
stable/7.2: [dff481e12b3f127739f6a4ea7cef2c25dc12e056]

CVE-2026-89580: bpf: Disable preemption in __bpf_get_stack

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89580

Introduced by commit c195651 ("bpf: add bpf_get_stack helper") in v4.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b1a47b2708d4e95dbd23aee2ec83752190897b3f]
stable/6.12: [8c5ba022f2085ea42d011497a6e92e527d123b9b]
stable/6.18: [dbfecc8a6631c0d3626c14ba1f1a485a4498445a]
stable/7.2: [9a23747909fcae707990c8466c381a0e7acfaa4e]

CVE-2026-89581: bpf, x86: Fix per-CPU address resolution into an
extended register

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89581

Introduced by commit 7bdbf74 ("bpf: add special internal-only MOV
instruction to resolve per-CPU addrs") in v6.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5bbbce02e500d47d8e259a45be5a7be9741d0533]
stable/6.12: [638bc3aada8ecdece184d5c15b100d489c9cccd7]
stable/6.18: [6886642414f59f928728802dc2c972a9859e6310]
stable/7.2: [6a19b18d458881bf3269a357cc6dc6db5eef4369]

CVE-2026-89582: bnx2x: fix double free in bnx2x_init_firmware() error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89582

Introduced by commit 94a78b7 ("bnx2x: Separated FW from the source.")
in v2.6.31-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2796ffe38cb4155afe0eab23636295b096c27a5]
stable/5.10: [770715784b689749014ce193ef986b706fe8f51c]
stable/5.15: [c44e5d6c3189241d5f791bc7b1eddde6b92f802c]
stable/6.1: [07d4516e3eb1fcde4a5db29eb556cdb0ebba6265]
stable/6.12: [dc98e727b9cfc5e19c796bf893878153f00b222b]
stable/6.18: [4d36e38e48340a1ccf92a98c7a22d07a954e5aa3]
stable/6.6: [ac280f6872e75df49f3004505bcddff91d9e5362]
stable/7.2: [a142c024f07d623e2b6b25943f6c36d4b6b0b4c6]

CVE-2026-89583: Bluetooth: eir: Fix OOB read in eir_get_service_data()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89583

Introduced by commit 8f9ae5b ("Bluetooth: eir: Add helpers for
managing service data") in v5.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4beb198bc59b242404a47c21990bc84165052c8a]
stable/6.1: [b6902adf81ea2ce14b1040dd97b6980050a8125a]
stable/6.12: [815fc98c227a78cbd93d4c29f2833705b7c2bc0f]
stable/6.18: [c21fa79301d7d6ac0a4ec6c51e8ba10beaa08c50]
stable/6.6: [1a28aae7f1fc8c06c0d02f153541be4fc7bacb74]
stable/7.2: [bb56e97bd67614238c1c0a4084704ccadbb875b4]

CVE-2026-89584: block: validate user space vectors during extraction

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89584

Introduced by commit 5ff3f74 ("block: simplify direct io validity
check") in v6.18-rc1.
Introduced by commit 7eac331 ("iomap: simplify direct io validity
check") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [14b007e178811db72fbb1ebb3535160db6ec1e6a]
stable/7.2: [d44a97a3b1c00cc571245124e23e5ceb0a0225a0]

CVE-2026-89585: auxdisplay: charlcd: cancel backlight work on
registration failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89585

Introduced by commit 39f8ea4 ("auxdisplay: charlcd: Extract character
LCD core from misc/panel") in v4.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3e3bf40916c1e810df03958cfa7ba6883cdce79]
stable/5.15: [cd97b3c68fe3c06c8067cc59d7dff976c5b7ea04]
stable/6.1: [22586432c1aba89d9bd33f3173408dac830f220b]
stable/6.12: [fe7ba73dde94c5f413b1588cd444b49105015dda]
stable/6.18: [84858671842ae5857b9ed1202b62f9045373dcd1]
stable/6.6: [6eaed64a32e550daf0dc9549742b3ab9e41d984f]
stable/7.2: [ff2fb3c1e60cb247ea3e28c0ea0bea81c18f7755]

CVE-2026-89586: ata: libata-scsi: fix DSM TRIM for sector sizes larger
than 2048 bytes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89586

Introduced by commit ef2d739 ("libata: SCT Write Same / DSM Trim") in v4.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [79cce911e623c0baa0fde307ce3a434e084b881a]
stable/5.10: [07975b8daa3b0ab3cbc02cc48ea7bc48fadcec53]
stable/5.15: [b7b5ab2df325ffbbad7ca2debaa071e024d68cb5]
stable/6.1: [07baa310ea3224a7044b1ca84796bb37a235af1f]
stable/6.12: [04e2befe25792f2e90097f284d7e86fc6bcfe928]
stable/6.18: [c2e3dccd6870659851eaa4c12ab16418b8e3040a]
stable/6.6: [977554ed91b54075fbc0bac536316b4841ef6258]
stable/7.2: [4a4268a0b0a595bd9534cf9c7fda93775a7d8a0d]

CVE-2026-89587: ACPI: pfr_update: fix stack buffer overflow in
query_capability()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89587

Introduced by commit 0db89fa ("ACPI: Introduce Platform Firmware
Runtime Update device driver") in v5.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ced45be0073a8a31b30b4a7f68cd3a15734515de]
stable/6.1: [d3af83e327565a9444cebc0db714cb837e493046]
stable/6.12: [a2151624b55029dad0ca7efd17fb83a0461c8843]
stable/6.18: [6d4ed2fd022bc862b156e53aae163b61259e1caa]
stable/6.6: [c5a31b4e7e37c92550be9a2edf51ca853a4d251a]
stable/7.2: [15d2b7f38f95d28652170344f39ee492c55e567c]

CVE-2026-89588: ACPI: APEI: GHES: fix ARM section length accounting after header

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89588

Introduced by commit 87880af ("APEI/GHES: ARM processor Error: don't
go past allocated memory") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18

Fixed status
mainline: [903308ea40adf0577d82eab69882faf8836326ce]
stable/6.12: [5ff385e9403e87ae33f65b8c38698d3b1e92cfde]
stable/6.18: [452eb28e03015abec6d4bf6488ee567706ade4e1]
stable/7.2: [b48b613073c3d652cb1823c15d16f7067cf4cee4]

CVE-2026-89589: acpi/apei/ghes: Use raw_spinlock_t for CXL CPER work locks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89589

Introduced by commit 5e4a264 ("acpi/ghes: Process CXL Component
Events") in v6.10-rc1.
Introduced by commit 36f257e ("acpi/ghes, cxl/pci: Process CXL CPER
Protocol Errors") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6625ca499c3131ef63be3215f8f942d7a097ea3a]
stable/6.18: [c735dbce7ad03df708bf22ec964f67e43cbc823a]
stable/7.2: [0e25382b05de48d09b243d3d447d236a6d735bc2]

CVE-2026-89590: accel/rocket: Fix error path handling in rocket_job_run()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89590

Introduced by commit 0810d5a ("accel/rocket: Add job submission
IOCTL") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b2dedadf6a91ac3fc9fae268bb556a041222711]
stable/6.18: [9ad8821573a36bcd18c84dbca3027802b0ea062f]
stable/7.2: [7d6fa298c23495b805004f5f446497b661998fa5]

CVE-2026-89591: accel/rocket: initialize job domain before cleanup paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89591

Introduced by commit 0810d5a ("accel/rocket: Add job submission
IOCTL") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [70e6a33d68a9b03335c5426332666e52d07f45d6]
stable/6.18: [3043230296653a609ab50006899e64bbb2d99465]
stable/7.2: [81731f1eda5e6a1dfad31445f741de9bbefbb08e]

CVE-2026-89592: accel/rocket: fix NULL dereference and integer
overflow in rocket_job_push()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89592

Introduced by commit 0810d5a ("accel/rocket: Add job submission
IOCTL") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a85402bff218f2b8f0d806e46c16c2f3d49cdda7]
stable/6.18: [c1a5bf1b6e1d5944183dcef3844a18c17219af4d]
stable/7.2: [dfff90a6eb2258e3b867994ae17af4a7ba3504d2]

CVE-2026-89593: hugetlb: only adjust reservation during unmapping if
mapcount is 0

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89593

Introduced by commit df7a6d1 ("mm/hugetlb: restore the reservation if
needed") in v6.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5120b1e048d48596ffaec1a8412012a91adba73b]
stable/6.12: [b0b1b9ca80b795ed2223e76dd787db7067121fb9]
stable/6.18: [a3c65af20cceb7f997847727636b4017326f845d]
stable/7.2: [0f001491e5a2ec69aa9d5dd6b799e5742245f9ea]

CVE-2026-89594: hsi: omap_ssi_core: fix missing DMA mask setup for SSI
controller device

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89594

Introduced by commit f959dcd ("dma-direct: Fix potential NULL pointer
dereference") in v5.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e81250ec6b69248b00d38c523dc6a13efaf38aab]
stable/5.10: [6a5426f56de98faf7886702f8720828bf346a48f]
stable/5.15: [a4beb841f84e0e6ad5ff3d114f43ad30165572dd]
stable/6.1: [9ecef057b7a7f165ce66eaf07cb4cf85d10ed9c7]
stable/6.12: [e8d47e309c704df95816e7442f05947424d8b33f]
stable/6.18: [4e019e5e247bfe877fdf288f2d6ec1b4c850c7c6]
stable/6.6: [9963a65be2befff82b5f5a7cfcd7ac4aca081c0b]
stable/7.2: [fbffbfdae55954213fea99c5c9856c48dc705019]

CVE-2026-89595: fsnotify: Fix stale object mask after concurrent mark updates

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89595

Introduced by commit 63c882a ("inotify: reimplement inotify using
fsnotify") in v2.6.31-rc1.
Introduced by commit 912ee39 ("fanotify: do not call
fanotify_update_object_mask in fanotify_add_mark") in v2.6.36-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e422777fdd4746de1109575c51e65038d4c5c1be]
stable/5.10: [27d172b60eeca5c8fd51b246f9fb959067cf102b]
stable/5.15: [2f09f08d602647fc4e328fc27ecb4c3008d10338]
stable/6.1: [de75382d6e354b2b055df4896d12a91969f12090]
stable/6.12: [92289e66639f62abc754c6f3bce5ead7e98e4ee2]
stable/6.18: [947400af98b9e63841929d079a2c3ea0a8ba227b]
stable/6.6: [343ae18e960f6c5f1d34d58a69750c62cd463228]
stable/7.2: [ac8d8b599d466a129122bded77db3d0f8b96b461]

CVE-2026-89596: forcedeth: fix off-by-one when saving/restoring
non-PCI config space

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89596

Introduced by commit 1a1ca86 ("[netdrvr] forcedeth: save/restore
device configuration space") in v2.6.27-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9393f1d656a79693e0c123ff7bc7c5c0f708046d]
stable/5.10: [effd589568b2c4399894a23000286210c60af6d7]
stable/5.15: [702aa4a44c87026b97b1da5c5ca80e1fa8a9875a]
stable/6.1: [fc71c6c3d3e3bb17474dcd1162aea6783a452a64]
stable/6.12: [9379f8527ca60d92715c90b32f1b477de9ec32cb]
stable/6.18: [0c3f4544ff3873594c8af1b907b4ac4e6d5ce005]
stable/6.6: [c4d5953582463f45e48b14ef9815e5fb636f7e1f]
stable/7.2: [c4f196bfeedd71e56aba4b63bd8f919edb2f7056]

CVE-2026-89597: fbdev: uvesafb: unregister connector callback on init failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89597

Introduced by commit 8bdb3a2 ("uvesafb: the driver core") in v2.6.24-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de8db23aa7c337e606fca9faf48b3ba72968597a]
stable/5.10: [b149f77d04082a9da75944cdc488becb0e35258f]
stable/5.15: [0352fdac3cbf11e3b323322ff8cd95e20cbf5cd7]
stable/6.1: [17518e7123f7ef01b1155064dc01f2087583908e]
stable/6.12: [9f8a822b44c42502f105cf6574f4867067eecdd0]
stable/6.18: [466a8af0dee2cf745307155e26884e19a37b7e15]
stable/6.6: [9eb7b3cbe99c9c0edbff69eb155c723e30983c22]
stable/7.2: [9e768ae51426af2034d479133cfd73010d641b1a]

CVE-2026-89598: fbdev: ssd1307fb: defer I2C transfers from damage callbacks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89598

Introduced by commit a2ed00d ("drivers/video: add support for the
Solomon SSD1307 OLED Controller") in v3.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ad709afdfa32509ed64938a6d9cd00db3cd54c2]
stable/6.12: [b64f3497a0cd7bbd26d6c268eebd217d8062fcee]
stable/6.18: [3bcab9b21f71d52bd1b2e03b80f29516bb000593]
stable/6.6: [237924f5b9afc93b57c87bc8efc5ea2e687855e4]
stable/7.2: [1981e54ac137f773fb25a7209a42b75213868306]

CVE-2026-89599: fbdev: omapfb: panel-dsi-cm: initialize lock before
registering display

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89599

Introduced by commit f76ee89 ("omapfb: copy omapdss & displays for
omapfb") in v4.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8e43fe0f22b7137ce456e6fe3581d3098174f74]
stable/5.10: [ef20d4e17d7fb0d83144caa9667e6f3198288993]
stable/5.15: [e7023d18c4eb292f886b31a3576402cb0e357df7]
stable/6.1: [f33a96e49284589257e90ddc4394ec0c6bf11ec4]
stable/6.12: [2c3f8c9c995db185284b079f39177e85b2258176]
stable/6.18: [76818e81cfcae33b09b739de09162c7d8d89bf0b]
stable/6.6: [302d19fbc7dc7e9f498930c66d65ff711ba5ba9f]
stable/7.2: [09db79078f25c048cfb5d7849795c70415ab8574]

CVE-2026-89600: fanotify: fix use-after-free of file range info

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89600

Introduced by commit 870499b ("fanotify: report file range info with
pre-content events") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d7f1cf5be33ef0175a4e8ed8687aeb98fb00a851]
stable/6.18: [66aa9a9e6481bfa512ee5b6380eaaec455a954d2]
stable/7.2: [b8f73b163b646bc56d4dce9c697a578e333f4894]

CVE-2026-89601: ext2: Fix lost inode updates for IS_SYNC inodes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89601

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [356984d1a5c32e94810cbb6c8dc7d8ff2d4d919a]
stable/7.2: [5efb3350230fef831167740e69e6db2861101186]

CVE-2026-89602: erofs: skip sufficiently large global buffers when resizing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89602

Introduced by commit d6db47e ("erofs: do not use pagepool in
z_erofs_gbuf_growsize()") in v6.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a7d097cf01301c5da37927c8f26123d006f0fd8a]
stable/6.18: [7267557ce98ccd07faaf3bc86382448950cc4ff6]
stable/7.2: [7f4a89d4f0d6acaf4b756c31de48f2109a257b70]

CVE-2026-89603: entry: Fix seccomp bypass after ptrace with TSYNC

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89603

Introduced by commit 142781e ("entry: Provide generic syscall entry
functionality") in v5.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a3591287fb7f808e209b4974ed337f609a2006b]
stable/5.10: [eca5ed4200f0be3e91f8a237b1f37582030a93a8]
stable/5.15: [8709e7e1dd7d7de0651e61700edf24f5784f9243]
stable/6.1: [22bb836fc133331982c264227a899d4b26a09706]
stable/6.12: [09e8880ce5409bdb84da991b053d7087502c181e]
stable/6.18: [459f33f82864723a7fa366cf1091d9c6c893b6b2]
stable/6.6: [23001ee5d8631e30192cde6f6d3ccb6805570499]
stable/7.2: [ab4647459098a43e9d6fdb860836f08c962f3774]

CVE-2026-89604: efivarfs: Rate limit statfs() handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89604

Introduced by commit d86ff33 ("efivarfs: expose used and total size")
in v6.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [b2326338dc683e8c1067c0cbf7a47986c4190902]
stable/6.1: [97d71ebee48cd1b29091762b3e5cca4f815dd84c]
stable/6.12: [8953bdd1b9c0e748d5408d3d0b8e7aeee5c9cd41]
stable/6.18: [92895a14329cc9533e2a74a265214f690ba3851a]
stable/6.6: [3cd611c9f1dbcc116c8af5112e3c1783c8cde2ae]
stable/7.2: [0dbc2e94b81df5a1264068b6ed3605c654b8afcb]

CVE-2026-89605: ecryptfs: release message context on send failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89605

Introduced by commit f66e883 ("eCryptfs: integrate eCryptfs device
handle into the module.") in v2.6.26-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [219644a3ad5518217b2d62cad6d2c36a2308c949]
stable/5.10: [177e0c32fec3602bb3b64139bb8bb610cd6722c7]
stable/5.15: [743e7aeb9575c0838d8996d40d81a6b8fa5cd060]
stable/6.1: [590fc6140e29c54d2f7839eb9df78d106ee1905e]
stable/6.12: [47ce611cb13f0eefa550d5434c1afcd4217bfc3e]
stable/6.18: [9319706316a8e79f374627554386d575a84b637f]
stable/6.6: [30845ed227475a11a49ccce047837d016b7e0f49]
stable/7.2: [654b7e79443f5ea90849f5c1cf70c0d94bd5b10e]

CVE-2026-89606: ecryptfs: reject too-small tag 70 packets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89606

Introduced by commit 9c79f34 ("eCryptfs: Filename Encryption: Tag 70
packets") in v2.6.29-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e97bbe1b2bd82ec2ae37ad2e4965b4d3e78bbf7f]
stable/5.10: [df5f375a6151ef71f636da044bcef90c26697255]
stable/5.15: [5668121974eb7f7aa82793a9d0d13abadb8904dc]
stable/6.1: [2e5afed9503dd1d85004c09503adc2cb584c0188]
stable/6.12: [9d88391bbed76eb091cddd50b0af87b1c6f22589]
stable/6.18: [b31da1ecf13929a8d7f8d2727843d2fe35396b75]
stable/6.6: [414a0f04feb06f03523edf7e2a8be1d7f1a9b160]
stable/7.2: [d2869768eab5648e6edc05f47e0716e5328e6681]

CVE-2026-89607: ecryptfs: reject oversized encrypted_key_size in
parse_tag_3_packet

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89607

Introduced by commit 237fead ("[PATCH] ecryptfs: fs/Makefile and
fs/Kconfig") in v2.6.20.16.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5babe9c177c364521e3e682b949c5a8c47f4a441]
stable/5.10: [2cd21340163494d312836c77c9fbfe2530b3d075]
stable/5.15: [e2152d491ae62d96a32ed59778680a242af1fbc6]
stable/6.1: [d2802414081184f79a619ede178aeef3aa989793]
stable/6.12: [ccd13eff0e7356d2aa28b127b577e4e5ad4563f5]
stable/6.18: [14cb36a500a5a3afbc955dbf69dabc565f1a3b26]
stable/6.6: [33e050cac841498b5175f0f385eee903fd98863c]
stable/7.2: [a419c9ebfc9a40ee56aaad6dc68bfd67d400817b]

CVE-2026-89608: ecryptfs: pass packet set buffer size to parser

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89608

Introduced by commit 237fead ("[PATCH] ecryptfs: fs/Makefile and
fs/Kconfig") in v2.6.20.16.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2602b79c5b3e2f6fce12e38a670f8e3fda4e46a2]
stable/5.10: [e7573b0e3058c6bbdfe81673f22c09900fde9e65]
stable/5.15: [66a87559ecb26afe80ad512faf728a158e2b81da]
stable/6.1: [3bd9bb3e167a7c14a50423f6ff03ee0fb007199d]
stable/6.12: [329de8b9e988b152b938f09224670d97bada0b96]
stable/6.18: [e5d254e654f2311a3c4b9c791d7f216554bcd17a]
stable/6.6: [749fa08d8f1b318bd8f4669a14a8a4a8c1bbdaac]
stable/7.2: [747fd45be396a6aea3420ab657a0ab4e60185b05]

CVE-2026-89609: ecryptfs: hold msg ctx list lock when cleaning daemon queue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89609

Introduced by commit f66e883 ("eCryptfs: integrate eCryptfs device
handle into the module.") in v2.6.26-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [779972513c2fa8c7938e54976f686091dafff22f]
stable/5.10: [64d8998e36cfd2bb7114f3af0aa51c5a559a39b3]
stable/5.15: [4d50b8aea11ad9594c8704a4c647e11311ab7b19]
stable/6.1: [956541efd125a10442f9514668bc5c852702c93b]
stable/6.12: [7e48afafe7abc275f7b6916613bb18b821e7d94a]
stable/6.18: [0d9636ecba34bd553ecf19049f7705505aea62fd]
stable/6.6: [ec1627bcb5b51ddd46b1ef27a9d5a9834abb0a6a]
stable/7.2: [4c02acbe0a2692ca9991c51e62bbe6d6b59dac31]

CVE-2026-89610: ntfs: verify run length exceeding volume boundary

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89610

Introduced commit is not determined.Fixed in v7.3-rc1.


Fixed status
mainline: [fea9e4488f384c0ef1c0e3d96b565127c1b98447]
stable/7.2: [6e844d4b82434a781b80d02145fd1b17cf90e3c3]

CVE-2026-89611: ntfs: validate non-resident attribute offsets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89611

Introduced commit is not determined.Fixed in v7.3-rc1.


Fixed status
mainline: [a83e82b0ec3ae523028e24813f23f18b43e8fc1c]
stable/7.2: [cd7b3dc7557faadeea626034e3bac68a449851ef]

CVE-2026-89612: ntfs: reject invalid MFT LCNs from boot sector

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89612

Introduced by commit 11ccc91 ("ntfs: update runlist handling and
cluster allocator") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cc9d09fef78410bcd37ac05168cbd5f6dd75d3d2]
stable/7.2: [8f8420b68a6f05ca2b03779d8208814ec539b9e5]

CVE-2026-89613: ntfs: reject invalid empty mapping pairs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89613

Introduced by commit 11ccc91 ("ntfs: update runlist handling and
cluster allocator") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [766062a82e1ce4087c7dc077224144dfd34b3661]
stable/7.2: [b0cc6dbc655e037251874b3e0dd1a760dcf29007]

CVE-2026-89614: ntfs: bound the free-cluster bitmap scan to the volume

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89614

Introduced by commit 11ccc91 ("ntfs: update runlist handling and
cluster allocator") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [19cac7902a8ab748e15f98ddaafcf5f8882be21d]
stable/7.2: [dc15a9f5307d5372aef3b64bf3ed7802f530c471]

CVE-2026-89615: fs/ntfs3: bound page_lcns[] index by the log record

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89615

Introduced by commit b46acd6 ("fs/ntfs3: Add NTFS journal") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f7b9dbdc1b7520206abce0049bdd143eb536e75]
stable/5.15: [31fdd11f75da9823500168cecb07aa45130915a3]
stable/6.1: [bb742d1030864c0fe140666f639428ba4e90b2ca]
stable/6.12: [f4c1bc6d7331f344ffcea93c2a37badcbe15baa6]
stable/6.18: [7ccb94901f38a062034b56b43c774050b113758f]
stable/6.6: [61ca8cbbf68f77f25b699ed4358bd232f94ed43b]
stable/7.2: [1135ebc225996b3ac1a295652b19a0a706737a6c]

CVE-2026-89616: fs/ntfs3: fix info-leak on partial LZNT decompress in
ni_read_frame()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89616

Introduced by commit 4342306 ("fs/ntfs3: Add file operations and
implementation") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [35d1ea92c7d946e2ebdbe36cdb2c969c8704bebd]
stable/5.15: [7d60a4c49af4d5cb88aa7cbf998d0408bd415055]
stable/6.1: [cd40eee4923d104ebec9ac7513b971bc441e431d]
stable/6.12: [0f699ddb290a24b37e1bc9bf1e3c9dbccf564bea]
stable/6.18: [376ee45659a4b943df672ad275c63da00655f929]
stable/6.6: [77d8efd04745cda23858546afdbd9d07b591758e]
stable/7.2: [4a1b39b2e10eb8de86265e80cf2be4396bc1dce4]

CVE-2026-89617: fs/ntfs3: validate dirty page table on log replay

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89617

Introduced by commit b46acd6 ("fs/ntfs3: Add NTFS journal") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [006cb7713dec10368e699abc4367e5faa334c9a5]
stable/5.15: [0e07ea2fc45a7b4757ef7bf1f692cc0180a08323]
stable/6.1: [1e90b1703ee1a04cd3e9e399353fc536f5f3ba10]
stable/6.12: [1200c2779c43b62656ccbb67df9468a7a9af2484]
stable/6.18: [2d94ffc9d7b5bb3517b129fe63b52d84bcd4ae56]
stable/6.6: [d23155634a4bc1183e761d5eb2c043b2e693cc98]
stable/7.2: [0908da07c23be4f94b99dfd9a94765525f0fe4bd]

CVE-2026-89618: eventfs: Initialize ei->children and ei->list in init_ei()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89618

Introduced by commit 5790b1f ("eventfs: Remove eventfs_file and just
use eventfs_inode") in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [1704aaaf5d22bc765c168402350d191e24e245bc]
stable/6.12: [c480f8af173d5b19c6d9c4311df6bbe352face9e]
stable/6.18: [5333e18e6b425fcc39c7fea89e3949a2a98bc5e4]
stable/6.6: [069729282fbecfaa8a54062266c338ed23f08005]
stable/7.2: [76e0f85f650738d768449dbccbc7c55d05f5b609]

CVE-2026-89619: HID: intel-thc-hid: intel-quickspi: bound GET_REPORT
response to the caller buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89619

Introduced by commit 4138f21 ("HID: intel-thc-hid: intel-quickspi:
Complete THC QuickSPI driver") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [035ec4a71cb8020a927c123bbe75c2f88d614986]
stable/6.18: [72706b44b665679d7d60a488d8776a911f1a93f3]
stable/7.2: [54e0bafc0653bdf2a6c5f5f8ad8787a820d98663]

CVE-2026-89620: HID: intel-thc-hid: intel-quickspi: validate report
size before copy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89620

Introduced by commit 9d8d517 ("HID: intel-thc-hid: intel-quickspi: Add
HIDSPI protocol implementation") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a59cf84441f9a17323c89452cec2bf16724c48a9]
stable/6.18: [6fcefe71aeb524f6e77fe586fe85d873745e917c]
stable/7.2: [ee8ad1bb1e96164d51089b1182f1bd5f187e7baa]

CVE-2026-89621: HID: mcp2221: validate report size in mcp2221_raw_event()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89621

Introduced by commit 67a95c2 ("HID: mcp2221: add usb to i2c-smbus host
bridge") in v5.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c9a6998c19503626c57a2267bf279e204113079]
stable/5.10: [cb38b1f149b7143355b37e86c841acf0076e5c2a]
stable/5.15: [b2c67dc0e30c308647bbd9b9e5d69a44c9d2733d]
stable/6.1: [fffcfa367072628c3144cca17d2a3c3c9e50c057]
stable/6.12: [bdc6a3af0dd734a326acdb7d6401a3b6a9f4f149]
stable/6.18: [127de5919820f88a9d55e8371ad4ac49f625f4c5]
stable/6.6: [c1c508e8923911cb458234997e55b7a4b9aa066f]
stable/7.2: [7c18fb36708a97ff6772825cc087b6d537bbf0d5]

CVE-2026-89622: HID: mcp2221: clear rxbuf after I2C/SMBus transfer completes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89622

Introduced by commit 67a95c2 ("HID: mcp2221: add usb to i2c-smbus host
bridge") in v5.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [db2333f88729c8aae062cb171ed058725ff5c901]
stable/6.18: [03c34309eb1bce1b3b5f7c4a94b703f419120383]
stable/7.2: [968546b676d992dd1da3e057d40598231f725996]

CVE-2026-89623: HID: mcp2221: stop device IO before hid_hw_stop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89623

Introduced by commit d4b50ac ("HID: mcp2221: Allow IO to start during
probe") in v6.6.8.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dca151633c0fde90935311c60e7cfc064aa56134]
stable/6.12: [0ae90a19e6b5a8557d25d95facb7e01c9c07af38]
stable/6.18: [c99ba6c234d4d537c317336376b78c088174034a]
stable/6.6: [85d963499f1feeea287c0a37c3eac3fc1898eca9]
stable/7.2: [2eda1513f573945c1e3a0090341f3d28740463b1]

CVE-2026-89624: HID: universal-pidff: stop the device when
force-feedback init fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89624

Introduced by commit f06bf8d ("HID: Add hid-universal-pidff driver and
supported device ids") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [ce08c5555cabcd444d8b77fa69a7cb68bb05f611]
stable/6.18: [01d9874e84d3ab78fd212ad822412eb3af84497f]
stable/7.2: [c457bb516b61edeab940235a011928e26925381e]

CVE-2026-89625: HID: sony: fix UAF of ghl_poke_timer / ghl_urb at driver unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89625

Introduced by commit cc894ac ("HID: sony: support for ghlive ps3/wii u
dongles") in v5.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a26705bd2e2728833e7a538ce91e58a5eeff496a]
stable/6.18: [114a58640aaf3c2eb97b5b01c75ab5e541d15d9c]
stable/7.2: [3155dc327344d286f17345cd371be05e255a4328]

CVE-2026-89626: HID: sensor: custom: Fix field sysfs group cleanup on failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89626

Introduced by commit 4a7de05 ("HID: sensor: Custom and Generic sensor
support") in v4.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3789d0802ddb4b3be04062caf4bfadd23496e9a7]
stable/5.10: [416194933af63bd58d03b7605b1ebc1711186838]
stable/5.15: [d0e15091e88d18e30b67daf85b88f6528bb9bf41]
stable/6.1: [10b05fafff932e325896d59dde40938954ab4577]
stable/6.12: [79154fad98ee843e5363940841e2d831503c190a]
stable/6.18: [f3f37b937a6ea2a00fb5e6189e74f855caa43eb5]
stable/6.6: [2409779f3096fcef41bcf57b5f4887d0fa0dc8dd]
stable/7.2: [d96f8958d4469ac02d9c563686cdd968005b944d]

CVE-2026-89627: HID: roccat: free buffered reports when destroying device

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89627

Introduced by commit 206f5f2 ("HID: roccat: propagate special events
of roccat hardware to userspace") in v2.6.35-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bbff0ccbff360a5498075525005f6a913239a3d7]
stable/5.10: [cebb20b9a29cfc90bf56e54337333084f85a69dd]
stable/5.15: [690da9177e64bcfda2f4c0b5b8465178e4a236d8]
stable/6.1: [b3cc411daa50b39ba5706492a80a5a0804d9c85f]
stable/6.12: [943b8dc2c6044c01e36395f51bb809a4b6bdfd22]
stable/6.18: [da00eac19feef209c9591e48c860afc2014603be]
stable/6.6: [4cb3ff31d237ad1f515455c497ef07d7172d912b]
stable/7.2: [fbb5a60f5c31b5625f0d89a79912fbcb2559289b]

CVE-2026-89628: HID: picolcd: clamp eeprom debugfs read to bytes
actually received

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89628

Introduced by commit 9bbf2b9 ("HID: add experimental access to PicoLCD
device's EEPROM and FLASH") in v2.6.35-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e9c667395ac1f8024f623250b32bae4c7af9caa0]
stable/5.10: [1a02056c2bf7ef9b5fd05ee6913aeeadb703c443]
stable/5.15: [65daa322f1021d8206f8032c4cd4c0cb2d26c7c3]
stable/6.1: [8dc662af019158690c470edd2e2857657f700abb]
stable/6.12: [a3e6e8d7198a9f3861861520a38b673684a1062b]
stable/6.18: [471f4a939c66d1d44aece2321807abf609fc9098]
stable/6.6: [4daf432c94a42e7be6aa10b012b33af5ed9bc118]
stable/7.2: [699a3c8b56e168ca19d12722f3f5ef1d6f4b1d84]

CVE-2026-89629: HID: corsair-void: Check size of status and firmware
events before reading them

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89629

Introduced by commit 6ea2a6f ("HID: corsair-void: Add Corsair Void
headset family driver") in v6.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [08d8814521885e67b1bdf6a3036ee264e3e58377]
stable/6.18: [79465a30050dad62b3c9e7796368db75dac6fa0d]
stable/7.2: [0329354abba357340ee88452425857f3718b5807]

CVE-2026-89630: smb: client: restore the data_offset bound in
is_valid_oplock_break()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89630

Introduced by commit 83bfbd0 ("cifs: Remove the RFC1002 header from
smb_hdr") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ba22f575de9deeae4ae0859ca4315a7698226237]
stable/7.2: [5b16a1967a01ad4496a7206a87c3eb16f1df2b05]

CVE-2026-89631: smb: client: reject a tree connect response whose byte
count is too small

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89631

Introduced by commit cc20c03 ("cifs: convert CIFSTCon to use new
unicode helper functions") in v2.6.30-rc5.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [65deb18359341141d37dc86fc7853511be3c87a7]
stable/6.18: [3be89e8039a85fa3b6cd5f9dcc4c1459eb356c2d]
stable/7.2: [411e484fe71a7f1028de617447edad9cb6d9d68a]

CVE-2026-89632: smb: client: fix use-before-check of ReparseDataLength
in reparse_buf_ptr()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89632

Introduced by commit a158bb6 ("smb: client: optimise reparse point
querying") in v6.6.32.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [05f78e6cf34ea3a285053bd5999e08e8ac298bd5]
stable/7.2: [711cf71300d7992f450600df8864917d3538679f]

CVE-2026-89633: smb: client: fix OOB read/write from unvalidated
DataOffset in coalesce_t2()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89633

Introduced by commit e4eb295 ("[PATCH] cifs: Handle multiple response
transact2 part 1 of 2") in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6343c1da561962688f203362d80d6a3bfa39fa1b]
stable/6.18: [672cf86aa6aa0fb4012ce4c3b3498df42ad67a4e]
stable/7.2: [033bc80019f07d158630df4e69b19a49010f54f1]

CVE-2026-89634: smb: client: fix ALIGN() overflow in symlink_data()
error context loop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89634

Introduced by commit 76894f3 ("cifs: improve symlink handling for
smb2+") in v6.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [62656b024efc21c3230eade1a847f25871c3d2bb]
stable/6.1: [2b4a25baa0b936fef6915c0459925077b324ecaf]
stable/6.12: [657372ba6ea50b4474d2a6a610097eae8cd1f3e9]
stable/6.18: [1f824f61d1df52392eaf0b74dfa5659d724fde30]
stable/6.6: [b89d678f9eafcf8d74885983166ba26b40a04ea0]
stable/7.2: [62a3025983c8c735a3c6fc85a59316f31b59af07]

CVE-2026-89635: ksmbd: only rebind the reopened file's own oplock on
durable reconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89635

Introduced by commit f363a0f ("ksmbd: fix app-instance durable
supersede session UAF") in v7.2-rc2.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f220a0a62e6b9b391c9d1f0e6580b05173cc7f7]
stable/7.2: [74e3ef4630f004c0de40c0540648a5a4033c6c9d]

CVE-2026-89636: smb: client: clear ce->tgthint in free_tgts()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89636

Introduced by commit 54be1f6 ("cifs: Add DFS cache routines") in v5.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b1b741cf8e7ce1b91d937e23decd3d3358748700]
stable/6.1: [14f60e959b5ac813715ff72e127beb3584ddabf6]
stable/6.12: [7507bd1885643d0461a6017767492450af1ce2a3]
stable/6.18: [9ab46a13798a61d9d020b01d4e57efdabe6624fa]
stable/6.6: [3ff9462bb7a06d8d32a1dc02d39580b078ec9e55]
stable/7.2: [5baab40404a9393bcc0b7b8f1950bf2c307e0984]

CVE-2026-89637: smb: client: fix UAF and buffer leak in
cifs_check_trans2() for malformed secondary T2

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89637

Introduced by commit 316cf94 ("CIFS: Move trans2 processing to ops
struct") in v3.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [730d0bb19507b9e19c2fe5343109ac618e2fbce5]
stable/6.18: [9eed72e9534b10a6d9f8f5146feff3db53aebdba]
stable/7.2: [5e6533a683f6a851158d9f33fb4ea8f4f25d7f84]

CVE-2026-89638: smb: client: clear setuid/setgid bit on write with
cifsacl/modefromsid/posix extensions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89638

Introduced by commit d32c4f2 ("CIFS: ignore mode change if it's just
for clearing setuid/setgid bits") in v2.6.24-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b8e5dc4f95e5484159b343903f302eb6d783f2e6]
stable/6.18: [b10015807e4c628095d1d1d1c9307efc8cdd9e1b]
stable/7.2: [69bfe810ecd1e0387d8975d711cd326341d13c6e]

CVE-2026-89639: cifs: use cifs_invalidate_cache() in
cifs_do_truncate() for O_TRUNC

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89639

Introduced by commit fa724e2 ("cifs: add fscache_resize_cookie() to
cifs_setsize()") in v7.2-rc6.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18

Fixed status
mainline: [364b183230586a62660a7280c1eb20138338eeb5]
stable/6.18: [8b9b10fe5b8b492b27b9f4546742ea541a650213]
stable/7.2: [81fc3868a7f726980ff845c1d0d271051e5f0f45]

CVE-2026-89640: cifs: fix loff_t underflow in cifs_remap_file_range()
when len == 0

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89640

Introduced by commit 04b38d6 ("vfs: pull btrfs clone API to vfs
layer") in v4.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6c322f5cf7476ded7a9a20f7be72462065a03c68]
stable/6.1: [f3d1ae1e6bc4a9f559185b6e7bd2b6375ec2fdd4]
stable/6.12: [b098f5e5858797827666e6cd73033f52fc39b5f6]
stable/6.18: [c2a0dcb5a7a1516aa6eb6d5cedca6a8e76527028]
stable/6.6: [7f62817fe049b0f3652518c1ba72631ec1e0a322]
stable/7.2: [b057ca17b656345d04669cb87f2aff9b31d873db]

CVE-2026-89641: cifs: clear tcon after cifsFileInfo_put() in
cifs_file_set_size()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89641

Introduced by commit 110fee6 ("smb: client: fix missing timestamp
updates with O_TRUNC") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b96db32fed8dfb2478d7c208f89bf383beed1535]
stable/6.18: [4f18c9e7ee464aaae5cd9fccdb943b3fcb4655d4]
stable/7.2: [4bea15d9c7683218f57b8c1f5f0aa75cab76af8d]

CVE-2026-89642: cifs: call pagecache_isize_extended() in
cifs_setsize() when extending

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89642

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c510edb9734af1c274d18f4f31a471a166bbc7e8]
stable/7.2: [12bafe32f09c0d24f5096154b59c347b9c6606e0]

CVE-2026-89643: audit: avoid dropping live tree ref on fsnotify rule autoremove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89643

Introduced by commit 34d99af ("audit: implement audit by executable")
in v4.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [783f0f0974c156aca630f4ffff248671082a098d]
stable/5.10: [9cac21f8eb82675ed19fb955b8bbb9dd14cc3d58]
stable/5.15: [b322cc7adcd2e6ec1594d187533a126506ab545c]
stable/6.1: [695c85dc345a4e0292739f004c261bedef3f27e6]
stable/6.12: [cf37b61b5420fd4600fe78cf8c24da6e4d9bfe28]
stable/6.18: [636a99bab36ba27515363d325866c0273ac83b3e]
stable/6.6: [01b0ec8c397be65ff710777c97017ca1de56ef8e]
stable/7.2: [583cf579b32d99e3fe4e9c8ecc4d852e3708fbec]

CVE-2026-89644: btrfs: fix extent map leak in NOCOW direct I/O write

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89644

Introduced by commit 5f9a8a5 ("Btrfs: add semaphore to synchronize
direct IO writes with fsync") in v4.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f950867c307c5413d628a153ac44915bd117ffd]
stable/6.18: [f42efd634c0ae7ba0ce2fc5e30e291b0803b0ae2]
stable/7.2: [05a1a816eef8b3e4332620a64fc8cf45c4eb5c0d]

CVE-2026-89645: btrfs: drop recovered reloc root refs on recovery failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89645

Introduced by commit f44deb7 ("btrfs: hold a ref on the
root->reloc_root") in v5.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d8ba4572922e336f0b59a80751b018e1e135164]
stable/6.12: [2256d6dc5b88841a8a8b4fd9a9f04730705fb6fd]
stable/6.18: [8a64baeb5bbb706b83d2235c1e39f5b77183817f]
stable/7.2: [4d43107e807bcd92621106b07f5011411c6341a8]

CVE-2026-89646: ceph: fix leaked inode reference on writeback abort at umount

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89646

Introduced by commit fd7449d ("ceph: fix generic/421 test failure") in
v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c25aee9c630fb86f98d79eccb75765067079b972]
stable/6.18: [ec32015a955c5d326c5e26610edfdcccd52f2314]
stable/7.2: [ac7a5a5385762df458d10cccc086a4e079be7409]

CVE-2026-89647: ceph: do not repeat ceph_trim_dentries() if no progress possible

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89647

Introduced by commit 37c4efc ("ceph: periodically trim stale
dentries") in v5.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e7d7aa7b730178278109c41fa1b17b06873065d5]
stable/6.12: [5a541eb401acb89d791da41189d7a79220164b93]
stable/6.18: [37d6edb2f03b29399a3a337fae78674de51e1695]
stable/7.2: [3d122b2feb1dd76bb5041bdea5e1e1b007d8d415]

CVE-2026-89648: ceph: cap delegated inode count in ceph_parse_deleg_inos()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89648

Introduced by commit d484648 ("ceph: decode interval_sets for
delegated inos") in v5.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4bd3158bd62466d57ed72a3f7bc5f205fedd6919]
stable/6.18: [c040e139f1a629b767f900bbbc3f9892c290ed85]
stable/7.2: [f341270ac5f5077804d7837ce77b0f0df1cea29d]

CVE-2026-89649: ceph: bound xattr value length in __build_xattrs()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89649

Introduced by commit 355da1e ("ceph: inode operations") in v2.6.34-rc2.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [68d541754d6cd3bb98d1fd8314f57e5eb533557d]
stable/5.10: [848b80ca6b410f350d08b8ac19a00ef88223f2ea]
stable/5.15: [01e3f19c301d492e12f16b3b463ac14d7cf3ebe7]
stable/6.1: [cb0cd79ae80476d1bc06bd9678484b6736f19588]
stable/6.12: [38be2f3c41ecaba58bb92dc16603e09ba9fd64f1]
stable/6.18: [1dd356310b1660215f9a3626580bf8b363ef981e]
stable/6.6: [61f085cb8976c9cebc90e1a8933e4cc1ad8b0fce]
stable/7.2: [b12b3320c81fd72ab36388fb2445fec9c3038f10]

CVE-2026-89650: ceph: bound num_export_targets array for mds info v2/v3

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89650

Introduced by commit d463a43 ("ceph: CEPH_FEATURE_MDSENC support") in v4.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3eb169ee297aa99670ba927c659990bd1e453f3]
stable/5.15: [0c4bcc3ba7291d383b82ce1c2fe324f69a42da2d]
stable/6.1: [55a06b32438c222765138727d0a8164b103e8f0d]
stable/6.12: [3bf7dba8dba9a05774b846affec61a3624ddba38]
stable/6.18: [58c2d3e954c13694ef6e820a5e9456461bb9e7df]
stable/6.6: [eb3e1a1cb1634c76d59c5a9cb1a026fc69d40911]
stable/7.2: [332c444f4dc6fa1e8b8637c9e82d29e97f768656]

CVE-2026-89651: ceph: bound MDSCapAuth path and fs_name decode in
handle_session()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89651

Introduced by commit 1d17de9 ("ceph: save cap_auths in MDS client when
session is opened") in v6.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [77933e22adfe813be2bd10be08d6e950103c3967]
stable/6.12: [dc5c7dffda92ef372fa587c444a1c537373df824]
stable/6.18: [c37db86d2b5e9b57001ccae7e7a727e95a4f9c02]
stable/7.2: [5f892c767b30e4fb0c744c59f9235c717383d2cd]

CVE-2026-89652: ceph: bound copied dentry name length in NFS export get_name

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89652

Introduced by commit 19913b4 ("ceph: add get_name() NFS export
callback") in v3.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eff8013c5a8916613c742ae5a2cc341cb605c0ae]
stable/6.12: [61d9f27b191b838b96b697ce0bfaee39a138243a]
stable/6.18: [06fb5e623cdc2402d6bb29be94d9beb9a826ffec]
stable/6.6: [a294064e0e0f81ea607b2f019e16888aa1b0a011]
stable/7.2: [e7c2fd3893a7f7fcd7e8cf0b2c6348bb1e893df6]

CVE-2026-89653: ceph: reject export_targets ranks >= CEPH_MAX_MDS in
mdsmap decode

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89653

Introduced by commit d517b39 ("ceph: reconnect to the export targets
on new mdsmaps") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aedc9053d909508a5f56c3f49f885fc030df4730]
stable/5.15: [3740c88ca9cb2210a8dbdd55ea4cec119fbe86fe]
stable/6.1: [8c823bbab3c24e657469a84db96902ba82d4e8bb]
stable/6.12: [736adee11af36e407ed902264f8b2fb5cf94b62f]
stable/6.18: [4d298880f82c42383b36946bafde7ccf4d804c9b]
stable/6.6: [c4addccd05bacbef2144b4db14853d0308a218ac]
stable/7.2: [96c3f5fbb0d5386e7111426f047f98cec4586674]

CVE-2026-89654: ceph: fix UAF in check_new_map() on session freed during unlock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89654

According to the .vulnerable file, this bug was introduced by commit
2f2dc05 in v2.6.34-rc2.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee611a7509554c4ca1f54f6aefe592fb1df7ea70]
stable/7.2: [21d5be092d947f8d83f76f7ebf3989e7e9230a98]

CVE-2026-89655: ceph: fix UAF in __kick_flushing_caps() on cf entry
freed during unlock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89655

According to the .vulnerable file, this bug was introduced by commit
e4500b5 in v4.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7af4c4f01305b0935adf6d4301b1ec407025485d]
stable/5.10: [091137821e1fc88f37e15201abf055c9494ddc61]
stable/5.15: [01542430081014d80fc9e70e92d6647432ddb7fc]
stable/6.1: [23eb34a53a53cb1a6dab1eeee830633207ac158d]
stable/6.12: [2701431aa3cc8b23efe6890182e7b04f5e76fab5]
stable/6.18: [fe46746087b5b9c5bb2d022df6c7819218494ced]
stable/6.6: [19f16f04c2b014a7dd214dc1e42557d8530b16f3]
stable/7.2: [2dba24dcd5050be4b7b119e6f0b01f62203b5d26]

CVE-2026-89656: libceph: reject buckets with mismatched CRUSH ids

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89656

Introduced by commit 66a0e2d ("crush: remove mutable part of CRUSH
map") in v4.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3cde4a8302301679937474a5f7a851394cc1bd11]
stable/5.10: [ee59040d6ed1a5f8d10d27174b8f32c90ca8e89a]
stable/5.15: [baad5875fdd2f5e248250fc3519bb045d64f1716]
stable/6.1: [4aeb93daadf388e72073abc204312dd364eeb30a]
stable/6.12: [3516a4131c4e45d62ee4e42e82c36930e8c1fbbd]
stable/6.18: [00562ccd4e88d092b9b851df50fad20442bfeb24]
stable/6.6: [6e5c6ce252b1eccfd41670a5cf95ab44f7ba7022]
stable/7.2: [79900d978158b2d80eef952fc41b9e4dc58d7b83]

CVE-2026-89657: libceph: validate OSD extent maps before cursor advance

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89657

Introduced by commit f628d79 ("libceph: add sparse read support to OSD
client") in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ec08b7499a62c6d4afa93d36ab47a43fcad57d1]
stable/6.12: [058ffa81f9440c5b4714685611cf697fd3739ec9]
stable/6.18: [2571b35883268a266554e80d368e67fdfea7fb9d]
stable/6.6: [94ae5145c520618802b0a24c047dcd5f05835db8]
stable/7.2: [201db408872ca12cf09e36bf0f560138c3dcfa1c]

CVE-2026-89658: NFSD: Prevent client use-after-free during NFSv4.0
revoked-state cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89658

Introduced by commit d688d85 ("nfsd: allow admin-revoked NFSv4.0 state
to be freed.") in v6.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b4f8a1586c42d3afc3c0ac779af2db7ab1a5c55]
stable/6.12: [0ae0d2b5c5a1b39c0b3c15d96b32a5b0c583d519]
stable/6.18: [b413ec5b23e3445dc9c4f273116078e2d4747626]
stable/7.2: [81cf7f1413862f87b078920c838460a6a88aa030]

CVE-2026-89659: NFSD: Prevent client use-after-free during delegation revoke

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89659

Introduced by commit 3bd64a5 ("nfsd4: implement
SEQ4_STATUS_RECALLABLE_STATE_REVOKED") in v3.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4683ca76b3b7e5808338491c6eb3c20e6b4894d5]
stable/6.18: [3c0a53ee0b442348d8d2286d6960d3f07bb3a3d3]
stable/7.2: [2a9d637c2a8fd8ac29ad9b29f28d122ef75c1a56]

CVE-2026-89660: NFSD: Prevent client use-after-free during admin state
revocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89660

Introduced by commit 1c13bf9 ("nfsd: allow lock state ids to be
revoked and then freed") in v6.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e270e5a0778e5bff852c8862ce9576ce70359393]
stable/6.18: [549bd9868e9d77b07ea94870940d64342829c6ad]
stable/7.2: [bf1f948691523282cc4905bc6cd325e0c0b49e6a]

CVE-2026-89661: NFSD: Prevent post-shutdown use-after-free in unlock_filesystem

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89661

Introduced by commit 3daab31 ("nfsd: cancel async COPY operations when
admin revokes filesystem state") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [292d915d3ba6fd15eeb88351fa10581683073109]
stable/7.2: [0c1a755b7212e0835398d4df5e782ea85ccd7476]

CVE-2026-89662: NFSD: Prevent lock owner use-after-free during client teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89662

Introduced by commit 68ef3bc ("nfsd: remove blocked locks on client
teardown") in v4.16-rc7.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5e2fa29d223a9a1e6a948e40b109d09081d1decd]
stable/5.10: [42d7954b0a1907d4ef122aef94561952a033cdc3]
stable/5.15: [bb38ff8b4dafbbd1781ad37cd96722fdf2cd972a]
stable/6.1: [b8bad5a11416b26cc7fd4b18fba46d75ff636558]
stable/6.12: [a6ead6fff3a7d03e49845f048f7000a2e0d34431]
stable/6.18: [4804c58f73a80d12df1de323bf97a164f6ee8743]
stable/6.6: [1ce74d1b7770e69735e8f8e509807af4ff9c8ee7]
stable/7.2: [8cf4ff0a7c083dd5e0067f517d63979b74b66649]

CVE-2026-89663: nfsd: revoke copy-notify stateids before dropping
their reference

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89663

Introduced by commit 624322f ("NFSD add COPY_NOTIFY operation") in v5.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3b0c3595db99bb4bebd7c8aa8a36f3c50e411bb7]
stable/5.10: [5f00e0ab4de45d4f9e4bd0883cf2517acf63fc0d]
stable/5.15: [06a62f6dbc60791f4229c6950b1eec6b18df9af1]
stable/6.1: [a1fca0f7bbb7b100a39c7ba8dd7922c87c4237a3]
stable/6.12: [6b8149448cdcb476fba4559d1ecc247efee9971b]
stable/6.18: [b56d2c5f01cddbeca7d11cce81d97db4ec9a464f]
stable/6.6: [caddbeffab1eaba1d2bcf5ceda35547863466705]
stable/7.2: [ff8a3cff02b92b2a82f1a9876038fcf953ae9c25]

CVE-2026-89664: nfsd: release OPEN-decoded posix ACLs via op_release

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89664

Introduced by commit 5fc51df ("NFSD: Add support for XDR decoding
POSIX draft ACLs") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8215892993ea9f5231da4fa9eb42428a286fce8b]
stable/7.2: [5b3a7d7c23c071efe12dd1bc1d2e5f97c4892921]

CVE-2026-89665: nfsd: reject out-of-range useconds in NFSv2 SETATTR/CREATE

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89665

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26709c8ffe73772eb69e68d553ac71d91228dccc]
stable/5.10: [cdc3299f7072777b09c9582a3b8b65bb163ddcf3]
stable/5.15: [09a79d9ab35a39603c834e8f6333603292f9c816]
stable/6.1: [5296a2442d12d45d6eea7b4d3ec3ffecc1821cac]
stable/6.12: [a937dd1aa2d92291fe0a1860d17e90d8f206cd22]
stable/6.18: [ad02d095439f89cbd6629420c7e3ba476457b83b]
stable/6.6: [1db456ffc22e045f49f7b9e62415a26b3f33f200]
stable/7.2: [1195483965a5f63d2dde18054ec7e50a23b9071c]

CVE-2026-89666: nfsd: reject out-of-range nseconds in NFSv3 SETATTR
and create ops

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89666

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb0eca7720662ba5847df1510e73801f7f473094]
stable/6.12: [55341d8a5a0f5853e70d46f5a55cf06007808f1d]
stable/6.18: [54e02f5e32c52fb395f2ee02986a6c6d5608d22b]
stable/7.2: [e2543852152bcf9aeb57da17d9f9219f7df8aafb]

CVE-2026-89667: nfsd: close shrinker/GC/fsnotify vs per-net shutdown
race in filecache

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89667

Introduced by commit ffb4025 ("nfsd: Don't leave work of closing files
to a work queue") in v6.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [40162cfea79b9510380decfdd1795b754dc9f972]
stable/6.18: [6d6b9f6a75c3767250e9c23ace4e384ab8f7843e]
stable/7.2: [08af9593e2b472fd98c00faf1bf03bdbb7203477]

CVE-2026-89668: nfsd: move nfsd_debugfs_init() after
nfsd4_init_slabs() in init_nfsd()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89668

Introduced by commit 9fe5ea7 ("NFSD: Add /sys/kernel/debug/nfsd") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c390c8a1764d67095fe444401861fac4c049362]
stable/6.18: [4ae5d7490ae6a7b83b3d607f88c499f4f85e753a]
stable/7.2: [ab43ff94f5dfc2b6a080b167b69855eb7655c98b]

CVE-2026-89669: nfsd: initialize copy-notify stateid before publishing it

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89669

Introduced by commit 624322f ("NFSD add COPY_NOTIFY operation") in v5.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [129643893b79f8a3c6b72045f933fbab5ee424ca]
stable/5.10: [863b6e995665472f2af5be2436a874ab6a9e5ac6]
stable/5.15: [d18d36395d973ef7372c8e6724970585f75b5c0b]
stable/6.1: [4415a692346a39fdb647cbd717eda510159aaf55]
stable/6.12: [e08a3dcaca0505f861e344a387f37f94d95dbdc2]
stable/6.18: [a4d7fedcaaf33e60a01e53eafca9041ef966212f]
stable/6.6: [9caad13b7cfe9ccb90cc405ac77335800e086595]
stable/7.2: [4cdef96892f4fa6e70c405b6e8f2fd6972f3b64b]

CVE-2026-89670: nfsd: hold rcu across localio cmpxchg retry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89670

Introduced by commit e6f7e14 ("nfs_localio: simplify interface to nfsd
for getting nfsd_file") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [58884694978a3d7d111edb433d7fd6a6c5af2f34]
stable/6.18: [763c0bad872368304db718f79af7e93048885c67]
stable/7.2: [559570f91a7d4d199a72105e4980bef791f4cbf1]

CVE-2026-89671: nfsd: gate nfs3 setacl by argp->mask

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89671

Introduced by commit a257cdd ("[PATCH] NFSD: Add server support for
NFSv3 ACLs.") in v2.6.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [453d7198a0ab07a12d46e0575861ac7b932da17e]
stable/6.12: [68a80b26efdff1d09f8ae1773c6a915abb9e191d]
stable/6.18: [b3bff820d068ea59767d4e91a3258231a879da5f]
stable/6.6: [3be1d8611dae4829e4608007db29f4a8748c37b2]
stable/7.2: [ff99ed007f065198fd723152405c22aa558f700b]

CVE-2026-89672: nfsd: gate nfs2 setacl by argp->mask

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89672

Introduced by commit a257cdd ("[PATCH] NFSD: Add server support for
NFSv3 ACLs.") in v2.6.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3a7e20ed66d3f04d37883c398da8a113b430769]
stable/6.12: [e41d173d9dc735cecb15ab7aa63ecab09338f81b]
stable/6.18: [f951b22dbeec46f2e0fba81cb80d1b0c686b61eb]
stable/6.6: [8e4422b05f410f95c51b68a0db4bf1d87f6d22f5]
stable/7.2: [37eea38e7898538f0ec5f1eb8b18d8646e4be41c]

CVE-2026-89673: nfsd: fix XDR padding calculation in ff_encode_getdeviceinfo

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89673

Introduced by commit efcae97 ("NFSD: da_addr_body field missing in
some GETDEVICEINFO replies") in v6.4.16.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b989aaec85e1293a871d602590c951fe44b8647]
stable/5.10: [356decf074b82bac5564568203c12426dcea3470]
stable/5.15: [15460c8e6c9bc92cda8f68bc419ac082300ab3d6]
stable/6.1: [9be67a6be48ddf2ebaa98c0df671690b8f9666e7]
stable/6.12: [74015b7be806ad9e21d46f7bd2831df280c6c783]
stable/6.18: [41ebca28e17f84293650598f86bd69532ec1a8e0]
stable/6.6: [88bce7e326c368d7df15126ccac537e54bebd467]
stable/7.2: [62e5949f0dd5ec837af144860ff908369df4c7c9]

CVE-2026-89674: nfsd: fix XDR length calculation in nfsd4_ff_encode_layoutget

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89674

Introduced by commit 9b9960a ("nfsd: Add a super simple flex file
server") in v4.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9868174af49d207fbaf0c5e055d088a983684af]
stable/5.10: [3a7fd224df0fbb42167eb1b77be45d72fe0b1098]
stable/5.15: [29e4478e2ed5a227e8f0c33cacb91bf227cedd47]
stable/6.1: [65a72b721943618eeb3a41c8b36e915591f3f83f]
stable/6.12: [e7d9d23ecd9172f05b09bb678ff22db8e361c428]
stable/6.18: [0380129b1373c437eb35401a174671c8888f4b80]
stable/6.6: [bee826c00ac900473f91306f1f3e5a5a81fd4a74]
stable/7.2: [c81cef6a805dec266c10fc4f83c93d6fcf1a2b43]

CVE-2026-89675: nfsd: fix UAF in async copy cancel and shutdown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89675

Introduced by commit e0639dc ("NFSD introduce async copy feature") in v4.20-rc1.
Introduced by commit ac0514f ("NFSD: Add a laundromat reaper for async
copy state") in v6.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [62c0f6eaf050bb9284c1f9cac6ed1770092e6b95]
stable/6.18: [9031493ef7369d5c59c4bacc96f0c85965f09a98]
stable/7.2: [a385cf5e016b748babf94cc664e43a26e17db117]

CVE-2026-89676: nfsd: fix stale s2s_cp_stateids IDR entry for async COPY

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89676

Introduced by commit e0639dc ("NFSD introduce async copy feature") in v4.20-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d0beaee498e11880e72826026db0e9c9890fc114]
stable/6.18: [9b4e5e9ba5ae13808b8a6d229d87c54611ba0e7a]
stable/7.2: [14b978e8d05ce018d0afbeb6611833ef91713a02]

CVE-2026-89677: nfsd: fix possible fh_compose of wrong dentry in
nfsd4_create_file()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89677

Introduced by commit 64a989d ("VFS/knfsd: Teach dentry_create() to use
atomic_open()") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e2c79360c6a89975ec5b5a7d4ef937e4db91a27]
stable/7.2: [033e783709ce99662cf81f6abcad746a8da9d35f]

CVE-2026-89678: nfsd: fix partial-write detection in nfsd_direct_write

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89678

Introduced by commit 06c5c97 ("NFSD: Implement NFSD_IO_DIRECT for NFS
WRITE") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [250ec14932d5cfe102f68a57892bb566eee7f83e]
stable/7.2: [fa6590dfd16ab55f03b658b079072ace3504825e]

CVE-2026-89679: nfsd: fix null dereference in nfsd4_setattr for deleg
timestamp attrs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89679

Introduced by commit 7e13f4f ("nfsd: handle delegated timestamps in
SETATTR") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe456c8c0931bb3e8a03d429920e87fd85747fba]
stable/6.18: [3c5119b799a7f57db332b2c31e806de16c869f0f]
stable/7.2: [3c896db123892256fd39af0ee8c2d02c63539983]

CVE-2026-89680: nfsd: fix nfsd_file leak on inter-server COPY setup failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89680

Introduced by commit ce0887a ("NFSD add nfs4 inter ssc to nfsd4_copy")
in v5.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [88a76145451d703eedd867b5989bf73d17340399]
stable/6.12: [1a6a41b848455bf6ba2c9da2dfb0730e608ce7ab]
stable/6.18: [424d5c95108a4809b832cb0a312c61de4aec0078]
stable/7.2: [6ed8d6de7ec90c4ba84eb82673058f506e5777fd]

CVE-2026-89681: nfsd: fix layout fence worker double-reference race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89681

Introduced by commit f52792f ("NFSD: Enforce timeout on layout recall
and integrate lease manager fencing") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8580571227451384399b3fa53fcde19848c48e5a]
stable/7.2: [a278d361e0e8f242211891193d56483a7a9f47a8]

CVE-2026-89682: nfsd: fix fcache_disposal UAF by inlining dispose
state into nfsd_net

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89682

Introduced by commit 1463b38 ("NFSD: simplify per-net file cache
management") in v5.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [bbf13732f74351d21c5e0e8dd9bd8e1c48dc35d4]
stable/6.18: [ba0ee9e04b7a0356c28d5a2fe445db675d24e572]
stable/7.2: [cadc9036d5a8209f89e7026ddba7cfb1c716b03c]

CVE-2026-89683: nfsd: fix dentry ref leak on V4ROOT export filehandle lookup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89683

Introduced by commit ef7f6c4 ("nfsd: move V4ROOT version check to
nfsd_set_fh_dentry()") in v6.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6247023fbbec1325029f2d5f2a7cdc0f9f9ea15a]
stable/6.12: [d493cf57f4c4dae5396cd6ad41e5c209d0615a81]
stable/6.18: [c1ae0f973bcba5730871e35976a0ab6878fdac34]
stable/7.2: [11db8df188b34bdb8c6a3a0bf438e5fc8cd75aca]

CVE-2026-89684: nfsd: fix cpntf publish race in nfs4_init_cp_state

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89684

Introduced by commit 624322f ("NFSD add COPY_NOTIFY operation") in v5.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be3a5c1d857b0dcbc11796cea603ef25834f75b2]
stable/5.10: [63e18fc65587fd3f7b4c6d70e96d32fc41d82ba3]
stable/5.15: [6ac469a274e3c7d87fc46ba46d83b95009680407]
stable/6.1: [8eeca993357a0bc35aaefebfd7462ac7b0a21d9a]
stable/6.12: [21d6c5957f5ca97d7352e60f55ea412beb9419f5]
stable/6.18: [a631a26a8777bb235eabd478bbbaf26a4db750bf]
stable/6.6: [bfeac42d9074e539bacd1898dd8c14b7f5776620]
stable/7.2: [c7270f62e7a05a2ee68aa2b74262b658a14463bd]

CVE-2026-89685: nfsd: fix clock domain mismatch in clients_still_reclaiming()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89685

Introduced by commit 20b7d86 ("nfsd: use boottime for lease expiry
calculation") in v5.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [09ea3eb9a518565f5bca386e81b993ed8825f5e8]
stable/6.18: [f9cec313efb2fd18d962aad738a4892bce806016]
stable/7.2: [9843649196221152b6e5d138a3ce859bdaae1d96]

CVE-2026-89686: nfsd: fix BUG_ON in nfsd4_alloc_layout_stateid on
racing delegation revoke

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89686

Introduced by commit c5c707f ("nfsd: implement pNFS layout recalls")
in v4.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ca94ba36172046be6a694a7986f6931e47ed4d51]
stable/6.12: [c517f27498757e616d2a8fe6d16caad1fee422e6]
stable/6.18: [607a56fea772c1f4f4989d8e255dd4f7192d9604]
stable/7.2: [97bda8b4284d90897a1f1922e5082ff9e35d7c7e]

CVE-2026-89687: nfsd: ensure nfsd_file_do_acquire() does not use a
non-opened file

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89687

Introduced by commit 64a989d ("VFS/knfsd: Teach dentry_create() to use
atomic_open()") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5859cc01fee06a2cd7458905a9593082fbab06e1]
stable/7.2: [a95a1cffacd0203100297001719160160f443dd6]

CVE-2026-89688: nfsd: drop the stateid, not the stateowner, on
seqid_op replay retry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89688

Introduced by commit eec7620 ("nfsd: replace rp_mutex to avoid
deadlock in move_to_close_lru()") in v6.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5e4627d3513e60accfce9d5f4c7fa95251ef93d6]
stable/6.12: [69ed78b6b947c9257213164678b4edf17533093b]
stable/6.18: [00843074d9b84824552c9679d423d29500ca5de0]
stable/7.2: [f7cb90ddc021747fc9abfd4cf5252d425fd34eec]

CVE-2026-89689: nfsd: don't free session slots that are still in use

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89689

Introduced by commit fc8738c ("nfsd: add support for freeing unused
session-DRC slots") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5d22e372f4ac3eb287037a488c29691d52a6330]
stable/6.18: [72d40b103bb03f0124d3a3c8f71a30cbafaf6afa]
stable/7.2: [b449b134e7762ddf98653a4b1d3e76d2d212ea64]

CVE-2026-89690: nfsd: defer vfree of compound ops to fix rpc_status UAF

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89690

Introduced by commit bd9d6a3 ("NFSD: add rpc_status netlink support")
in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fca26a3fc19ed02278aa2a150af82d43db0302cb]
stable/6.12: [48f72aff24f7a7329209dc6cbc27c869f3e3595c]
stable/6.18: [6703199f4d7e7f37d6a726a849eb358e8fae72fb]
stable/7.2: [19413ccc45070a7270b9e25c2a258daf7f91de42]

CVE-2026-89691: nfsd: clear opcnt on compound arg release to prevent OOB read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89691

Introduced by commit bd9d6a3 ("NFSD: add rpc_status netlink support")
in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae4c38555e81563b8dc5eae55ffd70f0ea97aa5a]
stable/6.12: [58bcdfb2b2e412088839ae740b1a95154dc0b8d0]
stable/6.18: [e879148867bd4c4cac42e063ffaffa187dddc6fe]
stable/7.2: [c1a4f7b1848f95302df598217e1c7a1410c2d0c5]

CVE-2026-89692: nfsd: clear CALLBACK_RUNNING on failed delegation recall queue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89692

Introduced by commit 1054e8f ("nfsd: prevent callback tasks running
concurrently") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b036727d334b1b7cd4c1f1fba3b59ba93a6bbe96]
stable/6.18: [b137930ee52e3ef38915a3511d4c070463b63a32]
stable/7.2: [cb2d0c4d1b3d301d042ed61365eaa8cb0141a254]

CVE-2026-89693: nfsd: check nfsd4_acl_to_attr() return value in nfsd4_create()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89693

Introduced by commit c0cbe70 ("NFSD: add posix ACLs to struct
nfsd_attrs") in v6.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [2c7912732184773dbd371a411da87af1cc080b86]
stable/6.18: [430ed49a16cf9ca249d0fb51490582090bc4848b]
stable/7.2: [80cebb0e8a8d1e758f0d671f5e047279c5c3e528]

CVE-2026-89694: nfsd: check client ownership when cancelling a
copy-notify stateid

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89694

Introduced by commit ce0887a ("NFSD add nfs4 inter ssc to nfsd4_copy")
in v5.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6bdbfab96e0cf25e5f57dac5c09dc1749751a4bf]
stable/5.10: [88daaed26e17e1c7e851859b5bbb4f0e1ab6d0e9]
stable/5.15: [81b2cfe767943922eca906a2a5af23a0ce5d0f35]
stable/6.1: [6bba72b8ee68ad631b94bd439592cba46de54d7d]
stable/6.12: [b1eca07303594ca27f5dc360a6946bd7e1f5b04c]
stable/6.18: [b42dc26a14b4ad5d6daaada11ec4c70744141c25]
stable/6.6: [75268f6cfe26b09a7e4d3216367e87fe9e2a26aa]
stable/7.2: [d801906165cb5cc250d5cbe44935594e170be3e2]

CVE-2026-89695: nfsd: cap decoded POSIX ACL count to bound sort cost

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89695

Introduced by commit 5fc51df ("NFSD: Add support for XDR decoding
POSIX draft ACLs") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4bc1108e876153a2dd6d874052b99182c3603135]
stable/7.2: [ea14d71d6ecb925673761bcf79f781f7dc9042cc]

CVE-2026-89696: nfsd: block non-SAVEFH ops after FOREIGN PUTFH to
prevent NULL deref

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89696

Introduced by commit b9e8638 ("NFSD: allow inter server COPY to have a
STALE source server fh") in v5.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c59738a00aa51b16adc1b5ceb7c80877168efb4d]
stable/5.10: [ffdc844e673d2bcb2af8c8c3eef8cdea59d0bf32]
stable/5.15: [00c84f4eec715e501efc080a5670114189e42507]
stable/6.1: [2d9846fd1c767920fddd4bde30eb35cd2969df13]
stable/6.12: [35f248bd40b47b229d4999581df45b97daadd977]
stable/6.18: [311f7d926630940650447cbd1c932b076b40a6c4]
stable/6.6: [977e6f006a7a3ffc4216ae6034f768f8de6fd138]
stable/7.2: [bf4d338dc8625d70c7f2cb0657d66851a7ac9154]

CVE-2026-89697: nfsd: add fh_want_write() for early-verified SETATTR
in nfsd_proc_setattr()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89697

Introduced by commit cc26508 ("nfsd: Disable NFSv2 timestamp
workaround for NFSv3+") in v4.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e475be769aa9f7a2c1ce55a2b8592cfccacddcc]
stable/5.10: [3eec9d791968c177a4a8cda9af5c04f79dae09cb]
stable/5.15: [9229d824b938f4fb0ea7a5dddade51735e6fe6f9]
stable/6.1: [2150305134889fb2fc25228d35353bd2f6f29500]
stable/6.12: [15ca3b64a69caa6194bed8f98a20ed90a11c11dd]
stable/6.18: [533964d420d385e11b08dd4c56c66ef5dcccaf08]
stable/6.6: [d823bf9285cdf4514873b85ab5a888878dd4e8f4]
stable/7.2: [c4a409b86a92815181a8e9395c6bf1696ad19175]

CVE-2026-89698: nfsd: widen nfsd_genl_rqstp address fields to sockaddr_storage

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89698

Introduced by commit bd9d6a3 ("NFSD: add rpc_status netlink support")
in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a99d720ed2a5258564e5e9d5f39f3184a030d354]
stable/6.18: [03c512f22d3fbe7a3767d6df5e3d88b8e7c105e5]
stable/7.2: [dcb69ad0dafb4a24b825183bb94055d5be8a10bd]

CVE-2026-89699: nfsd: validate symlink target length in NFSv4 CREATE

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89699

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [041f57056e5fb9c80adc088269322d2c61074406]
stable/5.10: [36011308b3f01ce7dc9954f3cefcbb5291af9f95]
stable/5.15: [888dad4b557352cf85be31613407b5ba51ad07d1]
stable/6.1: [8661d3cb38fd148947e57dbc0871fd4d3fa33bbf]
stable/6.12: [b24843ea3de1676b29902457b38507c95a80649b]
stable/6.18: [895a485cd3758031ef9993c0d53cf19ce8fb4ccc]
stable/6.6: [3ef5e7a01a4d74995a65496bc9166d1e980a4355]
stable/7.2: [45ec115cbfecb4b3cfab7fca6f73d1b60696a25a]

CVE-2026-89700: nfsd: validate sockaddr length per family in listener_set

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89700

Introduced by commit 16a4711 ("NFSD: add listener-{set,get} netlink
command") in v6.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bdcc85c2b05a9378d8bd2d65f9fc41440a3cf464]
stable/6.18: [2aca70c18c5f5d06004122861fb151d5fcc57faf]
stable/7.2: [22d0e4752ca88fd84196d22ebeedc905e6540440]

CVE-2026-89701: nfsd: validate nseconds in TIME_DELEG decode paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89701

Introduced by commit 6ae30d6 ("nfsd: add support for delegated
timestamps") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0f4a767340fad392bd656115b8752005518c9065]
stable/6.18: [7e7b93da7fa2e77f977096251899d1410986adf6]
stable/7.2: [5eb489831a9fd4754f4baf26e6989efb66ce104c]

CVE-2026-89702: nfsd: size fh_verify server sockaddr slot by xpt_locallen

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89702

Introduced by commit 0513828 ("NFSD: Instrument fh_verify()") in v6.0-rc1.
Introduced by commit 948755e ("NFSD: Replace dprintk() call site in
fh_verify()") in v6.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [71d068490098b1d23c63b2345e40675d3a1ca763]
stable/6.12: [95d064f9828a20ccca5ae90a17be3e2076f25272]
stable/6.18: [7ff8d6363cffff45654ea85e319f7c0c54226012]
stable/7.2: [719a10e3f5f868c3c4ac3cf3648c5775d12034bd]

CVE-2026-89703: nfsd: set SC_STATUS_FREED in nfsd4_drop_revoked_stid
for delegations

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89703

Introduced by commit 8dd91e8 ("nfsd: fix race between laundromat and
free_stateid") in v6.12-rc5.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [650d370cfbc66a96dd14d517bd704689b5bda4e5]
stable/6.12: [d832a0587528853d45481d1faf75d4b5d062adaf]
stable/6.18: [1e4795766719ffd74b8cf0f2fde4a1350f8326bf]
stable/7.2: [a6d89032e5c6620d5bb44582a72555ce07bf1c2e]

CVE-2026-89704: nfsd: sample writeback error cursor before async COPY loop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89704

Introduced by commit 555dbf1 ("nfsd: Replace use of rwsem with
errseq_t") in v5.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [20a67a7d18221af736f124770c2c5e859b479046]
stable/5.10: [435e4246c7dfff2fbd76dfdbf91975d5d9f788c9]
stable/5.15: [9f539a1c0791f907eb4e6d04b43178d9962e2def]
stable/6.1: [4728504c021656128a07f4693af80ed4a5fcc863]
stable/6.12: [52b2db7a72e19ac2686fa4b2a52406661e7bf9e2]
stable/6.18: [8277d4a11ae2cb5495842be558fd946032c24363]
stable/6.6: [322422d66d1a04434a0dcc0c9d3a4c4b3f225117]
stable/7.2: [a1cbafe756cd5e6ab0e099062f37da7a5b081169]

CVE-2026-89705: nfsd: restore rq_status_counter to even on all
nfsd_dispatch() exit paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89705

Introduced by commit bd9d6a3 ("NFSD: add rpc_status netlink support")
in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f6045886fe3f14f269f683d64021b004a50d0efa]
stable/7.2: [b08c30f08d57f30699d36809d92f0b683dca261f]

CVE-2026-89706: nfsd: Reset write verifier when async COPY writeback fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89706

Introduced by commit eac0b17 ("NFSD add vfs_fsync after async copy is
done") in v5.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [f5cb2276954cb80987a93ef9f9dfbfdbfc0f10b9]
stable/5.10: [cc5f7cef0659a27c13dd33edd8e2f79257b095c6]
stable/5.15: [c6d2f6372c7e0f76b9c148ff7696aec64da0b5b7]
stable/6.1: [8a08ffe73eb2aa6bc6f88763da7e2b55bab6493a]
stable/6.12: [31d4d0a62ec4bafbcdbad142f11ab1f90794b1d0]
stable/6.18: [591134e059e3456180244a826d6917cdc183140b]
stable/6.6: [6b13d26cc21b6320a3c61d5e4cee2ce9a589b181]
stable/7.2: [bf0cd31a9abcb728c17d79b4c2cc533612a8b6af]

CVE-2026-89707: nfsd: release path refs on follow_down() error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89707

Introduced by commit cc53ce5 ("Add a dentry op to allow processes to
be held during pathwalk transit") in v2.6.38-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6cba08dc1922140d260cfeb30bbda4ee1bf869d8]
stable/6.12: [194316df81263519156ebe714c4a286bee00e5be]
stable/6.18: [467d56fd3ff57447a790c6dc3ede2d02a947d224]
stable/6.6: [085cfde7c2186acaad103f02d2c25435ad5224e9]
stable/7.2: [2bc4343308d85ee4e0dd3877b384306c96f114c2]

CVE-2026-89708: nfsd: RCU-protect cl_cb_session to fix use-after-free
on session teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89708

Introduced by commit dcbeaa6 ("nfsd4: allow backchannel recovery") in
v2.6.38-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01c5d5f58a5db9b0ee5afba2e49d3157788687b2]
stable/6.18: [f164eb52b6f3cbf40f07fe379f9f421f88e02f76]
stable/7.2: [13bdd486c3aad4fc19e6d8b9c3556a4b4c190b25]

CVE-2026-89709: lockd, nfsd: RCU-protect nlmsvc_ops dispatch

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89709

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [641e5e20852359b8c31149be4598884e30652f60]
stable/7.2: [3c461a1820088fb5889d73a6522369bde45527a9]

CVE-2026-89710: NFSv4.1: fix layout segment leak on the
pnfs_layout_process() forget path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89710

Introduced by commit fb700ef ("NFSv4.1: Simplify layout return in
pnfs_layout_process()") in v5.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee5a386cfe60f3f8286de16a9db8e1a08f0bc124]
stable/5.15: [f52188118d319b47d49ee91a897f6afda4879c59]
stable/6.1: [ad3e41855325e55623276660ef20fbc3b8ba087f]
stable/6.12: [7c5b0e813efd9124760d5fd1bfc6b229f03fb1a2]
stable/6.18: [36e3f13bf0728f4ce11ee8904cec82a783222f62]
stable/6.6: [a080bb69d30f11738d753a60d1eb733d627c2093]
stable/7.2: [32ac1b0b7f1cfa0d1a1faf9c72f4154046101070]

CVE-2026-89711: NFSD: remove flawed WARN_ON_ONCE from nfsd_mode_check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89711

Introduced by commit e75b23f ("nfsd: check d_can_lookup in fh_verify
of directories") in v4.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa0cf48a448c5a9fe1a1e880899ecd589ce39e6e]
stable/5.10: [ae251937c6f0237e5b555a5e4ba4595b8206e865]
stable/5.15: [e145e8d67a5d41c72d322e7f87ab474d39d9dfb7]
stable/6.1: [9f4434893a2783f7384d993cea883aff3fb7a52d]
stable/6.12: [b55b4d880bb080fa10eb08ba21a5d8679b8102fe]
stable/6.18: [7ef182a8fe9c12b0d936880b1e504840639aa009]
stable/6.6: [2ef131323999539038e306773c8256403834361b]
stable/7.2: [a275de3bac5635514ca830f2e46b5ff0e66b5c4c]

CVE-2026-89712: NFSD: restart ssc_expire_umount walk after dropping
nfsd_ssc_lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89712

Introduced by commit f4e44b3 ("NFSD: delay unmount source's export
after inter-server copy completed.") in v5.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [036c1b182f4da65363e79ec0ac276edc6b7296e5]
stable/5.10: [2b59029b8f24a99b5d844af2da3950d39d36eeea]
stable/5.15: [d9e151fea5ed706c1284adacabd869b0be745db2]
stable/6.1: [659ee3da073164e1e6e40dfcbc26eeed85845f93]
stable/6.12: [77de363d9a1c8cd35f20482782c612cda085791a]
stable/6.18: [4ed8d2317aef21cc2a9e5a55d6b59860b4b151a8]
stable/6.6: [60680ae7243b22de3d09be990d8e23bcfc4af837]
stable/7.2: [7377fa964b8aaf47cb04e5efcc4c82d15e8c2ce9]

CVE-2026-89713: NFSD: check truncate permission under inode lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89713

Introduced by commit 783112f ("nfsd: special case truncates some
more") in v4.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [b778e0e0a16759f22a70579c3cf8d254a40d4a7f]
stable/6.12: [3afa17d93ba8c925f49370c816c6dae5112d8c24]
stable/6.18: [d8352da196349182e1afd5a93308256cddc0a97d]
stable/7.2: [44086254479035de42ca3d286ecf25521d4e6325]

CVE-2026-89714: NFS: fix delegation_hash_table leak when
nfs4_server_common_setup() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89714

Introduced by commit f5b3108 ("NFS: use a hash table for delegation
lookup") in v6.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2092f5b38f88be306140c77aeeeb43fc1adacacc]
stable/6.18: [f3adf1643517357221422c05986d6de5df7b9913]
stable/7.2: [0fd2b9687dae36be5b84eab39b4c627bb7ab33b3]

CVE-2026-89715: NFS/localio: fix ref leak on nfs_uuid_add_file failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89715

Introduced by commit fdd015d ("NFS/localio: nfs_uuid_put() fix races
with nfs_open/close_local_fh()") in v6.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ca018c19e0ba38975e5ddc3ef8117d5b734313aa]
stable/6.18: [5215e734bf7cba18237155f8cb2a0accb60ca339]
stable/7.2: [9f59b05423ed381f8cdeaaae4bd6778adcb6865c]

CVE-2026-89716: zram: validate deflate params

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89716

Introduced by commit dc75a0d ("zram: support deflate-specific params")
in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec7607ac4717ff521c9c1e9d8271c26293345513]
stable/6.18: [923578d0f0d0703c3db61ab35dc37075ae53b0bd]
stable/7.2: [e23fac4ab2a5728386477b98a402a1042b21bffb]

CVE-2026-89717: zram: set default primary compressor in zram_destroy_comps()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89717

Introduced by commit 486fd58 ("zram: don't free statically defined
names") in v6.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [dde75313eed0b014c437f48dd75c0308b592cbf9]
stable/6.18: [5cec3e60e9f2d1324179df3aa91656f90095cf8f]
stable/7.2: [dea8f13c3dfad8b990f8ea96c997aabeebbc1d22]

CVE-2026-89718: zram: fix out-of-bounds access in writeback_store()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89718

Introduced by commit a939888 ("zram: support idle/huge page
writeback") in v5.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [894913e2d35c46ff19a77530907771ae57862b96]
stable/7.2: [07a82a66f8c1894d92e51d97542c32ebf2c51b09]

CVE-2026-89719: zram: fix out-of-bounds access in read_block_state()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89719

Introduced by commit c026534 ("zram: introduce zram memory tracking")
in v4.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [391f057f44a51cc9418da5cba78b014324174264]
stable/6.18: [e7dbcb7a561a21e9a8f5b5fa90bb95aefbd0739d]
stable/7.2: [5e458fa714a55b6b64a9fe0c6d4fa609609f9ec3]

CVE-2026-89720: ubifs: fix out-of-bounds read in signature length check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89720

Introduced by commit 817aa09 ("ubifs: support offline signed images")
in v5.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [95d27c1708bb6e8823c8e7c623f9abc2a91bf4bf]
stable/5.10: [ab7405bd86331cc2dbc8201699d4adc33bea75e7]
stable/5.15: [11abc34698cb3172badf8aa12e623f1bac98bbd8]
stable/6.1: [8cc3da72cf57acb4b77442ea8cec48425dff7c06]
stable/6.12: [f76b79d6e42af20682495bccd22f72c7164b0018]
stable/6.18: [a1dc246f98bb94233effa4fa3ec7bf84700bb7d1]
stable/6.6: [37a9d25a563f5f9103282954ce573c4a61321e7c]
stable/7.2: [83e1aa9f5f906c9b1f4949d0521f0f950a159d96]

CVE-2026-89721: phy: rockchip-samsung-dcphy: fix out-of-range max_register

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89721

Introduced by commit b2a1a2a ("phy: rockchip: Add Samsung MIPI
D-/C-PHY driver") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4486e75ba647bd8b98fc1f053101b40caceeed4b]
stable/6.18: [14afe18655c0951f4f85898f761bf92264e65ccd]
stable/7.2: [c1a62f9dcf531d56c56da2e4435386b6d264c69f]

CVE-2026-89722: PCI/sysfs: Fix out-of-bounds read in pci_write_legacy_io()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89722

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc76258d0132df1d831a5a29758bd448ca9c566e]
stable/6.18: [e892f05f1f790d5721cd8e3c561ed76da7e08bae]
stable/7.2: [7a99e9c7011905734cc2739038f2a224b6be0d1f]

CVE-2026-89723: nilfs2: fix slab-out-of-bounds in
nilfs_direct_propagate after truncation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89723

Introduced by commit 36a580e ("nilfs2: direct block mapping") in v2.6.30-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [45662dedb8f272ef7f16e69f13424c4bd0399240]
stable/5.10: [39005fd1ce654ffdecacddc406b9a038efe606e6]
stable/5.15: [bf49e6f6ddc12445a0330708b365de6458085980]
stable/6.1: [4a1bb1f9f24a935c9b3f4fbf98012fa6d4ad826d]
stable/6.12: [5d3783c451a546373662ee11ec17019273e68034]
stable/6.18: [448636c745a3f3b8582a0b8ce718c890a11c0fa9]
stable/6.6: [b313edfbc0c2a60f7ce09b2e81ee71909ab8ddaf]
stable/7.2: [28362e8ce51377afdec1782e661e808328a10514]

CVE-2026-89724: media: vicodec: fix out-of-bounds write in FWHT encoder

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89724

Introduced by commit 16ecf6d ("media: vicodec: Add support for 4
planes formats") in v5.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf4500ebf6fb57bf4ab83c3dd349a40257dbe2a9]
stable/5.10: [f7ae26c100a6c26c2a166d2c41e73188067b36bd]
stable/5.15: [6ea647e76c44387d5c1c635df4604c2154d9060e]
stable/6.1: [d40838a63f2bd6a3df0a6cdd8ff1d5c6366e8fff]
stable/6.12: [84cfebf7f4229d748cca8eb9c4e1f1c4099d3ab7]
stable/6.18: [8c14472431e27f13661d0db9d837156eaced0ecb]
stable/6.6: [e21cccc29b840930cd9dcfdf1139658063a681af]
stable/7.2: [b95315ffc66b39856396c1043618bb4e4d5785ba]

CVE-2026-89725: media: cec: stm32: prevent out-of-bounds write on RX overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89725

Introduced by commit d69ae57 ("[media] cec: add STM32 cec driver") in v4.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fb9dda38d4b9e90db07ed9a0ee2d35bf85494035]
stable/5.10: [f2499b720ea9b874d58770885c6c2e8445a8c3ef]
stable/5.15: [3df1a4026662121011187247897fe95fd84e8a3a]
stable/6.1: [37ac45f7d6e3a6a5dcf6452a0b7bad9a543e8344]
stable/6.12: [c3edd7fb8e3692423a702705509947fc9c30b3d1]
stable/6.18: [0c260d3f97e52978a8c769bb095ac0901333a3ac]
stable/6.6: [1b4fdefd788db990d1805feb5c7b2388de791ecd]
stable/7.2: [a85ce3b175615c2e13bc01e8a1b6b6b6910fde57]

CVE-2026-89726: lib/ucs2_string.c: fix out-of-bounds read in ucs2_strnlen()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89726

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cec0d03fe785380540dc1b4d07c80f67ae2ffc78]
stable/5.10: [04ae68af4107600120c3c41c94268f43bc350d48]
stable/5.15: [2e5a70a175f0c74e7238b013a96c4eabc3002934]
stable/6.1: [3ada20e110bf3245edb0a3bcddadc33d0f142f8d]
stable/6.12: [709eb41adaf78d59d4579a13a898125919b69bcc]
stable/6.18: [7d658da725ea81c91f73087547b97e7ced82d62b]
stable/6.6: [60c74f42f5abddb85dd919b4448d5474e65dbe76]
stable/7.2: [1b0dc3cbb8630f0b5cb34d848628225920a904be]

CVE-2026-89727: KVM: arm64: GICv2: Don't WARN on out-of-range GICV_DIR INTID

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89727

Introduced by commit 255de89 ("KVM: arm64: GICv2: Handle deactivation
via GICV_DIR traps") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c6d9c8ac6521d3049ec90ac58bebd23ed03ac496]
stable/7.2: [78b95c571d021391153a5ac7981e9e4d5cc856a3]

CVE-2026-89728: i3c: renesas: Fix out-of-bounds access for newdevs mask

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89728

Introduced by commit e721898 ("i3c: renesas: Add suspend/resume
support") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12

Fixed status
mainline: [50dec95c9d1f1f82819bc898ef2b60fa83fd4ccd]
stable/7.2: [769f5a233efcf8587f70fb2244a202d88582c746]

CVE-2026-89729: HID: sensor-hub: Fix out-of-bounds write in
sensor_hub_get_feature

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89729

Introduced by commit 5459ada ("HID: sensor-hub: Fix packing of result
buffer for feature report") in v4.9-rc5.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c92693f3ed099401d0383ef35ca1fe1e6ba033de]
stable/5.10: [1c0463f0f028801a933f090cd2695f132635b374]
stable/5.15: [4145aa149a32e4b35d5d47e380d0c6c438b4e6fe]
stable/6.1: [8bf8aaf2f74de64f801eb30bc38927dba1f8e40a]
stable/6.12: [fa95b14198b6c8ea721b4784f466d3c2c2bac83a]
stable/6.18: [9f43499ce6458a572b781f6bb46c464ab59fa825]
stable/6.6: [c5c60260a07e627084e792ea959ab468ccfa4d50]
stable/7.2: [bc3d72c44bff17688dc5f3e5132a53b51dae0f04]

CVE-2026-89730: fpga: altera-cvp: Avoid out-of-bounds read in trailing
byte write

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89730

Introduced by commit 34d1dc1 ("fpga manager: Add Altera CvP driver")
in v4.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9da70a43b5fea60d758137f7f0ccfe19356cb5bb]
stable/5.10: [447b3c893987a0106a65f04b62ec3271892e9d98]
stable/5.15: [3b8938f5fbcf4a918785f9cb4b108782eb4ea717]
stable/6.1: [2564ac3d3b8b47cd9692a5bf42d668ed7218b54e]
stable/6.12: [b138bc665e21d4422382ab43aebdf0a2b7bb9cb3]
stable/6.18: [827ec385458adeeda651de2b6f3537e386b1a8d9]
stable/6.6: [8f3365ed2a5db2ac95ab70a6c47561db39d24537]
stable/7.2: [4dc1051939e499c838229af035464a5fc7671198]

CVE-2026-89731: cxl/ras: Fix cxl_rch_get_aer_info() out-of-bounds AER
register read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89731

Introduced by commit 6ac0788 ("cxl/pci: Add RCH downstream port error
logging") in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [29458e62d0829cbc99435f3e44fd560f9bbf1da7]
stable/6.18: [8bd3523df1319edc61cd391e695c84a4618516df]
stable/7.2: [8e3d9dbb25d3ddbe72b4542ec4f7c4e622fe0ced]

CVE-2026-89732: usb: gadget: f_fs: Prevent deadlock during ep0 read loop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89732

Introduced by commit ddf8abd ("USB: f_fs: the FunctionFS driver") in
v2.6.35-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [569dd7e5dcffe1e1c6b26ca2cd3be57eb433e082]
stable/5.10: [fbe3db4b650c284df8eb4cb68eebcf270cf861b5]
stable/5.15: [30430509c156e1df2bdafd5f1cadb160e53db5d6]
stable/6.1: [bafddd0f20b5228760be303aa69c58502e92309c]
stable/6.12: [fd20cc68bbdb5620696ac108e8f2efd180fe2c1a]
stable/6.18: [34e88f53614640b59039a46717fb6142e9871022]
stable/6.6: [b0a6bfac0c3c3edf5b2ecaee87a09234601fe78d]
stable/7.2: [eac233e63f9db82ba874e3cccafaafab162999e0]

CVE-2026-89733: usb: gadget: uvc: fix dangling pointers in
uvc_function_bind() and uvc_function_unbind()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89733

Introduced by commit 0f9df93 ("usb: gadget: uvc: fix error path in
uvc_function_bind()") in v3.8-rc1.
Introduced by commit 6d11ed7 ("usb: gadget: f_uvc: convert f_uvc to
new function interface") in v3.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bdab5605259ba5d6ff927c1a85cc83eb3ecfdacc]
stable/5.10: [ddb1b0d5d858584ed0d3a5aaa042ee693998c7e2]
stable/5.15: [85dd5e8bd6776d02854f2847d83429f1f712e99c]
stable/6.1: [502a7f5b79b7ba751988789e982924f8f496129f]
stable/6.12: [8e88ed8a374de67270d38689f2a81018909cafbb]
stable/6.18: [9897b7da8c0ad8356c1b8649379fcb5a689462cb]
stable/6.6: [bec7708eb3b5295d12e931db24381b7c94c72953]
stable/7.2: [38f822ddce9355893d734279a26ddec45182197e]

CVE-2026-89734: usb: gadget: uvc: Fix null pointer dereference in
uvcg_video_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89734

Introduced by commit f0bbfbd ("usb: gadget: uvc: rework to enqueue in
pump worker from encoded queue") in v6.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5b1da38592efdc1a263d4c0353298cba19e9d6fc]
stable/6.18: [dbe2762ae8e543b06c57f1ac6512b02fd3fd09b2]
stable/7.2: [d511e015d06767f52bb18d48371cab6d7cb88433]

CVE-2026-89735: usb: gadget: midi2: remove default configfs groups on teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89735

Introduced by commit 8b64592 ("usb: gadget: Add support for USB MIDI
2.0 function driver") in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0f6bffb5008f0cba9cad5ded2caccc64466a6e54]
stable/6.12: [4beda67ee72e0c8df5b49951dd8b96f6adb25e02]
stable/6.18: [a15c2acd3083461f91725760e59dff88b33c28f6]
stable/6.6: [79dbedf40ad930f83839e564394dc5d1a54938c6]
stable/7.2: [9ea5dfb2bfef4f8a7e704d1921d8a790cb7fb700]

CVE-2026-89736: usb: gadget: u_audio: Fix use-after-free on sound card
disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89736

Introduced by commit 6c67ed9 ("usb: gadget: u_audio: don't let
userspace block driver unbind") in v6.3-rc4.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [858965947081d10d41d9a1010a540d3d5eea958b]
stable/5.10: [a7ecd1a04f4f485d7be6443d0f0b2c61a800cb82]
stable/5.15: [f983793f03148b097977f200298db215cd2d4438]
stable/6.1: [6f46762196f04464e1050a9ee94e72b917db9010]
stable/6.12: [c74ff0b1a0fca53d3ac185873c87d6a719b30a47]
stable/6.18: [4e747c864a88537e18b1ffc19a1954c9686bb8e1]
stable/6.6: [891a8d11f4d5eb50b2ce7570f4f98204a7a57493]
stable/7.2: [79a92896e2bb9471550c56fc23d8d93592f04c27]

CVE-2026-89737: usb: typec: thunderbolt: Disable work before freeing
tbt on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89737

Introduced by commit 100e257 ("usb: typec: Add driver for Thunderbolt
3 Alternate Mode") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [92090f6ff2acc81e9dd99881dcfb4f8c1bdaabd3]
stable/6.18: [ebb840d982a612261cfc8a7687735a140c6c7024]
stable/7.2: [0a25484fe22f621e151367a59a82330a22ac80bc]

CVE-2026-89738: usb: gadget: at91_udc: drain polled-VBUS timer/work
before udc is freed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89738

Introduced by commit 4037242 ("ARM: 6209/3: at91_udc: Add vbus
polarity and polling mode") in v2.6.36-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c27d13ce4bab80fbdf6523928071b6c24b37606c]
stable/6.12: [a2a602cb1e28d76a5398cec3fa21b0110385f501]
stable/6.18: [51a311eb97e91ce1aed3005cb71ccb2e30f8cce8]
stable/7.2: [557ef547d49ff5e6026a4d39bdd3113bd81d7688]

CVE-2026-89739: usb: dwc3: gadget: Fix use-after-free in
dwc3_gadget_free_endpoints due to race condition

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89739

Introduced by commit dcfe437 ("usb: dwc3: gadget: Reinitiate stream
for all host NoStream behavior") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9c855832790cd488d87de1885974f4c37cfe7358]
stable/6.18: [448e95c0f3eaa8d99f16ccae92ab94545f14413b]
stable/7.2: [93e08b13a7a30e4e78556d993720e0bc36231ec7]

CVE-2026-89740: serial: imx: serialize imx_uart_ports[] lifetime

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89740

Introduced by commit dbff4e9 ("IMX UART: remove statically initialized
tables") in v2.6.27-rc1.
Introduced by commit 9f322ad ("imx: serial: handle initialisation
failure correctly") in v2.6.31-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b0b29fdcb47907ae0296b8fe829e918e05e300f]
stable/6.12: [681696ae9e4a28bdf54893c807dfe4a6c08e30a5]
stable/6.18: [28b932202fcdbeb2ef58d89ce4363f480433c234]
stable/7.2: [7429dce56a73bc080a8c072edb167106f73a08ae]

CVE-2026-89741: Revert "media: v4l2-dev: fix error handling in
__video_register_device()"

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89741

Introduced by commit 2a934fd ("media: v4l2-dev: fix error handling in
__video_register_device()") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12
stable/6.6

Fixed status
mainline: [e7600f5cee5de14065f950807931d6e6d40fb2d7]
stable/5.10: [8b998c171ed875e402e1fd1c5cd619e4ca05e9c1]
stable/5.15: [3de14b4f681a1b3c6d375d98d9d37a55ebb85349]
stable/6.1: [8027f82c0f5474ed72448e160ee9778051fa1f49]
stable/6.12: [712ca1cf756de2557a116e0df55791bac0c9f99e]
stable/6.18: [aad08b5f67d2a8116e1a00bce2611c1513b10bce]
stable/6.6: [2ac009a65d2385e9f0799eaf9d9694a29153a161]
stable/7.2: [ce792b94e03882108019ba996c1a7c4d4e09be2c]

CVE-2026-89742: rapidio: mport_cdev: fix use-after-free in dma_req_free()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89742

Introduced by commit e8de370 ("rapidio: add mport char device driver")
in v4.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5cbef379a94b161726c5f504598bf4791d45cedc]
stable/5.10: [00c5ed913b0dc563fbeb8a97ea8916c03bbbbf6a]
stable/5.15: [fc79c07cdcde02c5b17633d78777de6ac2c14b29]
stable/6.1: [26ccfe7d69e27b0d933ae0a64a23a0cb9b9a85a6]
stable/6.12: [9a9929ec875ff20922c90c96fd544ae8a2a61a8d]
stable/6.18: [e6e925cc1f8067c65c7bec3da50a0ead3b3ef4e0]
stable/6.6: [bd8881c24a9520f9c3d3e855d866197f63e471a7]
stable/7.2: [211c68d817a3d9dc14c0026a59da7cac30f8147e]

CVE-2026-89743: misc: nsm: bound the device-reported response length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89743

Introduced by commit b987375 ("misc: Add Nitro Secure Module driver")
in v6.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [808e530654a5354e6df78863a5d61e4d44e67235]
stable/6.12: [339f19b9a6171289b0e797deb8bda80b9a1fcc30]
stable/6.18: [29e634a18957acda11383a15ab98a91c4ae9e294]
stable/7.2: [2aa0fb9c96f894a9c179a48e7522ea6705800adf]

CVE-2026-89744: device property: fix infinite loop in
fwnode_for_each_child_node()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89744

Introduced by commit 2692c61 ("device property: Allow secondary lookup
in fwnode_get_next_child_node()") in v7.0-rc2.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [1900692555826753adab8799a1a8d50bb1ee200c]
stable/6.1: [04004fa33730031392d987a9c1bbd8a0e1c4794b]
stable/6.12: [20ed517e416df89448029293304c9e180c26cd4b]
stable/6.18: [ba69d892ff4e4a58cc12a2cae106b112db3306cc]
stable/6.6: [f4ae79b5f00130aacaddb1f3eb2e5ef711fbf9e0]
stable/7.2: [9cb6b223ef02cb5c9777a852ae1ecf5796987eb6]

CVE-2026-89745: debugfs: Fix lockdown check for mmap_prepare

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89745

Introduced by commit 651fdda ("relay: update relay to use
mmap_prepare") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f81808de37338aac8e167f99bfae647b1b835c70]
stable/7.2: [e7f6a6b5741d16fdac7adaecbe0fa52ae756f208]

CVE-2026-89746: tracing: Fix use-after-free with same-name named triggers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89746

Introduced by commit 6f86bde ("tracing: Fix bad hist from corrupting
named_triggers list") in v6.14-rc5.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [a7318172aa332a161fb9618286e64454c827f8fd]
stable/6.1: [441aa6742dff70297b5f64533a07a6189a026e91]
stable/6.12: [477d762be4b0ffaf01429ccd88859e93b0ec28cc]
stable/6.18: [b1a49c22de01faf176d44e5caa765e237353a579]
stable/6.6: [3a8534664426c071c2dfb5b4ffa36b18a2abfd79]
stable/7.2: [83d1ae0406d8eade219a81b401e201702dd9dc55]

CVE-2026-89747: tracing: Fix use-after-free in trace_pipe read on
sub-buffer order change

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89747

Introduced by commit f9b94da ("ring-buffer: Set new size of the ring
buffer sub page") in v6.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [372f8534244d632ad5118e8a87a11291b01712d3]
stable/6.12: [05ebe1e1d7d38c2612bacfefe043a33572ae34cb]
stable/6.18: [ddbe921ed16a0ad2d9e09574c3f3aabec7528325]
stable/7.2: [7a49d19ff9baaf61217e5ec14199c18bc2d93ee4]

CVE-2026-89748: tracing: Fix retry exhaustion in simple ring buffer reader swap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89748

Introduced by commit 34e5b95 ("tracing: Introduce simple_ring_buffer")
in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0d3aed7b12cf37b74c7cc5265073d0263b49cde]
stable/7.2: [df02489aa3aa1834659f0d20c89f7d212047d268]

CVE-2026-89749: tracing: Fix crash passing ERR_PTR to kthread_stop()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89749

Introduced by commit e618700 ("tracing/events: add startup tests for
events") in v2.6.31-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [649bc7df3e5d7be6f7996a95084037dbf3cad1e5]
stable/5.10: [c1a4fb7aa290f158d50654d640292e49d9055fd1]
stable/5.15: [42ccb215ef0a552acbbd32f81009bfe4b278ba77]
stable/6.1: [98d06fb9865a490e12ebe32d65b9ffac6108614d]
stable/6.12: [12a499f741fc5be3731c8b0a0d909406575cc2eb]
stable/6.18: [adadf4192f700bca82abfda9fa6d58c0bf37cc04]
stable/6.6: [ceb1707aef5824cf024eb82d10787b7621e2ff35]
stable/7.2: [c40e0b4fa365969e67011529eabdfb66d1022256]

CVE-2026-89750: tracing/user_events: Clear copied tracing state before
fork duplication

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89750

Introduced by commit 7235759 ("tracing/user_events: Use remote writes
for event enablement") in v6.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [390f6bd8583d177029d9df4bea6667509e55a765]
stable/6.12: [63b39e49a4c9d68e010e96b26fc7374f0864f2b1]
stable/6.18: [25a0758cf6bdbfddac2be71124c9bd0692f4b0b1]
stable/6.6: [33ce55b368b64d65941867add00e7f288cbb8234]
stable/7.2: [b799f67119aff179719a0b1e12441ebbdaaf62f9]

CVE-2026-89751: x86/tdx: Fix off-by-one in port I/O handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89751

Introduced by commit 0314994 ("x86/tdx: Port I/O: Add runtime
hypercalls") in v5.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0f63e656b1c679d32ac595de29d10c03efca6a25]
stable/6.1: [c6875423ad849ac234ab9812eb72f37ff8a490b4]
stable/6.12: [222b7005e4519f633b4cd666226256abbab46a1a]
stable/6.18: [c4a22154870813d10aa0b4c734a574c726f9d4b0]
stable/6.6: [220011fe95fc78b2bc2d7d43893bc73957a5c811]
stable/7.2: [bb45f705c4440dd3c689328319b88dd28770bbb8]

CVE-2026-89752: mm: memcg: stop reclaim when a limit update is superseded

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89752

Introduced by commit 8c8c383 ("mm: memcontrol: try harder to set a new
memory.high") in v5.5-rc1.
Introduced by commit b6e6edc ("mm: memcontrol: reclaim and OOM kill
when shrinking memory.max below usage") in v4.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9477820c63cbf4d97114238f3d1ff10dfd6bee3f]
stable/5.10: [ebf762a393630d1582645be3f0fc22a674eb9122]
stable/5.15: [4ea0617b9e46d26c0a3e5af00308ea1931cc545d]
stable/6.1: [5c6f87d33733d96fba66ea4e78cd8b24b4d60a49]
stable/6.12: [39ec1e4183a718f448b2e9de681dcbdda18fce42]
stable/6.18: [95d87030cae7764805aa7c621c52871139297cb0]
stable/6.6: [8bf21ad3657305e28deafd9ef16a121407496bc3]
stable/7.2: [aab391074de96ed601eeca32daef9a8507d436d9]

CVE-2026-89753: mm/vmscan: report RCU-tasks quiescent states in shrink_lruvec()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89753

According to the .vulnerable file, this bug was introduced by commit
8315f42 in v3.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [25f52e81216884a7444bf07a606691feb09a94e3]
stable/5.10: [4f50593c9cbc883d8c9b50148a3e8a8b1fd35f57]
stable/5.15: [4cdc1bdf40944de5c6b118fef07ad23f07844338]
stable/6.1: [a67a00a70a7c8309ca47ea157ef3e8ed3d268f5b]
stable/6.12: [b5391676c61d94ffe3272dcf6723738b802f79e8]
stable/6.18: [3fd50239986302cb050d3649351bcec00fa9d5ab]
stable/6.6: [029c9408049f7f582230322057b7075bea594fd5]
stable/7.2: [cf3ba0911a1cf8680371ff113b90088edd01d2bb]

CVE-2026-89754: mm/pagewalk: fix stale walk->action escaping walk_pmd_range()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89754

Introduced by commit 3b89863 ("mm/pagewalk: fix race between
concurrent split and refault") in v7.0-rc6.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [aedf2efd18977e0cef7eb963166e2b1fcc0aa321]
stable/6.18: [895cd4ecbb2e03d7583103c65ee5adaae126ed6d]
stable/7.2: [c05cdc2ab365b98099386e6c166b9865a4f2a9d3]

CVE-2026-89755: mm/migrate_device: clear stale mapping after freeing swapcache

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89755

Introduced by commit df263d9 ("mm/migrate_device: try to handle
swapcache pages") in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [34a00895d032a414830d41106a09329ae6c251b6]
stable/7.2: [8ffedc6573a665cdc31ebe47eae7b32b78d0df83]

CVE-2026-89756: mm/migrate: report RCU-tasks quiescent states in
migrate_pages_batch()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89756

According to the .vulnerable file, this bug was introduced by commit
8315f42 in v3.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [efe8f86c0916f0f74eea74ae21a3b37f728c6bad]
stable/6.1: [8c6d63d434ebb85c6cf3dac1e70a171b183c6614]
stable/6.12: [4996a7bc01ef35570664854dac2530c604981039]
stable/6.18: [5dc0daff0341c6baba19c38f47d299ac831d7e99]
stable/6.6: [4757542649af56d894e25e30f57cd497dffad53f]
stable/7.2: [66734981b4d3c105223a13c827c9c73be18d91ad]

CVE-2026-89757: mm/mglru: fix and remove redundant unevictable folio handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89757

Introduced by commit ac35a49 ("mm: multi-gen LRU: minimal
implementation") in v6.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7e698e326b239a91ea15844817551921209e826]
stable/6.18: [54a58d6656dd403b686b247f0bad8507cbfb45df]
stable/7.2: [15d3a2a71c8bf7333d019d249ee33669e69e4275]

CVE-2026-89758: mm/mempolicy: skip non-present PMDs when queueing folios

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89758

Introduced by commit 368076f ("mm/huge_memory: add device-private THP
support to PMD operations") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2858b4027f491e6fdb8ee2d8923798b619bf2791]
stable/7.2: [3d927093b2add7ced588a926c3dc5d7a83f18596]

CVE-2026-89759: mm/kmemleak: avoid soft lockup when scanning task stacks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89759

Introduced by commit c4b2896 ("mm/kmemleak: rely on rcu for task stack
scanning") in v5.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d10d4e19e6daa487f0cd0ea6cba472325de92f9]
stable/6.12: [9a1b12c06c192290b8479de48f66f1e75d89c4b7]
stable/6.18: [3fc8044251de21555fb02c365fa681bab8b0db55]
stable/7.2: [1838c704bcb4fd3556cf67513c6f97a39099e35c]

CVE-2026-89760: mm, swap: don't free a hibernation slot that is in the
swap cache

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89760

Introduced by commit 0d6af9b ("mm, swap: use the swap table to track
the swap count") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [10d9012e83efedde8718ceaa5053f836e0c8596c]
stable/7.2: [a6df73156f2d85746c69adbf13d0f5ea200e0626]

CVE-2026-89761: apparmor: fix out-of-bounds write when null
terminating a label vec

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89761

Introduced by commit f1bd904 ("apparmor: add the base fns() for domain
labels") in v4.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f1e40193eef7f047e6b77cfb4b4cafdecd7a123]
stable/6.12: [9124e078ea2250d8d01d2162a550acb01ef5bf48]
stable/6.18: [28069434aef66b9d084f0609b7a29c171846815e]
stable/7.2: [36bdd0b45ec3f4822832a56e9db8674c8450dfce]

CVE-2026-89762: apparmor: fix cred UAF caused by
begin_current_label_crit_section()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89762

Introduced by commit c75afcd ("AppArmor: contexts used in attaching
policy to system objects") in v2.6.36-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f4ae5fab613dca01d6a2a8210dd832e009fcf47]
stable/6.12: [361488984d668235438faac28635f3632351407f]
stable/6.18: [587a6a92b93ec314c583bbf747413af170d42540]
stable/7.2: [580f777d6d9fd07fc034bd1aeba5c30fd48871a2]

CVE-2026-89763: KEYS: trusted: Fix TPM teardown ordering

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89763

Introduced by commit 0b6cf6b ("tpm: pass an array of tpm_extend_digest
structures to tpm_pcr_extend()") in v5.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5e2d672280d97d83de43031d93761b12dadd7b8a]
stable/6.18: [753c978f2400f9783eb524842a975d3ac950d511]
stable/7.2: [2f7541afbc57fe9d26769a22c31d8ce8790c9a19]

CVE-2026-89764: rust: devres: fix race between concurrent revokers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89764

Introduced by commit 05aa6fb ("rust: scatterlist: Add abstraction for
sg_table") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [acc516dfa1972d31836b50abc0115216cd0fccc5]
stable/7.2: [c7e3d57c705ab1053a6a1bbef96795e792da1540]

CVE-2026-89765: timers/itimer: Zero-init old itimerval before copy to userspace

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89765

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [18c7d85864e554adc8fad1e8d2e9d2cb6c3911c8]
stable/5.10: [6d4b937251386d9c6f968e7802f0cb16a8523772]
stable/5.15: [4ea70146ab9376092297eb8b622ef1792797f2cf]
stable/6.1: [a17b345daff46fec4af9f1ecbdf350208016dd15]
stable/6.12: [4c66719dd1e4023c5e3f7d050f1bbefec3dfbeb4]
stable/6.18: [2bf5e8f7c9bf4ad3be343a9a6e3e50a34264d25e]
stable/6.6: [bdfda99c5763822a9a888e8af0ad7d9312ffcfe2]
stable/7.2: [00ef529a5402f41eb1d227916437e237450719f9]

CVE-2026-89766: pidfd: hold exec_update_lock around namespace ioctl

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89766

Introduced by commit 5b08bd4 ("pidfs: allow retrieval of namespace
file descriptors") in v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9688a46802939da28f00cb40e8129615d5d4af39]
stable/6.18: [cf24ce48d60225fdbee68ed2058763a1fd172ff3]
stable/7.2: [e89318aa8629969e86548b05e7c19283af3f0efb]

CVE-2026-89767: ovl: fix double end_creating() on the casefold-mismatch path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89767

Introduced by commit dfc7da4 ("ovl: Check for casefold consistency
when creating new dentries") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [077ab8985ee278c3d8618182d335b0f0cd919e16]
stable/6.18: [2fa220bc0f84597cb6de665e5b5021c5901ddf00]
stable/7.2: [b1aa8ab78a8e87aee9e306971465408e059f839a]

CVE-2026-89768: fs: fix user path of nested backing files

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89768

Introduced by commit 6af36ae ("lsm: add backing_file LSM hooks") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [f2381b546e7e6a35c9fcee0d0ccb6c042a9aeb5d]
stable/6.12: [88c927a63dc717b6d46b20fe13ea713916e49089]
stable/6.18: [c03114634d342648bd34910aa8fb88007e92cc3c]
stable/7.2: [a35cc21355734e1acb89973d9be90ca8e4c3ed2f]

CVE-2026-89769: clocksource/drivers/nxp-pit: Fix IRQ leak on
cpuhp_setup_state error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89769

Introduced by commit bee33f2 ("clocksource/drivers/nxp-pit: Add NXP
Automotive s32g2 / s32g3 support") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [05520e035f8332c8e33f3011b5ca016fde61793d]
stable/6.18: [d53c29a89a15e56a1797f3ef249955e544782e04]
stable/7.2: [cdcd861123248e871c2ec2be968b0a1b2a5a34b0]

CVE-2026-89770: iomap: don't free integrity payload that doesn't exist

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89770

Introduced by commit 0b10a37 ("iomap: support T10 protection
information") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a8685b32c0718cc7b2cb4d6202e5a5b8e0a8e2d]
stable/7.2: [65651f1001aa3638909bc58c7b2b46160692757b]

CVE-2026-89771: ring-buffer: Fix subbuf resize race with ring buffer readers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89771

Introduced by commit f9b94da ("ring-buffer: Set new size of the ring
buffer sub page") in v6.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a5f63637890f03177146efddaba5ec7a1b4d61f]
stable/6.12: [6d666f0b8b36c0765cf19fbe6de5a7ba5a73aad9]
stable/6.18: [50f4a793c4ff24826efb0ac700989a5063cc53df]
stable/7.2: [0c7c517827a453128a8f58bfd849546a29813b27]

CVE-2026-89772: btrfs: write-protect folios during data writeback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89772

Introduced by commit 095be15 ("btrfs: unify folio dirty flag
clearing") in v7.2-rc1.
Introduced by commit a4ef54d ("btrfs: make
extent_range_clear_dirty_for_io() to handle sector size < page size
cases") in v6.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5376c9db45368eb210b4d71104ac00a59dc8b6e0]
stable/7.2: [074c715e0b498891c09fe7f11e1cd9d7a04699bd]

CVE-2026-89773: drm/amd/display: Skip Update HDCP Config In Transition State

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89773

According to the .vulnerable file, this bug was introduced by commit
5c9b8b2 in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d5164580a99477dcfe15cea101b153b1e63f1535]
stable/7.2: [f733276ae737e4d599d1e19de6722aee1521a154]

CVE-2026-89774: Bluetooth: SCO: hold sk properly in sco_conn_ready

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89774

Introduced by commit 27c24fd ("Bluetooth: switch to lock_sock in SCO")
in v5.15-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e37f6452d586b95c346a9abdd2fb80b67794f39]
stable/5.15: [50aae396dc30377bec8e3b181b8346f8fd38f7d8]
stable/6.1: [6e3840578aaad1a296aab1eaaa89ea3b7d5cbae1]
stable/6.12: [73cb063f5ec6ca51eb1e246c6d332563002ac277]
stable/6.18: [7199c78c3a3e399a4dc439d845826793880ccedc]
stable/6.6: [d141d9b769bcd1b747898528c5023270cda040f2]

CVE-2026-89775: KVM: arm64: Handle negative S1 walk levels in VNCR TLB
size evaluation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89775

Introduced by commit 7270cc9 ("KVM: arm64: nv: Handle VNCR_EL2
invalidation from MMU notifiers") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8053393680d4fa3eb962667d2be95dd39f0940e5]
stable/6.18: [be54a70067c7dbe1381157e8a238fa4b16ea9c05]
stable/7.2: [1c9fca34b9625a67a7f1a03c8604f3df760c6c49]

CVE-2026-89776: vxlan: vnifilter: enforce exact length of GROUP/GROUP6
attributes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89776

Introduced by commit f9c4bb0 ("vxlan: vni filtering support on collect
metadata device") in v5.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [984f831dda31b3a18f47454cf64989f65402879e]
stable/6.1: [e12c4663529699f457b2988c1dfedf4d13b3b3be]
stable/6.12: [a9ec10815199f9879ba080241dc555efb1daf324]
stable/6.18: [daebc7064a1b4c12c98e52c4bceede7f2fcd573c]
stable/6.6: [47bfcc871576eaef6c8edab6749acd4b317306ea]
stable/7.2: [ad32e564c62ebf5ba76dd60a22af52c69d54d17b]

CVE-2026-89777: vfio/pci: clear vdev->msi_perm after freeing it on init failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89777

Introduced by commit 30ea32a ("vfio/pci: Fix potential memory leak in
vfio_msi_cap_len") in v4.20-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [dc77acfeb979dded39b247b60fef0399536bfa77]
stable/5.10: [eb84cd81040e58dd05ac190f561f2115e3367249]
stable/5.15: [f0eea8f9013676b42289ec35941e848b8a543e19]
stable/6.1: [d665a1688af7f8fefd7c0eb04f2a37122ce007f4]
stable/6.12: [812f1db7f0755a19ef16ecdc5cec51bcabc5eda5]
stable/6.18: [533d0c5feef85ee6404b9f41d5564fac6971a008]
stable/6.6: [25cdd2a492d868cff1e519a60fe282909c52d385]
stable/7.2: [fda8fb7e8179561693a786a7af593f6b944a21c1]

CVE-2026-89778: isofs: fix out-of-bounds page array access on empty zisofs block

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89778

Introduced by commit 59bc055 ("zisofs: Implement reading of compressed
files when PAGE_CACHE_SIZE > compress block size") in v2.6.33-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [68d4d3e78150c7ed7d1195af63ad1e6ace30c661]
stable/5.15: [8b994ac5778a725982fd6a8a3afcaa068d4a93e3]
stable/6.1: [ad3249cdf9d4ba34bb8b1ff3956a4020fdfb5b0a]
stable/6.12: [f03425dcbe04aec3c27b9917e97d7d23a2908dda]
stable/6.18: [cd616aa0449a772a6956abf03358f0ff31720580]
stable/6.6: [85904076cece72ee3194646ad7ac8e6659d999aa]
stable/7.2: [9c6eace8d07e90f038c89eb3b756d65a7e259d48]

CVE-2026-89779: fs/ntfs3: validate ef->size covers the record's name and value

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89779

Introduced by commit 0e8235d ("fs/ntfs3: Check fields while reading")
in v6.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [c22f91d82cb9a29d22bdffdce6c803467984ad0c]
stable/5.15: [b27e68ad818a4ca2cef8f35f97e75d756714c818]
stable/6.1: [28a924c7e67e6d71abeb04860b61166fecb027fc]
stable/6.12: [077df8464cf24f8ffc82fb6efec2ae600686e699]
stable/6.18: [aab1880058ac767d3ea9388a9a7221c776c22c44]
stable/6.6: [d585ed08308909c7e6fefb4e8a258aeb29b19ff9]
stable/7.2: [c8a109c9e23a2c7fd548473dde728b2cb8188146]

CVE-2026-89780: net: qualcomm: rmnet: restore skb->dev on deaggregated frames

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89780

Introduced by commit 378e253 ("net: qualcomm: rmnet: Remove
unnecessary device assignment") in v4.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a66734a1c5e36525ea07e9f4547fddc51e916de3]
stable/5.10: [5aaa7409c1b4ca4c60d66e2afa99703bf4eb7ddd]
stable/5.15: [9b78ab84ddf97c06a8567edb62b6c0fd582f9a62]
stable/6.1: [9d18c6c6cd1666b2cb7915cad052e22abf520997]
stable/6.12: [b14c22c31d9e30f38ea1693ac06d318f32258f5d]
stable/6.18: [7abe769e72c792e5f9eb273813eb3ecd8389854c]
stable/6.6: [4bcef54e4a3355a62d9ad90729fe563435ec76c3]
stable/7.2: [200460a0793dc6af97d3b36d92ac245350ac26fc]

CVE-2026-89781: fs/ntfs3: fix out-of-bounds read in read_log_rec_buf()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89781

Introduced by commit b46acd6 ("fs/ntfs3: Add NTFS journal") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de603b9d377fab57a5e6432fa84a9f36b32c1636]
stable/5.15: [df099bfdb57773ba7f40f8a9dcc82e75af277922]
stable/6.1: [1b2d31f1083beb80c55d1152249f652c1445a559]
stable/6.12: [49f7cbc902b08b56eb7d2633163ecc57a0e7145a]
stable/6.18: [74a83aa05f73033af719771ab1f0c269928b4865]
stable/6.6: [700973cc65db405bde0368ccf88699390150943e]
stable/7.2: [53e56f7aa1d0f950a8bc2e4cdb3ba9fe45967531]

CVE-2026-89782: fs/ntfs3: reject restart table growth beyond U16_MAX entries

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89782

Introduced by commit b46acd6 ("fs/ntfs3: Add NTFS journal") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [111f8d74a19d85942ecbb3aba78f6f3c88e59391]
stable/5.15: [caa0ec3fc44a13d7c21d78e4722f4f05f87ccf56]
stable/6.1: [339e59996ff193adcf1c438cf05f19e753beb3a7]
stable/6.12: [be218a01aadffe33ed4fc73e25276d676ebbd09d]
stable/6.18: [aad605a450611e2a7b7cf9dd5724004d39192bfb]
stable/6.6: [ecde45cd81dc28f5696c312c5ce5a509962e9ab1]
stable/7.2: [967a5ff8a614d10126b6d46db1ac040948d6cb42]

CVE-2026-89783: xfrm6: fix out-of-bounds write in xfrm6_input_addr()
when secpath is full

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89783

Introduced by commit 9473e1f ("[XFRM] MIPv6: Fix to input RO state
correctly.") in v2.6.25-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d9e3bf34fec9a5d237e4b7cef4a707bc2e091bc]
stable/5.10: [91fc387f63c00ddfb5221127a17bac97549a8343]
stable/5.15: [68e8737fe8e72f085c608cff322b3d2de8340af1]
stable/6.1: [8fe2c53fb81f5ad5be43af2ad09583f7c78b4b77]
stable/6.12: [48996649222e95008cdb98cd58579e3fc8e5ee06]
stable/6.18: [0f679e0523ddfff3fb554336ceb874b0e51e9cd3]
stable/6.6: [bdcda866c89f9a8b1acdabf02d26cde9fbe501d8]
stable/7.2: [5f35a29a5eed3d80befd32050843ac88dea3d61a]

CVE-2026-89784: SUNRPC: check rpc_sockaddr2uaddr() return value in
rpcb_register_inet4/6

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89784

Introduced by commit d77385f ("SUNRPC: Fix rpc_sockaddr2uaddr") in v3.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd22370226a0d8109045d0831fd5aaadee921693]
stable/5.10: [04441b792ec40eb66349b5fab34b6a2090b5b2dd]
stable/5.15: [5a51c49ddb37b883566874aecc66bc5a2e617a96]
stable/6.1: [4a6095de8cb1858e05bdf70b3e7d6d7645c25041]
stable/6.12: [4e01022974355732e748ec8ebc97c558cb624ffe]
stable/6.18: [cda4aacfb0bbf5c0f90fd0b42c72c749635d1368]
stable/6.6: [12bf3e0182ccdaf3b412756a756d3944a7dacaa9]
stable/7.2: [eb476289c12cc22c8766f8a84eeb7ab46c4e8fb6]

CVE-2026-89785: fs/ntfs3: fix out-of-bounds read of INDEX_ROOT in
reparse/objid init

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89785

Introduced by commit 82cae26 ("fs/ntfs3: Add initialization of super
block") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2064bc663f89e61b8681c1fb9d1ce445de72063d]
stable/5.15: [eb80003744e32a7366a523015e4acfe0a2ac7d88]
stable/6.1: [bd631e2005290a55c8edda87363bc0d594c01705]
stable/6.12: [66c074eab6f966fbe48a0fc4b3a45b2a2e2df527]
stable/6.18: [64bb6000bfbdf241a6dd578199acd90321a4243e]
stable/6.6: [94fce1d3e74fe011e21f17490ba58491709fd7e5]
stable/7.2: [72caafbc95c5dca8266a942b8e96ad81d8d9adc7]

CVE-2026-89786: ext4: fix out-of-bounds read in ext4_read_inline_dir()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89786

Introduced by commit c4d8b02 ("ext4: fix readdir error in case
inline_data+^dir_index.") in v3.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9333cc809f0a89e001b814155a6cb8903a6274df]
stable/5.15: [d1e7c186555ad65554fd2f2b02f5a539aa35ae48]
stable/6.1: [5fd20d4e50dd6e460b3ea8e4396f8553d4526f8f]
stable/6.12: [b060861f662d4826dc700a1c3584243bb3474cfe]
stable/6.18: [6702c7da86d8cdb88d0fc57166286e115ffeb8c0]
stable/6.6: [1a1dea633b724a1c042dbcdb1fed27f410916688]
stable/7.2: [36bf17bb90cdf7a623499b624b05acde4d2feef5]

CVE-2026-89787: ext4: check dir entry fits before reading the hash
trailer in ext4_search_dir()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89787

Introduced by commit 471fbbe ("ext4: handle casefolding with
encryption") in v5.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c7e6b863d298f56522d0d08554bbea7f142e6588]
stable/5.15: [4d20106c536b73c4a8a02652dc85e35898baebf7]
stable/6.1: [61a395967de06edba58760e81907a272db749faa]
stable/6.12: [d8c184bec24b5a00ae96d704856d935eaded1685]
stable/6.18: [3933884bc3102898b458c53fbd1ac52eb9cdb8a4]
stable/6.6: [e94676a08af6312aa72d8a981232b281f9bcfcf5]
stable/7.2: [83663c0b739480c00cfe785675db87520ec484ed]

CVE-2026-89788: ksmbd: fix tree connection use-after-free in smb2_tree_connect()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89788

Introduced by commit 33b235a ("ksmbd: fix race condition between tree
conn lookup and disconnect") in v6.6-rc5.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [b5ec6c462aab1062cf5d1e667ba7c6442f737055]
stable/7.2: [4e30fbd26e84efa2e5cbec4eb11e126ac0c79313]

CVE-2026-89789: gtp: add synchronize_net() in gtp_newlink() error path
to prevent use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89789

Introduced by commit 459aa66 ("gtp: add initial driver for datapath of
GPRS Tunneling Protocol (GTP-U)") in v4.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d989e22ae9802c52c56ad4284d0caf26696cf6ae]
stable/5.10: [fcafb2b1430824bae4258c01a439ec97ca0c6973]
stable/5.15: [3ca3da5c305caa873ddb81e8c6b118143f6dd3d1]
stable/6.1: [6f815c2fb6ab20385f81c353cdad0ea3b88132af]
stable/6.12: [fd8396cfecbd904468c71362f08aaa25f96d5337]
stable/6.18: [7677eb2cbf2cc7446de474c01a6b06277c0051e5]
stable/6.6: [e3b9aa0773abd5d4ed90be41ce5306c146d5b09e]
stable/7.2: [8d85498016a5bb56339734a14c276209fa65bafc]

CVE-2026-89790: ipv6: avoid divide by zero in rt6_multipath_rebalance

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89790

Introduced by commit bd11ff4 ("ipv6: Get rid of RTNL for SIOCDELRT and
RTM_DELROUTE.") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2c26c2911dd1a363c488add4fb63eb5f0f28f87]
stable/6.18: [f30cf8fd9872299c0c27f9916252ba2b9f422dce]
stable/7.2: [f82b5dbb2fef65b52a62d5ffe05e0483c4385a83]

CVE-2026-89791: perf: Fix use-after-free when perf mmap() revival
races with the last munmap()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89791

Introduced by commit 5974145 ("perf: Identify the 0->1 transition for
event::mmap_count") in v6.18-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [58a8108bc73de0740d5b88150465d6690ea5f85f]
stable/6.18: [929cb3b9dc818dd9fa89d510d4ff2b255e42badd]
stable/7.2: [0c739f54f1c77f3a4643160cd2e031b6c2f2aab6]

CVE-2026-89792: ksmbd: prevent out-of-bounds reads in share config responses

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89792

Introduced by commit a677ebd ("ksmbd: validate payload size in ipc
response") in v6.9-rc3.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [f25e93768fcc5d8287e50b1ec52a42e4c276df34]
stable/7.2: [61a8d06600c8c397f9a7e01940479d4c94a82f5f]

CVE-2026-89793: ublk: clear VM_MAYWRITE on read-only ublk char device mmap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89793

Introduced commit is not determined.Fixed in v7.3-rc2.


Fixed status
mainline: [6e2b571b0a54755b06e092501913e1dfefe75d6c]
stable/6.12: [5befd06a72216869b607cf7724a4f16c6a2d3999]
stable/6.18: [e373c1acdbcf88cec533ece9f589020adaed0a78]
stable/6.6: [be41733c24be58e2a1ef718c80fafdfb98a40d5e]
stable/7.2: [fa5e1bc673ca59722608af67b27e65dba0c97926]

CVE-2026-89794: ksmbd: zero pipe read compound padding

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89794

Introduced by commit e2b76ab ("ksmbd: add support for read compound")
in v6.6-rc1.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [73f860489e3be2245598d1819226304fc5b87291]
stable/6.12: [f188a400dd5285fec5a84548fe8dca49eee01155]
stable/6.18: [d83a9de7cecd401c3d3e00ed6371194dcd7313e4]
stable/7.2: [be15b8da4a82cf1e1f9880b2661b90770606eec1]

CVE-2026-89795: PCI: Allow per function PCI slots to fix slot reset on s390

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89795

Introduced by commit 44510d6 ("s390/pci: Handling multifunctions") in v5.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dcc5bec09e23bbc4f9de055a11fce9937244f2c8]
stable/6.18: [2050d900f9adbd6d6f38d30e182bcd9ad3108467]
stable/7.2: [ecdcceed4d377b02d4ea036b65f83f962c38ede7]

CVE-2026-89796: mm/damon/core: avoid infinite kdamond_merge_regions()
internal loop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89796

Introduced by commit 310d6c1 ("mm/damon/core: merge regions
aggressively when max_nr_regions is unmet") in v6.10.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [123e4619ab6c8ab1c4cb1d7a58311a2af13929cd]
stable/7.2: [8a96a06e04d210845be5d9581c0e9e338947e8f8]

CVE-2026-89797: power: supply: ab8500_fg: fix use-after-free on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89797

Introduced by commit 1315163 ("ab8500-fg: A8500 fuel gauge driver") in v3.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [75b1e88d34254f4fb7753345e21bfee47abddd7f]
stable/6.18: [c660c017dec1fd7cd88e1103c5ae1aae6ce636bf]
stable/7.2: [013731074ab6a8d11ec209eee64c5b2656954479]

CVE-2026-89798: rpcrdma: arm rn_done before publishing the notification

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89798

Introduced by commit 7e86845 ("rpcrdma: Implement generic device
removal") in v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5b06f706374c37375bdff9d21cc10e61df925a92]
stable/6.18: [3c97b8e76ca2bba9e8770571413aed694068e78e]
stable/7.2: [ea0408273ccf5df1fb52d9a1b9db4d31600dcb36]

CVE-2026-89799: bpf: Disable preemption in bpf_get_stackid

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89799

Introduced by commit d5a3b1f ("bpf: introduce
BPF_MAP_TYPE_STACK_TRACE") in v4.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [15f1bd8574662f1b7b26aaa2e23ebf4066f0117d]
stable/6.18: [ccf481d73bce6e851cec364fe831c86fe66877cf]
stable/7.2: [c4efdc1d4cb3e9183e41a1b2a5e0901dbbb31cdf]

CVE-2026-89800: drm/nouveau/uvmm: clear the dirty flag when unwinding
an OP_UNMAP_SPARSE

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89800

Introduced by commit b88baab ("drm/nouveau: implement new VM_BIND
uAPI") in v6.6-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [38a62306c4266bcb3cd89e33c7111ee33096ebb3]
stable/6.12: [196ce9e5e93202da097062be24e404984dbc5ac2]
stable/6.18: [1101cbfe7f342e5eaaf7444965d4f1215abdac4c]
stable/6.6: [a129b2b875c148aba233ace8447a0c36ca3bae07]
stable/7.2: [c60033c172420179b7bbb3d1f843f8dc90164dc5]

CVE-2026-89801: drm/nouveau/uvmm: fix premature region free on failed
OP_UNMAP_SPARSE

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89801

Introduced by commit b88baab ("drm/nouveau: implement new VM_BIND
uAPI") in v6.6-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ccf930812f23b8259ef64fd3394d53b093e4651a]
stable/6.12: [88114e3a96582882e63b2f73aa7a5a9cf0d5073c]
stable/6.18: [24c25b182d17d1bdfde0088c96bdf6f93e8f46bc]
stable/6.6: [ba42d8a1c2c7629c61914df11a7d63ac77449ffb]
stable/7.2: [4083d24c2636fde7b18076115af52820d203bc57]

CVE-2026-89802: drm/nouveau/uvmm: fix NULL deref unwinding an OP_MAP_SPARSE op

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89802

Introduced by commit b88baab ("drm/nouveau: implement new VM_BIND
uAPI") in v6.6-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [412a6ceb56d501ef2f8202e26ab4b5d4dfbca566]
stable/6.12: [3bf493cf7ed0c2b3df728977a257e0d99b4db1c6]
stable/6.18: [b7dc03e09313d22a6d230b759de3b05d504c008f]
stable/7.2: [3857238de6bce6c1573e8cb86c37b067e5208f05]

CVE-2026-89803: drm/nouveau: unsubscribe the channel-kill event before
the fence context

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89803

Introduced by commit ea13e5a ("drm/nouveau: signal pending fences when
channel has been killed") in v5.6-rc1.
Introduced by commit ea13e5a ("drm/nouveau: signal pending fences when
channel has been killed") in v5.6-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [511585987d27d8cb668acebd399fc4deda23404c]
stable/6.12: [f5a79a9ebfbafb87ca7a896e8d6b5f33a98d097e]
stable/6.18: [f3830fdd6930e233d727f29eee1617f7e6a0e9e5]
stable/7.2: [1fef7553dc628295c1208a4f2ac2094c62886e5d]

CVE-2026-89804: drm/nouveau/dmem: fix mismatched DMA unmap size for large folios

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89804

Introduced by commit c322874 ("gpu/drm/nouveau: enable THP support for
GPU memory migration") in v6.19-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [caa1bc2a0a6ca19dcb90bbf88208b0fe2decd66f]
stable/7.2: [4deb29b9d33bfdb3de4d2d9944947ecf77221e42]

CVE-2026-89805: drm/pagemap: Fix folio allocation fallback and use-after-put

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89805

Introduced by commit ddeda61 ("drm/pagemap: Allocate folios when
possible") in v6.18-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [df72e55e754c8d449321ddddad19a8bd3cb8d032]
stable/7.2: [10e92e18e3dab081789d868878f2ecce6166948a]

CVE-2026-89806: drm/sysfb: ofdrm: Fix integer overflow in fb_size calculation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89806

Introduced by commit c8a1775 ("drm/ofdrm: Add ofdrm for Open Firmware
framebuffers") in v6.2-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c6f48e59ece0123f6a11527ad4d89b21c2d65b87]
stable/6.18: [ded6ad826fe0fd059333d3a3b3e1742c8e45ff41]
stable/7.2: [d9daf9a6e7a6f82ef338a09386eefc6807100d3f]

CVE-2026-89807: drm/amdkfd: guard against NULL restore_mqd in CRIU queue restore

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89807

Introduced by commit 48f0bdf ("drm/amdkfd: Added MQD manager files for
GFX12.") in v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6aa530642f95d5c48aa336416f94a35e7949b647]
stable/6.12: [19c73848493ab58e39649700da6de11710a36de1]
stable/6.18: [ebffa44e7a21ead59ac4b4264e8fc2cbb44c4a21]
stable/7.2: [c643c229babe2e8efc5eefe60e19d44868a643ff]

CVE-2026-89808: drm/amdkfd: Fix the case that vm range is hole at
svm_migrate_copy_to_vram

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89808

According to the .vulnerable file, this bug was introduced by commit
50ea50c in v5.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [520e345ffe05aabef1db82beda4288afb1757ff2]
stable/6.18: [ae806a95b28fcecb913430cfa45a252e91a945d6]
stable/7.2: [0a9a0e8a97da70a0336c9115178aaf1be29bcfb1]

CVE-2026-89809: drm/amdkfd: fix scope of mqd_mgr dereference in pqm_debugfs_mqds

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89809

According to the .vulnerable file, this bug was introduced by commit
e1b73b6 in v7.0-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [012a026bae0212952b423a842b7e2c0bf21f8e7a]
stable/7.2: [58e866711b234571b0ce342c43d153a4786b32b8]

CVE-2026-89810: drm/amdkfd: Fix error path at svm_migrate_copy_to_ram

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89810

According to the .vulnerable file, this bug was introduced by commit
48ff079 in v5.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [960c4a8069bfd352c48cc88592618f1ebe24c69e]
stable/6.18: [da87bcad1f781d822e7ced6d1de9dbc6d381c72e]
stable/7.2: [a2035918a7a1d8fd3bb79d22e1e149294a5a8418]

CVE-2026-89811: drm/amdkfd: Add TLB flush after MES queue eviction/suspension

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89811

According to the .vulnerable file, this bug was introduced by commit
cc009e6 in v5.19-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [94e25cb6ab7f4f025bcdcd8ea79fda30f12843a4]
stable/6.18: [e230c546ed93741833ab5babb0b202f9c2052b45]
stable/7.2: [6aae545c87087e4dc96e205452243813bfa73ba2]

CVE-2026-89812: drm/amdgpu: force complete the MES ring fences on reset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89812

According to the .vulnerable file, this bug was introduced by commit
34e087e in v6.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [48dc279c3010ac8f91b1845b2abb3a1e9943a0f5]
stable/7.2: [ebe7542553d008e2285e0fbba0c63f0295a7e694]

CVE-2026-89813: drm/amdgpu: force complete the KIQ ring fences on reset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89813

According to the .vulnerable file, this bug was introduced by commit
65781c7 in v4.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd65d1742992361fc2201ecb4e43411e6e417fcb]
stable/7.2: [bdd6a58743e00ebc6d52b9cdf9aafb4e535e0b71]

CVE-2026-89814: drm/amdgpu: clamp the isolation index for rings
outside a partition

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89814

According to the .vulnerable file, this bug was introduced by commit
bd22e44 in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b30900566642ceb2c9e12b56c2afec28d0fd91a0]
stable/6.18: [964de255497ffd7cb8a86e405b8ac6d927e7e177]
stable/7.2: [0bfb938182d1313e5cac32ae38dbaaa4eabe4af4]

CVE-2026-89815: drm/ttm: Drop tt->restore after successful restore

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89815

Introduced by commit b63d715 ("drm/ttm/pool, drm/ttm/tt: Provide a
helper to shrink pages") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [941ac10529b3be5965a88d432a161ab459672ba8]
stable/7.2: [a46ab76b6cf5478e2ac7b942a377c7a1827b436a]

CVE-2026-89816: drm: Fix drm_crtc_commit leak if signaled when
PAGE_FLIP_EVENT is used

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89816

Introduced by commit 24835e4 ("drm: reference count
event->completion") in v4.11-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d4be202165e832d74849b4a68e289a2a377039c]
stable/5.10: [c5517b71101f61a45144e3cf77a19626355272de]
stable/5.15: [866a04137dac7e82a3848851061ff7ed15c2847e]
stable/6.1: [6a6a7aae4681a20cd32789fea9a487aaafa0e7a3]
stable/6.12: [ff73f5f43d032c3da3c534c517f661e8dfeb358a]
stable/6.18: [66b1b309886337745d395bbc158440ab196305ce]
stable/6.6: [e2f27b5ed9084feb7bae9ef2bc80de37c92280b1]
stable/7.2: [e6195b941fdc8d81fc431c9f25539cf6c6234b51]

CVE-2026-89817: drm/gud: NUL-terminate TV mode names read from the device

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89817

Introduced by commit 40e1a70 ("drm: Add GUD USB Display driver") in v5.13-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [500cb24cd61bad8a2747ddfc49b7034899c82d94]
stable/5.15: [08c8ec28547987e55a90c662f8795e05c2925498]
stable/6.1: [9096edfd6f2edbc79612b482547e0972edbcfe4b]
stable/6.12: [d0f3312f7800eb0e00d1264f66104c788f43dd69]
stable/6.18: [b86438a5c6b0250ccb07dd380184d1e70e0dea6c]
stable/6.6: [89210cb5ff8fdbe055c97ac688be2268f6c815ae]
stable/7.2: [6ea61f1d4cbaa0db937e31bffc041fb8afeacf52]

CVE-2026-89818: drm/amdgpu/vcn: fix integer overflow in dec_msg buffer
count check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89818

Introduced by commit b193019 ("drm/amdgpu/vcn3: Prevent OOB reads when
parsing dec msg") in v7.1-rc1.
Introduced by commit 0a78f2b ("drm/amdgpu/vcn4: Prevent OOB reads when
parsing dec msg") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [4d7390530853eb7befda9cc786e4c86e8ad7ac9e]
stable/6.1: [c2340281be4ddacb8c203e2bce59b126d1d6c4c8]
stable/6.12: [47799e1f893d47d8af231710a61065e3ec8a13e8]
stable/6.18: [7e28853c78c20bb8ba4c1dba702430cd05e09f76]
stable/6.6: [6dceaeceaa7c8396339f3ea34b0110cb912ca61b]
stable/7.2: [9ae19bd60891bea0a7b7504cc8dbfe74570ac3b3]

CVE-2026-89819: drm/amd/display: validate plane degamma LUT size for
private color prop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89819

Introduced by commit 980f871 ("drm/amd/display: add plane degamma TF
and LUT support") in v6.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e4c3ab59021e7c146a84b6671f0d530972bd58b4]
stable/6.12: [f6f04d8ae5725bcc893bdc62e3467efd97255c5b]
stable/6.18: [0b2615b8b54f58bbdf986dffb38cbc35214a5cc5]
stable/7.2: [b10cc09b329245c6d95f8fa3e7f068575e3e0e9f]

CVE-2026-89820: drm/amd/display: fix dc_lock leak on GPU reset error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89820

Introduced by commit 3cf7a0b ("drm/amd/display: Catch failures for
amdgpu_dm_commit_zero_streams()") in v6.15-rc1.
Introduced by commit 2b6943d ("drm/amd/display: Pass up errors for
reset GPU that fails to init HW") in v6.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [92a9eebd2a1f892fe482154d83f9f1626bc73d3b]
stable/6.18: [295d2bf42061db490254e748f9344545bb7faf19]
stable/7.2: [dac29cbb405b912742f4f7eda833cec8e7a53780]

CVE-2026-89821: drm/amd/display: avoid divide-by-zero in __is_lut_linear()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89821

Introduced by commit 086247a ("drm/amd/display: Use 4096 lut entries")
in v4.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f40873f8a4107df2b9c8e68c947c4fd0cd519d2]
stable/5.10: [2320626425f3af3a25b8afb6876f205b1c6d4e64]
stable/5.15: [d1e06d5dc8f12451ce71dc068342660a34476084]
stable/6.1: [c127ace7af2b40107947a6504391f94d6fd21734]
stable/6.12: [5f18cd1ba873e751bf5547407ad44ea34adfbe2f]
stable/6.18: [ee28fafb50f58b847509b5240b431ddec673bdfe]
stable/6.6: [4d5ee095a58461b2446d7a6eb0c14c2fe3eaab44]
stable/7.2: [15ee43aad0df43dfd1dbb32e7d5b951745c4b87f]

CVE-2026-89822: drm/i915: Guard against NULL driver_data in i915_pci_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89822

According to the .vulnerable file, this bug was introduced by commit
782a985 in v3.16-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3785d40831ba5601296283e0197e10e089392757]
stable/6.1: [2239e6b49d33bb38817d69b4f0bf7d5cbde2ec68]
stable/6.12: [e351cb2d373f6f1d4f1eb7c9f30dc058c69c89f8]
stable/6.18: [18b3433f10ee9c69e3252046028aa2be421f2d4d]
stable/6.6: [4a0236fe97732e31cb4a6dcb433642f9e3ef9a56]
stable/7.2: [84829e324a396668ceafb14723293b2863a74dcf]

CVE-2026-89823: drm: fix race between partial drm_dev_register()
failure and ioctl

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89823

Introduced by commit bee330f ("drm: Use srcu to protect
drm_device.unplugged") in v4.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb197f7d60f00d0f5b1b3505dfc86a7e36045a3e]
stable/5.10: [26d9162213952927cd59c0d94b7e0e992b347bec]
stable/5.15: [24d28d15c0f7f7d4a1c229f8730314f0f8758810]
stable/6.1: [6729990df9e70623bf53f855b521ae71ca9cb278]
stable/6.12: [19dbfe4d586aecfed121cb3fa62281761d9d341f]
stable/6.18: [79d09cfe90304ff4f195e47d569800f5e0f8b854]
stable/6.6: [a0a7e2e177f2f18b9e7318a4c64ac44efd9ef22c]
stable/7.2: [2d1215a72159d00001e08dee162e27718934bee9]

CVE-2026-89824: drm/panel-edp: fix i2c adapter leak on probe failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89824

Introduced by commit cc5a3fc ("drm/panel: panel-simple: Stash DP AUX
bus; allow using it for DDC") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e2a9e291275a74e309a21cbb1def6296a72d6aed]
stable/6.1: [f933d0f6fcd6280ce709553d394c30e9f7cc1b8c]
stable/6.12: [e048a11cf4649e03f194e16eb809e57ffc9eb5b6]
stable/6.18: [0259846b15a665c6762a86b3fa0eb8b674b35d1c]
stable/6.6: [8d9e6dffaea9b1282f8dc82f2d5e3cbd64e11fb3]
stable/7.2: [972afe6d5314037556bf6b3e635d7a06547064ee]

CVE-2026-89825: drm/panthor: fix firmware control interface bounds checks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89825

Introduced by commit 2718d91 ("drm/panthor: Add the FW logical block")
in v6.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6a47f9fd2d970674ed9dedc52fc7ab76fd015785]
stable/6.12: [33ae55809aee9b4dca1d00cdee35b527f2bf8626]
stable/6.18: [80c9528661c774f899281c9a72011208ff39929e]
stable/7.2: [3e5c7cddc0073eef6f9bb373189b11a969f1f6f6]

CVE-2026-89826: drm/panthor: harden firmware build-info bounds checks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89826

Introduced by commit 2718d91 ("drm/panthor: Add the FW logical block")
in v6.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8321b093fa6c297b80586460ce6914d9655df170]
stable/6.18: [5516f1acfd07564361cf306cc90a8e513df0f096]
stable/7.2: [6ae19dce3e8c13ae73590b3f4311abe9f96bbae8]

CVE-2026-89827: drm/amdgpu: avoid force-completing uninitialized UVD rings

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89827

Introduced by commit 0a33b11 ("drm/amdgpu: mark force completed fences
with -ECANCELED") in v6.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6760f5cb12d2366ddd58a2d8637f7583d73f596b]
stable/7.2: [967a179463d3227dfaf9200fd654c1f5a26a11e8]

CVE-2026-89828: drm/amdgpu: Fix init ordering in amdgpu_vram_mgr_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89828

Introduced by commit 2b624a2 ("drm/ttm: Handle cgroup based eviction
in TTM") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e773798e14ac0aea54ca9676083b91f445e5bc59]
stable/6.18: [e184e46ca1ba652ab8053a10a51b39aad06d3f5c]
stable/7.2: [3e234c6face8651045f46895dfe9c086ea64f03b]

CVE-2026-89829: f2fs: fix to pass folio->index to
f2fs_sanity_check_node_footer()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89829

Introduced by commit 0a73610 ("f2fs: fix to do sanity check on node
footer in __write_node_folio()") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [7e188e9f9437ab47c3237d609f1b26348d6fea1a]
stable/6.18: [a984446aa9d5b787afa3023fc7b44017b80fe3bc]
stable/7.2: [0b196c07407f48a41cd9741cf53e10cb1e23d2e5]

CVE-2026-89830: f2fs: fix valid block count leak on data block
allocation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89830

Introduced by commit 7d009e0 ("f2fs: fix to handle segment allocation
failure correctly") in v6.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0f9af07ecc1ab486038373db6ae0436c5d674b19]
stable/6.12: [2d50b6d47e5671ff6a25834c5906d443356191f0]
stable/6.18: [dde99df5a9d3b0ca6ac0a86f98799685f7399432]
stable/7.2: [931e1aa4d44c52ff8e0feb38420a8827c62e886b]

CVE-2026-89831: f2fs: protect critical_task_priority updates with s_umount

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89831

Introduced by commit 5219093 ("f2fs: sysfs: introduce
critical_task_priority") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e4692c6c165e81b2cbb847d8da4b45a53483b33]
stable/7.2: [bee6dfcc111b1dffdb3e13d73b7028b699fa0165]

CVE-2026-89832: f2fs: fix to clear dirty flag on folio in error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89832

Introduced by commit b42b179 ("f2fs: fix to do checksum even if inode
page is uptodate") in v5.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [5b86eab84ac8e9289b5afc52ef88ab18ba5bacab]
stable/6.18: [ab35ae07f2b5b4e118ea47b88577fc7d0e797b17]
stable/7.2: [3923ec2b98c96dda4a8bfab81d22553dbf0dd6c2]

CVE-2026-89833: f2fs: fix to avoid potential deadloop in f2fs_fsync_node_pages()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89833

Introduced by commit 608514d ("f2fs: set fsync mark only for the last
dnode") in v4.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce366bfa821ec81dd45bde547ee31e659306cc61]
stable/6.18: [161513f53e4ac90fd356433bdf8e31e6adeb92af]
stable/7.2: [905411f6504876d268ba8dafc8e75367782da4b7]

CVE-2026-89834: f2fs: fix to migrate all curseg types during free_segment_range

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89834

Introduced by commit d0b9e42 ("f2fs: introduce inmem curseg") in v5.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ec06f50ddd8d201bd7e55b896ae28ed9d4cb7d1]
stable/6.12: [3b85edf3391f3e1f624f409a7d2d239885f567b7]
stable/6.18: [b8ae1228c153622afa71a179c9d4dc268117e0f0]
stable/7.2: [b9776094aa7118e8e5dfdcd791ffc8330c5ca408]

CVE-2026-89835: f2fs: avoid NULL checkpoint thread access in sysfs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89835

Introduced by commit e659206 ("f2fs: add ckpt_thread_ioprio sysfs
node") in v5.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5cb33b00c8fbb6e8f1fa3d281c3036d5f7c7c41f]
stable/6.12: [a6573f3ffc19542de9ebc1a2b1f930fd48ba538c]
stable/6.18: [aefcec3bebdeed2bff444378122300763325ba23]
stable/7.2: [8f3b99c50dd0da1777994ce7c7e60d39b9f60f4b]

CVE-2026-89836: f2fs: fix folio_nr_pages() race after put in large
folio invalidate

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89836

Introduced by commit 05e65c1 ("f2fs: support large folio for immutable
non-compressed case") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0dab71381f1b4d12dc2056f8bd5aaa9d93ce9082]
stable/7.2: [cc34df18da92f68f9b384c3ae95ad64be46cb5ee]

CVE-2026-89837: f2fs: fix dentry folio leak in find_in_level

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89837

Introduced by commit 7ad08a5 ("f2fs: Handle casefolding with
Encryption") in v5.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cca7d3e30bf30333314e31bc70b9a739f1342167]
stable/6.18: [aefb4b0f465b6f95fe02b52d1822a3fb4a9ae922]
stable/7.2: [93a3e6a4c9e726a13a935963e8dc43d181db1527]

CVE-2026-89838: f2fs: limit recovery filename logging to stored length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89838

Introduced by commit f356fe0 ("f2fs: add debug msgs in the recovery
routine") in v3.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01027b2fcb74dade59fb833b51023f6593b6a9a2]
stable/7.2: [317d32e1a8deaf1c01c388badc667334c39e62ca]

CVE-2026-89839: f2fs: use the mount idmap for the owner check in
f2fs_xattr_advise_set()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89839

Introduced by commit 01beba7 ("fs: port inode_owner_or_capable() to
mnt_idmap") in v6.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a54ffce4637acb0db8e695188a6c7f99f14c3576]
stable/6.12: [c3e2692c7a58e0bdb84bd658d827e89dcecea3ad]
stable/6.18: [3b681229e9f8fb1dd29bc65983bf3c87779e4ca3]
stable/6.6: [4c0c610b480cfbc57528aa1acbd6be12ed2a6fb1]
stable/7.2: [ab31e3b774f5d06b4489cef6c297b48c47c9dcbd]

CVE-2026-89840: f2fs: validate MOVE_RANGE destination size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89840

Introduced by commit 4dd6f97 ("f2fs: support an ioctl to move a range
of data blocks") in v4.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e533889fc26aea0cd83c90327063f272061dd820]
stable/7.2: [dcae1eeda53149f219dd6af93b3083b7271c1c63]

CVE-2026-89841: f2fs: only redirty pinned folios in redirty_blocks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89841

Introduced by commit 5951fee ("f2fs: Use a folio in redirty_blocks()")
in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [85171332742e741ccd6f401c69b6e0d698119e72]
stable/6.18: [445e4a1e6025ecd5312e9a95c1b234192c976ca1]
stable/7.2: [89c65ec3c18903de763cf567c96ab3ef60e5f3b0]

CVE-2026-89842: scsi: qla2xxx: Skip NVMe LS reject IOCB when FW not started

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89842

Introduced by commit 875386b ("scsi: qla2xxx: Add Unsolicited LS
Request and Response Support for NVMe") in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7e46ebffc5781aab3f1f5a5d4350addbb5833f4]
stable/6.12: [7c1fc75dd3fb6b6414508fbdf7aeed0d757c9120]
stable/6.18: [ac4b019ac07844d3f67ea5e48b1d982b2170d1a7]
stable/6.6: [2935b730211c5c1433aa6101fa3b55df2b63869a]
stable/7.2: [e9bfb56e2c1bda49d3c5442d824569d71eec07e2]

CVE-2026-89843: scsi: qla2xxx: Zero-init bsg stack buffers to avoid info leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89843

Introduced by commit 697a4bc ("[SCSI] qla2xxx: Provide method for
updating I2C attached VPD.") in v3.2-rc1.
Introduced by commit 9ebb5d9 ("[SCSI] qla2xxx: Add I2C BSG
interface.") in v3.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b93d3bb3afe1b44489927de1eb4e66e8536a5935]
stable/5.10: [1c820d0900e4aacd5020b989159f6b4b2f7d0d6a]
stable/5.15: [26bc6a2c235a70bfc9b6de412600208aca820e20]
stable/6.1: [5ab32dff910291b5e6bf6223f8a4003536c1800a]
stable/6.12: [708c0ec1e09c52fee24b74ce9398bf3f8d1c83fd]
stable/6.18: [4fe5790674097897a1af1367d1e384f7e5a62fb7]
stable/6.6: [947c6bfcf7f5ec924995bec43e3108b98c75b44e]
stable/7.2: [7881faf862ee301ecfe3adc0725bd2fa0021cd95]

CVE-2026-89844: scsi: qla2xxx: Hold vport_slock for host map update in
report ID acquisition

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89844

Introduced by commit 430eef0 ("scsi: qla2xxx: Relocate/rename vp map")
in v6.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7944039ba9cb5c3a935d17c91004e3b8649ff58e]
stable/6.12: [6ed66e2a67bbd22877008ff9aa64bd574a7fc011]
stable/6.18: [776e4e8cbcf155302f430ce9793d1502e3c113a0]
stable/6.6: [e8f1b0cb9782338c6341ceed816e9c1243743cdd]
stable/7.2: [7d0b3f745efb24c0aac5e06b49b3420bc65d23b9]

CVE-2026-89845: scsi: qla2xxx: Avoid req_q_map double-read in
qla2x00_error_entry()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89845

Introduced by commit a6fe35c ("[SCSI] qla2xxx: Avoid invalid request
queue dereference for bad response packets.") in v3.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [deb8abde83a799d2501f3977f6d6051000253f5e]
stable/5.10: [c845f2597787ef70159a32566669e308b2807a56]
stable/5.15: [fe04b31e386aee4cc3a18f07462af146037dc389]
stable/6.1: [1b995cf4157465357d66ba096e7cdaafab9972e7]
stable/6.12: [1c90b74e484ba48f31944fe04963d99e01ac3767]
stable/6.18: [5dd9bec8004ba93cee8b689bf54ce294f59e5e3c]
stable/6.6: [d79376fbd2a076de82c1cd8aa0b600b300c75a44]
stable/7.2: [35124cfa9898b2088ee72859e573e0876aff66fc]

CVE-2026-89846: scsi: qla2xxx: Bound rsp_info_len to avoid OOB sense-data read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89846

Introduced by commit 5544213 ("[SCSI] qla2xxx: Correct extended
sense-data handling.") in v2.6.36-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ca6d880d6c70cb7946e7b3e05d7285f271b6d99e]
stable/5.10: [125b12861c726e58448bb95d55b04851fb131d1f]
stable/5.15: [e57ace988bda5693f7b3645f652ea4b4220870ee]
stable/6.1: [6b08c0cb110a1fba92f99d655020198489699815]
stable/6.12: [ebc41dfc59d190956e0113e8bd90c28f6f21e8b9]
stable/6.18: [d7f7746ff031ae45724881261804f4bf5317c985]
stable/6.6: [be75ab791c9b3baca66c70ce03443afebc83acda]
stable/7.2: [f6e8977bce887481b2b2b0e2e14a791270741cfb]

CVE-2026-89847: scsi: qla2xxx: Avoid double completion in async IOCB timeout

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89847

Introduced by commit f6145e8 ("scsi: qla2xxx: Fix race between switch
cmd completion and timeout") in v4.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bb45bc4bd53c95a7bf6f782577b5ede94c0f8aa8]
stable/5.10: [71a7b6e3c7f121439f51a058e53d4a8e05b63dec]
stable/5.15: [7257b5e1fb6c9387714f66e01b79ec82b717eede]
stable/6.1: [f5b660e0b0d9190d8853c795c2522cc5f8c93003]
stable/6.12: [d6d856c722f40f0694ff755208552e658db6dd42]
stable/6.18: [9fa1d71233a82416492d9c9de9756ebe140fe714]
stable/6.6: [6e217a9482eabbd8b29847be334c74cf468d3544]
stable/7.2: [845d4abd92cd2f97551356c8b281ad6e197acb07]

CVE-2026-89848: scsi: qla2xxx: Quiesce response IRQ before freeing request queue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89848

Introduced by commit d745952 ("scsi: qla2xxx: Add multiple queue pair
functionality.") in v4.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [505753ec2594c6af09a601f0dd60be7d840c1d2d]
stable/6.12: [1486cc18be3e2b4c2a730f4a1b0448d009381b3d]
stable/6.18: [10e9f05f7fd0a103886a867ec8afe621fe4b906a]
stable/6.6: [7ac5be2a8609679fc6bbfea881360444a5ce8202]
stable/7.2: [157ca7d1af45f87aa14a286754f19c3f72386988]

CVE-2026-89849: scsi: qla2xxx: Reject non-SCSI SRB on status IOCB fast path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89849

Introduced by commit dd30706 ("scsi: qla2xxx: edif: Add key update")
in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0f41d07d72f2245208c45374ca8d0a1846cad667]
stable/5.15: [9204fb0888374083be74f799049649a17eab4191]
stable/6.1: [b7418198b45b327194b97f856fe8ea8daa91f3fd]
stable/6.12: [e38041b47c29316ba79b645e2ae0b713d216b1db]
stable/6.18: [e93aa3c5125d9a4352ac0fa8ba4a7f8f87881805]
stable/6.6: [8f0e31e7a41376abe7d6ca7cbee07fcf9de071e6]
stable/7.2: [29f1f9ad9e354cd0b6e4f6fc75ba09162d6a04d9]

CVE-2026-89850: scsi: qla2xxx: Don't query firmware state while chip is down

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89850

Introduced by commit b6faaaf ("scsi: qla2xxx: Serialize mailbox
request") in v4.20-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0cebe20dcffbed9c078fe30e2d18cd5046d9eff]
stable/5.10: [178d984e8875292582e4295cf559b2b11d3c9325]
stable/5.15: [cba780c01f72f8585ca81ad7304097f8b12ef339]
stable/6.1: [22f44f77da496bc355479c08a0a9dbc9ad42ba42]
stable/6.12: [7bc2baed8a3d6a1e2a3f6b78d245f25d1e18a749]
stable/6.18: [a194684853dceaa1d6b7a9a02bc12f479232ad9b]
stable/6.6: [b6a30baa29695fa0eaba4a3a04435a3c1a5cb63d]
stable/7.2: [a6374b508893de15fee78583a95f5099d7812e85]

CVE-2026-89851: scsi: qla2xxx: Fix FCE trace enable parsing in debugfs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89851

Introduced by commit 841df27 ("scsi: qla2xxx: Move FCE Trace buffer
allocation to user control") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [b7368687e3d11f51392d3c4774ec0263d5fbf31f]
stable/5.10: [b0c08c08a08b6cca0e7e192bcbe0514e41fcc55f]
stable/5.15: [9932cbd0b49d0a5ab8378d32650ffb51604ffa35]
stable/6.1: [f5e245164d187d1ee227140c8b2e83b67f59c1fd]
stable/6.12: [eff41f50461c238bd2c5cd20672a5b53e68d493a]
stable/6.18: [7203d4aed8f444e7376c2dee8d93577b37cf9989]
stable/6.6: [5762d992dddaf301e7fb78f797de407116847121]
stable/7.2: [aac0d3cb9199121d2ce5906e06f94b793fac1052]

CVE-2026-89852: scsi: qla2xxx: Zero mailbox struct in
qla2x00_get_firmware_state()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89852

Introduced by commit 4d4df19 ("[SCSI] qla2xxx: Add ISP84XX support.")
in v2.6.26-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9efaa782845b4d5fb3e01242be0d06ebc7428d8f]
stable/5.10: [f8fc5cc6b3284506c6ab83c822c48133377668bb]
stable/5.15: [f29695b1138ae2539c5cd6cdaba9b1b072aaa81a]
stable/6.1: [13d645a2cdb224d27205368f3e3c68bb160daf97]
stable/6.12: [1f49e861c18caf8eef7f0ad9a2c5034f88a6ba79]
stable/6.18: [e6cfb1ee18336aab41a0941d6d3ea5009aaafc05]
stable/6.6: [2f847f06bb223aa895eea91fc9e5e2d6314038eb]
stable/7.2: [9f31de4d07e4cde91dfc24522993a5fbb4d67083]

CVE-2026-89853: scsi: qla2xxx: Fix FCE trace use-after-free during firmware dump

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89853

Introduced by commit 841df27 ("scsi: qla2xxx: Move FCE Trace buffer
allocation to user control") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [53298efcbbb0f0438366d45cb7ed7e6d93dd5531]
stable/5.10: [423487f03e325b8665d20a2a3171fe012b1a4fa9]
stable/5.15: [7bd308cd893e8cce023d03a40a2f0adccaff0175]
stable/6.1: [edc464a4fc96e2720d166e7cc7e7a6827b086760]
stable/6.12: [ef9b89f6c92274c3670403fd06130ca25f685050]
stable/6.18: [8e7a26931b6111583cfeaf49c068f26524dc3af2]
stable/6.6: [6003e79148eca73d7cafb076f5be47e234d543d0]
stable/7.2: [41ef7edde27ac87d55ffc703da44e78aa8c2e896]

CVE-2026-89854: scsi: qla2xxx: Fix cs84xx use-after-free on host teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89854

Introduced by commit fe1b806 ("[SCSI] qla2xxx: Refactor shutdown code
so some functionality can be reused.") in v3.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [33d102102d925357c5fd172dd6672a27d74b3215]
stable/5.10: [8c1ebcade6aac58137f2645b579894301febabf3]
stable/5.15: [1d8bbc4344b9367d9d54731475d745fbc9ea28f2]
stable/6.1: [2c3b17ee53f034936f7398dbf4d143e608b7c35c]
stable/6.12: [fcf0804dfe05862007189ac9dc4dc2063be36de1]
stable/6.18: [8286a9095fb59751fba171afa2b4f590271c87d5]
stable/6.6: [ae09260be7454ed7630a913f147591a25e3a9d09]
stable/7.2: [122bf170c94a3797531b12fee580639a5dc893ed]

CVE-2026-89855: scsi: qla2xxx: Serialize flash version read in reset handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89855

Introduced by commit 8c2cf7d ("[SCSI] qla2xxx: Add a new interface to
update versions.") in v3.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f606ed93de0c4f1e7e3618779e9fad731455314a]
stable/5.10: [f1fc052f2a5890ea6dba80d50254dd6258b13386]
stable/5.15: [31bf2714abbb0aa5a8a03d15038f8920e1c74b21]
stable/6.1: [ae979c549cba684e67b6c047140f3a8d2439b298]
stable/6.12: [75460967619eda720c9a03767729157ffd171d8c]
stable/6.18: [8d116137119371349fb09685fe05413d8fc92efe]
stable/6.6: [9cef42a073a0bdeee7fb1b47221cda222d330d2a]
stable/7.2: [33735490789e5417851752974c0b1d23125559cd]

CVE-2026-89856: scsi: qla2xxx: Clamp MSI-X derived queue counts to
avoid truncation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89856

Introduced by commit d745952 ("scsi: qla2xxx: Add multiple queue pair
functionality.") in v4.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ebfd35c64433821bd5619a6d07ccc2df8b5b1de3]
stable/5.10: [cf623d32761b00f221a9cfded3303d56e84b429d]
stable/5.15: [9eeddbeaa896f39d943644b16d83a6ad0ceab255]
stable/6.1: [802068b9b683b8008fcccbf6e9ad133e597ec87c]
stable/6.12: [2efe50b2da829909023de4a2eb87badb7cfa53cc]
stable/6.18: [7a448f5ed0b283dbde4e9183dd1e98c221432dab]
stable/6.6: [e80adfeac61b4d5db7ffe0f5af43999c33a4145e]
stable/7.2: [33c77254e6e91f37c72c7fad4051777452b10de8]

CVE-2026-89857: scsi: qla2xxx: Hold qpair lock when sending NVMe LS reject

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89857

Introduced by commit 875386b ("scsi: qla2xxx: Add Unsolicited LS
Request and Response Support for NVMe") in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f743488e4a203049f27ec5d8cd0caccc483af01e]
stable/6.12: [b3a362466db6b8ec47cc537ac641ac197fa69b5d]
stable/6.18: [11834e5773e20fd3742d7eb900876e66b9e7d029]
stable/6.6: [7eb618877503edbf17aa65e357a81bda1fc8f163]
stable/7.2: [b02ff132017b28222187ebcf95ce7f4cb576cd36]

CVE-2026-89858: scsi: qla2xxx: Bound image count in
qla2x00_update_fru_versions()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89858

Introduced by commit 697a4bc ("[SCSI] qla2xxx: Provide method for
updating I2C attached VPD.") in v3.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de62cf265dbe309f34f144a6cdbca9240317727e]
stable/5.10: [af733bbfcf667af1871a2735fba2835b0da71efb]
stable/5.15: [a9706d5e754e77515a92bb532bd0d73644979a1f]
stable/6.1: [7e3154c97ec15460f715dbbe4097c255cce110b1]
stable/6.12: [f93e8039e6fd54a3c027c6184daf00b745b576a0]
stable/6.18: [7b22b4cb8822805cef7ba618da6f76e1474d68bd]
stable/6.6: [047f1f7ee6f85bde28abfdda9fa550191ddc0532]
stable/7.2: [f2d4f025b67fcbfb2bbbadd3b5a6a43c4b436514]

CVE-2026-89859: scsi: qla2xxx: Zero dport diagnostics buffer to avoid info leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89859

Introduced by commit ec89146 ("qla2xxx: Add bsg interface to support
D_Port Diagnostics.") in v4.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a152edab3854f01dd2daf3eaf8f32cbabdb3834e]
stable/7.2: [9fc03be982763a131913f84fe73b240ae45bca37]

CVE-2026-89860: scsi: qla2xxx: Initialize NVMe abort_work once at submission

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89860

Introduced by commit e473b30 ("scsi: qla2xxx: Add FC-NVMe abort
processing") in v4.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e85f6dbc85616de2172bce8eaf84b387a723cd1]
stable/6.12: [6a1b50c4879c2e6a034e8e85f9c055f0eea157c7]
stable/6.18: [67f0d5187c29360388f7e1e503c627ec45d01089]
stable/6.6: [b403700ac62fbf3c310196386e125879a182efcf]
stable/7.2: [f4aaa4a4e6f1da6f3abfd80e1917bef922287177]

CVE-2026-89861: scsi: qla2xxx: Hold vport reference in
qla24xx_report_id_acquisition()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89861

Introduced by commit 2c3dfe3 ("[SCSI] qla2xxx: add support for NPIV")
in v2.6.23-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [793cedee296fd819bfadc2a7ec4d52faf9c09a0a]
stable/5.10: [d09ef32af1e05d79f29b460521a20bc4e6fd2ecf]
stable/5.15: [4b7f0a95bfeb1d3673da4c29bbe9872a61bc1a69]
stable/6.1: [267533b28ddf2c9223d30ad7e6960fa9e936428e]
stable/6.12: [f6b3bcc7cb2f4c37464958b9fd97dc7f185ea297]
stable/6.18: [47272152a13d202d98496208f9bf382c1cf4d4fb]
stable/6.6: [f8d2eb510c063a8ca79a5dc766a4303d3925fe83]
stable/7.2: [d556f899964d184e6cb788f3fa9dcddcafe1ab2d]

CVE-2026-89862: scsi: qla2xxx: Fix BSG job leak on validate flash
image error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89862

Introduced by commit c2c6822 ("scsi: qla2xxx: Fix bsg_done() causing
double free") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12
stable/6.18 stable/6.6

Fixed status
mainline: [0fb52cc632464b0cd07f970341330466d772efe1]
stable/7.2: [e25241f9fa01fb0c088381a156d84a725b71c1ef]

CVE-2026-89863: scsi: qla2xxx: edif: Fix NULL pointer deref in RX SA
delete check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89863

Introduced by commit dd30706 ("scsi: qla2xxx: edif: Add key update")
in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c20ee380ca59c5a8646750c4849969a815924e2e]
stable/5.15: [e479e9b148456905d12711411484b94083c8ff58]
stable/6.1: [2191b0034a2f1307d421782e6eceddf8eec9e7f6]
stable/6.12: [96eb8a3fc9f7fe7ba32679fcf1d2fd7d251e7a8b]
stable/6.18: [94bfb61478bcb207d27f8cd24fd231421059519f]
stable/6.6: [de0c8ef3b900c5e971c82ef38c6f5c22c5f3d8c1]
stable/7.2: [75fd6d041c4a325ae37f4683e6678d3015988bb0]

CVE-2026-89864: scsi: qla2xxx: Bound i2c->length in I2C bsg handlers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89864

Introduced by commit 9ebb5d9 ("[SCSI] qla2xxx: Add I2C BSG
interface.") in v3.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0918ee2c0eeb4d7f45b82b3dc11e65c2d9b7ad59]
stable/5.10: [8f01f886cc5e7bbc16cbf1a9928fdebbc911e973]
stable/5.15: [2be39946abcde5a6416fb074ef728429e246a996]
stable/6.1: [522d6dcdc645d8f97d6b4cdfd6d8eea307f3ff0e]
stable/6.12: [32d6df14fdab71fe1ba304fd9a0db0411ea2e043]
stable/6.18: [97ca58b0fb026799b99e3d552d5f69cf9a3113ad]
stable/6.6: [9a756f277eb89f769dbf380f38245c270d31fdb5]
stable/7.2: [47049fdadc0eaa115e813735b827e1379c0d2cf8]

CVE-2026-89865: scsi: qla2xxx: Zero SFP DMA buffer in FRU/I2C bsg handlers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89865

Introduced by commit 697a4bc ("[SCSI] qla2xxx: Provide method for
updating I2C attached VPD.") in v3.2-rc1.
Introduced by commit 9ebb5d9 ("[SCSI] qla2xxx: Add I2C BSG
interface.") in v3.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b47d4a1547d9ef21b2e9d1a739fe2204d4be05dc]
stable/5.10: [a476377a66897549dd49bee319f4df66623417b7]
stable/5.15: [09703bc7c0be3a7a155b0ff5f21f6765ba3f519c]
stable/6.1: [97c45c75f5cdec96b1a4fba8b1d55d0dd01af1e8]
stable/6.12: [581590f560b74399151b3cbc88574424c2f3d2dc]
stable/6.18: [b157256c28086c434afd70cc78bf9b4d8caf1276]
stable/6.6: [84bde5ce4038d9ad811e5c994305bbfcbd7a9f79]
stable/7.2: [a5501c42256235523c4dddf799f032dfbf4f4c77]

CVE-2026-89866: media: chips-media: wave5: Resume device before setting EOS flag

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89866

Introduced by commit 9707a62 ("media: chips-media: wave5: Add the v4l2
layer") in v6.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a52e6f7923c17a672135b485ffd96fbd72f46267]
stable/7.2: [2215e55ee1e5e69ad53862d968360c5aa63dd3a7]

CVE-2026-89867: media: chips-media: wave5: Defer job_finish() only
when a DEC_PIC was queued

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89867

Introduced by commit a176ac5 ("media: chips-media: wave5: Improve
performance of decoder") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b694ba0a5526a69f78a6924982b1553154ccfd73]
stable/7.2: [63d758d2f9dba836d5ae597d317cde522e817cf9]

CVE-2026-89868: media: chips-media: wave5: Add timeout while stop_streaming

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89868

Introduced by commit 9707a62 ("media: chips-media: wave5: Add the v4l2
layer") in v6.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ae7faed2e60d6d07d9efdd962d20dcb15330ced]
stable/7.2: [c104f37b9f79d6c179c5f1a170d7f1da497ff527]

CVE-2026-89869: media: qcom: iris: use disable_irq() during power-off

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89869

Introduced by commit bb8a95a ("media: iris: implement power
management") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b9c2215bdedc9c532a7e9d57ec49ee1b6381f863]
stable/6.18: [ff98cd2b8b54cf96bccace2f7b7e4775cdccaf02]
stable/7.2: [d7f34cbaced92069400fc5d71fefe3cb4c748da8]

CVE-2026-89870: media: zoran: Avoid freeing a registered video_device twice

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89870

Introduced by commit 82e3a49 ("media: staging: media: zoran: move
videodev alloc") in v5.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [0735e0b5a96761a9ce277a238e834008ad92a0a5]
stable/6.1: [3ad6cf27505017a6794f5f96c31218c2291e951b]
stable/6.12: [4d99d8d0d895489064783601a516bd45812fa992]
stable/6.18: [f1c4f3885df1f09bcab5296d86834d104f865e86]
stable/6.6: [c4acac8cdc005b2d14b6cef5e215d264212857f3]
stable/7.2: [672dbccf4351370dad002d3c78dbb29ca1588f22]

CVE-2026-89871: media: video-i2c: fix kthread error pointer left in
kthread_vid_cap on failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89871

Introduced by commit 5cebaac ("media: video-i2c: add video-i2c
driver") in v4.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [76e379754ba618989f6215be608d5c04774a611d]
stable/5.10: [db0f4531aa55cfb0171684ebfffe3ff04b79d5a8]
stable/5.15: [0fac63cac6689588da530764ccb6ba55ee8e4d8b]
stable/6.1: [5c35d380bea60503c4fe0986fe1de6a3263282b3]
stable/6.12: [968c5213e34c48d35febdfd09cf3dc58ad039140]
stable/6.18: [52fd9d80c0cea7bf09e7ee36cad316e5c39b7fe6]
stable/6.6: [3d1b10d81fe54852ed953f4129577b733bbd6907]
stable/7.2: [0e7f2cd72a4f9268ee09a13b13f3339e7cc71557]

CVE-2026-89872: media: v4l2-fwnode: Fix fwnode leak in v4l2_fwnode_parse_link

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89872

Introduced by commit ca50c19 ("[media] v4l: fwnode: Support generic
fwnode for parsing standardised properties") in v4.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a6e86efd7f85e519bf48417f41923f8bd51f1597]
stable/5.10: [c9b5238d173ee9b94dcaa2b34244ea89c8024feb]
stable/5.15: [ccd8d1d80afab8b492a583ae81bfd295835bab2f]
stable/6.1: [d92dc4692834e04bc0ef1d0908589852050d1a66]
stable/6.12: [578c4bfa28bf21458ecdde2fd3fc429475f34c10]
stable/6.18: [3ced388b7908270529e5aa6d221840114b6c33bc]
stable/6.6: [ef609b3ce456f021320fee2fb7e45094a3ccf232]
stable/7.2: [881aafb139520570fd3390bf9938d7098b7fbb99]

CVE-2026-89873: media: v4l2-ctrls: validate HEVC EXT SPS RPS counts

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89873

Introduced by commit c9a59dc ("media: rkvdec: Add HEVC support for the
VDPU381 variant") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [796b5c6d4f1615d59d5d8fe5a38fae6bfdfe878e]
stable/7.2: [30f85a7c59113a8844b276efc010085a34f912e9]

CVE-2026-89874: media: v4l2-async: avoid deleting unlinked ASC entry
on link error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89874

Introduced by commit 28a1295 ("media: v4l: async: Allow multiple
connections between entities") in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47d82b605351c0e04f6365e42c8ffe2fcfdba615]
stable/6.12: [caac13f518d83974e9884d1eeda3d4cc3bb92978]
stable/6.18: [3345746e0957bce6c53644838e4955710a82a962]
stable/6.6: [d273571e531405426983c6a45ec635c7d0415eed]
stable/7.2: [a57d94026cb4fd7b3d258f0db2ad391cbccfaba5]

CVE-2026-89875: media: ti: vpe: quiesce overflow recovery before freeing streams

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89875

Introduced by commit fc2873a ("media: ti: vpe: Add the VIP driver") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aeaacc3001449d44b4ab7da56331121d1f3b137b]
stable/7.2: [fd5b4a14c87b21e1c9eaee603b01bb7fa7db45c8]

CVE-2026-89876: media: tda18250: fix possible integer overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89876

Introduced by commit 148abd3 ("media: tda18250: support for new
silicon tuner") in v4.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6dd8e257f7cafda7fbf10d81b3c55c9bba4825f4]
stable/5.10: [cf8e3b3d7d9a6a96f4df6246e2e14b32f58d889e]
stable/5.15: [4e21f0e5696d3148b183c7e21dd44f7dec0d07ef]
stable/6.1: [3e5568d554c5f6da2cbba45684295927ebefd943]
stable/6.12: [0e0fbdb4c9381e2ea647a3fe3bf39bdb02ea5b73]
stable/6.18: [7c62bd653563939ff0d0fdfd4b8c73c4f97a1dcc]
stable/6.6: [593b1172e5d548581dfdb9a63713088f5dfab255]
stable/7.2: [f1ba602afd5ee6609fd71a0d112d18e8447a485f]

CVE-2026-89877: media: saa7164: fix cleanup on resource allocation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89877

Introduced by commit 443c122 ("V4L/DVB (12923): SAA7164: Add support
for the NXP SAA7164 silicon") in v2.6.32-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [28e84c6e2e6753ed238ea097b2842a32a6a6879b]
stable/6.1: [daa5b32cdf7db81a07ee2a91ce092a363e7754aa]
stable/6.12: [69259c627009bf7621010ae9e997dad2dad3339c]
stable/6.18: [4d2048466af9e2c960c5be6dcd317e3b657d268b]
stable/6.6: [77f216f8de6221efb6f6c471bc9e598f1879825b]
stable/7.2: [fc65623524b5bf23baddc6ae688d954fba0d5de2]

CVE-2026-89878: media: s2255: check firmware size before reading trailing marker

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89878

Introduced by commit 14d9626 ("V4L/DVB (8752): s2255drv: firmware
improvement patch") in v2.6.28-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [330f2936ab768c7215322a476f033143e8891d28]
stable/5.10: [6f6a5b0b0a84c2de0e152f2841e57bc226db924f]
stable/5.15: [8eca0f85eeb0789be40e637bcf9a21c4265b6c6f]
stable/6.1: [ffc27411ea60b8a09f1fea3d664b65210fdeb454]
stable/6.12: [3e03f1209c1c8a45a7bc559f4ecd79d9b33f706d]
stable/6.18: [342632a4d8ba3fafc1556deee0b7a48dd7860336]
stable/6.6: [5626785b0e4665326e4d96736c106161da09b2f0]
stable/7.2: [7d221859ba45d7228d0138c9a3e55bd3bb31e14e]

CVE-2026-89879: media: s2255: bound JPEG frame size before copying
into the buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89879

Introduced by commit 38f993a ("V4L/DVB (8125): This driver adds
support for the Sensoray 2255 devices.") in v2.6.27-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e504cc888f42999dd76b6a43788c422610f2aad2]
stable/5.10: [32a595dd3e8634544e5cfbc47f906dff3d3c1ef8]
stable/5.15: [4b6f7bccc6559ae5c54573c284fe76eafc9989b2]
stable/6.1: [2542516a147bfad740e7e411c251b639fad260ff]
stable/6.12: [d2ecaaab6a4f165abb54cdf61be60030b5782bf8]
stable/6.18: [68d664f1b4efe525e99154b7058fcb0378bdaff7]
stable/6.6: [79f58f900dd221ab04ea74bf4eaf79fa3b0fcc77]
stable/7.2: [dd739517560c8d0ec4463a53e717bf40b988d7da]

CVE-2026-89880: media: rtl2832_sdr: release URBs and stream buffers on
start_streaming() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89880

Introduced by commit 7711389 ("[media] rtl2832_sdr: Realtek RTL2832
SDR driver module") in v3.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe50cdaebf12cd32ff9a44d92bfd6fbc2300dbd4]
stable/5.10: [f14a713a36a5c87568430e9770896f2a8f5bbbb7]
stable/5.15: [c819dea3a433ae790b829443fdcc1715d1586560]
stable/6.1: [0337ab0759285076a3f9dcfcc40906e69ab519b3]
stable/6.12: [8bcf11a239eac4e224ad856277de9a36c91b1711]
stable/6.18: [26a2a985bbeee3eaa6f80ff7de732161a171ec9f]
stable/6.6: [c91e8ae2b39c6da81f26f2c9877d3fd33a4465ce]
stable/7.2: [ac02b2c56ccef0788cea9b86990a8f349a3fc6d8]

CVE-2026-89881: media: rtl2832_sdr: use vb2_video_unregister_device()
on remove to fix DMA leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89881

Introduced by commit 7711389 ("[media] rtl2832_sdr: Realtek RTL2832
SDR driver module") in v3.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dabb047c62668f280998e29117c55e41aabac336]
stable/5.10: [234c46b95a032232e31fa5987b84fb8f87a9693b]
stable/5.15: [034b6a4f9589c04bc3f2bd5125658cd72d3e17c8]
stable/6.1: [0ef9f19010ae4ba93aca211ea8f0081b9bf7aab2]
stable/6.12: [bbf15e83c37d9ac938b7c35c02b748fe54230010]
stable/6.18: [7443b16b6dd8889a3b9c5236a09e7c58f0d11dae]
stable/6.6: [053581d4657c6b5289c5de71a4828d313c005189]
stable/7.2: [a0d9d9a3b41a1346c26af57aade6ba3f552fa171]

CVE-2026-89882: media: rkvdec: hevc: guard INTER_REF_PIC_SET_PRED
index underflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89882

Introduced by commit c9a59dc ("media: rkvdec: Add HEVC support for the
VDPU381 variant") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [052c5ed5a1d96a6b24fd50ccda16fc6841ee7ca3]
stable/7.2: [74938f83a8abbee8f502dfb5d94213b2497d1edf]

CVE-2026-89883: media: rc: sunxi-cir: Unregister rc device on probe failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89883

Introduced by commit b4e3e59 ("[media] rc: add sunxi-ir driver") in v3.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [479aa6fa8c50f1052f1451326ef7d4d586d340c3]
stable/5.15: [4655a591478e4b31a3396695a2457daad9d4c899]
stable/6.1: [4efd7146dcf959afe64e9c51531cd8f82e60eab6]
stable/6.12: [59951b8a87ef4fb4b5b9409f70ba07663681a040]
stable/6.18: [5b58d8c206f37525c8217171e1f3e91dd2fa55e5]
stable/6.6: [826763adbd8bd3137c5b3756650da473dc6216d5]
stable/7.2: [5e6f5bffaa80fc8ecce348ec0e34fed9d843e47e]

CVE-2026-89884: media: platform: mtk-mdp3: fix NULL deref on failed SCP lookup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89884

Introduced by commit 61890cc ("media: platform: mtk-mdp3: add MediaTek
MDP3 driver") in v6.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [90368323fb244da0504e3da37a182f8e89bcc3b9]
stable/6.12: [28548387d79d14c975e77787ebd1f051265e1396]
stable/6.18: [5026f927ef4150ba12da6f1098cf7952d77b14b6]
stable/7.2: [426ead7eed6d6b3c3f0fe0925c112ef73fc87256]

CVE-2026-89885: media: platform: mtk-mdp3: Fix SCP device refcounting

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89885

Introduced by commit 8f6f3aa ("media: platform: mtk-mdp3: fix device
leaks at probe") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18

Fixed status
mainline: [55793e4665b7f15151e6f5ab51ca980e73abed5d]
stable/6.12: [dce13bd9bade3ecc1acb7579397f24743850997f]
stable/6.18: [252850653569fdb1a259937e02325cf32c8f0970]
stable/7.2: [0259ade4c4ceaf1e184a7c1aea8071ad398f9b6f]

CVE-2026-89886: media: intel/ipu6: fix async notifier cleanup leak on
parse error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89886

Introduced by commit f50c4ca ("media: intel/ipu6: add the main input
system driver") in v6.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [abb1f808ceab5a3275f8a6b4e37cff17f9f781c1]
stable/6.12: [dd5943aedbe4d7eb46158cb35078257733ac48b6]
stable/6.18: [27b7997be552ee37b3e01beacfeb4131f1bebb5f]
stable/7.2: [eee6069e4e9511e814a33a75e403f7e863f70394]

CVE-2026-89887: media: i2c: ov7740: fix use-after-destroy in remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89887

Introduced by commit 39c5c44 ("media: i2c: Add the ov7740 image sensor
driver") in v4.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d1b3dea5a44124bab6c14a2d71b977dabed54e7]
stable/5.10: [9e4693436c7dcf8584002500ce4b434b79bbf9ed]
stable/5.15: [81e9765878d3ac8ad18e3a683332b5d6bc3a0e33]
stable/6.1: [8a02ee6c1c4e88f3a0442bd60d3c77db9a30db5e]
stable/6.12: [25e2505866c577db2661e4d431f0907c6ec9a3b4]
stable/6.18: [af81f35e4f429e769b784754e1aa4d7a922470ac]
stable/6.6: [7512838a19af0a284a58435292243fad21e57ff1]
stable/7.2: [09453b467990e8ef8fe09f45a685f9a625248d33]

CVE-2026-89888: media: i2c: ov02a10: fix endpoint parsing use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89888

Introduced by commit 91807ef ("media: i2c: add OV02A10 image sensor
driver") in v5.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [94971ba0592ca77ec99b292226a4b398763315b8]
stable/5.15: [9de48ba68f56de9fe20ebd3f9728d22af25f9a91]
stable/6.1: [8ddb3b69f67b0632ff3830da18de3e8dcaf5884b]
stable/6.12: [213b2489130357c8d3e8d4fb2bdab88791ce3185]
stable/6.18: [90f9b421fc6d4f2edab7521efdb1e58571468d33]
stable/6.6: [4c2988bf1ad2753240a38db10ce23e87ec542f8f]
stable/7.2: [6e13784452785cd8402b228bea53bc6a027ade84]

CVE-2026-89889: media: i2c: imx415: Release runtime PM reference on VBLANK error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89889

Introduced by commit 3bcae55 ("media: i2c: imx415: Add read/write
control of VBLANK") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bea3001e0f32527a291444e527e84a7ea9b546d4]
stable/6.18: [1aa66bb3ba440aabb3bfe65ba5f19bef86a0f823]
stable/7.2: [46c63cc1c1aefa08d3126000d5b56dabb62e801f]

CVE-2026-89890: media: go7007: defer the ALSA v4l2 put until card release

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89890

Introduced by commit d5d3a7c ("[media] go7007: fix
unregister/disconnect handling") in v3.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1bd456afeb8a515137e567967069fce6f8fcd23e]
stable/5.10: [1c57d1a3396b2d767d58f10dff09bb397586c714]
stable/5.15: [9c4f9628b8558c87903492a777834cc5be14ded3]
stable/6.1: [b7a0de398ad510426db9c8e96c516ef7abf48b0e]
stable/6.12: [29fe4d38fb59ec28ca656cb2dabc2b0f78e78980]
stable/6.18: [0745a59945d927652d892437f9647ed6e87c0677]
stable/6.6: [1c9fdd9465211432d5c0ff70caaec0be245823d5]
stable/7.2: [e6f1a1ac9b8ccabfec548aef0d0d93eaf4dba4f4]

CVE-2026-89891: media: em28xx: fix use-after-free of dev_next->devlist
on disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89891

Introduced by commit f410b40 ("media: em28xx: split up em28xx_dvb_init
to reduce stack size") in v4.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [826915b6b65e2d3251e7248ea54289a22d748c84]
stable/5.10: [f61720346fdcc1a2deec59a2f6cbb0cc20d1dc18]
stable/5.15: [1ed575b1991f68569eb589b7747d3bc26aa6a8a2]
stable/6.1: [da4b07da6281e39ce4c01e1227e036f3bf600e14]
stable/6.12: [20c2c65f3d9f7c278dc9750531d3201ac8bf78b7]
stable/6.18: [0782807552b6aff41b4656c6c9076a3231d3e79d]
stable/6.6: [20aacd87550be297dc39a3f9532dcfff91586510]
stable/7.2: [16cb1ee17e093175b4d9ae33202f68e5b108cca2]

CVE-2026-89892: media: em28xx: defer audio-only extension registration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89892

Introduced by commit 4a08966 ("media: em28xx-cards: rework the em28xx
probing code") in v4.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [95f76f51937fdfb0fc1e14cae606b1ef574a56f3]
stable/5.10: [0da1e627f4fc9d0e947fdae90913042120878923]
stable/5.15: [f8d7e77d9c621b42a191c67a9b37bec23dc1d555]
stable/6.1: [1abe9524dec0fd26e9ceb8d586034d6f68dd8273]
stable/6.12: [d06067ee32620f272cfb80c7bc7c572ad4e74724]
stable/6.18: [f9322ac9f862961d7f377b87ec26c8565af7e073]
stable/6.6: [4e11c45dfdc72ab656067b1df8fcebaf52fd4715]
stable/7.2: [4666197ca4f7d80cd3b0292054fe45d76be9ba04]

CVE-2026-89893: media: cx23885: cancel NetUP CI work before teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89893

Introduced by commit c184dcd ("V4L/DVB (10798): Add CIMax(R) SP2
Common Interface code for NetUP Dual DVB-S2 CI card") in v2.6.30-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e143d662ca94888b494b2427fc9e34494eb933a]
stable/5.10: [aaf76794b870b0f391eff339252a2e2e22f33a4a]
stable/5.15: [f7ff5adb63c1b277565afa54ccc0924d841b4a52]
stable/6.1: [140ecbcbf978fbe60f83f8d4f8b1199029a5c763]
stable/6.12: [5deec890ecfa04d21cfa9bb9a2fe5e9dc98db5c5]
stable/6.18: [bf3f49273d5bf6acbdad18ff44c01ffcf7a7a146]
stable/6.6: [ec82b0cf7f75fd95802592dcc9560fc7f529bba4]
stable/7.2: [99cd62b9b1c818d6d01a87be9a8e5796314150a2]

CVE-2026-89894: media: cx231xx: reject geometry changes while the VBI
queue is busy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89894

Introduced by commit 7c61713 ("media: cx231xx: convert to the vb2
framework") in v5.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [627a121c15fe05a541f44d86016294b80bada75d]
stable/5.10: [aa3314506deb9703bcf0e889db08959440228fbf]
stable/5.15: [90d50648af36a1fbf5dbc99238de6fd0e58a13e0]
stable/6.1: [a5dd3d7fba358ff9486f3f51b2a9038348c0970a]
stable/6.12: [1d1079db8d1807e259a1d2679ed314949797aad9]
stable/6.18: [7087bef6510c7df5df0b19192633b8ecc0f33a6f]
stable/6.6: [54ac6df8b8d97eddc3ae97fd2045bdedc8541b6d]
stable/7.2: [a636c72c7f522d984fa498fc0631f33a2d0be3fd]

CVE-2026-89895: media: cobalt: Avoid freeing ALSA private data twice

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89895

Introduced by commit 85756a0 ("[media] cobalt: add new driver") in v4.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a7d6b9c4cb5ac18cbd3f1c7f8c7b159c42ba0b1]
stable/5.10: [75bbf45e3a954e292ae26832d2df40ca2e3ee452]
stable/5.15: [fe65028ee72a7e07e572b351891bd7a1f8917d33]
stable/6.1: [61dfa8ded5efc3a25d331fa9ce5cebb85531fe70]
stable/6.12: [6cbc8a73b3464ebeccc49987b7233b6b087b8504]
stable/6.18: [cb1218da234ea15fa14d90e2d049d686874d7aa3]
stable/6.6: [42e00371f83c3fc7b99a36bf0229c74ad5d3c7d8]
stable/7.2: [8c6610e230b9355cf7df5a338a0592c0f088c00b]

CVE-2026-89896: media: cedrus: fix memory leak in cedrus_init_ctrls()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89896

Introduced by commit 50e7615 ("media: platform: Add Cedrus VPU decoder
driver") in v4.20-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9df2fbe563194da1967a5db083442186c1323efe]
stable/5.10: [6fabacc3b79a528450aef4c32464da2ec681049e]
stable/5.15: [729a1ffab968b3c493f61d1cd683f5bafec500ea]
stable/6.1: [ce5693b6e3a693fcdc3800af309363f6250104c8]
stable/6.12: [79fd0b0161506fc9507bf7a6fe4c975a857a5be8]
stable/6.18: [f78cf36cabf911da348ea80e4e9f430d74f6905c]
stable/6.6: [22441be29ec27c693f40c1ef499093275ef529d1]
stable/7.2: [81aa608ac3a56cdd4aab0bd12442ed529a24ba31]

CVE-2026-89897: media: cec: Serialize exclusive follower delivery

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89897

Introduced by commit 9881fe0 ("[media] cec: add HDMI CEC framework
(adapter)") in v4.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1924d0788caa6c66fd320dd4704fae99487fd2c7]
stable/5.10: [efc829b4b937f98c4467bffe9243f756b7cfbf7f]
stable/5.15: [cac577854826950dda4d53569728b1da6c1425d5]
stable/6.1: [4b532b271c91790b7ab661cd488a7ad36f5c4f6b]
stable/6.12: [df941e6851da17fc53c7f6af2bdcc7383d17babc]
stable/6.18: [5c62095acc2a952099688774513c4a637bcdb2b5]
stable/6.6: [271e57a936dcdbaecb4b1bd005d9a285bbe60ab4]
stable/7.2: [ae614f48712156fb0f55b207338d48d422c58bc0]

CVE-2026-89898: media: cec: extron-da-hd-4k-plus: add sanity check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89898

Introduced by commit 056f282 ("media: cec: extron-da-hd-4k-plus: add
the Extron DA HD 4K Plus CEC driver") in v6.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [abac9820b26b5cfcb01eb79efe2abdd0ac7e07c3]
stable/6.12: [00c13b4ab481a09d915d099815cff1b10926ddd9]
stable/6.18: [673611cc2ab9769929644ce879f7ea34932a3011]
stable/7.2: [7ad2fec276946a0dedfa54eb26fc38c4fc6a6034]

CVE-2026-89899: media: cec: disable delayed work before freeing an
interrupted transmit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89899

Introduced by commit 490d84f ("media: cec: forgot to cancel delayed
work") in v4.20-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [0fbd5c2327020858c45b2d1c65775d64cdeca523]
stable/6.12: [9a951931d4b4084acd64fa55fc3672a9da45ddf9]
stable/6.18: [a3adb63b121937b97f7fdc51e96564c7c799538b]
stable/7.2: [9c6ceb0949227c1f0cf0e19393daec72d9889871]

CVE-2026-89900: media: cec: core: Fix kmemleak due to missed
rc_free_device() call

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89900

Introduced by commit dccc0c3 ("media: rc: fix race between unregister
and urb/irq callbacks") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [a24ba0653f7154e671dc8d2bf64682ab2d042792]
stable/6.12: [f28a8e1ba4d67a18e4662e5acefd5a4389322366]
stable/6.18: [695063fc57574dd117b1bc750ca189cf03a2caad]
stable/6.6: [954ee95a03b4d31d4505591bfaba02c24b75776b]
stable/7.2: [cca2407794795cecff7f8e5f5a79f4ef6b1d6f6c]

CVE-2026-89901: media: airspy: use vb2_video_unregister_device() on
disconnect to fix NULL deref

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89901

Introduced by commit 634fe50 ("[media] airspy: AirSpy SDR driver") in v3.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f378dc45e685fc825d2dd08e7864666d6fcc009]
stable/5.10: [c9081e2655188d2d134a741aec837dc70439d505]
stable/5.15: [75089cea32e5055773bd13116236d08fdc98678a]
stable/6.1: [155d0378ae0d6305cc4840583a6b42d2d0595bff]
stable/6.12: [a9a8c37ddda9fa3687b142be9098e1c37b8faf35]
stable/6.18: [297fee023f46d771a844520675692ea089d80d9d]
stable/6.6: [6e4ea90fdc6608cd5fac342e146ab6ae15d430bc]
stable/7.2: [c6749ac8f59cc80eb1b2d52f167fdf13e12655cc]

CVE-2026-89902: LoongArch: Avoid preempt count underflow without probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89902

Introduced by commit 6d4cc40 ("LoongArch: Add kprobes support") in v6.3-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [72ce4b24676e8b3b75376c4c559dd81c1ac52d5a]
stable/6.12: [a1cb727fa27c2d9c7859729cd90db7bc0f46957f]
stable/6.18: [76395109a051b53860faaec96522ef08ae9e8e27]
stable/6.6: [ff40e597d5d98c0c45a4d09df8177202fac9520e]
stable/7.2: [c4357ebeee63cb8da1446fc936573a34e68b0f71]

CVE-2026-89903: LoongArch: Do not save/restore percpu base register in
rethook trampoline

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89903

Introduced by commit 3f55368 ("LoongArch: Add kretprobes support") in v6.3-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c3f2feace5e4f4b01b68b9f947b19adb4155c32e]
stable/6.12: [8f15e95b438bc6b3c9f23a33c9a0d0678ebd1dc8]
stable/6.18: [266ffc92e68593759adfe3d58f188773d32782c3]
stable/6.6: [a03b5e7483ad2c33ba5dd2adb8552e84bfee8fe2]
stable/7.2: [c048b0a3c0836c4b1bef4b51d355d27090bf6790]

CVE-2026-89904: LoongArch: Fix acpi_package_ids[] array overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89904

Introduced by commit 4e8f586 ("LoongArch: Retrieve CPU package ID from
PPTT when available") in v7.2-rc5.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18

Fixed status
mainline: [2a2367d46d7a4ee4122b7a86e57125542dbbe963]
stable/6.12: [0195e04b1eec8fb00e2db9c5e55655a3f5e76f60]
stable/6.18: [d3fd094c13c6d0b74f246461ca4cf427d539c8e8]
stable/7.2: [6311b8c471afa33c18adbe4eb16f862936b71ca3]

CVE-2026-89905: LoongArch: BPF: Move arena register slot below TCC context

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89905

Introduced by commit ef54c51 ("LoongArch: BPF: Implement PROBE_MEM32
pseudo instructions") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cd7e356b07a27e91394838cf3fb655862b519294]
stable/7.2: [f0e4d069cb47cf4f8dc4f6bc104e0671155aa3b9]

CVE-2026-89906: LoongArch: BPF: Refactor jump offset calculation in tail call

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89906

Introduced by commit cd39d9e ("LoongArch: BPF: Fix jump offset
calculation in tailcall") in v6.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [37d545d12f21c4d50612ecaebd7ae1e5bf91b2d8]
stable/6.18: [882b8912b7e92341fdb115ba0e2e5142a28684ff]
stable/7.2: [96f44d493c280ea161569c43d7ed0f3b0815803a]

CVE-2026-89907: LoongArch: KVM: Validate MSI data before routing it to EIOINTC

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89907

Introduced by commit 1928254 ("LoongArch: KVM: Add irqfd support") in v6.13-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [501514d6ebd2111c353a1296f25dbe22fbd64657]
stable/7.2: [83715a40a2d30d23719e0b25380ba82ff905195b]

CVE-2026-89908: LoongArch: KVM: Preserve memslot arch flags on KVM_MR_FLAGS_ONLY

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89908

Introduced by commit 7ab6fb5 ("LoongArch: KVM: Optimization for
memslot hugepage checking") in v6.8-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [27a9bfee3bbcb3cabb77797354f07e0e44e49831]
stable/6.12: [7c6df65b53846cd7a9a1c81c6ddb42fdc08603e8]
stable/6.18: [4e4dbc341b1581dc512b85d98b768373b0398366]
stable/7.2: [bc7a6849b4395f45a602db91b0fb2fb2e9ed4bba]

CVE-2026-89909: LoongArch: KVM: Free init resources if kvm_init() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89909

Introduced by commit 2bd6ac6 ("LoongArch: KVM: Implement kvm module
related interface") in v6.7-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7a1064cce3b100b54780c68529176232d8eb01e]
stable/6.12: [6bbbd7b719233645a5c120557a9ca1422e6b7a48]
stable/6.18: [6b78786ee7260d9818cf1d7a245b7a655ef83076]
stable/7.2: [3bf6f5e2e1007d38a5f35bd37e94ab645a0c40bc]

CVE-2026-89910: LoongArch: KVM: Fix uninitialized stack variable issue
with dmsintc

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89910

Introduced by commit 03de5ee ("LoongArch: KVM: Add DMSINTC inject msi
to vCPU") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [81aa3a58b542ed88819115c80a17acd86eacb89d]
stable/7.2: [f56060b0e10fa5633fac1dc243a25da3a5cdafb1]

CVE-2026-89911: KVM: arm64: Correctly cap TLBI Range to the architural limit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89911

Introduced by commit 4ffa72a ("KVM: arm64: nv: Add S1 TLB invalidation
primitive for VNCR_EL2") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [69a598288195947a1662b53de702eb6976af96b7]
stable/6.18: [566b1f08d983615f731cc693f2ad59db302c6b57]
stable/7.2: [2de38f0448b45d27eba984fc0d9edb7a138972c2]

CVE-2026-89912: KVM: arm64: vgic-its: Don't dereference a NULL
collection on ITT save

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89912

Introduced by commit eff484e ("KVM: arm64: vgic-its: ITT save and
restore") in v4.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c6c156d931c33b92362383cf76f6d6e1291dcbfe]
stable/6.18: [3d4c26b16a04a084fe0bde08ccdd8086570f8bbe]
stable/7.2: [36df368861d2664291298feeb37dfef43fcae670]

CVE-2026-89913: KVM: arm64: vgic-v3: take an LPI reference in
vgic_v3_save_pending_tables

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89913

According to the .vulnerable file, this bug was introduced by commit
2807712 in v4.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5b8f203bfc07a5a257dff859e66d2c500f9f509]
stable/6.18: [7631f95297560157d3a9283cb999e3be00103348]
stable/7.2: [d3a2d20b7248ea67465af1cf79c79f90ff70926c]

CVE-2026-89914: KVM: arm64: Sign-extend VA for range-based TLBI invalidation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89914

Introduced by commit 85bba00 ("KVM: arm64: nv: Move TLBI range
decoding to a helper") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2393470085649f0b973ecceb26fe8fc71edde0c1]
stable/6.18: [72bce82c4171bf330919ff1b64dc0a36c254ec7d]
stable/7.2: [3feb83918e30f0472e058224b926ebfe8a064fac]

CVE-2026-89915: KVM: arm64: Remove VM-wide VNCR mapping counter

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89915

Introduced by commit 4ffa72a ("KVM: arm64: nv: Add S1 TLB invalidation
primitive for VNCR_EL2") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c55bc773b6e814406658fae7dc5c15f639ed816e]
stable/6.18: [5453b85c7ebb605febac3df42021f9471663f051]
stable/7.2: [87c2bbf189829dce4aaada8f82e3d54ccc037976]

CVE-2026-89916: KVM: arm64: Make VNCR invalidation participate in MMU
invalidation retry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89916

Introduced by commit 4ffa72a ("KVM: arm64: nv: Add S1 TLB invalidation
primitive for VNCR_EL2") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b7324f3a0c1072b9d578b8d42f199506753f26e]
stable/6.18: [d8580e7aa189b0c6c5bb4d94b8352728a7c35bbd]
stable/7.2: [11ee3faab4f1755d126bead9f882e75a7a677860]

CVE-2026-89917: KVM: arm64: Handle VNCR TLB invalidation race with
vcpu_put() VNCR unmapping

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89917

Introduced by commit 7270cc9 ("KVM: arm64: nv: Handle VNCR_EL2
invalidation from MMU notifiers") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [38640bc32be3fcf9526d477155bc19d3f146231f]
stable/6.18: [5cbd8761d001c11ada73b1753d772c4745a70e72]
stable/7.2: [9065c1261f8a05c6a7a2d90048c7c0665ab2896d]

CVE-2026-89918: KVM: arm64: Correctly handle end of VA space TLBI invalidation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89918

Introduced by commit 4ffa72a ("KVM: arm64: nv: Add S1 TLB invalidation
primitive for VNCR_EL2") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [34af2c3e31f91a739dc175459fdbd99ed952b457]
stable/6.18: [ce447651a52ec077694172af10c4fffb11f56c43]
stable/7.2: [c624731ca6fe59ad8909ce4108301aa7560a91d6]

CVE-2026-89919: KVM: s390: keyop: use mmu_lock to read gmap->asce

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89919

Introduced by commit 0ee4ddc ("KVM: s390: Storage key manipulation
IOCTL") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da07a751efa4583385f9f0f47113549fe8871242]
stable/7.2: [ae452b990e0544425f77045351c56e77158858e7]

CVE-2026-89920: KVM: s390: Fix memory corruption by not reinjecting CK
machine checks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89920

Introduced by commit 4d62fcc ("KVM: s390: Inject machine check into
the guest") in v4.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [546dde823a36d7283dcf46127c2f3d093443860f]
stable/6.18: [6ee52d3af2a1bf70349cf3f860933c8d221e229a]
stable/7.2: [7077ec953996acc04b49d1dfc43df1c1a2a74395]

CVE-2026-89921: KVM: s390: Zero initialize data structures for
inject_pfault_token

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89921

Introduced by commit 383d0b0 ("KVM: s390: handle pending local
interrupts via bitmap") in v3.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e2c7f7cbc27418f9a290399b986c1b85ff93b90]
stable/6.18: [9b046de62b8098af6e2ba820b125ec9dc5f162c8]
stable/7.2: [134f235e0e8de54611a72d3cc3f63e5f31246baa]

CVE-2026-89922: KVM: s390: Take srcu when importing watchpoint data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89922

Introduced by commit 27291e2 ("KVM: s390: hardware support for guest
debugging") in v3.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a4e482def8533ebace517d9f67f1465841b1f982]
stable/6.1: [6830fbc3724bf49c142aae69a4694f115fa9cedd]
stable/6.12: [76f5b4ea9ed0aa5a34bda9d8a878f2c73026ec03]
stable/6.18: [cc710ee45395efb4937e042960f791d33924e5f6]
stable/6.6: [f8e3a9997d5ecd56ebe4b262ff424516c068fecb]
stable/7.2: [4c05bf21d1806853e662cc19e744736a3408f155]

CVE-2026-89923: KVM: s390: Free guest debug data on vcpu destroy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89923

Introduced by commit 27291e2 ("KVM: s390: hardware support for guest
debugging") in v3.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e7f698b09d4a7c36b299acf680fc50fe868e2bcd]
stable/5.10: [053f2068cf9b0654b651fed5ad7649d3deb982bf]
stable/5.15: [6c996b12bbe4a6023076e8eee3cfaf2cc99db76c]
stable/6.1: [d6280fc540d8f4653c9b54a78cb747e128070f5e]
stable/6.12: [9a32c4c6a6c23b7f5bf765eb5b83ba7f64a8ec63]
stable/6.18: [b5acacfdb8966abff91836c1c5bd7da59d8a526e]
stable/6.6: [544a5a665019cef394ce8bda97fa7a2cab253781]
stable/7.2: [e4d8b7f176b976474e0800ba71ee2dfa3ce263c9]

CVE-2026-89924: KVM: s390: Fix old_data leak in guest debug error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89924

Introduced by commit 27291e2 ("KVM: s390: hardware support for guest
debugging") in v3.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa9c8e8baf1e765fa65b93212522c636f25d846f]
stable/5.10: [124c81ee610e1fbdd93d4399f88d9e28ba97a941]
stable/5.15: [e5ae7816e5ad145618f7fd568a0e8a94dd9f81f4]
stable/6.1: [c85d402553987777cc4742751437ea5dcbf98a7b]
stable/6.12: [4048d0a252163084794be3e37995b872c5178913]
stable/6.18: [f55e4d415d95342d5753e528e05a1e8623992c3f]
stable/6.6: [5fbf319137735252eefa507193c9a619af5b7457]
stable/7.2: [46cb8a273e2f853f89a78b59dbdff8787b6e1c86]

CVE-2026-89925: KVM: s390: Fix memory leak in guest debug handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89925

Introduced by commit 27291e2 ("KVM: s390: hardware support for guest
debugging") in v3.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [121ea1de927c8b9bfdf53c31cad27b86d5de0293]
stable/5.10: [39e7cebb889839b5762c9ad22e2d715b5883b288]
stable/5.15: [58b1b729a9f90c80b508fc3e2174cbc0ee50859e]
stable/6.1: [9071f75cbde3bf46119cb28e92cfbef830c4bf97]
stable/6.12: [fc2034c431adcbaabf5f8a01912358f07355349e]
stable/6.18: [44bf3792c10f4bb3de507391f1837e020d92eaa2]
stable/6.6: [5940418e4232a2ff1d30ba12e0d213dbf48f0a83]
stable/7.2: [581be9f6085834188cef1ad2f07babf3b421e409]

CVE-2026-89926: KVM: s390: Fix length check __import_wp_info()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89926

Introduced by commit 27291e2 ("KVM: s390: hardware support for guest
debugging") in v3.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c07680a467e2f7697245bcd11691bffb2a6f0ed]
stable/5.15: [aef540194effd768bed0bd2e6a74fe135a3d7c3a]
stable/6.1: [71153d3262517e1c02c3a66aa5094f279b2d1454]
stable/6.12: [b94ab9caa5d72c78226121cccff5e33f946da900]
stable/6.18: [beb9c55af609c4c7308259d7191688c75a4e3d4a]
stable/6.6: [fec89d327d9b2b669b5bbdac209386c6317c3722]
stable/7.2: [3fe801db90bdeefb0bbdda42d832846b53f64f8a]

CVE-2026-89927: KVM: x86: hyper-v: Clamp stimer deadline to avoid livelock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89927

Introduced by commit 1f4b34f ("kvm/x86: Hyper-V SynIC timers") in v4.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ca49fbd2883cd53d32d85b50feef17fa04d0fbf]
stable/5.10: [a4665762388750e08df99baabe5fce2a21d1423e]
stable/5.15: [61954727ee08f026f5e1c9ee69e1b404a68f2f7a]
stable/6.1: [8aa467fe757d8cb2278e98d7fbf44fc05eb0dbf8]
stable/6.12: [6a8ba9213cce613455b1502ee0fd178656bf617b]
stable/6.18: [3097582b73a8ed1cd6f6790fa78706f4a79b5a49]
stable/6.6: [8e19ded84336891646b31375720717635f0fdd90]
stable/7.2: [bdb732ebee545b7e3bee7060efc754a8d99818b9]

CVE-2026-89928: KVM: x86/mmu: Consume the locked rmap value in the
lockless rmap walk

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89928

Introduced by commit af3b6a9 ("KVM: x86/mmu: Walk rmaps (shadow MMU)
without holding mmu_lock when aging gfns") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e428f9779a43737d830111238816f1928b07aefb]
stable/6.18: [41debfc98526c0a95c41a62435aca0a70340a26d]
stable/7.2: [8edb3c09e43f7cd8a5dfd291c6e0fc9c74d4621d]

CVE-2026-89929: KVM: nVM: Ensure INVVPID is emulated on the correct physical CPU

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89929

According to the .vulnerable file, this bug was introduced by commit
5c614b3 in v4.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d00e67326d831e6e610933a3800712f4ffe6ec1]
stable/6.12: [d03e721801ac54b9fdf05668aa0c069f07913b68]
stable/6.18: [27bdeb5fd19046ffba9ff234e92fe553eb2efb30]
stable/7.2: [9941850e8adf164d005dbd3774c4b79e91a3cb8e]

CVE-2026-89930: KVM: nVMX: Service local TLB flushes on failed nested VM-Enter

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89930

Introduced by commit 5c614b3 ("KVM: nVMX: nested VPID emulation") in v4.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [05a0b701d1089fb57beeb8982f23c3bbafe0fa8b]
stable/5.15: [c0c66cd575e31218da6a7d104c6ef80b0830b60c]
stable/6.1: [1025b938dc439b75c720a568a855a13eeb245686]
stable/6.12: [f74fccdf4f7fb0780cd84944108d35f3d9dc46a7]
stable/6.18: [c43563e7518e65ec6ccaa6a65f84c5af5ca5d379]
stable/6.6: [312cdb6d8940827dea63a7a52fb714a5049f06d1]
stable/7.2: [62c3ee4c9f0e2efef5157358b3549e50ede96d73]

CVE-2026-89931: KVM: nVMX: Ensure KVM_REQ_GET_NESTED_STATE_PAGES is
cleared on VM-Exit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89931

Introduced by commit b4f69df ("KVM: x86: Make Hyper-V emulation
optional") in v6.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [11722439fb206c88e6f31be54173efa9880b4ccb]
stable/6.12: [ae190f2439ca30067927077bf570d4c5edf07a0f]
stable/6.18: [674a3244f07f323f21a106a7bdcaebb6db6a5058]
stable/7.2: [bbec4adc2f340d85f4a77a9ddcddaa6b1f4639c5]

CVE-2026-89932: KVM: nVMX: Always flush vpid02 on first use

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89932

According to the .vulnerable file, this bug was introduced by commit
5c614b3 in v4.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0772389413dce9657c7d6950abf3edbbd511356]
stable/5.15: [26de0d2d9a8d14c03e5ebb25fd68b5bfcd5ac366]
stable/6.1: [8bc609999ec223089fec8d74c7de27d689606b36]
stable/6.12: [8b98d662ab24f34710a56e03bc9169e4a5508606]
stable/6.18: [22dfcc22c95e91295119a1c3b469816ce44c4804]
stable/6.6: [62604376c313178811375f40a282fc2a46cd2311]
stable/7.2: [121991d150735f3c0f7401678ce4d35c5b4ac898]

CVE-2026-89933: iio: pressure: dps310: fix NULL pointer dereference on
ACPI probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89933

Introduced by commit 72ff282 ("iio: pressure: dps310: Add ACPI HID
table") in v5.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26e9213898fc949923188ef0aeea31fc87708836]
stable/6.12: [bc7b09e701b4175fc683b579fcdef3bfac809239]
stable/6.18: [7ded5b76ec2df6a3fb1bfde0d1869cde363fef30]
stable/6.6: [a32a39da18e01b20c2ab65af9be34dc870187382]
stable/7.2: [3fa189573cca284ae663bfd2d5b9ed755bec5e9d]

CVE-2026-89934: iio: light: ltrf216a: fix runtime PM reference leak in
error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89934

Introduced by commit 83f0bcd ("iio: light: Add support for ltrf216a
sensor") in v6.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c132aef0e757a39036b1d40faf0569f2e343b13e]
stable/6.12: [c4f003d8578f5718fe1ec332bc89f9ff69fd205b]
stable/6.18: [0614928a3eda35bddd8c2f02311e286b59bbe746]
stable/7.2: [80e7381e8cccb543397572af153865f34aaf4353]

CVE-2026-89935: iio: light: apds9306: fix PM reference leak in
apds9306_read_data()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89935

Introduced by commit 620d1e6 ("iio: light: Add support for APDS9306
Light Sensor") in v6.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d378fceaafd79e0dc59d3546bda251a3058062c0]
stable/6.18: [f3d97800b03cd39ec135e544dcd0a93ffd18e4c7]
stable/7.2: [3ce75e455dd6eaa775fb0badb31c0b100c7a01fe]

CVE-2026-89936: iio: dac: m62332: Fix regulator reference count imbalance

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89936

Introduced by commit b87b0c0 ("iio: add m62332 DAC driver") in v4.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a130404ce0b69ca1438126bd81c1985d3b4d2e6f]
stable/5.10: [bac0ed8bee651aa841375edf72c6ab1d10ac80c6]
stable/5.15: [9263b9ad968a563337a60e0eb66e35186e1faf9a]
stable/6.1: [1d3a7d7dd3adee19e00be2b2237140f0fe169484]
stable/6.12: [ae18d2d2ef27a4d04fda6e30c23774513dc9be1e]
stable/6.18: [08ac8d2976d57aa943d64e351c4d0bd8bb0c6de9]
stable/6.6: [f5acb824277a97a5210c454872202bf7f08c75d4]
stable/7.2: [9fe22f563b2a0fdb11fd3711a8c39c023629c08a]

CVE-2026-89937: iio: chemical: sgp30: Handle IAQ thread creation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89937

Introduced by commit ce51412 ("iio: chemical: sgp30: Support Sensirion
SGP30/SGPC3 sensors") in v5.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1135d6875d2dbda3f6ec718f3421a6ce4378bd63]
stable/5.10: [bffd0655a35402b2df8857699f8248e5a534d214]
stable/5.15: [bae0316c087b1ef625844003fe37e803a13819f3]
stable/6.1: [3c6b52b258e65a584e3f5122ed7f406bc89a946e]
stable/6.12: [a5aaea17a1834d7254ff597e4d5e1bc60dfc4800]
stable/6.18: [2d386efb4c37a50739db19c7c8e49564fd53a570]
stable/6.6: [3462c13bb0f50dec09235adb7fd04b6f617cf0cc]
stable/7.2: [44d52c8b1c6da7ac1b0dffeeff6de68370746775]

CVE-2026-89938: iio: chemical: atlas-sensor: use
iio_trigger_poll_nested() to fix remove UAF

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89938

Introduced by commit 7103b99 ("iio: chemical: atlas-ph-sensor: reorg
driver to allow multiple chips") in v4.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be61c8c6252671ecf1fee0ad90f87669e0be1e20]
stable/6.12: [91e12b0fbd7047d02bf4ef4dbc491b9ef0159250]
stable/6.18: [2071624c3d0f497ca91da78858e6f30d7112fea6]
stable/6.6: [f64b437641b5a70c18bb0fd38da2b69d8926c871]
stable/7.2: [30b0d44c978bbc857bd68b71dab371805653de70]

CVE-2026-89939: iio: chemical: atlas-sensor: fix PM reference leak in
buffer postenable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89939

Introduced by commit 0e4f336 ("iio: chemical: atlas-sensor: Balance
runtime pm + pm_runtime_resume_and_get()") in v5.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bcd3f72e26314edfce7eaf8d7160b3119c7b7fed]
stable/5.15: [c7e91ae6d7802170f53ece09a4ecc6302265d3e4]
stable/6.1: [a595f4d3e4ee1c91c62a298730a77b16dc26b426]
stable/6.12: [aedf8f068d9da774d5cb62e9c9d6e62b2ce64d86]
stable/6.18: [43bce901047e95bbf8fb63eb471460642e497604]
stable/6.6: [72daa7eb7fc6202fece0bb56487d72af5c49ccdf]
stable/7.2: [777e8ebfe6b3fa733694977f0f4cf849e07e925c]

CVE-2026-89940: iio: buffer: Tie IIO dma fence lock lifetime to the fence

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89940

Introduced by commit 3e26d9f ("iio: core: Add new DMABUF interface
infrastructure") in v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f25ec4627d935dedfb5fe83bd2c2678cdcc19611]
stable/6.12: [6865d79fca17a80fbd60c12550ca9a5e0e20e0eb]
stable/6.18: [510497e31be4f241103507315a859e2085ccb081]
stable/7.2: [8b3e221590181a8beb3735bbabf166df02c839b5]

CVE-2026-89941: iio: buffer: Make IIO DMA fence release RCU-safe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89941

Introduced by commit 3e26d9f ("iio: core: Add new DMABUF interface
infrastructure") in v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8662e56c31cf23b61ca3d11b516efb94c35b8026]
stable/6.12: [311595dc0b5621f74d8eb4dc38ef4efcdfe7e769]
stable/6.18: [06a9460b8b792e109cbc934a856d02e5cff217ef]
stable/7.2: [11cef99491117d4264603df159c4ff5f3845a059]

CVE-2026-89942: iio: buffer: Fix potential use-after-free in anonymous
buffer release

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89942

Introduced by commit 3e26d9f ("iio: core: Add new DMABUF interface
infrastructure") in v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6288b593e76eb10329326f2cd51e32557203b9e5]
stable/6.12: [ab53077511cde811bf3ee219426c522329c41226]
stable/6.18: [f1f8f0e8e0af9cae8150658dc7bb51332f984893]
stable/7.2: [6d4bdbf7bad63e759bf20259c527f69a1209e3dd]

CVE-2026-89943: ASoC: loongson: Fix error handling in ACPI property parsing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89943

Introduced by commit ddb538a ("ASoC: loongson: Factor out
loongson_card_acpi_find_device() function") in v6.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0eb0e3c623ac1da8b85d518043fef7660af7805d]
stable/6.12: [682c123cef455545f48ecbe74b3872fa303bf58f]
stable/6.18: [4e580d84a638f007b5b68d50d7633de502f325e7]
stable/7.2: [bb1602908c67db7197ab001638573262bccc6ca2]

CVE-2026-89944: ASoC: hdac_hda: Fix hlink refcount leak on component
registration failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89944

Introduced by commit 6bae5ea ("ASoC: hdac_hda: add asoc extension for
legacy HDA codec drivers") in v4.20-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6ad4892c4f5cb437a928a02f5b7d37d496aa9268]
stable/6.12: [7eef9ae3b4ef782557526dd8ba0c206f028d8c2f]
stable/6.18: [e8ea01a0457080b0cc7c69c430c0ab65d84dc377]
stable/7.2: [cb6b0b1a9d5a61ef841739d42c6211094e9c8e2c]

CVE-2026-89945: ASoC: cs35l34: drain threaded IRQ before runtime suspend

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89945

Introduced by commit c1124c0 ("ASoC: cs35l34: Initial commit of the
cs35l34 CODEC driver.") in v4.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4105a4c0678b2808fc8046b60321b4f1cc7dae75]
stable/5.10: [3be8380fb14d602cd833e5852e6d83c1e7eb1ceb]
stable/5.15: [96982734e765c13c3db02067e1d5784682085f5c]
stable/6.1: [5b063739619990d5de0c94c85d6e5be14e7cbdfe]
stable/6.12: [4fe8a91a9266f1321c2d31ce67940a4e8b93559e]
stable/6.18: [5a4fe7a87841af23ba80bae31b80355b16926cf4]
stable/6.6: [f4bfd755c52dfa7584e6c9374206b71b8895c997]
stable/7.2: [07a86575edc308e66b6c8873ed4a93ef3a063e55]

CVE-2026-89946: ASoC: cs35l33: drain threaded IRQ before runtime suspend

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89946

Introduced by commit 3333cb7 ("ASoC: cs35l33: Initial commit of the
cs35l33 CODEC driver.") in v4.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e074c12c428c633e079154301207a6079a208583]
stable/5.10: [d07799302721d381aef834fac8a11d196894eccb]
stable/5.15: [5b5311427e54d9c0d07178ee42df68ba44c2d5ca]
stable/6.1: [a04722542c76ce861031384480825afded8cc4f4]
stable/6.12: [6ae98918240585eb2ad32b097c4810f4e2dabe88]
stable/6.18: [6e369bc46663b4bfce3d5f8b8ed08e71ecea13a2]
stable/6.6: [614c2616ea677abfbed917a92bdc5141efff3536]
stable/7.2: [84cf6acd01a1ec8f30276578a039216327af782e]

CVE-2026-89947: clk: meson: align gxbb_32k_clk_sel number of parents
with actual count

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89947

Introduced by commit 7915d7d ("clk: amlogic: gxbb: drop non existing
32k clock parent") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [628b6fee9fca292f12d07f0f1bcf1edefa949d81]
stable/5.10: [c86214e6178c38a0eff39110a4e92b824f5dd403]
stable/5.15: [8b2f7a411e7ceaef268355c2150c22ee3f509c3b]
stable/6.1: [1e509a6707d2fd9da79bdfa24742661b34562bfd]
stable/6.12: [f6ff0e6995dbff5cb145d7795c8f0af9c168094a]
stable/6.18: [4582949b7badcb91bb537ca522d69b8a35131e72]
stable/6.6: [404079d124d75a5da16322acc53d3ffc50b4ec68]
stable/7.2: [bf85bd6e550c17ffa585606fcc18eb5b7c95bbce]

CVE-2026-89948: batman-adv: bla: fix freeing of claims on meshif deletion

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89948

Introduced by commit 2372138 ("batman-adv: add basic bridge loop
avoidance code") in v3.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8d128c932bced74e3b1625ba3d7c78ef122a88a7]
stable/5.10: [844a95a734f178d56c7acce14c5cce2cecff7e1a]
stable/5.15: [baeb1a28fd8e2f68193650d3664a8cd1adfd85c6]
stable/6.1: [aacffa780a37e06cd5a13d33740a6e96c3a67e6c]
stable/6.12: [f50edb69082a8ba990cc23d642089829f99afe6a]
stable/6.18: [871acdf97f64cee8398f72b88b89e8b4f4816dbe]
stable/6.6: [76aedcde5a2489cc971d4d1e396e784a49565e96]
stable/7.2: [9a0c47023d3254048a1588534755d4476bcc3abc]

CVE-2026-89949: batman-adv: dat: avoid unaligned fault in IP extraction

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89949

Introduced by commit 5c3a0e5 ("batman-adv: Distributed ARP Table - add
ARP parsing functions") in v3.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0121afa52cdb88cfb4d5d7bd126a23a9100121d8]
stable/5.10: [b1bbc694ca51adb8dbed3f3235b4fcbdb44e0e20]
stable/5.15: [15dbfb37f0e1a085d48deeb8f5238e9d28127dde]
stable/6.1: [a170d4617e8cca05a1314de61728a262ef272782]
stable/6.12: [91c99b4e152023c7d458a5dedd52d2b0d7df4ce3]
stable/6.18: [1cfa7d5f70d54cb8c7e82df739430782d1996ee1]
stable/6.6: [c74a4acf41d19f21199dec2d6c813c90d31cd02c]
stable/7.2: [0c2df865338bbf92aa45b9253e5f9b8ef2d9992f]

CVE-2026-89950: batman-adv: mcast: linearize skbuff for packet generation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89950

Introduced by commit 9003913 ("batman-adv: mcast: implement multicast
packet generation") in v6.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6a30a59e2660afd03c975f1b8eae6a2301161197]
stable/6.12: [a9603e0a7cb5e0cddc6b23af153cf7daafc5c55e]
stable/6.18: [c32e5e25c41201c8c3b796a4ab2c45103187091e]
stable/7.2: [2879177539e3ece483a8e5406970373698e9a6c5]

CVE-2026-89951: batman-adv: fix stale receive device on merged fragments

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89951

Introduced by commit 610bfc6 ("batman-adv: Receive fragmented packets
and merge") in v3.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ad46c907d7d9975a285c1e89a4adde652eaa93f5]
stable/5.10: [63d86250fa7cbe22451369bd1c0881dfc8190958]
stable/5.15: [f830c2dfc1431764db9256b3d5db1695fc9a7f56]
stable/6.1: [f4b4ae763b5d59319fad62a00c76676758e7dafa]
stable/6.12: [a2c272da99c2077088083c14961cf2f1e4506995]
stable/6.18: [e91d2cc7441d89a45bad73ad9789159c7441cb80]
stable/6.6: [6df64825f8b199921120c685af2abca14b077331]
stable/7.2: [2dffc8c44b6e3347b3719c6419c07b4a18fea895]

CVE-2026-89952: mtd: rawnand: validate ONFI extended parameter page sections

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89952

Introduced by commit 6dcbe0c ("mtd: get the ECC info from the Extended
Parameter Page") in v3.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e5e415262330bd70f983e091d8919d9dcd99e475]
stable/5.10: [1bf148fabe6463422195b7cc43b3412533f1dc21]
stable/5.15: [c7df90bbda71549bfd981bf478ad04ddfccf4e0d]
stable/6.1: [86948f81964e40cd6472d76a6371e4f297d84db0]
stable/6.12: [12a63a0f0d17b2d26211b2524ded91a67dd5c99c]
stable/6.18: [c8f86e375b39cada09fd8cb33dd3bb3641e84a62]
stable/6.6: [ddb6ddf5be7429bb98b3368c883be51f00b31678]
stable/7.2: [23e747fe585830c43095c37c85b2757231c6917f]

CVE-2026-89953: mtd: mtdoops: free page bitmap when the backing MTD is removed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89953

Introduced by commit be95745 ("mtd: mtdoops: keep track of used/unused
pages in an array") in v2.6.33-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [956e7da12c114f13c63d126ab1d79c3b6a819060]
stable/5.10: [477d61d54e097e90f748aa18d013805abd56bcbd]
stable/5.15: [a91ac71e67c3e01ed9afd9841435bebb930293f8]
stable/6.1: [698944132083d143ef965c0090ee14ba1d9e1a5f]
stable/6.12: [8414f0e9f707226de20b48c7048179fd86d352fc]
stable/6.18: [d06f91a52af11630c9f7e487f6daf242ac310cb8]
stable/6.6: [f25c804947e0a28c15e73da8e2e0db959cbed716]
stable/7.2: [1e5cd8bc902331ff801df88cbb299029ae062753]

CVE-2026-89954: mtd: afs: validate v2 image info bounds

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89954

Introduced by commit b7cf5e2 ("mtd: afs: add v2 partition parsing") in v5.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e9290031f736e99ad17c25c00311c92c266843b7]
stable/5.10: [1bec05a68414cf8d0cab6cb42445b8603f32ffc4]
stable/5.15: [3ad8ff12fd44b08af9212ac4883a7e29d2ab7348]
stable/6.1: [875daa3c750814ff2e2dc050239c390048f0bcd0]
stable/6.12: [1edea8900ca3e405c1421d8b5c29f97107874f72]
stable/6.18: [18916f475057cbd2fb8ea6ae86e6b85884ad1d53]
stable/6.6: [da740539e8f370767317e24615349b9342a6e773]
stable/7.2: [d14e6298139f58a87a87d7022e26a7f37f0ddce7]

CVE-2026-89955: s390/vfio-ap: Fix NULL deref in status_show() during queue probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89955

Introduced by commit 260f3ea ("s390/vfio-ap: move probe and remove
callbacks to vfio_ap_ops.c") in v6.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd6f4ef6f8a37412909ad787c837332fb070159c]
stable/6.12: [e102ce0f4af99dff769a4b1b4daa4cc6bd5ad2d9]
stable/6.18: [69632952aca04caa71e49953b6949fc04e788e67]
stable/6.6: [31fa0a8a3c337ed2d200166d6926ab23c14f8b2e]
stable/7.2: [7db2511fc601ca3a6e3fb1bdce02261c3c3167c3]

CVE-2026-89956: s390/vfio-ap: Fix missing lock required to access list
of ap_matrix_mdev objects

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89956

Introduced by commit 2c1ee89 ("s390/vfio-ap: prepare for dynamic
update of guest's APCB on queue probe/remove") in v6.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7fa61c29850d05e40ca9ed41bfdf57673023f581]
stable/6.18: [647916988272fe5ecb4bb30cd02b51af9960618a]
stable/7.2: [0fd74477d05743d4cd9b25a3b667daa278d53b93]

CVE-2026-89957: s390/vfio-ap: Fix hot-unplug skipped when last AP
adapter or domain removed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89957

Introduced by commit eeb386a ("s390/vfio-ap: handle config changed and
scan complete notification") in v6.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [917f509bfb88048094dbb85c4e9dbc4d6fe4a886]
stable/6.1: [f58e824de8577fe411f6199d659731a0f86a7275]
stable/6.12: [753aa3bb1273bc0d36adb013d5915cc8ff6b72a9]
stable/6.18: [c45753c32d452d10d8efaeb52587e9e6e8126e33]
stable/6.6: [3a9b049bbdc40165d7f3e20b818eec95e5694d96]
stable/7.2: [04b35dd88c108b2d2ceaaa396aba1cb4049d5831]

CVE-2026-89958: s390/vfio-ap: Fix dereference matrix_mdev->kvm without
checking for NULL

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89958

Introduced by commit eeb386a ("s390/vfio-ap: handle config changed and
scan complete notification") in v6.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d50346801b4f144e42b49cd4f1496010498ab114]
stable/6.12: [334b435b951353f934d5110c4630e0cb58d2f9a7]
stable/6.18: [178ea7a1c2c3c0c01d14b8f60aa35f1e0cdc6b78]
stable/6.6: [5e932abfcce6189d067fffb0eb8214443bc04374]
stable/7.2: [4f7e869d0db24ae07b4c888fd3bc21554eef775d]

CVE-2026-89959: s390/vfio-ap: Fix control domain removal in
vfio_ap_mdev_cfg_remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89959

Introduced by commit eeb386a ("s390/vfio-ap: handle config changed and
scan complete notification") in v6.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6b8a02e216f6b520cc029e43ddc83956605135d5]
stable/6.1: [12871a4269f139221c9fde9ea3eb69c9228f59d4]
stable/6.12: [4bffadde7fc49b00493fb78c6376f958998d4b8c]
stable/6.18: [f7d66afc34bc6e833c8ebe56973afec35f473bc1]
stable/6.6: [02e72909453dee2f8a09f78819f9a9cb902dfbdc]
stable/7.2: [2ff68bf414de167bc138e6e211ee1ad3ab3c5052]

CVE-2026-89960: s390/vfio-ap: fix stale pqap_hook pointer on error in
vfio_ap_mdev_set_kvm()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89960

Introduced by commit 86956e7 ("s390/vfio-ap: replace open coded locks
for VFIO_GROUP_NOTIFY_SET_KVM notification") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4400270ec0348d05dc0439d8f0130853ce7f9e20]
stable/6.12: [6a180adafc2a8a5fbe815985c71b2201e93ab5e1]
stable/6.18: [fc069d00a0dbef40042fd681554d48dcd5a1d524]
stable/6.6: [eb6cc898501a004c0fa8aab951351d9c959b91cc]
stable/7.2: [13bfc94eef389bd664ffc67b00184919902c938a]

CVE-2026-89961: powerpc/mm: fix wrong addr_pfn tracking in compound
vmemmap population

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89961

Introduced by commit f2b79c0 ("powerpc/book3s64/radix: add support for
vmemmap optimization for radix") in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [89a4ae32764172468dea303eb6ae90fe6c859712]
stable/6.12: [e163c7184acf36ac20a248498f4a16016057ca01]
stable/6.18: [9c914b7a0bd18834505c65f22225ce22c152b2d9]
stable/6.6: [b96be860673f9fbbf12cdadb0b25fc4d6d4d207f]
stable/7.2: [7968852a7ca3ce81477ec5b4494a28d612f35a97]

CVE-2026-89962: powerpc/kexec_file: Prevent kexec range truncation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89962

Introduced by commit 180adfc ("powerpc/kexec_file: Add helper
functions for getting memory ranges") in v5.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa40f9dbdd4af53e7445d9135b5b207eb8adf372]
stable/6.12: [9ef63622e6cee588ea4b763a6afc87065254b36a]
stable/6.18: [da88a2a2119e4fd0e8919a7a2448682f574e1545]
stable/7.2: [c4cb547f26d9b73b489c5278d0c8db837c5a174f]

CVE-2026-89963: powerpc/kexec_file: Fix null-ptr-def in extra size calculation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89963

Introduced by commit 0d3ff06 ("powerpc/kexec_file: fix extra size
calculation for kexec FDT") in v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [761eda315a6e1fda3e8e2185b28430771fb1ac29]
stable/6.12: [11ef1c2a5dbe0bd8c1345f59bab7331d352f02cf]
stable/6.18: [df45337587db21c502fe5251d3bcc7887428f4fb]
stable/7.2: [4ff3d9fd71c7bc2fc81afdac1970d9c55a5c0dea]

CVE-2026-89964: parisc: eisa: Fix infinite loop when parsing invalid IRQ value

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89964

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b585431a16cfb9d8f2955a9fa0787ce3dceb3c2]
stable/5.10: [68659b627770f3c8d8f578e8ddee78a07d5f1d0e]
stable/5.15: [8640ade22369e248f77fbdd31a9d71b338499eef]
stable/6.1: [21f063e3c2b11fb9078ccdfd3b23634313ce4f0c]
stable/6.12: [bb10d54b74845eb4547baa1b9e908ecd32aa64e1]
stable/6.18: [3e2691eeee83a819125dba3f42c74e1b6730d5cd]
stable/6.6: [62d88e93ef5e1e04041e347945f7d7510eba1797]
stable/7.2: [16a62a3f2128b3d86fefc082d8f631becd02bff5]

CVE-2026-89965: nvdimm/btt: reject an arena whose nfree is below the lane count

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89965

Introduced by commit 5212e11 ("nd_btt: atomic sector updates") in v4.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6a1f2e5ed9267ca19187038ac635393c165213ac]
stable/5.10: [eb491343d2d1784121ad9af91c25b338c28913c3]
stable/5.15: [59d5cd1f42b4bab3609512c3cb3d3540d3d21da7]
stable/6.1: [f6c5313aae794ecca8f762c1a3493de5c266f120]
stable/6.12: [6f79d1a5f2611a3d36e9312be5425cd9cb397c51]
stable/6.18: [6b1faf1f099f7060b5f1f2f0d024132581f1726e]
stable/6.6: [f9bf05c63b77d000e9c01f3e47af36973887d350]
stable/7.2: [9dfa11cef4750b67591307f2c62e47a23d60e4b7]

CVE-2026-89966: mm/hugetlb_cma: fix null nodemask dereference in
hugetlb_cma_alloc_frozen_folio

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89966

Introduced by commit eb02f14 ("mm/hugetlb: allow overcommitting
gigantic hugepages") in v6.19-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b8a8ae4dd176a232e973017d2aa3c536a7275e2]
stable/7.2: [10f616ef06c5bd2d656a0eebaf73f9b09d150c24]

CVE-2026-89967: mm/migrate_device: avoid out-of-bounds writes for
compound folios

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89967

Introduced by commit a30b48b ("mm/migrate_device: implement THP
migration of zone device pages") in v6.19-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc41e961a269f2ca4196e669d6d8e05480899cd4]
stable/7.2: [99186b185c245f5987d7f8715d5504c8d8cc04a0]

CVE-2026-89968: nvmet-tcp: reject unsolicited H2CData PDUs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89968

Introduced by commit 872d26a ("nvmet-tcp: add NVMe over TCP target
driver") in v5.0-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [db62b35cbca052860c519cbcabe7650708528738]
stable/5.10: [02341ee424fb2eed16b5b8a9d247492e49335c21]
stable/5.15: [cade124c06f8e738e3a0df285ed2e08953e6bfaa]
stable/6.1: [14beef7d4f123fb458fc9844aa74a071871dcca6]
stable/6.12: [2b71f9193e3d3a352920ba367f1a6db345249038]
stable/6.18: [cf1484d9a75de6809ef331e16f525aaa41b0e16d]
stable/6.6: [9fb527103e53fd43a8e802c2eca407869c204f7a]
stable/7.2: [1cbed7538946c99e585acefd11c9ba3a0bdbae05]

CVE-2026-89969: nvmet-tcp: fix out-of-bounds write when receiving an
over-long PDU

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89969

Introduced by commit 872d26a ("nvmet-tcp: add NVMe over TCP target
driver") in v5.0-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [14cc5a7e77731497d5bea70f3bb05df7eda982e4]
stable/5.10: [a3f0bcfbaf3312a5754d1ce020a07d394669eb25]
stable/5.15: [4f84d42c53c49557fb1ef285c683b0a81b576c74]
stable/6.1: [58dc6035b79c4c73c0cbf9ec9f68a7f117b2b3e6]
stable/6.12: [3a385e0c39efbe34db8edd95900c123113ae3450]
stable/6.18: [dbc4acbdb3ca8c81441368ad7409b8f77d4de8f6]
stable/6.6: [cf5f39d2b58f97e0cd1829c4a6aeef17f1607cca]
stable/7.2: [d95d342bc0ea82dc79e6362b2f1f997431750e4c]

CVE-2026-89970: nvmet-auth: Synchronize timeout work during SQ teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89970

Introduced by commit 1a70200 ("nvmet-auth: expire authentication
sessions") in v6.0-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eaa948c0e19b1bb2d93262207bca0c3d19cc3406]
stable/6.1: [664022fa1c93f4eba09ef5ee02411b9709dd7a93]
stable/6.12: [c17c87bde6d6f5252a6a6f0a94b2430164aa28d5]
stable/6.18: [7555ddd60af72df2862dd8f9b730a9848577edda]
stable/6.6: [c3c126a6142a1335bc8c34a5607c39cf01daf295]
stable/7.2: [eb4f9127a2b8a152743f1ee597627e2f69cb54fe]

CVE-2026-89971: nvme: skip the zoned limits update if the zone info query failed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89971

Introduced by commit c85c9ab ("nvme: split nvme_update_zone_info") in v6.9-rc3.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3838e80fcfb32e62baffb63c6dc0a60153665a4d]
stable/6.18: [7fad53ae2052a2b4fc7ca567d6555bdb1176ba35]
stable/7.2: [bb6dafa79040357cf5043836e1db108c2af8b1e1]

CVE-2026-89972: nvme: add missing SRCU grace period in error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89972

Introduced by commit ed754e5 ("nvme: track shared namespaces") in v4.15-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef248d5de4469fb6bbaf8dbe0c4c47800080d648]
stable/6.18: [d663944dbad81bb0e3635d7090db4713e6300858]
stable/7.2: [76023560d60f10b4f808941163aa2975f1631683]

CVE-2026-89973: nvme-tcp: check the data direction of a C2HData PDU

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89973

Introduced by commit 3f2304f ("nvme-tcp: add NVMe over TCP host
driver") in v5.0-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f83af377c148f6ad94b41c0e8313f12adf45e1c1]
stable/5.10: [df74950ba6008655d4a977d17df7faf4b6e52b74]
stable/5.15: [980d990f3c0560d7dfbfbf14699651fdf02f26ee]
stable/6.1: [5b115d932f6e769ac80783fb18edd21b0aed256e]
stable/6.12: [80d56202fbdff8906be6954b2776e5c14a4026f2]
stable/6.18: [b4af7999a998787d5eb6facb5a333e04a4f1d2d9]
stable/6.6: [0673a2affe45ca76b60de31a83c67b1e60f81bde]
stable/7.2: [a0c389b8a495bda1eb719d2503853c924b7a8355]

CVE-2026-89974: nvme-fc: fix double free of fabrics options when
nvme_add_ctrl() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89974

Introduced by commit 1a9e218 ("nvme: split device add from
initialization") in v6.11-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [56e6279266f6962bb2d38a54397e3c605165b0c5]
stable/6.12: [8bd14aa065112b4d523bea690027c7527a6224f6]
stable/6.18: [7df913a7ced5d7349f0b23bdcf25ad54fe83a1c1]
stable/7.2: [5f89d68c00ccd1b25151da0bf660012380c2bad9]

CVE-2026-89975: nvme-fabrics: fix DHCHAP secret leak on parse failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89975

Introduced by commit f50fff7 ("nvme: implement In-Band
authentication") in v6.0-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [afdee49a1b88ed9bb44e2b30e855297c169bcc53]
stable/6.12: [702c1ae0d31b44828ec3c87079def490c1ee1fb3]
stable/6.18: [15d7a35a489287109b5a7c157d53d9b8214f0318]
stable/7.2: [d21da6cc91ba1c4f1ae5ba007f3cb89e1c0c7549]

CVE-2026-89976: accel/ethosu: fix job completion fence cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89976

Introduced by commit 5a5e9c0 ("accel: Add Arm Ethos-U NPU driver") in v6.19-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d2a3adc91950f9a18829dadc7317fb5180a15c5]
stable/7.2: [b3e0f79af1f27339d8d2527c02cc3e8397c2f69f]

CVE-2026-89977: accel/ethosu: check MMIO mapping errors in probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89977

Introduced by commit 5a5e9c0 ("accel: Add Arm Ethos-U NPU driver") in v6.19-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ab64476a610fe65858fdc37c7a30caa13e334ac]
stable/7.2: [f7aad73b481194e3f0efba9688e9a5914bbd036b]

CVE-2026-89978: accel/amdxdna: return early from a zero-length flush

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89978

Introduced by commit e252e3f ("accel/amdxdna: Revise device bo
creation and free") in v6.17-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc14753664240cedf669623b27ae9922b0618b25]
stable/6.18: [45962da5821d0a691f638ccb13842889156d8969]
stable/7.2: [f00def884a831dc49eb659dac2dd09dbfd21e67f]

CVE-2026-89979: ALSA: pcm: Fix race between non-atomic ops and trigger-start

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89979

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [acac7b5e07349a9d10d78873afb4b93cd1dc721f]
stable/5.10: [b1d12144557fceed5de6e22e2c2e30a40ed37702]
stable/5.15: [b2edc017f94c08bdd0b046a586e43ac771a2f942]
stable/6.1: [b599e7f16441386754ec083fa62a549bccb02fca]
stable/6.12: [5abeb4f9f2023f001d693b4e5e1ebbf25e25d0eb]
stable/6.18: [7ad2ea7c10044b08ecf7b04376916faf12e17a99]
stable/6.6: [ad29779736cfd6f5595f0cab300dd7611418e363]
stable/7.2: [50afadf1ea66597116eb14e73c24da7ae99b759f]

CVE-2026-89980: ALSA: harmony: initialize locks before requesting IRQ

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89980

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [33abb7491e89285a41565670945293dda841afc4]
stable/5.15: [9af6c9203583655cb7ed45e52e14101652b37547]
stable/6.1: [f86ff9238b0c8284909e073a681a60708b9f36ab]
stable/6.12: [9347588bbd6ad43a85e17046d9c117a41453c52a]
stable/6.18: [89992bda7dfbba7ded2ba4185730453c57fa65bc]
stable/6.6: [7dc239edb6d58e01c9ec868565cc03e7adf91747]
stable/7.2: [cd209eb3136e002becbda232e399fa31a2276436]

CVE-2026-89981: arm64: Don't read GMID_EL1 when MTE is disabled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89981

Introduced by commit f35abcb ("KVM: arm64: Trap MTE access and
discovery when MTE is disabled") in v7.0-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5445d64199626974269fcdf347769ad44b0bb53b]
stable/7.2: [d2d22ff377cd43f2e9660426ff22e3cd4c534637]

CVE-2026-89982: i2c: mux: Fix channel node leak on adapter add failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89982

Introduced by commit bc45449 ("i2c/of: Automatically populate i2c mux
busses from device tree data.") in v3.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [385c7af4e3b95d0769fd211831674e83b16a2ebf]
stable/5.10: [4f42f70afd2447f3c82ca69d1e03466a75348ba9]
stable/5.15: [4c9bc46a2a4afb7a11c48d33bdf19febab431015]
stable/6.1: [dd2c1e6747b17b24ecddd48a7bb6bb964c2793d1]
stable/6.12: [b580f062b24c4eef562f08f210c028adb34ef14e]
stable/6.18: [2b3b06cb709c4bf75a3fe3da3a0ca368ee3b40e5]
stable/6.6: [0927153f2abf48b6cc3e5f27063a17f7a8d47f38]
stable/7.2: [694e7e6edf249723ca7d3ef77c2ca1badfc78dc4]

CVE-2026-89983: i2c: core: fix debugfs UAF on adapter removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89983

Introduced by commit 73febd7 ("i2c: create debugfs entry per adapter")
in v6.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [b15b548d52b43ba8ac4652bc2c7244a8dd1e9622]
stable/5.15: [dc33a9762538b3250ed6b5644a4d44c748be33a6]
stable/6.1: [1f1bcd4eca6caa3e4258d9a31925112539406eb6]
stable/6.12: [643fb872aa04342d27dbef52b2b3cf3fe71b2c7b]
stable/6.18: [112b3d48084c820bbccf41d9783fd122e3ac4cb0]
stable/6.6: [f9094ace03e0a532cc6505d2e97b61ae738da4ed]
stable/7.2: [552836be2d95c688eede6371f85532abe1a71232]

CVE-2026-89984: perf/x86/intel: Fix kernel address leakages in LBR stack

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89984

Introduced by commit 47125db ("perf/x86/intel/lbr: Support
Architectural LBR") in v5.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e2b0575900ff72aa82748af96e7bd564ade5157a]
stable/5.10: [f3705db4e6378cc1b91a38ce0fe2f879055e23ca]
stable/5.15: [b589147f54adc62e4172e4acf079ad5fb7b3687f]
stable/6.1: [be0628a101ac05b085aaa4f650d48bd3915e80fa]
stable/6.12: [6ac26161db27f7fb9d9e89ae240dbe52795496cc]
stable/6.18: [3c492c8eba02698ca893a9a13388d2adf6dfb839]
stable/6.6: [ca19a175e89b7de604fab736436cbab74030b47a]
stable/7.2: [68c4b780b266a435261a1e029bede5ee3c2735cc]

CVE-2026-89985: memcg: keep folio's objcg same as its node

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89985

Introduced by commit f1cf8d2 ("mm: memcontrol: eliminate the problem
of dying memory cgroup for LRU folios") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf4ade7dbd76d4ec8697840e4ebb15ed77c5ec26]
stable/7.2: [6165478eaa3094eaee1d5e33b12520064faf043d]

CVE-2026-89986: mm/mempolicy: fix sleeping allocation in
alloc_pages_bulk_weighted_interleave()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89986

Introduced by commit fa3bea4 ("mm/mempolicy: introduce
MPOL_WEIGHTED_INTERLEAVE for weighted interleaving") in v6.9-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [540e583b66d6402bf556fde5e53c817a54c1afe5]
stable/6.12: [bcb3d0c867ee40dc48e9c085bf328fbc679b6656]
stable/6.18: [0ceda28f371df9e0bbdaa29214f71fe8298f23d8]
stable/7.2: [2943f1f4b7f2816177060eb9f551f2e6d8b629ba]

CVE-2026-89987: mm/huge_memory: transfer the pmd dirty bit to the folio on zap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89987

Introduced by commit b507238 ("thp: support file pages in
zap_huge_pmd()") in v4.8-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe6cf984939d8e12cb33a99673c8d026c5135e68]
stable/6.18: [effe3cc6d4fdd407457eb30f7b0ef094393f0d64]
stable/7.2: [9435cddf1378d149d826bd7bd1448a44bf96868d]

CVE-2026-89988: kprobes: Protect kprobe_blacklist with RCU

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89988

Introduced by commit 376e242 ("kprobes: Introduce NOKPROBE_SYMBOL()
macro to maintain kprobes blacklist") in v3.16-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c4256196b3a105307e2235fbfd85e768bbcdd0f]
stable/6.1: [8f406205003f741225f620f0e357ca0de71d45e3]
stable/6.12: [518d9b5568bb06f86e4434f7a30faa9612ea91ad]
stable/6.18: [5da247e4d1e8661d4d6f997101d59967e8994e32]
stable/6.6: [630ed8734a02b992e8a97538179c2ece42c5210f]
stable/7.2: [6e62cf983a2bd547e6bbd3f935539233e5f97f8f]

CVE-2026-89989: ima: Check for ERR_PTR from dentry_path() in
validate_hash_algo()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89989

Introduced by commit 4f2946a ("IMA: introduce a new policy option
func=SETXATTR_CHECK") in v5.15-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8861f6d5c0678a7c5089c7b272509fc5931b8437]
stable/5.15: [d6fade89903c8fd0af6c956242aec8b927040e02]
stable/6.1: [0de5b525c0cd7d202848b8adfde3c01c287fb1a6]
stable/6.12: [9e69d683ebd7def04557fe758ff123105d7d9840]
stable/6.18: [f8a2f2a4602318eb93d49d27fd0d0fdaab17edde]
stable/6.6: [30b5c0e17dcad72b6b2f987319aa645570e6376d]
stable/7.2: [d62a84a78de5f29c642fa3bd4eee072ba7289cb4]

CVE-2026-89990: ceph: lock mutex in ceph_mds_check_access()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89990

Introduced by commit 596afb0 ("ceph: add ceph_mds_check_access()
helper") in v6.10-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a61c6ae1dae2611082b831b4aaa780878099c012]
stable/6.12: [729c1ff670ece6f3d4b1738365a0b2f90d487523]
stable/6.18: [ca5bfea2045ef2eb3305cf2a9d8da549b76c37d3]
stable/7.2: [df1a97d5313fccadb08390306d49b194fb027392]

CVE-2026-89991: bpf: Fix infinite loop in pcpu_freelist push with one
possible CPU

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89991

Introduced by commit f2ac0e5 ("bpf: Convert percpu_freelist.c to
rqspinlock") in v6.15-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [efebf6496685c93150df5bb0794363ae70c5f58a]
stable/6.18: [a24a146ae2cb5d9faeea96d10010fcb6579abe1f]
stable/7.2: [a5b5e62baceff9e252c6535cf42a027d04f226cf]

CVE-2026-89992: cpuidle: dt_idle_genpd: kfree() the original name allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89992

Introduced by commit 9d976d6 ("cpuidle: Factor-out power domain
related code from PSCI domain driver") in v5.18-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b0ac85512b7f67479127b2713254490662eb13d]
stable/6.1: [1312ae33b91430ec99e69cd3d47f0e50a4ebf54b]
stable/6.12: [09d002c8fb0261d35ce9d8a705de5db034ee90b8]
stable/6.18: [b519dfce1998c323e54a56f911cf708d9ba0e076]
stable/6.6: [a38caa9ed0d5c61c17d88393b14b292199289c1f]
stable/7.2: [3394c7ba23336bdb7ece29127130fd01731d42d8]

CVE-2026-89993: dmaengine: dw-edma: Initialize IRQ data before requesting IRQs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89993

Introduced by commit e63d79d ("dmaengine: Add Synopsys eDMA IP core
driver") in v5.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [647217abea849d3d45f8cb0b8ee5b78d50f26985]
stable/5.15: [b86280b12ccf33b68b309b7cb0e4476894dfe77c]
stable/6.1: [07e50cef557def076418c67051a336e4c6bd50e1]
stable/6.12: [d232bc6cf4562132ef50644484dfd4b23a593295]
stable/6.18: [fac202d73e7a649b7d4010325c6c6dcd9334fe65]
stable/6.6: [17ef63843c0fcbf1efdfbbfb0f5584a5ea2c91ba]
stable/7.2: [d91fb6c0d10dad32929dc5c6850f89df34e1bfcd]

CVE-2026-89994: dmaengine: fsl-edma: tracing: no ptr dereference
during log output

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89994

Introduced by commit 11102d0 ("dmaengine: fsl-edma: add trace event
support") in v6.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ea04dca8e627f722caa7a2037cfbae0257f3501]
stable/6.12: [ef02cd3807f39ae1dbc924788d8fa6a85334c435]
stable/6.18: [d382aaf5fed38c6dd2e0cc710d97cb81d660ffa7]
stable/7.2: [2a3801ae5c344473e648006c5b03a9216ac54a6a]

CVE-2026-89995: dma-direct: return struct page from dma_direct_alloc_from_pool()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89995

Introduced by commit 5b138c5 ("dma-direct: factor out a
dma_direct_alloc_from_pool helper") in v5.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [94a04ad732c9f8b9554270fc4038a06737de5c22]
stable/6.12: [c3fdb94da43ff23287f85664174c45c45e881a3f]
stable/6.18: [408ff2d5bf555bd3f4c84a2edb95c0690bf9edc8]
stable/7.2: [feeb2ef775081a6c188cdd10e7a45369a07ce531]

CVE-2026-89996: dma-buf: dma-heap: don't publish fd before
copy_to_user() succeeds

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89996

Introduced by commit c02a81f ("dma-buf: Add dma-buf heaps framework")
in v5.6-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [30d0aff2c65a277135cfd8ea28fa1ee75e0ea4e0]
stable/6.18: [69d57dbadb27ffd5eef34fd184bab145500cdabc]
stable/7.2: [0d4a5d218055db29b50cc07d3d73d27007c2a391]

CVE-2026-89997: dm: fix resume-vs-remove race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89997

According to the .vulnerable file, this bug was introduced by commit
3f77316 in v2.6.36-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [44b43ec132f1cf3275ecc182d0c82f50c3c4c3d5]
stable/5.10: [9757367bcf1d5d2c50b94d005abca21f3eedd7c3]
stable/5.15: [1ede2bce2bd640605df83db1356fd727159bc9ed]
stable/6.1: [3f04e6520d9a53adb1d1daf4dc5d31a60fc77d1f]
stable/6.12: [3b59530b14fde693e41d8e39bc326df6cbf07b76]
stable/6.18: [36177beff2a9df035991ad8d16ccf8d363ed93ee]
stable/6.6: [94f3d399c1ddba763c1c5a6501f7375d533d789f]
stable/7.2: [94380ecd5ff9b2a2b9f6e8a0b5c465159ccfaf71]

CVE-2026-89998: dm: fix race when loading and unloading a table

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89998

According to the .vulnerable file, this bug was introduced by commit
1a581b7 in v6.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5380c7f6335cc6d77eb77d065105e81155c4d9d3]
stable/6.1: [b02e35b81176c7d61dd441cc7a2e5c324a82444b]
stable/6.12: [a1af1884c960b98c621b6fe2fea1216b78c02152]
stable/6.18: [af1f32ccf8051f4691ced11feb452b9d13561727]
stable/6.6: [0ea6e5ad4a5817e91f11b4cc1e022e575ed2e7ca]
stable/7.2: [00ad6f9ed27f91925d4d3fb7aab50a60d774f998]

CVE-2026-89999: HID: wacom: validate report length in wacom_intuos_pro2_bt_irq

Announce: https://www.cve.org/CVERecord?id=CVE-2026-89999

Introduced by commit 4922cd2 ("HID: wacom: Support 2nd-gen Intuos
Pro's Bluetooth classic interface") in v4.11-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a8e04f3f894ccb52cfcd7e60125a9f35da4a616d]
stable/5.10: [d2844f3fcd058113acbe0aa110ab13ef28b98d9f]
stable/5.15: [1bfc0547b81d5861443420d19b5ed2fd533cd17f]
stable/6.1: [84781a1f3c5dc6650480be9329e6e8528939eaa0]
stable/6.12: [114af803e409a68e52516810ecd24df4d8ce0c68]
stable/6.18: [74ec08f7b81c2726578039ca6dea0fec136c38ea]
stable/6.6: [96dd0af7597aba2d80cc97e2f66e8b72d30ba125]
stable/7.2: [0cdc6cb242dd8d2731956fdf3390de094482a4b2]

CVE-2026-90000: HID: rmi: fix OOB access with undersized RMI reports

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90000

Introduced by commit 9fb6bf0 ("HID: rmi: introduce RMI driver for
Synaptics touchpads") in v3.16-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4956993bb3befdf791d71a4952d8d13bcfd44c7b]
stable/5.10: [fba600d824597b2a894ecae72fc422c2b8c08f8c]
stable/5.15: [056ef8e6700b8b6ca11453a9d4bfb1b868a5cd88]
stable/6.1: [183da103022ec11af55ba9951d2cc171fb6c836b]
stable/6.12: [ab2958e0c94edd63315dd14dc548874cc63a4043]
stable/6.18: [f4cb9c4556dcb593e66dbb855179dbd351dbb053]
stable/6.6: [a8be8bbf0952bb7ff46636ead1896769c381fe55]
stable/7.2: [48934c2927414a37a7fadeb6091113177c0b2038]

CVE-2026-90001: HID: bpf: serialize device reference release in
struct_ops destroy path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90001

Introduced by commit ebc0d80 ("HID: bpf: implement HID-BPF through
bpf_struct_ops") in v6.11-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9cdc7e6dc7a99ad7311ad5e7c145f2b9ce4e24b0]
stable/6.12: [401359684620145be710de97b87e1a47abfe1459]
stable/6.18: [c7f927aa8b55008ed5ea0814313d5dad771dcf3c]
stable/7.2: [bfb7939788f3c8dd080a4dd81e38d625b35d194e]

CVE-2026-90002: ftrace: Take trace_array reference before accessing
its ftrace_ops

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90002

Introduced by commit 591dffd ("ftrace: Allow for function tracing
instance to filter functions") in v3.15-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9100191e5acb2e5ea2313f436667bb5fce129f47]
stable/6.18: [83fd7eca5ab0d3ac3f23bff889175d847e21af06]
stable/7.2: [cee8f286794df916553d8d445eac5c323ec5b0f8]

CVE-2026-90003: futex: Prevent rcuwait use-after-free during requeue PI

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90003

Introduced by commit 07d91ef ("futex: Prevent requeue_pi() lock
nesting issue on RT") in v5.15-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3b8d46fe401cba3a5c46dea610e6eb3dc15370e]
stable/6.1: [220ee9e04ca3b7f014c000264aa6c884f036c86e]
stable/6.12: [244f301759fd34b1dd0b4192ce44f8ef224e027d]
stable/6.18: [7d1559126d86be6e4f6a85663dfbfe85caa47e37]
stable/6.6: [81aadbd09bf1dcd3238212f336ba699503557ae8]
stable/7.2: [e4a4ccfa470f910b747b3ee8d18670ed8ac8a236]

CVE-2026-90004: mm/damon/core: handle region split failure in
apply_min_nr_regions()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90004

Introduced by commit b1029f2 ("mm/damon/core: split regions for
min_nr_regions") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c608748607620f331196ed0ba9fe4017892c1457]
stable/7.2: [463ebd63e8ee3d73022a18915ea43320dad8aad7]

CVE-2026-90005: samples/damon/wsse: handle damon_start() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90005

Introduced by commit b757c6c ("samples/damon/wsse: start and stop
DAMON as the user requests") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e4742be45ea45bf554399ce89a09f71e525d7981]
stable/6.18: [6179c7f47876d576dfe30efa8fbf1b0b1fdd13c0]
stable/7.2: [e60774d6335b89fac0be8b17a041fcffc508d281]

CVE-2026-90006: samples/damon/mtier: handle damon_stop() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90006

Introduced by commit 82a08bd ("samples/damon: implement a DAMON module
for memory tiering") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9dc5b6d66fd51b103eff21ed0df3e292f489ebc0]
stable/6.18: [3c07c57b894116ae26f01b84c68e68b538ada7ed]
stable/7.2: [215f9a7e4f1dcfc05ebcdc5c1ad0ea0dcb47bd09]

CVE-2026-90007: scsi: pm8001: Use rollback index when freeing MSI-X vectors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90007

Introduced by commit a76037f ("scsi: pm8001: switch to
pci_irq_alloc_vectors") in v4.11-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f92a64545165bdbb36dee8fa35626b295463313]
stable/5.10: [f39e3ca1f688d7c08954a0794e9bf1e279c83b15]
stable/5.15: [a980dec7c69990e4f119bcf6a2ea093d1c4975e8]
stable/6.1: [0205db768570f9a46b20912afa581a0c7a63d8b7]
stable/6.12: [fb22a8d2f3ac6665cc8bee197096b6675cac1a9f]
stable/6.18: [dd817463c9b42a3a9e23d15b86c6c77a6cfb809d]
stable/6.6: [2853ce9c88e0e6dd575f95f28b3a8c2b27164115]
stable/7.2: [e20b16aa3b49f9db5510940740255a987e6f2a6f]

CVE-2026-90008: scsi: megaraid_sas: Limit NVMe request size to the PRP
chain frame

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90008

Introduced by commit 9b8b848 ("block: Increase
BLK_DEF_MAX_SECTORS_CAP") in v6.17-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af8c27375733fb6a6df9fa484cda77cc3dd0cb80]
stable/6.18: [4bb34769ef44ab3770b89e4055de6af4a458bec9]
stable/7.2: [4dd118d06dec9efe5065ac7897bdc18f404a3af4]

CVE-2026-90009: scsi: bsg: Fix TOCTOU in io_uring passthrough command setup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90009

Introduced by commit 7b6d325 ("scsi: bsg: add io_uring passthrough
handler") in v7.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b3c5965fca99f62d31c963294bd5b23cc488e97]
stable/7.2: [f033530105aa73d82c121d54b57f358e4865d2f4]

CVE-2026-90010: scsi: bsg: Cap io_uring sense copy to max_response_len

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90010

Introduced by commit 7b6d325 ("scsi: bsg: add io_uring passthrough
handler") in v7.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ece06de726737e887dc0225c8283477624f8ae21]
stable/7.2: [5d326efc334ea21afd8161f6ca53e17de71948a9]

CVE-2026-90011: scsi: target: iscsi: Reserve a terminator byte for the
login payload

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90011

Introduced by commit e48354c ("iscsi-target: Add iSCSI fabric support
for target v4.1") in v3.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f4825922d2fb371e2b969697d792077f1b62b62c]
stable/5.10: [5fac79f248c37774d1dd761406f83d25ca6ff8e4]
stable/5.15: [6ddddcad436d8e6e619204d3c848147ff2f5bf1e]
stable/6.1: [b19dc17ed963ac36c0db4b52a1803fb11169f91f]
stable/6.12: [eb9dadf4d552ebe10644871c5189286552aa48f5]
stable/6.18: [1624bff4c5118ad494d50ad94d44f22064667a7f]
stable/6.6: [6b589ef9d5f6cdc70d2b4f269ca6cf26b5ebb076]
stable/7.2: [3ddf3ea291a0ef2ea93b82e158960ac2cc42302b]

CVE-2026-90012: spi: Fix DMA mapping ownership on partial map failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90012

Introduced by commit e289df8 ("spi: Rework per message DMA mapped flag
to be per transfer") in v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [367cea239fc93094e5c16a72724800e0358f5c46]
stable/6.12: [cc8354213ad6bd5fb8cc05a3fa3701188d086626]
stable/6.18: [a38051fa2ddedbc8ec15292c55e276880ec5b9a4]
stable/7.2: [5def8b6aaad44603740786262b95b6f77df52a1c]

CVE-2026-90013: tracing: Take trace_array reference when opening options file

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90013

Introduced by commit 577b785 ("tracing: add tracer dependent options
to options directory") in v2.6.30-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f2951ebd15c36a1ea4820a7f0cbb0b5f1c028b73]
stable/6.18: [d0f37d77b9b4b241e0b30ef2562f6353cbda3bec]
stable/7.2: [64a41f4a9a968f54f3792399aa4d2a9fdb23b0a5]

CVE-2026-90014: tracing: Have show_event_filters/triggers files take
trace array ref

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90014

Introduced by commit 729757b ("tracing: Add show_event_filters to
expose active event filters") in v7.0-rc1.
Introduced by commit 6a80838 ("tracing: Add show_event_triggers to
expose active event triggers") in v7.0-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f4a771cc684c7354b6200147f7252c58d17408ff]
stable/7.2: [2ee3f7d43f79efaca0cd84a6798653d9d75ce60b]

CVE-2026-90015: xhci: fix lost bounce buffers on TDs spanning several
ring segments

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90015

Introduced by commit f9c589e ("xhci: TD-fragment, align the
unsplittable case with a bounce buffer") in v4.8-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff44dfb03a293bf30e31f98772a1dd316a6071d1]
stable/5.10: [c8124b28f12dbdd126118e63d0ebf8093a01fb81]
stable/5.15: [e04d5304a248e5d2a7f4faa87541644bdd320cfb]
stable/6.1: [a1629dfb011446d02905778f6df19f14c5f4f3b3]
stable/6.12: [3c9a2b5a4f1183696f02ac280ced1d34afb409b1]
stable/6.18: [efaab8938fb92979be6df359f7d1a43fb7e4717d]
stable/6.6: [43239fc6dfb62c50ae1b9c0e82bac0f8cd2e285c]
stable/7.2: [7236bbd2cb7d9fc0eda896bbd34790341e2a4377]

CVE-2026-90016: staging: rtl8723bs: fix OOB read in rtw_restruct_wmm_ie()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90016

Introduced by commit 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in v4.12-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [28a289beaf226b30b1e6e7d7b1a2946fe2d6e852]
stable/6.18: [4420cc71841b50e31a7868ef7acb011c0e08d294]
stable/7.2: [fd19b8895f8a91087e8a62f1e27b128025dabb95]

CVE-2026-90017: staging: rtl8723bs: fix OOB read in rtw_action_frame_parse()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90017

Introduced by commit 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in v4.12-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff917923f4fb9c83717ba135ee47d7e4c1567bb7]
stable/5.10: [15081ff835b29e456da29303b32efc436df04695]
stable/5.15: [310aaa8058d19cc431aedac0f5bb814e84479393]
stable/6.1: [1410bce22351ba15d8e58287cbf09d55d7f21fc9]
stable/6.12: [136f9a3ab87ded8aaf081425cfb2059659dd9023]
stable/6.18: [b041e3f35e0d262d42a711094ab594634d72744a]
stable/6.6: [0b7f64c7bb9664777168768c6b44affb07dcbf24]
stable/7.2: [a54fd1a44862d263df9f8bc17fca3620be31addb]

CVE-2026-90018: staging: rtl8723bs: fix OOB read / stack overflow in
rtw_get_wps_attr()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90018

Introduced by commit 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in v4.12-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [99aa998dec83ba180822f70e6d48a514fc81c20d]
stable/5.15: [931640dfcb8cfa08f6cfb46229716d8072356420]
stable/6.1: [3a6457ebf39080b87c712657fdb38f34a24fc3ff]
stable/6.12: [a53d1ac9ce63db07943b2b2248111003851fb00f]
stable/6.18: [ff61aa3289355dafa811550a1764691cd1f5d33b]
stable/6.6: [fd5e24ea8373347d0352f153a66e8647337d1b10]
stable/7.2: [34f51d196c43a42046d229de5e79025d5ca553ca]
CVE-2026-90019: usb: gadget: fix null pointer dereference in
usb_put_function_instance()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90019

Introduced by commit 0062f6e ("usb: gadget: add a forward pointer from
usb_function to its "instance"") in v3.9-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6e74ac5c596fd246e37eadfc354567179ccbe9aa]
stable/5.10: [0fc54a00954f9f4c3e3d4ffa64a530685d99a39b]
stable/5.15: [6e6736c049683380f5e20becde498986e9293ca4]
stable/6.1: [3a9691fff79bcce95338435599df6d3ae433cfdc]
stable/6.12: [6ea3a073ca97716d4a73df49a3bec1c3ccf8e2a0]
stable/6.18: [d3a7fa61997db3bf6dadef4c1bd87a4fa782a817]
stable/6.6: [7a4f4ca7ff32ae24807c83e2a06d62b13378d53c]
stable/7.2: [5117f236e9e30744338b425395d55913c4500897]

CVE-2026-90020: USB: gadget: fix NULL pointer dereference in gadget_dev_ioctl()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90020

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd0eed9e165b1a6292f49e622e3dd0b7d99b106d]
stable/5.10: [8be30959be31b4205e3bdd2e2a6221f3a2ee7ea1]
stable/5.15: [e8219accce2f6d3502ed71f5b5e854ecf27249a6]
stable/6.1: [87cbf9410b12f5c2d659bb01e8ecf6517cb9f28c]
stable/6.12: [ebd916fdfefaacbc0e577f7037ec96b31a105e5f]
stable/6.18: [c29a83c1ff3f06d5751f6d365b606c9f81ccc4cb]
stable/6.6: [162178ca83c3de986900385a0477eb539f8e1a7e]
stable/7.2: [64ec019bf9a8b12f53b9f2777d65aadb730b5a84]

CVE-2026-90021: usb: gadget: f_midi: initialize work in f_midi_alloc()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90021

Introduced by commit 8653d71 ("usb/gadget: f_midi: Replace tasklet
with work") in v5.12-rc1.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [7e07d3e4c389217d7d7171d80edf2e23ac70f1ea]
stable/6.12: [3d8b11255e632170f32f1925bfcaf96331f36317]
stable/6.18: [02ac76f27db23ef652358458c272d9d2d6f51167]
stable/7.2: [858576de6b2f5166b08dae803f0fd0766dcb3002]

CVE-2026-90022: usb: gadget: f_midi2: fix use-after-free in string
attribute show path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90022

According to the .vulnerable file, this bug was introduced by commit
29ee7a4 in v6.6-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fed0aa7c6eaedc6c0d4e362fc91724aa47be4a7b]
stable/6.12: [d11f3300b39e2daad2f0d9d66ddcc39a156cb594]
stable/6.18: [e89e30f0b5d3004fe5955250bd8b04f3733e32ce]
stable/6.6: [f9bdf4c4f6410a1dfafafa383a0e21069372657f]
stable/7.2: [49fab5e1bdb205c36c965d0e9677bc40d282d3a2]

CVE-2026-90023: usb: gadget: f_mass_storage: fix null pointer
dereference in fsg_common_set_num_buffers()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90023

Introduced by commit fe5a6c4 ("usb: gadget: storage: get rid of
fsg_num_buffers_validate()") in v4.8-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c0f5ca48674a5b5f9fa4a9c3325aa48053af0bc]
stable/6.18: [9e8dd2a7a8ccbb756771ad985b0ad3387ed3c957]
stable/7.2: [b9b5b5df5b8dd3c1572ed267200276a44cc67d8e]

CVE-2026-90024: usb: gadget: midi2: Fix null-pointer dereference in
f_midi2_free_ep_reqs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90024

Introduced by commit 8b64592 ("usb: gadget: Add support for USB MIDI
2.0 function driver") in v6.6-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0efaf1872949e96d213c8e910fd9517f7d7c406]
stable/6.12: [5b92f6a0c7c01efbb335d837ecdf34d38d98720f]
stable/6.18: [9c3d5091e3568ed48ac4c5b08a78eb06fad0d70a]
stable/6.6: [51ddc55c75087ac25342f6d73d3aeaf14f59bd76]
stable/7.2: [4079f19a0e1ce76f1e21a398f02aca150ceaaf61]

CVE-2026-90025: usb: typec: ucsi: displayport: Fix OOB altmode array index

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90025

Introduced by commit af8622f ("usb: typec: ucsi: Support for
DisplayPort alt mode") in v5.2-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [04cec690b1fd9d1c4c314b91a10d8c68a3acfe18]
stable/5.10: [8fde7e4a366184e9a6aa95541e52933a73c00a74]
stable/5.15: [83f1abd62cc134700ba92e1e2dc650a49a185497]
stable/6.1: [1ffed96ef986e2cdf986aa4a4506a5e6dcdf4456]
stable/6.12: [ac9f878c468052af6571e8639ab1c3ae040b908f]
stable/6.18: [33a81acd2d1d0667d4eff93cb90339fa53e617e8]
stable/6.6: [58e0ee293ec5e06cacbe3953ad44042f1473dae9]
stable/7.2: [bdaaf3074aedce8f1b173cc363d61cff5f6a585f]

CVE-2026-90026: usb: typec: qcom-pmic: cancel reset_work on stop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90026

Introduced by commit a4422ff ("usb: typec: qcom: Add Qualcomm PMIC
Type-C driver") in v6.5-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b0df6efd143f8085bdb68778a013a46f1349913]
stable/6.12: [b9a7eed472edbfa8dec0fdeafd5e796550a8a8b7]
stable/6.18: [d4e00a1eb39174e25ef759b8fb1111bba8e87b1e]
stable/6.6: [0b69b166852dbf1f9532b22bd49f502e5970eb95]
stable/7.2: [52d556f08547733948cc40b8b11e6b68dccee7b2]

CVE-2026-90027: usb: typec: qcom-pmic-typec: disable cc_debounce_dwork on stop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90027

Introduced by commit a4422ff ("usb: typec: qcom: Add Qualcomm PMIC
Type-C driver") in v6.5-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [263f7d61a4201cde16849b2d016251806e7418be]
stable/6.12: [4359b5f95c93a4658e08368fa6fab9d89eb98447]
stable/6.18: [c614d7c44ca7fb78867ba46b233acdb59287e8c8]
stable/7.2: [1ab669c2b44e1040ddfab7cd7f717aad580d17aa]

CVE-2026-90028: usb: typec: hd3ss3220: track VBUS enable state per consumer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90028

Introduced by commit b3f9d6e ("usb: typec: hd3ss3220: Check if
regulator needs to be switched") in v7.0-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9a48db776d7184981630ecc01a3ad30a8f7dc24]
stable/7.2: [df7cd3908e07503fa7e9737dacf44208530e58d9]

CVE-2026-90029: usb: storage: realtek_cr: fix use-after-free on disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90029

Introduced by commit e931830 ("Realtek cr: Add autosuspend function.")
in v3.1-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ffee1aebb0c0ffcda9faffd17834ea9b00d42cc]
stable/6.18: [7c4e2f964c65dea4ea22386799d5fb10ef1e3e54]
stable/7.2: [cae9dbba6adae21a04a3bd045e07b489847ff2c6]

CVE-2026-90030: usb: dwc3: clear forceRM when issuing EndTransfer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90030

Introduced by commit 1e43c86 ("usb: dwc3: core: Add DWC31 version
2.00a controller") in v6.9-rc1.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [b58e6200450d350314db0ecda7d6d1bde3281e80]
stable/6.18: [0afe5c31612de3d18cc6d16e616da4a48ba1e5a2]
stable/7.2: [e01408ee52fe5cb2d0b43f47f359336af2b6c316]

CVE-2026-90031: usb-storage: ene_ub6250: fix race between scan work and probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90031

According to the .vulnerable file, this bug was introduced by commit
41e568d in v2.6.39-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [445fc368c6bc73eff0aeb3818cf5f355facfbb16]
stable/5.10: [9cd335f4f41e84d1ab88d80150ffee8dee9650d7]
stable/5.15: [8936d95dd04d34db96d4d1e3899eee52605bbedc]
stable/6.1: [9c261a83131e241d67cb73ab578d0265bc19cfb5]
stable/6.12: [5082546702c32a2700894d2c0ace784e038ef6a3]
stable/6.18: [1c67f2ba9c5f7c5ab3670671c0d51c6504bcaf74]
stable/6.6: [9481bc04a8c351ed883a7f0e10939bbe9120ead7]
stable/7.2: [996c319b8bd5ada1f62daae0d331d0b23e0f2117]

CVE-2026-90032: media: usbtv: keep device alive while ALSA card exists

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90032

Introduced by commit 63ddf68 ("[media] usbtv: add audio support") in v3.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fc530fe168bb2b745a93f553ad21fc25fd9cba3d]
stable/5.10: [97b5e8b22b98e287481a97a9a4cfebbb348738a5]
stable/5.15: [503be26ff888cb3576e55d251895d290e8146f27]
stable/6.1: [be0f7745f883386e5263b4e475686a81dfa87175]
stable/6.12: [239d1683e08b2aee2a15ef35706e1ea9a76681d8]
stable/6.18: [7690a86b193271322cd31ab77349a87aa10858e4]
stable/6.6: [67374e3a00814dcdd46e9feca61f69f7f2d81957]
stable/7.2: [1618257cb0aba4ce342ae8c0228368c24161f5fb]

CVE-2026-90033: ALSA: usb-audio: fix OOB write in snd_usbmidi_us122l_output()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90033

Introduced by commit 030a07e ("ALSA: Add USB US122L driver") in v2.6.28-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e4637ce34607f1733a34a57294966d26b263e626]
stable/5.10: [5538daf2a5cc80ac3f3e913c0db045d92d995d40]
stable/5.15: [a441a8e52148c91c2f2a91f42e3b9bc961a13a4b]
stable/6.1: [2dae0e3a59e31f78222279d544b98e747cd1fbff]
stable/6.12: [de6d252f115be887a701c09a05cdb076f3a590c9]
stable/6.18: [9392a2c346762ffee8edd1ba8bac50d2e24a2ed7]
stable/6.6: [1d4add2b832b56f81bb0eab065ec35c610343018]
stable/7.2: [9d81885d97cba7796d1f8edc88f2499c8296f5b9]

CVE-2026-90034: usb: image: mdc800: change kmalloc() to kzalloc()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90034

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2430eb81e44111b30eeb5273bbcf8b24ca517ef9]
stable/5.10: [6c601410d1a9ae645f604fe2f61b9f4942c77dfb]
stable/5.15: [2df8f7720ed91f1aad4f128553b6e90c7c5fac1e]
stable/6.1: [67c6726dd6048a2781aa43a2bf9fcf1e16ee3a7d]
stable/6.12: [8c38049879f2108f57c98f03cc7f3db51a12bdab]
stable/6.18: [838455cc8bfe1278150d1d776529edea6cd4c1dd]
stable/6.6: [553c375e86a49882e95840565512e17bff31cc3a]
stable/7.2: [e22428f0c038c23109c0383a235aa607b0cd4c95]

CVE-2026-90035: drm/amd/display: fix division by zero in get_estimated_bw()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90035

Introduced by commit 8e5cfe5 ("drm/amd/display: upstream
link_dp_dpia_bw.c") in v6.3-rc1.
Fixed in v7.3-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f63de9054da858d57054474c32464106f8375e0d]
stable/6.12: [ac2ab58a79bf2401ae8c5d1c030bf0a5a376f43a]
stable/6.18: [4814f28c45f58a71a80d09b80a60da6a063b539a]
stable/6.6: [4c5b61b9df6ab33b55f228e1b6579cefad11a9f7]
stable/7.2: [b08c3d5ee7feadd821208f7c2c1ec02a16ce5878]

CVE-2026-90036: NFSD: Prevent client use-after-free during blocked-lock reaping

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90036

Introduced by commit 7919d0a ("nfsd: add a LRU list for blocked
locks") in v4.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9026932ac8be4d0ae01db47f23619a98cc57b671]
stable/6.18: [cd489b03587378645fe0d20142a33f1ed60bac98]
stable/7.2: [6fedb2eaff77554ca7a0deffd2e8bc0d6e8b38b0]

CVE-2026-90037: NFSD: Prevent client use-after-free during close_lru reaping

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90037

Introduced by commit 217526e ("nfsd: protect the close_lru list and
oo_last_closed_stid with client_lock") in v3.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2330b788d732f43668b965b3105b37ceb276dfea]
stable/6.18: [83dd59ac1c3455c2c7d8ddb582d980a13199b9b3]
stable/7.2: [e57a9ed34ea8c17e831de59b8f1a6b2d80d347a1]

CVE-2026-90038: NFSD: Prevent client use-after-free during export
state revocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90038

Introduced by commit 2eac189 ("NFSD: Add NFSD_CMD_UNLOCK_EXPORT
netlink command") in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2108de53568a64936a0da3e04d85c35df98d3fb6]
stable/7.2: [c05ae58fe06ce2ac34312f649e71c3596bdde358]

CVE-2026-90039: NFSD: Guard admin state-revocation walks with NFSD_NET_UP

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90039

Introduced by commit 1ac3629 ("nfsd: prepare for supporting
admin-revocation of state") in v6.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f3e6638aebc0ab8afb8b4e9816ea9a1cad85378]
stable/6.18: [104a51265042b4424085741c963cb858ac29ec0b]
stable/7.2: [0146467a2fce845cb6629979c3e9c58dd3d3a6a3]

CVE-2026-90040: KVM: SEV: Forcefully invalidate SNP VMSA if its
backing gmem page is zapped

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90040

Introduced by commit e366f92 ("KVM: SEV: Support SEV-SNP AP Creation
NAE event") in v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1a3c216233413f57f5341a9b878b7e2dde7e785]
stable/7.2: [2640cc26ed0dd1bf6ec2f6852a60e494093db3e5]

CVE-2026-90041: HID: sony: clean up device list on probe failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90041

Introduced by commit 4f967f6 ("HID: sony: Fix memory issue when
connecting device using both Bluetooth and USB") in v4.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7c65699a3a311198a07659a614fe64d45924839e]
stable/6.18: [3b4709e4864908bb06c48c500cc8db8d3d55d139]
stable/7.2: [d044d796e2a369c6051c7e83dce88c7baa2494d4]

CVE-2026-90042: ceph: properly decrypt filenames in vmalloc() buffers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90042

Introduced by commit 457117f ("ceph: add helpers for converting names
for userland presentation") in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e939fc6a7bd969a58a150b7f188c1047138403e3]
stable/6.18: [110747ff535e3d98ac17d68dbd056bb6ef000e23]
stable/7.2: [3b467c68803d7c7e82678289e598afd44faa6101]

CVE-2026-90043: zram: fix slot lock bit position on big-endian 64-bit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90043

Introduced by commit 2e8ff2f ("zram: use u32 for entry ac_time
tracking") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a8b5875741d416703e19ad8eeac6fce8a12bd6e4]
stable/7.2: [052b6b2d5fe97547bd2cdb73fa894f6cfea68b11]

CVE-2026-90044: usb: gadget: f_fs: Fix Use-After-Free in AIO error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90044

Introduced by commit de2080d ("gadget/function/f_fs.c: close leaks")
in v4.0-rc4.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e78dcb1f7ec271449c54984dc90c62a5ba272de7]
stable/6.18: [153b5ecd29ed055562400bc17c91df3fd869b0ce]
stable/7.2: [4a2fb2d12b87b43724230abb52a1440617c7b6cc]

CVE-2026-90045: USB: gadget: ffs: fix mm lifetime handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90045

According to the .vulnerable file, this bug was introduced by commit
2e4c755 in v3.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5eb5c72c72fef76cb765ef1669b62b6a3ba1bfc8]
stable/6.18: [f3d31484b3f26d63c09e5569ebfaa1079a17f171]
stable/7.2: [7411de0ce3b45286de1de82526795658ea6eacb0]

CVE-2026-90046: mm/page_alloc: don't spin_trylock() in NMI on UP

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90046

Introduced by commit 8c57b68 ("mm, bpf: Introduce
free_pages_nolock()") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3105ae628fb785d48b49256468be4f21a7b3cfc0]
stable/6.18: [06c76d3c389ff504052f64b1acee44651bd847fa]
stable/7.2: [68a069b407303e71db371df85036101e8ff59280]

CVE-2026-90047: drm/xe: Don't hand out the flat CCS storage as usable VRAM

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90047

Introduced by commit 3717339 ("drm/xe/vram: fix ccs offset
calculation") in v6.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [818bebeb63dd6bf5f4e07e145f6cdbace520a34c]
stable/6.18: [c96477e0cabf55bfbdf078078e9de1c8024f8060]
stable/7.2: [348c3db4f1520d36764ac8cae2492f50599714f6]

CVE-2026-90048: fs/ntfs3: fix slab-out-of-bounds write in ni_create_attr_list()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90048

Introduced by commit 4342306 ("fs/ntfs3: Add file operations and
implementation") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7c4841e2a62794a3bab7c1ff0540580f387e377f]
stable/6.12: [fa2215cf451414b0512cd6f7d37a057893811f4d]
stable/6.18: [d07e281f2a7710502985d6f80b95ddac8f4e81d5]
stable/6.6: [7e9aee7e4d9767cc3e423b3beecb01c7ebb6bbcd]
stable/7.2: [a84f3db72561c4d9281c5ff721ce46b9ffa7f30e]

CVE-2026-90049: net: skbuff: don't skb_tx_error() the source skb in
skb_zerocopy()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90049

Introduced by commit 36d5fe6 ("core, nfqueue, openvswitch: Orphan
frags in skb_zerocopy and handle errors") in v3.14.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ece906150128d5ec2462aabcc978c568433eca4]
stable/5.10: [849bdb83123760a865bcb2970127f4c0b9423ba3]
stable/5.15: [fb10e0e9b220a2eed08931a60dbaad9a2370c908]
stable/6.1: [767ec2a65cc022d303b0c9c12811e7db22057341]
stable/6.12: [04dd250a78e268af3e7124beb1dc10ec1dd88d60]
stable/6.18: [a13b1e80e5015cd732440b475c0ef443dc4a2157]
stable/6.6: [8069643ae64dfdf634b6c78c7f622e5323031436]
stable/7.2: [bab5a851e44a3601d31f2aa8043f385bb50ac5d9]



* Updated CVEs

CVE-2022-48650: scsi: qla2xxx: Fix memory leak in __qlt_24xx_handle_abts()

stable/5.10 was fixed.

Fixed status
stable/5.10: [29a22a3d495c147117137719d2c39045c44ccebf]

CVE-2023-52676: bpf: Guard stack limits against 32bit overflow

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [ad1754f86a87fe74912fb542b23ff24ada4e3307]
stable/5.15: [4ba97610399e83d29d1086a0827d33172539b49b]
stable/6.1: [e160b2ed94a20fa940369ebd914277f88005e70d]

CVE-2023-54237: net/smc: fix potential panic dues to unprotected
smc_llc_srv_add_link()

stable/5.10 was fixed.

Fixed status
stable/5.10: [fe35c24b730d38b421da93ac5d493cb4495e8e54]

CVE-2024-35887: ax25: fix use-after-free bugs caused by ax25_ds_del_timer

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [28f2d36ac52225a13e020c2589833f1816a0cfc6]
stable/6.1: [8a912ef5b7c5d14fb41b9a7935d1df5bb87058bf]

CVE-2024-41062: bluetooth/l2cap: sync sock recv cb and release

stable/5.10 was fixed.

Fixed status
stable/5.10: [2243127db6ba20cbef90c6349a2b1000af401d2e]

CVE-2024-50017: x86/mm/ident_map: Use gbpages only where full GB page
should be mapped.

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [cb2555fb0223edac9e7820f16de17ae04a39ad39]
stable/6.1: [fe9bab1d6441ed49dc3dd0acce4c2215e8d85447]

CVE-2024-50029: Bluetooth: hci_conn: Fix UAF in hci_enhanced_setup_sync

stable/6.1 was fixed.

Fixed status
stable/6.1: [9b666a0490379c860eab380dec19a864c0bc256b]

CVE-2024-52560: fs/ntfs3: Mark inode as bad as soon as error detected
in mi_enum_attr()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [acfb75eeb3304d08cbd5b5a8c77379459ec6a04e]
stable/6.6: [4ff4b6b9e85cfe879773ca78d91b1090a3ce19ac]

CVE-2024-56639: net: hsr: must allocate more bytes for RedBox support

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [e6773b7da5ecb11ef8e95b50145fd963e326e0f1]
stable/6.6: [a77a45fbadd9c053e8cf3a9ce2e23bcd23819ea6]

CVE-2024-58097: wifi: ath11k: fix RCU stall while reaping monitor
destination ring

stable/6.1 was fixed.

Fixed status
stable/6.1: [cdb32923699932502b0573f818643aae72ce0cd5]

CVE-2025-21649: net: hns3: fix kernel crash when 1588 is sent on HIP08 devices

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [4cfa9624d6bf2d68c3831e22b49ccffe3f0b556a]
stable/6.1: [7b1b15058b177b0457ebf34b6664763cf2bbf712]
stable/6.6: [9d213ca0cb49e2d829f8338baf776f32cc8d9efa]

CVE-2025-21651: net: hns3: don't auto enable misc vector

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [800a6dfcf570c4a7e168a6fe515904de56e97148]
stable/5.15: [ee2861fce5f66c6901a014f68598e94666b23455]
stable/6.1: [41b84c5a603ffe987ec094e163d7da73aaf1841d]
stable/6.6: [7f1fe43907a6339a41364f4f7915fbf3ab2775a8]

CVE-2025-22039: ksmbd: fix overflow in dacloffset bounds check

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [abbb4ec41867f2cd1c971258e493893bf43bcbd3]
stable/6.1: [8483d7b532be1d1bc149556a2fedf903868c6303]
stable/6.6: [73f074fb5e139cd42ad75089abe4e28a49a30003]

CVE-2025-22101: net: libwx: fix Tx L4 checksum

stable/6.6 was fixed.

Fixed status
stable/6.6: [9c6c85ae77efbe29420883082b3a7b9fd2c57602]

CVE-2025-22103: net: fix NULL pointer dereference in l3mdev_l3_rcv

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [1da52878f7fb74ace304f74325bb89e3e5546b55]
stable/5.15: [d97d6b1bd2b7f2a188d261d44c4519a13b8c406a]
stable/6.1: [8da4d7f9141e8dbd3ece2f0e6930a0ea8812c862]

CVE-2025-22124: md/md-bitmap: fix wrong bitmap_limit for clustermd when write sb

stable/6.6 was fixed.

Fixed status
stable/6.6: [5eaf57fdfa37c869e61e9908e03edd707f9145b8]

CVE-2025-23129: wifi: ath11k: Clear affinity hint before calling
ath11k_pcic_free_irq() in error path

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [8d0519f511d93d675f61d6bfb45ffcc945af4b14]
stable/6.6: [7493b9baf0e54b44caae46715aaa409a84bd9f4b]

CVE-2025-37802: ksmbd: fix WARNING "do not call blocking ops when !TASK_RUNNING"

stable/6.6 was fixed.

Fixed status
stable/6.6: [97aabdbf7ba82da20e698f0e62917fb206d42941]

CVE-2025-37833: net/niu: Niu requires MSIX ENTRY_DATA fields touch
before entry reads

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [52a266008a9450e4222994666b4510c026fbb03c]
stable/6.6: [0afd48b173bebd6d94769ba2c91bd7404b9eb3c9]

CVE-2025-38097: espintcp: remove encap socket caching to avoid reference leak

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [e32bafd08ee35feacd47b05cc5bfe9cd9659cd25]
stable/5.15: [9673ca00e6c5503069dc98780e2e89db0e663c16]

CVE-2025-38266: pinctrl: mediatek: eint: Fix invalid pointer
dereference for v1 platforms

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [eae2b12df3aac874566f7025799ca4219572e44c]
stable/6.12: [abe8ad6a1a00c5c7be28b038d0ede0bdcacd8610]
stable/6.6: [e578bbff985822573a27d4b7c9ec858e6014d033]

CVE-2025-38591: bpf: Reject narrower access to pointer ctx fields

stable/6.6 was fixed.

Fixed status
stable/6.6: [e2e9599f3503df7cf3569d2b6c50d5488fb59435]

CVE-2025-38660: [ceph] parse_longname(): strrchr() expects NUL-terminated string

stable/6.6 was fixed.

Fixed status
stable/6.6: [4b9aee707c4580511983a0998547f3b28514e6a6]

CVE-2025-39991: wifi: ath11k: fix NULL dereference in ath11k_qmi_m3_load()

stable/6.6 was fixed.

Fixed status
stable/6.6: [7554d498e4283c3b4559795abd175eb24a84f47f]

CVE-2025-40074: ipv4: start using dst_dev_rcu()

stable/6.6 was fixed.

Fixed status
stable/6.6: [e150f273cd8ed34ebc6d03758aad95c12fc58337]

CVE-2025-40123: bpf: Enforce expected_attach_type for tailcall compatibility

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [e53a59e7cee5c1605d1ed595933098c2b69108f9]
stable/5.15: [dc4f348952173beb8ceb15be30b249276eccb605]

CVE-2025-40295: fscrypt: fix left shift underflow when
inode->i_blkbits > PAGE_SHIFT

stable/6.12 was fixed.

Fixed status
stable/6.12: [3493f4de79f6f54c622d0be4273637f0cf7e28a6]

CVE-2025-71142: cpuset: fix warning when disabling remote partition

stable/6.12 was fixed.

Fixed status
stable/6.12: [71953da7c979983917a4597bcad2c1ea6b8cc226]

CVE-2026-23137: of: unittest: Fix memory leak in unittest_data_add()

stable/6.12 was fixed.

Fixed status
stable/6.12: [58baf98d1bdab897fd796f39a16061bade229d71]

CVE-2026-23191: ALSA: aloop: Fix racy access at PCM trigger

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [f57467114f40c5aacebbea96fb4ff9e5cd2b7f18]
stable/5.15: [c99be0d5af02adebe9cb6f9869d20397fa9935a3]
stable/6.1: [f3ce8be893726899e3053cf8059ecc95d8410359]
stable/6.6: [0e6245b2424d126ac90018142d09f0707e12998b]

CVE-2026-23201: ceph: fix oops due to invalid pointer for kfree() in
parse_longname()

stable/6.6 was fixed.

Fixed status
stable/6.6: [c9a129c82ddf82a50b4f8960d2609714ca2dbd26]

CVE-2026-23447: net: usb: cdc_ncm: add ndpoffset to NDP32 nframes bounds check

stable/6.1 was fixed.

Fixed status
stable/6.1: [baf246d6680befde2086b1df9eb3aaba3fb6853f]

CVE-2026-23448: net: usb: cdc_ncm: add ndpoffset to NDP16 nframes bounds check

stable/6.1 was fixed.

Fixed status
stable/6.1: [63c35b8fce77a7892e8fa06c540d4943145506eb]

CVE-2026-31420: bridge: mrp: reject zero test interval to avoid OOM panic

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [610073ffb77ffd2b5eca182d2ac264de4834a175]
stable/5.15: [ec8850be9b2b3beac1c7967d95f169dd2785979d]
stable/6.1: [1ec86b4b9e28170a2565cf36f0e6e2b96b55134d]
stable/6.6: [2120bd8546cd6a63c558d135773aa8f41c8259fc]

CVE-2026-43088: net: af_key: zero aligned sockaddr tail in PF_KEY exports

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [6df5f90175fe4c584e9960b6c00131a7bf2b5399]
stable/5.15: [746ee79d9e140f0e9e56f5123eaa88ad9332de7b]
stable/6.1: [e357c3cf8a44d4ec1f49ad6981e4ab9704354347]

CVE-2026-43122: [REJECTED]: ACPI: processor: Update cpuidle driver
check in __acpi_processor_start()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [e494c5fce5697a67548c15ffb8165eaf3aea41a3]
stable/6.6: [0f0a317dd9e66f6935c35898ca4b6b7213e969ac]

CVE-2026-43198: tcp: fix potential race in tcp_v6_syn_recv_sock()

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [aef4a9ae95d1bc4f7897065011e6261026719aeb]
stable/5.15: [dad1fe7db6c6519138430ac8f5e589c18f83bfc9]
stable/6.1: [a7e761ba55efaa9c49e0afdd304bb78167af3429]
stable/6.12: [9ed654e340f4c73bc6f0af2fbc90ac293e645ce0]
stable/6.6: [cd644e6dc72eec8d9d988717ea1c54f8668ded69]

CVE-2026-43288: ext4: move ext4_percpu_param_init() before ext4_mb_init()

stable/6.1 was fixed.

Fixed status
stable/6.1: [0b3d80c56957862ba477ca0ce30c12cad9179c2b]

CVE-2026-43344: perf/x86/intel/uncore: Fix die ID init and look up bugs

stable/6.6 was fixed.

Fixed status
stable/6.6: [184870af0e73f8ea2577c751fa098681465249f2]

CVE-2026-45897: netfilter: nft_counter: serialize reset with spinlock

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [e13194e60217db02c2e7202375d9e5951267d87b]
stable/6.6: [de6601f1374fab124cd9276df6671f64d940ceb4]

CVE-2026-46090: ALSA: aloop: Fix peer runtime UAF during format-change stop

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [3727a3541788412c393eec236ad228d72efe19c7]
stable/6.6: [d258cdce50ff3e02392917258e81a0ce9555c327]

CVE-2026-46158: mptcp: pm: ADD_ADDR rtx: always decrease sk refcount

stable/5.10 was fixed.

Fixed status
stable/5.10: [f5555a6d7c472849fdf2b426e3d0a85103118793]

CVE-2026-46170: mptcp: pm: ADD_ADDR rtx: free sk if last

stable/5.10 was fixed.

Fixed status
stable/5.10: [aa8cabde7e83bf96269ee47427dc9b59e3ed8e60]

CVE-2026-46305: staging: rtl8723bs: os_dep: avoid NULL pointer
dereference in rtw_cbuf_alloc

stable/6.18 was fixed.

Fixed status
stable/6.18: [7d4024037ee309a8f0cb86b4093d59da0e135db8]

CVE-2026-52944: ksmbd: fix FSCTL permission bypass by adding a
permission check for FSCTL_SET_SPARSE

stable/5.15, stable/6.1, stable/6.12 were fixed.

Fixed status
stable/5.15: [ef664475c1bf1a27d45dae6848ca9c9c4d86853f]
stable/6.1: [3a9a0a1c38ef90788f5d7c4b29903c8b220f744a]
stable/6.12: [c5ab11263e3c89aa7989afc5374ef7743e092fd0]

CVE-2026-52961: ceph: fix BUG_ON in __ceph_build_xattrs_blob() due to
stale blob size

stable/6.6 was fixed.

Fixed status
stable/6.6: [d161c4456672f8c431e3bdf9bea817b490d14181]

CVE-2026-53010: ksmbd: fix use-after-free in smb2_open during durable reconnect

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [4db3dcac84c2f14a45ae201efb38de1fb1bfc009]
stable/6.6: [f0ff7f12398e85b3a11745ff7feab6246f3d75c2]

CVE-2026-53078: bpf: Fix same-register dst/src OOB read and pointer
leak in sock_ops

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [db1200ec2c3ddf119d4d9ba67982063df06bbacb]
stable/5.15: [4c1c5efd9d1d74743d41ce4e1600501b4feb6827]
stable/6.1: [0e6b30657bbc771f38025c828d722b6162428508]
stable/6.6: [64eaf4ecda007140ddcdb28e00c48c9c69aaba39]

CVE-2026-53098: wifi: mt76: mt7915: fix use-after-free bugs in
mt7915_mac_dump_work()

stable/6.1 was fixed.

Fixed status
stable/6.1: [55159f1fa30bef03e01af469823c1de103a4a884]

CVE-2026-53178: staging: rtl8723bs: rtw_mlme: add bounds checks before
ie_length subtraction

stable/6.18 was fixed.

Fixed status
stable/6.18: [637e0ea73f690028796ee2fc72a2ac4ec32968c6]

CVE-2026-53250: xsk: cache csum_start/csum_offset to fix TOCTOU in
xsk_skb_metadata()

stable/6.12 was fixed.

Fixed status
stable/6.12: [eb778aed8a9b2381668fcb1247ae4fa011224768]

CVE-2026-64016: ksmbd: fix durable reconnect error path file lifetime

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [478bfaa036bd0c7e179acff8b8484bccdee3b8c7]
stable/6.6: [5e641e4ee0bc1937408d41051a908ad4151be63b]

CVE-2026-64031: erofs: fix managed cache race for unaligned extents

stable/6.12 was fixed.

Fixed status
stable/6.12: [2718cdb6db0fdbe375e61f2980aada27bafb323e]

CVE-2026-64058: netfs: Fix netfs_read_folio() to wait on writeback

stable/6.12 was fixed.

Fixed status
stable/6.12: [090a8aa1894b72f5b3fc18dee68d42ad45f4a2c6]

CVE-2026-64210: net/mlx5e: xsk: Fix unlocked writing to ICOSQ

stable/6.1, stable/6.12, stable/6.18, stable/6.6 were fixed.

Fixed status
stable/6.1: [0c8f331485656d5937d56a488016b944a038fe2f]
stable/6.12: [f37adef34eb7ebe29a534d20ccadd72bd7ff664e]
stable/6.18: [54a97ef1025236cc1bc54d79c7ae2eb8027ce4b8]
stable/6.6: [f3d8c2fd591bb603b069e151881a317e26a3f478]

CVE-2026-64321: nvme: target: rdma: fix ndev refcount leak on queue connect

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [204b9645536bb4a77a2cb35e6519dbf9f4ea1665]
stable/6.1: [00eaa58988d35fd47ca8811f7f72871591f61ffb]
stable/6.6: [712f3268a62d0df98a7ee991cba963ced2e58007]

CVE-2026-72131: nvme-apple: Prevent shared tags across queues on Apple A11

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [91d3b243bffe5c94503c9a8ea478a080f79ec58e]
stable/6.12: [c6a1c94c6705e18e9718737be84d5e6e661f134c]
stable/6.6: [073b9238fac4d1c7727c1d05e3fafad0fd40d451]

CVE-2026-72255: netfilter: nf_queue: pin bridge device while NFQUEUE
holds fake dst

stable/5.10 was fixed.

Fixed status
stable/5.10: [4e56d3d60d3192ef0a0c08e8b433636690189384]

CVE-2026-74268: tcp: clear sock_ops cb flags before force-closing a child socket

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [5d5389b2c37ca00da61d1407618ebe15abae0c8b]
stable/5.15: [9f30ba9aa0270a18fdd1e6cd426c480c35f7de9d]
stable/6.1: [71e9c53220abd7f5a45aa4d5e5b420d3479f3a4f]
stable/6.12: [fe23d56e9266d58ba5c380f1970118eedeee0b68]
stable/6.6: [9fffa6465851a1910a6e9cb7272787dd615b26b1]

CVE-2026-74334: RDMA/nldev: Fix locking when accessing mr->pd

stable/6.1, stable/6.12, stable/6.18, stable/6.6 were fixed.

Fixed status
stable/6.1: [845c6b355226195dad1f26b300c4830f57034e8b]
stable/6.12: [05e26f34597e9c38bb5b340d86b179b23673869f]
stable/6.18: [a07cba1296aaa81bf9b914486ca957aaff196247]
stable/6.6: [7a0cbb5721a1da81e902d73b6049f85ca8f3fc0a]

CVE-2026-74371: bpf: fix BPF_PROG_QUERY OOB write and cgroup backward compat

stable/6.12 was fixed.

Fixed status
stable/6.12: [b78eb6efbf052d44a3a14726aa7c7d5aa2e544d7]

CVE-2026-74378: RDMA/rxe: Fix TOCTOU heap overflow in get_srq_wqe

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [c8db0e5ab0b6c540214c46c56aaac7cbcb0967fe]
stable/5.15: [e48daa94ad2d406225b73491fc935064716f0ec7]

CVE-2026-74474: vxlan: use pskb_network_may_pull() for transmit path
header pulls

stable/6.1 was fixed.

Fixed status
stable/6.1: [371425d4be7795e9158388af9eee0201e6047410]

CVE-2026-74565: netfilter: nf_tables: make nft_object rhltable per table

stable/5.10, stable/6.1 were fixed.

Fixed status
stable/5.10: [4b549d32d34ee765527e63726bb1af984876e776]
stable/6.1: [523c881661dde67efb44fce38c8eed50a72a57c1]

CVE-2026-80671: perf sched: Fix register_pid() overflow, strcpy, and BUG_ON

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [344e59fc4f2cba6dc04ce5e2a77388645d4ca834]
stable/5.15: [22263d241bad753217d545f8085b7ead52e2873b]
stable/6.1: [2003918e13f43cf6c5698be3cc9aa3657dd676a8]
stable/6.12: [261d2b5f4afa0570ca906e553c93811c5abe4590]
stable/6.6: [29639f00bfa49da7904ba0a499e0da7a0e5d735e]

CVE-2026-80689: tracing/mmiotrace: Add NULL check for mmio_trace_array
in logging functions

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [dc1b1a057b3bb901f83433700e604fe0ae67c5f2]
stable/5.15: [6aee2d478545c089dd5d055d3c9f0c7ea034fb80]
stable/6.1: [4e4ab09db7899d7f2d2293a18adf0fa200a27e73]
stable/6.6: [2df964d141270c40f07547b0c2e0a51e2573d46d]

CVE-2026-80878: afs: Fix leak of ungot volume

stable/6.12 was fixed.

Fixed status
stable/6.12: [7d10cfec6cbce7396ed5cf6abd8c34bae09c393b]

CVE-2026-80888: drm/vmwgfx: drop dma_buf reference on foreign-fd prime import

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [1715901e7052cf90fbf04c8303e563a47e021278]
stable/5.15: [c4fd91ee7228f56fbb4cf528757dc17ffefeb0ee]

CVE-2026-80912: selinux: reject an unclaimed class value in
security_get_classes()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [d2e7f7035d6f407119ba5467f7218cc4370844fc]
stable/5.15: [f38a71868888285efc9c0ab5b032e23919c5a0a1]
stable/6.1: [3480c081c23d559fd9a6921b76955664f2e95153]

CVE-2026-80914: Bluetooth: ISO: fix use-after-free of listener socket
in iso_conn_ready

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [1702f12cf59a1c3b670eb6bb4a4d6fcccf07e3b8]
stable/6.6: [d47b8f8c02a3d3f282693e5a4ff1f6b4b00518de]

CVE-2026-80935: wifi: mt76: mt7996: bound the device EEPROM address
before the EFUSE copy

stable/6.18 was fixed.

Fixed status
stable/6.18: [9e5abb5e2ade0b6fd0e47209711115d47a255176]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com


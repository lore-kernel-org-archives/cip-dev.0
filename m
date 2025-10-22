Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B0CCCD1AB
	for <webhook@archiver.kernel.org>; Wed, 22 Oct 2025 23:37:17 +0000 (UTC)
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
 by mx.groups.io with SMTP id smtpd.web11.8490.1761176232474876777
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Oct 2025 16:37:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=XfK05Py7;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.51, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63e3804362cso173722d50.2
        for <cip-dev@lists.cip-project.org>; Wed, 22 Oct 2025 16:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1761176231; x=1761781031; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vpBNBrd1k9WZ+7Z7MyFweathRUc57h2n5TIVU3sQXUM=;
        b=XfK05Py7NAdfgXARTe0HIWpie8zsqUmbAYP6BeOABTU+Hw/Iqd0qdNz9rqjdiWfFLB
         lbtlD0PHNpu7570o+vwnakl4Pf9SIb96cF05E/bh+Siy499RLpuMZ1Wad8gQRKQyMIot
         L4rNdxA5mvlJkBQMKwffp2GMtBhmwy8u8QDQqgKj7tQ/1IVQBL0Nyw3Dmfvt+zGieyxR
         MuZ1E2tT/SeRN7XilPolQ9dgYF1GpWm2/mA1apypqS8fU84lFSO6E6zYopKBnSen/tFO
         OFuuaShL0/r3bj0rMUqvAg1y6Wu6N/xxea43ixc6pRrYIr6d93akxqKQEEf58HM+qzkW
         3+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761176231; x=1761781031;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vpBNBrd1k9WZ+7Z7MyFweathRUc57h2n5TIVU3sQXUM=;
        b=NHoCfkwWiWSfRsOVUsCpjRYuKmWI5JGKsuDLKVxK48GybvOxlf6d89RZwuOANJUP2a
         mWt1k6po4mV5T0u7TzDPDCXzmPZbnnqbkVADUQpvu1YNlYUsC/qFaNqBOfb1H0LKgNDv
         UCjhJmxL9MQIrq4CyGTvxdrziNZeTxK7oiCpGoaH8K1ttTPBZwbkvjE9mjVmR5ZUl/VK
         bFQCinZHyNdU8zdHKDuUdeIqFC8IL5sM6WtF79zX9eCIjfnnoXJfUEdwYd4CQjlx95dN
         FLr3zsVVzZogreldcFBXWSwwnQA1lt/pahNvCGTQzctQERuoylkFne9gQqm0o7qDcbah
         5WtQ==
X-Gm-Message-State: AOJu0YzuL3E/cMJ5B7IbHhlIOMaDAkEzmR0bXCdWuIi9Jc/ySGYanh6y
	IhIZ4559sAbn+hEDfOUrxwobowwwR1qp8GWrlYEQf3+RBN7de1dTFiqB5XaPld+x9fe5GlxDbdd
	bLiX/HwUUs1w0hNQn11TQYMFJqsYZy02oOtc5AwLnzcNlYwbUbomz9+E=
X-Gm-Gg: ASbGncsjCtGWcjk/U0epcKANwxq++wdupeOSFLIfyl3MtxoDK6aS3Ntf2q+v6sOqApF
	5O0GW6leo9hrLREsXQyo7atRV6dQ/FzX3Q4rixra11dIvMOHUAimHGEfltfinrINmT3Iza8LTOa
	F5tJsKpO2gz6sm+fWH5JXV0J2OYyDz6lDxWzs8iXnVkBS66Bmz1R9IBPgJW8qHQ9+UOr4oIPQ6D
	lnXqfxJz6qimqPD2fdo1BJKlw3+glrFQACMLc07CTySlDX0mTQ00PBMarQOCDb9LIXqTvaT
X-Google-Smtp-Source: AGHT+IEoSw0KV79YjIHlwIigFbVpoHc/Jn6AlUwMXGohAjZm45Z4e7ZL6QQuw7AoJLKoyfT9JiZG7qf5YaMvH48xGqU=
X-Received: by 2002:a05:690c:6f09:b0:717:ca51:d781 with SMTP id
 00721157ae682-7836d1c4bdcmr364026097b3.17.1761176230508; Wed, 22 Oct 2025
 16:37:10 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 23 Oct 2025 08:36:34 +0900
X-Gm-Features: AWmQ_bn86FOtronvGIPATuA5-qzaY2nvWupgS6IjXoFXHSfSDg76XCjxJzV0hA8
Message-ID: <CAODzB9paHx3+AZLO_AVWKusnpZT2qAGr7stjbp6Q5KbC8+i9aw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Oct 2025 23:37:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20214

Hi!

It's this week's CVE report.

This week reported 83 new CVEs and 9 updated CVEs.

* New CVEs
CVE-2025-40001: scsi: mvsas: Fix use-after-free bugs in mvs_work_queue

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40001

Introduced by commit 20b09c2 ("[SCSI] mvsas: add support for 94xx;
layout change; bug fixes") in v2.6.31-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [60cd16a3b7439ccb699d0bf533799eeb894fd217]
stable/5.15: [6ba7e73cafd155a5d3abf560d315f0bab2b9d89f]
stable/6.1: [c2c35cb2a31844f84f21ab364b38b4309d756d42]
stable/6.12: [00d3af40b158ebf7c7db2b3bbb1598a54bf28127]
stable/6.6: [3c90f583d679c81a5a607a6ae0051251b6dee35b]

CVE-2025-40002: thunderbolt: Fix use-after-free in tb_dp_dprx_work

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40002

Introduced by commit d6d458d ("thunderbolt: Handle DisplayPort tunnel
activation asynchronously") in v6.14-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [67600ccfc4f38ebd331b9332ac94717bfbc87ea7]

CVE-2025-40003: net: mscc: ocelot: Fix use-after-free caused by cyclic
delayed work

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40003

Introduced by commit a556c76 ("net: mscc: Add initial Ocelot switch
support") in v4.18-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc9ea787079671cb19a8b25ff9f02be5ef6bfcf5]
stable/6.12: [70acdd1eb35ffb3afdcb59e4c3bbb178da411d0f]

CVE-2025-40004: net/9p: Fix buffer overflow in USB transport layer

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40004

Introduced by commit a3be076 ("net/9p/usbg: Add new usb gadget
function transport") in v6.12-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c04db81cd0288dfc68b7a0f7d09bd49b40bba451]
stable/6.12: [0da18d49f874d444ad83c8a546fa33bfcf2f582c]

CVE-2025-40005: spi: cadence-quadspi: Implement refcount to handle
unbind during busy

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40005

Introduced commit is not determined.Fixed in v6.17-rc5.
Vulnerable driver was added by 1406234 ("mtd: spi-nor: Add driver for
Cadence Quad SPI Flash Controller") in 4.8-rc1.

Fixed status
mainline: [7446284023e8ef694fb392348185349c773eefb3]

CVE-2025-40006: mm/hugetlb: fix folio is still mapped when deleted

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40006

Introduced by commit 4aae8d1 ("mm/hugetlbfs: unmap pages if page fault
raced with hole punch") in v4.5-rc1.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [7f3cf1a5f0ab5fcd1492ca6df38347af998620a8]
mainline: [7b7387650dcf2881fd8bb55bcf3c8bd6c9542dd7]
stable/5.10: [91f548e920fbf8be3f285bfa3fa045ae017e836d]
stable/5.15: [3e851448078f5b01f6264915df3cfef75e323a12]
stable/5.4: [bc1c9ce8aeff45318332035dbef9713fb9e982d7]
stable/6.1: [c1dc0524ab2cc3982d4e0d2bfac71a0cd4d65c39]
stable/6.12: [910d7749346c4b0acdc6e4adfdc4a9984281a206]
stable/6.6: [c9c2a51f91aea70e89b496cac360cd795a2b3c26]

CVE-2025-40007: netfs: fix reference leak

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40007

Introduced by commit 20d72b0 ("netfs: Fix the request's work item to
not require a ref") in v6.16-rc1.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d428dca252c858bfac691c31fa95d26cd008706]

CVE-2025-40008: kmsan: fix out-of-bounds access to shadow memory

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40008

Introduced by commit 2ef3cec ("kmsan: do not wipe out origin when
doing partial unpoisoning") in v6.10-rc3.
Fixed in v6.17.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [85e1ff61060a765d91ee62dc5606d4d547d9d105]
stable/6.1: [e6684ed39edc35401a3341f85b1ab50a6f89a45d]
stable/6.12: [f84e48707051812289b6c2684d4df2daa9d3bfbc]
stable/6.6: [df1fa034c0fc229a63d01ffb20bb919b839cb576]

CVE-2025-40009: fs/proc/task_mmu: check p->vec_buf for NULL

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40009

Introduced by commit 52526ca ("fs/proc/task_mmu: implement IOCTL to
get and optionally clear info about PTEs") in v6.7-rc1.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [28aa29986dde79e8466bc87569141291053833f5]
stable/6.12: [ca988dcdc6683ecd9de5f525ce469588a9141c21]

CVE-2025-40010: afs: Fix potential null pointer dereference in afs_put_server

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40010

Introduced by commit 2757a4d ("afs: Fix access after dec in put
functions") in v6.0-rc1.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9158c6bb245113d4966df9b2ba602197a379412e]
stable/6.1: [7b8381f3c405b864a814d747e526e078c3ef4bc2]
stable/6.12: [a13dbc5e20c7284b82afe6f08debdecf51d2ca04]
stable/6.6: [cab278cead49a547ac84c3e185f446f381303eae]

CVE-2025-40011: drm/gma500: Fix null dereference in hdmi teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40011

Introduced by commit 1b082cc ("gma500: Add Oaktrail support") in v3.3-rc1.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [92a8b94f3b1b94652e41ad2bd610ec8a09cd58c9]
mainline: [352e66900cde63f3dadb142364d3c35170bbaaff]
stable/5.10: [4bbfd1b290857b9d14ea9d91562bde55ff2bc85e]
stable/5.15: [e15de80737d444ed743b1c60ced4a3a97913169b]
stable/5.4: [70b0c11483d3b90b2d0f416026e475e084a77e62]
stable/6.1: [02e4ff4941efb9bbb40d8d5b61efa1a4119b1ba7]
stable/6.12: [f800f7054d2cf28b51296c7c575da27c29e3859b]
stable/6.6: [6ffa6b5bc861a3ea9dfcdc007f002b4a347c24ba]

CVE-2025-40012: net/smc: fix warning in smc_rx_splice() when calling get_page()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40012

Introduced by commit f7a2207 ("net/smc: implement DMB-related
operations of loopback-ism") in v6.10-rc1.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a35c04de2565db191726b5741e6b66a35002c652]
stable/6.12: [14fc4fdae42e34d7ee871b292ac2ecc61c2c5de7]

CVE-2025-40013: ASoC: qcom: audioreach: fix potential null pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40013

Introduced by commit 36ad9bf ("ASoC: qdsp6: audioreach: add topology
support") in v5.16-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8318e04ab2526b155773313b66a1542476ce1106]
stable/6.1: [9c1ad4192f3d2fc85339718a6252cb3337848f7b]
stable/6.12: [4dda55d04caac3b4102c26e29b1c27fa35636be3]
stable/6.6: [70e1e5fe9f7e05ff831b56ebc02543e7811b8e18]

CVE-2025-40015: media: stm32-csi: Fix dereference before NULL check

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40015

Introduced by commit e7bad98 ("media: v4l: Convert the users of
v4l2_get_link_freq to call it on a pad") in v6.15-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [80eaf32672871bd2623ce6ba13ffc1f018756580]

CVE-2025-40016: media: uvcvideo: Mark invalid entities with id
UVC_INVALID_ENTITY_ID

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40016

Introduced by commit a3fbc2e ("media: mc-entity.c: use WARN_ON,
validate link pads") in v5.7-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0e2ee70291e64a30fe36960c85294726d34a103e]
stable/6.12: [000b2a6bed7f30e0aadfb19bce9af6458d879304]
stable/6.6: [f617d515d66c05e9aebc787a8fe48b7163fc7b70]

CVE-2025-40017: media: iris: Fix memory leak by freeing untracked persist buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40017

Introduced by commit 73702f4 ("media: iris: allocate, initialize and
queue internal buffers") in v6.15-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [02a24f13b3a1d9da9f3de56aa5fdb7cc1fe167a2]

CVE-2022-50556: drm: Fix potential null-ptr-deref due to drmm_mode_config_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50556

Introduced by commit 6b4959f ("drm/atomic: atomic plane properties")
in v4.0-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [834c23e4f798dcdc8af251b3c428ceef94741991]
stable/5.10: [5ae70041a6d7de62a0cdb2bbcfe0c9cf753035d0]
stable/5.15: [d06e827a65a6bcd2e329045d891d0739cec1cf4a]
stable/6.1: [b14147464251f66e38fa39f0aae9780466db8610]

CVE-2022-50557: pinctrl: thunderbay: fix possible memory leak in
thunderbay_build_functions()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50557

Introduced by commit 12422af ("pinctrl: Add Intel Thunder Bay pinctrl
driver") in v5.17-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83e1bcaf8cef26edaaf2a6098ef760f563683483]
stable/6.1: [aae4846e8e49044cb51d0276bec2a3fc2d5cd8da]

CVE-2022-50558: regmap-irq: Use the new num_config_regs property in
regmap_add_irq_chip_fwnode

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50558

Introduced by commit faa87ce ("regmap-irq: Introduce config registers
for irq types") in v6.0-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [84498d1fb35de6ab71bdfdb6270a464fb4a0951b]
stable/6.1: [961db32e52f4d34a9a95939a30393fd190397f84]

CVE-2022-50559: clk: imx: scu: fix memleak on platform_device_add() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50559

Introduced by commit 77d8f30 ("clk: imx: scu: add two cells binding
support") in v5.11-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [855ae87a2073ebf1b395e020de54fdf9ce7d166f]
stable/5.15: [9209e6bab75d4008d9f4248c66008f3ffd24c931]

CVE-2022-50560: drm/meson: explicitly remove aggregate driver at
module unload time

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50560

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected file was added by bbbe775 ("drm: Add support for Amlogic
Meson Graphic Controller") in 4.10-rc1.

Fixed status
mainline: [8616f2a0589a80e08434212324250eb22f6a66ce]
stable/5.10: [8a427a22839daacd36531a62c83d5c9cd6f20657]
stable/5.15: [587c7da877219e6185217bf64418e62e114dab1e]

CVE-2022-50561: iio: fix memory leak in iio_device_register_eventset()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50561

Introduced by commit 32f1717 ("iio: core: rework iio device group
creation") in v5.13-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [86fdd15e10e404e70ecb2a3bff24d70356d42b36]
stable/5.15: [dc6afd6070f3a5b086c8c5cfa6ded63ae44494da]
stable/6.1: [a154b1c139fbf6a49762159be81d425d41ceec87]

CVE-2022-50562: tpm: acpi: Call acpi_put_table() to fix memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50562

Introduced by commit 0bfb237 ("tpm: Move eventlog files to a
subdirectory") in v4.18-rc1.
Introduced by commit 85467f6 ("tpm: Add support for event log pointer
found in TPM2 ACPI table") in v5.9-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8740a12ca2e2959531ad253bac99ada338b33d80]
stable/5.10: [8ddc48068ac85740d3d5f9f3b0b323e733a35b33]
stable/5.15: [638cd298dfebce46919cbd6cf1884701215f506d]
stable/6.1: [bf31e3f8077af539feaf4e9bbf82e8eb51e7e5a8]

CVE-2022-50563: dm thin: Fix UAF in run_timer_softirq()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50563

Introduced by commit 991d9fa ("dm: add thin provisioning target") in v3.2-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e8b8e0d2bbf7d1172c4f435621418e29ee408d46]
cip/4.4-st: [8578f071289f23b1db6ee0303d94c2ff78160779]
mainline: [88430ebcbc0ec637b710b947738839848c20feff]
stable/5.10: [34fe9c2251f19786a6689149a6212c6c0de1d63b]
stable/5.15: [34cd15d83b7206188d440b29b68084fcafde9395]
stable/5.4: [7ae6aa649394e1e7f6dafb55ce0d578c0572a280]
stable/6.1: [d9971fa4d8bde63d49c743c1b32d12fbbd3a30bd]

CVE-2022-50564: s390/netiucv: Fix return type of netiucv_tx()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50564

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [85d392710275355425df8618ccbebbc336f5acc5]
cip/4.4-st: [40d18ec712a7f50653435fda0b4de811dd77de78]
mainline: [88d86d18d7cf7e9137c95f9d212bb9fff8a1b4be]
stable/5.10: [3ac0217ca9186c2f9af9a0113a331a42aa847894]
stable/5.15: [dfbf0122ea1b9b3e73fa22c8ff6bd888935c54fc]
stable/5.4: [4bee3c75d5bf7c2b5dc0b520410eb40449e5da31]
stable/6.1: [d034fa43af92fc46a81d882f46d9cc3e4ffdbbcc]

CVE-2022-50565: wifi: plfxlc: fix potential memory leak in
__lf_x_usb_enable_rx()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50565

Introduced by commit 68d57a0 ("wireless: add plfxlc driver for
pureLiFi X, XL, XC devices") in v5.19-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [895b3b06efc285c1245242e9638b9ae251dc13ec]
stable/6.1: [fce7e46273649d9cdcd98d89551975a65f206a14]

CVE-2022-50566: mtd: Fix device name leak when register device failed
in add_mtd_device()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50566

Introduced by commit 1f24b5a ("[MTD] driver model updates") in v2.6.30-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [db07fe76df01f40cb897d6e9066b84e46957beb3]
cip/4.4-st: [dea72728b745037a38631b7a741f79a90ccad943]
mainline: [895d68a39481a75c680aa421546931fb11942fa6]
stable/5.10: [330bc5533e8a8ed69cb951d5a8edce9bddb9db21]
stable/5.15: [71212d73184845c944ef1b43f092e643e5bde003]
stable/5.4: [fa0d32ab8407d7481450c664fd0de64f2dae9489]
stable/6.1: [bcabe1dc2a344adbb3382930a23e273ba9382277]

CVE-2022-50567: fs: jfs: fix shift-out-of-bounds in dbAllocAG

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50567

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [eea87acb6027be3dd4d3c57186bb22800d57fdda]
cip/4.4-st: [b2bc05a29c71e2668e999c7d428870760635676a]
mainline: [898f706695682b9954f280d95e49fa86ffa55d08]
stable/5.10: [3e997e4ce8ae7ab89d72334120f6aee49c5bbdbd]
stable/5.15: [0536f76a2bca83d1a3740517ba22cc93a44b3099]
stable/5.4: [359616ce587e524107730504891afa4b1a8be58c]
stable/6.1: [67973caae78e21ee46a7281aaa8ca364eb9c444f]

CVE-2022-50568: usb: gadget: f_hid: fix f_hidg lifetime vs cdev

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50568

Introduced by commit 71adf11 ("USB: gadget: add HID gadget driver") in
v2.6.35-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [1cd7f156f6389918f760687fbbf133c86da93162]
mainline: [89ff3dfac604614287ad5aad9370c3f984ea3f4b]
stable/5.10: [1b6a53e447ec3d81623610c8c7ec5082b47dfdce]
stable/5.15: [d3136b79705c2e3bba9c76adc5628af0215d798e]
stable/5.4: [c78c87c4e389b62f8892af7f59857447aa6d9797]
stable/6.1: [9e08b7f5fa00e9d550851352bd0d1ba74ccffef2]

CVE-2022-50569: xfrm: Update ipcomp_scratches with NULL when freed

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50569

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
cip/4.19-st: [1e8abde895b3ac6a368cbdb372e8800c49e73a28]
cip/4.4-st: [183c60e319f5c4eed8399ea40e9d4656307cf782]
mainline: [8a04d2fc700f717104bfb95b0f6694e448a4537f]
stable/5.10: [be81c44242b20fc3bdcc73480ef8aaee56f5d0b6]
stable/5.15: [03155680191ef0f004b1d6a5714c5b8cd271ab61]
stable/5.4: [18373ed500f7cd53e24d9b0bd0f1c09d78dba87e]

CVE-2022-50570: platform/chrome: fix memory corruption in ioctl

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50570

Introduced by commit eda2e30 ("mfd / platform: cros_ec: Miscellaneous
character device to talk with the EC") in v5.4-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a07b45fd3c2dda24fad43639be5335a4595196a]
stable/5.10: [868fc93b615b9f6c2b0b1894536618fa6cd66acc]
stable/5.15: [fd1d3b265784a2243fcaef06aebfb2f8ee733cec]
stable/5.4: [e548f9503c4b3292a60a63fe77dccea62999a35a]

CVE-2022-50571: btrfs: call __btrfs_remove_free_space_cache_locked on
cache load failure

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50571

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
mainline: [8a1ae2781dee9fc21ca82db682d37bea4bd074ad]

CVE-2022-50572: ASoC: audio-graph-card: fix refcount leak of cpu_ep in
__graph_for_each_link()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50572

Introduced by commit fce9b90 ("ASoC: audio-graph-card: cleanup DAI
link loop method - step2") in v5.1-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ab2d12c726f0fde0692fa5d81d8019b3dcd62d0]
stable/5.10: [06c9d468c06806dab752eb8e72addbf3792c1023]
stable/5.15: [85eb5c952b7fe2d2059beaa4a4dd26688b25547b]
stable/5.4: [ed1376f771404917c2ec3ebc617431ec01146134]
stable/6.1: [4cc8431ec77a43ea106d8bde0860c61cfdda1cd0]

CVE-2022-50573: wifi: mt76: mt7915: fix mt7915_rate_txpower_get() resource leaks

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50573

Introduced by commit e329675 ("wifi: mt76: mt7915: enable per
bandwidth power limit support") in v6.2-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b25301af01566f4b5a301fc1ad7c5d2b1788d7f]

CVE-2022-50574: drm/omap: dss: Fix refcount leak bugs

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50574

Introduced by commit 09bffa6 ("drm: omap: use common OF graph
helpers") in v4.12-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b42057e62120813ebe9274f508fa785b7cab33a]
stable/5.10: [1f340e1c1c74d11c45a6e32663829b26acd4f47b]
stable/5.15: [a5ce83e85d795ec98697039ecc518b21d5810adc]
stable/5.4: [9d7af9b1624dd70b67354972d7297429e6372091]

CVE-2022-50575: xen/privcmd: Fix a possible warning in
privcmd_ioctl_mmap_resource()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50575

Introduced by commit 3ad0876 ("xen/privcmd: add
IOCTL_PRIVCMD_MMAP_RESOURCE") in v4.18-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [5d68ae32d132ea2af73bc223fd64c46f85302a8b]
mainline: [8b997b2bb2c53b76a6db6c195930e9ab8e4b0c79]
stable/5.10: [46026bb057c35f5bb111bf95e00cd8366d2e34d4]
stable/5.15: [0bf874183b32eae2cc20e3c5be38ec3d33e7e564]
stable/5.4: [4f983ee5e5de924d93a7bbb4e6f68f38c6256cd5]
stable/6.1: [4da411086f5ab32f811a89ef804980ec106ebb65]

CVE-2022-50576: serial: pch: Fix PCI device refcount leak in pch_request_dma()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50576

Introduced by commit 3c6a483 ("Serial: EG20T: add PCH_UART driver") in
v2.6.38-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [dfd15c5550b9190d5b0f9bcacb3e6436322f3854]
cip/4.4-st: [9a64a835fd0db513ea59efa61a4092eddb84cf3d]
mainline: [8be3a7bf773700534a6e8f87f6ed2ed111254be5]
stable/5.10: [07f4ca68b0f6bf84b6b391c14b59fd179fcde9c5]
stable/5.15: [6f7d82380fbeaed3a940efc33c23f0c4bbd0fc02]
stable/5.4: [d165388227aa7e46a9751b90bae6337b5335cdbb]
stable/6.1: [516614a371c26e3334625b4bca19a5362bf658d6]

CVE-2022-50577: ima: Fix memory leak in __ima_inode_hash()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50577

Introduced by commit 280fe83 ("ima: Always return a file measurement
in ima_file_hash()") in v5.18-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8c1d6a050a0f16e0a9d32eaf53b965c77279c6f8]
stable/6.1: [f375bcf69f58fd0744c9dfd1b6b891a27301d67b]

CVE-2022-50578: class: fix possible memory leak in __class_register()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50578

Introduced by commit ced6473 ("driver core: class: add class_groups
support") in v4.10-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [3bb9c92c27624ad076419a70f2b1a30cd1f8bbbd]
cip/4.4-st: [b66a419c08f2a1ee627c2e0123a7303fcb215473]
mainline: [8c3e8a6bdb5253b97ad532570f8b5db5f7a06407]
stable/5.10: [18a7200646958cf8e1b8a933de08122fc50676cd]
stable/5.15: [417ef049e3fd3b0d2593c1d5ffa3d0d5d0a018a7]
stable/5.4: [3e0efc3f3f5e5c73996782f8db69963e501bb878]
stable/6.1: [abaedb68a769e6bf36836b55a2f49b531c5f3f7b]

CVE-2022-50579: arm64: ftrace: fix module PLTs with mcount

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50579

Introduced by commit a625357 ("arm64: ftrace: consistently handle
PLTs.") in v5.19-rc3.
Fixed in v6.1-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [8cfb08575c6d4585f1ce0deeb189e5c824776b04]
stable/5.10: [657de36c72f57fa172a66b06f826b3f5bc56f42e]
stable/5.15: [6c93b683cedaef745884cb9d554d02ed6266b897]

CVE-2022-50580: blk-throttle: prevent overflow while calculating wait time

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50580

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
mainline: [8d6bbaada2e0a65f9012ac4c2506460160e7237a]
stable/5.10: [19c010ae44f0ce52b5436080492a61a092ee0cf4]
stable/5.15: [70b2adb1d698fbc63d3b3848c452524dc15872c5]

CVE-2022-50581: hfs: fix OOB Read in __hfs_brec_find

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50581

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [2344f17c0a89c181ab1a9fef57fd8c3bddfd6e30]
cip/4.4-st: [de9aa2b8a010895c93fdfb48f4388af09d9210e3]
mainline: [8d824e69d9f3fa3121b2dda25053bae71e2460d2]
stable/5.10: [4fd3a11804c8877ff11fec59c5c53f1635331e3e]
stable/5.15: [367296925c7625c3969d2a78d7a3e1dee161beb5]
stable/5.4: [90103ccb6e60aa4efe48993d23d6a528472f2233]
stable/6.1: [bfc9d8f27f89717431a6aecce42ae230b437433f]

CVE-2022-50582: regulator: core: Prevent integer underflow

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50582

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected code was added by f7d7ad4 ("regulator: Allow regulators to
verify enabled during enable()") in 5.9-rc1.

Fixed status
mainline: [8d8e16592022c9650df8aedfe6552ed478d7135b]
stable/5.10: [b051d9bf98bd9cea312b228e264eb6542a9beb67]
stable/5.15: [e33da263e9658bfe870ea7836fbbd72f246d7dbd]

CVE-2023-53692: ext4: fix use-after-free read in ext4_find_extent for
bigalloc + inline

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53692

Introduced by commit 131294c ("ext4: fix delayed allocation bug in
ext4_clu_mapped for bigalloc + inline") in v6.2-rc1.
Fixed in v6.4-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/5.10 stable/5.15 stable/5.4 stable/6.1

Fixed status
mainline: [835659598c67907b98cd2aa57bb951dfaf675c69]
stable/5.10: [770b0613637f59f3091dda1ff0c23671a5326b9c]
stable/5.15: [40566def189c513be2c694681256d7486cc6e368]
stable/5.4: [a34f6dcb78c654ab905642c1b4e7e5fbb4f0babe]
stable/6.1: [96d440bee177669dc0acedca0abd73bae6a9be8b]

CVE-2023-53693: USB: gadget: Fix the memory leak in raw_gadget driver

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53693

Introduced commit is not determined.Fixed in v6.5-rc4.
Affected code was added by f2c2e71 ("usb: gadget: add raw-gadget
interface") in 5.7-rc1.

Fixed status
mainline: [83e30f2bf86ef7c38fbd476ed81a88522b620628]
stable/5.10: [68e6287ac61dc22513cd39f02b9ac1fef28513e4]
stable/5.15: [0f7a2b567197798da7bfa2252f4485c0ca6c6266]
stable/6.1: [de77000c1923d7942f9b4f08447c8feeae1c0f33]

CVE-2023-53694: riscv: ftrace: Fixup panic by disabling preemption

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53694

Introduced by commit afc76b8 ("riscv: Using PATCHABLE_FUNCTION_ENTRY
instead of MCOUNT") in v5.12-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8547649981e6631328cd64f583667501ae385531]
stable/6.1: [84cfcf240f4a577733b1d98fcd2611a611612b03]

CVE-2023-53695: udf: Detect system inodes linked into directory hierarchy

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53695

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
cip/4.19-st: [1dc71eeb198a8daa17d0c995998a53b0b749a158]
mainline: [85a37983ec69cc9fcd188bc37c4de15ee326355a]
stable/5.10: [a44ec34b90440ada190924f5908b97026504fdcd]
stable/5.15: [37e74003d81e79457535cbbdfa1603431c03fac0]
stable/5.4: [d747b31e2925a2f384e7dd1901a2e5bc5f984ed8]
stable/6.1: [1f328751b65c49c13a312d67a3bf27766b85baf7]

CVE-2023-53696: scsi: qla2xxx: Fix memory leak in qla2x00_probe_one()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53696

Introduced by commit a423994 ("scsi: qla2xxx: Add switch command to
simplify fabric discovery") in v4.16-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [85ade4010e13ef152ea925c74d94253db92e5428]
stable/5.15: [ae73c4dd48f2c79d515d509a0cbe9efb0a197f44]
stable/6.1: [44374911ac63f769c442f56fdfadea673c5f4425]

CVE-2023-53697: nvdimm: Fix memleak of pmu attr_groups in
unregister_nvdimm_pmu()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53697

Introduced by commit 0fab1ba ("drivers/nvdimm: Add perf interface to
expose nvdimm performance stats") in v5.18-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [85ae42c72142346645e63c33835da947dfa008b3]
stable/6.1: [500a6ff9c2a81348fe0f04e2deb758145e8ab94e]
stable/6.6: [85ae42c72142346645e63c33835da947dfa008b3]

CVE-2023-53698: xsk: fix refcount underflow in error path

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53698

Introduced by commit ba3beec ("xsk: Fix possible crash when multiple
sockets are created") in v5.18-rc5.
Fixed in v6.5-rc6.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [85c2c79a07302fe68a1ad5cc449458cc559e314d]
stable/5.15: [789fcd94c9cac133dd4d96e193188661aca9f6c3]
stable/6.1: [15b453cf7348973217558235b9ece2ee5fea6777]

CVE-2023-53699: riscv: move memblock_allow_resize() after linear
mapping is ready

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53699

Introduced by commit 671f9a3 ("RISC-V: Setup initial page tables in
two stages") in v5.3-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [85fadc0d04119c2fe4a20287767ab904c6d21ba1]
stable/5.15: [a4284246fca2ef482a8fcf5ad7d2c33a45b41e9c]
stable/6.1: [0a1b80ff4f721c4be98707bfe9d20238df133eb8]

CVE-2023-53700: media: max9286: Fix memleak in max9286_v4l2_register()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53700

Introduced by commit 66d8c9d ("media: i2c: Add MAX9286 driver") in v5.9-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8636c5fc7658c7c6299fb8b352d24ea4b9ba99e2]
stable/5.10: [505ff3a0c5951684c3a43094ca4c1a74683d5681]
stable/5.15: [5897fe3ebe8252993579e1bee715ebfe5504e052]
stable/6.1: [724039e013b34f46344abdbf8c74e6a65a828327]

CVE-2023-53702: s390/crypto: use vector instructions only if available
for ChaCha20

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53702

Introduced by commit 349d03f ("crypto: s390 - add crypto library
interface for ChaCha20") in v5.19-rc1.
Fixed in v6.4-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8703dd6b238da0ec6c276e53836f8200983d3d9b]
stable/6.1: [25e8d30507aa2f251152df1af7809e85b5538f4a]

CVE-2023-53703: HID: amd_sfh: Fix for shift-out-of-bounds

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53703

Introduced by commit 93ce5e0 ("HID: amd_sfh: Implement SFH1.1
functionality") in v6.0-rc1.
Fixed in v6.5-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87854366176403438d01f368b09de3ec2234e0f5]
stable/6.1: [5a45ed1ae34bb0e68944471f4bafb68e0a572791]

CVE-2023-53704: clk: imx: clk-imx8mp: improve error handling in
imx8mp_clocks_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53704

Introduced by commit 9c140d9 ("clk: imx: Add support for i.MX8MP clock
driver") in v5.6-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [878b02d5f3b56cb090dbe2c70c89273be144087f]
stable/5.10: [cb047c13bbf9018693ae31f03a5a26b212d02f13]
stable/5.15: [bcea444ab4c045864b55d67313833d606676602a]
stable/6.1: [6317d0302655f7e854cd4f31e93b47d35cb058bb]

CVE-2023-53705: ipv6: Fix out-of-bounds access in ipv6_find_tlv()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53705

Introduced by commit c61a404 ("[IPV6]: Find option offset by type.")
in v2.6.20.16.
Fixed in v6.4-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [04bf69e3de435d793a203aacc4b774f8f9f2baeb]
cip/4.4-st: [ca31acf449fc0ef93a64de47e2dc368964d4b90e]
mainline: [878ecb0897f4737a4c9401f3523fd49589025671]
stable/5.10: [e5f82688ae10f5f386952e65e941bb8868ee54dc]
stable/5.15: [9b92e2d0eb696d7586ba832c8854653b59887da0]
stable/5.4: [011f47c8b8389154f996f5f69da8efc3a3beefef]
stable/6.1: [91dd8aab9c9f193210681b86b6b92840ffe74f0c]

CVE-2023-53706: mm/vmemmap/devdax: fix kernel crash when probing devdax devices

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53706

Introduced by commit 4917f55 ("mm/sparse-vmemmap: improve memory
savings for compound devmaps") in v5.19-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87a7ae75d7383afa998f57656d1d14e2a730cc47]

CVE-2023-53707: drm/amdgpu: Fix integer overflow in amdgpu_cs_pass1

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53707

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
mainline: [87c2213e85bd81e4a9a4d0880c256568794ae388]
stable/6.1: [9f55d300541cb5b435984d269087810581580b00]

CVE-2023-53708: ACPI: x86: s2idle: Catch multiple ACPI_TYPE_PACKAGE objects

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53708

Introduced commit is not determined.Fixed in v6.6-rc1.


Fixed status
mainline: [883cf0d4cf288313b71146ddebdf5d647b76c78b]
stable/5.15: [7b7964cd9db30bc84808a40d13a0633b4313f149]
stable/6.1: [1ea7e47807279369c82718efd2677ea25c6579e3]
stable/6.6: [883cf0d4cf288313b71146ddebdf5d647b76c78b]

CVE-2023-53709: ring-buffer: Handle race between rb_move_tail and rb_check_pages

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53709

Introduced by commit 1039221 ("ring-buffer: Do not disable recording
when there is an iterator") in v5.7-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8843e06f67b14f71c044bf6267b2387784c7e198]
stable/5.10: [6e02a43acd0691791df79ce538f2dd497a6c9b76]
stable/5.15: [d41db100bc386b9433a3fc87026f5e8b453653e3]
stable/6.1: [9674390ac540ed06768e3fbc2dba553929fbd736]

CVE-2023-53710: wifi: mt76: mt7921: fix error code of return in mt7921_acpi_read

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53710

Introduced by commit f965333 ("mt76: mt7921: introduce ACPI SAR
support") in v6.0-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [888d89034f9eaeab9b5b75f13dbe35376c7dd471]
stable/6.1: [2a9a5f88e0da71c8e4f30aacbda45b1a1af5469d]

CVE-2023-53711: NFS: Fix a potential data corruption

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53711

Introduced by commit ed5d588 ("NFS: Try to join page groups before an
O_DIRECT retransmission") in v5.7-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [88975a55969e11f26fe3846bf4fbf8e7dc8cbbd4]
stable/5.10: [4185605cd0f72ec8bf8b423aacd94cd5ee13bbcf]
stable/5.15: [da302f1d476a44245823a74546debb5d160bf5bd]
stable/6.1: [dac14a1dbe20e003215dacb8a3a1a7e4ca4e0ad0]
stable/6.6: [88975a55969e11f26fe3846bf4fbf8e7dc8cbbd4]

CVE-2023-53712: ARM: 9317/1: kexec: Make smp stop calls asynchronous

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53712

Introduced commit is not determined.Fixed in v6.6-rc1.
Affected code was added by 2d7b3c6 ("ARM: kexec: fix kdump register
saving on panic()") in 4.17-rc6.

Fixed status
mainline: [8922ba71c969d2a0c01a94372a71477d879470de]
stable/5.15: [46870eea5496ff277e86187a49ac5a667cfe60c4]
stable/6.1: [ee378f45a70d09b51373ba495d30d99ef12219c1]

CVE-2023-53713: arm64: sme: Use STR P to clear FFR context field in
streaming SVE mode

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53713

Introduced by commit 9f58486 ("arm64/sve: Make access to FFR
optional") in v5.16-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [893b24181b4c4bf1fa2841b1ed192e5413a97cb1]
stable/6.1: [97669214944e80d3756657c21c4f286f3da6a423]

CVE-2023-53714: drm/stm: ltdc: fix late dereference check

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53714

Introduced commit is not determined.Fixed in v6.5-rc1.
Affected code was added by 79b4468 ("drm/stm: ltdc: add support for
CRC hashing feature") in 5.18-rc1.

Fixed status
mainline: [898a9e3f56db9860ab091d4bf41b6caa99aafc3d]
stable/6.1: [340dba127bbed51e8425cd8e097aacfadd175462]

CVE-2023-53715: wifi: brcmfmac: cfg80211: Pass the PMK in binary instead of hex

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53715

Introduced commit is not determined.Fixed in v6.4-rc1.
Affected code was introducedby b8a64f0 ("brcmfmac: support 4-way
handshake offloading for WPA/WPA2-PSK") in 4.13-rc1.

Fixed status
cip/4.19-st: [2bc34facb90ceeff6f8c17d2006575a6d07c3825]
mainline: [89b89e52153fda2733562776c7c9d9d3ebf8dd6d]
stable/5.10: [4e8dc0e5c7636efaadbd7e488acd34b4291c0431]
stable/5.15: [e242c66f7ecfe8f5b6eb308f4ea464fd8589c866]
stable/5.4: [56c7e9c39bd54fd753c0c4b1ed10278cbd3a5f02]
stable/6.1: [f8a6c53ff1d91acd5a20eb627edbffd816eb9a4e]

CVE-2023-53716: net: fix skb leak in __skb_tstamp_tx()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53716

Introduced by commit 50749f2 ("tcp/udp: Fix memleaks of sk and
zerocopy skbs with TX timestamp.") in v6.4-rc1.
Fixed in v6.4-rc4.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/5.10 stable/5.15 stable/5.4 stable/6.1

Fixed status
cip/4.19-st: [779332447108545ef04682ea29af5f85c0202aee]
mainline: [8a02fb71d7192ff1a9a47c9d937624966c6e09af]
stable/5.10: [a594382ec6d0cc8cff5a8bc7e61b54e3858fb243]
stable/5.15: [e06841a2abf9c82735cee39e88b1d79464088840]
stable/5.4: [58766252f6b2c0487cda6976a53d2bb03ae28e2a]
stable/6.1: [cc18b4685910d5d9de8314bae9c55790701b1811]

CVE-2023-53717: wifi: ath9k: Fix potential stack-out-of-bounds write
in ath9k_wmi_rsp_callback()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53717

Introduced by commit fb9987d ("ath9k_htc: Support for AR9271
chipset.") in v2.6.35-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [ae4933b4f17de8e2b7ff6f91b17d3b0099a6d6bc]
cip/4.4-st: [43f0245051e32c2bf359bccb167631aaeb6d44fd]
mainline: [8a2f35b9830692f7a616f2f627f943bc748af13a]
stable/5.10: [78b56b0a613a87b61290b95be497fdfe2fe58aa6]
stable/5.15: [1af7eacfad45149c54893a8a9df9e92ef89f0a90]
stable/5.4: [bf6dc175a2b53098a69db1236d9d53982f4b1bc0]
stable/6.1: [8f28513d9520184059530c01a9f928a1b3809d3f]

CVE-2023-53718: ring-buffer: Do not swap cpu_buffer during resize process

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53718

Introduced commit is not determined.Fixed in v6.5-rc3.


Fixed status
mainline: [8a96c0288d0737ad77882024974c075345c72011]
stable/5.10: [66a3b2a121386702663065d5c9e5a33c03d3f4a2]
stable/5.15: [49b830d75f03d5dd41146d10e4d3e2a8211c4b94]
stable/6.1: [128c06a34cfe55212632533a706b050d54552741]

CVE-2023-53719: serial: arc_uart: fix of_iomap leak in `arc_serial_probe`

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53719

Introduced by commit 8dbe1d5 ("serial/arc: inline the probe helper")
in v3.17-rc1.
Fixed in v6.4-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [3f00df24a5021a6f02c1830a290acd4bceb22a2d]
mainline: [8ab5fc55d7f65d58a3c3aeadf11bdf60267cd2bd]
stable/5.10: [153017561d2804cfae87cc9aa377aa84dd906ae1]
stable/5.15: [f76a18e53a66c0ef2938276110717b3805720cd9]
stable/5.4: [7525aa211758cc023a371e010d16ceaae1057807]
stable/6.1: [081790eee6b47389a0d895262086d64c6a38d6e5]

CVE-2023-53720: net/mlx5e: Release the label when replacing existing ct entry

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53720

Introduced by commit 94ceffb ("net/mlx5e: Implement CT entry update")
in v6.3-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ac04a28144cfa89b61be518268233742c23d88d]

CVE-2023-53721: wifi: ath12k: Fix a NULL pointer dereference in
ath12k_mac_op_hw_scan()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53721

Introduced commit is not determined.Fixed in v6.6-rc1.
Affected code was added by d889913 ("wifi: ath12k: driver for Qualcomm
Wi-Fi 7 devices") in 6.3-rc1.

Fixed status
mainline: [8ad314da54c6dd223a6b6cc85019160aa842f659]
stable/6.6: [8ad314da54c6dd223a6b6cc85019160aa842f659]

CVE-2023-53722: md: raid1: fix potential OOB in raid1_remove_disk()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53722

Introduced commit is not determined.Fixed in v6.6-rc1.


Fixed status
cip/4.19-st: [91fbd4e75cb573f44d2619a9dc2f9ba927040760]
cip/4.4-st: [68cf5597da964c5ba1fb854188cb25cb8cdedd24]
mainline: [8b0472b50bcf0f19a5119b00a53b63579c8e1e4d]
stable/5.10: [7993cfc041481a3a9cd4a3858088fc846b8ccaf7]
stable/5.15: [4f96c0665f9f4cf70130c9757750dc43dc679c82]
stable/5.4: [25a68f2286be56fb3a6f9fa0e269c04b5e6c6e24]
stable/6.1: [4f7d853b4590fc20e90dd50e346c02811a8c5b08]
stable/6.6: [8b0472b50bcf0f19a5119b00a53b63579c8e1e4d]

CVE-2023-53723: drm/amdgpu: disable sdma ecc irq only when sdma RAS is
enabled in suspend

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53723

Introduced commit is not determined.Fixed in v6.4-rc2.
Affected code was added by 7d0e632 ("drm/amdgpu: update more sdma
instances irq support") in 5.4-rc1.

Fixed status
mainline: [8b229ada2669b74fdae06c83fbfda5a5a99fc253]
stable/5.10: [c1420276be7a98df0074584bb9c1709cbc1a9df5]
stable/5.15: [823787470e320f90372c3ef506769520026c571f]
stable/5.4: [3decf3a750a924362bf4e2680dd3b07242fe56e8]
stable/6.1: [2a179117a3b29e7136e4045c57090a05bb97f373]

CVE-2023-53724: mfd: pcf50633-adc: Fix potential memleak in
pcf50633_adc_async_read()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53724

Introduced by commit 08c3e06 ("mfd: PCF50633 adc driver") in v2.6.29-rc2.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [41cdf082ae006ea002135dfaf43b2897de3bded8]
cip/4.4-st: [4ae03b84a70905f762b651b6063c73972c8e6546]
mainline: [8b450dcff23aa254844492831a8e2b508a9d522d]
stable/5.10: [3ee13bdf0d25ae8752ae6185b6d13bbb0d5a8e30]
stable/5.15: [6a8a02dcfae13ab07dc7bed2b409cec7f3d32e92]
stable/5.4: [588edb4fb1f1e6487a0f60a5f7b9a24d2d0c9f8e]
stable/6.1: [9cca3a4933ca365cc664d5eefb0f942374ea8b41]

CVE-2023-53725: clocksource/drivers/cadence-ttc: Fix memory leak in
ttc_timer_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53725

Introduced by commit e932900 ("arm: zynq: Use standard timer binding")
in v3.10-rc1.
Introduced by commit 70504f3 ("clocksource/drivers/cadence_ttc:
Convert init function to return error") in v4.8-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e0a9cc90ea44a50d76a84f9f9bf1703d31fe45e9]
mainline: [8b5bf64c89c7100c921bd807ba39b2eb003061ab]
stable/5.10: [ebdff0986513a29be242aace0ef89b6c105b0bf0]
stable/5.15: [289e2054eeb63c9e133960731c342eeffad218d3]
stable/5.4: [54cc10a0f4b01b522e9519014200f1b33bf7e4aa]
stable/6.1: [919dd531ebb7514f205ae7aab87994337ebce1f6]

CVE-2023-53726: arm64: csum: Fix OoB access in IP checksum code for
negative lengths

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53726

Introduced by commit 5777eae ("arm64: Implement optimised checksum
routine") in v5.6-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8bd795fedb8450ecbef18eeadbd23ed8fc7630f5]
stable/5.10: [5a85727239a23de1cc8d93985f1056308128f3e2]
stable/5.15: [9a43563cfd6b9200ff2f76b3f9fcdcb217ceb523]
stable/6.1: [ba0b46166b8e547024d02345a68b747841931ad2]
stable/6.6: [8bd795fedb8450ecbef18eeadbd23ed8fc7630f5]

CVE-2023-53727: net/sched: fq_pie: avoid stalls in fq_pie_timer()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53727

Introduced by commit ec97ecf ("net: sched: add Flow Queue PIE packet
scheduler") in v5.6-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8c21ab1bae945686c602c5bfa4e3f3352c2452c5]
stable/5.10: [94d527c3759d76c29220758362f622954612bea7]
stable/5.15: [973a4c302d7f3804098ff9824d9f56926901f293]
stable/6.1: [f39b49077abec4c9c3a4c2966532004851c51006]
stable/6.6: [8c21ab1bae945686c602c5bfa4e3f3352c2452c5]

CVE-2023-53728: posix-timers: Ensure timer ID search-loop limit is valid

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53728

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
cip/4.19-st: [9ea26a8494a0a9337e7415eafd6f3ed940327dc5]
cip/4.4-st: [232958f9ac5f1c3333f78b2024db0a955a5c0711]
mainline: [8ce8849dd1e78dadcee0ec9acbd259d239b7069f]
stable/5.10: [322377cc909defcca9451487484845e7e1d20d1b]
stable/5.15: [ef535e0315afd098c4beb1da364847eca4b56a20]
stable/5.4: [8ad6679a5bb97cdb3e14942729292b4bfcc0e223]
stable/6.1: [6a0ac84501b4fec73a1a823c55cf13584c43f418]

CVE-2023-53729: soc: qcom: qmi_encdec: Restrict string length in decode

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53729

Introduced by commit 9b8a11e ("soc: qcom: Introduce QMI
encoder/decoder") in v4.16-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [6b58859e7c4ac357517a59f0801e8ce1b58a8ee2]
mainline: [8d207400fd6b79c92aeb2f33bb79f62dff904ea2]
stable/5.10: [2ccab9f82772ead618689d17dbc6950d6bd1e741]
stable/5.15: [b2f39b813d1eed4a522428d1e6acd7dfe9b81579]
stable/5.4: [64c5e916fabe5ef7bef0210b8a59fa8941ee1b8e]
stable/6.1: [f6250ecb7fbb934b89539e7e2ba6c1d8555c0975]
stable/6.6: [8d207400fd6b79c92aeb2f33bb79f62dff904ea2]

CVE-2023-53730: blk-iocost: use spin_lock_irqsave in adjust_inuse_and_calc_cost

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53730

Introduced by commit b0853ab ("blk-iocost: revamp in-period donation
snapbacks") in v5.10-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8d211554679d0b23702bd32ba04aeac0c1c4f660]
stable/5.10: [8563b58a4360e648ce18f0e98a75a4be51667431]
stable/5.15: [eb120c0aff5ceab9c9c46b87f302465bbf2bbaed]
stable/6.1: [8ceeb3fc86a83700bb1585c189006080a47e8506]

CVE-2023-53731: netlink: fix potential deadlock in netlink_set_err()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53731

Introduced by commit 1d482e6 ("netlink: disable IRQs for
netlink_lock_table()") in v5.13-rc4.
Fixed in v6.5-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
cip/4.19-st: [4b9adb8d4a62ff7608d4a7d4eb42036a88f30980]
mainline: [8d61f926d42045961e6b65191c09e3678d86a9cf]
stable/5.10: [cde7b90e0539a3b11da377e463dfd2288a162dbf]
stable/5.15: [a641240b7e071c5538dc0e7894ece833fce459dd]
stable/5.4: [8f6652ed2ad98fe6d13b903483d9257762ab2ec6]
stable/6.1: [61ffe8b1ee084e5c82a4e4bbf9e7b68e0c06e464]

CVE-2023-53732: fs/ntfs3: Fix NULL dereference in ni_write_inode

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53732

Introduced commit is not determined.Fixed in v6.4-rc1.
Affected file was added by 4342306 ("fs/ntfs3: Add file operations and
implementation") in 5.15-rc1.

Fixed status
mainline: [8dae4f6341e335a09575be60b4fdf697c732a470]
stable/5.15: [d4b74482529516477cf7b12502538e51827c699f]
stable/6.1: [b3152afc0eb864f7c6ecad134a15b577ef7aec77]


* Updated CVEs
CVE-2024-36890: mm/slab: make __free(kfree) accept error pointers

stable/5.15 was fixed.

Fixed status
stable/5.15: [946771c2a2b1150f9b7286feadc3aa1e15a1eb16]

CVE-2024-43877: media: pci: ivtv: Add check for DMA map result

stable/5.15 was fixed.

Fixed status
stable/5.15: [81d0664bed91a858c7b50c263954b59d65f1b414]

CVE-2024-58011: platform/x86: int3472: Check for adev == NULL

stable/5.15 was fixed.

Fixed status
stable/5.15: [46263a0b687a044e645387a9c7692ccd693f09f1]

CVE-2025-22058: udp: Fix memory accounting leak.

stable/5.15 was fixed.

Fixed status
stable/5.15: [c3ad8c30b6b109283d2643e925f8e65f2e7ab34e]

CVE-2025-39993: media: rc: fix races with imon_disconnect()

stable/5.15 was fixed.

Fixed status
stable/5.15: [71c52b073922d05e79e6de7fc7f5f38f927929a4]

CVE-2025-39994: media: tuner: xc5000: Fix use-after-free in xc5000_release

stable/5.15 was fixed.

Fixed status
stable/5.15: [3f876cd47ed8bca1e28d68435845949f51f90703]

CVE-2025-39995: media: i2c: tc358743: Fix use-after-free bugs caused
by orphan timer in probe

stable/5.15 was fixed.

Fixed status
stable/5.15: [663faf1179db9663a3793c75e9bc869358bad910]

CVE-2025-39996: media: b2c2: Fix use-after-free causing by
irq_check_work in flexcop_pci_remove

stable/5.15 was fixed.

Fixed status
stable/5.15: [120e221b4bbe9d0f6c09b5c4dc53ca4ad91d956b]

CVE-2025-39998: scsi: target: target_core_configfs: Add length check
to avoid buffer overflow

stable/5.15 was fixed.

Fixed status
stable/5.15: [ddc79fba132b807ff775467acceaf48b456e008b]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com


Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D07BC77B60
	for <webhook@archiver.kernel.org>; Wed, 26 Apr 2023 23:11:29 +0000 (UTC)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
 by mx.groups.io with SMTP id smtpd.web10.7721.1682550680211340062
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Apr 2023 16:11:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=nxSPCLR8;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.174, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-38de3338abeso4292510b6e.1
        for <cip-dev@lists.cip-project.org>; Wed, 26 Apr 2023 16:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1682550679; x=1685142679;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WwCOd3E9didbrfw592FP/2xU08HYa96/mmM8iChtkqw=;
        b=nxSPCLR8675sMk73SUao7lK0KVIsoS14h/vy/As23liTcYlKKAeawwToalovSMwhYX
         C3tuJMLOfKm+p6i2U/pzTnuBitl+c25GtfQIqk5bSwL/sL4UDmYgA6hJmWa5bB0Zi0pR
         0rvynk+IZdL938GQedMsaHwoZRjTM7L1EOCVNSS+dmikFfs+RnV95Eaoa9tIWvmBYSlO
         tnEt5k9sUpJqYlPcjVswcgnaoBEvxV0jFx2GdpkF4eZ8eXC+vfPPF8ogzylyvcTETAIm
         Lxb9q7WSm5n74ySuOEsuiHOsSHnNJJ9FNYfZzpyDmgX86c9UJUaj5JcQQ7gPHkDiMXVG
         wWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682550679; x=1685142679;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WwCOd3E9didbrfw592FP/2xU08HYa96/mmM8iChtkqw=;
        b=ShepUI0a9UEiIPrbzQNd5U47JKVC96XHN9RsZlwFKqKKNY8xDFqtHr+pUww39/GRr0
         jg/C0pXty/LAM1GAAFLM7BdQKSamxFxKwUf7NZeypn3hLJketJ7tY92V15BgpXlM+fQl
         Dp41fEMPqv+HgAYBd1X+7ae5OjrbbROz76SNoeAYuXtIP9RUQ7HHU/m2jFU9PSsrlsBJ
         +wng2bEu1UE13ga9nMA4KibwXTRqaGs1x8GmzZC/o9KtdmFiGXt2XZIZkPVao7m0jmpE
         KRVirYd5d3jNyo0cmXFHemukJJT/AF2n2Cgfgx+DPVkx6q/uNeWYreAfQZoGHQL8oRMG
         dYtA==
X-Gm-Message-State: AAQBX9eg/PeqwzGZRrENn2+qpzBHMAnSNtt1kOdIKmajaH3WChQVbwmh
	4/u567ILuIx+P3RWO4Qs0z2Q2lkbaZJyeIXrJdTILWtEuLAWODsVDBc=
X-Google-Smtp-Source: AKy350ZBBX7WQpgzdPKvM199UyXh2+gNyKua0YZuC0aVVo/i0qhrZu9W+PQ6FxiZDZzlz3m3OegieWGgdImWGF1M86Q=
X-Received: by 2002:a05:6808:1293:b0:38e:28b7:9c76 with SMTP id
 a19-20020a056808129300b0038e28b79c76mr13065120oiw.47.1682550678533; Wed, 26
 Apr 2023 16:11:18 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 27 Apr 2023 08:10:42 +0900
Message-ID: <CAODzB9puF7wdTwNtqgc4NCReByxqLeYukqm8s9ii-LL7dE0a_Q@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Apr 2023 23:11:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11359

Hi !

It's this week's CVE report.

This week reported 13 new CVEs and 3 updated CVEs.

* New CVEs

CVE-2023-2176: Kernel: Slab-out-of-bound read in compare_netdev_and_ip

CVSS v3 score is not provided.

Accessing out-of-boundary bug was found in drivers/infiniband/core/cma.c.
This bug will cause a system crash or escalate privilege.

Fixed status
mainline: [8d037973d48c026224ab285e6a06985ccac6f7bf]

CVE-2023-2177: Kernel: NULL pointer dereference problem in
sctp_sched_dequeue_common

CVSS v3 score is not provided.

A NULL pointer dereference bug was found in the net/sctp/stream_sched.c.
This bug will cause a system crash or a denial of service.

This bug was introduced by commit 5bbbbe32a431 ("sctp: introduce
stream scheduler foundations") in 4.15-rc1.
Kernel 4.4 and 4.14 are not affected.

Fixed status
mainline: [181d8d2066c000ba0a0e6940a7ad80f1a0e68e9d]
stable/5.10: [6f3505588d66b27220f07d0cab18da380fae2e2d]
stable/5.15: [e796e1fe20ecaf6da419ef6a5841ba181bba7a0c]
stable/5.4: [8d6dab81ee3d0309c09987ff76164a25486c43e0]

CVE-2023-2166: A null pointer dereference issue was found in can protocol

CVSS v3 score is not provided.

A null pointer dereference issue was found in can protocol in
net/can/af_can.c in the Linux before Linux. ml_priv may not be
initialized in the receive path of CAN frames. A local user could use
this flaw to crash the system or potentially cause a denial of
service.

This issue was introduced by commit 4e096a1 ("net: introduce CAN
specific pointer in the struct net_device") in 5.12-rc1-dontuse.
Kernel 4.4, 4.14, and 4.19 are not affected.

Fixed status
mainline: [0acc442309a0a1b01bcdaa135e56e6398a49439c]
stable/5.10: [c42221efb1159d6a3c89e96685ee38acdce86b6f]
stable/5.15: [c142cba37de29f740a3852f01f59876af8ae462a]
stable/5.4: [3982652957e8d79ac32efcb725450580650a8644]

CVE-2023-2194: write in xgene_slimpro_i2c_xfer()

CVSS v3 score is not provided.

An out-of-bounds write vulnerability was found in the Linux kernel's
SLIMpro I2C device driver. The userspace "data->block[0]" variable was
not capped to a number between 0-255 and was used as the size of a
memcpy, possibly writing beyond the end of dma_buffer. This flaw could
allow a local privileged user to crash the system or potentially
achieve code execution.

This issue was introduced by commit f6505fb ("i2c: add SLIMpro I2C
device driver on APM X-Gene platform") in 4.2-rc1.

Fixed status
mainline: [92fbb6d1296f81f41f65effd7f5f8c0f74943d15]
stable/4.14: [b8cb50c68c87f2c4a1d65df9275073e9c94aef5e]
stable/4.19: [5fc2b9485a8722c8350c3379992f5931ccfeaf98]
stable/5.10: [1eaa2b7ae90c5a5e05586df310d804de250747d3]
stable/5.15: [272dc775a52f2b0d0d8e844e77fefa7df8ebc653]
stable/5.4: [f8cbad984b1601435d087125ac760d3cae90213a]
stable/6.1: [7c64e839585eac8048bf67b1c6dcb7a5ca189a2e]
stable/6.2: [cc3c3ee6d035d38f116a6dec88acf7f74598aebd]

CVE-2023-31081: BUG: general protection fault in vidtv_mux_stop_thread

CVSS v3 score is not provided.

An issue was discovered in
drivers/media/test-drivers/vidtv/vidtv_bridge.c in the Linux kernel
6.2. There is a NULL pointer dereference in vidtv_mux_stop_thread. In
vidtv_stop_streaming, after dvb->mux=NULL occurs, it executes
vidtv_mux_stop_thread(dvb->mux).

No CIP member enables DVB_TEST_DRIVERS in the cip-kernel-config.

Fixed status
Not fixed yet

CVE-2023-31082: BUG: sleeping function called from invalid context in
__might_resched

CVSS v3 score is not provided.

An issue was discovered in drivers/tty/n_gsm.c in the Linux kernel
6.2. There is a sleeping function called from an invalid context in
gsmld_write, which will block the kernel.

Fixed status
Not fixed yet

CVE-2023-31083: BUG: general protection fault in hci_uart_tty_ioctl

CVSS v3 score is not provided.

An issue was discovered in drivers/bluetooth/hci_ldisc.c in the Linux
kernel 6.2. In hci_uart_tty_ioctl, there is a race condition between
HCIUARTSETPROTO and HCIUARTGETPROTO. HCI_UART_PROTO_SET is set before
hu->proto is set. A NULL pointer dereference may occur.

Fixed status
Not fixed yet

CVE-2023-31084: BUG: WARNING in dvb_frontend_get_event

CVSS v3 score is not provided.

An issue was discovered in drivers/media/dvb-core/dvb_frontend.c in
the Linux kernel 6.2. There is a blocking operation when a task is in
!TASK_RUNNING. In dvb_frontend_get_event, wait_event_interruptible is
called; the condition is dvb_frontend_test_event(fepriv,events). In
dvb_frontend_test_event, down(&fepriv->sem) is called. However,
wait_event_interruptible would put the process to sleep, and
down(&fepriv->sem) may block the process.

Fixed status
Not fixed yet

CVE-2023-31085: BUG: divide error in ubi_attach_mtd_dev

CVSS v3 score is not provided.

An issue was discovered in drivers/mtd/ubi/cdev.c in the Linux kernel
6.2. There is a divide-by-zero error in do_div(sz,mtd->erasesize),
used indirectly by ctrl_cdev_ioctl, when mtd->erasesize is 0.

Fixed status
Not fixed yet

CVE-2023-2006: A race condition was found in the RxRPC network protocol

CVSS v3 score is not provided.

A race condition was found in the Linux kernel's RxRPC network
protocol, within the processing of RxRPC bundles. This issue results
from the lack of proper locking when performing operations on an
object. This may allow an attacker to escalate privileges and execute
arbitrary code in the context of the kernel.

It was introduced by commit 245500d ("rxrpc: Rewrite the client
connection manager") in 5.10-rc1.
So, before 5.10 kernels are not affected.

Fixed status
mainline: [3bcd6c7eaa53b56c3f584da46a1f7652e759d0e5]
stable/5.10: [3535c632e6d16c98f76e615da8dc0cb2750c66cc]
stable/5.15: [38fe0988bd516f35c614ea9a5ff86c0d29f90c9a]

CVE-2023-2007: Linux Kernel DPT I2O Controller Time-Of-Check
Time-Of-Use Information Disclosure Vulnerability

CVSS v3 score is not provided.

The specific flaw exists within the DPT I2O Controller driver. The
issue results from the lack of proper locking when performing
operations on an object. An attacker can leverage this in conjunction
with other vulnerabilities to escalate privileges and execute
arbitrary code in the context of the kernel.

To fix this issue, the driver has been removed.

Following defconfig files use this driver in the cip-kernel-config.
$ find . -name *defconfig | xargs grep -n SCSI_DPT_I2O
./4.9.y-cip/x86/siemens_server_defconfig:165:CONFIG_SCSI_DPT_I2O=m
./4.14.y-cip/x86/siemens_iot2000_defconfig:149:CONFIG_SCSI_DPT_I2O=m
./4.14.y-cip/x86/siemens_server_defconfig:149:CONFIG_SCSI_DPT_I2O=m
./4.19.y-cip/x86/siemens_server_defconfig:153:CONFIG_SCSI_DPT_I2O=m
./4.4.y-cip/x86/siemens_server_defconfig:154:CONFIG_SCSI_DPT_I2O=m

Fixed status
mainline: [b04e75a4a8a81887386a0d2dbf605a48e779d2a0]

CVE-2023-2019: netdevsim: fib: Fix reference count leak on route
deletion failure

CVSS v3 score is not provided.

A flaw was found in the Linux kernel's netdevsim device driver, within
the scheduling of events. This issue results from the improper
management of a reference count. This may allow an attacker to create
a denial of service condition on the system

It was introduced by commit 0ae3eb7 ("netdevsim: fib: Perform the
route programming in a non-atomic context") in 5.12-rc1dontuse.
This patch is not backported to older stable kernels so before 5.12
kernels are not affected by this issue.

Fixed status
mainline: [180a6a3ee60a7cb69ed1232388460644f6a21f00]
stable/5.15: [f671cf48f383fccba313346eddb4bd6bcbdb55a4]

CVE-2023-2269: A possible deadlock in dm_get_inactive_table in dm-
ioctl.c leads to dos

CVSS v3 score is not provided.

A denial of service problem was found, due to a possible recursive
locking scenario, resulting in a deadlock in table_clear in
drivers/md/dm-ioctl.c in the Linux Kernel Device Mapper-Multipathing
sub-component.

Fixed status
mainline: [3d32aaa7e66d5c1479a3c31d6c2c5d45dd0d3b89]

* Updated CVEs

CVE-2021-4037: kernel: security regression for CVE-2018-13405

stable 5.4 was fixed.

Fixed status
mainline: [01ea173e103edd5ec41acec65b9261b87e123fc2]
stable/5.10: [e811a534ec2f7f6c0d27532c0915715427b7cab1]
stable/5.4: [e76bd6da51235ce86f5a8017dd6c056c76da64f9]

CVE-2023-1859: 9p/xen: Fix use after free bug in xen_9pfs_front_remove
due  to race condition

stable kernels were fixed.

Fixed status
stable/4.14: [b5664e929e2e19f644ea133ae8d87fbd5654ec5a]
stable/4.19: [c078fcd3f00ea5eadad07da169956d84f65af49b]
stable/5.10: [9266e939d76279d8710196d86215ba2be6345041]
stable/5.15: [e35ae49bc198412c9294115677e5acdef95b1fb5]
stable/5.4: [fcd084e199b9a38490bfedd97885bbaba14475e5]
stable/6.1: [c4002b9d5e837f152a40d1333c56ccb84975147b]
stable/6.2: [e7dcd834af53c79418ca3cd1c42749a314b9f7dc]

CVE-2023-30456: KVM: nVMX: add missing consistency checks for CR0 and CR4

stable 4.19 was fixed.

Fixed status
mainline: [112e66017bff7f2837030f34c2bc19501e9212d5]
stable/4.19: [495adb06518bb10f50e1aa1a1dbd5daa47d118f2]
stable/5.10: [c54974ccaff73525462e278602dfe4069877cfaa]
stable/5.15: [9c2f09add608a505f0e5fb694805f4766801583f]
stable/5.4: [65e4c9a6d0c9a8c81ce75576869d46fff5d7964f]
stable/6.1: [4bba9c8adec804f03d12dc762e50d083ee88b6b0]
stable/6.2: [71d05b9fa0bfc131a6e2250dea045a818ff25550]


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
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com


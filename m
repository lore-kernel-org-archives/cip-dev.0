Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F32C6FA82
	for <webhook@archiver.kernel.org>; Wed, 14 Sep 2022 23:54:18 +0000 (UTC)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by mx.groups.io with SMTP id smtpd.web09.4385.1663199650247537579
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Sep 2022 16:54:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=ZoaKbpi7;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.47,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f47.google.com with SMTP id
 l7-20020a056830154700b0065563d564dfso11399545otp.0
        for <cip-dev@lists.cip-project.org>;
 Wed, 14 Sep 2022 16:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date;
        bh=W3FVuS9TPmoeepyX2pbZbI13bbIOteDS1FDd+ps+w90=;
        b=ZoaKbpi7+0X6sQQFGK3V7VuzRsSHQEf6qCjQmXCrlvzKMWkKs6Fdapwqit47z/oCKQ
         CsxjMqaWCyDRgMkLVwLbzxy2EX8z2SNWAmFHVqKmyGGEVv7VeKjS5TKeX9i2xjvA7HmL
         k3g0jYDuWElwGNjzPOx/S2ahvO8H84Kjsu9PA5d7o4X413vua/3xqIB+LoWiySfGYC67
         PpOdHlfzPf3jbftpxl2H3Xvz2XhVm01PA9fs6pkY4XP46O4ICWfh28srQdtYwqg2Y01n
         KkZWcYK+/cMDlb1bYCfpTXwN2Ss6KQWuPo30DUQ+tfDkW1n1PYfUkKOsqH1u8ULieRbb
         klpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=W3FVuS9TPmoeepyX2pbZbI13bbIOteDS1FDd+ps+w90=;
        b=BeqbReuTvYXMcOsUzvkEdF+5FnxgBGLjGbHn3TcVYbGfqYY1+0eLiV95rcfuI6yLaz
         RlzkPchlIRDy8UwXoccoyzEm1h9jHz8asHyebDa8MDSSljJoan1V5VxdaJsLB/0x0IuS
         DwuK6r5nEe4hP/sV/x5U5/NInijNPN8eYAtSBs7YvMh1HUztiIu3Ggxn8vFMfBGajG+I
         ns6dMAq1WOGL4LNOLx/iD9kRmZDAQnBl29R+2jMnJw18Sur9aTGaNvlIaXEwd0W+62fR
         YZF9TxG5SSrOey4PoS/rjCpHzwj5CONcmJLBkId0OEoRBR53GaOaDXJ2yRwITUR5MVDB
         ERrw==
X-Gm-Message-State: ACgBeo1vEsJBu0uPx5EbAADhjTZJSxgibHStYLqoK7R1Qke3g1hn0s4n
	54iTl/ntZO0n43he3R0WwdNEVfnt6SlklQjFSS6gk4yCG8Ylvg==
X-Google-Smtp-Source: 
 AA6agR4I76Tzb9YTzWL4fFcHwUuubhJhpa659JhOS0A+mw3HUWSEhlAExRRXph10zIbMGyTARVI4lSV5AxAPhUi/aiM=
X-Received: by 2002:a05:6830:919:b0:657:ce94:341e with SMTP id
 v25-20020a056830091900b00657ce94341emr1901191ott.96.1663199649041; Wed, 14
 Sep 2022 16:54:09 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 15 Sep 2022 08:53:33 +0900
Message-ID: 
 <CAODzB9qzYNymRy7DQk_qXwa-g5=sW9=O+59SkoBP3VPzkKtePA@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Sep 2022 23:54:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9495

Hi !

It's this week's CVE report.

This week reported 8 new CVEs and 0 updated CVEs.

* New CVEs

CVE-2022-3169: Request to NVME_IOCTL_RESET and NVME_IOCTL_SUBSYS_RESET
may cause a DOS

CVSS v3 score is 5.5 MEDIUM.

A denial of service flaw may occur if there is a consecutive request
of the NVME_IOCTL_RESET and the NVME_IOCTL_SUBSYS_RESET through the
device file of the driver, resulting in a PCIe link disconnect.

This bug was reported last October to the kernel bugzilla
(https://bugzilla.redhat.com/show_bug.cgi?id=3D2125341)  but it hasn't
been fixed yet.

Fixed status
Not fixed yet.

CVE-2022-40307: efi: capsule-loader: Fix use-after-free in efi_capsule_writ=
e

CVSS v3 score is 4.7 MEDIUM.

There is a race condition that occurs between the efi_capsule_write() and
efi_capsule_flush(). This race condition bug causes use-after-free bug.

Fixed status
mainline: [9cb636b5f6a8cc6d1b50809ec8f8d33ae0c84c95]

CVE-2022-3077: A buffer overflow vulnerability was found in the Linux
kernel Intel=E2=80=99s iSMT SMBus host controller driver

CVSS v3 score is not assigned.

A buffer overflow vulnerability was found in the Linux kernel Intel=E2=80=
=99s
iSMT SMBus host controller driver in the way it handled the
I2C_SMBUS_BLOCK_PROC_CALL case (via the ioctl I2C_SMBUS) with
malicious input data. This flaw could allow a local user to crash the
system.

This vulnerability was introduced by commit 5e9a97b ("i2c: ismt:
Adding support for I2C_SMBUS_BLOCK_PROC_CALL") in 5.11-rc1.
This commit is not backported to earlier versions so that 4.4, 4.9,
4.14, 4.19, and 5.10 are not vulnerabile.

Fixed status
mainline: [690b2549b19563ec5ad53e5c82f6a944d910086e]
stable/5.15: [24c6fc6e7453f64cf6cbb4218c62aafdecc16ee1]

CVE-2022-36280: An out-of-bounds(OOB) memory access vulnerability was
found in vmwgfx driver

CVSS v3 score is not assigned(NIST).
CVSS v3 score is 6.3 MEDIUM(CNA).

An out-of-bounds(OOB) memory access vulnerability was found in vmwgfx
driver in drivers/gpu/vmxgfx/vmxgfx_kms.c in GPU component in the
Linux kernel with device file '/dev/dri/renderD128 (or Dxxx)'. This
flaw allows a local attacker with a user account on the system to gain
privilege, causing a denial of service(DoS).

Above description said the vulnerability is in
drivers/gpu/vmxgfx/vmxgfx_kms.c but this file doesn't exist in the
mainline. It may be drivers/gpu/drm/vmwgfx/vmwgfx_kms.c instead.

Fixed status
Not fixed yet.

CVE-2022-38096: A NULL pointer dereference vulnerability was found in
vmwgfx driver

CVSS v3 score is 5.5 MEDIUM(NIST).
CVSS v3 score is 6.3 MEDIUM(CNA).

Above description said the vulnerability is in
drivers/gpu/vmxgfx/vmxgfx_kms.c but this file doesn't exist in the
mainline. It may be drivers/gpu/drm/vmwgfx/vmwgfx_kms.c instead.

Fixed status
Not fixed yet.

CVE-2022-38457: A use-after-free vulnerability was found int vmwgfx
drivers driver

CVSS v3 score is 5.5 MEDIUM(NIST).
CVSS v3 score is 6.3 MEDIUM(CNA).

A NULL pointer dereference vulnerability was found in vmwgfx driver in
drivers/gpu/vmxgfx/vmxgfx_execbuf.c in GPU component of Linux kernel
with device file '/dev/dri/renderD128 (or Dxxx)'. This flaw allows a
local attacker with a user account on the system to gain privilege,
causing a denial of service(DoS).

Above description said the vulnerability is in
drivers/gpu/vmxgfx/vmxgfx_execbuf.c but this file doesn't exist in the
mainline. It may be drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c instead.

Fixed status
Not fixed yet.

CVE-2022-40133: A use-after-free vulnerability was found in vmwgfx driver

CVSS v3 score 5.5 MEDIUM(NIST).
CVSS v3 score is 6.3 MEDIUM(CNA).

A use-after-free(UAF) vulnerability was found in function
'vmw_execbuf_tie_context' in drivers/gpu/vmxgfx/vmxgfx_execbuf.c in
Linux kernel's vmwgfx driver with device file '/dev/dri/renderD128 (or
Dxxx)'. This flaw allows a local attacker with a user account on the
system to gain privilege, causing a denial of service(DoS).

Above description said the vulnerability is in
drivers/gpu/vmxgfx/vmxgfx_execbuf.c but this file doesn't exist in the
mainline. It may be drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c instead.

Fixed status
Not fixed yet.

CVE-2022-3202: Null Pointer Deference in jfs_evict_inode leads to
Denial of Service

CVSS v3 score is not assigned

A NULL pointer dereference flaw in diFree in fs/jfs/inode.c in
Journaled File System (JFS)in the Linux kernel. This could allow a
local attacker to crash the system or leak kernel internal
information.

All stable kernels and cip kernels are fixed this issue.

Fixed status
mainline: [a53046291020ec41e09181396c1e829287b48d47]
stable/4.14: [33bd243566a9b1ca94261dcc2e16c7b9e3a71c15]
stable/4.19: [2ef74e3e0089b6615ee124e1183746974c6bb561]
stable/4.9: [d2e45f0bc25da09efcac658d6e405115fcfa83c2]
stable/5.10: [b9c5ac0a15f24d63b20f899072fa6dd8c93af136]
stable/5.15: [d925b7e78b62805fcc5440d1521181c82b6f03cb]
stable/5.4: [e19c3149a80e4fc8df298d6546640e01601f3758]

* Updated CVEs

No update CVEs.

Fixed status

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


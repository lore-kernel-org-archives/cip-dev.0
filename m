Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D4AC433FE
	for <webhook@archiver.kernel.org>; Wed,  5 Oct 2022 23:54:24 +0000 (UTC)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com
 [209.85.160.42])
 by mx.groups.io with SMTP id smtpd.web12.82.1665014054114857814
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Oct 2022 16:54:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=npVCIxNQ;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.42,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-132af5e5543so455317fac.8
        for <cip-dev@lists.cip-project.org>;
 Wed, 05 Oct 2022 16:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=beefWxvPml/+sy2tw68wm0ymgcFMOLGdf817+E9tgQc=;
        b=npVCIxNQyQfrsdrMv3mygxf0u7E+5/wVl8EwUJOPqyuiUsVrbuCK6CskjBFO0vGP8c
         M4N+4SViqfT8bYTgaE3delxEMo4XHEOOfocKj9J1JvBt0VFD0pckeIHOYf2JX1O5ksLW
         u+qDkQKhKasLEH//u2eSxwL3kmUkdi+P6SwkUpcyMDUHi4uzBVboJw8nVYACd4zJEZtO
         3HHfub0cVSBIacaglmsfd2/JJRYSfOY1KEUk4wbkY8mvxZ9TcqCbMMsQLBSu/pB3w08p
         3ZJpgr24HlK4C6zagbfRJdJvRnL6iMsJRk6bLekcSnAM92JI7UwfEgTFIeWuNs3sSGPJ
         1ElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=beefWxvPml/+sy2tw68wm0ymgcFMOLGdf817+E9tgQc=;
        b=AZvSGgpzIkWrnD72n5LUcJeQed8ceZTmRWyZkhB3FLE7hziS1ydFxx/N4BVY83FBff
         xGGkQJ6+5CHNgvMndvsQJDIG3oE2k6Xc2pZRdpynVnGtmkwj6uVe2lmX8yUONKYYcYIH
         /2JYVOFF284H/uTrVrqCDs36eWraga6wKuYBRDbiu3iMubYf4Updb84dRaoCpL3r98KD
         c7wSixFRgSDIGw1bV0Y6YDuiYOcpF20tdx+tKghPQJBCGwAZr05/vNGb8jWCTgWtBM8i
         q9mM0JvQEQdtaZ+613O+kyYRRuaJ+bq1F1yDr8nT3TojsYJv2K431xA6UhEVCwMU2Ois
         D/cg==
X-Gm-Message-State: ACrzQf0hpInP0kC1XdgsyCoI+HrG4ZpTZMyjEvEy4fUXZWStLnhI5AM9
	Zr4dfQxBWy8+L12zOpib3Rz0rnxtt2hh2Wx2KghOTENolL6IxQ==
X-Google-Smtp-Source: 
 AMsMyM5X3yoTtbxCf8zTjrOEO6PIi7oWkafyT8BrggwjX6eV+c9AQf8BoTo5+dqZ0lHjcmytWT6bAJgBQay7rLRXSaY=
X-Received: by 2002:a05:6870:eca8:b0:132:df46:5c66 with SMTP id
 eo40-20020a056870eca800b00132df465c66mr1091005oab.280.1665014052857; Wed, 05
 Oct 2022 16:54:12 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 6 Oct 2022 08:53:36 +0900
Message-ID: 
 <CAODzB9q1jZ5mr4gVzM_tic-B81swhRZ=_RqfxnemQZyzj3_Lgg@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Oct 2022 23:54:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9653

Hi !

It's this week's CVE report.

This week reported 7 new CVEs and 2 updated CVEs.

* New CVEs

CVE-2022-41848: char: pcmcia: synclink_cs: Fix use-after-free in mgslpc_ops

CVSS v3 score is 4.2 MEDIUM.

drivers/char/pcmcia/synclink_cs.c in the Linux kernel through 5.19.12
has a race condition and resultant use-after-free if a physically
proximate attacker removes a PCMCIA device while calling ioctl, aka a
race condition between mgslpc_ioctl and mgslpc_detach.

This Vulnerability is affected if CONFIG_SYNCLINK_CS(SyncLink PC Card
support) is enabled.

No CIP member enables CONFIG_SYNCLINK_CS.

Fixed status
Patch is available but it hasn't been merged yet.

CVE-2022-41849: video: fbdev: smscufx: Fix use-after-free in ufx_ops_open()

CVSS v3 score is 4.2 MEDIUM.

This vulnerability is affected if CONFIG_FB_SMSCUFX (SMSC UFX6000/7000
USB Framebuffer support) is enabled.

drivers/video/fbdev/smscufx.c in the Linux kernel through 5.19.12 has
a race condition and resultant use-after-free if a physically
proximate attacker removes a USB device while calling open(), aka a
race condition between ufx_ops_open and ufx_usb_disconnect.

4.4.y-cip-rt/x86/siemens_i386-rt.config is enabled CONFIG_FB_SMSCUFX.

Fixed status
Patch is available but it hasn't been merged yet.

CVE-2022-41850: HID: roccat: Fix Use-After-Free in roccat_read

CVSS v3 score is 4.7 MEDIUM.

This vulnerability is affected if CONFIG_HID_ROCCAT (Roccat device
support) is enabled.

roccat_report_event in drivers/hid/hid-roccat.c in the Linux kernel
through 5.19.12 has a race condition and resultant use-after-free in
certain situations where a report is received while copying a
report->value is in progress.

Following files set CONFIG_HID_ROCCAT=m.

4.9.y-cip/arm/moxa_mxc_defconfig
4.19.y-cip/arm/moxa_mxc_defconfig
4.4.y-cip/arm/moxa_mxc_defconfig
5.10.y-cip/arm/moxa_mxc_defconfig

Fixed status
Patch is available but it hasn't been merged yet.

CVE-2022-20421: binder: fix UAF of ref->proc caused by race condition

CVSS v3 score is not provided.

A use-after-free bug was found in drivers/android/binder.c.
This driver is built when ANDROID_BINDER_IPC is set.

No CIP member enables ANDROID_BINDER_IPC.

Fixed status
mainline: [a0e44c64b6061dda7e00b7c458e4523e2331b739]
stable/4.14: [229f47603dd306bc0eb1a831439adb8e48bb0eae]
stable/4.19: [06e5b43ca4dab06a92bf4c2f33766e6fb11b880a]
stable/5.10: [9629f2dfdb1dad294b468038ff8e161e94d0b609]
stable/5.15: [c2a4b5dc8fa71af73bab704d0cac42ac39767ed6]
stable/5.19: [603a47f2ae56bf68288784d3c0a8c5b8e0a827ed]
stable/5.4: [30d0901b307f27d36b2655fb3048cf31ee0e89c0]

CVE-2022-20422: arm64: fix oops in concurrently setting insn_emulation sysctls

CVSS v3 score is not provided.

A NULL pointer dereference bug was found in emulation_proc_handler()
in arm64/kernel/armv8_deprecated.c.
If emulation_proc_handler() is called concurrently, a NULL pointer
dereference bug may occur.
The armv8_deprecated.c is built when ARMV8_DEPRECATED is set.

Patch for 4.9 is available but it's not released yet.

No CIP member enables ARMV8_DEPRECATED.

Fixed status
mainline: [af483947d472eccb79e42059276c4deed76f99a6]
stable/4.14: [9d5fec6ba2e4117d196a8259ab54615ffe562460]
stable/4.19: [b51881b1da57fe9877125dfdd0aac5172958fcfd]
stable/5.10: [353b4673d01c512303c45cf2346f630cda73b5c9]
stable/5.15: [cc69ef95988b9ef2fc730ec452a7441efb90ef5e]
stable/5.19: [07022e07017ee5540f5559b0aeb916e8383c1e1a]
stable/5.4: [04549063d5701976034d8c2bfda3d3a8cbf0409f]

CVE-2022-20423: usb: gadget: rndis: prevent integer overflow in
rndis_set_response()

CVSS v3 score is not provided.

In rndis_set_response(), there was a missing buffer size check that
caused an integer overflow bug.

Fixed status
cip/4.4: [debcd5bcbe8ab6cfaf703ad7f7333308e388874a]
cip/4.4-rt: [debcd5bcbe8ab6cfaf703ad7f7333308e388874a]
cip/4.4-st: [debcd5bcbe8ab6cfaf703ad7f7333308e388874a]
mainline: [65f3324f4b6fed78b8761c3b74615ecf0ffa81fa]
stable/4.14: [c7953cf03a26876d676145ce5d2ae6d8c9630b90]
stable/4.19: [138d4f739b35dfb40438a0d5d7054965763bfbe7]
stable/4.9: [8b3e4d26bc9cd0f6373d0095b9ffd99e7da8006b]
stable/5.10: [28bc0267399f42f987916a7174e2e32f0833cc65]
stable/5.15: [56b38e3ca4064041d93c1ca18828c8cedad2e16c]
stable/5.4: [21829376268397f9fd2c35cfa9135937b6aa3a1e]

CVE-2022-20424: io_uring: always use original task when preparing req identity

This CVE is a duplicate of
CVE-2022-1786(https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/-/blob/master/issues/CVE-2022-1786.yml).

* Updated CVEs

CVE-2022-23816 CVE-2022-29900: Information leak through mispredicted
returns on AMD processors
CVE-2022-29901: Information leak through mispredicted returns on Intel
processors

According to the debian security tracker[1,2], it added new notes that
said "[buster] - linux <ignored> (Mitigation is too invasive to
backport)". It seems as if the Debian team tried to backport patches
to 4.19 but they gave up backporting patches because of its too
complex backport?

1: https://security-tracker.debian.org/tracker/CVE-2022-29900
2: https://security-tracker.debian.org/tracker/CVE-2022-29901

CVE-2022-2663: netfilter: nf_conntrack_irc: Tighten matching on DCC message

Added one more commit e8d5dfd ("netfilter: nf_conntrack_irc: Tighten
matching on DCC message"). This commit was merged in 6.0-rc7.
Both commits 0efe125 ("netfilter: nf_conntrack_irc: Fix forged IP
logic") and e8d5dfd ("netfilter: nf_conntrack_irc: Tighten matching on
DCC message") mentions to fix 869f37d ("[NETFILTER]:
nf_conntrack/nf_nat: add IRC helper port").

Fix status
mainline: [0efe125cfb99e6773a7434f3463f7c2fa28f3a43,
e8d5dfd1d8747b56077d02664a8838c71ced948e]
stable/4.14: [6ce66e3442a5989cbe56a6884384bf0b7d1d0725]
stable/4.19: [3275f7804f40de3c578d2253232349b07c25f146,
468adf7aab7a30ffe4467e2c981a65568ba84f0b]
stable/4.9: [eb4d8d6b44a23ff2b6e2af06c8240de73dff8a7d]
stable/5.10: [e12ce30fe593dd438c5b392290ad7316befc11ca,
9a5d7e0acb41bb2aac552f8eeb4b404177f3f66d]
stable/5.15: [451c9ce1e2fc9b9e40303bef8e5a0dca1a923cc4]
stable/5.19: [6cf0609154b2ce8d3ae160e7506ab316400a8d3d]
stable/5.4: [36f7b71f8ad8e4d224b45f7d6ecfeff63b091547]

CVE-2022-2308: undefined behavior or data leak in Virtio drivers with VDUSE

The mainline, 5.15, and 5.19 were fixed. The VDUSE has been introduced
since 5.15-rc1 by commit c8a6153("vduse: Introduce VDUSE - vDPA Device
in Userspace") so earlier than 5.15 kernels aren't affected.

Fixed status
mainline: [46f8a29272e51b6df7393d58fc5cb8967397ef2b]
stable/5.15: [dc248ddf41eab4566e95b1ee2433c8a5134ad94a]
stable/5.19: [38d854c4a11c3bbf6a96ea46f14b282670c784ac]

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


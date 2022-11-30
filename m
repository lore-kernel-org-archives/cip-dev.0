Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367CEC4321E
	for <webhook@archiver.kernel.org>; Wed, 30 Nov 2022 23:26:57 +0000 (UTC)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
 by mx.groups.io with SMTP id smtpd.web11.28822.1669850812610088071
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Nov 2022 15:26:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=VWA4Ghe6;
 spf=pass (domain: miraclelinux.com, ip: 209.85.166.43, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-io1-f43.google.com with SMTP id e189so25703iof.1
        for <cip-dev@lists.cip-project.org>; Wed, 30 Nov 2022 15:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pM0Y/3KHzAbWAebGAYF52GC5DJd/MezoNdfB4r+Dbbw=;
        b=VWA4Ghe6j44loGWH9Mq+lry6x8h+Vv/MePuKS3rFVCYNENViMu17nqV7tiDspZRbbY
         fYfnEe0E8JxF8rfeDfY9q7H/CUv0VXEbl8k5FQatvk6LxKVNm9QcDcKgOD9zGORsX1ak
         sVnmz6P/Rtt2d+P0bwUbqlmueReP2Kpkz/dtlIg9d6s6lwGS+6VHoat/F/GIFP2Ucd00
         6N46cc6hO+QyIKjT20n/Xc1ZzlHMkoehr5ZXWDZx8Z/6FsEwSZNWXRK0KE3Jrp9ugPrR
         zDGvhi2XRc2mKi51cyN9k0iQHbzJID61ph/M7/zvR9OkmXY0GodvDELSCEknnV5Ax+0r
         zJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pM0Y/3KHzAbWAebGAYF52GC5DJd/MezoNdfB4r+Dbbw=;
        b=yvtRbcwrqQ5N50VNCO/6Fx1CvQu2nDH3Mf24QOAZNH97pkRHxECDshGUxYR5RZ3yJn
         cj/5a9g8IRZhWY6pH/rEvz1P4OaAAdSOjYNIxNwTIcN5ALLS6sRorS8s9D4kz9Ctbsof
         4MgY04BDCtSIDO4+vwwdhw+dK35VdGzpFnTQNMmN8kahg4GwClgelulGeJdM4HdktWM4
         y/5phZ96HknVNWXNG7RKCy8gjBhkXxZkY7HADjs26R/DJSDlfquAN87n+K20BSgCJStJ
         lzzNAz4eFEZdPeFHWuZBDwMatM7rBU1zNrpD5lZnzL/DaPG+PCAB+eOHh2VFV807+CQg
         yDNw==
X-Gm-Message-State: ANoB5pmzGFDdPG+fvu0FQ0KwWTT/YdFRhoUqeJY6GhBphdzKBn+RiW4s
	NrEbHgUbLja6udLKZYwVxvwsmXEEKCTclR3pPHfrJR/isrwiNQ==
X-Google-Smtp-Source: AA0mqf4D5IIjzEWTqa3Opu34LpycJdXiLeC38RW2wktJ7f36SBhsduZWbRgdSVZvkpZTG/hy1dsxWjWBPmIqBWOEqkY=
X-Received: by 2002:a02:6662:0:b0:363:69a0:837f with SMTP id
 l34-20020a026662000000b0036369a0837fmr23268161jaf.57.1669850811452; Wed, 30
 Nov 2022 15:26:51 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 1 Dec 2022 08:26:15 +0900
Message-ID: <CAODzB9phe9VtP4rgjySyub20heqvN9MvgH19EFgZOgbaYDQS9Q@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Nov 2022 23:26:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10145

Hi !

It's this week's CVE report.

This week reported 11 new CVEs and 3 updated CVEs.
CVE-2022-45884, CVE-2022-45885, CVE-2022-45886, CVE-2022-45887 are
fixed in a same patch series.

* New CVEs

CVE-2022-4129: l2tp: missing lock when clearing sk_user_data can lead
to NULL pointer dereference

CVSS v3 score is not provided.

A NULL pointer dereference bug was found in the l2tp module.

Introduced by commit b68777d54fac ("l2tp: Serialize access to
sk_user_data with sk_callback_lock") in 6.1-rc6.
It fixes commit 3557baa ("[L2TP]: PPP over L2TP driver core") in 2.6.23-rc1=
.
Commit b68777d54fac is not backported to stable kernels so these
kernels aren't affected by this issue.

Fixed status
Patch is available(https://lore.kernel.org/netdev/20221119130317.39158-1-ja=
kub@cloudflare.com/)
but not merged yet.

CVE-2022-28667: Out-of-bounds write for some Intel(R) PROSet/Wireless
WiFi software

CVSS v3 score is 6.5 MEDIUM.

Out-of-bounds write for some Intel(R) PROSet/Wireless WiFi software
before version 22.140 may allow an unauthenticated user to potentially
enable denial of service via adjacent access.

According to the Intel security advisory INTEL-SA-00687, it said that
"Intel=C2=AE PROSet/Wireless WiFi drivers to mitigate this vulnerability
will be up streamed by November 08, 2022." so the mainline kernel
seems affected by this issue.

Fixed status
Not fixed yet

CVE-2022-45884: A use-after-free bug was found in
drivers/media/dvb-core/dvbdev.c

CVSS v3 score is 7.0 HIGH.

An issue was discovered in the Linux kernel.
drivers/media/dvb-core/dvbdev.c has a use-after-free, related to
dvb_register_device dynamically allocating fops.

It looks like all stable kernels (include 4.4) are affected by this issue.

Fixed status
Patch is available but it hasn't been merged yet.
https://lore.kernel.org/linux-media/20221115131822.6640-1-imv4bel@gmail.com=
/

CVE-2022-45885: A use-after-free bug was found in
drivers/media/dvb-core/dvb_frontend.c

CVSS v3 score is 7.0 HIGH.

An issue was discovered in the Linux kernel.
drivers/media/dvb-core/dvb_frontend.c has a race condition that can
cause a use-after-free when a device is disconnected.

It looks like all stable kernels (include 4.4) are affected by this issue.

Fixed status
Patch is available but it hasn't been merged yet.
https://lore.kernel.org/linux-media/20221115131822.6640-1-imv4bel@gmail.com=
/

CVE-2022-45886: A use-after-free bug was found in
drivers/media/dvb-core/dvb_net.c

CVSS v3 score is 7.0 HIGH.

An issue was discovered in the Linux kernel.
drivers/media/dvb-core/dvb_net.c has a .disconnect versus
dvb_device_open race condition that leads to a use-after-free.

It looks like all stable kernels (include 4.4) are affected by this issue.

Fixed status
Patch is available but it hasn't been merged yet.
https://lore.kernel.org/linux-media/20221115131822.6640-1-imv4bel@gmail.com=
/

CVE-2022-45887: media: ttusb-dec: Fix memory leak in ttusb_dec_exit_dvb()

CVSS v3 score is 4.7 MEDIUM.

An issue was discovered in the Linux kernel.
drivers/media/usb/ttusb-dec/ttusb_dec.c has a memory leak because of
the lack of a dvb_frontend_detach call.

It looks like all stable kernels (including 4.4) are affected by this issue=
.

Fixed status
Patch is available but it hasn't been merged yet.
https://lore.kernel.org/linux-media/20221115131822.6640-1-imv4bel@gmail.com=
/

CVE-2022-45888: char: xillybus: Fix use-after-free in xillyusb_open()

CVSS v3 score is 6.4 MEDIUM.

An issue was discovered in the Linux kernel.
drivers/char/xillybus/xillyusb.c has a race condition and
use-after-free during physical removal of a USB device.

XILLYUSB driver was added by a53d120 ("char: xillybus: Add driver for
XillyUSB (Xillybus variant for USB)" in 5.14-rc1. So, before 5.14
kernels are not affected.

Fixed status
Patch is available but it hasn't been merged yet.
https://lore.kernel.org/all/20221022175404.GA375335@ubuntu/

CVE-2022-45919: media: dvb-core: Fix use-after-free due to race
condition occurring in dvb_ca_en50221

CVSS v3 score is 7.0 HIGH.

An issue was discovered in the Linux kernel. In
drivers/media/dvb-core/dvb_ca_en50221.c, a use-after-free can occur if
there is a disconnect after an open, because of the lack of a
wait_event.

It looks like all stable kernels (include 4.4) are affected by this issue.

Fixed status
Patch is available but it hasn't been merged yet.
https://lore.kernel.org/linux-media/20221121063308.GA33821@ubuntu/T/#u

CVE-2022-45934: Bluetooth: L2CAP: Fix u8 overflow

CVSS v3 score is not provided.

An issue was discovered in the Linux kernel. l2cap_config_req in
net/bluetooth/l2cap_core.c has an integer wraparound via
L2CAP_CONF_REQ packets.

It looks like all stable kernels (include 4.4) are affected by this issue.

Fixed status
fixed in the bluetooth-next tree.
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3Dae4569813a6e931258db627cdfe50dfb4f917d5d

CVE-2022-45869: KVM: x86/mmu: Fix race condition in direct_page_fault

CVSS v3 score is not provided.

A race condition bug was found in direct_page_fault() it will lead to
a systemc crash.
Introduced by commit a2855af ("KVM: x86/mmu: Allow parallel page
faults for the TDP MMU") in v5.12-rc1-dontuse. It is not backported to
stable kernels.
so less than 5.12 kernels are not affected by this issue.

Fixed status
mainline: [47b0c2e4c220f2251fd8dcfbb44479819c715e15]

CVE-2022-4139: drm/i915: fix TLB invalidation for Gen12 video and
compute enginescip

CVSS v3 score is not provided.

A random memory corruption or data leaks problem in Intel i915 graphic
driver because of incorrect GPU TLB flush.
This bug was introduced by commit 7938d61 ("drm/i915: Flush TLBs
before releasing backing store") which was backported to all stable
kernels.

Fixed status
mainline: [04aa64375f48a5d430b5550d9271f8428883e550]

* Updated CVEs

CVE-2022-3169: Request to NVME_IOCTL_RESET and NVME_IOCTL_SUBSYS_RESET
may cause a DOS

stable kernels are fixed this week.

Fixed status
mainline: [1e866afd4bcdd01a70a5eddb4371158d3035ce03]
stable/5.10: [023435a095d22bcbbaeea7e3a8c534b5c57d0d82]
stable/5.15: [b1a27b2aad936746e6ef64c8a24bcb6dce6f926a]
stable/6.0: [0c2b1c56252bf19d3412137073c2c07e86f40ba1]

CVE-2022-3521: kcm: avoid potential race in kcm_tx_work

stable kernels are fixed this week. kernel 4.4 is not affected by this issu=
e.

Fixed status
mainline: [ec7eede369fe5b0d085ac51fdbb95184f87bfc6c]
stable/4.14: [381b6cb3f3e66b84db77028ac7d84f18d80f1153]
stable/4.19: [23a0a5869749c7833772330313ae7aec6581ec60]
stable/4.9: [fe3f79701fdaf8a087bc7043839e7f8b2e61b6fe]
stable/5.10: [7deb7a9d33e4941c5ff190108146d3a56bf69e9d]
stable/5.15: [27d706b0d394a907ff8c4f83ffef9d3e5817fa84]
stable/5.4: [ad39d09190a545d0f05ae0a82900eee96c5facea]
stable/6.0: [2526ac6b0f5a9b38e7e9073e37141cf78408078d]

CVE-2022-3344: KVM: SVM: nested shutdown interception could lead to host cr=
ash

mainline was fixed this week.

Fixed status
mainline: [16ae56d7e0528559bf8dc9070e3bfd8ba3de80df,
ed129ec9057f89d615ba0c81a4984a90345a1684]

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


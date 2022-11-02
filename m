Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740CAC4321E
	for <webhook@archiver.kernel.org>; Wed,  2 Nov 2022 23:20:48 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.web11.13362.1667431241040207949
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Nov 2022 16:20:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=n36Q0kKj;
 spf=pass (domain: miraclelinux.com, ip: 209.85.208.47, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ed1-f47.google.com with SMTP id v27so665017eda.1
        for <cip-dev@lists.cip-project.org>; Wed, 02 Nov 2022 16:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kg6DIbKnClmH9xmIxoLDmhOYrYtPXBlw7YG6/jWFwQI=;
        b=n36Q0kKj6Urf68sj8qf1hgJzN3yxLdeSX86AcH9DmlttzI8IdlHwfWhn0TnymvrU0Z
         ENZ/IqVrSElOmWgKihCfE//AGaH5MovLyZPGoY2yPvYibFzzBhdG9K6+QeviELqHPgzw
         Kg4UjR5sA1TinUMfnygnIshzsOIH8lQ19mCvGaE/9Cp57D256O5SGsk9LmffRLpWwGJt
         7rvk5S242tFFKhOvFTKDCF778N80PsCTQ6ZxM4pOKvnpOHz0pvHQEDN5X+SrIqNNeTNX
         1Cpup2204ooo5VA6aahFOxAmsV2wTh10fYfvhBTj9Gz/5j0oOK6dN6ScN3VpDR4GZZrB
         v4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kg6DIbKnClmH9xmIxoLDmhOYrYtPXBlw7YG6/jWFwQI=;
        b=tisq2TY1Hy0lYFUD2bBkNzoL+ZGfS2gyAB+ctO2PAr0LY6LfE+uFfbmV7Hr8em8Vaa
         h/cYKHwlo8cauQLGVBjGsBxk0GwOXAoriniBTbNzyvtAL8r/Wf+hxIlbRKtJaWFsDlia
         wWXZhUNgZv4eKKB3Rfxxr9Cb0xsmqqYZoArEujcpzLga/JY6JMYnTfBZVzZsL8vaKj/c
         CIc0xgsPuc7hIy58u3zGQfQdLev8UkAibKPo5YPIE5Vf5vPmXtYFKjH/vvfGY3VxH3qq
         H0c+mZ1BJHuuE5jG/8G4eOIyYrCKRBjfc1MHWS7V0575zBNjqAqvx6uBR4vUwCStwGdn
         /ccQ==
X-Gm-Message-State: ACrzQf2KPw2PQwMut5gdEiZOdslrYd7ZH0J3SmIHtp2F9F7xXTMeP8jy
	l/5k77LDKblHyqMMKFdoeaoR8t6DOed1oH0GC/7O35q6CJ4unA==
X-Google-Smtp-Source: AMsMyM7GHcqQQsMhckhVmC/UBIUfs6gZKhAs/vPGR2LPUuPsqwcYjWpjprLKt3ye4yObd/RDXRRdTtNWo1URV73kxmc=
X-Received: by 2002:a05:6402:7c4:b0:462:9bc2:d0d0 with SMTP id
 u4-20020a05640207c400b004629bc2d0d0mr27590733edy.122.1667431238926; Wed, 02
 Nov 2022 16:20:38 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 3 Nov 2022 08:20:03 +0900
Message-ID: <CAODzB9r5NHrmR0bUGUKe+qkZSBJ5Y3+PThwWTJdHpmZ00H8mpg@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Nov 2022 23:20:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9895

Hi !

It's this week's CVE report.

This week reported 6 new CVEs and 3 updated CVEs.

CVE-2022-44034, CVE-2022-44032, and CVE-2022-44033 are related issues.

* New CVEs

CVE-2022-3544: A memory leak bug was found in damon_sysfs_add_target()
in mm/daemon/sysfs.c.

CVSS v3 score is 5.5 MEDIUM(NIST).
CVSS v3 score is 3.5 MEDIUM(CNA).

This bug was introduced by commit a61ea56 ("mm/damon/sysfs: link DAMON
for virtual address spaces monitoring") in 5.18-rc1.
The mm/daemon/sysfs.c was introduced by commit c951cd3 ("mm/damon:
implement a minimal stub for sysfs-based DAMON interface") in
5.18-rc1.

Fixed status
mainline: [1c8e2349f2d033f634d046063b704b2ca6c46972]

CVE-2022-3628: wifi: Fix potential buffer overflow in 'brcmf_fweh_event_worker'

CVSS v3 score is not provided.

An intra-object buffer overflow was found in brcmfmac (an upstream
Broadcom's USB Wi-Fi driver), which can be triggered by a malicious
USB device. This bug will cause privilege escalation or DoS.
However, it requires an attacker to attach a malicious USB device to
the target system.

Fixed status
patch is available but not merged
yet(https://lore.kernel.org/linux-wireless/10230673-8dbe-bf67-ba76-9f8cdc35faf3@gmail.com/T/#u)

CVE-2022-44034: char: pcmcia: scr24x_cs: Fix use-after-free in scr24x_fops

CVSS v3 score is 6.4 MEDIUM.

An issue was discovered in the Linux kernel through 6.0.6.
drivers/char/pcmcia/scr24x_cs.c has a race condition and resultant
use-after-free if a physically proximate attacker removes a PCMCIA
device while calling open(), aka a race condition between
scr24x_open() and scr24x_remove().

Fixed status
patch is available but it hasn't been merged
yet(https://lore.kernel.org/lkml/20220919101825.GA313940@ubuntu/).

CVE-2022-44032: char: pcmcia: cm4000_cs: Fix use-after-free in cm4000_fops

CVSS v3 score is 6.4 MEDIUM.

An issue was discovered in the Linux kernel through 6.0.6.
drivers/char/pcmcia/cm4000_cs.c has a race condition and resultant
use-after-free if a physically proximate attacker removes a PCMCIA
device while calling open(), aka a race condition between cmm_open()
and cm4000_detach().

Fixed status
patch is available but it hasn't been merged
yet(https://lore.kernel.org/lkml/20220919040701.GA302806@ubuntu/).

CVE-2022-44033: char: pcmcia: cm4040_cs: Fix use-after-free in reader_fops

CVSS v3 score is 6.4 MEDIUM.

An issue was discovered in the Linux kernel through 6.0.6.
drivers/char/pcmcia/cm4040_cs.c has a race condition and resultant
use-after-free if a physically proximate attacker removes a PCMCIA
device while calling open(), aka a race condition between
cm4040_open() and reader_detach().

Fixed status
patch is available but it hasn't been merged
yet(https://lore.kernel.org/lkml/20220919040457.GA302681@ubuntu/).

CVE-2022-3707: Double-free in split_2MB_gtt_entry when function
intel_gvt_dma_map_guest_page failed

CVSS v3 score is not provided.

A double free bug was found in the Intel GVT-g graphics driver in
drivers/gpu/drm/i915/gvt/gtt.c.
If intel_gvt_dma_map_guest_page() fails, it will call
ppgtt_invalidate_spt() to free spt value but the caller doesn't notice
that, the caller will free spt value again in the error path. It will
cause a system crash.

Intel GVT-g graphics driver was introduced in 4.8-rc1. Kernel 4.4
doesn't contain it.

Fixed status
Patch is available but it hasn't been merged
yet(https://lore.kernel.org/all/20221007013708.1946061-1-zyytlz.wz@163.com/).

* Updated CVEs

CVE-2022-3531: selftest/bpf: Fix memory leak in kprobe_multi_test

Fixed in the mainline.

Fixed status
mainline: [6d2e21dc4db3933db65293552ecc1ede26febeca]

CVE-2022-26373: Post-Barrier Return Stack Buffer Predictions (PBRSB)

4.14 was fixed this week.

stable/4.14: [7a4d2cba68731673c3ec89a1a5eee3a9af35ffa7,
48bfe6ca381525bd3b7e4d360a4695792ace4c55]
stable/4.19: [b6c5011934a15762cd694e36fe74f2f2f93eac9b,
b1c9f470fb724d3cfd6cf8fe4a70c2ec4de2e9f4]
stable/5.10: [509c2c9fe75ea7493eebbb6bb2f711f37530ae19,
1bea03b44ea2267988cce064f5887b01d421b28c]
stable/5.15: [7fcd99e889c0634f8275ae7a6b06aec4a22c8715,
5c5c77746ce1108833d1fda005598a749eaef2cb]
stable/5.18: [0abdbbd9ae9c81615836278d787a8c8dcd576c36,
fd2128cd778f46f5444967ed203b91120ebdda72]
stable/5.19: [f826d0412d80348aa22274ec9884cab0950a350b,
f6664a403f11c97929ebde920da1ec1c10438428]
stable/5.4: [f2f41ef0352db9679bfae250d7a44b3113f3a3cc,
b58882c69f6633dcebd66bdb38658f688aa52ec9]

CVE-2019-19338: Kernel: KVM: export MSR_IA32_TSX_CTRL to guest -
incomplete fix for TAA (CVE-2019-11135)

I added CVE-2019-19338.yml which hasn't been tracked on cip-kernel-sec.

This issue was introduced by commit e1d38b63acd8 ("kvm/x86: Export
MDS_NO=0 to guests when TSX is enabled") in 5.4-rc8.

Fixed status
mainline: [cbbaa2727aa3ae9e0a844803da7cef7fd3b94f2b,
c11f83e0626bdc2b6c550fc8b9b6eeefbd8cefaa,
  b07a5c53d42a8c87b208614129e947dd2338ff9c]
stable/4.19: [6a10f818a9adbe394eb36d223814e207e5121236]
stable/4.9: [0bc72dbb9dbc2dfa0f975f4b519ae91fa338aec8]

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


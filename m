Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C671AC433F5
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 01:44:44 +0000 (UTC)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com
 [209.85.161.45])
 by mx.groups.io with SMTP id smtpd.web10.3397.1639612232015238342
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Dec 2021 15:50:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=Qw0GDPA+;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.45,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f45.google.com with SMTP id
 w15-20020a4a9d0f000000b002c5cfa80e84so6398827ooj.5
        for <cip-dev@lists.cip-project.org>;
 Wed, 15 Dec 2021 15:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=3Bx+heVhRPJPUfMbQwqQybNxFiytcORjfIHeolPdWLE=;
        b=Qw0GDPA+8sYv+eSN8Ou5ybLePz8NznZ06W4p7ASxuWQIFokRvwscOGTg2TY/6Gpzb4
         Yhzj+PnFCNcBHqJjv56kY5AppU0W5r7n2UUAQGC4EO6wBoOD/uncLyGcL7SrBXCOrisA
         3q1vrfc4OdzxFpIbnVHhFXYx0t3fTameBwsnGh9hScC89Zddhse6CBQU3gTQBFuMaz8C
         TIuk/R5FXVeEtnc/nRr8/KwuO7wgWwr+sKxGBf5o/ErMJCE52l/lmfKSkfH/tHjjALwd
         6B8JcmIev+IouwTfhtzIao0G4NKfQJSyfq48clvpno5bIbcleTgA7khgMDoyxb5SAf47
         yRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3Bx+heVhRPJPUfMbQwqQybNxFiytcORjfIHeolPdWLE=;
        b=H+uSZgErwSpfRwhxG92dCEpZRgoVPsO1WvSaZIBwn7Mu3tupBFHHjMUjZkBKsim75v
         o2oubjRhvjKUxZYZdfrc4SKbmQQEiuDJVpKKi+IeeEMJVHeN4HHe8UbuCzbm3CmewaFS
         ZDmqdgKCld9JPFXJnZm+fH4uNQCj+ZaUc7kP+MoSRq1QhFgU/kg1D/IvitZV5TDh5aSz
         4uN4l0g+QgCW4odwcuff9WtqTdjMs5ycq14QnoSi8/ft6c9cKUZHHdcOqcp20UIDAUVI
         hQtkbIsAkX8tWVVx7TN/K43VZMY6wa2ANGOHpCSghHhoHSSKWNXhV6+LSgrQEtV8VMSp
         kr4w==
X-Gm-Message-State: AOAM531tF3MRT0AgVgtoVQzQCMQnlInHsEB65lG07JynpOk6tcGOI77P
	naevKXz2v/9Dglq9G9vVtmOlTKJpr7mWOTp9z4VzFWVGPr7uxg==
X-Google-Smtp-Source: 
 ABdhPJwcDVRYb+s1Plbd0txAGXy9qIIs3rCZoEUlfKTkOVV6GoRD26pe9QYxFi2LBcrvakB7o+rhRPYP+6kFSBLArIo=
X-Received: by 2002:a4a:e1a9:: with SMTP id 9mr9305880ooy.41.1639612230938;
 Wed, 15 Dec 2021 15:50:30 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 16 Dec 2021 08:49:55 +0900
Message-ID: 
 <CAODzB9rdc7X0n9nEi9JKzQmjuVbreaosKpHcn7YYpyGPSWkPQg@mail.gmail.com>
Subject: New CVE entries in this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 01:44:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7111

Hi !

It's this week's CVE report.

This week reported ten new CVEs and two of them aren't fixed in the
mainline yet.

* New CVEs

CVE-2021-0961: In quota_proc_write of xt_quota2.c, there is a possible
way to read kernel memory due to uninitialized data

CVSS v3 score is not provided

This bug is fixed in Android kernel. There is three commits to fix this bug.

https://android.googlesource.com/kernel/common/+/e113eb454e92
https://android.googlesource.com/kernel/common/+/60a4c35570d9
https://android.googlesource.com/kernel/common/+/4b05a506bda0

These commit modified net/netfilter/xt_quota2.c which is Android
specific source. So this CVE is Android specific bug. The mainline and
stable kernels aren't affected.

Fixed status

The mainline and stable kernels aren't affected.

CVE-2021-39648: usb: gadget: configfs: Fix use-after-free issue with udc_name

CVSS v3 score is not provided

4.4 kernel gadget_dev_desc_UDC_show() is bit different from later
kernel versions. However, it looks 4.4 also has same issue.

Fixed status

mainline: [64e6bbfff52db4bf6785fab9cffab850b2de6870]
stable/4.14: [6766064c794afeacc29b21fc09ea4dbe3cae1af3]
stable/4.19: [83b74059fdf1c4fa6ed261725e6f301552ad23f7]
stable/4.9: [225330e682fa9aaa152287b49dea1ce50fbe0a92]
stable/5.10: [a4b202cba3ab1a7a8b1ca92603931fba5e2032c3]
stable/5.4: [bcffe2de9dde74174805d5f56a990353e33b8072]

CVE-2021-39656: configfs: fix a use-after-free in __configfs_open_file

Bug introduced commit b0841ee was merged in 5.3-rc8. This commit isn't
backported to 4.4 so 4.4 isn't affected.

Fixed status

mainline: [14fbbc8297728e880070f7b077b3301a8c698ef9]
stable/4.14: [4769013f841ed35bdce3b11b64349d0c166ee0a2]
stable/4.19: [9123463620132ada85caf5dc664b168f480b0cc4]
stable/4.9: [6f5c47f0faed69f2e78e733fb18261854979e79f]
stable/5.10: [109720342efd6ace3d2e8f34a25ea65036bb1d3b]
stable/5.4: [73aa6f93e1e980f392b3da4fee830b0e0a4a40ff]

CVE-2021-39657: scsi: ufs: Correct the LUN used in
eh_device_reset_handler() callback

CVSS v3 score is not provided

Bug was fixed in 5.11-rc4. so mainline and stable kernels are already fixed.

Fixed status

mainline: [35fc4cd34426c242ab015ef280853b7bff101f48]
stable/4.14: [30f2a89f9481f851bc68e51a1e7114392b052231]
stable/4.19: [b397fcae2207963747c6f947ef4d06575553eaef]
stable/4.4: [a4cdbf4805bfed8f39e6b25f113588064d9a6ac5]
stable/4.9: [7bbac19e604b2443c93f01c3259734d53f776dbf]
stable/5.10: [2536194bb3b099cc9a9037009b86e7ccfb81461c]
stable/5.4: [97853a7eae80a695a18ce432524eaa7432199a41]

CVE-2021-4090: kernel: Overflow of bmval[bmlen-1] in
nfsd4_decode_bitmap function

CVSS v3 score is not provided

OOB write bug in nsfd. This bug was introduced by commit d1c263a
("NFSD: Replace READ* macros in nfsd4_decode_fattr()
") since 5.11-rc1 and fixed in 5.16-rc2. Before 5.11 kernels aren't
affected this issue.

Fixed status

mainline: [c0019b7db1d7ac62c711cda6b357a659d46428fe]
stable/5.15: [10c22d9519f3f5939de61a1500aa3a926b778d3a]

CVE-2021-4093: KVM: SVM: out-of-bounds read/write in sev_es_string_io

CVSS v3 score is not provided

OOB read/write bug in AMD SVM mode. This bug was introduced by commit
7ed9abf ("KVM: SVM: Support string IO operations for an SEV-ES guest")
which is merged since 5.11-rc1. Before 5.11 kernels aren't affected
this issue.

Fixed status

mainline: [95e16b4792b0429f1933872f743410f00e590c55]

CVE-2021-4095: KVM: NULL pointer dereference in kvm_dirty_ring_get()
in virt/kvm/dirty_ring.c

CVSS v3 score is not provided

This issues was introduced by commit 629b534 ("KVM: x86/xen: update
wallclock region") which is merged in 5.12-rc1-dontuse. Before
5.12-rc1-dontuse kernels aren't affectd this issue.
Patch is being reviewed.

Fixed status

Not fixed yet.

CVE-2021-3864: descendant's dumpable setting with certain SUID binaries

CVSS v3 score is not provided

This bug is able to write coredump file anyware. However, abusing this
bug, such as arbitrary code execution is required some program. The
PoC(https://www.openwall.com/lists/oss-security/2021/10/20/2).
There is two mitigation techniques are suggested. So, users follow
these mitigation technique is recommended.

Fixed status

Not fixed yet.

CVE-2021-4083: fget: check that the fd still exists after getting a ref to it

CVSS v3 score is not provided

UAF bug in fs/file.c it causes system crash, priviledge escalation.
The mainline and all stable kernels are aready fixed.

Fixed status

mainline: [054aa8d439b9185d4f5eb9a90282d1ce74772969]
stable/4.14: [98548c3a9882a1ea993a103be7c1b499f3b88202]
stable/4.19: [8bf31f9d9395b71af3ed33166a057cd3ec0c59da]
stable/4.4: [8afa4ef999191477506b396fae518338b8996fec]
stable/4.9: [a043f5a600052dc93bc3d7a6a2c1592b6ee77482]
stable/5.10: [4baba6ba56eb91a735a027f783cc4b9276b48d5b]
stable/5.15: [6fe4eadd54da3040cf6f6579ae157ae1395dc0f8]
stable/5.4: [03d4462ba3bc8f830d9807e3c3fde54fad06e2e2]

CVE-2021-39685: Linux Kernel USB Gadget buffer overflow

CVSS v3 score is not provided

Buffer overflow bug in USB gadget devices. An attacker can read and/or
write up to 65k of kernel memory.
It already fixed in mainline and all stable kernels.

Fixed status

mainline: [153a2d7e3350cc89d406ba2d35be8793a64c2038,
86ebbc11bb3f60908a51f3e41a17e3f477c2eaa3]
stable/4.14: [e7c8afee149134b438df153b09af7fd928a8bc24,
d8cd524ae4ec788011a14be17503fc224f260fe3]
stable/4.19: [13e45e7a262dd96e8161823314679543048709b9,
32de5efd483db68f12233fbf63743a2d92f20ae4]
stable/4.4: [93cd7100fe471c5f76fb942358de4ed70dbcaf35,
af21211c327c4703c7681fa7286c4d660682e413]
stable/4.9: [d2ca6859ea96c6d4c6ad3d6873a308a004882419,
e4de8ca013f06ad4a0bf40420a291c23990e4131]
stable/5.10: [7193ad3e50e596ac2192531c58ba83b9e6d2444b,
e4de8ca013f06ad4a0bf40420a291c23990e4131]
stable/5.15: [36dfdf11af49d3c009c711fb16f5c6e7a274505d,
6eea4ace62fa6414432692ee44f0c0a3d541d97a]
stable/5.4: [fd6de5a0cd42fc43810bd74ad129d98ab962ec6b,
9978777c5409d6c856cac1adf5930e3c84f057be]

* Updated CVEs

no updated CVEs.

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2020-26555: BR/EDR pin code pairing broken

No fix information

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


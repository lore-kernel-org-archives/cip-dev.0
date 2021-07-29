Return-Path: <SRS0=8G3/=MV=lists.cip-project.org=bounce+64572+6637+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315D6C4338F
	for <cip-dev@archiver.kernel.org>; Thu, 29 Jul 2021 01:19:41 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B1BD600D4
	for <cip-dev@archiver.kernel.org>; Thu, 29 Jul 2021 01:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7B1BD600D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id fHQ1YY4521723xarSuijiv05; Wed, 28 Jul 2021 18:19:40 -0700
X-Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
 by mx.groups.io with SMTP id smtpd.web12.3579.1627521572958870500
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jul 2021 18:19:39 -0700
X-Received: by mail-oi1-f176.google.com with SMTP id u25so6242368oiv.5
        for <cip-dev@lists.cip-project.org>; Wed, 28 Jul 2021 18:19:32 -0700 (PDT)
X-Gm-Message-State: WnypsmCfgx6bpocwsPBFtq4ix4520388AA=
X-Google-Smtp-Source: ABdhPJyIfVbjT7UyEpWKQ207qH2yyhhQxSxjGxEsb2aelcpitwcD/EALE0WCc5Keazpfwqivq7T4zFevEZro4EkS2u8=
X-Received: by 2002:a54:4806:: with SMTP id j6mr1556508oij.66.1627521572014;
 Wed, 28 Jul 2021 18:19:32 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?5biC5bed5q2j576O?= <masami.ichikawa@miraclelinux.com>
Date: Thu, 29 Jul 2021 10:18:56 +0900
Message-ID: <CAODzB9o8xwbKB7i1vDfQx0SSZa84+nPh+9kZDKj7LRvpO9R0mg@mail.gmail.com>
Subject: [cip-dev] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="Dc0Uxlmz3MQlqDpxNdaH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1627521580;
 bh=uDiK//jZdxrCcOCp1Ge6AbpfO65/yUA7oqEi6khnm54=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=UqwW638ujWnImy1X30uhMCqAHN0eMaaiCXMKPKSgbPUt4H9kXKg/IfbvJNr+AUKUN2S
 1W011ZYwdSAjxDqZeoIQZ/mRuxl/qMXFkNeMkWVgxQVOj4wwYthpbzqFV8lWR5MOd61yL
 DDH55x/agaLSTybmdlRPsWislAEn7eKpnsM=

--Dc0Uxlmz3MQlqDpxNdaH
Content-Type: text/plain; charset="UTF-8"

Hi !

Here is this week's CVE report.

* CVE short summary

** New CVEs

CVE-2021-3640: there is no fixed information as of 2021/07/29.

CVE-2021-37576: mainline and stable kernels are fixed. This CVE only
affects powerpc architecture.

** Updated CVEs

CVE-2021-31829: I fixed wrong security information.

CVE-2021-22543: added stable/4.19 fixed commit.

** Traking CVEs

CVE-2021-29256: not fiexd in mainline yet

CVE-2021-31615: not fiexd in mainline yet

CVE-2021-21781: v4.4 is not fixed as of 2021/07/29

CVE-2021-3655: v4.4 is not fixed as of 2021/07/29

CVE-2021-37159: mainline is not fixed as of 2021/07/29

* CVE detail

New CVEs

- CVE-2021-3640: Linux kernel: UAF in sco_send_frame function

Not fixed in mainline.

From email(https://www.openwall.com/lists/oss-security/2021/07/22/1)

-------------
2021-07-08: Bug reported to security@...nel.org and
linux-distros@...openwall.org
2021-07-09: CVE-2021-3640 is assigned
2021-07-22: 14 days of the embargo is over

One sad thing is that the bluez team is currently focused on fixing up the
CVE-2021-3573, which I failed to properly patched, and the patch for this
new is not yet fully discussed.
I hope the patch will be settled down and merged to the mainline in the
near future.
-------------

CVE-2021-37576: KVM guest to host memory corruption

This vulnerability only affects PowerPC architecture.

No CIP memeber uses PPC architecture.

Fixed status
mainline: [f62f3c20647ebd5fb6ecb8f0b477b9281c44c10a]
stable/4.19: [0493b10c06021796ba80cbe53c961defd5aca6e5]
stable/4.4: [1e90a673f6ee09c668fe01aa1b94924f972c9811]
stable/5.10: [c1fbdf0f3c26004a2803282fdc1c35086908a99e]

 Updated CVEs

CVE-2021-22543: KVM through Improper handling of VM_IO|VM_PFNMAP vmas
in KVM can bypass RO checks and can lead to pages being freed while
still accessible by the VMM and guest

Added stable/4.19 fixed commit.

v4.4 kernel gets pfn following way in hva_to_pfn(). It not uses
kvm_get_pfn(). hva_to_pfn_remapped() doesn't exist in v4.4 kernel.

            else if ((vma->vm_flags & VM_PFNMAP)) {
                    pfn = ((addr - vma->vm_start) >> PAGE_SHIFT) +
                            vma->vm_pgoff;


If v4.4 has same vulnerability, it'll need to write a patch by own.

CVE-2021-31829: Linux kernel protection of stack pointer against
speculative pointer arithmetic can be bypassed to leak content of
kernel memory

Fixed status
mainline: [f8be156be163a052a067306417cd0ff679068c97]
stable/4.19: [117777467bc015f0dc5fc079eeba0fa80c965149]
stable/5.10: [dd8ed6c9bc2224c1ace5292d01089d3feb7ebbc3]

There was wrong informaition so I updated it.
stable/5.10 is fixed but cip/5.10 is not fixed yet.

Currenty traking CVEs

CVE-2021-29256: The Arm Mali GPU kernel driver allows an unprivileged
user to achieve access to freed memory

Not fiexd in mainline yet

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

Not fiexd in mainline yet

CVE-2021-21781: Arm SIGPAGE information disclosure vulnerability

v4.4 is not fixed as of 2021/07/29

Fixed status
mainline: [9c698bff66ab4914bb3d71da7dc6112519bde23e]
stable/4.19: [80ef523d2cb719c3de66787e922a96b5099d2fbb]
stable/5.10: [7913ec05fc02ccd7df83280451504b0a3e543097]

CVE-2021-3655: missing size validations on inbound SCTP packets

According to cip-kernel-sec's scripts v4.4 is not fixed as of 2021/07/29

One of a patch 50619dbf8db77e98d821d615af4f634d08e22698 is included.
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/net/sctp?h=linux-4.4.y&id=48cd035cad5b5fad0648aa8294c4223bedb166dd

Fixed status
mainline: [0c5dc070ff3d6246d22ddd931f23a6266249e3db,
50619dbf8db77e98d821d615af4f634d08e22698,b6ffe7671b24689c09faa5675dd58f93758a97ae,
ef6c8d6ccf0c1dccdda092ebe8782777cd7803c9]
stable/4.19: [c7a03ebace4f9cd40d9cd9dd5fb2af558025583c,
dd16e38e1531258d332b0fc7c247367f60c6c381]
stable/4.9: [c7da1d1ed43a6c2bece0d287e2415adf2868697e]
stable/5.10: [d4dbef7046e24669278eba4455e9e8053ead6ba0,
6ef81a5c0e22233e13c748e813c54d3bf0145782]


CVE-2021-37159: hso_free_net_device in drivers/net/usb/hso.c in the
Linux kernel through 5.13.4 calls unregister_netdev without checking
for the NETREG_REGISTERED state, leading to a use-after-free and a
double free.

The mainline is not fixed as of 2021/07/29

Regards,


-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--Dc0Uxlmz3MQlqDpxNdaH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6637): https://lists.cip-project.org/g/cip-dev/message=
/6637
Mute This Topic: https://lists.cip-project.org/mt/84519830/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Dc0Uxlmz3MQlqDpxNdaH--

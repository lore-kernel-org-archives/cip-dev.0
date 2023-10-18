Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7C8CDB47E
	for <webhook@archiver.kernel.org>; Wed, 18 Oct 2023 23:20:46 +0000 (UTC)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
 by mx.groups.io with SMTP id smtpd.web11.15374.1697671240470335963
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Oct 2023 16:20:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=IYZ7C3E5;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.43, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6cd096727c6so590521a34.1
        for <cip-dev@lists.cip-project.org>; Wed, 18 Oct 2023 16:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1697671239; x=1698276039; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2n8HLkVNxkJOOmQ2820u4/ez87pUxJHJL37JL+pLEPs=;
        b=IYZ7C3E529touDTBXIJL6cnoB7CJrieS0CEgU1sVPyZyGdBL+6lLCpJwaei3PiG4Qq
         TmIL3/K1FwRtEPpp2qWpR6CX+9hoOUaXqbMcCvFVZDj87I4tTjAMiX0ZDX8l+sQFv7mQ
         clqH1wYQXaqJ8ZImC91r9FXkYaXJRFrLLs1BqKIMbwFFAq+I/sFTyr3fx5ZYnsNNl2rU
         X1Aa11a73/zEWECHZkvM65ykvtNxJ56IH40YYb8vJibXkAsM48uXyHawhacH0e3vy6bD
         th03CMR6kWDS5SfWkeKvVaIBNNfMjQYDu1FPI8CXo1HZhWz6KQsimq+sz/76rSufAXji
         edyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697671239; x=1698276039;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2n8HLkVNxkJOOmQ2820u4/ez87pUxJHJL37JL+pLEPs=;
        b=EE+FFBO6KJ6XxrvOhqAD7wzE7joi2ttpIzeYybGq6MWsEJbIPC1PaiGk3CtL2RMbyg
         cij4w/Dw1C1gJmVhk5+wTxo6KEd4wrp01KgwzfdYxrIhb5Xg19gMhCzr8zyV9dvcuD/v
         wtKXOmKHNbeOuK8WrCT+HA10VyMURXzfy6JHWmAO9UKbBCChuZzhkJM6InyFJUw02BMO
         g/u7DX6wNrFUy6y1j+IXdGvngVzntpa5SMNh25S/kltbkKS0gTIEi+HgoT7aywizYoWB
         5WPArwPEeUUOUsW+RGm9t/ui4t8RirrBPt9yzxVx803qG8wcQTm2JYgWMZNAfS5AZdIL
         Rqgw==
X-Gm-Message-State: AOJu0Yz/kk+9ZiRk2nSciMgGnS/2EMXzaX1aJPhkGhUI+cV8eIrjJboF
	gyQ6ytX4P/XIWjIdRi75KnpSOUglDoiuf1cCRcGlsxGGb+VSHL4+Vrk=
X-Google-Smtp-Source: AGHT+IGv89smhOUmRANaGGIk9cqPSLCp1PvkiqXJ2j9NDc/h8ZDKc0kavceBggriNT6Oqj0X0vBLSjIoX4GbYYBBpEE=
X-Received: by 2002:a05:6870:3d92:b0:1e9:fb1e:870f with SMTP id
 lm18-20020a0568703d9200b001e9fb1e870fmr1042240oab.37.1697671239407; Wed, 18
 Oct 2023 16:20:39 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 19 Oct 2023 08:20:03 +0900
Message-ID: <CAODzB9qbOzGf1K6qSMAEq-OSWfKXTnZ8wT3pKTyNomxfe032_Q@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Oct 2023 23:20:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13403

Hi !

It's this week's CVE report.

This week reported 6 new CVEs and 1 updated CVE.

* New CVEs

CVE-2023-5178: nvmet-tcp: Fix a possible UAF in queue intialization setup

CVSS v3 score is not provided.

A logical bug in the NVMe-oF/TCP subsystem. A malicious actor, with
the ability to send messages to the NVMe-oF/TCP server (either LAN or
WAN), can cause a use-after-free and a double free, which may lead to
remote kernel code execution.

Fixed status
Patch is available
(https://lore.kernel.org/all/20231004173226.5992-1-sj@kernel.org/T/)
but it has not merged into the mainline yet as of 2023-10-16.

CVE-2023-40791: crypto, cifs: fix error handling in extract_iter_to_sg()

CVSS v3 score is not provided.

extract_user_to_sg in lib/scatterlist.c in the Linux kernel before
6.4.12 fails to unpin pages in a certain situation, as demonstrated by
a WARNING for try_grab_page.

Introduced by commit 0185846 ("netfs: Add a function to extract an
iterator into a scatterlist") in 6.3-rc1. Fixed in 6.5-rc6.
LTS kernels are not affected.

Fixed status
mainline: [f443fd5af5dbd531f880d3645d5dd36976cf087f]

CVE-2023-45862: USB: ene_usb6250: Allocate enough memory for full object

CVSS v3 score is not provided.

An issue was discovered in drivers/usb/storage/ene_ub6250.c for the
ENE UB6250 reader driver in the Linux kernel before 6.2.5. An object
could potentially extend beyond the end of an allocation.

Fixed status
mainline: [ce33e64c1788912976b61314b56935abd4bc97ef]
stable/4.14: [26f31c6e1389c23a1b822a61c59d5d1f357cb478]
stable/4.19: [cef5e33d8b893891817236db819982f87943e8fd]
stable/5.10: [961f93d63da72f5fcaa6793fb2dcbc995c119a8e]
stable/5.15: [7e902b949600c51c94d06b137f874126a27e6557]
stable/5.4: [da4e715a466ca982d4584da21ea385f28ca79ce6]
stable/6.1: [ff542083b105c9c72d83899d3f74eeec354f808e]

CVE-2023-45863: kobject: Fix slab-out-of-bounds in fill_kobj_path()

CVSS v3 score is not provided.

An issue was discovered in lib/kobject.c in the Linux kernel before
6.2.3. With root access, an attacker can trigger a race condition that
results in a fill_kobj_path out-of-bounds write.

All LTS kernels are affected. It is fixed in 6.3-rc1.

Fixed status
mainline: [3bb2a01caa813d3a1845d378bbe4169ef280d394]
stable/5.15: [89a0079049f5568268d75c8cdf28bec0e2553e23]
stable/6.1: [fe4dd80d58ec5633daf5d50671d1341f738508bf]

CVE-2023-45871: igb: set max size RX buffer when store bad packet is enabled

CVSS v3 score is not provided.

An issue was discovered in drivers/net/ethernet/intel/igb/igb_main.c
in the IGB driver in the Linux kernel before 6.5.3. A buffer size may
not be adequate for frames larger than the MTU.

It was introduced by commit 89eaefb ("igb: Support RX-ALL
featureflag.") in 3.4-rc1. Fixed in 6.6-rc1.

Fixed status
mainline: [bb5ed01cd2428cd25b1c88a3a9cba87055eb289f]
stable/4.14: [017d5c8eef06178e4148db273df03b7ad9eeb5bc]
stable/4.19: [981d0bc43e8d5482294432677e80a1d15f4b790d]
stable/5.10: [3e39008e9e3043663324f0920a5d6ebfa68cc92a]
stable/5.15: [be7353af5b35c8f4a11573a38b997f74f8c2ae4b]
stable/5.4: [c2ad60ed38b872aa971408b8b8eaad7a91501b37]
stable/6.1: [d2e906c725979c39ebf120a189e521ceae787d26]
stable/6.5: [dad92377fc6e012e481c6f4a75e32e48fe2777db]

CVE-2023-45898: ext4: fix slab-use-after-free in ext4_es_insert_extent()

CVSS v3 score is not provided.

The Linux kernel before 6.5.4 has an es1 use-after-free in
fs/ext4/extents_status.c, related to ext4_es_insert_extent.

Introduced by commit 2a69c45 ("ext4: using nofail preallocation in
ext4_es_insert_extent()") in 6.5-rc1. Fixed in 6.6-rc1.
LTS kernels are not affected.

Fixed status
mainline: [768d612f79822d30a1e7d132a4d4b05337ce42ec]
stable/6.5: [c15bf3330a9e3c01b23e59899a6a02432a62ddc3]

* Updated CVEs

CVE-2023-31085: BUG: divide error in ubi_attach_mtd_dev

Fixed in the mainline and all stable kernels.
It was introduced by commit 801c135 ("UBI: Unsorted Block Images") in
2.6.22-rc1. Fixed in 6.6-rc5.

Fixed status
mainline: [017c73a34a661a861712f7cc1393a123e5b2208c]
stable/4.14: [ef7a4c97a85ab1bff7abc98f885678bd33bb4881]
stable/4.19: [a0d71e9e61da8a85a46774c67549739e28fda795]
stable/5.10: [a5f643ab11631095c60c9852705220edf1659d6f]
stable/5.15: [0ea2a63497333019bd2931975ed489216b365755]
stable/5.4: [c6d358387632a6d45b3e5d4c310cfec1bde59423]
stable/6.1: [91aeb418b9175d09fc858f0fdf01988cbf990c5d]
stable/6.5: [87b9858e404069817cd4b31830e0a1b9b3d183c4]

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


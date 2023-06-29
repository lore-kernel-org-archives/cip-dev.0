Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2D7EB64DC
	for <webhook@archiver.kernel.org>; Thu, 29 Jun 2023 00:27:25 +0000 (UTC)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
 by mx.groups.io with SMTP id smtpd.web11.385.1687998440312442905
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jun 2023 17:27:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=dqdgPsbz;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.178, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3a0457d6b77so117714b6e.0
        for <cip-dev@lists.cip-project.org>; Wed, 28 Jun 2023 17:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1687998439; x=1690590439;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7phuWugCDDJ8kCg2w8UJ41vN9RjsLholc3+/CGFJYAY=;
        b=dqdgPsbzLl6JG8GiHm/LPI0yRKG2EzExKjlSx3rhdLxe9MeOc4pjdfktfJAwlz3tbG
         gLn3N5SRrmDXV0oykbNVd3RPGqp5u+rg2YNih9EbOV6rwyDHp702FdW901InKemw1+Uk
         sezZunUYFLrimEYNoPxa/rLJC75IhC2qqpetJB1fSQZ9ThEjbpebcKfvpbn5CYctZRo8
         6sQDBdIwsGnEjMGZ1IqyABKuMtDFj/ORCk7cgrkiQQdleeri0oAWUb6ZWmP/C+W/I3Mq
         +2dYknwzdXsbze11utMTuxSqytNUXFfQs5y5ZjKHHXbtZNEY/v6PJSUctcvYgVdaas2A
         nR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687998439; x=1690590439;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7phuWugCDDJ8kCg2w8UJ41vN9RjsLholc3+/CGFJYAY=;
        b=VzPd9fgW2mK7tIJkK1oLK/2cxvJ8KtsQMiR5rjWZ1anhDd8WzrH/Bw+TnS0sXN92fJ
         g+UWN4U/PXG4yCnd1771mVurARR2tkhOQRN3X4AUP9+HNffGDI84A8PX2kGcqZJ9iJEx
         /JEkPH7eK8gJBILnpzkG/IldRMK/AAqToprHZcHXBW9RqN38LAIXqkGiZMLNfdDxhzBc
         VD99NrBEIr8vK2t5NlwJd6QYRXVnssNCxEZdk6hMGj+VFH9V0i0AP+lE2MJfhXMK13cK
         vbWX33at0Ts71gPaWO9IyFu9GAvEX9kfwyaHXzMkjye8PnAo9jl1PtNNavHULyVqxriU
         ierQ==
X-Gm-Message-State: AC+VfDwHho7F3gOHDf934+5+DW+4fNlJ2AViir2AI8SleF60uZWVF2aB
	xX3Nsw58UniLp81Daj+pO9NL/eByJh7bsIPx9M5EFRImfTBTr/tqetA=
X-Google-Smtp-Source: ACHHUZ5Y5pXy/0ga/IhKtDvh4H2wJjBeigIh5ekd5jRKKXkr767Gv2v28qtXerv9OPshpph9uZBPMnGRGsYo9dNqSzE=
X-Received: by 2002:a05:6808:110:b0:3a3:65d6:d76 with SMTP id
 b16-20020a056808011000b003a365d60d76mr3140156oie.42.1687998438691; Wed, 28
 Jun 2023 17:27:18 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 29 Jun 2023 09:26:42 +0900
Message-ID: <CAODzB9psY93Rnooj34fP+gWd18mHEMK2FUmtG+2xNnLSqLtKDw@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Jun 2023 00:27:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12160

Hi !

It's this week's CVE report.

This week reported 10 new CVEs and 3 updated CVEs.

* New CVEs

CVE-2023-3357: NULL pointer dereference bug was found in the AMD
Sensor Fusion Hub driver

CVSS v3 score is not provided.

It didn't check dma_clloc_coherent()'s return value in the
amd_sfh_hid_client_init(). If it returns NULL, NULL pointer
dereference bug occurs.
This bug was introduced by commit 4b2c53d ("SFH:Transport Driver to
add support of AMD Sensor Fusion Hub (SFH)") in 5.11-rc1 so that
before 5.11 kernels aren't affected.

Fixed status
mainline: [53ffa6a9f83b2170c60591da1ead8791d5a42e81]
stable/5.15: [d238f94b2b61c77dd60db820aa683ff6a58c1543]
stable/6.1: [8a37cf11dc78b71a5e0ef18aa33af41415b5ca38]

CVE-2023-3358: NULL pointer dereference bug was found in the
Integrated Sensor Hub driver

CVSS v3 score is not provided.

It didn't check dev->ishtp_dma_tx_map is NULL or not in the
ishtp_cl_get_dma_send_buf(). If it is NULL, a NULL pointer dereference
bug will occur.
This bug was introduced by commit 3703f53 ("HID: intel_ish-hid: ISH
Transport layer") in 4.9-rc1 so 4.4 isn't affected.

Fixed status
mainline: [b3d40c3ec3dc4ad78017de6c3a38979f57aaaab8]
stable/4.14: [eaa86c4ae77e9c6c28e3c417539ebbee987be0c9]
stable/4.19: [cc906a3a4432da143ab3d2e894f99ddeff500cd3]
stable/5.10: [7b4516ba56f1fcb13ffc91912f3074e28362228d]
stable/5.15: [c4cb73febe35f92f7a401f4cbc84f94c764732a9]
stable/5.4: [97445814efcd0ba7a347b1463ba86bdf3cdc65aa]
stable/6.1: [9a65e90179ba06eb299badc3e4dc4aa2b1e35af3]

CVE-2023-3359: NULL pointer dereference bug was found in the Broadcom
NVRAM driver

CVSS v3 score is not provided.

It didn't check kzalloc() return value in the brcm_nvram_parse() if it
returns NULL, NULL pointer dereference bug will occur.
This bug was introduced by commit 6e977ea ("nvmem: brcm_nvram: parse
NVRAM content into NVMEM cells") in 5.18-rc1 so that before 5.18
kernels aren't affected.

Fixed status
mainline: [b0576ade3aaf24b376ea1a4406ae138e2a22b0c0]
stable/6.1: [f5249bbae0e736d612d2095ad79dc1389b3e89b5]

CVE-2023-3338: NULL Pointer Dereference in DECnet

CVSS v3 score is not provided.

A NULL pointer dereference bug was found in the DECnet subsystem that
will cause a system crash or privilege escalation.
The DECnet subsystem has been removed in 6.1-rc1 and stable kernels.

Fixed status
mainline: [1202cdd665315c525b5237e96e0bedc76d7e754f]
stable/4.14: [975840f8dec3c1e6a6b28a387bb7cf55a4775e18]
stable/4.19: [3e77bbc87342841db66c18a3afca0441c8c555e4]
stable/5.10: [1c004b379b0327992c1713334198cf5eba29a4ba]
stable/5.15: [2a974abc09761c05fef697fe229d1b85a7ce3918]
stable/5.4: [6b1203ae83c3d07bad90b6f38ebf2e4d5998dd28]

CVE-2023-1206: hash collisions in the IPv6 connection lookup table

CVSS v3 score is not provided.

A hash collision bug was found in the IPv6 connection lookup table. It
will cause a DoS.

Fixed status
Not fixed yet

CVE-2023-3090: ipvlan:Fix out-of-bounds caused by unclear skb->cb

CVSS v3 score is not provided (NIST).
CVSS v3 score is 7.8 HIGH (CNA).

A heap out-of-bounds write vulnerability in the Linux Kernel ipvlan
network driver can be exploited to achieve local privilege escalation.
The out-of-bounds write is caused by missing skb->cb initialization in
the ipvlan network driver. The vulnerability is reachable if
CONFIG_IPVLAN is enabled.
All stable kernels and CIP kernels have been fixed.

Fixed status
mainline: [90cbed5247439a966b645b34eb0a2e037836ea8e]
stable/4.14: [8747ec637300f1212a47a9f15e2340cfe4dcbb9c]
stable/4.19: [b36dcf3ed547c103acef6f52bed000a0ac6c074f]
stable/5.10: [f4a371d3f5a7a71dff1ab48b3122c5cf23cc7ad5]
stable/5.15: [7c8be27727fe194b4625da442ee2b854db76b200]
stable/5.4: [1aa872e967f2017041bb2284479b3c6ce8d121b5]
stable/6.1: [610a433810b277b3b77389733c07d22e8af68de2]
stable/6.3: [3cd16c6a6a6b68bba02fbbc54b9906f44640ffde]

CVE-2023-3355: Missing return value check from kmalloc

CVSS v3 score is not provided.

A NULL pointer dereference flaw was found in the Linux kernel's
drivers/gpu/drm/msm/msm_gem_submit.c code in the submit_lookup_cmds
function, which fails because it lacks a check of the return value of
kmalloc(). This issue allows a local user to crash the system.

This bug was introduced by commit 20224d7 ("drm/msm/submit: Move
copy_from_user ahead of locking bos") in 5.11-rc1. Before 5.11 kernels
aren't affected.

Fixed status
mainline: [d839f0811a31322c087a859c2b181e2383daa7be]
stable/5.15: [436fb91cadb82da0b0b114baa4fc3b5ef7e6d557]
stable/6.1: [31c4251a20fd7addc1bf4fe801f95f9ba1b38990]

CVE-2023-3389: io_uring: hold uring mutex around poll removal

CVSS v3 score is not provided (NIST).
CVSS v3 score is 5.5 MEDIUM (CNA).

A use-after-free vulnerability in the Linux Kernel io_uring subsystem
can be exploited to achieve local privilege escalation. Racing a
io_uring cancel poll request with a linked timeout can cause a UAF in
a hrtimer.

The io_uring feature was introduced in 5.1 so kernel 4.x are not affected.

Fixed status
mainline: [9ca9fb24d5febccea354089c41f96a8ad0d853f8]
stable/5.10: [4716c73b188566865bdd79c3a6709696a224ac04]

CVE-2023-3390: netfilter: nf_tables: incorrect error path handling
with NFT_MSG_NEWRULE

CVSS v3 score is not provided (NIST).
CVSS v3 score is 7.8 HIGH (CNA).

A use-after-free vulnerability was found in the Linux kernel's
netfilter subsystem in net/netfilter/nf_tables_api.c. Mishandled error
handling with NFT_MSG_NEWRULE makes it possible to use a dangling
pointer in the same transaction causing a use-after-free
vulnerability. This flaw allows a local attacker with user access to
cause a privilege escalation issue.

Patch to 4.14, 4.19, 5.4, and 5.10 were failed.
https://lore.kernel.org/stable/2023061939-sprout-jujitsu-b6a0@gregkh/
https://lore.kernel.org/stable/2023061937-spiritism-reliably-6082@gregkh/
https://lore.kernel.org/stable/2023061935-renewed-granite-7529@gregkh/
https://lore.kernel.org/stable/ZJAT0Ci5+sT+AQfm@calendula/


Fixed status
mainline: [1240eb93f0616b21c675416516ff3d74798fdc97]
stable/5.15: [44ebe988cb38e720b91826f4d7c31692061ca04a]
stable/6.1: [4aaa3b730d16c13cc3feaa127bfca1af201d969d]
stable/6.3: [bdace3b1a51887211d3e49417a18fdbd315a313b]

CVE-2023-3397: fs/jfs: Add a mutex named txEnd_lmLogClose_mutex to
prevent a race condition between txEnd and lmLogClose functions

CVSS v3 score is not provided.

A race condition bug was found between lmLogClose() and txEnd() which
causes a slab use-after-free bug.

Fixed status
Patch is available but it hasn't been merget
yet(https://lore.kernel.org/lkml/20230515095956.17898-1-zyytlz.wz@163.com/).

* Updated CVEs

CVE-2022-1015: OOB access bug in netfilter

Stable 5.10 was fixed.

Fixed status
mainline: [6e1acfa387b9ff82cfc7db8cc3b6959221a95851]
stable/5.10: [9e8d927cfa564e5a00cd287bd66fac6d45f0af39]
stable/5.15: [1bd57dea456149619f3b80d67eee012122325af8]
stable/5.16: [2c8ebdaa7c9755b85d90c07530210e83665bad9a]
stable/5.17: [afdc3f4b81f0ec9f97f0910476af4620a2481a6d]

CVE-2023-2124: OOB access in the Linux kernel's XFS subsystem

Stable 5.4 was fixed.

Fixed status
mainline: [22ed903eee23a5b174e240f1cdfa9acf393a5210]
stable/5.10: [0e98a97f772f2ffcee8ced7a49b71e72916e0aa1]
stable/5.15: [6cfe9ddb6aa698464fa16fb77a0233f68c13360c]
stable/5.4: [c87439055174b31c51a89f8d66af2600033c664d]
stable/6.1: [a2961463d74f5c86a8dda3b41c484c28ccc4c289]
stable/6.3: [69ebe82c73f4f9f4b49ed3b35ce347af20716d0a]

CVE-2023-34255: xfs: verify buffer contents when we skip log replay

Stable 5.4 was fixed.

mainline: [22ed903eee23a5b174e240f1cdfa9acf393a5210]
stable/5.10: [0e98a97f772f2ffcee8ced7a49b71e72916e0aa1]
stable/5.15: [6cfe9ddb6aa698464fa16fb77a0233f68c13360c]
stable/5.4: [c87439055174b31c51a89f8d66af2600033c664d]
stable/6.1: [a2961463d74f5c86a8dda3b41c484c28ccc4c289]
stable/6.3: [69ebe82c73f4f9f4b49ed3b35ce347af20716d0a]

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


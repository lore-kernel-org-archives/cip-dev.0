Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8185C5479D
	for <webhook@archiver.kernel.org>; Thu, 12 Jan 2023 00:21:43 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.web10.42124.1673482902293364248
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Jan 2023 16:21:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=2BWXB4K9;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.46, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f46.google.com with SMTP id i26-20020a9d68da000000b00672301a1664so9763884oto.6
        for <cip-dev@lists.cip-project.org>; Wed, 11 Jan 2023 16:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PdrGM4Q9F/SLKe+IWufESKb2HvwtMeQ9axF5nXz6Yzo=;
        b=2BWXB4K9xlRNZO7b0SuMGgYLnEMkyXxRbt6s7wt4gRoyqQ2KX8P0ULHBkAKEji4/US
         TEx+jzSNi1XCTaun1Un9VDYQAseomR69xa0Pdf5RDgEg4gB1MFlVh32F4tqGg/54dFIT
         wnTtCkInJuFtMxO/zajt5SzSyuQWBkXTpeZDQwMEm6/+dZtESNqYTSLuE9pwQJZEuc2N
         FF7Ow7Iyf3rAGC4Gb+WMwiZjYP+NxfhEvsof1eX7RyRMZcKe4YPep9Sex9AedVfPmbIu
         hUDyIE1Uk6xC+U8S64DB6Fxi7NPb+6wJnvvv9xp+AROEv8MOeTTP9nRULEJc8mEYaJyo
         ArUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PdrGM4Q9F/SLKe+IWufESKb2HvwtMeQ9axF5nXz6Yzo=;
        b=gFGiXXmtL0TC8yPkEcWDaKyX8wz819ysF6sGtr60sPa3drTVFTveweORlY8Hxr5MrP
         yL2EFoNYOb9CfXVXFQhJRxVSCLyTM66ScUhE5vF3Two8aOug4ZmMN176+R/CqqAjeXBX
         qfbJyE246QqVsiCWW+ceGJJT0eWPyo4KkSqWXVVhL6H6L9IZZ3nl2pndpcLZq4sxu+hG
         qjgBsuHXHTaLWPugkAiPP/BuNI9QyPftQMQvgXfjVc0joytMa9EH2gaIaEBRQeTk7oSs
         j1AdWy7JN5OUp/hI8u0LXHzv7Jdf3Z0zRF0Beag4aATSeIsu5eT5irmCmtoUDXRf5w8T
         vvcQ==
X-Gm-Message-State: AFqh2kpoRGa3nltdEVxiVkStl2BAXszMay5XqJzjlrTKhRnDrZc16Rd4
	l2vmrZqqAaPu4vEB4xvaVSRVJ1FeCFCxwMX6nJFAVv2KsLauhmli
X-Google-Smtp-Source: AMrXdXs7+ej1JqGOrgoGPKV4frpoqaAOp/d2uLkaVBWmmGyOY7KZsOnJvjy0W5hMyvJv6JhcHqUzX/KWdJYIHfrItuw=
X-Received: by 2002:a9d:4817:0:b0:672:2e67:4268 with SMTP id
 c23-20020a9d4817000000b006722e674268mr4682844otf.223.1673482901151; Wed, 11
 Jan 2023 16:21:41 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 12 Jan 2023 09:21:05 +0900
Message-ID: <CAODzB9qVcr4Z81QJjDe8zkoFK+CnT-K-o9H6GiWMU9wxHPt3EA@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Jan 2023 00:21:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10344

Hi !

It's this week's CVE report.

This week reported 4 new CVEs and 3 updated CVEs.

* New CVEs

CVE-2023-0047: Out of memory in local cgroup's memory may cause denial
of service outside its area

CVSS v3 score is not provided

According to the Red Hat bugzilla, "A Linux Kernel flaw found in
memory management. If allocation failure happens in
pagefault_out_of_memory with VM_FAULT_OOM,
then it can lead to memory overflow when many tasks trigger this. An
issue may cause multi-tenant denial of service (memory overflow).
It was reported that a malicious workload may be allowed to OOM-kill
random other workloads on the same node.".

kernel 4.4 looks affected by this vulnerability.

Fixed status
mainline: [60e2793d440a3ec95abb5d6d4fc034a4b480472d]
stable/4.14: [bed55513692e0dc720f02ad7da3e528c55e0b663]
stable/4.19: [d508b70eaa8d6d994c289b757c0ca0355d4dbe29]
stable/4.9: [973b61a5f3ba6690624d109a68cca35d0348b91f]
stable/5.10: [1d457987366f7a92d03e03df80f9a63040133233]
stable/5.15: [c15aeead2488b3b28db6863f9f2ba2338e3c9838]
stable/5.4: [66938ba1285778634276a4b4028de367d7f1e8c2]

CVE-2023-0122: NVME driver: null pointer dereference in
drivers/nvme/target/auth.c

CVSS v3 score is not provided

A NULL pointer dereference in nvmet_setup_auth. This bug was
introduced by commit db1312dd ("nvmet: implement basic In-Band
Authentication") in 6.0-rc1.
4.x and 5.x kernels are not affected by this vulnerability.

Fixed status
mainline: [da0342a3aa0357795224e6283df86444e1117168]

CVE-2022-4696: io_uring: add missing item types for splice request

CVSS v3 score is not provided (NIST)
CVSS v3 score is 7.8 (CNA)

There exists a use-after-free vulnerability in the Linux kernel
through io_uring and the IORING_OP_SPLICE operation.
If IORING_OP_SPLICE is missing the IO_WQ_WORK_FILES flag, which
signals that the operation won't use current->nsproxy,
so its reference counter is not increased. This assumption is not
always true as calling io_splice on specific files will call the
get_uts
function which will use current->nsproxy leading to invalidly
decreasing its reference counter later causing the use-after-free
vulnerability.

fs/io_wq.[hc] are not present in 5.4.

Fixed status
mainline: [44526bedc2ff8fcd58552e3c5bae928524b6f13c]
stable/5.10: [75454b4bbfc7e6a4dd8338556f36ea9107ddf61a]

CVE-2023-0210: ksmbd: check nt_len to be at least CIFS_ENCPWD_SIZE in
ksmbd_decode_ntlmssp_auth_blob

CVSS v3 score is not provided

There is a heap overflow bug in ksmbd_decode_ntlmssp_auth_blob in
which nt_len can be less than CIFS_ENCPWD_SIZE

This vulnerability was introduced by commit e2f3448 ("cifsd: add
server-side procedures for SMB3") in 5.15-rc1.
Less than 5.15 kernels are not affected by this issue.

Fixed status
mainline: [797805d81baa814f76cf7bdab35f86408a79d707]

* Updated CVEs

CVE-2022-36280: An out-of-bounds(OOB) memory access vulnerability was
found in vmwgfx driver in drivers/gpu/vmxgfx/vmxgfx_kms.c

stable 6.0 and 6.1 were fixed.

Fixed status
mainline: [4cf949c7fafe21e085a4ee386bb2dade9067316e]
stable/6.0: [4d54d11b49860686331c58a00f733b16a93edfc4]
stable/6.1: [622d527decaac0eb65512acada935a0fdc1d0202]

CVE-2022-41218: media: dvb-core: Fix UAF due to refcount races at releasing

stable 6.0 and 6.1 were fixed.

Fixed status
mainline: [fd3d91ab1c6ab0628fe642dd570b56302c30a792]
stable/6.0: [55870fc9e45faa9a65860bcd6b0f8ca8c99afe44]
stable/6.1: [530ca64b44625f7d39eb1d5efb6f9ff21da991e2]

CVE-2022-3707: Double-free in split_2MB_gtt_entry when function
intel_gvt_dma_map_guest_page failed

This bug was introduced by commit b901b252 ("drm/i915/gvt: Add 2M huge
gtt support") in 4.19-rc1.

Fixed status
mainline: [4a61648af68f5ba4884f0e3b494ee1cabc4b6620]

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


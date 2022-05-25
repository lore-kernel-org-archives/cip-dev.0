Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAE3C433EF
	for <webhook@archiver.kernel.org>; Wed, 25 May 2022 23:12:49 +0000 (UTC)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42])
 by mx.groups.io with SMTP id smtpd.web10.13518.1653520367534524607
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 May 2022 16:12:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=z2lD8MRU;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.42,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f42.google.com with SMTP id
 h9-20020a056830400900b0060b03bfe792so8796744ots.12
        for <cip-dev@lists.cip-project.org>;
 Wed, 25 May 2022 16:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=IlQ1oy6TMl+U8ZiUAVmzUzufzpaWRt+N8k7KWzHtk68=;
        b=z2lD8MRUxgonDbo/tySrJ/NDrG8xRvYuCvoMimyX4d8EY+G820P0R2SzxcUXtEGOum
         UQFJmL4NWJji2vj+zPnELzotGZf668jDXJ1rSn3fXD3t4xlojV4tNjGonaq2wXNAfRj+
         ZkmXKMeblAglwQUPpfPlbJ9femjfYwt3cRpSkWFTNseMbtiMOfgOZqdQ5f+FW09H+flf
         ej48xNz0jSCW2aZCCuvYbDT2JMe0K8gtNW/1ep9OEv+Npc+98RIWhsl8k57bni3sN6Wt
         VW7Y3bu8Bz8ORGB4AkIwA0ZLSROcbtriUotutLDeo0RDwkHXSNFEeCidN7KLW9vOalXB
         w7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IlQ1oy6TMl+U8ZiUAVmzUzufzpaWRt+N8k7KWzHtk68=;
        b=pXASHQKomss/YCmr0D1Op/NX5AEagiQKtWQ/h1CVHmLLswHiLhlabONy+voxw9elv0
         MnR7ACjpajcNJGccSVX92qStbM/O4UazNZYHZhE/tPVYtmMFCXxinu7mUsLD/Esen51i
         TCBJx6BkfJORPgXixZc/KJ8+0c/vm0To4gIjJHk8Dsw48BDg7Zi++IEFktD9Bk36IJ5W
         Kkl9WOZVttOAJu3HoZ5LDpnt+/8zPgV+iySAc2pOnS2+Y9VwX9FWvoZQjCSDIUI0QpwO
         yq2VgSyIhw4Umo0P4B3Iv1Q+oj7jMvbyauRcawLFqm2h4OU4n2YzX06v3QNbEUkzAlP4
         k6wA==
X-Gm-Message-State: AOAM532kK+TmsBDm2ucIHhfoGoQu/qiN9DrmeK440z//8RsSWwAdChV2
	7jDSGn9+jFqBHyyqmge6CangWaWz6QBqWHHu0A01GsER8myOWg==
X-Google-Smtp-Source: 
 ABdhPJx/l+EDyikTJG83GBXeOQONmo9FxyPTk5Fs4vDC+9Hv7/IRzxMwdMuEyA0847RJ1tMtS5LvrXXaqc8c+1tNLqc=
X-Received: by 2002:a05:6830:1ad4:b0:60b:2933:cb7f with SMTP id
 r20-20020a0568301ad400b0060b2933cb7fmr3417358otc.336.1653520365413; Wed, 25
 May 2022 16:12:45 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 26 May 2022 08:12:09 +0900
Message-ID: 
 <CAODzB9qO1T12J-6Z2jHpUQN9-k7n5zeeYA5JnR_-NWZ6tQxLUQ@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 May 2022 23:12:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8439

Hi !

It's this week's CVE report.

This week reported 6 new CVEs and 3 updated CVEs.

* New CVEs

CVE-2022-1729: perf: Fix sys_perf_event_open() race against self

CVSS v3 score is not assigned.

Introduced by commit f63a8da ("perf: Fix event->ctx locking") that was
merged in 4.0-rc1.
This race condition bug allows a local user privilege escalation.
To set kernel.perf_event_paranoid >= 3, effectively rendering the
vulnerability harmless.

The mainline and stable kernels were fixed.

Fixed status
mainline: [3ac6487e584a1eb54071dbe1212e05b884136704]
stable/4.14: [dee63319e2d1abd5d37a89de046ccf32ca8a8451]
stable/4.19: [6cdd53a49aa7413e53c14ece27d826f0b628b18a]
stable/4.9: [a1466528d8ae5d9a3bb29781f0098fa3476e9e1c]
stable/5.10: [3ee8e109c3c316073a3e0f83ec0769c7ee8a7375]
stable/5.15: [e085354dde254bc6c83ee604ea66c2b36f9f9067]
stable/5.17: [22fb2974224c9836eeaf0d24fdd481fcdaa0aea8]
stable/5.4: [dd0ea88b0a0f913f82500e988ef38158a9ad9885]

CVE-2022-1789: KVM: x86/mmu: fix NULL pointer dereference on guest INVPCID

CVSS v3 score is not assigned.

Null pointer dereference bug was found in kvm_mmu_invpcid_gva() in
arch/x86/kvm/mmu/mmu.c.
4.4 is vulnerable too. Patch needs to be modified to apply 4.4.

Fixed status
mainline: [9f46c187e2e680ecd9de7983e4d081c3391acc76]

CVE-2021-33135: A vulnerability in x86/SGX driver which will allow a
local attacker to do local DoS.

CVSS v3 score is 5.5 MEDIUM.

Uncontrolled resource consumption in the Linux kernel drivers for
Intel(R) SGX may allow an authenticated user to potentially enable
denial of service via local access.

This bug was introduced by the commit 1728ab5 (x86/sgx: Add a page
reclaimer) was merged in 5.11-rc1. Earlier than 5.11-rc1 kernels
aren't affected by this vulnerability.

Fixed status
mainline: [08999b2489b4c9b939d7483dbd03702ee4576d96]
stable/5.15: [ce91f0f023adfc239b44261f6dccb4a883d44d92]

CVE-2022-1786: io_uring: always use original task when preparing req identity

CVSS v3 score is not assigned.

A freeing memory bug was found in the io_uring module. This bug allows
an attacker to escalate privilege.
The reporter describes this bug affects 5.10 and 5.11. The mainline
was fixed in commit 4379bf8 ("io_uring: remove io_identity") which was
merged in 5.12-rc1-dontuse.

Fixed status
mainline: [4379bf8bd70b5de6bba7d53015b0c36c57a634ee]
stable/5.10: [29f077d070519a88a793fbc70f1e6484dc6d9e35]

CVE-2022-1836: floppy: disable FDRAWCMD by default

CVSS v3 score is not assigned.

An UAF bug was found in the floppy driver. This bug potentially will
leds local DoS, kernel information leak.
The mainline and all stable kernels were fixed.

Fixed status
mainline: [233087ca063686964a53c829d547c7571e3f67bf]
stable/4.14: [b7fa84ae1171a3c5ea5d710899080a6e63cfe084]
stable/4.19: [0e535976774504af36fab1dfb54f3d4d6cc577a9]
stable/4.9: [0dd02ff72c6daf4e7800fb5dd1109fbacdde97dc]
stable/5.10: [54c028cfc49624bfc27a571b94edecc79bbaaab4]
stable/5.15: [e52da8e4632f9c8fe78bf1c5881ce6871c7e08f3]
stable/5.17: [d91ca05d52fabf68c0376bcfeed1a52be68a8e1b]
stable/5.4: [7dea5913000c6a2974a00d9af8e7ffb54e47eac1]

CVE-2022-21499: lockdown: also lock down previous kgdb use

CVSS v3 score is not assigned.

Using gdb or kgdb, it will be able to read/write kernel memory even
though the lockdown feature is enabled.
The lockdown feature was introduced in 5.4. Earlier than 5.4 kernels
aren't affected by this issue.

The mainline and all stable kernels were fixed.

Fixed status
mainline: [eadb2f47a3ced5c64b23b90fd2a3463f63726066]
stable/5.15: [69c5d307dce1560fafcb852f39d7a1bf5e266641]
stable/5.17: [281d356a035132f2603724ee0f04767d70e2e98e]

* Updated CVEs

CVE-2022-0854: swiotlb information leak with DMA_FROM_DEVICE

4.19 and 5.10 were fixed this week.

Fixed status
mainline: [ddbd89deb7d32b1fbb879f48d68fda1a8ac58e8e,
aa6f8dcbab473f3a3c7454b74caa46d36cdc5d13]
stable/4.19: [8d9ac1b6665c73f23e963775f85d99679fd8e192,
06cb238b0f7ac1669cb06390704c61794724c191]
stable/5.10: [d4d975e7921079f877f828099bb8260af335508f,
f3f2247ac31cb71d1f05f56536df5946c6652f4a]
stable/5.15: [7403f4118ab94be837ab9d770507537a8057bc63,
2c1f97af38be151527380796d31d3c9adb054bf9]
stable/5.16: [270475d6d2410ec66e971bf181afe1958dad565e,
62b27d925655999350d0ea775a025919fd88d27f]

CVE-2022-1652: A concurrency use-after-free in bad_flp_intr

All stable kernels were fixed this week.

Fixed status
mainline: [f71f01394f742fc4558b3f9f4c7ef4c4cf3b07c8]
stable/4.14: [dc650d53bad770f169e498f1231671c51b0b321d]
stable/4.19: [3392d8711ad9e5b688999c948fd36d798c0d075d]
stable/4.9: [2adafe1c646b462c755e99216f966927eec96059]
stable/5.10: [911b36267855501f7f80a75927c128c0ac03fe58]
stable/5.15: [fc2bee93e31bbba920e9eeba76af72264ced066f]
stable/5.17: [88887ced7803132ed357a42d050560a2fb5c7ce6]
stable/5.4: [67e2b62461b5d02a1e63103e8a02c0bca75e26c7]

CVE-2022-28893: SUNRPC: Ensure we flush any closed sockets before xs_xprt_free()

5.4 was fixed this week. The mainline and all stable kernels were fixed.

Fixed status
mainline: [f00432063db1a0db484e85193eccc6845435b80e]
stable/5.10: [e68b60ae29de10c7bd7636e227164a8dbe305a82]
stable/5.15: [54f6834b283d9b4d070b0639d9ef5e1d156fe7b0]
stable/5.16: [7a0921a23cae42e9fa5ce964f6907181b6dc80d8]
stable/5.17: [d21287d8a4589dd8513038f887ece980fbc399cf]
stable/5.4: [2f8f6c393b11b5da059b1fc10a69fc2f2b6c446a]

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


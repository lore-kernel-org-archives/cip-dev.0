Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4360FCD1288
	for <webhook@archiver.kernel.org>; Thu,  4 Apr 2024 05:35:02 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
 by mx.groups.io with SMTP id smtpd.web11.31594.1712208892616589785
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Apr 2024 22:34:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=vMXmAmUn;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.41, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e6d089f603so392836a34.1
        for <cip-dev@lists.cip-project.org>; Wed, 03 Apr 2024 22:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1712208891; x=1712813691; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kkrWJ1QxscN035uoO3iq9gc1w13qodyabhRDm4WXXms=;
        b=vMXmAmUnCYKscipz6VFPJBf68nboTjiNHsJtbbpyH6ZFaFqDmHyzIVnbcKq2TlncPD
         0HKpSUhERap0+3GV4i2mZRU8jjSYclg6O13N64NTBxonhwimactzaiEFVb+LWHjQiL5l
         mZOeoyc1sQEMfwImzturq6qZO6N7yM+XcPDIW3DK8hQ2kP5KZH+fbNUJSfiSTkvKiN/Z
         AjhdEdBPY2dv0dnc0EQ60rn579lkGXbJt3Kv3rzCV5v6yQLDHvDr1pTOJFCS1XMoxbIN
         WoCFtrtFHaGY2GhLCijgjNeAJrxQMvqqlYUumFZbkvKnKLzskssUQQOCa56q4FcuA7hL
         SbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712208891; x=1712813691;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kkrWJ1QxscN035uoO3iq9gc1w13qodyabhRDm4WXXms=;
        b=w+2A1jkB7MUIMMWCEBeNNVY6xXTX+PurE4xPTHAFjdVWaglPByMJiaUtrkrNoetBwE
         rCIRtVQj2h+Rg7oFDTPUUHXLHO/UmoNCpvzBHGYZwzToQSrMqYu7OEsUSTZgvsaQBBoj
         ceDYrz/e+9oDret1O50I2f90xspAA8yKXHtOX4vrQG+daA2R9D/D1KC9TgiQlwo2MHzT
         pZ8+HhtLImHLZoZDo6gz616J8VJI8H7udL7uDoFxOGzc8r8aUTcyGgqw8z0aedw9q9Sv
         fnOHbGywsncqoXDFJRz0O8VNqPkNWv7p0kWp4tBrvTBE+SanIaZat4tnphpdyHuuhcVo
         7o5w==
X-Gm-Message-State: AOJu0YxurkxKH0/nOWoyVWxQM/X7ybIXEAryqymPMUOpLTzaWkJdp75k
	tRomL5Q7WkzuOthLX/hMtUiCkwmPWV8wH97tSoDySjHytcKp1VLlbOsZ5oYOgQWCFo6AFu3jv9E
	tWk84A6yayhtsu57/bWjbEbodLcmItVCqgYaJj4WOCZAz93QPpsw=
X-Google-Smtp-Source: AGHT+IG0pzuzOIqseg8YPCpaBOOF6ylvjxGJ4oPgQ/DOzxxn3St6ezvPbVdRLgjkVFkjazgoV0kfFCP8/IO/+42Cx7w=
X-Received: by 2002:a05:6870:284:b0:22e:922f:a4f3 with SMTP id
 q4-20020a056870028400b0022e922fa4f3mr1078323oaf.15.1712208889096; Wed, 03 Apr
 2024 22:34:49 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 4 Apr 2024 14:34:12 +0900
Message-ID: <CAODzB9p10pKZUSHnMhYsX-9HXEUE1FHuztV6QuU61bkM38MX_A@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Apr 2024 05:35:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15489

Hi!

It's this week's CVE report.

This week reported 137 new CVEs and 12 updated CVEs.

* New CVEs

CVE-2023-52628: netfilter: nftables: exthdr: fix 4-byte stack OOB write

Announce: https://lore.kernel.org/linux-cve-announce/2024032850-CVE-2023-52628-14fb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 49499c3 ("netfilter: nf_tables: switch registers
to 32 bit addressing") in v4.1-rc1.
Introduced by commit 935b7f6 ("netfilter: nft_exthdr: add TCP option
matching") in v4.11-rc1.
Introduced by commit 133dc20 ("netfilter: nft_exthdr: Support SCTP
chunks") in v5.14-rc1.
Introduced by commit dbb5281 ("netfilter: nf_tables: add support for
matching IPv4 options") in v5.3-rc1.
Fixed in v6.6-rc1.

For more detail, please check the following urls.

- ZDI-CAN-21950/ZDI-24-298:
https://www.zerodayinitiative.com/advisories/ZDI-24-298/
- ZDI-CAN-21951/ZDI-24-299:
https://www.zerodayinitiative.com/advisories/ZDI-24-299/
- ZDI-CAN-21961/ZDI-24-297:
https://www.zerodayinitiative.com/advisories/ZDI-24-297/

Fixed status
mainline: [fd94d9dadee58e09b49075240fe83423eb1dcd36]
stable/5.10: [a7d86a77c33ba1c357a7504341172cc1507f0698]
stable/5.15: [1ad7b189cc1411048434e8595ffcbe7873b71082]
stable/6.1: [d9ebfc0f21377690837ebbd119e679243e0099cc]

CVE-2023-52629: sh: push-switch: Reorder cleanup operations to avoid
use-after-free bug

Announce: https://lore.kernel.org/linux-cve-announce/2024032949-CVE-2023-52629-a508@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9f5e8ee ("sh: generic push-switch framework.") in
v2.6.20.16.
This bug is only affected by SH architecture.
Fixed in v6.6-rc1.

Fixed status
mainline: [246f80a0b17f8f582b2c0996db02998239057c65]

CVE-2024-26653: usb: misc: ljca: Fix double free in error handling path

Announce: https://lore.kernel.org/linux-cve-announce/2024040122-CVE-2024-26653-7903@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit acd6199 ("usb: Add support for Intel LJCA
device") in v6.7-rc1.
Thic commit is not backported to older stable kernels.
Fixed in v6.9-rc2.

Fixed status
mainline: [7c9631969287a5366bc8e39cd5abff154b35fb80]
stable/6.7: [420babea4f1881a7c4ea22a8e218b8c6895d3f21]
stable/6.8: [8a9f653cc852677003c23ee8075e3ed8fb4743c9]

CVE-2024-26654: ALSA: sh: aica: reorder cleanup operations to avoid UAF bugs

Announce: https://lore.kernel.org/linux-cve-announce/2024040142-CVE-2024-26654-aa6c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 198de43 ("[ALSA] Add ALSA support for the SEGA
Dreamcast PCM device") in v2.6.23-rc1.
Fixed in v6.9-rc2.

Fixed status
mainline: [051e0840ffa8ab25554d6b14b62c9ab9e4901457]
stable/6.1: [9d66ae0e7bb78b54e1e0525456c6b54e1d132046]
stable/6.6: [61d4787692c1fccdc268ffa7a891f9c149f50901]
stable/6.7: [e955e8a7f38a856fc6534ba4e6bffd4d5cc80ac3]
stable/6.8: [3c907bf56905de7d27b329afaf59c2fb35d17b04]

CVE-2024-26655: Fix memory leak in posix_clock_open()

Announce: https://lore.kernel.org/linux-cve-announce/2024040124-CVE-2024-26655-265a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 60c6946 ("posix-clock: introduce
posix_clock_context concept") in v6.7-rc1.
Thic commit is not backported to older stable kernels.
Fixed in v6.9-rc2.

Fixed status
mainline: [5b4cdd9c5676559b8a7c944ac5269b914b8c0bb8]
stable/6.7: [a88649b49523e8cbe95254440d803e38c19d2341]
stable/6.8: [0200dd7ed2335469955d7e69cc1a6fa7df1f3847]

CVE-2023-52630: blk-iocost: Fix an UBSAN shift-out-of-bounds warning

Announce: https://lore.kernel.org/linux-cve-announce/2024040219-CVE-2023-52630-a529@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5160a5a ("blk-iocost: implement delay adjustment
hysteresis") in v5.10-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc4.

Fixed status
mainline: [2a427b49d02995ea4a6ff93a1432c40fa4d36821]
stable/5.10: [9f56f38331171c9a19754004f0664686d67ee48d]
stable/5.15: [1e4d3f8bd880e02932a9ea179f90bfa74fd2e899]
stable/6.1: [e5dc63f01e027721c29f82069f7e97e2149fa131]
stable/6.6: [27b216130e64651e76ed583742a1b4e4d08a67c3]
stable/6.7: [cd33b330cb21675189e747953845f5c3689e4912]

CVE-2023-52631: fs/ntfs3: Fix an NULL dereference bug

Announce: https://lore.kernel.org/linux-cve-announce/2024040222-CVE-2023-52631-ea7b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit be71b5c ("fs/ntfs3: Add attrib operations") in v5.15-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc4.

Fixed status
mainline: [b2dd7b953c25ffd5912dda17e980e7168bebcf6c]
stable/5.15: [ae4acad41b0f93f1c26cc0fc9135bb79d8282d0b]
stable/6.1: [ec1bedd797588fe38fc11cba26d77bb1d9b194c6]
stable/6.6: [fb7bcd1722bc9bc55160378f5f99c01198fd14a7]
stable/6.7: [686820fe141ea0220fc6fdfc7e5694f915cf64b2]

CVE-2023-52632: drm/amdkfd: Fix lock dependency warning with srcu

Announce: https://lore.kernel.org/linux-cve-announce/2024040218-CVE-2023-52632-f7bb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
It looks as if this bug was introduced by commit 367c9b0 ("drm/amdkfd:
Ensure mm remain valid in svm deferred_list work") in 5.18-rc1.

Fixed status
mainline: [2a9de42e8d3c82c6990d226198602be44f43f340]
stable/6.1: [b602f098f716723fa5c6c96a486e0afba83b7b94]
stable/6.6: [752312f6a79440086ac0f9b08d7776870037323c]
stable/6.7: [1556c242e64cdffe58736aa650b0b395854fe4d4]

CVE-2023-52633: um: time-travel: fix time corruption

Announce: https://lore.kernel.org/linux-cve-announce/2024040218-CVE-2023-52633-d020@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
The time travel mode was introduced by commit 06503870 ("um: Support
time travel mode") in 5.3-rc1.
The time_travel_ndelay() was introduced by 0bc8fb4d ("um: Implement
ndelay/udelay in time-travel mode") in 5.7-rc1.
So,  Linux 4.x is not affected.

Fixed status
mainline: [abe4eaa8618bb36c2b33e9cdde0499296a23448c]
stable/5.15: [0c7478a2da3f5fe106b4658338873d50c86ac7ab]
stable/6.1: [4f7dad73df4cdb2b7042103d3922745d040ad025]
stable/6.6: [de3e9d8e8d1ae0a4d301109d1ec140796901306c]
stable/6.7: [b427f55e9d4185f6f17cc1e3296eb8d0c4425283]

CVE-2023-52634: drm/amd/display: Fix disable_otg_wa logic

Announce: https://lore.kernel.org/linux-cve-announce/2024040219-CVE-2023-52634-27e0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
Vulnerable function dcn35_disable_otg_wa() was introduced by commit
8774029f76 ("drm/amd/display: Add DCN35 CLK_MGR") in 6.7-rc1.

Fixed status
mainline: [2ce156482a6fef349d2eba98e5070c412d3af662]
stable/6.7: [ce29728ef6485a367934cc100249c66dd3cde5b6]

CVE-2023-52635: PM / devfreq: Synchronize devfreq_monitor_[start/stop]

Announce: https://lore.kernel.org/linux-cve-announce/2024040219-CVE-2023-52635-8b18@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
The delayed timer feature was introduced by commit 4dc3bab8 ("PM /
devfreq: Add support delayed timer for polling mode") in 5.9-rc1.

Fixed status
mainline: [aed5ed595960c6d301dcd4ed31aeaa7a8054c0c6]
stable/5.10: [3399cc7013e761fee9d6eec795e9b31ab0cbe475]
stable/5.15: [099f6a9edbe30b142c1d97fe9a4748601d995675]
stable/6.1: [31569995fc65007b73a3fff605ec2b3401b435e9]
stable/6.6: [0aedb319ef3ed39e9e5a7b7726c8264ca627bbd9]
stable/6.7: [ae815e2fdc284ab31651d52460698bd89c0fce22]

CVE-2023-52636: libceph: just wait for more data to be available on the socket

Announce: https://lore.kernel.org/linux-cve-announce/2024040249-CVE-2023-52636-d965@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d396f89 ("libceph: add sparse read support to
msgr1") in v6.6-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc4.

Fixed status
mainline: [8e46a2d068c92a905d01cbb018b00d66991585ab]
stable/6.6: [da9c33a70f095d5d55c36d0bfeba969e31de08ae]
stable/6.7: [bd9442e553ab8bf74b8be3b3c0a43bf4af4dc9b8]

CVE-2024-26656: drm/amdgpu: fix use-after-free bug

Announce: https://lore.kernel.org/linux-cve-announce/2024040247-CVE-2024-26656-ffaa@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
It looks as if commit 62914a99 ("drm/amdgpu: Use mmu_interval_insert
instead of hmm_mirror") in 5.5-rc1 or
81fa1af31 ("drm/amdgpu: Use mmu_interval_notifier instead of
hmm_mirror") in 5.5-rc1 are suspicious.
So, prior to Linux 5.5 may not be affected.

Fixed status
mainline: [22207fd5c80177b860279653d017474b2812af5e]
stable/6.6: [e87e08c94c9541b4e18c4c13f2f605935f512605]
stable/6.7: [af054a5fb24a144f99895afce9519d709891894c]
stable/6.8: [22f665ecfd1225afa1309ace623157d12bb9bb0c]

CVE-2024-26657: drm/sched: fix null-ptr-deref in init entity

Announce: https://lore.kernel.org/linux-cve-announce/2024040250-CVE-2024-26657-25a0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 56e4496 ("drm/sched: Convert the GPU scheduler to
variable number of run-queues") in v6.7-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc2.

Fixed status
mainline: [f34e8bb7d6c6626933fe993e03ed59ae85e16abb]
stable/6.7: [74cd204c7afe498aa9dcc3ebf0ecac53d477a429]
stable/6.8: [54b5b7275dfdec35812ccce70930cd7c4ee612b2]

CVE-2024-26658: bcachefs: grab s_umount only if snapshotting

Announce: https://lore.kernel.org/linux-cve-announce/2024040222-CVE-2024-26658-1451@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
According to the commit log, commit 42d23732 ("bcachefs: Snapshot
creation, deletion") may introduce this bug.

Fixed status
mainline: [2acc59dd88d27ad69b66ded80df16c042b04eeec]
stable/6.7: [5b41d3fd04c6757b9c2a60a0c5b2609cae9999df]

CVE-2024-26659: xhci: handle isoc Babble and Buffer Overrun events properly

Announce: https://lore.kernel.org/linux-cve-announce/2024040222-CVE-2024-26659-e4f6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc3.
Backporting this fix to 4.19
(https://lore.kernel.org/stable/2024021310-prelaunch-earmark-e533@gregkh/)
and
5.4 (https://lore.kernel.org/stable/2024021309-hypertext-gush-3da8@gregkh/)
were failed.
It looks like 4.x kernels are affected.

Fixed status
mainline: [7c4650ded49e5b88929ecbbb631efb8b0838e811]
stable/5.10: [696e4112e5c1ee61996198f0ebb6ca3fab55166e]
stable/5.15: [2aa7bcfdbb46241c701811bbc0d64d7884e3346c]
stable/6.1: [2e3ec80ea7ba58bbb210e83b5a0afefee7c171d3]
stable/6.6: [f5e7ffa9269a448a720e21f1ed1384d118298c97]
stable/6.7: [418456c0ce56209610523f21734c5612ee634134]

CVE-2024-26660: drm/amd/display: Implement bounds check for stream
encoder creation in DCN301

Announce: https://lore.kernel.org/linux-cve-announce/2024040222-CVE-2024-26660-3f40@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3a83e4e ("drm/amd/display: Add dcn3.01 support to
DC (v2)") in v5.11-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc4.

Fixed status
mainline: [58fca355ad37dcb5f785d9095db5f748b79c5dc2]
stable/5.15: [42442f74314d41ddc68227047036fa3e78940054]
stable/6.1: [efdd665ce1a1634b8c1dad5e7f6baaef3e131d0a]
stable/6.6: [cd9bd10c59e3c1446680514fd3097c5b00d3712d]
stable/6.7: [a938eab9586eea31cfd129a507f552efae14d738]

CVE-2024-26661: drm/amd/display: Add NULL test for 'timing generator'
in 'dcn21_set_pipe()'

Announce: https://lore.kernel.org/linux-cve-announce/2024040223-CVE-2024-26661-bef6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 474ac4a ("drm/amd/display: Implement some asic
specific abm call backs.") in v5.9-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc4.

Fixed status
mainline: [66951d98d9bf45ba25acf37fe0747253fafdf298]
stable/6.6: [3f3c237a706580326d3b7a1b97697e5031ca4667]
stable/6.7: [39f24c08363af1cd945abad84e3c87fd3e3c845a]

CVE-2024-26662: drm/amd/display: Fix 'panel_cntl' could be null in
'dcn21_set_backlight_level()'

Announce: https://lore.kernel.org/linux-cve-announce/2024040223-CVE-2024-26662-863c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 474ac4a ("drm/amd/display: Implement some asic
specific abm call backs.") in v5.9-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc4.

Fixed status
mainline: [e96fddb32931d007db12b1fce9b5e8e4c080401b]
stable/6.6: [2e150ccea13129eb048679114808eb9770443e4d]
stable/6.7: [0c863cab0e9173f8b6c7bc328bee3b8625f131b5]

CVE-2024-26663: tipc: Check the bearer type before calling
tipc_udp_nl_bearer_add()

Announce: https://lore.kernel.org/linux-cve-announce/2024040223-CVE-2024-26663-9705@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ef20cd4 ("tipc: introduce UDP replicast") in v4.9-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc4.

Fixed status
mainline: [3871aa01e1a779d866fa9dfdd5a836f342f4eb87]
stable/4.19: [24ec8f0da93b8a9fba11600be8a90f0d73fb46f1]
stable/5.10: [19d7314f2fb9515bdaac9829d4d8eb34edd1fe95]
stable/5.15: [c1701ea85ef0ec7be6a1b36c7da69f572ed2fd12]
stable/5.4: [6f70f0b412458c622a12d4292782c8e92e210c2f]
stable/6.1: [3d3a5b31b43515b5752ff282702ca546ec3e48b6]
stable/6.6: [888e3524be87f3df9fa3c083484e4b62b3e3bb59]
stable/6.7: [0cd331dfd6023640c9669d0592bc0fd491205f87]

CVE-2024-26664: hwmon: (coretemp) Fix out-of-bounds memory access

Announce: https://lore.kernel.org/linux-cve-announce/2024040223-CVE-2024-26664-03db@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7108b80 ("hwmon/coretemp: Handle large core ID
value") in v6.1-rc2.
This commit was backported to 4.19, 5.4, 5.10, and 5.15.
Fixed in v6.8-rc4.

Fixed status
mainline: [4e440abc894585a34c2904a32cd54af1742311b3]
stable/4.19: [93f0f4e846fcb682c3ec436e3b2e30e5a3a8ee6a]
stable/5.10: [f0da068c75c20ffc5ba28243ff577531dc2af1fd]
stable/5.15: [a16afec8e83c56b14a4a73d2e3fb8eec3a8a057e]
stable/5.4: [1eb74c00c9c3b13cb65e508c5d5a2f11afb96b8b]
stable/6.1: [9bce69419271eb8b2b3ab467387cb59c99d80deb]
stable/6.6: [853a6503c586a71abf27e60a7f8c4fb28092976d]
stable/6.7: [3a7753bda55985dc26fae17795cb10d825453ad1]

CVE-2024-26665: tunnels: fix out of bounds access when building IPv6 PMTU error

Announce: https://lore.kernel.org/linux-cve-announce/2024040224-CVE-2024-26665-5daa@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4cb47a8 ("tunnels: PMTU discovery support for
directly bridged IP packets") in v5.9-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc4.

Fixed status
mainline: [d75abeec401f8c86b470e7028a13fcdc87e5dd06]
stable/5.10: [e77bf828f1ca1c47fcff58bdc26b60a9d3dfbe1d]
stable/5.15: [d964dd1bc1452594b4207d9229c157d9386e5d8a]
stable/6.1: [e37cde7a5716466ff2a76f7f27f0a29b05b9a732]
stable/6.6: [510c869ffa4068c5f19ff4df51d1e2f3a30aaac1]
stable/6.7: [7dc9feb8b1705cf00de20563b6bc4831f4c99dab]

CVE-2024-26666: wifi: mac80211: fix RCU use in TDLS fast-xmit

Announce: https://lore.kernel.org/linux-cve-announce/2024040224-CVE-2024-26666-fcfe@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8cc0726 ("wifi: mac80211: handle TDLS data frames
with MLO") in v6.5-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc4.

Fixed status
mainline: [9480adfe4e0f0319b9da04b44e4eebd5ad07e0cd]
stable/6.6: [fc3432ae8232ff4025e7c55012dd88db0e3d18eb]
stable/6.7: [c255c3b653c6e8b52ac658c305e2fece2825f7ad]

CVE-2024-26667: drm/msm/dpu: check for valid hw_pp in
dpu_encoder_helper_phys_cleanup

Announce: https://lore.kernel.org/linux-cve-announce/2024040224-CVE-2024-26667-cf72@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ae4d721 ("drm/msm/dpu: add an API to reset the
encoder related hw blocks") in v5.19-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc4.

Fixed status
mainline: [7f3d03c48b1eb6bc45ab20ca98b8b11be25f9f52]
stable/6.1: [fb8bfc6ea3cd8c5ac3d35711d064e2f6646aec17]
stable/6.6: [79592a6e7bdc1d05460c95f891f5e5263a107af8]
stable/6.7: [eb4f56f3ff5799ca754ae6d811803a63fe25a4a2]

CVE-2024-26668: netfilter: nft_limit: reject configurations that cause
integer overflow

Announce: https://lore.kernel.org/linux-cve-announce/2024040235-CVE-2024-26668-636e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d2168e8 ("netfilter: nft_limit: add per-byte
limiting") in v4.3-rc1.
Fixed in v6.8-rc2.

Fixed status
mainline: [c9d9eb9c53d37cdebbad56b91e40baf42d5a97aa]
stable/5.15: [79d4efd75e7dbecd855a3b8a63e65f7265f466e1]
stable/6.1: [bc6e242bb74e2ae616bfd2b250682b738e781c9b]
stable/6.6: [9882495d02ecc490604f747437a40626dc9160d0]
stable/6.7: [00c2c29aa36d1d1827c51a3720e9f893a22c7c6a]

CVE-2024-26669: net/sched: flower: Fix chain template offload

Announce: https://lore.kernel.org/linux-cve-announce/2024040237-CVE-2024-26669-ca3c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit bbf7383 ("net: sched: traverse chains in block
with tcf_get_next_chain()") in v5.1-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc2.

Fixed status
mainline: [32f2a0afa95fae0d1ceec2ff06e0e816939964b8]
stable/6.6: [9ed46144cff3598a5cf79955630e795ff9af5b97]
stable/6.7: [c04709b2cc99ae31c346f79f0211752d7b74df01]

CVE-2024-26670: arm64: entry: fix ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD

Announce: https://lore.kernel.org/linux-cve-announce/2024040238-CVE-2024-26670-ecbd@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 471470b ("arm64: errata: Add Cortex-A520
speculative unprivileged load workaround") in v6.6-rc5.
This commit was backported to 6.1.
Fixed in v6.8-rc1.

Fixed status
mainline: [832dd634bd1b4e3bbe9f10b9c9ba5db6f6f2b97f]
stable/6.6: [58eb5c07f41704464b9acc09ab0707b6769db6c0]
stable/6.7: [baa0aaac16432019651e0d60c41cd34a0c3c3477]

CVE-2024-26671: blk-mq: fix IO hang from sbitmap wakeup race

Announce: https://lore.kernel.org/linux-cve-announce/2024040219-CVE-2024-26671-2543@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
The blk_mq_mark_tag_wait() was renamed from blk_mq_dispatch_wait_add()
by commit f906a6a0f ("blk-mq: improve tag waiting setup for non-shared
tags")
in 4.15-rc1. The blk_mq_dispatch_wait_add() was introduced by commit
da55f2cc ("blk-mq: use sbq wait queues instead of restart for driver
tags") in 4.11-rc1.
So, Linux 4.4 may not be affected.

Fixed status
mainline: [5266caaf5660529e3da53004b8b7174cab6374ed]
stable/4.19: [9525b38180e2753f0daa1a522b7767a2aa969676]
stable/5.10: [7610ba1319253225a9ba8a9d28d472fc883b4e2f]
stable/5.15: [89e0e66682e1538aeeaa3109503473663cd24c8b]
stable/5.4: [ecd7744a1446eb02ccc63e493e2eb6ede4ef1e10]
stable/6.1: [1d9c777d3e70bdc57dddf7a14a80059d65919e56]
stable/6.6: [6d8b01624a2540336a32be91f25187a433af53a0]
stable/6.7: [f1bc0d8163f8ee84a8d5affdf624cfad657df1d2]

CVE-2024-26672: drm/amdgpu: Fix variable 'mca_funcs' dereferenced
before NULL check in 'amdgpu_mca_smu_get_mca_entry()'

Announce: https://lore.kernel.org/linux-cve-announce/2024040219-CVE-2024-26672-e96e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.

Fixed status
mainline: [4f32504a2f85a7b40fe149436881381f48e9c0c0]
stable/6.7: [7b5d58c07024516c0e81b95e98f37710cf402c53]

CVE-2024-26673: netfilter: nft_ct: sanitize layer 3 and 4 protocol
number in custom expectations

Announce: https://lore.kernel.org/linux-cve-announce/2024040212-CVE-2024-26673-b2d3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 857b460 ("netfilter: nft_ct: add ct expectations
support") in v5.3-rc1.
It looks as if commit 7ff607e2 ("drm/amdgpu: add amdgpu smu mca dump
feature support") in 6.7-rc1 introduced by this bug.
Fixed in v6.8-rc3.

Fixed status
mainline: [8059918a1377f2f1fff06af4f5a4ed3d5acd6bc4]
stable/5.10: [65ee90efc928410c6f73b3d2e0afdd762652c09d]
stable/5.15: [b775ced05489f4b77a35fe203e9aeb22f428e38f]
stable/5.4: [f549f340c91f08b938d60266e792ff7748dae483]
stable/6.1: [0f501dae16b7099e69ee9b0d5c70b8f40fd30e98]
stable/6.6: [cfe3550ea5df292c9e2d608e8c4560032391847e]
stable/6.7: [38cc1605338d99205a263707f4dde76408d3e0e8]

CVE-2024-26674: x86/lib: Revert to _ASM_EXTABLE_UA() for {get,put}_user() fixups

Announce: https://lore.kernel.org/linux-cve-announce/2024040252-CVE-2024-26674-4ff9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b19b74b ("x86/mm: Rework address range check in
get_user() and put_user()") in v6.4-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc4.

Fixed status
mainline: [8eed4e00a370b37b4e5985ed983dccedd555ea9d]
stable/6.6: [2aed1b6c33afd8599d01c6532bbecb829480a674]
stable/6.7: [2da241c5ed78d0978228a1150735539fe1a60eca]

CVE-2024-26675: ppp_async: limit MRU to 64K

Announce: https://lore.kernel.org/linux-cve-announce/2024040252-CVE-2024-26675-5b19@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.8-rc4.

Fixed status
cip/4.4: [37a53d8baa59dffb752a1dd9e85888090fd05c7e]
cip/4.4-rt: [37a53d8baa59dffb752a1dd9e85888090fd05c7e]
cip/4.4-st: [37a53d8baa59dffb752a1dd9e85888090fd05c7e]
mainline: [cb88cb53badb8aeb3955ad6ce80b07b598e310b8]
stable/4.19: [4fdb14ba89faff6e6969a4dffdc8e54235d6e5ed]
stable/5.10: [b06e067e93fa4b98acfd3a9f38a398ab91bbc58b]
stable/5.15: [58fbe665b097bf7b3144da7e7b91fb27aa8d0ae3]
stable/5.4: [56fae81633ccee307cfcb032f706bf1863a56982]
stable/6.1: [4e2c4846b2507f6dfc9bea72b7567c2693a82a16]
stable/6.6: [7e5ef49670766c9742ffcd9cead7cdb018268719]
stable/6.7: [210d938f963dddc543b07e66a79b7d8d4bd00bd8]

CVE-2024-26676: af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.

Announce: https://lore.kernel.org/linux-cve-announce/2024040252-CVE-2024-26676-222f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2aab4b9 ("af_unix: fix struct pid leaks in OOB
support") in v6.3-rc2.
This commit was backported to 6.1 and 5.15.
Fixed in v6.8-rc4.

Fixed status
mainline: [1279f9d9dec2d7462823a18c29ad61359e0a007d]
stable/5.15: [4fe505c63aa3273135a57597fda761e9aecc7668]
stable/6.1: [e0e09186d8821ad59806115d347ea32efa43ca4b]
stable/6.6: [b74aa9ce13d02b7fd37c5325b99854f91b9b4276]
stable/6.7: [82ae47c5c3a6b27fdc0f9e83c1499cb439c56140]

CVE-2024-26677: rxrpc: Fix delayed ACKs to not set the reference serial number

Announce: https://lore.kernel.org/linux-cve-announce/2024040252-CVE-2024-26677-8bc6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 17926a7 ("[AF_RXRPC]: Provide secure RxRPC
sockets for use by userspace and kernel both") in v2.6.22-rc1.
Fixed in v6.8-rc4.

Fixed status
mainline: [e7870cf13d20f56bfc19f9c3e89707c69cf104ef]
stable/6.6: [200cb50b9e154434470c8969d32474d38475acc2]
stable/6.7: [63719f490e6a89896e9a463d2b45e8203eab23ae]

CVE-2024-26678: x86/efistub: Use 1:1 file:memory mapping for PE/COFF
.compat section

Announce: https://lore.kernel.org/linux-cve-announce/2024040253-CVE-2024-26678-2cf0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3e3eabe ("x86/boot: Increase section and file
alignment to 4k/512") in v6.7-rc1.
This commit was backported to 6.6.
Fixed in v6.8-rc4.

Fixed status
mainline: [1ad55cecf22f05f1c884adf63cc09d3c3e609ebf]
stable/6.6: [0a962f2fbaa976af9eed21d0306370cded485787]
stable/6.7: [4adeeff8c12321cd453412a659c3c0eeb9bb2397]

CVE-2024-26679: inet: read sk->sk_family once in inet_recv_error()

Announce: https://lore.kernel.org/linux-cve-announce/2024040253-CVE-2024-26679-d520@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f4713a3 ("net-timestamp: make tcp_recvmsg call
ipv6_recv_error for AF_INET6 socks") in v3.18-rc7.
Fixed in v6.8-rc4.

Fixed status
cip/4.4: [bb8d857ec2d255cdba76631c733f8d722b5ab6bc]
cip/4.4-rt: [bb8d857ec2d255cdba76631c733f8d722b5ab6bc]
cip/4.4-st: [bb8d857ec2d255cdba76631c733f8d722b5ab6bc]
mainline: [eef00a82c568944f113f2de738156ac591bbd5cd]
stable/4.19: [caa064c3c2394d03e289ebd6b0be5102eb8a5b40]
stable/5.10: [88081ba415224cf413101def4343d660f56d082b]
stable/5.15: [3266e638ba5cc1165f5e6989eb8c0720f1cc4b41]
stable/5.4: [5993f121fbc01dc2d734f0ff2628009b258fb1dd]
stable/6.1: [54538752216bf89ee88d47ad07802063a498c299]
stable/6.6: [4a5e31bdd3c1702b520506d9cf8c41085f75c7f2]
stable/6.7: [307fa8a75ab7423fa5c73573ec3d192de5027830]

CVE-2024-26680: net: atlantic: Fix DMA mapping for PTP hwts ring

Announce: https://lore.kernel.org/linux-cve-announce/2024040253-CVE-2024-26680-d16c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 94ad945 ("net: aquantia: add PTP rings
infrastructure") in v5.5-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc4.

Fixed status
mainline: [2e7d3b67630dfd8f178c41fa2217aa00e79a5887]
stable/6.1: [466ceebe48cbba3f4506f165fca7111f9eb8bb12]
stable/6.6: [004fe5b7f59286a926a45e0cafc7870e9cdddd56]
stable/6.7: [e42e334c645575be5432adee224975d4f536fdb1]

CVE-2024-26681: netdevsim: avoid potential loop in nsim_dev_trap_report_work()

Announce: https://lore.kernel.org/linux-cve-announce/2024040253-CVE-2024-26681-7e46@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 012ec02 ("netdevsim: convert driver to use
unlocked devlink API during init/fini") in v6.0-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc4.

Fixed status
mainline: [ba5e1272142d051dcc57ca1d3225ad8a089f9858]
stable/6.1: [0193e0660cc6689c794794b471492923cfd7bfbc]
stable/6.6: [6eecddd9c3c8d6e3a097531cdc6d500335b35e46]
stable/6.7: [d91964cdada76740811b7c621239f9c407820dbc]

CVE-2024-26682: wifi: mac80211: improve CSA/ECSA connection refusal

Announce: https://lore.kernel.org/linux-cve-announce/2024040254-CVE-2024-26682-f2b2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c09c4f3 ("wifi: mac80211: don't connect to an AP
while it's in a CSA process") in v6.7-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc4.

Fixed status
mainline: [35e2385dbe787936c793d70755a5177d267a40aa]
stable/6.7: [ea88bde8e3fefbe4268f6991375dd629895a090a]

CVE-2024-26683: wifi: cfg80211: detect stuck ECSA element in probe resp

Announce: https://lore.kernel.org/linux-cve-announce/2024040254-CVE-2024-26683-8614@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c09c4f3 ("wifi: mac80211: don't connect to an AP
while it's in a CSA process") in v6.7-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc4.

Fixed status
mainline: [177fbbcb4ed6b306c1626a277fac3fb1c495a4c7]
stable/6.7: [ce112c941c2b172afba3e913a90c380647d53975]

CVE-2024-26684: net: stmmac: xgmac: fix handling of DPP safety error
for DMA channels

Announce: https://lore.kernel.org/linux-cve-announce/2024040254-CVE-2024-26684-7ce8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 56e58d6 ("net: stmmac: Implement Safety Features
in XGMAC core") in v5.4-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc4.

Fixed status
mainline: [46eba193d04f8bd717e525eb4110f3c46c12aec3]
stable/5.10: [2fc45a4631ac7837a5c497cb4f7e2115d950fc37]
stable/5.15: [6609e98ed82966a1b3168c142aca30f8284a7b89]
stable/5.4: [e9837c83befb5b852fa76425dde98a87b737df00]
stable/6.1: [e42ff0844fe418c7d03a14f9f90e1b91ba119591]
stable/6.6: [7e0ff50131e9d1aa507be8e670d38e9300a5f5bf]
stable/6.7: [3b48c9e258c8691c2f093ee07b1ea3764caaa1b2]

CVE-2023-52637: can: j1939: Fix UAF in j1939_sk_match_filter during
setsockopt(SO_J1939_FILTER)

Announce: https://lore.kernel.org/linux-cve-announce/2024040332-CVE-2023-52637-5e37@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9d71dd0 ("can: add support of SAE J1939
protocol") in v5.4-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc5.

Fixed status
mainline: [efe7cf828039aedb297c1f9920b638fffee6aabc]
stable/5.10: [978e50ef8c38dc71bd14d1b0143d554ff5d188ba]
stable/5.15: [41ccb5bcbf03f02d820bc6ea8390811859f558f8]
stable/5.4: [08de58abedf6e69396e1207e4f99ef8904b2b532]
stable/6.1: [4dd684d4bb3cd5454e0bf6e2a1bdfbd5c9c872ed]
stable/6.6: [f84e7534457dcd7835be743517c35378bb4e7c50]
stable/6.7: [fc74b9cb789cae061bbca7b203a3842e059f6b5d]

CVE-2023-52638: can: j1939: prevent deadlock by changing
j1939_socks_lock to rwlock

Announce: https://lore.kernel.org/linux-cve-announce/2024040334-CVE-2023-52638-26a6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc5.
The can/j1939 was introduced by commit ("can: add support of SAE J1939
protocol") in 5.4-rc1. It looks like this bug was introduced by the
commit.

Fixed status
mainline: [6cdedc18ba7b9dacc36466e27e3267d201948c8d]
stable/5.15: [03358aba991668d3bb2c65b3c82aa32c36851170]
stable/6.1: [aedda066d717a0b4335d7e0a00b2e3a61e40afcf]
stable/6.6: [26dfe112ec2e95fe0099681f6aec33da13c2dd8e]
stable/6.7: [559b6322f9480bff68cfa98d108991e945a4f284]

CVE-2023-52639: KVM: s390: vsie: fix race during shadow creation

Announce: https://lore.kernel.org/linux-cve-announce/2024040335-CVE-2023-52639-5b67@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a3508fb ("KVM: s390: vsie: initial support for
nested virtualization") in v4.8-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc4.

Fixed status
mainline: [fe752331d4b361d43cfd0b89534b4b2176057c32]
stable/6.1: [5df3b81a567eb565029563f26f374ae3803a1dfc]
stable/6.6: [f5572c0323cf8b4f1f0618178648a25b8fb8a380]
stable/6.7: [28bb27824f25f36e5f80229a358d66ee09244082]

CVE-2023-52640: fs/ntfs3: Fix oob in ntfs_listxattr

Announce: https://lore.kernel.org/linux-cve-announce/2024040355-CVE-2023-52640-2657@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc4.
The ntfs3's attribute operation was introduced by commit be71b5cba
("fs/ntfs3: Add attrib operations") in 5.15-rc1.
So, prior to Linux 5.15 is not affected.

Fixed status
mainline: [731ab1f9828800df871c5a7ab9ffe965317d3f15]
stable/5.15: [a585faf0591548fe0920641950ebfa8a6eefe1cd]
stable/6.1: [6ed6cdbe88334ca3430c5aee7754dc4597498dfb]
stable/6.6: [52fff5799e3d1b5803ecd2f5f19c13c65f4f7b23]
stable/6.7: [0830c5cf19bdec50d0ede4755ddc463663deb21c]

CVE-2023-52641: fs/ntfs3: Add NULL ptr dereference checking at the end
of attr_allocate_frame()

Announce: https://lore.kernel.org/linux-cve-announce/2024040357-CVE-2023-52641-1c18@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc4.
The ntfs3's arrtib operations was introduced by commit be71b5cb
("fs/ntfs3: Add attrib operations") in 5.15-rc1.
This commit introduced this bug.

Fixed status
mainline: [aaab47f204aaf47838241d57bf8662c8840de60a]
stable/5.15: [ee8db6475cb15c8122855f72ad4cfa5375af6a7b]
stable/6.1: [50545eb6cd5f7ff852a01fa29b7372524ef948cc]
stable/6.6: [947c3f3d31ea185ddc8e7f198873f17d36deb24c]
stable/6.7: [847b68f58c212f0439c5a8101b3841f32caffccd]

CVE-2024-26685: nilfs2: fix potential bug in end_buffer_async_write

Announce: https://lore.kernel.org/linux-cve-announce/2024040335-CVE-2024-26685-e15e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7f42ec3 ("nilfs2: fix issue with race condition
of competition between segments for dirty blocks") in v3.12-rc4.
Fixed in v6.8-rc4.

Fixed status
cip/4.4: [ac338f456db88bd4c653e01151074320959ac404]
cip/4.4-rt: [ac338f456db88bd4c653e01151074320959ac404]
cip/4.4-st: [ac338f456db88bd4c653e01151074320959ac404]
mainline: [5bc09b397cbf1221f8a8aacb1152650c9195b02b]
stable/4.19: [c4a09fdac625e64abe478dcf88bfa20406616928]
stable/5.10: [f3e4963566f58726d3265a727116a42b591f6596]
stable/5.15: [8fa90634ec3e9cc50f42dd605eec60f2d146ced8]
stable/5.4: [d31c8721e816eff5ca6573cc487754f357c093cd]
stable/6.1: [6589f0f72f8edd1fa11adce4eedbd3615f2e78ab]
stable/6.6: [2c3bdba00283a6c7a5b19481a59a730f46063803]
stable/6.7: [626daab3811b772086aef1bf8eed3ffe6f523eff]

CVE-2024-26686: fs/proc: do_task_stat: use sig->stats_lock to gather
the threads/children stats

Announce: https://lore.kernel.org/linux-cve-announce/2024040335-CVE-2024-26686-b22f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc4.
It may affect all stable kernels.

Fixed status
mainline: [7601df8031fd67310af891897ef6cc0df4209305]
stable/6.1: [cf4b8c39b9a0bd81c47afc7ef62914a62dd5ec4d]
stable/6.7: [27978243f165b44e342f28f449b91327944ea071]

CVE-2024-26687: xen/events: close evtchn after mapping cleanup

Announce: https://lore.kernel.org/linux-cve-announce/2024040335-CVE-2024-26687-55d0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d46a78b ("xen: implement pirq type event
channels") in v2.6.37-rc1.
Backporting to this fix to 4.19
(https://lore.kernel.org/stable/2024021921-why-roamer-871c@gregkh/),
5.10 (https://lore.kernel.org/stable/2024021914-wackiness-diagnoses-52e2@gregkh/),
5.15 (https://lore.kernel.org/stable/2024021911-king-sugar-1024@gregkh/), and
5.4 (https://lore.kernel.org/stable/2024021917-krypton-upcountry-d467@gregkh/)
were failed.
Fixed in v6.8-rc5.

Fixed status
mainline: [fa765c4b4aed2d64266b694520ecb025c862c5a9]
stable/6.1: [585a344af6bcac222608a158fc2830ff02712af5]
stable/6.6: [20980195ec8d2e41653800c45c8c367fa1b1f2b4]
stable/6.7: [9be71aa12afa91dfe457b3fb4a444c42b1ee036b]

CVE-2024-26688: fs,hugetlb: fix NULL pointer dereference in hugetlbs_fill_super

Announce: https://lore.kernel.org/linux-cve-announce/2024040336-CVE-2024-26688-7b0e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3202198 ("hugetlbfs: Convert to fs_context") in v5.1-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc4.

Fixed status
mainline: [79d72c68c58784a3e1cd2378669d51bfd0cb7498]
stable/5.10: [80d852299987a8037be145a94f41874228f1a773]
stable/5.15: [22850c9950a4e43a67299755d11498f3292d02ff]
stable/5.4: [1dde8ef4b7a749ae1bc73617c91775631d167557]
stable/6.1: [2e2c07104b4904aed1389a59b25799b95a85b5b9]
stable/6.6: [13c5a9fb07105557a1fa9efdb4f23d7ef30b7274]
stable/6.7: [ec78418801ef7b0c22cd6a30145ec480dd48db39]

CVE-2024-26689: ceph: prevent use-after-free in encode_cap_msg()

Announce: https://lore.kernel.org/linux-cve-announce/2024040336-CVE-2024-26689-990b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc4.
Commit 0a454bdd ("ceph: reorganize __send_cap for less spinlock
abuse") in 5.8-rc1 introduced the __prep_cap().
It seems as if this commit introduced this bug.

Fixed status
mainline: [cda4672da1c26835dcbd7aec2bfed954eda9b5ef]
stable/5.10: [8180d0c27b93a6eb60da1b08ea079e3926328214]
stable/5.15: [70e329b440762390258a6fe8c0de93c9fdd56c77]
stable/6.1: [f3f98d7d84b31828004545e29fd7262b9f444139]
stable/6.6: [ae20db45e482303a20e56f2db667a9d9c54ac7e7]
stable/6.7: [7958c1bf5b03c6f1f58e724dbdec93f8f60b96fc]

CVE-2024-26690: net: stmmac: protect updates of 64-bit statistics counters

Announce: https://lore.kernel.org/linux-cve-announce/2024040336-CVE-2024-26690-0097@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 133466c ("net: stmmac: use per-queue 64 bit
statistics where necessary") in v6.6-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc4.

Fixed status
mainline: [38cc3c6dcc09dc3a1800b5ec22aef643ca11eab8]
stable/6.6: [9680b2ab54ba8d72581100e8c45471306101836e]
stable/6.7: [e6af0f082a4b87b99ad033003be2a904a1791b3f]

CVE-2024-26691: KVM: arm64: Fix circular locking dependency

Announce: https://lore.kernel.org/linux-cve-announce/2024040336-CVE-2024-26691-fff7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc5.
Vulnerable functions were introduced by commit 9d0c063 ("KVM: arm64:
Instantiate pKVM hypervisor VM and vCPU structures from EL1") in
6.2-rc1.

Fixed status
mainline: [10c02aad111df02088d1a81792a709f6a7eca6cc]
stable/6.6: [3d16cebf01127f459dcfeb79ed77bd68b124c228]
stable/6.7: [3ab1c40a1e915e350d9181a4603af393141970cc]

CVE-2024-26692: smb: Fix regression in writes when non-standard
maximum write size negotiated

Announce: https://lore.kernel.org/linux-cve-announce/2024040337-CVE-2024-26692-162f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d08089f ("cifs: Change the I/O paths to use an
iterator rather than a page list") in v6.3-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc5.

Fixed status
mainline: [4860abb91f3d7fbaf8147d54782149bb1fc45892]
stable/6.6: [4145ccff546ea868428b3e0fe6818c6261b574a9]
stable/6.7: [63c35afd50e28b49c5b75542045a8c42b696dab9]

CVE-2024-26693: wifi: iwlwifi: mvm: fix a crash when we run out of stations

Announce: https://lore.kernel.org/linux-cve-announce/2024040337-CVE-2024-26693-9c3b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 57974a5 ("wifi: iwlwifi: mvm: refactor
iwl_mvm_mac_sta_state_common()") in v6.4-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc5.

Fixed status
mainline: [b7198383ef2debe748118996f627452281cf27d7]
stable/6.6: [00f4eb31b8193f6070ce24df636883f9c104ca95]
stable/6.7: [c12f0f4d4caf23b1bfdc2602b6b70d56bdcd6aa7]

CVE-2024-26694: wifi: iwlwifi: fix double-free bug

Announce: https://lore.kernel.org/linux-cve-announce/2024040337-CVE-2024-26694-b216@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5e31b3d ("wifi: iwlwifi: dbg: print pc register
data once fw dump occurred") in v6.4-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc4.

Fixed status
mainline: [353d321f63f7dbfc9ef58498cc732c9fe886a596]
stable/6.6: [ab9d4bb9a1892439b3123fc52b19e32b9cdf80ad]
stable/6.7: [d24eb9a27bea8fe5237fa71be274391d9d51eff2]

CVE-2024-26695: crypto: ccp - Fix null pointer dereference in
__sev_platform_shutdown_locked

Announce: https://lore.kernel.org/linux-cve-announce/2024040338-CVE-2024-26695-e41f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1b05ece ("crypto: ccp - During shutdown, check
SEV data pointer before using") in v6.0-rc1.
This commit was backported to 5.10 and 5.15.
Fixed in v6.8-rc4.

Fixed status
mainline: [ccb88e9549e7cfd8bcd511c538f437e20026e983]
stable/5.10: [58054faf3bd29cd0b949b77efcb6157f66f401ed]
stable/5.15: [7535ec350a5f09b5756a7607f5582913f21200f4]
stable/6.1: [8731fe001a60581794ed9cf65da8cd304846a6fb]
stable/6.6: [88aa493f393d2ee38ac140e1f6ac1881346e85d4]
stable/6.7: [b5909f197f3b26aebedca7d8ac7b688fd993a266]

CVE-2024-26696: nilfs2: fix hang in nilfs_lookup_dirty_data_buffers()

Announce: https://lore.kernel.org/linux-cve-announce/2024040338-CVE-2024-26696-9dff@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1d1d1a7 ("mm: only enforce stable page writes if
the backing device requires it") in v3.9-rc1.
Fixed in v6.8-rc4.

Fixed status
cip/4.4: [61870bf424a21fe93d918909c6e7148f85f51278]
cip/4.4-rt: [61870bf424a21fe93d918909c6e7148f85f51278]
cip/4.4-st: [61870bf424a21fe93d918909c6e7148f85f51278]
mainline: [38296afe3c6ee07319e01bb249aa4bb47c07b534]
stable/4.19: [228742b2ddfb99dfd71e5a307e6088ab6836272e]
stable/5.10: [98a4026b22ff440c7f47056481bcbbe442f607d6]
stable/5.15: [7e9b622bd0748cc104d66535b76d9b3535f9dc0f]
stable/5.4: [862ee4422c38be5c249844a684b00d0dbe9d1e46]
stable/6.1: [8494ba2c9ea00a54d5b50e69b22c55a8958bce32]
stable/6.6: [ea5ddbc11613b55e5128c85f57b08f907abd9b28]
stable/6.7: [e38585401d464578d30f5868ff4ca54475c34f7d]

CVE-2024-26697: nilfs2: fix data corruption in dsync block recovery
for small block sizes

Announce: https://lore.kernel.org/linux-cve-announce/2024040338-CVE-2024-26697-9521@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc4.

Fixed status
cip/4.4: [3cd3a103704de7170df4b51e063c61e95fc14962]
cip/4.4-rt: [3cd3a103704de7170df4b51e063c61e95fc14962]
cip/4.4-st: [3cd3a103704de7170df4b51e063c61e95fc14962]
mainline: [67b8bcbaed4777871bb0dcc888fb02a614a98ab1]
stable/4.19: [5278c3eb6bf5896417572b52adb6be9d26e92f65]
stable/5.10: [364a66be2abdcd4fd426ffa44d9b8f40aafb3caa]
stable/5.15: [120f7fa2008e3bd8b7680b4ab5df942decf60fd5]
stable/5.4: [a6efe6dbaaf504f5b3f8a5c3f711fe54e7dda0ba]
stable/6.1: [9c9c68d64fd3284f7097ed6ae057c8441f39fcd3]
stable/6.6: [2e1480538ef60bfee5473dfe02b1ecbaf1a4aa0d]
stable/6.7: [2000016bab499074e6248ea85aeea7dd762355d9]

CVE-2024-26698: hv_netvsc: Fix race condition between netvsc_probe and
netvsc_remove

Announce: https://lore.kernel.org/linux-cve-announce/2024040338-CVE-2024-26698-36ac@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ac50476 ("hv_netvsc: Disable NAPI before closing
the VMBus channel") in v5.8-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc3.

Fixed status
mainline: [e0526ec5360a48ad3ab2e26e802b0532302a7e11]
stable/5.10: [9ec807e7b6f5fcf9499f3baa69f254bb239a847f]
stable/5.15: [7656372ae190e54e8c8cf1039725a5ea59fdf84a]
stable/6.1: [48a8ccccffbae10c91d31fc872db5c31aba07518]
stable/6.6: [22a77c0f5b8233237731df3288d067af51a2fd7b]
stable/6.7: [0e8875de9dad12805ff66e92cd5edea6a421f1cd]

CVE-2024-26699: drm/amd/display: Fix array-index-out-of-bounds in dcn35_clkmgr

Announce: https://lore.kernel.org/linux-cve-announce/2024040339-CVE-2024-26699-c700@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc5.
Affected file drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
was introduced by commit in 8774029f ("drm/amd/display: Add DCN35
CLK_MGR") in 6.7-rc1.

Fixed status
mainline: [46806e59a87790760870d216f54951a5b4d545bc]
stable/6.7: [ca400d8e0c1c9d79c08dfb6b7f966e26c8cae7fb]

CVE-2024-26700: drm/amd/display: Fix MST Null Ptr for RV

Announce: https://lore.kernel.org/linux-cve-announce/2024040339-CVE-2024-26700-a2b8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc4.
The compute_mst_dsc_configs_for_state() was introduced by commit
8c20a1e ("drm/amd/display: MST DSC compute fair share") in 5.6-rc1.
It seems as if 5.10 and 5.15 are affected.

Fixed status
mainline: [e6a7df96facdcf5b1f71eb3ec26f2f9f6ad61e57]
stable/6.1: [01d992088dce3945f70f49f34b0b911c5213c238]
stable/6.6: [7407c61f43b66e90ad127d0cdd13cbc9d87141a5]
stable/6.7: [5cd7185d2db76c42a9b7e69adad9591d9fca093f]

CVE-2024-26702: iio: magnetometer: rm3100: add boundary check for the
value read from RM3100_REG_TMRC

Announce: https://lore.kernel.org/linux-cve-announce/2024040339-CVE-2024-26702-acda@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 121354b ("iio: magnetometer: Add driver support
for PNI RM3100") in v5.0-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc5.

Fixed status
mainline: [792595bab4925aa06532a14dd256db523eb4fa5e]
stable/5.10: [36a49290d7e6d554020057a409747a092b1d3b56]
stable/5.15: [8d5838a473e8e6d812257c69745f5920e4924a60]
stable/5.4: [7200170e88e3ec54d9e9c63f07514c3cead11481]
stable/6.1: [176256ff8abff29335ecff905a09fb49e8dcf513]
stable/6.6: [1d8c67e94e9e977603473a543d4f322cf2c4aa01]
stable/6.7: [57d05dbbcd0b3dc0c252103b43012eef5d6430d1]

CVE-2024-26703: tracing/timerlat: Move hrtimer_init to timerlat_fd open()

Announce: https://lore.kernel.org/linux-cve-announce/2024040340-CVE-2024-26703-d60d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e88ed22 ("tracing/timerlat: Add user-space
interface") in v6.5-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc3.

Fixed status
mainline: [1389358bb008e7625942846e9f03554319b7fecc]
stable/6.6: [5f703935fdb559642d85b2088442ee55a557ae6d]
stable/6.7: [2354d29986ebd138f89c2b73fecf8237e0a4ad6b]

CVE-2024-26704: ext4: fix double-free of blocks due to wrong extents moved_len

Announce: https://lore.kernel.org/linux-cve-announce/2024040340-CVE-2024-26704-a082@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit fcf6b1b ("ext4: refactor ext4_move_extents code
base") in v3.18-rc2.
Fixed in v6.8-rc3.

Fixed status
cip/4.4: [052905e830d7a5f7bf023f09a028cc7546b38339]
cip/4.4-rt: [052905e830d7a5f7bf023f09a028cc7546b38339]
cip/4.4-st: [052905e830d7a5f7bf023f09a028cc7546b38339]
mainline: [55583e899a5357308274601364741a83e78d6ac4]
stable/4.19: [b4fbb89d722cbb16beaaea234b7230faaaf68c71]
stable/5.10: [d033a555d9a1cf53dbf3301af7199cc4a4c8f537]
stable/5.15: [afba9d11320dad5ce222ac8964caf64b7b4bedb1]
stable/5.4: [afbcad9ae7d6d11608399188f03a837451b6b3a1]
stable/6.1: [185eab30486ba3e7bf8b9c2e049c79a06ffd2bc1]
stable/6.6: [2883940b19c38d5884c8626483811acf4d7e148f]
stable/6.7: [559ddacb90da1d8786dd8ec4fd76bbfa404eaef6]

CVE-2024-26705: parisc: BTLB: Fix crash when setting up BTLB at CPU bringup

Announce: https://lore.kernel.org/linux-cve-announce/2024040340-CVE-2024-26705-c0ff@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e5ef93d ("parisc: BTLB: Initialize BTLB tables at
CPU startup") in v6.6-rc2.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc3.

Fixed status
mainline: [913b9d443a0180cf0de3548f1ab3149378998486]
stable/6.6: [54944f45470af5965fb9c28cf962ec30f38a8f5b]
stable/6.7: [aa52be55276614d33f22fbe7da36c40d6432d10b]

CVE-2024-26706: parisc: Fix random data corruption from exception handler

Announce: https://lore.kernel.org/linux-cve-announce/2024040341-CVE-2024-26706-844b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc3.
Since commit 4b9d2a731 ("parisc: Switch user access functions to
signal errors in r29 instead of r8") in 5.17-rc1,
use register r29 instead of register r8 to signal faults when
accessing user memory.
So, before 5.17 may not be affected.

Fixed status
mainline: [8b1d72395635af45410b66cc4c4ab37a12c4a831]
stable/6.1: [23027309b099ffc4efca5477009a11dccbdae592]
stable/6.6: [fa69a8063f8b27f3c7434a0d4f464a76a62f24d2]
stable/6.7: [ce31d79aa1f13a2345791f84935281a2c194e003]

CVE-2024-26707: net: hsr: remove WARN_ONCE() in send_hsr_supervision_frame()

Announce: https://lore.kernel.org/linux-cve-announce/2024040341-CVE-2024-26707-1153@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 121c33b ("net: hsr: introduce common code for skb
initialization") in v5.9-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc3.

Fixed status
mainline: [37e8c97e539015637cb920d3e6f1e404f707a06e]
stable/5.10: [0d8011a878fdf96123bc0d6a12e2fe7ced5fddfb]
stable/5.15: [de769423b2f053182a41317c4db5a927e90622a0]
stable/6.1: [56440799fc4621c279df16176f83a995d056023a]
stable/6.6: [923dea2a7ea9e1ef5ac4031fba461c1cc92e32b8]
stable/6.7: [547545e50c913861219947ce490c68a1776b9b51]

CVE-2024-26708: mptcp: really cope with fastopen race

Announce: https://lore.kernel.org/linux-cve-announce/2024040341-CVE-2024-26708-c98a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1e777f3 ("mptcp: add MSG_FASTOPEN sendmsg flag
support") in v6.2-rc1.
Introduced by commit 4fd19a3 ("mptcp: fix inconsistent state on
fastopen race") in v6.7-rc7.
These commits were backported to 6.6.
Fixed in v6.8-rc5.

Fixed status
mainline: [337cebbd850f94147cee05252778f8f78b8c337f]
stable/6.6: [4bfe217e075d04e63c092df9d40c608e598c2ef2]
stable/6.7: [e158fb9679d15a2317ec13b4f6301bd26265df2f]

CVE-2024-26709: powerpc/iommu: Fix the missing iommu_group_put()
during platform domain attach

Announce: https://lore.kernel.org/linux-cve-announce/2024040341-CVE-2024-26709-19b4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a8ca9fc ("powerpc/iommu: Do not do platform
domain attach atctions after probe") in v6.7-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc5.

Fixed status
mainline: [0846dd77c8349ec92ca0079c9c71d130f34cb192]
stable/6.7: [c90fdea9cac9eb419fc266e75d625cb60c8f7f6c]

CVE-2024-26710: powerpc/kasan: Limit KASAN thread size increase to 32KB

Announce: https://lore.kernel.org/linux-cve-announce/2024040342-CVE-2024-26710-6332@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 18f14afe2816 ("powerpc/64s: Increase default
stack  size to 32KB") in 6.8-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc5.

Fixed status
mainline: [f1acb109505d983779bbb7e20a1ee6244d2b5736]
stable/6.1: [4297217bcf1f0948a19c2bacc6b68d92e7778ad9]
stable/6.6: [4cc31fa07445879a13750cb061bb8c2654975fcb]
stable/6.7: [b29b16bd836a838b7690f80e37f8376414c74cbe]

CVE-2024-26711: iio: adc: ad4130: zero-initialize clock init data

Announce: https://lore.kernel.org/linux-cve-announce/2024040342-CVE-2024-26711-de47@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6209406 ("iio: adc: ad4130: add AD4130 driver")
in v6.2-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc5.

Fixed status
mainline: [a22b0a2be69a36511cb5b37d948b651ddf7debf3]
stable/6.6: [0e0dab37750926d4fb0144edb1c1ea0612fea273]
stable/6.7: [02876e2df02f8b17a593d77a0a7879a8109b27e1]

CVE-2024-26712: powerpc/kasan: Fix addr error caused by page alignment

Announce: https://lore.kernel.org/linux-cve-announce/2024040342-CVE-2024-26712-d713@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 663c0c9 ("powerpc/kasan: Fix shadow area set up
for modules.") in v5.4-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc5.

Fixed status
mainline: [4a7aee96200ad281a5cc4cf5c7a2e2a49d2b97b0]
stable/5.10: [230e89b5ad0a33f530a2a976b3e5e4385cb27882]
stable/5.15: [2738e0aa2fb24a7ab9c878d912dc2b239738c6c6]
stable/6.1: [0c09912dd8387e228afcc5e34ac5d79b1e3a1058]
stable/6.6: [0516c06b19dc64807c10e01bb99b552bdf2d7dbe]
stable/6.7: [70ef2ba1f4286b2b73675aeb424b590c92d57b25]

CVE-2024-26713: powerpc/pseries/iommu: Fix iommu initialisation during DLPAR add

Announce: https://lore.kernel.org/linux-cve-announce/2024040342-CVE-2024-26713-1b52@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a940904 ("powerpc/iommu: Add iommu_ops to report
capabilities and allow blocking domains") in v6.4-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc5.

Fixed status
mainline: [ed8b94f6e0acd652ce69bd69d678a0c769172df8]
stable/6.6: [9978d5b744e0227afe19e3bcb4c5f75442dde753]
stable/6.7: [d4f762d6403f7419de90d7749fa83dd92ffb0e1d]

CVE-2024-26714: interconnect: qcom: sc8180x: Mark CO0 BCM keepalive

Announce: https://lore.kernel.org/linux-cve-announce/2024040343-CVE-2024-26714-d9a8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9c8c6ba ("interconnect: qcom: Add SC8180x
providers") in v5.15-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc5.

Fixed status
mainline: [85e985a4f46e462a37f1875cb74ed380e7c0c2e0]
stable/6.1: [6616d3c4f8284a7b3ef978c916566bd240cea1c7]
stable/6.6: [d8e36ff40cf9dadb135f3a97341c02c9a7afcc43]
stable/6.7: [7a3a70dd08e4b7dffc2f86f2c68fc3812804b9d0]

CVE-2024-26715: usb: dwc3: gadget: Fix NULL pointer dereference in
dwc3_gadget_suspend

Announce: https://lore.kernel.org/linux-cve-announce/2024040343-CVE-2024-26715-20ed@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9772b47 ("usb: dwc3: gadget: Fix suspend/resume
during device mode") in v4.6-rc5.
This commit was backported to 4.4 by commit df2ca3271.
Fixed in v6.8-rc3.
Backporting the fix to 4.19
(https://lore.kernel.org/stable/2024021815-crate-unsettled-85a8@gregkh/),
5.4 (https://lore.kernel.org/stable/2024021814-anointer-vanish-667b@gregkh/),
and
5.10 (https://lore.kernel.org/stable/2024021813-bubbling-outage-eadc@gregkh/)
were failed.

Fixed status
mainline: [61a348857e869432e6a920ad8ea9132e8d44c316]
stable/5.15: [88936ceab6b426f1312327e9ef849c215c6007a7]
stable/6.1: [57e2e42ccd3cd6183228269715ed032f44536751]
stable/6.6: [c7ebd8149ee519d27232e6e4940e9c02071b568b]
stable/6.7: [36695d5eeeefe5a64b47d0336e7c8fc144e78182]

CVE-2024-26716: usb: core: Prevent null pointer dereference in
update_port_device_state

Announce: https://lore.kernel.org/linux-cve-announce/2024040343-CVE-2024-26716-74a8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 83cb260 ("usb: core: add sysfs entry for usb
device state") in v6.5-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc3.

Fixed status
mainline: [12783c0b9e2c7915a50d5ec829630ff2da50472c]
stable/6.6: [ed85777c640cf9e6920bb1b60ed8cd48e1f4d873]
stable/6.7: [465b545d1d7ef282192ddd4439b08279bdb13f6f]

CVE-2024-26717: HID: i2c-hid-of: fix NULL-deref on failed power up

Announce: https://lore.kernel.org/linux-cve-announce/2024040344-CVE-2024-26717-0d01@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b33752c ("HID: i2c-hid: Reorganize so ACPI and OF
are separate modules") in v5.12-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc3.

Fixed status
mainline: [00aab7dcb2267f2aef59447602f34501efe1a07f]
stable/5.15: [62f5d219edbd174829aa18d4b3d97cd5fefbb783]
stable/6.1: [d7d7a0e3b6f5adc45f23667cbb919e99093a5b5c]
stable/6.6: [4cad91344a62536a2949873bad6365fbb6232776]
stable/6.7: [e28d6b63aeecbda450935fb58db0e682ea8212d3]

CVE-2024-26718: dm-crypt, dm-verity: disable tasklets

Announce: https://lore.kernel.org/linux-cve-announce/2024040344-CVE-2024-26718-7259@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 39d42fa ("dm crypt: add flags to optionally
bypass kcryptd workqueues") in v5.9-rc1.
Introduced by commit 5721d4e ("dm verity: Add optional
"try_verify_in_tasklet" feature") in v6.0-rc1.
These commits are not backported to older stable kernels.
Fixed in v6.8-rc3.

Fixed status
mainline: [0a9bab391e336489169b95cb0d4553d921302189]
stable/6.1: [30884a44e0cedc3dfda8c22432f3ba4078ec2d94]
stable/6.6: [5735a2671ffb70ea29ca83969fe01316ee2ed6fc]
stable/6.7: [0c45a20cbe68bc4d681734f5c03891124a274257]

CVE-2024-26719: nouveau: offload fence uevents work to workqueue

Announce: https://lore.kernel.org/linux-cve-announce/2024040344-CVE-2024-26719-b66e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc3.

Fixed status
mainline: [39126abc5e20611579602f03b66627d7cd1422f0]
stable/6.6: [cc0037fa592d56e4abb9c7d1c52c4d2dc25cd906]
stable/6.7: [985d053f7633d8b539ab1531738d538efac678a9]

CVE-2024-26720: mm/writeback: fix possible divide-by-zero in
wb_dirty_limits(), again

Announce: https://lore.kernel.org/linux-cve-announce/2024040344-CVE-2024-26720-06fa@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f678959 ("mm/page-writeback.c: fix divide by zero
in bdi_dirty_limits()") in v3.16.
Fixed in v6.8-rc3.

Fixed status
cip/4.4: [c6db6ae566da0e109616d2517c7047284049d5dc]
cip/4.4-rt: [c6db6ae566da0e109616d2517c7047284049d5dc]
cip/4.4-st: [c6db6ae566da0e109616d2517c7047284049d5dc]
mainline: [9319b647902cbd5cc884ac08a8a6d54ce111fc78]
stable/4.19: [c593d26fb5d577ef31b6e49a31e08ae3ebc1bc1e]
stable/5.10: [81e7d2530d458548b90a5c5e76b77ad5e5d1c0df]
stable/5.15: [5099871b370335809c0fd1abad74d9c7c205d43f]
stable/5.4: [1f12e4b3284d6c863f272eb2de0d4248ed211cf4]
stable/6.1: [16b1025eaa8fc223ab4273ece20d1c3a4211a95d]
stable/6.6: [ec18ec230301583395576915d274b407743d8f6c]
stable/6.7: [65977bed167a92e87085e757fffa5798f7314c9f]

CVE-2024-26721: drm/i915/dsc: Fix the macro that calculates
DSCC_/DSCA_ PPS reg address

Announce: https://lore.kernel.org/linux-cve-announce/2024040345-CVE-2024-26721-3377@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit bd07725 ("drm/i915/vdsc: Add function to read any
PPS register") in v6.7-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc5.

Fixed status
mainline: [962ac2dce56bb3aad1f82a4bbe3ada57a020287c]
stable/6.7: [ff5999fb03f467e1e7159f0ddb199c787f7512b9]

CVE-2024-26722: ASoC: rt5645: Fix deadlock in rt5645_jack_detect_work()

Announce: https://lore.kernel.org/linux-cve-announce/2024040345-CVE-2024-26722-4df2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cdba430 ("ASoC: rt5650: add mutex to avoid the
jack detection failure") in v6.7-rc5.
This commit was backported to 4.19, 5.10, 5.15, 5.4, 6.1, and 6.6.
Fixed in v6.8-rc5.

Fixed status
mainline: [6ef5d5b92f7117b324efaac72b3db27ae8bb3082]
stable/4.19: [3dd2d99e2352903d0e0b8769e6c9b8293c7454b2]
stable/5.10: [4a98bc739d0753a5810ce5630943cd7614c7717e]
stable/5.15: [d14b8e2005f36319df9412d42037416d64827f6b]
stable/5.4: [422d5243b9f780abd3d39da2b746e3915677b07d]
stable/6.1: [1f0d7792e9023e8658e901b7b76a555f6aa052ec]
stable/6.6: [050ad2ca0ac169dd9e552075d2c6af1bbb46534c]
stable/6.7: [ed5b8b735369b40d6c1f8ef3e62d369f74b4c491]

CVE-2024-26723: lan966x: Fix crash when adding interface under a lag

Announce: https://lore.kernel.org/linux-cve-announce/2024040345-CVE-2024-26723-49ee@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cabc9d4 ("net: lan966x: Add lag support for
lan966x") in v6.1-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc5.

Fixed status
mainline: [15faa1f67ab405d47789d4702f587ec7df7ef03e]
stable/6.1: [b9357489c46c7a43999964628db8b47d3a1f8672]
stable/6.6: [48fae67d837488c87379f0c9f27df7391718477c]
stable/6.7: [2a492f01228b7d091dfe38974ef40dccf8f9f2f1]

CVE-2024-26724: net/mlx5: DPLL, Fix possible use after free after
delayed work timer triggers

Announce: https://lore.kernel.org/linux-cve-announce/2024040345-CVE-2024-26724-4e19@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 496fd0a ("mlx5: Implement SyncE support using
DPLL infrastructure") in v6.7-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc5.

Fixed status
mainline: [aa1eec2f546f2afa8c98ec41e5d8ee488165d685]
stable/6.7: [1596126ea50228f0ed96697bae4e9368fda02c56]

CVE-2024-26725: dpll: fix possible deadlock during netlink dump operation

Announce: https://lore.kernel.org/linux-cve-announce/2024040346-CVE-2024-26725-d16b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9d71b54 ("dpll: netlink: Add DPLL framework base
functions") in v6.7-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc5.

Fixed status
mainline: [53c0441dd2c44ee93fddb5473885fd41e4bc2361]
stable/6.7: [087739cbd0d0b87b6cec2c0799436ac66e24acc8]

CVE-2024-26726: btrfs: don't drop extent_map for free space inode on write error

Announce: https://lore.kernel.org/linux-cve-announce/2024040346-CVE-2024-26726-fed0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc5.
Backporting the fix to 4.19
(https://lore.kernel.org/stable/2024021802-crunchy-presoak-d1f4@gregkh/),
5.4 (https://lore.kernel.org/stable/2024021800-willed-chug-3616@gregkh/),
5.10 (https://lore.kernel.org/stable/2024021858-sharpie-diffusive-52e1@gregkh/),
and
5.15 (https://lore.kernel.org/stable/2024021856-vigorous-supper-1ca1@gregkh/)
were failed.

Fixed status
mainline: [5571e41ec6e56e35f34ae9f5b3a335ef510e0ade]
stable/6.1: [02f2b95b00bf57d20320ee168b30fb7f3db8e555]
stable/6.6: [7bddf18f474f166c19f91b2baf67bf7c5eda03f7]
stable/6.7: [a4b7741c8302e28073bfc6dd1c2e73598e5e535e]

CVE-2024-26727: btrfs: do not ASSERT() if the newly created subvolume
already got read

Announce: https://lore.kernel.org/linux-cve-announce/2024040346-CVE-2024-26727-3ec3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2dfb1e4 ("btrfs: preallocate anon block device at
first phase of snapshot creation") in v5.9-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc4.

Fixed status
mainline: [e03ee2fe873eb68c1f9ba5112fee70303ebf9dfb]
stable/5.10: [3f5d47eb163bceb1b9e613c9003bae5fefc0046f]
stable/5.15: [e31546b0f34af21738c4ceac47d662c00ee6382f]
stable/6.1: [66b317a2fc45b2ef66527ee3f8fa08fb5beab88d]
stable/6.6: [833775656d447c545133a744a0ed1e189ce61430]
stable/6.7: [5a172344bfdabb46458e03708735d7b1a918c468]

CVE-2024-26728: drm/amd/display: fix null-pointer dereference on edid reading

Announce: https://lore.kernel.org/linux-cve-announce/2024040357-CVE-2024-26728-316a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0e859fa ("drm/amd/display: Remove unwanted drm
edid references") in v6.7-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc6.

Fixed status
mainline: [9671761792156f2339627918bafcd713a8a6f777]
stable/6.7: [2d392f7268a1a9bfbd98c831f0f4c964e59aa145]

CVE-2024-26729: drm/amd/display: Fix potential null pointer
dereference in dc_dmub_srv

Announce: https://lore.kernel.org/linux-cve-announce/2024040357-CVE-2024-26729-2f3e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 028bac5 ("drm/amd/display: decouple dmcub
execution to reduce lock granularity") in v6.7-rc1.
Introduced by commit 65138eb ("drm/amd/display: Add DCN35 DMUB") in v6.7-rc1.
These commits are not backported to older stable kernels.
Fixed in v6.8-rc6.

Fixed status
mainline: [d2b48f340d9e4a8fbeb1cdc84cd8da6ad143a907]
stable/6.7: [351080ba3414c96afff0f1338b4aeb2983195b80]

CVE-2024-26730: hwmon: (nct6775) Fix access to temperature
configuration registers

Announce: https://lore.kernel.org/linux-cve-announce/2024040358-CVE-2024-26730-4c35@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b7f1f7b ("hwmon: (nct6775) Additional TEMP
registers for nct6799") in v6.6-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc6.

Fixed status
mainline: [d56e460e19ea8382f813eb489730248ec8d7eb73]
stable/6.6: [f006c45a3ea424f8f6c8e4b9283bc245ce2a4d0f]
stable/6.7: [c196387820c9214c5ceaff56d77303c82514b8b1]

CVE-2024-26731: bpf, sockmap: Fix NULL pointer dereference in
sk_psock_verdict_data_ready()

Announce: https://lore.kernel.org/linux-cve-announce/2024040358-CVE-2024-26731-e084@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6df7f76 ("bpf, sockmap: Wake up polling after
data copy") in v6.4-rc4.
This commit was backported to 6.1.
Fixed in v6.8-rc6.

Fixed status
mainline: [4cd12c6065dfcdeba10f49949bffcf383b3952d8]
stable/6.1: [4588b13abcbd561ec67f5b3c1cb2eff690990a54]
stable/6.6: [9b099ed46dcaf1403c531ff02c3d7400fa37fa26]
stable/6.7: [d61608a4e394f23e0dca099df9eb8e555453d949]

CVE-2024-26732: net: implement lockless setsockopt(SO_PEEK_OFF)

Announce: https://lore.kernel.org/linux-cve-announce/2024040358-CVE-2024-26732-8cda@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 859051d ("bpf: Implement cgroup sockaddr hooks
for unix sockets") in v6.7-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc6.

Fixed status
mainline: [56667da7399eb19af857e30f41bea89aa6fa812c]
stable/6.7: [897f75e2cde8a5f9f7529b55249af1fa4248c83b]

CVE-2024-26733: arp: Prevent overflow in arp_req_get().

Announce: https://lore.kernel.org/linux-cve-announce/2024040358-CVE-2024-26733-617f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.8-rc6.

Fixed status
mainline: [a7d6027790acea24446ddd6632d394096c0f4667]
stable/5.10: [dbc9b22d0ed319b4e29034ce0a3fe32a3ee2c587]
stable/5.15: [97eaa2955db4120ce6ec2ef123e860bc32232c50]
stable/6.1: [f119f2325ba70cbfdec701000dcad4d88805d5b0]
stable/6.6: [a3f2c083cb575d80a7627baf3339e78fedccbb91]
stable/6.7: [3ab0d6f8289ba8402ca95a9fc61a34909d5e1f3a]

CVE-2024-26734: devlink: fix possible use-after-free and memory leaks
in devlink_init()

Announce: https://lore.kernel.org/linux-cve-announce/2024040359-CVE-2024-26734-277b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 687125b ("devlink: split out core code") in v6.3-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc6.

Fixed status
mainline: [def689fc26b9a9622d2e2cb0c4933dd3b1c8071c]
stable/6.6: [919092bd5482b7070ae66d1daef73b600738f3a2]
stable/6.7: [e91d3561e28d7665f4f837880501dc8755f635a9]

CVE-2024-26735: ipv6: sr: fix possible use-after-free and null-ptr-deref

Announce: https://lore.kernel.org/linux-cve-announce/2024040359-CVE-2024-26735-462f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 915d7e5 ("ipv6: sr: add code base for control
plane support of SR-IPv6") in v4.10-rc1.
This commit is not backported to 4.4.
Fixed in v6.8-rc6.

Fixed status
mainline: [5559cea2d5aa3018a5f00dd2aca3427ba09b386b]
stable/4.19: [953f42934533c151f440cd32390044d2396b87aa]
stable/5.10: [65c38f23d10ff79feea1e5d50b76dc7af383c1e6]
stable/5.15: [91b020aaa1e59bfb669d34c968e3db3d5416bcee]
stable/5.4: [82831e3ff76ef09fb184eb93b79a3eb3fb284f1d]
stable/6.1: [8391b9b651cfdf80ab0f1dc4a489f9d67386e197]
stable/6.6: [9e02973dbc6a91e40aa4f5d87b8c47446fbfce44]
stable/6.7: [02b08db594e8218cfbc0e4680d4331b457968a9b]

CVE-2024-26736: afs: Increase buffer size in afs_update_volume_status()

Announce: https://lore.kernel.org/linux-cve-announce/2024040359-CVE-2024-26736-284d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d2ddc77 ("afs: Overhaul volume and server record
caching and fileserver rotation") in v4.15-rc1.
This commit is not backported to 4.4.
Fixed in v6.8-rc6.

Fixed status
mainline: [6ea38e2aeb72349cad50e38899b0ba6fbcb2af3d]
stable/5.10: [d9b5e2b7a8196850383c70d099bfd39e81ab6637]
stable/5.15: [e56662160fc24d28cb75ac095cc6415ae1bda43e]
stable/5.4: [5c27d85a69fa16a08813ba37ddfb4bbc9a1ed6b5]
stable/6.1: [e8530b170e464017203e3b8c6c49af6e916aece1]
stable/6.6: [6e6065dd25b661420fac19c34282b6c626fcd35e]
stable/6.7: [d34a5e57632bb5ff825196ddd9a48ca403626dfa]

CVE-2024-26737: bpf: Fix racing between bpf_timer_cancel_and_free and
bpf_timer_cancel

Announce: https://lore.kernel.org/linux-cve-announce/2024040359-CVE-2024-26737-a9c3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b00628b ("bpf: Introduce bpf timers.") in v5.15-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc6.

Fixed status
mainline: [0281b919e175bb9c3128bd3872ac2903e9436e3f]
stable/5.15: [5268bb02107b9eedfdcd51db75b407d10043368c]
stable/6.1: [addf5e297e6cbf5341f9c07720693ca9ba0057b5]
stable/6.6: [8327ed12e8ebc5436bfaa1786c49988894f9c8a6]
stable/6.7: [7d80a9e745fa5b47da3bca001f186c02485c7c33]

CVE-2024-26738: powerpc/pseries/iommu: DLPAR add doesn't completely
initialize pci_controller

Announce: https://lore.kernel.org/linux-cve-announce/2024040300-CVE-2024-26738-844b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a940904 ("powerpc/iommu: Add iommu_ops to report
capabilities and allow blocking domains") in v6.4-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc6.

Fixed status
mainline: [a5c57fd2e9bd1c8ea8613a8f94fd0be5eccbf321]
stable/6.6: [b8315b2e25b4e68e42fcb74630f824b9a5067765]
stable/6.7: [46e36ebd5e00a148b67ed77c1d31675996f77c25]

CVE-2024-26739: net/sched: act_mirred: don't override retval if we
already lost the skb

Announce: https://lore.kernel.org/linux-cve-announce/2024040300-CVE-2024-26739-170e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e5cf1ba ("act_mirred: use TC_ACT_REINSERT when
possible") in v4.19-rc1.
This commit is not backported to 4.4.
Fixed in v6.8-rc6.

Fixed status
mainline: [166c2c8a6a4dc2e4ceba9e10cfe81c3e469e3210]
stable/6.6: [28cdbbd38a4413b8eff53399b3f872fd4e80db9d]
stable/6.7: [f4e294bbdca8ac8757db436fc82214f3882fc7e7]

CVE-2024-26740: net/sched: act_mirred: use the backlog for mirred ingress

Announce: https://lore.kernel.org/linux-cve-announce/2024040300-CVE-2024-26740-4d6f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 53592b3 ("net/sched: act_mirred: Implement
ingress actions") in v4.10-rc1.
This commit is backported to 4.4.
Fixed in v6.8-rc6.

Fixed status
mainline: [52f671db18823089a02f07efc04efdb2272ddc17]
stable/6.6: [7c787888d164689da8b1b115f3ef562c1e843af4]
stable/6.7: [60ddea1600bc476e0f5e02bce0e29a460ccbf0be]

CVE-2024-26741: dccp/tcp: Unhash sk from ehash for tb2 alloc failure
after check_estalblished().

Announce: https://lore.kernel.org/linux-cve-announce/2024040300-CVE-2024-26741-961e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 28044fc ("net: Add a bhash2 table hashed by port
and address") in v6.1-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc6.

Fixed status
mainline: [66b60b0c8c4a163b022a9f0ad6769b0fd3dc662f]
stable/6.1: [729bc77af438a6e67914c97f6f3d3af8f72c0131]
stable/6.6: [334a8348b2df26526f3298848ad6864285592caf]
stable/6.7: [f8c4a6b850882bc47aaa864b720c7a2ee3102f39]

CVE-2024-26742: scsi: smartpqi: Fix disable_managed_interrupts

Announce: https://lore.kernel.org/linux-cve-announce/2024040301-CVE-2024-26742-1b19@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cf15c3e ("scsi: smartpqi: Add module param to
disable managed ints") in v6.0-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc6.

Fixed status
mainline: [5761eb9761d2d5fe8248a9b719efc4d8baf1f24a]
stable/6.1: [3c31b18a8dd8b7bf36af1cd723d455853b8f94fe]
stable/6.6: [4f5b15c15e6016efb3e14582d02cc4ddf57227df]
stable/6.7: [b9433b25cb06c415c9cb24782599649a406c8d6d]

CVE-2024-26743: RDMA/qedr: Fix qedr_create_user_qp error flow

Announce: https://lore.kernel.org/linux-cve-announce/2024040301-CVE-2024-26743-6034@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit df15856 ("RDMA/qedr: restructure functions that
create/destroy QPs") in v4.11-rc1.
This commit is not backported to 4.4.
Fixed in v6.8-rc6.

Fixed status
mainline: [5ba4e6d5863c53e937f49932dee0ecb004c65928]
stable/5.10: [5639414a52a29336ffa1ede80a67c6d927acbc5a]
stable/5.15: [135e5465fefa463c5ec93c4eede48b9fedac894a]
stable/6.1: [7f31a244c753aacf40b71d01f03ca6742f81bbbc]
stable/6.6: [95175dda017cd4982cd47960536fa1de003d3298]
stable/6.7: [bab8875c06ebda5e01c5c4cab30022aed85c14e6]

CVE-2024-26744: RDMA/srpt: Support specifying the srpt_service_guid parameter

Announce: https://lore.kernel.org/linux-cve-announce/2024040301-CVE-2024-26744-d344@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a42d985 ("ib_srpt: Initial SRP Target merge for
v3.3-rc1") in v3.3-rc1.
Fixed in v6.8-rc6.

Fixed status
mainline: [fdfa083549de5d50ebf7f6811f33757781e838c0]
stable/4.19: [84f1dac960cfa210a3b7a7522e6c2320ae91932b]
stable/5.10: [5a5c039dac1b1b7ba3e91c791f4421052bf79b82]
stable/5.15: [989af2f29342a9a7c7515523d879b698ac8465f4]
stable/6.1: [aee4dcfe17219fe60f2821923adea98549060af8]
stable/6.6: [fe2a73d57319feab4b3b175945671ce43492172f]
stable/6.7: [c99a827d3cff9f84e1cb997b7cc6386d107aa74d]

CVE-2024-26747: usb: roles: fix NULL pointer issue when put module's reference

Announce: https://lore.kernel.org/linux-cve-announce/2024040301-CVE-2024-26747-50b0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5c54fca ("usb: roles: Take care of driver module
reference counting") in v4.19-rc6.
This commit is not backported to 4.4.
Fixed in v6.8-rc6.

Fixed status
mainline: [1c9be13846c0b2abc2480602f8ef421360e1ad9e]
stable/5.10: [e279bf8e51893e1fe160b3d8126ef2dd00f661e1]
stable/5.15: [ef982fc41055fcebb361a92288d3225783d12913]
stable/6.1: [0158216805ca7e498d07de38840d2732166ae5fa]
stable/6.6: [4b45829440b1b208948b39cc71f77a37a2536734]
stable/6.7: [01f82de440f2ab07c259b7573371e1c42e5565db]

CVE-2024-26748: usb: cdns3: fix memory double free when handle zero packet

Announce: https://lore.kernel.org/linux-cve-announce/2024040302-CVE-2024-26748-f000@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7733f6c ("usb: cdns3: Add Cadence USB3 DRD
Driver") in v5.4-rc1.
This commit is not backported to 4.x.
Fixed in v6.8-rc6.

Fixed status
mainline: [5fd9e45f1ebcd57181358af28506e8a661a260b3]
stable/5.10: [1e204a8e9eb514e22a6567fb340ebb47df3f3a48]
stable/5.15: [3a2a909942b5335b7ea66366d84261b3ed5f89c8]
stable/5.4: [aad6132ae6e4809e375431f8defd1521985e44e7]
stable/6.1: [9a52b694b066f299d8b9800854a8503457a8b64c]
stable/6.6: [70e8038813f9d3e72df966748ebbc40efe466019]
stable/6.7: [92d20406a3d4ff3e8be667c79209dc9ed31df5b3]

CVE-2024-26749: usb: cdns3: fixed memory use after free at
cdns3_gadget_ep_disable()

Announce: https://lore.kernel.org/linux-cve-announce/2024040302-CVE-2024-26749-eac4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7733f6c ("usb: cdns3: Add Cadence USB3 DRD
Driver") in v5.4-rc1.
This commit is not backported to 4.x.
Fixed in v6.8-rc6.

Fixed status
mainline: [cd45f99034b0c8c9cb346dd0d6407a95ca3d36f6]
stable/5.10: [b40328eea93c75a5645891408010141a0159f643]
stable/5.15: [4e5c73b15d95452c1ba9c771dd013a3fbe052ff3]
stable/5.4: [cfa9abb5570c489dabf6f7fb3a066cc576fc8824]
stable/6.1: [2134e9906e17b1e5284300fab547869ebacfd7d9]
stable/6.6: [29e42e1578a10c611b3f1a38f3229b2d664b5d16]
stable/6.7: [9a07244f614bc417de527b799da779dcae780b5d]

CVE-2024-26751: ARM: ep93xx: Add terminator to gpiod_lookup_table

Announce: https://lore.kernel.org/linux-cve-announce/2024040302-CVE-2024-26751-fd31@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b2e6355 ("i2c: gpio: Convert to use descriptors")
in v4.15-rc1.
This commit is not backported to 4.4.
Fixed in v6.8-rc6.

Fixed status
mainline: [fdf87a0dc26d0550c60edc911cda42f9afec3557]
stable/4.19: [9e200a06ae2abb321939693008290af32b33dd6e]
stable/5.10: [70d92abbe29692a3de8697ae082c60f2d21ab482]
stable/5.15: [eec6cbbfa1e8d685cc245cfd5626d0715a127a48]
stable/5.4: [999a8bb70da2946336327b4480824d1691cae1fa]
stable/6.1: [786f089086b505372fb3f4f008d57e7845fff0d8]
stable/6.6: [97ba7c1f9c0a2401e644760d857b2386aa895997]
stable/6.7: [6abe0895b63c20de06685c8544b908c7e413efa8]

CVE-2024-26752: l2tp: pass correct message length to ip6_append_data

Announce: https://lore.kernel.org/linux-cve-announce/2024040302-CVE-2024-26752-cb0a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9d4c758 ("ipv4, ipv6: Fix handling of transhdrlen
in __ip{,6}_append_data()") in v6.6-rc5.
Fixed in v6.8-rc6.

Fixed status
cip/4.4: [e4d9ba7b6e13a2d6611a039d01f1f6b7313667db]
cip/4.4-rt: [e4d9ba7b6e13a2d6611a039d01f1f6b7313667db]
cip/4.4-st: [e4d9ba7b6e13a2d6611a039d01f1f6b7313667db]
mainline: [359e54a93ab43d32ee1bff3c2f9f10cb9f6b6e79]
stable/4.19: [4c3ce64bc9d36ca9164dd6c77ff144c121011aae]
stable/5.10: [dcb4d14268595065c85dc5528056713928e17243]
stable/5.15: [0da15a70395182ee8cb75716baf00dddc0bea38d]
stable/5.4: [c1d3a84a67db910ce28a871273c992c3d7f9efb5]
stable/6.1: [13cd1daeea848614e585b2c6ecc11ca9c8ab2500]
stable/6.6: [804bd8650a3a2bf3432375f8c97d5049d845ce56]
stable/6.7: [83340c66b498e49353530e41542500fc8a4782d6]

CVE-2024-26753: crypto: virtio/akcipher - Fix stack overflow on memcpy

Announce: https://lore.kernel.org/linux-cve-announce/2024040303-CVE-2024-26753-b93a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 59ca6c9 ("virtio-crypto: implement RSA
algorithm") in v5.18-rc1.
This commit is backported to 5.10.
Fixed in v6.8-rc6.

Fixed status
mainline: [c0ec2a712daf133d9996a8a1b7ee2d4996080363]
stable/5.10: [37077ed16c7793e21b005979d33f8a61565b7e86]
stable/6.1: [62f361bfea60c6afc3df09c1ad4152e6507f6f47]
stable/6.6: [b0365460e945e1117b47cf7329d86de752daff63]
stable/6.7: [ef1e47d50324e232d2da484fe55a54274eeb9bc1]

CVE-2024-26754: gtp: fix use-after-free and null-ptr-deref in
gtp_genl_dump_pdp()

Announce: https://lore.kernel.org/linux-cve-announce/2024040303-CVE-2024-26754-b34f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 459aa66 ("gtp: add initial driver for datapath of
GPRS Tunneling Protocol (GTP-U)") in v4.7-rc1.
This commit is not backported to 4.4.
Fixed in v6.8-rc6.

Fixed status
mainline: [136cfaca22567a03bbb3bf53a43d8cb5748b80ec]
stable/4.19: [f0ecdfa679189d26aedfe24212d4e69e42c2c861]
stable/5.10: [2e534fd15e5c2ca15821c897352cf0e8a3e30dca]
stable/5.15: [a576308800be28f2eaa099e7caad093b97d66e77]
stable/5.4: [f8cbd1791900b5d96466eede8e9439a5b9ca4de7]
stable/6.1: [3963f16cc7643b461271989b712329520374ad2a]
stable/6.6: [ba6b8b02a3314e62571a540efa96560888c5f03e]
stable/6.7: [5013bd54d283eda5262c9ae3bcc966d01daf8576]

CVE-2024-26755: md: Don't suspend the array for interrupted reshape

Announce: https://lore.kernel.org/linux-cve-announce/2024040303-CVE-2024-26755-947e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit bc08041 ("md: suspend array in md_start_sync() if
array need reconfiguration") in v6.7-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc6.

Fixed status
mainline: [9e46c70e829bddc24e04f963471e9983a11598b7]
stable/6.7: [60d6130d0ac1d883ed93c2a1e10aadb60967fd48]

CVE-2024-26756: md: Don't register sync_thread for reshape directly

Announce: https://lore.kernel.org/linux-cve-announce/2024040303-CVE-2024-26756-135f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f670557 ("[PATCH] md: Checkpoint and allow
restart of raid5 reshape") in v2.6.20.16.
Introduced by commit f52f5c7 ("md: fix stopping sync thread") in v6.7-rc5.
Fixed in v6.8-rc6.

Fixed status
mainline: [ad39c08186f8a0f221337985036ba86731d6aafe]
stable/6.7: [13b520fb62b772e408f9b79c5fe18ad414e90417]

CVE-2024-26757: md: Don't ignore read-only array in md_check_recovery()

Announce: https://lore.kernel.org/linux-cve-announce/2024040304-CVE-2024-26757-7f96@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ecbfb9f ("dm raid: add raid level takeover
support") in v4.8-rc1.
Introduced by commit f52f5c7 ("md: fix stopping sync thread") in v6.7-rc5.
Fixed in v6.8-rc6.

Fixed status
mainline: [55a48ad2db64737f7ffc0407634218cc6e4c513b]
stable/6.7: [2ea169c5a0b1134d573d07fc27a16f327ad0e7d3]

CVE-2024-26758: md: Don't ignore suspended array in md_check_recovery()

Announce: https://lore.kernel.org/linux-cve-announce/2024040304-CVE-2024-26758-dcc3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 68866e4 ("MD: no sync IO while suspended") in v3.0-rc4.
Introduced by commit f52f5c7 ("md: fix stopping sync thread") in v6.7-rc5.
Fixed in v6.8-rc6.

Fixed status
mainline: [1baae052cccd08daf9a9d64c3f959d8cdb689757]
stable/6.7: [a55f0d6179a19c6b982e2dc344d58c98647a3be0]

CVE-2024-26759: mm/swap: fix race when skipping swapcache

Announce: https://lore.kernel.org/linux-cve-announce/2024040304-CVE-2024-26759-45f1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0bcac06 ("mm, swap: skip swapcache for swapin of
synchronous device") in v4.15-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc6.

Fixed status
mainline: [13ddaf26be324a7f951891ecd9ccd04466d27458]
stable/6.1: [2dedda77d4493f3e92e414b272bfa60f1f51ed95]
stable/6.6: [305152314df82b22cf9b181f3dc5fc411002079a]
stable/6.7: [d183a4631acfc7af955c02a02e739cec15f5234d]

CVE-2024-26760: scsi: target: pscsi: Fix bio_put() for error case

Announce: https://lore.kernel.org/linux-cve-announce/2024040305-CVE-2024-26760-560a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 066ff57 ("block: turn bio_kmalloc into a simple
kmalloc wrapper") in v5.19-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc6.

Fixed status
mainline: [de959094eb2197636f7c803af0943cb9d3b35804]
stable/6.1: [f49b20fd0134da84a6bd8108f9e73c077b7d6231]
stable/6.6: [4ebc079f0c7dcda1270843ab0f38ab4edb8f7921]
stable/6.7: [1cfe9489fb563e9a0c9cdc5ca68257a44428c2ec]

CVE-2024-26761: cxl/pci: Fix disabling memory if DVSEC CXL Range does
not match a CFMWS window

Announce: https://lore.kernel.org/linux-cve-announce/2024040305-CVE-2024-26761-0646@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 34e37b4 ("cxl/port: Enable HDM Capability after
validating DVSEC Ranges") in v5.19-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc6.

Fixed status
mainline: [0cab687205986491302cd2e440ef1d253031c221]
stable/6.1: [031217128990d7f0ab8c46db1afb3cf1e075fd29]
stable/6.6: [2cc1a530ab31c65b52daf3cb5d0883c8b614ea69]
stable/6.7: [3a3181a71935774bda2398451256d7441426420b]

CVE-2024-26762: cxl/pci: Skip to handle RAS errors if CXL.mem device is detached

Announce: https://lore.kernel.org/linux-cve-announce/2024040305-CVE-2024-26762-b719@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6ac0788 ("cxl/pci: Add RCH downstream port error
logging") in v6.7-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc6.

Fixed status
mainline: [eef5c7b28dbecd6b141987a96db6c54e49828102]
stable/6.7: [21e5e84f3f63fdf44e49642a6e45cd895e921a84]

CVE-2024-26763: dm-crypt: don't modify the data when using
authenticated encryption

Announce: https://lore.kernel.org/linux-cve-announce/2024040305-CVE-2024-26763-4627@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc6.
This fix mab be applied to Linux 4.4.

Fixed status
mainline: [50c70240097ce41fe6bce6478b80478281e4d0f7]
stable/4.19: [43a202bd552976497474ae144942e32cc5f34d7e]
stable/5.10: [3c652f6fa1e1f9f02c3fbf359d260ad153ec5f90]
stable/5.15: [1a4371db68a31076afbe56ecce34fbbe6c80c529]
stable/5.4: [0dccbb93538fe89a86c6de31d4b1c8c560848eaa]
stable/6.1: [e08c2a8d27e989f0f5b0888792643027d7e691e6]
stable/6.6: [64ba01a365980755732972523600a961c4266b75]
stable/6.7: [d9e3763a505e50ba3bd22846f2a8db99429fb857]

CVE-2024-26764: fs/aio: Restrict kiocb_set_cancel_fn() to I/O
submitted via libaio

Announce: https://lore.kernel.org/linux-cve-announce/2024040306-CVE-2024-26764-c1e7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc6.
The aio_complete_rw() was introduced by commit 54843f ("aio: refactor
read/write iocb setup") in 4.18-rc1.

Fixed status
mainline: [b820de741ae48ccf50dd95e297889c286ff4f760]
stable/4.19: [337b543e274fe7a8f47df3c8293cc6686ffa620f]
stable/5.10: [ea1cd64d59f22d6d13f367d62ec6e27b9344695f]
stable/5.15: [d7b6fa97ec894edd02f64b83e5e72e1aa352f353]
stable/5.4: [b4eea7a05ee0ab5ab0514421e6ba8c5d249cf942]
stable/6.1: [18f614369def2a11a52f569fe0f910b199d13487]
stable/6.6: [e7e23fc5d5fe422827c9a43ecb579448f73876c7]
stable/6.7: [1dc7d74fe456944a9b1c57bd776280249f441ac6]

CVE-2024-26765: LoongArch: Disable IRQ before init_fn() for nonboot CPUs

Announce: https://lore.kernel.org/linux-cve-announce/2024040306-CVE-2024-26765-157f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc6.
LoongArch was introduced in 5.19. So 4.x, 5.4, 5.10, and 5.15 are not affected.

Fixed status
mainline: [1001db6c42e4012b55e5ee19405490f23e033b5a]
stable/6.1: [a262b78dd085dbe9b3c75dc1d9c4cd102b110b53]
stable/6.6: [dffdf7c783ef291eef38a5a0037584fd1a7fa464]
stable/6.7: [8bf2ca8c60712af288b88ba80f8e4df4573d923f]

CVE-2024-26766: IB/hfi1: Fix sdma.h tx->num_descs off-by-one error

Announce: https://lore.kernel.org/linux-cve-announce/2024040306-CVE-2024-26766-6b6a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit fd8958e ("IB/hfi1: Fix sdma.h tx->num_descs
off-by-one errors") in v6.3-rc1.
This commit was backported to 4.19, 5.10, 5.15, 5.4, adn 6.1."
Fixed in v6.8-rc6.

Fixed status
mainline: [e6f57c6881916df39db7d95981a8ad2b9c3458d6]
stable/4.19: [115b7f3bc1dce590a6851a2dcf23dc1100c49790]
stable/5.10: [3f38d22e645e2e994979426ea5a35186102ff3c2]
stable/5.15: [47ae64df23ed1318e27bd9844e135a5e1c0e6e39]
stable/5.4: [5833024a9856f454a964a198c63a57e59e07baf5]
stable/6.1: [52dc9a7a573dbf778625a0efca0fca55489f084b]
stable/6.6: [a2fef1d81becf4ff60e1a249477464eae3c3bc2a]
stable/6.7: [9034a1bec35e9f725315a3bb6002ef39666114d9]

CVE-2024-26767: drm/amd/display: fixed integer types and null check locations

Announce: https://lore.kernel.org/linux-cve-announce/2024040306-CVE-2024-26767-bdac@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc5.
Backporting the fix to 4.19
(https://lore.kernel.org/stable/20240327122712.2841726-1-sashal@kernel.org/),
5.4 (https://lore.kernel.org/stable/20240327122323.2838480-1-sashal@kernel.org/),
5.10 (https://lore.kernel.org/stable/20240327121940.2835388-1-sashal@kernel.org/),
5.15 (https://lore.kernel.org/stable/20240327121618.2832619-1-sashal@kernel.org/),
and
6.1 (https://lore.kernel.org/stable/20240327121305.2830053-1-sashal@kernel.org/)
were failed.

The link_validation.c was introduced by commit 5461888
("drm/amd/display: break down dc_link.c") in 6.3-rc1.
The bios_parser2.c was introduced by commit ae79c310
("drm/amd/display: Add DCE12 bios parser support") in 4.15-rc1.
So, Linux 4.4 may not be affected.

Fixed status
mainline: [0484e05d048b66d01d1f3c1d2306010bb57d8738]
stable/6.6: [71783d1ff65204d69207fd156d4b2eb1d3882375]
stable/6.7: [beea9ab9080cd2ef46296070bb327af066ee09d7]

CVE-2024-26768: LoongArch: Change acpi_core_pic[NR_CPUS] to
acpi_core_pic[MAX_CORE_PIC]

Announce: https://lore.kernel.org/linux-cve-announce/2024040307-CVE-2024-26768-efa4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc4.
LoongArch was introduced in 5.19. So 4.x, 5.4, 5.10, and 5.15 are not affected.

Fixed status
mainline: [4551b30525cf3d2f026b92401ffe241eb04dfebe]
stable/6.6: [88e189bd16e5889e44a41b3309558ebab78b9280]
stable/6.7: [0f6810e39898af2d2cabd9313e4dbc945fb5dfdd]

CVE-2024-26769: nvmet-fc: avoid deadlock on delete association path

Announce: https://lore.kernel.org/linux-cve-announce/2024040307-CVE-2024-26769-e9cc@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc3.
Affected file fc.c was introduced by commit c5343203 ("nvme-fabrics:
Add target support for FC transport") in 4.10-rc1.

Fixed status
mainline: [710c69dbaccdac312e32931abcb8499c1525d397]
stable/5.15: [5e0bc09a52b6169ce90f7ac6e195791adb16cec4]
stable/6.1: [9e6987f8937a7bd7516aa52f25cb7e12c0c92ee8]
stable/6.6: [eaf0971fdabf2a93c1429dc6bedf3bbe85dffa30]
stable/6.7: [1d86f79287206deec36d63b89c741cf542b6cadd]

CVE-2024-26770: HID: nvidia-shield: Add missing null pointer checks to
LED initialization

Announce: https://lore.kernel.org/linux-cve-announce/2024040307-CVE-2024-26770-1c08@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc3.
Calling devm_kasprintf() was added by commit 3ab196f ("HID:
nvidia-shield: Add battery support for Thunderstrike") in 6.6-rc1 and
7fe1fed4 ("HID: nvidia-shield: Update Thunderstrike LED instance name
to use id") in 6.6-rc1.
These commits are not backported to older stable kernels.

Fixed status
mainline: [b6eda11c44dc89a681e1c105f0f4660e69b1e183]
stable/6.6: [83527a13740f57b45f162e3af4c7db4b88521100]
stable/6.7: [e71cc4a1e584293deafff1a7dea614b0210d0443]

CVE-2024-26771: dmaengine: ti: edma: Add some null pointer checks to
the edma_probe

Announce: https://lore.kernel.org/linux-cve-announce/2024040307-CVE-2024-26771-b6de@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc3.
Calling devm_kasprintf() was added by 2b6b3b7 ("ARM/dmaengine: edma:
Merge the two drivers under drivers/dma/") in 4.4-rc1.
The drivers/dma/ti/edma.c is drivers/dma/edma.c in Linux 4.4.

Fixed status
mainline: [6e2276203ac9ff10fc76917ec9813c660f627369]
stable/5.10: [c432094aa7c9970f2fa10d2305d550d3810657ce]
stable/5.15: [4fe4e5adc7d29d214c59b59f61db73dec505ca3d]
stable/6.1: [9d508c897153ae8dd79303f7f035f078139f6b49]
stable/6.6: [7b24760f3a3c7ae1a176d343136b6c25174b7b27]
stable/6.7: [f2a5e30d1e9a629de6179fa23923a318d5feb29e]

CVE-2024-26772: ext4: avoid allocating blocks from corrupted group in
ext4_mb_find_by_goal()

Announce: https://lore.kernel.org/linux-cve-announce/2024040308-CVE-2024-26772-5168@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc3.

Fixed status
cip/4.4: [d545ccbb16d47682e28a877a561e69aed6918d27]
cip/4.4-rt: [d545ccbb16d47682e28a877a561e69aed6918d27]
cip/4.4-st: [d545ccbb16d47682e28a877a561e69aed6918d27]
mainline: [832698373a25950942c04a512daa652c18a9b513]
stable/4.19: [5a6dcc4ad0f7f7fa8e8d127b5526e7c5f2d38a43]
stable/5.10: [ffeb72a80a82aba59a6774b0611f792e0ed3b0b7]
stable/5.15: [8de8305a25bfda607fc13475ebe84b978c96d7ff]
stable/5.4: [6b92b1bc16d691c95b152c6dbf027ad64315668d]
stable/6.1: [d639102f4cbd4cb65d1225dba3b9265596aab586]
stable/6.6: [d3bbe77a76bc52e9d4d0a120f1509be36e25c916]
stable/6.7: [21dbe20589c7f48e9c5d336ce6402bcebfa6d76a]

CVE-2024-26773: ext4: avoid allocating blocks from corrupted group in
ext4_mb_try_best_found()

Announce: https://lore.kernel.org/linux-cve-announce/2024040308-CVE-2024-26773-a314@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc3.

Fixed status
cip/4.4: [24f29b76aab92974ff562960a3bc720aa36dd80c]
cip/4.4-rt: [24f29b76aab92974ff562960a3bc720aa36dd80c]
cip/4.4-st: [24f29b76aab92974ff562960a3bc720aa36dd80c]
mainline: [4530b3660d396a646aad91a787b6ab37cf604b53]
stable/4.19: [21f8cfe79f776287459343e9cfa6055af61328ea]
stable/5.10: [927794a02169778c9c2e7b25c768ab3ea8c1dc03]
stable/5.15: [4c21fa60a6f4606f6214a38f50612b17b2f738f5]
stable/5.4: [260fc96283c0f594de18a1b045faf6d8fb42874d]
stable/6.1: [f97e75fa4e12b0aa0224e83fcbda8853ac2adf36]
stable/6.6: [0184747b552d6b5a14db3b7fcc3b792ce64dedd1]
stable/6.7: [a2576ae9a35c078e488f2c573e9e6821d651fbbe]

CVE-2024-26774: ext4: avoid dividing by 0 in
mb_update_avg_fragment_size() when block bitmap corrupt

Announce: https://lore.kernel.org/linux-cve-announce/2024040308-CVE-2024-26774-52d9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc3.
The mb_update_avg_fragment_size() was introduced by commit 196e402
("ext4: improve cr 0 / cr 1 group scanning") in 5.13-rc1.

Fixed status
mainline: [993bf0f4c393b3667830918f9247438a8f6fdb5b]
stable/5.15: [687061cfaa2ac3095170e136dd9c29a4974f41d4]
stable/6.1: [8b40eb2e716b503f7a4e1090815a17b1341b2150]
stable/6.6: [f32d2a745b02123258026e105a008f474f896d6a]
stable/6.7: [8cf9cc602cfb40085967c0d140e32691c8b71cf3]

CVE-2024-26775: aoe: avoid potential deadlock at set_capacity

Announce: https://lore.kernel.org/linux-cve-announce/2024040309-CVE-2024-26775-8dc1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc2.
It seems as if 4.x and 5.x kernels are affected.

Fixed status
mainline: [e169bd4fb2b36c4b2bee63c35c740c85daeb2e86]
stable/6.1: [2d623c94fbba3554f4446ba6f3c764994e8b0d26]
stable/6.6: [673629018ba04906899dcb631beec34d871f709c]
stable/6.7: [19a77b27163820f793b4d022979ffdca8f659b77]

CVE-2024-26776: spi: hisi-sfc-v3xx: Return IRQ_NONE if no interrupts
were detected

Announce: https://lore.kernel.org/linux-cve-announce/2024040309-CVE-2024-26776-8119@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc2.
The hisi_sfc_v3xx_isr() was introduced by commit b1dd56512 ("spi:
hisi-sfc-v3xx: add support for IRQ mode") in 5.10-rc1.

Fixed status
mainline: [de8b6e1c231a95abf95ad097b993d34b31458ec9]
stable/5.10: [e94da8aca2e78ef9ecca02eb211869eacd5504e5]
stable/5.15: [0399d7eba41d9b28f5bdd7757ec21a5b7046858d]
stable/6.1: [f19361d570c67e7e014896fa2dacd7d721bf0aa8]
stable/6.6: [d637b5118274701e8448f35953877daf04df18b4]
stable/6.7: [e4168ac25b4bd378bd7dda322d589482a136c1fd]

CVE-2024-26777: fbdev: sis: Error out if pixclock equals zero

Announce: https://lore.kernel.org/linux-cve-announce/2024040309-CVE-2024-26777-3c7c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc2.

Fixed status
cip/4.4: [3837467fac54c0ce4cd27b3e7fe274f724d543b2]
cip/4.4-rt: [3837467fac54c0ce4cd27b3e7fe274f724d543b2]
cip/4.4-st: [3837467fac54c0ce4cd27b3e7fe274f724d543b2]
mainline: [e421946be7d9bf545147bea8419ef8239cb7ca52]
stable/4.19: [84246c35ca34207114055a87552a1c4289c8fd7e]
stable/5.10: [cd36da760bd1f78c63c7078407baf01dd724f313]
stable/5.15: [df6e2088c6f4cad539cf67cba2d6764461e798d1]
stable/5.4: [6db07619d173765bd8622d63809cbfe361f04207]
stable/6.1: [f329523f6a65c3bbce913ad35473d83a319d5d99]
stable/6.6: [99f1abc34a6dde248d2219d64aa493c76bbdd9eb]
stable/6.7: [1d11dd3ea5d039c7da089f309f39c4cd363b924b]

CVE-2024-26778: fbdev: savage: Error out if pixclock equals zero

Announce: https://lore.kernel.org/linux-cve-announce/2024040309-CVE-2024-26778-8137@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc2.

Fixed status
cip/4.4: [6172966f364e632310e95f18e67755fdd95a7dd9]
cip/4.4-rt: [6172966f364e632310e95f18e67755fdd95a7dd9]
cip/4.4-st: [6172966f364e632310e95f18e67755fdd95a7dd9]
mainline: [04e5eac8f3ab2ff52fa191c187a46d4fdbc1e288]
stable/4.19: [224453de8505aede1890f007be973925a3edf6a1]
stable/5.10: [512ee6d6041e007ef5bf200c6e388e172a2c5b24]
stable/5.15: [8c54acf33e5adaad6374bf3ec1e3aff0591cc8e1]
stable/5.4: [84dce0f6a4cc5b7bfd7242ef9290db8ac1dd77ff]
stable/6.1: [070398d32c5f3ab0e890374904ad94551c76aec4]
stable/6.6: [bc3c2e58d73b28b9a8789fca84778ee165a72d13]
stable/6.7: [a9ca4e80d23474f90841251f4ac0d941fa337a01]

CVE-2024-26779: wifi: mac80211: fix race condition on enabling fast-xmit

Announce: https://lore.kernel.org/linux-cve-announce/2024040310-CVE-2024-26779-8030@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc2.

Fixed status
cip/4.4: [16f509814b0db3baed21f39884f7c4d8b59fa91e]
cip/4.4-rt: [16f509814b0db3baed21f39884f7c4d8b59fa91e]
cip/4.4-st: [16f509814b0db3baed21f39884f7c4d8b59fa91e]
mainline: [bcbc84af1183c8cf3d1ca9b78540c2185cd85e7f]
stable/4.19: [76fad1174a0cae6fc857b9f88b261a2e4f07d587]
stable/5.10: [5ffab99e070b9f8ae0cf60c3c3602b84eee818dd]
stable/5.15: [88c18fd06608b3adee547102505d715f21075c9d]
stable/5.4: [85720b69aef177318f4a18efbcc4302228a340e5]
stable/6.1: [eb39bb548bf974acad7bd6780fe11f9e6652d696]
stable/6.6: [54b79d8786964e2f840e8a2ec4a9f9a50f3d4954]
stable/6.7: [281280276b70c822f55ce15b661f6d1d3228aaa9]

* Updated CVEs

CVE-2023-47233: Use after Free bug in brcmf_cfg80211_detach

stable 6.1, 6.6, 6.7, and 6.8 were fixed.

Fixed status
mainline: [0f7352557a35ab7888bc7831411ec8a3cbe20d78]
stable/6.1: [0b812f706fd7090be74812101114a0e165b36744]
stable/6.6: [190794848e2b9d15de92d502b6ac652806904f5a]
stable/6.7: [6678a1e7d896c00030b31491690e8ddc9a90767a]
stable/6.8: [0a7591e14a8da794d0b93b5d1c6254ccb23adacb]

CVE-2024-23307: Integer Overflow bug was found md/raid/raid5 modules

stable 6.1, 6.6, 6.7, and 6.8 were fixed.

Fixed status
mainline: [dfd2bf436709b2bccb78c2dda550dde93700efa7]
stable/6.1: [9477cfeb300823461b44223a7d5fac26a31df4fe]
stable/6.6: [8ec4a68a25a231e2303716a0aba8ff1413d47c87]
stable/6.7: [1191f9391105e49115715e55030476849f6f6da5]
stable/6.8: [83dcc4e850c69ca569e1b0f1484910e6a68b2d78]

CVE-2024-24861: Race condition bug was found in media/xc4000 device
driver in xc4000 xc4000_get_frequency()

stable 6.1, 6.6, 6.7, and 6.8 were fixed.

Fixed status
mainline: [36d503ad547d1c75758a6fcdbec2806f1b6aeb41]
stable/6.1: [09c1be4d581d3356159abcc5a8a7a6c5f1bf1e77]
stable/6.6: [dc5e4f240473b64f7b2f24424e96c92435ebd8d7]
stable/6.7: [b0864de231dece0f7226b909521bebc86105743a]
stable/6.8: [5c26122885cedcb99606cdc06a3419db7feb1e1e]

CVE-2024-26584: net: tls: handle backlogging of crypto requests

stable 6.1 was fixed.

Fixed status
mainline: [8590541473188741055d27b955db0777569438e3]
stable/6.1: [cd1bbca03f3c1d845ce274c0d0a66de8e5929f72]
stable/6.6: [13eca403876bbea3716e82cdfe6f1e6febb38754]
stable/6.7: [ab6397f072e5097f267abf5cb08a8004e6b17694]

CVE-2024-26585: tls: fix race between tx work scheduling and socket close

stable 6.1 was fixed.

Fixed status
mainline: [e01e3934a1b2d122919f73bc6ddbe1cdafc4bbdb]
stable/6.1: [196f198ca6fce04ba6ce262f5a0e4d567d7d219d]
stable/6.6: [6db22d6c7a6dc914b12c0469b94eb639b6a8a146]
stable/6.7: [e327ed60bff4a991cd7a709c47c4f0c5b4a4fd57]

CVE-2024-26642: netfilter: nf_tables: disallow anonymous set with timeout flag

stable 6.1, 6.6, and 6.7 ware fixed.

Fixed status
mainline: [16603605b667b70da974bea8216c93e7db043bf1]
stable/6.1: [72c1efe3f247a581667b7d368fff3bd9a03cd57a]
stable/6.6: [c0c2176d1814b92ea4c8e7eb7c9cd94cd99c1b12]
stable/6.7: [8e07c16695583a66e81f67ce4c46e94dece47ba7]

CVE-2024-26643: netfilter: nf_tables: mark set as dead when unbinding
anonymous set with timeout

stable 6.1, 6.6, and 6.7 ware fixed.

Fixed status
mainline: [552705a3650bbf46a22b1adedc1b04181490fc36]
stable/6.1: [406b0241d0eb598a0b330ab20ae325537d8d8163]
stable/6.6: [b2d6f9a5b1cf968f1eaa71085ceeb09c2cb276b1]
stable/6.7: [5224afbc30c3ca9ba23e752f0f138729b2c48dd8]

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


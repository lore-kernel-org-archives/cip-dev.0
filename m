Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8172FCD4855
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 22:30:43 +0000 (UTC)
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10400.1762986640457823668
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Nov 2025 14:30:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=2URUGawk;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.42, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-640f88b873bso136585d50.3
        for <cip-dev@lists.cip-project.org>; Wed, 12 Nov 2025 14:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1762986639; x=1763591439; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Psb62Ab0GOPXm5z5pSBICFd4Xf/1/nqvQBEZ7oLHnjI=;
        b=2URUGawk+UatFl+d0Z/rC81DC4r5VbA2ryYwT8vc4V8HmWPASi/d6tyrzF3pyVciNh
         0eJK0feNAEUmTu19G7CdKYMaNemSdQKxtsNADtUU9US6JyDjLp9jRwXMMWA8NTZn/y6+
         lDCNRPaaRFh87lilSmlRVk/T/jqUfRlOt85MpbfGjQRc6Gv/r5zvwX24LhXdTU+CM6Q/
         /P/uDpqV1+r6K5gMsAytSHGXG+0cmTwiaky/wzYDlsGmFoGI7k721bzqcg/5ulQYEanq
         /CLxaEGiMQSAnPlO2M4zXERPAn/Z1KP2UsBRViaa1WVpuMQtfWTeFnh/RkR3eEfwMoE5
         VziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762986639; x=1763591439;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Psb62Ab0GOPXm5z5pSBICFd4Xf/1/nqvQBEZ7oLHnjI=;
        b=LliTpQMM12yCIChk7SAh+TdMtROEbNMBbWMFP7RBwLnVWgXDy31oOioahGH2Jq2kb3
         uv9I5xiGNTQxKMkXoxKNE8bXyCH7PnmiIXTEw3idunHrO8CNLEdclTh2D4uQTkb8PoDt
         BsjEGZWhJw1fnBoqnodtnrZ3Ac59luPCBQyFwxqdL34fojarcJSOev5lYDY7X+iBe8PM
         uEXOzrZBcgBv30dmPS2rs1XlazpNTeIDB7Kdjb3m+AXK3MlMKEmituFQIt7OkizeyBeI
         0tO3ED5ZvHarI3fYawJnqQLEhV5n0xcjVNTnL4zp3g3Ea8J/6mDh9ivaDvibLiZTMBWE
         deww==
X-Gm-Message-State: AOJu0YxNWrF4ibH/rAKlbvfz16/b3akdms4Dd7tne/1bFeTA1JRcOorL
	4PR3JPLWwO9kq0paytMs2JU6SStPUvyLzYgcj0BwUE/IH0UUfD1KNgcBYR+RIU7crmvwJwDU3Se
	zTh54wubVRhNfExMsEbZTWmZeL+1W1QR0lIn96OwB4/qmTCFBrSPKDdo=
X-Gm-Gg: ASbGncs48geUiObie2cb/y6rE7RF7sraEKuC163vocEKIrtGpBo8SYJ22/11SpOMvuu
	oxCmhE7g/imXlYdoqGPk6RTKXZh/AEdGvCvJCHWv9wZLfCLCBu03DWYqCgJzmLJtI6iGJ1leRpj
	WCn7AE0Ij6Z5S7uZJU9jIDxikcyjwWbhjrc4l9m0ZEJ1c7ObwUUDGy0hw691FFHnt3KUmKFSJRL
	N9vNH8ItUxOXm0iM8NzC31SZyBcbiQhOQRU+5PdWXZU8Iuor+O57CDDvmCgXg==
X-Google-Smtp-Source: AGHT+IE9gry5e4rMXX+q9BrKrHFglVg8C/19tfFYZe4nEdS6svxDxJ50wxKqMsTtcOkCZvWtffVd3uDSSv5PMDJaTC0=
X-Received: by 2002:a53:acd9:0:20b0:63f:b87a:8346 with SMTP id
 956f58d0204a3-64101a46f4amr3518772d50.27.1762986638533; Wed, 12 Nov 2025
 14:30:38 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 13 Nov 2025 07:30:02 +0900
X-Gm-Features: AWmQ_bm54qF19NhHeNzY9SQg4egtycCmRHCH07xC6WsBV8QmiRqT3IsVFFPakMQ
Message-ID: <CAODzB9p_FSBRtYwQXxym120WnsGR_1U6Bj_ehZ3Mbmn4eJ7O9w@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Nov 2025 22:30:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20516

Hi!

It's this week's CVE report.

This week reported 69 new CVEs and 0 updated CVEs.

* New CVEs
CVE-2025-40108: serial: qcom-geni: Fix blocked task

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40108

Introduced by commit 1afa706 ("serial: qcom-geni: Enable PM runtime
for serial driver") in v6.17-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a699213d4e6ef4286348c6439837990f121e0c03]

CVE-2025-40109: crypto: rng - Ensure set_ent is always present

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40109

Introduced by commit 77ebdab ("crypto: af_alg - add extra parameters
for DRBG interface") in v5.10-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0d36727bf39bb16ef0a67ed608e279535ebf0da]
stable/5.10: [15d6f42da1bb527629d8e1067b1302d58dec9166]
stable/5.15: [bd903c25b652c331831226cdf56c8179d18e43f4]
stable/6.1: [17acbcd44fe8dc17dc1072375e76df2d52da6ac8]
stable/6.12: [c5c703b50e91dd4748769f4c5ab50d9ad60be370]
stable/6.6: [ab172f4f42626549b02bada05f09e3f2b0cc26ec]

CVE-2025-40110: drm/vmwgfx: Fix a null-ptr access in the cursor snooper

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40110

Introduced by commit c0951b7 ("drm/vmwgfx: Refactor resource
management") in v3.8-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ac2c0279053a2c5265d46903432fb26ae2d0da2]
stable/6.12: [13c9e4ed125e19484234c960efe5ac9c55119523]
stable/6.6: [299cfb5a7deabdf9ecd30071755672af0aced5eb]

CVE-2025-40111: drm/vmwgfx: Fix Use-after-free in validation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40111

Introduced by commit 64ad2ab ("drm/vmwgfx: Adapt validation code for
reference-free lookups") in v4.20-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dfe1323ab3c8a4dd5625ebfdba44dc47df84512a]
stable/5.10: [fb7165e5f3b3b10721ff70553583ad12e90e447a]
stable/5.15: [4c918f9d1ccccc0e092f43dcb2d8266f54d7340b]
stable/5.4: [1822e5287b7dfa59d0af966756ebf1dc652b60ee]
stable/6.1: [9a8eaca539708ca532747f606d231f70e684e8ca]
stable/6.12: [655a2f29bfc21105c80bf8a7d7aafa6eca8b4496]
stable/6.6: [867bda5d95d36f10da398fd4409e21c7002b2332]

CVE-2025-40112: sparc: fix accurate exception reporting in
copy_{from_to}_user for Niagara

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40112

Introduced by commit 7ae3aaf ("sparc64: Convert NGcopy_{from,to}_user
to accurate exception reporting.") in v4.9-rc4.
Fixed in v6.18-rc1.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [0b67c8fc10b13a9090340c5f8a37d308f4e1571c]
stable/5.10: [7823fc4d8ab5e57f8db7806ff2530c03c166c4bb]
stable/5.15: [37547d8e6eba87507279ee3dfddfd9dc46335454]
stable/5.4: [05440320ea3e249d5f984918f2bf51210c1a7c03]
stable/6.1: [a365ee556e45f780ee322b349a06efdad0c1458f]
stable/6.12: [a90ce516a73dbe087f9bf3dbf311301a58d125c6]
stable/6.6: [8cdeb5e482d3fdce7e825444b6ca3865e24c0228]

CVE-2025-40113: remoteproc: qcom: pas: Shutdown lite ADSP DTB on X1E

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40113

Introduced by commit 62210f7 ("remoteproc: qcom_q6v5_pas: Unload lite
firmware on ADSP") in v6.9-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [142964960c7c35de5c5f7bdd61c32699de693630]

CVE-2025-40115: scsi: mpt3sas: Fix crash in transport port remove by
using ioc_info()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40115

Introduced by commit f92363d ("[SCSI] mpt3sas: add new driver
supporting 12GB SAS") in v3.8-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1703fe4f8ae50d1fb6449854e1fcaed1053e3a14]
stable/5.10: [4e1442bae50ed633c2fe8058f47cd79b4ad88b9b]
stable/5.15: [a89253eb4e648deace48a4e38996afd182eb95e3]
stable/5.4: [b3a6d153861d0f29b80882470d14aafb8d687dc2]
stable/6.1: [fa153fb40c61f8ca01237427c97a0b93ba32c403]
stable/6.12: [1fd39e14d47d9b4965dd5c9cff16e64ba3e71a62]
stable/6.6: [6459dba4f35017448535a799cf699d5205eb5489]

CVE-2025-40116: usb: host: max3421-hcd: Fix error pointer dereference
in probe cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40116

Introduced by commit 05dfa5c ("usb: host: max3421-hcd: fix "spi_rd8"
uses dynamic stack allocation warning") in v3.16-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [186e8f2bdba551f3ae23396caccd452d985c23e3]
stable/5.10: [3facf69a735e730ae36387f18780fe420708aa91]
stable/5.15: [e0e0ce06f3571be9b26790e4df56ba37b1de8543]
stable/5.4: [89838fe5c6c010ff8d3924f22afd9c18c5c95310]
stable/6.1: [3723c3dda1cc82c9bbca08fcbd46705a361bfd56]
stable/6.12: [e68ea6de1d0551f90d7a2c75f82cb3ebe5e397dc]
stable/6.6: [b0439e3762ac9ea580f714e1504a1827d1ad32f5]

CVE-2025-40117: misc: pci_endpoint_test: Fix array underflow in
pci_endpoint_test_ioctl()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40117

Introduced by commit eefb837 ("misc: pci_endpoint_test: Add doorbell
test case") in v6.17-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1ad82f9db13d85667366044acdfb02009d576c5a]

CVE-2025-40118: scsi: pm80xx: Fix array-index-out-of-of-bounds on rmmod

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40118

Introduced by commit f7b705c ("scsi: pm80xx: Set phy_attached to zero
when device is gone") in v6.15-rc3.
Fixed in v6.18-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/5.4 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [251be2f6037fb7ab399f68cd7428ff274133d693]
stable/5.10: [45acbf154befedd9bc135f5e031fe7855d1e6493]
stable/5.15: [eef5ef400893f8e3dbb09342583be0cdc716d566]
stable/5.4: [d94be0a6ae9ade706d4270e740bdb4f79953a7fc]
stable/6.1: [9c671d4dbfbfb0d73cfdfb706afb36d9ad60a582]
stable/6.12: [9326a1541e1b7ed3efdbab72061b82cf01c6477a]
stable/6.6: [e62251954a128a2d0fcbc19e5fa39e08935bb628]

CVE-2025-40119: ext4: fix potential null deref in ext4_mb_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40119

Introduced by commit f7eaacb ("ext4: convert free groups order lists
to xarrays") in v6.17-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c3fac6bc0a9c00dbe65d8dc0d3a282afe4d3188]

CVE-2025-40120: net: usb: asix: hold PM usage ref to avoid PM/MDIO +
RTNL deadlock

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40120

Introduced by commit 4a2c721 ("net: usb: asix: ax88772: manage PHY PM
from MAC") in v5.14-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d3c4cd5c62f24bb3cb4511b7a95df707635e00a]
stable/5.15: [71a0ba7fdaf8d035426912a4ed7bf1738a81010c]
stable/6.1: [3e96cd27ff1a004d84908c1b6cc68ac60913874e]
stable/6.12: [1534517300e12f2930b6ff477b8820ff658afd11]
stable/6.6: [724a9db84188f80ef60b1f21cc7b4e9c84e0cb64]

CVE-2025-40121: ASoC: Intel: bytcr_rt5651: Fix invalid quirk input mapping

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40121

Introduced by commit 64484cc ("ASoC: Intel: bytcr_rt5651: Set card
long_name based on quirks") in v4.18-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4336efb59ef364e691ef829a73d9dbd4d5ed7c7b]
stable/5.10: [64a36a7032082b4c330ce081acb6efb99246020e]
stable/5.15: [95e29db33b5f73218ae08ebb48c61c9a8d28e2ff]
stable/5.4: [bff827b0d507e52b23efab9f67c232a4f037ab2c]
stable/6.1: [2204e582b4eea872e1e7a5c90edcb84b928c68b0]
stable/6.12: [fdf99978a6480e14405212472b6c747e0fa43bed]
stable/6.6: [f197894de2f4ef46c7d53827d9df294b75c35e13]

CVE-2025-40122: perf/x86/intel: Fix IA32_PMC_x_CFG_B MSRs access error

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40122

Introduced by commit ec980e4 ("perf/x86/intel: Support auto counter
reload") in v6.16-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [43796f30507802d93ead2dc44fc9637f34671a89]

CVE-2025-40123: bpf: Enforce expected_attach_type for tailcall compatibility

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40123

Introduced by commit 5e43f89 ("bpf: Check attach type at prog load
time") in v4.17-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4540aed51b12bc13364149bf95f6ecef013197c0]
stable/6.1: [a99de19128aec0913f3d529f529fbbff5edfaff8]
stable/6.12: [f856c598080ba7ce1252867b8ecd6ad5bdaf9a6a]
stable/6.6: [08cb3dc9d2b44f153d0bcf2cb966e4a94b5d0f32]

CVE-2025-40124: sparc: fix accurate exception reporting in
copy_{from_to}_user for UltraSPARC III

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40124

Introduced by commit ee841d0 ("sparc64: Convert U3copy_{from,to}_user
to accurate exception reporting.") in v4.9-rc4.
Fixed in v6.18-rc1.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [47b49c06eb62504075f0f2e2227aee2e2c2a58b3]
stable/5.10: [1198077606aeffb102587c6ea079ce99641c99d4]
stable/5.15: [1857cdca12c4aff58bf26a7005a4d02850c29927]
stable/5.4: [fdd43fe6d286f27b826572457a89c926f97e2d3a]
stable/6.1: [91eda032eb16e5d2be27c95584665bc555bb5a90]
stable/6.12: [5ef9c94d7110e90260c06868cf1dcf899b9f25ee]
stable/6.6: [dc766c4830a7e1e1ee9d7f77d4ab344f2eb23c8e]

CVE-2025-40125: blk-mq: check kobject state_in_sysfs before deleting
in blk_mq_unregister_hctx

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40125

Introduced by commit 477e19d ("blk-mq: adjust debugfs and sysfs
register when updating nr_hw_queues") in v4.20-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c7ef92f6d4d08a27d676e4c348f4e2922cab3ed]
stable/5.10: [cc14ea21c4e658814d737ed4dedde6cd626a15ad]
stable/5.15: [4b97e99b87a773d52699521d40864f3ec888e9a6]
stable/5.4: [a8c53553f1833cc2d14175d2d72cf37193a01898]
stable/6.1: [6e7dadc5763c48eb3b9b91265a21f312599ebb2c]
stable/6.12: [babc634e9fe2803962dba98a07587e835dbc0731]
stable/6.6: [06c4826b1d900611096e4621e93133db57e13911]

CVE-2025-40126: sparc: fix accurate exception reporting in
copy_{from_to}_user for UltraSPARC

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40126

Introduced by commit cb736fd ("sparc64: Convert U1copy_{from,to}_user
to accurate exception reporting.") in v4.9-rc4.
Fixed in v6.18-rc1.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [4fba1713001195e59cfc001ff1f2837dab877efb]
stable/5.10: [41c18baee66134e6ef786eb075c1b6adb22432b0]
stable/5.15: [59424dc0d0e044b2eb007686a4724ddd91d57db5]
stable/5.4: [0bf3dc3a2156f1c5ddaba4b85d09767874634114]
stable/6.1: [9b137f277cc3297044aabd950f589e505d30104c]
stable/6.12: [7de3a75bbc8465d816336c74d50109e73501efab]
stable/6.6: [674ff598148a28bae0b5372339de56f2abf0b1d1]

CVE-2025-40127: hwrng: ks-sa - fix division by zero in ks_sa_rng_init

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40127

Introduced by commit 6d01d85 ("hwrng: ks-sa - Add minimum sleep time
before ready-polling") in v5.5-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [612b1dfeb414dfa780a6316014ceddf9a74ff5c0]
stable/5.10: [692a04a1e0cde1d80a33df0078c755cf02cd7268]
stable/5.15: [d76b099011fa056950f63d05ebb6160991242f6a]
stable/6.1: [eec7e0e19c1fa75dc65e25aa6a21ef24a03849af]
stable/6.12: [2b6bcce32cb5aff84588a844a4d3f6dd5353b8e2]
stable/6.6: [f4238064379a91e71a9c258996acac43c50c2094]

CVE-2025-40128: btrfs: fix symbolic link reading when bs > ps

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40128

Introduced by commit cc38d17 ("btrfs: enable large data folio support
under CONFIG_BTRFS_EXPERIMENTAL") in v6.17-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [67378b754608a3524d125bfa5744508a49fe48be]

CVE-2025-40129: sunrpc: fix null pointer dereference on zero-length checksum

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40129

Introduced by commit 0653028 ("SUNRPC: Convert gss_verify_header() to
use xdr_stream") in v6.3-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6df164e29bd4e6505c5a2e0e5f1e1f6957a16a42]
stable/6.12: [affc03d44921f493deaae1d33151e3067a6f9f8f]
stable/6.6: [81cec07d303186d0d8c623ef8b5ecd3b81e94cf6]

CVE-2025-40130: scsi: ufs: core: Fix data race in CPU latency PM QoS
request handling

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40130

Introduced by commit 2777e73 ("scsi: ufs: core: Add CPU latency QoS
support for UFS driver") in v6.9-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [79dde5f7dc7c038eec903745dc1550cd4139980e]

CVE-2025-40131: wifi: ath12k: Fix peer lookup in ath12k_dp_mon_rx_deliver_msdu()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40131

Introduced by commit bd00cc7 ("wifi: ath12k: replace the usage of rx
desc with rx_info") in v6.16-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ca61ed8b3f3fc9a7decd68039cb1d7d1238c566]

CVE-2025-40132: ASoC: Intel: sof_sdw: Prevent jump to NULL add_sidecar callback

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40132

Introduced by commit da52441 ("ASoC: Intel: sof_sdw: Add callbacks to
register sidecar devices") in v6.10-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87cab86925b7fa4c1c977bc191ac549a3b23f0ea]
stable/6.12: [aea038062edfca9c6e5ddcecd4611d5a80113b4e]

CVE-2025-40133: mptcp: Use __sk_dst_get() and dst_dev_rcu() in
mptcp_active_enable().

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40133

Introduced by commit 27069e7 ("mptcp: disable active MPTCP in case of
blackhole") in v6.12-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [893c49a78d9f85e4b8081b908fb7c407d018106a]
stable/6.12: [ad16235c9d3ef7ec17c109ff39b7504f49d17072]

CVE-2025-40134: dm: fix NULL pointer dereference in __dm_suspend()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40134

Introduced by commit c4576ae ("dm: fix request-based dm's use of
dm_wait_for_completion") in v5.0-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8d33a030c566e1f105cd5bf27f37940b6367f3be]
stable/5.10: [30f95b7eda5966b81cb221bd569c0f095a068cf6]
stable/5.15: [a0e54bd8d7ea79127fe9920df3ae36f85e79ac7c]
stable/5.4: [9dc43ea6a20ff83fe9a5fe4be47ae0fbf2409b98]
stable/6.1: [a802901b75e13cc306f1b7ab0f062135c8034e9e]
stable/6.12: [19ca4528666990be376ac3eb6fe667b03db5324d]
stable/6.6: [846cafc4725ca727d94f9c4b5f789c1a7c8fb6fe]

CVE-2025-40135: ipv6: use RCU in ip6_xmit()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40135

Introduced by commit 4a6ce2b ("net: introduce a new function
dst_dev_put()") in v4.13-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9085e56501d93af9f2d7bd16f7fcfacdde47b99c]

CVE-2025-40136: crypto: hisilicon/qm - request reserved interrupt for
virtual function

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40136

Introduced by commit 3536cc5 ("crypto: hisilicon/qm - support get
device irq information from hardware registers") in v6.1-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9228facb308157ac0bdd264b873187896f7a9c7a]

CVE-2025-40137: f2fs: fix to truncate first page in error path of
f2fs_truncate()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40137

Introduced by commit 92dffd0 ("f2fs: convert inline_data when i_size
becomes large") in v3.19-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9251a9e6e871cb03c4714a18efa8f5d4a8818450]
stable/6.12: [a7b7ebdd7045a36454b3e388a2ecf50344fad9e6]
stable/6.6: [83a8e4efea022506a0e049e7206bdf8be9f78148]

CVE-2025-40138: f2fs: fix to avoid NULL pointer dereference in
f2fs_check_quota_consistency()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40138

Introduced by commit d185351 ("f2fs: separate the options parsing and
options checking") in v6.17-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [930a9a6ee8e7ffa20af4bffbfc2bbd21d83bf81c]

CVE-2025-40139: smc: Use __sk_dst_get() and dst_dev_rcu() in in
smc_clc_prfx_set().

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40139

Introduced by commit a046d57 ("smc: CLC handshake (incl. preparation
steps)") in v4.11-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [935d783e5de9b64587f3adb25641dd8385e64ddb]

CVE-2025-40140: net: usb: Remove disruptive netif_wake_queue in
rtl8150_set_multicast

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40140

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [958baf5eaee394e5fd976979b0791a875f14a179]
stable/5.10: [1a08a37ac03d07a1608a1592791041cac979fbc3]
stable/5.15: [54f8ef1a970a8376e5846ed90854decf7c00555d]
stable/5.4: [cce3c0e21cdd15bcba5c35d3af1700186de8f187]
stable/6.1: [114e05344763a102a8844efd96ec06ba99293ccd]
stable/6.12: [6053e47bbf212b93c051beb4261d7d5a409d0ce3]
stable/6.6: [6394bade9daab8e318c165fe43bba012bf13cd8e]

CVE-2025-40141: Bluetooth: ISO: Fix possible UAF on iso_conn_free

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40141

Introduced by commit ccf74f2 ("Bluetooth: Add BTPROTO_ISO socket
type") in v6.0-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9950f095d6c875dbe0c9ebfcf972ec88fdf26fc8]
stable/6.1: [eba6d787ec117a5d2c60f9644e0a39c18542b6be]
stable/6.12: [80689777919f02328eb873769de4647c9dd3e371]
stable/6.6: [5319145a07d8bf5b0782b25cb3115825689d42bb]

CVE-2025-40142: ALSA: pcm: Disable bottom softirqs as part of
spin_lock_irq() on PREEMPT_RT

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40142

Introduced by commit d2d6422 ("x86: Allow to enable PREEMPT_RT.") in v6.12-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9fc4a3da9a0259a0500848b5d8657918efde176b]
stable/6.12: [63ee96c7f47df239ee0a6e8108b6bfd8c98334ae]

CVE-2025-40143: bpf: dont report verifier bug for missing
bpf_scc_visit on speculative path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40143

Introduced by commit c9e3190 ("bpf: propagate read/precision marks
over state graph backedges") in v6.17-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3c73d629ea1373af3c0c954d41fd1af555492e3]

CVE-2025-40144: nvdimm: ndtest: Return -ENOMEM if devm_kcalloc() fails
in ndtest_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40144

Introduced by commit 9399ab6 ("ndtest: Add dimms to the two buses") in
v5.11-rc7.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a9e6aa994917ee602798bbb03180a194b37865bb]
stable/5.15: [972cbba5cd384bacdc2eb589776e1d0a9f42714f]
stable/6.1: [bc8b56317ff83ef4bba89bda356b93978604694f]
stable/6.12: [e4a1e3e88160f7d7a2c33e3db8844073ed6eaf97]
stable/6.6: [b808a3590c2884ca91316dbadbfcc1924f5893c7]

CVE-2025-40145: PCI/pwrctrl: Fix double cleanup on
devm_add_action_or_reset() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40145

Introduced by commit 75996c9 ("PCI/pwrctrl: Add pwrctrl driver for PCI
slots") in v6.15-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab81f2f79c683c94bac622aafafbe8232e547159]

CVE-2025-40146: blk-mq: fix potential deadlock while nr_requests grown

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40146

Introduced by commit e3a2b3f ("blk-mq: allow changing of queue depth
through sysfs") in v3.16-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b86433721f46d934940528f28d49c1dedb690df1]

CVE-2025-40147: blk-throttle: fix access race during throttle policy activation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40147

Introduced by commit a3166c5 ("blk-throttle: delay initialization
until configuration") in v6.10-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bd9fd5be6bc0836820500f68fff144609fbd85a9]

CVE-2025-40148: drm/amd/display: Add NULL pointer checks in dc_stream
cursor attribute functions

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40148

Introduced by commit 4465dd0 ("drm/amd/display: Refactor SubVP cursor
limiting logic") in v6.16-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf4e4b97d0fdc66f04fc19d807e24dd8421b8f11]

CVE-2025-40149: tls: Use __sk_dst_get() and dst_dev_rcu() in
get_netdev_for_sock().

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40149

Introduced by commit e8f6979 ("net/tls: Add generic NIC offload
infrastructure") in v4.18-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c65f27b9c3be2269918e1cbad6d8884741f835c5]

CVE-2025-40150: f2fs: fix to avoid migrating empty section

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40150

Introduced by commit 9703d69 ("f2fs: support file pinning for zoned
devices") in v6.9-rc1.
Fixed in v6.18-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [d625a2b08c089397d3a03bff13fa8645e4ec7a01]

CVE-2025-40151: LoongArch: BPF: No support of struct argument in
trampoline programs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40151

Introduced by commit f9b6b41 ("LoongArch: BPF: Add basic bpf
trampoline support") in v6.17-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e82406c7cbdd368c5459b8a45e118811d2ba0794]

CVE-2025-40152: drm/msm: Fix bootup splat with separate_gpu_drm modparam

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40152

Introduced by commit 217ed15 ("drm/msm: enable separate binding of GPU
and display devices") in v6.17-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f028bcafb6dfb4c2bb656cbff9e6a66222d3d3d7]

CVE-2025-40153: mm: hugetlb: avoid soft lockup when mprotect to large
memory area

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40153

Introduced by commit 8f86059 ("[PATCH] Enable mprotect on huge pages")
in v2.6.20.16.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f52ce0ea90c83a28904c7cc203a70e6434adfecb]
stable/5.10: [5783485ab2be06be5312b26c8793526edc09123d]
stable/5.15: [547e123e9d342a44c756446640ed847a8aeec611]
stable/5.4: [30498c44c2a0b20f6833ed7d8fc3df901507f760]
stable/6.1: [957faf9582f92bb2be8ebe4ab6aa1c2bc71d9859]
stable/6.12: [4975c975ed9457a77953a26aeef85fdba7cf5498]
stable/6.6: [964598e6f70a1be9fe675280bf16b4f96b0a6809]

CVE-2025-40154: ASoC: Intel: bytcr_rt5640: Fix invalid quirk input mapping

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40154

Introduced by commit 063422c ("ASoC: Intel: bytcr_rt5640: Set card
long_name based on quirks") in v4.18-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fba404e4b4af4f4f747bb0e41e9fff7d03c7bcc0]
stable/5.10: [a97b4d18ecb012c5624cdf2cab2ce5e1312fdd5d]
stable/5.15: [dea9c8c9028c9374761224a7f9d824e845a2aa2e]
stable/5.4: [2c27e047bdcba457ec953f7e90e4ed6d5f8aeb01]
stable/6.1: [f58fca15f3bf8b982e799c31e4afa8923788aa40]
stable/6.12: [5c03ea2ef4ebba75c69c90929d8590eb3d3797a9]
stable/6.6: [29a41bf6422688f0c5a09b18222e1a64b2629fa4]

CVE-2025-40155: iommu/vt-d: debugfs: Fix legacy mode page table dump logic

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40155

Introduced by commit 2b437e8 ("iommu/vt-d: debugfs: Support dumping a
specified page table") in v6.7-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fbe6070c73badca726e4ff7877320e6c62339917]
stable/6.12: [d8cf7b59c49f9118fa875462e18686cb6b131bb5]

CVE-2025-40156: PM / devfreq: mtk-cci: Fix potential error pointer
dereference in probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40156

Introduced by commit e09bd57 ("PM / devfreq: mtk-cci: Handle sram
regulator probe deferral") in v6.1-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fc33bf0e097c6834646b98a7b3da0ae5b617f0f9]
stable/6.1: [9cc23e221f392304b7b8aad213812564ddf6517e]
stable/6.12: [44e32104cf7e670e3d683c97b52350d8fac23322]
stable/6.6: [80eab6a9df7e1107dc334434dbacd05297703377]

CVE-2025-40157: EDAC/i10nm: Skip DIMM enumeration on a disabled memory
controller

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40157

Introduced by commit ba987ea ("EDAC/i10nm: Add Intel Granite Rapids
server support") in v6.3-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2e6fe1bbefd9c059c3787d1c620fe67343a94dff]
stable/6.12: [1652f14cf3bef5a4baa232de954fc22bdcaa78fe]
stable/6.6: [8100b6c0f9089d5b156642b81270ce27fff17490]

CVE-2025-40158: ipv6: use RCU in ip6_output()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40158

Introduced by commit 4a6ce2b ("net: introduce a new function
dst_dev_put()") in v4.13-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [11709573cc4e48dc34c80fc7ab9ce5b159e29695]

CVE-2025-40159: xsk: Harden userspace-supplied xdp_desc validation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40159

Introduced by commit 341ac98 ("xsk: Support tx_metadata_len") in v6.8-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [07ca98f906a403637fc5e513a872a50ef1247f3b]
stable/6.12: [1463cd066f32efd56ddfd3ac4e3524200f362980]

CVE-2025-40160: xen/events: Return -EEXIST for bound VIRQs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40160

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [07ce121d93a5e5fb2440a24da3dbf408fcee978e]
stable/6.12: [a1e7f07ae6b594f1ba5be46c6125b43bc505c5aa]
stable/6.6: [612ef6056855c0aacb9b25d1d853c435754483f7]

CVE-2025-40161: mailbox: zynqmp-ipi: Fix SGI cleanup on unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40161

Introduced by commit 6ffb163 ("mailbox: zynqmp: handle SGI for shared
IPI") in v6.10-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bb160e791ab15b89188a7a19589b8e11f681bef3]
stable/6.12: [1ee147efee68be00203b1fee6479911debb1edb2]

CVE-2025-40162: ASoC: amd/sdw_utils: avoid NULL deref when
devm_kasprintf() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40162

Introduced by commit cb8ea62 ("ASoC: amd/sdw_utils: add sof based
soundwire generic machine driver") in v6.12-rc1.
Fixed in v6.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5726b68473f7153a7f6294185e5998b7e2a230a2]
stable/6.12: [095d692e5997ece300c89f10d903d5230090e6a0]

CVE-2025-40163: sched/deadline: Stop dl_server before CPU goes offline

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40163

Introduced by commit 4ae8d9a ("sched/deadline: Fix dl_server getting
stuck") in v6.17.
Fixed in v6.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee6e44dfe6e50b4a5df853d933a96bdff5309e6e]

CVE-2025-40164: usbnet: Fix using smp_processor_id() in preemptible
code warnings

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40164

Introduced by commit 43daa96 ("usbnet: Stop RX Q on MTU change") in v4.7-rc7.
Fixed in v6.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [327cd4b68b4398b6c24f10eb2b2533ffbfc10185]

CVE-2025-40165: media: nxp: imx8-isi: m2m: Fix streaming cleanup on release

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40165

Introduced by commit cf21f32 ("media: nxp: Add i.MX8 ISI driver") in v6.4-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [178aa3360220231dd91e7dbc2eb984525886c9c1]
stable/6.12: [e8b5f4d80775835cf8192d65138e9be1ff202847]
stable/6.6: [50c721be2cff2bf8c9a5f1f4add35c2bbb1df302]

CVE-2025-40166: drm/xe/guc: Check GuC running state before
deregistering exec queue

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40166

Introduced by commit dd08ebf ("drm/xe: Introduce a new DRM driver for
Intel GPUs") in v6.8-rc1.
Fixed in v6.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f64b3cd051b825de0a2a9f145c8e003200cedd5]
stable/6.12: [2c6e5904c5bdbac8e0eadee40f70c42bb83f6dc6]

CVE-2025-40167: ext4: detect invalid INLINE_DATA + EXTENTS flag combination

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40167

Introduced commit is not determined.Fixed in v6.18-rc2.


Fixed status
mainline: [1d3ad183943b38eec2acf72a0ae98e635dc8456b]
stable/5.10: [f061f7c331fc16250fc82aa68964f35821687217]
stable/5.15: [2e9e10657b04152ed0d6ecae8d0c02a3405e28f5]
stable/5.4: [4954d297c91d292630ab43ba4d195dc371ce65d3]
stable/6.1: [1437c95ab2a28b138d4521653583729f61ccb48b]
stable/6.12: [de985264eef64be8a90595908f2e6a87946dad34]
stable/6.6: [cb6039b68efa547b676a8a10fc4618d9d1865c23]

CVE-2025-40168: smc: Use __sk_dst_get() and dst_dev_rcu() in
smc_clc_prfx_match().

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40168

Introduced by commit a046d57 ("smc: CLC handshake (incl. preparation
steps)") in v4.11-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [235f81045c008169cc4e1955b4a64e118eebe61b]

CVE-2025-40169: bpf: Reject negative offsets for ALU ops

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40169

Introduced by commit ec0e2da ("bpf: Support new signed div/mod
instructions.") in v6.6-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [55c0ced59fe17dee34e9dfd5f7be63cbab207758]
stable/6.12: [5017c302ca4b2a45149ad64e058fa2d5623c068f]
stable/6.6: [3bce44b344040e5eef3d64d38b157c15304c0aab]

CVE-2025-40170: net: use dst_dev_rcu() in sk_setup_caps()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40170

Introduced by commit 4a6ce2b ("net: introduce a new function
dst_dev_put()") in v4.13-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [99a2ace61b211b0be861b07fbaa062fca4b58879]

CVE-2025-40171: nvmet-fc: move lsop put work to nvmet_fc_ls_req_op

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40171

Introduced by commit 710c69d ("nvmet-fc: avoid deadlock on delete
association path") in v6.8-rc3.
Fixed in v6.18-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [db5a5406fb7e5337a074385c7a3e53c77f2c1bd3]
stable/5.15: [11269c08013f4ee8b8f5edc6c56700acb34092d0]
stable/6.1: [a28112cc55013cd8cbd5d36b5115a5b851151bd9]
stable/6.12: [7331925c247b03b7767b8cd93cfe1b7aa2377850]
stable/6.6: [060ecc81240ef9d60d9485a3a5eb55a0d6e7a25c]

CVE-2025-40172: accel/qaic: Treat remaining == 0 as error in
find_and_map_user_pages()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40172

Introduced by commit 96d3c1c ("accel/qaic: Clean up integer overflow
checking in map_user_pages()") in v6.5-rc7.
Fixed in v6.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [11f08c30a3e4157305ba692f1d44cca5fc9a8fca]
stable/6.12: [551f1dfbcb7f3e6ed07f9d6c8c1c64337fcd0ede]
stable/6.6: [48b1d42286bfef7628b1d6c8c28d4e456c90f725]

CVE-2025-40173: net/ip6_tunnel: Prevent perpetual tunnel growth

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40173

Introduced by commit 8eb30be ("ipv6: Create ip6_tnl_xmit") in v4.7-rc1.
Fixed in v6.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [21f4d45eba0b2dcae5dbc9e5e0ad08735c993f16]
stable/5.10: [11f6066af3bfb8149aa16c42c0b0c5ea5b199a94]
stable/5.15: [402b6985e872b4cf394bbbf33b503947a326a6cb]
stable/5.4: [566f8d5c8a443f2dd69c5460fdec43ed1c870c65]
stable/6.1: [10fe967efe73c610e526ff7460581610633dee9c]
stable/6.12: [eeb4345488672584db4f8c20a1ae13a212ce31c4]
stable/6.6: [48294a67863c9cfa367abb66bbf0ef6548ae124f]

CVE-2025-40174: x86/mm: Fix SMP ordering in switch_mm_irqs_off()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40174

Introduced by commit 209954c ("x86/mm/tlb: Update mm_cpumask lazily")
in v6.14-rc1.
Fixed in v6.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83b0177a6c4889b3a6e865da5e21b2c9d97d0551]

CVE-2025-40175: idpf: cleanup remaining SKBs in PTP flows

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40175

Introduced by commit 4901e83 ("idpf: add Tx timestamp capabilities
negotiation") in v6.16-rc1.
Fixed in v6.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3f8c0a273120fd2638f03403e786c3de2382e72]

CVE-2025-40176: tls: wait for pending async decryptions if
tls_strp_msg_hold fails

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40176

Introduced by commit 84c61fe ("tls: rx: do not use the standard
strparser") in v6.0-rc1.
Fixed in v6.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b8a6ff84abbcbbc445463de58704686011edc8e1]
stable/6.1: [9f83fd0c179e0f458e824e417f9d5ad53443f685]
stable/6.12: [39dec4ea3daf77f684308576baf483b55ca7f160]
stable/6.6: [c61d4368197d65c4809d9271f3b85325a600586a]

CVE-2025-40177: accel/qaic: Fix bootlog initialization ordering

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40177

Introduced by commit 5f8df5c ("accel/qaic: Add bootlog debugfs") in v6.10-rc1.
Fixed in v6.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd6e385528d8f85993b7bfc6430576136bb14c65]
stable/6.12: [646868e6962b14e25ae7462fdd1fb061b40c1f16]


* Updated CVEs

No update.

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com


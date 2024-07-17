Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C00C3DA60
	for <webhook@archiver.kernel.org>; Wed, 17 Jul 2024 23:10:16 +0000 (UTC)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
 by mx.groups.io with SMTP id smtpd.web10.3552.1721257812215117466
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jul 2024 16:10:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=Yyi1ITyf;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.46, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-25d634c5907so108736fac.2
        for <cip-dev@lists.cip-project.org>; Wed, 17 Jul 2024 16:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1721257811; x=1721862611; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7+QASOviHcj9AyZtqxp+gV82Mlpcu01S+AgbExaMGiY=;
        b=Yyi1ITyf4z21HY8IGd0X9AIoOdjhKFncm19SUGS5ym5JIn3GHUlC5iOgJ5izWmleGy
         aerJ9NItqDrxmnmvYXOSCJHtE3qWB2mVr0GgDd4ajuBiUZEQ+v/0Y9T2uJctp54y0+Ft
         LGUk5bOo3Xpgvv2Zqy5XxXbZfHh6xNE4EjJBsxgIKYeWHY7L2G4KLV8Onfp8EIDZq+ip
         sXcfdZ4aWMsj+zeM+hvzkqjIerwsG6FBCZqkHH2FhqmED5adhR3pgiPbMEGtwB3z2nMQ
         qKm0rhRKpGELtgVrTNWnuIIgOslej+7HNjHDrmsdjiBu3XK8vSMjQ6bAR/6qFjBRHrok
         VjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721257811; x=1721862611;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7+QASOviHcj9AyZtqxp+gV82Mlpcu01S+AgbExaMGiY=;
        b=hu3f7ltRCBblToFSIfmHsJNuWgiTwxnuzL7TvPQ03JvRd4uR88ZcXKunIojnXEQj9I
         5FPt0/hUABSqOa2l3fnUNtar+mI1GccdxM9K5xmmGjm/KC6RafdPNF1VHHUjKRaOm1U9
         SgPrx2faYw6qS77MOG98r5VK0woxKyp4k1dEHLFXAc5WV5ub1z7CM5GbAO+ow80PBi7K
         81SG/5TKUKqyWWhqMek/Qg746c8mSNsGYDT1nN1wY518DcPAMQJnm0PsZEs9v3lWniWp
         kNY441PI0LbQIweRxxQug4pfNuDFgUlUV5TJMQKXqdPWFTFZH8zbCLjRcUcxyIw4WxRw
         NIXw==
X-Gm-Message-State: AOJu0Yyx5dpBjm7bzXGxeehslxVJfDBrAqb/dICcbJL+2vm24lfw5hPJ
	5jacbq2WrJJlspNnmtU7O+OvPRv3fk/WTQt3DFIzYXq6CDTDpkhKcMS/Zi0TX6vA1JiSyPgxFRi
	XWHZ8KSrUEutTLoVkjGqC+dvJNQXCz87aJp50f0Tjg6Fg5HIKgdc=
X-Google-Smtp-Source: AGHT+IFN/FtPz7UyWqh1uRbabX9tdEgodxOa3V8LF5UGr8EARGID55slXqh1wp35ie11DHF0fjbJ8RAL/sZdF0PgwX8=
X-Received: by 2002:a05:6870:e814:b0:25d:6d9e:bdfe with SMTP id
 586e51a60fabf-260d922b5camr2863710fac.28.1721257809912; Wed, 17 Jul 2024
 16:10:09 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 18 Jul 2024 08:09:33 +0900
Message-ID: <CAODzB9qz-2eJhmP7m=3R=z7jQH1Ehc_gA0-bpBVnBHB61q0deQ@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jul 2024 23:10:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16570

Hi!

It's this week's CVE report.

This week reported 102 new CVEs and 1 updated CVEs.

* New CVEs

CVE-2024-41007: tcp: avoid too many retransmit packets

Announce: https://lore.kernel.org/linux-cve-announce/2024071513-CVE-2024-41007-777c@gregkh/

Introduced by commit b701a99 ("tcp: Add
tcp_clamp_rto_to_user_timeout() helper to improve accuracy") in
v4.19-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [97a9063518f198ec0adb2ecb89789de342bb8283]

CVE-2021-47622: scsi: ufs: Fix a deadlock in the error handler

Announce: https://lore.kernel.org/linux-cve-announce/2024071643-CVE-2021-47622-2e8d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc1.

Fixed status
mainline: [945c3cca05d78351bba29fa65d93834cb7934c7b]
stable/5.15: [493c9e850677df8b4eda150c2364b1c1a72ed724]

CVE-2021-47623: powerpc/fixmap: Fix VM debug warning on unmap

Announce: https://lore.kernel.org/linux-cve-announce/2024071645-CVE-2021-47623-407f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc2.
CIP does not support powerpc architecture.

Fixed status
mainline: [aec982603aa8cc0a21143681feb5f60ecc69d718]
stable/5.10: [67baac10dd5ad1e9f50e8f2659984b3b0728d54e]
stable/5.15: [43ae0ccc4d2722b833fb59b905af129428e06d03]

CVE-2021-47624: net/sunrpc: fix reference count leaks in
rpc_sysfs_xprt_state_change

Announce: https://lore.kernel.org/linux-cve-announce/2024071646-CVE-2021-47624-86cd@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc2.
It seems as if this bug was introduced by commit 5b7eb784 ("SUNRPC:
take a xprt offline using sysfs") in 5.14-rc1.

Fixed status
mainline: [776d794f28c95051bc70405a7b1fa40115658a18]
stable/5.15: [4b22aa42bd4d2d630ef1854c139275c3532937cb]

CVE-2022-48773: xprtrdma: fix pointer derefs in error cases of rpcrdma_ep_create

Announce: https://lore.kernel.org/linux-cve-announce/2024071628-CVE-2022-48773-9563@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc4.
It seems as if this bug was introduced by commit 93aa8e0 ("xprtrdma:
Merge struct rpcrdma_ia into struct rpcrdma_ep") in 5.7-rc1.

Fixed status
mainline: [a9c10b5b3b67b3750a10c8b089b2e05f5e176e33]
stable/5.10: [1e7433fb95ccc01629a5edaa4ced0cd8c98d0ae0]
stable/5.15: [9921c866dc369577c3ebb9adf2383b01b58c18de]

CVE-2022-48774: dmaengine: ptdma: Fix the error handling path in pt_core_init()

Announce: https://lore.kernel.org/linux-cve-announce/2024071631-CVE-2022-48774-f680@gregkh/

Introduced by commit fa5d823 ("dmaengine: ptdma: Initial driver for
the AMD PTDMA") in v5.15-rc1.
Fixed in v5.17-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c62fd3406e0b2277c76a6984d3979c7f3f1d129]
stable/5.15: [3e41445287afa3cf6d572778e5aab31d25e60a8d]

CVE-2022-48775: Drivers: hv: vmbus: Fix memory leak in vmbus_add_channel_kobj

Announce: https://lore.kernel.org/linux-cve-announce/2024071631-CVE-2022-48775-d5e9@gregkh/

Introduced by commit c2e5df6 ("vmbus: add per-channel sysfs info") in v4.15-rc1.
Fixed in v5.17-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8bc69f86328e87a0ffa79438430cc82f3aa6a194]
stable/4.19: [417947891bd5ae327f15efed1a0da2b12ef24962]
stable/5.10: [91d8866ca55232d21995a3d54fac96de33c9e20c]
stable/5.15: [c377e2ba78d3fe9a1f0b4ec424e75f81da7e81e9]
stable/5.4: [fe595759c2a4a5bb41c438474f15947d8ae32f5c]

CVE-2022-48776: mtd: parsers: qcom: Fix missing free for pparts in cleanup

Announce: https://lore.kernel.org/linux-cve-announce/2024071631-CVE-2022-48776-9882@gregkh/

Introduced by commit 10f3b4d ("mtd: parsers: qcom: Fix leaking of
partition name") in v5.14-rc1.
Fixed in v5.17-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3dd8ba961b9356c4113b96541c752c73d98fef70]
stable/5.15: [3eb5185896a68373714dc7d0009111744adc3345]

CVE-2022-48777: mtd: parsers: qcom: Fix kernel panic on skipped partition

Announce: https://lore.kernel.org/linux-cve-announce/2024071631-CVE-2022-48777-0e32@gregkh/

Introduced by commit 803eb12 ("mtd: parsers: Add Qcom SMEM parser") in
v5.12-rc1.
Fixed in v5.17-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [65d003cca335cabc0160d3cd7daa689eaa9dd3cd]
stable/5.15: [eb03cb6e03ffd9173e18e5fe87e4e3ce83820453]

CVE-2022-48778: mtd: rawnand: gpmi: don't leak PM reference in error path

Announce: https://lore.kernel.org/linux-cve-announce/2024071632-CVE-2022-48778-b11c@gregkh/

It was introduced by commit f53d4c1 ("mtd: rawnand: gpmi: Add ERR007117
protection for nfc_apply_timings") in 5.17-rc1. Fixed in 5.17-rc5.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15 stable/5.4

Fixed status
mainline: [9161f365c91614e5a3f5c6dcc44c3b1b33bc59c0]
stable/5.10: [a4eeeaca50199e3f19eb13ac3b7e0bbb93e22de4]
stable/5.15: [4a7ec50298b1127c5024a750c969ea0794899545]
stable/5.4: [4cd3281a910a5adf73b2a0a82241dd67844d0b25]

CVE-2022-48779: net: mscc: ocelot: fix use-after-free in ocelot_vlan_del()

Announce: https://lore.kernel.org/linux-cve-announce/2024071632-CVE-2022-48779-94bd@gregkh/

Introduced by commit d400442 ("net: mscc: ocelot: track the port pvid
using a pointer") in v5.16-rc1.
Fixed in v5.17-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef57640575406f57f5b3393cf57f457b0ace837e]

CVE-2022-48780: net/smc: Avoid overwriting the copies of clcsock
callback functions

Announce: https://lore.kernel.org/linux-cve-announce/2024071632-CVE-2022-48780-0f27@gregkh/

It was introduced by commit 341adee ("net/smc: Forward wakeup to smc socket
waitqueue after fallback") in 5.17-rc3. Fixed in 5.17-rc5.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [1de9770d121ee9294794cca0e0be8fbfa0134ee8]
stable/5.15: [7de7ba7a8bd4fde0141de8674c13514d0072f0e6]

CVE-2022-48781: crypto: af_alg - get rid of alg_memory_allocated

Announce: https://lore.kernel.org/linux-cve-announce/2024071633-CVE-2022-48781-498c@gregkh/

Introduced by commit 2bb2f5f ("net: add new socket option
SO_RESERVE_MEM") in v5.16-rc1.
Fixed in v5.17-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [25206111512de994dfc914f5b2972a22aa904ef3]

CVE-2022-48782: mctp: fix use after free

Announce: https://lore.kernel.org/linux-cve-announce/2024071633-CVE-2022-48782-5032@gregkh/

Introduced by commit 4f9e1ba ("mctp: Add tracepoints for tag/key
handling") in v5.16-rc1.
Fixed in v5.17-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e5b6a5c8c44310784c88c1c198dde79f6402f7b]

CVE-2022-48783: net: dsa: lantiq_gswip: fix use after free in gswip_remove()

Announce: https://lore.kernel.org/linux-cve-announce/2024071633-CVE-2022-48783-baab@gregkh/

It was introduced by commit 0d120df ("net: dsa: lantiq_gswip: don't use devres
for mdiobus") in 5.17-rc4. Fixed in 5.17-rc5.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [8c6ae46150a453f8ae9a6cd49b45f354f478587d]
stable/5.10: [f48bd34137718042872d06f2c7332b3267a29165]
stable/5.15: [df2495f329b08ac0d0d3e6334a01955ae839005e]

CVE-2022-48784: cfg80211: fix race in netlink owner interface destruction

Announce: https://lore.kernel.org/linux-cve-announce/2024071634-CVE-2022-48784-f061@gregkh/

Introduced by commit ea6b209 ("cfg80211: fix locking in netlink owner
interface destruction") in v5.13-rc1.
Fixed in v5.17-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0a6fd1527067da537e9c48390237488719948ed]
stable/5.15: [241e633cb379c4f332fc1baf2abec95ec840cbeb]

CVE-2022-48785: ipv6: mcast: use rcu-safe version of ipv6_get_lladdr()

Announce: https://lore.kernel.org/linux-cve-announce/2024071634-CVE-2022-48785-2ba2@gregkh/

Introduced by commit 88e2ca3 ("mld: convert ifmcaddr6 to RCU") in v5.13-rc1.
Fixed in v5.17-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26394fc118d6115390bd5b3a0fb17096271da227]
stable/5.15: [3e11ef1903cf6c2fba35594b193a3570854d9e9e]

CVE-2022-48786: vsock: remove vsock from connected table when connect
is interrupted by a signal

Announce: https://lore.kernel.org/linux-cve-announce/2024071637-CVE-2022-48786-7416@gregkh/

Introduced by commit d021c34 ("VSOCK: Introduce VM Sockets") in v3.9-rc1.
Fixed in v5.17-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b9208492fcaecff8f43915529ae34b3bcb03877c]
stable/4.19: [2910bcb9f67551a45397735e47b6d456eb8cd549]
stable/5.10: [87cd1bbd6677411e17369cd4b7389ab1e1fdba44]
stable/5.15: [787468ee7a435777521d33399d012fd591ae2f94]
stable/5.4: [5f326fe2aef411a6575628f92bd861463ea91df7]

CVE-2022-48787: iwlwifi: fix use-after-free

Announce: https://lore.kernel.org/linux-cve-announce/2024071639-CVE-2022-48787-98e4@gregkh/

Introduced by commit ab07506 ("iwlwifi: fix leaks/bad data after
failed firmware load")
in 5.17-rc1. Fixed in 5.17-rc5.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt stable/4.19 stable/5.10
stable/5.15 stable/5.4

Fixed status
mainline: [bea2662e7818e15d7607d17d57912ac984275d94]
stable/4.19: [7d6475179b85a83186ccce59cdc359d4f07d0bcb]
stable/5.10: [008508c16af0087cda0394e1ac6f0493b01b6063]
stable/5.15: [ddd46059f7d99119b62d44c519df7a79f2e6a515]
stable/5.4: [494de920d98f125b099f27a2d274850750aff957]

CVE-2022-48788: nvme-rdma: fix possible use-after-free in transport
error_recovery work

Announce: https://lore.kernel.org/linux-cve-announce/2024071640-CVE-2022-48788-be08@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc3.

Fixed status
mainline: [b6bb1722f34bbdbabed27acdceaf585d300c5fd2]
stable/4.19: [5593f72d1922403c11749532e3a0aa4cf61414e9]
stable/5.10: [324f5bdc52ecb6a6dadb31a62823ef8c709d1439]
stable/5.15: [646952b2210f19e584d2bf9eb5d092abdca2fcc1]
stable/5.4: [d411b2a5da68b8a130c23097014434ac140a2ace]

CVE-2022-48789: nvme-tcp: fix possible use-after-free in transport
error_recovery work

Announce: https://lore.kernel.org/linux-cve-announce/2024071640-CVE-2022-48789-a066@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc3.

Fixed status
mainline: [ff9fc7ebf5c06de1ef72a69f9b1ab40af8b07f9e]
stable/5.10: [e192184cf8bce8dd55d619f5611a2eaba996fa05]
stable/5.15: [5e42fca37ccc76f39f73732661bd47254cad5982]
stable/5.4: [61a26ffd5ad3ece456d74c4c79f7b5e3f440a141]

CVE-2022-48790: nvme: fix a possible use-after-free in controller
reset during load

Announce: https://lore.kernel.org/linux-cve-announce/2024071640-CVE-2022-48790-ca2a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc3.

Fixed status
mainline: [0fa0f99fc84e41057cbdd2efbfe91c6b2f47dd9d]
stable/4.19: [a25e460fbb0340488d119fb2e28fe3f829b7417e]
stable/5.10: [0ead57ceb21bbf15963b4874c2ac67143455382f]
stable/5.15: [e043fb5a0336ee74614e26f0d9f36f1f5bb6d606]
stable/5.4: [70356b756a58704e5c8818cb09da5854af87e765]

CVE-2022-48791: scsi: pm8001: Fix use-after-free for aborted TMF sas_task

Announce: https://lore.kernel.org/linux-cve-announce/2024071641-CVE-2022-48791-b475@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc3.

Fixed status
mainline: [61f162aa4381845acbdc7f2be4dfb694d027c018]
stable/5.10: [d872e7b5fe38f325f5206b6872746fa02c2b4819]
stable/5.15: [3c334cdfd94945b8edb94022a0371a8665b17366]

CVE-2022-48792: scsi: pm8001: Fix use-after-free for aborted SSP/STP sas_task

Announce: https://lore.kernel.org/linux-cve-announce/2024071641-CVE-2022-48792-87c5@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc3.

Fixed status
mainline: [df7abcaa1246e2537ab4016077b5443bb3c09378]
stable/5.10: [fe9ac3eaa2e387a5742b380b73a5a6bc237bf184]
stable/5.15: [d9d93f32534a0a80a1c26bdb0746d90a7b19c2c2]

CVE-2022-48793: KVM: x86: nSVM: fix potential NULL derefernce on
nested migration

Announce: https://lore.kernel.org/linux-cve-announce/2024071641-CVE-2022-48793-3fc4@gregkh/

Introduced by commit 232f75d ("KVM: nSVM: call nested_svm_load_cr3 on
nested state load") in v5.13-rc1.
Fixed in v5.17-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e1779c2714c3023e4629825762bcbc43a3b943df]
stable/5.15: [74b426bea4f7e3b081add2b88d4fba16d3af7ab6]

CVE-2022-48794: net: ieee802154: at86rf230: Stop leaking skb's

Announce: https://lore.kernel.org/linux-cve-announce/2024071642-CVE-2022-48794-15e8@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc3.

Fixed status
mainline: [e5ce576d45bf72fd0e3dc37eff897bfcc488f6a9]
stable/4.19: [6312f6a53fd3ea38125dcaca5e3c9aa7d8a60cf7]
stable/5.10: [0fd484644c68897c490a3307bfcc8bf767df5a43]
stable/5.15: [23b2a25382400168427ea278f3d8bf4ecfd333bf]
stable/5.4: [455ef08d6e5473526fa6763f75a93f7198206966]

CVE-2022-48795: parisc: Fix data TLB miss in sba_unmap_sg

Announce: https://lore.kernel.org/linux-cve-announce/2024071642-CVE-2022-48795-4de4@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc5.

Fixed status
cip/4.4: [ca156cb4166f163dd7a894f5e67fd4076e11538e]
cip/4.4-rt: [ca156cb4166f163dd7a894f5e67fd4076e11538e]
cip/4.4-st: [ca156cb4166f163dd7a894f5e67fd4076e11538e]
mainline: [b7d6f44a0fa716a82969725516dc0b16bc7cd514]
stable/4.19: [867e50231c7605547d9334904d70a181f39f2d9e]
stable/5.10: [f8f519d7df66c334b5e08f896ac70ee3b53add3b]
stable/5.15: [8c8e949ae81e7f5ab58f9f9f8e9b573b93173dd2]
stable/5.4: [efccc9b0c7e28d0eb7918a236e59f60dc23db4c3]

CVE-2022-48796: iommu: Fix potential use-after-free during probe

Announce: https://lore.kernel.org/linux-cve-announce/2024071642-CVE-2022-48796-8474@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc3.
Affected function was introduced by commit 0c830e6 ("iommu:
Introduce device fault report API") in 5.3-rc1.

Fixed status
mainline: [b54240ad494300ff0994c4539a531727874381f4]
stable/5.10: [cb86e511e78e796de6947b8f3acca1b7c76fb2ff]
stable/5.15: [65ab30f6a6952fa9ee13009862736cf8d110e6e5]

CVE-2022-48797: mm: don't try to NUMA-migrate COW pages that have other uses

Announce: https://lore.kernel.org/linux-cve-announce/2024071642-CVE-2022-48797-b404@gregkh/

Introduced by commit 09854ba ("mm: do_wp_page() simplification") in v5.9-rc4.
Fixed in v5.17-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [80d47f5de5e311cbc0d01ebb6ee684e8f4c196c6]
stable/5.10: [254090925e16abd914c87b4ad1b489440d89c4c3]
stable/5.15: [b3dc4b9d3ca68b370c4aeab5355007eedf948849]

CVE-2022-48798: s390/cio: verify the driver availability for path_event call

Announce: https://lore.kernel.org/linux-cve-announce/2024071643-CVE-2022-48798-2628@gregkh/

Introduced by commit 32ef938 ("s390/cio: Add support for FCES status
notification") in v5.11-rc1.
Fixed in v5.17-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd9cb842fa9d90653a9b48aba52f89c069f3bc50]
stable/5.15: [fe990b7bf6ac93f1d850d076b8f0e758268aa4ab]

CVE-2022-48799: perf: Fix list corruption in perf_cgroup_switch()

Announce: https://lore.kernel.org/linux-cve-announce/2024071643-CVE-2022-48799-9594@gregkh/

Introduced by commit 058fe1c ("perf/core: Make cgroup switch visit
only cpuctxs with cgroup events") in v4.11-rc1.
Fixed in v5.17-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5f4e5ce638e6a490b976ade4a40017b40abb2da0]
stable/4.19: [30d9f3cbe47e1018ddc8069ac5b5c9e66fbdf727]
stable/5.10: [f6b5d51976fcefef5732da3e3feb3ccff680f7c8]
stable/5.15: [7969fe91c9830e045901970e9d755b7505881d4a]
stable/5.4: [a2ed7b29d0673ba361546e2d87dbbed149456c45]

CVE-2022-48800: mm: vmscan: remove deadlock due to throttling failing
to make progress

Announce: https://lore.kernel.org/linux-cve-announce/2024071643-CVE-2022-48800-5ff8@gregkh/

Introduced by commit d818fca ("mm/vmscan: throttle reclaim and
compaction when too may pages are isolated") in v5.16-rc1.
Fixed in v5.17-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b485c6f1f9f54b81443efda5f3d8a5036ba2cd91]

CVE-2022-48801: iio: buffer: Fix file related error handling in
IIO_BUFFER_GET_FD_IOCTL

Announce: https://lore.kernel.org/linux-cve-announce/2024071644-CVE-2022-48801-5a19@gregkh/

Introduced by commit f73f7f4 ("iio: buffer: add ioctl() to support
opening extra buffers for IIO device") in v5.13-rc1.
Fixed in v5.17-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c72ea20503610a4a7ba26c769357d31602769c01]
stable/5.15: [b7f54894aa7517d2b6c797a499b9f491e9db9083]

CVE-2022-48802: fs/proc: task_mmu.c: don't read mapcount for migration entry

Announce: https://lore.kernel.org/linux-cve-announce/2024071644-CVE-2022-48802-a19f@gregkh/

Introduced by commit e9b61f1 ("thp: reintroduce split_huge_page()") in v4.5-rc1.
Fixed in v5.17-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [24d7275ce2791829953ed4e72f68277ceb2571c6]
stable/5.10: [db3f3636e4aed2cba3e4e7897a053323f7a62249]
stable/5.15: [a8dd0cfa37792863b6c4bf9542975212a6715d49]

CVE-2022-48803: phy: ti: Fix missing sentinel for clk_div_table

Announce: https://lore.kernel.org/linux-cve-announce/2024071644-CVE-2022-48803-ab28@gregkh/

Introduced by commit 091876c ("phy: ti: j721e-wiz: Add support for WIZ
module present in TI J721E SoC") in v5.6-rc1.
Fixed in v5.17-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d1e6bcb31663ee83aaea1f171f3dbfe95dd4a69]
stable/5.10: [3c75d1017cb362b6a4e0935746ef5da28250919f]
stable/5.15: [7a360e546ad9e7c3fd53d6bb60348c660cd28f54]

CVE-2022-48804: vt_ioctl: fix array_index_nospec in vt_setactivate

Announce: https://lore.kernel.org/linux-cve-announce/2024071645-CVE-2022-48804-f191@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc4.

Fixed status
cip/4.4: [fca8d5fada98defcc56889823a044f1190ec8d09]
cip/4.4-rt: [fca8d5fada98defcc56889823a044f1190ec8d09]
cip/4.4-st: [fca8d5fada98defcc56889823a044f1190ec8d09]
mainline: [61cc70d9e8ef5b042d4ed87994d20100ec8896d9]
stable/4.19: [170325aba4608bde3e7d21c9c19b7bc266ac0885]
stable/5.10: [778302ca09498b448620edd372dc908bebf80bdf]
stable/5.15: [ffe54289b02e9c732d6f04c8ebbe3b2d90d32118]
stable/5.4: [ae3d57411562260ee3f4fd5e875f410002341104]

CVE-2022-48805: net: usb: ax88179_178a: Fix out-of-bounds accesses in RX fixup

Announce: https://lore.kernel.org/linux-cve-announce/2024071645-CVE-2022-48805-afec@gregkh/

Introduced by commit e2ca90c ("ax88179_178a: ASIX AX88179_178A USB
3.0/2.0 to gigabit ethernet adapter driver") in v3.9-rc2.
Fixed in v5.17-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [e15f4029a2a0049c77337be7fd089989ebba750c]
cip/4.4-rt: [e15f4029a2a0049c77337be7fd089989ebba750c]
cip/4.4-st: [e15f4029a2a0049c77337be7fd089989ebba750c]
mainline: [57bc3d3ae8c14df3ceb4e17d26ddf9eeab304581]
stable/4.19: [1668781ed24da43498799aa4f65714a7de201930]
stable/5.10: [758290defe93a865a2880d10c5d5abd288b64b5d]
stable/5.15: [ffd0393adcdcefab7e131488e10dcfde5e02d6eb]
stable/5.4: [a0fd5492ee769029a636f1fb521716b022b1423d]

CVE-2022-48806: eeprom: ee1004: limit i2c reads to I2C_SMBUS_BLOCK_MAX

Announce: https://lore.kernel.org/linux-cve-announce/2024071645-CVE-2022-48806-445c@gregkh/

It was introduced by commit effa453 ("i2c: i801: Don't silently correct invalid
transfer size") in 5.17-rc1. Fixed in 5.17-rc4.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10
cip/5.10-rt stable/4.19 stable/5.10 stable/5.15 stable/5.4

Fixed status
mainline: [c0689e46be23160d925dca95dfc411f1a0462708]
stable/5.10: [a37960df7eac3cc8094bd1ab84864e9e32c91345]
stable/5.15: [9a5f471ae380f9fcb9756d453c12ca1f8595a93c]
stable/5.4: [3937c35493ee2847aaefcfa5460e94b7443eef49]

CVE-2022-48807: ice: Fix KASAN error in LAG NETDEV_UNREGISTER handler

Announce: https://lore.kernel.org/linux-cve-announce/2024071645-CVE-2022-48807-cd6e@gregkh/

Introduced by commit 6a8b357 ("ice: Respond to a NETDEV_UNREGISTER
event for LAG") in v5.15.
Fixed in v5.17-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bea1898f65b9b7096cb4e73e97c83b94718f1fa1]
stable/5.15: [f9daedc3ab8f673e3a9374b91a89fbf1174df469]

CVE-2022-48808: net: dsa: fix panic when DSA master device unbinds on shutdown

Announce: https://lore.kernel.org/linux-cve-announce/2024071646-CVE-2022-48808-a6fe@gregkh/

Introduced by commit 0650bf5 ("net: dsa: be compatible with masters
which unregister on shutdown") in v5.15-rc3.
Fixed in v5.17-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee534378f00561207656663d93907583958339ae]
stable/5.15: [ff45899e732e57088985e3a497b1d9100571c0f5]

CVE-2022-48809: net: fix a memleak when uncloning an skb dst and its metadata

Announce: https://lore.kernel.org/linux-cve-announce/2024071646-CVE-2022-48809-ba13@gregkh/

Introduced by commit fc4099f ("openvswitch: Fix egress tunnel info.") in v4.3.
Fixed in v5.17-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [e410676af66e026b8534bd52d1197f4752815848]
cip/4.4-rt: [e410676af66e026b8534bd52d1197f4752815848]
cip/4.4-st: [e410676af66e026b8534bd52d1197f4752815848]
mainline: [9eeabdf17fa0ab75381045c867c370f4cc75a613]
stable/4.19: [0be943916d781df2b652793bb2d3ae4f9624c10a]
stable/5.10: [00e6d6c3bc14dfe32824e2c515f0e0f2d6ecf2f1]
stable/5.15: [fdcb263fa5cda15b8cb24a641fa2718c47605314]
stable/5.4: [a80817adc2a4c1ba26a7aa5f3ed886e4a18dff88]

CVE-2022-48810: ipmr,ip6mr: acquire RTNL before calling
ip[6]mr_free_table() on failure path

Announce: https://lore.kernel.org/linux-cve-announce/2024071646-CVE-2022-48810-0940@gregkh/

Introduced by commit f243e5a ("ipmr,ip6mr: call ip6mr_free_table() on
failure path") in v4.0-rc7.
Fixed in v5.17-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [0de6a060816abba4f130fbdf3eea3da72530eccb]
cip/4.4-rt: [0de6a060816abba4f130fbdf3eea3da72530eccb]
cip/4.4-st: [0de6a060816abba4f130fbdf3eea3da72530eccb]
mainline: [5611a00697c8ecc5aad04392bea629e9d6a20463]
stable/4.19: [12b6703e9546902c56b4b9048b893ad49d62bdd4]
stable/5.10: [09ac0fcb0a82d647f2c61d3d488d367b7ee5bd51]
stable/5.15: [3cab045c99dbb9a94eb2d1d405f399916eec698a]
stable/5.4: [16dcfde98a25340ff0f7879a16bea141d824a196]

CVE-2022-48811: ibmvnic: don't release napi in __ibmvnic_open()

Announce: https://lore.kernel.org/linux-cve-announce/2024071647-CVE-2022-48811-5c54@gregkh/

Introduced by commit ed651a1 ("ibmvnic: Updated reset handling") in v4.12-rc1.
Fixed in v5.17-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [61772b0908c640d0309c40f7d41d062ca4e979fa]
stable/5.15: [960dfaf3b578dd23af012590e809ae2d58ba1827]

CVE-2022-48812: net: dsa: lantiq_gswip: don't use devres for mdiobus

Announce: https://lore.kernel.org/linux-cve-announce/2024071647-CVE-2022-48812-afaa@gregkh/

Introduced by commit ac3a68d ("net: phy: don't abuse devres in
devm_mdiobus_register()") in v5.9-rc1.
Fixed in v5.17-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0d120dfb5d67edc5bcd1804e167dba2b30809afd]
stable/5.10: [e177d2e85ebcd3008c4b2abc293f4118e04eedef]
stable/5.15: [b5652bc50dde7b84e93dfb25479b64b817e377c1]

CVE-2022-48813: net: dsa: felix: don't use devres for mdiobus

Announce: https://lore.kernel.org/linux-cve-announce/2024071647-CVE-2022-48813-9ecc@gregkh/

Introduced by commit ac3a68d ("net: phy: don't abuse devres in
devm_mdiobus_register()") in v5.9-rc1.
Fixed in v5.17-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [209bdb7ec6a28c7cdf580a0a98afbc9fc3b98932]
stable/5.10: [95e5402f9430b3c7d885dd3ec4c8c02c17936923]
stable/5.15: [8cda7577a0b4018572f31e0caadfabd305ea2786]

CVE-2022-48814: net: dsa: seville: register the mdiobus under devres

Announce: https://lore.kernel.org/linux-cve-announce/2024071648-CVE-2022-48814-a8d7@gregkh/

Introduced by commit ac3a68d ("net: phy: don't abuse devres in
devm_mdiobus_register()") in v5.9-rc1.
Fixed in v5.17-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bd488afc3b39e045ba71aab472233f2a78726e7b]
stable/5.15: [1d13e7221035947c62800c9d3d99b4ed570e27e7]

CVE-2022-48815: net: dsa: bcm_sf2: don't use devres for mdiobus

Announce: https://lore.kernel.org/linux-cve-announce/2024071648-CVE-2022-48815-9659@gregkh/

Introduced by commit ac3a68d ("net: phy: don't abuse devres in
devm_mdiobus_register()") in v5.9-rc1.
Fixed in v5.17-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [08f1a20822349004bb9cc1b153ecb516e9f2889d]
stable/5.10: [2770b795294ed312375c11ef1d0b810499c66b83]
stable/5.15: [caabb5f64f5c32fceed93356bb688ef1ec6c5783]

CVE-2022-48816: SUNRPC: lock against ->sock changing during sysfs read

Announce: https://lore.kernel.org/linux-cve-announce/2024071648-CVE-2022-48816-e2a3@gregkh/

Introduced by commit 17f09d3 ("SUNRPC: Check if the xprt is connected
before handling sysfs reads") in v5.16-rc1.
Introduced by commit a848248 ("SUNRPC query transport's source port")
in v5.14-rc1.
Fixed in v5.17-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b49ea673e119f59c71645e2f65b3ccad857c90ee]

CVE-2022-48817: net: dsa: ar9331: register the mdiobus under devres

Announce: https://lore.kernel.org/linux-cve-announce/2024071649-CVE-2022-48817-ec7b@gregkh/

Introduced by commit ac3a68d ("net: phy: don't abuse devres in
devm_mdiobus_register()") in v5.9-rc1.
Fixed in v5.17-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [50facd86e9fbc4b93fe02e5fe05776047f45dbfb]
stable/5.10: [475ce5dcf2d88fd4f3c213a0ac944e3e40702970]
stable/5.15: [aae1c6a1d3d696fc33b609fb12fe744a556d1dc5]

CVE-2022-48818: net: dsa: mv88e6xxx: don't use devres for mdiobus

Announce: https://lore.kernel.org/linux-cve-announce/2024071649-CVE-2022-48818-4dbb@gregkh/

Introduced by commit ac3a68d ("net: phy: don't abuse devres in
devm_mdiobus_register()") in v5.9-rc1.
Fixed in v5.17-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f53a2ce893b2c7884ef94471f170839170a4eba0]
stable/5.10: [8ccebe77df6e0d88c72ba5e69cf1835927e53b6c]
stable/5.15: [8b626d45127d6f5ada7d815b83cfdc09e8cb1394]

CVE-2022-48819: tcp: take care of mixed splice()/sendmsg(MSG_ZEROCOPY) case

Announce: https://lore.kernel.org/linux-cve-announce/2024071649-CVE-2022-48819-16f6@gregkh/

Introduced by commit 9b65b17 ("net: avoid double accounting for pure
zerocopy skbs") in v5.16-rc1.
Fixed in v5.17-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8d9d938514f46c4892aff6bfe32f425e84d81cc]

CVE-2022-48820: phy: stm32: fix a refcount leak in stm32_usbphyc_pll_enable()

Announce: https://lore.kernel.org/linux-cve-announce/2024071649-CVE-2022-48820-3db4@gregkh/

Introduced by commit 5b1af71 ("phy: stm32: rework PLL Lock detection")
in v5.12-rc1.
Fixed in v5.17-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cfc826c88a79e22ba5d8001556eb2c7efd8a01b6]
stable/5.15: [94b16ca86ab688ed6fad4548f70137f93cf1f0a9]

CVE-2022-48821: misc: fastrpc: avoid double fput() on failed usercopy

Announce: https://lore.kernel.org/linux-cve-announce/2024071650-CVE-2022-48821-5c97@gregkh/

Introduced by commit 6cffd79 ("misc: fastrpc: Add support for dmabuf
exporter") in v5.1-rc1.
Fixed in v5.17-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [46963e2e0629cb31c96b1d47ddd89dc3d8990b34]
stable/5.10: [a5ce7ee5fcc07583159f54ab4af5164de00148f5]
stable/5.15: [e4382d0a39f9a1e260d62fdc079ddae5293c037d]
stable/5.4: [4e6fd2b5fcf8e7119305a6042bd92e7f2b9ed215]

CVE-2022-48822: usb: f_fs: Fix use-after-free for epfile

Announce: https://lore.kernel.org/linux-cve-announce/2024071650-CVE-2022-48822-48d1@gregkh/

Introduced by commit a9e6f83 ("usb: gadget: f_fs: stop sleeping in
ffs_func_eps_disable") in v4.9-rc3.
Fixed in v5.17-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ebe2b1add1055b903e2acd86b290a85297edc0b3]
stable/4.19: [cfe5f6fd335d882bcc829a1c8a7d462a455c626e]
stable/5.10: [0042178a69eb77a979e36a50dcce9794a3140ef8]
stable/5.15: [72a8aee863af099d4434314c4536d6c9a61dcf3c]
stable/5.4: [c9fc422c9a43e3d58d246334a71f3390401781dc]

CVE-2022-48823: scsi: qedf: Fix refcount issue when LOGO is received during TMF

Announce: https://lore.kernel.org/linux-cve-announce/2024071650-CVE-2022-48823-373d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc2.
It seems as if this bug was introduced by commit 5d5e556 ("scsi: qedf:
Modify flush routine to handle all I/Os and TMF") in 5.2-rc1.

Fixed status
mainline: [5239ab63f17cee643bd4bf6addfedebaa7d4f41e]
stable/5.10: [87f187e5265bc8e3b38faef8b9db864cdd61dde7]
stable/5.15: [6be8eaad75ca73131e2a697f0270dc8ee73814a8]
stable/5.4: [7cc32ff0cd6c44a3c26de5faecfe8b5546198fad]

CVE-2022-48824: scsi: myrs: Fix crash in error case

Announce: https://lore.kernel.org/linux-cve-announce/2024071651-CVE-2022-48824-2c1e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc2.
It seems as if this bug was introduced by commit 77266186 ("scsi: myrs: Add
Mylex RAID controller (SCSI interface)") in 4.20-rc1.

Fixed status
mainline: [4db09593af0b0b4d7d4805ebb3273df51d7cc30d]
stable/5.10: [0e42c4a3d732517edc3766dd45a14e60d29dd929]
stable/5.15: [6207f35c213f6cb2fc3f13b5e77f08c710e1de19]
stable/5.4: [5c5ceea00c8c9df150708e66cb9f2891192c1162]

CVE-2022-48825: scsi: qedf: Add stag_work to all the vports

Announce: https://lore.kernel.org/linux-cve-announce/2024071651-CVE-2022-48825-8c19@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc2.
It seems as if this bug was introduced by commit 61d8658b ("scsi: qedf:
Add QLogic FastLinQ offload FCoE driver framework.") in 4.11-rc1.

Fixed status
mainline: [b70a99fd13282d7885f69bf1372e28b7506a1613]
stable/5.10: [aa7352aa155e19815b41f09f114fe9f110fde4d8]
stable/5.15: [1f53bbf27a876f7e61262bd74c18680ac11d4c31]

CVE-2022-48826: drm/vc4: Fix deadlock on DSI device attach error

Announce: https://lore.kernel.org/linux-cve-announce/2024071651-CVE-2022-48826-9956@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc2.
Affected file was introduced by commit 4078f575 ("drm/vc4: Add DSI
driver") in 4.11-rc1.

Fixed status
mainline: [0a3d12ab5097b1d045e693412e6b366b7e82031b]
stable/5.15: [770d1ba9a8201ce9bee0946eb03746449b6f3b80]

CVE-2022-48827: NFSD: Fix the behavior of READ near OFFSET_MAX

Announce: https://lore.kernel.org/linux-cve-announce/2024071652-CVE-2022-48827-f95b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc4.

Fixed status
mainline: [0cb4d23ae08c48f6bf3c29a8e5c4a74b8388b960]
stable/5.10: [1726a39b0879acfb490b22dca643f26f4f907da9]
stable/5.15: [c6eff5c4277146a78b4fb8c9b668dd64542c41b0]

CVE-2022-48828: NFSD: Fix ia_size underflow

Announce: https://lore.kernel.org/linux-cve-announce/2024071652-CVE-2022-48828-97cb@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc4.

Fixed status
mainline: [e6faac3f58c7c4176b66f63def17a34232a17b0e]
stable/5.10: [38d02ba22e43b6fc7d291cf724bc6e3b7be6626b]
stable/5.15: [8e0ecaf7a7e57b30284d6b3289cc436100fadc48]

CVE-2022-48829: NFSD: Fix NFSv3 SETATTR/CREATE's handling of large file sizes

Announce: https://lore.kernel.org/linux-cve-announce/2024071652-CVE-2022-48829-2145@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc4.
It seems as if this bug was introduced by commit 9cde936 ("NFSD: Update the
SETATTR3args decoder to use struct xdr_stream") in 5.12-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 stable/5.10

Fixed status
mainline: [a648fdeb7c0e17177a2280344d015dba3fbe3314]
stable/5.10: [a231ae6bb50e7c0a9e9efd7b0d10687f1d71b3a3]
stable/5.15: [37f2d2cd8eadddbbd9c7bda327a9393399b2f89b]

CVE-2022-48830: can: isotp: fix potential CAN frame reception race in
isotp_rcv()

Announce: https://lore.kernel.org/linux-cve-announce/2024071652-CVE-2022-48830-8dbf@gregkh/

Introduced by commit e057dd3 ("can: add ISO 15765-2:2016 transport
protocol") in v5.10-rc1.
Fixed in v5.17-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7c759040c1dd03954f650f147ae7175476d51314]
stable/5.10: [7b53d2204ce79b27a878074a77d64f40ec21dbca]
stable/5.15: [f90cc68f9f4b5d8585ad5d0a206a9d37ac299ef3]

CVE-2022-48831: ima: fix reference leak in asymmetric_verify()

Announce: https://lore.kernel.org/linux-cve-announce/2024071653-CVE-2022-48831-d6b7@gregkh/

Introduced by commit 947d705 ("ima: Support EC keys for signature
verification") in v5.13-rc1.
Fixed in v5.17-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [926fd9f23b27ca6587492c3f58f4c7f4cd01dad5]
stable/5.15: [0838d6d68182f0b28a5434bc6d50727c4757e35b]

CVE-2022-48832: audit: don't deref the syscall args when checking the
openat2 open_how::flags

Announce: https://lore.kernel.org/linux-cve-announce/2024071653-CVE-2022-48832-1322@gregkh/

Introduced by commit 1c30e3a ("audit: add support for the openat2
syscall") in v5.16-rc1.
Fixed in v5.17-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7a82f89de92aac5a244d3735b2bd162c1147620c]

CVE-2022-48833: btrfs: skip reserved bytes warning on unmount after
log cleanup failure

Announce: https://lore.kernel.org/linux-cve-announce/2024071617-CVE-2022-48833-69a8@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc3.
According to the commit log, commit c2e3930 ("btrfs: clear extent
buffer uptodate
when we fail to write it") and 651740a ("btrfs: check WRITE_ERR when trying to
read an extent buffer") are mentioned.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [40cdc509877bacb438213b83c7541c5e24a1d9ec]
stable/5.15: [4c5d94990fa2fd609360ecd0f7e183212a7d115c]

CVE-2022-48834: usb: usbtmc: Fix bug in pipe direction for control transfers

Announce: https://lore.kernel.org/linux-cve-announce/2024071620-CVE-2022-48834-c369@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17.
It seems as if this bug was introduced by commit 658f24f ("usb: usbtmc: Add
ioctl for generic requests on control") in 4.20-rc1.

Fixed status
mainline: [e9b667a82cdcfe21d590344447d65daed52b353b]
stable/5.10: [10a805334a11acd547602d6c4cf540a0f6ab5c6e]
stable/5.15: [c69aef9db878ab277068a8cc1b4bf0cf309dc2b7]
stable/5.4: [700a0715854c1e79a73341724ce4f5bb01abc016]

CVE-2022-48835: scsi: mpt3sas: Page fault in reply q processing

Announce: https://lore.kernel.org/linux-cve-announce/2024071620-CVE-2022-48835-7cd5@gregkh/

Introduced by commit 711a923 ("scsi: mpt3sas: Postprocessing of target
and LUN reset") in v5.10-rc1.
Fixed in v5.17.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [69ad4ef868c1fc7609daa235dfa46d28ba7a3ba3]
stable/5.10: [98e7a654a5bebaf1a28e987af5e44c002544a413]
stable/5.15: [0cd2dd4bcf4abc812148c4943f966a3c8dccb00f]

CVE-2022-48836: Input: aiptek - properly check endpoint type

Announce: https://lore.kernel.org/linux-cve-announce/2024071620-CVE-2022-48836-fb3d@gregkh/

Introduced by commit 8e20cf2 ("Input: aiptek - fix crash on detecting
device without endpoints") in v4.4-rc6.
Fixed in v5.17.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [c383c8867e935430ca360969afd727526db42cf5]
cip/4.4-rt: [c383c8867e935430ca360969afd727526db42cf5]
cip/4.4-st: [c383c8867e935430ca360969afd727526db42cf5]
mainline: [5600f6986628dde8881734090588474f54a540a8]
stable/4.19: [6de20111cd0bb7da9b2294073ba00c7d2a6c1c4f]
stable/5.10: [f0d43d22d24182b94d7eb78a2bf6ae7e2b33204a]
stable/5.15: [e762f57ff255af28236cd02ca9fc5c7e5a089d31]
stable/5.4: [e732b0412f8c603d1e998f3bff41b5e7d5c3914c]

CVE-2022-48837: usb: gadget: rndis: prevent integer overflow in
rndis_set_response()

Announce: https://lore.kernel.org/linux-cve-announce/2024071621-CVE-2022-48837-9325@gregkh/

This CVE announce does not contain fixed commit in the mainline.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10
cip/5.10-rt stable/4.19 stable/5.10 stable/5.15 stable/5.4

Fixed status
cip/4.4: [debcd5bcbe8ab6cfaf703ad7f7333308e388874a]
cip/4.4-rt: [debcd5bcbe8ab6cfaf703ad7f7333308e388874a]
cip/4.4-st: [debcd5bcbe8ab6cfaf703ad7f7333308e388874a]
mainline: [65f3324f4b6fed78b8761c3b74615ecf0ffa81fa]
stable/4.19: [138d4f739b35dfb40438a0d5d7054965763bfbe7]
stable/5.10: [28bc0267399f42f987916a7174e2e32f0833cc65]
stable/5.15: [56b38e3ca4064041d93c1ca18828c8cedad2e16c]
stable/5.4: [21829376268397f9fd2c35cfa9135937b6aa3a1e]

CVE-2022-48838: usb: gadget: Fix use-after-free bug by not setting
udc->dev.driver

Announce: https://lore.kernel.org/linux-cve-announce/2024071621-CVE-2022-48838-ead7@gregkh/

Introduced by commit 2ccea03 ("usb: gadget: introduce UDC Class") in v3.1-rc1.
Fixed in v5.17.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [16b1941eac2bd499f065a6739a40ce0011a3d740]
stable/4.19: [609a7119bffe3ddd7c93f2fa65be8917e02a0b7e]
stable/5.10: [00bdd9bf1ac6d401ad926d3d8df41b9f1399f646]
stable/5.15: [2015c23610cd0efadaeca4d3a8d1dae9a45aa35a]
stable/5.4: [2282a6eb6d4e118e294e43dcc421e0e0fe4040b5]

CVE-2022-48839: net/packet: fix slab-out-of-bounds access in packet_recvmsg()

Announce: https://lore.kernel.org/linux-cve-announce/2024071621-CVE-2022-48839-09f9@gregkh/

Introduced by commit 0fb375f ("[AF_PACKET]: Allow for > 8 byte
hardware addresses.") in v2.6.20.16.
Fixed in v5.17.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [b63f1369cfbe8b496fda059db3b2403e37b7c8be]
cip/4.4-rt: [b63f1369cfbe8b496fda059db3b2403e37b7c8be]
cip/4.4-st: [b63f1369cfbe8b496fda059db3b2403e37b7c8be]
mainline: [c700525fcc06b05adfea78039de02628af79e07a]
stable/4.19: [a33dd1e6693f80d805155b3f69c18c2f642915da]
stable/5.10: [70b7b3c055fd4a464da8da55ff4c1f84269f9b02]
stable/5.15: [a055f5f2841f7522b44a2b1eccb1951b4b03d51a]
stable/5.4: [268dcf1f7b3193bc446ec3d14e08a240e9561e4d]

CVE-2022-48840: iavf: Fix hang during reboot/shutdown

Announce: https://lore.kernel.org/linux-cve-announce/2024071622-CVE-2022-48840-d1d6@gregkh/

It was introduced by commit 974578017fc1 ("iavf: Add waiting so the port is
initialized in remove") in 5.17-rc7. Fixed in 5.17.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [b04683ff8f0823b869c219c78ba0d974bddea0b5]
stable/5.15: [80974bb730270199c6fcb189af04d5945b87e813]

CVE-2022-48841: ice: fix NULL pointer dereference in
ice_update_vsi_tx_ring_stats()

Announce: https://lore.kernel.org/linux-cve-announce/2024071622-CVE-2022-48841-67c8@gregkh/

Introduced by commit e72bba2 ("ice: split ice_ring onto Tx/Rx separate
structs") in v5.16-rc1.
Fixed in v5.17.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f153546913bada41a811722f2c6d17c3243a0333]

CVE-2022-48842: ice: Fix race condition during interface enslave

Announce: https://lore.kernel.org/linux-cve-announce/2024071622-CVE-2022-48842-3be7@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc8.
According to the commit log, commit 5dbbbd01 ("ice: Avoid RTNL lock when
re-creating auxiliary device") in 5.17-rc4 is mentioned.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [5cb1ebdbc4342b1c2ce89516e19808d64417bdbc]
stable/5.15: [a9bbacc53d1f5ed8febbfdf31401d20e005f49ef]

CVE-2022-48843: drm/vrr: Set VRR capable prop only if it is attached
to connector

Announce: https://lore.kernel.org/linux-cve-announce/2024071623-CVE-2022-48843-b23b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc7.
It seems as if this bug was introduced by commit ba1b0f6c ("drm:
Add vrr_capable property to the drm connector") in 5.0-rc1.

Fixed status
mainline: [62929726ef0ec72cbbe9440c5d125d4278b99894]
stable/5.10: [0ba557d330946c23559aaea2d51ea649fdeca98a]
stable/5.15: [3534c5c005ef99a1804ed50b8a72cdae254cabb5]
stable/5.4: [941e8bcd2b2ba95490738e33dfeca27168452779]

CVE-2022-48844: Bluetooth: hci_core: Fix leaking sent_cmd skb

Announce: https://lore.kernel.org/linux-cve-announce/2024071623-CVE-2022-48844-cc1f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc7.
It seems as if this bug was introduced by commit 58ce6d5b27 ("Bluetooth:
defer cleanup of resources in hci_unregister_dev()") in 5.15-rc1.

Fixed status
mainline: [dd3b1dc3dd050f1f47cd13e300732852414270f8]
stable/5.15: [3679ccc09d8806686d579095ed504e045af7f7d6]

CVE-2022-48845: MIPS: smp: fill in sibling and core maps earlier

Announce: https://lore.kernel.org/linux-cve-announce/2024071623-CVE-2022-48845-880a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc7.

Fixed status
cip/4.4: [7d408d308424a9e45a6ad54b32cbf191b5607c07]
cip/4.4-rt: [7d408d308424a9e45a6ad54b32cbf191b5607c07]
cip/4.4-st: [7d408d308424a9e45a6ad54b32cbf191b5607c07]
mainline: [f2703def339c793674010cc9f01bfe4980231808]
stable/4.19: [56eaacb8137ba2071ce48d4e3d91979270e139a7]
stable/5.10: [e8ad9ecc406974deb5e7c070f51cc1d09d21dc4b]
stable/5.15: [be538b764a46be1d0700fd3b6e82fb76bd17f13a]
stable/5.4: [c2420bc3333111184cdcb112282d13afe1338dd7]

CVE-2022-48846: block: release rq qos structures for queue without disk

Announce: https://lore.kernel.org/linux-cve-announce/2024071623-CVE-2022-48846-a1a8@gregkh/

Introduced by commit 8e141f9 ("block: drain file system I/O on
del_gendisk") in v5.15-rc6.
Fixed in v5.17.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [daaca3522a8e67c46e39ef09c1d542e866f85f3b]
stable/5.15: [d4ad8736ac982111bb0be8306bf19c8207f6600e]

CVE-2022-48847: watch_queue: Fix filter limit check

Announce: https://lore.kernel.org/linux-cve-announce/2024071624-CVE-2022-48847-42ea@gregkh/

Introduced by commit c73be61 ("pipe: Add general notification queue
support") in v5.8-rc1.
Fixed in v5.17-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c993ee0f9f81caf5767a50d1faeba39a0dc82af2]
stable/5.10: [648895da69ced90ca770fd941c3d9479a9d72c16]
stable/5.15: [1b09f28f70a5046acd64138075ae3f095238b045]

CVE-2022-48848: tracing/osnoise: Do not unregister events twice

Announce: https://lore.kernel.org/linux-cve-announce/2024071624-CVE-2022-48848-3cfb@gregkh/

Introduced by commit 2fac8d6 ("tracing/osnoise: Allow multiple
instances of the same tracer") in v5.16-rc1.
Fixed in v5.17-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0cfe17bcc1dd2f0872966b554a148e888833ee9]

CVE-2022-48849: drm/amdgpu: bypass tiling flag check in virtual
display case (v2)

Announce: https://lore.kernel.org/linux-cve-announce/2024071624-CVE-2022-48849-3119@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc6.
It seems as if this bug was introduced by commit 2f350dda
("drm/amdgpu: check tiling flags when creating FB on GFX8-") in 5.16-rc1.

Fixed status
mainline: [e2b993302f40c4eb714ecf896dd9e1c5be7d4cd7]
stable/5.15: [fcd1d79aa943fff4fbaa0cce1d576995a7960699]

CVE-2022-48850: net-sysfs: add check for netdevice being present to speed_show

Announce: https://lore.kernel.org/linux-cve-announce/2024071625-CVE-2022-48850-247b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc6.

Fixed status
cip/4.4: [e575e5e25df98fe54478725691ea9060b114a33f]
cip/4.4-rt: [e575e5e25df98fe54478725691ea9060b114a33f]
cip/4.4-st: [e575e5e25df98fe54478725691ea9060b114a33f]
mainline: [4224cfd7fb6523f7a9d1c8bb91bb5df1e38eb624]
stable/4.19: [75fc8363227a999e8f3d17e2eb28dce5600dcd3f]
stable/5.10: [d15c9f6e3335002fea1c33bc8f71a705fa96976c]
stable/5.15: [8d5e69d8fbf3a35ab4fbe56b8f092802b43f3ef6]
stable/5.4: [8879b5313e9fa5e0c6d6812a0d25d83aed0110e2]

CVE-2022-48851: staging: gdm724x: fix use after free in gdm_lte_rx()

Announce: https://lore.kernel.org/linux-cve-announce/2024071625-CVE-2022-48851-4dad@gregkh/

Introduced by commit 61e1210 ("staging: gdm7240: adding LTE USB
driver") in v3.12-rc1.
Fixed in v5.17-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [26e8ec43e5e38a5c9a298a4c15a0924fcfce45dc]
cip/4.4-rt: [26e8ec43e5e38a5c9a298a4c15a0924fcfce45dc]
cip/4.4-st: [26e8ec43e5e38a5c9a298a4c15a0924fcfce45dc]
mainline: [fc7f750dc9d102c1ed7bbe4591f991e770c99033]
stable/4.19: [48ecdf3e29a6e514e8196691589c7dfc6c4ac169]
stable/5.10: [6d9700b445098dbbce0caff4b8cfca214cf1e757]
stable/5.15: [1fb9dd3787495b4deb0efe66c58306b65691a48f]
stable/5.4: [403e3afe241b62401de1f8629c9c6b9b3d69dbff]

CVE-2022-48852: drm/vc4: hdmi: Unregister codec device on unbind

Announce: https://lore.kernel.org/linux-cve-announce/2024071625-CVE-2022-48852-9475@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc6.

Fixed status
mainline: [e40945ab7c7f966d0c37b7bd7b0596497dfe228d]
stable/5.15: [ee22082c3e2f230028afa0e22aa8773b1de3c919]

CVE-2022-48853: swiotlb: fix info leak with DMA_FROM_DEVICE

Announce: https://lore.kernel.org/linux-cve-announce/2024071626-CVE-2022-48853-c6d8@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc6.

Fixed status
mainline: [ddbd89deb7d32b1fbb879f48d68fda1a8ac58e8e]
stable/4.19: [8d9ac1b6665c73f23e963775f85d99679fd8e192]
stable/5.10: [d4d975e7921079f877f828099bb8260af335508f]
stable/5.15: [7403f4118ab94be837ab9d770507537a8057bc63]
stable/5.4: [6bfc5377a210dbda2a237f16d94d1bd4f1335026]

CVE-2022-48854: net: arc_emac: Fix use after free in arc_mdio_probe()

Announce: https://lore.kernel.org/linux-cve-announce/2024071626-CVE-2022-48854-9d4e@gregkh/

Introduced by commit 95b5fc0 ("net: arc_emac: Make use of the helper
function dev_err_probe()") in v5.16-rc1.
Fixed in v5.17-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc0e610a6eb0d46e4123fafdbe5e6141d9fff3be]

CVE-2022-48855: sctp: fix kernel-infoleak for SCTP sockets

Announce: https://lore.kernel.org/linux-cve-announce/2024071626-CVE-2022-48855-cce9@gregkh/

Introduced by commit 8f840e4 ("sctp: add the sctp_diag.c file") in v4.7-rc1.
Fixed in v5.17-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [633593a808980f82d251d0ca89730d8bb8b0220c]
stable/4.19: [2d8fa3fdf4542a2174a72d92018f488d65d848c5]
stable/5.10: [b7e4d9ba2ddb78801488b4c623875b81fb46b545]
stable/5.15: [1502f15b9f29c41883a6139f2923523873282a83]
stable/5.4: [bbf59d7ae558940cfa2b36a287fd1e88d83f89f8]

CVE-2022-48856: gianfar: ethtool: Fix refcount leak in gfar_get_ts_info

Announce: https://lore.kernel.org/linux-cve-announce/2024071626-CVE-2022-48856-fd52@gregkh/

Introduced by commit 7349a74 ("net: ethernet: gianfar_ethtool: get phc
index through drvdata") in v4.18-rc1.
Fixed in v5.17-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ac5b58e645c66932438bb021cb5b52097ce70b0]
stable/4.19: [6263f2eb93a85ad7df504daf0c341a7fb6bbe8a6]
stable/5.10: [21044e679ed535345042d2023f7df0ca8e897e2a]
stable/5.15: [f49f646f9ec296fc0afe7ae92c2bb47f23e3846c]
stable/5.4: [f7b3b520349193f8a82cca74daf366199e06add9]

CVE-2022-48857: NFC: port100: fix use-after-free in port100_send_complete

Announce: https://lore.kernel.org/linux-cve-announce/2024071627-CVE-2022-48857-e0b2@gregkh/

Introduced by commit 0347a6a ("NFC: port100: Commands mechanism
implementation") in v3.13-rc1.
Fixed in v5.17-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [61adee669dc8e6c9f724f04fe356f0eee7398eb3]
cip/4.4-rt: [61adee669dc8e6c9f724f04fe356f0eee7398eb3]
cip/4.4-st: [61adee669dc8e6c9f724f04fe356f0eee7398eb3]
mainline: [f80cfe2f26581f188429c12bd937eb905ad3ac7b]
stable/4.19: [b1db33d4e54bc35d8db96ce143ea0ef92e23d58e]
stable/5.10: [2b1c85f56512d49e43bc53741fce2f508cd90029]
stable/5.15: [0e721b8f2ee5e11376dd55363f9ccb539d754b8a]
stable/5.4: [cd2a5c0da0d1ddf11d1f84e9c9b1949f50f6e161]

CVE-2022-48858: net/mlx5: Fix a race on command flush flow

Announce: https://lore.kernel.org/linux-cve-announce/2024071627-CVE-2022-48858-5d3f@gregkh/

Introduced by commit 50b2412 ("net/mlx5: Avoid possible free of
command entry while timeout comp handler") in v5.9.
Fixed in v5.17-rc8.
Bug introduced commit was backported to following branches.
stable/5.4

Fixed status
mainline: [063bd355595428750803d8736a9bb7c8db67d42d]
stable/5.10: [f3331bc17449f15832c31823f27573f4c0e13e5f]
stable/5.15: [7c519f769f555ff7d9d4ccba3497bbb589df360a]
stable/5.4: [1a4017926eeea56c7540cc41b42106746ee8a0ee]

CVE-2022-48859: net: marvell: prestera: Add missing of_node_put() in
prestera_switch_set_base_mac_addr

Announce: https://lore.kernel.org/linux-cve-announce/2024071627-CVE-2022-48859-4427@gregkh/

Introduced by commit 501ef30 ("net: marvell: prestera: Add driver for
Prestera family ASIC devices") in v5.10-rc1.
Fixed in v5.17-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9ffa3e2bc451816ce0295e40063514fabf2bd36]
stable/5.15: [b7c2fd1d126329340639adfb8dd2938fe4b65df7]

CVE-2022-48860: ethernet: Fix error handling in xemaclite_of_probe

Announce: https://lore.kernel.org/linux-cve-announce/2024071628-CVE-2022-48860-92e9@gregkh/

Introduced by commit 5cdaaa1 ("net: emaclite: adding MDIO and phy lib
support") in v2.6.34-rc1.
Fixed in v5.17-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [dbb45072885612a10a4f875390077922485366b3]
cip/4.4-rt: [dbb45072885612a10a4f875390077922485366b3]
cip/4.4-st: [dbb45072885612a10a4f875390077922485366b3]
mainline: [b19ab4b38b06aae12442b2de95ccf58b5dc53584]
stable/4.19: [8609e29611befc4bfbe7a91bb50fc65ae72ff549]
stable/5.10: [979b418b96e35f07136f77962ccfaa54cf3e30e1]
stable/5.15: [5e7c402892e189a7bc152b125e72261154aa585d]
stable/5.4: [8ee065a7a9b6a3976c16340503677efc4d8351f6]

CVE-2022-48861: vdpa: fix use-after-free on vp_vdpa_remove

Announce: https://lore.kernel.org/linux-cve-announce/2024071628-CVE-2022-48861-440e@gregkh/

Introduced by commit 64b9f64 ("vdpa: introduce virtio pci driver") in v5.13-rc1.
Fixed in v5.17-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb057b44dbe35ae14527830236a92f51de8f9184]
stable/5.15: [4b1743bc715a3691a63ac21b349079b07bf1b19e]

CVE-2022-48862: vhost: fix hung thread due to erroneous iotlb entries

Announce: https://lore.kernel.org/linux-cve-announce/2024071628-CVE-2022-48862-0c27@gregkh/

Introduced by commit 0bbe306 ("vhost: factor out IOTLB") in v5.7-rc1.
Fixed in v5.17-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e2ae38cf3d91837a493cb2093c87700ff3cbe667]
stable/5.15: [f8d88e86e90ea1002226d7ac2430152bfea003d1]

CVE-2022-48863: mISDN: Fix memory leak in dsp_pipeline_build()

Announce: https://lore.kernel.org/linux-cve-announce/2024071629-CVE-2022-48863-3df7@gregkh/

Introduced by commit 960366c ("Add mISDN DSP") in v2.6.27-rc1.
Fixed in v5.17-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c6a502c2299941c8326d029cfc8a3bc8a4607ad5]
stable/5.10: [a3d5fcc6cf2ecbba5a269631092570aa285a24cb]
stable/5.15: [7777b1f795af1bb43867375d8a776080111aae1b]

CVE-2022-48864: vdpa/mlx5: add validation for
VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command

Announce: https://lore.kernel.org/linux-cve-announce/2024071629-CVE-2022-48864-2b26@gregkh/

Introduced by commit 5289373 ("vdpa/mlx5: Add multiqueue support") in v5.15-rc1.
Fixed in v5.17-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ed0f849fc3a63ed2ddf5e72cdb1de3bdbbb0f8eb]
stable/5.15: [e7e118416465f2ba8b55007e5b789823e101421e]

CVE-2022-48865: tipc: fix kernel panic when enabling bearer

Announce: https://lore.kernel.org/linux-cve-announce/2024071629-CVE-2022-48865-bd8b@gregkh/

Introduced by commit 35c55c9 ("tipc: add neighbor monitoring
framework") in v4.8-rc1.
Fixed in v5.17-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be4977b847f5d5cedb64d50eaaf2218c3a55a3a3]
stable/5.10: [2de76d37d4a6dca9b96ea51da24d4290e6cfa1a5]
stable/5.15: [f96dc3adb9a97b8f3dfdb88796483491a3006b71]

CVE-2022-48866: HID: hid-thrustmaster: fix OOB read in thrustmaster_interrupts

Announce: https://lore.kernel.org/linux-cve-announce/2024071629-CVE-2022-48866-93bd@gregkh/

Introduced by commit c49c336 ("HID: support for initialization of some
Thrustmaster wheels") in v5.13-rc1.
Fixed in v5.17-rc8.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fc3ef2e3297b3c0e2006b5d7b3d66965e3392036]
stable/5.15: [3ffbe85cda7f523dad896bae08cecd8db8b555ab]

CVE-2023-52886: USB: core: Fix race by not overwriting
udev->descriptor in hub_port_init()

Announce: https://lore.kernel.org/linux-cve-announce/2024071601-CVE-2023-52886-a235@gregkh/

Introduced by commit 45bf39f ("USB: core: Don't hold device lock while
reading the "descriptors" sysfs file") in v6.3-rc1.
Fixed in v6.6-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10
cip/5.10-rt cip/6.1 cip/6.1-rt stable/4.19 stable/5.10 stable/5.15
stable/5.4 stable/6.1

Fixed status
mainline: [ff33299ec8bb80cdcc073ad9c506bd79bb2ed20b]
stable/5.10: [9d241c5d9a9b7ad95c90c6520272fe404d5ac88f]
stable/5.15: [7fe9d87996062f5eb0ca476ad0257f79bf43aaf5]
stable/6.1: [8186596a663506b1124bede9fde6f243ef9f37ee]

CVE-2024-41008: drm/amdgpu: change vm->task_info handling

Announce: https://lore.kernel.org/linux-cve-announce/20240716080357.2696435-2-lee@kernel.org/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc1.

Fixed status
mainline: [b8f67b9ddf4f8fe6dd536590712b5912ad78f99c]

CVE-2024-41009: bpf: Fix overrunning reservations in ringbuf

Announce: https://lore.kernel.org/linux-cve-announce/2024071715-CVE-2024-41009-cac5@gregkh/

Introduced by commit 457f443 ("bpf: Implement BPF ring buffer and
verifier support for it") in v5.8-rc1.
Fixed in v6.10-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cfa1a2329a691ffd991fcf7248a57d752e712881]
stable/6.1: [d1b9df0435bc61e0b44f578846516df8ef476686]
stable/6.6: [511804ab701c0503b72eac08217eabfd366ba069]

CVE-2024-41010: bpf: Fix too early release of tcx_entry

Announce: https://lore.kernel.org/linux-cve-announce/2024071718-CVE-2024-41010-9042@gregkh/

Introduced by commit e420bed ("bpf: Add fd-based tcx multi-prog infra
with link support") in v6.6-rc1.
Fixed in v6.10.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1cb6f0bae50441f4b4b32a28315853b279c7404e]


* Updated CVEs

CVE-2024-39487: bonding: Fix out-of-bounds read in
bond_option_arp_ip_targets_set()

stable 6.1, 6.6, and 6.9 were fixed.

Fixed status
mainline: [e271ff53807e8f2c628758290f0e499dbe51cb3d]
stable/6.1: [c8eb8ab9a44ff0e73492d0a12a643c449f641a9f]
stable/6.6: [b75e33eae8667084bd4a63e67657c6a5a0f8d1e8]
stable/6.9: [9f835e48bd4c75fdf6a9cff3f0b806a7abde78da]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com


Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1922AC54E66
	for <webhook@archiver.kernel.org>; Wed, 13 Mar 2024 23:34:50 +0000 (UTC)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
 by mx.groups.io with SMTP id smtpd.web10.11284.1710372886593564007
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Mar 2024 16:34:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=OiD4nm/2;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.54, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-221a2d0c5dcso279986fac.0
        for <cip-dev@lists.cip-project.org>; Wed, 13 Mar 2024 16:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1710372885; x=1710977685; darn=lists.cip-project.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u2p+68MiKZWUVbVO7nrGVB/uZT9wO4EZjxLPT3c/CwU=;
        b=OiD4nm/2ouq0dr92t+FVp8pBWmsqTbchwI43dnpY9efWRXdsIic8te3LgTfhslfzzQ
         Mk6l83gqI1XopsYaUp+BJzL2kSFDzKhLmD8swLkg0eXwKP2LRS9PYIOQh0Tq5GwV7BqU
         Q3Qz6NkW1wys22zbBSXoWCXwwJGixWbsL+7vAt+OvTPLlFnLBZslxxAdDPHffbPvo3e8
         pdnA6jTb9xbAiTF5TG2fH4QqCpjar2IpwQ8IFjem3cPnqm+hwKXcxkOzhP2Ox+Rngtqz
         Do3FRA3CbLmebemjgE5dBOofU5lUXByt2feu/Gxhxp8g6C34W0Kc/9TotwtqjFFgvazt
         pW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710372885; x=1710977685;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2p+68MiKZWUVbVO7nrGVB/uZT9wO4EZjxLPT3c/CwU=;
        b=EcWoV9V9ZnofZ192o6V6H5PIGSP+QqO0uMJH/8B4xWxh1gFBuAAdEz6+Ru28+VZPee
         Bv4kI/sbXMMjdv/vOvAgeKuLONG3DDuS/bNo7WbAnSVFQRpjPc/gGsMtm/Bsp7vxG2Jv
         s7f99a+c5yPYCGnOHNaG+ORvtjcJOgoCNhqdkobcB3wIAt+5gNL8+lALtcTfMdBsyQ2v
         dsMeUvINEMyAuIVvAOAGgpo0kDFUbAF3D6sLtMOjxW+Z1df7oPwWCJ7T2dIlF/0+Pyf+
         FbtCxt5SvetsjhZrwa5olSbdc/NxAePLZe64vxf4ie8ZZZ0N0T/iATKqNYrQcKWNtM/0
         S+Fw==
X-Gm-Message-State: AOJu0YwpvzMNU/HX8HW2+l+CaDLfxqj5Mwhbc+IJwZy+UTPFsnAZ9rcZ
	LOnowjwh1cNP+hM7ZJW/IcJ0IzXXDl/u0A2+DD4Zn37xU0n64hpOQJffFUff2ZDQFANwCXf74JJ
	nFdxJGAqOINt9WbHaQBhqZZ/36IINogcC/L7pc3VBcKF2Q4VlkR8=
X-Google-Smtp-Source: AGHT+IFmbWCvBzSzAEfTculEKSX0MDQ4lRsdzBDRjHndxhkmmIQ8+tVN6uWGrAIqHO5wVsHfbMqBTUVbxFwgvrPpmIk=
X-Received: by 2002:a05:6870:f81a:b0:221:14e3:7f6e with SMTP id
 fr26-20020a056870f81a00b0022114e37f6emr279686oab.46.1710372885512; Wed, 13
 Mar 2024 16:34:45 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 14 Mar 2024 08:34:09 +0900
Message-ID: <CAODzB9pR7_5jsyfTTUnENOv5Y4GPcNSDnApcjyo3Xx8_-AjhiQ@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Mar 2024 23:34:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15294

Hi!

It's this week's CVE report.

This week reported 5 new CVEs and 8 updated CVEs.

* New CVEs

CVE-2023-28746: Register File Data Sampling (RFDS)

Announce: https://www.openwall.com/lists/oss-security/2024/03/12/13
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

This CVE was published by the Xen.org security team.

You can check which Intel processors are affected via Intel "Affected
Processors: Guidance for Security Issues on Intel=C2=AE Processors".
(https://www.intel.com/content/www/us/en/developer/topic-technology/softwar=
e-security-guidance/processors-affected-consolidated-product-cpu-model.html=
)

Fixed by commit e95df4ec0c0c9791941f112db699fae794b9862a,
4e42765d1be01111df0c0275bbaf1db1acef346e,
8076fcde016c9c0e0660543e67bff86cb48a7c9c, and
2a0180129d726a4b953232175857d442651b55a0 in master branch.


Fixed status
mainline: [e95df4ec0c0c9791941f112db699fae794b9862a,
4e42765d1be01111df0c0275bbaf1db1acef346e,
8076fcde016c9c0e0660543e67bff86cb48a7c9c,
2a0180129d726a4b953232175857d442651b55a0]

CVE-2024-2193: GhostRace: Speculative Race Conditions

Announce: https://www.openwall.com/lists/oss-security/2024/03/12/14
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

This CVE was published by the Xen.org security team.

According to the researcher's report
(https://www.vusec.net/projects/ghostrace/) it said that
"""
The Linux kernel developers have no immediate plans to implement our
proposed serialization of synchronization primitives due to
performance concerns. However, they confirmed the IPI storming issue
(CVE-2024-26602) and implemented an IPI rate-limiting feature
to address the CPU saturation issue by adding a synchronization mutex
on the path of sys_membarrier and avoiding its concurrent
execution on multiple cores. Unfortunately, as our experiments show
(Figure 4), hindering IPI storming primitives (i.e., 0 storming cores)
is insufficient to close the attack surface completely.
"""

Fixed status
Not fixed yet

CVE-2023-52608: firmware: arm_scmi: Check mailbox/SMT channel for consisten=
cy

Announce: https://lore.kernel.org/linux-cve-announce/20240313140155.1913910=
-3-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5c8a47a ("firmware: arm_scmi: Make scmi core
independent of the transport type") in v5.7-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc2.

Fixed status
mainline: [437a310b22244d4e0b78665c3042e5d1c0f45306]
stable/5.15: [614cc65032dcb0b64d23f5c5e338a8a04b12be5d]
stable/6.1: [7f95f6997f4fdd17abec3200cae45420a5489350]
stable/6.6: [9b5e1b93c83ee5fc9f5d7bd2d45b421bd87774a2]
stable/6.7: [12dc4217f16551d6dee9cbefc23fdb5659558cda]

CVE-2024-26629: nfsd: fix RELEASE_LOCKOWNER

Announce: https://lore.kernel.org/linux-cve-announce/20240313140155.1913910=
-4-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ce3c4ad ("NFSD: Fix possible sleep during
nfsd4_release_lockowner()") in v5.19-rc1.
This commit is backported to 4.4, 4.19, 5.4, 5.10, and 5.15. All
stable kernels are affected.
Fixed in v6.8-rc2.

Fixed status
mainline: [edcf9725150e42beeca42d085149f4c88fa97afd]
stable/6.1: [e4cf8941664cae2f89f0189c29fe2ce8c6be0d03]
stable/6.6: [b7d2eee1f53899b53f069bba3a59a419fc3d331b]
stable/6.7: [8f5b860de87039b007e84a28a5eefc888154e098]

CVE-2024-26630: mm: cachestat: fix folio read-after-free in cache walk

Announce: https://lore.kernel.org/linux-cve-announce/20240313155037.1968072=
-2-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cf264e1 ("cachestat: implement cachestat
syscall") in v6.5-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc7.

Fixed status
mainline: [3a75cb05d53f4a6823a32deb078de1366954a804]
stable/6.6: [ba60fdf75e89ea762bb617be578dc47f27655117]
stable/6.7: [fe7e008e0ce728252e4ec652cceebcc62211657c]


* Updated CVEs

CVE-2023-6356: NULL pointer dereference in nvmet_tcp_build_iovec

The mainline and all stable kernels are fixed. Linux 4.x is not affected.

Fixed status
mainline: [efa56305908ba20de2104f1b8508c6a7401833be]
stable/5.10: [f775f2621c2ac5cc3a0b3a64665dad4fb146e510]
stable/5.15: [4cb3cf7177ae3666be7fb27d4ad4d72a295fb02d]
stable/5.4: [ee5e7632e981673f42a50ade25e71e612e543d9d]
stable/6.1: [2871aa407007f6f531fae181ad252486e022df42]
stable/6.6: [24e05760186dc070d3db190ca61efdbce23afc88]
stable/6.7: [70154e8d015c9b4fb56c1a2ef1fc8b83d45c7f68]

CVE-2023-6536: NULL pointer dereference in __nvmet_req_complete

The mainline and all stable kernels are fixed. Linux 4.x is not affected.

Fixed status
mainline: [0849a5441358cef02586fb2d60f707c0db195628]
stable/5.10: [39669fae69f302961d89f38d969c6fcc1d07eb02]
stable/5.15: [0613a2fbdf8d32c3f8f1e62d704e92251a100795]
stable/5.4: [9638beb4e10ac116c6a4fc13315e9c3608055ac0]
stable/6.1: [83ccd15717ee2b6143df72df39685f0c832e3451]
stable/6.6: [2f00fd8d50a7d5eedc85e62efdc1a29213168998]
stable/6.7: [c32d355f507fa81cf23aaa4dd4150e696cb8ebaf]

CVE-2024-0841: hugetlbfs: Null pointer dereference in
hugetlbfs_fill_super function

The mainline and all stable kernels are fixed. Linux 4.x is not affected.

Fixed status
mainline: [79d72c68c58784a3e1cd2378669d51bfd0cb7498]
stable/5.10: [80d852299987a8037be145a94f41874228f1a773]
stable/5.15: [22850c9950a4e43a67299755d11498f3292d02ff]
stable/5.4: [1dde8ef4b7a749ae1bc73617c91775631d167557]
stable/6.1: [2e2c07104b4904aed1389a59b25799b95a85b5b9]
stable/6.6: [13c5a9fb07105557a1fa9efdb4f23d7ef30b7274]
stable/6.7: [ec78418801ef7b0c22cd6a30145ec480dd48db39]

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
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com


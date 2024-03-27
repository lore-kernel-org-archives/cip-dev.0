Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E4DC47DD9
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 23:11:34 +0000 (UTC)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
 by mx.groups.io with SMTP id smtpd.web11.2215.1711581092877953698
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 16:11:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=TwH3wYMh;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.42, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2228c4c5ac3so258507fac.0
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 16:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1711581092; x=1712185892; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RaLOLPBcXHpHBR4AVpDyFkvW0u1gf8yoOe1gtxWnuXg=;
        b=TwH3wYMhcqMaqC/9esuOOslsGNUYgzRE7l/VlrlPBaOl3PsmRS/BKsMKMFV0a7l+6c
         uzwSveZQp0n+0pFA856Y4bPb+eBdesFKA+DBkENHvNiOBs1LnBWouH0OPvPIU/8gogdJ
         lprc5JchUy0JMIp0iM3tL6ymvEXid/Zr6JY6v/Ud4pLE2Fe2aHXqjreuP9yZhYX4HHlW
         erYaR5hZFgU6IxhvT3oGf76tGmtkYSO1LkDUryMO1MNHBp/IaZ/FtTZc4RZ0v6mSK88u
         pl0wEJLi/9m7yndlGhvJoPS7X2MloqZpaZO4FgI71Af+pQ4lVn8i1ZAk0ODQIKrPCDOM
         +WEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711581092; x=1712185892;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RaLOLPBcXHpHBR4AVpDyFkvW0u1gf8yoOe1gtxWnuXg=;
        b=uWMXBGDN+JwzyqpWC7rg8ZNeLtaYBIMh/3d+Z2sSmyN9jUJS1LwuIxYcAPW56qGD+g
         NEUfG9cpNBYv8U19eckZH0XInfcCR20dbWyg5h47xMF3gMnFwy2nz+EiYRioLtMIbJ5t
         UQrK/XmOrhbJB1SjRtiIPs5dmpggPsFQ+diWj8zEYt4/xbGYnNy9zZIQChKvMy8X2cc3
         okejgsJlmbwFE73tN5P/w4Sea2J4+mF4En2ZdAqRmIK3B/KIx8LnXE8zv5+JtNwgN8lQ
         2PZsR36JKk8w1bingqvOf6vLV1pQhD/MHoVm9mh260UfFl28sZGOhlw2ZnK8I3o5AmO6
         1ecA==
X-Gm-Message-State: AOJu0YyU96xxWZZBbaSJcmg35ZmsdUyUGEVMSCdiZ66oVOFNtbCM0j5m
	YwYbjvIqONOkkiYdpoz2gvPkHO/KwU+2yUii2TQH15KjgOGRk5i5z4VjQkqHkhmSU0oIPh/aKqV
	S6ERSHc7iaAkhygcHBonXnao7oj3XBwh3d2hE0g//04uCybbx/kk=
X-Google-Smtp-Source: AGHT+IGRJXlu0+GoU6Xj1+I/tsQKPmJvTJTyNE941QrYggVg/ewYrHVdgtCMmQDlpn/RDYrTGlfeNIunQqvw8xEGzPo=
X-Received: by 2002:a05:6870:8191:b0:22a:1ce4:c0cf with SMTP id
 k17-20020a056870819100b0022a1ce4c0cfmr945730oae.55.1711581090844; Wed, 27 Mar
 2024 16:11:30 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 28 Mar 2024 08:10:54 +0900
Message-ID: <CAODzB9qT-x5mxUmWEZ_PigyqyJzqafK7Pn-8JqTzfmN-bj+pCg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 23:11:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15472

Hi!

It's this week's CVE report.

This week reported 60 new CVEs and 9 updated CVEs.

* New CVEs

CVE-2023-52620: netfilter: nf_tables: disallow timeout for anonymous sets

Announce: https://lore.kernel.org/linux-cve-announce/2024032147-CVE-2023-52620-11a9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.4.
It looks as if CVE-2023-52620 and CVE-2024-26642 both have the same root causes.
So, commit 761da29 ("netfilter: nf_tables: add set timeout API
support") may introduce this bug.
The commit 761da29 was merged in 4.1-rc1.

Fixed status
mainline: [e26d3009efda338f19016df4175f354a9bd0a4ab]
stable/5.15: [00b19ee0dcc1aef06294471ab489bae26d94524e]
stable/6.1: [b7be6c737a179a76901c872f6b4c1d00552d9a1b]

CVE-2024-26642: netfilter: nf_tables: disallow anonymous set with timeout flag

Announce: https://lore.kernel.org/linux-cve-announce/2024032150-CVE-2024-26642-3549@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 761da29 ("netfilter: nf_tables: add set timeout
API support") in v4.1-rc1.
Fixed in v6.8.

Fixed status
mainline: [16603605b667b70da974bea8216c93e7db043bf1]

CVE-2024-26643: netfilter: nf_tables: mark set as dead when unbinding
anonymous set with timeout

Announce: https://lore.kernel.org/linux-cve-announce/2024032150-CVE-2024-26643-4f9d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5f68718 ("netfilter: nf_tables: GC transaction
API to avoid race with control plane") in v6.5-rc6.
This commit was backported to 5.10, 5.15, 5.4, and 6.1. Linux 4.x is
not affected.
Fixed in v6.8.

Fixed status
mainline: [552705a3650bbf46a22b1adedc1b04181490fc36]

CVE-2021-47136: net: zero-initialize tc skb extension on allocation

Announce: https://lore.kernel.org/linux-cve-announce/2024032553-CVE-2021-47136-407d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 038ebb1 ("net/sched: act_ct: fix miss set mru for
ovs after defrag in act_ct") in v5.9-rc1.
Introduced by commit d29334c ("net/sched: act_api: fix miss set
post_ct for ovs after do conntrack in act_ct") in v5.12-rc5.
These commits are not backported to older stable kernels.
Fixed in v5.13-rc4.

Fixed status
mainline: [9453d45ecb6c2199d72e73c993e9d98677a2801b]
stable/5.10: [ac493452e937b8939eaf2d24cac51a4804b6c20e]

CVE-2021-47137: net: lantiq: fix memory corruption in RX ring

Announce: https://lore.kernel.org/linux-cve-announce/2024032556-CVE-2021-47137-7c8e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit fe1a564 ("net: lantiq: Add Lantiq / Intel VRX200
Ethernet driver ") in v4.20-rc1.
This commit is not backported to older stable kernels.
Fixed in v5.13-rc4.

Fixed status
mainline: [c7718ee96dbc2f9c5fc3b578abdf296dd44b9c20]
stable/5.10: [5ac72351655f8b033a2935646f53b7465c903418]
stable/5.4: [8bb1077448d43a871ed667520763e3b9f9b7975d]

CVE-2021-47138: cxgb4: avoid accessing registers when clearing filters

Announce: https://lore.kernel.org/linux-cve-announce/2024032557-CVE-2021-47138-9241@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b1a7936 ("cxgb4: Delete all hash and TCAM filters
before resource cleanup") in v5.2-rc1.
This commit is not backported to older stable kernels.
Fixed in v5.13-rc4.

Fixed status
mainline: [88c380df84fbd03f9b137c2b9d0a44b9f2f553b0]
stable/5.10: [02f03883fdb10ad7e66717c70ea163a8d27ae6e7]
stable/5.4: [0bf49b3c8d8b3a43ce09f1b2db70e5484d31fcdf]

CVE-2021-47139: net: hns3: put off calling register_netdev() until
client initialize complete

Announce: https://lore.kernel.org/linux-cve-announce/2024032557-CVE-2021-47139-994d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 08a1006 ("net: hns3: re-organize vector handle")
in v5.6-rc1.
This commit is not backported to older stable kernels.
Fixed in v5.13-rc4.

Fixed status
mainline: [a289a7e5c1d49b7d47df9913c1cc81fb48fab613]
stable/5.10: [a663c1e418a3b5b8e8edfad4bc8e7278c312d6fc]

CVE-2021-47140: iommu/amd: Clear DMA ops when switching domain

Announce: https://lore.kernel.org/linux-cve-announce/2024032557-CVE-2021-47140-5dd4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 08a27c1 ("iommu: Add support to change default
domain of an iommu group") in v5.11-rc1.
This commit is not backported to older stable kernels.
Fixed in v5.13-rc4.

Fixed status
mainline: [d6177a6556f853785867e2ec6d5b7f4906f0d809]

CVE-2021-47141: gve: Add NULL pointer checks when freeing irqs.

Announce: https://lore.kernel.org/linux-cve-announce/2024032557-CVE-2021-47141-ce47@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 893ce44 ("gve: Add basic driver framework for
Compute Engine Virtual NIC") in v5.3-rc1.
This commit is not backported to older stable kernels.
Fixed in v5.13-rc4.

Fixed status
mainline: [5218e919c8d06279884aa0baf76778a6817d5b93]
stable/5.10: [da21a35c00ff1a1794d4f166d3b3fa8db4d0f6fb]
stable/5.4: [821149ee88c206fa37e79c1868cc270518484876]

CVE-2021-47142: drm/amdgpu: Fix a use-after-free

Announce: https://lore.kernel.org/linux-cve-announce/2024032558-CVE-2021-47142-9319@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc3.
It looks as if it was introduced by commit d38ceaf ("drm/amdgpu: add
core driver (v4)") in 4.2-rc1.

Fixed status
cip/4.4: [0707c3fea8102d211631ba515ef2159707561b0d]
cip/4.4-rt: [0707c3fea8102d211631ba515ef2159707561b0d]
cip/4.4-st: [0707c3fea8102d211631ba515ef2159707561b0d]
mainline: [1e5c37385097c35911b0f8a0c67ffd10ee1af9a2]
stable/4.19: [a849e218556f932576c0fb1c5a88714b61709a17]
stable/4.4: [0707c3fea8102d211631ba515ef2159707561b0d]
stable/5.10: [f98cdf084405333ee2f5be548a91b2d168e49276]
stable/5.4: [7398c2aab4da960761ec182d04d6d5abbb4a226e]

CVE-2021-47143: net/smc: remove device from smcd_dev_list after failed
device_add()

Announce: https://lore.kernel.org/linux-cve-announce/2024032558-CVE-2021-47143-4f3c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c6ba7c9 ("net/smc: add base infrastructure for
SMC-D and ISM") in v4.19-rc1.
This commit is not backported to older stable kernels.
Fixed in v5.13-rc4. Linux 4.19 is not fixed yet.

Fixed status
mainline: [444d7be9532dcfda8e0385226c862fd7e986f607]
stable/5.10: [8b2cdc004d21a7255f219706dca64411108f7897]

CVE-2021-47144: drm/amd/amdgpu: fix refcount leak

Announce: https://lore.kernel.org/linux-cve-announce/2024032558-CVE-2021-47144-26d3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc3.
The obj variable in struct drm_framebuffer is not exist in Linux 4.4
so it may not affect to Linux 4.4.

Fixed status
mainline: [fa7e6abc75f3d491bc561734312d065dc9dc2a77]
stable/4.19: [599e5d61ace952b0bb9bd942b198bbd0cfded1d7]
stable/5.10: [9fdb8ed37a3a44f9c49372b69f87fd5f61cb3240]
stable/5.4: [dde2656e0bbb2ac7d83a7bd95a8d5c3c95bbc009]

CVE-2021-47145: btrfs: do not BUG_ON in link_to_fixup_dir

Announce: https://lore.kernel.org/linux-cve-announce/2024032558-CVE-2021-47145-e536@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc3.

Fixed status
cip/4.4: [76bfd8ac20bebeae599452a03dfc5724c0475dcf]
cip/4.4-rt: [76bfd8ac20bebeae599452a03dfc5724c0475dcf]
cip/4.4-st: [76bfd8ac20bebeae599452a03dfc5724c0475dcf]
mainline: [91df99a6eb50d5a1bc70fff4a09a0b7ae6aab96d]
stable/4.19: [6eccfb28f8dca70c9b1b3bb3194ca54cbe73a9fa]
stable/4.4: [76bfd8ac20bebeae599452a03dfc5724c0475dcf]
stable/5.10: [7e13db503918820e6333811cdc6f151dcea5090a]
stable/5.4: [0ed102453aa1cd12fefde8f6b60b9519b0b1f003]

CVE-2021-47146: mld: fix panic in mld_newpack()

Announce: https://lore.kernel.org/linux-cve-announce/2024032559-CVE-2021-47146-05d4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 72e09ad ("ipv6: avoid high order allocations") in
v2.6.35-rc3.
Fixed in v5.13-rc4.

Fixed status
cip/4.4: [0e35b7457b7b6e73ffeaaca1a577fdf1af0feca1]
cip/4.4-rt: [0e35b7457b7b6e73ffeaaca1a577fdf1af0feca1]
cip/4.4-st: [0e35b7457b7b6e73ffeaaca1a577fdf1af0feca1]
mainline: [020ef930b826d21c5446fdc9db80fd72a791bc21]
stable/4.19: [4b77ad9097067b31237eeeee0bf70f80849680a0]
stable/4.4: [0e35b7457b7b6e73ffeaaca1a577fdf1af0feca1]
stable/5.10: [beb39adb150f8f3b516ddf7c39835a9788704d23]
stable/5.4: [37d697759958d111439080bab7e14d2b0e7b39f5]

CVE-2021-47147: ptp: ocp: Fix a resource leak in an error handling path

Announce: https://lore.kernel.org/linux-cve-announce/2024032559-CVE-2021-47147-e4bc@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a7e1aba ("ptp: Add clock driver for the
OpenCompute TimeCard.") in v5.11-rc1.
This commit is not backported to the older stable kernel.
Fixed in v5.13-rc4.

Fixed status
mainline: [9c1bb37f8cad5e2ee1933fa1da9a6baa7876a8e4]

CVE-2021-47148: octeontx2-pf: fix a buffer overflow in otx2_set_rxfh_context()

Announce: https://lore.kernel.org/linux-cve-announce/2024032559-CVE-2021-47148-502f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 81a4362 ("octeontx2-pf: Add RSS multi group
support") in v5.12-rc1.
This commit is not backported to the older stable kernel.
Fixed in v5.13-rc4.

Fixed status
mainline: [e5cc361e21648b75f935f9571d4003aaee480214]

CVE-2021-47149: net: fujitsu: fix potential null-ptr-deref

Announce: https://lore.kernel.org/linux-cve-announce/2024032500-CVE-2021-47149-b998@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc3.

Fixed status
cip/4.4: [b92170e209f7746ed72eaac98f2c2f4b9af734e6]
cip/4.4-rt: [b92170e209f7746ed72eaac98f2c2f4b9af734e6]
cip/4.4-st: [b92170e209f7746ed72eaac98f2c2f4b9af734e6]
mainline: [52202be1cd996cde6e8969a128dc27ee45a7cb5e]
stable/4.19: [7883d3895d0fbb0ba9bff0f8665f99974b45210f]
stable/4.4: [b92170e209f7746ed72eaac98f2c2f4b9af734e6]
stable/5.10: [71723a796ab7881f491d663c6cd94b29be5fba50]
stable/5.4: [22049c3d40f08facd1867548716a484dad6b3251]

CVE-2021-47150: net: fec: fix the potential memory leak in fec_enet_init()

Announce: https://lore.kernel.org/linux-cve-announce/2024032500-CVE-2021-47150-f066@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 59d0f74 ("net: fec: init multi queue date
structure") in v3.18-rc1.
Linux 4.4 is not fixed yet.
Fixed in v5.13-rc4.

Fixed status
mainline: [619fee9eb13b5d29e4267cb394645608088c28a8]
stable/4.19: [15102886bc8f5f29daaadf2d925591d564c17e9f]
stable/5.10: [8ee7ef4a57a9e1228b6f345aaa70aa8951c7e9cd]
stable/5.4: [20255d41ac560397b6a07d8d87dcc5e2efc7672a]

CVE-2021-47151: interconnect: qcom: bcm-voter: add a missing of_node_put()

Announce: https://lore.kernel.org/linux-cve-announce/2024032500-CVE-2021-47151-2551@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 976daac ("interconnect: qcom: Consolidate
interconnect RPMh support") in v5.7-rc1.
This commit is not backported to older stable kernels.
Fixed in v5.13-rc4.

Fixed status
mainline: [a00593737f8bac2c9e97b696e7ff84a4446653e8]
stable/5.10: [4e3cea8035b6f1b9055e69cc6ebf9fa4e50763ae]

CVE-2021-47152: mptcp: fix data stream corruption

Announce: https://lore.kernel.org/linux-cve-announce/2024032500-CVE-2021-47152-a386@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 18b683b ("mptcp: queue data for mptcp level
retransmission") in v5.7-rc1.
This commit is not backported to older stable kernels.
Fixed in v5.13-rc4.

Fixed status
mainline: [29249eac5225429b898f278230a6ca2baa1ae154]
stable/5.10: [3267a061096efc91eda52c2a0c61ba76e46e4b34]

CVE-2021-47153: i2c: i801: Don't generate an interrupt on bus reset

Announce: https://lore.kernel.org/linux-cve-announce/2024032501-CVE-2021-47153-8c75@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 636752b ("i2c-i801: Enable IRQ for SMBus
transactions") in v3.6-rc1.
Fixed in v5.13-rc4.

Fixed status
cip/4.4: [f9469082126cebb7337db3992d143f5e4edfe629]
cip/4.4-rt: [f9469082126cebb7337db3992d143f5e4edfe629]
cip/4.4-st: [f9469082126cebb7337db3992d143f5e4edfe629]
mainline: [e4d8716c3dcec47f1557024add24e1f3c09eb24b]
stable/4.19: [c70e1ba2e7e65255a0ce004f531dd90dada97a8c]
stable/4.4: [f9469082126cebb7337db3992d143f5e4edfe629]
stable/5.10: [b523feb7e8e44652f92f3babb953a976e7ccbbef]
stable/5.4: [04cc05e3716ae31b17ecdab7bc55c8170def1b8b]

CVE-2021-47158: net: dsa: sja1105: add error handling in sja1105_setup()

Announce: https://lore.kernel.org/linux-cve-announce/2024032533-CVE-2021-47158-71e9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0a7bdbc ("net: dsa: sja1105: move devlink param
code to sja1105_devlink.c") in v5.10-rc1.
Introduced by commit 8aa9ebc ("net: dsa: Introduce driver for NXP
SJA1105 5-port L2 switch") in v5.2-rc1.
These commits are not backported to older stable kernels.
Fixed in v5.13-rc4.

Fixed status
mainline: [cec279a898a3b004411682f212215ccaea1cd0fb]
stable/5.10: [dd8609f203448ca6d58ae71461208b3f6b0329b0]

CVE-2021-47159: net: dsa: fix a crash if ->get_sset_count() fails

Announce: https://lore.kernel.org/linux-cve-announce/2024032533-CVE-2021-47159-9ac6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit badf3ad ("net: dsa: Provide CPU port statistics
to master netdev") in v4.7-rc1.
This commit is not backpoted to 4.4.
Fixed in v5.13-rc4.

Fixed status
mainline: [a269333fa5c0c8e53c92b5a28a6076a28cde3e83]
stable/4.19: [0f2cb08c57edefb0e7b5045e0e3e9980a3d3aa37]
stable/5.10: [caff86f85512b8e0d9830e8b8b0dfe13c68ce5b6]
stable/5.4: [ce5355f140a7987011388c7e30c4f8fbe180d3e8]

CVE-2021-47160: net: dsa: mt7530: fix VLAN traffic leaks

Announce: https://lore.kernel.org/linux-cve-announce/2024032534-CVE-2021-47160-8e53@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 83163f7 ("net: dsa: mediatek: add VLAN support
for MT7530") in v4.16-rc1.
This commit is not backpoted to 4.4.
Fixed in v5.13-rc4.

Fixed status
mainline: [474a2ddaa192777522a7499784f1d60691cd831a]
stable/4.19: [ae389812733b1b1e8e07fcc238e41db166b5c78d]
stable/5.10: [b91117b66fe875723a4e79ec6263526fffdb44d2]
stable/5.4: [4fe4e1f48ba119bdbc7c897c83b04ba0d08f5488]

CVE-2021-47161: spi: spi-fsl-dspi: Fix a resource leak in an error handling path

Announce: https://lore.kernel.org/linux-cve-announce/2024032534-CVE-2021-47161-65ce@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 90ba370 ("spi: spi-fsl-dspi: Add DMA support for
Vybrid") in v4.10-rc1.
This commit is not backpoted to 4.4.
Fixed in v5.13-rc4.

Fixed status
mainline: [680ec0549a055eb464dce6ffb4bfb736ef87236e]
stable/4.19: [00450ed03a17143e2433b461a656ef9cd17c2f1d]
stable/5.10: [fe6921e3b8451a537e01c031b8212366bb386e3e]
stable/5.4: [15d1cc4b4b585f9a2ce72c52cca004d5d735bdf1]

CVE-2021-47162: tipc: skb_linearize the head skb when reassembling msgs

Announce: https://lore.kernel.org/linux-cve-announce/2024032534-CVE-2021-47162-01da@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 45c8b7b ("tipc: allow non-linear first fragment
buffer") in v4.3.
Fixed in v5.13-rc4.

Fixed status
cip/4.4: [b2c8d28c34b3070407cb1741f9ba3f15d0284b8b]
cip/4.4-rt: [b2c8d28c34b3070407cb1741f9ba3f15d0284b8b]
cip/4.4-st: [b2c8d28c34b3070407cb1741f9ba3f15d0284b8b]
mainline: [b7df21cf1b79ab7026f545e7bf837bd5750ac026]
stable/4.19: [4b1761898861117c97066aea6c58f68a7787f0bf]
stable/4.4: [b2c8d28c34b3070407cb1741f9ba3f15d0284b8b]
stable/5.10: [6da24cfc83ba4f97ea44fc7ae9999a006101755c]
stable/5.4: [64d17ec9f1ded042c4b188d15734f33486ed9966]

CVE-2021-47163: tipc: wait and exit until all work queues are done

Announce: https://lore.kernel.org/linux-cve-announce/2024032534-CVE-2021-47163-3ab9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d0f9193 ("tipc: add ip/udp media type") in v4.1-rc1.
Fixed in v5.13-rc4.
Backporting this fix to 4.19 and 4.4 ware failed.
4.19: https://lore.kernel.org/stable/162238534421917@kroah.com/
4.4: https://lore.kernel.org/stable/162238339320326@kroah.com/

Fixed status
mainline: [04c26faa51d1e2fe71cf13c45791f5174c37f986]
stable/5.10: [5195ec5e365a2a9331bfeb585b613a6e94f98dba]
stable/5.4: [d1f76dfadaf8f47ed1753f97dbcbd41c16215ffa]

CVE-2021-47164: net/mlx5e: Fix null deref accessing lag dev

Announce: https://lore.kernel.org/linux-cve-announce/2024032535-CVE-2021-47164-0581@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7e51891 ("net/mlx5e: Use netdev events to set/del
egress acl forward-to-vport rule") in v5.8-rc1.
This commit is not backported to older stable kernels.
Fixed in v5.13-rc4.

Fixed status
mainline: [83026d83186bc48bb41ee4872f339b83f31dfc55]
stable/5.10: [2e4b0b95a489259f9d35a3db17023061f8f3d587]

CVE-2021-47165: drm/meson: fix shutdown crash when component not probed

Announce: https://lore.kernel.org/linux-cve-announce/2024032535-CVE-2021-47165-95d9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit fa0c16c ("drm: meson_drv add shutdown function")
in v5.12-rc3.
This commit was backported to 4.19, 5.10, and 5.4. Linux 4.4 is not affected.
Fixed in v5.13-rc4.

Fixed status
mainline: [7cfc4ea78fc103ea51ecbacd9236abb5b1c490d2]
stable/4.19: [e256a0eb43e17209e347409a80805b1659398d68]
stable/5.10: [d66083c0d6f5125a4d982aa177dd71ab4cd3d212]
stable/5.4: [4ce2bf20b4a6e307e114847d60b2bf40a6a1fac0]

CVE-2021-47166: NFS: Don't corrupt the value of pg_bytes_written in
nfs_do_recoalesce()

Announce: https://lore.kernel.org/linux-cve-announce/2024032535-CVE-2021-47166-6ab7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a7d42dd ("nfs: add mirroring support to pgio
layer") in v4.0-rc1.
Fixed in v5.13-rc4.

Fixed status
cip/4.4: [e8b8418ce14ae66ee55179901edd12191ab06a9e]
cip/4.4-rt: [e8b8418ce14ae66ee55179901edd12191ab06a9e]
cip/4.4-st: [e8b8418ce14ae66ee55179901edd12191ab06a9e]
mainline: [0d0ea309357dea0d85a82815f02157eb7fcda39f]
stable/4.19: [40f139a6d50c232c0d1fd1c5e65a845c62db0ede]
stable/4.4: [e8b8418ce14ae66ee55179901edd12191ab06a9e]
stable/5.10: [7087db95c0a06ab201b8ebfac6a7ec1e34257997]
stable/5.4: [785917316b25685c9b3a2a88f933139f2de75e33]

CVE-2021-47167: NFS: Fix an Oopsable condition in __nfs_pageio_add_request()

Announce: https://lore.kernel.org/linux-cve-announce/2024032535-CVE-2021-47167-c68c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a7d42dd ("nfs: add mirroring support to pgio
layer") in v4.0-rc1.
Fixed in v5.13-rc4.
Backporting this fix to 4.19
(https://lore.kernel.org/stable/162238258072199@kroah.com/) and 4.4
(https://lore.kernel.org/stable/162238257828195@kroah.com/)
were failed.

Fixed status
mainline: [56517ab958b7c11030e626250c00b9b1a24b41eb]
stable/5.10: [ee21cd3aa8548e0cbc8c67a80b62113aedd2d101]
stable/5.4: [1fc5f4eb9d31268ac3ce152d74ad5501ad24ca3e]

CVE-2021-47168: NFS: fix an incorrect limit in filelayout_decode_layout()

Announce: https://lore.kernel.org/linux-cve-announce/2024032536-CVE-2021-47168-2916@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 16b374c ("NFSv4.1: pnfs: filelayout: add driver's
LAYOUTGET and GETDEVICEINFO infrastructure") in v2.6.37-rc1.
Fixed in v5.13-rc4.

Fixed status
cip/4.4: [9d280ab53df1d4a1043bd7a9e7c6a2f9cfbfe040]
cip/4.4-rt: [9d280ab53df1d4a1043bd7a9e7c6a2f9cfbfe040]
cip/4.4-st: [9d280ab53df1d4a1043bd7a9e7c6a2f9cfbfe040]
mainline: [769b01ea68b6c49dc3cde6adf7e53927dacbd3a8]
stable/4.19: [945ebef997227ca8c20bad7f8a8358c8ee57a84a]
stable/4.4: [9d280ab53df1d4a1043bd7a9e7c6a2f9cfbfe040]
stable/5.10: [9b367fe770b1b80d7bf64ed0d177544a44405f6e]
stable/5.4: [e411df81cd862ef3d5b878120b2a2fef0ca9cdb1]

CVE-2021-47169: serial: rp2: use 'request_firmware' instead of
'request_firmware_nowait'

Announce: https://lore.kernel.org/linux-cve-announce/2024032536-CVE-2021-47169-4fd2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc4.

Fixed status
cip/4.4: [1e04d5d5fe5e76af68f834e1941fcbfa439653be]
cip/4.4-rt: [1e04d5d5fe5e76af68f834e1941fcbfa439653be]
cip/4.4-st: [1e04d5d5fe5e76af68f834e1941fcbfa439653be]
mainline: [016002848c82eeb5d460489ce392d91fe18c475c]
stable/4.19: [35265552c7fe9553c75e324c80f45e28ff14eb6e]
stable/4.4: [1e04d5d5fe5e76af68f834e1941fcbfa439653be]
stable/5.10: [6a931ceb0b9401fe18d0c500e08164bf9cc7be4b]
stable/5.4: [915452f40e2f495e187276c4407a4f567ec2307e]

CVE-2021-47170: USB: usbfs: Don't WARN about excessively large memory
allocations

Announce: https://lore.kernel.org/linux-cve-announce/2024032536-CVE-2021-47170-ee51@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v5.13-rc4.
It looks as if Linux 4.4 may be affected.

Fixed status
mainline: [4f2629ea67e7225c3fd292c7fe4f5b3c9d6392de]
stable/4.19: [2ab21d6e1411999b5fb43434f421f00bf50002eb]
stable/5.10: [8d83f109e920d2776991fa142bb904d985dca2ed]
stable/5.4: [2c835fede13e03f2743a333e4370b5ed2db91e83]

CVE-2021-47171: net: usb: fix memory leak in smsc75xx_bind

Announce: https://lore.kernel.org/linux-cve-announce/2024032536-CVE-2021-47171-f223@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d0cad87 ("smsc75xx: SMSC LAN75xx USB gigabit
ethernet adapter driver") in v2.6.34-rc2.
Fixed in v5.13-rc4.

Fixed status
cip/4.4: [200dbfcad8011e50c3cec269ed7b980836eeb1fa]
cip/4.4-rt: [200dbfcad8011e50c3cec269ed7b980836eeb1fa]
cip/4.4-st: [200dbfcad8011e50c3cec269ed7b980836eeb1fa]
mainline: [46a8b29c6306d8bbfd92b614ef65a47c900d8e70]
stable/4.19: [9e6a3eccb28779710cbbafc4f4258d92509c6d07]
stable/4.4: [200dbfcad8011e50c3cec269ed7b980836eeb1fa]
stable/5.10: [635ac38b36255d3cfb8312cf7c471334f4d537e0]
stable/5.4: [b95fb96e6339e34694dd578fb6bde3575b01af17]

CVE-2021-47172: iio: adc: ad7124: Fix potential overflow due to non
sequential channel numbers

Announce: https://lore.kernel.org/linux-cve-announce/2024032537-CVE-2021-47172-4990@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d7857e4 ("iio: adc: ad7124: Fix DT channel
configuration") in v5.5-rc7.
This commit was backported to 5.4. Linux 4.x is not affected.
Fixed in v5.13-rc4.

Fixed status
mainline: [f2a772c51206b0c3f262e4f6a3812c89a650191b]
stable/5.10: [f70122825076117787b91e7f219e21c09f11a5b9]
stable/5.4: [f49149964d2423fb618fb6b755bb1eaa431cca2c]

CVE-2021-47173: misc/uss720: fix memory leak in uss720_probe

Announce: https://lore.kernel.org/linux-cve-announce/2024032537-CVE-2021-47173-12cc@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0f36163 ("[PATCH] usb: fix uss720 schedule with
interrupts off") in v2.6.20.16.
Fixed in v5.13-rc4.

Fixed status
cip/4.4: [5f46b2410db2c8f26b8bb91b40deebf4ec184391]
cip/4.4-rt: [5f46b2410db2c8f26b8bb91b40deebf4ec184391]
cip/4.4-st: [5f46b2410db2c8f26b8bb91b40deebf4ec184391]
mainline: [dcb4b8ad6a448532d8b681b5d1a7036210b622de]
stable/4.19: [386918878ce4cd676e4607233866e03c9399a46a]
stable/4.4: [5f46b2410db2c8f26b8bb91b40deebf4ec184391]
stable/5.10: [5394ae9d8c7961dd93807fdf1b12a1dde96b0a55]
stable/5.4: [36b5ff1db1a4ef4fdbc2bae364344279f033ad88]

CVE-2021-47174: netfilter: nft_set_pipapo_avx2: Add irq_fpu_usable()
check, fallback to non-AVX2 version

Announce: https://lore.kernel.org/linux-cve-announce/2024032537-CVE-2021-47174-a330@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7400b06 ("nft_set_pipapo: Introduce AVX2-based
lookup implementation") in v5.7-rc1.
This commit is not backported to older stable kernels.
Fixed in v5.13-rc4.

Fixed status
mainline: [f0b3d338064e1fe7531f0d2977e35f3b334abfb4]
stable/5.10: [b1f45a26bd322525c14edd9504f6d46dfad679a4]

CVE-2021-47175: net/sched: fq_pie: fix OOB access in the traffic path

Announce: https://lore.kernel.org/linux-cve-announce/2024032537-CVE-2021-47175-5b85@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ec97ecf ("net: sched: add Flow Queue PIE packet
scheduler") in v5.6-rc1.
This commit is not backported to older stable kernels.
Fixed in v5.13-rc4.

Fixed status
mainline: [e70f7a11876a1a788ceadf75e9e5f7af2c868680]
stable/5.10: [e6294c06e7c62ffdd5bf3df696d3a4fcbb753d3c]

CVE-2021-47176: s390/dasd: add missing discipline function

Announce: https://lore.kernel.org/linux-cve-announce/2024032538-CVE-2021-47176-015a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b729493 ("s390/dasd: Prepare for additional path
event handling") in v5.11-rc1.
This commit was backported to 5.10 and 5.4. Linux 4.4 is not affected.
Fixed in v5.13-rc4.

Fixed status
mainline: [c0c8a8397fa8a74d04915f4d3d28cb4a5d401427]
stable/5.10: [aa8579bc084673c651204f7cd0d6308a47dffc16]
stable/5.4: [6a16810068e70959bc1df686424aa35ce05578f1]

CVE-2021-47177: iommu/vt-d: Fix sysfs leak in alloc_iommu()

Announce: https://lore.kernel.org/linux-cve-announce/2024032538-CVE-2021-47177-4d4a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 39ab955 ("iommu: Add sysfs bindings for struct
iommu_device") in v4.11-rc1.
This commit is not backported to older stable kernels.
Fixed in v5.13-rc4.

Fixed status
mainline: [0ee74d5a48635c848c20f152d0d488bf84641304]
stable/4.19: [2ec5e9bb6b0560c90d315559c28a99723c80b996]
stable/5.10: [f01134321d04f47c718bb41b799bcdeda27873d2]
stable/5.4: [044bbe8b92ab4e542de7f6c93c88ea65cccd8e29]

CVE-2021-47178: scsi: target: core: Avoid smp_processor_id() in preemptible code

Announce: https://lore.kernel.org/linux-cve-announce/2024032538-CVE-2021-47178-6167@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1526d9f ("scsi: target: Make state_list per CPU")
in v5.11-rc1.
This commit was backported to 5.10. Linux 5.4 and 4.x are not affected.
Fixed in v5.13-rc4.

Fixed status
mainline: [70ca3c57ff914113f681e657634f7fbfa68e1ad1]
stable/5.10: [a222d2794c53f8165de20aa91b39e35e4b72bce9]

CVE-2021-47179: NFSv4: Fix a NULL pointer dereference in
pnfs_mark_matching_lsegs_return()

Announce: https://lore.kernel.org/linux-cve-announce/2024032538-CVE-2021-47179-d9c2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit de144ff ("NFSv4: Don't discard segments marked
for return in _pnfs_return_layout()") in 5.13-rc1.
This commit was backported to 4.19, 5.10, and 5.4. Linux 4.4 is not affected.
Fixed in 5.13-rc4.

Fixed status
mainline: [a421d218603ffa822a0b8045055c03eae394a7eb]
stable/4.19: [39785761feadf261bc5101372b0b0bbaf6a94494]
stable/5.10: [f9890652185b72b8de9ebeb4406037640b6e1b53]
stable/5.4: [aba3c7795f51717ae316f3566442dee7cc3eeccb]

CVE-2021-47180: NFC: nci: fix memory leak in nci_allocate_device

Announce: https://lore.kernel.org/linux-cve-announce/2024032539-CVE-2021-47180-5b80@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 11f54f2 ("NFC: nci: Add HCI over NCI protocol
support") in v4.0-rc1.
Fixed in v5.13-rc4.

Fixed status
cip/4.4: [448a1cb12977f52142e6feb12022c59662d88dc1]
cip/4.4-rt: [448a1cb12977f52142e6feb12022c59662d88dc1]
cip/4.4-st: [448a1cb12977f52142e6feb12022c59662d88dc1]
mainline: [e0652f8bb44d6294eeeac06d703185357f25d50b]
stable/4.19: [0365701bc44e078682ee1224866a71897495c7ef]
stable/4.4: [448a1cb12977f52142e6feb12022c59662d88dc1]
stable/5.10: [b34cb7ac32cc8e5471dc773180ea9ae676b1a745]
stable/5.4: [af2a4426baf71163c0c354580ae98c7888a9aba7]

CVE-2023-52621: bpf: Check rcu_read_lock_trace_held() before calling
bpf map helpers

Announce: https://lore.kernel.org/linux-cve-announce/20240326171931.1354035-4-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.

The sleepable bpf program feature was introduced by commit 1e6c62a88
("bpf: Introduce sleepable BPF programs") in 5.10-rc1.
So, Linux 5.4 and 4.x are not affected.

Fixed status
mainline: [169410eba271afc9f0fb476d996795aa26770c6d]
stable/6.1: [d6d6fe4bb105595118f12abeed4a7bdd450853f3]
stable/6.6: [483cb92334cd7f1d5387dccc0ab5d595d27a669d]
stable/6.7: [c7f1b6146f4a46d727c0d046284c28b6882c6304]

CVE-2023-52622: ext4: avoid online resizing failures due to oversized flex bg

Announce: https://lore.kernel.org/linux-cve-announce/20240326171931.1354035-5-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
Linux 4.4 seems to be affected.

Fixed status
mainline: [5d1935ac02ca5aee364a449a35e2977ea84509b0]
stable/4.19: [cd1f93ca97a9136989f3bd2bf90696732a2ed644]
stable/5.10: [cfbbb3199e71b63fc26cee0ebff327c47128a1e8]
stable/5.15: [d76c8d7ffe163c6bf2f1ef680b0539c2b3902b90]
stable/5.4: [b183fe8702e78bba3dcef8e7193cab6898abee07]
stable/6.1: [6d2cbf517dcabc093159cf138ad5712c9c7fa954]
stable/6.6: [8b1413dbfe49646eda2c00c0f1144ee9d3368e0c]
stable/6.7: [dc3e0f55bec4410f3d74352c4a7c79f518088ee2]

CVE-2023-52623: SUNRPC: Fix a suspicious RCU usage warning

Announce: https://lore.kernel.org/linux-cve-announce/20240326171931.1354035-6-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
The rpc_xprt_switch_has_addr() was introduced by commit 39e5d2df
("SUNRPC search xprt switch for sockaddr") in 4.9-rc1.
Linux 4.4 is not affected.

Fixed status
mainline: [31b62908693c90d4d07db597e685d9f25a120073]
stable/4.19: [fece80a2a6718ed58487ce397285bb1b83a3e54e]
stable/5.10: [c430e6bb43955c6bf573665fcebf31694925b9f7]
stable/5.15: [f8cf4dabbdcb8bef85335b0ed7ad5b25fd82ff56]
stable/5.4: [7a96d85bf196c170dcf1b47a82e9bb97cca69aa6]
stable/6.1: [e8ca3e73301e23e8c0ac0ce2e6bac4545cd776e0]
stable/6.6: [69c7eeb4f622c2a28da965f970f982db171f3dc6]
stable/6.7: [8f860c8407470baff2beb9982ad6b172c94f1d0a]

CVE-2023-52624: drm/amd/display: Wake DMCUB before executing GPINT commands

Announce: https://lore.kernel.org/linux-cve-announce/20240326175007.1388794-10-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
Backporting this fix to 6.1 failed
(https://lore.kernel.org/stable/2024012756-pauper-underdog-470b@gregkh/).
The dc_dmub_srv.h and dc_dmub_srv.c were introduced by commit
3a1627b073 ("drm/amd/display: Add DMUB support to DC") in 5.6-rc1.
The dmub_psr.c was introduced by commit 4c1a1335d ("drm/amd/display:
Driverside changes to support PSR in DMCUB") in 5.6-rc1.
Therefore, it looks as if 5.4 and 4.x are not affected.

Fixed status
mainline: [e5ffd1263dd5b44929c676171802e7b6af483f21]
stable/6.7: [2ef98c6d753a744e333b7e34b9cf687040fba57d]

CVE-2023-52625: drm/amd/display: Refactor DMCUB enter/exit idle interface

Announce: https://lore.kernel.org/linux-cve-announce/20240326175007.1388794-11-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
Backporting this fix to 6.1 was failed
(https://lore.kernel.org/stable/2024012743-shortcake-unsure-ebfd@gregkh/).

The dc_dmub_srv.h and dc_dmub_srv.c were introduced by commit
3a1627b073 ("drm/amd/display: Add DMUB support to DC") in 5.6-rc1.
The dcn35_hwseq.c was introduced by commit 6f8b7565 ("drm/amd/display:
Add DCN35 HWSEQ").
So that it looks as if at least prior to Linux 5.6 kernels are not affected.

Fixed status
mainline: [8e57c06bf4b0f51a4d6958e15e1a99c9520d00fa]
stable/6.7: [820c3870c491946a78950cdf961bf40e28c1025f]

CVE-2023-52626: net/mlx5e: Fix operation precedence bug in port
timestamping napi_poll context

Announce: https://lore.kernel.org/linux-cve-announce/20240326175007.1388794-12-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 92214be ("net/mlx5e: Update doorbell for port
timestamping CQ before the software counter") in v6.7-rc2.
This commit was backported to 6.6. Prior to Linux 6.6 kernels are not affected.
Fixed in v6.8-rc2.

Fixed status
mainline: [3876638b2c7ebb2c9d181de1191db0de8cac143a]
stable/6.6: [40e0d0746390c5b0c31144f4f1688d72f3f8d790]
stable/6.7: [33cdeae8c6fb58cc445f859b67c014dc9f60b4e0]

CVE-2023-52627: iio: adc: ad7091r: Allow users to configure device events

Announce: https://lore.kernel.org/linux-cve-announce/20240326175007.1388794-13-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ca69300 ("iio: adc: Add support for AD7091R5
ADC") in v5.6-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc1.

Fixed status
mainline: [020e71c7ffc25dfe29ed9be6c2d39af7bd7f661f]
stable/5.10: [1eba6f7ffa295a0eec098c107043074be7cc4ec5]
stable/5.15: [49f322ce1f265935f15e5512da69a399f27a5091]
stable/6.1: [137568aa540a9f587c48ff7d4c51cdba08cfe9a4]
stable/6.6: [89c4e63324e208a23098f7fb15c00487cecbfed2]
stable/6.7: [55aca2ce91a63740278502066beaddbd841af9c6]

CVE-2024-26644: btrfs: don't abort filesystem when attempting to
snapshot deleted subvolume

Announce: https://lore.kernel.org/linux-cve-announce/20240326151722.1258576-3-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc2.
Backporting this fix to 5.4
(https://lore.kernel.org/stable/2024012747-marshland-overcoat-1e01@gregkh/)
and
4.19 (https://lore.kernel.org/stable/2024012750-shore-gradually-d4bb@gregkh/)
were failed.
It looks like Linux 4.4 is affected.

Fixed status
mainline: [7081929ab2572920e94d70be3d332e5c9f97095a]
stable/5.10: [2bdf872bcfe629a6202ffd6641615a8ed00e8464]
stable/5.15: [0877497dc97834728e1b528ddf1e1c484292c29c]
stable/6.1: [6e6bca99e8d88d989a7cde4c064abea552d5219b]
stable/6.6: [ec794a7528199e1be6d47bec03f4755aa75df256]
stable/6.7: [d8680b722f0ff6d7a01ddacc1844e0d52354d6ff]

CVE-2024-26645: tracing: Ensure visibility when inserting an element
into tracing_map

Announce: https://lore.kernel.org/linux-cve-announce/20240326151722.1258576-4-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c193707 ("tracing: Remove code which merges
duplicates") in v4.17-rc1.
Linux 4.4 is not affected.
Fixed in v6.8-rc2.

Fixed status
mainline: [2b44760609e9eaafc9d234a6883d042fc21132a7]
stable/4.19: [5022b331c041e8c54b9a6a3251579bd1e8c0fc0b]
stable/5.10: [ef70dfa0b1e5084f32635156c9a5c795352ad860]
stable/5.15: [aef1cb00856ccfd614467cfb50b791278992e177]
stable/5.4: [dad9b28f675ed99b4dec261db2a397efeb80b74c]
stable/6.1: [f4f7e696db0274ff560482cc52eddbf0551d4b7a]
stable/6.6: [a1eebe76e187dbe11ca299f8dbb6e45d5b1889e7]
stable/6.7: [bf4aeff7da85c3becd39fb73bac94122331c30fb]

CVE-2024-26646: thermal: intel: hfi: Add syscore callbacks for system-wide PM

Announce: https://lore.kernel.org/linux-cve-announce/20240326175007.1388794-14-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
This driver was introduced by commit 1cb19cabeb ("thermal: intel: hfi:
Minimally initialize the Hardware Feedback Interface") in 5.18-rc1.
So, prior to Linux 5.18 kernels are not affected.

Fixed status
mainline: [97566d09fd02d2ab329774bb89a2cdf2267e86d9]
stable/6.1: [28f010dc50df0f7987c04112114fcfa7e0803566]
stable/6.6: [019ccc66d56a696a4dfee3bfa2f04d0a7c3d89ee]
stable/6.7: [c9d6d63b6c03afaa6f185df249af693a7939577c]

CVE-2024-26647: drm/amd/display: Fix late derefrence 'dsc' check in
'link_set_dsc_pps_packet()'

Announce: https://lore.kernel.org/linux-cve-announce/20240326175007.1388794-15-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.

Fixed status
mainline: [3bb9b1f958c3d986ed90a3ff009f1e77e9553207]
stable/6.6: [6aa5ede6665122f4c8abce3c6eba06b49e54d25c]
stable/6.7: [cf656fc7276e5b3709a81bc9d9639459be2b2647]

CVE-2024-26648: drm/amd/display: Fix variable deferencing before NULL
check in edp_setup_replay()

Announce: https://lore.kernel.org/linux-cve-announce/20240326175007.1388794-16-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc1.
The link_dpms.c was introduced by commit 54618888 ("drm/amd/display:
break down dc_link.c") in 6.3-rc1.

Fixed status
mainline: [7073934f5d73f8b53308963cee36f0d389ea857c]
stable/6.6: [22ae604aea14756954e1c00ae653e34d2afd2935]
stable/6.7: [c02d257c654191ecda1dc1af6875d527e85310e7]

CVE-2024-26649: drm/amdgpu: Fix the null pointer when load rlc firmware

Announce: https://lore.kernel.org/linux-cve-announce/20240326175007.1388794-17-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3da9b71 ("drm/amd: Use `amdgpu_ucode_*` helpers
for GFX10") in v6.3-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc1.

Fixed status
mainline: [bc03c02cc1991a066b23e69bbcc0f66e8f1f7453]
stable/6.6: [8b5bacce2d13dbe648f0bfd3f738ecce8db4978c]
stable/6.7: [d3887448486caeef9687fb5dfebd4ff91e0f25aa]

CVE-2024-26650: platform/x86: p2sb: Allow p2sb_bar() calls during PCI
device probe

Announce: https://lore.kernel.org/linux-cve-announce/20240326175007.1388794-18-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9745fb0 ("platform/x86/intel: Add Primary to
Sideband (P2SB) bridge support") in v6.0-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8-rc2.

Fixed status
mainline: [5913320eb0b3ec88158cfcb0fa5e996bf4ef681b]
stable/6.1: [2841631a03652f32b595c563695d0461072e0de4]
stable/6.6: [847e1eb30e269a094da046c08273abe3f3361cf2]
stable/6.7: [d281ac9a987c553d93211b90fd4fe97d8eca32cd]

CVE-2024-26651: sr9800: Add check for usbnet_get_endpoints

Announce: https://lore.kernel.org/linux-cve-announce/2024032721-CVE-2024-26651-34b3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 19a38d8 ("USB2NET : SR9800 : One chip USB2.0
USB2NET SR9800 Device Driver Support") in v3.14-rc3.
Fixed in v6.9-rc1.

Fixed status
mainline: [07161b2416f740a2cb87faa5566873f401440a61]
stable/4.19: [424eba06ed405d557077339edb19ce0ebe39e7c7]
stable/5.10: [6b4a39acafaf0186ed8e97c16e0aa6fca0e52009]
stable/5.15: [276873ae26c8d75b00747c1dadb9561d6ef20581]
stable/5.4: [8a8b6a24684bc278036c3f159f7b3a31ad89546a]
stable/6.1: [9c402819620a842cbfe39359a3ddfaac9adc8384]
stable/6.6: [e39a3a14eafcf17f03c037290b78c8f483529028]
stable/6.7: [efba65777f98457773c5b65e3135c6132d3b015f]

CVE-2024-26652: net: pds_core: Fix possible double free in error handling path

Announce: https://lore.kernel.org/linux-cve-announce/2024032713-CVE-2024-26652-f95c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4569cce ("pds_core: add auxiliary_bus devices")
in v6.4-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8.

Fixed status
mainline: [ba18deddd6d502da71fd6b6143c53042271b82bd]
stable/6.6: [995f802abff209514ac2ee03b96224237646cec3]
stable/6.7: [ffda0e962f270b3ec937660afd15b685263232d3]

* Updated CVEs

CVE-2023-52447: bpf: Defer the free of inner map when necessary

stable 5.10 and 5.15 were fixed.

Fixed status
mainline: [876673364161da50eed6b472d746ef88242b2368]
stable/5.10: [90c445799fd1dc214d7c6279c144e33a35e29ef2]
stable/5.15: [37d98fb9c3144c0fddf7f6e99aece9927ac8dce6]
stable/6.1: [62fca83303d608ad4fec3f7428c8685680bb01b0]
stable/6.6: [f91cd728b10c51f6d4a39957ccd56d1e802fc8ee]
stable/6.7: [bfd9b20c4862f41d4590fde11d70a5eeae53dcc5]

CVE-2023-6270: AoE: improper reference count leads to use-after-free
vulnerability

This bug was introduced commit 7562f876c ("[NET]: Rework dev_base via
list_head (v3)") in 2.6.22-rc1.
All stable kernels were fixed.

Fixed status
mainline: [f98364e926626c678fb4b9004b75cacf92ff0662]
stable/4.19: [ad80c34944d7175fa1f5c7a55066020002921a99]
stable/5.10: [faf0b4c5e00bb680e8e43ac936df24d3f48c8e65]
stable/5.15: [7dd09fa80b0765ce68bfae92f4e2f395ccf0fba4]
stable/5.4: [1a54aa506b3b2f31496731039e49778f54eee881]
stable/6.1: [74ca3ef68d2f449bc848c0a814cefc487bf755fa]
stable/6.6: [eb48680b0255a9e8a9bdc93d6a55b11c31262e62]
stable/6.7: [079cba4f4e307c69878226fdf5228c20aa1c969c]
stable/6.8: [a16fbb80064634b254520a46395e36b87ca4731e]

CVE-2024-22099: NULL pointer dereference bug and buffer overflow
vulnerabilities was found in the bluetooth subsystem

All stable kernels were fixed.

Fixed status
mainline: [2535b848fa0f42ddff3e5255cf5e742c9b77bb26]
stable/4.19: [369f419c097e82407dd429a202cde9a73d3ae29b]
stable/5.10: [81d7d920a22fd58ef9aedb1bd0a68ee32bd23e96]
stable/5.15: [8d1753973f598531baaa2c1033cf7f7b5bb004b0]
stable/5.4: [5f369efd9d963c1f711a06c9b8baf9f5ce616d85]
stable/6.1: [567c0411dc3b424fc7bd1e6109726d7ba32d4f73]
stable/6.6: [3ead59bafad05f2967ae2438c0528d53244cfde5]
stable/6.7: [5f9fe302dd3a9bbc50f4888464c1773f45166bfd]

CVE-2023-7042: wifi: ath10k: fix NULL pointer dereference in
ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev()

stable 4.19, 5.x, and 6.x were fixed.

Fixed status
mainline: [ad25ee36f00172f7d53242dc77c69fff7ced0755]
stable/4.19: [0cd3b0a1dc987697cba1fe93c784365aa1f8a230]
stable/5.10: [e1dc7aa814a95aeeb1b2c05be2b62af8423b15cc]
stable/5.15: [4c4e592266b6eec748ce90e82bd9cbc9838f3633]
stable/5.4: [88a9dffaec779504ab3680d33cf677741c029420]
stable/6.1: [90f089d77e38db1c48629f111f3c8c336be1bc38]
stable/6.6: [10a342fa2fe4c4dd22f2c8fe917d3b1929582076]
stable/6.7: [db755cf93f5895bbac491d27a8e2fe04c5f9ae4a]
stable/6.8: [835c5d37f4b0ba99e9ec285ffa645bc532714191]

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


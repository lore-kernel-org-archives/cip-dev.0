Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3105C38145
	for <webhook@archiver.kernel.org>; Wed,  7 Sep 2022 23:07:55 +0000 (UTC)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com
 [209.85.160.42])
 by mx.groups.io with SMTP id smtpd.web08.2438.1662592060337621663
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Sep 2022 16:07:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=XoqAexsA;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.42,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-1278a61bd57so21286001fac.7
        for <cip-dev@lists.cip-project.org>;
 Wed, 07 Sep 2022 16:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=GHXpz+tjjA+TiVtwtat9DPOa2lLdmdedIo+GTp0+A7U=;
        b=XoqAexsAG5YH8KIwZMa+6VWh21BrpAC9uq198L9XC2egYetH4uXG6ZpZRe2Kt9F/pI
         h6gDLNEsqUVr6hwvYGsdl3jBvh2Lv0pAJcljN+uysdEzhM28WpLn6o44+Dz62GNMkuRc
         Ca86bu6vImR0GNn0YM3qGNaca3IL7j/xwVOIqkLqwrKAJQ1W4bqzl8Qb6tB/gYPp/W6d
         A7liNQ6cx0HI2A3AoCgMw0dNF+pstawINIJDVKkslxRNGp0uZenVeWI/fmioUB3Q3LU0
         3RWSbNbEC3WMzrEW0+Hkgz7dsvxS7wr7TFuRXp95uFPoxsXtO4Deih/uDgCfUDlxh/oZ
         uhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=GHXpz+tjjA+TiVtwtat9DPOa2lLdmdedIo+GTp0+A7U=;
        b=QaF+TY7uR8OSlUSR0qrwajQh28W4prp3+PbJnzU+Vo9P1+BJgf0d4bRa3fhxtZOIHn
         23RTBNJc4oMe/aZw6CNoR0pnUpE0W5QoJqki3YDxyWmTUwmh24dy16XdwfA7MsMxu0zU
         XL4/lfEA6uQ8CAP5TzgJM+tFiobUMEgBjvDo9qmRm1WwzK1dUeKDGtuR4ZA/59Yviy1E
         WwonsyGFwX2u9KQ6lPJLGPWO2Kw5Zkylq9lNedKrwV7gIFjAqDMIyIOSIn4T6gybiFVz
         NCYbprE785ZM4n+e6L1QrUM1fGdRh09Q/SndzFE5XtHlsLt0ahABOv9jff8ceQCPraxU
         Kgdw==
X-Gm-Message-State: ACgBeo1ve1uXM1D8H2udk+6bwi40dXNUfGCGKYKZ5T1nmKo7EYRxmLXB
	rzcFcbKrQ8nQr3N5jryT03WueqySDVHLWCnMzH2VjjKMYaALIA==
X-Google-Smtp-Source: 
 AA6agR48e7d7WU7gm5ZxntQNFzuO+KXFUcKi60/dBiIpocSUaQI6LmkGlEettEMjq4vzMwiso/ov16cpVZ8ZFRSeaa4=
X-Received: by 2002:a05:6870:e409:b0:127:d330:c941 with SMTP id
 n9-20020a056870e40900b00127d330c941mr392383oag.280.1662592059222; Wed, 07 Sep
 2022 16:07:39 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 8 Sep 2022 08:07:03 +0900
Message-ID: 
 <CAODzB9p4Rns_2VSk6HMn8RDZpswp1GRCNxnP7o2MWPDnZjereA@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Sep 2022 23:07:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9472

Hi !

It's this week's CVE report.

This week reported 3 new CVEs and 2 updated CVEs.

* New CVEs

CVE-2022-3078: lack of check after calling vzalloc() and lack of free
after allocation in vidtv driver

CVSS v3 score is 5.5 MEDIUM.

The vidtv driver was introduced by commit f90cf60 ("media: vidtv: add
a bridge driver") was merged in 5.10-rc1.

There is a lack of check after calling vzalloc() and lack of free
after allocation in drivers/media/test-drivers/vidtv/vidtv_s302m.c.
Kernel 4.4, 4.9, 4.14, 4.19, and 5.4 are not affected.

No CIP member enables CONFIG_DVB_VIDTV.

Fixed status
mainline: [e6a21a14106d9718aa4f8e115b1e474888eeba44]
stable/5.10: [663e7a72871f89f7a10cc8d7b2f17f27c64e071d]
stable/5.15: [9dd2fd7a1f84c947561af29424c5ddcecfcf2cbe]

CVE-2022-39190: 'netfilter: nf_tables: disallow binding to already bound chain

CVSS v3 score is not assigned.

There is a lack of input value check in nft_verdict_init of the file
net/netfilter/nf_tables_api.c which will cause denial of service
vulnerability. This vulnerability was introduced by commit d0e2c7d
("netfilter: nf_tables: add NFT_CHAIN_BINDING") which was merged in
5.9-rc1.

Kernel 4.4, 4.9, 4.14, 4.19, and 5.4 are not affected.

Fixed status
mainline: [e02f0d3970404bfea385b6edb86f2d936db0ea2b]
stable/5.10: [c08a104a8bce832f6e7a4e8d9ac091777b9982ea]
stable/5.15: [51f192ae71c3431aa69a988449ee2fd288e57648]
stable/5.19: [fdca693fcf26c11596e7aa1e540af2b4a5288c76]

CVE-2022-39842: video: fbdev: pxa3xx-gcu: Fix integer overflow in
pxa3xx_gcu_write

CVSS v3 score is not assigned.

There is an integer overflow bug in pxa3xx_gcu_write() in PXA3XX_GCU driver.

All stable kernels(include 4.4) are affected by this issue.
No CIP member enables CONFIG_PXA3XX_GCU.

Fixed status
mainline: [a09d2d00af53b43c6f11e6ab3cb58443c2cac8a7]

* Updated CVEs

CVE-2022-39188: unmap_mapping_range() race with munmap() on VM_PFNMAP
mappings leads to stale TLB entry

4.14, 4.19, 4.9, 5.10, 5.15, and 5.4 were fixed.

Fixed status
mainline: [b67fbebd4cf980aecbcc750e1462128bffe8ae15]
stable/4.14: [b8a54a2a45feacbc96065e5d6b9a1cbee2aa1e9d]
stable/4.19: [c3b1e88f14e7f442e2ddcbec94527eec84ac0ca3]
stable/4.9: [390f33a95419f7fa1254ba6b6feeabde480732f9]
stable/5.10: [895428ee124ad70b9763259308354877b725c31d]
stable/5.15: [3ffb97fce282df03723995f5eed6a559d008078e]
stable/5.4: [c9c5501e815132530d741ec9fdd22657f91656bc]

CVE-2022-3028: af_key: Do not call xfrm_probe_algs in parallel

4.14, 4.19, 4.9, and 5.4 were fixed.

Fixed status
mainline: [ba953a9d89a00c078b85f4b190bc1dde66fe16b5]
stable/4.14: [f1b1b63e307478e93548f59e18bd844744b396d3]
stable/4.19: [7dbfc8f25f22fe2a64dd808266e00c8d2661ebdd]
stable/4.9: [e580d3201ed222c4752ced7e629ad96bc0340713]
stable/5.10: [c5c4d4c9806dadac7bc82f9c29ef4e1b78894775]
stable/5.15: [103bd319c0fc90f1cb013c3a508615e6df8af823]
stable/5.19: [6901885656c029c976498290b52f67f2c251e6a0]
stable/5.4: [8ee27a4f0f1ad36d430221842767880df6494147]

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


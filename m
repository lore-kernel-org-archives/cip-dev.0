Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE498C3F6B0
	for <webhook@archiver.kernel.org>; Thu,  4 Aug 2022 05:00:52 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web10.1419.1659589243934260856
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 22:00:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=IJaG8D2R;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id f192so8902951pfa.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 22:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=fo1KEYDlPQg6dWOULlByJ9hZfDg1CG7Hya056RETsFk=;
        b=IJaG8D2RXEqyDQeF0KnOy8NOaR+HmlYQl4se3xeMNwKZF7KWCiNOJBbuf8HjkYGx1O
         UAgaeJLpb7gMnBuZABcg8zw3i/gJ64RXfF1z+jQa6k+DlBmultegezwfcGzHt1c2yKO7
         1QfjmSpNIQPWQtlnkgtlJV7E8dJEmOGP6mRr4CdJPU1ffmFq7CZ+i9cRsViHajGFqcfm
         NKadX2ycMVqTr68ZvsmXQpFVI7Xjp5fhmo4GOhpzsG4h/1wUIS9dY/+aDqq0tcxRXcJs
         wX9qdvm7dm737PYku+OhyVYRGCuw6hqG+gCso28N5olJR8gRUpsBHIdNLsP8/Z+V2Yg+
         SP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=fo1KEYDlPQg6dWOULlByJ9hZfDg1CG7Hya056RETsFk=;
        b=HIeBs5x9BJIKjby/Jx4T69g1bgqBy3TyVJdhZCUWEBZNeO/7NmNeSwTCoG217FUUnr
         GvKaJH2YG5yGpF81CNR0qWnLeDIqLpXkjRrro7L2YECXSkNNA6cvzU+oLrYGC7RcCWo2
         mVaLX4YhqxFi8kZs2t5zHZz4BINO00woYyiMKszbsmVeQyQJmw6jAWmr2KuDE9ZY5XIb
         /gfpXIdol7nfkkJDo0+Wehp6r9M46DBMLKhrgrVX11azh1d8+MRR6ej2eI9VeQsSmXqA
         paYwOrHT2hgx72NmYINjKxwkR/p7HAGRWzID4y/oGGu/f73ltKcGiuqi94Z48q5+nRAx
         76dg==
X-Gm-Message-State: ACgBeo1mZ3Dbhfxa50YDk//avUNcPR0Z5E9/nAXp0Wmz517SbsY/iqAt
	ohDEib2hUZaY5uewnfdFQusXyjzI1I+yK3bbwks=
X-Google-Smtp-Source: 
 AA6agR5A2iaCdZOGK2BGUbGTvAd3eQvNFiJNepwU5UO19b80/u9G3wgimd8z+cCUWY/AV6X8iM84WA==
X-Received: by 2002:a63:87c3:0:b0:41b:e478:11e9 with SMTP id
 i186-20020a6387c3000000b0041be47811e9mr216058pge.326.1659589243254;
        Wed, 03 Aug 2022 22:00:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 z9-20020a62d109000000b0052d46b43006sm8603390pfg.156.2022.08.03.22.00.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 22:00:42 -0700 (PDT)
Message-ID: <62eb527a.620a0220.c0df.ee8a@mx.google.com>
Date: Wed, 03 Aug 2022 22:00:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-37-ge3a52725ce96e
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 24 runs,
 1 regressions (v5.10.131-cip13-37-ge3a52725ce96e)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Aug 2022 05:00:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9109

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 24 runs, 1 regress=
ions (v5.10.131-cip13-37-ge3a52725ce96e)

Regressions Summary
-------------------

platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre | gcc-10   | defconfig | 1    =
      =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.131-cip13-37-ge3a52725ce96e/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.131-cip13-37-ge3a52725ce96e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e3a52725ce96e4794cc31e31ccd20914f40f19a3 =



Test Regressions
---------------- =



platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre | gcc-10   | defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/62eb4b837678a6d10adaf056

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-37-ge3a52725ce96e/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-nfs-meson-gxm-khadas-vim2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-37-ge3a52725ce96e/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-nfs-meson-gxm-khadas-vim2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62eb4b837678a6d10=
adaf057
        failing since 0 day (last pass: v5.10.100-cip2-484-gede5006fb276, f=
irst fail: v5.10.131-cip13-431-g420b8f43ddc46) =

 =20


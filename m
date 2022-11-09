Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2BEC43219
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 22:37:27 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web09.319.1668033438803746717
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 09 Nov 2022 14:37:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ddNSX4dh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id m6so121575pfb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 09 Nov 2022 14:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sG3gqFMvx9RsLBH4PsbfahUgSjXHTEQ4ptAXYxH+61o=;
        b=ddNSX4dhkjQnxEaukWMQyk0TDz6oTJ7oXuxbqapL/pJ9gseLSDMEPpyZ8HA1zxNka1
         VSQ9DJAiYr7/cZRIcH8Nw3RfuqmuAQcOmxy1UEMj0BnRnlDLBIPq9EzpdA9bctjxrPZc
         pdi/qNM7SOOgF3WZKFhagaV1JGcj16Q0NbzLkZ3+mXDKCqul6la1MTHv7gpGMoFAWja0
         3zx08WNlZSY+KRjcagATsnaBPCPD5fEHOV7o46uvk3qUB2XhQYh7hZWjIUvvLJUXorht
         9o8+MoPgi+2mlsifDAd+qu9CcbViTD/lzriFR14X6MXL8kAEaTMIt6Hx51YkfnKz8O7w
         hkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sG3gqFMvx9RsLBH4PsbfahUgSjXHTEQ4ptAXYxH+61o=;
        b=4M90lN7+zoyTRSR6oxN55TC7cJLDWTm8v4PvLTMcGmuBJhd4vm4zWVx5FEJ6PD4tCy
         2r/FeKbZ7b47r0IWfsnF7njfrKdRbzqEvAt5V3o9jGlubTlqONC9OxZdYsKQg33ekCHC
         KWYqJTrzRWHAwZG1UKKVV2rY4m04e1NfOqESU4YSYCViaZvE3QQwT4xBr7ICWs/B4ckv
         6b5+1voxMaOdV580TgAyq2V2HAhg01nHESGy6XoyhgjVWXAzjuPtCPLKMAtIPuxnUYgj
         NmayGM2mTaYHvezsKv14tZm/qgBb0Zk/X2EHA7CMsYytUP1wsUIysqYgZh6hGRMHCSGJ
         p0dg==
X-Gm-Message-State: ACrzQf3TaKxSYy3VkLCUczwEasWzIrP1u3RB3s2Pv9GdxMN5WOR933nH
	uHJ3veCMpntBHJicVqbg8pCwvU6+F8sXccIKH18=
X-Google-Smtp-Source: AMsMyM46F1xNNzUpNoyvWoI+DZe/qI92Mi5rhJ0ORWg1PZNzWYoEe1F7DTWihQheYPZCl7Rm+2nWzg==
X-Received: by 2002:a05:6a00:ac6:b0:530:3197:48b6 with SMTP id c6-20020a056a000ac600b00530319748b6mr63095578pfl.80.1668033440758;
        Wed, 09 Nov 2022 14:37:20 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id cv6-20020a17090afd0600b00213a9e1f863sm1741768pjb.4.2022.11.09.14.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:37:20 -0800 (PST)
Message-ID: <636c2ba0.170a0220.ab60e.339d@mx.google.com>
Date: Wed, 09 Nov 2022 14:37:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.153-cip19-3-gc76f4e7e5c71
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip ltp-mm: 6 runs,
 1 regressions (v5.10.153-cip19-3-gc76f4e7e5c71)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 22:37:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9980

cip/linux-5.10.y-cip ltp-mm: 6 runs, 1 regressions (v5.10.153-cip19-3-gc76f=
4e7e5c71)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.153-cip19-3-gc76f4e7e5c71/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.153-cip19-3-gc76f4e7e5c71
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c76f4e7e5c7160107c9b5d8ec188f61fe326cec3

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  b79157c8375cfdd2abfc59f63afe8ea09eaa8c5d =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/636c2572a80f9e02cfe7db5e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19-3-gc76f4e7e5c71/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-=
mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19-3-gc76f4e7e5c71/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-=
mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/636c2572a80f9e02cfe7db5f
        failing since 302 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20


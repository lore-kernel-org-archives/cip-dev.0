Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E0EC43334
	for <webhook@archiver.kernel.org>; Thu,  7 Jul 2022 06:37:42 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.web08.2646.1657175860161655135
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 06 Jul 2022 23:37:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=3gWa3FDU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.177,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f177.google.com with SMTP id 145so16735007pga.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 06 Jul 2022 23:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=p63yABG31CyM3l93Ssnh8edsOlTch2oPusTVdUseJMU=;
        b=3gWa3FDUjJ/bhSMNOaLgVpx6cvLFqMy2kGKdpRq6EtuhruYOR0zEd8sOkjHEAhRhSI
         qcVynuUnbFg/QLNhq2gswGNOl/mFqx7aJ085rqpYsn1VkBRosTGFxZO/TXBIoro0qHXL
         XbvIrjM+jqVhdeRnBqS+K+YUMTY1T/YmVScE+flx9E4RMiuvTLIYwmAqasDHQVVzxApD
         W575XEIPQqlNg8vVs0yShPRpJeX+pnR0dRG0GMz3ZBjM0YnPmhWPkBXA4QbZ9WgaU11v
         v87JjQ2Q/X9tM725QcFgLhpb9jRhA4WJM/UryVRlX3DiSHGwzbJ3mhRobfb85dK588Wx
         JbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=p63yABG31CyM3l93Ssnh8edsOlTch2oPusTVdUseJMU=;
        b=QhQKpqAA/xHadUpmkwLBeBcEuMCuMXWIE4N/PhpPgkj+hliqzHEQ78S5qz0Hun37zN
         pX4Y7Cd1Y3ypHSfBSj/pkfmDvUW1G+TnwVUUs5td7AQDUbFrOzW6h0B33VlPruno3AXC
         jfhCFUC5zAVsgpV+kxy3bd+zgER/ebVP174OJ/K7AGBcOsjv5q2wQW4G7wQWpTWf/lkH
         ubEZy1WEWihctNNnFpAOKBcKiD5E/sPunfr3EaihYKQp65H0FrKxHrYmVf2w/8XSLRWq
         fbVo4f28JW0IyLKH0yhF+XL6FY7khG7VqleQPO5KK8XVYuAozPoPtGHC7iOHXXqG4ilw
         UJRQ==
X-Gm-Message-State: AJIora/Ibw/LF85cKUToRBbhLwNrBF3g4XwornZcri/4YI6bcOTJplXs
	XMp+GlthLavFrsMQlwt9I6Llh2OEvCQwSqxm
X-Google-Smtp-Source: 
 AGRyM1uMt2YDl4o29PeiwT8+IwoD0//zlOi2gEO9kJUH0Jxk9b5l5E0dUdOOBIBctvsV+ECggZcr+Q==
X-Received: by 2002:a17:90b:4c49:b0:1ec:e8a2:b5f0 with SMTP id
 np9-20020a17090b4c4900b001ece8a2b5f0mr3182286pjb.21.1657175859505;
        Wed, 06 Jul 2022 23:37:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 r22-20020a63fc56000000b0041154ac0f1csm17863336pgk.44.2022.07.06.23.37.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 23:37:39 -0700 (PDT)
Message-ID: <62c67f33.1c69fb81.36050.adb2@mx.google.com>
Date: Wed, 06 Jul 2022 23:37:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.126-cip11-116-gef362fbbff528
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 45 runs,
 3 regressions (v5.10.126-cip11-116-gef362fbbff528)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Jul 2022 06:37:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8707

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 45 runs, 3 regress=
ions (v5.10.126-cip11-116-gef362fbbff528)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

r8a77950-salvator-x          | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.126-cip11-116-gef362fbbff528/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.126-cip11-116-gef362fbbff528
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ef362fbbff528b6dc0695b488cfc8cde20b404e4 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62c67512baeb0c8966a39ca8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62c67512baeb0c896=
6a39ca9
        failing since 9 days (last pass: v5.10.121-cip9-272-g3fb28d4c623b, =
first fail: v5.10.121-cip9-287-ge9094c8446fc) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a77950-salvator-x          | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62c67722ed9b758673a39bf8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-nfs-r8a77950-salvator-x.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-nfs-r8a77950-salvator-x.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62c67722ed9b75867=
3a39bf9
        new failure (last pass: v5.10.126-cip11-1-gc5218dc69ff1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c6763c6e96385084a39bee

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/62c6763d6e96385084a39c10
        failing since 120 days (last pass: v5.10.100-cip2-319-gcbff87047566=
, first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-07-07T05:59:09.680198  [   38.110074] cdn-dp fec00000.dp: Direct f=
irmware load for rockchip/dptx.bin failed with error -2
    2022-07-07T05:59:09.690091  [   38.120101] cdn-dp fec00000.dp: Falling =
back to sysfs fallback for: rockchip/dptx.bin
    2022-07-07T05:59:09.808962  /lava-6771633/1/../bin/lava-test-case
    2022-07-07T05:59:09.837681  [   38.268917] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20


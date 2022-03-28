X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web10.567.1648504686847718184
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 28 Mar 2022 14:58:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=xZlC4EZB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.179, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f179.google.com with SMTP id z128so13213569pgz.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 28 Mar 2022 14:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=SSnzZH1seoAvWNTnu6MfQZtWbV2iGhYR/9NCfH9HbcA=;
        b=xZlC4EZBkKfQF8eVctla1gQmqyW9yAX/FOjsvFXnX1+F63zRl/EXl+T0RRkZgYR5rG
         uFlNSpXtU7yKfijj7Qyml1S6SVmej6dVfeFH6KHwKnvajpx5yQqJd8QrsaagXGeVMejV
         E752PF/EIWAmMsCE80zj67Q3DtVpo2f3EtYAFzZx/7i5eIhKH1Pj/bgu4CzLNfqeXsoz
         7v1JHZJRRGaig5KPlFXzYOikVQSdkz3D6O9twnZxXRaZVXa7bP0ZuVA3N7sNK12fYUnS
         Y0J4+ZPEhJDhckIL7uFtPNRPSXCyD9gn0LBxJ+HsTFwF7juTdXjfYRJptyzmdQbcHdXj
         +z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=SSnzZH1seoAvWNTnu6MfQZtWbV2iGhYR/9NCfH9HbcA=;
        b=WiLuk/YV3ASegjKepYB9GN2biDWbroc24u1AbQsoI6tZWghduO/R31rzluS3h+9BqQ
         2vhsjYb2sbUBXsZOQ6Y5tQZsDXu63thTrbh1HJparzrKlDAAont2k3rC/nyyqxNvJfLh
         R74ZS5kmUSAImhgSHkwpf1GGfMpg6h4raNsEqJkytXVSvX0BfYL9DjovLDo06FECyjQg
         IrwkjkR83NCrdjonNYlSwJ0cjEVEPLKJROOwMRfhr3DmCb7oApVfIv9rCzbcOPPGX+2M
         P6TVDZ+u1Qzlgw0zvz0g8KvusJFXy4Y7uMRv/1z6IyrOo5KYheUXPKGn4CCnFKhZEdLA
         6/uA==
X-Gm-Message-State: AOAM531l5tsfc1AdHLfljS2H6R7x39ySMvrnY7ZDEl+qgm5KiT6WsRhw
	k1WVdctX8IxQlBlvdaLXx0xC4NWu+adJJquVyjw=
X-Google-Smtp-Source: ABdhPJwJSapRhDvzqvZZCB9gBxR9df/6dxMFuBWf2N6uFg+jy6V70yxUHEgQNkchrpvtwccwhzlVTA==
X-Received: by 2002:a63:3fcc:0:b0:398:ae5:6905 with SMTP id m195-20020a633fcc000000b003980ae56905mr11284636pga.463.1648504686030;
        Mon, 28 Mar 2022 14:58:06 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ev16-20020a17090aead000b001c7c2919453sm428386pjb.33.2022.03.28.14.58.05
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 14:58:05 -0700 (PDT)
Message-ID: <62422f6d.1c69fb81.2e4fe.1b3e@mx.google.com>
Date: Mon, 28 Mar 2022 14:58:05 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.233-cip69-142-g40322771bdc1
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 11 runs, 1 regressions (v4.19.233-cip69-142-g40322771bdc1) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 11 runs, 1 regress=
ions (v4.19.233-cip69-142-g40322771bdc1)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.233-cip69-142-g40322771bdc1/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.233-cip69-142-g40322771bdc1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      40322771bdc1d32499c228464c031d6a0779e3ca =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/624227fd4583399becae06cc

  Results:     82 PASS, 6 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-142-g40322771bdc1/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-142-g40322771bdc1/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220311.1/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/624227fe4583399becae06ee
        failing since 15 days (last pass: v4.19.229-cip67-111-g5c3c0b39cf3b=
, first fail: v4.19.231-cip68-123-g92e3e7f3d4df)

    2022-03-28T21:26:09.390094  <8>[   37.011168] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-03-28T21:26:10.414680  /lava-5964150/1/../bin/lava-test-case   =

 =20


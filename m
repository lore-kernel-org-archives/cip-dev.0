Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DE5C25B08
	for <webhook@archiver.kernel.org>; Fri,  5 Aug 2022 02:54:16 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web10.2826.1659668047498315845
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 04 Aug 2022 19:54:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=MEiXvmgh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id p8so1461002plq.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 04 Aug 2022 19:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=jgmRdIJUY9gKI0tX4y2Ch9FjtWAcwtM33nt8VJkEfZk=;
        b=MEiXvmghT+oanGXQdM274Tq7Os/rCvXvIGyqfgEel2GIeyG+zp3FiYFYmRWweiiMu3
         0jBp5bybFPpMEMC8BTmYfVv0hwwUdzIw98bay+kVzAi88MQwXt9ZPW/PmBuLrv+LS/e2
         cjk8pYgEQ84S853WDesXmJLweP3KN0eHbkO0P7UmmdKGkSYTIkTET+2O14iyetxLqwCr
         xZBYeFkCXiuCI6NPvVhzHjStDzZdE3cN92B32oUqwN310ipF0TwiG0F3zzRIbZxz8VE8
         UpphhFtV9iq3605XQrGG6v16+ATDjIpznFXg/7umgBPQmY8P/aLholpNZSBarY6KSmwx
         lZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=jgmRdIJUY9gKI0tX4y2Ch9FjtWAcwtM33nt8VJkEfZk=;
        b=adaPmBLVNxASlGv28ionDsDJARbYpajnClbFz7sq7H8IAk7BXxQnzQTIDr/T58HFJS
         EqCIAt0W2SOonblYdGlTsridhKxh6hJvHlok9aDAGKUM1c8chMkZfnXJJFrpOjKZUoxF
         ZQMl3JFjPC8N9R2Onn5BF0xHBBIDo3rUQBv23MrSvvmNr3+pPIipB1jpqlSL8sol6I4u
         mcyxWsvd626/Wxxj2ZQghKe1pkC2u0oiEbgUuEaRJhblm4sFUzLPytIxxi9KFbN1rVjD
         d4l87pbC+bW9U6nERsFIF3YmAmjgPKylQg5RZOJU5H1S5ck2Bb22T6tBMQ6OPnT99hx0
         eMhA==
X-Gm-Message-State: ACgBeo02zWmQjaVA657t4XmRdXy4Kk00k4mxGZM3o+e4R8BDrQgPR9JF
	vdMLqqPOjHpa5rdG7yGd013NduIbsSuo8+gAAIg=
X-Google-Smtp-Source: 
 AA6agR6QHzUc6K+KItOO6FDKn3Jci91r0RYooCV0vZDw3IenDvNs0EXaBUZ7GcGU+3OQccVAiKMNdQ==
X-Received: by 2002:a17:902:ec8f:b0:16e:d8d8:c2ef with SMTP id
 x15-20020a170902ec8f00b0016ed8d8c2efmr4827498plg.62.1659668046538;
        Thu, 04 Aug 2022 19:54:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 u8-20020a170903124800b0016f15140e55sm1639289plh.189.2022.08.04.19.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 19:54:06 -0700 (PDT)
Message-ID: <62ec864e.170a0220.4b816.31bf@mx.google.com>
Date: Thu, 04 Aug 2022 19:54:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-37-ge3a52725ce96
Subject: cip/linux-5.10.y-cip baseline-nfs: 44 runs,
 3 regressions (v5.10.131-cip13-37-ge3a52725ce96)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Aug 2022 02:54:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9127

cip/linux-5.10.y-cip baseline-nfs: 44 runs, 3 regressions (v5.10.131-cip13-=
37-ge3a52725ce96)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
meson-gxm-khadas-vim2    | arm64 | lab-baylibre  | gcc-10   | defconfig    =
              | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.131-cip13-37-ge3a52725ce96/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-37-ge3a52725ce96
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e3a52725ce96e4794cc31e31ccd20914f40f19a3 =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
meson-gxm-khadas-vim2    | arm64 | lab-baylibre  | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/62ec7a37e12e4819d4daf056

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-37-ge3a52725ce96/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-me=
son-gxm-khadas-vim2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-37-ge3a52725ce96/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-me=
son-gxm-khadas-vim2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62ec7a37e12e4819d=
4daf057
        failing since 227 days (last pass: v5.10.8-8301-g3d6168cb89f6, firs=
t fail: v5.10.83-cip1-31-gdcbef6602957) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/62ec7eb0f83d6d6006daf05f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-37-ge3a52725ce96/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a=
1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-37-ge3a52725ce96/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a=
1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62ec7eb0f83d6d600=
6daf060
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ec7cf0622f51045cdaf05a

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-37-ge3a52725ce96/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-37-ge3a52725ce96/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/62ec7cf0622f51045cdaf07c
        failing since 128 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2022-08-05T02:13:51.633939  <8>[   37.686716] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-08-05T02:13:52.685624  /lava-6976372/1/../bin/lava-test-case
    2022-08-05T02:13:52.725328  <8>[   38.779714] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20


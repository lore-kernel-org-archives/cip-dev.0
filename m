Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DC0EE49B2
	for <webhook@archiver.kernel.org>; Wed, 23 Aug 2023 10:42:56 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web11.8496.1692787373260084316
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 23 Aug 2023 03:42:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=HcTnZp9C;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-68a41035828so2478742b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 23 Aug 2023 03:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692787372; x=1693392172;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9s8i9BDsQlPrNwydZcG3Tn6o/GmBOEBrZiPvOI3rHCM=;
        b=HcTnZp9C/wglb6qwt/tTKhAO7xXEHtORt1v4N8wKnbOWvGF8ySKx/LekbXUbxBlbix
         g18gzrlXt2RSv1wlyyTspYlfmXnBBBXltYM3FnQS7sVOEmw1gQQ0ZUsiqQLx/UqT/N+G
         v9NrJgPqZD0Ra2Mew8lDYP0uY0z7QRBlyCwsVrcn9Loh9y8Usw1zn0Mx1A6VzqVo1ePZ
         qRhTkAvfzYH1cYhRRA/P395cb01um8iiskDVPM8LqxWv4kXg9hk4Pp2ECcK9w5DrlGjY
         fATVtVkY4l6uT0oF2BDyQD6vpquf73KnxPJPQU7dmpY/Mj6MRPAVZVaFeDGDUfMNJsmV
         2Xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692787372; x=1693392172;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9s8i9BDsQlPrNwydZcG3Tn6o/GmBOEBrZiPvOI3rHCM=;
        b=Voc1UIsh/kRSxcBqj/hn56RqTSzLDl5P8Q69U2RnehuBVU4b4TDifvmJy4xKtrwbH3
         FX+lZMokg1mOgTs8AeUuxOyvj5iObd1SYafUqHli8mLhMreGG5ncsX3qEPcD8fV8WJCt
         JtGLcc2537F2mCEWxrBjm9kmVMbefV7rB6sfR3+tAX669PWOspVAj/LnYpFlWgKRXabe
         pCq25pa8G4jrbZzvo0uE6L41gR+8WdqKeLAvbRMBMnfVRNfhN5gTWT7KONAH7LACOWBy
         /7ZC2GXMlt3MzZdNXZvktepH5TriY1J3VbswoBWKVDOKv8qfZd+o3+4jBhplI5mnlGPo
         b3tQ==
X-Gm-Message-State: AOJu0YzkfR8AJUuq3u4ZxdPTPBtd2/3oDMIp5Yr7HaZqBLzbovgGqsDr
	PNl/v1JwW62OizuJRjGr/8+JvO3d3/f/z6YqEFg=
X-Google-Smtp-Source: AGHT+IGQHZQmTONcCs3JKbANAj/0Qz50wonYgiH6vrSKfEe95Z75UxSk1KxUDLdtjhEn5OtOl8YpOg==
X-Received: by 2002:a05:6a00:1a88:b0:67a:9208:87a with SMTP id e8-20020a056a001a8800b0067a9208087amr10678661pfv.23.1692787371969;
        Wed, 23 Aug 2023 03:42:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fm25-20020a056a002f9900b00689f3d73639sm5454561pfb.65.2023.08.23.03.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 03:42:51 -0700 (PDT)
Message-ID: <64e5e2ab.050a0220.5f8f1.a54c@mx.google.com>
Date: Wed, 23 Aug 2023 03:42:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.45-cip3-31-gc9451d303f3d
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
Subject: cip/linux-6.1.y-cip baseline: 139 runs,
 5 regressions (v6.1.45-cip3-31-gc9451d303f3d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Aug 2023 10:42:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12839

cip/linux-6.1.y-cip baseline: 139 runs, 5 regressions (v6.1.45-cip3-31-gc94=
51d303f3d)

Regressions Summary
-------------------

platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
acer-chromebox-cxi4-puff | x86_64 | lab-collabora   | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

imx6dl-riotboard         | arm    | lab-pengutronix | gcc-10   | multi_v7_d=
efconfig           | 1          =

juno-uboot               | arm64  | lab-broonie     | gcc-10   | cip://6.1.=
y-c...64_defconfig | 2          =

sun50i-h6-pine-h64       | arm64  | lab-collabora   | gcc-10   | defconfig =
                   | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.45-cip3-31-gc9451d303f3d/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.45-cip3-31-gc9451d303f3d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c9451d303f3dddd89b8ee3f9bb9a2ff5b369be7f =



Test Regressions
---------------- =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
acer-chromebox-cxi4-puff | x86_64 | lab-collabora   | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e5dbd8e0e85d6113b1e3b8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.45-ci=
p3-31-gc9451d303f3d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.45-ci=
p3-31-gc9451d303f3d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e5dbd8e0e85d6113b1e=
3b9
        failing since 9 days (last pass: v6.1.42-cip2-1-g47d13938e615, firs=
t fail: v6.1.45-cip3) =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
imx6dl-riotboard         | arm    | lab-pengutronix | gcc-10   | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64e5dbcb7521f10979b1e3af

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.45-ci=
p3-31-gc9451d303f3d/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-=
imx6dl-riotboard.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.45-ci=
p3-31-gc9451d303f3d/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-=
imx6dl-riotboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e5dbcb7521f10979b1e3b4
        new failure (last pass: v6.1.42-cip2-1-g47d13938e615)

    2023-08-23T10:13:07.966300  + set[   14.962140] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 998102_1.5.2.3.1>
    2023-08-23T10:13:07.966522   +x
    2023-08-23T10:13:08.072897  / # #
    2023-08-23T10:13:08.174829  export SHELL=3D/bin/sh
    2023-08-23T10:13:08.175304  #
    2023-08-23T10:13:08.276620  / # export SHELL=3D/bin/sh. /lava-998102/en=
vironment
    2023-08-23T10:13:08.277150  =

    2023-08-23T10:13:08.378511  / # . /lava-998102/environment/lava-998102/=
bin/lava-test-runner /lava-998102/1
    2023-08-23T10:13:08.379252  =

    2023-08-23T10:13:08.382401  / # /lava-998102/bin/lava-test-runner /lava=
-998102/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
juno-uboot               | arm64  | lab-broonie     | gcc-10   | cip://6.1.=
y-c...64_defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64e5db82f1cb2fbbe5b1e3af

  Results:     55 PASS, 5 FAIL, 1 SKIP
  Full config: cip://6.1.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.45-ci=
p3-31-gc9451d303f3d/arm64/cip---6.1.y-cip-arm64-qemu_arm64_defconfig/gcc-10=
/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.45-ci=
p3-31-gc9451d303f3d/arm64/cip---6.1.y-cip-arm64-qemu_arm64_defconfig/gcc-10=
/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case/id/=
64e5db82f1cb2fbbe5b1e3da
        failing since 23 days (last pass: v6.1.31-65-ge66be31505fa, first f=
ail: v6.1.42-cip2)

    2023-08-23T10:12:01.590129  /lava-65575/1/../bin/lava-test-case
    2023-08-23T10:12:01.629869  <8>[   35.078095] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>
    2023-08-23T10:12:01.630372  /lava-65575/1/../bin/lava-test-case   =


  * baseline.bootrr.ethernet-probed: https://kernelci.org/test/case/id/64e5=
db82f1cb2fbbe5b1e3dc
        failing since 23 days (last pass: v6.1.31-65-ge66be31505fa, first f=
ail: v6.1.42-cip2)

    2023-08-23T10:12:00.556933  /lava-65575/1/../bin/lava-test-case
    2023-08-23T10:12:00.560172  <8>[   34.024957] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dethernet-probed RESULT=3Dfail>
    2023-08-23T10:12:00.560689  /lava-65575/1/../bin/lava-test-case   =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
sun50i-h6-pine-h64       | arm64  | lab-collabora   | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64e5d6de20652122adb1e41f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.45-ci=
p3-31-gc9451d303f3d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.45-ci=
p3-31-gc9451d303f3d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e5d6de20652122adb1e424
        failing since 23 days (last pass: v6.1.31-53-g486caac40d06, first f=
ail: v6.1.42-cip2)

    2023-08-23T09:54:03.390447  / # #

    2023-08-23T09:54:03.492789  export SHELL=3D/bin/sh

    2023-08-23T09:54:03.493590  #

    2023-08-23T09:54:03.595045  / # export SHELL=3D/bin/sh. /lava-11336307/=
environment

    2023-08-23T09:54:03.595821  =


    2023-08-23T09:54:03.697299  / # . /lava-11336307/environment/lava-11336=
307/bin/lava-test-runner /lava-11336307/1

    2023-08-23T09:54:03.698516  =


    2023-08-23T09:54:03.699695  / # /lava-11336307/bin/lava-test-runner /la=
va-11336307/1

    2023-08-23T09:54:03.780819  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-23T09:54:03.781380  + cd /lava-11336307/1/tests/1_boot<8>[   16=
.926200] <LAVA_SIGNAL_STARTRUN 1_bootrr 11336307_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20


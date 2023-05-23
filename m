Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92309C77B75
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 01:16:26 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web10.9737.1684804585516949398
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 May 2023 18:16:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=oF3oHk6n;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ae4be0b1f3so47344475ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 22 May 2023 18:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684804584; x=1687396584;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lS7Z6DTccv4vu0AApWOZmPa2HlszNii4xNe2WFo1vCs=;
        b=oF3oHk6nLXLchlfoX1KatfB1WvIsY/2VBCdpk20UlvlfWkVqncF+u5VNjwX3ll9jsY
         8EaMdT0u0Cb7QAcZvh3cvlNC31jA6yaWLG+w0NdzUbu9chxC+uzgaGICNIrn0hRlXR0Z
         gGK+dcIXdPimquxpRcDWf0cdXmwGPjSH9vTbuo3zgZIcMaNyqKLoYPrA3bgQt9mtPPpF
         cl3wwYWB5/gKD3Rc30iQBM5PPQrY1vQbj6ZiuFSWqOz6DnjhIU71RWUX7lfB3wUTqFMT
         sokfx3XzcafuEJHhYHGPSOXXS3+l/fFbfnufrf1ndzNIV1xgA3XIYMv1KfqMImtU+ix6
         UAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684804584; x=1687396584;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lS7Z6DTccv4vu0AApWOZmPa2HlszNii4xNe2WFo1vCs=;
        b=HrWM4TG9E12z+tXA+mR2h6ArxEcDGuZOoBFq0kSP0MPSCbKeFl4vNDYP61kXhMNzsg
         oUI5YFmtrMXGf35VkZOTpC4EYQroSkoV1TNohhSHUCd3ZrsRi10W8pJKEs4QU4UZCAjN
         gCFHDC17vK7WchQR8QdlQ9mx8jO7BFoCwVzTHiZb/YgA9ETvOk0QO0Lg3l3IAScCDodh
         neIapJN+SK9GUfbq6wp2gN0AiK1p9R+8lAUUWAcd1wQ7+qy4Rl1MCd4bGlxMoolIuHW2
         5QsD2N3KitKhKOZh7KOhebPcYzRcyUzZvkaBi7NrCKZVv+xIyoOt2H+QXHeAgPkyPozJ
         hGvw==
X-Gm-Message-State: AC+VfDx8uMVx6Xec5KeX6wLe50KlcE8LJ+6NJJOMhSwZ+lhE+ddRrKhB
	O4qtKMC1zcpmK5WnUNkDKkYvKZ4IHlkTd7L484K46A==
X-Google-Smtp-Source: ACHHUZ7kYjmDI74TCkrwLcxlOABDCoPmgihWaTvjHz9g+AoLPfjJO3pnN3eMciIX+Rqavs+ftPtO/g==
X-Received: by 2002:a17:902:eb46:b0:1ac:9cad:1845 with SMTP id i6-20020a170902eb4600b001ac9cad1845mr12783853pli.18.1684804583203;
        Mon, 22 May 2023 18:16:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902e54700b001aae625e422sm5439946plf.37.2023.05.22.18.16.22
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 18:16:22 -0700 (PDT)
Message-ID: <646c13e6.170a0220.e879e.a192@mx.google.com>
Date: Mon, 22 May 2023 18:16:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.280-cip95-rt30
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 106 runs,
 71 regressions (v4.19.280-cip95-rt30)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 01:16:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11592

cip-gitlab/ci/pavel/linux-test baseline: 106 runs, 71 regressions (v4.19.28=
0-cip95-rt30)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig            | 2          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 2          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 5          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 7          =

hip07-d05                    | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

hip07-d05                    | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defconfig             | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig             | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 5          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 5          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 7          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 8          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.280-cip95-rt30/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.280-cip95-rt30
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      dcee20e65677ab5d0e0d47c572f2c71dae6074a1 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0b88c9ce5e38692e8605

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0b88c9ce5e38692e8=
606
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0b8b702d81e96c2e8624

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0b8b702d81e96c2e8=
625
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0b8972fa78333a2e860f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0b8972fa78333a2e8=
610
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig            | 2          =


  Details:     https://kernelci.org/test/plan/id/646c09a16e413985772e8606

  Results:     44 PASS, 6 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm/at91_dt_defconfig/gcc-10/lab-broonie/baseline-at9=
1sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm/at91_dt_defconfig/gcc-10/lab-broonie/baseline-at9=
1sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.atmel-usart-serial-driver-present: https://kernelci.org=
/test/case/id/646c09a16e413985772e8633
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:32:15.395532  /lava-498686/1/../bin/lava-test-case
    2023-05-23T00:32:15.432259  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Datm=
el-usart-serial-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at91-usart-mode-driver-present: https://kernelci.org/te=
st/case/id/646c09a16e413985772e8634
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:32:14.301881  /lava-498686/1/../bin/lava-test-case
    2023-05-23T00:32:14.339932  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dat9=
1-usart-mode-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/646c0b95ae3e287e552e85f7

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at=
91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at=
91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.atmel-usart-serial-driver-present: https://kernelci.org=
/test/case/id/646c0b96ae3e287e552e8625
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:40:16.427228  /lava-498690/1/../bin/lava-test-case
    2023-05-23T00:40:16.463604  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Datm=
el-usart-serial-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at91-usart-mode-driver-present: https://kernelci.org/te=
st/case/id/646c0b96ae3e287e552e8626
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:40:15.340933  /lava-498690/1/../bin/lava-test-case
    2023-05-23T00:40:15.377395  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dat9=
1-usart-mode-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 5          =


  Details:     https://kernelci.org/test/plan/id/646c0d06f8734b4ffb2e861c

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-be=
aglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-be=
aglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/646c0d06f8734b4ffb2e862e
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:46:32.075593  /lava-498783/1/../bin/lava-test-case
    2023-05-23T00:46:32.093427  <8>[   27.444864] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-05-23T00:46:33.117554  /lava-498783/1/../bin/lava-test-case
    2023-05-23T00:46:33.136101  <8>[   28.487479] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mmc1-probed: https://kernelci.org/test/case/id/646c0d06=
f8734b4ffb2e8637
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:46:29.701180  /lava-498783/1/../bin/lava-test-case
    2023-05-23T00:46:29.717937  <8>[   25.070796] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc1-probed RESULT=3Dfail>   =


  * baseline.bootrr.mmc0-probed: https://kernelci.org/test/case/id/646c0d06=
f8734b4ffb2e8638
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:46:28.651498  /lava-498783/1/../bin/lava-test-case
    2023-05-23T00:46:28.668345  <8>[   24.021103] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc0-probed RESULT=3Dfail>   =


  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/646c0d06f8734b4ffb2e8644
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:46:24.090394  /lava-498783/1/../bin/lava-test-case
    2023-05-23T00:46:24.108542  <8>[   19.459962] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/646c0d07f8734b4f=
fb2e864b
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)
        1 lines

    2023-05-23T00:46:20.708992  / # =

    2023-05-23T00:46:20.714635  =

    2023-05-23T00:46:20.821147  / # #
    2023-05-23T00:46:20.827048  #
    2023-05-23T00:46:20.929838  / # export SHELL=3D/bin/sh
    2023-05-23T00:46:20.935841  export SHELL=3D/bin/sh
    2023-05-23T00:46:21.037874  / # . /lava-498783/environment
    2023-05-23T00:46:21.043671  . /lava-498783/environment
    2023-05-23T00:46:21.145858  / # /lava-498783/bin/lava-test-runner /lava=
-498783/0
    2023-05-23T00:46:21.150460  /lava-498783/bin/lava-test-runner /lava-498=
783/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 7          =


  Details:     https://kernelci.org/test/plan/id/646c0cc795eb6c33132e8622

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-b=
eaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-b=
eaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.omap-sham-driver-present: https://kernelci.org/test/cas=
e/id/646c0cc795eb6c33132e8633
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:45:34.548927  <6>[   33.147876] platform pm33xx: deferred=
 probe pending
    2023-05-23T00:45:35.421670  /lava-498751/1/../bin/lava-test-case
    2023-05-23T00:45:35.469325  <8>[   34.066204] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap-aes-driver-present: https://kernelci.org/test/case=
/id/646c0cc795eb6c33132e8636
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:45:33.043801  /lava-498751/1/../bin/lava-test-case
    2023-05-23T00:45:33.101759  <8>[   31.698785] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/646c0cc795eb6c33132e8639
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:45:29.561913  /lava-498751/1/../bin/lava-test-case
    2023-05-23T00:45:29.612811  <8>[   28.210875] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-05-23T00:45:30.665903  /lava-498751/1/../bin/lava-test-case
    2023-05-23T00:45:30.725078  <8>[   29.322510] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mmc1-probed: https://kernelci.org/test/case/id/646c0cc7=
95eb6c33132e8641
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:45:26.781929  /lava-498751/1/../bin/lava-test-case
    2023-05-23T00:45:26.834202  <8>[   25.431862] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc1-probed RESULT=3Dfail>   =


  * baseline.bootrr.mmc0-probed: https://kernelci.org/test/case/id/646c0cc7=
95eb6c33132e8642
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:45:25.654149  /lava-498751/1/../bin/lava-test-case
    2023-05-23T00:45:25.711288  <8>[   24.308895] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc0-probed RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/646c0cc795eb6c33132e8654
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:45:28.455488  /lava-498751/1/../bin/lava-test-case
    2023-05-23T00:45:28.508529  <8>[   27.104986] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/646c0cc795eb6c33=
132e8658
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)
        1 lines

    2023-05-23T00:45:20.533368  / # =

    2023-05-23T00:45:20.542980  =

    2023-05-23T00:45:20.660528  / # #
    2023-05-23T00:45:20.667577  #
    2023-05-23T00:45:20.770274  / # export SHELL=3D/bin/sh
    2023-05-23T00:45:20.777444  export SHELL=3D/bin/sh
    2023-05-23T00:45:20.879646  / # . /lava-498751/environment
    2023-05-23T00:45:20.887074  . /lava-498751/environment
    2023-05-23T00:45:20.989342  / # /lava-498751/bin/lava-test-runner /lava=
-498751/0
    2023-05-23T00:45:21.003441  /lava-498751/bin/lava-test-runner /lava-498=
751/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hip07-d05                    | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0c3c725bbf097a2e85ef

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-hip07-d05.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-hip07-d05.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0c3c725bbf097a2e8=
5f0
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hip07-d05                    | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0dcd923dc41f232e871a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-collabora/baseline-hip07-d=
05.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-collabora/baseline-hip07-d=
05.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0dcd923dc41f232e8=
71b
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0ad23c2df793a82e85ef

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseli=
ne-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseli=
ne-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0ad23c2df793a82e85f4
        failing since 124 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-05-23T00:37:13.373129  + set +x[    7.314142] <LAVA_SIGNAL_ENDRUN =
0_dmesg 956968_1.5.2.3.1>
    2023-05-23T00:37:13.373296  =

    2023-05-23T00:37:13.480661  / # #
    2023-05-23T00:37:13.582129  export SHELL=3D/bin/sh
    2023-05-23T00:37:13.582593  #
    2023-05-23T00:37:13.684013  / # export SHELL=3D/bin/sh. /lava-956968/en=
vironment
    2023-05-23T00:37:13.684500  =

    2023-05-23T00:37:13.785917  / # . /lava-956968/environment/lava-956968/=
bin/lava-test-runner /lava-956968/1
    2023-05-23T00:37:13.786797  =

    2023-05-23T00:37:13.789136  / # /lava-956968/bin/lava-test-runner /lava=
-956968/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0c3cceca34a7752e85ea

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baselin=
e-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baselin=
e-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0c3cceca34a7752e85ef
        failing since 124 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-05-23T00:43:26.795793  + set +x
    2023-05-23T00:43:26.795957  [    5.025812] <LAVA_SIGNAL_ENDRUN 0_dmesg =
956974_1.5.2.3.1>
    2023-05-23T00:43:26.902319  / # #
    2023-05-23T00:43:27.003780  export SHELL=3D/bin/sh
    2023-05-23T00:43:27.004188  #
    2023-05-23T00:43:27.105459  / # export SHELL=3D/bin/sh. /lava-956974/en=
vironment
    2023-05-23T00:43:27.105809  =

    2023-05-23T00:43:27.207394  / # . /lava-956974/environment/lava-956974/=
bin/lava-test-runner /lava-956974/1
    2023-05-23T00:43:27.207948  =

    2023-05-23T00:43:27.210305  / # /lava-956974/bin/lava-test-runner /lava=
-956974/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0c869f998105942e85eb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboo=
t.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboo=
t.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0c869f998105942e8=
5ec
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0d358f298d80012e8602

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/b=
aseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/b=
aseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0d358f298d80012e8=
603
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0e9d7dedf9a1cb2e860c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm6=
4-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm6=
4-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0e9d7dedf9a1cb2e8=
60d
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0bc4d3aa0dd7c22e85ee

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0bc4d3aa0dd7c22e8=
5ef
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0c14e82b96c7642e85fc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_ar=
m64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_ar=
m64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0c14e82b96c7642e8=
5fd
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0d210b01e425112e8616

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/b=
aseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/b=
aseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0d210b01e425112e8=
617
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0eb2b362a5c3ab2e85ff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm6=
4-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm6=
4-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0eb2b362a5c3ab2e8=
600
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0bc5f177aac1372e860c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0bc5f177aac1372e8=
60d
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0c29f13cdc170c2e8610

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_ar=
m64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_ar=
m64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0c29f13cdc170c2e8=
611
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0de9f22db5cf922e8617

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/b=
aseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/b=
aseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0de9f22db5cf922e8=
618
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0e9e1f374a55fd2e861a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm6=
4-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm6=
4-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0e9e1f374a55fd2e8=
61b
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0bc5d3aa0dd7c22e85f2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0bc5d3aa0dd7c22e8=
5f3
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0c28f13cdc170c2e860d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_ar=
m64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_ar=
m64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0c28f13cdc170c2e8=
60e
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0cf9f8734b4ffb2e85f7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/b=
aseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/b=
aseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0cf9f8734b4ffb2e8=
5f8
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0f0296b1e3720f2e861f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm6=
4-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm6=
4-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0f0296b1e3720f2e8=
620
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0bc4efebce54aa2e8610

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0bc4efebce54aa2e8=
611
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0c3c4f9ada9a532e85fd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_ar=
m64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_ar=
m64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0c3c4f9ada9a532e8=
5fe
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0bcdd3aa0dd7c22e85fd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-bro=
onie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-bro=
onie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0bcdd3aa0dd7c22e8=
5fe
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0e6183a1098fdc2e85fd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig/gcc-10/lab-broonie/baseline-q=
emu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig/gcc-10/lab-broonie/baseline-q=
emu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0e6183a1098fdc2e8=
5fe
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0b88702d81e96c2e85ed

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0b88702d81e96c2e8=
5ee
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0c00f13cdc170c2e8601

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baseline=
-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baseline=
-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0c00f13cdc170c2e8=
602
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0b92ae3e287e552e85f4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a774=
3-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a774=
3-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0b92ae3e287e552e8=
5f5
        failing since 4 days (last pass: v5.10.179-cip32-4-g580ea5dd85ae, f=
irst fail: v5.10.179-cip32-471-g18129e1b68691) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 5          =


  Details:     https://kernelci.org/test/plan/id/646c0c50ceca34a7752e861a

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-=
rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-=
rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rk_iommu-vpu_mmu-probed: https://kernelci.org/test/case=
/id/646c0c50ceca34a7752e8638
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:43:44.462544  /lava-10419458/1/../bin/lava-test-case

    2023-05-23T00:43:44.471346  <8>[   13.881169] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk_iommu-vpu_mmu-probed RESULT=3Dfail>
   =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/646c0c50ceca34a7752e8648
        failing since 31 days (last pass: v4.4-st20-1100-ga8cadce4b9649, fi=
rst fail: v5.10.177-cip31-33-gd59f246891e73)

    2023-05-23T00:43:41.145847  Usag<8>[   10.551571] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Ddwmmc_rockchip-driver-present RESULT=3Dpass>

    2023-05-23T00:43:41.149668  e: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-05-23T00:43:41.149885  =


    2023-05-23T00:43:41.154897  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-05-23T00:43:41.157405  FIRST, INC default to 1.

    2023-05-23T00:43:41.157623  =


    2023-05-23T00:43:41.161012  	-w	Pad to last with leading zeros

    2023-05-23T00:43:41.163669  	-s SEP	String separator

    2023-05-23T00:43:41.167795  /lava-10419458/1/../bin/lava-test-case

    2023-05-23T00:43:41.171754  /lava-10419458/1/../bin/lava-test-case
 =

    ... (1 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/646c0c50ceca34a7752e864a
        failing since 122 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-05-23T00:43:41.095586  BusyBox v1.31.1 (2023-05-12 17:02:46 UTC)<8=
>[   10.503915] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-05-23T00:43:41.097410   multi-call binary.

    2023-05-23T00:43:41.097462  =


    2023-05-23T00:43:41.102845  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-05-23T00:43:41.102912  =


    2023-05-23T00:43:41.107064  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/646c0c50ceca34a7752e864b
        failing since 122 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-05-23T00:43:41.076489  <8>[   10.486163] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.cros-ec-dev-driver-present: https://kernelci.org/test/c=
ase/id/646c0c50ceca34a7752e865b
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:43:38.752663  <8>[    8.162808] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtpm-chip-is-online RESULT=3Dskip>

    2023-05-23T00:43:39.768666  /lava-10419458/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 5          =


  Details:     https://kernelci.org/test/plan/id/646c0aeb8862f787752e8614

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/646c0aeb8862f787752e861a
        failing since 61 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d)

    2023-05-23T00:37:48.900047  /lava-10419375/1/../bin/lava-test-case

    2023-05-23T00:37:48.908447  <8>[   37.468123] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/646c0aeb8862f787752e861b
        failing since 61 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d)

    2023-05-23T00:37:47.875027  /lava-10419375/1/../bin/lava-test-case

    2023-05-23T00:37:47.883387  <8>[   36.443329] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =


  * baseline.bootrr.cros-ec-sysfs-driver-present: https://kernelci.org/test=
/case/id/646c0aeb8862f787752e8650
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:37:43.719540  <8>[   32.278164] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-gyro0-probed RESULT=3Dpass>

    2023-05-23T00:37:44.728076  /lava-10419375/1/../bin/lava-test-case
   =


  * baseline.bootrr.cros-ec-lightbar-driver-present: https://kernelci.org/t=
est/case/id/646c0aeb8862f787752e8659
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:37:43.556565  /lava-10419375/1/../bin/lava-test-case

    2023-05-23T00:37:43.565932  <8>[   32.124435] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-lightbar-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.cros-ec-debugfs-driver-present: https://kernelci.org/te=
st/case/id/646c0aeb8862f787752e8662
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:37:40.360331  <8>[   28.919815] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtpm-chip-is-online RESULT=3Dskip>

    2023-05-23T00:37:41.377590  /lava-10419375/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 7          =


  Details:     https://kernelci.org/test/plan/id/646c0bc67df89a64bb2e85e6

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a6=
4-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a6=
4-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.lima-driver-present: https://kernelci.org/test/case/id/=
646c0bc67df89a64bb2e85e9
        new failure (last pass: v5.10.177-cip31-33-gd59f246891e73)

    2023-05-23T00:41:27.583470  x v1.31.1 (2023-05-12 16:56:27 UTC) multi-c=
all binary.
    2023-05-23T00:41:27.583777  =

    2023-05-23T00:41:27.583963  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST
    2023-05-23T00:41:27.584201  =

    2023-05-23T00:41:27.589488  Print numbers from FIRST to LAST, in steps =
of INC.
    2023-05-23T00:41:27.594704  FIRST, INC default to 1.
    2023-05-23T00:41:27.595148  =

    2023-05-23T00:41:27.595505  	-w	Pad to last with leading zeros
    2023-05-23T00:41:27.602235  	-s SEP	String separator
    2023-05-23T00:41:27.602603  /lava-498737/1/../bin/lava-test-case =

    ... (2 line(s) more)  =


  * baseline.bootrr.sun8i-mixer-driver-present: https://kernelci.org/test/c=
ase/id/646c0bc67df89a64bb2e85ec
        new failure (last pass: v5.10.177-cip31-33-gd59f246891e73)

    2023-05-23T00:41:26.493989  /lava-498737/1/../bin/lava-test-case
    2023-05-23T00:41:26.504461  <8>[   35.387469] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-phy-probed RESULT=3Dblocked>
    2023-05-23T00:41:27.518583  /lava-498737/1/../bin/lava-test-case
    2023-05-23T00:41:27.529465  <8>[   36.411826] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-mixer-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-hdmi-phy-driver-present: https://kernelci.org/tes=
t/case/id/646c0bc67df89a64bb2e85ed
        new failure (last pass: v5.10.177-cip31-33-gd59f246891e73)

    2023-05-23T00:41:24.949335  <6>[   33.837119] platform sound_spdif: def=
erred probe pending
    2023-05-23T00:41:25.468729  /lava-498737/1/../bin/lava-test-case
    2023-05-23T00:41:25.479898  <8>[   34.362014] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-hdmi-phy-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sunxi-wdt-driver-present: https://kernelci.org/test/cas=
e/id/646c0bc67df89a64bb2e85f0
        new failure (last pass: v5.10.177-cip31-33-gd59f246891e73)

    2023-05-23T00:41:22.346536  /lava-498737/1/../bin/lava-test-case
    2023-05-23T00:41:22.357014  <8>[   31.239961] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsoc-crypto-probed RESULT=3Dblocked>
    2023-05-23T00:41:23.373022  /lava-498737/1/../bin/lava-test-case   =


  * baseline.bootrr.sun8i-ce-driver-present: https://kernelci.org/test/case=
/id/646c0bc67df89a64bb2e85f1
        new failure (last pass: v5.10.177-cip31-33-gd59f246891e73)

    2023-05-23T00:41:20.297373  /lava-498737/1/../bin/lava-test-case
    2023-05-23T00:41:20.307531  <8>[   29.191041] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsid-probed RESULT=3Dblocked>
    2023-05-23T00:41:21.321260  /lava-498737/1/../bin/lava-test-case
    2023-05-23T00:41:21.332051  <8>[   30.214989] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-ce-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.eeprom-sunxi-sid-driver-present: https://kernelci.org/t=
est/case/id/646c0bc67df89a64bb2e85f2
        new failure (last pass: v5.10.177-cip31-33-gd59f246891e73)

    2023-05-23T00:41:19.271568  /lava-498737/1/../bin/lava-test-case
    2023-05-23T00:41:19.283390  <8>[   28.165322] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Deeprom-sunxi-sid-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-dw-hdmi-driver-present: https://kernelci.org/test=
/case/id/646c0bc67df89a64bb2e85f5
        new failure (last pass: v5.10.177-cip31-33-gd59f246891e73)

    2023-05-23T00:41:17.181713  /lava-498737/1/../bin/lava-test-case
    2023-05-23T00:41:17.201769  <8>[   26.075795] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-dw-hdmi-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 8          =


  Details:     https://kernelci.org/test/plan/id/646c0b88702d81e96c2e85f0

  Results:     24 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5=
-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5=
-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.lima-driver-present: https://kernelci.org/test/case/id/=
646c0b88702d81e96c2e85f3
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:40:29.888815  /lava-498719/1/../bin/lava-test-case
    2023-05-23T00:40:29.899393  <8>[   33.461122] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-phy-probed RESULT=3Dblocked>
    2023-05-23T00:40:30.913330  /lava-498719/1/../bin/lava-test-case
    2023-05-23T00:40:30.923904  <8>[   34.485587] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlima-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-hdmi-phy-driver-present: https://kernelci.org/tes=
t/case/id/646c0b88702d81e96c2e85f4
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:40:27.839400  /lava-498719/1/../bin/lava-test-case
    2023-05-23T00:40:27.849447  <8>[   31.411520] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-probed RESULT=3Dblocked>
    2023-05-23T00:40:28.863579  /lava-498719/1/../bin/lava-test-case
    2023-05-23T00:40:28.874974  <8>[   32.435656] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-hdmi-phy-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-dw-hdmi-driver-present: https://kernelci.org/test=
/case/id/646c0b88702d81e96c2e85f5
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:40:25.789229  /lava-498719/1/../bin/lava-test-case
    2023-05-23T00:40:25.800296  <8>[   29.361548] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-mixer-probed RESULT=3Dblocked>
    2023-05-23T00:40:26.814048  /lava-498719/1/../bin/lava-test-case
    2023-05-23T00:40:26.825468  <8>[   30.386208] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-dw-hdmi-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-mixer-driver-present: https://kernelci.org/test/c=
ase/id/646c0b88702d81e96c2e85f6
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:40:23.739806  /lava-498719/1/../bin/lava-test-case
    2023-05-23T00:40:23.750327  <8>[   27.311762] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Danalog-audio-probed RESULT=3Dblocked>
    2023-05-23T00:40:24.764233  /lava-498719/1/../bin/lava-test-case
    2023-05-23T00:40:24.775303  <8>[   28.336442] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-mixer-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-ce-driver-present: https://kernelci.org/test/case=
/id/646c0b88702d81e96c2e85f8
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:40:19.640991  /lava-498719/1/../bin/lava-test-case
    2023-05-23T00:40:19.651184  <8>[   23.213305] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dir-probed RESULT=3Dblocked>
    2023-05-23T00:40:20.664700  /lava-498719/1/../bin/lava-test-case
    2023-05-23T00:40:20.675847  <8>[   24.237161] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-ce-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sunxi-ir-driver-present: https://kernelci.org/test/case=
/id/646c0b88702d81e96c2e85f9
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:40:18.616202  /lava-498719/1/../bin/lava-test-case
    2023-05-23T00:40:18.627044  <8>[   22.188582] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsunxi-ir-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sunxi-wdt-driver-present: https://kernelci.org/test/cas=
e/id/646c0b88702d81e96c2e85fc
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:40:15.495742  /lava-498719/1/../bin/lava-test-case
    2023-05-23T00:40:15.505754  <8>[   19.068033] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsid-probed RESULT=3Dblocked>
    2023-05-23T00:40:16.519641  /lava-498719/1/../bin/lava-test-case
    2023-05-23T00:40:16.530701  <8>[   20.092095] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsunxi-wdt-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.eeprom-sunxi-sid-driver-present: https://kernelci.org/t=
est/case/id/646c0b88702d81e96c2e85fd
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:40:14.469620  /lava-498719/1/../bin/lava-test-case
    2023-05-23T00:40:14.481399  <8>[   18.042275] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Deeprom-sunxi-sid-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0b2568d1b028b42e85e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0b2568d1b028b42e85eb
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:38:55.040426  / # #

    2023-05-23T00:38:55.142704  export SHELL=3D/bin/sh

    2023-05-23T00:38:55.143498  #

    2023-05-23T00:38:55.244905  / # export SHELL=3D/bin/sh. /lava-10419405/=
environment

    2023-05-23T00:38:55.245699  =


    2023-05-23T00:38:55.347218  / # . /lava-10419405/environment/lava-10419=
405/bin/lava-test-runner /lava-10419405/1

    2023-05-23T00:38:55.348488  =


    2023-05-23T00:38:55.364628  / # /lava-10419405/bin/lava-test-runner /la=
va-10419405/1

    2023-05-23T00:38:55.406131  + export 'TESTRUN_ID=3D1_bootrr'

    2023-05-23T00:38:55.423721  + cd /lava-1041940<8>[   15.619310] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 10419405_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20


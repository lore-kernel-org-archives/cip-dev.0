Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90550C7EE26
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 01:16:26 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.9736.1684804585233322279
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 May 2023 18:16:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=IX2c3ZqN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ae52ce3205so46531285ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 22 May 2023 18:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684804584; x=1687396584;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHWhcb5zcvR38iM29k22fO3NzJDq37H0hhssmEajdjU=;
        b=IX2c3ZqNu0cjgdq4H6u1uSiF74V+Y9nFwPC7p7ppeiCDR14H7KoGSgK97WcSvm+7UO
         oBWU04qxXJWD6E6Be4pvAQDE+M64f+CBi1mOSOCjB9G4nWQ4aDDlzAz6CCqIOK1k9khx
         8qCCeYAkn/PsXyyV3fhYYMwT2+0iclmqAr2uJHRlYNZN6/COlM5bItO2ELlYM7gPWb+T
         U3TF2+ybm+jd7cYw0Rdh396/tZbKh+00hFtAhZDL6nvjxrfeTM/Wsi45NNSB8JN6ryAk
         Q6syBMCCc/sgZFAztEJc8PbLOHxtHPie3CVsP3QwmY8xkcnPJQAj2v0JARxF4bRiApib
         GMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684804584; x=1687396584;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHWhcb5zcvR38iM29k22fO3NzJDq37H0hhssmEajdjU=;
        b=kN6gg44lVdUq95KeLOy318SmiaC5i9Qe+YT5jE8uPlorVZlWE4H45ax4BxQTiSkWOh
         SyY2S/hUKPFAyH/IHP8Y2NbxIyg3hfBP1vsW8pg4xUuvcmhU0/LTjAkOJdyWJq5Rzapf
         P/zXdgeOwow+i5rooNqon3Xj1KPVhVboTJjjnjWi8BNsMBFOTjjVuYE8RjPl6t6RDhj+
         0+tvFknkzVSiqlwZnNOlsz5/mllGPG9nmZgCsNGhrrMd1heOlmi6GJ0POXOFlRDOKvuV
         kMT98sfqn3AkxrGWD/kwAmHTQXK/jGSO7cDavsAXqAM8msdUssxKu3tr+DuEcLSS1a2E
         AU2Q==
X-Gm-Message-State: AC+VfDypnV89XqD+xYHFkMFQOZ0SLhCupqd8y6Dd/P0iPXGHUjgGzOXJ
	w5CCyX8oyEOAG4iGwOlSvwlp3VXl+Qz03jvFYJVQrw==
X-Google-Smtp-Source: ACHHUZ4Y/SdAljWJ5vIbpoz6HUELDCRIspkEGGqM7w4UVsNFgJzmIk/Csp6wELF1ge7L8cArDZv3gQ==
X-Received: by 2002:a17:903:1112:b0:1aa:f818:7a23 with SMTP id n18-20020a170903111200b001aaf8187a23mr14158683plh.27.1684804583724;
        Mon, 22 May 2023 18:16:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902a38100b001a6ff7bd4d9sm5529637pla.15.2023.05.22.18.16.22
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 18:16:23 -0700 (PDT)
Message-ID: <646c13e7.170a0220.4ac0e.9cda@mx.google.com>
Date: Mon, 22 May 2023 18:16:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.280-cip95-rt30
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 40 runs,
 39 regressions (v4.19.280-cip95-rt30)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 01:16:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11591

cip-gitlab/ci/pavel/linux-test baseline-nfs: 40 runs, 39 regressions (v4.19=
.280-cip95-rt30)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 2          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 7          =

hip07-d05                    | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

hip07-d05                    | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 5          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 8          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 8          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.280-cip95-rt30/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.280-cip95-rt30
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      dcee20e65677ab5d0e0d47c572f2c71dae6074a1 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0b8eae3e287e552e85eb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/646c0b8eae3e287e5=
52e85ec
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0b88702d81e96c2e85ea

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/646c0b88702d81e96=
c2e85eb
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0b9defebce54aa2e85e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/646c0b9defebce54a=
a2e85e8
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/646c0c5ed8044550372e85e6

  Results:     43 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nf=
s-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nf=
s-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.atmel-usart-serial-driver-present: https://kernelci=
.org/test/case/id/646c0c5ed8044550372e8612
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:43:42.537300  /lava-498689/1/../bin/lava-test-case   =


  * baseline-nfs.bootrr.at91-usart-mode-driver-present: https://kernelci.or=
g/test/case/id/646c0c5ed8044550372e8613
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:43:41.380572  /lava-498689/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0e7d5db99ab7eb2e8648

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nf=
s-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nf=
s-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/646c0e7d5db99ab7e=
b2e8649
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0e2db349f6ce1f2e85f2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-n=
fs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-n=
fs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/646c0e2db349f6ce1=
f2e85f3
        failing since 6 days (last pass: v5.10.177-cip31-33-gd59f246891e73,=
 first fail: v5.10.179-cip32-4-g580ea5dd85ae) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 7          =


  Details:     https://kernelci.org/test/plan/id/646c1381412b9c11612e8602

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-b=
eaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-b=
eaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.mmc0-probed: https://kernelci.org/test/case/id/646c=
1381412b9c11612e8616
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T01:14:02.779356  /lava-940747/1/../bin/lava-test-case
    2023-05-23T01:14:02.889071  [   50.882378] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mmc1-probed: https://kernelci.org/test/case/id/646c=
1381412b9c11612e8617
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T01:14:04.055774  /lava-940747/1/../bin/lava-test-case
    2023-05-23T01:14:04.173723  [   52.166445] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/646c1381412b9c11612e861f
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T01:14:06.711899  /lava-940747/1/../bin/lava-test-case
    2023-05-23T01:14:06.829117  [   54.820130] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/646c1381412b9c11612e8620
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T01:14:07.947733  /lava-940747/1/../bin/lava-test-case
    2023-05-23T01:14:08.056697  [   56.050195] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-05-23T01:14:09.175857  /lava-940747/1/../bin/lava-test-case
    2023-05-23T01:14:09.279651  [   57.273166] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-aes-driver-present: https://kernelci.org/test/=
case/id/646c1381412b9c11612e8623
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T01:14:12.054312  /lava-940747/1/../bin/lava-test-case
    2023-05-23T01:14:12.157266  [   60.151374] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-sham-driver-present: https://kernelci.org/test=
/case/id/646c1381412b9c11612e8626
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T01:14:14.883422  /lava-940747/1/../bin/lava-test-case
    2023-05-23T01:14:15.003282  [   62.997258] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/646c1381412b=
9c11612e8636
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)
        1 lines

    2023-05-23T01:13:47.879349  / # =

    2023-05-23T01:13:47.885295  =

    2023-05-23T01:13:52.940562  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/940747/extract-nfsrootfs-3o6lbi9t'
    2023-05-23T01:13:52.952233  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/940747/extract-nfsrootfs-3o6lbi9t'
    2023-05-23T01:13:55.085529  / # export NFS_SERVER_IP=3D'192.168.1.1'
    2023-05-23T01:13:55.096759  export NFS_SERVER_IP=3D'192.168.1.1'
    2023-05-23T01:13:55.214795  / # #
    2023-05-23T01:13:55.221925  #
    2023-05-23T01:13:55.340178  / #export SHELL=3D/bin/sh
    2023-05-23T01:13:55.349861   export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hip07-d05                    | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0fc1040cf306e62e8608

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-nfs-hip07-d05.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-nfs-hip07-d05.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/646c0fc1040cf306e=
62e8609
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hip07-d05                    | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646c13d24488b9d7852e8605

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-hip=
07-d05.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-hip=
07-d05.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/646c13d24488b9d78=
52e8606
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0b9ef177aac1372e85ee

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/646c0b9ef177aac13=
72e85ef
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0e023bcae7f1c72e85eb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-juno-=
uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-juno-=
uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/646c0e023bcae7f1c=
72e85ec
        new failure (last pass: v5.10.177-cip31-33-gd59f246891e73) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 5          =


  Details:     https://kernelci.org/test/plan/id/646c0aebfa7c0662f02e86be

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/646c0aebfa7c0662f02e86c4
        failing since 61 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d)

    2023-05-23T00:37:55.347376  /lava-10419383/1/../bin/lava-test-case

    2023-05-23T00:37:55.375733  <8>[   40.173222] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/646c0aebfa7c0662f02e86c5
        failing since 61 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d)

    2023-05-23T00:37:54.290185  /lava-10419383/1/../bin/lava-test-case

    2023-05-23T00:37:54.312107  <8>[   39.109349] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.cros-ec-sysfs-driver-present: https://kernelci.org/=
test/case/id/646c0aebfa7c0662f02e86fa
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:37:49.754046  /lava-10419383/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.cros-ec-lightbar-driver-present: https://kernelci.o=
rg/test/case/id/646c0aebfa7c0662f02e8703
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:37:47.233530  <8>[   32.030579] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-keyb-probed RESULT=3Dpass>

    2023-05-23T00:37:48.257500  /lava-10419383/1/../bin/lava-test-case

    2023-05-23T00:37:48.284025  <8>[   33.081042] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-lightbar-driver-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.cros-ec-debugfs-driver-present: https://kernelci.or=
g/test/case/id/646c0aebfa7c0662f02e870c
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:37:44.768910  <8>[   29.566860] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtpm-chip-is-online RESULT=3Dskip>

    2023-05-23T00:37:45.826999  /lava-10419383/1/../bin/lava-test-case

    2023-05-23T00:37:45.853850  <8>[   30.651361] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-debugfs-driver-present RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 8          =


  Details:     https://kernelci.org/test/plan/id/646c0ca10854e00bf12e85f9

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50=
i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50=
i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.lima-driver-present: https://kernelci.org/test/case=
/id/646c0ca10854e00bf12e85fc
        new failure (last pass: v5.10.177-cip31-33-gd59f246891e73)

    2023-05-23T00:45:11.098704  /lava-498735/1/../bin/lava-test-case
    2023-05-23T00:45:11.210239  <8>[  108.270446] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlima-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun8i-mixer-driver-present: https://kernelci.org/te=
st/case/id/646c0ca10854e00bf12e85ff
        new failure (last pass: v5.10.177-cip31-33-gd59f246891e73)

    2023-05-23T00:45:08.633843  /lava-498735/1/../bin/lava-test-case
    2023-05-23T00:45:08.753765  <8>[  105.814382] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-phy-probed RESULT=3Dblocked>
    2023-05-23T00:45:09.776809  /lava-498735/1/../bin/lava-test-case
    2023-05-23T00:45:09.884232  <8>[  106.944239] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-mixer-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun8i-hdmi-phy-driver-present: https://kernelci.org=
/test/case/id/646c0ca10854e00bf12e8600
        new failure (last pass: v5.10.177-cip31-33-gd59f246891e73)

    2023-05-23T00:45:07.505116  /lava-498735/1/../bin/lava-test-case
    2023-05-23T00:45:07.611722  <8>[  104.670725] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-hdmi-phy-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sunxi-wdt-driver-present: https://kernelci.org/test=
/case/id/646c0ca10854e00bf12e8603
        new failure (last pass: v5.10.177-cip31-33-gd59f246891e73)

    2023-05-23T00:45:03.125155  /lava-498735/1/../bin/lava-test-case
    2023-05-23T00:45:03.869611  <8>[  100.930274] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsoc-crypto-probed RESULT=3Dblocked>
    2023-05-23T00:45:04.894228  /lava-498735/1/../bin/lava-test-case
    2023-05-23T00:45:05.066324  <8>[  102.126455] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsunxi-wdt-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun8i-ce-driver-present: https://kernelci.org/test/=
case/id/646c0ca10854e00bf12e8604
        new failure (last pass: v5.10.177-cip31-33-gd59f246891e73)

    2023-05-23T00:45:00.180432  /lava-498735/1/../bin/lava-test-case
    2023-05-23T00:45:00.407970  <8>[   97.469285] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsid-probed RESULT=3Dblocked>
    2023-05-23T00:45:01.428964  /lava-498735/1/../bin/lava-test-case
    2023-05-23T00:45:02.102809  <8>[   99.163289] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-ce-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.eeprom-sunxi-sid-driver-present: https://kernelci.o=
rg/test/case/id/646c0ca10854e00bf12e8605
        new failure (last pass: v5.10.177-cip31-33-gd59f246891e73)

    2023-05-23T00:44:59.038589  /lava-498735/1/../bin/lava-test-case
    2023-05-23T00:44:59.158435  <8>[   96.218512] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Deeprom-sunxi-sid-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun8i-dw-hdmi-driver-present: https://kernelci.org/=
test/case/id/646c0ca10854e00bf12e8608
        new failure (last pass: v5.10.177-cip31-33-gd59f246891e73)

    2023-05-23T00:44:55.542161  /lava-498735/1/../bin/lava-test-case
    2023-05-23T00:44:55.860283  <8>[   92.920788] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-dw-hdmi-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/646c0ca10854e00bf12e861f
        failing since 124 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-05-23T00:44:33.300486  <8>[   70.363745] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 498735_1.6.2.4.1>
    2023-05-23T00:44:33.470430  / # #
    2023-05-23T00:44:33.572529  export SHELL=3D/bin/sh
    2023-05-23T00:44:33.573010  #
    2023-05-23T00:44:33.674439  / # export SHELL=3D/bin/sh. /lava-498735/en=
vironment
    2023-05-23T00:44:33.674932  =

    2023-05-23T00:44:33.776561  / # . /lava-498735/environment/lava-498735/=
bin/lava-test-runner /lava-498735/1
    2023-05-23T00:44:33.777389  =

    2023-05-23T00:44:33.780408  / # /lava-498735/bin/lava-test-runner /lava=
-498735/1
    2023-05-23T00:44:33.964887  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 8          =


  Details:     https://kernelci.org/test/plan/id/646c0bdbf5764e9b512e85e6

  Results:     24 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50=
i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50=
i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.lima-driver-present: https://kernelci.org/test/case=
/id/646c0bdbf5764e9b512e85e9
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:41:54.988714  /lava-498715/1/../bin/lava-test-case
    2023-05-23T00:41:55.011591  <8>[   60.941865] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-phy-probed RESULT=3Dblocked>
    2023-05-23T00:41:56.034079  /lava-498715/1/../bin/lava-test-case
    2023-05-23T00:41:56.056595  <8>[   61.986893] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlima-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun8i-hdmi-phy-driver-present: https://kernelci.org=
/test/case/id/646c0bdbf5764e9b512e85ea
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:41:52.890348  /lava-498715/1/../bin/lava-test-case
    2023-05-23T00:41:52.915388  <8>[   58.846033] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-probed RESULT=3Dblocked>
    2023-05-23T00:41:53.939038  /lava-498715/1/../bin/lava-test-case
    2023-05-23T00:41:53.963116  <8>[   59.892545] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-hdmi-phy-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun8i-dw-hdmi-driver-present: https://kernelci.org/=
test/case/id/646c0bdbf5764e9b512e85eb
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:41:50.781793  /lava-498715/1/../bin/lava-test-case
    2023-05-23T00:41:50.805474  <8>[   56.735624] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-mixer-probed RESULT=3Dblocked>
    2023-05-23T00:41:51.828558  /lava-498715/1/../bin/lava-test-case
    2023-05-23T00:41:51.866770  <8>[   57.796199] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-dw-hdmi-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun8i-mixer-driver-present: https://kernelci.org/te=
st/case/id/646c0bdbf5764e9b512e85ec
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:41:48.686863  /lava-498715/1/../bin/lava-test-case
    2023-05-23T00:41:48.710559  <8>[   54.640827] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Danalog-audio-probed RESULT=3Dblocked>
    2023-05-23T00:41:49.733385  /lava-498715/1/../bin/lava-test-case
    2023-05-23T00:41:49.757233  <8>[   55.687042] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-mixer-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sun8i-ce-driver-present: https://kernelci.org/test/=
case/id/646c0bdbf5764e9b512e85ee
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:41:44.399337  /lava-498715/1/../bin/lava-test-case
    2023-05-23T00:41:44.424060  <8>[   50.354868] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dir-probed RESULT=3Dblocked>
    2023-05-23T00:41:45.447387  /lava-498715/1/../bin/lava-test-case
    2023-05-23T00:41:45.471406  <8>[   51.401311] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-ce-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sunxi-ir-driver-present: https://kernelci.org/test/=
case/id/646c0bdbf5764e9b512e85ef
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:41:43.350941  /lava-498715/1/../bin/lava-test-case
    2023-05-23T00:41:43.376256  <8>[   49.306197] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsunxi-ir-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sunxi-wdt-driver-present: https://kernelci.org/test=
/case/id/646c0bdbf5764e9b512e85f2
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:41:40.124403  /lava-498715/1/../bin/lava-test-case
    2023-05-23T00:41:40.145838  <8>[   46.077493] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsid-probed RESULT=3Dblocked>
    2023-05-23T00:41:41.169508  /lava-498715/1/../bin/lava-test-case
    2023-05-23T00:41:41.192325  <8>[   47.122233] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsunxi-wdt-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.eeprom-sunxi-sid-driver-present: https://kernelci.o=
rg/test/case/id/646c0bdbf5764e9b512e85f3
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:41:39.077129  /lava-498715/1/../bin/lava-test-case
    2023-05-23T00:41:39.101380  <8>[   45.030597] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Deeprom-sunxi-sid-driver-present RESULT=3Dfail>   =

 =20


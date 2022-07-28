Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024C0C25B07
	for <webhook@archiver.kernel.org>; Thu, 28 Jul 2022 10:40:27 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web09.31079.1659004823812078756
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 28 Jul 2022 03:40:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=rLfzhdVL;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id y15so1440807plp.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 28 Jul 2022 03:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=puZnFIXUpUNQmEgVXHkne3F5d9p7awpa8uu4t3aT+0c=;
        b=rLfzhdVLreNYAtQWtHY9vqPOKynpxqkZ8O+LK/IPNWSwZAXexZhxIWP7XNMIPwjlYv
         9o8f/EhAbiairaZ4PENaW0X+WP2i+vrmZMarGJef2ocF3ULdf89h3FZaPM7zfRS2ehbs
         2e3eN+AKaOXw7anMW6FJaU+1TmSVouQ1Epc8kOxrheDcIDwnbNpUiUhVkDMiimPAzJQs
         oi4rjdjdLBMs/8C9GZP3gdYuV+oE/+VFQ9uaKA5ZW43r3zpx6M+PDx9pcEOyY3aximaU
         a2XoIG3nKTQeOLerhbrGgMaHAQtbC8dWOwsM2bJZia5EJ+zAqgvTYHt5COBtY4Rk7XMx
         QGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=puZnFIXUpUNQmEgVXHkne3F5d9p7awpa8uu4t3aT+0c=;
        b=tQnbhqQ5FB33avimetbGNVf6loLhm8R9qN5Mt3/h9JZGnMbTCa2SspZCI5HLsaBX0f
         2F40mpRP91z8s0JpAcNtOksypksRPKadJijxIqu19eaHbnm1EO+pmsHTD8mFRD5xhsmi
         DxcRuSnvMmcHLKX8nRWREq98sb2LgOC9yuvVx3nfeuHmbiawpQdttrwdHMnhk2UHLurX
         AshzqBGCoP0c5Hps0iDGDPd22tfcLUw3zU0xv5/JtMK6ZEfVp/WGbNMziVbXKgWB5NNP
         e/ZyYeVHl6W8+cZdtUlWPOz1ZXjajWZsbREbDIu++ktN3amQXqjMbET9/gNCG0Gb1CKE
         N+ww==
X-Gm-Message-State: AJIora98jhse9lgOe9hePot8D7wXDOPT6a7ahvsougSJ8wV97vGxwB9x
	nW1riOnHqd7xvoT2N0uCfaPM2j8SkAG862PFppY=
X-Google-Smtp-Source: 
 AGRyM1s4C9Tb7vaK+/vVMMc6QltpfrRzSYp6b7CM8OjgyXO5TZYXSmXrnnZz1LMLUvSP2U01V3ENpA==
X-Received: by 2002:a17:902:70cc:b0:16c:60e0:50fb with SMTP id
 l12-20020a17090270cc00b0016c60e050fbmr25429062plt.156.1659004822978;
        Thu, 28 Jul 2022 03:40:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 u18-20020a17090341d200b0016dbdf7b97bsm868321ple.266.2022.07.28.03.40.22
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 03:40:22 -0700 (PDT)
Message-ID: <62e26796.170a0220.cc730.11b3@mx.google.com>
Date: Thu, 28 Jul 2022 03:40:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-585-gc99f2b257bde
Subject: cip-gitlab/ci/pavel/linux-test smc: 14 runs,
 9 regressions (v4.4-st5-585-gc99f2b257bde)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Jul 2022 10:40:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8970

cip-gitlab/ci/pavel/linux-test smc: 14 runs, 9 regressions (v4.4-st5-585-gc=
99f2b257bde)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm-virt-gicv3          | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv3          | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-585-gc99f2b257bde/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-585-gc99f2b257bde
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c99f2b257bde3cd60a833056aab624ad5fab3812 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b4913305adedc0daf059

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62e0b4913305adedc0daf05a
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/62e1c858d893940bf6daf05b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm64/defconfig/gcc-10/lab-broonie/smc-juno-ubo=
ot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm64/defconfig/gcc-10/lab-broonie/smc-juno-ubo=
ot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62e1c858d893940bf6daf05c
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b5468b4777a537daf05b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm/multi_v7_defconfig/gcc-10/lab-broonie/smc-q=
emu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm/multi_v7_defconfig/gcc-10/lab-broonie/smc-q=
emu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/armel/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62e0b5468b4777a537daf05c
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b6a2080c0d2cd6daf075

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm/multi_v7_defconfig/gcc-10/lab-collabora/smc=
-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm/multi_v7_defconfig/gcc-10/lab-collabora/smc=
-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/armel/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62e0b6a2080c0d2cd6daf076
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b096e4da64c7c8daf08a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm=
64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm=
64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62e0b096e4da64c7c8daf08b
        failing since 77 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b3cadc4da3cd4fdaf064

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm64/defconfig+arm64-chromebook/gcc-10/lab-bro=
onie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm64/defconfig+arm64-chromebook/gcc-10/lab-bro=
onie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62e0b3cadc4da3cd4fdaf065
        failing since 77 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b21f25bd0639c4daf06a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm64/defconfig/gcc-10/lab-collabora/smc-qemu_a=
rm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm64/defconfig/gcc-10/lab-collabora/smc-qemu_a=
rm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62e0b21f25bd0639c4daf06b
        failing since 77 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b3808f2659c50ddaf05c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm64/defconfig+arm64-chromebook/gcc-10/lab-col=
labora/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm64/defconfig+arm64-chromebook/gcc-10/lab-col=
labora/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62e0b3808f2659c50ddaf05d
        failing since 77 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b3bd16421b94efdaf065

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig/gcc-10/lab-collabora/sm=
c-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig/gcc-10/lab-collabora/sm=
c-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/x86/rootfs.cpio.gz =



  * smc.CVE-2020-0543: https://kernelci.org/test/case/id/62e0b3bd16421b94ef=
daf067
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFD4C6FD1F
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 13:27:13 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web11.42475.1679491632456889097
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 06:27:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=0TVpjB1G;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id h14so10340465pgj.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 06:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679491631;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DU3Z7PTHAmSd+0rXJvtC5OCfRAzKPqUrx0IJhnPFRZo=;
        b=0TVpjB1GYCvssNZ75pMYPRx0x5lRGSo3ycxGeudhhZgbjAu2wG/M2cwFdZtUNtrmWG
         e+IP0vdkq/R/e2fAKbbTgijIpKCemjHB9n7ScIPlrQr4FWXjn3zUSX4tge8IpQt+ms8e
         Ajlzq6dRirpzGpY7JFoIlrgXxe90G7CEdEePIRhqV3wQ4swKs2xqzdxSStRD/DPxnCwv
         Uwe/Uiool47aCuba+MRExovCkKO03odWOuS6XS+V+2WeDcK2PWVv5i62I1XsANXIBzur
         0k/ZiSuQmFF3FLvPenWtOGlrfsuNpXiHZUgDRXFabLj9ttojT1+DRBAT7Di974X4UpGB
         B2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679491631;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DU3Z7PTHAmSd+0rXJvtC5OCfRAzKPqUrx0IJhnPFRZo=;
        b=ccHItE5FRXEmolVDHuM60jzTee/k+mhe/ELI1L+d/WlDUaoHaX848VNP9nG3/shfM4
         n9qsj4xNBipWwx8XGcpEtXVaAS0bnmXbLbAFIq2AFKkbl481BBWeL712SaxjuGAm1x4Q
         wS4b3rqRhhWURs1XlsSbw+64eZQe3S2/4i4wTfZdxQpsc6bclHYHvDPVytB5R0yYMFF3
         8KwOA/Y669IhE3Kh20U+01xx7u8YWpchrxAOYHofiCNsKvV7lMo7UWkx33zEd7nV4hBl
         CGXjRvVvoYB2irKEuEb7qm9tdtJofEMyoUBsOWP6usaFsTBfWSEHODMSDcWXUfVd6Qko
         91eA==
X-Gm-Message-State: AO0yUKXii3sM+Kfh3J8Y0hOvnxEN6RV/9anD7/IDE5bUWkMRPhFvaUv2
	D7JCYuoeoe0XXejhuoSjGCaS/FmYBCoPzNAOwoozGQ==
X-Google-Smtp-Source: AK7set/UG+yZOeDnriS31g4yfObhtvjozgheVjCxdNnNmoqZzRzuEWDF133xQY88BmJr3DPr4m3y7Q==
X-Received: by 2002:a62:62c3:0:b0:5e0:a86:a76f with SMTP id w186-20020a6262c3000000b005e00a86a76fmr3202502pfb.0.1679491631334;
        Wed, 22 Mar 2023 06:27:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a23-20020a62bd17000000b005a91d570972sm7821420pff.41.2023.03.22.06.27.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 06:27:10 -0700 (PDT)
Message-ID: <641b022e.620a0220.129cf.d6b5@mx.google.com>
Date: Wed, 22 Mar 2023 06:27:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.175-cip29-rt12
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 35 runs,
 13 regressions (v5.10.175-cip29-rt12)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 13:27:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11077

cip-gitlab/ci/pavel/linux-test baseline-nfs: 35 runs, 13 regressions (v5.10=
.175-cip29-rt12)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.175-cip29-rt12/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.175-cip29-rt12
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0a6a8df2de5a8e8f024b47926cff286c6ec0e31f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641af95a3f3a9840919c950e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641af95a3f3a98409=
19c950f
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641af9701265ca6ee69c95a2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641af9701265ca6ee=
69c95a3
        failing since 0 day (last pass: v5.10.168-cip27-456-g42a59c4e5329, =
first fail: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641af96f1265ca6ee69c959f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641af96f1265ca6ee=
69c95a0
        failing since 0 day (last pass: v5.10.168-cip27-456-g42a59c4e5329, =
first fail: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641afe05f86b2ee2d59c9514

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nf=
s-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nf=
s-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641afe05f86b2ee2d=
59c9515
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/641afb1ce2bf6f9d029c9522

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-n=
fs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-n=
fs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641afb1ce2bf6f9d029c955b
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d)

    2023-03-22T12:56:10.105466  [   56.180947] <LAVA_SIGNAL_ENDRUN 0_dmesg =
206737_1.6.2.4.1>
    2023-03-22T12:56:10.375698  #
    2023-03-22T12:56:10.387297  / # #
    2023-03-22T12:56:10.503217  export SHELL=3D/bin/sh
    2023-03-22T12:56:10.616616  / # export SHELL=3D/bin/sh. /lava-206737/en=
vironment
    2023-03-22T12:56:10.624716  =

    2023-03-22T12:56:10.631025  / # . /lava-206737/environment
    2023-03-22T12:56:10.745330  /lava-206737/bin/lava-test-runner /lava-206=
737/1
    2023-03-22T12:56:10.759095  / # /lava-206737/bin/lava-test-runner /lava=
-206737/1
    2023-03-22T12:56:11.465480  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641af96f3f3a9840919c953b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-dell-latitude-5400-4305U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-dell-latitude-5400-4305U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641af96f3f3a98409=
19c953c
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641af96d3f3a9840919c9535

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-dell-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-dell-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641af96d3f3a98409=
19c9536
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641afa9ba7c2e8873d9c950f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641afa9ba7c2e8873=
d9c9510
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641b003762967636ce9c952b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nf=
s-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nf=
s-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641b003762967636c=
e9c952c
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641b0203c17b146bf69c9508

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nf=
s-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nf=
s-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641b0203c17b146bf=
69c9509
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/641afb76d0deba37b89c950f

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/641afb76d0deba37b89c9516
        failing since 0 day (last pass: v5.10.168-cip27-456-g42a59c4e5329, =
first fail: v4.19.277-cip94-1098-g26d9f86d942d)

    2023-03-22T12:58:08.388710  /lava-9729961/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/641afb76d0deba37b89c9558
        failing since 0 day (last pass: v5.10.168-cip27-456-g42a59c4e5329, =
first fail: v4.19.277-cip94-1098-g26d9f86d942d)

    2023-03-22T12:58:08.418926  <8>[   35.359797] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-03-22T12:58:09.456216  /lava-9729961/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641afc64457b5fe4ca9c9506

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50=
i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50=
i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641afc64457b5fe4ca9c9536
        failing since 62 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-03-22T13:01:59.657700  [   29.676672] <LAVA_SIGNAL_ENDRUN 0_dmesg =
206794_1.6.2.4.1>
    2023-03-22T13:01:59.768510  / # #
    2023-03-22T13:01:59.870739  export SHELL=3D/bin/sh
    2023-03-22T13:01:59.871326  #
    2023-03-22T13:01:59.972719  / # export SHELL=3D/bin/sh. /lava-206794/en=
vironment
    2023-03-22T13:01:59.973207  =

    2023-03-22T13:02:00.074965  / # . /lava-206794/environment/lava-206794/=
bin/lava-test-runner /lava-206794/1
    2023-03-22T13:02:00.075724  =

    2023-03-22T13:02:00.079059  / # /lava-206794/bin/lava-test-runner /lava=
-206794/1
    2023-03-22T13:02:00.222948  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20


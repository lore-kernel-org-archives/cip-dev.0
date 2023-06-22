Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CC5EB64D8
	for <webhook@archiver.kernel.org>; Thu, 22 Jun 2023 13:11:17 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.10912.1687439472846069698
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 22 Jun 2023 06:11:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=D9YXNBCp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-668711086f4so465427b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 22 Jun 2023 06:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687439472; x=1690031472;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oUamBKU2uOIlsf0QzNQ1rLcZCg2wlC9kKO1Hgrc07Ks=;
        b=D9YXNBCpPSub+S+Nj/oW0y7Ge6nOOPrkJX61DWLmkRtupg3RFSDxs02pEPRFuBYNPr
         UemjlSEkp/fBXW0K7JTrPWwDVUnfBBBmlg6Xw947KyY72LNPScIMqL+py8I0ITm/SxVb
         g1nJyfh8XgoJ1xGWeldwXyHC05/EA2bWKZWjbWhIvjUkXq+OtCJBi7JGcxcJ+tj3KERJ
         ZOd+G0n90+p3cwjP112A/vOB5oMulW4K8CB4vkGp//aaTh39nT+Dwc2lDkmaEwpEk2be
         ZObVJr7Q8WwJCPj6rDuyz34IzxjfGm20jAsWZWs8SG/b9/VrOcxe6JVa/3hwZ4BeB7zM
         8odA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687439472; x=1690031472;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUamBKU2uOIlsf0QzNQ1rLcZCg2wlC9kKO1Hgrc07Ks=;
        b=Ez1fZAusJ/P5Ky1H/9BtHj2VNO78J/DhwsupEwhPnk+GvjHXja0FGKYJrjGshb7tIg
         /GJwsPbi8LN3hRaznvCO0c4Kc2Xd/GAVn31pyhiqYL4d8U0Yx6r0YuqIhbeQww/uYeOB
         WyUYEL+Lk77uvlHGuUA8wo5lSGcoY1sca6lleouIa/eIhksLDTGwEtsv5wqJCEblzatH
         L+JweRG0eZH3tFh3DF/O/0jFL9mcl6Gt4ZRQZnP8J9Pdr6LV7TbpS564AKwygKrLpJZi
         camNhavBeZ0ZkMF7O5TRaQ7ipPpEUt+ZqAPkagfh7NF3Tjs+Mte+w+fJCEJnZZncOWw7
         /2Lw==
X-Gm-Message-State: AC+VfDwi+BOLZxXvmMTzV2cdsEjrxKsc38aR5o+QVUvs4sKjKuKPH8xX
	peizHKPTSrEmrgmsN/U4uhPniFrOyI/FOc6uz2a3Ng==
X-Google-Smtp-Source: ACHHUZ7IMx8alrhF1nkir8yF4xngLaRMo+9P+7E128ymgxLNBd0cgjz+hGRP/idkP983iYMS/J5jNw==
X-Received: by 2002:a05:6a00:1f11:b0:668:6ea8:7bac with SMTP id be17-20020a056a001f1100b006686ea87bacmr19158549pfb.13.1687439470566;
        Thu, 22 Jun 2023 06:11:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i14-20020aa78d8e000000b0064f708ca12asm4519570pfr.70.2023.06.22.06.11.09
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 06:11:09 -0700 (PDT)
Message-ID: <6494486d.a70a0220.e64af.9cc8@mx.google.com>
Date: Thu, 22 Jun 2023 06:11:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.31-61-g32a95f5a4e3b
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 38 runs,
 19 regressions (v6.1.31-61-g32a95f5a4e3b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jun 2023 13:11:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12127

cip-gitlab/ci/pavel/linux-test baseline-nfs: 38 runs, 19 regressions (v6.1.=
31-61-g32a95f5a4e3b)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

kontron-pitx-imx8m           | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 2          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.31-61-g32a95f5a4e3b/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.31-61-g32a95f5a4e3b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      32a95f5a4e3b66089d84743bbec9da44020328ba =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64943cda02c0046dc9306151

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64943cda02c0046dc=
9306152
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64943bf5e40d6f2d20306178

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64943bf5e40d6f2d20306181
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70)

    2023-06-22T12:17:51.111488  + set +x

    2023-06-22T12:17:51.118082  [   19.746457] <LAVA_SIGNAL_ENDRUN 0_dmesg =
10860310_1.5.2.3.1>

    2023-06-22T12:17:51.228523  / # #

    2023-06-22T12:17:51.331090  export SHELL=3D/bin/sh

    2023-06-22T12:17:51.331761  #

    2023-06-22T12:17:51.433030  / # export SHELL=3D/bin/sh. /lava-10860310/=
environment

    2023-06-22T12:17:51.433753  =


    2023-06-22T12:17:51.535374  / # . /lava-10860310/environment/lava-10860=
310/bin/lava-test-runner /lava-10860310/1

    2023-06-22T12:17:51.536531  =


    2023-06-22T12:17:51.542277  / # /lava-10860310/bin/lava-test-runner /la=
va-10860310/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64943beae40d6f2d2030613e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64943beae40d6f2d20306147
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70)

    2023-06-22T12:17:26.490714  + set +x[   18.228320] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10860321_1.5.2.3.1>

    2023-06-22T12:17:26.490888  =


    2023-06-22T12:17:26.596122  / # #

    2023-06-22T12:17:26.698911  export SHELL=3D/bin/sh

    2023-06-22T12:17:26.699713  #

    2023-06-22T12:17:26.801231  / # export SHELL=3D/bin/sh. /lava-10860321/=
environment

    2023-06-22T12:17:26.801562  =


    2023-06-22T12:17:26.902641  / # . /lava-10860321/environment/lava-10860=
321/bin/lava-test-runner /lava-10860321/1

    2023-06-22T12:17:26.903909  =


    2023-06-22T12:17:26.909271  / # /lava-10860321/bin/lava-test-runner /la=
va-10860321/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64943bdcb70fa0a70530615a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64943bdcb70fa0a705306163
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70)

    2023-06-22T12:17:26.095597  + set +x

    2023-06-22T12:17:26.102422  <8>[   18.090067] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10860305_1.5.2.3.1>

    2023-06-22T12:17:26.206318  / # #

    2023-06-22T12:17:26.306932  export SHELL=3D/bin/sh

    2023-06-22T12:17:26.307126  #

    2023-06-22T12:17:26.407767  / # export SHELL=3D/bin/sh. /lava-10860305/=
environment

    2023-06-22T12:17:26.408047  =


    2023-06-22T12:17:26.508792  / # . /lava-10860305/environment/lava-10860=
305/bin/lava-test-runner /lava-10860305/1

    2023-06-22T12:17:26.509135  =


    2023-06-22T12:17:26.514306  / # /lava-10860305/bin/lava-test-runner /la=
va-10860305/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/649438a2f9740cf50730614f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/multi_v5_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/multi_v5_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/649438a2f9740cf50=
7306150
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64943c442bf0035c1f306177

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/multi_v7_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/multi_v7_defconfig/gcc-10/lab-broonie/baselin=
e-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64943c442bf0035c1=
f306178
        failing since 14 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v4.4.302-cip74-rt43-218-g246f4be89a77) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64944073c942960ae2306143

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseli=
ne-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseli=
ne-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64944073c942960ae230617d
        failing since 8 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921e=
9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-06-22T12:36:47.970715  + set +x
    2023-06-22T12:36:47.974700  <8>[   65.138643] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 652495_1.6.2.4.1>
    2023-06-22T12:36:48.116428  / # #
    2023-06-22T12:36:48.218970  export SHELL=3D/bin/sh
    2023-06-22T12:36:48.219698  #
    2023-06-22T12:36:48.321507  / # export SHELL=3D/bin/sh. /lava-652495/en=
vironment
    2023-06-22T12:36:48.322230  =

    2023-06-22T12:36:48.424057  / # . /lava-652495/environment/lava-652495/=
bin/lava-test-runner /lava-652495/1
    2023-06-22T12:36:48.425650  =

    2023-06-22T12:36:48.429201  / # /lava-652495/bin/lava-test-runner /lava=
-652495/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64944496068b1dd006306140

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-n=
fs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-n=
fs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64944496068b1dd006306147
        failing since 8 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921e=
9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-06-22T12:54:17.964177  + set +x
    2023-06-22T12:54:17.968528  <8>[   43.117832] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 971315_1.6.2.4.1>
    2023-06-22T12:54:18.150679  / # #
    2023-06-22T12:54:18.253384  export SHELL=3D/bin/sh
    2023-06-22T12:54:18.254085  #
    2023-06-22T12:54:18.355923  / # export SHELL=3D/bin/sh. /lava-971315/en=
vironment
    2023-06-22T12:54:18.356673  =

    2023-06-22T12:54:18.458504  / # . /lava-971315/environment/lava-971315/=
bin/lava-test-runner /lava-971315/1
    2023-06-22T12:54:18.459689  =

    2023-06-22T12:54:18.465659  / # /lava-971315/bin/lava-test-runner /lava=
-971315/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64943bd64bec101d95306189

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64943bd64bec101d95306192
        failing since 7 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921e=
9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-06-22T12:17:16.870858  + <8>[   18.509301] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10860300_1.5.2.3.1>

    2023-06-22T12:17:16.870946  set +x

    2023-06-22T12:17:16.975243  / # #

    2023-06-22T12:17:17.075778  export SHELL=3D/bin/sh

    2023-06-22T12:17:17.076064  #

    2023-06-22T12:17:17.176518  / # export SHELL=3D/bin/sh. /lava-10860300/=
environment

    2023-06-22T12:17:17.176735  =


    2023-06-22T12:17:17.277248  / # . /lava-10860300/environment/lava-10860=
300/bin/lava-test-runner /lava-10860300/1

    2023-06-22T12:17:17.277569  =


    2023-06-22T12:17:17.282442  / # /lava-10860300/bin/lava-test-runner /la=
va-10860300/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64943be43a5540535730612e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64943be43a55405357306137
        failing since 7 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921e=
9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-06-22T12:17:15.764634  + set +x<8>[   17.365820] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10860362_1.5.2.3.1>

    2023-06-22T12:17:15.764739  =


    2023-06-22T12:17:15.869114  / # #

    2023-06-22T12:17:15.969687  export SHELL=3D/bin/sh

    2023-06-22T12:17:15.969911  #

    2023-06-22T12:17:16.070472  / # export SHELL=3D/bin/sh. /lava-10860362/=
environment

    2023-06-22T12:17:16.070654  =


    2023-06-22T12:17:16.171141  / # . /lava-10860362/environment/lava-10860=
362/bin/lava-test-runner /lava-10860362/1

    2023-06-22T12:17:16.171461  =


    2023-06-22T12:17:16.176976  / # /lava-10860362/bin/lava-test-runner /la=
va-10860362/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64943bd6336ef7d999306161

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64943bd6336ef7d99930616a
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70)

    2023-06-22T12:17:24.374504  + <8>[   17.977049] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10860353_1.5.2.3.1>

    2023-06-22T12:17:24.374589  set +x

    2023-06-22T12:17:24.479127  / # #

    2023-06-22T12:17:24.579660  export SHELL=3D/bin/sh

    2023-06-22T12:17:24.579798  #

    2023-06-22T12:17:24.680246  / # export SHELL=3D/bin/sh. /lava-10860353/=
environment

    2023-06-22T12:17:24.680394  =


    2023-06-22T12:17:24.781092  / # . /lava-10860353/environment/lava-10860=
353/bin/lava-test-runner /lava-10860353/1

    2023-06-22T12:17:24.781970  =


    2023-06-22T12:17:24.786760  / # /lava-10860353/bin/lava-test-runner /la=
va-10860353/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/649444c2893dc1225e306156

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/ba=
seline-nfs-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/ba=
seline-nfs-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/649444c2893dc1225=
e306157
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/649442a613375f961d306139

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-nfs-imx6dl-riotboard.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-nfs-imx6dl-riotboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/649442a613375f961d306142
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70)

    2023-06-22T12:46:23.017700  + set[   27.986930] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 985388_1.6.2.3.1>
    2023-06-22T12:46:23.017920   +x
    2023-06-22T12:46:23.129891  / # #
    2023-06-22T12:46:23.231483  export SHELL=3D/bin/sh
    2023-06-22T12:46:23.231934  #
    2023-06-22T12:46:23.333096  / # export SHELL=3D/bin/sh. /lava-985388/en=
vironment
    2023-06-22T12:46:23.333601  =

    2023-06-22T12:46:23.434871  / # . /lava-985388/environment/lava-985388/=
bin/lava-test-runner /lava-985388/1
    2023-06-22T12:46:23.435470  =

    2023-06-22T12:46:23.438255  / # /lava-985388/bin/lava-test-runner /lava=
-985388/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6494457473a09ea8bb306142

  Results:     60 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-j=
uno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-j=
uno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6494457473a09ea8bb306181
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70)

    2023-06-22T12:58:11.705750  =

    2023-06-22T12:58:11.807034  / # #export SHELL=3D/bin/sh
    2023-06-22T12:58:11.807431  =

    2023-06-22T12:58:11.908578  / # export SHELL=3D/bin/sh. /lava-652457/en=
vironment
    2023-06-22T12:58:11.908943  =

    2023-06-22T12:58:12.010123  / # . /lava-652457/environment/lava-652457/=
bin/lava-test-runner /lava-652457/1
    2023-06-22T12:58:12.010720  =

    2023-06-22T12:58:12.019474  / # /lava-652457/bin/lava-test-runner /lava=
-652457/1
    2023-06-22T12:58:12.131546  + export TESTRUN_ID=3D1_bootrr
    2023-06-22T12:58:12.175372  + cd /lava-652457/1/tests/1_bootrr =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
kontron-pitx-imx8m           | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 2          =


  Details:     https://kernelci.org/test/plan/id/64943f105a5aff3b24306134

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm64/defconfig/gcc-10/lab-kontron/baseline-nfs-k=
ontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm64/defconfig/gcc-10/lab-kontron/baseline-nfs-k=
ontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64943f105a5aff3b2430613b
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-22T12:30:43.648275  / # #
    2023-06-22T12:30:43.750178  export SHELL=3D/bin/sh
    2023-06-22T12:30:43.750924  #
    2023-06-22T12:30:43.852664  / # export SHELL=3D/bin/sh. /lava-363239/en=
vironment
    2023-06-22T12:30:43.853452  =

    2023-06-22T12:30:43.955385  / # . /lava-363239/environment/lava-363239/=
bin/lava-test-runner /lava-363239/1
    2023-06-22T12:30:43.956612  =

    2023-06-22T12:30:43.960841  / # /lava-363239/bin/lava-test-runner /lava=
-363239/1
    2023-06-22T12:30:44.184929  + export TESTRUN_ID=3D1_bootrr
    2023-06-22T12:30:44.185446  + cd /lava-363239/1/tests/1_bootrr =

    ... (10 line(s) more)  =


  * baseline-nfs.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id=
/64943f105a5aff3b2430614b
        new failure (last pass: v6.1.26-1314-g1ab0ac1d7e2e3)

    2023-06-22T12:30:48.119252  /lava-363239/1/../bin/lava-test-case
    2023-06-22T12:30:48.167232  <8>[   21.798865] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64943be3e40d6f2d2030612e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab=
-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64943be3e40d6f2d20306137
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70)

    2023-06-22T12:17:17.168917  [   18.106130] <LAVA_SIGNAL_ENDRUN 0_dmesg =
10860333_1.5.2.3.1>

    2023-06-22T12:17:17.273383  / # #

    2023-06-22T12:17:17.374122  export SHELL=3D/bin/sh

    2023-06-22T12:17:17.374506  #

    2023-06-22T12:17:17.475221  / # export SHELL=3D/bin/sh. /lava-10860333/=
environment

    2023-06-22T12:17:17.475402  =


    2023-06-22T12:17:17.576090  / # . /lava-10860333/environment/lava-10860=
333/bin/lava-test-runner /lava-10860333/1

    2023-06-22T12:17:17.576410  =


    2023-06-22T12:17:17.581338  / # /lava-10860333/bin/lava-test-runner /la=
va-10860333/1

    2023-06-22T12:17:17.628987  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64943f235a5aff3b243061e3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a77=
4a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a77=
4a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64943f235a5aff3b243061ea
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70)

    2023-06-22T12:31:12.983837  + set +x
    2023-06-22T12:31:12.984061  [   48.200652] <LAVA_SIGNAL_ENDRUN 0_dmesg =
971295_1.6.2.4.1>
    2023-06-22T12:31:13.220167  / # #
    2023-06-22T12:31:14.682442  export SHELL=3D/bin/sh
    2023-06-22T12:31:14.703018  #
    2023-06-22T12:31:14.703229  / # export SHELL=3D/bin/sh
    2023-06-22T12:31:16.588891  / # . /lava-971295/environment
    2023-06-22T12:31:20.046243  /lava-971295/bin/lava-test-runner /lava-971=
295/1
    2023-06-22T12:31:20.066968  . /lava-971295/environment
    2023-06-22T12:31:20.067081  / # /lava-971295/bin/lava-test-runner /lava=
-971295/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64943e5fd62f6b357830614b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs=
-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.31-61-g32a95f5a4e3b/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs=
-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64943e5fd62f6b3578306154
        new failure (last pass: v5.10.182-cip35-8-g2391124f19a70)

    2023-06-22T12:27:59.183293  / # #

    2023-06-22T12:28:00.447594  export SHELL=3D/bin/sh

    2023-06-22T12:28:00.458632  #

    2023-06-22T12:28:02.205106  / # export SHELL=3D/bin/sh. /lava-10860400/=
environment

    2023-06-22T12:28:02.216167  =


    2023-06-22T12:28:02.216681  / # . /lava-10860400/environment

    2023-06-22T12:28:05.403238  /lava-10860400/bin/lava-test-runner /lava-1=
0860400/1

    2023-06-22T12:28:05.418638  / # /lava-10860400/bin/lava-test-runner /la=
va-10860400/1

    2023-06-22T12:28:05.577485  + export TESTRUN_ID=3D1_bootrr

    2023-06-22T12:28:05.577585  + cd /lava-10860400/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51BEC77B7A
	for <webhook@archiver.kernel.org>; Fri, 26 May 2023 07:58:02 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.3386.1685087880445374704
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 26 May 2023 00:58:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=5PmoBVAM;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ae74ab3089so3053195ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 26 May 2023 00:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685087879; x=1687679879;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9xQGijyDfZNr+LgZ5FOuv4b1U1JbXQRFHzCKntkspzM=;
        b=5PmoBVAMJZ1V1B1W6e1Djrw/1/3C5l6uOqj/n8xNFhEjayE3QVpRdLRgeNUy0BIz0m
         VytAxaZ+s6NNo4nQdZk6Z6Jjq0TIDFcXyXgGC83U6O9ApOCjgajZ4J498Gmd01lQ6E+B
         vsgJ4L8QPS5aXxHUm9Og/HtSWa6ECrBFRyt5KURLOF3+8DYnWdGkylWNQG3QrErILaA1
         pIZ03aYWfc7oQcTs26XjRVkmhtXymOv3A6pOhEaRUk6yr3p4SxnwVNA603KSqKy4A46V
         joHhIyqr+5zDiEkxegkCy2OSinQwhplaqEQl974HChzNwtsRdZ76BU57R+ITe6xb06ay
         LHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685087879; x=1687679879;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9xQGijyDfZNr+LgZ5FOuv4b1U1JbXQRFHzCKntkspzM=;
        b=cUbmvTJavl94qeogXPAqYw9cgKmOBCw3Qq4IqzZb+hWVD6hQwPQ6ty9WjpSPk4B4sm
         P7JQogjEE99cFelPwM7qKIo6yud1GyTp9BBm1vWbLh5LVaooGfTAn2kWyhx6i0fKq2ja
         srkAGkIGyu3RpFykupLfqC0U4IEiEtzy6/yhcE2BfvO1b8BJPhdjGnkZnCVfJTbvn6gW
         bME+LGPzvPFCdDxEEUnx3ToqzVQ7xZ9xHc0ZTu1JRk/QTYsGjegPIunHIi9u87bndQN6
         uu0qVHEI8+7NRJwrA6gKHdOUJXfbemyghBOlr+QZLmRXOzTZY47uNVvFRQ7Wci7xTXbd
         6CrA==
X-Gm-Message-State: AC+VfDxRtVABBag4FkOVoTCjwKI8JcsCR03Rv6qnIR7UYiKPE7cW3guJ
	7QQkIwUqcdhgel6rSHUPRq4ij7qVIduUoOZXfqZf7Q==
X-Google-Smtp-Source: ACHHUZ4MZBjHTrL+LYTZ4pO8kqHXDe6V31NNxBHB1JLb4G57ML620VaHvFHoWYMan41yud1SxXtlbg==
X-Received: by 2002:a17:902:f391:b0:1ad:e746:ca50 with SMTP id f17-20020a170902f39100b001ade746ca50mr1584062ple.2.1685087879065;
        Fri, 26 May 2023 00:57:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o8-20020a1709026b0800b001ac94b33ab1sm2600936plk.304.2023.05.26.00.57.58
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 00:57:58 -0700 (PDT)
Message-ID: <64706686.170a0220.f7a94.5d90@mx.google.com>
Date: Fri, 26 May 2023 00:57:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.180-cip33-21-g090289427e8b2
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 75 runs,
 10 regressions (v5.10.180-cip33-21-g090289427e8b2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 May 2023 07:58:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11649

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 75 runs, 10 regres=
sions (v5.10.180-cip33-21-g090289427e8b2)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig+kselftest | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.180-cip33-21-g090289427e8b2/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.180-cip33-21-g090289427e8b2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      090289427e8b2be9dac126c4d1b760b100f2c6b8 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6470600d992f2e1ddb2e8692

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm/multi_v7_defconfig+kself=
test/gcc-10/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm/multi_v7_defconfig+kself=
test/gcc-10/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6470600d992f2e1dd=
b2e8693
        new failure (last pass: v5.10.179-cip32-384-g291adc46abef0) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6470585bb672ae73982e85eb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr=
-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr=
-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6470585bb672ae73982e85f0
        failing since 35 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-26T06:57:24.308797  + set +x

    2023-05-26T06:57:24.315068  <8>[   28.327956] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10462485_1.5.2.3.1>

    2023-05-26T06:57:24.426792  / # #

    2023-05-26T06:57:24.529105  export SHELL=3D/bin/sh

    2023-05-26T06:57:24.529335  #

    2023-05-26T06:57:24.629845  / # export SHELL=3D/bin/sh. /lava-10462485/=
environment

    2023-05-26T06:57:24.630007  =


    2023-05-26T06:57:24.730548  / # . /lava-10462485/environment/lava-10462=
485/bin/lava-test-runner /lava-10462485/1

    2023-05-26T06:57:24.730809  =


    2023-05-26T06:57:24.735337  / # /lava-10462485/bin/lava-test-runner /la=
va-10462485/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64705a0f6f36e1d2fd2e860a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oct=
opus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oct=
opus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64705a0f6f36e1d2fd2e860f
        failing since 35 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-26T07:04:31.692505  + set[   22.674053] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10462669_1.5.2.3.1>

    2023-05-26T07:04:31.695563   +x

    2023-05-26T07:04:31.799969  / # #

    2023-05-26T07:04:31.900662  export SHELL=3D/bin/sh

    2023-05-26T07:04:31.900865  #

    2023-05-26T07:04:32.001437  / # export SHELL=3D/bin/sh. /lava-10462669/=
environment

    2023-05-26T07:04:32.001823  =


    2023-05-26T07:04:32.102547  / # . /lava-10462669/environment/lava-10462=
669/bin/lava-test-runner /lava-10462669/1

    2023-05-26T07:04:32.103103  =


    2023-05-26T07:04:32.107678  / # /lava-10462669/bin/lava-test-runner /la=
va-10462669/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647058207330ea00ef2e8603

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.t=
xt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647058207330ea00ef2e8608
        failing since 35 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-26T06:56:18.848721  + set[   21.481844] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10462526_1.5.2.3.1>

    2023-05-26T06:56:18.848875   +x

    2023-05-26T06:56:18.954823  / # #

    2023-05-26T06:56:19.055739  export SHELL=3D/bin/sh

    2023-05-26T06:56:19.056072  #

    2023-05-26T06:56:19.156745  / # export SHELL=3D/bin/sh. /lava-10462526/=
environment

    2023-05-26T06:56:19.157056  =


    2023-05-26T06:56:19.257735  / # . /lava-10462526/environment/lava-10462=
526/bin/lava-test-runner /lava-10462526/1

    2023-05-26T06:56:19.258237  =


    2023-05-26T06:56:19.262879  / # /lava-10462526/bin/lava-test-runner /la=
va-10462526/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647059ee7bf726753e2e8602

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/647059ee7bf726753e2e8607
        failing since 35 days (last pass: v5.10.168-cip27-109-g23841ec76bec=
, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-26T07:03:46.884631  + set +x

    2023-05-26T07:03:46.891687  [   20.180577] <LAVA_SIGNAL_ENDRUN 0_dmesg =
10462682_1.5.2.3.1>

    2023-05-26T07:03:46.995927  / # #

    2023-05-26T07:03:47.096565  export SHELL=3D/bin/sh

    2023-05-26T07:03:47.096751  #

    2023-05-26T07:03:47.197229  / # export SHELL=3D/bin/sh. /lava-10462682/=
environment

    2023-05-26T07:03:47.197476  =


    2023-05-26T07:03:47.298004  / # . /lava-10462682/environment/lava-10462=
682/bin/lava-test-runner /lava-10462682/1

    2023-05-26T07:03:47.298277  =


    2023-05-26T07:03:47.303182  / # /lava-10462682/bin/lava-test-runner /la=
va-10462682/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647061dc8090544ed52e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647061dc8090544ed=
52e85e7
        failing since 8 days (last pass: v5.10.177-cip31-122-gfb6ca504156b4=
, first fail: v5.10.179-cip32-384-g291adc46abef0) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/647059dfb0b1283deb2e860b

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/647059dfb0b1283deb2e8636
        failing since 35 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-26T07:03:51.037292  [   36.564088] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-05-26T07:03:52.089170  /lava-10462614/1/../bin/lava-test-case

    2023-05-26T07:03:52.119363  [   37.647245] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/647059dfb0b1283deb2e8637
        failing since 35 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-26T07:03:49.949976  [   35.477017] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-05-26T07:03:51.001885  /lava-10462614/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/647062f9d7fb2173e12e8603

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230519.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/647062f9d7fb2173e12e8609
        failing since 35 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-26T07:42:41.098052  /lava-10462921/1/../bin/lava-test-case

    2023-05-26T07:42:41.173331  <8>[  108.244286] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/647062f9d7fb2173e12e860a
        failing since 35 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-26T07:42:39.005505  /lava-10462921/1/../bin/lava-test-case

    2023-05-26T07:42:39.939678  <8>[  107.009847] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20


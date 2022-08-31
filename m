Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4889ECAAD4
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 14:18:01 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web12.26156.1661955480573882619
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 07:18:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=sZ2h6FUo;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id
 n65-20020a17090a5ac700b001fbb4fad865so15145911pji.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 07:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=yXUQRFcQW5yOOupicRVa4AsfYvc/d8123YfBmmrrzR4=;
        b=sZ2h6FUotsIdbioP93PqxQcoloC5mbWD1R/Q2WtzoV+XdnJ+VAh84cKTnv7bKNnjUx
         R4WMDrsrTjtm5ElchEoRNW79M7h92g1OC6BjsWb9GI55hamAaiIj5cHYf9csTAsp3kmQ
         pe+X3JsRiRCTH34pgy06XgBNZtDpYeRxmK2Uwpa321PD0Bb522n5KQXOFhqMR9Mj0gYe
         CSkFteBTNYK6/hN6mJw00RWTGwzo+lcIl7GUpB0/HM/MmCFU3c7ARL/C0tI/xrG1UBgC
         HpXzoU1be52GrzU2kZmXri9NFm+YnkCWDtC+4gF/FoH8DnrGUcAmcuO82JEMfcyW/BYN
         fkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=yXUQRFcQW5yOOupicRVa4AsfYvc/d8123YfBmmrrzR4=;
        b=3Cp0VhaKpk2/Sjs9zqnZQ8+SmibS+JzlzKb3addijANeUbQ3eYGeB1CpjKypRYDld4
         hMdntd4OH4qC8Cy/vViATUHAX4nXv8xPtxtjTv7waa1KePdfDYI9vLDrCvTbOqBq/hXd
         /iQ2lGii0miRo+F+Q0Or5AUd9y9YqnJmtTmYZodUFUcXMdoKxfTMB6h68bEMw3rCDz/2
         ukuCV/NiEQR7s9sYRuPGhfizbUT1VQb5zmv2GG/oz4xz/G92L/GACzanNpJeHfgZuYu9
         jfhzzrxdNsOU3xVvgjUV+dzRbUbFaW66NNY2dvEK0RFCBiHmJQFV1H4A10gyAW8XfpM2
         HUHg==
X-Gm-Message-State: ACgBeo0EAqpEZmHZ5MRDFZJVYUJoqLvpkHgGmPQ4VQYwJoCJfL70vZd7
	u8ZJVC0v02KDNNzbryqO6x7f/FbvB+WCrXtGpZA=
X-Google-Smtp-Source: 
 AA6agR5t0xG9NKvYY+gjGFAB4lR80vKBmb/b47rq1I7Fx7XXWTyE88NwCbYANvPNA6mhSWdBiZnzhw==
X-Received: by 2002:a17:90b:4a02:b0:1fe:2b10:f5a3 with SMTP id
 kk2-20020a17090b4a0200b001fe2b10f5a3mr3595555pjb.186.1661955479898;
        Wed, 31 Aug 2022 07:17:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 e11-20020a170902784b00b00173164792aasm11723966pln.127.2022.08.31.07.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 07:17:59 -0700 (PDT)
Message-ID: <630f6d97.170a0220.d634.54ea@mx.google.com>
Date: Wed, 31 Aug 2022 07:17:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.256-cip80
Subject: cip/linux-4.19.y-cip smc: 14 runs, 6 regressions (v4.19.256-cip80)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 14:18:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9348

cip/linux-4.19.y-cip smc: 14 runs, 6 regressions (v4.19.256-cip80)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.256-cip80/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.256-cip80
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e5c44c8629fdb37d31546d9544b68fef7292f810 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/630f5f517db064f2a8355644

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.256=
-cip80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.256=
-cip80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/630f5f517db064f2a8=
355650
        failing since 53 days (last pass: v4.19.249-cip76, first fail: v4.1=
9.251-cip77)

    2022-08-31T13:16:52.942184  <8>[   11.731747] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/630f5f517db064f2a8=
355651
        failing since 53 days (last pass: v4.19.249-cip76, first fail: v4.1=
9.251-cip77)

    2022-08-31T13:16:52.931193  <8>[   11.720889] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/630f654c36e69445ab355696

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.256=
-cip80/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.256=
-cip80/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/630f654c36e69445ab355697
        failing since 8 days (last pass: v4.19.226-cip66, first fail: v4.19=
.255-cip79) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/630f65b092d02ec6b2355646

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.256=
-cip80/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/smc-qemu_arm64-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.256=
-cip80/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/smc-qemu_arm64-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/630f65b092d02ec6b2355647
        failing since 8 days (last pass: v4.19.226-cip66, first fail: v4.19=
.255-cip79) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/630f5d989ea480f17735568b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.256=
-cip80/arm64/defconfig/gcc-10/lab-collabora/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.256=
-cip80/arm64/defconfig/gcc-10/lab-collabora/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/630f5d989ea480f17735568c
        failing since 8 days (last pass: v4.19.226-cip66, first fail: v4.19=
.255-cip79) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/630f60907ff36d693035566e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.256=
-cip80/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/smc-qemu_arm64=
-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.256=
-cip80/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/smc-qemu_arm64=
-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/630f60907ff36d693035566f
        failing since 8 days (last pass: v4.19.226-cip66, first fail: v4.19=
.255-cip79) =

 =20


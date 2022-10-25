Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD686C38A2D
	for <webhook@archiver.kernel.org>; Tue, 25 Oct 2022 16:59:39 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web10.410.1666717173808876080
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 25 Oct 2022 09:59:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=eOPynYsz;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id k22so733810pfd.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 25 Oct 2022 09:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4eRta0EAIAvI/L8DxyKASvuRYqG5kHobXfXwcSvBz9I=;
        b=eOPynYszb7DMz0Sy5D42VRuJ4SZ9YsVG7eHm2kRrZNWNaCpn1fB76XF89vg/JWCjeQ
         vBSymDgu36lDXxkhP/dn1WS9pD/L4U4Y7EP8ZasPK7pqMvFw3DImjomPG8hPSKv+7cns
         Fm0+yVmuMRW2vTEkFAlQPBMcRn576EJSpxraE7WRCI19SW6nBDLix4H94ZqGN3bi8HkW
         bTR4Rawvxa0V57dku/y9E5mv7Wnqa0j7AB5MbYdEs5i48lEik5fwi4NHLoH3RFJf3XjL
         f++ZomU3OfHr7hNnOkY6gm3rt5DymprH26qiYYrHQ3qKbHjQq9Jecsn0yqItxPjgMWC+
         U7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4eRta0EAIAvI/L8DxyKASvuRYqG5kHobXfXwcSvBz9I=;
        b=o7Z05UC5p2jL2UCC05/Af61d+svJTKuelB0M59zAc3/UcWY3dE6qalui9+ETaprBjD
         Zaysj65fGSzsSLYhOMeQjpS+pEeywpOE8FDJKm+jjGNuMBa3iisrHQ5iAlTSpQKiru4w
         Qxvs5a1jKTzMS+324UQWysuJl7GJXCpKdyIoQ83nhtHQXM4PHzkgy/CWXJIDcAwoT+Ag
         LU9EpQQjNgmjb3tWED2A1cff3r/EwalFT9gKR6spngjpUjEc0uhlihhfPozGXX7eZ3I4
         Y56ZhQC3YL6GO8SOKTeqCzCfVt5oAFch/Ufz8lbkNgIu8NkNJsNUNA9Dqygjr2cli2QI
         tFXQ==
X-Gm-Message-State: ACrzQf2dGKhPygLCh2fdVGVkcId5sjvp8TpL4JxsviBR/y0o1u7jX33H
	e1NZZyfn4j//+I/BbPWYXDTQMIcCpbXlEKg0
X-Google-Smtp-Source: AMsMyM7eDnE9Qk6PQM+2HjxJAkY4vb958zRCykWOnN1d/G+Ruxuh1o7IdcazGPQ+mPsjPxKJt9AEIA==
X-Received: by 2002:a65:6d93:0:b0:42c:50ec:8025 with SMTP id bc19-20020a656d93000000b0042c50ec8025mr32698352pgb.62.1666717172844;
        Tue, 25 Oct 2022 09:59:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7958e000000b0056b9cd24403sm1595754pfj.214.2022.10.25.09.59.32
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 09:59:32 -0700 (PDT)
Message-ID: <635815f4.a70a0220.1fae6.375d@mx.google.com>
Date: Tue, 25 Oct 2022 09:59:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-518-gc75907dbbb95a
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 39 runs,
 5 regressions (v5.10.145-518-gc75907dbbb95a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Oct 2022 16:59:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9837

cip-gitlab/ci/pavel/linux-test baseline-nfs: 39 runs, 5 regressions (v5.10.=
145-518-gc75907dbbb95a)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 3          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.145-518-gc75907dbbb95a/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.145-518-gc75907dbbb95a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c75907dbbb95a00b6b5fd298e65585204cf96ea5 =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config        | 1          =


  Details:     https://kernelci.org/test/plan/id/635809265711a3b1105e5b4a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-518-gc75907dbbb95a/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-518-gc75907dbbb95a/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221007.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/635809265711a3b11=
05e5b4b
        new failure (last pass: v5.10.145-cip17-421-g0d804ef4a611) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63580bf317e5dcaf665e5b64

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-518-gc75907dbbb95a/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-518-gc75907dbbb95a/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221007.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63580bf317e5dcaf6=
65e5b65
        new failure (last pass: v5.10.145-cip17-rt7) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 3          =


  Details:     https://kernelci.org/test/plan/id/63580b2d102278138f5e5b62

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-518-gc75907dbbb95a/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-518-gc75907dbbb95a/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221007.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.cros-ec-sensors-gyro0-probed: https://kernelci.org/=
test/case/id/63580b2d102278138f5e5ba9
        failing since 168 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a)

    2022-10-25T16:13:20.041385  <8>[   93.940206] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-accel1-probed RESULT=3Dfail>
    2022-10-25T16:13:21.085225  /lava-7715809/1/../bin/lava-test-case   =


  * baseline-nfs.bootrr.cros-ec-sensors-accel1-probed: https://kernelci.org=
/test/case/id/63580b2d102278138f5e5baa
        failing since 168 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a)

    2022-10-25T16:13:20.004797  /lava-7715809/1/../bin/lava-test-case   =


  * baseline-nfs.bootrr.cros-ec-sensors-accel0-probed: https://kernelci.org=
/test/case/id/63580b2d102278138f5e5bab
        failing since 168 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a)

    2022-10-25T16:13:17.880528  <8>[   91.779476] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-driver-present RESULT=3Dpass>
    2022-10-25T16:13:18.926919  /lava-7715809/1/../bin/lava-test-case
    2022-10-25T16:13:18.962224  <8>[   92.862249] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-accel0-probed RESULT=3Dfail>   =

 =20


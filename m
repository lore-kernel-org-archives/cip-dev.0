Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5C2C4332F
	for <webhook@archiver.kernel.org>; Wed,  4 Jan 2023 12:52:03 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web10.11173.1672836720545900893
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 04 Jan 2023 04:52:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=4hVsDK7T;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.172, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f172.google.com with SMTP id e10so8230242pgc.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 04 Jan 2023 04:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EH8MW3nmmQmM1Tx+QIRMTi/fjnwZlY81Cw0LToMgnCQ=;
        b=4hVsDK7TJ9wOv2RWHsBzc86/jSAq7YDeayWoYvGy1unjGWT77wpryPSiNv7pOmIPKJ
         fr1DsYHWdt9E/UNvirC29ZvvFqcrqBzVyPuiJHOcoVmPh8YgDxgRu0sTplDHbh8EFZH+
         SXQ1O1WBauNV8KzYK2o6oppmYAk10EvGf+g4jYMNziQPnsNao7kU4Wt25ioVHKlyXxvH
         lhIZWb+TBIMmw8xLSC+KEU2M6zzb6vT1MXPuzQ4Qus1bx/bY9dqgbwpedXsdC/5N0vxp
         OQihVk8brPGAbqe/8AneSp0SEoStINpWm5dLgAoDMmC5Hf98Yd2PXMImBkhLf6f0G0db
         ttTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EH8MW3nmmQmM1Tx+QIRMTi/fjnwZlY81Cw0LToMgnCQ=;
        b=MsgN8a4iot+j0e5igTNkaI3DJ+JYpbgBuXsjVeSik23JC04XAcOhWUGAziByFYD9mo
         XCM8K1T3pwGFRYDpTYDq30kBSa/c5O/xIuh33TCHC/98AljFizAdm5oWzZrTYgxXeRX4
         ZV45LXhuj6A1ABAIbKKrvsH9GNv7sDBGQ/wfs44MbwtnZGIN22acCGKrlBrGBcgeImOE
         UwuXvnfp+qR67cRtf0WL4ZcyP+jyayLbbDMpSLAH9SNyf3QzHUHrb23cbslOB8pCoGNT
         YEPvM8gXEp+bSxCOj180J5WJevDIZAj39BI4s2N2i7A524e1oXDrSS1y+mG3Tqj2+X9B
         bT6A==
X-Gm-Message-State: AFqh2kq/pIDYhpOYtgl+QenYBC6T2Rx4CZM4RWoWHgkrIPJWSimHxX8J
	740ZL3UoaMdOruTAN8c6BlMjSfZ0OcEmTmT2msc=
X-Google-Smtp-Source: AMrXdXt6iolSvcvocPI4YjwiqY7EY3aH0VykUsFrrvBqoFSjwA8cHIf9NeDifMJV4veeBV9IhaWhtQ==
X-Received: by 2002:a05:6a00:301e:b0:581:254d:7a45 with SMTP id ay30-20020a056a00301e00b00581254d7a45mr32291291pfb.9.1672836719568;
        Wed, 04 Jan 2023 04:51:59 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w3-20020a63fb43000000b00476799699e4sm16635395pgj.30.2023.01.04.04.51.59
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 04:51:59 -0800 (PST)
Message-ID: <63b5766f.630a0220.e0177.9266@mx.google.com>
Date: Wed, 04 Jan 2023 04:51:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.161-cip23-65-gca8c192cb189
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 119 runs,
 4 regressions (v5.10.161-cip23-65-gca8c192cb189)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jan 2023 12:52:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10301

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 119 runs, 4 regression=
s (v5.10.161-cip23-65-gca8c192cb189)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig        | 1          =

beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig        | 1          =

r8a7743-iwg20d-q7        | arm   | lab-cip     | gcc-10   | shmobile_defcon=
fig         | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.161-cip23-65-gca8c192cb189/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.161-cip23-65-gca8c192cb189
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ca8c192cb189c6be84da2274a96e73320a638b43 =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/63b56e0a87de851d974eee33

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm/omap2plus_defconfig/gcc-1=
0/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm/omap2plus_defconfig/gcc-1=
0/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221230.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63b56e0a87de851d974eee38
        new failure (last pass: v5.10.155-cip21-405-g26d566555c3de)

    2023-01-04T12:15:56.633879  <8>[   19.308276] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 46282_1.5.2.4.1>
    2023-01-04T12:15:56.742485  / # #
    2023-01-04T12:15:56.844836  export SHELL=3D/bin/sh
    2023-01-04T12:15:56.845243  #
    2023-01-04T12:15:56.946959  / # export SHELL=3D/bin/sh. /lava-46282/env=
ironment
    2023-01-04T12:15:56.947464  =

    2023-01-04T12:15:57.048969  / # . /lava-46282/environment/lava-46282/bi=
n/lava-test-runner /lava-46282/1
    2023-01-04T12:15:57.049974  =

    2023-01-04T12:15:57.053400  / # /lava-46282/bin/lava-test-runner /lava-=
46282/1
    2023-01-04T12:15:57.161733  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-cip     | gcc-10   | omap2plus_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/63b56e15a0967575274eee32

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm/omap2plus_defconfig/gcc-1=
0/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm/omap2plus_defconfig/gcc-1=
0/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221230.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63b56e15a0967575274eee35
        new failure (last pass: v5.10.155-cip21-405-g26d566555c3de)

    2023-01-04T12:16:07.862895  <8>[   13.106082] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 816054_1.5.2.4.1>
    2023-01-04T12:16:07.971346  / # #
    2023-01-04T12:16:08.072793  export SHELL=3D/bin/sh
    2023-01-04T12:16:08.073114  #
    2023-01-04T12:16:08.174259  / # export SHELL=3D/bin/sh. /lava-816054/en=
vironment
    2023-01-04T12:16:08.174567  =

    2023-01-04T12:16:08.275727  / # . /lava-816054/environment/lava-816054/=
bin/lava-test-runner /lava-816054/1
    2023-01-04T12:16:08.276242  =

    2023-01-04T12:16:08.283281  / # /lava-816054/bin/lava-test-runner /lava=
-816054/1
    2023-01-04T12:16:08.385640  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a7743-iwg20d-q7        | arm   | lab-cip     | gcc-10   | shmobile_defcon=
fig         | 1          =


  Details:     https://kernelci.org/test/plan/id/63b56b5dd3e43b052f4eee21

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm/shmobile_defconfig/gcc-10=
/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm/shmobile_defconfig/gcc-10=
/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221230.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63b56b5dd3e43b052f4ee=
e22
        failing since 70 days (last pass: v5.10.147-cip18-56-g87bd4289362be=
, first fail: v5.10.147-cip18-12-g7bc9523ecfb7f) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63b5755ba662fe30fd4eee30

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221230.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63b5755ba662fe30fd4ee=
e31
        new failure (last pass: v5.10.158-cip22-142-g79bb6f9db05d) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FBAC4828D
	for <webhook@archiver.kernel.org>; Wed, 31 Jan 2024 12:51:07 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.web10.13078.1706705466806604966
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Jan 2024 04:51:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=RYeW5xwv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.174, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so4358014a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 31 Jan 2024 04:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706705466; x=1707310266; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zedwLvDJz1UKqABYcDpDNm32K6Ny1ydvetiFHXog+8Y=;
        b=RYeW5xwvUguVLfwGJ5Fb2KxhjzTHM5AEKLwGIbOA2pM3B30m2YKsIbMQ9W3E0+MzIK
         Pdi3i4NRTkZsI1coz6zhXEq6WUobFbVgRm8YtFZ/lsOQCv4DpZUlVamGjf5UNCZtV+RL
         V9Cf1kLI+iGSYBLdKxSVpW5e84+r3TQHEDRddzyf8rmU7BrKIf8Cj8pfpSUiDZOltkc9
         f9uOY9j1p17+/+QDV+OG2BTXdNKGIvjcGbNz54KGGt/Ch0pqCnQS16LFkwYuwrOHKAfk
         rx0l4tabukk/eDQxpoFDS9Iq0c7v8iLtVmYQVkUnow/vNGOI+6yj6bBtevGYvWmWC5sH
         mySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706705466; x=1707310266;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zedwLvDJz1UKqABYcDpDNm32K6Ny1ydvetiFHXog+8Y=;
        b=lPJz6kLRscVWgEoER4msC/+piEhFjJrnJE3iPPFmnDOurjn9AzZA3vfJ7sTOhxle+q
         pQ8y8TTnKQLrZEmhqOd616k8rn5NmjQwLmGXENJgX6wvByhSdvtpiPmHrNv+/GVzVp39
         D4ZGp3n/80F5RQZmfGOvmJDGKMdmbFe3WDGNEwgjX0YnK2GVSqbXlj7yrNctElGpekgW
         ojF6TfrO5/wKVNmzZweNvConLKpxkV7Rkw1a/hC5dxqACg+DfJ5QmR+eZXCJ24dYOzdm
         RQ7/4/4UatvfK+XMRdbD3flFfZLCtQx+Ddx+F4EoTSSM4ucHso0ES34zj5/iwrXvRQ5e
         Ntvw==
X-Gm-Message-State: AOJu0Yw2RMNq3YnGsLyc4VtwlBoyhUP7RaL71eiJRouImkQ0PE9/HDFT
	USi4aedUiGdbbyJyDGLtaaMyA7bAyW9Kv1VXln5FJEGR+LJbHDP3I/silwumICaEssw9wrUDRzg
	Z
X-Google-Smtp-Source: AGHT+IHBZ0wloTiz7yNvabURmdJXBwSVnnA1pBWkSv6ySSaZ58O8SCKkp7s5ropcb72DsfJnfybcug==
X-Received: by 2002:a05:6a20:8f01:b0:19a:ef21:60a0 with SMTP id b1-20020a056a208f0100b0019aef2160a0mr1642317pzk.25.1706705465710;
        Wed, 31 Jan 2024 04:51:05 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m18-20020a170902db1200b001d8accb025fsm16276plx.197.2024.01.31.04.51.04
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 04:51:04 -0800 (PST)
Message-ID: <65ba4238.170a0220.2d3d8.0149@mx.google.com>
Date: Wed, 31 Jan 2024 04:51:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.72-cip13-32-gf60d2e8cb51c
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 102 runs,
 7 regressions (v6.1.72-cip13-32-gf60d2e8cb51c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jan 2024 12:51:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14562

cip-gitlab/ci/pavel/linux-test baseline: 102 runs, 7 regressions (v6.1.72-c=
ip13-32-gf60d2e8cb51c)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

imx8mp-evk                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.72-cip13-32-gf60d2e8cb51c/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.72-cip13-32-gf60d2e8cb51c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f60d2e8cb51c9da65ffcfe73144286c27725ceea =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65ba32b244a2dc55f500a08d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65ba32b244a2dc55f500a096
        failing since 12 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-01-31T11:44:40.453291  + set<8>[   11.686004] <LAVA_SIGNAL_ENDRUN =
0_dmesg 12669178_1.4.2.3.1>

    2024-01-31T11:44:40.453384   +x

    2024-01-31T11:44:40.558014  / # #

    2024-01-31T11:44:40.658605  export SHELL=3D/bin/sh

    2024-01-31T11:44:40.658754  #

    2024-01-31T11:44:40.759374  / # export SHELL=3D/bin/sh. /lava-12669178/=
environment

    2024-01-31T11:44:40.759516  =


    2024-01-31T11:44:40.860140  / # . /lava-12669178/environment/lava-12669=
178/bin/lava-test-runner /lava-12669178/1

    2024-01-31T11:44:40.860448  =


    2024-01-31T11:44:40.865230  / # /lava-12669178/bin/lava-test-runner /la=
va-12669178/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65ba32ab213832889f00a055

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65ba32ab213832889f00a05e
        failing since 12 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-01-31T11:44:28.489069  + set +x

    2024-01-31T11:44:28.495227  <8>[   10.833055] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12669212_1.4.2.3.1>

    2024-01-31T11:44:28.599898  / # #

    2024-01-31T11:44:28.700466  export SHELL=3D/bin/sh

    2024-01-31T11:44:28.700648  #

    2024-01-31T11:44:28.801160  / # export SHELL=3D/bin/sh. /lava-12669212/=
environment

    2024-01-31T11:44:28.801367  =


    2024-01-31T11:44:28.902024  / # . /lava-12669212/environment/lava-12669=
212/bin/lava-test-runner /lava-12669212/1

    2024-01-31T11:44:28.902309  =


    2024-01-31T11:44:28.906553  / # /lava-12669212/bin/lava-test-runner /la=
va-12669212/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65ba32bd06896b9f7300a03b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65ba32bd06896b9f7300a044
        failing since 12 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-01-31T11:44:42.444908  + set<8>[    8.549041] <LAVA_SIGNAL_ENDRUN =
0_dmesg 12669224_1.4.2.3.1>

    2024-01-31T11:44:42.444992   +x

    2024-01-31T11:44:42.549564  / # #

    2024-01-31T11:44:42.650275  export SHELL=3D/bin/sh

    2024-01-31T11:44:42.650479  #

    2024-01-31T11:44:42.750985  / # export SHELL=3D/bin/sh. /lava-12669224/=
environment

    2024-01-31T11:44:42.751180  =


    2024-01-31T11:44:42.851711  / # . /lava-12669224/environment/lava-12669=
224/bin/lava-test-runner /lava-12669224/1

    2024-01-31T11:44:42.852018  =


    2024-01-31T11:44:42.856639  / # /lava-12669224/bin/lava-test-runner /la=
va-12669224/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx8mp-evk                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65ba31e63581931cde00a047

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm64/defconfig/gcc-10/lab-broonie/baseline=
-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm64/defconfig/gcc-10/lab-broonie/baseline=
-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65ba31e63581931cde00a050
        failing since 34 days (last pass: v5.10.201-cip41-77-g545d45774209f=
, first fail: v6.1.66-cip11-rt6-10-g38253b8903b4)

    2024-01-31T11:41:09.703980  + set<8>[   21.170060] <LAVA_SIGNAL_ENDRUN =
0_dmesg 526585_1.5.2.4.1>
    2024-01-31T11:41:09.704562   +x
    2024-01-31T11:41:09.812896  / # #
    2024-01-31T11:41:10.979182  export SHELL=3D/bin/sh
    2024-01-31T11:41:10.985349  #
    2024-01-31T11:41:12.484305  / # export SHELL=3D/bin/sh. /lava-526585/en=
vironment
    2024-01-31T11:41:12.490441  =

    2024-01-31T11:41:15.213644  / # . /lava-526585/environment/lava-526585/=
bin/lava-test-runner /lava-526585/1
    2024-01-31T11:41:15.220321  =

    2024-01-31T11:41:15.223909  / # /lava-526585/bin/lava-test-runner /lava=
-526585/1 =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65ba32b1213832889f00a062

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65ba32b1213832889f00a06b
        failing since 12 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-01-31T11:44:41.862112  + <8>[   11.437665] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 12669193_1.4.2.3.1>

    2024-01-31T11:44:41.862196  set +x

    2024-01-31T11:44:41.965506  / # #

    2024-01-31T11:44:42.066098  export SHELL=3D/bin/sh

    2024-01-31T11:44:42.066251  #

    2024-01-31T11:44:42.166764  / # export SHELL=3D/bin/sh. /lava-12669193/=
environment

    2024-01-31T11:44:42.166913  =


    2024-01-31T11:44:42.267432  / # . /lava-12669193/environment/lava-12669=
193/bin/lava-test-runner /lava-12669193/1

    2024-01-31T11:44:42.267667  =


    2024-01-31T11:44:42.272411  / # /lava-12669193/bin/lava-test-runner /la=
va-12669193/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65ba395d230f2a846200a03d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-collabora/baseline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-collabora/baseline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65ba395d230f2a846200a=
03e
        new failure (last pass: v6.1.66-cip11-rt6-10-g38253b8903b4) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65ba33963d6e5c089f00a08d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm64/defconfig/gcc-10/lab-cip/baseline-r8a=
774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.72-cip13-32-gf60d2e8cb51c/arm64/defconfig/gcc-10/lab-cip/baseline-r8a=
774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65ba33963d6e5c089f00a096
        new failure (last pass: v4.19.299-cip105-1134-gc868d5e4adaa)

    2024-01-31T11:48:21.287727  / # #
    2024-01-31T11:48:22.747782  export SHELL=3D/bin/sh
    2024-01-31T11:48:22.768809  #
    2024-01-31T11:48:22.769378  / # export SHELL=3D/bin/sh
    2024-01-31T11:48:24.721036  / # . /lava-1085440/environment
    2024-01-31T11:48:28.312571  /lava-1085440/bin/lava-test-runner /lava-10=
85440/1
    2024-01-31T11:48:28.334205  . /lava-1085440/environment
    2024-01-31T11:48:28.334591  / # /lava-1085440/bin/lava-test-runner /lav=
a-1085440/1
    2024-01-31T11:48:28.424487  + export 'TESTRUN_ID=3D1_bootrr'
    2024-01-31T11:48:28.425030  + cd /lava-1085440/1/tests/1_bootrr =

    ... (26 line(s) more)  =

 =20


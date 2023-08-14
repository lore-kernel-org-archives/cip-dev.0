Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30005EB64DD
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 00:59:00 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.98138.1691974738440530167
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 13 Aug 2023 17:58:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=km+g6n5y;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1bc7e65ea44so25386835ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 13 Aug 2023 17:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691974737; x=1692579537;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8YWfsh/hCRYviQ4i3Fi4O6tDWfgAxbBFRJomBGRKPfU=;
        b=km+g6n5ylu95VrmtH6uCwm2ODMDL4TSvzo1e/BysTQe6heRCNuEz9S9PTYFghgTJFj
         m+WS6vPFYMWZ7iupFYTMKnzDn9oaO8j8eYS+uZEPT8Iq2ymC0XUyHcLP9fIbQAg8W8Qr
         xhHhmlzv4Q+9rPLQ9kMMOENZjSdJaagLapKRN21aYhmZBPMwO3iomy67oAaJVfDM8fge
         uNNCcRHhBwFYWfytSupSXypx4bpPDmTf2KIHjclPW6YH9Qe8kyfTSxO5b9WIHw8Gtt01
         7IgoXTUebOw846IMoxRHNdThMlBdifxTl4iMY5etjTV03rwQ8L9XkuSiODhISPa7zku7
         XtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691974737; x=1692579537;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8YWfsh/hCRYviQ4i3Fi4O6tDWfgAxbBFRJomBGRKPfU=;
        b=DG7cemeKPHAgGwMU7xZTYeoCu5hi99ld5j1lR6cWQVIWI2kfbbEx3AyGmp9hHbJ3xX
         YOln0WUPWzPt5pcoraSNSStd/zR9dG25q4MKFunohsJuEio//r1W24XO4h33AOzMdRpq
         DAxZw9YdCDk2zPX7jyd/Qy1t7Z1Unx/by02cfrXQdFFNK+NENZS2rz3lojVdqPrOfqR+
         VI1Mq5l8J0nc461dHohU/3BG10Oj3Kv8oUSBN9+aigTRqvIyaGIT8adhyp8ybQ63/pim
         Uxl4YCcUQoGrnqY0mTtgFstygoG5kAIRP9GeZZ+U9bAnCkO/X2eDiNyCQ/6cYXDin0Cp
         cwXg==
X-Gm-Message-State: AOJu0Yzd4TV4eoIq4u9epQ+voGqKEpk4cnsCqnFFu3YwfsYQsK6zkdY4
	SmfT3FHtrWzWlxuRjn3zfDwOE7mwjyFBAjOwPp5EPztL
X-Google-Smtp-Source: AGHT+IEtaDFyyMu7sGpXTX8Shj6N19DXapIZiR2HxmNvIXfNRmRrNVyd1vMExMtOLlnnVOs3mdhXAA==
X-Received: by 2002:a17:903:22c9:b0:1b8:a936:1915 with SMTP id y9-20020a17090322c900b001b8a9361915mr11366139plg.22.1691974737332;
        Sun, 13 Aug 2023 17:58:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n22-20020a170902969600b001b5247cac3dsm7969498plp.110.2023.08.13.17.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 17:58:56 -0700 (PDT)
Message-ID: <64d97c50.170a0220.502a0.df1c@mx.google.com>
Date: Sun, 13 Aug 2023 17:58:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.45-cip3
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
Subject: cip/linux-6.1.y-cip baseline: 135 runs, 5 regressions (v6.1.45-cip3)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 00:59:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12623

cip/linux-6.1.y-cip baseline: 135 runs, 5 regressions (v6.1.45-cip3)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
acer-chromebox-cxi4-puff | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

juno-uboot               | arm64  | lab-broonie   | gcc-10   | cip://6.1.y-=
c...64_defconfig | 2          =

r8a77960-ulcb            | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =

sun50i-h6-pine-h64       | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.45-cip3/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.45-cip3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      9854793aeaee837123cc2be25bbdf869fa5ba5e8 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
acer-chromebox-cxi4-puff | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d96fcf7470560de735b1fe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.45-ci=
p3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-ace=
r-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.45-ci=
p3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-ace=
r-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d96fcf7470560de735b=
1ff
        new failure (last pass: v6.1.42-cip2-1-g47d13938e615) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
juno-uboot               | arm64  | lab-broonie   | gcc-10   | cip://6.1.y-=
c...64_defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64d970a4f7d754e53235b23c

  Results:     55 PASS, 5 FAIL, 1 SKIP
  Full config: cip://6.1.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.45-ci=
p3/arm64/cip---6.1.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie/base=
line-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.45-ci=
p3/arm64/cip---6.1.y-cip-arm64-qemu_arm64_defconfig/gcc-10/lab-broonie/base=
line-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case/id/=
64d970a4f7d754e53235b26c
        failing since 14 days (last pass: v6.1.31-65-ge66be31505fa, first f=
ail: v6.1.42-cip2)

    2023-08-14T00:08:50.929257  /lava-50542/1/../bin/lava-test-case
    2023-08-14T00:08:50.968969  <8>[   35.065020] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>
    2023-08-14T00:08:50.969519  /lava-50542/1/../bin/lava-test-case   =


  * baseline.bootrr.ethernet-probed: https://kernelci.org/test/case/id/64d9=
70a4f7d754e53235b26e
        failing since 14 days (last pass: v6.1.31-65-ge66be31505fa, first f=
ail: v6.1.42-cip2)

    2023-08-14T00:08:49.874298  /lava-50542/1/../bin/lava-test-case
    2023-08-14T00:08:49.899384  <8>[   34.011602] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dethernet-probed RESULT=3Dfail>
    2023-08-14T00:08:49.899939  /lava-50542/1/../bin/lava-test-case   =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a77960-ulcb            | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9746ad6504adcd135b1d9

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.45-ci=
p3/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.45-ci=
p3/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d9746ad6504adcd135b1de
        failing since 14 days (last pass: v6.1.31-46-g4cc1cc26e90f, first f=
ail: v6.1.42-cip2)

    2023-08-14T00:26:28.411309  / # #

    2023-08-14T00:26:28.513495  export SHELL=3D/bin/sh

    2023-08-14T00:26:28.514198  #

    2023-08-14T00:26:28.615650  / # export SHELL=3D/bin/sh. /lava-11280987/=
environment

    2023-08-14T00:26:28.616359  =


    2023-08-14T00:26:28.717860  / # . /lava-11280987/environment/lava-11280=
987/bin/lava-test-runner /lava-11280987/1

    2023-08-14T00:26:28.718984  =


    2023-08-14T00:26:28.735432  / # /lava-11280987/bin/lava-test-runner /la=
va-11280987/1

    2023-08-14T00:26:28.783718  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-14T00:26:28.784226  + cd /lav<8>[   19.114639] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11280987_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
sun50i-h6-pine-h64       | arm64  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/64d97469d4bf82194b35b22c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.45-ci=
p3/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.45-ci=
p3/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d97469d4bf82194b35b231
        failing since 14 days (last pass: v6.1.31-53-g486caac40d06, first f=
ail: v6.1.42-cip2)

    2023-08-14T00:26:38.622530  / # #

    2023-08-14T00:26:38.724852  export SHELL=3D/bin/sh

    2023-08-14T00:26:38.725645  #

    2023-08-14T00:26:38.827075  / # export SHELL=3D/bin/sh. /lava-11280977/=
environment

    2023-08-14T00:26:38.827842  =


    2023-08-14T00:26:38.929311  / # . /lava-11280977/environment/lava-11280=
977/bin/lava-test-runner /lava-11280977/1

    2023-08-14T00:26:38.930527  =


    2023-08-14T00:26:38.946926  / # /lava-11280977/bin/lava-test-runner /la=
va-11280977/1

    2023-08-14T00:26:39.013973  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-14T00:26:39.014488  + cd /lava-11280977/1/tests/1_boot<8>[   16=
.990199] <LAVA_SIGNAL_STARTRUN 1_bootrr 11280977_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20


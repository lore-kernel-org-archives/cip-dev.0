Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F533C77B73
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 11:30:12 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.5164.1685964604548951800
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 04:30:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=15m6aAGZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1b1806264e9so23587065ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 04:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685964603; x=1688556603;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lItI0rXqsZn28B0U3eFAkAKIrcDtWJcwxyff8VQinko=;
        b=15m6aAGZrerIEbHW/o472/xPIiC5BQeJwePsHQdZpOc/P3XjirLHxtzTNBZ4TZQ3Nx
         ou6vYbWS8cUWrJL9FLBPLupDVQ0Faezd2jMjwFa2LSifFm6tE6tR9opWCxPkNyVWqvCN
         IMjbeBb5rgcTMifnwMnQEtu9WbBwaKeAVWGRezFVL+2vzk/LXb8RpkozPlACF5lQB84C
         xYMY1C1EKdhxqTuTL20wEdKczP2TdWRiNFfWEy5qz6pWuowPDpRKXURhfVuZLPhzJLK/
         yxkqnwM8PHrA0R31he/SZp1EHDOgIusHpuNm0XFZoc804viXKopQvSUocZg7dOpmajc7
         LfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685964603; x=1688556603;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lItI0rXqsZn28B0U3eFAkAKIrcDtWJcwxyff8VQinko=;
        b=X8/AiMLevG0KxXR4Xg6H1Z8/PYl6aNX/mScH9TMH4cEWko1T9RG5A/caz5SeQcLZ3G
         UbTQAiMpknY/vrzEJh/+MnI60raXI/+r9UX78wQ1Rv4MO7sfIZ/ZiSBMuilb2P1BmOTy
         GeEjq1ZQkFFqRKEdEasPODo0OzyzprViuSrBFdHCaYTIK3KMVjfIdKFbrttGDeD5na2h
         ag6qpljuJ1THUnh5fg4Hofn5lfqw6HuPWTXcTxYR+Y0h7KKTWhlvotu4oUVNGCqQ1uRO
         cC5zInPrC1fwBNPzYKKqf8CE/R31vkvmhShFSJpcTKiNlQPzZj/fucPZpo8rlxapBY+o
         uRoA==
X-Gm-Message-State: AC+VfDwhWw3zK7JqbuvAa0FMGkNnohvqYGWxbVb8F6yzX8HkUwHsKdjT
	QSgIsqVULzs1M0FLXPvga+vVdWHaeSWFy3z2H6v41Q==
X-Google-Smtp-Source: ACHHUZ4MsKlIkjCKt93kh5WZo9IYp0xbETkDFALmv4CSrM3UC7Wys46YNCbagKCjweeCOAgnJNDYlg==
X-Received: by 2002:a17:902:b218:b0:1b2:48c:4db with SMTP id t24-20020a170902b21800b001b2048c04dbmr1739654plr.38.1685964603157;
        Mon, 05 Jun 2023 04:30:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b001ab0b2dad2fsm6351121plg.211.2023.06.05.04.30.02
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 04:30:02 -0700 (PDT)
Message-ID: <647dc73a.170a0220.d5b28.ab41@mx.google.com>
Date: Mon, 05 Jun 2023 04:30:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1298-g61395b9756bd5
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline: 114 runs,
 13 regressions (v6.1.26-1298-g61395b9756bd5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 11:30:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11805

cip-gitlab/ci/pavel/linux-test baseline: 114 runs, 13 regressions (v6.1.26-=
1298-g61395b9756bd5)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

imx8mn-ddr4-evk              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1298-g61395b9756bd5/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1298-g61395b9756bd5
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      61395b9756bd5614e204ba22b9c75fd47c24a999 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647dbb550f054801b9f5de25

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647dbb550f054801b9f5de2e
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-05T10:39:06.972006  + set<8>[    8.814088] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10590848_1.4.2.3.1>

    2023-06-05T10:39:06.972109   +x

    2023-06-05T10:39:07.075846  / # #

    2023-06-05T10:39:07.176398  export SHELL=3D/bin/sh

    2023-06-05T10:39:07.176562  #

    2023-06-05T10:39:07.277028  / # export SHELL=3D/bin/sh. /lava-10590848/=
environment

    2023-06-05T10:39:07.277190  =


    2023-06-05T10:39:07.377659  / # . /lava-10590848/environment/lava-10590=
848/bin/lava-test-runner /lava-10590848/1

    2023-06-05T10:39:07.377908  =


    2023-06-05T10:39:07.382929  / # /lava-10590848/bin/lava-test-runner /la=
va-10590848/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647dbe0af52380f171f5de3f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls=
1088a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls=
1088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647dbe0af52380f171f5de46
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-05T10:50:17.922087  + [   18.657057] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1233516_1.5.2.4.1>
    2023-06-05T10:50:17.922408  set +x
    2023-06-05T10:50:18.029402  / # #
    2023-06-05T10:50:18.131444  export SHELL=3D/bin/sh
    2023-06-05T10:50:18.131926  #
    2023-06-05T10:50:18.233290  / # export SHELL=3D/bin/sh. /lava-1233516/e=
nvironment
    2023-06-05T10:50:18.233760  =

    2023-06-05T10:50:18.335140  / # . /lava-1233516/environment/lava-123351=
6/bin/lava-test-runner /lava-1233516/1
    2023-06-05T10:50:18.335874  =

    2023-06-05T10:50:18.337877  / # /lava-1233516/bin/lava-test-runner /lav=
a-1233516/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647dbb3c6ece4235eff5deb7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647dbb3c6ece4235eff5dec0
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-05T10:38:36.434627  + set +x

    2023-06-05T10:38:36.441261  <8>[   11.422487] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10590815_1.4.2.3.1>

    2023-06-05T10:38:36.545509  / # #

    2023-06-05T10:38:36.646073  export SHELL=3D/bin/sh

    2023-06-05T10:38:36.646249  #

    2023-06-05T10:38:36.746712  / # export SHELL=3D/bin/sh. /lava-10590815/=
environment

    2023-06-05T10:38:36.746927  =


    2023-06-05T10:38:36.847427  / # . /lava-10590815/environment/lava-10590=
815/bin/lava-test-runner /lava-10590815/1

    2023-06-05T10:38:36.847683  =


    2023-06-05T10:38:36.852144  / # /lava-10590815/bin/lava-test-runner /la=
va-10590815/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647dbb1ab3257abc45f5de29

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647dbb1ab3257abc45f5de32
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-05T10:38:02.897850  + set<8>[   10.217780] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10590826_1.4.2.3.1>

    2023-06-05T10:38:02.898426   +x

    2023-06-05T10:38:03.006158  #

    2023-06-05T10:38:03.007348  =


    2023-06-05T10:38:03.109061  / # #export SHELL=3D/bin/sh

    2023-06-05T10:38:03.109789  =


    2023-06-05T10:38:03.211258  / # export SHELL=3D/bin/sh. /lava-10590826/=
environment

    2023-06-05T10:38:03.211946  =


    2023-06-05T10:38:03.313477  / # . /lava-10590826/environment/lava-10590=
826/bin/lava-test-runner /lava-10590826/1

    2023-06-05T10:38:03.314781  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647dbb4c5c26b85cedf5de66

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647dbb4c5c26b85cedf5de6f
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-05T10:38:34.250146  + set<8>[    8.613842] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10590816_1.4.2.3.1>

    2023-06-05T10:38:34.250234   +x

    2023-06-05T10:38:34.354187  / # #

    2023-06-05T10:38:34.454940  export SHELL=3D/bin/sh

    2023-06-05T10:38:34.455156  #

    2023-06-05T10:38:34.555640  / # export SHELL=3D/bin/sh. /lava-10590816/=
environment

    2023-06-05T10:38:34.555882  =


    2023-06-05T10:38:34.656457  / # . /lava-10590816/environment/lava-10590=
816/bin/lava-test-runner /lava-10590816/1

    2023-06-05T10:38:34.656838  =


    2023-06-05T10:38:34.661193  / # /lava-10590816/bin/lava-test-runner /la=
va-10590816/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647dbae49901f5faabf5de25

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/=
baseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/=
baseline-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647dbae49901f5faabf5de2e
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-05T10:37:00.418954  + set +x
    2023-06-05T10:37:00.419422  [   12.831519] <LAVA_SIGNAL_ENDRUN 0_dmesg =
967507_1.5.2.3.1>
    2023-06-05T10:37:00.528452  / # #
    2023-06-05T10:37:00.630199  export SHELL=3D/bin/sh
    2023-06-05T10:37:00.630668  #
    2023-06-05T10:37:00.731950  / # export SHELL=3D/bin/sh. /lava-967507/en=
vironment
    2023-06-05T10:37:00.732465  =

    2023-06-05T10:37:00.833879  / # . /lava-967507/environment/lava-967507/=
bin/lava-test-runner /lava-967507/1
    2023-06-05T10:37:00.834567  =

    2023-06-05T10:37:00.837873  / # /lava-967507/bin/lava-test-runner /lava=
-967507/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647dbd62f5730eb18cf5de6a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647dbd62f5730eb18cf5d=
e6b
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647dbcfe9caf2c3b09f5de4c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647dbcfe9caf2c3b09f5d=
e4d
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647dbd1adf35232faaf5de46

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/baselin=
e-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/baselin=
e-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647dbd1adf35232faaf5d=
e47
        failing since 0 day (last pass: v5.10.179-cip32-471-g18129e1b68691,=
 first fail: v6.1.26-1302-g2631206dd75c2) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647dbb346ece4235eff5de9a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline=
-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline=
-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647dbb346ece4235eff5dea1
        failing since 74 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f6=
, first fail: v5.10.175-cip29-rt12)

    2023-06-05T10:38:19.962339  + set +x<8>[   33.541469] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1233510_1.5.2.4.1>
    2023-06-05T10:38:19.962666  =

    2023-06-05T10:38:20.071668  / # #
    2023-06-05T10:38:21.231933  export SHELL=3D/bin/sh
    2023-06-05T10:38:21.237585  #
    2023-06-05T10:38:21.237858  / # export SHELL=3D/bin/sh
    2023-06-05T10:38:22.785579  / # . /lava-1233510/environment
    2023-06-05T10:38:25.613434  /lava-1233510/bin/lava-test-runner /lava-12=
33510/1
    2023-06-05T10:38:25.619482  . /lava-1233510/environment
    2023-06-05T10:38:25.619772  / # /lava-1233510/bin/lava-test-runner /lav=
a-1233510/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx8mn-ddr4-evk              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647dbde7750d968bfff5de8d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm64/defconfig/gcc-10/lab-nxp/baseline-imx8mn=
-ddr4-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm64/defconfig/gcc-10/lab-nxp/baseline-imx8mn=
-ddr4-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647dbde7750d968bfff5de94
        failing since 1 day (last pass: v5.10.180-cip33-11-gfea7994097935, =
first fail: v6.1.26-1281-g84d5372e0f31)

    2023-06-05T10:50:01.521493  / # #
    2023-06-05T10:50:02.680392  export SHELL=3D/bin/sh
    2023-06-05T10:50:02.685824  #
    2023-06-05T10:50:04.233183  / # export SHELL=3D/bin/sh. /lava-1233514/e=
nvironment
    2023-06-05T10:50:04.238873  =

    2023-06-05T10:50:07.060830  / # . /lava-1233514/environment/lava-123351=
4/bin/lava-test-runner /lava-1233514/1
    2023-06-05T10:50:07.066927  =

    2023-06-05T10:50:07.067222  / # /lava-1233514/bin/lava-te<6>[   24.1858=
18] platform sound-bt-sco: deferred probe pending
    2023-06-05T10:50:07.073082  st-runner /lava-1233514/1
    2023-06-05T10:50:07.138037  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647dbb498b79bfff11f5de56

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647dbb498b79bfff11f5de5f
        failing since 1 day (last pass: v4.19.280-cip95-rt30, first fail: v=
6.1.26-1281-g84d5372e0f31)

    2023-06-05T10:38:38.595251  + set +x<8>[   10.881432] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10590875_1.4.2.3.1>

    2023-06-05T10:38:38.595367  =


    2023-06-05T10:38:38.700536  / # #

    2023-06-05T10:38:38.801252  export SHELL=3D/bin/sh

    2023-06-05T10:38:38.801490  #

    2023-06-05T10:38:38.902032  / # export SHELL=3D/bin/sh. /lava-10590875/=
environment

    2023-06-05T10:38:38.902266  =


    2023-06-05T10:38:39.002802  / # . /lava-10590875/environment/lava-10590=
875/bin/lava-test-runner /lava-10590875/1

    2023-06-05T10:38:39.003176  =


    2023-06-05T10:38:39.007961  / # /lava-10590875/bin/lava-test-runner /la=
va-10590875/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/647dbdd5e217768eacf5de59

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm64/defconfig/gcc-10/lab-collabora/baseline-=
rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm64/defconfig/gcc-10/lab-collabora/baseline-=
rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647dbdd5e217768eacf5de62
        failing since 1 day (last pass: v5.10.180-cip33-11-gfea7994097935, =
first fail: v6.1.26-1281-g84d5372e0f31)

    2023-06-05T10:49:32.891601  / # #

    2023-06-05T10:49:34.154904  export SHELL=3D/bin/sh

    2023-06-05T10:49:34.165998  #

    2023-06-05T10:49:35.916632  / # export SHELL=3D/bin/sh. /lava-10590957/=
environment

    2023-06-05T10:49:35.927810  =


    2023-06-05T10:49:39.137386  / # . /lava-10590957/environment/lava-10590=
957/bin/lava-test-runner /lava-10590957/1

    2023-06-05T10:49:39.148959  =


    2023-06-05T10:49:39.149318  / # /lava-10590957/bin/lava-test-runner /la=
va-10590957/1

    2023-06-05T10:49:39.204744  + export 'TESTRUN_ID=3D1_bootrr'

    2023-06-05T10:49:39.205282  + cd /lava-10590957/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =20


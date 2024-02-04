Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F975C48286
	for <webhook@archiver.kernel.org>; Sun,  4 Feb 2024 05:10:36 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web11.33189.1707023426135016410
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 03 Feb 2024 21:10:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=fchD7V8W;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2907a17fa34so2838770a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 03 Feb 2024 21:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707023425; x=1707628225; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JfDkXgLH07MuGiPktiXog1HHfOptE9gyfq1LWN2TOmc=;
        b=fchD7V8Wlz7g65o8kB/aVlBQM4mpWv4s8CCu5W3WBybivcb+1w7R2j3QkBk8q3bxDD
         07xxKy0QopY/JieFEkMMXjgkFWMNYXafOmH+bxGyFqNODxC2tQFVFbDK67xyLEaew/On
         zeuRFF+vNXlCM3LYFASuoub9pvrmOxNYYBXiYNwc1n7M4A9EFc4y6CwLszJbVowPgxIu
         6U9Yc5JvGcrRU2b6ZUR4AV6tQ5r7FtQDWKCpF52gAwa/CZmVSGHSAHR5+Xt1lGIK6iKk
         uQTyjhx2MHo6mK64UCZcdFasPI1bZHFer8Num6jGCqXQLSNNFyCFJj9TpivtHMCpZqPn
         nISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707023425; x=1707628225;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JfDkXgLH07MuGiPktiXog1HHfOptE9gyfq1LWN2TOmc=;
        b=pYHHjO5XftJ1W8PEK+zcl5pg7QA4+yl6W6HNJ217GszE8AKbgSkQWRxkXJGhGhSZJK
         5j8u8LV59AwN7IFMTgqNy/uu41hlqrfJLpFN0dpoKL0FYvCTgqkzHaNlB85uRi50POLY
         zOKI/+DE11jEcJivXmo4IMZw729TeqP9xUoC6NapxciOd4V1LuLiT5GBFopoJhJ9quRT
         55Ecn5NJbbioJnxWS2sgSMfRX5RU3DSly3oqN1C0FdYM+GEyFzOvVhzyJJa1FkOkAY5n
         CTwgiS9YgljxkcX/VQ0w8WZMttKYeySs+YjEtyyOTTZSGj/YfJMzTiWURBqTsyE8CDvg
         JzxQ==
X-Gm-Message-State: AOJu0YwdlRtw6yxh+I4JqbbaxtT9kc5Wsp3oMEdw8eZetFr3A5J90Yby
	lC4OXFaT0/IK8qBvxNJ/KFp05VTecfUqDgVPaetwvLVnZr/RFfYXfnspk8ehsaZIRwp+B6SgR74
	DfT8=
X-Google-Smtp-Source: AGHT+IFF9G9I4BPdvSWcNiJax0FsYgfyTLqfFt+WjwBsqj5rPrr+UmV9ACe0XXFoZ59c5QM90UEkUw==
X-Received: by 2002:a17:902:ec87:b0:1d9:aa5d:a50 with SMTP id x7-20020a170902ec8700b001d9aa5d0a50mr138001plg.25.1707023424633;
        Sat, 03 Feb 2024 21:10:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902d31500b001d7222d8caasm4007784plc.50.2024.02.03.21.10.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 21:10:24 -0800 (PST)
Message-ID: <65bf1c40.170a0220.9e837.e5f2@mx.google.com>
Date: Sat, 03 Feb 2024 21:10:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.75-cip14-132-g6e54756fbd6c2
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 117 runs,
 9 regressions (v6.1.75-cip14-132-g6e54756fbd6c2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 04 Feb 2024 05:10:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14644

cip-gitlab/ci/pavel/linux-test baseline: 117 runs, 9 regressions (v6.1.75-c=
ip14-132-g6e54756fbd6c2)

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

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

imx8mp-evk                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig         | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.75-cip14-132-g6e54756fbd6c2/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.75-cip14-132-g6e54756fbd6c2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6e54756fbd6c2a85eb65a7be04700955d2e49b68 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf14a4c39fe6639300a06a

  Results:     5 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/x86_64/x86_64_defconfig+x86-board/gcc-10/=
lab-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/x86_64/x86_64_defconfig+x86-board/gcc-10/=
lab-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bf14a4c39fe6639300a072
        failing since 16 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-04T04:38:15.930139  TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dpass=
 UNITS=3Dlines MEASUREMENT=3D0>

    2024-02-04T04:38:15.930211  =


    2024-02-04T04:38:15.930274  <8>[    8.603356] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12699708_1.4.2.3.1>

    2024-02-04T04:38:16.030762  / # #export SHELL=3D/bin/sh

    2024-02-04T04:38:16.030951  =


    2024-02-04T04:38:16.131469  / # export SHELL=3D/bin/sh. /lava-12699708/=
environment

    2024-02-04T04:38:16.131639  =


    2024-02-04T04:38:16.232162  / # . /lava-12699708/environment/lava-12699=
708/bin/lava-test-runner /lava-12699708/1

    2024-02-04T04:38:16.232463  =


    2024-02-04T04:38:16.237387  / # /lava-12699708/bin/lava-test-runner /la=
va-12699708/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf149bc39fe6639300a039

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/x86_64/x86_64_defconfig+x86-board/gcc-10/=
lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/x86_64/x86_64_defconfig+x86-board/gcc-10/=
lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bf149cc39fe6639300a042
        failing since 16 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-04T04:38:16.158182  set +x

    2024-02-04T04:38:16.164566  <8>[    5.891289] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12699733_1.4.2.3.1>

    2024-02-04T04:38:16.266198  / ##

    2024-02-04T04:38:16.366833  export SHELL=3D/bin/sh

    2024-02-04T04:38:16.367022   #

    2024-02-04T04:38:16.467541  / # export SHELL=3D/bin/sh. /lava-12699733/=
environment

    2024-02-04T04:38:16.467730  =


    2024-02-04T04:38:16.568266  / # . /lava-12699733/environment/lava-12699=
733/bin/lava-test-runner /lava-12699733/1

    2024-02-04T04:38:16.568574  =


    2024-02-04T04:38:16.572659  / # /lava-12699733/bin/lava-test-runner /la=
va-12699733/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf148b5875cbe74f00a06e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/x86_64/x86_64_defconfig+x86-board/gcc-10/=
lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/x86_64/x86_64_defconfig+x86-board/gcc-10/=
lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bf148b5875cbe74f00a077
        failing since 16 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-04T04:37:14.622325  <8>[    6.551195] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12699750_1.4.2.3.1>

    2024-02-04T04:37:14.622493  _1.4.2.3.1

    2024-02-04T04:37:14.625416  + set +x

    2024-02-04T04:37:14.628556  + KERNELCI_LAVA=3Dy /bin/sh /opt/kernelci/d=
mesg.sh

    2024-02-04T04:37:14.628637  + set +x

    2024-02-04T04:37:14.733260  / # #

    2024-02-04T04:37:14.833938  export SHELL=3D/bin/sh

    2024-02-04T04:37:14.834177  #

    2024-02-04T04:37:14.934716  / # export SHELL=3D/bin/sh. /lava-12699750/=
environment

    2024-02-04T04:37:14.934935  =

 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf14b041585444d200a059

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/x86_64/x86_64_defconfig+x86-board/gcc-10/=
lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/x86_64/x86_64_defconfig+x86-board/gcc-10/=
lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bf14b041585444d200a062
        failing since 16 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-04T04:37:44.349287  <8>[   #

    2024-02-04T04:37:44.349687   8.356685] <LAVA_SIGNAL_ENDRUN 0_dmesg 1269=
9715_1.4.2.3.1>

    2024-02-04T04:37:44.450348  / # #export SHELL=3D/bin/sh

    2024-02-04T04:37:44.450592  =


    2024-02-04T04:37:44.551104  / # export SHELL=3D/bin/sh. /lava-12699715/=
environment

    2024-02-04T04:37:44.551312  =


    2024-02-04T04:37:44.651886  / # . /lava-12699715/environment/lava-12699=
715/bin/lava-test-runner /lava-12699715/1

    2024-02-04T04:37:44.652179  =


    2024-02-04T04:37:44.657022  / # /lava-12699715/bin/lava-test-runner /la=
va-12699715/1

    2024-02-04T04:37:44.664019  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx8mp-evk                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf10ba383c78237100a068

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bf10ba383c78237100a070
        failing since 38 days (last pass: v5.10.201-cip41-77-g545d45774209f=
, first fail: v6.1.66-cip11-rt6-10-g38253b8903b4)

    2024-02-04T04:20:48.882443  =

    2024-02-04T04:20:48.882790  / # <8>[   23.376813] <LAVA_SIGNAL_ENDRUN 0=
_dmesg 542404_1.5.2.4.1>
    2024-02-04T04:20:50.048052  #export SHELL=3D/bin/sh
    2024-02-04T04:20:50.054139  =

    2024-02-04T04:20:51.552967  / # export SHELL=3D/bin/sh. /lava-542404/en=
vironment
    2024-02-04T04:20:51.559066  =

    2024-02-04T04:20:54.280908  / # . /lava-542404/environment/lava-542404/=
bin/lava-test-runner /lava-542404/1
    2024-02-04T04:20:54.287124  =

    2024-02-04T04:20:54.292842  / # /lava-542404/bin/lava-test-runner /lava=
-542404/1
    2024-02-04T04:20:54.336642  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf14a91166c6ab0c00a05b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/x86_64/x86_64_defconfig+x86-board/gcc-10/=
lab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/x86_64/x86_64_defconfig+x86-board/gcc-10/=
lab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65bf14a91166c6ab0c00a064
        failing since 16 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-04T04:37:49.983715  <8>[    8.306559] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12699767_1.4.2.3.1>

    2024-02-04T04:37:50.084825  / # #

    2024-02-04T04:37:50.185392  export SHELL=3D/bin/sh

    2024-02-04T04:37:50.185587  #

    2024-02-04T04:37:50.286065  / # export SHELL=3D/bin/sh. /lava-12699767/=
environment

    2024-02-04T04:37:50.286218  =


    2024-02-04T04:37:50.386705  / # . /lava-12699767/environment/lava-12699=
767/bin/lava-test-runner /lava-12699767/1

    2024-02-04T04:37:50.386934  =


    2024-02-04T04:37:50.391813  / # /lava-12699767/bin/lava-test-runner /la=
va-12699767/1

    2024-02-04T04:37:50.398388  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf10b95ca85681f300a06c

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/65bf1=
0b95ca85681f300a09c
        new failure (last pass: v6.1.72-cip13-32-gf60d2e8cb51c)

    2024-02-04T04:21:09.537278  /lava-542398/1/../bin/lava-test-case
    2024-02-04T04:21:09.553022  <8>[   19.043430] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2024-02-04T04:21:09.553350  /lava-542398/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf159fb09c117a0200a047

  Results:     50 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-broonie/baseline-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-broonie/baseline-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/65bf1=
59fb09c117a0200a073
        new failure (last pass: v6.1.72-cip13-32-gf60d2e8cb51c)

    2024-02-04T04:41:36.005389  /lava-542530/1/../bin/lava-test-case
    2024-02-04T04:41:36.020783  <8>[   18.996871] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2024-02-04T04:41:36.021023  /lava-542530/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65bf0ea8d4260c27d400a039

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm/shmobile_defconfig/gcc-10/lab-cip/bas=
eline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm/shmobile_defconfig/gcc-10/lab-cip/bas=
eline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65bf0ea8d4260c27d400a=
03a
        new failure (last pass: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =20


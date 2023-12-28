Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055C0C46CD2
	for <webhook@archiver.kernel.org>; Thu, 28 Dec 2023 00:07:35 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.113576.1703722051873777900
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 27 Dec 2023 16:07:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=TKNZCS9N;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28bc7155755so2232545a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 27 Dec 2023 16:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703722051; x=1704326851; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7jiQwFX5tan4E57IWKbVA+inqWrzCN5BdmJArlYns6M=;
        b=TKNZCS9NQ4h9qRt5/E2iFBku323OT5Vgh0CR+eqoDAz4Ev66u/PAh6UJ9KrwGD8pJx
         aLSOM6k6pgyIHK9T09Wucweb8Kn7Y2EL1wVnDkF3MjrFNBVU4qpnejpfkHqsTRX2u2cy
         iA8sezXf8GDfJUMuOuNq7crVSQIXxQ3QisHG0WqGwxYSFS9Z1X1VHJcB+2WjGW5OKpMo
         wvH0mKxeaVRuM0mqAkgwr2O5iZApVhY+AkR3Y05o2DzOSbk8kr3VeyPPkxEXAW5bJIZ3
         /Xvm0A72z24616wqZ3TSBveMpJLcKD9FVL6Xyba5agDZFNQBqs/H6J1TurBAqlPvVvfR
         b5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703722051; x=1704326851;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7jiQwFX5tan4E57IWKbVA+inqWrzCN5BdmJArlYns6M=;
        b=vKGnKTpTzSWGmEU9H+t5TLEUkXxExjqQhMj9zMDQsQE5qTMoVYuGbBkCaxFLkMqjgA
         UcYEfCq8/JNvipcexyqq4yEdPMX97ANxYIe3f7wnS94hEeIiKynOvYfB7J5/VuoAYJa2
         S+yXtkFgy2P5cimdxZE3CqyLh1UvPOvjmj8RPKuc5QC+eurvEZaHwBKD1PirqHhCBw83
         s5/cR/soHDSHB7Oh7rhlRrnCWI9qBdSts6canfF/Tg2X5lVLqXkeUjUBGCstMiovvEc2
         OFW+wb0Fyvv1QbU++V4hR9Kexeow5n/QyWfHDEgOapffxKQ9hYm9mb1TX7hpfHkzRoSY
         5qjA==
X-Gm-Message-State: AOJu0YzCkMmqJwJxZsDqT57ph6HxzE/IpyHNfZmdn0cyjTQ+oYRLwN7b
	wgV7axNb58JJfV25BkS6osPO3dt9wAA6eloe/e04rCaeVF4=
X-Google-Smtp-Source: AGHT+IFNByMg6QEbzWwFYBeAzMkvZuLQT0xvCGZ54fX9e+7vFEvhRjpqftLgaqj/yPvtsVYlC6FtsQ==
X-Received: by 2002:a17:90a:a60c:b0:28b:2a79:dcd with SMTP id c12-20020a17090aa60c00b0028b2a790dcdmr3082051pjq.67.1703722050499;
        Wed, 27 Dec 2023 16:07:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id pc9-20020a17090b3b8900b0028be0ec6e76sm12895686pjb.28.2023.12.27.16.07.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 16:07:29 -0800 (PST)
Message-ID: <658cbc41.170a0220.b008f.e35e@mx.google.com>
Date: Wed, 27 Dec 2023 16:07:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.66-cip11-rt6-10-g38253b8903b4
Subject: cip-gitlab/ci/pavel/linux-test baseline: 117 runs,
 13 regressions (v6.1.66-cip11-rt6-10-g38253b8903b4)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Dec 2023 00:07:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14210

cip-gitlab/ci/pavel/linux-test baseline: 117 runs, 13 regressions (v6.1.66-=
cip11-rt6-10-g38253b8903b4)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

imx8mp-evk                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig            | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig         | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig         | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.66-cip11-rt6-10-g38253b8903b4/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.66-cip11-rt6-10-g38253b8903b4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      38253b8903b46da162814048c6f555bba4399ca8 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb2cf97d318ff55e134aa

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658cb2cf97d318ff55e134b3
        new failure (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6)

    2023-12-27T23:26:49.700990  <8>[    6.859324] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12395521_1.4.2.3.1>

    2023-12-27T23:26:49.701066  sg

    2023-12-27T23:26:49.704500  + cat uuid

    2023-12-27T23:26:49.704574  + UUID=3D12395521_1.4.2.3.1

    2023-12-27T23:26:49.707643  + set +x

    2023-12-27T23:26:49.711503  + KERNELCI_LAVA=3Dy /bin/sh /opt/kernelci/d=
mesg.sh

    2023-12-27T23:26:49.711575  + set +x

    2023-12-27T23:26:49.815885  / # #

    2023-12-27T23:26:49.916838  export SHELL=3D/bin/sh

    2023-12-27T23:26:49.917771  #
 =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb2c997d318ff55e1348c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658cb2c997d318ff55e13495
        new failure (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6)

    2023-12-27T23:26:55.160615  <8>[    9.571974] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-12-27T23:26:55.160930  set +x

    2023-12-27T23:26:55.264759  / # #

    2023-12-27T23:26:55.366990  export SHELL=3D/bin/sh

    2023-12-27T23:26:55.367599  <8>[    9.602488] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12395572_1.4.2.3.1>

    2023-12-27T23:26:55.367875  #

    2023-12-27T23:26:55.469110  / # export SHELL=3D/bin/sh. /lava-12395572/=
environment

    2023-12-27T23:26:55.469802  =


    2023-12-27T23:26:55.571276  / # . /lava-12395572/environment/lava-12395=
572/bin/lava-test-runner /lava-12395572/1

    2023-12-27T23:26:55.571559  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb2d0853ec4b076e13491

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658cb2d0853ec4b076e1349a
        new failure (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6)

    2023-12-27T23:26:46.998445  + cat uuid

    2023-12-27T23:26:46.998528  + UUID=3D12395554_1.4.2.3.1

    2023-12-27T23:26:47.001751  + set +x

    2023-12-27T23:26:47.008049  + KERNELCI_<8>[    6.813790] <LAVA_SIGNAL_E=
NDRUN 0_dmesg 12395554_1.4.2.3.1>

    2023-12-27T23:26:47.011329  LAVA=3Dy /bin/sh /opt/kernelci/dmesg.sh

    2023-12-27T23:26:47.014332  + set +x

    2023-12-27T23:26:47.115479  / # #

    2023-12-27T23:26:47.216009  export SHELL=3D/bin/sh

    2023-12-27T23:26:47.216262  #

    2023-12-27T23:26:47.316788  / # export SHELL=3D/bin/sh. /lava-12395554/=
environment
 =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb2be3d8f5e3076e14dce

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658cb2bf3d8f5e3076e14dd7
        new failure (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6)

    2023-12-27T23:26:48.498562  <8>[   10.051881] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12395576_1.4.2.3.1>

    2023-12-27T23:26:48.608043  / # #

    2023-12-27T23:26:48.710320  export SHELL=3D/bin/sh

    2023-12-27T23:26:48.711106  #

    2023-12-27T23:26:48.812766  / # export SHELL=3D/bin/sh. /lava-12395576/=
environment

    2023-12-27T23:26:48.813531  =


    2023-12-27T23:26:48.915036  / # . /lava-12395576/environment/lava-12395=
576/bin/lava-test-runner /lava-12395576/1

    2023-12-27T23:26:48.916230  =


    2023-12-27T23:26:48.921048  / # /lava-12395576/bin/lava-test-runner /la=
va-12395576/1

    2023-12-27T23:26:48.927836  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx8mp-evk                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb1f0a969aabb4ce13478

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig/gcc-10/lab-broonie/base=
line-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig/gcc-10/lab-broonie/base=
line-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658cb1f0a969aabb4ce13480
        new failure (last pass: v5.10.201-cip41-77-g545d45774209f)

    2023-12-27T23:23:16.839953  + set +x
    2023-12-27T23:23:16.943673  <8>[   20.464192] <LAVA_SIGNA#
    2023-12-27T23:23:16.944363  L_TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dpa=
ss UNITS=3Dlines MEASUREMENT=3D0>
    2023-12-27T23:23:16.944568  <8>[   20.465064] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 395338_1.5.2.4.1>
    2023-12-27T23:23:18.103170  / # #export SHELL=3D/bin/sh
    2023-12-27T23:23:18.108704  =

    2023-12-27T23:23:19.599067  / # export SHELL=3D/bin/sh. /lava-395338/en=
vironment
    2023-12-27T23:23:19.604600  =

    2023-12-27T23:23:22.313172  / # . /lava-395338/environment/lava-395338/=
bin/lava-test-runner /lava-395338/1
    2023-12-27T23:23:22.319041   =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb32c20a1ce928fe1349b

  Results:     60 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig/gcc-10/lab-broonie/base=
line-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig/gcc-10/lab-broonie/base=
line-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658cb32c20a1ce928fe134d4
        new failure (last pass: v5.10.201-cip41-77-g545d45774209f)

    2023-12-27T23:28:26.231564  .1>
    2023-12-27T23:28:26.232000  =

    2023-12-27T23:28:26.334456  / # #export SHELL=3D/bin/sh
    2023-12-27T23:28:26.335244  =

    2023-12-27T23:28:26.437222  / # export SHELL=3D/bin/sh. /lava-395337/en=
vironment
    2023-12-27T23:28:26.437997  =

    2023-12-27T23:28:26.540037  / # . /lava-395337/environment/lava-395337/=
bin/lava-test-runner /lava-395337/1
    2023-12-27T23:28:26.541385  =

    2023-12-27T23:28:26.555751  / # /lava-395337/bin/lava-test-runner /lava=
-395337/1
    2023-12-27T23:28:26.622103  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (44 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb2b12f6c1cdac2e134a2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/x86_64/x86_64_defconfig+x86-board/gcc-1=
0/lab-collabora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658cb2b12f6c1cdac2e134ab
        new failure (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6)

    2023-12-27T23:26:27.437324  set +x

    2023-12-27T23:26:27.440436  <8>[    9.412399] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12395499_1.4.2.3.1>

    2023-12-27T23:26:27.548434  / # #

    2023-12-27T23:26:27.650717  export SHELL=3D/bin/sh

    2023-12-27T23:26:27.651501  #

    2023-12-27T23:26:27.752978  / # export SHELL=3D/bin/sh. /lava-12395499/=
environment

    2023-12-27T23:26:27.753715  =


    2023-12-27T23:26:27.855397  / # . /lava-12395499/environment/lava-12395=
499/bin/lava-test-runner /lava-12395499/1

    2023-12-27T23:26:27.856575  =


    2023-12-27T23:26:27.862177  / # /lava-12395499/bin/lava-test-runner /la=
va-12395499/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/658cae437ec54cdc9ae1347c

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/658ca=
e447ec54cdc9ae134ac
        failing since 24 days (last pass: v6.1.62-cip9-12-g3a5321f469b07, f=
irst fail: v6.1.64-cip10-rt5)

    2023-12-27T23:07:35.953889  /lava-395248/1/../bin/lava-test-case
    2023-12-27T23:07:35.967807  <8>[   19.230272] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2023-12-27T23:07:35.968348  /lava-395248/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb1c002dc6b11aee13475

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig/gcc-10/lab-broonie/base=
line-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig/gcc-10/lab-broonie/base=
line-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/658cb=
1c002dc6b11aee134a4
        new failure (last pass: v5.10.201-cip41-77-g545d45774209f)

    2023-12-27T23:21:22.279018  /lava-395305/1/../bin/lava-test-case
    2023-12-27T23:21:22.295760  <8>[   19.391708] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2023-12-27T23:21:22.296091  /lava-395305/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/658cac4fec2ce04244e13482

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/mips/malta_defconfig/gcc-10/lab-collabo=
ra/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/mips/malta_defconfig/gcc-10/lab-collabo=
ra/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/658cac4fec2ce04244e13=
483
        failing since 21 days (last pass: v6.1.64-cip10-rt5, first fail: v5=
.10.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/658caacfe226b9564fe13485

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/shmobile_defconfig/gcc-10/lab-cip/b=
aseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/shmobile_defconfig/gcc-10/lab-cip/b=
aseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/658caacfe226b9564fe13=
486
        new failure (last pass: v5.10.201-cip41-77-g545d45774209f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb07782e58348f2e13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/658cb07782e58348f2e13=
476
        new failure (last pass: v5.10.201-cip41-77-g545d45774209f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/658cb24cc257688887e1347a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig/gcc-10/lab-broonie/base=
line-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm64/defconfig/gcc-10/lab-broonie/base=
line-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/658cb24cc257688887e13=
47b
        new failure (last pass: v5.10.201-cip41-77-g545d45774209f) =

 =20


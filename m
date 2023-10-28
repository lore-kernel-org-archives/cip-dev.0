Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA53EC4167B
	for <webhook@archiver.kernel.org>; Sat, 28 Oct 2023 20:28:39 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web11.30083.1698524910931881368
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 28 Oct 2023 13:28:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=3eyUVh42;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.176, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5b92b852390so2388150a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 28 Oct 2023 13:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698524909; x=1699129709; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L9o9RmzOwE8IFDAE6gBRduLvFlIszjsP3NDb2UrkJv4=;
        b=3eyUVh42Y/5xFKSyxaT8/yVs5opSxn5vBv9O90qny/aKhULJVG8Wn0SdrIB19zPysO
         Z/IAOXT/iFfQQnXEggHwQ14HRzoc9rd7QfNKxqmT8ul5pppzRydnb+7jqHn1kEAPRx9/
         B5ABXglitnpNsZyORZECl1P4t/gf0xjplnYtqF6ZvOEdWxUnS+1e+7n3GWPeEwmp0k5K
         0TQn70Q9Mgl6GHfH0RVAeBrx114thk89qkhgrX+hXofhnuyHYMVbl1oXLUG4w5eHtYnS
         pYabfoPMsuDLLAiS3NM3DThJi+ODtH9Xxgxw6t8ZlnlyO+AiQbacS3a7okfaYDQ826qw
         s4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698524909; x=1699129709;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L9o9RmzOwE8IFDAE6gBRduLvFlIszjsP3NDb2UrkJv4=;
        b=VKL8PX2HAibC063j37/Rw3lHJXyirf2raxAKcgoJ9+jXDSOfcJPhtzB32yQbFaiqDv
         5CoDh3xPQpRW0eFpJYU/XsI+zbJSqB455B/5cgbWFMd8czANXMaw/BXTgHN9CxqpKEOz
         lIQ8gTkU5o8e4gC8QQBOhbS0cXgRChScPvcc6oKDUMu2CGu5qMiU/sJODBrVI7AH3kH3
         xkmk3BCNC9SmZqyendblhY3MYfclsMR6hCEH252zYkA2NslHd4Y8EJdQUnx1dZzeJBDA
         HAgLl9+AoDw8EX5YcXTRuZwS+J6qsOePzuoJrOadAd3MPPCfmphgd/pWqtIvR0MQLM3R
         jpkQ==
X-Gm-Message-State: AOJu0Yw+ch/tcwn1Zt5jXxuvHO+8x6LxfCxGvMdMVGVAbZkonz9HjiHP
	8MvAOzae1qceqRqRTxp4E6GD1PKWix/qIoLUsxg=
X-Google-Smtp-Source: AGHT+IHpJCoygGtJ184f5BuKvhfe4VD0rn4+rb9c9OkbST8XX7TVSvz3qJ2QusKwGWKN9ummOSDXCw==
X-Received: by 2002:a17:902:ee89:b0:1ca:731a:23e4 with SMTP id a9-20020a170902ee8900b001ca731a23e4mr6355214pld.40.1698524909498;
        Sat, 28 Oct 2023 13:28:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z3-20020a170903018300b001b06c106844sm3584031plg.151.2023.10.28.13.28.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 13:28:28 -0700 (PDT)
Message-ID: <653d6eec.170a0220.dad63.a95a@mx.google.com>
Date: Sat, 28 Oct 2023 13:28:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.59-cip8-106-g65bd536c294e
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 35 runs,
 6 regressions (v6.1.59-cip8-106-g65bd536c294e)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 28 Oct 2023 20:28:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13490

cip-gitlab/ci/pavel/linux-test baseline-nfs: 35 runs, 6 regressions (v6.1.5=
9-cip8-106-g65bd536c294e)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
at91sam9g20ek                | arm   | lab-broonie | gcc-10   | multi_v5_de=
fconfig         | 1          =

imx6dl-udoo                  | arm   | lab-broonie | gcc-10   | imx_v6_v7_d=
efconfig        | 1          =

imx6q-udoo                   | arm   | lab-broonie | gcc-10   | imx_v6_v7_d=
efconfig        | 1          =

imx8mp-evk                   | arm64 | lab-broonie | gcc-10   | defconfig  =
                | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig  =
                | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.59-cip8-106-g65bd536c294e/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.59-cip8-106-g65bd536c294e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      65bd536c294e2f5356dabd805e63516e90d72628 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
at91sam9g20ek                | arm   | lab-broonie | gcc-10   | multi_v5_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/653d670edb22a8b24defcf97

  Results:     47 PASS, 6 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm/multi_v5_defconfig/gcc-10/lab-broonie/b=
aseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm/multi_v5_defconfig/gcc-10/lab-broonie/b=
aseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/653d670edb22a8b24defcfce
        failing since 1 day (last pass: v5.10.194-915-g33f52aa14b957, first=
 fail: v6.1.58-cip7-132-gb38ea1474c159)

    2023-10-28T19:54:23.075362  <8><LAVA_SIGNAL_TESTCASE T+ set +x
    2023-10-28T19:54:23.090196  EST_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dl=
ines MEASUREMENT=3D0>
    2023-10-28T19:54:23.097098  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 205801_1.6.2=
.4.1>
    2023-10-28T19:54:23.206138  #
    2023-10-28T19:54:23.309303  / # #export SHELL=3D/bin/sh
    2023-10-28T19:54:23.310128  =

    2023-10-28T19:54:23.412059  / # export SHELL=3D/bin/sh. /lava-205801/en=
vironment
    2023-10-28T19:54:23.412836  =

    2023-10-28T19:54:23.514866  / # . /lava-205801/environment/lava-205801/=
bin/lava-test-runner /lava-205801/1
    2023-10-28T19:54:23.516174   =

    ... (13 line(s) more)  =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
imx6dl-udoo                  | arm   | lab-broonie | gcc-10   | imx_v6_v7_d=
efconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/653d696f562af3aaa1efcf10

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/653d696f562af3aaa=
1efcf11
        failing since 1 day (last pass: v4.4-st20-3596-g73e7f2b880d98, firs=
t fail: v6.1.58-cip7-132-gb38ea1474c159) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
imx6q-udoo                   | arm   | lab-broonie | gcc-10   | imx_v6_v7_d=
efconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/653d6b64f92bb6ce7eefcf0c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/653d6b64f92bb6ce7=
eefcf0d
        failing since 1 day (last pass: v4.4-st20-3596-g73e7f2b880d98, firs=
t fail: v6.1.58-cip7-132-gb38ea1474c159) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
imx8mp-evk                   | arm64 | lab-broonie | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/653d67c79083ba9b78efd069

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm64/defconfig/gcc-10/lab-broonie/baseline=
-nfs-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm64/defconfig/gcc-10/lab-broonie/baseline=
-nfs-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/653d67c79083ba9b78efd072
        failing since 1 day (last pass: v5.10.194-557-g2932db67f070a, first=
 fail: v6.1.58-cip7-132-gb38ea1474c159)

    2023-10-28T19:57:44.790761  <8>[   31.079289] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 205892_1.6.2.4.1>
    2023-10-28T19:57:44.900864  / # #
    2023-10-28T19:57:46.066003  export SHELL=3D/bin/sh
    2023-10-28T19:57:46.072103  #
    2023-10-28T19:57:47.569389  / # export SHELL=3D/bin/sh. /lava-205892/en=
vironment
    2023-10-28T19:57:47.575520  =

    2023-10-28T19:57:50.293884  / # . /lava-205892/environment/lava-205892/=
bin/lava-test-runner /lava-205892/1
    2023-10-28T19:57:50.300487  =

    2023-10-28T19:57:50.309342  / # /lava-205892/bin/lava-test-runner /lava=
-205892/1
    2023-10-28T19:57:50.547014  + export TESTRUN_ID=3D1_bootrr =

    ... (15 line(s) more)  =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/653d66eafb06c371adefcf7a

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/6=
53d66eafb06c371adefcfa9
        new failure (last pass: v6.1.58-cip7-132-gb38ea1474c159)

    2023-10-28T19:54:00.963054  /lava-205857/1/../bin/lava-test-case
    2023-10-28T19:54:01.020982  <8>[   34.513365] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>
    2023-10-28T19:54:01.021384  /lava-205857/1/../bin/lava-test-case   =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/653d67b9be0bdeeab4efcf06

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm64/defconfig/gcc-10/lab-broonie/baseline=
-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.59-cip8-106-g65bd536c294e/arm64/defconfig/gcc-10/lab-broonie/baseline=
-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.cpufreq-probed: https://kernelci.org/test/case/id/6=
53d67b9be0bdeeab4efcf34
        new failure (last pass: v6.1.58-cip7-132-gb38ea1474c159)

    2023-10-28T19:57:37.633900  /lava-205876/1/../bin/lava-test-case
    2023-10-28T19:57:37.673465  <8>[   35.307338] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpufreq-probed RESULT=3Dfail>   =

 =20


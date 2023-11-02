Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C6BC4167D
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 17:19:19 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web11.37336.1698945556100774820
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 02 Nov 2023 10:19:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=d2lukcyY;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6bd73395bceso994635b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 02 Nov 2023 10:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698945555; x=1699550355; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ICVA0XfpFYhsTkQ3CrpUP2D4qEfkC0l3dFx7KsWQKNQ=;
        b=d2lukcyYgY3M1JcbchW+FKyE2fFcrQaJcWrM6YGc1fL3TdPEkeb3rLABZWt4rxYSFO
         e/dWPU5GF79OuT6VM3ItdmY9EGv7G5dRkMO+WKAsMTrCSeQRIC5t8EnWI4GsvLTbsLNA
         C8uPMpQNjF4SL+XBE3QyxnQrrO+4XNQqY973NBKW6kJgQwu2EuF6T4Vne0+th3xofaKj
         V/ZqXc10a3xAJg7wZkqdkBkazEKf2D7s8+/2ifscqStToVVLZqHpplig0J6BBm159RHr
         gAU4hTu6BFe/oxe/ZONawKt/9uSRqd2JIPOt2Wk+iXDE40leGO2+nC+r2DQoL2wAb0yZ
         xeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698945555; x=1699550355;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ICVA0XfpFYhsTkQ3CrpUP2D4qEfkC0l3dFx7KsWQKNQ=;
        b=ncJfo7SpJMRWh6uFf5Tzw4NuU0M9wIYUylwaCg0V3ed/SIYxQWxKjqEkqFRew9XZJy
         yEviaX/j1uT4dnjgnLHQujR5XXz7hbC2Bi/RbLWJDFyE5ssWXI7AVOl+GCIRWFRh7wij
         1zfKgOXdsDOLy0QO4zmKz+Oz2t62tmDZp6r4KbkqW7FzZy9hmf7367QoJwWD+51QBDi5
         O5tkM0idF18QefCUOdkQN/LYoEMGfRv6CRPtv9ybpoq9STgxtQokXxtNIUx9brMMWdu2
         0YTL9Z4xeIiBTgnzA/MlTc+NAG9bU8y4DPRzlRg7DN/P2R+LUnz66h7JVFDX8GY16t2f
         KufQ==
X-Gm-Message-State: AOJu0YxoJ3E1DjnNqlCOGZt5XewNiwM+8YszzugyATwiiBQ/y821ziT5
	xrhiJhw526cpaLwGtD96GASyfUaktu1XkecC7b6fAQ==
X-Google-Smtp-Source: AGHT+IH2qNhI3CVAaRjBSLaAHV6PInVOp7ttEPlaeuLyaCDszOvuRSumcSKZPdR9t/n6ykGpZOORUg==
X-Received: by 2002:a05:6a00:1790:b0:68f:b5a3:5ec6 with SMTP id s16-20020a056a00179000b0068fb5a35ec6mr571164pfg.0.1698945554689;
        Thu, 02 Nov 2023 10:19:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b6-20020a056a000a8600b006933e71956dsm24235pfl.9.2023.11.02.10.19.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 10:19:13 -0700 (PDT)
Message-ID: <6543da11.050a0220.80db6.030a@mx.google.com>
Date: Thu, 02 Nov 2023 10:19:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-cip39-915-g96fa7f16cf02
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 87 runs,
 11 regressions (v5.10.194-cip39-915-g96fa7f16cf02)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Nov 2023 17:19:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13521

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 87 runs, 11 regres=
sions (v5.10.194-cip39-915-g96fa7f16cf02)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                    | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+kselftest          | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm...ok+kselftest | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook   | 2          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
                    | 1          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.194-cip39-915-g96fa7f16cf02/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.194-cip39-915-g96fa7f16cf02
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      96fa7f16cf0228e65eeaeaeef1b73f242f4e169e =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6543ca0904b4bf5d5fefcf7f

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6543ca0904b4bf5d5fefcfbe
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1)

    2023-11-02T16:10:28.540825  / # #
    2023-11-02T16:10:28.642636  export SHELL=3D/bin/sh
    2023-11-02T16:10:28.643453  #
    2023-11-02T16:10:28.745373  / # export SHELL=3D/bin/sh. /lava-217503/en=
vironment
    2023-11-02T16:10:28.746193  =

    2023-11-02T16:10:28.848277  / # . /lava-217503/environment/lava-217503/=
bin/lava-test-runner /lava-217503/1
    2023-11-02T16:10:28.849596  =

    2023-11-02T16:10:28.853814  / # /lava-217503/bin/lava-test-runner /lava=
-217503/1
    2023-11-02T16:10:29.039439  + export TESTRUN_ID=3D1_bootrr
    2023-11-02T16:10:29.039778  + cd /lava-217503/1/tests/1_bootrr =

    ... (9 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6543ccd987f0ba0bf7efcf25

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6543ccd987f0ba0bf7efcf61
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1)

    2023-11-02T16:22:16.008467  <8>[   64.651351] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 217544_1.6.2.4.1>
    2023-11-02T16:22:16.127205  #
    2023-11-02T16:22:16.230278  / # #export SHELL=3D/bin/sh
    2023-11-02T16:22:16.231039  =

    2023-11-02T16:22:16.332966  / # export SHELL=3D/bin/sh. /lava-217544/en=
vironment
    2023-11-02T16:22:16.333695  =

    2023-11-02T16:22:16.435814  / # . /lava-217544/environment/lava-217544/=
bin/lava-test-runner /lava-217544/1
    2023-11-02T16:22:16.437189  =

    2023-11-02T16:22:16.456242  / # /lava-217544/bin/lava-test-runner /lava=
-217544/1
    2023-11-02T16:22:16.823896  + export TESTRUN_ID=3D1_bootrr =

    ... (13 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6543c96b4630b504e8efcefd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6543c96b4630b504e=
8efcefe
        failing since 44 days (last pass: v5.10.186-cip37-982-g80a0585c0aa6=
2, first fail: v5.10.191-cip38-661-g112a3073ff26) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6543ca6aa9f7e9d34befcf2d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig/gcc-10/lab-c=
ip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig/gcc-10/lab-c=
ip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6543ca6aa9f7e9d34=
befcf2e
        failing since 97 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6543cc553058d1a426efcf58

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+kselftest/gc=
c-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+kselftest/gc=
c-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6543cc553058d1a42=
6efcf59
        failing since 97 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6543cd6cf961d64cabefcef8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6543cd6cf961d64ca=
befcef9
        failing since 83 days (last pass: v5.10.186-cip37-566-g36076316ef04=
9, first fail: v5.10.186-cip37-770-gddd36cfc4c4c8) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6543d4604caaf64791efcf01

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6543d4604caaf6479=
1efcf02
        failing since 97 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6543cb0769fe79f13befcf3a

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/6543cb0769fe79f13befcf44
        failing since 196 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-11-02T16:14:42.214353  <8>[   36.005422] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-11-02T16:14:43.263888  /lava-11931775/1/../bin/lava-test-case

    2023-11-02T16:14:43.298920  <8>[   37.090506] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/6543cb0769fe79f13befcf45
        failing since 196 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-11-02T16:14:41.131053  <8>[   34.921437] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-11-02T16:14:42.181841  /lava-11931775/1/../bin/lava-test-case
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6543c7724ef52a5881efcf1f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6543c7724ef52a5881efcf28
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1)

    2023-11-02T15:59:30.543844  / # #

    2023-11-02T15:59:31.799053  export SHELL=3D/bin/sh

    2023-11-02T15:59:31.809311  #

    2023-11-02T15:59:33.542885  / # export SHELL=3D/bin/sh. /lava-11931581/=
environment

    2023-11-02T15:59:33.553094  =


    2023-11-02T15:59:33.553182  / # . /lava-11931581/environment

    2023-11-02T15:59:36.730916  / # /lava-11931581/bin/lava-test-runner /la=
va-11931581/1

    2023-11-02T15:59:36.746672  /lava-11931581/bin/lava-test-runner /lava-1=
1931581/1

    2023-11-02T15:59:36.911356  + export TESTRUN_ID=3D1_bootrr

    2023-11-02T15:59:36.911422  + cd /lava-11931581/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6543c83c0876189f97efd029

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+kselftest/gc=
c-10/lab-collabora/baseline-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-915-g96fa7f16cf02/arm64/defconfig+kselftest/gc=
c-10/lab-collabora/baseline-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6543c83c0876189f97efd032
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1)

    2023-11-02T16:02:37.089511  / # #

    2023-11-02T16:02:38.349213  export SHELL=3D/bin/sh

    2023-11-02T16:02:38.360181  #

    2023-11-02T16:02:38.360738  / # export SHELL=3D/bin/sh

    2023-11-02T16:02:40.104855  . /lava-11931658/environment

    2023-11-02T16:02:43.310419  / # . /lava-11931658/environment/lava-11931=
658/bin/lava-test-runner /lava-11931658/1

    2023-11-02T16:02:43.321877  =


    2023-11-02T16:02:43.322180  / # /lava-11931658/bin/lava-test-runner /la=
va-11931658/1

    2023-11-02T16:02:43.754838  + export TESTRUN_ID=3D1_bootrr

    2023-11-02T16:02:43.755340  + cd /lava-11931658/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =20


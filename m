Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C914C4332F
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 22:07:54 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web10.209.1668031667703780416
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 09 Nov 2022 14:07:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=rBKbzjxo;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id k22so33914pfd.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 09 Nov 2022 14:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WarL7swkozYmvzKQO78Kl13VuSnWeDYd2AleBQied2M=;
        b=rBKbzjxoFCy22WIvJo1F68qyQMAfuSJSwZ+X0vYTP43uqGq6bV8GFXi7MPZDO5qRg8
         brjgHzMYZZX5QFtfuvYvA5F6Ui/Fc5WVZl/vuGp2mc8wAGCAR6eRywJhFd24QphzxNao
         7ik6nmOvTbPmlI9oDtQawyO9hH73yT4tDYH5oTR65bp6ws4BBav0Ph3lLFSdc9hUDmA2
         bikRdaRPIYlymt+iJKOP3Fw4IpEwe4vYFXNew7jqK7RCm0Nvet/HxWEB6szVEjqV8pNf
         IxdWQ73ukiMGLphG49GGcVPhxTF0wrqxx+x2Kb1gviD+6utI/s1JyOw8PLeWH1h186sz
         RmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WarL7swkozYmvzKQO78Kl13VuSnWeDYd2AleBQied2M=;
        b=2RdI1APs+icP9LVSIt/xRABk/dNurKTVbDCtdjPIrix9eYs9rCBg0ehCAcYA67raN+
         Bb4ArOe5Bmedo4sQqy51a9D6CEAFtmP2GFUDPed28dGGzSqEfIY1AD8MlqNw4pcqqjpe
         x1mFzIvT8Xw4kVzUFBHfWxsoR16bwbcL+u0yPTnaJODApMGPE5UxIyJVmJtYhImH9aVs
         W99+78+nypCMe2GJknAV9zoSabBfiVaImKWbUDRiECX6yZlyNq+Q+vpgtxMd1T8eL3re
         5JNQApWyYAWGHO04Y4gjDYQ9jVLv9243+rcx1ahlesvuBRqZgWb1rK18ur6oeKmajSSo
         vruA==
X-Gm-Message-State: ACrzQf1St9W0RWM8ekR9nc/mcZpcKG5siHoOCVMQiBLZ/qrwnMhe5hxJ
	+mj+H8Qgx0TMUbYvCCHzHBW2SrGe+W1DKZEtMjw=
X-Google-Smtp-Source: AMsMyM5TsK9mCqbKM6331olnROQl2SjdzWJ2uz85HdkV4Yoq+IHODnPbVsTurDcbOtI5k4PEO6o+8A==
X-Received: by 2002:a05:6a00:1a4d:b0:563:a7c4:f521 with SMTP id h13-20020a056a001a4d00b00563a7c4f521mr63026389pfv.61.1668031666856;
        Wed, 09 Nov 2022 14:07:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k13-20020aa79d0d000000b0056afd55722asm8713675pfp.153.2022.11.09.14.07.46
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:07:46 -0800 (PST)
Message-ID: <636c24b2.a70a0220.6002c.edf0@mx.google.com>
Date: Wed, 09 Nov 2022 14:07:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-rt74-1329-ga59fc50f38f6
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline: 116 runs,
 7 regressions (v5.10.145-rt74-1329-ga59fc50f38f6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 22:07:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9971

cip-gitlab/ci/pavel/linux-test baseline: 116 runs, 7 regressions (v5.10.145=
-rt74-1329-ga59fc50f38f6)

Regressions Summary
-------------------

platform               | arch  | lab           | compiler | defconfig      =
            | regressions
-----------------------+-------+---------------+----------+----------------=
------------+------------
bcm2836-rpi-2-b        | arm   | lab-collabora | gcc-10   | multi_v7_defcon=
fig         | 1          =

beagle-xm              | arm   | lab-baylibre  | gcc-10   | omap2plus_defco=
nfig        | 1          =

da850-lcdk             | arm   | lab-baylibre  | gcc-10   | davinci_all_def=
config      | 1          =

r8a7743-iwg20d-q7      | arm   | lab-cip       | gcc-10   | shmobile_defcon=
fig         | 1          =

sun50i-a64-pine64-plus | arm64 | lab-broonie   | gcc-10   | defconfig      =
            | 1          =

zynqmp-zcu102          | arm64 | lab-cip       | gcc-10   | defconfig+arm64=
-chromebook | 1          =

zynqmp-zcu102          | arm64 | lab-cip       | gcc-10   | defconfig      =
            | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.145-rt74-1329-ga59fc50f38f6/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.145-rt74-1329-ga59fc50f38f6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a59fc50f38f6208d7d36629eb501bf5191bde812 =



Test Regressions
---------------- =



platform               | arch  | lab           | compiler | defconfig      =
            | regressions
-----------------------+-------+---------------+----------+----------------=
------------+------------
bcm2836-rpi-2-b        | arm   | lab-collabora | gcc-10   | multi_v7_defcon=
fig         | 1          =


  Details:     https://kernelci.org/test/plan/id/636c23e9a043d698d9e7db6e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm/multi_v7_defconfig/gcc-10/lab-collab=
ora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/636c23e9a043d698d9e7d=
b6f
        failing since 183 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform               | arch  | lab           | compiler | defconfig      =
            | regressions
-----------------------+-------+---------------+----------+----------------=
------------+------------
beagle-xm              | arm   | lab-baylibre  | gcc-10   | omap2plus_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/636c1e8b3928857712e7db4e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm/omap2plus_defconfig/gcc-10/lab-bayli=
bre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm/omap2plus_defconfig/gcc-10/lab-bayli=
bre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/636c1e8b3928857712e7d=
b4f
        new failure (last pass: v4.4-st20-231-g7349cef09ddd2) =

 =



platform               | arch  | lab           | compiler | defconfig      =
            | regressions
-----------------------+-------+---------------+----------+----------------=
------------+------------
da850-lcdk             | arm   | lab-baylibre  | gcc-10   | davinci_all_def=
config      | 1          =


  Details:     https://kernelci.org/test/plan/id/636c18c1ffe05a5d49e7db9d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: davinci_all_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm/davinci_all_defconfig/gcc-10/lab-bay=
libre/baseline-da850-lcdk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm/davinci_all_defconfig/gcc-10/lab-bay=
libre/baseline-da850-lcdk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/armel/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/636c18c1ffe05a5=
d49e7dba5
        failing since 183 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a)
        4 lines

    2022-11-09T21:16:21.417343  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3000
    2022-11-09T21:16:21.417603  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3400
    2022-11-09T21:16:21.417787  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3800
    2022-11-09T21:16:21.420513  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3c00
    2022-11-09T21:16:21.463828  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dale=
rt RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D4>   =

 =



platform               | arch  | lab           | compiler | defconfig      =
            | regressions
-----------------------+-------+---------------+----------+----------------=
------------+------------
r8a7743-iwg20d-q7      | arm   | lab-cip       | gcc-10   | shmobile_defcon=
fig         | 1          =


  Details:     https://kernelci.org/test/plan/id/636c1b35390358aeefe7db51

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm/shmobile_defconfig/gcc-10/lab-cip/ba=
seline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/636c1b35390358aeefe7d=
b52
        failing since 1 day (last pass: v5.10.147-cip18-12-gcb2b164780be, f=
irst fail: v5.10.147-cip18-15-gef247a3cd0ad) =

 =



platform               | arch  | lab           | compiler | defconfig      =
            | regressions
-----------------------+-------+---------------+----------+----------------=
------------+------------
sun50i-a64-pine64-plus | arm64 | lab-broonie   | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/636c1f7a38c53b2df8e7db5b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/636c1f7a38c53b2df8e7d=
b5c
        new failure (last pass: v5.10.147-cip18-15-gef247a3cd0ad) =

 =



platform               | arch  | lab           | compiler | defconfig      =
            | regressions
-----------------------+-------+---------------+----------+----------------=
------------+------------
zynqmp-zcu102          | arm64 | lab-cip       | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/636c1eb3080fb59feae7db5d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/636c1eb3080fb59feae7d=
b5e
        failing since 183 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform               | arch  | lab           | compiler | defconfig      =
            | regressions
-----------------------+-------+---------------+----------+----------------=
------------+------------
zynqmp-zcu102          | arm64 | lab-cip       | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/636c20cfc355af31bee7db50

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/arm64/defconfig/gcc-10/lab-cip/baseline-=
zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/636c20cfc355af31bee7d=
b51
        failing since 183 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a) =

 =20


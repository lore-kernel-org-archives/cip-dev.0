X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web11.30933.1650899917242183522
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Apr 2022 08:18:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=6EXSWeEm;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id fv2so214749pjb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 25 Apr 2022 08:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=50XrEcy5sqdrC0yXjGsP/aSWBJLSmnaTHIoLisrPXiA=;
        b=6EXSWeEmYXejHleKiPA6KWsSE8tmqVGO3WEOoEMqe5BDFgWjzXLfUsKtp2eUMj7uNr
         QYurTg7cLGLQzrV6TZgLdMz/SuZfRx6D8sKQscTzcL537M/+oRJyS0oFCS6hE3w+th5h
         LUi+yiOXPmaqXqAZNC7vp3GD2fGId5b4Hp2mwVCZYFwC5vGJ605wyS9HWqZ26lJD+kqB
         PmBrT8R3OOjfgZX5Ptwff8cXppEUKt3gdh0O7n9oLyiCa/Du1o1ie5SuyIuOL1HcayWM
         6s/4VpSeRWX897aDShGg67DNFtNdCMEj6i9/UVCJTMe4v50WhR9LattW0eQ29/kecweD
         gAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=50XrEcy5sqdrC0yXjGsP/aSWBJLSmnaTHIoLisrPXiA=;
        b=DfszULlB1qXNfAw0tl4E9pQ0N3QPAdVFJNSKTZx/xTJ8eWSXqHiLEKSVNPYC7Gp9pz
         genet8KajvDJljUHp1uUJeDyuSIBINAb8MAshZFHUqsAoqJ+9gYehX+B9U4fkucxaJ5A
         0Wiqg4l53mvDVuCiKkJcToYBb+Eh3rau2p+DXiKoL68KKuU/ECWqTKx++gbn7ME12etu
         c6/tmjeFp3lSZZAHBJ5bIj7jJGLHnGnI0HCWCb62zDXPyqHlEeEbEMYlfLmqh8pLXTay
         vDheDQD6OxeTBR8HuAHliQPThNd3n6Nwhv2k5ZYb97EAqRmCe6DSpj7e/YwAAUs2DSa/
         a1Gw==
X-Gm-Message-State: AOAM5323t2F+dMsWq5KpXrEbliPjHhldoRIHYRZn1dgS6A3NhbODSWUw
	u79bbyCenMTFmMoNFYnOJJMPODUcqoHVcZmmVcs=
X-Google-Smtp-Source: ABdhPJxijrWuvhco2ah3yb82SwyM2Jckp4U1UIcqk4y7lS3FSyTyalEdVx6hHGrNH/8E+GKcfn9n9A==
X-Received: by 2002:a17:902:d510:b0:15c:ecd2:e7fc with SMTP id b16-20020a170902d51000b0015cecd2e7fcmr11165549plg.132.1650899916575;
        Mon, 25 Apr 2022 08:18:36 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a18-20020a631a12000000b003aaedc4af99sm7421413pga.67.2022.04.25.08.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 08:18:36 -0700 (PDT)
Message-ID: <6266bbcc.1c69fb81.3fc3e.17ee@mx.google.com>
Date: Mon, 25 Apr 2022 08:18:36 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.112-cip6
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip baseline: 129 runs, 3 regressions (v5.10.112-cip6) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip baseline: 129 runs, 3 regressions (v5.10.112-cip6)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
imx6q-var-dt6customboard | arm   | lab-baylibre  | gcc-10   | multi_v7_defc=
onfig         | 2          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.112-cip6/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.112-cip6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c8f6747dcd02a8f87731c324f4bc37bd120a8982 =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
imx6q-var-dt6customboard | arm   | lab-baylibre  | gcc-10   | multi_v7_defc=
onfig         | 2          =


  Details:     https://kernelci.org/test/plan/id/6266afd30045c3b92aff949c

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-imx6q-var-dt6cust=
omboard.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-imx6q-var-dt6cust=
omboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220422.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/6266afd30045c3b=
92aff949f
        new failure (last pass: v5.10.106-cip4-66-gc8c4cc5cdb54c)
        26 lines

    2022-04-25T14:27:20.771542  kern  :emerg : Internal error: : 1 [#1] SMP=
 ARM
    2022-04-25T14:27:20.771813  kern  :emerg : Process kworker/1:7 (pid: 69=
, stack limit =3D 0x(ptrval))
    2022-04-25T14:27:20.772036  kern  :emerg : Stack: (0xc30ddeb0 to<8>[   =
16.700919] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dfail UNITS=
=3Dlines MEASUREMENT=3D26>
    2022-04-25T14:27:20.772267   0xc30de000)   =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/6266afd30045c3b=
92aff94a0
        new failure (last pass: v5.10.106-cip4-66-gc8c4cc5cdb54c)
        4 lines

    2022-04-25T14:27:20.689929  kern  :alert : 8<--- cut here ---
    2022-04-25T14:27:20.718846  kern  :alert : Unhandled fault: alignment e=
xception (0x001) at 0xcec60217
    2022-04-25T14:27:20.719196  kern  :alert : pgd =3D (ptrval)
    2022-04-25T14:27:20.722008  kern  :alert : [<8>[   16.654455] <LAVA_SIG=
NAL_TESTCASE TEST_CASE_ID=3Dalert RESULT=3Dfail UNITS=3Dlines MEASUREMENT=
=3D4>
    2022-04-25T14:27:20.722299  cec60217] *pgd=3D1ec1141e(bad)   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6266af801386332324ff947f

  Results:     90 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399=
-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399=
-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220422.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/6266af801386332324ff94a4
        failing since 27 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.106-cip4)

    2022-04-25T14:26:00.293287  /lava-6171413/1/../bin/lava-test-case
    2022-04-25T14:26:00.303756  <8>[   33.608522] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20


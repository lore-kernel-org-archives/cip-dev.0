X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web10.8704.1652183288343101708
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 10 May 2022 04:48:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=M5hw3SSU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.175, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f175.google.com with SMTP id 15so14431889pgf.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 10 May 2022 04:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=tFj3/KWb35j2Set0lpYFSxMThm93bdrElqUWNQZLuFc=;
        b=M5hw3SSUujQpjAmHzEb0lrx1py5QZfC1YhyerOfbOAKFYOhmIW+5lTTStOFgDmusQx
         5Ctnwx1h+dJ9YZAEt+C4IZA6NlWuBd+yCLVZEZuMdToSa3ujZ/l4qAhl+wOPyk6KDH9l
         et8AmYss1ngQzRrvrC6uWN+py7EcZviPVhFhRdH0OrEU8Ia59/pCRPGALSCbpYy52y80
         mJeLUt/RGUYHOxmwwl9Um9JIr+68r4vg9I+P/NUKqEq6m8ANH6tSbjMzKedhZnvfF8fN
         YttD16WxzMVwZAwqeWeTVhdQO2YqcJLU/Hq+N2LZAsgM6TSxzOFon5One6wiaGtVkDoI
         k2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=tFj3/KWb35j2Set0lpYFSxMThm93bdrElqUWNQZLuFc=;
        b=7WFXewakyRwOS7dYggxOZLK44gFWypDRMgsN/BB698BuryGNYmYhl6IL8AMfjHSSAk
         6RJKL2wYtvnlUTdcMNnNqfBe+4BIi5zP8dGda0QAZ1gus0RUPMuSdvKmub0GMuOHEdoP
         laxFZVutVeLckUJIZGFF+htLODjyrhrsIvwgxhiQopXpEJhgvgggRHCmG0OAe2q5l/XF
         gb6jGJ5XJvinKNBWGPytE3wSozvd1si6WmOsonbgBg1h3wK/qrQ8IVA5UrZY85LgsH2w
         u0elrN1q3+dd9CBKvlb9fFNz0fO/ZKKnZ7rLL3wsiBdKEdhcMdZ8FSScXvgrElM97VnH
         UYlg==
X-Gm-Message-State: AOAM533eTHdfb1bX25QgYrfDK7psXHvQxmf1g6A/nGYP9opZSQP9cwys
	eYmP6MIoTQcKlxpxFVOuV5DOeSH6OQ/QbqotX+I=
X-Google-Smtp-Source: ABdhPJxbd5U6vJqvCMuqKZnqqjxTWV+ZPjuDDj5cKLmUVY5ugWHPIQpwlx3uxulvj5dcKjGA7KGtCA==
X-Received: by 2002:aa7:939a:0:b0:510:7b1d:e18c with SMTP id t26-20020aa7939a000000b005107b1de18cmr20131926pfe.4.1652183287474;
        Tue, 10 May 2022 04:48:07 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902bd0800b0015e8d4eb26csm1794825pls.182.2022.05.10.04.48.06
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 04:48:07 -0700 (PDT)
Message-ID: <627a50f7.1c69fb81.9092f.47ab@mx.google.com>
Date: Tue, 10 May 2022 04:48:07 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.109-cip5-384-g722204542e8a
Subject: cip-gitlab/ci/pavel/linux-test baseline: 75 runs, 10 regressions (v5.10.109-cip5-384-g722204542e8a) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline: 75 runs, 10 regressions (v5.10.109=
-cip5-384-g722204542e8a)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
da850-lcdk                 | arm   | lab-baylibre  | gcc-10   | davinci_all=
_defconfig      | 1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

sun50i-a64-pine64-plus     | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =

sun50i-h6-pine-h64         | arm64 | lab-collabora | gcc-10   | defconfig  =
                | 1          =

zynqmp-zcu102              | arm64 | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

zynqmp-zcu102              | arm64 | lab-cip       | gcc-10   | defconfig  =
                | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.109-cip5-384-g722204542e8a/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.109-cip5-384-g722204542e8a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      722204542e8a1bb3bd684e6acee24ca8daeced2f =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
da850-lcdk                 | arm   | lab-baylibre  | gcc-10   | davinci_all=
_defconfig      | 1          =


  Details:     https://kernelci.org/test/plan/id/627a45fd9518b187018f5739

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: davinci_all_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.109-cip5-384-g722204542e8a/arm/davinci_all_defconfig/gcc-10/lab-bayl=
ibre/baseline-da850-lcdk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.109-cip5-384-g722204542e8a/arm/davinci_all_defconfig/gcc-10/lab-bayl=
ibre/baseline-da850-lcdk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/627a45fd9518b18=
7018f5741
        new failure (last pass: v4.19.233-516-ge5e741fbfc87)
        4 lines

    2022-05-10T10:59:59.243999  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3000
    2022-05-10T10:59:59.244328  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3400
    2022-05-10T10:59:59.244558  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3800
    2022-05-10T10:59:59.244748  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3c00
    2022-05-10T10:59:59.291798  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dale=
rt RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D4>   =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627a4f7cae2691bdb88f5742

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.109-cip5-384-g722204542e8a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.109-cip5-384-g722204542e8a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627a4f7cae2691bdb88f5=
743
        new failure (last pass: v4.19.233-516-ge5e741fbfc87) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627a4fb886cdb6ee918f573c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.109-cip5-384-g722204542e8a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.109-cip5-384-g722204542e8a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627a4fb886cdb6ee918f5=
73d
        new failure (last pass: v4.19.233-516-ge5e741fbfc87) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627a4fb986cdb6ee918f573f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.109-cip5-384-g722204542e8a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.109-cip5-384-g722204542e8a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627a4fb986cdb6ee918f5=
740
        new failure (last pass: v4.19.233-516-ge5e741fbfc87) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/627a50e585d87605578f5734

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.109-cip5-384-g722204542e8a/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.109-cip5-384-g722204542e8a/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627a50e585d87605578f5=
735
        new failure (last pass: v4.19.233-516-ge5e741fbfc87) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie   | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627a4fcc5e7aaad0cb8f572f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.109-cip5-384-g722204542e8a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.109-cip5-384-g722204542e8a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627a4fcc5e7aaad0cb8f5=
730
        new failure (last pass: v4.19.233-516-ge5e741fbfc87) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
sun50i-a64-pine64-plus     | arm64 | lab-broonie   | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/627a49cb38e3857c838f5718

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.109-cip5-384-g722204542e8a/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.109-cip5-384-g722204542e8a/arm64/defconfig/gcc-10/lab-broonie/baseli=
ne-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627a49cb38e3857c838f5=
719
        new failure (last pass: v4.19.233-516-ge5e741fbfc87) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
sun50i-h6-pine-h64         | arm64 | lab-collabora | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/627a49dce9886370088f572d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.109-cip5-384-g722204542e8a/arm64/defconfig/gcc-10/lab-collabora/base=
line-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.109-cip5-384-g722204542e8a/arm64/defconfig/gcc-10/lab-collabora/base=
line-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627a49dce9886370088f5=
72e
        new failure (last pass: v4.19.233-516-ge5e741fbfc87) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
zynqmp-zcu102              | arm64 | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627a4926f3c16e693c8f5749

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.109-cip5-384-g722204542e8a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.109-cip5-384-g722204542e8a/arm64/defconfig+arm64-chromebook/gcc-10/l=
ab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627a4926f3c16e693c8f5=
74a
        new failure (last pass: v4.19.233-516-ge5e741fbfc87) =

 =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
zynqmp-zcu102              | arm64 | lab-cip       | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/627a4a7a5b4ededea78f5717

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.109-cip5-384-g722204542e8a/arm64/defconfig/gcc-10/lab-cip/baseline-z=
ynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.109-cip5-384-g722204542e8a/arm64/defconfig/gcc-10/lab-cip/baseline-z=
ynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/627a4a7a5b4ededea78f5=
718
        new failure (last pass: v4.19.233-516-ge5e741fbfc87) =

 =20


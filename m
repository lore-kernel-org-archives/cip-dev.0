Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4ACEE7108B
	for <webhook@archiver.kernel.org>; Thu, 21 Sep 2023 15:15:43 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.20656.1695309336742271953
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Sep 2023 08:15:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=j83Ettfq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1c364fb8a4cso9405585ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 21 Sep 2023 08:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695309335; x=1695914135; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i5RlTPK97Ae1E2ZSAR0ZMFcYfE7InB76osSlks7e9m4=;
        b=j83EttfqktBOlNFm/hdEIb7/0GLUIk/MGOPzGQxktMZy/BzkJbSjdIHbWUet0sLcBh
         Myi8l+ujKI96R35A2MNtIlS1/YMJUGI3jCYLSIVQGrKp5/hybYhgzk9tdrZBQhmHMD05
         dQrKLnIGPVbpx4dNuiwm1alqDHYgnuRkSSs4fX1DGORWajyXxrZnbwuzH3S6hgVvgK2C
         W/O4SEvuE54F4lbzK8ejC4y+xxlus7t9bPEqeVndlqC81IxmHFIolIDwhD2VqyuVDF5i
         9iYaBMW73sLKhksCr8uUKZXmNmQYoKeQs3ACSAN7SKtCZj413gCTvYXs5/86Dy/78EZ1
         T7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695309335; x=1695914135;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i5RlTPK97Ae1E2ZSAR0ZMFcYfE7InB76osSlks7e9m4=;
        b=YVNInu+34JY5d+gjvYqjqRWMxKNqsqFj55CSrmMEOYpQoP0gPRwvHk5gjTbalwOJev
         DW+IQdLv2S9slzdiwKs+J0wUPk8FAlWJ3MTSdI+0JvekOVC8vaMNO+xeTi7wLOHyyRJL
         J8ulYT/UiZi2YJzNUEaJjBGJefvnwtAVNvnB3X3pz+a8KBC+BjFFjHhb2v7HWvQ5Oesb
         g0LX6COxOKrMr5o1TfdT25IHGG82ZcMKYpRFmv0HxdUGxzm7t+O7iCQj3x6xLnad3Sym
         ImE3Dr/A0linc1kStBSQUumZ2MlkZMaffMZE1upJtKqr6QmNE7LRyBxlJkna9ypyGlVq
         GRzA==
X-Gm-Message-State: AOJu0Yzn7oZv96/J1ET0iypEsNzBx2i9vpIee8kpW8RwdTM/IJpHYnQD
	05dpql0sQs991ZNM0vcKssUgZwZJlTgFffkzEptBAQ==
X-Google-Smtp-Source: AGHT+IF+HLoEQ6IcEh027ycTqZLybr8xhgFCF1tZve8UQ7lWyIWgdoN10BBn43S115e0L7o3F2KXTA==
X-Received: by 2002:a17:902:6806:b0:1b9:ea60:cd82 with SMTP id h6-20020a170902680600b001b9ea60cd82mr5091896plk.5.1695309335313;
        Thu, 21 Sep 2023 08:15:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u16-20020a170902e81000b001c446f12973sm1603075plg.203.2023.09.21.08.15.34
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 08:15:34 -0700 (PDT)
Message-ID: <650c5e16.170a0220.2a9b2.467e@mx.google.com>
Date: Thu, 21 Sep 2023 08:15:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v6.1.54-cip6-101-gb060fea6ba099
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 24 runs,
 5 regressions (v6.1.54-cip6-101-gb060fea6ba099)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Sep 2023 15:15:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13202

cip-gitlab/ci/pavel/linux-test baseline-nfs: 24 runs, 5 regressions (v6.1.5=
4-cip6-101-gb060fea6ba099)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

asus-cx9400-volteer      | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

imx6q-udoo               | arm    | lab-broonie   | gcc-10   | imx_v6_v7_de=
fconfig          | 1          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
                 | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.54-cip6-101-gb060fea6ba099/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.54-cip6-101-gb060fea6ba099
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b060fea6ba09908b06e60cc84cbf201d2a71a711 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650c4d96277f1b38368a0a6b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/650c4d96277f1b38368a0a74
        new failure (last pass: v5.10.194-cip39-500-gc5c4e5fc16817)

    2023-09-21T14:04:47.154973  <8>[   14.799720] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11588120_1.5.2.3.1>

    2023-09-21T14:04:47.256659  #

    2023-09-21T14:04:47.357415  / # #export SHELL=3D/bin/sh

    2023-09-21T14:04:47.357567  =


    2023-09-21T14:04:47.458088  / # export SHELL=3D/bin/sh. /lava-11588120/=
environment

    2023-09-21T14:04:47.458259  =


    2023-09-21T14:04:47.558843  / # . /lava-11588120/environment/lava-11588=
120/bin/lava-test-runner /lava-11588120/1

    2023-09-21T14:04:47.559079  =


    2023-09-21T14:04:47.564779  / # /lava-11588120/bin/lava-test-runner /la=
va-11588120/1

    2023-09-21T14:04:47.764137  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-cx9400-volteer      | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650c4d85f441e936ae8a0a88

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/650c4d85f441e936ae8a0a91
        new failure (last pass: v5.10.194-cip39-500-gc5c4e5fc16817)

    2023-09-21T14:04:39.847413  <8>[   15.717568] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11588125_1.5.2.3.1>

    2023-09-21T14:04:39.955482  /#

    2023-09-21T14:04:40.058085   # #export SHELL=3D/bin/sh

    2023-09-21T14:04:40.058863  =


    2023-09-21T14:04:40.160250  / # export SHELL=3D/bin/sh. /lava-11588125/=
environment

    2023-09-21T14:04:40.161095  =


    2023-09-21T14:04:40.262634  / # . /lava-11588125/environment/lava-11588=
125/bin/lava-test-runner /lava-11588125/1

    2023-09-21T14:04:40.264075  =


    2023-09-21T14:04:40.268946  / # /lava-11588125/bin/lava-test-runner /la=
va-11588125/1

    2023-09-21T14:04:40.441305  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
imx6q-udoo               | arm    | lab-broonie   | gcc-10   | imx_v6_v7_de=
fconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/650c508d71709fea938a0a50

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/650c508d71709fea9=
38a0a51
        failing since 29 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, fir=
st fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650c4cdc5f505b986e8a0a4e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm64/defconfig+arm64-chromebook/gcc-10/la=
b-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/650c4cdc5f505b986=
e8a0a4f
        new failure (last pass: v5.10.194-cip39-500-gc5c4e5fc16817) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/650c53e4e1afa3d02c8a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm64/defconfig/gcc-10/lab-cip/baseline-nf=
s-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.54-cip6-101-gb060fea6ba099/arm64/defconfig/gcc-10/lab-cip/baseline-nf=
s-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/650c53e4e1afa3d02=
c8a0a43
        failing since 36 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d) =

 =20


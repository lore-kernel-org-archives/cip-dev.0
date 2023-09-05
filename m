Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660C8EE49B8
	for <webhook@archiver.kernel.org>; Tue,  5 Sep 2023 22:51:56 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
 by mx.groups.io with SMTP id smtpd.web11.36688.1693954309336189072
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Sep 2023 15:51:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=m9jwQGLO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.180, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3a88ef953adso2387276b6e.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 05 Sep 2023 15:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693954308; x=1694559108; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Sec20LsWY/BkXf7gF4L2XO3+Ne27AKhlLz7xAwPuN9E=;
        b=m9jwQGLO6cL5nEzAwVdCWXQ7rpeNtkUC3exkQ1UgNQIxpyI0Kf2QZ0wnKCsImkBKXq
         N1QQ/gv8E8FH+549ZytEGSq0C3hvOBxD5kpy3+mOUxJIpoe42cEDPU/aN1RggxK3SaHT
         v7/5YRyxTJzT8VedUU580T9B1i6GvI6iF1mKv+sFqj7MoPfpv4x0NM1Q6u2oS4a4XwJB
         a26DOjOwKoBkC2zHsoNzbP7eAOqvZW8X3ofeMvQwZMAbceP85EBawniP1dlGCQIfpKpt
         VQ91/Rf57uN8wMjLL0c36tl0STSncHqtWbHHgDUHyumhRBbRVismj8zv3254qsdQ/i35
         0ZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693954308; x=1694559108;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sec20LsWY/BkXf7gF4L2XO3+Ne27AKhlLz7xAwPuN9E=;
        b=BAPpxeBWAvGwbLdexWDlruQ//Utiza2d2NVh/px82HfKpglShMAYqGpMzIzuauF3PT
         NYMDr1k7jKByhFGxJ4Sk8pfjqlAYT/0YJ2sqQ3W6UES7Y+6oNga4hZrCH2TESqWHF6lp
         D8IjIcZLk/BSxktRhUuUgdurvoPjDAQw0KCnlLWsq0yg5pfToXP15hvRqs6x32907ZaI
         BLxn/A3BQQiby3mw3XFk70YeGv3i3lNa4c1iFjgYOepGQh2TraCAIIhT+eSWkPyupYYp
         hgDn9/U3Iijgw3+GoAJlaGpGlgnJ5ygj92o7DlgV45DIvbx4DZnuZrjKrtzxe0v+XNQQ
         jNQA==
X-Gm-Message-State: AOJu0Yx7zn2/foXAbHsgOcbNIZWwsJfl/bh3Rncztc4AZuZdZvoz5EkQ
	rt8ls3IqQzg6cBi2hEnNRlIPftTj7o1HNLYavVU=
X-Google-Smtp-Source: AGHT+IGef/fGS1koG32AIn74RWBlqmc4vwVpDVqPFHZadtFAQwabvSRTOUG1tRqFFtbum+ZPqgg2Ww==
X-Received: by 2002:aca:1706:0:b0:3a7:c13:c8d1 with SMTP id j6-20020aca1706000000b003a70c13c8d1mr12968348oii.17.1693954308082;
        Tue, 05 Sep 2023 15:51:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t20-20020a63b254000000b0054fa8539681sm2578085pgo.34.2023.09.05.15.51.47
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 15:51:47 -0700 (PDT)
Message-ID: <64f7b103.630a0220.80162.6d89@mx.google.com>
Date: Tue, 05 Sep 2023 15:51:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.46-cip4-14-gb994de8f45440
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 23 runs,
 5 regressions (v6.1.46-cip4-14-gb994de8f45440)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Sep 2023 22:51:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12965

cip-gitlab/ci/pavel/linux-test baseline-nfs: 23 runs, 5 regressions (v6.1.4=
6-cip4-14-gb994de8f45440)

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
nux-test/kernel/v6.1.46-cip4-14-gb994de8f45440/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.46-cip4-14-gb994de8f45440
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b994de8f45440fdf9186ead9b3a13945833c1547 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f7a2a7bb14eeb100286dda

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64f7a2a7bb14eeb100286ddf
        new failure (last pass: v5.10.191-cip38-2-g05fb42f86d06a)

    2023-09-05T21:50:08.730033  + set +x

    2023-09-05T21:50:08.736460  <8>[   18.398893] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11440130_1.5.2.3.1>

    2023-09-05T21:50:08.841893  /#

    2023-09-05T21:50:08.942619   # #export SHELL=3D/bin/sh

    2023-09-05T21:50:08.942786  =


    2023-09-05T21:50:09.043355  / # export SHELL=3D/bin/sh. /lava-11440130/=
environment

    2023-09-05T21:50:09.043553  =


    2023-09-05T21:50:09.144075  / # . /lava-11440130/environment/lava-11440=
130/bin/lava-test-runner /lava-11440130/1

    2023-09-05T21:50:09.144369  =


    2023-09-05T21:50:09.148834  / # /lava-11440130/bin/lava-test-runner /la=
va-11440130/1
 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-cx9400-volteer      | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f7a2ed6c0bfe2024286d88

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64f7a2ed6c0bfe2024286d8d
        new failure (last pass: v5.10.191-cip38-2-g05fb42f86d06a)

    2023-09-05T21:51:25.082866  <8>[   20.707800] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11440119_1.5.2.3.1>

    2023-09-05T21:51:25.086057  + set +x

    2023-09-05T21:51:25.193663  / # #

    2023-09-05T21:51:25.296025  export SHELL=3D/bin/sh

    2023-09-05T21:51:25.296852  #

    2023-09-05T21:51:25.398359  / # export SHELL=3D/bin/sh. /lava-11440119/=
environment

    2023-09-05T21:51:25.399159  =


    2023-09-05T21:51:25.500912  / # . /lava-11440119/environment/lava-11440=
119/bin/lava-test-runner /lava-11440119/1

    2023-09-05T21:51:25.502152  =


    2023-09-05T21:51:25.507250  / # /lava-11440119/bin/lava-test-runner /la=
va-11440119/1
 =

    ... (12 line(s) more)  =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
imx6q-udoo               | arm    | lab-broonie   | gcc-10   | imx_v6_v7_de=
fconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64f7a87d1de2b6301f286d82

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64f7a87d1de2b6301=
f286d83
        failing since 14 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, fir=
st fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f7a83279990f65dc286d9d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm64/defconfig+arm64-chromebook/gcc-10/lab=
-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64f7a83279990f65d=
c286d9e
        failing since 14 days (last pass: v5.10.186-cip37-16-gf8567732a40d,=
 first fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/64f7a8d3d5eac4e36b286d9f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm64/defconfig/gcc-10/lab-cip/baseline-nfs=
-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.46-cip4-14-gb994de8f45440/arm64/defconfig/gcc-10/lab-cip/baseline-nfs=
-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64f7a8d3d5eac4e36=
b286da0
        failing since 20 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d) =

 =20


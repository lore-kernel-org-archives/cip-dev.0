Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2707EB64D8
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 02:55:01 +0000 (UTC)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
 by mx.groups.io with SMTP id smtpd.web10.3018.1686711299282287838
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 13 Jun 2023 19:54:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=k2jyKeeo;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.52, mailfrom: bot@kernelci.org)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6b3a0ae7c29so1198656a34.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 13 Jun 2023 19:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686711298; x=1689303298;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=plaE3mOv/k9mwN7Ct1cqpT9SbvY8WXYj2Tm3FZd3MWI=;
        b=k2jyKeeoivVnMLaSCUQAlzZC/rg6uVosv6NyRoeuVVnwQhttl2eEJfbJOkXHr055Jn
         32b9z71TzT7o5Uat+AFRqYM0i7Zo2HAhcxbfrDmyIO4w+XkQHBoNZYRlJ2sVx1bMfN72
         vkgFsic0oO25+9+wIcSfB2eI4f+Whz0ef3eu5lDMfrMYkXEjdHwyS0/07LN+cNf0cyZg
         q6lIo2SLMlwztlMob1mlNM872hStX2jW/mRHxYC6afiGWv7jHTSl3s9q8ioUwnaE7qpE
         bmkFujs8SEWgMe9zeCH6TYRCIQCHQSocsZ0opfchIHoL3lKosXS3VxiLPfhE7LCt3FNk
         Z2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686711298; x=1689303298;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plaE3mOv/k9mwN7Ct1cqpT9SbvY8WXYj2Tm3FZd3MWI=;
        b=OYdu5V/avU/9xIM2B4IAdNoXbaTA/oNB95mfqIZx5oqQqeISi+yY892DedjVWKO8uF
         Y6XrrNnYmMOhk7Jpi2zaJ/cax6uJ9b37mgn0+3IE6Z5f6ZI+c+ZPbyAgH6n2tyzwEHJQ
         Cb46KhV1Z/6f0WgYSyh0o6xs0MfPAVGb0ocg4/GTEBzH+kE4+mTF2fYKJArjw/aUBmLF
         lEz6eSRJQyG+MO5MPnTdhd+djG+Zunh555AyHYVP58SSfjhafCa9D3Ts/shDP879uyJQ
         11i2Tl8EYERxKKv0okFBY5W22Ab56B0UBI4wAH9r8eN/kGVUWJO7HEtcvrcxdlZw9q0x
         6c/g==
X-Gm-Message-State: AC+VfDwvYceMQmrfZb/JU91WJ0Omj2CSdhh9EyWpmcLHhbhLMVtC+pWW
	UZend6iNg52dQiScONs6HmuEImBHL3uUzgwwTcbXuA==
X-Google-Smtp-Source: ACHHUZ5ug5ZVMzChOKsbyZ9ijN5/sW9GIiiZ4r3p3OeIeeGXPgM9kaWQ9RtGuiOvj3Xt7eFKPNyk9A==
X-Received: by 2002:a05:6358:e813:b0:12b:dce7:f428 with SMTP id gi19-20020a056358e81300b0012bdce7f428mr5750502rwb.1.1686711297588;
        Tue, 13 Jun 2023 19:54:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l6-20020a632506000000b00513973a7014sm9945936pgl.12.2023.06.13.19.54.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 19:54:57 -0700 (PDT)
Message-ID: <64892c01.630a0220.52cb6.4e2c@mx.google.com>
Date: Tue, 13 Jun 2023 19:54:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-8-gc3d08808cfa7
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 70 runs,
 11 regressions (v5.10.182-cip35-8-gc3d08808cfa7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 02:55:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12000

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 70 runs, 11 regres=
sions (v5.10.182-cip35-8-gc3d08808cfa7)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.182-cip35-8-gc3d08808cfa7/plan/baseline-n=
fs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.182-cip35-8-gc3d08808cfa7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c3d08808cfa768cd3cc5ecfba684f72db3e04b9f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64892148798f9177d03061c5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/arm/omap2plus_defconfig/gcc-10=
/lab-broonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/arm/omap2plus_defconfig/gcc-10=
/lab-broonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64892148798f9177d=
03061c6
        new failure (last pass: v5.10.180-cip34-236-g6d219c607dc68) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64891f410fa3ae3733306158

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octop=
us.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octop=
us.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64891f410fa3ae373330615d
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T02:00:26.371302  + set +x<8>[   22.495731] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10716626_1.5.2.3.1>

    2023-06-14T02:00:26.371480  =


    2023-06-14T02:00:26.476821  / # #

    2023-06-14T02:00:26.578669  export SHELL=3D/bin/sh

    2023-06-14T02:00:26.578910  #

    2023-06-14T02:00:26.679529  / # export SHELL=3D/bin/sh. /lava-10716626/=
environment

    2023-06-14T02:00:26.679762  =


    2023-06-14T02:00:26.780438  / # . /lava-10716626/environment/lava-10716=
626/bin/lava-test-runner /lava-10716626/1

    2023-06-14T02:00:26.780962  =


    2023-06-14T02:00:26.785913  / # /lava-10716626/bin/lava-test-runner /la=
va-10716626/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64892057cdf4eb638f30633a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/x86_64/x86_64_defconfig+x86-ch=
romebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n=
4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/x86_64/x86_64_defconfig+x86-ch=
romebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n=
4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64892057cdf4eb638f30633f
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T02:04:49.610372  + set +x

    2023-06-14T02:04:49.617200  <8>[   28.787817] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10716735_1.5.2.3.1>

    2023-06-14T02:04:49.722206  / # #

    2023-06-14T02:04:49.822921  export SHELL=3D/bin/sh

    2023-06-14T02:04:49.823080  #

    2023-06-14T02:04:49.923636  / # export SHELL=3D/bin/sh. /lava-10716735/=
environment

    2023-06-14T02:04:49.923802  =


    2023-06-14T02:04:50.024417  / # . /lava-10716735/environment/lava-10716=
735/bin/lava-test-runner /lava-10716735/1

    2023-06-14T02:04:50.024682  =


    2023-06-14T02:04:50.029694  / # /lava-10716735/bin/lava-test-runner /la=
va-10716735/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64891f3f189de2cd0f30614f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64891f3f189de2cd0f306154
        failing since 54 days (last pass: v5.10.168-cip27-109-g23841ec76bec=
, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T02:00:15.244211  + set +x<8>[   22.361778] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10716657_1.5.2.3.1>

    2023-06-14T02:00:15.244669  =


    2023-06-14T02:00:15.352170  / # #

    2023-06-14T02:00:15.454573  export SHELL=3D/bin/sh

    2023-06-14T02:00:15.455310  #

    2023-06-14T02:00:15.556831  / # export SHELL=3D/bin/sh. /lava-10716657/=
environment

    2023-06-14T02:00:15.557555  =


    2023-06-14T02:00:15.658965  / # . /lava-10716657/environment/lava-10716=
657/bin/lava-test-runner /lava-10716657/1

    2023-06-14T02:00:15.660090  =


    2023-06-14T02:00:15.665422  / # /lava-10716657/bin/lava-test-runner /la=
va-10716657/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64891ff91d8c3357ff30613b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/x86_64/x86_64_defconfig+x86-ch=
romebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/x86_64/x86_64_defconfig+x86-ch=
romebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64891ff91d8c3357ff306140
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T02:03:25.348507  + set[   18.970481] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10716761_1.5.2.3.1>

    2023-06-14T02:03:25.348603   +x

    2023-06-14T02:03:25.453175  / # #

    2023-06-14T02:03:25.553850  export SHELL=3D/bin/sh

    2023-06-14T02:03:25.554059  #

    2023-06-14T02:03:25.654611  / # export SHELL=3D/bin/sh. /lava-10716761/=
environment

    2023-06-14T02:03:25.654838  =


    2023-06-14T02:03:25.755421  / # . /lava-10716761/environment/lava-10716=
761/bin/lava-test-runner /lava-10716761/1

    2023-06-14T02:03:25.755721  =


    2023-06-14T02:03:25.760272  / # /lava-10716761/bin/lava-test-runner /la=
va-10716761/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/648921ca484f0fea9e3061c0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/arm64/defconfig+arm64-chromebo=
ok+kselftest/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.t=
xt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/arm64/defconfig+arm64-chromebo=
ok+kselftest/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/648921ca484f0fea9=
e3061c1
        failing since 8 days (last pass: v5.10.180-cip33-21-g090289427e8b2,=
 first fail: v5.10.180-cip34-19-gae79bc689058c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648924b94f6a80e1e7306146

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/arm64/defconfig/gcc-10/lab-bro=
onie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/arm64/defconfig/gcc-10/lab-bro=
onie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/648924b94f6a80e1e=
7306147
        new failure (last pass: v5.10.180-cip34-236-g6d219c607dc68) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/64892059a6d9e5e80e306133

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/arm64/defconfig+arm64-chromebo=
ok+kselftest/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/arm64/defconfig+arm64-chromebo=
ok+kselftest/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64892059a6d9e5e80e306139
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T02:05:11.282889  /lava-10716782/1/../bin/lava-test-case

    2023-06-14T02:05:11.352230  <8>[   55.344800] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64892059a6d9e5e80e30613a
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T02:05:08.858267  <8>[   52.849405] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-06-14T02:05:10.037991  /lava-10716782/1/../bin/lava-test-case

    2023-06-14T02:05:10.146713  <8>[   54.139267] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6489218792781a88ef30612e

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-8-gc3d08808cfa7/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/6489218792781a88ef306134
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T02:10:01.961789  /lava-10716821/1/../bin/lava-test-case

    2023-06-14T02:10:01.997397  <8>[   38.279142] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/6489218792781a88ef306135
        failing since 54 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-06-14T02:10:00.856756  /lava-10716821/1/../bin/lava-test-case

    2023-06-14T02:10:00.896755  <8>[   37.178338] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2B2CD5BC4
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 14:01:06 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.9416.1695132065079128107
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 19 Sep 2023 07:01:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=LmAm4NIP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1c572c9c852so15972155ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 19 Sep 2023 07:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695132064; x=1695736864; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9dV8kCR+raRLs9Lbijs6VVskkb1XdY+a7+YVMhGXx/A=;
        b=LmAm4NIPnoMs99RKmA0PcV11pBKxwb9D+9kFQe6MHUIG3k7wZ/OQ/VHN1lMKIrduVq
         kuCl25lyHnQTYH/VOC7+Z9duwDMO9uRIeOaWrcAux6E674aHsKGVLwmNM4gJLISPpWMA
         IEoa/SjD5S8oe1hszobzowCCqO6Ieo+6AxEb+qJdnwiKP/HYnfZD0hxvXSgovtRsEM8+
         ZbzStlf7yL7bhM91pgfTAgDjigmHfiSxlEzHy+SiibM3x/6IEVQdzyt1AiKJtI5HPYOr
         2qnEE4azjcTgJbiISpGJ6WOaY4ITunSZR/Hev/ErdnsxXznxBWLyRPPe8Uzu+cKTBpEw
         2UqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695132064; x=1695736864;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9dV8kCR+raRLs9Lbijs6VVskkb1XdY+a7+YVMhGXx/A=;
        b=R3/Usaym48vFarvo2/AXOUGWz0wXjOKltljnWq3GjHmlqUHWSvqhLFzRP8yDE7CT12
         aWj+cj/2aZYlxQJz5feqq4ZJ3o5daMET3JYidm/ytb6G07UbhT/yjBa6rnomgMP9nPRg
         OidS/LULd4FseVNTEgmYd3C7hBYn0E5sG4rIwE1JlQJGc4uD3FtOh3d0xs1njRjGK77z
         8WbXs23mIDRgKGTwXPEvQM/Ddma2LezyJNoVLBYgxMJm13PX4/pgN1U5qnUs7lD05+re
         S1dV8K9JepHp8eX0ByJoZ5wwLo0xv30h7uMixBwr6oIM/u6xvaxvfaJk+/rppKEJYTMd
         gieg==
X-Gm-Message-State: AOJu0YyKjbFRjtSKVfaSyp/kTSOeNzqfC7kahM3E7agH7XZiKetMqWBa
	c+zrYIKxDYclbI6ydV1iez8xSvZJeoYqotnV2NYuxA==
X-Google-Smtp-Source: AGHT+IGn/rxogmLm+61gUsCWANz93ZnnJSN1i1mo2k8xlSIejTU14Ijq4xduKxgL6m1nVfpzRbcxPg==
X-Received: by 2002:a17:902:c10d:b0:1b8:7fd7:e022 with SMTP id 13-20020a170902c10d00b001b87fd7e022mr9603498pli.28.1695132063595;
        Tue, 19 Sep 2023 07:01:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902ec8100b001b9de2b905asm8326267plg.231.2023.09.19.07.01.02
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 07:01:03 -0700 (PDT)
Message-ID: <6509a99f.170a0220.718f4.d452@mx.google.com>
Date: Tue, 19 Sep 2023 07:01:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.191-cip38-661-g112a3073ff26
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 38 runs,
 12 regressions (v5.10.191-cip38-661-g112a3073ff26)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Sep 2023 14:01:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13150

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 38 runs, 12 regres=
sions (v5.10.191-cip38-661-g112a3073ff26)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2711-rpi-4-b              | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.191-cip38-661-g112a3073ff26/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.191-cip38-661-g112a3073ff26
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      112a3073ff2650cf1c0684ba93fb4a7284304812 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2711-rpi-4-b              | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65099f9bc2c33094aa8a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+kselftest/gc=
c-10/lab-collabora/baseline-nfs-bcm2711-rpi-4-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+kselftest/gc=
c-10/lab-collabora/baseline-nfs-bcm2711-rpi-4-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65099f9bc2c33094a=
a8a0a43
        new failure (last pass: v5.10.186-cip37-982-g80a0585c0aa62) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6509995c9102aba99c8a0a78

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oct=
opus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oct=
opus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6509995c9102aba99c8a0a81
        failing since 151 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-09-19T12:51:40.940631  + set<8>[   15.781354] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11570980_1.5.2.3.1>

    2023-09-19T12:51:40.940718   +x

    2023-09-19T12:51:41.045046  / # #

    2023-09-19T12:51:41.145606  export SHELL=3D/bin/sh

    2023-09-19T12:51:41.145773  #

    2023-09-19T12:51:41.246269  / # export SHELL=3D/bin/sh. /lava-11570980/=
environment

    2023-09-19T12:51:41.246446  =


    2023-09-19T12:51:41.346931  / # . /lava-11570980/environment/lava-11570=
980/bin/lava-test-runner /lava-11570980/1

    2023-09-19T12:51:41.347180  =


    2023-09-19T12:51:41.351611  / # /lava-11570980/bin/lava-test-runner /la=
va-11570980/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650999670751b3b3178a0a4f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/650999670751b3b3178a0a58
        failing since 151 days (last pass: v5.10.168-cip27-109-g23841ec76be=
c, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-09-19T12:51:33.089658  + set +x

    2023-09-19T12:51:33.096100  <8>[   20.094362] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11570973_1.5.2.3.1>

    2023-09-19T12:51:33.200244  / # #

    2023-09-19T12:51:33.300786  export SHELL=3D/bin/sh

    2023-09-19T12:51:33.300958  #

    2023-09-19T12:51:33.401419  / # export SHELL=3D/bin/sh. /lava-11570973/=
environment

    2023-09-19T12:51:33.401585  =


    2023-09-19T12:51:33.502060  / # . /lava-11570973/environment/lava-11570=
973/bin/lava-test-runner /lava-11570973/1

    2023-09-19T12:51:33.502370  =


    2023-09-19T12:51:33.507386  / # /lava-11570973/bin/lava-test-runner /la=
va-11570973/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65099b70a64be6256a8a0aae

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.t=
xt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65099b70a64be6256a8a0ab7
        failing since 151 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-09-19T13:00:21.411030  + set +x

    2023-09-19T13:00:21.417387  <8>[   22.491445] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11571011_1.5.2.3.1>

    2023-09-19T13:00:21.527027  / # #

    2023-09-19T13:00:21.629500  export SHELL=3D/bin/sh

    2023-09-19T13:00:21.630341  #

    2023-09-19T13:00:21.732064  / # export SHELL=3D/bin/sh. /lava-11571011/=
environment

    2023-09-19T13:00:21.732859  =


    2023-09-19T13:00:21.834649  / # . /lava-11571011/environment/lava-11571=
011/bin/lava-test-runner /lava-11571011/1

    2023-09-19T13:00:21.835967  =


    2023-09-19T13:00:21.841238  / # /lava-11571011/bin/lava-test-runner /la=
va-11571011/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65099d94bf5c6dc8468a0a51

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65099d94bf5c6dc84=
68a0a52
        new failure (last pass: v5.10.186-cip37-982-g80a0585c0aa62) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65099f916dcc1cd4f18a0a58

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65099f916dcc1cd4f=
18a0a59
        new failure (last pass: v5.10.186-cip37-982-g80a0585c0aa62) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6509a015d38310ab068a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc=
.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6509a015d38310ab0=
68a0a43
        new failure (last pass: v5.10.186-cip37-982-g80a0585c0aa62) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6509a4087f2d2acf278a0a61

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6509a4087f2d2acf2=
78a0a62
        new failure (last pass: v5.10.191-cip38-218-g9947ff6f0dba7) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6509a6cdd2489938a38a0a51

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6509a6cdd2489938a=
38a0a52
        failing since 38 days (last pass: v5.10.186-cip37-566-g36076316ef04=
9, first fail: v5.10.186-cip37-770-gddd36cfc4c4c8) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6509a7f9d6448fccfd8a0a47

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+kselftest/gc=
c-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+kselftest/gc=
c-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6509a7f9d6448fccf=
d8a0a48
        failing since 53 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/65099cf2f64688c68b8a0b8f

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/65099cf2f64688c68b8a0b99
        failing since 151 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-09-19T13:06:39.208829  /lava-11571043/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/65099cf2f64688c68b8a0b9a
        failing since 151 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-09-19T13:06:37.051821  <8>[   95.621039] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-09-19T13:06:38.112425  /lava-11571043/1/../bin/lava-test-case

    2023-09-19T13:06:38.148911  <8>[   96.719783] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20


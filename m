Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A568FC001DC
	for <webhook@archiver.kernel.org>; Thu, 27 Jul 2023 11:46:29 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web10.5299.1690458385770591884
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 27 Jul 2023 04:46:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=nVB/sZzM;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-686f0d66652so730090b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 27 Jul 2023 04:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690458384; x=1691063184;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TP0L5E98y+6JMjGQi5xodbUZWpB6US4NoiDCkO22KiM=;
        b=nVB/sZzMEk1OOpgbsdka/LxFlh1iNL+s4/sgVI/g6HQdYDwjFzV2cdpCaoCgMH2HE8
         pMXV0N1Gbt8QXDyQDfPQDL08hBLn8bKAapfNYaCof/VEh656gJxGw3UuCzVNbTllIPsZ
         SutOvPAy3g1pfa3GWNzzW30FwFMgc3uPVjO/2dDdjjww/rQarMpdmjq5MIbDV3nqWsYJ
         UlkoWa1wchv0qgCplb/sEt2i19kKM8vsCeEKpoxPxuaZgtbRHBP9qNvm6oCk5ba8+rHh
         FllQiMiYQ8JJXvvhqgV+4Ffb5RA2qxrKG3AySbvNVj4SQiYoRwXidwuwXsO9/588zBN8
         1rXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690458384; x=1691063184;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TP0L5E98y+6JMjGQi5xodbUZWpB6US4NoiDCkO22KiM=;
        b=Aj1jjcdxA82WVbM2L9QJEJHh33OXEUIXQ9i2gB2fTOuRDfcYjuwZ3XsRLHlToZuyhr
         QGHHf7SCSKJWJs+RjFrluW2Q4YsJUn2zoktRJLdjlfUT6QGq0KN5v6fH212UjjymHZdN
         245xhdsuQYPhGkgJOtxAP58kfLz1NkxWVFrxhZKDAI342AtyeZ7IvoF2oZ0DXgDAPY4Q
         x+fbDBcUtE6hPeJKXWSx/j+NVj2h3UhVtFr4QBUbRtYd61t8DHZ5cMF7FkhU3DE1WCfe
         gVJIwR5zwyEN3TCfrXyOePczuReOdFV8OS00fu+t9EzD6ekpSmhnf1Xv3GJo8cPoMMjZ
         QZMw==
X-Gm-Message-State: ABy/qLb9gj/mhuawuFhLi0orjFU194cWWXIOlvgwjTXUPY4Q3I77RQEh
	dJlWlpP/4BUz7WOTcd6xkLOWuIPNybBjwUaApdA4ZQ==
X-Google-Smtp-Source: APBJJlHGPvQD49FQbP2MNEsT7d8X2P/0jwYmrxNitNu9p/vCZ452w8RDWvKy3qzMHq5yWhNjXtx2Gg==
X-Received: by 2002:aa7:88c8:0:b0:686:4dd4:d56e with SMTP id k8-20020aa788c8000000b006864dd4d56emr7224668pff.2.1690458384324;
        Thu, 27 Jul 2023 04:46:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j18-20020a62b612000000b006862af4914esm1335572pff.145.2023.07.27.04.46.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 04:46:23 -0700 (PDT)
Message-ID: <64c2590f.620a0220.e6d2b.2090@mx.google.com>
Date: Thu, 27 Jul 2023 04:46:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.186-cip37-526-g7640d76efb649
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 37 runs,
 6 regressions (v5.10.186-cip37-526-g7640d76efb649)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jul 2023 11:46:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12510

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 37 runs, 6 regress=
ions (v5.10.186-cip37-526-g7640d76efb649)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.186-cip37-526-g7640d76efb649/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.186-cip37-526-g7640d76efb649
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      7640d76efb649f3c7f8a243e5a966ef7bd8bda13 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c24abe3eeac517b38ace42

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oc=
topus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oc=
topus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64c24abe3eeac517b38ace47
        failing since 97 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-07-27T10:44:58.407159  + set<8>[   17.872139] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11150706_1.5.2.3.1>

    2023-07-27T10:44:58.407283   +x

    2023-07-27T10:44:58.512066  / # #

    2023-07-27T10:44:58.612789  export SHELL=3D/bin/sh

    2023-07-27T10:44:58.613020  #

    2023-07-27T10:44:58.713573  / # export SHELL=3D/bin/sh. /lava-11150706/=
environment

    2023-07-27T10:44:58.713839  =


    2023-07-27T10:44:58.814386  / # . /lava-11150706/environment/lava-11150=
706/bin/lava-test-runner /lava-11150706/1

    2023-07-27T10:44:58.814673  =


    2023-07-27T10:44:58.819453  / # /lava-11150706/bin/lava-test-runner /la=
va-11150706/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64c24d44fb508ed8608ace36

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010n=
r-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010n=
r-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64c24d44fb508ed86=
08ace37
        new failure (last pass: v5.10.184-cip36-10-ga711f789c23e1) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64c24ab13eeac517b38ace1f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64c24ab13eeac517b38ace24
        failing since 97 days (last pass: v5.10.168-cip27-109-g23841ec76bec=
, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-07-27T10:44:43.933465  + <8>[   20.602677] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11150716_1.5.2.3.1>

    2023-07-27T10:44:43.934020  set +x

    2023-07-27T10:44:44.040585  / # #

    2023-07-27T10:44:44.143346  export SHELL=3D/bin/sh

    2023-07-27T10:44:44.144084  #

    2023-07-27T10:44:44.245659  / # export SHELL=3D/bin/sh. /lava-11150716/=
environment

    2023-07-27T10:44:44.246338  =


    2023-07-27T10:44:44.347723  / # . /lava-11150716/environment/lava-11150=
716/bin/lava-test-runner /lava-11150716/1

    2023-07-27T10:44:44.348892  =


    2023-07-27T10:44:44.353806  / # /lava-11150716/bin/lava-test-runner /la=
va-11150716/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64c24c4de42d1c1f108ace32

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.=
txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64c24c4de42d1c1f108ace37
        failing since 97 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-07-27T10:51:36.911185  + set +x<8>[   20.299501] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11150724_1.5.2.3.1>

    2023-07-27T10:51:36.911608  =


    2023-07-27T10:51:37.019327  / # #

    2023-07-27T10:51:37.121574  export SHELL=3D/bin/sh

    2023-07-27T10:51:37.122397  #

    2023-07-27T10:51:37.223669  / # export SHELL=3D/bin/sh. /lava-11150724/=
environment

    2023-07-27T10:51:37.224341  =


    2023-07-27T10:51:37.325733  / # . /lava-11150724/environment/lava-11150=
724/bin/lava-test-runner /lava-11150724/1

    2023-07-27T10:51:37.326733  =


    2023-07-27T10:51:37.332407  / # /lava-11150724/bin/lava-test-runner /la=
va-11150724/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64c24f0de3cab99fd08ace2a

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-526-g7640d76efb649/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64c24f0de3cab99fd08ace30
        failing since 97 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-07-27T11:03:31.171191  /lava-11150810/1/../bin/lava-test-case

    2023-07-27T11:03:31.200391  <8>[   97.168857] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64c24f0de3cab99fd08ace31
        failing since 97 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-07-27T11:03:30.088025  /lava-11150810/1/../bin/lava-test-case

    2023-07-27T11:03:30.118802  <8>[   96.087242] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64F8C001DB
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 10:42:02 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web11.104516.1692009715281092101
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Aug 2023 03:41:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=XPhPbxn3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-26934bc3059so3563665a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Aug 2023 03:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692009714; x=1692614514;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PQe3tucIqOdeQxeHkUSlzNHWkepHA8JOTjKCmTO6uxE=;
        b=XPhPbxn34oGiI8u5MJB9AZpVLBmJ/Ox1u7l3AkNxqv5GKteoD48aBF8LCE4bO+iJii
         aUCsKrUrLsobQwib4XV0a6x0+WRyMXIBtv3/nVXwlmanQJt9jcKLSN4JWHiPO7v68gLw
         lnguVh/swXPIO81zToWIrIxzMTt9SJokI3hgjyeqZhszk+iEZLwxPmBYd8ROu9bFfVF7
         LoO/6GBZ15DKhOOeloLxzSPh/1MVVUHP8p3DBqWWD+d7CVrMhvy+Ys3n7o97gF2IMVIL
         793aYhQ89cHkg9MEPcuA/I3tSqmeHrpgb+02+AHPRdKVB+0zEKah3w2QWlpNQ2bSdbLy
         DAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692009714; x=1692614514;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQe3tucIqOdeQxeHkUSlzNHWkepHA8JOTjKCmTO6uxE=;
        b=CDamYkN/qV597yAND4Mg+qYOiX9k27MJTIsKqSMHeD2U+/0j0l0zeHRPse/G+0xGBi
         3LmnIGwbIorDDjM/QmSOdXBgbHqni4WLaRTj50PBM02yjCOqAt3EC86Xt6S5vq2K1GlL
         7AVtic3K19FmgzlmaRv7UG/GxTSmDCi1oloCF1/VTRnoqdoD8kvNf3tSXJ7m12/VJBXB
         bbkf0y/BMs5BV901/QRZeOtqntvxAPZ6dHni9BHZMqDeDEoe8P4sTb33bA0oU0TPc8Zq
         4R8nnUhmcNlqD+CiJkuWR6pwzXMEWElgA5Fddhu0c2XNIKGzXImwa/d/5KVQypzXKLkY
         uQjw==
X-Gm-Message-State: AOJu0YwDsp7Aj2/pyoVLvbQJTCIUVzQvW0MkKNG7zxTl9z+IonB0NlFQ
	yTTfQaIUSZwBV77nSDbcP5qt0Tp+4jyFkOC8cwPsDUrT
X-Google-Smtp-Source: AGHT+IGrsvCjhIEmaFJitJvQapCgtOZYs9nZCVBBh+oBTr+PHZXyAkVLgTLSZYiwfnK4aFNTcB/XBQ==
X-Received: by 2002:a17:90a:51c5:b0:268:b54:7c13 with SMTP id u63-20020a17090a51c500b002680b547c13mr16208392pjh.9.1692009713744;
        Mon, 14 Aug 2023 03:41:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jk21-20020a170903331500b001b8b2fb52d4sm9099574plb.203.2023.08.14.03.41.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 03:41:53 -0700 (PDT)
Message-ID: <64da04f1.170a0220.e0273.0104@mx.google.com>
Date: Mon, 14 Aug 2023 03:41:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.288-cip101-1117-g1f3468542aa9e
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 20 runs,
 46 regressions (v4.19.288-cip101-1117-g1f3468542aa9e)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 10:42:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12634

cip-gitlab/ci/pavel/linux-test baseline-nfs: 20 runs, 46 regressions (v4.19=
.288-cip101-1117-g1f3468542aa9e)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =

asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =

beaglebone-black       | arm    | lab-broonie   | gcc-10   | multi_v7_defco=
nfig           | 12         =

beaglebone-black       | arm    | lab-cip       | gcc-10   | multi_v7_defco=
nfig           | 12         =

beaglebone-black       | arm    | lab-broonie   | gcc-10   | omap2plus_defc=
onfig          | 7          =

beaglebone-black       | arm    | lab-cip       | gcc-10   | omap2plus_defc=
onfig          | 7          =

hp-x360-14-G1-sona     | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =

rk3399-gru-kevin       | arm64  | lab-collabora | gcc-10   | defconfig+arm6=
4-chromebook   | 5          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.288-cip101-1117-g1f3468542aa9e/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.288-cip101-1117-g1f3468542aa9e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1f3468542aa9e444da3a41472888366e97d515e2 =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9ff3876e2fa168c35b323

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig+x86-chromeboo=
k/gcc-10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig+x86-chromeboo=
k/gcc-10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64d9ff3876e2fa168=
c35b324
        new failure (last pass: v5.10.186-cip37-12-g2710acbceb75) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9ff4fd45093cd5035b24b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig+x86-chromeboo=
k/gcc-10/lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig+x86-chromeboo=
k/gcc-10/lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64d9ff4fd45093cd5=
035b24c
        new failure (last pass: v5.10.186-cip37-12-g2710acbceb75) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
beaglebone-black       | arm    | lab-broonie   | gcc-10   | multi_v7_defco=
nfig           | 12         =


  Details:     https://kernelci.org/test/plan/id/64d9fe13d7cdde77d835b1d9

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/multi_v7_defconfig/gcc-10/lab-bro=
onie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/multi_v7_defconfig/gcc-10/lab-bro=
onie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64d9f=
e13d7cdde77d835b1dc
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:12:12.384729  /lava-50856/1/../bin/lava-test-case
    2023-08-14T10:12:12.441581  <8>[   80.122669] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/64d9fe13d7cdde77d835b1dd
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:12:11.285559  /lava-50856/1/../bin/lava-test-case
    2023-08-14T10:12:11.332354  <8>[   79.013626] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/64d9fe13d7cdde77d835b1df
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:12:08.947993  /lava-50856/1/../bin/lava-test-case
    2023-08-14T10:12:09.002087  <8>[   76.682960] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-08-14T10:12:10.055708  /lava-50856/1/../bin/lava-test-case
    2023-08-14T10:12:10.111854  <8>[   77.791314] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/64d9fe13d7cdde77d835b1e0
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:12:06.734612  /lava-50856/1/../bin/lava-test-case
    2023-08-14T10:12:06.789789  <8>[   74.469575] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-08-14T10:12:07.844121  /lava-50856/1/../bin/lava-test-case
    2023-08-14T10:12:07.898196  <8>[   75.578041] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/64d9fe13d7cdde77d835b1e1
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:12:04.527820  /lava-50856/1/../bin/lava-test-case
    2023-08-14T10:12:04.579987  <8>[   72.260883] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-08-14T10:12:05.630946  /lava-50856/1/../bin/lava-test-case
    2023-08-14T10:12:05.685683  <8>[   73.364968] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/64d9fe13d7cdde77d835b1eb
        new failure (last pass: v5.10.186-cip37-11-gafa55beeffce9)

    2023-08-14T10:11:50.868960  /lava-50856/1/../bin/lava-test-case
    2023-08-14T10:11:50.921623  <8>[   58.601016] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-08-14T10:11:51.975762  /lava-50856/1/../bin/lava-test-case
    2023-08-14T10:11:52.032486  <8>[   59.710961] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/64d9fe13d7cdde77d835b1ec
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:11:49.763832  /lava-50856/1/../bin/lava-test-case
    2023-08-14T10:11:49.819137  <8>[   57.497648] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mmc1-probed: https://kernelci.org/test/case/id/64d9=
fe13d7cdde77d835b1f4
        new failure (last pass: v5.10.186-cip37-11-gafa55beeffce9)

    2023-08-14T10:11:47.980640  /lava-50856/1/../bin/lava-test-case
    2023-08-14T10:11:48.031945  <8>[   55.711762] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mmc0-probed: https://kernelci.org/test/case/id/64d9=
fe13d7cdde77d835b1f5
        new failure (last pass: v5.10.186-cip37-11-gafa55beeffce9)

    2023-08-14T10:11:46.858980  /lava-50856/1/../bin/lava-test-case
    2023-08-14T10:11:46.911801  <8>[   54.592000] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap8240-driver-present: https://kernelci.org/test/=
case/id/64d9fe13d7cdde77d835b201
        new failure (last pass: v5.10.186-cip37-11-gafa55beeffce9)

    2023-08-14T10:11:41.534267  /lava-50856/1/../bin/lava-test-case
    2023-08-14T10:11:41.589443  <8>[   49.267622] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64d9fe13d7cdde77d835b204
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:11:38.391284  <8>[   46.071356] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 50856_1.6.2.4.1>
    2023-08-14T10:11:38.507354  / # #
    2023-08-14T10:11:38.610628  export SHELL=3D/bin/sh
    2023-08-14T10:11:38.611501  #
    2023-08-14T10:11:38.713465  / # export SHELL=3D/bin/sh. /lava-50856/env=
ironment
    2023-08-14T10:11:38.714342  =

    2023-08-14T10:11:38.816394  / # . /lava-50856/environment/lava-50856/bi=
n/lava-test-runner /lava-50856/1
    2023-08-14T10:11:38.817661  =

    2023-08-14T10:11:38.821601  / # /lava-50856/bin/lava-test-runner /lava-=
50856/1
    2023-08-14T10:11:39.019789  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/64d9fe13d7cd=
de77d835b208
        new failure (last pass: v5.10.186-cip37-11-gafa55beeffce9)
        1 lines

    2023-08-14T10:11:29.866739  / # =

    2023-08-14T10:11:29.873855  =

    2023-08-14T10:11:34.829859  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/50856/extract-nfsrootfs-vg_xmt20'
    2023-08-14T10:11:34.840905  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/50856/extract-nfsrootfs-vg_xmt20'
    2023-08-14T10:11:37.134149  / # export NFS_SERVER_IP=3D'192.168.56.123'
    2023-08-14T10:11:37.145203  export NFS_SERVER_IP=3D'192.168.56.123'
    2023-08-14T10:11:37.250450  / # #
    2023-08-14T10:11:37.258067  #
    2023-08-14T10:11:37.360729  / # export SHELL=3D/bin/sh
    2023-08-14T10:11:37.368199  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
beaglebone-black       | arm    | lab-cip       | gcc-10   | multi_v7_defco=
nfig           | 12         =


  Details:     https://kernelci.org/test/plan/id/64d9fe0a11aaa744b035b1fd

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/multi_v7_defconfig/gcc-10/lab-cip=
/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/multi_v7_defconfig/gcc-10/lab-cip=
/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64d9fe0a11aaa744b035b200
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:11:38.501017  / # #
    2023-08-14T10:11:38.604747  export SHELL=3D/bin/sh
    2023-08-14T10:11:38.605871  #
    2023-08-14T10:11:38.708190  / # export SHELL=3D/bin/sh. /lava-997139/en=
vironment
    2023-08-14T10:11:38.709343  =

    2023-08-14T10:11:38.812024  / # . /lava-997139/environment/lava-997139/=
bin/lava-test-runner /lava-997139/1
    2023-08-14T10:11:38.813837  =

    2023-08-14T10:11:38.822968  / # /lava-997139/bin/lava-test-runner /lava=
-997139/1
    2023-08-14T10:11:39.043423  + export TESTRUN_ID=3D1_bootrr
    2023-08-14T10:11:39.044023  + cd /lava-997139/1/tests/1_bootrr =

    ... (10 line(s) more)  =


  * baseline-nfs.bootrr.omap8240-driver-present: https://kernelci.org/test/=
case/id/64d9fe0a11aaa744b035b203
        new failure (last pass: v5.10.186-cip37-11-gafa55beeffce9)

    2023-08-14T10:11:41.576800  /lava-997139/1/../bin/lava-test-case
    2023-08-14T10:11:41.624500  <8>[   41.815043] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mmc0-probed: https://kernelci.org/test/case/id/64d9=
fe0a11aaa744b035b20f
        new failure (last pass: v5.10.186-cip37-11-gafa55beeffce9)

    2023-08-14T10:11:46.849557  /lava-997139/1/../bin/lava-test-case
    2023-08-14T10:11:46.912310  <8>[   47.101303] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mmc1-probed: https://kernelci.org/test/case/id/64d9=
fe0a11aaa744b035b210
        new failure (last pass: v5.10.186-cip37-11-gafa55beeffce9)

    2023-08-14T10:11:47.983059  /lava-997139/1/../bin/lava-test-case
    2023-08-14T10:11:48.039824  <8>[   48.229356] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/64d9fe0a11aaa744b035b218
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:11:49.794612  /lava-997139/1/../bin/lava-test-case
    2023-08-14T10:11:49.855760  <8>[   50.045151] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/64d9fe0a11aaa744b035b219
        new failure (last pass: v5.10.186-cip37-11-gafa55beeffce9)

    2023-08-14T10:11:50.910283  /lava-997139/1/../bin/lava-test-case
    2023-08-14T10:11:50.964504  <8>[   51.153892] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-08-14T10:11:52.019195  /lava-997139/1/../bin/lava-test-case
    2023-08-14T10:11:52.072074  <8>[   52.259967] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/64d9fe0a11aaa744b035b223
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:12:04.314622  <6>[   64.519324] platform sound: deferred =
probe pending
    2023-08-14T10:12:04.506202  /lava-997139/1/../bin/lava-test-case
    2023-08-14T10:12:04.558822  <8>[   64.747994] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-08-14T10:12:05.597845  /lava-997139/1/../bin/lava-test-case
    2023-08-14T10:12:05.660786  <8>[   65.851034] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/64d9fe0a11aaa744b035b224
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:12:06.714954  /lava-997139/1/../bin/lava-test-case
    2023-08-14T10:12:06.762094  <8>[   66.953124] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-08-14T10:12:07.817244  /lava-997139/1/../bin/lava-test-case
    2023-08-14T10:12:07.870017  <8>[   68.059826] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/64d9fe0a11aaa744b035b225
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:12:08.924936  /lava-997139/1/../bin/lava-test-case
    2023-08-14T10:12:08.977603  <8>[   69.167120] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-08-14T10:12:10.032484  /lava-997139/1/../bin/lava-test-case
    2023-08-14T10:12:10.100457  <8>[   70.272149] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>
    2023-08-14T10:12:10.101097  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: 84: assert_device-present: not found   =


  * baseline-nfs.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/i=
d/64d9fe0a11aaa744b035b227
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:12:11.244216  /lava-997139/1/../bin/lava-test-case
    2023-08-14T10:12:11.301008  <8>[   71.491941] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64d9f=
e0a11aaa744b035b228
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:12:12.355654  /lava-997139/1/../bin/lava-test-case
    2023-08-14T10:12:12.403947  <8>[   72.598100] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/64d9fe0a11aa=
a744b035b22a
        new failure (last pass: v5.10.186-cip37-11-gafa55beeffce9)
        1 lines

    2023-08-14T10:11:29.912621  / # =

    2023-08-14T10:11:29.916673  =

    2023-08-14T10:11:34.970263  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/997139/extract-nfsrootfs-6nifoa5g'
    2023-08-14T10:11:34.983726  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/997139/extract-nfsrootfs-6nifoa5g'
    2023-08-14T10:11:37.103566  / # export NFS_SERVER_IP=3D'192.168.1.1'
    2023-08-14T10:11:37.114826  export NFS_SERVER_IP=3D'192.168.1.1'
    2023-08-14T10:11:37.220695  / # #
    2023-08-14T10:11:37.236417  #
    2023-08-14T10:11:37.338661  / # export SHELL=3D/bin/sh
    2023-08-14T10:11:37.348764  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
beaglebone-black       | arm    | lab-broonie   | gcc-10   | omap2plus_defc=
onfig          | 7          =


  Details:     https://kernelci.org/test/plan/id/64d9fe83fefe986e9c35b202

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/omap2plus_defconfig/gcc-10/lab-br=
oonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/omap2plus_defconfig/gcc-10/lab-br=
oonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.omap-sham-driver-present: https://kernelci.org/test=
/case/id/64d9fe84fefe986e9c35b213
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:14:06.499859  /lava-50858/1/../bin/lava-test-case
    2023-08-14T10:14:06.610388  <8>[   70.488356] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-aes-driver-present: https://kernelci.org/test/=
case/id/64d9fe84fefe986e9c35b216
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:14:03.723848  /lava-50858/1/../bin/lava-test-case
    2023-08-14T10:14:03.840170  <8>[   67.718075] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/64d9fe84fefe986e9c35b219
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:13:59.690153  /lava-50858/1/../bin/lava-test-case
    2023-08-14T10:13:59.800820  <8>[   63.678937] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-08-14T10:14:00.905266  /lava-50858/1/../bin/lava-test-case
    2023-08-14T10:14:01.020324  <8>[   64.897835] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/64d9fe84fefe986e9c35b21a
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:13:58.449675  /lava-50858/1/../bin/lava-test-case
    2023-08-14T10:13:58.579787  <8>[   62.457483] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mmc1-probed: https://kernelci.org/test/case/id/64d9=
fe84fefe986e9c35b222
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:13:56.006977  /lava-50858/1/../bin/lava-test-case
    2023-08-14T10:13:56.118479  <8>[   59.997549] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mmc0-probed: https://kernelci.org/test/case/id/64d9=
fe84fefe986e9c35b223
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:13:54.750719  /lava-50858/1/../bin/lava-test-case
    2023-08-14T10:13:54.856929  <8>[   58.735797] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc0-probed RESULT=3Dfail>   =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/64d9fe84fefe=
986e9c35b238
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)
        1 lines

    2023-08-14T10:13:40.258076  / # =

    2023-08-14T10:13:40.266538  =

    2023-08-14T10:13:45.273175  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/50858/extract-nfsrootfs-a1lsf1pq'
    2023-08-14T10:13:45.284330  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/50858/extract-nfsrootfs-a1lsf1pq'
    2023-08-14T10:13:47.592813  / # export NFS_SERVER_IP=3D'192.168.56.193'
    2023-08-14T10:13:47.603962  export NFS_SERVER_IP=3D'192.168.56.193'
    2023-08-14T10:13:47.723011  / # #
    2023-08-14T10:13:47.728040  #
    2023-08-14T10:13:47.838943  / # export SHELL=3D/bin/sh
    2023-08-14T10:13:47.844032  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
beaglebone-black       | arm    | lab-cip       | gcc-10   | omap2plus_defc=
onfig          | 7          =


  Details:     https://kernelci.org/test/plan/id/64d9fe6a3af1aead5235b23a

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/omap2plus_defconfig/gcc-10/lab-ci=
p/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/omap2plus_defconfig/gcc-10/lab-ci=
p/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.mmc0-probed: https://kernelci.org/test/case/id/64d9=
fe6a3af1aead5235b24e
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:13:32.099471  /lava-997141/1/../bin/lava-test-case
    2023-08-14T10:13:32.202385  <8>[   50.343117] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mmc1-probed: https://kernelci.org/test/case/id/64d9=
fe6a3af1aead5235b24f
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:13:33.337228  /lava-997141/1/../bin/lava-test-case
    2023-08-14T10:13:33.430585  <8>[   51.571434] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/64d9fe6a3af1aead5235b257
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:13:35.671771  /lava-997141/1/../bin/lava-test-case
    2023-08-14T10:13:35.775209  <8>[   53.914821] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/64d9fe6a3af1aead5235b258
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:13:36.872623  /lava-997141/1/../bin/lava-test-case
    2023-08-14T10:13:36.974528  <8>[   55.114527] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-08-14T10:13:38.074122  /lava-997141/1/../bin/lava-test-case
    2023-08-14T10:13:38.174396  <8>[   56.314065] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-aes-driver-present: https://kernelci.org/test/=
case/id/64d9fe6a3af1aead5235b25b
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:13:40.775973  /lava-997141/1/../bin/lava-test-case
    2023-08-14T10:13:40.876676  <8>[   59.016712] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-sham-driver-present: https://kernelci.org/test=
/case/id/64d9fe6a3af1aead5235b25e
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:13:43.495821  /lava-997141/1/../bin/lava-test-case
    2023-08-14T10:13:43.595278  <8>[   61.735322] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/64d9fe6a3af1=
aead5235b26e
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)
        1 lines

    2023-08-14T10:13:18.099159  / # =

    2023-08-14T10:13:18.112822  =

    2023-08-14T10:13:23.178082  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/997141/extract-nfsrootfs-s6vd8kpi'
    2023-08-14T10:13:23.188793  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/997141/extract-nfsrootfs-s6vd8kpi'
    2023-08-14T10:13:25.355636  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2023-08-14T10:13:25.366337  export NFS_SERVER_IP=3D'192.168.11.5'
    2023-08-14T10:13:25.476177  / # #
    2023-08-14T10:13:25.479090  #
    2023-08-14T10:13:25.588043  / # export SHELL=3D/bin/sh
    2023-08-14T10:13:25.591090  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
hp-x360-14-G1-sona     | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9ff76d45093cd5035b259

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig+x86-chromeboo=
k/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig+x86-chromeboo=
k/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64d9ff76d45093cd5=
035b25a
        new failure (last pass: v5.10.186-cip37-12-g2710acbceb75) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
rk3399-gru-kevin       | arm64  | lab-collabora | gcc-10   | defconfig+arm6=
4-chromebook   | 5          =


  Details:     https://kernelci.org/test/plan/id/64d9fde77955bbd1d835b276

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig+arm64-chromebook/gcc-=
10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig+arm64-chromebook/gcc-=
10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64d9fde77955bbd1d835b27c
        failing since 60 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-08-14T10:11:31.281128  /lava-11283137/1/../bin/lava-test-case

    2023-08-14T10:11:31.308647  <8>[   40.340072] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64d9fde77955bbd1d835b27d
        failing since 60 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-08-14T10:11:30.215509  /lava-11283137/1/../bin/lava-test-case

    2023-08-14T10:11:30.242098  <8>[   39.273810] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.cros-ec-sysfs-driver-present: https://kernelci.org/=
test/case/id/64d9fde77955bbd1d835b2b2
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:11:25.555668  /lava-11283137/1/../bin/lava-test-case

    2023-08-14T10:11:25.583501  <8>[   34.614766] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sysfs-driver-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.cros-ec-lightbar-driver-present: https://kernelci.o=
rg/test/case/id/64d9fde77955bbd1d835b2bb
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:11:23.049819  <8>[   32.081496] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-keyb-probed RESULT=3Dpass>

    2023-08-14T10:11:24.076344  /lava-11283137/1/../bin/lava-test-case

    2023-08-14T10:11:24.104891  <8>[   33.135937] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-lightbar-driver-present RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.cros-ec-debugfs-driver-present: https://kernelci.or=
g/test/case/id/64d9fde77955bbd1d835b2c4
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:11:20.494146  <8>[   29.525859] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtpm-chip-is-online RESULT=3Dskip>

    2023-08-14T10:11:21.559463  /lava-11283137/1/../bin/lava-test-case
   =

 =20


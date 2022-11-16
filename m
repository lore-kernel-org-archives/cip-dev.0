Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021AFC43217
	for <webhook@archiver.kernel.org>; Wed, 16 Nov 2022 14:44:55 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web12.8069.1668609893922239951
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Nov 2022 06:44:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=8DVvn3zK;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d20so16597642plr.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Nov 2022 06:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gIEyXUAFo3j36CLqN3LDtW9IqN+EQCEwGgWhZ00ifVU=;
        b=8DVvn3zKLsRzanPPuHybe0kz97GN2TTWao0pu33LZsOuygnAPpw+vPSgvKD46tt5XY
         BcThP8z3em1D2GW7dPW5vEBQWuPJ2ifuom2ABQDHzpDLZGx0dfqhP028/tS66DLwZHE9
         JyPj4ZMHbmw2Z2PV5MZIQ4vE1/9029F6chs96X847FNm19CfFRwd+sUy1BmihTqjC4HH
         NhPOMrEKKVRtcCbPqlzG3uMniOYNXegcg0gVTN8sN7euopTPpRXPSceVNk7hPhc9SxV7
         oN09QcNIT2ifoe6hClNscaaBzJNsndm+j3H4nfcMw7pfXGxOd+PxbumVLmsASKktbYHG
         CfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gIEyXUAFo3j36CLqN3LDtW9IqN+EQCEwGgWhZ00ifVU=;
        b=t4nYtFrUF+HsNWQikVYBS7hFigu53XfhxrwkwoBuuM0gkpSFUI+5taBvdJc4g8j5s1
         Y6WyNw9WFUAM/Sk0SZSTr/1kQvt6ZV/YlrP/ostVlAh1fs9/yz9YyWSTbfMSWcCzuIuQ
         qaeeXPSdsEr8ovXrbwSyT2jiz/MPqzdbViGp6Yp+kpty7jJTAguKx3QkxldB73sKs3Jb
         qrChtfwgzII5h/nLVMs9+S1AzRgAM3/f0j0W2RjCiHuTU5a4cLAZXSdx3BuIf6HoGw54
         HB7Up+n60Nq35KV1j3zhqJ3hnTUrrOS+tgDs44345B2Fuvj08RwR8Gzo6xD4JVuwQpu8
         CKaA==
X-Gm-Message-State: ANoB5pntDVZoaEh/q1oqLQ038LIV2BbulLrLVT0DpHMIC6x/mHwL5PXa
	W/QhMR+yKEOfxCGxPX7w98v/hGabmig/yd0sfZ8=
X-Google-Smtp-Source: AA0mqf4ZlAYHRrg+auuJfyDENot1QFnjskbvZrgxt2zZNLhmb/JmZ/Um/3I9b2mT3SAD9FBOMv5LiQ==
X-Received: by 2002:a17:902:e413:b0:186:9cf4:e53b with SMTP id m19-20020a170902e41300b001869cf4e53bmr9248716ple.50.1668609892978;
        Wed, 16 Nov 2022 06:44:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 192-20020a6217c9000000b0056c04dee930sm10857482pfx.120.2022.11.16.06.44.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:44:52 -0800 (PST)
Message-ID: <6374f764.620a0220.385c.0faf@mx.google.com>
Date: Wed, 16 Nov 2022 06:44:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.154-cip20-99-g0e320e4d37e4
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 7 runs,
 10 regressions (v5.10.154-cip20-99-g0e320e4d37e4)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Nov 2022 14:44:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10049

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 7 runs, 10 regressio=
ns (v5.10.154-cip20-99-g0e320e4d37e4)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.154-cip20-99-g0e320e4d37e4/plan/ltp-timer=
s/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.154-cip20-99-g0e320e4d37e4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0e320e4d37e4f142f91e122ae645a9aea854c7a1

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  a15eb3cdfa3556203167572e15754f1f59ba26bf =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6374e4ed6941d8c4e92abd00

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.154-cip20-99-g0e320e4d37e4/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.154-cip20-99-g0e320e4d37e4/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6374e4ed694=
1d8c4e92abd05
        failing since 20 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6374e4ed694=
1d8c4e92abd05
        failing since 20 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6374e3c0455ecd47a22abd1d

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.154-cip20-99-g0e320e4d37e4/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.154-cip20-99-g0e320e4d37e4/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6374e3c0455=
ecd47a22abd22
        failing since 20 days (last pass: v5.10.147-cip18-56-g87bd4289362be=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6374e3c0455=
ecd47a22abd22
        failing since 20 days (last pass: v5.10.147-cip18-56-g87bd4289362be=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6374ebcd7d9d4fc6e32abd28

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.154-cip20-99-g0e320e4d37e4/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.154-cip20-99-g0e320e4d37e4/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6374ebcd7d9=
d4fc6e32abd2d
        failing since 20 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6374ebcd7d9=
d4fc6e32abd2d
        failing since 20 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6374e668845a8222af2abd25

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.154-cip20-99-g0e320e4d37e4/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.154-cip20-99-g0e320e4d37e4/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6374e668845=
a8222af2abd2a
        failing since 20 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6374e668845=
a8222af2abd2a
        failing since 20 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6374e46083c24164922abd0f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.154-cip20-99-g0e320e4d37e4/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.154-cip20-99-g0e320e4d37e4/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6374e46083c=
24164922abd14
        failing since 20 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6374e46083c=
24164922abd14
        failing since 20 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =20


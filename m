Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D998C636CB
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 12:29:47 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.134204.1700828982204552684
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Nov 2023 04:29:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=QOk7/m+O;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6cb66fbc63dso1350000b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Nov 2023 04:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700828981; x=1701433781; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RNem1EgbW2KTUZFHNV2pvdcgaH2isCy1RqiInjj7eGk=;
        b=QOk7/m+OQRhPPVw3erqG1fLJ+E1BbNm9esPoverLK16nx7dsimxI7iOPyf89onqRw4
         y7RdcrnSfa5fMAyuuCw3mKs3uvxcw61BjAkTVCH+RxAhpLuUPRw8LwyhptYBhDLLkJWs
         0JPVc934fxSaJLSmYWkqeBlA4rD4nqHl7CKc+kI9Dj7a67tC8T0m7+wVnxc3GVA2zSYF
         EZw8uRBCQpkcnYC6UC/Tz+Elmz7At6KkzxOfw94G8oxEm/B3xIUcFYywr63lFNgBkDx4
         +GnCRnoDht7fiiGDmg8tXx32DcrmJfg12ri43jg92sCC2ihJDXfyuhWh3ITagsmNeURQ
         bmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700828981; x=1701433781;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RNem1EgbW2KTUZFHNV2pvdcgaH2isCy1RqiInjj7eGk=;
        b=ne7CJROdpMgm5t7jzNXRkslGsulLSILbSax3hfaOkxssu1dRlhY6F1JWtFxeSi7BO5
         q0BZJxypD7RZZ9wD/wiJxb3ls9TMx8J+OlsPZJ754TQrgEEDtIjpa5vG5mw8WZR0O5d4
         8yZEyRGIY4Ve+kZasfmA/BtdWkA6fKG9KIjMVN6bYCfRYPF+au2hM6jYbBoJe7IS45pl
         acl+bPeH5QN06AhvfzFoXG7AKjkoT5wCcRuajrtPTwvwV9oysVnTveHk7zX5exoxnNWx
         /rumUkUii59kGx91h11kY8hgHNHg65jHscA6UUGXY96xg/z0tHF8gThaig4Xq3zvb0Mw
         IikA==
X-Gm-Message-State: AOJu0Yxhr2r5qz1iXM5USH6pMV8fmUudw3H8jqgzZ1kx2t5rIhyF1m9p
	/l7FmWg8c1lMeNX0FiIZVrYw4YQ8Grqx3tFKvFk=
X-Google-Smtp-Source: AGHT+IE/ZDYtDTra6sTVRd77SK3k8XCBeocItpXecdfuxqMR6lhd7FdDqHsp8BISEVAxyxKIK/1lDA==
X-Received: by 2002:a05:6a00:2d94:b0:6c4:d615:2169 with SMTP id fb20-20020a056a002d9400b006c4d6152169mr10117923pfb.10.1700828980583;
        Fri, 24 Nov 2023 04:29:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m17-20020a62f211000000b006c33bf9905fsm2733121pfh.25.2023.11.24.04.29.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 04:29:40 -0800 (PST)
Message-ID: <65609734.620a0220.e4da4.6665@mx.google.com>
Date: Fri, 24 Nov 2023 04:29:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v6.1.62-cip9-12-g3a5321f469b07
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 51 runs,
 8 regressions (v6.1.62-cip9-12-g3a5321f469b07)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 12:29:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13740

cip-gitlab/ci/pavel/linux-test baseline-nfs: 51 runs, 8 regressions (v6.1.6=
2-cip9-12-g3a5321f469b07)

Regressions Summary
-------------------

platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig+x86-board | 1          =

asus-CM1400CXA-dalboz     | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig+x86-board | 1          =

asus-cx9400-volteer       | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig+x86-board | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig         | 1          =

beaglebone-black          | arm    | lab-cip         | gcc-10   | omap2plus=
_defconfig        | 1          =

hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig+x86-board | 1          =

imx6dl-riotboard          | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig         | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.62-cip9-12-g3a5321f469b07/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.62-cip9-12-g3a5321f469b07
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3a5321f469b07e6124d325d7faaa2f8f1993f67c =



Test Regressions
---------------- =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65608c945807e509c17e4a7a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65608c945807e509c17e4a83
        new failure (last pass: v5.10.201-rt98-828-g27523c64bc5dd)

    2023-11-24T11:43:57.151095  + set +x

    2023-11-24T11:43:57.157775  <8>[   19.001607] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12073953_1.5.2.3.1>

    2023-11-24T11:43:57.266292  / # #

    2023-11-24T11:43:57.368508  export SHELL=3D/bin/sh

    2023-11-24T11:43:57.369210  #

    2023-11-24T11:43:57.470786  / # export SHELL=3D/bin/sh. /lava-12073953/=
environment

    2023-11-24T11:43:57.471562  =


    2023-11-24T11:43:57.573200  / # . /lava-12073953/environment/lava-12073=
953/bin/lava-test-runner /lava-12073953/1

    2023-11-24T11:43:57.574413  =


    2023-11-24T11:43:57.580842  / # /lava-12073953/bin/lava-test-runner /la=
va-12073953/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
asus-CM1400CXA-dalboz     | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65608c7cc41a6d3e9d7e4aa6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-nfs-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-nfs-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65608c7cc41a6d3e9d7e4aaf
        new failure (last pass: v5.10.201-rt98-828-g27523c64bc5dd)

    2023-11-24T11:43:34.293400  <8>[   17.663586] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12073948_1.5.2.3.1>

    2023-11-24T11:43:34.398874  / # #

    2023-11-24T11:43:34.499483  export SHELL=3D/bin/sh

    2023-11-24T11:43:34.499709  #

    2023-11-24T11:43:34.600409  / # export SHELL=3D/bin/sh. /lava-12073948/=
environment

    2023-11-24T11:43:34.600616  =


    2023-11-24T11:43:34.701152  / # . /lava-12073948/environment/lava-12073=
948/bin/lava-test-runner /lava-12073948/1

    2023-11-24T11:43:34.701491  =


    2023-11-24T11:43:34.705952  / # /lava-12073948/bin/lava-test-runner /la=
va-12073948/1

    2023-11-24T11:43:34.785280  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65608c592c43bbb7477e4a6d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65608c592c43bbb7477e4a76
        new failure (last pass: v5.10.201-rt98-828-g27523c64bc5dd)

    2023-11-24T11:43:12.396042  <8>[   17.412904] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12073938_1.5.2.3.1>

    2023-11-24T11:43:12.399634  + set +x

    2023-11-24T11:43:12.504402  / # #

    2023-11-24T11:43:12.605047  export SHELL=3D/bin/sh

    2023-11-24T11:43:12.605200  #

    2023-11-24T11:43:12.705715  / # export SHELL=3D/bin/sh. /lava-12073938/=
environment

    2023-11-24T11:43:12.705868  =


    2023-11-24T11:43:12.806473  / # . /lava-12073938/environment/lava-12073=
938/bin/lava-test-runner /lava-12073938/1

    2023-11-24T11:43:12.806707  =


    2023-11-24T11:43:12.811386  / # /lava-12073938/bin/lava-test-runner /la=
va-12073938/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65608f854eae6be4317e4ac5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm/multi_v7_defconfig/gcc-10/lab-broonie/b=
aseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm/multi_v7_defconfig/gcc-10/lab-broonie/b=
aseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65608f854eae6be43=
17e4ac6
        new failure (last pass: v5.10.201-rt98-828-g27523c64bc5dd) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
beaglebone-black          | arm    | lab-cip         | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65608ff5ef99834bb77e4a7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm/omap2plus_defconfig/gcc-10/lab-cip/base=
line-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm/omap2plus_defconfig/gcc-10/lab-cip/base=
line-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65608ff5ef99834bb=
77e4a7b
        new failure (last pass: v5.10.201-rt98-828-g27523c64bc5dd) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65608c614bca45b0167e4a7a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65608c614bca45b0167e4a83
        new failure (last pass: v5.10.201-rt98-828-g27523c64bc5dd)

    2023-11-24T11:43:44.700369  <8>[   20.124959] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12073955_1.5.2.3.1>

    2023-11-24T11:43:44.805510  / # #

    2023-11-24T11:43:44.906212  export SHELL=3D/bin/sh

    2023-11-24T11:43:44.906434  #

    2023-11-24T11:43:45.007019  / # export SHELL=3D/bin/sh. /lava-12073955/=
environment

    2023-11-24T11:43:45.007193  =


    2023-11-24T11:43:45.107733  / # . /lava-12073955/environment/lava-12073=
955/bin/lava-test-runner /lava-12073955/1

    2023-11-24T11:43:45.108028  =


    2023-11-24T11:43:45.112924  / # /lava-12073955/bin/lava-test-runner /la=
va-12073955/1

    2023-11-24T11:43:45.191515  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
imx6dl-riotboard          | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65608f474eae6be4317e4a7b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm/multi_v7_defconfig/gcc-10/lab-pengutron=
ix/baseline-nfs-imx6dl-riotboard.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm/multi_v7_defconfig/gcc-10/lab-pengutron=
ix/baseline-nfs-imx6dl-riotboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65608f474eae6be4317e4a84
        new failure (last pass: v5.10.201-rt98-828-g27523c64bc5dd)

    2023-11-24T11:55:43.084762  + set[   29.790922] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1010958_1.6.2.3.1>
    2023-11-24T11:55:43.084971   +x
    2023-11-24T11:55:43.192416  / # #
    2023-11-24T11:55:43.293645  export SHELL=3D/bin/sh
    2023-11-24T11:55:43.294136  #
    2023-11-24T11:55:43.394908  / # export SHELL=3D/bin/sh. /lava-1010958/e=
nvironment
    2023-11-24T11:55:43.395326  =

    2023-11-24T11:55:43.496133  / # . /lava-1010958/environment/lava-101095=
8/bin/lava-test-runner /lava-1010958/1
    2023-11-24T11:55:43.496734  =

    2023-11-24T11:55:43.499595  / # /lava-1010958/bin/lava-test-runner /lav=
a-1010958/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                  | regressions
--------------------------+--------+-----------------+----------+----------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora   | gcc-10   | x86_64_de=
fconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65608c4f4118d27f3c7e4a77

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65608c4f4118d27f3c7e4a80
        new failure (last pass: v5.10.201-rt98-828-g27523c64bc5dd)

    2023-11-24T11:42:53.125290  + <8>[   17.782637] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 12073883_1.5.2.3.1>

    2023-11-24T11:42:53.125396  set +x

    2023-11-24T11:42:53.230011  / # #

    2023-11-24T11:42:53.330598  export SHELL=3D/bin/sh

    2023-11-24T11:42:53.330820  #

    2023-11-24T11:42:53.431433  / # export SHELL=3D/bin/sh. /lava-12073883/=
environment

    2023-11-24T11:42:53.431612  =


    2023-11-24T11:42:53.532138  / # . /lava-12073883/environment/lava-12073=
883/bin/lava-test-runner /lava-12073883/1

    2023-11-24T11:42:53.532384  =


    2023-11-24T11:42:53.537555  / # /lava-12073883/bin/lava-test-runner /la=
va-12073883/1
 =

    ... (12 line(s) more)  =

 =20


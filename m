Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28995C61DF4
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 12:29:47 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web10.134205.1700828983211759775
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Nov 2023 04:29:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=wHdEE2wn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6c33ab26dddso1503537b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Nov 2023 04:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700828982; x=1701433782; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u3NhOBB2l3opjBzPEoRbXR5iUJSCjrGo4HZi/UZpG2Q=;
        b=wHdEE2wnkb7VT2QZit+I+HtT3uZBXvenMbjNt8acQfQk2RCP0d6U/KhsIAzaEsvuYV
         kYQsihxvOPSHqTMy1Htpv+TkptG9bZhqEmUyeFXzcXAS/UAMhlt4u4vZgkWYZkQrKYUR
         19K0qqWnTyfiZ+Z+HmdNRoRK5Y2toNxjlwADTxHj5bUb1f8tg1c4jWbpi0b2kNf+Ft29
         21pibkuP+cnCOlj4V/u6pK46EpQXaY1fhhIc3fTbgewVWVyRBxgPgwykNRrAQ66+8Ldo
         uVP06Npq3S+TVv3x8BI0GlZZdlhlLO4MdCLh4cs00/oCS9o28OL2ZDxviRTgtorys76J
         ALCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700828982; x=1701433782;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3NhOBB2l3opjBzPEoRbXR5iUJSCjrGo4HZi/UZpG2Q=;
        b=rCdZa3dvUqLlSIoYLAv2lVikR84oeHGqRbO1DSNZ/9DDuzNw0sL33gBigLlTzhe+Tq
         tgQivq3vISZberrsgIe/J3gULtEvnbHJoZItu1cK7kAj+V92LUZyAI/lxAGAKpiyVR+H
         WUUj0GmeBmxUecDi7qh/xqPKFwyKuQRon8KV9p64DCkqjUP1hggzBmRj8ub0pi0Gmptd
         aCWvU9VtGlQX4wUGCTxr6w+xPYzdZF8A1nsJVUmEYgVYE/gPBWXWrr2ejXplnlcJzn1M
         CC2tB38qITeqLqhtpJmoD2jASB95hgUbD3ZlggN3qsJlx+7Uhe8U7T0lcUqcYolUnXpx
         uRRg==
X-Gm-Message-State: AOJu0Yx+fUVqp7IzJeiolwzW9eOu8qZgDUb/l7htM6iktn3OlBROUrXr
	FaPdB9Rn6tKbDlc2KWMcOsl4+woIrKKCzvIcyvM=
X-Google-Smtp-Source: AGHT+IF6ZgJs4OqSQTwKEACQeK1/XlbdnKUi3bnw2znQdYVPFdiQ4tTXFrEhePfkhaU9KfRrr4dH9Q==
X-Received: by 2002:a05:6a20:12d3:b0:154:b4cb:2e8c with SMTP id v19-20020a056a2012d300b00154b4cb2e8cmr3087642pzg.24.1700828981671;
        Fri, 24 Nov 2023 04:29:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 21-20020a17090a195500b00285861b3bffsm1512292pjh.37.2023.11.24.04.29.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 04:29:40 -0800 (PST)
Message-ID: <65609734.170a0220.d54bc.3a12@mx.google.com>
Date: Fri, 24 Nov 2023 04:29:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v6.1.62-cip9-12-g3a5321f469b07
Subject: cip-gitlab/ci/pavel/linux-test baseline: 121 runs,
 7 regressions (v6.1.62-cip9-12-g3a5321f469b07)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 12:29:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13741

cip-gitlab/ci/pavel/linux-test baseline: 121 runs, 7 regressions (v6.1.62-c=
ip9-12-g3a5321f469b07)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

asus-CM1400CXA-dalboz     | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

at91sam9g20ek             | arm    | lab-broonie   | gcc-10   | multi_v5_de=
fconfig         | 1          =

beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig        | 1          =

hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

imx6ul-14x14-evk          | arm    | lab-nxp       | gcc-10   | imx_v6_v7_d=
efconfig        | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.62-cip9-12-g3a5321f469b07/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.62-cip9-12-g3a5321f469b07
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3a5321f469b07e6124d325d7faaa2f8f1993f67c =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65608c4f1e9026f1487e4a95

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65608c4f1e9026f1487e4a9e
        new failure (last pass: v5.10.201-rt98-828-g27523c64bc5dd)

    2023-11-24T11:45:16.853945  <8>[    7.786852] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12073942_1.4.2.3.1>

    2023-11-24T11:45:16.857160  + set +x

    2023-11-24T11:45:16.961722  / # #

    2023-11-24T11:45:17.062296  export SHELL=3D/bin/sh

    2023-11-24T11:45:17.062502  #

    2023-11-24T11:45:17.163059  / # export SHELL=3D/bin/sh. /lava-12073942/=
environment

    2023-11-24T11:45:17.163284  =


    2023-11-24T11:45:17.263812  / # . /lava-12073942/environment/lava-12073=
942/bin/lava-test-runner /lava-12073942/1

    2023-11-24T11:45:17.264135  =


    2023-11-24T11:45:17.270053  / # /lava-12073942/bin/lava-test-runner /la=
va-12073942/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-CM1400CXA-dalboz     | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65608c73fec7873f857e4a6d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65608c73fec7873f857e4a76
        new failure (last pass: v5.10.201-rt98-828-g27523c64bc5dd)

    2023-11-24T11:43:31.717027  + set<8>[   10.820434] <LAVA_SIGNAL_ENDRUN =
0_dmesg 12073924_1.4.2.3.1>

    2023-11-24T11:43:31.717112   +x

    2023-11-24T11:43:31.821203  / # #

    2023-11-24T11:43:31.921847  export SHELL=3D/bin/sh

    2023-11-24T11:43:31.922044  #

    2023-11-24T11:43:32.022598  / # export SHELL=3D/bin/sh. /lava-12073924/=
environment

    2023-11-24T11:43:32.022817  =


    2023-11-24T11:43:32.123337  / # . /lava-12073924/environment/lava-12073=
924/bin/lava-test-runner /lava-12073924/1

    2023-11-24T11:43:32.123631  =


    2023-11-24T11:43:32.128099  / # /lava-12073924/bin/lava-test-runner /la=
va-12073924/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
at91sam9g20ek             | arm    | lab-broonie   | gcc-10   | multi_v5_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65608cf59d33f809e37e4a8a

  Results:     48 PASS, 6 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm/multi_v5_defconfig/gcc-10/lab-broonie/b=
aseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm/multi_v5_defconfig/gcc-10/lab-broonie/b=
aseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65608cf59d33f809e37e4ac3
        new failure (last pass: v5.10.201-rt98-828-g27523c64bc5dd)

    2023-11-24T11:45:23.925823  + set +x
    2023-11-24T11:45:23.926246  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 269412_1.5.2=
.4.1>
    2023-11-24T11:45:24.041358  / # #
    2023-11-24T11:45:24.144436  export SHELL=3D/bin/sh
    2023-11-24T11:45:24.144833  #
    2023-11-24T11:45:24.245984  / # export SHELL=3D/bin/sh. /lava-269412/en=
vironment
    2023-11-24T11:45:24.246440  =

    2023-11-24T11:45:24.347721  / # . /lava-269412/environment/lava-269412/=
bin/lava-test-runner /lava-269412/1
    2023-11-24T11:45:24.348502  =

    2023-11-24T11:45:24.352207  / # /lava-269412/bin/lava-test-runner /lava=
-269412/1 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
beaglebone-black          | arm    | lab-cip       | gcc-10   | omap2plus_d=
efconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/6560912cb3354a80ca7e4ab4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm/omap2plus_defconfig/gcc-10/lab-cip/base=
line-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm/omap2plus_defconfig/gcc-10/lab-cip/base=
line-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6560912cb3354a80ca7e4=
ab5
        new failure (last pass: v5.10.201-rt98-828-g27523c64bc5dd) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65608c5c4c28b8210e7e4ab1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65608c5c4c28b8210e7e4aba
        new failure (last pass: v5.10.201-rt98-828-g27523c64bc5dd)

    2023-11-24T11:42:59.836504  + <8>[   11.552751] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 12073944_1.4.2.3.1>

    2023-11-24T11:42:59.836956  set +x

    2023-11-24T11:42:59.944345  / # #

    2023-11-24T11:43:00.046878  export SHELL=3D/bin/sh

    2023-11-24T11:43:00.047584  #

    2023-11-24T11:43:00.149213  / # export SHELL=3D/bin/sh. /lava-12073944/=
environment

    2023-11-24T11:43:00.149926  =


    2023-11-24T11:43:00.251446  / # . /lava-12073944/environment/lava-12073=
944/bin/lava-test-runner /lava-12073944/1

    2023-11-24T11:43:00.253052  =


    2023-11-24T11:43:00.257433  / # /lava-12073944/bin/lava-test-runner /la=
va-12073944/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
imx6ul-14x14-evk          | arm    | lab-nxp       | gcc-10   | imx_v6_v7_d=
efconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65608e8af01d64305e7e4a6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/base=
line-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/base=
line-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65608e8af01d64305e7e4=
a6e
        new failure (last pass: v5.10.201-rt98-828-g27523c64bc5dd) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65608c38b149b94e5b7e4a78

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65608c38b149b94e5b7e4a81
        new failure (last pass: v5.10.201-rt98-828-g27523c64bc5dd)

    2023-11-24T11:42:33.783007  + set<8>[   11.528160] <LAVA_SIGNAL_ENDRUN =
0_dmesg 12073909_1.4.2.3.1>

    2023-11-24T11:42:33.783113   +x

    2023-11-24T11:42:33.887670  / # #

    2023-11-24T11:42:33.988257  export SHELL=3D/bin/sh

    2023-11-24T11:42:33.988441  #

    2023-11-24T11:42:34.089008  / # export SHELL=3D/bin/sh. /lava-12073909/=
environment

    2023-11-24T11:42:34.089188  =


    2023-11-24T11:42:34.189669  / # . /lava-12073909/environment/lava-12073=
909/bin/lava-test-runner /lava-12073909/1

    2023-11-24T11:42:34.189934  =


    2023-11-24T11:42:34.194426  / # /lava-12073909/bin/lava-test-runner /la=
va-12073909/1
 =

    ... (12 line(s) more)  =

 =20


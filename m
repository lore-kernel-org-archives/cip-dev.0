Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C307C77B7F
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 14:42:09 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web10.28158.1684507324429407181
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 19 May 2023 07:42:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=jEc0rdF+;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-64d30ab1ef2so614551b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 19 May 2023 07:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684507323; x=1687099323;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uAgoO1qdTPJOT9OUZDVwsCSccXi4AGUn14gwS4E4uRg=;
        b=jEc0rdF+P8poegvLepLz/Af+RRAS+LTDsKz6C0iuniUl+bGWVdYF3tNSWtwozjIt/t
         MKR7jRqTcrsYXSfWJQ4Qc5d0cz0OdOaup0hb95ZBH8eFaQIO2HSk5V0zqUrSgeON7aBC
         NIWj3uM+IoJPg+PTRA6Ztgzhj9guh5V1cwP5UGFIOq3lvEIlCTZ+VYhUA/lVNWebOPI2
         BGwr07oZSd7jQSCQLKoovagrSZwNAOS9LF5rlSkG+pxFWZVQSLKcVxhOW8RNxNbzv8ih
         5YXJxckkKPL1B0H+jRJvmQ3FcTFOOA7R0H9z7eN1Npj0O0BxR4pKKeNQCvbGG8k/uLtz
         vvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684507323; x=1687099323;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uAgoO1qdTPJOT9OUZDVwsCSccXi4AGUn14gwS4E4uRg=;
        b=SdHw2Cl+EAEz2oCJezed2qJxZA2WIlYz8tMdI4ADrg6LU80CAKBs/kdNFWux5Xj5ye
         jEj3myYSpH3RhekXIfC7N4pj2dutKoBH/hipUTBubiMBWcl50KhjyBNJzzd90E1t81OO
         DRgCzYgVFIpSw2Qqq6H2vgjuQXIB9EqWmEIXKxxixuCvZMLxG7F5m4/Y9nUN93ctRWYL
         03qghFw4CPvR9oJDuoRb7ySP4DZ2ihSl7uPjShgpREW0o6bilvlMuWHMcIQyXdMvJvoB
         oiFnR2LR6zpFXTldjW5Tofu2+597L+md8K5aL0ZaYOsQM6nbs+IzC+sjDHJ2uoZRpHQj
         ffDw==
X-Gm-Message-State: AC+VfDwwthV4aaRS++iXrPaXKsfuo7RJRq+llatUhKDMsYOE8uNHpRzD
	riQWZ3NfVrnhI9zNZBrTTMB9T3grwD3TAhT1vW/tqQ==
X-Google-Smtp-Source: ACHHUZ6Zd+tsPZPf1eTKgBtya5IB0uMbnmAPSeirOm9l6OrB+Vbt9sX4YzRiDIn7xYWD+fqRNaI8Pg==
X-Received: by 2002:a05:6a00:1912:b0:63f:cfd:5d10 with SMTP id y18-20020a056a00191200b0063f0cfd5d10mr3814735pfi.8.1684507323273;
        Fri, 19 May 2023 07:42:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n10-20020aa7904a000000b0063aa1763146sm3208600pfo.17.2023.05.19.07.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:42:02 -0700 (PDT)
Message-ID: <64678aba.a70a0220.64cae.5e42@mx.google.com>
Date: Fri, 19 May 2023 07:42:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip33
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline-nfs: 36 runs,
 9 regressions (v5.10.180-cip33)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 14:42:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11560

cip/linux-5.10.y-cip baseline-nfs: 36 runs, 9 regressions (v5.10.180-cip33)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip33/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip33
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7f6b02104eb287caf662ade9a67f11896ab01fde =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646780ec8fd24df5e02e860c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/646780ec8fd24df5e02e8611
        failing since 125 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-19T13:59:57.185306  [   18.771306] <LAVA_SIGNAL_ENDRUN 0_dmesg =
10389242_1.5.2.3.1>

    2023-05-19T13:59:57.188184  + set +x

    2023-05-19T13:59:57.292679  / # #

    2023-05-19T13:59:57.393386  export SHELL=3D/bin/sh

    2023-05-19T13:59:57.393606  #

    2023-05-19T13:59:57.494217  / # export SHELL=3D/bin/sh. /lava-10389242/=
environment

    2023-05-19T13:59:57.494395  =


    2023-05-19T13:59:57.594863  / # . /lava-10389242/environment/lava-10389=
242/bin/lava-test-runner /lava-10389242/1

    2023-05-19T13:59:57.595186  =


    2023-05-19T13:59:57.600667  / # /lava-10389242/bin/lava-test-runner /la=
va-10389242/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64678173e963cda2292e85ee

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64678173e963cda22=
92e85ef
        new failure (last pass: v5.10.179-cip32-4-gd8c029e4780f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64678433468b55d06b2e8662

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64678433468b55d06b2e868b
        failing since 125 days (last pass: v5.10.158-cip22, first fail: v5.=
10.162-cip24)

    2023-05-19T14:13:20.160223  [   50.246044] <LAVA_SIGNAL_ENDRUN 0_dmesg =
485613_1.6.2.4.1>
    2023-05-19T14:13:20.279050  / # #
    2023-05-19T14:13:20.381394  export SHELL=3D/bin/sh
    2023-05-19T14:13:20.381957  #
    2023-05-19T14:13:20.483466  / # export SHELL=3D/bin/sh. /lava-485613/en=
vironment
    2023-05-19T14:13:20.484104  =

    2023-05-19T14:13:20.585682  / # . /lava-485613/environment/lava-485613/=
bin/lava-test-runner /lava-485613/1
    2023-05-19T14:13:20.586548  =

    2023-05-19T14:13:20.590934  / # /lava-485613/bin/lava-test-runner /lava=
-485613/1
    2023-05-19T14:13:20.793173  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6467832c5de80dd8d72e85ee

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-b=
lack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-b=
lack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6467832c5de80dd8d72e8622
        failing since 108 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.165-cip25)

    2023-05-19T14:09:20.227343  [   55.152335] <LAVA_SIGNAL_ENDRUN 0_dmesg =
485572_1.6.2.4.1>
    2023-05-19T14:09:20.352728  / # #
    2023-05-19T14:09:20.454818  export SHELL=3D/bin/sh
    2023-05-19T14:09:20.455521  #
    2023-05-19T14:09:20.557355  / # export SHELL=3D/bin/sh. /lava-485572/en=
vironment
    2023-05-19T14:09:20.557907  =

    2023-05-19T14:09:20.659519  / # . /lava-485572/environment/lava-485572/=
bin/lava-test-runner /lava-485572/1
    2023-05-19T14:09:20.660369  =

    2023-05-19T14:09:20.665057  / # /lava-485572/bin/lava-test-runner /lava=
-485572/1
    2023-05-19T14:09:20.912410  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64678a6ba3a595a11f2e85e6

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64678a6ba3a595a11f2e85e9
        failing since 108 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.165-cip25)

    2023-05-19T14:39:32.994865  + set +x
    2023-05-19T14:39:32.999146  <8>[   62.736350] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 937122_1.6.2.4.1>
    2023-05-19T14:39:33.237611  #
    2023-05-19T14:39:33.339814  / # #export SHELL=3D/bin/sh
    2023-05-19T14:39:33.340423  =

    2023-05-19T14:39:33.441748  / # export SHELL=3D/bin/sh. /lava-937122/en=
vironment
    2023-05-19T14:39:33.442276  =

    2023-05-19T14:39:33.543560  / # . /lava-937122/environment/lava-937122/=
bin/lava-test-runner /lava-937122/1
    2023-05-19T14:39:33.544447  =

    2023-05-19T14:39:33.550930  / # /lava-937122/bin/lava-test-runner /lava=
-937122/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6467881f7fe71f84372e85f5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6467881f7fe71f84372e85fa
        failing since 35 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-05-19T14:30:36.329780  + <8>[   22.773438] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10389237_1.5.2.3.1>

    2023-05-19T14:30:36.329909  set +x

    2023-05-19T14:30:36.434186  / # #

    2023-05-19T14:30:36.534910  export SHELL=3D/bin/sh

    2023-05-19T14:30:36.535152  #

    2023-05-19T14:30:36.635706  / # export SHELL=3D/bin/sh. /lava-10389237/=
environment

    2023-05-19T14:30:36.635988  =


    2023-05-19T14:30:36.736614  / # . /lava-10389237/environment/lava-10389=
237/bin/lava-test-runner /lava-10389237/1

    2023-05-19T14:30:36.736976  =


    2023-05-19T14:30:36.741134  / # /lava-10389237/bin/lava-test-runner /la=
va-10389237/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646787b24e05b8eb372e85e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/646787b24e05b8eb372e85eb
        failing since 35 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-05-19T14:28:43.578411  + set +x

    2023-05-19T14:28:43.584883  <8>[   29.312679] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10389268_1.5.2.3.1>

    2023-05-19T14:28:43.695925  / # #

    2023-05-19T14:28:43.799302  export SHELL=3D/bin/sh

    2023-05-19T14:28:43.800277  #

    2023-05-19T14:28:43.902014  / # export SHELL=3D/bin/sh. /lava-10389268/=
environment

    2023-05-19T14:28:43.902954  =


    2023-05-19T14:28:44.004816  / # . /lava-10389268/environment/lava-10389=
268/bin/lava-test-runner /lava-10389268/1

    2023-05-19T14:28:44.006413  =


    2023-05-19T14:28:44.011725  / # /lava-10389268/bin/lava-test-runner /la=
va-10389268/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646783499fc83c77492e8658

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/646783499fc83c77492e865d
        failing since 125 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-19T14:10:02.602724  / # #

    2023-05-19T14:10:02.704903  export SHELL=3D/bin/sh

    2023-05-19T14:10:02.705647  #

    2023-05-19T14:10:02.807438  / # export SHELL=3D/bin/sh. /lava-10389593/=
environment

    2023-05-19T14:10:02.808182  =


    2023-05-19T14:10:02.909786  / # . /lava-10389593/environment/lava-10389=
593/bin/lava-test-runner /lava-10389593/1

    2023-05-19T14:10:02.910091  =


    2023-05-19T14:10:02.926191  / # /lava-10389593/bin/lava-test-runner /la=
va-10389593/1

    2023-05-19T14:10:03.138149  + export TESTRUN_ID=3D1_bootrr

    2023-05-19T14:10:03.138615  + cd /lava-10389593/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/646783d3077166849b2e8634

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-nfs-rk3399-r=
ock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-nfs-rk3399-r=
ock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230512.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/646783d3077166849=
b2e8635
        new failure (last pass: v5.10.179-cip32-4-gd8c029e4780f) =

 =20


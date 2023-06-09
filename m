Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AF7C7EE29
	for <webhook@archiver.kernel.org>; Fri,  9 Jun 2023 15:57:19 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web11.17098.1686326235529860009
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Jun 2023 08:57:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=aBZSjcsm;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1b24ff03400so7787545ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Jun 2023 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686326234; x=1688918234;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4oO3JxnWZ01lR7ZK9UMpNE68e8yKjRnzB/7MzazgN0U=;
        b=aBZSjcsmQO16o9jCRVr8bL/x8OYKLZwfzV0fjp7TXzbLfiDVsdeWp1vSPy6UozhBuJ
         3sj3kIPBtCI+L4l0g3cIxjarwgyTMVa2z0wX7pBrV90U1Ead2KDyonBH3H+U9OVBk1Fr
         Oz6pb30Mx5XU1YoLXSvN7egCONw+FA36l305DBCtd2hgeBEWA5RElG5FIosscA/u36lY
         hk699SKDYlpikrQts2vkrn2QJTFwphMnHFs2kowJeMTn2fyuQnjCsKO4V67H/F6SHieg
         aM6J9L/ndXjkrNhA+rhwVeNYtqMuxbV32PbdWpPldGEfk49Mq3uAzhlYDc5wFHahpbJ9
         LAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686326234; x=1688918234;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4oO3JxnWZ01lR7ZK9UMpNE68e8yKjRnzB/7MzazgN0U=;
        b=hjYLY30ZFGvnWU6lzQp9LwY2b0XE9PfFU95hf9D0Z6aeqx9buKmFCQ6KjfOBM8xw65
         tldGHyV5dl68kVdVp2oD162DA+2OfBTgw75yQohRp6UYwewEI4iq12y0KtsJDf9laLe+
         vOlf4S5CJtas2ItV726b2oOn19PQm2MuT6IWW9PBwFkqq4mnqZPcTE6ZzMjAnN4gaREB
         PZ5ncBiNHnZDjkADs9ZLxaG8/2N/1JZxwoL9vdiYT+elE1eWo76ooqWCrGPF9g//uoyn
         WlX5YL897lC0xBj2VXKI6moepcK90sWJC8XwTUPsgk7Mp170lKKNunsjR7LPIKqY7a6F
         Fm/w==
X-Gm-Message-State: AC+VfDxusm9cdilueGdfWUnZjQKHxQ3JM3XrM9galNS23uUhwJ8BS/46
	JzbrqQEkFuVkpImldhl5yhzD9o4R7SgDmDSjWj3rkw==
X-Google-Smtp-Source: ACHHUZ7an1rsQdoBiI5TfA67ivvCOKUSPEQC2OhMphXTS8HXjhVNv/wHqyo60VsTNQxL4YKMSFnZzA==
X-Received: by 2002:a17:903:120b:b0:1ae:2c87:f771 with SMTP id l11-20020a170903120b00b001ae2c87f771mr1785541plh.20.1686326234261;
        Fri, 09 Jun 2023 08:57:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902680300b001ab12ccc2a7sm3471053plk.98.2023.06.09.08.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 08:57:13 -0700 (PDT)
Message-ID: <64834bd9.170a0220.dcdf0.73d0@mx.google.com>
Date: Fri, 09 Jun 2023 08:57:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35
Subject: cip/linux-5.10.y-cip baseline-nfs: 33 runs,
 5 regressions (v5.10.182-cip35)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jun 2023 15:57:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11944

cip/linux-5.10.y-cip baseline-nfs: 33 runs, 5 regressions (v5.10.182-cip35)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.182-cip35/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.182-cip35
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      52f00829380df13d144d530b732464a175350508 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64833fe50a83bf2a63306404

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64833fe50a83bf2a63306409
        failing since 146 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-09T15:05:51.087048  + set +x

    2023-06-09T15:05:51.093321  [   22.915245] <LAVA_SIGNAL_ENDRUN 0_dmesg =
10660849_1.5.2.3.1>

    2023-06-09T15:05:51.198110  / # #

    2023-06-09T15:05:51.298858  export SHELL=3D/bin/sh

    2023-06-09T15:05:51.299108  #

    2023-06-09T15:05:51.399765  / # export SHELL=3D/bin/sh. /lava-10660849/=
environment

    2023-06-09T15:05:51.399986  =


    2023-06-09T15:05:51.500576  / # . /lava-10660849/environment/lava-10660=
849/bin/lava-test-runner /lava-10660849/1

    2023-06-09T15:05:51.500900  =


    2023-06-09T15:05:51.506955  / # /lava-10660849/bin/lava-test-runner /la=
va-10660849/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64834550974f42798f30613e

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64834550974f42798f306141
        failing since 146 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-09T15:28:38.687233  / # #
    2023-06-09T15:28:38.790591  export SHELL=3D/bin/sh
    2023-06-09T15:28:38.791668  #
    2023-06-09T15:28:38.894153  / # export SHELL=3D/bin/sh. /lava-958171/en=
vironment
    2023-06-09T15:28:38.895236  =

    2023-06-09T15:28:38.997724  / # . /lava-958171/environment/lava-958171/=
bin/lava-test-runner /lava-958171/1
    2023-06-09T15:28:38.999477  =

    2023-06-09T15:28:39.013439  / # /lava-958171/bin/lava-test-runner /lava=
-958171/1
    2023-06-09T15:28:39.298113  + export TESTRUN_ID=3D1_bootrr
    2023-06-09T15:28:39.298825  + cd /lava-958171/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648340827e0d1f0c1a306175

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/648340827e0d1f0c1a30617a
        failing since 56 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-06-09T15:08:30.187905  + <8>[   22.701522] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10660853_1.5.2.3.1>

    2023-06-09T15:08:30.188317  set +x

    2023-06-09T15:08:30.296119  / # #

    2023-06-09T15:08:30.398249  export SHELL=3D/bin/sh

    2023-06-09T15:08:30.398958  #

    2023-06-09T15:08:30.500437  / # export SHELL=3D/bin/sh. /lava-10660853/=
environment

    2023-06-09T15:08:30.501324  =


    2023-06-09T15:08:30.602942  / # . /lava-10660853/environment/lava-10660=
853/bin/lava-test-runner /lava-10660853/1

    2023-06-09T15:08:30.604165  =


    2023-06-09T15:08:30.608812  / # /lava-10660853/bin/lava-test-runner /la=
va-10660853/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64833fe2f41a431d5a306152

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64833fe2f41a431d5a306157
        failing since 56 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-06-09T15:06:05.765760  + set +x

    2023-06-09T15:06:05.772583  [   20.300538] <LAVA_SIGNAL_ENDRUN 0_dmesg =
10660864_1.5.2.3.1>

    2023-06-09T15:06:05.876935  / # #

    2023-06-09T15:06:05.977547  export SHELL=3D/bin/sh

    2023-06-09T15:06:05.977731  #

    2023-06-09T15:06:06.078213  / # export SHELL=3D/bin/sh. /lava-10660864/=
environment

    2023-06-09T15:06:06.078488  =


    2023-06-09T15:06:06.179098  / # . /lava-10660864/environment/lava-10660=
864/bin/lava-test-runner /lava-10660864/1

    2023-06-09T15:06:06.179420  =


    2023-06-09T15:06:06.183928  / # /lava-10660864/bin/lava-test-runner /la=
va-10660864/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64833fa14518ffc4a9306175

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64833fa14518ffc4a930617a
        failing since 146 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-09T15:04:50.126528  / # #

    2023-06-09T15:04:50.228878  export SHELL=3D/bin/sh

    2023-06-09T15:04:50.229650  #

    2023-06-09T15:04:50.331355  / # export SHELL=3D/bin/sh. /lava-10660798/=
environment

    2023-06-09T15:04:50.332153  =


    2023-06-09T15:04:50.434004  / # . /lava-10660798/environment/lava-10660=
798/bin/lava-test-runner /lava-10660798/1

    2023-06-09T15:04:50.435204  =


    2023-06-09T15:04:50.449073  / # /lava-10660798/bin/lava-test-runner /la=
va-10660798/1

    2023-06-09T15:04:50.592842  + export TESTRUN_ID=3D1_bootrr

    2023-06-09T15:04:50.608706  + cd /lava-10660798/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =20


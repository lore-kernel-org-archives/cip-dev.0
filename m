Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17181EB64D7
	for <webhook@archiver.kernel.org>; Thu, 22 Jun 2023 02:04:53 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web11.125.1687399492031348938
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 21 Jun 2023 19:04:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=MTCwKVoX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1b55fc3a71cso24367935ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 21 Jun 2023 19:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687399491; x=1689991491;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=db39MFto1vRFIErosD6EbfONMGQSL3WhZgBcTdUbFUA=;
        b=MTCwKVoXv77cLLmm9o8Y6br7KKNtJ2ikmfIOZfmA6Et6DA0TCfFtudIlSRv1zx/Gqf
         9PGtI63DCsiA/1DiQvtxXjuNALWLiGTnv2jHLZPCQIcHQj1EpnJcgvs9KegSKzTzeveJ
         uCvequmQtSRhGg+Z2N0uwkIz/dZ+EsYir0Ti6cwpW8KGVol2Y7ADT0Ht/iT6FUOi0Vua
         fMy336VDebiaPw/SpUhFGu9dl5rM7mfHwOAaSDezoVnlRWenDdJjKWgYR0OsDmRupCd2
         i5r5+WINByeL96606Aw7gEO57/wUAvw1rE0jWzOqv7IfwCxrme14Y/FpZaP7J4ku7pI4
         zV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687399491; x=1689991491;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=db39MFto1vRFIErosD6EbfONMGQSL3WhZgBcTdUbFUA=;
        b=hEg1QVa3nS6zm5/rYR9E8fbnyE1l8jkU5WXBMcqZ5xo4Rkeh8gZ990Jcycp/jLXGNO
         0Yl9u/LzXisLknLN58j3ifEPP7vel9Ou4/em5XoVatkuxLuww5NWEoKL8vt7cz3/mbmA
         zoN40C9/bnGd5HzUa1GcpVfBRjd3o7YCdflAGJYC2NWjxgOzdQEXVCgNxS9TS2MujIHa
         WrjM1OdoA7l0/UcLep3TFXDCI/H2bOkdFLg6GlbZcZmbWZl+2ZHmrF6YEK/F5VrbBQAP
         gUsTpDtJtL4nSFvntnUBW5J6xKEzFO/OErA0jdsYwi8SD47ztZDgJDQ0BGHEJ2TzcyZA
         yOMQ==
X-Gm-Message-State: AC+VfDwlGrlYdCXX/d/2jjNnGv9kVtCWcUwYBSsKUze1dIzYUtvMR18K
	ej7+SaVZXX3gcqSR/Moj3P1kb+wBVo7uT//yVk9TwQ==
X-Google-Smtp-Source: ACHHUZ50OEKC6adjkWNyNsMGzzSJIDk7V4YGGdPFQ4VAX82oEXQ/aw4s6dXlrIfo1uHfBH9Y4LZizQ==
X-Received: by 2002:a17:902:d34b:b0:1b3:f8db:6f0e with SMTP id l11-20020a170902d34b00b001b3f8db6f0emr12782872plk.43.1687399490586;
        Wed, 21 Jun 2023 19:04:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jh5-20020a170903328500b001ac7c725c1asm377901plb.6.2023.06.21.19.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 19:04:49 -0700 (PDT)
Message-ID: <6493ac41.170a0220.7298f.1c25@mx.google.com>
Date: Wed, 21 Jun 2023 19:04:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.184-cip36
Subject: cip/linux-5.10.y-cip baseline-nfs: 48 runs,
 8 regressions (v5.10.184-cip36)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jun 2023 02:04:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12106

cip/linux-5.10.y-cip baseline-nfs: 48 runs, 8 regressions (v5.10.184-cip36)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.184-cip36/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.184-cip36
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f34f3ecd0387c3ad8b34bf65ac19ec84a38f2333 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64939eab9cd57b828a306141

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64939eab9cd57b828a306148
        failing since 158 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-22T01:06:29.788308  [   18.643956] <LAVA_SIGNAL_ENDRUN 0_dmesg =
10853272_1.5.2.3.1>

    2023-06-22T01:06:29.791498  + set +x

    2023-06-22T01:06:29.892693  #

    2023-06-22T01:06:29.993531  / # #export SHELL=3D/bin/sh

    2023-06-22T01:06:29.993756  =


    2023-06-22T01:06:30.094314  / # export SHELL=3D/bin/sh. /lava-10853272/=
environment

    2023-06-22T01:06:30.094530  =


    2023-06-22T01:06:30.195076  / # . /lava-10853272/environment/lava-10853=
272/bin/lava-test-runner /lava-10853272/1

    2023-06-22T01:06:30.195392  =


    2023-06-22T01:06:30.200000  / # /lava-10853272/bin/lava-test-runner /la=
va-10853272/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6493a172c4076974e0306136

  Results:     42 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20ek=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20ek=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6493a172c4076974e0306167
        failing since 158 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-22T01:17:59.480887  / # =

    2023-06-22T01:17:59.488651  =

    2023-06-22T01:18:04.512979  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/650019/extract-nfsrootfs-_jul5x_g'
    2023-06-22T01:18:04.523901  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/650019/extract-nfsrootfs-_jul5x_g'
    2023-06-22T01:18:06.816441  / # export NFS_SERVER_IP=3D'192.168.56.230'
    2023-06-22T01:18:06.827395  export NFS_SERVER_IP=3D'192.168.56.230'
    2023-06-22T01:18:06.933988  / # #
    2023-06-22T01:18:06.941679  #
    2023-06-22T01:18:07.048515  / # export SHELL=3D/bin/sh
    2023-06-22T01:18:07.056247  export SHELL=3D/bin/sh =

    ... (46 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6493a53329861b1349306169

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6493a53329861b1349306172
        failing since 68 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-06-22T01:34:29.779968  + <8>[   26.993651] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10853184_1.5.2.3.1>

    2023-06-22T01:34:29.780079  set +x

    2023-06-22T01:34:29.897646  / # #

    2023-06-22T01:34:29.998346  export SHELL=3D/bin/sh

    2023-06-22T01:34:29.998574  #

    2023-06-22T01:34:30.099103  / # export SHELL=3D/bin/sh. /lava-10853184/=
environment

    2023-06-22T01:34:30.099316  =


    2023-06-22T01:34:30.199884  / # . /lava-10853184/environment/lava-10853=
184/bin/lava-test-runner /lava-10853184/1

    2023-06-22T01:34:30.200154  =


    2023-06-22T01:34:30.204902  / # /lava-10853184/bin/lava-test-runner /la=
va-10853184/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6493a3f8212ded259130618c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6493a3f8212ded2591306195
        failing since 68 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-06-22T01:29:22.520544  + set +x

    2023-06-22T01:29:22.527543  <8>[   17.049021] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10853240_1.5.2.3.1>

    2023-06-22T01:29:22.638411  / # #

    2023-06-22T01:29:22.740806  export SHELL=3D/bin/sh

    2023-06-22T01:29:22.741501  #

    2023-06-22T01:29:22.842880  / # export SHELL=3D/bin/sh. /lava-10853240/=
environment

    2023-06-22T01:29:22.843592  =


    2023-06-22T01:29:22.944834  / # . /lava-10853240/environment/lava-10853=
240/bin/lava-test-runner /lava-10853240/1

    2023-06-22T01:29:22.945093  =


    2023-06-22T01:29:22.950259  / # /lava-10853240/bin/lava-test-runner /la=
va-10853240/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6493a088861364c2093061e4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6493a088861364c2093061ed
        failing since 158 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-22T01:14:36.758003  / # #

    2023-06-22T01:14:36.860256  export SHELL=3D/bin/sh

    2023-06-22T01:14:36.861004  #

    2023-06-22T01:14:36.962428  / # export SHELL=3D/bin/sh. /lava-10853496/=
environment

    2023-06-22T01:14:36.963167  =


    2023-06-22T01:14:37.064831  / # . /lava-10853496/environment/lava-10853=
496/bin/lava-test-runner /lava-10853496/1

    2023-06-22T01:14:37.065208  =


    2023-06-22T01:14:37.070559  / # /lava-10853496/bin/lava-test-runner /la=
va-10853496/1

    2023-06-22T01:14:37.235778  + export TESTRUN_ID=3D1_bootrr

    2023-06-22T01:14:37.236332  + cd /lava-10853496/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6493a8028a2b021800306146

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/6493a8028a2b02180030618a
        failing since 91 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-06-22T01:46:39.141356  /lava-10853641/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/6493a8028a2b02180030618b
        failing since 91 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-06-22T01:46:36.991594  <8>[   34.844429] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-06-22T01:46:38.054981  /lava-10853641/1/../bin/lava-test-case

    2023-06-22T01:46:38.089070  <8>[   35.943449] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6493a7064274f4bc32306134

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-pine64-pl=
us.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-pine64-pl=
us.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6493a7064274f4bc32306163
        failing since 158 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-22T01:42:06.348835  <8>[   29.897469] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 650095_1.6.2.4.1>
    2023-06-22T01:42:06.465753  / # #
    2023-06-22T01:42:06.568248  export SHELL=3D/bin/sh
    2023-06-22T01:42:06.568824  #
    2023-06-22T01:42:06.670520  / # export SHELL=3D/bin/sh. /lava-650095/en=
vironment
    2023-06-22T01:42:06.671261  =

    2023-06-22T01:42:06.772964  / # . /lava-650095/environment/lava-650095/=
bin/lava-test-runner /lava-650095/1
    2023-06-22T01:42:06.951976  =

    2023-06-22T01:42:06.952236  /lava-650095/bin/lava-test-runner /lava-650=
095/1
    2023-06-22T01:42:07.092668  / # + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20


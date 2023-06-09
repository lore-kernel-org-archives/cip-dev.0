Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8796C7EE45
	for <webhook@archiver.kernel.org>; Fri,  9 Jun 2023 15:57:19 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web11.17100.1686326236438362606
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Jun 2023 08:57:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Cfnp3p2a;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1b065154b79so7569475ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Jun 2023 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686326235; x=1688918235;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O3eWFCVq3ol8oV3oVdlMg1Tt1kq//OMrx2RHUDYufQo=;
        b=Cfnp3p2avoeSsfVQDwBRvJj9s2i5+l2U9UA7M+Z8oT7WR+P4bcAAaDmUZyiuzulb79
         DIhdYvN3GRW+lrkYKyrUhHnodZBo5AYSq/CmjbJl9pAf6g5oI1ToCIGKw9/1c3OdDpa8
         PJ3ae98reK0m3PWVDj3jvWsWrODfaAP8n3QosT1EBfqmTXZLuecNNQpz8n+UYpSdrKvu
         BHRgyOyFOvhV/I9gEAsWIFC9tCIc0rK6esgkfjdtEt25sxAzeKlcsMgJungstTkpMmYs
         OsPvc1Vk4Uicx2J74l+yXV5shVb6FRPLQa4zyjlFd9YCjyR4MlVyj84WTrPLrqyqdAmT
         DEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686326235; x=1688918235;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O3eWFCVq3ol8oV3oVdlMg1Tt1kq//OMrx2RHUDYufQo=;
        b=U+ZRJZc8j1MgTdMMwn/vAViCPRrVft0iPppddhWDRMXeUU6vFqHpOjsyTsQxWNTVPV
         Uj0lX3nszcIKyoCg5qMnCFL7JcnHJC90hryfYtYfvslw2dq3k86a+6JZyWxZXhcqSBg9
         DGqZESg0plJUPdQ9obOQuAfElPP+nTiNnGvkzJdV72x9TWYwFbHhMPG4RCE80kh+vidJ
         J9DRmgdgOZ+To3aqZW9j9mmWjfxIYm69sP452qqeaRaVgoIXGCMhnRE+9l7jXCxrkNCM
         x332ayKfuTvNJdLDdixbowM4DwXQCY7V2WSVRF+d66nZsyLZUpNPwcen6H4C06TCeNgu
         iKDA==
X-Gm-Message-State: AC+VfDxdt9iE+vBUXLsoHQUiA7g31WfgPkJxh0mOe06ut4tBRPxEl9jY
	Sr39fUqybQ544Vo1l5Cr+kytTrwBkgGhN863Q4cagA==
X-Google-Smtp-Source: ACHHUZ7zN+wvMfr5eomnDiofNVps2Yl7DGql8SAsmaLrFSWzOkZn6B3OpUgujP65jHleM7GaJOuwyw==
X-Received: by 2002:a17:903:41c6:b0:1b1:99c9:8cd1 with SMTP id u6-20020a17090341c600b001b199c98cd1mr2452311ple.28.1686326234863;
        Fri, 09 Jun 2023 08:57:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n6-20020a1709026a8600b001a0448731c2sm3449569plk.47.2023.06.09.08.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 08:57:14 -0700 (PDT)
Message-ID: <64834bda.170a0220.4f82b.7357@mx.google.com>
Date: Fri, 09 Jun 2023 08:57:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35
Subject: cip/linux-5.10.y-cip baseline: 95 runs,
 13 regressions (v5.10.182-cip35)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jun 2023 15:57:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11945

cip/linux-5.10.y-cip baseline: 95 runs, 13 regressions (v5.10.182-cip35)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.182-cip35/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.182-cip35
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      52f00829380df13d144d530b732464a175350508 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64833fcc1d533688f8306159

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64833fcc1d533688f830615e
        failing since 146 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-09T15:05:38.697896  <8>[   11.904704] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10660841_1.4.2.3.1>

    2023-06-09T15:05:38.701140  + set +x

    2023-06-09T15:05:38.802313  #

    2023-06-09T15:05:38.802545  =


    2023-06-09T15:05:38.903247  / # #export SHELL=3D/bin/sh

    2023-06-09T15:05:38.903438  =


    2023-06-09T15:05:39.003930  / # export SHELL=3D/bin/sh. /lava-10660841/=
environment

    2023-06-09T15:05:39.004094  =


    2023-06-09T15:05:39.104570  / # . /lava-10660841/environment/lava-10660=
841/bin/lava-test-runner /lava-10660841/1

    2023-06-09T15:05:39.104833  =

 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64833fbd67f602814a306175

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64833fbd67f602814a30617a
        failing since 146 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-09T15:05:21.775935  + set +x

    2023-06-09T15:05:21.781455  <8>[   12.201267] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10660832_1.4.2.3.1>

    2023-06-09T15:05:21.890194  / ##

    2023-06-09T15:05:21.992539  export SHELL=3D/bin/sh

    2023-06-09T15:05:21.993291   #

    2023-06-09T15:05:21.993803  / # export SHELL=3D/bin/sh<4>[   12.399169]=
 i2c_designware i2c_designware.5: timeout in disabling adapter

    2023-06-09T15:05:22.095181  . /lava-10660832/environment

    2023-06-09T15:05:22.095880  =


    2023-06-09T15:05:22.197285  / # . /lava-10660832/environment/lava-10660=
832/bin/lava-test-runner /lava-10660832/1

    2023-06-09T15:05:22.198461  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64833f9b4518ffc4a930612e

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64833f9b4518ffc4a9306131
        failing since 146 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-09T15:04:15.586256  / # #
    2023-06-09T15:04:15.689405  export SHELL=3D/bin/sh
    2023-06-09T15:04:15.690354  #
    2023-06-09T15:04:15.792592  / # export SHELL=3D/bin/sh. /lava-958154/en=
vironment
    2023-06-09T15:04:15.793594  =

    2023-06-09T15:04:15.895927  / # . /lava-958154/environment/lava-958154/=
bin/lava-test-runner /lava-958154/1
    2023-06-09T15:04:15.897489  =

    2023-06-09T15:04:15.908450  / # /lava-958154/bin/lava-test-runner /lava=
-958154/1
    2023-06-09T15:04:16.033328  + export 'TESTRUN_ID=3D1_bootrr'
    2023-06-09T15:04:16.033902  + cd /lava-958154/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64834009d026cd7076306130

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64834009d026cd7076306135
        failing since 56 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-06-09T15:06:41.354434  + set +x

    2023-06-09T15:06:41.360901  <8>[   14.749926] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10660819_1.4.2.3.1>

    2023-06-09T15:06:41.469071  / # #

    2023-06-09T15:06:41.571115  export SHELL=3D/bin/sh

    2023-06-09T15:06:41.571895  #

    2023-06-09T15:06:41.673372  / # export SHELL=3D/bin/sh. /lava-10660819/=
environment

    2023-06-09T15:06:41.674127  =


    2023-06-09T15:06:41.775656  / # . /lava-10660819/environment/lava-10660=
819/bin/lava-test-runner /lava-10660819/1

    2023-06-09T15:06:41.776936  =


    2023-06-09T15:06:41.781798  / # /lava-10660819/bin/lava-test-runner /la=
va-10660819/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64833fce1d533688f8306166

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64833fce1d533688f830616b
        failing since 56 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-06-09T15:05:38.724113  + set +x<8>[   13.141052] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10660863_1.4.2.3.1>

    2023-06-09T15:05:38.724201  =


    2023-06-09T15:05:38.826281  #

    2023-06-09T15:05:38.927006  / # #export SHELL=3D/bin/sh

    2023-06-09T15:05:38.927167  =


    2023-06-09T15:05:39.027687  / # export SHELL=3D/bin/sh. /lava-10660863/=
environment

    2023-06-09T15:05:39.027848  =


    2023-06-09T15:05:39.128384  / # . /lava-10660863/environment/lava-10660=
863/bin/lava-test-runner /lava-10660863/1

    2023-06-09T15:05:39.128736  =


    2023-06-09T15:05:39.133648  / # /lava-10660863/bin/lava-test-runner /la=
va-10660863/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64833f778a1abbe50b30613a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64833f778a1abbe50b30613f
        failing since 146 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-09T15:04:23.446034  / # #

    2023-06-09T15:04:23.548498  export SHELL=3D/bin/sh

    2023-06-09T15:04:23.549269  #

    2023-06-09T15:04:23.650986  / # export SHELL=3D/bin/sh. /lava-10660792/=
environment

    2023-06-09T15:04:23.651754  =


    2023-06-09T15:04:23.753539  / # . /lava-10660792/environment/lava-10660=
792/bin/lava-test-runner /lava-10660792/1

    2023-06-09T15:04:23.754666  =


    2023-06-09T15:04:23.768771  / # /lava-10660792/bin/lava-test-runner /la=
va-10660792/1

    2023-06-09T15:04:23.859774  + export 'TESTRUN_ID=3D1_bootrr'

    2023-06-09T15:04:23.860305  + cd /lava-10660792/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64833d7779c7df83ec306132

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandb=
oard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64833d7779c7df83ec306137
        failing since 146 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-09T14:55:41.601201  + set +x
    2023-06-09T14:55:41.601360  [   10.207507] <LAVA_SIGNAL_ENDRUN 0_dmesg =
972584_1.5.2.3.1>
    2023-06-09T14:55:41.709361  / # #
    2023-06-09T14:55:41.811014  export SHELL=3D/bin/sh
    2023-06-09T14:55:41.811481  #
    2023-06-09T14:55:41.912646  / # export SHELL=3D/bin/sh. /lava-972584/en=
vironment
    2023-06-09T14:55:41.912984  =

    2023-06-09T14:55:42.014313  / # . /lava-972584/environment/lava-972584/=
bin/lava-test-runner /lava-972584/1
    2023-06-09T14:55:42.014867  =

    2023-06-09T14:55:42.017615  / # /lava-972584/bin/lava-test-runner /lava=
-972584/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64833f448dbe846b1c30612e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64833f448dbe846b1c306133
        failing since 146 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-09T15:03:22.212510  + set[    7.147206] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 972599_1.5.2.3.1>
    2023-06-09T15:03:22.212700   +x
    2023-06-09T15:03:22.318385  / # #
    2023-06-09T15:03:22.420097  export SHELL=3D/bin/sh
    2023-06-09T15:03:22.420567  #
    2023-06-09T15:03:22.521806  / # export SHELL=3D/bin/sh. /lava-972599/en=
vironment
    2023-06-09T15:03:22.522253  =

    2023-06-09T15:03:22.623573  / # . /lava-972599/environment/lava-972599/=
bin/lava-test-runner /lava-972599/1
    2023-06-09T15:03:22.624164  =

    2023-06-09T15:03:22.626699  / # /lava-972599/bin/lava-test-runner /lava=
-972599/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64833d508f764f447730614d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64833d508f764f4477306=
14e
        failing since 4 days (last pass: v5.10.180-cip34, first fail: v5.10=
.180-cip34-19-gf0f6960f132cd) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/64833f598dbe846b1c306166

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/64833f598dbe846b1c306195
        failing since 144 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-09T15:04:18.979355  FIRST,<8>[   21.384433] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-06-09T15:04:18.981077   INC default to 1.

    2023-06-09T15:04:18.981293  =


    2023-06-09T15:04:18.984873  	-w	Pad to last with leading zeros

    2023-06-09T15:04:18.987504  	-s SEP	String separator

    2023-06-09T15:04:18.991221  /lava-10660787/1/../bin/lava-test-case

    2023-06-09T15:04:18.997162  BusyBox v1.31.1 (2023-05-27 14:14:16 UTC) m=
ulti-call binary.

    2023-06-09T15:04:18.997382  =


    2023-06-09T15:04:19.007732  Usag<8>[   21.413640] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Ddwhdmi-rockchip-driver-i2c-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64833f598dbe846b1c306196
        failing since 144 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-09T15:04:18.958796   multi-call binary.

    2023-06-09T15:04:18.959087  =


    2023-06-09T15:04:18.963314  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-06-09T15:04:18.963693  =


    2023-06-09T15:04:18.968940  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64833f598dbe846b1c306197
        failing since 144 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-09T15:04:18.937970  <8>[   21.347581] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>

    2023-06-09T15:04:18.956775  BusyBox v1.31.1 (2023-05-27 14:14:16 UTC)<8=
>[   21.365473] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64833f598dbe846b1c3061ab
        failing since 144 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-09T15:04:06.896734  + <8>[    9.309181] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10660787_1.5.2.3.1>

    2023-06-09T15:04:06.897188  set +x

    2023-06-09T15:04:07.002317  =


    2023-06-09T15:04:07.102861  / # #export SHELL=3D/bin/sh

    2023-06-09T15:04:07.102980  =


    2023-06-09T15:04:07.203485  / # export SHELL=3D/bin/sh. /lava-10660787/=
environment

    2023-06-09T15:04:07.203588  =


    2023-06-09T15:04:07.304110  / # . /lava-10660787/environment/lava-10660=
787/bin/lava-test-runner /lava-10660787/1

    2023-06-09T15:04:07.304304  =


    2023-06-09T15:04:07.305602  / # /lava-10660787/bin/lava-test-runner /la=
va-10660787/1
 =

    ... (18 line(s) more)  =

 =20


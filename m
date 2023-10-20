Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C58C0032E
	for <webhook@archiver.kernel.org>; Fri, 20 Oct 2023 14:52:39 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.56494.1697813558832151089
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 20 Oct 2023 07:52:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=EEO9SCPg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1c9d922c039so7264545ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 20 Oct 2023 07:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697813558; x=1698418358; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6wxpFD4ujRI4urLlHQIq1wi/YjI5ufPKu0EKzRdOoAE=;
        b=EEO9SCPgW2YTtVdI8HXBbkeGvhzZllFvvvKaUeVd0ehN6uVN75zOPCzVsyAZ2OGZOQ
         ErxqxevSPWpnvHHRK9vELhAegKfe5GeAjdD1AnEIkIFQtcFF9Gm0Qs6705fl0IjKjKYJ
         A/lbyG3uksKNhhBBFreaU+69ygnxPntBPMMWKGmtjb5b/E8H6w09WJbxXJ7qqnkGuHjo
         BcRERIDqAukg149rPzD1Gtv8FGa88B4Gb085h1geTXPfyzmyGY/mhuz9fJ8OTSRFjQ4m
         /rWeLcOq5OXPyubFZopYZFyKcbGJjSKMZoaGvCCHfxBqFNkuzdNUupmAxf1Ydb6XKA5O
         NxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697813558; x=1698418358;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6wxpFD4ujRI4urLlHQIq1wi/YjI5ufPKu0EKzRdOoAE=;
        b=FW4T9OpwZxhi/crQA2vEpn+TMk/txeDb2juq5nXXvaidBeZqp42bUbUuuhrFsn5o7v
         O1tWpzLk8K1CB0I5voks/XNul0EUUzzZ27h7OVMXsJJo+Y5ZHE+RyYcIsZfc/eZvPfoF
         J9SiDv+n23Cg4U2e6uBWcrv35AYs4MVIkfdVUJTfQa1Dirh5tYeyAO8wHJ0RP9m9yFw8
         QwixWIImArYDXuB71C1ad+NZP0BGWEiKjfRL09ZT0jLi2XHdQSXhzFPah/jL87RJmNdH
         3GgMhBS9cTnOkkmcMK0aDSQG53yEUAs6SU2JRPg6sbRVVI3RLsbdoxwyQjH6PleMTMkV
         MrjQ==
X-Gm-Message-State: AOJu0YzepMJvYrBUd5cc3AU7KHQUG8/2HCIxjQxZpbQkFEvCLeeH5CyF
	L7LFUNJKGYF7uEpbMcNSgG8YJ/qr3KvMBMXNXAvxNw==
X-Google-Smtp-Source: AGHT+IHYa0S3kUUuLNujrC8cxGD67KiTOeElR5EjksY3sMdvJ7+iIQRn74CqyU2tnt/rrSWqpSnwBQ==
X-Received: by 2002:a17:902:d4cf:b0:1c3:92de:1b23 with SMTP id o15-20020a170902d4cf00b001c392de1b23mr2029213plg.59.1697813556437;
        Fri, 20 Oct 2023 07:52:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902a38d00b001b89b1b99fasm1649523pla.243.2023.10.20.07.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 07:52:34 -0700 (PDT)
Message-ID: <65329432.170a0220.864c.5b16@mx.google.com>
Date: Fri, 20 Oct 2023 07:52:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.295-cip103-rt33
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip-rt baseline: 204 runs,
 49 regressions (v4.19.295-cip103-rt33)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Oct 2023 14:52:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13415

cip/linux-4.19.y-cip-rt baseline: 204 runs, 49 regressions (v4.19.295-cip10=
3-rt33)

Regressions Summary
-------------------

platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora   | gcc-10   | defconfig=
+x86-chromebook     | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora   | gcc-10   | defconfig=
+x86-chromebook     | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | defconfig=
                    | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | defconfig=
+preempt_rt         | 1          =

beaglebone-black          | arm    | lab-cip         | gcc-10   | defconfig=
                    | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig           | 1          =

beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =

beaglebone-black          | arm    | lab-cip         | gcc-10   | multi_v7_=
defconfig           | 1          =

beaglebone-black          | arm    | lab-cip         | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =

dove-cubox                | arm    | lab-pengutronix | gcc-10   | mvebu_v7_=
defconfig           | 1          =

imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | defconfig=
                    | 1          =

imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | defconfig=
+preempt_rt         | 1          =

imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =

imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | defconfig=
                    | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | defconfig=
+preempt_rt         | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig          | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig           | 1          =

imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =

imx6ul-14x14-evk          | arm    | lab-nxp         | gcc-10   | defconfig=
                    | 1          =

imx6ul-14x14-evk          | arm    | lab-nxp         | gcc-10   | defconfig=
+preempt_rt         | 1          =

imx6ul-14x14-evk          | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =

imx6ul-14x14-evk          | arm    | lab-nxp         | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =

imx7d-sdb                 | arm    | lab-nxp         | gcc-10   | defconfig=
                    | 1          =

imx7d-sdb                 | arm    | lab-nxp         | gcc-10   | defconfig=
+preempt_rt         | 1          =

imx7d-sdb                 | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =

imx7d-sdb                 | arm    | lab-nxp         | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip         | gcc-10   | defconfig=
+preempt_rt         | 1          =

r8a774c0-ek874            | arm64  | lab-cip         | gcc-10   | defconfig=
+preempt_rt         | 1          =

r8a7796-m3ulcb            | arm64  | lab-collabora   | gcc-10   | defconfig=
+preempt_rt         | 1          =

r8a7796-m3ulcb            | arm64  | lab-collabora   | gcc-10   | defconfig=
                    | 1          =

rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | defconfig=
                    | 3          =

rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | defconfig=
+preempt_rt         | 3          =

rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 3          =

rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defc...g+preempt_rt | 3          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie     | gcc-10   | defconfig=
+preempt_rt         | 1          =

sun50i-a64-pine64-plus    | arm64  | lab-broonie     | gcc-10   | defconfig=
                    | 1          =

sun50i-h6-pine-h64        | arm64  | lab-collabora   | gcc-10   | defconfig=
+preempt_rt         | 1          =

sun50i-h6-pine-h64        | arm64  | lab-collabora   | gcc-10   | defconfig=
                    | 1          =

zynqmp-zcu102             | arm64  | lab-cip         | gcc-10   | defconfig=
+preempt_rt         | 1          =

zynqmp-zcu102             | arm64  | lab-cip         | gcc-10   | defconfig=
                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.295-cip103-rt33/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.295-cip103-rt33
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      28d064262557c550e33da563b323e56c214e60fd =



Test Regressions
---------------- =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora   | gcc-10   | defconfig=
+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/65328df4cb60bdcbb9efcf25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baseli=
ne-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baseli=
ne-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65328df4cb60bdcbb9efc=
f26
        new failure (last pass: v4.19.288-cip101-rt32) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora   | gcc-10   | defconfig=
+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/65328d0483ea2c29cbefcf19

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baseli=
ne-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baseli=
ne-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328d0483ea2c29cbefcf22
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:21:34.676386  + set +x

    2023-10-20T14:21:34.683080  <8>[   11.979509] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11829257_1.4.2.3.1>

    2023-10-20T14:21:34.787298  / # #

    2023-10-20T14:21:34.887999  export SHELL=3D/bin/sh

    2023-10-20T14:21:34.888224  #

    2023-10-20T14:21:34.988795  / # export SHELL=3D/bin/sh. /lava-11829257/=
environment

    2023-10-20T14:21:34.988978  =


    2023-10-20T14:21:35.089534  / # . /lava-11829257/environment/lava-11829=
257/bin/lava-test-runner /lava-11829257/1

    2023-10-20T14:21:35.089789  =


    2023-10-20T14:21:35.094677  / # /lava-11829257/bin/lava-test-runner /la=
va-11829257/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65328e1f384f3a19ffefcef9

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328e1f384f3a19ffefcf26
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:25:58.063021  <8>[   15.426982] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 181383_1.5.2.4.1>
    2023-10-20T14:25:58.173130  / # #
    2023-10-20T14:25:58.275784  export SHELL=3D/bin/sh
    2023-10-20T14:25:58.276492  #
    2023-10-20T14:25:58.378979  / # export SHELL=3D/bin/sh. /lava-181383/en=
vironment
    2023-10-20T14:25:58.379780  =

    2023-10-20T14:25:58.482232  / # . /lava-181383/environment/lava-181383/=
bin/lava-test-runner /lava-181383/1
    2023-10-20T14:25:58.483515  =

    2023-10-20T14:25:58.487415  / # /lava-181383/bin/lava-test-runner /lava=
-181383/1
    2023-10-20T14:25:58.554218  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | defconfig=
+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/65328e5b762686b8b3efcfa9

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-beagle=
bone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-beagle=
bone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328e5b762686b8b3efcfd8
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:26:56.327694  <8>[   18.317646] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 181446_1.5.2.4.1>
    2023-10-20T14:26:56.437860  / # #
    2023-10-20T14:26:56.540712  export SHELL=3D/bin/sh
    2023-10-20T14:26:56.541483  #
    2023-10-20T14:26:56.643453  / # export SHELL=3D/bin/sh. /lava-181446/en=
vironment
    2023-10-20T14:26:56.644055  =

    2023-10-20T14:26:56.746158  / # . /lava-181446/environment/lava-181446/=
bin/lava-test-runner /lava-181446/1
    2023-10-20T14:26:56.747459  =

    2023-10-20T14:26:56.751657  / # /lava-181446/bin/lava-test-runner /lava=
-181446/1
    2023-10-20T14:26:56.833761  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-cip         | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/653290f071c199d5c8efcefe

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/653290f171c199d5c8efcf2d
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:36:17.580518  <8>[    8.890229] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1023135_1.5.2.4.1>
    2023-10-20T14:36:17.688198  / # #
    2023-10-20T14:36:17.789970  export SHELL=3D/bin/sh
    2023-10-20T14:36:17.790618  #
    2023-10-20T14:36:17.891858  / # export SHELL=3D/bin/sh. /lava-1023135/e=
nvironment
    2023-10-20T14:36:17.892486  =

    2023-10-20T14:36:17.993620  / # . /lava-1023135/environment/lava-102313=
5/bin/lava-test-runner /lava-1023135/1
    2023-10-20T14:36:17.994701  =

    2023-10-20T14:36:18.000898  / # /lava-1023135/bin/lava-test-runner /lav=
a-1023135/1
    2023-10-20T14:36:18.066353  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65328a0e0bd52685abefcf00

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebo=
ne-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebo=
ne-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328a0e0bd52685abefcf2f
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:08:39.871916  <8>[   16.965454] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 181301_1.5.2.4.1>
    2023-10-20T14:08:39.980576  / # #
    2023-10-20T14:08:40.083125  export SHELL=3D/bin/sh
    2023-10-20T14:08:40.083907  #
    2023-10-20T14:08:40.185601  / # export SHELL=3D/bin/sh. /lava-181301/en=
vironment
    2023-10-20T14:08:40.186090  =

    2023-10-20T14:08:40.287586  / # . /lava-181301/environment/lava-181301/=
bin/lava-test-runner /lava-181301/1
    2023-10-20T14:08:40.288361  =

    2023-10-20T14:08:40.292512  / # /lava-181301/bin/lava-test-runner /lava=
-181301/1
    2023-10-20T14:08:40.359787  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-broonie     | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65328c8b55fb0c6c35efd0a6

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-broonie/baseli=
ne-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-broonie/baseli=
ne-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328c8b55fb0c6c35efd0d5
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:19:10.742908  <8>[   16.180523] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 181348_1.5.2.4.1>
    2023-10-20T14:19:10.852145  / # #
    2023-10-20T14:19:10.954348  export SHELL=3D/bin/sh
    2023-10-20T14:19:10.954992  #<6>[   16.271882] usb 1-1: new low-speed U=
SB device number 3 using musb-hdrc
    2023-10-20T14:19:10.955330  =

    2023-10-20T14:19:11.056694  / # export SHELL=3D/bin/sh. /lava-181348/en=
vironment
    2023-10-20T14:19:11.057329  =

    2023-10-20T14:19:11.057646  / # <3>[   16.421907] usb 1-1: device descr=
iptor read/64, error -71
    2023-10-20T14:19:11.159109  . /lava-181348/environment/lava-181348/bin/=
lava-test-runner /lava-181348/1
    2023-10-20T14:19:11.160186   =

    ... (17 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-cip         | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65328b9d7e8c8bdfecefcef3

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-b=
lack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beaglebone-b=
lack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328b9d7e8c8bdfecefcf1d
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:15:22.871076  <8>[    9.840698] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1023100_1.5.2.4.1>
    2023-10-20T14:15:22.974372  / # #
    2023-10-20T14:15:23.075447  export SHELL=3D/bin/sh
    2023-10-20T14:15:23.075960  #
    2023-10-20T14:15:23.176597  / # export SHELL=3D/bin/sh. /lava-1023100/e=
nvironment
    2023-10-20T14:15:23.177081  =

    2023-10-20T14:15:23.277835  / # . /lava-1023100/environment/lava-102310=
0/bin/lava-test-runner /lava-1023100/1
    2023-10-20T14:15:23.278438  =

    2023-10-20T14:15:23.286667  / # /lava-1023100/bin/lava-test-runner /lav=
a-1023100/1
    2023-10-20T14:15:23.350829  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
beaglebone-black          | arm    | lab-cip         | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65328fc808cb352034efd03e

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-cip/baseline-b=
eaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-cip/baseline-b=
eaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328fc808cb352034efd06d
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:33:08.578033  <8>[   11.085634] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1023118_1.5.2.4.1>
    2023-10-20T14:33:08.687134  / # #
    2023-10-20T14:33:08.788502  export SHELL=3D/bin/sh
    2023-10-20T14:33:08.788961  #
    2023-10-20T14:33:08.889877  / # export SHELL=3D/bin/sh. /lava-1023118/e=
nvironment
    2023-10-20T14:33:08.890363  =

    2023-10-20T14:33:08.991392  / # . /lava-1023118/environment/lava-102311=
8/bin/lava-test-runner /lava-1023118/1
    2023-10-20T14:33:08.992089  =

    2023-10-20T14:33:08.995998  / # /lava-1023118/bin/lava-test-runner /lav=
a-1023118/1
    2023-10-20T14:33:09.078283  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
dove-cubox                | arm    | lab-pengutronix | gcc-10   | mvebu_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65328ceed671958e21efcf50

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: mvebu_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/mvebu_v7_defconfig/gcc-10/lab-pengutronix/baseline-dove=
-cubox.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/mvebu_v7_defconfig/gcc-10/lab-pengutronix/baseline-dove=
-cubox.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328ceed671958e21efcf59
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:21:18.216690  + set +x
    2023-10-20T14:21:18.216901  [    4.299865] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1003828_1.5.2.3.1>
    2023-10-20T14:21:18.322859  / # #
    2023-10-20T14:21:18.424433  export SHELL=3D/bin/sh
    2023-10-20T14:21:18.424881  #
    2023-10-20T14:21:18.526092  / # export SHELL=3D/bin/sh. /lava-1003828/e=
nvironment
    2023-10-20T14:21:18.526530  =

    2023-10-20T14:21:18.627816  / # . /lava-1003828/environment/lava-100382=
8/bin/lava-test-runner /lava-1003828/1
    2023-10-20T14:21:18.628519  =

    2023-10-20T14:21:18.631164  / # /lava-1003828/bin/lava-test-runner /lav=
a-1003828/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65328d72b2d34a27afefcf0c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig/gcc-10/lab-collabora/baseline-imx6q-sabrelite=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328d73b2d34a27afefcf15
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:24:00.666574  / # #

    2023-10-20T14:24:00.768590  export SHELL=3D/bin/sh

    2023-10-20T14:24:00.769249  #

    2023-10-20T14:24:00.870515  / # export SHELL=3D/bin/sh. /lava-11829289/=
environment

    2023-10-20T14:24:00.871228  =


    2023-10-20T14:24:00.972710  / # . /lava-11829289/environment/lava-11829=
289/bin/lava-test-runner /lava-11829289/1

    2023-10-20T14:24:00.973804  =


    2023-10-20T14:24:00.980542  / # /lava-11829289/bin/lava-test-runner /la=
va-11829289/1

    2023-10-20T14:24:01.089418  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-20T14:24:01.089917  + cd /lava-11829289/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | defconfig=
+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/65328d87b2d34a27afefcf94

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-imx6=
q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-imx6=
q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328d87b2d34a27afefcf9d
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:26:35.306253  / # #

    2023-10-20T14:26:35.408411  export SHELL=3D/bin/sh

    2023-10-20T14:26:35.409094  #

    2023-10-20T14:26:35.510611  / # export SHELL=3D/bin/sh. /lava-11829326/=
environment

    2023-10-20T14:26:35.511312  =


    2023-10-20T14:26:35.612834  / # . /lava-11829326/environment/lava-11829=
326/bin/lava-test-runner /lava-11829326/1

    2023-10-20T14:26:35.613995  =


    2023-10-20T14:26:35.630014  / # /lava-11829326/bin/lava-test-runner /la=
va-11829326/1

    2023-10-20T14:26:35.731024  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-20T14:26:35.731523  + cd /lava-11829326/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/653289da6bb37ad9a6efcfaa

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-=
sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-imx6q-=
sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/653289da6bb37ad9a6efcfb3
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:10:52.322408  / # #

    2023-10-20T14:10:52.423106  export SHELL=3D/bin/sh

    2023-10-20T14:10:52.423322  #

    2023-10-20T14:10:52.523976  / # export SHELL=3D/bin/sh. /lava-11829144/=
environment

    2023-10-20T14:10:52.524204  =


    2023-10-20T14:10:52.624770  / # . /lava-11829144/environment/lava-11829=
144/bin/lava-test-runner /lava-11829144/1

    2023-10-20T14:10:52.625022  =


    2023-10-20T14:10:52.631132  / # /lava-11829144/bin/lava-test-runner /la=
va-11829144/1

    2023-10-20T14:10:52.695255  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-20T14:10:52.746183  + cd /lava-11829144/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6q-sabrelite           | arm    | lab-collabora   | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65328c383feb071417efcef3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/base=
line-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/base=
line-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328c383feb071417efcefc
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:18:26.345395  / # #

    2023-10-20T14:18:26.447209  export SHELL=3D/bin/sh

    2023-10-20T14:18:26.447909  #

    2023-10-20T14:18:26.549812  / # export SHELL=3D/bin/sh. /lava-11829192/=
environment

    2023-10-20T14:18:26.550504  =


    2023-10-20T14:18:26.652311  / # . /lava-11829192/environment/lava-11829=
192/bin/lava-test-runner /lava-11829192/1

    2023-10-20T14:18:26.653424  =


    2023-10-20T14:18:26.668406  / # /lava-11829192/bin/lava-test-runner /la=
va-11829192/1

    2023-10-20T14:18:26.779543  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-20T14:18:26.780079  + cd /lava-11829192/1/tests/1_bootrr
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65328d3eb6d2e8c80defcf14

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig/gcc-10/lab-pengutronix/baseline-imx6qp-wandbo=
ard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328d3eb6d2e8c80defcf1d
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:22:42.479126  + set +x
    2023-10-20T14:22:42.479308  [    4.867551] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1003835_1.5.2.3.1>
    2023-10-20T14:22:42.584979  / # #
    2023-10-20T14:22:42.686692  export SHELL=3D/bin/sh
    2023-10-20T14:22:42.687151  #
    2023-10-20T14:22:42.788332  / # export SHELL=3D/bin/sh. /lava-1003835/e=
nvironment
    2023-10-20T14:22:42.788745  =

    2023-10-20T14:22:42.889712  / # . /lava-1003835/environment/lava-100383=
5/bin/lava-test-runner /lava-1003835/1
    2023-10-20T14:22:42.890312  =

    2023-10-20T14:22:42.892424  / # /lava-1003835/bin/lava-test-runner /lav=
a-1003835/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | defconfig=
+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/65328d7ab2d34a27afefcf5c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig+preempt_rt/gcc-10/lab-pengutronix/baseline-im=
x6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig+preempt_rt/gcc-10/lab-pengutronix/baseline-im=
x6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328d7ab2d34a27afefcf65
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:23:43.908206  + set[    6.809107] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1003839_1.5.2.3.1>
    2023-10-20T14:23:43.908372   +x
    2023-10-20T14:23:44.015137  / # #
    2023-10-20T14:23:44.116907  export SHELL=3D/bin/sh
    2023-10-20T14:23:44.117490  #
    2023-10-20T14:23:44.219010  / # export SHELL=3D/bin/sh. /lava-1003839/e=
nvironment
    2023-10-20T14:23:44.219622  =

    2023-10-20T14:23:44.321129  / # . /lava-1003839/environment/lava-100383=
9/bin/lava-test-runner /lava-1003839/1
    2023-10-20T14:23:44.321765  =

    2023-10-20T14:23:44.324327  / # /lava-1003839/bin/lava-test-runner /lav=
a-1003839/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | imx_v6_v7=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65328cf0d671958e21efcf66

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx=
6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx=
6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328cf0d671958e21efcf6f
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:21:22.365782  + set +x[    7.371096] <LAVA_SIGNAL_ENDRUN =
0_dmesg 1003831_1.5.2.3.1>
    2023-10-20T14:21:22.366094  =

    2023-10-20T14:21:22.473344  / # #
    2023-10-20T14:21:22.575084  export SHELL=3D/bin/sh
    2023-10-20T14:21:22.575646  #
    2023-10-20T14:21:22.677167  / # export SHELL=3D/bin/sh. /lava-1003831/e=
nvironment
    2023-10-20T14:21:22.677713  =

    2023-10-20T14:21:22.779102  / # . /lava-1003831/environment/lava-100383=
1/bin/lava-test-runner /lava-1003831/1
    2023-10-20T14:21:22.779726  =

    2023-10-20T14:21:22.782975  / # /lava-1003831/bin/lava-test-runner /lav=
a-1003831/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/653289a89009ad5022efcef5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/653289a89009ad5022efcefe
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:07:24.467329  + set +x
    2023-10-20T14:07:24.467512  [    4.867211] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1003817_1.5.2.3.1>
    2023-10-20T14:07:24.573658  / # #
    2023-10-20T14:07:24.675392  export SHELL=3D/bin/sh
    2023-10-20T14:07:24.675873  #
    2023-10-20T14:07:24.777084  / # export SHELL=3D/bin/sh. /lava-1003817/e=
nvironment
    2023-10-20T14:07:24.777475  =

    2023-10-20T14:07:24.878655  / # . /lava-1003817/environment/lava-100381=
7/bin/lava-test-runner /lava-1003817/1
    2023-10-20T14:07:24.879242  =

    2023-10-20T14:07:24.881509  / # /lava-1003817/bin/lava-test-runner /lav=
a-1003817/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6qp-wandboard-revd1    | arm    | lab-pengutronix | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65328c13151437af13efcf09

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-pengutronix/ba=
seline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-pengutronix/ba=
seline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328c13151437af13efcf12
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:17:47.770666  + set[    6.900592] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1003822_1.5.2.3.1>
    2023-10-20T14:17:47.770833   +x
    2023-10-20T14:17:47.876990  / # #
    2023-10-20T14:17:47.978628  export SHELL=3D/bin/sh
    2023-10-20T14:17:47.979120  #
    2023-10-20T14:17:48.080381  / # export SHELL=3D/bin/sh. /lava-1003822/e=
nvironment
    2023-10-20T14:17:48.080835  =

    2023-10-20T14:17:48.182076  / # . /lava-1003822/environment/lava-100382=
2/bin/lava-test-runner /lava-1003822/1
    2023-10-20T14:17:48.182716  =

    2023-10-20T14:17:48.185378  / # /lava-1003822/bin/lava-test-runner /lav=
a-1003822/1 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6ul-14x14-evk          | arm    | lab-nxp         | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65328dc439e3ae2d4eefcf40

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328dc439e3ae2d4eefcf47
        failing since 212 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.277-cip94-rt29)

    2023-10-20T14:24:39.202988  + set +x<8>[   22.457783] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1254818_1.5.2.4.1>
    2023-10-20T14:24:39.203247  =

    2023-10-20T14:24:39.312889  / # #
    2023-10-20T14:24:40.469258  export SHELL=3D/bin/sh
    2023-10-20T14:24:40.474891  #
    2023-10-20T14:24:42.017126  / # export SHELL=3D/bin/sh. /lava-1254818/e=
nvironment
    2023-10-20T14:24:42.022827  =

    2023-10-20T14:24:44.835109  / # . /lava-1254818/environment/lava-125481=
8/bin/lava-test-runner /lava-1254818/1
    2023-10-20T14:24:44.841193  =

    2023-10-20T14:24:44.842806  / # /lava-1254818/bin/lava-test-runner /lav=
a-1254818/1 =

    ... (15 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6ul-14x14-evk          | arm    | lab-nxp         | gcc-10   | defconfig=
+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/65328e3cc0950b1518efceff

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-imx6ul-14x=
14-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-imx6ul-14x=
14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328e3cc0950b1518efcf06
        failing since 212 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.277-cip94-rt29)

    2023-10-20T14:26:53.541610  + set +x
    2023-10-20T14:26:53.544746  <8>[   24.858486] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1254819_1.5.2.4.1>
    2023-10-20T14:26:53.656839  / # #
    2023-10-20T14:26:54.812892  export SHELL=3D/bin/sh
    2023-10-20T14:26:54.818597  #
    2023-10-20T14:26:56.361303  / # export SHELL=3D/bin/sh. /lava-1254819/e=
nvironment
    2023-10-20T14:26:56.366987  =

    2023-10-20T14:26:59.180208  / # . /lava-1254819/environment/lava-125481=
9/bin/lava-test-runner /lava-1254819/1
    2023-10-20T14:26:59.186227  =

    2023-10-20T14:26:59.188453  / # /lava-1254819/bin/lava-test-runner /lav=
a-1254819/1 =

    ... (15 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6ul-14x14-evk          | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/653289f3af891c101fefcf0f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14=
-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6ul-14x14=
-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/653289f3af891c101fefcf16
        failing since 212 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.277-cip94-rt29)

    2023-10-20T14:08:16.431937  + set +x<8>[   22.400850] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1254811_1.5.2.4.1>
    2023-10-20T14:08:16.432261  =

    2023-10-20T14:08:16.544404  / # #
    2023-10-20T14:08:17.700949  export SHELL=3D/bin/sh
    2023-10-20T14:08:17.706576  #
    2023-10-20T14:08:19.248955  / # export SHELL=3D/bin/sh. /lava-1254811/e=
nvironment
    2023-10-20T14:08:19.254689  =

    2023-10-20T14:08:22.067501  / # . /lava-1254811/environment/lava-125481=
1/bin/lava-test-runner /lava-1254811/1
    2023-10-20T14:08:22.073637  =

    2023-10-20T14:08:22.075065  / # /lava-1254811/bin/lava-test-runner /lav=
a-1254811/1 =

    ... (15 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx6ul-14x14-evk          | arm    | lab-nxp         | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65328c5b6200729f6cefcf13

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-nxp/baseline-i=
mx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-nxp/baseline-i=
mx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328c5b6200729f6cefcf1a
        failing since 212 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.277-cip94-rt29)

    2023-10-20T14:18:42.560988  + set +x
    2023-10-20T14:18:42.564097  <8>[   24.969802] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1254812_1.5.2.4.1>
    2023-10-20T14:18:42.673797  / # #
    2023-10-20T14:18:43.828724  export SHELL=3D/bin/sh
    2023-10-20T14:18:43.834345  #
    2023-10-20T14:18:45.375760  / # export SHELL=3D/bin/sh. /lava-1254812/e=
nvironment
    2023-10-20T14:18:45.381166  =

    2023-10-20T14:18:48.192647  / # . /lava-1254812/environment/lava-125481=
2/bin/lava-test-runner /lava-1254812/1
    2023-10-20T14:18:48.198635  =

    2023-10-20T14:18:48.200834  / # /lava-1254812/bin/lava-test-runner /lav=
a-1254812/1 =

    ... (15 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx7d-sdb                 | arm    | lab-nxp         | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65328d75b2d34a27afefcf22

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328d76b2d34a27afefcf29
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:23:27.777524  / # #
    2023-10-20T14:23:28.933738  export SHELL=3D/bin/sh
    2023-10-20T14:23:28.939212  #
    2023-10-20T14:23:30.480176  / # export SHELL=3D/bin/sh. /lava-1254817/e=
nvironment
    2023-10-20T14:23:30.485627  =

    2023-10-20T14:23:33.296707  / # . /lava-1254817/environment/lava-125481=
7/bin/lava-test-runner /lava-1254817/1
    2023-10-20T14:23:33.302721  =

    2023-10-20T14:23:33.302983  / # /lava-1254817/bin/lava-test-runner /lav=
a-1254817/1
    2023-10-20T14:23:33.408835  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-20T14:23:33.409173  + cd /lava-1254817/1/tests/1_bootrr =

    ... (16 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx7d-sdb                 | arm    | lab-nxp         | gcc-10   | defconfig=
+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/65328db039e3ae2d4eefcf13

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-imx7d-sdb.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig+preempt_rt/gcc-10/lab-nxp/baseline-imx7d-sdb.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328db039e3ae2d4eefcf1a
        failing since 274 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:24:32.777400  / # #
    2023-10-20T14:24:33.933731  export SHELL=3D/bin/sh
    2023-10-20T14:24:33.939417  #
    2023-10-20T14:24:35.481826  / # export SHELL=3D/bin/sh. /lava-1254820/e=
nvironment
    2023-10-20T14:24:35.487527  =

    2023-10-20T14:24:38.299981  / # . /lava-1254820/environment/lava-125482=
0/bin/lava-test-runner /lava-1254820/1
    2023-10-20T14:24:38.305966  =

    2023-10-20T14:24:38.315587  / # /lava-1254820/bin/lava-test-runner /lav=
a-1254820/1
    2023-10-20T14:24:38.419379  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-20T14:24:38.419684  + cd /lava-1254820/1/tests/1_bootrr =

    ... (16 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx7d-sdb                 | arm    | lab-nxp         | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/653289f0af891c101fefcf04

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7d-sdb.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/653289f0af891c101fefcf0b
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:08:18.094136  / # #
    2023-10-20T14:08:19.250342  export SHELL=3D/bin/sh
    2023-10-20T14:08:19.255996  #
    2023-10-20T14:08:20.798035  / # export SHELL=3D/bin/sh. /lava-1254810/e=
nvironment
    2023-10-20T14:08:20.803618  =

    2023-10-20T14:08:20.803853  / # . /lava-1254810/environment
    2023-10-20T14:08:23.615411  / # /lava-1254810/bin/lava-test-runner /lav=
a-1254810/1
    2023-10-20T14:08:23.634962  /lava-1254810/bin/lava-test-runner /lava-12=
54810/1
    2023-10-20T14:08:23.728713  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-20T14:08:23.728998  + cd /lava-1254810/1/tests/1_bootrr =

    ... (16 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
imx7d-sdb                 | arm    | lab-nxp         | gcc-10   | multi_v7_=
defc...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65328c483feb071417efcefe

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-nxp/baseline-i=
mx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-nxp/baseline-i=
mx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328c483feb071417efcf05
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:18:30.429782  / # #
    2023-10-20T14:18:31.586156  export SHELL=3D/bin/sh
    2023-10-20T14:18:31.591805  #
    2023-10-20T14:18:33.134061  / # export SHELL=3D/bin/sh. /lava-1254813/e=
nvironment
    2023-10-20T14:18:33.139707  =

    2023-10-20T14:18:35.952281  / # . /lava-1254813/environment/lava-125481=
3/bin/lava-test-runner /lava-1254813/1
    2023-10-20T14:18:35.958295  =

    2023-10-20T14:18:35.969877  / # /lava-1254813/bin/lava-test-runner /lav=
a-1254813/1
    2023-10-20T14:18:36.065733  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-20T14:18:36.066107  + cd /lava-1254813/1/tests/1_bootrr =

    ... (16 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip         | gcc-10   | defconfig=
+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/65328e4bc0950b1518efcf47

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-r8a774a1=
-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-r8a774a1=
-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65328e4bc0950b1518efc=
f48
        new failure (last pass: v4.19.288-cip101-rt32) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
r8a774c0-ek874            | arm64  | lab-cip         | gcc-10   | defconfig=
+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/65328eaf5fd4c4f155efcef9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-r8a774c0=
-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-r8a774c0=
-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65328eaf5fd4c4f155efc=
efa
        new failure (last pass: v4.19.288-cip101-rt32) =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
r8a7796-m3ulcb            | arm64  | lab-collabora   | gcc-10   | defconfig=
+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/65328d1ec382cbb79cefcf01

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-r8=
a7796-m3ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-r8=
a7796-m3ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328d1ec382cbb79cefcf0a
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:26:35.318087  / # #

    2023-10-20T14:26:35.418570  export SHELL=3D/bin/sh

    2023-10-20T14:26:35.418685  #

    2023-10-20T14:26:35.519170  / # export SHELL=3D/bin/sh. /lava-11829281/=
environment

    2023-10-20T14:26:35.519282  =


    2023-10-20T14:26:35.619763  / # . /lava-11829281/environment/lava-11829=
281/bin/lava-test-runner /lava-11829281/1

    2023-10-20T14:26:35.619964  =


    2023-10-20T14:26:35.631951  / # /lava-11829281/bin/lava-test-runner /la=
va-11829281/1

    2023-10-20T14:26:35.688835  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-20T14:26:35.688912  + cd /la<8>[    9.182451] <LAVA_SIGNAL_STAR=
TRUN 1_bootrr 11829281_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
r8a7796-m3ulcb            | arm64  | lab-collabora   | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65328d5cd38684e8c8efcf4a

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796-m3ulc=
b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a7796-m3ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328d5cd38684e8c8efcf53
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:27:28.434324  / # #

    2023-10-20T14:27:28.536197  export SHELL=3D/bin/sh

    2023-10-20T14:27:28.536881  #

    2023-10-20T14:27:28.638159  / # export SHELL=3D/bin/sh. /lava-11829290/=
environment

    2023-10-20T14:27:28.638815  =


    2023-10-20T14:27:28.740044  / # . /lava-11829290/environment/lava-11829=
290/bin/lava-test-runner /lava-11829290/1

    2023-10-20T14:27:28.741314  =


    2023-10-20T14:27:28.742796  / # /lava-11829290/bin/lava-test-runner /la=
va-11829290/1

    2023-10-20T14:27:28.806686  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-20T14:27:28.807197  + cd /lav<8>[   13.625028] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11829290_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | defconfig=
                    | 3          =


  Details:     https://kernelci.org/test/plan/id/65328d59d38684e8c8efcefb

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-j=
aq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/65328d59d38684e8c8efcf2f
        failing since 273 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:27:22.887647  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   11.496921] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-10-20T14:27:22.889502   multi-call binary.

    2023-10-20T14:27:22.889721  =


    2023-10-20T14:27:22.894170  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-10-20T14:27:22.894388  =


    2023-10-20T14:27:22.899391  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/65328d59d38684e8c8efcf30
        failing since 273 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:27:22.868922  <8>[   11.479502] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328d59d38684e8c8efcf43
        failing since 273 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:27:19.042769  <8>[    7.653408] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-10-20T14:27:19.052125  + <8>[    7.665616] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11829284_1.5.2.3.1>

    2023-10-20T14:27:19.052671  set +x

    2023-10-20T14:27:19.158129  =


    2023-10-20T14:27:19.258955  / # #export SHELL=3D/bin/sh

    2023-10-20T14:27:19.259165  =


    2023-10-20T14:27:19.359594  / # export SHELL=3D/bin/sh. /lava-11829284/=
environment

    2023-10-20T14:27:19.359738  =


    2023-10-20T14:27:19.460167  / # . /lava-11829284/environment/lava-11829=
284/bin/lava-test-runner /lava-11829284/1

    2023-10-20T14:27:19.460366  =

 =

    ... (17 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | defconfig=
+preempt_rt         | 3          =


  Details:     https://kernelci.org/test/plan/id/65328da9cf7ef2c6eeefcf1b

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-rk32=
88-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-rk32=
88-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/65328da9cf7ef2c6eeefcf4f
        failing since 273 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:28:47.292954  <8>[   12.313977] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-driver-audio-present RESULT=3Dfail>

    2023-10-20T14:28:47.297404  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-10-20T14:28:47.297622  =


    2023-10-20T14:28:47.302500  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-10-20T14:28:47.305077  FIRST, INC default to 1.

    2023-10-20T14:28:47.305298  =


    2023-10-20T14:28:47.315470  	<8>[   12.335751] <LAVA_SIGNAL_TESTCASE TE=
ST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/65328da9cf7ef2c6eeefcf50
        failing since 273 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:28:47.271033  <8>[   12.295424] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>

    2023-10-20T14:28:47.282575  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-10-20T14:28:47.282970  =

   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328da9cf7ef2c6eeefcf63
        failing since 273 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:28:43.415365  + <8>[    8.441867] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11829322_1.5.2.3.1>

    2023-10-20T14:28:43.415771  set +x

    2023-10-20T14:28:43.521487  #

    2023-10-20T14:28:43.522614  =


    2023-10-20T14:28:43.624183  / # #export SHELL=3D/bin/sh

    2023-10-20T14:28:43.624886  =


    2023-10-20T14:28:43.726258  / # export SHELL=3D/bin/sh. /lava-11829322/=
environment

    2023-10-20T14:28:43.726977  =


    2023-10-20T14:28:43.828442  / # . /lava-11829322/environment/lava-11829=
322/bin/lava-test-runner /lava-11829322/1

    2023-10-20T14:28:43.829499  =

 =

    ... (17 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/653289c06bb37ad9a6efcf11

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288=
-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288=
-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/653289c16bb37ad9a6efcf45
        failing since 273 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:11:59.303392  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   11.263708] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-10-20T14:11:59.307000   multi-call binary.

    2023-10-20T14:11:59.307238  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/653289c16bb37ad9a6efcf46
        failing since 273 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:11:59.284530  <8>[   11.245956] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/653289c16bb37ad9a6efcf59
        failing since 273 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:11:55.451910  <8>[    7.413651] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-10-20T14:11:55.461456  + <8>[    7.425947] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11829139_1.5.2.3.1>

    2023-10-20T14:11:55.462084  set +x

    2023-10-20T14:11:55.567810  #

    2023-10-20T14:11:55.568131  =


    2023-10-20T14:11:55.668967  / # #export SHELL=3D/bin/sh

    2023-10-20T14:11:55.669562  =


    2023-10-20T14:11:55.770844  / # export SHELL=3D/bin/sh. /lava-11829139/=
environment

    2023-10-20T14:11:55.771810  =


    2023-10-20T14:11:55.873353  / # . /lava-11829139/environment/lava-11829=
139/bin/lava-test-runner /lava-11829139/1
 =

    ... (18 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora   | gcc-10   | multi_v7_=
defc...g+preempt_rt | 3          =


  Details:     https://kernelci.org/test/plan/id/65328c2d151437af13efcf63

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/base=
line-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/base=
line-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/65328c2d151437af13efcf97
        failing since 273 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:22:18.294906  <8>[   12.247465] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-driver-audio-present RESULT=3Dfail>

    2023-10-20T14:22:18.298090  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-10-20T14:22:18.298336  =


    2023-10-20T14:22:18.303539  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-10-20T14:22:18.305984  FIRST, INC default to 1.

    2023-10-20T14:22:18.306211  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/65328c2d151437af13efcf98
        failing since 273 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:22:18.272304  =


    2023-10-20T14:22:18.283370  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-10-20T14:22:18.283720  =

   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328c2d151437af13efcfab
        failing since 273 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:22:14.406284  <8>[    8.362578] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-10-20T14:22:14.415303  + <8>[    8.374842] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11829190_1.5.2.3.1>

    2023-10-20T14:22:14.416275  set +x

    2023-10-20T14:22:14.522129  #

    2023-10-20T14:22:14.523298  =


    2023-10-20T14:22:14.625056  / # #export SHELL=3D/bin/sh

    2023-10-20T14:22:14.625759  =


    2023-10-20T14:22:14.727135  / # export SHELL=3D/bin/sh. /lava-11829190/=
environment

    2023-10-20T14:22:14.727880  =


    2023-10-20T14:22:14.829448  / # . /lava-11829190/environment/lava-11829=
190/bin/lava-test-runner /lava-11829190/1
 =

    ... (17 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie     | gcc-10   | defconfig=
+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/65328e0a5fcdd631d0efcf24

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-sun5=
0i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/baseline-sun5=
0i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328e0b5fcdd631d0efcf4e
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:25:43.318575  <8>[   16.881564] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 181370_1.5.2.4.1>
    2023-10-20T14:25:43.426883  / # #
    2023-10-20T14:25:43.529278  export SHELL=3D/bin/sh
    2023-10-20T14:25:43.529756  #
    2023-10-20T14:25:43.631204  / # export SHELL=3D/bin/sh. /lava-181370/en=
vironment
    2023-10-20T14:25:43.631755  =

    2023-10-20T14:25:43.733219  / # . /lava-181370/environment/lava-181370/=
bin/lava-test-runner /lava-181370/1
    2023-10-20T14:25:43.734026  =

    2023-10-20T14:25:43.738633  / # /lava-181370/bin/lava-test-runner /lava=
-181370/1
    2023-10-20T14:25:43.779539  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
sun50i-a64-pine64-plus    | arm64  | lab-broonie     | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65328e96b1baba1250efcf1e

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine=
64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine=
64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328e96b1baba1250efcf47
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:28:06.501772  <8>[   15.970278] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 181395_1.5.2.4.1>
    2023-10-20T14:28:06.606571  / # #
    2023-10-20T14:28:06.708301  export SHELL=3D/bin/sh
    2023-10-20T14:28:06.708920  #
    2023-10-20T14:28:06.810514  / # export SHELL=3D/bin/sh. /lava-181395/en=
vironment
    2023-10-20T14:28:06.811146  =

    2023-10-20T14:28:06.912767  / # . /lava-181395/environment/lava-181395/=
bin/lava-test-runner /lava-181395/1
    2023-10-20T14:28:06.913713  =

    2023-10-20T14:28:06.917868  / # /lava-181395/bin/lava-test-runner /lava=
-181395/1
    2023-10-20T14:28:06.949049  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-collabora   | gcc-10   | defconfig=
+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/65328d323f50789e9aefcfc1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-su=
n50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm64/defconfig+preempt_rt/gcc-10/lab-collabora/baseline-su=
n50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328d323f50789e9aefcfca
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:26:56.621611  / # #

    2023-10-20T14:26:56.723502  export SHELL=3D/bin/sh

    2023-10-20T14:26:56.723745  #

    2023-10-20T14:26:56.824292  / # export SHELL=3D/bin/sh. /lava-11829275/=
environment

    2023-10-20T14:26:56.824497  =


    2023-10-20T14:26:56.924983  / # . /lava-11829275/environment/lava-11829=
275/bin/lava-test-runner /lava-11829275/1

    2023-10-20T14:26:56.925256  =


    2023-10-20T14:26:56.931238  / # /lava-11829275/bin/lava-test-runner /la=
va-11829275/1

    2023-10-20T14:26:56.971787  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-20T14:26:57.006360  + cd /lava-11829275/1/te<8>[   16.415385] <=
LAVA_SIGNAL_STARTRUN 1_bootrr 11829275_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-collabora   | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65328d6d38219e3734efcf19

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328d6d38219e3734efcf22
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:27:42.297407  / # #

    2023-10-20T14:27:42.399594  export SHELL=3D/bin/sh

    2023-10-20T14:27:42.400416  #

    2023-10-20T14:27:42.501700  / # export SHELL=3D/bin/sh. /lava-11829299/=
environment

    2023-10-20T14:27:42.502434  =


    2023-10-20T14:27:42.603883  / # . /lava-11829299/environment/lava-11829=
299/bin/lava-test-runner /lava-11829299/1

    2023-10-20T14:27:42.605045  =


    2023-10-20T14:27:42.621773  / # /lava-11829299/bin/lava-test-runner /la=
va-11829299/1

    2023-10-20T14:27:42.678809  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-20T14:27:42.679321  + cd /lava-1182929<8>[   15.606683] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11829299_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
zynqmp-zcu102             | arm64  | lab-cip         | gcc-10   | defconfig=
+preempt_rt         | 1          =


  Details:     https://kernelci.org/test/plan/id/65328d343f50789e9aefcfcc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-zynqmp-z=
cu102.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm64/defconfig+preempt_rt/gcc-10/lab-cip/baseline-zynqmp-z=
cu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328d343f50789e9aefcfd5
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:22:25.839605  + set +x
    2023-10-20T14:22:25.842741  <8>[    4.464932] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1023123_1.5.2.4.1>
    2023-10-20T14:22:25.949604  / # #
    2023-10-20T14:22:26.050995  export SHELL=3D/bin/sh
    2023-10-20T14:22:26.051436  #
    2023-10-20T14:22:26.152359  / # export SHELL=3D/bin/sh. /lava-1023123/e=
nvironment
    2023-10-20T14:22:26.152807  =

    2023-10-20T14:22:26.253692  / # . /lava-1023123/environment/lava-102312=
3/bin/lava-test-runner /lava-1023123/1
    2023-10-20T14:22:26.254550  =

    2023-10-20T14:22:26.258473  / # /lava-1023123/bin/lava-test-runner /lav=
a-1023123/1 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab             | compiler | defconfig=
                    | regressions
--------------------------+--------+-----------------+----------+----------=
--------------------+------------
zynqmp-zcu102             | arm64  | lab-cip         | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65328d5dd38684e8c8efcf58

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/arm64/defconfig/gcc-10/lab-cip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65328d5dd38684e8c8efcf61
        failing since 274 days (last pass: v4.19.265-cip85-rt27, first fail=
: v4.19.269-cip88-rt28)

    2023-10-20T14:23:08.042070  + set +x
    2023-10-20T14:23:08.045255  <8>[    3.763487] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1023147_1.5.2.4.1>
    2023-10-20T14:23:08.149825  / # #
    2023-10-20T14:23:08.251233  export SHELL=3D/bin/sh
    2023-10-20T14:23:08.251670  #
    2023-10-20T14:23:08.352568  / # export SHELL=3D/bin/sh. /lava-1023147/e=
nvironment
    2023-10-20T14:23:08.353003  =

    2023-10-20T14:23:08.453936  / # . /lava-1023147/environment/lava-102314=
7/bin/lava-test-runner /lava-1023147/1
    2023-10-20T14:23:08.454621  =

    2023-10-20T14:23:08.459181  / # /lava-1023147/bin/lava-test-runner /lav=
a-1023147/1 =

    ... (13 line(s) more)  =

 =20


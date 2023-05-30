Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989B6C7EE2E
	for <webhook@archiver.kernel.org>; Tue, 30 May 2023 16:55:48 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web10.2709.1685465739838497521
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 30 May 2023 09:55:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=RgF/r3N2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-53202149ae2so2952834a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 30 May 2023 09:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685465739; x=1688057739;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/+dsq+7+gef1lK7i467tjKhmBeNy/3wUd2eToVA+4I=;
        b=RgF/r3N2xy1vWajpPnZEPoZ+5+e90QhHVx8A1PVEqjNyJ+j2upIA11eibPR6RGI5AQ
         U1LTdNh0aQ829fTi/loF9P48LWEkr5NCkCjOi67lU6ruXGpoCnUgcOuabYHLaBhH1/kn
         j43RHTX2dvy4uSxx4Rg6mn81qbFmeYFZrjZ4Rsr9i/0i8+3hlx/s9XQ/b/Mg/gVJanBj
         78Akw25DrTETcOoBnLsHy4iU6A3tCl+YxgkICgylc30p6YIUvchqcJzf3R9gnL+mNdsy
         /xydhYozie506MkULcN2Fk2JRpIdkTP34vtuIhtDDepRVvGDQ5Keo+3A4OyKe2PM2+oa
         jqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685465739; x=1688057739;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/+dsq+7+gef1lK7i467tjKhmBeNy/3wUd2eToVA+4I=;
        b=Ny7RdNSAgwMXTAqeVDLMN7eqzbXp0Ue8qClwSiOI85WnlGyzSnD0chRgJHjYZGd7Cm
         XPF6xmU+v/6a4hKrl+4ezQlLXQCgw2cJLj+2GF2eHLFp6Pf3xfLjxGJT2euimiHmHLq1
         CQSGDYOaEk8udWM9fwLmL5mPje9pW//s41X3EISt86wPBqc3pFYmI7BcG3UaRmCNu4sF
         Fhtfg54UwT9Dd21zQIZI62kII/rNIV05LAtIp7RaKRcQWehC8sob6tjHL1f6NmaRS0pr
         S9p1dM4oHIG1uvTFj3iyj42KPgLNRQedXybUDZW6e7NndYO4xwuyt2sQWlmUDtyv49fH
         cPag==
X-Gm-Message-State: AC+VfDySjLsT3sIrEHhEq1wbPS389gX24bpcPX2Ow2h1OzyY8AyBI+fs
	2zH6j2Vkm+6Qa3ld3XHevL0k1uuDcH5wq6DsEbmqng==
X-Google-Smtp-Source: ACHHUZ5vH+hBKK3L+ZhQq/W6iszBwUlGtI3045aJITzdJW/jg1AfIuI4F0yLnnqpUTR37SKQFeMB/w==
X-Received: by 2002:a17:90b:3908:b0:256:48a5:4fd0 with SMTP id ob8-20020a17090b390800b0025648a54fd0mr3267822pjb.1.1685465738461;
        Tue, 30 May 2023 09:55:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w21-20020a17090a461500b0024752ff8061sm1560269pjg.12.2023.05.30.09.55.37
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:55:37 -0700 (PDT)
Message-ID: <64762a89.170a0220.21d52.2bd3@mx.google.com>
Date: Tue, 30 May 2023 09:55:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.180-cip34-213-g6582dd41d2c22
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 53 runs,
 6 regressions (v5.10.180-cip34-213-g6582dd41d2c22)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 May 2023 16:55:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11707

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 53 runs, 6 regress=
ions (v5.10.180-cip34-213-g6582dd41d2c22)

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
Flinux-5.10.y-cip-rc/kernel/v5.10.180-cip34-213-g6582dd41d2c22/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.180-cip34-213-g6582dd41d2c22
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6582dd41d2c22c9ea2ddcf80d06886b8470ab496 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64761b803918d695062e85fc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oc=
topus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oc=
topus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64761b803918d695062e8601
        failing since 40 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-30T15:51:14.827925  + set<8>[   27.677969] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10526796_1.5.2.3.1>

    2023-05-30T15:51:14.828023   +x

    2023-05-30T15:51:14.956262  / # #

    2023-05-30T15:51:15.056934  export SHELL=3D/bin/sh

    2023-05-30T15:51:15.057161  #

    2023-05-30T15:51:15.157768  / # export SHELL=3D/bin/sh. /lava-10526796/=
environment

    2023-05-30T15:51:15.157988  =


    2023-05-30T15:51:15.258566  / # . /lava-10526796/environment/lava-10526=
796/bin/lava-test-runner /lava-10526796/1

    2023-05-30T15:51:15.258931  =


    2023-05-30T15:51:15.264200  / # /lava-10526796/bin/lava-test-runner /la=
va-10526796/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64761e01e7ea11a35b2e8628

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010n=
r-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010n=
r-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64761e01e7ea11a35b2e862d
        failing since 40 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-30T16:02:03.551599  + set +x

    2023-05-30T16:02:03.557714  [   27.908307] <LAVA_SIGNAL_ENDRUN 0_dmesg =
10527090_1.5.2.3.1>

    2023-05-30T16:02:03.666194  / # #

    2023-05-30T16:02:03.768603  export SHELL=3D/bin/sh

    2023-05-30T16:02:03.769347  #

    2023-05-30T16:02:03.870852  / # export SHELL=3D/bin/sh. /lava-10527090/=
environment

    2023-05-30T16:02:03.871642  =


    2023-05-30T16:02:03.973297  / # . /lava-10527090/environment/lava-10527=
090/bin/lava-test-runner /lava-10527090/1

    2023-05-30T16:02:03.974555  =


    2023-05-30T16:02:03.980002  / # /lava-10527090/bin/lava-test-runner /la=
va-10527090/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64761b3ebda8c0e3da2e85e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64761b3ebda8c0e3da2e85eb
        failing since 40 days (last pass: v5.10.168-cip27-109-g23841ec76bec=
, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-30T15:49:59.646607  + <8>[   19.226349] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10526786_1.5.2.3.1>

    2023-05-30T15:49:59.646741  set +x

    2023-05-30T15:49:59.751132  / # #

    2023-05-30T15:49:59.851813  export SHELL=3D/bin/sh

    2023-05-30T15:49:59.852029  #

    2023-05-30T15:49:59.952508  / # export SHELL=3D/bin/sh. /lava-10526786/=
environment

    2023-05-30T15:49:59.952696  =


    2023-05-30T15:50:00.053191  / # . /lava-10526786/environment/lava-10526=
786/bin/lava-test-runner /lava-10526786/1

    2023-05-30T15:50:00.053534  =


    2023-05-30T15:50:00.058575  / # /lava-10526786/bin/lava-test-runner /la=
va-10526786/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64761d8d4f91a7a5792e8616

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.=
txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64761d8d4f91a7a5792e861b
        failing since 40 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-30T16:00:03.671413  + set +x[   21.205494] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10527078_1.5.2.3.1>

    2023-05-30T16:00:03.671502  =


    2023-05-30T16:00:03.776031  / # #

    2023-05-30T16:00:03.876592  export SHELL=3D/bin/sh

    2023-05-30T16:00:03.876762  #

    2023-05-30T16:00:03.977255  / # export SHELL=3D/bin/sh. /lava-10527078/=
environment

    2023-05-30T16:00:03.977448  =


    2023-05-30T16:00:04.077994  / # . /lava-10527078/environment/lava-10527=
078/bin/lava-test-runner /lava-10527078/1

    2023-05-30T16:00:04.078295  =


    2023-05-30T16:00:04.083544  / # /lava-10527078/bin/lava-test-runner /la=
va-10527078/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/647622715a0c2697a82e8649

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-213-g6582dd41d2c22/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/647622715a0c2697a82e864f
        failing since 40 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-30T16:20:54.683787  <8>[   95.900385] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-05-30T16:20:55.727033  /lava-10527284/1/../bin/lava-test-case

    2023-05-30T16:20:55.757658  <8>[   96.975090] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/647622715a0c2697a82e8650
        failing since 40 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-05-30T16:20:53.604018  <8>[   94.820483] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-05-30T16:20:54.655229  /lava-10527284/1/../bin/lava-test-case
   =

 =20


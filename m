Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC07C7EE29
	for <webhook@archiver.kernel.org>; Wed,  7 Jun 2023 14:54:25 +0000 (UTC)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
 by mx.groups.io with SMTP id smtpd.web11.222.1686149662879059598
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Jun 2023 07:54:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=y5H5/BXj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.179, mailfrom: bot@kernelci.org)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-33b4b70693eso6087035ab.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Jun 2023 07:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686149661; x=1688741661;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NG6GJP3c5Aa/8AnpeCibSl3rG6DQ86Tbtka5GLEmCOI=;
        b=y5H5/BXj5HLbHuGkXXbf6DOVHrsWPt/ssq9rxz56Q9QFOO1PLbgTZP5hJK+q8V8oZ3
         5soYQYyUL0K43IOUMlBtk7resnonEBLE2o9HrKbEhG1MQX8+va6srFbmvMoNYnid5I8Y
         Ec0XuQPNG14e3VepngdKMfDxUgvKH23NG7eWfhqyriVTBSTBZdi+DhDT719D6buFEFGj
         xIiMTUNfTbEie05lik8MvIMFjCwSXdOG7ddTeLUOBmum7HAn5NGJWqPtNYoWr9RBbL6k
         /LEpeIpg5lxWGJ/B1RtVa+Vh5DbnbSrvwDcTdbtvCJJaVu33YbPrgoDxeA7Lks5G5YHR
         2k8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686149661; x=1688741661;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NG6GJP3c5Aa/8AnpeCibSl3rG6DQ86Tbtka5GLEmCOI=;
        b=a1QpoX9KkJX2ssovmW/gpj5SfPWcZ/vEN907TpgzXwKOw16713ax5cAdjqdfk++a6J
         YkBGv+oVtatv3NHd6wW8nq9inSfqwtbsv8h05Wq7ne6EprcczKw///eh1Muk9Ag+iV5X
         /4KQIyRrIoDVbReQ5935Wz218+jHt5NTzOTu/eCkGSkd3n+E6Z6giY0RfkjJdU2bsW6y
         AhNCqjT8J1iokKDZQQrDZ3wp091T1SlF6GKoXDlaW7v1fNGIcoCBhp3tmI6J3hIGNMPH
         rXh9+qLcXUJPVV8ub8H96jbvsALfbjxI1XIix+o+WPjnVr+UBKaVbCkOE68js7W7B700
         txtg==
X-Gm-Message-State: AC+VfDzHsyyojcBRMAyCjxlh+0TFLqJgt8WOHvqrY6C77lJnv99q71/h
	L7eTwWw6VuGxsBGnapfnaSh5p554Um/YUxWM5pOuHQ==
X-Google-Smtp-Source: ACHHUZ7OWKPpoD1p560qjHthhDiNbMqohMDaZIcx4VnQLzhEs5SNtQ8btT2+KFwcz0PXl6ULeQuTbw==
X-Received: by 2002:a92:6e12:0:b0:335:9303:4345 with SMTP id j18-20020a926e12000000b0033593034345mr8441042ilc.25.1686149660584;
        Wed, 07 Jun 2023 07:54:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j25-20020aa78d19000000b0065dd1e7c2c1sm1094783pfe.63.2023.06.07.07.54.19
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 07:54:19 -0700 (PDT)
Message-ID: <64809a1b.a70a0220.ef6b7.1d0e@mx.google.com>
Date: Wed, 07 Jun 2023 07:54:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip74-rt43-218-g246f4be89a77
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 31 runs,
 71 regressions (v4.4.302-cip74-rt43-218-g246f4be89a77)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jun 2023 14:54:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11916

cip-gitlab/ci/pavel/linux-test baseline-nfs: 31 runs, 71 regressions (v4.4.=
302-cip74-rt43-218-g246f4be89a77)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 15         =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 15         =

dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-14-db0003na-grunt         | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 5          =

imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 10         =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 10         =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip74-rt43-218-g246f4be89a77/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip74-rt43-218-g246f4be89a77
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      246f4be89a7760f90649094cbfabcccfce7dafd1 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648091b208562f963c30613b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/648091b208562f963=
c30613c
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648090f4e24641cc2d306135

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/648090f4e24641cc2=
d306136
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648091ab2e8d8174e830612f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/648091ab2e8d8174e=
8306130
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6480916c49b5dac807306140

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6480916c49b5dac80=
7306141
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648091a99df46930d6306154

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/648091a99df46930d=
6306155
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648091aa89bb8a213b30614a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/648091aa89bb8a213=
b30614b
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64809174846cc39cee30612e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-br=
oonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-br=
oonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64809174846cc39ce=
e30612f
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64809354aac3bed9bb3061ad

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-ci=
p/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-ci=
p/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64809354aac3bed9b=
b3061ae
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 15         =


  Details:     https://kernelci.org/test/plan/id/648092f77bc53ad9ba306195

  Results:     24 PASS, 17 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/omap2plus_defconfig/gcc-10/lab-b=
roonie/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/omap2plus_defconfig/gcc-10/lab-b=
roonie/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64809=
2f77bc53ad9ba306198
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:23:36.133620  /lava-575552/1/../bin/lava-test-case
    2023-06-07T14:23:36.254868  [  100.057858] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-06-07T14:23:37.374154  /lava-575552/1/../bin/lava-test-case
    2023-06-07T14:23:37.496934  [  101.300765] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.simple-audio-driver-present: https://kernelci.org/t=
est/case/id/648092f77bc53ad9ba306199
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:23:33.805287  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: 84: assert_device-present: not found
    2023-06-07T14:23:34.868144  /lava-575552/1/../bin/lava-test-case
    2023-06-07T14:23:35.014459  [   98.816847] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/648092f77bc53ad9ba30619a
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:23:32.411982  /lava-575552/1/../bin/lava-test-case
    2023-06-07T14:23:32.529077  [   96.332207] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-06-07T14:23:33.648852  /lava-575552/1/../bin/lava-test-case
    2023-06-07T14:23:33.775676  [   97.578324] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/648092f77bc53ad9ba30619b
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:23:29.846603  /lava-575552/1/../bin/lava-test-case
    2023-06-07T14:23:29.962358  [   93.765384] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-06-07T14:23:31.082810  /lava-575552/1/../bin/lava-test-case
    2023-06-07T14:23:31.294408  [   95.097236] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/648092f77bc53ad9ba30619c
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:23:27.399571  /lava-575552/1/../bin/lava-test-case
    2023-06-07T14:23:27.522052  [   91.325351] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-06-07T14:23:28.607256  /lava-575552/1/../bin/lava-test-case
    2023-06-07T14:23:28.729162  [   92.531797] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tilcdc-driver-probed: https://kernelci.org/test/cas=
e/id/648092f77bc53ad9ba30619d
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:23:26.146676  /lava-575552/1/../bin/lava-test-case
    2023-06-07T14:23:26.277043  [   90.079862] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtilcdc-driver-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-sham-driver-present: https://kernelci.org/test=
/case/id/648092f77bc53ad9ba3061a2
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:23:22.029516  /lava-575552/1/../bin/lava-test-case
    2023-06-07T14:23:23.121589  [   86.923981] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-aes-driver-present: https://kernelci.org/test/=
case/id/648092f77bc53ad9ba3061a5
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:23:13.370677  /lava-575552/1/../bin/lava-test-case
    2023-06-07T14:23:15.707333  [   79.509690] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/648092f77bc53ad9ba3061a8
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:23:09.351707  /lava-575552/1/../bin/lava-test-case
    2023-06-07T14:23:09.468485  [   73.270648] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-06-07T14:23:10.577694  /lava-575552/1/../bin/lava-test-case
    2023-06-07T14:23:10.698271  [   74.500056] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/648092f77bc53ad9ba3061a9
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:23:08.100400  /lava-575552/1/../bin/lava-test-case
    2023-06-07T14:23:08.232285  [   72.034035] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sdhci-omap-driver-present: https://kernelci.org/tes=
t/case/id/648092f77bc53ad9ba3061b0
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:23:01.371099  /lava-575552/1/../bin/lava-test-case
    2023-06-07T14:23:01.503404  [   65.305298] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dbaseboard-eeprom-probed RESULT=3Dblocked>
    2023-06-07T14:23:02.594368  /lava-575552/1/../bin/lava-test-case
    2023-06-07T14:23:02.706043  [   66.507859] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.at24-driver-present: https://kernelci.org/test/case=
/id/648092f77bc53ad9ba3061b1
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:23:00.138179  /lava-575552/1/../bin/lava-test-case
    2023-06-07T14:23:00.252626  [   64.056085] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dat24-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.pwrbutton-driver-present: https://kernelci.org/test=
/case/id/648092f77bc53ad9ba3061b5
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:22:57.346993  /lava-575552/1/../bin/lava-test-case
    2023-06-07T14:22:57.556719  [   61.358573] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dpwrbutton-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap8240-driver-present: https://kernelci.org/test/=
case/id/648092f77bc53ad9ba3061bb
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:22:54.168542  /lava-575552/1/../bin/lava-test-case
    2023-06-07T14:22:54.277295  [   58.078914] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/648092f77bc5=
3ad9ba3061c2
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)
        1 lines

    2023-06-07T14:22:42.593985  / # =

    2023-06-07T14:22:42.598388  =

    2023-06-07T14:22:47.617560  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/575552/extract-nfsrootfs-sfczhl5b'
    2023-06-07T14:22:47.628207  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/575552/extract-nfsrootfs-sfczhl5b'
    2023-06-07T14:22:49.919201  / # export NFS_SERVER_IP=3D'192.168.56.193'
    2023-06-07T14:22:49.929941  export NFS_SERVER_IP=3D'192.168.56.193'
    2023-06-07T14:22:50.035171  / # #
    2023-06-07T14:22:50.039955  #
    2023-06-07T14:22:50.149251  / # export SHELL=3D/bin/sh
    2023-06-07T14:22:50.153835  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 15         =


  Details:     https://kernelci.org/test/plan/id/64809764eebf2d9c7a30615d

  Results:     24 PASS, 17 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/omap2plus_defconfig/gcc-10/lab-c=
ip/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/omap2plus_defconfig/gcc-10/lab-c=
ip/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.omap8240-driver-present: https://kernelci.org/test/=
case/id/64809764eebf2d9c7a306163
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:41:40.443372  /lava-955518/1/../bin/lava-test-case
    2023-06-07T14:41:40.667890  [   50.330376] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.pwrbutton-driver-present: https://kernelci.org/test=
/case/id/64809764eebf2d9c7a306169
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:41:44.172591  /lava-955518/1/../bin/lava-test-case
    2023-06-07T14:41:44.384038  [   54.047341] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dpwrbutton-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.at24-driver-present: https://kernelci.org/test/case=
/id/64809764eebf2d9c7a30616c
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:41:47.163782  /lava-955518/1/../bin/lava-test-case
    2023-06-07T14:41:47.376208  [   57.040075] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dat24-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sdhci-omap-driver-present: https://kernelci.org/tes=
t/case/id/64809764eebf2d9c7a30616d
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:41:48.491541  /lava-955518/1/../bin/lava-test-case
    2023-06-07T14:41:48.687022  [   58.351190] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dbaseboard-eeprom-probed RESULT=3Dblocked>
    2023-06-07T14:41:49.766384  /lava-955518/1/../bin/lava-test-case
    2023-06-07T14:41:49.963990  [   59.627723] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/64809764eebf2d9c7a306175
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:41:55.355477  /lava-955518/1/../bin/lava-test-case
    2023-06-07T14:41:55.524628  [   65.188753] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/64809764eebf2d9c7a306176
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:41:56.604079  /lava-955518/1/../bin/lava-test-case
    2023-06-07T14:41:56.804836  [   66.468814] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-06-07T14:41:57.885583  /lava-955518/1/../bin/lava-test-case
    2023-06-07T14:41:58.094870  [   67.758535] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-aes-driver-present: https://kernelci.org/test/=
case/id/64809764eebf2d9c7a306179
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:42:00.938853  /lava-955518/1/../bin/lava-test-case
    2023-06-07T14:42:01.148099  [   70.812463] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-sham-driver-present: https://kernelci.org/test=
/case/id/64809764eebf2d9c7a30617c
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:42:04.021271  /lava-955518/1/../bin/lava-test-case
    2023-06-07T14:42:04.231505  [   73.896133] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tilcdc-driver-probed: https://kernelci.org/test/cas=
e/id/64809764eebf2d9c7a306181
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:42:07.633955  /lava-955518/1/../bin/lava-test-case
    2023-06-07T14:42:07.843939  [   77.509466] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtilcdc-driver-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/64809764eebf2d9c7a306182
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:42:08.974920  /lava-955518/1/../bin/lava-test-case
    2023-06-07T14:42:09.189343  [   78.855395] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-06-07T14:42:10.302391  /lava-955518/1/../bin/lava-test-case
    2023-06-07T14:42:10.491503  [   80.156053] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/64809764eebf2d9c7a306183
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:42:11.617564  /lava-955518/1/../bin/lava-test-case
    2023-06-07T14:42:11.815028  [   81.481020] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-06-07T14:42:12.939750  /lava-955518/1/../bin/lava-test-case
    2023-06-07T14:42:13.129951  [   82.795522] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/64809764eebf2d9c7a306184
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:42:14.209306  /lava-955518/1/../bin/lava-test-case
    2023-06-07T14:42:14.409980  [   84.075577] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-06-07T14:42:15.487354  /lava-955518/1/../bin/lava-test-case
    2023-06-07T14:42:15.684810  [   85.350680] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.simple-audio-driver-present: https://kernelci.org/t=
est/case/id/64809764eebf2d9c7a306185
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:42:15.704048  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: 84: assert_device-present: not found
    2023-06-07T14:42:16.771051  /lava-955518/1/../bin/lava-test-case
    2023-06-07T14:42:16.974073  [   86.639116] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64809=
764eebf2d9c7a306186
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:42:18.058853  /lava-955518/1/../bin/lava-test-case
    2023-06-07T14:42:18.261726  [   87.927183] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-06-07T14:42:19.382383  /lava-955518/1/../bin/lava-test-case
    2023-06-07T14:42:19.593911  [   89.260517] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/64809764eebf=
2d9c7a306188
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)
        1 lines

    2023-06-07T14:41:27.982758  / # =

    2023-06-07T14:41:27.993668  =

    2023-06-07T14:41:33.011322  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/955518/extract-nfsrootfs-923gblbz'
    2023-06-07T14:41:33.022243  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/955518/extract-nfsrootfs-923gblbz'
    2023-06-07T14:41:35.076156  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2023-06-07T14:41:35.087094  export NFS_SERVER_IP=3D'172.16.3.3'
    2023-06-07T14:41:35.195720  / # #
    2023-06-07T14:41:35.202438  #
    2023-06-07T14:41:35.311101  / # export SHELL=3D/bin/sh
    2023-06-07T14:41:35.318622  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648091c065a368c4da306145

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-dell-latitude-5400-4305U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-dell-latitude-5400-4305U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/648091c065a368c4d=
a306146
        failing since 1 day (last pass: v6.1.26-1321-g3152fb7c8d2d6, first =
fail: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648091c6873488f3bd306152

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-dell-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-dell-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/648091c6873488f3b=
d306153
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648091ab89bb8a213b30614f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/648091ab89bb8a213=
b306150
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-14-db0003na-grunt         | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648090f6e24641cc2d30613c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-hp-14-db0003na-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-hp-14-db0003na-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/648090f6e24641cc2=
d30613d
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648091e4c31042a97e306141

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/648091e4c31042a97=
e306142
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64809202c4b33360b1306151

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64809202c4b33360b=
1306152
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648091be08562f963c306152

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/648091be08562f963=
c306153
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig          | 5          =


  Details:     https://kernelci.org/test/plan/id/648091c365a368c4da306173

  Results:     23 PASS, 7 FAIL, 2 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/imx_v6_v7_defconfig/gcc-10/lab-b=
roonie/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/imx_v6_v7_defconfig/gcc-10/lab-b=
roonie/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.entnaviv-gpu-driver-present: https://kernelci.org/t=
est/case/id/648091c365a368c4da306176
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:18:31.349349  /lava-575534/1/../bin/lava-test-case
    2023-06-07T14:18:31.404583  [   33.879190] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dipu-probed RESULT=3Dblocked>
    2023-06-07T14:18:32.455998  /lava-575534/1/../bin/lava-test-case
    2023-06-07T14:18:32.519399  [   34.993627] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dentnaviv-gpu-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sound-card: https://kernelci.org/test/case/id/64809=
1c365a368c4da30617a
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:18:30.074579  /lava-575534/1/../bin/lava-test-case
    2023-06-07T14:18:30.130715  [   32.605301] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sound-card-probed: https://kernelci.org/test/case/i=
d/648091c365a368c4da30617b
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:18:28.968438  /lava-575534/1/../bin/lava-test-case
    2023-06-07T14:18:29.036614  [   31.511839] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsound-card-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ssi-probed: https://kernelci.org/test/case/id/64809=
1c365a368c4da30617d
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:18:27.804631  /lava-575534/1/../bin/lava-test-case
    2023-06-07T14:18:27.853894  [   30.328787] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dssi-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ttymxc3-probed: https://kernelci.org/test/case/id/6=
48091c365a368c4da30618b
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:18:25.760763  /lava-575534/1/../bin/lava-test-case
    2023-06-07T14:18:25.820073  [   28.294748] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dttymxc3-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 10         =


  Details:     https://kernelci.org/test/plan/id/6480914909e4521bf9306165

  Results:     11 PASS, 12 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-br=
oonie/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-br=
oonie/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.entnaviv-gpu-driver-present: https://kernelci.org/t=
est/case/id/6480914909e4521bf9306168
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:16:15.102057  /lava-575508/1/../bin/lava-test-case
    2023-06-07T14:16:15.136964  [   46.306822] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dipu-probed RESULT=3Dblocked>
    2023-06-07T14:16:16.168250  /lava-575508/1/../bin/lava-test-case
    2023-06-07T14:16:16.199194  [   47.367901] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dentnaviv-gpu-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.imx-ipuv3-driver-present: https://kernelci.org/test=
/case/id/6480914909e4521bf9306169
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:16:12.977244  /lava-575508/1/../bin/lava-test-case
    2023-06-07T14:16:13.009293  [   44.178964] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-probed RESULT=3Dblocked>
    2023-06-07T14:16:14.039865  /lava-575508/1/../bin/lava-test-case
    2023-06-07T14:16:14.074054  [   45.242904] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dimx-ipuv3-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.dwhdmi-imx-driver-present: https://kernelci.org/tes=
t/case/id/6480914909e4521bf930616a
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:16:11.914589  /lava-575508/1/../bin/lava-test-case
    2023-06-07T14:16:11.945207  [   43.114073] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-imx-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sound-card: https://kernelci.org/test/case/id/64809=
14909e4521bf930616b
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:16:09.792635  /lava-575508/1/../bin/lava-test-case
    2023-06-07T14:16:09.822815  [   40.992227] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsound-card-probed RESULT=3Dblocked>
    2023-06-07T14:16:10.854343  /lava-575508/1/../bin/lava-test-case
    2023-06-07T14:16:10.885849  [   42.055994] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline-nfs.bootrr.fsl-asoc-card-driver-present: https://kernelci.org/=
test/case/id/6480914909e4521bf930616c
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:16:07.668122  /lava-575508/1/../bin/lava-test-case
    2023-06-07T14:16:07.701919  [   38.871937] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dssi-probed RESULT=3Dblocked>
    2023-06-07T14:16:08.730417  /lava-575508/1/../bin/lava-test-case
    2023-06-07T14:16:08.763210  [   39.931684] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dfsl-asoc-card-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.fsl-ssi-driver-present: https://kernelci.org/test/c=
ase/id/6480914909e4521bf930616d
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:16:04.483882  /lava-575508/1/../bin/lava-test-case
    2023-06-07T14:16:04.515798  [   35.685485] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcaam-jr0-probed RESULT=3Dblocked>
    2023-06-07T14:16:05.545545  /lava-575508/1/../bin/lava-test-case
    2023-06-07T14:16:05.576616  [   36.746114] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcaam-jr1-probed RESULT=3Dblocked>
    2023-06-07T14:16:06.605675  /lava-575508/1/../bin/lava-test-case
    2023-06-07T14:16:06.638399  [   37.807664] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dfsl-ssi-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.caam-jr-driver-present: https://kernelci.org/test/c=
ase/id/6480914909e4521bf930616e
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:16:02.362053  /lava-575508/1/../bin/lava-test-case
    2023-06-07T14:16:02.394222  [   33.564126] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcaam-probed RESULT=3Dblocked>
    2023-06-07T14:16:03.424068  /lava-575508/1/../bin/lava-test-case
    2023-06-07T14:16:03.454793  [   34.624142] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcaam-jr-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.caam-driver-present: https://kernelci.org/test/case=
/id/6480914909e4521bf930616f
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:16:00.232513  /lava-575508/1/../bin/lava-test-case
    2023-06-07T14:16:00.266264  [   31.436852] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dwatchdog-probed RESULT=3Dblocked>
    2023-06-07T14:16:01.297886  /lava-575508/1/../bin/lava-test-case
    2023-06-07T14:16:01.332541  [   32.502038] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcaam-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.imx2-wdt-driver-present: https://kernelci.org/test/=
case/id/6480914909e4521bf9306170
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:15:59.162278  /lava-575508/1/../bin/lava-test-case
    2023-06-07T14:15:59.203596  [   30.372447] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dimx2-wdt-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ttymxc3-probed: https://kernelci.org/test/case/id/6=
480914909e4521bf9306177
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:15:57.747019  /lava-575508/1/../bin/lava-test-case
    2023-06-07T14:15:57.786399  [   28.956257] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dttymxc3-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 10         =


  Details:     https://kernelci.org/test/plan/id/6480913509e4521bf9306142

  Results:     11 PASS, 12 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-br=
oonie/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/arm/multi_v7_defconfig/gcc-10/lab-br=
oonie/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.entnaviv-gpu-driver-present: https://kernelci.org/t=
est/case/id/6480913509e4521bf9306145
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:16:12.138990  /lava-575517/1/../bin/lava-test-case
    2023-06-07T14:16:12.188783  [   45.978957] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dipu-probed RESULT=3Dblocked>
    2023-06-07T14:16:13.219263  /lava-575517/1/../bin/lava-test-case
    2023-06-07T14:16:13.263225  [   47.052237] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dentnaviv-gpu-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.imx-ipuv3-driver-present: https://kernelci.org/test=
/case/id/6480913509e4521bf9306146
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:16:09.906551  /lava-575517/1/../bin/lava-test-case
    2023-06-07T14:16:09.981555  [   43.771903] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-probed RESULT=3Dblocked>
    2023-06-07T14:16:11.011590  /lava-575517/1/../bin/lava-test-case
    2023-06-07T14:16:11.101906  [   44.892326] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dimx-ipuv3-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.dwhdmi-imx-driver-present: https://kernelci.org/tes=
t/case/id/6480913509e4521bf9306147
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:16:08.849265  /lava-575517/1/../bin/lava-test-case
    2023-06-07T14:16:08.879557  [   42.669062] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-imx-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sound-card: https://kernelci.org/test/case/id/64809=
13509e4521bf9306148
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:16:06.542905  /lava-575517/1/../bin/lava-test-case
    2023-06-07T14:16:06.737762  [   40.527473] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsound-card-probed RESULT=3Dblocked>
    2023-06-07T14:16:07.770182  /lava-575517/1/../bin/lava-test-case
    2023-06-07T14:16:07.816918  [   41.607581] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline-nfs.bootrr.fsl-asoc-card-driver-present: https://kernelci.org/=
test/case/id/6480913509e4521bf9306149
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:16:04.339599  /lava-575517/1/../bin/lava-test-case
    2023-06-07T14:16:04.396906  [   38.187458] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dssi-probed RESULT=3Dblocked>
    2023-06-07T14:16:05.476798  /lava-575517/1/../bin/lava-test-case
    2023-06-07T14:16:05.515101  [   39.304288] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dfsl-asoc-card-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.fsl-ssi-driver-present: https://kernelci.org/test/c=
ase/id/6480913509e4521bf930614a
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:16:00.950129  /lava-575517/1/../bin/lava-test-case
    2023-06-07T14:16:01.002432  [   34.792198] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcaam-jr0-probed RESULT=3Dblocked>
    2023-06-07T14:16:02.035491  /lava-575517/1/../bin/lava-test-case
    2023-06-07T14:16:02.084780  [   35.874696] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcaam-jr1-probed RESULT=3Dblocked>
    2023-06-07T14:16:03.114498  /lava-575517/1/../bin/lava-test-case
    2023-06-07T14:16:03.307446  [   37.097066] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dfsl-ssi-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.caam-jr-driver-present: https://kernelci.org/test/c=
ase/id/6480913509e4521bf930614b
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:15:58.710167  /lava-575517/1/../bin/lava-test-case
    2023-06-07T14:15:58.774195  [   32.564262] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcaam-probed RESULT=3Dblocked>
    2023-06-07T14:15:59.808395  /lava-575517/1/../bin/lava-test-case
    2023-06-07T14:15:59.874349  [   33.664037] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcaam-jr-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.caam-driver-present: https://kernelci.org/test/case=
/id/6480913509e4521bf930614c
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:15:56.466077  /lava-575517/1/../bin/lava-test-case
    2023-06-07T14:15:56.518319  [   30.309283] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dwatchdog-probed RESULT=3Dblocked>
    2023-06-07T14:15:57.546178  /lava-575517/1/../bin/lava-test-case
    2023-06-07T14:15:57.634448  [   31.424287] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcaam-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.imx2-wdt-driver-present: https://kernelci.org/test/=
case/id/6480913509e4521bf930614d
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:15:55.399773  /lava-575517/1/../bin/lava-test-case
    2023-06-07T14:15:55.439555  [   29.229267] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dimx2-wdt-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ttymxc3-probed: https://kernelci.org/test/case/id/6=
480913509e4521bf9306154
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785)

    2023-06-07T14:15:53.840714  /lava-575517/1/../bin/lava-test-case
    2023-06-07T14:15:53.883846  [   27.674261] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dttymxc3-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648090e688e217a2d5306176

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/648090e688e217a2d=
5306177
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =20


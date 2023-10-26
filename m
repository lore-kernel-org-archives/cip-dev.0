Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0F2C25B48
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 14:12:47 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web11.71683.1698329565072456230
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 26 Oct 2023 07:12:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=kzwimyBd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1c9daca2b85so6815585ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 26 Oct 2023 07:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698329564; x=1698934364; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dS0NVG/bbEYXy3Go0U1Z/xpNrGH4xrInF+O8P2hO5oM=;
        b=kzwimyBdTPJeRBDvBaO545+m2Sct1nQIKp3XX3OJQirsX/MXUU17QbMH0ThiUajvtx
         RzM0eLcHHAdcGSIc0NrTC05kFMLtbBawkFbtgeEuWwVofBPLWex6Hf/A6ZU8TUY3NEvh
         hf7KcMJFi506zw2H7aNfCOKgeIXYz1ZxyGAeUhydDe7jmKAWLJWUCiziacAg1CCUxzO4
         2CJsLC7lSaxyj4eKMS1yoV3VQ3hSvBvSlNMFHhm7ZR3JkyVxJOdFL24PoKFa5+cQCAgf
         Q/ytikKNE5omKgXOGVFVaAJULEkOLpQ9BGrm8AasecxITS25dE1OGOR+XfNmSkGpF9By
         DvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698329564; x=1698934364;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dS0NVG/bbEYXy3Go0U1Z/xpNrGH4xrInF+O8P2hO5oM=;
        b=AV/VBjnrhmljbQBOnX7MPvY0IaN7I6/8ThVmZF/LLKYhagqBRXeuAIhoVWnqcUa7Sm
         VoTZPGIpbju6ffFEAMuwAi21CjVvj2kImEQlnNLDfPzf+HYSeFNKy8vD4dO+ZG9fPo3W
         nbRk+J1pdVoco9Z+GQOErLfKKH3CJpW1kZlbJGGiEdfRCqhkAjkjXOowlqdb948oT2JM
         D1gZqN6ONKAOMug80/VknSrTmg+ofxWcKmkY3Sq5Iwf4l9iWnrrl3VyoDiCKSv0PKus6
         JkCOKMprUHGhA8MQfZzeQL2GyaYiAsfOs1IzwFwvlzZn3evYWaZMPKcdDccr24GChYkS
         vDog==
X-Gm-Message-State: AOJu0YyNeBOlBXmDizHDJay0FUWr3tNF4E14WTY8viX2Y9a0ak5diJxJ
	QZlS1auWDFqdozonJ0PZWz0bUB43ezKIOqrw6Ww=
X-Google-Smtp-Source: AGHT+IHjd7h/LY7Qdk1RWxdVU3sIwMg+r21cNhnQnGb3gH6i4RTzDpzKGOvXgN9bllWUm5EcBUeZNA==
X-Received: by 2002:a17:902:e887:b0:1c5:cf7c:4d50 with SMTP id w7-20020a170902e88700b001c5cf7c4d50mr3991058plg.18.1698329563188;
        Thu, 26 Oct 2023 07:12:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902ac8700b001caa0ee76b1sm867644plr.211.2023.10.26.07.12.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 07:12:41 -0700 (PDT)
Message-ID: <653a73d9.170a0220.76784.21e4@mx.google.com>
Date: Thu, 26 Oct 2023 07:12:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4-st20-3596-g73e7f2b880d98
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 34 runs,
 62 regressions (v4.4-st20-3596-g73e7f2b880d98)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Oct 2023 14:12:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13465

cip-gitlab/ci/pavel/linux-test baseline-nfs: 34 runs, 62 regressions (v4.4-=
st20-3596-g73e7f2b880d98)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

acer-cp514-3wh-r0qs-guybrush | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 8          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig         | 8          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 15         =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig        | 15         =

dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-14-db0003na-grunt         | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-3596-g73e7f2b880d98/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-3596-g73e7f2b880d98
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      73e7f2b880d98bcbacb997959b6c7b220f7fe382 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e1fd9d28a2d1cefcf49

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/653a6e1fd9d28a2d1=
cefcf4a
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e21d9d28a2d1cefcf4c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/653a6e21d9d28a2d1=
cefcf4d
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-cp514-3wh-r0qs-guybrush | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e06c31ec3ad78efcf04

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-acer-cp514-3wh-r0qs-guybrush.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-acer-cp514-3wh-r0qs-guybrush.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/653a6e06c31ec3ad7=
8efcf05
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6d3d047e46396eefcef4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/653a6d3d047e46396=
eefcef5
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6f7fd3b8f1c7e3efcf2b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/653a6f7fd3b8f1c7e=
3efcf2c
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6db9467cfcda03efcefb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/653a6db9467cfcda0=
3efcefc
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e192f7837aeecefcf34

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/653a6e192f7837aee=
cefcf35
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e2a2f7837aeecefcf4c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/653a6e2a2f7837aee=
cefcf4d
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig         | 8          =


  Details:     https://kernelci.org/test/plan/id/653a6de1467cfcda03efcf2e

  Results:     15 PASS, 21 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-broonie/ba=
seline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-broonie/ba=
seline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/653a6de1467c=
fcda03efcf33
        new failure (last pass: v5.10.194-915-g33f52aa14b957)
        1 lines

    2023-10-26T13:46:07.918662  / # =

    2023-10-26T13:46:07.925092  =

    2023-10-26T13:46:12.943090  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/199986/extract-nfsrootfs-kr_56l6h'
    2023-10-26T13:46:12.953737  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/199986/extract-nfsrootfs-kr_56l6h'
    2023-10-26T13:46:15.248553  / # export NFS_SERVER_IP=3D'192.168.56.193'
    2023-10-26T13:46:15.259199  export NFS_SERVER_IP=3D'192.168.56.193'
    2023-10-26T13:46:15.362283  / # #
    2023-10-26T13:46:15.368828  #
    2023-10-26T13:46:15.470752  / # export SHELL=3D/bin/sh
    2023-10-26T13:46:15.477276  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =


  * baseline-nfs.bootrr.simple-audio-driver-present: https://kernelci.org/t=
est/case/id/653a6de1467cfcda03efcf36
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:46:53.681716  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: 84: assert_device-present: not found
    2023-10-26T13:46:54.711119  /lava-199986/1/../bin/lava-test-case
    2023-10-26T13:46:54.757453  [   81.032852] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/653a6de1467cfcda03efcf43
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:46:34.943524  /lava-199986/1/../bin/lava-test-case
    2023-10-26T13:46:34.984425  [   61.259751] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-10-26T13:46:36.024504  /lava-199986/1/../bin/lava-test-case
    2023-10-26T13:46:36.065755  [   62.340799] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.am335x-phy-driver-present: https://kernelci.org/tes=
t/case/id/653a6de1467cfcda03efcf47
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:46:29.403706  /lava-199986/1/../bin/lava-test-case
    2023-10-26T13:46:29.449826  [   55.724905] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb0-musb-dsps-probed RESULT=3Dblocked>
    2023-10-26T13:46:30.488396  /lava-199986/1/../bin/lava-test-case
    2023-10-26T13:46:30.533324  [   56.808724] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb1-musb-dsps-probed RESULT=3Dblocked>
    2023-10-26T13:46:31.572085  /lava-199986/1/../bin/lava-test-case
    2023-10-26T13:46:31.608312  [   57.883542] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dam335x-phy-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.musb-dsps-driver-present: https://kernelci.org/test=
/case/id/653a6de1467cfcda03efcf48
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:46:26.171869  /lava-199986/1/../bin/lava-test-case
    2023-10-26T13:46:26.209194  [   52.485971] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc0-probed RESULT=3Dblocked>
    2023-10-26T13:46:27.247340  /lava-199986/1/../bin/lava-test-case
    2023-10-26T13:46:27.283397  [   53.559238] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc1-probed RESULT=3Dblocked>
    2023-10-26T13:46:28.321372  /lava-199986/1/../bin/lava-test-case
    2023-10-26T13:46:28.365498  [   54.640859] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmusb-dsps-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sdhci-omap-driver-present: https://kernelci.org/tes=
t/case/id/653a6de1467cfcda03efcf49
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:46:25.086968  /lava-199986/1/../bin/lava-test-case
    2023-10-26T13:46:25.133037  [   51.408107] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tps65217-driver-present: https://kernelci.org/test/=
case/id/653a6de1467cfcda03efcf4f
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:46:20.524571  /lava-199986/1/../bin/lava-test-case
    2023-10-26T13:46:20.571910  [   46.847229] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtps65217-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap8240-driver-present: https://kernelci.org/test/=
case/id/653a6de1467cfcda03efcf53
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:46:18.164990  /lava-199986/1/../bin/lava-test-case
    2023-10-26T13:46:18.200137  [   44.476360] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig         | 8          =


  Details:     https://kernelci.org/test/plan/id/653a70915f879b2196efcf00

  Results:     15 PASS, 21 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-cip/baseli=
ne-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-cip/baseli=
ne-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/653a70915f87=
9b2196efcf05
        new failure (last pass: v5.10.194-915-g33f52aa14b957)
        1 lines

    2023-10-26T13:57:28.535790  / # =

    2023-10-26T13:57:28.544045  =

    2023-10-26T13:57:33.587787  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/1027205/extract-nfsrootfs-ejd7baq1'
    2023-10-26T13:57:33.598274  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/1027205/extract-nfsrootfs-ejd7baq1'
    2023-10-26T13:57:35.633982  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2023-10-26T13:57:35.644476  export NFS_SERVER_IP=3D'172.16.3.3'
    2023-10-26T13:57:35.746747  / # #
    2023-10-26T13:57:35.755022  #
    2023-10-26T13:57:35.855965  / # export SHELL=3D/bin/sh
    2023-10-26T13:57:35.863712  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =


  * baseline-nfs.bootrr.simple-audio-driver-present: https://kernelci.org/t=
est/case/id/653a70915f879b2196efcf08
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:58:26.428197  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: 84: assert_device-present: not found
    2023-10-26T13:58:27.457271  /lava-1027205/1/../bin/lava-test-case
    2023-10-26T13:58:27.576860  [   92.634107] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/653a70915f879b2196efcf15
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:58:00.403268  /lava-1027205/1/../bin/lava-test-case
    2023-10-26T13:58:00.595582  [   65.651887] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-10-26T13:58:01.633847  /lava-1027205/1/../bin/lava-test-case
    2023-10-26T13:58:06.284666  [   71.341396] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.am335x-phy-driver-present: https://kernelci.org/tes=
t/case/id/653a70915f879b2196efcf19
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:57:52.815892  /lava-1027205/1/../bin/lava-test-case
    2023-10-26T13:57:52.943786  [   58.000806] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb0-musb-dsps-probed RESULT=3Dblocked>
    2023-10-26T13:57:53.986799  /lava-1027205/1/../bin/lava-test-case
    2023-10-26T13:57:54.133664  [   59.190804] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb1-musb-dsps-probed RESULT=3Dblocked>
    2023-10-26T13:57:55.174658  /lava-1027205/1/../bin/lava-test-case
    2023-10-26T13:57:56.651587  [   61.707616] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dam335x-phy-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.musb-dsps-driver-present: https://kernelci.org/test=
/case/id/653a70915f879b2196efcf1a
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:57:49.320961  /lava-1027205/1/../bin/lava-test-case
    2023-10-26T13:57:49.466830  [   54.523911] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc0-probed RESULT=3Dblocked>
    2023-10-26T13:57:50.509554  /lava-1027205/1/../bin/lava-test-case
    2023-10-26T13:57:50.624803  [   55.680847] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc1-probed RESULT=3Dblocked>
    2023-10-26T13:57:51.665500  /lava-1027205/1/../bin/lava-test-case
    2023-10-26T13:57:51.773692  [   56.830894] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmusb-dsps-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sdhci-omap-driver-present: https://kernelci.org/tes=
t/case/id/653a70915f879b2196efcf1b
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:57:48.121971  /lava-1027205/1/../bin/lava-test-case
    2023-10-26T13:57:48.282575  [   53.338083] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tps65217-driver-present: https://kernelci.org/test/=
case/id/653a70915f879b2196efcf21
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:57:42.837229  /lava-1027205/1/../bin/lava-test-case
    2023-10-26T13:57:42.967178  [   48.023289] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtps65217-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap8240-driver-present: https://kernelci.org/test/=
case/id/653a70915f879b2196efcf25
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:57:40.058938  /lava-1027205/1/../bin/lava-test-case
    2023-10-26T13:57:40.191081  [   45.247577] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 15         =


  Details:     https://kernelci.org/test/plan/id/653a6cfd07b5b99bc1efcef5

  Results:     24 PASS, 17 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/omap2plus_defconfig/gcc-10/lab-broonie/b=
aseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/omap2plus_defconfig/gcc-10/lab-broonie/b=
aseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/653a6cfd07b5=
b99bc1efcef9
        new failure (last pass: v5.10.194-915-g33f52aa14b957)
        1 lines

    2023-10-26T13:42:15.548352  / # =

    2023-10-26T13:42:15.553304  =

    2023-10-26T13:42:20.574740  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/199947/extract-nfsrootfs-wsvdlkzk'
    2023-10-26T13:42:20.586050  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/199947/extract-nfsrootfs-wsvdlkzk'
    2023-10-26T13:42:22.879626  / # export NFS_SERVER_IP=3D'192.168.56.123'
    2023-10-26T13:42:22.890612  export NFS_SERVER_IP=3D'192.168.56.123'
    2023-10-26T13:42:22.997187  / # #
    2023-10-26T13:42:23.002495  #
    2023-10-26T13:42:23.112009  / # export SHELL=3D/bin/sh
    2023-10-26T13:42:23.117489  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =


  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/653a6=
cfd07b5b99bc1efcefc
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:43:05.738153  /lava-199947/1/../bin/lava-test-case
    2023-10-26T13:43:05.885863  [  102.760721] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-10-26T13:43:07.005651  /lava-199947/1/../bin/lava-test-case
    2023-10-26T13:43:07.302898  [  104.178083] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.simple-audio-driver-present: https://kernelci.org/t=
est/case/id/653a6cfd07b5b99bc1efcefd
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:43:03.384415  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: 84: assert_device-present: not found
    2023-10-26T13:43:04.495969  /lava-199947/1/../bin/lava-test-case
    2023-10-26T13:43:04.630609  [  101.503505] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/653a6cfd07b5b99bc1efcefe
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:43:01.976464  /lava-199947/1/../bin/lava-test-case
    2023-10-26T13:43:02.094549  [   98.968282] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-10-26T13:43:03.230054  /lava-199947/1/../bin/lava-test-case
    2023-10-26T13:43:03.356892  [  100.229951] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/653a6cfd07b5b99bc1efceff
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:42:59.471330  /lava-199947/1/../bin/lava-test-case
    2023-10-26T13:42:59.590220  [   96.463699] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-10-26T13:43:00.722020  /lava-199947/1/../bin/lava-test-case
    2023-10-26T13:43:00.840373  [   97.713836] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/653a6cfd07b5b99bc1efcf00
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:42:56.998030  /lava-199947/1/../bin/lava-test-case
    2023-10-26T13:42:57.130975  [   94.004395] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-10-26T13:42:58.264802  /lava-199947/1/../bin/lava-test-case
    2023-10-26T13:42:58.376979  [   95.250348] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tilcdc-driver-probed: https://kernelci.org/test/cas=
e/id/653a6cfd07b5b99bc1efcf01
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:42:55.723414  /lava-199947/1/../bin/lava-test-case
    2023-10-26T13:42:55.910131  [   92.783324] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtilcdc-driver-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-sham-driver-present: https://kernelci.org/test=
/case/id/653a6cfd07b5b99bc1efcf06
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:42:52.474695  /lava-199947/1/../bin/lava-test-case
    2023-10-26T13:42:52.592951  [   89.465819] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-aes-driver-present: https://kernelci.org/test/=
case/id/653a6cfd07b5b99bc1efcf09
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:42:49.657876  /lava-199947/1/../bin/lava-test-case
    2023-10-26T13:42:49.767690  [   86.641539] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/653a6cfd07b5b99bc1efcf0c
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:42:45.425719  /lava-199947/1/../bin/lava-test-case
    2023-10-26T13:42:45.592383  [   82.465371] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-10-26T13:42:46.905559  /lava-199947/1/../bin/lava-test-case
    2023-10-26T13:42:47.021018  [   83.893768] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/653a6cfd07b5b99bc1efcf0d
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:42:44.263209  /lava-199947/1/../bin/lava-test-case
    2023-10-26T13:42:44.341254  [   81.213387] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sdhci-omap-driver-present: https://kernelci.org/tes=
t/case/id/653a6cfd07b5b99bc1efcf15
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:42:35.431587  /lava-199947/1/../bin/lava-test-case
    2023-10-26T13:42:36.765157  [   73.636694] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dbaseboard-eeprom-probed RESULT=3Dblocked>
    2023-10-26T13:42:37.896653  /lava-199947/1/../bin/lava-test-case
    2023-10-26T13:42:39.695424  [   76.568355] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.at24-driver-present: https://kernelci.org/test/case=
/id/653a6cfd07b5b99bc1efcf16
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:42:34.178317  /lava-199947/1/../bin/lava-test-case
    2023-10-26T13:42:34.303617  [   71.175885] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dat24-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.pwrbutton-driver-present: https://kernelci.org/test=
/case/id/653a6cfd07b5b99bc1efcf19
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:42:31.452238  /lava-199947/1/../bin/lava-test-case
    2023-10-26T13:42:31.579822  [   68.451232] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dpwrbutton-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap8240-driver-present: https://kernelci.org/test/=
case/id/653a6cfd07b5b99bc1efcf1f
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:42:28.154175  /lava-199947/1/../bin/lava-test-case
    2023-10-26T13:42:28.281170  [   65.153299] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig        | 15         =


  Details:     https://kernelci.org/test/plan/id/653a6d634da6d1f731efcf06

  Results:     24 PASS, 17 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/omap2plus_defconfig/gcc-10/lab-cip/basel=
ine-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/omap2plus_defconfig/gcc-10/lab-cip/basel=
ine-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/653a6d634da6=
d1f731efcf0b
        new failure (last pass: v5.10.194-915-g33f52aa14b957)
        1 lines

    2023-10-26T13:44:13.324867  / # =

    2023-10-26T13:44:13.336408  =

    2023-10-26T13:44:18.384864  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/1027193/extract-nfsrootfs-gz7053lu'
    2023-10-26T13:44:18.405111  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/1027193/extract-nfsrootfs-gz7053lu'
    2023-10-26T13:44:20.502679  / # export NFS_SERVER_IP=3D'192.168.1.1'
    2023-10-26T13:44:20.515746  export NFS_SERVER_IP=3D'192.168.1.1'
    2023-10-26T13:44:20.618254  / # #
    2023-10-26T13:44:20.627674  #
    2023-10-26T13:44:20.744469  / # export SHELL=3D/bin/sh
    2023-10-26T13:44:20.755589  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =


  * baseline-nfs.bootrr.hdmi-audio: https://kernelci.org/test/case/id/653a6=
d634da6d1f731efcf0d
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:44:57.302818  /lava-1027193/1/../bin/lava-test-case
    2023-10-26T13:44:57.366816  [   78.873961] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-10-26T13:44:58.438105  /lava-1027193/1/../bin/lava-test-case
    2023-10-26T13:44:58.539982  [   80.044463] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline-nfs.bootrr.simple-audio-driver-present: https://kernelci.org/t=
est/case/id/653a6d634da6d1f731efcf0e
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:44:54.975450  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: 84: assert_device-present: not found
    2023-10-26T13:44:56.078638  /lava-1027193/1/../bin/lava-test-case
    2023-10-26T13:44:56.183617  [   77.687938] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tda19988-driver-present: https://kernelci.org/test/=
case/id/653a6d634da6d1f731efcf0f
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:44:48.728398  /lava-1027193/1/../bin/lava-test-case
    2023-10-26T13:44:48.833335  [   70.337254] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-10-26T13:44:49.920628  /lava-1027193/1/../bin/lava-test-case
    2023-10-26T13:44:50.021656  [   71.524374] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.tilcdc-driver-probed: https://kernelci.org/test/cas=
e/id/653a6d634da6d1f731efcf10
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:44:47.502244  /lava-1027193/1/../bin/lava-test-case
    2023-10-26T13:44:47.609082  [   69.113469] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtilcdc-driver-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-sham-driver-present: https://kernelci.org/test=
/case/id/653a6d634da6d1f731efcf15
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:44:44.595046  /lava-1027193/1/../bin/lava-test-case
    2023-10-26T13:44:44.696248  [   66.200198] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap-aes-driver-present: https://kernelci.org/test/=
case/id/653a6d634da6d1f731efcf18
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:44:41.883987  /lava-1027193/1/../bin/lava-test-case
    2023-10-26T13:44:41.994947  [   63.498276] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/t=
est/case/id/653a6d634da6d1f731efcf1b
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:44:38.045451  /lava-1027193/1/../bin/lava-test-case
    2023-10-26T13:44:38.166388  [   59.669635] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-10-26T13:44:39.285579  /lava-1027193/1/../bin/lava-test-case
    2023-10-26T13:44:39.348620  [   60.852054] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cpsw-switch-driver-present: https://kernelci.org/te=
st/case/id/653a6d634da6d1f731efcf1c
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:44:36.823215  /lava-1027193/1/../bin/lava-test-case
    2023-10-26T13:44:36.926190  [   58.429655] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.sdhci-omap-driver-present: https://kernelci.org/tes=
t/case/id/653a6d634da6d1f731efcf24
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:44:31.137881  /lava-1027193/1/../bin/lava-test-case
    2023-10-26T13:44:31.242815  [   52.745485] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dbaseboard-eeprom-probed RESULT=3Dblocked>
    2023-10-26T13:44:32.362099  /lava-1027193/1/../bin/lava-test-case
    2023-10-26T13:44:32.467015  [   53.970158] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.at24-driver-present: https://kernelci.org/test/case=
/id/653a6d634da6d1f731efcf25
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:44:29.909598  /lava-1027193/1/../bin/lava-test-case
    2023-10-26T13:44:30.018626  [   51.521990] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dat24-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.pwrbutton-driver-present: https://kernelci.org/test=
/case/id/653a6d634da6d1f731efcf28
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:44:27.325373  /lava-1027193/1/../bin/lava-test-case
    2023-10-26T13:44:27.399278  [   48.902388] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dpwrbutton-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.omap8240-driver-present: https://kernelci.org/test/=
case/id/653a6d634da6d1f731efcf2e
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:44:24.323334  /lava-1027193/1/../bin/lava-test-case
    2023-10-26T13:44:24.440190  [   45.942289] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.hdmi-codec-driver-present: https://kernelci.org/tes=
t/case/id/653a6d634da6d1f731efcf32
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:44:53.616275  /lava-1027193/1/../bin/lava-test-case
    2023-10-26T13:44:53.726283  [   75.230302] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-10-26T13:44:54.845443  /lava-1027193/1/../bin/lava-test-case
    2023-10-26T13:44:54.950422  [   76.454898] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case=
/id/653a6d634da6d1f731efcf33
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:44:51.156914  /lava-1027193/1/../bin/lava-test-case
    2023-10-26T13:44:51.258957  [   72.762822] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-10-26T13:44:52.378157  /lava-1027193/1/../bin/lava-test-case
    2023-10-26T13:44:52.481032  [   73.985451] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e2b8e6852739cefcf03

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-dell-latitude-5400-4305U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-dell-latitude-5400-4305U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/653a6e2b8e6852739=
cefcf04
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e18ec94d7af6befcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-dell-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-dell-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/653a6e18ec94d7af6=
befcef4
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6db5047e46396eefcf18

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/653a6db5047e46396=
eefcf19
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-14-db0003na-grunt         | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6d626fbf1499e5efcf01

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-hp-14-db0003na-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-hp-14-db0003na-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/653a6d626fbf1499e=
5efcf02
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e3f5cce3b6c0fefcef8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/653a6e3f5cce3b6c0=
fefcef9
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e64bc7956decfefcf00

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/653a6e64bc7956dec=
fefcf01
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e0bd9d28a2d1cefcf0d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/653a6e0bd9d28a2d1=
cefcf0e
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6d636b3ca0b672efcef8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/653a6d636b3ca0b67=
2efcef9
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818A6C6FA82
	for <webhook@archiver.kernel.org>; Sat, 17 Sep 2022 16:45:45 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web08.418.1663433136580744576
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 17 Sep 2022 09:45:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=CQvSoVza;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id k21so13690753pls.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 17 Sep 2022 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=8zVbOSJSzKLDrlJtNVw4Hujs9X3Ml6OhPkvElwf1j/0=;
        b=CQvSoVzawxR7gFgGSvNZd9tzktfvSKQ9EJzTWNswxcceGKnjQNRkSD1nHjRLFexllf
         MyMvux9P5D05eprDWyduXO0jXcjyXDogl7/5cQfKbIP7qri+NfjENtR/O0/Ntdpah/rM
         EpqCR+7/ZMe2J73hs7nNZ6Exaw8g78r1RmgIu85Q9s2wgXz9R9Jqf42ajIGP7CGYfjzD
         wqHsEs4Q9gkzvxJEVqLIY2H9Ha4R+P5fIWAqHA07lss6apd9dSD1nQb/Uxik/O37vu1c
         ZFJoFEQAuU4z1F1LgoJgMpuzEovUJZMNzK56s4pPWGZgdMbl7LKbk1lKTnVW/Ce1nYZD
         jAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=8zVbOSJSzKLDrlJtNVw4Hujs9X3Ml6OhPkvElwf1j/0=;
        b=pjnO2EZE0p8lBzHGYnGRGj372OB46F0XUSLdIKllHvZhmEauDlF/u21az0AEya0KAg
         lOEglcRt9ao57Kuy+hIiuxgA2MmjfY+iQ46/859gf+YYJRXpqJlFgYEiwNBKOwhbBEaf
         DQ+K3F1EXhDEKnZNr52n4Df2JHQUmT3X4uuQsDECzywd7i4YO8EA2SVhDRGOxbXxWQLi
         AQSe1V4wCQX7Gu4Ziji+JQg4BJOlbwQtL4O7KXyFXygR65DLyHLhXzqFOdS4iYmfxAPu
         /CtwfatGqT/oduAzeB6YJncd5frHq88cCsbsvFEAnnH2NMcYfvT4etUhOg4I2/jiFEk/
         /57w==
X-Gm-Message-State: ACrzQf1/NokziOd+Yone78e3t7YtyAGXCMMYKPtDEs2ZAOpQyAm+uKQI
	opxPbF8ExQOIZtHjy8sBEJ3dsld1sb1H2K9w74Y=
X-Google-Smtp-Source: 
 AMsMyM6jPB6NLWo+YaUHZiMLrPykbNGp4ww/djY1imxigmBNIgyfje6DCnRDVJVPaS8Y3c3WXgvd5g==
X-Received: by 2002:a17:903:2309:b0:176:be6c:d4df with SMTP id
 d9-20020a170903230900b00176be6cd4dfmr5260584plh.4.1663433135851;
        Sat, 17 Sep 2022 09:45:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 c16-20020a170903235000b00176dac464e5sm17371724plh.173.2022.09.17.09.45.34
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 09:45:35 -0700 (PDT)
Message-ID: <6325f9af.170a0220.3d550.f274@mx.google.com>
Date: Sat, 17 Sep 2022 09:45:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-229-gb433f12afe250
Subject: cip-gitlab/ci/pavel/linux-test smc: 9 runs,
 9 regressions (v4.4-st20-229-gb433f12afe250)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 17 Sep 2022 16:45:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9509

cip-gitlab/ci/pavel/linux-test smc: 9 runs, 9 regressions (v4.4-st20-229-gb=
433f12afe250)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_arm-virt-gicv3          | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv3          | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_x86_64                  | x86_64 | lab-broonie   | gcc-10   | x86_64_d=
efconfig             | 1          =

qemu_x86_64                  | x86_64 | lab-broonie   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig             | 2          =

qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-229-gb433f12afe250/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-229-gb433f12afe250
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b433f12afe2506afd30066f5b2b826129a20bc03 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ef43f9317112b4355681

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/6325ef43f9317112b4355682
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6325eec73673365732355643

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-broonie/smc=
-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-broonie/smc=
-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/6325eec73673365732355644
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6325edffe1e311c638355645

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-collabora/s=
mc-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-collabora/s=
mc-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/6325edffe1e311c638355646
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64                  | x86_64 | lab-broonie   | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/6325eb6b17156e799c355653

  Results:     15 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig/gcc-10/lab-broonie/sm=
c-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig/gcc-10/lab-broonie/sm=
c-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * smc.CVE-2017-5715: https://kernelci.org/test/case/id/6325eb6b17156e799c=
35565f
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:44:31.925546  [   11.277580] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3DCVE-2017-5715 RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64                  | x86_64 | lab-broonie   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ebbbcce9d9cb86355684

  Results:     15 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-broonie/smc-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-broonie/smc-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * smc.CVE-2017-5715: https://kernelci.org/test/case/id/6325ebbbcce9d9cb86=
355693
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:45:50.568639  [   11.582315] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3DCVE-2017-5715 RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig             | 2          =


  Details:     https://kernelci.org/test/plan/id/6325eb3190919ab878355650

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig/gcc-10/lab-collabora/=
smc-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig/gcc-10/lab-collabora/=
smc-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * smc.CVE-2020-0543: https://kernelci.org/test/case/id/6325eb3190919ab878=
355652
        failing since 31 days (last pass: v5.10.131-cip13-49-g1145e9c6352e6=
, first fail: v5.10.131-cip13-84-g5fcbe4a63ab4d)

    2022-09-17T15:43:32.856671  [    1.977797] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3DCVE-2018-12207 RESULT=3Dpass>   =


  * smc.CVE-2017-5715: https://kernelci.org/test/case/id/6325eb3190919ab878=
35565f
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:43:32.804505  [    1.925977] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3DCVE-2017-5715 RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6325eb43096e55e81e355648

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/smc-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/smc-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * smc.CVE-2020-0543: https://kernelci.org/test/case/id/6325eb43096e55e81e=
35564a
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:43:51.122464  [    2.108399] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3DCVE-2018-12207 RESULT=3Dpass>
    2022-09-17T15:43:51.126176  [    2.112475] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3DCVE-2020-0543 RESULT=3Dfail>   =


  * smc.CVE-2017-5715: https://kernelci.org/test/case/id/6325eb43096e55e81e=
355657
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e)

    2022-09-17T15:43:51.073112  [    2.059436] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3DCVE-2017-5715 RESULT=3Dfail>   =

 =20


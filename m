Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17283C19F2A
	for <webhook@archiver.kernel.org>; Thu,  4 Aug 2022 05:30:53 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web12.1544.1659591046884571043
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 22:30:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=Vo9ze+ft;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id p18so1064111plr.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 22:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=d5YAo5HAGoiX0kYKddyFNRPJ3xMmln3lOmiA4IimyaE=;
        b=Vo9ze+ftttMSvfiyFjw3yhzXPnJQU885IMjwHG/UdyjmDRZNMl51gEgOEn0dbpI3Mp
         LlD787PJlon/FHzv/HbpWalIoUh9kQuVpG8LJPfoV9AR90H44YU5u8larJxcBCdFqMaQ
         iECaY4OmX9NzEmCXPL7zgmxdWovER2b7ONPFqhEYdvWMwSUlJfogXMEJW5G4XaAjfoQt
         FZUCSGvvAK2ziaWJEAmVW4nhU1AdC3zDzdtgm6HJbqXxaEer4MkqEkCv3Y3YYdzDz33m
         +/1rGBYvVTexmzCpKRRrVKbvAACFAOZCUn4vDALAgSrJWFN4FibknNa8xvAbkTkxE07a
         Bf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=d5YAo5HAGoiX0kYKddyFNRPJ3xMmln3lOmiA4IimyaE=;
        b=ZF1VOh16SB//wbtFqHegca4EFzirTQVp057ph/0iawkohEx85fSGTFlEP4C2nb1Is/
         5Q3mN4lf6dmF5HLWr0JeTavP1g04E62bNRzGVEkmLZ4AjihQ1t6mYJx9gPtO4KCtsMxy
         jdJTuty3vBHCTQ/tVHFOQoARlWSU1vASFqFF7D7BMTgFA7Cf2cvVuxHz8HSR04QC0dXr
         MJ04A3kFsfuU/DR4FrybIl4AXrOj4iZ0+E7XRZWUfs9Sd70kc56SrWj7vvdHv9PSE3rl
         bwn6s6tHzuDxL0nj/zNmPfBft+8jOJCYPBi1E9USpe1BTOnBtXuTI6Ha8knNXc1B7kFp
         osow==
X-Gm-Message-State: ACgBeo0IX3zJIsQME+qcRtKqSZ0Y/eoJ9/JJfSdgi7IBWwcV/xclfoM+
	6ephIfIfWyzgfIE+XojOi28BNKMpg4crNXpFVBI=
X-Google-Smtp-Source: 
 AA6agR7thVJhrYbf5phVgrQU9w8v+rRyrctkwMiatxNxpXeS87Ut/LhGs9lHy3iOkchHAs4w45krPQ==
X-Received: by 2002:a17:902:ec8f:b0:16e:d8d8:c2ef with SMTP id
 x15-20020a170902ec8f00b0016ed8d8c2efmr299234plg.62.1659591046009;
        Wed, 03 Aug 2022 22:30:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 j68-20020a625547000000b0052c74a68eccsm13913125pfb.165.2022.08.03.22.30.45
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 22:30:45 -0700 (PDT)
Message-ID: <62eb5985.620a0220.bb095.68ac@mx.google.com>
Date: Wed, 03 Aug 2022 22:30:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-37-ge3a52725ce96e
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 7 runs,
 4 regressions (v5.10.131-cip13-37-ge3a52725ce96e)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Aug 2022 05:30:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9113

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 7 runs, 4 regressions (v5.1=
0.131-cip13-37-ge3a52725ce96e)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.131-cip13-37-ge3a52725ce96e/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.131-cip13-37-ge3a52725ce96e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e3a52725ce96e4794cc31e31ccd20914f40f19a3 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/62eb48d962785de96adaf082

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-37-ge3a52725ce96e/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-37-ge3a52725ce96e/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/62eb48d962785de96a=
daf08e
        failing since 30 days (last pass: v5.10.121-cip9-287-ge9094c8446fc,=
 first fail: v5.10.125-cip10-119-g603acbe1aceb)

    2022-08-04T04:19:22.804137  <8>[   10.280529] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/62eb48d962785de96a=
daf08f
        failing since 30 days (last pass: v5.10.121-cip9-287-ge9094c8446fc,=
 first fail: v5.10.125-cip10-119-g603acbe1aceb)

    2022-08-04T04:19:22.785602  <8>[   10.262233] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/62eb4bc17678a6d10adaf06c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-37-ge3a52725ce96e/arm64/defconfig/gcc-10/lab-b=
roonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-37-ge3a52725ce96e/arm64/defconfig/gcc-10/lab-b=
roonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62eb4bc17678a6d10adaf06d
        failing since 86 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/62eb51ce8d5f2a0685daf05a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-37-ge3a52725ce96e/arm64/defconfig/gcc-10/lab-c=
ollabora/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-37-ge3a52725ce96e/arm64/defconfig/gcc-10/lab-c=
ollabora/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62eb51ce8d5f2a0685daf05b
        failing since 86 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =20


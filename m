Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721E5C19F28
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 16:25:01 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web09.214.1659543898940936122
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 09:24:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=YCGYxgv+;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id w10so16887507plq.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 09:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=TY4jT7PKEFXQT5+Aus8XfcdYdEKgRmluV+qgvEW1qkA=;
        b=YCGYxgv+WHYvI4rrjjOK5IjmBBs9iiopIBfZk0Ukqs2uWH7deLv+mDcJ95s2aCi9D0
         KWfJ4rXZnAGntoO6/wini/T0zHsondERSxk3qGwnBgoa08M6p6ixYMcADdX0Ha5oxGol
         i/t+2H49RHqyT/4qOaNCDYBKgaF4ZL8Kzf8LbKE+jkd8dkBzeneT7BIqz3s2BX8b3S0Y
         JN6OBszUGh+2ohKVrluI4bVopvIHmZnjTM4GDqht80RfxfHhLJBDuPtQntzu20MPk7E/
         1ALfqre7Kwcd5TtALZxMxSz+GVAfJkbdF0eRquAx6KN/5ojUkPNwZIYMmCJgWmH+fMzI
         omYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=TY4jT7PKEFXQT5+Aus8XfcdYdEKgRmluV+qgvEW1qkA=;
        b=4E5tkWtqyjYgqmUFmJzRBYXT7CqBTAFhQuYzye4XX7zbBp5tZ6byBhFO/qF9ESmqJd
         ItOtDSI3eGrfP05TKQim8piC8EX9I29xCcU18HMjj8xJfGWr+AwcKSVG4ejBbT5qmlgc
         Ejiarqkk3L/FHTo9Fw/Rp8AzigTwfkj0vxXY7c6JK/ecWx2iEatZ0f+U+gqVD4y31kNV
         mUzoDar9bbPUV07kX8/WJOWCs2SZ7mXVUynsgmmhTKRUY8KfXHi67aJwSe15wZXBrXaX
         Yc+n/Bx2RtftwtwTynRIoGrbdn5RbtyK3LDzGaiQC4jCZP8my/qYZCoCCWi9pZlw2s3P
         Ls4g==
X-Gm-Message-State: ACgBeo3KeffEgI9DVkCoOodnsMCKYUC4eZTthX9luOcKJt3/OpJY9Fiu
	ikBXx43W+laBzS1+yeCJMS1jqy3Abp7Vgdgskng=
X-Google-Smtp-Source: 
 AA6agR5jm6vTpyJI+nAl7crIxht6BDM+6+ObSafVOB2bEic2/GhDGeSKSSIuxI3qawHfMQkTBMOzQw==
X-Received: by 2002:a17:90b:2687:b0:1f3:1535:eda5 with SMTP id
 pl7-20020a17090b268700b001f31535eda5mr5763314pjb.39.1659543898149;
        Wed, 03 Aug 2022 09:24:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 t2-20020a625f02000000b0052ab764fa78sm13116415pfb.185.2022.08.03.09.24.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 09:24:57 -0700 (PDT)
Message-ID: <62eaa159.620a0220.6f4f.4b48@mx.google.com>
Date: Wed, 03 Aug 2022 09:24:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-431-g420b8f43ddc46
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 10 runs,
 5 regressions (v5.10.131-cip13-431-g420b8f43ddc46)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 16:25:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9069

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 10 runs, 5 regressions (v5.=
10.131-cip13-431-g420b8f43ddc46)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.131-cip13-431-g420b8f43ddc46/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.131-cip13-431-g420b8f43ddc46
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      420b8f43ddc46ea18870caf6aa2052c5602729a5 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/62ea8cc3ec72aaa7f9daf072

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-431-g420b8f43ddc46/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-431-g420b8f43ddc46/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/62ea8cc3ec72aaa7f9=
daf07e
        failing since 29 days (last pass: v5.10.121-cip9-287-ge9094c8446fc,=
 first fail: v5.10.125-cip10-119-g603acbe1aceb)

    2022-08-03T14:57:02.236919  <8>[   12.290281] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/62ea8cc3ec72aaa7f9=
daf07f
        failing since 29 days (last pass: v5.10.121-cip9-287-ge9094c8446fc,=
 first fail: v5.10.125-cip10-119-g603acbe1aceb)

    2022-08-03T14:57:02.218305  <8>[   12.272108] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea8e802fc90561bbdaf056

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-431-g420b8f43ddc46/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-431-g420b8f43ddc46/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62ea8e802fc90561bbdaf057
        failing since 82 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-289-g2969e096d186) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea8fe9b3f708f4f1daf064

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-431-g420b8f43ddc46/arm64/defconfig/gcc-10/lab-=
broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-431-g420b8f43ddc46/arm64/defconfig/gcc-10/lab-=
broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62ea8fe9b3f708f4f1daf065
        failing since 85 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea91c4cbf7242795daf088

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-431-g420b8f43ddc46/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/smc-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-431-g420b8f43ddc46/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/smc-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62ea91c4cbf7242795daf089
        new failure (last pass: v5.10.129-cip12-12-ge4e007863cc76) =

 =20


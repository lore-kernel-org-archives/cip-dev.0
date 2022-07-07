Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E1AC43334
	for <webhook@archiver.kernel.org>; Thu,  7 Jul 2022 07:07:52 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.2777.1657177663923458507
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Jul 2022 00:07:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=0ya7bVQv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id x184so4208416pfx.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Jul 2022 00:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=SUIyy2Pv3H3GEA/VfctZ/4c9x0nK7yLvPdI8wMlidnA=;
        b=0ya7bVQv6KRtlfhxmSrpft5QfnXWZHKNwpCDbIcL5krFF0M2iz0QZBJNaYYI36ZcUG
         UzrNfLg0kta/qb+cYaXv+DpSWU/NzVn2/ozGIZ74JmjnfCmTYsVpTKYJVFkrDfX7BeAS
         fwYq3nUyNk3Rvavsgewp/+sOQlj4P1LlkeYithkT1Imw7rPG/PU/NDhZeraP0/Ov62jG
         UuJt9AMPZ7HeCbAjzhuZU0q4l/Lsw4v3u3+JYIhfmQ/Q+ux3X/b18VFnHbJZsYoi4XAi
         EYQOW9FWdp+N6v4CHeJcqMaVQxZ8EZ/5FUzWd9/H6Lo/O29FiF2S1OVn6TDzGCk8Anbw
         90HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=SUIyy2Pv3H3GEA/VfctZ/4c9x0nK7yLvPdI8wMlidnA=;
        b=stAPJkPiH15c3RbsAHJ5zGBJBKhmXGN+uqqtLLZY8cC+K1StsuHUh++pmpq3qtd244
         Z85np7GYkYjbL/q8gF9kmcRggYe2ggCAuOXbLTD9x7QUUs4lni1CrbU3Iiq6ds1w1c7j
         Y55mLVXYzfT40ik4rgsut6xArHeDDg8f5Dbrq7m6mSV6m32X1BRpwmAuDhL/McfFTALM
         xko6EfzDoQL3hwQaNGPHV0eC4CiUT3DHL+MrM8q9iyQ+ynLAevkuT7jBt06pq08DHaGH
         Q47lre5SKs6lgIimRS1nU7DJcOdfoo2c8GmLTHU+8ISuNO3xHTY2YGepd0WE+CoGpZuF
         eECQ==
X-Gm-Message-State: AJIora8W0pZHsWU3FSfwtU6PudHeJkquHzYCgxDt/lIhKYsCO9sQNcln
	1Re3yyW1sGBEeeeqaPjn8DaspX6m2SLhCs9O
X-Google-Smtp-Source: 
 AGRyM1tA369x+mqPMkfvg9GR12SGuOq5Pb94XmvAK3yvJfL8Z4jCSAGc1S2nYzoabN6/y7ag3yZaDQ==
X-Received: by 2002:a63:2a8f:0:b0:412:5278:b90 with SMTP id
 q137-20020a632a8f000000b0041252780b90mr15696169pgq.363.1657177663186;
        Thu, 07 Jul 2022 00:07:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 84-20020a621757000000b00524e8e48156sm26905654pfx.142.2022.07.07.00.07.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 00:07:42 -0700 (PDT)
Message-ID: <62c6863e.1c69fb81.7e9ad.6d75@mx.google.com>
Date: Thu, 07 Jul 2022 00:07:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.126-cip11-116-gef362fbbff528
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 10 runs,
 4 regressions (v5.10.126-cip11-116-gef362fbbff528)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Jul 2022 07:07:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8713

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 10 runs, 4 regressions (v5.=
10.126-cip11-116-gef362fbbff528)

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

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.126-cip11-116-gef362fbbff528/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.126-cip11-116-gef362fbbff528
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ef362fbbff528b6dc0695b488cfc8cde20b404e4 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/62c676b82970b4186aa39c08

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/62c676b82970b4186a=
a39c14
        failing since 2 days (last pass: v5.10.121-cip9-287-ge9094c8446fc, =
first fail: v5.10.125-cip10-119-g603acbe1aceb)

    2022-07-07T06:01:04.964721  <8>[   10.204828] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/62c676b82970b4186a=
a39c15
        failing since 2 days (last pass: v5.10.121-cip9-287-ge9094c8446fc, =
first fail: v5.10.125-cip10-119-g603acbe1aceb)

    2022-07-07T06:01:04.946634  <8>[   10.186780] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/62c6787672b1398e74a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/arm64/defconfig/gcc-10/lab-=
broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/arm64/defconfig/gcc-10/lab-=
broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62c6787672b1398e74a39bce
        failing since 58 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62c678b26472939f5ca39bd2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62c678b26472939f5ca39bd3
        failing since 55 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-289-g2969e096d186) =

 =20


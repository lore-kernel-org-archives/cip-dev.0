Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59A3C04A6A
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 15:07:19 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.163071.1692198434806135493
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Aug 2023 08:07:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=V8C49fNK;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1bdaeb0f29aso37383075ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Aug 2023 08:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692198434; x=1692803234;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z/hywwQc+Nv87OnCnQQM9OEutFrUEm+IFuoaL/gjV10=;
        b=V8C49fNK1oTWh3oxqmbr3Y4VZ9zuxVuZRCIq19+XTqqSoMGDV4wrqdF/jt2W+0pID1
         h3M1959zLvlc6SyHnOE1PxFn3YBVWu4vKa5MfGl4rQaVkVLNk+rTWg2gHyws/aBW8g0e
         FRYw2+CK8ZbzHlihDMFtLRDVpn6+ckXE8Skgnkn7OLu+zybwoxdTq3tw3l/4GpEu5Ipl
         gFGXmm8PlUHImop7uHOJjr/4n+vffAldeZ1EnaZYiQ4SMp1mwlHBsoD6DEKRXCOEzTkV
         yI14YGFlxhMEw37RXbIMLeCTtMgWmXc22uLLFphw2hO5bGjOAgza+a+ghuyCBteoVT3g
         /d3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692198434; x=1692803234;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/hywwQc+Nv87OnCnQQM9OEutFrUEm+IFuoaL/gjV10=;
        b=hrW8lKwLow9pgssH768GG8W8/fNpLFBn4+eFCkoRazky8/9Qr0yCFnhgv+WRTHSmVM
         fogvvRa1FnRsg/mXpCbH+flIr26EpEsdGOq5txC85CoUbeURHkmNlS1tu63x0wckRBsU
         bPx3Ur8LNLhuOPSn9IGBx8n82od+duz3X6IqP/vCI+K1qxmX0ZucwS0mRJaAKGPh7SwY
         VHgmjp03rb0DEKx5+Iv7RzCsrcGTyvONyKArWcMofNzMjevcSgKc0ccTt6xUxsRQhRgX
         x9jdwNsMdQihWHSHi76R5cV6A3bXZSnTyx+k/hCiFokk+YTknduHZKnW1QlUN9OZ1i2A
         Ewew==
X-Gm-Message-State: AOJu0YwIXW3YXBAijqERxFuDX4eeu19oN+XGSY7NBL2xLOwbN2qnjYin
	F96/kOsN8hYSYEF8ZbrjAwo2Nm6tsFT72S8PaGwkew==
X-Google-Smtp-Source: AGHT+IHCyMnAX6sGlSq1J+9VGT15lmCmuzfYrZa+Ii2uW4KcyckrUEVICjm687bMKWoCkHwRvuozPw==
X-Received: by 2002:a17:902:ce92:b0:1bb:6875:5a73 with SMTP id f18-20020a170902ce9200b001bb68755a73mr2282380plg.2.1692198432390;
        Wed, 16 Aug 2023 08:07:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902e88400b001b890b3bbb1sm13274717plg.211.2023.08.16.08.07.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 08:07:11 -0700 (PDT)
Message-ID: <64dce61f.170a0220.3233.911f@mx.google.com>
Date: Wed, 16 Aug 2023 08:07:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-3262-g667bb8d8b2cb
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 65 runs,
 108 regressions (v4.4-st20-3262-g667bb8d8b2cb)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 15:07:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12734

cip-gitlab/ci/pavel/linux-test baseline: 65 runs, 108 regressions (v4.4-st2=
0-3262-g667bb8d8b2cb)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

acer-cp514-3wh-r0qs-guybrush | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 13         =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 13         =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 15         =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 15         =

dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | multi_v7=
_defconfig           | 1          =

odroid-xu3                   | arm    | lab-collabora | gcc-10   | exynos_d=
efconfig             | 1          =

qemu_arm-virt-gicv2          | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv2          | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv2-uefi     | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv2-uefi     | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv3          | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv3          | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv3-uefi     | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_arm-virt-gicv3-uefi     | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

qemu_mips-malta              | mips   | lab-broonie   | gcc-10   | malta_de=
fconfig              | 1          =

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie   | gcc-10   | x86_64_d=
efconfig             | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig             | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

rk3288-rock2-square          | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 2          =

rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 22         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-3262-g667bb8d8b2cb/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-3262-g667bb8d8b2cb
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      667bb8d8b2cb1a46bab0ddda1cf60f6e73eff4c6 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce072ef9eb524c635b1ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dce072ef9eb524c635b=
1ed
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce05def9eb524c635b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dce05def9eb524c635b=
1da
        failing since 28 days (last pass: v6.1.38-cip1-10-g02aa22be941dd, f=
irst fail: v5.10.186-cip37-2-gfcd111609480) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce05def9eb524c635b1dc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dce05def9eb524c635b=
1dd
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cp514-3wh-r0qs-guybrush | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce05f171f775a2e35b215

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-acer-cp514-3wh-r0qs-guybrush.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-acer-cp514-3wh-r0qs-guybrush.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dce05f171f775a2e35b=
216
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce14f293cd5288635b270

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dce14f293cd5288635b=
271
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce04f171f775a2e35b1ff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dce04f171f775a2e35b=
200
        new failure (last pass: v4.19.288-cip101-1117-g1f3468542aa9e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce05d171f775a2e35b20b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dce05d171f775a2e35b=
20c
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 13         =


  Details:     https://kernelci.org/test/plan/id/64dcdfd3d881b84b7c35b1d9

  Results:     15 PASS, 21 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64dcdfd3d=
881b84b7c35b1dc
        failing since 27 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T14:40:12.759863  /lava-57234/1/../bin/lava-test-case
    2023-08-16T14:40:12.776453  [   52.810715] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-08-16T14:40:13.800499  /lava-57234/1/../bin/lava-test-case
    2023-08-16T14:40:13.816692  [   53.850917] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.simple-audio-driver-present: https://kernelci.org/test/=
case/id/64dcdfd3d881b84b7c35b1dd
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:40:10.703339  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found
    2023-08-16T14:40:11.717124  /lava-57234/1/../bin/lava-test-case
    2023-08-16T14:40:11.735952  [   51.768743] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/64dcdfd3d881b84b7c35b1de
        failing since 27 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T14:40:09.633787  /lava-57234/1/../bin/lava-test-case
    2023-08-16T14:40:09.651646  [   49.685126] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-08-16T14:40:10.675541  /lava-57234/1/../bin/lava-test-case
    2023-08-16T14:40:10.695620  [   50.726249] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
64dcdfd3d881b84b7c35b1df
        failing since 27 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T14:40:07.552938  /lava-57234/1/../bin/lava-test-case
    2023-08-16T14:40:07.569244  [   47.603156] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-08-16T14:40:08.593219  /lava-57234/1/../bin/lava-test-case
    2023-08-16T14:40:08.609533  [   48.643931] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/64dcdfd3d881b84b7c35b1e0
        failing since 27 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T14:40:05.470726  /lava-57234/1/../bin/lava-test-case
    2023-08-16T14:40:05.487489  [   45.521057] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-08-16T14:40:06.511250  /lava-57234/1/../bin/lava-test-case
    2023-08-16T14:40:06.528969  [   46.561772] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/64dcdfd3d881b84b7c35b1ea
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:39:52.820490  /lava-57234/1/../bin/lava-test-case
    2023-08-16T14:39:52.836895  [   32.870207] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-08-16T14:39:53.860397  /lava-57234/1/../bin/lava-test-case
    2023-08-16T14:39:53.879597  [   33.911306] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/64dcdfd3d881b84b7c35b1eb
        failing since 27 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T14:39:51.778288  /lava-57234/1/../bin/lava-test-case
    2023-08-16T14:39:51.796108  [   31.828171] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.am335x-phy-driver-present: https://kernelci.org/test/ca=
se/id/64dcdfd3d881b84b7c35b1ee
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:39:47.534076  /lava-57234/1/../bin/lava-test-case
    2023-08-16T14:39:47.551733  [   27.583736] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb0-musb-dsps-probed RESULT=3Dblocked>
    2023-08-16T14:39:48.575104  /lava-57234/1/../bin/lava-test-case
    2023-08-16T14:39:48.593346  [   28.625576] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb1-musb-dsps-probed RESULT=3Dblocked>
    2023-08-16T14:39:49.617408  /lava-57234/1/../bin/lava-test-case
    2023-08-16T14:39:49.635225  [   29.667317] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dam335x-phy-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.musb-dsps-driver-present: https://kernelci.org/test/cas=
e/id/64dcdfd3d881b84b7c35b1ef
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:39:44.411457  /lava-57234/1/../bin/lava-test-case
    2023-08-16T14:39:44.427139  [   24.461032] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc0-probed RESULT=3Dblocked>
    2023-08-16T14:39:45.451913  /lava-57234/1/../bin/lava-test-case
    2023-08-16T14:39:45.468665  [   25.501723] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc1-probed RESULT=3Dblocked>
    2023-08-16T14:39:46.492932  /lava-57234/1/../bin/lava-test-case
    2023-08-16T14:39:46.510585  [   26.542493] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmusb-dsps-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sdhci-omap-driver-present: https://kernelci.org/test/ca=
se/id/64dcdfd3d881b84b7c35b1f0
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:39:43.368923  /lava-57234/1/../bin/lava-test-case
    2023-08-16T14:39:43.387425  [   23.419208] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tps65217-driver-present: https://kernelci.org/test/case=
/id/64dcdfd3d881b84b7c35b1f6
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:39:39.068915  /lava-57234/1/../bin/lava-test-case
    2023-08-16T14:39:39.086728  [   19.118563] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtps65217-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/64dcdfd3d881b84b7c35b1fa
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:39:36.865140  /lava-57234/1/../bin/lava-test-case
    2023-08-16T14:39:36.882067  [   16.914853] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/64dcdfd3d881b84b=
7c35b201
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)
        1 lines

    2023-08-16T14:39:34.520688  / # =

    2023-08-16T14:39:34.526632  =

    2023-08-16T14:39:34.632443  / # #
    2023-08-16T14:39:34.637976  #
    2023-08-16T14:39:34.740612  / # export SHELL=3D/bin/sh
    2023-08-16T14:39:34.745823  export SHELL=3D/bin/sh
    2023-08-16T14:39:34.847933  / # . /lava-57234/environment
    2023-08-16T14:39:34.853894  . /lava-57234/environment
    2023-08-16T14:39:34.956031  / # /lava-57234/bin/lava-test-runner /lava-=
57234/0
    2023-08-16T14:39:34.960737  /lava-57234/bin/lava-test-runner /lava-5723=
4/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 13         =


  Details:     https://kernelci.org/test/plan/id/64dce1886f8343a70e35b1d9

  Results:     15 PASS, 21 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-cip/baselin=
e-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-cip/baselin=
e-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/64dce1886f8343a70e35b1df
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:46:43.246416  /lava-997934/1/../bin/lava-test-case
    2023-08-16T14:46:43.246969  [   11.001165] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tps65217-driver-present: https://kernelci.org/test/case=
/id/64dce1886f8343a70e35b1e3
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:46:45.445061  /lava-997934/1/../bin/lava-test-case
    2023-08-16T14:46:45.445687  [   13.203810] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtps65217-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sdhci-omap-driver-present: https://kernelci.org/test/ca=
se/id/64dce1886f8343a70e35b1e9
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:46:49.748996  /lava-997934/1/../bin/lava-test-case
    2023-08-16T14:46:49.749597  [   17.503930] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.musb-dsps-driver-present: https://kernelci.org/test/cas=
e/id/64dce1886f8343a70e35b1ea
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:46:50.785903  /lava-997934/1/../bin/lava-test-case
    2023-08-16T14:46:50.786467  [   18.545632] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc0-probed RESULT=3Dblocked>
    2023-08-16T14:46:51.808632  /lava-997934/1/../bin/lava-test-case
    2023-08-16T14:46:51.829234  [   19.586173] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc1-probed RESULT=3Dblocked>
    2023-08-16T14:46:52.867357  /lava-997934/1/../bin/lava-test-case
    2023-08-16T14:46:52.867928  [   20.626776] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmusb-dsps-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.am335x-phy-driver-present: https://kernelci.org/test/ca=
se/id/64dce1886f8343a70e35b1eb
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:46:53.889788  /lava-997934/1/../bin/lava-test-case
    2023-08-16T14:46:53.911160  [   21.668137] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb0-musb-dsps-probed RESULT=3Dblocked>
    2023-08-16T14:46:54.954912  /lava-997934/1/../bin/lava-test-case
    2023-08-16T14:46:54.955489  [   22.709745] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb1-musb-dsps-probed RESULT=3Dblocked>
    2023-08-16T14:46:55.992532  /lava-997934/1/../bin/lava-test-case
    2023-08-16T14:46:55.993124  [   23.751234] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dam335x-phy-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/64dce1886f8343a70e35b1ee
        failing since 27 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T14:46:58.157238  /lava-997934/1/../bin/lava-test-case
    2023-08-16T14:46:58.157803  [   25.912248] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/64dce1886f8343a70e35b1ef
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:46:59.193979  /lava-997934/1/../bin/lava-test-case
    2023-08-16T14:46:59.194541  [   26.953575] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-08-16T14:47:00.216305  /lava-997934/1/../bin/lava-test-case
    2023-08-16T14:47:00.237274  [   27.994732] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/64dce1886f8343a70e35b1f9
        failing since 27 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T14:47:11.825359  /lava-997934/1/../bin/lava-test-case
    2023-08-16T14:47:11.846073  [   39.604588] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-08-16T14:47:12.889800  /lava-997934/1/../bin/lava-test-case
    2023-08-16T14:47:12.890359  [   40.645173] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
64dce1886f8343a70e35b1fa
        failing since 27 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T14:47:13.927737  /lava-997934/1/../bin/lava-test-case
    2023-08-16T14:47:13.928303  [   41.686544] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-08-16T14:47:14.950634  /lava-997934/1/../bin/lava-test-case
    2023-08-16T14:47:14.971524  [   42.727710] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/64dce1886f8343a70e35b1fb
        failing since 27 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T14:47:16.009427  /lava-997934/1/../bin/lava-test-case
    2023-08-16T14:47:16.010015  [   43.768814] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-08-16T14:47:17.032124  /lava-997934/1/../bin/lava-test-case
    2023-08-16T14:47:17.059590  [   44.809346] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>
    2023-08-16T14:47:17.059888  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found   =


  * baseline.bootrr.simple-audio-driver-present: https://kernelci.org/test/=
case/id/64dce1886f8343a70e35b1fc
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:47:18.066363  /lava-997934/1/../bin/lava-test-case
    2023-08-16T14:47:18.093765  [   45.851979] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64dce1886=
f8343a70e35b1fd
        failing since 27 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T14:47:19.131748  /lava-997934/1/../bin/lava-test-case
    2023-08-16T14:47:19.132320  [   46.893662] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-08-16T14:47:20.154538  /lava-997934/1/../bin/lava-test-case
    2023-08-16T14:47:20.188553  [   47.933371] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>
    2023-08-16T14:47:20.189126  + set +x
    2023-08-16T14:47:20.189526  [   47.947931] <LAVA_SIGNAL_ENDRUN 1_bootrr=
 997934_1.5.2.4.5>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/64dce1886f8343a7=
0e35b1ff
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)
        1 lines

    2023-08-16T14:46:40.849624  / # =

    2023-08-16T14:46:40.857252  =

    2023-08-16T14:46:40.963635  / # #
    2023-08-16T14:46:40.969016  #
    2023-08-16T14:46:41.071808  / # export SHELL=3D/bin/sh
    2023-08-16T14:46:41.081040  export SHELL=3D/bin/sh
    2023-08-16T14:46:41.183343  / # . /lava-997934/environment
    2023-08-16T14:46:41.192952  . /lava-997934/environment
    2023-08-16T14:46:41.295408  / # /lava-997934/bin/lava-test-runner /lava=
-997934/0
    2023-08-16T14:46:41.304782  /lava-997934/bin/lava-test-runner /lava-997=
934/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 15         =


  Details:     https://kernelci.org/test/plan/id/64dcdf332fc2eb359b35b1dc

  Results:     24 PASS, 17 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/omap2plus_defconfig/gcc-10/lab-broonie/ba=
seline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/omap2plus_defconfig/gcc-10/lab-broonie/ba=
seline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64dcdf332=
fc2eb359b35b1df
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:37:31.401908  /lava-57193/1/../bin/lava-test-case
    2023-08-16T14:37:31.483358  [   50.166301] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-08-16T14:37:32.601668  /lava-57193/1/../bin/lava-test-case
    2023-08-16T14:37:32.681516  [   51.365380] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.simple-audio-driver-present: https://kernelci.org/test/=
case/id/64dcdf332fc2eb359b35b1e0
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:37:29.121455  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found
    2023-08-16T14:37:30.199186  /lava-57193/1/../bin/lava-test-case
    2023-08-16T14:37:30.280615  [   48.962924] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/64dcdf332fc2eb359b35b1e1
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:37:27.813643  /lava-57193/1/../bin/lava-test-case
    2023-08-16T14:37:27.894296  [   46.577570] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-08-16T14:37:29.019395  /lava-57193/1/../bin/lava-test-case
    2023-08-16T14:37:29.099764  [   47.783058] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
64dcdf332fc2eb359b35b1e2
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:37:25.495112  /lava-57193/1/../bin/lava-test-case
    2023-08-16T14:37:25.575998  [   44.259798] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-08-16T14:37:26.699070  /lava-57193/1/../bin/lava-test-case
    2023-08-16T14:37:26.743412  [   45.427304] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/64dcdf332fc2eb359b35b1e3
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:37:23.087873  /lava-57193/1/../bin/lava-test-case
    2023-08-16T14:37:23.166247  [   41.849598] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-08-16T14:37:24.289507  /lava-57193/1/../bin/lava-test-case
    2023-08-16T14:37:24.371116  [   43.053346] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tilcdc-driver-probed: https://kernelci.org/test/case/id=
/64dcdf332fc2eb359b35b1e4
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:37:21.987908  /lava-57193/1/../bin/lava-test-case
    2023-08-16T14:37:22.026136  [   40.709670] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtilcdc-driver-probed RESULT=3Dfail>   =


  * baseline.bootrr.omap-sham-driver-present: https://kernelci.org/test/cas=
e/id/64dcdf332fc2eb359b35b1e9
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:37:19.162471  /lava-57193/1/../bin/lava-test-case
    2023-08-16T14:37:19.243466  [   37.925499] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap-aes-driver-present: https://kernelci.org/test/case=
/id/64dcdf332fc2eb359b35b1ec
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:37:16.460596  /lava-57193/1/../bin/lava-test-case
    2023-08-16T14:37:16.540675  [   35.223086] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/64dcdf332fc2eb359b35b1ef
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:37:12.810842  /lava-57193/1/../bin/lava-test-case
    2023-08-16T14:37:12.856922  [   31.539118] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-08-16T14:37:13.926033  /lava-57193/1/../bin/lava-test-case
    2023-08-16T14:37:14.008598  [   32.690145] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/64dcdf332fc2eb359b35b1f0
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:37:11.608303  /lava-57193/1/../bin/lava-test-case
    2023-08-16T14:37:11.688582  [   30.371131] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sdhci-omap-driver-present: https://kernelci.org/test/ca=
se/id/64dcdf332fc2eb359b35b1f8
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:37:06.082690  /lava-57193/1/../bin/lava-test-case
    2023-08-16T14:37:06.164480  [   24.846137] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dbaseboard-eeprom-probed RESULT=3Dblocked>
    2023-08-16T14:37:07.288378  /lava-57193/1/../bin/lava-test-case
    2023-08-16T14:37:07.369868  [   26.051569] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
64dcdf332fc2eb359b35b1f9
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:37:04.900058  /lava-57193/1/../bin/lava-test-case
    2023-08-16T14:37:04.979680  [   23.661675] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dat24-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.pwrbutton-driver-present: https://kernelci.org/test/cas=
e/id/64dcdf332fc2eb359b35b1fc
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:37:02.288256  /lava-57193/1/../bin/lava-test-case
    2023-08-16T14:37:02.370182  [   21.051351] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dpwrbutton-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/64dcdf332fc2eb359b35b202
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:36:59.356832  /lava-57193/1/../bin/lava-test-case
    2023-08-16T14:36:59.436095  [   18.117315] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/64dcdf332fc2eb35=
9b35b209
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)
        1 lines

    2023-08-16T14:36:56.052861  / # =

    2023-08-16T14:36:56.061275  =

    2023-08-16T14:36:56.167481  / # #
    2023-08-16T14:36:56.173450  #
    2023-08-16T14:36:56.276103  / # export SHELL=3D/bin/sh
    2023-08-16T14:36:56.283050  export SHELL=3D/bin/sh
    2023-08-16T14:36:56.385310  / # . /lava-57193/environment
    2023-08-16T14:36:56.393154  . /lava-57193/environment
    2023-08-16T14:36:56.495482  / # /lava-57193/bin/lava-test-runner /lava-=
57193/0
    2023-08-16T14:36:56.500698  /lava-57193/bin/lava-test-runner /lava-5719=
3/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 15         =


  Details:     https://kernelci.org/test/plan/id/64dcdf307e2f33744e35b1e1

  Results:     24 PASS, 17 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/64dcdf307e2f33744e35b1e7
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:36:47.083657  /lava-997926/1/../bin/lava-test-case
    2023-08-16T14:36:47.163644  [   13.017295] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.pwrbutton-driver-present: https://kernelci.org/test/cas=
e/id/64dcdf307e2f33744e35b1ed
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:36:49.874399  /lava-997926/1/../bin/lava-test-case
    2023-08-16T14:36:49.962306  [   15.816270] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dpwrbutton-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
64dcdf307e2f33744e35b1f0
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:36:52.461482  /lava-997926/1/../bin/lava-test-case
    2023-08-16T14:36:52.550379  [   18.404682] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dat24-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sdhci-omap-driver-present: https://kernelci.org/test/ca=
se/id/64dcdf307e2f33744e35b1f1
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:36:53.669202  /lava-997926/1/../bin/lava-test-case
    2023-08-16T14:36:53.754076  [   19.607679] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dbaseboard-eeprom-probed RESULT=3Dblocked>
    2023-08-16T14:36:54.872798  /lava-997926/1/../bin/lava-test-case
    2023-08-16T14:36:54.920732  [   20.775325] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/64dcdf307e2f33744e35b1f9
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:36:58.849220  /lava-997926/1/../bin/lava-test-case
    2023-08-16T14:36:58.938071  [   24.792557] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/64dcdf307e2f33744e35b1fa
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:37:00.056478  /lava-997926/1/../bin/lava-test-case
    2023-08-16T14:37:00.099321  [   25.954364] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-08-16T14:37:01.154198  /lava-997926/1/../bin/lava-test-case
    2023-08-16T14:37:01.242066  [   27.096290] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap-aes-driver-present: https://kernelci.org/test/case=
/id/64dcdf307e2f33744e35b1fd
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:37:03.774491  /lava-997926/1/../bin/lava-test-case
    2023-08-16T14:37:03.811368  [   29.664347] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap-sham-driver-present: https://kernelci.org/test/cas=
e/id/64dcdf307e2f33744e35b200
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:37:06.261587  /lava-997926/1/../bin/lava-test-case
    2023-08-16T14:37:06.350180  [   32.204518] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tilcdc-driver-probed: https://kernelci.org/test/case/id=
/64dcdf307e2f33744e35b205
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:37:08.999401  /lava-997926/1/../bin/lava-test-case
    2023-08-16T14:37:09.036336  [   34.890057] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtilcdc-driver-probed RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/64dcdf307e2f33744e35b206
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:37:10.075086  /lava-997926/1/../bin/lava-test-case
    2023-08-16T14:37:10.161919  [   36.016907] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-08-16T14:37:11.248742  /lava-997926/1/../bin/lava-test-case
    2023-08-16T14:37:11.337705  [   37.191888] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
64dcdf307e2f33744e35b207
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:37:12.456410  /lava-997926/1/../bin/lava-test-case
    2023-08-16T14:37:12.546321  [   38.400970] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-08-16T14:37:13.664859  /lava-997926/1/../bin/lava-test-case
    2023-08-16T14:37:13.712795  [   39.568411] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/64dcdf307e2f33744e35b208
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:37:14.783639  /lava-997926/1/../bin/lava-test-case
    2023-08-16T14:37:14.862604  [   40.717300] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-08-16T14:37:15.981266  /lava-997926/1/../bin/lava-test-case
    2023-08-16T14:37:16.045217  [   41.882409] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>
    2023-08-16T14:37:16.045794  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found   =


  * baseline.bootrr.simple-audio-driver-present: https://kernelci.org/test/=
case/id/64dcdf307e2f33744e35b209
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:37:17.100027  /lava-997926/1/../bin/lava-test-case
    2023-08-16T14:37:17.177983  [   43.033196] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64dcdf307=
e2f33744e35b20a
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:37:18.264663  /lava-997926/1/../bin/lava-test-case
    2023-08-16T14:37:18.344541  [   44.200400] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-08-16T14:37:19.462954  /lava-997926/1/../bin/lava-test-case
    2023-08-16T14:37:19.552040  [   45.407344] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/64dcdf307e2f3374=
4e35b20c
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)
        1 lines

    2023-08-16T14:36:43.882888  / # =

    2023-08-16T14:36:43.890128  =

    2023-08-16T14:36:43.995419  / # #
    2023-08-16T14:36:44.002207  #
    2023-08-16T14:36:44.104899  / # export SHELL=3D/bin/sh
    2023-08-16T14:36:44.114143  export SHELL=3D/bin/sh
    2023-08-16T14:36:44.216266  / # . /lava-997926/environment
    2023-08-16T14:36:44.225939  . /lava-997926/environment
    2023-08-16T14:36:44.328295  / # /lava-997926/bin/lava-test-runner /lava=
-997926/0
    2023-08-16T14:36:44.337797  /lava-997926/bin/lava-test-runner /lava-997=
926/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce054171f775a2e35b205

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-dell-latitude-5400-4305U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-dell-latitude-5400-4305U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dce054171f775a2e35b=
206
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce3740530930cec35b2ce

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-dell-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-dell-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dce3740530930cec35b=
2cf
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce4dd4f8838d83835b1f9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dce4dd4f8838d83835b=
1fa
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce05d6cb606bebc35b263

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dce05d6cb606bebc35b=
264
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcdf880d909b899335b20f

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/baseli=
ne-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/baseli=
ne-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
64dcdf880d909b899335b213
        failing since 26 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T14:38:44.885458  /lava-1244156/1/../bin/lava-test-case
    2023-08-16T14:38:44.885814  [   27.724770] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dall-cpus-are-online RESULT=3Dfail>
    2023-08-16T14:38:44.886050  /lava-1244156/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcdf757e39d218cc35b1ef

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-nxp/baselin=
e-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-nxp/baselin=
e-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
64dcdf757e39d218cc35b1f3
        failing since 27 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T14:38:35.812156  /lava-1244159/1/../bin/lava-test-case
    2023-08-16T14:38:35.812533  [   21.789152] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dall-cpus-are-online RESULT=3Dfail>
    2023-08-16T14:38:35.812796  /lava-1244159/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
odroid-xu3                   | arm    | lab-collabora | gcc-10   | exynos_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcdf1597e9489a8135b1dd

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: exynos_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/exynos_defconfig/gcc-10/lab-collabora/bas=
eline-odroid-xu3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/exynos_defconfig/gcc-10/lab-collabora/bas=
eline-odroid-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
64dcdf1597e9489a8135b1e1
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:38:34.498962  /lava-11299647/1/../bin/lava-test-case

    2023-08-16T14:38:34.514862  [   13.851089] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dall-cpus-are-online RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv2          | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce1c0432d8a745c35b202

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dce1c0432d8a745c35b=
203
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv2          | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcdf84f07faa1ff335b22b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dcdf84f07faa1ff335b=
22c
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv2-uefi     | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce261b49d0b171435b1de

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dce261b49d0b171435b=
1df
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv2-uefi     | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce061ef9eb524c635b1e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dce061ef9eb524c635b=
1e8
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce29beb67bcc00135b1dd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dce29beb67bcc00135b=
1de
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcdf98d302560aff35b1e4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dcdf98d302560aff35b=
1e5
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3-uefi     | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce26067b79c81ab35b1ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dce26067b79c81ab35b=
1ed
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm-virt-gicv3-uefi     | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce06019b3c5113b35b23c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dce06019b3c5113b35b=
23d
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-broonie   | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcdf2c7e2f33744e35b1dd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/mips/malta_defconfig/gcc-10/lab-broonie/basel=
ine-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/mips/malta_defconfig/gcc-10/lab-broonie/basel=
ine-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dcdf2c7e2f33744e35b=
1de
        failing since 2 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fir=
st fail: v4.19.288-cip101-1117-g1f3468542aa9e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/64dcdf0c97e9489a8135b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/mips/malta_defconfig/gcc-10/lab-collabora/bas=
eline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/mips/malta_defconfig/gcc-10/lab-collabora/bas=
eline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dcdf0c97e9489a8135b=
1da
        failing since 2 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fir=
st fail: v4.19.288-cip101-1117-g1f3468542aa9e) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce0a71ebd814bbb35b213

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-broonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-broonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dce0a71ebd814bbb35b=
214
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie   | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce20f6e0502ef2235b1dc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig/gcc-10/lab-broonie/ba=
seline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig/gcc-10/lab-broonie/ba=
seline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dce20f6e0502ef2235b=
1dd
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce0610eecd1139c35b20e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig/gcc-10/lab-collabora/=
baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig/gcc-10/lab-collabora/=
baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dce0610eecd1139c35b=
20f
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce062171f775a2e35b21d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dce062171f775a2e35b=
21e
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3288-rock2-square          | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/64dcdf650d909b899335b1f4

  Results:     7 PASS, 2 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-rk3288-rock2-square.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-rk3288-rock2-square.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-pm-domain-driver-present: https://kernelci.org=
/test/case/id/64dcdf650d909b899335b1f9
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:39:47.374227  /lava-11299741/1/../bin/lava-test-case

    2023-08-16T14:39:47.406124  [   12.987760] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-probed RESULT=3Dblocked>

    2023-08-16T14:39:48.428816  /lava-11299741/1/../bin/lava-test-case

    2023-08-16T14:39:48.481670  [   14.059323] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pm-domain-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rk3288-crypto-driver-present: https://kernelci.org/test=
/case/id/64dcdf650d909b899335b1fa
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T14:39:46.338892  /lava-11299741/1/../bin/lava-test-case

    2023-08-16T14:39:46.367719  [   11.947948] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-driver-present RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 22         =


  Details:     https://kernelci.org/test/plan/id/64dce5066e7020762d35b1d9

  Results:     37 PASS, 22 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-pm-domain-driver-present: https://kernelci.org=
/test/case/id/64dce5066e7020762d35b1de
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T15:03:57.353494  [   45.857020] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-driver-present RESULT=3Dfail>

    2023-08-16T15:03:58.396394  /lava-11299743/1/../bin/lava-test-case

    2023-08-16T15:03:58.436745  [   46.940767] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-probed RESULT=3Dblocked>

    2023-08-16T15:03:59.491420  /lava-11299743/1/../bin/lava-test-case
   =


  * baseline.bootrr.rk3288-crypto-driver-present: https://kernelci.org/test=
/case/id/64dce5066e7020762d35b1df
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T15:03:56.230720  [   44.735004] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vopl-probed RESULT=3Dfail>

    2023-08-16T15:03:57.313673  /lava-11299743/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-vopl-probed: https://kernelci.org/test/case/id=
/64dce5066e7020762d35b1e0
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T15:03:55.118731  [   43.622842] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vopb-probed RESULT=3Dfail>

    2023-08-16T15:03:56.192701  /lava-11299743/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-vopb-probed: https://kernelci.org/test/case/id=
/64dce5066e7020762d35b1e1
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T15:03:54.063274  [   42.566849] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vop-driver-present RESULT=3Dpass>

    2023-08-16T15:03:55.079083  /lava-11299743/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb-phy-grf-probed: https://kernelci.org/test/=
case/id/64dce5066e7020762d35b1e3
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T15:03:52.932510  [   41.435861] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb-phy-driver-present RESULT=3Dpass>

    2023-08-16T15:03:53.946614  /lava-11299743/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-pwm0-probed: https://kernelci.org/test/case/id=
/64dce5066e7020762d35b1eb
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T15:03:51.625873  [   40.129450] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pwm-driver-present RESULT=3Dpass>

    2023-08-16T15:03:52.646640  /lava-11299743/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-iodomain-driver-present: https://kernelci.org/=
test/case/id/64dce5066e7020762d35b1ed
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T15:03:49.367852  /lava-11299743/1/../bin/lava-test-case

    2023-08-16T15:03:49.406963  [   37.910886] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-i2s-probed RESULT=3Dblocked>

    2023-08-16T15:03:50.460417  /lava-11299743/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockcip-i2s-driver-present: https://kernelci.org/test/c=
ase/id/64dce5066e7020762d35b1ee
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T15:03:46.132180  [   34.635306] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-phy-driver-present RESULT=3Dfail>

    2023-08-16T15:03:47.187142  /lava-11299743/1/../bin/lava-test-case

    2023-08-16T15:03:47.224395  [   35.727969] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-phy-grf-probed RESULT=3Dblocked>

    2023-08-16T15:03:48.275693  /lava-11299743/1/../bin/lava-test-case

    2023-08-16T15:03:48.314047  [   36.817873] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockcip-i2s-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rk_iommu-vopb_mmu-probed: https://kernelci.org/test/cas=
e/id/64dce5066e7020762d35b1ef
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T15:03:39.634336  [   28.138018] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-driver-present RESULT=3Dpass>

    2023-08-16T15:03:40.650408  /lava-11299743/1/../bin/lava-test-case
   =


  * baseline.bootrr.ramoops-driver-present: https://kernelci.org/test/case/=
id/64dce5066e7020762d35b1f7
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T15:03:37.305202  [   25.807747] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dehci-platform-usb_host0_ehci-probed RESULT=3Dpass>

    2023-08-16T15:03:38.318454  /lava-11299743/1/../bin/lava-test-case

    2023-08-16T15:03:38.356577  [   26.860486] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dramoops-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/64dce5066e7020762d35b1fb
        failing since 27 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-16T15:03:36.093433  [   24.593474] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dpass>

    2023-08-16T15:03:37.108090  /lava-11299743/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64dce5066e7020762d35b1fe
        failing since 208 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-08-16T15:03:36.020052  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA[ =
  24.518328] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-au=
dio-present RESULT=3Dfail>

    2023-08-16T15:03:36.020277  ST

    2023-08-16T15:03:36.020492  =


    2023-08-16T15:03:36.024968  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-08-16T15:03:36.027270  FIRST, INC default to 1.

    2023-08-16T15:03:36.027487  =


    2023-08-16T15:03:36.030547  	-w	Pad to last with leading zeros
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64dce5066e7020762d35b1ff
        failing since 208 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-08-16T15:03:35.981158  [   24.484668] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dfail>

    2023-08-16T15:03:36.007387  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-08-16T15:03:36.007737  =

   =


  * baseline.bootrr.dwhdmi-rockchip-probed: https://kernelci.org/test/case/=
id/64dce5066e7020762d35b200
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T15:03:34.922272  [   23.425290] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-driver-present RESULT=3Dpass>

    2023-08-16T15:03:35.941977  /lava-11299743/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-dp-phy-driver-present: https://kernelci.org/te=
st/case/id/64dce5066e7020762d35b201
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T15:03:45.005184  /lava-11299743/1/../bin/lava-test-case

    2023-08-16T15:03:45.045601  [   33.549149] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-edp-probed RESULT=3Dblocked>

    2023-08-16T15:03:46.092473  /lava-11299743/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-dp-driver-present: https://kernelci.org/test/c=
ase/id/64dce5066e7020762d35b202
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T15:03:42.878922  [   31.382633] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vpu_mmu-probed RESULT=3Dfail>

    2023-08-16T15:03:43.909761  /lava-11299743/1/../bin/lava-test-case

    2023-08-16T15:03:43.949438  [   32.453183] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rk_iommu-vpu_mmu-probed: https://kernelci.org/test/case=
/id/64dce5066e7020762d35b203
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T15:03:41.766957  [   30.270487] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vopl_mmu-probed RESULT=3Dfail>

    2023-08-16T15:03:42.840476  /lava-11299743/1/../bin/lava-test-case
   =


  * baseline.bootrr.rk_iommu-vopl_mmu-probed: https://kernelci.org/test/cas=
e/id/64dce5066e7020762d35b204
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T15:03:40.690111  [   29.193564] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vopb_mmu-probed RESULT=3Dfail>

    2023-08-16T15:03:41.727117  /lava-11299743/1/../bin/lava-test-case
   =


  * baseline.bootrr.dw_wdt-driver-present: https://kernelci.org/test/case/i=
d/64dce5066e7020762d35b209
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T15:03:33.618108  /lava-11299743/1/../bin/lava-test-case
   =


  * baseline.bootrr.cros-ec-keyb-probed: https://kernelci.org/test/case/id/=
64dce5066e7020762d35b20e
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T15:03:31.398107  [   19.901321] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-keyb-driver-present RESULT=3Dpass>

    2023-08-16T15:03:32.415431  /lava-11299743/1/../bin/lava-test-case
   =


  * baseline.bootrr.cros-ec-i2c-tunnel-driver-present: https://kernelci.org=
/test/case/id/64dce5066e7020762d35b210
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T15:03:28.686874  [   17.187382] asix 3-1:1.0 eth0: register =
'asix' at usb-ff580000.usb-1, ASIX AX88772B USB 2.0 Ethernet, 00:6f:00:09:0=
8:66

    2023-08-16T15:03:28.708450  [   17.212510] dwmmc_rockchip ff0d0000.dwmm=
c: IDMAC supports 32-bit address mode.

    2023-08-16T15:03:28.716100  [   17.220481] dwmmc_rockchip ff0d0000.dwmm=
c: Using internal DMA controller.

    2023-08-16T15:03:28.722056  [   17.227519] dwmmc_rockchip ff0d0000.dwmm=
c: Version ID is 270a

    2023-08-16T15:03:28.731999  [   17.233536] dwmmc_rockchip ff0d0000.dwmm=
c: DW MMC controller at irq 30,32 bit host data width,256 deep fifo

    2023-08-16T15:03:29.202983  /lava-11299743/1/../bin/lava-test-case

    2023-08-16T15:03:29.211997  [   17.715620] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-dev-probed RESULT=3Dblocked>

    2023-08-16T15:03:30.223969  /lava-11299743/1/../bin/lava-test-case
   =


  * baseline.bootrr.cros-ec-dev-driver-present: https://kernelci.org/test/c=
ase/id/64dce5066e7020762d35b211
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d)

    2023-08-16T15:03:27.348811  [   15.855363] dwc2 ff580000.usb: DWC OTG C=
ontroller

    2023-08-16T15:03:27.355994  [   15.860142] dwc2 ff580000.usb: new USB b=
us registered, assigned bus number 3

    2023-08-16T15:03:27.361296  [   15.867251] dwc2 ff580000.usb: irq 43, i=
o mem 0x00000000

    2023-08-16T15:03:27.367377  [   15.874795] hub 3-0:1.0: USB hub found

    2023-08-16T15:03:27.371569  [   15.878763] hub 3-0:1.0: 1 port detected

    2023-08-16T15:03:27.387964  [   15.891956] dwmmc_rockchip ff0d0000.dwmm=
c: IDMAC supports 32-bit address mode.

    2023-08-16T15:03:27.395345  [   15.899781] dwmmc_rockchip ff0d0000.dwmm=
c: Using internal DMA controller.

    2023-08-16T15:03:27.401298  [   15.906718] dwmmc_rockchip ff0d0000.dwmm=
c: Version ID is 270a

    2023-08-16T15:03:27.411032  [   15.912609] dwmmc_rockchip ff0d0000.dwmm=
c: DW MMC controller at irq 30,32 bit host data width,256 deep fifo

    2023-08-16T15:03:27.670187  [   16.175219] usb 3-1: new high-speed USB =
device number 2 using dwc2
 =

    ... (2 line(s) more)  =

 =20


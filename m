Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756E5C25B67
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 14:12:47 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web11.71680.1698329564939797542
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 26 Oct 2023 07:12:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=x/xsXTyt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6bd96cfb99cso876552b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 26 Oct 2023 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698329564; x=1698934364; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jFym2+Xi5hh2mKKGYAOBlumj0oWLN3i59UZWGp7ZCLo=;
        b=x/xsXTytKkKTcOZ4V6GtftnaurVqAKgE18j3Io7XKFcjCaxPXcMujpHL1mhiP4L/mi
         T9ZlbT9IaPrHaVykK0RHEkitu/nSgxUEbhsKueGpjflmWzMb3SyPk7NxiL4T8BulfH5L
         RbgWElB8eWgtbMYt/NP9a1zH18nfDf7p3f7rcA+Ds2vzmN88kU/O+d17y4b5JSjzjiXk
         sYrwPIBDMK6yFDVroSki2s4AI8Cuy2f52LDvwX4fHJ22B7hLDihwiID0d/GpN3Uyhaok
         kJPKE6P+EwCSRjVbT6vzYKxcrb8p3M2JMSinafVVFkTfQs77ffoAtoRcYE92Idezgs0b
         Q8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698329564; x=1698934364;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFym2+Xi5hh2mKKGYAOBlumj0oWLN3i59UZWGp7ZCLo=;
        b=ZbH35S7eDuydO72UHe7+mRdibU6Hl+4uF4hlpTtNpkG6OO20qfpj//QpLWetZUKHdd
         4o4ENg5I3i31MGlhhg4R99a5ybq2mgzSuc5xk5EcipujymkLVZck/d0F+DTxBBfAebG6
         zsQtxjWVG2yrG0n/IonEm39Rn5QiHsqlDn3Z/1O7u6uBKR12NWOT2K6uQOHeObYuoyAm
         LjaCZIHpScLpLch1tiMPA9Cu77cv3cRsYgr6AtJL94tcmEprFt0QaAiILb0dlHceykqq
         lRI5UN94os6MkG1fXfKdjr+rku7ON83S6gq0DxTyE8qkHGA6lXvntmnaRf4dXT53sQzA
         lWHg==
X-Gm-Message-State: AOJu0YzpQnw5RrCieJdRdi67iPIp8lE8FVAgM7v/5daJbyVjkx3Nu0XL
	o4fVIzG0ai38PVYZuYZKpfk1hNb+P8HO++s8+sk=
X-Google-Smtp-Source: AGHT+IFr2QA0KYhchcuY4BkXPAHyQ9ALP9JiABxocY1orV3Su6T8RHd4OOEhpWXJynNGvAIHPSYhbg==
X-Received: by 2002:a05:6a20:2446:b0:17f:643f:fc4 with SMTP id t6-20020a056a20244600b0017f643f0fc4mr1558534pzc.22.1698329562723;
        Thu, 26 Oct 2023 07:12:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f23-20020aa79697000000b0068fb783d0c6sm11610023pfk.141.2023.10.26.07.12.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 07:12:41 -0700 (PDT)
Message-ID: <653a73d9.a70a0220.3562b.704c@mx.google.com>
Date: Thu, 26 Oct 2023 07:12:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4-st20-3596-g73e7f2b880d98
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline: 72 runs,
 97 regressions (v4.4-st20-3596-g73e7f2b880d98)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Oct 2023 14:12:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13464

cip-gitlab/ci/pavel/linux-test baseline: 72 runs, 97 regressions (v4.4-st20=
-3596-g73e7f2b880d98)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

acer-chromebox-cxi4-puff     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

acer-cp514-3wh-r0qs-guybrush | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig          | 7          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 8          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig         | 8          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig        | 15         =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig        | 15         =

dell-latitude...4305U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

dell-latitude...8665U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

imx28-duckbill               | arm    | lab-pengutronix | gcc-10   | mxs_de=
fconfig              | 1          =

odroid-xu3                   | arm    | lab-collabora   | gcc-10   | exynos=
_defconfig           | 1          =

qemu_arm-virt-gicv2          | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =

qemu_arm-virt-gicv2          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 1          =

qemu_arm-virt-gicv2-uefi     | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =

qemu_arm-virt-gicv2-uefi     | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 1          =

qemu_arm-virt-gicv3          | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =

qemu_arm-virt-gicv3          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 1          =

qemu_arm-virt-gicv3-uefi     | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =

qemu_arm-virt-gicv3-uefi     | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defconfig           | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig           | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =

rk3288-rock2-square          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 2          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 19         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-3596-g73e7f2b880d98/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-3596-g73e7f2b880d98
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      73e7f2b880d98bcbacb997959b6c7b220f7fe382 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e16797b85123cefcf0d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653a6e16797b85123cefc=
f0e
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e035404ea4f56efcef8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653a6e035404ea4f56efc=
ef9
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
acer-cp514-3wh-r0qs-guybrush | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e1957301d2c8eefcefc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-acer-cp514-3wh-r0qs-guybrush.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-acer-cp514-3wh-r0qs-guybrush.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653a6e1957301d2c8eefc=
efd
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6f8846e334fc8befcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653a6f8846e334fc8befc=
ef4
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e202f7837aeecefcf45

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653a6e202f7837aeecefc=
f46
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig          | 7          =


  Details:     https://kernelci.org/test/plan/id/653a6d234b5b726316efceff

  Results:     36 PASS, 11 FAIL, 2 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/at91_dt_defconfig/gcc-10/lab-broonie/bas=
eline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/at91_dt_defconfig/gcc-10/lab-broonie/bas=
eline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/653a6d244=
b5b726316efcf0e
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:43:53.024041  random: nonblocking pool is initialized
    2023-10-26T13:43:53.064421  /lava-199954/1/../bin/lava-test-case   =


  * baseline.bootrr.audio-card-probed: https://kernelci.org/test/case/id/65=
3a6d244b5b726316efcf0f
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:43:51.986431  /lava-199954/1/../bin/lava-test-case   =


  * baseline.bootrr.i2c0-probed: https://kernelci.org/test/case/id/653a6d24=
4b5b726316efcf15
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:43:46.322691  /lava-199954/1/../bin/lava-test-case   =


  * baseline.bootrr.atmel-nand-driver-present: https://kernelci.org/test/ca=
se/id/653a6d244b5b726316efcf29
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:43:39.432302  /lava-199954/1/../bin/lava-test-case
    2023-10-26T13:43:40.518268  /lava-199954/1/../bin/lava-test-case   =


  * baseline.bootrr.atmel-ebi-driver-present: https://kernelci.org/test/cas=
e/id/653a6d244b5b726316efcf2a
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:43:38.346310  /lava-199954/1/../bin/lava-test-case   =


  * baseline.bootrr.atmel-usart-serial-driver-present: https://kernelci.org=
/test/case/id/653a6d244b5b726316efcf2e
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:43:33.854345  /lava-199954/1/../bin/lava-test-case   =


  * baseline.bootrr.at91-usart-mode-driver-present: https://kernelci.org/te=
st/case/id/653a6d244b5b726316efcf2f
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:43:32.768636  /lava-199954/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 8          =


  Details:     https://kernelci.org/test/plan/id/653a6d7fdc88a8f44befcf2c

  Results:     15 PASS, 21 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-broonie/ba=
seline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-broonie/ba=
seline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/653a6d7fdc88a8f4=
4befcf31
        new failure (last pass: v5.10.194-915-g33f52aa14b957)
        1 lines

    2023-10-26T13:44:46.195941  / # =

    2023-10-26T13:44:46.200827  =

    2023-10-26T13:44:46.304186  / # #
    2023-10-26T13:44:46.309290  #
    2023-10-26T13:44:46.410897  / # export SHELL=3D/bin/sh
    2023-10-26T13:44:46.416049  export SHELL=3D/bin/sh
    2023-10-26T13:44:46.517510  / # . /lava-199984/environment
    2023-10-26T13:44:46.521964  . /lava-199984/environment
    2023-10-26T13:44:46.623486  / # /lava-199984/bin/lava-test-runner /lava=
-199984/0
    2023-10-26T13:44:46.628606  /lava-199984/bin/lava-test-runner /lava-199=
984/0 =

    ... (9 line(s) more)  =


  * baseline.bootrr.simple-audio-driver-present: https://kernelci.org/test/=
case/id/653a6d7fdc88a8f44befcf34
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:45:22.349825  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found
    2023-10-26T13:45:23.365272  /lava-199984/1/../bin/lava-test-case
    2023-10-26T13:45:23.382952  [   50.904708] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/653a6d7fdc88a8f44befcf41
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:45:04.472722  /lava-199984/1/../bin/lava-test-case
    2023-10-26T13:45:04.490062  [   32.012263] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-10-26T13:45:05.513666  /lava-199984/1/../bin/lava-test-case
    2023-10-26T13:45:05.531851  [   33.052983] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.am335x-phy-driver-present: https://kernelci.org/test/ca=
se/id/653a6d7fdc88a8f44befcf45
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:44:59.187599  /lava-199984/1/../bin/lava-test-case
    2023-10-26T13:44:59.205194  [   26.726782] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb0-musb-dsps-probed RESULT=3Dblocked>
    2023-10-26T13:45:00.228919  /lava-199984/1/../bin/lava-test-case
    2023-10-26T13:45:00.246955  [   27.768208] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb1-musb-dsps-probed RESULT=3Dblocked>
    2023-10-26T13:45:01.269853  /lava-199984/1/../bin/lava-test-case
    2023-10-26T13:45:01.288061  [   28.809798] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dam335x-phy-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.musb-dsps-driver-present: https://kernelci.org/test/cas=
e/id/653a6d7fdc88a8f44befcf46
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:44:56.065638  /lava-199984/1/../bin/lava-test-case
    2023-10-26T13:44:56.082268  [   23.604764] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc0-probed RESULT=3Dblocked>
    2023-10-26T13:44:57.106346  /lava-199984/1/../bin/lava-test-case
    2023-10-26T13:44:57.123165  [   24.645223] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc1-probed RESULT=3Dblocked>
    2023-10-26T13:44:58.146692  /lava-199984/1/../bin/lava-test-case
    2023-10-26T13:44:58.163665  [   25.685464] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmusb-dsps-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sdhci-omap-driver-present: https://kernelci.org/test/ca=
se/id/653a6d7fdc88a8f44befcf47
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:44:55.024240  /lava-199984/1/../bin/lava-test-case
    2023-10-26T13:44:55.041801  [   22.563379] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tps65217-driver-present: https://kernelci.org/test/case=
/id/653a6d7fdc88a8f44befcf4d
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:44:50.725299  /lava-199984/1/../bin/lava-test-case
    2023-10-26T13:44:50.742580  [   18.264157] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtps65217-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/653a6d7fdc88a8f44befcf51
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:44:48.523221  /lava-199984/1/../bin/lava-test-case
    2023-10-26T13:44:48.540758  [   16.061939] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig         | 8          =


  Details:     https://kernelci.org/test/plan/id/653a6f79d3b8f1c7e3efceff

  Results:     15 PASS, 21 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-cip/baseli=
ne-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-cip/baseli=
ne-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/653a6f79d3b8f1c7=
e3efcf04
        new failure (last pass: v5.10.194-915-g33f52aa14b957)
        1 lines

    2023-10-26T13:53:15.504787  / # =

    2023-10-26T13:53:15.512290  =

    2023-10-26T13:53:15.617366  / # #
    2023-10-26T13:53:15.624798  #
    2023-10-26T13:53:15.726489  / # export SHELL=3D/bin/sh
    2023-10-26T13:53:15.733421  export SHELL=3D/bin/sh
    2023-10-26T13:53:15.834698  / # . /lava-1027203/environment
    2023-10-26T13:53:15.840797  . /lava-1027203/environment
    2023-10-26T13:53:15.941679  / # /lava-1027203/bin/lava-test-runner /lav=
a-1027203/0
    2023-10-26T13:53:15.948494  /lava-1027203/bin/lava-test-runner /lava-10=
27203/0 =

    ... (9 line(s) more)  =


  * baseline.bootrr.simple-audio-driver-present: https://kernelci.org/test/=
case/id/653a6f79d3b8f1c7e3efcf07
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:53:51.674150  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found
    2023-10-26T13:53:52.690322  /lava-1027203/1/../bin/lava-test-case
    2023-10-26T13:53:52.707419  [   44.942569] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/653a6f79d3b8f1c7e3efcf14
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:53:33.794677  /lava-1027203/1/../bin/lava-test-case
    2023-10-26T13:53:33.811962  [   26.046807] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-10-26T13:53:34.836553  /lava-1027203/1/../bin/lava-test-case
    2023-10-26T13:53:34.852560  [   27.087602] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.am335x-phy-driver-present: https://kernelci.org/test/ca=
se/id/653a6f79d3b8f1c7e3efcf18
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:53:28.509662  /lava-1027203/1/../bin/lava-test-case
    2023-10-26T13:53:28.527758  [   20.761727] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb0-musb-dsps-probed RESULT=3Dblocked>
    2023-10-26T13:53:29.551194  /lava-1027203/1/../bin/lava-test-case
    2023-10-26T13:53:29.569371  [   21.802998] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb1-musb-dsps-probed RESULT=3Dblocked>
    2023-10-26T13:53:30.592030  /lava-1027203/1/../bin/lava-test-case
    2023-10-26T13:53:30.610160  [   22.844225] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dam335x-phy-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.musb-dsps-driver-present: https://kernelci.org/test/cas=
e/id/653a6f79d3b8f1c7e3efcf19
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:53:25.387988  /lava-1027203/1/../bin/lava-test-case
    2023-10-26T13:53:25.403729  [   17.639237] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc0-probed RESULT=3Dblocked>
    2023-10-26T13:53:26.428358  /lava-1027203/1/../bin/lava-test-case
    2023-10-26T13:53:26.445375  [   18.679560] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc1-probed RESULT=3Dblocked>
    2023-10-26T13:53:27.468099  /lava-1027203/1/../bin/lava-test-case
    2023-10-26T13:53:27.485819  [   19.720191] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmusb-dsps-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sdhci-omap-driver-present: https://kernelci.org/test/ca=
se/id/653a6f79d3b8f1c7e3efcf1a
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:53:24.345856  /lava-1027203/1/../bin/lava-test-case
    2023-10-26T13:53:24.363990  [   16.597893] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tps65217-driver-present: https://kernelci.org/test/case=
/id/653a6f79d3b8f1c7e3efcf20
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:53:20.047694  /lava-1027203/1/../bin/lava-test-case
    2023-10-26T13:53:20.063580  [   12.298459] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtps65217-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/653a6f79d3b8f1c7e3efcf24
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:53:17.843757  /lava-1027203/1/../bin/lava-test-case
    2023-10-26T13:53:17.861922  [   10.095541] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig        | 15         =


  Details:     https://kernelci.org/test/plan/id/653a6c93e8c1f223aeefcf02

  Results:     24 PASS, 17 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/omap2plus_defconfig/gcc-10/lab-broonie/b=
aseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/omap2plus_defconfig/gcc-10/lab-broonie/b=
aseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/653a6c93e8c1f223=
aeefcf07
        new failure (last pass: v5.10.194-915-g33f52aa14b957)
        1 lines

    2023-10-26T13:40:55.659311  / # =

    2023-10-26T13:40:55.666604  =

    2023-10-26T13:40:55.769644  / # #
    2023-10-26T13:40:55.775480  #
    2023-10-26T13:40:55.877125  / # export SHELL=3D/bin/sh
    2023-10-26T13:40:55.883192  export SHELL=3D/bin/sh
    2023-10-26T13:40:55.984748  / # . /lava-199944/environment
    2023-10-26T13:40:55.991486  . /lava-199944/environment
    2023-10-26T13:40:56.092848  / # /lava-199944/bin/lava-test-runner /lava=
-199944/0
    2023-10-26T13:40:56.097762  /lava-199944/bin/lava-test-runner /lava-199=
944/0 =

    ... (9 line(s) more)  =


  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/653a6c93e=
8c1f223aeefcf09
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:41:31.182162  /lava-199944/1/../bin/lava-test-case
    2023-10-26T13:41:31.226291  [   50.547450] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-10-26T13:41:32.293097  /lava-199944/1/../bin/lava-test-case
    2023-10-26T13:41:32.370982  [   51.693117] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.simple-audio-driver-present: https://kernelci.org/test/=
case/id/653a6c93e8c1f223aeefcf0a
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:41:28.867605  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found
    2023-10-26T13:41:29.975597  /lava-199944/1/../bin/lava-test-case
    2023-10-26T13:41:30.058304  [   49.378823] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/653a6c93e8c1f223aeefcf0b
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:41:27.560893  /lava-199944/1/../bin/lava-test-case
    2023-10-26T13:41:27.641303  [   46.962725] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-10-26T13:41:28.766319  /lava-199944/1/../bin/lava-test-case
    2023-10-26T13:41:28.847322  [   48.167892] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
653a6c93e8c1f223aeefcf0c
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:41:25.145755  /lava-199944/1/../bin/lava-test-case
    2023-10-26T13:41:25.226409  [   44.547515] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-10-26T13:41:26.351485  /lava-199944/1/../bin/lava-test-case
    2023-10-26T13:41:26.431295  [   45.752414] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/653a6c93e8c1f223aeefcf0d
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:41:22.756927  /lava-199944/1/../bin/lava-test-case
    2023-10-26T13:41:22.836254  [   42.157557] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-10-26T13:41:23.961300  /lava-199944/1/../bin/lava-test-case
    2023-10-26T13:41:24.040484  [   43.361897] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tilcdc-driver-probed: https://kernelci.org/test/case/id=
/653a6c93e8c1f223aeefcf0e
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:41:21.551930  /lava-199944/1/../bin/lava-test-case
    2023-10-26T13:41:21.630059  [   40.951207] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtilcdc-driver-probed RESULT=3Dfail>   =


  * baseline.bootrr.omap-sham-driver-present: https://kernelci.org/test/cas=
e/id/653a6c93e8c1f223aeefcf13
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:41:18.704186  /lava-199944/1/../bin/lava-test-case
    2023-10-26T13:41:18.788541  [   38.109062] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap-aes-driver-present: https://kernelci.org/test/case=
/id/653a6c93e8c1f223aeefcf16
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:41:16.172023  /lava-199944/1/../bin/lava-test-case
    2023-10-26T13:41:16.252899  [   35.574012] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/653a6c93e8c1f223aeefcf19
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:41:12.315517  /lava-199944/1/../bin/lava-test-case
    2023-10-26T13:41:12.396935  [   31.717207] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-10-26T13:41:13.524664  /lava-199944/1/../bin/lava-test-case
    2023-10-26T13:41:13.605501  [   32.925334] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/653a6c93e8c1f223aeefcf1a
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:41:11.106784  /lava-199944/1/../bin/lava-test-case
    2023-10-26T13:41:11.189297  [   30.508977] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sdhci-omap-driver-present: https://kernelci.org/test/ca=
se/id/653a6c93e8c1f223aeefcf22
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:41:05.656392  /lava-199944/1/../bin/lava-test-case
    2023-10-26T13:41:05.738941  [   25.058734] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dbaseboard-eeprom-probed RESULT=3Dblocked>
    2023-10-26T13:41:06.865676  /lava-199944/1/../bin/lava-test-case
    2023-10-26T13:41:06.947022  [   26.266918] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
653a6c93e8c1f223aeefcf23
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:41:04.448895  /lava-199944/1/../bin/lava-test-case
    2023-10-26T13:41:04.529501  [   23.850894] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dat24-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.pwrbutton-driver-present: https://kernelci.org/test/cas=
e/id/653a6c93e8c1f223aeefcf26
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:41:01.877972  /lava-199944/1/../bin/lava-test-case
    2023-10-26T13:41:01.958911  [   21.278666] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dpwrbutton-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/653a6c93e8c1f223aeefcf2c
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:40:59.058337  /lava-199944/1/../bin/lava-test-case
    2023-10-26T13:40:59.139942  [   18.459146] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig        | 15         =


  Details:     https://kernelci.org/test/plan/id/653a6c9bcb005be6e4efcf19

  Results:     24 PASS, 17 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/omap2plus_defconfig/gcc-10/lab-cip/basel=
ine-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/omap2plus_defconfig/gcc-10/lab-cip/basel=
ine-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/653a6c9bcb005be6=
e4efcf1e
        new failure (last pass: v5.10.194-915-g33f52aa14b957)
        1 lines

    2023-10-26T13:40:53.345338  / # =

    2023-10-26T13:40:53.357149  =

    2023-10-26T13:40:53.459756  / # #
    2023-10-26T13:40:53.469081  #
    2023-10-26T13:40:53.569875  / # export SHELL=3D/bin/sh
    2023-10-26T13:40:53.580906  export SHELL=3D/bin/sh
    2023-10-26T13:40:53.725590  / # . /lava-1027190/environment
    2023-10-26T13:40:53.740920  . /lava-1027190/environment
    2023-10-26T13:40:53.841903  / # /lava-1027190/bin/lava-test-runner /lav=
a-1027190/0
    2023-10-26T13:40:53.852745  /lava-1027190/bin/lava-test-runner /lava-10=
27190/0 =

    ... (9 line(s) more)  =


  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/653a6c9bc=
b005be6e4efcf20
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:41:27.508265  /lava-1027190/1/../bin/lava-test-case
    2023-10-26T13:41:27.550254  [   43.952520] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-10-26T13:41:28.605584  /lava-1027190/1/../bin/lava-test-case
    2023-10-26T13:41:28.691592  [   45.093259] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.simple-audio-driver-present: https://kernelci.org/test/=
case/id/653a6c9bcb005be6e4efcf21
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:41:25.285770  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found
    2023-10-26T13:41:26.389039  /lava-1027190/1/../bin/lava-test-case
    2023-10-26T13:41:26.436966  [   42.839654] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/653a6c9bcb005be6e4efcf22
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:41:23.975748  /lava-1027190/1/../bin/lava-test-case
    2023-10-26T13:41:24.060582  [   40.461633] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-10-26T13:41:25.179738  /lava-1027190/1/../bin/lava-test-case
    2023-10-26T13:41:25.264849  [   41.665685] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
653a6c9bcb005be6e4efcf23
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:41:21.599010  /lava-1027190/1/../bin/lava-test-case
    2023-10-26T13:41:21.667917  [   38.067957] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-10-26T13:41:22.787275  /lava-1027190/1/../bin/lava-test-case
    2023-10-26T13:41:22.872285  [   39.273451] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/653a6c9bcb005be6e4efcf24
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:41:19.290466  /lava-1027190/1/../bin/lava-test-case
    2023-10-26T13:41:19.381441  [   35.782932] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-10-26T13:41:20.500652  /lava-1027190/1/../bin/lava-test-case
    2023-10-26T13:41:20.543718  [   36.945107] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tilcdc-driver-probed: https://kernelci.org/test/case/id=
/653a6c9bcb005be6e4efcf25
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:41:18.214130  /lava-1027190/1/../bin/lava-test-case
    2023-10-26T13:41:18.251223  [   34.652603] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtilcdc-driver-probed RESULT=3Dfail>   =


  * baseline.bootrr.omap-sham-driver-present: https://kernelci.org/test/cas=
e/id/653a6c9bcb005be6e4efcf2a
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:41:15.560969  /lava-1027190/1/../bin/lava-test-case
    2023-10-26T13:41:15.599943  [   32.001689] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap-aes-driver-present: https://kernelci.org/test/case=
/id/653a6c9bcb005be6e4efcf2d
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:41:13.129465  /lava-1027190/1/../bin/lava-test-case
    2023-10-26T13:41:13.176472  [   29.578061] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/653a6c9bcb005be6e4efcf30
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:41:09.466820  /lava-1027190/1/../bin/lava-test-case
    2023-10-26T13:41:09.509807  [   25.910778] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-10-26T13:41:10.565050  /lava-1027190/1/../bin/lava-test-case
    2023-10-26T13:41:10.612023  [   27.013282] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/653a6c9bcb005be6e4efcf31
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:41:08.254591  /lava-1027190/1/../bin/lava-test-case
    2023-10-26T13:41:08.347584  [   24.748229] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sdhci-omap-driver-present: https://kernelci.org/test/ca=
se/id/653a6c9bcb005be6e4efcf39
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:41:03.100926  /lava-1027190/1/../bin/lava-test-case
    2023-10-26T13:41:03.188917  [   19.589435] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dbaseboard-eeprom-probed RESULT=3Dblocked>
    2023-10-26T13:41:04.308184  /lava-1027190/1/../bin/lava-test-case
    2023-10-26T13:41:04.356130  [   20.758835] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
653a6c9bcb005be6e4efcf3a
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:41:01.891645  /lava-1027190/1/../bin/lava-test-case
    2023-10-26T13:41:01.981704  [   18.381768] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dat24-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.pwrbutton-driver-present: https://kernelci.org/test/cas=
e/id/653a6c9bcb005be6e4efcf3d
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:40:59.284573  /lava-1027190/1/../bin/lava-test-case
    2023-10-26T13:40:59.374260  [   15.774723] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dpwrbutton-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/653a6c9bcb005be6e4efcf43
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:40:56.487150  /lava-1027190/1/../bin/lava-test-case
    2023-10-26T13:40:56.566137  [   12.966929] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
dell-latitude...4305U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e1e2f7837aeecefcf42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-dell-latitude-5400-4305U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-dell-latitude-5400-4305U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653a6e1e2f7837aeecefc=
f43
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e187cbf675b11efcf13

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-dell-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-dell-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653a6e187cbf675b11efc=
f14
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e165404ea4f56efcf09

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653a6e165404ea4f56efc=
f0a
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e192f7837aeecefcf37

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653a6e192f7837aeecefc=
f38
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
imx28-duckbill               | arm    | lab-pengutronix | gcc-10   | mxs_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6cb3e8c1f223aeefd035

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: mxs_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/mxs_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx28-duckbill.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/mxs_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx28-duckbill.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653a6cb3e8c1f223aeefd=
036
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
odroid-xu3                   | arm    | lab-collabora   | gcc-10   | exynos=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6cfb4bba68e1b7efcefd

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: exynos_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/exynos_defconfig/gcc-10/lab-collabora/ba=
seline-odroid-xu3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/exynos_defconfig/gcc-10/lab-collabora/ba=
seline-odroid-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
653a6cfb4bba68e1b7efcf05
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:47:28.117446  /lava-11884049/1/../bin/lava-test-case

    2023-10-26T13:47:28.133719  [   13.779107] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dall-cpus-are-online RESULT=3Dfail>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_arm-virt-gicv2          | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6d526fbf1499e5efcef9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-broonie/ba=
seline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-broonie/ba=
seline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653a6d526fbf1499e5efc=
efa
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_arm-virt-gicv2          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6d1f5fb6815140efcefe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653a6d1f5fb6815140efc=
eff
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_arm-virt-gicv2-uefi     | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6ea6ad353f59ceefcf0d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-broonie/ba=
seline-qemu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-broonie/ba=
seline-qemu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653a6ea6ad353f59ceefc=
f0e
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_arm-virt-gicv2-uefi     | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e0d5404ea4f56efcf02

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-qemu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-qemu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653a6e0d5404ea4f56efc=
f03
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6dde77ce5dd026efcf0c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-broonie/ba=
seline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-broonie/ba=
seline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653a6dde77ce5dd026efc=
f0d
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6d22b2ea0af323efceff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653a6d22b2ea0af323efc=
f00
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_arm-virt-gicv3-uefi     | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e6a44cb5ba705efcfca

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-broonie/ba=
seline-qemu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-broonie/ba=
seline-qemu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653a6e6a44cb5ba705efc=
fcb
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_arm-virt-gicv3-uefi     | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e063a3fa5bc09efcf13

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-qemu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-qemu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653a6e063a3fa5bc09efc=
f14
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6db63ad01b3ceeefcf3c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig/gcc-10/lab-broonie/b=
aseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig/gcc-10/lab-broonie/b=
aseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653a6db63ad01b3ceeefc=
f3d
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e5344cb5ba705efcef7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-broonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-broonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653a6e5344cb5ba705efc=
ef8
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6db0467cfcda03efcef5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig/gcc-10/lab-collabora=
/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig/gcc-10/lab-collabora=
/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653a6db0467cfcda03efc=
ef6
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/653a6e0ed9d28a2d1cefcf10

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/653a6e0ed9d28a2d1cefc=
f11
        new failure (last pass: v5.10.194-915-g33f52aa14b957) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
rk3288-rock2-square          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 2          =


  Details:     https://kernelci.org/test/plan/id/653a6d1a3d29628f2fefcef6

  Results:     7 PASS, 2 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-rk3288-rock2-square.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-rk3288-rock2-square.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-pm-domain-driver-present: https://kernelci.org=
/test/case/id/653a6d1a3d29628f2fefceff
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:47:41.385277  /lava-11884065/1/../bin/lava-test-case

    2023-10-26T13:47:41.410499  [   12.225830] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-probed RESULT=3Dblocked>

    2023-10-26T13:47:42.432897  /lava-11884065/1/../bin/lava-test-case

    2023-10-26T13:47:42.470941  [   13.286454] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pm-domain-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rk3288-crypto-driver-present: https://kernelci.org/test=
/case/id/653a6d1a3d29628f2fefcf00
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:47:40.277764  /lava-11884065/1/../bin/lava-test-case

    2023-10-26T13:47:40.330756  [   11.143247] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-driver-present RESULT=3Dfail>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                  | regressions
-----------------------------+--------+-----------------+----------+-------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig         | 19         =


  Details:     https://kernelci.org/test/plan/id/653a6d373d29628f2fefcf3a

  Results:     37 PASS, 22 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3596-g73e7f2b880d98/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-pm-domain-driver-present: https://kernelci.org=
/test/case/id/653a6d373d29628f2fefcf43
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:48:19.304514  /lava-11884067/1/../bin/lava-test-case

    2023-10-26T13:48:19.342078  [   48.844453] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-probed RESULT=3Dblocked>

    2023-10-26T13:48:20.364154  /lava-11884067/1/../bin/lava-test-case
   =


  * baseline.bootrr.rk3288-crypto-driver-present: https://kernelci.org/test=
/case/id/653a6d373d29628f2fefcf44
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:48:17.124536  [   46.626930] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vopl-probed RESULT=3Dfail>

    2023-10-26T13:48:18.210183  /lava-11884067/1/../bin/lava-test-case

    2023-10-26T13:48:18.249124  [   47.751304] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-vopl-probed: https://kernelci.org/test/case/id=
/653a6d373d29628f2fefcf45
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:48:16.064869  [   45.567379] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vopb-probed RESULT=3Dfail>

    2023-10-26T13:48:17.085055  /lava-11884067/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-vopb-probed: https://kernelci.org/test/case/id=
/653a6d373d29628f2fefcf46
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:48:14.978539  [   44.480425] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vop-driver-present RESULT=3Dpass>

    2023-10-26T13:48:16.030609  /lava-11884067/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb-phy-grf-probed: https://kernelci.org/test/=
case/id/653a6d373d29628f2fefcf48
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:48:13.838414  [   43.339890] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb-phy-driver-present RESULT=3Dpass>

    2023-10-26T13:48:14.856400  /lava-11884067/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-pwm0-probed: https://kernelci.org/test/case/id=
/653a6d373d29628f2fefcf50
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:48:12.584593  [   42.086355] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pwm-driver-present RESULT=3Dpass>

    2023-10-26T13:48:13.619457  /lava-11884067/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-iodomain-driver-present: https://kernelci.org/=
test/case/id/653a6d373d29628f2fefcf52
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:48:10.280634  /lava-11884067/1/../bin/lava-test-case

    2023-10-26T13:48:10.319585  [   39.821827] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-i2s-probed RESULT=3Dblocked>

    2023-10-26T13:48:11.375457  /lava-11884067/1/../bin/lava-test-case

    2023-10-26T13:48:11.415859  [   40.917551] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-iodomain-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rockcip-i2s-driver-present: https://kernelci.org/test/c=
ase/id/653a6d373d29628f2fefcf53
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:48:08.117211  /lava-11884067/1/../bin/lava-test-case

    2023-10-26T13:48:08.156964  [   37.658769] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-phy-grf-probed RESULT=3Dblocked>

    2023-10-26T13:48:09.212825  /lava-11884067/1/../bin/lava-test-case

    2023-10-26T13:48:09.251873  [   38.753958] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockcip-i2s-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-dp-phy-driver-present: https://kernelci.org/te=
st/case/id/653a6d373d29628f2fefcf54
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:48:04.913926  [   34.415503] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-driver-present RESULT=3Dfail>

    2023-10-26T13:48:05.963050  /lava-11884067/1/../bin/lava-test-case

    2023-10-26T13:48:06.001855  [   35.503656] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-edp-probed RESULT=3Dblocked>

    2023-10-26T13:48:07.057645  /lava-11884067/1/../bin/lava-test-case

    2023-10-26T13:48:07.095423  [   36.597230] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-phy-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-dp-driver-present: https://kernelci.org/test/c=
ase/id/653a6d373d29628f2fefcf55
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:48:03.831881  [   33.333857] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vpu_mmu-probed RESULT=3Dfail>

    2023-10-26T13:48:04.874764  /lava-11884067/1/../bin/lava-test-case
   =


  * baseline.bootrr.rk_iommu-vpu_mmu-probed: https://kernelci.org/test/case=
/id/653a6d373d29628f2fefcf56
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:48:02.729867  [   32.231704] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vopl_mmu-probed RESULT=3Dfail>

    2023-10-26T13:48:03.793329  /lava-11884067/1/../bin/lava-test-case
   =


  * baseline.bootrr.rk_iommu-vopl_mmu-probed: https://kernelci.org/test/cas=
e/id/653a6d373d29628f2fefcf57
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:48:02.690769  /lava-11884067/1/../bin/lava-test-case
   =


  * baseline.bootrr.rk_iommu-vopb_mmu-probed: https://kernelci.org/test/cas=
e/id/653a6d373d29628f2fefcf58
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:48:00.578831  [   30.080874] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-driver-present RESULT=3Dpass>

    2023-10-26T13:48:01.596879  /lava-11884067/1/../bin/lava-test-case

    2023-10-26T13:48:01.636150  [   31.138213] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vopb_mmu-probed RESULT=3Dfail>
   =


  * baseline.bootrr.ramoops-driver-present: https://kernelci.org/test/case/=
id/653a6d373d29628f2fefcf60
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:47:58.155782  [   27.656670] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dehci-platform-usb_host0_ehci-probed RESULT=3Dpass>

    2023-10-26T13:47:59.169479  /lava-11884067/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwhdmi-rockchip-probed: https://kernelci.org/test/case/=
id/653a6d373d29628f2fefcf69
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:47:55.695497  [   25.196647] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-driver-present RESULT=3Dpass>

    2023-10-26T13:47:56.713499  /lava-11884067/1/../bin/lava-test-case
   =


  * baseline.bootrr.dw_wdt-driver-present: https://kernelci.org/test/case/i=
d/653a6d373d29628f2fefcf6e
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:47:53.478499  [   22.980574] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddw-apb-uart2-probed RESULT=3Dpass>

    2023-10-26T13:47:54.494820  /lava-11884067/1/../bin/lava-test-case
   =


  * baseline.bootrr.cros-ec-keyb-probed: https://kernelci.org/test/case/id/=
653a6d373d29628f2fefcf73
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:47:52.230077  [   21.731324] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-keyb-driver-present RESULT=3Dpass>

    2023-10-26T13:47:53.263346  /lava-11884067/1/../bin/lava-test-case
   =


  * baseline.bootrr.cros-ec-i2c-tunnel-driver-present: https://kernelci.org=
/test/case/id/653a6d373d29628f2fefcf75
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:47:48.877863  [   18.379118] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-dev-driver-present RESULT=3Dfail>

    2023-10-26T13:47:49.924726  /lava-11884067/1/../bin/lava-test-case

    2023-10-26T13:47:49.964378  [   19.466184] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-dev-probed RESULT=3Dblocked>

    2023-10-26T13:47:51.021230  /lava-11884067/1/../bin/lava-test-case
   =


  * baseline.bootrr.cros-ec-dev-driver-present: https://kernelci.org/test/c=
ase/id/653a6d373d29628f2fefcf76
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-26T13:47:47.819111  [   17.321107] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtpm-chip-is-online RESULT=3Dskip>

    2023-10-26T13:47:48.837791  /lava-11884067/1/../bin/lava-test-case
   =

 =20


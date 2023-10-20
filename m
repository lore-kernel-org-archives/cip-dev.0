Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B326AC001DF
	for <webhook@archiver.kernel.org>; Fri, 20 Oct 2023 18:09:20 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.61829.1697825351409161678
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 20 Oct 2023 11:09:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=G1TGVleu;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so1075715b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 20 Oct 2023 11:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697825350; x=1698430150; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zo1KoRcxSmONS0BTfQCYfaeUCfQolM46pph8lD/o0NM=;
        b=G1TGVleuGd0aoQiEvA/6JIIvR69o+G10cORisbOOK+fIEJKykKjF/Qop5NbDZab1Rf
         uzVQACP0EXk+ulRNdcxG4TCcsGsvyYt6t/i9ZEkuFgDEG2/3B8nw4ZKKEAzdt/LAhcVa
         YyKqPSHSAqggQrfGicUk8OKwtRchBrgM0wD5uuyMP6ZpicM93+styIkDmAg8wxhS/CSP
         fYbywrPU5enrkxz8//4jWMjxWe5X4Ien/MTAPl/PQS/Qsg6bNL2m2/IFlrpWVS8D1eF5
         TleKQPZ25zBuHrf1C2EFkdFd7J+5OBOjXe+vggRS716fSyszkB1zOzqO4F8h5PE0YJVZ
         FIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697825350; x=1698430150;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zo1KoRcxSmONS0BTfQCYfaeUCfQolM46pph8lD/o0NM=;
        b=MulG+SqKefITVCyY6GU/MJTE8PjkawjmHunAKcoZtqwkimjTr6IBZLU7UFhENt1RZX
         MrRPXuh5BEs0ew0nNiDaEb/18kE21BdVLbrauxC/aBOGFrgwVLDqUTMuW8Y8fs3w289W
         0jD6ERzK7Cj769KWzyL5Fs4xmrHWcsMs0BAuGNk5luqBZNi6POiScNu4aCzqoqdSjwwn
         g7Tsv8oGbtfjYDXjCSk9G324124nMxdtrgcKY9BNv+QafCjZzXryycNuRFT5QpvM9pgv
         zkx7KaqYCbVGYvq4YcDRvteXJN9lk1FHP8bKObZqtEHKP2JIXvDrErDhjsS/wAebTEGC
         sRQg==
X-Gm-Message-State: AOJu0Yzf8qa4Bu6N5aGYjBxzjwdFcyfEh0vwmIyePqcOYq6mTo3fsMpp
	DIquMqNbVcRs1lWL1edatR8Rvvd8vPnE/sVmwtF96A==
X-Google-Smtp-Source: AGHT+IEWCfbPiBaJorScD7Nn1GbXKn3MLkd1AzqVwHG62fVSTVtwJP8iJlRIgxzxdbqAgwVg4ZGUYg==
X-Received: by 2002:a05:6a20:da87:b0:14c:c393:692 with SMTP id iy7-20020a056a20da8700b0014cc3930692mr2958392pzb.7.1697825348929;
        Fri, 20 Oct 2023 11:09:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fb22-20020a056a002d9600b006be17e60708sm1824412pfb.204.2023.10.20.11.09.07
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:09:08 -0700 (PDT)
Message-ID: <6532c244.050a0220.2eed6.6df6@mx.google.com>
Date: Fri, 20 Oct 2023 11:09:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4.302-cip78-rt45-338-gf468de833aa13
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline: 70 runs,
 120 regressions (v4.4.302-cip78-rt45-338-gf468de833aa13)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Oct 2023 18:09:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13423

cip-gitlab/ci/pavel/linux-test baseline: 70 runs, 120 regressions (v4.4.302=
-cip78-rt45-338-gf468de833aa13)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

acer-chromebox-cxi4-puff     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

acer-cp514-3wh-r0qs-guybrush | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig            | 10         =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 13         =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 13         =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 15         =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 15         =

dell-latitude...4305U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

dell-latitude...8665U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx28-duckbill               | arm    | lab-pengutronix | gcc-10   | mxs_de=
fconfig                | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

odroid-xu3                   | arm    | lab-collabora   | gcc-10   | exynos=
_defconfig             | 1          =

qemu_arm-virt-gicv2          | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_arm-virt-gicv2          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_arm-virt-gicv2-uefi     | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_arm-virt-gicv2-uefi     | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_arm-virt-gicv3          | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_arm-virt-gicv3          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_arm-virt-gicv3-uefi     | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_arm-virt-gicv3-uefi     | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig              | 1          =

qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defconfig             | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig             | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

rk3288-rock2-square          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 2          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 22         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip78-rt45-338-gf468de833aa13/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip78-rt45-338-gf468de833aa13
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f468de833aa13aa639d147055db4edf9931b6811 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bc542602864e42efcf05

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532bc542602864e42efc=
f06
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bc462602864e42efcf00

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532bc462602864e42efc=
f01
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bc6fc09f717ae8efcf0c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532bc6fc09f717ae8efc=
f0d
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cp514-3wh-r0qs-guybrush | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bc72c09f717ae8efcf0f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-acer-cp514-3wh-r0qs-guybrush.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-acer-cp514-3wh-r0qs-guybrush.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532bc72c09f717ae8efc=
f10
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bd44dc8c29222cefcff4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532bd44dc8c29222cefc=
ff5
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bc53c09f717ae8efcefe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532bc53c09f717ae8efc=
eff
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bc702146c997c3efcf3e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532bc702146c997c3efc=
f3f
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig            | 10         =


  Details:     https://kernelci.org/test/plan/id/6532bbc8d7194f3dafefcf22

  Results:     36 PASS, 11 FAIL, 2 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/at91_dt_defconfig/gcc-10/lab-br=
oonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/at91_dt_defconfig/gcc-10/lab-br=
oonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/653=
2bbc8d7194f3dafefcf2b
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-20T17:41:12.616635  /lava-181891/1/../bin/lava-test-case   =


  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/6532bbc8d=
7194f3dafefcf31
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:41:11.935904  random: nonblocking pool is initialized
    2023-10-20T17:41:12.249683  /lava-181891/1/../bin/lava-test-case   =


  * baseline.bootrr.audio-card-probed: https://kernelci.org/test/case/id/65=
32bbc8d7194f3dafefcf32
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:41:11.171451  /lava-181891/1/../bin/lava-test-case   =


  * baseline.bootrr.wm8731-driver-present: https://kernelci.org/test/case/i=
d/6532bbc8d7194f3dafefcf36
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-20T17:41:07.679473  /lava-181891/1/../bin/lava-test-case
    2023-10-20T17:41:07.748376  sh: /sys/bus/spi/drivers/wm8731: unknown op=
erand
    2023-10-20T17:41:08.765428  /lava-181891/1/../bin/lava-test-case   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
6532bbc8d7194f3dafefcf37
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-20T17:41:06.593564  /lava-181891/1/../bin/lava-test-case   =


  * baseline.bootrr.i2c0-probed: https://kernelci.org/test/case/id/6532bbc8=
d7194f3dafefcf38
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:41:05.507629  /lava-181891/1/../bin/lava-test-case   =


  * baseline.bootrr.atmel-nand-driver-present: https://kernelci.org/test/ca=
se/id/6532bbc8d7194f3dafefcf4c
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:40:58.617385  /lava-181891/1/../bin/lava-test-case
    2023-10-20T17:40:59.703217  /lava-181891/1/../bin/lava-test-case   =


  * baseline.bootrr.atmel-ebi-driver-present: https://kernelci.org/test/cas=
e/id/6532bbc8d7194f3dafefcf4d
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:40:57.531411  /lava-181891/1/../bin/lava-test-case   =


  * baseline.bootrr.atmel-usart-serial-driver-present: https://kernelci.org=
/test/case/id/6532bbc8d7194f3dafefcf51
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:40:53.039436  /lava-181891/1/../bin/lava-test-case   =


  * baseline.bootrr.at91-usart-mode-driver-present: https://kernelci.org/te=
st/case/id/6532bbc8d7194f3dafefcf52
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:40:51.953490  /lava-181891/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 13         =


  Details:     https://kernelci.org/test/plan/id/6532bb8478ca84163cefcef6

  Results:     15 PASS, 21 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-b=
roonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-b=
roonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/6532bb8478ca8416=
3cefcefb
        new failure (last pass: v5.10.194-557-g2932db67f070a)
        1 lines

    2023-10-20T17:39:20.416786  / # =

    2023-10-20T17:39:20.421594  =

    2023-10-20T17:39:20.528854  / # #
    2023-10-20T17:39:20.534406  #
    2023-10-20T17:39:20.636782  / # export SHELL=3D/bin/sh
    2023-10-20T17:39:20.642338  export SHELL=3D/bin/sh
    2023-10-20T17:39:20.744205  / # . /lava-181852/environment
    2023-10-20T17:39:20.749952  . /lava-181852/environment
    2023-10-20T17:39:20.852130  / # /lava-181852/bin/lava-test-runner /lava=
-181852/0
    2023-10-20T17:39:20.857416  /lava-181852/bin/lava-test-runner /lava-181=
852/0 =

    ... (9 line(s) more)  =


  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/6532bb847=
8ca84163cefcefd
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-20T17:39:58.657853  /lava-181852/1/../bin/lava-test-case
    2023-10-20T17:39:58.675121  [   48.782041] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-10-20T17:39:59.697791  /lava-181852/1/../bin/lava-test-case
    2023-10-20T17:39:59.714238  [   49.822123] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.simple-audio-driver-present: https://kernelci.org/test/=
case/id/6532bb8478ca84163cefcefe
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:39:56.600499  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found
    2023-10-20T17:39:57.614862  /lava-181852/1/../bin/lava-test-case
    2023-10-20T17:39:57.633153  [   47.740152] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/6532bb8478ca84163cefceff
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-20T17:39:55.532278  /lava-181852/1/../bin/lava-test-case
    2023-10-20T17:39:55.549403  [   45.656572] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-10-20T17:39:56.573147  /lava-181852/1/../bin/lava-test-case
    2023-10-20T17:39:56.592994  [   46.697461] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
6532bb8478ca84163cefcf00
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-20T17:39:53.450100  /lava-181852/1/../bin/lava-test-case
    2023-10-20T17:39:53.467230  [   43.573876] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-10-20T17:39:54.490925  /lava-181852/1/../bin/lava-test-case
    2023-10-20T17:39:54.508115  [   44.615038] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/6532bb8478ca84163cefcf01
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-20T17:39:51.368293  /lava-181852/1/../bin/lava-test-case
    2023-10-20T17:39:51.385064  [   41.491781] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-10-20T17:39:52.408598  /lava-181852/1/../bin/lava-test-case
    2023-10-20T17:39:52.426370  [   42.532311] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/6532bb8478ca84163cefcf0b
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:39:38.715614  /lava-181852/1/../bin/lava-test-case
    2023-10-20T17:39:38.732748  [   28.838187] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-10-20T17:39:39.756720  /lava-181852/1/../bin/lava-test-case
    2023-10-20T17:39:39.774638  [   29.879458] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/6532bb8478ca84163cefcf0c
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-20T17:39:37.674113  /lava-181852/1/../bin/lava-test-case
    2023-10-20T17:39:37.691865  [   27.796626] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.am335x-phy-driver-present: https://kernelci.org/test/ca=
se/id/6532bb8478ca84163cefcf0f
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:39:33.429937  /lava-181852/1/../bin/lava-test-case
    2023-10-20T17:39:33.447781  [   23.552313] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb0-musb-dsps-probed RESULT=3Dblocked>
    2023-10-20T17:39:34.471668  /lava-181852/1/../bin/lava-test-case
    2023-10-20T17:39:34.489225  [   24.593871] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb1-musb-dsps-probed RESULT=3Dblocked>
    2023-10-20T17:39:35.512949  /lava-181852/1/../bin/lava-test-case
    2023-10-20T17:39:35.529945  [   25.635489] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dam335x-phy-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.musb-dsps-driver-present: https://kernelci.org/test/cas=
e/id/6532bb8478ca84163cefcf10
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:39:30.306795  /lava-181852/1/../bin/lava-test-case
    2023-10-20T17:39:30.323229  [   20.428780] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc0-probed RESULT=3Dblocked>
    2023-10-20T17:39:31.347503  /lava-181852/1/../bin/lava-test-case
    2023-10-20T17:39:31.364275  [   21.469614] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc1-probed RESULT=3Dblocked>
    2023-10-20T17:39:32.388162  /lava-181852/1/../bin/lava-test-case
    2023-10-20T17:39:32.405901  [   22.510557] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmusb-dsps-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sdhci-omap-driver-present: https://kernelci.org/test/ca=
se/id/6532bb8478ca84163cefcf11
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:39:29.264901  /lava-181852/1/../bin/lava-test-case
    2023-10-20T17:39:29.282751  [   19.387055] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/6532bb8478ca84163cefcf17
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:39:22.760131  /lava-181852/1/../bin/lava-test-case
    2023-10-20T17:39:22.777836  [   12.881732] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tps65217-driver-present: https://kernelci.org/test/case=
/id/6532bb8478ca84163cefcf1e
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:39:24.963694  /lava-181852/1/../bin/lava-test-case
    2023-10-20T17:39:24.981269  [   15.085479] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtps65217-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 13         =


  Details:     https://kernelci.org/test/plan/id/6532bc4aaef82eddb8efcf23

  Results:     15 PASS, 21 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-c=
ip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-c=
ip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/6532bc4aaef82edd=
b8efcf28
        new failure (last pass: v5.10.194-557-g2932db67f070a)
        1 lines

    2023-10-20T17:42:52.452305  / # =

    2023-10-20T17:42:52.459184  =

    2023-10-20T17:42:52.562219  / # #
    2023-10-20T17:42:52.568351  #
    2023-10-20T17:42:52.669524  / # export SHELL=3D/bin/sh
    2023-10-20T17:42:52.675744  export SHELL=3D/bin/sh
    2023-10-20T17:42:52.776767  / # . /lava-1023193/environment
    2023-10-20T17:42:52.783339  . /lava-1023193/environment
    2023-10-20T17:42:52.884241  / # /lava-1023193/bin/lava-test-runner /lav=
a-1023193/0
    2023-10-20T17:42:52.891024  /lava-1023193/bin/lava-test-runner /lava-10=
23193/0 =

    ... (9 line(s) more)  =


  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/6532bc4aa=
ef82eddb8efcf2a
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-20T17:43:30.665193  /lava-1023193/1/../bin/lava-test-case
    2023-10-20T17:43:30.682077  [   45.907512] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-10-20T17:43:31.705851  /lava-1023193/1/../bin/lava-test-case
    2023-10-20T17:43:31.721877  [   46.947276] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.simple-audio-driver-present: https://kernelci.org/test/=
case/id/6532bc4aaef82eddb8efcf2b
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:43:28.608297  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found
    2023-10-20T17:43:29.624449  /lava-1023193/1/../bin/lava-test-case
    2023-10-20T17:43:29.642730  [   44.866168] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/6532bc4aaef82eddb8efcf2c
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-20T17:43:27.541540  /lava-1023193/1/../bin/lava-test-case
    2023-10-20T17:43:27.558856  [   42.783499] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-10-20T17:43:28.582431  /lava-1023193/1/../bin/lava-test-case
    2023-10-20T17:43:28.601474  [   43.823829] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
6532bc4aaef82eddb8efcf2d
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-20T17:43:25.460508  /lava-1023193/1/../bin/lava-test-case
    2023-10-20T17:43:25.477619  [   40.702163] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-10-20T17:43:26.501049  /lava-1023193/1/../bin/lava-test-case
    2023-10-20T17:43:26.517005  [   41.742624] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/6532bc4aaef82eddb8efcf2e
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-20T17:43:23.379378  /lava-1023193/1/../bin/lava-test-case
    2023-10-20T17:43:23.395263  [   38.620741] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-10-20T17:43:24.420065  /lava-1023193/1/../bin/lava-test-case
    2023-10-20T17:43:24.435992  [   39.661111] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/6532bc4aaef82eddb8efcf37
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:43:10.731655  /lava-1023193/1/../bin/lava-test-case
    2023-10-20T17:43:10.748740  [   25.972800] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-10-20T17:43:11.772136  /lava-1023193/1/../bin/lava-test-case
    2023-10-20T17:43:11.790364  [   27.013556] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/6532bc4aaef82eddb8efcf38
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-20T17:43:09.690099  /lava-1023193/1/../bin/lava-test-case
    2023-10-20T17:43:09.708375  [   24.931502] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.am335x-phy-driver-present: https://kernelci.org/test/ca=
se/id/6532bc4aaef82eddb8efcf3b
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:43:05.447242  /lava-1023193/1/../bin/lava-test-case
    2023-10-20T17:43:05.464218  [   20.688066] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb0-musb-dsps-probed RESULT=3Dblocked>
    2023-10-20T17:43:06.488886  /lava-1023193/1/../bin/lava-test-case
    2023-10-20T17:43:06.507094  [   21.729698] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dusb1-musb-dsps-probed RESULT=3Dblocked>
    2023-10-20T17:43:07.529371  /lava-1023193/1/../bin/lava-test-case
    2023-10-20T17:43:07.547370  [   22.771043] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dam335x-phy-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.musb-dsps-driver-present: https://kernelci.org/test/cas=
e/id/6532bc4aaef82eddb8efcf3c
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:43:02.324585  /lava-1023193/1/../bin/lava-test-case
    2023-10-20T17:43:02.341487  [   17.565962] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc0-probed RESULT=3Dblocked>
    2023-10-20T17:43:03.366144  /lava-1023193/1/../bin/lava-test-case
    2023-10-20T17:43:03.382049  [   18.606481] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmmc1-probed RESULT=3Dblocked>
    2023-10-20T17:43:04.405505  /lava-1023193/1/../bin/lava-test-case
    2023-10-20T17:43:04.423671  [   19.646663] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmusb-dsps-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sdhci-omap-driver-present: https://kernelci.org/test/ca=
se/id/6532bc4aaef82eddb8efcf3d
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:43:01.284368  /lava-1023193/1/../bin/lava-test-case
    2023-10-20T17:43:01.301402  [   16.524324] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tps65217-driver-present: https://kernelci.org/test/case=
/id/6532bc4aaef82eddb8efcf43
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:56.985931  /lava-1023193/1/../bin/lava-test-case
    2023-10-20T17:42:57.002935  [   12.226011] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtps65217-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/6532bc4aaef82eddb8efcf47
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:54.784244  /lava-1023193/1/../bin/lava-test-case
    2023-10-20T17:42:54.800189  [   10.023710] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 15         =


  Details:     https://kernelci.org/test/plan/id/6532bc2caef82eddb8efcef3

  Results:     24 PASS, 17 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/omap2plus_defconfig/gcc-10/lab-=
broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/omap2plus_defconfig/gcc-10/lab-=
broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/6532bc2caef82edd=
b8efcef8
        new failure (last pass: v5.10.194-557-g2932db67f070a)
        1 lines

    2023-10-20T17:42:15.350500  / # =

    2023-10-20T17:42:15.357702  =

    2023-10-20T17:42:15.460566  / # #
    2023-10-20T17:42:15.466799  #
    2023-10-20T17:42:15.568331  / # export SHELL=3D/bin/sh
    2023-10-20T17:42:15.574820  export SHELL=3D/bin/sh
    2023-10-20T17:42:15.676194  / # . /lava-181884/environment
    2023-10-20T17:42:15.682674  . /lava-181884/environment
    2023-10-20T17:42:15.784374  / # /lava-181884/bin/lava-test-runner /lava=
-181884/0
    2023-10-20T17:42:15.795819  /lava-181884/bin/lava-test-runner /lava-181=
884/0 =

    ... (9 line(s) more)  =


  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/6532bc2ca=
ef82eddb8efcefa
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:50.945171  /lava-181884/1/../bin/lava-test-case
    2023-10-20T17:42:51.024800  [   51.874884] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-10-20T17:42:52.144645  /lava-181884/1/../bin/lava-test-case
    2023-10-20T17:42:52.199027  [   53.050866] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.simple-audio-driver-present: https://kernelci.org/test/=
case/id/6532bc2caef82eddb8efcefb
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:48.721887  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found
    2023-10-20T17:42:49.830022  /lava-181884/1/../bin/lava-test-case
    2023-10-20T17:42:49.875265  [   50.725026] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/6532bc2caef82eddb8efcefc
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:47.417658  /lava-181884/1/../bin/lava-test-case
    2023-10-20T17:42:47.497812  [   48.347591] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-10-20T17:42:48.621329  /lava-181884/1/../bin/lava-test-case
    2023-10-20T17:42:48.700318  [   49.550563] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
6532bc2caef82eddb8efcefd
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:45.014239  /lava-181884/1/../bin/lava-test-case
    2023-10-20T17:42:45.093334  [   45.944082] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-10-20T17:42:46.211445  /lava-181884/1/../bin/lava-test-case
    2023-10-20T17:42:46.292642  [   47.141982] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/6532bc2caef82eddb8efcefe
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:42.603250  /lava-181884/1/../bin/lava-test-case
    2023-10-20T17:42:42.682509  [   43.532828] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-10-20T17:42:43.807044  /lava-181884/1/../bin/lava-test-case
    2023-10-20T17:42:43.889226  [   44.739438] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tilcdc-driver-probed: https://kernelci.org/test/case/id=
/6532bc2caef82eddb8efceff
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:41.398382  /lava-181884/1/../bin/lava-test-case
    2023-10-20T17:42:41.477884  [   42.327394] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtilcdc-driver-probed RESULT=3Dfail>   =


  * baseline.bootrr.omap-sham-driver-present: https://kernelci.org/test/cas=
e/id/6532bc2caef82eddb8efcf04
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:38.559959  /lava-181884/1/../bin/lava-test-case
    2023-10-20T17:42:38.641283  [   39.490246] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap-aes-driver-present: https://kernelci.org/test/case=
/id/6532bc2caef82eddb8efcf07
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:35.906443  /lava-181884/1/../bin/lava-test-case
    2023-10-20T17:42:35.987852  [   36.837578] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/6532bc2caef82eddb8efcf0a
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:32.101698  /lava-181884/1/../bin/lava-test-case
    2023-10-20T17:42:32.145901  [   32.995064] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-10-20T17:42:33.249962  /lava-181884/1/../bin/lava-test-case
    2023-10-20T17:42:33.331240  [   34.180189] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/6532bc2caef82eddb8efcf0b
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:30.894932  /lava-181884/1/../bin/lava-test-case
    2023-10-20T17:42:30.976525  [   31.825068] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sdhci-omap-driver-present: https://kernelci.org/test/ca=
se/id/6532bc2caef82eddb8efcf13
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:25.461365  /lava-181884/1/../bin/lava-test-case
    2023-10-20T17:42:25.542710  [   26.391133] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dbaseboard-eeprom-probed RESULT=3Dblocked>
    2023-10-20T17:42:26.668377  /lava-181884/1/../bin/lava-test-case
    2023-10-20T17:42:26.750377  [   27.598719] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
6532bc2caef82eddb8efcf14
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:24.255867  /lava-181884/1/../bin/lava-test-case
    2023-10-20T17:42:24.335537  [   25.184545] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dat24-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.pwrbutton-driver-present: https://kernelci.org/test/cas=
e/id/6532bc2caef82eddb8efcf17
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:21.633728  /lava-181884/1/../bin/lava-test-case
    2023-10-20T17:42:21.712802  [   22.562141] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dpwrbutton-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/6532bc2caef82eddb8efcf1d
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:18.746239  /lava-181884/1/../bin/lava-test-case
    2023-10-20T17:42:18.825820  [   19.674272] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 15         =


  Details:     https://kernelci.org/test/plan/id/6532bfd5a32b85f1e8efcf08

  Results:     24 PASS, 17 FAIL, 2 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/omap2plus_defconfig/gcc-10/lab-=
cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/omap2plus_defconfig/gcc-10/lab-=
cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/6532bfd5a32b85f1=
e8efcf0d
        new failure (last pass: v5.10.194-557-g2932db67f070a)
        1 lines

    2023-10-20T17:58:04.595639  / # =

    2023-10-20T17:58:04.602357  =

    2023-10-20T17:58:04.705644  / # #
    2023-10-20T17:58:04.711124  #
    2023-10-20T17:58:04.812343  / # export SHELL=3D/bin/sh
    2023-10-20T17:58:04.817760  export SHELL=3D/bin/sh
    2023-10-20T17:58:04.918711  / # . /lava-1023209/environment
    2023-10-20T17:58:04.926390  . /lava-1023209/environment
    2023-10-20T17:58:05.027390  / # /lava-1023209/bin/lava-test-runner /lav=
a-1023209/0
    2023-10-20T17:58:05.032471  /lava-1023209/bin/lava-test-runner /lava-10=
23209/0 =

    ... (9 line(s) more)  =


  * baseline.bootrr.simple-audio-driver-present: https://kernelci.org/test/=
case/id/6532bfd5a32b85f1e8efcf0f
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:58:36.662718  /opt/bootrr/libexec/bootrr/boards/ti,am335x=
-bone-black: line 84: assert_device-present: not found
    2023-10-20T17:58:37.717871  /lava-1023209/1/../bin/lava-test-case
    2023-10-20T17:58:37.762395  [   42.928531] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsimple-audio-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/6532bfd5a32b85f1e8efcf10
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:58:35.401017  /lava-1023209/1/../bin/lava-test-case
    2023-10-20T17:58:35.479817  [   40.646770] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-10-20T17:58:36.603108  /lava-1023209/1/../bin/lava-test-case
    2023-10-20T17:58:36.648411  [   41.814755] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
6532bfd5a32b85f1e8efcf11
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:58:33.000154  /lava-1023209/1/../bin/lava-test-case
    2023-10-20T17:58:33.081256  [   38.247897] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-10-20T17:58:34.196969  /lava-1023209/1/../bin/lava-test-case
    2023-10-20T17:58:34.276080  [   39.442719] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/6532bfd5a32b85f1e8efcf12
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:58:30.623617  /lava-1023209/1/../bin/lava-test-case
    2023-10-20T17:58:30.703354  [   35.870213] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-10-20T17:58:31.827164  /lava-1023209/1/../bin/lava-test-case
    2023-10-20T17:58:31.865903  [   37.032183] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tilcdc-driver-probed: https://kernelci.org/test/case/id=
/6532bfd5a32b85f1e8efcf13
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:58:29.544514  /lava-1023209/1/../bin/lava-test-case
    2023-10-20T17:58:29.575218  [   34.741595] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtilcdc-driver-probed RESULT=3Dfail>   =


  * baseline.bootrr.omap-sham-driver-present: https://kernelci.org/test/cas=
e/id/6532bfd5a32b85f1e8efcf18
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:58:26.830538  /lava-1023209/1/../bin/lava-test-case
    2023-10-20T17:58:26.861469  [   32.027612] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap-aes-driver-present: https://kernelci.org/test/case=
/id/6532bfd5a32b85f1e8efcf1b
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:58:24.303632  /lava-1023209/1/../bin/lava-test-case
    2023-10-20T17:58:24.383761  [   29.549672] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/6532bfd5a32b85f1e8efcf1e
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:58:20.698693  /lava-1023209/1/../bin/lava-test-case
    2023-10-20T17:58:20.736718  [   25.902679] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-10-20T17:58:21.795765  /lava-1023209/1/../bin/lava-test-case
    2023-10-20T17:58:21.840240  [   27.005640] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/6532bfd5a32b85f1e8efcf1f
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:58:19.491421  /lava-1023209/1/../bin/lava-test-case
    2023-10-20T17:58:19.574587  [   24.739855] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sdhci-omap-driver-present: https://kernelci.org/test/ca=
se/id/6532bfd5a32b85f1e8efcf23
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:58:14.341371  /lava-1023209/1/../bin/lava-test-case
    2023-10-20T17:58:14.421426  [   19.586499] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dbaseboard-eeprom-probed RESULT=3Dblocked>
    2023-10-20T17:58:15.543289  /lava-1023209/1/../bin/lava-test-case
    2023-10-20T17:58:15.588260  [   20.753588] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dsdhci-omap-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
6532bfd5a32b85f1e8efcf24
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:58:13.136999  /lava-1023209/1/../bin/lava-test-case
    2023-10-20T17:58:13.218192  [   18.383910] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dat24-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.pwrbutton-driver-present: https://kernelci.org/test/cas=
e/id/6532bfd5a32b85f1e8efcf27
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:58:10.532398  /lava-1023209/1/../bin/lava-test-case
    2023-10-20T17:58:10.614570  [   15.779640] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dpwrbutton-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/6532bfd5a32b85f1e8efcf2d
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:58:07.753472  /lava-1023209/1/../bin/lava-test-case
    2023-10-20T17:58:07.832664  [   12.997750] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/6532bfd5a=
32b85f1e8efcf35
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:58:38.830187  /lava-1023209/1/../bin/lava-test-case
    2023-10-20T17:58:38.891013  [   44.057737] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio-probed RESULT=3Dblocked>
    2023-10-20T17:58:40.009143  /lava-1023209/1/../bin/lava-test-case
    2023-10-20T17:58:40.088483  [   45.256271] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dhdmi-audio RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
dell-latitude...4305U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bc605ada5e855eefcf0d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-dell-latitude-5400-4305U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-dell-latitude-5400-4305U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532bc605ada5e855eefc=
f0e
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bd9fb68c6850c5efcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-dell-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-dell-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532bd9fb68c6850c5efc=
ef4
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bd4f982971d5ffefcf00

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532bd4f982971d5ffefc=
f01
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bc653a1a159708efcf21

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532bc653a1a159708efc=
f22
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx28-duckbill               | arm    | lab-pengutronix | gcc-10   | mxs_de=
fconfig                | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bade21349170b2efcef4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: mxs_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/mxs_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx28-duckbill.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/mxs_defconfig/gcc-10/lab-pengut=
ronix/baseline-imx28-duckbill.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532bade21349170b2efc=
ef5
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bb0442adea9f2eefcef3

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/imx_v6_v7_defconfig/gcc-10/lab-=
nxp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/imx_v6_v7_defconfig/gcc-10/lab-=
nxp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
6532bb0442adea9f2eefcefb
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-20T17:37:55.485955  /lava-1254850/1/../bin/lava-test-case
    2023-10-20T17:37:55.486225  [   26.028900] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dall-cpus-are-online RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bb50c76a1f7074efcf44

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-n=
xp/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-n=
xp/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
6532bb50c76a1f7074efcf4c
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-20T17:39:16.707276  /lava-1254852/1/../bin/lava-test-case
    2023-10-20T17:39:16.707693  [   25.792978] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dall-cpus-are-online RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
odroid-xu3                   | arm    | lab-collabora   | gcc-10   | exynos=
_defconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bbb4b351456b0aefcf16

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: exynos_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/exynos_defconfig/gcc-10/lab-col=
labora/baseline-odroid-xu3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/exynos_defconfig/gcc-10/lab-col=
labora/baseline-odroid-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
6532bbb4b351456b0aefcf1e
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:45:14.049094  /lava-11831912/1/../bin/lava-test-case

    2023-10-20T17:45:14.065372  [   13.370614] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dall-cpus-are-online RESULT=3Dfail>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv2          | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bb9278ca84163cefcf4d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532bb9278ca84163cefc=
f4e
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv2          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bb48c76a1f7074efcf28

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-c=
ollabora/baseline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-c=
ollabora/baseline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532bb48c76a1f7074efc=
f29
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv2-uefi     | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bc45c09f717ae8efcef9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532bc45c09f717ae8efc=
efa
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv2-uefi     | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bc245ada5e855eefcefc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-c=
ollabora/baseline-qemu_arm-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-c=
ollabora/baseline-qemu_arm-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532bc245ada5e855eefc=
efd
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bb91e9b9602e57efcefb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532bb91e9b9602e57efc=
efc
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv3          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bb49c76a1f7074efcf2b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-c=
ollabora/baseline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-c=
ollabora/baseline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532bb49c76a1f7074efc=
f2c
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv3-uefi     | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bc595ada5e855eefcf0a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-b=
roonie/baseline-qemu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532bc595ada5e855eefc=
f0b
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm-virt-gicv3-uefi     | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bc39c09f717ae8efcef6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-c=
ollabora/baseline-qemu_arm-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-c=
ollabora/baseline-qemu_arm-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532bc39c09f717ae8efc=
ef7
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bb1b21349170b2efcf35

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/mips/malta_defconfig/gcc-10/lab-bro=
onie/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/mips/malta_defconfig/gcc-10/lab-bro=
onie/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532bb1b21349170b2efc=
f36
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/6532babd4c6462c47eefcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/mips/malta_defconfig/gcc-10/lab-col=
labora/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/mips/malta_defconfig/gcc-10/lab-col=
labora/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532babd4c6462c47eefc=
ef4
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bce71ccd7cdce3efcefb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532bce71ccd7cdce3efc=
efc
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bd5ee20268a247efcf12

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig/gcc-10/lab-=
broonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig/gcc-10/lab-=
broonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532bd5ee20268a247efc=
f13
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bc9c7ef55e8ddeefcf05

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532bc9c7ef55e8ddeefc=
f06
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bc9d2146c997c3efcf49

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig/gcc-10/lab-=
collabora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig/gcc-10/lab-=
collabora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532bc9d2146c997c3efc=
f4a
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bc282146c997c3efcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/shmobile_defconfig/gcc-10/lab-c=
ip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/shmobile_defconfig/gcc-10/lab-c=
ip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532bc282146c997c3efc=
ef4
        failing since 30 days (last pass: v6.1.52-cip5-29-g9fee06894d496, f=
irst fail: v5.10.194-cip39-500-gc5c4e5fc16817) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-rock2-square          | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/6532bb1421349170b2efcf22

  Results:     7 PASS, 2 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-c=
ollabora/baseline-rk3288-rock2-square.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-c=
ollabora/baseline-rk3288-rock2-square.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-pm-domain-driver-present: https://kernelci.org=
/test/case/id/6532bb1421349170b2efcf2b
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:29.745208  /lava-11831802/1/../bin/lava-test-case

    2023-10-20T17:42:29.776984  [   14.848569] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-probed RESULT=3Dblocked>

    2023-10-20T17:42:30.799527  /lava-11831802/1/../bin/lava-test-case

    2023-10-20T17:42:30.852538  [   15.922552] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pm-domain-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rk3288-crypto-driver-present: https://kernelci.org/test=
/case/id/6532bb1421349170b2efcf2c
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:28.663689  /lava-11831802/1/../bin/lava-test-case

    2023-10-20T17:42:28.707010  [   13.778254] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-driver-present RESULT=3Dfail>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 22         =


  Details:     https://kernelci.org/test/plan/id/6532bb3d14d0871f99efcf2a

  Results:     37 PASS, 22 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-c=
ollabora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/arm/multi_v7_defconfig/gcc-10/lab-c=
ollabora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-pm-domain-driver-present: https://kernelci.org=
/test/case/id/6532bb3d14d0871f99efcf33
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:43:03.295946  [   46.036299] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-driver-present RESULT=3Dfail>

    2023-10-20T17:43:04.353399  /lava-11831803/1/../bin/lava-test-case

    2023-10-20T17:43:04.392139  [   47.133103] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk3288-crypto-probed RESULT=3Dblocked>

    2023-10-20T17:43:05.435282  /lava-11831803/1/../bin/lava-test-case
   =


  * baseline.bootrr.rk3288-crypto-driver-present: https://kernelci.org/test=
/case/id/6532bb3d14d0871f99efcf34
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:43:03.255055  /lava-11831803/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-vopl-probed: https://kernelci.org/test/case/id=
/6532bb3d14d0871f99efcf35
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:43:02.159429  /lava-11831803/1/../bin/lava-test-case

    2023-10-20T17:43:02.198491  [   44.939935] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vopl-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-vopb-probed: https://kernelci.org/test/case/id=
/6532bb3d14d0871f99efcf36
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:43:01.087952  /lava-11831803/1/../bin/lava-test-case

    2023-10-20T17:43:01.114930  [   43.856214] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-vopb-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb-phy-grf-probed: https://kernelci.org/test/=
case/id/6532bb3d14d0871f99efcf38
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:58.962871  [   41.702907] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb-phy-driver-present RESULT=3Dpass>

    2023-10-20T17:42:59.982819  /lava-11831803/1/../bin/lava-test-case

    2023-10-20T17:43:00.022403  [   42.762924] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb-phy-grf-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-pwm0-probed: https://kernelci.org/test/case/id=
/6532bb3d14d0871f99efcf40
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:57.711985  [   40.452233] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-pwm-driver-present RESULT=3Dpass>

    2023-10-20T17:42:58.757387  /lava-11831803/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-iodomain-driver-present: https://kernelci.org/=
test/case/id/6532bb3d14d0871f99efcf42
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:55.477352  /lava-11831803/1/../bin/lava-test-case

    2023-10-20T17:42:55.516746  [   38.257400] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-i2s-probed RESULT=3Dblocked>

    2023-10-20T17:42:56.572747  /lava-11831803/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockcip-i2s-driver-present: https://kernelci.org/test/c=
ase/id/6532bb3d14d0871f99efcf43
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:52.252110  [   34.992001] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-phy-driver-present RESULT=3Dfail>

    2023-10-20T17:42:53.286715  /lava-11831803/1/../bin/lava-test-case

    2023-10-20T17:42:53.325627  [   36.065444] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-phy-grf-probed RESULT=3Dblocked>

    2023-10-20T17:42:54.380607  /lava-11831803/1/../bin/lava-test-case

    2023-10-20T17:42:54.420622  [   37.161288] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockcip-i2s-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-dp-phy-driver-present: https://kernelci.org/te=
st/case/id/6532bb3d14d0871f99efcf44
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:50.106263  [   32.846556] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-driver-present RESULT=3Dfail>

    2023-10-20T17:42:51.132040  /lava-11831803/1/../bin/lava-test-case

    2023-10-20T17:42:51.172056  [   33.912627] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-dp-edp-probed RESULT=3Dblocked>

    2023-10-20T17:42:52.212323  /lava-11831803/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-dp-driver-present: https://kernelci.org/test/c=
ase/id/6532bb3d14d0871f99efcf45
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:49.028514  [   31.768980] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vpu_mmu-probed RESULT=3Dfail>

    2023-10-20T17:42:50.082119  /lava-11831803/1/../bin/lava-test-case
   =


  * baseline.bootrr.rk_iommu-vpu_mmu-probed: https://kernelci.org/test/case=
/id/6532bb3d14d0871f99efcf46
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:47.923074  [   30.663488] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vopl_mmu-probed RESULT=3Dfail>

    2023-10-20T17:42:48.989806  /lava-11831803/1/../bin/lava-test-case
   =


  * baseline.bootrr.rk_iommu-vopl_mmu-probed: https://kernelci.org/test/cas=
e/id/6532bb3d14d0871f99efcf47
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:46.850196  [   29.590555] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-vopb_mmu-probed RESULT=3Dfail>

    2023-10-20T17:42:47.883217  /lava-11831803/1/../bin/lava-test-case
   =


  * baseline.bootrr.rk_iommu-vopb_mmu-probed: https://kernelci.org/test/cas=
e/id/6532bb3d14d0871f99efcf48
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:45.804385  [   28.544882] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drk_iommu-driver-present RESULT=3Dpass>

    2023-10-20T17:42:46.824622  /lava-11831803/1/../bin/lava-test-case
   =


  * baseline.bootrr.ramoops-driver-present: https://kernelci.org/test/case/=
id/6532bb3d14d0871f99efcf50
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:43.442317  [   26.181570] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dehci-platform-usb_host0_ehci-probed RESULT=3Dpass>

    2023-10-20T17:42:44.455781  /lava-11831803/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/6532bb3d14d0871f99efcf54
        failing since 16 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-20T17:42:42.289286  [   25.029332] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dpass>

    2023-10-20T17:42:43.307259  /lava-11831803/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6532bb3d14d0871f99efcf57
        failing since 273 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-10-20T17:42:42.177957  	-s SE[   24.912032] <LAVA_SIGNAL_TESTCASE =
TEST_CASE_ID=3Ddwhdmi-rockchip-driver-audio-present RESULT=3Dfail>

    2023-10-20T17:42:42.179577  P	String separator

    2023-10-20T17:42:42.183229  /lava-11831803/1/../bin/lava-test-case

    2023-10-20T17:42:42.198005  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-10-20T17:42:42.198241  =


    2023-10-20T17:42:42.202101  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-10-20T17:42:42.202318  =


    2023-10-20T17:42:42.206669  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-10-20T17:42:42.208978  FIRST, INC default to 1.

    2023-10-20T17:42:42.209194  =

 =

    ... (1 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6532bb3d14d0871f99efcf58
        failing since 273 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-10-20T17:42:42.154452  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-10-20T17:42:42.154610  =


    2023-10-20T17:42:42.158460  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-10-20T17:42:42.158701  =


    2023-10-20T17:42:42.162947  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-10-20T17:42:42.165379  FIRST, INC default to 1.

    2023-10-20T17:42:42.165443  =


    2023-10-20T17:42:42.168559  	-w	Pad to last with leading zeros
   =


  * baseline.bootrr.dwhdmi-rockchip-probed: https://kernelci.org/test/case/=
id/6532bb3d14d0871f99efcf59
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:41.089098  [   23.828803] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-driver-present RESULT=3Dpass>

    2023-10-20T17:42:42.107152  /lava-11831803/1/../bin/lava-test-case

    2023-10-20T17:42:42.134141  [   24.874323] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dfail>
   =


  * baseline.bootrr.dw_wdt-driver-present: https://kernelci.org/test/case/i=
d/6532bb3d14d0871f99efcf5e
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:38.824420  [   21.564877] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddw-apb-uart2-probed RESULT=3Dpass>

    2023-10-20T17:42:39.839150  /lava-11831803/1/../bin/lava-test-case

    2023-10-20T17:42:39.878414  [   22.618945] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddw_wdt-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.cros-ec-keyb-probed: https://kernelci.org/test/case/id/=
6532bb3d14d0871f99efcf63
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:37.636953  [   20.376891] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-keyb-driver-present RESULT=3Dpass>

    2023-10-20T17:42:38.663503  /lava-11831803/1/../bin/lava-test-case
   =


  * baseline.bootrr.cros-ec-i2c-tunnel-driver-present: https://kernelci.org=
/test/case/id/6532bb3d14d0871f99efcf65
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:34.346126  [   17.085882] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-dev-driver-present RESULT=3Dfail>

    2023-10-20T17:42:34.465446  [   17.202696] asix 3-1:1.0 eth0: register =
'asix' at usb-ff580000.usb-1, ASIX AX88772B USB 2.0 Ethernet, 00:6f:00:09:0=
8:66

    2023-10-20T17:42:34.477611  [   17.218276] dwmmc_rockchip ff0d0000.dwmm=
c: IDMAC supports 32-bit address mode.

    2023-10-20T17:42:34.485495  [   17.226556] dwmmc_rockchip ff0d0000.dwmm=
c: Using internal DMA controller.

    2023-10-20T17:42:34.491246  [   17.233415] dwmmc_rockchip ff0d0000.dwmm=
c: Version ID is 270a

    2023-10-20T17:42:34.501070  [   17.239235] dwmmc_rockchip ff0d0000.dwmm=
c: DW MMC controller at irq 30,32 bit host data width,256 deep fifo

    2023-10-20T17:42:35.400814  /lava-11831803/1/../bin/lava-test-case

    2023-10-20T17:42:35.439755  [   18.179994] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dcros-ec-dev-probed RESULT=3Dblocked>

    2023-10-20T17:42:36.494192  /lava-11831803/1/../bin/lava-test-case
   =


  * baseline.bootrr.cros-ec-dev-driver-present: https://kernelci.org/test/c=
ase/id/6532bb3d14d0871f99efcf66
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-20T17:42:33.286077  [   16.026660] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Dtpm-chip-is-online RESULT=3Dskip>

    2023-10-20T17:42:33.453326  [   16.195082] usb 3-1: new high-speed USB =
device number 2 using dwc2

    2023-10-20T17:42:34.307054  /lava-11831803/1/../bin/lava-test-case
   =

 =20


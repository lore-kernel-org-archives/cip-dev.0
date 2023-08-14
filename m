Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DED4EB64DD
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 10:42:03 +0000 (UTC)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
 by mx.groups.io with SMTP id smtpd.web10.104783.1692009717337724481
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Aug 2023 03:41:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=3rp6au3U;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.172, mailfrom: bot@kernelci.org)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3497a6119abso13382305ab.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Aug 2023 03:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692009716; x=1692614516;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OWDdoAbk6uog/yCIQcQDbgSCzrxOBgeEseETYI6eqkk=;
        b=3rp6au3UFQDngtj/ZnVh96Wqv8LWjV6nGZyaNVxbodjCib1XLk9Nzsmte3gVtl9P6/
         d3v6BbJjhb2SIgumUWtjsn1NINX5Q4P3DBuMvekijYJp/o3IPh3o5BboXZUibmjAD2/P
         hKKYFo/RS5cp8ENkJxqP+aV16P3Uaeqv2Bw3x4woAhpNqRw2yFyTwC0JJlpekoERSkTo
         88OaVhvzZReAchaGj65unaaEForxEKIFlMdMafaYG6yFCMcaqe/7YB15alJMD/2I6KWI
         uW+JLRtUdq1EDjbXp9bqqujm72lOS0V7TTTct5sSmpz1OQex0I/LR9QdCdECTE+7QbHs
         A4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692009716; x=1692614516;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OWDdoAbk6uog/yCIQcQDbgSCzrxOBgeEseETYI6eqkk=;
        b=aFWdZ6i9r0FcpsReQpi1m3RS8prsrMtvc5DNEJTjytTrZY0Fz0BAsyHvK9ofO5f2R5
         379DFNHZTfkvn0NP3iJSLO6sx19pcHU4X7MM/ZegF6NBuY3TMGXaoh/H79MHGZbl+BQz
         BXOJZ+ka+SKs7gQgBZwOWlAyo1ix8XPTKhMZOnVNTxad4B4282huKazjK0yC0bKJlNCf
         Lr3ZYI7pn72ImVYBmo9mMla1GfzlC6+RlTUwczN7NLd7Op516zh2xtieVNLzndb2qP9O
         kemUctoDImU5RPiu1XKf9qudOH+XOFgt2fu8b0nhxHdR1cOsqE9Hdq6OnTby+2smNsCc
         44sA==
X-Gm-Message-State: AOJu0YyWxWDH+nQdOkiD4EzIKVxHUq8FK/vzlG7X7l1UaZ2cIkZTdTF0
	itHLBV5Hs/umJ5sW+Mqu5ufZh5DoHDUqDhyGdbNZki7U
X-Google-Smtp-Source: AGHT+IFYrsM1F9m5IDN5JgeHhAwNlqXxKPcYP7yFdcUN2Wb2GQDHZr0UmAV7YF3kHuwZccTmUiCxMw==
X-Received: by 2002:a05:6e02:1110:b0:349:76b0:4dde with SMTP id u16-20020a056e02111000b0034976b04ddemr11423154ilk.11.1692009714544;
        Mon, 14 Aug 2023 03:41:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q5-20020a637505000000b0055bf13811f5sm7128440pgc.15.2023.08.14.03.41.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 03:41:53 -0700 (PDT)
Message-ID: <64da04f1.630a0220.af77.b799@mx.google.com>
Date: Mon, 14 Aug 2023 03:41:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.288-cip101-1117-g1f3468542aa9e
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 105 runs,
 112 regressions (v4.19.288-cip101-1117-g1f3468542aa9e)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 10:42:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12635

cip-gitlab/ci/pavel/linux-test baseline: 105 runs, 112 regressions (v4.19.2=
88-cip101-1117-g1f3468542aa9e)

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

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig            | 5          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 3          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 12         =

beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 12         =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 7          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 8          =

imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | multi_v7=
_defconfig           | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

qemu_mips-malta              | mips   | lab-broonie   | gcc-10   | malta_de=
fconfig              | 1          =

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie   | gcc-10   | x86_64_d=
efconfig             | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig             | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 7          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 5          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 12         =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 9          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.288-cip101-1117-g1f3468542aa9e/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.288-cip101-1117-g1f3468542aa9e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1f3468542aa9e444da3a41472888366e97d515e2 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9ff3ed45093cd5035b1e5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig+x86-chromeboo=
k/gcc-10/lab-collabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig+x86-chromeboo=
k/gcc-10/lab-collabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d9ff3ed45093cd5035b=
1e6
        new failure (last pass: v5.10.186-cip37-12-g2710acbceb75) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9ff37d45093cd5035b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig+x86-chromeboo=
k/gcc-10/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig+x86-chromeboo=
k/gcc-10/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d9ff37d45093cd5035b=
1da
        failing since 25 days (last pass: v6.1.38-cip1-10-g02aa22be941dd, f=
irst fail: v5.10.186-cip37-2-gfcd111609480) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9ff3476e2fa168c35b1f7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig+x86-chromeboo=
k/gcc-10/lab-collabora/baseline-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig+x86-chromeboo=
k/gcc-10/lab-collabora/baseline-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d9ff3476e2fa168c35b=
1f8
        new failure (last pass: v5.10.186-cip37-12-g2710acbceb75) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9ff3bd45093cd5035b1df

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig+x86-chromeboo=
k/gcc-10/lab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig+x86-chromeboo=
k/gcc-10/lab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d9ff3bd45093cd5035b=
1e0
        new failure (last pass: v5.10.186-cip37-12-g2710acbceb75) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9ff3476e2fa168c35b1f4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig+x86-chromeboo=
k/gcc-10/lab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig+x86-chromeboo=
k/gcc-10/lab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d9ff3476e2fa168c35b=
1f5
        new failure (last pass: v5.10.186-cip37-12-g2710acbceb75) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | at91_dt_=
defconfig            | 5          =


  Details:     https://kernelci.org/test/plan/id/64d9fdd17955bbd1d835b1f1

  Results:     44 PASS, 6 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/at91_dt_defconfig/gcc-10/lab-broo=
nie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/at91_dt_defconfig/gcc-10/lab-broo=
nie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/64d=
9fdd27955bbd1d835b1f6
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:11:06.228253  /lava-50862/1/../bin/lava-test-case
    2023-08-14T10:11:06.263546  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =


  * baseline.bootrr.atmel-usart-serial-driver-present: https://kernelci.org=
/test/case/id/64d9fdd27955bbd1d835b20d
        new failure (last pass: v5.10.186-cip37-12-g2710acbceb75)

    2023-08-14T10:10:52.361712  /lava-50862/1/../bin/lava-test-case
    2023-08-14T10:10:52.398451  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Datm=
el-usart-serial-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at91-usart-mode-driver-present: https://kernelci.org/te=
st/case/id/64d9fdd27955bbd1d835b20e
        new failure (last pass: v5.10.186-cip37-12-g2710acbceb75)

    2023-08-14T10:10:51.267958  /lava-50862/1/../bin/lava-test-case
    2023-08-14T10:10:51.305845  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dat9=
1-usart-mode-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.wm8731-driver-present: https://kernelci.org/test/case/i=
d/64d9fdd27955bbd1d835b214
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:11:02.111607  /lava-50862/1/../bin/lava-test-case
    2023-08-14T10:11:02.146787  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Deep=
rom-probed RESULT=3Dblocked>
    2023-08-14T10:11:02.185144  sh: /sys/bus/spi/drivers/wm8731: unknown op=
erand
    2023-08-14T10:11:03.204984  /lava-50862/1/../bin/lava-test-case
    2023-08-14T10:11:03.240960  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dwm8=
731-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
64d9fdd27955bbd1d835b215
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:11:01.025340  /lava-50862/1/../bin/lava-test-case
    2023-08-14T10:11:01.060835  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dat2=
4-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 3          =


  Details:     https://kernelci.org/test/plan/id/64d9fe5d32a1e8b81435b1d9

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/multi_v5_defconfig/gcc-10/lab-bro=
onie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/multi_v5_defconfig/gcc-10/lab-bro=
onie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/64d=
9fe5d32a1e8b81435b1de
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:13:30.293843  /lava-50877/1/../bin/lava-test-case
    2023-08-14T10:13:30.328654  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =


  * baseline.bootrr.atmel-usart-serial-driver-present: https://kernelci.org=
/test/case/id/64d9fe5d32a1e8b81435b1ff
        new failure (last pass: v5.10.186-cip37-12-g2710acbceb75)

    2023-08-14T10:13:15.473526  /lava-50877/1/../bin/lava-test-case
    2023-08-14T10:13:15.509075  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Datm=
el-usart-serial-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at91-usart-mode-driver-present: https://kernelci.org/te=
st/case/id/64d9fe5d32a1e8b81435b200
        new failure (last pass: v5.10.186-cip37-12-g2710acbceb75)

    2023-08-14T10:13:14.388504  /lava-50877/1/../bin/lava-test-case
    2023-08-14T10:13:14.424608  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dat9=
1-usart-mode-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 12         =


  Details:     https://kernelci.org/test/plan/id/64d9fdbbc11ce7eaba35b215

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/multi_v7_defconfig/gcc-10/lab-bro=
onie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/multi_v7_defconfig/gcc-10/lab-bro=
onie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/64d9fdbbc11ce7eaba35b218
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:10:52.307527  /lava-50844/1/../bin/lava-test-case
    2023-08-14T10:10:52.324857  <8>[   43.405917] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-08-14T10:10:53.349402  /lava-50844/1/../bin/lava-test-case
    2023-08-14T10:10:53.369566  <8>[   44.447955] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
64d9fdbbc11ce7eaba35b219
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:10:50.222954  /lava-50844/1/../bin/lava-test-case
    2023-08-14T10:10:50.240425  <8>[   41.321187] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-08-14T10:10:51.264876  /lava-50844/1/../bin/lava-test-case
    2023-08-14T10:10:51.281799  <8>[   42.363417] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/64d9fdbbc11ce7eaba35b21a
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:10:48.138700  /lava-50844/1/../bin/lava-test-case
    2023-08-14T10:10:48.156516  <8>[   39.237427] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-08-14T10:10:49.179984  /lava-50844/1/../bin/lava-test-case
    2023-08-14T10:10:49.198469  <8>[   40.278767] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/64d9fdbbc11ce7eaba35b224
        new failure (last pass: v5.10.186-cip37-11-gafa55beeffce9)

    2023-08-14T10:10:35.469961  /lava-50844/1/../bin/lava-test-case
    2023-08-14T10:10:35.488225  <8>[   26.568278] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-08-14T10:10:36.511467  /lava-50844/1/../bin/lava-test-case
    2023-08-14T10:10:36.530973  <8>[   27.610580] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/64d9fdbbc11ce7eaba35b225
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:10:34.426353  /lava-50844/1/../bin/lava-test-case
    2023-08-14T10:10:34.445490  <8>[   25.524973] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mmc1-probed: https://kernelci.org/test/case/id/64d9fdbb=
c11ce7eaba35b22d
        new failure (last pass: v5.10.186-cip37-11-gafa55beeffce9)

    2023-08-14T10:10:33.096710  /lava-50844/1/../bin/lava-test-case
    2023-08-14T10:10:33.114009  <8>[   24.195320] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc1-probed RESULT=3Dfail>   =


  * baseline.bootrr.mmc0-probed: https://kernelci.org/test/case/id/64d9fdbb=
c11ce7eaba35b22e
        new failure (last pass: v5.10.186-cip37-11-gafa55beeffce9)

    2023-08-14T10:10:32.048101  /lava-50844/1/../bin/lava-test-case
    2023-08-14T10:10:32.064320  <8>[   23.145990] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc0-probed RESULT=3Dfail>   =


  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/64d9fdbbc11ce7eaba35b23b
        new failure (last pass: v5.10.186-cip37-11-gafa55beeffce9)

    2023-08-14T10:10:27.489884  /lava-50844/1/../bin/lava-test-case
    2023-08-14T10:10:27.508913  <8>[   18.588606] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d9fdbbc11ce7eaba35b23e
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:10:24.796250  <8>[   15.878395] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 50844_1.5.2.4.1>
    2023-08-14T10:10:24.906007  / # #
    2023-08-14T10:10:25.008913  export SHELL=3D/bin/sh
    2023-08-14T10:10:25.009653  #
    2023-08-14T10:10:25.111969  / # export SHELL=3D/bin/sh. /lava-50844/env=
ironment
    2023-08-14T10:10:25.112785  =

    2023-08-14T10:10:25.215155  / # . /lava-50844/environment/lava-50844/bi=
n/lava-test-runner /lava-50844/1
    2023-08-14T10:10:25.216261  =

    2023-08-14T10:10:25.220624  / # /lava-50844/bin/lava-test-runner /lava-=
50844/1
    2023-08-14T10:10:25.286837  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =


  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64d9fdbbc=
11ce7eaba35b23f
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:10:55.478769  /lava-50844/1/../bin/lava-test-case
    2023-08-14T10:10:55.494919  <8>[   46.577550] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/64=
d9fdbbc11ce7eaba35b240
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:10:54.437866  /lava-50844/1/../bin/lava-test-case
    2023-08-14T10:10:54.455406  <8>[   45.536587] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/64d9fdbbc11ce7ea=
ba35b244
        new failure (last pass: v5.10.186-cip37-11-gafa55beeffce9)
        1 lines

    2023-08-14T10:10:24.109348  / # =

    2023-08-14T10:10:24.115580  =

    2023-08-14T10:10:24.220030  / # #
    2023-08-14T10:10:24.226278  #
    2023-08-14T10:10:24.328929  / # export SHELL=3D/bin/sh
    2023-08-14T10:10:24.335028  export SHELL=3D/bin/sh
    2023-08-14T10:10:24.437469  / # . /lava-50844/environment
    2023-08-14T10:10:24.443742  . /lava-50844/environment
    2023-08-14T10:10:24.546215  / # /lava-50844/bin/lava-test-runner /lava-=
50844/0
    2023-08-14T10:10:24.550763  /lava-50844/bin/lava-test-runner /lava-5084=
4/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 12         =


  Details:     https://kernelci.org/test/plan/id/64d9fda264327f4c3d35b234

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/multi_v7_defconfig/gcc-10/lab-cip=
/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/multi_v7_defconfig/gcc-10/lab-cip=
/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d9fda264327f4c3d35b237
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:10:06.397411  + set +x
    2023-08-14T10:10:06.399411  <8>[    9.814791] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 997135_1.5.2.4.1>
    2023-08-14T10:10:06.507044  / # #
    2023-08-14T10:10:06.608629  export SHELL=3D/bin/sh
    2023-08-14T10:10:06.608986  #
    2023-08-14T10:10:06.710207  / # export SHELL=3D/bin/sh. /lava-997135/en=
vironment
    2023-08-14T10:10:06.710788  =

    2023-08-14T10:10:06.811992  / # . /lava-997135/environment/lava-997135/=
bin/lava-test-runner /lava-997135/1
    2023-08-14T10:10:06.812634  =

    2023-08-14T10:10:06.813955  / # /lava-997135/bin/lava-test-runner /lava=
-997135/1 =

    ... (12 line(s) more)  =


  * baseline.bootrr.omap8240-driver-present: https://kernelci.org/test/case=
/id/64d9fda264327f4c3d35b23a
        new failure (last pass: v5.10.186-cip37-11-gafa55beeffce9)

    2023-08-14T10:10:09.086449  /lava-997135/1/../bin/lava-test-case
    2023-08-14T10:10:09.104523  <8>[   12.518013] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap8240-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mmc0-probed: https://kernelci.org/test/case/id/64d9fda2=
64327f4c3d35b246
        new failure (last pass: v5.10.186-cip37-11-gafa55beeffce9)

    2023-08-14T10:10:13.648242  /lava-997135/1/../bin/lava-test-case
    2023-08-14T10:10:13.665118  <8>[   17.079762] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc0-probed RESULT=3Dfail>   =


  * baseline.bootrr.mmc1-probed: https://kernelci.org/test/case/id/64d9fda2=
64327f4c3d35b247
        new failure (last pass: v5.10.186-cip37-11-gafa55beeffce9)

    2023-08-14T10:10:14.698587  /lava-997135/1/../bin/lava-test-case
    2023-08-14T10:10:14.715538  <8>[   18.129685] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc1-probed RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/64d9fda264327f4c3d35b24f
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:10:16.030580  /lava-997135/1/../bin/lava-test-case
    2023-08-14T10:10:16.049458  <8>[   19.462255] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/64d9fda264327f4c3d35b250
        new failure (last pass: v5.10.186-cip37-11-gafa55beeffce9)

    2023-08-14T10:10:17.074492  /lava-997135/1/../bin/lava-test-case
    2023-08-14T10:10:17.092445  <8>[   20.505649] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-08-14T10:10:18.116557  /lava-997135/1/../bin/lava-test-case
    2023-08-14T10:10:18.134597  <8>[   21.547926] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/64d9fda264327f4c3d35b25a
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:10:29.745249  /lava-997135/1/../bin/lava-test-case
    2023-08-14T10:10:29.762112  <8>[   33.177257] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-08-14T10:10:30.786753  /lava-997135/1/../bin/lava-test-case
    2023-08-14T10:10:30.804636  <8>[   34.218935] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
64d9fda264327f4c3d35b25b
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:10:31.829537  /lava-997135/1/../bin/lava-test-case
    2023-08-14T10:10:31.847091  <8>[   35.261847] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-08-14T10:10:32.871656  /lava-997135/1/../bin/lava-test-case
    2023-08-14T10:10:32.889312  <8>[   36.304088] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/64d9fda264327f4c3d35b25c
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:10:33.914208  /lava-997135/1/../bin/lava-test-case
    2023-08-14T10:10:33.931778  <8>[   37.346867] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-08-14T10:10:34.956290  /lava-997135/1/../bin/lava-test-case
    2023-08-14T10:10:34.974931  <8>[   38.388744] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/64=
d9fda264327f4c3d35b25e
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:10:36.045957  /lava-997135/1/../bin/lava-test-case
    2023-08-14T10:10:36.062937  <8>[   39.477853] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/64d9fda26=
4327f4c3d35b25f
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:10:37.086936  /lava-997135/1/../bin/lava-test-case
    2023-08-14T10:10:37.103255  <8>[   40.519021] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/64d9fda264327f4c=
3d35b261
        new failure (last pass: v5.10.186-cip37-11-gafa55beeffce9)
        1 lines

    2023-08-14T10:10:05.734143  / # =

    2023-08-14T10:10:05.736866  =

    2023-08-14T10:10:05.840472  / # #
    2023-08-14T10:10:05.843118  #
    2023-08-14T10:10:05.944541  / # export SHELL=3D/bin/sh
    2023-08-14T10:10:05.946993  export SHELL=3D/bin/sh
    2023-08-14T10:10:06.048170  / # . /lava-997135/environment
    2023-08-14T10:10:06.050744  . /lava-997135/environment
    2023-08-14T10:10:06.152022  / # /lava-997135/bin/lava-test-runner /lava=
-997135/0
    2023-08-14T10:10:06.154101  /lava-997135/bin/lava-test-runner /lava-997=
135/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 7          =


  Details:     https://kernelci.org/test/plan/id/64d9fdda7955bbd1d835b233

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/omap2plus_defconfig/gcc-10/lab-br=
oonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/omap2plus_defconfig/gcc-10/lab-br=
oonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.omap-sham-driver-present: https://kernelci.org/test/cas=
e/id/64d9fdda7955bbd1d835b244
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:11:31.068630  /lava-50859/1/../bin/lava-test-case
    2023-08-14T10:11:31.126734  <8>[   31.559453] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap-aes-driver-present: https://kernelci.org/test/case=
/id/64d9fdda7955bbd1d835b247
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:11:28.698123  /lava-50859/1/../bin/lava-test-case
    2023-08-14T10:11:28.753038  <8>[   29.185959] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/64d9fdda7955bbd1d835b24a
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:11:25.212200  /lava-50859/1/../bin/lava-test-case
    2023-08-14T10:11:25.267784  <8>[   25.700669] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-08-14T10:11:26.320170  /lava-50859/1/../bin/lava-test-case
    2023-08-14T10:11:26.376772  <8>[   26.809222] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/64d9fdda7955bbd1d835b24b
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:11:24.105087  /lava-50859/1/../bin/lava-test-case
    2023-08-14T10:11:24.158838  <8>[   24.591326] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mmc1-probed: https://kernelci.org/test/case/id/64d9fdda=
7955bbd1d835b253
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:11:22.427644  /lava-50859/1/../bin/lava-test-case
    2023-08-14T10:11:22.483711  <8>[   22.918496] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc1-probed RESULT=3Dfail>   =


  * baseline.bootrr.mmc0-probed: https://kernelci.org/test/case/id/64d9fdda=
7955bbd1d835b254
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:11:21.305513  /lava-50859/1/../bin/lava-test-case
    2023-08-14T10:11:21.358144  <8>[   21.792040] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc0-probed RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/64d9fdda7955bbd1=
d835b269
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)
        1 lines

    2023-08-14T10:11:17.210738  / # =

    2023-08-14T10:11:17.220754  =

    2023-08-14T10:11:17.325117  / # #
    2023-08-14T10:11:17.331718  #
    2023-08-14T10:11:17.433588  / # export SHELL=3D/bin/sh
    2023-08-14T10:11:17.440827  export SHELL=3D/bin/sh
    2023-08-14T10:11:17.542741  / # . /lava-50859/environment
    2023-08-14T10:11:17.548554  . /lava-50859/environment
    2023-08-14T10:11:17.650355  / # /lava-50859/bin/lava-test-runner /lava-=
50859/0
    2023-08-14T10:11:17.656298  /lava-50859/bin/lava-test-runner /lava-5085=
9/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 8          =


  Details:     https://kernelci.org/test/plan/id/64d9fe8132a1e8b81435b223

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/omap2plus_defconfig/gcc-10/lab-ci=
p/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/omap2plus_defconfig/gcc-10/lab-ci=
p/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d9fe8132a1e8b81435b226
        failing since 60 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-08-14T10:13:54.733505  / # #
    2023-08-14T10:13:54.836961  export SHELL=3D/bin/sh
    2023-08-14T10:13:54.838001  #
    2023-08-14T10:13:54.940123  / # export SHELL=3D/bin/sh. /lava-997142/en=
vironment
    2023-08-14T10:13:54.941102  =

    2023-08-14T10:13:55.043477  / # . /lava-997142/environment/lava-997142/=
bin/lava-test-runner /lava-997142/1
    2023-08-14T10:13:55.045050  =

    2023-08-14T10:13:55.056573  / # /lava-997142/bin/lava-test-runner /lava=
-997142/1
    2023-08-14T10:13:55.216510  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-14T10:13:55.263380  + cd /lava-997142/1/tests/1_bootrr =

    ... (10 line(s) more)  =


  * baseline.bootrr.mmc0-probed: https://kernelci.org/test/case/id/64d9fe81=
32a1e8b81435b237
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:13:58.749319  /lava-997142/1/../bin/lava-test-case
    2023-08-14T10:13:58.804058  <8>[   15.771486] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc0-probed RESULT=3Dfail>   =


  * baseline.bootrr.mmc1-probed: https://kernelci.org/test/case/id/64d9fe81=
32a1e8b81435b238
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:13:59.875596  /lava-997142/1/../bin/lava-test-case
    2023-08-14T10:13:59.932696  <8>[   16.899804] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmmc1-probed RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/64d9fe8132a1e8b81435b240
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:14:01.553418  /lava-997142/1/../bin/lava-test-case
    2023-08-14T10:14:01.606354  <8>[   18.571341] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.phy-gmii-sel-driver-present: https://kernelci.org/test/=
case/id/64d9fe8132a1e8b81435b241
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:14:02.645540  /lava-997142/1/../bin/lava-test-case
    2023-08-14T10:14:02.714412  <8>[   19.680786] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dblocked>
    2023-08-14T10:14:03.769215  /lava-997142/1/../bin/lava-test-case
    2023-08-14T10:14:03.824988  <8>[   20.792436] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dphy-gmii-sel-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap-aes-driver-present: https://kernelci.org/test/case=
/id/64d9fe8132a1e8b81435b244
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:14:06.145107  /lava-997142/1/../bin/lava-test-case
    2023-08-14T10:14:06.193334  <8>[   23.162784] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap-aes-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.omap-sham-driver-present: https://kernelci.org/test/cas=
e/id/64d9fe8132a1e8b81435b247
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:14:08.517364  /lava-997142/1/../bin/lava-test-case
    2023-08-14T10:14:08.572346  <8>[   25.539566] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Domap-sham-driver-present RESULT=3Dfail>   =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/64d9fe8132a1e8b8=
1435b257
        new failure (last pass: v5.10.186-cip37-12-gf8c9ce666de7b)
        1 lines

    2023-08-14T10:13:53.603005  / # =

    2023-08-14T10:13:53.626291  =

    2023-08-14T10:13:53.732673  / # #
    2023-08-14T10:13:53.738160  #
    2023-08-14T10:13:53.856762  / # export SHELL=3D/bin/sh
    2023-08-14T10:13:53.865995  export SHELL=3D/bin/sh
    2023-08-14T10:13:53.968413  / # . /lava-997142/environment
    2023-08-14T10:13:53.977711  . /lava-997142/environment
    2023-08-14T10:13:54.080029  / # /lava-997142/bin/lava-test-runner /lava=
-997142/0
    2023-08-14T10:13:54.089720  /lava-997142/bin/lava-test-runner /lava-997=
142/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9fe5f54a2b4953135b20d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/imx_v6_v7_defconfig/gcc-10/lab-nx=
p/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/imx_v6_v7_defconfig/gcc-10/lab-nx=
p/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
64d9fe5f54a2b4953135b211
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:13:33.598641  /lava-1243519/1/../bin/lava-test-case
    2023-08-14T10:13:33.627671  <8>[   28.764205] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dall-cpus-are-online RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9fdabc11ce7eaba35b1e7

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/multi_v7_defconfig/gcc-10/lab-nxp=
/baseline-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/multi_v7_defconfig/gcc-10/lab-nxp=
/baseline-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
64d9fdabc11ce7eaba35b1eb
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:10:38.410681  /lava-1243515/1/../bin/lava-test-case
    2023-08-14T10:10:38.411043  <8>[   20.732765] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dall-cpus-are-online RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9ff11a29055224e35b1e2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig/gcc-10/lab-broonie/ba=
seline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig/gcc-10/lab-broonie/ba=
seline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d9ff11a29055224e35b=
1e3
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9ff3cd45093cd5035b1e2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig+arm64-chromebook/gcc-=
10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig+arm64-chromebook/gcc-=
10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d9ff3cd45093cd5035b=
1e3
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64da00b81182d4181b35b42b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig/gcc-10/lab-broonie/ba=
seline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig/gcc-10/lab-broonie/ba=
seline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64da00b81182d4181b35b=
42c
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9feaaf48d63544c35b1dc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig+arm64-chromebook/gcc-=
10/lab-collabora/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig+arm64-chromebook/gcc-=
10/lab-collabora/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d9feaaf48d63544c35b=
1dd
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9ff0da29055224e35b1dc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig/gcc-10/lab-collabora/=
baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig/gcc-10/lab-collabora/=
baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d9ff0da29055224e35b=
1dd
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9ff2476e2fa168c35b1e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig+arm64-chromebook/gcc-=
10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig+arm64-chromebook/gcc-=
10/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d9ff2476e2fa168c35b=
1e7
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64da00dc10beed387735b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig/gcc-10/lab-broonie/ba=
seline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig/gcc-10/lab-broonie/ba=
seline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64da00dc10beed387735b=
1da
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9fea732a1e8b81435b2bd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig+arm64-chromebook/gcc-=
10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig+arm64-chromebook/gcc-=
10/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d9fea732a1e8b81435b=
2be
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9ff0b0349202f8d35b210

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig/gcc-10/lab-collabora/=
baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig/gcc-10/lab-collabora/=
baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d9ff0b0349202f8d35b=
211
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64da007c9b21d810b935b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig+arm64-chromebook/gcc-=
10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig+arm64-chromebook/gcc-=
10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64da007c9b21d810b935b=
1da
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64da00e0b5ff0119d335b1f5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig/gcc-10/lab-broonie/ba=
seline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig/gcc-10/lab-broonie/ba=
seline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64da00e0b5ff0119d335b=
1f6
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9febbf48d63544c35b1f6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig+arm64-chromebook/gcc-=
10/lab-collabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig+arm64-chromebook/gcc-=
10/lab-collabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d9febbf48d63544c35b=
1f7
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9ff0e0349202f8d35b21a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig/gcc-10/lab-collabora/=
baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig/gcc-10/lab-collabora/=
baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d9ff0e0349202f8d35b=
21b
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9ff50d45093cd5035b24e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig+arm64-chromebook/gcc-=
10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig+arm64-chromebook/gcc-=
10/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d9ff50d45093cd5035b=
24f
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64da01e42a1c93eb2335b1dc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig/gcc-10/lab-broonie/ba=
seline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig/gcc-10/lab-broonie/ba=
seline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64da01e42a1c93eb2335b=
1dd
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9feab9bb8f3585a35b1da

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig+arm64-chromebook/gcc-=
10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig+arm64-chromebook/gcc-=
10/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d9feab9bb8f3585a35b=
1db
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9ff0c0349202f8d35b214

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig/gcc-10/lab-collabora/=
baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig/gcc-10/lab-collabora/=
baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d9ff0c0349202f8d35b=
215
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-broonie   | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/64da013010beed387735b1f7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/mips/malta_defconfig/gcc-10/lab-broon=
ie/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/mips/malta_defconfig/gcc-10/lab-broon=
ie/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64da013010beed387735b=
1f8
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9fed19bb8f3585a35b1fa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/mips/malta_defconfig/gcc-10/lab-colla=
bora/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/mips/malta_defconfig/gcc-10/lab-colla=
bora/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d9fed19bb8f3585a35b=
1fb
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie   | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9ff140349202f8d35b220

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig/gcc-10/lab-br=
oonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig/gcc-10/lab-br=
oonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d9ff140349202f8d35b=
221
        new failure (last pass: v5.10.186-cip37-11-gafa55beeffce9) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64da02481b41b4395035b1f5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig+x86-chromeboo=
k/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig+x86-chromeboo=
k/gcc-10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64da02481b41b4395035b=
1f6
        new failure (last pass: v5.10.186-cip37-12-g2710acbceb75) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9fea932a1e8b81435b2d2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig/gcc-10/lab-co=
llabora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig/gcc-10/lab-co=
llabora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d9fea932a1e8b81435b=
2d3
        new failure (last pass: v5.10.186-cip37-11-gafa55beeffce9) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64da0039c55f98faa435b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig+x86-chromeboo=
k/gcc-10/lab-collabora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig+x86-chromeboo=
k/gcc-10/lab-collabora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64da0039c55f98faa435b=
1da
        new failure (last pass: v5.10.186-cip37-12-g2710acbceb75) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9ff42d45093cd5035b248

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/shmobile_defconfig/gcc-10/lab-cip=
/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/shmobile_defconfig/gcc-10/lab-cip=
/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d9ff42d45093cd5035b=
249
        failing since 35 days (last pass: v6.1.31-61-g32a95f5a4e3b, first f=
ail: v6.1.31-65-geef5a19d48f6) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/64d9fd7e1483f79d0935b1dc

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/multi_v7_defconfig/gcc-10/lab-col=
labora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm/multi_v7_defconfig/gcc-10/lab-col=
labora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/test=
/case/id/64d9fd7e1483f79d0935b1f2
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:11:30.026578  <8>[   13.858151] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-iodomain-driver-present RESULT=3Dpass>

    2023-08-14T10:11:31.037791  /lava-11283115/1/../bin/lava-test-case
   =


  * baseline.bootrr.rk_iommu-vpu_mmu-probed: https://kernelci.org/test/case=
/id/64d9fd7e1483f79d0935b1fa
        new failure (last pass: v5.10.186-cip37-11-gafa55beeffce9)

    2023-08-14T10:11:28.880591  <8>[   12.712901] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk_iommu-vopl_mmu-probed RESULT=3Dpass>

    2023-08-14T10:11:29.892096  /lava-11283115/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/64d9fd7e1483f79d0935b209
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:11:27.597817  <8>[   11.429837] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dfail>

    2023-08-14T10:11:28.609301  /lava-11283115/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/64d9fd7e1483f79d0935b20a
        failing since 24 days (last pass: v6.1.38-cip1-13-ga3621452a4fc, fi=
rst fail: v5.10.186-cip37-12-gf8c9ce666de7b)

    2023-08-14T10:11:26.577391  Usag<8>[   10.405707] <LAVA_SIGNAL_TESTCASE=
 TEST_CASE_ID=3Ddwmmc_rockchip-driver-present RESULT=3Dpass>

    2023-08-14T10:11:26.580886  e: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-08-14T10:11:26.581289  =


    2023-08-14T10:11:26.588292  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-08-14T10:11:26.588705  FIRST, INC default to 1.

    2023-08-14T10:11:26.588956  =


    2023-08-14T10:11:26.592444  	-w	Pad to last with leading zeros

    2023-08-14T10:11:26.594938  	-s SEP	String separator

    2023-08-14T10:11:26.598905  /lava-11283115/1/../bin/lava-test-case

    2023-08-14T10:11:26.602640  /lava-11283115/1/../bin/lava-test-case
 =

    ... (1 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64d9fd7e1483f79d0935b20c
        failing since 205 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-08-14T10:11:26.526649  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   10.357916] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-08-14T10:11:26.529367   multi-call binary.

    2023-08-14T10:11:26.529418  =


    2023-08-14T10:11:26.533261  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-08-14T10:11:26.533487  =


    2023-08-14T10:11:26.538509  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64d9fd7e1483f79d0935b20d
        failing since 205 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-08-14T10:11:26.508142  <8>[   10.340496] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.cros-ec-dev-driver-present: https://kernelci.org/test/c=
ase/id/64d9fd7e1483f79d0935b21d
        new failure (last pass: v5.10.186-cip37-11-gafa55beeffce9)

    2023-08-14T10:11:24.185945  <8>[    8.018668] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtpm-chip-is-online RESULT=3Dskip>

    2023-08-14T10:11:25.201367  /lava-11283115/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 5          =


  Details:     https://kernelci.org/test/plan/id/64d9fdcd26d5f1d15135b1d9

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig+arm64-chromebook/gcc-=
10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig+arm64-chromebook/gcc-=
10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64d9fdcd26d5f1d15135b1df
        failing since 60 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-08-14T10:11:46.585089  <8>[   36.618154] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-08-14T10:11:47.599486  /lava-11283138/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64d9fdcd26d5f1d15135b1e0
        failing since 60 days (last pass: v6.1.26-1320-g1ddf4b637f785, firs=
t fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-08-14T10:11:45.559834  <8>[   35.592488] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-08-14T10:11:46.574684  /lava-11283138/1/../bin/lava-test-case
   =


  * baseline.bootrr.cros-ec-sysfs-driver-present: https://kernelci.org/test=
/case/id/64d9fdcd26d5f1d15135b215
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:11:43.357595  /lava-11283138/1/../bin/lava-test-case

    2023-08-14T10:11:43.366747  <8>[   33.400791] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sysfs-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.cros-ec-lightbar-driver-present: https://kernelci.org/t=
est/case/id/64d9fdcd26d5f1d15135b21e
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:11:41.121874  <8>[   31.155137] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-keyb-probed RESULT=3Dpass>

    2023-08-14T10:11:42.137318  /lava-11283138/1/../bin/lava-test-case

    2023-08-14T10:11:42.146262  <8>[   32.179760] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-lightbar-driver-present RESULT=3Dfail>
   =


  * baseline.bootrr.cros-ec-debugfs-driver-present: https://kernelci.org/te=
st/case/id/64d9fdcd26d5f1d15135b227
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:11:39.923111  /lava-11283138/1/../bin/lava-test-case

    2023-08-14T10:11:39.933085  <8>[   29.966382] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-debugfs-driver-present RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 12         =


  Details:     https://kernelci.org/test/plan/id/64d9fe3b2565ac357b35b1dc

  Results:     23 PASS, 16 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig/gcc-10/lab-broonie/ba=
seline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig/gcc-10/lab-broonie/ba=
seline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.lima-driver-present: https://kernelci.org/test/case/id/=
64d9fe3c2565ac357b35b1df
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:13:02.058866   v1.31.1 (2023-06-23 08:09:45 UTC) multi-ca=
ll binary.
    2023-08-14T10:13:02.059321  =

    2023-08-14T10:13:02.064143  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST
    2023-08-14T10:13:02.064543  =

    2023-08-14T10:13:02.069829  Print numbers from FIRST to LAST, in steps =
of INC.
    2023-08-14T10:13:02.070208  FIRST, INC default to 1.
    2023-08-14T10:13:02.070423  =

    2023-08-14T10:13:02.075664  	-w	Pad to last with leading zeros
    2023-08-14T10:13:02.076165  	-s SEP	String separator
    2023-08-14T10:13:02.079964  /lava-50880/1/../bin/lava-test-case =

    ... (2 line(s) more)  =


  * baseline.bootrr.sun8i-mixer-driver-present: https://kernelci.org/test/c=
ase/id/64d9fe3c2565ac357b35b1e2
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:13:00.973634  /lava-50880/1/../bin/lava-test-case
    2023-08-14T10:13:00.981902  <8>[   35.359802] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-phy-probed RESULT=3Dblocked>
    2023-08-14T10:13:01.995768  /lava-50880/1/../bin/lava-test-case
    2023-08-14T10:13:02.006880  <8>[   36.383916] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-mixer-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-hdmi-phy-driver-present: https://kernelci.org/tes=
t/case/id/64d9fe3c2565ac357b35b1e3
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:12:59.946564  /lava-50880/1/../bin/lava-test-case
    2023-08-14T10:12:59.957961  <8>[   34.334748] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-hdmi-phy-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sunxi-wdt-driver-present: https://kernelci.org/test/cas=
e/id/64d9fe3c2565ac357b35b1e6
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:12:56.825368  /lava-50880/1/../bin/lava-test-case
    2023-08-14T10:12:56.836207  <8>[   31.213751] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsoc-crypto-probed RESULT=3Dblocked>
    2023-08-14T10:12:57.849527  /lava-50880/1/../bin/lava-test-case
    2023-08-14T10:12:57.860610  <8>[   32.238107] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsunxi-wdt-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-ce-driver-present: https://kernelci.org/test/case=
/id/64d9fe3c2565ac357b35b1e7
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:12:54.776880  /lava-50880/1/../bin/lava-test-case
    2023-08-14T10:12:54.786941  <8>[   29.165448] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsid-probed RESULT=3Dblocked>
    2023-08-14T10:12:55.800881  /lava-50880/1/../bin/lava-test-case
    2023-08-14T10:12:55.811749  <8>[   30.189158] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-ce-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.eeprom-sunxi-sid-driver-present: https://kernelci.org/t=
est/case/id/64d9fe3c2565ac357b35b1e8
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:12:53.751596  /lava-50880/1/../bin/lava-test-case
    2023-08-14T10:12:53.763226  <8>[   28.140103] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Deeprom-sunxi-sid-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-dw-hdmi-driver-present: https://kernelci.org/test=
/case/id/64d9fe3c2565ac357b35b1eb
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:12:51.662566  /lava-50880/1/../bin/lava-test-case
    2023-08-14T10:12:51.674084  <8>[   26.051596] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-dw-hdmi-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/64d9fe3c2=
565ac357b35b1ec
        failing since 25 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:12:49.615940  /lava-50880/1/../bin/lava-test-case
    2023-08-14T10:12:49.625892  <8>[   24.004865] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Di2s-probed RESULT=3Dblocked>
    2023-08-14T10:12:50.638846  /lava-50880/1/../bin/lava-test-case
    2023-08-14T10:12:50.648577  <8>[   25.027930] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline.bootrr.sun4i-i2s-driver-present: https://kernelci.org/test/cas=
e/id/64d9fe3c2565ac357b35b1ed
        failing since 25 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:12:47.565364  /lava-50880/1/../bin/lava-test-case
    2023-08-14T10:12:47.576473  <8>[   21.955442] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-digital-probed RESULT=3Dblocked>
    2023-08-14T10:12:48.590979  /lava-50880/1/../bin/lava-test-case
    2023-08-14T10:12:48.601980  <8>[   22.980130] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun4i-i2s-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-codec-driver-present: https://kernelci.org/test/c=
ase/id/64d9fe3c2565ac357b35b1ee
        failing since 25 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:12:45.516536  /lava-50880/1/../bin/lava-test-case
    2023-08-14T10:12:45.527614  <8>[   19.905869] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-analog-probed RESULT=3Dblocked>
    2023-08-14T10:12:46.541334  /lava-50880/1/../bin/lava-test-case
    2023-08-14T10:12:46.552746  <8>[   20.930441] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun50i-codec-analog-driver-present: https://kernelci.or=
g/test/case/id/64d9fe3c2565ac357b35b1ef
        failing since 25 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:12:44.491421  /lava-50880/1/../bin/lava-test-case
    2023-08-14T10:12:44.503469  <8>[   18.880345] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun50i-codec-analog-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d9fe3c2565ac357b35b202
        failing since 25 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:12:41.543043  <8>[   15.922731] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 50880_1.5.2.4.1>
    2023-08-14T10:12:41.650075  / # #
    2023-08-14T10:12:41.752952  export SHELL=3D/bin/sh
    2023-08-14T10:12:41.753664  #
    2023-08-14T10:12:41.855787  / # export SHELL=3D/bin/sh. /lava-50880/env=
ironment
    2023-08-14T10:12:41.856511  =

    2023-08-14T10:12:41.958890  / # . /lava-50880/environment/lava-50880/bi=
n/lava-test-runner /lava-50880/1
    2023-08-14T10:12:41.960067  =

    2023-08-14T10:12:41.964746  / # /lava-50880/bin/lava-test-runner /lava-=
50880/1
    2023-08-14T10:12:41.995472  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 9          =


  Details:     https://kernelci.org/test/plan/id/64d9fe5054a2b4953135b1da

  Results:     24 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig/gcc-10/lab-broonie/ba=
seline-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig/gcc-10/lab-broonie/ba=
seline-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.lima-driver-present: https://kernelci.org/test/case/id/=
64d9fe5054a2b4953135b1dd
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:13:20.813638  /lava-50892/1/../bin/lava-test-case
    2023-08-14T10:13:20.824340  <8>[   33.501298] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-phy-probed RESULT=3Dblocked>
    2023-08-14T10:13:21.837571  /lava-50892/1/../bin/lava-test-case
    2023-08-14T10:13:21.848654  <8>[   34.525511] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlima-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-hdmi-phy-driver-present: https://kernelci.org/tes=
t/case/id/64d9fe5054a2b4953135b1de
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:13:18.763857  /lava-50892/1/../bin/lava-test-case
    2023-08-14T10:13:18.774536  <8>[   31.451887] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-probed RESULT=3Dblocked>
    2023-08-14T10:13:19.788187  /lava-50892/1/../bin/lava-test-case
    2023-08-14T10:13:19.799737  <8>[   32.475806] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-hdmi-phy-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-dw-hdmi-driver-present: https://kernelci.org/test=
/case/id/64d9fe5054a2b4953135b1df
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:13:16.714669  /lava-50892/1/../bin/lava-test-case
    2023-08-14T10:13:16.725358  <8>[   29.402143] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-mixer-probed RESULT=3Dblocked>
    2023-08-14T10:13:17.739057  /lava-50892/1/../bin/lava-test-case
    2023-08-14T10:13:17.750327  <8>[   30.426684] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-dw-hdmi-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-mixer-driver-present: https://kernelci.org/test/c=
ase/id/64d9fe5054a2b4953135b1e0
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:13:14.664975  /lava-50892/1/../bin/lava-test-case
    2023-08-14T10:13:14.676000  <8>[   27.352608] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Danalog-audio-probed RESULT=3Dblocked>
    2023-08-14T10:13:15.689580  /lava-50892/1/../bin/lava-test-case
    2023-08-14T10:13:15.700914  <8>[   28.377225] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-mixer-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8-codec-analog-driver-present: https://kernelci.org/=
test/case/id/64d9fe5054a2b4953135b1e1
        failing since 25 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:13:12.615366  /lava-50892/1/../bin/lava-test-case
    2023-08-14T10:13:12.626044  <8>[   25.303017] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcrypto-probed RESULT=3Dblocked>
    2023-08-14T10:13:13.639610  /lava-50892/1/../bin/lava-test-case
    2023-08-14T10:13:13.651317  <8>[   26.327084] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8-codec-analog-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-ce-driver-present: https://kernelci.org/test/case=
/id/64d9fe5054a2b4953135b1e2
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:13:10.566793  /lava-50892/1/../bin/lava-test-case
    2023-08-14T10:13:10.576577  <8>[   23.254214] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dir-probed RESULT=3Dblocked>
    2023-08-14T10:13:11.590419  /lava-50892/1/../bin/lava-test-case
    2023-08-14T10:13:11.601358  <8>[   24.278001] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-ce-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sunxi-ir-driver-present: https://kernelci.org/test/case=
/id/64d9fe5054a2b4953135b1e3
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:13:09.541840  /lava-50892/1/../bin/lava-test-case
    2023-08-14T10:13:09.552812  <8>[   22.229603] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsunxi-ir-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sunxi-wdt-driver-present: https://kernelci.org/test/cas=
e/id/64d9fe5054a2b4953135b1e6
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:13:06.421900  /lava-50892/1/../bin/lava-test-case
    2023-08-14T10:13:06.431851  <8>[   19.109840] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsid-probed RESULT=3Dblocked>
    2023-08-14T10:13:07.445991  /lava-50892/1/../bin/lava-test-case
    2023-08-14T10:13:07.457053  <8>[   20.133737] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsunxi-wdt-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.eeprom-sunxi-sid-driver-present: https://kernelci.org/t=
est/case/id/64d9fe5054a2b4953135b1e7
        new failure (last pass: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:13:05.396480  /lava-50892/1/../bin/lava-test-case
    2023-08-14T10:13:05.408187  <8>[   18.084365] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Deeprom-sunxi-sid-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9fe1c3af1aead5235b1f0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig/gcc-10/lab-collabora/=
baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/arm64/defconfig/gcc-10/lab-collabora/=
baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d9fe1c3af1aead5235b1f5
        failing since 25 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-08-14T10:14:09.264582  / # #

    2023-08-14T10:14:09.366437  export SHELL=3D/bin/sh

    2023-08-14T10:14:09.366650  #

    2023-08-14T10:14:09.467080  / # export SHELL=3D/bin/sh. /lava-11283147/=
environment

    2023-08-14T10:14:09.467186  =


    2023-08-14T10:14:09.567638  / # . /lava-11283147/environment/lava-11283=
147/bin/lava-test-runner /lava-11283147/1

    2023-08-14T10:14:09.567911  =


    2023-08-14T10:14:09.577994  / # /lava-11283147/bin/lava-test-runner /la=
va-11283147/1

    2023-08-14T10:14:09.641815  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-14T10:14:09.641884  + cd /lava-1128314<8>[   15.595121] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11283147_1.5.2.4.5>
 =

    ... (12 line(s) more)  =

 =20


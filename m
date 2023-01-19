Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C115BC678D4
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 04:30:58 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web11.38552.1674102657730811970
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 20:30:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=gKAtaOAQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id k18so1206187pll.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 20:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n1vJygRczeNgVB+ABBmrz0w5qYQvWZ23pYF/X50/0I8=;
        b=gKAtaOAQwgBRST18dTSxs+wZxe2GXxOzsPTTvShxzwuWVhvfdTLWPvJerMeztZmrPG
         daKcYpniDWsZfYE7rUwwlB4kgGs1U1R/cSDL86YWOVM9sieUYiUvkle2oE6EjyOgP9K+
         GGVrnX8oEhhiHeWZnw3TlkW3dzDMwX9zeF62eownWXsEB86495Mt01pC+nshxXdSy6Gc
         G7i6AIDjd/syyUVw2OpfDS2Lqu13doox5ajkgyFH8sgrc7f/rQDBISexCYGVBD0qMXRa
         7k4u+RmrXcNPalZ35kPpnLqkQktfh5Y3KCX+xs40vY8HbzLyf49HQhhT7olKBVrD62R+
         70BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1vJygRczeNgVB+ABBmrz0w5qYQvWZ23pYF/X50/0I8=;
        b=yPAj3qOUzwPGCbgVv8BkBTP5hC1FBHvbF+5TbNUqCWSQ8fa/I9qjsWu0SGklXDmZJV
         LFBnBmNs3tYKy0QYMBy4fv9nS1IhwvuNYGE7AfEIMJD/BPSA+QwO5iHq+auDIMvZU7Ro
         tAFYYg/EolosVfUbIXx+M5n+MwgMousGVDAw9RYPNiZ2ORsPoD1vCa33IPvarzCdBuGB
         kx+q6spK2utmCknxD4stOSXc1w6Ndkdc1ONbHMNUjs+6gM2OLX0PDgaLh7iqmnBSLnBG
         SaSLI/BA8/Q1y3acvIdX4JBKTmxVg/12nk7ONXOW6IFEBgAfiHD0PY+RmFDpHJ/qJSIE
         EkdA==
X-Gm-Message-State: AFqh2kqf81ivI8h05DUGZoyc7MfcM2qNy3Mh8KPkS2ZV8z+M4D0+3XPz
	I60MVS0CqKcNGWr2Q76eXGJz55ij7Wv8kS/+QU8gvg==
X-Google-Smtp-Source: AMrXdXtUjAVLN5xqPxeR/eXVPcqIfUozuYP91tNXGQI3Fb3H7gkqkvkFR4LVbwPGzsDck6drzvtrZg==
X-Received: by 2002:a17:902:dccc:b0:194:8de9:872a with SMTP id t12-20020a170902dccc00b001948de9872amr9323151pll.34.1674102655247;
        Wed, 18 Jan 2023 20:30:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902a38600b001782aab6318sm23916074pla.68.2023.01.18.20.30.54
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 20:30:54 -0800 (PST)
Message-ID: <63c8c77e.170a0220.a4e27.678c@mx.google.com>
Date: Wed, 18 Jan 2023 20:30:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.269-cip88-rt28-rebase
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 133 runs,
 62 regressions (v4.19.269-cip88-rt28-rebase)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 04:30:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10424

cip-gitlab/ci/pavel/linux-test baseline: 133 runs, 62 regressions (v4.19.26=
9-cip88-rt28-rebase)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

at91-sama5d4_xplained        | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

beagle-xm                    | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 2          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 2          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 2          =

hip07-d05                    | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6sx-sdb                   | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2        | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre    | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre    | gcc-10   | x86_64=
_defconfig             | 1          =

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

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 7          =

sun50i-h6-pine-h64           | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.269-cip88-rt28-rebase/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.269-cip88-rt28-rebase
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      09932a66d6b63564f8b94b34721b1f2d38ea9575 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b73a69ec0d20bb915ec2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8b73a69ec0d20bb915=
ec3
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b7609d734d58fd915ee0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c8b7609d734d58fd915ee5
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:21:47.306460  + set<8>[    7.231152] <LAVA_SIGNAL_ENDRUN =
0_dmesg 8789741_1.4.2.3.1>
    2023-01-19T03:21:47.307107   +x
    2023-01-19T03:21:47.415017  /#
    2023-01-19T03:21:47.518172   # #export SHELL=3D/bin/sh
    2023-01-19T03:21:47.519110  =

    2023-01-19T03:21:47.621124  / # export SHELL=3D/bin/sh. /lava-8789741/e=
nvironment
    2023-01-19T03:21:47.622005  =

    2023-01-19T03:21:47.723994  / # . /lava-8789741/environment/lava-878974=
1/bin/lava-test-runner /lava-8789741/1
    2023-01-19T03:21:47.725294  =

    2023-01-19T03:21:47.730653  / # /lava-8789741/bin/lava-test-runner /lav=
a-8789741/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b74a69ec0d20bb915efa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8b74a69ec0d20bb915=
efb
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b9ce96fcfd5b8c915ed9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c8b9ce96fcfd5b8c915ede
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:32:11.651539  =

    2023-01-19T03:32:11.652716  + set +x
    2023-01-19T03:32:11.659450  <8>[   10.336536] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8789759_1.4.2.3.1>
    2023-01-19T03:32:11.764107  / # #
    2023-01-19T03:32:11.865157  export SHELL=3D/bin/sh
    2023-01-19T03:32:11.865385  #
    2023-01-19T03:32:11.966312  / # export SHELL=3D/bin/sh. /lava-8789759/e=
nvironment
    2023-01-19T03:32:11.966521  =

    2023-01-19T03:32:12.067459  / # . /lava-8789759/environment/lava-878975=
9/bin/lava-test-runner /lava-8789759/1
    2023-01-19T03:32:12.067767   =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b73b69ec0d20bb915ec8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8b73b69ec0d20bb915=
ec9
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8bbe8ed3f4f26fe915f0b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/multi_v7_defconfig/gcc-10/lab-baylibre/bas=
eline-at91-sama5d4_xplained.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/multi_v7_defconfig/gcc-10/lab-baylibre/bas=
eline-at91-sama5d4_xplained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8bbe8ed3f4f26fe915=
f0c
        failing since 63 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f6=
, first fail: v4.19.265-cip85-rt27) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b66797d269072e915eb9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/multi_v7_defconfig/gcc-10/lab-baylibre/bas=
eline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/multi_v7_defconfig/gcc-10/lab-baylibre/bas=
eline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c8b66797d269072e915ebe
        failing since 0 day (last pass: v5.10.145-rt74-1329-ga59fc50f38f6, =
first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:17:45.419112  <8>[   20.933959] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3165846_1.5.2.4.1>
    2023-01-19T03:17:45.526438  / # #
    2023-01-19T03:17:45.627993  export SHELL=3D/bin/sh
    2023-01-19T03:17:45.628401  #
    2023-01-19T03:17:45.729540  / # export SHELL=3D/bin/sh. /lava-3165846/e=
nvironment
    2023-01-19T03:17:45.729902  =

    2023-01-19T03:17:45.831052  / # . /lava-3165846/environment/lava-316584=
6/bin/lava-test-runner /lava-3165846/1
    2023-01-19T03:17:45.831809  =

    2023-01-19T03:17:45.836480  / # /lava-3165846/bin/lava-test-runner /lav=
a-3165846/1
    2023-01-19T03:17:45.924315  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/63c8b722c20d5d0641915f30

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c8b722c20d5d0641915f35
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:20:43.559229  <8>[   11.905304] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 140266_1.5.2.4.1>
    2023-01-19T03:20:43.726997  / # #
    2023-01-19T03:20:43.845303  export SHELL=3D/bin/sh
    2023-01-19T03:20:43.851901  <6>[   11.965589] usb 1-1: new low-speed US=
B device number 3 using musb-hdrc
    2023-01-19T03:20:43.855265  #
    2023-01-19T03:20:43.859776  / # <3>[   12.115754] usb 1-1: device descr=
iptor read/64, error -71
    2023-01-19T03:20:43.863354  export SHELL=3D/bin/sh
    2023-01-19T03:20:43.973526  / # . /lava-140266/environment
    2023-01-19T03:20:44.085823  /lava-140266/bin/lava-test-runner /lava-140=
266/1
    2023-01-19T03:20:44.098423  . /lava-140266/environment =

    ... (17 line(s) more)  =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/63c8b722c20d5d06=
41915f39
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)
        1 lines

    2023-01-19T03:20:42.748672  / # =

    2023-01-19T03:20:42.762812  =

    2023-01-19T03:20:42.915395  / # #
    2023-01-19T03:20:42.925647  #<6>[   11.275576] usb 1-1: new low-speed U=
SB device number 2 using musb-hdrc
    2023-01-19T03:20:42.930785  =

    2023-01-19T03:20:43.043284  / # export SHELL=3D/bin/sh
    2023-01-19T03:20:43.054761  export SHELL=3D/bin/sh
    2023-01-19T03:20:43.164565  / # . /lava-140266/environment
    2023-01-19T03:20:43.171082  <3>[   11.425634] usb 1-1: device descripto=
r read/64, error -71
    2023-01-19T03:20:43.177170  . /lava-140266/environment =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/63c8b8cb7c51e9c3ce915f02

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c8b8cb7c51e9c3ce915f05
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:27:54.142762  <8>[    8.869931] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 828356_1.5.2.4.1>
    2023-01-19T03:27:54.252532  / # #
    2023-01-19T03:27:54.355142  export SHELL=3D/bin/sh
    2023-01-19T03:27:54.355947  #
    2023-01-19T03:27:54.457863  / # export SHELL=3D/bin/sh. /lava-828356/en=
vironment
    2023-01-19T03:27:54.458632  =

    2023-01-19T03:27:54.560587  / # . /lava-828356/environment/lava-828356/=
bin/lava-test-runner /lava-828356/1
    2023-01-19T03:27:54.561845  =

    2023-01-19T03:27:54.567538  / # /lava-828356/bin/lava-test-runner /lava=
-828356/1
    2023-01-19T03:27:54.633997  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/63c8b8cb7c51e9c3=
ce915f09
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)
        1 lines

    2023-01-19T03:27:53.452436  / # =

    2023-01-19T03:27:53.459535  =

    2023-01-19T03:27:53.565798  / # #
    2023-01-19T03:27:53.573009  #
    2023-01-19T03:27:53.675297  / # export SHELL=3D/bin/sh
    2023-01-19T03:27:53.682541  export SHELL=3D/bin/sh
    2023-01-19T03:27:53.784534  / # . /lava-828356/environment
    2023-01-19T03:27:53.790252  . /lava-828356/environment
    2023-01-19T03:27:53.892296  / # /lava-828356/bin/lava-test-runner /lava=
-828356/0
    2023-01-19T03:27:53.899984  /lava-828356/bin/lava-test-runner /lava-828=
356/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b71dc20d5d0641915f0c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/omap2plus_defconfig/gcc-10/lab-broonie/bas=
eline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/63c8b71dc20d5d06=
41915f15
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)
        1 lines

    2023-01-19T03:20:36.480044  / # =

    2023-01-19T03:20:36.488313  =

    2023-01-19T03:20:36.592403  / # #
    2023-01-19T03:20:36.815203  #
    2023-01-19T03:20:36.916785  / # export SHELL=3D/bin/sh
    2023-01-19T03:20:36.924501  export SHELL=3D/bin/sh
    2023-01-19T03:20:37.025886  / # . /lava-140299/environment
    2023-01-19T03:20:37.033790  . /lava-140299/environment
    2023-01-19T03:20:37.135383  / # /lava-140299/bin/lava-test-runner /lava=
-140299/0
    2023-01-19T03:20:37.140111  /lava-140299/bin/lava-test-runner /lava-140=
299/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 2          =


  Details:     https://kernelci.org/test/plan/id/63c8bbff54e7788350915ed0

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/omap2plus_defconfig/gcc-10/lab-cip/baselin=
e-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c8bbff54e7788350915ed3
        new failure (last pass: v4.19.269-rt119-858-g4aae57dbf650)

    2023-01-19T03:41:33.815935  + set +x<8>[   10.699895] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 828366_1.5.2.4.1>
    2023-01-19T03:41:33.816449  =

    2023-01-19T03:41:33.929660  / # #
    2023-01-19T03:41:34.032275  export SHELL=3D/bin/sh
    2023-01-19T03:41:34.033097  #
    2023-01-19T03:41:34.135086  / # export SHELL=3D/bin/sh. /lava-828366/en=
vironment
    2023-01-19T03:41:34.135951  =

    2023-01-19T03:41:34.237882  / # . /lava-828366/environment/lava-828366/=
bin/lava-test-runner /lava-828366/1
    2023-01-19T03:41:34.239199  =

    2023-01-19T03:41:34.245395  / # /lava-828366/bin/lava-test-runner /lava=
-828366/1 =

    ... (12 line(s) more)  =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/63c8bbff54e77883=
50915ed7
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)
        1 lines

    2023-01-19T03:41:32.809466  / # =

    2023-01-19T03:41:32.820858  =

    2023-01-19T03:41:32.927916  / # #
    2023-01-19T03:41:32.938850  #
    2023-01-19T03:41:33.041417  / # export SHELL=3D/bin/sh
    2023-01-19T03:41:33.051081  export SHELL=3D/bin/sh
    2023-01-19T03:41:33.153100  / # . /lava-828366/environment
    2023-01-19T03:41:33.163673  . /lava-828366/environment
    2023-01-19T03:41:33.265721  / # /lava-828366/bin/lava-test-runner /lava=
-828366/0
    2023-01-19T03:41:33.274219  /lava-828366/bin/lava-test-runner /lava-828=
366/0 =

    ... (9 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hip07-d05                    | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8bd0ddefb7b73df915efc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-co=
llabora/baseline-hip07-d05.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-co=
llabora/baseline-hip07-d05.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8bd0ddefb7b73df915=
efd
        new failure (last pass: v4.19.269-rt119-858-g4aae57dbf650) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b65303adf377c2915ef4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/multi_v7_defconfig/gcc-10/lab-collabora/ba=
seline-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c8b65303adf377c2915ef9
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:17:24.422172  + set +x
    2023-01-19T03:17:24.426697  <8>[    7.902692] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 8789709_1.5.2.4.1>
    2023-01-19T03:17:24.533943  #
    2023-01-19T03:17:24.535395  =

    2023-01-19T03:17:24.638064  / # #export SHELL=3D/bin/sh
    2023-01-19T03:17:24.638981  =

    2023-01-19T03:17:24.741028  / # export SHELL=3D/bin/sh. /lava-8789709/e=
nvironment
    2023-01-19T03:17:24.741950  =

    2023-01-19T03:17:24.844023  / # . /lava-8789709/environment/lava-878970=
9/bin/lava-test-runner /lava-8789709/1
    2023-01-19T03:17:24.845635   =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b68297d269072e915ed9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix=
/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix=
/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c8b68297d269072e915ede
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:18:18.727046  + set +x[    7.222765] <LAVA_SIGNAL_ENDRUN =
0_dmesg 882850_1.5.2.3.1>
    2023-01-19T03:18:18.727220  =

    2023-01-19T03:18:18.833891  / # #
    2023-01-19T03:18:18.935582  export SHELL=3D/bin/sh
    2023-01-19T03:18:18.936069  #
    2023-01-19T03:18:19.037313  / # export SHELL=3D/bin/sh. /lava-882850/en=
vironment
    2023-01-19T03:18:19.037893  =

    2023-01-19T03:18:19.139161  / # . /lava-882850/environment/lava-882850/=
bin/lava-test-runner /lava-882850/1
    2023-01-19T03:18:19.139743  =

    2023-01-19T03:18:19.142551  / # /lava-882850/bin/lava-test-runner /lava=
-882850/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b632153c76e295915ecf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/=
baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/=
baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c8b632153c76e295915ed4
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:16:59.288068  + set +x
    2023-01-19T03:16:59.288262  [    5.016403] <LAVA_SIGNAL_ENDRUN 0_dmesg =
882848_1.5.2.3.1>
    2023-01-19T03:16:59.394366  / # #
    2023-01-19T03:16:59.496076  export SHELL=3D/bin/sh
    2023-01-19T03:16:59.496617  #
    2023-01-19T03:16:59.597846  / # export SHELL=3D/bin/sh. /lava-882848/en=
vironment
    2023-01-19T03:16:59.598368  =

    2023-01-19T03:16:59.699703  / # . /lava-882848/environment/lava-882848/=
bin/lava-test-runner /lava-882848/1
    2023-01-19T03:16:59.700304  =

    2023-01-19T03:16:59.703140  / # /lava-882848/bin/lava-test-runner /lava=
-882848/1 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6sx-sdb                   | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b68797d269072e915ee7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline=
-imx6sx-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline=
-imx6sx-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c8b68797d269072e915eea
        failing since 0 day (last pass: v5.10.145-rt74-1329-ga59fc50f38f6, =
first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:18:00.704230  <8>[   18.627083] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1140461_1.5.2.4.1>
    2023-01-19T03:18:00.809776  / # #
    2023-01-19T03:18:01.969712  export SHELL=3D/bin/sh
    2023-01-19T03:18:01.975399  #
    2023-01-19T03:18:03.523287  / # export SHELL=3D/bin/sh. /lava-1140461/e=
nvironment
    2023-01-19T03:18:03.528997  =

    2023-01-19T03:18:06.351469  / # . /lava-1140461/environment/lava-114046=
1/bin/lava-test-runner /lava-1140461/1
    2023-01-19T03:18:06.357531  =

    2023-01-19T03:18:06.366164  / # /lava-1140461/bin/lava-test-runner /lav=
a-1140461/1
    2023-01-19T03:18:06.455108  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b8799c69197d7f915eb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-ju=
no-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-ju=
no-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8b8799c69197d7f915=
eba
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b86dfdcd9a34b4915ee1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-me=
son-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-me=
son-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8b86dfdcd9a34b4915=
ee2
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b85cd31a869c03915ec8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-baylibre/baseline-q=
emu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-baylibre/baseline-q=
emu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8b85cd31a869c03915=
ec9
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b8c40bb9f2c613915ed5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8b8c40bb9f2c613915=
ed6
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8ba0d2fcad9b3cd915ec8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-qe=
mu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-qe=
mu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8ba0d2fcad9b3cd915=
ec9
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8bb3adc11311cba915efe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8bb3adc11311cba915=
eff
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2        | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b80ad490e35408915ece

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-collabora/baseline-=
qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-collabora/baseline-=
qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8b80ad490e35408915=
ecf
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b8c20bb9f2c613915ecf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-baylibre/baseline-q=
emu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-baylibre/baseline-q=
emu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8b8c20bb9f2c613915=
ed0
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-858-g4aae57dbf650) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b8c57c51e9c3ce915ed7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8b8c57c51e9c3ce915=
ed8
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b9d15906947e42915ef1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-qe=
mu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-qe=
mu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8b9d15906947e42915=
ef2
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-858-g4aae57dbf650) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8bb75c62209aa0c915f4b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8bb75c62209aa0c915=
f4c
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b8097151971aea915ed6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-collabora/baseline-=
qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-collabora/baseline-=
qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8b8097151971aea915=
ed7
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-858-g4aae57dbf650) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv2-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b80c7151971aea915ee9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8b80c7151971aea915=
eea
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b8859c69197d7f915ece

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8b8859c69197d7f915=
ecf
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-858-g4aae57dbf650) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b8c30bb9f2c613915ed2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-baylibre/baseline-q=
emu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-baylibre/baseline-q=
emu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8b8c30bb9f2c613915=
ed3
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8bad5c810bb057a915ec7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-qe=
mu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-qe=
mu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8bad5c810bb057a915=
ec8
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8bc3e332d2ac486915f96

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8bc3e332d2ac486915=
f97
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-858-g4aae57dbf650) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b8027151971aea915ec2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-co=
llabora/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8b8027151971aea915=
ec3
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-858-g4aae57dbf650) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b85dfdcd9a34b4915eb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-ba=
ylibre/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8b85dfdcd9a34b4915=
eba
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b8872fa84f9cd4915eba

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-baylibre/baseline-q=
emu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-baylibre/baseline-q=
emu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8b8872fa84f9cd4915=
ebb
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8bca223b3eae8d6915eda

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8bca223b3eae8d6915=
edb
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8bcde9f8f87f183915f4e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-qe=
mu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-broonie/baseline-qe=
mu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8bcde9f8f87f183915=
f4f
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_arm64-virt-gicv3-uefi   | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b80bd490e35408915ed3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-collabora/baseline-=
qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-collabora/baseline-=
qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8b80bd490e35408915=
ed4
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre    | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b78182536d61c3915edf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-baylibre/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-baylibre/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8b78182536d61c3915=
ee0
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre    | gcc-10   | x86_64=
_defconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b7e43fec4f56e5915ecb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/ba=
seline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/ba=
seline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8b7e43fec4f56e5915=
ecc
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-858-g4aae57dbf650) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b869fdcd9a34b4915ec0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-broonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-broonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8b869fdcd9a34b4915=
ec1
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-broonie     | gcc-10   | x86_64=
_defconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b96df6c23919b8915ee9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig/gcc-10/lab-broonie/bas=
eline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8b96df6c23919b8915=
eea
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-858-g4aae57dbf650) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b73a69ec0d20bb915ec5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8b73a69ec0d20bb915=
ec6
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b78d1a902cafe3915ed5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig/gcc-10/lab-collabora/b=
aseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8b78d1a902cafe3915=
ed6
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-858-g4aae57dbf650) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b8466e2e023c87915ee8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/shmobile_defconfig/gcc-10/lab-cip/baseline=
-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/shmobile_defconfig/gcc-10/lab-cip/baseline=
-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c8b8466e2e023c87915=
ee9
        failing since 0 day (last pass: v4.19.269-rt119-1495-gc851fb1e222f,=
 first fail: v4.19.269-rt119-858-g4aae57dbf650) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 7          =


  Details:     https://kernelci.org/test/plan/id/63c8b722c20d5d0641915f3b

  Results:     79 PASS, 9 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-co=
llabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-co=
llabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rk3399-gru-sound-driver-rt5514-present: https://kernelc=
i.org/test/case/id/63c8b722c20d5d0641915f72
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:20:59.013758  00:20:44 UTC) multi-call binary.
    2023-01-19T03:20:59.014201  =

    2023-01-19T03:20:59.014847  =

    2023-01-19T03:20:59.018677  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST
    2023-01-19T03:20:59.019414  =

    2023-01-19T03:20:59.019782  =

    2023-01-19T03:20:59.033299  Print numbers from FIRST to LAST, in steps =
of<8>[   34.701829] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-d=
river-rt5514-present RESULT=3Dfail>   =


  * baseline.bootrr.rk3399-gru-sound-driver-max98357A-present: https://kern=
elci.org/test/case/id/63c8b722c20d5d0641915f73
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:20:58.989057  =

    2023-01-19T03:20:58.991312  -w	Pad to last with leading zeros
    2023-01-19T03:20:58.993901  	-s SEP	String separator
    2023-01-19T03:20:58.997509  /lava-8789802/1/../bin/lava-test-case
    2023-01-19T03:20:59.011302  BusyBox v1.31.1 (2023-01-15 <8>[   34.67904=
3] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drk3399-gru-sound-driver-max98357A-p=
resent RESULT=3Dfail>   =


  * baseline.bootrr.rk3399-gru-sound-driver-dp-present: https://kernelci.or=
g/test/case/id/63c8b722c20d5d0641915f74
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:20:58.966293  <8>[   34.636377] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drk3399-gru-sound-driver-da7219-present RESULT=3Dfail>
    2023-01-19T03:20:58.969624  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST
    2023-01-19T03:20:58.970064  =

    2023-01-19T03:20:58.975009  Print numbers from FIRST to LAST, in steps =
of INC.
    2023-01-19T03:20:58.975757  =

    2023-01-19T03:20:58.977086  FIRST, INC default to 1.
    2023-01-19T03:20:58.977822  =

    2023-01-19T03:20:58.978492  =

    2023-01-19T03:20:58.987161  	<8>[   34.656077] <LAVA_SIGNAL_TESTCASE TE=
ST_CASE_ID=3Drk3399-gru-sound-driver-dp-present RESULT=3Dfail>   =


  * baseline.bootrr.rk3399-gru-sound-driver-da7219-present: https://kernelc=
i.org/test/case/id/63c8b722c20d5d0641915f75
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:20:58.954199  BusyBox v1.31.1 (2023-01-15 00:20:44 UTC) m=
ulti-call binary.
    2023-01-19T03:20:58.955021  =

    2023-01-19T03:20:58.955718     =


  * baseline.bootrr.cros-ec-sysfs-driver-present: https://kernelci.org/test=
/case/id/63c8b722c20d5d0641915f7c
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:20:56.805518  =

    2023-01-19T03:20:57.814625  /lava-8789802/1/../bin/lava-test-case
    2023-01-19T03:20:57.823631  <8>[   33.497718] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sysfs-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-lightbar-driver-present: https://kernelci.org/t=
est/case/id/63c8b722c20d5d0641915f85
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:20:55.636373  /lava-8789802/1/../bin/lava-test-case<8>[  =
 31.310513] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dcros-ec-keyb-probed RESULT=
=3Dpass>
    2023-01-19T03:20:55.637083  =

    2023-01-19T03:20:55.637180  =

    2023-01-19T03:20:56.654031  /lava-8789802/1/../bin/lava-test-case<8>[  =
 32.328108] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dcros-ec-lightbar-driver-pr=
esent RESULT=3Dfail>   =


  * baseline.bootrr.cros-ec-debugfs-driver-present: https://kernelci.org/te=
st/case/id/63c8b722c20d5d0641915f8e
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:20:53.451893  =

    2023-01-19T03:20:54.468603  /lava-8789802/1/../bin/lava-test-case
    2023-01-19T03:20:54.478043  <8>[   30.151928] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-debugfs-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b721c20d5d0641915f25

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-baylibre/baseline-s=
un50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-baylibre/baseline-s=
un50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c8b721c20d5d0641915f2a
        failing since 0 day (last pass: v5.10.145-cip17-rt7, first fail: v4=
.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:20:39.235366  / # #
    2023-01-19T03:20:39.337102  export SHELL=3D/bin/sh
    2023-01-19T03:20:39.337740  #
    2023-01-19T03:20:39.439110  / # export SHELL=3D/bin/sh. /lava-3165878/e=
nvironment
    2023-01-19T03:20:39.439629  =

    2023-01-19T03:20:39.540997  / # . /lava-3165878/environment/lava-316587=
8/bin/lava-test-runner /lava-3165878/1
    2023-01-19T03:20:39.541639  =

    2023-01-19T03:20:39.546381  / # /lava-3165878/bin/lava-test-runner /lav=
a-3165878/1
    2023-01-19T03:20:39.616280  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-19T03:20:39.616759  + cd /lava-3165878<8>[   15.622959] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 3165878_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b71bc20d5d0641915ec2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-collabora/baseline-=
sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig/gcc-10/lab-collabora/baseline-=
sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c8b71bc20d5d0641915ec7
        failing since 0 day (last pass: v5.10.145-cip17-rt7, first fail: v4=
.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:20:45.215035  / # #
    2023-01-19T03:20:45.316821  export SHELL=3D/bin/sh
    2023-01-19T03:20:45.317308  #
    2023-01-19T03:20:45.418646  / # export SHELL=3D/bin/sh. /lava-8789792/e=
nvironment
    2023-01-19T03:20:45.419163  =

    2023-01-19T03:20:45.520553  / # . /lava-8789792/environment/lava-878979=
2/bin/lava-test-runner /lava-8789792/1
    2023-01-19T03:20:45.521352  =

    2023-01-19T03:20:45.524683  / # /lava-8789792/bin/lava-test-runner /lav=
a-8789792/1
    2023-01-19T03:20:45.595638  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-19T03:20:45.595942  + cd /lava-8789792<8>[   15.613527] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 8789792_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b6990cb28c399c915ec6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/multi_v7_defconfig/gcc-10/lab-baylibre/bas=
eline-sun8i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/multi_v7_defconfig/gcc-10/lab-baylibre/bas=
eline-sun8i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c8b6990cb28c399c915ecb
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:18:22.213527  / # #
    2023-01-19T03:18:22.315204  export SHELL=3D/bin/sh
    2023-01-19T03:18:22.315548  #
    2023-01-19T03:18:22.416855  / # export SHELL=3D/bin/sh. /lava-3165850/e=
nvironment
    2023-01-19T03:18:22.417203  =

    2023-01-19T03:18:22.518532  / # . /lava-3165850/environment/lava-316585=
0/bin/lava-test-runner /lava-3165850/1
    2023-01-19T03:18:22.519180  =

    2023-01-19T03:18:22.524895  / # /lava-3165850/bin/lava-test-runner /lav=
a-3165850/1
    2023-01-19T03:18:22.622778  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-19T03:18:22.623257  + cd /lava-3165850/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b61dc62f58bc97915ef2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseli=
ne-sun8i-h2-plus-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseli=
ne-sun8i-h2-plus-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c8b61dc62f58bc97915ef7
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:16:19.188597  + set +x
    2023-01-19T03:16:19.190774  <8>[    7.960445] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3165825_1.5.2.4.1>
    2023-01-19T03:16:19.295916  / # #
    2023-01-19T03:16:19.397701  export SHELL=3D/bin/sh
    2023-01-19T03:16:19.398192  #
    2023-01-19T03:16:19.499532  / # export SHELL=3D/bin/sh. /lava-3165825/e=
nvironment
    2023-01-19T03:16:19.500003  =

    2023-01-19T03:16:19.601409  / # . /lava-3165825/environment/lava-316582=
5/bin/lava-test-runner /lava-3165825/1
    2023-01-19T03:16:19.602205  =

    2023-01-19T03:16:19.621425  / # /lava-3165825/bin/lava-test-runner /lav=
a-3165825/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b65b89c0edfca5915ed3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/multi_v7_defconfig/gcc-10/lab-baylibre/bas=
eline-sun8i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/multi_v7_defconfig/gcc-10/lab-baylibre/bas=
eline-sun8i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c8b65b89c0edfca5915ed8
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:17:21.467209  / # #
    2023-01-19T03:17:21.568940  export SHELL=3D/bin/sh
    2023-01-19T03:17:21.569292  #
    2023-01-19T03:17:21.670615  / # export SHELL=3D/bin/sh. /lava-3165837/e=
nvironment
    2023-01-19T03:17:21.670980  =

    2023-01-19T03:17:21.772366  / # . /lava-3165837/environment/lava-316583=
7/bin/lava-test-runner /lava-3165837/1
    2023-01-19T03:17:21.773148  =

    2023-01-19T03:17:21.792792  / # /lava-3165837/bin/lava-test-runner /lav=
a-3165837/1
    2023-01-19T03:17:21.874777  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-19T03:17:21.875374  + cd /lava-3165837/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b6191b4a53fbbe915eba

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseli=
ne-sun8i-h3-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseli=
ne-sun8i-h3-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c8b6191b4a53fbbe915ebf
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-01-19T03:16:16.983281  / # #
    2023-01-19T03:16:17.084980  export SHELL=3D/bin/sh
    2023-01-19T03:16:17.085329  #
    2023-01-19T03:16:17.186647  / # export SHELL=3D/bin/sh. /lava-3165823/e=
nvironment
    2023-01-19T03:16:17.187001  =

    2023-01-19T03:16:17.288416  / # . /lava-3165823/environment/lava-316582=
3/bin/lava-test-runner /lava-3165823/1
    2023-01-19T03:16:17.289029  =

    2023-01-19T03:16:17.294526  / # /lava-3165823/bin/lava-test-runner /lav=
a-3165823/1
    2023-01-19T03:16:17.373402  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-19T03:16:17.373885  + cd /lava-3165823/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20


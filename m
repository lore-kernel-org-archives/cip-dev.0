Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF314CD80B7
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 11:51:07 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
 by mx.groups.io with SMTP id smtpd.web11.89012.1696938658902563355
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 10 Oct 2023 04:50:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=rwFmt2Gy;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.51, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1dd54aca17cso4131837fac.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 10 Oct 2023 04:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696938658; x=1697543458; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QvdIXpv6U840y4wLB7OixW5PFbwax4pPX9y0xLtIri4=;
        b=rwFmt2GyhkxOqmcxZxVP5C5mqxVv62fN9tUFAqhgIJa10ZvyjYWKpuHIFSJXd9uI0A
         fvyCXMLT7jozZFYPXpUf3flBfccNm18Kt7+36TIZQQcNbtpcSuN5JbUPSqxivDMYsamK
         WGCHzZ6u/7A1QFaOs8w/1VPnn7Ub3ygYE5sxPtVmwpqlScY2iHKkxW0ncVDSvb5QhhOS
         zhQyPptqx4MJrDEYx7m1DBt8yg627JmZOSpp24TP1SFACy9zCMZGQ5AWsgmNzKSLkTL8
         tJbY+NUsKsaM31/30nwWU51lxab9fLdd+NyFHyLu/kVGOoTRBq+nGlCO+d37hAC1+60w
         3HAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696938658; x=1697543458;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QvdIXpv6U840y4wLB7OixW5PFbwax4pPX9y0xLtIri4=;
        b=ASZ1SrQtVFyMHEEwDfA+sPD7RE/8uHf3YynV6ZKYzZ4rp8mUqxILUZU2ML3vKqu4oW
         UnXJ0D443sqa7dhxlv/BfKdU8WN8/zYp3olA4XCGBB3XH6CKCvFeI6tn+W1n51vEf/07
         Gcs+1/2K1pxam4Cm7SVo0Bj1ZmsqCkIqGHkoLD5aetL7jFicMHJFtRieXNs0Wqt/Bf1x
         QPXposYtaYX7zqq6eHhutP3miOxFa2b7t8Vz2515SJ4QZqIcoTMMqaVjdxAsLADf8Vc9
         bApNqayy2vSppgZBgVN3aKf9WSMWG3wJ82umu6nQhaSXZyu972NMiE+p1SQyEcVyYHOh
         IMOQ==
X-Gm-Message-State: AOJu0YzPvY5MVCMLjindIOvFbEwANqP0gms9AVYskj/vdEroJx5kW7bF
	2WoQZ0u4TfgC3xmGug8mCXDN0xc42MRojX14JfUReQ==
X-Google-Smtp-Source: AGHT+IE5xcYbppr+xgkyQDY0oABskv+df59llD7QGe0UEU/c3SBoYkIvUUdy9NhVEmum4kigiB0N4A==
X-Received: by 2002:a05:6870:d7a7:b0:1dc:7e71:d475 with SMTP id bd39-20020a056870d7a700b001dc7e71d475mr19216723oab.4.1696938656482;
        Tue, 10 Oct 2023 04:50:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l24-20020a62be18000000b0069323619f69sm8265524pff.143.2023.10.10.04.50.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 04:50:55 -0700 (PDT)
Message-ID: <65253a9f.620a0220.59c36.3b38@mx.google.com>
Date: Tue, 10 Oct 2023 04:50:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-553-gd498c00818b88
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline: 120 runs,
 76 regressions (v5.10.194-553-gd498c00818b88)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 11:51:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13361

cip-gitlab/ci/pavel/linux-test baseline: 120 runs, 76 regressions (v5.10.19=
4-553-gd498c00818b88)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig            | 3          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 2          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 7          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 7          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 10         =

kontron-kbox-a-230-ls        | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =

kontron-sl28-var3-ads2       | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig              | 1          =

qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 5          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =

rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 5          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-553-gd498c00818b88/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-553-gd498c00818b88
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d498c00818b8876a72d6eb6c2498058ec80d51bb =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cbv514-1h-34uz-brya     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65252f1f26ec61668defcf3b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65252f1f26ec61668defc=
f3c
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | at91_d=
t_defconfig            | 3          =


  Details:     https://kernelci.org/test/plan/id/652531e72446de9abfefcef3

  Results:     49 PASS, 4 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/at91_dt_defconfig/gcc-10/lab-broonie/base=
line-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/at91_dt_defconfig/gcc-10/lab-broonie/base=
line-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/652=
531e72446de9abfefcefc
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:13:21.229530  /lava-160567/1/../bin/lava-test-case
    2023-10-10T11:13:21.267335  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =


  * baseline.bootrr.wm8731-driver-present: https://kernelci.org/test/case/i=
d/652531e72446de9abfefcf07
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:13:17.026678  /lava-160567/1/../bin/lava-test-case
    2023-10-10T11:13:17.065148  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Deep=
rom-probed RESULT=3Dblocked>
    2023-10-10T11:13:17.107675  sh: /sys/bus/spi/drivers/wm8731: unknown op=
erand
    2023-10-10T11:13:18.128132  /lava-160567/1/../bin/lava-test-case
    2023-10-10T11:13:18.166548  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dwm8=
731-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.at24-driver-present: https://kernelci.org/test/case/id/=
652531e72446de9abfefcf08
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:13:15.924964  /lava-160567/1/../bin/lava-test-case
    2023-10-10T11:13:15.964094  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dat2=
4-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 2          =


  Details:     https://kernelci.org/test/plan/id/6525306bc0f99dcf33efcf4f

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/multi_v5_defconfig/gcc-10/lab-broonie/bas=
eline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/multi_v5_defconfig/gcc-10/lab-broonie/bas=
eline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id/652=
5306bc0f99dcf33efcf58
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:07:08.511233  /lava-160527/1/../bin/lava-test-case
    2023-10-10T11:07:08.549028  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525306bc0f99dcf33efcf88
        failing since 18 days (last pass: v5.10.194-cip39-500-gc5c4e5fc1681=
7, first fail: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-10T11:06:53.999438  + set +x
    2023-10-10T11:06:53.999961  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 160527_1.5.2=
.4.1>
    2023-10-10T11:06:54.113809  / # #
    2023-10-10T11:06:54.216848  export SHELL=3D/bin/sh
    2023-10-10T11:06:54.217651  #
    2023-10-10T11:06:54.319651  / # export SHELL=3D/bin/sh. /lava-160527/en=
vironment
    2023-10-10T11:06:54.320449  =

    2023-10-10T11:06:54.422469  / # . /lava-160527/environment/lava-160527/=
bin/lava-test-runner /lava-160527/1
    2023-10-10T11:06:54.423826  =

    2023-10-10T11:06:54.427421  / # /lava-160527/bin/lava-test-runner /lava=
-160527/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/6525314e91b965c04aefcf46

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/bcm2835_defconfig/gcc-10/lab-collabora/ba=
seline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/bcm2835_defconfig/gcc-10/lab-collabora/ba=
seline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525314e91b965c04aefcf4f
        failing since 54 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-10-10T11:15:08.098793  / # #

    2023-10-10T11:15:08.200921  export SHELL=3D/bin/sh

    2023-10-10T11:15:08.201622  #

    2023-10-10T11:15:08.302947  / # export SHELL=3D/bin/sh. /lava-11724105/=
environment

    2023-10-10T11:15:08.303653  =


    2023-10-10T11:15:08.405146  / # . /lava-11724105/environment/lava-11724=
105/bin/lava-test-runner /lava-11724105/1

    2023-10-10T11:15:08.406249  =


    2023-10-10T11:15:08.423117  / # /lava-11724105/bin/lava-test-runner /la=
va-11724105/1

    2023-10-10T11:15:08.487229  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-10T11:15:08.531208  + cd /lava-11724105/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/652530afc90e6ce424efcf2b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652530afc90e6ce424efc=
f2c
        failing since 54 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/6525311982648c40e8efcf15

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/652531198=
2648c40e8efcf1c
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:09:54.912576  /lava-160546/1/../bin/lava-test-case
    2023-10-10T11:09:54.948107  <8>[   47.290185] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/65=
25311982648c40e8efcf1d
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:09:53.851510  /lava-160546/1/../bin/lava-test-case
    2023-10-10T11:09:53.887447  <8>[   46.228693] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/6525311982648c40e8efcf1f
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:09:51.676908  /lava-160546/1/../bin/lava-test-case
    2023-10-10T11:09:51.715541  <8>[   44.056710] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-10-10T11:09:52.741745  /lava-160546/1/../bin/lava-test-case
    2023-10-10T11:09:52.780351  <8>[   45.118895] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
6525311982648c40e8efcf20
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:09:49.556408  /lava-160546/1/../bin/lava-test-case
    2023-10-10T11:09:49.590013  <8>[   41.931031] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-10-10T11:09:50.616568  /lava-160546/1/../bin/lava-test-case
    2023-10-10T11:09:50.650444  <8>[   42.991515] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/6525311982648c40e8efcf21
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:09:47.436289  /lava-160546/1/../bin/lava-test-case
    2023-10-10T11:09:47.469447  <8>[   39.811340] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-10-10T11:09:48.496059  /lava-160546/1/../bin/lava-test-case
    2023-10-10T11:09:48.529838  <8>[   40.870406] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/6525311982648c40e8efcf2d
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:09:35.512207  /lava-160546/1/../bin/lava-test-case
    2023-10-10T11:09:35.549009  <8>[   27.888973] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525311982648c40e8efcf46
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:09:29.776021  <8>[   22.116534] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 160546_1.5.2.4.1>
    2023-10-10T11:09:29.885296  / # #
    2023-10-10T11:09:29.988416  export SHELL=3D/bin/sh
    2023-10-10T11:09:29.989377  #
    2023-10-10T11:09:30.091453  / # export SHELL=3D/bin/sh. /lava-160546/en=
vironment
    2023-10-10T11:09:30.092362  =

    2023-10-10T11:09:30.194557  / # . /lava-160546/environment/lava-160546/=
bin/lava-test-runner /lava-160546/1
    2023-10-10T11:09:30.195988  =

    2023-10-10T11:09:30.200445  / # /lava-160546/bin/lava-test-runner /lava=
-160546/1
    2023-10-10T11:09:30.294127  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 7          =


  Details:     https://kernelci.org/test/plan/id/6525389a586e5774e1efd21a

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/multi_v7_defconfig/gcc-10/lab-cip/baselin=
e-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/multi_v7_defconfig/gcc-10/lab-cip/baselin=
e-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525389a586e5774e1efd221
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:41:32.018972  + set +x
    2023-10-10T11:41:32.021008  <8>[   16.495785] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1018718_1.5.2.4.1>
    2023-10-10T11:41:32.129962  / # #
    2023-10-10T11:41:32.231890  export SHELL=3D/bin/sh
    2023-10-10T11:41:32.232360  #
    2023-10-10T11:41:32.333737  / # export SHELL=3D/bin/sh. /lava-1018718/e=
nvironment
    2023-10-10T11:41:32.334189  =

    2023-10-10T11:41:32.435570  / # . /lava-1018718/environment/lava-101871=
8/bin/lava-test-runner /lava-1018718/1
    2023-10-10T11:41:32.436311  =

    2023-10-10T11:41:32.438438  / # /lava-1018718/bin/lava-test-runner /lav=
a-1018718/1 =

    ... (12 line(s) more)  =


  * baseline.bootrr.cpsw-switch-driver-present: https://kernelci.org/test/c=
ase/id/6525389a586e5774e1efd23a
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:41:37.749957  /lava-1018718/1/../bin/lava-test-case
    2023-10-10T11:41:37.786232  <8>[   22.259298] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.tda19988-driver-present: https://kernelci.org/test/case=
/id/6525389a586e5774e1efd246
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:41:49.682133  /lava-1018718/1/../bin/lava-test-case
    2023-10-10T11:41:49.711766  <8>[   34.186313] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlcdc-probed RESULT=3Dblocked>
    2023-10-10T11:41:50.739900  /lava-1018718/1/../bin/lava-test-case
    2023-10-10T11:41:50.775257  <8>[   35.249126] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.mcasp-driver-loaded: https://kernelci.org/test/case/id/=
6525389a586e5774e1efd247
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:41:51.801753  /lava-1018718/1/../bin/lava-test-case
    2023-10-10T11:41:51.835868  <8>[   36.310142] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtda19988-probed RESULT=3Dblocked>
    2023-10-10T11:41:52.862302  /lava-1018718/1/../bin/lava-test-case
    2023-10-10T11:41:52.895984  <8>[   37.370280] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp-driver-loaded RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-codec-driver-present: https://kernelci.org/test/ca=
se/id/6525389a586e5774e1efd248
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:41:53.922803  /lava-1018718/1/../bin/lava-test-case
    2023-10-10T11:41:53.955730  <8>[   38.430261] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmcasp0-probed RESULT=3Dblocked>
    2023-10-10T11:41:54.982087  /lava-1018718/1/../bin/lava-test-case
    2023-10-10T11:41:55.017057  <8>[   39.490755] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio-probed: https://kernelci.org/test/case/id/65=
25389a586e5774e1efd24a
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:41:56.090175  /lava-1018718/1/../bin/lava-test-case
    2023-10-10T11:41:56.124899  <8>[   40.599377] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio-probed RESULT=3Dfail>   =


  * baseline.bootrr.hdmi-audio: https://kernelci.org/test/case/id/6525389a5=
86e5774e1efd24b
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:41:57.150285  /lava-1018718/1/../bin/lava-test-case
    2023-10-10T11:41:57.183967  <8>[   41.659155] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dhdmi-audio RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6525302cdbcb6a6935efcef9

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/omap2plus_defconfig/gcc-10/lab-cip/baseli=
ne-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cpsw-switch-probed: https://kernelci.org/test/case/id/6=
525302cdbcb6a6935efcf1b
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:06:11.547961  /lava-1018699/1/../bin/lava-test-case
    2023-10-10T11:06:11.581930  <8>[   16.964227] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcpsw-switch-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525341b20ba227e2befcf8e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-l=
s1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-l=
s1028a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525341b20ba227e2befcf95
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:22:52.494959  + [   23.999267] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1253985_1.5.2.4.1>
    2023-10-10T11:22:52.495274  set +x
    2023-10-10T11:22:52.600514  =

    2023-10-10T11:22:52.701716  / # #export SHELL=3D/bin/sh
    2023-10-10T11:22:52.702114  =

    2023-10-10T11:22:52.803104  / # export SHELL=3D/bin/sh. /lava-1253985/e=
nvironment
    2023-10-10T11:22:52.803532  =

    2023-10-10T11:22:52.904543  / # . /lava-1253985/environment/lava-125398=
5/bin/lava-test-runner /lava-1253985/1
    2023-10-10T11:22:52.905243  =

    2023-10-10T11:22:52.909380  / # /lava-1253985/bin/lava-test-runner /lav=
a-1253985/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65252e13fffc789f87efcef3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65252e13fffc789f87efcefc
        failing since 54 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-10-10T10:57:12.161268  <8>[    9.297088] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11723950_1.4.2.3.1>

    2023-10-10T10:57:12.164920  + set +x

    2023-10-10T10:57:12.270789  #

    2023-10-10T10:57:12.373892  / # #export SHELL=3D/bin/sh

    2023-10-10T10:57:12.374796  =


    2023-10-10T10:57:12.476372  / # export SHELL=3D/bin/sh. /lava-11723950/=
environment

    2023-10-10T10:57:12.477175  =


    2023-10-10T10:57:12.579148  / # . /lava-11723950/environment/lava-11723=
950/bin/lava-test-runner /lava-11723950/1

    2023-10-10T10:57:12.580288  =


    2023-10-10T10:57:12.585373  / # /lava-11723950/bin/lava-test-runner /la=
va-11723950/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65252f790595c434abefcfb2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/ba=
seline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/ba=
seline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65252f790595c434abefc=
fb3
        failing since 48 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, fir=
st fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-udoo                  | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65253249a37cbe1232efcfde

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65253249a37cbe1232efc=
fdf
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65252f7a1d76632c69efcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/ba=
seline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/ba=
seline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65252f7a1d76632c69efc=
ef4
        failing since 48 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, fir=
st fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-udoo                   | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525325debb8f7d1e4efcf04

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/multi_v7_defconfig/gcc-10/lab-broonie/bas=
eline-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6525325debb8f7d1e4efc=
f05
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65252ddffcd74cc55fefcf0c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutroni=
x/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutroni=
x/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65252ddffcd74cc55fefcf15
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:56:24.346163  + set +x
    2023-10-10T10:56:24.346345  [   10.467723] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1002890_1.5.2.3.1>
    2023-10-10T10:56:24.454288  / # #
    2023-10-10T10:56:24.555965  export SHELL=3D/bin/sh
    2023-10-10T10:56:24.556445  #
    2023-10-10T10:56:24.657828  / # export SHELL=3D/bin/sh. /lava-1002890/e=
nvironment
    2023-10-10T10:56:24.658262  =

    2023-10-10T10:56:24.759507  / # . /lava-1002890/environment/lava-100289=
0/bin/lava-test-runner /lava-1002890/1
    2023-10-10T10:56:24.760099  =

    2023-10-10T10:56:24.762986  / # /lava-1002890/bin/lava-test-runner /lav=
a-1002890/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6525304b0fb5466305efcf18

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/multi_v7_defconfig/gcc-10/lab-pengutronix=
/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/multi_v7_defconfig/gcc-10/lab-pengutronix=
/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525304b0fb5466305efcf21
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:06:31.102068  + set[    7.237672] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1002895_1.5.2.3.1>
    2023-10-10T11:06:31.102276   +x
    2023-10-10T11:06:31.208008  / # #
    2023-10-10T11:06:31.309628  export SHELL=3D/bin/sh
    2023-10-10T11:06:31.310116  #
    2023-10-10T11:06:31.411425  / # export SHELL=3D/bin/sh. /lava-1002895/e=
nvironment
    2023-10-10T11:06:31.411906  =

    2023-10-10T11:06:31.513196  / # . /lava-1002895/environment/lava-100289=
5/bin/lava-test-runner /lava-1002895/1
    2023-10-10T11:06:31.513897  =

    2023-10-10T11:06:31.516058  / # /lava-1002895/bin/lava-test-runner /lav=
a-1002895/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65252e3e067906a4c1efcf3e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/baseli=
ne-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/imx_v6_v7_defconfig/gcc-10/lab-nxp/baseli=
ne-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
65252e3e067906a4c1efcf46
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T10:57:54.240089  /lava-1253978/1/../bin/lava-test-case
    2023-10-10T10:57:54.272076  <8>[   31.209075] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dall-cpus-are-online RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/652530aac90e6ce424efcefb

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/multi_v7_defconfig/gcc-10/lab-nxp/baselin=
e-imx7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/multi_v7_defconfig/gcc-10/lab-nxp/baselin=
e-imx7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.all-cpus-are-online: https://kernelci.org/test/case/id/=
652530aac90e6ce424efcf03
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:08:01.291621  /lava-1253981/1/../bin/lava-test-case
    2023-10-10T11:08:01.312646  <8>[   24.930801] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dall-cpus-are-online RESULT=3Dfail>
    2023-10-10T11:08:01.312971  /lava-1253981/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 10         =


  Details:     https://kernelci.org/test/plan/id/65253490e4837fca3cefcef5

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-broonie/baseline-j=
uno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-broonie/baseline-j=
uno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.led7-probed: https://kernelci.org/test/case/id/65253490=
e4837fca3cefcf06
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:24:52.934983  /lava-160609/1/../bin/lava-test-case
    2023-10-10T11:24:52.958044  <8>[   28.511431] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>
    2023-10-10T11:24:52.958553  /lava-160609/1/../bin/lava-test-case   =


  * baseline.bootrr.led6-probed: https://kernelci.org/test/case/id/65253490=
e4837fca3cefcf07
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:24:51.905918  /lava-160609/1/../bin/lava-test-case
    2023-10-10T11:24:51.927944  <8>[   27.481913] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline.bootrr.led5-probed: https://kernelci.org/test/case/id/65253490=
e4837fca3cefcf08
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:24:50.876827  /lava-160609/1/../bin/lava-test-case
    2023-10-10T11:24:50.898857  <8>[   26.453102] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline.bootrr.led4-probed: https://kernelci.org/test/case/id/65253490=
e4837fca3cefcf09
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:24:49.847706  /lava-160609/1/../bin/lava-test-case
    2023-10-10T11:24:49.869768  <8>[   25.423479] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline.bootrr.led3-probed: https://kernelci.org/test/case/id/65253490=
e4837fca3cefcf0a
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:24:48.817666  /lava-160609/1/../bin/lava-test-case
    2023-10-10T11:24:48.840661  <8>[   24.394185] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline.bootrr.led2-probed: https://kernelci.org/test/case/id/65253490=
e4837fca3cefcf0b
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:24:47.788624  /lava-160609/1/../bin/lava-test-case
    2023-10-10T11:24:47.810600  <8>[   23.364846] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled2-probed RESULT=3Dfail>   =


  * baseline.bootrr.led1-probed: https://kernelci.org/test/case/id/65253490=
e4837fca3cefcf0c
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:24:46.758579  /lava-160609/1/../bin/lava-test-case
    2023-10-10T11:24:46.781650  <8>[   22.335497] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline.bootrr.led0-probed: https://kernelci.org/test/case/id/65253490=
e4837fca3cefcf0d
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:24:45.730581  /lava-160609/1/../bin/lava-test-case
    2023-10-10T11:24:45.751626  <8>[   21.305738] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =


  * baseline.bootrr.iommu1-probed: https://kernelci.org/test/case/id/652534=
90e4837fca3cefcf20
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:24:44.270834  /lava-160609/1/../bin/lava-test-case
    2023-10-10T11:24:44.274075  <8>[   19.828785] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>   =


  * baseline.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case/id/=
65253490e4837fca3cefcf2d
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:24:42.520869  <6>[   18.063908] input: PS/2 Generic Mouse=
 as /devices/platform/bus@8000000/bus@8000000:motherboard-bus/bus@8000000:m=
otherboard-bus:iofpga-bus@300000000/1c070000.kmi/serio1/input/input4
    2023-10-10T11:24:42.632577  <4>[   18.189650] psmouse serio1: Failed to=
 enable mouse on 1c070000.kmi
    2023-10-10T11:24:42.935096  /lava-160609/1/../bin/lava-test-case
    2023-10-10T11:24:42.938373  <8>[   18.489923] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =


  Details:     https://kernelci.org/test/plan/id/652533f068cbc1329befcfa4

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-kontron/baseline-k=
ontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-kontron/baseline-k=
ontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
652533f068cbc1329befcfe8
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:22:00.818452  /lava-384910/1/../bin/lava-test-case
    2023-10-10T11:22:00.821735  <8>[   13.434995] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/652533f068cbc1329befcfe9
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:22:01.830262  /lava-384910/1/../bin/lava-test-case
    2023-10-10T11:22:01.833393  <8>[   14.451981] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-10-10T11:22:02.853999  /lava-384910/1/../bin/lava-test-case   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/652533f068cbc1329befd000
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:22:05.280560  /lava-384910/1/../bin/lava-test-case
    2023-10-10T11:22:05.283883  <8>[   17.896367] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 3          =


  Details:     https://kernelci.org/test/plan/id/652533dcb05d0c41d3efcf00

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-kontron/baseline-k=
ontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-kontron/baseline-k=
ontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rcpm-driver-present: https://kernelci.org/test/case/id/=
652533dcb05d0c41d3efcf4b
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:21:48.438976  /lava-384909/1/../bin/lava-test-case
    2023-10-10T11:21:48.442277  <8>[   10.914890] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/652533dcb05d0c41d3efcf4c
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:21:49.451336  /lava-384909/1/../bin/lava-test-case
    2023-10-10T11:21:49.454665  <8>[   11.932748] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-10-10T11:21:50.474138  /lava-384909/1/../bin/lava-test-case   =


  * baseline.bootrr.layerscape-sfp-driver-present: https://kernelci.org/tes=
t/case/id/652533dcb05d0c41d3efcf61
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:21:52.896956  /lava-384909/1/../bin/lava-test-case
    2023-10-10T11:21:52.900324  <8>[   15.372938] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/652533c9ae183f4b7befcf25

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-b=
roonie/baseline-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-b=
roonie/baseline-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/652533c9a=
e183f4b7befcf2c
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:21:19.994273  /lava-160577/1/../bin/lava-test-case
    2023-10-10T11:21:20.005896  <8>[   19.085123] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>
    2023-10-10T11:21:20.006231  + set +x   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525346d6f96063721efcf5b

  Results:     51 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-broonie/baseline-m=
eson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-broonie/baseline-m=
eson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/6525346d6=
f96063721efcf62
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:24:00.995138  /lava-160627/1/../bin/lava-test-case
    2023-10-10T11:24:01.005145  <8>[   19.088039] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6525324d763472aa96efcefa

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525324d763472aa96efcf1a
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:15:13.871148  + set +x

    2023-10-10T11:15:13.879540  <8>[   15.645305] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11724198_1.5.2.3.1>

    2023-10-10T11:15:13.984680  / # #

    2023-10-10T11:15:14.087037  export SHELL=3D/bin/sh

    2023-10-10T11:15:14.087999  #

    2023-10-10T11:15:14.189689  / # export SHELL=3D/bin/sh. /lava-11724198/=
environment

    2023-10-10T11:15:14.190593  =


    2023-10-10T11:15:14.292640  / # . /lava-11724198/environment/lava-11724=
198/bin/lava-test-runner /lava-11724198/1

    2023-10-10T11:15:14.293794  =


    2023-10-10T11:15:14.295863  / # /lava-11724198/bin/lava-test-runner /la=
va-11724198/1
 =

    ... (21 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-broonie     | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/652532b3763472aa96efcf2b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/mips/malta_defconfig/gcc-10/lab-broonie/basel=
ine-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/mips/malta_defconfig/gcc-10/lab-broonie/basel=
ine-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652532b3763472aa96efc=
f2c
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/65253298763472aa96efcf26

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/mips/malta_defconfig/gcc-10/lab-collabora/bas=
eline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/mips/malta_defconfig/gcc-10/lab-collabora/bas=
eline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65253298763472aa96efc=
f27
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/652531a62f86cc6028efcf01

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/shmobile_defconfig/gcc-10/lab-cip/baselin=
e-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/shmobile_defconfig/gcc-10/lab-cip/baselin=
e-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652531a62f86cc6028efc=
f02
        failing since 20 days (last pass: v6.1.52-cip5-29-g9fee06894d496, f=
irst fail: v5.10.194-cip39-500-gc5c4e5fc16817) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/652532fe21f103d269efcefa

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652532fe21f103d269efcf01
        failing since 41 days (last pass: v6.1.46-cip4-rt2, first fail: v5.=
10.191-cip38-2-g05fb42f86d06a)

    2023-10-10T11:17:56.630367  + set +x
    2023-10-10T11:17:56.630496  <8>[   83.935350] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1018744_1.5.2.4.1>
    2023-10-10T11:17:56.736850  / # #
    2023-10-10T11:17:58.196326  export SHELL=3D/bin/sh
    2023-10-10T11:17:58.216770  #
    2023-10-10T11:17:58.216955  / # export SHELL=3D/bin/sh
    2023-10-10T11:18:00.168950  / # . /lava-1018744/environment
    2023-10-10T11:18:03.760464  /lava-1018744/bin/lava-test-runner /lava-10=
18744/1
    2023-10-10T11:18:03.781159  . /lava-1018744/environment
    2023-10-10T11:18:03.781283  / # /lava-1018744/bin/lava-test-runner /lav=
a-1018744/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/652533231ce7acf192efcf41

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/baseline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/baseline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652533231ce7acf192efcf48
        failing since 54 days (last pass: v4.19.288-cip101-1117-g1f3468542a=
a9e, first fail: v5.10.186-cip37-16-gf8567732a40d)

    2023-10-10T11:18:32.238943  + set +x
    2023-10-10T11:18:32.239050  <8>[   84.203932] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1018748_1.5.2.4.1>
    2023-10-10T11:18:32.344483  / # #
    2023-10-10T11:18:33.803687  export SHELL=3D/bin/sh
    2023-10-10T11:18:33.824145  #
    2023-10-10T11:18:33.824354  / # export SHELL=3D/bin/sh
    2023-10-10T11:18:35.776504  / # . /lava-1018748/environment
    2023-10-10T11:18:39.367139  /lava-1018748/bin/lava-test-runner /lava-10=
18748/1
    2023-10-10T11:18:39.387782  . /lava-1018748/environment
    2023-10-10T11:18:39.387903  / # /lava-1018748/bin/lava-test-runner /lav=
a-1018748/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/652532ea83268ba3c2efcef7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652532ea83268ba3c2efcefe
        failing since 18 days (last pass: v5.10.194-cip39-500-gc5c4e5fc1681=
7, first fail: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-10T11:17:34.396685  / # #
    2023-10-10T11:17:35.855955  export SHELL=3D/bin/sh
    2023-10-10T11:17:35.876373  #
    2023-10-10T11:17:35.876526  / # export SHELL=3D/bin/sh
    2023-10-10T11:17:37.828456  / # . /lava-1018741/environment
    2023-10-10T11:17:41.419608  /lava-1018741/bin/lava-test-runner /lava-10=
18741/1
    2023-10-10T11:17:41.440238  . /lava-1018741/environment
    2023-10-10T11:17:41.440441  / # /lava-1018741/bin/lava-test-runner /lav=
a-1018741/1
    2023-10-10T11:17:41.520311  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-10T11:17:41.520453  + cd /lava-1018741/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652534641a48b2d67befcf77

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-cip/baseline-r8a77=
4c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-cip/baseline-r8a77=
4c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652534641a48b2d67befcf7e
        failing since 18 days (last pass: v5.10.194-cip39-500-gc5c4e5fc1681=
7, first fail: v6.1.54-cip6-101-gb060fea6ba099)

    2023-10-10T11:23:52.419005  / # #
    2023-10-10T11:23:53.878472  export SHELL=3D/bin/sh
    2023-10-10T11:23:53.898899  #
    2023-10-10T11:23:53.899071  / # export SHELL=3D/bin/sh
    2023-10-10T11:23:55.851070  / # . /lava-1018760/environment
    2023-10-10T11:23:59.443178  /lava-1018760/bin/lava-test-runner /lava-10=
18760/1
    2023-10-10T11:23:59.463834  . /lava-1018760/environment
    2023-10-10T11:23:59.463953  / # /lava-1018760/bin/lava-test-runner /lav=
a-1018760/1
    2023-10-10T11:23:59.542544  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-10T11:23:59.542720  + cd /lava-1018760/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652533e268cbc1329befcf0a

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-collabora/baseline=
-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-collabora/baseline=
-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652533e268cbc1329befcf13
        failing since 82 days (last pass: v6.1.31-65-geef5a19d48f6, first f=
ail: v5.10.186-cip37-2-gfcd111609480)

    2023-10-10T11:26:23.550881  / # #

    2023-10-10T11:26:23.653130  export SHELL=3D/bin/sh

    2023-10-10T11:26:23.653853  #

    2023-10-10T11:26:23.755187  / # export SHELL=3D/bin/sh. /lava-11724281/=
environment

    2023-10-10T11:26:23.755902  =


    2023-10-10T11:26:23.857317  / # . /lava-11724281/environment/lava-11724=
281/bin/lava-test-runner /lava-11724281/1

    2023-10-10T11:26:23.858474  =


    2023-10-10T11:26:23.875185  / # /lava-11724281/bin/lava-test-runner /la=
va-11724281/1

    2023-10-10T11:26:23.924096  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-10T11:26:23.924605  + cd /lav<8>[   16.415016] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11724281_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 5          =


  Details:     https://kernelci.org/test/plan/id/6525305ec0f99dcf33efcef3

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm/multi_v7_defconfig/gcc-10/lab-collabora/b=
aseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/test=
/case/id/6525305ec0f99dcf33efcf0d
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:11:22.642488  <8>[   21.170923] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-iodomain-driver-present RESULT=3Dpass>
   =


  * baseline.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/test/=
case/id/6525305ec0f99dcf33efcf23
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:11:21.230084  /lava-11724040/1/../bin/lava-test-case<8>[ =
  19.759299] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwmmc_rockchip-sdmmc-prob=
ed RESULT=3Dfail>

    2023-10-10T11:11:21.230142  =


    2023-10-10T11:11:22.241538  /lava-11724040/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/6525305ec0f99dcf33efcf24
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:11:20.209122  	-w	P<8>[   18.734721] <LAVA_SIGNAL_TESTCAS=
E TEST_CASE_ID=3Ddwmmc_rockchip-driver-present RESULT=3Dpass>

    2023-10-10T11:11:20.212306  ad to last with leading zeros

    2023-10-10T11:11:20.214747  	-s SEP	String separator

    2023-10-10T11:11:20.218711  /lava-11724040/1/../bin/lava-test-case

    2023-10-10T11:11:20.224695  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-10-10T11:11:20.224930  =


    2023-10-10T11:11:20.229111  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-10-10T11:11:20.229338  =


    2023-10-10T11:11:20.234440  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-10-10T11:11:20.236957  FIRST, INC default to 1.
 =

    ... (5 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6525305ec0f99dcf33efcf27
        failing since 262 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-10-10T11:11:20.136575  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   18.664840] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-10-10T11:11:20.138525   multi-call binary.

    2023-10-10T11:11:20.138578  =


    2023-10-10T11:11:20.143036  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-10-10T11:11:20.143282  =


    2023-10-10T11:11:20.148401  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6525305ec0f99dcf33efcf28
        failing since 262 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-10-10T11:11:20.117552  /lava-11724040/1/../bin/lava-test-case<8>[ =
  18.647163] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed RE=
SULT=3Dpass>

    2023-10-10T11:11:20.117607  =

   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/65253275ee77618a15efcef9

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/65253276ee77618a15efcf03
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:17:15.895681  /lava-11724197/1/../bin/lava-test-case

    2023-10-10T11:17:15.905970  <8>[   34.981447] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/65253276ee77618a15efcf04
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:17:14.858281  /lava-11724197/1/../bin/lava-test-case

    2023-10-10T11:17:14.869791  <8>[   33.944257] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525340f20ba227e2befcf3c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-collabora/baseline=
-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-collabora/baseline=
-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525340f20ba227e2befcf45
        failing since 20 days (last pass: v5.10.191-cip38-29-g9e1aa2001db86=
, first fail: v5.10.194-cip39-500-gc5c4e5fc16817)

    2023-10-10T11:22:47.596631  / # #

    2023-10-10T11:22:48.857181  export SHELL=3D/bin/sh

    2023-10-10T11:22:48.868072  #

    2023-10-10T11:22:48.868503  / # export SHELL=3D/bin/sh

    2023-10-10T11:22:50.612027  / # . /lava-11724278/environment

    2023-10-10T11:22:53.816088  /lava-11724278/bin/lava-test-runner /lava-1=
1724278/1

    2023-10-10T11:22:53.827487  . /lava-11724278/environment

    2023-10-10T11:22:53.831840  / # /lava-11724278/bin/lava-test-runner /la=
va-11724278/1

    2023-10-10T11:22:53.882890  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-10T11:22:53.883375  + cd /lava-11724278/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 5          =


  Details:     https://kernelci.org/test/plan/id/6525340220ba227e2befcef4

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-broonie/baseline-s=
un50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-broonie/baseline-s=
un50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/652534022=
0ba227e2befcf0c
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:22:34.098864  /lava-160638/1/../bin/lava-test-case
    2023-10-10T11:22:34.110286  <8>[   25.405835] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Di2s-probed RESULT=3Dblocked>
    2023-10-10T11:22:35.134152  /lava-160638/1/../bin/lava-test-case
    2023-10-10T11:22:35.145263  <8>[   26.440956] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsound-card RESULT=3Dfail>   =


  * baseline.bootrr.sun4i-i2s-driver-present: https://kernelci.org/test/cas=
e/id/6525340220ba227e2befcf0d
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:22:32.025176  /lava-160638/1/../bin/lava-test-case
    2023-10-10T11:22:32.036895  <8>[   23.331948] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-digital-probed RESULT=3Dblocked>
    2023-10-10T11:22:33.062675  /lava-160638/1/../bin/lava-test-case
    2023-10-10T11:22:33.074270  <8>[   24.369054] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun4i-i2s-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun8i-codec-driver-present: https://kernelci.org/test/c=
ase/id/6525340220ba227e2befcf0e
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:22:29.952897  /lava-160638/1/../bin/lava-test-case
    2023-10-10T11:22:29.964282  <8>[   21.258807] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcodec-analog-probed RESULT=3Dblocked>
    2023-10-10T11:22:30.990205  /lava-160638/1/../bin/lava-test-case
    2023-10-10T11:22:31.002155  <8>[   22.295911] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8i-codec-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.sun50i-codec-analog-driver-present: https://kernelci.or=
g/test/case/id/6525340220ba227e2befcf0f
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:22:28.916234  /lava-160638/1/../bin/lava-test-case
    2023-10-10T11:22:28.929125  <8>[   20.222522] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun50i-codec-analog-driver-present RESULT=3Dfail>   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6525340220ba227e2befcf22
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2023-10-10T11:22:25.759437  + set +x
    2023-10-10T11:22:25.763463  <8>[   17.059695] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 160638_1.5.2.4.1>
    2023-10-10T11:22:25.874655  / # #
    2023-10-10T11:22:25.977270  export SHELL=3D/bin/sh
    2023-10-10T11:22:25.978067  #
    2023-10-10T11:22:26.080005  / # export SHELL=3D/bin/sh. /lava-160638/en=
vironment
    2023-10-10T11:22:26.080641  =

    2023-10-10T11:22:26.182724  / # . /lava-160638/environment/lava-160638/=
bin/lava-test-runner /lava-160638/1
    2023-10-10T11:22:26.184030  =

    2023-10-10T11:22:26.188085  / # /lava-160638/bin/lava-test-runner /lava=
-160638/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6525341620ba227e2befcf53

  Results:     40 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-broonie/baseline-s=
un50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-broonie/baseline-s=
un50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.sun8-codec-analog-driver-present: https://kernelci.org/=
test/case/id/6525341620ba227e2befcf7f
        failing since 26 days (last pass: v6.1.46-cip4-14-gb994de8f45440, f=
irst fail: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-10-10T11:22:57.580264  /lava-160616/1/../bin/lava-test-case
    2023-10-10T11:22:57.597482  <8>[   20.029967] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsun8-codec-analog-driver-present RESULT=3Dfail>   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65253336d3657481e6efcf36

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/baseline-zynqmp-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/baseline-zynqmp-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65253336d3657481e6efc=
f37
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
zynqmp-zcu102                | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652534eeabe3464acbefcf05

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-cip/baseline-zynqm=
p-zcu102.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-553-gd498c00818b88/arm64/defconfig/gcc-10/lab-cip/baseline-zynqm=
p-zcu102.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652534eeabe3464acbefc=
f06
        failing since 6 days (last pass: v6.1.54-cip6-101-gb060fea6ba099, f=
irst fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =20


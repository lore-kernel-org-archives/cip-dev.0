Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022DEC10F09
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 17:42:06 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web10.42550.1702057320995556137
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Dec 2023 09:42:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=cEnZQdxg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ce9e897aeaso1907557b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 08 Dec 2023 09:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702057320; x=1702662120; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OzXJTDVghqF1qjZaQnHWI8PFBn9f1DCxPu4KOxlm5Lc=;
        b=cEnZQdxgMXPUsjmtb/GnmyMK8+L7TBbfsOUJmBjL/dxPuOiPz6//sufhaQGcjv16Rq
         LqLcrXJKlFT+KEBwyKs2hFAgOvWfEnaWqPb15PC7Rrlwm3BkRoshsJIHJ2i+WBqGrbaa
         FhfPkpCm+G/izHxNVXrGGZtYYsaND25H9HLJn2ii0YDKUistUYg/qGBv8MPK7HZRgIS0
         sobsFDtIChbfh45IP1RUCN0zEkADW8nRNZBO9ls0ce4WGF2byrJEflvssRZiwdZx5RRJ
         x+yxiYmntsgjpwYjCDCWd71EM/KILzJJynPb39cJ/4LU/v/Uo7q0lY9EtuDWJ4Xg2+xf
         nf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702057320; x=1702662120;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OzXJTDVghqF1qjZaQnHWI8PFBn9f1DCxPu4KOxlm5Lc=;
        b=kuMT6giVTckgPLeQbBxNUP7ht+4c4hrJRuvQCsbfQ/xPhGK11yLszoBVusEFFaE4JC
         V/Gvn2OBJc61mYPxXDLihXZrpBtPgR0dVbj5DPoPvaVpDs/viCsINLEzjEYFPdrAN12c
         2crvBvzP80bf+dp9zw/gBaLDHgd9iIT2nkkCysXu5nvYOI+p4cyg9wX0+Oc2DJ/LAU+k
         uekZb1a/WqwO/Mc9HwwVEkYwKAufFkfR+QUbnr1kjOKZjgqAeU4FQv+ZtpBcJSbTTVCG
         5wdyP7+d6OLInzExjyMZ0mpft0LIsAJuvewogwURKE25hk3LmsW7C+JTQxGekSWiDtjJ
         GSdw==
X-Gm-Message-State: AOJu0Yz5iBxU3G2cJ3aq+usUiXucJgdc0AwRl7B/pmkDwI279hdvLjTO
	ni+6qdlFk6YS6+qneLAE13UzNmNTE6JDr9u9N0B5rw==
X-Google-Smtp-Source: AGHT+IHOqMyM55y6Vqjd7adigw6rRqcJhKkANLyy7VoB0H8hQPKEavrbjXZTUs6ifW6UJlVNihZ+yg==
X-Received: by 2002:a05:6a00:2394:b0:6cb:a2f7:83d with SMTP id f20-20020a056a00239400b006cba2f7083dmr476415pfc.19.1702057319868;
        Fri, 08 Dec 2023 09:41:59 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fb6-20020a056a002d8600b006ce95e37a40sm1827362pfb.111.2023.12.08.09.41.58
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:41:59 -0800 (PST)
Message-ID: <65735567.050a0220.2b396.654d@mx.google.com>
Date: Fri, 08 Dec 2023 09:41:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-63-gfdfe1fbf93bc6
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 34 runs,
 20 regressions (v5.10.201-cip41-63-gfdfe1fbf93bc6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 17:42:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13978

cip-gitlab/ci/pavel/linux-test baseline-nfs: 34 runs, 20 regressions (v5.10=
.201-cip41-63-gfdfe1fbf93bc6)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
acer-cbv514-1h-34uz-brya  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

acer-chromebox-cxi5-brask | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

at91sam9g20ek             | arm    | lab-broonie   | gcc-10   | at91_dt_def=
config          | 1          =

at91sam9g20ek             | arm    | lab-broonie   | gcc-10   | multi_v5_de=
fconfig         | 1          =

juno-uboot                | arm64  | lab-broonie   | gcc-10   | defconfig  =
                | 10         =

kontron-kbox-a-230-ls     | arm64  | lab-kontron   | gcc-10   | defconfig  =
                | 3          =

kontron-sl28-var3-ads2    | arm64  | lab-kontron   | gcc-10   | defconfig  =
                | 3          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-cip41-63-gfdfe1fbf93bc6/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-cip41-63-gfdfe1fbf93bc6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      fdfe1fbf93bc6fe6ed2708f11c2613bef556fdeb =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
acer-cbv514-1h-34uz-brya  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65734cdb532bc49123e1347b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-cbv514-1h-34uz-brya.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65734cdb532bc4912=
3e1347c
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
acer-chromebox-cxi5-brask | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65734ce16f3d243b6ee1347c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-chromebox-cxi5-brask.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/baseline-nfs-acer-chromebox-cxi5-brask.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65734ce16f3d243b6=
ee1347d
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
at91sam9g20ek             | arm    | lab-broonie   | gcc-10   | at91_dt_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/65734a700e215f48e8e1347c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm/at91_dt_defconfig/gcc-10/lab-broonie=
/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65734a700e215f48e=
8e1347d
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
at91sam9g20ek             | arm    | lab-broonie   | gcc-10   | multi_v5_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65734908638adc66c7e13479

  Results:     48 PASS, 6 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.gpio-keys-probed: https://kernelci.org/test/case/id=
/65734908638adc66c7e13482
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T16:48:59.434823  /lava-326638/1/../bin/lava-test-case
    2023-12-08T16:48:59.522533  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dgpi=
o-keys-probed RESULT=3Dfail>   =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
juno-uboot                | arm64  | lab-broonie   | gcc-10   | defconfig  =
                | 10         =


  Details:     https://kernelci.org/test/plan/id/657351a1c35340c214e13480

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-broonie/basel=
ine-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.led7-probed: https://kernelci.org/test/case/id/6573=
51a1c35340c214e13491
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:25:34.871883  /lava-326762/1/../bin/lava-test-case
    2023-12-08T17:25:34.916475  <8>[   72.830027] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled7-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led6-probed: https://kernelci.org/test/case/id/6573=
51a1c35340c214e13492
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:25:33.788821  /lava-326762/1/../bin/lava-test-case
    2023-12-08T17:25:33.832415  <8>[   71.745915] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled6-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led5-probed: https://kernelci.org/test/case/id/6573=
51a1c35340c214e13493
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:25:32.701588  /lava-326762/1/../bin/lava-test-case
    2023-12-08T17:25:32.749250  <8>[   70.662859] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled5-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led4-probed: https://kernelci.org/test/case/id/6573=
51a1c35340c214e13494
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:25:31.609636  /lava-326762/1/../bin/lava-test-case
    2023-12-08T17:25:31.662560  <8>[   69.574338] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled4-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led3-probed: https://kernelci.org/test/case/id/6573=
51a1c35340c214e13495
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:25:30.510753  /lava-326762/1/../bin/lava-test-case
    2023-12-08T17:25:30.570687  <8>[   68.483969] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled3-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led2-probed: https://kernelci.org/test/case/id/6573=
51a1c35340c214e13496
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:25:28.966765  <4>[   66.860607] amba 20010000.etf: deferr=
ed probe timeout, ignoring dependency
    2023-12-08T17:25:28.967368  <4>[   66.867797] amba 20030000.tpiu: defer=
red probe timeout, ignoring dependency
    2023-12-08T17:25:28.967783  <4>[   66.875070] amba 20040000.funnel: def=
erred probe timeout, ignoring dependency
    2023-12-08T17:25:28.968468  <4>[   66.882511] amba 20070000.etr: deferr=
ed probe timeout, ignoring dependency
    2023-12-08T17:25:28.968859  <4>[   66.889686] amba 20100000.stm: deferr=
ed probe timeout, ignoring dependency
    2023-12-08T17:25:29.010124  <4>[   66.896861] amba 20120000.replicator:=
 deferred probe timeout, ignoring dependency
    2023-12-08T17:25:29.010653  <4>[   66.904644] amba 22010000.cpu-debug: =
deferred probe timeout, ignoring dependency
    2023-12-08T17:25:29.011038  <4>[   66.912341] amba 22040000.etm: deferr=
ed probe timeout, ignoring dependency
    2023-12-08T17:25:29.011719  <4>[   66.919514] amba 220c0000.funnel: def=
erred probe timeout, ignoring dependency
    2023-12-08T17:25:29.012120  <4>[   66.926954] amba 22110000.cpu-debug: =
deferred probe timeout, ignoring dependency =

    ... (12 line(s) more)  =


  * baseline-nfs.bootrr.led1-probed: https://kernelci.org/test/case/id/6573=
51a1c35340c214e13497
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:25:28.349820  /lava-326762/1/../bin/lava-test-case
    2023-12-08T17:25:28.391684  <8>[   66.304970] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.led0-probed: https://kernelci.org/test/case/id/6573=
51a1c35340c214e13498
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:25:26.647231  <4>[   64.557539] arm-smmu 2b600000.iommu: =
deferred probe timeout, ignoring dependency
    2023-12-08T17:25:26.650413  <4>[   64.565243] arm-smmu: probe of 2b6000=
00.iommu failed with error -110
    2023-12-08T17:25:27.273743  /lava-326762/1/../bin/lava-test-case
    2023-12-08T17:25:27.310667  <8>[   65.223511] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dled0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.iommu1-probed: https://kernelci.org/test/case/id/65=
7351a1c35340c214e134ab
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:25:25.001805  /lava-326762/1/../bin/lava-test-case
    2023-12-08T17:25:25.055651  <8>[   62.969333] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Diommu1-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.1c050000_mmc-probed: https://kernelci.org/test/case=
/id/657351a1c35340c214e134b8
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:25:23.073575  /lava-326762/1/../bin/lava-test-case
    2023-12-08T17:25:23.114519  <8>[   61.029382] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3D1c050000.mmc-probed RESULT=3Dfail>   =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
kontron-kbox-a-230-ls     | arm64  | lab-kontron   | gcc-10   | defconfig  =
                | 3          =


  Details:     https://kernelci.org/test/plan/id/65734ca5bfc9baf041e13486

  Results:     89 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/65734ca5bfc9baf041e134c6
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:04:06.782419  /lava-403469/1/../bin/lava-test-case
    2023-12-08T17:04:06.813188  <8>[   16.833159] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/65734ca5bfc9baf041e134c7
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:04:07.820832  /lava-403469/1/../bin/lava-test-case
    2023-12-08T17:04:07.852755  <8>[   17.875063] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-12-08T17:04:08.876245  /lava-403469/1/../bin/lava-test-case
    2023-12-08T17:04:08.897139  <8>[   18.914972] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/65734ca5bfc9baf041e134de
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:04:11.732401  /lava-403469/1/../bin/lava-test-case
    2023-12-08T17:04:11.757276  <8>[   21.776344] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
kontron-sl28-var3-ads2    | arm64  | lab-kontron   | gcc-10   | defconfig  =
                | 3          =


  Details:     https://kernelci.org/test/plan/id/65734ca1dcc10261c6e134be

  Results:     97 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-kontron/basel=
ine-nfs-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rcpm-driver-present: https://kernelci.org/test/case=
/id/65734ca1dcc10261c6e13505
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:04:04.489251  /lava-403468/1/../bin/lava-test-case
    2023-12-08T17:04:04.518141  <8>[   16.751411] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.ftm-alarm-driver-present: https://kernelci.org/test=
/case/id/65734ca1dcc10261c6e13506
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:04:05.525837  /lava-403468/1/../bin/lava-test-case
    2023-12-08T17:04:05.551856  <8>[   17.784936] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dblocked>
    2023-12-08T17:04:06.559496  /lava-403468/1/../bin/lava-test-case
    2023-12-08T17:04:06.589489  <8>[   18.822845] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>   =


  * baseline-nfs.bootrr.layerscape-sfp-driver-present: https://kernelci.org=
/test/case/id/65734ca1dcc10261c6e1351b
        failing since 2 days (last pass: v6.1.64-cip10-rt5, first fail: v5.=
10.201-cip41-16-g3c85fba3b6e5d)

    2023-12-08T17:04:09.383188  /lava-403468/1/../bin/lava-test-case
    2023-12-08T17:04:09.408215  <8>[   21.641350] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dlayerscape-sfp-driver-present RESULT=3Dfail>   =

 =20


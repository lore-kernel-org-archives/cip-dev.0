Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5756AC54E4A
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 19:50:26 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.33379.1709322624124550638
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 11:50:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Bz5QFkOF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc0d11d1b7so23005035ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 11:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709322623; x=1709927423; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dgy1ZU4725alB/ybUlDdAT+tgM7qe4kvtI2mA04TtYk=;
        b=Bz5QFkOFDR748nOyRdTD/cD3ywc914j5riWtCPCRLMnWJ0QMKbJqFkAgEXGpd/q+hD
         Qnabvxt3JlErV+qsbGmCvkeGIBAOclk7H+DlYb2OOpy6LmnLZQwgbCG6OaQicR8n0kRG
         ql5zh/eAOMGY3F1LSY21lxm62+0elRl6HMBe8omBb2m9aUnKGQWv6JHtwo0RAqUl0tAs
         +yAIWUHlJvI9UuAWSyZLdZPjmWi2I4IPr9yqbawwfYA2V5KKDN1zgiCuej8wflS4Hg8a
         R23EL7hH3mSekbcJiAI677QkIDV+dIVxaXBy5cXkbrJ6S+U4nndUACDmJIluRGB5aUYl
         N95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709322623; x=1709927423;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dgy1ZU4725alB/ybUlDdAT+tgM7qe4kvtI2mA04TtYk=;
        b=X0Ua8gRnpbcGPzMtYyLax3kmk2npy2cMl8wBk0/Nc/WlvhW8Xm2cFnm47VUT7QNa9N
         NpCzSQZBrIIFWtTeFuKtMJ1sZ0Cp+e0hSJGfQYPVPdq3IstzclhoZmy2z1nNTCr2fiHe
         RhCLXH8Gg1ykLWUoTwTJz04oAb5KU63YpY0HQgf7+cu7hvrXGE95br+C89/YSpUNbV+J
         b2gXyul60nTF4s+/ZzIAd7uJRAiMb5Mtbp5tsWB1V1YkyVWGD4aE+Gu7VT6ZmmSOq/7U
         OF8quNU4wPKyHRiyS2LgpN/Pn9O/ATnfkCTDChHnH851TKFllWhQxb0OFhMq5gmTYcfv
         o6+g==
X-Gm-Message-State: AOJu0YzlUdU69a1NMNa3wjuq+WRTLSwYztrIKXwtof+HC0fR7DKMFfG4
	7CxESApWqiWRYRqT4RQocAuwTwY30tXhwBF4ViOphgK/MadO+/tWFCFT/U+jmZHnpvOK1IKIRdn
	VLws=
X-Google-Smtp-Source: AGHT+IH6QUQia9p7AY50for5PfRirfjVYnI2/37oAIAXqxI53BRYlIQyvcHSufEff/h59ZgOzILDKA==
X-Received: by 2002:a17:902:aa84:b0:1db:509a:5a31 with SMTP id d4-20020a170902aa8400b001db509a5a31mr2497301plr.26.1709322623086;
        Fri, 01 Mar 2024 11:50:23 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s4-20020a170902ea0400b001dbc3f2e7f4sm3855906plg.101.2024.03.01.11.50.22
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 11:50:22 -0800 (PST)
Message-ID: <65e2317e.170a0220.f76f6.2a87@mx.google.com>
Date: Fri, 01 Mar 2024 11:50:22 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.306-cip107-254-gfeae08b50ac51
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 76 runs,
 4 regressions (v4.19.306-cip107-254-gfeae08b50ac51)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 19:50:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15135

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 76 runs, 4 regressions=
 (v4.19.306-cip107-254-gfeae08b50ac51)

Regressions Summary
-------------------

platform          | arch | lab         | compiler | defconfig           | r=
egressions
------------------+------+-------------+----------+---------------------+--=
----------
at91sam9g20ek     | arm  | lab-broonie | gcc-10   | at91_dt_defconfig   | 2=
          =

beaglebone-black  | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1=
          =

r8a7743-iwg20d-q7 | arm  | lab-cip     | gcc-10   | shmobile_defconfig  | 1=
          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.306-cip107-254-gfeae08b50ac51/plan/baseli=
ne/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.306-cip107-254-gfeae08b50ac51
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      feae08b50ac51891b1ac8f457acdb2bcd62fdc22 =



Test Regressions
---------------- =



platform          | arch | lab         | compiler | defconfig           | r=
egressions
------------------+------+-------------+----------+---------------------+--=
----------
at91sam9g20ek     | arm  | lab-broonie | gcc-10   | at91_dt_defconfig   | 2=
          =


  Details:     https://kernelci.org/test/plan/id/65e21f0192357ab70c63701c

  Results:     42 PASS, 8 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-254-gfeae08b50ac51/arm/at91_dt_defconfig/gcc-=
10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-254-gfeae08b50ac51/arm/at91_dt_defconfig/gcc-=
10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/65e21f019=
2357ab70c637027
        failing since 35 days (last pass: v4.19.304-cip106-27-gf3e967c370d4=
4, first fail: v4.19.304-cip106-176-g770d0422c72e9)

    2024-03-01T18:31:11.748667  /lava-651305/1/../bin/lava-test-case
    2024-03-01T18:31:11.782782  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dsou=
nd-card RESULT=3Dfail>   =


  * baseline.bootrr.audio-card-probed: https://kernelci.org/test/case/id/65=
e21f0192357ab70c637028
        failing since 35 days (last pass: v4.19.304-cip106-27-gf3e967c370d4=
4, first fail: v4.19.304-cip106-176-g770d0422c72e9)

    2024-03-01T18:31:10.662718  /lava-651305/1/../bin/lava-test-case
    2024-03-01T18:31:10.697588  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Daud=
io-card-probed RESULT=3Dfail>   =

 =



platform          | arch | lab         | compiler | defconfig           | r=
egressions
------------------+------+-------------+----------+---------------------+--=
----------
beaglebone-black  | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1=
          =


  Details:     https://kernelci.org/test/plan/id/65e227ff2329060440637051

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-254-gfeae08b50ac51/arm/omap2plus_defconfig/gc=
c-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-254-gfeae08b50ac51/arm/omap2plus_defconfig/gc=
c-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e227ff2329060440637083
        new failure (last pass: v4.19.306-cip107-201-gc2afc54e2d6bb)

    2024-03-01T19:09:16.464753  + set +x<8>[   17.107118] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 651486_1.5.2.4.1>
    2024-03-01T19:09:16.465073  =

    2024-03-01T19:09:16.575828  / # #
    2024-03-01T19:09:16.679116  export SHELL=3D/bin/sh
    2024-03-01T19:09:16.680081  #
    2024-03-01T19:09:16.782220  / # export SHELL=3D/bin/sh. /lava-651486/en=
vironment
    2024-03-01T19:09:16.783144  =

    2024-03-01T19:09:16.885265  / # . /lava-651486/environment/lava-651486/=
bin/lava-test-runner /lava-651486/1
    2024-03-01T19:09:16.886748  =

    2024-03-01T19:09:16.890214  / # /lava-651486/bin/lava-test-runner /lava=
-651486/1 =

    ... (12 line(s) more)  =

 =



platform          | arch | lab         | compiler | defconfig           | r=
egressions
------------------+------+-------------+----------+---------------------+--=
----------
r8a7743-iwg20d-q7 | arm  | lab-cip     | gcc-10   | shmobile_defconfig  | 1=
          =


  Details:     https://kernelci.org/test/plan/id/65e22074f932cb817963701d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-254-gfeae08b50ac51/arm/shmobile_defconfig/gcc=
-10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-254-gfeae08b50ac51/arm/shmobile_defconfig/gcc=
-10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e22075f932cb8179637=
01e
        failing since 35 days (last pass: v4.19.304-cip106-27-gf3e967c370d4=
4, first fail: v4.19.304-cip106-176-g770d0422c72e9) =

 =20


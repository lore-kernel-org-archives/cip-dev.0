X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web09.6445.1647928102111327824
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 21 Mar 2022 22:48:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=cC8GZzkq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id jx9so944620pjb.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 21 Mar 2022 22:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=l4IMWR1dFMtzxTdLwIjS4uofgxBV1UDi4UedFH6ihzY=;
        b=cC8GZzkqmFA+4htBDMRpwA1EFboIhSQB6dcYIgKKtr5iZNo6sb5SNWcr/hfkh0ftcX
         F1lzXjHav7KxNAiv0FqZFXs8xo7oqBQ13Vp0AiL2mSyZhU8mn9HjDTy0XBdI+JV04rJ+
         HSU1y8TpPhxh4UtP34AiDpMNJVX9BN98Co7MMlt6A4FSahATpB7Jkhs25YuR5MabqLmU
         xt+TzAKWTD2D21JzabEQYtrIy+fbNSkKKxvUV4axc1g8a10kYaCk0tIWEUC8P8+Lr1ZD
         bnr9o/UBm+0MlHFonMasOGxM9nCfo+Q+Y5MTa7DUoYkKwz7G5iqTLiHL2feL0tK3oAxr
         s67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=l4IMWR1dFMtzxTdLwIjS4uofgxBV1UDi4UedFH6ihzY=;
        b=SecMKGjqY7eyMBtHzDKjxqOh84U6yBEDeAOeLDdENPkw9T2NJSvNXcjUbm9kJjSxdF
         L2hd4p6sWzEmnW/G/wXPtWJtj8+QG3kWwxVNINvtZKECoJAie2TSLwdCHjol5sOtjWSI
         UYiSHrXy7Q3HJIX0Bk6PapB8P07xmia85xlDiG+aSfxb2Iymgy9mMhBctlF9zq7uNT9O
         3cRa/0eUiIg5upkvhZPqRkchMzZmTBm0Lh+eHlJAKMp+9nQLlqaNqEI4EJS3rVObKotr
         TLEpzSrTTmZ66GpjQuls6pkLLWfxNYIO/gRsSt1kOCRihK+6A3VSk8vm5pdc2vseb8i7
         mu1Q==
X-Gm-Message-State: AOAM530izUgyzVRsqwEFyIuOuBGMBQ1EZ0nY8+wWysi3ERPzQS4QBfTG
	ME7pprN/chHbOEE5oJ1ZVmERGM3zPRpUiGnDIUI=
X-Google-Smtp-Source: ABdhPJyGoSoMk9bSIfzvTuUDjTXcmSev3ag5QcpSEMQDGKx1Fnu6XYtYfm6AP20CAI9roqiBiHI52A==
X-Received: by 2002:a17:902:b406:b0:14f:bb35:95ab with SMTP id x6-20020a170902b40600b0014fbb3595abmr16426143plr.140.1647928101373;
        Mon, 21 Mar 2022 22:48:21 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b14-20020a056a000cce00b004fabc39519esm920827pfv.5.2022.03.21.22.48.21
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 22:48:21 -0700 (PDT)
Message-ID: <62396325.1c69fb81.9e9d4.2c08@mx.google.com>
Date: Mon, 21 Mar 2022 22:48:21 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.104-cip3-155-g4f07dbd2df49e
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 4 runs, 4 regressions (v5.10.104-cip3-155-g4f07dbd2df49e) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 4 runs, 4 regression=
s (v5.10.104-cip3-155-g4f07dbd2df49e)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 2          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.104-cip3-155-g4f07dbd2df49e/plan/ltp-time=
rs/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.104-cip3-155-g4f07dbd2df49e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4f07dbd2df49ee61f77347287ba5837888067f02

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dc836ec4cd4e02e1346001f828c1f1988a8d7d54 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 2          =


  Details:     https://kernelci.org/test/plan/id/62395499e2e1e85e632172dc

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-155-g4f07dbd2df49e/arm64/defconfig/gcc-10/lab-c=
ip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-155-g4f07dbd2df49e/arm64/defconfig/gcc-10/lab-c=
ip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/62395499e2e=
1e85e632172e7
        failing since 8 days (last pass: v5.10.100-cip2-425-g0a0d92194f39, =
first fail: v5.10.100-cip2-484-gede5006fb276) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/62395499e2e=
1e85e632172e7
        failing since 8 days (last pass: v5.10.100-cip2-425-g0a0d92194f39, =
first fail: v5.10.100-cip2-484-gede5006fb276) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 2          =


  Details:     https://kernelci.org/test/plan/id/623959fce1e03b76fc2172b9

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-155-g4f07dbd2df49e/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-155-g4f07dbd2df49e/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/623959fce1e=
03b76fc2172c4
        new failure (last pass: v5.10.100-cip2-484-gede5006fb276) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/623959fce1e=
03b76fc2172c4
        new failure (last pass: v5.10.100-cip2-484-gede5006fb276) =

 =20


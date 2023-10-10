Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71FBE95A9F
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 14:13:19 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web11.92271.1696947199053889289
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 10 Oct 2023 07:13:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=zSsreBga;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.179, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-58d261807e8so1743058a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 10 Oct 2023 07:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696947198; x=1697551998; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JRbBmoD5HnvPVH+WMPqEGzpXKPXG8jfQ9MVPm3fEk8k=;
        b=zSsreBgau8U3rqSkaJhD81fQQlzMFueoBX6oMkpFjI3AsUEZI24KFoulAD1jrmakMJ
         a0MCCUEUtpYSnYMZXQQyHdGuow+z/nMazbMZgDqeVcZrVP6FC5O1RZHpg1wnLCaBRTvG
         nh38DVGo3BdZlbrkoJHA2+xuiQV+v+6If6AtDwLGZpDn4P80C0L1H4ZzzXPFpnvSN6Ru
         wGEcEFWP/2V6Bbm6ch1yQ0Wwpin3+X5yqIEKwe59t+2GwGKlSX4b2l2fX3JYLw0xQNrn
         wZDvafp19dRu8SThdBigtGs22cU/q7EqItsA943LfKK1Pc6SNwNgkT8eW4CDzPA5uKVq
         CcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696947198; x=1697551998;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JRbBmoD5HnvPVH+WMPqEGzpXKPXG8jfQ9MVPm3fEk8k=;
        b=Vu3z4m7V7ZbzDZhB1py0Ycmv5/i94rutLlNcv8YpT4C4uqyOQe5rXnx2Hl68kDJWp4
         sNRLPv+/aG7sVmzzodmwuCaf9BKaPaqqgi4vU74Tm0TZ/rOxwbmHu25j1pg+AuP02dsl
         16viczGx8Q21LKcuPA+UNPHj9bZ7NHHfX/lwNBRXlRWIX+6gl4b83JdIY+llRZmZDSm0
         uArpmQ2pivNNfZg7+R5vNCIaJy4EaKjc4rTKOjSP3mcPO4T6K+JbaqC9dm//bt785xq3
         5GIp/stQro2TsdDAXS95ELoEl33CHaQmo0RnyJ31eErZQzje5D4X8mQG5+Kzd0MDviOn
         gMfg==
X-Gm-Message-State: AOJu0YxA/qS9ud3MvakWjqs/VXYvS5kALf80/i8IHyR2f8HGOcV3c9za
	2+3be6QkH0IMGCWPucDlEz47/0s2PVDigWdEkLK0vg==
X-Google-Smtp-Source: AGHT+IHxjeGUfDacnejcOx9gp+ampqGgaD3xMRClXn+QPLyTO9WjatX8iji9AKHOetnARAiT32Wm8g==
X-Received: by 2002:a05:6a20:1586:b0:15d:6fd3:8e8c with SMTP id h6-20020a056a20158600b0015d6fd38e8cmr18287698pzj.14.1696947198048;
        Tue, 10 Oct 2023 07:13:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v3-20020aa78503000000b0068fe39e6a46sm8259195pfn.112.2023.10.10.07.13.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 07:13:14 -0700 (PDT)
Message-ID: <65255bfa.a70a0220.60cd8.3dd9@mx.google.com>
Date: Tue, 10 Oct 2023 07:13:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.194-557-g2932db67f070a
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 11 runs,
 4 regressions (v5.10.194-557-g2932db67f070a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 14:13:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13381

cip-gitlab/ci/pavel/linux-test ltp-pty: 11 runs, 4 regressions (v5.10.194-5=
57-g2932db67f070a)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =

qemu_smp8_riscv64        | riscv | lab-collabora | gcc-10   | defconfig    =
              | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.194-557-g2932db67f070a/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.194-557-g2932db67f070a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2932db67f070a3c9076db35b5abbabb867b599cd

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
mt8173-elm-hana          | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65254db29203a1f501efcefa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/ltp-pty-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ollabora/ltp-pty-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65254db29203a1f501efce=
fb
        failing since 118 days (last pass: v6.1.26-1320-g1ddf4b637f785, fir=
st fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
qemu_smp8_riscv64        | riscv | lab-collabora | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65254e09da3836f0dfefcef9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/riscv/defconfig/gcc-10/lab-collabora/ltp-pty-=
qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/riscv/defconfig/gcc-10/lab-collabora/ltp-pty-=
qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65254e09da3836f0dfefce=
fa
        failing since 0 day (last pass: v5.10.194-cip39-552-gc89b2c57483f0,=
 first fail: v5.10.194-553-gd498c00818b88) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65255122da8dd8443eefcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig+arm64-chromebook/gcc-10/lab-c=
ip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65255122da8dd8443eefce=
f4
        failing since 6 days (last pass: v5.10.182-cip35-8-g2391124f19a70, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65255137da8dd8443eefcef9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774=
a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.194-557-g2932db67f070a/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774=
a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65255137da8dd8443eefce=
fa
        failing since 6 days (last pass: v5.10.182-cip35-8-g2391124f19a70, =
first fail: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =20


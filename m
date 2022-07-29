Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70E2C3F6B0
	for <webhook@archiver.kernel.org>; Fri, 29 Jul 2022 23:04:58 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web12.705.1659135895560726871
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 29 Jul 2022 16:04:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=Wga5DATo;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id p8so5775029plq.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 29 Jul 2022 16:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=j3z5UFVbyX+jctlPw96T2yhKEqn8bKKKezCAf7139YQ=;
        b=Wga5DAToV98Wr3ktb5VIxauQvcdNxwHAKaldfwViu0vcKJwHclQtrv8RPGHEBVjYBY
         hQnLO4qncwej2BLNncHUXEM2YilCJ/NaQXKKCd5Gh/auufDO09dZn3dED8HIFf2UngA9
         VZhIGULYVWB8nOF3BD5e4uc8hCT3H64CHL5sH9vSQFMQI/MnDf8fXWUU7eldowHgfxXF
         GJ1qJ8+0b2iriKJDa239QUmoQEY/hlo0zBC1hmb3BQyULri02ZDb59XDXHYec5Ky7r0p
         3e/Z3cO7tsvVzx9GpeyrJSCq1cEEmFbUP48dswdmclPgta/y0g9dt6QFy8FK3ogAZtEO
         0ADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=j3z5UFVbyX+jctlPw96T2yhKEqn8bKKKezCAf7139YQ=;
        b=T94ca5HOkYBaTpdi8MTXECf88C25tDj2IBpJqsnEFGyf4iZg2ccHAb1kag4uOEHuk5
         1oSjOIRIhJQT+CfI2XVKJfRCd+7LrSc9zF1Jy59TvN5SXJKIVLtZrH+QQIvcglodlNjo
         Jvs3nrk1VhLl5lKfVSD8ZbZe1ebRfNs7rHcMbMyvVLFrTYnn3FP3/UCBdw41jTAweVlu
         5tPsEetC8F9BM+ocTL90ZQSRhKedNAQAbLYoUsQKZTJgWzx6QrZbPq8pC4ZFmsdzQOWx
         cbhPFfQ74e1Ubmt28Ij+sCwTILYegFISpuzRu2fyCYwAXBrJXTph1lFzkp6bd+ngRZnY
         AMJQ==
X-Gm-Message-State: ACgBeo0w9bxdwurlVYCj3fQ7oUvYLeFNRhRptsUxY0qUEAP6br2ItETs
	N8VMZLCNIoPn9YV3NLUUpEGMR5NnvXJsqD0eOTM=
X-Google-Smtp-Source: 
 AA6agR6gGnX5RolPP8oFF0JdmOG8lNOvNNslc6ecscaGzoKfyD17Rc58VN0cGF5wHJok77Kn/e/9/A==
X-Received: by 2002:a17:90b:1d0c:b0:1f3:320f:4102 with SMTP id
 on12-20020a17090b1d0c00b001f3320f4102mr6500724pjb.192.1659135894534;
        Fri, 29 Jul 2022 16:04:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 n11-20020a1709026a8b00b001641b2d61d4sm3360456plk.30.2022.07.29.16.04.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 16:04:53 -0700 (PDT)
Message-ID: <62e46795.170a0220.6a406.5715@mx.google.com>
Date: Fri, 29 Jul 2022 16:04:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.252-cip78-113-gb7034e0f773f8
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc kselftest-futex: 6 runs,
 1 regressions (v4.19.252-cip78-113-gb7034e0f773f8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Jul 2022 23:04:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8988

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc kselftest-futex: 6 runs, 1 regre=
ssions (v4.19.252-cip78-113-gb7034e0f773f8)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.252-cip78-113-gb7034e0f773f8/plan/kselfte=
st-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.252-cip78-113-gb7034e0f773f8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b7034e0f773f811f76bd4c5795f4eafe7e1dede9 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/62e454500fd6d6456cdaf056

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.252-cip78-113-gb7034e0f773f8/arm64/defconfig/gcc-10/lab-=
cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.252-cip78-113-gb7034e0f773f8/arm64/defconfig/gcc-10/lab-=
cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62e454500fd6d6=
456cdaf057
        failing since 7 days (last pass: v4.19.249-cip76-57-gef3cc1b9e556, =
first fail: v4.19.251-cip77-82-g10c370b53152) =

 =20


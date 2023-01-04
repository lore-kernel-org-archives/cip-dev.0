Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA1CC4332F
	for <webhook@archiver.kernel.org>; Wed,  4 Jan 2023 13:22:03 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web10.11794.1672838521666048330
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 04 Jan 2023 05:22:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=G769EaP4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id c2so8295685plc.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 04 Jan 2023 05:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uJQyHEK19Zw5erQpLcHDLtOxTvX8sahnT9uZZ2+/84k=;
        b=G769EaP41simR9JY7zhREAQjqXOwvIteeo/D3E7hza/GBjjdG/N+GJh3la0yfgGUiz
         xVXVzpcFVqpwXAkJb9dgUQIe0NuH5sbVC+9OSL6i9yPrcCKsXGtaLX7E8ePeHMZPAfE6
         /aVw6xuFlk1i7/HOTmSN47cIr4DADAnvMkhIBCnwNXZNxFnj21HzhkhvE1Tv2+SS3i35
         SKP8i8E2lrg9VxKUKG1rkcjYXLcloIqniNYcHH6BRAzTCfRU0NAM2vccGVxE7I93qAN9
         x1ByPunPmgvcgkPjijyCvAuxxlwA/h8QBidJ8azeZiJnzCOJoIho7Nqm70sB0pLasHuT
         PWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJQyHEK19Zw5erQpLcHDLtOxTvX8sahnT9uZZ2+/84k=;
        b=2iBu5eTXa2G76om/PhT34i95zgFrFgvhbmDHwZoEciC6aQ9iiC9slNJVAbtyzaorNi
         zEQS898wlf8U2gBeouGmjHNJbxkSa3N5Zr95TvqezFCjRM9nC81nQVD2NeXfoN1EsVBO
         U7Tp9mZvqSDRCYD7/OOtxdkvckIcdTn2USZ9kwceXeDJ0RpPfxD5FDnRRklSwigsOR5g
         UwSj9iZGI2wBsagSNVxmBjrU4OLqE7Qli7ulxczWCKRYykazSOy3Rm1IV1whrIckeA42
         BL7m6QwXyx0ewQ0uu6iIRupnxl/aJwh/M1FTGLvQuAXYh72KKw5IvdQ5cBH3qCYkZmJQ
         tTIw==
X-Gm-Message-State: AFqh2krM2m6XalE4zZ3ijw0Vdj9RMcUqnW+bT3Z2Scyn3jV+NS77fbe2
	eckPygqo82j72N4ewtm/WpvrCUXYB2X0na6psM4=
X-Google-Smtp-Source: AMrXdXvReoCUuaprbuZU7EQhGVfRcY0tQqiXmgDXNmWb63OFJjrz54GByd3q6Mh/gQe5gN9n/8jntA==
X-Received: by 2002:a17:903:28d:b0:192:85f3:5b1 with SMTP id j13-20020a170903028d00b0019285f305b1mr33249326plr.59.1672838520664;
        Wed, 04 Jan 2023 05:22:00 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902f7ca00b0019145e3f77dsm6565951plw.111.2023.01.04.05.22.00
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 05:22:00 -0800 (PST)
Message-ID: <63b57d78.170a0220.18279.9232@mx.google.com>
Date: Wed, 04 Jan 2023 05:22:00 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.161-cip23-65-gca8c192cb189
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 12 runs,
 3 regressions (v5.10.161-cip23-65-gca8c192cb189)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jan 2023 13:22:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10305

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 12 runs, 3 regr=
essions (v5.10.161-cip23-65-gca8c192cb189)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
beaglebone-black             | arm   | lab-cip     | gcc-10   | multi_v7_de=
fconfig         | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig  =
                | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.161-cip23-65-gca8c192cb189/plan/kselftest=
-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.161-cip23-65-gca8c192cb189
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ca8c192cb189c6be84da2274a96e73320a638b43 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
beaglebone-black             | arm   | lab-cip     | gcc-10   | multi_v7_de=
fconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/63b57533a96fea27684eee1e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm/multi_v7_defconfig/gcc-10=
/lab-cip/kselftest-futex-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm/multi_v7_defconfig/gcc-10=
/lab-cip/kselftest-futex-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221230.0/armhf/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/63b57533a96fea=
27684eee1f
        new failure (last pass: v5.10.158-cip22-142-g79bb6f9db05d) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/63b57937fd256ca7e24eee19

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig/gcc-10/lab-br=
oonie/kselftest-futex-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig/gcc-10/lab-br=
oonie/kselftest-futex-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221230.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/63b57937fd256c=
a7e24eee1a
        failing since 13 days (last pass: v5.10.153-cip19-122-g149fbc7cd21d=
, first fail: v5.10.158-cip22-142-g79bb6f9db05d) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63b5772b8beaa7df2b4eee49

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221230.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/63b5772b8beaa7=
df2b4eee4a
        new failure (last pass: v5.10.158-cip22-142-g79bb6f9db05d) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A45CC4332F
	for <webhook@archiver.kernel.org>; Fri,  4 Nov 2022 09:23:49 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.web08.9158.1667553824485653507
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 04 Nov 2022 02:23:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=7WK9faRQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.174, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f174.google.com with SMTP id e129so3884788pgc.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 04 Nov 2022 02:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bTKoaRzw3rYp3ztcY2KtkJtAHbcQIgp8XTyQQIR79Hc=;
        b=7WK9faRQNqIwsln/iQ/njojova+06EQQkmDljHuFakeZbCkN0qXquGerp/CqhoGYQP
         o/SRkf7TOzwxc+EQbrWK8blPTHd4QkkrinL29XuBgov6H5X7QTzCUMgU421I1vLIw49c
         iWraBpJ6kgJTcLLAIEk8tVLbEfh3H2kUZDrbj9q55bE4wW2xQBO+QXAorVZJYpz+PWqz
         cK3EDQCEn7d6Z6SFv4NEWz7ATlRaEHIAQE2wOVSf9F4ZbG17U2QRDnyOtuHpVjqsR4El
         GwyTmYr9SxEWjR1oZnTNWxCIb40erHd1WPqQVWNZBXOzhyRULa9twh4h95dnIYm/CS+k
         Y88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bTKoaRzw3rYp3ztcY2KtkJtAHbcQIgp8XTyQQIR79Hc=;
        b=f001WiLVHkDLn/03+xU+DU9naIQ5hb+50CB9VlMk+AFCq/rzFOhjp+iyrP1z86+6vC
         p+jh9HGOGsJxmQtLA1QJuYg0AGOnRzzme6tROIAgHJlQzdobnc1VI6snm5tNul4yoAEl
         pveM5uE15pa8EPJBkVOzVQfYmUSg0qxEEys9BSGEpt2CBX9Ksw+i8oL/nWE84tXjTMq0
         7g6tbwb9WeLb17/XnCwR7tUDnqe+U8H3ECJQfOpb/7kMAi160By8ORgihH6ctF7bXico
         vsT5tHbgwB8NKpxerOKyOvLV4AiuNTZFL4CfynmkPqiVxp2DZraH+q0gOAphFc0XVLy7
         2Yag==
X-Gm-Message-State: ACrzQf0Ib04KJp5SOwIrnMv1/kpqnH1Hk0/0Nhro99k86MVXec1uZlKQ
	GhhdjUyjscSRkNPhwBp7NOjmSckamJz8GQ==
X-Google-Smtp-Source: AMsMyM6Se6I8PIzRSCX4K5K+z3Pa63Pf9obKjAK4uUW1YUJFKwVASu9ytWodvEfvs9xsAcjMn43c8g==
X-Received: by 2002:a63:ea04:0:b0:43a:b17f:cd12 with SMTP id c4-20020a63ea04000000b0043ab17fcd12mr29509776pgi.109.1667553823830;
        Fri, 04 Nov 2022 02:23:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902cf0200b00186a6b6350esm2071395plg.268.2022.11.04.02.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 02:23:43 -0700 (PDT)
Message-ID: <6364da1f.170a0220.28727.454c@mx.google.com>
Date: Fri, 04 Nov 2022 02:23:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-12-gcb2b164780be
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-futex: 7 runs,
 2 regressions (v5.10.147-cip18-12-gcb2b164780be)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Nov 2022 09:23:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9927

cip/linux-5.10.y-cip kselftest-futex: 7 runs, 2 regressions (v5.10.147-cip1=
8-12-gcb2b164780be)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip      | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.147-cip18-12-gcb2b164780be/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.147-cip18-12-gcb2b164780be
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      cb2b164780beff6c4be7ccfd9020e39c07c44f3c =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/6364d15d41b6a77d3ae7db5e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-baylibre/kselftest-futex=
-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-baylibre/kselftest-futex=
-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6364d15d41b6a7=
7d3ae7db5f
        new failure (last pass: v5.10.147-cip18) =

 =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip      | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/6364d55c20db0927f5e7db84

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-cip/kselftest-futex-r8a7=
74a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-cip/kselftest-futex-r8a7=
74a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6364d55c20db09=
27f5e7db85
        new failure (last pass: v5.10.147-cip18) =

 =20


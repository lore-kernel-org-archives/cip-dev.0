Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF5DC433FE
	for <webhook@archiver.kernel.org>; Wed,  5 Oct 2022 12:49:15 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web09.23190.1664974146665081106
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 05 Oct 2022 05:49:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=M7ayRif5;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id
 v10-20020a17090a634a00b00205e48cf845so1425218pjs.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 05 Oct 2022 05:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=WEQdUiJnJ4OF8Ko/klsPo+XOU5L/Vk7iqyIUyfZo6zM=;
        b=M7ayRif5vvFiw8vP2mZMCWx37UhsrUW3kvKp6ehCaaULuUo279HJmrSb7cU2aAPBcG
         vSvmDyyV8oZQVceGVpJIQT2Z98G1SaPbTXhPUjc26PMryIeHwBKYxBmZcW3A7TeZZ9XW
         uYMzhZKCIeR7P1dY95Dv8Pa6LF0CjLLGUJe9rlQqjc0MU2mTyW1SEU4V2b/iuvrcgpi0
         fY1TpKjxkPpjNYdr7XKDe+jfHlNG8af4DKeUWr4Lt5J/id2YTcPnyA/K7Tx/ylpvPSER
         qsBdLDMQmDRWC3waCBhvDhyp/p6upHSO61/ONqvFF9fMFOah8h8YcEJa8x7maQ+FB96M
         Jlag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=WEQdUiJnJ4OF8Ko/klsPo+XOU5L/Vk7iqyIUyfZo6zM=;
        b=F0WW1zOWTLtgl1jZIN+lIzoZdS+kxYN75mNp49cUqNCCl9OyPD6jO0H3wUVTCws0u9
         9JgwcFVSTjV/BqBauQgI20mWzySgRx0sNFtZqWjiyz8j44bFC/+/thGUp7MG4oi7Ohye
         PTAL/jIM3l9IzEcGMv7ozuN2X4ZUZUDUvFwzovJVaJOYFhF2Ta48HgfZPlQRaTpus7PF
         7uUVp5/LhICRTMvN6avx3iSAaXkxurCTsLWyoZYq1Kuv0nb0tYcNPRjM2534PWy/AIta
         ubI3laZOTFzjClQD6jWh/KTmVoEdcgiCkvKs0Gaej9eD+aoo6t/6HejR7J+WlnQpUFML
         i1HA==
X-Gm-Message-State: ACrzQf1uCx3DiiPy2kVSzQuJFHSwX50MD0CPU5NHdCaWxamFRvH5qfHA
	aNjfc5TruAoxJlaVfeg6mW9h4zzlSUtzMe0v6bI=
X-Google-Smtp-Source: 
 AMsMyM4VE4mm9ug95dzdjHRMefC40ERLYBWgmZjCrbuLEpu1H7QQIUOUf+DiClbm9z3XUpCopCH6cg==
X-Received: by 2002:a17:903:189:b0:178:3df7:f32e with SMTP id
 z9-20020a170903018900b001783df7f32emr31720231plg.47.1664974145814;
        Wed, 05 Oct 2022 05:49:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 t15-20020aa7946f000000b0052d432b4cc0sm6452608pfq.33.2022.10.05.05.49.05
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 05:49:05 -0700 (PDT)
Message-ID: <633d7d41.a70a0220.fb478.b2c5@mx.google.com>
Date: Wed, 05 Oct 2022 05:49:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.145-cip17-192-gbe875d9d93504
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 98 runs,
 2 regressions (v5.10.145-cip17-192-gbe875d9d93504)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Oct 2022 12:49:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9645

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 98 runs, 2 regressions=
 (v5.10.145-cip17-192-gbe875d9d93504)

Regressions Summary
-------------------

platform | arch | lab          | compiler | defconfig           | regressio=
ns
---------+------+--------------+----------+---------------------+----------=
--
panda    | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig  | 1        =
  =

panda    | arm  | lab-baylibre | gcc-10   | omap2plus_defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.145-cip17-192-gbe875d9d93504/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.145-cip17-192-gbe875d9d93504
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      be875d9d93504a4ac9c5dfc8d0bed7cc4197ab75 =



Test Regressions
---------------- =



platform | arch | lab          | compiler | defconfig           | regressio=
ns
---------+------+--------------+----------+---------------------+----------=
--
panda    | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig  | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/633d7b84d3ce88c7e0cab5f9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-192-gbe875d9d93504/arm/multi_v7_defconfig/gcc-=
10/lab-baylibre/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-192-gbe875d9d93504/arm/multi_v7_defconfig/gcc-=
10/lab-baylibre/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/633d7b84d3ce88c7e0cab=
5fa
        failing since 34 days (last pass: v5.10.136-cip14-542-g97767707d3d0=
, first fail: v5.10.138-cip15-90-gd4130d0ee3c7) =

 =



platform | arch | lab          | compiler | defconfig           | regressio=
ns
---------+------+--------------+----------+---------------------+----------=
--
panda    | arm  | lab-baylibre | gcc-10   | omap2plus_defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/633d7850ace7b18f15cab5f2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-192-gbe875d9d93504/arm/omap2plus_defconfig/gcc=
-10/lab-baylibre/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-192-gbe875d9d93504/arm/omap2plus_defconfig/gcc=
-10/lab-baylibre/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/633d7850ace7b18f15cab=
5f3
        failing since 34 days (last pass: v5.10.136-cip14-542-g97767707d3d0=
, first fail: v5.10.138-cip15-90-gd4130d0ee3c7) =

 =20


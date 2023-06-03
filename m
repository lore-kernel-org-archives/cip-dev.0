Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EBEC77B7A
	for <webhook@archiver.kernel.org>; Sat,  3 Jun 2023 17:43:26 +0000 (UTC)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
 by mx.groups.io with SMTP id smtpd.web11.2069.1685814198970079322
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 03 Jun 2023 10:43:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Bxx9Svrn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.173, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-394c7ba4cb5so2326009b6e.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 03 Jun 2023 10:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685814198; x=1688406198;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5+Fs2+lD2Oh86y2omLZK1OFcztfkmAii+cOlmraSKZQ=;
        b=Bxx9SvrnzXFEjCGettUff0zi6ZiPVCr+b3lcnxyoy/7tkm7TrsKT2ZLx79spKVyP1p
         0yjHWAikEAVNfO/RALP/PjHXh0iyX1+lt0aUybXsofj75H9vDsdfDHw3XZcTkgJi4O28
         76XIh3QphnguSnjkZ56zoK1VxzcZkYdyR0vExDmPIsJ5gfAJL2ysRYy53nbPiHzvtxPQ
         NXbqwRJmpU+GsjkCzU50bkd5/83Q3M4aC3lVVsrSRL9WculvMADAihsFGjiDIpDdxY1e
         nkMwdFPAm1mgsnPB3fw8T2YyfrFpPHrxmbQV3lPgrnqEO8Avpyt9zsC7p4kYOLqoUBzj
         KnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685814198; x=1688406198;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5+Fs2+lD2Oh86y2omLZK1OFcztfkmAii+cOlmraSKZQ=;
        b=P2zBl9VMzc+qC1XJiLuqR6s7XYTzBIXi4JY+wFxMLQdiQ/dPJDISCcCb3jhdVJIW3O
         HR6bVlatLKbZhdntNZliUpzprOhhhyH4V75SX01EvjgYaryTU1lm1Bevjz66ayhIzcYN
         CYUvCRVVYb5lxIs3UBBKffd29qS06/JxYMoEtsnx6AaTsbaYrRr+TNCvKJd5pVki+qCI
         8xK4Np/24n8dZgWPJAiOyYNC8XyaP/oc9Gt9TTb2vNvZpsPtQ0acysJsVJ/4FfVYL9oC
         3gvj8ImRTkFQq0GSmUxrfwcg6BB5R9SMo766HOZ87RlKzsnODwvA07z6R1KyOxjyGKtP
         hhEQ==
X-Gm-Message-State: AC+VfDyX+5Q/SdWtOsfDwLmtPX/TnRA/CLXPmI/oKxHjxMs7auEQoTQy
	krFvZtYTY0rVVS/JIL/O533w/zBecNIz7YwcXHg3bw==
X-Google-Smtp-Source: ACHHUZ7EX+/oS31NdnU6oFGNkAIo0jEHT8ScO/aw3ZqglZOaKh2FeTL8Jsn5CKsViP8Q1gWMeTp9rA==
X-Received: by 2002:a54:4691:0:b0:398:3152:fee1 with SMTP id k17-20020a544691000000b003983152fee1mr3118689oic.20.1685814198000;
        Sat, 03 Jun 2023 10:43:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d3-20020a170903230300b001ac82e8491csm3431566plh.282.2023.06.03.10.43.17
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jun 2023 10:43:17 -0700 (PDT)
Message-ID: <647b7bb5.170a0220.ce07d.6047@mx.google.com>
Date: Sat, 03 Jun 2023 10:43:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1281-g84d5372e0f31
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 13 runs,
 2 regressions (v6.1.26-1281-g84d5372e0f31)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 03 Jun 2023 17:43:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11757

cip-gitlab/ci/pavel/linux-test ltp-ipc: 13 runs, 2 regressions (v6.1.26-128=
1-g84d5372e0f31)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =

beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1281-g84d5372e0f31/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1281-g84d5372e0f31
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      84d5372e0f314fb85258229768641315d1a95773

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/647b7af2bc18354758f5de26

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm/multi_v7_defconfig/gcc-10/lab-broonie/ltp-i=
pc-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm/multi_v7_defconfig/gcc-10/lab-broonie/ltp-i=
pc-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/647b7af2bc18354758f5de=
27
        new failure (last pass: v4.19.280-cip95-rt30) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/647b7605c139a9e953f5de25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm/omap2plus_defconfig/gcc-10/lab-broonie/ltp-=
ipc-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm/omap2plus_defconfig/gcc-10/lab-broonie/ltp-=
ipc-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/647b7605c139a9e953f5de=
26
        new failure (last pass: v4.19.280-cip95-rt30) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFE7C4332F
	for <webhook@archiver.kernel.org>; Wed, 21 Dec 2022 20:14:26 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web10.29383.1671653665825944228
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 21 Dec 2022 12:14:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=EOkII+iT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id gt4so16882646pjb.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 21 Dec 2022 12:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n0RDsf0tu1YHKnDiGBgYWDJ6JrTMSoOkXy/gWEtihBg=;
        b=EOkII+iTvXaHqNnCjrA9o1udLLneNUTS+YEc+uEzP+/DAofGa2If3sVHQFShEs+tIU
         7SEa2HwB4FHfftSTNHPDTLzZA+Cpf+sa/RZI1NJLMTvInlv5x/Jtuetq5hIy3erOpWtp
         9n3+Tvw2yf2Ap8wLG+s7hTPX15hfF9y5LsyBbR8I0JiUu1+uFWRY1s5Aijqfa/S1SFVC
         ybjrr3vZ4h0Yw+4mQiv44Obrfgz/CkdmienX+QVuWRvq71UUR98D0do9BnCUktPRP7O3
         rJy9mqI7lcHyM26c1uQD4Mrh3xxwPx57/JJvPi2ERtxGEyl2uE4rACB/WKNi1EzgLIkM
         Rpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0RDsf0tu1YHKnDiGBgYWDJ6JrTMSoOkXy/gWEtihBg=;
        b=TST1T1dI4PohYUSVvhUcRJN+3nJB3eZdF5RI9uRXICi1YPk9oU5+3+PKu4S1uLQZ+x
         2pq7YhmgFSVaseFx/RuNrhJC4NYg0kKGuvKF05+/tvhkyUrAxESYBfhGRj3tekD5JkdH
         AhNLYif2EZH3FbyLfzdjIy/kjxEZxqtu3Wtp3rslDPLNluvXsdOtTxzzy4TsV6U2Y3I/
         f6JY3gFebbtuDRlpPJng/CHjBKFKZQXEg32QnfJI6j8dMBirgSyqYy7Xg2ydQ6U98Xau
         JVx073CUps8JajYL0ZvDWuaJTP8RLUhPnlb9+35FrkrpynJ0P+8V9d88suUJuNWJ2W5B
         gSCA==
X-Gm-Message-State: AFqh2kpBpoG/SYHGL6oMdJe9PFUaqjFLQUSB9HLyErv+rXLEFjDtpflk
	iSupjbcsu27K/lI90ySIFbc487KMe/YB0mkz2Hk=
X-Google-Smtp-Source: AMrXdXvZZ82YadGH9NUoVJJPfkiSnLh4lKU1LSQCvZXuh8L//f5eTyYmfPlCFfs3Jzztw8YhPRQa+w==
X-Received: by 2002:a17:902:ec89:b0:18b:ed3f:c6ca with SMTP id x9-20020a170902ec8900b0018bed3fc6camr4498054plg.12.1671653664926;
        Wed, 21 Dec 2022 12:14:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b00189c9f7fac1sm11844025plb.62.2022.12.21.12.14.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 12:14:24 -0800 (PST)
Message-ID: <63a36920.170a0220.f5b53.57e0@mx.google.com>
Date: Wed, 21 Dec 2022 12:14:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.158-cip22-142-g79bb6f9db05d
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 149 runs,
 2 regressions (v5.10.158-cip22-142-g79bb6f9db05d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Dec 2022 20:14:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10258

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 149 runs, 2 regression=
s (v5.10.158-cip22-142-g79bb6f9db05d)

Regressions Summary
-------------------

platform          | arch | lab          | compiler | defconfig           | =
regressions
------------------+------+--------------+----------+---------------------+-=
-----------
beagle-xm         | arm  | lab-baylibre | gcc-10   | omap2plus_defconfig | =
1          =

r8a7743-iwg20d-q7 | arm  | lab-cip      | gcc-10   | shmobile_defconfig  | =
1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.158-cip22-142-g79bb6f9db05d/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.158-cip22-142-g79bb6f9db05d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      79bb6f9db05dca63bd1dd09dc84a45072dbc2ee9 =



Test Regressions
---------------- =



platform          | arch | lab          | compiler | defconfig           | =
regressions
------------------+------+--------------+----------+---------------------+-=
-----------
beagle-xm         | arm  | lab-baylibre | gcc-10   | omap2plus_defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/63a36143e0ecd9ad824eee7d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.158-cip22-142-g79bb6f9db05d/arm/omap2plus_defconfig/gcc-=
10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.158-cip22-142-g79bb6f9db05d/arm/omap2plus_defconfig/gcc-=
10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221216.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63a36143e0ecd9ad824ee=
e7e
        new failure (last pass: v5.10.155-cip21-405-g26d566555c3de) =

 =



platform          | arch | lab          | compiler | defconfig           | =
regressions
------------------+------+--------------+----------+---------------------+-=
-----------
r8a7743-iwg20d-q7 | arm  | lab-cip      | gcc-10   | shmobile_defconfig  | =
1          =


  Details:     https://kernelci.org/test/plan/id/63a35d7eb57de8ed954eee25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.158-cip22-142-g79bb6f9db05d/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.158-cip22-142-g79bb6f9db05d/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221216.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63a35d7eb57de8ed954ee=
e26
        failing since 56 days (last pass: v5.10.147-cip18-56-g87bd4289362be=
, first fail: v5.10.147-cip18-12-g7bc9523ecfb7f) =

 =20


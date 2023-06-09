Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF659C7EE29
	for <webhook@archiver.kernel.org>; Fri,  9 Jun 2023 12:40:38 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.12336.1686314432838385269
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Jun 2023 05:40:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=3sSsD+uJ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-64d44b198baso1339052b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Jun 2023 05:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686314432; x=1688906432;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RLRxt2CtuzguwcyOlmpjdcot2YJfZLv7gkIYbyK9ss0=;
        b=3sSsD+uJw8D5okgsgEmPdqtCZioZwYBpeXEw/IK5zozMMMDo0JBM/+yuTVhmTSsu06
         FCPYcm0eRNHGXGMSy+y1k0hINvXWsbLPiGA0xyIxQkCXONLjpiGGccZYPCRQsdi4AakW
         q1f5I/zJogCfW2HEeKujTsp4a+NoqJJZWbrOw8aVD1UoRDpr9xVyf0V04oJNWZLZ9QuU
         i9nhbrdCtLleUCMylNGfnPnbpg/HFl6D1balbj0lTaFNZOdD7wpYO8lhxdKumQSAmRoR
         2xiNUs+XUOtoEok/ZUfqDAYeo0EtuZRhqk2YoyJMDgSX8xZQHFl40bQtpPddqkEcJ2Ac
         ZReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686314432; x=1688906432;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLRxt2CtuzguwcyOlmpjdcot2YJfZLv7gkIYbyK9ss0=;
        b=TTlMnVPFL6q0BwdxBECpJWyDL8V728f/Tkyv+/HLL8G5fv7wl5faLPP4pBsjx2jELf
         nXdccdgXlCG8n5clf/EcAsO9rJU4+U25Fy+ctsSV02VfgzF20VKAvCkihYzukGNSEhBh
         nM8LJr04scwpDC9rznSZfGkHXhjw29eOqteH76TIZ8haccVuo3rXBD3HZRw7obZUIwo0
         Q7g1mNdtuVn7NA6IlE75F14L0HTq+SNwB4n0Uw1pAaNnjjcVPCU2YC5Th6aVwkxu3MbR
         ixyZmRb79eJOKuGzNBvjP4JE4X7rjshmEFVra6xsGcFRO2Qg9c/M4UUb9+3xB5ARwnGE
         zHMw==
X-Gm-Message-State: AC+VfDznAPUdjzan9aMkMua6KDRW3qL7e10kU9049XKd2HR50tskozwJ
	outmc5vD/Vf8szAFmgAO3WFRxVThdffAlWd8dqNgDA==
X-Google-Smtp-Source: ACHHUZ4HS6cy6Ob+OgVZ/uqFD3w4eIGhiVJth18ZsceBYsGa4By5NgE1m8kUNJXl/h0Wv4Ej6r0s6Q==
X-Received: by 2002:a05:6a00:24c4:b0:64f:f478:2294 with SMTP id d4-20020a056a0024c400b0064ff4782294mr2192345pfv.0.1686314431472;
        Fri, 09 Jun 2023 05:40:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d19-20020aa78153000000b0065fd8075bb1sm2721681pfn.14.2023.06.09.05.40.30
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 05:40:30 -0700 (PDT)
Message-ID: <64831dbe.a70a0220.59027.5708@mx.google.com>
Date: Fri, 09 Jun 2023 05:40:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.283-cip98-224-g5f5303d7920a9
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 8 runs,
 3 regressions (v4.19.283-cip98-224-g5f5303d7920a9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jun 2023 12:40:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11939

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 8 runs, 3 regression=
s (v4.19.283-cip98-224-g5f5303d7920a9)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.283-cip98-224-g5f5303d7920a9/plan/ltp-tim=
ers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.283-cip98-224-g5f5303d7920a9
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      5f5303d7920a98db8e84681ee6f1318ae918ab84

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/648312f27c009928cf306145

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/648312f27c0=
09928cf30614a
        failing since 217 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/648312f27c0=
09928cf30614a
        failing since 217 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/648315d2206920f72d30619b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/648315d2206920f72d3=
0619c
        new failure (last pass: v4.19.283-cip98-135-g4ed206c5dc11) =

 =20


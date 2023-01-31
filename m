Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C63C636CC
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 12:54:54 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web11.11184.1675169688227912146
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 31 Jan 2023 04:54:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=b5YQOwi3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id j20so3525124pfj.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 31 Jan 2023 04:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h9Eprgdbzu9qitbHu/3B7md/BH8F5ifsihWg+SW9nbM=;
        b=b5YQOwi3m3QqBr6JUlnPP/nPeOPv2q7lMeYKVFB+3lcVuj7F6O9s1UkFRPkrDYPRML
         n2vcnbO7ZgTQEC/qcOnjKd/basvCgfBrCM95e9s/flyZuPs6kZkXZeXd3SRDOyfeVVjV
         oEclHwRqlHUXNRqbwxE5jp6UZYW45uNuYUsnM73VXlzQ3tGYd/itVVUQMnsYhGdw7nof
         7PeLA5uEuXUhoespZBunrdPqJ/QwPxvVILVHw0sUDfY/hTzVc5PjNntFL4NKZdcrIEa2
         /I26gdrqBIMk5YKkCVaIFWBCw5/3T9gIqVems0mC5egSdsXWmhIke31XPI/jRTXKK41e
         8GiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h9Eprgdbzu9qitbHu/3B7md/BH8F5ifsihWg+SW9nbM=;
        b=bndshiKxAFdjuFHDwoEg7bUiqEVi7Apby8uWz4tw6QA/8lAex4BJ2opS4EelMSb8WG
         DcCIO3ud5t3qb67+ZPs28oX4nZt+1ZJgZJKaYFHAby2Fc/MzDVDs1YMG2KpVvmbSsgVO
         lv6oxPQEZ4c1R65N82ofagUzMRCLXAZEUz2B7IX/CZMwYgOCy3pqMA5UXiNWEDM3g3CA
         yCCi0DX7jlphT5k6dzLC5H/um1JE010UB7OrpPwCf0ddurcQdgvIqtYIK63gYySPSH3I
         I8XyRgog9QV3w9ujVFuJCv9c2ls7dAVezCGE1EeENCSskkq+gWxNzvKInpF8pYhGNME2
         JWvw==
X-Gm-Message-State: AO0yUKXWIbHBnxnBg9jak9hNaFd4wJECxRaGhY/72L7TYj1s8Ch0bjXN
	yeJ0f0JcQoxb8OCe+SHDX1xYSJjLdH+SK2XOKBWxUA==
X-Google-Smtp-Source: AK7set8DmhVj83E7xVA0x5L+jeU6Bd1+VeL2Xp6W9lsvAfG2y44eBr5j9tsogzOyap2dx2GAVXVNgA==
X-Received: by 2002:aa7:9511:0:b0:593:dc6d:53ab with SMTP id b17-20020aa79511000000b00593dc6d53abmr4147040pfp.27.1675169687358;
        Tue, 31 Jan 2023 04:54:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b3-20020aa78103000000b00582388bd80csm6403802pfi.83.2023.01.31.04.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 04:54:47 -0800 (PST)
Message-ID: <63d90f97.a70a0220.98731.a8b4@mx.google.com>
Date: Tue, 31 Jan 2023 04:54:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip72
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-cip baseline: 54 runs, 2 regressions (v4.4.302-cip72)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 12:54:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10526

cip/linux-4.4.y-cip baseline: 54 runs, 2 regressions (v4.4.302-cip72)

Regressions Summary
-------------------

platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig | =
2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0af99ca381ce97af181eab7f6fc808b1e039ac3d =



Test Regressions
---------------- =



platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig | =
2          =


  Details:     https://kernelci.org/test/plan/id/63d9081691c0de3f34915ed5

  Results:     37 PASS, 22 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-jaq=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-veyron-jaq=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/63d9081691c0de3f34915efe
        failing since 5 days (last pass: v4.4.302-cip71-1-g61333eee4869, fi=
rst fail: v4.4.302-cip71-590-g22fc523bf881)

    2023-01-31T12:22:00.259613     =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/63d9081691c0de3f34915eff
        failing since 5 days (last pass: v4.4.302-cip71-1-g61333eee4869, fi=
rst fail: v4.4.302-cip71-590-g22fc523bf881)

    2023-01-31T12:22:00.220002  BusyBox v1.31.1 (2023-01-27 15:57:34 UTC) m=
ulti-call binary.
    2023-01-31T12:22:00.220223  =

    2023-01-31T12:22:00.223824  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST
    2023-01-31T12:22:00.224293  =

    2023-01-31T12:22:00.228633  Print numbers from FIRST to LAST, in steps =
of INC.
    2023-01-31T12:22:00.231097  FIRST, INC default to 1.
    2023-01-31T12:22:00.231313  =

    2023-01-31T12:22:00.234240  	-w	Pad to last with leading zeros
    2023-01-31T12:22:00.234718  =

    2023-01-31T12:22:00.236459  	-s SEP	String separator =

    ... (3 line(s) more)  =

 =20


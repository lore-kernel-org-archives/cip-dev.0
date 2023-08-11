Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E859AC001DE
	for <webhook@archiver.kernel.org>; Fri, 11 Aug 2023 15:27:23 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web10.45720.1691767638380332516
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 11 Aug 2023 08:27:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=GWcDlbn9;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1bc83a96067so15536365ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 11 Aug 2023 08:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691767637; x=1692372437;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6ElfHuLtvMcLYNdUhuigUSIbkXpI6LWlFFlpGjzh2Ow=;
        b=GWcDlbn9jyy3SR67uBedCbwV48GNZiCGZN7aufhD8Xd5pmf0Xqwy8g1g6VmtbuhudD
         iPrZ2seD5eVccHw+fbznVvlk7YeKVDPq7SSy70AyqWXtXIitm5kRvUWYV5mzy7dJ50l2
         lMJ/6Vrju5GRpe+7/x5tpyoUdfDjzbn8Du86/aswo7V105tnMFeY7GqW1F2/JuzOBWER
         zJloUCZkmvCadG7EMcN+jWgPru4yTNWVQBbosxGDkr/N6YsKeM37obJIDLigIdaUPNRS
         u5BkMC4kvR75GWHtRjcZMpku4Zwj2z99JsxGaTwHJTcpoo+sKoPx5UvtOVXexUvJClgA
         perg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691767637; x=1692372437;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ElfHuLtvMcLYNdUhuigUSIbkXpI6LWlFFlpGjzh2Ow=;
        b=VpXDej1l9Vi/YDpuQJnMGxiJ2Lv1EHADBXB4iPylI0V+xPfZ7i06Cv5owTAfbKFoWL
         enycmrjKXT9u6pmRW8fBcWuGeXbP9xvuNxijKb1P8ujmvJl3Zbts/Hu7B4tG1gyRlWQO
         2gBEcAAyqcIguh/kFJ28BONL2UVGGa7KS80XboGrTtVpX8XpcuQ2idBgFQqmofUwV34C
         KiKOYdLrPgnAuh3wzBFVSDrp8kpd8U4hdnvB2MmhGJ6/CULDPQvE5Qfwy4CX3jp1Nwni
         q3ulhFa6f4btmvsiZ56s67rOB2ngPW0tLTLzf8BO+l1eUIS2CExPUpSsO8mjRHT80jy8
         J8uw==
X-Gm-Message-State: AOJu0YyOjFSMpnOMSV3UHm046Af5186R7L8J+GTGrYLVi8izHsVUnMB3
	eaQIDXisjF2OdcAeYxij27Sxv/lSVVW+ffiQbfx7Fg==
X-Google-Smtp-Source: AGHT+IGqV4FoI5ETeOkrjAllZZY37Sio7wK5TNwft0y5pbh6rgLV/TnpBKQHyGamX67TIXDpC32Xvg==
X-Received: by 2002:a17:902:d715:b0:1b8:c1f:fd2c with SMTP id w21-20020a170902d71500b001b80c1ffd2cmr2012970ply.33.1691767637117;
        Fri, 11 Aug 2023 08:27:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y2-20020a170902700200b001bbb1eec92dsm4046409plk.224.2023.08.11.08.27.16
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:27:16 -0700 (PDT)
Message-ID: <64d65354.170a0220.2e389.816e@mx.google.com>
Date: Fri, 11 Aug 2023 08:27:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-770-gddd36cfc4c4c8
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 5
 runs, 1 regressions (v5.10.186-cip37-770-gddd36cfc4c4c8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Aug 2023 15:27:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12618

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 5 runs, 1 r=
egressions (v5.10.186-cip37-770-gddd36cfc4c4c8)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.186-cip37-770-gddd36cfc4c4c8/plan/ltp-fcn=
tl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.186-cip37-770-gddd36cfc4c4c8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ddd36cfc4c4c8e772fc77e48315307e9956bad25

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d64296187315fe9935b1e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-ram=
mus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-770-gddd36cfc4c4c8/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-ram=
mus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/64d6429618=
7315fe9935b1e7
        new failure (last pass: v5.10.186-cip37-566-g36076316ef049) =

 =20


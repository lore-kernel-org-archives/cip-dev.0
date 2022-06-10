Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E1DC43334
	for <webhook@archiver.kernel.org>; Fri, 10 Jun 2022 12:36:59 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.web09.26523.1654864611083457707
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 10 Jun 2022 05:36:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=VxwZkp8f;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.174,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f174.google.com with SMTP id 129so24669159pgc.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 10 Jun 2022 05:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=+uhIkJ2QHBVEog9nRXrOgBmOXhaNY+yTjUY1TrWszLU=;
        b=VxwZkp8fH6iTKNCnJwCKJwUbLQhT6o7mcrBEuArM1s6CrzVy8EMXxXuHNWOqcJC1qq
         KlansEJD+eS13qqzSR8VNkAcgaffluNFUe9KKxikNfJsvJ2LVFle7QttqsISDzrnf50R
         2DQ6RlHUePKcxzowDdytdPXNFKsQQDYgbHWsrvJYeOJcCPOYiVlFxW4VuJwhrTnbU4+E
         WYtX6K0HYa3nMdnfVhucdOYft9M+ERLcBbC6jG+KAhKH/ZmOvdQnua+zMowEX/FILMwA
         N1l71lu1QZCeKk3fLKqj8JYSx+0eMjnRD41GIW8xfKn2sRgyVAy+End4b/nDxten2Jzz
         p8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=+uhIkJ2QHBVEog9nRXrOgBmOXhaNY+yTjUY1TrWszLU=;
        b=7swsa5jXXSkvqaTK78rHLe417+1Gs0WFwP3Zrmc4V/poMk/fRSOUxmCGQpq3OWCSMc
         pf8NSlI5FigFhDl5WbQyjQEHSnpaFpa4hbrVMtMTKH0/akikeb4CehlZzJORkkt5rHKh
         dHj8FR0G1Vu+iTpa48O+cQq/1PNVhvIeDkWPsqc2FJFx5RUfzjKZxhoR+refLALuQG12
         TVjfqtIyXJmBOAIVs/NxPRi6guM6YehYDuagmpKsZ2nNMAawgHjpmpwIUUsZNUqQYYbE
         qLRumimpBD1gZFrto1K9/ZeoqbTIXIaW+1DNQLSgzl9uuiArLwq7VGr4bKbmnQKSjL2f
         0EIg==
X-Gm-Message-State: AOAM530zCs4h1ppq1SEoqWr9ONRHZpoOpjE5yHkl4n/u74sYaZmuV+Oy
	PHDqoYR8vESUYMOxcTL8/ciedG8veOZKQEzl/Lo=
X-Google-Smtp-Source: 
 ABdhPJyR9PhyYYMGCRt9vStClJSoijADKZ4qpEhvb24Bm8aj/uyRYG9PVbkxdh2KkZC6UVx5Q7L30w==
X-Received: by 2002:a62:7cca:0:b0:4fd:e594:fac0 with SMTP id
 x193-20020a627cca000000b004fde594fac0mr45524158pfc.79.1654864610407;
        Fri, 10 Jun 2022 05:36:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 m11-20020a65438b000000b003fadc415bfdsm19082531pgp.8.2022.06.10.05.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 05:36:49 -0700 (PDT)
Message-ID: <62a33ae1.1c69fb81.cc73a.5066@mx.google.com>
Date: Fri, 10 Jun 2022 05:36:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.121-cip9
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline-nfs: 17 runs,
 1 regressions (v5.10.121-cip9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Jun 2022 12:36:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8543

cip/linux-5.10.y-cip baseline-nfs: 17 runs, 1 regressions (v5.10.121-cip9)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.121-cip9/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.121-cip9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      bd24696dd7ad23517733728da675a00cd3073916 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62a3381bc468b79b8ea39bdc

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.121=
-cip9/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-rk=
3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.121=
-cip9/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-rk=
3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220603.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/62a3381bc468b79b8ea39bfe
        failing since 73 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.106-cip4)

    2022-06-10T12:24:48.743159  /lava-6583828/1/../bin/lava-test-case
    2022-06-10T12:24:48.768770  <8>[   96.532598] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EA0C636CC
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 13:24:54 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web10.11502.1675171490760251858
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 31 Jan 2023 05:24:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=AbpbI71J;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.180, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f180.google.com with SMTP id e10so10022480pgc.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 31 Jan 2023 05:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4MgU+rpmJM6J0oz+3FHPbXxV8u3vbU+MWHTp0PBsx/E=;
        b=AbpbI71J1O8RBrAbJZugAQ/swk1xHuO48C1ozDsnuU4BHFlM3Yi84YeLOtLw+1eC85
         KxJ0sThQ/6No5rhXO3LzDgrLgGAuSxesCsC8xQt0EkThJzijdxUAJNug3/RMPm4ZCCht
         RRlc4ERXm2OymA4O+UbYsk4fhhXBixQK/kOWytB9cCg3vZ2Tn1bTRgE3X6tNKMfwZqQP
         9w+r3RcYY0Ipy/+vYNKl28ufFivo5sg4e2xjGj9X3jHWcaFwKEADMZCfFvCsLUbADpwP
         m9yt5fHDt2MUP7zGx8hNMmamAVdDMzLqpgmdeuNDnxI2LrjNmzzPitNC6+7aNgvrdwrQ
         PB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4MgU+rpmJM6J0oz+3FHPbXxV8u3vbU+MWHTp0PBsx/E=;
        b=OoLyVcTzG1oMoQIqiojhfco3sEK2WdcnPrvuFpGZirLuycTFW5jl1kDlVeOGx04AoB
         FD6uLwL0d2b5asy/sh2DTkwt4WN9aRvaio5JXU368kZvEUOI6LCl9J1S3XoBpdtU6oV3
         fQdZvJojjvKng8Fk3bbdCd/wAm1HaiV9gaRiG95MSV7U8mQEYxRzdGdJPJs3VVXHa96l
         JOKZQGLG34Um7itYwFyUNuCtntyWVCKnOcoxokUpeSzAIAYPC8mKSjVvD49GcjMxUSgD
         3+Sh2jY4tePS4XoyG+sQtHdFWvMCdtbDMFmghyFQ0H2rIb+qki1WemNK1VKLjUlcHPxp
         XJqw==
X-Gm-Message-State: AO0yUKUC88ZKQnOzrBeTl5k3C+92HttgiUNEE+FYFFiX8LPaHL+mK1Cj
	J4npAOLiTCa/y+xc3DG7Jd350e8PCaXUKOUglQSGyA==
X-Google-Smtp-Source: AK7set+mXcM/7YY+NODuJCsNo00RVgc329dx54kg69i3+JJ0gyJ+wZQpFFIE5r1DxeyDuQdjti9BLg==
X-Received: by 2002:aa7:950a:0:b0:592:568a:1f70 with SMTP id b10-20020aa7950a000000b00592568a1f70mr11202891pfp.25.1675171489917;
        Tue, 31 Jan 2023 05:24:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ay7-20020a056a00300700b00592547db086sm8872008pfb.209.2023.01.31.05.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:24:49 -0800 (PST)
Message-ID: <63d916a1.050a0220.eed2.f0b2@mx.google.com>
Date: Tue, 31 Jan 2023 05:24:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip72
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-cip ltp-fcntl-locktests: 3 runs,
 1 regressions (v4.4.302-cip72)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 13:24:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10530

cip/linux-4.4.y-cip ltp-fcntl-locktests: 3 runs, 1 regressions (v4.4.302-ci=
p72)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0af99ca381ce97af181eab7f6fc808b1e039ac3d

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dd2d61ac1a1e09797a6165f478abd4a9f4f43035 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d9090bed4b40d313915ebd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-fcntl-=
locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-fcntl-=
locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230127.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/63d9090bed=
4b40d313915ebe
        new failure (last pass: v4.4.302-cip71-590-g22fc523bf881) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD49C4708E
	for <webhook@archiver.kernel.org>; Wed,  4 Jan 2023 13:22:03 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.11792.1672838520603635676
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 04 Jan 2023 05:22:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=xaLCnN8C;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id g16so26181759plq.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 04 Jan 2023 05:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IS/Gcx4zpU8ksp3gWHqGq3IpQjo+Gui9XT0VfpiZYcM=;
        b=xaLCnN8Ck2+UnRmc49IkVWTdymgD3Zc5+Co0+wK77AWdYdkk/bKJATMkJBMZTBqTpI
         S2kGJdUGlMjeS4+a3zTAYWxCHe/+Phj2HKqqQXu7HcOTA3EuB9RA5KtpfKPu6ZLiP0bh
         b3SajkChfODORwz2cdu33lfPHQQEHSuJ42s03ZP8rOn4BK1hOJaG1W4Duw8RLcf5O4tB
         Ssj00bH5D4MSeVZz7wmAWSumeyANOrNfvTQ0Uw4HJ1w6WxA1hnTSmmYg58Y9X8683hIh
         BlkEe+Gx0TBmdiTNAwpDI781I2wJquqPHYlYJwIokUDU3ERKI4hT0sVtB2qXzMlcJatc
         5E9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IS/Gcx4zpU8ksp3gWHqGq3IpQjo+Gui9XT0VfpiZYcM=;
        b=AaLxw10wk3sGPrCFvVfcQT0fkWkIoGK0ypniQ2SF1IJksOYNMu0PGlwCf56ecSpCY2
         VixIlMoTqxZ1jtfrFsdUsVti01J0CchlGDuz+Z517bzjEhxWkrP3uwzRuu4HeQo9qa3/
         Dg2P7UhUBu2hHZ62zR1IlNXIh8hIsl4aVvIXM9fChspyFOexukwyqna1gc+CdX8a4F3F
         YapjhDHRlfvMnok6TfuebXtpKG8CKsP67mDOz3T7zZJ0QID2wCkXTGKLNw1rTWyj1t33
         NOscmiFmuQgH0iYwgedvX4j1+YxAgOcGbG13El2xdUAe+ZzNLyH402Pi/6Bx3FBZ9LcZ
         qH5A==
X-Gm-Message-State: AFqh2koCaq+eZJC41Uef7bvoN09ffXjJuujUi9BmwGV6P5iY1SamsgrA
	oxfINgo99vKeMTVi5bBo8xdvy3WCdoK6k/fHnQU=
X-Google-Smtp-Source: AMrXdXsPvMH+0jrLlEmtjWST7gByJg40eI3Dv8cR/841nJbHAsjBL+YEFskMxlIyXyI3Frcq0vvgBQ==
X-Received: by 2002:a05:6a20:8e0b:b0:ac:2559:35f6 with SMTP id y11-20020a056a208e0b00b000ac255935f6mr74332162pzj.28.1672838519688;
        Wed, 04 Jan 2023 05:21:59 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 3-20020a620503000000b005762905c89asm22547872pff.66.2023.01.04.05.21.59
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 05:21:59 -0800 (PST)
Message-ID: <63b57d77.620a0220.77d9c.3859@mx.google.com>
Date: Wed, 04 Jan 2023 05:21:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.161-cip23-65-gca8c192cb189
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 12
 runs, 2 regressions (v5.10.161-cip23-65-gca8c192cb189)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jan 2023 13:22:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10303

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 12 runs, =
2 regressions (v5.10.161-cip23-65-gca8c192cb189)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.161-cip23-65-gca8c192cb189/plan/kselftest=
-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.161-cip23-65-gca8c192cb189
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ca8c192cb189c6be84da2274a96e73320a638b43 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/63b57356aa49a8ef734eee31

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig/gcc-10/lab-ci=
p/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig/gcc-10/lab-ci=
p/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221230.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63b57356=
aa49a8ef734eee32
        new failure (last pass: v5.10.158-cip22-142-g79bb6f9db05d) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63b5781b5882c05daf4eee47

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221230.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63b5781b=
5882c05daf4eee48
        new failure (last pass: v5.10.158-cip22-142-g79bb6f9db05d) =

 =20


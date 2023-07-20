Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91BAEB64DD
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 16:45:19 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web10.2180.1689871514676792605
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Jul 2023 09:45:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=5mnppBdl;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1b8ad907ba4so6078345ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Jul 2023 09:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689871513; x=1690476313;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ulmiHCKxjEc/JltwuPdRfMMUX6wqWyQicuGW6/LBwqI=;
        b=5mnppBdl3DqOt1zaWv/F2xs1WEjLqYgFMU+x+1y9FX3Kuzd4d+H6Q/c+jzB8FlHDMg
         f9ZBIZJPLVEbh59Zzq5l8bLfBq3r4W0D5C/HQp6fKvhNr+0BAtWJI3eCIaIghKkpdxH5
         zTisKqRtS82ZlZKcWTzR+8zBu4WfBeMh2w+IpFyvXaYYf9gxnjsYDNX/95fcUFhSkyZ0
         NSnL2VM/KWz+fnRvUOllxo8tlMGXm+vzQQ6NcwVZPufiipM/ntnhcdbqi3QPlqw/7/AM
         K5JKbr36MsyzyPhv87kX3qxiGjUDZiGZXhSs3rVOoHpUbsZkkNz1J7rgfbiqVbF6DcKf
         Gkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689871513; x=1690476313;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ulmiHCKxjEc/JltwuPdRfMMUX6wqWyQicuGW6/LBwqI=;
        b=DD4ZNb8yBF2T/odNZqIHKqEMjawG8rHOPzL9exmPThZ1aSA2xQBTEcR56uQVTNufcb
         TV1RP8CMnWWASZTmcdoar+U+xNbhX0XsDr8q2nc5UZ4EIx0GrGWgrsypX5zwuN8WIMqN
         nbh+4DIZ95usmZii+mQMIHTR89sA3mtNm8tLi5TtcUKZEcIhUD27RbPpeYGp7srQa08H
         /DXdmE+MkFDAc7Os0N/SKFmTQVsRhYBljjdReUE3Sf+id7dQR0hZvRbGw05sIrSAbWUI
         C2521sx6Dm4ofYF4lC8dUW/ZIXArk7WTjWzdZ2zpDMSuwvT2gDQZaxuQkgD6k6WTcCLB
         TqwQ==
X-Gm-Message-State: ABy/qLYamtt71yfEXcY1AmXLiX+mf7KKRpjM7K+ptDKqGUQ8xNvhMNv8
	cUcSI/8yTyQWyE9mGmxHI92CvAUFBpg2twFjIca2YQ==
X-Google-Smtp-Source: APBJJlEXkuQyOKovR42qmIdTppH+mmVd76PYi4vkIFJBhRLHO7vT6yJT5JOUpt5O+3dyxcUWcdIcEg==
X-Received: by 2002:a17:903:32c4:b0:1b8:95fc:d11 with SMTP id i4-20020a17090332c400b001b895fc0d11mr21402351plr.40.1689871513474;
        Thu, 20 Jul 2023 09:45:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s9-20020a170902b18900b001b9de39905asm1629242plr.59.2023.07.20.09.45.09
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 09:45:12 -0700 (PDT)
Message-ID: <64b96498.170a0220.5acc8.2fa3@mx.google.com>
Date: Thu, 20 Jul 2023 09:45:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.186-cip37-12-gf8c9ce666de7b
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 6 runs,
 4 regressions (v5.10.186-cip37-12-gf8c9ce666de7b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 16:45:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12482

cip-gitlab/ci/pavel/linux-test ltp-timers: 6 runs, 4 regressions (v5.10.186=
-cip37-12-gf8c9ce666de7b)

Regressions Summary
-------------------

platform     | arch  | lab           | compiler | defconfig | regressions
-------------+-------+---------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 2          =

qemu_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.186-cip37-12-gf8c9ce666de7b/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.186-cip37-12-gf8c9ce666de7b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f8c9ce666de7b69f842e25063054c803ff45d06d

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform     | arch  | lab           | compiler | defconfig | regressions
-------------+-------+---------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64b948869ea448f8018ace27

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/riscv/defconfig/gcc-10/lab-broonie/ltp-t=
imers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/riscv/defconfig/gcc-10/lab-broonie/ltp-t=
imers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b948869ea=
448f8018ace2c
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b948869ea=
448f8018ace2c
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc) =

 =



platform     | arch  | lab           | compiler | defconfig | regressions
-------------+-------+---------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64b9422e03c02ccd328ace1c

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/riscv/defconfig/gcc-10/lab-collabora/ltp=
-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-gf8c9ce666de7b/riscv/defconfig/gcc-10/lab-collabora/ltp=
-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b9422e03c=
02ccd328ace21
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b9422e03c=
02ccd328ace21
        new failure (last pass: v6.1.38-cip1-13-ga3621452a4fc) =

 =20


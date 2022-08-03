Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4865C19F28
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 06:21:31 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web09.5519.1659507684039756918
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 02 Aug 2022 23:21:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=Z/p8GpO4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id t22so7779571pjy.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 02 Aug 2022 23:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=uJlF6bQphFeoy6IOczCPdOZEXgZPGBuqF5B2GDhiHok=;
        b=Z/p8GpO4IoySajpWz07pZuphSRbYkpKoV61ONSbq0e3rpNW3bGRq+GqWXvCAKk5CMs
         jK9beHOnR1rbMR3AwPfVZwS230LbxkLBZzdCceH9qALUhYvRg5TcpXgGrF1QnEm/qu6Z
         NZB730pFygILJ/tS/gC8kJNVRI4Zx8hHirxLNafqYSVE1h52vBFnKh6X+4ohKoGLR/lm
         seZWC4yYTAxGir2h/jYCZmNx7hmd0ECxNUnEHKTzG4Lct+X9v/SiXtLSK6A9f9oDfJhe
         Lis2b6P9Zw34c8gWWj0pPpGVhBEKpFS7RCI60CcUaKyGF00UsjW9K9lAkm5IntMj4JOc
         YdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=uJlF6bQphFeoy6IOczCPdOZEXgZPGBuqF5B2GDhiHok=;
        b=oyS2GXbbnEOZkI2fX26ohsDs1nBEVpdNhyZbNnlSs/54CKGPXtcdtwICoPnRVTpYBg
         sn1f2/qtdIjAjuDC0K/VyRpcpiyqmFcWevnJok2oTVLGRKUK4RshTIQ6AZONptxuA4BN
         kOCtTRcgFNV8696BnSDqe78VwulY3sRPgIKpR6g2OJn/G8HdAAyu26bk7WtNjAl+ztk4
         QGDCSAc2lt3fKdfvp8JVSPdn4pprSD74DKoee5BOcXKBzZNofslhwyCGdK7E4KPwn7oC
         kWCge8F2nb4HTjPLeJ68Xa79brwARkbvRpuLTtYYuKE0rk2vbVt2X+rxp60M8e5fL6nb
         Vp3A==
X-Gm-Message-State: ACgBeo3YpfdaD7F5mneklr/29FrES2a+xXcghtCdigoIBQyS36cJLpqo
	5OtREr5B/Z4xcwULpmBSXrsRQlkRkg1/nLToBYc=
X-Google-Smtp-Source: 
 AA6agR4f0krQXMqSpHI37QoXddmmft/Grvi1ik56z1c0sCw0ZCb5BGn5QO7CL3JGsAA+assbrKOeXw==
X-Received: by 2002:a17:90b:1b4c:b0:1f2:60c2:6da1 with SMTP id
 nv12-20020a17090b1b4c00b001f260c26da1mr3328072pjb.68.1659507683235;
        Tue, 02 Aug 2022 23:21:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 b1-20020a170903228100b0016dbb878f8asm878791plh.82.2022.08.02.23.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 23:21:22 -0700 (PDT)
Message-ID: <62ea13e2.170a0220.513d2.1c8f@mx.google.com>
Date: Tue, 02 Aug 2022 23:21:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip70
Subject: cip/linux-4.4.y-cip smc: 9 runs, 4 regressions (v4.4.302-cip70)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 06:21:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9036

cip/linux-4.4.y-cip smc: 9 runs, 4 regressions (v4.4.302-cip70)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig       =
           | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig+arm64-=
chromebook | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig       =
           | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig+arm64-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip70/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip70
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      42722e64d359f47f84e170ac99e4b2dd2d04865b =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig       =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/62e8da248a27527511daf06d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62e8da248a27527511daf06e
        failing since 7 days (last pass: v4.4.296-cip67, first fail: v4.4.3=
02-cip69-517-g92709d8ae585) =

 =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig+arm64-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e8da252a7fac2ee2daf066

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/smc-qemu_arm64-vir=
t-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/smc-qemu_arm64-vir=
t-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62e8da252a7fac2ee2daf067
        new failure (last pass: v4.4.296-cip67) =

 =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig       =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/62e8d7390b5127d908daf074

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70/arm64/defconfig/gcc-10/lab-collabora/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70/arm64/defconfig/gcc-10/lab-collabora/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62e8d7390b5127d908daf075
        failing since 7 days (last pass: v4.4.296-cip67, first fail: v4.4.3=
02-cip69-517-g92709d8ae585) =

 =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig+arm64-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e8d775007c025788daf07e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/smc-qemu_arm64-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/smc-qemu_arm64-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62e8d775007c025788daf07f
        new failure (last pass: v4.4.296-cip67) =

 =20


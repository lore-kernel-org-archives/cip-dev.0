Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B1FC7EE2F
	for <webhook@archiver.kernel.org>; Wed,  7 Jun 2023 14:28:28 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.10071.1686148103321086994
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Jun 2023 07:28:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=OILy6/V5;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1b1806264e9so38737555ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Jun 2023 07:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686148102; x=1688740102;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zBzaojV4LNopYOR5X1N3D0MOlqNQETD+6sE88Ke5MAI=;
        b=OILy6/V5XqENSCzxHF5HYLTqIiqKumvGzUZNqhg1iu9NaHgzxXcuaKp/npR2F9aE0Y
         WmAOUqEX6Ly7axNVQJK+Aw6+x84YN94Cq/cEPdgos01Vq6tb95/H0Ihgv6Q3qGcn+u58
         h4W3Jt71bJ8rvXLtr0jsynpPqzZuHa0Umtis6TUMNhSt+0Gkv5XTgWFEmSxO8RYhmzuM
         Xr1qif3OpCeR8D3TU1j1yGKypRdfcEmMlJPfXAmnTOsXb56y+73AtM5VdczFss5lNkUP
         UMevu8THETupPa3L4fncV5DlZ2GyxzyJbk7LoZYQ+mmHfdRt3lIogFnMbGmmJ5clIrpv
         4Gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686148102; x=1688740102;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBzaojV4LNopYOR5X1N3D0MOlqNQETD+6sE88Ke5MAI=;
        b=RK6MNTAiDncU9vmpR7K3C5BWzTEkiMs+tBPORa7Pc2X4TE08tKOEXktJk+nmWo1AXc
         Xo6Wo+RlI2oq1DJxZAN1HOketf8UOzmwOXc4wcRgwMDcZ43IWXdO48grYUSkEa2XfmM4
         PCuMY4d9t/XU22+Ccm564gBVN1XL3GkC2JG8J0/UA6S21UrHiarJzxCbMgYEYtOxJvmM
         CW/BifaDUalhCu5UXeVHDIdrancpBQiwampHNFnEoXutGKP2ZwJyk3wanLSe+hKme2kN
         Gk6LpnpXchiXg5AXiGWAGCM11y0+q0pQ9+NYh8+vEkYBB0tOZ5IfttG3Zs0+NvuJkx18
         PX9g==
X-Gm-Message-State: AC+VfDxfxr+jJbAh9+k4pxKfXaQUQWG9V8BVnezrFp9I78jyab2VXFZ5
	TCEBA0dCLFVdaFqKskpY42V9cKBtskRxoRKU/cZvMA==
X-Google-Smtp-Source: ACHHUZ4hblFLxwjqwA09f5qiTxkSliJJ6wMQVFLGHMJu/Tx4M/o2+YHRFDBp3dyfrYioVywAV34AXw==
X-Received: by 2002:a17:902:ec8a:b0:1b2:450f:99e with SMTP id x10-20020a170902ec8a00b001b2450f099emr1618351plg.46.1686148101681;
        Wed, 07 Jun 2023 07:28:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s8-20020a170902ea0800b001ab01b909c9sm10531371plg.120.2023.06.07.07.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 07:28:21 -0700 (PDT)
Message-ID: <64809405.170a0220.d699f.3f7b@mx.google.com>
Date: Wed, 07 Jun 2023 07:28:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip76-rt44
Subject: cip/linux-4.4.y-cip-rt baseline-nfs: 54 runs,
 4 regressions (v4.4.302-cip76-rt44)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jun 2023 14:28:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11914

cip/linux-4.4.y-cip-rt baseline-nfs: 54 runs, 4 regressions (v4.4.302-cip76=
-rt44)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip-rt/ker=
nel/v4.4.302-cip76-rt44/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-cip-rt
  Describe: v4.4.302-cip76-rt44
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      246f4be89a7760f90649094cbfabcccfce7dafd1 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64808b6de18ca39486306140

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip76-rt44/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-c=
ollabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip76-rt44/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-c=
ollabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64808b6de18ca3948=
6306141
        failing since 63 days (last pass: v4.4.302-cip72-rt42, first fail: =
v4.4.302-cip74-rt43) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64808b4790338f421e30614e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip76-rt44/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beagle=
bone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip76-rt44/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beagle=
bone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64808b4790338f421=
e30614f
        new failure (last pass: v4.4.302-cip74-rt43) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/648089d7e8d5549b3c30613e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip76-rt44/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-=
nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip76-rt44/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-=
nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/648089d7e8d5549b3=
c30613f
        new failure (last pass: v4.4.302-cip74-rt43) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64808aca6e25ba0204306144

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip76-rt44/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-c=
ollabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip76-rt44/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-c=
ollabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64808aca6e25ba020=
4306145
        failing since 120 days (last pass: v4.4.302-cip71-rt41, first fail:=
 v4.4.302-cip72-rt42) =

 =20


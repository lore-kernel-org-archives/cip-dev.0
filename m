Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810C6C32793
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 22:25:36 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web11.31289.1674080734370088639
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 14:25:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=nUPR+mYv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id s13-20020a17090a6e4d00b0022900843652so3989477pjm.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 14:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UIS53Ufm2kJb28uOIhw3N4ZCn80K/JaWs1ximYnQM9U=;
        b=nUPR+mYvti4R66G5E6EN3IIvXn4TkpiG7t3mLBYXEdNIv+93P+p10Ecs3JNOeeAG6J
         ngOLOBW6nlZKDTUrTaCxnquJQs38LJRO/nb1MlaPAMK1jEPYAwfLKN8FlIiWoXIbR7Uj
         ZQZp4LdXQ6ShSHbTRZdexUcrWs2AaY1egPw9FAP+zErpd9zikLXzb0goT31LFfVr2NFg
         qA/lFrrX2Fikg5yDYAOPyqtEOIiiF18N7FshhWbTZdcEpsFtMb9u4jmxJlJFHbXlsdt0
         gb224Oqd25/pnzaxLikgXOadOW/yT29Ay08ZxWl3uVCaCxQYdxGF2aXsZleLWHduMOyT
         2f5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UIS53Ufm2kJb28uOIhw3N4ZCn80K/JaWs1ximYnQM9U=;
        b=qlBP5U4T1MxrzbejsQRoXBsIt4x0WYj3qlPWea7VfmGOAhyeQd3eqLuXw7yrA6tcvY
         Abu+yBGxBclR5YCjQFxedP3KFzuvN8Fq4zJi1OFRXzsmeCt7kUsMlU3uC6In3FIYmo6l
         wxOV9jzmYKf5D1OFtQ7sybIgUUNZL4WguELSia5jEzV7oG2HSQUNsvOXqR6taxLhBGjb
         xvDXLbPCwaH1wIFmGaYx6Ax8e4xJbxdek2w2wgv1m2q0/HUSwe0y7Ze1X9m7d/PviT/w
         U50Hjy+aSIPpblvxP7dq+NM4G7WhiECAAwFjZfpQH18IYXCSbyTT0HQ6xvTVv//e+R3O
         80vQ==
X-Gm-Message-State: AFqh2kpq/GNJRiqsNAQ9I+GDz2s9/30vUJfrEdjT+ukQOudjgjk799jp
	JTTS9ySbmoAltYcQfBxIQUM3geVIuHoGXgiU0zo=
X-Google-Smtp-Source: AMrXdXv7117kMgwIXDQqp2Y2jjeEIs+XCaq5nw0Ek3AXCdE98pIlPDxJUBZ8oaGbbS9tLGXGx2Zr+Q==
X-Received: by 2002:a17:902:ea0a:b0:193:389d:ecc5 with SMTP id s10-20020a170902ea0a00b00193389decc5mr12757383plg.47.1674080733552;
        Wed, 18 Jan 2023 14:25:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id iw18-20020a170903045200b00194b0074b25sm3162516plb.160.2023.01.18.14.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 14:25:33 -0800 (PST)
Message-ID: <63c871dd.170a0220.27eb2.5c75@mx.google.com>
Date: Wed, 18 Jan 2023 14:25:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Kernel: v4.19.269-cip88-rt28
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip-rt ltp-ipc: 10 runs,
 1 regressions (v4.19.269-cip88-rt28)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 22:25:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10410

cip/linux-4.19.y-cip-rt ltp-ipc: 10 runs, 1 regressions (v4.19.269-cip88-rt=
28)

Regressions Summary
-------------------

platform         | arch | lab     | compiler | defconfig          | regress=
ions
-----------------+------+---------+----------+--------------------+--------=
----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.269-cip88-rt28/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.269-cip88-rt28
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2b470889b91ffbff27aafaf122ef1ff24fa4e82c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  cf59c1fb5f7181453b16171d75654ee9a1216dde =



Test Regressions
---------------- =



platform         | arch | lab     | compiler | defconfig          | regress=
ions
-----------------+------+---------+----------+--------------------+--------=
----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/63c85f5870c839a4c8915f28

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig/gcc-10/lab-cip/ltp-ipc-beaglebone-bla=
ck.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/arm/multi_v7_defconfig/gcc-10/lab-cip/ltp-ipc-beaglebone-bla=
ck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/63c85f5870c839a4c8915f=
29
        new failure (last pass: v4.19.265-cip85-rt27) =

 =20


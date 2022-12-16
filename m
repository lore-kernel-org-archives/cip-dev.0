Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B909EC001B2
	for <webhook@archiver.kernel.org>; Fri, 16 Dec 2022 21:10:41 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web11.6526.1671225037073044707
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 16 Dec 2022 13:10:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=rVpB9nhQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so7339966pjj.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 16 Dec 2022 13:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6GS2qU7Z52UiyUWq4W1fyUliZRl+T+c+sLweDhXXfUY=;
        b=rVpB9nhQS5VFK0vM4VDriwH8m8LmhPQh1g5xL5RPblKLQeMyo4UdYH/gUiCzvrmHjx
         lFaaodmCnd2l2FIONo0Ubz93vNAur1GHZQTpogji8tBC4OgZHT3iI/hYODRj0LpfNCQc
         9pogU7l5c8dW5mpXZOUsYI1/Zey1Y51fxVkRGRThaFb3+0zzhP21qRVO0j2os+B2zP0V
         QSHvXYaTer5Zo9uk2qy0iRI4bhMq1XNA1eVgeoFPDntrML/7VACRfoDPCZZixJry+19V
         aX90I9iPHsY1lus++WEVtOpY8gwQPSS2sqGCn6QSAF1mz+N0z18JPNUxuC88iisgjfsE
         TD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6GS2qU7Z52UiyUWq4W1fyUliZRl+T+c+sLweDhXXfUY=;
        b=mzhxTWkk5dPCNIPt1wklZme0uOUokCvOZ/XIDsHL4Uy7nux736nMdWBuXnHxc5cB3S
         1XejyFYUdBfnYIeNQcad3iT9hQwzRSg22aX5UqSV9pVp7ISnDraN4iJBp5F1fb1vKRK5
         GsNJrFUPUn86orqB+cYbxBQIdN3s+UBF2w/id0t/NsB1XwuTASN27QZ3M65Nb/Bdn8QJ
         qZrEmAS4j1hKSL9LcDkyAza43Dj41//50vNDqvpolyrFAPYOvo5WQi6i7pVdHfi1OkVr
         qP81e/S5JqGlFAGOHcm+oJ58f57UAvwAbtcUb629vAkMYGbcccYPoByO2JBHq0HUpbfq
         BAAg==
X-Gm-Message-State: ANoB5plHug6/IJlAedtZADqnruyAwqp46DybsV1bTI9Z51WtvtCcaKRM
	ijtTnanVxu0MADBg87qfbWUBKvko2owiysaYABs=
X-Google-Smtp-Source: AA0mqf7G49QPljHbmz5NQItLxzfMdMtCfthxwFEls3O4alEPMYlO8zKohMDO9VgfZzQ74RPXpusY4Q==
X-Received: by 2002:a17:903:234b:b0:189:e7ea:9ff9 with SMTP id c11-20020a170903234b00b00189e7ea9ff9mr48752287plh.42.1671225036332;
        Fri, 16 Dec 2022 13:10:36 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709026f0800b00186bc66d2cbsm2067426plk.73.2022.12.16.13.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 13:10:35 -0800 (PST)
Message-ID: <639cdecb.170a0220.1cd6f.440e@mx.google.com>
Date: Fri, 16 Dec 2022 13:10:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.158-cip22-7-g92462fd9830b
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 6 runs,
 4 regressions (v5.10.158-cip22-7-g92462fd9830b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Dec 2022 21:10:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10245

cip/linux-5.10.y-cip kselftest-lkdtm: 6 runs, 4 regressions (v5.10.158-cip2=
2-7-g92462fd9830b)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+k=
selftest          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.158-cip22-7-g92462fd9830b/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.158-cip22-7-g92462fd9830b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      92462fd9830b23227198482fe4bee42316a5694d =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/639cc84090faa250e52abcfc

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc=
-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc=
-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221209.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/639cc84090faa250e52abd02
        failing since 171 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/639ccb43028c7144852abd13

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc=
-10/lab-collabora/kselftest-lkdtm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc=
-10/lab-collabora/kselftest-lkdtm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221209.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/639ccb43028c7144852abd19
        failing since 171 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/639ccdbb0f3ce126f52abcfa

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc=
-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc=
-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221209.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/639ccdbb0f3ce126f52abd00
        failing since 171 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+k=
selftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/639cd87bcb6447c6972abd1f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-l=
kdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-l=
kdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221209.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/639cd87bcb6447=
c6972abd20
        new failure (last pass: v5.10.158-cip22) =

 =20


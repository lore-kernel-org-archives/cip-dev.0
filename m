Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFD9C04A6A
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:22:19 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web10.162099.1692195736717754198
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:22:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=q1pSJ8f3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.182, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5657add1073so3341070a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Aug 2023 07:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692195736; x=1692800536;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p1rTiGn2N1wkwwa1xYPcvmbvEs86WhQR/+iiyUG2mzA=;
        b=q1pSJ8f3mgQHNNrjWLRdnsDKLue6a1C6Vf/gZZLm5HqYD4CFiearmk9ktEA0xBh3Q8
         MHJvAyV8Fe3Eq3pTc6FtFHRiEMOFfjl5Xgd3UPLkyMV+HixRj2x6s+tV7czS4C9S7rOL
         mb75m1Hs1264V2nqvKumR+injCktBdxXE4FdC6j/8xHKD8v9DQcLcTE0a0jDrOp2mI8+
         Hkl5nruk4vlha7rYX4wt7RcvIFYV0Tle3PmB2CjKiKnbPFCv5qDz4GTqTFbr/s3j7mye
         6NS9j6P7noVFBfJTgkLtsGSVJi3aOl2r2CMQnR3G1rszb+SWtQbOrKN4dZ0PM4eqElBM
         SSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692195736; x=1692800536;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p1rTiGn2N1wkwwa1xYPcvmbvEs86WhQR/+iiyUG2mzA=;
        b=MqH7L94kfsrFY7sLZZDjF8najz27szOtyd+PtoCzXKE84EjJdB3HMse50vt3u43vd9
         X68WAi6MZtNbvjP+SfQjemunDquWYE7bd+wmXrxbjm5ZrZW90OS8F3/zQkJS3aZpC0pk
         1Sj76WSWkfRugQOfgzn5yUrlHIAHhm+50fHoExBf08STOPU/95No1eHSdg+omm4x01br
         GliW9ttkW9gxs8ljHUgRAi9lTJHnFmi9OMzCH5Xove8bF4kb9id6NvD2DA0aX5HxohwC
         YKIipTspyhHD60LLi1NIL+gQjyfxulli5uyVuFWgGZQA6bSjlt4IDLoYj6NCCYHZA9Jk
         6+nQ==
X-Gm-Message-State: AOJu0YyQOqwNYzGsLUHlfylHexMKrMu7vMuomBA1yZbXTJkTMKaDuZIX
	daoXje8/prVMlflim3qPRJzhoKjqqtIxvBHrmk5WVQ==
X-Google-Smtp-Source: AGHT+IEjQuAwSi+kaYfykHnDcGJrH86U0VSWb38261Xg/XKUcOh+omfr82WzdlgRsVaWDHx9povFyQ==
X-Received: by 2002:a17:90a:d252:b0:261:219b:13b3 with SMTP id o18-20020a17090ad25200b00261219b13b3mr2890226pjw.16.1692195735659;
        Wed, 16 Aug 2023 07:22:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c6-20020a17090a674600b0026b25c05495sm9492269pjm.20.2023.08.16.07.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 07:22:15 -0700 (PDT)
Message-ID: <64dcdb97.170a0220.b712c.fde5@mx.google.com>
Date: Wed, 16 Aug 2023 07:22:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-2312-g74888f4b13f0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st-rt
Subject: cip/linux-4.4.y-st-rt baseline-nfs: 13 runs,
 1 regressions (v4.4-st20-2312-g74888f4b13f0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:22:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12715

cip/linux-4.4.y-st-rt baseline-nfs: 13 runs, 1 regressions (v4.4-st20-2312-=
g74888f4b13f0)

Regressions Summary
-------------------

platform   | arch | lab         | compiler | defconfig           | regressi=
ons
-----------+------+-------------+----------+---------------------+---------=
---
imx6q-udoo | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rt/kern=
el/v4.4-st20-2312-g74888f4b13f0/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st-rt
  Describe: v4.4-st20-2312-g74888f4b13f0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      74888f4b13f0cb22c1c00a5622e0cf2dbebe60ea =



Test Regressions
---------------- =



platform   | arch | lab         | compiler | defconfig           | regressi=
ons
-----------+------+-------------+----------+---------------------+---------=
---
imx6q-udoo | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/64dcd52c677e2d7a8735b2f9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rt/v4.4-st2=
0-2312-g74888f4b13f0/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nf=
s-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rt/v4.4-st2=
0-2312-g74888f4b13f0/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nf=
s-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64dcd52c677e2d7a8=
735b2fa
        new failure (last pass: v4.4-st20-2172-gb3363b986efb) =

 =20


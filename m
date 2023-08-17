Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86498C05052
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 02:47:56 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web11.178623.1692240468846221779
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Aug 2023 19:47:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Oj7KOIj6;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-26b0b4a7cccso4949276a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Aug 2023 19:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692240468; x=1692845268;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aMGABRZ0Ajz7oeIpvsONQqN4QnKKULlHjHukou4vV/E=;
        b=Oj7KOIj6iLVtuszamTrTQyyn5iUweefs26+8Zz0aI6fngcuaOOfYejuUCI9MjoG/t+
         om8aF1z9QXZXK6oR1djX6JZG0hQuQ70ND3Z+Q7SFEqKYmEKajuHygJtLBFQFH5fWTHR2
         3a6SvWle8TivLeptDhYhL64DTQ6xnHGUf/QnSgsf6sPNlTbZZfodfCM5QZIXAnlE3uIj
         4tMoswHOoGof4AcBl2GNxp3Bxqxlpg9ulxDKS8GDyALEGbkFxNBLyhyfTNgxLrUhftm/
         NS0AscAi/cdMrj1G0ZOmbs20eR6jPkYICtbLOpKrCLp2JDLnZcR9lMkS5vG2UJl+KOIK
         OvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692240468; x=1692845268;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMGABRZ0Ajz7oeIpvsONQqN4QnKKULlHjHukou4vV/E=;
        b=eNBU0XgSwFlF43Xvhqiqf8G72SlWC4heHASIUHBIG6P7Ea5XbP8VzijFn67bQlKC59
         oFm4wwAvQ68+8KoQrsVu4ruZxKxCsBtpZZe5YymOAQZH40+tymSVGQcSUN79KnmuM5dv
         3d2yBQRQp43b/xLh5XS8B/xVhbPXTTJpEBxYa5yZLJ2Y/EirtygygUb4kDblP464Mwgf
         NHotjSUyCBTbGQiGmlCYAG7MTKapygLYzB/gSQr0SVWOStFthLYkHblVpw92UcnTCbHr
         w1+eY56T6J0q+pJmH0UW9DP/u6iHSyJZNoXZW439FIyxGi3FAM0zybuxPO28H7QXiHzp
         eQMQ==
X-Gm-Message-State: AOJu0YyG0URatB23Q5INUSga3qC7L9KTaJmRKFXLb8GA5D5cGOntxCe8
	cDIVNcpmPW7OPQVcwp4AkUqmZK496MreF8sf+/tNbA==
X-Google-Smtp-Source: AGHT+IES8alJkwJEaqKNb0SSiq/siLp0xogX8/OraVamFnjt4uXw13J8fB/sQh1BCWAIiZLPR0kqDw==
X-Received: by 2002:a17:90a:7bc9:b0:268:2523:652c with SMTP id d9-20020a17090a7bc900b002682523652cmr3318025pjl.31.1692240467619;
        Wed, 16 Aug 2023 19:47:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a018900b00263d3448141sm483200pjc.8.2023.08.16.19.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 19:47:46 -0700 (PDT)
Message-ID: <64dd8a52.170a0220.29dc0.161c@mx.google.com>
Date: Wed, 16 Aug 2023 19:47:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip78-rt45
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip-rt
Subject: cip/linux-4.4.y-cip-rt baseline-nfs: 26 runs,
 2 regressions (v4.4.302-cip78-rt45)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Aug 2023 02:47:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12745

cip/linux-4.4.y-cip-rt baseline-nfs: 26 runs, 2 regressions (v4.4.302-cip78=
-rt45)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...k+preempt_rt | 1          =

imx6q-sabrelite          | arm    | lab-collabora | gcc-10   | multi_v7_def=
c...g+preempt_rt | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip-rt/ker=
nel/v4.4.302-cip78-rt45/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-cip-rt
  Describe: v4.4.302-cip78-rt45
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3cf7ed0b67379f8a7553970ac5ae1fc052d22719 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd800d4af1c10a1935b1ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip78-rt45/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-c=
ollabora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip78-rt45/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-c=
ollabora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64dd800d4af1c10a1=
935b1ed
        failing since 134 days (last pass: v4.4.302-cip72-rt42, first fail:=
 v4.4.302-cip74-rt43) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
imx6q-sabrelite          | arm    | lab-collabora | gcc-10   | multi_v7_def=
c...g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd7c8fd14cd27b1a35b1e5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip78-rt45/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/baselin=
e-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip78-rt45/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/baselin=
e-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64dd7c8fd14cd27b1=
a35b1e6
        new failure (last pass: v4.4.302-cip76-rt44) =

 =20


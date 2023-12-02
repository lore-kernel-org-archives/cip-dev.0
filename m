Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E21C46CA7
	for <webhook@archiver.kernel.org>; Sat,  2 Dec 2023 00:36:53 +0000 (UTC)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
 by mx.groups.io with SMTP id smtpd.web11.8784.1701477409530919811
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Dec 2023 16:36:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=MGqW2P4Z;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.41, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1fb06f38df0so243927fac.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Dec 2023 16:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701477408; x=1702082208; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WnQWSWyOq/zvey3HKUW0Wl+6mtk/37oDrnjJufSJKfQ=;
        b=MGqW2P4ZGqV9RvLAhkRhbljJmnQu0pgujzdHfsRgoSAYuSsi4uUliAkpoWI2UhAn/K
         PqyMbZcs3Ywp4w/BIaRLXpIBU+qQ+cLEIsACzinIBbv984jwKsyBRudbOu+i1mwa25cp
         /PsU0qL5UTNxhbt2WORN0JZj9EHaVyGaIIyoe3Swl3rggd++czXYP7TSEsiCAavp0uaU
         znn2lg+PNfpbuVgeNFNjuctZAQRCz0QEAp4yI1jyDxCRaBsShU6d8+Bp/vRtJY4xJjp+
         tmmDKxLOMIhkPboYZ/jFz5taZW8OUPNdTm5ZfNKJ4GKC0/2ZC8fbrH1CihXrwpv6lE9l
         4k3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701477408; x=1702082208;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WnQWSWyOq/zvey3HKUW0Wl+6mtk/37oDrnjJufSJKfQ=;
        b=ndmbWzhGRo7cvjH76q34WYNXGvYDBHBQ6wHU6mFdBmLdL3pYV0/RCf6dBw0PEJbVzd
         7KZ2xLoqz/xpDXZtAo6v5iYBJEF+CYwYKpPt9QtxVWxkNFv03Eblk3I0ZEUJzmyrTIEN
         dqK20P2cVsqWmj33rq4qlPHVDzVVR2aKvYJs0N4xauPEBTMdzqjTJ8lwOachBCpNMBfu
         c7rQsnMYdEbC1jsnOmaqRW5dPhidB5oxt6tPKzPp4FLgqpLT4ni1K9AnYQ/FkfKPbT1M
         BiZpyZzUAOkDpVR3Q6ffQRdn9dlkBysPekS+b3H1dhQ9I/pnjHYunNR1tub1/2nNIX5h
         8j1Q==
X-Gm-Message-State: AOJu0Yw16JKl2GgyNGR0rYc7863cuKDr/UI7vsWo7RsEgtnrtDAx5rQg
	NhUcBahieXRqme2bZsm15mgTx2WnqJNkmEMJ0QSNUg==
X-Google-Smtp-Source: AGHT+IELPvw2KyZKfnB2lh3QqXy3EGLUkRpB6EiOJA2KZTqcFBJr69pGDIfhMqqCh+6ZiZ+jh4NPBQ==
X-Received: by 2002:a05:6870:63a8:b0:1fa:ed79:4cc4 with SMTP id t40-20020a05687063a800b001faed794cc4mr559233oap.6.1701477407993;
        Fri, 01 Dec 2023 16:36:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t15-20020a63f34f000000b00578b40a4903sm3652845pgj.22.2023.12.01.16.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 16:36:47 -0800 (PST)
Message-ID: <656a7c1f.630a0220.582c4.cb29@mx.google.com>
Date: Fri, 01 Dec 2023 16:36:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.64-cip10
Subject: cip/linux-6.1.y-cip ltp-ipc: 13 runs, 1 regressions (v6.1.64-cip10)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Dec 2023 00:36:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13773

cip/linux-6.1.y-cip ltp-ipc: 13 runs, 1 regressions (v6.1.64-cip10)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.64-cip10/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.64-cip10
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      6eab166db6d4f9b10eb2993de0fcd289a09024bd

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/656a78b30d9e4afe26e134bd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.64-ci=
p10/arm/omap2plus_defconfig/gcc-10/lab-broonie/ltp-ipc-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.64-ci=
p10/arm/omap2plus_defconfig/gcc-10/lab-broonie/ltp-ipc-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/656a78b30d9e4afe26e134=
be
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07) =

 =20


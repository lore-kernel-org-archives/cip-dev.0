Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69777C43217
	for <webhook@archiver.kernel.org>; Sat, 26 Nov 2022 11:44:05 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web10.68569.1669463042303103796
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 26 Nov 2022 03:44:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=WJbxG/vR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.172, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f172.google.com with SMTP id q1so5879402pgl.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 26 Nov 2022 03:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EER4fMqv9likauG+tZYtwAZacMqkpp59T9uqqcbVWp8=;
        b=WJbxG/vRf89l5PlCuMFgcYYPehU3p9kknrIG6vvEV1NEs0nVHqmS5YGprf4E6VO1F2
         N1mQBZ0FGEGsYFztsYEnELsxEPGzShYv3Q+IyQvhDynDfQqKz0WbW/cAq9j0LhZ/kTQp
         zwGfpxhkLW1vX7hD6HlcQdZZAdnht+2TWGmiidN6s5WYTO58KeQMdaalGHSn53U5kV20
         dRq0uHJDrfwe7cPmSzEzgUzTvEQn9B3uAgo9xlC1s9Wrnk8T+4MpTaqiF9rmQ7IhTKr4
         RBuPjGKWnFezcOTPi/RESdsreVbrflWrdxlSg7vq5P7lGTYdv8Ki/R1aWUhx3crQLOSt
         nOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EER4fMqv9likauG+tZYtwAZacMqkpp59T9uqqcbVWp8=;
        b=vdwVBgdjYG/2AFrkWnuYY3n2xfbaJh1eWYcXaMUFg6sWqwn9t1b3t5guI2L/bRFbop
         kl+Mu7kUgz7BqSv0gCgWPQ2l8YSvnFtQfiWHNJEYmN+Jx97kDqmQVZvOPDL+2HLNKQw3
         cwZhxa6b9E2yI2BWKtTHcEKWegbzvAp6DER3V8EUdPxif99u64DG5Ye5WFiVRcXPNXZM
         qALj71a4+x4mxNldtziPM7JprkX1nP5W3O9mGsO4TGtKTX5l7Xbz1iKy6P6bkrKf17HZ
         unyplWzk6YuUipC6VHGZbjGBphQ/zsVIBeY5iiigmcxmFSlazz+HysrbU9FfmkItY8NL
         z0fA==
X-Gm-Message-State: ANoB5pmk3CEr9l+BsCRx7NfBFQuLxNmjkRslzSXB783O49Fo0sNARx28
	dsmdmjnSSF9KTpgF6HK+oDO3RV7kHl4Pp1lYsg0=
X-Google-Smtp-Source: AA0mqf4BQX/uvqpu9GFfNwfOpPwg06TF+LkiJOMnUH4xjDIMGm6P0dXs+hroqLSG+nN/cVnHiUVcKg==
X-Received: by 2002:a05:6a00:3204:b0:574:31bb:a576 with SMTP id bm4-20020a056a00320400b0057431bba576mr19293414pfb.46.1669463039302;
        Sat, 26 Nov 2022 03:43:59 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e15-20020a170902ed8f00b00177efb56475sm5195753plj.85.2022.11.26.03.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 03:43:58 -0800 (PST)
Message-ID: <6381fbfe.170a0220.ba38f.6e05@mx.google.com>
Date: Sat, 26 Nov 2022 03:43:58 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.266-cip86
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip baseline-nfs: 30 runs,
 1 regressions (v4.19.266-cip86)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 26 Nov 2022 11:44:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10117

cip/linux-4.19.y-cip baseline-nfs: 30 runs, 1 regressions (v4.19.266-cip86)

Regressions Summary
-------------------

platform      | arch | lab         | compiler | defconfig          | regres=
sions
--------------+------+-------------+----------+--------------------+-------=
-----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.266-cip86/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.266-cip86
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8c8d57a3cae5b94b0a26c176e2a32f260fc529ae =



Test Regressions
---------------- =



platform      | arch | lab         | compiler | defconfig          | regres=
sions
--------------+------+-------------+----------+--------------------+-------=
-----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/6381fa80ba799fed4d2abd17

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.266=
-cip86/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20ek=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.266=
-cip86/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20ek=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221107.1/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6381fa80ba799fed4=
d2abd18
        new failure (last pass: v4.19.259-cip82) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D93C41513
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 11:30:18 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.158279.1692185412174163016
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Aug 2023 04:30:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=HWb0LZYu;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1bc8a2f71eeso41184925ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Aug 2023 04:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692185411; x=1692790211;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bSLeIZ7AxW0DpXjPWPHBmNLoVtqNHNHZErHit9EwLH8=;
        b=HWb0LZYumN/GJ25pyoeZU/Tlr5Czr1P8sYolipfxirOGH/MMdwF613yQhrXBgyzOw8
         U2XJcAZhy+MZSfsH044yRKPeBSRGwCwDf3JgIkZGyQZN1/V2dAtdzPmXzyVa/pSjXJXc
         ijStfflHTsLWBZOV02j4h1YABM4JP0rdA0/F/XEvb0JJKfkZbtY1EvE9E7m4ZYCg1zt0
         5aOkYoekMuHMG0hblcZzkNL23jJl+rxS+boJe53VGR808qFOxEaQdXUSWH1BuLxEEAl3
         plrliSjmE1Xs3FZ377CfP1zyjOqs/fgX3vF6K8Nc010G6JBzfVmy6Nn5vM+1ktKalcu7
         5q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692185411; x=1692790211;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSLeIZ7AxW0DpXjPWPHBmNLoVtqNHNHZErHit9EwLH8=;
        b=ey1+nhFY6aQ821KBA92Y73s8GmkieLwF7kGpY96dP07khgTLJYgf8KL+WBIFyUbnIV
         EbO54npV73nyLl0m8eSg/O8HasUepyECapX+Ud89XsjV/EuUX0tKBQcAcXBM2WsMZQWE
         NEGlizu6FJQjk5NMDqWVkiszALti6HZn4n4cn5GHtTmQUo3JBfE+HIiQUNz1mQN1z6q5
         4XJSwqr1T/BTEtgChbSYyVJuL/miUj9yoqfF2zqZp3z7hqpuq4gda/QS1paWKRqj4B66
         CwLf0IYwFuSoemBSvgN6zEqFMpBWYAl0Rifqi+VnnP0tkJbvOsqQ7QmkKTnuKrqrbTjR
         K6yQ==
X-Gm-Message-State: AOJu0YyzbJoj5J6/+VxmbJpB8LfofnOaeAAwj5jF/I4WwERTJ7fCC2oX
	6C0Hm7B+HPFNVEWVGRSJ3gb+bajsnllXMkGuaVwh0Q==
X-Google-Smtp-Source: AGHT+IEMwrSFyJyP78bZ6BhPg4dCPiq/d5/vlJAg2KyEKGZEwOcKPUANzUHNpXJcG7t+4EdOvxiotg==
X-Received: by 2002:a17:902:e543:b0:1bc:3944:9391 with SMTP id n3-20020a170902e54300b001bc39449391mr1757722plf.25.1692185410629;
        Wed, 16 Aug 2023 04:30:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902728c00b001ac7f583f72sm12872512pll.209.2023.08.16.04.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 04:30:09 -0700 (PDT)
Message-ID: <64dcb341.170a0220.74bb9.7d7a@mx.google.com>
Date: Wed, 16 Aug 2023 04:30:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-14-gc9b5a049d8ea
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip ltp-pty: 5 runs,
 1 regressions (v5.10.186-cip37-14-gc9b5a049d8ea)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 11:30:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12670

cip/linux-5.10.y-cip ltp-pty: 5 runs, 1 regressions (v5.10.186-cip37-14-gc9=
b5a049d8ea)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.186-cip37-14-gc9b5a049d8ea/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.186-cip37-14-gc9b5a049d8ea
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c9b5a049d8ead0f771ee3424c42b20632ebc5b3b

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dca1591efcda8adc35b1f9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie=
/ltp-pty-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie=
/ltp-pty-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/64dca1591efcda8adc35b1=
fa
        failing since 7 days (last pass: v5.10.186-cip37-12-g2710acbceb751,=
 first fail: v5.10.186-cip37-13-g260094841fe1a) =

 =20


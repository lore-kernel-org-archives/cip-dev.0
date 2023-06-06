Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F4AC7EE24
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 15:56:46 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web11.192.1686067002251118167
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Jun 2023 08:56:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=NJK36FoA;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-650c8cb68aeso3602329b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Jun 2023 08:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686067001; x=1688659001;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UpSpIhyr3XhTFHXEQDnk7j0wwBpninpJlph+pA+uG98=;
        b=NJK36FoAFJ5dDAeYdkuBFb1K612RxcF2irIkqG8vX/nttKhEYUp5ljvkcYKYCYJf2j
         3vhQRo2/2pjxWhNH8AxjHJmLOx/ZDRcVEgmaG6tSC4P/qPk/cBDB6zPxyX+nGiTQgfAM
         W8UM1ysBucXSY2NtNDHc4dSK1zyXIc5QZkBYboc6TvmrqzFW7ZqAQDDEp/ujkIqotTUN
         KSLG096r1HNeBeoHa9DLQnm6Dai1zmn0d2QJV1qIRKNwvbTAIeIB0t+Xy6XsuKkM17Xo
         mbvh6AZBlpmz28XUaPnnQmprhGgaEEGO3Eoa2dVqzen0ze7VC7KokEHnj9YIxp3fHDCF
         2tyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686067001; x=1688659001;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UpSpIhyr3XhTFHXEQDnk7j0wwBpninpJlph+pA+uG98=;
        b=cyk84EFLrQ8VKDXQYjBE6XTbhxd9e1FIVcCRBPciRLvDDO5X6rUsmbXigAzU7uvRIv
         hY25IVTzzjgOpPj79fHGZfCpmpbOM3dbKLHSPSNys6HReCVhuDA0HOyTXKZAv10xuB2Q
         jkBJxBfpBJD3gjNi7fYJV5F5JNJ8b85BY/WN2gPd7RIROVIIt8iJFtH7sy0fq7wc5Zss
         rJ8+AonXRJ9eeArPnl0i04bzRXSVIcZJTGUYEPwvTIMqklYb29cAdhBX+Qg+88sx2bKq
         KQJ2B1A0DUOVOrsB5l6Lpg4dYn+SQTdDHeZj+Bxj8q0/h1bOfvRsrbGtAQ0Lvh3NMRO8
         Z34w==
X-Gm-Message-State: AC+VfDxJ9/REYLxya+87v2FqWp/9o51d6FhMiNGMznXAF+xo0d6JAFk2
	W/gqgeILxJChDc1L7CHr25mX5Tn4Lkva/VT5e9opxA==
X-Google-Smtp-Source: ACHHUZ58viZnnR4Yvyw9aEWL2JqbkvNtDiXtOJVOPtGWJcby339TlOQOKq0SEn6WGO9e24QzSeOFRw==
X-Received: by 2002:a05:6a00:3982:b0:650:6e3e:a8e3 with SMTP id fi2-20020a056a00398200b006506e3ea8e3mr1024363pfb.26.1686067001384;
        Tue, 06 Jun 2023 08:56:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h6-20020a62b406000000b00637b0c719c5sm6954572pfn.201.2023.06.06.08.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 08:56:40 -0700 (PDT)
Message-ID: <647f5738.620a0220.bf725.d486@mx.google.com>
Date: Tue, 06 Jun 2023 08:56:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4-st20-1308-ge1d2f27f3d7b0
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.4.y-st
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-st ltp-timers: 6 runs,
 1 regressions (v4.4-st20-1308-ge1d2f27f3d7b0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 15:56:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11900

cip/linux-4.4.y-st ltp-timers: 6 runs, 1 regressions (v4.4-st20-1308-ge1d2f=
27f3d7b0)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st/kernel/=
v4.4-st20-1308-ge1d2f27f3d7b0/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.4.y-st
  Describe: v4.4-st20-1308-ge1d2f27f3d7b0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e1d2f27f3d7b00de8c897e307a469e764166b3f0

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f44bcfd430eb664f5de34

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
308-ge1d2f27f3d7b0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
308-ge1d2f27f3d7b0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/647f44bcfd430eb664f=
5de35
        new failure (last pass: v4.4-st20-1187-g8497d3390dc2) =

 =20


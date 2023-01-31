Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C95C636D3
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 12:54:54 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web10.10904.1675169688465627123
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 31 Jan 2023 04:54:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ukZ11BEK;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id 5so14966474plo.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 31 Jan 2023 04:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=spCkTCCW8Y4jRooe0+VSvIZVg7J/84CQRb0uVRIFGmk=;
        b=ukZ11BEKtf2OeZvujcDmz0tVijprNivMI1c5xmkenkUSFeo46K+Hp49ALwo+I67JPU
         xS9DeYdLoM9yedUFL1+rLPKtKiEMk6v+jdjajzCEr6GWQ5JaKnl4keSIXHHoQDgET7aH
         uaWGkNrw23kCbg3XeE6U9oEi/KQGi7NstuXfZv+k6j1xmcvzu52PtkdW6LBKPvhVYbln
         bwzdhWmGfJFK03ip1TPHKf5ITv7cVF1VVQi6xy89E2iIMYdb3VCZljAVfjaj/UFK29tW
         PEHfvCXb7qQgG4LZg447ps8a7c9BFfdUBIbz6t6NnT7L1HdJYYV91FuataSIAIxKh4T8
         8pEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=spCkTCCW8Y4jRooe0+VSvIZVg7J/84CQRb0uVRIFGmk=;
        b=6kMZPF1Qlo67FAeMgZ+gvVMP4gg+9PIOalbVda716SFuepJU43xeJ99nOr4SQtrYLY
         dDdfUJ8wiMbkosQVBKbexi3Z7D0FHD46mQqMEH/whD86UHajmnGdoKc1sLr3b+rjIx3F
         RaRUkiv5CkTT574WQiHMjExInu7qhhB1GLyjjoZ2viFbSUjxpZ2LfBzkIiP8sxWbDj6t
         h64A70lH26ERkWCxSZ2zhSMKOhpL6tlnoy3SdSnitGsu9wnflgYz0GCriaeS1sWs7YJd
         GN1PYGlFOYAcUlBDfU90DRRrO1Vfr8SGNwjy6CiGQ+1NQtYGpQyuR3Meiy5K07TZDHvw
         w3Fw==
X-Gm-Message-State: AO0yUKWRnithifqn9caexNEOK+VkousCx8mbGB7RH/v3j3Hq3xAYDU4P
	icVVUAztfLYpOliS/g0jUjphwiQH0s3riyxD3DhUXw==
X-Google-Smtp-Source: AK7set8Lw+AchS5SbRhKwPp9ETst50PIkUI7EMWGAtvNpSaNy4RIULjQqxUvRI0gNcvlhr6348nY+w==
X-Received: by 2002:a17:903:2055:b0:196:3feb:1f1e with SMTP id q21-20020a170903205500b001963feb1f1emr9431926pla.47.1675169687667;
        Tue, 31 Jan 2023 04:54:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902ea1200b00188fc6766d6sm9721636plg.219.2023.01.31.04.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 04:54:47 -0800 (PST)
Message-ID: <63d90f97.170a0220.1d8bd.0a7d@mx.google.com>
Date: Tue, 31 Jan 2023 04:54:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip72
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-cip baseline-nfs: 18 runs,
 1 regressions (v4.4.302-cip72)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 12:54:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10527

cip/linux-4.4.y-cip baseline-nfs: 18 runs, 1 regressions (v4.4.302-cip72)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-x360-14-G1-sona | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0af99ca381ce97af181eab7f6fc808b1e039ac3d =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-x360-14-G1-sona | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d9083c5b268347da915edd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-n=
fs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-n=
fs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230127.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63d9083c5b268347d=
a915ede
        failing since 63 days (last pass: v4.4.302-cip70-236-g69445bc0d420,=
 first fail: v4.4.302-cip71) =

 =20


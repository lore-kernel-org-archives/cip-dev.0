Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6EDC6FA90
	for <webhook@archiver.kernel.org>; Tue, 27 Sep 2022 10:32:43 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.9398.1664274761816886668
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 27 Sep 2022 03:32:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=CwDe7uc2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id w20so8662658ply.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 27 Sep 2022 03:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=ejFdhXXNtVwY+PLiFtA6eMvFFaZogKysBIwlFhk3XtY=;
        b=CwDe7uc2W9lN4szZKLHNtjq0CBF2Ucy99gvD5+1OXDXk9Jpiz6f7OPhLSjFgoS7BT6
         bsh98XFES+C60auGql5+sR/YTvhmunsCGnZo1p9PHZZTwEdEQKUsdPUpeKsedLFPyntI
         hKnBSK7vqsNqfBtfd+oNIRNEwTh0rvKz9cn0f9TUgjbQM0WMnwUl3CnwxmIApfZP/G86
         vtGOAzQOVmbD4vEWcRvZgYcL3+BVIdSFLkbTqpMMGAfVg9ijgMouvNCE6E9G6CJLFhWu
         LzQVbPP7phw2YSgx7dDq+yxW44yFnRoPPrdqRsz5pMvizREaLIEz3joIs+pgX9/K/OYm
         95Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=ejFdhXXNtVwY+PLiFtA6eMvFFaZogKysBIwlFhk3XtY=;
        b=uWQX1qydbefqCJ6r8fxKBcz0Poww0jMD6Ceg55jsBqWpW7LoQtWxfyexnQZlQGuZdO
         iOL1I8csbzzbbajpiD9Ses3LJHq2ASPm7l80lrNDgbsId8KEoFuGyonCbGjvUktMvxGf
         AM1uxAeYiMJzg+Mf7wwu7SiybSbSKL680b65cCWnLFWKJ+QrQxnuqopj6vRyjOKEeEkR
         oFK3af/cQr4IJ5nJX6wLr/aGYNqr5KUodivcn7uJkLa0u9l9FbMJO58t/ZsKwb4kAoKj
         dK1BaFYNMLADPDgds7ArM2LU5OCtL+SsUPfP5XYXfci5oXrsPSi8w+dM+wi2cbVkae0L
         15zA==
X-Gm-Message-State: ACrzQf1ABAuRWQbSu89vkKmlJ4yr2rOSglgmQc7q8qjGAuYdfBeTav2W
	DkAZ5+LIW+/NNQ91JVtXomkc7Xg3fgTRsvVL
X-Google-Smtp-Source: 
 AMsMyM4bJCWc4HrHLuGQTZljrQqLuDPLX5oyuJmhy4niYp3BPvbsnhwdJh0Y9SvTbraNhzpROtdghg==
X-Received: by 2002:a17:90b:4c0a:b0:203:6c1e:e730 with SMTP id
 na10-20020a17090b4c0a00b002036c1ee730mr3833101pjb.146.1664274761040;
        Tue, 27 Sep 2022 03:32:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 p7-20020a170902e74700b001789ee5c821sm1186878plf.61.2022.09.27.03.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 03:32:40 -0700 (PDT)
Message-ID: <6332d148.170a0220.20886.1cfe@mx.google.com>
Date: Tue, 27 Sep 2022 03:32:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.259-cip82
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip ltp-pty: 5 runs, 1 regressions (v4.19.259-cip82)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Sep 2022 10:32:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9559

cip/linux-4.19.y-cip ltp-pty: 5 runs, 1 regressions (v4.19.259-cip82)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.259-cip82/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.259-cip82
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      91f283faebd1a92efc2cfe0a3de7c568c87e5ee5

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  48cfd7a9977e6268b4aa2600608cebad7e0e42b8 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6332c4fa177b6e8408ec4ea6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.259=
-cip82/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-pty-rk3399=
-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.259=
-cip82/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-pty-rk3399=
-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6332c4fa177b6e8408ec4e=
a7
        new failure (last pass: v4.19.256-cip80) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3476C46CA3
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 21:13:10 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.104226.1701983586898360670
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 13:13:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=yWP0/iSh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ce28faa92dso10676375ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 13:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701983586; x=1702588386; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7+wiKjM24VCfMJp0zZ/XvUF8mmbz5pJlTxixlcTV84w=;
        b=yWP0/iShrFM6wbjll3mLqE++3hMZqpOckbp9BfnFTJX787tJLOw+iTfYNPeD1j4gZU
         joblHPcFn4+L9g1cmFp5pZ6Ti2czYImYm9ZcvGBmVKCGF4IYVRBI0njbKHB2MG+Tkwa4
         K/cW1FiKYdwIm6udDaKIbbwSCaICr6b4ONViIfp7kHyBjtEQHYl5DCuz2fQUP0D830xr
         yziijf6wMZRZkKOs69ScGlV4m5QnfrZW/ySdjz5zxHbCwxXQ4et0mQsFLoDLUxzS3Gs/
         oHIkw/Dve76h+HBbhDe9PQ7mHVjdVKq+02JyMATciu+5yVRr3WGLhGoFeyejeLW3x9dQ
         3AVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701983586; x=1702588386;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7+wiKjM24VCfMJp0zZ/XvUF8mmbz5pJlTxixlcTV84w=;
        b=wIPnN8d224ayem/hWloBwZIhBaW5Rw6QfFlfufz/Kr+gvi6XEjYdq1FgEXqnJ2PDww
         3ELeFRlQ0SRGq5S4hXK8PrexZ3cciReBuqxh9OwhX3h7f/vE8mM9W7zm/K26RHfH4nAL
         pdYZF05Q+pIHXf/Ui1iLXNplk3CzaV9O3EeEXxRBXGai48c28hLyCMqXSzdBP/JcenlC
         NX2XRpr4I8WBSRGpjGUNtJUYm7RVEU0L/WgTBB37Ft74UIYCp5XTIw4KYh75dzN8Urfy
         ygprYK9xCOaESTA2yO8eIU/UF1d/0HIbqJOU4J/Z+685hiPrMK5B7ABDSOHsz4Bthp1r
         0bCQ==
X-Gm-Message-State: AOJu0YxqhjKDLgVX4YtjSbQyLBGBH1QmIYUDS92W8zQ5b1RY55qIoWH1
	iNRQ99boUf8jv3dkQCiBbvdJpObrUA881HXzKJWugg==
X-Google-Smtp-Source: AGHT+IGTSB6KafUA2rda2R0T/GyY6YElT7NFA68qAT6/qNNthXHO5Y8s7ina0DjyY7R3QFGVqVMv2Q==
X-Received: by 2002:a17:902:b686:b0:1d0:60c6:1db8 with SMTP id c6-20020a170902b68600b001d060c61db8mr2302485pls.32.1701983585862;
        Thu, 07 Dec 2023 13:13:05 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b18-20020a170903229200b001d07d88a71esm261975plh.73.2023.12.07.13.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:13:04 -0800 (PST)
Message-ID: <65723560.170a0220.2da6b.1ba4@mx.google.com>
Date: Thu, 07 Dec 2023 13:13:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-28-ga386bc478aa6b
Subject: cip/linux-5.10.y-cip ltp-fcntl-locktests: 9 runs,
 1 regressions (v5.10.201-cip41-28-ga386bc478aa6b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 21:13:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13914

cip/linux-5.10.y-cip ltp-fcntl-locktests: 9 runs, 1 regressions (v5.10.201-=
cip41-28-ga386bc478aa6b)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-28-ga386bc478aa6b/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-28-ga386bc478aa6b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a386bc478aa6b422e6dd5d92a540987ddfca9397

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657227388f8cae7943e13568

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests=
-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-28-ga386bc478aa6b/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests=
-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/657227388f=
8cae7943e13569
        failing since 175 days (last pass: v5.10.182-cip35-1-g7cde3fba93966=
, first fail: v5.10.182-cip35-8-gdba81ae6f2be) =

 =20


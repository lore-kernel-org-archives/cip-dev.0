Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9B3C169C2
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 10:52:52 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web10.5793.1702291965129840988
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 11 Dec 2023 02:52:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=YRVtQw3V;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28659b38bc7so4232985a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 11 Dec 2023 02:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702291964; x=1702896764; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nyx9dDiMkm3IDCuQUrDhAjIK6OlMKLoByJIiJ98VMN8=;
        b=YRVtQw3VA8QAXEyh8RoK9x6q9Gmi+5hKfjN52OFr50SyCO3cnIaOAQVxV6L3h/Nbmz
         tUpam6haomFqID/Gg+XTUG2wyj+2BQbI2rJNIzgPtjgDvwltwI4+gZnEj+ijhVrMvK6K
         21NchKgje0hN1P5cOANUT0hy3+UH6os6Ak9z1BP7vMKOjm3CbxKiE2azKVYHLIMnN3KM
         fq/XGcE9mZir73GN+uzwoxJk/VPyWFBjE2a5VR3Cg1Yp76ik7jxVTVCbaKj9qy4lIdhB
         hwV8hPMYk5toZT483z8R+hq7F5lFu+uDDnodGTfZk0Wjo7Fh6sDNyeVHWcrYxLpeVB0l
         /9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291964; x=1702896764;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nyx9dDiMkm3IDCuQUrDhAjIK6OlMKLoByJIiJ98VMN8=;
        b=oMMQtGYAs4wDdjMnQzCtHZ/bHoY7GrIaALLpz+fBzR/CrHN7rqE+/f8+x1nJB2ofcg
         C8yJlQ59rIwipfhDjCYS/RFd3Ud+Q1YWGxK29WpEkmXS8xs8MgzOeeFKERDngZGZ03xw
         tIQhF0jIcwu6DHMjlOUMrCoukhjZzrQB7v/AuUTMkq73u2OQPX5Dc7PpXu8TqUyZwxlf
         DBXCE0zaooionEqZaxYG9F4yeAtHXK1nxjK0ChjcYOkSbe8tVrDp2DImnWFw6XpGjJg5
         pYC7tS6IeaqgHi8bAyAhz01ZtgHFnX1GnGgM2MddXrabYD283/9Z/U7zRO7wPODxYSz/
         O07A==
X-Gm-Message-State: AOJu0YwZVxmAmb7FrC9x57If6JooZd6pbMJ4TDXODXiy+mieyAIhrF6Q
	oXCGmqht2UFL9qsvW0ozNpS5IXHWhnMscW/nccZENA==
X-Google-Smtp-Source: AGHT+IER4XjtinzMweR/6tZTTkGizvFrURl+TiFugl7AzgQohS8pAdHRo2xsRLhE78fnc08m7KNSMQ==
X-Received: by 2002:a17:90a:e50e:b0:286:ca3e:be8c with SMTP id t14-20020a17090ae50e00b00286ca3ebe8cmr3084716pjy.90.1702291964042;
        Mon, 11 Dec 2023 02:52:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 10-20020a17090a19ca00b00285dfa07befsm7230164pjj.34.2023.12.11.02.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:52:43 -0800 (PST)
Message-ID: <6576e9fb.170a0220.3cd16.326d@mx.google.com>
Date: Mon, 11 Dec 2023 02:52:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-63-gfdfe1fbf93bc6
Subject: cip/linux-5.10.y-cip kselftest-lib: 3 runs,
 1 regressions (v5.10.201-cip41-63-gfdfe1fbf93bc6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 10:52:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14009

cip/linux-5.10.y-cip kselftest-lib: 3 runs, 1 regressions (v5.10.201-cip41-=
63-gfdfe1fbf93bc6)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-63-gfdfe1fbf93bc6/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-63-gfdfe1fbf93bc6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      fdfe1fbf93bc6fe6ed2708f11c2613bef556fdeb =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6576deab78eaf64994e13489

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6576deab78eaf649=
94e1348a
        failing since 67 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20


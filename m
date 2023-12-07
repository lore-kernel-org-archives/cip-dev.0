Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184FAC4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 21:44:31 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web10.104994.1701985461597494182
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 13:44:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=HDJ+VfDl;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d0b2752dc6so12710195ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 13:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701985460; x=1702590260; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0gLCQ/6uap10SOd4emSXNOJhhCGXT0bSz19BwVIUsoY=;
        b=HDJ+VfDlvjYOR88KZh/qX/Q1Kc54ZBEunb3qBkQLfH+nQaBpeiHuGiKWYZ/dC1NUYH
         VBtQ7KgLfhRMBTfK6VLYm0DIEsKyDAaj97y7XUqEA7rCkSdSHAxWkrT+nOxRdFyspKT7
         V2ZgaX3aCggM4zCx+3xGNFwqlUa6u9gBNzT+Rxchd3+i3zutU8CwrsZ5BlIctJ0LkMqg
         8by2oBLPeEyYE39JUC7E+fl2sQ1PbZr84wflkgEop9x6H59lX4497oWOSGkQvVyIppG9
         HCR/nFH41BG3kOZ2NbAKbbfGobnhJ25SmfnUF034OStF6/U8o/yvN5qeAx0uBUxmJaIh
         tImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701985460; x=1702590260;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gLCQ/6uap10SOd4emSXNOJhhCGXT0bSz19BwVIUsoY=;
        b=I/bxVFDB9Wjd40r6knYvl0wIJJRzPo6lzrJcWXaKhwJXcDJL+ShgzFuJMDthvlBh9u
         0v0Ojee0p5Yw+H3Jv1Qq+heoT8k50XYuk+GhiRe5KYXw7G7QkBySC8bfSt7WAfnjClzg
         xWcHZ/1B11HR4QIoz1wzKs2aqmXppOhYAiZSQSmbWdRgpVgSnfAvFkJfDKNO+SCwK+aE
         90R9dfdWxroB+TYDAtYdX6yvSIAaIhJo2LvF2F9cK72x3xpe9qiBxiZoswiCT1Jx8SKL
         wrGq3UGN4FbPkejqKm7miDyCsaLCGr7yPIs4MFm/KBxZZjIq087wVJTAWtn+1zi/Vf2G
         M7WQ==
X-Gm-Message-State: AOJu0YxgzgSLjBwPmaseNPDEDP60XL+54uO2R+jMJeEWV/RYJPRORcki
	AYoBRs+3U9lFKoqZvRh0wMB4bVhs9imrgt3rxEhgiw==
X-Google-Smtp-Source: AGHT+IEXuGHEn8a3vhNvjCxCl1uaseSKTvK8q1ExkfNrFsGzIO1Y0g7Do38tArDfyIusCV4Ruicasw==
X-Received: by 2002:a17:903:230a:b0:1d0:b790:2fc0 with SMTP id d10-20020a170903230a00b001d0b7902fc0mr3744401plh.67.1701985460582;
        Thu, 07 Dec 2023 13:44:20 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i18-20020a170902eb5200b001cfc42ccfcasm279164pli.152.2023.12.07.13.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:44:18 -0800 (PST)
Message-ID: <65723cb2.170a0220.ed827.1a42@mx.google.com>
Date: Thu, 07 Dec 2023 13:44:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.299-cip105
Subject: cip/linux-4.19.y-cip ltp-timers: 11 runs,
 4 regressions (v4.19.299-cip105)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 21:44:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13926

cip/linux-4.19.y-cip ltp-timers: 11 runs, 4 regressions (v4.19.299-cip105)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 2          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.299-cip105/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.299-cip105
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d152f9dce44a3068c74de8c2046a16b8dd3c1544

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 2          =


  Details:     https://kernelci.org/test/plan/id/657232b4133739b380e13483

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-timers-r8a774a1=
-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-timers-r8a774a1=
-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/657232b4133=
739b380e13488
        new failure (last pass: v4.19.295-cip103) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/657232b4133=
739b380e13488
        new failure (last pass: v4.19.295-cip103) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 2          =


  Details:     https://kernelci.org/test/plan/id/65723445126622f3f1e134c4

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.299=
-cip105/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65723445126=
622f3f1e134c8
        new failure (last pass: v4.19.295-cip103) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65723445126=
622f3f1e134c8
        new failure (last pass: v4.19.295-cip103) =

 =20


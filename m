Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9905C77B6E
	for <webhook@archiver.kernel.org>; Fri, 14 Apr 2023 11:13:40 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web10.6547.1681470814123186434
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 14 Apr 2023 04:13:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=jY2WuDx9;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id cm18-20020a17090afa1200b0024713adf69dso5752457pjb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 14 Apr 2023 04:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681470813; x=1684062813;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5DKgN6JGn3lwtQNqFExepeRD4t7vY8R/VCKSotsOVbQ=;
        b=jY2WuDx9YySlbfK5U7MjS8mMMWcGkUVHloyI+Ph5dQmCE/D9njKtrvnQYRJVnD3Cp4
         deX7/gYzYM+Z6DKZWNzyAdQt/lJQ0SncrCzbhWh+7d6TQdkXNR96+hQ043JvLhUDEHUq
         hG7iHwlAc+oeCKbkvKwKdedWeOF4I9l5w0g/NAYSBlc8+FKif1ITxrVe25JQyRltu9PR
         HwTskV4JRwInovOGt0rJUeHh00inE0Mzdr+zhCBR2t5CF5xbgCB1gm9xuZ9bF4RvbzCq
         jgF+fbinOzW1eD+IsOz2bSIH6Ym1Y+hKyIvqt9h6ue32yuVPhGjCyyaAfo09G+QEo+oY
         mc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681470813; x=1684062813;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5DKgN6JGn3lwtQNqFExepeRD4t7vY8R/VCKSotsOVbQ=;
        b=JrJH+YNE4SDqACrHnCLFzw4EU1tPhO1dEO7ZoFZEpqv8rVBUwjIF/E+KDsZhDD16te
         M77f4N0poqd6kOegaVGIHEf3y6Qd+Em9tFPFZ28gm3Uwn/abCpnySncZJEchI5wWVvYj
         9JvXg6dPWiHjGH2j1yQOaPluXfloZz3yVulAuQcNO0aPO7wFESWim6wtiVh/LCdq8FK0
         rvK8a52VtOep9z6oPjmG+cbLUBuVRG056FC42h14bLvnO0zU+7KTvlahKIqLTwo6N1nY
         4+weAdQfSp6wE+3CoDH9R8mkmTjIvi9rd7m69TyMeK4FL0R1iAGG4x0iZhGQw4wYEfpc
         w+gA==
X-Gm-Message-State: AAQBX9f9vgnL6CbMZPbdN/hvCnxZPIOdpxr1X+VRysCcTSbfi0vGnU8g
	SBYVg+53iNSJm8VvoFnxc7goeXPyNet3ixFR483uG4jm
X-Google-Smtp-Source: AKy350ZTHfE8wpdpLhpBYFpUk+mBobABs3Yqz3f2sgQIDuB5BDvFqQUWrk0sd7sI1mHd/ERSVahN3Q==
X-Received: by 2002:a05:6a20:8b0a:b0:e8:d62c:4aa9 with SMTP id l10-20020a056a208b0a00b000e8d62c4aa9mr5263339pzh.24.1681470813242;
        Fri, 14 Apr 2023 04:13:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d9-20020aa78149000000b005a9ea5d43ddsm2904745pfn.174.2023.04.14.04.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:13:32 -0700 (PDT)
Message-ID: <6439355c.a70a0220.e2aea.63a7@mx.google.com>
Date: Fri, 14 Apr 2023 04:13:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.280-cip96
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip ltp-mm: 6 runs, 2 regressions (v4.19.280-cip96)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Apr 2023 11:13:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11210

cip/linux-4.19.y-cip ltp-mm: 6 runs, 2 regressions (v4.19.280-cip96)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.280-cip96/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.280-cip96
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0f5788ca10e5121ce62a8a58a84c723b7d99607f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  cb9b37a6a47ea5f9e442b4473c6eb06877bd18ac =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/64392beee31152c8b72e85e8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230407.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/64392beee31152c8b72e85e9
        failing since 454 days (last pass: v4.19.222-cip64, first fail: v4.=
19.225-cip65) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64392f8883936f9a8c2e85f3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230407.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/64392f8883936f9a8c2e85f4
        failing since 454 days (last pass: v4.19.222-cip64, first fail: v4.=
19.225-cip65) =

 =20


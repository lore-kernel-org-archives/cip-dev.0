Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9849C25B0C
	for <webhook@archiver.kernel.org>; Fri,  5 Aug 2022 03:24:16 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web08.2973.1659669849234748529
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 04 Aug 2022 20:24:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=s13be2Ok;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id p18so1527127plr.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 04 Aug 2022 20:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=cClIcptooy4G+NCftHSVObGU1BuUJO5PfRP5fP9viws=;
        b=s13be2OkNE+guvR2DBZnGoSw6mTeO2hWYYiC5y10ekhDZZ6gELe3js8wCLot2566Ab
         VZiQU0EhlfYCjmb5ZpbhBkCSh8AFgyWNxIUQjoNZ8ekt8d2zbBINXYfMi8lfAZaWstjq
         kw4HsYhryIwCsUTGPBo8kyBC9GpoXsCSgWEPzzj5PjBAnzPyDiP69gbvVTt0I+zX9PEY
         EogZBG1hBQe6YcwBU7OqUECXQDZQmlH6T4Xg9klKJIQTQXLXLoXwLzjkJVALByM/sSx4
         79j/Q/U72nQOOJgkqFM+y0roYc8pe2JDvkS7U+HMufFH6ISaRgySID+bM8c+U09wJgTB
         AkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=cClIcptooy4G+NCftHSVObGU1BuUJO5PfRP5fP9viws=;
        b=OMVmcYzSkoGN9EO5nqb1AAlijBesjmxb79wXgv4itAaalQT7J50xdoDEqr6amBggYX
         Y+/iJV+KLxJY118Eq1/6XwDZ3UvAVYTJxShxKVivdSrysYe01eI/rA1BwOjeXVxp89ME
         AgsVIHbeuV9fA0qXr2g6puhyLd6qERM8MY+Jprop9SLzE5wM0b+ZELFKh1NW7QNOzXD4
         7nseUFQrTiil2UCsd/MmDTy/bx9glDkjYxietPD9AH8Fag0kHk0hYr0DCDsCCOme90tC
         5N018+wOOVVuIWLB4LODZewdXlpe49s78YvwkB8Eg6PvnVvlsKv4ZGqnSJ6vu0ySYc83
         YGnQ==
X-Gm-Message-State: ACgBeo0NPqIeV3B84PPNoeNuf0gpw5CxDA43ORGe0aV52tPXd8Eo7PVH
	ZcY9U/gnTxjJ6tpJyUxWG9SyL7+26Wd5u+9iAkw=
X-Google-Smtp-Source: 
 AA6agR49fKk24e6ecnRdafiBdThC/L3rAY217/nDCtn9bLSDB/OpxqCXAfVMqPHA5mSkU6etn6uG7w==
X-Received: by 2002:a17:903:124f:b0:16b:8167:e34e with SMTP id
 u15-20020a170903124f00b0016b8167e34emr4776141plh.52.1659669848541;
        Thu, 04 Aug 2022 20:24:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 h185-20020a6253c2000000b0052cdb06c125sm1712759pfb.159.2022.08.04.20.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 20:24:08 -0700 (PDT)
Message-ID: <62ec8d58.620a0220.523a4.2eb4@mx.google.com>
Date: Thu, 04 Aug 2022 20:24:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-37-ge3a52725ce96
Subject: cip/linux-5.10.y-cip ltp-ipc: 11 runs,
 1 regressions (v5.10.131-cip13-37-ge3a52725ce96)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Aug 2022 03:24:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9131

cip/linux-5.10.y-cip ltp-ipc: 11 runs, 1 regressions (v5.10.131-cip13-37-ge=
3a52725ce96)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.131-cip13-37-ge3a52725ce96/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-37-ge3a52725ce96
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e3a52725ce96e4794cc31e31ccd20914f40f19a3

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  bda92ad659a52d38ac810099f69adff626b064c6 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/62ec7d2b58916d8706daf05b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-37-ge3a52725ce96/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-37-ge3a52725ce96/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62ec7d2b58916d8706daf0=
5c
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =20


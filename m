Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477ECC4332F
	for <webhook@archiver.kernel.org>; Sat, 10 Dec 2022 02:13:29 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.6050.1670638408855550030
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Dec 2022 18:13:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=kOPPbBok;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id t18so4923913pfq.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Dec 2022 18:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mglA2kpxlz4TSMilbdM+eNBdpJjp/CAcmuPvEkCehas=;
        b=kOPPbBok1K7acwWNkFZ4lJMQ3VPxLdtIiO4Fv2Pbasr3R7FeDU9zdwtv6h0DOyvfkC
         R1QGtFObPo5Xe96McmoWtZinRcOxuPzMux1RClU2jWhdqqxx3VmDdXo6wqSdw4/QfAte
         IL2nhCqvKnB6tM41gSIUel7/dS8afsOuy+JdP0yDtmktIvT3eJ5IbYfXI/AzI2vvmOlj
         FV9x8Q5YwjHMk9N6wFL/2W/w826eHjhG0sjsn10iPl7ZEs625yKOdL36pt3J6CxTboYA
         f8uOwdvSvzVrZAPSKp4tnjcGMIXj5MC46I/7UMbiYXkSq/quQr7yn4Qx5x8+MAFIP1J4
         eYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mglA2kpxlz4TSMilbdM+eNBdpJjp/CAcmuPvEkCehas=;
        b=dLOYoVtImWhBTAEi6u2ojGpmMAkZ+iDN04deuH2C1bm4Vboon3Fo18XgxQW2eiGWme
         z3Ag+pgv2xgcjQtrLFhpM34F+vFCfntP+fQztTPCwEOzdlTouWebU65bp5CMuhNKE9NR
         9iQAx0iSpFDA+ershx854WHRRtCZtMdvPq6nviZDfhnbWb9iTtFV1NdYqQP9ioTQIwEc
         hTFqOjG6BRLDb69N2MYrGu4euEY79m2rinyOpVnFR1eGU8FzHIhiI5i6dr/8TUgcHg3T
         Tpz+sJbyrcFylIrN0zmuvcVy3kroBdC2Y9PzbypUSnNpmarmAWOOxj6GL8dU+uAmEftH
         SLeA==
X-Gm-Message-State: ANoB5pmyCM2Ju4DjFH7Sdm0gtATs3T3gnRiVjIGTfToTljjJc4xO8mUD
	Un7xnon3o/vfKvwdZZ1o/3K2biR5tQiGdEZaq4A=
X-Google-Smtp-Source: AA0mqf7SJlLBLYWOEk+VERToL/6m/Fdv0vx4nYByfaQSNSOYYo5NVKvjFodlVflQRqsYescXV+4iuw==
X-Received: by 2002:a05:6a00:d6b:b0:578:1e81:6776 with SMTP id n43-20020a056a000d6b00b005781e816776mr1142364pfv.22.1670638407946;
        Fri, 09 Dec 2022 18:13:27 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f14-20020aa79d8e000000b0056ee49d6e95sm1809800pfq.86.2022.12.09.18.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 18:13:27 -0800 (PST)
Message-ID: <6393eb47.a70a0220.765f0.3f45@mx.google.com>
Date: Fri, 09 Dec 2022 18:13:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.268-cip87
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip ltp-mm: 4 runs, 1 regressions (v4.19.268-cip87)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 10 Dec 2022 02:13:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10184

cip/linux-4.19.y-cip ltp-mm: 4 runs, 1 regressions (v4.19.268-cip87)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.268-cip87/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.268-cip87
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      268e570d0a5691ceb479fa0368a6c73c5b080f89

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  e76de05a93390f5ec7fae2941d8f24d367c9b2b8 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6393e215e4891317582abe55

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.268=
-cip87/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.268=
-cip87/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221202.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6393e215e4891317582abe56
        failing since 328 days (last pass: v4.19.222-cip64, first fail: v4.=
19.225-cip65) =

 =20


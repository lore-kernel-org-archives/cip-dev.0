Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D75C04FDE
	for <webhook@archiver.kernel.org>; Sat, 10 Dec 2022 02:19:39 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web11.6176.1670638771515331992
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Dec 2022 18:19:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=lAWcz0+x;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id t18so4929873pfq.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Dec 2022 18:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fBloCcKS7Fc5ItoL6cX7H8Pn6oWM+GLx1HVQEnW6vKQ=;
        b=lAWcz0+xURQaWXfZM8HMRfciiEgfJMMswjxV1XsL5K45EcMb2u/6yhJ+bgcmPW8Rq2
         DMl2v0vWYUaDXWM+8Vam/lSza2hRZ3YorBWh6+8DUs49wypYkyGPPmjqAG0IdqJ7WJds
         rp9//Y5e7g7hiDe8CQyTx33ihs61gjvz4cD5DqhzIRJo/eqOR7NtfAW2XtZcBbDL+DYu
         9MT5BTahkKOXNW/Tl6GjOnCZChZawUBe2F02YPROvT0kSSFm6Axfni6Ljq9+iN34v5qD
         PqIJePVCjH2ftPaNCpjxZ7RbIFttuBIpmecK1mijmpCmFs7ItT+3OcRDX+6X9ixBmF+z
         uUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fBloCcKS7Fc5ItoL6cX7H8Pn6oWM+GLx1HVQEnW6vKQ=;
        b=0xYrotBCEKXvWajKwc4xhIv/2CPFJSOIZsk3LnDFLLsXoDp/tDdoFK255jZ1XPS5y7
         4qLGP1hUKcDDOYlYiEiocMOMliGmA116OnakVETpcIEJ4ywfMFKhTWYH4wG8fYZXcfNk
         YVt1tJJZ1eVNWww5KUszdCm+N4CCPqIgXHEaa5UWNBgyOH6It6jwk8ufl1qW/663i8jd
         3O0s+ad5bzqLGrHPLpQGulPF36pP+Z0mwBJmUVQZ2LM39Wc+0MylZ2mSIFgUN8vJlDWj
         1pEeBlsiPVR5jaiqD6nVGiQKe2B3rUA4mg1hvaUUrzrzA7I23BXaJU4w1+jT/6Sf1/w4
         kpAQ==
X-Gm-Message-State: ANoB5pkZXN+sh7ZJoEWiT4qgk2+RJdASScdhzMz9oxwYgss/9t29c4yu
	8T9kIljfDDiKf8xC4mjjOB9t98PvA1g/nFXUS/Q=
X-Google-Smtp-Source: AA0mqf5+bzARBXH/0zmlHZGZrIEMS2KjMi0JWQhd0ARA2uXPDEDUWN4IRrMeREYQSGJjYQirgDhOlg==
X-Received: by 2002:a05:6a00:2919:b0:56d:4ab0:c7fd with SMTP id cg25-20020a056a00291900b0056d4ab0c7fdmr7821716pfb.1.1670638770694;
        Fri, 09 Dec 2022 18:19:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f7-20020aa79d87000000b005736209dc01sm1820710pfq.47.2022.12.09.18.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 18:19:30 -0800 (PST)
Message-ID: <6393ecb2.a70a0220.520df.42ba@mx.google.com>
Date: Fri, 09 Dec 2022 18:19:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.158-cip22
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip ltp-mm: 5 runs, 1 regressions (v5.10.158-cip22)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 10 Dec 2022 02:19:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10191

cip/linux-5.10.y-cip ltp-mm: 5 runs, 1 regressions (v5.10.158-cip22)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.158-cip22/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.158-cip22
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f37e570b7c4ab8bcfacf36780a9e204878f2c181

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


  Details:     https://kernelci.org/test/plan/id/6393e9e5add8c2cdfb2abcfa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221202.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6393e9e5add8c2cdfb2abcfb
        failing since 332 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20


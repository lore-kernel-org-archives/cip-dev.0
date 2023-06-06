Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2544DC77B73
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 15:21:50 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web11.1551.1686064903294316182
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Jun 2023 08:21:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=tP8J8GUv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.182, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso5682303a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Jun 2023 08:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686064902; x=1688656902;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YBr68ALquriOqnG73pUqX9pYxDvrC3Kyru9Nh/rS7t0=;
        b=tP8J8GUvv90xKD83gp+aUMIzp69v2LSOuWL9EVCUdPeQ2+TbVNI1/tZnLuD2ObF8u6
         NLixL8d+nOaF5BrkJAVpLlbllusrRhTrXABzYj2gjrnmFF47X1DiLBFu4LSBMH8icfNs
         SBBMyO0EjctcBMoCHmiw8R7D2YMEA34xtPZDThtYA3eDMRrUp8zj+8ROfkxhIhdGrxLq
         JTod0ZtyWEAIqW9T302yQIDIxWMm9RtGjkp/7cwMVf0VWGaoE3fi3gzCjQappEA8f7eT
         lsNQOASyO5QXEYZx/Egcc1wZDaEO/i9hYM3nTFaQCLQ/p3EYOBWckjeOe6EcoI8HYxer
         rBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686064902; x=1688656902;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YBr68ALquriOqnG73pUqX9pYxDvrC3Kyru9Nh/rS7t0=;
        b=jpqeT7hf7+5kb6vX5pc0Ph5t6SxCIrxTJQZCgMqQ7tsSS/IEVY/VcQZuRnZlBYZPrZ
         72XBVxzHbYm/TR6fxEyqOldDuEStlyjRnIQLAm5Y6TxKPDAHN5Jm1mKTl6S/ETVo6yZH
         Zv68pXxSjWz4/3N3obLZ+y7nW1ITVlBuie9zWL4MCFQlt+xYCNi+19GlaMQtoyADrfEB
         BMc1LsH4OnHdj9ABOPm+vxNkDsKGaDmu5Vr8+Pd6hhKAovSQKjzYVEbQPXszsmsx9GhY
         mXG/x6CepUYCil5SOFaxjg6tw4PCDdVhl4CKQggoEqp7okjWGVFHca9fEFpB05f5G29c
         tNSQ==
X-Gm-Message-State: AC+VfDxxh4RNKvXJFjPG3qlQ2LMLe6mvudLdDugzBYCupF+/QYTXnZnN
	xvheZtRCr9itw7dKmh2SaD1I5ZdHAuGWQ/E+ldDsTQ==
X-Google-Smtp-Source: ACHHUZ4t2j1yADT2fo17IuBj7iD451P78ieihQG98GzS3eQlszLFS4ZFas0xQ/YLj4fSoY/H6ybp1w==
X-Received: by 2002:a17:902:ea09:b0:1af:adc6:3bc0 with SMTP id s9-20020a170902ea0900b001afadc63bc0mr2670969plg.5.1686064902197;
        Tue, 06 Jun 2023 08:21:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x10-20020a170902ec8a00b001ac8e0ea157sm8653641plg.144.2023.06.06.08.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 08:21:41 -0700 (PDT)
Message-ID: <647f4f05.170a0220.a04e7.09dc@mx.google.com>
Date: Tue, 06 Jun 2023 08:21:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4.302-cip72-495-ga0a97337aff8d
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip ltp-fcntl-locktests: 3 runs,
 1 regressions (v4.4.302-cip72-495-ga0a97337aff8d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 15:21:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11896

cip/linux-4.4.y-cip ltp-fcntl-locktests: 3 runs, 1 regressions (v4.4.302-ci=
p72-495-ga0a97337aff8d)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-495-ga0a97337aff8d/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-495-ga0a97337aff8d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a0a97337aff8d76931b459e84792717c3bf6d6b4

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


  Details:     https://kernelci.org/test/plan/id/647f3e67e90247b6a7f5de31

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-495-ga0a97337aff8d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-495-ga0a97337aff8d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/647f3e67e9=
0247b6a7f5de32
        failing since 126 days (last pass: v4.4.302-cip71-590-g22fc523bf881=
, first fail: v4.4.302-cip72) =

 =20


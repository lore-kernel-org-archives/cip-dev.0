Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EABC7EE32
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 04:26:30 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
 by mx.groups.io with SMTP id smtpd.web10.241.1685939181374445486
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 04 Jun 2023 21:26:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=cske2GtW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.51, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1a1fa977667so4758698fac.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 04 Jun 2023 21:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685939180; x=1688531180;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H6SZJcIKTgBLhvcBScUMWH0g2eqNVFIbYMDCiZT96jQ=;
        b=cske2GtWzqAtz+oMQYxK+8SKm5rDiJ1o9kIzHrq3IHIjcBHft0I+HlofBbfiV2K0j+
         wVSlUIcsDD7mJqGb+JY3gk9EHY3Scoi3R73muRHZ03IEf5qeqo7HJtP0RthS1f3mwDhq
         eSRby6fwnCTuAF/PxV3v47rRDdB+wRai526FO8Om/C9gfgKPm/DtEJOwZEIFyXunHRnV
         u2OtfH6eKsl9LM2HirMvC1cp2/a22/at6/BGGNsXuU7/yvfS1bsf2A1UAKVQ0l4+xcjf
         lU/IBgqtfldcMRXrcxDu9kVdMM6qhJPxfnTlmDNOgg11O6C1OWbeTFeiugpgPgGsrjDJ
         FuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685939180; x=1688531180;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6SZJcIKTgBLhvcBScUMWH0g2eqNVFIbYMDCiZT96jQ=;
        b=ag+BWMOCvRaggUuVZ2I4/TMEcXDLoAIjTKDjU2Kzn/kBoKSgy6/d2guX4TBNTR55qk
         6Ko70HL8OQigiHdWw0ivvyWFfRYCYR4DjK7v5wsHJuvaceH5ZUEHCuKApO0U09TqtiB3
         23gj1kJ6TniimPV/aI0WbY+qBf6/TCXE2bE/0e6XtNm/QLYxu+AfL06Bt6yLYWki0/E8
         fvnnfgOAhWcvVKryM2601TUZHBmkflIcZSwTAE70p8s0AVdqZzbfgHukhhaEsA5nl+wb
         Nld0FKMYYwMirtO6gbzkHGy+zn0UDqkygF4LUUf7pc3oOSYYIyL2Ly78Dnz26enB+qkE
         cIwQ==
X-Gm-Message-State: AC+VfDyPh5xRixZL05zkim2d6fqCzLOnqZQvltehZ6qhqRWcGzgVdc0G
	nrcZoF//6UbmYMlrXrQSGfiokqQSDKoTrnXQtGB9GQ==
X-Google-Smtp-Source: ACHHUZ6JN61yNFZ8yqOtPFAF8R6SvqZ0uqmU2IaAswHzAnbv93JNvc2BI2dEjDJatSu5n0sTS6VtyQ==
X-Received: by 2002:a05:6359:39a:b0:128:55b:df76 with SMTP id eg26-20020a056359039a00b00128055bdf76mr6638487rwb.8.1685939179946;
        Sun, 04 Jun 2023 21:26:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 200-20020a6301d1000000b0051ba9d772f9sm4861494pgb.59.2023.06.04.21.26.19
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 21:26:19 -0700 (PDT)
Message-ID: <647d63eb.630a0220.7a3b2.83f5@mx.google.com>
Date: Sun, 04 Jun 2023 21:26:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-19-gae79bc689058c
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 18 runs,
 1 regressions (v5.10.180-cip34-19-gae79bc689058c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 04:26:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11773

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 18 runs, 1 regressions =
(v5.10.180-cip34-19-gae79bc689058c)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.180-cip34-19-gae79bc689058c/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.180-cip34-19-gae79bc689058c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ae79bc689058cc27e73e1cde11fdc558c96a2889

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647d58f731e2e06de9f5de32

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip34-19-gae79bc689058c/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/647d58f731e2e06de9f5de=
33
        new failure (last pass: v5.10.180-cip34-213-g6582dd41d2c22) =

 =20


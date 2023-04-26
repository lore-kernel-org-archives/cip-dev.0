Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3C5C77B60
	for <webhook@archiver.kernel.org>; Wed, 26 Apr 2023 14:24:09 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web10.9341.1682519047772876128
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 26 Apr 2023 07:24:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=5JBBabgD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-63b64a32fd2so9196730b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 26 Apr 2023 07:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682519046; x=1685111046;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QCrDawKqJ1kdZSGVAhxZgi14foasv27MXs0Rd3/gmDo=;
        b=5JBBabgD+TIpKzBG/qhfPtBchGk1nOC6CMWR5kxNPcbB0Or82zMdSSP3gNaueG51dJ
         10Jjm9l/vsHn/PzOHdHKaH1pis1VVQWsukjuzsdrlHe6jXcvsdDD2GGIILcoK6gLF0P/
         X3gCX4OYdSqfj0/M2Ri8dOY6Dbie2ZeRcghd/HaQ4laEq514kNNps2Dlq11e8jwmEhfy
         OFFdnNT7gKZ6CPr8PfbyzOBlx5qUxQNsyQ5KSjZjXkUDhQtuqlU+CJjo49SJubXgoeNL
         xGbUugDHm1FGFdjWyLczSrFVPEVU1r1DErmEQltAUwoGJqfLbrSQMogSuw1uc8nI9hwW
         XE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682519046; x=1685111046;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCrDawKqJ1kdZSGVAhxZgi14foasv27MXs0Rd3/gmDo=;
        b=AxiWm8r6r2ePMFRC9KvsugTBnBf1fHAleAiXbqG8SpTsN6BV9tVCg/KR+34fPg82yd
         6XwbtcpWdmWVvC7GLLn/bjSeYmf960TEe9EtwLU/8/eJyuZnDz8IT6h+8wNB1WqwoyYp
         kN0AV7gaKvmZVcWv5l8hfrV/v2NW7H9TqVwldF2srur9F6WaGiMxKdkc/Nuiur+nJKVa
         GxtcGhpP9lC2a3yo+RnBO2byjez+QTFj1V9p2/6vkoV6E5UBfckHRNe0Le99ATuQeStR
         yzhVRy0J0yTU+7YyUw6b6lny/qNKGvsoMHk5a7r9tbiACEarpR2r0bE6ARd/bEmxyNX8
         gPlA==
X-Gm-Message-State: AAQBX9dSiwCAcbXrK3Evkf4qlfTa1cNPZ4DncBb6r36ESM2UonKUJD3Y
	oQvvip83Wk6j8XwLaJrAKfeakLnlg1nj0iTFQycP/A==
X-Google-Smtp-Source: AKy350YFv3S2eiEA4GMFwSNmz+wFtczBQ57ZLsON/oR9DiDB+I0EX4gRKNOWiLAvVwq3nhh3LJSJzA==
X-Received: by 2002:a05:6a20:9191:b0:f6:d4d:49 with SMTP id v17-20020a056a20919100b000f60d4d0049mr8930012pzd.27.1682519046496;
        Wed, 26 Apr 2023 07:24:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s12-20020a056a00178c00b0062e12f945adsm11354610pfg.135.2023.04.26.07.24.05
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 07:24:05 -0700 (PDT)
Message-ID: <64493405.050a0220.46c64.6aed@mx.google.com>
Date: Wed, 26 Apr 2023 07:24:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.280-cip96-89-g355dfa824cb4
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc kselftest-futex: 8 runs,
 1 regressions (v4.19.280-cip96-89-g355dfa824cb4)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Apr 2023 14:24:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11357

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc kselftest-futex: 8 runs, 1 regre=
ssions (v4.19.280-cip96-89-g355dfa824cb4)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.280-cip96-89-g355dfa824cb4/plan/kselftest=
-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.280-cip96-89-g355dfa824cb4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      355dfa824cb4c11c1525b77bd5e76e4c0733b7c9 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6449268dacdfc57c932e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-ci=
p/kselftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-ci=
p/kselftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230414.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6449268dacdfc5=
7c932e85e7
        new failure (last pass: v4.19.280-cip96-59-g4b02e7efb967d) =

 =20


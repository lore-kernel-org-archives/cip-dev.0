Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA122C6FD1D
	for <webhook@archiver.kernel.org>; Tue,  4 Apr 2023 16:56:42 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web10.107401.1680627394166336101
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 04 Apr 2023 09:56:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=3g4Eq5tj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id dw14so21889353pfb.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 04 Apr 2023 09:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680627393;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E3yU9q3ZS5lXIC58bAJshA0tHDESfxgiYPubd8tqAM0=;
        b=3g4Eq5tj1dSun9cNNFF2KtFqArP2XlQLVZRtBGbRnF9DRmIuy4zj1ZwIzPc6V6lJec
         ZMskojGr45qXv+CZLFb7v3EEfxa3n5zSOEbtPynGO1yb3fHylDD6J9aNvXZ0cb78fkEs
         F0O2XRZA1T1psH+P9+V9sxixtk3l5Yz5VE47+V4BqBleywLQnJpjvkpQ/sAeIAkhZjXt
         wMSfoEZfGdYMkafSYO1admrXBWaOCW0cGg99v3nFxpBND802uJd4trs6ziMvgPnnTTn4
         hkH8SqLLiaJmish4HXMkLSfdEbuRjBoEMJWyz85iFHHncGHLwD7TyKuBaLIbc3MSn4Es
         kCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680627393;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E3yU9q3ZS5lXIC58bAJshA0tHDESfxgiYPubd8tqAM0=;
        b=bPNpZBJ+34EV8xjumES3zQw49QstyxHwELLgvXbxRU57zbckz9WHzJYYC3h9k7Prg5
         qiV8k4baPe6rKnqUJNH5etJ3wCt63/AtgilKjO26266qh/CAySbxj4iyHvg70xTRvxIN
         WQ+qFaTjSMQpp266RI474yLYDJnxQpgtf6fmXsYg4LlFMxt0+dAZrZn3WYk9ig4/wv+L
         74n1VZglhyx4d5y9ufrDzDcwd/LllMAm9dDreuSesGFPTxaNJhW7wBsWOfoH0iSuRSrF
         i05fjtroR+yGaR6o8S9A6mc2URM+wGNDORtItxQX/O/Unj4+qujzSmNeJamp0nydObqM
         TNWg==
X-Gm-Message-State: AAQBX9fum2cse2usSZ5YiDg5OQNjvItanemPZZ5HpZMQ1hu8vm1FWJyV
	6Dq3OolC7YHxAghOsT+DjaEU9o/6+27+4XXA+ZvrRA==
X-Google-Smtp-Source: AKy350a/+8Eb99o5xuGdo/zIXbjU8UYRsfW424ftjWJQyNtHd1ODwzcQF3dlQm7Z0Y5TCuIiOZpbgg==
X-Received: by 2002:a62:1b4c:0:b0:62a:87ce:14ca with SMTP id b73-20020a621b4c000000b0062a87ce14camr3294359pfb.32.1680627393326;
        Tue, 04 Apr 2023 09:56:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i19-20020aa787d3000000b005a8de0f4c64sm9039964pfo.82.2023.04.04.09.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 09:56:33 -0700 (PDT)
Message-ID: <642c56c1.a70a0220.2e138.1f1e@mx.google.com>
Date: Tue, 04 Apr 2023 09:56:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip74-rt43
Subject: cip/linux-4.4.y-cip-rt ltp-ipc: 9 runs,
 1 regressions (v4.4.302-cip74-rt43)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Apr 2023 16:56:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11174

cip/linux-4.4.y-cip-rt ltp-ipc: 9 runs, 1 regressions (v4.4.302-cip74-rt43)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...k+preempt_rt | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip-rt/ker=
nel/v4.4.302-cip74-rt43/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-4.4.y-cip-rt
  Describe: v4.4.302-cip74-rt43
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      22456e8b8d35c6bd1313511bfa4dd945ce7a0c1e

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  70199ce4f0c498bfc7d0d9e0440f54b97b373b26 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/642c438cdb3215249379e942

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-c=
ollabora/ltp-ipc-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab-c=
ollabora/ltp-ipc-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230331.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/642c438cdb3215249379e9=
43
        new failure (last pass: v4.4.302-cip72-rt42) =

 =20


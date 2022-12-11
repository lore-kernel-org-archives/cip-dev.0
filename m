Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483D4C10F1D
	for <webhook@archiver.kernel.org>; Sun, 11 Dec 2022 20:20:25 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web11.25759.1670790017891597011
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 11 Dec 2022 12:20:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=b36qu7Xj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so10082527pjo.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 11 Dec 2022 12:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/K4Ml5z/GnvqkhM0iEhUxOeJa3qd183xVpaGS6FYhn4=;
        b=b36qu7XjCYeVS6vow+5eBmHwrr2RDlrQ6ja0tPMvlwze11SR5LfaFqNqczy3HPjOyv
         2xPz99uAkMhMOZSyGfutnLASWt5vhLbrRMXwBpNf9ZNc4ipVtpcKdVoZL6hEp8t7Xc4T
         RXE2aKyC3YGY366zpP2Otcnrja8ZYee7KPUvxN7AJzItw9r0183pElzm7axNqH3SMKgn
         zoGY05+3cP1nM3IF4r2PHydrRvFQGR7jrY5a0NS33hXhyGtgDzeIKEUu1ENeMJVhOo7N
         CRZxBhzPysVJDFscE0aWpABkn1qw6RfnFeq6tpCoy/7hLRXP8zfL2KmXo/tOU/+bXnMs
         8lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/K4Ml5z/GnvqkhM0iEhUxOeJa3qd183xVpaGS6FYhn4=;
        b=D2cDZbLzn8Ne+wX5wf7B3ERae9bqlXdmTJpvPLDJWkg2uV1X3j7Y49I+aDfQYd4b71
         nBJdfoOO3ENO4js9XPoFBQKPzxVCyS3yyUmLN0rtGmBUmhF9as5q5Fom+2jjXSjH/lER
         dNk8KrA0yz35Nf0gs0bBoYiTMsMq7t+WiwYiQ+rl4NFZxTWiNY/hDvXsl3HUaI9KY435
         s6exMykwcLwkkaan6a4y3f7w9XWrzydEGiDw1y4iN6T4GvkEJYmkCXb+LJvkTMkAMNRS
         p7SfbRSrm3Wm6xNpgU3JHYrwnVu9sFGEYqmlvMFIROhuIo5t8dBvPuqo0FqrVflCWUZ1
         tVmA==
X-Gm-Message-State: ANoB5pnp4pymqYmi3ZX3VH33kmQ+GIjmXpM0q2Sj/DhXXJIWuvESiJq1
	S4tqNpoBJb52ysKwsfEPHeFO+Ithg4ZaHsW5tW4=
X-Google-Smtp-Source: AA0mqf5iFzjsOHTS4EQHNDmKBvNaQv+HBNZAIqaYQQErOerJx4I5ctwlEmLpWK9Q+qrmx2aOIEsyrw==
X-Received: by 2002:a17:90a:b38b:b0:219:8e19:6ebf with SMTP id e11-20020a17090ab38b00b002198e196ebfmr14206340pjr.0.1670790016772;
        Sun, 11 Dec 2022 12:20:16 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ce8-20020a17090aff0800b00219220edf0dsm4020998pjb.48.2022.12.11.12.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 12:20:16 -0800 (PST)
Message-ID: <63963b80.170a0220.d2a48.67ee@mx.google.com>
Date: Sun, 11 Dec 2022 12:20:16 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.158-cip22-rt9
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip-rt ltp-fcntl-locktests: 8 runs,
 1 regressions (v5.10.158-cip22-rt9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 11 Dec 2022 20:20:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10206

cip/linux-5.10.y-cip-rt ltp-fcntl-locktests: 8 runs, 1 regressions (v5.10.1=
58-cip22-rt9)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.158-cip22-rt9/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.158-cip22-rt9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2c52868ae1cbccd8bfb24f6b41a5fd024c1ca7e8

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  e76de05a93390f5ec7fae2941d8f24d367c9b2b8 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/63962af53d4b047eaa2abd03

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/arm64/defconfig/gcc-10/lab-broonie/ltp-fcntl-locktests-meson-=
gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/arm64/defconfig/gcc-10/lab-broonie/ltp-fcntl-locktests-meson-=
gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221202.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/63962af53d=
4b047eaa2abd04
        new failure (last pass: v5.10.153-cip19-rt8) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5661BE7B601
	for <webhook@archiver.kernel.org>; Wed,  4 Oct 2023 12:23:01 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.16791.1696422180155642875
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 04 Oct 2023 05:23:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=m0LwtmiW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1c752caeaa6so15328135ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 04 Oct 2023 05:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696422179; x=1697026979; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CAwkXiEZtgsBgJZdLSIIkZmQwnqw/zG+KHUxwqiWd8s=;
        b=m0LwtmiWZv847EohK9CbwGhaKygylbw0UEtN3bgfW53ZtOXGLRpfbaMV91FCAFJlF7
         jSGkg+6Gklm7W9yfm/CFLndrWq83tW+OBoShBfXwUHwdoHSzFu6siKY+i9M/nAgFdLT1
         CIpa2hQnjyLKUxMT+N+BquxQL+cLCfvuYY36e5cBrytaHvIJHk0it/BEEEGRvsNTE7Pn
         0ENgohteBx1vYQAtVFO+/UrQDxTWoQRxAYTtH8ics+64LkDwoTi27201kjDVZdGBp9jH
         2/o2VLWH4nfaLABSXt0sSs/QEELyQTA4cR9pxzQ1unL7NqVUE3nxvCzYnKnLClVSN0jB
         d/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696422179; x=1697026979;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAwkXiEZtgsBgJZdLSIIkZmQwnqw/zG+KHUxwqiWd8s=;
        b=buE415Y7j7m6MSde7g/FZNz0pfN4RcQAtyl4RqBUv3VrVRHs7nmF/R1pt+4r0H6s1A
         /gZw+bt8DVUK6Esyf299zVcg4/iNFSNFF2UnUsoVe0m3W2ah8WPIUN8CqT0M6hY1kNwO
         sa8FosdvcJ0bOCPsH1nylhmYtIO8awndXjPW3nU53GEbsNFRghAxHdkYC9maZ5iCWM50
         G1uPBgwRlwRqESC2MfBXJjX30EQJR4SDWjfxp35xmRQv/HLUNCB0PGe1S3wCi5SvWti4
         OPWVn/s0FBQPQxbP5brZLzIPEvGIk4D2fjqcsPUj0XBP0M5Df9NQSZFf7jgScLfdZyg+
         v6xA==
X-Gm-Message-State: AOJu0YwPyUGS975MCGfrkSInsFT/wFXiSsrlNH4NWqahk8Lcxhi9Aykw
	UVCn/mjnYFYcGKkBksAT5wXoBc5AfY9ZuovuLTJDCA==
X-Google-Smtp-Source: AGHT+IF1WgHJQQyjFtJTW8F2KPNcwum4yLigL1CmWEpBBYIZnLWWOBPj4gH2fmsciGGgSFQTA59p1Q==
X-Received: by 2002:a17:902:a402:b0:1c7:7e00:809e with SMTP id p2-20020a170902a40200b001c77e00809emr1977007plq.67.1696422178972;
        Wed, 04 Oct 2023 05:22:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902dac400b001b81a97860asm3544065plx.27.2023.10.04.05.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 05:22:58 -0700 (PDT)
Message-ID: <651d5922.170a0220.ab3a7.8ad9@mx.google.com>
Date: Wed, 04 Oct 2023 05:22:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.194-cip39-1-g53e59f50ca3ff
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 1 runs,
 1 regressions (v5.10.194-cip39-1-g53e59f50ca3ff)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Oct 2023 12:23:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13281

cip/linux-5.10.y-cip kselftest-lkdtm: 1 runs, 1 regressions (v5.10.194-cip3=
9-1-g53e59f50ca3ff)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.194-cip39-1-g53e59f50ca3ff/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.194-cip39-1-g53e59f50ca3ff
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      53e59f50ca3ff023b612a48397ad7e057a9fd408 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/651d5076f748c5e3068a0a8f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-=
lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-=
lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/651d5076f748c5=
e3068a0a90
        new failure (last pass: v5.10.184-cip36) =

 =20


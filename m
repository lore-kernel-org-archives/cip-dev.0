Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106F2C4828E
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 22:20:44 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web10.9152.1706826035646835902
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 01 Feb 2024 14:20:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=VocJF0fr;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-295c8b795e2so1146553a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 01 Feb 2024 14:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706826034; x=1707430834; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5Jhu8tzW4K5q+/jcvf8DLzmurtSdEN3ESEg9Cu/bWiM=;
        b=VocJF0frKepRVnQ+v05TLvFmr4K/jEwG7Yr4/pj/s5WH2wLdsIr4TgcUxa5vLVcDjo
         mk7E6xp2fRbxCbgnCxOX7XNBWNUVpMi6+GRVbNvlRlmPMCTkAmUc1wSQjfxjKtoOcIDS
         /C95BBprVsSzmgqgAZqpwMKE3Wv/YABCrk5Zmq8ZHqwtFYJ9KlmRjFYZcbuRXz3v98Xv
         mDn+rdzS0wjn3IYMGlf28Eg+ekszOzbRUhYoltv+tVmxsRw+ErlzlvkXJ3/orFta2AQE
         akPU/2+Wkj7FZBEHGYf7Cn+b537alC8WgTQHyc2ufVgfTMjVOy8KYWi0D3EEQe5Ih2/Y
         b4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706826034; x=1707430834;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Jhu8tzW4K5q+/jcvf8DLzmurtSdEN3ESEg9Cu/bWiM=;
        b=qG3/oMcCuL0pZcTBY0fe3HNNp4Jrfz+Q34oB3JpBbaFjB8JzbjYbVv0zlYSQmcFZ2e
         zEfEInrTA5ERxWFBC2Ys5UjtHESDu8go0RIwHQZq2wcI1UGs7wr0p2vA5WQcoSI4r1MW
         rTvEwat9XbTHNI9Ax6Nfj4feWYF9/ANdrZzaIIfFnbKmN50ikDiusgJoLRao9O9pN7Iv
         Ok2T4sPidXZHk+L+5TaTO2DtgezjpIPJCYQ1SFVTnEbCAGspvDMJ+9sIM4kVe8qwbLmr
         UxxgQi3UH6pnelBiIuyZrqz/wflp0r5Tp1Br2SDm6ZxMfCgJ5Su+312M88Plu561Dn7w
         Bssg==
X-Gm-Message-State: AOJu0YzNMp3QcMBSWCu7DqwS+LVvScb8nvzJH0OUYfaKbPn8oIzm8O0d
	W1fEiD4wW40GdwDrDMxB/Xi0JspWqrul/T1AP79HM6H7zTYQnVpZIYFtNM0Kr67wP+ozx/pYWP+
	P
X-Google-Smtp-Source: AGHT+IEtk2O2s69J6jRpOhmg5gETWOAHV/d6aI09jRRmDB2v5JT1EIRzSUX0uq5rstFiQuyES1dSNw==
X-Received: by 2002:a17:90a:bc89:b0:293:d87e:c0fa with SMTP id x9-20020a17090abc8900b00293d87ec0famr3831818pjr.17.1706826034618;
        Thu, 01 Feb 2024 14:20:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVKImPzZA/Xgx8w39Dna8mom0AAt4xawIP4xQQUB95STy/R/jzVXUh+6UTdnWveG1EiWjiFgeBska9UygbkNv4qDL6+CqoKKV/Fq5uB9He38LLXP/z/ymEvqBz2m/NJTqvTcmjJyRolQve7hRXeu1zu8g==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090ad60500b0028e023be116sm332954pju.49.2024.02.01.14.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 14:20:31 -0800 (PST)
Message-ID: <65bc192f.170a0220.72f9d.2695@mx.google.com>
Date: Thu, 01 Feb 2024 14:20:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.208-cip43-4-g1c63c70fb18b8
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 2 runs,
 1 regressions (v5.10.208-cip43-4-g1c63c70fb18b8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Feb 2024 22:20:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14593

cip/linux-5.10.y-cip kselftest-seccomp: 2 runs, 1 regressions (v5.10.208-ci=
p43-4-g1c63c70fb18b8)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.208-cip43-4-g1c63c70fb18b8/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.208-cip43-4-g1c63c70fb18b8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1c63c70fb18b87b5bcfe5d7ddf0096c92a1557ed =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0c73b4adc5b7fe00a045

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-=
seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-=
seccomp-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65bc0c73b4ad=
c5b7fe00a046
        failing since 120 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =20


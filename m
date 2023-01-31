Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7171AC64EC4
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 14:11:34 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.13206.1675174288776633136
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 31 Jan 2023 06:11:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=6op2ypw8;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso19139890pjj.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 31 Jan 2023 06:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yCu1XdomQIBGB7mzlg6WkaNsHf6XM2831H3ZuqepTdQ=;
        b=6op2ypw8/qbHL9bsR/EszDaFng1y7l/GMkMmoXjwJy0hTO1gcKxv2uzLI65RJzcPIq
         29YGzkTtwtXwBEj1D+R60mW9xog2tHQCdPeiRoYbG34YsfFvxbcb3CO4fXCvveWpevGc
         56T3QHqZofgyEjzRdxS5oh/o4+awHDirGefBQVvqCLnvEx04f7e60jL5Wa+2RwkFtlpg
         zZu06jnVSm/lWGwXVt7WzgssaTAIWTIpbOJneFazCpbaXzAfYsCUGyb11J9FSxiezVue
         8JdgCDu+KlCaYwXyogoQBmysb94JfJeowc62C8TjHmqLiHSniHn8LZBrADneCLiHH8rf
         pXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCu1XdomQIBGB7mzlg6WkaNsHf6XM2831H3ZuqepTdQ=;
        b=F0TVvHyINOJ4DkagvdFpYe2MDU/VmMPmwHLVMJbASKUhqBfoPpOzWLnAJCDXpz0fAR
         +c8HhyzVn65OFtK+FfbF0iz/EKQiNEINPlGmPQFSS27gqbAkCq1BbfKr+d2eyDD2/YsR
         oqFIptXq2HqMG2WWMYtJLihsaNWdOCBZY0KFY9Ymhbvk5ooMTpKG4JbUbLsYnIWDa2KR
         xh/RC/+IkBJUgjV7mkIR67lsPIr+cSid9jxaKAO00OwpypDh4r9sbqY0GZzupzef0yAP
         AKccLFHdzCgCJqYjo9IVWTxQJ6+pfvB9udLD8w6HExvNWDADTiNEx5VWxV+WfOXtpgo7
         B0jg==
X-Gm-Message-State: AO0yUKUTsF95qBn+0dgqW4NPer/hop1Dse9d+jye0epbCSywL3ufFh8T
	5gsTvDjICK/8Wsq/hH33d6mFdKJZuzPBxWphB9aoHQ==
X-Google-Smtp-Source: AK7set9sIdZY33Xj4cZ6lcV3nMf19h+kk84u/htyjaDw07drHq7cwJ7bUOch1wss+LToW10/1Ms1lA==
X-Received: by 2002:a17:90a:1988:b0:22c:6b5b:8509 with SMTP id 8-20020a17090a198800b0022c6b5b8509mr13189875pji.16.1675174287626;
        Tue, 31 Jan 2023 06:11:27 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p22-20020a17090a931600b0022c1266f0c7sm8827456pjo.21.2023.01.31.06.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 06:11:27 -0800 (PST)
Message-ID: <63d9218f.170a0220.7b11a.e3c7@mx.google.com>
Date: Tue, 31 Jan 2023 06:11:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.165-cip25
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-ipc: 12 runs, 1 regressions (v5.10.165-cip25)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 14:11:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10541

cip/linux-5.10.y-cip ltp-ipc: 12 runs, 1 regressions (v5.10.165-cip25)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.165-cip25/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.165-cip25
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      52aae1dc6afe62fedb14c89fd4feca1d8bb13416 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/63d918de4bfe74395c915faa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230127.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dd2d61ac1a1e09797a6165f478abd4a9f4f43035 =



  * ltp-ipc.login: https://kernelci.org/test/case/id/63d918de4bfe74395c915f=
ab
        new failure (last pass: v5.10.162-cip24) =

 =20


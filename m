Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB232C41513
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 15:37:39 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.164086.1692200257906246304
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Aug 2023 08:37:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=mhX2yNpy;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1bbc87ded50so42127645ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Aug 2023 08:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692200257; x=1692805057;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=if+AwMXTDOSOILjM2D8YlXvEtO2ORlpP66BW1hEmNO4=;
        b=mhX2yNpymV2gmXa77Ap7+n6O37sm/NdaLTI7h69zkwLVqOVQJ9DOf4SKIitc8ENvGX
         VRpJwCrOGvdkKGxqMgOf6W4Qw4z0I6dOkSZiPAwA4pyEkNDG81DzWkksPdzPk0FR7Iyp
         XhoofPH/vwOnfViYI1zgST013LimnlhZWfd7kr3y8ol/HD/BuOwxyKWW5TyODxfbNrly
         6Rx245oT8q8I67CHkbcaC4sf7n5mLZ2UBYk94eqm5LoOdk9vezqKRxqVlUe8CyhwLdtt
         AQS7hsc7ZIbdXQ/K6w7P3r3K7eVLy2vhZCPmkvBHaoeX5uO0xjPkpBzrlHSpq6Jl+ra+
         PNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692200257; x=1692805057;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=if+AwMXTDOSOILjM2D8YlXvEtO2ORlpP66BW1hEmNO4=;
        b=Jr81jDiJk5cCd0zpW4JO5yfBACndHIcoqrhVfSXUR47LJuUQE27Um3X+N4gUXyaa8c
         ts52YSaLAWETdaqg5gR8EhBauUR0WuFr5ClzfC7586rNQ5jrOavIxHX2VW4/1Gz4EtrE
         xsg+vl6YrAwvyubZuTvEQRzMuhjI+LPUt571Be5qjxmo0m605rhBN6046QexTcGrz91b
         /zYG2s0PpEsfIOtCUIO09Rq2iEvYhYZMRylxCAiD5lDFBJJ79QRYC5SK2EhRt3+jQM6c
         UiZo71xcZwH2lING5UU0r5AkDMI+3zWFg/fySdbQqP7oKgfBK+ku8Xq2kukv6Nw8ZkLS
         ZFpA==
X-Gm-Message-State: AOJu0YwM/qbjD3sSBeCtxeb0ZYPwAJjey0AQLnPyBgcP8HU1zquI4pzo
	0Zaq0e1wDVHaLYvlENvZFOAoqVTSIwERzQ4T8VCaVA==
X-Google-Smtp-Source: AGHT+IFa0L26zJDAZEL38d0Gf4A1EZ0Z6+1V+emfJTJ3CLIUKaGuk5JbLEGR9fXn5Arl4z4k/gsA/Q==
X-Received: by 2002:a17:902:e891:b0:1bd:c956:2798 with SMTP id w17-20020a170902e89100b001bdc9562798mr2272906plg.46.1692200256553;
        Wed, 16 Aug 2023 08:37:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902728c00b001ac5896e96esm13243865pll.207.2023.08.16.08.37.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 08:37:35 -0700 (PDT)
Message-ID: <64dced3f.170a0220.73660.8582@mx.google.com>
Date: Wed, 16 Aug 2023 08:37:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-3262-g667bb8d8b2cb
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 1 runs,
 1 regressions (v4.4-st20-3262-g667bb8d8b2cb)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 15:37:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12735

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 1 runs, 1 regressions (=
v4.4-st20-3262-g667bb8d8b2cb)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-3262-g667bb8d8b2cb/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-3262-g667bb8d8b2cb
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      667bb8d8b2cb1a46bab0ddda1cf60f6e73eff4c6

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dce3a70393d3fa3535b1dc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-3262-g667bb8d8b2cb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/64dce3a703=
93d3fa3535b1dd
        new failure (last pass: v5.10.186-cip37-16-gf8567732a40d) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAB7C19F2A
	for <webhook@archiver.kernel.org>; Thu,  4 Aug 2022 05:00:52 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.1386.1659589243615837659
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 22:00:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=ceqY7iV0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id o3so18332670ple.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 22:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=kIHAxTav1N3qxdPx8h5b9q3WfIomDhCeyCQt9TuSRcc=;
        b=ceqY7iV0MODU60lqCmdZg4OpUgoiaWOK9YYOD+Dc7ABl/SptUnbPOnmYLYig8kalBk
         +6y/FBVs1rLeZEMclfFiQzcvCj+96r6YiPX0nk49sKBSktPgVVadKtd8u4K1kx/FM3zc
         czF6e042XWLMGLa0TMpQhjrgrT4YDBl6AwMsjpy59r+kNw8MDhUclu8LXH/p8NzxRiuZ
         jbQGYGtGw5FJYC7Ht2MZPqfxxoE1C8FbI8aIm6w84in/xWYGXcFs0DQN+jbMhgCE6BbE
         iUq6gnxFdlLPYkvZEPKHSp9VMrmo8o1I9APllQ1u1TyTRrBif6e8Yjw4EG1Ar+5A/Sz5
         oFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=kIHAxTav1N3qxdPx8h5b9q3WfIomDhCeyCQt9TuSRcc=;
        b=wudvaYEJVfQpfjWLhjyhjj/MRhv+bg2gBTJi/DoGzNCYLIR4xo9UJZMs5x8Ej0dUFq
         guRHaYoLmg9CA7w2JnTSKfGEbHbZChLxcswBCTj23NBTV7iVbpfyr1JwkDhfDl8eFs32
         m5+haGzrbvxCuvyHe7+ll51MXlymbsQI26voHD1ADRsqKxIUbOuve5CeRpNfGgooLM1B
         AdH9bHWciFVKW6C+Npb8zaMVNWDpJ0TVBsb2B7EgiErZR/W8E7fIyLFUTZiAlU8g87vF
         9OVK0lNuTCc/l6t1hWStdrM/+BnyV/2KjmQYuptq5znvEICXtzx2zO2SZg8DgEoqlUDE
         AzQA==
X-Gm-Message-State: ACgBeo30Fs2JYYaGtV0L0v45szP/uTtAMWRJBVN3fJ/nLjRuhRbfpSvk
	OAOQYjVeX9nGkzoFoEkFuXSvbkt16B3JjAOXP5A=
X-Google-Smtp-Source: 
 AA6agR68EFPMOjs93fBcwYyeoWjDO6GdCFBdGdYKRcqCGylfsQJHA4VXvFl58skrTwHfTdFalFGokw==
X-Received: by 2002:a17:902:e744:b0:16e:f6c2:3731 with SMTP id
 p4-20020a170902e74400b0016ef6c23731mr199684plf.104.1659589242736;
        Wed, 03 Aug 2022 22:00:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 e16-20020a170902ef5000b0016ccbc9db0fsm2883557plx.5.2022.08.03.22.00.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 22:00:42 -0700 (PDT)
Message-ID: <62eb527a.170a0220.5962f.57d3@mx.google.com>
Date: Wed, 03 Aug 2022 22:00:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-37-ge3a52725ce96e
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 6 runs,
 2 regressions (v5.10.131-cip13-37-ge3a52725ce96e)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Aug 2022 05:00:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9107

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 6 runs, 2 regr=
essions (v5.10.131-cip13-37-ge3a52725ce96e)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =

r8a774c0-ek874           | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.131-cip13-37-ge3a52725ce96e/plan/baseline=
-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.131-cip13-37-ge3a52725ce96e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e3a52725ce96e4794cc31e31ccd20914f40f19a3 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/62eb4e312b89e236fcdaf056

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-37-ge3a52725ce96e/arm64/defconfig/gcc-10/lab-c=
ip/baseline-cip-nfs-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-37-ge3a52725ce96e/arm64/defconfig/gcc-10/lab-c=
ip/baseline-cip-nfs-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm64/cip-core-image-kernelci-cip-core-buster-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62eb4e312b89e=
236fcdaf057
        new failure (last pass: v5.10.131-cip13-431-g420b8f43ddc46) =

 =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774c0-ek874           | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/62eb4bc37678a6d10adaf06f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-37-ge3a52725ce96e/arm64/defconfig/gcc-10/lab-c=
ip/baseline-cip-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-37-ge3a52725ce96e/arm64/defconfig/gcc-10/lab-c=
ip/baseline-cip-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm64/cip-core-image-kernelci-cip-core-buster-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62eb4bc37678a=
6d10adaf070
        new failure (last pass: v5.10.131-cip13-431-g420b8f43ddc46) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F76C7EE2A
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 15:12:09 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.28877.1684509125780397424
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 19 May 2023 08:12:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=SdeSxQPu;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ae507af2e5so7263795ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 19 May 2023 08:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684509125; x=1687101125;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U+bAsl2fvNOblFSBEmjuLTjVASzFkpGYQ36lFfo6lMY=;
        b=SdeSxQPuex1aj6Dykma9v5o2efYKxIlrSpRAkFFYQYATpSgSX4PH5M19h8wVUVOWVr
         uUv9jP0duSQRi+DLPS4NQcMEH6eQzWbVQMI8EfMDtPtgTloaVVFQBJ+vyOpZndS2SC9m
         TKTRaH3xrWy0t7GDcNoAdyW7wpNC8Y2/h+5fJnhGV0tJ5NdV/0lh3R8mLJQEMYiDyEpj
         hyHDFuNpUAnkcgMHQ9vxTGMuKf4ecMemTAWQZnMGW6wtbyLeVz+qEqChgG96hc0PhlHq
         LHbf5cFDyXTncXjX/bDGk24QA2PhV3I6in8T3OmDByFK4Q9Pbckoxfh35LV1E++JNTJT
         767Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684509125; x=1687101125;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+bAsl2fvNOblFSBEmjuLTjVASzFkpGYQ36lFfo6lMY=;
        b=AoH3Bgl/9QkzNkL5qMfQzpTxjVSLBxafIq3qbHObU8zpTLjCjwjiUTnfaNPFfjKZBL
         mikcWjDkL3Jak1n+A1nC3laOP3LMTm5lq7AGqjJXKkw9f3mD7LwuoEfln1HFbuj55rb/
         t01XFoty9wlJR2hKv3dq6jbiiMRp3OfJlptUlYiZeztLvog5bSTzArnL0W1KFUWssXkP
         j4l3UbQJXNSHyROFgrjxOaDzgklaZ+AheqzCPQM9OCCYV1wTghb9wNv0FdzdfuSSeRUo
         IBRUNTAxwSYKAFe+yHbV/Psb1lUIAiS5A4y7HaqATS+O/riaZlEXHf1B0kWytsgsA4XD
         PjZw==
X-Gm-Message-State: AC+VfDzH2a5flD+ybkNVzfN7IkW8jwDbdKXT/AR1VAUOu/8CtgR5yalm
	qAQZJAriQ7BUQOOrhofcitu2/c+ngi6HkJMXgaQqeg==
X-Google-Smtp-Source: ACHHUZ78WrXqol2llnnQwMpdRcb3wFp/yT7Ew4GwUV9SOXtWVs7F5E2zxBLlxIQ53zOCpC5JBLRRBg==
X-Received: by 2002:a17:902:d2c6:b0:1ac:9efa:bb10 with SMTP id n6-20020a170902d2c600b001ac9efabb10mr3476700plc.4.1684509124803;
        Fri, 19 May 2023 08:12:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 1-20020a170902ee4100b001ae6b4b28adsm3550516plo.130.2023.05.19.08.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 08:12:04 -0700 (PDT)
Message-ID: <646791c4.170a0220.6d8bc.67ba@mx.google.com>
Date: Fri, 19 May 2023 08:12:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip33
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-ipc: 14 runs, 1 regressions (v5.10.180-cip33)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 15:12:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11564

cip/linux-5.10.y-cip ltp-ipc: 14 runs, 1 regressions (v5.10.180-cip33)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip33/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip33
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7f6b02104eb287caf662ade9a67f11896ab01fde

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64678b1b385e7f3cb52e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-ipc-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-ipc-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/64678b1b385e7f3cb52e85=
e7
        new failure (last pass: v5.10.179-cip32-4-gd8c029e4780f) =

 =20


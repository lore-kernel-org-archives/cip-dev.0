Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04379EB64DC
	for <webhook@archiver.kernel.org>; Sat, 15 Jul 2023 02:31:20 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web11.4884.1689388273606710592
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 14 Jul 2023 19:31:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=n33pcUms;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-666eec46206so2514940b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 14 Jul 2023 19:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689388272; x=1691980272;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CkIMbM4oMuPq+zSssWKqbQMbHiDgJRrl76pJRbzKBv8=;
        b=n33pcUmsy8Zd4Y3EwmYEhwyIpdeqv68x7yI5IXaToxaNwAa1TfCcgAuLVRAaoKRDuc
         x23S+xVdkDWwVjfKOvKcfqPrtr7V4rhcqYOL5XCshHNXGLth1G7B8URyIPdXP0qKezYr
         j/n8YCO5Pdv0xIjsePcPUltb77BjeFI4HYjzfcZJfJ2WtLqW1LCacL5dfPmSvixLdrts
         bpa/b3qBRxvJdJjmEmG6IMaZANmjpzrB3s/yCbf0G/KTOFJSeM4IISqaJGoEtD4sAcT7
         5/gAFRZw5I5UnCVRYsXrNskTQ7Gy5uOy5dCxMzN2EXKCPA5A6qjQgjZeMyj1f5cT1Lmq
         5PJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689388272; x=1691980272;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CkIMbM4oMuPq+zSssWKqbQMbHiDgJRrl76pJRbzKBv8=;
        b=D6tYTvR6fbJklPw5NY3Tzi8fKClfx1rV6oxPbxPJxIXPqhhUtbTtqw88OfjB3KWPL8
         EWzleWYzihaJ/5z8CNf3Hrn2kdZyPSBQT2Qetk/ArB20OG21OBd3gp/xq61r78fjGvKB
         oYaaxWJywafiDrgbfqS9JFeb4gTZ1ggYyJwssQZxFXw1exXbGuopUx1ExAKBPUU8HP1+
         HFM0SF+gRe9fHApoTWFvzH3B+VDfdVEUtDEnFuXm6bijtH8FxWAsCdcCXmGSTSEVf1qu
         /fYAoKQQwZqae8N3TBUnKPbc/SXBoEQZLib+xbXQEKwU66APLaR8Ax8oObaOWhgV3FxV
         Jx3g==
X-Gm-Message-State: ABy/qLZ+zTRhS826rCqTJvSX4RmXWlhmRN62GDcgvSw69Rqh1y7GP4vA
	c3C3qit+/YDqEEZRQ8d6iP0XsjshmqPjmLntgcLZew==
X-Google-Smtp-Source: APBJJlHc3eF4Z0/ojFRaCrEl9QskBofdZcvnD6el/G7OvYlRo9NX4CfelmeCCAJtzcQtx2a/GhyG8A==
X-Received: by 2002:a05:6a00:a01:b0:67f:3dcd:bc00 with SMTP id p1-20020a056a000a0100b0067f3dcdbc00mr8260766pfh.2.1689388272412;
        Fri, 14 Jul 2023 19:31:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t12-20020a63b24c000000b0055bf13811f5sm4534281pgo.15.2023.07.14.19.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 19:31:11 -0700 (PDT)
Message-ID: <64b204ef.630a0220.2b08e.b9a9@mx.google.com>
Date: Fri, 14 Jul 2023 19:31:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.186-cip37-rt15
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt preempt-rt: 1 runs,
 1 regressions (v5.10.186-cip37-rt15)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 15 Jul 2023 02:31:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12356

cip/linux-5.10.y-cip-rt preempt-rt: 1 runs, 1 regressions (v5.10.186-cip37-=
rt15)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...k+preempt_rt | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.186-cip37-rt15/plan/preempt-rt/

  Test:     preempt-rt
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.186-cip37-rt15
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      db05335d4d4ee47b8fc64652b2c2ad8e57eeaf52

  Test suite revisions:
    rt-tests
      URL:  https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
      SHA:  4ad6aa8141f225b7741cc3c5c52a649e7b8915fc =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64b1f79daad0a7f3938ace89

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/preempt-rt-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/preempt-rt-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-rt=
/20230623.0/amd64/rootfs.cpio.gz =



  * preempt-rt.login: https://kernelci.org/test/case/id/64b1f79daad0a7f3938=
ace8a
        new failure (last pass: v5.10.184-cip36-rt14) =

 =20


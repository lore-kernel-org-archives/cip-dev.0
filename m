Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B550C04A6A
	for <webhook@archiver.kernel.org>; Sat, 15 Jul 2023 02:31:20 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.4860.1689388273872875440
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 14 Jul 2023 19:31:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=kpC9oInE;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-666e64e97e2so1836649b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 14 Jul 2023 19:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689388273; x=1691980273;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8GgmFm1xa4DFyM7MfBF/5HRMZGV7/V1IL3UxiJzqnY0=;
        b=kpC9oInEhJKoeyTLpRY3e43PS8Zq8N94ztnzrdq27bdKE87k2BgOnolD+2gKEDPqnc
         pwMJ9lOT+BEeiPP2liHNhOOlKTRDC0EAJRkJ6gH9M1jRZZcnVlMiYym77LAhMGCoLou3
         2UYYge3yf86T4s/qR4nuaeScvR54k/2S6+TeKxDnrNoR3zdDZlZ5gd/d7H0RKm3hz7Go
         1mJHZkh1Puynv+0Id3jl3peHwayC0ZQK+fzfhgQqrLAAxHWhH8DoE5FQcX5C/AgIQmBH
         sXi/+941Mvtq6klohLvJEId/5tOwgikb3eHUfPobGl2mZQANRgbVrE2iapdshcjtgOLF
         7jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689388273; x=1691980273;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8GgmFm1xa4DFyM7MfBF/5HRMZGV7/V1IL3UxiJzqnY0=;
        b=Hz/v74T6vIKehWubp0sLMImuqbenAtLz8JXfGNyn/u5We3lLqvMuZen7NJhNv14Koi
         ysc9oO4IMVvBixgoonrLgzoQsNnybEXG3ugLk+eXVhL84dLItZNxHHCDlp4NP47Opi1B
         vsE8nz/JO/vF+TS3z4xY8Rd3sJw+WasYjdIQyHxet+FoY56sx+TMpqmj5iXwm+7OmG/x
         r5mh354eBNldGbb0ZZ1IqnBdzcaIMrtRTfoaVAbXb0/MKDpepplYAkLPuikMWqxAFV2O
         8Vu6Rn4sVqrAzXF3VW9K6sk0Q53lDmuNwKaTGEx/jEc7RvO7iicPFaAv0N1vVNCSb3gs
         OBzg==
X-Gm-Message-State: ABy/qLbif754gL/g+edDugq4PDRGPwXW/qFSo338HtylM6pG+e6USJCM
	qTcZXw1dFrW3IRViSv6shycm1TDQz+OnGoM9SdsP3A==
X-Google-Smtp-Source: APBJJlErQ0J0qToYtm2OA0xAHScu65Aaj1B0wFIz/Q7kUBBtzzqKEc2sHyAGjKjMjrd00fQu09dtqA==
X-Received: by 2002:a05:6a20:8e22:b0:134:33a3:7887 with SMTP id y34-20020a056a208e2200b0013433a37887mr333887pzj.19.1689388272940;
        Fri, 14 Jul 2023 19:31:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s1-20020a63af41000000b00528db73ed70sm8167220pgo.3.2023.07.14.19.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 19:31:11 -0700 (PDT)
Message-ID: <64b204ef.630a0220.e5c2c.244c@mx.google.com>
Date: Fri, 14 Jul 2023 19:31:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.186-cip37-rt15
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt ltp-ipc: 10 runs,
 1 regressions (v5.10.186-cip37-rt15)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 15 Jul 2023 02:31:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12357

cip/linux-5.10.y-cip-rt ltp-ipc: 10 runs, 1 regressions (v5.10.186-cip37-rt=
15)

Regressions Summary
-------------------

platform          | arch  | lab         | compiler | defconfig            |=
 regressions
------------------+-------+-------------+----------+----------------------+=
------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig+preempt_rt |=
 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.186-cip37-rt15/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.186-cip37-rt15
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      db05335d4d4ee47b8fc64652b2c2ad8e57eeaf52

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab         | compiler | defconfig            |=
 regressions
------------------+-------+-------------+----------+----------------------+=
------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig+preempt_rt |=
 1          =


  Details:     https://kernelci.org/test/plan/id/64b1f788f9e94943ae8ace42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/riscv/defconfig+preempt_rt/gcc-10/lab-broonie/ltp-ipc-qemu_s=
mp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
186-cip37-rt15/riscv/defconfig+preempt_rt/gcc-10/lab-broonie/ltp-ipc-qemu_s=
mp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/64b1f788f9e94943ae8ace=
43
        new failure (last pass: v5.10.184-cip36-rt14) =

 =20


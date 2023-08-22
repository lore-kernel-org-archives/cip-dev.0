Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6B7EE49AA
	for <webhook@archiver.kernel.org>; Tue, 22 Aug 2023 13:19:48 +0000 (UTC)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
 by mx.groups.io with SMTP id smtpd.web10.7765.1692710381623523198
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 22 Aug 2023 06:19:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=FHmGy1/R;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.48, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1c11d53221cso2884856fac.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 22 Aug 2023 06:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692710380; x=1693315180;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iJZCr3xffeBlCJzp7fZ7Ns+JdqK4YMdBaj1iofR4sTs=;
        b=FHmGy1/RNUhBQwu3P/TV4cs9nWwC0n1vmTvpXHA6Fb+BYYVjCW1qDFtYacUBKMYreP
         HVkwX8rGIHTNfP6oDHy2PMUX856JeP2NvlAStwhXX/9hd7cob0UuVjy/LTQdmhyEzk1N
         op2k5QdMYa6UvGJii5YiJydwush1PD5Rd1sh8CIjiVdMkOem42ChkfMb/8hCTxccJMBO
         qiu+1UR5llR+HdWKm2hbhPw/dX+GVmxovDaZASy+d5wkiUInGAQiSch+ZMQ3WKrgiTGo
         wsfnGjNG9I1DJetuS4hEZhlNgBepNMZyIoFarbVEPnWCATz8ZGwsbQFUCYVGXgYGY5H6
         ssZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692710380; x=1693315180;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJZCr3xffeBlCJzp7fZ7Ns+JdqK4YMdBaj1iofR4sTs=;
        b=jH/qZvLX0E9LVXrYi/4IdBiuejHUGEVVOLdwELLc8bGaif+rcOhxdgI8xaJ37FuAmv
         1m6uqnQrn5VL5aET40Revjcpae3RisZ6HnHP0JjWevwHCQLaJCnpZ/zZxoepSmTVoneX
         atLZpC+daczi9RdxA5XLo97FViDP0agCTcIMF3E3AY/V83S9CGnx35dAgv++aHKsdpIZ
         c+q1Z98VuH7v7SQVKJ/e21baVEC5NYlqnc+BC6b3StztpCbD+XQEfqvjHi73T45D1ZoB
         LgNLFWVeMOKW9SXMh9+VqkFT08MZF2Rnc9Iuj5y8KG0Jz4vu7X0S3Rr9w156/bLvZVDs
         zLQA==
X-Gm-Message-State: AOJu0Ywzqg/zCTBUtC0feypSBlmTnYNlh7uEAk031xagGd2b3Vmst1Ja
	Q9j+ZwQT9cKE0zprRDoq/E8St99K99ZN7h2qKqGgvA==
X-Google-Smtp-Source: AGHT+IFP+BIK1S5opeEto2NTT1GpqalV+z9eB7hUbVh/Tfrilq40+uoy0pUggFpjn8HROnQoOpX1ZQ==
X-Received: by 2002:a05:6870:d113:b0:1c4:e139:33f with SMTP id e19-20020a056870d11300b001c4e139033fmr11459063oac.10.1692710380533;
        Tue, 22 Aug 2023 06:19:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bt11-20020a17090af00b00b002680ef05c40sm7873334pjb.55.2023.08.22.06.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 06:19:38 -0700 (PDT)
Message-ID: <64e4b5ea.170a0220.e07d.e1fb@mx.google.com>
Date: Tue, 22 Aug 2023 06:19:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-27-gd6d928db0a620
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip ltp-pty: 6 runs,
 1 regressions (v5.10.186-cip37-27-gd6d928db0a620)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Aug 2023 13:19:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12824

cip/linux-5.10.y-cip ltp-pty: 6 runs, 1 regressions (v5.10.186-cip37-27-gd6=
d928db0a620)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.186-cip37-27-gd6d928db0a620/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.186-cip37-27-gd6d928db0a620
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d6d928db0a620394e433833b5dda4ec7ac822999

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/64e4a6b18aa243d7d6b1e3bd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/riscv/defconfig/gcc-10/lab-collabora/ltp-pty-qemu_=
smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/riscv/defconfig/gcc-10/lab-collabora/ltp-pty-qemu_=
smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/64e4a6b18aa243d7d6b1e3=
be
        new failure (last pass: v5.10.186-cip37-14-gc9b5a049d8ea) =

 =20


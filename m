Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FAFC7EE2E
	for <webhook@archiver.kernel.org>; Fri,  9 Jun 2023 18:39:34 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.2399.1686335970272314109
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Jun 2023 11:39:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=mlUHuFKM;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1b01bd7093aso8329945ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Jun 2023 11:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686335969; x=1688927969;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ffh/UmCltKWQxW0klGs6lJMNa9joWY33pMEQHYqXmnY=;
        b=mlUHuFKMyVgGnPl1uFFsSo1Dk26zb0xWu8WEolo/yJ0P1KIDE0vreA8HlAPJ9zKFDr
         nvDThYHZ9xd9vv0BgpuNuJizK/eYMMPWNKiPEQ3NeRbBq5lr3oRcauXbc/t8qPST3i9k
         211OGXMtDsqF4zJrp1VISRULjbnUQay4NwqXXT5a8fNQEXL20XXcPiI39BfbR+DNRxu/
         HVTsC5soF+WTr9pcmlb88Hq12ceaAG/D87Wlwg7PpXgwI45AGLST8gibFvsw3togC5xo
         kfuA8iCEb8VqF/pa+shmuF1yNfoq4v0tLQsRrEMvSQIOUtcQIpHRb0g51Wv0lVjcMe9n
         dD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686335969; x=1688927969;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffh/UmCltKWQxW0klGs6lJMNa9joWY33pMEQHYqXmnY=;
        b=GLnFc8C5yMF5FIPuUjSDPCYM0PSR3GpDYWlJKeALjg1aKneNh+1ND0O5WAGEOL5Khd
         HUA6MmvNWPJ/7ChLIM6rbWeDIjMSNKJs3p+cAA/z+TKVGcsqgMJTEHjQUVnRjvwa4WJS
         y72re8Yd6JTCPP4bB986RTEk5y952L9vhu1Gvb9dijdnfUb9+KJxaExnjOBNBn/2IbOp
         6OFqyYzYR8OurgplwIOH/DtefDc8xPJdRVD7EYXYTSf76WuW260rI1yflkMyMRwFrynE
         SyIXM+ZE4XAQVmeUSgg/doJr00diIJP3c0sBmvagjeTHZckjITJ9X8rbruwLtjdIw41K
         XxCQ==
X-Gm-Message-State: AC+VfDzfgSQfDHVuYvdL/TVX0yEtfiuGvYTefxHCnqteImnJvsf4mt2p
	HtJqgXLfSSCoDeDKh6MQiYHQnbDiHo3H9JLat7o4fg==
X-Google-Smtp-Source: ACHHUZ6Jotk8Kwxns3ZE0HV+ZbHpYbLs/wOsDFh2NQsT9ValmL2+to41351DW6S/JwoTxnjuHT1arg==
X-Received: by 2002:a17:902:e807:b0:1b0:5e97:ee2e with SMTP id u7-20020a170902e80700b001b05e97ee2emr2104467plg.19.1686335968902;
        Fri, 09 Jun 2023 11:39:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e5c500b001b1a2663e9bsm3628939plf.77.2023.06.09.11.39.27
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:39:28 -0700 (PDT)
Message-ID: <648371e0.170a0220.d0623.7bf9@mx.google.com>
Date: Fri, 09 Jun 2023 11:39:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.283-cip98-1248-gcaf6e8ee921e9
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 3 runs,
 1 regressions (v4.19.283-cip98-1248-gcaf6e8ee921e9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jun 2023 18:39:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11955

cip-gitlab/ci/pavel/linux-test kselftest-futex: 3 runs, 1 regressions (v4.1=
9.283-cip98-1248-gcaf6e8ee921e9)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.283-cip98-1248-gcaf6e8ee921e9/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.283-cip98-1248-gcaf6e8ee921e9
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      caf6e8ee921e9e7714b8669fc9187fcd56d5a5e6 =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64836310ad73f938693061d0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.283-cip98-1248-gcaf6e8ee921e9/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/64836310ad73f9=
38693061d1
        failing since 2 days (last pass: v6.1.26-1320-g1ddf4b637f785, first=
 fail: v4.4.302-cip74-rt43-218-g246f4be89a77) =

 =20


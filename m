Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3814DEE01E8
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 16:43:41 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web10.1725.1694623411850805184
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Sep 2023 09:43:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Pzx3APaY;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1c337aeefbdso64213235ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Sep 2023 09:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694623411; x=1695228211; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bDkwThHaW+7AVC1HNszOJQcdlMDmv+sXx7fw4e0aThs=;
        b=Pzx3APaYDEA5jGOtAyulNXYKJi2o/JpyY6/BXxwrImPxhprL5J6GdxbURC7vPBCcMS
         1zZIy+RaPuHcakUz/PbxR+QAfBiKmAle+7eL09r0jFXp0ENPVjwlnNsiYlsb6/wgSUsA
         Lgipqtr5yVbFJUQPq+q935oF3l/7uNSMGJswPUtThbfCyKyAK2lnUgRzIQJHVWpt7rEq
         ilmRrUaz5sjoz873Hge/7AG/s54INUjRqRXff852sb4BYxnuzlBWQoJJO+IycP1gpAe7
         wnB2aWrxOOUysFk6FH2rt5CHv3eK9Lcm2uO1OVchlrKLfaPtwInUeHlYH1flYRPmb+LB
         RH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694623411; x=1695228211;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDkwThHaW+7AVC1HNszOJQcdlMDmv+sXx7fw4e0aThs=;
        b=IkJxdWE3hMZhTl6mKXWshlyNniMLbwu6ftirm5MXwNP1ZpsDVhWgQxPzvylIRy1dMx
         qElfOCt+lt4DSQbfINAHLBDM81NuAuiFBi1PmgO+dYHU3+xghqYuqqtz7f8Yl8bczP8e
         s4sv8TzIQYno3nWRSgz9/9OBjWIXDNzh+Ld4Dxw5zYV+QDHzdy9rttZu6dEbwk20mVvh
         H86UQHaT68SAzlqYbG48RlIw76jLnX2XeqTM1n+8zils1HO3Cd8OCMDi3JgnYyCXnvmr
         YzLfVFHsGseQFZ++NqV2A23dlDxvVwC39G0Vb5eyu5m4FxTVFdZytosWt3E6JYYcIq20
         clLQ==
X-Gm-Message-State: AOJu0Yx9T31fp0E8c00ci4FsIDRpVXymsZA022whRj14g/va+0fU90Re
	R1cqC9a3lFFjGJLYFG16LKuG+yDu/GC7xyiy0DM=
X-Google-Smtp-Source: AGHT+IF8s0bXNbOzx94vXUPBFEi+/FXPstgzvvjVHokpGnqqoh25AFpeDSJvohoyx79Jw8L/7RSXfQ==
X-Received: by 2002:a17:903:120b:b0:1c0:7bac:13d4 with SMTP id l11-20020a170903120b00b001c07bac13d4mr3558514plh.65.1694623410775;
        Wed, 13 Sep 2023 09:43:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902c3cc00b001b869410ed2sm10638343plj.72.2023.09.13.09.43.30
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 09:43:30 -0700 (PDT)
Message-ID: <6501e6b2.170a0220.5d798.edac@mx.google.com>
Date: Wed, 13 Sep 2023 09:43:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.191-cip38-29-g9e1aa2001db86
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 5 runs,
 2 regressions (v5.10.191-cip38-29-g9e1aa2001db86)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 16:43:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13109

cip-gitlab/ci/pavel/linux-test ltp-pty: 5 runs, 2 regressions (v5.10.191-ci=
p38-29-g9e1aa2001db86)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 1       =
   =

qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.191-cip38-29-g9e1aa2001db86/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.191-cip38-29-g9e1aa2001db86
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      9e1aa2001db862da32812062860b8756cbc8890a

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
qemu_smp8_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/6501d3ef11b04244678a0a43

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/riscv/defconfig/gcc-10/lab-broonie/ltp-p=
ty-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/riscv/defconfig/gcc-10/lab-broonie/ltp-p=
ty-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6501d3ef11b04244678a0a=
44
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440) =

 =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/6501d3440c866c24988a0a56

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/riscv/defconfig/gcc-10/lab-collabora/ltp=
-pty-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.191-cip38-29-g9e1aa2001db86/riscv/defconfig/gcc-10/lab-collabora/ltp=
-pty-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6501d3440c866c24988a0a=
57
        new failure (last pass: v6.1.46-cip4-14-gb994de8f45440) =

 =20


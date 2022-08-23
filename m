Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E696C3F6B0
	for <webhook@archiver.kernel.org>; Tue, 23 Aug 2022 03:59:59 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web09.27871.1661227197986894277
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 Aug 2022 20:59:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=AYsL0tbH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.178,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f178.google.com with SMTP id 12so11212951pga.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 Aug 2022 20:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=5PVZgTUby5XK5SnV8Dz3KIJM0ZHWcsr9JNiRqE7Qoh4=;
        b=AYsL0tbH5mzDN+LG2OF+Q6bW08HDtswHWw38x6t6UYdxUaebUDkr2+5S2JUS+5KaRM
         jadDTEW0djjnvd+6vuKD7TCXOlMUCkYYOpihatNv8Bkg+j6tluyZQ5S9AK6CYX3gZJuw
         959GO7Ps4hpG9uadpM8JH8xb1rz5BOoWtqoBMLoDHcMCcAJsyuziAh4pEOZ3uH071elV
         FJ8UXt22BNkmpk/eG8P1hIKVO3KwJYUMV9D2HbM+xb7mE2iVIcboAn2ec3FJZzdQi6jP
         WtUrQ86IM45chH0Lwhr4v2BomgS5nCOuXNElLFu7IDHgDpj3Njs520Y//dBacOb1foT4
         JPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=5PVZgTUby5XK5SnV8Dz3KIJM0ZHWcsr9JNiRqE7Qoh4=;
        b=wj0pe4mPSOp38eJhYJ1/0wiZaXqUO0zsmiUrrtLmRtq16D1wyw/Xu8PkJpxFFzy0p1
         g9Dyr3QxndeWzAU/87gOG7O3kBKqtn9ur4F206/pCW8otPO17PcpltxNFjW1VIPnSu1l
         OFhgfEAZ2G+GkTRhpPvX7VurHed/AVmJJtuQe0rFvDuaAy7kOWW5+jQvUTOOanwzZSHH
         i55th1pTtN3YzO+o9fJhLpvauI5tGS64pFejt3hdEsV9TE91/6lc/7bJomldCbyL2Hzc
         OydvF41YzKANrq3qVgtOB44u+jRK7pHCLJQ1ASm0iU0M164S7Y1YNU8lPJjeAjVTvbXP
         vSoQ==
X-Gm-Message-State: ACgBeo0NfHpv9cd/xqZFBJi+Asz0ICT2c+avLYWlobyAR+WNVzxEJqd8
	K0zacgxxmX087yne1xVKAuZaqSrq2Ln7y22r
X-Google-Smtp-Source: 
 AA6agR5poWc/32by/U9RHspsD4SBnRWUxK/WMrh9yJ8G3sTtKgr/JomjSum5a1RmUYAfHM4EF11YRA==
X-Received: by 2002:a63:8bc7:0:b0:42a:3e68:833f with SMTP id
 j190-20020a638bc7000000b0042a3e68833fmr15152247pge.120.1661227197113;
        Mon, 22 Aug 2022 20:59:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 z12-20020aa79e4c000000b00535e950aa28sm8686245pfq.131.2022.08.22.20.59.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 20:59:56 -0700 (PDT)
Message-ID: <630450bc.a70a0220.512a4.03b4@mx.google.com>
Date: Mon, 22 Aug 2022 20:59:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.136-cip14-542-g97767707d3d0
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 6 runs,
 1 regressions (v5.10.136-cip14-542-g97767707d3d0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Aug 2022 03:59:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9302

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 6 runs, 1 regress=
ions (v5.10.136-cip14-542-g97767707d3d0)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.136-cip14-542-g97767707d3d0/plan/kselftes=
t-lib/

  Test:     kselftest-lib
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.136-cip14-542-g97767707d3d0
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      97767707d3d0aa36cbf6620b216d0d19b9314417 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6304407a2e4f522b3c3557f2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.136-cip14-542-g97767707d3d0/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.136-cip14-542-g97767707d3d0/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220812.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6304407a2e4f522b=
3c3557f3
        new failure (last pass: v5.10.131-cip13-493-ge129308279043) =

 =20


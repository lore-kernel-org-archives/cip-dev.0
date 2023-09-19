Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0171ACE79AB
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 15:55:39 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.13501.1695138937487215044
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 19 Sep 2023 08:55:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=gEV12O0X;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1c451541f23so21358075ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 19 Sep 2023 08:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695138936; x=1695743736; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IpBZEqr5FheLKu6OpAumVFrIFpdXi9twpYcv3lChhlM=;
        b=gEV12O0XvVt4LKbIyX19wXyxRTVd5Cfp0HUANyl5cATO7f1WpQDpHnzl3z0DiXWo+t
         qhAwM9xM3ZubJjBBpVl2II7fEI4j1BBvJibgp6LJa2vetXC06RepsXT2/oPJgCW7g+Hx
         eDCndNMXz22m6yLNP6j+V6nXwugsZaSXyvbUUq68RHaocH0Z8w6VIhGDQ1UGislGjjIb
         Xvt6fWOrWkFiQIvQM9SvcgaxTW3ReDPTEC+z+b1/P4KRTdaTrby2b7SHrNVThJ74Sz34
         QghbRjX9fklf4xUnDBDThe03sj3kvc8R0nKW2/CoKGGBXNARNTRR8I1tfofqO/IW9sN2
         0NXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695138936; x=1695743736;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IpBZEqr5FheLKu6OpAumVFrIFpdXi9twpYcv3lChhlM=;
        b=XBRBDT8ZqQUdMJ/NLv6bsHr7r5vBVLLqXDXGOVLMIXR2CHP5uJibNjhw7Vv62lVFh0
         YsTsLUeceurBpekUUQuw1BZ8l50zZrccaXEwUSWHharzDJ1Rw52XYHurapJmgm5zejcL
         PzqnT9dLO2dWjMfu/dTtqDq985uxlS9iKykDvP5MQPtMuiU6KwsL1+PjmLa5f3th41HE
         uxtN1ATxUZDO5fFQVFtA9YKL9VOtoZtAlzxxQ4ISdfVSQmpO5p8kDhyN1frbheFoWbDX
         5Cv44ZlQgCZEbS/7vcQ0xgADCeCRHzOLnMO0FH8FzE6efcCCZpHlWvsZgJ/vQvsOxPmz
         ihUQ==
X-Gm-Message-State: AOJu0YwDdlpAFHUHh4qXZ/OEerhevyWaF09UlVRFUZHyVHQ4R54sy3kh
	GW3ZCXEPY5FLkC0nGKGmQm4xrIXP+f6/de4Lt6rwnA==
X-Google-Smtp-Source: AGHT+IEL31Ysj9yUKiuQyzqLrnPhQqK60ZVsb1ds2+L86oLM/E2ihrHpq5glb0mnoGRtiwnLZe2fsQ==
X-Received: by 2002:a17:902:d315:b0:1c0:cb4d:df7c with SMTP id b21-20020a170902d31500b001c0cb4ddf7cmr10186341plc.1.1695138936459;
        Tue, 19 Sep 2023 08:55:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j20-20020a170902759400b001bdc3768ca5sm10092760pll.254.2023.09.19.08.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 08:55:34 -0700 (PDT)
Message-ID: <6509c476.170a0220.740fb.312c@mx.google.com>
Date: Tue, 19 Sep 2023 08:55:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.194-cip39
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip smc: 3 runs, 2 regressions (v5.10.194-cip39)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Sep 2023 15:55:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13160

cip/linux-5.10.y-cip smc: 3 runs, 2 regressions (v5.10.194-cip39)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.194-cip39/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.194-cip39
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      ecda23c2ad8c5eae1f19054d0b67a7904546b7f4 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6509b6049df0cd72618a0a4f

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/6509b6049df0cd7261=
8a0a5b
        failing since 442 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-09-19T14:53:37.153502  <8>[   13.089989] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/6509b6049df0cd7261=
8a0a5c
        failing since 442 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-09-19T14:53:37.140036  <8>[   13.076324] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20


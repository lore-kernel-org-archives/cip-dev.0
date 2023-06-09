Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D523C7EE45
	for <webhook@archiver.kernel.org>; Fri,  9 Jun 2023 16:20:09 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.17613.1686327599481729384
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Jun 2023 09:19:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=aU91Zyzu;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1b065154b79so7754245ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Jun 2023 09:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686327598; x=1688919598;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jYDGnY7Jz50XoY3Re3nATxko6Aew28KPyp22c4xUpKA=;
        b=aU91ZyzuZSzTIx8gHbTWUaBkGAjGu5rscwzPHcXnRk/wWvH/fUNR4/lpR4txDoDtvD
         XLcGobclbJD8tOF3U/5HV/UmH6EELscuf6xH+xJoWosyBo8O+fpwcVKPkVug7iNxbTu8
         woeRWlM/FQQ4E9Z1xkxf0PMNZkfpORaAzhiv/HrB1+ldEFtkd58IpNUWOvWdoVscU0zm
         N2JjfQmw9iMfHZLOPwcedGEfcFd9754/tMrensv7I5pCQGAMKY4tsuNIGnj3khT3jJ1h
         H30xGoyiPH16EVfBOQDALcoDpARIpSulhJByheDC9+hHUqKTjKgZsAHF4ZnGL5MNvrgi
         HbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686327598; x=1688919598;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYDGnY7Jz50XoY3Re3nATxko6Aew28KPyp22c4xUpKA=;
        b=lvY+z3zXMvsIObPDrxpHTRQGhK8erQqiy8bswbLtBFV/+A+183gjps+jZmSybozqkj
         1wVl5EFduisT29w6ANALxFJGL1l2ne7JgBH4RzAUgPzzQ7JH6MNDPVbifaec0le+WvcS
         Q/2YH59Dc4bpQd7hKgFmzvCqNTS4+I5LDG/dGb4YX9MbBDBWNXNB6lEdD9kylORYA523
         dbaJe+jTQIdaNodj9gao2AJ5EijZMdxcF5B/GUmVUm7o/VaaOwalIQO47Q2Hx2PZiIi7
         4tgkANDp6kNw+zN/BH+WkubAzWV1mDsUlNW05Oo76dUb0Lxbj3WG3BLhecFJs20guRy4
         rueA==
X-Gm-Message-State: AC+VfDw1cuAb/zk5e//xnn4q1L0cI23feS1c1PwwW96EyjAHal5rE58O
	WzOnlWO3q6dBHgWx2jt6C0FynGPlROOkJTu81zv9Lw==
X-Google-Smtp-Source: ACHHUZ6eCHurjqU27pRm2CptdG54MXlRq+ZFjpy4cujVGdai7T3rGy9C6KTo9rLdDd2e4W0rK1PqXA==
X-Received: by 2002:a17:902:bb10:b0:1b1:9069:db5f with SMTP id im16-20020a170902bb1000b001b19069db5fmr2563884plb.18.1686327598579;
        Fri, 09 Jun 2023 09:19:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s11-20020a170902ea0b00b001b045c9abd2sm3470181plg.143.2023.06.09.09.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 09:19:58 -0700 (PDT)
Message-ID: <6483512e.170a0220.aee03.778c@mx.google.com>
Date: Fri, 09 Jun 2023 09:19:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.284-cip99
Subject: cip/linux-4.19.y-cip ltp-timers: 5 runs,
 2 regressions (v4.19.284-cip99)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jun 2023 16:20:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11947

cip/linux-4.19.y-cip ltp-timers: 5 runs, 2 regressions (v4.19.284-cip99)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 2      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.284-cip99/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.284-cip99
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a13de4c6b84ab64a5cb3ef5e852b1620686d0309

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 2      =
    =


  Details:     https://kernelci.org/test/plan/id/64834666a777c2f06a30613b

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.284=
-cip99/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.284=
-cip99/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64834666a77=
7c2f06a306146
        new failure (last pass: v4.19.283-cip98) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64834666a77=
7c2f06a306146
        new failure (last pass: v4.19.283-cip98) =

 =20


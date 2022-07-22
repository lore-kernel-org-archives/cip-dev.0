Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8932C433EF
	for <webhook@archiver.kernel.org>; Fri, 22 Jul 2022 18:14:17 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web09.11175.1658513654589471288
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 22 Jul 2022 11:14:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=xlti2tYy;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id o12so5099353pfp.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 22 Jul 2022 11:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=U2JGKFyJwq88dB+EltgA4fIIihS7haZ3LrpF9Pj/qFw=;
        b=xlti2tYye67XMs6bxVJo/PjWdI3niYQ3bh173gS1szsIl1R4yhL30d3sbWOnEz9Y2O
         t8mMVpNXyCSEMB5UDO8TJthLMdE7SlrDpbQ7COHw3TXsL/wOr7NvjHtdekho4svEpUjV
         e4+XY4d164/eXn1EtojSXZc05RBeVw+HzWN8wTEavRs/6pmve1V0eTHbg4moeHLcoA1/
         7IoWU1hLH6TjKYrqo+TMgI7JdtonjQ8CytdbBE+H9KCCsw+lYfRYbqylETpeDv8c1hds
         /kkcHr1CC8j6NncyV6rxRiKtpaJDM9NxkXGwDrmT7rsVcZSVvUsZmstRSVo+WwXCgmLk
         FHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=U2JGKFyJwq88dB+EltgA4fIIihS7haZ3LrpF9Pj/qFw=;
        b=XnnPsike4urD240vJNSFnIGa09hhztdCSIw5zMOJ1KnJNEBdR+n27trY4zMtKohGdJ
         d1zmJDDMW1GMTdx13fDINbNfLF+dgQFsgsqA9cvSxNmWSGhEzYNGhNrCYUEfSHgQWYFq
         VfwJWYpFCTOu9B/p+ZZb71lGpQZWtZrdlbUvGwTT0aGKTeZCisbn1OJ2pguYiSQP9V4g
         Ae2G7Tnk99pNM6Hbdeeekt7WLH0eLgudjysWni71oyZ2harHtUGXvmQ0yYL8gROvsVUP
         084r9C1X7gCd1/VB3gyv5k096IZFafrQ4TRd03Fi7E+KuCu8Lu8jNB7MaI1kX4i5K4JI
         K91A==
X-Gm-Message-State: AJIora+E62ipSpcbA5NFQLUl3PMgtlogafAfY4bYqlafksQjFxOwroDz
	cF6D0aYGUbpFC6l2TGAB33Sgj93ATjRKyckT
X-Google-Smtp-Source: 
 AGRyM1s6l/t/M/mYF/kyShdEJKlnNijBpGTeMqYMIsJ+xwiMfHzqKTk4egw+99uexWvSAPxhXWJbgA==
X-Received: by 2002:a05:6a00:2495:b0:52b:7a9:9c72 with SMTP id
 c21-20020a056a00249500b0052b07a99c72mr1168238pfv.46.1658513653928;
        Fri, 22 Jul 2022 11:14:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 a17-20020aa78e91000000b005254e44b748sm4193689pfr.84.2022.07.22.11.14.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 11:14:13 -0700 (PDT)
Message-ID: <62dae8f5.1c69fb81.a2552.69f5@mx.google.com>
Date: Fri, 22 Jul 2022 11:14:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.251-cip77-82-g10c370b53152
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 11 runs,
 2 regressions (v4.19.251-cip77-82-g10c370b53152)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Jul 2022 18:14:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8890

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 11 runs, 2 regressio=
ns (v4.19.251-cip77-82-g10c370b53152)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.251-cip77-82-g10c370b53152/plan/ltp-timer=
s/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.251-cip77-82-g10c370b53152
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      10c370b53152e01c8282be083dc0943e33d50ead

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  bda92ad659a52d38ac810099f69adff626b064c6 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/62da583a1454fa8b22daf05e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig/gcc-10/lab-ci=
p/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig/gcc-10/lab-ci=
p/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62da583a1454fa8b22d=
af05f
        new failure (last pass: v4.19.249-cip76-57-gef3cc1b9e556) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62da65e5ee6dcc6b29daf056

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62da65e5ee6dcc6b29d=
af057
        new failure (last pass: v4.19.249-cip76-57-gef3cc1b9e556) =

 =20


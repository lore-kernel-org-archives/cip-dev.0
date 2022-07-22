Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60FDCCA48C
	for <webhook@archiver.kernel.org>; Fri, 22 Jul 2022 18:14:17 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web10.11205.1658513654287469788
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 22 Jul 2022 11:14:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=4yrtyvLd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id
 q41-20020a17090a1b2c00b001f2043c727aso4883924pjq.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 22 Jul 2022 11:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=sqf5fZpk8kH+JjSZ5mUaALMs5asJPUUutYRm5OWMxiw=;
        b=4yrtyvLdi416LTsOhvo6RJNYiDOydJcqLwxoyZRGqwRODRNjRAGxnkqPQRIiGMHyL2
         bb7Q9dte+CNJl1KcKsLKpf6moLZBbBGZsLvoQde+gh/f29LS1MI4TA7Zc+m5UewBFLP1
         bwBDt7OQgHje4Giju7frg5XfdSu6RSYMMHfjrX/jQMtLyvmhsW4qC4+gIh5Hu7UyLayP
         E2GOGYN5aIKES9mTlqgOauH6quvnVv7uvwiKTlC0zk9UauK/Q7wVPPDbRoWoFfnFeIvq
         nbxTmhNOVSV1TJeIANM5dJxiP4wogcyHVo5H+daujni+pM1667GszksQHjjFcp2cCYxY
         7Vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=sqf5fZpk8kH+JjSZ5mUaALMs5asJPUUutYRm5OWMxiw=;
        b=i46NbUDIENbn5iWL95gS/ltl1AEN+1R1qTl3ITThy3GR6F74AyNA4OKxQHbzyj3HRx
         EOp9v2NuUx5cCtkhk48+4bMn8syw5pjQWHSU0dzGX39zaZ9ubr4TD6aTMl59Kj9cMxW5
         8MFvyFoXwDLvzLLktJVk+tCNa04rBzgqhXS1boP/uJ7ARHNdgXSNJ2Z06cyi7wgdRQyG
         gyPQ/vOJBcHGdlpBT1BlGjDZGa4kZjbGDSW5SlfLzDgyS6Cd3Bg7z+l974qmfbjkyTis
         lG5wBUdHSPSLLPEIITxWw0rHJysU4xp4+Hiuczihi082AsPzp/SLh9btTmSUy2aeON2y
         ufaw==
X-Gm-Message-State: AJIora80myMX764pa1AeAMlRQKe5KSz0KfteIIm9h7QsNsXPBNcO8AmO
	Xh7KRlW3JdZtXMq4edRmWJ9ADrtTG1neriXG
X-Google-Smtp-Source: 
 AGRyM1uj1cBxjNBaQAg2zxBm8nenTClU9zfNEsPTmzlwCusz0Vlr6hu3MCM82i59BfC6BXsXKI5XMA==
X-Received: by 2002:a17:90a:4402:b0:1f2:3507:5f96 with SMTP id
 s2-20020a17090a440200b001f235075f96mr917521pjg.22.1658513653598;
        Fri, 22 Jul 2022 11:14:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 dw15-20020a17090b094f00b001f2157fdfbbsm3753733pjb.19.2022.07.22.11.14.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 11:14:13 -0700 (PDT)
Message-ID: <62dae8f5.1c69fb81.eadaa.615e@mx.google.com>
Date: Fri, 22 Jul 2022 11:14:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.251-cip77-82-g10c370b53152
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-pty: 7 runs,
 2 regressions (v4.19.251-cip77-82-g10c370b53152)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Jul 2022 18:14:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8889

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-pty: 7 runs, 2 regressions (=
v4.19.251-cip77-82-g10c370b53152)

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
Flinux-4.19.y-cip-rc/kernel/v4.19.251-cip77-82-g10c370b53152/plan/ltp-pty/

  Test:     ltp-pty
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


  Details:     https://kernelci.org/test/plan/id/62da596430ae360decdaf056

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig/gcc-10/lab-ci=
p/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig/gcc-10/lab-ci=
p/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62da596430ae360decdaf0=
57
        new failure (last pass: v4.19.249-cip76-57-gef3cc1b9e556) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62da61494fab8f1964daf06d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.251-cip77-82-g10c370b53152/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62da61494fab8f1964daf0=
6e
        new failure (last pass: v4.19.249-cip76-57-gef3cc1b9e556) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FA8C3F6B0
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 16:25:01 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web09.211.1659543895631456205
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 09:24:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=N97Ufsgw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id x23so8208843pll.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 09:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=daJDvWXwXr5DPi0p9UsvLoziWUpNYuXyg/vr39oO1mM=;
        b=N97UfsgwcoVo2izgqyMKd0dMVdtzTEkHPlxU+Cu8DGJf2yui7GWxXiCMYkVvPL8Vam
         RIjp0X1PTAN9PHe5mTL/QfyjfaJtQBpg5ZG0qmXju1Nr2HfKHDmb3VNPx6cFjbXZ2WU+
         +x3mjL2VIc9rmviPl/lL/SwYBJUeCvSSruDFhzsvKBumWIyM35BcOuosAVrRnAVtOCqX
         VZ6+89FqILuZ+jmoa1g3/h9Mj4MX1JPSIooWqM5ntvcYbA0f/ojeG2Z9l18kyn9WN2J+
         4VgX2aBljML1twR2cPTzte0atDokSsrwYywS8uRNkrWZ9fe5EbkmfyrEQ9bpy0uFSqPH
         /ABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=daJDvWXwXr5DPi0p9UsvLoziWUpNYuXyg/vr39oO1mM=;
        b=hk5buDKoN5i99UlPYPvfGUTF9fxFK83GKlGlYw19zOzzth14eb8iE+OTiAvqXH4qC9
         mfbQIlJuXCx2uKCBtWNki9g8czGz9RT0+G47dlZjTgwFa1yM+cJ73DJWixfYmFvj2oTb
         N2Kp+DHHtvhNDptV2TSP3RR/UF2cq0D9VCVutK6Rgi3LcZxBc3SVP4VjLRNRqFvn0qjw
         hXSophhDFOqW4V/Y9SNC3WxLRBFP3Fz18WQXKRv5kiK0gNE3ey60g2Rb3KB7nB0rtf74
         JOK+0vUfD/4NNvOQ0FJ0xlod4FOc1FlwZ6ty8/YQLJVRRhMGJfEtvTtb1oJAQOcC4ot0
         DvCg==
X-Gm-Message-State: ACgBeo0OJ93uGbchBMzT4IvE7cLbIQ5aqKsmVQH+vzoo2IbjuVivqkzX
	IVrdSxAbJKKmoyRBtlBUI9g9HyLWy8QxAnZ1aJE=
X-Google-Smtp-Source: 
 AA6agR4ZNrfPk+jA6vYERFA/aKKy7Xvr0SrRfQ+EC6dSkoStBBgv7XfkQU4gQVm5MdW5ERRCvTnXFQ==
X-Received: by 2002:a17:903:1110:b0:16b:6968:1d08 with SMTP id
 n16-20020a170903111000b0016b69681d08mr26792067plh.3.1659543897875;
        Wed, 03 Aug 2022 09:24:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 m68-20020a625847000000b00528c3ad8e09sm13290614pfb.66.2022.08.03.09.24.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 09:24:55 -0700 (PDT)
Message-ID: <62eaa157.620a0220.bb78c.4c95@mx.google.com>
Date: Wed, 03 Aug 2022 09:24:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-431-g420b8f43ddc46
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 11 runs,
 1 regressions (v5.10.131-cip13-431-g420b8f43ddc46)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 16:25:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9068

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 11 runs, 1 regressions =
(v5.10.131-cip13-431-g420b8f43ddc46)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.131-cip13-431-g420b8f43ddc46/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.131-cip13-431-g420b8f43ddc46
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      420b8f43ddc46ea18870caf6aa2052c5602729a5

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
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea9a0262242d1e55daf065

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-431-g420b8f43ddc46/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-431-g420b8f43ddc46/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62ea9a0262242d1e55daf0=
66
        failing since 27 days (last pass: v5.10.126-cip11-1-gc5218dc69ff1, =
first fail: v5.10.126-cip11-116-gef362fbbff528) =

 =20


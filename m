Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DDBC6FA86
	for <webhook@archiver.kernel.org>; Fri, 23 Sep 2022 19:11:49 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web10.665.1663960305227951105
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Sep 2022 12:11:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=ueLWVvV+;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id
 a5-20020a17090aa50500b002008eeb040eso8245159pjq.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Sep 2022 12:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=CL3mpkCZJ+if3mFURzz6xt03UmnOIZMzoztm9BHkjfg=;
        b=ueLWVvV+AI3c5VvEMNyU8rK0CzoHlRtSJb7VDJz572vdQwwDYO6o0G8kdLuaiJg429
         PJxLRxErrcI9EIJcLJQDpMzel0dTQMPkQCR5vib0tSN6mfzjbMXHA8d3TM5PuzyLlVir
         iPVivFc9Pf1qb4YWdDv4LjMRVsODPwNk+2sf9k6tE7YBY2s5PpQdJGzZMBijTqbhtbFx
         R92qMO7UD+kIeUctgoVqyW0ZFQrKICbg96zJGZr1tdlYCNDgbfqE1+SU83ougJsE4jw+
         qxGSvpWgMV4V+FNXOvDOWRQUc1LKnzV9eeD3cX6F2xcEH44Wr5aamAHhc8SF1VUBGLKd
         z8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=CL3mpkCZJ+if3mFURzz6xt03UmnOIZMzoztm9BHkjfg=;
        b=3UNefacv4henc41sicdO1mijERCKkCqxviHwkd6HRdLr4vMMTjtUEOKiIcWEDBK9x4
         oWFPbXMWP68wiFB8aqe7QpzPgWcMLSWt/RRODgGuia5lyMWYRRvMVOKqKA1lNK3sMiuV
         9O92PIDVu5dPENe3F/CAoUR+gp+HElqTaz1e6YwNVcCWlmwFvhQwHqqW4sD2oRZ6NB73
         qmSPiqbJRzuBuLUbkJxzxSBQfK5BL7r0Jl+tR9+5oZQrrL/rLIjnMxb012JtmZwY4Vgr
         mJ8HBhyqiMcSqHLz9/pCCujvIQR3cBEEHHG2IifRjA33FeBi99sE1tGpfKVjLdgtQ+PV
         f+6g==
X-Gm-Message-State: ACrzQf0RsMyMDbyy22WI1/rvw1E3f7sCYimTOfwxCCT41sq6IpmfSu73
	ZVSwxKO0RVrzco0VeZ3zUsCHsdYbnP+/YnGe+Kw=
X-Google-Smtp-Source: 
 AMsMyM5wuFT+WRnXKaLmiEqRjwPbQWD3zCIeQ+VqMff07bmqjWXnI/xOhEQnnX/MP1T5nj6tKargSQ==
X-Received: by 2002:a17:90b:3889:b0:200:8255:f0e5 with SMTP id
 mu9-20020a17090b388900b002008255f0e5mr23056072pjb.51.1663960304205;
        Fri, 23 Sep 2022 12:11:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 k11-20020aa7998b000000b00537d60286c9sm6777603pfh.113.2022.09.23.12.11.43
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 12:11:43 -0700 (PDT)
Message-ID: <632e04ef.a70a0220.7a176.e16e@mx.google.com>
Date: Fri, 23 Sep 2022 12:11:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.140-cip16-261-g8fa62effa305f
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 8 runs,
 3 regressions (v5.10.140-cip16-261-g8fa62effa305f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Sep 2022 19:11:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9543

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 8 runs, 3 regressions (v5.1=
0.140-cip16-261-g8fa62effa305f)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.140-cip16-261-g8fa62effa305f/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.140-cip16-261-g8fa62effa305f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      8fa62effa305f81a2f52692a14ee690927819830 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/632df49ce1d02c865e355661

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/632df49ce1d02c865e=
35566d
        failing since 80 days (last pass: v5.10.121-cip9-287-ge9094c8446fc,=
 first fail: v5.10.125-cip10-119-g603acbe1aceb)

    2022-09-23T18:01:53.820968  <8>[   12.294493] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/632df49ce1d02c865e=
35566e
        failing since 80 days (last pass: v5.10.121-cip9-287-ge9094c8446fc,=
 first fail: v5.10.125-cip10-119-g603acbe1aceb)

    2022-09-23T18:01:53.802952  <8>[   12.276222] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/632df7eb3a904d3ba13556a3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/632df7eb3a904d3ba13556a4
        failing since 133 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6=
, first fail: v5.10.112-cip6-289-g2969e096d186) =

 =20


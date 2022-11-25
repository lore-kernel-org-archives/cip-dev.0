Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AC9C4167D
	for <webhook@archiver.kernel.org>; Fri, 25 Nov 2022 13:12:18 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web10.46764.1669381935514009948
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 25 Nov 2022 05:12:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=JG3FvJxO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.172, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f172.google.com with SMTP id f9so3930878pgf.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 25 Nov 2022 05:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KJX8qriHyL3F+m6F/8EqVh2AVH5nBiO/v67wfQWJ0oE=;
        b=JG3FvJxO1b99xc1PQfUakXMgL4DktQI0mkoREJw1KMwsdvFte6bmWT/i82jkN8kOAw
         V7qNADBEuICxTOqHeH+GcZ0vkVLfROoamU8EgcuN0KsniGMyaJMT36DZvg0FyCFM4BE2
         GVglXTPtoHNtOo+qUS7lgud1wdLPzxc3EbIxp1oPVqBeMUlmkNefSEmIvD/NJSFKFY/T
         c1Jh6VIMKC6DmAL0HCaEw/f8UweaZ9099+3mKH3hDjl6rjhlw052hGkPeW0eBJhuFYY2
         NV32u6MVLQ1fcvErNtlIwD9hfR3lzFRoOdlXmXfJDQg+DFblTUCZwK+fBfvRKCmFIYYT
         81gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJX8qriHyL3F+m6F/8EqVh2AVH5nBiO/v67wfQWJ0oE=;
        b=504w20n4HJ/AGLVAkJgFPIPD5QgV20XEqm7GSQLVMRaKBMZNgeHiJu4wZeBDO4cHA2
         Y2m81lPrbhyOFseynnYDqqORGV8PDjoNR65yLwMo9e9I2kE0t+O5CYM1EwRgUDYC2kZq
         rGebQjXBctFYq8DpmXXsmr3C7uKubmPlzICLx1ekxGrcfDbnVq1oexW7/DJTK+fohTGC
         9hSu1UzuXZYuDrtW2piI0e46xZB/o1T95KvH/FJyR52Pt4uliDMih4431QTuf8yCKVVz
         xi4JZcxOICCSiEJDiDCraxpfdEGOYrMLNDA3PdG9+SfheGW7dAIFyyiQzMIKfBU6ovz0
         w7DA==
X-Gm-Message-State: ANoB5pmrS4u9F2vdwxy2d2V8KtrwkbDB6fsY+lj3GAJUIwEHMxtERLmW
	I2R+qNizatGelj0WUsnLgWDKqSlAwJ+L74L8OaQ=
X-Google-Smtp-Source: AA0mqf7jy+/sVrlnV5EOxSrrB2vr/tUUtEWfMzpmnHkPRjGw9itkHDJK9WRapQoMMLmk3QebgAPWZQ==
X-Received: by 2002:a63:1305:0:b0:470:4522:f32f with SMTP id i5-20020a631305000000b004704522f32fmr35493287pgl.114.1669381934687;
        Fri, 25 Nov 2022 05:12:14 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b23-20020aa79517000000b00574d7111c99sm128214pfp.195.2022.11.25.05.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 05:12:13 -0800 (PST)
Message-ID: <6380bf2d.a70a0220.4e021.0291@mx.google.com>
Date: Fri, 25 Nov 2022 05:12:13 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip70-236-g69445bc0d420
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip ltp-pty: 3 runs,
 1 regressions (v4.4.302-cip70-236-g69445bc0d420)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Nov 2022 13:12:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10111

cip/linux-4.4.y-cip ltp-pty: 3 runs, 1 regressions (v4.4.302-cip70-236-g694=
45bc0d420)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip70-236-g69445bc0d420/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip70-236-g69445bc0d420
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      69445bc0d4209b0634d1f43657fd58f708cadf81

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  a15eb3cdfa3556203167572e15754f1f59ba26bf =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6380b8a62bf8152a852abd58

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-236-g69445bc0d420/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-236-g69445bc0d420/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6380b8a62bf8152a852abd=
59
        failing since 133 days (last pass: v4.4.302-cip69-296-g52de9431d314=
, first fail: v4.4.302-cip69-508-gd887d54a1be6) =

 =20


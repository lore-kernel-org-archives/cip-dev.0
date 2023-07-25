Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC952C0015E
	for <webhook@archiver.kernel.org>; Tue, 25 Jul 2023 21:08:01 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web11.853.1690319277173191782
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 25 Jul 2023 14:07:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Cd3Z++4+;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-666ecf9a081so5538118b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 25 Jul 2023 14:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690319276; x=1690924076;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=28NY+Rt6ac96yyazA9mYGykO6c8J6tkRRYjlyx55Gsc=;
        b=Cd3Z++4+ZFWEj0iWekL6jQfKEs+RSMODDOHGL+NkwBzHjGuvTG9q8hGHNVCvJP4DkN
         mhcMK7BXXu1Ekd8hBoEP0vO820IsGfjIBfB+65060s5i3EDJPT4gpILM3Xq3bOsq4TvJ
         YO3ipuMkMf/SmIK+aNvt/Wg0bhXkYdH83ifP4qU1W+rYtyeSDYsOAOvyM0FLtOZnMWHI
         BeN04/mjstIg2eKC7wvFOd2PwThkMIYaUtACgS6PENxk7bzfO9TJ99XEezn8E0kmaq3F
         CPItw2lCsrtTp+EMGcDJe2hjXfKqgFXx6WB5ucRUZH26TrLeTNXG/4oYKWBDpIRWmyKA
         LM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690319276; x=1690924076;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28NY+Rt6ac96yyazA9mYGykO6c8J6tkRRYjlyx55Gsc=;
        b=ZuoXD8iRZIbUZKpUg0p6ZcFnpUCtpiP5GlcAZ/3oG58E1s0nDIklQ9RrI77nXeC5LE
         iguXL9cwneUVpL1KPPQCOUk6UQiBkHDKiBHwapJWpq4TtKY36W0/mWQF0AAc7Y1Z5Cfb
         Q2aykzfHwaRZNE9ebw4MrPS+nBF58vkYVtfEHRMJl1wdFzIMZ/nriNNxTqkE64EOU8Tc
         pJmkMw259O+PEZzZhGdq1fpvMH4ANoAsCV1JkwbSzb2vGliHyGvP/nQ0+YTZ1YGPwuGI
         +i+NsFKJqNUljpRDgWT3IXuVIaWyaUdWxdQKbCx3fiIKiuZaRO65ENgiHsTNKDAf60/K
         dHZQ==
X-Gm-Message-State: ABy/qLYjWt9bGTgeDdOR93kPsXmHvNm9GkrX7sjc0zrVNyx23EdXwen1
	uSvHlwDRk9c8t17KowHITKA0cIQZJiviQ+10TOQggQ==
X-Google-Smtp-Source: APBJJlF7P6wHLoPd0LS6i/q4Cq52fMqEAtfECAvhC3I5xqCCGyxXTv/uqkTdDtPie89Xp30dvlTFcA==
X-Received: by 2002:a05:6a20:728e:b0:13a:59b1:c884 with SMTP id o14-20020a056a20728e00b0013a59b1c884mr216929pzk.40.1690319276243;
        Tue, 25 Jul 2023 14:07:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m7-20020aa79007000000b006636c4f57a6sm10089836pfo.27.2023.07.25.14.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 14:07:55 -0700 (PDT)
Message-ID: <64c039ab.a70a0220.f42a7.32cf@mx.google.com>
Date: Tue, 25 Jul 2023 14:07:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.186-cip37-12-g2710acbceb751
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip smc: 3 runs,
 2 regressions (v5.10.186-cip37-12-g2710acbceb751)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Jul 2023 21:08:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12505

cip/linux-5.10.y-cip smc: 3 runs, 2 regressions (v5.10.186-cip37-12-g2710ac=
bceb751)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.186-cip37-12-g2710acbceb751/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.186-cip37-12-g2710acbceb751
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2710acbceb751c864f5fbbd3521374e60d9802fe =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64c028881ff4ea20e38ace3b

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-12-g2710acbceb751/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/64c028881ff4ea20e3=
8ace47
        failing since 386 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-07-25T19:54:36.909208  <8>[   17.334899] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/64c028881ff4ea20e3=
8ace48
        failing since 386 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-07-25T19:54:36.895702  <8>[   17.321310] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20


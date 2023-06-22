Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53228EB64D7
	for <webhook@archiver.kernel.org>; Thu, 22 Jun 2023 02:34:53 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
 by mx.groups.io with SMTP id smtpd.web11.1177.1687401290980025115
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 21 Jun 2023 19:34:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=t231+Cq0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.180, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-39ecf031271so3312786b6e.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 21 Jun 2023 19:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687401290; x=1689993290;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MZ4vCT/Z0VVk8aFTbFbkAUOEzGjqo0pwZ9jhlbV7KfM=;
        b=t231+Cq0DqvW3dD/AhlMmvsowNUceQU/HyUyorWJIFUWJiNjBzc6Qz2JiDc+yIF1z/
         IkI0I+r3t8kgf1DeMZUc+x90RYO3TDjglAfXyl8PAcUQaLfJ5a7zvM705oenDetEXfts
         Td3JlhJFrHXRvwmmaV0JEPnKJ3A3Du4i1hpIqI9YQONqkCot9HlEEt1+ObJQpCl2MxfX
         xMWWDLdgIuh8OiWVTFJPsUq1vJQZuZZd9a2KBg2SeuaJSkd+HypfLC8tb9UOOMI2maoA
         EPG6XcUchdfe+OL5kKYZq4fqcULJlg4TsSJF7GGrnGh7+ThJtcEBJ0mL5YSGiXsZ9sGZ
         6LAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687401290; x=1689993290;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZ4vCT/Z0VVk8aFTbFbkAUOEzGjqo0pwZ9jhlbV7KfM=;
        b=L6i7URk8TZc8SgSmM/IdYEvRr/cpJ2imu5Hl+Xa5dFI6L33tbACXCH3ROvweb3Ee9Y
         urhrS9n+p57A9uMHm+9fOlvpf3JcNhhlysyUQnwHQ6Tk62zJCfHYLitFbacBn5hU+mzU
         HroiiBtaed7Ocj/qOQ3lCpsVqluX4Z7j527Tz2AF+MAkP195HJPajDopcvW7j6EQlwUv
         np7yVwsJf7iD0HCWlJ5D6hOZpNK18sGHazxloKE/iC38j/PPwnYugul0aJXTAsEU/9fm
         g4JXrs1VTxrzKkCmlSyky5iPTmfA2dSsemMfqNgTV+P6H/UnmkhDwnyvzsLxfpBTeKhV
         euNA==
X-Gm-Message-State: AC+VfDw29kockIJ5hteVKPF77bOOmLMNsWUPD7VxTTVa1sfMINurzs68
	Z2rdMwA+hW8Od6QldsjH6JZAsyco1S+BXrZdoQ16NA==
X-Google-Smtp-Source: ACHHUZ74D15Up8NJA+fGU0HL3CucyC28rxxt2wFoVvkvO1hTRvn7mRv6Ula4VVuR34G3MkEJBYeYaQ==
X-Received: by 2002:a05:6808:f8f:b0:39a:a86d:2f32 with SMTP id o15-20020a0568080f8f00b0039aa86d2f32mr22044942oiw.6.1687401289859;
        Wed, 21 Jun 2023 19:34:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090a280400b0025c09577ce1sm10434791pjd.7.2023.06.21.19.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 19:34:49 -0700 (PDT)
Message-ID: <6493b349.170a0220.f6574.5657@mx.google.com>
Date: Wed, 21 Jun 2023 19:34:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.184-cip36
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 1 runs,
 1 regressions (v5.10.184-cip36)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jun 2023 02:34:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12108

cip/linux-5.10.y-cip kselftest-seccomp: 1 runs, 1 regressions (v5.10.184-ci=
p36)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.184-cip36/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.184-cip36
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f34f3ecd0387c3ad8b34bf65ac19ec84a38f2333 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6493b0aedb89d9d78a306131

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-meson=
-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-meson=
-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230609.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6493b0aedb89=
d9d78a306132
        failing since 12 days (last pass: v5.10.180-cip34-26-g462b2292d23e6=
, first fail: v5.10.182-cip35) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E09DC7EE22
	for <webhook@archiver.kernel.org>; Wed,  3 May 2023 10:01:19 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web10.15165.1683108076569480516
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 May 2023 03:01:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=SshcdEEt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-643557840e4so143241b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 03 May 2023 03:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683108075; x=1685700075;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ox7n/d4XNiclU+fmOKXLmnIxm5LSNvu8cI2kTNcnOLE=;
        b=SshcdEEtJVwwaz5/QpTYY+pel11McfpxSp9i7N2+j8NgxjczBJ0MyrOaeVFShapgxx
         aK42L3pbnlQCSOmN4/bqWVTTTOnXgD/Ox1MhEU4XRNRa5kN3JXWZeDJjPsghhGPk5gwV
         6pqnXYiAGDysQcJRoRg4wYa7QLdLrYhwzCwp1yE5dwImdsHQVkw/vvFhz/MlPFLXiAKj
         nfsNTUaTcsnc/AV3WWbNZeKYFuUSvmZocMU5KQHCfG3X9arnhKFWOQaiD+0bbZCqki20
         +7fnJRl4SsdJWXwFtmQfzQ5kJx7jbvNAyqIt8tl/rdWrIKNWyjAcTEZHcmdfTKnyI30m
         aTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683108075; x=1685700075;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ox7n/d4XNiclU+fmOKXLmnIxm5LSNvu8cI2kTNcnOLE=;
        b=dMDPyaD5+LzcLumduo0QxGDqGLhsFTgNcOdFEanqZQVtw5IlqW6KsZHS3zEGf1kMTT
         gwGS1rFRBT0sLK+mEG5g2KG5C1H4WBCYWiyxf1GIIC87ArlwB4HSqpS+8ZiuhU/zOxIK
         zF3xH3lPNG6k5g3TYNuP897/AUljdMstpUzS92UvGPZ5q1nZTjjsIOZwkAkft4FafIq7
         5vCh3FVimFnty7LMmrWDu+lYb3hkZyDrGDuemrQKciPRLt0u4yKEapsAnnhdjqtzZy+D
         GSAJTiUzHTuO9k4iLiqCOHWeo38bkR7dPpNbwqPus8VPLp3SRlDkkQWKK0D2VCG0yhUh
         4D6A==
X-Gm-Message-State: AC+VfDzeK/z7iesr1rA13TH+keQm0K6TkJOzhGgdj7B9xTDQLEbwFj2p
	fA07sXJa6KEWagFHxYib1MDYRXO+D7L/P7it8mE=
X-Google-Smtp-Source: ACHHUZ61FDMa7sC1Ri2xeuVnif/G5Jm7vzWStBc3DFNQFHQK5rJZgiFohIkI3Qvtj6c9iV5xzBgnaA==
X-Received: by 2002:a05:6a00:1350:b0:635:c8e4:ed0f with SMTP id k16-20020a056a00135000b00635c8e4ed0fmr29274071pfu.11.1683108075351;
        Wed, 03 May 2023 03:01:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j12-20020aa78dcc000000b0063a04905379sm4378855pfr.137.2023.05.03.03.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 03:01:14 -0700 (PDT)
Message-ID: <645230ea.a70a0220.fc363.8e43@mx.google.com>
Date: Wed, 03 May 2023 03:01:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-1186-gb629b961cbe6
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc ltp-pty: 3 runs,
 1 regressions (v4.4-st20-1186-gb629b961cbe6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 May 2023 10:01:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11395

cip/linux-4.4.y-st-rc ltp-pty: 3 runs, 1 regressions (v4.4-st20-1186-gb629b=
961cbe6)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1186-gb629b961cbe6/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1186-gb629b961cbe6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      b629b961cbe64f7960f450588400468813a5f85c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ec58cf9bfb5588e6f831ee55aa6b10ebd790a826 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645224444634e204932e85fc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-gb629b961cbe6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-gb629b961cbe6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230421.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/645224444634e204932e85=
fd
        failing since 5 days (last pass: v4.4-st20-1097-g52d843097a439, fir=
st fail: v4.4-st20-1186-g2516b357b2e3a) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6862DC43334
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 02:11:00 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web11.1932.1658801451191815497
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Jul 2022 19:10:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=4fhTvl8w;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.176,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f176.google.com with SMTP id h132so11936709pgc.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Jul 2022 19:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=CrvIyv1RO5cBOdomNtYj5kpi7YRYIex7WZYMfkOgiQc=;
        b=4fhTvl8wGvXv9GWzdTZ8dsG+Itt5c+2OSkZjrIOp/l+amUtF6FTF9Aq3txJcF+TpPL
         xt0Sbq6CW44ZydAHhSURvW3PDJ/N7xjIwRS4I0DUFF99PuIflqPojxle7aQNxzHNJXzx
         HxhOFKt1VxM9/0t5bhol0wo3Dral7nIXOBdm/mWAF5mRkPR3y4QPLoQLACoVhrm8No+Y
         rn0VQMWU6O2wppc1m8QcGFdNBno+ctWRRq0FjIku1zfsU/d5uulBE1Zyn7BOpj/t/tsz
         Nd8X+tl98RNCFBvdSE3EKliWaD/bcqeB0332N9rtVapXAONPvUHZYUzf5B1XnIZraQtR
         cD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=CrvIyv1RO5cBOdomNtYj5kpi7YRYIex7WZYMfkOgiQc=;
        b=yHAXe6tEyM4D8a/t5MACCZT6jbvnRTST2JcamCmQMWhmtT+1l/OYjXX2K76+QOjAnX
         SWkkkc3qLFSJIhQTU24OOR9ExvVXb0JKSpliYGPxyPtu7G4sM8dGf6PZXsAUDb8DfdXr
         lQ+wp5zd9CAbIbJwcu68EwtBC5AsB+mXBGG2J5vdPqFs3Q84P+7wkuK17LsUaEmyukuK
         KnXKsbgXJDf0d2As2wbemi3jaInd5iQEUK1nG8EgU8Qhb41buX6dwlepsN2SYm9B7LSd
         TF2wGROd9uSchHhCgDR2nLLIW7XBXT1EUo1xB/TmtQqU/SoAY6ub4g07ch/fzEMkGl+c
         FtwQ==
X-Gm-Message-State: AJIora+1HGd8orpfVXxEJ2pa9gotUlRJwBbOABzYaSdqP5YLDzQjenvI
	ajprkQGglZ4nPj7kg9m7gta2oO2Mjdi4ousY
X-Google-Smtp-Source: 
 AGRyM1sQc7an1PP531FpNwYEI5STFPKQeUwjjt9Qui4TlOu2RqX8mdeVyE8ABAQXDMp+ndW2w0SaSg==
X-Received: by 2002:a63:d54:0:b0:41a:dfa3:235b with SMTP id
 20-20020a630d54000000b0041adfa3235bmr9711672pgn.213.1658801450489;
        Mon, 25 Jul 2022 19:10:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 c3-20020a170903234300b0016be5f24aaesm7760910plh.163.2022.07.25.19.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 19:10:50 -0700 (PDT)
Message-ID: <62df4d2a.1c69fb81.b55e6.c367@mx.google.com>
Date: Mon, 25 Jul 2022 19:10:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip69-517-g92709d8ae585
Subject: cip/linux-4.4.y-cip ltp-pty: 3 runs,
 1 regressions (v4.4.302-cip69-517-g92709d8ae585)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 02:11:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8919

cip/linux-4.4.y-cip ltp-pty: 3 runs, 1 regressions (v4.4.302-cip69-517-g927=
09d8ae585)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip69-517-g92709d8ae585/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip69-517-g92709d8ae585
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      92709d8ae585b3c97e359b1323f02c37349ee40d

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  bda92ad659a52d38ac810099f69adff626b064c6 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62df3ab8befd78bcd6daf061

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-517-g92709d8ae585/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-517-g92709d8ae585/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/62df3ab8befd78bcd6daf0=
62
        failing since 11 days (last pass: v4.4.302-cip69-296-g52de9431d314,=
 first fail: v4.4.302-cip69-508-gd887d54a1be6) =

 =20


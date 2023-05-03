Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A899CC7EE29
	for <webhook@archiver.kernel.org>; Wed,  3 May 2023 15:22:30 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web11.22571.1683127347223247164
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 May 2023 08:22:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=D48k53T1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ab1b79d3a7so7292635ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 03 May 2023 08:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683127346; x=1685719346;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x4VnbefgPi/5I0TyiwkUtZLT3yZH5S3iHKzjgOySB0k=;
        b=D48k53T1mVJfzVBBZpJ4hHs9RzEZTjPsMkr3VeXA3stEiVWU5Pc6gb3SHRkze6LOZG
         2C4fJZJJ+BfQYs59e/4XwtUGTCx4hJnx9Un3q5kwWSrsBDIC7TMbRyjPeQfn75sbmZjU
         LIZMgxrMfjmXteA58oKBAiZHHyGfmnNklC2WsLI2eYPtdEH8uBiBUhiopNUMEEv3iLAC
         0eJcHNnNFsgOKgmaSWHt6IndVcez6CeUyJiGJz2AnyT1CjtorrC/4u1ytu4El0JN+mxc
         kEtvqlheIwMrEwpCixJr8INNwFDuztXmKzkXVJL3E3C3YItNhz+4tHpMY2I4C4yd7mnw
         EipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683127346; x=1685719346;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4VnbefgPi/5I0TyiwkUtZLT3yZH5S3iHKzjgOySB0k=;
        b=U7rS/w4Pq2OkvqtZ4Y2LNO3hkdzN6H7hZXK/tNA6tbHrObkGREmpUhhliaYe0SIi6O
         liyoXnzInvSrbyRqVdaNotAbHAFeoD1nRYv47F4wTwo9/uwXRWEOofSjpZ7S9DRG6oW8
         ofeXW/fntaCSRL10KeEmbxh196j5OMGda+to5mnje3pe/nez15bXGE1ZdYLi3XSfoIxo
         dsj27rmOpPCelig3JeYd/2Ik2/fjiYQM64bZP5O2vwvT5CsskLjAskOU96TNDwxf1QuD
         JA+twkFxFKwiF9OtRqKUKEkL9SvyMjm4wk3RXVTEiSUrucZutRbMV8fzLU1L0XkMpIiI
         6drQ==
X-Gm-Message-State: AC+VfDyzwr5biVmLO5ll/R32CClu7/1ZHmH60m9yDy9MRcQgBtjR79hl
	Ffdyr/gkCjTmUJ3z1CW7UXLHP/0kaltGpi/F1Tz6kA==
X-Google-Smtp-Source: ACHHUZ75TrCgIfsLrKd9K53XdjYvm8lij3rMczAUe5zKAXF9or43d6FKN/1wm7MRhdHE8QYul+yY2g==
X-Received: by 2002:a17:902:864c:b0:1a6:46f2:4365 with SMTP id y12-20020a170902864c00b001a646f24365mr395213plt.30.1683127346165;
        Wed, 03 May 2023 08:22:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g4-20020a1709026b4400b0019f3cc463absm21871290plt.0.2023.05.03.08.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 08:22:25 -0700 (PDT)
Message-ID: <64527c31.170a0220.5d42f.c607@mx.google.com>
Date: Wed, 03 May 2023 08:22:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4.302-cip72-372-ga3bc58e64f55
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-cip baseline-nfs: 20 runs,
 2 regressions (v4.4.302-cip72-372-ga3bc58e64f55)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 May 2023 15:22:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11403

cip/linux-4.4.y-cip baseline-nfs: 20 runs, 2 regressions (v4.4.302-cip72-37=
2-ga3bc58e64f55)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-372-ga3bc58e64f55/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-372-ga3bc58e64f55
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a3bc58e64f55aa72a4c70a5e27ee369c025756dd =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645276609fcba6a0c92e85ee

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-372-ga3bc58e64f55/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-372-ga3bc58e64f55/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230421.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/645276609fcba6a0c=
92e85ef
        failing since 155 days (last pass: v4.4.302-cip70-236-g69445bc0d420=
, first fail: v4.4.302-cip71) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64527542f11fa273452e860c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-372-ga3bc58e64f55/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-372-ga3bc58e64f55/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230421.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64527542f11fa2734=
52e860d
        new failure (last pass: v4.4.302-cip72) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52575EB64DC
	for <webhook@archiver.kernel.org>; Thu, 15 Jun 2023 10:38:10 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web10.14940.1686825484708084440
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 15 Jun 2023 03:38:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=IMWmC1o7;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1b3be39e666so5032965ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 15 Jun 2023 03:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686825484; x=1689417484;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Hlvqz0O1UbDk0u48DXFPpZsxb6McuLn1hG6k5VtZNw8=;
        b=IMWmC1o7uSqP0x5x0eOf1oaorumWOlzaPjfJbXiOKTq7dEAvT33btCdDkjMiJKERrx
         QFcaMR7Awu2f72ky54plh8RHNU1EkYF9LW9fdK6WgnKIkjotk16bxXojG3LDlUS5SlZ2
         5hZOxcVg4HUwjpwm3ZelA1K6B+ApG5iSsJESXGAq83V8DTA416C5W4zLyF6O8kDTmXbN
         FgNZYKzKDpdqlx9emqr9AyQ9zoMRlb0EiFwWe8Nphip+wzjR7FO3evt+HJvTENmS9cL+
         bjs0SC0C8/t6Psyku2kz0AVT1bVSlNqDX4IadKzDYU7Ua/qdp6FksAX7AKM7sZrsO1Kj
         /NfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686825484; x=1689417484;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hlvqz0O1UbDk0u48DXFPpZsxb6McuLn1hG6k5VtZNw8=;
        b=lQ8VD94RtySIm5SBY/v3nCfI/GlySek2Hr+8TOGDUF1hSH6bFboFRb+Q7wauyibe0T
         5zBspoYNnsuohNOUvvlJUKgZ0qTBmjvNXwmPatMQ1fZEWqQOjTYo2h5spvi2chMMTUdN
         AEws6bsUiQc31d1YCGrm72N2ifJi44X4YlrWurQ/VnXvPgX0tz9gLbc6PDwp68uUi8LP
         5R6Of7hLdcELtQrY0MoaY9aEVLA0AXb1KdssIXwYUguLR2uaji86b1avzLi0HSovtPrR
         YXRqwGxgW4F4DVMuE0cg2jGblQJhZwuFDYTze3tlWHBwzLeoqfvbpvNrSVctYKLSvJhF
         OF6A==
X-Gm-Message-State: AC+VfDy+BwiLDV5BWja6CIS3HBd20P87PWBVAiZofk5dHduDOLs/ckyp
	f4YnebcG0pFzZN1ETXy7nOwPApfKb0LesOfJyl1zEg==
X-Google-Smtp-Source: ACHHUZ4wXu59nfOyvNuWO1wVTaQQIHbY1un4VLtf2RubG+iGd548RsEwBqFoRfc6pC8SGP2TpAIfog==
X-Received: by 2002:a17:902:ecc4:b0:1b3:c62d:71b7 with SMTP id a4-20020a170902ecc400b001b3c62d71b7mr6177208plh.18.1686825483869;
        Thu, 15 Jun 2023 03:38:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jo5-20020a170903054500b001addf547a6esm13786926plb.17.2023.06.15.03.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 03:38:02 -0700 (PDT)
Message-ID: <648aea0a.170a0220.53a54.c77d@mx.google.com>
Date: Thu, 15 Jun 2023 03:38:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-8-gdba81ae6f2be
Subject: cip/linux-5.10.y-cip smc: 7 runs,
 2 regressions (v5.10.182-cip35-8-gdba81ae6f2be)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jun 2023 10:38:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12052

cip/linux-5.10.y-cip smc: 7 runs, 2 regressions (v5.10.182-cip35-8-gdba81ae=
6f2be)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.182-cip35-8-gdba81ae6f2be/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.182-cip35-8-gdba81ae6f2be
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dba81ae6f2be7f7d87f3a29a8566758d2e0017ae =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/648ad6ccf89df0731830614c

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/648ad6ccf89df07318=
306158
        failing since 346 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-06-15T09:15:32.188037  <8>[   16.955907] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/648ad6ccf89df07318=
306159
        failing since 346 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-06-15T09:15:32.174364  <8>[   16.942192] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20


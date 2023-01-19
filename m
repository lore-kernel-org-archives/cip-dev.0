Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3590C38142
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 05:01:08 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.38510.1674104458989668939
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 21:00:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=g0p9hoF2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id c26so604080pfp.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 21:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/1gRBgxuMEIEntywPJe9s/ACAEwM3RPD9oZzbv0ZdxM=;
        b=g0p9hoF2cr8ZjRkJZsEV3VK770cgpbw920ooazE5ih3KeJtUOKbLMlhaDcLWjkN6HG
         jRSootfp/CGKWP9w8VQbrT0tn2UCo5k6LkN0VtcEK2j5HR7s4qJX2Q7Mcu/OVEieAF9E
         BkI8AgkVkVbQVixrCCdsbN6vgDmRUrdVIa9QwCTr4bwoCBLvUYqbcIDgWnGnoEm5azvF
         lDSYO3vgD2SB76X0D5bjFtQJcX7XPBhy5zdZHZRZJPFZJdbA1SPHhxwyRgNSrwkRWhvv
         AHerqrwoP2gbQhuEAlUoTVfgW46i+dNwZi+Cs3qaosXAnoQIaNrtgoQnRaH2YidDx3WS
         X7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1gRBgxuMEIEntywPJe9s/ACAEwM3RPD9oZzbv0ZdxM=;
        b=tcOP1/EUgZ+nycJ589TJX/p3JaOEeyrPoJZJxlVDbC/6yQvxcTvKbYzt8AnLPtG+O1
         PbKhonPAuHXb/+sHE0RJx3JPiiTY8m35aH2lr7HEOWyuKirn6yj5Ua/Lmb/VHyQm78AY
         /81WzJzoM9NdoS7/1cLcuFqLN8fCrnh3stC2Ms3O1CVmVGJtwGqke2lA4qHkB0YrwCjk
         OvORPHLWFolF64Ue3RmD8ZZiGpKAd4rHNl2I8FxiA5ookKJO6EzDbXWTRaUmQj3KMaTJ
         HgvAWRbLpikt41epeUYkglVHDGxU/UiTYznjfChxOIUFE8of4P4E89aHOQVr0RLTGR/C
         yh3Q==
X-Gm-Message-State: AFqh2koPK6ThtQvV2WIK0qmhIa86kDONVsM+x1HOa5q2wUauYLAGB8yy
	c6/4sdAdXw2hTwL8MTmLp431YTfgSVK9KqnBuhIMYA==
X-Google-Smtp-Source: AMrXdXuyv8FYoSp92oXu06JdF91LrybQXz6IJoBsdw/Su5NuLctiShz4l0hB27wpvAysIPa6aJSszQ==
X-Received: by 2002:a62:1901:0:b0:582:5b8e:533 with SMTP id 1-20020a621901000000b005825b8e0533mr29965713pfz.16.1674104458204;
        Wed, 18 Jan 2023 21:00:58 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y194-20020a62cecb000000b005898fcb7c1bsm18654879pfg.177.2023.01.18.21.00.57
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 21:00:57 -0800 (PST)
Message-ID: <63c8ce89.620a0220.20fc7.f9b1@mx.google.com>
Date: Wed, 18 Jan 2023 21:00:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.269-cip88-rt28-rebase
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 3 runs,
 1 regressions (v4.19.269-cip88-rt28-rebase)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 05:01:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10428

cip-gitlab/ci/pavel/linux-test ltp-mm: 3 runs, 1 regressions (v4.19.269-cip=
88-rt28-rebase)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.269-cip88-rt28-rebase/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.269-cip88-rt28-rebase
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      09932a66d6b63564f8b94b34721b1f2d38ea9575

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  cf59c1fb5f7181453b16171d75654ee9a1216dde =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b74c69ec0d20bb915f08

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/63c8b74c69ec0d20bb915f09
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =20


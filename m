Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D39C7619A
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 08:31:02 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web11.37577.1679473856513652219
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 01:30:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=khu5EBH2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id q102so3334478pjq.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 01:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679473856;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qibYZ/xi0zl14BjcW2kSYFWF0ru8WyTDhW+2otzZNaI=;
        b=khu5EBH2iC3eJlxbMP2T4uIU7RmudWy3NXNhObG4nBIjz94xfGXraGuLqWcnizMJTh
         87RWqYLS6vo5w50rkVCaaC3pHkyQZYQtMq7Oe/x7A+vVJQfVGDYs64tPVS9HQptngsjO
         cHMxMXS+pUjS+Oh7lHBnIWwNJ+J6kfl+RY1dfFdquPMtlEdlbyBCbFFptk161vY7zK+4
         ffUjk8fJ5ajxB3Z4XiHtj+3M01BV3hO6pmlKtMAXIFkzvNaEA+B7rAIbC5ZkDhr+AdLu
         +zwxFW6WPujhzKO6QnWqBe4WXedlUHaJwKRN1uCjXqJZP5SN8R1CVrhmAOlFt8eHhS/1
         CKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679473856;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qibYZ/xi0zl14BjcW2kSYFWF0ru8WyTDhW+2otzZNaI=;
        b=mvicdVlz1WK9/0B/iu62O/UDxKNsQJt9Z4o0wACVVxjKkCNZ5xbyiJvk2CuGt1R8JO
         GRlLd6G3gGdzzz0aLhEIV2J7i4kq8NRCMOXbaslh/yj/351/92gwb9iLnmagiUtsQFJn
         lP5A001+/t7C5EssIOl1UyhPskGh188O+nq96rBqH1Zy2ln2qqhhZGjy0u+RGmYNHclV
         mOqxWOFN3DDlOgrdjlOOb5BGekV4ZyVpLFwEKQmthna/L6z3NG/yRyKxOzeHZojOdnQy
         kd85+fJhrWfg2mgznoBVAcd08dX96bTx+41igD3dE4UIi0J9Ci+wf68eLHlrNAgBlzJC
         pvDQ==
X-Gm-Message-State: AO0yUKWwYQ7tWuZ4x5bVbqhmCY7rXzRLqXJPGQEOd14c6W126WHx/FKs
	nTig/emdACFyk/nArjDxLuhjf4es4AbO21NTMz8=
X-Google-Smtp-Source: AK7set/cJvOKbhfSlR8RUK/ESdQaQJkuhDQDB0YwWvjJk0qvJ93u7vYRjGz34fZTmUQJh2K7hPhL6g==
X-Received: by 2002:a05:6a20:41b:b0:b8:499d:7c9b with SMTP id a27-20020a056a20041b00b000b8499d7c9bmr5017563pza.51.1679473855829;
        Wed, 22 Mar 2023 01:30:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d16-20020aa78150000000b005a8c60ce93bsm9821844pfn.149.2023.03.22.01.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 01:30:55 -0700 (PDT)
Message-ID: <641abcbf.a70a0220.502c2.2224@mx.google.com>
Date: Wed, 22 Mar 2023 01:30:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.277-cip94
Subject: cip/linux-4.19.y-cip smc: 5 runs, 2 regressions (v4.19.277-cip94)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 08:31:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11053

cip/linux-4.19.y-cip smc: 5 runs, 2 regressions (v4.19.277-cip94)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.277-cip94/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.277-cip94
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7027f305d14858b8392890a56cfe71edd50df202 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/641aac5a96bb4a250c9c9506

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.277=
-cip94/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.277=
-cip94/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/641aac5a96bb4a250c=
9c9512
        failing since 256 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-03-22T07:20:52.664862  <8>[   12.065993] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/641aac5a96bb4a250c=
9c9513
        failing since 256 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-03-22T07:20:52.654763  <8>[   12.056446] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20


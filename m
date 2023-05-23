Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851FBC77B75
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 02:01:06 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web11.11348.1684807257872813500
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 May 2023 19:00:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=tJ/EQPls;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ae4baa77b2so48819005ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 22 May 2023 19:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684807257; x=1687399257;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9+0S4U5EFtEcxkqp7DNf9oCIWR55xX5xbbH1PoCziKQ=;
        b=tJ/EQPlskR9yFs6Hm864VfnMhlhw8xz2v241IP++Q6yBbxCPVqRsKB31TKYjUE5p9w
         Ski06mHfCQM/Bt0K4p4LzyQ6q2SRJSRpqtDah/cKMtoL1Pf9YMWOsJCfAO9hjUu7umTZ
         cq23uMb+DZw1/gR2MmGfUZ5+NBDsliQT0JX9MAQ8M1t+XspCrTI4mhIkX33iaLu5QM3z
         gb3O+02cgBo9QlaaaqP4HB0SNabjr2X6sTM9Os5ryeoVXCSIJpRjRwxJVQH/nKSV+YPI
         HuIsJSuRp9PbRFJ57nUqn3jcx4cUmVNCpKSxnJQJdF6rJsdZoum7spl1WSmdASp/mEn8
         KhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684807257; x=1687399257;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+0S4U5EFtEcxkqp7DNf9oCIWR55xX5xbbH1PoCziKQ=;
        b=mBQzmqEVDQBGoeZf/VMiq7HVHuloSJcOCffV1JNsxsUYzC2Vd3hci5nww0JDfSVyMN
         irEIt+Y2qjSju6ktmFegqC58/U2lCJgQ5+8VVCMZYo5CwXCYhmSS6Wh8HeCiKxpWxJtq
         hI8/SfgVrGLUul5jpX97uu8nYhlOFo84XOt2fq0s/cSQwe6ctPn5OB0fDmgNNd9UysVO
         VZD6AQPOyyAk3UoG2LOGtef4zl3HpJ29LPEqMo5OJrBNjoQQLKJ/VWsH/8Gb2SGVpP60
         ZSQ7J3MniqY73StQ1iB50/OBxNU83kz2mgUzzMhdqAC5cTNlN9w4J5pXkXBhnSpx4Gw+
         OhWw==
X-Gm-Message-State: AC+VfDwUwXsZ9Nt3/R8EJBPUGOfW6SKLWldNXpPzvXdJhU8r4WQAvAFW
	AqOb08MXVYFrte3dv3679FMTMzDSP2zMMsN/xMD7+Q==
X-Google-Smtp-Source: ACHHUZ6UtoTl6o7e9gtqqHpV9y7QT7jIgW7PXT13nhau9ZwXgI99q8l4o7voOWF23VD/+ZjkLEvTKQ==
X-Received: by 2002:a17:903:2444:b0:1aa:f203:781c with SMTP id l4-20020a170903244400b001aaf203781cmr15843666pls.44.1684807256934;
        Mon, 22 May 2023 19:00:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902ceca00b001aafa2e212esm5471649plg.52.2023.05.22.19.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 19:00:56 -0700 (PDT)
Message-ID: <646c1e58.170a0220.c2b2c.9c9e@mx.google.com>
Date: Mon, 22 May 2023 19:00:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip33-11-gfea7994097935
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip smc: 4 runs,
 2 regressions (v5.10.180-cip33-11-gfea7994097935)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 02:01:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11606

cip/linux-5.10.y-cip smc: 4 runs, 2 regressions (v5.10.180-cip33-11-gfea799=
4097935)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip33-11-gfea7994097935/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip33-11-gfea7994097935
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      fea799409793527f9b9b2d2c53f0dc4e3ac7ac6a =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/646c10f07594a226cb2e85f4

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/646c10f07594a226cb=
2e8600
        failing since 322 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-05-23T01:03:27.696294  <8>[   17.382519] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/646c10f07594a226cb=
2e8601
        failing since 322 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-05-23T01:03:27.682188  <8>[   17.368922] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFE8C7619A
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 10:38:33 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web11.39103.1679481510252895946
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 03:38:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=BCvNtIYV;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id fd25so10790872pfb.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 03:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679481509;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8sI+YpRYxwBqrKOIzun68oU7qZHprTynrUu9IybKLks=;
        b=BCvNtIYVDTcO/IZz3ZhUSAsrddbUoOzuRDfKG1vpOpsjXs6fQ1JMFR25y2RmrQCDAh
         IBHYARPo8jis2WKYk1ECQGTY45Fyc83m2vum14bw+T2TdpKGsICkpMmWEnfPHYTwOQdn
         f2IbY40QxYVnEV39+OkKbW7b3aUWAo2iw6biZ/pLbV+kSGK5kPQXjXnQ8VHn5tQrgeSZ
         jtxP5rx5esJGMRcYVbywmGSPXIxZ9rMsGGFUxnhGR0Ia6t40J4E7SJDLcT7XP84L8JFa
         GbhSXfYv0os759VaBGmCywz4be9fKmiE4NLnuhVL/OgeAtQYWvrLeKzdRi/m4qTW12Cq
         Lm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679481509;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8sI+YpRYxwBqrKOIzun68oU7qZHprTynrUu9IybKLks=;
        b=ThUhoOE2Z1H+9EcmSbMeFgusccT8/hi20d4AK6I/FRVC61uXp++KKxSXfB8Kf5KZHZ
         AdjYl1x0jhvnt1ZQSKNIY3lMEV/tIOv5ZUvlQnLaFKAav7DKWqFsxEAw/UA4OK9CCVII
         BmRx0KlchS3Z7hRhNPzTS16naouobL5UCE2DFsAxCQgpKR6FeCPQR88wFd5vCmELhwHu
         96dY3GKiAouLKe6Jov37MVO4UZg8nA/VZ0fJQIROfOsNLtwDSMXH0ebndsa1E2oRsXbl
         T4UpA3hc9G/tNtaT1h6FmyWMUHU1Qrz7UfgkbD2ldEbMLm7w2uO/t/XS3I/cuZpBTPD4
         uHyw==
X-Gm-Message-State: AO0yUKW6Cdpk9yKsn4y9mvB9N0PY3yRTKs1KcDQ2XpgpPuPcaZMDTcUN
	M12gCRCPeejphKfS5QLperNO3mAMhXfX/e5VuGi4Gw==
X-Google-Smtp-Source: AK7set8oMOQ0+R7qUKK+J+R/fbHGqYN0jAaPOoSY1a7ByYrqBrz6u2+KaStJ2rz7OmlzvsHmnOEsAw==
X-Received: by 2002:aa7:96f9:0:b0:626:a9b:94b8 with SMTP id i25-20020aa796f9000000b006260a9b94b8mr2541454pfq.20.1679481509537;
        Wed, 22 Mar 2023 03:38:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q17-20020a62ae11000000b005abc0d426c4sm9817853pff.54.2023.03.22.03.38.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 03:38:29 -0700 (PDT)
Message-ID: <641adaa5.620a0220.99c7.1122@mx.google.com>
Date: Wed, 22 Mar 2023 03:38:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.277-cip94-1098-g26d9f86d942d
Subject: cip-gitlab/ci/pavel/linux-test smc: 5 runs,
 1 regressions (v4.19.277-cip94-1098-g26d9f86d942d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 10:38:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11071

cip-gitlab/ci/pavel/linux-test smc: 5 runs, 1 regressions (v4.19.277-cip94-=
1098-g26d9f86d942d)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.277-cip94-1098-g26d9f86d942d/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.277-cip94-1098-g26d9f86d942d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      26d9f86d942d1c22bb7542618e47ea5c0e6b4026 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641acb80635785ca679c95bc

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/smc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/smc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/641acb80635785ca67=
9c95c2
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329)

    2023-03-22T09:33:35.767245  <8>[   15.635017] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E93C47DD6
	for <webhook@archiver.kernel.org>; Fri, 19 Jan 2024 01:32:24 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web11.11600.1705627943311008802
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 18 Jan 2024 17:32:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=PwhLOKnd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d5f388407bso1836165ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 18 Jan 2024 17:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705627942; x=1706232742; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V9xvTywLlQdh0e/Kk57efH13JkL8J5SRFGXFU6/HtnY=;
        b=PwhLOKndkfR1cN6ET6+UgZRoZWGDf1g3zEsgkdvyAIL2NWlOhh7wVZnkwuK7P/uhYy
         z8k7gR4O+VM+M64OrBb433jz0ZsRWHMfTIR/m64h8QCyLQsjcxHMRrKRhDh5UGkZ7gYE
         x/V2qrrD1PlwbPQOKmpgKRszOwC0TN1Ih6Hyf/eG29hgXiFauiR7wytOtOHA3FxqN6tx
         775e1BYCHcocFcv8p+fiK8p29YdiGXYo6/UuesCJNcNU8FTPkAKxkoTXRwHBRUcezYEm
         2C16BwSSABiRI9mDlaNkD4SNxqS/hVi9P3BG3tnTLmNdPXNd6ES3C5aFoLMPoP+yZGc/
         YlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705627942; x=1706232742;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V9xvTywLlQdh0e/Kk57efH13JkL8J5SRFGXFU6/HtnY=;
        b=r9n0vS9ID4STValnGQofkb4i1+YU/t3/T6fqoQJ2GKtwy+iPKcR2YPIkKcTyCFPY/W
         6Lx3pkfi2wkoSKVKtobjPy6E8zA/+BzMOfln+ewZuu2cvNGMfYjUgqfZJdLIDW7cNunL
         clIpoBPt9glMOMVH+A/tfQcSjjgJOZ8IqfxQwWTru33O0JxalixkiS3+Fw3dihCE1XlK
         XsTOHcos/hZFIX0IcVHB1BwJGfrmV005jqTJ0/sxgZ81WeR7j576RqFuOKKYvvWMg27d
         0D0AVmTO1v61hiwVu/1wrukLWTfHRSkbTkAvSQt7K2zpMzQC6Tons2KvQytgW2PBC6PR
         DXJw==
X-Gm-Message-State: AOJu0YzvdTGUufcZgkEm3m8dk0VnNe+aZYUJmx6Uyfu3EmXGieKvjrKL
	h/c6idR7zwTkBAZpewUS6fiAKA9G0+c7c/4iZApSQQCfA6jI8u84ksikkcVQVWiLHUIs0hIFudx
	EWuI=
X-Google-Smtp-Source: AGHT+IFSXawYYFsWk6bTPOu/EnJ3YdKNHONdDfChSs8OwW4en/E64F8sy/zdiA3WmUJmmoJrMZtbNA==
X-Received: by 2002:a17:902:fc85:b0:1d5:13b0:cf0d with SMTP id mf5-20020a170902fc8500b001d513b0cf0dmr2148058plb.5.1705627942104;
        Thu, 18 Jan 2024 17:32:22 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id kv11-20020a17090328cb00b001cc1dff5b86sm1972611plb.244.2024.01.18.17.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 17:32:21 -0800 (PST)
Message-ID: <65a9d125.170a0220.110f9.9ed4@mx.google.com>
Date: Thu, 18 Jan 2024 17:32:21 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v6.1.72-cip13-30-g79e2886a5da69
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip baseline: 116 runs,
 1 regressions (v6.1.72-cip13-30-g79e2886a5da69)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jan 2024 01:32:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14417

cip/linux-6.1.y-cip baseline: 116 runs, 1 regressions (v6.1.72-cip13-30-g79=
e2886a5da69)

Regressions Summary
-------------------

platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.72-cip13-30-g79e2886a5da69/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.72-cip13-30-g79e2886a5da69
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      79e2886a5da69a8a86ec82215b5e9e0748943546 =



Test Regressions
---------------- =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65a9c46bbf6298dd6452a420

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-30-g79e2886a5da69/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m=
1-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-30-g79e2886a5da69/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m=
1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65a9c46bbf6298dd6452a429
        failing since 55 days (last pass: v6.1.59-cip8, first fail: v6.1.62=
-cip9-12-g3a5321f469b07)

    2024-01-19T00:38:26.006813  / # #

    2024-01-19T00:38:27.085416  export SHELL=3D/bin/sh

    2024-01-19T00:38:27.087174  #

    2024-01-19T00:38:28.575168  / # export SHELL=3D/bin/sh. /lava-12571030/=
environment

    2024-01-19T00:38:28.576417  =


    2024-01-19T00:38:31.288465  / # . /lava-12571030/environment/lava-12571=
030/bin/lava-test-runner /lava-12571030/1

    2024-01-19T00:38:31.289864  =


    2024-01-19T00:38:31.299664  / # /lava-12571030/bin/lava-test-runner /la=
va-12571030/1

    2024-01-19T00:38:31.358723  + export 'TESTRUN_ID=3D1_bootrr'

    2024-01-19T00:38:31.358819  + cd /lava-125710<8>[   28.514463] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 12571030_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =20


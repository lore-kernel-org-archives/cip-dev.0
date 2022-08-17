Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBDAC32789
	for <webhook@archiver.kernel.org>; Wed, 17 Aug 2022 11:38:14 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web08.27695.1660736285435186284
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 17 Aug 2022 04:38:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=TxkZdryZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id s206so11755982pgs.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 17 Aug 2022 04:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=Xm41bEb+nbbPOCgcsxxzzCokjZx9B9Dg2hYh84FnVos=;
        b=TxkZdryZ5aRRjU9ubMZQD5usOu2fj5j1X8AZ+8A8olu4eaSXLSbSNPhpeGvwzog9g6
         GZYKVW0z2/Dixh2zLhhR2rQXSCOFpxKXpZZ8mJnemKtKApdIQIvEFyuQIPaFB7fxcVar
         Pf9cl+TgOZHMoEMk0aKwpohqkZpJfSSofFuacuboNET3lWeIQYdPutJk0GTLLZ9sm172
         +uLR28hwpQBPrDx4tNfT66MAIjM5acMnUi8cgSQ29lWcvIew6ifhY59FjuHfaw3yFbpA
         4h0QkOxFKWgFQ9stL+qU9pYfZZIVzg2oOYy9om0ZXutqDsSTM9acU3w3LTp5f4+VL4Xx
         DjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=Xm41bEb+nbbPOCgcsxxzzCokjZx9B9Dg2hYh84FnVos=;
        b=tyPizS44y2704PGvSBbsHY6Au+rG78xr1jyheGFOLtWEoxvRs0oOdC+ptjkOKBxNyG
         YevYbu4xnTR1CtpjddQpr9P4a/cokyafwqJRDfQBdXIxtqvOSbhiOjdpfMRVSXKd9a7v
         fBSfgcwklOLJe/IgeheC9Ev5f3NnKkw21dUhX1oj5ggR/myKyQzm8tjRoCOW4RAB54Ob
         FTGN825lXbL5K2SSKQkew5RtIXM+6kiucxWnh0rZ61YCZKoZ7uo7/cHZWCUHZZlTwIeJ
         YgC+7abpOqa60V9KpVsVnbawPhhsurxSZBb4PfKBg5KTiv1dXqmTQBtouRCGIw1taLDa
         4RKA==
X-Gm-Message-State: ACgBeo0YDIhPloBYEzFr603wJQN/nEa3786cJAKAe6QdKJJ4MCXkTuBA
	T9tldEqAwm0rQVHF/qc9XSKtuUdVzWn1n1Hn
X-Google-Smtp-Source: 
 AA6agR5Eq/aZrA+V1MmQibUhLRhit4YWTmBcXaNFtgFRS88g/2TX+j6PVaq365tMhtV9979o5Jb6Kw==
X-Received: by 2002:a63:85c7:0:b0:428:c1d8:36ee with SMTP id
 u190-20020a6385c7000000b00428c1d836eemr12959620pgd.58.1660736284709;
        Wed, 17 Aug 2022 04:38:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 s8-20020a17090302c800b0016eef326febsm1268172plk.1.2022.08.17.04.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 04:38:03 -0700 (PDT)
Message-ID: <62fcd31b.170a0220.835f7.1f18@mx.google.com>
Date: Wed, 17 Aug 2022 04:38:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-84-g3b53e4dbd9f41
Subject: cip/linux-5.10.y-cip baseline-cip-nfs: 6 runs,
 1 regressions (v5.10.131-cip13-84-g3b53e4dbd9f41)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Aug 2022 11:38:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9273

cip/linux-5.10.y-cip baseline-cip-nfs: 6 runs, 1 regressions (v5.10.131-cip=
13-84-g3b53e4dbd9f41)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.131-cip13-84-g3b53e4dbd9f41/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-84-g3b53e4dbd9f41
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3b53e4dbd9f41171cf639b3ba0b107f6d6f444ac =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/62fccfdd2a1d844f1635564b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8=
a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm64/cip-core-image-kernelci-cip-core-buster-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62fccfdd2a1d8=
44f1635564c
        new failure (last pass: v5.10.131-cip13-49-g1145e9c6352e6) =

 =20


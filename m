Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090C9CCA47B
	for <webhook@archiver.kernel.org>; Sat,  9 Jul 2022 00:27:43 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web08.1703.1657326459601629992
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Jul 2022 17:27:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=BM2raNGn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id o12so372655pfp.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Jul 2022 17:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Z7qH1IFTwaevx4i+qdajIJWXIQQ4xYLSgRrXqQpF8qY=;
        b=BM2raNGnxx+YjWhRcmmgzayg99L/NYPtKKfMPPHUrS6lROBBtIhvWnyNanJxpMPCmd
         do60fLGnSXDok10McSGG8KBiOo2ZB9CoNHZlKxvTpokmW9VlZLtEIP6eLovwQOmq3srX
         iqmcbqFkAF0nFi+cGIF2x5FC5e4D9LM90rX2Sje3h5rwVsA69NAb5qqHPCGcH91BpjVr
         EGurST/o5GRmbuxf92BowpICgbTXyhEW477uHE59itJhKjp7MakpULVx6w3zH85hQzPq
         3YCHPCptl4miKrvqHc9PBGolzH4B08dwFIvoIxZvB69qpJoU4nKukq/WuzzpTl/3JRKq
         O+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Z7qH1IFTwaevx4i+qdajIJWXIQQ4xYLSgRrXqQpF8qY=;
        b=PjrBLQRuueH6tCUTyBOALI8svR/Rn5PvpfkAAvihK+UT0z8LY+7QCPzp+G3mDdNzkj
         KWjXPoqQaiOqDxJfe0jgEF6hxLWqSBk8hc+iwxZgfSJFNgUI3q0oZtXrRnJuAN0yAD3y
         YOHeZ3lpWJ8oP70VUmsyOOCfaK7G6alUkdbxGDshXW5pebFKjHbAvobSSa8ShymY0toP
         dI6Bm9aQu0mzJMsF3rSNvN1GtRYvMWcSAOG4KIjiVZRDl4M2E5CD8hZdNZ7TRx9TL/SW
         PfQHDiUCSbZErxuVAGNki8PZA/yqHnMwmkXqgHv3h6lsOJdzrp666PD/N09AY58L64Os
         WcFw==
X-Gm-Message-State: AJIora+sXMvXfHT1H0itIVdrUPdHVvRyCFcmnION1tepFBrBMyPb6M+o
	eazGTnPQK1AWx3gf1Ez+GyJBx6cxFylWn4Z5
X-Google-Smtp-Source: 
 AGRyM1utEfS/v9CPe5EtTr/DJGNjwcGZi21R8BBtB/IY3CybmiG0HSQJzgJpc/dhLQKsSezOeD1Xlg==
X-Received: by 2002:a63:7204:0:b0:40c:9dc6:57f1 with SMTP id
 n4-20020a637204000000b0040c9dc657f1mr5504344pgc.153.1657326458612;
        Fri, 08 Jul 2022 17:27:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 m9-20020a655649000000b0040c97f0057dsm55934pgs.17.2022.07.08.17.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 17:27:38 -0700 (PDT)
Message-ID: <62c8cb7a.1c69fb81.c09e6.01eb@mx.google.com>
Date: Fri, 08 Jul 2022 17:27:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-filesystems: 9 runs,
 1 regressions (v5.10.129-cip12)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 09 Jul 2022 00:27:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8735

cip/linux-5.10.y-cip kselftest-filesystems: 9 runs, 1 regressions (v5.10.12=
9-cip12)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.129-cip12/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.129-cip12
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      19dd4538e81e4019bc96ac6521af3a4ec93e110c =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c8c9d7aa20032c42a39bd9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/kselftest-filesystem=
s-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/kselftest-filesystem=
s-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/62c8c9d7=
aa20032c42a39bda
        new failure (last pass: v5.10.126-cip11) =

 =20


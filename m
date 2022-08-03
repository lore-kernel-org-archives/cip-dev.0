Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34713C19F28
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 11:43:23 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.7360.1659526997981596191
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 04:43:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=Il2PShU3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id
 p14-20020a17090a74ce00b001f4d04492faso1765323pjl.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 04:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=D9g6GrGsoj9vP4AX3PBcG6rBVwixgRhWFPvIHZyITJw=;
        b=Il2PShU3N/dDbDc7YbfI89gccmWg7qvFHdhqFQbMGBFfnXdiEvUHRxUZU5PHZBxFpc
         eJP0pQshJyhjLcONKViv6BoMxCWmGqfkKjIpV5S1MHBNaA1eYzerjpPaBVMA39XIEd/y
         7Q1FsY2wNoJtBnBMVW+3sR7fb6Xi39+sHRiHQJ/y29hiRwWX/4Pqc1LVa7hpGVKm/VTn
         g3hPYOn+hHtfxdxQgGeAWm5EW4N/2kgwdBC6q/1xe8vbpmFmLoJ8ZG1LD7d8dmHH5yF0
         iUoBIZ7KHsGFKiApLd+06wmHQKQ9aOxBRsuG+hN+5cieEWnn11BGdkfWkpxFAG7Y2Z02
         /DFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=D9g6GrGsoj9vP4AX3PBcG6rBVwixgRhWFPvIHZyITJw=;
        b=Zq7vv9Kceuq5VBqHPlItOf3y7u+isD80o0HnhevsF1EsbFr/P4ZV89yPrlhV/9rgsG
         7Rlu2FVVOMS9EQaPWACK7wgBNPlRFGOAdoGoilfop3Gd+OWYVTX9aDykheZeRhnwVAGP
         tc4k8jFpm/XS5IoakIUagZ5x9Y6xg5xGMdbEhQLsxa1qAELT85ByvtBfreRUQ67NcaLM
         DlTY6O9F+EfMkxwzrcvRNmGxq6RJxKKcKwyCtk2gaPQHrFPdxYClPRh9zG8wjwNsQciB
         t8wUPHNouUNSZ6ojQfP9EZQH2WsMNfEayN+bXBtPBaTWwIWkQkYOPiiznUz9LO99RBdI
         K7Ig==
X-Gm-Message-State: ACgBeo29htobVY8k1hbKyxCOsAKQhEeV8rkujIWRqU2FlgC8Y4r0/BqL
	oeNxbn2t93C/EovhzdmFXmPdwnTAKGUYumCSRAo=
X-Google-Smtp-Source: 
 AA6agR6RhCVnsS2qOoZoH8n7FcsNbxXGBovY+1gXr4W7oZcxH+i/zjYqfsPOCtn6IqJv/ZU5b5F93w==
X-Received: by 2002:a17:90b:17c5:b0:1f4:f55d:24f3 with SMTP id
 me5-20020a17090b17c500b001f4f55d24f3mr4504473pjb.109.1659526997006;
        Wed, 03 Aug 2022 04:43:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 e1-20020aa79801000000b0052d3571a3adsm8184029pfl.7.2022.08.03.04.43.16
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 04:43:16 -0700 (PDT)
Message-ID: <62ea5f54.a70a0220.26fa5.c761@mx.google.com>
Date: Wed, 03 Aug 2022 04:43:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-24-ga6f4ea41fe167
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 5 runs,
 1 regressions (v5.10.131-cip13-24-ga6f4ea41fe167)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 11:43:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9041

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 5 runs, 1 regressions (v5.=
10.131-cip13-24-ga6f4ea41fe167)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.131-cip13-24-ga6f4ea41fe167/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.131-cip13-24-ga6f4ea41fe167
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a6f4ea41fe167f956d4000eaf276a1e383603071 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/62ea58533319f7e263daf068

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-24-ga6f4ea41fe167/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-24-ga6f4ea41fe167/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62ea58533319f=
7e263daf069
        failing since 84 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-260-gb0fe64f485ff) =

 =20


X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web09.6907.1646132186395409058
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 01 Mar 2022 02:56:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Ajl0v0tn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id z16so13869138pfh.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 01 Mar 2022 02:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=hTIqlKfiRIsVwpBFaq0hXUEHbWfBL/ln5czJ7wj0iFI=;
        b=Ajl0v0tn17onW+Jt58pNRr/I1ARXXRW95zknU6m04bNrbk7K5DOysy9yZCj47s1f8p
         aixhh0FW1/+qxZGFjbNZKouJUq6LrFXeWr5pLBpa10RNgjEdB/12tA40ZP+/kTQV9Enl
         iear0r8qa0fvuZGRGYOMrBt4VrkUO4TWRJ83ALxz83evBq5nLS22epD9eUHl5mHuDZ9D
         B7lxtZG4KTNAKjFPJKnE54HDl1GK4mCqx+DPHvnq2wAEKY3IcGb4pqbcCmPIetkhl4wn
         8t3CjFRRzSeHvAkOmg9dsTUCKFU90z7sNDXwMTHlQPAcQmDrNB4jKJyieZfrj9J+GWKQ
         hfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=hTIqlKfiRIsVwpBFaq0hXUEHbWfBL/ln5czJ7wj0iFI=;
        b=58VXlVERrqIPa4F96HxV3o4P4ctsNNyevED0iO2v8PXaDrnUG/5bnFtsW47BqgSx+Y
         QPl+cBgVKYXM7P5x2e2amfWpJndUM6EBlJWfIcqPc6fwWOkdJRFdwCshbOs0jLZl/eEv
         eRShkYZmAF2Y6yLPqUhXgL4UGOQ2mzO+890s0WkGla9x4bOaOnOzflboV34QUQ1/aUSL
         8QPeVm5VLWiczeIfAYvSBy0QJ9bvGajZV17O3jvY0/DqvDh3EwygTMj+D6tFbobUriW6
         qJMEnMNDw29SC+rU8EKo495R8DBbCWnKMWgwuPPzINxACXq1hIKSS+5SLYR9YEO/oKCK
         +2HQ==
X-Gm-Message-State: AOAM5329l6vPK/V9NFlIY0GjTiM0dWoU+rU+me7jyldVtu2k9zmt6bUI
	RIMaRne/rVdXSSnaOLm8TWzCnc0x0ati8qRCKMg=
X-Google-Smtp-Source: ABdhPJzCwECVxfDAOH9WRJnPhC0/r+I8/GQtYMFQrCBgQZT0fo/MouxABvUVomB/UBUn5nTsw9VYWg==
X-Received: by 2002:a63:5d09:0:b0:372:9a55:bf89 with SMTP id r9-20020a635d09000000b003729a55bf89mr21201300pgb.321.1646132185734;
        Tue, 01 Mar 2022 02:56:25 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 8-20020a056a00070800b004e14ae3e8d7sm16185970pfl.164.2022.03.01.02.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 02:56:25 -0800 (PST)
Message-ID: <621dfbd9.1c69fb81.a4925.9998@mx.google.com>
Date: Tue, 01 Mar 2022 02:56:25 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.231-cip68
Subject: cip/linux-4.19.y-cip baseline-cip-nfs: 5 runs, 1 regressions (v4.19.231-cip68) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-4.19.y-cip baseline-cip-nfs: 5 runs, 1 regressions (v4.19.231-cip=
68)

Regressions Summary
-------------------

platform         | arch | lab     | compiler | defconfig          | regress=
ions
-----------------+------+---------+----------+--------------------+--------=
----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.231-cip68/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.231-cip68
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c7477548dcf8c653b00e361f7a724f0b94e7d372 =



Test Regressions
---------------- =



platform         | arch | lab     | compiler | defconfig          | regress=
ions
-----------------+------+---------+----------+--------------------+--------=
----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/621df03605c05dbfb7c62987

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.231=
-cip68/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-cip-nfs-beaglebone-bl=
ack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.231=
-cip68/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-cip-nfs-beaglebone-bl=
ack.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/621df03605c05=
dbfb7c62988
        new failure (last pass: v4.19.229-cip67) =

 =20


X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web09.9980.1648046203497889250
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 23 Mar 2022 07:36:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=KmIemo8B;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id n15so1713044plh.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 23 Mar 2022 07:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=IwVmAJ2mPc3lNxJ//WkwGYrNGo+s+oCF2aXfmhIAf2g=;
        b=KmIemo8BPq9kEQYgmm6ziPcKkxuCkh3nnitH/X+wgM1wi/VmeKYAmmprc+6M3r3gD+
         S/tMc6J75yjEpg9EIUobAND13IxmhqRhp1a4YAjXzUeL9JpbipXJYqNRn+FX2zTaa4kr
         JZihiM8F2dPsZTEFlkbVtTr6i+5CjDUOwjg7Uj3vsZWZKua8rQchelUMTA8JNsNtCDb/
         TCG+Um4ACl3bKoM5AucyGSeGArDUb99rM6WEUWfQuX1PO4z3IvmDRKvBzSd1OwMyR27/
         VFbGrKm29P2u7nPvauZuz9bTZTRpOSdMdX0OaSynsoi/SVR5lsJf7iraH9aFQ5GiaUm2
         exwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=IwVmAJ2mPc3lNxJ//WkwGYrNGo+s+oCF2aXfmhIAf2g=;
        b=Q2DUsB2N6dSyUnILikry9T2mtUHwz0o2/3l3p/pbeFbi7ED92OWbrjopns6EcZ1ByH
         YXQvk0baeA6uIqNc4TKdO15k/7chifSnwO7PlSArFSt0CQKHoIiDEilyXEfqIVjLoNwz
         BMdHLmaI6TMUKJUnoSBI0Zxgavtjxg1kgt0r47pH3WlG+aSd0FijEU2zMw+NI22QEV1O
         ZThUI6KYlA9regAOAHc9Pg2Ss4UPvaBmA7dNoGpsGKU/wdd7y1+cVOr2FsqnGiunrIjX
         Z3MVEISdAU7x4U6dj3RJ6BwtnREZWopAXQMdUeDbeq3tkWLJMBj3vWC29HyyX/BjfN3R
         82FQ==
X-Gm-Message-State: AOAM532aR1mDGP1mhnVrCCSnnVR5XVW4jZbtSggK8EKrXfl2gj/phQUs
	MXAyZKBCrk2TRzC/hjKCIugKMvO5rjJ79OEk6n4=
X-Google-Smtp-Source: ABdhPJwQrtIwOi75rXZKeO7jLJym3WNjuy0wTr5O3DB9GSAGiY5VHyi+BOReBkGRjNnqxd2cEJO85g==
X-Received: by 2002:a17:90b:1811:b0:1c7:832a:3388 with SMTP id lw17-20020a17090b181100b001c7832a3388mr48724pjb.40.1648046202652;
        Wed, 23 Mar 2022 07:36:42 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z16-20020a637e10000000b00382b21c6b0bsm87730pgc.51.2022.03.23.07.36.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 07:36:42 -0700 (PDT)
Message-ID: <623b307a.1c69fb81.3c851.03eb@mx.google.com>
Date: Wed, 23 Mar 2022 07:36:42 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.104-cip3-186-g758e0f22e236
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 5 runs, 1 regressions (v5.10.104-cip3-186-g758e0f22e236) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 5 runs, 1=
 regressions (v5.10.104-cip3-186-g758e0f22e236)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.104-cip3-186-g758e0f22e236/plan/kselftest=
-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.104-cip3-186-g758e0f22e236
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      758e0f22e2369c3d29d49c89c4ab585390c74a82 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/623b239b23abf4fda9bd919c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-186-g758e0f22e236/arm64/defconfig+kselftest/gcc=
-10/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-186-g758e0f22e236/arm64/defconfig+kselftest/gcc=
-10/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220311.1/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/623b239b=
23abf4fda9bd919d
        new failure (last pass: v5.10.104-cip3-155-g4f07dbd2df49e) =

 =20


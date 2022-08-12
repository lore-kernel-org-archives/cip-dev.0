Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FC2C25B0E
	for <webhook@archiver.kernel.org>; Fri, 12 Aug 2022 14:34:26 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web09.11443.1660314860534656451
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Aug 2022 07:34:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=xADrDIIF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id
 t2-20020a17090a4e4200b001f21572f3a4so1099622pjl.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Aug 2022 07:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=VjNRyVD5/1ifnOvHQzKbVUGKMCWPiiY8vQRGhPHjGFY=;
        b=xADrDIIFryZjFtKtHVEzCENtQqSHfn4hV6kFIjbCcA9dswYdZwyl1Dyyla4cDThQf8
         0jFC3uiJK4HWHZUPdkKdC9yWzhZrYzFijCnaNP8lXVG2NkfcyHJNSMiBVYx41qWClR8l
         OiMMUEX7HhLrdF0cA4hUS3lTQ/Q+zqPSuvaWnuBwLpob2+7iiHr38Ky78BPZmddRjg8V
         bzfx2TSuNpYKUa8uqKBVQCL3O3K8qmFkw+go/Tx7oPZqZZ4M5Pntk6a9bDG2XtgJdDtk
         KYrk+EzJ072SHifY2N+ZySuBBS9ia50Pl7wHCNFslDEjDihLqbO73SeKAf4YB7XkQMtK
         0Y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=VjNRyVD5/1ifnOvHQzKbVUGKMCWPiiY8vQRGhPHjGFY=;
        b=CO/TmLIiEiLCEC2akcARDo4l0lhnRIOfa1KY7wA0Kmy68abnakqPEzHIWSWAxRDHtA
         sMXEtwSBxfekY5jDOMviuRNdE61CA2zQid6OWIZkSiAgJmAAf8o30HDhL0k7jjg5ReAd
         51yy4wHUyfJk9aK9+wfoveT3l5EkDZvT2QbNEt4pPrd+BVhmJAlzb2diZ0guxdlzT/hJ
         Y8C7clX4M806bQZrNChyMRkIEVSocOBFSUZZSMY+XYSLDbhRLsgLeBOG832JIxLmV2EY
         4pRV1lQJ3sNzHHd5d/B++Z4y5YoyMIYWQJLx0A+Pi8BoYzZ/1Kb4Y+uBs7FRQ3sB4vtF
         TM8Q==
X-Gm-Message-State: ACgBeo14XEOQfsJSP3+trbCaJT6DwC8geOFyqp9d277bTqxpdol0eJRf
	h7sk/taOotxGWIPQ0AXRvPPsk55lrh1Kl5uD
X-Google-Smtp-Source: 
 AA6agR5SIUi5Cq5FUCiko7xKyJ+DnYGgWGEPm2qfzxK4sfo4NWKMr0rv8Q7WGYuu1JJcs3aiMJlKMg==
X-Received: by 2002:a17:90b:3c0e:b0:1f4:d764:99f8 with SMTP id
 pb14-20020a17090b3c0e00b001f4d76499f8mr4351687pjb.91.1660314859597;
        Fri, 12 Aug 2022 07:34:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 s11-20020a170902ea0b00b0016be96e07d1sm1816830plg.121.2022.08.12.07.34.18
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 07:34:19 -0700 (PDT)
Message-ID: <62f664eb.170a0220.33f38.30b4@mx.google.com>
Date: Fri, 12 Aug 2022 07:34:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-35-gab58aa0904675
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 11 runs,
 1 regressions (v5.10.131-cip13-35-gab58aa0904675)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Aug 2022 14:34:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9197

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 11 runs, 1 regressions (v5=
.10.131-cip13-35-gab58aa0904675)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.131-cip13-35-gab58aa0904675/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.131-cip13-35-gab58aa0904675
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ab58aa0904675bdc00cf17ebe4f1b5aba242c1cd =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/62f65d9e50d413da14daf05c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62f65d9e50d41=
3da14daf05d
        failing since 0 day (last pass: v4.4-st20-74-gc99f2b257bde3, first =
fail: v4.4-st20-96-g74ff989472f09) =

 =20


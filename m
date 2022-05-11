X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.8648.1652254722091650633
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 11 May 2022 00:38:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=vZPQwCzF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id j14so1093458plx.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 11 May 2022 00:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=7HnlSgXp6p1ehhjvgWFKdnZP8kD7e6eyJRXf116o7I0=;
        b=vZPQwCzFg4gAKZ9xhHUwnUeSXj7W2l/4CIj5LLk498aj2O4/dC+LjZCcmgsLfwWQim
         uXzUXRs853eW3CTkfFcJ29ltwZ0A0SuwA3OWsLRwO3f9zdkJmhPgvoBdPIGGcF9iLVl5
         rbgX6sxPOXAfEloWUNek0/ONhIOpXmbOohLAlwUYug+RD3N5l68x8sfYpfM0tZAZHMZw
         9fqUFbJi36vUkTxJ3efhXdoGX+fmdbpf6TnQ4coh89ZJKdr4y6pQOdZaQjkvZFrp53CJ
         ZfBl1YtKPr9o96wEllegXsseEquamlqWUvisSZDGpaCyL3rLGl0xPHs4Q52yEUvfBeYQ
         Ne6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=7HnlSgXp6p1ehhjvgWFKdnZP8kD7e6eyJRXf116o7I0=;
        b=n/6ugq0x1SoZbIkQlDHSRVY4TCNZN0w81yNYvQhBmvY7uOsc7R0932y2/kaDDOY0Io
         6xN00fCdBfjd4jyTPJLHGaWZ2vVzWoyY96lCweyv5BIxNAGstGH6iLBJ4uBHGSH7TDzc
         gioOtijNCWSOnjs0SWGPu277x3RWRzOh9RmxOqyYS58gM6nrwbccHux/HmXlqXpH3YLj
         l29qcDATO5swnqaCmbu8B/O0lXQDihJvUpM69yOwcwYJ+fLJq0t0m/B2RFxtNs2TzHOm
         ndxeRZsaanYyL0Uvi8hzgrCmz3pT+l/YCWsTMe2tdP4V9BwIO4ehpqdN3C4jaDZJcQzw
         DkCw==
X-Gm-Message-State: AOAM533JzOZw1bwGtffKT78DG8TtPw0FfvIt8IVWODyxIXh1DbvNoVHJ
	tLUF1k7mfLVNRzsM5G2XjnPViGYvGC1TYgQ/DL8=
X-Google-Smtp-Source: ABdhPJylXkJ2cThkZT80Gcb7nJMn+8p1bJMm6VERzEn6tbabE+88dJEMS+lnlkYnga1a6QET1yeSeA==
X-Received: by 2002:a17:90b:3b8d:b0:1dc:7637:91c3 with SMTP id pc13-20020a17090b3b8d00b001dc763791c3mr3942699pjb.186.1652254721268;
        Wed, 11 May 2022 00:38:41 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id pc11-20020a17090b3b8b00b001dc4d22c0a7sm1044459pjb.10.2022.05.11.00.38.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 00:38:40 -0700 (PDT)
Message-ID: <627b6800.1c69fb81.ba69c.2841@mx.google.com>
Date: Wed, 11 May 2022 00:38:40 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-260-gb0fe64f485ff
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 8 runs, 4 regressions (v4.4-st5-260-gb0fe64f485ff) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test baseline-nfs: 8 runs, 4 regressions (v4.4-st=
5-260-gb0fe64f485ff)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =

beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig  | 1 =
         =

beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =

beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-260-gb0fe64f485ff/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-260-gb0fe64f485ff
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b0fe64f485ff31f848b40c0d6a9ac286d5b2f5df =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/627b4ec023a888431f8f5723

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-broonie/basel=
ine-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-broonie/basel=
ine-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220506.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/627b4ec023a8=
88431f8f572a
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a)
        1 lines

    2022-05-11T05:50:42.717582  / # =

    2022-05-11T05:50:42.724490  =

    2022-05-11T05:50:47.739649  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/129754/extract-nfsrootfs-jed4ejex'
    2022-05-11T05:50:47.750651  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/129754/extract-nfsrootfs-jed4ejex'
    2022-05-11T05:50:50.041470  / # export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-11T05:50:50.052432  export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-11T05:50:50.157383  / # #
    2022-05-11T05:50:50.164148  #
    2022-05-11T05:50:50.266696  / # export SHELL=3D/bin/sh
    2022-05-11T05:50:50.273516  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/627a8d181259e59bde8f5722

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-=
nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-=
nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220506.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/627a8d181259=
e59bde8f5727
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a)
        1 lines

    2022-05-10T16:04:14.316483  / # =

    2022-05-10T16:04:14.325021  =

    2022-05-10T16:04:19.338393  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/677163/extract-nfsrootfs-3b9ik_8z'
    2022-05-10T16:04:19.349636  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/677163/extract-nfsrootfs-3b9ik_8z'
    2022-05-10T16:04:21.397320  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-05-10T16:04:21.408200  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-05-10T16:04:21.513317  / # #
    2022-05-10T16:04:21.522358  #
    2022-05-10T16:04:21.624675  / # export SHELL=3D/bin/sh
    2022-05-10T16:04:21.633080  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/627b4b644b346ac2a48f5725

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/omap2plus_defconfig/gcc-10/lab-broonie/base=
line-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/omap2plus_defconfig/gcc-10/lab-broonie/base=
line-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220506.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/627b4b644b34=
6ac2a48f572c
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a)
        1 lines

    2022-05-11T05:36:02.694720  / # =

    2022-05-11T05:36:02.700855  =

    2022-05-11T05:36:07.760422  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/129703/extract-nfsrootfs-vdxubxrc'
    2022-05-11T05:36:07.771654  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/129703/extract-nfsrootfs-vdxubxrc'
    2022-05-11T05:36:10.067705  / # export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-11T05:36:10.078691  export NFS_SERVER_IP=3D'192.168.56.230'
    2022-05-11T05:36:10.191666  / # #
    2022-05-11T05:36:10.197200  #
    2022-05-11T05:36:10.311154  / # export SHELL=3D/bin/sh
    2022-05-11T05:36:10.316560  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/627a8bcb02121713f28f5750

  Results:     3 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-260-gb0fe64f485ff/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline=
-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220506.0/armhf/initrd.cpio.gz =



  * baseline-nfs.dmesg.crit: https://kernelci.org/test/case/id/627a8bcb0212=
1713f28f5755
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a)
        1 lines

    2022-05-10T15:58:49.760112  / # =

    2022-05-10T15:58:49.763293  =

    2022-05-10T15:58:54.776348  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/677156/extract-nfsrootfs-38mjnry6'
    2022-05-10T15:58:54.787054  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/677156/extract-nfsrootfs-38mjnry6'
    2022-05-10T15:58:56.960626  / # export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-10T15:58:56.971339  export NFS_SERVER_IP=3D'192.168.11.5'
    2022-05-10T15:58:57.079036  / # #
    2022-05-10T15:58:57.081765  #
    2022-05-10T15:58:57.195770  / # export SHELL=3D/bin/sh
    2022-05-10T15:58:57.198473  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =20


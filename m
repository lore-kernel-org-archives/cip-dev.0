X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web12.1392.1652904673770028075
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 May 2022 13:11:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Rs+eN016;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id x143so3120480pfc.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 May 2022 13:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=NJ3SHKLfaSqk7OyGm+SO8Yq2adN7U1aJpIr+KKAU6no=;
        b=Rs+eN016BTsH6X+PcDg6TAIbl0y4o/5xNolJgXWGNh0e3LAMpVp4iXIQakOIi++mOn
         5AbggXb3SpBssnL70mwD6nrilrJh1zzmvLx6vFK16f8YzKISh1NmxCUgYx2s9gkhnuP1
         PTFGo28PmqkaFTTTIFezfItpsyFHpSLYowowxTRk5fDuxmixXqZ4Vmq+egvzwm2/A8tb
         +cjx7GS2/DfmmFoU3ktehHsvFJBAl5+518rXzuss1XICL/u+X79FRKfIgDFwm/ktVj0d
         LdFjKEFn9hhHGxJx3HhkKrskfUnMB6qv7r0kIeLyrBUMWlVlGzVEK6jN0B3c6lVh0/KP
         SHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=NJ3SHKLfaSqk7OyGm+SO8Yq2adN7U1aJpIr+KKAU6no=;
        b=zp3R6LfWZjDjGt64Ya2R0QjlCYqOwDsr6DiTwpIzQdTBSyEXHk76zknoKjGs6Q+3Xk
         hBQ2gaOuiPZp9FNvFpcssuSSfmI1Zb3MvOJKZzkC4A0zsEe/ToIMOomBm/F+SOfLd7J1
         nmVk61pMEk//QLJRYmcu/4PGIbxklkjEdQv9bYJHIpdQ1xORrs6X1MsKwtQ/5oiikQ9D
         cCeplRb82JEEywA5b2oPyLC5FQXsI2cjld8OFNu9Xf4hMG/tW6Pf8keEbCQI1EbhZd6s
         USg42HmHKtEKOEtPj8A9YUZqCfjco7Et8s+dXZVDNtz0tx2EoTJTo/+fUIkMSIMbUum5
         eRVQ==
X-Gm-Message-State: AOAM533IIhhhNxMblEqXY7kAHfrQLykRGN9uAtIEjSuCLNpCuU0au7IG
	RCEmiy81Zg78ZvPHOjYoty83nZlRkPyu4d9ITkw=
X-Google-Smtp-Source: ABdhPJzGEUaSQii57UfZjRxDy/mQWBa8Xz7xKA3hxj0M8hSu8Pah8u7eQCmOTMXL+fpdlqxkSDgGGA==
X-Received: by 2002:a05:6a00:c8f:b0:510:60cf:55fa with SMTP id a15-20020a056a000c8f00b0051060cf55famr1006530pfv.37.1652904672904;
        Wed, 18 May 2022 13:11:12 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c22-20020a170902c2d600b0015e8d4eb2easm2096642pla.308.2022.05.18.13.11.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:11:12 -0700 (PDT)
Message-ID: <628552e0.1c69fb81.3c60e.55a9@mx.google.com>
Date: Wed, 18 May 2022 13:11:12 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.115-cip7-81-gd05f72e501084
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 13 runs, 1 regressions (v5.10.115-cip7-81-gd05f72e501084) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 13 runs, 1 reg=
ressions (v5.10.115-cip7-81-gd05f72e501084)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.115-cip7-81-gd05f72e501084/plan/baseline-=
cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.115-cip7-81-gd05f72e501084
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d05f72e501084803c8658a71668fc1aadb075165 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/628550fcd29f825c65a39c08

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.115-cip7-81-gd05f72e501084/arm/omap2plus_defconfig/gcc-1=
0/lab-broonie/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.115-cip7-81-gd05f72e501084/arm/omap2plus_defconfig/gcc-1=
0/lab-broonie/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/628550fcd29f8=
25c65a39c09
        failing since 6 days (last pass: v5.10.112-cip6-218-g8253434cd56a, =
first fail: v5.10.112-cip6-289-g2969e096d186) =

 =20


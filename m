X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web10.6534.1649899346181988643
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Apr 2022 18:22:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=dl0Y5PD4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so4180135pjk.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Apr 2022 18:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=mZirlZBkFnBVS0CJfJwkbaXovc1rvyPj1cgfxpqlDoE=;
        b=dl0Y5PD4S8Ux6h+k6rNMsjOQ1J/GAoBL9K5cOEHu4QyBxyzdwbHqjIwPT5XkauqwlR
         Wa+Mw/v0zz1du6gNUJ5s06+iDPGarisfezm6TflcmReU0Twta8KRkqFKWLnEy1sG0AuT
         sNqWoST7dA5Och3S2irDY02SjL7Zq0UATDhtybk5AeyByTB2OABnAWV4XDf9JQKm+1zR
         M+oqI5m9vpwtPN+UaGnkGig+0Bh7s+b56E5lLgyvBCnbnY/tnSAiyUvKEArpjNO25K7P
         jx26/5mgPMfV5BGWSmr8HGEe6eHz/sPJRLZwvSlVliQ3KnNjdF7iYsNq7LFm1grDWFS7
         6w5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=mZirlZBkFnBVS0CJfJwkbaXovc1rvyPj1cgfxpqlDoE=;
        b=MvEDhF0e+fasbxbxR1NK8oMq9VwbnUP3Cz7UTwmXc3AudlEhvY1VfAeiKnXx6vpyV3
         4xZbD02dz915/3CPPupKKp40aXpteW36RYKRExUuLySLUDUTkc0SCMel0C0QFhBvLkFw
         ny78m3WGo2hECbebvq1IU7JVJ1D65Ijr/FQhxdED9hDukf0+FoDFOSwn/6IR1tC6xF0C
         pS+DpUSXb1WY4EGukwFjRG0H2r2tP6re9qKyDVzPtK8P8aleQ6fm6tfMyAPzgTX3O7/+
         e//xvwP4Cq9tramEpvnC8JkJPg6dA7pRFz+lNtuaNGhnnLwjCGz+xP7yUB2V3W4Cd1NR
         RbYg==
X-Gm-Message-State: AOAM530D3EjEZR+bRXOTeG9EktztgEVwMMw6qMzBnNdyqz194yI77Qqy
	VGhuCz/j2w8sf6IcnnB4TYh+LIyDl7r3as0H
X-Google-Smtp-Source: ABdhPJwFJ0TOTGPaPwNQej6zHDlocdMd0jdVcFQ3r18/9XAsmLzYVOGLd+pEce0Cettvx3Ug5OdPfg==
X-Received: by 2002:a17:903:244e:b0:158:897b:40ec with SMTP id l14-20020a170903244e00b00158897b40ecmr10385434pls.121.1649899345305;
        Wed, 13 Apr 2022 18:22:25 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k62-20020a17090a4cc400b001c7ea7f487asm271911pjh.39.2022.04.13.18.22.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 18:22:25 -0700 (PDT)
Message-ID: <62577751.1c69fb81.4343d.12b1@mx.google.com>
Date: Wed, 13 Apr 2022 18:22:25 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.109-cip5-770-g2801336f0f208
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 6 runs, 1 regressions (v5.10.109-cip5-770-g2801336f0f208) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 6 runs, 1 regr=
essions (v5.10.109-cip5-770-g2801336f0f208)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.109-cip5-770-g2801336f0f208/plan/baseline=
-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.109-cip5-770-g2801336f0f208
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2801336f0f2089b0d935efe67d93eccaa85e4bec =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6257735ef3486ca48aae0763

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-770-g2801336f0f208/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-770-g2801336f0f208/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm64/cip-core-image-kernelci-cip-core-buster-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/6257735ef3486=
ca48aae0764
        new failure (last pass: v5.10.106-cip4-757-gd8c01ae8a4bc9) =

 =20


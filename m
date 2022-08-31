Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B519C0502C
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 13:22:31 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web10.25675.1661952148676783692
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 06:22:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=AdV2Bnnk;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id
 w88-20020a17090a6be100b001fbb0f0b013so14951429pjj.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 06:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=DWsTdv2MWi5skaynJM2qIJFCjPxBzQta7RzQK25HqTA=;
        b=AdV2BnnkTD/7s69SXiszd754uqxEGXSyHR4HhQwJovQ3JqYTlPFJQyJe8ra84qEgmw
         uGuSoolPQTJOdcT1VIZ1hxnKDN/F+rfuhJNhCg1WqU/aLqlenGXDdiruP/tk9eGMdHBe
         pxEM2PKPdxwXY2sLuLWJP332GPYwiYXJ0pCR777bBIsyItgsIP0nDZn8s1VGbNNOaF/L
         Lm1HK3nQysPpsWjD/p4igxYwnZKZxuUSSuZiP3c3vMg9Irvzovtz05Y1Dzl+EiGOQdQT
         sb8CKELSUozXy7ScGH7ZurOAnMNancYUNypxppMPrCYqj6L6U5lbUg4YujpHj3vDMH1L
         kcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=DWsTdv2MWi5skaynJM2qIJFCjPxBzQta7RzQK25HqTA=;
        b=BhOQtLWgQAtKOJ/dXMSsXusKMxCH0f4YMs3UmRh6e1ONfqkNhIhtScVgnhJUiud/7K
         FLJtd/LEXJf2Kj9vwqDGYiHZFmcbicD4WLpWL/ZVkeZwI3NxxHCDG0ic2PT63tJ6o4Eo
         AKIiZL3wTyPJYXmEQojpW/I2LiD9cHgnf0+slp4Smi3SzJI8ABX369+/jfz6nkZf3w56
         c39OlG7amh3wAMfap19fAJI8QLNqQt3Ki/WxkjpjcoKpdSkbul6qvrZsUOR6Y6YOiOYt
         XgHYyNqyln/zlryO0UpC3WRyiTp3/zj7Etxa/T5jVuX9fLmkmVQehz9TyW2qfY2l6w4G
         XxEg==
X-Gm-Message-State: ACgBeo2zI6NTsN9DCr9ScUodR11k+dp3dJuBiBnmGX4DRNkdIPcLd15J
	yYOqAUhuHUbWpi+T8n0O5y6aSxSZtYhUOKYPwcE=
X-Google-Smtp-Source: 
 AA6agR4hDbxJCiTpWjCQ2dF8WC7lSLOo/r5JH1WOL0mNh6tcSMV1wvaHxSgAOP0RsUolOOIxxqGvTg==
X-Received: by 2002:a17:90b:2243:b0:1f4:e8a4:8c38 with SMTP id
 hk3-20020a17090b224300b001f4e8a48c38mr3411035pjb.136.1661952148082;
        Wed, 31 Aug 2022 06:22:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 v13-20020a17090a00cd00b001fa80cde150sm1299909pjd.20.2022.08.31.06.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 06:22:27 -0700 (PDT)
Message-ID: <630f6093.170a0220.4e3c0.25c8@mx.google.com>
Date: Wed, 31 Aug 2022 06:22:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.138-cip15
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 5 runs,
 3 regressions (v5.10.138-cip15)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 13:22:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9343

cip/linux-5.10.y-cip kselftest-lkdtm: 5 runs, 3 regressions (v5.10.138-cip1=
5)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.138-cip15/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.138-cip15
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f2d94917db95e02bef61288aba5b06e0dfef3a73 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/630f4aaedc8a629fe6355648

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/630f4aaedc8a629fe635564e
        failing since 64 days (last pass: v5.10.121-cip9, first fail: v5.10=
.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/630f4ad68f83932a8e3556dd

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/630f4ad68f83932a8e3556e3
        failing since 64 days (last pass: v5.10.121-cip9, first fail: v5.10=
.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/630f4aaf4fbd5e5e02355694

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/630f4aaf4fbd5e5e0235569a
        failing since 64 days (last pass: v5.10.121-cip9, first fail: v5.10=
.125-cip10) =

 =20


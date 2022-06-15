Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE75CCA47B
	for <webhook@archiver.kernel.org>; Wed, 15 Jun 2022 09:35:04 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web12.2591.1655285699252650961
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 15 Jun 2022 02:34:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=68YMRLMK;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id f9so9974948plg.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 15 Jun 2022 02:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=B8lLj/PZKqun0SfAtL/+s/laTc5MxgVjJLkxcbL6DPE=;
        b=68YMRLMKmeXb4I5cg2H9+HLssDGfFXf8Mfl6yrU9zWFOlXIQrsmZd5AGtflgcRNrii
         6BvWpxkADbr6ECjFauk/gPbnr8uzXzTjFeLW2ve9VSfUQ41ReH7jW8EcsgRXqr/YG7HC
         KF1wCE0u8Wq7p5O4HiXIxl4QsPrmFJjAG+2dVxTDVI4zTphO3GBwf1g7+/m0A1WJqqe9
         uyLyuM18QL229liUZzoR8ZlanzTaBVf2Pvfbet7zCYIRtI718lOLFsu4rILma1EFoTzk
         ffgAznsjVDKnAr+VVqR2Dz11luKpF6AWjGQJvTvYV3LlbH+ogY48Nj+HYN3UVwmQWFFL
         D+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=B8lLj/PZKqun0SfAtL/+s/laTc5MxgVjJLkxcbL6DPE=;
        b=usClDXKVHUaEwqNcHgiVzyzCZ9Dca4lIDg5RucfYiGU7efSSId2ujV5Y6La8lDPZvW
         Miy6EpRADAxQFCXgp4veOuqIAfRwiH42hbUwW/Z9Q+FshqGWHgs6c6nhOMjNElqh6xRL
         FvgdWkUw38EODXPX8ZSRY0DXY8gA3rBIBDd+Qj1afEBhQxHzJUKCGtOpgWpI1KZXfn+j
         p94IG1qiib6n7mmFXwFNPYN27un7RJSvgMiM2+PpsNB1U78K6QqJpT79V02V22nLwOc8
         OitFreLXfn+32BVfsoCzbpvsWdxtaa2/kp2ovgBXmTdMnMA0rR7wseOduoZIPmsO18Yh
         MVCg==
X-Gm-Message-State: AJIora/bf2xvzD68jmt8Eggy/JJKbe4el6+SJ/HLn5SawljvVUIxVbm7
	J0HjqPTLTWhl+wFl45FO//LR7vdrRP76z2LZH7k=
X-Google-Smtp-Source: 
 AGRyM1s+W+pkkoFK07K271Id7iQY378yAvZ8xQWiVz+ImEnWQhR9++/xbpukv8VV5oMKd2EoWbBSog==
X-Received: by 2002:a17:90a:b396:b0:1e4:d7de:ea3d with SMTP id
 e22-20020a17090ab39600b001e4d7deea3dmr9241781pjr.222.1655285698531;
        Wed, 15 Jun 2022 02:34:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 v11-20020a1709028d8b00b001616e19537esm8738945plo.213.2022.06.15.02.34.58
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 02:34:58 -0700 (PDT)
Message-ID: <62a9a7c2.1c69fb81.4566e.ac8b@mx.google.com>
Date: Wed, 15 Jun 2022 02:34:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-312-g3a12bf5207d81
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 1 runs,
 1 regressions (v4.4-st5-312-g3a12bf5207d81)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Jun 2022 09:35:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8562

cip-gitlab/ci/pavel/linux-test ltp-timers: 1 runs, 1 regressions (v4.4-st5-=
312-g3a12bf5207d81)

Regressions Summary
-------------------

platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig | =
1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-312-g3a12bf5207d81/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-312-g3a12bf5207d81
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3a12bf5207d810922b696a4c99c88e2841af6212

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  e98f9465925434349d0aa6eb71e81b5464e76df4 =



Test Regressions
---------------- =



platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/62a7b4c2c08d7a8c3ba39be4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-collabora/lt=
p-timers-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-collabora/lt=
p-timers-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220610.0/armhf/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62a7b4c2c08d7a8c3ba=
39be5
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d) =

 =20


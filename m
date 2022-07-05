Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE354C433EF
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 05:35:35 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.web09.81288.1656999332931487805
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 22:35:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=ocSZxLmo;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.181,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f181.google.com with SMTP id q82so3304471pgq.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 22:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=3Nzo7j2FBKjlca3nyZg6vWQgt1L5zIKOrsCCPXTO2B4=;
        b=ocSZxLmoIOxmuAkfBw62PoQTKAFSjyollOfpzsmTP7n+XjhQ1LH+eycmQGf2xt1hSG
         9R3yJnG1V5MHKOedDV5zY+BcNBrZJj+ls5WbKyAmAacq2S0BxpwRhYbUU4LQ9lZ99z/G
         PfIuDt4rtaVMhY9KKgrXvc/Idt7TDcxulQDkggyXQw9Su6Osbsr5+Ltv9UFelNqXbnJr
         WjEGoC6HJiwjMDJjDPsgFnKKsLtX8M46qeXLHP2s47lCVLJPm0Xc1p5HcxbNAPI3HcMC
         CgCC40Y695W/L/zSlUWhg4wLLEi6P/uSlJ4O+ubZ2TdMtPWrcGtI92lq9DGzWETNTy4a
         utCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=3Nzo7j2FBKjlca3nyZg6vWQgt1L5zIKOrsCCPXTO2B4=;
        b=XdGpWPGfiqLyLpf108N31ayXafsJ3xpRlbNT+V8xey9aFjmgZnsqPimpzQpeKhXKba
         uh5Ehv4H0NIJsYyPHpQ5flNYEMu/Mcmkg17380Kmbt0/WVQ2XLqYhArJDFtb8jGGxQdu
         3mOiO0OxOb1mK4ZKnn8njHTVVs6KXC/s+Ut7uRvI9xenGVT/xu5YIc/9CKAha9JsHg4p
         3bJY6yNoKWh5QF1jc+jqN2Ih1xIHrBsr+sAjC6wNf3CgbG85ZNL0/2wYwJ67UPManxdr
         Ejvm3S6vWmZCNVtrCLhU7UDccpI4VatpNowQzceoMCeh54cltshlX6Ch58yi23z8KKdl
         Z+2g==
X-Gm-Message-State: AJIora8J2XCM2Tv5PWHKKF5AXhKYlE+swHcND3Im+q9GYuNGUgOG57G0
	VKwaXmitIop0Q+KXExvTA/OseGz1PnuuiNe5
X-Google-Smtp-Source: 
 AGRyM1tS2xiv9j7fcL4eeMbK4JhfMm0gwkAJNA+0CMT+olKhdYcB348x35w8pkHCSdtUl6K6B/YTZg==
X-Received: by 2002:a05:6a00:1995:b0:525:bca8:b062 with SMTP id
 d21-20020a056a00199500b00525bca8b062mr40893403pfl.26.1656999331908;
        Mon, 04 Jul 2022 22:35:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 132-20020a62198a000000b005256c9c3957sm21828362pfz.108.2022.07.04.22.35.31
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 22:35:31 -0700 (PDT)
Message-ID: <62c3cda3.1c69fb81.9985b.ec98@mx.google.com>
Date: Mon, 04 Jul 2022 22:35:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-1083-g94e3113365c2
X-Kernelci-Branch: ci/iwamatsu/linux-4.4.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.4.y-cip-rc ltp-ipc: 9 runs,
 1 regressions (v4.4.302-1083-g94e3113365c2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 05:35:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8678

cip-gitlab/ci/iwamatsu/linux-4.4.y-cip-rc ltp-ipc: 9 runs, 1 regressions (v=
4.4.302-1083-g94e3113365c2)

Regressions Summary
-------------------

platform         | arch | lab     | compiler | defconfig          | regress=
ions
-----------------+------+---------+----------+--------------------+--------=
----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.4.y-cip-rc/kernel/v4.4.302-1083-g94e3113365c2/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.4.y-cip-rc
  Describe: v4.4.302-1083-g94e3113365c2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      94e3113365c2fd3bb6050308d809a5d12b4f042a

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  e98f9465925434349d0aa6eb71e81b5464e76df4 =



Test Regressions
---------------- =



platform         | arch | lab     | compiler | defconfig          | regress=
ions
-----------------+------+---------+----------+--------------------+--------=
----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/62c3b74cf2280bf969a39bde

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.4.302-1083-g94e3113365c2/arm/multi_v7_defconfig/gcc-10/lab-c=
ip/ltp-ipc-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.4.302-1083-g94e3113365c2/arm/multi_v7_defconfig/gcc-10/lab-c=
ip/ltp-ipc-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220610.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62c3b74cf2280bf969a39b=
df
        new failure (last pass: v4.4.302-1082-g00b9de85d40e) =

 =20


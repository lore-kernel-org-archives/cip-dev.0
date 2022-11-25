Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3133C4167B
	for <webhook@archiver.kernel.org>; Fri, 25 Nov 2022 08:52:26 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web10.43140.1669366341934816177
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 25 Nov 2022 00:52:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=a+NtQc3F;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.171, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f171.google.com with SMTP id 130so3421199pgc.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 25 Nov 2022 00:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fVkWO2jfjXQtotjBh0F19lmFhiqiyAaV3jxyV9hcmoY=;
        b=a+NtQc3F+HKOYX/7kOwGHhElBMPv38PMMJCIOUnWbNU1ZuQsPyp0+hAdQVwT8yvhtM
         cap2SkdW7/SfSoPbqJwkvyo0jR6ClcOTikMoXzmiTD085tIcUJjKetYfML86RgyUOua6
         LGfsCzu5BZ/2RuxF9S9CW9BtXaiXuQWbray7S/yJJSZk3shXMMotutxcNz3cd+RPpc4n
         GgwJ1hWah9ecNJXAXMYr32Y0vhrEXWAvkIpKF1Nqfh/tSHJoDyrwo8lCHzxot2wJ7toE
         DO03/hG/p4o5PdfQgdqhPPTErVwbP21F2NyoGPnFTdksCZ84EGF2lNdh78z4uKCQsNwx
         IP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fVkWO2jfjXQtotjBh0F19lmFhiqiyAaV3jxyV9hcmoY=;
        b=nJDucF2jmmQ2+/cWuPTYHzJhEm3vflOhOx9jMM9TpahFBRzI4SIg6OIKUcbXRe36fO
         im4re2vC1TV2Jy7x4Klxb+J15DLtmZI/RE9+TTmJX9nMOxFI3xuxl7mCfq4euEPdqJz7
         vnLtdwkV0op7QFWN7awYk89Gskcgay4tqdw5TyNTV8IvVKsSbmNhJqU+fcuKS+cHUMnH
         MF3YRMHH1t0COqjosZUcbMpXOeCym+g1G9oIGvKlhFWnio38AMu0jxFXRdK7E2/RZY57
         0Bb7Y6dWPE0BKftn7fEZFHHFqzxRyz9z+9UV/7TLbCnD7UGdxLeftgr2yOEr7+IXcXOZ
         jO1w==
X-Gm-Message-State: ANoB5pmJHA23tHv+ZTyiuWgUH4n46M9zAzr40bBkA2Mljj4lfe99tfKd
	IFgVlPjC5qY5ER1U27spjvEZtltEHAU9PBubTrk=
X-Google-Smtp-Source: AA0mqf76P3sxqp8B11zF2hBohRbroIjzeZTFbwH+zoCEd7Bq5SPJS5W6dxZ1Fv/etT6DXawbtaDKUA==
X-Received: by 2002:a05:6a00:26c8:b0:574:c159:ce3b with SMTP id p8-20020a056a0026c800b00574c159ce3bmr1356005pfw.74.1669366341148;
        Fri, 25 Nov 2022 00:52:21 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p1-20020aa79e81000000b00565c8634e55sm2567339pfq.135.2022.11.25.00.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 00:52:20 -0800 (PST)
Message-ID: <63808244.a70a0220.95dee.385d@mx.google.com>
Date: Fri, 25 Nov 2022 00:52:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip70-98-g7f7838c92740
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip smc: 6 runs,
 1 regressions (v4.4.302-cip70-98-g7f7838c92740)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Nov 2022 08:52:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10104

cip/linux-4.4.y-cip smc: 6 runs, 1 regressions (v4.4.302-cip70-98-g7f7838c9=
2740)

Regressions Summary
-------------------

platform    | arch   | lab           | compiler | defconfig        | regres=
sions
------------+--------+---------------+----------+------------------+-------=
-----
qemu_x86_64 | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip70-98-g7f7838c92740/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip70-98-g7f7838c92740
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7f7838c92740fa423a5a3f12c00ed02d92851254 =



Test Regressions
---------------- =



platform    | arch   | lab           | compiler | defconfig        | regres=
sions
------------+--------+---------------+----------+------------------+-------=
-----
qemu_x86_64 | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/63807361c915a3f0172abd16

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-98-g7f7838c92740/x86_64/x86_64_defconfig/gcc-10/lab-collabora/smc-qemu=
_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-98-g7f7838c92740/x86_64/x86_64_defconfig/gcc-10/lab-collabora/smc-qemu=
_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/x86/rootfs.cpio.gz =



  * smc.CVE-2020-0543: https://kernelci.org/test/case/id/63807361c915a3f017=
2abd18
        failing since 55 days (last pass: v4.4.302-cip70, first fail: v4.4.=
302-cip70-98-g7f7838c92740f)

    2022-11-25T07:48:36.021339  [    1.975140] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3DCVE-2020-0543 RESULT=3Dfail>
    2022-11-25T07:48:36.021451     =

 =20


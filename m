Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8173AC77B73
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 01:46:36 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web10.11285.1684806388812295722
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 May 2023 18:46:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=jHzOtjLS;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.170, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5208be24dcbso4770123a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 22 May 2023 18:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684806388; x=1687398388;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wd4GyHsiLhNAzijPKI+AX09A3hTkx74MluO8ypRlzPU=;
        b=jHzOtjLSSWT9lGxOFGAh59DqX/b/B0Eo8GWPJvR2rCgY3+oPGQrep7u+aygIybjiYy
         r+fVA+Zlg6LEKwrEKj0NB1hXZU7ZrNXQePOD8rhsln3KV+eRTaf3L7Z/M3pyxBWI4JWe
         vajQYL8WJskIkofyJeq8OOaykq0YOFOEmF/KAIx7SVFGPd+NdqNiJ2gLS7blnsBnPWq2
         mPuoOOOPITmh8jTIDuRyvad9nTXJ/uFg1S3vyl2sbmZMsTohwG+2EM6Nyu/1zPo80vt5
         o0AEIbhnelLKwcTlCENU+NcH3aHA9326KVziqPoplocYSBSFafGCx/B6gDeHOX/iIuv6
         VOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684806388; x=1687398388;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wd4GyHsiLhNAzijPKI+AX09A3hTkx74MluO8ypRlzPU=;
        b=H7Ofs0qjonyKBfovXevIiWeCTtmfkIfO5/ezOeIVAw6PsEjEHjvFK+ujoTQ+7eDDaa
         TLwaENw3EJijK++kIuVtzhUjjiXTFd3O+8QIEYb/uYWCcZoCqOHr2ExRWNRgAjevV/J1
         7a8wlSj85DaaUdOeyTxr8my/+84xEyY9fd7DHV6EiYcABiPNBWrwaSvTS/pCgHYU16XC
         u0swjXIZb26M/njdf9+AwEPxm0fNspVl8wYyoPeOUxnzrKClwzNS6snCeGctFo06DyWI
         2BVnbk1Piki6tbvyCzDsgc2tTbu8KTZQ7dGPWMeGi3Czd8ct6L6gVYyqvJD2hnYoup4I
         WMaQ==
X-Gm-Message-State: AC+VfDyY+EqBrDZ48EFxyBJ5/XTpALMEL3gL6kfhM0ElurkSaqT0I4Dj
	xELGLcNSWbD2FhstLdVYUKHKe3jKN/luCe3pnrSa3w==
X-Google-Smtp-Source: ACHHUZ6w1/yKhBK40bAATig11wHW15E3XuV3vGqMwRq0csuieSjRfMA+cegegnuzZF7gwreK0xkJYg==
X-Received: by 2002:a17:902:ac86:b0:1af:a704:a65 with SMTP id h6-20020a170902ac8600b001afa7040a65mr5994610plr.10.1684806387841;
        Mon, 22 May 2023 18:46:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z5-20020a170903018500b001ae5044c2aasm5441257plg.145.2023.05.22.18.46.26
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 18:46:26 -0700 (PDT)
Message-ID: <646c1af2.170a0220.208ba.92b0@mx.google.com>
Date: Mon, 22 May 2023 18:46:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.280-cip95-rt30
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test smc: 6 runs,
 2 regressions (v4.19.280-cip95-rt30)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 01:46:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11602

cip-gitlab/ci/pavel/linux-test smc: 6 runs, 2 regressions (v4.19.280-cip95-=
rt30)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.280-cip95-rt30/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.280-cip95-rt30
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      dcee20e65677ab5d0e0d47c572f2c71dae6074a1 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0c594f9ada9a532e8627

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/smc-r=
8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/smc-r=
8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/646c0c594f9ada9a53=
2e862d
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-05-23T00:44:00.340336  <8>[   15.783160] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0f0096b1e3720f2e8606

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-cip/smc-r8a774a1-hihope-rz=
g2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/arm64/defconfig/gcc-10/lab-cip/smc-r8a774a1-hihope-rz=
g2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/646c0f0096b1e3720f=
2e860c
        new failure (last pass: v5.10.179-cip32-4-g580ea5dd85ae)

    2023-05-23T00:55:08.555964  <8>[   18.396558] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =

 =20


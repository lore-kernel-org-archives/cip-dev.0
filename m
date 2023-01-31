Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8F6C636D7
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 14:11:34 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web10.12861.1675174287056671872
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 31 Jan 2023 06:11:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=xNZEb9oT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id u5so9955009pfm.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 31 Jan 2023 06:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E4U7L44C9pRBAx9F5mKhZwlf+2vFPP2e/sPoqso5GQI=;
        b=xNZEb9oTDSES1CitHCI2Sa28fTv1ZvF7H/ZoZImI/vVLdqZYnO4takhfh7shXWxwv1
         rNLtAhat3jQ5pdVX7/ql7+AzB4lm/0BeleGeaH50PNRIZL2cGaq8BCv3UOsrhlg88vFO
         /h2bSIJAZtXXonZ2BgPx3Ai94U60oIxWrRXPc5hISxIek79piqscjXmMuAhnVRp8TwAT
         Sij5iBf67ZSllVP2dydAZtWjCWhIhxhAyIPV5D78eXcQqarpxhIfAm2CAX0oqWggovAs
         XaUy80dzPy/l+tlARDjq70VhuPokQxsbQg/2uNHEIUsVJVUqm1HdF9YHyUu86gZwQjRx
         KPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E4U7L44C9pRBAx9F5mKhZwlf+2vFPP2e/sPoqso5GQI=;
        b=cOxO9vm1EOihDSrAWZM+vJan/GaN0+o2tmTmYR8nzPJrYDEE0OS6UjlWwl4GYhBgjb
         0bOt1R3gqoBumTnAqcPOy3ZZ/VZFCVRb9TztGWPEwClJiYc31g96Am/1//k0rgNGO/lH
         kuxWkgvHUh59EMsqq0TlYJ753WRUvjzXdVi70p0LmSxo3hyR12NBB5HAjyW3D3w5XqZ8
         4Nw0wgyoneDyyDaAb6CleCfjmMb8sHnNUcd6A9qh8qHIDWP4pXBi2kLUa6s6EkFXg/Et
         Vynj/5clav0WQSkl4QZCBDBJaTMV3O5jFZVG8WiX5d2Ju9LAeIZcghLaHZWczTK+vpeL
         68PA==
X-Gm-Message-State: AO0yUKUgjTp3HjIzHAF9y/Tw+TLDEf2N/Lj7rmE4trpTmwg0seLb00zF
	gj3VxwYTlK7qnfzVMFJB/SEWE6CwPZ9wgfSPsy+QCw==
X-Google-Smtp-Source: AK7set9JJvp6gGUSaSGlcndW5KmRGwoXZfbIf/ETugrqoOYesFbOmRQYTH1N4N3dxnr/T5WmRUveOg==
X-Received: by 2002:aa7:8114:0:b0:590:7636:d435 with SMTP id b20-20020aa78114000000b005907636d435mr10025461pfi.13.1675174286249;
        Tue, 31 Jan 2023 06:11:26 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7870f000000b0058119caa82csm9430774pfo.205.2023.01.31.06.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 06:11:25 -0800 (PST)
Message-ID: <63d9218d.a70a0220.16289.039c@mx.google.com>
Date: Tue, 31 Jan 2023 06:11:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.165-cip25
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-lib: 9 runs,
 1 regressions (v5.10.165-cip25)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 14:11:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10538

cip/linux-5.10.y-cip kselftest-lib: 9 runs, 1 regressions (v5.10.165-cip25)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.165-cip25/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.165-cip25
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      52aae1dc6afe62fedb14c89fd4feca1d8bb13416 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/63d90ee929b153fc96915f91

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-lib-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-lib-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63d90ee929b153fc=
96915f92
        new failure (last pass: v5.10.162-cip24) =

 =20


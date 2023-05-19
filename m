Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56558C77B7A
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 15:12:09 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web11.28875.1684509124290852441
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 19 May 2023 08:12:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=ztsm8xhd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-64d2981e3abso1193089b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 19 May 2023 08:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684509123; x=1687101123;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tFlP0bOyOtljDV6DUls9oi7f77sbJn369UqAcCEbVSo=;
        b=ztsm8xhdnY2yk/EtR8ZCbIzorjue9gKFeifk62PZLS1PEYxtfb+P9vdmx8fVo/UsM0
         d8b2S7o49CchYziryztAPRuKR5xTQRbiBwCwamrN3nmE26U5h+xiCTbl3KB80qjCA2M3
         JJ5K1bZlnOb2mfEdgmUy6o737pId6WL7htvaBn0d+XT31O93Z9PP4A3hi4RA/ZcoX+TO
         S7CYu1oC6s6tVb/rGnf4K0CNz0R+wOJInX9mNKzZGPWovkonSY7z7VtW1bLGzosNJTUM
         9WPmjHtGysvtoKNbg1IZSk7eCZhLdBUp7At6u2VI8QNnvZ2RK3KZRYXcrMTEMNGkQurn
         +WDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684509123; x=1687101123;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tFlP0bOyOtljDV6DUls9oi7f77sbJn369UqAcCEbVSo=;
        b=jNmFOR1pverHA259EjxxdVYgq93veb1ceD+BNxAWB5t5wwdVTat3JC5D/HZElnqVcK
         D2xiJFYZ3AVtCMfF7jd3BwfxjVHP6mzI+7KFvBsXwUJPIbqyhiWSthmBabdjSkm7w9tY
         0BQDIiuZ4xMTR5el6eFbCOtGSkwZ6FP8fVH9Q33DtoFwwRZpecnSAsJGf7Hh2ixzqAla
         WxW/+m4Db/Sx8S5jGt1e68/MARwupMIBvDP54atZ/0l85UB4t0TRCD7m3nT5V7QRYOcY
         LmihjvYbGh+fynKGwUJLlC33P2ONX2F8mg+ouUAWjwdcMEqBgFERtNtJt1J8l45jaVIa
         EQEA==
X-Gm-Message-State: AC+VfDxlZ36hpTFgqqKiocPjPJ83d0ETGQoDjv1tW2KpM1nNOj0UnAJJ
	SXRA8gRyMjGquTanj7kdlsxK2Fg9A3vfWvr2W4oxug==
X-Google-Smtp-Source: ACHHUZ45dsBy1CNWKGiAg2iZxfM/KfX1bp2+dGwX5Yx3ryF82M50pLFI9+SVL26FRmsX1h5EXXfdGA==
X-Received: by 2002:a05:6a00:244f:b0:643:ba77:f265 with SMTP id d15-20020a056a00244f00b00643ba77f265mr3129004pfj.25.1684509123282;
        Fri, 19 May 2023 08:12:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t5-20020a62ea05000000b0062de9ef6915sm3051817pfh.216.2023.05.19.08.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 08:12:02 -0700 (PDT)
Message-ID: <646791c2.620a0220.490c6.5ad9@mx.google.com>
Date: Fri, 19 May 2023 08:12:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip33
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 1 runs,
 1 regressions (v5.10.180-cip33)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 15:12:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11563

cip/linux-5.10.y-cip kselftest-seccomp: 1 runs, 1 regressions (v5.10.180-ci=
p33)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip33/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip33
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7f6b02104eb287caf662ade9a67f11896ab01fde =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64678a7da3a595a11f2e8625

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-=
hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-=
hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230512.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/64678a7da3a5=
95a11f2e8626
        new failure (last pass: v5.10.179-cip32-4-gd8c029e4780f) =

 =20


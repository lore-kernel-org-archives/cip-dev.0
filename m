Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F21CCA481
	for <webhook@archiver.kernel.org>; Fri, 24 Jun 2022 17:14:18 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web11.10414.1656090851378799323
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Jun 2022 10:14:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=RtFhzUGt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id
 b12-20020a17090a6acc00b001ec2b181c98so6382432pjm.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Jun 2022 10:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=vqpriqT1lyBBteMeNNWTaxF1b0y3Q+YyCFWVdeP/jzU=;
        b=RtFhzUGt9Y0h+pabKbbQ/F+OBPdOtWCSM9ICOR+Eh3XxhgqbNMgiUrlWoFA2N2ffa2
         u+bcW+ZmJyFIPv87OuiF1YV6nLtVrM3Gxu5DhYpOOTjx3KuPrMc7GpY6lfPJPb+k16bx
         B05cMX0Cx0KKOC9i+7S+XFXO+Mcm1nLkhVE3Yfkm69hIZaddeaMxgC7noro6muZDtovi
         1toG8zNfIelILd57XCyWPC4uz0aMJo8ZgNLgUjzdPm5apgEgyM33FP+wUctckHc5YcHV
         d7KxYoMirWq9U/EsFdjlVG9XZezPMi3tyXUtZiEXmeioj0JtNtLA1AIV60jDLdCf0hrJ
         WrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=vqpriqT1lyBBteMeNNWTaxF1b0y3Q+YyCFWVdeP/jzU=;
        b=buVGK93CCTM8D1rwLwCB3kbLGrAyc6YQydt0ND396KEaHlHSyAO4Y1o8Ef4g2WBUWw
         I9Ojo9TUEvwnb0RhbOWHhHRVwXWqKj4oaoOevkJLv6+c4rrKzbfLdFPPVB/sgdPeXw6G
         wmPcUzeGfMlYu4/24kIsumg2UJm4P+dAtT7dDzClBgD+G7BxZBPPxgInuWaPtwZB/p92
         l15ac+3d9tZILfbm2hqEldLDkhD/YkkGsls87XQ6vCUw8BW+bp+ZOZQBsvYBnFppXLD2
         zP4nRt3XtHfpdOQ2XSAMDd96PCFwBkji3fMpa8BBeYdsOWs/he2hdqAOoToFZPEkxALo
         6B6Q==
X-Gm-Message-State: AJIora+/6SQDhE45eCoYW2EvHpgSjyZGjmfH+nPdHoCwUBXBoyJgyith
	aNwHBY56mEkgFAsodQoYWvfEIKkNIHRh9qPdRVY=
X-Google-Smtp-Source: 
 AGRyM1vzNjiDUErfg/mY+1PEERCmhfHjUe04kSEDU/qUav6WtdApAR9hIHFN25nzYNAiSmME6mUVNw==
X-Received: by 2002:a17:90b:1e44:b0:1ec:cc44:be77 with SMTP id
 pi4-20020a17090b1e4400b001eccc44be77mr5309500pjb.34.1656090850798;
        Fri, 24 Jun 2022 10:14:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 q15-20020a17090311cf00b00166304d082bsm2108232plh.73.2022.06.24.10.14.04
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 10:14:05 -0700 (PDT)
Message-ID: <62b5f0dd.1c69fb81.12ac.312c@mx.google.com>
Date: Fri, 24 Jun 2022 10:14:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.121-cip9-272-g3fb28d4c623b
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 10 runs,
 1 regressions (v5.10.121-cip9-272-g3fb28d4c623b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jun 2022 17:14:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8595

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 10 runs, 1 regres=
sions (v5.10.121-cip9-272-g3fb28d4c623b)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.121-cip9-272-g3fb28d4c623b/plan/kselftest=
-lib/

  Test:     kselftest-lib
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.121-cip9-272-g3fb28d4c623b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3fb28d4c623b354373a844dd48f16cb4f005388e =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/62b5deb1648d50c65ca39c77

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-272-g3fb28d4c623b/arm64/defconfig+kselftest/gcc=
-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-272-g3fb28d4c623b/arm64/defconfig+kselftest/gcc=
-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220610.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/62b5deb1648d50c6=
5ca39c78
        new failure (last pass: v5.10.118-465-g0af29783a3c9) =

 =20


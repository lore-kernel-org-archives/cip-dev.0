Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D9FC433EF
	for <webhook@archiver.kernel.org>; Tue, 28 Jun 2022 05:05:03 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web12.51951.1656392693206175926
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 27 Jun 2022 22:04:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=ebFdLw20;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.176,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f176.google.com with SMTP id e63so11093197pgc.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 27 Jun 2022 22:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=TJtChW4jwYeX9zWrrpXzLKHC7z2J3fRCAsA0PEjE3I8=;
        b=ebFdLw203WaDRrSqDOQlw7VnfrcJePpbTvflV0KirAjJjuCk0kDkMbFrVCqttl+Leh
         1Cmwl9EGc0LGIZvf2M3eNGgop9QPeVcHOGlDgJfADt3M7B2ohuHsM6QM8s72uti+LHBg
         rvgqCpC5ceZuel/iLn5DnwXwuqCY3EeOfEfUHXt8feV3wBxNFWyVS7z0lb304MpUXLVl
         MYwUxMaIds80E8vWOIpwsH4CZ0npyxScKXTJroLVcMT5zNdigMaNgO4BbRw5vU4uGsuO
         ASTgScLZnMxmTawhudQtiZhPkvmKnSzn1KPJsBlHKF5/etHBnS9qlypl+sBUOCLnWnKI
         AIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=TJtChW4jwYeX9zWrrpXzLKHC7z2J3fRCAsA0PEjE3I8=;
        b=lnrgWjpeSd4cQPn9rW/FIWRBbScCjUVQTSQCqA3raiuZp83U7dPs9jjDLnk6rPbuLR
         2knEyz2zoVGa63tlytFpYrDLz13NH2HhgOopfbmeYHQC3diR4s4uDhfnCcCEdUJiwxo1
         BQQbrMNOiBPieubpmjhkiokIgUM9NMZ9I9aQQxwg9gsx8wkKG+w7+kBsl1iAjT+Z9+Z8
         2EGSafGtZA3G/BvYAbrJnOo2uyiqFpt3ZgAA6JmxzXQTEyQFIuGbW2O/kCyR89HH4JA9
         qm9X78KEN93XzoNBlYPdA81fWkeWXP/xlaWg/3QyCU2QbyNGoiMEWPTbb0PQvOrnekmN
         7Xgw==
X-Gm-Message-State: AJIora+sELN/8TR1+5N+XdFzzxTpnQB3Qr41n60fOtUVQwKsrBZe2ew3
	JNolVNwBljq4zVVBnsh6CcCYtZxmp6MmZIHz
X-Google-Smtp-Source: 
 AGRyM1uWnokjn4oPwcO9MmNG3xZOO7bfBqLS0zcpzv9T/KnaMFBcC7AkfjpD5CuSi148TMpDeRGcYA==
X-Received: by 2002:a62:1bd2:0:b0:525:6880:2a93 with SMTP id
 b201-20020a621bd2000000b0052568802a93mr1613522pfb.30.1656392692549;
        Mon, 27 Jun 2022 22:04:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 u17-20020a17090341d100b0016909678e2csm8182444ple.292.2022.06.27.22.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 22:04:51 -0700 (PDT)
Message-ID: <62ba8bf3.1c69fb81.34a88.b8a1@mx.google.com>
Date: Mon, 27 Jun 2022 22:04:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.125-cip10
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip smc: 7 runs, 1 regressions (v5.10.125-cip10)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jun 2022 05:05:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8622

cip/linux-5.10.y-cip smc: 7 runs, 1 regressions (v5.10.125-cip10)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.125-cip10/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.125-cip10
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      93e5c28cd0bdd8a2d89059fe7218ce98dd7c81ce =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/62ba7889fbe4e404b6a39c62

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.125=
-cip10/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.125=
-cip10/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62ba7889fbe4e404b6a39c63
        new failure (last pass: v5.10.112-cip6) =

 =20


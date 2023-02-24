Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AEFC61DA4
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 11:31:29 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web10.15499.1677238288607227536
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Feb 2023 03:31:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=o/jjjx8e;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id oe18-20020a17090b395200b00236a0d55d3aso2375166pjb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Feb 2023 03:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I8odEHBeGIBp3W+cdcZ1RPjjJ5WMphFcQe70eug7zWk=;
        b=o/jjjx8eNeklZnDqJxxH+QUYIWIbtTNOXnijCL4dR6O+LKmr9nK7OKisvdXnDwXnEM
         lrbsIjUzH+Cg3xB0RJVPOdVIFfG5u1M+uAEa/a1Q5Gj0JAH422Yem/Y2jtxOxv1afyfJ
         PoKpMrbRetRhmM+67NcEypjECD31rl5IdH2HoFEZ4PvswGYWuGj90QBRWkS+L7BXOlos
         ihe3hccOf8+fRI1Wtc2WJJ4n1qn8udR9gHQUkolm/WwqtmgvsSD0Ybr410iO2Uj3AlpF
         Uig6aFCJ9KHSzW6VNDamNKPcnKSTjm0tuekDmRIQAYpmYUqirakBIWlPTisUuY2TxOfm
         n4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8odEHBeGIBp3W+cdcZ1RPjjJ5WMphFcQe70eug7zWk=;
        b=RRd8KhQ1LPQcy26r+UKBfgsen5DmlEUDxQU4hyEVdKlWQQOFKifRiIHVLTK3yf0eb8
         /ykU835N4HG5GIvfTA0IT/eBjzj87C9Db6OI2SEpvLax+e3sP8gzg0rYYr6JAObC4OnL
         j3AWckg7o5EC3Pl++eMB7t+nP6bffGlK+uLFZUxWpJECZ9YqXYlKAGAPTml3ylNZYxV3
         jfRRd2fLABFEGSZO2Awm0nLMhFBHgLF52SgUaVmJ1GLHTWzPuiYmoiPTsD1PxXnmomh3
         Y9++IXRYj9KjLa8uoXiDRVQp/XHDDo9ITcng1M75kU7X/MPusrwFn7B6Byu4T/Sjgpph
         R7bw==
X-Gm-Message-State: AO0yUKWcKOGRwkEJXNR4GH9009kNaWp9A8CAEoxJdUNGa8Znpok+81GG
	uH1VYaSjIiCnqzSx1e7by9icRGqx5Gj6xGGxwnD6yw==
X-Google-Smtp-Source: AK7set/7qVYnCxpJ3ZH6G5/dQR/FgPBSLb6fwjfHahTpRgXKTQy205mhxxgsb4Y1wuJca8T7ht9pDg==
X-Received: by 2002:a17:90b:33d0:b0:230:d782:7954 with SMTP id lk16-20020a17090b33d000b00230d7827954mr18113716pjb.9.1677238287759;
        Fri, 24 Feb 2023 03:31:27 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x18-20020a17090abc9200b00233aacab89esm1323206pjr.48.2023.02.24.03.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 03:31:27 -0800 (PST)
Message-ID: <63f8a00f.170a0220.ba2c9.23db@mx.google.com>
Date: Fri, 24 Feb 2023 03:31:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.168-cip27
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-futex: 9 runs,
 1 regressions (v5.10.168-cip27)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Feb 2023 11:31:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10808

cip/linux-5.10.y-cip kselftest-futex: 9 runs, 1 regressions (v5.10.168-cip2=
7)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.168-cip27/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.168-cip27
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      cc82f737b68c179240070fa34771bcfd0a5fa421 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/63f890fd6316cc7e188c8630

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm64/defconfig/gcc-10/lab-broonie/kselftest-futex-meson-gxl-s905x-l=
ibretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.168=
-cip27/arm64/defconfig/gcc-10/lab-broonie/kselftest-futex-meson-gxl-s905x-l=
ibretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230217.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/63f890fd6316cc=
7e188c8631
        failing since 0 day (last pass: v5.10.167-cip26, first fail: v5.10.=
167-cip26-2-g1e87e7748b91) =

 =20


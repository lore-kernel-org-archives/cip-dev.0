Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC814C433FE
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 22:37:27 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web08.306.1668033438688163556
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 09 Nov 2022 14:37:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=0T0zsBWz;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so3232193pji.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 09 Nov 2022 14:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tkBnTkJ+8sAiacYYhyMAf+2ptMBlO/0I/as4gM21OtQ=;
        b=0T0zsBWz39rlYgaLzwrJM6NMApPTkRaRrdIySC07XXKco0YjQHgvItlTOEIq1ADoAU
         va8BndP2M5g0quNtbKDdb3InkxRnaq0WEBO1RkBGgbcLO7T2VW9ToZktcWexKQRSEyUR
         3z4sv1hLpGPr3tHhUpxw0wzI8TH19oTXhBodpnKHcn0ZciGg+Zn/QdBk63LIm0gj80Zz
         EF4Gi6y5MWeYIwCuTLNODYccPXIbthqIgt02E0S93vnTOuOIpw76EJQb/IchXUG+kL+y
         gbZOKDs9b04+HFFV9RelMDPlhN2hZTKe3L2rH7ATTh221EjEChXY2HNi1AdVnkPwU+1b
         rCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tkBnTkJ+8sAiacYYhyMAf+2ptMBlO/0I/as4gM21OtQ=;
        b=6t9YgEm8KEesCmgqED/ZWHa6qmkrquaqosHiAcjcsrmSevAcvogdGNjk7LKqm6AngG
         unn614ZNO4uOyCQcycAopFnT/hzsNX5eKFI5SJGBfw0PPMiXV1a0hrqQm9AkVcoqmJiw
         uCyfl6CoV6DfghcZA15hUYfk2lGOsQqZJ5WwZPgPbLxmD8VgTszObke3+v/dm5TDxDvK
         4mj71GH9x4Y0C0oCmnTuMuqYs2f4wDTUJxYlriR37NaQZBMfAF8aoLxiqdaajttaeYer
         vn6P1H3Q68zA5JRfO5dKVcp8i/sKkSSF5qqV38C/XAcJgtTwJufzywv2xFGAGCK0r0Ik
         PP6Q==
X-Gm-Message-State: ACrzQf0oNX+xw6AVxvJhk1+IlByeXo+YTdk3N11PVV4yYnT4FBFhq6Fg
	zXWJ/dtcH52bFeJ8uXsMRUtX7+kZrk6qn1WtoTU=
X-Google-Smtp-Source: AMsMyM7Izg2oK+qTv+ucu7ql/gHt12ycDQwjfyTQbU15M+fl+qM1ugitCUInDotcwPKV5e/Li0BDKw==
X-Received: by 2002:a17:902:8643:b0:187:3f0b:a4d7 with SMTP id y3-20020a170902864300b001873f0ba4d7mr43843573plt.15.1668033438115;
        Wed, 09 Nov 2022 14:37:18 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902dace00b001752216ca51sm9723714plx.39.2022.11.09.14.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:37:17 -0800 (PST)
Message-ID: <636c2b9d.170a0220.fd4d5.150d@mx.google.com>
Date: Wed, 09 Nov 2022 14:37:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.153-cip19-3-gc76f4e7e5c71
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-futex: 9 runs,
 1 regressions (v5.10.153-cip19-3-gc76f4e7e5c71)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 22:37:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9974

cip/linux-5.10.y-cip kselftest-futex: 9 runs, 1 regressions (v5.10.153-cip1=
9-3-gc76f4e7e5c71)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.153-cip19-3-gc76f4e7e5c71/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.153-cip19-3-gc76f4e7e5c71
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c76f4e7e5c7160107c9b5d8ec188f61fe326cec3 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/636c1ef90a92c21886e7db81

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19-3-gc76f4e7e5c71/arm64/defconfig/gcc-10/lab-baylibre/kselftest-futex-=
meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19-3-gc76f4e7e5c71/arm64/defconfig/gcc-10/lab-baylibre/kselftest-futex-=
meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/636c1ef90a92c2=
1886e7db82
        failing since 5 days (last pass: v5.10.147-cip18, first fail: v5.10=
.147-cip18-12-gcb2b164780be) =

 =20


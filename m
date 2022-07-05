Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4190CC433EF
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 21:10:43 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web08.268.1657055438620243324
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Jul 2022 14:10:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=ehwsgF0j;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id ju17so8262417pjb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Jul 2022 14:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=/KC0bq4d70cqVjIqy76qRcZJNoX1GDDDcZMEE9Lo3bo=;
        b=ehwsgF0jxBrgaWiKvHMQCBMKDxjzJohjpXsJFJIDLnLjLFWOHIKU0q7wri5tP58K+C
         x1/3sAmkh4K8qdAqcDTY1J75TvQe55CGMXOubWId0ZVy0scBlF24kS6i6DtyWeGAKE+z
         xJuqTZm+OmoxS4Lf7kAcP+ooDp/TzTWuw9UkfRaGUC8ZaXaspTgp7gC/MrYvlFOfGxfG
         wV6ot0aJNhuWQvGOlEpOtaiDoxiRP7LiwF9DUomYTvDG6sVqmq5Ec+Yc5dYVs+PKYXtZ
         JLtFdNwA3OLryQu3UcCKkRURNH3ybpcxrv3XOv6XCEwhU12791a6FQnRwvSGDvC7ImHR
         +i1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=/KC0bq4d70cqVjIqy76qRcZJNoX1GDDDcZMEE9Lo3bo=;
        b=Q1bpEv+1XnJo9PjrMxMvt+xz/09cMmlK07SBYRg9Ef2tBTQaOnxmEFEfNvGnbiSBix
         C3narvkbl28jA/2nIzyhSNRRGUkv4NrL68u4xC2eXZCriq73mYEBfZ5faTerWQ5gHGV4
         kK7j1pNWM0ZOcc7wOw617s3edqreTcLI26DbZfO2tpmwqmIpv26YlwDXadOWbtT/rjHr
         36UOFVJ8P0gCwlbt6IwJBwxoJ2zyZjPkPHMdVFBNnccZsBbOdwPj4v8sKFTgb82B4tyW
         pDbJU4MWUnOWs8ov/h2f9o1JG9mXpvlqvFGi7ndQGYKG6YjzHwpx2pN3a5NnJziAn/2z
         cwRA==
X-Gm-Message-State: AJIora8kkZspEPsatWT4dWE0uCj9FZa5PaaUop6tQMSAy3VLzk9jjvoR
	5MVGa53MMnWZsbAKcCBK4D6kGcGLCAnD+sFF
X-Google-Smtp-Source: 
 AGRyM1sd60+ztI6fjY2JlLO01TCH8ycERM+AoO74VCGlOkn9EvfknS2PkK9W2b5QZEROkG49HmlFrw==
X-Received: by 2002:a17:902:ea47:b0:16b:a612:208d with SMTP id
 r7-20020a170902ea4700b0016ba612208dmr35283242plg.96.1657055437851;
        Tue, 05 Jul 2022 14:10:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 x12-20020a17090a1f8c00b001ef307e1deesm13036838pja.18.2022.07.05.14.10.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 14:10:36 -0700 (PDT)
Message-ID: <62c4a8cc.1c69fb81.cfb3.2d0b@mx.google.com>
Date: Tue, 05 Jul 2022 14:10:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.126-cip11-1-gc5218dc69ff1
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 7 runs,
 1 regressions (v5.10.126-cip11-1-gc5218dc69ff1)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 21:10:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8693

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 7 runs, 1 reg=
ressions (v5.10.126-cip11-1-gc5218dc69ff1)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.126-cip11-1-gc5218dc69ff1/plan/kselftest-=
seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.126-cip11-1-gc5218dc69ff1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c5218dc69ff1f0703b893c079a21669841b479e1 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62c499117b185f7500a39c57

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-1-gc5218dc69ff1/arm64/defconfig+kselftest/gcc-=
10/lab-baylibre/kselftest-seccomp-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-1-gc5218dc69ff1/arm64/defconfig+kselftest/gcc-=
10/lab-baylibre/kselftest-seccomp-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/62c499117b18=
5f7500a39c58
        failing since 7 days (last pass: v5.10.118-465-g0af29783a3c9, first=
 fail: v5.10.121-cip9-287-ge9094c8446fc) =

 =20


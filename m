Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83029CDB47E
	for <webhook@archiver.kernel.org>; Fri, 20 Oct 2023 10:33:17 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.51355.1697797991997569813
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 20 Oct 2023 03:33:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=i1bFz+Jr;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso522441b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 20 Oct 2023 03:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697797991; x=1698402791; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HCAlelXTwUxkONyW9TnPxp+dxOlUuOeCDlW3KDsSqqM=;
        b=i1bFz+JrHUZACHfG0h4CGnN+/tz7oZY+w/9m9CcinpDb0Rz81YGJ8WlFb6dptFovi5
         t7ctRRzamxgByNal1xFxPafpj92JV/JnAu5DjjegjMGheGwMsWkhkcswvl3PGPki/6HR
         A4Qj6gn4igBRKIfvvfJO+mp3XucPII+ny/XXbHs79WvsoY+q8cgsmY6ElLl9zau6K9vs
         aSGBpHVh6CRcXY0TT+Xm7MAchwQa9PMFIAB0lIWHmMRdOjJfMYzN7XW9ny74oW6HM4lt
         dcKz4O6EIRgVG4diQR9n8Ctr5iB6DykGXuCknD0nNNzOAXLBWUbq2e2UempHYkKTWeUr
         ii8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697797991; x=1698402791;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCAlelXTwUxkONyW9TnPxp+dxOlUuOeCDlW3KDsSqqM=;
        b=s2IS9ySTMjnybO4kYKc+zn/Ldtd4OhmctvpiWjzYR2Bc6yw3wDaxY8BX5mI4HWi0C5
         dRLhYQBYAJCtuAwkEzcVAiMk/gsvw/tEbmTkjctp6JEnPCGRh5SSqWXKynI57LDpgki/
         TnXWV3gGJWvNnbm57pUObwFGNdEODYQoUna97v/mgLLePcnhanIhSO3POnJTVLyb6hmG
         WGdVeHzuLoqLdc64B9OR7Hvuedj0Q66LnvNhKKndBPlsr5oAah/W0/+e0ofMDoJrl0k5
         U9vnLAMin15CzAJ4eMqONe5tcCZ4iwDqnCY1t5m7V9WIpZwPGtIM49xKDikfykXynIE9
         HQ3Q==
X-Gm-Message-State: AOJu0Yy5ExEPwj6MCK/Rj2zTHnP5/wV8Y8wG5p3tEC6zrUkvNxn1tf4H
	+0BHdglKd4r/AI9NSgd9/P04IGpZqdfMfWvdzW+i2w==
X-Google-Smtp-Source: AGHT+IH45/ZCxP9EgpwDeqbm9Uc+Tp12XnLo8c8/I0vTg6flrzOo09yrXslH31PmNFlfFbPo4TINVg==
X-Received: by 2002:a05:6a00:1817:b0:68e:3616:604a with SMTP id y23-20020a056a00181700b0068e3616604amr2237884pfa.8.1697797991087;
        Fri, 20 Oct 2023 03:33:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t129-20020a625f87000000b0068fc48fcaa8sm1266460pfb.155.2023.10.20.03.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:33:09 -0700 (PDT)
Message-ID: <65325765.620a0220.fd273.451d@mx.google.com>
Date: Fri, 20 Oct 2023 03:33:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.58-cip7
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-6.1.y-cip ltp-pty: 9 runs, 2 regressions (v6.1.58-cip7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Oct 2023 10:33:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13412

cip/linux-6.1.y-cip ltp-pty: 9 runs, 2 regressions (v6.1.58-cip7)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
mt8173-elm-hana  | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.58-cip7/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.58-cip7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      5608f0095a5ba83c76af0e5824c2e2d3f41231b5

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
mt8173-elm-hana  | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65324f060825b73395efcf04

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.58-ci=
p7/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-pty-mt8173-elm=
-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.58-ci=
p7/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-pty-mt8173-elm=
-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65324f060825b73395efcf=
05
        new failure (last pass: v6.1.31-53-g486caac40d06) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65324ad6400e7f4b51efcf15

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.58-ci=
p7/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-pty-rk3399-gru=
-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.58-ci=
p7/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-pty-rk3399-gru=
-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65324ad6400e7f4b51efcf=
16
        new failure (last pass: v6.1.31-53-g486caac40d06) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D352AC7EE24
	for <webhook@archiver.kernel.org>; Wed, 31 May 2023 10:25:22 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web11.10770.1685528713420221081
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 May 2023 03:25:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=ATmG2S7I;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-64d4e4598f0so6230523b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 31 May 2023 03:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685528712; x=1688120712;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sUixi9mvFddDsW5UpnPZEzcuSceKxupN//WdTrCgEj0=;
        b=ATmG2S7I9Jh+Q+1kKh9snbeRe6E/EnW+TRPg5kgZuNQbZgA4cgvEEyM967Cvsimy7e
         EEcKsLrHlyrdqkqX/HU4xagTRFUTnaLGwxa1oxOafHnrc72WPVHGxJLW5nIFIRCdlhMy
         dUImifvdCbffi6doENfLKlGiW+FUt1HRVbk6R5Zn6d3Ey6hVJgKpFc5i4b6Gx52q2IZ2
         G3oHuMae7z4ZvfzX6/vJhHCZ0WeB1RCi5gm8bd0GY6pXXQqnjajc20KEo/mOxtzBwuaw
         SPTPO+50Q/obQW6ZPVf1n+uatt5Xsd74sx0WBrFpSKXehQxoEuZHnK+mjY57fC52Kk5S
         rarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685528712; x=1688120712;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUixi9mvFddDsW5UpnPZEzcuSceKxupN//WdTrCgEj0=;
        b=QjlNb2dBBl1L5HSWCfqvPSoKVjLwrGyjszflKE9P2Qx2Fw35ZDs5KAw5VrkBZ603iW
         GL0freWE+Uy4Kum8on+TQxiUufFPqenq1bMmCgTyMJWj+3TAtkjSDJAo93/V2BRidSi1
         21gsJ3iUmERWbOlye5j1OMH+v0EctVcVMVsyfUXy8nNZkLZnVW6AumuRvQmaU59uTJ7j
         HgMCyfyz3Ao6D2yq1AUgLPRkN/KDpKxS56ipG9mLbN4WW+ZK9aQ4RsRsIddgR4blNT21
         vT3M3qBRfrFbLZZ7h9uDV1uPiqhPaULZWVjxJRsLZQkjRqb+QLVuriy821EhdgbrJgs+
         YHJA==
X-Gm-Message-State: AC+VfDxqwHTLZnodD7e2KaP3pwCWj5v4KK352VtjdIY1FI0YIEMyNqfw
	nfBNJNSC9ye8BH/9oXiwoMH+163sjVkiadFnjadS5Q==
X-Google-Smtp-Source: ACHHUZ7a7w0h8UVbCI7L+GxewdnllBDgSIGcav/bVFpsjJMoHCcR9wTihrAS1/pmd8yB+U/IZmwyIA==
X-Received: by 2002:a05:6a00:b50:b0:64c:a554:f577 with SMTP id p16-20020a056a000b5000b0064ca554f577mr6446502pfo.11.1685528712280;
        Wed, 31 May 2023 03:25:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x14-20020a056a00270e00b006437c0edf9csm3180281pfv.16.2023.05.31.03.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 03:25:11 -0700 (PDT)
Message-ID: <64772087.050a0220.bc032.6492@mx.google.com>
Date: Wed, 31 May 2023 03:25:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-1307-g20af3740f4fc
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc ltp-fcntl-locktests: 3 runs,
 1 regressions (v4.4-st20-1307-g20af3740f4fc)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 May 2023 10:25:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11711

cip/linux-4.4.y-st-rc ltp-fcntl-locktests: 3 runs, 1 regressions (v4.4-st20=
-1307-g20af3740f4fc)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1307-g20af3740f4fc/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1307-g20af3740f4fc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      20af3740f4fcb1ef7c5d829654de94824a2d493f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647710dcec6d0f17d62e862e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1307-g20af3740f4fc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1307-g20af3740f4fc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/647710dcec=
6d0f17d62e862f
        failing since 62 days (last pass: v4.4-st20-938-gc773c630d0e4f, fir=
st fail: v4.4-st20-1097-gd51b0e04681f) =

 =20


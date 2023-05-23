Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B5CC77B75
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 02:00:56 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web11.11345.1684807256297290647
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 May 2023 19:00:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=y6u8clcd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.179, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5307502146aso4736339a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 22 May 2023 19:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684807255; x=1687399255;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pgYa0mYJ6c6ix8cRSn/PEYyyfh6r2zg+wwqk3kK+vDo=;
        b=y6u8clcd2Soiz3eH2QBW9cT0gkmP3cDhvLM4+RmI6P+p0otkJi0DybFDfXYpB3Wz7X
         jPH6aFFmF/2f3wVGPuw3dMb8/GBUhJANxr4GYCuVpGUYSnTx1Ch9q/StLZjjJO34Mskr
         TBBodctfHT8XpZpprnD89cbMOPQCDry+iW2YbJyRdNUILhCISyGs99SfvBD1cdjELQb5
         mKl2COHdR2W13qv9JeTrtfMVx+n/8VMKsaDp4KMdlFRCwCYHPyaoa+uwldYr/Eg9vdYv
         YQxTuIddcPer8Ma/+geh/jk0koET77J8YmBo51kxYSPcpU4hgTI/INfUe2Z2BCe84BYU
         5Qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684807255; x=1687399255;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pgYa0mYJ6c6ix8cRSn/PEYyyfh6r2zg+wwqk3kK+vDo=;
        b=c0hX7ynez/KpbETVgF/HAFcMxbC89/gQGUUSRl+EmMQ7yzWd4WokrB99+OyEeIwzZB
         PigOjUKBJMHMqF58eCA+dHoV5eddYJXD21gYYyFDgwe5TTIjlTATNLoNCuWTnwvZwjvl
         FBjmUGpb/YHSgH+ovE0n4B6BsTIi0MVv4DwM7rTseRzUDGRATod/JvbLen0d1OiuIePd
         mHFPQkai7/4z/qhjmiXhyrhvgFjDGTs/t9EPVWyJ9sMB+WBTvFbFnPBoBloVik64ylNE
         mwBNoJxJMjOZdxXgrV+EAOw/vm4n7FwVqOtQnwax5quaiifzs4+QhFTgd4QkZ0tuwEK+
         VBHg==
X-Gm-Message-State: AC+VfDzeVhUq+3bRgl5uf46tx16QSz8iGt9do61MjbPHobdmegdjrfu3
	A3ma0a4ry4jgrFsndUz17w6MxwkYy7D87+Hm0xlhLg==
X-Google-Smtp-Source: ACHHUZ7GaeWBUp+ejoXpGUY/DiVIUOilNcPZ6qv9JIweqNDBz94Nlw/TYGvcOTKA7peOmQ4Gsg6VWQ==
X-Received: by 2002:a17:902:db07:b0:1ab:28ec:bf10 with SMTP id m7-20020a170902db0700b001ab28ecbf10mr15562436plx.51.1684807254988;
        Mon, 22 May 2023 19:00:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jh9-20020a170903328900b001a6f7744a27sm5492152plb.87.2023.05.22.19.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 19:00:54 -0700 (PDT)
Message-ID: <646c1e56.170a0220.56e58.9658@mx.google.com>
Date: Mon, 22 May 2023 19:00:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip33-11-gfea7994097935
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-mm: 6 runs,
 1 regressions (v5.10.180-cip33-11-gfea7994097935)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 02:00:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11604

cip/linux-5.10.y-cip ltp-mm: 6 runs, 1 regressions (v5.10.180-cip33-11-gfea=
7994097935)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip33-11-gfea7994097935/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip33-11-gfea7994097935
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      fea799409793527f9b9b2d2c53f0dc4e3ac7ac6a

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c19fef5f9752bfb2e85f7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/lt=
p-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/lt=
p-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/646c19fef5f9752bfb2e85f8
        failing since 496 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20


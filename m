Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286AEC433EF
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 03:04:45 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web10.80346.1656990282115546631
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 20:04:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=jUIZcf87;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id
 cp18-20020a17090afb9200b001ef79e8484aso3815283pjb.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 20:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=nldvReGDDAopxx3FKJH4UKH+XgQeqZxooluogUmLEvY=;
        b=jUIZcf87FiGvSIyJxfaTYx8L0RhKZPXPaKjFNprUaNmD2cdlzA/xClb/Gooy7ats1N
         OY9MF0ER2ypojECny599Lz1/7UZHilC/GaUTBETr/OpWO4EXED1mSmVtbq/aMrPG2Fun
         VoH2dWVbWzyywYtYiSd/BiMJALCzxD5zKMAPjPIurOqWhtXvlecT3Hdz872ywLJ3XJZF
         ZRHGW3AYM/dpfC7xpCr2I7KrZ060NIJJNx9juCBDfJ1ALtZpjTe2hzPfTxOTi2AvcwbD
         3jHXBVpuiyREEdfUiiU9+CkwercEyWE0J/rXWKjbKQnFBFzq2wUUTSC6JSMM/aVfNsXk
         S19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=nldvReGDDAopxx3FKJH4UKH+XgQeqZxooluogUmLEvY=;
        b=iVkLR9DH60Za9162rndvk4RfKCtGH0LxO8MUpxredLtP1X40SKk7w3heL9YTH3suMQ
         ZayKINY9Ybv6PjOA4M4PL3+BvC1gJl6Wk3Ofrxxo1UWIIJSaFS4hpEYwvyT6azJ67vBr
         xktEMtvQhjiTIEb4jhLdYOFQU1JFQRaeGN4VjUuAGeeY8hZrb8amuPEoRx88qIRcAxCt
         ggjzTZ0IUXlEx9z4TbUsoFvLI4jSbc+JXs7B5ifgwNLxL+FJpY/KIOsWrcqxVKFKilbl
         hFK41E/4VSGaB4kO3frJrzkKTxo1yMacsh+GKv0ctPpESI4pfAgIY1OD5iF9TPkqFQh8
         cR1w==
X-Gm-Message-State: AJIora+d+JiBWwcjVeyVHNDKePrml8a+wUc3cw03MyXq0hwf4OlKrqfK
	9U25u5Af1c5PAxiXAiCkWwA2ZIhgiA6Z653X
X-Google-Smtp-Source: 
 AGRyM1vFPEcRPx4siGaZ2q+eWBg1TyMRjG+fy4468cH1cAm7av4VkvYcK3ZN1gYXKxEfFYR28TPg4Q==
X-Received: by 2002:a17:90a:e4ce:b0:1ef:87dc:e377 with SMTP id
 e14-20020a17090ae4ce00b001ef87dce377mr9844634pju.25.1656990281307;
        Mon, 04 Jul 2022 20:04:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 cd21-20020a056a00421500b0051b32c2a5a7sm21299910pfb.138.2022.07.04.20.04.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 20:04:40 -0700 (PDT)
Message-ID: <62c3aa48.1c69fb81.8a87b.ebbf@mx.google.com>
Date: Mon, 04 Jul 2022 20:04:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.125-cip10-119-g603acbe1aceb
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 6 runs,
 1 regressions (v5.10.125-cip10-119-g603acbe1aceb)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 03:04:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8657

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 6 runs, 1 regre=
ssions (v5.10.125-cip10-119-g603acbe1aceb)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.125-cip10-119-g603acbe1aceb/plan/kselftes=
t-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.125-cip10-119-g603acbe1aceb
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      603acbe1acebe85cab7f594d9952a493be976262 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c3a1e45f79a95c47a39bd1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-119-g603acbe1aceb/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-119-g603acbe1aceb/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62c3a1e45f79a9=
5c47a39bd2
        new failure (last pass: v5.10.125-cip10-118-gb03e159be974) =

 =20


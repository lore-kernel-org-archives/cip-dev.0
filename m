Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8043AC3A5A7
	for <webhook@archiver.kernel.org>; Thu,  8 Dec 2022 15:50:47 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.17670.1670514638210775753
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 08 Dec 2022 07:50:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=1qodMGQQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id a9so1871297pld.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 08 Dec 2022 07:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GYW+yphTY8YqhSpUlhQlkSMBPmcZ8En0VhY9/ZXT/lo=;
        b=1qodMGQQSgWG1VMN3Fxuf9N8wizW2MUJsKR+XyPCLVD7LbLnJKgbPWn0ok9QX2hSlD
         7j+F5VT7p+fl3yiIgLA2ZeLBh2DR399QX5SfG+Rubo77wKPmzd33EueVqeIFiUYZl0MI
         xUTpCJ5XZD490Sf3zbgpDji6LdPmUQDocCZJLsIQrt5pPNOS49DSFsSclc8yn5t5w0n/
         /dDVa1vJru8/AU50Dvz2fLPHuHCzLC+DzqpfzOc3nV5qNvdw1tIwsjQ97zIqIodB/z2y
         fZ7C5Pn1z8JSJ1agOg7TDyUrBEiKwQQf4IwgK8nJijnW/MOHOE9Hl5Yh7I7rIfJHatuX
         0Tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYW+yphTY8YqhSpUlhQlkSMBPmcZ8En0VhY9/ZXT/lo=;
        b=KKQfSX+q0HvN0+7Jb/fh8IR596Y3CAykW3zsHSp5Id2BRRpyt2xnKS7xE7DDyxl2uG
         toldV0WRBD9SNZCH4/hx1DzDTrmvTxVMk94zEphk6xOm/CmdQnuTHArBs48UF8bzhJBJ
         EFn7TtP1qwr+ifgf5vWR7rFQ6T4mCjT4XjJ4NJliguttAS7KtY9/LZgmqoee0yy4Y1e3
         2HDk+X/plnmVhQ+9DYEGzu2nc4zRwEJAFGBOhw2ClaR+cRb2pA42QBM+SHZUTKEVG/wq
         GqI7/fjJJZzQpAp6HbTWXufc5GabSbeD7fL/fpmdCphXdEszltYoGVpkOHye5zClkoIi
         92DQ==
X-Gm-Message-State: ANoB5pn1W6AElcLI5asT0SAwg4VoBX2yPM5x8OIzkBqnr8izomHEAaDz
	uN/K8jYJduxe92i6xxdO24IA+ByYOTL8Mjn+uzE=
X-Google-Smtp-Source: AA0mqf4EALJn8+VoLhk/FV6bilBAKwO5V5a7wUbzdMqxa+UYKzDcH4pUWRIpPhfxCI0LXmg6RNvOdw==
X-Received: by 2002:a17:90a:af84:b0:218:c8fd:c213 with SMTP id w4-20020a17090aaf8400b00218c8fdc213mr2632631pjq.36.1670514637246;
        Thu, 08 Dec 2022 07:50:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x12-20020a17090abc8c00b002132f3e71c6sm3014597pjr.52.2022.12.08.07.50.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 07:50:36 -0800 (PST)
Message-ID: <639207cc.170a0220.eb28b.6057@mx.google.com>
Date: Thu, 08 Dec 2022 07:50:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.155-cip21-405-g26d566555c3de
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 21 runs,
 1 regressions (v5.10.155-cip21-405-g26d566555c3de)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Dec 2022 15:50:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10167

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 21 runs, 1 regress=
ions (v5.10.155-cip21-405-g26d566555c3de)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.155-cip21-405-g26d566555c3de/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.155-cip21-405-g26d566555c3de
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      26d566555c3de5796328380cfeda5b2372f45010 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63920577c96d30f8202abd0a

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.155-cip21-405-g26d566555c3de/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.155-cip21-405-g26d566555c3de/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221202.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/63920577c96d30f8202abd2c
        failing since 274 days (last pass: v5.10.100-cip2-319-gcbff87047566=
, first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-12-08T15:40:23.544642  /lava-8290484/1/../bin/lava-test-case
    2022-12-08T15:40:23.574600  [   98.258979] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20


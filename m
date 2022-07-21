Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75ECCCA48D
	for <webhook@archiver.kernel.org>; Thu, 21 Jul 2022 10:54:04 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web09.4942.1658400836891819913
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Jul 2022 03:53:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=x/LiLmAg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id z3so1471253plb.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Jul 2022 03:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=n0Gt8pBlwzcUA1PfRtk/zBrs465p1kf7h2QeRrFTe3U=;
        b=x/LiLmAg0FT5YgK+lopUyRm9gOs5OW8z+WMkfRDB/nSAceTydvXHHt9UCqmCi12Xsj
         k+WK6nxCcKYyWVnu0R9dFcU7JfRZMrrOOCMOGKaUqPKUpG4PL/FWCT5ZuekPwQvDtgS6
         WuihOyaBx1zgGuIYTbAtDbCMzoyeEGjghhngHhWPr5eB4ao7cHSJqB1r+WpBWkFJqfZS
         PMOOARoADkwr9d/tkZteLtbtrr1bxqrW6xV1VhjDJCDigMMd5dQXe4DdwIrBjeSwT6Q/
         3oTfG4ega0lapCaE/1MvqmRGUUR3e+w02Ik7/f9ts+FFh4hoiQSKIW3R78rCcrj/n7pE
         4mrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=n0Gt8pBlwzcUA1PfRtk/zBrs465p1kf7h2QeRrFTe3U=;
        b=cYDYj60dRNkPH4XB54h+V5RlKgO9qKHxh+/DbEmaRovtKITjW3ArTZLLAnlxkX5bNZ
         gtrKJRlRzIp+gq9o2Z0SOdXQeIEPnI7/Oe5r1uQv40d7+t7r1iQ2gNk8X9mAcEt+/cy9
         EX2gJoyUkUyPMO0N1nxH0tjkgSAgrpT7luKg4jX5HdbktSfvCLyUVKQeQFtuTUCAio+3
         vl+yn+6x/ObnRUzag3oMx+MfQKu3it+p1nHDO0kC30HvHv615dHThC1J1okV/v7dk0o+
         f4H7ILccV3tJmxA4uW5v74vtTL753FbUFKOeKStWievghaihY6QkgX8JEAVoNeujhvzz
         mBhg==
X-Gm-Message-State: AJIora/ZZS8b0m9hPxExqXUJFVz+8h+jAilHAmSL5EikRIbTcOILvGuB
	bxs2JiiUQgygzrmldE3hvjX0ExsAJbI4PXaZYGA=
X-Google-Smtp-Source: 
 AGRyM1vApz/x1MN6GBpjhpoUaKiNsR0pEQwMOgolEQwbLk98JccWvn78LCTBAxMt/jQJhBZyDpyjeA==
X-Received: by 2002:a17:90b:1c0b:b0:1f0:23df:5406 with SMTP id
 oc11-20020a17090b1c0b00b001f023df5406mr10818094pjb.157.1658400836231;
        Thu, 21 Jul 2022 03:53:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 p4-20020a634204000000b0041239bf9be8sm1251981pga.1.2022.07.21.03.53.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 03:53:55 -0700 (PDT)
Message-ID: <62d93043.1c69fb81.31dc0.1c8b@mx.google.com>
Date: Thu, 21 Jul 2022 03:53:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-12-ge4e007863cc76
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 8 runs,
 1 regressions (v5.10.129-cip12-12-ge4e007863cc76)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Jul 2022 10:54:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8872

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 8 runs, 1 regre=
ssions (v5.10.129-cip12-12-ge4e007863cc76)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.129-cip12-12-ge4e007863cc76/plan/kselftes=
t-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.129-cip12-12-ge4e007863cc76
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e4e007863cc767efd75ca69c0b98e5daab0c20ff =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62d92798852a5a4f06daf090

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220716.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62d92798852a5a=
4f06daf091
        new failure (last pass: v5.10.126-cip11-116-gef362fbbff528) =

 =20


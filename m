Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934F3C43334
	for <webhook@archiver.kernel.org>; Thu, 21 Jul 2022 10:54:04 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web10.4907.1658400836872763228
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Jul 2022 03:53:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=2i3eM86D;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id p8so1425830plq.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Jul 2022 03:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Chv5+zON8cgIbcnM6pXaAR96oX3C4u22XPLHifVdKqg=;
        b=2i3eM86DpaibQ7N7a0Et2a6iTKZwZ3ncJkBKUS4leEgzq7q4ZhlUucSL3pdO2Tr6MD
         08n/KhfI8MtQXnQqVNHImkIAZPYBPgEkQJDLwn1SYPFUSgaPkQimjZhQK/KBmygrfWSj
         8foKkQNSa5qg9/t6YroPkQebaU1e9cndMSk/9q41AIdp0RJzkxq+0n5UmIrRtpXHmCDo
         uK4HUy0BZwXar+3l4zSvEaiq+T9nQ2Zr2ZflOYuYZbLRZaL8FIykB+kZZR4oTVmI39y4
         3BDw/Lsarqs1gJqoaaIUnwstbTrklKkZP6XbfO8TX3zCmxD/YsVsuOnfX5y/XHL/y9ii
         yW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Chv5+zON8cgIbcnM6pXaAR96oX3C4u22XPLHifVdKqg=;
        b=gaSxpjj5wQ8Vx3l37GxLwVD9N0aihRkrhUnGU4r5gfs7fo1Yvc1dzNjRzuhgstVseW
         LIUgt5gPFDqzHquUpYFbiZD5Z7UNDgk13E2sBcNa1So5V/QMInIOKM0iTSmfHxBPeJNl
         7tJ3SEIY9DbD+K+cBTdV02Izkb8IanFq45h2tC1Xplomfmz/LXYHytynEuMBkusJMcIE
         ovHDF9flXis1rXuKSVGg8NceEuivwC5OrV6/3fRlNWV26oShxgI5ebM02rgxtQz5vtfj
         GfAP0vc3I9gaXQFJOm0dPgclhyvotqOODoN5Xev/49SKHZXuGgoVg6HbwGq7jRW6BArO
         gY3A==
X-Gm-Message-State: AJIora+QiYBg8Z9Mkk0NdpGCPohhGo7RdARZdpqKCESjzqgX8NqFDW8g
	qd2EuT6J+absTaRBX/WhwcPQfIoGlerFnsGD04M=
X-Google-Smtp-Source: 
 AGRyM1tJR41p8R5K2+5gaS6+16c9fpFpfNK3fNLw62FAMiOsi9g9W9tmykcSDG50ihnxmbCCkR4GiA==
X-Received: by 2002:a17:90a:7784:b0:1ef:c0fe:968c with SMTP id
 v4-20020a17090a778400b001efc0fe968cmr10531047pjk.26.1658400835644;
        Thu, 21 Jul 2022 03:53:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 68-20020a621647000000b0052ba88f2dd6sm1428359pfw.57.2022.07.21.03.53.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 03:53:55 -0700 (PDT)
Message-ID: <62d93043.1c69fb81.faee1.25ae@mx.google.com>
Date: Thu, 21 Jul 2022 03:53:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-12-ge4e007863cc76
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 8
 runs, 1 regressions (v5.10.129-cip12-12-ge4e007863cc76)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Jul 2022 10:54:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8871

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 8 runs, 1=
 regressions (v5.10.129-cip12-12-ge4e007863cc76)

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
t-filesystems/

  Test:     kselftest-filesystems
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


  Details:     https://kernelci.org/test/plan/id/62d91c7f5467f861fedaf09c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220716.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/62d91c7f=
5467f861fedaf09d
        new failure (last pass: v5.10.126-cip11-116-gef362fbbff528) =

 =20


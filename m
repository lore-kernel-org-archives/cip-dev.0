Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE68C64EC4
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 20:57:56 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web10.184.1677877072427809085
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 03 Mar 2023 12:57:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=eQsq4rXu;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id oj5so3846990pjb.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 03 Mar 2023 12:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1677877071;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=55LhYvJu+2MjWddRUTgp+60PYbvvViiX7XlzyL8fEHg=;
        b=eQsq4rXupakxr+2FXkoNrtkmRB7qbqJGMYLo4OBQVZKGRTXa71DAjyZSA6/EEdO/ww
         oWW0s8ULxaff+T16vEih4MpxAl5J+pSreFrMgJsPpCJ/069a7TLvbPuurQRviHVEn0fm
         l781UE6LdW/pdlKqWuDWrVbGR95JS1DhZTUOuOL8gT73Fjb4r1NiH+geVvvslcjOAXH0
         XU5ibRAQ5AMgzQZ9XpjQd0f7aujyC1QHKJ6/oci4OAcaDjlqnEqE2S+KqhihZCPaolvQ
         LOKmccs92kHlWKTkkw8s70iUY4HCufRyIq100lTTs2RFx2xvdhU6At4CPimwNQSmHFT7
         OEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677877071;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55LhYvJu+2MjWddRUTgp+60PYbvvViiX7XlzyL8fEHg=;
        b=cGklsiF9wgWy4LBXXbtkDHy/q/Ky16c4fe0hJVFTulmipghMNFSx8iofCakcHrSP1X
         g8Q2AMe+1qwYMYHz18UFve+4C1H4WWXZ253fN9XrINTdT37sUDMlBq6ZPMSdvGZEstrZ
         pSTdIPlkFgFy5BhLf0x73NcgkO5udlOICvk5Tv43MCdPuvlD2u+390rydNO1hZoe5th0
         vX59ObQF0jPwRIUguVo4gMwlCq/GnnOnIQzXEdSW/7xf2m+sZ8hR+WHIcxQs7JggsEzA
         wS+WvQu1/INQZDJcXVnsyVp5R4IdChR1SJaRUvXzledvmXgQC7Uqdln0iYFaqNCYlY9U
         E1iQ==
X-Gm-Message-State: AO0yUKUnEI+NGX5MrY8nmXBdsg7IsAvx9Q4Vr3WFHjZ0rCtc84UezI3P
	cZi6AJx8mjrlwmIaeRu5/LNdx2d8Zs/yEhfIuPWBPd3V
X-Google-Smtp-Source: AK7set+eaIy6jbcZ2xyyWYPSTYS0K+YeRXN5+Hb9AwUIXPstx28Z4plU6V0JJJBfYBo8CCrI6e3WZg==
X-Received: by 2002:a17:902:ec8f:b0:19a:aaac:f4d1 with SMTP id x15-20020a170902ec8f00b0019aaaacf4d1mr2399074plg.13.1677877071435;
        Fri, 03 Mar 2023 12:57:51 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i8-20020a170902c94800b0019ab151eb90sm1907490pla.139.2023.03.03.12.57.50
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 12:57:51 -0800 (PST)
Message-ID: <64025f4f.170a0220.d2503.4532@mx.google.com>
Date: Fri, 03 Mar 2023 12:57:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.168-cip27-109-g23841ec76bec
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 8 runs,
 1 regressions (v5.10.168-cip27-109-g23841ec76bec)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 20:57:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10925

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 8 runs, 1 regress=
ions (v5.10.168-cip27-109-g23841ec76bec)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.168-cip27-109-g23841ec76bec/plan/kselftes=
t-lib/

  Test:     kselftest-lib
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.168-cip27-109-g23841ec76bec
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      23841ec76bec7ddf00658918b23753dc2ca930ce =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64025e64b3c19915748c86b1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-broonie/kselftest-lib-meson-gxl-s905x-libretech-c=
c.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-broonie/kselftest-lib-meson-gxl-s905x-libretech-c=
c.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230224.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/64025e64b3c19915=
748c86b2
        new failure (last pass: v5.10.168-cip27-86-g19cf8cd2dd993) =

 =20


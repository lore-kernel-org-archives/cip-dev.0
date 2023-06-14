Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA861EB64D9
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 12:57:25 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.10958.1686747441043274867
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 14 Jun 2023 05:57:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=jXyMJX8h;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6666d5f9803so289613b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 14 Jun 2023 05:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686747439; x=1689339439;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x2jWzNaByi0feIAD59vf9wzMDLHXjrKrRrBO1cZjB9M=;
        b=jXyMJX8hDrkSKq8KYbaf4BYEas+IEgfA+jcPIyp+y0ddKpHRIzPA/eSbPgJgFmYgUO
         ehy4YabVLoxEZqfa7WLv9ecw7jx0y6lFcE7vMJdsL29XZGRUTxW1+gcP/bwTeCqSt2Vi
         8EzKnUntFEONnJr20jaPA16BPIGw2Hg2gFQQDq6Qe6gk0VzuoUC5UIiCodnumNXBY40k
         vF40kbSmY4nG/bWUb1bVW4833VNjPn0Xv6zs8ho+amCg2wAoSme1Tj9r7Us5GV4JHl6d
         WZW5Mrfjlb4jFy3kxwIDG88MMKT99H2pETu/4LpehkQnCTWS58dPToIUaZ1WR3GH2qP3
         cgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686747439; x=1689339439;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2jWzNaByi0feIAD59vf9wzMDLHXjrKrRrBO1cZjB9M=;
        b=CUNG9VrmrzO+91ySF9lhX9gG+8Ti1Yh5x9VR8sBuWbhUq/B3cZFMDRuxn0KkXljNmH
         ICXcfo5ZY9KMvnbBVhsrHSA62S0J/A+AULykLv2U5Cb0/aLqNo1/RBCCJK73/BxZjdwW
         b+YGglVjylDMvENQt94RMH6NO22h1V80mGuOGPDn6SnB0s6+tqHaylpX5BTdlAPdH9RW
         sFbXBYo+bswhff2XpCBvQL51jzkcO/UgU4aVSEAxauRi1tAaQuKDa6vYsF5aRNBWDiPT
         ppPp/coioB8yfBpStHCMWfplciFGNam7u13b6DiaoR9lgoh3W6RGZGcvHtZs+SFWyYfT
         U80Q==
X-Gm-Message-State: AC+VfDy6E4eM8+NF25x88IrWoUcC+paAmdn+Zt0afQCzxOVmsZyqBpns
	aKfhlfJbqB/vWyujcwaWTogXwgDV5ixatb+T54SUMg==
X-Google-Smtp-Source: ACHHUZ5rlNJQJMgsrNf872PhPfYypzb0tDAvlAWL5RGf5LkxBOnsurk3Fc2i9k3Uc22oGRYLfkgu5Q==
X-Received: by 2002:a05:6a20:4424:b0:11a:ce33:563a with SMTP id ce36-20020a056a20442400b0011ace33563amr2124737pzb.15.1686747439376;
        Wed, 14 Jun 2023 05:57:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l19-20020a62be13000000b0066145d63b1asm10358873pff.138.2023.06.14.05.57.18
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 05:57:18 -0700 (PDT)
Message-ID: <6489b92e.620a0220.515a0.46b6@mx.google.com>
Date: Wed, 14 Jun 2023 05:57:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-191-gf4efde512959
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 9 runs,
 1 regressions (v5.10.182-cip35-191-gf4efde512959)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 12:57:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12018

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 9 runs, 1 regress=
ions (v5.10.182-cip35-191-gf4efde512959)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.182-cip35-191-gf4efde512959/plan/kselftes=
t-lib/

  Test:     kselftest-lib
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.182-cip35-191-gf4efde512959
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f4efde5129594b413888498ce6f27da48a03771e =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b863772c781ae3306133

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/kselftest-lib-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/kselftest-lib-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230609.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/6489b863772c781a=
e3306134
        failing since 0 day (last pass: v5.10.180-cip34-236-g6d219c607dc68,=
 first fail: v5.10.182-cip35-8-gc3d08808cfa7) =

 =20


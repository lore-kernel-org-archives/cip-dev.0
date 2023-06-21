Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D441EB64DC
	for <webhook@archiver.kernel.org>; Wed, 21 Jun 2023 20:03:39 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web10.100.1687377811917704375
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 21 Jun 2023 13:03:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=k1GhV26u;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1b50d7b4aaaso29063075ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 21 Jun 2023 13:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687377811; x=1689969811;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9NVyHUAozXM2+Obj4v/wQhQoFRZHZwX48uYDAQedab0=;
        b=k1GhV26ut32Ih5UovYlElJpbBnGDSxJg6P3zcjGwCg4PDvNq/xAm768GXGq53F3/cx
         qjWkVbl17PzQaV65PIMfETdULXO5aOtdsl9tvFJplqu3fNzdMRe1orYoJnGYBu5E70yR
         UmqF/N7z7ezFFyBuYlZOkxwYO9L0fP0lofX5LHFNNHahFIHKClf4F6AFcuLVSRG80N6h
         WnSpsN5Q+R1GrqeGHd0HPUnIOg2gDWTYw54IFuEEq00xLIvvUxxm984pMBEFGkuiJaea
         7KntHzX2S2RbfItNVM4g3GCQHXJV7craWVTmloElK2LBBRI4mGz2r2wboXWWWdvyPJws
         1zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687377811; x=1689969811;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9NVyHUAozXM2+Obj4v/wQhQoFRZHZwX48uYDAQedab0=;
        b=A7vvIqLz5hr430quzrYsYzSZt62NF6KB7pDktkCYZTukAxlKDgBFyAHH+SIqxjVTc8
         kJRVu/lQxyiD5q3yDAhqWKzTCYNN6aAdgijpFq758kVho++aIgRUInU0iUCNytiS/hcw
         l0MDjrGAxitEhYzKjUkC3rrARoX02j8BKBu4KPZvFJ3X9cY5+Kac3OLvI5y1YuyG9lEL
         P3+vTPnfuUkrPAU3n3NIYgGsEbxVpXOPPT4QJTjAEBtYsVq/g6wHvdMatc+lJipdhkZj
         aVlAmRLtixuR9QwsQnFJGW9u3VHUjOIyJzFIdIoHfJPxpjb/53ShLUrYBs27iyo/sQtA
         gmnw==
X-Gm-Message-State: AC+VfDymNdCQZwpvaLxnWFmSiLtrHlBM1Pv3ZIDsxdHmI3ZC7hdtdd0V
	8hSs8EefilqLESD3NXNk6uCNoD3mjB/LKwAvX213bA==
X-Google-Smtp-Source: ACHHUZ6J1gVYllS4CJYYpts2CZD0TNcfanziTwBMIqAPtPF/0JSGMqpkhz0qOZ1dAKWwycMHhlIYmg==
X-Received: by 2002:a17:903:244e:b0:1b6:695f:1dbf with SMTP id l14-20020a170903244e00b001b6695f1dbfmr7834840pls.61.1687377810716;
        Wed, 21 Jun 2023 13:03:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id kg14-20020a170903060e00b001b6a27dff99sm992328plb.159.2023.06.21.13.03.26
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:03:27 -0700 (PDT)
Message-ID: <6493578f.170a0220.50131.2652@mx.google.com>
Date: Wed, 21 Jun 2023 13:03:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-289-g3c0549540706
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 7 runs,
 1 regressions (v5.10.182-cip35-289-g3c0549540706)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Jun 2023 20:03:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12101

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 7 runs, 1 reg=
ressions (v5.10.182-cip35-289-g3c0549540706)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.182-cip35-289-g3c0549540706/plan/kselftes=
t-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.182-cip35-289-g3c0549540706
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3c0549540706be602c1cc58f7ebdcae39509baa7 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/649346cc61f3d3e0923061ac

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/kselftest-seccomp-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/kselftest-seccomp-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230609.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/649346cc61f3=
d3e0923061ad
        new failure (last pass: v5.10.182-cip35-191-gf4efde512959) =

 =20


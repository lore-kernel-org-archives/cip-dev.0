Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4288FC48BE4
	for <webhook@archiver.kernel.org>; Thu, 11 Aug 2022 15:40:40 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.8035.1660232437651126884
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 11 Aug 2022 08:40:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=48y49+Np;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id g13so10302360plo.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 11 Aug 2022 08:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=mtEqbptaKzOAXsuDSaj0IuabiD/q05askBETCj5Nkgk=;
        b=48y49+NpJPMvpdkE4GzdtKLsSkln+Upg5Qb0m2UEFgT8E80bT3lN5TehrGEoV59Dh2
         ZOGA/zgR9159D5H/dSc25khhYrTXLzj3qmCxwbk84gPQFa7ansTxLQyum07uS6spOg/Q
         YCdnASixALkwPkluusVGXgVjo9FzRyg0OUSEkUuahoBhgz4CEjHwP3XNzU30Gds2Pu2z
         nd0arh9nJK2YbG5EtA4NylY5WuVi4dDrTkF9knhUHkjmWOw1m01UsROfdmH+p4+HQxr3
         0EuPKx81+MHhiPVN81RObobfNBnZCcbKgY6EmA+vhQjQXPK3iTgAMbG1ntj4r/SlJgO9
         PdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=mtEqbptaKzOAXsuDSaj0IuabiD/q05askBETCj5Nkgk=;
        b=yzmBCT+Nu8l+0F5sQWcvZe6lPunY3kYvk+awQghaeXjBqQ/nCVVTyvCPI3Y+LgS/M6
         DQ5C4D1ql5LJXsw0/zpK5cG6/zUy+LE3bc+ijeLahNiGqOl/rGVi+hREpUHrPgJ7wPWv
         vO8M4/JtLC33gSN9efi2mTnyiC1e5cYQ+mVprQvgfP6dG5cyd2Yebw4V7+K4DZrOpZqC
         wZpzQHzdPrRFFSQqmQaTorxYHt+oBZaaJkJEWatl9VP7RHLTZJCoPA+TY2zgsp8Id5di
         h9K6t5ZuXWovU1xmk19Zww+cFxbGMzoY6yWRzW+2DcX9W8qCLrWB2wx5pLkvBe/TdSle
         b8/Q==
X-Gm-Message-State: ACgBeo2Dvdr0lnAtXqcgqAWik0FuFe3ZpR9lZN7kLw8iqILR+JjqOeu0
	w1aZuxJxWlsP1WwjgwqBEpDR/XErPJ9OgXFvcrM=
X-Google-Smtp-Source: 
 AA6agR6RQcUFD+sYEouf4OidTjIA3/S10ez4mbdmhCg5QTgkRQVhdC8rOIE2zVVlWJqgttvNaNBG+w==
X-Received: by 2002:a17:90a:fd12:b0:1f3:1e89:18e1 with SMTP id
 cv18-20020a17090afd1200b001f31e8918e1mr9249018pjb.109.1660232436934;
        Thu, 11 Aug 2022 08:40:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 s16-20020a632150000000b0041d003f8f16sm11477208pgm.87.2022.08.11.08.40.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 08:40:36 -0700 (PDT)
Message-ID: <62f522f4.630a0220.a3ac.26d4@mx.google.com>
Date: Thu, 11 Aug 2022 08:40:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-493-ge129308279043
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 10 runs,
 1 regressions (v5.10.131-cip13-493-ge129308279043)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Aug 2022 15:40:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9163

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 10 runs, 1 regres=
sions (v5.10.131-cip13-493-ge129308279043)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.131-cip13-493-ge129308279043/plan/kselfte=
st-lib/

  Test:     kselftest-lib
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.131-cip13-493-ge129308279043
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e12930827904334316a5d7407de3f9a7126f9892 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62f51a4b7842200d84daf0ad

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-493-ge129308279043/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/kselftest-lib-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-493-ge129308279043/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/kselftest-lib-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220805.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/62f51a4b7842200d=
84daf0ae
        new failure (last pass: v5.10.131-cip13-431-g420b8f43ddc46) =

 =20


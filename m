Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B491C6FA92
	for <webhook@archiver.kernel.org>; Fri, 23 Sep 2022 19:11:49 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web12.713.1663960302219249298
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Sep 2022 12:11:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=TzysMh7P;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.180,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f180.google.com with SMTP id f193so1142231pgc.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Sep 2022 12:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=az2RaH/ChxUDeuWxKONStBZbkFGoxqMWMY83CKLdTQ0=;
        b=TzysMh7PupH3feRz8usZNpMS5bHEjdwg+BRQonYbB4H7c/Eag0WP9Y54BEcG6Re+KU
         1v92jTbzoLFqMN18fSxCN5VdaFlKl6KELLM9QM0gjt36tB5HYbr/tEDDCYJ9CCjoGWuh
         wveE6nfDRd0wrqGlBP1vgvmiDim52XUkzKdlETzea60zr6zJXRT20JX2s4OXQlvdsULE
         O5dTPxTNusKGfUPC5N8AS/+OPf9mPo3/WJmBq+Y3aTXLfSc7gzXDvX5lYU1aWUGDrPsj
         X+6Gd0jx8f1vB2X+/VA3MlznOsjSV0HqVSP2/mhdcrCS3Kjpq0mZG7zwaMhwZ3RvtSbM
         bCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=az2RaH/ChxUDeuWxKONStBZbkFGoxqMWMY83CKLdTQ0=;
        b=TbFVZrTYi1M84q5K6uuFPiZ0QhwjN4UgiIbYHGc4HQEYyKv8mouyc4ivHuPmgf2sgO
         /OPvC6zLLhNov3PKxbVne77RnCeWqOnpGYboZSJGN8+L+C+eDHKxv0ALhy2j38nxHhzV
         2+p+QDfHk6FyKYJJ1u8E5CxjIGvM/dhbwZ5bjJE4DaSTpR/Ve9WDU6NsiY9pmGmD3+Ca
         uq5Q/yTUVCFvPmTmvsMctHfPUEtK8GOSCpXsijG6dWbOzC0rffX0npbn4GRnCgy68shQ
         gtJtpH3UbkOpbRZoXUhLSgBvVZ//lwthryeUQK+/TKUyzJGdjJPYWJdAVnUQ1dVc9Sa8
         5t+A==
X-Gm-Message-State: ACrzQf0ja/cc0eZ2eDfnL/ME3YSRqK1aUCkX/U2xjazozytYo4wQK5L3
	EgpwYrb1z9qmDBQ7j5Hv1a2ePVss5Opdjl4+ZOM=
X-Google-Smtp-Source: 
 AMsMyM7wB/ir3dVp+QtRPGwnEW13tSiM3ZzHUDrruCHMUUcOwBR5P4jkrGcl2Gym98lnfI+VZg+y2g==
X-Received: by 2002:a63:4626:0:b0:43b:383d:d1e with SMTP id
 t38-20020a634626000000b0043b383d0d1emr8983689pga.619.1663960301345;
        Fri, 23 Sep 2022 12:11:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 w6-20020a627b06000000b0053e57b0a233sm6657129pfc.164.2022.09.23.12.11.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 12:11:40 -0700 (PDT)
Message-ID: <632e04ec.620a0220.4c469.dbc1@mx.google.com>
Date: Fri, 23 Sep 2022 12:11:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.140-cip16-261-g8fa62effa305f
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 10 runs,
 1 regressions (v5.10.140-cip16-261-g8fa62effa305f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Sep 2022 19:11:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9540

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 10 runs, 1 regres=
sions (v5.10.140-cip16-261-g8fa62effa305f)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.140-cip16-261-g8fa62effa305f/plan/kselfte=
st-lib/

  Test:     kselftest-lib
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.140-cip16-261-g8fa62effa305f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      8fa62effa305f81a2f52692a14ee690927819830 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/632df82b9ede6c11d635567e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/arm64/defconfig+kselftest/g=
cc-10/lab-baylibre/kselftest-lib-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/arm64/defconfig+kselftest/g=
cc-10/lab-baylibre/kselftest-lib-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/632df82b9ede6c11=
d635567f
        new failure (last pass: v5.10.138-cip15-90-gd4130d0ee3c7) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D95C32793
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 06:38:42 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web11.9843.1674023916698958476
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 17 Jan 2023 22:38:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=keK5WOCG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id s13-20020a17090a6e4d00b0022900843652so1347141pjm.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 17 Jan 2023 22:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DZiiYqiX5bGmzF45E7JmM22M1tX4y5LI5FuVh5dbIxc=;
        b=keK5WOCGF+QWoYz9xXhyA1KqDBenJY2Nunto+ElU4wOID+q2sIjXGELTsZF+nbmfmR
         FfPfKU6E62CBcu48ezJ/h9FoA/hhscHhW+8saFQzAne6n1WRy4BqiDifMi8UgcwGiVe6
         LSZoHl8nBattCTz9Npy03zio792RoDmltmotlHwivf6BiurVrUk4WXMC1MUzbPhKQVrT
         ouyuWWMOH3QnFWHniiYc70HJ2ajGa0boT9b9kxGouywEooXZ38P/eDSBu10t8SEqZodP
         6F8cIioGFWLuhvhSB8Im2ZdDwUTUzTsWooJ1KLJxPPB+RIWLkkL1kuIapukrYDmKpoKF
         rMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZiiYqiX5bGmzF45E7JmM22M1tX4y5LI5FuVh5dbIxc=;
        b=lFUrqqgpjqSSeu3NPOQJNUnGUuoyU7zLtUIPhFW+cIWIRWii4ZdQDGdT6JS9nl7+di
         s6R1ODOpmMdaZ/Z+B3hCQqzCluIARd6VqavE2GrZdnHzSSy84TIKwrMqslEcvXK1GZe/
         i18+hWGBH3w+2Cant9IU34D+Dpq7Yvt+LwxrgQQZmZGUKLhFTL9e+ChEVTL3GEGOOYbc
         c6VRHxu9FmyXUzqVNK6HVHNxe5Py47sx/9xu4Rq8I1uDO3dsRhwZHcRUttXhbnm72MWb
         Ji3XjtxlZOVdlKOMUSgIXRJKn5pJAE6uYEcoNM1ylVle0GgHDYkd1JwBWfYKovJ3BVMO
         CkSA==
X-Gm-Message-State: AFqh2kqMdtSnHkVGubgCJbos59c1KaScFs9JUjgAlnbx0DV669U/pPID
	+tkwN1nviGHQlwhF6oZQh0q1/O7MSjtTVTgxQeC7LA==
X-Google-Smtp-Source: AMrXdXvqQzoEdsTS3icvmcWHnAptBbvo7qvre05hOdWf6NASz2ja1ZiNHrrhSBgK4hCxAB8PIisJcQ==
X-Received: by 2002:a17:902:8d83:b0:193:39bd:df97 with SMTP id v3-20020a1709028d8300b0019339bddf97mr6190673plo.14.1674023915714;
        Tue, 17 Jan 2023 22:38:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k3-20020a170902ba8300b0018968d1c6f3sm5949210pls.59.2023.01.17.22.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 22:38:35 -0800 (PST)
Message-ID: <63c793eb.170a0220.5d14b.9f11@mx.google.com>
Date: Tue, 17 Jan 2023 22:38:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Kernel: v4.4-st20-821-g39bdf0444b23
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc kselftest-futex: 3 runs,
 1 regressions (v4.4-st20-821-g39bdf0444b23)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 06:38:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10383

cip/linux-4.4.y-st-rc kselftest-futex: 3 runs, 1 regressions (v4.4-st20-821=
-g39bdf0444b23)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-821-g39bdf0444b23/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-821-g39bdf0444b23
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      39bdf0444b238ce8b92fda121bd1462a27f07a66 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c788d84f7c6d90d7915edd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-821-g39bdf0444b23/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/kselftest-futex-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-821-g39bdf0444b23/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/kselftest-futex-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230114.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/63c788d84f7c6d=
90d7915ede
        new failure (last pass: v4.4-st20-799-g1229c813bcd9) =

 =20


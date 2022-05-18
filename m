X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web10.1731.1652906476100145018
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 May 2022 13:41:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=GM6fC7eq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id l14so3183326pjk.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 May 2022 13:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=iq2J5MzAYsMTvJXmCrZuLbMflYX7EUlz9jvJj7se27E=;
        b=GM6fC7eqwlFknf8iQFvref/j9euoDjAsuGQ4OIQzSAX4uoTGnrxxrfGWLVmNQZOSme
         54MM9mvnbMz2zBtmbKOh4XCRAFx4Cxpq14z1YMtLbvhiXMvcjEsQLLVt7to6BDR1+obN
         qcbhpaavMhp01I0I+Fof//9OjxNw2cBEjlCzrkCNi3u8RJd3akhQulLF1RACrC9gc/i0
         rOoAcTT7fwnQgonhtTfMy+oL1JgbpKSEHR74/6XfIaj1Hio74ZpXgh2RRT/hAkoYyMhm
         62Qz+ZxoHvSk1TOFUwzuQg/fGsokeLyCfR7OjTPUdJe46k0vGpysPETQm6DTbXruQ+v8
         Hnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=iq2J5MzAYsMTvJXmCrZuLbMflYX7EUlz9jvJj7se27E=;
        b=YTmTaNcDsa2GC3usYXjP2wd7KtwJZBUn4gKw6KKiNplTOB3ebLy4T7F4H1SrVNT26D
         pJ05vI2RdA7i5XERiLIMbplw/bHSd2jHs/8ezz/GzZfEQ21g45Kow/4Rv33UMYewtr9q
         5woovF6CqjRxeMDZqurzR8kR5WtL9H8EJmaRqr8HTr3WzRjcSZghewTLz70bhP5vWbUc
         iKeIJ3gitT7dEkbP1xJNFKi1mipF/t54sxeJnbTWNr8pwUyp2HSaIpKeCsDM3W/jsz4c
         YIMlbqVWdCf2qrl8M/SI4dQincnMcc5mpMYZv3Ec/bneER3nPHApD5DGPy059KcHo5xN
         JwtQ==
X-Gm-Message-State: AOAM532BCiZuftxCdrZ2o582L+Zz05Viht52mZ2Rznk/KgQNJHoYB69N
	G/bRpDj7s8a46BWXriutIBjkc1Kiu65aZcUtABU=
X-Google-Smtp-Source: ABdhPJwyQNVr9kGt8+bfFhvmzOzOLLGbv1SMwGGD1ASkElTOM00SJMMHR/mi9StEo0wFMck5NHRF0w==
X-Received: by 2002:a17:902:9a83:b0:15e:f718:4ced with SMTP id w3-20020a1709029a8300b0015ef7184cedmr1138401plp.69.1652906475494;
        Wed, 18 May 2022 13:41:15 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090a990800b001df6216e89dsm4107959pjp.28.2022.05.18.13.41.14
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:41:14 -0700 (PDT)
Message-ID: <628559ea.1c69fb81.2aa39.a7f6@mx.google.com>
Date: Wed, 18 May 2022 13:41:14 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.115-cip7-81-gd05f72e501084
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 6 runs, 1 regressions (v5.10.115-cip7-81-gd05f72e501084) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 6 runs, 1 reg=
ressions (v5.10.115-cip7-81-gd05f72e501084)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.115-cip7-81-gd05f72e501084/plan/kselftest=
-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.115-cip7-81-gd05f72e501084
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d05f72e501084803c8658a71668fc1aadb075165 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62854b382864d7a96ea39bf1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.115-cip7-81-gd05f72e501084/arm64/defconfig+kselftest/gcc=
-10/lab-baylibre/kselftest-seccomp-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.115-cip7-81-gd05f72e501084/arm64/defconfig+kselftest/gcc=
-10/lab-baylibre/kselftest-seccomp-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220513.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/62854b382864=
d7a96ea39bf2
        new failure (last pass: v5.10.112-cip6-289-g2969e096d186) =

 =20


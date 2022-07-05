Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88174C433EF
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 04:24:45 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web12.80552.1656995079999167110
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 21:24:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=BM6SXcnx;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id n12so10502932pfq.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 21:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=iOfOZLAe7bqQWeoL61/niuQ9SolakvIFz5IgWSb00lk=;
        b=BM6SXcnxqgqxhv/10DQ8EAGYmyr+9fKYEqTQQy07b/3zumIhuJEyQWlGllrUIecX6P
         Rz8OhobHbm836IJIVDCp8LwznWXPPerko87Mi6eLjWMnTwFK7PeVSFEh/gE5fD72xfi6
         70uzURv+qRpAtPairU1lF2pf0fzx3z8oL7jV78MpzjUvWV58wRkRjeM4cobAZ9MhoFhH
         BYn8+L44om/bO4PPpneamzQr+JeoaWdSCntG/vwftwA9XK0d3fzWihyDYua3CHhg+DYG
         zTA03z2JdIRHfSAZfB+jCPvLfUwYzMBAatVAGrWZYZQCr5TS5fmecmnQZrOce3vHrqTq
         lC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=iOfOZLAe7bqQWeoL61/niuQ9SolakvIFz5IgWSb00lk=;
        b=z2MDGW5UzihPO56W4RzBlg039MHQEfS4PRM/gYDiWuIB/rRHUPOzATwClPv9jxw9vi
         yq+Jy0UBNsZYaa5QCml12s/6Wu2XCTpdujMsac1FY2+UonkE/LM3SWkKjAMl5O+6p9th
         tMLz/9yW1g4pNTx0+IjCIFQ1UdOKm7eWnpqO+e9bNfKJDVZcQ1a7H/sWXCscox7I4KCQ
         KaIAif4uklwDWKr/35GnMbmMJxoogWUnZbxtTwRXcXXJZk0mcVaGuBsecCm9Vg7gPZnk
         bRvAJpekXgaBf6Ef/FVQWRCIqJ2OllqbldSGBkN462TE+7lGMmwF8vmtSu92wQtrQnwc
         YUCw==
X-Gm-Message-State: AJIora+CP4fqrFW2guQD6XtsPUgXqKNJXjXrP8ohd+Dc4S3Obc+Vxrd7
	rVTdY7aHmMcOqLXeF9mamyqk4codCi86lZoA
X-Google-Smtp-Source: 
 AGRyM1sBIPRGre8xJeXkuHdbOEJz2jVO1a0eLRorKU738GrLfstxsHdis60Kr6NjL2e3MAb/k2KbRw==
X-Received: by 2002:a05:6a00:1995:b0:525:bca8:b066 with SMTP id
 d21-20020a056a00199500b00525bca8b066mr38736985pfl.16.1656995079215;
        Mon, 04 Jul 2022 21:24:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 q13-20020a170902a3cd00b0016bd8fb1fafsm4656351plb.307.2022.07.04.21.24.38
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 21:24:38 -0700 (PDT)
Message-ID: <62c3bd06.1c69fb81.89480.6c64@mx.google.com>
Date: Mon, 04 Jul 2022 21:24:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.125-cip10-120-gf70f522cb972
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 8 runs,
 2 regressions (v5.10.125-cip10-120-gf70f522cb972)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 04:24:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8669

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 8 runs, 2 regress=
ions (v5.10.125-cip10-120-gf70f522cb972)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip      | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.125-cip10-120-gf70f522cb972/plan/kselftes=
t-lib/

  Test:     kselftest-lib
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.125-cip10-120-gf70f522cb972
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f70f522cb9729264739dd5a10a8e68d86241981f =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62c3aafa641d6b956ba39bdf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-120-gf70f522cb972/arm64/defconfig+kselftest/gc=
c-10/lab-baylibre/kselftest-lib-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-120-gf70f522cb972/arm64/defconfig+kselftest/gc=
c-10/lab-baylibre/kselftest-lib-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/62c3aafa641d6b95=
6ba39be0
        new failure (last pass: v5.10.125-cip10-119-g603acbe1aceb) =

 =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip      | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62c3ab075f34d80945a39bd8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-120-gf70f522cb972/arm64/defconfig+kselftest/gc=
c-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-120-gf70f522cb972/arm64/defconfig+kselftest/gc=
c-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/62c3ab075f34d809=
45a39bd9
        new failure (last pass: v5.10.125-cip10-119-g603acbe1aceb) =

 =20


Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F90CCA480
	for <webhook@archiver.kernel.org>; Tue, 28 Jun 2022 00:39:31 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web10.49764.1656376763473478797
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 27 Jun 2022 17:39:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=pOgnPhRB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id
 c6-20020a17090abf0600b001eee794a478so3491745pjs.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 27 Jun 2022 17:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Dev1YBQp1eJr4xMJWMThRx9KVz3HYmkL7rQSc37WQxE=;
        b=pOgnPhRB5y54mdKbCo5YuvH1lOffUFc22xuW6NKDjQKQCmhlBcvCUmUp4h5A30F0Dn
         zPiIHrzHOBJh8cxtKt3QgzCKBjUjYmF92e9obYut8kZ5ltkMfZ0ZooF9h9ir4OLma3CE
         2DVRk4aTYJCghRB/4wePY1pGshkD/Gi8H3cDT7lxLV0lorZyIdhovWccX/vzuYQemK0x
         Imv+uhdViwuJcMpaqAr+rvCYm/ZyNLBCHa5S8jKWNrrB8Ex+ngHHoae7PBHnK/Be2/ty
         BOoqPPqNUcqHW7hzHWsFv3wwT4VGppd9FWTR3KXvqQR0tiR40GwluvHsYLiy/Pk2xR2i
         bi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Dev1YBQp1eJr4xMJWMThRx9KVz3HYmkL7rQSc37WQxE=;
        b=X22hiAOgjdEtGjqxJCZhW8Lv+oSrqR02kfrhn4cDi4mwVdvK5lwfubzhMsfLyRMlZG
         hABWeY+2awwV17A+95TgySKI/ND4yhjpMeksc1pgIprhABkCz6CRMKw0B1GmqDW8ys/z
         CpgQe6ElYqBFts9hCf0T9WPB+G9wOZJU5typBAOwQSNSuyi4r43ePobyFPKIwqmrjsDG
         tO/gfCNTdcxxv/9YrZOhH+GDAxaF5FDJGah9F/E0UrvLc+uDkm7tcEDfXc43iQZ9XsoS
         IlZLAckmNvBM9zoKfngNWHJsK5HipQ9XZdnGMnqCo4H/Gi5qBaxYFgbR6IrdSJZ4NcEB
         r39g==
X-Gm-Message-State: AJIora/4wyYnkziJjWlTx9eEoF/TIM433PcBTr6FcrtyZuYHWgVPG2xe
	14OiiAPK6Iig3QP21MSsd3FIua/O3IAc/ZtH
X-Google-Smtp-Source: 
 AGRyM1v2X4P0fXd7fvVCWKQkmUmK58xkDL6QouoKAhAOBndU4ESN0WHJHzD8+1O4VNOHHaj2MtMmhA==
X-Received: by 2002:a17:902:b287:b0:16b:85cd:ef6b with SMTP id
 u7-20020a170902b28700b0016b85cdef6bmr922687plr.8.1656376762915;
        Mon, 27 Jun 2022 17:39:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 w16-20020aa79a10000000b0051ba90d55acsm7989228pfj.207.2022.06.27.17.39.21
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 17:39:21 -0700 (PDT)
Message-ID: <62ba4db9.1c69fb81.43f99.ad5a@mx.google.com>
Date: Mon, 27 Jun 2022 17:39:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.121-cip9-287-ge9094c8446fc
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 6 runs,
 1 regressions (v5.10.121-cip9-287-ge9094c8446fc)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jun 2022 00:39:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8612

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 6 runs, 1 reg=
ressions (v5.10.121-cip9-287-ge9094c8446fc)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.121-cip9-287-ge9094c8446fc/plan/kselftest=
-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.121-cip9-287-ge9094c8446fc
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e9094c8446fcef728d675699ced39be2dbbfb8f7 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62ba415a70e39709d6a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-287-ge9094c8446fc/arm64/defconfig+kselftest/gcc=
-10/lab-baylibre/kselftest-seccomp-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-287-ge9094c8446fc/arm64/defconfig+kselftest/gcc=
-10/lab-baylibre/kselftest-seccomp-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/62ba415a70e3=
9709d6a39bce
        new failure (last pass: v5.10.118-465-g0af29783a3c9) =

 =20


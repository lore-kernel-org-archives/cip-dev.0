Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16202C433EF
	for <webhook@archiver.kernel.org>; Thu,  7 Jul 2022 07:07:43 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web11.2775.1657177661168468307
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Jul 2022 00:07:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=sC4KEVEC;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f175.google.com with SMTP id i190so4269790pge.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Jul 2022 00:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=BZ8cq0UBNeDdIcVXsi5hIoySFw+wiF7a2V5m4O0fym4=;
        b=sC4KEVECfkD/gz+6YPziffiHc9uSt0TsSeSdMM1e2CoviU6BCvo4kja5pRPD+3Z8O4
         cyDYSK7AFu6UOH5RK2XsHbqVPUd/WbehkGy+WNTJjYq6nYhxEsmHAGd4H97iV1CL0xqR
         qNw/4zTR8AqgYCceNvRO9f9E/f5CvA4yG2bg8X4QbVt2T9IDw61MnumnVdJgtxrjOCa6
         fq/itYJ1xyUfL9e97koarJSiMGpCNG8grvLTim53fLTke0HxfIYQy9Be/8++Pafui7YO
         iJ/GNwqCgedCFbNOee7SCp3wK3ZuPINgHwPLR6b6A7R9w+buCM54Ds5RCcvUgqFRKArH
         /CgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=BZ8cq0UBNeDdIcVXsi5hIoySFw+wiF7a2V5m4O0fym4=;
        b=xa0heIb9j4L/vZuS4Ltfh5DC+qHJbrI3I6WzJ0CTBJkDE85AToYO9ksiaAGL8AXYZi
         Aks6DCRKVlNG0jHkticazSgpFGdnQWetrr2y2/mODpMNj/NvK+lduuPb704lWrRY1dx9
         aCixGzN9WtGxJ67Hgb/4XTvcB08vJod0BrbVgTCCJav3y7DgYVH7bSK9Xsy2cLK/ldaU
         D+3H9Bh8fQLC1DcAF144VQIDp2rr/joa+boeYpfbF4uqmsG9YF+zJ8x8tKoU4smojm7+
         pcL4qUqQqLCsYtDG7Li8dMpNTDZjfFogGMI06TyboQpr/gXBF0Tj/NZn2mYGn+q4MHnz
         pHzQ==
X-Gm-Message-State: AJIora+kM4k0wx4wallHAEGpMWtm7RkFgeraZ/XkQu0KKJ+9XOpH5G5o
	BBzXFmp5tldY4mjoTDdDWwGG0iSxwMXuOTZt
X-Google-Smtp-Source: 
 AGRyM1tPWrftW7qGn/2XHP2B4oIPYqsRRssFbDXSvxdjdMrR1dV1LWO3TauLjd4yATBGl0nZ75RyNg==
X-Received: by 2002:a17:902:ab0a:b0:16b:ddd0:1ede with SMTP id
 ik10-20020a170902ab0a00b0016bddd01edemr23195117plb.32.1657177660295;
        Thu, 07 Jul 2022 00:07:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 n14-20020a170902e54e00b0016a7d9e6548sm10386493plf.262.2022.07.07.00.07.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 00:07:40 -0700 (PDT)
Message-ID: <62c6863c.1c69fb81.72ea7.eb30@mx.google.com>
Date: Thu, 07 Jul 2022 00:07:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.126-cip11-116-gef362fbbff528
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 12 runs,
 2 regressions (v5.10.126-cip11-116-gef362fbbff528)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Jul 2022 07:07:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8710

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 12 runs, 2 regres=
sions (v5.10.126-cip11-116-gef362fbbff528)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-odroid-n2         | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.126-cip11-116-gef362fbbff528/plan/kselfte=
st-lib/

  Test:     kselftest-lib
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.126-cip11-116-gef362fbbff528
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ef362fbbff528b6dc0695b488cfc8cde20b404e4 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-odroid-n2         | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62c67689f1f12cc0eca39bf8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/arm64/defconfig+kselftest/g=
cc-10/lab-baylibre/kselftest-lib-meson-g12b-odroid-n2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/arm64/defconfig+kselftest/g=
cc-10/lab-baylibre/kselftest-lib-meson-g12b-odroid-n2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/62c67689f1f12cc0=
eca39bf9
        new failure (last pass: v5.10.125-cip10-119-g603acbe1aceb) =

 =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62c67722317bb8a33da39bda

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/arm64/defconfig+kselftest/g=
cc-10/lab-baylibre/kselftest-lib-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-116-gef362fbbff528/arm64/defconfig+kselftest/g=
cc-10/lab-baylibre/kselftest-lib-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/62c67722317bb8a3=
3da39bdb
        new failure (last pass: v5.10.126-cip11-1-gc5218dc69ff1) =

 =20


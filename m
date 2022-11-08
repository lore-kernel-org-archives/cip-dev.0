Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF1CC433FE
	for <webhook@archiver.kernel.org>; Tue,  8 Nov 2022 21:07:34 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.2725.1667941649991436485
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 08 Nov 2022 13:07:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=G0fRQwiR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id j12so15264947plj.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 08 Nov 2022 13:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sn+h9uDdEXdlQT4O0e/U4JsXBdAYf4K/JKS45vW+m70=;
        b=G0fRQwiRn9tMAjlzPQl7JghswcGy3Q7xB07+uu/XprQyQNHSFmosXVTf/53Hnjx0Ev
         gEMw10BMvDSvKyWC77oZVjSXY1P/f6Mfw8oOvDvABRTpZQJfqD11VpBznVcinKML38Jv
         nbx6RmL+1+UvcmE4GbVEug63U+TJVpkGtaQLbq7g3/fTiYspIhmyHaeGIB3BJP4SdNCS
         HdDwcpaIONEUTwkDiltMMNwkmg+7gdKjZ8w8w6UJhtAc/vpSfeXZ95k47guulz+dl6cf
         1Vf6Z0UxeAYqYpkAQ8xHpCHcpQyiZ3b6ABN3SYKWJypbcZKaLTi4TlrATVYW7HB5npft
         zWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sn+h9uDdEXdlQT4O0e/U4JsXBdAYf4K/JKS45vW+m70=;
        b=GpiIkjg7AczNMoH6qhuOPP3bxid7rJAYBljW/ayuYe1ugPZa55YQqK0C7d+dGcAZuZ
         rkye6hUeLKfFKBaW8wy5luoaKAAKgM04nrrrs0ruGB3Sm8TKi0W6OIVLZJVAJVEHagVs
         z0VjxDH3gYw3Zuw1WriqONmOMdWqlQfCqCWmf7waVkgAUZuU7xOnFpWrGXwk6rWlz9sj
         955+TVmRCFpaSm+qutswZuidhDVb8S9mm1d732ggNUXypT3ynRYUbuY+87uJXo2nS93B
         6/ypyhyDYeRbFdaoVyCt01b4RVZlBDXtmtyGZXxZbe/XLyITKXGZgDwll7MLYfEYDiVV
         b10g==
X-Gm-Message-State: ANoB5pkDdj6UvjNh3Mj9StpKF+n7ANtnH57Oog+kLWM8skIsEMT3VST5
	Fw6l80dX6/PJL9C2EZ4NyBlGLYgXOmUBM1XK
X-Google-Smtp-Source: AA0mqf66/IlhHjTgD7jtItsebNHMEUL4LZElhz+c/852cR69alMmITGZFmfSPolJLw9Ns79zZVtA+A==
X-Received: by 2002:a17:902:c3d1:b0:188:758f:f473 with SMTP id j17-20020a170902c3d100b00188758ff473mr18128506plj.113.1667941649195;
        Tue, 08 Nov 2022 13:07:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d16-20020a170902ced000b0017f49b41c12sm7412112plg.173.2022.11.08.13.07.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 13:07:28 -0800 (PST)
Message-ID: <636ac510.170a0220.4ceb4.d075@mx.google.com>
Date: Tue, 08 Nov 2022 13:07:28 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-15-gef247a3cd0ad
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 11 runs,
 2 regressions (v5.10.147-cip18-15-gef247a3cd0ad)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Nov 2022 21:07:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9952

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 11 runs, 2 regression=
s (v5.10.147-cip18-15-gef247a3cd0ad)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip      | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.147-cip18-15-gef247a3cd0ad/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.147-cip18-15-gef247a3cd0ad
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ef247a3cd0adc25a8015590a0e7652ad30c2b2f7 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/636ab8fff5a9fa26c6e7dc31

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-15-gef247a3cd0ad/arm64/defconfig/gcc-10/lab-baylibre/kself=
test-filesystems-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-15-gef247a3cd0ad/arm64/defconfig/gcc-10/lab-baylibre/kself=
test-filesystems-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/636ab8ff=
f5a9fa26c6e7dc32
        failing since 63 days (last pass: v5.10.131-cip13-84-g5fcbe4a63ab4d=
, first fail: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip      | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/636abc66170575ec06e7db6e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-15-gef247a3cd0ad/arm64/defconfig/gcc-10/lab-cip/kselftest-=
filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-15-gef247a3cd0ad/arm64/defconfig/gcc-10/lab-cip/kselftest-=
filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/636abc66=
170575ec06e7db6f
        new failure (last pass: v5.10.147-cip18-12-gcb2b164780be) =

 =20


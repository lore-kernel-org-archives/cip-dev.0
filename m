Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51CFC54E94
	for <webhook@archiver.kernel.org>; Tue, 24 Jan 2023 13:16:59 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.14464.1674566211899026359
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 24 Jan 2023 05:16:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=thHM9dh4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so18492845pjg.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 24 Jan 2023 05:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g5U8YsjafE0Iwg68kSiKrwRbmhrmySjB0rom5QlscAM=;
        b=thHM9dh4cdtrQbqUuJ5HBuwwkHKtTT/pvvdtiuOGjCmFmgAX8oqnCW481H5gpKZyFL
         ttcTA9IVf4Wt2IbJR7feHgGda9/KjfSKJquQwEJHK3Za3Gzu8ujU0Rf7EoMAEGjPYgg+
         xMPpupcsAiAI0e0Yadq+ePbK6DghkNn6eovRTEUaVXENIkH4804LO9OevHAVXMFW9qH+
         PhpCTMWV3xsJBL5H7HhmceWIOUmMUCpi9Wd7LpHl9agnFXhKR5fuleLMqgzzv+7f68Yf
         RSblbz458kU5jIlYCGssGHJJA9RXGRSHkcOUJDLA3HyajpU7DW7iOYJPLp4s+vbSJX81
         XByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g5U8YsjafE0Iwg68kSiKrwRbmhrmySjB0rom5QlscAM=;
        b=Dns1fbau4COzhFr9WFFTlxtospXhBdhPsfQwa3leG4GUI+N/9m20aQ3VM/zI07eW3d
         ESIU1xP6mjhIxUoF89R9pj/u7hc7JHo+hrtGMx4j+xr0O1hTRtzOnF/PsvLK2zcydr59
         3f9iMzoN0UNafbdVXd4GCFqUBcABmtC47RBigN6iUBjirqDS7r175u4DiKhgABylKtvH
         5zq9UGANo42ltUYyIU9HzS7JfZZ/LkvUCd4fi//iQRVYnSmrdM1OrdU06OjZv68BP08z
         EQ6nUJqJq0FQ22ZepQZ8Kjl61I/3syCv1IF62dXZs/2WL0SB+OoTRSxxw5isQGGWtVi2
         rO8A==
X-Gm-Message-State: AFqh2krm5iNAPraw8VAgFoH5zYejNLDE+WYK1wSDr/8+YdHj+LGHOaSo
	y21cE5C9Ex/vwPr1qJe4XvV8aMUN0IsFvNp+dCw=
X-Google-Smtp-Source: AMrXdXv3SufN7djYd9YlnKjkSoFJVlnoMKAVHPtjbCovzPy8jrhJWNPlVOeSwulhPtrkm5WcTWdw8A==
X-Received: by 2002:a17:902:f546:b0:194:d95c:7936 with SMTP id h6-20020a170902f54600b00194d95c7936mr24151009plf.50.1674566210816;
        Tue, 24 Jan 2023 05:16:50 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jl13-20020a170903134d00b0019117164732sm1623306plb.213.2023.01.24.05.16.50
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 05:16:50 -0800 (PST)
Message-ID: <63cfda42.170a0220.38e3e.2c3c@mx.google.com>
Date: Tue, 24 Jan 2023 05:16:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.162-cip24-952-gf408044f5bad
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 66 runs,
 1 regressions (v5.10.162-cip24-952-gf408044f5bad)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Jan 2023 13:16:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10466

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 66 runs, 1 regress=
ions (v5.10.162-cip24-952-gf408044f5bad)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.162-cip24-952-gf408044f5bad/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.162-cip24-952-gf408044f5bad
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f408044f5bad2c96806e41c8eac61744913398d4 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/63cfd14c065d79ec07915ede

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-952-gf408044f5bad/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-nfs-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-952-gf408044f5bad/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-nfs-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63cfd14c065d79ec0=
7915edf
        failing since 87 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f=
, first fail: v5.10.147-cip18-468-g86403a07ae1c) =

 =20


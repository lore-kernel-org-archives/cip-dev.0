Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44275C636D6
	for <webhook@archiver.kernel.org>; Mon,  6 Feb 2023 12:48:14 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web10.52251.1675687691023371359
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 06 Feb 2023 04:48:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=vwu6tc6b;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso13361067pju.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 06 Feb 2023 04:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BnEotDT5ndgm58t/9CUMdQ0GlhYRB69ZZigzhGSy+xs=;
        b=vwu6tc6bCb8AE9vqGgag6k4InEEJ0CNwkwe3gwIkfwlzciyYgZCcOpMUhERZn+kovS
         jaJCMmownyZSW84JyDOXlVmdUp1FXrtMvp08Ggo/dd9YSPtnlbDyiEKdS5spqilDS2FI
         km5Z36eJr/6bAKIa+k8ySSy/YHRwGCmQzqlRb6LBRDb8zvaiZqj7g2Nd2w0smTL78sQK
         Cj0CLO9n7U3wn2FJrRzbB7NRDqNFLNha/diYEFe84lHAMcP89jzBBLTu0v7XJ7E6qS5f
         RMWK0eHPwcCc3zv5gQqo76T0ynxNLWPSWzuy51FKH6U2T700OWEQJj6x7WVrzT+j2sN5
         KKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnEotDT5ndgm58t/9CUMdQ0GlhYRB69ZZigzhGSy+xs=;
        b=JN3Yy2oTvHskl0v6l60Mf8OpNQOxIIqSp8T4HzpOZ1aKLH+icW9gHyBDpkhD0r654u
         L6A0k4bNgA25G0/+Ipb1aQBFOOXwccstgpWFVAwUImLXLYe5Bt1sx4/ZJs3oLNV5NjT4
         ViK7qYXQLSoPYVo7iZ8Pfp4fo0oos38/SxOtXrK4uLjPu1gWPRST+LZishKTG+/h7o4u
         G/4pb4kcCj0Ja6UV6DrAGIOriF16XPnXOLD/t1mSvk9c5+AephY/O+SDiOAR+8dma2Xj
         bSkaF+hmKKenZZI9J/qbLpEFOf/Tkf8/dcSZp3NP3vzJj5exnZec4dBZUbRe6uXYrS0H
         9Aog==
X-Gm-Message-State: AO0yUKWJ0Aak41LVzvGpw7GtZzSXkHqljWh8kSZMB29BpuVJRmt9qbt/
	N8ZaUfY3OynZFC+e7KWQrfzGQzX+s5aomyse
X-Google-Smtp-Source: AK7set/XGXSpHJeeHY+bh+g1grlQ3XkEXUPheoEeiqJ+1EPB6Y1Lh8RmMttmrVwkgIXjZaryEiWgBg==
X-Received: by 2002:a17:902:e804:b0:196:8d48:8760 with SMTP id u4-20020a170902e80400b001968d488760mr24709879plg.31.1675687690177;
        Mon, 06 Feb 2023 04:48:10 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p11-20020a1709026b8b00b0017fe9b038fdsm6795593plk.14.2023.02.06.04.48.09
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 04:48:09 -0800 (PST)
Message-ID: <63e0f709.170a0220.2b199.a850@mx.google.com>
Date: Mon, 06 Feb 2023 04:48:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.165-cip25-154-gb7e05ba4f61a2
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 10 runs,
 1 regressions (v5.10.165-cip25-154-gb7e05ba4f61a2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Feb 2023 12:48:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10604

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 10 runs, 1 regres=
sions (v5.10.165-cip25-154-gb7e05ba4f61a2)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.165-cip25-154-gb7e05ba4f61a2/plan/kselfte=
st-lib/

  Test:     kselftest-lib
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.165-cip25-154-gb7e05ba4f61a2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b7e05ba4f61a238b39854406f0889bab2b4fb757 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63e0eaccab2d203873915ebf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-154-gb7e05ba4f61a2/arm64/defconfig+kselftest/g=
cc-10/lab-baylibre/kselftest-lib-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-154-gb7e05ba4f61a2/arm64/defconfig+kselftest/g=
cc-10/lab-baylibre/kselftest-lib-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63e0eaccab2d2038=
73915ec0
        failing since 12 days (last pass: v5.10.162-cip24-853-g709bb3738fde=
, first fail: v5.10.162-cip24-952-gf408044f5bad) =

 =20


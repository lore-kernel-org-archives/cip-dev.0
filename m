Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EC2C5478C
	for <webhook@archiver.kernel.org>; Fri, 23 Feb 2024 12:06:57 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web11.9071.1708690013193305238
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Feb 2024 04:06:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=gZ6WIVY5;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29a2545a1e7so592588a91.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 23 Feb 2024 04:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708690012; x=1709294812; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6PXBWQjLtytMVio3v0Q+eqZ1wDQMgYATXFdnFSKID1E=;
        b=gZ6WIVY5gWMz26IKloSRBBTs95t5H6WIpEWOpJ0oivhFnZBK1nFcukCUhZg/pONbm9
         dspRhOOUnBM+uigSOyXnSZ7A/ASzqg/K4SZTBggi1Ou/zYgmqqvEafFcfj3UFp+V45gt
         hJsDXdCfp4RLKMrlwtiV6QpoBZbxwx+kF5ae67y1vwCkE7NHBvuNEMJlNmNsSqi7Vp5T
         OF4A2pMEjmpiXCuEAYG7WCCFexWRUVO8JyisaTaSvuzvcGCbc4cpZh6cD8rgGPnkFTQJ
         67LbNAiHrN6g02L5DRAE/O5rWEVAREoa702JRb++YgOoHZnJhDlW1Vv7d3sFZ+BQZum+
         dLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708690012; x=1709294812;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6PXBWQjLtytMVio3v0Q+eqZ1wDQMgYATXFdnFSKID1E=;
        b=QcrYibNh20zZOgQo1+JdaKB8PCvcbJA31rL3NI8DODWGxBQ1MTxxgGKiSKPPAyZbYK
         7nh8dC/D/4mruKhxOWTBOIC98divrWTfmw5EXsSj6+9sc7Gm8CLqCIvcuvHm/8Qrw+YK
         fvhv2LdjZvCtTKhkU1fK4miVvMqyHu41PHgKHL/l16PL3TPWmgu7m5BPkgFNVi+VCfnr
         BMhXC6GmcMycO+msTJDL6qtzcsBpRK6TRpqeDM58tovfX8/NYzMMmJWgBjoT+zTWUpAf
         SHg3eM1gMJ0XfL0OkWpjhQbw4d2JlykPf1hUwf9e4HCBVjyPXCK3JviTYdfQpK4TYpmQ
         NsUg==
X-Gm-Message-State: AOJu0Yx5fFTAeILi5OxY7Y980oUm9dGf3WIODEc37iXxUvkYPUxNgcLp
	cnlquOI7ZnZXsqE8lmyBHHN1KrcH6Z2wnE9CLbmqceeCsB0looCC9Bgrz57Sxo543Nh9Xgk1Dyf
	OoWI=
X-Google-Smtp-Source: AGHT+IEZ2WCosdfze4ZmHu40huVivDaDdP7Ntvb1+Hza6k8HQDTOtw9LN5OCBJUltWVPyKPgB49tCw==
X-Received: by 2002:a17:90b:fd8:b0:29a:6928:441a with SMTP id gd24-20020a17090b0fd800b0029a6928441amr1322606pjb.33.1708690012166;
        Fri, 23 Feb 2024 04:06:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p12-20020a17090a348c00b0029a45b28d43sm1391489pjb.14.2024.02.23.04.06.47
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 04:06:50 -0800 (PST)
Message-ID: <65d88a5a.170a0220.85be5.3d1e@mx.google.com>
Date: Fri, 23 Feb 2024 04:06:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.209-cip44-424-g38943e302f8c8
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 15 runs,
 1 regressions (v5.10.209-cip44-424-g38943e302f8c8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Feb 2024 12:06:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15076

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 15 runs, 1 regressions =
(v5.10.209-cip44-424-g38943e302f8c8)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-424-g38943e302f8c8/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-424-g38943e302f8c8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      38943e302f8c8bda23c2853f688afa5e35cae90d =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65d87c8fab92d44b49637022

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/ltp-ipc-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/ltp-ipc-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65d87c8fab92d44b496370=
23
        failing since 41 days (last pass: v5.10.205-897-gcc9858ae2881, firs=
t fail: v5.10.205-905-gb40421b142370) =

 =20


Return-Path: <SRS0=vVWt=IV=lists.cip-project.org=bounce+64572+6316+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127BBC433DB
	for <cip-dev@archiver.kernel.org>; Tue, 23 Mar 2021 15:29:36 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A5C261984
	for <cip-dev@archiver.kernel.org>; Tue, 23 Mar 2021 15:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5C261984
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6316+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id OGLsYY4521723xc8e2Aa11Zt; Tue, 23 Mar 2021 08:29:35 -0700
X-Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web12.10812.1616513374536082869
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 23 Mar 2021 08:29:34 -0700
X-Received: by mail-pj1-f46.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so12367054pjc.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 23 Mar 2021 08:29:34 -0700 (PDT)
X-Gm-Message-State: v7EIHx9lcJsid6UYXlCyBpkux4520388AA=
X-Google-Smtp-Source: ABdhPJyq1vFFmc2msCE6VgD+m+rC+xd4umAxUcfVGDYUJIj3amyDkWxAJEowL+VaNA9m647AkYMGqA==
X-Received: by 2002:a17:90a:2c4b:: with SMTP id p11mr5266094pjm.75.1616513373876;
        Tue, 23 Mar 2021 08:29:33 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 76sm17327091pfw.156.2021.03.23.08.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 08:29:33 -0700 (PDT)
Message-ID: <605a095d.1c69fb81.86a8d.9843@mx.google.com>
Date: Tue, 23 Mar 2021 08:29:33 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v4.19.182-cip45-40-g0e469137cd784
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
Subject: [cip-dev] cip/linux-4.19.y-cip baseline-nfs: 16 runs, 1 regressions (v4.19.182-cip45-40-g0e469137cd784) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="1RnunxlaPSOPKFk4B3tr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616513375;
 bh=djXt/5J288xJjyjzvlvF1qD8r485gCVFFttskpGjuSo=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=J0hZ0k/bwn/8sKrzWnmwJ8aYvIPKtdKNpfayf6KX7cgj2/Gz8kBZn5XGzbFzEOZz7GX
 +c26dayGDqeFy+ACw+oizU216V+Q6rBW/Khko6lUL4esKPlva9cNrfGSo+qQAxwYnRxv4
 EJoG6+OgEsMD83cl4DxiE0X/SJ8XObwTlwQ=

--1RnunxlaPSOPKFk4B3tr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline-nfs: 16 runs, 1 regressions (v4.19.182-cip45-=
40-g0e469137cd784)

Regressions Summary
-------------------

platform       | arch  | lab          | compiler | defconfig | regressions
---------------+-------+--------------+----------+-----------+------------
meson-gxm-q200 | arm64 | lab-baylibre | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.182-cip45-40-g0e469137cd784/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.182-cip45-40-g0e469137cd784
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0e469137cd784e952b10670400ce2b9143741fd2 =



Test Regressions
---------------- =



platform       | arch  | lab          | compiler | defconfig | regressions
---------------+-------+--------------+----------+-----------+------------
meson-gxm-q200 | arm64 | lab-baylibre | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6059f8073e1c9ba0edaddced

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.182=
-cip45-40-g0e469137cd784/arm64/defconfig/gcc-8/lab-baylibre/baseline-nfs-me=
son-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.182=
-cip45-40-g0e469137cd784/arm64/defconfig/gcc-8/lab-baylibre/baseline-nfs-me=
son-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0315.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6059f8073e1c9ba0e=
daddcee
        failing since 1 day (last pass: v4.19.169-cip42, first fail: v4.19.=
182-cip45) =

 =20

--1RnunxlaPSOPKFk4B3tr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6316): https://lists.cip-project.org/g/cip-dev/message=
/6316
Mute This Topic: https://lists.cip-project.org/mt/81553656/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--1RnunxlaPSOPKFk4B3tr--

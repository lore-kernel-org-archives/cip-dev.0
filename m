Return-Path: <SRS0=j1X2=IU=lists.cip-project.org=bounce+64572+6309+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5F5C433C1
	for <cip-dev@archiver.kernel.org>; Mon, 22 Mar 2021 07:54:59 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CC8061937
	for <cip-dev@archiver.kernel.org>; Mon, 22 Mar 2021 07:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC8061937
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6309+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 9ZhKYY4521723xQuHCDo5IKd; Mon, 22 Mar 2021 00:54:57 -0700
X-Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web08.9622.1616399697415741198
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 Mar 2021 00:54:57 -0700
X-Received: by mail-pl1-f171.google.com with SMTP id v8so6113020plz.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 22 Mar 2021 00:54:57 -0700 (PDT)
X-Gm-Message-State: 51L2C3fTcsAloqin2CTrXCTTx4520388AA=
X-Google-Smtp-Source: ABdhPJxJjvimzsQsrYH6isPQEXazGqU0UXAMrCgtMV4G3+zF3CGaskeWGckzfkMXOl8AID+aRABPKQ==
X-Received: by 2002:a17:90b:3550:: with SMTP id lt16mr11851778pjb.47.1616399696749;
        Mon, 22 Mar 2021 00:54:56 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n16sm12624785pff.119.2021.03.22.00.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 00:54:56 -0700 (PDT)
Message-ID: <60584d50.1c69fb81.5f3e.f2c1@mx.google.com>
Date: Mon, 22 Mar 2021 00:54:56 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v4.19.182-cip45
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
Subject: [cip-dev] cip/linux-4.19.y-cip baseline-nfs: 15 runs, 2 regressions (v4.19.182-cip45) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="MTAXlSHVhptZp1hkOlTG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616399697;
 bh=DT7ApoR9GHRFcdiUmJQJaJTg7W8/A7xrjR1smd32WtE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=ILrofCgZErurgdOU7r1qDr5oS0g0B6O1YMYMEn/p6QYLm3VgY6gkS/whb1DP/mo5qz7
 r0Z96BoTSdbnAP/y+tlnTeUtF5AL+mCwwXhKlENIUn+c6fgzUFI/HLfvlMTVVlbD2VlMr
 xUA8gB7HoXg4xXqUa0uF7B3NkHOgrzmyVc8=

--MTAXlSHVhptZp1hkOlTG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline-nfs: 15 runs, 2 regressions (v4.19.182-cip45)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre  | gcc-8    | defconfig | 1   =
       =

rk3399-gru-kevin      | arm64 | lab-collabora | gcc-8    | defconfig | 1   =
       =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.182-cip45/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.182-cip45
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      6b96b21074b8f7ad4b8fc885d42282228e2a6967 =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre  | gcc-8    | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/605842a6fb02bcaf8caddcc6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.182=
-cip45/arm64/defconfig/gcc-8/lab-baylibre/baseline-nfs-meson-gxm-khadas-vim=
2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.182=
-cip45/arm64/defconfig/gcc-8/lab-baylibre/baseline-nfs-meson-gxm-khadas-vim=
2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0315.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/605842a6fb02bcaf8=
caddcc7
        new failure (last pass: v4.19.177-cip44) =

 =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
rk3399-gru-kevin      | arm64 | lab-collabora | gcc-8    | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/60584535f3f084c651addcbb

  Results:     82 PASS, 6 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.182=
-cip45/arm64/defconfig/gcc-8/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.182=
-cip45/arm64/defconfig/gcc-8/lab-collabora/baseline-nfs-rk3399-gru-kevin.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0315.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/60584535f3f084c65=
1addcbc
        new failure (last pass: v4.19.177-cip44) =

 =20

--MTAXlSHVhptZp1hkOlTG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6309): https://lists.cip-project.org/g/cip-dev/message=
/6309
Mute This Topic: https://lists.cip-project.org/mt/81519107/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--MTAXlSHVhptZp1hkOlTG--

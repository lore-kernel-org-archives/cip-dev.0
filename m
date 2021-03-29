Return-Path: <SRS0=5nXG=I3=lists.cip-project.org=bounce+64572+6335+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FCEC433C1
	for <cip-dev@archiver.kernel.org>; Mon, 29 Mar 2021 04:59:14 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1BA461929
	for <cip-dev@archiver.kernel.org>; Mon, 29 Mar 2021 04:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BA461929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6335+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id cVgWYY4521723xmMgRUOVApV; Sun, 28 Mar 2021 21:59:13 -0700
X-Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.17095.1616993952951618249
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 28 Mar 2021 21:59:13 -0700
X-Received: by mail-pl1-f179.google.com with SMTP id h20so3828876plr.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 28 Mar 2021 21:59:12 -0700 (PDT)
X-Gm-Message-State: IEaC5VjiA665ytFmpJmSlZtkx4520388AA=
X-Google-Smtp-Source: ABdhPJz8RfvK/Zkw6uBdeax6KmT5sNDWAFrGzFpf79xUxiE9QXVlA2obHu0KVBqf3Nr1NIdxCQRA3g==
X-Received: by 2002:a17:902:dac9:b029:e4:b52f:1d38 with SMTP id q9-20020a170902dac9b02900e4b52f1d38mr27358115plx.15.1616993952376;
        Sun, 28 Mar 2021 21:59:12 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id fr23sm14362392pjb.22.2021.03.28.21.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 21:59:12 -0700 (PDT)
Message-ID: <60615ea0.1c69fb81.b7f93.4077@mx.google.com>
Date: Sun, 28 Mar 2021 21:59:12 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.183-cip46
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
Subject: [cip-dev] cip/linux-4.19.y-cip baseline-nfs: 8 runs, 1 regressions (v4.19.183-cip46) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="q9WujhSp9eDyfOKBeRH1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616993953;
 bh=E4cSkncvrrH/0NorooPCswC1cxpNd4R7fPGoomfl4o8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=UzuHn8ufem68SUy2uu8XEKgiXssTPs0kwjwxiGKIY5YQufmOHevqbZ0S2ruj1kTQtvT
 /TPROy64CKnlTtQOb4wYY/BX2PFdefnyeDVS4NSQhCSgpzwomTKF3Yk3izM32A6N9gF5s
 +16MvTD5gpb/0LZ1fCDQZZhimPt2+ZwjEWA=

--q9WujhSp9eDyfOKBeRH1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline-nfs: 8 runs, 1 regressions (v4.19.183-cip46)

Regressions Summary
-------------------

platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre | gcc-8    | defconfig | 1    =
      =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.183-cip46/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.183-cip46
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      9701ebc154a80d8752b3fa4a81a19b467168203a =



Test Regressions
---------------- =



platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre | gcc-8    | defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/6061530f2b6b1f9fd7af02ae

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.183=
-cip46/arm64/defconfig/gcc-8/lab-baylibre/baseline-nfs-meson-gxm-khadas-vim=
2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.183=
-cip46/arm64/defconfig/gcc-8/lab-baylibre/baseline-nfs-meson-gxm-khadas-vim=
2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0315.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6061530f2b6b1f9fd=
7af02af
        failing since 6 days (last pass: v4.19.177-cip44, first fail: v4.19=
.182-cip45) =

 =20

--q9WujhSp9eDyfOKBeRH1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6335): https://lists.cip-project.org/g/cip-dev/message=
/6335
Mute This Topic: https://lists.cip-project.org/mt/81689543/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--q9WujhSp9eDyfOKBeRH1--

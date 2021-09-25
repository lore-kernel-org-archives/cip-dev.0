Return-Path: <SRS0=TO7o=OP=lists.cip-project.org=bounce+64572+6747+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC312C433F5
	for <cip-dev@archiver.kernel.org>; Sat, 25 Sep 2021 16:24:40 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C1B8610CB
	for <cip-dev@archiver.kernel.org>; Sat, 25 Sep 2021 16:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4C1B8610CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0OHoYY4521723xOChe1YP8si; Sat, 25 Sep 2021 09:24:40 -0700
X-Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web12.8746.1632587079518849426
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 25 Sep 2021 09:24:39 -0700
X-Received: by mail-pl1-f177.google.com with SMTP id n2so8634234plk.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 25 Sep 2021 09:24:39 -0700 (PDT)
X-Gm-Message-State: GEHlJP2BNie4udquf6H8KaFmx4520388AA=
X-Google-Smtp-Source: ABdhPJyPW0rH7+OTWB8eGwkjGFkU4vsiGA5HtYZ+zjc/DiCpo+gea1YI6FFDTn/yBjgMFy2jB635Rw==
X-Received: by 2002:a17:902:8f97:b0:13d:f842:34c4 with SMTP id z23-20020a1709028f9700b0013df84234c4mr5859421plo.54.1632587078896;
        Sat, 25 Sep 2021 09:24:38 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id nm23sm11351468pjb.26.2021.09.25.09.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 09:24:38 -0700 (PDT)
Message-ID: <614f4d46.1c69fb81.6c609.30a0@mx.google.com>
Date: Sat, 25 Sep 2021 09:24:38 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v4.19.207-cip58
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
Subject: [cip-dev] cip/linux-4.19.y-cip baseline-nfs: 13 runs, 1 regressions (v4.19.207-cip58) #kernelci
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
Content-Type: multipart/mixed; boundary="875MNm60Qd4IyvDWCkS8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1632587080;
 bh=zwm9daFyaYAauMMzlS7Ps1wgQS4aZIjCWi0ucOLTShs=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=juaHlMlA2/5IfOEFHaZs8TlYzBMxJxswcls1HD6WIrrzK2WOJRgzeK+ANVIqxdNLnil
 txwuFBSiraq6ObXfbfw18UEne3vvjGafQ3DH+gTePvFM6/tShBb/LDsmfcocBOylV+Qy+
 NbsXK5hZmGaUGXJ48ya8uStPFvOdEqsf7UU=

--875MNm60Qd4IyvDWCkS8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline-nfs: 13 runs, 1 regressions (v4.19.207-cip58)

Regressions Summary
-------------------

platform   | arch | lab           | compiler | defconfig              | reg=
ressions
-----------+------+---------------+----------+------------------------+----=
--------
odroid-xu3 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig+ima | 1  =
        =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.207-cip58/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.207-cip58
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c3737f5637179738a7e899359a490e349ee75d82 =



Test Regressions
---------------- =



platform   | arch | lab           | compiler | defconfig              | reg=
ressions
-----------+------+---------------+----------+------------------------+----=
--------
odroid-xu3 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig+ima | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/614f3df8ccab046ad899a2da

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+ima
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.207=
-cip58/arm/multi_v7_defconfig+ima/gcc-8/lab-collabora/baseline-nfs-odroid-x=
u3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.207=
-cip58/arm/multi_v7_defconfig+ima/gcc-8/lab-collabora/baseline-nfs-odroid-x=
u3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0913.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/614f3df8ccab046ad=
899a2db
        failing since 37 days (last pass: v4.19.198-cip54, first fail: v4.1=
9.204-cip55) =

 =20

--875MNm60Qd4IyvDWCkS8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6747): https://lists.cip-project.org/g/cip-dev/message/=
6747
Mute This Topic: https://lists.cip-project.org/mt/85863417/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelci
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--875MNm60Qd4IyvDWCkS8--

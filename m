Return-Path: <SRS0=BmP8=JW=lists.cip-project.org=bounce+64572+6392+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B52DC433B4
	for <cip-dev@archiver.kernel.org>; Sun, 25 Apr 2021 22:01:25 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8E9560234
	for <cip-dev@archiver.kernel.org>; Sun, 25 Apr 2021 22:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E9560234
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6392+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id qK1HYY4521723xN5lJ3f9vNB; Sun, 25 Apr 2021 15:01:24 -0700
X-Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.web09.7367.1619388083882229594
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 25 Apr 2021 15:01:23 -0700
X-Received: by mail-pg1-f181.google.com with SMTP id z16so38815709pga.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 25 Apr 2021 15:01:23 -0700 (PDT)
X-Gm-Message-State: LeqKPGksLLSQtHyc45HyJo3Yx4520388AA=
X-Google-Smtp-Source: ABdhPJxGpaduqx1oHTa8j8azVPtL9TQPQucdYWUJb7WOrspaol8KLT/PQQOpcFHmyILYKFO4exflgg==
X-Received: by 2002:a63:e918:: with SMTP id i24mr1948512pgh.118.1619388083258;
        Sun, 25 Apr 2021 15:01:23 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b1sm10502435pgf.84.2021.04.25.15.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 15:01:23 -0700 (PDT)
Message-ID: <6085e6b3.1c69fb81.9e33e.ee70@mx.google.com>
Date: Sun, 25 Apr 2021 15:01:23 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v4.19.188-cip48
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
Subject: [cip-dev] cip/linux-4.19.y-cip igt-kms-rockchip: 2 runs, 1 regressions (v4.19.188-cip48) #kernelci
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
Content-Type: multipart/mixed; boundary="zvq3TdtRoiPdh6qGYVR6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1619388084;
 bh=ixeDBb4OP5trCJATChYn8+TrGPKsmjflG0SzuI3ccXk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=t327Ibws1RRpj3eVLJdPhKrm2XfO64zd8zjatOE5woE+CKqcvhaqOpGZdiIjF7MTECj
 0mggOuazPFTg8yvg4qOYAg4RNYuoaT0HLLJFDgA7tpVawc52zomz66dujY562WdgDkmrc
 KVIBBsLmDxah4XTruVZmzFOqgpcQbjPIR/8=

--zvq3TdtRoiPdh6qGYVR6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip igt-kms-rockchip: 2 runs, 1 regressions (v4.19.188-cip=
48)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.188-cip48/plan/igt-kms-rockchip/

  Test:     igt-kms-rockchip
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.188-cip48
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      46c40361addfc061df66c8296e9dc3e717281464

  Test suite revisions:
    drm
      URL:  git://anongit.freedesktop.org/mesa/drm
      SHA:  c7dc0465cf55f613f1caa085aa762db06cb14974
    igt-gpu-tools
      URL:  https://gitlab.freedesktop.org/drm/igt-gpu-tools.git
      SHA:  907705f0c3f6b5ae6358a4822434dd6d7a070cff =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/6085d6d9732328d1229b7797

  Results:     85 PASS, 3 FAIL, 146 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.188=
-cip48/arm64/defconfig/gcc-8/lab-collabora/igt-kms-rockchip-rk3399-gru-kevi=
n.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.188=
-cip48/arm64/defconfig/gcc-8/lab-collabora/igt-kms-rockchip-rk3399-gru-kevi=
n.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster-igt/=
20210419.0/arm64/rootfs.cpio.gz =



  * igt-kms-rockchip.kms_vblank.pipe-B-ts-continuation-dpms-suspend: https:=
//kernelci.org/test/case/id/6085d6d9732328d1229b7820
        new failure (last pass: v4.19.186-cip47-1-g4c2cb7ba796b)

    2021-04-25 20:52:59.721000+00:00  <14>[  156.287615] [IGT] kms_vblank: =
executing
    2021-04-25 20:52:59.736000+00:00  IGT-Version: 1.25-g907705f (aarch64) =
(Linux: 4.19.188-cip48 aarc<14>[  156.292987] [IGT] kms_vblank: starting su=
btest pipe-B-ts-continuation-dpms-suspend
    2021-04-25 20:52:59.736000+00:00  h64)
    2021-04-25 20:52:59.742000+00:00  Starting subtest: pipe-B-ts-continuat=
ion-dpms-suspend
    2021-04-25 20:53:00.464000+00:00  <6>[  157.027299] rockchip-dp ff97000=
0.edp: Link Training Clock Recovery success
    2021-04-25 20:53:00.478000+00:00  <6>[  157.042550] rockchip-dp ff97000=
0.edp: Link Training success!
    2021-04-25 20:53:00.622000+00:00  Beginning pipe-B-ts-continuation-dpms=
-suspend on pipe B, connector eDP-1
    2021-04-25 20:53:01.222000+00:00  [cmd] rtcwake: assuming RTC uses UTC =
...
    2021-04-25 20:53:01.228000+00:00  rtcwake: wakeup from \"mem\" using /d=
ev/rtc0 at Sun Apr 25 20:30:14 2021
    2021-04-25 20:53:01.242000+00:00  <6>[  157.809408] PM: suspend entry (=
deep) =

    ... (122 line(s) more)  =

 =20

--zvq3TdtRoiPdh6qGYVR6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6392): https://lists.cip-project.org/g/cip-dev/message=
/6392
Mute This Topic: https://lists.cip-project.org/mt/82365001/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--zvq3TdtRoiPdh6qGYVR6--
